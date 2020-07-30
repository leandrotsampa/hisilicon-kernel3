/******************************************************************************

  Copyright (C), 2011-2014, Hisilicon Tech. Co., Ltd.

 ******************************************************************************
  File Name     : drv_ca_otp_reg_v100.h
  Version       : Initial Draft
  Author        : Hisilicon hisecurity team
  Created       : 
  Last Modified :
  Description   : CA OTPV100 REG DEFINE
  Function List :
  History       :
******************************************************************************/

/* OTP Address */
#ifndef __DRV_CA_OTP_REG_V100_H__
#define __DRV_CA_OTP_REG_V100_H__

/* OTP */
#define CA_OTP_CA_PRM0       (0x00)
#define CA_OTP_CA_PRM1       (0x04)
#define CA_OTP_CA_PRM2       (0x08)
#define CA_OTP_CA_PRM3       (0x0c)
#define CA_OTP_CA_PRM4       (0x10)
#define CA_OTP_CA_PRM5       (0x14)
#define CA_OTP_CA_PRM6       (0x18)
#define CA_OTP_CA_PRM7       (0x1C)

#define CA_OTP_BOOT_MODE_SEL_0      (0x00)
#define CA_OTP_BOOT_MODE_SEL_1      (0x01)
#define CA_OTP_SCS_ACTIVATION       (0x02) 
#define CA_OTP_JTAG_PRT_MODE_0      (0x03) 
#define CA_OTP_JTAG_PRT_MODE_1      (0x04)  
#define CA_OTP_CW_KEY_DEACTIVATION  (0x05)  
#define CA_OTP_R2R_KEY_DEACTIVATION (0x06)  
#define CA_OTP_DEBUG_DISABLE        (0x07) 
#define CA_OTP_RSV                  (0x08)
#define CA_OTP_JTAG_KEY_LEN         (0x09)
#define CA_OTP_MKT_ID_P             (0x0A)
#define CA_OTP_STB_SN_P             (0x0B)
#define CA_OTP_CW_LV_ORG            (0x0C)
#define CA_OTP_CW_LV_SEL            (0x0D)
#define CA_OTP_SECURE_CHIP_P        (0x0E)
#define CA_OTP_CW_INFO_P            (0x0F)
#define CA_OTP_BLOAD_DEC_EN         (0x10)
#define CA_OTP_R2R_LV_SEL           (0x11)
#define CA_OTP_LINK_PRT_DISABLE     (0x12)
#define CA_OTP_BOOTSEL_LOCK         (0x13)
#define CA_OTP_CA_RSV_LOCK          (0x14)
#define CA_OTP_TDES_LOCK            (0x15)
#define CA_OTP_CW_LV_LOCK           (0x16)
#define CA_OTP_R2R_LV_LOCK          (0x17)
#define CA_OTP_R2R_HARD_KEY_LOCK    (0x18)
#define CA_OTP_SELF_BOOT_DISABLE    (0x19)

#define CA_OTP_JTAG_KEY0     (0x20)
#define CA_OTP_JTAG_KEY1     (0x24)
#define CA_OTP_CHIPID        (0x28)
#define CA_OTP_MARKETID      (0x2c)
#define CA_OTP_DVB_ROOTKEY0  (0x30)
#define CA_OTP_DVB_ROOTKEY1  (0x34)
#define CA_OTP_DVB_ROOTKEY2  (0x38)
#define CA_OTP_DVB_ROOTKEY3  (0x3C)
#define CA_OTP_R2R_ROOTKEY0  (0x40)
#define CA_OTP_R2R_ROOTKEY1  (0x44)
#define CA_OTP_R2R_ROOTKEY2  (0x48)
#define CA_OTP_R2R_ROOTKEY3  (0x4C)
#define CA_OTP_STB_SN        (0x50)
#define CA_OTP_SECURE_CHIP   (0x55)   /*CA manufacturer ID*/
#define CA_OTP_CW_INFO_RSV   (0x57)
#define CA_OTP_CW_HARD_SEL   (0x58)
#define CA_OTP_CSA3_SEL      (0x5C)
#define CA_OTP_RSA           (0x200)
#define CA_OTP_SR            (0x400)

typedef union
{
    struct
    {
        HI_U32 boot_mode_sel_0      : 8;
        HI_U32 boot_mode_sel_1      : 8;
        HI_U32 SCS_active           : 8;
        HI_U32 jtag_prt_mode_0      : 8;
    } bits;
    HI_U32 u32;
} CA_OTP_PRM0_U;

typedef union
{
    struct
    {
        HI_U32 jtag_prt_mode_1      : 8;
        HI_U32 cw_key_deactive      : 8;
        HI_U32 r2r_key_deactive     : 8;
        HI_U32 debug_disable        : 8;
    } bits;
    HI_U32 u32;
} CA_OTP_PRM1_U;

typedef union
{
    struct
    {
        HI_U32 rsv              : 8;
        HI_U32 jtag_key_len     : 8;
        HI_U32 mkt_id_p         : 8;
        HI_U32 stb_sn_p         : 8;
    } bits;
    HI_U32 u32;
} CA_OTP_PRM2_U;

typedef union
{
    struct
    {
        HI_U32 cw_lv_org        : 8;
        HI_U32 cw_lv_sel        : 8;
        HI_U32 secure_chip_p    : 8;
        HI_U32 cw_info_p        : 8;
    } bits;
    HI_U32 u32;
}CA_OTP_PRM3_U;

typedef union
{
    struct
    {
        HI_U32 bload_dec_en     : 8;
        HI_U32 r2r_lv_sel       : 8;
        HI_U32 link_prt_disable : 8;
        HI_U32 bootsel_lock     : 8;
    } bits;
    HI_U32 u32;
}CA_OTP_PRM4_U;

typedef union
{
    struct
    {
        HI_U32 ca_rsv_lock      : 8;
        HI_U32 tdes_lock        : 8;
        HI_U32 cw_lv_lock       : 8;
        HI_U32 r2r_lv_lock      : 8;
    } bits;
    HI_U32 u32;
}CA_OTP_PRM5_U;

typedef union
{
    struct
    {
        HI_U32 r2r_hard_key_lock: 8;
        HI_U32 self_boot_disable: 8;
        HI_U32 rsv1             : 8;
        HI_U32 rsv2             : 8;
    } bits;
    HI_U32 u32;
}CA_OTP_PRM6_U;

#endif /* __DRV_CA_OTP_REG_V100_H__ */
/*-----------------------------------------END------------------------------------*/
