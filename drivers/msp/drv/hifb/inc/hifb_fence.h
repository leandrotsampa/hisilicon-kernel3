/******************************************************************************
*
* Copyright (C) 2014 Hisilicon Technologies Co., Ltd.  All rights reserved. 
*
* This program is confidential and proprietary to Hisilicon  Technologies Co., Ltd. (Hisilicon), 
* and may not be copied, reproduced, modified, disclosed to others, published or used, in
* whole or in part, without the express prior written permission of Hisilicon.
*
******************************************************************************
File Name           : hifb_fence.h
Version             : Initial Draft
Author              : 
Created             : 2014/09/09
Description         : 
Function List       : 
History             :
Date                       Author                   Modification
2014/09/09                 y00181162                Created file        
******************************************************************************/

#ifndef __HIFB_FENCE_H__
#define __HIFB_FENCE_H__


/*********************************add include here******************************/
#if (LINUX_VERSION_CODE < KERNEL_VERSION(3, 10, 0))
#include <linux/sw_sync.h>
#else
#include <sw_sync.h>
#endif

/*****************************************************************************/


#ifdef __cplusplus
#if __cplusplus
   extern "C"
{
#endif
#endif /* __cplusplus */



/***************************** Macro Definition ******************************/


/*************************** Structure Definition ****************************/
typedef struct
{
	atomic_t s32RefreshCnt;
    HI_U32   u32FenceValue;
    HI_U32   u32Timeline;
    HI_U32  FrameEndFlag;
    wait_queue_head_t    FrameEndEvent;
    struct sw_sync_timeline *pstTimeline;
    HI_BOOL bFrameHit;
}HIFB_SYNC_INFO_S;

/********************** Global Variable declaration **************************/



/******************************* API declaration *****************************/


/***********************************************************************
* func		    : hifb_create_fence
* description	: 创建fence，这里创建的是release fence，返回的是
                  releaseFD，acquire fence有GPU创建，返回的是acquireFD，
                  HWComposer通过Binder通信送给hifb这个文件描述符
* param[in] 	: *timeline 前面创建的hifb时间轴
* param[in] 	: fence_name要创建的fence名字，"hifb_fence"
* param[in] 	: value 创建fence的初始值，前面是timeline的初始值，
                  第一次创建的时候++s_SyncInfo.u32FenceValue也就是2。
                  所以第一次创建fence的初始值为2
* retval		: NA
***********************************************************************/
int hifb_create_fence(struct sw_sync_timeline *timeline,const char *fence_name,unsigned value);

/***********************************************************************
* func		    : hifb_fence_wait
* description	: 等待同步
* param[in] 	: GPU创建的fence
* param[in] 	: 等待超时时间
***********************************************************************/
int hifb_fence_wait(int fence_fd, long timeout);

#ifdef __cplusplus

#if __cplusplus

}
#endif
#endif /* __cplusplus */

#endif /* __HIFB_FENCE_H__ */
