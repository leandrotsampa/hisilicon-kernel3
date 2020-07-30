/******************************************************************************
*
* Copyright (C) 2014 Hisilicon Technologies Co., Ltd.  All rights reserved. 
*
* This program is confidential and proprietary to Hisilicon  Technologies Co., Ltd. (Hisilicon), 
* and may not be copied, reproduced, modified, disclosed to others, published or used, in
* whole or in part, without the express prior written permission of Hisilicon.
*
******************************************************************************
File Name           : hifb_fence.c
Version             : Initial Draft
Author              : 
Created             : 2014/08/06
Description         : 
Function List       : 
History             :
Date                       Author                   Modification
2014/08/06                 y00181162                Created file        
******************************************************************************/

/*********************************add include here******************************/
#include <linux/ctype.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/errno.h>
#include <linux/string.h>
#include <linux/delay.h>
#include <linux/slab.h>
#include <linux/mm.h>
#include <linux/time.h>
#include <linux/fb.h>
#include <asm/uaccess.h>
#include <linux/file.h>
#include <asm/types.h>
#include <asm/stat.h>
#include <asm/fcntl.h>

#include "hifb_comm.h"

#ifdef CFG_HIFB_FENCE_SUPPORT
#include "hifb_fence.h"
#endif

/***************************** Macro Definition ******************************/


/*************************** Structure Definition ****************************/


/********************** Global Variable declaration **************************/



/******************************* API declaration *****************************/


#ifdef CFG_HIFB_FENCE_SUPPORT

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
int hifb_create_fence(struct sw_sync_timeline *timeline, const char *fence_name, unsigned value)
{
	int fd;
	struct sync_fence *fence;
	struct sync_pt *pt;

	if (timeline == NULL) 
	{
		return -EINVAL;
	}
	/**
	 **获取可用的文件节点
	 **/
	fd = get_unused_fd();
	if (fd < 0) {
		HIFB_ERROR("get_unused_fd failed!\n");
		return fd;
	}
	/**
	 **创建同步节点
	 **/
	pt = sw_sync_pt_create(timeline, value);
	if (pt == NULL) {
		return -ENOMEM;
	}
	/**
	 **一堆同步节点的集合，让hal层的fence与kernel联系上
	 **/
	fence = sync_fence_create(fence_name, pt);
	if (fence == NULL) {
		sync_pt_free(pt);
		return -ENOMEM;
	}
	/**
	 **将设备节点安装到fence中，这样就可以操作这个设备节点了
	 **/
	sync_fence_install(fence, fd);

	return fd;
	
}


/***********************************************************************
* func		: hifb_fence_wait
* description	: 等待同步
* param[in] 	: GPU创建的fence
* param[in] 	: 等待超时时间
***********************************************************************/
int hifb_fence_wait(int fence_fd, long timeout)
{
	int err;
	struct sync_fence *fence = NULL;

	fence = sync_fence_fdget(fence_fd);
	if (fence == NULL)
	{
		HIFB_ERROR("sync_fence_fdget failed!\n");
		return -EINVAL;
	}

	/**
	 **这里等待s_SyncInfo.u32Timeline与s_SyncInfo.u32FenceValue相等
	 **相等之后这个fence线程会被唤醒，否则等超时。这两个值创建的时候都指定了
	 **底层会有记录，这里的两个值只做为上面调试使用
	 **/
	err = sync_fence_wait(fence, timeout);
	if (err == -ETIME)
	{/**#define MSEC_PER_SEC    1000L 在time.h中**/
		err = sync_fence_wait(fence, 10 * MSEC_PER_SEC);
	}
	if (err < 0)
	{
		HIFB_WARNING("error waiting on fence: 0x%x\n", err);
	}

	/**
	 **谁使用谁释放，hifb使用acquire fence，则由hifb来释放，
	 ** hifb创建的release fence给GPU使用，则由GPU释放realease fence。
	 **/
	sync_fence_put(fence);
	
	return 0;
	
}
#endif
