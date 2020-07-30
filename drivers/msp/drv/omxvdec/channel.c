/*
 * Copyright (c) (2014 - ...) Device Chipset Source Algorithm and Chipset Platform Development Dept
 * Hisilicon. All rights reserved.
 *
 * File:    channel.c
 *
 * Purpose: omxvdec channel functions
 *
 * Author:  yangyichang 00226912
 *
 * Date:    26, 11, 2014
 *
 */

#include <linux/dma-buf.h> //for dma buf, ion map

#include "omxvdec.h"
#include "channel.h"
#include "decoder.h"
#include "processor.h"

#include "vfmw_ext.h"
#include "hi_module.h"    //HI_ID_VDEC
#include "hi_drv_stat.h"


/*================ EXTERN VALUE ================*/
extern HI_BOOL  g_SaveRawEnable;
extern HI_CHAR  g_SavePath[];
extern HI_CHAR  g_SaveName[];
extern HI_U32   g_SaveNum;
extern HI_BOOL  g_FastOutputMode;
extern HI_U32   g_lowdelay_count_frame;
extern HI_BOOL  g_LowDelayStatistics;
extern VFMW_EXPORT_FUNC_S* pVfmwFunc;

#ifdef VFMW_VPSS_BYPASS_EN
extern OMXVDEC_ENTRY  *g_OmxVdec;
#endif
/*============== INTERNAL FUNCTION =============*/

static inline const HI_PCHAR channel_show_chan_state(eCHAN_STATE state)
{
	switch (state)
    {
       case CHAN_STATE_IDLE:
            return "IDLE";
            break;

       case CHAN_STATE_WORK:
            return "WORK";
            break;

       case CHAN_STATE_PAUSE:
            return "PAUSE";
            break;

       case CHAN_STATE_PAUSE_PENDING:
            return "PAUSE_PENDING";
            break;

       default:
            return "INVALID";
            break;
	}
}

static inline const HI_PCHAR channel_show_protocol(HI_U32 protocol)
{
    /* CodecType Relative */
    HI_PCHAR s;
    switch (protocol)
    {
        case STD_HEVC:
           s = "H265";
           break;

        case STD_H264:
           s = "H264";
           break;

        case STD_MVC:
           s = "MVC";
           break;

        case STD_MPEG4:
           s = "MPEG4";
           break;

        case STD_H263:
           s = "H263";
           break;

        case STD_MPEG2:
           s = "MPEG2";
           break;

        case STD_DIVX3:
           s = "DIVX3";
           break;

        case STD_VP6:
           s = "VP6";
           break;

        case STD_VP6F:
           s = "VP6F";
           break;

        case STD_VP6A:
           s = "VP6A";
           break;

        case STD_VP8:
           s = "VP8";
           break;

        case STD_VP9:
           s = "VP9";
           break;

        case STD_REAL8:
           s = "REAL8";
           break;

        case STD_REAL9:
           s = "REAL9";
           break;

        case STD_AVS:
           s = "AVS";
           break;

        case STD_SORENSON:
           s = "SORENSON";
           break;

        case STD_VC1:
           s = "VC1AP";
           break;

        case (VID_STD_E)STD_WMV:
           s = "VC1SMP";
           break;

        case (VID_STD_E)STD_MJPEG:
           s = "MJPEG";
           break;

        default:
           s = "unknow";
           break;
    }

    return s;
}

static inline const HI_PCHAR channel_show_dfs_state(eDFS_STATE state)
{
	switch (state)
    {
       case DFS_INIT:
            return "INIT";
            break;

       case DFS_WAIT_RESPONSE_0:
            return "WAIT RESPONSE 0";
            break;

       case DFS_WAIT_INSERT:
            return "WAIT INSERT";
            break;

       case DFS_WAIT_BIND:
            return "WAIT BIND";
            break;

       case DFS_WAIT_FILL:
            return "WAIT FILL";
            break;

       case DFS_WAIT_ACTIVATE:
            return "WAIT ACTIVATE";
            break;

        case DFS_WAIT_RESPONSE_1:
            return "WAIT RESPONSE 1";
            break;

       case DFS_WAIT_TRY_ALLOC:
            return "WAIT TRY ALLOC";
            break;

       case DFS_WAIT_CONFIG:
            return "WAIT CONFIG";
            break;

       case DFS_DONE:
            return "DONE";
            break;

       default:
            return "UNKOWN";
            break;
	}
}

static inline const HI_PCHAR channel_show_color_format(OMX_PIX_FORMAT_E format)
{
    HI_PCHAR s;
    switch (format)
    {
       case OMX_PIX_FMT_NV12:
           s = "YUV420SemiPlanar";
           break;

       case OMX_PIX_FMT_NV21:
           s = "YVU420SemiPlanar";
           break;

       case OMX_PIX_FMT_YUV420Planar:
           s = "YUV420Planar";
           break;

       case OMX_PIX_FMT_YUV420Tile:
           s = "YUV420Tile";
           break;

       default:
           OmxPrint(OMX_ERR, "unkown format %d\n", format);
           s = "unkown format";
           break;
    }

    return s;
}

static inline const HI_PCHAR channel_show_buffer_state(eBUFFER_STATE state)
{
	switch (state)
    {
        case BUF_STATE_IDLE:
            return "idle";
            break;

        case BUF_STATE_QUEUED:
            return "queued";
            break;

        case BUF_STATE_USING:
            return "using";
            break;

        default:
            return "invalid";
            break;
	}
}

static HI_VOID channel_show_chan_config(OMXVDEC_DRV_CFG *pcfg)
{
    OmxPrint(OMX_INFO, "\n");
    OmxPrint(OMX_INFO, " IsOmxPath        = %d\n", pcfg->chan_cfg.s32IsOmxPath);
    OmxPrint(OMX_INFO, " Protocol         = %s\n", channel_show_protocol(pcfg->chan_cfg.eVidStd));
    OmxPrint(OMX_INFO, " Resolution       = %dx%d\n", pcfg->cfg_width, pcfg->cfg_height);
    OmxPrint(OMX_INFO, " Stride           = %d\n", pcfg->cfg_stride);
    OmxPrint(OMX_INFO, " UseNativeBuf     = %d\n", pcfg->m_use_native_buf);
    OmxPrint(OMX_INFO, " ColorFormat      = %s\n", channel_show_color_format(pcfg->cfg_color_format));
    OmxPrint(OMX_INFO, " IsAdvProfile     = %d\n", pcfg->chan_cfg.StdExt.Vc1Ext.IsAdvProfile);
    OmxPrint(OMX_INFO, " CodecVersion     = %d\n", pcfg->chan_cfg.StdExt.Vc1Ext.CodecVersion);
    OmxPrint(OMX_INFO, " bReversed        = %d\n", pcfg->chan_cfg.StdExt.Vp6Ext.bReversed);
    OmxPrint(OMX_INFO, " ChanPriority     = %d\n", pcfg->chan_cfg.s32ChanPriority);
    OmxPrint(OMX_INFO, " ChanErrThr       = %d\n", pcfg->chan_cfg.s32ChanErrThr);
    OmxPrint(OMX_INFO, " ChanStrmOFThr    = %d\n", pcfg->chan_cfg.s32ChanStrmOFThr);
    OmxPrint(OMX_INFO, " DecMode          = %d\n", pcfg->chan_cfg.s32DecMode);
    OmxPrint(OMX_INFO, " DecOrderOutput   = %d\n", pcfg->chan_cfg.s32DecOrderOutput);
    OmxPrint(OMX_INFO, " SupportAllP      = %d\n", pcfg->chan_cfg.s32SupportAllP);
    OmxPrint(OMX_INFO, " LowdlyEnable     = %d\n", pcfg->chan_cfg.s32LowdlyEnable);
    OmxPrint(OMX_INFO, " BtlDbdrEnable    = %d\n", pcfg->chan_cfg.s32BtlDbdrEnable);
    OmxPrint(OMX_INFO, " Btl1Dt2DEnable   = %d\n", pcfg->chan_cfg.s32Btl1Dt2DEnable);
    OmxPrint(OMX_INFO, " CompressEnbale   = %d\n", pcfg->chan_cfg.s32VcmpEn);
    OmxPrint(OMX_INFO, " WaterMarkerEn    = %d\n", pcfg->chan_cfg.s32WmEn);
    OmxPrint(OMX_INFO, " MaxRawPacketNum  = %d\n", pcfg->chan_cfg.s32MaxRawPacketNum);
    OmxPrint(OMX_INFO, " MaxRawPacketSize = %d\n", pcfg->chan_cfg.s32MaxRawPacketSize);
    OmxPrint(OMX_INFO, "\n");

	return;
}

static HI_S32 channel_add_chan_record(OMXVDEC_ENTRY *omxvdec, OMXVDEC_CHAN_CTX *pchan)
{
	HI_U32 record_id  = 0;
	HI_U32 channel_id = 0;
	unsigned long flags;
	OMXVDEC_CHAN_CTX *recorded_chan = HI_NULL;

    if (HI_NULL == omxvdec || pchan == HI_NULL)
    {
        OmxPrint(OMX_FATAL, "%s param invalid!\n", __func__);
		return HI_FAILURE;
	}

	spin_lock_irqsave(&omxvdec->channel_lock, flags);
	if (!list_empty(&omxvdec->chan_list))
    {
        do {
            record_id = channel_id;
            list_for_each_entry(recorded_chan, &omxvdec->chan_list, chan_list)
            {
                if(recorded_chan->channel_id == channel_id)
                {
                    channel_id++;
                    break;
                }
            }
        }while(record_id != channel_id);
    }
    pchan->channel_id = channel_id;

	list_add_tail(&pchan->chan_list, &omxvdec->chan_list);
	spin_unlock_irqrestore(&omxvdec->channel_lock, flags);

    omxvdec->total_chan_num++;
    OmxPrint(OMX_INFO, "%s: channel %d create successfully!\n", __func__, channel_id);

	return HI_SUCCESS;
}

static HI_S32 channel_delete_chan_record(OMXVDEC_ENTRY *omxvdec, OMXVDEC_CHAN_CTX *pchan)
{
	unsigned long flags;

    if (HI_NULL == omxvdec || pchan == HI_NULL)
    {
        OmxPrint(OMX_FATAL, "%s param invalid!\n", __func__);
		return HI_FAILURE;
	}

	spin_lock_irqsave(&omxvdec->channel_lock, flags);
	list_del(&pchan->chan_list);
	spin_unlock_irqrestore(&omxvdec->channel_lock, flags);

    omxvdec->total_chan_num --;

    OmxPrint(OMX_INFO, "%s: channel %d release successfully!\n", __func__, pchan->channel_id);

	return HI_SUCCESS;
}

static HI_S32 channel_map_kernel_viraddr(OMXVDEC_BUF_DESC *puser_buf, HI_VOID **kern_vaddr)
{
    HI_S32        ret;
    MMZ_BUFFER_S  stBuffer;
    memset(&stBuffer, 0, sizeof(MMZ_BUFFER_S));

    if (OMX_USE_NATIVE == puser_buf->buffer_type)
    {
       *kern_vaddr = __va(puser_buf->phyaddr);
    }
#ifdef HI_OMX_TEE_SUPPORT
    else if (OMX_ALLOCATE_SECURE == puser_buf->buffer_type)
    {
        //c00277632
    }
#endif
    else
    {
       stBuffer.u32StartPhyAddr = puser_buf->phyaddr;

       ret = HI_DRV_OMXVDEC_Map(&stBuffer);
       if (HI_SUCCESS != ret)
       {
           OmxPrint(OMX_FATAL, "%s call MEM_Map failed!\n", __func__);
           return HI_FAILURE;
       }
       *kern_vaddr = (HI_VOID *)stBuffer.pu8StartVirAddr;
    }

	return HI_SUCCESS;
}

static HI_S32 channel_unmap_kernel_viraddr(OMXVDEC_BUF_S *puser_buf)
{
    MMZ_BUFFER_S  stBuffer;
    memset(&stBuffer, 0, sizeof(MMZ_BUFFER_S));

	if (puser_buf->buf_type == OMX_ALLOCATE_USR || puser_buf->buf_type == OMX_USE_OTHER)
	{
    	stBuffer.pu8StartVirAddr = (HI_U8*)puser_buf->kern_vaddr;
        stBuffer.u32StartPhyAddr = puser_buf->phy_addr;
    	HI_DRV_OMXVDEC_Unmap(&stBuffer);
	}

	return HI_SUCCESS;
}

#ifdef VFMW_VPSS_BYPASS_EN
//add by l00228308 for smmu ion memory map
static HI_S32 channel_ion_map_viraddr(OMXVDEC_ION_BUF_S *pIonBuf)
{
    HI_U8* pu8VirAddr = HI_NULL;
    struct dma_buf* bufHhd = HI_NULL;
	if (pIonBuf == HI_NULL)
	{
	   OmxPrint(OMX_FATAL, "input null parm\n");
	   return HI_FAILURE;
	}

    bufHhd = dma_buf_get(pIonBuf->BufFd);

	if ( HI_NULL == bufHhd)
	{
		OmxPrint(OMX_FATAL,"%s dma_buf_get failed!\n", __func__);
	    return HI_FAILURE;
	}
	if (HI_SUCCESS != dma_buf_begin_cpu_access(bufHhd, 0, 0, 0))
	{
		OmxPrint(OMX_FATAL,"%s dmabuf map failed!\n", __func__);
		goto err;
	}

    pu8VirAddr = dma_buf_kmap(bufHhd,0 /*Offset*/);
	if (pu8VirAddr == HI_NULL)
	{
	   OmxPrint(OMX_FATAL,"dma_buf_get return HI_NULL!! fd = 0x%x\n",pIonBuf->BufFd);
	   goto err1;
	}

	pIonBuf->pu8DmaBuf = (HI_U8*)bufHhd;
	pIonBuf->pu8StartVirAddr = pu8VirAddr;

    OmxPrint(OMX_INFO, "map success!!! dmabuf = %p, pu8VirAddr = %p\n", bufHhd, pu8VirAddr);

	return HI_SUCCESS;

err1:
	dma_buf_end_cpu_access(bufHhd, 0, 0, 0);
err:
	dma_buf_put(bufHhd);
	return HI_FAILURE;
}

static HI_VOID channel_ion_unmap_viraddr(OMXVDEC_ION_BUF_S *pIonBuf)
{
    struct dma_buf* bufHhd = HI_NULL;

	if (pIonBuf == HI_NULL)
	{
	   OmxPrint(OMX_FATAL,"input null parm\n");
	   return ;
	}

    bufHhd = (struct dma_buf*)pIonBuf->pu8DmaBuf;

    dma_buf_kunmap(bufHhd,0,0);

	dma_buf_end_cpu_access(bufHhd, 0, 0, 0);

	dma_buf_put(bufHhd);

	return ;
}
//add end
#endif

static OMXVDEC_BUF_S *channel_lookup_addr_table(OMXVDEC_CHAN_CTX *pchan, OMXVDEC_BUF_DESC *puser_buf)
{
	HI_S32         i = 0;
    HI_S32        *num_of_buffers = HI_NULL;
	HI_U32        tmp_addr        = 0;
	OMXVDEC_BUF_S *buf_addr_table = HI_NULL;

	if (HI_NULL == pchan || HI_NULL == puser_buf)
    {
        OmxPrint(OMX_FATAL, "%s param invalid!\n", __func__);
		return HI_NULL;
	}

	if (puser_buf->dir == PORT_DIR_INPUT)
    {
		buf_addr_table = (OMXVDEC_BUF_S *)pchan->in_buf_table;
		num_of_buffers = &pchan->input_buf_num;
	}
    else if (puser_buf->dir == PORT_DIR_OUTPUT)
    {
        buf_addr_table = (OMXVDEC_BUF_S *)pchan->out_buf_table;
        num_of_buffers = &pchan->output_buf_num;
    }
    else
    {
        OmxPrint(OMX_ERR, "%s buf dir invalid!\n", __func__);
        return HI_NULL;
    }

	for (i = 0; i < *num_of_buffers; i++)
    {
        tmp_addr = buf_addr_table[i].phy_addr;
        if (puser_buf->phyaddr == tmp_addr)
        {
            break;
        }
    }

    if (i < *num_of_buffers)
    {
	    // in alloc usr path, insert in table before map user addr, so update user addr here
        buf_addr_table[i].user_vaddr = (HI_VOID *)puser_buf->bufferaddr;
        return &buf_addr_table[i];
    }

    OmxPrint(OMX_ERR, "%s buffer(0x%08x) not found!\n", __func__, puser_buf->phyaddr);

	return HI_NULL;
}

static HI_U32 channel_insert_addr_table(OMXVDEC_CHAN_CTX *pchan, OMXVDEC_BUF_DESC *puser_buf)
{
	HI_S32   i = 0;
	HI_VOID *kern_vaddr     = HI_NULL;
	HI_U32   phyaddr        = 0;
	HI_S32  *num_of_buffers = HI_NULL;

	OMXVDEC_BUF_S *buf_addr_table;
	OMXVDEC_BUF_S *pbuf;

	if (puser_buf->dir == PORT_DIR_INPUT)
    {
        OmxPrint(OMX_INBUF, "Insert Input Buffer, phy addr = 0x%08x\n", puser_buf->phyaddr);
        buf_addr_table = (OMXVDEC_BUF_S *)pchan->in_buf_table;
        num_of_buffers = &pchan->input_buf_num;

        if (*num_of_buffers >= pchan->max_in_buf_num)
        {
            OmxPrint(OMX_ERR, "%s: number of buffers reached max in value(%d)\n", __func__, pchan->max_in_buf_num);
            return HI_FAILURE;
        }
    }
    else if (puser_buf->dir == PORT_DIR_OUTPUT)
    {
        OmxPrint(OMX_OUTBUF, "Insert Output Buffer, phy addr = 0x%08x\n", puser_buf->phyaddr);
        buf_addr_table = (OMXVDEC_BUF_S *)pchan->out_buf_table;
        num_of_buffers = &pchan->output_buf_num;

        if (*num_of_buffers >= pchan->max_out_buf_num)
        {
            OmxPrint(OMX_ERR, "%s: number of buffers reached max out value(%d)\n", __func__, pchan->max_out_buf_num);
            return HI_FAILURE;
        }
    }
    else
    {
        OmxPrint(OMX_ERR, "%s: Buffer dir(%d) Invalid!\n", __func__, puser_buf->dir);
		return HI_FAILURE;
	}

	phyaddr = puser_buf->phyaddr;
	i = 0;
	while ((i < *num_of_buffers) && (phyaddr != buf_addr_table[i].phy_addr))
    {
        i++;
    }

	if (i < *num_of_buffers)
    {
        OmxPrint(OMX_ERR, "%s: phyaddr = 0x%x already insert\n", __func__, phyaddr);
        return HI_FAILURE;
    }

    // vir addr is not necessary for output buffer
	if (puser_buf->dir == PORT_DIR_INPUT)
    {
    	/* get kernel virtual address */
    	if (channel_map_kernel_viraddr(puser_buf, &kern_vaddr) != HI_SUCCESS)
        {
            OmxPrint(OMX_FATAL, "%s: get_addr failed (phyaddr: 0x%x)\n", __func__, phyaddr);
    		return HI_FAILURE;
    	}
    }

	pbuf              = buf_addr_table + *num_of_buffers;
	pbuf->user_vaddr  = (HI_VOID *)puser_buf->bufferaddr;
	pbuf->phy_addr    = puser_buf->phyaddr;
	pbuf->private_phy_addr = puser_buf->private_phyaddr;
	pbuf->kern_vaddr  = kern_vaddr;
	pbuf->client_data = (HI_VOID *)puser_buf->client_data;
	pbuf->buf_len     = puser_buf->buffer_len;
	pbuf->act_len     = 0;
	pbuf->private_len = puser_buf->private_len;
	pbuf->offset      = 0;
    pbuf->buf_type    = puser_buf->buffer_type;
    pbuf->status      = BUF_STATE_IDLE;
	pbuf->buf_id      = *num_of_buffers;

	*num_of_buffers += 1;

	if (puser_buf->dir == PORT_DIR_INPUT)
    {
        OmxPrint(OMX_INBUF, "Insert Input Buffer, PhyAddr = 0x%08x, Success!\n", puser_buf->phyaddr);
    }
    else
    {
        if (pbuf->private_phy_addr == 0xffffffff || pbuf->private_phy_addr == 0)
        {
            pchan->is_overaly = HI_FALSE;
        }
        else
        {
            pchan->is_overaly = HI_TRUE;
        }

        OmxPrint(OMX_OUTBUF, "Insert Output Buffer, PhyAddr = 0x%08x, Success!\n", puser_buf->phyaddr);

    }

#ifdef VFMW_VPSS_BYPASS_EN
    if (HI_TRUE == pchan->is_overaly && puser_buf->dir == PORT_DIR_OUTPUT)
    {
        HI_S32 s32Ret = HI_FAILURE;
		OMXVDEC_ION_BUF_S stOmxVdecMetaPriv;
        memset(&stOmxVdecMetaPriv, 0, sizeof(OMXVDEC_ION_BUF_S));

		stOmxVdecMetaPriv.BufFd = puser_buf->private_fd;
		stOmxVdecMetaPriv.u32Offset = puser_buf->private_offset;

        s32Ret = channel_ion_map_viraddr(&stOmxVdecMetaPriv);
		if (s32Ret != HI_SUCCESS)
		{
		    OmxPrint(OMX_ERR,"channel_ion_map_viraddr fd = 0x%x, phyaddr = 0x%x,failed!\n",puser_buf->private_fd,puser_buf->phyaddr);
		}

		pbuf->private_vaddr = (HI_VOID*)stOmxVdecMetaPriv.pu8StartVirAddr + stOmxVdecMetaPriv.u32Offset;

		memcpy(&pbuf->Buf_meta_priv, &stOmxVdecMetaPriv, sizeof(OMXVDEC_ION_BUF_S));
    }
	else
	{
	    pbuf->private_vaddr = HI_NULL;
	}
#endif

	return HI_SUCCESS;
}

static HI_U32 channel_delete_addr_table(OMXVDEC_CHAN_CTX *pchan, OMXVDEC_BUF_DESC *puser_buf)
{
	HI_U32 i            = 0;
	HI_S32 is_find      = 0;
	HI_U32 phyaddr      = 0;
	unsigned long flags = 0;
    spinlock_t        *p_lock         = HI_NULL;
	HI_U32            *num_of_buffers = HI_NULL;
	OMXVDEC_BUF_S     *ptmp           = HI_NULL;
	OMXVDEC_BUF_S     *pbuf           = HI_NULL;
	struct list_head  *p_queue        = HI_NULL;
	OMXVDEC_BUF_S     *p_qbuf         = HI_NULL;
	OMXVDEC_BUF_S     *buf_addr_table = HI_NULL;

	if (puser_buf->dir == PORT_DIR_INPUT)
    {
        OmxPrint(OMX_INBUF, "Delete Input Buffer, phy addr = 0x%08x\n", puser_buf->phyaddr);
        buf_addr_table = pchan->in_buf_table;
        num_of_buffers = &pchan->input_buf_num;
        p_lock = &pchan->raw_lock;
        p_queue = &pchan->raw_queue;
	}
    else if (puser_buf->dir == PORT_DIR_OUTPUT)
	{
        OmxPrint(OMX_OUTBUF, "Delete Input Buffer, phy addr = 0x%08x\n", puser_buf->phyaddr);
        buf_addr_table = pchan->out_buf_table;
        num_of_buffers = &pchan->output_buf_num;
        p_lock = &pchan->yuv_lock;
        p_queue = &pchan->yuv_queue;
	}

	if (HI_NULL == num_of_buffers || HI_NULL == buf_addr_table || HI_NULL == p_lock || HI_NULL == p_queue)
    {
        OmxPrint(OMX_ERR, "%s Table is empty!!\n", __func__);
		return HI_FAILURE;
	}

	phyaddr = puser_buf->phyaddr;
	while ((i < *num_of_buffers) && (phyaddr != buf_addr_table[i].phy_addr))
    {
        i++;
    }

	if (i == *num_of_buffers)
    {
        OmxPrint(OMX_ERR, "%s: phyaddr = 0x%x not found", __func__, phyaddr);
        return HI_FAILURE;
	}

	pbuf = &buf_addr_table[i];

	if (BUF_STATE_USING == pbuf->status)
    {
        OmxPrint(OMX_ERR, "WARN: buffer 0x%x still in use?!\n", phyaddr);
        //return HI_FAILURE;   //not exit, force continue
	}

	if (puser_buf->dir == PORT_DIR_INPUT)
    {
        /* unmap kernel virtual address */
        channel_unmap_kernel_viraddr(pbuf);
    }

    pbuf->kern_vaddr = HI_NULL;

#ifdef VFMW_VPSS_BYPASS_EN
    if ((HI_NULL != pbuf->private_vaddr) && (HI_TRUE == pchan->is_overaly))
    {
        /* unmap kernel virtual address */
        channel_ion_unmap_viraddr(&pbuf->Buf_meta_priv);
		pbuf->private_vaddr = HI_NULL;
    }
#endif

	if (i < (*num_of_buffers - 1))
    {
        /* copy into new addr slot */
        memcpy(pbuf, &buf_addr_table[*num_of_buffers - 1], sizeof(OMXVDEC_BUF_S));
        pbuf->buf_id = i;

        spin_lock_irqsave(p_lock, flags);
        if (!list_empty(p_queue))
        {
			list_for_each_entry_safe(p_qbuf, ptmp, p_queue, list)
			{
				if (buf_addr_table[*num_of_buffers - 1].phy_addr == (p_qbuf->phy_addr))
				{
					is_find = 1;
					/* delete old node in list */
					list_del(&p_qbuf->list);
					break;
				}
			}

			/* insert new node into list */
			if (is_find)
			{
				list_add_tail(&pbuf->list, p_queue);
			}
		}
		spin_unlock_irqrestore(p_lock, flags);
    }

    memset(&buf_addr_table[*num_of_buffers - 1], 0, sizeof(OMXVDEC_BUF_S));
	*num_of_buffers = *num_of_buffers - 1;

	if (puser_buf->dir == PORT_DIR_INPUT)
    {
        OmxPrint(OMX_INBUF, "Delete Input Buffer, phy addr = 0x%08x, Done!\n", puser_buf->phyaddr);
    }
    else
    {
        OmxPrint(OMX_OUTBUF, "Delete Output Buffer, phy addr = 0x%08x, Done!\n", puser_buf->phyaddr);
    }

	return HI_SUCCESS;
}

HI_S32 channel_insert_in_raw_list(OMXVDEC_CHAN_CTX *pchan, OMXVDEC_BUF_S *pstream)
{
	HI_S32 is_find = 0;
	unsigned long  flags;
	OMXVDEC_BUF_S *pbuf = HI_NULL;

    spin_lock_irqsave(&pchan->raw_lock, flags);
    if (!(list_empty(&pchan->raw_queue)))
    {
        list_for_each_entry(pbuf, &pchan->raw_queue, list)
        {
            if (pstream->phy_addr == pbuf->phy_addr)
            {
                is_find = 1;
                break;
            }
        }

        if (is_find)
        {
            OmxPrint(OMX_ERR, "0x%x already in raw list!\n", pstream->phy_addr);
            spin_unlock_irqrestore(&pchan->raw_lock, flags);
            return HI_FAILURE;
        }
    }

    OmxPrint(OMX_INBUF, "Empty this buffer, phyaddr: 0x%08x, data_len: %d\n", pstream->phy_addr, pstream->act_len);

    /* insert the stream packet to raw queue */
    pstream->status = BUF_STATE_QUEUED;
    list_add_tail(&pstream->list, &pchan->raw_queue);

    spin_unlock_irqrestore(&pchan->raw_lock, flags);

    return HI_SUCCESS;
}

HI_S32 channel_insert_in_yuv_list(OMXVDEC_CHAN_CTX *pchan, OMXVDEC_BUF_S *pframe)
{
	HI_S32 is_find = 0;
	unsigned long  flags;
	OMXVDEC_BUF_S *pbuf = HI_NULL;

    spin_lock_irqsave(&pchan->yuv_lock, flags);
    if (!(list_empty(&pchan->yuv_queue)))
    {
        list_for_each_entry(pbuf, &pchan->yuv_queue, list)
        {
            if (pframe->phy_addr == pbuf->phy_addr)
            {
                is_find = 1;
                break;
            }
        }

        if (is_find)
        {
            OmxPrint(OMX_ERR, "0x%x already in yuv list!\n", pframe->phy_addr);
            spin_unlock_irqrestore(&pchan->yuv_lock, flags);
            return HI_FAILURE;
        }
    }

	OmxPrint(OMX_OUTBUF, "Fill this buffer, phyaddr:0x%08x\n", pframe->phy_addr);

	pframe->status = BUF_STATE_QUEUED;
	list_add_tail(&pframe->list, &pchan->yuv_queue);

	spin_unlock_irqrestore(&pchan->yuv_lock, flags);

    return HI_SUCCESS;
}

static HI_S32 channel_add_last_frame(OMXVDEC_CHAN_CTX *pchan, OMXVDEC_BUF_S *pstream)
{
    if (HI_NULL == pchan || HI_NULL == pstream)
    {
        OmxPrint(OMX_ERR, "%s param invalid!\n", __func__);
        return HI_FAILURE;
    }

    pstream->act_len    = pstream->buf_len;
    pstream->offset     = 0;
    pstream->flags      = VDEC_BUFFERFLAG_ENDOFFRAME;
    pstream->time_stamp = HI_INVALID_PTS;
    pstream->buf_id     = LAST_FRAME_BUF_ID;

    return HI_SUCCESS;
}

#if (!defined(HI_OMX_TEE_SUPPORT) && !defined(HI_ADVCA_FUNCTION_RELEASE))

static HI_S32 channel_save_stream(OMXVDEC_CHAN_CTX *pchan, OMXVDEC_BUF_S *pstream)
{
    HI_S32        len = 0;
    mm_segment_t  oldfs;
    HI_CHAR       FilePath[PATH_LEN];

    if (HI_TRUE == g_SaveRawEnable && pchan->raw_file == HI_NULL)
    {
        snprintf(FilePath, sizeof(FilePath), "%s/%s_%d_%d.raw", g_SavePath, g_SaveName, g_SaveNum, pchan->channel_id);
        pchan->raw_file = filp_open(FilePath, O_RDWR|O_CREAT|O_TRUNC, S_IRWXO);
        if (IS_ERR(pchan->raw_file))
        {
            OmxPrint(OMX_ERR, "%s open raw file %s failed, ret=%ld\n", __func__, FilePath, PTR_ERR(pchan->raw_file));
            pchan->raw_file = HI_NULL;
        }
        else
        {
            OmxPrint(OMX_ALWS, "Start to save raw data of inst_%d in %s\n", pchan->channel_id, FilePath);
        }
    }
    else if (HI_FALSE == g_SaveRawEnable && pchan->raw_file != HI_NULL)
    {
        filp_close(pchan->raw_file, HI_NULL);
        pchan->raw_file = HI_NULL;
        OmxPrint(OMX_ALWS, "Stop saving raw data of inst_%d.\n", pchan->channel_id);
    }
    if (pchan->raw_file != HI_NULL)
    {
        oldfs = get_fs();
        set_fs(KERNEL_DS);
        len = pchan->raw_file->f_op->write(pchan->raw_file, pstream->kern_vaddr, pstream->act_len, &pchan->raw_file->f_pos);
        set_fs(oldfs);
        OmxPrint(OMX_ALWS, "Saving raw data of inst_%d, length = %d\n", pchan->channel_id, pstream->act_len);
    }

    return HI_SUCCESS;
}
#endif

/*============== EXPORT INTERFACE =============*/
HI_S32 channel_init(HI_VOID)
{
    HI_S32 ret = HI_FAILURE;

    OmxPrint(OMX_TRACE, "%s %d\n", __func__, __LINE__);

    ret = decoder_init();
    if (ret != HI_SUCCESS)
    {
        OmxPrint(OMX_FATAL, "%s init decoder failed!\n", __func__);
        return HI_FAILURE;
    }

    ret = processor_init();
    if (ret != HI_SUCCESS)
    {
        ret = decoder_exit();
        if (ret != HI_SUCCESS)
        {
            OmxPrint(OMX_FATAL, "%s exit decoder failed!\n", __func__);
        }
        OmxPrint(OMX_FATAL, "%s init processor failed!\n", __func__);
        return HI_FAILURE;
    }

    OmxPrint(OMX_TRACE, "%s exit normally!\n", __func__);

    return HI_SUCCESS;
}

HI_VOID channel_exit(HI_VOID)
{
    HI_S32 ret = HI_FAILURE;

    OmxPrint(OMX_TRACE, "%s %d\n", __func__, __LINE__);

    ret = decoder_exit();
    if (ret != HI_SUCCESS)
    {
        OmxPrint(OMX_FATAL, "%s exit decoder failed!\n", __func__);
    }

    ret = processor_exit();
    if (ret != HI_SUCCESS)
    {
        OmxPrint(OMX_FATAL, "%s exit processor failed!\n", __func__);
    }

    OmxPrint(OMX_TRACE, "%s exit normally!\n", __func__);

    return;
}

HI_S32 channel_create_inst(struct file *fd, OMXVDEC_DRV_CFG *pcfg)
{
	HI_S32 ret = 0;
    HI_U32 TableSize;
    HI_U32 TotalSize;
	unsigned long flags;
	OMXVDEC_CHAN_CTX *pchan   = HI_NULL;
	OMXVDEC_ENTRY    *omxvdec = HI_NULL;
    //MMZ_BUFFER_S      TmpBuf;

	OmxPrint(OMX_TRACE, "%s enter!\n", __func__);

    /* Get omxvdec */
    omxvdec = fd->private_data;
    if (HI_NULL == omxvdec)
    {
	    OmxPrint(OMX_FATAL, "%s: omxvdec = null, error!\n", __func__);
	    return HI_FAILURE;
    }


    /* Alloc context */
/*    memset(&TmpBuf, 0, sizeof(MMZ_BUFFER_S));
    ret = HI_DRV_OMXVDEC_AllocAndMap("OMXVDEC", HI_NULL, sizeof(OMXVDEC_CHAN_CTX), 0, &TmpBuf);
    if (ret != HI_SUCCESS)
    {
        OmxPrint(OMX_FATAL, "%s alloc pchan mem failed\n", __func__);
		return HI_FAILURE;
    }
    pchan = (OMXVDEC_CHAN_CTX *)TmpBuf.pu8StartVirAddr;
    memset(pchan, 0, sizeof(OMXVDEC_CHAN_CTX));
    memcpy(&pchan->channel_buf, &TmpBuf, sizeof(MMZ_BUFFER_S));
    pchan->eChanMemAlloc         = ALLOC_BY_MMZ;
*/


    /* Alloc context */
	pchan = kzalloc(sizeof(OMXVDEC_CHAN_CTX), GFP_KERNEL);
    if (ret != HI_SUCCESS)
    {
        OmxPrint(OMX_FATAL, "%s kzalloc ctx failed!\n", __func__);

        return HI_FAILURE;
    }



    /* Initialize ctx resource */
    VDEC_INIT_MUTEX(&pchan->chan_mutex);
	spin_lock_init(&pchan->chan_lock);
	spin_lock_init(&pchan->raw_lock);
	spin_lock_init(&pchan->yuv_lock);
	spin_lock_init(&pchan->dfs.dfs_lock);

	INIT_LIST_HEAD(&pchan->chan_list);
	INIT_LIST_HEAD(&pchan->raw_queue);
	INIT_LIST_HEAD(&pchan->yuv_queue);

    VDEC_DOWN_INTERRUPTIBLE(&pchan->chan_mutex);

	pchan->vdec     = omxvdec;
    pchan->file_dec = (HI_U32*)fd;
#ifdef HI_OMX_TEE_SUPPORT
    pchan->is_tvp = pcfg->is_tvp;
#endif

	/* Record this channel */
	ret = channel_add_chan_record(omxvdec, pchan);
    if (ret != HI_SUCCESS)
    {
        OmxPrint(OMX_FATAL, "%s add chan record failed\n", __func__);
		goto cleanup0;
    }

    /* Initialize msg queue */
	pchan->msg_queue = message_queue_init(QUEUE_DEFAULT_DEPTH);
	if (HI_NULL == pchan->msg_queue)
    {
        OmxPrint(OMX_FATAL, "%s call msg_queue_init failed!\n", __func__);
		goto cleanup1;
	}

    pchan->bLowdelay = pcfg->chan_cfg.s32LowdlyEnable;
    pchan->m_use_native_buf = pcfg->m_use_native_buf;

    /* Create decoder */
    channel_show_chan_config(pcfg);
    pchan->out_width  = pcfg->cfg_width;
    pchan->out_height = pcfg->cfg_height;
	pchan->out_stride = pcfg->cfg_stride;
	ret = decoder_create_inst(pchan, pcfg);
	if (ret != HI_SUCCESS)
    {
        OmxPrint(OMX_FATAL, "%s call channel_create_with_vfmw failed!\n", __func__);
		goto cleanup2;
	}
    pchan->rotation = pcfg->cfg_rotation;

    if ((STD_VP6 == pcfg->chan_cfg.eVidStd) || (STD_VP6F == pcfg->chan_cfg.eVidStd) || (STD_VP6A == pcfg->chan_cfg.eVidStd))
    {
        pchan->bReversed = pcfg->chan_cfg.StdExt.Vp6Ext.bReversed;
    }
    else
    {
        pchan->bReversed = 0;
    }


    /* Create processor */
    ret = processor_create_inst(pchan, pcfg->cfg_color_format);
	if (ret != HI_SUCCESS)
    {
        OmxPrint(OMX_FATAL, "%s call channel_create_with_vpss failed!\n", __func__);
		goto cleanup3;
	}

    /* Get memory resource */
#ifdef HI_OMX_TEE_SUPPORT
    if (HI_TRUE == pchan->is_tvp)
    {
        TableSize = (pcfg->cfg_inbuf_num+pcfg->cfg_outbuf_num)*sizeof(OMXVDEC_BUF_S);
        TotalSize = TableSize;

        ret = HI_DRV_OMXVDEC_AllocAndMap("OMXVDEC_EXTRA", HI_NULL, TotalSize, 0, &pchan->channel_extra_buf);
        if (ret != HI_SUCCESS)
        {
            OmxPrint(OMX_FATAL, "%s alloc extra buffer mem failed\n", __func__);
            goto cleanup4;
        }

        pchan->in_buf_table        = (HI_VOID *)(pchan->channel_extra_buf.pu8StartVirAddr);
        pchan->out_buf_table       = pchan->in_buf_table + pcfg->cfg_inbuf_num*sizeof(OMXVDEC_BUF_S);
        pchan->max_in_buf_num      = pcfg->cfg_inbuf_num;
        pchan->max_out_buf_num     = pcfg->cfg_outbuf_num;
        pchan->eEXTRAMemAlloc      = ALLOC_BY_MMZ;

        ret = HI_DRV_OMXVDEC_Alloc("SEC_OMXVDEC_LAST_FRAME", HI_NULL, LAST_FRAME_BUF_SIZE, 4, &pchan->decoder_eos_buf, 1);
        if (HI_SUCCESS != ret)
        {
            OmxPrint(OMX_FATAL, "%s alloc sec last frame mem failed\n", __func__);
            omxvdec_release_mem(&pchan->channel_extra_buf, pchan->eEXTRAMemAlloc);
            goto cleanup4;
        }

        pchan->last_frame.kern_vaddr   = (HI_VOID *)(HI_SIZE_T)pchan->decoder_eos_buf.pu8StartVirAddr;
		pchan->last_frame.phy_addr     = pchan->decoder_eos_buf.u32StartPhyAddr;
        pchan->last_frame.buf_len      = pchan->decoder_eos_buf.u32Size;
        pchan->last_frame.u32FrameRate = 30000;
        pchan->eEOSMemAlloc            = ALLOC_BY_SEC;
    }
    else
#endif
    {
        TableSize = (pcfg->cfg_inbuf_num+pcfg->cfg_outbuf_num)*sizeof(OMXVDEC_BUF_S);
        TotalSize = LAST_FRAME_BUF_SIZE + 16 + TableSize;  // +16 for gap
        ret = HI_DRV_OMXVDEC_AllocAndMap("OMXVDEC_EXTRA", HI_NULL, TotalSize, 0, &pchan->channel_extra_buf);
        if (ret != HI_SUCCESS)
        {
            OmxPrint(OMX_FATAL, "%s alloc extra buffer mem failed\n", __func__);
    		goto cleanup4;
        }

        pchan->last_frame.phy_addr   = pchan->channel_extra_buf.u32StartPhyAddr;
        pchan->last_frame.kern_vaddr = (HI_VOID*)pchan->channel_extra_buf.pu8StartVirAddr;
        pchan->last_frame.buf_len    = LAST_FRAME_BUF_SIZE;
        pchan->last_frame.u32FrameRate = 30000;

        pchan->in_buf_table          = (HI_VOID *)(pchan->channel_extra_buf.pu8StartVirAddr + LAST_FRAME_BUF_SIZE + 16);
        pchan->out_buf_table         = pchan->in_buf_table + pcfg->cfg_inbuf_num*sizeof(OMXVDEC_BUF_S);
        pchan->max_in_buf_num        = pcfg->cfg_inbuf_num;
        pchan->max_out_buf_num       = pcfg->cfg_outbuf_num;
        pchan->eEXTRAMemAlloc        = ALLOC_BY_MMZ;
        pchan->omx_vdec_lowdelay_proc_rec = NULL;
        if(pchan->bLowdelay || g_FastOutputMode)
        {
            pchan->omx_vdec_lowdelay_proc_rec = kzalloc(sizeof(OMXVDEC_LOWDELAY_PROC_RECORD), GFP_KERNEL);
            if (HI_NULL == pchan->omx_vdec_lowdelay_proc_rec)
            {
                OmxPrint(OMX_FATAL, "%s kzalloc lowdelay_proc_rec failed!\n", __func__);
            }
            else
            {
                pchan->omx_vdec_lowdelay_proc_rec->usrtag_start_time = (OMX_GetTimeInMs()) & 0xFF;
                pchan->omx_vdec_lowdelay_proc_rec->interval          = ((OMX_GetTimeInMs()) & 0xF) + 1;
            }
        }
    }
    OMX_PTSREC_Alloc(pchan->channel_id);
	spin_lock_irqsave(&pchan->chan_lock, flags);
	pchan->state = CHAN_STATE_IDLE;
	spin_unlock_irqrestore(&pchan->chan_lock, flags);

    VDEC_UP_INTERRUPTIBLE(&pchan->chan_mutex);

	OmxPrint(OMX_TRACE, "%s exit normally!\n", __func__);

	return pchan->channel_id;

cleanup4:
	processor_release_inst(pchan);
cleanup3:
	decoder_release_inst(pchan);
cleanup2:
	message_queue_deinit(pchan->msg_queue);
cleanup1:
	channel_delete_chan_record(omxvdec, pchan);
cleanup0:
    VDEC_UP_INTERRUPTIBLE(&pchan->chan_mutex);

	kfree(pchan);
    pchan = HI_NULL;

	return HI_FAILURE;
}

HI_S32 channel_release_inst(OMXVDEC_CHAN_CTX *pchan)
{
    HI_U32 i;
    HI_S32 ret = HI_FAILURE;
	unsigned long flags;
	eCHAN_STATE state;
	OMXVDEC_BUF_S *pbuf    = HI_NULL;
	OMXVDEC_ENTRY *omxvdec = HI_NULL;
    MMZ_BUFFER_S stBuffer;
    memset(&stBuffer, 0, sizeof(MMZ_BUFFER_S));

    OmxPrint(OMX_TRACE, "%s enter!\n", __func__);

	if (HI_NULL == pchan)
	{
        OmxPrint(OMX_FATAL, "%s pchan = NULL\n", __func__);
		return HI_FAILURE;
	}

    VDEC_DOWN_INTERRUPTIBLE(&pchan->chan_mutex);

    omxvdec = pchan->vdec;
	if (HI_NULL == omxvdec)
	{
        OmxPrint(OMX_FATAL, "%s omxvdec = NULL\n", __func__);
        VDEC_UP_INTERRUPTIBLE(&pchan->chan_mutex);
		return HI_FAILURE;
	}
    if (HI_TRUE == g_LowDelayStatistics)
    {
        HI_HANDLE hHandle = 0;
        hHandle = (HI_ID_VDEC << 16) | pchan->channel_id;
        ret = (pVfmwFunc->pfnVfmwControl)(pchan->decoder_id, VDEC_CID_STOP_LOWDLAY_CALC, &hHandle);
        if (HI_SUCCESS != ret)
        {
            OmxPrint(OMX_FATAL, "%s call VDEC_CID_STOP_LOWDLAY_CALC failed, ret = %d!\n", __func__, ret);
            VDEC_UP_INTERRUPTIBLE(&pchan->chan_mutex);
            return HI_FAILURE;
        }
        HI_DRV_LD_Stop_Statistics();
    }

	spin_lock_irqsave(&pchan->chan_lock, flags);
	state = pchan->state;
	spin_unlock_irqrestore(&pchan->chan_lock, flags);

	if (state == CHAN_STATE_WORK || state == CHAN_STATE_PAUSE)
    {
		if (decoder_stop_inst(pchan) < 0)
        {
            OmxPrint(OMX_FATAL, "%s call channel_stop_with_vfmw failed!\n", __func__);
		}

        if (processor_stop_inst(pchan) < 0)
        {
            OmxPrint(OMX_FATAL, "%s call channel_stop_with_vpss failed!\n", __func__);
        }

		/*check if the msg queue read out*/
		spin_lock_irqsave(&pchan->chan_lock, flags);
		pchan->state = CHAN_STATE_IDLE;
		spin_unlock_irqrestore(&pchan->chan_lock, flags);
	}

	if (processor_release_inst(pchan) < 0)
    {
        OmxPrint(OMX_FATAL, "%s call channel_release_with_vpss failed!\n", __func__);
	}

	if (decoder_release_inst(pchan) < 0)
    {
        OmxPrint(OMX_FATAL, "%s call channel_release_with_vfmw failed!\n", __func__);
	}

    for (i=0; i<pchan->max_in_buf_num; i++)
    {
       pbuf = &((OMXVDEC_BUF_S *)(pchan->in_buf_table))[i];
       if (BUF_STATE_INVALID != pbuf->status)
       {
           stBuffer.u32StartPhyAddr = pbuf->phy_addr;
           stBuffer.pu8StartVirAddr = (HI_U8*)pbuf->kern_vaddr;
           HI_DRV_OMXVDEC_Unmap(&stBuffer);
       }
    }

    for (i=0; i<pchan->max_out_buf_num; i++)
    {
       pbuf = &((OMXVDEC_BUF_S *)(pchan->out_buf_table))[i];
       if (BUF_STATE_INVALID != pbuf->status)
       {
           stBuffer.u32StartPhyAddr = pbuf->phy_addr;
           stBuffer.pu8StartVirAddr = (HI_U8*)pbuf->kern_vaddr;
           HI_DRV_OMXVDEC_Unmap(&stBuffer);
       }

    }

    if (pchan->raw_file != HI_NULL)
    {
        filp_close(pchan->raw_file, HI_NULL);
        pchan->raw_file = HI_NULL;
    }

    omxvdec_release_mem(&pchan->channel_extra_buf, pchan->eEXTRAMemAlloc);

    //sec:will release  N-sec:the structure is empty,will NOT release acturelly
    omxvdec_release_mem(&pchan->decoder_eos_buf, pchan->eEOSMemAlloc);

	message_queue_deinit(pchan->msg_queue);

	spin_lock_irqsave(&pchan->chan_lock, flags);
	pchan->state = CHAN_STATE_INVALID;
	spin_unlock_irqrestore(&pchan->chan_lock, flags);

    /* Free pts recover channel */
    OMX_PTSREC_Free(pchan->channel_id);

	channel_delete_chan_record(omxvdec, pchan);
    if((pchan->bLowdelay || g_FastOutputMode) && (pchan->omx_vdec_lowdelay_proc_rec != NULL))
    {
        kfree(pchan->omx_vdec_lowdelay_proc_rec);
    }

    VDEC_UP_INTERRUPTIBLE(&pchan->chan_mutex);

	kfree(pchan);
	pchan = HI_NULL;

    OmxPrint(OMX_TRACE, "%s exit normally!\n", __func__);

	return HI_SUCCESS;
}

HI_S32 channel_start_inst(OMXVDEC_CHAN_CTX *pchan)
{
	unsigned long flags;
	HI_S32 ret    = HI_FAILURE;
	HI_U32 status = VDEC_S_FAILED;

	OmxPrint(OMX_TRACE, "%s enter!\n", __func__);

	spin_lock_irqsave(&pchan->chan_lock, flags);
	if (pchan->state == CHAN_STATE_WORK)
    {
		spin_unlock_irqrestore(&pchan->chan_lock, flags);
        OmxPrint(OMX_ERR, "%s already in work state!\n", __func__);
		goto error;
	}
    if((pchan->bLowdelay || g_FastOutputMode) && (pchan->omx_vdec_lowdelay_proc_rec != NULL))
    {
        pchan->omx_vdec_lowdelay_proc_rec->current_tag   = pchan->omx_vdec_lowdelay_proc_rec->usrtag_start_time + \
                                                           pchan->omx_vdec_lowdelay_proc_rec->interval;
        pchan->omx_vdec_lowdelay_proc_rec->time_cost_sum         = 0;
        pchan->omx_vdec_lowdelay_proc_rec->average_time_cost     = 0;
        pchan->omx_vdec_lowdelay_proc_rec->rec_index             = 0;
        memset(pchan->omx_vdec_lowdelay_proc_rec->time_record, 0, sizeof(pchan->omx_vdec_lowdelay_proc_rec->time_record));
    }
	spin_unlock_irqrestore(&pchan->chan_lock, flags);

	ret = decoder_start_inst(pchan);
	if (ret != HI_SUCCESS)
    {
        OmxPrint(OMX_FATAL, "%s call decoder_start_inst failed!\n", __func__);
		goto error;
	}

	ret = processor_start_inst(pchan);
	if (ret != HI_SUCCESS)
    {
        ret = decoder_stop_inst(pchan);
        if (ret != HI_SUCCESS)
        {
            OmxPrint(OMX_FATAL, "%s call decoder_stop_inst failed!\n", __func__);
        }
        OmxPrint(OMX_FATAL, "%s call processor_start_inst failed!\n", __func__);
		goto error;
	}

    /* Start pts recover channel */
    OMX_PTSREC_Start(pchan->channel_id);

	spin_lock_irqsave(&pchan->chan_lock, flags);
	pchan->state = CHAN_STATE_WORK;
	spin_unlock_irqrestore(&pchan->chan_lock, flags);

	status = VDEC_S_SUCCESS;

	OmxPrint(OMX_TRACE, "%s exit normally!\n", __func__);

error:
	message_queue(pchan->msg_queue, VDEC_MSG_RESP_START_DONE, status, HI_NULL);
    OmxPrint(OMX_INFO, "%s post msg ret=%d,status=%d!\n", __func__, ret, status);

	return ret;
}

HI_S32 channel_stop_inst(OMXVDEC_CHAN_CTX *pchan)
{
	HI_S32 ret    = HI_FAILURE;
	HI_U32 status = VDEC_S_FAILED;
	unsigned long flags;

    OmxPrint(OMX_TRACE, "%s enter!\n", __func__);

	spin_lock_irqsave(&pchan->chan_lock, flags);
	if (pchan->state == CHAN_STATE_IDLE)
    {
		status = VDEC_ERR_BAD_STATE;
        OmxPrint(OMX_FATAL, "%s already stop!\n", __func__);
	}
    else
    {
		status = VDEC_S_SUCCESS;
	    pchan->state = CHAN_STATE_IDLE;
    }
	spin_unlock_irqrestore(&pchan->chan_lock, flags);

    // stop order is important!!
    if (VDEC_S_SUCCESS == status)
    {
        ret = decoder_stop_inst(pchan);
    	if (ret != HI_SUCCESS)
        {
    		status = VDEC_ERR_HW_FATAL;
            OmxPrint(OMX_FATAL, "%s call channel_stop_with_vfmw failed!\n", __func__);
    	}

    	ret = processor_stop_inst(pchan);
    	if (ret != HI_SUCCESS)
        {
    		status = VDEC_ERR_HW_FATAL;
            OmxPrint(OMX_FATAL, "%s call channel_stop_with_vpss failed!\n", __func__);
    	}

        /* Stop pts recover channel */
        OMX_PTSREC_Stop(pchan->channel_id);

        OmxPrint(OMX_TRACE, "%s exit normally!\n", __func__);
    	ret = HI_SUCCESS;
    }
    else
    {
        OmxPrint(OMX_INFO, "%s post msg ret=%d,status=%d!\n", __func__, ret, status);
    	ret = HI_FAILURE;
    }

    message_queue(pchan->msg_queue, VDEC_MSG_RESP_STOP_DONE, status, HI_NULL);

    return ret;
}

HI_S32 channel_reset_inst(OMXVDEC_CHAN_CTX *pchan)
{
    HI_S32 ret = HI_SUCCESS;

#ifdef VFMW_VPSS_BYPASS_EN
    SINT32 s32ImgOutputEn = 0;
#endif

    pchan->reset_pending = 1;

    ret = processor_reset_inst(pchan);
    if (ret != HI_SUCCESS)
    {
        OmxPrint(OMX_FATAL, "%s reset processor failed!\n", __func__);
    }

#ifdef VFMW_VPSS_BYPASS_EN
    ret = decoder_record_occoupied_frame(pchan);
    if (ret != HI_SUCCESS)
    {
       OmxPrint(OMX_FATAL, "%s record occoupied frame failed\n", __func__);
       //return ret;
    }

	VDEC_DOWN_INTERRUPTIBLE(&g_OmxVdec->stRemainFrmList.bypass_mutex);

	s32ImgOutputEn = 1;
    ret = (pVfmwFunc->pfnVfmwControl)( pchan->decoder_id, VDEC_CID_SET_IMG_OUTPUT_INFO, &s32ImgOutputEn);
    if (VDEC_OK != ret)
    {
        OmxPrint(OMX_INFO, "Chan %d VDEC_CID_SET_IMG_OUTPUT_INFO (enable = %d) err!\n",  pchan->decoder_id,s32ImgOutputEn);
    }

	VDEC_UP_INTERRUPTIBLE(&g_OmxVdec->stRemainFrmList.bypass_mutex);
#endif

    ret = decoder_reset_inst_with_option(pchan);
    if (ret != HI_SUCCESS)
    {
        OmxPrint(OMX_FATAL, "%s reset decoder failed!\n", __func__);
    }

    /* Reset pts recover channel */
    OMX_PTSREC_Reset(pchan->channel_id);

    pchan->reset_pending = 0;

    return ret;
}

HI_S32 channel_pause_inst(OMXVDEC_CHAN_CTX *pchan)
{
    HI_S32 post_msg = 0;
	unsigned long flags;

    OmxPrint(OMX_TRACE, "%s enter!\n", __func__);

	spin_lock_irqsave(&pchan->chan_lock, flags);
	if (pchan->state != CHAN_STATE_WORK)
    {
        spin_unlock_irqrestore(&pchan->chan_lock, flags);
        OmxPrint(OMX_ERR, "%s state != CHAN_STATE_WORK!\n", __func__);
        message_queue(pchan->msg_queue, VDEC_MSG_RESP_PAUSE_DONE, VDEC_ERR_BAD_STATE, HI_NULL);
		return HI_FAILURE;
	}

	pchan->state = CHAN_STATE_PAUSE;
	if (0 == pchan->yuv_use_cnt)
    {
        post_msg = 1;
    }
	else
    {
        pchan->pause_pending = 1;
    }
	spin_unlock_irqrestore(&pchan->chan_lock, flags);

	if (post_msg)
    {
        message_queue(pchan->msg_queue, VDEC_MSG_RESP_PAUSE_DONE, VDEC_S_SUCCESS, HI_NULL);
    }

    OmxPrint(OMX_TRACE, "%s exit normally!\n", __func__);

	return HI_SUCCESS;
}

HI_S32 channel_resume_inst(OMXVDEC_CHAN_CTX *pchan)
{
	unsigned long flags;

	OmxPrint(OMX_TRACE, "%s enter!\n", __func__);

	spin_lock_irqsave(&pchan->chan_lock, flags);
	if (pchan->state != CHAN_STATE_PAUSE)
    {
        spin_unlock_irqrestore(&pchan->chan_lock, flags);
        OmxPrint(OMX_FATAL, "%s state != CHAN_STATE_PAUSE!\n", __func__);
	    message_queue(pchan->msg_queue, VDEC_MSG_RESP_RESUME_DONE, VDEC_ERR_BAD_STATE, HI_NULL);
	    return HI_FAILURE;
	}

	/* bad state change */
	if (pchan->pause_pending)
    {
        pchan->pause_pending = 0;
    }

	pchan->state = CHAN_STATE_WORK;

	spin_unlock_irqrestore(&pchan->chan_lock, flags);

    message_queue(pchan->msg_queue, VDEC_MSG_RESP_RESUME_DONE, VDEC_S_SUCCESS, HI_NULL);

	OmxPrint(OMX_TRACE, "%s exit normally!\n", __func__);

	return HI_SUCCESS;
}

HI_S32 channel_bind_user_buffer(OMXVDEC_CHAN_CTX *pchan, OMXVDEC_BUF_DESC *puser_buf)
{
	HI_S32 ret = HI_FAILURE;

    OmxPrint(OMX_TRACE, "%s enter!\n", __func__);

	if (HI_NULL == pchan || HI_NULL == puser_buf || 0 == puser_buf->phyaddr)
    {
        OmxPrint(OMX_FATAL, "%s param invalid!\n", __func__);
		return HI_FAILURE;
	}

	ret = channel_insert_addr_table(pchan, puser_buf);
	if (ret != HI_SUCCESS)
    {
        OmxPrint(OMX_ERR, "%s call channel_insert_addr_table failed!\n", __func__);
		return HI_FAILURE;
	}

    OmxPrint(OMX_TRACE, "%s exit normally!\n", __func__);

	return HI_SUCCESS;
}

HI_S32 channel_unbind_user_buffer(OMXVDEC_CHAN_CTX *pchan, OMXVDEC_BUF_DESC *puser_buf)
{
	HI_S32 ret = HI_FAILURE;

    OmxPrint(OMX_TRACE, "%s enter!\n", __func__);

    if (HI_NULL == pchan || HI_NULL == puser_buf || 0 == puser_buf->phyaddr)
    {
        OmxPrint(OMX_FATAL, "%s param invalid!\n", __func__);
        return HI_FAILURE;
    }

	ret = channel_delete_addr_table(pchan, puser_buf);
	if (ret != HI_SUCCESS)
    {
        OmxPrint(OMX_FATAL, "%s call channel_delete_addr_table failed!\n", __func__);
		return HI_FAILURE;
	}

	OmxPrint(OMX_TRACE, "%s exit normally!\n", __func__);

	return HI_SUCCESS;
}

HI_S32 channel_empty_this_stream(OMXVDEC_CHAN_CTX *pchan, OMXVDEC_BUF_DESC *puser_buf)
{
	unsigned long  flags;
	HI_S32         ret     = HI_FAILURE;
	OMXVDEC_BUF_S *pstream = HI_NULL;

	OmxPrint(OMX_TRACE, "%s enter!\n", __func__);

	if (HI_NULL == pchan || HI_NULL == puser_buf)
    {
        OmxPrint(OMX_FATAL, "%s param invalid!\n", __func__);
    	return HI_FAILURE;
	}

    // only process buffer with valid data len
    if (puser_buf->data_len != 0)
    {
    	pstream = channel_lookup_addr_table(pchan, puser_buf);
    	if (HI_NULL == pstream)
        {
            OmxPrint(OMX_ERR, "%s call channel_lookup_addr_table failed!\n", __func__);
	        message_queue(pchan->msg_queue, VDEC_MSG_RESP_INPUT_DONE, VDEC_ERR_ILLEGAL_OP, (HI_VOID *)puser_buf);
    	    return HI_FAILURE;
    	}

        pstream->act_len    = puser_buf->data_len;
        pstream->offset     = puser_buf->data_offset;
        pstream->time_stamp = puser_buf->timestamp;
        pstream->flags      = puser_buf->flags;
        if((pchan->bLowdelay || g_FastOutputMode) && (NULL != pchan->omx_vdec_lowdelay_proc_rec))
        {
            pstream->usr_tag = pchan->omx_vdec_lowdelay_proc_rec->current_tag;
            pchan->omx_vdec_lowdelay_proc_rec->current_tag += pchan->omx_vdec_lowdelay_proc_rec->interval;
            channel_add_lowdelay_tag_time(pchan, pstream->usr_tag, OMX_LOWDELAY_REC_ETB_TIME, OMX_GetTimeInMs());
        }

        ret = channel_insert_in_raw_list(pchan, pstream);
        if (ret != HI_SUCCESS)
        {
	        message_queue(pchan->msg_queue, VDEC_MSG_RESP_INPUT_DONE, VDEC_ERR_ILLEGAL_OP, (HI_VOID *)puser_buf);
    	    return HI_FAILURE;
        }

        /* save raw process*/
    #ifdef HI_OMX_TEE_SUPPORT
        // debug support: add save secure stream method
    #else
    	#ifndef HI_ADVCA_FUNCTION_RELEASE
            channel_save_stream(pchan, pstream);
        #endif
    #endif
    }

	if (puser_buf->flags & VDEC_BUFFERFLAG_EOS)
    {
        OmxPrint(OMX_INFO, "%s receive EOS flag!\n", __func__);
		if (0 == pchan->eos_in_list)
		{
	        pstream = &pchan->last_frame;
	        ret = channel_add_last_frame(pchan, pstream);
	        if (ret != HI_SUCCESS)
	        {
	           OmxPrint(OMX_ERR, "Chan(%d) send last frame failed!\n", pchan->channel_id);
	        }
	        else
	        {
	           pstream->status = BUF_STATE_QUEUED;
	           spin_lock_irqsave(&pchan->raw_lock, flags);
	           list_add_tail(&pstream->list, &pchan->raw_queue);
	           spin_unlock_irqrestore(&pchan->raw_lock, flags);
	           pchan->eos_in_list = 1;
	        }
	    }
		else
		{
	        OmxPrint(OMX_ERR, "Chan(%d) eos already in list!\n", pchan->channel_id);
		}
        pchan->eos_recv_flag++;
	}

    if (0 == puser_buf->data_len)
    {
        OmxPrint(OMX_ERR, "%s receive an empty buffer, return immediately.\n", __func__);
	    message_queue(pchan->msg_queue, VDEC_MSG_RESP_INPUT_DONE, VDEC_S_SUCCESS, (HI_VOID *)puser_buf);
		pchan->omx_chan_statinfo.EBD++;
    }

	pchan->omx_chan_statinfo.ETB++;

    if ( HI_TRUE == pchan->bLowdelay || HI_TRUE == g_FastOutputMode)
    {
        ret = (pVfmwFunc->pfnVfmwControl)(pchan->decoder_id, VDEC_CID_EXTRA_WAKEUP_THREAD, NULL);
    }

	OmxPrint(OMX_TRACE, "%s exit normally!\n", __func__);

	return HI_SUCCESS;
}

HI_S32 channel_fill_this_frame(OMXVDEC_CHAN_CTX *pchan, OMXVDEC_BUF_DESC *puser_buf)
{
	HI_S32         ret    = HI_FAILURE;
	OMXVDEC_BUF_S *pframe = HI_NULL;

	OmxPrint(OMX_TRACE, "%s enter!\n", __func__);

	if (HI_NULL == pchan || HI_NULL == puser_buf)
    {
        OmxPrint(OMX_FATAL, "%s param invalid!\n", __func__);
		return HI_FAILURE;
	}

	pframe = channel_lookup_addr_table(pchan, puser_buf);
	if (HI_NULL == pframe)
    {
        OmxPrint(OMX_ERR, "%s call channel_lookup_addr_table failed!\n", __func__);
        message_queue(pchan->msg_queue, VDEC_MSG_RESP_OUTPUT_DONE, VDEC_ERR_ILLEGAL_OP, (HI_VOID *)puser_buf);
        return HI_FAILURE;
	}

	pframe->offset	= puser_buf->data_offset;
	pframe->act_len	= 0;

    ret = channel_insert_in_yuv_list(pchan, pframe);
    if (ret != HI_SUCCESS)
    {
        message_queue(pchan->msg_queue, VDEC_MSG_RESP_OUTPUT_DONE, VDEC_ERR_ILLEGAL_OP, (HI_VOID *)puser_buf);
	    return HI_FAILURE;
    }

	pchan->omx_chan_statinfo.FTB++;

	OmxPrint(OMX_TRACE, "%s exit normally!\n", __func__);

	return HI_SUCCESS;
}

HI_S32 channel_get_message(OMXVDEC_CHAN_CTX *pchan, OMXVDEC_MSG_INFO *pmsg)
{
	if (HI_NULL == pchan || HI_NULL == pmsg)
    {
        OmxPrint(OMX_FATAL, "%s param invalid!\n", __func__);
        return HI_FAILURE;
	}

	return message_dequeue(pchan->msg_queue, pmsg);
}

HI_S32 channel_flush_in_port(OMXVDEC_CHAN_CTX *pchan)
{
	unsigned long flags;
	OMXVDEC_BUF_S *pbuf = HI_NULL;
	OMXVDEC_BUF_S *ptmp = HI_NULL;
	OMXVDEC_BUF_DESC user_buf;
    memset(&user_buf, 0, sizeof(OMXVDEC_BUF_DESC));

	pbuf = ptmp = HI_NULL;

    spin_lock_irqsave(&pchan->raw_lock, flags);
    list_for_each_entry_safe(pbuf, ptmp, &pchan->raw_queue, list)
    {
        if (BUF_STATE_USING == pbuf->status)
        {
            continue;
        }

        pbuf->status = BUF_STATE_IDLE;
        list_del(&pbuf->list);

        if (pbuf->buf_id != LAST_FRAME_BUF_ID)
        {
            user_buf.dir = PORT_DIR_INPUT;
            user_buf.bufferaddr = (HI_SIZE_T)pbuf->user_vaddr;
            user_buf.buffer_len =  pbuf->buf_len;
            user_buf.client_data = (HI_SIZE_T)pbuf->client_data;

            user_buf.data_len = 0;
            user_buf.timestamp = 0;

            pbuf->act_len = user_buf.data_len;
            message_queue(pchan->msg_queue, VDEC_MSG_RESP_INPUT_DONE, VDEC_S_SUCCESS, (void *)&user_buf);
            OmxPrint(OMX_OUTBUF, "Release Idle In Buffer: phy addr = 0x%08x\n", pbuf->phy_addr);
        }
        else
        {
            pchan->eos_in_list = 0;
        }
	}

    if (pchan->raw_use_cnt > 0)
    {
        pchan->input_flush_pending = 1;
    }
    else
    {
        message_queue(pchan->msg_queue, VDEC_MSG_RESP_FLUSH_INPUT_DONE, VDEC_S_SUCCESS, HI_NULL);
    }

	spin_unlock_irqrestore(&pchan->raw_lock, flags);

    if (pchan->input_flush_pending)
    {
        OmxPrint(OMX_INBUF, "Call vfmw to release input buffers.\n");
        decoder_command_handler(pchan, DEC_CMD_CLEAR_STREAM, HI_NULL); // call decoder to return all es buffer
    }

	return HI_SUCCESS;
}

HI_S32 channel_flush_out_port(OMXVDEC_CHAN_CTX *pchan)
{
    unsigned long flags;
    OMXVDEC_BUF_S *pbuf = HI_NULL;
    OMXVDEC_BUF_S *ptmp = HI_NULL;
    OMXVDEC_BUF_DESC user_buf;

    OmxPrint(OMX_TRACE, "%s enter!\n", __func__);

    if (1 == pchan->recfg_flag) // flush command called by resolution change
    {
        OmxPrint(OMX_INFO, "Wait for output with no clear.\n");
        pchan->recfg_flag = 0;
    }
    else // flush command called by seek
    {
        OmxPrint(OMX_INFO, "Call to clear remain pictures.\n");
        channel_reset_inst(pchan);  // reset channel to clear old image
        pchan->seek_pending = 1;
    }

    memset(&user_buf, 0, sizeof(OMXVDEC_BUF_DESC));

    pbuf = ptmp = HI_NULL;

    spin_lock_irqsave(&pchan->yuv_lock, flags);
    list_for_each_entry_safe(pbuf, ptmp, &pchan->yuv_queue, list)
    {
        if (BUF_STATE_USING == pbuf->status)
        {
            continue;
        }

        user_buf.dir          = PORT_DIR_OUTPUT;
        user_buf.bufferaddr   = (HI_SIZE_T)pbuf->user_vaddr;
        user_buf.buffer_len   =  pbuf->buf_len;
        user_buf.client_data  = (HI_SIZE_T)pbuf->client_data;
        user_buf.flags        = 0;
        user_buf.data_len     = 0;
        user_buf.timestamp    = 0;

        pbuf->status = BUF_STATE_IDLE;
        list_del(&pbuf->list);

        message_queue(pchan->msg_queue, VDEC_MSG_RESP_OUTPUT_DONE, VDEC_S_SUCCESS, (HI_VOID *)&user_buf);
    	pchan->omx_chan_statinfo.FBD++;

		OmxPrint(OMX_OUTBUF, "Release Idle Out Buffer: phy addr = 0x%08x\n", pbuf->phy_addr);
    }

	if (pchan->yuv_use_cnt > 0)
    {
		pchan->output_flush_pending = 1;
    }
	else
    {
		message_queue(pchan->msg_queue, VDEC_MSG_RESP_FLUSH_OUTPUT_DONE, VDEC_S_SUCCESS, HI_NULL);
	}
    spin_unlock_irqrestore(&pchan->yuv_lock, flags);

	OmxPrint(OMX_TRACE, "%s exit normally!\n", __func__);

    return HI_SUCCESS;
}

HI_S32 channel_flush_inst(OMXVDEC_CHAN_CTX *pchan, ePORT_DIR dir)
{
    HI_S32 ret_in  = HI_SUCCESS;
    HI_S32 ret_out = HI_SUCCESS;

    OmxPrint(OMX_TRACE, "%s enter!\n", __func__);

	if (HI_NULL == pchan)
    {
        OmxPrint(OMX_FATAL, "%s param invalid!\n", __func__);
        return HI_FAILURE;
	}

    if ((PORT_DIR_INPUT == dir) || (PORT_DIR_BOTH == dir))
    {
        ret_in = channel_flush_in_port(pchan);
        if (ret_in != HI_SUCCESS)
        {
            OmxPrint(OMX_ERR, "channel_flush_in_port failed!\n");
        }
    }

    if ((PORT_DIR_OUTPUT == dir) || (PORT_DIR_BOTH == dir))
    {
        ret_out = channel_flush_out_port(pchan);
        if (ret_out != HI_SUCCESS)
        {
            OmxPrint(OMX_ERR, "channel_flush_out_port failed!\n");
        }
    }

    OmxPrint(OMX_TRACE, "%s exit normally!\n", __func__);

    return (ret_in | ret_out);
}

HI_S32 channel_report_message(OMXVDEC_CHAN_CTX *pchan, HI_U32 msgcode, HI_VOID *priv)
{
    OmxPrint(OMX_TRACE, "%s enter!\n", __func__);

	message_queue(pchan->msg_queue, msgcode, VDEC_S_SUCCESS, priv);

    OmxPrint(OMX_TRACE, "%s exit normally!\n", __func__);

	return HI_SUCCESS;
}

HI_S32 channel_check_avaible_frame_buffer(OMXVDEC_CHAN_CTX *pchan)
{
    HI_S32 ret = HI_FAILURE;
	unsigned long flags;
	OMXVDEC_BUF_S *pbuf = HI_NULL;

	spin_lock_irqsave(&pchan->yuv_lock, flags);

	list_for_each_entry(pbuf, &pchan->yuv_queue, list)
	{
        if (pbuf->status == BUF_STATE_QUEUED)
        {
            ret = HI_SUCCESS;
            break;
        }
	}

	spin_unlock_irqrestore(&pchan->yuv_lock, flags);

    return ret;
}

OMXVDEC_CHAN_CTX* channel_find_inst_by_channel_id(OMXVDEC_ENTRY *omxvdec, HI_S32 handle)
{
    HI_S8 find = 0;
	OMXVDEC_CHAN_CTX *pchan = HI_NULL;
	unsigned long flags;

	if (HI_NULL == omxvdec || handle < 0)
    {
        OmxPrint(OMX_FATAL, "%s: omxvdec = NULL / handle(%d) invalid\n", __func__, handle);
        return HI_NULL;
    }

	spin_lock_irqsave(&omxvdec->channel_lock, flags);
	if (!list_empty(&omxvdec->chan_list))
    {
        list_for_each_entry(pchan, &omxvdec->chan_list, chan_list)
        {
            if(pchan->channel_id == handle)
            {
                find = 1;
                break;
            }
        }
    }
	spin_unlock_irqrestore(&omxvdec->channel_lock, flags);

    if (0 == find)
    {
        pchan = HI_NULL;
    }

	return pchan;
}

OMXVDEC_CHAN_CTX* channel_find_inst_by_decoder_id(OMXVDEC_ENTRY *omxvdec, HI_S32 handle)
{
    HI_S8 find = 0;
	OMXVDEC_CHAN_CTX *pchan = HI_NULL;
	unsigned long flags;

	if (HI_NULL == omxvdec || handle < 0)
    {
        OmxPrint(OMX_FATAL, "%s: omxvdec = NULL / handle(%d) invalid\n", __func__, handle);
        return HI_NULL;
    }

	spin_lock_irqsave(&omxvdec->channel_lock, flags);
	if (!list_empty(&omxvdec->chan_list))
    {
        list_for_each_entry(pchan, &omxvdec->chan_list, chan_list)
        {
            if(pchan->decoder_id == handle)
            {
                find = 1;
                break;
            }
        }
    }
	spin_unlock_irqrestore(&omxvdec->channel_lock, flags);

    if (0 == find)
    {
        pchan = HI_NULL;
    }

	return pchan;
}

OMXVDEC_CHAN_CTX* channel_find_inst_by_processor_id(OMXVDEC_ENTRY *omxvdec, HI_S32 handle)
{
    HI_S8 find = 0;
	unsigned long flags;
	OMXVDEC_CHAN_CTX *pchan = HI_NULL;

	if (HI_NULL == omxvdec || handle < 0)
    {
        OmxPrint(OMX_FATAL, "%s: omxvdec = NULL / handle(%d) invalid\n", __func__, handle);
        return HI_NULL;
    }

	spin_lock_irqsave(&omxvdec->channel_lock, flags);
	if (!list_empty(&omxvdec->chan_list))
    {
        list_for_each_entry(pchan, &omxvdec->chan_list, chan_list)
        {
            if(pchan->processor_id == handle)
            {
                find = 1;
                break;
            }
        }
    }
	spin_unlock_irqrestore(&omxvdec->channel_lock, flags);

    if (0 == find)
    {
        pchan = HI_NULL;
    }

	return pchan;
}

HI_VOID channel_add_lowdelay_tag_time(OMXVDEC_CHAN_CTX *pchan, UINT32 tag, UINT32 type, UINT32 time)
{
    UINT32 i = 0;

    if (HI_NULL == pchan)
    {
        OmxPrint(OMX_FATAL, "%s param invalid!\n", __func__);
        return;
    }

    switch(type)
    {
        case OMX_LOWDELAY_REC_ETB_TIME:
            for(i = 0; i < OMX_LOWDELAY_REC_NODE_NUM; i++)
            {
                if(OMX_LOWDELAY_REC_NODE_FREE == pchan->omx_vdec_lowdelay_proc_rec->time_record[i][OMX_LOWDELAY_REC_NODE_STATE])
                {
                    memset(pchan->omx_vdec_lowdelay_proc_rec->time_record[i], 0, sizeof(pchan->omx_vdec_lowdelay_proc_rec->time_record[i]));
                    pchan->omx_vdec_lowdelay_proc_rec->time_record[i][OMX_LOWDELAY_REC_USERTAG]    = tag;
                    pchan->omx_vdec_lowdelay_proc_rec->time_record[i][OMX_LOWDELAY_REC_ETB_TIME]   = time;
                    pchan->omx_vdec_lowdelay_proc_rec->time_record[i][OMX_LOWDELAY_REC_NODE_STATE] = OMX_LOWDELAY_REC_NODE_WRITED;
                    break;
                }
            }
            break;
        case OMX_LOWDELAY_REC_VFMW_RCV_STRM_TIME:
            for(i = 0; i < OMX_LOWDELAY_REC_NODE_NUM; i++)
            {
                if((pchan->omx_vdec_lowdelay_proc_rec->time_record[i][OMX_LOWDELAY_REC_USERTAG] == tag) && \
                   (pchan->omx_vdec_lowdelay_proc_rec->time_record[i][OMX_LOWDELAY_REC_NODE_STATE] == OMX_LOWDELAY_REC_NODE_WRITED))
                {
                    pchan->omx_vdec_lowdelay_proc_rec->time_record[i][OMX_LOWDELAY_REC_VFMW_RCV_STRM_TIME] = time;
                    break;
                }
            }
            break;
        case OMX_LOWDELAY_REC_VFMW_RLS_STRM_TIME:
            for(i = 0; i < OMX_LOWDELAY_REC_NODE_NUM; i++)
            {
                if((pchan->omx_vdec_lowdelay_proc_rec->time_record[i][OMX_LOWDELAY_REC_USERTAG] == tag) && \
                   (pchan->omx_vdec_lowdelay_proc_rec->time_record[i][OMX_LOWDELAY_REC_NODE_STATE] == OMX_LOWDELAY_REC_NODE_WRITED))
                {
                    pchan->omx_vdec_lowdelay_proc_rec->time_record[i][OMX_LOWDELAY_REC_VFMW_RLS_STRM_TIME] = time;
                    break;
                }
            }
            break;
        case OMX_LOWDELAY_REC_VFMW_RPO_IMG_TIME:
            for(i = 0; i < OMX_LOWDELAY_REC_NODE_NUM; i++)
            {
                if((pchan->omx_vdec_lowdelay_proc_rec->time_record[i][OMX_LOWDELAY_REC_USERTAG] == tag) && \
                   (pchan->omx_vdec_lowdelay_proc_rec->time_record[i][OMX_LOWDELAY_REC_NODE_STATE] == OMX_LOWDELAY_REC_NODE_WRITED))
                {
                    pchan->omx_vdec_lowdelay_proc_rec->time_record[i][OMX_LOWDELAY_REC_VFMW_RPO_IMG_TIME] = time;
                    break;
                }
            }
            break;
        case OMX_LOWDELAY_REC_VPSS_RCV_IMG_TIME:
            for(i = 0; i < OMX_LOWDELAY_REC_NODE_NUM; i++)
            {
                if((pchan->omx_vdec_lowdelay_proc_rec->time_record[i][OMX_LOWDELAY_REC_USERTAG] == tag) && \
                   (pchan->omx_vdec_lowdelay_proc_rec->time_record[i][OMX_LOWDELAY_REC_NODE_STATE] == OMX_LOWDELAY_REC_NODE_WRITED))
                {
                    pchan->omx_vdec_lowdelay_proc_rec->time_record[i][OMX_LOWDELAY_REC_VPSS_RCV_IMG_TIME] = time;
                    break;
                }
            }
            break;
        case OMX_LOWDELAY_REC_VPSS_RPO_IMG_TIME:
            for(i = 0; i < OMX_LOWDELAY_REC_NODE_NUM; i++)
            {
                if((pchan->omx_vdec_lowdelay_proc_rec->time_record[i][OMX_LOWDELAY_REC_USERTAG] == tag) && \
                   (pchan->omx_vdec_lowdelay_proc_rec->time_record[i][OMX_LOWDELAY_REC_NODE_STATE] == OMX_LOWDELAY_REC_NODE_WRITED))
                {
                    pchan->omx_vdec_lowdelay_proc_rec->time_record[i][OMX_LOWDELAY_REC_VPSS_RPO_IMG_TIME] = time;
                    pchan->omx_vdec_lowdelay_proc_rec->time_record[i][OMX_LOWDELAY_REC_TOTAL_USED_TIME] = pchan->omx_vdec_lowdelay_proc_rec->time_record[i][OMX_LOWDELAY_REC_VPSS_RPO_IMG_TIME] - \
                                                                                              pchan->omx_vdec_lowdelay_proc_rec->time_record[i][OMX_LOWDELAY_REC_ETB_TIME];
                    pchan->omx_vdec_lowdelay_proc_rec->rec_index++;
                    if(pchan->omx_vdec_lowdelay_proc_rec->rec_index < g_lowdelay_count_frame)
                    {
                        pchan->omx_vdec_lowdelay_proc_rec->time_cost_sum += pchan->omx_vdec_lowdelay_proc_rec->time_record[i][OMX_LOWDELAY_REC_TOTAL_USED_TIME];
                    }
                    else
                    {
                        pchan->omx_vdec_lowdelay_proc_rec->average_time_cost = (pchan->omx_vdec_lowdelay_proc_rec->time_cost_sum) / (g_lowdelay_count_frame);
                        pchan->omx_vdec_lowdelay_proc_rec->rec_index  = 0;
                        pchan->omx_vdec_lowdelay_proc_rec->time_cost_sum = 0;
                    }
                    memcpy(pchan->omx_vdec_lowdelay_proc_rec->time_record[OMX_LOWDELAY_REC_NODE_NUM], pchan->omx_vdec_lowdelay_proc_rec->time_record[i], sizeof(pchan->omx_vdec_lowdelay_proc_rec->time_record[i]));
                    break;
                }
            }
            for(i = 0 ; i < OMX_LOWDELAY_REC_NODE_NUM; i++)
            {
               if(pchan->omx_vdec_lowdelay_proc_rec->time_record[i][OMX_LOWDELAY_REC_USERTAG] <= tag)
               {
                    memset(pchan->omx_vdec_lowdelay_proc_rec->time_record[i], 0, sizeof(pchan->omx_vdec_lowdelay_proc_rec->time_record[i]));
               }
            }
            break;
        default:
            break;
    }

    return;
}

#ifdef VFMW_VPSS_BYPASS_EN
/***********************************************************************************/
/**函数名:channel_release_frame                                                   **/
/**作用:  只用于OMX通路，vpss bypass的情况，外部调用FTB时omxvdec内部给VFMW还帧    **/
/**修改人:l00228308                                                               **/
/***********************************************************************************/
HI_S32 channel_release_frame(OMXVDEC_CHAN_CTX *pchan, OMXVDEC_BUF_DESC *puser_buf)
{
	HI_S32         ret    = HI_FAILURE;
	OMXVDEC_BUF_S *pframe = HI_NULL;
    HI_DRV_VIDEO_FRAME_S stFrame;
	HI_DRV_VIDEO_FRAME_S *pstFramePriv = NULL;

	OmxPrint(OMX_TRACE, "%s enter!\n", __func__);

    memset(&stFrame, 0 , sizeof(HI_DRV_VIDEO_FRAME_S));

	if (HI_NULL == pchan || HI_NULL == puser_buf)
    {
        OmxPrint(OMX_FATAL, "%s param invalid!\n", __func__);
		return HI_FAILURE;
	}

	pframe = channel_lookup_addr_table(pchan, puser_buf);
	if (HI_NULL == pframe)
    {
        OmxPrint(OMX_ERR, "%s call channel_lookup_addr_table failed!\n", __func__);
        return HI_FAILURE;
	}

	if (0 != pframe->private_vaddr)
	{
	    pstFramePriv = (HI_DRV_VIDEO_FRAME_S *)pframe->private_vaddr;

		memcpy(&stFrame, pstFramePriv, sizeof(HI_DRV_VIDEO_FRAME_S));
        memset(pstFramePriv, 0 , sizeof(HI_DRV_VIDEO_FRAME_S));
	}
	else
	{
	    OmxPrint(OMX_ERR, "%s private_vaddr = 0! error\n", __func__);
		return HI_FAILURE;
	}

	ret = processor_release_image(pchan->processor_id, &stFrame);
    if (ret != HI_SUCCESS)
    {
        OmxPrint(OMX_ERR, "%s processor_release_image  release frame (0x%x) failed! return 0x%x\n", __func__,stFrame.stBufAddr[0].u32PhyAddr_Y,ret);
	    return HI_FAILURE;
    }

	OmxPrint(OMX_TRACE, "%s exit normally! return 0x%x\n", __func__,ret);

	return HI_SUCCESS;
}

/*************************************************************************************/
/**函数名  : channel_IsSpecialFrm                                                   **/
/**作用    :  只用于OMX通路，判断该帧是否是special帧                                **/
/**参数说明:                                                                        **/
/**TargetPhyAddr    : 对比目标物理地址/Smmu地址                                     **/
/**pIndex:            如果非空，则返回对应找到的OccupiedFrm的索引ID，               **/
/**                   如果为空，则意味着外面不需要返回ID，忽略，不报错              **/
/**修改人:l00228308                                                                 **/
/*************************************************************************************/
HI_BOOL channel_IsOccupiedFrm(HI_U32 TargetPhyAddr, HI_U32 *pIndex)
{
	HI_U32 specialFrameIndex;
	HI_BOOL bSpecialFrm = HI_FALSE;
    OMXVDEC_FRM_INFO_S *pSpecialFrmInfo;

	if (TargetPhyAddr == 0 || TargetPhyAddr == 0xffffffff)
	{
	    OmxPrint(OMX_ERR, "%s TargetPhyAddr invalid\n", __func__);

		return HI_FALSE;
	}

	VDEC_DOWN_INTERRUPTIBLE(&g_OmxVdec->stRemainFrmList.bypass_mutex);

    for (specialFrameIndex = 0; specialFrameIndex < OMXVDEC_MAX_REMAIN_FRM_NUM; specialFrameIndex++)
    {
       pSpecialFrmInfo = &g_OmxVdec->stRemainFrmList.stSpecialFrmRec[specialFrameIndex];
       if (pSpecialFrmInfo->frmBufRec.u32StartPhyAddr ==  TargetPhyAddr)
       {
           bSpecialFrm = HI_TRUE;
		   if (pIndex != HI_NULL)
		   {
		      *pIndex = specialFrameIndex;
		   }
		   break;
       }
    }
	VDEC_UP_INTERRUPTIBLE(&g_OmxVdec->stRemainFrmList.bypass_mutex);

    return bSpecialFrm;
}


/********************************************************************************************************************/
/**函数名: channel_set_processor_bypass                                                                            **/
/**作用:  只用于OMX通路，设置VPSS 是否 bypass 的信息                                                               **/
/* 参数说明:                                                                                                       **/
/* pchan           : 通道信息上下文                                                                                **/
/**修改人:l00228308                                                                                                **/
/********************************************************************************************************************/
HI_S32 channel_set_processor_bypass(OMXVDEC_CHAN_CTX *pchan)
{
	unsigned long flags;
	HI_S32 ret    = HI_FAILURE;

	OmxPrint(OMX_TRACE, "%s enter!\n", __func__);
	if (HI_NULL == pchan)
    {
        OmxPrint(OMX_FATAL, "%s: vdec = NULL, invalid\n", __func__);
        return HI_NULL;
    }

	spin_lock_irqsave(&pchan->chan_lock, flags);
	if (pchan->state == CHAN_STATE_WORK)
    {
		spin_unlock_irqrestore(&pchan->chan_lock, flags);
        OmxPrint(OMX_ERR, "%s already in work state,can't be set!\n", __func__);
		goto error;
	}
	spin_unlock_irqrestore(&pchan->chan_lock, flags);

	ret = processor_set_bypass(pchan);
	if (ret != HI_SUCCESS)
    {
        OmxPrint(OMX_FATAL, "%s call processor_set_bypass failed!\n", __func__);
		goto error;
	}
	OmxPrint(OMX_TRACE, "%s exit normally!\n", __func__);

error:
	return ret;
}


/********************************************************************************************************************/
/**函数名: channel_get_processor_bypass                                                                            **/
/**作用:  只用于OMX通路，获取VPSS 是否 bypass 的信息                                                               **/
/* 参数说明:                                                                                                       **/
/* pchan           : 通道信息上下文                                                                                **/
/* chan_cfg        : 利用其中的cfg_width和cfg_height                                                               **/
/**修改人:l00228308                                                                                                **/
/********************************************************************************************************************/
HI_S32 channel_get_processor_bypass(OMXVDEC_CHAN_CTX *pchan,OMXVDEC_DRV_CFG *chan_cfg)
{
	HI_S32 ret    = HI_FAILURE;
    PROCESSOR_BYPASSATTR_S stBypassAttr;

	memset(&stBypassAttr, 0, sizeof(PROCESSOR_BYPASSATTR_S));

	OmxPrint(OMX_TRACE, "%s enter!\n", __func__);

	if (HI_NULL == pchan)
    {
        OmxPrint(OMX_FATAL, "%s: vdec = NULL, invalid\n", __func__);
        return HI_NULL;
    }

	stBypassAttr.u32InputWidth = chan_cfg->cfg_width;
	stBypassAttr.u32InputHeight = chan_cfg->cfg_height;

	ret = processor_get_bypass(pchan,&stBypassAttr);
	if (ret != HI_SUCCESS)
    {
        OmxPrint(OMX_FATAL, "%s call processor_get_bypass failed!\n", __func__);
		goto error;
	}
	OmxPrint(OMX_TRACE, "%s exit normally!\n", __func__);

error:
	return ret;
}

#endif

HI_VOID channel_proc_entry(struct seq_file *p, OMXVDEC_CHAN_CTX *pchan)
{
    HI_S32 i;
    OMXVDEC_BUF_S *pVdecBufTable = HI_NULL;

    PROC_PRINT(p, "--------------- INST%2d --------------\n",   pchan->channel_id);
    PROC_PRINT(p, "%-25s :%d\n",    "ChanId",       pchan->decoder_id);
    PROC_PRINT(p, "%-25s :%d\n",    "VpssId",       pchan->processor_id);
    PROC_PRINT(p, "%-25s :%d\n",    "TVP",          pchan->is_tvp);
    PROC_PRINT(p, "%-25s :%d\n",    "bypass",       pchan->bVpssBypass);
    PROC_PRINT(p, "%-25s :%d\n",    "Overlay",      pchan->is_overaly);
    PROC_PRINT(p, "%-25s :%d\n",    "10BIT",        pchan->is_10bit);
    PROC_PRINT(p, "%-25s :%s\n",    "State",        channel_show_chan_state(pchan->state));
    PROC_PRINT(p, "%-25s :%s\n",    "Protocol",     channel_show_protocol(pchan->protocol));
    PROC_PRINT(p, "%-25s :%d\n",    "Progress",     pchan->progress);
    PROC_PRINT(p, "%-25s :%dx%d\n", "Resolution",   pchan->out_width, pchan->out_height);
    PROC_PRINT(p, "%-25s :%d\n",    "Stride",       pchan->out_stride);
    PROC_PRINT(p, "%-25s :%s\n",    "ColorFormat",  channel_show_color_format(pchan->color_format));
    PROC_PRINT(p, "%-25s :%d\n",    "EosFlag",      pchan->eos_recv_flag);
    PROC_PRINT(p, "%-25s :%d\n",    "EosInList",    pchan->eos_in_list);
    PROC_PRINT(p, "%-25s :%d\n",    "EofFlag",      pchan->eof_send_flag);
    PROC_PRINT(p, "%-25s :%d\n",    "Lowdelay",     pchan->bLowdelay);
    PROC_PRINT(p, "%-25s :%d(%d)\n","FrameRate(Src)",pchan->last_frame.u32FrameRate, pchan->last_frame.u32SrcFrameRate);

	PROC_PRINT(p, "%-25s :%s\n",    "DfsState",     channel_show_dfs_state(pchan->dfs.dfs_state));

	if (STD_VP6 == pchan->protocol || STD_VP6A == pchan->protocol || STD_VP6F == pchan->protocol)
	{
    PROC_PRINT(p, "%-25s :%d\n",    "VP6 Reversed", pchan->bReversed);
	}

    if (pchan->dfs.alloc_pmv_num != 0)
    {
    PROC_PRINT(p, "DFS INFO:\n");
    PROC_PRINT(p, "%-25s :(%d/%d/%d)\n",  "FrmBuf",     pchan->dfs.alloc_frm_num, pchan->dfs.config_frm_num, pchan->dfs.need_frm_num);
    PROC_PRINT(p, "%-25s :(%d/%d/%d)\n",  "Pmvbuf",     pchan->dfs.alloc_pmv_num, pchan->dfs.config_pmv_num, pchan->dfs.need_pmv_num);
    PROC_PRINT(p, "%-25s :%d\n",          "RetryCount", pchan->dfs.retry_count);
    }
    if (DFS_DONE == pchan->dfs.dfs_state)
    {
    PROC_PRINT(p, "%-25s :%dms\n",    "DelayTime",      pchan->dfs.delay_time);
    }

    PROC_PRINT(p, "%-25s :%d/%d\n", "ETB/EBD",          pchan->omx_chan_statinfo.ETB, pchan->omx_chan_statinfo.EBD);
    PROC_PRINT(p, "%-25s :%d/%d\n", "FTB/FBD",          pchan->omx_chan_statinfo.FTB, pchan->omx_chan_statinfo.FBD);

    PROC_PRINT(p, "%-25s :%d/%d\n", "Decoder In/Out",   pchan->omx_chan_statinfo.DecoderIn, pchan->omx_chan_statinfo.DecoderOut);
    PROC_PRINT(p, "%-25s :%d/%d\n", "Processor In/Out", pchan->omx_chan_statinfo.ProcessorIn, pchan->omx_chan_statinfo.ProcessorOut);
    PROC_PRINT(p, "\n");

    PROC_PRINT(p, "%-10s :%d/%d\n", "In Buffer",    pchan->input_buf_num, pchan->max_in_buf_num);
    PROC_PRINT(p, " %-10s%-10s%-10s%-10s\n", "phyaddr", "size", "fill", "status");

    pVdecBufTable = (OMXVDEC_BUF_S *)pchan->in_buf_table;
    for (i=0; i<pchan->input_buf_num; i++)
    {
       PROC_PRINT(p, " %-10x%-10d%-10d%-10s\n",
                     pVdecBufTable[i].phy_addr,
                     pVdecBufTable[i].buf_len,
                     pVdecBufTable[i].act_len,
                     channel_show_buffer_state(pVdecBufTable[i].status));
    }
    PROC_PRINT(p, "\n");

    PROC_PRINT(p, "%-10s :%d/%d\n", "Out Buffer",   pchan->output_buf_num, pchan->max_out_buf_num);
    PROC_PRINT(p, " %-10s%-10s%-10s%-10s\n", "phyaddr", "size", "fill", "status");
    pVdecBufTable = (OMXVDEC_BUF_S *)pchan->out_buf_table;
    for (i=0; i<pchan->output_buf_num; i++)
    {
       PROC_PRINT(p, " %-10x%-10d%-10d%-10s\n",
                     pVdecBufTable[i].phy_addr,
                     pVdecBufTable[i].buf_len,
                     pVdecBufTable[i].act_len,
                     channel_show_buffer_state(pVdecBufTable[i].status));
    }
    PROC_PRINT(p, "\n");

    if((pchan->bLowdelay || g_FastOutputMode) && (NULL != pchan->omx_vdec_lowdelay_proc_rec))
    {
        PROC_PRINT(p, "--------------- LOWDELAY TIME--------------\n");
        PROC_PRINT(p, "%-50s(ms) :%d\n",    "Empty This Buffer       -> Decoder Receive Stream", pchan->omx_vdec_lowdelay_proc_rec->time_record[OMX_LOWDELAY_REC_NODE_NUM][OMX_LOWDELAY_REC_VFMW_RCV_STRM_TIME] - \
                                                                                             pchan->omx_vdec_lowdelay_proc_rec->time_record[OMX_LOWDELAY_REC_NODE_NUM][OMX_LOWDELAY_REC_ETB_TIME]);
        PROC_PRINT(p, "%-50s(ms) :%d\n",    "Decoder Receive Stream  -> Decoder Report Image",   pchan->omx_vdec_lowdelay_proc_rec->time_record[OMX_LOWDELAY_REC_NODE_NUM][OMX_LOWDELAY_REC_VFMW_RPO_IMG_TIME] - \
                                                                                             pchan->omx_vdec_lowdelay_proc_rec->time_record[OMX_LOWDELAY_REC_NODE_NUM][OMX_LOWDELAY_REC_VFMW_RCV_STRM_TIME]);
        PROC_PRINT(p, "%-50s(ms) :%d\n",    "Decoder Report Image    -> Processor Receive Image",pchan->omx_vdec_lowdelay_proc_rec->time_record[OMX_LOWDELAY_REC_NODE_NUM][OMX_LOWDELAY_REC_VPSS_RCV_IMG_TIME] - \
                                                                                             pchan->omx_vdec_lowdelay_proc_rec->time_record[OMX_LOWDELAY_REC_NODE_NUM][OMX_LOWDELAY_REC_VFMW_RPO_IMG_TIME]);
        PROC_PRINT(p, "%-50s(ms) :%d\n",    "Processor Receive Image -> Processor Report Image", pchan->omx_vdec_lowdelay_proc_rec->time_record[OMX_LOWDELAY_REC_NODE_NUM][OMX_LOWDELAY_REC_VPSS_RPO_IMG_TIME] - \
                                                                                             pchan->omx_vdec_lowdelay_proc_rec->time_record[OMX_LOWDELAY_REC_NODE_NUM][OMX_LOWDELAY_REC_VPSS_RCV_IMG_TIME]);
        PROC_PRINT(p, "%-50s(ms) :%d\n",    "Total Used Time",                                   pchan->omx_vdec_lowdelay_proc_rec->time_record[OMX_LOWDELAY_REC_NODE_NUM][OMX_LOWDELAY_REC_TOTAL_USED_TIME]);
        PROC_PRINT(p, "%s(%d %s) %26s(ms) :%d\n",    "Average Time", g_lowdelay_count_frame, "Frame", " ", pchan->omx_vdec_lowdelay_proc_rec->average_time_cost);
    }
    PROC_PRINT(p, "-------------------------------------\n");
}

