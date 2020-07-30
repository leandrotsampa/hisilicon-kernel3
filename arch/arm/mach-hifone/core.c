#include <linux/init.h>
#include <asm/irq.h>
#include <asm/mach-types.h>
#include <asm/mach/arch.h>
#include <asm/mach/map.h>
#include <mach/hardware.h>
#include <mach/early-debug.h>
#include <linux/irqchip/arm-gic.h>
#include <linux/delay.h>
#include <linux/memblock.h>
#include <linux/of_platform.h>
#include "platsmp.h"

#ifdef CONFIG_DMA_CMA
extern int hisi_declare_heap_memory(void);
#endif

int combphy_fixed  = 0;
EXPORT_SYMBOL(combphy_fixed);

/*****************************************************************************/

static struct map_desc hifone_io_desc[] __initdata = {
	/* HIFONE_IOCH1 */
	{
		.virtual	= HIFONE_IOCH1_VIRT,
		.pfn		= __phys_to_pfn(HIFONE_IOCH1_PHYS),
		.length		= HIFONE_IOCH1_SIZE,
		.type		= MT_DEVICE
	},
	/* HIFONE_IOCH2 */
	{
		.virtual	= HIFONE_IOCH2_VIRT,
		.pfn		= __phys_to_pfn(HIFONE_IOCH2_PHYS),
		.length		= HIFONE_IOCH2_SIZE,
		.type		= MT_DEVICE
	},
	/* HIFONE_IOCH3 */
	{
		.virtual	= HIFONE_IOCH3_VIRT,
		.pfn		= __phys_to_pfn(HIFONE_IOCH3_PHYS),
		.length		= HIFONE_IOCH3_SIZE,
		.type		= MT_DEVICE
	},
	/* HIFONE_IOCH4 */
	{
		.virtual	= HIFONE_IOCH4_VIRT,
		.pfn		= __phys_to_pfn(HIFONE_IOCH4_PHYS),
		.length		= HIFONE_IOCH4_SIZE,
		.type		= MT_DEVICE
	},
	/* HIFONE_IOCH5 */
	{
		.virtual	= HIFONE_IOCH5_VIRT,
		.pfn		= __phys_to_pfn(HIFONE_IOCH5_PHYS),
		.length		= HIFONE_IOCH5_SIZE,
		.type		= MT_DEVICE
	},
	/* HIFONE_IOCH6 */
	{
		.virtual	= HIFONE_IOCH6_VIRT,
		.pfn		= __phys_to_pfn(HIFONE_IOCH6_PHYS),
		.length		= HIFONE_IOCH6_SIZE,
		.type		= MT_DEVICE
	},
	/* HIFONE_IOCH7 */
	{
		.virtual	= HIFONE_IOCH7_VIRT,
		.pfn		= __phys_to_pfn(HIFONE_IOCH7_PHYS),
		.length		= HIFONE_IOCH7_SIZE,
		.type		= MT_DEVICE
	},
	/* HIFONE_IOCH8 */
	{
		.virtual	= HIFONE_IOCH8_VIRT,
		.pfn		= __phys_to_pfn(HIFONE_IOCH8_PHYS),
		.length		= HIFONE_IOCH8_SIZE,
		.type		= MT_DEVICE
	},
	/* HIFONE_IOCH9 */
	{
		.virtual	= HIFONE_IOCH9_VIRT,
		.pfn		= __phys_to_pfn(HIFONE_IOCH9_PHYS),
		.length		= HIFONE_IOCH9_SIZE,
		.type		= MT_DEVICE
	},
};
/*****************************************************************************/

void __init hifone_map_io(void)
{
	int i;

	iotable_init(hifone_io_desc, ARRAY_SIZE(hifone_io_desc));
	printk(KERN_DEBUG "-------------Fixed IO Mapping----------\n");
	printk(KERN_DEBUG "Virt,            Phys,             Size\n");

	for (i = 0; i < ARRAY_SIZE(hifone_io_desc); i++) {
		printk(KERN_DEBUG "0x%08lX,    0x%08X,    0x%08lX\n",
			hifone_io_desc[i].virtual,
			__pfn_to_phys(hifone_io_desc[i].pfn),
			hifone_io_desc[i].length);
		edb_putstr(" V: ");	edb_puthex(hifone_io_desc[i].virtual);
		edb_putstr(" P: ");	edb_puthex(hifone_io_desc[i].pfn);
		edb_putstr(" S: ");	edb_puthex(hifone_io_desc[i].length);
		edb_putstr(" T: ");	edb_putul(hifone_io_desc[i].type);
		edb_putstr("\n");
	}
	printk(KERN_DEBUG "--------------------------------------\n");

	edb_trace();
}
/*****************************************************************************/

static void __init hifone_reserve(void)
{

#ifdef CONFIG_SUPPORT_DSP_RUN_MEM
	/* Reserve memory for DSP */
	BUG_ON(memblock_reserve(CONFIG_DSP_RUN_MEM_ADDR,
		CONFIG_DSP_RUN_MEM_SIZE));

	printk(KERN_NOTICE "DSP run memory space at 0x%08X, size: 0x%08x Bytes.\n",
		CONFIG_DSP_RUN_MEM_ADDR,
		CONFIG_DSP_RUN_MEM_SIZE);
#endif

#ifdef CONFIG_DMA_CMA
	hisi_declare_heap_memory();
#endif
}
/*****************************************************************************/

void __init hifone_init(void)
{
	u32 reg_data;
	void *base = NULL;

	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);

	/* read combphy ec version when init function */
	base = __io_address(REG_BASE_PERI_CTRL);
	reg_data = readl(base + 0x160);
	if((reg_data&0xC00000) == 0xC00000)
		combphy_fixed = 1;
}

/*****************************************************************************/

static void __init hifone_init_early(void)
{
	/*
	 * 1. enable L1 prefetch                       [2]
	 * 4. enable allocation in one cache way only. [8]
	 */
	asm volatile (
	"	mrc	p15, 0, r0, c1, c0, 1\n"
	"	orr	r0, r0, #0x104\n"
	"	mcr	p15, 0, r0, c1, c0, 1\n"
	  :
	  :
	  : "r0", "cc");
}
/*****************************************************************************/

#ifdef CONFIG_HIMCIV200_SDIO_SYNOPSYS
static int hifone_mci_quirk(void)
{
	void *base = __io_address(REG_BASE_SDIO1);
	unsigned int reg_data = 0;

	writel(0x1affe, base + 0x44);
	writel(0, base + 0x20);
	writel(0, base + 0x1c);
	writel(0, base + 0x28);

	writel(0xa000414c, base + 0x2c);

	mdelay(100);

	reg_data = readl(base + 0x00);
	reg_data |= 7;
	writel(reg_data, base + 0x00);

	writel(0, base + 0x78);
	writel(0, base + 0x04);
	mdelay(2);
	writel(1, base + 0x78);

	return 0;
}
#endif

void hifone_restart(enum reboot_mode mode, const char *cmd)
{
	printk(KERN_INFO "CPU will restart.");

	mdelay(200);

	local_irq_disable();

#ifdef CONFIG_HIMCIV200_SDIO_SYNOPSYS
	hifone_mci_quirk();
#endif

	/* unclock wdg */
	writel(0x1ACCE551,  __io_address(REG_BASE_WDG0 + 0xc00));
	/* wdg load value */
	writel(0x00000100,  __io_address(REG_BASE_WDG0 + 0x0));
	/* bit0: int enable bit1: reboot enable */
	writel(0x00000003,  __io_address(REG_BASE_WDG0 + 0x8));

	while (1)
		;

	BUG();
}
/*****************************************************************************/

static const char * const hifone_dt_board_compat[] = {
	"hifone-series",
	NULL
};

DT_MACHINE_START(HIFONE, "bigfish")
	.dt_compat    = hifone_dt_board_compat,
	.atag_offset	= 0x100,
	.map_io		= hifone_map_io,
	.init_early	= hifone_init_early,
	.init_machine	= hifone_init,
	.smp          = smp_ops(hifone_smp_ops),
	.reserve	= hifone_reserve,
	.restart	= hifone_restart,
MACHINE_END
