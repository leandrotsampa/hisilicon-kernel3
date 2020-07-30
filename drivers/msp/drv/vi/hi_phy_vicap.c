/******************************************************************************

  Copyright (C), 2014-2014, Hisilicon Tech. Co., Ltd.

******************************************************************************
  File Name     : hi_phy_vicap.c
  Version       : Initial Draft
  Author        : Hisilicon multimedia software group
  Created       : 2014/05/15
  Description   :
  History       :
  1.Date        : 2014/05/15
    Author      : l00214567
    Modification: Created file
 *******************************************************************************/
#include <linux/kernel.h>
#include <linux/interrupt.h>
#include <asm/io.h>
     
#include "hi_drv_module.h"
#include "hi_error_mpi.h"

#include "drv_vi.h"
#include "hi_drv_vi.h"
#include "hi_drv_reg.h"
#include "drv_venc_ext.h"
#include "drv_vdec_ext.h"
#include "drv_vpss_ext.h"
#include "drv_win_ext.h"
#include "hi_reg_common.h"

#include "drv_vicap.h"
//#include "hi_drv_vicap.h"
#include "hi_common.h"
#include "hi_osal.h"
#include "hi_type.h"
#include "drv_vicap_buf.h"

#define VI_CHECK_NULL_PTR(ptr) \
    do {\
        if (NULL == ptr)\
        {\
            HI_ERR_VI("NULL point \r\n"); \
            return HI_ERR_VI_NULL_PTR; \
        } \
    } while (0)

HI_U32 u32Ufcnt = 0; /* 用户占用的buf数 */



HI_S32 HI_PHY_Transfer_FrameInfo(HI_UNF_VIDEO_FRAME_INFO_S *pstUnfFrm, HI_DRV_VIDEO_FRAME_S *pstDrvFrm,  HI_BOOL bUnf2Drv)
{
    VI_CHECK_NULL_PTR(pstUnfFrm);
    VI_CHECK_NULL_PTR(pstDrvFrm);
    
    if(HI_TRUE == bUnf2Drv)
    {
        memset(pstUnfFrm, 0, sizeof(HI_UNF_VIDEO_FRAME_INFO_S));

        pstUnfFrm->u32FrameIndex  = pstDrvFrm->u32FrameIndex;
        pstUnfFrm->stVideoFrameAddr[0].u32YAddr = pstDrvFrm->stBufAddr[0].u32PhyAddr_Y;
        pstUnfFrm->stVideoFrameAddr[0].u32YStride = pstDrvFrm->stBufAddr[0].u32Stride_Y;
        pstUnfFrm->stVideoFrameAddr[0].u32CAddr = pstDrvFrm->stBufAddr[0].u32PhyAddr_C;
        pstUnfFrm->stVideoFrameAddr[0].u32CStride = pstDrvFrm->stBufAddr[0].u32Stride_C;
        pstUnfFrm->stVideoFrameAddr[0].u32CrAddr = pstDrvFrm->stBufAddr[0].u32PhyAddr_Cr;
        pstUnfFrm->stVideoFrameAddr[0].u32CrStride = pstDrvFrm->stBufAddr[0].u32Stride_Cr;
        pstUnfFrm->stVideoFrameAddr[1].u32YAddr = pstDrvFrm->stBufAddr[1].u32PhyAddr_Y;
        pstUnfFrm->stVideoFrameAddr[1].u32YStride = pstDrvFrm->stBufAddr[1].u32Stride_Y;
        pstUnfFrm->stVideoFrameAddr[1].u32CAddr = pstDrvFrm->stBufAddr[1].u32PhyAddr_C;
        pstUnfFrm->stVideoFrameAddr[1].u32CStride = pstDrvFrm->stBufAddr[1].u32Stride_C;
        pstUnfFrm->stVideoFrameAddr[1].u32CrAddr = pstDrvFrm->stBufAddr[1].u32PhyAddr_Cr;
        pstUnfFrm->stVideoFrameAddr[1].u32CrStride = pstDrvFrm->stBufAddr[1].u32Stride_Cr;
        pstUnfFrm->u32Width = pstDrvFrm->u32Width;
        pstUnfFrm->u32Height = pstDrvFrm->u32Height;
        pstUnfFrm->u32SrcPts = pstDrvFrm->u32SrcPts;
        pstUnfFrm->u32Pts = pstDrvFrm->u32Pts;
        pstUnfFrm->u32AspectWidth = pstDrvFrm->u32AspectWidth;
        pstUnfFrm->u32AspectHeight = pstDrvFrm->u32AspectHeight;
        pstUnfFrm->stFrameRate.u32fpsInteger = pstDrvFrm->u32FrameRate / 1000 ;
        pstUnfFrm->stFrameRate.u32fpsDecimal = pstDrvFrm->u32FrameRate % 1000 ;
                                  

        switch ( pstDrvFrm->ePixFormat)
        {
        case HI_DRV_PIX_FMT_NV61_2X1:
            pstUnfFrm->enVideoFormat = HI_UNF_FORMAT_YUV_SEMIPLANAR_422;
            break;
        case HI_DRV_PIX_FMT_NV21:
            pstUnfFrm->enVideoFormat = HI_UNF_FORMAT_YUV_SEMIPLANAR_420;
            break;
        case HI_DRV_PIX_FMT_NV80:
            pstUnfFrm->enVideoFormat = HI_UNF_FORMAT_YUV_SEMIPLANAR_400;
            break;
        case HI_DRV_PIX_FMT_NV12_411:
            pstUnfFrm->enVideoFormat = HI_UNF_FORMAT_YUV_SEMIPLANAR_411;
            break;
        case HI_DRV_PIX_FMT_NV61:
            pstUnfFrm->enVideoFormat = HI_UNF_FORMAT_YUV_SEMIPLANAR_422_1X2;
            break;
        case HI_DRV_PIX_FMT_NV42:
            pstUnfFrm->enVideoFormat = HI_UNF_FORMAT_YUV_SEMIPLANAR_444;
            break;
        case HI_DRV_PIX_FMT_UYVY:
            pstUnfFrm->enVideoFormat = HI_UNF_FORMAT_YUV_PACKAGE_UYVY;
            break;
        case HI_DRV_PIX_FMT_YUYV:
            pstUnfFrm->enVideoFormat = HI_UNF_FORMAT_YUV_PACKAGE_YUYV;
            break;
        case HI_DRV_PIX_FMT_YVYU:
            pstUnfFrm->enVideoFormat = HI_UNF_FORMAT_YUV_PACKAGE_YVYU;
            break;
        case HI_DRV_PIX_FMT_YUV400:
            pstUnfFrm->enVideoFormat = HI_UNF_FORMAT_YUV_PLANAR_400;
            break;
        case HI_DRV_PIX_FMT_YUV411:
            pstUnfFrm->enVideoFormat = HI_UNF_FORMAT_YUV_PLANAR_411;
            break;
        case HI_DRV_PIX_FMT_YUV420p:
            pstUnfFrm->enVideoFormat = HI_UNF_FORMAT_YUV_PLANAR_420;
            break;
        case HI_DRV_PIX_FMT_YUV422_1X2:
            pstUnfFrm->enVideoFormat = HI_UNF_FORMAT_YUV_PLANAR_422_1X2;
            break;
        case HI_DRV_PIX_FMT_YUV422_2X1:
            pstUnfFrm->enVideoFormat = HI_UNF_FORMAT_YUV_PLANAR_422_2X1;
            break;
        case HI_DRV_PIX_FMT_YUV_444:
            pstUnfFrm->enVideoFormat = HI_UNF_FORMAT_YUV_PLANAR_444;
            break;
        case HI_DRV_PIX_FMT_YUV410p:
            pstUnfFrm->enVideoFormat = HI_UNF_FORMAT_YUV_PLANAR_410;
            break;
        default:
            pstUnfFrm->enVideoFormat = HI_UNF_FORMAT_YUV_BUTT;
            break;
        }

        pstUnfFrm->bProgressive = pstDrvFrm->bProgressive;

        switch (pstDrvFrm->enFieldMode)
        {
        case HI_DRV_FIELD_ALL:
            pstUnfFrm->enFieldMode = HI_UNF_VIDEO_FIELD_ALL;
            break;
        case HI_DRV_FIELD_TOP:
            pstUnfFrm->enFieldMode = HI_UNF_VIDEO_FIELD_TOP;
            break;
        case HI_DRV_FIELD_BOTTOM:
            pstUnfFrm->enFieldMode = HI_UNF_VIDEO_FIELD_BOTTOM;
            break;
        default:
            pstUnfFrm->enFieldMode = HI_UNF_VIDEO_FIELD_BUTT;
            break;
        }

        pstUnfFrm->bTopFieldFirst = pstDrvFrm->bTopFieldFirst;
        pstUnfFrm->u32DisplayHeight = pstDrvFrm->stDispRect.s32Height;
        pstUnfFrm->u32DisplayWidth = pstDrvFrm->stDispRect.s32Width;
        pstUnfFrm->u32DisplayCenterX = pstDrvFrm->stDispRect.s32X;
        pstUnfFrm->u32DisplayCenterY = pstDrvFrm->stDispRect.s32Y;
        
        switch (pstDrvFrm->eFrmType)
        {
        case HI_DRV_FT_NOT_STEREO:
            pstUnfFrm->enFramePackingType = HI_UNF_FRAME_PACKING_TYPE_NONE;
            break;
        case HI_DRV_FT_SBS:
            pstUnfFrm->enFramePackingType = HI_UNF_FRAME_PACKING_TYPE_SIDE_BY_SIDE;
            break;
        case HI_DRV_FT_TAB:
            pstUnfFrm->enFramePackingType = HI_UNF_FRAME_PACKING_TYPE_TOP_AND_BOTTOM;
            break;
        case HI_DRV_FT_FPK:
            pstUnfFrm->enFramePackingType = HI_UNF_FRAME_PACKING_TYPE_TIME_INTERLACED;
            break;
        case HI_DRV_FT_TILE:
            pstUnfFrm->enFramePackingType = HI_UNF_FRAME_PACKING_TYPE_FRAME_PACKING;
            break;
        default:
            pstUnfFrm->enFramePackingType = HI_UNF_FRAME_PACKING_TYPE_BUTT;
            break;
        }
        //pstUnfFrm->enFramePackingType = (HI_UNF_VIDEO_FRAME_PACKING_TYPE_E)pstDrvFrm->eFrmType;
        pstUnfFrm->u32Circumrotate = pstDrvFrm->u32Circumrotate;
        pstUnfFrm->bHorizontalMirror = pstDrvFrm->bToFlip_H;
        pstUnfFrm->bVerticalMirror = pstDrvFrm->bToFlip_V;
        pstUnfFrm->u32ErrorLevel = pstDrvFrm->u32ErrorLevel;
      
        memcpy(pstUnfFrm->u32Private, pstDrvFrm->u32Priv, sizeof(HI_U32) * 64);
    }
    else
    {

        memset(pstDrvFrm, 0, sizeof(HI_DRV_VIDEO_FRAME_S));

        pstDrvFrm->u32FrameIndex = pstUnfFrm->u32FrameIndex;
        pstDrvFrm->stBufAddr[0].u32PhyAddr_Y = pstUnfFrm->stVideoFrameAddr[0].u32YAddr;
        pstDrvFrm->stBufAddr[0].u32Stride_Y  = pstUnfFrm->stVideoFrameAddr[0].u32YStride;
        pstDrvFrm->stBufAddr[0].u32PhyAddr_C = pstUnfFrm->stVideoFrameAddr[0].u32CAddr;
        pstDrvFrm->stBufAddr[0].u32Stride_C   = pstUnfFrm->stVideoFrameAddr[0].u32CStride;
        pstDrvFrm->stBufAddr[0].u32PhyAddr_Cr = pstUnfFrm->stVideoFrameAddr[0].u32CrAddr;
        pstDrvFrm->stBufAddr[0].u32Stride_Cr  = pstUnfFrm->stVideoFrameAddr[0].u32CrStride;
        pstDrvFrm->stBufAddr[1].u32PhyAddr_Y  = pstUnfFrm->stVideoFrameAddr[1].u32YAddr;
        pstDrvFrm->stBufAddr[1].u32Stride_Y  = pstUnfFrm->stVideoFrameAddr[1].u32YStride;
        pstDrvFrm->stBufAddr[1].u32PhyAddr_C = pstUnfFrm->stVideoFrameAddr[1].u32CAddr;
        pstDrvFrm->stBufAddr[1].u32Stride_C   = pstUnfFrm->stVideoFrameAddr[1].u32CStride;
        pstDrvFrm->stBufAddr[1].u32PhyAddr_Cr = pstUnfFrm->stVideoFrameAddr[1].u32CrAddr;
        pstDrvFrm->stBufAddr[1].u32Stride_Cr  = pstUnfFrm->stVideoFrameAddr[1].u32CrStride;
        pstDrvFrm->u32Width  = pstUnfFrm->u32Width;
        pstDrvFrm->u32Height = pstUnfFrm->u32Height;
        pstDrvFrm->u32SrcPts = pstUnfFrm->u32SrcPts;
        pstDrvFrm->u32Pts = pstUnfFrm->u32Pts;
        pstDrvFrm->u32AspectWidth  = pstUnfFrm->u32AspectWidth;
        pstDrvFrm->u32AspectHeight = pstUnfFrm->u32AspectHeight;
        pstDrvFrm->u32FrameRate = pstUnfFrm->stFrameRate.u32fpsInteger * 1000 +
                                  pstUnfFrm->stFrameRate.u32fpsDecimal;

        switch (pstUnfFrm->enVideoFormat)
        {
        case HI_UNF_FORMAT_YUV_SEMIPLANAR_422:
            pstDrvFrm->ePixFormat = HI_DRV_PIX_FMT_NV61_2X1;
            break;
        case HI_UNF_FORMAT_YUV_SEMIPLANAR_420:
            pstDrvFrm->ePixFormat = HI_DRV_PIX_FMT_NV21;
            break;
        case HI_UNF_FORMAT_YUV_SEMIPLANAR_400:
            pstDrvFrm->ePixFormat = HI_DRV_PIX_FMT_NV80;
            break;
        case HI_UNF_FORMAT_YUV_SEMIPLANAR_411:
            pstDrvFrm->ePixFormat = HI_DRV_PIX_FMT_NV12_411;
            break;
        case HI_UNF_FORMAT_YUV_SEMIPLANAR_422_1X2:
            pstDrvFrm->ePixFormat = HI_DRV_PIX_FMT_NV61;
            break;
        case HI_UNF_FORMAT_YUV_SEMIPLANAR_444:
            pstDrvFrm->ePixFormat = HI_DRV_PIX_FMT_NV42;
            break;
        case HI_UNF_FORMAT_YUV_PACKAGE_UYVY:
            pstDrvFrm->ePixFormat = HI_DRV_PIX_FMT_UYVY;
            break;
        case HI_UNF_FORMAT_YUV_PACKAGE_YUYV:
            pstDrvFrm->ePixFormat = HI_DRV_PIX_FMT_YUYV;
            break;
        case HI_UNF_FORMAT_YUV_PACKAGE_YVYU:
            pstDrvFrm->ePixFormat = HI_DRV_PIX_FMT_YVYU;
            break;
        case HI_UNF_FORMAT_YUV_PLANAR_400:
            pstDrvFrm->ePixFormat = HI_DRV_PIX_FMT_YUV400;
            break;
        case HI_UNF_FORMAT_YUV_PLANAR_411:
            pstDrvFrm->ePixFormat = HI_DRV_PIX_FMT_YUV411;
            break;
        case HI_UNF_FORMAT_YUV_PLANAR_420:
            pstDrvFrm->ePixFormat = HI_DRV_PIX_FMT_YUV420p;
            break;
        case HI_UNF_FORMAT_YUV_PLANAR_422_1X2:
            pstDrvFrm->ePixFormat = HI_DRV_PIX_FMT_YUV422_1X2;
            break;
        case HI_UNF_FORMAT_YUV_PLANAR_422_2X1:
            pstDrvFrm->ePixFormat = HI_DRV_PIX_FMT_YUV422_2X1;
            break;
        case HI_UNF_FORMAT_YUV_PLANAR_444:
            pstDrvFrm->ePixFormat = HI_DRV_PIX_FMT_YUV_444;
            break;
        case HI_UNF_FORMAT_YUV_PLANAR_410:
            pstDrvFrm->ePixFormat = HI_DRV_PIX_FMT_YUV410p;
            break;
        default:
            pstDrvFrm->ePixFormat = HI_DRV_PIX_BUTT;
            break;
        }

        pstDrvFrm->bProgressive = pstUnfFrm->bProgressive;

        switch (pstUnfFrm->enFieldMode)
        {
        case HI_UNF_VIDEO_FIELD_ALL:
            pstDrvFrm->enFieldMode = HI_DRV_FIELD_ALL;
            break;
        case HI_UNF_VIDEO_FIELD_TOP:
            pstDrvFrm->enFieldMode = HI_DRV_FIELD_TOP;
            break;
        case HI_UNF_VIDEO_FIELD_BOTTOM:
            pstDrvFrm->enFieldMode = HI_DRV_FIELD_BOTTOM;
            break;
        default:
            pstDrvFrm->enFieldMode = HI_DRV_FIELD_BUTT;
            break;
        }

        pstDrvFrm->bTopFieldFirst = pstUnfFrm->bTopFieldFirst;
        pstDrvFrm->stDispRect.s32Height = pstUnfFrm->u32DisplayHeight;
        pstDrvFrm->stDispRect.s32Width = pstUnfFrm->u32DisplayWidth;
        pstDrvFrm->stDispRect.s32X = pstUnfFrm->u32DisplayCenterX;
        pstDrvFrm->stDispRect.s32Y = pstUnfFrm->u32DisplayCenterY;
        
        switch (pstUnfFrm->enFramePackingType)
        {
        case HI_UNF_FRAME_PACKING_TYPE_NONE :
            pstDrvFrm->eFrmType = HI_DRV_FT_NOT_STEREO;
            break;
        case HI_UNF_FRAME_PACKING_TYPE_SIDE_BY_SIDE:
            pstDrvFrm->eFrmType = HI_DRV_FT_SBS;
            break;
        case HI_UNF_FRAME_PACKING_TYPE_TOP_AND_BOTTOM:
            pstDrvFrm->eFrmType = HI_DRV_FT_TAB;
            break;
        case HI_UNF_FRAME_PACKING_TYPE_TIME_INTERLACED:
            pstDrvFrm->eFrmType = HI_DRV_FT_FPK;
            break;
        case HI_UNF_FRAME_PACKING_TYPE_FRAME_PACKING:
            pstDrvFrm->eFrmType = HI_DRV_FT_TILE;
            break;
        default:
            pstDrvFrm->eFrmType = HI_UNF_FRAME_PACKING_TYPE_BUTT;
            break;
        }
        //pstDrvFrm->eFrmType = (HI_DRV_FRAME_TYPE_E)pstUnfFrm->enFramePackingType;
        pstDrvFrm->u32Circumrotate = pstUnfFrm->u32Circumrotate;
        pstDrvFrm->bToFlip_H = pstUnfFrm->bHorizontalMirror;
        pstDrvFrm->bToFlip_V = pstUnfFrm->bVerticalMirror;
        pstDrvFrm->u32ErrorLevel = pstUnfFrm->u32ErrorLevel;

        memcpy(pstDrvFrm->u32Priv, pstUnfFrm->u32Private, sizeof(HI_U32) * 64);
    }
    
    return HI_SUCCESS;
}





HI_S32 HI_PHY_Transfer_Attr(const HI_UNF_VI_ATTR_S  *pstViAttr, HI_DRV_VICAP_ATTR_S *pstVicapAttr)
{
    if((HI_NULL == pstViAttr)||(HI_NULL == pstVicapAttr))
    {
        return HI_FAILURE;
    }
    
    memset(pstVicapAttr, 0, sizeof(HI_DRV_VICAP_ATTR_S));
    
    if(HI_UNF_VI_MODE_HDMIRX == pstViAttr->enInputMode)
    {
        pstVicapAttr->enAccess = HI_DRV_VICAP_ACCESS_HDMI;
    }
    else
    {
        return HI_FAILURE;
    }

    switch (pstViAttr->en3dFmt)
    {
    case HI_UNF_FRAME_PACKING_TYPE_NONE :
        pstVicapAttr->en3dFmt = HI_DRV_FT_NOT_STEREO;
        break;
    case HI_UNF_FRAME_PACKING_TYPE_SIDE_BY_SIDE:
        pstVicapAttr->en3dFmt = HI_DRV_FT_SBS;
        break;
    case HI_UNF_FRAME_PACKING_TYPE_TOP_AND_BOTTOM:
        pstVicapAttr->en3dFmt = HI_DRV_FT_TAB;
        break;
    case HI_UNF_FRAME_PACKING_TYPE_TIME_INTERLACED:
        pstVicapAttr->en3dFmt = HI_DRV_FT_FPK;
        break;
    case HI_UNF_FRAME_PACKING_TYPE_FRAME_PACKING:
        pstVicapAttr->en3dFmt = HI_DRV_FT_TILE;
        break;
    default:
        pstVicapAttr->en3dFmt = HI_UNF_FRAME_PACKING_TYPE_BUTT;
        break;
    }
    
    //pstVicapAttr->en3dFmt =(HI_DRV_FRAME_TYPE_E) pstViAttr->en3dFmt;
    pstVicapAttr->bInterlace = pstViAttr->bInterlace;
    pstVicapAttr->enIntfMode= HI_DRV_VICAP_INTF_FVHDE;
    pstVicapAttr->u32Width =  pstViAttr->u32Width;
    pstVicapAttr->u32Height=  pstViAttr->u32Height;
    pstVicapAttr->u32Vblank = pstViAttr->u32Vblank;
    pstVicapAttr->u32FrameRate = pstViAttr->u32FrameRate;
   // pstVicapAttr->enPixFmt = pstViAttr->enPixFmt;
    switch (pstViAttr->enPixFmt)
    {
    case HI_UNF_FORMAT_YUV_SEMIPLANAR_422:
        pstVicapAttr->enPixFmt = HI_DRV_PIX_FMT_NV61_2X1;
        break;
    case HI_UNF_FORMAT_YUV_SEMIPLANAR_420:
        pstVicapAttr->enPixFmt = HI_DRV_PIX_FMT_NV21;
        break;
    case HI_UNF_FORMAT_YUV_SEMIPLANAR_400:
        pstVicapAttr->enPixFmt = HI_DRV_PIX_FMT_NV80;
        break;
    case HI_UNF_FORMAT_YUV_SEMIPLANAR_411:
        pstVicapAttr->enPixFmt = HI_DRV_PIX_FMT_NV12_411;
        break;
    case HI_UNF_FORMAT_YUV_SEMIPLANAR_422_1X2:
        pstVicapAttr->enPixFmt = HI_DRV_PIX_FMT_NV61;
        break;
    case HI_UNF_FORMAT_YUV_SEMIPLANAR_444:
        pstVicapAttr->enPixFmt = HI_DRV_PIX_FMT_NV42;
        break;
    case HI_UNF_FORMAT_YUV_PACKAGE_UYVY:
        pstVicapAttr->enPixFmt = HI_DRV_PIX_FMT_UYVY;
        break;
    case HI_UNF_FORMAT_YUV_PACKAGE_YUYV:
        pstVicapAttr->enPixFmt = HI_DRV_PIX_FMT_YUYV;
        break;
    case HI_UNF_FORMAT_YUV_PACKAGE_YVYU:
        pstVicapAttr->enPixFmt = HI_DRV_PIX_FMT_YVYU;
        break;
    case HI_UNF_FORMAT_YUV_PLANAR_400:
        pstVicapAttr->enPixFmt = HI_DRV_PIX_FMT_YUV400;
        break;
    case HI_UNF_FORMAT_YUV_PLANAR_411:
        pstVicapAttr->enPixFmt = HI_DRV_PIX_FMT_YUV411;
        break;
    case HI_UNF_FORMAT_YUV_PLANAR_420:
        pstVicapAttr->enPixFmt = HI_DRV_PIX_FMT_YUV420p;
        break;
    case HI_UNF_FORMAT_YUV_PLANAR_422_1X2:
        pstVicapAttr->enPixFmt = HI_DRV_PIX_FMT_YUV422_1X2;
        break;
    case HI_UNF_FORMAT_YUV_PLANAR_422_2X1:
        pstVicapAttr->enPixFmt = HI_DRV_PIX_FMT_YUV422_2X1;
        break;
    case HI_UNF_FORMAT_YUV_PLANAR_444:
        pstVicapAttr->enPixFmt = HI_DRV_PIX_FMT_YUV_444;
        break;
    case HI_UNF_FORMAT_YUV_PLANAR_410:
        pstVicapAttr->enPixFmt = HI_DRV_PIX_FMT_YUV410p;
        break;
    case HI_UNF_FORMAT_RGB_SEMIPLANAR_444:
        pstVicapAttr->enPixFmt = HI_DRV_PIX_FMT_RGB444;
        break;
    default:
        pstVicapAttr->enPixFmt = HI_DRV_PIX_BUTT;
        break;
    }
    
    pstVicapAttr->enSrcBitWidth = pstViAttr->enSrcBitWidth;
    pstVicapAttr->enOverSample = pstViAttr->enOverSample;

    switch (pstViAttr->enColorSpace)
    {
    case HI_UNF_COLOR_SPACE_BT601_YUV_LIMITED:
        pstVicapAttr->enColorSpace = HI_DRV_CS_BT601_YUV_LIMITED;
        break;
    case HI_UNF_COLOR_SPACE_BT601_YUV_FULL:
        pstVicapAttr->enColorSpace = HI_DRV_CS_BT601_YUV_FULL;
        break;
    case HI_UNF_COLOR_SPACE_BT601_RGB_LIMITED:
        pstVicapAttr->enColorSpace = HI_DRV_CS_BT601_RGB_LIMITED;
        break;
    case HI_UNF_COLOR_SPACE_BT601_RGB_FULL:
        pstVicapAttr->enColorSpace = HI_DRV_CS_BT601_RGB_FULL;
        break;
    case HI_UNF_COLOR_SPACE_NTSC1953:
        pstVicapAttr->enColorSpace = HI_DRV_CS_NTSC1953;
        break;
    case HI_UNF_COLOR_SPACE_BT470_SYSTEM_M:
        pstVicapAttr->enColorSpace = HI_DRV_CS_BT470_SYSTEM_M;
        break;
    case HI_UNF_COLOR_SPACE_BT470_SYSTEM_BG:
        pstVicapAttr->enColorSpace = HI_DRV_CS_BT470_SYSTEM_BG;
         break;
    case HI_UNF_COLOR_SPACE_BT709_YUV_LIMITED:
        pstVicapAttr->enColorSpace = HI_DRV_CS_BT709_YUV_LIMITED;
        break;
    case HI_UNF_COLOR_SPACE_BT709_YUV_FULL:
        pstVicapAttr->enColorSpace = HI_DRV_CS_BT709_YUV_FULL;
        break;
    case HI_UNF_COLOR_SPACE_BT709_RGB_LIMITED:
        pstVicapAttr->enColorSpace = HI_DRV_CS_BT709_RGB_LIMITED;
        break;
    case HI_UNF_COLOR_SPACE_BT709_RGB_FULL:
        pstVicapAttr->enColorSpace = HI_DRV_CS_BT709_RGB_FULL;
        break;
    case HI_UNF_COLOR_SPACE_SMPT170M:
        pstVicapAttr->enColorSpace = HI_DRV_CS_SMPT170M;
        break;
    case HI_UNF_COLOR_SPACE_SMPT240M:
        pstVicapAttr->enColorSpace = HI_DRV_CS_SMPT240M;
        break;
    case HI_UNF_COLOR_SPACE_BT878:
        pstVicapAttr->enColorSpace = HI_DRV_CS_BT878;
        break;
    case HI_UNF_COLOR_SPACE_XVYCC:
        pstVicapAttr->enColorSpace = HI_DRV_CS_XVYCC;
        break;
    case HI_UNF_COLOR_SPACE_JPEG:
        pstVicapAttr->enColorSpace = HI_DRV_CS_JPEG;
        break;
    case HI_UNF_COLOR_SPACE_RGB:
        pstVicapAttr->enColorSpace = HI_DRV_CS_DEFAULT;
        break;
    default:
        pstVicapAttr->enColorSpace = HI_DRV_CS_BT709_YUV_LIMITED;
        break;
    }
    
    pstVicapAttr->enSourceType = HI_DRV_SOURCE_HDMI;
    pstVicapAttr->enColorSys = HI_DRV_COLOR_SYS_AUTO;
    
    pstVicapAttr->bGraphicMode = HI_TRUE;
    pstVicapAttr->enBufMgmtMode = (HI_DRV_VICAP_BUF_MGMT_E)pstViAttr->enBufMgmtMode;
    pstVicapAttr->u32BufNum = pstViAttr->u32BufNum;
    
    memcpy(&pstVicapAttr->stOutAttr.stCapRect, &pstViAttr->stInputRect, sizeof(HI_RECT_S));
    pstVicapAttr->stOutAttr.en3DT2DMode = (HI_DRV_VICAP_3DT2D_MODE_E)pstViAttr->enDst3DT2DMode;
    pstVicapAttr->stOutAttr.enDstBitWidth = pstViAttr->enDstBitWidth;
    pstVicapAttr->stOutAttr.u32DestWidth = pstViAttr->stInputRect.s32Width;
    pstVicapAttr->stOutAttr.u32DestHeight = pstViAttr->stInputRect.s32Height;
    if(HI_UNF_FORMAT_YUV_SEMIPLANAR_422 == pstViAttr->enVideoFormat)
    {
        pstVicapAttr->stOutAttr.enVideoFmt = HI_DRV_PIX_FMT_NV61_2X1;
    }
    else if(HI_UNF_FORMAT_YUV_SEMIPLANAR_420 == pstViAttr->enVideoFormat)
    {
        pstVicapAttr->stOutAttr.enVideoFmt = HI_DRV_PIX_FMT_NV21;
    }
    else if(HI_UNF_FORMAT_YUV_SEMIPLANAR_444 == pstViAttr->enVideoFormat)
    {
        pstVicapAttr->stOutAttr.enVideoFmt = HI_DRV_PIX_FMT_NV42;
    }
    else
    {
        return HI_FAILURE;
    }
    
    pstVicapAttr->stOutAttr.u32DstFrameRate = pstViAttr->u32FrameRate;
    pstVicapAttr->bUserOut = HI_TRUE;
    
    return HI_SUCCESS;

}

HI_S32  HI_PHY_VICAP_Init(HI_VOID)
{
    HI_S32 s32Ret = HI_FAILURE;
    u32Ufcnt = 0;

    s32Ret = HI_DRV_VICAP_Init();
    return s32Ret;
}

HI_VOID HI_PHY_VICAP_DeInit(HI_VOID)
{
    HI_DRV_VICAP_DeInit();
}

HI_S32  HI_PHY_VICAP_Destroy(HI_HANDLE hVicap)
{
    HI_S32 s32Ret = HI_FAILURE;

    s32Ret = HI_DRV_VICAP_Destroy(hVicap);
    if(HI_SUCCESS != s32Ret)
    {
        HI_ERR_VI("HI_DRV_VICAP_Destroy,  ret = 0x%08x\n\n",s32Ret);
        return s32Ret;
    }
    
    HI_DRV_VICAP_DeInit();
    return s32Ret;
}

HI_S32  HI_PHY_VICAP_Start(HI_HANDLE hVicap)
{
    HI_S32 s32Ret = HI_FAILURE;

    s32Ret = HI_DRV_VICAP_Start(hVicap);
    return s32Ret;
}

HI_S32  HI_PHY_VICAP_Stop(HI_HANDLE hVicap)
{
    HI_S32 s32Ret = HI_FAILURE;

    s32Ret = HI_DRV_VICAP_Stop(hVicap);
    return s32Ret;
}

HI_S32 HI_PHY_VICAP_Create(const HI_UNF_VI_ATTR_S *pstViAttr, HI_HANDLE *phVicap)
{
    HI_S32 s32Ret = HI_FAILURE;
    HI_DRV_VICAP_ATTR_S  stVicapAttr;
     
    if((HI_NULL == pstViAttr)||(HI_NULL == phVicap)||(HI_FALSE != pstViAttr->bVirtual))
    {
        HI_ERR_VI("Input parameter error!\n");
        return HI_FAILURE;
    }
    
    s32Ret = HI_DRV_VICAP_Init();
    if(HI_SUCCESS != s32Ret)
    {
        HI_ERR_VI("HI_DRV_VICAP_Init,  ret = 0x%08x\n\n",s32Ret);
        return s32Ret;
    }
    
    s32Ret = HI_PHY_Transfer_Attr(pstViAttr, &stVicapAttr);
    if(HI_SUCCESS != s32Ret)
    {
        HI_ERR_VI("HI_PHY_Transfer_Format  ret = 0x%08x\n\n",s32Ret);
        goto ERR0 ;
    }
    
    s32Ret = HI_DRV_VICAP_Create(&stVicapAttr, phVicap);
    if(HI_SUCCESS != s32Ret)
    {
        HI_ERR_VI("create vi failed,  ret = 0x%08x\n\n",s32Ret);
        goto ERR0 ;
    }

    return HI_SUCCESS;
    
ERR0:
    
    HI_DRV_VICAP_DeInit();
    
    return HI_FAILURE;
        
}

HI_S32  HI_PHY_VICAP_GetOutputAttr(HI_HANDLE hVicap, HI_UNF_VI_ATTR_S *pstViAttr)
{
    HI_S32 s32Ret = HI_FAILURE;

    HI_DRV_VICAP_OUTPUT_ATTR_S  stOutAttr;
    
    s32Ret = HI_DRV_VICAP_GetOutputAttr(hVicap, &stOutAttr);
    if(HI_SUCCESS != s32Ret)
    {
        HI_ERR_VI("HI_DRV_VICAP_GetOutputAttr,  ret = 0x%08x\n\n",s32Ret);
        return s32Ret;
    }

    memcpy(&pstViAttr->stInputRect, &stOutAttr.stCapRect, sizeof(HI_RECT_S));
    
    if(HI_DRV_PIX_FMT_NV12 == stOutAttr.enVideoFmt)
    {
        pstViAttr->enVideoFormat = HI_UNF_FORMAT_YUV_SEMIPLANAR_422;
    }
    else if(HI_DRV_PIX_FMT_NV16 == stOutAttr.enVideoFmt)
    {
        pstViAttr->enVideoFormat = HI_UNF_FORMAT_YUV_SEMIPLANAR_420;
    }
    else
    {
        return HI_FAILURE;
    }
    
   // stOutAttr.enDstBitWidth = HI_DRV_PIXEL_BITWIDTH_8BIT;
   // stOutAttr.u32DstFrameRate = 60;

   return HI_SUCCESS;
}
HI_S32  HI_PHY_VICAP_SetOutputAttr(HI_HANDLE hVicap, HI_UNF_VI_ATTR_S *pstViAttr)
{
    HI_S32 s32Ret = HI_FAILURE;

    HI_DRV_VICAP_OUTPUT_ATTR_S  stOutAttr = {0};
    
    memcpy(&stOutAttr.stCapRect, &pstViAttr->stInputRect, sizeof(HI_RECT_S));
    
    stOutAttr.enDstBitWidth = pstViAttr->enDstBitWidth;
    stOutAttr.u32DestWidth = pstViAttr->stInputRect.s32Width;
    stOutAttr.u32DestHeight = pstViAttr->stInputRect.s32Height;
    if(HI_UNF_FORMAT_YUV_SEMIPLANAR_422 == pstViAttr->enVideoFormat)
    {
        stOutAttr.enVideoFmt = HI_DRV_PIX_FMT_NV12;
    }
    else if(HI_UNF_FORMAT_YUV_SEMIPLANAR_420== pstViAttr->enVideoFormat)
    {
        stOutAttr.enVideoFmt = HI_DRV_PIX_FMT_NV16;
    }
    else
    {
        return HI_FAILURE;
    }
    
    stOutAttr.u32DstFrameRate = 60;
    
    s32Ret = HI_DRV_VICAP_SetOutputAttr(hVicap, &stOutAttr);
    if(HI_SUCCESS != s32Ret)
    {
        HI_ERR_VI("HI_DRV_VICAP_SetOutputAttr,  ret = 0x%08x\n\n",s32Ret);
        return s32Ret;
    }

    return HI_SUCCESS;
}

HI_S32  HI_PHY_VICAP_SetExtBuf(HI_HANDLE hVicap, HI_UNF_VI_BUFFER_ATTR_S *pstBufAttr)
{
    HI_S32 s32Ret = HI_FAILURE;

    s32Ret = HI_DRV_VICAP_SetExtBuf(hVicap, (HI_DRV_VICAP_BUF_ATTR_S*)pstBufAttr);
     if(HI_SUCCESS != s32Ret)
     {
         HI_ERR_VI("HI_DRV_VICAP_SetExtBuf,  ret = 0x%08x\n\n",s32Ret);
         return s32Ret;
     }
     return HI_SUCCESS;
}


/* 获取/释放采集图像帧 */
HI_S32  HI_PHY_VICAP_AcquireFrame(HI_HANDLE hVicap,  HI_DRV_VIDEO_FRAME_S *pFrameInfo)
{
    HI_S32 s32Ret = HI_FAILURE;

    s32Ret = HI_DRV_VICAP_AcquireFrame(hVicap, pFrameInfo);
     if(HI_SUCCESS != s32Ret)
     {
         HI_INFO_VI("HI_DRV_VICAP_AcquireFrame,  ret = 0x%08x\n\n",s32Ret);
         return s32Ret;
     }
     return HI_SUCCESS;
}

HI_S32  HI_PHY_VICAP_ReleaseFrame(HI_HANDLE hVicap,  HI_DRV_VIDEO_FRAME_S *pFrameInfo)
{
    HI_S32 s32Ret = HI_FAILURE;

    s32Ret = HI_DRV_VICAP_ReleaseFrame(hVicap, pFrameInfo);
    if(HI_SUCCESS != s32Ret)
    {
         HI_ERR_VI("HI_DRV_VICAP_ReleaseFrame,  ret = 0x%08x\n\n",s32Ret);
         return s32Ret;
    }
    return HI_SUCCESS;
}

/* 用户获取采集图像帧 */
HI_S32 HI_PHY_VICAP_UserAcquireFrame(HI_HANDLE hVicap,  HI_UNF_VIDEO_FRAME_INFO_S *pFrameInfo, HI_U32 u32TimeoutMs)
{
    HI_S32 s32Ret = HI_FAILURE;
    HI_DRV_VIDEO_FRAME_S stDrvFrm = {0};

    //s32Ret = HI_DRV_VICAP_UserAcquireFrame(hVicap, &stDrvFrm, u32TimeoutMs);
    s32Ret = HI_DRV_VICAP_AcquireFrame(hVicap, &stDrvFrm);
    if(HI_SUCCESS != s32Ret)
    {
        HI_INFO_VI("HI_DRV_VICAP_UserAcquireFrame,  ret = 0x%08x\n\n",s32Ret);
        return s32Ret;
    }

    s32Ret = HI_PHY_Transfer_FrameInfo(pFrameInfo, &stDrvFrm, HI_TRUE);
    if(HI_SUCCESS != s32Ret)
    {
        HI_ERR_VI("HI_PHY_Transfer_Format  ret = 0x%08x\n\n",s32Ret);
        return s32Ret;
    }
    u32Ufcnt++;
    return HI_SUCCESS;
}

/* 用户释放采集图像帧 */
HI_S32 HI_PHY_VICAP_UserReleaseFrame(HI_HANDLE hVicap,  HI_UNF_VIDEO_FRAME_INFO_S *pFrameInfo)
{
    HI_S32 s32Ret = HI_FAILURE;
    HI_DRV_VIDEO_FRAME_S stDrvFrm = {0};

    if(0 < u32Ufcnt)
    {
        u32Ufcnt--;
    }
    else
    {
        return HI_FAILURE;
    }
    
    s32Ret = HI_PHY_Transfer_FrameInfo(pFrameInfo, &stDrvFrm, HI_FALSE);
    if(HI_SUCCESS != s32Ret)
    {
        HI_ERR_VI("HI_PHY_Transfer_Format  ret = 0x%08x\n\n",s32Ret);
        return s32Ret;
    }

    //s32Ret = HI_DRV_VICAP_UserReleaseFrame(hVicap, &stDrvFrm);
    
    s32Ret = HI_DRV_VICAP_ReleaseFrame(hVicap, &stDrvFrm);
    if(HI_SUCCESS != s32Ret)
    {
        HI_ERR_VI("HI_DRV_VICAP_UserReleaseFrame,  ret = 0x%08x\n\n",s32Ret);
        return s32Ret;
    }
     return HI_SUCCESS;
}
 



