/******************************************************************************
*
* Copyright (C) 2015 Hisilicon Technologies Co., Ltd.  All rights reserved. 
*
* This program is confidential and proprietary to Hisilicon  Technologies Co., Ltd. (Hisilicon), 
* and may not be copied, reproduced, modified, disclosed to others, published or used, in
* whole or in part, without the express prior written permission of Hisilicon.
*
******************************************************************************
File Name	    : jpeg_drv_mem.h
Version		    : Initial Draft
Author		    : 
Created		    : 2015/01/25
Description	    :
Function List 	: 

			  		  
History       	:
Date				Author        		Modification
2015/01/25		    y00181162  		    Created file      	
******************************************************************************/

#ifndef __JPEG_DRV_MEM_H__
#define __JPEG_DRV_MEM_H__


#ifndef HI_BUILD_IN_BOOT
/*********************************add include here******************************/
#include <linux/types.h>
#include <linux/fs.h>
#include <linux/interrupt.h>
#include <linux/ioctl.h>
#include <linux/delay.h>
#include <linux/errno.h>
#include <linux/mm.h>
#include <linux/fcntl.h>
#include <linux/slab.h>
#include <asm/atomic.h>
#include <asm/io.h>

#include "hi_type.h"
#include "hi_jpeg_config.h"


#ifdef CONFIG_JPEG_OMX_FUNCTION

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

    #define JPGD_DRV_STREAM_BUFFER      (512 * 1024)
    
     /** @} */  /** <!-- ==== Macro Definition end ==== */

	 /*************************** Enum Definition ****************************/
	/** \addtogroup	  JPEG */
	/** @{ */	/** <!--[JPEG]*/

    /** @} */  /** <!-- ==== enum Definition end ==== */
	
	/*************************** Structure Definition ****************************/
	/** \addtogroup	  JPEG */
	/** @{ */	/** <!--[JPEG]*/

	
	/** @} */  /** <!-- ==== Structure Definition End ==== */
	
    /********************** Global Variable declaration **************************/
 
    /******************************* API declaration *****************************/

	/** \addtogroup	  JPEG */
	/** @{ */	/** <!--[JPEG]*/

    /***************************************************************************************
    * func			: jpeg_mem_alloc
    * description	: alloc all memory
    				  CNcomment: 分配所有内存 CNend\n
    * param[in] 	: 
    * others:		: NA
    ***************************************************************************************/
    HI_S32 jpeg_mem_alloc(HI_U64 u64DecHandle);
    
	/***************************************************************************************
	* func			: jpeg_mem_destory
	* description	: destory all memory
					  CNcomment: 销毁所有内存 CNend\n
	* param[in] 	: 
	* others:		: NA
	***************************************************************************************/
    HI_VOID jpeg_mem_destory(HI_U64 u64DecHandle);
    
	
	/** @} */  /** <!-- ==== API Declaration End ==== */

    /****************************************************************************/



#ifdef __cplusplus
    
#if __cplusplus
   
}
#endif
#endif /* __cplusplus */

#endif

#endif/**HI_BUILD_IN_BOOT**/
#endif/**__JPEG_DRV_MEM_H__**/
