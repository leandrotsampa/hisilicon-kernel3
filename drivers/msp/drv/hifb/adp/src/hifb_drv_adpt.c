
/******************************************************************************

  Copyright (C), 2001-2011, Hisilicon Tech. Co., Ltd.

 ******************************************************************************
  File Name     : drv_hifb_adpt.c
  Version       : Initial Draft
  Author        : Hisilicon multimedia software group
  Created       : 2012/09/20
  Description   :
  History       :
  1.Date        : 
  Author        : 
  Modification  : Created file

*******************************************************************************/
#ifndef HI_BUILD_IN_BOOT
#include <linux/string.h>
#include <linux/fb.h>
#else
#include "hifb_debug.h"
#endif
#include "optm_hifb.h"
#include "hifb_drv.h"
#include "hifb_config.h"

static OPTM_GFX_OPS_S g_stGfxOps;



/***************************************************************************************
* func          : OPTM_GetGfxGpId
* description   : CNcomment: 根据图层ID获取GP ID CNend\n
* param[in]     : HI_VOID
* retval        : NA
* others:       : NA
***************************************************************************************/
OPTM_GFX_GP_E OPTM_GetGfxGpId(HIFB_LAYER_ID_E enLayerId)
{
	if(enLayerId <= HIFB_LAYER_HD_3)
	{
		return OPTM_GFX_GP_0;
	}
	else if(enLayerId >= HIFB_LAYER_SD_0 && enLayerId <= HIFB_LAYER_SD_1)
	{
		return OPTM_GFX_GP_1;
	}

	return OPTM_GFX_GP_BUTT;
}

/***************************************************************************************
* func          : HIFB_DRV_SetLayerKeyMask
* description   : CNcomment: 设置图层color key CNend\n
* param[in]     : HI_VOID
* retval        : NA
* others:       : NA
***************************************************************************************/
HI_S32 HIFB_DRV_SetLayerKeyMask(HIFB_LAYER_ID_E enLayerId, const HIFB_COLORKEYEX_S *pstColorkey)
{
   return g_stGfxOps.OPTM_GfxSetLayKeyMask(enLayerId, pstColorkey);
}
/***************************************************************************************
* func          : HIFB_DRV_EnableLayer
* description   : CNcomment: 图层使能 CNend\n
* param[in]     : HI_VOID
* retval        : NA
* others:       : NA
***************************************************************************************/
HI_S32 HIFB_DRV_EnableLayer(HIFB_LAYER_ID_E enLayerId, HI_BOOL bEnable)
{
    return g_stGfxOps.OPTM_GfxSetEnable(enLayerId, bEnable);;
}


/***************************************************************************************
* func			: HIFB_DRV_SetLayerAddr
* description	: CNcomment: 设置显示地址 CNend\n
* param[in] 	: HI_VOID
* retval		: NA
* others:		: NA
***************************************************************************************/
HI_S32 HIFB_DRV_SetLayerAddr(HIFB_LAYER_ID_E enLayerId, HI_U32 u32Addr)
{	
    return g_stGfxOps.OPTM_GfxSetLayerAddr(enLayerId, u32Addr);
}

/***************************************************************************************
* func			: HIFB_DRV_GetLayerAddr
* description	: CNcomment: 获取显示地址 CNend\n
* param[in] 	: HI_VOID
* retval		: NA
* others:		: NA
***************************************************************************************/
HI_S32 HIFB_DRV_GetLayerAddr(HIFB_LAYER_ID_E enLayerId,HI_U32 *pu32Addr)
{
    return g_stGfxOps.OPTM_GfxGetLayerAddr(enLayerId, pu32Addr);
}

/***************************************************************************************
* func			: HIFB_DRV_SetLayerStride
* description	: CNcomment: 设置图层行间距 CNend\n
* param[in] 	: HI_VOID
* retval		: NA
* others:		: NA
***************************************************************************************/
HI_S32 HIFB_DRV_SetLayerStride(HIFB_LAYER_ID_E enLayerId, HI_U32 u32Stride)
{
    return g_stGfxOps.OPTM_GfxSetLayerStride(enLayerId, u32Stride);
}

/***************************************************************************************
* func			: HIFB_DRV_SetLayerDataFmt
* description	: CNcomment: 设置图层像素格式 CNend\n
* param[in] 	: HI_VOID
* retval		: NA
* others:		: NA
***************************************************************************************/
HI_S32 HIFB_DRV_SetLayerDataFmt(HIFB_LAYER_ID_E enLayerId, HIFB_COLOR_FMT_E enDataFmt)
{
    if(enDataFmt >= HIFB_FMT_BUTT){
     	  return HI_FAILURE;
    }

    return g_stGfxOps.OPTM_GfxSetLayerDataFmt(enLayerId, enDataFmt);
}

HI_S32 HIFB_DRV_SetColorReg(HIFB_LAYER_ID_E enLayerId, HI_U32 u32OffSet, HI_U32 u32Color, HI_S32 UpFlag)
{
    if (u32OffSet > 255)
    {
        HIFB_ERROR("GFX color clut offset > 255.\n");
        return HI_FAILURE;
    }
    return g_stGfxOps.OPTM_GfxSetColorReg(enLayerId, u32OffSet, u32Color, UpFlag);
}

HI_S32 HIFB_DRV_WaitVBlank(HIFB_LAYER_ID_E enLayerId)
{
    return g_stGfxOps.OPTM_GfxWaitVBlank(enLayerId);
}

/***************************************************************************************
* func          : HIFB_DRV_SetLayerDeFlicker
* description   : CNcomment: 设置图层抗闪 CNend\n
* param[in]     : HI_VOID
* retval        : NA
* others:       : NA
***************************************************************************************/
HI_S32 HIFB_DRV_SetLayerDeFlicker(HIFB_LAYER_ID_E enLayerId, HIFB_DEFLICKER_S *pstDeFlicker)
{
    return g_stGfxOps.OPTM_GfxSetLayerDeFlicker(enLayerId, pstDeFlicker);
}

/***************************************************************************************
* func          : HIFB_DRV_SetLayerAlpha
* description   : CNcomment: 设置图层alpha的值 CNend\n
* param[in]     : HI_VOID
* retval        : NA
* others:       : NA
***************************************************************************************/
HI_S32 HIFB_DRV_SetLayerAlpha(HIFB_LAYER_ID_E enLayerId, HIFB_ALPHA_S *pstAlpha)
{
    return g_stGfxOps.OPTM_GfxSetLayerAlpha(enLayerId, pstAlpha);
}

/***************************************************************************************
* func          : HIFB_DRV_GetGPGalphaSum
* description   : CNcomment: 获取GP全局alpha值为0的像素点个数 CNend\n
* param[in]     : HI_VOID
* retval        : NA
* others:       : NA
***************************************************************************************/
HI_S32 HIFB_DRV_GetGPGalphaSum(HIFB_LAYER_ID_E enLayerId, HI_U32 *pu32GalphaSum)
{
    return g_stGfxOps.OPTM_GfxGetLayerGalphaSum(enLayerId, pu32GalphaSum);
}


HI_S32 HIFB_DRV_GetLayerInRect(HIFB_LAYER_ID_E enLayerId, HIFB_RECT *pstInputRect)
{
	 HI_S32 s32Ret;

	 s32Ret = HI_SUCCESS;
	 
	 if (HI_NULL != pstInputRect)
	 {
		 s32Ret |=	g_stGfxOps.OPTM_GfxGetLayerRect(enLayerId, pstInputRect);
	 } 

	 return s32Ret;
}

 /***************************************************************************************
 * func 		 : HIFB_DRV_SetLayerInRect
 * description	 : CNcomment: 设置图层输入矩形 CNend\n
 * param[in]	 : HI_VOID
 * retval		 : NA
 * others:		 : NA
 ***************************************************************************************/
 HI_S32 HIFB_DRV_SetLayerInRect(HIFB_LAYER_ID_E enLayerId, const HIFB_RECT *pstInputRect)
 {
	 HI_S32 s32Ret;
 
	 s32Ret = HI_SUCCESS;
	 
	 if (HI_NULL != pstInputRect)
	 {
		 s32Ret |=	g_stGfxOps.OPTM_GfxSetLayerRect(enLayerId, pstInputRect);
	 } 
 
	 return s32Ret;
 }

 HI_S32 HIFB_DRV_SetLayerOutRect(HIFB_LAYER_ID_E enLayerId, const HIFB_RECT *pstOutputRect)
{
	HI_S32 s32Ret;

	s32Ret = HI_SUCCESS;

	if (HI_NULL != pstOutputRect)
	{
		s32Ret |= g_stGfxOps.OPTM_GfxSetGpRect(OPTM_GetGfxGpId(enLayerId), pstOutputRect);	
	}	

	return s32Ret;
}

HI_S32 HIFB_DRV_SetLayerScreenSize(HIFB_LAYER_ID_E enLayerId, HI_U32 u32Width, HI_U32 u32Height)
{

	return g_stGfxOps.OPTM_GfxSetGpInPutSize(OPTM_GetGfxGpId(enLayerId), u32Width, u32Height);	
}

HI_S32 HIFB_DRV_GetLayerOutRect(HIFB_LAYER_ID_E enLayerId, HIFB_RECT *pstOutputRect)
{
	HI_S32 s32Ret;

	s32Ret = HI_SUCCESS;

	if (HI_NULL != pstOutputRect)
	{
		s32Ret |= g_stGfxOps.OPTM_GfxGetOutRect(enLayerId, pstOutputRect);	
	}	

	return s32Ret;
}

HI_S32 HIFB_DRV_GetDispSize(HIFB_LAYER_ID_E enLayerId, HIFB_RECT *pstOutputRect)
{
	HI_S32 s32Ret;

	s32Ret = HI_SUCCESS;

	if (HI_NULL != pstOutputRect)
	{
		s32Ret |= g_stGfxOps.OPTM_GfxGetDispFMTSize(OPTM_GetGfxGpId(enLayerId), pstOutputRect);	
	}	

	return s32Ret;
}


/***************************************************************************************
* func          : HIFB_DRV_SetTriDimMode
* description   : CNcomment: 设置3D模式 CNend\n
* param[in]     : HI_VOID
* retval        : NA
* others:       : NA
***************************************************************************************/
#ifdef CFG_HIFB_STEREO3D_HW_SUPPORT  
HI_S32 HIFB_DRV_SetTriDimMode(HI_U32 u32LayerId, HIFB_STEREO_MODE_E enStereoMode, HIFB_STEREO_MODE_E enWbcSteroMode)
{
	if( HIFB_STEREO_MONO == enStereoMode)
	{
		g_stGfxOps.OPTM_GfxSetTriDimEnable(u32LayerId, HI_FALSE);
	}
	else
	{
		g_stGfxOps.OPTM_GfxSetTriDimEnable(u32LayerId, HI_TRUE);
	}
	return g_stGfxOps.OPTM_GfxSetTriDimMode(u32LayerId, enStereoMode, enWbcSteroMode);
}

/***************************************************************************************
* func			: HIFB_DRV_SetTriDimAddr
* description	: CNcomment: 设置3D显示地址 CNend\n
* param[in] 	: HI_VOID
* retval		: NA
* others:		: NA
***************************************************************************************/
HI_S32 HIFB_DRV_SetTriDimAddr(HI_U32 u32LayerId, HI_U32 u32TriDimAddr)
{
	g_stGfxOps.OPTM_GfxSetTriDimAddr(u32LayerId, u32TriDimAddr);
	return HI_SUCCESS;
}
#endif


HI_S32 HIFB_DRV_ColorConvert(const struct fb_var_screeninfo *pstVar, HIFB_COLORKEYEX_S *pCkey)
{
    HI_U8 rOff, gOff, bOff;

    rOff = pstVar->red.length;
    gOff = pstVar->green.length;
    bOff = pstVar->blue.length;

    pCkey->u8RedMask = (0xff >> rOff);
    pCkey->u8GreenMask = (0xff >> gOff);
    pCkey->u8BlueMask  = (0xff >> bOff);

    return HI_SUCCESS;
}
//#endif
HI_S32 HIFB_DRV_UpdataLayerReg(HIFB_LAYER_ID_E enLayerId)
{
    return g_stGfxOps.OPTM_GfxUpLayerReg(enLayerId);
}


/***************************************************************************************
* func          : HIFB_DRV_SetLayerPreMult
* description   : CNcomment: 设置图层预乘 CNend\n
* param[in]     : HI_VOID
* retval        : NA
* others:       : NA
***************************************************************************************/
HI_S32 HIFB_DRV_SetLayerPreMult(HIFB_LAYER_ID_E enLayerId, HI_BOOL bEnable)
{
    return g_stGfxOps.OPTM_GfxSetLayerPreMult(enLayerId, bEnable);
}


HI_S32 HIFB_DRV_SetIntCallback(HIFB_CALLBACK_TPYE_E eCallbackType, IntCallBack pCallBack, HIFB_LAYER_ID_E enLayerId)
{
    return g_stGfxOps.OPTM_GfxSetCallback(enLayerId, pCallBack, eCallbackType);
}


/***************************************************************************************
* func          : HIFB_DRV_OpenLayer
* description   : CNcomment: 打开对应的图层 CNend\n
* param[in]     : HI_VOID
* retval        : NA
* others:       : NA
***************************************************************************************/
HI_S32 HIFB_DRV_OpenLayer(HIFB_LAYER_ID_E enLayerId)
{
    return g_stGfxOps.OPTM_GfxOpenLayer(enLayerId);
}

HI_VOID HIFB_DRV_GetOSDData(HIFB_LAYER_ID_E enLayerId, HIFB_OSD_DATA_S *pstLayerData)
{
	g_stGfxOps.OPTM_GfxGetOSDData(enLayerId, pstLayerData);
}


HI_S32 HIFB_DRV_CloseLayer(HIFB_LAYER_ID_E enLayerId)
{
    return g_stGfxOps.OPTM_GfxCloseLayer(enLayerId);
}


/***************************************************************************************
* func          : HIFB_DRV_GetDevOps
* description   : CNcomment: 获取adp设备上下文 CNend\n
* param[in]     : HI_VOID
* retval        : NA
* others:       : NA
***************************************************************************************/
HI_S32 HIFB_DRV_GfxInit(HI_VOID)
{
	OPTM_GFX_GetOps(&g_stGfxOps);
    return g_stGfxOps.OPTM_GfxInit();
}


/***************************************************************************************
* func          : HIFB_DRV_GfxDeInit
* description   : CNcomment: 图形设备去初始化 CNend\n
* param[in]     : HI_VOID
* retval        : NA
* others:       : NA
***************************************************************************************/
HI_S32 HIFB_DRV_GfxDeInit(HI_VOID)
{
    return g_stGfxOps.OPTM_GfxDeInit();
}

HI_S32 HIFB_DRV_SetLayerPriority(HIFB_LAYER_ID_E enLayerId, HIFB_ZORDER_E enZOrder)
{
	g_stGfxOps.OPTM_GfxSetLayerPriority(enLayerId, enZOrder);
    return HI_SUCCESS;
}

HI_S32 HIFB_DRV_GetLayerPriority(HIFB_LAYER_ID_E enLayerId, HI_U32 *pU32ZOrder)
{
	g_stGfxOps.OPTM_GfxGetLayerPriority(enLayerId, pU32ZOrder);
    return HI_SUCCESS;
}


HI_S32 HIFB_DRV_PauseCompression(HIFB_LAYER_ID_E enLayerId)
{
     return HI_SUCCESS;
}
HI_S32 HIFB_DRV_ResumeCompression(HIFB_LAYER_ID_E enLayerId)
{
     return HI_SUCCESS;
}

/***************************************************************************************
* func          : HIFB_DRV_GetGFXCap
* description   : CNcomment: 获取图层能力级 CNend\n
* param[in]     : HI_VOID
* retval        : NA
* others:       : NA
***************************************************************************************/
HI_VOID HIFB_DRV_GetGFXCap(const HIFB_CAPABILITY_S **pstCap)
{
	g_stGfxOps.OPTM_GFX_GetDevCap(pstCap);
}

HI_S32 HIFB_DRV_SetScreenFlag(HIFB_LAYER_ID_E enLayerId, HI_BOOL bFlag)
{
	g_stGfxOps.OPTM_GFX_SetGpInUsrFlag(OPTM_GetGfxGpId(enLayerId), bFlag);
	return HI_SUCCESS;
}

HI_S32 HIFB_DRV_GetScreenFlag(HIFB_LAYER_ID_E enLayerId)
{	
	return g_stGfxOps.OPTM_GFX_GetGpInUsrFlag(OPTM_GetGfxGpId(enLayerId));
}

HI_S32 HIFB_DRV_SetInitScreenFlag(HIFB_LAYER_ID_E enLayerId, HI_BOOL bFlag)
{
	g_stGfxOps.OPTM_GFX_SetGpInInitFlag(OPTM_GetGfxGpId(enLayerId), bFlag);
	return HI_SUCCESS;
}

HI_S32 HIFB_DRV_GetInitScreenFlag(HIFB_LAYER_ID_E enLayerId)
{	
	return g_stGfxOps.OPTM_GFX_GetGpInInitFlag(OPTM_GetGfxGpId(enLayerId));
}

HI_S32 HIFB_DRV_SetLayerMaskFlag(HIFB_LAYER_ID_E enLayerId, HI_BOOL bFlag)
{
	g_stGfxOps.OPTM_GFX_SetGPMask(OPTM_GetGfxGpId(enLayerId), bFlag);
	return HI_SUCCESS;
}

HI_S32 HIFB_DRV_GetLayerMaskFlag(HIFB_LAYER_ID_E enLayerId)
{	
	return g_stGfxOps.OPTM_GFX_GetGfxMask(OPTM_GetGfxGpId(enLayerId));
}

HI_S32 HIFB_DRV_ClearLogo(HIFB_LAYER_ID_E enLayerId)
{
	return g_stGfxOps.OPTM_GFX_ClearLogoOsd(enLayerId);
}

HI_S32 HIFB_DRV_SetStereoDepth(HIFB_LAYER_ID_E enLayerId, HI_S32 s32Depth)
{
	return g_stGfxOps.OPTM_GFX_SetStereoDepth(enLayerId, s32Depth);
}

HI_S32 HIFB_DRV_SetTCFlag(HI_BOOL bFlag)
{
	return g_stGfxOps.OPTM_GFX_SetTCFlag(bFlag);
}

HI_VOID HIFB_DRV_SetDeCmpSwitch(HIFB_LAYER_ID_E enLayerId, HI_BOOL bOpen)
{
#if defined(CFG_HI_FB_DECOMPRESS_SUPPORT) && !defined(HI_BUILD_IN_BOOT)
	if (bOpen){
		g_stGfxOps.OPTM_GFX_DECMP_Open(enLayerId);
	}else{
		g_stGfxOps.OPTM_GFX_DECMP_Close(enLayerId);
    }
#endif
}

HI_S32 HIFB_DRV_SetCmpSwitch(HIFB_LAYER_ID_E enLayerId, HI_BOOL bOpen)
{
	if (bOpen)
	{
		return g_stGfxOps.OPTM_GFX_CMP_Open(enLayerId);
	}
	else
	{
		return g_stGfxOps.OPTM_GFX_CMP_Close(enLayerId);
	}	
}

HI_S32 HIFB_DRV_GetCmpSwitch(HIFB_LAYER_ID_E enLayerId)
{
	return g_stGfxOps.OPTM_GFX_CMP_GetSwitch(enLayerId);
}

HI_S32 HIFB_DRV_SetCmpRect(HIFB_LAYER_ID_E enLayerId, HIFB_RECT *pstRect)
{
	return g_stGfxOps.OPTM_GFX_SetCmpRect(enLayerId, pstRect);
}

HI_S32 HIFB_DRV_SetCmpMode(HIFB_LAYER_ID_E enLayerId, HIFB_CMP_MODE_E enCMPMode)
{
	return g_stGfxOps.OPTM_GFX_SetCmpMode(enLayerId, enCMPMode);
}

HIFB_CMP_MODE_E HIFB_DRV_GetCmpMode(HIFB_LAYER_ID_E enLayerId)
{
	return g_stGfxOps.OPTM_GFX_GetCmpMode(enLayerId);
}

HI_S32 HIFB_DRV_SetCmpDDROpen(HIFB_LAYER_ID_E enLayerId, HI_BOOL bOpen)
{
	return g_stGfxOps.OPTM_GFX_SetCmpDDROpen(enLayerId, bOpen);
}
HI_S32 HIFB_DRV_SetGpDeflicker(HI_U32 u32DispChn, HI_BOOL bDeflicker)
{
    OPTM_GFX_GP_E enGpID;
    enGpID = u32DispChn ? OPTM_GFX_GP_0 : OPTM_GFX_GP_1;
    return g_stGfxOps.OPTM_GfxSetGpDeflicker(enGpID, bDeflicker);
}

HI_S32 HIFB_DRV_GetSlvLayerInfo(HIFB_SLVLAYER_DATA_S *pstLayerInfo)
{
    return g_stGfxOps.OPTM_GFX_GetSlvLayerInfo(pstLayerInfo);
}

HI_S32 HIFB_DRV_GetHaltDispStatus(HIFB_LAYER_ID_E enLayerId,HI_BOOL *pbDispInit)
{
	return g_stGfxOps.OPTM_GFX_GetHaltDispStatus(enLayerId, pbDispInit);
}

/***************************************************************************************
* func          : HIFB_DRV_GetDevOps
* description   : CNcomment: 获取设备上下文 CNend\n
* param[in]     : HI_VOID
* retval        : NA
* others:       : NA
***************************************************************************************/
HI_VOID HIFB_DRV_GetDevOps(HIFB_DRV_OPS_S    *Ops)
{
	Ops->HIFB_DRV_CloseLayer        = HIFB_DRV_CloseLayer;
	Ops->HIFB_DRV_ColorConvert      = HIFB_DRV_ColorConvert;
	Ops->HIFB_DRV_EnableLayer       = HIFB_DRV_EnableLayer;
	Ops->HIFB_DRV_GetGFXCap         = HIFB_DRV_GetGFXCap;
	Ops->HIFB_DRV_GetOSDData        = HIFB_DRV_GetOSDData;
	Ops->HIFB_DRV_GetLayerPriority  = HIFB_DRV_GetLayerPriority;
	Ops->HIFB_DRV_GfxDeInit         = HIFB_DRV_GfxDeInit;
	Ops->HIFB_DRV_GfxInit           = HIFB_DRV_GfxInit;
	Ops->HIFB_DRV_OpenLayer         = HIFB_DRV_OpenLayer;
	Ops->HIFB_DRV_PauseCompression  = HIFB_DRV_PauseCompression;
	Ops->HIFB_DRV_ResumeCompression = HIFB_DRV_ResumeCompression;
	Ops->HIFB_DRV_SetColorReg       = HIFB_DRV_SetColorReg;
#ifdef CFG_HIFB_STEREO3D_HW_SUPPORT    
	Ops->HIFB_DRV_SetTriDimMode     = HIFB_DRV_SetTriDimMode;
	Ops->HIFB_DRV_SetTriDimAddr     = HIFB_DRV_SetTriDimAddr;
#endif    
	Ops->HIFB_DRV_SetLayerAddr      = HIFB_DRV_SetLayerAddr;
	Ops->HIFB_DRV_GetLayerAddr      = HIFB_DRV_GetLayerAddr;
	Ops->HIFB_DRV_SetLayerAlpha     = HIFB_DRV_SetLayerAlpha;
    Ops->HIFB_DRV_GetGPGalphaSum    = HIFB_DRV_GetGPGalphaSum;
	Ops->HIFB_DRV_SetLayerDataFmt   = HIFB_DRV_SetLayerDataFmt;
	Ops->HIFB_DRV_SetLayerDeFlicker = HIFB_DRV_SetLayerDeFlicker;
	Ops->HIFB_DRV_SetLayerPriority  = HIFB_DRV_SetLayerPriority;
	Ops->HIFB_DRV_UpdataLayerReg    = HIFB_DRV_UpdataLayerReg;	
	Ops->HIFB_DRV_WaitVBlank        = HIFB_DRV_WaitVBlank;
	Ops->HIFB_DRV_SetLayerKeyMask   = HIFB_DRV_SetLayerKeyMask;
	Ops->HIFB_DRV_SetLayerPreMult   = HIFB_DRV_SetLayerPreMult;
	Ops->HIFB_DRV_SetIntCallback    = HIFB_DRV_SetIntCallback;
	Ops->HIFB_DRV_SetLayerStride    = HIFB_DRV_SetLayerStride;
	Ops->HIFB_DRV_SetLayerInRect    = HIFB_DRV_SetLayerInRect;
	Ops->HIFB_DRV_SetLayerOutRect   = HIFB_DRV_SetLayerOutRect;
	Ops->HIFB_DRV_GetLayerOutRect   = HIFB_DRV_GetLayerOutRect;
	Ops->HIFB_DRV_GetLayerInRect    = HIFB_DRV_GetLayerInRect;
	Ops->HIFB_DRV_SetLayerScreenSize = HIFB_DRV_SetLayerScreenSize;
	Ops->HIFB_DRV_SetScreenFlag     = HIFB_DRV_SetScreenFlag;
	Ops->HIFB_DRV_GetScreenFlag     = HIFB_DRV_GetScreenFlag;
	Ops->HIFB_DRV_SetInitScreenFlag = HIFB_DRV_SetInitScreenFlag;
	Ops->HIFB_DRV_GetInitScreenFlag = HIFB_DRV_GetInitScreenFlag;
	Ops->HIFB_DRV_SetLayerMaskFlag  = HIFB_DRV_SetLayerMaskFlag;
	Ops->HIFB_DRV_GetLayerMaskFlag  = HIFB_DRV_GetLayerMaskFlag;
    Ops->HIFB_DRV_GetDispSize       = HIFB_DRV_GetDispSize;
	Ops->HIFB_DRV_ClearLogo         = HIFB_DRV_ClearLogo;
	Ops->HIFB_DRV_SetStereoDepth    = HIFB_DRV_SetStereoDepth;
	Ops->HIFB_DRV_SetTCFlag         = HIFB_DRV_SetTCFlag;
    Ops->HIFB_DRV_SetDeCmpSwitch    = HIFB_DRV_SetDeCmpSwitch;
	Ops->HIFB_DRV_SetCmpSwitch      = HIFB_DRV_SetCmpSwitch;
	Ops->HIFB_DRV_GetCmpSwitch      = HIFB_DRV_GetCmpSwitch;
	Ops->HIFB_DRV_SetCmpRect        = HIFB_DRV_SetCmpRect;
	Ops->HIFB_DRV_SetCmpMode        = HIFB_DRV_SetCmpMode;
	Ops->HIFB_DRV_GetCmpMode        = HIFB_DRV_GetCmpMode;
	Ops->HIFB_DRV_SetCmpDDROpen     = HIFB_DRV_SetCmpDDROpen;
    Ops->HIFB_DRV_SetGpDeflicker    = HIFB_DRV_SetGpDeflicker;
	Ops->HIFB_DRV_GetSlvLayerInfo   = HIFB_DRV_GetSlvLayerInfo;
	Ops->HIFB_DRV_GetHaltDispStatus = HIFB_DRV_GetHaltDispStatus;
	return;
}
