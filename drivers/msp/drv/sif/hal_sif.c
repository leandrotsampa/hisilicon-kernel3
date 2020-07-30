/******************************************************************************

  Copyright (C), 2012-2014, Hisilicon Tech. Co., Ltd.

 ******************************************************************************
  File Name     : hal_ademod.c
  Version       : Initial Draft
  Author        : Hisilicon multimedia software group
  Created       : 2012/09/20
  Description   : 
  History       :
  1.Date        : 2012/09/20
    Author      : m00196336
    Modification: Created file
******************************************************************************/
#include <asm/io.h>
#include <linux/module.h>

#include "sif_reg.h"
#include "hal_sif.h"
#include "drv_sif_ioctl.h"
#include "hi_type.h"
#include "hi_reg_common.h"

static HI_U32 g_u32SifBase = 0;
static HI_U32 g_u32CrgBase = 0;

#define SIF_REGS_ADDR    0xFF230000
#define SIF_REGS_SIZE    0x10000

#define SIF_CRG_REGS_ADDR    0xf8a22000
#define SIF_CRG_REGS_SIZE    0x10000

HI_S32 SIF_CRG_HAL_Init(HI_VOID)
{    
    g_u32CrgBase = (HI_U32)ioremap_nocache(SIF_CRG_REGS_ADDR, SIF_CRG_REGS_SIZE);
    if (0 == g_u32CrgBase)
    {
        return HI_FAILURE;
    }
    
    return HI_SUCCESS;
}

HI_S32 SIF_CRG_HAL_DeInit(HI_VOID)
{    
    iounmap((void __iomem *)g_u32CrgBase);
    
    return HI_SUCCESS;
}

static inline HI_VOID SIF_CRG_HAL_WriteReg(HI_U32 u32Offset, HI_U32 u32Value)
{
    (*(volatile HI_U32*)((HI_U32)(g_u32CrgBase) + (HI_U32)u32Offset)) = u32Value;
}

static inline HI_U32 SIF_CRG_HAL_ReadReg(HI_U32 u32Offset)
{
    return (*(volatile HI_U32*)((HI_U32)g_u32CrgBase + (HI_U32)u32Offset));
}

HI_S32 SIF_CRG_HAL_Reset(HI_VOID)
{
    #if 1
        U_PERI_CRG103 unTmp;
        unTmp.u32 = SIF_CRG_HAL_ReadReg(SIF_CRG_OFFSET);
        unTmp.bits.demod_srst_req = HI_TRUE;
        SIF_CRG_HAL_WriteReg(SIF_CRG_OFFSET, unTmp.u32);
    #else
        U_PERI_CRG103 uTmpVal;
        uTmpVal.u32 = g_pstRegCrg->PERI_CRG103.u32;
        uTmpVal.bits.demod_srst_req = HI_TRUE;
        g_pstRegCrg->PERI_CRG103.u32 = uTmpVal.u32;
    #endif
        
    return HI_SUCCESS;
}

HI_S32 SIF_CRG_HAL_NoReset(HI_UNF_SIF_AIF_MODE_E enOpenParam)
{
    #if 1
    U_PERI_CRG103 unTmp;
    unTmp.u32 = SIF_CRG_HAL_ReadReg(SIF_CRG_OFFSET);

    switch (enOpenParam)
    {
        case HI_UNF_SIF_AIF_MODE_INTERNEL:
            unTmp.bits.demod_cken       = HI_TRUE;
            unTmp.bits.afe2_cken        = HI_TRUE;
            unTmp.bits.sif_cken         = HI_TRUE;
            unTmp.bits.pwm_sif_cken     = HI_TRUE;
            unTmp.bits.demod_srst_req   = HI_FALSE;
            unTmp.bits.demod_cksel      = SIF_CRG_DEMODE_CKSEL_INTERL;
            unTmp.bits.afe2_clkin_pctrl = HI_FALSE;
            unTmp.bits.pwm_sif_srst_req = HI_FALSE;
            unTmp.bits.demod_fsclk_div  = SIF_CRG_DEMODE_FSCLKDIV_256;
            unTmp.bits.demod_bclk_div   = SIF_CRG_DEMODE_BCLKDIV_3;
            break;
        case HI_UNF_SIF_AIF_MODE_EXTERN:
            break;
        default:
            break;
    }

    SIF_CRG_HAL_WriteReg(SIF_CRG_OFFSET, unTmp.u32);
    #else    
    switch (enOpenParam)
    {
        case HI_UNF_SIF_AIF_MODE_INTERNEL:
        {
            U_PERI_CRG103 uTmpVal;
            uTmpVal.u32 = g_pstRegCrg->PERI_CRG103.u32;
            uTmpVal.bits.demod_cken       = HI_TRUE;
            uTmpVal.bits.afe2_cken        = HI_TRUE;
            uTmpVal.bits.sif_cken         = HI_TRUE;
            uTmpVal.bits.pwm_sif_cken     = HI_TRUE;
            uTmpVal.bits.demod_srst_req   = HI_FALSE;
            uTmpVal.bits.demod_cksel      = SIF_CRG_DEMODE_CKSEL_INTERL;
            uTmpVal.bits.afe2_clkin_pctrl = HI_FALSE;
            uTmpVal.bits.pwm_sif_srst_req = HI_FALSE;
            uTmpVal.bits.demod_fsclk_div  = SIF_CRG_DEMODE_FSCLKDIV_256;
            uTmpVal.bits.demod_bclk_div   = SIF_CRG_DEMODE_BCLKDIV_3;
            g_pstRegCrg->PERI_CRG103.u32 = uTmpVal.u32;
            break;
        }
        case HI_UNF_SIF_AIF_MODE_EXTERN:
            break;
        default:
            break;
    }
    #endif
        
    return HI_SUCCESS;

}

static inline HI_VOID SIF_HAL_WriteReg(HI_U32 u32Offset, HI_U32 u32Value)
{
    (*(volatile HI_U32*)((HI_U32)(g_u32SifBase) + (HI_U32)(u32Offset * 4))) = u32Value;
}

static inline HI_VOID SIF_HAL_WriteRegU16(HI_U32 u32Offset, HI_U32 u32Value)
{
    HI_U32 ValueL = u32Value & 0xff;
    HI_U32 ValueH = (u32Value >> 8) & 0xff;

    SIF_HAL_WriteReg(u32Offset, ValueH);
    SIF_HAL_WriteReg(u32Offset + 1, ValueL);
}

static inline HI_U32 SIF_HAL_ReadReg(HI_U32 u32Offset)
{
    return (*(volatile HI_U32*)((HI_U32)g_u32SifBase + (HI_U32)(u32Offset * 4)));
}

static inline HI_U32 SIF_HAL_ReadRegU16(HI_U32 u32Offset)
{
   HI_U32 u32ValueH, u32ValueL;

   u32ValueH = SIF_HAL_ReadReg(u32Offset);
   u32ValueL = SIF_HAL_ReadReg(u32Offset + 1);

   return ((u32ValueH<<8)|u32ValueL);
}

HI_S32 SIF_HAL_Init(HI_VOID)
{
    g_u32SifBase = (HI_U32)ioremap_nocache(SIF_REGS_ADDR, SIF_REGS_SIZE);
    if (0 == g_u32SifBase)
    {
        return HI_FAILURE;
    }

    return HI_SUCCESS;
}

HI_S32 SIF_HAL_DeInit(HI_VOID)
{
    iounmap((void __iomem *)g_u32SifBase);
    
    return HI_SUCCESS;
}

HI_BOOL SIF_HAL_GetIntRaw(HI_VOID)
{
    U_ADEMOD_INT_RAW umTmp;

    umTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_INTR_RAW);

    return umTmp.bits.int_raw;
}

HI_BOOL SIF_HAL_GetIntStatus(HI_VOID)
{
    U_ADEMOD_INT_STATUS umTmp;

    umTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_INTR_STATUS);

    return umTmp.bits.int_status;
}

HI_VOID SIF_HAL_SetIntEn(HI_BOOL bEn)
{
    U_ADEMOD_INT_ENABLE unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_INTR_EN);

    unTmp.bits.int_enable = bEn;

    SIF_HAL_WriteReg(ADEMOD_REG_INTR_EN, unTmp.u32);
}

HI_VOID SIF_HAL_SetIntClr(HI_VOID)
{
    U_ADEMOD_INT_CLR unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_INTR_CLR);

    unTmp.bits.int_clr = 1;

    SIF_HAL_WriteReg(ADEMOD_REG_INTR_CLR, unTmp.u32);
}

/*(0x00) System Select Register */
HI_VOID SIF_HAL_ASDEn(HI_BOOL bEnable)
{
    U_ADEMOD_SYS_SEL unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_SYS_SEL);

    unTmp.bits.ASDEn = bEnable;
    
//    HI_ERR_SIF("__FUNCTION__ = %s, __LINE__ = %d, unTmp.bits.ASDEn = %d\n", __FUNCTION__, __LINE__, unTmp.bits.ASDEn);

    SIF_HAL_WriteReg(ADEMOD_REG_SYS_SEL, unTmp.u32);
}

HI_VOID SIF_HAL_SetSysSel(SIF_SYS_SEL_E enValue)
{
    U_ADEMOD_SYS_SEL unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_SYS_SEL);

    unTmp.bits.sys_sel = enValue;

    SIF_HAL_WriteReg(ADEMOD_REG_SYS_SEL, unTmp.u32);
}

HI_U32 SIF_HAL_GetDetStandard(HI_VOID)
{
    U_ADEMOD_SYS_SEL unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_SYS_SEL);
    
    return unTmp.bits.sys_sel;
}

/*(0x01) Standard Select Register, read System Select Register(0x00), set standselect register following the result */
/*BTSC stereo or BTSC SAP*/
HI_VOID SIF_HAL_SetBTSCSap(SIF_STAND_SEL_E enValue)
{
    U_ADEMOD_STNDRD_SEL unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_STAND_SEL);

    unTmp.bits.stndrd = enValue;

    SIF_HAL_WriteReg(ADEMOD_REG_STAND_SEL, unTmp.u32);
}

/*(0x02) Sample Rate Register */
HI_VOID SIF_HAL_SetSampleRate(SIF_SAMPLE_RATE_E enValue)
{
    U_ADEMOD_SAMPRT unTmp;
        
    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_SAMP_RATE);
    
    unTmp.bits.samprt = enValue;
    
    SIF_HAL_WriteReg(ADEMOD_REG_SAMP_RATE, unTmp.u32);
}

/*(0x80) Automatic System Detect Control Register */
HI_VOID SIF_HAL_SetASDCtl45(SIF_ASDCTL_45M_E enValue)
{
    U_ADEMOD_ASD_CTL unTmp;
    
    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_ASD_CTL);

    unTmp.bits.FrFive = enValue;

    SIF_HAL_WriteReg(ADEMOD_REG_ASD_CTL, unTmp.u32);
}

HI_VOID SIF_HAL_SetASDCtl65(SIF_ASDCTL_65M_E enValue)
{
    U_ADEMOD_ASD_CTL unTmp;
    
    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_ASD_CTL);
    
    unTmp.bits.SxFive = enValue;

    SIF_HAL_WriteReg(ADEMOD_REG_ASD_CTL, unTmp.u32);
}

/*(0x41) Mute Control Register */
HI_BOOL SIF_HAL_IsAAOSMute(HI_VOID)
{
    U_ADEMOD_MUTE_CTL unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_MUTE_CTL);

    return (HI_BOOL)(unTmp.bits.AAOSMut);
}

HI_BOOL SIF_HAL_IsASDMute(HI_VOID)
{
    U_ADEMOD_MUTE_CTL unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_MUTE_CTL);

    return (HI_BOOL)(unTmp.bits.ASDMut);
}

HI_BOOL SIF_HAL_IsLeftMute(HI_VOID)
{
    U_ADEMOD_MUTE_CTL unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_MUTE_CTL);

    return (HI_BOOL)(unTmp.bits.MuteLeftRslt);
}

HI_BOOL SIF_HAL_IsRightMute(HI_VOID)
{
    U_ADEMOD_MUTE_CTL unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_MUTE_CTL);

    return (HI_BOOL)(unTmp.bits.MuteRightRslt);
}

HI_VOID SIF_HAL_SetMuteAuto(HI_BOOL bEn)
{
    U_ADEMOD_MUTE_CTL unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_MUTE_CTL);

    unTmp.bits.MuteOv = bEn;

    SIF_HAL_WriteReg(ADEMOD_REG_MUTE_CTL, unTmp.u32);
}

#if 0
HI_U32 ADEMOD_DEBUG_MUTE(HI_VOID)
{
    return SIF_HAL_ReadReg(ADEMOD_REG_MUTE_CTL);
}
#endif

HI_BOOL SIF_HAL_IsMuteAuto(HI_VOID)
{
    U_ADEMOD_MUTE_CTL unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_MUTE_CTL);

    return (HI_BOOL)(unTmp.bits.MuteOv);
}

HI_VOID SIF_HAL_SetMuteLeft(HI_BOOL bmute)
{
    U_ADEMOD_MUTE_CTL unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_MUTE_CTL);

    unTmp.bits.MuteLACTL = bmute;

    SIF_HAL_WriteReg(ADEMOD_REG_MUTE_CTL, unTmp.u32);
}

HI_VOID SIF_HAL_SetMuteRight(HI_BOOL bmute)
{
    U_ADEMOD_MUTE_CTL unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_MUTE_CTL);

    unTmp.bits.MuteRBCTL = bmute;

    SIF_HAL_WriteReg(ADEMOD_REG_MUTE_CTL, unTmp.u32);
}

/*(0x2E) Stereo Carrier Search Control*/
HI_VOID SIF_HAL_SetAscsDK1Skip(HI_BOOL bSkip)
{
    U_ADEMOD_SCS_CTL unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_ASCS_CTL);

    unTmp.bits.A2DK1skip = bSkip;

    SIF_HAL_WriteReg(ADEMOD_REG_ASCS_CTL, unTmp.u32);
}

HI_VOID SIF_HAL_SetAscsDK2Skip(HI_BOOL bSkip)
{
    U_ADEMOD_SCS_CTL unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_ASCS_CTL);

    unTmp.bits.A2DK2skip = bSkip;

    SIF_HAL_WriteReg(ADEMOD_REG_ASCS_CTL, unTmp.u32);
}

HI_VOID SIF_HAL_SetAscsDK3Skip(HI_BOOL bSkip)
{
    U_ADEMOD_SCS_CTL unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_ASCS_CTL);

    unTmp.bits.A2DK3skip = bSkip;

    SIF_HAL_WriteReg(ADEMOD_REG_ASCS_CTL, unTmp.u32);
}

/*system select change automaticlly after a stereo carrier is detected*/
HI_VOID SIF_HAL_SetAscsChgMod(SIF_ASCS_CHGMODE_E enValue)
{
    U_ADEMOD_SCS_CTL unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_ASCS_CTL);

    unTmp.bits.ChgMod = enValue;

    SIF_HAL_WriteReg(ADEMOD_REG_ASCS_CTL, unTmp.u32);
}

/*Stereo search enable:Disabled/One-time Search Enabled/Continuous Search Enabled*/
HI_VOID SIF_HAL_SetAscsEn(SIF_ASCS_MODE_E enValue)
{
    U_ADEMOD_SCS_CTL unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_ASCS_CTL);

    unTmp.bits.SrchEn = enValue;

    SIF_HAL_WriteReg(ADEMOD_REG_ASCS_CTL, unTmp.u32);
}

/*(0x09) Audio Output Control Register */
HI_VOID SIF_HAL_SetLOR(HI_BOOL bLOutR)
{
    U_ADEMOD_AOUT_CTL unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_AAOS_CTL);

    unTmp.bits.LOR = bLOutR;

    SIF_HAL_WriteReg(ADEMOD_REG_AAOS_CTL, unTmp.u32);
}

HI_VOID SIF_HAL_SetROL(HI_BOOL bROutL)
{
    U_ADEMOD_AOUT_CTL unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_AAOS_CTL);

    unTmp.bits.ROL = bROutL;

    SIF_HAL_WriteReg(ADEMOD_REG_AAOS_CTL, unTmp.u32);
}

HI_VOID SIF_HAL_SetLRSum(HI_BOOL bLRSum)
{
    U_ADEMOD_AOUT_CTL unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_AAOS_CTL);

    unTmp.bits.lrsum = bLRSum;

    SIF_HAL_WriteReg(ADEMOD_REG_AAOS_CTL, unTmp.u32);
}

HI_VOID SIF_HAL_AAOSEn(HI_BOOL bAAOSAutoEn)
{
    U_ADEMOD_AOUT_CTL unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_AAOS_CTL);

    unTmp.bits.aout_en = bAAOSAutoEn;

    SIF_HAL_WriteReg(ADEMOD_REG_AAOS_CTL, unTmp.u32);
}

HI_VOID SIF_HAL_SetAAOSLfSel(SIF_AAOS_OUTMODE_E enAAOSMode)
{
    U_ADEMOD_AOUT_CTL unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_AAOS_CTL);

    unTmp.bits.lfsel = enAAOSMode;

    SIF_HAL_WriteReg(ADEMOD_REG_AAOS_CTL, unTmp.u32);
}

HI_VOID SIF_HAL_SetAAOSRtSel(SIF_AAOS_OUTMODE_E enAAOSMode)
{
    U_ADEMOD_AOUT_CTL unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_AAOS_CTL);

    unTmp.bits.rtsel = enAAOSMode;

    SIF_HAL_WriteReg(ADEMOD_REG_AAOS_CTL, unTmp.u32);
}

HI_BOOL SIF_HAL_GetAAOSEn()
{
    U_ADEMOD_AOUT_CTL unTmp;
    
    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_AAOS_CTL);

    return (HI_BOOL)(unTmp.bits.aout_en);
}

SIF_AAOS_OUTMODE_E SIF_HAL_GetAAOSLfSel()
{
    U_ADEMOD_AOUT_CTL unTmp;
    
    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_AAOS_CTL);

    return (SIF_AAOS_OUTMODE_E)(unTmp.bits.lfsel);
}

SIF_AAOS_OUTMODE_E  SIF_HAL_GetAAOSRtSel()
{
    U_ADEMOD_AOUT_CTL unTmp;
    
    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_AAOS_CTL);

    return (SIF_AAOS_OUTMODE_E)(unTmp.bits.rtsel);
}

/*(0x0A) Audio Mode Detect Register */
SIF_AUDMODE_DET_E SIF_HAL_GetAudModDet(HI_VOID)
{
    U_ADEMOD_AMODE unTmp;
    
    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_MODE_DET);

    return (SIF_AUDMODE_DET_E)(unTmp.bits.audmod);
}

/*(0x2A) Status */
HI_BOOL SIF_HAL_IsASDComplete(HI_VOID)
{
    U_ADEMOD_STAT unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_STATUS);

//    HI_ERR_SIF("the current status is 0x%x\n", unTmp.u32);

    return (HI_BOOL)(unTmp.bits.ASDComplete);
}

/* When high, this bit indicates that either a bilingual or SAP mode has been detected.*/
HI_BOOL SIF_HAL_IsBiSAP(HI_VOID)
{
    U_ADEMOD_STAT unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_STATUS);

    return (HI_BOOL)(unTmp.bits.bili_SAP);
}

/* When high, this bit indicates independent mono sound*/
HI_BOOL SIF_HAL_IsNICAMMono(HI_VOID)
{
    U_ADEMOD_STAT unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_STATUS);

    return (HI_BOOL)(unTmp.bits.imono);
}

/*
 * 1)  SysSel indicates either BTSC or FM Radio and a valid pilot signal is detected. 
 * 2)  SysSel indicates either EIAJ or A2 and the ID signal (AudMod) indicates stereo (0x1.) 
 * 3)  SysSel indicates NICAM, NICAM reception is good, and NICCtl2:1 indicate stereo (0x0.) 
*/
HI_BOOL SIF_HAL_IsStereo(HI_VOID)
{
    U_ADEMOD_STAT unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_STATUS);

    return (HI_BOOL)(unTmp.bits.mono_str);    
}

SIF_ANADIG_STATUS_E SIF_HAL_GetAnaDigStatus(HI_VOID)
{
    U_ADEMOD_STAT unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_STATUS);

    return (SIF_ANADIG_STATUS_E)(unTmp.bits.SndStat);
}

HI_BOOL SIF_HAL_IsPrmCarExist(HI_VOID)
{
    U_ADEMOD_STAT unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_STATUS);
    
    return (HI_BOOL)(unTmp.bits.PrmCarDet);    
}

HI_BOOL SIF_HAL_IsSecCarExist(HI_VOID)
{
    U_ADEMOD_STAT unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_STATUS);
    
    return (HI_BOOL)(unTmp.bits.SecCarDet);
}

/*(0x2F) Stereo Carrier Search Result */
/*Stereo carrier search result.  This is only updated when a new stereo carrier is 
successfully detected.*/
SIF_ASCS_RESULT_E SIF_HAL_GetASCSResult(HI_VOID)
{
    U_ADEMOD_SCS_RSLT unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_ASCS_RESULT);

    return (SIF_ASCS_RESULT_E)(unTmp.bits.SrchRsl);
}

/*Stereo carrier search status.*/
HI_BOOL SIF_HAL_IsASCSSearching(HI_VOID)
{
    U_ADEMOD_SCS_RSLT unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_ASCS_RESULT);

    return (HI_BOOL)(unTmp.bits.SrchSt);
}

/*Stereo carrier search result (SrchRsl) comparison to SysSel. */
HI_BOOL SIF_HAL_IsASCSCompare(HI_VOID)
{
    U_ADEMOD_SCS_RSLT unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_ASCS_RESULT);
    
    return (HI_BOOL)(unTmp.bits.SrchCmp);
}

/*NICAM/A2,状态下，第一载波存在，第二载波没有检测出来，由此状态位确定是否需要开启立体声搜索*/
HI_BOOL SIF_HAL_IsASCSIndicator(HI_VOID)
{
    U_ADEMOD_SCS_RSLT unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_ASCS_RESULT);
    
    return (HI_BOOL)(unTmp.bits.SrchInd);
}

/*(0x40) Audio Output Result Register */
HI_BOOL SIF_HAL_IsAAOSLOR(HI_VOID)
{
    U_ADEMOD_AOUT_RSLT unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_AAOS_RESULT);
    
    return (HI_BOOL)(unTmp.bits.LOR);
}

HI_BOOL SIF_HAL_IsAAOSROL(HI_VOID)
{
    U_ADEMOD_AOUT_RSLT unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_AAOS_RESULT);
    
    return (HI_BOOL)(unTmp.bits.ROL);
}

HI_BOOL SIF_HAL_IsAAOSLRSum(HI_VOID)
{
    U_ADEMOD_AOUT_RSLT unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_AAOS_RESULT);
    
    return (HI_BOOL)(unTmp.bits.LRsum);
}

/******************************************************************************************************
table1:                                                 table2:
LOR  LfRsl   BTSC   EIA-J   A2     NICAM   FM Radio     ROL RtRsl BTSC EIA-J A2   NICAM   FM Radio 
X    0x0     Mono   Mono    Mono   AMono   Mono         X   0x0   Mono Mono  Mono AMono   Mono 
0    0x1     L      L       L       L       L           0   0x1   R     R     R     R      R 
1    0x1     R      R       R       R       R           1   0x1   L     L     L     L      L 
X    0x2     Mono   A       A       A     Mono          X   0x2   Mono  A     A     A     Mono 
X    0x3     SAP*   B       B       B     L-R           X   0x3   SAP*  B     B     B     L-R 
*******************************************************************************************************/
SIF_OUTMODE_E SIF_HAL_GetAAOSLfResult(HI_VOID)
{
    U_ADEMOD_AOUT_RSLT unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_AAOS_RESULT);

    return (SIF_OUTMODE_E)(unTmp.bits.LfRslt);
}

SIF_OUTMODE_E SIF_HAL_GetAAOSRtResult(HI_VOID)
{
    U_ADEMOD_AOUT_RSLT unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_AAOS_RESULT);

    return (SIF_OUTMODE_E)(unTmp.bits.RtRslt);
}

/*(0x1D) Pilot PLL Status Register*/
HI_BOOL SIF_HAL_GetPLLStatus(HI_VOID)
{
    U_ADEMOD_PLT_STATUS unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_PLL_STATUS);
    
    return (HI_BOOL)(unTmp.bits.PLLLok);
}

/*(0x22 – 0x23) NICAM Control Bits Register */
/*0:8 consecutive frames, 1:next eight frames*/
HI_BOOL SIF_HAL_GetFrameFlag(HI_VOID)
{
    U_ADEMOD_NIC_CTL unTmp;

    unTmp.u32 = SIF_HAL_ReadRegU16(ADEMOD_REG_NICAM_CTL_H);

    return (HI_BOOL)(unTmp.bits.c0);
}

SIF_NICAM_CTRL_E SIF_HAL_GetNICAMCtrl(HI_VOID)
{
    U_ADEMOD_NIC_CTL unTmp;

    unTmp.u32 = SIF_HAL_ReadRegU16(ADEMOD_REG_NICAM_CTL_H);
   
    return (SIF_NICAM_CTRL_E)(unTmp.bits.c321);
}

HI_BOOL SIF_HAL_IsNICAMDig(HI_VOID)
{
    U_ADEMOD_NIC_CTL unTmp;

    unTmp.u32 = SIF_HAL_ReadRegU16(ADEMOD_REG_NICAM_CTL_H);

    return (HI_BOOL)(unTmp.bits.c4);
}

HI_VOID SIF_HAL_SetFilter1(SIF_FILTER1_E enFilter)
{
    U_ADEMOD_DMD1_CTL unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_DEMOD1_CTL);
    
    unTmp.bits.dmd1_fl0 = enFilter&0x1;
    unTmp.bits.dmd1_fl1 = (enFilter&0x2)>>1;
    unTmp.bits.dmd1_fl2 = (enFilter&0x4)>>2;
    
    SIF_HAL_WriteReg(ADEMOD_REG_DEMOD1_CTL, unTmp.u32);
}

HI_VOID SIF_HAL_SetDeviation1(SIF_DEVIATION1_E enDeviation)
{
    U_ADEMOD_DMD1_CTL unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_DEMOD1_CTL);
    
    unTmp.bits.dmd1_dv0 = enDeviation&0x1;
    unTmp.bits.dmd1_dv1 = (enDeviation&0x2)>>1;
    unTmp.bits.dmd1_dv2 = (enDeviation&0x4)>>2;
    
    SIF_HAL_WriteReg(ADEMOD_REG_DEMOD1_CTL, unTmp.u32);
}

HI_VOID SIF_HAL_DemulatorMode(SIF_DEMOD1_MODE_E enMode)
{
    U_ADEMOD_DMD1_CTL unTmp;

    unTmp.u32 = SIF_HAL_ReadReg(ADEMOD_REG_DEMOD1_CTL);
    
    unTmp.bits.dmd1_md = enMode;
    
    SIF_HAL_WriteReg(ADEMOD_REG_DEMOD1_CTL, unTmp.u32);
}

HI_VOID SIF_HAL_SetDemodCarriFreq1(HI_U32 enCrriFreq1)
{
    SIF_HAL_WriteRegU16(ADEMOD_REG_DEMOD1_FREQ_H, enCrriFreq1);
}

HI_VOID SIF_HAL_SetDemodCarriFreq2(HI_U32 enCrriFreq2)
{
    SIF_HAL_WriteRegU16(ADEMOD_REG_DEMOD2_FREQ_H, enCrriFreq2);
}

HI_U32 SIF_HAL_GetQualityValue(HI_VOID)
{
    return SIF_HAL_ReadRegU16(ADEMOD_REG_FM_QUAL_1_H);
}

HI_U32 SIF_HAL_GetCarrierShiftValue(HI_VOID)
{
    return SIF_HAL_ReadRegU16(ADEMOD_REG_AVERAGE_FREQ_1_H);
}

HI_U32 SIF_HAL_GetPhaseValue(HI_VOID)
{
    return SIF_HAL_ReadRegU16(ADEMOD_REG_PHASE_NOISE_1_H);
}

HI_U32 SIF_HAL_GetQuality1(HI_VOID)
{
   return SIF_HAL_ReadRegU16(ADEMOD_REG_FM_QUAL_1_H);
}
HI_U32 SIF_HAL_GetQuality2(HI_VOID)
{
    return SIF_HAL_ReadRegU16(ADEMOD_REG_FM_QUAL_2_H);
}

HI_U32 SIF_HAL_GetCarri1Freq(HI_VOID)
{
   return SIF_HAL_ReadRegU16(ADEMOD_REG_DEMOD1_FREQ_H);
}

HI_U32 SIF_HAL_GetCarri12Freq(HI_VOID)
{
    return SIF_HAL_ReadRegU16(ADEMOD_REG_DEMOD2_FREQ_H);
}

HI_VOID SIF_HAL_SetFreqErr(HI_U32 u32Value)
{
    SIF_HAL_WriteReg(ADEMOD_REG_CARRIER_AVERAGE_FREQ_THD, u32Value);
}

HI_U32 SIF_HAL_GetFreqErr(HI_U32 u32Value)
{
    return SIF_HAL_ReadRegU16(ADEMOD_REG_CARRIER_AVERAGE_FREQ_THD);
}

