/******************************************************************************
*
* Copyright (C) 2015 Hisilicon Technologies Co., Ltd.  All rights reserved. 
*
* This program is confidential and proprietary to Hisilicon  Technologies Co., Ltd. (Hisilicon), 
* and may not be copied, reproduced, modified, disclosed to others, published or used, in
* whole or in part, without the express prior written permission of Hisilicon.
*
******************************************************************************
File Name	    : jpeg_drv_signal.c
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


/*********************************add include here******************************/
#include "jpeg_drv_signal.h"
#include "hi_jpeg_config.h"

/***************************** Macro Definition ******************************/


/*************************** Structure Definition ****************************/


/********************** Global Variable declaration **************************/


/******************************* API forward declarations *******************/
extern long os_semctl(int semid, int semnum, int cmd, unsigned long arg);
extern long os_semget(key_t key, int nsems, int semflg);


/******************************* API realization *****************************/

/***************************************************************************************
* func			: jpeg_create_signal
* description	: create signal.
				  CNcomment: 创建信号量 CNend\n
* param[in] 	: 
* retval		: HI_SUCCESS 成功
* retval		: HI_FAILURE 失败
* others:		: NA
***************************************************************************************/
HI_S32 jpeg_create_signal(HI_S32 *ps32Semid)
{

	HI_S32 semid  = 0;

	/**
	 ** 获取一个信号量，权限支持多进程共享该信号量
	 ** 第二个参数是信号灯的数目
	 **/
	if ((semid = os_semget(IPC_PRIVATE, 1, IPC_CREAT | 0666)) == -1) 
	{
		JPEG_TRACE("create signal failure\n");
		return HI_FAILURE;
	}
	/**
	 ** init signal 初始化信号量 
	 ** SETVAL:设置某个所代表信号灯的值为arg.val
	 **/
	if(os_semctl(semid, 0, SETVAL, 1) < 0) 
	{
		JPEG_TRACE("init signal failure\n");
		return HI_FAILURE;
	}

	*ps32Semid = semid;
	
	return HI_SUCCESS;
	
}

/***************************************************************************************
* func			: jpeg_destory_signal
* description	: destory signal.
				  CNcomment: 销毁信号量 CNend\n
* param[in] 	: 
* retval		: HI_SUCCESS 成功
* retval		: HI_FAILURE 失败
* others:		: NA
***************************************************************************************/
HI_S32 jpeg_destory_signal(HI_S32 s32Semid)
{

	HI_S32 s32Ret = HI_SUCCESS;

	s32Ret = os_semctl(s32Semid, 0, IPC_RMID, 1);
	if(s32Ret == HI_FAILURE) 
	{
		JPEG_TRACE("destory id failure\n");
		return HI_FAILURE;
	}
	
	return HI_SUCCESS;
	
}
#endif

#endif/**HI_BUILD_IN_BOOT**/
