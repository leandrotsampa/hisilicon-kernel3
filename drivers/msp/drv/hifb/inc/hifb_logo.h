/******************************************************************************
*
* Copyright (C) 2015 Hisilicon Technologies Co., Ltd.  All rights reserved. 
*
* This program is confidential and proprietary to Hisilicon  Technologies Co., Ltd. (Hisilicon), 
* and may not be copied, reproduced, modified, disclosed to others, published or used, in
* whole or in part, without the express prior written permission of Hisilicon.
*
******************************************************************************
File Name           : hifb_logo.h
Version             : Initial Draft
Author              : 
Created             : 2014/09/09
Description         : 
Function List       : 
History             :
Date                       Author                   Modification
2015/05/19                 y00181162                Created file        
******************************************************************************/

#ifndef __HIFB_LOGO_H__
#define __HIFB_LOGO_H__


/*********************************add include here******************************/

#include "hifb_config.h"
#include <linux/kthread.h>

/*****************************************************************************/


#ifdef __cplusplus
#if __cplusplus
   extern "C"
{
#endif
#endif /* __cplusplus */



#ifdef CFG_HIFB_LOGO_SUPPORT

/***************************** Macro Definition ******************************/
#define HIFB_BOOT_FMT_1555             5
#define HIFB_BOOT_FMT_8888             9

#define HIFB_HD_LOGO_LAYER_ID          HIFB_LAYER_HD_0
#define HIFB_SD_LOGO_LAYER_ID          CONFIG_HIFB_SD_LOGO_LAYER_ID
	
/*************************** Structure Definition ****************************/

typedef enum tagHIFB_LOGO_CHANNEL_E
{
	HIFB_LOGO_CHN_HD = 0,
	HIFB_LOGO_CHN_SD = 1,
	HIFB_LOGO_CHN_BUTT,
}HIFB_LOGO_CHANNEL_E;

typedef struct tagHIFB_LOGO_INFO_S
{
	HI_BOOL          bShow;
	HI_BOOL          bClean;
	HI_U32           u32LogoAddr;
	HI_U32           u32LogoSdAddr;
	HIFB_LAYER_ID_E  eLogoID;
	struct task_struct *pThreadTask;
    struct work_struct freeLogoMemWork;
}HIFB_LOGO_INFO_S;

typedef struct tagHIFB_LOGO_S
{
	HI_U32           u32LogoNum;
	HI_BOOL          bLogoInit;
	HIFB_LOGO_INFO_S stLogoInfo[HIFB_LOGO_CHN_BUTT];	
}HIFB_LOGO_S;
	
/********************** Global Variable declaration **************************/



/******************************* API declaration *****************************/

/***************************************************************************************
* func          : hifb_logo_setstate
* description   : CNcomment: set state when insmod ko CNend\n
* param[in]     : HI_VOID
* retval        : NA
* others:       : NA
***************************************************************************************/
HI_VOID hifb_logo_setstate(HI_VOID);


/***************************************************************************************
* func          : hifb_logo_init
* description   : init logo    CNcomment: logo初始化 CNend\n
* param[in]     : HI_VOID
* retval        : NA
* others:       : NA
***************************************************************************************/
HI_VOID hifb_logo_init(HI_U32 u32LayerId);

/***************************************************************************************
* func          : hifb_clear_logo
* description   : clear logo   CNcomment: 清logo CNend\n
* param[in]     : u32LayerID
* param[in]     : bModExit
* retval        : NA
* others:       : NA
***************************************************************************************/
HI_VOID hifb_clear_logo(HI_U32 u32LayerID, HI_BOOL bModExit);


/***************************************************************************************
* func          : hifb_set_logosd
* description   : set logo sd 
                               CNcomment: 设置logo数据信息 CNend\n
* param[in]     : u32LayerID   CNcomment: layer id     CNend\n
* retval        : NA
* others:       : NA
***************************************************************************************/
HI_S32 hifb_set_logosd(HI_U32 u32LayerID);


/***************************************************************************************
* func          : hifb_logo_app
* description   : copy logo para and memory to app layer
                               CNcomment: 将logo的内容拷贝的主图层中 CNend\n
* param[in]     : u32LayerID   CNcomment: layer id     CNend\n
* retval        : NA
* others:       : NA
***************************************************************************************/
HI_VOID hifb_logo_app(HI_U32 u32LayerID);


#endif



#ifdef __cplusplus

#if __cplusplus

}
#endif
#endif /* __cplusplus */

#endif /* __HIFB_LOGO_H__ */
