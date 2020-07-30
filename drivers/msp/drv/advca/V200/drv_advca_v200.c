/******************************************************************************

  Copyright (C), 2011-2014, Hisilicon Tech. Co., Ltd.

 ******************************************************************************
  File Name     : drv_advca_v200.c
  Version       : Initial Draft
  Author        : Hisilicon hisecurity team
  Created       :
  Last Modified :
  Description   :
  Function List :
  History       :
******************************************************************************/
#include "drv_advca_internal.h"
#include "drv_advca_external.h"
#include "asm/io.h"
extern OTP_EXPORT_FUNC_S *g_pOTPExportFunctionList;

/*************************************************************************
*   Macro Definition   *
*************************************************************************/
#define otp_rd_u32(addr, val) do { \
        val = (g_pOTPExportFunctionList->HAL_OTP_V100_Read)(addr); \
    } while (0)

#define otp_wt_u32(addr, val) do { \
        HI_S32 Ret = HI_SUCCESS; \
        unsigned char *ptr = (unsigned char *)&val; \
        Ret = (g_pOTPExportFunctionList->HAL_OTP_V100_WriteByte)((addr + 0), ptr[0]); \
        Ret |= (g_pOTPExportFunctionList->HAL_OTP_V100_WriteByte)((addr + 1), ptr[1]); \
        Ret |= (g_pOTPExportFunctionList->HAL_OTP_V100_WriteByte)((addr + 2), ptr[2]); \
        Ret |= (g_pOTPExportFunctionList->HAL_OTP_V100_WriteByte)((addr + 3), ptr[3]); \
        if (HI_SUCCESS != Ret) \
        { \
            HI_ERR_CA("Fail to write OTP!\n"); \
            return Ret; \
        } \
    } while (0)

#define otp_wt_u8(addr, val) do { \
        HI_S32 Ret = HI_SUCCESS; \
        Ret = (g_pOTPExportFunctionList->HAL_OTP_V100_WriteByte)(addr, val); \
        if (HI_SUCCESS != Ret) \
        { \
            HI_ERR_CA("Fail to write OTP!\n"); \
            return Ret; \
        } \
    } while (0)

#define otp_wt_Bit(addr, pos, val) do { \
        HI_S32 Ret = HI_SUCCESS; \
        Ret = (g_pOTPExportFunctionList->HAL_OTP_V100_WriteBit)(addr, pos, val); \
        if (HI_SUCCESS != Ret) \
        { \
            HI_ERR_CA("Fail to write OTP!\n"); \
            return Ret; \
        } \
    } while (0)

/*************************************************************************
*  Structure  *
*************************************************************************/
// otp reg
typedef union
{
    struct
    {
        HI_U32 boot_mode_sel_0       : 1;
        HI_U32 boot_mode_sel_1       : 1;
        HI_U32 scs_activation        : 1;
        HI_U32 jtag_prt_mode_0       : 1;
        HI_U32 jtag_prt_mode_1       : 1;
        HI_U32 cw_key_deactivation   : 1;
        HI_U32 r2r_key_deactivation  : 1;
        HI_U32 debug_disable         : 1;
        HI_U32 rsv1                  : 1;
        HI_U32 jtag_key_len          : 1;
        HI_U32 mkt_id_p              : 1;
        HI_U32 stb_sn_p              : 1;
        HI_U32 cw_lv_org             : 1;
        HI_U32 cw_lv_sel             : 1;
        HI_U32 secure_chip_p         : 1;
        HI_U32 cw_info_p             : 1;
        HI_U32 bload_dec_en          : 1;
        HI_U32 r2r_lv_sel            : 1;
        HI_U32 link_prt_disable      : 1;
        HI_U32 bootsel_lock          : 1;
        HI_U32 ca_rsv_lock           : 1;
        HI_U32 tdes_lock             : 1;
        HI_U32 cw_lv_lock            : 1;
        HI_U32 r2r_lv_lock           : 1;
        HI_U32 r2r_hard_key_lock     : 1;
        HI_U32 self_boot_disable     : 1;
        HI_U32 low_power_disable     : 1;
        HI_U32 misc_ctrl_en          : 1;
        HI_U32 ca_vendor             : 4;
    } bits;
    HI_U32 u32;
} CA_PF_OTP_U;

/*************************************************************************
*  Variable  *
*************************************************************************/
static HI_U8 *g_CaVirAddr = 0;


static CA_PF_OTP_U g_CurPfOtp;
static CA_PF_OTP_U g_OrgPfOtp;

static HI_UNF_ADVCA_ALG_TYPE_E g_CwAlgType;
static HI_UNF_ADVCA_ALG_TYPE_E g_R2RAlgType;
static HI_UNF_ADVCA_KEYLADDER_LEV_E g_CwLadderSel;
static HI_UNF_ADVCA_KEYLADDER_LEV_E g_R2RLadderSel;

static HI_BOOL g_IsSWPKKeyLadderOpen = HI_FALSE;

static HI_U32 *pDrvSema = NULL;

HI_VOID ca_v200_ReadReg(HI_U32 addr, HI_U32 *pu32Result)
{
    HI_U32 temp_addr = (addr - CA_BASE);
    HI_REG_READ32(temp_addr, *pu32Result);
    return;
}

HI_VOID ca_v200_WriteReg(HI_U32 addr, HI_U32 u32Result)
{
    HI_U32 temp_addr = (addr - CA_BASE);
    HI_REG_READ32(temp_addr, u32Result);
    return;
}

/*************************************************************************
*  ca & otp func  *
*************************************************************************/
HI_S32 ca_getChipID(HI_U32 *pID)
{
    HI_U32 chipid = 0;

    if (pID == NULL)
    {
        HI_ERR_CA("Param error\n");
        return HI_ERR_CA_INVALID_PARA;
    }

    ca_v200_ReadReg(CA_V200_CHIP_ID_ADD, &chipid);
    if (0 == chipid)
    {
        otp_rd_u32(OTP_CHIPID, chipid);
    }

    *pID = chipid;

    return HI_SUCCESS;
}

HI_S32 ca_getUniqueChipID(HI_U8 *pID)
{
    unsigned int *ptr;
    HI_U32 chipid = 0;

    if (pID == NULL)
    {
        HI_ERR_CA("Param error\n");
        return HI_ERR_CA_INVALID_PARA;
    }

    ptr = (unsigned int *)pID;
    ca_v200_ReadReg(CA_V200_CHIP_ID_ADD, &chipid);
    if (0 == chipid)
    {
        otp_rd_u32(OTP_CHIPID, chipid);
    }

    *ptr = chipid;

    return HI_SUCCESS;
}

HI_S32 ca_getMktIdP(HI_U32 *pMktIdP)
{
    HI_U32 mktIdP = 0;

    if (NULL == pMktIdP)
    {
        return HI_ERR_CA_INVALID_PARA;
    }

    otp_rd_u32(OTP_MKT_ID_P, mktIdP);

    if (0 == (mktIdP & 0xff))
    {
        *pMktIdP = 0;
    }
    else
    {
        *pMktIdP = 1;
    }

    return HI_SUCCESS;
}

HI_S32 ca_setMktIdP(HI_VOID)
{
    HI_U32 u32MktIdP = 0;

    ca_getMktIdP(&u32MktIdP);
    if (1 == u32MktIdP)
    {
        return HI_SUCCESS;
    }

    otp_wt_u8(OTP_MKT_ID_P, 0xff);

    g_CurPfOtp.bits.mkt_id_p = 1;

    return HI_SUCCESS;
}

HI_S32 ca_getMarketID(HI_U8 u8Id[4])
{
    unsigned int *ptr;
    HI_U32 MarketID = 0;

    if (u8Id == NULL)
    {
        HI_ERR_CA("Param error\n");
        return HI_ERR_CA_INVALID_PARA;
    }

    ptr = (unsigned int *)u8Id;
    ca_v200_ReadReg(CA_V200_MARKET_SID_REF_ADD, &MarketID);
    if (0 == MarketID)
    {
        otp_rd_u32(OTP_MARKETID, MarketID);
    }

    *ptr = MarketID;

    return HI_SUCCESS;
}

/** Here set otp */
HI_S32 ca_setMarketID(HI_U8 u8Id[4])
{
    /* Once programmed, Cann't set again! */
    unsigned short index = 0;
    unsigned int marketIDP = 0;
    HI_U8 u8CurrentMarketID[4] = {0};

    ca_getMktIdP(&marketIDP);
    ca_getMarketID(u8CurrentMarketID);

    if (marketIDP)
    {
        for ( index = 0 ; index < 4 ; index++ )
        {
            if (u8CurrentMarketID[index] != u8Id[index])
            {
                break;
            }
        }

        /*If u8Id has been set as the Market Id already, HI_SUCCESS should be returned*/
        if (index == 4)
        {
            return HI_SUCCESS;
        }
        else
        {
            /*if Market Id has been set, but it's not u8Id, HI_ERR_CA_SETPARAM_AGAIN should be returned*/
            HI_ERR_CA("MarketID can not set again\n");
            return HI_ERR_CA_SETPARAM_AGAIN;
        }
    }

    /* write to OTP and Set a used tag(OTP_MKT_ID_P) */
    for(index = 0; index < 4; index++)
    {
        otp_wt_u8(OTP_MARKETID+index, u8Id[index]);
    }
    otp_wt_u8(OTP_MKT_ID_P, 0xff);
    g_CurPfOtp.bits.mkt_id_p = 1;

    return HI_SUCCESS;
}

HI_S32 ca_setMarketIDEx(HI_U32 Id)
{
    HI_U32 u32MarketId = 0;
    HI_U32 u32MarketIdP = 0;

    ca_v200_ReadReg(CA_V200_MARKET_SID_REF_ADD, &u32MarketId);

    ca_getMktIdP(&u32MarketIdP);
    if (1 == u32MarketIdP)
    {
        if (u32MarketId == Id)
        {
            /* if Id has been set as the Market Id already, HI_SUCCESS should be returned*/
            return HI_SUCCESS;
        }
        else
        {
            /*if Market Id has been set, but it's not Id, HI_ERR_CA_SETPARAM_AGAIN should be returned*/
            HI_ERR_CA("MarketID can not set again\n");
            return HI_ERR_CA_SETPARAM_AGAIN;
        }
    }

    otp_wt_u32(OTP_MARKETID, Id);
    otp_wt_u8(OTP_MKT_ID_P, 0xff);

    g_CurPfOtp.bits.mkt_id_p = 1;

    return HI_SUCCESS;
}

HI_S32 ca_getMarketIDEx(HI_U32 *pId)
{
    HI_U32 marketID = 0;

    if (pId == NULL)
    {
        HI_ERR_CA("Param error\n");
        return HI_ERR_CA_INVALID_PARA;
    }

    ca_v200_ReadReg(CA_V200_MARKET_SID_REF_ADD, &marketID);
    *pId = marketID;

    return HI_SUCCESS;
}

HI_S32 ca_getStbSnP(HI_U32 *pStbSnP)
{
    HI_U32 stbSnP = 0;

    if (NULL == pStbSnP)
    {
        return HI_ERR_CA_INVALID_PARA;
    }

    otp_rd_u32(OTP_STB_SN_P, stbSnP);

    if (0 == (stbSnP & 0xff))
    {
        *pStbSnP = 1;
    }
    else
    {
        *pStbSnP = 0;
    }

    return HI_SUCCESS;
}

HI_S32 ca_setStbSnP(HI_U32 stbSnP)
{
    HI_U32 u32StbSnP = 0;

    ca_getStbSnP(&u32StbSnP);
    if (stbSnP)
    {
        if (1 == u32StbSnP)
        {
            return HI_SUCCESS;
        }

        otp_wt_u8(OTP_STB_SN_P, 0x0);

        g_CurPfOtp.bits.stb_sn_p = 1;
    }

    return HI_SUCCESS;
}

HI_S32 ca_getStbSN(HI_U8 u8SN[4])
{
    unsigned int *ptr;
    HI_U32 stbSn = 0;

    if (u8SN == NULL)
    {
        HI_ERR_CA("Param error\n");
        return HI_ERR_CA_INVALID_PARA;
    }

    ptr = (unsigned int *)u8SN;
    ca_v200_ReadReg(CA_V200_STB_SN_ADD, &stbSn);
    if (0 == stbSn)
    {
        otp_rd_u32(OTP_STB_SN, stbSn);
    }

    *ptr = stbSn;

    return HI_SUCCESS;
}

HI_S32 ca_setStbSN(HI_U8 u8SN[4])
{
    /* Once programmed, Cann't set again! */
    unsigned short index = 0;
    HI_U32 u32StbSnP = 0;
    HI_U8 u8CurrentStbSN[4] = {0};

    ca_getStbSnP(&u32StbSnP);
    ca_getStbSN(u8CurrentStbSN);

    if (u32StbSnP)
    {
        for ( index = 0 ; index < 4 ; index++ )
        {
            if (u8CurrentStbSN[index] != u8SN[index])
            {
                break;
            }
        }

        /*If u8SN has been set as the STBSN already, HI_SUCCESS should be returned*/
        if (index == 4)
        {
            return HI_SUCCESS;
        }
        else
        {
            /*if STBSN has been set, but it's not u8SN, HI_ERR_CA_SETPARAM_AGAIN should be returned*/
            HI_ERR_CA("MarketID can not set again\n");
            return HI_ERR_CA_SETPARAM_AGAIN;
        }
    }

    for(index = 0;index<4;index++)
    {
        otp_wt_u8(OTP_STB_SN+index, u8SN[index]);
    }

    /* write to OTP and Set a used tag(OTP_STB_SN_P) */
    otp_wt_u8(OTP_STB_SN_P, 0x0);
    g_CurPfOtp.bits.stb_sn_p = 1;

    return HI_SUCCESS;
}

HI_S32 ca_setStbSNEx(HI_U32 SN)
{
    HI_U32 u32STBSN = 0;
    HI_U32 u32StbSnP = 0;

    ca_v200_ReadReg(CA_V200_STB_SN_ADD, &u32STBSN);

    ca_getStbSnP(&u32StbSnP);
    if (1 == u32StbSnP)
    {
        if (u32STBSN == SN)
        {
            /* if SN has been set as the STBCASN already, HI_SUCCESS should be returned*/
            return HI_SUCCESS;
        }
        else
        {
            /*if STBCASN has been set, but it's not SN, HI_ERR_CA_SETPARAM_AGAIN should be returned*/
            HI_ERR_CA("stbSN can not set again\n");
            return HI_ERR_CA_SETPARAM_AGAIN;
        }
    }

    otp_wt_u32(OTP_STB_SN, SN);
    otp_wt_u8(OTP_STB_SN_P, 0x0);

    g_CurPfOtp.bits.stb_sn_p = 1;

    return HI_SUCCESS;
}

HI_S32 ca_getStbSNEx(HI_U32 *pSN)
{
    HI_U32 stbSn = 0;

    if (pSN == NULL)
    {
        HI_ERR_CA("Param error\n");
        return HI_ERR_CA_INVALID_PARA;
    }

    ca_v200_ReadReg(CA_V200_STB_SN_ADD, &stbSn);
    *pSN = stbSn;

    return HI_SUCCESS;
}

HI_S32 ca_StatHardCwSel(HI_U32 *pbLock)
{
    HI_U32 u32Lock = 0;

    // 0
    if (pbLock == NULL)
    {
        return HI_ERR_CA_INVALID_PARA;
    }

    otp_rd_u32(OTP_CW_INFO_P, u32Lock);
    if (0 == (u32Lock & 0xff))
    {
        *pbLock = 1;
    }
    else
    {
        *pbLock = 0;
    }

    return HI_SUCCESS;
}

HI_S32 ca_LockHardCwSel(HI_VOID)
{
    HI_U32 Value;
    HI_U32 u32Lock = 0;

    ca_StatHardCwSel(&u32Lock);

    /* If hard cw is already set, HI_SUCCESS will be returned */
    if (u32Lock)
    {
        return HI_SUCCESS;
    }

    /*  write to OTP and Set a used tag(OTP_CW_INFO_P) */
    Value = 0xFFFFFFFF;
    otp_wt_u32(OTP_CW_HARD_SEL,Value);  /* 32 multi-CW */
    otp_wt_u8(OTP_CW_INFO_P, 0x0);
    g_CurPfOtp.bits.cw_info_p = 1;
    return HI_SUCCESS;
}

HI_S32 ca_LockBootDecEn(HI_VOID)
{
    CA_CTRLPROC_U CaCtrlProc;

    CaCtrlProc.Value = 0;
    ca_v200_ReadReg(CA_V200_CTRL_PROC_ADD, &CaCtrlProc.Value);

    /* If boot_dec_en is already set, HI_SUCCESS will be returned */
    if (g_CurPfOtp.bits.bload_dec_en || CaCtrlProc.Bits.BootDecEn)
    {
        return HI_SUCCESS;
    }

    /* write to OTP */
    otp_wt_u8(OTP_BLOAD_DEC_EN,0xFF);
    g_CurPfOtp.bits.bload_dec_en = 1;
    return HI_SUCCESS;
}

HI_S32 ca_StatR2RHardKey(HI_U32 *pbLock)
{
    HI_U32 u32Lock = 0;

    // 0
    if (pbLock == NULL)
    {
        return HI_ERR_CA_INVALID_PARA;
    }

    otp_rd_u32(OTP_R2R_HARD_KEY_LOCK, u32Lock);
    if (0 == (u32Lock & 0xff))
    {
        *pbLock = 0;
    }
    else
    {
        *pbLock = 1;
    }

    return HI_SUCCESS;
}

HI_S32 ca_LockR2RHardKey(HI_VOID)
{
    HI_U32 u32Lock = 0;

    ca_StatR2RHardKey(&u32Lock);

    /* If r2r_hard_key is already set, HI_SUCCESS will be returned */
    if (u32Lock)
    {
        return HI_SUCCESS;
    }

    /* write to OTP */
    otp_wt_u8(OTP_R2R_HARD_KEY_LOCK,0xFF);
    g_CurPfOtp.bits.r2r_hard_key_lock = 1;

    return HI_SUCCESS;
}

HI_S32 ca_getCWDeactive(HI_U32 *pdeActive)
{
    HI_U32 u32Deactive = 0;

    // 0
    if (pdeActive == NULL)
    {
        return HI_ERR_CA_INVALID_PARA;
    }

    otp_rd_u32(OTP_CW_KEY_DEACTIVATION, u32Deactive);
    if (0 == (u32Deactive & 0xff))
    {
        *pdeActive = 1;
    }
    else
    {
        *pdeActive = 0;
    }

    return HI_SUCCESS;
}

HI_S32 ca_setCWDeactive(HI_VOID)
{
    HI_U32 u32Deactive = 0;

    ca_getCWDeactive(&u32Deactive);
    /* if CW is already deactived, HI_SUCCESS should be returned*/
    if (1 == u32Deactive)
    {
        return HI_SUCCESS;
    }

    otp_wt_u8(OTP_CW_KEY_DEACTIVATION, 0x0);

    g_CurPfOtp.bits.cw_key_deactivation = 1;

    return HI_SUCCESS;
}

HI_S32 ca_getR2RDeactive(HI_U32 *pdeActive)
{
    HI_U32 u32Deactive = 0;

    // 0
    if (pdeActive == NULL)
    {
        return HI_ERR_CA_INVALID_PARA;
    }

    otp_rd_u32(OTP_R2R_KEY_DEACTIVATION, u32Deactive);
    if (0x0 == (u32Deactive & 0xff))
    {
        *pdeActive = 0;
    }
    else
    {
        *pdeActive = 1;
    }

    return HI_SUCCESS;
}

HI_S32 ca_setR2RDeactive(HI_VOID)
{
    HI_U32 u32Deactive = 0;

    ca_getR2RDeactive(&u32Deactive);
    /* if R2R is already deactived, HI_SUCCESS should be returned*/
    if (1 == u32Deactive)
    {
        return HI_SUCCESS;
    }

    otp_wt_u8(OTP_R2R_KEY_DEACTIVATION, 0xff);

    g_CurPfOtp.bits.r2r_key_deactivation = 1;

    return HI_SUCCESS;
}

HI_S32 ca_getJtagKeyLen(HI_U32 *plenType)
{
    HI_U32 u32Len = 0;

    if (plenType == NULL)
    {
        return HI_ERR_CA_INVALID_PARA;
    }

    otp_rd_u32(OTP_JTAG_KEY_LEN, u32Len);
    if (0 == (u32Len & 0xff))
    {
        *plenType = 1;
    }
    else
    {
        *plenType = 0;
    }

    return HI_SUCCESS;
}

HI_S32 ca_setJtagKeyLen(HI_VOID)
{
    HI_U32 u32Len = 0;

    ca_getJtagKeyLen(&u32Len);
    // if jtag key len is already set, return HI_SUCCESS
    if (1 == u32Len)
    {
        return HI_SUCCESS;
    }

    otp_wt_u8(OTP_JTAG_KEY_LEN, 0x0);

    g_CurPfOtp.bits.jtag_key_len = 1;

    return HI_SUCCESS;
}

HI_S32 ca_getSR(HI_U32 *pSR, HI_U32 pSRNumber)
{
    if (pSR == NULL)
    {
        HI_ERR_CA("Param error\n");
        return HI_ERR_CA_INVALID_PARA;
    }

    return (g_pOTPExportFunctionList->HAL_OTP_V100_GetSrBit)(pSRNumber, pSR);
}

HI_S32 ca_setSR(HI_U32 pSR, HI_U32 pSRNumber)
{
    if (pSR)
    {
        return (g_pOTPExportFunctionList->HAL_OTP_V100_SetSrBit)(pSRNumber);
    }

    return HI_SUCCESS;
}

HI_S32 ca_setDvbRootKey(HI_U8 *key)
{
    int i;
    HI_U32 sr6Value = 0;

    if (NULL == key)
    {
        return HI_ERR_CA_INVALID_PARA;
    }

    ca_getSR(&sr6Value, 6);

    if (1 == sr6Value)
    {
        return HI_ERR_CA_SETPARAM_AGAIN;
    }

    for (i = 0; i < 16; i++)
    {
        otp_wt_u8((OTP_DVB_ROOTKEY0 + i), key[i]);
    }

    return HI_SUCCESS;
}

HI_S32 ca_getDVBRootKey(HI_U8 *key)
{
    unsigned int *ptr;
    HI_U32 sr4Value = 0;

    if (NULL == key)
    {
        return HI_ERR_CA_INVALID_PARA;
    }

    ca_getSR(&sr4Value, 4);

    if (1 == sr4Value)
    {
        return HI_ERR_CA_NOT_SUPPORT;
    }

    ptr = (unsigned int *)key;
    otp_rd_u32(OTP_DVB_ROOTKEY0, ptr[0]);
    otp_rd_u32(OTP_DVB_ROOTKEY1, ptr[1]);
    otp_rd_u32(OTP_DVB_ROOTKEY2, ptr[2]);
    otp_rd_u32(OTP_DVB_ROOTKEY3, ptr[3]);

    return HI_SUCCESS;
}

HI_S32 ca_setR2RRootKey(HI_U8 *key)
{
    int i;
    HI_U32 sr6Value = 0;

    if (NULL == key)
    {
        return HI_ERR_CA_INVALID_PARA;
    }

    ca_getSR(&sr6Value, 6);

    if (1 == sr6Value)
    {
        return HI_ERR_CA_SETPARAM_AGAIN;
    }

    for (i = 0; i < 16; i++)
    {
        otp_wt_u8((OTP_R2R_ROOTKEY0 + i), key[i]);
    }

    return HI_SUCCESS;
}

HI_S32 ca_getR2RRootKey(HI_U8 *key)
{
    unsigned int *ptr;
    HI_U32 sr4Value = 0;

    if (NULL == key)
    {
        return HI_ERR_CA_INVALID_PARA;
    }

    ca_getSR(&sr4Value, 4);

    if (1 == sr4Value)
    {
        return HI_ERR_CA_NOT_SUPPORT;
    }

    ptr = (unsigned int *)key;
    otp_rd_u32(OTP_R2R_ROOTKEY0, ptr[0]);
    otp_rd_u32(OTP_R2R_ROOTKEY1, ptr[1]);
    otp_rd_u32(OTP_R2R_ROOTKEY2, ptr[2]);
    otp_rd_u32(OTP_R2R_ROOTKEY3, ptr[3]);

    return HI_SUCCESS;
}

HI_S32 ca_setJtagKey(HI_U8 *key)
{
    int i;
    HI_U32 sr6Value = 0;

    if (NULL == key)
    {
        return HI_ERR_CA_INVALID_PARA;
    }

    ca_getSR(&sr6Value, 6);

    if (1 == sr6Value)
    {
        return HI_ERR_CA_SETPARAM_AGAIN;
    }

    for (i = 0; i < 8; i++)
    {
        otp_wt_u8((OTP_JTAG_KEY0 + i), key[i]);
    }

    return HI_SUCCESS;
}

HI_S32 ca_getJtagKey(HI_U8 *key)
{
    unsigned int *ptr;
    HI_U32 sr4Value = 0;

    if (NULL == key)
    {
        return HI_ERR_CA_INVALID_PARA;
    }

    ca_getSR(&sr4Value, 4);

    if (1 == sr4Value)
    {
        return HI_ERR_CA_NOT_SUPPORT;
    }

    ptr = (unsigned int *)key;
    otp_rd_u32(OTP_JTAG_KEY0, ptr[0]);
    otp_rd_u32(OTP_JTAG_KEY1, ptr[1]);

    return HI_SUCCESS;
}

HI_S32 ca_setRSAKey(HI_U8 *key)
{
    int i;
    HI_U32 sr6Value = 0;

    if (NULL == key)
    {
        return HI_ERR_CA_INVALID_PARA;
    }

    ca_getSR(&sr6Value, 6);

    if (1 == sr6Value)
    {
        return HI_ERR_CA_SETPARAM_AGAIN;
    }

    for (i = 0; i < 512; i++)
    {
        otp_wt_u8((OTP_RSA + i), key[i]);
    }

    return HI_SUCCESS;
}

HI_S32 ca_getRSAKey(HI_U8 *key)
{
    int i;
    unsigned int *ptr;
    HI_U32 sr4Value = 0;

    if (NULL == key)
    {
        return HI_ERR_CA_INVALID_PARA;
    }

    ca_getSR(&sr4Value, 4);

    if (1 == sr4Value)
    {
        return HI_ERR_CA_NOT_SUPPORT;
    }

    ptr = (unsigned int *)key;

    for (i = 0; i < 128; i++)
    {
        otp_rd_u32((OTP_RSA + 4 * i), ptr[i]);
    }

    return HI_SUCCESS;
}

HI_S32 ca_setChipId(HI_U32 ChipId)
{
    HI_U32 sr6Value = 0;
    HI_U32 u32ChipId = 0;

    ca_getChipID(&u32ChipId);

    ca_getSR(&sr6Value, 6);

    if (1 == sr6Value)
    {
        if (u32ChipId == ChipId)
        {
            /* if ChipId has been set as the CHIP ID already, HI_SUCCESS should be returned*/
            return HI_SUCCESS;
        }
        else
        {
            /*if CHIP ID has been set, but it's not ChipId, HI_ERR_CA_SETPARAM_AGAIN should be returned*/
            return HI_ERR_CA_SETPARAM_AGAIN;
        }
    }

    otp_wt_u32(OTP_CHIPID, ChipId);

    return HI_SUCCESS;
}

HI_S32 ca_StatLinkProtect(HI_U32 *pbDisable)
{
    HI_U32 u32Disable = 0;

    // 0
    if (pbDisable == NULL)
    {
        return HI_ERR_CA_INVALID_PARA;
    }

    otp_rd_u32(OTP_LINK_PRT_DISABLE, u32Disable);
    if (0 == (u32Disable & 0xff))
    {
        *pbDisable = 0;
    }
    else
    {
        *pbDisable = 1;
    }

    return HI_SUCCESS;
}


HI_S32 ca_DisableLinkProtect(HI_VOID)
{
    HI_U32 u32Disable = 0;

    ca_StatLinkProtect(&u32Disable);

    /* If link protect is already disabled, HI_SUCCESS will be returned */
    if (u32Disable)
    {
        return HI_SUCCESS;
    }

    /* write to OTP */
    otp_wt_u8(OTP_LINK_PRT_DISABLE,0xFF);
    g_CurPfOtp.bits.link_prt_disable = 1;

    return HI_SUCCESS;
}

HI_S32 ca_getSelfBoot(HI_U32 *pSelfBoot)
{
    HI_U32 selfBoot = 0;

    if (pSelfBoot == NULL)
    {
        return HI_ERR_CA_INVALID_PARA;
    }

    otp_rd_u32(OTP_SELF_BOOT_DISABLE, selfBoot);

    if (0 == (selfBoot & 0xff))
    {
        *pSelfBoot = 1;
    }
    else
    {
        *pSelfBoot = 0;
    }

    return HI_SUCCESS;
}

HI_S32 ca_DisableSelfBoot(HI_VOID)
{
    HI_U32 u32Stat = 0;

    ca_getSelfBoot(&u32Stat);

    if (1 == u32Stat)
    {
        /*if self boot is already disabled, do nothing and return HI_SUCCESS*/
        return HI_SUCCESS;
    }

    /* write to OTP */
    otp_wt_u8(OTP_SELF_BOOT_DISABLE,0x0);
    g_CurPfOtp.bits.self_boot_disable = 1;

    return HI_SUCCESS;
}

HI_S32 ca_getBootSelLock(HI_U32 *pBootSelLock)
{
    HI_U32 u32BootSelLock = 0;

    if (NULL == pBootSelLock)
    {
        return HI_ERR_CA_INVALID_PARA;
    }

    otp_rd_u32(OTP_BOOTSEL_LOCK, u32BootSelLock);

    if (0 == (u32BootSelLock & 0xff))
    {
        *pBootSelLock = 1;
    }
    else
    {
        *pBootSelLock = 0;
    }

    return HI_SUCCESS;
}

HI_S32 ca_setBootSelLock(HI_VOID)
{
    HI_U32 u32BootSelLock = 0;

    ca_getBootSelLock(&u32BootSelLock);

    /* if the bootsel is already locked, HI_SUCCESS should be returned*/
    if (1 == u32BootSelLock)
    {
        return HI_SUCCESS;
    }

    otp_wt_u8(OTP_BOOTSEL_LOCK, 0x0);
    g_CurPfOtp.bits.bootsel_lock = 1;

    return HI_SUCCESS;
}

HI_S32 otp_getBootMode(HI_UNF_ADVCA_FLASH_TYPE_E *pSel)
{
    HI_U32 u32BootMode = 0;

    otp_rd_u32(OTP_BOOT_MODE_SEL_0, u32BootMode);

    switch (u32BootMode & 0x0000ffff)
    {
        case 0x0000ff00 :
            *pSel = HI_UNF_ADVCA_FLASH_TYPE_SPI;
            break;
        case 0x0000ffff :
            *pSel = HI_UNF_ADVCA_FLASH_TYPE_NAND;
            break;
        case 0x000000ff :
            *pSel = HI_UNF_ADVCA_FLASH_TYPE_EMMC;
            break;
        default:
            *pSel = HI_UNF_ADVCA_FLASH_TYPE_BUTT;
    }
    return HI_SUCCESS;
}

HI_S32 otp_setBootMode(HI_UNF_ADVCA_FLASH_TYPE_E enSel)
{
    HI_UNF_ADVCA_FLASH_TYPE_E eCurrentBootMode = HI_UNF_ADVCA_FLASH_TYPE_BUTT;
    HI_U32 u32BootSelLock = 0;

    if (enSel >= HI_UNF_ADVCA_FLASH_TYPE_BUTT)
    {
        HI_ERR_CA("BootMode Bad Param\n");
        return HI_ERR_CA_INVALID_PARA;
    }

    ca_getBootSelLock(&u32BootSelLock);
    otp_getBootMode(&eCurrentBootMode);

    if (u32BootSelLock)
    {
        if (enSel == eCurrentBootMode)
        {
            /*if enSel has been set as the Boot Mode already, HI_SUCCESS should be returned*/
            return HI_SUCCESS;
        }
        else
        {
            /*if Boot Mode has been set, but it's not enSel, HI_ERR_CA_SETPARAM_AGAIN should be returned*/
            HI_ERR_CA("BootMode can not set again\n");
            return HI_ERR_CA_SETPARAM_AGAIN;
        }
    }

    switch (enSel)
    {
        case HI_UNF_ADVCA_FLASH_TYPE_NAND :
            {
                otp_wt_u8(OTP_BOOT_MODE_SEL_0, 0xff);
                g_CurPfOtp.bits.boot_mode_sel_0 = 1;
                break;
            }
        case HI_UNF_ADVCA_FLASH_TYPE_NOR :
            {
                break;
            }
        case HI_UNF_ADVCA_FLASH_TYPE_EMMC:
            {
                otp_wt_u8(OTP_BOOT_MODE_SEL_0, 0xff);
                otp_wt_u8(OTP_BOOT_MODE_SEL_1, 0x0);
                g_CurPfOtp.bits.boot_mode_sel_0 = 1;
                g_CurPfOtp.bits.boot_mode_sel_1 = 1;
                break;
            }
        default:
            {
                /* default SPI Flash */
            }
    }

    /*lock bootsel*/
    otp_wt_u8(OTP_BOOTSEL_LOCK, 0x0);
    g_CurPfOtp.bits.bootsel_lock = 1;

    return HI_SUCCESS;
}

HI_S32 otp_getSCSActive(HI_U32 *penable)
{
    HI_U32 u32Active = 0;

    if (penable == NULL)
    {
        HI_ERR_CA("Param error\n");
        return HI_ERR_CA_INVALID_PARA;
    }

    otp_rd_u32(OTP_SCS_ACTIVATION, u32Active);
    if (0 == (u32Active & 0xff))
    {
        *penable = 0;
    }
    else
    {
        *penable = 1;
    }

    return HI_SUCCESS;
}

HI_S32 otp_setSCSActive(HI_VOID)
{
    HI_U32 u32Active = 0;

    otp_getSCSActive(&u32Active);

    /* if the SCS feature is already enabled, HI_SUCCESS should be returned*/
    if (1 == u32Active)
    {
        return HI_SUCCESS;
    }

    /* enable SCS in OTP*/
    otp_wt_u8(OTP_SCS_ACTIVATION, 0xff);
    g_CurPfOtp.bits.scs_activation = 1;

    return HI_SUCCESS;;
}

HI_S32 otp_getJtagPrtMode(HI_UNF_ADVCA_JTAG_MODE_E *pjipm)
{
    HI_U32 jtagPrtMode = 0;

    if (pjipm == NULL)
    {
        return HI_ERR_CA_INVALID_PARA;
    }

    otp_rd_u32(OTP_JTAG_PRT_MODE_0, jtagPrtMode);
    jtagPrtMode = jtagPrtMode & 0xffff;

    switch (jtagPrtMode)
    {
        case  0x00ff:
            *pjipm = HI_UNF_ADVCA_JTAG_MODE_OPEN;
            break;
        case 0x0000 :
            *pjipm = HI_UNF_ADVCA_JTAG_MODE_PROTECT;
            break;
        case 0xff00 :
        case 0xffff :
            *pjipm = HI_UNF_ADVCA_JTAG_MODE_CLOSED;
            break;
        default:
            *pjipm = HI_UNF_ADVCA_JTAG_MODE_BUTT;
    }

    return HI_SUCCESS;
}
//0-32 byte  0--> 1/1--> 0 {0-->0/1-->1 ok}
HI_S32 otp_setJtagPrtMode(HI_UNF_ADVCA_JTAG_MODE_E jipm)
{
    HI_U32 u32PrtMode = 0;

    otp_getJtagPrtMode(&u32PrtMode);

    if (jipm >= HI_UNF_ADVCA_JTAG_MODE_BUTT)
    {
        HI_ERR_CA("JtagPrtMode Param error\n");
        return HI_ERR_CA_INVALID_PARA;
    }

    if (u32PrtMode == jipm)
    {
        return HI_SUCCESS;
    }

    if (HI_UNF_ADVCA_JTAG_MODE_CLOSED == u32PrtMode)            /* CLOSED->... */
    {
        HI_ERR_CA("JtagPrtMode can not set again\n");
        return HI_ERR_CA_SETPARAM_AGAIN;
    }

    if (HI_UNF_ADVCA_JTAG_MODE_PROTECT == u32PrtMode)
    {
        if (jipm < HI_UNF_ADVCA_JTAG_MODE_CLOSED)   /* PROTECTED->OPEN|PROTECTED */
        {
            HI_ERR_CA("JtagPrtMode can not set again\n");
            return HI_ERR_CA_SETPARAM_AGAIN;
        }
    }

    if (jipm == HI_UNF_ADVCA_JTAG_MODE_PROTECT)     /* OPEN->PROTECTED */
    {
        otp_wt_u8(OTP_JTAG_PRT_MODE_0, 0x00);
        g_CurPfOtp.bits.jtag_prt_mode_0 = 1;
    }
    else if (jipm == HI_UNF_ADVCA_JTAG_MODE_CLOSED) /* OPEN|PROTECTED->CLOSED */
    {
        otp_wt_u8(OTP_JTAG_PRT_MODE_1, 0xFF);
        g_CurPfOtp.bits.jtag_prt_mode_1 = 1;
    }
    else if (jipm == HI_UNF_ADVCA_JTAG_MODE_OPEN)   /* OPEN->OPEN */
    {
        // default
    }

    return HI_SUCCESS;
}

/*********************************************************************/

HI_S32 ca_getCWLadder(HI_UNF_ADVCA_KEYLADDER_LEV_E *psel)
{
    CA_CTRLPROC_U CaCtrlProc;

    CaCtrlProc.Value = 0;
    ca_v200_ReadReg(CA_V200_CTRL_PROC_ADD, &CaCtrlProc.Value);

    if (psel == NULL)
    {
        HI_ERR_CA("ladder err, psel == NULL ! \n");
        return HI_ERR_CA_INVALID_PARA;
    }

    /* OTP control cw_lv_org == 1*/
    if (CaCtrlProc.Bits.CwLvOrg)
    {
        /* OTP set to level 3, cw_lv_sel == 1 */
        if (CaCtrlProc.Bits.CwLvSel)
        {
            *psel = HI_UNF_ADVCA_KEYLADDER_LEV3;
        }
        else
        {
            *psel = HI_UNF_ADVCA_KEYLADDER_LEV2;
        }
    }
    /* control register cw_lv_org == 0 */
    else
    {
        CA_LADDERSET_U   CaSetLadder;//CA Key-ladder Software setting Level.

        CaSetLadder.Value = 0;
        ca_v200_ReadReg(CA_V200_SET_ADD, &CaSetLadder.Value);

        if (0x2 == CaSetLadder.Bits.CwLadSet)
        {
            *psel = HI_UNF_ADVCA_KEYLADDER_LEV2;
        }
        else if(0x3 == CaSetLadder.Bits.CwLadSet)
        {
            *psel = HI_UNF_ADVCA_KEYLADDER_LEV3;
        }
        else
        {
            *psel = HI_UNF_ADVCA_KEYLADDER_BUTT;
        }
    }

    return HI_SUCCESS;
}

static HI_S32 ca_setCWLadder(HI_UNF_ADVCA_KEYLADDER_LEV_E sel)
{
    CA_CTRLPROC_U CaCtrlProc;

    CaCtrlProc.Value = 0;
    ca_v200_ReadReg(CA_V200_CTRL_PROC_ADD, &CaCtrlProc.Value);

    if ((sel != HI_UNF_ADVCA_KEYLADDER_LEV2) && (sel != HI_UNF_ADVCA_KEYLADDER_LEV3))
    {
        HI_ERR_CA("ladder err, sel = %d ! \n", sel);
        return HI_ERR_CA_INVALID_PARA;
    }

    /* OTP control cw_lv_org == 1*/
    if (CaCtrlProc.Bits.CwLvOrg)  /* g_CurPfOtp.bits.cw_lv_org */
    {
        /* cw_lv_sel programmed or cw_lv_lock locked*/
        if ((CaCtrlProc.Bits.CwLvSel)
         || (1 == CaCtrlProc.Bits.CwLvLock)
         || (1 == g_CurPfOtp.bits.cw_lv_sel)
         || (1 == g_CurPfOtp.bits.cw_lv_lock))
        {
            HI_UNF_ADVCA_KEYLADDER_LEV_E org_sel;

            ca_getCWLadder(&org_sel);
            if(org_sel == sel)
            {
                return HI_SUCCESS;
            }
            else
            {
                HI_ERR_CA("CWLadder can not set again\n");
                return HI_ERR_CA_SETPARAM_AGAIN;
            }
        }

        /* set OTP */
        if (HI_UNF_ADVCA_KEYLADDER_LEV3 == sel)
        {
            otp_wt_u8(OTP_CW_LV_SEL,0x0);
            g_CurPfOtp.bits.cw_lv_sel = 1;
        }
        // TODO:Is locked when set to HI_UNF_ADVCA_KEYLADDER_LEV2?
        otp_wt_u8(OTP_CW_LV_LOCK,0xff);
        g_CurPfOtp.bits.cw_lv_lock = 1;
    }
    /* control register*/
    else
    {
        CA_LADDERSET_U   CaSetLadder;//CA Key-ladder Software setting Level.

        CaSetLadder.Value = 0;
        ca_v200_ReadReg(CA_V200_SET_ADD, &CaSetLadder.Value);

        if (HI_UNF_ADVCA_KEYLADDER_LEV2 == sel)
        {
            CaSetLadder.Bits.CwLadSet = 0x2;
        }
        else
        {
            CaSetLadder.Bits.CwLadSet = 0x3;
        }
        ca_v200_WriteReg(CA_V200_SET_ADD, CaSetLadder.Value);
    }

    g_CwLadderSel = sel;

    return HI_SUCCESS;
}

HI_S32 ca_getR2RLadder(HI_UNF_ADVCA_KEYLADDER_LEV_E *psel)
{
    CA_CTRLPROC_U CaCtrlProc;

    CaCtrlProc.Value = 0;
    ca_v200_ReadReg(CA_V200_CTRL_PROC_ADD, &CaCtrlProc.Value);

    if (psel == NULL)
    {
        HI_ERR_CA("ladder err, psel == NULL ! \n");
        return HI_ERR_CA_INVALID_PARA;
    }

    if (CaCtrlProc.Bits.R2rLvSel)
    {
        *psel = HI_UNF_ADVCA_KEYLADDER_LEV3;
    }
    else
    {
        *psel = HI_UNF_ADVCA_KEYLADDER_LEV2;
    }

    return HI_SUCCESS;
}

static HI_S32 ca_setR2RLadder(HI_UNF_ADVCA_KEYLADDER_LEV_E sel)
{
    CA_CTRLPROC_U CaCtrlProc;

    CaCtrlProc.Value = 0;
    ca_v200_ReadReg(CA_V200_CTRL_PROC_ADD, &CaCtrlProc.Value);

    if ((sel != HI_UNF_ADVCA_KEYLADDER_LEV3) && (sel != HI_UNF_ADVCA_KEYLADDER_LEV2))
    {
        HI_ERR_CA("ladder err, sel = %d ! \n", sel);
        return HI_ERR_CA_INVALID_PARA;
    }

    /* r2r_lv_sel programmed or r2r_lv_lock locked */
    if ((CaCtrlProc.Bits.R2rLvSel || CaCtrlProc.Bits.R2rLvLock)
      ||(g_CurPfOtp.bits.r2r_lv_sel || g_CurPfOtp.bits.r2r_lv_lock))
    {
        HI_UNF_ADVCA_KEYLADDER_LEV_E org_sel;

        ca_getR2RLadder(&org_sel);
        if(org_sel == sel)
        {
            return HI_SUCCESS;
        }
        else
        {
            HI_ERR_CA("R2RLadder can not set again\n");
            return HI_ERR_CA_SETPARAM_AGAIN;
        }
    }

    if (HI_UNF_ADVCA_KEYLADDER_LEV3 == sel)
    {
        otp_wt_u8(OTP_R2R_LV_SEL,0x0);
        g_CurPfOtp.bits.r2r_lv_sel = 1;
    }
    otp_wt_u8(OTP_R2R_LV_LOCK,0x0);
    g_CurPfOtp.bits.r2r_lv_lock = 1;

    g_R2RLadderSel = sel;

    return HI_SUCCESS;
}

// exist the same Cyc:ladder1/ladder0 alg
HI_S32 ca_setCWAlg(HI_UNF_ADVCA_ALG_TYPE_E type)
{
    if (type > HI_UNF_ADVCA_ALG_TYPE_BUTT)
    {
        HI_ERR_CA("args err, type = %d ! \n", type);
        return HI_ERR_CA_INVALID_PARA;
    }

    g_CwAlgType = type;
    return HI_SUCCESS;
}

// limited, only aes
HI_S32 ca_setR2RAlg(HI_UNF_ADVCA_ALG_TYPE_E type)
{
    if (type >= HI_UNF_ADVCA_ALG_TYPE_BUTT)
    {
        HI_ERR_CA("args err, type = %d ! \n", type);
        return HI_ERR_CA_INVALID_PARA;
    }

    g_R2RAlgType = type;
    return HI_SUCCESS;
}

HI_S32 ca_getCWAlg(HI_UNF_ADVCA_ALG_TYPE_E *pu32CwAlgType)
{
    if (NULL == pu32CwAlgType)
    {
        return HI_ERR_CA_INVALID_PARA;
    }

    *pu32CwAlgType = (HI_U32)g_CwAlgType;

    return HI_SUCCESS;
}

HI_S32 ca_getR2RAlg(HI_UNF_ADVCA_ALG_TYPE_E *pu32R2RAlgType)
{
    if (NULL == pu32R2RAlgType)
    {
        return HI_ERR_CA_INVALID_PARA;
    }

    *pu32R2RAlgType = (HI_U32)g_R2RAlgType;

    return HI_SUCCESS;
}

HI_S32 ca_getVendorId(CA_OTP_VENDOR_TYPE_E *pu32VendorId)
{
    HI_U32 u32VendorId = 0;

    if (pu32VendorId == NULL)
    {
        HI_ERR_CA("vendor id err, pu32VendorId == NULL ! \n");
        return HI_ERR_CA_INVALID_PARA;
    }

    otp_rd_u32(OTP_SECURE_CHIP, u32VendorId);
    *pu32VendorId = (CA_OTP_VENDOR_TYPE_E)(u32VendorId & 0xff);

    return HI_SUCCESS;
}

HI_S32 ca_getSecureChipP(HI_U32 *pSecureChipP)
{
    HI_U32 secureChipP = 0;

    if (pSecureChipP == NULL)
    {
        HI_ERR_CA("Param error\n");
        return HI_ERR_CA_INVALID_PARA;
    }

    otp_rd_u32(OTP_SECURE_CHIP_P, secureChipP);

    if (0 == (secureChipP & 0xff))
    {
        *pSecureChipP = 0;
    }
    else
    {
        *pSecureChipP = 1;
    }

    return HI_SUCCESS;
}

HI_S32 ca_StatTdesLock(HI_U32 *pbLock)
{
    HI_U32 u32Lock = 0;

    // 0
    if (pbLock == NULL)
    {
        return HI_ERR_CA_INVALID_PARA;
    }

    otp_rd_u32(OTP_TDES_LOCK, u32Lock);
    if (0 == (u32Lock & 0xff))
    {
        *pbLock = 1;
    }
    else
    {
        *pbLock = 0;
    }

    return HI_SUCCESS;
}

HI_S32 ca_setTdesLock(HI_U32 tdesLock)
{
    HI_U32 u32Lock = 0;

    ca_StatTdesLock(&u32Lock);

    if (tdesLock)
    {
        /*if Tdes is already locked, HI_SUCCESS should be returned*/
        if (1 == u32Lock)
        {
            return HI_SUCCESS;
        }

        otp_wt_u8(OTP_TDES_LOCK, 0x0);
        g_CurPfOtp.bits.tdes_lock = 1;
    }
    else
    {
        /*default not lock, do nothing*/
    }

    return HI_SUCCESS;
}

HI_S32 ca_setVendorId(CA_OTP_VENDOR_TYPE_E secureChipId)
{
    HI_U32 u32SecureChipId = 0;
    HI_U32 u32SecureChipP = 0;

    if (secureChipId >= CA_OTP_VENDOR_BUTT)
    {
        return HI_ERR_CA_INVALID_PARA;
    }

    ca_getSecureChipP(&u32SecureChipP);
    if (1 == u32SecureChipP)
    {
        otp_rd_u32(OTP_SECURE_CHIP, u32SecureChipId);
        if (secureChipId == (u32SecureChipId & 0xff))
        {
            return HI_SUCCESS;
        }
        else
        {
            return HI_ERR_CA_SETPARAM_AGAIN;
        }
    }

    otp_wt_u8(OTP_SECURE_CHIP, secureChipId);
    g_CurPfOtp.bits.ca_vendor = secureChipId;

    otp_wt_u8(OTP_SECURE_CHIP_P, 0xff);
    g_CurPfOtp.bits.secure_chip_p = 1;

    return HI_SUCCESS;
}

HI_S32 ca_setSecureChipP(HI_VOID)
{
    HI_U32 u32SecureChipP = 0;

    ca_getSecureChipP(&u32SecureChipP);
    if (1== u32SecureChipP)
    {
        return HI_SUCCESS;
    }

    otp_wt_u8(OTP_SECURE_CHIP_P, 0xff);

    g_CurPfOtp.bits.secure_chip_p = 1;

    return HI_SUCCESS;
}

HI_S32 ca_getLowPowerDisable(HI_U32 *pLowPowerDisable)
{
    HI_U32 lowPowerDisable = 0;

    if (NULL == pLowPowerDisable)
    {
        return HI_ERR_CA_INVALID_PARA;
    }

    otp_rd_u32(OTP_LOW_POWER_DISABLE, lowPowerDisable);

    if (0 == (lowPowerDisable & 0xff))
    {
        *pLowPowerDisable = 0;
    }
    else
    {
        *pLowPowerDisable = 1;
    }

    return HI_SUCCESS;
}

HI_S32 ca_setLowPowerDisable(HI_U32 lowPowerDisable)
{
    HI_U32 u32Disable = 0;

    ca_getLowPowerDisable(&u32Disable);

    if (lowPowerDisable)
    {
        if (1== u32Disable)
        {
            return HI_SUCCESS;
        }

        otp_wt_u8(OTP_LOW_POWER_DISABLE, 0xff);

        g_CurPfOtp.bits.low_power_disable = 1;
    }

    return HI_SUCCESS;
}

HI_S32 ca_getPcieEn(HI_U32 *pPcieEn)
{
    HI_U32 pcieEn = 0;

    if (NULL == pPcieEn)
    {
        return HI_ERR_CA_INVALID_PARA;
    }

    otp_rd_u32(OTP_MISC_CTRL_EN, pcieEn);

    if (0x00 == (pcieEn & 0x00000001))
    {
        *pPcieEn = 1;
    }
    else
    {
        *pPcieEn = 0;
    }

    return HI_SUCCESS;
}

HI_S32 ca_setPcieEn(HI_U32 pcieEn)
{
    HI_U32 u32PcieEn = 0;

    ca_getPcieEn(&u32PcieEn);

    if (pcieEn)
    {
        if (1 == u32PcieEn)
        {
            return HI_SUCCESS;
        }

        otp_wt_Bit(OTP_MISC_CTRL_EN, 0x0, 0);
    }

    return HI_SUCCESS;
}

HI_S32 ca_getCsa3En(HI_U32 *pCsa3En)
{
    HI_U32 csa3En = 0;

    if (NULL == pCsa3En)
    {
        return HI_ERR_CA_INVALID_PARA;
    }

    otp_rd_u32(OTP_MISC_CTRL_EN, csa3En);

    if (0x00 == (csa3En & 0x00000002))
    {
        *pCsa3En = 1;
    }
    else
    {
        *pCsa3En = 0;
    }

    return HI_SUCCESS;
}

HI_S32 ca_setCsa3En(HI_VOID)
{
    HI_U32 csa3En = 0;

    ca_getCsa3En(&csa3En);

    if (1 == csa3En)
    {
        return HI_SUCCESS;
    }

    otp_wt_Bit(OTP_MISC_CTRL_EN, 0x1, 0);

    return HI_SUCCESS;
}

HI_S32 ca_getLpcEn(HI_U32 *pLpcEn)
{
    HI_U32 lpcEn = 0;

    if (NULL == pLpcEn)
    {
        return HI_ERR_CA_INVALID_PARA;
    }

    otp_rd_u32(OTP_MISC_CTRL_EN, lpcEn);

    if (0x00 == (lpcEn & 0x00000004))
    {
        *pLpcEn = 1;
    }
    else
    {
        *pLpcEn = 0;
    }

    return HI_SUCCESS;
}

HI_S32 ca_setLpcEn(HI_U32 lpcEn)
{
    HI_U32 u32LpcEn = 0;

    ca_getLpcEn(&u32LpcEn);

    if (lpcEn)
    {
        if (1 == u32LpcEn)
        {
            return HI_SUCCESS;
        }

        otp_wt_Bit(OTP_MISC_CTRL_EN, 0x2, 0);
    }

    return HI_SUCCESS;
}

HI_S32 ca_getLpcMasterEn(HI_U32 *pLpcMasterEn)
{
    HI_U32 lpcMasterEn = 0;

    if (NULL == pLpcMasterEn)
    {
        return HI_ERR_CA_INVALID_PARA;
    }

    otp_rd_u32(OTP_MISC_CTRL_EN, lpcMasterEn);

    if (0x00 == (lpcMasterEn & 0x00000008))
    {
        *pLpcMasterEn = 1;
    }
    else
    {
        *pLpcMasterEn = 0;
    }

    return HI_SUCCESS;
}

HI_S32 ca_setLpcMasterEn(HI_U32 lpcMasterEn)
{
    HI_U32 u32LpcMasterEn = 0;

    ca_getLpcMasterEn(&u32LpcMasterEn);

    if (lpcMasterEn)
    {
        if (1 == u32LpcMasterEn)
        {
            return HI_SUCCESS;
        }

        otp_wt_Bit(OTP_MISC_CTRL_EN, 0x3, 0);
    }

    return HI_SUCCESS;
}

HI_S32 ca_setSR7(HI_U32 pSR7)
{
    return ca_setSR(pSR7, 7);
}

HI_S32 ca_getSR7(HI_U32 *pSR7)
{
    if (NULL == pSR7)
    {
        return HI_ERR_CA_INVALID_PARA;
    }

    return ca_getSR(pSR7, 7);
}

HI_S32 ca_setSR6(HI_U32 pSR6)
{
    return ca_setSR(pSR6, 6);
}

HI_S32 ca_getSR6(HI_U32 *pSR6)
{
    if (NULL == pSR6)
    {
        return HI_ERR_CA_INVALID_PARA;
    }

    return ca_getSR(pSR6, 6);
}

HI_S32 ca_setSR4(HI_U32 pSR4)
{
    return ca_setSR(pSR4, 4);
}

HI_S32 ca_getSR4(HI_U32 *pSR4)
{
    if (NULL == pSR4)
    {
        return HI_ERR_CA_INVALID_PARA;
    }

    return ca_getSR(pSR4, 4);
}

HI_S32 ca_setSR2(HI_U32 pSR2)
{
    return ca_setSR(pSR2, 2);
}

HI_S32 ca_getSR2(HI_U32 *pSR2)
{
    if (NULL == pSR2)
    {
        return HI_ERR_CA_INVALID_PARA;
    }

    return ca_getSR(pSR2, 2);
}

HI_S32 ca_getMiscCtrlEn(HI_U32 *pMiscCtrlEn)
{
    HI_U32 u32MiscCtrlEn = 0;

    if (NULL == pMiscCtrlEn)
    {
        return HI_ERR_CA_INVALID_PARA;
    }

    otp_rd_u32(OTP_MISC_CTRL_EN, u32MiscCtrlEn);

    if (0x00 == (u32MiscCtrlEn & 0x00000002))
    {
        *pMiscCtrlEn = 1;
    }
    else
    {
        *pMiscCtrlEn = 0;
    }

    return HI_SUCCESS;
}

HI_S32 ca_setMiscCtrlEn(HI_VOID)
{
    HI_U32 u32MiscCtrlEn = 0;

    ca_getMiscCtrlEn(&u32MiscCtrlEn);
    if (1 == u32MiscCtrlEn)
    {
        // if misc ctrl en is already set, return HI_SUCCESS
        return HI_SUCCESS;
    }

    otp_wt_Bit(OTP_MISC_CTRL_EN, 0x1, 0);

    return HI_SUCCESS;
}

static HI_S32 ca_waitStat(HI_VOID)
{
    HI_S32    Ret = 0;
    HI_U32    cnt;
    CA_STAT_U caStat;
    CA_CTRL_U CaCtrl;

    /* wait for KeyLadder calc done */
    cnt = 0;
    // corform one value when test, about 500
    while (cnt < 10000)
    {
        CaCtrl.Value = 0;
        ca_v200_ReadReg(CA_V200_CTRL_ADD, &CaCtrl.Value);
        if (CaCtrl.Bits.CaStart == 0)
        {
            HI_INFO_CA("ca_decrypted finished\n");
            break;
        }
        cnt++;
    }

    if (cnt >= 10000)
    {
        HI_ERR_CA("handle too long \n");
        return 1;      /* overtime */
    }

    /* query the  State of CA Module RWC */
    caStat.Value = 0;
    ca_v200_ReadReg(CA_V200_STAT_ADD, &caStat.Value);
#if 0
    if (caStat.bits.cw_klad2_rdy)
    {
        HI_INFO_CA("cw_klad2_rdy \n");
    }

    if (caStat.bits.cw_klad1_rdy)
    {
        HI_INFO_CA("cw_klad1_rdy \n");
    }

    if (caStat.bits.cw_klad0_rdy)
    {
        HI_INFO_CA("cw_klad0_rdy \n");
    }

    if (caStat.bits.r2r_klad2_rdy)
    {
        HI_INFO_CA("r2r_klad2_rdy \n");
    }

    if (caStat.bits.r2r_klad1_rdy)
    {
        HI_INFO_CA("r2r_klad1_rdy \n");
    }

    if (caStat.bits.r2r_klad0_rdys)
    {
        HI_INFO_CA("r2r_klad0_rdys \n");
    }
#endif

    /* RWC clear when write to 1*/
    if ((caStat.Bits.TdesKeyErr)
        || (caStat.Bits.LastKeyErr)
        || (caStat.Bits.KeyLadErr))
    {
        if (caStat.Bits.TdesKeyErr)
        {
	        caStat.Bits.TdesKeyErr = 1;
	        Ret = -2;
            HI_ERR_CA("tdes_key_err \n");
        }

        if (caStat.Bits.LastKeyErr)
        {
	        caStat.Bits.LastKeyErr = 1;
	        Ret = -1;
            HI_ERR_CA("last_key_err \n");
        }

        if (caStat.Bits.KeyLadErr)
        {
	        caStat.Bits.KeyLadErr = 1;
	        Ret = -1;
            HI_ERR_CA("key_lad_err \n");
        }

        return Ret;   /* error */
    }
    return 0;        /* success */
}

static HI_VOID ca_clearStat(HI_VOID)
{
    CA_STAT_U caStat;

    /* query the  State of CA Module RWC */
    caStat.Value = 0;
    ca_v200_ReadReg(CA_V200_STAT_ADD, &caStat.Value);

    ca_v200_WriteReg(CA_V200_STAT_ADD, caStat.Value);
    return;        /* success */
}


// TODO:algorith(AES or TDEA)   (Encrypt or Decrypt)
HI_S32 ca_DecryptCw(HI_UNF_ADVCA_KEYLADDER_LEV_E enLevel,HI_U32 *pDataIn,HI_U32 AddrID,HI_BOOL bEvenOrOdd)
{
    HI_S32 Ret;
    CA_FUNCSET_U FuncSet;
    CA_CTRL_U    CaCtrl;

    /* para check*/
    if (enLevel > g_CwLadderSel)
    {
       HI_ERR_CA("enLevel(%d) >= g_R2RLadderSel(%d)\n",enLevel,g_CwLadderSel);
       return HI_ERR_CA_INVALID_PARA;
    }

    if (HI_NULL == pDataIn)
    {
       HI_ERR_CA("HI_NULL == pDataIn\n");
       return HI_ERR_CA_INVALID_PARA;
    }

    /*1  set CA register FUNC_SET as 0 */
    //g_pCaReg->FuncSet.Value = 0;
    FuncSet.Value = 0;
    ca_v200_WriteReg(CA_V200_LP_SET_ADD, FuncSet.Value);

    /*2  put DVB_RootKey（CK2）to CA register(DATA input) */
    ca_v200_WriteReg(CA_V200_DIN0_ADD, pDataIn[0]);
    ca_v200_WriteReg(CA_V200_DIN1_ADD, pDataIn[1]);
    ca_v200_WriteReg(CA_V200_DIN2_ADD, pDataIn[2]);
    ca_v200_WriteReg(CA_V200_DIN3_ADD, pDataIn[3]);

    /*3  wait DECRYPT_CTRL.Start equal to 0, then set DECRYPT_CTRL */
    Ret = ca_waitStat();
    if (Ret > 0)
    {
        HI_ERR_CA("key ladder timeout\n");
        return HI_ERR_CA_WAIT_TIMEOUT;
    }

    ca_clearStat();

    CaCtrl.Value = 0;
    CaCtrl.Bits.AlgSel = g_CwAlgType;  /* Now all is TDEA */
    CaCtrl.Bits.KeyLadSel = enLevel;
    CaCtrl.Bits.CwOrR2r = 0;
    if (g_CwLadderSel == enLevel)
    {
        CaCtrl.Bits.OddOrEven = bEvenOrOdd;
        CaCtrl.Bits.KeyAddr = AddrID & 0x3F;
    }
    CaCtrl.Bits.EnOrDecrpt = 1;
    CaCtrl.Bits.CaStart = 1;
    ca_v200_WriteReg(CA_V200_CTRL_ADD, CaCtrl.Value);

    /*4 wait for decrypt done */
    Ret = ca_waitStat();
    if (Ret > 0)
    {
        HI_ERR_CA("key ladder timeout\n");
        return HI_ERR_CA_WAIT_TIMEOUT;
    }
    else if (Ret == -2)
    {
        HI_ERR_CA("Symetric key usage\n");
        return HI_ERR_CA_LPK_DECRYPT;
    }
    else if (Ret < 0)
    {
        HI_ERR_CA("key ladder error\n");
        return HI_FAILURE;
    }

    return HI_SUCCESS;
}

HI_S32 ca_DecryptR2R(HI_UNF_ADVCA_KEYLADDER_LEV_E enLevel,HI_U32 *pDataIn,HI_U32 AddrID,HI_BOOL bEnOrDeCrypt)
{
    HI_S32 Ret;
    CA_FUNCSET_U FuncSet;
    CA_CTRL_U    CaCtrl;

    /* para check */
    if (enLevel > g_R2RLadderSel)
    {
        HI_ERR_CA("enLevel(%d) >= g_R2RLadderSel(%d)\n",enLevel,g_R2RLadderSel);
        return HI_ERR_CA_INVALID_PARA;
    }

    if (HI_NULL == pDataIn)
    {
        HI_ERR_CA("HI_NULL == pDataIn\n");
        return HI_ERR_CA_INVALID_PARA;
    }

    /*1  set CA register FUNC_SET as 0 */
    //g_pCaReg->FuncSet.Value = 0;
    FuncSet.Value = 0;
    ca_v200_WriteReg(CA_V200_LP_SET_ADD, FuncSet.Value);

    /*2  put DVB_RootKey（CK2）to CA register(DATA input) */
    ca_v200_WriteReg(CA_V200_DIN0_ADD, pDataIn[0]);
    ca_v200_WriteReg(CA_V200_DIN1_ADD, pDataIn[1]);
    ca_v200_WriteReg(CA_V200_DIN2_ADD, pDataIn[2]);
    ca_v200_WriteReg(CA_V200_DIN3_ADD, pDataIn[3]);

    /*3  wait DECRYPT_CTRL.Start equal to 0, then set DECRYPT_CTRL */
    Ret = ca_waitStat();
    if (Ret > 0)
    {
        HI_ERR_CA("key ladder timeout\n");
        return HI_ERR_CA_WAIT_TIMEOUT;
    }

    ca_clearStat();

    CaCtrl.Value = 0;
    CaCtrl.Bits.AlgSel = g_R2RAlgType;  /* support 3DES & AES */
    CaCtrl.Bits.KeyLadSel = enLevel;
    CaCtrl.Bits.CwOrR2r = 1;
    CaCtrl.Bits.EnOrDecrpt = bEnOrDeCrypt;

    if (g_R2RLadderSel == enLevel)
    {
        CaCtrl.Bits.KeyAddr = AddrID & 0x3F;
    }
    CaCtrl.Bits.CaStart = 1;
    ca_v200_WriteReg(CA_V200_CTRL_ADD, CaCtrl.Value);

    /*4 wait for decrypt done */
    Ret = ca_waitStat();
    if (Ret > 0)
    {
        HI_ERR_CA("key ladder timeout\n");
        return HI_ERR_CA_WAIT_TIMEOUT;
    }
    else if (Ret == -2)
    {
        HI_ERR_CA("Symetric key usage\n");
        return HI_ERR_CA_LPK_DECRYPT;
    }
    else if (Ret < 0)
    {
        HI_ERR_CA("key ladder error\n");
        return HI_FAILURE;
    }

    return HI_SUCCESS;
}

HI_S32 ca_DecryptLpk(HI_U32 *pEncryptLpk)
{
    HI_S32 Ret;
    CA_FUNCSET_U FuncSet;
    CA_CTRL_U    CaCtrl;
    CA_CTRLPROC_U CaCtrlProc;

    CaCtrlProc.Value = 0;
    ca_v200_ReadReg(CA_V200_CTRL_PROC_ADD, &CaCtrlProc.Value);

    /* 0.if support to LPK */
    if (CaCtrlProc.Bits.LkpDisable || g_CurPfOtp.bits.link_prt_disable)
    {
        HI_INFO_CA("Link Protection is not supported\n");
        return HI_ERR_CA_NOT_SUPPORT;
    }

    /* 1.wait for DECRYPT_CTRL.Start equal to 0 */
    Ret = ca_waitStat();
    if (Ret > 0)
    {
        HI_ERR_CA("key ladder timeout\n");
        return HI_ERR_CA_WAIT_TIMEOUT;
    }

    ca_clearStat();

    /* 2.set FUNC_SET as 2 */
    //g_pCaReg->FuncSet.Value = 2;
    FuncSet.Value = 2;
    ca_v200_WriteReg(CA_V200_LP_SET_ADD, FuncSet.Value);

    /* 3.put R2R(LPK) to CA register(DATA input) */
    ca_v200_WriteReg(CA_V200_DIN0_ADD, pEncryptLpk[0]);
    ca_v200_WriteReg(CA_V200_DIN1_ADD, pEncryptLpk[1]);
    ca_v200_WriteReg(CA_V200_DIN2_ADD, pEncryptLpk[2]);
    ca_v200_WriteReg(CA_V200_DIN3_ADD, pEncryptLpk[3]);

    /* 4.set to DECRYPT_CTRL */
    CaCtrl.Value = 0;
    CaCtrl.Bits.AlgSel = 0;     /* TDEA */
    CaCtrl.Bits.EnOrDecrpt = 1; /* Decrypt */
    CaCtrl.Bits.CaStart = 1;
    ca_v200_WriteReg(CA_V200_CTRL_ADD, CaCtrl.Value);

    /* 5.wait for DECRYPT_CTRL.Start equal to 0 */
    Ret = ca_waitStat();
    if (Ret > 0)
    {
        HI_ERR_CA("key ladder timeout\n");
        return HI_ERR_CA_WAIT_TIMEOUT;
    }
    else if (Ret < 0)
    {
        HI_ERR_CA("key ladder error\n");
        return HI_ERR_CA_LPK_DECRYPT;
    }

    return HI_SUCCESS;
}

HI_S32 ca_DecryptPrtData(HI_U32 *pEncryptData,HI_U32 *pClearData)
{
    HI_S32 Ret;
    CA_FUNCSET_U FuncSet;
    CA_CTRL_U    CaCtrl;
    CA_CTRLPROC_U CaCtrlProc;

    CaCtrlProc.Value = 0;
    ca_v200_ReadReg(CA_V200_CTRL_PROC_ADD, &CaCtrlProc.Value);

    /* 0.If support LPK */
    if (CaCtrlProc.Bits.LkpDisable || g_CurPfOtp.bits.link_prt_disable)
    {
        HI_INFO_CA("Link Protection is not supported\n");
        return HI_ERR_CA_NOT_SUPPORT;
    }

    /* 1.wait for DECRYPT_CTRL.Start equal to 0 */
    Ret = ca_waitStat();
    if (Ret > 0)
    {
        HI_ERR_CA("key ladder timeout\n");
        return HI_ERR_CA_WAIT_TIMEOUT;
    }

    ca_clearStat();

    /* 2.set to FUNC_SET as 3 */
    //g_pCaReg->FuncSet.Value = 3;
    FuncSet.Value = 3;
    ca_v200_WriteReg(CA_V200_LP_SET_ADD, FuncSet.Value);

    /* 3.put LPK(PROTECTED_DATA) to CA register(DATA input) */
    //g_pCaReg->CaDataIn0 = pEncryptData[0];
    //g_pCaReg->CaDataIn1 = pEncryptData[1];
    //g_pCaReg->CaDataIn2 = pEncryptData[0];
    //g_pCaReg->CaDataIn3 = pEncryptData[1] + 1;
    ca_v200_WriteReg(CA_V200_DIN0_ADD, pEncryptData[0]);
    ca_v200_WriteReg(CA_V200_DIN1_ADD, pEncryptData[1]);
    ca_v200_WriteReg(CA_V200_DIN2_ADD, pEncryptData[0]);
    ca_v200_WriteReg(CA_V200_DIN3_ADD, (pEncryptData[1]+1));

    /* 4.set DECRYPT_CTRL */
    CaCtrl.Value = 0;
    CaCtrl.Bits.AlgSel = 0;     /* TDEA */
    CaCtrl.Bits.EnOrDecrpt = 1; /* Decrypt */
    CaCtrl.Bits.CaStart = 1;
    ca_v200_WriteReg(CA_V200_CTRL_ADD, CaCtrl.Value);

    /* 5.wait for DECRYPT_CTRL.Start equal to 0 */
    Ret = ca_waitStat();
    if (Ret > 0)
    {
        HI_ERR_CA("key ladder timeout\n");
        return HI_ERR_CA_WAIT_TIMEOUT;
    }
    else if (Ret < 0)
    {
        HI_ERR_CA("key ladder error\n");
        return HI_ERR_CA_LPK_DECRYPT;
    }

    /* 6.when CPU read PARAMETER register，get PROTECTED_DATA */
    //memcpy((HI_U8*)pClearData,(HI_U8*)&g_pCaReg->LpPara[0],8);
    ca_v200_ReadReg(CA_V200_LP_PARAMETER_0_ADD, &pClearData[0]);
    ca_v200_ReadReg(CA_V200_LP_PARAMETER_1_ADD, &pClearData[1]);

    return HI_SUCCESS;
}

HI_S32 DRV_ADVCA_V200_EncryptSwpk(HI_U32 *pClearSwpk,HI_U32 *pEncryptSwpk)
{
    HI_S32 Ret;
    CA_FUNCSET_U FuncSet;
    CA_CTRL_U    CaCtrl;

    /* 1 wait for DECRYPT_CTRL.Start equal to 0 */
    Ret = ca_waitStat();
    if (Ret > 0)
    {
        HI_ERR_CA("key ladder timeout\n");
        return HI_ERR_CA_WAIT_TIMEOUT;
    }

    ca_clearStat();

    /*2	set CA register FUNC_SET as 4 */
    //g_pCaReg->FuncSet.Value = 4;
    FuncSet.Value = 4;
    ca_v200_WriteReg(CA_V200_LP_SET_ADD, FuncSet.Value);

    /*3	put SWPK to CA register(DATA input) */
    ca_v200_WriteReg(CA_V200_DIN0_ADD, pClearSwpk[0]);
    ca_v200_WriteReg(CA_V200_DIN1_ADD, pClearSwpk[1]);
    ca_v200_WriteReg(CA_V200_DIN2_ADD, pClearSwpk[2]);
    ca_v200_WriteReg(CA_V200_DIN3_ADD, pClearSwpk[3]);

    /*4	set DECRYPT_CTRL */
    CaCtrl.Value = 0;
    CaCtrl.Bits.AlgSel = 0;     /* TDEA */
    CaCtrl.Bits.EnOrDecrpt = 0; /* Encrypt */
    CaCtrl.Bits.CaStart = 1;
    ca_v200_WriteReg(CA_V200_CTRL_ADD, CaCtrl.Value);

    /*5	wait for DECRYPT_CTRL.Start equal to 0 */
    Ret = ca_waitStat();
    if (Ret > 0)
    {
        HI_ERR_CA("key ladder timeout\n");
        return HI_ERR_CA_WAIT_TIMEOUT;
    }
    else if (Ret < 0)
    {
        HI_ERR_CA("key ladder error\n");
        return HI_ERR_CA_SWPK_ENCRYPT;
    }

    /*6	when CPU read PARAMETER register，get R2R(SWPK) */
    //memcpy((HI_U8*)pEncryptSwpk,(HI_U8*)&g_pCaReg->LpPara[0],16);
    ca_v200_ReadReg(CA_V200_LP_PARAMETER_0_ADD, &pEncryptSwpk[0]);
    ca_v200_ReadReg(CA_V200_LP_PARAMETER_1_ADD, &pEncryptSwpk[1]);
    ca_v200_ReadReg(CA_V200_LP_PARAMETER_2_ADD, &pEncryptSwpk[2]);
    ca_v200_ReadReg(CA_V200_LP_PARAMETER_3_ADD, &pEncryptSwpk[3]);

    return HI_SUCCESS;
}

HI_S32 ca_DecryptSwpk(HI_U32 AddrID, HI_U32 *pEncryptSwpk)
{
    HI_S32 Ret;
    CA_FUNCSET_U FuncSet;
    CA_CTRL_U    CaCtrl;

    /* 1 wait for DECRYPT_CTRL.Start equal to 0 */
    Ret = ca_waitStat();
    if (Ret > 0)
    {
        HI_ERR_CA("key ladder timeout\n");
        return HI_ERR_CA_WAIT_TIMEOUT;
    }

    ca_clearStat();

    /*2	set CA register FUNC_SET as 8 */
    /*当bload_dec_flag为1，对数据进行解密并把解密后数据写入多通道cipher*/
    FuncSet.Value = 8;
    ca_v200_WriteReg(CA_V200_LP_SET_ADD, FuncSet.Value);

    /*3	put SWPK to CA register(DATA input) */
    ca_v200_WriteReg(CA_V200_DIN0_ADD, pEncryptSwpk[0]);
    ca_v200_WriteReg(CA_V200_DIN1_ADD, pEncryptSwpk[1]);
    ca_v200_WriteReg(CA_V200_DIN2_ADD, pEncryptSwpk[2]);
    ca_v200_WriteReg(CA_V200_DIN3_ADD, pEncryptSwpk[3]);

    /*4	set DECRYPT_CTRL */
    CaCtrl.Value = 0;
    CaCtrl.Bits.AlgSel = 0;     /* TDEA */
    CaCtrl.Bits.EnOrDecrpt = 1; /* Decrypt */
    CaCtrl.Bits.KeyAddr = AddrID & 0x3F;
    CaCtrl.Bits.CaStart = 1;
    ca_v200_WriteReg(CA_V200_CTRL_ADD, CaCtrl.Value);

    /*5	wait for DECRYPT_CTRL.Start equal to 0 */
    Ret = ca_waitStat();
    if (Ret > 0)
    {
        HI_ERR_CA("key ladder timeout\n");
        return HI_ERR_CA_WAIT_TIMEOUT;
    }
    else if (Ret < 0)
    {
        HI_ERR_CA("key ladder error\n");
        return HI_ERR_CA_SWPK_ENCRYPT;
    }

    return HI_SUCCESS;
}

HI_VOID ca_SetClock(HI_BOOL bEnable)
{
    HI_U32 CaCrgValue = 0;
    HI_U8 * pu8VirAddr = HI_NULL;

#ifdef SDK_SECURITY_ARCH_VERSION_V2
    pu8VirAddr= (HI_U8*)ioremap_nocache(CA_CRG_ADDR_CLK,0x10);
    if (HI_NULL == pu8VirAddr)
    {
        HI_ERR_OTP("ioremap_nocache map error\n");
        return;
    }

    Sys_rdReg(pu8VirAddr, &CaCrgValue);  //SC_PERI_CLKSTAT bit27
    /* Trun off Clock */
    if (HI_FALSE == bEnable)
    {
        CaCrgValue &= 0xF7FFFFFF;
        Sys_wtReg(pu8VirAddr,CaCrgValue);
    }
    /* Trun on Clock */
    else
    {
        CaCrgValue |= 0x8000000;
        Sys_wtReg(pu8VirAddr,CaCrgValue);
    }
    iounmap(pu8VirAddr);
#else
    pu8VirAddr= (HI_U8*)ioremap_nocache(CA_CRG_ADDR,0x10);
    if (HI_NULL == pu8VirAddr)
    {
        HI_ERR_OTP("ioremap_nocache map error\n");
        return;
    }

    Sys_rdReg(pu8VirAddr, &CaCrgValue);  //PERI_CRG29
    /* Trun off Clock */
    if (HI_FALSE == bEnable)
    {
        CaCrgValue &= 0x3FEFF;
        Sys_wtReg(pu8VirAddr,CaCrgValue);
    }
    /* Trun on Clock */
    else
    {
        CaCrgValue &= 0x0103;
        CaCrgValue |= 0x100;
        Sys_wtReg(pu8VirAddr,CaCrgValue);
    }
    iounmap(pu8VirAddr);
#endif
}

HI_VOID ca_SetReset(HI_BOOL bCancleOrSet)
{
    HI_U32 CaCrgValue = 0;
    HI_U8 * pu8VirAddr = HI_NULL;

#ifdef SDK_SECURITY_ARCH_VERSION_V2
    pu8VirAddr= (HI_U8*)ioremap_nocache(CA_CRG_ADDR_SRST_REQ,0x10);
    if(HI_NULL == pu8VirAddr)
    {
        HI_ERR_OTP("ioremap_nocache map error\n");
        return;
    }

    Sys_rdReg(pu8VirAddr, &CaCrgValue); //SC_PERI_SRST bit22
    /* Reset */
    if (HI_TRUE == bCancleOrSet)
    {
        CaCrgValue |= 0x400000;
        Sys_wtReg(pu8VirAddr,CaCrgValue);
    }
    /* Undo Reset */
    else
    {
        CaCrgValue &= 0xFFBFFFFF;
        Sys_wtReg(pu8VirAddr,CaCrgValue);
    }
    iounmap(pu8VirAddr);
#else
    pu8VirAddr= (HI_U8*)ioremap_nocache(CA_CRG_ADDR,0x10);
    if(HI_NULL == pu8VirAddr)
    {
        HI_ERR_OTP("ioremap_nocache map error\n");
        return;
    }

    Sys_rdReg(pu8VirAddr, &CaCrgValue);
    /* Reset */
    if (HI_TRUE == bCancleOrSet)
    {
        CaCrgValue |= 0x1;
        Sys_wtReg(pu8VirAddr,CaCrgValue);
    }
    /* Undo Reset */
    else
    {
        CaCrgValue &= 0x3FFFE;
        Sys_wtReg(pu8VirAddr,CaCrgValue);
    }
    iounmap(pu8VirAddr);
#endif
}

HI_S32 ca_Init(HI_VOID)
{
    HI_VOID *ptr;
    CA_SECBOOTCFG_U secBootCfg;
    HI_U32 count = 0;

    ca_SetClock(HI_TRUE);
    ca_SetReset(HI_FALSE);

    ptr = ca_ioremap_nocache(CA_BASE_ADDR, 0x1000);
    if (ptr == NULL)
    {
        HI_ERR_CA("ca_ioremap_nocache err\n");
        return HI_FAILURE;
    }

    g_CaVirAddr = ptr;

    pDrvSema = ca_create_mutex();
    if (NULL != pDrvSema)
    {
        HI_ERR_CA("fail to create ca mutex\n");
        return HI_FAILURE;
    }

    ca_initMutex(pDrvSema);

    g_CwAlgType  = HI_UNF_ADVCA_ALG_TYPE_TDES;
    g_R2RAlgType = HI_UNF_ADVCA_ALG_TYPE_TDES;

    /* OTP programmed tag */
    //g_CurPfOtp.u32 = g_pCaReg->CaPrmOtp;
    count = 0;
    do
    {
        count ++;

		secBootCfg.Value = 0;
		ca_v200_ReadReg(CA_V200_SECURE_BOOT_CFG_ADD, &(secBootCfg.Value));
        if(0 == secBootCfg.Bits.Valid)
        {
            break;
        }
        else if(count >= 1000)
        {
            break;
        }
    }while ( 1 );

    if(count >= 1000) //timeout!
    {
        HI_ERR_CA("CA key ladder is not ready, Fatal Error!\n");
        return HI_FAILURE;
    }
    g_CurPfOtp.u32 = 0;
    ca_v200_ReadReg(CA_V200_CTRL_PROC_ADD, &(g_CurPfOtp.u32));
    g_OrgPfOtp.u32 = g_CurPfOtp.u32;

    return HI_SUCCESS;
}

HI_VOID ca_deInit(void)
{
    if (g_CaVirAddr)
    {
        ca_iounmap((HI_VOID *)g_CaVirAddr);
        g_CaVirAddr = 0;
    }

    return;
}

/*****************************************************************************
 Prototype    :
 Description  : CA Module Interface
 Input        : None
 Output       : None
 Return Value : None
*****************************************************************************/
static HI_S32 ca_ext_Ioctl(unsigned int cmd, void* arg)
{
    HI_S32 ret;
    static HI_U8 keybuf[512] = {0};

    ret = HI_SUCCESS;
    switch (cmd)
    {
        // want nagra, delete conax
    case CMD_CA_EXT0_SETCWDEACTIVE:
        {
            ret = ca_setCWDeactive();
            break;
        }
    case CMD_CA_EXT0_GETCWDEACTIVE:
        {
            HI_U32 *pCwDeactive = (HI_U32*)arg;
            ret = ca_getCWDeactive(pCwDeactive);
            break;
        }
    case CMD_CA_EXT0_SETR2RDEACTIVE:
        {
            ret = ca_setR2RDeactive();
            break;
        }
    case CMD_CA_EXT0_GETR2RDEACTIVE:
        {
            HI_U32 *pR2RDeactive = (HI_U32*)arg;
            ret = ca_getR2RDeactive(pR2RDeactive);
            break;
        }
    case CMD_CA_EXT0_SETJTAGKEYLEN:
        {
            ret = ca_setJtagKeyLen();
            break;
        }
    case CMD_CA_EXT0_GETJTAGKEYLEN:
        {
            HI_U32 *plenType = (HI_U32*)arg;
            ret = ca_getJtagKeyLen(plenType);
            break;
        }
    case CMD_CA_SET_DVB_ROOT_KEY:
        {
            CA_KEY_S *pKey = (CA_KEY_S*)arg;
            memset(keybuf, 0xff, 32);
            memcpy(keybuf, pKey->KeyBuf, 16);

            ret = ca_setDvbRootKey(keybuf);
            break;
        }
    case CMD_CA_GET_DVB_ROOT_KEY:
        {
            CA_KEY_S *pKey = (CA_KEY_S*)arg;
            memset(keybuf, 0x0, 32);

            ret = ca_getDVBRootKey(keybuf);

            memcpy(pKey->KeyBuf,keybuf,16);
            break;
        }
    case CMD_CA_SET_R2R_ROOT_KEY:
        {
            CA_KEY_S *pKey = (CA_KEY_S*)arg;
            memset(keybuf, 0xff, 32);
            memcpy(keybuf, pKey->KeyBuf, 16);

            ret = ca_setR2RRootKey(keybuf);

            break;
        }
    case CMD_CA_GET_R2R_ROOT_KEY:
        {
            CA_KEY_S *pKey = (CA_KEY_S*)arg;
            memset(keybuf, 0x0, 32);

            ret = ca_getR2RRootKey(keybuf);

            memcpy(pKey->KeyBuf,keybuf,16);
            break;
        }
    case CMD_CA_SET_JTAG_KEY:
        {
            CA_KEY_S *pKey = (CA_KEY_S*)arg;
            memset(keybuf, 0xff, 16);
            memcpy(keybuf, pKey->KeyBuf, 8);

            ret = ca_setJtagKey(keybuf);

            break;
        }
    case CMD_CA_GET_JTAG_KEY:
        {
            CA_KEY_S *pKey = (CA_KEY_S*)arg;
            memset(keybuf, 0x0, 16);

            ret = ca_getJtagKey(keybuf);

            memcpy(pKey->KeyBuf,keybuf,8);
            break;
        }
    case CMD_CA_EXT1_SETRSAKEY:
        {
            CA_KEY_S *pKey = (CA_KEY_S*)arg;
            memset(keybuf, 0x0, 512);
            memcpy(keybuf, pKey->KeyBuf, 512);

            ret = ca_setRSAKey(keybuf);

            break;
        }
    case CMD_CA_EXT1_GETRSAKEY:
        {
            CA_KEY_S *pKey = (CA_KEY_S*)arg;
            memset(keybuf, 0x0, 512);

            ret = ca_getRSAKey(keybuf);
            memcpy(pKey->KeyBuf, keybuf, 512);
            break;
        }
    case CMD_CA_SET_CHIPID:
        {
            HI_U32 *pChipId = (HI_U32*)arg;
            ret = ca_setChipId(*pChipId);

            break;
        }
    case CMD_CA_EXT1_OTPREAD:
        {
            OTP_ENTRY_S *pOtpEntry = (OTP_ENTRY_S *)arg;
            otp_rd_u32(pOtpEntry->Addr,pOtpEntry->Value);
            break;
        }
    case CMD_CA_EXT1_OTPWRITE:
        {
            OTP_ENTRY_S *pOtpEntry = (OTP_ENTRY_S *)arg;
            otp_wt_u32(pOtpEntry->Addr,pOtpEntry->Value);
            break;
        }
	case CMD_CA_EXT1_OTPWRITEBYTE:
        {
            OTP_ENTRY_S *pOtpEntry = (OTP_ENTRY_S *)arg;
            otp_wt_u8(pOtpEntry->Addr,pOtpEntry->Value);
            break;
        }
	case CMD_CA_EXT1_OTPDISFUNC:
        {
            HI_U32 pos = *(HI_U32 *)arg;
            if (pos > 7)
            {
                ret = ENOIOCTLCMD;
			}
            else
            {
            	ret = (g_pOTPExportFunctionList->HAL_OTP_V100_FuncDisable)(pos,1);
            }
            break;
        }
    default:
        {
            ret = -ENOIOCTLCMD;
            break;
        }
    }

    return ret;
}

HI_S32 DRV_ADVCA_V200_Ioctl(unsigned int cmd, void* arg)
{
    HI_S32 ret = HI_SUCCESS;
    HI_U32 u32VendorId = 0;
    HI_U8 IDbuf[4] = {0};

    ret = ca_down_interruptible(pDrvSema);
    if (HI_FAILURE == ret)
    {
        HI_ERR_CA("%s:  down_interruptible err ! \n", __FUNCTION__);
        return HI_FAILURE;
    }

    ret = ca_getVendorId(&u32VendorId);
    if (HI_SUCCESS != ret)
    {
        HI_ERR_CA("%s:  get vendor type err ! \n", __FUNCTION__);
        ca_up(pDrvSema);
        return ret;
    }

    // 1
    switch (cmd)
    {
        case CMD_CA_GET_CHIPID:
        {
            HI_U32 *pu32ChipId = (HI_U32*)arg;

            if ((CA_OTP_VENDOR_CONAX == u32VendorId) || (CA_OTP_VENDOR_NAGRA == u32VendorId))
            {
                ret = ca_getChipID(pu32ChipId);
            }
            else
            {
                memset(IDbuf, 0x0, 4);
                ret = ca_getUniqueChipID(IDbuf);
                *pu32ChipId = (IDbuf[0]<<24) + (IDbuf[1]<<16) + (IDbuf[2]<<8) + IDbuf[3];
            }
            break;
        }
        case CMD_CA_GET_UNIQUE_CHIPID:
        {

            CA_KEY_S *pKey = (CA_KEY_S*)arg;
            memset(IDbuf, 0x0, 4);
            ret = ca_getUniqueChipID(IDbuf);
            memcpy(pKey->KeyBuf, IDbuf, 4);
            break;
        }
        case CMD_CA_SET_MARKETID:
        {
            if (CA_OTP_VENDOR_NAGRA == u32VendorId)
            {
                HI_U32 *pu32MaketId = (HI_U32*)arg;
                ret = ca_setMarketIDEx(*pu32MaketId);
            }
            else
            {
                CA_KEY_S *pKey = (CA_KEY_S*)arg;
                memset(IDbuf, 0x0, 4);
                memcpy(IDbuf, pKey->KeyBuf, 4);
                ret = ca_setMarketID(IDbuf);
            }
            break;
        }
        case CMD_CA_GET_MARKETID:
        {
            if (CA_OTP_VENDOR_NAGRA == u32VendorId)
            {
                HI_U32 *pu32MarketId = (HI_U32*)arg;
                ret = ca_getMarketIDEx(pu32MarketId);
            }
            else
            {
                CA_KEY_S *pKey = (CA_KEY_S*)arg;
                memset(IDbuf, 0x0, 4);
                ret = ca_getMarketID(IDbuf);
                memcpy(pKey->KeyBuf, IDbuf, 4);
            }
            break;
        }
        case CMD_CA_SET_STBSN:
        {
            if (CA_OTP_VENDOR_NAGRA == u32VendorId)
            {
                HI_U32 *pu32StbSN = (HI_U32*)arg;
                ret = ca_setStbSNEx(*pu32StbSN);
            }
            else
            {
                CA_KEY_S *pKey = (CA_KEY_S*)arg;
                memset(IDbuf, 0x0, 4);
                IDbuf[0] = pKey->KeyBuf[3];
                IDbuf[1] = pKey->KeyBuf[2];
                IDbuf[2] = pKey->KeyBuf[1];
                IDbuf[3] = pKey->KeyBuf[0];
                ret = ca_setStbSN(IDbuf);
            }
            break;
        }
        case CMD_CA_GET_STBSN:
        {
            if (CA_OTP_VENDOR_NAGRA == u32VendorId)
            {
                HI_U32 *pu32StbSN = (HI_U32*)arg;
                ret = ca_getStbSNEx(pu32StbSN);
            }
            else
            {
                CA_KEY_S *pKey = (CA_KEY_S*)arg;
                memset(IDbuf, 0x0, 4);
                ret = ca_getStbSN(IDbuf);
                pKey->KeyBuf[0] = IDbuf[3];
                pKey->KeyBuf[1] = IDbuf[2];
                pKey->KeyBuf[2] = IDbuf[1];
                pKey->KeyBuf[3] = IDbuf[0];
            }
            break;
        }
        case CMD_CA_LOCKHARDCWSEL:
        {
            ret = ca_LockHardCwSel();
            break;
        }
        case CMD_CA_LOCKBOOTDECEN:
        {
            ret = ca_LockBootDecEn();
            break;
        }
        case CMD_CA_LOCKR2RHARDKEY:
        {
            ret = ca_LockR2RHardKey();
            break;
        }
        case CMD_CA_STATHARDCWSEL :
        {
            HI_U32 *pbLock = (HI_U32*)arg;
            ret = ca_StatHardCwSel(pbLock);
            break;
        }
        case CMD_CA_STATR2RHARDKEY :
        {
            HI_U32 *pbLock = (HI_U32*)arg;
            ret = ca_StatR2RHardKey(pbLock);
            break;
        }
        case CMD_CA_STATTDESLOCK :
        {
            HI_U32 *pbLock = (HI_U32*)arg;
            ret = ca_StatTdesLock(pbLock);
            break;
        }
        case CMD_CA_DISABLELPT:
        {
            ret = ca_DisableLinkProtect();
            break;
        }
        case CMD_CA_DISABLESELFBOOT:
        {
            ret = ca_DisableSelfBoot();
            break;
        }
        case CMD_CA_SET_BOOTMODE:
        {
            HI_UNF_ADVCA_FLASH_TYPE_E BootMode = *(HI_UNF_ADVCA_FLASH_TYPE_E*)arg;
            ret = otp_setBootMode(BootMode);
            break;
        }
        case CMD_CA_GET_BOOTMODE:
        {
            HI_UNF_ADVCA_FLASH_TYPE_E *pBootMode = (HI_UNF_ADVCA_FLASH_TYPE_E*)arg;
            ret = otp_getBootMode(pBootMode);
            break;
        }
        case CMD_CA_SET_SCSACTIVE:
        {
            ret = otp_setSCSActive();
            break;
        }
        case CMD_CA_GET_SCSACTIVE:
        {
            HI_U32 *pu32SecBoot = (HI_U32*)arg;
            ret = otp_getSCSActive(pu32SecBoot);
            break;
        }
        case CMD_CA_SET_JTAGPRTMODE:
        {
            HI_UNF_ADVCA_JTAG_MODE_E JtagMode = *(HI_UNF_ADVCA_JTAG_MODE_E*)arg;
            ret = otp_setJtagPrtMode(JtagMode);
            break;
        }
        case CMD_CA_GET_JTAGPRTMODE:
        {
            HI_UNF_ADVCA_JTAG_MODE_E *pJtagMode = (HI_UNF_ADVCA_JTAG_MODE_E*)arg;
            ret = otp_getJtagPrtMode(pJtagMode);
            break;
        }
        case CMD_CA_DVB_SETLADDER:
        {
            HI_UNF_ADVCA_KEYLADDER_LEV_E DvbLadder = *(HI_UNF_ADVCA_KEYLADDER_LEV_E*)arg;
            ret = ca_setCWLadder(DvbLadder);
            break;
        }
        case CMD_CA_DVB_GETLADDER:
        {
            HI_UNF_ADVCA_KEYLADDER_LEV_E *pDvbLadder = (HI_UNF_ADVCA_KEYLADDER_LEV_E*)arg;
            ret = ca_getCWLadder(pDvbLadder);
            break;
        }
        case CMD_CA_R2R_SETLADDER:
        {
            HI_UNF_ADVCA_KEYLADDER_LEV_E R2RLadder = *(HI_UNF_ADVCA_KEYLADDER_LEV_E*)arg;
            ret = ca_setR2RLadder(R2RLadder);
            break;
        }
        case CMD_CA_R2R_GETLADDER:
        {
            HI_UNF_ADVCA_KEYLADDER_LEV_E *pR2RLadder = (HI_UNF_ADVCA_KEYLADDER_LEV_E*)arg;
            ret = ca_getR2RLadder(pR2RLadder);
            break;
        }
        // TODO: Need set? Now fix on TDEA
        case CMD_CA_DVB_SETALG:
        {
            HI_UNF_ADVCA_ALG_TYPE_E CwAlgType = *(HI_U32*)arg;
            ret = ca_setCWAlg(CwAlgType);
            break;
        }

        case CMD_CA_R2R_SETALG:
        {
            HI_UNF_ADVCA_ALG_TYPE_E R2RType = *(HI_U32*)arg;
            ret = ca_setR2RAlg(R2RType);
            break;
        }
        case CMD_CA_DVB_GETALG:
        {
            HI_UNF_ADVCA_ALG_TYPE_E *pCwAlgType = (HI_UNF_ADVCA_ALG_TYPE_E*)arg;
            ret = ca_getCWAlg(pCwAlgType);
            break;
        }
        case CMD_CA_R2R_GETALG:
        {
            HI_UNF_ADVCA_ALG_TYPE_E *pR2RAlgType = (HI_UNF_ADVCA_ALG_TYPE_E*)arg;
            ret = ca_getR2RAlg(pR2RAlgType);
            break;
        }
        case CMD_CA_DVB_CRYPT:
        {
            CA_CRYPTPM_S CryptParam = *(CA_CRYPTPM_S*)arg;
            ret = ca_DecryptCw(CryptParam.ladder,CryptParam.pDin,0,0);
            break;
        }
        case CMD_CA_R2R_CRYPT:
        {
            CA_CRYPTPM_S CryptParam = *(CA_CRYPTPM_S*)arg;
            ret = ca_DecryptR2R(CryptParam.ladder,CryptParam.pDin,0,1);
            break;
        }
        case CMD_CA_LPK_LOAD:
        {
            CA_LOADLPK_S *pLoadLpk = (CA_LOADLPK_S*)arg;
            /* Decrypt LPK */
            ret = ca_DecryptLpk(pLoadLpk->EncryptLpk);
            if (HI_SUCCESS != ret)
            {
                HI_ERR_CA("ca_DecryptLpk error\n");
            }
            break;
        }
        case CMD_CA_LPK_DECRYPT :
        {
            CA_DECRYPTLPTDATA_S *pDecryptLptData = (CA_DECRYPTLPTDATA_S*)arg;
            /* Decrypt data*/
            ret = ca_DecryptPrtData(pDecryptLptData->EncryptData,pDecryptLptData->ClearData);
            if (HI_SUCCESS != ret)
            {
                HI_ERR_CA("ca_DecryptLpk error\n");
            }
            break;
        }
        case CMD_CA_SWPK_CRYPT :
        {
            CA_ENCRYPTSWPK_S *pEncryptSwpk = (CA_ENCRYPTSWPK_S*)arg;
            ret = DRV_ADVCA_V200_EncryptSwpk(pEncryptSwpk->ClearSwpk,pEncryptSwpk->EncryptSwpk);
            if (HI_SUCCESS != ret)
            {
                HI_ERR_CA("DRV_ADVCA_V200_EncryptSwpk error\n");
            }
            break;
        }
        case CMD_CA_SWPK_KEY_LADDER_OPEN:
        {
            DRV_ADVCA_V200_SWPKKeyLadderOpen();
            break;
        }
        case CMD_CA_SWPK_KEY_LADDER_CLOSE:
        {
            DRV_ADVCA_V200_SWPKKeyLadderClose();
            break;
        }
#if 0
        case CMD_CA_SET_RSVDATA:
        {
            CA_RSVDATA_S *pRsvData = (CA_RSVDATA_S*)arg;
            ret = otp_setRsvData(pRsvData);
            break;
        }
        case CMD_CA_GET_RSVDATA:
        {
            CA_RSVDATA_S *pRsvData = (CA_RSVDATA_S*)arg;
            ret = otp_getRsvData(pRsvData);
            break;
        }
#endif
        case CMD_CA_SET_PROTECT:
        {
            HI_S32 ret;
            ret = (g_pOTPExportFunctionList->HAL_OTP_V100_SetWriteProtect)();
            if (ret)
            {
                ret = HI_FAILURE;
            }
            else
            {
                ret = HI_SUCCESS;
            }
            break;
        }

        case CMD_CA_GET_PROTECT:
        {
            HI_U32 *pu32Protect = (HI_U32*)arg;
            (g_pOTPExportFunctionList->HAL_OTP_V100_GetWriteProtect)(pu32Protect);
            break;
        }
#ifndef SDK_SECURITY_ARCH_VERSION_V2
        case CMD_CA_GET_CHIP_VERSION:
        {
            HI_CHAR *pChipVersion = (HI_CHAR*)arg;
            HI_CHIP_VERSION_E ChipVersion;
            HI_CHIP_TYPE_E enChipType;
            (HI_VOID)DRV_ADVCA_GetChipVersion(&enChipType, &ChipVersion);

            switch(ChipVersion)
            {
                case HI_CHIP_VERSION_V100:
                case HI_CHIP_VERSION_V101:
                    ca_snprintf(pChipVersion, 3, "11");
                    break;
                case HI_CHIP_VERSION_V200:
                    ca_snprintf(pChipVersion, 3, "20");
                    break;
                default:
                    ca_snprintf(pChipVersion, 3, "xx");
                    break;
            }

            break;
        }
#else
        case CMD_CA_GET_CHIP_VERSION:
        {
            HI_U32 *pChipVersion = (HI_U32*)arg;
            HI_U32 u32Value = 0;
            HI_U8 *pu8VirAddr = HI_NULL;
            pu8VirAddr= (HI_U8*)ioremap_nocache(CA_SYSCTRL_BASE,0x10);
            if(HI_NULL == pu8VirAddr)
            {
                HI_ERR_OTP("ioremap_nocache map error\n");
                return HI_FAILURE;
            }

            Sys_rdReg(pu8VirAddr, &u32Value);
            iounmap(pu8VirAddr);
            u32Value = (u32Value >> 10) & 0x1f;
            switch (u32Value)
            {
                case 0x1C :
                case 0x1F :
                    *pChipVersion = 0x20;
                    break;
                case 0x1D:
                    *pChipVersion = 0x30;
                    break;
                case 0x1E :
                    *pChipVersion = 0x40;
                    break;
                default:
                    *pChipVersion = 0;
                    ret = HI_FAILURE;
                    break;
            }
            break;
        }
#endif
        case CMD_CA_SET_MCKL_DES_HARD_DISABLE:
        {
            HI_U32 *pu32TdesLock = (HI_U32*)arg;
            ret = ca_setTdesLock(*pu32TdesLock);
            break;
        }
        case CMD_CA_SET_VENDOR_ID:
        {
            HI_U32 *pu32VendorId = (HI_U32 *)arg;
            ret = ca_setVendorId((CA_OTP_VENDOR_TYPE_E)*pu32VendorId);
            break;
        }
        case CMD_CA_GET_VENDOR_ID:
        {
            HI_U32 *pu32VendorId = (HI_U32*)arg;
            ret = ca_getVendorId((CA_OTP_VENDOR_TYPE_E *)pu32VendorId);
            break;
        }
        case CMD_CA_SET_VENDOR_ID_LOCK:
        {
            ret = ca_setSecureChipP();
            break;
        }
        case CMD_CA_GET_VENDOR_ID_LOCK:
        {
            HI_U32 *pu32SecureChipP = (HI_U32*)arg;
            ret = ca_getSecureChipP(pu32SecureChipP);
            break;
        }
        case CMD_CA_SET_LOWPOWER_DISABLE:
        {
            HI_U32 *pu32LowPowerDisable = (HI_U32*)arg;
            ret = ca_setLowPowerDisable(*pu32LowPowerDisable);
            break;
        }
        case CMD_CA_GET_LOWPOWER_DISABLE:
        {
            HI_U32 *pu32LowPowerDisable = (HI_U32*)arg;
            ret = ca_getLowPowerDisable(pu32LowPowerDisable);
            break;
        }
        case CMD_CA_SET_PCIE_EN:
        {
            HI_U32 *pu32PcieEn = (HI_U32*)arg;
            ret = ca_setPcieEn(*pu32PcieEn);
            break;
        }
        case CMD_CA_GET_PCIE_EN:
        {
            HI_U32 *pu32PcieEn = (HI_U32*)arg;
            ret = ca_getPcieEn(pu32PcieEn);
            break;
        }
        case CMD_CA_SET_CSA3_EN:
        {
            ret = ca_setCsa3En();
            break;
        }
        case CMD_CA_GET_CSA3_EN:
        {
            HI_U32 *pu32Csa3En = (HI_U32*)arg;
            ret = ca_getCsa3En(pu32Csa3En);
            break;
        }
        case CMD_CA_SET_LPC_DISABLE:
        {
            HI_U32 *pu32LpcEn = (HI_U32*)arg;
            ret = ca_setLpcEn(*pu32LpcEn);
            break;
        }
        case CMD_CA_GET_LPC_DISABLE:
        {
            HI_U32 *pu32LpcEn = (HI_U32*)arg;
            ret = ca_getLpcEn(pu32LpcEn);
            break;
        }
        case CMD_CA_SET_LPC_MASTER_DISABLE:
        {
            HI_U32 *pu32LpcMasterEn = (HI_U32*)arg;
            ret = ca_setLpcMasterEn(*pu32LpcMasterEn);
            break;
        }
        case CMD_CA_GET_LPC_MASTER_DISABLE:
        {
            HI_U32 *pu32LpcMasterEn = (HI_U32*)arg;
            ret = ca_getLpcMasterEn(pu32LpcMasterEn);
            break;
        }
        case CMD_CA_SET_BOOT_SEL_LOCK_0:
        {
            ret = ca_setBootSelLock();
            break;
        }
        case CMD_CA_GET_BOOT_SEL_LOCK_0:
        {
            HI_U32 *pu32BootSelLock = (HI_U32*)arg;
            ret = ca_getBootSelLock(pu32BootSelLock);
            break;
        }
        case CMD_CA_SET_MKTID_LOCK:
        {
            ret = ca_setMktIdP();
            break;
        }
        case CMD_CA_GET_MKTID_LOCK:
        {
            HI_U32 *pu32MktIdP = (HI_U32*)arg;
            ret = ca_getMktIdP(pu32MktIdP);
            break;
        }
        case CMD_CA_SET_STBSN_LOCK:
        {
            HI_U32 *pu32StbSnP = (HI_U32*)arg;
            ret = ca_setStbSnP(*pu32StbSnP);
            break;
        }
        case CMD_CA_GET_STBSN_LOCK:
        {
            HI_U32 *pu32StbSnP = (HI_U32*)arg;
            ret = ca_getStbSnP(pu32StbSnP);
            break;
        }
        case CMD_CA_GET_SELFBOOT:
        {
            HI_U32 *pu32SelfBoot = (HI_U32*)arg;
            ret = ca_getSelfBoot(pu32SelfBoot);
            break;
        }
        case CMD_CA_SETSR7:
        {
            HI_U32 *pu32SR = (HI_U32*)arg;
            ret = ca_setSR7(*pu32SR);
            break;
        }
        case CMD_CA_GETSR7:
        {
            HI_U32 *pu32SR = (HI_U32*)arg;
            ret = ca_getSR7(pu32SR);
            break;
        }
        case CMD_CA_SETSR6:
        {
            HI_U32 *pu32SR = (HI_U32*)arg;
            ret = ca_setSR6(*pu32SR);
            break;
        }
        case CMD_CA_GETSR6:
        {
            HI_U32 *pu32SR = (HI_U32*)arg;
            ret = ca_getSR6(pu32SR);
            break;
        }
        case CMD_CA_SETSR4:
        {
            HI_U32 *pu32SR = (HI_U32*)arg;
            ret = ca_setSR4(*pu32SR);
            break;
        }
        case CMD_CA_GETSR4:
        {
            HI_U32 *pu32SR = (HI_U32*)arg;
            ret = ca_getSR4(pu32SR);
            break;
        }
        case CMD_CA_SETSR2:
        {
            HI_U32 *pu32SR = (HI_U32*)arg;
            ret = ca_setSR2(*pu32SR);
            break;
        }
        case CMD_CA_GETSR2:
        {
            HI_U32 *pu32SR = (HI_U32*)arg;
            ret = ca_getSR2(pu32SR);
            break;
        }
        case CMD_CA_SET_MISC_CTRL_EN:
        {
            ret = ca_setMiscCtrlEn();
            break;
        }
        case CMD_CA_GET_MISC_CTRL_EN:
        {
            HI_U32 *pu32MiscCtrlEn = (HI_U32*)arg;
            ret = ca_getMiscCtrlEn(pu32MiscCtrlEn);
            break;
        }
        case CMD_CA_CHECK_MARKET_ID_SET:
        {
            HI_U32 u32MarketIdSet;
            HI_BOOL *pbIsMarketIdSet = (HI_BOOL*)arg;
            ret = ca_getMktIdP(&u32MarketIdSet);
            if (ret)
            {
                ret = HI_FAILURE;
            }
            else
            {
                ret = HI_SUCCESS;
            }
            *pbIsMarketIdSet = (HI_BOOL)u32MarketIdSet;
            break;
        }
        case CMD_CA_LOCKSECRETKEY:
        {
            ret = (g_pOTPExportFunctionList->HAL_OTP_V100_FuncDisable)(2, 1);
            ret |= (g_pOTPExportFunctionList->HAL_OTP_V100_FuncDisable)(4, 1);
            ret |= (g_pOTPExportFunctionList->HAL_OTP_V100_FuncDisable)(6, 1);
            break;
        }
        case CMD_CA_GET_REVISION:
        {
            CA_KEY_S *pKey = (CA_KEY_S*)arg;

            if (CA_OTP_VENDOR_NAGRA == u32VendorId)
            {
            	if ( strlen(NAGRA_REVISION) > 25 )
            	{
	                memcpy(pKey->KeyBuf, NAGRA_REVISION, 25);
            	}
				else
				{
				    memcpy(pKey->KeyBuf, NAGRA_REVISION, strlen(NAGRA_REVISION));
				}
            }
            else
            {
            	if ( strlen(ADVCA_REVISION) > 25 )
            	{
            	    memcpy(pKey->KeyBuf, ADVCA_REVISION, 25);
            	}
				else
				{
				    memcpy(pKey->KeyBuf, ADVCA_REVISION, strlen(ADVCA_REVISION));
				}

            }
            break;
        }
        default:
        {
            ret = ca_ext_Ioctl(cmd, arg);
            break;
        }
    }

    ca_up(pDrvSema);

    if (ret == HI_SUCCESS)
    {
        HI_INFO_CA("cmd = 0x%08x  ok !\n", cmd);
    }

    return ret;
}

int DRV_ADVCA_V200_Open(HI_VOID)
{
    HI_S32 ret = HI_SUCCESS;
    HI_U32 u32Value = 0;

    ret = ca_down_interruptible(pDrvSema);
    if (HI_FAILURE == ret)
    {
        HI_ERR_CA("%s:  down_interruptible err ! \n", __FUNCTION__);
        return HI_FAILURE;
    }

    (HI_VOID)ca_atomic_inc_return(&u32Value);
    if (u32Value == 1)
    {
        ca_setCWAlg(HI_UNF_ADVCA_ALG_TYPE_TDES);
        ca_setR2RAlg(HI_UNF_ADVCA_ALG_TYPE_TDES);
        ca_getCWLadder(&g_CwLadderSel);
        ca_getR2RLadder(&g_R2RLadderSel);
    }

    ca_up(pDrvSema);
    return 0;
}

int DRV_ADVCA_V200_Release(HI_VOID)
{
    HI_S32 ret = HI_SUCCESS;
    HI_U32 u32Value = 0;

    ret = ca_down_interruptible(pDrvSema);
    if (HI_FAILURE == ret)
    {
        HI_ERR_CA("%s:  down_interruptible err ! \n", __FUNCTION__);
        return HI_FAILURE;
    }

    ret = ca_atomic_dec_return(&u32Value);
    if (HI_FAILURE == ret)
    {
        return HI_FAILURE;
    }

    if (0 == u32Value)
    {
        HI_INFO_CA("%s:  ok ! \n", __FUNCTION__);
    }

    ca_up(pDrvSema);

    return 0;
}

/*****************************************************************************
 Prototype    :
 Description  : CA Module interface for Other Modules
 Input        : None
 Output       : None
 Return Value : None
*****************************************************************************/

HI_S32 DRV_ADVCA_V200_DecryptCws(HI_U32 AddrID,HI_U32 EvenOrOdd, HI_U8 *pu8Data)
{
    HI_S32 ret = HI_SUCCESS;
    HI_U32 u32Value = 0;

    if (pu8Data == NULL)
    {
        HI_ERR_CA("Param error\n");
        return HI_ERR_CA_INVALID_PARA;
    }

    ret = ca_atomic_read(&u32Value);
    if (HI_FAILURE == ret)
    {
        return HI_FAILURE;
    }

    if (0 == u32Value)
    {
        HI_ERR_CA("not init ! \n");
        return HI_ERR_CA_NOT_INIT;
    }

    // 1
    ret = ca_down_interruptible(pDrvSema);
    if (HI_FAILURE == ret)
    {
        HI_ERR_CA("%s:  down_interruptible err ! \n", __FUNCTION__);
        return HI_FAILURE;
    }

    ret = ca_DecryptCw(g_CwLadderSel,(HI_U32*)pu8Data,AddrID,EvenOrOdd);
    if (HI_SUCCESS != ret)
    {
        ca_up(pDrvSema);
        return ret;
    }

    ca_up(pDrvSema);

    return HI_SUCCESS;
}

HI_S32 DRV_ADVCA_V200_DecryptCipher(HI_U32 AddrID, HI_U32 *pu32DataIn)
{
    HI_S32 ret;
    HI_U32 u32Value = 0;
    // 0
    if (pu32DataIn == NULL)
    {
        HI_ERR_CA("Param error\n");
        return HI_ERR_CA_INVALID_PARA;
    }

    ret = ca_atomic_read(&u32Value);
    if (HI_FAILURE == ret)
    {
        return HI_FAILURE;
    }

    if ( 0 == u32Value)
    {
        HI_ERR_CA("not init ! \n");
        return HI_ERR_CA_NOT_INIT;
    }

    // 1
    ret = ca_down_interruptible(pDrvSema);
    if (HI_FAILURE == ret)
    {
        HI_ERR_CA("%s:  down_interruptible err ! \n", __FUNCTION__);
        return HI_FAILURE;
    }

    if(g_IsSWPKKeyLadderOpen)
    {
        ret = ca_DecryptSwpk(AddrID, pu32DataIn);
        if (ret)
        {
            ca_up(pDrvSema);
            return ret;
        }
    }
    else
    {
        ret = ca_DecryptR2R(g_R2RLadderSel, pu32DataIn, AddrID, 1);
        if (ret)
        {
            ca_up(pDrvSema);
            return ret;
        }
    }

    ca_up(pDrvSema);

    return HI_SUCCESS;
}

HI_S32 DRV_ADVCA_V200_EncryptCipher(HI_U32 AddrID, HI_U32 *pu32DataIn)
{
    HI_S32 ret;
    HI_U32 u32Value = 0;

    // 0
    if (pu32DataIn == NULL)
    {
        HI_ERR_CA("Param error\n");
        return HI_ERR_CA_INVALID_PARA;
    }

    ret = ca_atomic_read(&u32Value);
    if (HI_FAILURE == ret)
    {
        return HI_FAILURE;
    }

    if (0 == u32Value)
    {
        HI_ERR_CA("not init ! \n");
        return HI_ERR_CA_NOT_INIT;
    }

    ret = ca_down_interruptible(pDrvSema);
    if (HI_FAILURE == ret)
    {
        HI_ERR_CA("%s:  down_interruptible err ! \n", __FUNCTION__);
        return HI_FAILURE;
    }

    ret = ca_DecryptR2R(g_R2RLadderSel, pu32DataIn, AddrID, 0);
    if (ret)
    {
        ca_up(pDrvSema);
        return ret;
    }

    ca_up(pDrvSema);

    return HI_SUCCESS;
}

HI_S32 DRV_ADVCA_V200_SWPKKeyLadderOpen(HI_VOID)
{
    g_IsSWPKKeyLadderOpen = HI_TRUE;
    return HI_SUCCESS;
}

HI_S32 DRV_ADVCA_V200_SWPKKeyLadderClose(HI_VOID)
{
    g_IsSWPKKeyLadderOpen = HI_FALSE;
    return HI_SUCCESS;
}

HI_U32 ca_v200_rdReg(HI_U32 u32RegAddr)
{
    HI_U32 u32Value;

    ca_v200_ReadReg(u32RegAddr, &u32Value);
    return u32Value;
}


/*****************************************************************************
 Prototype    :
 Description  : CA Module register function
 Input        : None
 Output       : None
 Return Value : None
*****************************************************************************/

HI_S32  DRV_ADVCA_V200_ModeInit_0(HI_VOID)
{
    HI_S32 ret = HI_SUCCESS;

    ret = ca_Init();
    if (ret != HI_SUCCESS)
    {
        HI_FATAL_CA("register CA failed.\n");
        return HI_FAILURE;
    }

    DRV_ADVCA_V200_RegisterRebootNotifier();

    return HI_SUCCESS;
}

HI_VOID DRV_ADVCA_V200_ModeExit_0(HI_VOID)
{
    ca_deInit();

    return;
}
/*--------------------------------END-----------------------------------*/
