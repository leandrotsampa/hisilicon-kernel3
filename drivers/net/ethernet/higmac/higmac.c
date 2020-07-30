#include <linux/kernel.h>
#include <linux/errno.h>
#include <linux/unistd.h>
#include <linux/interrupt.h>
#include <linux/delay.h>
#include <linux/netdevice.h>
#include <linux/etherdevice.h>
#include <linux/skbuff.h>
#include <linux/spinlock.h>
#include <linux/mm.h>
#include <linux/mii.h>
#include <linux/ethtool.h>
#include <linux/phy.h>
#include <linux/dma-mapping.h>
#include <linux/workqueue.h>
#include <linux/device.h>
#include <linux/atomic.h>
#include <linux/platform_device.h>
#include <linux/capability.h>
#include <linux/time.h>
#include <asm/setup.h>
#include <linux/proc_fs.h>
#include <linux/module.h>

#include <linux/of_net.h>
#include <linux/of_mdio.h>
#include <linux/clk.h>
#include <linux/reset.h>

#include "util.h"
#include "higmac.h"
#include "ctrl.h"
#include "mdio.h"
#include "forward.h"
#include "autoeee/autoeee.h"
#include "sockioctl.h"

/* set irq affinity to cpu1 when multi-processor */
#define HIGMAC_IRQ_AFFINITY_CPU		2

#define DEFAULT_MSG_ENABLE (NETIF_MSG_DRV|NETIF_MSG_PROBE|NETIF_MSG_LINK)
static int debug;
module_param(debug, int, 0);
MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");

#define MAX_GMAC_INSTANCE       2
struct higmac_adapter higmac_fwd_adapter[MAX_GMAC_INSTANCE];

static int g_speed_portmode_table[speed_mode_butt][interface_mode_butt] = {
	{port_mode_10_mii, port_mode_10_rmii, port_mode_10_rgmii},
	{port_mode_100_mii, port_mode_100_rmii, port_mode_100_rgmii},
	{port_mode_butt, port_mode_butt, port_mode_1000_rgmii}
};

int calculate_port_mode(enum speed_mode speed, phy_interface_t phy_intf,
			int is_duplex_half)
{
	enum if_mode if_mode;
	int ret = port_mode_butt;

	switch (phy_intf) {
	case PHY_INTERFACE_MODE_MII:
		if_mode = interface_mode_mii;
		break;
	case PHY_INTERFACE_MODE_RMII:
		if_mode = interface_mode_rmii;
		break;
	case PHY_INTERFACE_MODE_RGMII:
		if_mode = interface_mode_rgmii;
		break;
	default:
		if_mode = interface_mode_butt;
		break;
	}

	if (speed < speed_mode_butt && if_mode < interface_mode_butt) {
		ret = g_speed_portmode_table[speed][if_mode];
		if (is_duplex_half)
			ret &= ~(1 << 4);	/* see mac_if ctrl reg */

		return ret;
	}

	pr_err("Invalid speed(%d) & interface(%d) mode.\n", speed, if_mode);
	pr_err("Please assign which mode our eth will correctly work at.\n");
	pr_err("It may support 10/100M MII, 10/100M RMII, 10M/100M/1G RGMII\n");
	BUG();

	/* can't reach here */
	return -1;
}

/* set gmac's multicast list, here we setup gmac's mc filter */
static void higmac_gmac_multicast_list(struct net_device *dev)
{
	struct higmac_netdev_local *ld = netdev_priv(dev);
	struct netdev_hw_addr *ha;
	unsigned int d = 0;

	/* when set gmac in promisc mode
	 * a. dev in IFF_PROMISC mode
	 */
	if ((dev->flags & IFF_PROMISC)) {
		/* promisc mode.received all pkgs. */
		higmac_writel_bits(ld, 0, REC_FILT_CONTROL, BIT_BC_DROP_EN);
		higmac_writel_bits(ld, 0, REC_FILT_CONTROL, BIT_MC_MATCH_EN);
		higmac_writel_bits(ld, 0, REC_FILT_CONTROL, BIT_UC_MATCH_EN);
	} else {
		/* drop uc pkgs with field 'DA' not match our's */
		higmac_writel_bits(ld, 1, REC_FILT_CONTROL, BIT_UC_MATCH_EN);

		if (dev->flags & IFF_BROADCAST)	/* no broadcast */
			higmac_writel_bits(ld, 0, REC_FILT_CONTROL, BIT_BC_DROP_EN);
		else
			higmac_writel_bits(ld, 1, REC_FILT_CONTROL, BIT_BC_DROP_EN);

		if (netdev_mc_empty(dev) || !(dev->flags & IFF_MULTICAST)) {
			/* haven't join any mc group */
			higmac_writel(0, PORT_MC_ADDR_LOW);
			higmac_writel_bits(ld, 0, PORT_MC_ADDR_HIGH,
					BIT_PORT_MC_ADDR_HIGH);
			higmac_writel_bits(ld, 1, REC_FILT_CONTROL, BIT_MC_MATCH_EN);
		} else if (1 == netdev_mc_count(dev) && (dev->flags & IFF_MULTICAST)) {
			netdev_for_each_mc_addr(ha, dev) {
				d = (ha->addr[0] << 8) | (ha->addr[1]);
				higmac_writel_bits(ld, d, PORT_MC_ADDR_HIGH,
						BIT_PORT_MC_ADDR_HIGH);

				d = (ha->addr[2] << 24) | (ha->addr[3] << 16)
				    | (ha->addr[4] << 8) | (ha->addr[5]);
				higmac_writel(d, PORT_MC_ADDR_LOW);
			}
			higmac_writel_bits(ld, 1, REC_FILT_CONTROL, BIT_MC_MATCH_EN);
		} else
			higmac_writel_bits(ld, 0, REC_FILT_CONTROL, BIT_MC_MATCH_EN);
	}
}


/* the func stop the hw desc and relaim the software skb resource
 * before reusing the gmac, you'd better reset the gmac
 */
void higmac_reclaim_rx_tx_resource(struct higmac_netdev_local *ld)
{
	unsigned long rxflags, txflags;
	int rd_offset, wr_offset;
	int i;

	higmac_irq_disable(ld);
	higmac_hw_desc_disable(ld);
	writel(STOP_RX_TX, ld->gmac_iobase + STOP_CMD);

	spin_lock_irqsave(&ld->rxlock, rxflags);
	/* rx_bq: logic write pointer */
	wr_offset = readl(ld->gmac_iobase + RX_BQ_WR_ADDR);
	/* rx_bq: software read pointer */
	rd_offset = readl(ld->gmac_iobase + RX_BQ_RD_ADDR);
	/* FIXME: prevent to reclaim skb in rx bottom half */
	writel(wr_offset, ld->gmac_iobase + RX_BQ_RD_ADDR);

	/* rx_fq: software write pointer */
	wr_offset = readl(ld->gmac_iobase + RX_FQ_WR_ADDR);
	/* rx_fq: logic read pointer */
	rd_offset = readl(ld->gmac_iobase + RX_FQ_RD_ADDR);
	if (!rd_offset)
		rd_offset = (HIGMAC_HWQ_RX_FQ_DEPTH - 1) << DESC_BYTE_SHIFT;
	else
		rd_offset -= DESC_SIZE;
	/* FIXME: stop to feed hw desc */
	writel(rd_offset, ld->gmac_iobase + RX_FQ_WR_ADDR);

	for (i = 0; i < ld->rx_fq.count; i++) {
		if (!ld->rx_fq.skb[i])
			ld->rx_fq.skb[i] = SKB_MAGIC;
	}
	spin_unlock_irqrestore(&ld->rxlock, rxflags);

	/* no need to wait pkts in tx_rq finish to free all skb,
	 * because higmac_xmit_release_skb is in the tx_lock,
	 */
	spin_lock_irqsave(&ld->txlock, txflags);
	/* tx_rq: logic write */
	wr_offset = readl(ld->gmac_iobase + TX_RQ_WR_ADDR);
	/* tx_rq: software read */
	rd_offset = readl(ld->gmac_iobase + TX_RQ_RD_ADDR);
	/* FIXME: stop to reclaim tx skb */
	writel(wr_offset, ld->gmac_iobase + TX_RQ_RD_ADDR);

	/* tx_bq: logic read */
	rd_offset = readl(ld->gmac_iobase + TX_BQ_RD_ADDR);
	if (!rd_offset)
		rd_offset = (HIGMAC_HWQ_TX_BQ_DEPTH - 1) << DESC_BYTE_SHIFT;
	else
		rd_offset -= DESC_SIZE;
	/* FIXME: stop software tx skb */
	writel(rd_offset, ld->gmac_iobase + TX_BQ_WR_ADDR);

	for (i = 0; i < ld->tx_bq.count; i++) {
		if (!ld->tx_bq.skb[i])
			ld->tx_bq.skb[i] = SKB_MAGIC;
	}
	spin_unlock_irqrestore(&ld->txlock, txflags);
}

static void higmac_monitor_func(unsigned long arg);
void pmt_reg_restore(struct higmac_netdev_local *ld);
static void higmac_set_multicast_list(struct net_device *dev);

/* reset and re-config gmac */
void higmac_restart(struct higmac_netdev_local *ld)
{
	unsigned long rxflags, txflags;
	struct sk_buff *skb = NULL;
	int i;

	/* restart hw engine now */
	higmac_mac_core_reset(ld);

	spin_lock_irqsave(&ld->rxlock, rxflags);
	spin_lock_irqsave(&ld->txlock, txflags);

	for (i = 0; i < ld->rx_fq.count; i++) {
		skb = ld->rx_fq.skb[i];
		if (skb) {
			ld->rx_skb[i] = NULL;
			ld->rx_fq.skb[i] = NULL;
			if (skb == SKB_MAGIC)
				continue;
			dev_kfree_skb_any(skb);
			/* TODO: need to unmap the skb here
			 * but there is no way to get the dma_addr here,
			 * and unmap(TO_DEVICE) ops do nothing in fact,
			 * so we ignore to call
			 * dma_unmap_single(dev, dma_addr, skb->len,
			 *      DMA_TO_DEVICE)
			 */
		}
	}

	for (i = 0; i < ld->tx_bq.count; i++) {
		skb = ld->tx_bq.skb[i];
		if (skb) {
			ld->tx_skb[i] = NULL;
			ld->tx_bq.skb[i] = NULL;
			if (skb == SKB_MAGIC)
				continue;
			dev_kfree_skb_any(skb);
			/* TODO: unmap the skb */
		}
	}

	pmt_reg_restore(ld);
	higmac_hw_mac_core_init(ld);
	higmac_hw_set_mac_addr(ld, ld->netdev->dev_addr);
	higmac_hw_set_desc_queue_addr(ld);

	/* we don't set macif here, it will be set in adjust_link */
	if (ld->netdev->flags & IFF_UP) {
		/* when resume, only do the following operations
		 * when dev is up before suspend.
		 */
		higmac_feed_hw(ld);
		higmac_set_multicast_list(ld->netdev);

		higmac_hw_desc_enable(ld);
		higmac_port_enable(ld);
		higmac_irq_enable(ld);
	}
	spin_unlock_irqrestore(&ld->txlock, txflags);
	spin_unlock_irqrestore(&ld->rxlock, rxflags);
}

#if defined(CONFIG_ARCH_S40)
#define HIGMAC_LINK_CHANGE_PROTECT
#endif

#ifdef HIGMAC_LINK_CHANGE_PROTECT
#define HIGMAC_MS_TO_NS (1000000ULL)
#define HIGMAC_FLUSH_WAIT_TIME (100*HIGMAC_MS_TO_NS)
/* protect code */
static void higmac_linkup_flush(struct higmac_netdev_local *ld)
{
	int tx_bq_wr_offset, tx_bq_rd_offset;
	unsigned long long time_limit, time_now;

	time_now = sched_clock();
	time_limit = time_now + HIGMAC_FLUSH_WAIT_TIME;

	do {
		tx_bq_wr_offset = readl(ld->gmac_iobase + TX_BQ_WR_ADDR);
		tx_bq_rd_offset = readl(ld->gmac_iobase + TX_BQ_RD_ADDR);

		time_now = sched_clock();
		if (unlikely((long long)time_now -
					(long long)time_limit >= 0))
			break;
	} while (tx_bq_rd_offset != tx_bq_wr_offset);

	mdelay(1);
}
#endif

static void higmac_adjust_link(struct net_device *dev)
{
	struct higmac_netdev_local *ld = netdev_priv(dev);
	int stat = 0, port_mode;
	enum speed_mode speed_mode = speed_mode_100M;

	stat |= ld->phy->link ? HIGMAC_LINKED : 0;
	stat |= (ld->phy->duplex == DUPLEX_FULL) ? HIGMAC_DUP_FULL : 0;

	if (ld->phy->link) {
		switch (ld->phy->speed) {
		case SPEED_10:
			stat |= HIGMAC_SPD_10M;
			speed_mode = speed_mode_10M;
			break;
		default:
			pr_err("wired, phy link speed!\n");
		case SPEED_100:
			stat |= HIGMAC_SPD_100M;
			speed_mode = speed_mode_100M;
			break;
		case SPEED_1000:
			stat |= HIGMAC_SPD_1000M;
			speed_mode = speed_mode_1000M;
			break;
		}
	}

	if ((ld->link_stat != stat) &&
	    ((ld->link_stat | stat) & HIGMAC_LINKED)) {
		phy_print_status(ld->phy);

		if (stat & HIGMAC_LINKED) {
#ifdef HIGMAC_LINK_CHANGE_PROTECT
			unsigned long txflags;

			spin_lock_irqsave(&ld->txlock, txflags);

			higmac_linkup_flush(ld);
#endif
			port_mode = calculate_port_mode(speed_mode,
							ld->phy_mode,
							ld->phy->duplex ==
							DUPLEX_HALF);
			higmac_set_macif(ld, port_mode, ld->phy->speed);

			/* for collision detect and retransmission */
			writel(ld->phy->duplex,
			       ld->gmac_iobase + MAC_DUPLEX_HALF_CTRL);
#ifdef HIGMAC_LINK_CHANGE_PROTECT
			spin_unlock_irqrestore(&ld->txlock, txflags);
#endif
		}

		if (ld->autoeee)
			init_autoeee(ld, stat);
		ld->link_stat = stat;
	}
}

static void higmac_destroy_hw_desc_queue(struct higmac_netdev_local *ld)
{
	int i;

	for (i = 0; i < QUEUE_NUMS; i++) {
		if (ld->pool[i].desc) {
			dma_free_coherent(ld->dev, ld->pool[i].size,
					  ld->pool[i].desc,
					  ld->pool[i].phys_addr);

			ld->pool[i].desc = NULL;
		}
	}

	kfree(ld->rx_fq.skb);
	kfree(ld->tx_bq.skb);
	ld->rx_fq.skb = NULL;
	ld->tx_bq.skb = NULL;

	if (ld->tso_supported) {
		kfree(ld->tx_bq.sg_desc_offset);
		ld->tx_bq.sg_desc_offset = NULL;
	}

	kfree(ld->tx_skb);
	ld->tx_skb = NULL;

	kfree(ld->rx_skb);
	ld->rx_skb = NULL;
}

static int higmac_init_hw_desc_queue(struct higmac_netdev_local *ld)
{
	struct device *dev = ld->dev;
	struct higmac_desc *virt_addr;
	dma_addr_t phys_addr;
	int size, i;

	/* queue depth */
	ld->rx_fq.count = HIGMAC_HWQ_RX_FQ_DEPTH;
	ld->rx_bq.count = HIGMAC_HWQ_RX_BQ_DEPTH;
	ld->tx_bq.count = HIGMAC_HWQ_TX_BQ_DEPTH;
	ld->tx_rq.count = HIGMAC_HWQ_TX_RQ_DEPTH;

	for (i = 0; i < QUEUE_NUMS; i++) {
		size = ld->pool[i].count * sizeof(struct higmac_desc);
		virt_addr = dma_alloc_coherent(dev, size, &phys_addr,
					       GFP_KERNEL);
		if (virt_addr == NULL) {
			pr_err("alloc desc pool[%d] error!\n", i);
			goto error_free_pool;
		}

		memset(virt_addr, 0, size);
		ld->pool[i].size = size;
		ld->pool[i].desc = virt_addr;
		ld->pool[i].phys_addr = phys_addr;
		/* pr_info("pool[i]=%p, phys=0x%x\n", virt_addr, phys_addr); */
	}
	ld->rx_fq.skb = kzalloc(ld->rx_fq.count
				* sizeof(struct sk_buff *), GFP_KERNEL);
	if (ld->rx_fq.skb == NULL)
		goto error_free_pool;

	ld->rx_skb = kzalloc(ld->rx_fq.count
			     * sizeof(struct sk_buff *), GFP_KERNEL);
	if (ld->rx_skb == NULL)
		goto error_free_pool;

	ld->tx_bq.skb = kzalloc(ld->tx_bq.count
				* sizeof(struct sk_buff *), GFP_KERNEL);
	if (ld->tx_bq.skb == NULL)
		goto error_free_pool;

	ld->tx_skb = kzalloc(ld->tx_bq.count
			     * sizeof(struct sk_buff *), GFP_KERNEL);
	if (ld->tx_skb == NULL)
		goto error_free_pool;

	if (ld->tso_supported) {
		ld->tx_bq.sg_desc_offset = kzalloc(ld->tx_bq.count
						   * sizeof(int), GFP_KERNEL);
		if (ld->tx_bq.sg_desc_offset == NULL)
			goto error_free_pool;
	}

	higmac_hw_set_desc_queue_addr(ld);

	return 0;

error_free_pool:
	higmac_destroy_hw_desc_queue(ld);

	return -ENOMEM;
}

int higmac_tx_avail(struct higmac_netdev_local *ld)
{
	int tx_bq_wr_offset, tx_bq_rd_offset;

	tx_bq_wr_offset = readl(ld->gmac_iobase + TX_BQ_WR_ADDR);
	tx_bq_rd_offset = readl(ld->gmac_iobase + TX_BQ_RD_ADDR);

	return (tx_bq_rd_offset >> DESC_BYTE_SHIFT) + HIGMAC_HWQ_TX_BQ_DEPTH
	    - (tx_bq_wr_offset >> DESC_BYTE_SHIFT) - 1;
}

static int higmac_init_sg_desc_queue(struct higmac_netdev_local *ld)
{
	ld->sg_count = ld->tx_bq.count + HIGMAC_SG_DESC_ADD;
	ld->dma_sg_desc = (struct sg_desc *)dma_alloc_coherent(ld->dev,
				ld->sg_count * sizeof(struct sg_desc),
				&ld->dma_sg_phy, GFP_KERNEL);

	if (ld->dma_sg_desc == NULL) {
		pr_err("alloc sg desc dma error!\n");
		return -ENOMEM;
	}
#ifdef HIGMAC_TSO_DEBUG
	pr_info("Higmac dma_sg_phy: 0x%p\n", (void *)ld->dma_sg_phy);
#endif

	ld->sg_head = 0;
	ld->sg_tail = 0;

	return 0;
}

static void higmac_destroy_sg_desc_queue(struct higmac_netdev_local *ld)
{
	if (ld->dma_sg_desc) {
		dma_free_coherent(ld->dev,
				  ld->sg_count * sizeof(struct sg_desc),
				  ld->dma_sg_desc, ld->dma_sg_phy);
		ld->dma_sg_desc = NULL;
	}
}

static void higmac_bfproc_recv(unsigned long data)
{
	struct net_device *dev = (void *)data;
	struct higmac_netdev_local *ld = netdev_priv(dev);
	struct sk_buff *skb = NULL;
	int rx_bq_wr_offset = 0;
	int rx_bq_rd_offset = 0;
	struct higmac_desc *rx_bq_desc;
	dma_addr_t dma_addr;
	unsigned int rlen;
	unsigned long flags;
	int ret = 0;
	int start, end;

	spin_lock_irqsave(&ld->txlock, flags);
	higmac_xmit_release_skb(ld);
	spin_unlock_irqrestore(&ld->txlock, flags);

	spin_lock_irqsave(&ld->rxlock, flags);
	rx_bq_wr_offset = readl(ld->gmac_iobase + RX_BQ_WR_ADDR);
	rx_bq_rd_offset = readl(ld->gmac_iobase + RX_BQ_RD_ADDR);

	start = rx_bq_rd_offset >> DESC_BYTE_SHIFT;

	while (rx_bq_wr_offset != rx_bq_rd_offset) {
		int pos = rx_bq_rd_offset >> DESC_BYTE_SHIFT;

		rx_bq_desc = ld->rx_bq.desc + pos;

		skb = ld->rx_skb[pos];
		while (!skb) {
			pr_err("rx_bq: desc consistent warning\n");
			pr_err("rx_bq:wr=0x%x, rd=0x%x, rx_fq.skb[%d](0x%p)\n",
			       rx_bq_wr_offset, rx_bq_rd_offset,
			       pos, ld->rx_fq.skb[pos]);
			/* logic bug, cause it update rx_bq_wr pointer first
			 * before loading the desc from fifo into rx_bq.
			 * so try to read it again until desc reached the rx_bq.
			 * FIXME: use volatile or __iomem to avoid compiler
			 * optimize?
			 */
			rx_bq_desc = ld->rx_bq.desc + pos;

			skb = ld->rx_skb[pos];
		}

		/* data consistent check */
		if (unlikely(skb != ld->rx_fq.skb[pos])) {
			pr_err("desc->skb(0x%p) != rx_fq.skb[%d](0x%p)!\n",
			       skb, pos, ld->rx_fq.skb[pos]);
			if (ld->rx_fq.skb[pos] == SKB_MAGIC)
				goto next;
			BUG_ON(1);
		} else {
			ld->rx_fq.skb[pos] = NULL;
		}

		if (ld->tso_supported) {
			struct higmac_tso_desc *rx_bq_tso_desc;

			rx_bq_tso_desc = (struct higmac_tso_desc *)rx_bq_desc;
			rlen = rx_bq_tso_desc->desc1.rx.data_len;
		} else {
			rlen = rx_bq_desc->data_len;
		}

		dma_addr = rx_bq_desc->data_buff_addr;

		dma_unmap_single(ld->dev, dma_addr, HIETH_MAX_FRAME_SIZE,
				 DMA_FROM_DEVICE);

		skb_put(skb, rlen);
		skb->protocol = eth_type_trans(skb, dev);

		if (HIETH_INVALID_RXPKG_LEN(skb->len)) {
			pr_err("rcv pkt len error, len = %d\n", skb->len);
			dev->stats.rx_errors++;
			dev->stats.rx_length_errors++;
			dev_kfree_skb_any(skb);
			goto next;
		}

		skb->ip_summed = CHECKSUM_NONE;
#if defined(CONFIG_HIGMAC_RXCSUM)
		if (dev->features & NETIF_F_RXCSUM) {
			int hdr_csum_done =
				rx_bq_desc->header_csum_done;
			int payload_csum_done =
				rx_bq_desc->payload_csum_done;
			int hdr_csum_err =
				rx_bq_desc->header_csum_err;
			int payload_csum_err =
				rx_bq_desc->payload_csum_err;

			if (hdr_csum_done && payload_csum_done) {
				if (unlikely(hdr_csum_err ||
					     payload_csum_err)) {
					dev->stats.rx_errors++;
					dev->stats.rx_crc_errors++;
					dev_kfree_skb_any(skb);
					goto next;
				} else {
					skb->ip_summed = CHECKSUM_UNNECESSARY;
				}
			}
		}
#endif

		dev->stats.rx_packets++;
		dev->stats.rx_bytes += skb->len;
		dev->last_rx = jiffies;

		skb->dev = dev;
		ret = netif_rx(skb);
		if (ret)
			dev->stats.rx_dropped++;
next:
		ld->rx_skb[pos] = NULL;

		rx_bq_rd_offset += DESC_SIZE;
		if (rx_bq_rd_offset >=
		    (HIGMAC_HWQ_RX_BQ_DEPTH << DESC_BYTE_SHIFT))
			rx_bq_rd_offset = 0;

		writel(rx_bq_rd_offset, ld->gmac_iobase + RX_BQ_RD_ADDR);
	}
	end = rx_bq_rd_offset >> DESC_BYTE_SHIFT;
	if (netif_msg_rx_err(ld))
		pr_info("gmac%d reclaim skb[%d-%d)\n", ld->index, start, end);

	higmac_feed_hw(ld);
	spin_unlock_irqrestore(&ld->rxlock, flags);
}

static irqreturn_t hieth_net_isr(int irq, void *dev_id)
{
	/* TODO: remove debug code */
	struct net_device *ndev = (struct net_device *)dev_id;
	struct higmac_netdev_local *ld = netdev_priv(ndev);
	int ints;

	higmac_irq_disable(ld);

	ints = higmac_read_irqstatus(ld);

	if (netif_msg_intr(ld))
		pr_info("gmac%d irq status=0x%x\n", ld->index, ints);

	if (likely(ints & (RX_BQ_IN_INT | RX_BQ_IN_TIMEOUT_INT |
			   TX_RQ_IN_INT | TX_RQ_IN_TIMEOUT_INT))) {
		tasklet_schedule(&ld->bf_recv);
		higmac_clear_irqstatus(ld, ints);
		ints &= ~(RX_BQ_IN_INT | RX_BQ_IN_TIMEOUT_INT
			  | TX_RQ_IN_INT | TX_RQ_IN_TIMEOUT_INT);
	}

	if (unlikely(ints)) {
		higmac_trace(7, "unknown ints=0x%.8x\n", ints);
		higmac_clear_irqstatus(ld, ints);
	}

	higmac_irq_enable(ld);

	return IRQ_HANDLED;
}

static void higmac_monitor_func(unsigned long arg)
{
	struct net_device *dev = (struct net_device *)arg;
	struct higmac_netdev_local *ld = netdev_priv(dev);
	unsigned long flags;

	if (!ld || !netif_running(dev)) {
		higmac_trace(7, "network driver is stopped.");
		return;
	}

	spin_lock_irqsave(&ld->rxlock, flags);
	higmac_feed_hw(ld);
	spin_unlock_irqrestore(&ld->rxlock, flags);

	ld->monitor.expires = jiffies + HIGMAC_MONITOR_TIMER;
	mod_timer(&ld->monitor, ld->monitor.expires);
}

static int higmac_net_open(struct net_device *dev)
{
	struct higmac_netdev_local *ld = netdev_priv(dev);
	unsigned long flags;

	clk_prepare_enable(ld->macif_clk);
	clk_prepare_enable(ld->clk);

	/* If we configure mac address by
	 * "ifconfig ethX hw ether XX:XX:XX:XX:XX:XX",
	 * the ethX must be down state and mac core clock is disabled
	 * which results the mac address has not been configured
	 * in mac core register.
	 * So we must set mac address again here,
	 * because mac core clock is enabled at this time
	 * and we can configure mac address to mac core register.
	 */
	higmac_hw_set_mac_addr(ld, dev->dev_addr);

	ld->link_stat = 0;

	/* We should use netif_carrier_off() here,
	 * because the default state should be off.
	 * And this call should before phy_start().
	 */
	netif_carrier_off(dev);
	phy_start(ld->phy);

	higmac_hw_desc_enable(ld);
	higmac_port_enable(ld);
	higmac_irq_enable(ld);

	spin_lock_irqsave(&ld->rxlock, flags);
	higmac_feed_hw(ld);
	spin_unlock_irqrestore(&ld->rxlock, flags);

	ld->monitor.expires = jiffies + HIGMAC_MONITOR_TIMER;
	mod_timer(&ld->monitor, ld->monitor.expires);

	netdev_reset_queue(dev);
	netif_start_queue(dev);

	return 0;
}

static int higmac_net_close(struct net_device *dev)
{
	struct higmac_netdev_local *ld = netdev_priv(dev);

	higmac_irq_disable(ld);
	higmac_hw_desc_disable(ld);

	netif_carrier_off(dev);
	netif_stop_queue(dev);

	phy_stop(ld->phy);
	del_timer_sync(&ld->monitor);

	clk_disable_unprepare(ld->clk);
	clk_disable_unprepare(ld->macif_clk);

	return 0;
}

static void higmac_net_timeout(struct net_device *dev)
{
	dev->stats.tx_errors++;

	pr_err("tx timeout!\n");
}

static int higmac_net_hard_start_xmit(struct sk_buff *skb,
				      struct net_device *dev)
{
	struct higmac_netdev_local *ld = netdev_priv(dev);
	int ret;

	/* if adding higmac_xmit_release_skb here, iperf tcp client
	 * performance will be affected, from 550M(avg) to 513M~300M
	 */

	ret = higmac_xmit_real_send(ld, skb);
	if (ret) {
		dev->stats.tx_dropped++;
		dev->stats.tx_fifo_errors++;

		netif_stop_queue(dev);
		ret = NETDEV_TX_BUSY;
		goto out;
	}

	dev->trans_start = jiffies;
	dev->stats.tx_packets++;
	dev->stats.tx_bytes += skb->len;

	ret = NETDEV_TX_OK;

out:
	return ret;
}

static void higmac_set_multicast_list(struct net_device *dev)
{
	higmac_gmac_multicast_list(dev);

#if 0
	struct higmac_netdev_local *ld = netdev_priv(dev);
	struct netdev_hw_addr *ha;
	int entry, end, i;

	entry = FWD_TBL_MC_START + FWD_TBL_MC_NUMS_EACH_GMAC * ld->index;
	end = entry + FWD_TBL_MC_NUMS_EACH_GMAC;

	netdev_for_each_mc_addr(ha, dev) {
		if (entry < end) {
			fwd_uc_mc_tbl_add(ld, ha->addr, entry, ADD_MC);
			entry++;
		} else {
			/* shall we switch to promiscous mode? */
			pr_err("Cann't filter so many mc group!\n");
			return;
		}
	}
	/* clear the other mc entry */
	for (i = entry; i < end; i++)
		fwd_mc_tbl_del(ld, entry);
#endif
}

static inline void higmac_enable_rxcsum_drop(struct higmac_netdev_local *ld,
					     bool drop)
{
	unsigned int v;

	v = readl(ld->gmac_iobase + TSO_COE_CTRL);
	if (drop)
		v |= COE_ERR_DROP;
	else
		v &= ~COE_ERR_DROP;
	writel(v, ld->gmac_iobase + TSO_COE_CTRL);
}

static int higmac_set_features(struct net_device *dev,
			       netdev_features_t features)
{
	struct higmac_netdev_local *ld = netdev_priv(dev);
	netdev_features_t changed = dev->features ^ features;

	if (changed & NETIF_F_RXCSUM) {
		if (features & NETIF_F_RXCSUM)
			higmac_enable_rxcsum_drop(ld, true);
		else
			higmac_enable_rxcsum_drop(ld, false);
	}

	return 0;
}

static struct net_device_stats *higmac_net_get_stats(struct net_device *dev)
{
	return &dev->stats;
}

static int higmac_net_set_mac_address(struct net_device *dev, void *p)
{
	struct higmac_netdev_local *ld = netdev_priv(dev);
	int ret;

	ret = eth_mac_addr(dev, p);
	if (!ret)
		higmac_hw_set_mac_addr(ld, dev->dev_addr);

	return ret;
}

static void higmac_get_drvinfo(struct net_device *net_dev,
			       struct ethtool_drvinfo *info)
{
	strncpy(info->driver, "higmac driver", 15);
	strncpy(info->version, "higmac v200", 15);
	strncpy(info->bus_info, "platform", 15);
}

static unsigned int higmac_get_link(struct net_device *net_dev)
{
	struct higmac_netdev_local *ld = netdev_priv(net_dev);

	return ld->phy->link ? HIGMAC_LINKED : 0;
}

static int higmac_get_settings(struct net_device *net_dev,
			       struct ethtool_cmd *cmd)
{
	struct higmac_netdev_local *ld = netdev_priv(net_dev);

	if (ld->phy)
		return phy_ethtool_gset(ld->phy, cmd);

	return -EINVAL;
}

static int higmac_set_settings(struct net_device *net_dev,
			       struct ethtool_cmd *cmd)
{
	struct higmac_netdev_local *ld = netdev_priv(net_dev);

	if (!capable(CAP_NET_ADMIN))
		return -EPERM;

	if (ld->phy)
		return phy_ethtool_sset(ld->phy, cmd);

	return -EINVAL;
}

static u32 higmac_ethtool_getmsglevel(struct net_device *ndev)
{
	struct higmac_netdev_local *priv = netdev_priv(ndev);

	return priv->msg_enable;
}

static void higmac_ethtool_setmsglevel(struct net_device *ndev, u32 level)
{
	struct higmac_netdev_local *priv = netdev_priv(ndev);

	priv->msg_enable = level;
}

static struct ethtool_ops hieth_ethtools_ops = {
	.get_drvinfo = higmac_get_drvinfo,
	.get_link = higmac_get_link,
	.get_settings = higmac_get_settings,
	.set_settings = higmac_set_settings,
	.get_msglevel = higmac_ethtool_getmsglevel,
	.set_msglevel = higmac_ethtool_setmsglevel,
};

static const struct net_device_ops hieth_netdev_ops = {
	.ndo_open = higmac_net_open,
	.ndo_stop = higmac_net_close,
	.ndo_start_xmit = higmac_net_hard_start_xmit,
	.ndo_tx_timeout = higmac_net_timeout,
	.ndo_set_rx_mode = higmac_set_multicast_list,
	.ndo_set_features = higmac_set_features,
	.ndo_do_ioctl = higmac_ioctl,
	.ndo_set_mac_address = higmac_net_set_mac_address,
	.ndo_change_mtu = eth_change_mtu,
	.ndo_get_stats = higmac_net_get_stats,
};

static int higmac_of_get_param(struct higmac_netdev_local *ld,
			       struct device_node *node)
{
	struct device_node *child = NULL;
	int data;

	/* get auto eee */
	ld->autoeee = of_property_read_bool(node, "autoeee");
	/* get internal flag */
	ld->internal_phy =
		of_property_read_bool(node, "internal-phy");

	/* get gpio_base and bit */
	of_property_read_u32(node, "phy-gpio-base",
			(u32 *)(&ld->gpio_base));
	of_property_read_u32(node, "phy-gpio-bit",
			&ld->gpio_bit);

	child = of_get_next_available_child(node, NULL);
	WARN_ON(child == NULL);

	/* get phy-addr */
	if (of_property_read_u32(child, "reg", &data)) {
		pr_err("%s has not config PHY address\n",
		       child->full_name);
		return -EINVAL;
	}
	if ((data < 0) || (data >= PHY_MAX_ADDR)) {
		pr_err("%s has invalid PHY address=%d\n",
		       child->full_name, data);
		return -EINVAL;
	}

	ld->phy_addr = data;

	child = of_get_next_available_child(node, child);
	WARN_ON(child != NULL);

	return 0;
}

static int higmac_dev_probe(struct platform_device *pdev)
{
	struct device *dev = &pdev->dev;
	struct device_node *node = dev->of_node;
	struct net_device *ndev;
	struct higmac_netdev_local *priv;
	struct resource *res_gmac;
	struct resource *res_macif;
#if 0
	struct resource *res_fwd;
	struct resource *res_ctrl;
#endif
	struct mii_bus *bus;
	const char *mac_addr;
	unsigned int tso_ver;
#if 0
	struct higmac_adapter *adapter;
#endif
	int ret;
	struct cpumask cpumask;

	/* init ndev */
	ndev = alloc_etherdev(sizeof(struct higmac_netdev_local));
	if (!ndev)
		return -ENOMEM;

	platform_set_drvdata(pdev, ndev);

	priv = netdev_priv(ndev);
	priv->dev = dev;	/* struct device */
	priv->netdev = ndev;

	res_gmac = platform_get_resource(pdev, IORESOURCE_MEM, MEM_GMAC_IOBASE);
	priv->gmac_iobase = devm_ioremap_resource(dev, res_gmac);
	if (IS_ERR(priv->gmac_iobase)) {
		ret = PTR_ERR(priv->gmac_iobase);
		goto out_free_netdev;
	}

	res_macif = platform_get_resource(pdev, IORESOURCE_MEM,
					  MEM_MACIF_IOBASE);
	priv->macif_base = devm_ioremap_resource(dev, res_macif);
	if (IS_ERR(priv->macif_base)) {
		ret = PTR_ERR(priv->macif_base);
		goto out_free_netdev;
	}

	priv->port_rst = devm_reset_control_get(dev, HIGMAC_PORT_RST_NAME);
	if (IS_ERR(priv->port_rst)) {
		ret = PTR_ERR(priv->port_rst);
		goto out_free_netdev;
	}

	priv->macif_rst = devm_reset_control_get(dev, HIGMAC_MACIF_RST_NAME);
	if (IS_ERR(priv->macif_rst)) {
		ret = PTR_ERR(priv->macif_rst);
		goto out_free_netdev;
	}

	priv->phy_rst = devm_reset_control_get(dev, HIGMAC_PHY_RST_NAME);
	if (IS_ERR(priv->phy_rst))
		priv->phy_rst = NULL;

#if 0
        res_fwd = platform_get_resource(pdev, IORESOURCE_MEM, MEM_FWD_IOBASE);
	if (res_fwd->start == (res_gmac->start + 2 * HIGMAC_ADDR_BLOCK_SIZE)) {
		priv->fwd_base = devm_ioremap_resource(dev, res_fwd);
		if (IS_ERR(priv->fwd_base)) {
			priv->index = GMAC_PORT0;
        } else if (res_fwd->start == (res_gmac->start + HIGMAC_ADDR_BLOCK_SIZE)) {
		priv->index = GMAC_PORT1;
		priv->fwd_base = priv->gmac_iobase + HIGMAC_ADDR_BLOCK_SIZE;
	}

        res = platform_get_resource(pdev, IORESOURCE_MEM, MEM_CTRL_IOBASE);
        priv->ctrl_base = devm_ioremap_resource(dev, res);
        if (IS_ERR(priv->ctrl_base)) {
                ret = PTR_ERR(priv->ctrl_base);
                goto out_free_netdev;
        }
#endif

	priv->clk = devm_clk_get(&pdev->dev, HIGMAC_MAC_CLK_NAME);
	if (IS_ERR(priv->clk)) {
		netdev_err(ndev, "failed to get clk\n");
		ret = -ENODEV;
		goto out_free_netdev;
	}

	ret = clk_prepare_enable(priv->clk);
	if (ret < 0) {
		netdev_err(ndev, "failed to enable clk %d\n", ret);
		goto out_free_netdev;
	}

	priv->macif_clk = devm_clk_get(&pdev->dev, HIGMAC_MACIF_CLK_NAME);
	if (IS_ERR(priv->macif_clk))
		priv->macif_clk = NULL;

	if (priv->macif_clk) {
		ret = clk_prepare_enable(priv->macif_clk);
		if (ret < 0) {
			netdev_err(ndev, "failed enable macif_clk %d\n", ret);
			goto out_clk_disable;
		}
	}

	higmac_mac_core_reset(priv);

	/* phy reset, should be early than "of_mdiobus_register".
	 * becausue "of_mdiobus_register" will read PHY register by MDIO.
	 */
	higmac_hw_phy_reset(priv);

	bus = mdiobus_alloc();
	if (bus == NULL) {
		ret = -ENOMEM;
		goto out_macif_clk_disable;
	}

	bus->priv = priv;
	bus->name = "higmac_mii_bus";
	bus->read = higmac_mdio_read;
	bus->write = higmac_mdio_write;
	bus->parent = &pdev->dev;
	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-mii", dev_name(&pdev->dev));
	priv->bus = bus;

	ret = of_mdiobus_register(bus, node);
	if (ret)
		goto err_free_mdio;

	higmac_of_get_param(priv, node);

	priv->phy_mode = of_get_phy_mode(node);
	if (priv->phy_mode < 0) {
		netdev_err(ndev, "not find phy-mode\n");
		ret = -EINVAL;
		goto err_mdiobus;
	}

	priv->phy_node = of_parse_phandle(node, "phy-handle", 0);
	if (!priv->phy_node) {
		netdev_err(ndev, "not find phy-handle\n");
		ret = -EINVAL;
		goto err_mdiobus;
	}

	mac_addr = of_get_mac_address(node);
	if (mac_addr)
		ether_addr_copy(ndev->dev_addr, mac_addr);
	if (!is_valid_ether_addr(ndev->dev_addr)) {
		eth_hw_addr_random(ndev);
		netdev_warn(ndev, "using random MAC address %pM\n",
			    ndev->dev_addr);
	}

	higmac_hw_set_mac_addr(priv, ndev->dev_addr);

	/* init hw controller */
	higmac_hw_mac_core_init(priv);

	/* TODO: phy fix here?? other way ??? */
	phy_register_fixups();

	priv->phy = of_phy_connect(ndev, priv->phy_node,
				   &higmac_adjust_link, 0, priv->phy_mode);
	if (!priv->phy) {
		ret = -ENODEV;
		goto out_phy_node;
	}

	/* If the phy_id is mostly Fs, there is no device there */
	if ((priv->phy->phy_id & 0x1fffffff) == 0x1fffffff ||
	    priv->phy->phy_id == 0) {
		pr_info("phy %d not found\n", priv->phy->addr);
		ret = -ENODEV;
		goto out_phy_disconnect;
	}

	pr_info("attached PHY %d to driver %s, PHY_ID=0x%x\n",
		priv->phy->addr, priv->phy->drv->name, priv->phy->phy_id);

	/* Stop Advertising 1000BASE Capability if interface is not RGMII */
	if ((priv->phy_mode == PHY_INTERFACE_MODE_MII) ||
	    (priv->phy_mode == PHY_INTERFACE_MODE_RMII)) {
		priv->phy->advertising &= ~(SUPPORTED_1000baseT_Half |
					    SUPPORTED_1000baseT_Full);

		/* Internal FE phy's reg BMSR bit8 is wrong, make the kernel
		 * believe it has the 1000base Capability, so fix it here
		 */
		if (priv->phy->phy_id == HISILICON_PHY_ID_FESTAV200)
			priv->phy->supported &= ~(ADVERTISED_1000baseT_Full |
						  ADVERTISED_1000baseT_Half);
	}

	if (priv->autoeee)
		init_autoeee(priv, 0);

	ndev->irq = platform_get_irq(pdev, 0);
	if (ndev->irq <= 0) {
		netdev_err(ndev, "No irq resource\n");
		ret = -EINVAL;
		goto out_phy_disconnect;
	}

	ret = devm_request_irq(dev, ndev->irq, hieth_net_isr,
			       0, pdev->name, ndev);
	if (ret) {
		netdev_err(ndev, "devm_request_irq failed\n");
		goto out_phy_disconnect;
	}

	/* set irq affinity */
	if ((num_online_cpus() > HIGMAC_IRQ_AFFINITY_CPU) &&
	    cpu_online(HIGMAC_IRQ_AFFINITY_CPU)) {
		cpumask_clear(&cpumask);
		cpumask_set_cpu(HIGMAC_IRQ_AFFINITY_CPU, &cpumask);
		irq_set_affinity(ndev->irq, &cpumask);
	}

	spin_lock_init(&priv->rxlock);
	spin_lock_init(&priv->txlock);
	spin_lock_init(&priv->pmtlock);

	/* init netdevice */
	SET_NETDEV_DEV(ndev, dev);	/* init ndev */
	ndev->watchdog_timeo = 3 * HZ;
	ndev->netdev_ops = &hieth_netdev_ops;
	ndev->ethtool_ops = &hieth_ethtools_ops;

	tso_ver = readl(priv->gmac_iobase + CRF_MIN_PACKET);
	tso_ver = (tso_ver >> BIT_OFFSET_TSO_VERSION) & BIT_MASK_TSO_VERSION;

	if (tso_ver == VER_TSO) {
		priv->tso_supported = true;
		ndev->hw_features |= NETIF_F_SG |
			NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
			NETIF_F_TSO | NETIF_F_TSO6 | NETIF_F_UFO;
	}
#if defined(CONFIG_HIGMAC_RXCSUM)
	ndev->hw_features |= NETIF_F_RXCSUM;
	higmac_enable_rxcsum_drop(priv, true);
#endif

	ndev->features |= ndev->hw_features;
	ndev->features |= NETIF_F_HIGHDMA | NETIF_F_GSO;
	ndev->vlan_features |= ndev->features;

	/* init tasklet */
	priv->bf_recv.next = NULL;
	priv->bf_recv.state = 0;
	priv->bf_recv.func = higmac_bfproc_recv;
	priv->bf_recv.data = (unsigned long)ndev;
	atomic_set(&priv->bf_recv.count, 0);

	init_timer(&priv->monitor);
	priv->monitor.function = higmac_monitor_func;
	priv->monitor.data = (unsigned long)ndev;
	priv->monitor.expires = jiffies + HIGMAC_MONITOR_TIMER;

	device_set_wakeup_capable(priv->dev, 1);
	/* TODO: when we can let phy powerdown?
	 * In some mode, we don't want phy powerdown,
	 * so I set wakeup enable all the time
	 */
	device_set_wakeup_enable(priv->dev, 1);

	priv->wol_enable = false;

#if 0
	spin_lock_init(&adapter->lock);
	priv->adapter	= adapter;/* glb sys adapter */
	adapter->work_mode = STANDALONE;
	fwd_setup(adapter);
#endif
	priv->msg_enable = netif_msg_init(debug, DEFAULT_MSG_ENABLE);

	/* init hw desc queue */
	ret = higmac_init_hw_desc_queue(priv);
	if (ret)
		goto _error_hw_desc_queue;

	if (priv->tso_supported) {
		ret = higmac_init_sg_desc_queue(priv);
		if (ret)
			goto _error_sg_desc_queue;
	}

	/* register netdevice */
	ret = register_netdev(priv->netdev);
	if (ret) {
		pr_err("register_ndev failed!");
		goto _error_sg_desc_queue;
	}

	clk_disable_unprepare(priv->clk);
	if (priv->macif_clk)
		clk_disable_unprepare(priv->macif_clk);

	pr_info("ETH: %s, phy_addr=%d\n",
		phy_modes(priv->phy_mode), priv->phy->addr);

	return ret;

_error_sg_desc_queue:
	if (priv->tso_supported)
		higmac_destroy_sg_desc_queue(priv);

_error_hw_desc_queue:
	higmac_destroy_hw_desc_queue(priv);
	devm_free_irq(dev, ndev->irq, ndev);
out_phy_disconnect:
	phy_disconnect(priv->phy);
out_phy_node:
	of_node_put(priv->phy_node);
err_mdiobus:
	mdiobus_unregister(bus);
err_free_mdio:
	mdiobus_free(bus);
out_macif_clk_disable:
	if (priv->macif_clk)
		clk_disable_unprepare(priv->macif_clk);
out_clk_disable:
	clk_disable_unprepare(priv->clk);
out_free_netdev:
	free_netdev(ndev);

	return ret;
}

static int higmac_dev_remove(struct platform_device *pdev)
{
	struct device *dev = &pdev->dev;
	struct net_device *ndev = platform_get_drvdata(pdev);
	struct higmac_netdev_local *priv = netdev_priv(ndev);

	/* TODO: stop the gmac and free all resource */
	del_timer_sync(&priv->monitor);
	tasklet_disable(&priv->bf_recv);

	unregister_netdev(ndev);

	higmac_reclaim_rx_tx_resource(priv);

	if (priv->tso_supported)
		higmac_destroy_sg_desc_queue(priv);
	higmac_destroy_hw_desc_queue(priv);

	devm_free_irq(dev, ndev->irq, ndev);

	phy_disconnect(priv->phy);
	of_node_put(priv->phy_node);

	mdiobus_unregister(priv->bus);
	mdiobus_free(priv->bus);

	free_netdev(ndev);

	return 0;
}

static inline bool need_forcing_fwd(void)
{
#if 0
	struct higmac_adapter *adapter = get_adapter();
	return adapter->forcing_fwd;
#endif
	return false;
}

#include "pm.c"
#ifdef CONFIG_PM

int higmac_dev_suspend(struct platform_device *pdev, pm_message_t state)
{
	struct net_device *ndev = platform_get_drvdata(pdev);
//	struct higmac_adapter *adapter = get_adapter();
	struct higmac_netdev_local *priv = netdev_priv(ndev);
//	int mode = adapter->work_mode;
	int val;

	disable_irq(ndev->irq);
	/* If support Wake on LAN, we should not disconnect phy
	 * because it will call phy_suspend to power down phy.
	 */
	if (!priv->wol_enable)
		phy_disconnect(priv->phy);
	del_timer_sync(&priv->monitor);
	tasklet_disable(&priv->bf_recv);
	netif_device_detach(ndev);

	netif_carrier_off(ndev);

	/* If netdev is down, MAC clock is disabled.
	 * So if we want to reclaim MAC rx and tx resource,
	 * we must first enable MAC clock and then disable it.
	 */
	if (!(ndev->flags & IFF_UP))
		clk_prepare_enable(priv->clk);

	higmac_reclaim_rx_tx_resource(priv);

	if (!(ndev->flags & IFF_UP))
		clk_disable_unprepare(priv->clk);

	if (need_forcing_fwd()) {
		/* set gmac in promisc mode.received all pkgs. */
		val = readl_relaxed(priv->gmac_iobase + REC_FILT_CONTROL);
		val &= ~(BIT_BC_DROP_EN | BIT_MC_MATCH_EN |
				BIT_UC_MATCH_EN);
		writel_relaxed(val, priv->gmac_iobase + REC_FILT_CONTROL);
#if 0
		mode = MODE3;
#endif
		priv->wol_enable = true;
	}

#if 0
	fwd_suspend(adapter, mode);
#endif

	pmt_enter(priv);

	if (!priv->wol_enable) {	/* if no WOL, then poweroff */
		/* pr_info("power off gmac.\n"); */
		/* no need to call genphy_resume() in resume,
		 * because we reset everything
		 */
		genphy_suspend(priv->phy);	/* power down phy */
		msleep(20);
		higmac_hw_all_clk_disable(priv);
	}

	return 0;
}
EXPORT_SYMBOL(higmac_dev_suspend);

int higmac_dev_resume(struct platform_device *pdev)
{
	struct net_device *ndev = platform_get_drvdata(pdev);
	struct higmac_netdev_local *priv = netdev_priv(ndev);
//	struct higmac_adapter *adapter = get_adapter();

	/* If we support Wake on LAN, we doesn't call clk_disable.
	 * But when we resume, the uboot may off mac clock and reset phy
	 * by re-write the mac CRG register.
	 * So we first call clk_disable, and then clk_enable.
	 */
	if (priv->wol_enable)
		higmac_hw_all_clk_disable(priv);

	higmac_hw_all_clk_enable(priv);
	/* internal FE_PHY: enable clk and reset  */
	higmac_hw_phy_reset(priv);
#if 0
	higmac_hw_phy_gpio_reset();
	higmac_hw_external_phy_reset();
#endif

#if 0
	fwd_resume(adapter);
#endif

	/* If netdev is down, MAC clock is disabled.
	 * So if we want to restart MAC and re-initialize it,
	 * we must first enable MAC clock and then disable it.
	 */
	if (!(ndev->flags & IFF_UP))
		clk_prepare_enable(priv->clk);

	/* power on gmac */
	higmac_restart(priv);

	/* If support WoL, we didn't disconnect phy.
	 * But when we resume, we reset PHY, so we want to
	 * call phy_connect to make phy_fixup excuted.
	 * This is important for internal PHY fix.
	 */
	if (priv->wol_enable)
		phy_disconnect(priv->phy);

	phy_connect_direct(ndev, priv->phy, higmac_adjust_link, priv->phy_mode);

	/* If we suspend and resume when net device is down,
	 * some operations are unnecessary.
	 */
	if (ndev->flags & IFF_UP) {
		priv->monitor.expires = jiffies + HIGMAC_MONITOR_TIMER;
		mod_timer(&priv->monitor, priv->monitor.expires);
		if (priv->phy->phy_id == HISILICON_PHY_ID_FESTAV200)
			priv->link_stat = HIGMAC_DUP_FULL;
		else
			priv->link_stat = 0;
	}
	tasklet_enable(&priv->bf_recv);
	netif_device_attach(ndev);
	if (ndev->flags & IFF_UP)
		phy_start(priv->phy);
	enable_irq(ndev->irq);

	pmt_exit(priv);

	if (!(ndev->flags & IFF_UP))
		clk_disable_unprepare(priv->clk);

	return 0;
}
EXPORT_SYMBOL(higmac_dev_resume);
#else
#define higmac_dev_suspend	NULL
#define higmac_dev_resume	NULL
#endif

static const struct of_device_id higmac_of_match[] = {
	{.compatible = "hisilicon,higmac",},
};

MODULE_DEVICE_TABLE(of, higmac_of_match);

static struct platform_driver higmac_dev_driver = {
	.probe = higmac_dev_probe,
	.remove = higmac_dev_remove,
	.suspend = higmac_dev_suspend,
	.resume = higmac_dev_resume,
	.driver = {
		   .owner = THIS_MODULE,
		   .name = HIGMAC_DRIVER_NAME,
		   .of_match_table = higmac_of_match,
		   },
};

#include "proc-dev.c"

static int __init higmac_init(void)
{
	int ret = 0;

	ret = platform_driver_register(&higmac_dev_driver);
	if (ret)
		return ret;

	higmac_proc_create();

	return ret;
}

static void __exit higmac_exit(void)
{
	platform_driver_unregister(&higmac_dev_driver);

	higmac_proc_destroy();
}

module_init(higmac_init);
module_exit(higmac_exit);

MODULE_AUTHOR("ZMJUN");
MODULE_DESCRIPTION("Hisilicon double GMAC driver, base on driver higmacv200 by CHH");
MODULE_LICENSE("GPL v2");
