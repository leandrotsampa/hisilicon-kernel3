/******************************************************************************
*
* Copyright (C) 2015 Hisilicon Technologies Co., Ltd.  All rights reserved. 
*
* This program is confidential and proprietary to Hisilicon  Technologies Co., Ltd. (Hisilicon), 
* and may not be copied, reproduced, modified, disclosed to others, published or used, in
* whole or in part, without the express prior written permission of Hisilicon.
*
******************************************************************************
File Name	    : jpeg_drv_api.c
Version		    : Initial Draft
Author		    : 
Created		    : 2015/01/25
Description	    :
Function List 	: 

			  		  
History       	:
Date				Author        		Modification
2015/01/25		    y00181162  		    Created file      	
******************************************************************************/

/*********************************add include here******************************/
#include "hi_jpeg_config.h"
#include "jpeg_drv_parse.h"
#include "hi_jpeg_drv_api.h"
#include "hi_jpeg_reg.h"
#include "jpeg_drv_hal.h"
#include "jpeg_drv_osr.h"

#ifdef HI_BUILD_IN_BOOT
#include "hi_reg_common.h"
#include "hi_go_common.h"
#endif

#ifdef HI_BUILD_IN_MINI_BOOT
#include "delay.h"
#endif


#ifdef CONFIG_JPEG_OMX_FUNCTION

/***************************** Macro Definition ******************************/


/*************************** Structure Definition ****************************/
#ifndef HI_BUILD_IN_BOOT
typedef struct tagJPEG_ATOMIC
{
   atomic_t OpenCount;
   atomic_t CreateCount;
}JPEG_ATOMIC;
#endif

/********************** Global Variable declaration **************************/
#ifdef HI_BUILD_IN_BOOT
/**
 **寄存器基地址
 **/
volatile HI_U32 *gs_pJpegRegBase = NULL;
#else
JPEG_ATOMIC gs_JpegAtomic;
#endif

/******************************* API forward declarations *******************/

/******************************* API realization *****************************/
/***************************************************************************
* func          : HI_DRV_JPEG_Open
* description   : open jpeg dev.
                  CNcomment: 打开jpeg设备 CNend\n
* retval        : HI_SUCCESS 成功
* retval        : HI_FAILURE 失败
* others:       : NA
****************************************************************************/
HI_VOID HI_DRV_JPEG_Open(HI_VOID)
{
#ifdef HI_BUILD_IN_BOOT
	volatile U_PERI_CRG31 unTempValue;
	unTempValue.u32 = g_pstRegCrg->PERI_CRG31.u32;
	unTempValue.bits.jpgd_cken     = 0x1;
	unTempValue.bits.jpgd_clk_sel  = 0x0;
	unTempValue.bits.jpgd_srst_req = 0x0;
	g_pstRegCrg->PERI_CRG31.u32 = unTempValue.u32;

	gs_pJpegRegBase = (HI_U32*)JPGD_REG_BASEADDR;
	JpgHalInit(gs_pJpegRegBase);
	JpgHalSetIntMask(0x0);
#else
	HI_S32 s32Cnt = 0;
	s32Cnt = atomic_read(&gs_JpegAtomic.OpenCount);
	atomic_inc(&gs_JpegAtomic.OpenCount);
	if(0 != s32Cnt){
		return;
	}
#endif
    return;
}

/***************************************************************************
* func          : HI_DRV_JPEG_Close
* description   : close jpeg dev.
                  CNcomment: 关闭jpeg设备 CNend\n
* others:       : NA
****************************************************************************/
HI_VOID HI_DRV_JPEG_Close(HI_VOID)
{
#ifdef HI_BUILD_IN_BOOT
	volatile U_PERI_CRG31 unTempValue;

	unTempValue.u32 = g_pstRegCrg->PERI_CRG31.u32;
	unTempValue.bits.jpgd_srst_req  = 0x1;
	g_pstRegCrg->PERI_CRG31.u32 = unTempValue.u32;

    #if 0
	while(*gs_pJpegRegBase & 0x2){	
	   /*nothing to do!*/
    }
    #else
    udelay(1000*20);
    #endif
	unTempValue.u32 = g_pstRegCrg->PERI_CRG31.u32;
	unTempValue.bits.jpgd_srst_req  = 0x0;
	unTempValue.bits.jpgd_cken      = 0x0;
	g_pstRegCrg->PERI_CRG31.u32 = unTempValue.u32;
#else
	HI_S32 s32Cnt  = 0;
	s32Cnt  = atomic_read(&gs_JpegAtomic.OpenCount);
	atomic_dec(&gs_JpegAtomic.OpenCount);
	if(1 != s32Cnt){
		return;
	}
#endif
    return;
}

/***************************************************************************
* func          : HI_DRV_JPEG_CreateDec
* description   : ctreate jpeg decoder.
                  CNcomment: 创建解码器 CNend\n
* param[in]     : *pu64DecHandle
* retval        : HI_SUCCESS 成功
* retval        : HI_FAILURE 失败
* others:       : NA
****************************************************************************/
HI_S32 HI_DRV_JPEG_CreateDec(HI_U64 *pu64DecHandle)
{
#ifdef HI_BUILD_IN_BOOT
	HI_U64 u64DecHandle = 0;

    u64DecHandle = (unsigned long)HI_GFX_Malloc(sizeof(IMAG_INFO_S),"jpeg-drv-handle");
    if(0 == u64DecHandle){
        return HI_FAILURE;
    }
    memset((HI_VOID*)(unsigned long)u64DecHandle,0,sizeof(IMAG_INFO_S));
    
    *pu64DecHandle = u64DecHandle;
#else
	HI_S32 s32Cnt = 0;
	s32Cnt = atomic_read(&gs_JpegAtomic.CreateCount);
	atomic_inc(&gs_JpegAtomic.CreateCount);
	if(0 != s32Cnt){
		return HI_SUCCESS;
	}
#endif
    return HI_SUCCESS;
}

/***************************************************************************
* func          : HI_DRV_JPEG_DecInfo
* description   : get jpeg input infomation.
                  CNcomment: 获取图片输入信息 CNend\n
* param[in]     : u64DecHandle
* param[in]     : *stInMsg
* retval        : HI_SUCCESS 成功
* retval        : HI_FAILURE 失败
* others:       : NA
****************************************************************************/
HI_S32 HI_DRV_JPEG_DecInfo(HI_U64 u64DecHandle,HI_DRV_JPEG_INMSG_S *stInMsg)
{
	HI_S32 s32Ret = HI_SUCCESS;
	if(NULL == stInMsg){
		return HI_FAILURE;
	}
	/**
     ** get device，can not decode next frame
     ** 获取设备，等待上一帧解码完成才能启动下一帧解码
     **/
	stInMsg->u64DecHandle = u64DecHandle;
	s32Ret = jpg_dec_parse(stInMsg);
    if(HI_SUCCESS != s32Ret){
        return HI_FAILURE;
    }
    jpeg_get_imginfo(stInMsg);
    
    return HI_SUCCESS;
}

/***************************************************************************
* func          : HI_DRV_JPEG_DecOutInfo
* description   : get jpeg output infomation.
                  CNcomment: 获取图片输出信息 CNend\n
* param[in]     : u64DecHandle
* param[in]     : *stOutMsg
* retval        : HI_SUCCESS 成功
* retval        : HI_FAILURE 失败
* others:       : NA
****************************************************************************/
HI_S32 HI_DRV_JPEG_DecOutInfo(HI_U64 u64DecHandle,HI_DRV_JPEG_OUTMSG_S *stOutMsg)
{
	HI_S32 s32Ret = HI_SUCCESS;
	if(NULL == stOutMsg){
		return HI_FAILURE;
	}
	stOutMsg->u64DecHandle = u64DecHandle;
	s32Ret = jpeg_get_sofn(stOutMsg);
    if(HI_SUCCESS != s32Ret){
        return HI_FAILURE;
    }
    
    return HI_SUCCESS;
}

/***************************************************************************
* func          : HI_DRV_JPEG_DecFrame
* description   : dec one frame.
                  CNcomment: 解码一帧图片 CNend\n
* param[in]     : u64DecHandle
* param[in]     : *pstDecInfo
* retval        : HI_SUCCESS 成功
* retval        : HI_FAILURE 失败
* others:       : NA
****************************************************************************/
HI_S32 HI_DRV_JPEG_DecFrame(HI_U64 u64DecHandle,HI_JPEG_DECINFO_S *pstDecInfo)
{
	HI_S32 s32Ret = HI_SUCCESS;
	if(NULL == pstDecInfo){
		return HI_FAILURE;
	}
	pstDecInfo->stInMsg.u64DecHandle  = u64DecHandle;
	pstDecInfo->stOutMsg.u64DecHandle = u64DecHandle;
    s32Ret = jpg_osr_dec(pstDecInfo);
    if(HI_SUCCESS != s32Ret){
        return HI_FAILURE;
    }
    /**
     ** release device，can decode next frame
     ** 释放设备可以启动下一帧解码
     **/
    return HI_SUCCESS;
}

/***************************************************************************
* func          : HI_DRV_JPEG_DestoryDec
* description   : destory decode.
                  CNcomment: 销毁解码器 CNend\n
* param[in]     : u64DecHandle
* retval        : HI_SUCCESS 成功
* retval        : HI_FAILURE 失败
* others:       : NA
****************************************************************************/
HI_VOID HI_DRV_JPEG_DestoryDec(HI_U64 u64DecHandle)
{
#ifdef HI_BUILD_IN_BOOT
    if(0 == u64DecHandle){
        return;
    }
    HI_GFX_Free((HI_CHAR*)(unsigned long)u64DecHandle);
#else
	HI_S32 s32Cnt  = 0;
	s32Cnt = atomic_read(&gs_JpegAtomic.CreateCount);
    atomic_dec(&gs_JpegAtomic.CreateCount);
	if(1 != s32Cnt){
		return;
	}
#endif
    return;
}

/***************************************************************************************
* func			: HI_DRV_JPEG_GetLuPixSum
* description	: get lu pix sum
				  CNcomment: 获取亮度值和 CNend\n
* param[in] 	: u64DecHandle
* retval		: HI_SUCCESS
* retval		: HI_FAILURE
* others:		: NA
***************************************************************************************/
HI_VOID HI_DRV_JPEG_GetLuPixSum(HI_U64 u64DecHandle,HI_U64* pu64LuPixValue)
{
	return;
}

/***************************************************************************************
* func			: 导出环境变量
* others:		: NA
***************************************************************************************/
	#ifndef HI_BUILD_IN_BOOT
		EXPORT_SYMBOL(HI_DRV_JPEG_Open);
		EXPORT_SYMBOL(HI_DRV_JPEG_Close);
		EXPORT_SYMBOL(HI_DRV_JPEG_CreateDec);
		EXPORT_SYMBOL(HI_DRV_JPEG_DecOutInfo);
		EXPORT_SYMBOL(HI_DRV_JPEG_DecFrame);
		EXPORT_SYMBOL(HI_DRV_JPEG_DestoryDec);
		EXPORT_SYMBOL(HI_DRV_JPEG_GetLuPixSum);
	#endif
#endif
