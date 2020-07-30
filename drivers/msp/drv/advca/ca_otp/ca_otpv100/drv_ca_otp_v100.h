/******************************************************************************

  Copyright (C), 2011-2014, Hisilicon Tech. Co., Ltd.

 ******************************************************************************
  File Name     : drv_ca_otp_v100.h
  Version       : Initial Draft
  Author        : Hisilicon hisecurity team
  Created       : 
  Last Modified :
  Description   : CA OTPV100 FUNC DECLARE
  Function List :
  History       :
******************************************************************************/
#ifndef __DRV_CA_OTP_V100_H__
#define __DRV_CA_OTP_V100_H__

#include "drv_advca_external.h"

HI_S32 DRV_CA_OTP_V100_Set_MarketId(HI_U32 Id);
HI_S32 DRV_CA_OTP_V100_Set_STBSN(HI_U32 SN);
HI_S32 DRV_CA_OTP_V100_LockHardCwSel(HI_VOID);
HI_S32 DRV_CA_OTP_V100_LockBootDecEn(HI_VOID);
HI_S32 DRV_CA_OTP_V100_LockR2RHardKey(HI_VOID);
HI_S32 DRV_CA_OTP_V100_DisableLinkProtect(HI_VOID);
HI_S32 DRV_CA_OTP_V100_DisableSelfBoot(HI_U32 selfBoot);
HI_S32 DRV_CA_OTP_V100_SetBootMode(HI_U8 type);
HI_S32 DRV_CA_OTP_V100_SetSCSActive(HI_VOID);
HI_S32 DRV_CA_OTP_V100_SetJtagProtectMode(HI_U8 JtagMode);

#endif /* __DRV_CA_OTP_V100_H__ */
