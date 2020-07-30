/******************************************************************************

  Copyright (C), 2012-2050, Hisilicon Tech. Co., Ltd.

 ******************************************************************************
  File Name     : drv_uf.c
  Version       : Initial Draft
  Author        : Hisilicon multimedia software group
  Created       : 2013/11/15
  Description   : 
  History       :
  1.Date        : 2013/11/15
    Author      : c00186004
    Modification: Created file
******************************************************************************/
#include <linux/module.h>
#include <linux/spinlock.h>
#include <linux/wait.h>
#include <linux/slab.h> 
#include <linux/sched.h>

#include "hi_debug.h"
#include "drv_vicap.h"
#include "drv_uf.h"

#define UF_TIMEOUT 10

#define HI_ERR_UF HI_ERR_VICAP

#define UF_CHECK_NULL_PTR(ptr)\
do{\
    if(NULL == ptr)\
    {\
        HI_ERR_UF("Null Point!\n");\
        return HI_FAILURE;\
    }\
}while(0)

typedef struct hiUF_INFO_S
{
    volatile HI_BOOL          bValid;     /* 是否可获取图像 */
    HI_DRV_VIDEO_FRAME_S      stFrameInfo;/* 当前发送帧信息 */
    UF_INIT_ATTR_S            stInitAttr;  /* UF初始属性 */
    HI_U32                    u32Ufcnt;   /* 用户占用的buf数 */
    spinlock_t                stUfLock;   /* 自旋锁防止中断抢占 */
    wait_queue_head_t         stUfWait;   /* 用户连续获取时，阻塞队列 */ 
} UF_INFO_S;

HI_S32 UF_DRV_CheckInitAttr(UF_INIT_ATTR_S *pstInitAttr)
{
    if (HI_NULL == pstInitAttr->hHandle)
    {
        HI_ERR_UF("hHandle is Null Point!\n");
        return HI_FAILURE;
    }

    if (HI_NULL == pstInitAttr->pfnUfBufUserAdd)
    {
        HI_ERR_UF("pfnUfBufUserAdd is Null Point!\n");
        return HI_FAILURE;
    }

    if (HI_NULL == pstInitAttr->pfnUfBufUserSub)
    {
        HI_ERR_UF("pfnUfBufUserSub is Null Point!\n");
        return HI_FAILURE;
    }

    return HI_SUCCESS;
}

HI_VOID *HI_DRV_UF_Init(UF_INIT_ATTR_S *pstInitAttr)
{
    HI_S32 s32Ret = 0;
    UF_INFO_S *pstUfInfo = HI_NULL;

    if (HI_NULL == pstInitAttr)
    {
        HI_ERR_UF("Null Point\n");
        return HI_NULL;
    }
    
    s32Ret = UF_DRV_CheckInitAttr(pstInitAttr);
    if (HI_SUCCESS != s32Ret)
    {
        return HI_NULL;
    }

    pstUfInfo = (UF_INFO_S *)kzalloc(sizeof(UF_INFO_S),GFP_KERNEL);
    if (!pstUfInfo) 
    {
        HI_ERR_UF("Null Point\n");
		return HI_NULL;
	}

    spin_lock_init(&pstUfInfo->stUfLock);
    init_waitqueue_head(&pstUfInfo->stUfWait);
    
    memcpy(&pstUfInfo->stInitAttr, pstInitAttr, sizeof(UF_INIT_ATTR_S));
    
    return pstUfInfo;
}
EXPORT_SYMBOL(HI_DRV_UF_Init);

HI_S32 HI_DRV_UF_DeInit(HI_VOID *phUf)
{
    HI_S32 s32Ret;
    HI_HANDLE hHandle = HI_INVALID_HANDLE;
    FN_UF_BufUserSub pfnUfBufUserSub = HI_NULL;
    UF_INFO_S *pstUfInfo = HI_NULL;
    
    UF_CHECK_NULL_PTR(phUf);
    
    pstUfInfo = (UF_INFO_S *)phUf;
    hHandle = pstUfInfo->stInitAttr.hHandle;
    pfnUfBufUserSub = pstUfInfo->stInitAttr.pfnUfBufUserSub;
    
    if (pstUfInfo->bValid)
    {
        s32Ret = pfnUfBufUserSub(hHandle, pstUfInfo->stFrameInfo.stBufAddr[0].u32PhyAddr_Y);
        if (HI_SUCCESS != s32Ret)
        {
            HI_ERR_UF("pfnUfBufUserSub failed!\n");
            kfree(phUf);
            return HI_FAILURE;
        }
        pstUfInfo->bValid = HI_FALSE;
    }
    
	kfree(phUf);
    
    return HI_SUCCESS;
}
EXPORT_SYMBOL(HI_DRV_UF_DeInit);

/* 获取采集图像帧 */
HI_S32 HI_DRV_UF_AcquireFrm(HI_VOID *phUf, HI_DRV_VIDEO_FRAME_S *pstUserFrm)
{
    HI_S32 s32Ret;
    unsigned long u32Flags = 0;
    UF_INFO_S *pstUfInfo = HI_NULL;

    UF_CHECK_NULL_PTR(phUf);
    UF_CHECK_NULL_PTR(pstUserFrm);
    
    pstUfInfo= (UF_INFO_S *)phUf;
    
    if (pstUfInfo->u32Ufcnt >= pstUfInfo->stInitAttr.u32Depth)
    {
        HI_ERR_UF("over depth\n"); 
        return HI_FAILURE;
    }

    s32Ret = wait_event_timeout(pstUfInfo->stUfWait, pstUfInfo->bValid, UF_TIMEOUT*HZ);
    if (s32Ret <= 0) 
    {
        HI_ERR_UF("time out:%d\n", pstUfInfo->bValid); 
        return HI_FAILURE;
    }   

    spin_lock_irqsave(&pstUfInfo->stUfLock, u32Flags);
    memcpy(pstUserFrm, &pstUfInfo->stFrameInfo, sizeof(HI_DRV_VIDEO_FRAME_S));
    pstUfInfo->bValid = HI_FALSE;    
    spin_unlock_irqrestore(&pstUfInfo->stUfLock, u32Flags);
    
    pstUfInfo->u32Ufcnt++;
    
    return HI_SUCCESS;
}
EXPORT_SYMBOL(HI_DRV_UF_AcquireFrm);

/* 释放取采集图像帧 */
HI_S32 HI_DRV_UF_ReleaseFrm(HI_VOID *phUf, HI_DRV_VIDEO_FRAME_S *pstUserFrm)
{
    HI_S32 s32Ret;
    HI_HANDLE hHandle = HI_INVALID_HANDLE;
    FN_UF_BufUserSub pfnUfBufUserSub = HI_NULL;
    UF_INFO_S *pstUfInfo = HI_NULL;

    UF_CHECK_NULL_PTR(phUf);    
    UF_CHECK_NULL_PTR(pstUserFrm);

    pstUfInfo= (UF_INFO_S *)phUf;
    hHandle = pstUfInfo->stInitAttr.hHandle;
    pfnUfBufUserSub = pstUfInfo->stInitAttr.pfnUfBufUserSub;

    s32Ret = pfnUfBufUserSub(hHandle, pstUserFrm->stBufAddr[0].u32PhyAddr_Y);  
    if (HI_SUCCESS != s32Ret)
    {
        HI_ERR_UF("pfnUfBufUserSub failed!\n");
        return HI_FAILURE;
    }

    pstUfInfo->u32Ufcnt--;
    
    return HI_SUCCESS;    
}
EXPORT_SYMBOL(HI_DRV_UF_ReleaseFrm);

/* 获取VI采集图像帧 */
HI_S32 HI_DRV_UF_SendFrm(HI_VOID *phUf, HI_DRV_VIDEO_FRAME_S *pstUserFrm)
{     
    unsigned long u32Flags;
    HI_S32 s32Ret;
    HI_HANDLE hHandle = HI_INVALID_HANDLE;
    FN_UF_BufUserSub pfnUfBufUserSub = HI_NULL;
    FN_UF_BufUserAdd pfnUfBufUserAdd = HI_NULL;
    UF_INFO_S *pstUfInfo = HI_NULL;

    UF_CHECK_NULL_PTR(phUf);    
    UF_CHECK_NULL_PTR(pstUserFrm);

    pstUfInfo= (UF_INFO_S *)phUf; 
    hHandle = pstUfInfo->stInitAttr.hHandle;
    pfnUfBufUserSub = pstUfInfo->stInitAttr.pfnUfBufUserSub;
    pfnUfBufUserAdd = pstUfInfo->stInitAttr.pfnUfBufUserAdd;

    spin_lock_irqsave(&pstUfInfo->stUfLock, u32Flags);
    if (pstUfInfo->bValid)
    {
        s32Ret = pfnUfBufUserSub(hHandle, pstUfInfo->stFrameInfo.stBufAddr[0].u32PhyAddr_Y);
        if (HI_SUCCESS != s32Ret)
        {
            HI_ERR_UF("pfnUfBufUserSub failed!\n");
            spin_unlock_irqrestore(&pstUfInfo->stUfLock, u32Flags);
            return HI_FAILURE;
        }
        pstUfInfo->bValid = HI_FALSE;
    }
    
    memcpy(&pstUfInfo->stFrameInfo, pstUserFrm, sizeof(HI_DRV_VIDEO_FRAME_S));
    pstUfInfo->bValid = HI_TRUE;
    pfnUfBufUserAdd(hHandle, pstUserFrm->stBufAddr[0].u32PhyAddr_Y); 
    spin_unlock_irqrestore(&pstUfInfo->stUfLock, u32Flags);
    wake_up(&pstUfInfo->stUfWait);
    
    return HI_SUCCESS;
}
EXPORT_SYMBOL(HI_DRV_UF_SendFrm);

