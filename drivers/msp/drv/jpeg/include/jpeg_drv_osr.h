/******************************************************************************
*
* Copyright (C) 2015 Hisilicon Technologies Co., Ltd.  All rights reserved. 
*
* This program is confidential and proprietary to Hisilicon  Technologies Co., Ltd. (Hisilicon), 
* and may not be copied, reproduced, modified, disclosed to others, published or used, in
* whole or in part, without the express prior written permission of Hisilicon.
*
******************************************************************************
File Name	    : jpeg_drv_osr.h
Version		    : Initial Draft
Author		    : 
Created		    : 2015/03/01
Description	    : The user will use this api to realize some function
Function List 	: 

			  		  
History       	:
Date				Author        		Modification
2015/03/01		    y00181162  		    Created file      	
******************************************************************************/
#ifndef __JPEG_DRV_OSR_H__
#define __JPEG_DRV_OSR_H__


/*********************************add include here******************************/
#ifndef HI_BUILD_IN_BOOT
	#include <linux/syscalls.h>
	#include <linux/ipc.h>
#endif

#include "hi_jpeg_config.h"
#include "hi_jpeg_drv_api.h"
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
	/** \addtogroup	  JPEG */
	/** @{ */	/** <!--[JPEG]*/

    /** @} */  /** <!-- ==== enum Definition end ==== */
	
	/*************************** Structure Definition ****************************/
#ifndef HI_BUILD_IN_BOOT
		#ifdef CONFIG_JPEG_USE_KERNEL_SIGNAL
			/** jpeg device imformation */
			/** CNcomment:jpeg设备信息 */
			typedef struct hiJPG_OSRDEV_S
			{
			
				HI_S32	s32SignalId;		   /**< 信号量ID					**/
				HI_BOOL bSuspendSignal; 	   /**< whether get suspend signal   **//**<CNcomment:获取待机信号	   */
				HI_BOOL bResumeSignal;		   /**< whether get resume signal	 **//**<CNcomment:获取待机唤醒信号	*/
				HI_BOOL bDecTask;			   /**< whether have jpeg dec task	**//**<CNcomment:是否有jpeg解码任务  */
				HI_BOOL bClockOpen; 		   /**< 待机时候的时钟状态		  **/
				HI_BOOL bResetState;		   /**< 待机时候的复位状态		   **/
				HI_BOOL bMceUse;			   /**< 是否MCE在jpeg设备		   **/
				JPG_INTTYPE_E	   IntType;   /**< lately happened halt type  **/
				wait_queue_head_t  QWaitInt;  /**< waite halt queue 		  **/
			
			}JPG_OSRDEV_S;
			
		#else
			/** jpeg device imformation */
			/** CNcomment:jpeg设备信息 */
			typedef struct hiJPG_OSRDEV_S
			{
			
				HI_BOOL bSuspendSignal; 	 /**< whether get suspend signal  *//**<CNcomment:获取待机信号		 */
				HI_BOOL bResumeSignal;		   /**< whether get resume signal	*//**<CNcomment:获取待机唤醒信号  */
				HI_BOOL bEngageFlag;		  /**< whether be occupied, HI_TRUE if be occupied */
				HI_BOOL bDecTask;			  /**< whether have jpeg dec task	*//**<CNcomment:是否有jpeg解码任务	*/
				HI_BOOL bClockOpen; 		  /**< 待机时候的时钟状态 **/
				HI_BOOL bResetState;		   /**< 待机时候的复位状态 **/
				HI_BOOL bLock;				   /**< 已经处于锁状态	   **/
				HI_BOOL bMceUse;			   /**< 是否MCE在jpeg设备		   **/
				struct semaphore   SemGetDev; /**< protect the device to occupy the operation singnal */
				struct file 	   *pFile;
				JPG_INTTYPE_E	   IntType; 	 /**< lately happened halt type  */
				wait_queue_head_t  QWaitInt;	 /**< waite halt queue			 */
				wait_queue_head_t  QWaitMutex;	 /**< 释放信号量				 */
			
			}JPG_OSRDEV_S;

			/** dispose close device */
			/** CNcomment:关设备处理 */
			typedef struct hiJPG_DISPOSE_CLOSE_S
			{
			
				 HI_S32 s32SuspendClose;
				 HI_S32 s32DecClose;
				 HI_BOOL bOpenUp;
				 HI_BOOL bSuspendUp;
				 HI_BOOL bRealse;
			
			}JPG_DISPOSE_CLOSE_S;
			
		#endif
	/** \addtogroup	  JPEG */
	/** @{ */	/** <!--[JPEG]*/

	
	/** @} */  /** <!-- ==== Structure Definition End ==== */
	
    /********************** Global Variable declaration **************************/
 
    /******************************* API declaration *****************************/

	/** \addtogroup	  JPEG */
	/** @{ */	/** <!--[JPEG]*/

	
	/***************************************************************************************
	* func			: jpg_osr_open
	* description	: open jpeg device
					  CNcomment: 打开jpeg设备 CNend\n
	* param[in] 	: *inode
	* param[in] 	: *file
	* retval		: HI_SUCCESS
	* retval		: HI_FAILURE
	* others:		: NA
	***************************************************************************************/
	HI_S32 jpg_osr_open(struct inode *inode, struct file *file);
	/***************************************************************************************
	* func			: jpg_osr_close
	* description	: close jpeg device
					  CNcomment: 关闭jpeg设备 CNend\n
	* param[in] 	: *inode
	* param[in] 	: *file
	* retval		: HI_SUCCESS
	* retval		: HI_FAILURE
	* others:		: NA
	***************************************************************************************/
	HI_S32 jpg_osr_close( struct inode *inode, struct file *file);
	/***************************************************************************************
	* func			: jpg_osr_mmap
	* description	: mmap register ddr
					  CNcomment: 映射寄存器地址 CNend\n
	* param[in] 	: *inode
	* param[in] 	: *file
	* retval		: HI_SUCCESS
	* retval		: HI_FAILURE
	* others:		: NA
	***************************************************************************************/
	HI_S32 jpg_osr_mmap(struct file * filp, struct vm_area_struct *vma);

	/***************************************************************************************
	* func			: jpg_do_cancel_reset
	* description	: cancel reset jpeg register
					  CNcomment: 测消复位 CNend\n
	* param[in] 	: HI_VOID
	* retval		: NA
	* others:		: NA
	***************************************************************************************/
	HI_VOID jpg_do_cancel_reset(HI_VOID);


	/***************************************************************************************
	* func			: jpg_do_reset
	* description	: reset jpeg register
					  CNcomment: 复位 CNend\n
	* param[in] 	: HI_VOID
	* retval		: NA
	* others:		: NA
	***************************************************************************************/
	HI_VOID jpg_do_reset(HI_VOID);


	/***************************************************************************************
	* func			: jpg_do_clock_off
	* description	: close the jpeg clock
					  CNcomment: 关闭jpeg时钟 CNend\n
	* param[in] 	: HI_VOID
	* retval		: NA
	* others:		: NA
	***************************************************************************************/
	HI_VOID jpg_do_clock_off(HI_VOID);

	
	/***************************************************************************************
	* func			: jpg_do_clock_on
	* description	: open the jpeg clock
					  CNcomment: 打开jpeg时钟 CNend\n
	* param[in] 	: HI_VOID
	* retval		: NA
	* others:		: NA
	***************************************************************************************/
	HI_VOID jpg_do_clock_on(HI_VOID);


	 /***************************************************************************************
	 * func 		 : jpg_select_clock_frep
	 * description	 : select the clock frequence
					   CNcomment: jpeg时钟频率选择 CNend\n
	 * param[in]	 : HI_VOID
	 * retval		 : NA
	 * others:		 : NA
	 ***************************************************************************************/
	 HI_VOID jpg_select_clock_frep(HI_VOID);

	/***************************************************************************************
	* func			: jpg_osr_getlupixsum
	* description	: get lu pix sum
					  CNcomment: 获取亮度值和 CNend\n
	* param[in] 	: u64DecHandle
	* retval		: HI_SUCCESS
	* retval		: HI_FAILURE
	* others:		: NA
	***************************************************************************************/
	HI_VOID jpg_osr_getlupixsum(HI_U64 u64DecHandle,HI_U64* pu64LuPixValue);
	
#endif

    /***************************************************************************************
	* func			: jpg_osr_dec
	* description	: jpeg hard decode
					  CNcomment: jpeg解码 CNend\n
	* param[in] 	: *stDecInfo
	* retval		: HI_SUCCESS
	* retval		: HI_FAILURE
	* others:		: NA
	***************************************************************************************/
	HI_S32 jpg_osr_dec(HI_JPEG_DECINFO_S *stDecInfo);

	
	/** @} */  /** <!-- ==== API Declaration End ==== */

    /****************************************************************************/



#ifdef __cplusplus
    
#if __cplusplus
   
}
#endif
#endif /* __cplusplus */

#endif /* __JPEG_DRV_OSR_H__*/
