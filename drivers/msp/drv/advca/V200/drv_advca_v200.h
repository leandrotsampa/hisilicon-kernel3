/******************************************************************************

  Copyright (C), 2011-2014, Hisilicon Tech. Co., Ltd.

 ******************************************************************************
  File Name     : drv_advca_v200.h
  Version       : Initial Draft
  Author        : Hisilicon hisecurity team
  Created       : 
  Last Modified :
  Description   : 
  Function List :
  History       :
******************************************************************************/

#ifndef __DRV_ADVCA_V200_H__
#define __DRV_ADVCA_V200_H__

#include "drv_advca_external.h"

/* CA_MAILBOX */
#ifdef SDK_SECURITY_ARCH_VERSION_V2
#define CA_BASE_ADDR          0x101c0000
#define CA_CRG_ADDR_CLK       0x101e0024
#define CA_CRG_ADDR_SRST_REQ  0x101e0028
#define CA_SYSCTRL_BASE       0x101e0000
#else
#define CA_BASE_ADDR 0x10000000
#define CA_CRG_ADDR  0x101F50B4
#endif

#define CA_V200_SECURE_BOOT_CFG_ADD   (CA_BASE_ADDR + 0x00)
#define CA_V200_SECURE_BOOT_STAT_ADD  (CA_BASE_ADDR + 0x04)
#define CA_V200_MARKET_SID_REF_ADD    (CA_BASE_ADDR + 0x08)
#define CA_V200_CHIP_ID_ADD           (CA_BASE_ADDR + 0x0c)
#define CA_V200_STB_SN_ADD            (CA_BASE_ADDR + 0x10)
#define CA_V200_DIN0_ADD              (CA_BASE_ADDR + 0x20)
#define CA_V200_DIN1_ADD              (CA_BASE_ADDR + 0x24)
#define CA_V200_DIN2_ADD              (CA_BASE_ADDR + 0x28)
#define CA_V200_DIN3_ADD              (CA_BASE_ADDR + 0x2c)
#define CA_V200_CTRL_ADD              (CA_BASE_ADDR + 0x30)
#define CA_V200_SET_ADD               (CA_BASE_ADDR + 0x34)
#define CA_V200_STAT_ADD              (CA_BASE_ADDR + 0x38)
#define CA_V200_INT_STAT_ADD          (CA_BASE_ADDR + 0x40)
#define CA_V200_INT_EN_ADD            (CA_BASE_ADDR + 0x44)
#define CA_V200_INT_RAW_ADD           (CA_BASE_ADDR + 0x48)
#define CA_V200_LOAD_OTP_ADD          (CA_BASE_ADDR + 0x4c)
#define CA_V200_RST_ST_ADD            (CA_BASE_ADDR + 0x50)
#define CA_V200_DOUT0_ADD             (CA_BASE_ADDR + 0x60)
#define CA_V200_DOUT1_ADD             (CA_BASE_ADDR + 0x64)
#define CA_V200_DOUT2_ADD             (CA_BASE_ADDR + 0x68)
#define CA_V200_DOUT3_ADD             (CA_BASE_ADDR + 0x6c)
#define CA_V200_JTAG_KEY0_ADD         (CA_BASE_ADDR + 0x70)
#define CA_V200_JTAG_KEY1_ADD         (CA_BASE_ADDR + 0x74)
#define CA_V200_CTRL_PROC_ADD         (CA_BASE_ADDR + 0x78)
#define CA_V200_PRM_OTP_ADD           (CA_BASE_ADDR + 0x7c)
#define CA_V200_DVB_ROOT_KEY0_ADD     (CA_BASE_ADDR + 0x80)
#define CA_V200_DVB_ROOT_KEY1_ADD     (CA_BASE_ADDR + 0x84)
#define CA_V200_DVB_ROOT_KEY2_ADD     (CA_BASE_ADDR + 0x88)
#define CA_V200_DVB_ROOT_KEY3_ADD     (CA_BASE_ADDR + 0x8C)
#define CA_V200_R2R_ROOT_KEY0_ADD     (CA_BASE_ADDR + 0x90)
#define CA_V200_R2R_ROOT_KEY1_ADD     (CA_BASE_ADDR + 0x94)
#define CA_V200_R2R_ROOT_KEY2_ADD     (CA_BASE_ADDR + 0x98)
#define CA_V200_R2R_ROOT_KEY3_ADD     (CA_BASE_ADDR + 0x9C)
#define CA_V200_LP_SET_ADD            (CA_BASE_ADDR + 0xa0)
#define CA_V200_DEBUG_INFO_ADD        (CA_BASE_ADDR + 0xa4)
#define CA_V200_LPK_RDY_ADD           (CA_BASE_ADDR + 0xa8)
#define CA_V200_LP_PARAMETER_0_ADD    (CA_BASE_ADDR + 0xb0)
#define CA_V200_LP_PARAMETER_1_ADD    (CA_BASE_ADDR + 0xb4)
#define CA_V200_LP_PARAMETER_2_ADD    (CA_BASE_ADDR + 0xb8)
#define CA_V200_LP_PARAMETER_3_ADD    (CA_BASE_ADDR + 0xbc)
#define CA_V200_RSV0_INFO_ADD         (CA_BASE_ADDR + 0xc0)
#define CA_V200_RSV1_INFO_ADD         (CA_BASE_ADDR + 0xc4)
#define CA_V200_RSV2_INFO_ADD         (CA_BASE_ADDR + 0xc8)
#define CA_V200_RSV3_INFO_ADD         (CA_BASE_ADDR + 0xcc)
#define CA_V200_VERSION_ADD           (CA_BASE_ADDR + 0xd0)


/* OTP */
#define OTP_CA_PRM0       (0x00)
#define OTP_CA_PRM1       (0x04)
#define OTP_CA_PRM2       (0x08)
#define OTP_CA_PRM3       (0x0c)
#define OTP_CA_PRM4       (0x10)
#define OTP_CA_PRM5       (0x14)
#define OTP_CA_PRM6       (0x18)
#define OTP_CA_PRM7       (0x1C)

#define OTP_BOOT_MODE_SEL_0      (0x00)
#define OTP_BOOT_MODE_SEL_1      (0x01)
#define OTP_SCS_ACTIVATION       (0x02) 
#define OTP_JTAG_PRT_MODE_0      (0x03) 
#define OTP_JTAG_PRT_MODE_1      (0x04)  
#define OTP_CW_KEY_DEACTIVATION  (0x05)  
#define OTP_R2R_KEY_DEACTIVATION (0x06)  
#define OTP_DEBUG_DISABLE        (0x07) 
#define OTP_RSV                  (0x08)
#define OTP_JTAG_KEY_LEN         (0x09)
#define OTP_MKT_ID_P             (0x0A)
#define OTP_STB_SN_P             (0x0B)
#define OTP_CW_LV_ORG            (0x0C)
#define OTP_CW_LV_SEL            (0x0D)
#define OTP_SECURE_CHIP_P        (0x0E)
#define OTP_CW_INFO_P            (0x0F)
#define OTP_BLOAD_DEC_EN         (0x10)
#define OTP_R2R_LV_SEL           (0x11)
#define OTP_LINK_PRT_DISABLE     (0x12)
#define OTP_BOOTSEL_LOCK         (0x13)
#define OTP_CA_RSV_LOCK          (0x14)
#define OTP_TDES_LOCK            (0x15)
#define OTP_CW_LV_LOCK           (0x16)
#define OTP_R2R_LV_LOCK          (0x17)
#define OTP_R2R_HARD_KEY_LOCK    (0x18)
#define OTP_SELF_BOOT_DISABLE    (0x19)
#define OTP_LOW_POWER_DISABLE    (0x1a)
#define OTP_MISC_CTRL_EN         (0x1b)

#define OTP_JTAG_KEY0     (0x20)
#define OTP_JTAG_KEY1     (0x24)
#define OTP_CHIPID        (0x28)
#define OTP_MARKETID      (0x2c)
#define OTP_DVB_ROOTKEY0  (0x30)
#define OTP_DVB_ROOTKEY1  (0x34)
#define OTP_DVB_ROOTKEY2  (0x38)
#define OTP_DVB_ROOTKEY3  (0x3C)
#define OTP_R2R_ROOTKEY0  (0x40)
#define OTP_R2R_ROOTKEY1  (0x44)
#define OTP_R2R_ROOTKEY2  (0x48)
#define OTP_R2R_ROOTKEY3  (0x4C)
#define OTP_STB_SN        (0x50)
#define OTP_SECURE_CHIP   (0x55)   /*CA manufacturer ID*/
#define OTP_CW_INFO_RSV   (0x57)
#define OTP_CW_HARD_SEL   (0x58)
#define OTP_CSA3_SEL      (0x5C)
#define OTP_HDCP          (0x60)
#define OTP_RSA           (0x200)
#define OTP_SR            (0x400)


HI_S32 DRV_ADVCA_V200_SWPKKeyLadderOpen(HI_VOID);
HI_S32 DRV_ADVCA_V200_SWPKKeyLadderClose(HI_VOID);
HI_S32 ca_getChipID(HI_U32 *pID);
HI_S32 ca_getUniqueChipID(HI_U8 *pID);
HI_S32 ca_getMarketID(HI_U8 u8Id[4]);
HI_U32 ca_v200_rdReg(HI_U32 u32RegAddr);
HI_S32 ca_getCWLadder(HI_UNF_ADVCA_KEYLADDER_LEV_E *psel);
HI_S32 ca_getR2RLadder(HI_UNF_ADVCA_KEYLADDER_LEV_E *psel);
HI_S32 ca_StatHardCwSel(HI_U32 *pbLock);
HI_S32 ca_StatR2RHardKey(HI_U32 *pbLock);
HI_S32 otp_getSCSActive(HI_U32 *penable);
HI_S32 otp_getBootMode(HI_UNF_ADVCA_FLASH_TYPE_E *pSel);


#endif	/* __DRV_ADVCA_V200_H__ */