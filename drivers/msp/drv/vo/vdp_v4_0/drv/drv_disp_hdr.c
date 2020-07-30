/******************************************************************************
  Copyright (C), 2001-2015, Hisilicon Tech. Co., Ltd.
 ******************************************************************************
  File Name     : drv_disp_hdr.c
  Version       : Initial Draft
  Author        : Hisilicon multimedia software group
  Created       : 2015-09-23
  Description   : Dolby HDR processing functions.
  History       :
  1.Date        : 2015-09-23
    Author      : q00293180
    Modification: Created file
*******************************************************************************/
#include "drv_disp_priv.h"
#include "drv_disp_bufcore.h"
#include "hi_drv_hdmi.h"
#include "hi_drv_module.h"


#include "drv_disp_hdr.h"
#include "drv_vdp_hdr_com.h"

#include "KdmTypeFxp.h"
#include "vdp_drv_hihdr.h"

#ifdef __cplusplus
#if __cplusplus
extern "C"
{
#endif
#endif
/******************************************************************************
    define functions
*******************************************************************************/
//purpose of function below is to get EL and MD from a buf Node through BL frame.
#ifndef offsetof
#ifdef __compiler_offsetof
#define offsetof(TYPE,MEMBER) __compiler_offsetof(TYPE,MEMBER)
#else
#define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
#endif
#endif

#ifndef container_of
#define container_of(ptr,type,member) ({  \
        const typeof(((type *)0)->member) *__mptr = (ptr);    \
        (type *)((char*)__mptr - offsetof( type , member)); } )
#endif

/******************************************************************************
    global variable
*******************************************************************************/
static HDMI_EXPORT_FUNC_S   *s_pstHDMIFunc = HI_NULL;
extern DISP_DEV_S s_stDisplayDevice;

//static HI_BOOL              bHDMIFuncInit  = HI_FALSE;

//use below DmKs temply,just for testing.It will initialize when disp init.
//DmKsFxp_t       *pg_stDmKs = HI_NULL;

/******************************************************************************
    extern function
*******************************************************************************/


/******************************************************************************
    internal function
*******************************************************************************/
/********************************************************************************
para[in] : pstWinDoviRefInfo, win info that disp process HDR will refer to.
para[in] : pstPlayInfo, record play info including last work mode and last play mode.
retval     HI_DRV_DISP_WORKING_MODE_E   working mode after decision.
working mode:judge SDR-Path process or HDR-Path process.
********************************************************************************/
HI_DRV_DISP_WORKING_MODE_E DISP_WorkingModePolicy(WINDOW_DOLBY_REFERENCE_INFO_S* pstWinDoviRefInfo,
                                                  HI_DRV_DISP_PLAY_INFO_S       *pstPlayInfo)
{
    HI_BOOL               bCloseHDRPath = HI_FALSE;
    HI_DRV_VIDEO_FRAME_S  *pCurrentFrm   = HI_NULL;
    DISP_BUF_NODE_S       *pstDispBufNode = HI_NULL;

    if (HI_NULL == pstWinDoviRefInfo)
    {
        DISP_ERROR("pstWinDoviRefInfo is null!\n");
        return HI_DRV_DISP_WORKING_MODE_SDR;
    }

    if (HI_NULL == pstPlayInfo)
    {
        DISP_ERROR("pstPlayInfo is null!\n");
        return HI_DRV_DISP_WORKING_MODE_SDR;
    }

    if (pstPlayInfo->enLastPlayMode >= HI_DRV_HDR_PLAY_MODE_BUTT)
    {
        DISP_ERROR("enLastPlayMode is invalid!\n");
        return HI_DRV_DISP_WORKING_MODE_SDR;
    }

    pCurrentFrm = pstWinDoviRefInfo->pCurrentFrame;
    GetHDRPathStatus(&bCloseHDRPath);

    /*step1 : when HD win num > 1 or close HDR path, will go through SDR path.*/
    if ((pstWinDoviRefInfo->u32HDDispWinNum > 1) ||
        (bCloseHDRPath))
    {
        return HI_DRV_DISP_WORKING_MODE_SDR;
    }
    else
    {
        /*step2 : when HD win num == 1 and is enable,process path decided by frm type. */
        if((1 == pstWinDoviRefInfo->u32HDDispWinNum) &&
           (pstWinDoviRefInfo->bHdrWinStatus))
        {
            if (pCurrentFrm != HI_NULL)
            {
                pstDispBufNode = container_of((HI_U32*)pCurrentFrm,DISP_BUF_NODE_S,u32Data[0]);
                if (HI_DRV_VIDEO_FRAME_TYPE_DOLBY_BL == pCurrentFrm->enSrcFrameType)
                {
                    /* dolby frame type will go through Dolby-HDR path. */
                    return HI_DRV_DISP_WORKING_MODE_DOLBY_HDR;
                }
                else if (HI_DRV_VIDEO_FRAME_TYPE_HDR10 == pCurrentFrm->enSrcFrameType)
                {
                    if(pstDispBufNode->bHisiHdr)
                    {
                        /* hdr10 frame type will go through Hdr10-HDR path. */
                        return HI_DRV_DISP_WORKING_MODE_HISI_HDR10;
                    }
                    else
                    {
                        /* hdr10 frame type will go through Hdr10-HDR path. */
                        return HI_DRV_DISP_WORKING_MODE_DOLBY_HDR10;
                    }
                    
                }
                else
                {
                    /* sdr frame type and other type frame will go through SDR path. */
                    return HI_DRV_DISP_WORKING_MODE_SDR;
                }
            }
            else
            {
                /* if current frame is null, keep last work mode. */
               return pstPlayInfo->enLastWorkMode;
            }
        }
        /*step3 : when HD win num <= 0 or win on v0 is disable,process path decided by LastPlayMode. */
        else
        {
            if (HI_DRV_DISP_WORKING_MODE_DOLBY_HDR == pstPlayInfo->enLastWorkMode)
            {
                /* should send the last-gfx-dolby-frame when lastPlayMode is dolby-mode. */
                if (HI_DRV_HDR_PLAY_MODE_DOLBY == pstPlayInfo->enLastPlayMode)
                {
                    return HI_DRV_DISP_WORKING_MODE_LAST_GRAPHIC_DOLBY;
                }
                else
                {
                    return HI_DRV_DISP_WORKING_MODE_SDR;
                }
            }
            else
            {
                return HI_DRV_DISP_WORKING_MODE_SDR;
            }
        }
    }
}

/*******************************************************************************
make play mode decision according to NextFrm/DispType/LastPlayMode in DolbyWorkMode.
********************************************************************************/
HI_DRV_HDR_PLAY_MODE_E DISP_DolbyPlayModePolicy(WINDOW_DOLBY_REFERENCE_INFO_S* pstWinDoviRefInfo,
                                                  HI_DRV_DISP_OUT_TYPE_E             enDispType)
{
    HI_DRV_HDR_PLAY_MODE_E  enPlayMode = HI_DRV_HDR_PLAY_MODE_BUTT;
    DISP_BUF_NODE_S*        pstDispBufNextNode = HI_NULL;
    HI_DRV_VIDEO_PRIVATE_S* pstPrivInfo = HI_NULL;

    if(HI_NULL == pstWinDoviRefInfo)
    {
        DISP_ERROR("pstWinDoviRefInfo is null,Dolby playMode will be set SDR mode.\n");
        return HI_DRV_HDR_PLAY_MODE_SDR;
    }

    if(enDispType >= HI_DRV_DISP_TYPE_BUTT)
    {
        DISP_ERROR("enDispType is invalid,Dolby playMode will be set SDR mode.\n");
        return HI_DRV_HDR_PLAY_MODE_SDR;
    }

    if(HI_DRV_DISP_TYPE_DOLBY == enDispType)
    {
        if (HI_NULL == pstWinDoviRefInfo->pNextFrame)
        {
            enPlayMode = HI_DRV_HDR_PLAY_MODE_DOLBY;
        }
        else
        {
            /* CurrentFrame NOT null,needn't to check it. */
            pstPrivInfo = (HI_DRV_VIDEO_PRIVATE_S*)(pstWinDoviRefInfo->pCurrentFrame->u32Priv);
            pstDispBufNextNode = container_of((HI_U32*)pstWinDoviRefInfo->pNextFrame, DISP_BUF_NODE_S, u32Data[0]);
            if ((HI_DRV_VIDEO_FRAME_TYPE_DOLBY_BL != pstWinDoviRefInfo->pNextFrame->enSrcFrameType)
                || (HI_DRV_DISP_TYPE_DOLBY != pstDispBufNextNode->stDolbyInfo.enDispOutType)
                || (pstPrivInfo->u32LastFlag))
            {
                enPlayMode = HI_DRV_HDR_PLAY_MODE_DOLBY_LAST;
            }
            //pNextFrm is Dolby frm and DolbyVision output.
            else
            {
                enPlayMode = HI_DRV_HDR_PLAY_MODE_DOLBY;
            }
        }
    }
    else if (HI_DRV_DISP_TYPE_HDR10 == enDispType)
    {
        enPlayMode = HI_DRV_HDR_PLAY_MODE_HDR10;
    }
    else if(HI_DRV_DISP_TYPE_HDR10_CERT == enDispType)
    {
        enPlayMode = HI_DRV_HDR_PLAY_MODE_HDR10_CERT;
    }
    else if (HI_DRV_DISP_TYPE_NORMAL == enDispType)
    {
        enPlayMode = HI_DRV_HDR_PLAY_MODE_SDR;
    }
    else if (HI_DRV_DISP_TYPE_SDR_CERT == enDispType)
    {
        enPlayMode = HI_DRV_HDR_PLAY_MODE_SDR_CERT;
    }

    return enPlayMode;

}


HI_VOID DISP_DolbyWorkModeGetHdr10OutMetadata(const HI_DRV_HDR_PLAY_MODE_E enPlayMode,
                                              HI_DRV_HDMI_HDR_ATTR_S   *pstHdmiHdrAttr)
{

    if(HI_NULL == pstHdmiHdrAttr)
    {
        DISP_ERROR("pstHdmiHdrAttr is null!\n");
        return;
    }
	
    if(HI_DRV_HDR_PLAY_MODE_HDR10_CERT == enPlayMode)
    {
        pstHdmiHdrAttr->enHdrMode = HI_DRV_HDMI_HDR_MODE_CEA_861_3_AUTHEN;
    }
    else
    {
        pstHdmiHdrAttr->enHdrMode = HI_DRV_HDMI_HDR_MODE_CEA_861_3;
    }
    
    pstHdmiHdrAttr->enEotfType = HI_DRV_HDMI_EOTF_SMPTE_ST_2048;
    pstHdmiHdrAttr->enMetadataId = HI_DRV_HDMI_HDR_METADATA_ID_0;
    pstHdmiHdrAttr->unDescriptor.stType1.u16Primaries0_X = HDR10_METADATA_R_X;
    pstHdmiHdrAttr->unDescriptor.stType1.u16Primaries0_Y = HDR10_METADATA_R_Y;
    pstHdmiHdrAttr->unDescriptor.stType1.u16Primaries1_X = HDR10_METADATA_G_X;
    pstHdmiHdrAttr->unDescriptor.stType1.u16Primaries1_Y = HDR10_METADATA_G_Y;
    pstHdmiHdrAttr->unDescriptor.stType1.u16Primaries2_X = HDR10_METADATA_B_X;
    pstHdmiHdrAttr->unDescriptor.stType1.u16Primaries2_Y = HDR10_METADATA_B_Y;
    pstHdmiHdrAttr->unDescriptor.stType1.u16WhitePoint_X = HDR10_METADATA_WP_X;
    pstHdmiHdrAttr->unDescriptor.stType1.u16WhitePoint_Y = HDR10_METADATA_WP_Y;
    pstHdmiHdrAttr->unDescriptor.stType1.u16MaxLuminance = HDR10_METADATA_DISP_MASTER_MAX;
    pstHdmiHdrAttr->unDescriptor.stType1.u16MinLuminance = HDR10_METADATA_DISP_MASTER_MIN;
    pstHdmiHdrAttr->unDescriptor.stType1.u16MaxLightLevel= HDR10_METADATA_CLL_MAX;          //zero currently
    pstHdmiHdrAttr->unDescriptor.stType1.u16AverageLightLevel= HDR10_METADATA_FALL_MAX;     //zero currently
    /* !NOTICE! here should use no-const luminous,otherwise may cause display problem on 
    * some TVs which not support const luminous. */
	pstHdmiHdrAttr->enColorimetry = HI_DRV_HDMI_COLORIMETRY_2020_NON_CONST_LUMINOUS;
    return ;
}

//pstDisp can use to get 1.whether support 12bitYUV or not;2.static metadata when HDR10 output?
/*******************************************************************************
para[in] :pstDisp           12bitYUV/edidInfo
para[in] :enPlayMode        output signal
para[out]:pstHdmiHdrAttr    HDR attr info that HDMI need
this function mainly used for generate HdmiHdrAttr according to different output
signal,and just used in DolbyWorkMode.
********************************************************************************/
HI_VOID DISP_DolbyWorkModeSetHdmiHdrAttr(DISP_S *pstDisp,
                              const HI_DRV_HDR_PLAY_MODE_E  enPlayMode,
                                    HI_DRV_HDMI_HDR_ATTR_S  *pstHdmiHdrAttr)
{
    switch(enPlayMode)
    {
        case HI_DRV_HDR_PLAY_MODE_SDR:
        {
            pstHdmiHdrAttr->enHdrMode = HI_DRV_HDMI_HDR_MODE_DISABLE;
            break;
        }
        case HI_DRV_HDR_PLAY_MODE_HDR10:
        {
            DISP_DolbyWorkModeGetHdr10OutMetadata(enPlayMode,pstHdmiHdrAttr);
            break;
        }
        case HI_DRV_HDR_PLAY_MODE_HDR10_CERT:
        {
            DISP_DolbyWorkModeGetHdr10OutMetadata(enPlayMode,pstHdmiHdrAttr);
            break;
        }
        case HI_DRV_HDR_PLAY_MODE_DOLBY_LAST:
        case HI_DRV_HDR_PLAY_MODE_DOLBY:
        {
            pstHdmiHdrAttr->enHdrMode = HI_DRV_HDMI_HDR_MODE_DOLBY_TUNNELING;
            break;
        }
        default:
            pstHdmiHdrAttr->enHdrMode = HI_DRV_HDMI_HDR_MODE_DISABLE;
            break;
    }

    return ;
}

/*******************************************************************************
para[in] :pstBLFrm     first frm in Dolby buf Node.
para[out]:pstELFrm     second frm in Dolby buf Node.
para[out]:pstAssemMd   address of stAssemMd in disp.
para[out]:pu8UpMdBuf   buffer for update metadata.
para[out]:pu32UpMdLen  length of update metadata.
para[out]:penDispType  output type of display.
note:1.get EL frame according to base addr of BL frame in buf Node.
     2.decide composer mode besides get metadata from buf Node.
********************************************************************************/
static HI_VOID DISP_PrepareDolbyFrmAndMd(HI_DRV_VIDEO_FRAME_S             *pstBLFrm,
                                       HI_DRV_VIDEO_FRAME_S             **pstELFrm,
                                       HI_DRV_DOLBY_METADATA_ASSEMBLE_S *pstAssemMd,
                                       HI_U8                            *pu8UpMdBuf,
                                       HI_U32                           *pu32UpMdLen,
                                       HI_DRV_DISP_OUT_TYPE_E           *penDispType)
{
    DISP_BUF_NODE_S              *pstDispBufNode = HI_NULL;
    HI_U32                       *pu32Data       = HI_NULL;
    HI_U32                        u32CompLen  = 0;
    HI_U32                        u32DmCfgLen = 0;
    HI_U32                        u32KsDmLen  = 0;
    HI_DRV_DOLBY_COMPOSER_MODE_E  enCompMode  = HI_DRV_DOLBY_COMPOSER_MODE_FULL;

    /* get disp buf node through BL frame.
     * window buffer node store as: u32Data[size]/bValidEL/pEL/pMd.
     */
    pu32Data = (HI_U32 *)pstBLFrm;
    pstDispBufNode = container_of(pu32Data,DISP_BUF_NODE_S,u32Data[0]);//use container_of method to get the node.
    //DISP_ASSERT(pstDispBufNode != HI_NULL);

    u32CompLen  = pstDispBufNode->stDolbyInfo.u32CompLen;
    u32DmCfgLen = pstDispBufNode->stDolbyInfo.u32DmCfgLen;
    u32KsDmLen  = pstDispBufNode->stDolbyInfo.u32DmRegLen;
    *pu32UpMdLen = pstDispBufNode->stDolbyInfo.u32UpMdLen;
    *penDispType = pstDispBufNode->stDolbyInfo.enDispOutType;
    if(pstDispBufNode->bValidData2)
    {
        enCompMode = HI_DRV_DOLBY_COMPOSER_MODE_FULL;
        *pstELFrm = (HI_DRV_VIDEO_FRAME_S*)pstDispBufNode->u32Data2;
        //DISP_ASSERT(pstELFrm != HI_NULL);
    }
    else
    {
        enCompMode = HI_DRV_DOLBY_COMPOSER_MODE_EL_FREE;
        *pstELFrm = HI_NULL;
        //DISP_ASSERT(pstELFrm == HI_NULL);
    }

    //get composer cfg and dm reg metadata from buffer Node.
    memcpy(&pstAssemMd->stCompCfg,pstDispBufNode->u8Metadata,u32CompLen);
    memcpy(&pstAssemMd->stDmCfg,pstDispBufNode->u8Metadata + u32CompLen,u32DmCfgLen);
    memcpy(&pstAssemMd->stDmKs,pstDispBufNode->u8Metadata + u32CompLen + u32DmCfgLen,u32KsDmLen);
    memcpy(pu8UpMdBuf,pstDispBufNode->u8Metadata + u32CompLen + u32DmCfgLen + u32KsDmLen,*pu32UpMdLen);

    //TODO.adjust composer mode according to enCompMode.
    if(HI_DRV_DOLBY_COMPOSER_MODE_FULL == enCompMode)
    {
        pstAssemMd->stCompCfg.disable_residual_flag = DISABLE_EL_FLAG_OFF;
    }
    else
    {
        pstAssemMd->stCompCfg.disable_residual_flag = DISABLE_EL_FLAG_ON;
    }

    return ;
}

/*******************************************************************************
Transfer video frame address to disp_hdr_frame address
para[in] : pstVidFrmAddr
para[out]: pstHdrFrmAddr
*******************************************************************************/
static HI_VOID DISP_TransferAddress(const HI_DRV_VID_FRAME_ADDR_S     *pstVidFrmAddr,
                                    DRV_DISP_HDR_FRAME_ADDR_S   *pstHdrFrmAddr)
{
    pstHdrFrmAddr->u32PhyAddr_YHead     =   pstVidFrmAddr->u32PhyAddr_YHead;
    pstHdrFrmAddr->u32PhyAddr_Y         =   pstVidFrmAddr->u32PhyAddr_Y;
    pstHdrFrmAddr->vir_addr_y           =   pstVidFrmAddr->vir_addr_y;
    pstHdrFrmAddr->u32Stride_Y          =   pstVidFrmAddr->u32Stride_Y;

    pstHdrFrmAddr->u32PhyAddr_CHead     =   pstVidFrmAddr->u32PhyAddr_CHead;
    pstHdrFrmAddr->u32PhyAddr_C         =   pstVidFrmAddr->u32PhyAddr_C;
    pstHdrFrmAddr->vir_addr_c           =   pstVidFrmAddr->vir_addr_c;
    pstHdrFrmAddr->u32Stride_C          =   pstVidFrmAddr->u32Stride_C;

    pstHdrFrmAddr->u32PhyAddr_CrHead    =   pstVidFrmAddr->u32PhyAddr_CrHead;
    pstHdrFrmAddr->u32PhyAddr_Cr        =   pstVidFrmAddr->u32PhyAddr_Cr;
    pstHdrFrmAddr->u32Stride_Cr         =   pstVidFrmAddr->u32Stride_Cr;

	pstHdrFrmAddr->u32Head_Stride = pstVidFrmAddr->u32Head_Stride;
	pstHdrFrmAddr->u32Head_Size = pstVidFrmAddr->u32Head_Size;

    return ;
}

/*******************************************************************************
Recognize whether frame pixformat is compress or not
para[in] : enPixFormat
para[out]: pbDcmp,     true indicate frame is compressed while false indicate incompressed.
*******************************************************************************/
static HI_VOID DISP_RecognizeCompressFrm(HI_DRV_PIX_FORMAT_E enPixFormat, HI_BOOL *pbDcmp)
{
    if(((HI_DRV_PIX_FMT_NV08_CMP <= enPixFormat)
          &&(HI_DRV_PIX_FMT_NV42_CMP >= enPixFormat))
       || ((HI_DRV_PIX_FMT_NV12_TILE_CMP <= enPixFormat)
          && (HI_DRV_PIX_FMT_NV21_TILE_CMP >= enPixFormat))
      )
    {
        *pbDcmp = HI_TRUE;
    }
    else
    {
        *pbDcmp = HI_FALSE;
    }
    return ;
}

/*******************************************************************************
para[in] : pstBLFrm
para[in] : pstELFrm
para[in] : enPlayMode
para[in] : stOutRect    window's out rect
para[out]: pstHdrCfg    cbb API need this info to config.
this function mainly to generate cfg structure for cbb config use.
********************************************************************************/
static HI_VOID DISP_GenerateDolbyWorkModeHdrCfg(const HI_DRV_VIDEO_FRAME_S     *pstBLFrm,
                                               const HI_DRV_VIDEO_FRAME_S     *pstELFrm,
                                               const HI_DRV_HDR_PLAY_MODE_E    enPlayMode,
                                               HI_RECT_S                       stOutRect,
                                               HI_DRV_DISP_DOLBY_HDR_CFG_S    *pstHdrCfg)
{
    HI_BOOL bCompatible = HI_FALSE;

    bCompatible = pstBLFrm->unHDRInfo.stDolbyInfo.bCompatible;//what about EL?

    pstHdrCfg->bGfxEn   = HI_TRUE;//default true currently.
    pstHdrCfg->bMuteEn  = HI_FALSE;
#ifdef CFG_VDP_MMU_SUPPORT
    pstHdrCfg->bSmmu    = HI_TRUE;
#else
    pstHdrCfg->bSmmu    = HI_FALSE;
#endif
    /***step1.get cfg mode according to enPlayMode and bCompatible***/
    if (bCompatible)
    {
        switch (enPlayMode)
        {
            case HI_DRV_HDR_PLAY_MODE_SDR:
            {
                pstHdrCfg->enHdrMode = DRV_DOVI_BC_IN_SDR_OUT;
                break;
            }
            case HI_DRV_HDR_PLAY_MODE_SDR_CERT:
            {
                pstHdrCfg->enHdrMode = DRV_DOVI_BC_IN_SDR_OUT_CERT;
                break;
            }
            case HI_DRV_HDR_PLAY_MODE_HDR10:
            {
                pstHdrCfg->enHdrMode = DRV_DOVI_BC_IN_HDR10_OUT;
                break;
            }
            case HI_DRV_HDR_PLAY_MODE_HDR10_CERT:
            {
                pstHdrCfg->enHdrMode = DRV_DOVI_BC_IN_HDR10_OUT_CERT;
                break;
            }
            case HI_DRV_HDR_PLAY_MODE_DOLBY_LAST:
            case HI_DRV_HDR_PLAY_MODE_DOLBY:
            {
                //Dolby ONLY has IPT out.
                pstHdrCfg->enHdrMode = DRV_DOVI_BC_IN_DOVI_IPT_OUT;
                break;
            }
            default:
                break;
        }
    }
    else
    {
        switch (enPlayMode)
        {
            case HI_DRV_HDR_PLAY_MODE_SDR:
            {
                pstHdrCfg->enHdrMode = DRV_DOVI_NBC_IN_SDR_OUT;
                break;
            }
            case HI_DRV_HDR_PLAY_MODE_SDR_CERT:
            {
                pstHdrCfg->enHdrMode = DRV_DOVI_NBC_IN_SDR_OUT_CERT;
                break;
            }
            case HI_DRV_HDR_PLAY_MODE_HDR10:
            {
                pstHdrCfg->enHdrMode = DRV_DOVI_NBC_IN_HDR10_OUT;
                break;
            }
            case HI_DRV_HDR_PLAY_MODE_HDR10_CERT:
            {
                pstHdrCfg->enHdrMode = DRV_DOVI_NBC_IN_HDR10_OUT_CERT;
                break;
            }
            case HI_DRV_HDR_PLAY_MODE_DOLBY_LAST:
            case HI_DRV_HDR_PLAY_MODE_DOLBY:
            {
                //Dolby ONLY has IPT out.
                pstHdrCfg->enHdrMode = DRV_DOVI_NBC_IN_DOVI_IPT_OUT;
                break;
            }
            default:
                break;
        }
    }

    /***step2.generate other attributes of HdrCfg.***/
    if (HI_NULL != pstELFrm)
    {
        pstHdrCfg->bELValid              = HI_TRUE;
        pstHdrCfg->stELResoOut           = stOutRect;
        pstHdrCfg->stELResoIn            = pstELFrm->stDispRect;
        pstHdrCfg->stELFrame.enBitWidth  = pstELFrm->enBitWidth;
        pstHdrCfg->stELFrame.enPixFormat = pstELFrm->ePixFormat;
        pstHdrCfg->stELFrame.bSecurity   = pstELFrm->bSecure;

        DISP_RecognizeCompressFrm(pstHdrCfg->stELFrame.enPixFormat,
                                  &pstHdrCfg->stELFrame.bDcmpEn);

        DISP_TransferAddress(&pstELFrm->stBufAddr[0],&pstHdrCfg->stELFrame.stAddress[0]);
        if(HI_DRV_PIXEL_BITWIDTH_10BIT == pstHdrCfg->stELFrame.enBitWidth)
        {
            DISP_TransferAddress(&pstELFrm->stBufAddr_LB[0],
                                 &pstHdrCfg->stELFrame.stAddress_lb[0]);
        }

        /*****************************************************
        |if EL reso is not equal to outRect,mute it
        ******************************************************/
        if((pstHdrCfg->stELResoIn.s32Width != pstHdrCfg->stELResoOut.s32Width) ||
           (pstHdrCfg->stELResoIn.s32Height!= pstHdrCfg->stELResoOut.s32Height))
    	{

			if ((pstHdrCfg->stELResoIn.s32Width == (pstHdrCfg->stELResoOut.s32Width/2) )
				&& (pstHdrCfg->stELResoIn.s32Height == (pstHdrCfg->stELResoOut.s32Height/2) )
				)
			{
				 pstHdrCfg->bMuteEn = HI_FALSE;
			}
			else
			{
            	pstHdrCfg->bMuteEn  = HI_TRUE;

        	}
    	}
	}

    pstHdrCfg->stBLResoOut             = stOutRect;
    pstHdrCfg->stBLResoIn              = pstBLFrm->stDispRect;
    pstHdrCfg->stBLFrame.enBitWidth    = pstBLFrm->enBitWidth;
    pstHdrCfg->stBLFrame.enPixFormat   = pstBLFrm->ePixFormat;
    pstHdrCfg->stBLFrame.bSecurity     = pstBLFrm->bSecure;

    DISP_RecognizeCompressFrm(pstHdrCfg->stBLFrame.enPixFormat,
                                  &pstHdrCfg->stBLFrame.bDcmpEn);

    DISP_TransferAddress(&pstBLFrm->stBufAddr[0], &pstHdrCfg->stBLFrame.stAddress[0]);
    if (HI_DRV_PIXEL_BITWIDTH_10BIT == pstHdrCfg->stBLFrame.enBitWidth)
    {
        DISP_TransferAddress(&pstBLFrm->stBufAddr_LB[0],
                             &pstHdrCfg->stBLFrame.stAddress_lb[0]);
    }

    return ;
}


/*******************************************************************************
para[in] : pstDisp      use for callback function to send update md.
para[in] : enPlayMode   play mode of dolby work-mode.
para[in] : pu8MdBuf     buffer to send update metadata.
para[out]: u32MdLen     length of update metadata.
update metadata when output DolbyVision signal,and store in MdBuf wait HDMI to send.
********************************************************************************/
static HI_VOID DISP_DolbyUpdateMd(DISP_S                   *pstDisp,
                                  HI_DRV_HDR_PLAY_MODE_E    enPlayMode,
                                  HI_U8                    *pu8MdBuf,
                                  HI_U32                    u32MdLen)
{
    HI_DRV_DOLBY_HDR_MD_HEADER_S stMdHeader;

    memset(&stMdHeader,0x0,sizeof(HI_DRV_DOLBY_HDR_MD_HEADER_S));

    /* Needn't update when output signal is not DolbyVision.*/
    if((HI_DRV_HDR_PLAY_MODE_DOLBY != enPlayMode)
        && (HI_DRV_HDR_PLAY_MODE_DOLBY_LAST != enPlayMode))
    {
        //needn't send update metadata,just return.
        return;
    }

    stMdHeader.u32MdId = pu8MdBuf[0];

    if(HI_DRV_HDR_PLAY_MODE_DOLBY_LAST == enPlayMode)
    {
        stMdHeader.bEos = HI_TRUE;
    }
    else if(HI_DRV_HDR_PLAY_MODE_DOLBY == enPlayMode)
    {
        stMdHeader.bEos = HI_FALSE;
    }

    stMdHeader.bNoMd = 0;
    stMdHeader.u8MdVer = HEADER_MD_VER;
    stMdHeader.u8MdType = HEADER_MD_TYPE;

    /* CBB's update interface to config reg and send update metadata.*/
    pstDisp->pstIntfOpt->PF_SetHdrHdmiMetadata((HI_U8*)&stMdHeader,u32MdLen,pu8MdBuf);

}



/*******************************************************************************
para[in] : pstDisp            get DispType/LastPlayMode/edidInfo
para[in] : pstWinDoviRefInfo  get BLELFrm/Md/NextFrm(judge last DoviFrm)
para[out]: pstHdmiHdrAttr     get info according to output signal
this function mainly to generate all need info and config reg,as well as HDMI info.
********************************************************************************/
static HI_S32 DISP_DolbyWorkModeProcess(DISP_S                         *pstDisp,
                                        WINDOW_DOLBY_REFERENCE_INFO_S  *pstWinDoviRefInfo,
                                        HI_DRV_HDMI_HDR_ATTR_S         *pstHdmiHdrAttr)
{
    HI_DRV_DOLBY_METADATA_ASSEMBLE_S* pstAssemMd = HI_NULL;
    HI_DRV_HDR_PLAY_MODE_E            enPlayMode = HI_DRV_HDR_PLAY_MODE_BUTT;
    HI_DRV_DISP_OUT_TYPE_E            enDispType = HI_DRV_DISP_TYPE_BUTT;
    HI_DRV_VIDEO_FRAME_S*             pstBLFrm = HI_NULL;
    HI_DRV_VIDEO_FRAME_S*             pstELFrm = HI_NULL;
    HI_DRV_DISP_DOLBY_HDR_CFG_S       stHdrCfg ;
    HI_RECT_S                         stOutRect;
    
    HI_U8*                            pu8MdBuf    = HI_NULL;
    HI_U32*                           pu32UpMdLen = HI_NULL;
    
    memset(&stHdrCfg, 0x0, sizeof(HI_DRV_DISP_DOLBY_HDR_CFG_S));
    memset(&stOutRect,0x0,sizeof(HI_RECT_S));
    
    pstAssemMd     = &pstDisp->stHdrPlayInfo.stDolbyHdrInfo.stAssemMd;
    pu8MdBuf       = pstDisp->stHdrPlayInfo.stDolbyHdrInfo.u8MdBuf;
    pu32UpMdLen    = &pstDisp->stHdrPlayInfo.stDolbyHdrInfo.u32UpMdLen;
    
    pstBLFrm       = pstWinDoviRefInfo->pCurrentFrame;
    stOutRect      = pstWinDoviRefInfo->stWinOutRect;
    
    if (HI_NULL == pstBLFrm)
    {
        /* if current frame is null,mute it. */
        stHdrCfg = pstDisp->stHdrPlayInfo.stDolbyHdrInfo.stLastHdrCfg;
        stHdrCfg.bMuteEn  = HI_TRUE;
        pstDisp->pstIntfOpt->PF_SetHdrMode(&stHdrCfg,
                                           &pstDisp->stHdrPlayInfo.stDolbyHdrInfo.stAssemMd.stCompCfg,
                                           &pstDisp->stHdrPlayInfo.stDolbyHdrInfo.stAssemMd.stDmKs);
        /* record for proc info */
        pstDisp->stHdrProcInfo.stDolbyHdrProcInfo.stDolbyHdrCfg = stHdrCfg;
    
        DISP_DolbyUpdateMd(pstDisp,
                           pstDisp->stHdrPlayInfo.enLastPlayMode,
                           pstDisp->stHdrPlayInfo.stDolbyHdrInfo.u8MdBuf,
                           pstDisp->stHdrPlayInfo.stDolbyHdrInfo.u32UpMdLen);
    
        DISP_DolbyWorkModeSetHdmiHdrAttr(pstDisp,
                                         pstDisp->stHdrPlayInfo.enLastPlayMode,
                                         pstHdmiHdrAttr);
    }
    else
    {
        /*
        * step1.get EL Frm and metadata(compCfg/dmCfg/dmKs/updateMd)
        * from the frame(store in buffer node actually.)
        */
        DISP_PrepareDolbyFrmAndMd(pstBLFrm, &pstELFrm, pstAssemMd, pu8MdBuf, pu32UpMdLen, &enDispType);
    
        /*
         * step2.get play mode through DolbyPlayModePolicy.
         */
        enPlayMode = DISP_DolbyPlayModePolicy(pstWinDoviRefInfo, enDispType);

        /*
         * step3.generate cbb's HdrMode cfg para.
         */
        DISP_GenerateDolbyWorkModeHdrCfg(pstBLFrm, pstELFrm, enPlayMode,stOutRect, &stHdrCfg);

        /* record info for proc debug*/
        pstDisp->stHdrProcInfo.enHdrPlayMode = enPlayMode;
        pstDisp->stHdrProcInfo.stDolbyHdrProcInfo.stCompCfg = pstAssemMd->stCompCfg;
        pstDisp->stHdrProcInfo.stDolbyHdrProcInfo.stDmCfg   = pstAssemMd->stDmCfg;
        pstDisp->stHdrProcInfo.stDolbyHdrProcInfo.stDmKs    = pstAssemMd->stDmKs;
        pstDisp->stHdrProcInfo.stDolbyHdrProcInfo.bELVaild  = (HI_NULL == pstELFrm)? HI_FALSE : HI_TRUE;
        pstDisp->stHdrProcInfo.stDolbyHdrProcInfo.stDolbyHdrCfg = stHdrCfg;
            
        /*
         * step4.CBB adapter interface to config composer reg and DM reg.
         */
        pstDisp->pstIntfOpt->PF_SetHdrMode(&stHdrCfg, &pstAssemMd->stCompCfg, &pstAssemMd->stDmKs);
    
        /*
         * step5.another CBB adapter interface for update metadata when output DolbyVision.
         * notes:ONLY DolbyVision output need update metadata.
         */
        DISP_DolbyUpdateMd(pstDisp, enPlayMode, pu8MdBuf, *pu32UpMdLen);
    
        /*
         * step6.set HDMI HDR-related attributes.
         */
        DISP_DolbyWorkModeSetHdmiHdrAttr(pstDisp, enPlayMode, pstHdmiHdrAttr);
    
        /*
         * step7.update last play mode and config.
         */
        pstDisp->stHdrPlayInfo.stDolbyHdrInfo.stLastHdrCfg  = stHdrCfg;         
        pstDisp->stHdrPlayInfo.enLastPlayMode = enPlayMode;
        if (HI_DRV_HDR_PLAY_MODE_DOLBY_LAST == enPlayMode)
        {
            pstDisp->stHdrPlayInfo.enLastPlayMode = HI_DRV_HDR_PLAY_MODE_SDR;
            //DISP_ERROR("------>Dolby Last Frame!\n");
        }

}


return HI_SUCCESS;
}

/*******************************************************************************
para[in] : pstDisp            get DispType/LastPlayMode/edidInfo
para[out]: pstHdmiHdrAttr     set hdmi hdr attr.
********************************************************************************/
static HI_VOID DISP_LastGfxDolbyWorkModeProcess(DISP_S                 *pstDisp,
                                                HI_DRV_HDMI_HDR_ATTR_S *pstHdmiHdrAttr)
{
    /*step1: get last HdrCfg info */
    /*step2: get last metadata info */
    HI_DRV_DISP_DOLBY_HDR_CFG_S  *pstHdrCfg = &pstDisp->stHdrPlayInfo.stDolbyHdrInfo.stLastHdrCfg;
    pstHdrCfg->bMuteEn  = HI_TRUE;
    pstDisp->pstIntfOpt->PF_SetHdrMode(pstHdrCfg,
                                       &pstDisp->stHdrPlayInfo.stDolbyHdrInfo.stAssemMd.stCompCfg,
                                       &pstDisp->stHdrPlayInfo.stDolbyHdrInfo.stAssemMd.stDmKs);
    pstDisp->stHdrProcInfo.stDolbyHdrProcInfo.stDolbyHdrCfg = *pstHdrCfg;

    /*step3: get last update metadata */
    DISP_DolbyUpdateMd(pstDisp,
                       HI_DRV_HDR_PLAY_MODE_DOLBY_LAST,
                       pstDisp->stHdrPlayInfo.stDolbyHdrInfo.u8MdBuf,
                       pstDisp->stHdrPlayInfo.stDolbyHdrInfo.u32UpMdLen);

    /*step4: change playMode to sdr mode after send last dolby frame. */
    pstDisp->stHdrPlayInfo.enLastPlayMode = HI_DRV_HDR_PLAY_MODE_SDR;

    /*step5: set hdmi hdr mode.*/
    pstHdmiHdrAttr->enHdrMode = HI_DRV_HDMI_HDR_MODE_DOLBY_TUNNELING;
}

/*******************************************************************************
|                           hdr10 process functions.
*******************************************************************************/

/*******************************************************************************
* para[in]:enDispType   hdr type of disp
*
* hdr10 play mode policy function.output signal decided by disp type.
*******************************************************************************/
static HI_DRV_HDR_PLAY_MODE_E  DISP_Hdr10PlayModePolicy(HI_DRV_DISP_OUT_TYPE_E enDispType)
{
    HI_DRV_HDR_PLAY_MODE_E enPlayMode = HI_DRV_HDR_PLAY_MODE_BUTT;

    if (enDispType >= HI_DRV_DISP_TYPE_BUTT)
    {
        DISP_ERROR("enDispType is invalid,Dolby playMode will be set SDR mode.\n");
        return HI_DRV_HDR_PLAY_MODE_SDR;
    }

    switch(enDispType)
    {
        case HI_DRV_DISP_TYPE_NORMAL:
        {
            enPlayMode = HI_DRV_HDR_PLAY_MODE_SDR;
            break;
        }
        case HI_DRV_DISP_TYPE_SDR_CERT:
        {
            enPlayMode = HI_DRV_HDR_PLAY_MODE_SDR_CERT;
            break;
        }
        case HI_DRV_DISP_TYPE_DOLBY:
        {
            /*currently NOT SUPPORT Dolby output.*/
            DISP_ERROR("Don't support dolby output currently, output will be set to SDR mode.\n");
            enPlayMode = HI_DRV_HDR_PLAY_MODE_SDR;
            break;
        }
        case HI_DRV_DISP_TYPE_HDR10:
        {
            enPlayMode = HI_DRV_HDR_PLAY_MODE_HDR10;
            break;
        }
        case HI_DRV_DISP_TYPE_HDR10_CERT:
        {
            enPlayMode = HI_DRV_HDR_PLAY_MODE_HDR10_CERT;
            break;
        }
        default:
            enPlayMode = HI_DRV_HDR_PLAY_MODE_SDR;
            break;
    }

    return enPlayMode;

}

#if 0
static HI_VOID DISP_DolbyHdr10WorkModePrepareDm(HI_DRV_HDR_PLAY_MODE_E enPlayMode,DmKsFxp_t *pstKsDm)
{
    /* get default KsDm */
    if((HI_DRV_HDR_PLAY_MODE_HDR10 == enPlayMode)
        ||(HI_DRV_HDR_PLAY_MODE_HDR10_CERT == enPlayMode))
    {
        memcpy(pstKsDm,g_Hdr10InHdr10OutKsDm,sizeof(DmKsFxp_t));
    }
    else
    {
        memcpy(pstKsDm,g_Hdr10InSdrOutKsDm,sizeof(DmKsFxp_t));
    }

    return;
}
#endif

static HI_VOID DISP_Hdr10PlayModeTransfer2HdmiMD(const HI_DRV_VIDEO_HDR10_METADATA_S *pstMd,
                                                 HI_DRV_HDMI_META_DESCIRPER_UN *punDescriptor)
{
    punDescriptor->stType1.u16Primaries0_X = pstMd->u16DispPrimariesX0;
    punDescriptor->stType1.u16Primaries0_Y = pstMd->u16DispPrimariesY0;
    punDescriptor->stType1.u16Primaries1_X = pstMd->u16DispPrimariesX1;
    punDescriptor->stType1.u16Primaries1_Y = pstMd->u16DispPrimariesY1;
    punDescriptor->stType1.u16Primaries2_X = pstMd->u16DispPrimariesX2;
    punDescriptor->stType1.u16Primaries2_Y = pstMd->u16DispPrimariesY2;
    punDescriptor->stType1.u16WhitePoint_X = pstMd->u16WhitePointX;
    punDescriptor->stType1.u16WhitePoint_Y = pstMd->u16WhitePointY;

    /* !NOTICE!
     * conflict between protocol of hevc and CEA861.3-2015,
     * hevc define max and min disp master luminance as unsigned 32-bit value
     * in units of 0.0001 nits; while CEA861.3-2015 define max as unsigned 16-bit
     * value in units of 1 nits,min as unsigned 16-bit value in units of 0.0001 nits.
     */
    punDescriptor->stType1.u16MaxLuminance = (HI_U16)(pstMd->u32MaxDispMasteringLuminance / 10000);
    punDescriptor->stType1.u16MinLuminance = (HI_U16)pstMd->u32MinDispMasteringLuminance;

    /*
    * max conten light level & average light level are useless in frame info.set 0 currently.
    */
#if 0
    punDescriptor->stType1.u16MaxLightLevel    = (HI_U16)pstMd->u32MaxContentLightLevel;
    punDescriptor->stType1.u16AverageLightLevel= (HI_U16)pstMd->u32MaxFrmAverageLightLevel;
#endif
    punDescriptor->stType1.u16MaxLightLevel    = HDR10_METADATA_CLL_MAX;      //zero currently
    punDescriptor->stType1.u16AverageLightLevel= HDR10_METADATA_FALL_MAX;     //zero currently

    return ;
}

static HI_VOID DISP_Hdr10WorkModeGetHdr10OutMetadata(const HI_DRV_VIDEO_HDR10_INFO_S *pstHdr10Info,
                                                     const HI_DRV_HDR_PLAY_MODE_E     enPlayMode,
                                                     HI_DRV_HDMI_HDR_ATTR_S   *pstHdmiHdrAttr)
{
    if(HI_DRV_HDR_PLAY_MODE_HDR10_CERT == enPlayMode)
    {
        pstHdmiHdrAttr->enHdrMode = HI_DRV_HDMI_HDR_MODE_CEA_861_3_AUTHEN;
    }
    else
    {
        pstHdmiHdrAttr->enHdrMode = HI_DRV_HDMI_HDR_MODE_CEA_861_3;
    }
    

    pstHdmiHdrAttr->enMetadataId = HI_DRV_HDMI_HDR_METADATA_ID_0;

    DISP_Hdr10PlayModeTransfer2HdmiMD(&pstHdr10Info->stMetadata,
                                      &pstHdmiHdrAttr->unDescriptor);

    if(HI_DRV_GAMMA_TYPE_2084 == pstHdr10Info->enGammaType)
    {
        pstHdmiHdrAttr->enEotfType = HI_DRV_HDMI_EOTF_SMPTE_ST_2048;
    }
    else
    {
        pstHdmiHdrAttr->enEotfType = HI_DRV_HDMI_EOTF_SDR_LUMIN;
    }

    if(HI_DRV_CS_BT2020_YUV_LIMITED == pstHdr10Info->enColorSpace)
    {
        pstHdmiHdrAttr->enColorimetry = HI_DRV_HDMI_COLORIMETRY_2020_NON_CONST_LUMINOUS;
    }
    else
    {
        pstHdmiHdrAttr->enColorimetry = HI_DRV_HDMI_COLORIMETRY_NO_DATA;
    }

    return ;

}

static HI_VOID DISP_Hdr10WorkModeSetHdmiHdrAttr(const HI_DRV_VIDEO_HDR10_INFO_S *pstHdr10Info,
                                                const HI_DRV_HDR_PLAY_MODE_E     enPlayMode,
                                                HI_DRV_HDMI_HDR_ATTR_S   *pstHdmiHdrAttr)
{
    switch(enPlayMode)
    {
        case HI_DRV_HDR_PLAY_MODE_SDR:
        {
            pstHdmiHdrAttr->enHdrMode = HI_DRV_HDMI_HDR_MODE_DISABLE;
            break;
        }
        case HI_DRV_HDR_PLAY_MODE_HDR10:
        {
            DISP_Hdr10WorkModeGetHdr10OutMetadata(pstHdr10Info,enPlayMode,pstHdmiHdrAttr);
            break;
        }
        case HI_DRV_HDR_PLAY_MODE_HDR10_CERT:
        {
            DISP_Hdr10WorkModeGetHdr10OutMetadata(pstHdr10Info,enPlayMode,pstHdmiHdrAttr);
            break;
        }
        case HI_DRV_HDR_PLAY_MODE_DOLBY:
        {
            //pstHdmiHdrAttr->enHdrMode = HI_DRV_HDMI_HDR_MODE_DOLBY_TUNNELING;
            DISP_ERROR("Currently NOT Support HDR10 in Dolby out!Set SDR out instead.\n");
            pstHdmiHdrAttr->enHdrMode = HI_DRV_HDMI_HDR_MODE_DISABLE;
            break;
        }
        default:
            /* sdr cert and other case will go through this patch.*/
            pstHdmiHdrAttr->enHdrMode = HI_DRV_HDMI_HDR_MODE_DISABLE;
            break;
    }

    return ;
}

static HI_VOID DISP_GenerateDolbyHdr10WorkModeHdrCfg(const HI_DRV_VIDEO_FRAME_S  *pstFrm,
                                                    const HI_DRV_HDR_PLAY_MODE_E  enPlayMode,
                                                    HI_RECT_S                     stOutRect,
                                                    HI_DRV_DISP_DOLBY_HDR_CFG_S   *pstHdrCfg)
{
    pstHdrCfg->bGfxEn   = HI_TRUE;//default true currently.
#ifdef CFG_VDP_MMU_SUPPORT
    pstHdrCfg->bSmmu    = HI_TRUE;
#else
    pstHdrCfg->bSmmu    = HI_FALSE;
#endif

    /*step1: get cfg mode according to play mode */
    switch(enPlayMode)
    {
        case HI_DRV_HDR_PLAY_MODE_SDR:
        {
            pstHdrCfg->enHdrMode = DRV_HDR10_IN_SDR_OUT;
            break;
        }
        case HI_DRV_HDR_PLAY_MODE_SDR_CERT:
        {
            pstHdrCfg->enHdrMode = DRV_HDR10_IN_SDR_OUT_CERT;
            break;
        }
        case HI_DRV_HDR_PLAY_MODE_HDR10:
        {
            pstHdrCfg->enHdrMode = DRV_HDR10_IN_HDR10_OUT;
            break;
        }
        case HI_DRV_HDR_PLAY_MODE_HDR10_CERT:
        {
            pstHdrCfg->enHdrMode = DRV_HDR10_IN_HDR10_OUT_CERT;
            break;
        }
        case HI_DRV_HDR_PLAY_MODE_DOLBY:
        {
            //NO support currently! set sdr output instead.
            DISP_ERROR("Currently NOT Support HDR10-in-Dolby-out!Set SDR out instead.\n");
            pstHdrCfg->enHdrMode = DRV_HDR10_IN_SDR_OUT;
            break;
        }
        default:
            pstHdrCfg->enHdrMode = DRV_HDR10_IN_SDR_OUT;
            break;
    }

    /*step2: generate other attributes of HdrCfg.*/
    pstHdrCfg->stBLResoOut             = stOutRect;
    pstHdrCfg->stBLResoIn              = pstFrm->stDispRect;
    pstHdrCfg->stBLFrame.enBitWidth    = pstFrm->enBitWidth;
    pstHdrCfg->stBLFrame.enPixFormat   = pstFrm->ePixFormat;
    pstHdrCfg->stBLFrame.bSecurity     = pstFrm->bSecure;

    DISP_RecognizeCompressFrm(pstHdrCfg->stBLFrame.enPixFormat,
                              &pstHdrCfg->stBLFrame.bDcmpEn);

    DISP_TransferAddress(&pstFrm->stBufAddr[0], &pstHdrCfg->stBLFrame.stAddress[0]);
    if (HI_DRV_PIXEL_BITWIDTH_10BIT == pstHdrCfg->stBLFrame.enBitWidth)
    {
        DISP_TransferAddress(&pstFrm->stBufAddr_LB[0],
                             &pstHdrCfg->stBLFrame.stAddress_lb[0]);
    }

    return ;
}

/*******************************************************************************
* para[in]:pstDisp              Disp info.
* para[in]:pstWinDoviRefInfo    common info for win and disp.
* para[out]:pstHdmiHdrAttr      info frm attributes for hdmi.
*******************************************************************************/
static HI_VOID DISP_DolbyHdr10WorkModeProcess(DISP_S                         *pstDisp,
                                         WINDOW_DOLBY_REFERENCE_INFO_S  *pstWinDoviRefInfo,
                                         HI_DRV_HDMI_HDR_ATTR_S         *pstHdmiHdrAttr)
{
    HI_DRV_DOLBY_METADATA_ASSEMBLE_S *pstAssemMd = HI_NULL;
    HI_DRV_HDR_PLAY_MODE_E           enPlayMode = HI_DRV_HDR_PLAY_MODE_BUTT;
    HI_DRV_VIDEO_FRAME_S              *pstFrm = HI_NULL;
    HI_DRV_DISP_DOLBY_HDR_CFG_S       stHdrCfg ;
    HI_RECT_S                         stOutRect;


    memset(&stHdrCfg,0x0,sizeof(HI_DRV_DISP_DOLBY_HDR_CFG_S));
    memset(&stOutRect,0x0,sizeof(HI_RECT_S));
    
    pstAssemMd     = &pstDisp->stHdrPlayInfo.stDolbyHdrInfo.stAssemMd;
    pstFrm       = pstWinDoviRefInfo->pCurrentFrame;
    stOutRect      = pstWinDoviRefInfo->stWinOutRect;

    if(HI_NULL == pstFrm)
    {
        //when mute in hdr10, config hdmi's metadata with last configuration.
        stHdrCfg = pstDisp->stHdrPlayInfo.stDolbyHdrInfo.stLastHdrCfg;
        stHdrCfg.bMuteEn  = HI_TRUE;
        pstDisp->pstIntfOpt->PF_SetHdrMode(&stHdrCfg,
                                           &pstDisp->stHdrPlayInfo.stDolbyHdrInfo.stAssemMd.stCompCfg,
                                           &pstDisp->stHdrPlayInfo.stDolbyHdrInfo.stAssemMd.stDmKs);
        pstDisp->stHdrProcInfo.stDolbyHdrProcInfo.stDolbyHdrCfg = stHdrCfg;

        DISP_Hdr10WorkModeSetHdmiHdrAttr(&pstDisp->stHdrPlayInfo.stLastHdr10Info,
                                         pstDisp->stHdrPlayInfo.enLastPlayMode,
                                         pstHdmiHdrAttr);
    }
    else
    {

        /*step1: make play mode policy.*/
        enPlayMode = DISP_Hdr10PlayModePolicy(pstDisp->stSetting.stDispHDRAttr.enDispType);

        /*step2: get KsDm para. */
        memset(pstAssemMd, 0x0, sizeof(HI_DRV_DOLBY_METADATA_ASSEMBLE_S));
#if 0        
        DISP_DolbyHdr10WorkModePrepareDm(enPlayMode, &pstAssemMd->stDmKs);
#endif

        /*step3: generate CBB's HdrCfg para.*/
        DISP_GenerateDolbyHdr10WorkModeHdrCfg(pstFrm, enPlayMode, stOutRect, &stHdrCfg);
        /* need to disable el */
        pstAssemMd->stCompCfg.disable_residual_flag = HI_TRUE;

        /* record info for proc */
        pstDisp->stHdrProcInfo.enHdrPlayMode = enPlayMode;
        pstDisp->stHdrProcInfo.stDolbyHdrProcInfo.stCompCfg = pstAssemMd->stCompCfg;
        pstDisp->stHdrProcInfo.stDolbyHdrProcInfo.stDmCfg   = pstAssemMd->stDmCfg;
        pstDisp->stHdrProcInfo.stDolbyHdrProcInfo.stDmKs    = pstAssemMd->stDmKs;
        pstDisp->stHdrProcInfo.stDolbyHdrProcInfo.stDolbyHdrCfg = stHdrCfg;

        /*step4: call CBB's adapter interface to config */
        pstDisp->pstIntfOpt->PF_SetHdrMode(&stHdrCfg, &pstAssemMd->stCompCfg, &pstAssemMd->stDmKs);

        /*step5: set HDMI Hdr attr according to play mode. */
        DISP_Hdr10WorkModeSetHdmiHdrAttr(&pstFrm->unHDRInfo.stHDR10Info, enPlayMode, pstHdmiHdrAttr);

        /* update Hdr play info. */
        pstDisp->stHdrPlayInfo.enLastPlayMode  = enPlayMode;
        pstDisp->stHdrPlayInfo.stDolbyHdrInfo.stLastHdrCfg = stHdrCfg;
        pstDisp->stHdrPlayInfo.stLastHdr10Info = pstFrm->unHDRInfo.stHDR10Info;
    }

    return ;
}

static HI_VOID DISP_GenerateHisiHdr10WorkModeHdrCfg(const HI_DRV_VIDEO_FRAME_S  *pstFrm,
                                                    const HI_DRV_HDR_PLAY_MODE_E  enPlayMode,
                                                    HI_RECT_S                     stOutRect,
                                                    HI_DRV_DISP_HISI_HDR_CFG_S   *pstHdrCfg)
{
    
    
        pstHdrCfg->bGfxEn   = HI_TRUE;//default true currently.
#ifdef CFG_VDP_MMU_SUPPORT
        pstHdrCfg->bSmmu    = HI_TRUE;
#else
        pstHdrCfg->bSmmu    = HI_FALSE;
#endif
    
        /*step1: get cfg mode according to play mode */
        switch(enPlayMode)
        {
            case HI_DRV_HDR_PLAY_MODE_SDR:
            {
                pstHdrCfg->enHdrMode = DRV_HISI_HDR10_IN_SDR_OUT;
                break;
            }
            case HI_DRV_HDR_PLAY_MODE_HDR10:
            {
                pstHdrCfg->enHdrMode = DRV_HISI_HDR10_IN_HDR10_OUT;
                break;
            }
            case HI_DRV_HDR_PLAY_MODE_BBC:
            {
                /* NO support currently! set sdr output instead.*/
                DISP_ERROR("Currently NOT support BBC out!Set SDR out instead.\n");
                pstHdrCfg->enHdrMode = DRV_HISI_HDR10_IN_SDR_OUT;
                break;
            }
            case HI_DRV_HDR_PLAY_MODE_DOLBY:
            case HI_DRV_HDR_PLAY_MODE_SDR_CERT:
            case HI_DRV_HDR_PLAY_MODE_HDR10_CERT:
            case HI_DRV_HDR_PLAY_MODE_DOLBY_LAST:
            {
                /* NO support currently! set sdr output instead.*/
                DISP_ERROR("Error PlayMode!Set SDR out instead.\n");
                pstHdrCfg->enHdrMode = DRV_HISI_HDR10_IN_SDR_OUT;
                break;
            }
            default:
                pstHdrCfg->enHdrMode = DRV_HISI_HDR10_IN_SDR_OUT;
                break;
        }
    
        /*step2: generate other attributes of HdrCfg.*/
        pstHdrCfg->stResoOut             = stOutRect;
        pstHdrCfg->stResoIn              = pstFrm->stDispRect;
        pstHdrCfg->stFrame.enBitWidth    = pstFrm->enBitWidth;
        pstHdrCfg->stFrame.enPixFormat   = pstFrm->ePixFormat;
        pstHdrCfg->stFrame.bSecurity     = pstFrm->bSecure;
    
        DISP_RecognizeCompressFrm(pstHdrCfg->stFrame.enPixFormat,
                                  &pstHdrCfg->stFrame.bDcmpEn);
    
        DISP_TransferAddress(&pstFrm->stBufAddr[0], &pstHdrCfg->stFrame.stAddress[0]);
        if (HI_DRV_PIXEL_BITWIDTH_10BIT == pstHdrCfg->stFrame.enBitWidth)
        {
            DISP_TransferAddress(&pstFrm->stBufAddr_LB[0],
                                 &pstHdrCfg->stFrame.stAddress_lb[0]);
        }
    return ;
}

static HI_VOID DISP_HisiHdr10WorkModeProcess(DISP_S                     *pstDisp,
                                         WINDOW_DOLBY_REFERENCE_INFO_S  *pstWinDoviRefInfo,
                                         HI_DRV_HDMI_HDR_ATTR_S         *pstHdmiHdrAttr)
{
    HiHDRDmTMCfg                      *pstPqHdrCfg = HI_NULL;
    HI_DRV_HDR_PLAY_MODE_E             enPlayMode = HI_DRV_HDR_PLAY_MODE_BUTT;
    HI_DRV_VIDEO_FRAME_S              *pstFrm = HI_NULL;
    DISP_BUF_NODE_S                   *pstDispBufNode = HI_NULL;
    HI_DRV_DISP_HISI_HDR_CFG_S         stHisiHdrCfg ;
    HI_RECT_S                          stOutRect;

    memset(&stHisiHdrCfg,0x0,sizeof(HI_DRV_DISP_HISI_HDR_CFG_S));
    memset(&stOutRect,0x0,sizeof(HI_RECT_S));
    
    pstFrm       = pstWinDoviRefInfo->pCurrentFrame;
    stOutRect    = pstWinDoviRefInfo->stWinOutRect;

    if(HI_NULL == pstFrm)
    {
        //when mute in hdr10, config hdmi's metadata with last configuration.
        pstDisp->pstIntfOpt->PF_SetHisiHdrMute(HI_TRUE);
        pstDisp->stHdrPlayInfo.stHisiHdrinfo.stLastHdrCfg.bMuteEn = HI_TRUE;
        pstDisp->stHdrProcInfo.stHisiHdrProcInfo.stHisiHdrCfg = pstDisp->stHdrPlayInfo.stHisiHdrinfo.stLastHdrCfg;

        DISP_Hdr10WorkModeSetHdmiHdrAttr(&pstDisp->stHdrPlayInfo.stLastHdr10Info,
                                         pstDisp->stHdrPlayInfo.enLastPlayMode,
                                         pstHdmiHdrAttr);
    }
    else
    {
        pstDispBufNode = container_of((HI_U32*)pstFrm, DISP_BUF_NODE_S, u32Data[0]);

        /*step1: make play mode policy.*/
        enPlayMode = DISP_Hdr10PlayModePolicy(pstDispBufNode->stDolbyInfo.enDispOutType);

        /*step2: get PqHdrCfg para. */
        pstPqHdrCfg = (HiHDRDmTMCfg *)pstDispBufNode->u8Metadata;

        pstDisp->stHdrProcInfo.enHdrPlayMode = enPlayMode;
        
        /*step3: generate CBB's HdrCfg para.*/
        DISP_GenerateHisiHdr10WorkModeHdrCfg(pstFrm,enPlayMode,stOutRect,&stHisiHdrCfg);

        /* record info for proc. */
        pstDisp->stHdrProcInfo.stHisiHdrProcInfo.stHisiHdrCfg = stHisiHdrCfg;

        /*step4: call CBB's adapter interface to config */
        pstDisp->pstIntfOpt->PF_SetHisiHdrMode(&stHisiHdrCfg,pstPqHdrCfg);

        /*step5: set HDMI Hdr attr according to play mode. */
        DISP_Hdr10WorkModeSetHdmiHdrAttr(&pstFrm->unHDRInfo.stHDR10Info, enPlayMode, pstHdmiHdrAttr);
        pstDisp->stHdrPlayInfo.stHisiHdrinfo.stLastHdrCfg = stHisiHdrCfg;
        pstDisp->stHdrPlayInfo.stLastHdr10Info = pstFrm->unHDRInfo.stHDR10Info;
        pstDisp->stHdrPlayInfo.enLastPlayMode  = enPlayMode;
    }

    return ;
}

HI_VOID DISP_SetHdmiHdrAttr(HI_UNF_HDMI_ID_E enHdmi, HI_DRV_HDMI_HDR_ATTR_S *pstHdrAttr)
{
    //get HDMI export functions.
    if (HI_NULL == s_pstHDMIFunc)
    {
        if (HI_SUCCESS != DispGetHdmiExportFuncPtr(&s_pstHDMIFunc))
        {
            DISP_ERROR("DISP_get HDMI func failed!");
            return ;
        }
    }

    if (s_pstHDMIFunc->pfnHdmiSetHdrAttr)
    {
        if(s_pstHDMIFunc->pfnHdmiSetHdrAttr(HI_UNF_HDMI_ID_0, pstHdrAttr))
        {
            DISP_ERROR("HDMI setHdrAttr Fail.\n");
        }
    }
    else
    {
        DISP_ERROR("pfnHdmiSetHdrAttr of HDMI is NULL!\n");
    }

    return;
}

/*******************************************************************************
para[in] : hHandle  handle of display(HD).
para[in] : pstInfo  call-back disp info,update in DISP_CB_PreProcess function.
this function mainly process different kind of video source.SDR/HDR10/DolbyVision.
********************************************************************************/

HI_VOID DISP_ISR_SourceProcess(HI_VOID* hHandle, const HI_DRV_DISP_CALLBACK_INFO_S* pstInfo)
{
    DISP_S*                         pstDisp = HI_NULL;
    WINDOW_DOLBY_REFERENCE_INFO_S   stWinDolbyRefInfo;
    HI_DRV_DISP_WORKING_MODE_E      enWorkMode = HI_DRV_DISP_WORKING_MODE_BUTT;
    HI_DRV_HDMI_HDR_ATTR_S          stHdmiHdrAttr;
    HI_DISP_DISPLAY_INFO_S          stDispInfo;
	static HI_U32   u32Step = 0;

    pstDisp = (DISP_S*)hHandle;

    //needn't to refresh disp HDR proc info,just keep it in last status.
    //memset(&pstDisp->stHdrProcInfo,0x0,sizeof(HI_DRV_DISP_HDR_PROC_INFO_S));

    memset(&stWinDolbyRefInfo,0x0,sizeof(WINDOW_DOLBY_REFERENCE_INFO_S));
    //nomatter what kind of frame HDMI send,it will set HdmiHdrAttr info.
    memset(&stHdmiHdrAttr,0x0,sizeof(HI_DRV_HDMI_HDR_ATTR_S));

    //prepare update DispInfo for GFX.
    memset(&stDispInfo,0x0,sizeof(HI_DISP_DISPLAY_INFO_S));
    stDispInfo = pstInfo->stDispInfo;

    //step1.get DoviWinInfo and LastPlayMode info for working mode policy
    GetWinDoviRefInfo(&stWinDolbyRefInfo);

    //step2.get working mode,i.e.,Normal control path or Dolby control path.
    //NOTE:both Dolby working mode and HDR10 working mode use Dolby control path.
    enWorkMode = DISP_WorkingModePolicy(&stWinDolbyRefInfo, &pstDisp->stHdrPlayInfo);
    pstDisp->stHdrProcInfo.enWorkMode = enWorkMode;
    //step3.process according to the enWorkMode.
    switch(enWorkMode)
    {
        /* SDR working mode process.*/
        case HI_DRV_DISP_WORKING_MODE_SDR:
        {
            /* Normal working path, should set disable HDR mode to HDMI.*/
            stHdmiHdrAttr.enHdrMode = HI_DRV_HDMI_HDR_MODE_DISABLE;
            break;
        }
        /* DolbyVision working mode process,output signal types:SDR/DolbyVision/HDR10.*/
        case HI_DRV_DISP_WORKING_MODE_DOLBY_HDR:
        {
            DISP_DolbyWorkModeProcess(pstDisp,&stWinDolbyRefInfo,&stHdmiHdrAttr);
            break;
        }
        /* graphic last DolbyVision working mode process.*/
        case HI_DRV_DISP_WORKING_MODE_LAST_GRAPHIC_DOLBY:
        {
            /* config graphic layer according to last configration.*/
            DISP_LastGfxDolbyWorkModeProcess(pstDisp,&stHdmiHdrAttr);
            break;
        }
         /* Dolby-HDR10 working mode process,output signal types:SDR/HDR10.*/
        case HI_DRV_DISP_WORKING_MODE_DOLBY_HDR10:
        {
            DISP_DolbyHdr10WorkModeProcess(pstDisp,&stWinDolbyRefInfo,&stHdmiHdrAttr);
            break;
        }
        /* Hisi-HDR10 working mode process,output signal types:SDR/HDR10.*/
        case HI_DRV_DISP_WORKING_MODE_HISI_HDR10:
        {
            DISP_HisiHdr10WorkModeProcess(pstDisp,&stWinDolbyRefInfo,&stHdmiHdrAttr);
            break;
        }
        default:
            break;
    }

   /* step4.send HDR attributes to HDMI and update disp work mode for graphic.*
    * 1.In HDR work mode, setHdmiHdrAttr every frame;
    * 2.In SDR work mode,
    *    2.1 if last work mode is HDR, setHdmiHdrAttr this frame;
    *    2.2 if last work mode is SDR, needn't setHdmiHdrAttr;
    */
    if(HI_DRV_DISP_WORKING_MODE_SDR == enWorkMode)
    {
	    /* if last work mode is HDR,need to clean the registers! */
        switch (pstDisp->stHdrPlayInfo.enLastWorkMode)
        {
            case HI_DRV_DISP_WORKING_MODE_SDR:
            {
			    if (1 == u32Step)
			    {
				     pstDisp->pstIntfOpt->PF_CleanHdr(HI_TRUE);
			    }
                else if(2 == u32Step)
                {
                    pstDisp->pstIntfOpt->PF_CleanHisiHdr(HI_TRUE);
                }
			    u32Step = 0;
                break;
            }
            case HI_DRV_DISP_WORKING_MODE_HISI_BBC:
            case HI_DRV_DISP_WORKING_MODE_HISI_HDR10:
            {
                pstDisp->pstIntfOpt->PF_CleanHisiHdr(HI_FALSE);
                u32Step = 2;
				if (pstDisp->stSetting.stIntf[HI_DRV_DISP_INTF_HDMI0].bOpen)
			    {
				    DISP_SetHdmiHdrAttr(HI_UNF_HDMI_ID_0,&stHdmiHdrAttr);
			    }
                break;
            }
            case HI_DRV_DISP_WORKING_MODE_DOLBY_HDR:
            case HI_DRV_DISP_WORKING_MODE_DOLBY_HDR10:
            case HI_DRV_DISP_WORKING_MODE_LAST_GRAPHIC_DOLBY:
            {			    
                pstDisp->pstIntfOpt->PF_CleanHdr(HI_FALSE);
				u32Step = 1;
				if (pstDisp->stSetting.stIntf[HI_DRV_DISP_INTF_HDMI0].bOpen)
			    {
				    DISP_SetHdmiHdrAttr(HI_UNF_HDMI_ID_0,&stHdmiHdrAttr);
			    }
                break;
            }
            default:
                break;
        }

        if ((HI_TRUE == pstDisp->stSetting.bBT2020Support)
            || (HI_DRV_DISP_TYPE_DOLBY == pstDisp->stSetting.stDispHDRAttr.enDispType)
			|| (HI_DRV_DISP_TYPE_HDR10 == pstDisp->stSetting.stDispHDRAttr.enDispType)
			|| (HI_DRV_DISP_TYPE_HDR10_CERT == pstDisp->stSetting.stDispHDRAttr.enDispType)
			) 
        {
             if (HI_NULL != stWinDolbyRefInfo.pCurrentFrame)
             {
    			HI_DRV_VIDEO_PRIVATE_S *pstPriv;
    			pstPriv = (HI_DRV_VIDEO_PRIVATE_S *) stWinDolbyRefInfo.pCurrentFrame->u32Priv;

    			if (HI_DRV_VIDEO_FRAME_TYPE_SDR == stWinDolbyRefInfo.pCurrentFrame->enSrcFrameType )
    			{
					if ((HI_DRV_CS_BT2020_YUV_LIMITED == pstPriv->eColorSpace)
						||(HI_DRV_CS_BT2020_YUV_FULL == pstPriv->eColorSpace)
						||(HI_DRV_CS_BT2020_RGB_LIMITED == pstPriv->eColorSpace)
						||(HI_DRV_CS_BT2020_RGB_FULL == pstPriv->eColorSpace)
						)
					{
                       /*set  attr */
						if (HI_TRUE != pstDisp->stSetting.bBT2020Enable)
						{
						  DISP_THREAT_PROCESS_S* pstDispThread  = HI_NULL;
						  pstDispThread = &s_stDisplayDevice.stDispThread;

						  pstDispThread->enThreadEvent = EVENT_DISP_CSC_CHANGE;
						  pstDispThread->enDisp = HI_DRV_DISPLAY_1;
						  pstDispThread->bBt2020Enable = HI_TRUE;
					      wake_up(&pstDispThread->stWaitQueHead);
						}
					}
                    
    			}
    		
    	    } 
         	else
			{
				if (HI_TRUE == pstDisp->stSetting.bBT2020Enable)
				{
				  DISP_THREAT_PROCESS_S* pstDispThread  = HI_NULL;
				  pstDispThread = &s_stDisplayDevice.stDispThread;

				  pstDispThread->enThreadEvent = EVENT_DISP_CSC_CHANGE;
				  pstDispThread->enDisp = HI_DRV_DISPLAY_1;
				  pstDispThread->bBt2020Enable = HI_FALSE;
			      wake_up(&pstDispThread->stWaitQueHead);
				}
			}
        }
        else
		{
			if (HI_TRUE == pstDisp->stSetting.bBT2020Enable)
			{
			  DISP_THREAT_PROCESS_S* pstDispThread  = HI_NULL;
			  pstDispThread = &s_stDisplayDevice.stDispThread;

			  pstDispThread->enThreadEvent = EVENT_DISP_CSC_CHANGE;
			  pstDispThread->enDisp = HI_DRV_DISPLAY_1;
			  pstDispThread->bBt2020Enable = HI_FALSE;
		      wake_up(&pstDispThread->stWaitQueHead);
			}
        }

        stDispInfo.enDispProcessMode = HI_DRV_DISP_PROCESS_MODE_SDR;
    }
    else
    {
    	if (pstDisp->stSetting.stIntf[HI_DRV_DISP_INTF_HDMI0].bOpen)
    	{
			DISP_SetHdmiHdrAttr(HI_UNF_HDMI_ID_0,&stHdmiHdrAttr);
    	}
        stDispInfo.enDispProcessMode = HI_DRV_DISP_PROCESS_MODE_HDR;
    }
    /* disp process mode info for Gfx */
    (HI_VOID)DISP_ISR_SetDispInfo(pstDisp->enDisp, &stDispInfo);

    /* store as last work mode */
    pstDisp->stHdrPlayInfo.enLastWorkMode = enWorkMode;

}


HI_BOOL DISP_OutputTypeAndFormatMatch(HI_DRV_DISP_OUT_TYPE_E enOutputType,
                                     HI_DRV_DISP_FMT_E  enFormat)
{
    //disp format should not be interlace when disp output type is Dolby.
    if (HI_DRV_DISP_TYPE_DOLBY == enOutputType)
    {
        if ((HI_DRV_DISP_FMT_1080i_60 <= enFormat) &&
            (enFormat <= HI_DRV_DISP_FMT_1080i_50))
        {
            DISP_ERROR("Cannot support interlace format while set Dolby output type!\n");
            return HI_FALSE;
        }

        if ((HI_DRV_DISP_FMT_PAL <= enFormat) &&
            (enFormat <= HI_DRV_DISP_FMT_1440x480i_60))
        {
            DISP_ERROR("Cannot support interlace format while set Dolby output type!\n");
            return HI_FALSE;
        }

        if (HI_DRV_DISP_FMT_1080i_59_94 == enFormat)
        {
            DISP_ERROR("Cannot support interlace format while set Dolby output type!\n");
            return HI_FALSE;
        }

    }
    return HI_TRUE;
}


#ifdef __cplusplus
#if __cplusplus
}
#endif
#endif



