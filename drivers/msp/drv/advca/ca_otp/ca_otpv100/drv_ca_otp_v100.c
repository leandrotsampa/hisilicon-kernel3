/******************************************************************************

  Copyright (C), 2011-2014, Hisilicon Tech. Co., Ltd.

 ******************************************************************************
  File Name     : drv_ca_otp_v100.c
  Version       : Initial Draft
  Author        : Hisilicon hisecurity team
  Created       : 
  Last Modified :
  Description   : CA OTPV100 FUNC DEFINE
  Function List :
  History       :
******************************************************************************/
#include "drv_advca_internal.h"
#include "drv_advca_external.h"

extern OTP_EXPORT_FUNC_S *g_pOTPExportFunctionList;

#define ca_otp_rd_u32(addr, val) do { \
        val = HAL_OTP_V100_Read(addr); \
    } while (0)

#define ca_otp_wt_u32(addr, val) do { \
        HI_S32 Ret = HI_SUCCESS; \
        unsigned char *ptr = (unsigned char *)&val; \
        Ret = (g_pOTPExportFunctionList->HAL_OTP_V100_WriteByte)((addr + 0), ptr[0]); \
        Ret |= (g_pOTPExportFunctionList->HAL_OTP_V100_WriteByte)((addr + 1), ptr[1]); \
        Ret |= (g_pOTPExportFunctionList->HAL_OTP_V100_WriteByte)((addr + 2), ptr[2]); \
        Ret |= (g_pOTPExportFunctionList->HAL_OTP_V100_WriteByte)((addr + 3), ptr[3]); \
        if (HI_SUCCESS != Ret) \
        { \
            HI_FATAL_CA("Failed to write OTP!\n"); \
            return Ret; \
        } \
    } while (0)

#define ca_otp_wt_u8(addr, val) do { \
        HI_S32 Ret = HI_SUCCESS; \
        Ret = (g_pOTPExportFunctionList->HAL_OTP_V100_WriteByte)(addr, val); \
        if (HI_SUCCESS != Ret) \
        { \
            HI_FATAL_CA("Failed to write OTP!\n"); \
            return Ret; \
        } \
    } while (0)

#define ca_otp_wt_Bit(addr, pos, val) do { \
        HI_S32 Ret = HI_SUCCESS; \
        Ret = (g_pOTPExportFunctionList->HAL_OTP_V100_WriteBit)(addr, pos, val); \
        if (HI_SUCCESS != Ret) \
        { \
            HI_FATAL_CA("Failed to write OTP!\n"); \
            return Ret; \
        } \
    } while (0)

HI_S32 DRV_CA_OTP_V100_Set_MarketId(HI_U32 Id)
{
    HI_S32    ret = HI_SUCCESS;
    
    /* write to OTP and Set a used tag(CA_OTP_MKT_ID_P) */
    ca_otp_wt_u32(CA_OTP_MARKETID, Id);
    ca_otp_wt_u8(CA_OTP_MKT_ID_P, 0xff);
    
    return ret;
}

HI_S32 DRV_CA_OTP_V100_Set_STBSN(HI_U32 SN)
{
    HI_S32    ret = HI_SUCCESS;
    
    /* write to OTP and Set a used tag(CA_OTP_STB_SN_P) */
    ca_otp_wt_u32(CA_OTP_STB_SN, SN);
    ca_otp_wt_u8(CA_OTP_STB_SN_P, 0x0);
    
    return ret;
}

HI_S32 DRV_CA_OTP_V100_LockHardCwSel(HI_VOID)
{
    HI_U32    Value;
    HI_S32    ret = HI_SUCCESS;
    
    /*  write to OTP and Set a used tag(CA_OTP_CW_INFO_P) */
    Value = 0xFFFFFFFF;
    ca_otp_wt_u32(CA_OTP_CW_HARD_SEL,Value);  /* 32 multi-CW */
    ca_otp_wt_u8(CA_OTP_CW_INFO_P, 0x0);
    
    return ret;
}

HI_S32 DRV_CA_OTP_V100_LockBootDecEn(HI_VOID)
{
    HI_S32    ret = HI_SUCCESS;

    /* write to OTP */
    ca_otp_wt_u8(CA_OTP_BLOAD_DEC_EN,0xFF);
    
    return ret;
}

HI_S32 DRV_CA_OTP_V100_LockR2RHardKey(HI_VOID)
{
    HI_S32    ret = HI_SUCCESS;

    /* write to OTP */
    ca_otp_wt_u8(CA_OTP_R2R_HARD_KEY_LOCK,0xFF);
    
    return ret;
}

HI_S32 DRV_CA_OTP_V100_DisableLinkProtect(HI_VOID)
{
    HI_S32    ret = HI_SUCCESS;

    /* write to OTP */
    ca_otp_wt_u8(CA_OTP_LINK_PRT_DISABLE,0xFF);
    
    return ret;
}

HI_S32 DRV_CA_OTP_V100_DisableSelfBoot(HI_U32 selfBoot)
{
    HI_S32    ret = HI_SUCCESS;

    if (selfBoot)
    {
        /* write to OTP */
        ca_otp_wt_u8(CA_OTP_SELF_BOOT_DISABLE,0x0);
    }
    
    return ret;
}

HI_S32 DRV_CA_OTP_V100_SetBootMode(HI_U8 type)
{
    HI_S32    ret = HI_SUCCESS;

    switch (type)
    {
    case CA_OTP_FLASH_TYPE_NAND :
        ca_otp_wt_u8(CA_OTP_BOOT_MODE_SEL_0, 0xff);
        break;
    case CA_OTP_FLASH_TYPE_NOR :
        break;
    case CA_OTP_FLASH_TYPE_EMMC:
        ca_otp_wt_u8(CA_OTP_BOOT_MODE_SEL_0, 0xff);
        ca_otp_wt_u8(CA_OTP_BOOT_MODE_SEL_1, 0x0);               
        break;
    default:
        ;/* default SPI Flash */
    }
    return ret;
}

HI_S32 DRV_CA_OTP_V100_SetSCSActive(HI_VOID)
{
    HI_S32    ret = HI_SUCCESS;

    /* write to OTP */
    ca_otp_wt_u8(CA_OTP_SCS_ACTIVATION, 0xff);
    
    return ret;
}

HI_S32 DRV_CA_OTP_V100_SetJtagProtectMode(HI_U8 JtagMode)
{
    HI_S32    ret = HI_SUCCESS;

    switch (JtagMode)
    {
    case CA_OTP_JTAG_MODE_PROTECT :
        ca_otp_wt_u8(CA_OTP_JTAG_PRT_MODE_0, 0x00);
        break;
    case CA_OTP_JTAG_MODE_CLOSED:
        ca_otp_wt_u8(CA_OTP_JTAG_PRT_MODE_1, 0xFF);         
        break;
    default:
        ;/* default Open Mode */
    }
    return ret;
}
/*--------------------------------------END--------------------------------------*/
