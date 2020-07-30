/******************************************************************************

  Copyright (C), 2012-2050, Hisilicon Tech. Co., Ltd.

 ******************************************************************************
  File Name     : drv_uf.h
  Version       : Initial Draft
  Author        : Hisilicon multimedia software group
  Created       : 2013/11/11
  Description   : 
  History       :
  1.Date        : 2013/11/11
    Author      : c00186004
    Modification: Created file
******************************************************************************/

#ifndef __HI_DRV_UFH__
#define __HI_DRV_UFH__

#include "hi_drv_video.h"

#ifdef __cplusplus
#if __cplusplus
extern "C"{
#endif
#endif /* __cplusplus */

typedef HI_S32 (*FN_UF_BufUserSub)(HI_HANDLE hHandle, HI_U32 u32PhysAddr);
typedef HI_S32 (*FN_UF_BufUserAdd)(HI_HANDLE hHandle, HI_U32 u32PhysAddr);

typedef struct hiUF_INIT_ATTR_S
{
    HI_HANDLE        hHandle;
    FN_UF_BufUserSub pfnUfBufUserSub;/* 引用计数减 */
    FN_UF_BufUserAdd pfnUfBufUserAdd;/* 引用计数加 */    
    HI_U32           u32Depth;    /* 用户能够获取的最大buf数 */
} UF_INIT_ATTR_S;

/* 初始化,设置用户最大占用的图像帧数 */
extern HI_VOID *HI_DRV_UF_Init(UF_INIT_ATTR_S *pstInitAttr);

/* 去初始化 */
extern HI_S32 HI_DRV_UF_DeInit(HI_VOID *phUf);

/* 用户获取采集图像帧 */
extern HI_S32 HI_DRV_UF_AcquireFrm(HI_VOID *phUf, HI_DRV_VIDEO_FRAME_S *pstUserFrm);

/* 用户释放取采集图像帧 */
extern HI_S32 HI_DRV_UF_ReleaseFrm(HI_VOID *phUf, HI_DRV_VIDEO_FRAME_S *pstUserFrm);

/* 获取VI采集图像帧 */
extern HI_S32 HI_DRV_UF_SendFrm(HI_VOID *phUf, HI_DRV_VIDEO_FRAME_S *pstUserFrm);


#ifdef __cplusplus
#if __cplusplus
}
#endif
#endif /* __cplusplus */

#endif/* __HI_DRV_UFH__ */

