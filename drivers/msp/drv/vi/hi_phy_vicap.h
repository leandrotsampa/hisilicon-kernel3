/******************************************************************************

  Copyright (C), 2014-2014, Hisilicon Tech. Co., Ltd.

******************************************************************************
  File Name     : hi_phy_vicap.h
  Version       : Initial Draft
  Author        : Hisilicon multimedia software group
  Created       : 2014/05/15
  Description   :
  History       :
  1.Date        : 2014/05/15
    Author      : l00214567
    Modification: Created file
 *******************************************************************************/


#ifndef __HI_PHY_VICAP_H__
#define __HI_PHY_VICAP_H__

#include <linux/semaphore.h>

#include "hi_osal.h"
#include "drv_vi_ioctl.h"
#include "drv_vpss_ext.h"
#include "drv_vi_utils.h"
#include "drv_vi_buf.h"
#include "hi_drv_dev.h"
#include "hi_drv_stat.h"
#include "hi_drv_sys.h"



HI_S32  HI_PHY_VICAP_Init(HI_VOID);
HI_VOID HI_PHY_VICAP_DeInit(HI_VOID);
HI_S32 HI_PHY_VICAP_Create(const HI_UNF_VI_ATTR_S *pstViAttr, HI_HANDLE *phVicap);
HI_S32  HI_PHY_VICAP_Destroy(HI_HANDLE hVicap);
HI_S32  HI_PHY_VICAP_Start(HI_HANDLE hVicap);
HI_S32  HI_PHY_VICAP_Stop(HI_HANDLE hVicap);
HI_S32  HI_PHY_VICAP_GetOutputAttr(HI_HANDLE hVicap, HI_UNF_VI_ATTR_S *pstViAttr);
HI_S32  HI_PHY_VICAP_SetOutputAttr(HI_HANDLE hVicap, HI_UNF_VI_ATTR_S *pstViAttr);

HI_S32  HI_PHY_VICAP_SetExtBuf(HI_HANDLE hVicap,  HI_UNF_VI_BUFFER_ATTR_S *pstBufAttr);

/* 获取/释放采集图像帧 */
HI_S32  HI_PHY_VICAP_AcquireFrame(HI_HANDLE hVicap, HI_DRV_VIDEO_FRAME_S *pFrameInfo);
HI_S32  HI_PHY_VICAP_ReleaseFrame(HI_HANDLE hVicap, HI_DRV_VIDEO_FRAME_S *pFrameInfo);

/* 用户获取采集图像帧 */
HI_S32 HI_PHY_VICAP_UserAcquireFrame(HI_HANDLE hVicap, HI_UNF_VIDEO_FRAME_INFO_S *pFrameInfo, HI_U32 u32TimeoutMs);
/* 用户释放采集图像帧 */
HI_S32 HI_PHY_VICAP_UserReleaseFrame(HI_HANDLE hVicap, HI_UNF_VIDEO_FRAME_INFO_S *pFrameInfo);





#endif
