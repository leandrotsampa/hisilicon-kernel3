/******************************************************************************

  Copyright (C), 2012-2050, Hisilicon Tech. Co., Ltd.

 ******************************************************************************
  File Name     : hdmi_common.h
  Version       : Initial Draft
  Author        : Hisilicon multimedia software group
  Created       : 2014/1/3
  Description   : 
  History       :
  1.Date        : 2014/3/15
    Author      : c00189109
    Modification: Created file
******************************************************************************/
#ifndef __DRV_HDMI_COMMON_H__
#define __DRV_HDMI_COMMON_H__

#include "hi_type.h"
#include "hi_debug.h"
#include "hi_common.h"

#include "hi_drv_video.h"
#include "hi_unf_video.h"


#ifdef __cplusplus
 #if __cplusplus
    extern "C" {
 #endif
#endif /* __cplusplus */


#define HDMI_FATAL(fmt...) \
            HI_FATAL_PRINT(HI_ID_HDMIRX, fmt)

#define HDMI_ERROR(fmt...) \
            HI_ERR_PRINT(HI_ID_HDMIRX, fmt)

#define HDMI_WARN(fmt...) \
            HI_WARN_PRINT(HI_ID_HDMIRX, fmt)

#define HDMI_INFO(fmt...) \
            HI_INFO_PRINT(HI_ID_HDMIRX, fmt)

#define HDMI_DBG(fmt...) \
            HI_DBG_PRINT(HI_ID_HDMIRX, fmt)

#ifdef __cplusplus
 #if __cplusplus
    }
 #endif
#endif /* __cplusplus */

#endif /* #ifndef __DRV_MEMC_COMMON_H__ */


