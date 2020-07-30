/******************************************************************************
*
* Copyright (C) 2015 Hisilicon Technologies Co., Ltd.  All rights reserved. 
*
* This program is confidential and proprietary to Hisilicon  Technologies Co., Ltd. (Hisilicon), 
* and may not be copied, reproduced, modified, disclosed to others, published or used, in
* whole or in part, without the express prior written permission of Hisilicon.
*
******************************************************************************
File Name	    : jpeg_drv_signal.h
Version		    : Initial Draft
Author		    : 
Created		    : 2015/03/01
Description	    : The user will use this api to realize some function
Function List 	: 

			  		  
History       	:
Date				Author        		Modification
2015/03/01		    y00181162  		    Created file      	
******************************************************************************/
#ifndef HI_BUILD_IN_BOOT



#ifdef CONFIG_JPEG_USE_KERNEL_SIGNAL


#ifndef __JPEG_DRV_SIGNAL_H__
#define __JPEG_DRV_SIGNAL_H__


/*********************************add include here******************************/
#include <linux/syscalls.h>
#include <linux/ipc.h>


#include "hi_type.h"

/*****************************************************************************/


#ifdef __cplusplus
#if __cplusplus
   extern "C" 
{
#endif
#endif /* __cplusplus */


     /***************************** Macro Definition ******************************/
	 /** \addtogroup	  JPEG */
	 /** @{ */	/** <!--[JPEG]*/


     /** @} */  /** <!-- ==== Macro Definition end ==== */

	 /*************************** Enum Definition ****************************/
    /****************************************************************************/
	/*							   jpeg enum    					            */
	/****************************************************************************/
	
	/** \addtogroup	  JPEG */
	/** @{ */	/** <!--[JPEG]*/

    /** @} */  /** <!-- ==== enum Definition end ==== */
	
	/*************************** Structure Definition ****************************/
    /****************************************************************************/
	/*							   jpeg api structure    					    */
	/****************************************************************************/
	
	/** \addtogroup	  JPEG */
	/** @{ */	/** <!--[JPEG]*/

	
	/** @} */  /** <!-- ==== Structure Definition End ==== */
	
    /********************** Global Variable declaration **************************/
 
    /******************************* API declaration *****************************/

	/** \addtogroup	  JPEG */
	/** @{ */	/** <!--[JPEG]*/


	
	/***************************************************************************************
	* func			: jpeg_create_signal
	* description	: create signal.
					  CNcomment: 创建信号量 CNend\n
	* param[in] 	: 
	* retval		: HI_SUCCESS 成功
	* retval		: HI_FAILURE 失败
	* others:		: NA
	***************************************************************************************/
    HI_S32 jpeg_create_signal(HI_S32 *ps32Semid);

	/***************************************************************************************
	* func			: jpeg_destory_signal
	* description	: destory signal.
					  CNcomment: 销毁信号量 CNend\n
	* param[in] 	: 
	* retval		: HI_SUCCESS 成功
	* retval		: HI_FAILURE 失败
	* others:		: NA
	***************************************************************************************/
 	HI_S32 jpeg_destory_signal(HI_S32 s32Semid);
	
	/** @} */  /** <!-- ==== API Declaration End ==== */

    /****************************************************************************/



#ifdef __cplusplus
    
#if __cplusplus
   
}
#endif
#endif /* __cplusplus */

#endif /* __JPEG_DRV_SIGNAL_H__*/

#endif

#endif/**HI_BUILD_IN_BOOT**/
