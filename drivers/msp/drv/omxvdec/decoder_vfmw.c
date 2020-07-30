/*
 * Copyright (c) (2014 - ...) Device Chipset Source Algorithm and Chipset Platform Development Dept
 * Hisilicon. All rights reserved.
 *
 * File:    decoder_vfmw.c
 *
 * Purpose: omxvdec decoder vfmw functions
 *
 * Author:  yangyichang 00226912
 *
 * Date:    26, 11, 2014
 *
 */

#include "hi_drv_module.h"  // HI_DRV_MODULE_GetFunction 依赖
#include "hi_module.h"    //HI_ID_OMXVDEC
#include "hi_drv_stat.h"
#include "decoder.h"
#include "vfmw_ext.h"


/*================ EXTERN VALUE ================*/
extern OMXVDEC_ENTRY *g_OmxVdec;
extern OMXVDEC_FUNC g_stOmxFunc;

#if (1 == PRE_ALLOC_VDEC_VDH_MMZ)
extern MMZ_BUFFER_S g_stVDHMMZ;
extern HI_BOOL g_bVdecPreVDHMMZUsed;
extern HI_U32 g_VdecPreVDHMMZUsedSize;
extern VDEC_PREMMZ_NODE_S st_VdecChanPreUsedMMZInfo[];
extern HI_U32 g_VdecPreMMZNodeNum;
#endif

HI_S32 processor_inform_img_ready(OMXVDEC_CHAN_CTX *pchan);

/*================ STATIC VALUE ================*/
VFMW_EXPORT_FUNC_S* pVfmwFunc = HI_NULL;


/*=================== MACRO ====================*/
#define SOFT_DEC_MIN_MEM_SD     (22*1024*1024)
#define SOFT_DEC_MIN_MEM_HD     (45*1024*1024)

#if (1 == PRE_ALLOC_VDEC_VDH_MMZ)
#define HI_VDEC_MAX_PRENODE_NUM 100
#endif


/*================ GLOBAL VALUE ================*/
HI_U32   g_DispNum               = 1;
HI_U32   g_SegSize               = 2;         // (M)
HI_BOOL  g_DynamicFsEnable       = HI_TRUE;
HI_BOOL  g_LowDelayStatistics    = HI_FALSE;  //HI_TRUE;
HI_BOOL  g_RawMoveEnable         = HI_TRUE;   // 码流搬移使能标志，解决scd切割失败不释放码流的情况
HI_BOOL  g_FastOutputMode        = HI_FALSE;


/*================== DATA TYPE =================*/
typedef enum {
	CFG_CAP_SD = 0,
	CFG_CAP_HD,
	CFG_CAP_UHD,
	CFG_CAP_BUTT,
}eCFG_CAP;


/*============== INTERNAL FUNCTION =============*/
#ifdef VFMW_VPSS_BYPASS_EN
HI_S32 decoder_find_special2Normal_Index(OMXVDEC_CHAN_CTX *pchan,HI_U32 u32Phyaddr, HI_U32 *pIndex)
{
    HI_U32 index;
	DSF_SINGLE_BUF_S *pBufSlot = HI_NULL;

	D_OMXVDEC_CHECK_PTR_RET(pchan);

    for (index=0; index < MAX_DFS_BUF_NUM; index++)
	{
        pBufSlot = &(pchan->dfs.single_buf[index]);

        if (pBufSlot->frm_buf.u32StartPhyAddr  == u32Phyaddr)
        {
	       *pIndex = index;
		   return HI_SUCCESS;
        }
	}
    OmxPrint(OMX_FATAL,"find normal frame buffer index error!Phyaddr = 0x%x\n",u32Phyaddr);
	return HI_FAILURE;
}


HI_S32 decoder_record_occoupied_frame(OMXVDEC_CHAN_CTX *pchan)
{
	HI_S32 ret = HI_FAILURE;
    VDEC_SPECIAL_FRM_S stReportFrmRec;
    SINT32 s32ImgOutputEn = 0;
	HI_U32 i;
	HI_U32 index = 0;
	OMXVDEC_FRM_INFO_S stSpecialFrmInfo;

    OmxPrint(OMX_TRACE, "%s enter!\n", __func__);

	memset(&stReportFrmRec, 0, sizeof(VDEC_SPECIAL_FRM_S));

	VDEC_DOWN_INTERRUPTIBLE(&g_OmxVdec->stRemainFrmList.bypass_mutex);

    ret = (pVfmwFunc->pfnVfmwControl)( pchan->decoder_id, VDEC_CID_SET_IMG_OUTPUT_INFO, &s32ImgOutputEn);
    if (VDEC_OK != ret)
    {
        OmxPrint(OMX_INFO, "Chan %d VDEC_CID_SET_IMG_OUTPUT_INFO (enable = %d) err!\n",  pchan->decoder_id,s32ImgOutputEn);
    }

    ret = (pVfmwFunc->pfnVfmwControl)( pchan->decoder_id, VDEC_CID_REPORT_OCCUQIED_FRM, &stReportFrmRec);
    if (VDEC_OK != ret)
    {
        OmxPrint(OMX_WARN, "Chan %d VDEC_CID_REPORT_OCCUQIED_FRM err!\n", pchan->decoder_id);
    }
	else
	{
	    OmxPrint(OMX_INFO,"Chan %d VDEC_CID_REPORT_OCCUQIED_FRM occupied frame = %d!\n", pchan->decoder_id,stReportFrmRec.specialFrameNum);

		for (i = 0; i < stReportFrmRec.specialFrameNum ; i++)
		{
		    stSpecialFrmInfo.bCanRls                   = HI_FALSE;
		    stSpecialFrmInfo.frmBufRec.u32StartPhyAddr = stReportFrmRec.specialFrmRec[i].PhyAddr;
			stSpecialFrmInfo.frmBufRec.pu8StartVirAddr = (HI_U8*)(HI_SIZE_T)stReportFrmRec.specialFrmRec[i].VirAddr;
			stSpecialFrmInfo.frmBufRec.u32Size         = stReportFrmRec.specialFrmRec[i].Size;

			if (HI_SUCCESS == decoder_find_special2Normal_Index(pchan, stSpecialFrmInfo.frmBufRec.u32StartPhyAddr, &index))
			{
			    stSpecialFrmInfo.enbufferNodeStatus       =  pchan->dfs.single_buf[index].frm_buf_type;
			    pchan->dfs.single_buf[index].is_CanRls    = HI_FALSE;
			}
			else
			{
			    OmxPrint(OMX_ERR,"special Frame 0x%x,can't find match single buffer node\n", stSpecialFrmInfo.frmBufRec.u32StartPhyAddr);
				stSpecialFrmInfo.enbufferNodeStatus       = ALLOC_INVALID;
			}

            /*fix me!! 安全的内存能区分吗?*/
			OmxPrint(OMX_INFO, "add list  pstChan->specialFrmRec[%d],u32StartPhyAddr= 0x%x,u32StartVirAddr = 0x%p,u32Size = %d\n",
			            i,stSpecialFrmInfo.frmBufRec.u32StartPhyAddr ,stSpecialFrmInfo.frmBufRec.pu8StartVirAddr,stSpecialFrmInfo.frmBufRec.u32Size);
			ret = OMXVDEC_List_Add(&g_OmxVdec->stRemainFrmList, &stSpecialFrmInfo);
		}
	}

	VDEC_UP_INTERRUPTIBLE(&g_OmxVdec->stRemainFrmList.bypass_mutex);

    OmxPrint(OMX_TRACE, "%s exit!\n", __func__);

	return ret;
}


/******************************************************/
/***             全局还帧接口                       ***/
/** 此处输入的 pstFrame 应对应metadata强转中的信息  ***/
/******************************************************/
HI_S32 decoder_global_release_frame(HI_DRV_VIDEO_FRAME_S* pstFrame)
{
    HI_S32 s32Ret = HI_FAILURE;
    HI_U32 u32Index = 0;
    OMXVDEC_FRM_INFO_S* pSpecialFrmInfo;
    D_OMXVDEC_CHECK_PTR_RET(pstFrame);

    OmxPrint(OMX_TRACE, "%s enter!\n", __func__);

	if (!((0 != g_OmxVdec->stRemainFrmList.s32Num) && (channel_IsOccupiedFrm(pstFrame->stBufAddr[0].u32PhyAddr_Y, &u32Index))))
	{
	    /* this frame isn't occupied frame */
		OmxPrint(OMX_FATAL, "%s frame phy(0x%x) is invalid! remain num:%d\n", __func__, \
		         pstFrame->stBufAddr[0].u32PhyAddr_Y, g_OmxVdec->stRemainFrmList.s32Num);

		return HI_FAILURE;
	}

	if (u32Index >= OMXVDEC_MAX_REMAIN_FRM_NUM)
	{
		OmxPrint(OMX_FATAL, "%s u32Index = %d is invalid!\n", __func__, u32Index);

		return HI_FAILURE;
	}
	else
	{
    	pSpecialFrmInfo = &g_OmxVdec->stRemainFrmList.stSpecialFrmRec[u32Index];
	}

    if (pSpecialFrmInfo->frmBufRec.u32StartPhyAddr != 0 && pSpecialFrmInfo->frmBufRec.u32Size != 0)
    {
        OmxPrint(OMX_ERR, "%s vir:0x%p phy:0x%x  type:%d\n", __func__, pSpecialFrmInfo->frmBufRec.pu8StartVirAddr, \
			pSpecialFrmInfo->frmBufRec.u32StartPhyAddr, pSpecialFrmInfo->enbufferNodeStatus);

        omxvdec_release_mem(&pSpecialFrmInfo->frmBufRec, pSpecialFrmInfo->enbufferNodeStatus);
    }

	s32Ret = OMXVDEC_List_Del(&g_OmxVdec->stRemainFrmList, u32Index);

    OmxPrint(OMX_TRACE, "%s exit!\n", __func__);

    return s32Ret;
}

EXPORT_SYMBOL(decoder_global_release_frame);

#endif

static HI_S32 decoder_event_handler(HI_S32 chan_id, HI_S32 event_type, HI_VOID *pargs)
{
	unsigned long flags;
	HI_S32  ret = HI_SUCCESS;
    HI_U32 *ptemp = HI_NULL;
	OMXVDEC_CHAN_CTX  *pchan = HI_NULL;
    IMAGE* pstImg = NULL;
#if (VFMW_FLAG == 5)
	HI_U32 need_frm_num = 0;
#endif

	pchan = channel_find_inst_by_decoder_id(g_OmxVdec, chan_id);
	if (HI_NULL == pchan)
    {
        OmxPrint(OMX_FATAL, "%s can't find Chan(%d).\n", __func__, chan_id);
        return HI_FAILURE;
	}

	switch (event_type)
    {
        case EVNT_NEW_IMAGE:
            pstImg = (IMAGE*)((HI_U32*)pargs);

            if (pstImg == NULL)
            {
                break;
            }

            if ((pchan->bLowdelay || g_FastOutputMode) && (NULL != pchan->omx_vdec_lowdelay_proc_rec))
            {
                channel_add_lowdelay_tag_time(pchan, pstImg->Usertag, OMX_LOWDELAY_REC_VFMW_RPO_IMG_TIME, OMX_GetTimeInMs());
            }
            pchan->omx_chan_statinfo.DecoderOut++;
            ret = processor_inform_img_ready(pchan);

            break;

        case EVNT_NEED_ARRANGE:
            HI_DRV_SYS_GetTimeStampMs(&pchan->dfs.delay_time);

            spin_lock_irqsave(&pchan->dfs.dfs_lock, flags);

            pchan->dfs.dfs_state     = DFS_WAIT_RESPONSE_0;
            pchan->dfs.need_frm_num  = ((HI_U32*)pargs)[0];
            pchan->dfs.need_frm_size = ((HI_U32*)pargs)[1];

            spin_unlock_irqrestore(&pchan->dfs.dfs_lock, flags);

            g_OmxVdec->task.task_state = TASK_STATE_ONCALL;
	        wake_up(&g_OmxVdec->task.task_wait);
            break;

	#if (VFMW_FLAG == 5)
        case EVNT_ARRANGE_FRAME_BUF:
            HI_DRV_SYS_GetTimeStampMs(&pchan->dfs.delay_time);

            spin_lock_irqsave(&pchan->dfs.dfs_lock, flags);

            pchan->dfs.dfs_state      = DFS_WAIT_RESPONSE_1;
            pchan->dfs.need_frm_num   = ((HI_U32*)pargs)[0];
            pchan->dfs.need_frm_size  = ((HI_U32*)pargs)[1];
            pchan->dfs.need_pmv_num   = ((HI_U32*)pargs)[2];
            pchan->dfs.need_pmv_size  = ((HI_U32*)pargs)[3];

            if (pchan->is_overaly && pchan->bVpssBypass)
            {
                pchan->dfs.need_frm_num += MAX(g_DispNum, 6);
            }
            else
            {
                pchan->dfs.need_frm_num += g_DispNum;
            }

			//SMMU下，pchan的成员不能直接传递到安全侧，否则会导致无法读到正确值
			need_frm_num = pchan->dfs.need_frm_num;
            spin_unlock_irqrestore(&pchan->dfs.dfs_lock, flags);

            ret = (pVfmwFunc->pfnVfmwControl)(pchan->decoder_id, VDEC_CID_SET_FRAME_BUFFER_NUM, (HI_VOID *)&need_frm_num);
			if(ret != VDEC_OK)
			{
                OmxPrint(OMX_ERR, "call vfmw command VDEC_CID_SET_FRAME_BUFFER_NUM err!\n");
			}
			else
			{

                g_OmxVdec->task.task_state = TASK_STATE_ONCALL;
	            wake_up(&g_OmxVdec->task.task_wait);
			}
            break;
#ifdef VFMW_VPSS_BYPASS_EN
        case EVNT_POST_MODULE_OCCUPY_FRAMES:
            if (((HI_U64 *)pargs)[1] != 0)
            {
                HI_U32 i = 0;
				HI_U32 index;
				HI_U32 specialFrmNum = 0;
		        VFMW_SPECIAL_FRAME_REC_S *pSpecialFrmRec;
				OMXVDEC_FRM_INFO_S stSpecialFrmInfo;

                specialFrmNum = ((HI_U64 *)pargs)[1];
                pSpecialFrmRec = ((VFMW_SPECIAL_FRAME_REC_S **)pargs)[0];

			    for (i = 0; i < specialFrmNum; i++,pSpecialFrmRec++)
			    {
				    stSpecialFrmInfo.bCanRls                 = HI_FALSE;
				    stSpecialFrmInfo.frmBufRec.u32StartPhyAddr = pSpecialFrmRec->PhyAddr;
					stSpecialFrmInfo.frmBufRec.pu8StartVirAddr = (HI_U8*)(HI_SIZE_T)pSpecialFrmRec->VirAddr;
					stSpecialFrmInfo.frmBufRec.u32Size         = pSpecialFrmRec->Size;

					if (HI_SUCCESS == decoder_find_special2Normal_Index(pchan, stSpecialFrmInfo.frmBufRec.u32StartPhyAddr, &index))
					{
					    stSpecialFrmInfo.enbufferNodeStatus       =  pchan->dfs.single_buf[index].frm_buf_type;
					    pchan->dfs.single_buf[index].is_CanRls    =  HI_FALSE;
					}
					else
					{
					    OmxPrint(OMX_INFO,"special Frame 0x%x,can't find match single buffer node\n", stSpecialFrmInfo.frmBufRec.u32StartPhyAddr);
						stSpecialFrmInfo.enbufferNodeStatus       = ALLOC_INVALID;
					}

		            /*fix me!! 安全的内存能区分吗?*/
					OmxPrint(OMX_INFO,"add list  pstChan->specialFrmRec[%d],u32StartPhyAddr= 0x%x,u32StartVirAddr = 0x%p,u32Size = %d\n",
					            i,stSpecialFrmInfo.frmBufRec.u32StartPhyAddr ,stSpecialFrmInfo.frmBufRec.pu8StartVirAddr,stSpecialFrmInfo.frmBufRec.u32Size);

					ret = OMXVDEC_List_Add(&g_OmxVdec->stRemainFrmList,&stSpecialFrmInfo);
					if (ret != HI_SUCCESS)
					{
					    OmxPrint(OMX_INFO,"OMXVDEC_List_Add return failed! 0x%x\n",ret);
					}
			    }
            }
            break;
#else
        case EVNT_POST_MODULE_OCCUPY_ONE_FRAME:
            if (((HI_U64 *)pargs)[2] == 1)
            {
                if (HI_TRUE == pchan->dfs.occupied_frm_exist)
                {
                    OmxPrint(OMX_ERR, "Occupy Frame Report: but last occupied frm not release yet!!!\n");
                }
                pchan->dfs.occupied_frm_exist   = HI_TRUE;
                pchan->dfs.occupied_frm_phyaddr = ((HI_U64 *)pargs)[0];
            }
            else
            {
                pchan->dfs.occupied_frm_exist   = HI_FALSE;
            }
            break;
#endif
	#endif

		case EVNT_LAST_FRAME:
            OmxPrint(OMX_INFO, "Get Last Frame Report!\n");
            if (HI_NULL == pargs)
            {
                OmxPrint(OMX_ERR, "Last frame report but pargs = NULL\n");
                ret = HI_FAILURE;
                break;
            }

            /* pargs[0]-> 0: success, 1: fail,  2+: report last frame image id */
            ptemp = pargs;
            pchan->last_frame_info[0] = DECODER_REPORT_LAST_FRAME;
            pchan->last_frame_info[1] = ptemp[0];
            if (REPORT_LAST_FRAME_SUCCESS == ptemp[0])
            {
                OmxPrint(OMX_INFO, "Last frame report success!\n");
            }
            else if (REPORT_LAST_FRAME_FAIL == ptemp[0])
            {
                OmxPrint(OMX_ERR, "Last frame report failed!\n");
            }
            else
            {
                pchan->last_frame_info[1]  = REPORT_LAST_FRAME_WITH_ID;
                pchan->last_frame_image_id = ptemp[0];
                OmxPrint(OMX_ERR, "Last frame report image id %d!\n", pchan->last_frame_image_id);
            }
            break;

       	default:
            //OmxPrint(OMX_INFO, "\nUnsupport Event Type: 0x%4.4x, arg=%p\n", event_type, pargs);
            break;
	}

	return ret;
}

static HI_S32 decoder_init_option(OMXVDEC_CHAN_CTX *pchan, VDEC_CHAN_CFG_S *pchan_cfg, VDEC_CHAN_CAP_LEVEL_E *pFmwCap, VDEC_CHAN_OPTION_S *pstOption)
{
    eCFG_CAP  ConfigCap = CFG_CAP_HD;

    if (HI_NULL == pchan || HI_NULL == pchan_cfg || HI_NULL == pFmwCap || HI_NULL == pstOption)
    {
        OmxPrint(OMX_FATAL, "%s param invalid!\n", __func__);
        return HI_FAILURE;
    }

    if (STD_VC1 == pchan_cfg->eVidStd
     && 0 == pchan_cfg->StdExt.Vc1Ext.IsAdvProfile)
    {
        pchan->protocol = STD_WMV;
    }
    else
    {
        pchan->protocol = pchan_cfg->eVidStd;
    }

    if ((STD_VP6 == pchan_cfg->eVidStd) || (STD_VP6F == pchan_cfg->eVidStd) || (STD_VP6A == pchan_cfg->eVidStd))
    {
        pchan->bReversed = pchan_cfg->StdExt.Vp6Ext.bReversed;
    }
    else
    {
        pchan->bReversed = 0;
    }

    pstOption->eAdapterType         = ADAPTER_TYPE_OMXVDEC;
    pstOption->MemAllocMode         = MODE_PART_BY_SDK;
    pstOption->s32SupportBFrame     = 1;
    pstOption->s32ReRangeEn         = 1;
    pstOption->s32DisplayFrameNum   = g_DispNum;

    if (pchan->out_width*pchan->out_height > HD_FRAME_WIDTH*HD_FRAME_HEIGHT)
    {
        ConfigCap = CFG_CAP_UHD;
        pstOption->s32MaxWidth   = MAX(UHD_FRAME_WIDTH,  pchan->out_width);
        pstOption->s32MaxHeight  = MAX(UHD_FRAME_HEIGHT, pchan->out_height);
        pstOption->s32SCDBufSize = 4*g_SegSize*1024*1024;
        pstOption->s32MaxRefFrameNum = 4;
    }
    else if(pchan->out_width*pchan->out_height > SD_FRAME_WIDTH*SD_FRAME_HEIGHT)
    {
        ConfigCap = CFG_CAP_HD;
        pstOption->s32MaxWidth   = MAX(HD_FRAME_WIDTH,  pchan->out_width);
        pstOption->s32MaxHeight  = MAX(HD_FRAME_HEIGHT, pchan->out_height);
        pstOption->s32SCDBufSize = g_SegSize*1024*1024;
        pstOption->s32MaxRefFrameNum = 10;
    }
    else
    {
        ConfigCap = CFG_CAP_SD;
        pstOption->s32MaxWidth   = MAX(SD_FRAME_WIDTH,  pchan->out_width);
        pstOption->s32MaxHeight  = MAX(SD_FRAME_HEIGHT, pchan->out_height);
        pstOption->s32SCDBufSize = g_SegSize*1024*1024;
        pstOption->s32MaxRefFrameNum = 12;
    }

	//h263默认设置 1080P能力级
    if(STD_H263 == pchan_cfg->eVidStd)
    {
        ConfigCap = CFG_CAP_HD;
        pstOption->s32MaxWidth   = MAX(HD_FRAME_WIDTH,  pchan->out_width);
        pstOption->s32MaxHeight  = MAX(HD_FRAME_HEIGHT, pchan->out_height);
        pstOption->s32SCDBufSize = g_SegSize*1024*1024;
        pstOption->s32MaxRefFrameNum = 10;
    }

    if (STD_HEVC == pchan_cfg->eVidStd)
    {
        switch (ConfigCap)
        {
            case CFG_CAP_SD:
    	        *pFmwCap = CAP_LEVEL_HEVC_720;
                break;
            case CFG_CAP_HD:
            default:
    	        *pFmwCap = CAP_LEVEL_HEVC_FHD;
                break;
            case CFG_CAP_UHD:
    	        *pFmwCap = CAP_LEVEL_HEVC_UHD;
                break;
        }

        pstOption->s32SupportH264    = 1;
        pstOption->s32MaxSliceNum    = 136;
        pstOption->s32MaxSpsNum      = 32;
        pstOption->s32MaxPpsNum      = 256;
    }
    else if (STD_H264 == pchan_cfg->eVidStd || STD_MVC == pchan_cfg->eVidStd)
    {
        if (STD_MVC == pchan_cfg->eVidStd)
        {
            *pFmwCap = CAP_LEVEL_MVC_FHD;
        }
        else
        {
            switch (ConfigCap)
            {
                case CFG_CAP_SD:
        	        *pFmwCap = CAP_LEVEL_H264_720;
                    break;
                case CFG_CAP_HD:
                default:
        	        *pFmwCap = CAP_LEVEL_H264_FHD;
                    break;
                case CFG_CAP_UHD:
        	        *pFmwCap = CAP_LEVEL_4096x2160;
                    break;
            }
        }

        pstOption->s32SupportH264    = 1;
        pstOption->s32MaxSliceNum    = 136;
        pstOption->s32MaxSpsNum      = 32;
        pstOption->s32MaxPpsNum      = 256;
    }
    else
    {
        switch (ConfigCap)
        {
            case CFG_CAP_SD:
    	        *pFmwCap = CAP_LEVEL_MPEG_720;
                break;
            case CFG_CAP_HD:
            default:
    	        *pFmwCap = CAP_LEVEL_MPEG_FHD;
                break;
            case CFG_CAP_UHD:
    	        *pFmwCap = CAP_LEVEL_4096x2160;
                break;
        }

        if (STD_VP8 == pchan_cfg->eVidStd)
        {
            pstOption->s32MaxRefFrameNum = 3;
        }
        else
        {
            pstOption->s32MaxRefFrameNum = 2;
        }
    }

    if (HI_TRUE == g_DynamicFsEnable
     && STD_H263     != pchan_cfg->eVidStd
     && STD_SORENSON != pchan_cfg->eVidStd)
    {
        pstOption->u32DynamicFrameStoreAllocEn = 1;
        pstOption->s32ExtraFrameStoreNum       = g_DispNum;
        pstOption->u32CfgFrameNum              = 0;
        pstOption->s32DelayTime                = 0;
        pstOption->u32MaxMemUse                = -1;

	#if (VFMW_FLAG == 4)
        pstOption->u32SelfAdaptionDFS          = 1;
        pstOption->u32NeedMMZ                  = 1;
	#endif
    }

    return HI_SUCCESS;
}

static HI_S32 decoder_get_stream(HI_S32 chan_id, STREAM_DATA_S *stream_data)
{
	HI_S32 ret = HI_FAILURE;
	unsigned long flags;
	OMXVDEC_BUF_S *pbuf     = HI_NULL;
	OMXVDEC_CHAN_CTX *pchan = HI_NULL;

	pchan = channel_find_inst_by_channel_id(g_OmxVdec, chan_id);
	if (HI_NULL == pchan)
    {
        OmxPrint(OMX_FATAL, "%s can't find Chan(%d).\n", __func__, chan_id);
        return HI_FAILURE;
	}

	spin_lock_irqsave(&pchan->chan_lock, flags);
	if (pchan->state != CHAN_STATE_WORK)
    {
		spin_unlock_irqrestore(&pchan->chan_lock, flags);
		return HI_FAILURE;
	}
	spin_unlock_irqrestore(&pchan->chan_lock, flags);

	spin_lock_irqsave(&pchan->raw_lock, flags);
	if (list_empty(&pchan->raw_queue))
    {
		spin_unlock_irqrestore(&pchan->raw_lock, flags);
		return HI_FAILURE;
	}

	if (pchan->input_flush_pending)
    {
		spin_unlock_irqrestore(&pchan->raw_lock, flags);
        OmxPrint(OMX_INBUF, "Invalid: input_flush_pending\n");
		return HI_FAILURE;
	}

	list_for_each_entry(pbuf, &pchan->raw_queue, list)
    {
		if(BUF_STATE_USING == pbuf->status)
        {
			continue;
        }

        memset(stream_data, 0, sizeof(STREAM_DATA_S));

        pbuf->status                      = BUF_STATE_USING;
		stream_data->PhyAddr	          = pbuf->phy_addr + pbuf->offset;

	#if (VFMW_FLAG == 4)
		stream_data->VirAddr	          = pbuf->kern_vaddr + pbuf->offset;
	#else
		stream_data->VirAddr	          = (UINT64)(HI_SIZE_T)(pbuf->kern_vaddr + pbuf->offset);
	#endif

		stream_data->Length	              = pbuf->act_len;
		stream_data->Pts	              = pbuf->time_stamp;
		stream_data->RawExt.Flags         = pbuf->flags;
		stream_data->RawExt.BufLen        = pbuf->buf_len;
		stream_data->RawExt.CfgWidth      = pchan->out_width;
		stream_data->RawExt.CfgHeight     = pchan->out_height;
        stream_data->UserTag              = pbuf->usr_tag;

        if (pchan->seek_pending)
        {
            stream_data->RawExt.IsSeekPending = 1;
            pchan->seek_pending = 0;
        }

        if (pbuf->flags & VDEC_BUFFERFLAG_ENDOFFRAME)
        {
            stream_data->is_not_last_packet_flag = 0;
        }
        else
        {
            stream_data->is_not_last_packet_flag = 1;
        }

        if (pbuf->buf_id == LAST_FRAME_BUF_ID)
        {
            OmxPrint(OMX_INFO, "vfmw read last frame.\n");
            stream_data->is_stream_end_flag = 1;
        }

		pchan->raw_use_cnt++;

        OmxPrint(OMX_PTS, "Get Time Stamp: %lld\n", stream_data->Pts);

		ret = HI_SUCCESS;

        if ((pchan->bLowdelay || g_FastOutputMode) && (NULL != pchan->omx_vdec_lowdelay_proc_rec))
        {
            channel_add_lowdelay_tag_time(pchan, stream_data->UserTag, OMX_LOWDELAY_REC_VFMW_RCV_STRM_TIME, OMX_GetTimeInMs());
        }

        OmxPrint(OMX_INBUF, "VFMW got stream: PhyAddr = 0x%08x, Len = %d\n",
                 stream_data->PhyAddr, stream_data->Length);
        pchan->omx_chan_statinfo.DecoderIn++;
		break;
	}

	spin_unlock_irqrestore(&pchan->raw_lock, flags);

	return ret;
}

static HI_S32 decoder_release_stream(HI_S32 chan_id, STREAM_DATA_S *stream_data)
{
	unsigned long flags;
	HI_S32        is_find = 0;
	OMXVDEC_BUF_S    *pbuf  = HI_NULL;
    OMXVDEC_BUF_S    *ptmp  = HI_NULL;
	OMXVDEC_CHAN_CTX *pchan = HI_NULL;

	OMXVDEC_BUF_DESC  user_buf;

	if (HI_NULL == stream_data)
    {
        OmxPrint(OMX_FATAL, "%s stream_data = NULL.\n", __func__);
        return HI_FAILURE;
	}

	pchan = channel_find_inst_by_channel_id(g_OmxVdec, chan_id);
	if (HI_NULL == pchan)
    {
        OmxPrint(OMX_FATAL, "%s can't find Chan(%d).\n", __func__, chan_id);
        return HI_FAILURE;
	}

	/* for we del element during, so use safe methods for list */
	spin_lock_irqsave(&pchan->raw_lock, flags);
	if (list_empty(&pchan->raw_queue))
    {
        spin_unlock_irqrestore(&pchan->raw_lock, flags);
        OmxPrint(OMX_ERR, "%s: list is empty\n", __func__);
        return 0;
    }

	list_for_each_entry_safe(pbuf, ptmp, &pchan->raw_queue, list)
    {
		if (stream_data->PhyAddr == (pbuf->phy_addr + pbuf->offset))
        {
			if (BUF_STATE_USING != pbuf->status)
            {
               OmxPrint(OMX_ERR, "%s: buf(0x%08x) flag confused!\n",__func__,  stream_data->PhyAddr);
            }

            pbuf->status = BUF_STATE_IDLE;
			list_del(&pbuf->list);
			is_find = 1;
			break;
		}
	}

	if (!is_find)
    {
	    spin_unlock_irqrestore(&pchan->raw_lock, flags);
        OmxPrint(OMX_ERR, "%s: buffer(0x%08x) not in queue!\n", __func__, stream_data->PhyAddr);
        return HI_FAILURE;
	}

    if (pbuf->buf_id != LAST_FRAME_BUF_ID)
    {
        /* let msg to indicate buffer was given back */

        user_buf.dir         = PORT_DIR_INPUT;
        user_buf.bufferaddr  = (HI_SIZE_T)pbuf->user_vaddr;
        user_buf.buffer_len  = pbuf->buf_len;
        user_buf.client_data = (HI_SIZE_T)pbuf->client_data;
        user_buf.data_len    = 0;
        user_buf.timestamp   = 0;
        user_buf.phyaddr     = pbuf->phy_addr;

        pbuf->act_len        = user_buf.data_len;

        message_queue(pchan->msg_queue, VDEC_MSG_RESP_INPUT_DONE, VDEC_S_SUCCESS, (HI_VOID *)&user_buf);
		pchan->omx_chan_statinfo.EBD++;
    }
	else
	{
        pchan->eos_in_list = 0;
	    OmxPrint(OMX_INFO, "vfmw release last frame.\n");
	}

	pchan->raw_use_cnt = (pchan->raw_use_cnt > 0) ? (pchan->raw_use_cnt-1) : 0;

	if (pchan->input_flush_pending && (pchan->raw_use_cnt == 0))
    {
        OmxPrint(OMX_INBUF, "%s: input flush done!\n", __func__);
		message_queue(pchan->msg_queue, VDEC_MSG_RESP_FLUSH_INPUT_DONE, VDEC_S_SUCCESS, HI_NULL);
		pchan->input_flush_pending = 0;
	}

    if ((pchan->bLowdelay || g_FastOutputMode) && (NULL != pchan->omx_vdec_lowdelay_proc_rec))
    {
        channel_add_lowdelay_tag_time(pchan, stream_data->UserTag, OMX_LOWDELAY_REC_VFMW_RLS_STRM_TIME, OMX_GetTimeInMs());
    }
	spin_unlock_irqrestore(&pchan->raw_lock, flags);

    OmxPrint(OMX_INBUF, "VFMW release stream: PhyAddr = 0x%08x, Len = %d\n",
                        stream_data->PhyAddr, stream_data->Length);

    return HI_SUCCESS;

}

static inline HI_S32 decoder_clear_stream(OMXVDEC_CHAN_CTX *pchan)
{
	HI_S32 ret = HI_FAILURE;

    OmxPrint(OMX_TRACE, "%s enter!\n", __func__);

	ret = (pVfmwFunc->pfnVfmwControl)(pchan->decoder_id, VDEC_CID_RELEASE_STREAM, HI_NULL);
    if (ret != HI_SUCCESS)
    {
        OmxPrint(OMX_FATAL, "%s release stream failed\n", __func__);
        return ret;
    }

    OmxPrint(OMX_TRACE, "%s exit normally!\n", __func__);

	return HI_SUCCESS;
}

static inline HI_S32 decoder_alloc_mem(OMXVDEC_CHAN_CTX *pchan, HI_VOID *pFsParam)
{
	HI_S32 ret = HI_FAILURE;

    OmxPrint(OMX_TRACE, "%s enter!\n", __func__);

    ret = (pVfmwFunc->pfnVfmwControl)(pchan->decoder_id, VDEC_CID_ALLOC_MEM_TO_CHANNEL, pFsParam);
    if (ret != HI_SUCCESS)
    {
        OmxPrint(OMX_FATAL, "%s alloc mem to channel failed\n", __func__);
        return ret;
    }

    OmxPrint(OMX_TRACE, "%s exit normally!\n", __func__);

	return HI_SUCCESS;
}

static inline HI_S32 decoder_config_mem(OMXVDEC_CHAN_CTX *pchan, HI_VOID *pFsParam)
{
	HI_S32 ret = HI_FAILURE;

    OmxPrint(OMX_TRACE, "%s enter!\n", __func__);

    ret = (pVfmwFunc->pfnVfmwControl)(pchan->decoder_id, VDEC_CID_ALLOC_MEM_TO_DECODER, pFsParam);
    if (ret != HI_SUCCESS)
    {
        OmxPrint(OMX_FATAL, "%s config mem to channel failed\n", __func__);
        return HI_FAILURE;
    }

    OmxPrint(OMX_TRACE, "%s exit normally!\n", __func__);

	return HI_SUCCESS;
}


/*============ EXPORT INTERFACE =============*/
HI_S32 decoder_init(HI_VOID)
{
    HI_S32 ret = HI_FAILURE;
    VDEC_OPERATION_S stInitParam;

    OmxPrint(OMX_TRACE, "%s enter!\n", __func__);

    pVfmwFunc = HI_NULL;

    ret = HI_DRV_MODULE_GetFunction(HI_ID_VFMW, (HI_VOID**)&g_stOmxFunc.pDecoderFunc);
    if (HI_SUCCESS != ret || HI_NULL == g_stOmxFunc.pDecoderFunc)
    {
        OmxPrint(OMX_FATAL, "%s get vfmw function failed!\n", __func__);
        return HI_FAILURE;
    }

    pVfmwFunc = (VFMW_EXPORT_FUNC_S *)(g_stOmxFunc.pDecoderFunc);

    memset(&stInitParam, 0, sizeof(VDEC_OPERATION_S));

    stInitParam.eAdapterType = ADAPTER_TYPE_OMXVDEC;
    stInitParam.mem_malloc   = HI_NULL;
    stInitParam.mem_free     = HI_NULL;
    stInitParam.VdecCallback = decoder_event_handler;

    ret = (pVfmwFunc->pfnVfmwInitWithOperation)(&stInitParam);
    if (ret != HI_SUCCESS)
    {
        OmxPrint(OMX_FATAL, "%s init vfmw failed!\n", __func__);
        return HI_FAILURE;
    }

    OmxPrint(OMX_TRACE, "%s exit normally!\n", __func__);

    return HI_SUCCESS;
}

HI_S32 decoder_exit(HI_VOID)
{
    HI_S32 ret = HI_FAILURE;

    OmxPrint(OMX_TRACE, "%s enter!\n", __func__);

    ret = (pVfmwFunc->pfnVfmwExit)();
    if (ret != HI_SUCCESS)
    {
        OmxPrint(OMX_FATAL, "%s exit vfmw failed!\n", __func__);
        return ret;
    }

    OmxPrint(OMX_TRACE, "%s exit normally!\n", __func__);

    return HI_SUCCESS;
}

#ifdef HI_OMX_TEE_SUPPORT
HI_S32 decoder_init_trusted(HI_VOID)
{
    HI_S32 ret = HI_FAILURE;
    VDEC_OPERATION_S stInitParam;

    OmxPrint(OMX_TRACE, "%s enter!\n", __func__);

    memset(&stInitParam, 0, sizeof(VDEC_OPERATION_S));

    stInitParam.eAdapterType = ADAPTER_TYPE_OMXVDEC;
    stInitParam.VdecCallback = decoder_event_handler;

	stInitParam.mem_malloc   = HI_NULL;
    stInitParam.mem_free     = HI_NULL;
    ret = (pVfmwFunc->pfnVfmwTrustDecoderInit)(&stInitParam);
    if (ret != HI_SUCCESS)
    {
        OmxPrint(OMX_FATAL, "Init trusted decoder failed!n");
        return ret;
    }

    OmxPrint(OMX_TRACE, "%s exit normally!\n", __func__);

    return HI_SUCCESS;
}

HI_S32 decoder_exit_trusted(HI_VOID)
{
    HI_S32 ret = HI_FAILURE;

    OmxPrint(OMX_TRACE, "%s enter!\n", __func__);

    ret = (pVfmwFunc->pfnVfmwTrustDecoderExit)();
    if (ret != HI_SUCCESS)
    {
        OmxPrint(OMX_FATAL, "Exit trusted decoder failed\n");
        return ret;
    }

    OmxPrint(OMX_TRACE, "%s exit normally!\n", __func__);

    return HI_SUCCESS;
}
#endif

HI_S32 decoder_create_inst(OMXVDEC_CHAN_CTX *pchan, OMXVDEC_DRV_CFG *pdrv_cfg)
{
    HI_S32 ret = HI_FAILURE;
    HI_S8 as8TmpBuf[128];
    VDEC_CHAN_CAP_LEVEL_E enFmwCap;
    HI_U32                u32VDHSize = 0;
    VDEC_CHAN_OPTION_S    stOption;
    DETAIL_MEM_SIZE       stMemSize;
    VDEC_CHAN_CFG_S      *pchan_cfg = HI_NULL;

    OmxPrint(OMX_TRACE, "%s enter!\n", __func__);

    memset(&stOption,  0, sizeof(VDEC_CHAN_OPTION_S));
    memset(&stMemSize, 0, sizeof(DETAIL_MEM_SIZE));

#ifdef HI_OMX_TEE_SUPPORT
    if (HI_TRUE == pchan->is_tvp)
    {
        ret = decoder_init_trusted();
        if (ret != HI_SUCCESS)
        {
            OmxPrint(OMX_FATAL, "%s call decoder_init_trusted failed\n", __func__);
            return HI_FAILURE;
        }
    }
#endif

    pchan_cfg = &pdrv_cfg->chan_cfg;
    ret = decoder_init_option(pchan, pchan_cfg, &enFmwCap, &stOption);
    if (ret != HI_SUCCESS)
    {
        OmxPrint(OMX_FATAL, "%s call decoder_init_option failed\n", __func__);
        goto error0;
    }

#if (VFMW_FLAG == 4)
    ((HI_SIZE_T*)as8TmpBuf)[0] = (HI_SIZE_T)enFmwCap;
    ((HI_SIZE_T*)as8TmpBuf)[1] = (HI_SIZE_T)&stOption; //@l00284814 64bit
#else
    ((HI_U64*)as8TmpBuf)[0] = (HI_U64)enFmwCap;
    ((HI_U64*)as8TmpBuf)[1] = (HI_U64)(HI_SIZE_T)&stOption; //@l00284814 64bit
#endif

    ret = (pVfmwFunc->pfnVfmwControl)(-1, VDEC_CID_GET_CHAN_DETAIL_MEMSIZE_WITH_OPTION, as8TmpBuf);
    if (ret != HI_SUCCESS)
    {
        OmxPrint(OMX_FATAL, "%s call GET_CHAN_DETAIL_MEMSIZE failed\n", __func__);
        goto error0;
    }

    stMemSize = *(DETAIL_MEM_SIZE *)as8TmpBuf;

#ifdef HI_OMX_TEE_SUPPORT
    if (HI_TRUE == pchan->is_tvp)
    {
        memset(&pchan->decoder_vdh_buf, 0, sizeof(MMZ_BUFFER_S));
        memset(&pchan->decoder_scd_buf, 0, sizeof(MMZ_BUFFER_S));

        stOption.s32IsSecMode = 1;
        stOption.MemAllocMode = MODE_ALL_BY_MYSELF;
        stOption.MemDetail.ChanMemScd.Length  = 0;
        stOption.MemDetail.ChanMemScd.PhyAddr = 0;
        stOption.MemDetail.ChanMemScd.VirAddr = HI_NULL;
        stOption.MemDetail.ChanMemCtx.Length  = 0;
        stOption.MemDetail.ChanMemCtx.PhyAddr = 0;
        stOption.MemDetail.ChanMemCtx.VirAddr = HI_NULL;
        stOption.MemDetail.ChanMemVdh.Length  = 0;
        stOption.MemDetail.ChanMemVdh.PhyAddr = 0;
        stOption.MemDetail.ChanMemVdh.VirAddr = HI_NULL;
    }
    else
#endif
    {
	    stOption.s32IsSecMode = 0;

        /* Allocate frame buffer memory(VDH) */
        if (STD_H263 == pchan->protocol || STD_SORENSON == pchan->protocol)  // 内核态软解所需帧存大小指定
        {
            if (enFmwCap < CAP_LEVEL_MPEG_FHD)
            {
                u32VDHSize = SOFT_DEC_MIN_MEM_SD;
            }
            else
            {
                u32VDHSize = SOFT_DEC_MIN_MEM_HD;
            }
        }
        else
        {
            u32VDHSize = stMemSize.VdhDetailMem;
        }

        if (1 == stOption.u32DynamicFrameStoreAllocEn
            && STD_H263     != pchan->protocol
            && STD_SORENSON != pchan->protocol)
        {
            stOption.MemDetail.ChanMemVdh.Length  = 0;
            stOption.MemDetail.ChanMemVdh.PhyAddr = 0;
            stOption.MemDetail.ChanMemVdh.VirAddr = HI_NULL;
        }
        else if (STD_H263     != pchan->protocol
              && STD_SORENSON != pchan->protocol)
        {
        #if (1 == PRE_ALLOC_VDEC_VDH_MMZ)
            pchan->decoder_vdh_buf.u32Size = u32VDHSize;
            ret = VDEC_Chan_FindPreMMZ(&pchan->decoder_vdh_buf);

            //if pre alloc mmz not available,alloc it by mmz
            if (ret != HI_SUCCESS)
            {
                ret = HI_DRV_OMXVDEC_Alloc("OMXVDEC_VDH", HI_NULL, u32VDHSize, 0, &pchan->decoder_vdh_buf, 0);
                pchan->eVDHMemAlloc = ALLOC_BY_MMZ_UNMAP;
            }
            else
            {
                pchan->eVDHMemAlloc = ALLOC_BY_PRE;
            }

        #else

            ret = HI_DRV_OMXVDEC_Alloc("OMXVDEC_VDH", HI_NULL, u32VDHSize, 0, &pchan->decoder_vdh_buf, 0);
            pchan->eVDHMemAlloc = ALLOC_BY_MMZ_UNMAP;
        #endif

            if (ret != HI_SUCCESS)
            {
                OmxPrint(OMX_FATAL, "%s alloc mem for VDH failed\n", __func__);
                goto error0;
            }
        }
        else
        {
            ret = HI_DRV_OMXVDEC_Alloc("OMXVDEC_SOFTVDH", HI_NULL, u32VDHSize, 0, &pchan->decoder_vdh_buf, 0);
            if (ret != HI_SUCCESS)
            {
                OmxPrint(OMX_FATAL, "%s alloc mem for VDH failed\n", __func__);
                goto error0;
            }

            pchan->eVDHMemAlloc = ALLOC_BY_MMZ_UNMAP;

            ret = HI_DRV_OMXVDEC_MapCache(&pchan->decoder_vdh_buf);
            if (ret != HI_SUCCESS)
            {
                OmxPrint(OMX_FATAL, "%s alloc mem for soft VDH failed\n", __func__);
                omxvdec_release_mem(&pchan->decoder_vdh_buf, pchan->eVDHMemAlloc);

                goto error0;
            }

            pchan->eVDHMemAlloc = ALLOC_BY_MMZ;
        }

        stOption.MemDetail.ChanMemVdh.Length  = pchan->decoder_vdh_buf.u32Size;
        stOption.MemDetail.ChanMemVdh.PhyAddr = pchan->decoder_vdh_buf.u32StartPhyAddr;
	#if (VFMW_FLAG == 4)
		stOption.MemDetail.ChanMemVdh.VirAddr = pchan->decoder_vdh_buf.pu8StartVirAddr;
	#else
		stOption.MemDetail.ChanMemVdh.VirAddr = (UINT64)(HI_SIZE_T)pchan->decoder_vdh_buf.pu8StartVirAddr;
	#endif

        /* Alloc SCD buffer */
        if (stMemSize.ScdDetailMem > 0)
        {
            if (STD_H263     != pchan->protocol
              && STD_SORENSON != pchan->protocol)
            {
                ret = HI_DRV_OMXVDEC_AllocAndMap("OMXVDEC_SCD", HI_NULL, stMemSize.ScdDetailMem, 0, &pchan->decoder_scd_buf);
                if (ret != HI_SUCCESS)
                {
                    OmxPrint(OMX_FATAL, "%s alloc mem for SCD failed\n", __func__);
                    omxvdec_release_mem(&pchan->decoder_vdh_buf, pchan->eVDHMemAlloc);

                    goto error0;
                }

                pchan->eSCDMemAlloc = ALLOC_BY_MMZ;
            }
            else
            {
                ret = HI_DRV_OMXVDEC_Alloc("OMXVDEC_SOFTSCD", HI_NULL, stMemSize.ScdDetailMem, 0, &pchan->decoder_scd_buf, 0);
                if (ret != HI_SUCCESS)
                {
                    OmxPrint(OMX_FATAL, "%s alloc mem for soft SCD failed\n", __func__);
                    omxvdec_release_mem(&pchan->decoder_vdh_buf, pchan->eVDHMemAlloc);

                    goto error0;
                }
                pchan->eSCDMemAlloc = ALLOC_BY_MMZ_UNMAP;

                ret = HI_DRV_OMXVDEC_MapCache(&pchan->decoder_scd_buf);
                if (ret != HI_SUCCESS)
                {
                    OmxPrint(OMX_FATAL, "%s alloc mem for soft SCD failed\n", __func__);
                    omxvdec_release_mem(&pchan->decoder_vdh_buf, pchan->eVDHMemAlloc);
                    omxvdec_release_mem(&pchan->decoder_scd_buf, pchan->eSCDMemAlloc);

                    goto error0;
                }
                pchan->eSCDMemAlloc = ALLOC_BY_MMZ;
            }

            /*pstChan->stSCDMMZBuf.u32SizeD的大小就是从vfmw获取的大小:pstChan->stMemSize.ScdDetailMem*/
            stOption.MemDetail.ChanMemScd.Length  = pchan->decoder_scd_buf.u32Size;
            stOption.MemDetail.ChanMemScd.PhyAddr = pchan->decoder_scd_buf.u32StartPhyAddr;
		#if (VFMW_FLAG == 4)
            stOption.MemDetail.ChanMemScd.VirAddr = pchan->decoder_scd_buf.pu8StartVirAddr;
		#else
            stOption.MemDetail.ChanMemScd.VirAddr = (UINT64)(HI_SIZE_T)pchan->decoder_scd_buf.pu8StartVirAddr;
		#endif
        }

        /* Context memory allocated by VFMW */
        /*这部分由vfmw自己进行分配，scd和vdh的内存由vdec进行分配*/
        stOption.MemDetail.ChanMemCtx.Length  = 0;
        stOption.MemDetail.ChanMemCtx.PhyAddr = 0;
        stOption.MemDetail.ChanMemCtx.VirAddr = HI_NULL;
    }

#if (VFMW_FLAG == 4)
    ((HI_SIZE_T*)as8TmpBuf)[0] = (HI_SIZE_T)enFmwCap;
    ((HI_SIZE_T*)as8TmpBuf)[1] = (HI_SIZE_T)&stOption; //@f00241306 64bit  l00284814
#else
    ((HI_U64*)as8TmpBuf)[0] = (HI_U64)enFmwCap;
    ((HI_U64*)as8TmpBuf)[1] = (HI_U64)(HI_SIZE_T)&stOption; //@l00284814 64bit
#endif

    ret = (pVfmwFunc->pfnVfmwControl)(-1, VDEC_CID_CREATE_CHAN_WITH_OPTION, as8TmpBuf);
    if (ret != HI_SUCCESS)
    {
        OmxPrint(OMX_FATAL, "%s CREATE_CHAN_WITH_OPTION failed:%#x\n", __func__, ret);
        goto error1;
    }

    pchan->decoder_id = *(HI_U32 *)as8TmpBuf;
    OmxPrint(OMX_INFO, "Create decoder %d success!\n", pchan->decoder_id);

    // 如果不使能码流移动功能，将码流包个数设置最大即可
    if (HI_FALSE == g_RawMoveEnable)
    {
        pchan_cfg->s32MaxRawPacketNum = -1;
    }

    /* 在云游戏的场景，视频为H264，只有IP帧，如果使能快速输出模式，
       设置IP_MODE,SIMPLE_DPB,SCD lowdly
    */
    if ( HI_TRUE == pchan->bLowdelay || HI_TRUE == g_FastOutputMode)
    {
    	pchan_cfg->s32DecMode         = IP_MODE;

        /* set to 1 means Orderoutput */
    	pchan_cfg->s32DecOrderOutput  = 1;
        pchan_cfg->s32LowdlyEnable    = HI_FALSE;
        pchan_cfg->s32ModuleLowlyEnable = HI_TRUE;
        pchan_cfg->s32ChanLowlyEnable = HI_TRUE;
    }

    //set the decode max w&h
    pchan_cfg->s32MaxWidth = UHD_FRAME_WIDTH;
	pchan_cfg->s32MaxHeight = UHD_FRAME_HEIGHT;

    ret = (pVfmwFunc->pfnVfmwControl)(pchan->decoder_id, VDEC_CID_CFG_CHAN, pchan_cfg);
    if (ret != HI_SUCCESS)
    {
        OmxPrint(OMX_FATAL, "%s CFG_CHAN failed\n", __func__);
        goto error2;
    }

    pchan->stream_ops.stream_provider_inst_id = pchan->channel_id;
    pchan->stream_ops.read_stream = decoder_get_stream;
    pchan->stream_ops.release_stream = decoder_release_stream;
    ret = (pVfmwFunc->pfnVfmwControl)(pchan->decoder_id, VDEC_CID_SET_STREAM_INTF, &pchan->stream_ops);
    if (ret != HI_SUCCESS)
    {
        OmxPrint(OMX_FATAL, "%s SET_STREAM_INTF failed\n", __func__);
        goto error2;
    }

    pchan->image_ops.image_provider_inst_id = pchan->channel_id;
    ret = (pVfmwFunc->pfnVfmwControl)(pchan->decoder_id, VDEC_CID_GET_IMAGE_INTF, &pchan->image_ops);
    if (ret != HI_SUCCESS)
    {
        OmxPrint(OMX_FATAL, "%s GET_IMAGE_INTF failed\n", __func__);
        goto error2;
    }

    if (HI_TRUE == g_LowDelayStatistics)
    {
        HI_HANDLE hHandle = 0;

        hHandle = (HI_ID_VDEC << 16) | pchan->channel_id;

        ret = (pVfmwFunc->pfnVfmwControl)(pchan->decoder_id, VDEC_CID_START_LOWDLAY_CALC, &hHandle);
        if (HI_SUCCESS != ret)
        {
            OmxPrint(OMX_FATAL, "%s call VDEC_CID_START_LOWDLAY_CALC failed, ret = %d!\n", __func__, ret);
            return HI_FAILURE;
        }
             HI_DRV_LD_Start_Statistics(SCENES_VID_PLAY, hHandle);
    }

    OmxPrint(OMX_TRACE, "%s exit normally!\n", __func__);

    return HI_SUCCESS;

error2:
    ret = (pVfmwFunc->pfnVfmwControl)(pchan->decoder_id, VDEC_CID_DESTROY_CHAN, HI_NULL);
    if (ret != HI_SUCCESS)
    {
        OmxPrint(OMX_FATAL, "%s DESTROY_CHAN failed\n", __func__);
    }

error1:
	omxvdec_release_mem(&pchan->decoder_scd_buf, pchan->eSCDMemAlloc);
	omxvdec_release_mem(&pchan->decoder_vdh_buf, pchan->eVDHMemAlloc);

error0:
#ifdef HI_OMX_TEE_SUPPORT
    if (HI_TRUE == pchan->is_tvp)
    {
        ret = decoder_exit_trusted();
        if (ret != HI_SUCCESS)
        {
            OmxPrint(OMX_FATAL, "decoder_exit_trusted failed\n");
        }
    }
#endif

    return HI_FAILURE;
}

HI_S32 decoder_release_inst(OMXVDEC_CHAN_CTX *pchan)
{
    HI_U32 i = 0;
    DSF_SINGLE_BUF_S *pBufSlot = HI_NULL;

    HI_S32 ret = HI_FAILURE;

    OmxPrint(OMX_TRACE, "%s enter!\n", __func__);

    ret = (pVfmwFunc->pfnVfmwControl)(pchan->decoder_id, VDEC_CID_DESTROY_CHAN, HI_NULL);
    if (ret != HI_SUCCESS)
    {
       OmxPrint(OMX_FATAL, "%s destroy vfmw failed\n", __func__);
       //return ret;  /* 不退出，强制释放资源 */
    }

#ifdef HI_OMX_TEE_SUPPORT
    if (HI_TRUE == pchan->is_tvp)
    {
        ret = decoder_exit_trusted();
        if (ret != HI_SUCCESS)
        {
            OmxPrint(OMX_FATAL, "decoder_exit_trusted failed\n");
        }
    }
#endif

    omxvdec_release_mem(&pchan->decoder_scd_buf, pchan->eSCDMemAlloc);
    omxvdec_release_mem(&pchan->decoder_vdh_buf, pchan->eVDHMemAlloc);

#ifdef 	VFMW_VPSS_BYPASS_EN
    for (i=0; i < MAX_DFS_BUF_NUM; i++)
	{
        pBufSlot = &(pchan->dfs.single_buf[i]);

        if (pBufSlot->frm_buf.u32StartPhyAddr == 0 || pBufSlot->frm_buf.u32Size == 0)
        {
			continue;
		}

		if (!((0 != g_OmxVdec->stRemainFrmList.s32Num) && (channel_IsOccupiedFrm(pBufSlot->frm_buf.u32StartPhyAddr,HI_NULL))))
		{
		    /* this frame isn't occupied frame, can be released now */
	        if (pBufSlot->pmv_buf.u32StartPhyAddr != 0 && pBufSlot->pmv_buf.u32Size != 0)
	        {
	            omxvdec_release_mem(&pBufSlot->pmv_buf, pBufSlot->pmv_buf_type);
	        }
	        if (pBufSlot->frm_buf.u32StartPhyAddr != 0 && pBufSlot->frm_buf.u32Size != 0)
	        {
	            omxvdec_release_mem(&pBufSlot->frm_buf, pBufSlot->frm_buf_type);
	        }
		}
		else
		{
		    /* occupied frame's pmv buffer can't be used by other moudle,so can be released now */
	        if (pBufSlot->pmv_buf.u32StartPhyAddr != 0 && pBufSlot->pmv_buf.u32Size != 0)
	        {
	            omxvdec_release_mem(&pBufSlot->pmv_buf, pBufSlot->pmv_buf_type);
	        }
		}
	}
#else
    for (i=0; i < MAX_DFS_BUF_NUM; i++)
	{
        pBufSlot = &(pchan->dfs.single_buf[i]);
        if (pBufSlot->pmv_buf.u32StartPhyAddr != 0 && pBufSlot->pmv_buf.u32Size != 0)
        {
            omxvdec_release_mem(&pBufSlot->pmv_buf, pBufSlot->pmv_buf_type);
        }
        if (pBufSlot->frm_buf.u32StartPhyAddr != 0 && pBufSlot->frm_buf.u32Size != 0)
        {
            omxvdec_release_mem(&pBufSlot->frm_buf, pBufSlot->frm_buf_type);
        }
	}
#endif

    OmxPrint(OMX_TRACE, "%s exit normally!\n", __func__);

    return ret;
}

HI_S32 decoder_start_inst(OMXVDEC_CHAN_CTX *pchan)
{
	HI_S32 ret = HI_FAILURE;

    OmxPrint(OMX_TRACE, "%s enter!\n", __func__);

	ret = (pVfmwFunc->pfnVfmwControl)(pchan->decoder_id, VDEC_CID_START_CHAN, HI_NULL);
    if (ret != HI_SUCCESS)
    {
        OmxPrint(OMX_FATAL, "%s start vfmw failed\n", __func__);
        return ret;
	}

    OmxPrint(OMX_TRACE, "%s exit normally!\n", __func__);

	return HI_SUCCESS;
}

HI_S32 decoder_stop_inst(OMXVDEC_CHAN_CTX *pchan)
{
	HI_S32 ret = HI_FAILURE;

    OmxPrint(OMX_TRACE, "%s enter!\n", __func__);

    ret = (pVfmwFunc->pfnVfmwControl)(pchan->decoder_id, VDEC_CID_STOP_CHAN, HI_NULL);
    if (ret != HI_SUCCESS)
    {
        OmxPrint(OMX_FATAL, "%s stop vfmw failed\n", __func__);
        return ret;
	}

    OmxPrint(OMX_TRACE, "%s exit normally!\n", __func__);

	return HI_SUCCESS;
}

HI_S32 decoder_reset_inst(OMXVDEC_CHAN_CTX *pchan)
{
	HI_S32 ret = HI_FAILURE;

    OmxPrint(OMX_TRACE, "%s enter!\n", __func__);

	ret = (pVfmwFunc->pfnVfmwControl)(pchan->decoder_id, VDEC_CID_RESET_CHAN, HI_NULL);
	if (ret != HI_SUCCESS)
    {
        OmxPrint(OMX_FATAL, "%s reset vfmw failed\n", __func__);
        return ret;
	}

    OmxPrint(OMX_TRACE, "%s exit normally!\n", __func__);

	return HI_SUCCESS;
}

HI_S32 decoder_reset_inst_with_option(OMXVDEC_CHAN_CTX *pchan)
{
	HI_S32 ret = HI_FAILURE;
    VDEC_CHAN_RESET_OPTION_S  Option;

    OmxPrint(OMX_TRACE, "%s enter!\n", __func__);

    Option.s32KeepBS     = 0;
    Option.s32KeepSPSPPS = 1;
#if (VFMW_FLAG == 5)
	Option.s32KeepFSP    = 1;
#endif
    ret = (pVfmwFunc->pfnVfmwControl)(pchan->decoder_id, VDEC_CID_RESET_CHAN_WITH_OPTION, &Option);
    if (ret != HI_SUCCESS)
    {
        OmxPrint(OMX_FATAL, "%s reset vfmw with option failed\n", __func__);
        return ret;
    }

    OmxPrint(OMX_TRACE, "%s exit normally!\n", __func__);

	return HI_SUCCESS;
}

HI_S32 decoder_command_handler(OMXVDEC_CHAN_CTX *pchan, DECODER_CMD_E eCmd, HI_VOID* pArgs)
{
	HI_S32 ret = HI_FAILURE;

    OmxPrint(OMX_TRACE, "%s enter!\n", __func__);

    switch(eCmd)
    {
        case DEC_CMD_CLEAR_STREAM:
            ret = decoder_clear_stream(pchan);
            break;

        case DEC_CMD_ALLOC_MEM:
            ret = decoder_alloc_mem(pchan, pArgs);
            break;

        case DEC_CMD_CONFIG_MEM:
            ret = decoder_config_mem(pchan, pArgs);
            break;

        default:
            OmxPrint(OMX_FATAL, "%s unkown command %d\n", __func__, eCmd);
            break;
    }

    OmxPrint(OMX_TRACE, "%s exit normally!\n", __func__);

	return ret;
}




