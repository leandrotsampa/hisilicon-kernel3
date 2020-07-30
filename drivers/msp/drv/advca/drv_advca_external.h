/******************************************************************************

  Copyright (C), 2011-2014, Hisilicon Tech. Co., Ltd.

 ******************************************************************************
  File Name     : drv_advca_external.h
  Version       : Initial Draft
  Author        : Hisilicon hisecurity team
  Created       : 
  Last Modified :
  Description   : 
  Function List :
  History       :

******************************************************************************/

#ifndef __DRV_ADVCA_EXTERNAL_H__
#define __DRV_ADVCA_EXTERNAL_H__

#ifdef __cplusplus
extern "C" {
#endif

#ifdef SDK_SECURITY_ARCH_VERSION_V3
#include "hi_type.h"
#include "hi_unf_advca.h"
#include "hi_unf_cipher.h"
#include "hi_drv_advca.h"
#include "hi_error_mpi.h"
#include "drv_advca.h"
#include "drv_advca_ext.h"
#include "drv_advca_ioctl.h"
#include "drv_otp_ext.h"
#include "drv_otp_ioctl.h"
#else
#ifdef SDK_SECURITY_ARCH_VERSION_V2
#include "hi_struct.h"
#include "advca_X5SD_dump.h"
#include "hi_ecs_errcode.h"
#else
#include "hi_unf_ecs.h"
#include "hi_error_ecs.h"
#include "priv_otp.h"
#include "common_dev.h"
#include "common_proc.h"
#include "common_mem.h"
#include "hi_common.h"
#include "common_sys.h"
#endif
#endif


#ifdef __cplusplus
}
#endif
#endif /* __DRV_ADVCA_EXTERNAL_H__ */
