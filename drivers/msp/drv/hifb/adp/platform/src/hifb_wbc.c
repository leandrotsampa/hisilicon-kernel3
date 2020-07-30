/******************************************************************************
*
* Copyright (C) 2015 Hisilicon Technologies Co., Ltd.  All rights reserved. 
*
* This program is confidential and proprietary to Hisilicon  Technologies Co., Ltd. (Hisilicon), 
* and may not be copied, reproduced, modified, disclosed to others, published or used, in
* whole or in part, without the express prior written permission of Hisilicon.
*
******************************************************************************
File Name           : hifb_wbc.c
Version             : Initial Draft
Author              : 
Created             : 2015/06/15
Description         : 回写处理
Function List       : 
History             :
Date                       Author                   Modification
2015/06/15                y00181162                Created file        
******************************************************************************/


/*********************************add include here******************************/
#ifndef HI_BUILD_IN_BOOT
	#include <linux/string.h>
	#include <linux/fb.h>
	#include <linux/time.h>
	#include <linux/version.h>
	#include <linux/module.h>
	#include <linux/types.h>
	#include <linux/errno.h>
	#include <linux/fcntl.h>
	#include <linux/mm.h>
	#include <linux/miscdevice.h>
	#include <linux/proc_fs.h>
	#include <linux/fs.h>
	#include <linux/slab.h>
	#include <linux/init.h>
	#include <linux/delay.h>
	#include <asm/uaccess.h>
	#include <asm/io.h>
	#include <linux/interrupt.h>
	#include <linux/ioport.h>
	#include <linux/string.h>
	#include <linux/workqueue.h>
	#include "hi_module.h"
	#include "hi_drv_module.h"
#else
	#include "hifb_debug.h"
#endif

#include "drv_disp_ext.h"
#include "hifb_wbc.h"
#include "optm_hal.h"
#include "hifb_config.h"

/***************************** Macro Definition ******************************/
#define OPTM_GFX_WBC_WIDTH              (gs_bTcWbc2Flag? 1920 : 720)
#define OPTM_GFX_WBC_HEIGHT             (gs_bTcWbc2Flag? 1200 : 576)
#define OPTM_GFXDATA_DEFAULTBYTES       4

/*************************** Structure Definition ****************************/


/********************** Global Variable declaration **************************/
extern HIFB_GFX_MODE_EN        g_enOptmGfxWorkMode;
extern OPTM_GFX_GP_S           g_stGfxGPDevice[OPTM_GFX_GP_BUTT];
extern OPTM_GFX_LAYER_S        g_stGfxDevice[OPTM_MAX_LOGIC_HIFB_LAYER];
extern const HIFB_CAPABILITY_S g_stGfxCap[OPTM_MAX_LOGIC_HIFB_LAYER];

OPTM_GFX_WBC_S  g_stGfxWbc2;

static HI_BOOL  gs_bTcWbc2Flag            = HI_FALSE;
static HI_U32   g_u32Wbc2SlvLayerInitFlag = 0;

/******************************* API declaration *****************************/

/***************************************************************************************
* func          : HIFB_WBC2_SetRegUp
* description   : CNcomment:更新回写寄存器 CNend\n
* param[in]     : HI_VOID
* retval        : NA
* others:       : NA
***************************************************************************************/
HI_S32 HIFB_WBC2_SetRegUp(OPTM_VDP_LAYER_WBC_E enWbcID)
{
	/** 这个是控制开机logo的 **/
	OPTM_CheckGPMask_BYGPID(OPTM_GFX_GP_0);
    OPTM_VDP_WBC_SetRegUp(enWbcID);
    return HI_SUCCESS;
}

/***************************************************************************************
* func          : HIFB_WBC2_Open
* description   : CNcomment: open wbc
                             打开回写 CNend\n
* param[in]     : HI_VOID
* retval        : NA
* others:       : NA
***************************************************************************************/
static HI_S32 HIFB_WBC2_Open(HI_VOID)
{

	HI_S32 s32WbcSzie = 0;
	
    if(HI_TRUE == g_stGfxWbc2.bOpened){
        return HI_SUCCESS;
    }

	g_stGfxWbc2.u32BufIndex     = 0;
    g_stGfxWbc2.s32BufferWidth  = OPTM_GFX_WBC_WIDTH;
    g_stGfxWbc2.s32BufferHeight = OPTM_GFX_WBC_HEIGHT;
    g_stGfxWbc2.u32BufferStride = g_stGfxWbc2.s32BufferWidth * OPTM_GFXDATA_DEFAULTBYTES;
    s32WbcSzie = g_stGfxWbc2.u32BufferStride * g_stGfxWbc2.s32BufferHeight * OPTM_WBCBUFFER_NUM;
    
    if(g_stGfxWbc2.stFrameBuffer.pu8StartVirAddr == 0){
        if (OPTM_AllocAndMap(OPTM_GFX_WBC2_BUFFER,    \
			                 "iommu",                 \
                             s32WbcSzie,              \
                             0,                       \
                             &(g_stGfxWbc2.stFrameBuffer)) != 0){
            HIFB_ERROR("GFX Get wbc2 buffer failed!\n");
            return HI_FAILURE;
        }
    }
     
    if (1 == OPTM_WBCBUFFER_NUM){
        #ifdef CONFIG_GFX_MMU_SUPPORT
            g_stGfxWbc2.u32WBCBuffer[0] = g_stGfxWbc2.stFrameBuffer.u32StartSmmuAddr;
        #else
            g_stGfxWbc2.u32WBCBuffer[0] = g_stGfxWbc2.stFrameBuffer.u32StartPhyAddr;
        #endif
        g_stGfxWbc2.u32WriteBufAddr = g_stGfxWbc2.u32WBCBuffer[0];
        g_stGfxWbc2.u32ReadBufAddr  = g_stGfxWbc2.u32WBCBuffer[0];
    }else if (2 == OPTM_WBCBUFFER_NUM){
        #ifdef CONFIG_GFX_MMU_SUPPORT
            g_stGfxWbc2.u32WBCBuffer[0] = g_stGfxWbc2.stFrameBuffer.u32StartSmmuAddr;
        #else
            g_stGfxWbc2.u32WBCBuffer[0] = g_stGfxWbc2.stFrameBuffer.u32StartPhyAddr;
        #endif
        g_stGfxWbc2.u32WBCBuffer[1] = g_stGfxWbc2.u32WBCBuffer[0] + g_stGfxWbc2.u32BufferStride * g_stGfxWbc2.s32BufferHeight;
		g_stGfxWbc2.u32WriteBufAddr = g_stGfxWbc2.u32WBCBuffer[0];
        g_stGfxWbc2.u32ReadBufAddr  = g_stGfxWbc2.u32WBCBuffer[1];
    }else{
        HIFB_ERROR("Allocate wbc buffer failure!\n");
        return HI_FAILURE;
    }

#ifndef HI_BUILD_IN_BOOT
    memset(g_stGfxWbc2.stFrameBuffer.pu8StartVirAddr, 0, s32WbcSzie);
#endif

    g_stGfxWbc2.enWbcHalId   = OPTM_VDP_LAYER_WBC_GP0;
    g_stGfxWbc2.u32DataPoint = 0;
    g_stGfxWbc2.enDataFmt    = HIFB_FMT_AYUV8888;
    g_stGfxWbc2.enDitherMode = VDP_DITHER_TMP_SPA_8;
    g_stGfxWbc2.stWBCFmt     = VDP_WBC_OFMT_ARGB8888;
    g_stGfxWbc2.enReadMode   = VDP_RMODE_PROGRESSIVE;
	/**
	 ** 输出用逐行更新，否则会突然出现标清回写没有数据
	 ** 要不然隔行的时候回写要更新两次
	 **/
	g_stGfxWbc2.enOutMode    = VDP_RMODE_PROGRESSIVE;
    g_stGfxWbc2.enWbcMode    = OPTM_WBC_MODE_MONO;
    g_stGfxWbc2.enWbcInt     = OPTM_VDP_INTMSK_WBC_GP0_INT;
	g_stGfxWbc2.bOpened      = HI_TRUE;
    g_stGfxWbc2.bWorking     = HI_FALSE;

    OPTM_VDP_WBC_SetThreeMd    (g_stGfxWbc2.enWbcHalId, g_stGfxWbc2.enWbcMode);
    OPTM_VDP_WBC_SetDitherMode (g_stGfxWbc2.enWbcHalId, g_stGfxWbc2.enDitherMode);
    OPTM_VDP_WBC_SetOutFmt     (g_stGfxWbc2.enWbcHalId, g_stGfxWbc2.stWBCFmt);
    OPTM_VDP_WBC_SetOutIntf    (g_stGfxWbc2.enWbcHalId, g_stGfxWbc2.enOutMode);
    OPTM_VDP_WBC_SetLayerAddr  (g_stGfxWbc2.enWbcHalId, g_stGfxWbc2.u32WriteBufAddr, 0x0, g_stGfxWbc2.u32BufferStride, 0x0);
	HIFB_WBC2_SetRegUp         (g_stGfxWbc2.enWbcHalId);
		
    return HI_SUCCESS;
}

/***************************************************************************************
* func          : HIFB_WBC2_CloseSlvLayer
* description   : CNcomment: 同源回写的情况下关闭标清图层 CNend\n
* param[in]     : HI_VOID
* retval        : NA
* others:       : NA
***************************************************************************************/
HI_S32 HIFB_WBC2_CloseSlvLayer(HIFB_LAYER_ID_E enLayerId)
{

    HI_S32  s32Ret = HI_SUCCESS;
    
#ifndef HI_BUILD_IN_BOOT
	OPTM_GFX_GP_E enGPId = g_stGfxDevice[enLayerId].enGPId;
#endif

    if (HI_FALSE == g_u32Wbc2SlvLayerInitFlag){
        return HI_SUCCESS;
    }

    OPTM_VDP_GFX_SetLayerEnable  (g_stGfxDevice[enLayerId].enGfxHalId, HI_FALSE);
    OPTM_VDP_GFX_SetRegUp        (g_stGfxDevice[enLayerId].enGfxHalId);
    OPTM_VDP_WBC_SetEnable       (g_stGfxWbc2.enWbcHalId,HI_FALSE);
	HIFB_WBC2_SetEnable          (HI_FALSE);

#ifndef HI_BUILD_IN_BOOT
    s32Ret = OPTM_SetCallbackToDisp(enGPId, (IntCallBack)OPTM_DispCallBack, HI_DRV_DISP_C_INTPOS_90_PERCENT, HI_FALSE);
#endif
    s32Ret |= OPTM_GFX_ReleaseClutBuf(enLayerId);
    
    g_stGfxDevice[enLayerId].bExtractLine = HI_FALSE;
    g_stGfxDevice[enLayerId].bOpened      = HI_FALSE;
    g_stGfxWbc2.bOpened                   = HI_FALSE;
    g_u32Wbc2SlvLayerInitFlag             = HI_FALSE;

    return s32Ret;
}
/***************************************************************************************
* func          : HIFB_WBC2_OpenSlvLayer
* description   : CNcomment: 同源回写的情况下打开回写标清图层，并配置相关标清层的
                             相关参数 CNend\n
* param[in]     : HI_VOID
* retval        : NA
* others:       : NA
***************************************************************************************/
HI_VOID HIFB_WBC2_OpenSlvLayer(HIFB_LAYER_ID_E enLayerId)
{
    HI_S32  s32Ret       = HI_SUCCESS;
	OPTM_GFX_GP_E enGPId = OPTM_GFX_GP_1;

    if(HI_TRUE == g_u32Wbc2SlvLayerInitFlag){
        return;
    }
    if(HIFB_GFX_MODE_NORMAL == g_enOptmGfxWorkMode){
        return;
    }

    s32Ret = HIFB_WBC2_Open();
    if(HI_SUCCESS != s32Ret){
        HIFB_ERROR("Fail to open Wbc2!\n");
        goto ERR;
    }

	/**===============================================================
	 **回写图层和GP1操作
	 **=============================================================**/
    OPTM_GfxInitLayer(enLayerId);

    g_stGfxDevice[enLayerId].enReadMode = VDP_RMODE_PROGRESSIVE;
	g_stGfxDevice[enLayerId].bCmpOpened = HI_FALSE;
	
	OPTM_GfxSetLayerReadMode      (enLayerId, g_stGfxDevice[enLayerId].enReadMode);
    OPTM_VDP_GFX_SetPalpha        (g_stGfxDevice[enLayerId].enGfxHalId, HI_TRUE,HI_TRUE,0xff,0xff);
    OPTM_VDP_GFX_SetPreMultEnable (g_stGfxDevice[enLayerId].enGfxHalId, HI_TRUE);
    /** 这里不启动回写显示，所以不更新，不使能，否则地址切换影响logo过渡 **/
    OPTM_GfxSetLayerStride        (enLayerId, g_stGfxWbc2.u32BufferStride);
    OPTM_GfxSetLayerAddr          (enLayerId, g_stGfxWbc2.u32ReadBufAddr);
    
	/**
	 ** 标清通道打开GP1
	 **/
	enGPId = g_stGfxDevice[enLayerId].enGPId;
    s32Ret = OPTM_GPOpen(enGPId);
    if(HI_SUCCESS != s32Ret){
        return;
    }

#ifndef HI_BUILD_IN_BOOT
    s32Ret = OPTM_SetCallbackToDisp(enGPId, (IntCallBack)OPTM_DispCallBack, HI_DRV_DISP_C_INTPOS_90_PERCENT, HI_TRUE);
    if(HI_SUCCESS != s32Ret){
        HIFB_ERROR("unable to register to disp for slv layer!\n");
        goto ERR;
    }
#endif

    if(g_stGfxCap[enLayerId].bHasCmapReg != HI_FALSE){
        HI_CHAR name[32];
        snprintf(name, sizeof(name), "HIFB_Fb%d_Clut", enLayerId);
        if(OPTM_Adapt_AllocAndMap(name, NULL, OPTM_CMAP_SIZE, 0, &g_stGfxDevice[enLayerId].stCluptTable) != HI_SUCCESS){
            HIFB_ERROR("GFX Get clut buffer failed!\n");
            goto ERR;
        }
        OPTM_VDP_GFX_SetLutAddr(g_stGfxDevice[enLayerId].enGfxHalId, g_stGfxDevice[enLayerId].stCluptTable.u32StartPhyAddr);
    }
    g_stGfxDevice[enLayerId].bOpened  = HI_TRUE;
    g_u32Wbc2SlvLayerInitFlag         = HI_TRUE;
    /**
     ** maybe master layer was closed, when we starting work queue to open slv layer
     **/
    if(HIFB_GFX_MODE_NORMAL == g_enOptmGfxWorkMode){
        goto ERR;
    }
    return;

ERR:
    HIFB_WBC2_CloseSlvLayer(enLayerId);
    g_stGfxDevice[enLayerId].bOpened  = HI_FALSE;
    g_u32Wbc2SlvLayerInitFlag         = HI_FALSE;
	
    return;
}

/***************************************************************************************
* func          : HIFB_WBC2_WorkQueue
* description   : CNcomment: init work at OPTM_GPOpen function
                             同源回写工作对列, 在GP打开函数中初始化 CNend\n
* param[in]     : HI_VOID
* retval        : NA
* others:       : NA
***************************************************************************************/
#ifndef HI_BUILD_IN_BOOT
HI_VOID HIFB_WBC2_WorkQueue(struct work_struct *data)
{
    HIFB_LAYER_ID_E u32LayerID = HIFB_LAYER_ID_BUTT;
    OPTM_GFX_WORK_S *pstOpenSlvWork = container_of(data, OPTM_GFX_WORK_S, work);
    u32LayerID = (HIFB_LAYER_ID_E)(pstOpenSlvWork->u32Data);
    HIFB_WBC2_OpenSlvLayer(u32LayerID);
    return;
}
#endif


/***************************************************************************************
* func          : HIFB_WBC2_SetTcFlag
* description   : CNcomment: 设置TC回写标记 CNend\n
* param[in]     : HI_VOID
* retval        : NA
* others:       : NA
***************************************************************************************/
HI_VOID HIFB_WBC2_SetTcFlag(HI_BOOL bFlag)
{
	gs_bTcWbc2Flag = bFlag;
}


/***************************************************************************************
* func          : HIFB_WBC2_SetCropReso
* description   : CNcomment: 设置WBC_GP0裁剪分辨率，也就输入的起始和结束坐标 CNend\n
* param[in]     : HI_VOID
* retval        : NA
* others:       : NA
***************************************************************************************/
HI_VOID HIFB_WBC2_SetCropReso(OPTM_VDP_DISP_RECT_S stInputRect)
{
	OPTM_VDP_DISP_RECT_S stWbcRect = {0};

	stWbcRect.u32DXL = stInputRect.u32IWth;
    stWbcRect.u32DYL = stInputRect.u32IHgt;

    #ifdef GFX_CONFIG_WBC_GP0_PRE_ZME_EN
		/**
	 	 **预缩放的输出
	 	 **/
		if( (stWbcRect.u32DXL >= 3840) && (stWbcRect.u32DYL >= 2160)){
			stWbcRect.u32DXL /= 2;
		}
	#endif
	
    OPTM_VDP_WBC_SetCropReso (g_stGfxWbc2.enWbcHalId, stWbcRect);
	
}

/***************************************************************************************
* func          : HIFB_WBC2_SetPreZmeEn
* description   : CNcomment: 设置ZME使能 CNend\n
* param[in]     : HI_VOID
* retval        : NA
* others:       : NA
***************************************************************************************/
HI_VOID HIFB_WBC2_SetPreZmeEn(OPTM_ALG_GZME_DRV_PARA_S *pstZmeDrvPara)
{
#ifdef GFX_CONFIG_WBC_GP0_PRE_ZME_EN
	 if( (pstZmeDrvPara->u32ZmeFrmWIn >= 3840) && (pstZmeDrvPara->u32ZmeFrmHIn >= 2160)){
		pstZmeDrvPara->u32ZmeFrmWIn = pstZmeDrvPara->u32ZmeFrmWIn / 2;
	    OPTM_VDP_WBC_SetPreZmeEnable(OPTM_VDP_LAYER_WBC_GP0,HI_TRUE);
	  }else{
		OPTM_VDP_WBC_SetPreZmeEnable(OPTM_VDP_LAYER_WBC_GP0,HI_FALSE);
	  }
#endif
}

/***************************************************************************************
* func          : HIFB_WBC2_Init
* description   : wbc initial
                  CNcomment: 回写初始化 CNend\n
* param[in]     : 
* retval        : NA
* others:       : NA
***************************************************************************************/
HI_VOID HIFB_WBC2_Init(HI_VOID)
{
	memset(&g_stGfxWbc2, 0, sizeof(OPTM_GFX_WBC_S));
}

/***************************************************************************************
* func          : HIFB_WBC2_Dinit
* description   : wbc initial
                  CNcomment: 回写去初始化 CNend\n
* param[in]     : 
* retval        : NA
* others:       : NA
***************************************************************************************/
HI_VOID HIFB_WBC2_Dinit(HI_VOID)
{
	if(NULL != g_stGfxWbc2.stFrameBuffer.pu8StartVirAddr){
        OPTM_UnmapAndRelease(&(g_stGfxWbc2.stFrameBuffer));
        g_stGfxWbc2.stFrameBuffer.pu8StartVirAddr  = NULL;
        g_stGfxWbc2.stFrameBuffer.u32StartPhyAddr  = 0;
        g_stGfxWbc2.stFrameBuffer.u32StartSmmuAddr = 0;
        g_stGfxWbc2.stFrameBuffer.u32Size          = 0;
        g_stGfxWbc2.stFrameBuffer.bSmmu            = HI_FALSE;
    }
}

/***************************************************************************************
* func          : HIFB_WBC2_JudgeEnable
* description   : CNcomment: 在同源回写模式下，判断是否有高清设备使能，要是有的话
							 说明同源回写使用的图层(SD0)已经打开。CNend\n
* param[in]     : HI_VOID
* retval        : NA
* others:       : NA
***************************************************************************************/
static HI_S32 HIFB_WBC2_JudgeEnable(HI_VOID)
{
    HI_U32 i = 0;
    for (i = 0; i < HIFB_LAYER_SD_0; i++){
        if(g_stGfxDevice[i].bEnable){
            return HI_TRUE;
        }
    }
    return HI_FALSE;
}
/***************************************************************************************
* func          : HIFB_WBC2_SetEnable
* description   : CNcomment: 设置回写使能状态 CNend\n
* param[in]     : HI_VOID
* retval        : NA
* others:       : NA
***************************************************************************************/
HI_VOID HIFB_WBC2_SetEnable(HI_BOOL bEnable)
{
    if (bEnable){
        g_stGfxDevice[OPTM_SLAVER_LAYERID].bEnable = HI_TRUE;
    }else{
        g_stGfxDevice[OPTM_SLAVER_LAYERID].bEnable = HIFB_WBC2_JudgeEnable();
    }
    g_stGfxGPDevice[OPTM_SLAVER_GPID].unUpFlag.bits.Enable = 1;
    g_stGfxGPDevice[OPTM_SLAVER_GPID].unUpFlag.bits.RegUp  = 1;
    
 	return;
}

/***************************************************************************************
* func          : HIFB_WBC2_CfgSlvLayer
* description   : CNcomment: 配置标清图层 CNend\n
* param[in]     : HI_VOID
* retval        : NA
* others:       : NA
***************************************************************************************/
HI_S32 HIFB_WBC2_CfgSlvLayer(HIFB_LAYER_ID_E enLayerId,HI_RECT_S *pstRect)
{
    HIFB_RECT        stRect          = {0};
    OPTM_GFX_GP_E    enGfxGpId       = g_stGfxDevice[enLayerId].enGPId;
    OPTM_GFX_GP_E    enMstGfxGpId    = OPTM_MASTER_GPID;
    OPTM_GFX_WBC_S   *pstWbc2        = &g_stGfxWbc2;
    OPTM_VDP_DISP_RECT_S  stLayerRect;

    stRect.x = 0;
    stRect.y = 0;
    stRect.w = pstRect->s32Width;
    stRect.h = pstRect->s32Height;

    pstWbc2->stInRect.x = 0;
    pstWbc2->stInRect.y = 0;
    pstWbc2->stInRect.w = g_stGfxGPDevice[enMstGfxGpId].stInRect.s32Width;
    pstWbc2->stInRect.h = g_stGfxGPDevice[enMstGfxGpId].stInRect.s32Height;

    /**
     ** wbc_outRect was decided by the disp format size or user's adjustRect
     **/
    pstWbc2->stOutRect.x = pstRect->s32X;
    pstWbc2->stOutRect.y = pstRect->s32Y;
    pstWbc2->stOutRect.w = pstRect->s32Width;
    pstWbc2->stOutRect.h = pstRect->s32Height;

    g_stGfxGPDevice[enGfxGpId].stOutRect.s32X      = pstRect->s32X;
    g_stGfxGPDevice[enGfxGpId].stOutRect.s32Y      = pstRect->s32Y;
    g_stGfxGPDevice[enGfxGpId].stOutRect.s32Width  = pstRect->s32Width;
    g_stGfxGPDevice[enGfxGpId].stOutRect.s32Height = pstRect->s32Height;

	OPTM_CheckGPMask_BYGPID(enGfxGpId);
	
    memset(&stLayerRect, 0, sizeof(stLayerRect));

    stLayerRect.u32IWth= pstWbc2->stInRect.w & 0xfffffffe;
    stLayerRect.u32IHgt= pstWbc2->stInRect.h & 0xfffffffe;
    /**
     ** crop for source of gp0 data
     **/
    stLayerRect.u32DXL = stLayerRect.u32DXS + stLayerRect.u32IWth;
    stLayerRect.u32DYL = stLayerRect.u32DXS + stLayerRect.u32IHgt;

    stLayerRect.u32OWth= pstRect->s32Width & 0xfffffffe;
    stLayerRect.u32OHgt= pstRect->s32Height & 0xfffffffe;

    OPTM_VDP_WBC_SetLayerReso  (pstWbc2->enWbcHalId, stLayerRect);
    OPTM_VDP_WBC_SetCropReso   (pstWbc2->enWbcHalId, stLayerRect);

#ifndef HI_BUILD_IN_BOOT
    if(g_stGfxGPDevice[enGfxGpId].unUpFlag.bits.WbcMode || g_stGfxGPDevice[OPTM_MASTER_GPID].bNeedExtractLine == HI_TRUE){
        OPTM_GfxSetLayerRect   (enLayerId, &stRect);
        OPTM_GfxSetGpRect      (enGfxGpId, &stRect);
    }
#else
    OPTM_GfxSetLayerRect  (enLayerId, &stRect);
    OPTM_GfxSetGpRect     (enGfxGpId, &stRect);
#endif

    return HI_SUCCESS;
}


/***************************************************************************************
* func          : HIFB_WBC2_Reset
* description   : CNcomment: 回写状态复位 CNend\n
* param[in]     : HI_VOID
* retval        : NA
* others:       : NA
***************************************************************************************/
HI_VOID HIFB_WBC2_Reset(HI_BOOL bWbcRegUp)
{
	if(HI_TRUE == bWbcRegUp){
		g_stGfxGPDevice[OPTM_SLAVER_GPID].unUpFlag.bits.RegUp = 1;
	}
	if(!g_stGfxGPDevice[OPTM_SLAVER_GPID].bMaskFlag){
		return;
	}
#ifndef HI_BUILD_IN_BOOT
	OPTM_ClearIntSignal (g_stGfxWbc2.enWbcInt);
#endif
	g_stGfxGPDevice[OPTM_SLAVER_GPID].unUpFlag.bits.RegUp = 0;
	g_stGfxWbc2.bWorking = HI_FALSE;

	return;
}


#ifndef HI_BUILD_IN_BOOT
/***************************************************************************************
* func          : HIFB_WBC2_FrameEndProcess
* description   : CNcomment: 帧完成回写处理 CNend\n
* param[in]     : HI_VOID
* retval        : NA
* others:       : NA
***************************************************************************************/
HI_S32 HIFB_WBC2_FrameEndProcess(OPTM_GFX_GP_E enGpId)
{
    HIFB_LAYER_ID_E enLayerId  = HIFB_LAYER_SD_0;
    OPTM_GFX_GP_S   *pGfxGp    = NULL;
    OPTM_GFX_WBC_S   *pstWbc2  = NULL;
	HI_U32 u32WbcEnable        = 0;
	HIFB_RECT stRect           = {0};

	OPTM_CheckGPMask_BYGPID(enGpId);

	pGfxGp   = &g_stGfxGPDevice[OPTM_SLAVER_GPID];
	pstWbc2  = &g_stGfxWbc2;
	stRect.w = g_stGfxGPDevice[OPTM_SLAVER_GPID].stOutRect.s32Width;
	stRect.h = g_stGfxGPDevice[OPTM_SLAVER_GPID].stOutRect.s32Height;


    if(OPTM_VDP_DISP_GetIntSignal(pstWbc2->enWbcInt) && !g_stGfxGPDevice[OPTM_SLAVER_GPID].bMaskFlag)
    {/** wbc int finish and is wbc work, deal with wbc
      ** 回写中断完成以及同源回写，处理回写相关操作
      **/
	       	OPTM_ClearIntSignal(pstWbc2->enWbcInt);
	 		/**
	 		 **切回写地址，并设置要显示的地址
	 		 **/
	 		pstWbc2->u32ReadBufAddr  = pstWbc2->u32WBCBuffer[pstWbc2->u32BufIndex];
	        pstWbc2->u32BufIndex     = pstWbc2->u32BufIndex + 1;
	        pstWbc2->u32BufIndex     = pstWbc2->u32BufIndex % OPTM_WBCBUFFER_NUM;
	        pstWbc2->u32WriteBufAddr = pstWbc2->u32WBCBuffer[pstWbc2->u32BufIndex];
	        
			OPTM_VDP_GFX_SetLayerAddrEX   (g_stGfxDevice[enLayerId].enGfxHalId,pstWbc2->u32ReadBufAddr);
			OPTM_GfxSetLayerRect          (enLayerId,        &stRect);
			OPTM_GfxSetGpRect             (OPTM_SLAVER_GPID, &stRect);
	        OPTM_VDP_GFX_SetRegUp         (g_stGfxDevice[enLayerId].enGfxHalId);
	        OPTM_VDP_GP_SetRegUp          (OPTM_SLAVER_GPID);
	        
			pstWbc2->bWorking = HI_FALSE;
    }


	/**
	 **获取回写寄存器的使能状态
	 **/
	OPTM_VDP_WBC_GetEnable(pstWbc2->enWbcHalId, &u32WbcEnable);
    if(HI_FALSE == u32WbcEnable || HI_FALSE == g_stGfxDevice[enLayerId].bEnable){
		return HI_SUCCESS;
	}
    
	if(pGfxGp->unUpFlag.bits.RegUp){
    	
        if(pGfxGp->unUpFlag.bits.WbcMode){
        	/**
        	 **set wbc 3d
        	 **需要设置3D回写模式
        	 **/
            OPTM_VDP_WBC_SetThreeMd(pstWbc2->enWbcHalId, (HI_U32)pstWbc2->enWbcMode);
            pGfxGp->unUpFlag.bits.WbcMode = 0;
        }
        if(g_stGfxWbc2.s32WbcCnt > 0){
        	/** 解决回写微缩闪的问题 **/
            g_stGfxWbc2.s32WbcCnt--;
        }else{
            if(!g_stGfxWbc2.bWorking){
				pGfxGp->unUpFlag.bits.RegUp = 0;
				OPTM_VDP_WBC_SetLayerAddr(pstWbc2->enWbcHalId,      \
					                      pstWbc2->u32WriteBufAddr, \
					                      0x0,                      \
					                      pstWbc2->u32BufferStride, \
					                      0x0);
				HIFB_WBC2_SetRegUp       (pstWbc2->enWbcHalId);
				g_stGfxWbc2.bWorking = HI_TRUE;
            }
        }
    }

    return HI_SUCCESS;
}

/***************************************************************************************
* func          : HIFB_WBC2_SlvLayerProcess
* description   : CNcomment: 回写标清层处理 CNend\n
* param[in]     : HI_VOID
* retval        : NA
* others:       : NA
***************************************************************************************/
HI_S32 HIFB_WBC2_SlvLayerProcess(OPTM_GFX_GP_E enGpId)
{

    HIFB_LAYER_ID_E enLayerId          = HIFB_LAYER_SD_0;
    OPTM_GFX_GP_S   *pGfxGp            = &g_stGfxGPDevice[enGpId];
    OPTM_GFX_WBC_S   *pstWbc2          = &g_stGfxWbc2;
    
	/** GP1掩码 **/
	OPTM_CheckGPMask_BYGPID(enGpId);

    if(pGfxGp->unUpFlag.bits.Enable){
        OPTM_VDP_GFX_SetLayerEnable (g_stGfxDevice[enLayerId].enGfxHalId, g_stGfxDevice[enLayerId].bEnable);
        OPTM_VDP_WBC_SetEnable      (pstWbc2->enWbcHalId,g_stGfxDevice[enLayerId].bEnable);
        if(HI_FALSE == g_stGfxDevice[enLayerId].bEnable){
        	/**
        	 ** 1、要是回写关闭，马上更新使能，使下一帧不生效，否则下一帧还回写
        	 ** 2、要是回写打开，要等到地址等信息配置完才能生效，否则挂死
        	 **/
			OPTM_VDP_GFX_SetRegUp  (g_stGfxDevice[enLayerId].enGfxHalId);
			HIFB_WBC2_SetRegUp     (pstWbc2->enWbcHalId);
		}
	    pGfxGp->unUpFlag.bits.Enable = 0;
    }
    if(pGfxGp->unUpFlag.bits.InRect){
        HIFB_WBC2_CfgSlvLayer(enLayerId, &pGfxGp->stOutRect);
        pGfxGp->unUpFlag.bits.InRect = 0;
    }
    if(pGfxGp->unUpFlag.bits.Alpha){
        HIFB_ALPHA_S *pstAlpha;
        pstAlpha = &g_stGfxDevice[enLayerId].stAlpha;
        OPTM_VDP_GFX_SetPalpha(g_stGfxDevice[enLayerId].enGfxHalId,pstAlpha->bAlphaEnable,HI_TRUE,pstAlpha->u8Alpha0,pstAlpha->u8Alpha1);
        OPTM_VDP_GFX_SetLayerGalpha(g_stGfxDevice[enLayerId].enGfxHalId, pstAlpha->u8GlobalAlpha);
        pGfxGp->unUpFlag.bits.Alpha = 0;
    }
    if(pGfxGp->unUpFlag.bits.PreMute){
        OPTM_VDP_GFX_SetPreMultEnable(g_stGfxDevice[enLayerId].enGfxHalId, g_stGfxDevice[enLayerId].bPreMute);
        pGfxGp->unUpFlag.bits.PreMute = 0;
    }

    pGfxGp->unUpFlag.bits.RegUp = 0x1;

	return HI_SUCCESS;
}

/***************************************************************************************
* func          : HIFB_WBC2_GetSlvLayerInfo
* description   : CNcomment: 获取标清回写图层信息 CNend\n
* param[in]     : HI_VOID
* retval        : NA
* others:       : NA
***************************************************************************************/
HI_S32 HIFB_WBC2_GetSlvLayerInfo(HIFB_SLVLAYER_DATA_S *pstLayerInfo)
{
    pstLayerInfo->enLayerID = OPTM_SLAVER_LAYERID;
	
    if(HIFB_GFX_MODE_HD_WBC != g_enOptmGfxWorkMode){
        return HI_FAILURE;
    }    
	
	pstLayerInfo->bOpen          = g_stGfxDevice[OPTM_SLAVER_LAYERID].bOpened;
	pstLayerInfo->bShow          = g_stGfxDevice[OPTM_SLAVER_LAYERID].bEnable;
	pstLayerInfo->eFmt           = g_stGfxWbc2.enDataFmt;
	pstLayerInfo->eGfxWorkMode   = g_enOptmGfxWorkMode;
	pstLayerInfo->eScanMode      = g_stGfxGPDevice[OPTM_SLAVER_GPID].bInterface ? HIFB_SCANMODE_I : HIFB_SCANMODE_P;
	pstLayerInfo->u32Stride      = g_stGfxWbc2.u32BufferStride;
	pstLayerInfo->u32WbcBufNum   = OPTM_WBCBUFFER_NUM;
	pstLayerInfo->u32WbcBufSize  = g_stGfxWbc2.stFrameBuffer.u32Size;
	pstLayerInfo->u32ReadBufAddr = g_stGfxWbc2.u32ReadBufAddr;
	
	pstLayerInfo->stCurWBCBufRect.x = 0;
	pstLayerInfo->stCurWBCBufRect.y = 0;
	pstLayerInfo->stCurWBCBufRect.w = g_stGfxWbc2.stOutRect.w;
	pstLayerInfo->stCurWBCBufRect.h = g_stGfxWbc2.stOutRect.h;

	pstLayerInfo->stSrcBufRect.x = 0;
	pstLayerInfo->stSrcBufRect.y = 0;
	pstLayerInfo->stSrcBufRect.w = g_stGfxWbc2.stInRect.w;
	pstLayerInfo->stSrcBufRect.h = g_stGfxWbc2.stInRect.h;

	pstLayerInfo->stMaxWbcBufRect.x = 0;
	pstLayerInfo->stMaxWbcBufRect.y = 0;
	pstLayerInfo->stMaxWbcBufRect.w = g_stGfxWbc2.s32BufferWidth;
	pstLayerInfo->stMaxWbcBufRect.h = g_stGfxWbc2.s32BufferHeight;

	pstLayerInfo->stScreenRect.x = g_stGfxWbc2.stOutRect.x;
	pstLayerInfo->stScreenRect.y = g_stGfxWbc2.stOutRect.y;
	pstLayerInfo->stScreenRect.w = g_stGfxWbc2.stOutRect.w;
	pstLayerInfo->stScreenRect.h = g_stGfxWbc2.stOutRect.h;

	return HI_SUCCESS;
}

#else
/***************************************************************************************
* func          : HIFB_WBC2_Isr
* description   : CNcomment: 回写处理 CNend\n
* param[in]     : HI_VOID
* retval        : NA
* others:       : NA
***************************************************************************************/
HI_VOID HIFB_WBC2_Isr(HI_VOID* u32Param0, HI_VOID* u32Param1)
{
    HIFB_LAYER_ID_E enLayerId = HIFB_LAYER_SD_0;
    OPTM_GFX_GP_E   enGfxGpId = *((OPTM_GFX_GP_E*)u32Param0);
    OPTM_GFX_GP_S   *pGfxGp   = &g_stGfxGPDevice[enGfxGpId];
    OPTM_GFX_WBC_S   *pstWbc2 = &g_stGfxWbc2;
    HIFB_ALPHA_S *pstAlpha    = &g_stGfxDevice[enLayerId].stAlpha;
    
    HIFB_WBC2_CfgSlvLayer(enLayerId, &pGfxGp->stOutRect);
    
    if(   pGfxGp->unUpFlag.bits.Enable           \
       && pGfxGp->unUpFlag.bits.RegUp            \
       && !g_stGfxGPDevice[enGfxGpId].bMaskFlag){
        OPTM_VDP_GFX_SetLayerEnable (g_stGfxDevice[enLayerId].enGfxHalId, g_stGfxDevice[enLayerId].bEnable);
        OPTM_VDP_WBC_SetEnable      (pstWbc2->enWbcHalId,                 g_stGfxDevice[enLayerId].bEnable);
    }

    OPTM_VDP_GFX_SetPalpha        (g_stGfxDevice[enLayerId].enGfxHalId,pstAlpha->bAlphaEnable,HI_TRUE,pstAlpha->u8Alpha0,pstAlpha->u8Alpha1);
    OPTM_VDP_GFX_SetLayerGalpha   (g_stGfxDevice[enLayerId].enGfxHalId, pstAlpha->u8GlobalAlpha);
    OPTM_VDP_GFX_SetPreMultEnable (g_stGfxDevice[enLayerId].enGfxHalId, g_stGfxDevice[enLayerId].bPreMute);
    OPTM_VDP_GFX_SetLayerAddrEX   (g_stGfxDevice[enLayerId].enGfxHalId,         \
                                   pstWbc2->u32WBCBuffer[pstWbc2->u32BufIndex]);
    OPTM_VDP_WBC_SetLayerAddr     (pstWbc2->enWbcHalId,                         \
                                   pstWbc2->u32WBCBuffer[pstWbc2->u32BufIndex], \
                                   0x0, pstWbc2->u32BufferStride, 0x0);
    
    OPTM_VDP_GFX_SetRegUp          (g_stGfxDevice[enLayerId].enGfxHalId);
    OPTM_VDP_GP_SetRegUp           (enGfxGpId);
    HIFB_WBC2_SetRegUp             (pstWbc2->enWbcHalId);
        
    return;
    
}

#endif


/***************************************************************************************
* func          : HIFB_WBC2_Recovery
* description   : CNcomment: 重新设置WBC和回写图层属性 CNend\n
* param[in]     : HI_VOID
* retval        : NA
* others:       : NA
***************************************************************************************/
HI_VOID HIFB_WBC2_Recovery(OPTM_GFX_GP_E enGPId)
{

	OPTM_GFX_WBC_S *pstWbc2 = &g_stGfxWbc2;
	HI_RECT_S  *pstDispRect = &g_stGfxGPDevice[enGPId].stOutRect;
	
	g_stGfxDevice[HIFB_LAYER_SD_0].enReadMode = g_stGfxGPDevice[enGPId].bInterface ? VDP_RMODE_SELF_ADAPTION : VDP_RMODE_PROGRESSIVE;

	OPTM_VDP_WBC_SetDitherMode     (pstWbc2->enWbcHalId, pstWbc2->enDitherMode);
	OPTM_VDP_WBC_SetOutFmt         (pstWbc2->enWbcHalId, pstWbc2->stWBCFmt);
	OPTM_VDP_WBC_SetOutIntf        (pstWbc2->enWbcHalId, pstWbc2->enOutMode);
	OPTM_VDP_WBC_SetLayerAddr      (pstWbc2->enWbcHalId, pstWbc2->u32WriteBufAddr, 0x0, pstWbc2->u32BufferStride, 0x0);

	OPTM_VDP_GFX_SetInDataFmt      (g_stGfxDevice[HIFB_LAYER_SD_0].enGfxHalId,OPTM_PixerFmtTransferToHalFmt(pstWbc2->enDataFmt));
    OPTM_VDP_GFX_SetPalpha         (g_stGfxDevice[HIFB_LAYER_SD_0].enGfxHalId, HI_TRUE,HI_TRUE,0xff,0xff);
	OPTM_VDP_GFX_SetPreMultEnable  (g_stGfxDevice[HIFB_LAYER_SD_0].enGfxHalId, HI_TRUE);
	OPTM_VDP_GFX_SetLutAddr        (g_stGfxDevice[HIFB_LAYER_SD_0].enGfxHalId, g_stGfxDevice[HIFB_LAYER_SD_0].stCluptTable.u32StartPhyAddr);
	OPTM_VDP_GFX_SetLayerBkg       (g_stGfxDevice[HIFB_LAYER_SD_0].enGfxHalId, g_stGfxDevice[HIFB_LAYER_SD_0].stBkg);
	OPTM_VDP_GFX_SetBitExtend      (g_stGfxDevice[HIFB_LAYER_SD_0].enGfxHalId, g_stGfxDevice[HIFB_LAYER_SD_0].enBitExtend);
	OPTM_VDP_GFX_SetUpdMode        (g_stGfxDevice[HIFB_LAYER_SD_0].enGfxHalId, g_stGfxDevice[HIFB_LAYER_SD_0].enUpDateMode);

	OPTM_GfxSetLayerStride         (HIFB_LAYER_SD_0, pstWbc2->u32BufferStride);
	OPTM_GfxSetLayerReadMode       (HIFB_LAYER_SD_0, g_stGfxDevice[HIFB_LAYER_SD_0].enReadMode);
	HIFB_WBC2_CfgSlvLayer          (HIFB_LAYER_SD_0, pstDispRect);
    
	return;
}
