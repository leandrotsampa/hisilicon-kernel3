/******************************************************************************

  Copyright (C), 2012-2050, Hisilicon Tech. Co., Ltd.

 ******************************************************************************
  File Name     : drv_vicap.c
  Version       : Initial Draft
  Author        : Hisilicon multimedia software group
  Created       : 2013/10/29
  Description   : 
  History       :
  1.Date        : 2013/10/29
    Author      : w00248302/c00186004
    Modification: Created file
******************************************************************************/
#include <linux/interrupt.h>
#include <linux/spinlock.h>
#include <linux/seq_file.h>

#include "drv_vicap.h"
#include "hi_drv_vicap.h"
#include "hi_common.h"
#include "hi_osal.h"
#include "hi_type.h"
#include "drv_vicap_buf.h"
#include "drv_uf.h"
#include "drv_pq_ext.h"
#include "hi_drv_module.h"
#include "hi_drv_sys.h"

#define MAXVICAP 2

#ifdef HI_FPGA
#define VICAP_IRQ_NR (45 + 32)
#else
#define VICAP_IRQ_NR (89 + 32)
#endif
static VICAP_DRV_CTX_S g_stVicapDrvCtx[MAXVICAP];
static HI_U32 g_u32VicapCount;

VICAP_USED_EXT_FUNC_S g_stVicapExtFunc = {HI_NULL};

static spinlock_t stVicapDrvLock;

#define VICAP_DRV_SPIN_LOCK(flags)   spin_lock_irqsave(&stVicapDrvLock, flags)
#define VICAP_DRV_SPIN_UNLOCK(flags) spin_unlock_irqrestore(&stVicapDrvLock, flags)

#define VICAP_CHECK_NULL_PTR(ptr)\
do{\
    if (NULL == ptr)\
    {\
        HI_ERR_VICAP("NULL point \n");\
        return HI_FAILURE;\
    }\
}while(0)

#define VICAP_CHECK_HVICAP(hVicap)\
    do{\
        if(HI_ID_VICAP != GETVICAPID(hVicap))\
        {\
            HI_ERR_VICAP("Invalid HI_ID_VICAP:0x%x \n",GETVICAPID(hVicap));\
            return HI_FAILURE;\
        }\
        if(GETCONTEXTID(hVicap) >= MAXVICAP)\
        {\
            HI_ERR_VICAP("Invalid CONTEXTID:0x%x \n",GETCONTEXTID(hVicap));\
            return HI_FAILURE;\
        }\
        if(GETPHYPT(hVicap) >= MAXPT)\
        {\
            HI_ERR_VICAP("Invalid PHYPT:0x%x \n",GETPHYPT(hVicap));\
            return HI_FAILURE;\
        }\
        if(GETPHYCHN(hVicap) > (VICAP_PHYCHN_CHN0 | VICAP_PHYCHN_CHN1) )\
        {\
            HI_ERR_VICAP("Invalid PHYCHN:0x%x \n",GETPHYCHN(hVicap));\
            return HI_FAILURE;\
        }\
        if (hVicap != (g_stVicapDrvCtx[GETCONTEXTID(hVicap)].hViCap))\
        {\
            HI_ERR_VICAP("Invalid hVicap:0x%x \n",hVicap);\
            return HI_FAILURE;\
        }\
    }while(0)
#if    defined(CHIP_TYPE_hi3751v100)   \
    || defined(CHIP_TYPE_hi3751v100b)          
#define VICAP_GET_HDDEC_FUNC(pHddecFunc)\
    do{\
        if (HI_NULL == g_stVicapExtFunc.pHddecExtFunc)\
        {\
            if (HI_DRV_MODULE_GetFunction(HI_ID_HDDEC, (HI_VOID**)&(g_stVicapExtFunc.pHddecExtFunc)))\
            {\
                HI_ERR_VICAP("Get Function from Hddec failed.\n");\
                return HI_FAILURE;\
            }\
            if (HI_NULL == g_stVicapExtFunc.pHddecExtFunc)\
            {\
                HI_ERR_VICAP("Hddec not register export function.\n");\
                return HI_FAILURE;\
            }\
        }\
        pHddecFunc = g_stVicapExtFunc.pHddecExtFunc;\
    }while(0)   
#endif

#if    defined(CHIP_TYPE_hi3751v100)   \
    || defined(CHIP_TYPE_hi3798cv100)  \
    || defined(CHIP_TYPE_hi3796cv100)    
#define VICAP_GET_HDMIRX_FUNC(pHdmirxFunc)\
    do{\
        if (HI_NULL == g_stVicapExtFunc.pHdmirxExtFunc)\
        {\
            if (HI_DRV_MODULE_GetFunction(HI_ID_HDMIRX, (HI_VOID**)&(g_stVicapExtFunc.pHdmirxExtFunc)))\
            {\
                HI_ERR_VICAP("Get Function from Hdmirx failed.\n");\
                return HI_FAILURE;\
            }\
            if (HI_NULL == g_stVicapExtFunc.pHdmirxExtFunc)\
            {\
                HI_ERR_VICAP("Hdmirx not register export function.\n");\
                return HI_FAILURE;\
            }\
        }\
        pHdmirxFunc = g_stVicapExtFunc.pHdmirxExtFunc;\
    }while(0)
#endif
HI_S32 VICAP_DRV_GetVicapCtx(HI_U32 u32VicapContextId, VICAP_DRV_CTX_S **pstVicapDrvCtx)
{
    VICAP_CHECK_NULL_PTR(pstVicapDrvCtx);
    *pstVicapDrvCtx = &g_stVicapDrvCtx[u32VicapContextId];
    return HI_SUCCESS;
}

/*获取VICAP通道索引*/
static HI_S32 VICAP_DRV_GetChnIndex(HI_HANDLE hVicap)
{
    HI_U32 i;
    HI_U32 u32Chnindex = 0;

    for(i = 0; i < MAXCHN; i++)
    {
        if(0 != ((1 << i) & (GETPHYCHN(hVicap))))
        {
             u32Chnindex = i;
             break;
        }
    }
    return u32Chnindex;
}

/* 选择需要打开、关闭的时钟 */
static HI_VOID VICAP_DRV_SetClkAndReset(HI_HANDLE hVicap, HI_BOOL bEnable)
{   
    HI_U32 u32ContextIndex = 0;
    HI_U32 u32PtIndex = 0;
    HI_U32 u32ChnIndex = 0;
    
    u32ContextIndex = GETCONTEXTID(hVicap);
    u32PtIndex = GETPHYPT(hVicap);
    u32ChnIndex = GETPHYCHN(hVicap);

    /* 3D */
    if(HI_DRV_FT_NOT_STEREO != g_stVicapDrvCtx[u32ContextIndex].stVicapAttr.en3dFmt)
    {
        /* 打开关闭，时钟门控*/
        VICAP_HAL_SetPpcClken(VICAP_PHYCHN_CHN0,bEnable);
        VICAP_HAL_SetPpcClken(VICAP_PHYCHN_CHN1,bEnable);
        VICAP_HAL_SetPtClken(VICAP_PHYPT_PT0,bEnable);
        VICAP_HAL_SetPtClken(VICAP_PHYPT_PT1,bEnable);

        /* 复位，撤销复位*/
        VICAP_HAL_SetPpcReset(VICAP_PHYCHN_CHN0,!bEnable);
        VICAP_HAL_SetPpcReset(VICAP_PHYCHN_CHN1,!bEnable);
        VICAP_HAL_SetPtReset(VICAP_PHYPT_PT0,!bEnable);
        VICAP_HAL_SetPtReset(VICAP_PHYPT_PT1,!bEnable);
    }
    /* 2D */
    else
    {
        /* 打开时钟门控*/           
        VICAP_HAL_SetPpcClken(u32ChnIndex,bEnable); 
        VICAP_HAL_SetPtClken(u32PtIndex,bEnable);
        
        /* 复位，撤销复位*/            
        VICAP_HAL_SetPpcReset(u32ChnIndex,!bEnable);
        VICAP_HAL_SetPtReset(u32PtIndex,!bEnable); 
    }    
}

/*帧信息转换*/
static HI_S32 VICAP_DRV_ConvertFrmInfo(HI_U32 u32ContextIndex,VICAP_BUF_S *stBuf,VICAP_FRAME_STATUS_S *pstFrmStatus, HI_DRV_VIDEO_FRAME_S *pstCurFrm)
{
    HI_DRV_VIDEO_PRIVATE_S  *pstFrmPriv = HI_NULL;
    
    VICAP_CHECK_NULL_PTR(pstFrmStatus);
    VICAP_CHECK_NULL_PTR(pstCurFrm);
    VICAP_CHECK_NULL_PTR(stBuf);
    
   /*为当前视频帧分配内存*/
    memset(pstCurFrm, 0, sizeof(HI_DRV_VIDEO_FRAME_S));

    /*设置当前帧的信息*/ 
    pstCurFrm->u32Width = pstFrmStatus->u32DstWidth;
    pstCurFrm->u32Height = pstFrmStatus->u32DstHeight;
    pstCurFrm->u32FrameRate = (pstFrmStatus->u32DstFrameRate)*1000;
    pstCurFrm->enBitWidth = pstFrmStatus->enDstBitWidth;
    pstCurFrm->ePixFormat = pstFrmStatus->enVideoFormat;
    pstCurFrm->bProgressive = !pstFrmStatus->stSourceTimingInfo.bInterlace;
    pstCurFrm->enFieldMode = HI_DRV_FIELD_ALL;
    pstCurFrm->bTopFieldFirst = HI_TRUE;
    pstCurFrm->eFrmType = pstFrmStatus->stSourceTimingInfo.en3dType;
    /*满足系统需求，在发送之前，3D格式统一更改为HI_DRV_FT_FPK*/
    if(pstFrmStatus->stSourceTimingInfo.en3dType > HI_DRV_FT_NOT_STEREO)
    {
        pstCurFrm->eFrmType = HI_DRV_FT_FPK;
    }
    pstCurFrm->u32Circumrotate = 0;
    pstCurFrm->bToFlip_V = HI_FALSE;

    /*Timing 信息*/
    pstFrmPriv =(HI_DRV_VIDEO_PRIVATE_S *)(&pstCurFrm->u32Priv[0]);
    memset(pstFrmPriv, 0, sizeof(HI_DRV_VIDEO_PRIVATE_S));
    pstFrmPriv->stVideoOriginalInfo.enSource    = pstFrmStatus->stSourceTimingInfo.enSource; 
    pstFrmPriv->stVideoOriginalInfo.u32Width    = pstFrmStatus->stSourceTimingInfo.u32SrcWidth ;
    pstFrmPriv->stVideoOriginalInfo.u32Height   = pstFrmStatus->stSourceTimingInfo.u32SrcHeight;
    pstFrmPriv->stVideoOriginalInfo.u32FrmRate  = (pstFrmStatus->stSourceTimingInfo.u32SrcFrmRate)*1000;
    pstFrmPriv->stVideoOriginalInfo.en3dType    = pstFrmStatus->stSourceTimingInfo.en3dType;
    pstFrmPriv->stVideoOriginalInfo.enSrcColorSpace = pstFrmStatus->stSourceTimingInfo.enSrcColorSpace;
    pstFrmPriv->stVideoOriginalInfo.enColorSys  =  pstFrmStatus->stSourceTimingInfo.enSrcColorSys; 
    pstFrmPriv->stVideoOriginalInfo.bGraphicMode=   pstFrmStatus->stSourceTimingInfo.bGraphicMode; 
    pstFrmPriv->stVideoOriginalInfo.bInterlace  =  pstFrmStatus->stSourceTimingInfo.bInterlace; 

    /* Default ColorSpacae in DDR equal Timing ColorSpace, when RGB Convert to YUV, ColorSpace will set as YUV709 */
    pstFrmPriv->eColorSpace = pstFrmStatus->eCscColorSpace;

    /*左眼地址*/
    pstCurFrm->stBufAddr[VICAP_EYE_LEFT].u32Stride_Y = pstFrmStatus->u32YStride;
    pstCurFrm->stBufAddr[VICAP_EYE_LEFT].u32Stride_C = pstFrmStatus->u32CStride;
    pstCurFrm->stBufAddr[VICAP_EYE_LEFT].u32PhyAddr_Y = stBuf->stVideoFrmInfo.stBufAddr[VICAP_EYE_LEFT].u32PhyAddr_Y;
    pstCurFrm->stBufAddr[VICAP_EYE_LEFT].u32PhyAddr_C =  pstCurFrm->stBufAddr[VICAP_EYE_LEFT].u32PhyAddr_Y+ \
        (pstFrmStatus->u32DstHeight)*(pstFrmStatus->u32YStride);
    /* 隔行的3D Frame Package，需要特殊处理 */
    if (pstFrmStatus->stSourceTimingInfo.bInterlace  && (HI_DRV_FT_FPK == pstFrmStatus->stSourceTimingInfo.en3dType))
    {
        pstCurFrm->stBufAddr[VICAP_EYE_LEFT].u32PhyAddr_C = pstCurFrm->stBufAddr[VICAP_EYE_LEFT].u32PhyAddr_Y
                    +(pstFrmStatus->u32DstHeight)*(pstFrmStatus->u32YStride)*2;
    }

    /*检测视频是否为3D格式*/
    if (pstFrmStatus->b3D)
    {
        pstCurFrm->stBufAddr[VICAP_EYE_RIGHT].u32Stride_Y = pstFrmStatus->u32YStride;
        pstCurFrm->stBufAddr[VICAP_EYE_RIGHT].u32Stride_C = pstFrmStatus->u32CStride;
        pstCurFrm->stBufAddr[VICAP_EYE_RIGHT].u32PhyAddr_Y = stBuf->stVideoFrmInfo.stBufAddr[VICAP_EYE_LEFT].u32PhyAddr_Y + (pstFrmStatus->u32BufSize)/2;
        pstCurFrm->stBufAddr[VICAP_EYE_RIGHT].u32PhyAddr_C =  pstCurFrm->stBufAddr[VICAP_EYE_RIGHT].u32PhyAddr_Y + \
            (pstFrmStatus->u32DstHeight)*(pstFrmStatus->u32YStride);
        
        /* 隔行的3D Frame Package，需要特殊处理 */
        if (pstFrmStatus->stSourceTimingInfo.bInterlace  && (HI_DRV_FT_FPK == pstFrmStatus->stSourceTimingInfo.en3dType))
        {

            pstCurFrm->stBufAddr[VICAP_EYE_RIGHT].u32PhyAddr_Y = pstCurFrm->stBufAddr[VICAP_EYE_LEFT].u32PhyAddr_Y + \
                (pstFrmStatus->u32DstHeight)*(pstFrmStatus->u32YStride);
            pstCurFrm->stBufAddr[VICAP_EYE_RIGHT].u32PhyAddr_C =  pstCurFrm->stBufAddr[VICAP_EYE_LEFT].u32PhyAddr_C + \
                (pstFrmStatus->u32DstHeight)*(pstFrmStatus->u32CStride);
        }
    }
    return HI_SUCCESS;
}
        
/*获取帧buffer*/
static HI_S32 VICAP_DRV_GetFrmBuf(HI_HANDLE hVicap,VICAP_FRAME_STATUS_S *pstFrmStatus, HI_DRV_VIDEO_FRAME_S *pstCurFrm)
{
    VICAP_BUF_S stBuf;
    HI_U32 u32ContextIndex;

    u32ContextIndex = GETCONTEXTID(hVicap);
    VICAP_CHECK_NULL_PTR(pstFrmStatus);
    VICAP_CHECK_NULL_PTR(pstCurFrm);
    
    if(HI_SUCCESS != VICAP_DRV_BufGet(g_stVicapDrvCtx[u32ContextIndex].hBufHandle, &stBuf))
    {
        HI_INFO_VICAP("VICAP get Free Buf Failed \n");
        return HI_FAILURE;
    }
    if(HI_SUCCESS != VICAP_DRV_ConvertFrmInfo(u32ContextIndex,&stBuf,pstFrmStatus,pstCurFrm))
    {
        HI_INFO_VICAP("VICAP ConvertFrmInfo Failed \n");
        return HI_FAILURE;
    }   
    
    return HI_SUCCESS; 
}

static HI_S32 VICAP_DRV_PutFrmBuf(HI_HANDLE hVicap,VICAP_BUF_BLK_S * pstVicapBlk)
{
    HI_HANDLE hBufHandle;
    HI_U32 u32PhyAddr;
    HI_S32 s32Ret;
    HI_U32 u32ContextIndex;

    u32ContextIndex = GETCONTEXTID(hVicap);
    VICAP_CHECK_NULL_PTR(pstVicapBlk);
    if (pstVicapBlk->bValid)
    {     
        hBufHandle = g_stVicapDrvCtx[u32ContextIndex].hBufHandle;
        u32PhyAddr = pstVicapBlk->stVicapFrameInfo.stBufAddr[VICAP_EYE_LEFT].u32PhyAddr_Y;
        s32Ret = VICAP_DRV_BufSub(hBufHandle,u32PhyAddr);     
        HI_ASSERT(HI_SUCCESS == s32Ret);
        pstVicapBlk->bValid = HI_FALSE;
    }
    return HI_SUCCESS;
}

static HI_S32 VICAP_DRV_CheckAttr(HI_DRV_VICAP_ATTR_S *pstVicapAttr)
{
    HI_U32 u32SrcWidth = 0;
    HI_U32 u32SrcHeight = 0;

    VICAP_CHECK_NULL_PTR(pstVicapAttr);
        
    u32SrcWidth = pstVicapAttr->u32Width;/* 源图像一帧的宽度,3D格式为单眼宽度*/
    u32SrcHeight = pstVicapAttr->u32Height; /* 源图像一帧的高度，即隔行信号是两场的高度，逐行信号是一帧的高度，3D格式为单眼高度*/

    /*主次*/
    if(HI_DRV_VICAP_BUTT <= pstVicapAttr->enType)
    {
        HI_ERR_VICAP("Invalid Vicap type %d\n", pstVicapAttr->enType);
        return HI_FAILURE;
    }
    
    /*VICAP对接的输入源*/
    if(HI_DRV_VICAP_ACCESS_BUTT <= pstVicapAttr->enAccess)
    {
        HI_ERR_VICAP("Invalid Vicap Access %d\n", pstVicapAttr->enAccess);
        return HI_FAILURE;
    }
    
    /*3D格式*/
    if (HI_DRV_FT_BUTT <= pstVicapAttr->en3dFmt)
    {
        HI_ERR_VICAP("Invalid 3D format %d of VICAP \n", pstVicapAttr->en3dFmt);
        return HI_FAILURE;
    }

    /*VICAP对接的时序类型*/
    if(HI_DRV_VICAP_INTF_BUTT <= pstVicapAttr->enIntfMode)
    {
        HI_ERR_VICAP("Invalid Vicap Intf  %d\n", pstVicapAttr->enIntfMode);
        return HI_FAILURE;
    }

    /*逐隔行*/
    if ((HI_TRUE != pstVicapAttr->bInterlace) && (HI_FALSE != pstVicapAttr->bInterlace))
    {
        HI_ERR_VICAP("Invalid interlace %d of VICAP \n", pstVicapAttr->bInterlace);
        return HI_FAILURE;
    }
    
    /*宽高*/
    if ((u32SrcWidth < VICAP_MIN_WIDTH) || (u32SrcHeight < VICAP_MIN_HEIGHT))
    {
        HI_ERR_VICAP("src rect must larger than 128x128, u32SrcWidth = %d, u32SrcHeight = %d\n",u32SrcWidth,u32SrcHeight);
        return HI_FAILURE;
    }
    
    /* 3D FP格式需要检测帧/场消隐区的宽度 */
    if ((HI_DRV_FT_FPK == pstVicapAttr->en3dFmt) && (0 == pstVicapAttr->u32Vblank))
    {
        HI_ERR_VICAP("vblank must set when input 3d fp video \n");
        return HI_FAILURE;
    }
    
    /*输入像素格式 RGB444,YUV444/422*/
    if ((pstVicapAttr->enPixFmt != HI_DRV_PIX_FMT_RGB444)\
        && (pstVicapAttr->enPixFmt != HI_DRV_PIX_FMT_NV42)\
        && (pstVicapAttr->enPixFmt != HI_DRV_PIX_FMT_NV61_2X1))
    {
        HI_ERR_VICAP("Invalid pixel format %d of VICAP \n", pstVicapAttr->enPixFmt);
        return HI_FAILURE;
    } 
   /* 输出存储格式 RGB_SP444,YUV_SP444/422 */
    if ((pstVicapAttr->stOutAttr.enVideoFmt != HI_DRV_PIX_FMT_RGB444)\
        && (pstVicapAttr->stOutAttr.enVideoFmt != HI_DRV_PIX_FMT_NV42)\
        && (pstVicapAttr->stOutAttr.enVideoFmt != HI_DRV_PIX_FMT_NV61_2X1))
    {
        HI_ERR_VICAP("Invalid video format %d of VICAP \n", pstVicapAttr->stOutAttr.enVideoFmt);
        return HI_FAILURE;
    }   

    /* YUV输入，不能RGB输出*/
    if (((HI_DRV_PIX_FMT_NV61_2X1 == pstVicapAttr->enPixFmt) || (HI_DRV_PIX_FMT_NV42 == pstVicapAttr->enPixFmt))
        &&(pstVicapAttr->stOutAttr.enVideoFmt == HI_DRV_PIX_FMT_RGB444))
    {
        HI_ERR_VICAP("Invalid pixfmt:%d, video format %d of VICAP \n", 
                 pstVicapAttr->enPixFmt, pstVicapAttr->stOutAttr.enVideoFmt);
        return HI_FAILURE;
    }

    /* 422像素格式时宽度必须是偶数 */
    if ((HI_DRV_PIX_FMT_NV61_2X1 == pstVicapAttr->enPixFmt) 
        && VICAP_IS_ODD_NUM(u32SrcWidth))
    {
        HI_ERR_VICAP("source width must be even value，when YUV422 u32SrcWidth = %d\n",u32SrcWidth);
        return HI_FAILURE;
    }
        
    /* 隔行信号时高度必须是偶数 */
    if ((HI_TRUE == pstVicapAttr->bInterlace) && VICAP_IS_ODD_NUM(u32SrcHeight))
    {
        HI_ERR_VICAP("source height must be even value, when interlace.u32SrcHeight = %d\n",u32SrcHeight);
        return HI_FAILURE;
    }
    
    /*是否设置输入和输出帧率*/
    if ((0 == pstVicapAttr->u32FrameRate) || (0 == pstVicapAttr->stOutAttr.u32DstFrameRate))
    {
        HI_ERR_VICAP("must set source frmrate:%d and dest frmrate\n",\
                    pstVicapAttr->u32FrameRate, pstVicapAttr->stOutAttr.u32DstFrameRate);
        return HI_FAILURE;
    }
    
    /*输出帧率是否大于输入帧率*/
    if (pstVicapAttr->u32FrameRate < pstVicapAttr->stOutAttr.u32DstFrameRate)
    {
        HI_ERR_VICAP("dest frmrate:%d should less than source frmrate:%d\n",
            pstVicapAttr->stOutAttr.u32DstFrameRate, pstVicapAttr->u32FrameRate);
        return HI_FAILURE;
    }
    
    /*视频输入位宽是否有效*/
    if (pstVicapAttr->enSrcBitWidth >= HI_DRV_PIXEL_BITWIDTH_BUTT)
    {
        HI_ERR_VICAP("Invalid srcbitwidth:%d of VICAP \n", pstVicapAttr->enSrcBitWidth);
        return HI_FAILURE;
    }
        
    /*视频输出位宽是否有效*/
    if (pstVicapAttr->stOutAttr.enDstBitWidth >= HI_DRV_PIXEL_BITWIDTH_12BIT)
    {
        HI_ERR_VICAP("Invalid dstbitwidth:%d of VICAP \n", pstVicapAttr->stOutAttr.enDstBitWidth);
        return HI_FAILURE;
    }
   
    /*过采样模式是否有效，最大4倍过采样*/
    if (pstVicapAttr->enOverSample >= HI_DRV_OVERSAMPLE_BUTT)
    {
        HI_ERR_VICAP("Invalid over sample mode:%d of VICAP \n", 
            pstVicapAttr->enOverSample);
        return HI_FAILURE;
    }

    /*color space*/
    if (pstVicapAttr->enColorSpace >= HI_DRV_CS_BUTT)
    {
        HI_ERR_VICAP("Invalid Color Space:%d of VICAP \n", pstVicapAttr->enColorSpace);
        return HI_FAILURE;
    }

    /*source type*/
    if (pstVicapAttr->enSourceType >= HI_DRV_SOURCE_BUTT)
    {
        HI_ERR_VICAP("Invalid Source type:%d of VICAP \n", pstVicapAttr->enSourceType);
        return HI_FAILURE;
    }
    
    if (pstVicapAttr->enColorSys >= HI_DRV_COLOR_SYS_BUTT)
    {
        HI_ERR_VICAP("Invalid ColorSys:%d of VICAP \n", pstVicapAttr->enColorSys);
        return HI_FAILURE;
    }
    if ((HI_FALSE != pstVicapAttr->bGraphicMode) && (HI_TRUE != pstVicapAttr->bGraphicMode))
    {
        HI_ERR_VICAP("Invalid bGraphicMode :%d of VICAP \n", pstVicapAttr->bGraphicMode);
        return HI_FAILURE;
    }

    if (pstVicapAttr->enBufMgmtMode >= HI_DRV_VICAP_BUF_BUTT)
    {
        HI_ERR_VICAP("Invalid BufMgmtMode:%d of VICAP \n", pstVicapAttr->enBufMgmtMode);
        return HI_FAILURE;
    }

    if (pstVicapAttr->u32BufNum < VICAP_MIN_BUFNUM)
    {
        HI_ERR_VICAP("Invalid Bufnum :%d of VICAP \n", pstVicapAttr->u32BufNum);
        return HI_FAILURE;
    }

    /*检测是否支持用户获取帧数据*/
    if ((pstVicapAttr->bUserOut != HI_TRUE) && (pstVicapAttr->bUserOut != HI_FALSE))
    {
        HI_ERR_VICAP("Invalid userout:%d of VICAP\n", pstVicapAttr->bUserOut);
        return HI_FAILURE;
    }
  
    /*3D播放格式*/
    if (HI_DRV_VICAP_3DT2D_BUTT <= pstVicapAttr->stOutAttr.en3DT2DMode)
    {
        HI_ERR_VICAP("Invalid en3DT2DMode %d of VICAP \n", pstVicapAttr->stOutAttr.en3DT2DMode);
        return HI_FAILURE;
    }

    return HI_SUCCESS;
}


/*检测创建条件*/
static HI_S32 VICAP_DRV_CheckCreateCondition(HI_DRV_VICAP_ATTR_S *pstVicapAttr)
{

    HI_U32 u32VicapNumOf2D = 0;
    HI_U32 i;

    VICAP_CHECK_NULL_PTR(pstVicapAttr);
    /*创建条件判断*/
    for(i = 0;i < MAXVICAP; i++)
    {   
        if(HI_INVALID_HANDLE != g_stVicapDrvCtx[i].hViCap)
        {
            /*存在3D通路，不管要创建的是什么通路，都不能再创建(确定了存在的为2D通路)*/
            if(HI_DRV_FT_NOT_STEREO != g_stVicapDrvCtx[i].stVicapAttr.en3dFmt)
            {
                HI_ERR_VICAP("There is one 3d path,vicap can't create other path!\n");
                return HI_FAILURE;
            }

            /*存在通路，若要创建的不是2D通路，不能创建(确定了要创建的为2D通路)*/
            if(HI_DRV_FT_NOT_STEREO != pstVicapAttr->en3dFmt)
            {
                HI_ERR_VICAP("There is one 2d path,vicap can't create a 3d path!\n");
                return HI_FAILURE;
            }

            /*要创建的通路与存在的通路主次相同，不能创建*/
            if(pstVicapAttr->enType == g_stVicapDrvCtx[i].stVicapAttr.enType)
            {
                HI_ERR_VICAP("The create path type is &s,it is exist!\n",pstVicapAttr->enType?"SUB":"MAIN");
                return HI_FAILURE;
            }

            u32VicapNumOf2D++;            
        }
    }

    /*存在两个2D通路，不能再创建*/
    if(u32VicapNumOf2D >= MAXVICAP)
    {
        HI_ERR_VICAP("Vicap have two path,can't create other!\n");
        return HI_FAILURE;
    } 
    return HI_SUCCESS;
}

static HI_S32 VICAP_DRV_GenerateHandle(HI_DRV_VICAP_ATTR_S *pstVicapAttr)
 {
    HI_S32 i;
    HI_U32 u32VicapId;
    HI_U32 u32UsingContext = INVALID_ID;
    HI_U32 u32UsingPhyPt = INVALID_ID;
    HI_U32 u32UsingPhychn = INVALID_ID;
    HI_HANDLE hVicap;
    
    VICAP_CHECK_NULL_PTR(pstVicapAttr);
        
    u32VicapId = ((HI_ID_VICAP << 24) & 0xff000000);  

    /*通路选择,遍历，选择第一个空的*/
    for(i = 0; i < MAXVICAP; i++)
    {
        if(HI_INVALID_HANDLE == g_stVicapDrvCtx[i].hViCap)
        {
           u32UsingContext = i;
           break;
        }
    }

    /*端口选择*/
    if(HI_DRV_VICAP_MAIN == pstVicapAttr->enType)
    {
        u32UsingPhyPt = VICAP_PHYPT_PT0;
        u32UsingPhychn = VICAP_PHYCHN_CHN0;
    }
    
    if(HI_DRV_VICAP_SUB == pstVicapAttr->enType)
    {
        u32UsingPhyPt = VICAP_PHYPT_PT1;
        u32UsingPhychn = VICAP_PHYCHN_CHN1;
    }

    /*3D默认使用两个通道*/
    if(HI_DRV_FT_NOT_STEREO != pstVicapAttr->en3dFmt)
    {
        u32UsingPhychn = (VICAP_PHYCHN_CHN0 | VICAP_PHYCHN_CHN1);
    }

    hVicap = (u32VicapId | (u32UsingContext << 16) | (u32UsingPhyPt << 8) | (u32UsingPhychn));

    return hVicap;
 }

static HI_S32 VICAP_DRV_CheckChnHScale(HI_U32 u32CropWidth, HI_U32 u32DestWidth)
{
    HI_U32  u32HStep = 0;

    u32HStep = (u32CropWidth << 20)/u32DestWidth;
    
    /* 最大缩小倍数为:水平16倍(65536 =16x4096) */
    if (u32HStep >= VICAP_MAX_HFIR_RATIO)
    {
        HI_ERR_VICAP("The max scale multiple should be 16\n");
        return HI_FAILURE;
    }

    return HI_SUCCESS;
}

static HI_S32 VICAP_DRV_CheckChnVScale(HI_U32 u32CropHeight, HI_U32 u32DestHeight)
{
    HI_U32  u32VStep = 0; 

    u32VStep = u32CropHeight / u32DestHeight;
    
    /* 最大缩小倍数为:垂直16倍,缩放倍数为2-16的整数*/
    if ((u32VStep >= VICAP_MAX_VFIR_RATIO))
    {
        HI_ERR_VICAP("The max scale multiple should be 16\n");
        return HI_FAILURE;
    }

    return HI_SUCCESS;
}

static HI_S32 VICAP_DRV_CheckOutputAttr(HI_U32 u32ContextIndex,HI_DRV_VICAP_OUTPUT_ATTR_S *pstOutAttr)
{
    HI_S32 s32CropX =0;
    HI_S32 s32CropY =0;
    HI_S32 s32CropW =0;
    HI_S32 s32CropH =0;
    HI_U32 u32DestW =0;
    HI_U32 u32DestH =0;
    HI_U32 u32SrcW =0;
    HI_U32 u32SrcH =0;  
    HI_BOOL bInterlace; 

    VICAP_CHECK_NULL_PTR(pstOutAttr);

    s32CropX = pstOutAttr->stCapRect.s32X;
    s32CropY = pstOutAttr->stCapRect.s32Y;
    s32CropW = pstOutAttr->stCapRect.s32Width;
    s32CropH = pstOutAttr->stCapRect.s32Height;
    u32DestW = pstOutAttr->u32DestWidth;
    u32DestH = pstOutAttr->u32DestHeight;
    u32SrcW = g_stVicapDrvCtx[u32ContextIndex].stVicapAttr.u32Width;
    u32SrcH = g_stVicapDrvCtx[u32ContextIndex].stVicapAttr.u32Height;  
    bInterlace = g_stVicapDrvCtx[u32ContextIndex].stVicapAttr.bInterlace;

    if(g_stVicapDrvCtx[u32ContextIndex].stVicapAttr.stOutAttr.en3DT2DMode !=  pstOutAttr->en3DT2DMode)
    {
        HI_ERR_VICAP("The OutPutAttr of en3DT2DMode can't be change,\
            old en3DT2DMode is %d,new en3DT2DMode is %d\n"\
            ,g_stVicapDrvCtx[u32ContextIndex].stVicapAttr.stOutAttr.en3DT2DMode\
            ,pstOutAttr->en3DT2DMode);
        return HI_FAILURE;
    }
    if(g_stVicapDrvCtx[u32ContextIndex].stVicapAttr.stOutAttr.enVideoFmt != pstOutAttr->enVideoFmt)
    {
        HI_ERR_VICAP("The OutPutAttr of enVideoFmt can't  be change,\
            old enVideoFmt is %d,new enVideoFmt is %d\n"\
                        ,g_stVicapDrvCtx[u32ContextIndex].stVicapAttr.stOutAttr.enVideoFmt\
                        ,pstOutAttr->enVideoFmt);
        return HI_FAILURE;
    }
    if(g_stVicapDrvCtx[u32ContextIndex].stVicapAttr.stOutAttr.enDstBitWidth != pstOutAttr->enDstBitWidth)
    {
        HI_ERR_VICAP("The OutPutAttr of enDstBitWidth can't  be change,\
            old enDstBitWidth is %d,new enDstBitWidth is %d\n"\
                        ,g_stVicapDrvCtx[u32ContextIndex].stVicapAttr.stOutAttr.enDstBitWidth\
                        ,pstOutAttr->enDstBitWidth);
        return HI_FAILURE;
    }

    /* 输出帧率 [24Hz,60] */
    if (0 == pstOutAttr->u32DstFrameRate)
    {
        HI_ERR_VICAP("must set Dst frmrate:%d \n",\
                    pstOutAttr->u32DstFrameRate);
        return HI_FAILURE;
    }
    
    /*输出帧率是否大于输入帧率*/
    if (g_stVicapDrvCtx[u32ContextIndex].stVicapAttr.u32FrameRate < pstOutAttr->u32DstFrameRate)
    {
        HI_ERR_VICAP("dest frmrate:%d should less than source frmrate:%d\n",
            pstOutAttr->u32DstFrameRate, g_stVicapDrvCtx[u32ContextIndex].stVicapAttr.u32FrameRate);
        return HI_FAILURE;
    }
    
    if (pstOutAttr->en3DT2DMode >= HI_DRV_VICAP_3DT2D_BUTT)
    {
        HI_ERR_VICAP("Invalid 3D to 2D format %d of VI \n", pstOutAttr->en3DT2DMode);
        return HI_FAILURE;
    }
    
    if ((s32CropX < 0) || (s32CropY < 0) || (s32CropW < 0) || (s32CropH < 0))
    {
        HI_ERR_VICAP("invalid args crop rect of vi,X:%d,Y:%d,W:%d,H:%d\n",\
                    s32CropX, s32CropY, s32CropW, s32CropH);            
        return HI_FAILURE;      
    }
    
    if ((HI_DRV_PIX_FMT_NV61_2X1 == pstOutAttr->enVideoFmt)
        && (VICAP_IS_ODD_NUM(s32CropX) || VICAP_IS_ODD_NUM(s32CropW)
        || VICAP_IS_ODD_NUM(u32DestW)))
    {
        HI_ERR_VICAP("width must be even value,X:%d,CW:%d,DW:%d\n",\
                    s32CropX, s32CropW, u32DestW);
        return HI_FAILURE;
    } 
    
    if ((HI_TRUE == bInterlace) && (VICAP_IS_ODD_NUM(s32CropY) || VICAP_IS_ODD_NUM(s32CropH)))
    {
        HI_ERR_VICAP("height item of each field must be even value Y:%d,H%d\n",\
                    s32CropY, s32CropH);
        return HI_FAILURE;
    }

    if (s32CropW < VICAP_MIN_WIDTH || s32CropH < VICAP_MIN_HEIGHT 
        || u32DestW < VICAP_MIN_WIDTH || u32DestH < VICAP_MIN_HEIGHT)
    {
        HI_ERR_VICAP("dest rect and crop rect must larger than 128x128,\
                    CW:%d,CH:%d,DW:%d,DH:%d\n", s32CropW, s32CropH, u32DestW,u32DestH);
        return HI_FAILURE;
    }
    
    if ((s32CropW + s32CropX > u32SrcW) || (s32CropH + s32CropY > u32SrcH) || (u32DestW > s32CropW) || (u32DestH > s32CropH))
    {
        HI_ERR_VICAP("dest width must <= crop width,dest height must <= crop height,corp rect must <= src size,\
                    X:%d,Y:%d,W:%d,H:%d,DW:%d,DH:%d\n",s32CropX,s32CropY,s32CropW,s32CropH,u32DestW,u32DestH);
        return HI_FAILURE;
    }

    /*通道水平缩放倍数*/
    if (VICAP_DRV_CheckChnHScale(s32CropW, u32DestW) != HI_SUCCESS)
    {
        HI_ERR_VICAP("DestWidth's scale multiple or max width illegal,\
                    CW:%d, DW:%d\n", s32CropW, u32DestW);
        return HI_FAILURE;
    } 

    /*通道垂直缩放倍数*/
    if (VICAP_DRV_CheckChnVScale(s32CropH, u32DestH) != HI_SUCCESS)
    {
        HI_ERR_VICAP("DestHeight's scale multiple or max Height illegal,\
                    CW:%d, DW:%d\n", s32CropH, u32DestH);
        return HI_FAILURE;
    } 
    

    return HI_SUCCESS;
}

static HI_S32 VICAP_DRV_SetAccess(HI_HANDLE hVicap,HI_DRV_VICAP_ACCESS_TYPE_E enAccess)
{
    U_PERI_CRG55 PERI_CRG55;
    HI_U32 u32PtIndex;
    VICAP_WORKHZ_E eWorkHz = VICAP_WORKHZ_300HZ;
#if    defined(CHIP_TYPE_hi3751v100)   \
    || defined(CHIP_TYPE_hi3798cv100)  \
    || defined(CHIP_TYPE_hi3796cv100)    
    HDMIRX_EXPORT_FUNC_S   *pstHdmirxExFunc = HI_NULL;
#endif
    HI_U32 u32HdmirxCtrlNum = 0;
    /*设置源*/ 
    PERI_CRG55.u32 = g_pstRegCrg->PERI_CRG55.u32;
    u32PtIndex = GETPHYPT(hVicap);
    
    if(HI_DRV_FT_NOT_STEREO != g_stVicapDrvCtx[GETCONTEXTID(hVicap)].stVicapAttr.en3dFmt)
    { 
       switch (enAccess)
        {
            case  HI_DRV_VICAP_ACCESS_TVD: 
                PERI_CRG55.bits.vi_p0_cksel = SYS_VICAP_CLK_TVD;
                PERI_CRG55.bits.vi_p1_cksel = SYS_VICAP_CLK_TVD;
            break;
            case  HI_DRV_VICAP_ACCESS_HDDEC:
                PERI_CRG55.bits.vi_p0_cksel = SYS_VICAP_CLK_HDDEC;
                PERI_CRG55.bits.vi_p1_cksel = SYS_VICAP_CLK_HDDEC;
            break;
            case  HI_DRV_VICAP_ACCESS_HDMI:
#if    defined(CHIP_TYPE_hi3751v100)   \
    || defined(CHIP_TYPE_hi3798cv100)  \
    || defined(CHIP_TYPE_hi3796cv100)    
                VICAP_GET_HDMIRX_FUNC(pstHdmirxExFunc);
                VICAP_CHECK_NULL_PTR(pstHdmirxExFunc);
                u32HdmirxCtrlNum = pstHdmirxExFunc->pfnHDMIRXGetDataRoute();
                if(HI_DRV_HDMIRX_DATA_ROUTE_CTRL0 == u32HdmirxCtrlNum)
                {
                    PERI_CRG55.bits.vi_p0_cksel = SYS_VICAP_CLK_HDMI_CTRL0;
                    PERI_CRG55.bits.vi_p1_cksel = SYS_VICAP_CLK_HDMI_CTRL0;

                }else if (HI_DRV_HDMIRX_DATA_ROUTE_CTRL1 == u32HdmirxCtrlNum)
                {
                    PERI_CRG55.bits.vi_p0_cksel = SYS_VICAP_CLK_HDMI_CTRL1;
                    PERI_CRG55.bits.vi_p1_cksel = SYS_VICAP_CLK_HDMI_CTRL1;
                }
                else
                {
                    HI_ERR_VICAP("Invalid HdmirxCtrlNum %d of VICAP \n", u32HdmirxCtrlNum);
                    return HI_FAILURE;
                }   
#else
                PERI_CRG55.bits.vi_p0_cksel = SYS_VICAP_CLK_HDMI_CTRL0;
                PERI_CRG55.bits.vi_p1_cksel = SYS_VICAP_CLK_HDMI_CTRL0;

#endif
                PERI_CRG55.bits.vi_ppc0_hdmirx_cksel = VICAP_HDMIRX_WORKHZ_PPC;/*暂时这样配置，后期有需要再调整*/
                PERI_CRG55.bits.vi_ppc1_hdmirx_cksel = VICAP_HDMIRX_WORKHZ_PPC;/*暂时这样配置，后期有需要再调整*/
            break;
            default:
                HI_ASSERT(0);
        }
        PERI_CRG55.bits.vi_ppc0_cksel = eWorkHz;  
        PERI_CRG55.bits.vi_ppc1_cksel = eWorkHz;  
    }    
    else
    {        
        if(VICAP_PHYPT_PT0 == u32PtIndex)
        {
            switch (enAccess)
            {
                case  HI_DRV_VICAP_ACCESS_TVD: 
                    PERI_CRG55.bits.vi_p0_cksel = SYS_VICAP_CLK_TVD;
                break;
                case  HI_DRV_VICAP_ACCESS_HDDEC:
                    PERI_CRG55.bits.vi_p0_cksel = SYS_VICAP_CLK_HDDEC;
                break;
                case  HI_DRV_VICAP_ACCESS_HDMI:
#if    defined(CHIP_TYPE_hi3751v100)   \
    || defined(CHIP_TYPE_hi3798cv100)  \
    || defined(CHIP_TYPE_hi3796cv100)    
                    VICAP_GET_HDMIRX_FUNC(pstHdmirxExFunc);
                    VICAP_CHECK_NULL_PTR(pstHdmirxExFunc);
                    u32HdmirxCtrlNum = pstHdmirxExFunc->pfnHDMIRXGetDataRoute();
                    if(HI_DRV_HDMIRX_DATA_ROUTE_CTRL0 == u32HdmirxCtrlNum)
                    {
                        PERI_CRG55.bits.vi_p0_cksel = SYS_VICAP_CLK_HDMI_CTRL0;
                    
                    }else if (HI_DRV_HDMIRX_DATA_ROUTE_CTRL1 == u32HdmirxCtrlNum)
                    {
                        PERI_CRG55.bits.vi_p0_cksel = SYS_VICAP_CLK_HDMI_CTRL1;
                    }
                    else if (HI_DRV_HDMIRX_DATA_ROUTE_CTRL0_CTRL1== u32HdmirxCtrlNum)
                    {
                        PERI_CRG55.bits.vi_p0_cksel = SYS_VICAP_CLK_HDMI_CTRL0;
                        PERI_CRG55.bits.vi_p1_cksel = SYS_VICAP_CLK_HDMI_CTRL1;
                    }
                    else
                    {
                        HI_ERR_VICAP("Invalid HdmirxCtrlNum %d of VICAP \n", u32HdmirxCtrlNum);
                        return HI_FAILURE;
                    }
#else
                    PERI_CRG55.bits.vi_p0_cksel = SYS_VICAP_CLK_HDMI_CTRL0;  
#endif                    
                    PERI_CRG55.bits.vi_ppc0_hdmirx_cksel = VICAP_HDMIRX_WORKHZ_PPC;/*暂时这样配置，后期有需要再调整*/
                break;
                default:
                    HI_ASSERT(0);
            }

            PERI_CRG55.bits.vi_ppc0_cksel = eWorkHz;
            
        }
    
        if(VICAP_PHYPT_PT1 == u32PtIndex)
        {
            switch (enAccess)
            {
                case  HI_DRV_VICAP_ACCESS_TVD: 
                    PERI_CRG55.bits.vi_p1_cksel = SYS_VICAP_CLK_TVD;

                break;
                case  HI_DRV_VICAP_ACCESS_HDDEC:
                    PERI_CRG55.bits.vi_p1_cksel = SYS_VICAP_CLK_HDDEC;
                break;
                case  HI_DRV_VICAP_ACCESS_HDMI:
#if    defined(CHIP_TYPE_hi3751v100)   \
    || defined(CHIP_TYPE_hi3798cv100)  \
    || defined(CHIP_TYPE_hi3796cv100)    
                    VICAP_GET_HDMIRX_FUNC(pstHdmirxExFunc);
                    VICAP_CHECK_NULL_PTR(pstHdmirxExFunc);
                    u32HdmirxCtrlNum = pstHdmirxExFunc->pfnHDMIRXGetDataRoute();
                    if(HI_DRV_HDMIRX_DATA_ROUTE_CTRL0 == u32HdmirxCtrlNum)
                    {
                        PERI_CRG55.bits.vi_p1_cksel = SYS_VICAP_CLK_HDMI_CTRL0;
                    
                    }else if (HI_DRV_HDMIRX_DATA_ROUTE_CTRL1 == u32HdmirxCtrlNum)
                    {
                        PERI_CRG55.bits.vi_p1_cksel = SYS_VICAP_CLK_HDMI_CTRL1;
                    }
                    else if (HI_DRV_HDMIRX_DATA_ROUTE_CTRL0_CTRL1== u32HdmirxCtrlNum)
                    {
                        PERI_CRG55.bits.vi_p0_cksel = SYS_VICAP_CLK_HDMI_CTRL0;
                        PERI_CRG55.bits.vi_p1_cksel = SYS_VICAP_CLK_HDMI_CTRL1;
                    }
                    else
                    {
                        HI_ERR_VICAP("Invalid HdmirxCtrlNum %d of VICAP \n", u32HdmirxCtrlNum);
                        return HI_FAILURE;
                    }
#else                    
                    PERI_CRG55.bits.vi_p1_cksel = SYS_VICAP_CLK_HDMI_CTRL0;
#endif                    
                    PERI_CRG55.bits.vi_ppc1_hdmirx_cksel = VICAP_HDMIRX_WORKHZ_PPC;/*暂时这样配置，后期有需要再调整*/
                break;
                default:
                    HI_ASSERT(0); 
            }
        
            PERI_CRG55.bits.vi_ppc1_cksel = eWorkHz;

        }    
    }  
    g_pstRegCrg->PERI_CRG55.u32 = PERI_CRG55.u32;
    return HI_SUCCESS;
}

static HI_S32 VICAP_DRV_GetBufferAttr(HI_DRV_VICAP_ATTR_S *pstVicapAttr,VICAP_FRAME_STATUS_S *pstFrmStatus,VICAP_BUF_ATTR_S *pstBufAttr)
{
    HI_U32 u32BufSize = 0; 
    HI_U32 u32Width = 0;
    HI_U32 u32Height = 0;
    HI_U32 u32YStride = 0;
    HI_U32 u32CStride = 0;
    VICAP_CHECK_NULL_PTR(pstVicapAttr);
    VICAP_CHECK_NULL_PTR(pstFrmStatus);
    VICAP_CHECK_NULL_PTR(pstBufAttr); 
    
    if(HI_DRV_VICAP_BUF_ALLOC == pstVicapAttr->enBufMgmtMode)
    {
        
        u32Width =  pstVicapAttr->u32Width;
        u32Height = pstVicapAttr->u32Height;

        /*VICAP STRIDE 16Byte对齐*/
        if (HI_DRV_PIXEL_BITWIDTH_8BIT == pstVicapAttr->stOutAttr.enDstBitWidth)
        {
            u32YStride = VICAP_ALIGN_8BIT_YSTRIDE(u32Width);
        }
        else if (HI_DRV_PIXEL_BITWIDTH_10BIT == pstVicapAttr->stOutAttr.enDstBitWidth)
        {
            u32YStride = VICAP_ALIGN_10BIT_COMP_YSTRIDE(u32Width);
        }
        else
        {
            HI_ASSERT(0);
        }

        /*根据输出的VIDEOFmt确认Cstride与BufSize*/
        if ((HI_DRV_PIX_FMT_RGB444 == pstVicapAttr->stOutAttr.enVideoFmt) 
                || (HI_DRV_PIX_FMT_NV42 == pstVicapAttr->stOutAttr.enVideoFmt))
        {
            u32CStride = u32YStride * 2;
            u32BufSize = u32YStride * u32Height * 3;
        }
        else if ( HI_DRV_PIX_FMT_NV61_2X1 == pstVicapAttr->stOutAttr.enVideoFmt)
        {
            u32CStride = u32YStride;
            u32BufSize = u32YStride * u32Height * 2;
        }
        else
        {
            HI_ERR_VICAP("Invalid video format %d of VICAP \n", pstVicapAttr->stOutAttr.enVideoFmt);
            return HI_FAILURE;
        }


        /*3D输入,3D播放*/
        if ((HI_DRV_FT_NOT_STEREO != pstVicapAttr->en3dFmt) &&(HI_DRV_VICAP_3DT2D_OFF == pstVicapAttr->stOutAttr.en3DT2DMode))
        {
            u32BufSize = u32BufSize * 2;
            pstFrmStatus->b3D = HI_TRUE;
        }
        else
        {
            pstFrmStatus->b3D = HI_FALSE;
        }
        
        pstBufAttr->enBufMode = pstVicapAttr->enBufMgmtMode; 
        pstBufAttr->u32BufNum = pstVicapAttr->u32BufNum;
        pstBufAttr->u32BufSize = u32BufSize;

        pstFrmStatus->stSourceTimingInfo.enSource = pstVicapAttr->enSourceType;
        pstFrmStatus->stSourceTimingInfo.u32SrcWidth = pstVicapAttr->u32Width;
        pstFrmStatus->stSourceTimingInfo.u32SrcHeight= pstVicapAttr->u32Height;
        pstFrmStatus->stSourceTimingInfo.u32SrcFrmRate = pstVicapAttr->u32FrameRate;
        pstFrmStatus->stSourceTimingInfo.en3dType = pstVicapAttr->en3dFmt;
        pstFrmStatus->stSourceTimingInfo.enSrcColorSpace = pstVicapAttr->enColorSpace;
        pstFrmStatus->stSourceTimingInfo.enSrcColorSys = pstVicapAttr->enColorSys;
        pstFrmStatus->stSourceTimingInfo.bGraphicMode = pstVicapAttr->bGraphicMode;
        pstFrmStatus->stSourceTimingInfo.bInterlace = pstVicapAttr->bInterlace;

        pstFrmStatus->u32DstWidth = pstVicapAttr->stOutAttr.u32DestWidth;
        pstFrmStatus->u32DstHeight = pstVicapAttr->stOutAttr.u32DestHeight;       
        pstFrmStatus->enDstBitWidth = pstVicapAttr->stOutAttr.enDstBitWidth;
        pstFrmStatus->enVideoFormat = pstVicapAttr->stOutAttr.enVideoFmt;
        pstFrmStatus->u32DstFrameRate = pstVicapAttr->stOutAttr.u32DstFrameRate;
        pstFrmStatus->u32YStride = u32YStride;
        pstFrmStatus->u32CStride = u32CStride;
        pstFrmStatus->u32BufSize = u32BufSize;        
    }
    return HI_SUCCESS;
    
}

static HI_S32 VICAP_DRV_SetPortAttr(HI_HANDLE hVicap,HI_DRV_VICAP_ATTR_S *pstVicapAttr)
{
    VICAP_INTF_MODE_E          enIntfMode = VICAP_INTF_MODE_FVHDE;     /* 接口模式 */
    VICAP_COMP_MODE_E          enCompMode = VICAP_COMP_MODE_THREE;     /* 分量模式 (单分量、双分量、三分量) */
    HI_U32                     au32Offset[3] = {0};  /* 分量偏移 */
	HI_U32                     au32CompMask[3] = {0};/* 分量掩码配置 */
    VICAP_SYNC_CFG_S           stSyncCfg;      /* FVHDE外同步时序配置 */  
    HI_U32                     u32CompMask = 0;
    HI_U32                     u32PtIndex = 0;
    HI_BOOL                    bToYuv444 = HI_FALSE;
   
    VICAP_CHECK_NULL_PTR(pstVicapAttr);
    memset(&stSyncCfg, 0 , sizeof(VICAP_SYNC_CFG_S));
   
    /*时序类型*/
    switch (pstVicapAttr->enIntfMode)
    {
        case HI_DRV_VICAP_INTF_FVHDE:
        enIntfMode = VICAP_INTF_MODE_FVHDE;
        break;
        case HI_DRV_VICAP_INTF_BT601:
        enIntfMode = VICAP_INTF_MODE_BT601;
        break;
        case HI_DRV_VICAP_INTF_BT656:
        enIntfMode = VICAP_INTF_MODE_BT656;
        break;
        case HI_DRV_VICAP_INTF_BT1120:
        enIntfMode = VICAP_INTF_MODE_BT1120;
        break;
        default:
        enIntfMode = VICAP_INTF_MODE_BUTT;
        break;
    }

    /*默认offset参数 */
    au32Offset[0] = 0;
    au32Offset[1] = 12;
    au32Offset[2] = 24;  
    
#if    defined(CHIP_TYPE_hi3751v100b)   \
    || defined(CHIP_TYPE_hi3751v100)
    /*HDDEC的YPBPR管脚定制化*/
    if(HI_DRV_VICAP_ACCESS_HDDEC == g_stVicapDrvCtx[GETCONTEXTID(hVicap)].stVicapAttr.enAccess)
    {
	    HI_U32                     u32DataOrder = 0;
       HDDEC_EXPORT_FUNC_S  *pstHDDECExFunc = HI_NULL;
       VICAP_GET_HDDEC_FUNC(pstHDDECExFunc);
       VICAP_CHECK_NULL_PTR(pstHDDECExFunc);
       u32DataOrder = pstHDDECExFunc->pfnHDDECGetDataOrder();
           
       switch(u32DataOrder)
        {
           case HI_DRV_HDDEC_DATA_ORDER_RGB:
           {
                au32Offset[0] = 0;
                au32Offset[1] = 12;
                au32Offset[2] = 24;
                break;
           }

           case HI_DRV_HDDEC_DATA_ORDER_RBG:
           {
                au32Offset[0] = 12;
                au32Offset[1] = 0;
                au32Offset[2] = 24;
                break;
           }

           case HI_DRV_HDDEC_DATA_ORDER_GBR:
           {
                au32Offset[0] = 24;
                au32Offset[1] = 0;
                au32Offset[2] = 12;
                break;
           } 

           case HI_DRV_HDDEC_DATA_ORDER_GRB:
           {
                au32Offset[0] = 0;
                au32Offset[1] = 24;
                au32Offset[2] = 12;
                break;
           }

           case HI_DRV_HDDEC_DATA_ORDER_BGR:
           {
                au32Offset[0] = 24;
                au32Offset[1] = 12;
                au32Offset[2] = 0;
                break;
           }

           case HI_DRV_HDDEC_DATA_ORDER_BRG:
           {
                au32Offset[0] = 12;
                au32Offset[1] = 24;
                au32Offset[2] = 0;
                break;
           } 

           default:
           {
                HI_ERR_VICAP("Get u32DataOrder = %d error.\n", u32DataOrder);
                break;
           }
        }
    }    
#endif

    /*分量掩码*/
    if (HI_DRV_PIXEL_BITWIDTH_8BIT == pstVicapAttr->enSrcBitWidth)
    {
        u32CompMask = VICAP_CHN_DATA_MASK(8);
    }
    else if(HI_DRV_PIXEL_BITWIDTH_10BIT == pstVicapAttr->enSrcBitWidth)
    {
        u32CompMask = VICAP_CHN_DATA_MASK(10);
    }
    else if(HI_DRV_PIXEL_BITWIDTH_12BIT == pstVicapAttr->enSrcBitWidth)
    {
        u32CompMask = VICAP_CHN_DATA_MASK(12);
    }
    else
    {
        HI_ASSERT(0);
    }    

    /*分量掩码配置*/
    if((HI_DRV_PIX_FMT_RGB444 == pstVicapAttr->enPixFmt) \
        || (HI_DRV_PIX_FMT_NV42 == pstVicapAttr->enPixFmt))
    {
        enCompMode = VICAP_COMP_MODE_THREE;
        au32CompMask[0] = u32CompMask;
        au32CompMask[1] = u32CompMask;
        au32CompMask[2] = u32CompMask;
        bToYuv444 = HI_FALSE;
    }

    if(HI_DRV_PIX_FMT_NV61_2X1 == pstVicapAttr->enPixFmt)
    {
        enCompMode = VICAP_COMP_MODE_DOUBLE;
        au32CompMask[0] = u32CompMask;
        au32CompMask[1] = u32CompMask;
        bToYuv444 = HI_FALSE;
    }    

    /*fvhde外同步时序*/
    stSyncCfg.bFieldInv = HI_FALSE;
    stSyncCfg.enFieldSel = VICAP_FIELD_SEL_FIELD;
    stSyncCfg.enVsyncMode = VICAP_VSYNC_MODE_SINGLE_UP;
    stSyncCfg.bVsyncInv = HI_FALSE;
    stSyncCfg.enVsyncSel = VICAP_VSYNC_SEL_VSYNC;
    stSyncCfg.enHsyncMode = VICAP_HSYNC_MODE_SINGLE_UP;
    stSyncCfg.enHsyncAnd = VICAP_HSYNC_AND_OFF;
    stSyncCfg.bHsyncInv = HI_FALSE;
    stSyncCfg.enHsyncSel = VICAP_HSYNC_SEL_HSYNC;
    stSyncCfg.bDeInv = HI_FALSE;
    stSyncCfg.enDeSel = VICAP_DE_SEL_DE;

    if(g_stVicapDrvCtx[GETCONTEXTID(hVicap)].stFrmStatus.b3D)
    {      
        VICAP_HAL_SetPortUpToYuv444(VICAP_PHYPT_PT0, bToYuv444);
        VICAP_HAL_SetPortIntfMode(VICAP_PHYPT_PT0, enIntfMode);
        VICAP_HAL_SetPortCompMode(VICAP_PHYPT_PT0, enCompMode);
        VICAP_HAL_SetPortDataLayout(VICAP_PHYPT_PT0, au32Offset, au32CompMask);
        VICAP_HAL_SetPortSyncCfg(VICAP_PHYPT_PT0, &stSyncCfg);

        VICAP_HAL_SetPortUpToYuv444(VICAP_PHYPT_PT1, bToYuv444);
        VICAP_HAL_SetPortIntfMode(VICAP_PHYPT_PT1, enIntfMode);
        VICAP_HAL_SetPortCompMode(VICAP_PHYPT_PT1, enCompMode);
        VICAP_HAL_SetPortDataLayout(VICAP_PHYPT_PT1, au32Offset, au32CompMask);
        VICAP_HAL_SetPortSyncCfg(VICAP_PHYPT_PT1, &stSyncCfg);
    }
    else
    {   
        u32PtIndex = GETPHYPT(hVicap);
        
        VICAP_HAL_SetPortUpToYuv444(u32PtIndex, bToYuv444);
        VICAP_HAL_SetPortIntfMode(u32PtIndex, enIntfMode);
        VICAP_HAL_SetPortCompMode(u32PtIndex, enCompMode);
        VICAP_HAL_SetPortDataLayout(u32PtIndex, au32Offset, au32CompMask);
        VICAP_HAL_SetPortSyncCfg(u32PtIndex, &stSyncCfg);
    }
    
    return HI_SUCCESS;
}

static HI_S32 VICAP_DRV_SetChnCsc(HI_HANDLE hVicap,HI_DRV_VICAP_ATTR_S *pstVicapAttr)
{
    HI_U32 u32ChnIndex = 0;
    HI_U32 u32ContextIndex = 0;
    HI_S32 s32Ret = 0;
    HI_BOOL bCsc = HI_FALSE;
    HI_PQ_CSC_COEF_S stPqCSCCoef;
    HI_PQ_CSC_DCCOEF_S stPqCSCDCCoef;
    VICAP_CSC_COEF_S stVicapCSCCoef;
    VICAP_CSC_DCCOEF_S stVicapCSCDCCoef;
    HI_PQ_CSC_MODE_E eCscMode = HI_PQ_CSC_RGB2YUV_601;    

    u32ContextIndex = GETCONTEXTID(hVicap);
    
    if((HI_DRV_PIX_FMT_RGB444   == pstVicapAttr->enPixFmt) && 
        ((HI_DRV_PIX_FMT_NV42   == pstVicapAttr->stOutAttr.enVideoFmt) ||
        (HI_DRV_PIX_FMT_NV61_2X1== pstVicapAttr->stOutAttr.enVideoFmt)))
    {
        if(HI_DRV_CS_BT709_RGB_FULL == pstVicapAttr->enColorSpace)
        {
            eCscMode = HI_PQ_CSC_RGB2YUV_709_FULL;
        }

        if(HI_DRV_CS_BT709_RGB_LIMITED == pstVicapAttr->enColorSpace)
        {
            eCscMode = HI_PQ_CSC_RGB2YUV_709;
        }
        
        g_stVicapDrvCtx[u32ContextIndex].stFrmStatus.eCscColorSpace = HI_DRV_CS_BT709_YUV_LIMITED;
       
        memset(&stPqCSCCoef, 0, sizeof(VICAP_CSC_COEF_S));
        s32Ret = DRV_PQ_GetCSCCoef(eCscMode, &stPqCSCCoef, &stPqCSCDCCoef);
        if(s32Ret != HI_SUCCESS)
        {
          HI_ERR_VICAP("Get Csc Coef Faild!\n");
          return HI_FAILURE;
        }
        bCsc = HI_TRUE;
        memcpy(&stVicapCSCCoef, &stPqCSCCoef, sizeof(VICAP_CSC_COEF_S));
        /* VICAP与VDP的设计差异，PQ依据VDP提供参数，故需对调DC0与DC2 */
        stVicapCSCDCCoef.csc_in_dc0 = stPqCSCDCCoef.csc_in_dc2;
        stVicapCSCDCCoef.csc_in_dc1 = stPqCSCDCCoef.csc_in_dc1;
        stVicapCSCDCCoef.csc_in_dc2 = stPqCSCDCCoef.csc_in_dc0;
        stVicapCSCDCCoef.csc_out_dc0 = stPqCSCDCCoef.csc_out_dc2;
        stVicapCSCDCCoef.csc_out_dc1 = stPqCSCDCCoef.csc_out_dc1;
        stVicapCSCDCCoef.csc_out_dc2 = stPqCSCDCCoef.csc_out_dc0;
    }
    else
    {        
        g_stVicapDrvCtx[u32ContextIndex].stFrmStatus.eCscColorSpace = pstVicapAttr->enColorSpace;
        bCsc = HI_FALSE;
    }
    
    g_stVicapDrvCtx[u32ContextIndex].stFrmStatus.bCsc = bCsc;
        
    if(g_stVicapDrvCtx[GETCONTEXTID(hVicap)].stFrmStatus.b3D)
    {      
        VICAP_HAL_SetChnCscEn(VICAP_CHNINDEX0,bCsc);
        VICAP_HAL_SetChnCscEn(VICAP_CHNINDEX1,bCsc);
        if(HI_TRUE == bCsc)
        {
            VICAP_HAL_SetChnCsc(VICAP_CHNINDEX0,&stVicapCSCCoef,&stVicapCSCDCCoef);
            VICAP_HAL_SetChnCsc(VICAP_CHNINDEX1,&stVicapCSCCoef,&stVicapCSCDCCoef);
            
        }
    }
    else
    {   
        u32ChnIndex = VICAP_DRV_GetChnIndex(hVicap);
        VICAP_HAL_SetChnCscEn(u32ChnIndex,bCsc);
        if(HI_TRUE == bCsc)
        {
            VICAP_HAL_SetChnCsc(u32ChnIndex,&stVicapCSCCoef,&stVicapCSCDCCoef);
        }
    }
    
    return HI_SUCCESS;
}
static HI_S32 VICAP_DRV_SetChnStaticAttr(HI_HANDLE hVicap,HI_DRV_VICAP_ATTR_S *pstVicapAttr,VICAP_FRAME_STATUS_S *pstFrmStatus)
{
    HI_U32 u32SkipYCfg, u32SkipCCfg, u32YStride, u32CStride; 
    HI_U32 u32ChnIndex;
    VICAP_DITHER_CFG_E enDitherCfg = VICAP_DITHER_10BIT;

    VICAP_CHECK_NULL_PTR(pstVicapAttr);
    VICAP_CHECK_NULL_PTR(pstFrmStatus);

    VICAP_DRV_SetChnCsc(hVicap,pstVicapAttr);
    
    /* skip属性参数 */
    if (HI_DRV_OVERSAMPLE_2X == pstVicapAttr->enOverSample)
    {
        u32SkipYCfg = VICAP_SKIP_SAMPLE_2X;
    }
    else if (HI_DRV_OVERSAMPLE_4X == pstVicapAttr->enOverSample)
    {
        u32SkipYCfg = VICAP_SKIP_SAMPLE_4X;
    }
    else
    {
        u32SkipYCfg = VICAP_SKIP_SAMPLE_OFF;
    } 

    /*默认色度与亮度的skip相同*/
    u32SkipCCfg = u32SkipYCfg;
    /*源为422时，色度skip为亮度skip的两倍*/
    if(HI_DRV_PIX_FMT_NV61_2X1 == pstVicapAttr->enPixFmt)
    {
        if (HI_DRV_OVERSAMPLE_2X == pstVicapAttr->enOverSample)
        {
            u32SkipCCfg = VICAP_SKIP_SAMPLE_4X;
        }
        else if (HI_DRV_OVERSAMPLE_4X == pstVicapAttr->enOverSample)
        {
            u32SkipCCfg = VICAP_SKIP_SAMPLE_8X;
        }
        else
        {
            u32SkipCCfg = VICAP_SKIP_SAMPLE_2X;
        } 
    }
    
    /*dither*/
    /*视频输出位宽为10bit*/
    if (HI_DRV_PIXEL_BITWIDTH_10BIT == pstVicapAttr->stOutAttr.enDstBitWidth)
    {
        enDitherCfg = VICAP_DITHER_10BIT;
    }
    /*视频输出位宽为8bit*/
    if (HI_DRV_PIXEL_BITWIDTH_8BIT == pstVicapAttr->stOutAttr.enDstBitWidth)
    {
        enDitherCfg = VICAP_DITHER_8BIT;
    }
    
    /* Stride跨度的配置，隔行时芯片会乘2 */
    u32YStride = pstFrmStatus->u32YStride;
    u32CStride = pstFrmStatus->u32CStride;

    /* 亮度Skip和色度Skip，32bit组成4X8的矩阵确定保留的行和列，
    *整个图像依照4X8的规律保留行和列。应用于过采样场景 */
    if(g_stVicapDrvCtx[GETCONTEXTID(hVicap)].stFrmStatus.b3D)
    {
        /*通道0*/
        VICAP_HAL_SetSkipYCfg(VICAP_CHNINDEX0, u32SkipYCfg);
        VICAP_HAL_SetSkipCCfg(VICAP_CHNINDEX0, u32SkipCCfg);
        VICAP_HAL_SetWchYStride(VICAP_CHNINDEX0, u32YStride);
        VICAP_HAL_SetWchCStride(VICAP_CHNINDEX0, u32CStride);
        VICAP_HAL_SetDitherCfg(VICAP_CHNINDEX0, enDitherCfg);
        /*通道1*/
        VICAP_HAL_SetSkipYCfg(VICAP_CHNINDEX1, u32SkipYCfg);
        VICAP_HAL_SetSkipCCfg(VICAP_CHNINDEX1, u32SkipCCfg);
        VICAP_HAL_SetWchYStride(VICAP_CHNINDEX1, u32YStride);
        VICAP_HAL_SetWchCStride(VICAP_CHNINDEX1, u32CStride);
        VICAP_HAL_SetDitherCfg(VICAP_CHNINDEX1, enDitherCfg);

    }
    else
    {   
        u32ChnIndex = VICAP_DRV_GetChnIndex(hVicap);
        VICAP_HAL_SetSkipYCfg(u32ChnIndex, u32SkipYCfg);
        VICAP_HAL_SetSkipCCfg(u32ChnIndex, u32SkipCCfg);
        VICAP_HAL_SetWchYStride(u32ChnIndex, u32YStride);
        VICAP_HAL_SetWchCStride(u32ChnIndex, u32CStride);
        VICAP_HAL_SetDitherCfg(u32ChnIndex, enDitherCfg);
    }  
    return HI_SUCCESS;
}

static HI_VOID VICAP_DRV_EnablePort(HI_HANDLE hVicap)
{
    HI_U32 u32PtIndex;

    u32PtIndex = GETPHYPT(hVicap);    

    if(g_stVicapDrvCtx[GETCONTEXTID(hVicap)].stFrmStatus.b3D)
    { 
        /*端口工作时钟*/
        VICAP_HAL_SetPtClk(VICAP_PHYPT_PT0);
        VICAP_HAL_SetVicapIntPtMask(VICAP_PHYPT_PT0,HI_FALSE);
        /*端口中断mask*/
        VICAP_HAL_SetPortIntMask(VICAP_PHYPT_PT0, 0);    
        /*使能端口*/
        VICAP_HAL_SetPortEn(VICAP_PHYPT_PT0, HI_TRUE);   

        /*端口工作时钟*/
        VICAP_HAL_SetPtClk(VICAP_PHYPT_PT1);
        VICAP_HAL_SetVicapIntPtMask(VICAP_PHYPT_PT1,HI_FALSE);
        /*端口中断mask*/
        VICAP_HAL_SetPortIntMask(VICAP_PHYPT_PT1, 0);    
        /*使能端口*/
        VICAP_HAL_SetPortEn(VICAP_PHYPT_PT1, HI_TRUE);   
    }
    else
    {          
        u32PtIndex = GETPHYPT(hVicap);       
        /*端口工作时钟*/
        VICAP_HAL_SetPtClk(u32PtIndex);
        VICAP_HAL_SetVicapIntPtMask(u32PtIndex,HI_FALSE);
        /*端口中断mask*/
        VICAP_HAL_SetPortIntMask(u32PtIndex, 0);    
        /*使能端口*/
        VICAP_HAL_SetPortEn(u32PtIndex, HI_TRUE);
    }    
}
static HI_VOID VICAP_DRV_EnableChn(HI_HANDLE hVicap)
{
    HI_U32 u32ChnIndex;
    
    if(g_stVicapDrvCtx[GETCONTEXTID(hVicap)].stFrmStatus.b3D)
    {        
        VICAP_HAL_SetChnClk(VICAP_PHYPT_PT0,VICAP_CHNINDEX0);/*设置通道时钟*/        
        VICAP_HAL_ClrChnIntStatus(VICAP_CHNINDEX0, 0xffffffff);/*清除中断*/        
        VICAP_HAL_SetVicapIntChnMask(VICAP_CHNINDEX0,HI_TRUE);/*VICAP全局中断mask*/        
        VICAP_HAL_SetChnIntMask(VICAP_CHNINDEX0, VICAP_CHN_INT_MASK0);/*通道中断mask*/        
        VICAP_HAL_SetChnEn(VICAP_CHNINDEX0, HI_TRUE); /*使能通道*/

        VICAP_HAL_SetChnClk(VICAP_PHYPT_PT1,VICAP_CHNINDEX1);
        VICAP_HAL_ClrChnIntStatus(VICAP_CHNINDEX1, 0xffffffff);
        VICAP_HAL_SetVicapIntChnMask(VICAP_CHNINDEX1,HI_TRUE);
        VICAP_HAL_SetChnIntMask(VICAP_CHNINDEX1, VICAP_CHN_INT_MASK0);
        VICAP_HAL_SetChnEn(VICAP_CHNINDEX1, HI_TRUE);        
    }
    else
    {          
        u32ChnIndex = VICAP_DRV_GetChnIndex(hVicap);
        VICAP_HAL_SetChnClk(GETPHYPT(hVicap),u32ChnIndex);
        VICAP_HAL_ClrChnIntStatus(u32ChnIndex, 0xffffffff);
        VICAP_HAL_SetVicapIntChnMask(u32ChnIndex,HI_TRUE);
        VICAP_HAL_SetChnIntMask(u32ChnIndex, VICAP_CHN_INT_MASK0);
        VICAP_HAL_SetChnEn(u32ChnIndex, HI_TRUE);
    }    
}

static HI_S32 VICAP_DRV_DisablePort(HI_HANDLE hVicap)
{
    HI_U32 u32PtIndex;
    
    u32PtIndex = GETPHYPT(hVicap); 
    
    if(g_stVicapDrvCtx[GETCONTEXTID(hVicap)].stFrmStatus.b3D)
    {
        VICAP_HAL_SetPortEn(VICAP_PHYPT_PT0,HI_FALSE); /*禁用端口*/        
        VICAP_HAL_SetPortIntMask(VICAP_PHYPT_PT0, 0);/*端口中断mask*/
        VICAP_HAL_SetVicapIntPtMask(VICAP_PHYPT_PT0,HI_FALSE);

        VICAP_HAL_SetPortEn(VICAP_PHYPT_PT1,HI_FALSE); /*禁用端口*/        
        VICAP_HAL_SetPortIntMask(VICAP_PHYPT_PT1, 0);/*端口中断mask*/
        VICAP_HAL_SetVicapIntPtMask(VICAP_PHYPT_PT1,HI_FALSE);
    }
    else
    {       
        VICAP_HAL_SetPortEn(u32PtIndex,HI_FALSE); /*禁用端口*/        
        VICAP_HAL_SetPortIntMask(u32PtIndex, 0);/*端口中断mask*/
        VICAP_HAL_SetVicapIntPtMask(u32PtIndex,HI_FALSE);
    }
    
    return HI_SUCCESS;
}

static HI_S32 VICAP_DRV_DisableChn(HI_HANDLE hVicap)
{
        
    if(g_stVicapDrvCtx[GETCONTEXTID(hVicap)].stFrmStatus.b3D)
    {
        VICAP_HAL_SetChnEn(VICAP_CHNINDEX0, HI_FALSE);
        VICAP_HAL_SetChnEn(VICAP_CHNINDEX1, HI_FALSE);
    }
    else
    {   
        VICAP_HAL_SetChnEn(VICAP_DRV_GetChnIndex(hVicap), HI_FALSE);
    }  

    return HI_SUCCESS;
}

static HI_S32 VICAP_DRV_DisableChnMask(HI_HANDLE hVicap)
{
    
    if(g_stVicapDrvCtx[GETCONTEXTID(hVicap)].stFrmStatus.b3D)
    {
        /*VICAP中断mask*/
        VICAP_HAL_SetVicapIntChnMask(VICAP_CHNINDEX0,HI_FALSE);
        VICAP_HAL_SetVicapIntChnMask(VICAP_CHNINDEX1,HI_FALSE);
        /*通道中断mask*/
        VICAP_HAL_SetChnIntMask(VICAP_CHNINDEX0, HI_FALSE);
        VICAP_HAL_SetChnIntMask(VICAP_CHNINDEX1, HI_FALSE);

    }
    else
    {        
        VICAP_HAL_SetChnIntMask(VICAP_DRV_GetChnIndex(hVicap), HI_FALSE);
        VICAP_HAL_SetVicapIntChnMask(GETPHYCHN(hVicap) >> 1,HI_FALSE);
    }  
 
    return HI_SUCCESS;
}


/*获取中断场类型*/
static VICAP_FRAME_FILED_E  VICAP_DRV_GetIntType(HI_U32 u32PtIndex,HI_BOOL bInterlace, HI_DRV_FRAME_TYPE_E en3dFmt)
{
    VICAP_FRAME_FILED_E enFiledType;
    /*隔行信号 且 3D格式不为FP*/
    if ((HI_TRUE == bInterlace) && (en3dFmt != HI_DRV_FT_FPK))
    {
        enFiledType = VICAP_HAL_IsTopField(u32PtIndex);  
    } 
    /* 3D framepacking的一个垂直同步中断含有左右两场图像 */
    else
    {
        enFiledType = VICAP_FRAME_FILED_FRAME;
    }
    
    return enFiledType;
}
static HI_S32 VICAP_DRV_SendPic(HI_HANDLE hVicap,VICAP_BUF_BLK_S *pstThisFrm)
{
    VICAP_BUF_S  stBuf;
    HI_U32 u32ContextIndex;
    HI_S32 s32Ret;
    VICAP_CHN_DBG_INFO_S  *pstChnDbg = NULL;
    struct timeval time1;
    struct timeval time2;

    u32ContextIndex = GETCONTEXTID(hVicap);
    memset(&stBuf, 0,sizeof(VICAP_BUF_S));
    pstChnDbg = &g_stVicapDrvCtx[u32ContextIndex].stChnDbg;
   
    /*采集完毕发送帧数据*/
    memcpy(&stBuf.stVideoFrmInfo, &pstThisFrm->stVicapFrameInfo, sizeof(HI_DRV_VIDEO_FRAME_S));

   /* proc and send this frame */        
    do_gettimeofday(&time1);
    pstChnDbg->u32SendvTime = VICAP_TIME_DIFF_US(time1, pstChnDbg->stLastSendTime);
    memcpy(&pstChnDbg->stLastSendTime, &time1, sizeof(time1));
    
    HI_DRV_SYS_GetTimeStampMs(&stBuf.stVideoFrmInfo.u32SrcPts);
    stBuf.stVideoFrmInfo.u32Pts = stBuf.stVideoFrmInfo.u32SrcPts;
    s32Ret = VICAP_DRV_BufPut(g_stVicapDrvCtx[u32ContextIndex].hBufHandle, &stBuf);
    
    do_gettimeofday(&time2);
    pstChnDbg->u32SendFrmTime = VICAP_TIME_DIFF_US(time2, time1);
    if(HI_SUCCESS != s32Ret)
    {
        HI_ERR_VICAP("Vicap PutBuf Failed!\n");
        s32Ret = VICAP_DRV_BufSub(g_stVicapDrvCtx[u32ContextIndex].hBufHandle,stBuf.stVideoFrmInfo.stBufAddr[VICAP_EYE_LEFT].u32PhyAddr_Y);     
        HI_ASSERT(HI_SUCCESS == s32Ret); 
        pstThisFrm->bValid = HI_FALSE;
    }
#if    defined(CHIP_TYPE_hi3751v100)   \
    || defined(CHIP_TYPE_hi3751v100b)      
    if (g_stVicapDrvCtx[u32ContextIndex].pfUserCallBack != HI_NULL)
    {
       g_stVicapDrvCtx[u32ContextIndex].pfUserCallBack(g_stVicapDrvCtx[u32ContextIndex].hDst,VICAP_EVENT_NEW_FRAME, HI_NULL);
    }
    else
    {
        HI_ERR_VICAP("Can't report VICAP_EVENT_NEW_FRAME,pfUserCallBack is NULL\n");
    }
#endif
    /* 判断用户获取帧数据的句柄,用户获取VICAP采集图像帧 */
    if((HI_TRUE == pstThisFrm->bValid) && (g_stVicapDrvCtx[u32ContextIndex].pUfHandle))
    {
        s32Ret = HI_DRV_UF_SendFrm(g_stVicapDrvCtx[u32ContextIndex].pUfHandle, &pstThisFrm->stVicapFrameInfo);
        if(HI_SUCCESS != s32Ret)
        {
            HI_INFO_VICAP("Vicap UF SendFrm Failed!\n");            
        }
    }
    pstChnDbg->u32SendCnt++;

    return HI_SUCCESS;
}

static HI_VOID VICAP_DRV_ProcSendFrm(HI_HANDLE hVicap)
{
    HI_S32 s32Ret = 0;
    HI_U32 u32ContextIndex;
    VICAP_BUF_BLK_S *pThisFrm = NULL; 
    VICAP_CHN_DBG_INFO_S  *pstDbgInf  = NULL;

    u32ContextIndex = GETCONTEXTID(hVicap);
    pThisFrm = &g_stVicapDrvCtx[u32ContextIndex].stThisFrm;
    pstDbgInf  = &g_stVicapDrvCtx[u32ContextIndex].stChnDbg;

    if (pThisFrm->bValid)  
    {
       /* 如果上一帧顶场丢失，
          * 两场都采: 则上帧只有底场的数据，不应发送，直接释放
           *只采底场: 则上一帧的Buf中没有图像(分配了buf但实际没有采)，不应发送空图像，直接释放
           */
        if (HI_TRUE == g_stVicapDrvCtx[u32ContextIndex].bTopFrmLost)
        {
            s32Ret = VICAP_DRV_PutFrmBuf(hVicap,pThisFrm);
            HI_ASSERT(HI_SUCCESS == s32Ret);
            g_stVicapDrvCtx[u32ContextIndex].bTopFrmLost = HI_FALSE;  
            pstDbgInf->u32BufCnt --;
            pstDbgInf->u32LostInt ++;
            return;
        }   
        
        pstDbgInf->u32Sequence ++;
        pThisFrm->stVicapFrameInfo.u32FrameIndex = pstDbgInf->u32Sequence;
        
        VICAP_DRV_SendPic(hVicap, pThisFrm);
        pThisFrm->bValid = HI_FALSE;        

    }
    else
    {        
        if (pstDbgInf->bStartCnt)
        {
            pstDbgInf->u32LostInt ++;
            pstDbgInf->u32BotLost ++;
            HI_INFO_VICAP("vicap phychn lost field int!\n");
        }
        
    }
}
static HI_BOOL VICAP_DRV_FrmRateCtrl(VICAP_FRM_RATE_CTRL_S *pstFrmRateInfo)
{
    HI_U32 u32DstFrmRate;
    HI_U32 u32SrcFrmRate;
    HI_S32 *ps32LostFrmKey;
    
    u32SrcFrmRate = pstFrmRateInfo->u32SrcFrmRate;/* 输入源的帧率(PAL:25,NTSC:30,DC: )*/
    u32DstFrmRate = pstFrmRateInfo->u32DstFrmRate;
    ps32LostFrmKey = &pstFrmRateInfo->s32LostFrmKey;/* 丢帧策略关键值*/
    
    /* 如果是满帧通道则每一帧都捕获*/
    if (u32SrcFrmRate == u32DstFrmRate)
    {
        return HI_TRUE;
    }
    
    /* 丢帧算法*/
    *ps32LostFrmKey += u32DstFrmRate;
    if (*ps32LostFrmKey >= u32SrcFrmRate)/* 按照算法，本帧应该捕获*/
    {
        *ps32LostFrmKey -= u32SrcFrmRate;
        return HI_TRUE;
    }

    return HI_FALSE;

}

static HI_S32 VICAP_DRV_SetChnCrop(HI_HANDLE hVicap,HI_DRV_VICAP_ATTR_S *pstVicapAttr, HI_DRV_VICAP_OUTPUT_ATTR_S *pstOutAttr)
{
    
    HI_U32 u32SrcWidth = 0;/*源图像宽度*/
    HI_U32 u32SrcHeight = 0;/*源图像高度*/
    HI_U32 u32Vblank = 0;/*3DFP,场消隐区宽度*/
    HI_U32 u32ChnIndex = 0;
    HI_U32 i = 0;
    
    /*3D播放模式*/
    HI_DRV_VICAP_3DT2D_MODE_E en3DT2DMode;
    /*矩形区域描述*/
    HI_RECT_S stCapRect;    
    /*通道裁剪配置*/
    VICAP_CROP_CFG_S astChnCropCfg[MAXCHN];

    memset(&stCapRect, 0 ,sizeof(HI_RECT_S));
    for(i = 0; i < MAXCHN; i++)
    {
        memset(&astChnCropCfg[i], 0 , sizeof(VICAP_CROP_CFG_S));
    }    
    
    u32SrcWidth = pstVicapAttr->u32Width;/* 源图像一帧的宽度,3D格式为单眼宽度 */    
    u32SrcHeight = pstVicapAttr->u32Height;/* 源图像一帧的高度，即隔行信号是两场的高度，逐行信号是一帧的高度，3D格式为单眼宽高 */    
    u32Vblank = pstVicapAttr->u32Vblank;/* 场消隐区宽度，用于处理3D格式FP */ 
    en3DT2DMode = pstVicapAttr->stOutAttr.en3DT2DMode;
    memcpy(&stCapRect, &pstOutAttr->stCapRect ,sizeof(stCapRect));

    /*检测过采样模式*/
    if (HI_DRV_OVERSAMPLE_4X == pstVicapAttr->enOverSample)
    {
        stCapRect.s32X *= 4;
        stCapRect.s32Width *= 4;
        u32SrcWidth *= 4;
    }
    
    if (HI_DRV_OVERSAMPLE_2X == pstVicapAttr->enOverSample)
    {

        stCapRect.s32X *= 2;
        stCapRect.s32Width *= 2;
        u32SrcWidth *= 2;
    }  

    /*隔行信号*/
    if (pstVicapAttr->bInterlace)
    {
        stCapRect.s32Y /= 2;
        stCapRect.s32Height /= 2;
        u32SrcHeight /= 2;
    }

    /*2D裁剪*/
    if((HI_DRV_FT_NOT_STEREO == pstVicapAttr->en3dFmt))
    {
        u32ChnIndex = VICAP_DRV_GetChnIndex(hVicap);

        /* 2D裁剪区域 */        
        astChnCropCfg[u32ChnIndex].stCropRect[VICAP_CROP0].s32X = stCapRect.s32X;
        astChnCropCfg[u32ChnIndex].stCropRect[VICAP_CROP0].s32Y = stCapRect.s32Y;
        astChnCropCfg[u32ChnIndex].stCropRect[VICAP_CROP0].s32Width = stCapRect.s32Width;
        astChnCropCfg[u32ChnIndex].stCropRect[VICAP_CROP0].s32Height = stCapRect.s32Height;
        astChnCropCfg[u32ChnIndex].bCropEn[VICAP_CROP0] = HI_TRUE;
        astChnCropCfg[u32ChnIndex].bCropEn[VICAP_CROP1] = HI_FALSE;
        /*设置通道裁剪区域*/
        VICAP_HAL_SetChnCrop(u32ChnIndex, &astChnCropCfg[u32ChnIndex]);

       
    }
    /*3D裁剪*/
    else
    {
        if(HI_DRV_FT_SBS == pstVicapAttr->en3dFmt)
        {
            /* 3D左眼裁剪区域 */
            astChnCropCfg[VICAP_CHNINDEX0].stCropRect[VICAP_CROP0].s32X = stCapRect.s32X;
            astChnCropCfg[VICAP_CHNINDEX0].stCropRect[VICAP_CROP0].s32Y = stCapRect.s32Y;
            astChnCropCfg[VICAP_CHNINDEX0].stCropRect[VICAP_CROP0].s32Width = stCapRect.s32Width;
            astChnCropCfg[VICAP_CHNINDEX0].stCropRect[VICAP_CROP0].s32Height = stCapRect.s32Height;
            astChnCropCfg[VICAP_CHNINDEX0].bCropEn[VICAP_CROP0] = HI_TRUE;
            astChnCropCfg[VICAP_CHNINDEX0].bCropEn[VICAP_CROP1] = HI_FALSE;
            
            if (HI_DRV_VICAP_3DT2D_OFF == en3DT2DMode)
            {
                /* 3D右眼裁剪区域 */
                astChnCropCfg[VICAP_CHNINDEX1].stCropRect[VICAP_CROP0].s32X = stCapRect.s32X + u32SrcWidth;
                astChnCropCfg[VICAP_CHNINDEX1].stCropRect[VICAP_CROP0].s32Y = stCapRect.s32Y;
                astChnCropCfg[VICAP_CHNINDEX1].stCropRect[VICAP_CROP0].s32Width = stCapRect.s32Width;
                astChnCropCfg[VICAP_CHNINDEX1].stCropRect[VICAP_CROP0].s32Height = stCapRect.s32Height; 
                astChnCropCfg[VICAP_CHNINDEX1].bCropEn[VICAP_CROP0] = HI_TRUE;
                astChnCropCfg[VICAP_CHNINDEX1].bCropEn[VICAP_CROP1] = HI_FALSE;

            }
            else if (HI_DRV_VICAP_3DT2D_R == en3DT2DMode)
            {
                astChnCropCfg[VICAP_CHNINDEX0].stCropRect[VICAP_CROP0].s32X = stCapRect.s32X + u32SrcWidth; 
            }          

        }

        if(HI_DRV_FT_TAB == pstVicapAttr->en3dFmt)
        {
            /* 3D左眼裁剪区域 */
            astChnCropCfg[VICAP_CHNINDEX0].stCropRect[VICAP_CROP0].s32X = stCapRect.s32X;
            astChnCropCfg[VICAP_CHNINDEX0].stCropRect[VICAP_CROP0].s32Y = stCapRect.s32Y;
            astChnCropCfg[VICAP_CHNINDEX0].stCropRect[VICAP_CROP0].s32Width = stCapRect.s32Width;
            astChnCropCfg[VICAP_CHNINDEX0].stCropRect[VICAP_CROP0].s32Height = stCapRect.s32Height;
            astChnCropCfg[VICAP_CHNINDEX0].bCropEn[VICAP_CROP0] = HI_TRUE;
            astChnCropCfg[VICAP_CHNINDEX0].bCropEn[VICAP_CROP1] = HI_FALSE;

            if (HI_DRV_VICAP_3DT2D_OFF == en3DT2DMode)
            {
                /* 3D右眼裁剪区域 */
                astChnCropCfg[VICAP_CHNINDEX1].stCropRect[VICAP_CROP0].s32X = stCapRect.s32X;
                astChnCropCfg[VICAP_CHNINDEX1].stCropRect[VICAP_CROP0].s32Y = stCapRect.s32Y + u32SrcHeight;
                astChnCropCfg[VICAP_CHNINDEX1].stCropRect[VICAP_CROP0].s32Width = stCapRect.s32Width;
                astChnCropCfg[VICAP_CHNINDEX1].stCropRect[VICAP_CROP0].s32Height = stCapRect.s32Height;            
                astChnCropCfg[VICAP_CHNINDEX1].bCropEn[VICAP_CROP0] = HI_TRUE; 
                astChnCropCfg[VICAP_CHNINDEX1].bCropEn[VICAP_CROP1] = HI_FALSE;
            }
            else if (HI_DRV_VICAP_3DT2D_R == en3DT2DMode)
            {
                astChnCropCfg[VICAP_CHNINDEX0].stCropRect[VICAP_CROP0].s32Y = stCapRect.s32Y + u32SrcHeight;
            }

        }
    
        if(HI_DRV_FT_FPK == pstVicapAttr->en3dFmt)
        {
            if (pstVicapAttr->bInterlace)
            {                
                /* 3D左眼奇场裁剪区域 */
                astChnCropCfg[VICAP_CHNINDEX0].stCropRect[VICAP_CROP0].s32X = stCapRect.s32X;
                astChnCropCfg[VICAP_CHNINDEX0].stCropRect[VICAP_CROP0].s32Y = stCapRect.s32Y;
                astChnCropCfg[VICAP_CHNINDEX0].stCropRect[VICAP_CROP0].s32Width = stCapRect.s32Width;
                astChnCropCfg[VICAP_CHNINDEX0].stCropRect[VICAP_CROP0].s32Height = stCapRect.s32Height;
                astChnCropCfg[VICAP_CHNINDEX0].bCropEn[VICAP_CROP0] = HI_TRUE;

                /* 3D左眼偶场裁剪区域 */
                astChnCropCfg[VICAP_CHNINDEX1].stCropRect[VICAP_CROP0].s32X = stCapRect.s32X;
                astChnCropCfg[VICAP_CHNINDEX1].stCropRect[VICAP_CROP0].s32Y = stCapRect.s32Y + (u32SrcHeight + u32Vblank) * 2 + 1;
                astChnCropCfg[VICAP_CHNINDEX1].stCropRect[VICAP_CROP0].s32Width = stCapRect.s32Width;
                astChnCropCfg[VICAP_CHNINDEX1].stCropRect[VICAP_CROP0].s32Height = stCapRect.s32Height;
                astChnCropCfg[VICAP_CHNINDEX1].bCropEn[VICAP_CROP0] = HI_TRUE;

                if (HI_DRV_VICAP_3DT2D_OFF == en3DT2DMode)
                {
                    /* 3D右眼奇场裁剪区域 */
                    astChnCropCfg[VICAP_CHNINDEX0].stCropRect[VICAP_CROP1].s32X = stCapRect.s32X;
                    astChnCropCfg[VICAP_CHNINDEX0].stCropRect[VICAP_CROP1].s32Y = stCapRect.s32Y + u32SrcHeight + u32Vblank + 1;
                    astChnCropCfg[VICAP_CHNINDEX0].stCropRect[VICAP_CROP1].s32Width = stCapRect.s32Width;
                    astChnCropCfg[VICAP_CHNINDEX0].stCropRect[VICAP_CROP1].s32Height = stCapRect.s32Height;
                    astChnCropCfg[VICAP_CHNINDEX0].bCropEn[VICAP_CROP1] = HI_TRUE;
                  
                    /* 3D右眼偶场裁剪区域 */
                    astChnCropCfg[VICAP_CHNINDEX1].stCropRect[VICAP_CROP1].s32X = stCapRect.s32X;
                    astChnCropCfg[VICAP_CHNINDEX1].stCropRect[VICAP_CROP1].s32Y = stCapRect.s32Y + (u32SrcHeight + u32Vblank) * 3 + 2;
                    astChnCropCfg[VICAP_CHNINDEX1].stCropRect[VICAP_CROP1].s32Width = stCapRect.s32Width;
                    astChnCropCfg[VICAP_CHNINDEX1].stCropRect[VICAP_CROP1].s32Height = stCapRect.s32Height;             
                    astChnCropCfg[VICAP_CHNINDEX1].bCropEn[VICAP_CROP1] = HI_TRUE;

                }
                else if (HI_DRV_VICAP_3DT2D_R == en3DT2DMode)
                {
                    /* 3D->2D-R奇场裁剪区域 */
                    astChnCropCfg[VICAP_CHNINDEX0].stCropRect[VICAP_CROP0].s32Y = stCapRect.s32Y + u32SrcHeight + u32Vblank + 1;
                    /* 3D->2D-R偶场裁剪区域 */
                    astChnCropCfg[VICAP_CHNINDEX0].stCropRect[VICAP_CROP1].s32Y = stCapRect.s32Y + (u32SrcHeight + u32Vblank) * 3 + 2;
                }  
                
            }
            else
            {
                /* 3D左眼裁剪区域 */
                astChnCropCfg[VICAP_CHNINDEX0].stCropRect[VICAP_CROP0].s32X = stCapRect.s32X;
                astChnCropCfg[VICAP_CHNINDEX0].stCropRect[VICAP_CROP0].s32Y = stCapRect.s32Y;
                astChnCropCfg[VICAP_CHNINDEX0].stCropRect[VICAP_CROP0].s32Width = stCapRect.s32Width;
                astChnCropCfg[VICAP_CHNINDEX0].stCropRect[VICAP_CROP0].s32Height = stCapRect.s32Height;
                astChnCropCfg[VICAP_CHNINDEX0].bCropEn[VICAP_CROP0] = HI_TRUE;
                astChnCropCfg[VICAP_CHNINDEX0].bCropEn[VICAP_CROP1] = HI_FALSE;

                if (HI_DRV_VICAP_3DT2D_OFF == en3DT2DMode)
                {
                    /* 3D右眼裁剪区域 */
                    astChnCropCfg[VICAP_CHNINDEX1].stCropRect[VICAP_CROP0].s32X = stCapRect.s32X;
                    astChnCropCfg[VICAP_CHNINDEX1].stCropRect[VICAP_CROP0].s32Y = stCapRect.s32Y + u32SrcHeight + u32Vblank;
                    astChnCropCfg[VICAP_CHNINDEX1].stCropRect[VICAP_CROP0].s32Width = stCapRect.s32Width;
                    astChnCropCfg[VICAP_CHNINDEX1].stCropRect[VICAP_CROP0].s32Height = stCapRect.s32Height;
                    astChnCropCfg[VICAP_CHNINDEX1].bCropEn[VICAP_CROP0] = HI_TRUE;
                    astChnCropCfg[VICAP_CHNINDEX1].bCropEn[VICAP_CROP1] = HI_FALSE;
                }
                else if (HI_DRV_VICAP_3DT2D_R == en3DT2DMode)
                {
                    astChnCropCfg[VICAP_CHNINDEX0].stCropRect[VICAP_CROP0].s32Y = stCapRect.s32Y + u32SrcHeight + u32Vblank; 
                }

            }
        }
        /*设置通道裁剪区域*/
        VICAP_HAL_SetChnCrop(VICAP_CHNINDEX0, &astChnCropCfg[VICAP_CHNINDEX0]); 
        VICAP_HAL_SetChnCrop(VICAP_CHNINDEX1, &astChnCropCfg[VICAP_CHNINDEX1]); 
    }
    return HI_SUCCESS;
}

VICAP_SCALE_COEFPARA_E VICAP_DRV_SelectCoefPara(HI_U32 u32HStep)
{    
    VICAP_SCALE_COEFPARA_E eCoefPara = VICAP_SCALE_COEFPARA_BUTT;
    
    if (VICAP_NO_HFIR_RATIO == u32HStep)                               
    {                                                     
        eCoefPara = VICAP_SCALE_COEFPARA_NO;                             //无缩小                          
    }     
    else if ((u32HStep > VICAP_NO_HFIR_RATIO) && (u32HStep <= VICAP_2X_HFIR_RATIO) )     //2倍缩小
    {
        eCoefPara = VICAP_SCALE_COEFPARA_2X;
    }
    else if ((u32HStep > VICAP_2X_HFIR_RATIO) && (u32HStep <= VICAP_3X_HFIR_RATIO)) //3倍缩小
    {
        eCoefPara = VICAP_SCALE_COEFPARA_3X;
    }
    else if ((u32HStep > VICAP_3X_HFIR_RATIO) && (u32HStep <= VICAP_4X_HFIR_RATIO)) //4倍缩小
    {
        eCoefPara = VICAP_SCALE_COEFPARA_4X;
    }
    else                                                              //其它倍缩小
    {
        eCoefPara = VICAP_SCALE_COEFPARA_OTHER;
    }
    return eCoefPara;
}


static HI_S32 VICAP_DRV_SetScaleAttr(HI_S32 s32ChnIndex, VICAP_UPDATE_SCALE_TYPE_E enUpdateType, VICAP_SCALE_ATTR_S *pstScaleAttr)
{
    HI_S32 s32Ret = 0;
    HI_U32 u32Wi = pstScaleAttr->u32InImgWidth;/*输入图像宽度*/
    HI_U32 u32Wo = pstScaleAttr->u32OutImgWidth;/*输出图像宽度*/
    HI_U32 u32Hi = pstScaleAttr->u32InImgHeight;/*输入图像高度*/
    HI_U32 u32Ho = pstScaleAttr->u32OutImgHeight;/*输出图像高度*/

    HI_U32 u32YHStep = 0;
    HI_U32 u32CHStep = 0;
    HI_U32 u32YVStep = 0;
    HI_U32 u32CVStep = 0;
    
    VICAP_SCALE_COEFPARA_E eYCoefPara = VICAP_SCALE_COEFPARA_BUTT;
    VICAP_SCALE_COEFPARA_E eCCoefPara = VICAP_SCALE_COEFPARA_BUTT;

    /*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~step1: 计算缩放配置~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
    /* 444->422下采样，色度水平方向缩小是亮度的两倍, */
    if (((HI_DRV_PIX_FMT_NV42 == pstScaleAttr->enPixFormat) || (HI_DRV_PIX_FMT_RGB444 == pstScaleAttr->enPixFormat))
        && (HI_DRV_PIX_FMT_NV61_2X1 == pstScaleAttr->enVideoFmt))
    {   
        /* 4096左移20位，32位溢出 */
        u32YHStep = (((u32Wi << 19)/ u32Wo) * 2);/*2^20=1048576*/
        u32CHStep = u32YHStep << 1;/*色度为亮度的2倍*/
    }
    else 
    {
        u32YHStep = (((u32Wi << 19) / u32Wo) * 2);
        u32CHStep = u32YHStep;
    }
    
    /*垂直缩放倍数,向上取整*/
    u32YVStep = (u32Hi+ (u32Ho-1))/ u32Ho;
    u32CVStep = u32YVStep;
    
     eYCoefPara = VICAP_DRV_SelectCoefPara(u32YHStep);
     eCCoefPara = VICAP_DRV_SelectCoefPara(u32CHStep);

   /*~~~~~~~~~~~~~~~~~~~~~~~~step2:配置缩放参数到硬件~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
    /* 设置水平缩放系数 */    
    if (VICAP_UPDATE_SCALE_COEF == enUpdateType)
    {
        if (u32YHStep != VICAP_HAL_NO_HSCALE_STEP)
        {
            s32Ret |= VICAP_HAL_SetHScaleCoef8Phase(s32ChnIndex, VICAP_CHN_SCALE_OBJ_YH,eYCoefPara);
        }
        if (u32CHStep != VICAP_HAL_NO_HSCALE_STEP)
        {
            s32Ret |= VICAP_HAL_SetHScaleCoef8Phase(s32ChnIndex, VICAP_CHN_SCALE_OBJ_CH,eCCoefPara);
        }
    }

    /*设置除水平缩放系数外的其它相关缩放配置*/
    if (VICAP_UPDATE_SCALE_PARAM == enUpdateType)
    {    
        /*配置水平y缩放相关*/
        if (u32YHStep != VICAP_HAL_NO_HSCALE_STEP)
        {
            s32Ret |= VICAP_HAL_SetCoefUpdate(s32ChnIndex, VICAP_CHN_LHCOEF_UPDATE);
            s32Ret |= VICAP_HAL_SetHScale(s32ChnIndex, VICAP_CHN_SCALE_OBJ_YH, u32YHStep, VICAP_CHN_SCALE_MODE_FILT, 
                            HI_FALSE, HI_TRUE);
        }
        else
        {
            s32Ret |= VICAP_HAL_HScaleEn(s32ChnIndex, VICAP_CHN_SCALE_OBJ_YH, HI_FALSE);
        }


        /*配置垂直y缩放相关*/
        if(u32YVStep != VICAP_HAL_NO_VSCALE_STEP)
        {
            s32Ret |= VICAP_HAL_SetVScale(s32ChnIndex, VICAP_CHN_SCALE_OBJ_YH, u32YVStep,HI_TRUE);
        }
        else
        {
            s32Ret |= VICAP_HAL_VScaleEn(s32ChnIndex, VICAP_CHN_SCALE_OBJ_YH, HI_FALSE);
        }
        
        /*配置水平c缩放相关*/
        if (u32CHStep != VICAP_HAL_NO_HSCALE_STEP)
        {
            s32Ret |= VICAP_HAL_SetCoefUpdate(s32ChnIndex, VICAP_CHN_CHCOEF_UPDATE);
            s32Ret |= VICAP_HAL_SetHScale(s32ChnIndex, VICAP_CHN_SCALE_OBJ_CH, u32CHStep, VICAP_CHN_SCALE_MODE_FILT, 
                            HI_FALSE, HI_TRUE);
        }
        else
        {
            s32Ret |= VICAP_HAL_HScaleEn(s32ChnIndex, VICAP_CHN_SCALE_OBJ_CH, HI_FALSE);
        }

        /*配置垂直c缩放相关*/
        if(u32CVStep != VICAP_HAL_NO_VSCALE_STEP)
        {
            s32Ret |= VICAP_HAL_SetVScale(s32ChnIndex, VICAP_CHN_SCALE_OBJ_CH, u32CVStep, HI_TRUE);
        }
        else
        {
            s32Ret |= VICAP_HAL_VScaleEn(s32ChnIndex, VICAP_CHN_SCALE_OBJ_YH, HI_FALSE);
        }
    }

    return s32Ret;

}

static HI_S32 VICAP_DRV_UpdateChnDynamicAttr(HI_HANDLE hVicap)
{
    HI_U32 u32ContextIndex;
    HI_U32 u32ChnIndex;
    HI_U32 u32OutHeight;
    HI_RECT_S stCapRect;                  /* 捕获区域*/
    VICAP_SCALE_ATTR_S stScaleAttr;
    HI_DRV_VICAP_ATTR_S *pstVicapAttr;    /*VICAP属性指针*/
    HI_DRV_VICAP_OUTPUT_ATTR_S *pstVicapOutAttrTmp;
    VICAP_FRAME_STATUS_S *pstFrmStatus;   /*帧状态指针*/
    VICAP_SCALE_SIZE_S   stScaleSize;
    SIZE_S    stYDestSize, stCDestSize; 
    VICAP_CHN_DBG_INFO_S  *pstDbgInf  = HI_NULL;//VI调试信息 

    u32ContextIndex = GETCONTEXTID(hVicap);
    pstDbgInf  = &g_stVicapDrvCtx[u32ContextIndex].stChnDbg;

    /*检测通道的动态属性是否已经配置*/
    if (g_stVicapDrvCtx[u32ContextIndex].bUpdateCfg != HI_TRUE)
    {
        return HI_SUCCESS;
    }

    pstVicapAttr = &g_stVicapDrvCtx[u32ContextIndex].stVicapAttr;
    pstFrmStatus = &g_stVicapDrvCtx[u32ContextIndex].stFrmStatus;
    pstVicapOutAttrTmp = &g_stVicapDrvCtx[u32ContextIndex].stOutAttrtmp;
    memcpy(&stCapRect, &pstVicapOutAttrTmp->stCapRect, sizeof(HI_RECT_S));
    u32OutHeight = pstVicapOutAttrTmp->u32DestHeight;

    /*若为隔行信号，并3D格式不为FP*/
    if (pstVicapAttr->bInterlace && (pstVicapAttr->en3dFmt != HI_DRV_FT_FPK))
    {
        /*如果输入为场,则硬件限制针对一场,故crop的h/2*/
        stCapRect.s32Height >>= 1;
        u32OutHeight >>= 1;
    }

    /* 设置裁剪区域 */
    VICAP_DRV_SetChnCrop(hVicap, pstVicapAttr, pstVicapOutAttrTmp);

    /* 缩放属性参数 */
    stScaleSize.u32YInPixel = stCapRect.s32Width;
    stScaleSize.u32CInPixel = stCapRect.s32Width;
    stScaleSize.u32YOutPixel = pstVicapOutAttrTmp->u32DestWidth;
    stScaleSize.u32COutPixel = pstVicapOutAttrTmp->u32DestWidth;
    stScaleSize.u32YInLine  = stCapRect.s32Height;
    stScaleSize.u32CInLine  = stCapRect.s32Height;
    stScaleSize.u32YOutLine = u32OutHeight;
    stScaleSize.u32COutLine = u32OutHeight;

    stScaleAttr.u32InImgWidth = stCapRect.s32Width;/*输入图像宽度*/
    stScaleAttr.u32InImgHeight = stCapRect.s32Height;/*输入图像高度*/
    stScaleAttr.u32OutImgWidth = pstVicapOutAttrTmp->u32DestWidth;/*输出图像宽度*/
    stScaleAttr.u32OutImgHeight = u32OutHeight;/*输出图像高度*/
    stScaleAttr.enPixFormat = pstVicapAttr->enPixFmt;/*输入像素格式*/
    stScaleAttr.enVideoFmt = pstVicapOutAttrTmp->enVideoFmt;/*输出存储格式*/

    /*输入像素格式为YUV422,缩放的色度像素个数输入是原来的一半*/
    if ((HI_DRV_PIX_FMT_NV61_2X1 == pstVicapAttr->enPixFmt))
    {
        stScaleSize.u32CInPixel >>= 1;
    }

    /* 输出存储格式为YUV422，缩放输出的色度像素个数为原来的一半 */
    if (HI_DRV_PIX_FMT_NV61_2X1 == pstVicapOutAttrTmp->enVideoFmt) 
    {
        stScaleSize.u32COutPixel >>= 1;
    }  

    /* dest属性参数 */
    /*Y分量SIZE*/
    stYDestSize.u32Width = stScaleSize.u32YOutPixel;
    stYDestSize.u32Height = u32OutHeight;

    /* 色度双分量UV一块存储需要 x 2 */
    stCDestSize.u32Width = stScaleSize.u32COutPixel * 2;    
    stCDestSize.u32Height = u32OutHeight;

    /*设置缩放相关配置*/
    if(g_stVicapDrvCtx[u32ContextIndex].stFrmStatus.b3D)
    {
        /*通道0*/          
        VICAP_DRV_SetScaleAttr(VICAP_CHNINDEX0, VICAP_UPDATE_SCALE_COEF, &stScaleAttr);/*设置缩放属性_更新缩放系数*/
        VICAP_DRV_SetScaleAttr(VICAP_CHNINDEX0, VICAP_UPDATE_SCALE_PARAM, &stScaleAttr);/*设置缩放属性_更新缩放系数外的其他缩放参数*/
        VICAP_HAL_SetScaleSize(VICAP_CHNINDEX0, VICAP_CHN_SCALE_OBJ_YH, &stScaleSize);/*设置缩放属性_设置Y分量的输入输出宽度与高度*/
        VICAP_HAL_SetScaleSize(VICAP_CHNINDEX0, VICAP_CHN_SCALE_OBJ_CH, &stScaleSize);/*设置缩放属性_设置C分量的输入输出宽度*/        
        VICAP_HAL_SetChnWchSize(VICAP_CHNINDEX0, stYDestSize.u32Width, stYDestSize.u32Height, VICAP_WCH_MODE_Y);
        VICAP_HAL_SetChnWchSize(VICAP_CHNINDEX0, stCDestSize.u32Width, stCDestSize.u32Height, VICAP_WCH_MODE_C);

        /*通道1*/         
        VICAP_DRV_SetScaleAttr(VICAP_CHNINDEX1, VICAP_UPDATE_SCALE_COEF, &stScaleAttr);/*设置缩放属性_更新缩放系数*/
        VICAP_DRV_SetScaleAttr(VICAP_CHNINDEX1, VICAP_UPDATE_SCALE_PARAM, &stScaleAttr);/*设置缩放属性_更新缩放系数外的其他缩放参数*/
        VICAP_HAL_SetScaleSize(VICAP_CHNINDEX1, VICAP_CHN_SCALE_OBJ_YH, &stScaleSize);/*设置缩放属性_设置Y分量的输入输出宽度与高度*/
        VICAP_HAL_SetScaleSize(VICAP_CHNINDEX1, VICAP_CHN_SCALE_OBJ_CH, &stScaleSize);/*设置缩放属性_设置C分量的输入输出宽度*/        
        VICAP_HAL_SetChnWchSize(VICAP_CHNINDEX1, stYDestSize.u32Width, stYDestSize.u32Height, VICAP_WCH_MODE_Y);
        VICAP_HAL_SetChnWchSize(VICAP_CHNINDEX1, stCDestSize.u32Width, stCDestSize.u32Height, VICAP_WCH_MODE_C);
     }
    else
    {   
        u32ChnIndex = VICAP_DRV_GetChnIndex(hVicap);    
        VICAP_DRV_SetScaleAttr(u32ChnIndex, VICAP_UPDATE_SCALE_COEF, &stScaleAttr);/*设置缩放属性_更新缩放系数*/
        VICAP_DRV_SetScaleAttr(u32ChnIndex, VICAP_UPDATE_SCALE_PARAM, &stScaleAttr);/*设置缩放属性_更新缩放系数外的其他缩放参数*/
        VICAP_HAL_SetScaleSize(u32ChnIndex, VICAP_CHN_SCALE_OBJ_YH, &stScaleSize);/*设置缩放属性_设置Y分量的输入输出宽度与高度*/
        VICAP_HAL_SetScaleSize(u32ChnIndex, VICAP_CHN_SCALE_OBJ_CH, &stScaleSize);/*设置缩放属性_设置C分量的输入输出宽度*/        
        VICAP_HAL_SetChnWchSize(u32ChnIndex, stYDestSize.u32Width, stYDestSize.u32Height, VICAP_WCH_MODE_Y);
        VICAP_HAL_SetChnWchSize(u32ChnIndex, stCDestSize.u32Width, stCDestSize.u32Height, VICAP_WCH_MODE_C);        
    }  

    /*把VI输出属性,动态更改属性存入全局变量指针中*/
    memcpy(&g_stVicapDrvCtx[u32ContextIndex].stVicapAttr.stOutAttr, pstVicapOutAttrTmp, sizeof(HI_DRV_VICAP_OUTPUT_ATTR_S));

    pstFrmStatus->u32DstWidth = pstVicapOutAttrTmp->u32DestWidth;/*帧图像宽度等于输出图像宽度*/
    pstFrmStatus->u32DstHeight = pstVicapOutAttrTmp->u32DestHeight;/*帧图像高度等于裁剪区域高度*/
    pstFrmStatus->u32DstFrameRate = pstVicapOutAttrTmp->u32DstFrameRate;/*输出帧率*/
    g_stVicapDrvCtx[u32ContextIndex].stFrmRateCtrl.u32DstFrmRate = pstVicapOutAttrTmp->u32DstFrameRate;/*更新帧率控制的输出帧率*/

    /*vicap输出属性动态更新完毕，恢复可更新状态*/
    g_stVicapDrvCtx[u32ContextIndex].bUpdateCfg = HI_FALSE;
    pstDbgInf->u32UpdateCnt++;

    return HI_SUCCESS;
}

static HI_S32 VICAP_DRV_ProcPrepareFrm(HI_HANDLE hVicap)
{    
    HI_S32 s32Ret = 0;
    HI_U32              u32ContextIndex;
    VICAP_BUF_BLK_S     *pstThisFrm = NULL;
    VICAP_BUF_BLK_S     *pstNextFrm = NULL;
    VICAP_FRAME_STATUS_S  *pstFrmStatus = NULL;//帧状态信息
    VICAP_CHN_DBG_INFO_S  *pstDbgInf  = NULL;//VI调试信息 

    u32ContextIndex = GETCONTEXTID(hVicap);
    pstThisFrm = &g_stVicapDrvCtx[u32ContextIndex].stThisFrm;
    pstNextFrm = &g_stVicapDrvCtx[u32ContextIndex].stNextFrm;
    pstFrmStatus = &g_stVicapDrvCtx[u32ContextIndex].stFrmStatus;
    pstDbgInf  = &g_stVicapDrvCtx[u32ContextIndex].stChnDbg;

    pstDbgInf->u32IntCnt++;

    /*检测是否为连续两个底场，计顶场丢失*/
    if (HI_TRUE == pstThisFrm->bValid)
    {
        //释放当前帧的缓存
        s32Ret = VICAP_DRV_PutFrmBuf(hVicap,pstThisFrm);       
        HI_ASSERT(HI_SUCCESS == s32Ret);
        pstDbgInf->u32BufCnt --;
        pstDbgInf->u32TopLost ++;
        pstDbgInf->u32LostInt ++;
        g_stVicapDrvCtx[u32ContextIndex].bTopFrmLost = HI_TRUE;/* 用于顶场中断丢失时的异常处理 */
    }

    /* update ThisBuf from NextBuf */
    memcpy(pstThisFrm, pstNextFrm, sizeof(VICAP_BUF_BLK_S));

    /* 第二个底场或则帧之后，开始计数中断和顶底场丢失，保证中断和顶底场丢失信息的准确性 */
    if (HI_TRUE == pstThisFrm->bValid)
    {
        pstDbgInf->bStartCnt = HI_TRUE;/* 是否开始计数丢失中断、顶底场数 */
    }
    
    /*帧率控制*/
    if(HI_TRUE == VICAP_DRV_FrmRateCtrl(&g_stVicapDrvCtx[u32ContextIndex].stFrmRateCtrl))
    {
        if(HI_TRUE == g_stVicapDrvCtx[u32ContextIndex].bUpdateCfg)
        { 
            VICAP_DRV_UpdateChnDynamicAttr(hVicap);
            goto lost_frm;
        }
    }
    else
    {
        HI_INFO_VICAP("vicap not cap(0) \n");
        goto lost_frm;
    }

    /*为下一帧获取空闲buf*/
     /* 根据通道采集状态，为视频帧分配VideoBuf，并设置相应字段 */ 
    if (VICAP_DRV_GetFrmBuf(hVicap, pstFrmStatus, &pstNextFrm->stVicapFrameInfo) != HI_SUCCESS)
    {              
        HI_INFO_VICAP("vicap get free buf fail,w:%d,h:%d\n",
            pstFrmStatus->u32DstWidth, pstFrmStatus->u32DstHeight);
        
#if    defined(CHIP_TYPE_hi3751v100)   \
    || defined(CHIP_TYPE_hi3751v100b)          
        if (g_stVicapDrvCtx[u32ContextIndex].pfUserCallBack != HI_NULL)
        {
           g_stVicapDrvCtx[u32ContextIndex].pfUserCallBack(g_stVicapDrvCtx[u32ContextIndex].hDst,VICAP_EVENT_BUFLIST_FULL, HI_NULL);
        }
        else
        {
            HI_ERR_VICAP("Can't report VICAP_EVENT_BUFLIST_FULL,pfUserCallBack is NULL\n");
        }
#endif        
        goto getbuf_failed;
    }
   
    /* 置视频帧有效标志 */
    pstNextFrm->bValid = HI_TRUE;
    pstDbgInf->u32BufCnt ++;
    return HI_SUCCESS;
lost_frm:
    pstNextFrm->bValid = HI_FALSE;
    return HI_SUCCESS;
getbuf_failed:
    pstNextFrm->bValid = HI_FALSE;
    pstDbgInf->u32GetVbFail++;
    return HI_FAILURE;   
    
}

static VICAP_FRAME_FILED_E VICAP_DRV_GetFrameField(VICAP_FRAME_FILED_E enIntField)
{
    /*若中断场类型为顶场中断*/
    if (VICAP_FRAME_FILED_TOP == enIntField)
    {
        return VICAP_FRAME_FILED_BOTTOM;
    }
    /*若中断场类型为底场中断*/
    else if (VICAP_FRAME_FILED_BOTTOM == enIntField)/* capture top filed in bottom interrupt*/
    {
        return VICAP_FRAME_FILED_TOP;
    } 
    /*默认*/
    else
    {
        return VICAP_FRAME_FILED_FRAME;
    }
}

static HI_VOID VICAP_DRV_StartCap(HI_HANDLE hVicap,VICAP_FRAME_FILED_E enField, HI_BOOL bInterlace,
                                 VICAP_BUF_BLK_S *pstVicapFrame)
{
    VICAP_ADDR_S stViAddr[2];
    HI_DRV_VIDEO_FRAME_S *pstVFrame = NULL;    
    VICAP_CHN_WCH_CFG_S  stWchCfg;
    HI_U32 u32ChnIndex;
    
    memset(stViAddr, 0, sizeof(stViAddr));     
    pstVFrame = &pstVicapFrame->stVicapFrameInfo;
    
    /*2D时默认存储在左眼*/
    /*顶场*/
    if (VICAP_FRAME_FILED_TOP == enField)
    {
        stViAddr[VICAP_EYE_LEFT].u32YAddr = pstVFrame->stBufAddr[VICAP_EYE_LEFT].u32PhyAddr_Y;
        stViAddr[VICAP_EYE_LEFT].u32CAddr = pstVFrame->stBufAddr[VICAP_EYE_LEFT].u32PhyAddr_C;
    }
    /*底场*/
    else if (VICAP_FRAME_FILED_BOTTOM == enField)
    {
        stViAddr[VICAP_EYE_LEFT].u32YAddr = pstVFrame->stBufAddr[VICAP_EYE_LEFT].u32PhyAddr_Y + pstVFrame->stBufAddr[VICAP_EYE_LEFT].u32Stride_Y;
        stViAddr[VICAP_EYE_LEFT].u32CAddr = pstVFrame->stBufAddr[VICAP_EYE_LEFT].u32PhyAddr_C + pstVFrame->stBufAddr[VICAP_EYE_LEFT].u32Stride_C; 
    } 
    /*帧*/
    else if (VICAP_FRAME_FILED_FRAME == enField)
    {        
        stViAddr[VICAP_EYE_LEFT].u32YAddr = pstVFrame->stBufAddr[VICAP_EYE_LEFT].u32PhyAddr_Y;
        stViAddr[VICAP_EYE_LEFT].u32CAddr = pstVFrame->stBufAddr[VICAP_EYE_LEFT].u32PhyAddr_C;    
    }    
    else 
    {
        HI_ASSERT(0);
    }
    
    /*右眼地址*/
    /*SBS与TAB*/
    if (g_stVicapDrvCtx[GETCONTEXTID(hVicap)].stFrmStatus.b3D)
    {        
         if (VICAP_FRAME_FILED_TOP == enField)
         {
             stViAddr[VICAP_EYE_RIGHT].u32YAddr = pstVFrame->stBufAddr[VICAP_EYE_RIGHT].u32PhyAddr_Y;
             stViAddr[VICAP_EYE_RIGHT].u32CAddr = pstVFrame->stBufAddr[VICAP_EYE_RIGHT].u32PhyAddr_C;
         }else if(VICAP_FRAME_FILED_BOTTOM == enField)
         {
             stViAddr[VICAP_EYE_RIGHT].u32YAddr = pstVFrame->stBufAddr[VICAP_EYE_RIGHT].u32PhyAddr_Y + pstVFrame->stBufAddr[VICAP_EYE_RIGHT].u32Stride_Y;
             stViAddr[VICAP_EYE_RIGHT].u32CAddr = pstVFrame->stBufAddr[VICAP_EYE_RIGHT].u32PhyAddr_C + pstVFrame->stBufAddr[VICAP_EYE_RIGHT].u32Stride_C; 
         }else if (VICAP_FRAME_FILED_FRAME == enField)
         {
            stViAddr[VICAP_EYE_RIGHT].u32YAddr = pstVFrame->stBufAddr[VICAP_EYE_RIGHT].u32PhyAddr_Y;
            stViAddr[VICAP_EYE_RIGHT].u32CAddr = pstVFrame->stBufAddr[VICAP_EYE_RIGHT].u32PhyAddr_C;
            /* 3D framepacking信号 */
            if(bInterlace && (HI_DRV_FT_FPK == g_stVicapDrvCtx[GETCONTEXTID(hVicap)].stVicapAttr.en3dFmt))
            {
                stViAddr[VICAP_EYE_RIGHT].u32YAddr = pstVFrame->stBufAddr[VICAP_EYE_LEFT].u32PhyAddr_Y + pstVFrame->stBufAddr[VICAP_EYE_RIGHT].u32Stride_Y;
                stViAddr[VICAP_EYE_RIGHT].u32CAddr = pstVFrame->stBufAddr[VICAP_EYE_LEFT].u32PhyAddr_C + pstVFrame->stBufAddr[VICAP_EYE_RIGHT].u32Stride_C; 
            }          
         }         
         else 
         {
             HI_ASSERT(0);
         }
    }

    stWchCfg.bInterlace = bInterlace;
    stWchCfg.enDstBitWidth = pstVFrame->enBitWidth;
    stWchCfg.enField   =  enField;

    if(g_stVicapDrvCtx[GETCONTEXTID(hVicap)].stFrmStatus.b3D)
    {
        VICAP_HAL_SetChnWchCfg(VICAP_CHNINDEX0,&stWchCfg,VICAP_WCH_MODE_Y);
        VICAP_HAL_SetChnWchAddr(VICAP_CHNINDEX0, &stViAddr[VICAP_EYE_LEFT], VICAP_WCH_MODE_Y);
        VICAP_HAL_SetChnWchCfg(VICAP_CHNINDEX0,&stWchCfg,VICAP_WCH_MODE_C);
        VICAP_HAL_SetChnWchAddr(VICAP_CHNINDEX0, &stViAddr[VICAP_EYE_LEFT], VICAP_WCH_MODE_C);
        VICAP_HAL_SetRegNewer(VICAP_CHNINDEX0);

        VICAP_HAL_SetChnWchCfg(VICAP_CHNINDEX1,&stWchCfg,VICAP_WCH_MODE_Y);
        VICAP_HAL_SetChnWchAddr(VICAP_CHNINDEX1, &stViAddr[VICAP_EYE_RIGHT], VICAP_WCH_MODE_Y);
        VICAP_HAL_SetChnWchCfg(VICAP_CHNINDEX1,&stWchCfg,VICAP_WCH_MODE_C);
        VICAP_HAL_SetChnWchAddr(VICAP_CHNINDEX1, &stViAddr[VICAP_EYE_RIGHT], VICAP_WCH_MODE_C);
        VICAP_HAL_SetRegNewer(VICAP_CHNINDEX1); 
    }
    else
    {   
        u32ChnIndex = VICAP_DRV_GetChnIndex(hVicap);
        VICAP_HAL_SetChnWchCfg(u32ChnIndex,&stWchCfg,VICAP_WCH_MODE_Y);
        VICAP_HAL_SetChnWchAddr(u32ChnIndex, &stViAddr[VICAP_EYE_LEFT], VICAP_WCH_MODE_Y);
        VICAP_HAL_SetChnWchCfg(u32ChnIndex,&stWchCfg,VICAP_WCH_MODE_C);
        VICAP_HAL_SetChnWchAddr(u32ChnIndex, &stViAddr[VICAP_EYE_LEFT], VICAP_WCH_MODE_C);
        VICAP_HAL_SetRegNewer(u32ChnIndex); 
    }
    return ;    
}


static HI_S32 VICAP_DRV_ProcCapFrm(HI_HANDLE hVicap,VICAP_FRAME_FILED_E enIntField)
{
    HI_BOOL bInterlace;
    VICAP_FRAME_FILED_E enViField;
    VICAP_BUF_BLK_S *pstViFrame = NULL;
    HI_U32 u32ContextIndex;
    
    u32ContextIndex = GETCONTEXTID(hVicap);
    bInterlace = g_stVicapDrvCtx[u32ContextIndex].stVicapAttr.bInterlace;

    /* config addr info and regnewer */
    /* 配置为捕获两场时，底场顶场中断都需要启动采集 */
    if (HI_TRUE == g_stVicapDrvCtx[u32ContextIndex].stNextFrm.bValid)
    {            
        /* 配置给芯片的内存的filed标志:top/bottom/frame */
        enViField = VICAP_DRV_GetFrameField(enIntField);
        pstViFrame = &g_stVicapDrvCtx[u32ContextIndex].stNextFrm;
        /* 根据不同的帧的场信息从VI图像缓存信息指针中取地址配置给芯片并启动采集*/
        VICAP_DRV_StartCap(hVicap,enViField, bInterlace, pstViFrame);
    }                

    return HI_SUCCESS;
}

HI_S32 VICAP_DRV_ChnIntProcess(HI_HANDLE hVicap)
{
    VICAP_FRAME_FILED_E  enIntField;
    HI_U32 u32ContextIndex = 0;
    struct timeval time1,time2,stCurTime;  
    HI_U32 u32UsedPhyChn = 0;
    
    u32ContextIndex = GETCONTEXTID(hVicap);
    u32UsedPhyChn = GETPHYCHN(hVicap);

    /*Check 通道状态*/
    if(VICAP_STATUS_STOP == g_stVicapDrvCtx[u32ContextIndex].enStatus)
    {
        return HI_SUCCESS;
    }

    if(VICAP_STATUS_STOPPING == g_stVicapDrvCtx[u32ContextIndex].enStatus)
    {   
        /*检测通道状态是否为关闭*/
        if(g_stVicapDrvCtx[u32ContextIndex].stFrmStatus.b3D)
        {
            if((0 == VICAP_HAL_GetChnEnStatus(VICAP_CHNINDEX0)) && 0 == VICAP_HAL_GetChnEnStatus(VICAP_CHNINDEX1))
            {
                g_stVicapDrvCtx[u32ContextIndex].enStatus = VICAP_STATUS_STOP;
                wake_up(&g_stVicapDrvCtx[u32ContextIndex].stWaitQueue);
                return HI_SUCCESS;
            }  
        }
        else
        {
            if(0 == VICAP_HAL_GetChnEnStatus(VICAP_DRV_GetChnIndex(hVicap)))
            {
                g_stVicapDrvCtx[u32ContextIndex].enStatus = VICAP_STATUS_STOP;
                wake_up(&g_stVicapDrvCtx[u32ContextIndex].stWaitQueue);
                return HI_SUCCESS;
            }

        }

        /*关闭通道*/
        VICAP_DRV_DisableChn(hVicap);
        
        /*设置reg_new*/
        if(g_stVicapDrvCtx[u32ContextIndex].stFrmStatus.b3D)
        {
            VICAP_HAL_SetRegNewer(VICAP_CHNINDEX0); 
            VICAP_HAL_SetRegNewer(VICAP_CHNINDEX1); 
        }
        else
        {
            VICAP_HAL_SetRegNewer(VICAP_DRV_GetChnIndex(hVicap)); 
        }
        return HI_SUCCESS;
    }

    /*获取中断场*/
    enIntField = VICAP_DRV_GetIntType(GETPHYPT(hVicap)\
    ,g_stVicapDrvCtx[u32ContextIndex].stVicapAttr.bInterlace,g_stVicapDrvCtx[u32ContextIndex].stVicapAttr.en3dFmt);

    do_gettimeofday(&time1);

    /* 隔行信号的顶场 或者 逐行信号 */
    if ((VICAP_FRAME_FILED_FRAME == enIntField) || (VICAP_FRAME_FILED_TOP == enIntField))    
    {    
          /* 统计两帧中断之间的时间间隔,调试用! */
         do_gettimeofday(&stCurTime);
         g_stVicapDrvCtx[u32ContextIndex].stChnDbg.u32IntvTime = \
             VICAP_TIME_DIFF_US(stCurTime, g_stVicapDrvCtx[u32ContextIndex].stChnDbg.stLastIntTime);
         memcpy(&g_stVicapDrvCtx[u32ContextIndex].stChnDbg.stLastIntTime, &stCurTime, sizeof(stCurTime));
         /* 分发已经采集好的上一帧视频图像 */
         VICAP_DRV_ProcSendFrm(hVicap);
    }

    /* 隔行信号的底场 或者 逐行信号 */
    if ((VICAP_FRAME_FILED_FRAME == enIntField) || (VICAP_FRAME_FILED_BOTTOM == enIntField))
    {                   
         /* 帧率控制及准备视频采集 */
         VICAP_DRV_ProcPrepareFrm(hVicap);
    }

    /* 启动视频帧采集 */
    VICAP_DRV_ProcCapFrm(hVicap,enIntField);

    do_gettimeofday(&time2);
     g_stVicapDrvCtx[u32ContextIndex].stChnDbg.u32IntTime = VICAP_TIME_DIFF_US(time2, time1);
     
    /*判断中断占用时间是否大于最大中断调用时间，若为真，则把最大中断占用时间设为现在的中断占用时间*/
    if (g_stVicapDrvCtx[u32ContextIndex].stChnDbg.u32IntTime > g_stVicapDrvCtx[u32ContextIndex].stChnDbg.u32IntTimeMax)
    {
        g_stVicapDrvCtx[u32ContextIndex].stChnDbg.u32IntTimeMax = g_stVicapDrvCtx[u32ContextIndex].stChnDbg.u32IntTime;        
    } 

   return HI_SUCCESS; 
}


static inline irqreturn_t VICAP_DRV_InterruptRoute(HI_S32 irq, HI_VOID *dev_id)
{    
    HI_U32 u32Chn0IntStatus = 0;  
    HI_U32 u32Chn1IntStatus = 0;
    HI_U32 u32UsedPhyChn = 0;
    HI_U32 i;

    for(i = 0; i < MAXVICAP; i++)
    {
        u32Chn0IntStatus = 0;  
        u32Chn1IntStatus = 0;
        /*上下文无效，结束本次循环*/
        if(HI_INVALID_HANDLE == g_stVicapDrvCtx[i].hViCap)
        {
            continue;
        }
        
        u32UsedPhyChn = GETPHYCHN(g_stVicapDrvCtx[i].hViCap);
        switch(u32UsedPhyChn)
        {    
            case VICAP_PHYCHN_CHN0:
            {
                u32Chn0IntStatus = VICAP_HAL_GetChnIntStatus(VICAP_CHNINDEX0);        
                break;
            }
            case VICAP_PHYCHN_CHN1:
            {
                u32Chn1IntStatus = VICAP_HAL_GetChnIntStatus(VICAP_CHNINDEX1);
                break;
            }
            case (VICAP_PHYCHN_CHN0 | VICAP_PHYCHN_CHN1):
            {
                u32Chn0IntStatus = VICAP_HAL_GetChnIntStatus(VICAP_CHNINDEX0);
                /*供清除通道1的中断用*/
                u32Chn1IntStatus = VICAP_HAL_GetChnIntStatus(VICAP_CHNINDEX1);
                break;
            }
            default:
            {
                HI_ASSERT(0);
            }
        }
        
        /*清除中断*/
        if (u32Chn0IntStatus)
        {
            VICAP_HAL_ClrChnIntStatus(VICAP_CHNINDEX0, 0xffffffff);
        }
        if (u32Chn1IntStatus)
        {
            VICAP_HAL_ClrChnIntStatus(VICAP_CHNINDEX1, 0xffffffff);
        }

        /*错误中断*/
        /*场数据丢失中断*/
        if ((u32Chn0IntStatus & VICAP_CHN_INT_FIELDTHROW) 
            || (u32Chn1IntStatus & VICAP_CHN_INT_FIELDTHROW))
        {
            HI_INFO_VICAP("VICAP_CHN_INT_FIELDTHROW \n");
        }
        
        /*内部FIFO溢出错误中断状态*/
        if ((u32Chn0IntStatus & VICAP_CHN_INT_BUFOVF) 
            || (u32Chn1IntStatus & VICAP_CHN_INT_BUFOVF))
        {
            HI_ERR_VICAP("VICAP_CHN_INT_BUFOVF \n");
        }
        
        /*Y数据通路总线错误中断状态*/
        if ((u32Chn0IntStatus & (VICAP_CHN_INT_YBUSERR|VICAP_CHN_INT_CBUSERR))
            || (u32Chn1IntStatus & (VICAP_CHN_INT_YBUSERR|VICAP_CHN_INT_CBUSERR)))
        {
            HI_ERR_VICAP("VICAP_CHN_INT_BUSERR \n");
        }
 
        /*中断处理*/
        if (((VICAP_PHYCHN_CHN0 == u32UsedPhyChn)||((VICAP_PHYCHN_CHN0 | VICAP_PHYCHN_CHN1) == u32UsedPhyChn))\
            &&(u32Chn0IntStatus & VICAP_CHN_INT_FRAMESTART))
        {
            VICAP_DRV_ChnIntProcess(g_stVicapDrvCtx[i].hViCap);
        }

        if((VICAP_PHYCHN_CHN1 == u32UsedPhyChn) && (u32Chn1IntStatus & VICAP_CHN_INT_FRAMESTART))
        {
            VICAP_DRV_ChnIntProcess(g_stVicapDrvCtx[i].hViCap);
        }   
    }

    return IRQ_HANDLED;
}


HI_S32 HI_DRV_VICAP_Init(HI_VOID)
{
    
    HI_U32 i;

    /*初始化上下文*/
    for(i = 0; i < MAXVICAP; i++)
    {
       memset(&g_stVicapDrvCtx[i], 0, sizeof(VICAP_DRV_CTX_S));           
       g_stVicapDrvCtx[i].hViCap = HI_INVALID_HANDLE;
       g_stVicapDrvCtx[i].pfUserCallBack = HI_NULL;
    }
    memset(&g_stVicapExtFunc, 0, sizeof(VICAP_USED_EXT_FUNC_S));
    
    /* 初始化VICAP计数 */
    g_u32VicapCount = 0;
    
    /*自旋锁初始化*/
    spin_lock_init(&stVicapDrvLock);
    
    /* request irq(为VI注册中断处理例程) */  
    /*取 IRQF_DISABLED标志，则在执行该中断服务程序时会屏蔽所有其他的中断*/
    if (request_irq(VICAP_IRQ_NR, VICAP_DRV_InterruptRoute, IRQF_DISABLED, "VICAP", NULL))
    {
       HI_ERR_VICAP("VICAP failed request irq\n");
       VICAP_HAL_BoardDeInit();
       return HI_FAILURE;
    }

    return HI_SUCCESS;   

}



HI_S32 HI_DRV_VICAP_Create(HI_DRV_VICAP_ATTR_S *pstVicapAttr, HI_HANDLE *phVicap)
{
    HI_U32 u32ContextIndex;
    HI_HANDLE hVicap;
    VICAP_FRAME_STATUS_S *pstFrmStatus = NULL;
    VICAP_BUF_ATTR_S stBufAttr;
    HI_HANDLE hBufHandle = HI_INVALID_HANDLE;
    HI_VOID *pUfHandle = NULL;
    UF_INIT_ATTR_S stInitAttr;
    
    VICAP_CHECK_NULL_PTR(pstVicapAttr);
    VICAP_CHECK_NULL_PTR(phVicap);

    if(0 >= g_u32VicapCount)
    {
        memset(&g_stVicapExtFunc, 0, sizeof(VICAP_USED_EXT_FUNC_S));
    }
    /*是否存在无效属性*/
    if(HI_SUCCESS != VICAP_DRV_CheckAttr(pstVicapAttr))
    {
        HI_ERR_VICAP("some Vicap attr is invalid \n");
        return HI_FAILURE;
    } 
    /*检测创建条件*/
    if(HI_SUCCESS != VICAP_DRV_CheckCreateCondition(pstVicapAttr))
    {
        HI_ERR_VICAP("Can't Create Vicap! \n");
        return HI_FAILURE;    
    }
    
    /*创建HANDLE*/  
    hVicap = VICAP_DRV_GenerateHandle(pstVicapAttr);
    u32ContextIndex = GETCONTEXTID(hVicap);

    /*初始化VICAP通路上下文*/
    memset(&g_stVicapDrvCtx[u32ContextIndex], 0, sizeof(VICAP_DRV_CTX_S));           
    g_stVicapDrvCtx[u32ContextIndex].hViCap = HI_INVALID_HANDLE; 
    g_stVicapDrvCtx[u32ContextIndex].pfUserCallBack = HI_NULL;
    init_waitqueue_head(&g_stVicapDrvCtx[u32ContextIndex].stWaitQueue);
    
    g_stVicapDrvCtx[u32ContextIndex].hViCap = hVicap;
    g_stVicapDrvCtx[u32ContextIndex].stFrmRateCtrl.u32SrcFrmRate = pstVicapAttr->u32FrameRate;    
    g_stVicapDrvCtx[u32ContextIndex].stFrmRateCtrl.u32DstFrmRate = pstVicapAttr->stOutAttr.u32DstFrameRate;
    memcpy(&g_stVicapDrvCtx[u32ContextIndex].stVicapAttr, pstVicapAttr, sizeof(HI_DRV_VICAP_ATTR_S));
    memcpy(&g_stVicapDrvCtx[u32ContextIndex].stOutAttrtmp, &pstVicapAttr->stOutAttr, sizeof(HI_DRV_VICAP_OUTPUT_ATTR_S));
    g_stVicapDrvCtx[u32ContextIndex].bUpdateCfg = HI_TRUE;

    /* 创建第一路时，总线时钟打开，并撤销复位 */
    if(0 >= g_u32VicapCount)
    {
        VICAP_HAL_SetBusClken(HI_TRUE);
        VICAP_HAL_SetBusReset(HI_FALSE);

        /*初始化寄存器*/
        if (HI_SUCCESS != VICAP_HAL_BoardInit())
        {
           HI_ERR_VICAP("VICAP failed board init\n");
           return HI_FAILURE;
        }

        /*初始化VI硬件*/
        VICAP_HAL_Init();
    }

    /* 打开相应通路的时钟，并撤销复位 */
    VICAP_DRV_SetClkAndReset(hVicap, HI_TRUE);

    /*设置输入源*/
    if(HI_SUCCESS != VICAP_DRV_SetAccess(hVicap,pstVicapAttr->enAccess) )
    {
       HI_ERR_VICAP("Vicap set Access failed \n");
       return HI_FAILURE;
    }
    
    /*初始化BUF*/
    memset(&stBufAttr, 0, sizeof(VICAP_BUF_ATTR_S));    
    pstFrmStatus = &g_stVicapDrvCtx[u32ContextIndex].stFrmStatus;
    if(HI_SUCCESS != VICAP_DRV_GetBufferAttr(pstVicapAttr, pstFrmStatus, &stBufAttr))
    {
        HI_ERR_VICAP("Vicap GetBufferAttr failed \n");
        return HI_FAILURE;
    }    
    if (HI_SUCCESS != VICAP_DRV_BufInit(&stBufAttr, &hBufHandle))
    {
        HI_ERR_VICAP("Buf init failed \n");
        return HI_FAILURE;
    }        
    g_stVicapDrvCtx[u32ContextIndex].hBufHandle = hBufHandle;
    pstFrmStatus->hBufHandle = hBufHandle;
    
    /*初始化UF模块，并注册引用计数回调函数*/
    if (pstVicapAttr->bUserOut)
    {
        stInitAttr.hHandle = hBufHandle;
        stInitAttr.pfnUfBufUserSub = VICAP_DRV_BufSub;
        stInitAttr.pfnUfBufUserAdd = VICAP_DRV_BufAdd;
        stInitAttr.u32Depth = VICAP_USEROUT_DEPTH;
        pUfHandle = HI_DRV_UF_Init(&stInitAttr);
        if (!pUfHandle)
        {
            HI_ERR_VICAP("UF init failed \n");
            return HI_FAILURE;
        }
        
        g_stVicapDrvCtx[u32ContextIndex].pUfHandle = pUfHandle;
     }
    /*设置通道相关的静态属性*/
    VICAP_DRV_SetChnStaticAttr(hVicap, pstVicapAttr, pstFrmStatus);
    /*配置端口属性*/
    VICAP_DRV_SetPortAttr(hVicap,pstVicapAttr);
    /*使能端口*/
    VICAP_DRV_EnablePort(hVicap);
    *phVicap = hVicap;
    VICAP_DRV_ProcAdd(hVicap);
    g_u32VicapCount++;
    return HI_SUCCESS;    
}

HI_S32 HI_DRV_VICAP_Start(HI_HANDLE hVicap)
{   
    HI_U32 u32ContextIndex;

    VICAP_CHECK_HVICAP(hVicap);

    u32ContextIndex = GETCONTEXTID(hVicap);    
    if(VICAP_STATUS_START == g_stVicapDrvCtx[u32ContextIndex].enStatus)
    {
        HI_INFO_PRINT(HI_ID_VICAP,"This vicap is start! \n");
        return HI_SUCCESS;
    }
    /*使能通道*/
    VICAP_DRV_EnableChn(hVicap);
    /*置该通路状态为为start*/
    g_stVicapDrvCtx[u32ContextIndex].enStatus = VICAP_STATUS_START;

    return HI_SUCCESS;
}

HI_S32 HI_DRV_VICAP_GetOutputAttr(HI_HANDLE hVicap, HI_DRV_VICAP_OUTPUT_ATTR_S *pstOutAttr)
{
    /*Check hVicap是否有效*/
    VICAP_CHECK_HVICAP(hVicap);

    /*从上下文中获取输出属性，并赋给*pstOutAttr*/
    memcpy(pstOutAttr, &g_stVicapDrvCtx[GETCONTEXTID(hVicap)].stVicapAttr.stOutAttr, sizeof(HI_DRV_VICAP_OUTPUT_ATTR_S));
    return HI_SUCCESS;
}

HI_S32 HI_DRV_VICAP_SetOutputAttr(HI_HANDLE hVicap, HI_DRV_VICAP_OUTPUT_ATTR_S *pstOutAttr)
{
    HI_U32 u32ContextIndex;
    /*Check hVicap是否有效*/
    VICAP_CHECK_HVICAP(hVicap);

    u32ContextIndex = GETCONTEXTID(hVicap);
    /*判断输出属性是否合规*/
    if(HI_SUCCESS != VICAP_DRV_CheckOutputAttr(u32ContextIndex,pstOutAttr))
    {
       HI_ERR_VICAP("Invalid outputAttr\n");
       return HI_FAILURE; 
    }    

    /*把更新的输出属性存入上下文的stOutPutAttrTemp中*/    
    memcpy(&g_stVicapDrvCtx[u32ContextIndex].stOutAttrtmp, pstOutAttr, sizeof(HI_DRV_VICAP_OUTPUT_ATTR_S));
    /*设置输出属性可更新标志*/
    g_stVicapDrvCtx[u32ContextIndex].bUpdateCfg = HI_TRUE;

    return HI_SUCCESS;
}

/*虚拟VI使用*/
HI_S32 HI_DRV_VICAP_SetExtBuf(HI_HANDLE hVicap, HI_DRV_VICAP_BUF_ATTR_S *pstBufAttr)
{
    VICAP_CHECK_HVICAP(hVicap);
    VICAP_CHECK_NULL_PTR(pstBufAttr);
    return HI_SUCCESS;
}

/* 获取采集图像帧 */
HI_S32 HI_DRV_VICAP_AcquireFrame(HI_HANDLE hVicap, HI_DRV_VIDEO_FRAME_S *pFrameInfo)
{
    HI_U32  u32ContextIndex;
    VICAP_BUF_S stBuf;

    VICAP_CHECK_HVICAP(hVicap);
    u32ContextIndex = GETCONTEXTID(hVicap);
    /*Check 通路是否启动*/
    if(VICAP_STATUS_START != g_stVicapDrvCtx[u32ContextIndex].enStatus)
    {
        return HI_FAILURE;
    }

    if(HI_SUCCESS != VICAP_DRV_BufAcquire(g_stVicapDrvCtx[u32ContextIndex].hBufHandle,&stBuf))
    {
        HI_INFO_VICAP("AcquireFrame Failed\n");
        return HI_FAILURE;
    }
    
    memcpy(pFrameInfo, &stBuf.stVideoFrmInfo, sizeof(HI_DRV_VIDEO_FRAME_S));
    return HI_SUCCESS;
}

/* 释放采集图像帧 */
HI_S32 HI_DRV_VICAP_ReleaseFrame(HI_HANDLE hVicap, HI_DRV_VIDEO_FRAME_S *pFrameInfo)
{
    HI_U32  u32ContextIndex;
    VICAP_BUF_S stBuf;

    VICAP_CHECK_HVICAP(hVicap);
    u32ContextIndex = GETCONTEXTID(hVicap);

    memcpy(&stBuf.stVideoFrmInfo, pFrameInfo, sizeof(HI_DRV_VIDEO_FRAME_S));
    if(HI_SUCCESS != VICAP_DRV_BufRelease(g_stVicapDrvCtx[u32ContextIndex].hBufHandle,&stBuf))
    {
        HI_ERR_VICAP("ReleaseFrame Failed\n");
        return HI_FAILURE;
    } 
    return HI_SUCCESS;
}

/* 用户获取采集图像帧 */
HI_S32 HI_DRV_VICAP_UserAcquireFrame(HI_HANDLE hVicap, HI_DRV_VIDEO_FRAME_S *pFrameInfo, HI_U32 u32TimeoutMs)
{
    HI_U32  u32ContextIndex;    

    u32ContextIndex = GETCONTEXTID(hVicap);
    VICAP_CHECK_HVICAP(hVicap);

    if(VICAP_STATUS_START != g_stVicapDrvCtx[GETCONTEXTID(hVicap)].enStatus)
    {
        return HI_FAILURE;
    }
    
    if(HI_NULL == g_stVicapDrvCtx[GETCONTEXTID(hVicap)].pUfHandle)
    {
        return HI_FAILURE;
    }

    if(HI_SUCCESS != HI_DRV_UF_AcquireFrm(g_stVicapDrvCtx[u32ContextIndex].pUfHandle, pFrameInfo))
    {
        return HI_FAILURE;
    }  

    return HI_SUCCESS;
}

/* 用户释放采集图像帧 */
HI_S32 HI_DRV_VICAP_UserReleaseFrame(HI_HANDLE hVicap, HI_DRV_VIDEO_FRAME_S *pFrameInfo)
{
    HI_U32  u32ContextIndex;    

    u32ContextIndex = GETCONTEXTID(hVicap);
    VICAP_CHECK_HVICAP(hVicap);

    /*Check是否初始化UF模块*/
    if(NULL == g_stVicapDrvCtx[GETCONTEXTID(hVicap)].pUfHandle)
    {
        return HI_FAILURE;
    }
    /* 用户释放取采集图像帧 */
    if(HI_SUCCESS != HI_DRV_UF_ReleaseFrm(g_stVicapDrvCtx[u32ContextIndex].pUfHandle, pFrameInfo))
    {
        return HI_FAILURE;
    }    

    return HI_SUCCESS;
}

HI_S32 HI_DRV_VICAP_Stop(HI_HANDLE hVicap)
{
    HI_S32 s32Ret = 0;
    HI_U32 u32ContextIndex;
    unsigned long vicaplockflag;
    /*Check hVicap是否有效*/
    VICAP_CHECK_HVICAP(hVicap);
    u32ContextIndex = GETCONTEXTID(hVicap);

    /*判断是否已经为停止状态，已经为停止状态则直接返回成功*/
    VICAP_DRV_SPIN_LOCK(vicaplockflag);
    if(VICAP_STATUS_STOP == g_stVicapDrvCtx[u32ContextIndex].enStatus)
    {
        VICAP_DRV_SPIN_UNLOCK(vicaplockflag);
        HI_INFO_PRINT(HI_ID_VICAP,"This vicap is stop! \n");
        return HI_SUCCESS;
    }
    
    g_stVicapDrvCtx[u32ContextIndex].enStatus = VICAP_STATUS_STOPPING;
    VICAP_DRV_SPIN_UNLOCK(vicaplockflag);

    /*停止等待队列*/
    if(0 >= wait_event_timeout(g_stVicapDrvCtx[u32ContextIndex].stWaitQueue, 
        (g_stVicapDrvCtx[u32ContextIndex].enStatus == VICAP_STATUS_STOP), HZ/20))
    {
        HI_INFO_VICAP("Wait Event Wrong,Time Out!\n");
        VICAP_DRV_DisableChn(hVicap);

        if(g_stVicapDrvCtx[u32ContextIndex].stFrmStatus.b3D)
        {
            VICAP_HAL_SetRegNewer(VICAP_CHNINDEX0);
            VICAP_HAL_SetRegNewer(VICAP_CHNINDEX1);
        }
        else
        {
            VICAP_HAL_SetRegNewer(VICAP_DRV_GetChnIndex(hVicap));
        }
        g_stVicapDrvCtx[u32ContextIndex].enStatus = VICAP_STATUS_STOP;
    }
    
    /*设置Mask，屏蔽通道中断与通道*/
    VICAP_DRV_DisableChnMask(hVicap);

    /*释放this与next帧*/
    s32Ret = VICAP_DRV_PutFrmBuf(hVicap, &g_stVicapDrvCtx[u32ContextIndex].stThisFrm);
    HI_ASSERT(HI_SUCCESS == s32Ret);
    s32Ret = VICAP_DRV_PutFrmBuf(hVicap, &g_stVicapDrvCtx[u32ContextIndex].stNextFrm);
    HI_ASSERT(HI_SUCCESS == s32Ret);
       
    return HI_SUCCESS;
}

HI_S32 HI_DRV_VICAP_Destroy(HI_HANDLE hVicap)
{
    HI_U32 u32ContextIndex;
    HI_U32 u32UsingThisPtNum = 0;
    HI_U32 i;
    HI_S32 s32Ret = 0;

    VICAP_CHECK_HVICAP(hVicap);
    u32ContextIndex = GETCONTEXTID(hVicap);
    
    if(VICAP_STATUS_STOP != g_stVicapDrvCtx[u32ContextIndex].enStatus)
    {
        HI_INFO_VICAP("VICAP must be stop!\n");
        return HI_FAILURE;
    }

    for(i = 0; i < MAXVICAP; i++)
    {
        /*当前上下文跳过，遍历其它上下文，看其中是否在使用这个端口,有使用，u32UsingThisPtNum就加1 */
        if((i != u32ContextIndex) && (GETPHYPT(hVicap) == GETPHYPT(g_stVicapDrvCtx[i].hViCap)))
        {
            u32UsingThisPtNum++;
        }        
    }
    /*根据遍历的结果，选择是否关闭该端口*/
    if(0 == u32UsingThisPtNum)
    {
        VICAP_DRV_DisablePort(hVicap);
        VICAP_DRV_SetClkAndReset(hVicap, HI_FALSE);
    }
    else
    {
        VICAP_HAL_SetPpcReset(GETPHYCHN(hVicap),HI_TRUE);
        VICAP_HAL_SetPpcClken(GETPHYCHN(hVicap),HI_FALSE);
    }
    
    /* 去初始化UF模块 */
    if(g_stVicapDrvCtx[u32ContextIndex].pUfHandle != HI_NULL)
    {
        s32Ret = HI_DRV_UF_DeInit(g_stVicapDrvCtx[u32ContextIndex].pUfHandle);
        if (s32Ret != HI_SUCCESS)
        {
            HI_ERR_VICAP("Release Frame Failed\n");
            return HI_FAILURE;
        }

        g_stVicapDrvCtx[u32ContextIndex].pUfHandle = HI_NULL;
    }
    
    VICAP_DRV_BufDeInit(g_stVicapDrvCtx[u32ContextIndex].hBufHandle);    
    
    g_u32VicapCount--;
    /* 不存在VICAP通路时，关闭总线时钟 */
    if(0 >= g_u32VicapCount)
    {
        VICAP_HAL_SetBusClken(HI_FALSE);

        //去初始化寄存器
        VICAP_HAL_BoardDeInit();
    }

    memset(&g_stVicapDrvCtx[u32ContextIndex], 0, sizeof(VICAP_DRV_CTX_S));
    g_stVicapDrvCtx[u32ContextIndex].hViCap = HI_INVALID_HANDLE;
    g_stVicapDrvCtx[u32ContextIndex].pfUserCallBack = HI_NULL;
    VICAP_DRV_ProcDel(hVicap);

    return HI_SUCCESS;
}

HI_S32  HI_DRV_VICAP_RegistHook(HI_HANDLE hVicap, HI_HANDLE hDst, PFN_VICAP_CALLBACK pfVicapCallback)
{
    HI_U32 u32ContextIndex = 0;

    VICAP_CHECK_HVICAP(hVicap);
    u32ContextIndex = GETCONTEXTID(hVicap);
    g_stVicapDrvCtx[u32ContextIndex].pfUserCallBack = pfVicapCallback;
    g_stVicapDrvCtx[u32ContextIndex].hDst = hDst;

    return HI_SUCCESS;
}

HI_VOID HI_DRV_VICAP_DeInit(HI_VOID)
{ 
    HI_S32 i = 0;
    /* 关闭所有时钟门控 */
    VICAP_HAL_SetBusClken(HI_FALSE);
    VICAP_HAL_SetPpcClken(VICAP_PHYCHN_CHN0,HI_FALSE);
    VICAP_HAL_SetPpcClken(VICAP_PHYCHN_CHN1,HI_FALSE);
    VICAP_HAL_SetPtClken(VICAP_PHYPT_PT0,HI_FALSE);
    VICAP_HAL_SetPtClken(VICAP_PHYPT_PT1,HI_FALSE);
    
    /* 复位，总线不能复位 */
    VICAP_HAL_SetPpcReset(VICAP_PHYCHN_CHN0,HI_TRUE);
    VICAP_HAL_SetPpcReset(VICAP_PHYCHN_CHN1,HI_TRUE);
    VICAP_HAL_SetPtReset(VICAP_PHYPT_PT0,HI_TRUE);
    VICAP_HAL_SetPtReset(VICAP_PHYPT_PT1,HI_TRUE);

    //释放VI中断
    free_irq(VICAP_IRQ_NR, NULL); 

    /*初始化上下文*/
    for(i = 0; i < MAXVICAP; i++)
    {
       memset(&g_stVicapDrvCtx[i], 0, sizeof(VICAP_DRV_CTX_S));           
       g_stVicapDrvCtx[i].hViCap = HI_INVALID_HANDLE;
       g_stVicapDrvCtx[i].pfUserCallBack = HI_NULL;
    }
    memset(&g_stVicapExtFunc, 0, sizeof(VICAP_USED_EXT_FUNC_S));
    /* 初始化VICAP计数 */
    g_u32VicapCount = 0;
}
