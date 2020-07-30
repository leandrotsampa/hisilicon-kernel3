/******************************************************************************

  Copyright (C), 2012-2014, Hisilicon Tech. Co., Ltd.

 ******************************************************************************
  File Name     : drv_ademod.h
  Version       : Initial Draft
  Author        : Hisilicon multimedia software group
  Created       : 2012/11/06
  Description   : 
  History       :
  1.Date        : 2012/11/06
    Author      : m00196336/l00191026
    Modification: Created file
******************************************************************************/
#include <linux/init.h>
#include <linux/module.h>
#include <linux/ioctl.h>
#include <asm/uaccess.h>
#include <linux/fs.h>
#include <linux/err.h>
#include <linux/slab.h>
#include <linux/delay.h>
#include <asm/io.h>

#include "drv_sif_ioctl.h"
#include "drv_sif.h"
#include "hi_module.h"
#include "hi_drv_struct.h"
#include "hi_drv_dev.h"
#include "hi_drv_module.h"
#include "hi_drv_proc.h"
#include "hi_osal.h"
#include "hal_sif.h"
#include "hi_kernel_adapt.h"
#include "hi_reg_common.h"

static SIF_DRV_CTX_S g_stSifDrvDev;

static HI_S32 g_SifSuspendFlag = 0;
static HI_S32 g_SifResumeFlag = 0;

DEFINE_SEMAPHORE(g_SIFMutex);
static atomic_t g_SIFOpenCnt = ATOMIC_INIT(0);

#if 0

/******************************************************************************************************
*********************************************set default parameter*************************************
*******************************************************************************************************/
static HI_S32 SIF_HAL_DefaultFactoryCTX(SIF_DRV_CTX_S *pstCTX)
{
    SIF_CHECK_NULL_PTR(pstCTX);

    pstCTX->stDevAttr.enSmpRate     = SIF_SAM_RATE_48K;
    pstCTX->stDevAttr.bAAOSEn       = HI_TRUE;
    pstCTX->stDevAttr.L_output      = SIF_AAOS_OUTMODE_L_OR_R;
    pstCTX->stDevAttr.R_output      = SIF_AAOS_OUTMODE_L_OR_R;
    pstCTX->stDevAttr.enASCSChgMode = SIF_ASCS_CHGMODE_AUTO;
    pstCTX->stDevAttr.enASCSCtl     = SIF_ASCS_MODE_ALWAYS;
    pstCTX->stDevAttr.enASD45CTL    = SIF_ASDCTL_45M_PAL_SUM;
    pstCTX->stDevAttr.enASD65CTL    = SIF_ASDCTL_65M_DK;
    
    pstCTX->stDevAttr.enFlt1        = SIF_DEMOD1_FILTER_384K;
    pstCTX->stDevAttr.enDeviation1  = SIF_DEVIATION_384K;
    pstCTX->stDevAttr.enDemulaMode  = SIF_DEMOD1_MODE_FM;

    pstCTX->stDevAttr.enCrriFreq1   = SIF_DEMOD1_65M_18432M;
    pstCTX->stDevAttr.enCrriFreq2   = SIF_DEMOD2_62578125M_18432M;
    
    pstCTX->stDevAttr.bASDEn        = HI_TRUE;
    pstCTX->stDevAttr.enSysSel      = SIF_SYS_SEL_DK3;
    pstCTX->stDevAttr.bBTSCSap      = HI_FALSE;
    
    pstCTX->stDevAttr.bMuteEn       = HI_TRUE; 
    pstCTX->stDevAttr.bMuteL        = HI_FALSE;
    pstCTX->stDevAttr.bMuteL        = HI_FALSE;

    pstCTX->enCurnStatus            = SIF_CHANNEL_STATUS_STOP;

    return HI_SUCCESS;
}
#endif
/**************************************************************************
addr value  
0x02 0x00    set sample rate
0x09 0x05    set AAOS control and AAOS mode
0x80 0x08    set demulator mode:4.5MHz or 6.5MHz
0x00 0x00    set attributes relate to ASD:ASD atuo or system select 
0x41 0x04    set mute ctl:mute override,left muted or right muted setting
***************************************************************************/

#if 0
static HI_S32 SIF_HAL_SetDefaultCfg(const SIF_DRV_CTX_S *pstCTX)
{
    SIF_CHECK_NULL_PTR(pstCTX);

    /*set sample rate*/
    SIF_HAL_SetSampleRate(pstCTX->stDevAttr.enSmpRate);    

    /*set aaos attribute*/
    SIF_HAL_AAOSEn(pstCTX->stDevAttr.bAAOSEn);             
    SIF_HAL_SetAAOSLfSel(pstCTX->stDevAttr.L_output);
    SIF_HAL_SetAAOSRtSel(pstCTX->stDevAttr.R_output);

    /*set ASD Control*/
    SIF_HAL_SetASDCtl45(pstCTX->stDevAttr.enASD45CTL);
    SIF_HAL_SetASDCtl65(pstCTX->stDevAttr.enASD65CTL);

    /*set ASCS attribute*/
    SIF_HAL_SetAscsChgMod(pstCTX->stDevAttr.enASCSChgMode);
    SIF_HAL_SetAscsDK2Skip(HI_FALSE);
    SIF_HAL_SetAscsEn(pstCTX->stDevAttr.enASCSCtl); 

    /*set over modulation*/
    SIF_HAL_DemulatorMode(pstCTX->stDevAttr.enDemulaMode);
    SIF_HAL_SetDeviation1(pstCTX->stDevAttr.enDeviation1);
    SIF_HAL_SetFilter1(pstCTX->stDevAttr.enFlt1);

    /*set carrier shift*/
    SIF_HAL_SetDemodCarriFreq1(pstCTX->stDevAttr.enCrriFreq1);
    SIF_HAL_SetDemodCarriFreq2(pstCTX->stDevAttr.enCrriFreq2);

    /*set ASD enable*/
    #if 0
    SIF_HAL_ASDEn(pstCTX->stDevAttr.bASDEn);
    if (HI_FALSE== pstCTX->stDevAttr.bASDEn)
    {
        /*set system select mannually*/
        SIF_HAL_SetSysSel(pstCTX->stDevAttr.enSysSel);
    }
    #endif

    /*set mute attribute*/
    SIF_HAL_SetMuteLeft(pstCTX->stDevAttr.bMuteL);
    SIF_HAL_SetMuteRight(pstCTX->stDevAttr.bMuteR);
    SIF_HAL_SetMuteAuto(pstCTX->stDevAttr.bMuteEn);

    return HI_SUCCESS;
}
#endif
static HI_S32 SIF_GetCarriShiftValue(HI_U32 *pu32ShiftValue);
static HI_U32 SIF_GetQuality1(HI_VOID);
static HI_U32 SIF_GetQuality2(HI_VOID);
static HI_S32 SIF_Suspend(HI_VOID);
static HI_S32 SIF_Resume(HI_VOID);
static HI_S32 SIF_GetOutMode(HI_UNF_SIF_AAOS_MODE_E *penAAOSMode);

static HI_U8 *EnSysSelToStr(HI_VOID)
{
    SIF_SYS_SEL_E enSysSel = 0;

    enSysSel = SIF_HAL_GetDetStandard();
    
    switch (enSysSel)
    {
        case SIF_SYS_SEL_BG_FM:
            return "BG_FM";
        case SIF_SYS_SEL_BG_NICAM:
            return "BG_Nicam"; 
        case SIF_SYS_SEL_L:
            return "Secam_L"; 
        case SIF_SYS_SEL_I:
            return "Sys_I"; 
        case SIF_SYS_SEL_DK1:
            return "Dk1";      	 
        case SIF_SYS_SEL_DK2:
            return "Dk2";     	 
        case SIF_SYS_SEL_DK3:
            return "Dk3";     	 
        case SIF_SYS_SEL_DK_NICAM:
            return "Nicam_DK";	  
        case SIF_SYS_SEL_KOREA:
            return "Korea";   	  
        case SIF_SYS_SEL_EIAJ:
            return "Eiaj";        
        case SIF_SYS_SEL_BTSC:
            return "Btsc";
        default:
            return "SysSel_NO";
    }
}

static HI_U8 *EnASDCTL45ToStr(SIF_HAL_ATTR_S *pstDevAttr)
{
    switch (pstDevAttr->enASD45CTL)
    {
        case SIF_ASDCTL_45M_BTSC:
            return "Btsc";
        case SIF_ASDCTL_45M_EIAJ:
            return "Eiaj";
        case SIF_ASDCTL_45M_M_KOREA:
            return "Korea";
        case SIF_ASDCTL_45M_PAL_SUM:
            return "Pal_Sum";
        default:
            return "Radio";
    }
}

static HI_U8 *EnASDCTL65ToStr(SIF_HAL_ATTR_S *pstDevAttr)
{
    switch (pstDevAttr->enASD65CTL)
    {
        case SIF_ASDCTL_65M_SECAM_L:
            return "Secam_L";
        case SIF_ASDCTL_65M_DK:
            return "DK";
        default:
            return "NONE";
    }
}

static HI_U8 *EnFilter1ToStr(SIF_HAL_ATTR_S *pstDevAttr)
{
    switch (pstDevAttr->enFlt1)
    {
        case SIF_DEMOD1_FILTER_50K:
            return "50K";
        case SIF_DEMOD1_FILTER_100K:
            return "100K";
        case SIF_DEMOD1_FILTER_384K:
            return "384K";
        case SIF_DEMOD1_FILTER_540K:
            return "540K";
        case SIF_DEMOD1_FILTER_200K:
            return "200K";
        case SIF_DEMOD1_FILTER_BUTT:
        default:
            return "";
    }
}

static HI_U8 *EnCarriStatus1ToStr(HI_UNF_SIF_AAOS_MODE_E enAAOSMode)
{
    switch (enAAOSMode)
    {
        case HI_UNF_SIF_AAOS_MODE_MONO:
            return "Mono";
        case HI_UNF_SIF_AAOS_MODE_STEREO:
            return "Stereo";
        case HI_UNF_SIF_AAOS_MODE_DUAL:
            return "Dual";
        case HI_UNF_SIF_AAOS_MODE_MONO_SAP:
            return "MonoSap";
        case HI_UNF_SIF_AAOS_MODE_STEREO_SAP:
            return "StereoSap";        
        case HI_UNF_SIF_AAOS_MODE_NICAM_MONO:
            return "NicamMono";
        case HI_UNF_SIF_AAOS_MODE_NICAM_STEREO:
            return "NicamStereo";
        case HI_UNF_SIF_AAOS_MODE_NICAM_DUAL:
            return "NicamDual";
        case HI_UNF_SIF_AAOS_MODE_NICAM_FM_MOMO:
            return "NicamFMMono";
        case HI_UNF_SIF_AAOS_MODE_BUTT:
        default:
            return "";
    }
}

static HI_U8 *EnDeviation1ToStr(SIF_HAL_ATTR_S *pstDevAttr)
{
    switch (pstDevAttr->enDeviation1)
    {
        case SIF_DEVIATION_50K:
            return "50K";
        case SIF_DEVIATION_100K:
            return "100K";
        case SIF_DEVIATION_384K:
            return "384K";
        case SIF_DEVIATION_540K:
            return "540K";
        case SIF_DEVIATION_200K:
            return "200K";
        case SIF_DEVIATION_BUTT:
        default:
            return "";
    }
}

static HI_U8 *EnDemModeToStr(SIF_HAL_ATTR_S *pstDevAttr)
{
    switch (pstDevAttr->enDemulaMode)
    {
        case SIF_DEMOD1_MODE_FM:
            return "Fm";
        case SIF_DEMOD1_MODE_AM:
            return "Am";
        case SIF_DEMOD1_MODE_BUTT:
        default:
            return "";
    }
}

static HI_U8 *EnOutToStr(SIF_AAOS_OUTMODE_E en_output)
{
    switch (en_output)
    {  
        case SIF_AAOS_OUTMODE_MONO:
            return "Mono";
        case SIF_AAOS_OUTMODE_L_OR_R:
            return "LR";
        case SIF_AAOS_OUTMODE_A:
            return "A";
        case SIF_AAOS_OUTMODE_B:
            return "B";
        case SIF_AAOS_OUTMODE_BUTT:
        default:
            return "";
    }
}

static HI_U8 *EnAscsModeToStr(SIF_HAL_ATTR_S *pstDevAttr)
{
    switch (pstDevAttr->enASCSChgMode)
    {
        case SIF_ASCS_CHGMODE_NOT_ATUO:
            return "NO_Auto";
        case SIF_ASCS_CHGMODE_AFTER_RST:
            return "Aft_Rst";
        case SIF_ASCS_CHGMODE_AUTO:
            return "Auto";
        case SIF_ASCS_CHGMODE_AUTO1:
            return "Auto1";
        case SIF_ASCS_CHGMODE_BUTT:
        default:
            return "";
    }
}

static HI_U8 *EnAscsCtlToStr(SIF_HAL_ATTR_S *pstDevAttr)
{
    switch (pstDevAttr->enASCSCtl)
    {
        case SIF_ASCS_MODE_DISABLE:
            return "Disable";
        case SIF_ASCS_MODE_ONETIME:
            return "OneTime";
        case SIF_ASCS_MODE_ALWAYS:
            return "Always";
        case SIF_ASCS_MODE_ALWAYS1:
            return "Always1";
        case SIF_ASCS_MODE_BUTT:
        default:
            return "";
    }
}

static HI_U8 *EnCarri1ToStr(SIF_HAL_ATTR_S *pstDevAttr)
{  
    HI_U32 u32CarriFreq = SIF_HAL_GetCarri1Freq();

    switch (u32CarriFreq)
    {
        case SIF_DEMOD1_45M_18432M:
            return "4.5M";
        case SIF_DEMOD1_55M_18432M:
            return "5.5M";
        case SIF_DEMOD1_60M_18432M:
            return "6.0M";
        case SIF_DEMOD1_65M_18432M:
            return "6.5M";
        default:
            return "No_Freq";
    }
}

static HI_U8 *EnCarri2ToStr(SIF_HAL_ATTR_S *pstDevAttr)
{  
    HI_U32 u32CarriFreq = SIF_HAL_GetCarri12Freq();
    
    switch (u32CarriFreq)
    {
        case SIF_DEMOD2_4_724212M_18432M:
            return "4.724M";
        case SIF_DEMOD2_57421875M_18432M:
            return "5.742M";
        case SIF_DEMOD2_585M_18432M:
            return "5.85M";
        case SIF_DEMOD2_62578125M_18432M:
            return "6.26M";
        case SIF_DEMOD2_6552M_18432M:
            return "6.55M";
        case SIF_DEMOD2_6741875M_18432M:
            return "6.74M";
        default:
            return "No_Freq";
    }
}

static HI_U8 *EnQualityToStr(HI_U32 u32Quality)
{  
    if (u32Quality < 0x0001)
    {
        return "<-36dB";
    }
    else if ((u32Quality >= 0x0001) && (u32Quality < 0x0004))
    {
        return "-36~-24dB";
    }
    else if ((u32Quality >= 0x0004) && (u32Quality < 0x0010))
    {
        return "-24~-12dB";
    }
    else if ((u32Quality >= 0x0010) && (u32Quality < 0x0040))
    {
        return "-12~0dB";
    }
    else if ((u32Quality >= 0x0040) && (u32Quality < 0x0100))
    {
        return "0~12dB";
    }
    else if ((u32Quality >= 0x0100) && (u32Quality < 0x0400))
    {
        return "12~24dB";
    }
    else if ((u32Quality >= 0x0400) && (u32Quality < 0x1000))
    {
        return "24~36dB";
    }
    else if ((u32Quality >= 0x1000) && (u32Quality < 0x4000))
    {
        return "36~48dB";
    }
    else if ((u32Quality >= 0x4000) && (u32Quality < 0xFFFF))
    {
        return "48~60dB";
    }
    else
    {
        return ">60dB";
    }        
}

static HI_BOOL bFlag = 0;

static HI_S32 SIF_ProcShow(struct seq_file *s)
{
    SIF_HAL_ATTR_S  *pstDevAttr  = NULL;
    HI_S32 u32ShfitValue         = 0;
    HI_U32 u32Deviation          = 0;
    HI_U32 u32Flag               = 0;
    HI_UNF_SIF_AAOS_MODE_E       enAAOSMode = HI_UNF_SIF_AAOS_MODE_MONO;

    if (bFlag == HI_FALSE)
    {
        return HI_FAILURE;
    }
    
    pstDevAttr = &g_stSifDrvDev.stDevAttr;

    
    PROC_PRINT(s, "\n------------------------SIF INFO BEGIN----------------------------\n");
    PROC_PRINT(s, "SYSTEM      :SysSel(%s), AsdCtl45(%s), AsdCtl65(%s)\n", EnSysSelToStr(),EnASDCTL45ToStr(pstDevAttr), EnASDCTL65ToStr(pstDevAttr));
    PROC_PRINT(s, "DEVIATION   :Filter1(%s), Deviation(%s), Fm_Mode(%s)\n", EnFilter1ToStr(pstDevAttr),EnDeviation1ToStr(pstDevAttr), EnDemModeToStr(pstDevAttr));

    SIF_GetOutMode(&enAAOSMode);
    PROC_PRINT(s, "STATUS      :Carrier(%s)\n", EnCarriStatus1ToStr(enAAOSMode));
    PROC_PRINT(s, "AAOS        :AaosEn(%d), L_out(%s), R_out(%s)\n", pstDevAttr->bAAOSEn,EnOutToStr(pstDevAttr->L_output), EnOutToStr(pstDevAttr->R_output));
    PROC_PRINT(s, "ASCS        :AscsMode(%s), AscsCtl(%s)\n", EnAscsModeToStr(pstDevAttr),EnAscsCtlToStr(pstDevAttr));
    PROC_PRINT(s, "MUTECTL     :MuteEn(%d), MuteL(%d), MuteR(%d)\n", pstDevAttr->bMuteEn, pstDevAttr->bMuteL, pstDevAttr->bMuteR);
    PROC_PRINT(s, "Carrier     :Carrier1(%s), Carrier2(%s)\n", EnCarri1ToStr(pstDevAttr), EnCarri2ToStr(pstDevAttr));

    /*quality*/
    SIF_GetCarriShiftValue(&u32ShfitValue);
    u32Deviation = SIF_HAL_GetPhaseValue();

    if ((u32ShfitValue) & 0x8000)
    {
        u32Flag       = 1;
        u32ShfitValue = 0xffff - u32ShfitValue;
    }

    u32ShfitValue	= u32ShfitValue * 18432 /1048576;
    u32Deviation = u32Deviation * 18432 / 1048576 ;

    PROC_PRINT(s, "FEIBIAO     :Shift1(%c%dkHz), Deviation(%dkHz)\n", (u32Flag == 1)? '-':'+', u32ShfitValue, u32Deviation);
    PROC_PRINT(s, "QUALITY     :Qual1(%s), Qual2(%s), QualComp1(0x%xh), QualComp2(0x%xh) \n", 
               EnQualityToStr(SIF_GetQuality1()), EnQualityToStr(SIF_GetQuality2()), 
               ((SIF_GetQuality1()) & (0xfff8)) >> 3, ((SIF_GetQuality2()) & (0xfff8)) >> 3);
    PROC_PRINT(s, "\n------------------------SIF INFO END------------------------------\n");

    return HI_SUCCESS;
}

HI_S32 SIF_DRV_ReadProc(struct seq_file *s, HI_VOID *pData)
{
    SIF_ProcShow(s);
    
    return HI_SUCCESS;
}

static HI_S32 SIF_OpenDev(HI_VOID)
{
    SIF_HAL_Init();
    SIF_CRG_HAL_Init();
    
    return HI_SUCCESS;
}

static HI_S32 SIF_CloseDev(HI_VOID)
{    
    SIF_HAL_DeInit();
    SIF_CRG_HAL_DeInit();
    
    return HI_SUCCESS;
}

HI_S32 SIF_DRV_Open(struct inode * inode, struct file * file)
{
    HI_S32 Ret;
    
    Ret = down_interruptible(&g_SIFMutex);
   
    if (atomic_inc_return(&g_SIFOpenCnt) == 1)
    {
        if (HI_SUCCESS != SIF_OpenDev())
        {
            HI_FATAL_SIF("SIF_OpenDev err!\n" );
            up(&g_SIFMutex);
            return HI_FAILURE;
        }
    }

    bFlag = HI_FALSE;
    
    up(&g_SIFMutex);
    return HI_SUCCESS;
}

HI_S32 SIF_DRV_Close(struct inode * inode, struct file * file)
{
    HI_S32 Ret;
    
    Ret = down_interruptible(&g_SIFMutex);
   
    
    if (atomic_dec_and_test(&g_SIFOpenCnt))
    {
        if (HI_SUCCESS != SIF_CloseDev())
        {
            HI_FATAL_SIF("SIF_CloseDev err!\n" );
        }
    }
    
    up(&g_SIFMutex);
    
    return HI_SUCCESS;
}

HI_S32 SIF_DRV_Suspend(PM_BASEDEV_S *pdev, pm_message_t state)
{
    HI_S32 s32Ret;
    HI_FATAL_SIF("entering\n");

    s32Ret = down_interruptible(&g_SIFMutex);
    if(0 != atomic_read(&g_SIFOpenCnt))
    {        
        s32Ret = SIF_Suspend();
        if(HI_SUCCESS != s32Ret)
        {
            HI_FATAL_SIF("SIF Suspend fail\n");
            up(&g_SIFMutex);
            return HI_FAILURE;
        }
    }
    
    HI_FATAL_SIF("ok\n");

    up(&g_SIFMutex);
    return HI_SUCCESS;
}

HI_S32 SIF_DRV_Resume(PM_BASEDEV_S *pdev)
{
    HI_S32 s32Ret;
    
    HI_FATAL_SIF("entering\n");

    s32Ret = down_interruptible(&g_SIFMutex);
    
    if(0 != atomic_read(&g_SIFOpenCnt))
    {
        s32Ret = SIF_Resume();
        if(HI_SUCCESS != s32Ret)
        {
            HI_FATAL_SIF("SIF Resume fail\n");
            up(&g_SIFMutex);
            return HI_FAILURE;
        }
    }
    
    up(&g_SIFMutex);
    HI_FATAL_SIF("ok\n");
    return HI_SUCCESS;
}

static HI_S32 SIF_SetASDCtl(HI_UNF_SIF_SYSCTL_E enSysCtl)
{        
    if (enSysCtl >= HI_UNF_SIF_SYSCTL_BUTT)
    {
        SIF_TRACE(HI_SIF_ERR, "Invalid ASD Control Param Error: %d of ADEMOD \n", enSysCtl);
        return HI_FAILURE;
    }
            
    switch (enSysCtl)
    {
        case HI_UNF_SIF_SYSCTL_BTSC:
        {
            g_stSifDrvDev.stDevAttr.enASD45CTL = SIF_ASDCTL_45M_BTSC;
            g_stSifDrvDev.stDevAttr.enASD65CTL = SIF_ASDCTL_65M_DK;
            
            break;
        }            
        case HI_UNF_SIF_SYSCTL_EIAJ:
        {
            g_stSifDrvDev.stDevAttr.enASD45CTL = SIF_ASDCTL_45M_EIAJ;
            g_stSifDrvDev.stDevAttr.enASD65CTL = SIF_ASDCTL_65M_DK;
            
            break;
        }
        case HI_UNF_SIF_SYSCTL_M_KOREA:
        {
            g_stSifDrvDev.stDevAttr.enASD45CTL = SIF_ASDCTL_45M_M_KOREA;
            g_stSifDrvDev.stDevAttr.enASD65CTL = SIF_ASDCTL_65M_DK;
            
            break;
        }
        case HI_UNF_SIF_SYSCTL_PAL_SUM:
        {
            g_stSifDrvDev.stDevAttr.enASD45CTL = SIF_ASDCTL_45M_PAL_SUM;
            g_stSifDrvDev.stDevAttr.enASD65CTL = SIF_ASDCTL_65M_DK;
            
            break;
        }
        case HI_UNF_SIF_SYSCTL_SECAM_L:
        {
            g_stSifDrvDev.stDevAttr.enASD45CTL = SIF_ASDCTL_45M_PAL_SUM;
            g_stSifDrvDev.stDevAttr.enASD65CTL = SIF_ASDCTL_65M_SECAM_L;
            
            break;
        }
        case HI_UNF_SIF_SYSCTL_FM_US:
        {   
            g_stSifDrvDev.stDevAttr.enASD45CTL = SIF_ASDCTL_45M_FM_US;
            g_stSifDrvDev.stDevAttr.enASD65CTL = SIF_ASDCTL_65M_DK;
            
            break;
        }
        case HI_UNF_SIF_SYSCTL_FM_EUROPE:
        {         
            g_stSifDrvDev.stDevAttr.enASD45CTL = SIF_ASDCTL_45M_FM_EURO;
            g_stSifDrvDev.stDevAttr.enASD65CTL = SIF_ASDCTL_65M_DK;
            
            break;
        }                
        default:
        {
            SIF_TRACE(HI_SIF_ERR, "invalid args asd ctrl:%d\n", enSysCtl);   
            g_stSifDrvDev.stDevAttr.enASD45CTL = SIF_ASDCTL_45M_PAL_SUM;
            g_stSifDrvDev.stDevAttr.enASD65CTL = SIF_ASDCTL_65M_DK;
            
            break;
        }        
    }

    SIF_HAL_SetASDCtl45(g_stSifDrvDev.stDevAttr.enASD45CTL);
    SIF_HAL_SetASDCtl65(g_stSifDrvDev.stDevAttr.enASD65CTL);
    
    return HI_SUCCESS;
}

static HI_S32 SIF_SetSysSel(HI_UNF_SIF_STANDARD_TYPE_E enSysSel);

#ifdef SIF_OTP_CHECK_SUPPORT
static  HI_S32 SIF_CheckChipOTP(HI_VOID)
{
    HI_S32 Ret = HI_FAILURE;
    HI_U32  u32OtpMask = 0;    
    HI_U32  u32OtpVal = 0;


    u32OtpVal  = 1; //*(HI_U32 *)(AFLT_OTP_BASEADDR + AFLT_OTP_OFFSETADDR);
    u32OtpMask = 0x1;

    if (!(u32OtpVal & u32OtpMask)) //support when otp_value=0 for ddp
    {
        Ret = HI_SUCCESS;
    }

    return Ret;
}
#endif

static HI_S32 SifSetASDEn(HI_VOID)
{
    g_stSifDrvDev.stDevAttr.bASDEn = HI_TRUE;
    SIF_HAL_ASDEn(g_stSifDrvDev.stDevAttr.bASDEn);

    return HI_SUCCESS;
}

static HI_S32 SIF_StartAsdDetect(HI_UNF_SIF_SYSCTL_E enSysCtl)
{
    HI_S32 s32Ret;

    if (bFlag == HI_FALSE)
    {
        HI_ERR_SIF("current state is not open,can not start ASD Detect!\n");
        return HI_FAILURE;
    }
    
    if(SIF_CHANNEL_STATUS_START!= g_stSifDrvDev.enCurnStatus)
    {
        HI_ERR_SIF("current state is stop,can not set out mode!\n");
        return HI_FAILURE;
    }
       
    if (enSysCtl > HI_UNF_SIF_SYSCTL_BUTT)
    {
        return HI_FAILURE;
    }

#ifdef SIF_OTP_CHECK_SUPPORT
    if (HI_UNF_SIF_SYSCTL_BTSC == enSysCtl)
    {
        if (SIF_CheckChipOTP() != HI_SUCCESS)
        {
            HI_ERR_SIF("The Chip is not Support!\n");
            return HI_FAILURE;
        }
    }
#endif
    
    s32Ret = SIF_SetASDCtl(enSysCtl);    
    if (s32Ret != HI_SUCCESS)
    {        
        SIF_TRACE(HI_SIF_ERR, "Invalid Param Error: [%s] of SIF, [%d] of SIF\n", __FUNCTION__, __LINE__);
        return HI_FAILURE;        
    }

#if 0
    if (enSysCtl == HI_UNF_SIF_SYSCTL_BTSC)
    {
        SIF_SetSysSel(HI_UNF_SIF_STANDARD_M_BTSC);
    }
    else if (enSysCtl == HI_UNF_SIF_SYSCTL_M_KOREA)
    {
        SIF_SetSysSel(HI_UNF_SIF_STANDARD_M_A2);
    }       
    else if (enSysCtl == HI_UNF_SIF_SYSCTL_EIAJ)
    {
        SIF_SetSysSel(HI_UNF_SIF_STANDARD_M_EIA_J);
    }
    else
    {
        s32Ret = SifSetASDEn();    
        if (s32Ret != HI_SUCCESS)
        {        
            SIF_TRACE(HI_SIF_ERR, "Invalid Param Error: [%s] of SIF, [%d] of SIF\n", __FUNCTION__, __LINE__);
            return HI_FAILURE;
        }
    }
#else
    s32Ret = SifSetASDEn();    
    if (s32Ret != HI_SUCCESS)
    {        
        SIF_TRACE(HI_SIF_ERR, "Invalid Param Error: [%s] of SIF, [%d] of SIF\n", __FUNCTION__, __LINE__);
        return HI_FAILURE;
    }
#endif

    return HI_SUCCESS;
}

static HI_S32 SIF_GetSysSel(HI_UNF_SIF_STANDARD_TYPE_E *penSysSel)
{
    SIF_SYS_SEL_E enSysSel;
    SIF_CHECK_NULL_PTR(penSysSel);

    if (bFlag == HI_FALSE)
    {
        HI_ERR_SIF("current state is not open,can not start ASD Detect!\n");
        return HI_FAILURE;
    }

    if(SIF_CHANNEL_STATUS_START!= g_stSifDrvDev.enCurnStatus)
    {
        HI_ERR_SIF("current state is not stop,can not set attr!\n");
        return HI_FAILURE;
    }

    enSysSel = SIF_HAL_GetDetStandard();
    
    switch (enSysSel)
    {
        case SIF_SYS_SEL_BG_FM:
            *penSysSel = HI_UNF_SIF_STANDARD_BG_A2;
            break;
        case SIF_SYS_SEL_BG_NICAM:
            *penSysSel = HI_UNF_SIF_STANDARD_BG_NICAM;
            break;  
        case SIF_SYS_SEL_I:
            *penSysSel = HI_UNF_SIF_STANDARD_I;
            break;           
        case SIF_SYS_SEL_DK1:
            *penSysSel = HI_UNF_SIF_STANDARD_DK1_A2;
            break;
        case SIF_SYS_SEL_DK2:
            *penSysSel = HI_UNF_SIF_STANDARD_DK2_A2;
            break;  
        case SIF_SYS_SEL_DK3:
            *penSysSel = HI_UNF_SIF_STANDARD_DK3_A2;
            break;        
        case SIF_SYS_SEL_DK_NICAM:
            *penSysSel = HI_UNF_SIF_STANDARD_DK_NICAM;
            break;            
        case SIF_SYS_SEL_L:
            *penSysSel = HI_UNF_SIF_STANDARD_L;
            break;         
        case SIF_SYS_SEL_BTSC:
            *penSysSel = HI_UNF_SIF_STANDARD_M_BTSC;
            break;        
        case SIF_SYS_SEL_KOREA:
            *penSysSel = HI_UNF_SIF_STANDARD_M_A2;
            break;            
        case SIF_SYS_SEL_EIAJ:
            *penSysSel = HI_UNF_SIF_STANDARD_M_EIA_J;
            break;         
        case SIF_SYS_SEL_FM_RADIO_EUROPE:
        case SIF_SYS_SEL_FM_RADIO_US:        
        case SIF_SYS_SEL_FM_RADIO_EUROPE1:
        case SIF_SYS_SEL_FM_RADIO_EUROPE2:
        case SIF_SYS_SEL_FM_RADIO_EUROPE3:
            *penSysSel = HI_UNF_SIF_STANDARD_NOTSTANDARD;
            break; 
         default:
             *penSysSel = HI_UNF_SIF_STANDARD_NOTSTANDARD;
            break;
    }

#ifdef SIF_OTP_CHECK_SUPPORT
    if (SIF_SYS_SEL_BTSC == enSysSel)
    {
        if (SIF_CheckChipOTP() != HI_SUCCESS)
        {
            HI_ERR_SIF("The Chip is not Support!\n");
            *penSysSel = HI_UNF_SIF_STANDARD_NOTSTANDARD;
        }
    }
#endif
    
    g_stSifDrvDev.stDevAttr.enSysSel = enSysSel;    
    g_stSifDrvDev.enSifStand = *penSysSel;

    return HI_SUCCESS;
}

static HI_S32 SIF_SetSysSel(HI_UNF_SIF_STANDARD_TYPE_E enSysSel)
{
    if (bFlag == HI_FALSE)
    {
        HI_ERR_SIF("current state is not open,can not start ASD Detect!\n");
        return HI_FAILURE;
    }
        
    if (enSysSel >= HI_UNF_SIF_STANDARD_NOTSTANDARD)
    {
        SIF_TRACE(HI_SIF_ERR, "Invalid System Select Param Error: %d of ADEMOD \n", enSysSel);
        return HI_FAILURE;
    }

    if(SIF_CHANNEL_STATUS_START!= g_stSifDrvDev.enCurnStatus)
    {
        HI_ERR_SIF("current state is not stop,can not set attr!\n");
        return HI_FAILURE;
    }

    g_stSifDrvDev.enSifStand = enSysSel;
    
    switch (enSysSel)
    {
        case HI_UNF_SIF_STANDARD_BG:            
        case HI_UNF_SIF_STANDARD_BG_A2:
            g_stSifDrvDev.stDevAttr.enSysSel = SIF_SYS_SEL_BG_FM;
            break;        
        case HI_UNF_SIF_STANDARD_BG_NICAM:
            g_stSifDrvDev.stDevAttr.enSysSel = SIF_SYS_SEL_BG_NICAM;
            break;
        case HI_UNF_SIF_STANDARD_I:
            g_stSifDrvDev.stDevAttr.enSysSel = SIF_SYS_SEL_I;
            break;
        case HI_UNF_SIF_STANDARD_DK:
        case HI_UNF_SIF_STANDARD_DK3_A2:
            g_stSifDrvDev.stDevAttr.enSysSel = SIF_SYS_SEL_DK3;
            break;        
        case HI_UNF_SIF_STANDARD_DK1_A2:
            g_stSifDrvDev.stDevAttr.enSysSel = SIF_SYS_SEL_DK1;
            break;        
        case HI_UNF_SIF_STANDARD_DK2_A2:
            g_stSifDrvDev.stDevAttr.enSysSel = SIF_SYS_SEL_DK2;
            break;        
        case HI_UNF_SIF_STANDARD_DK_NICAM:
            g_stSifDrvDev.stDevAttr.enSysSel = SIF_SYS_SEL_DK_NICAM;
            break;        
        case HI_UNF_SIF_STANDARD_M:
        case HI_UNF_SIF_STANDARD_M_A2:
            g_stSifDrvDev.stDevAttr.enSysSel = SIF_SYS_SEL_KOREA;
            break; 
        case HI_UNF_SIF_STANDARD_M_BTSC:
#ifdef SIF_OTP_CHECK_SUPPORT
            if (SIF_CheckChipOTP() != HI_SUCCESS)
            {
                HI_ERR_SIF("The Chip is not Support!\n");
                g_stSifDrvDev.stDevAttr.enSysSel = SIF_SYS_SEL_FM_RADIO_EUROPE3;
            }
#else
            g_stSifDrvDev.stDevAttr.enSysSel = SIF_SYS_SEL_BTSC;
#endif
            break;               
        case HI_UNF_SIF_STANDARD_M_EIA_J:
            g_stSifDrvDev.stDevAttr.enSysSel = SIF_SYS_SEL_EIAJ;
            break;                    
        case HI_UNF_SIF_STANDARD_L:
            g_stSifDrvDev.stDevAttr.enSysSel = SIF_SYS_SEL_L;
            break;
        default:            
            g_stSifDrvDev.stDevAttr.enSysSel = SIF_SYS_SEL_FM_RADIO_EUROPE3;
            break;
    }

    
    SIF_HAL_SetSysSel(g_stSifDrvDev.stDevAttr.enSysSel);
    
    return HI_SUCCESS;
}

static HI_S32 SIF_GetOutMode(HI_UNF_SIF_AAOS_MODE_E *penAAOSMode)
{
    HI_UNF_SIF_AAOS_MODE_E   enMode = HI_UNF_SIF_AAOS_MODE_MONO;
    
#ifndef SIF_OTP_CHECK_SUPPORT
    HI_BOOL              IsStereo;
    HI_BOOL              IsSap;
#endif

    if (bFlag == HI_FALSE)
    {
        HI_ERR_SIF("current state is not open,can not start ASD Detect!\n");
        return HI_FAILURE;
    }
    
    if(SIF_CHANNEL_STATUS_START!= g_stSifDrvDev.enCurnStatus)
    {
        HI_ERR_SIF("current state is not stop,can not set attr!\n");
        return HI_FAILURE;
    }

    switch (g_stSifDrvDev.stDevAttr.enSysSel)
    {
        case SIF_SYS_SEL_BTSC:
        {
#ifdef SIF_OTP_CHECK_SUPPORT
            if (SIF_CheckChipOTP() != HI_SUCCESS)
            {
                HI_ERR_SIF("The Chip is not Support!\n");
                enMode = HI_UNF_SIF_AAOS_MODE_MONO;
            }
#else
            
            IsStereo = SIF_HAL_IsStereo();
            
            enMode = IsStereo?HI_UNF_SIF_AAOS_MODE_STEREO:HI_UNF_SIF_AAOS_MODE_MONO;

            IsSap = SIF_HAL_IsBiSAP();
            if (IsSap)
            {
                enMode = (enMode == HI_UNF_SIF_AAOS_MODE_STEREO)?HI_UNF_SIF_AAOS_MODE_STEREO_SAP:HI_UNF_SIF_AAOS_MODE_MONO_SAP;
            }
#endif
            break;
        }
        case SIF_SYS_SEL_BG_FM:
        case SIF_SYS_SEL_DK1:
        case SIF_SYS_SEL_DK2:
        case SIF_SYS_SEL_DK3:
        case SIF_SYS_SEL_KOREA://FM-Korea
        {
            HI_BOOL bTmp = SIF_HAL_IsSecCarExist();

            if (bTmp)
            {
                SIF_AUDMODE_DET_E enAudMode = SIF_HAL_GetAudModDet();
                switch (enAudMode)
                {
                    case SIF_AUDMODE_MONO:
                        enMode = HI_UNF_SIF_AAOS_MODE_MONO;
                        break;
                    case SIF_AUDMODE_STEREO:
                        enMode = HI_UNF_SIF_AAOS_MODE_STEREO;
                        break;
                    case SIF_AUDMODE_BILIGUAL:
                        enMode = HI_UNF_SIF_AAOS_MODE_DUAL; 
                        break;                
                    default:
                        enMode = HI_UNF_SIF_AAOS_MODE_MONO;
                        break;  
                }
            }
             break;
        }
        case SIF_SYS_SEL_L:
        case SIF_SYS_SEL_BG_NICAM:
        case SIF_SYS_SEL_DK_NICAM:
        case SIF_SYS_SEL_I:
        {
            SIF_ANADIG_STATUS_E enAnaMode = SIF_HAL_GetAnaDigStatus();

            if (enAnaMode == SIF_ANADIG_STATUS_DIG)
            {
                SIF_NICAM_CTRL_E enNICAMCtl = SIF_HAL_GetNICAMCtrl();
                switch (enNICAMCtl)
                {
                    case SIF_NICAM_CTRL_STEREO:
                        enMode = HI_UNF_SIF_AAOS_MODE_NICAM_STEREO;
                        break;
                    case SIF_NICAM_CTRL_MONODATA:
                        enMode = HI_UNF_SIF_AAOS_MODE_NICAM_MONO;
                        break;
                    case SIF_NICAM_CTRL_DUALMONO:
                        enMode = HI_UNF_SIF_AAOS_MODE_NICAM_DUAL;
                        break;
                    default:
                        break;
                }
            }
            else
            {
                enMode = HI_UNF_SIF_AAOS_MODE_MONO;
            }
            break;
        }
        case SIF_SYS_SEL_EIAJ:
        {
            HI_BOOL bTmp = SIF_HAL_IsPrmCarExist();
                            
            if (bTmp)
            {
                SIF_AUDMODE_DET_E enAudMode = SIF_HAL_GetAudModDet();
                switch (enAudMode)
                {
                    case SIF_AUDMODE_MONO:
                        enMode = HI_UNF_SIF_AAOS_MODE_MONO;
                        break;
                    case SIF_AUDMODE_BILIGUAL:
                        enMode = HI_UNF_SIF_AAOS_MODE_DUAL;
                        break;
                    case SIF_AUDMODE_STEREO:
                        enMode = HI_UNF_SIF_AAOS_MODE_STEREO; 
                        break;                
                    default:
                        enMode = HI_UNF_SIF_AAOS_MODE_MONO;
                        break;  
                }
            }
            break;
        }
        case SIF_SYS_SEL_FM_RADIO_US:
        case SIF_SYS_SEL_FM_RADIO_EUROPE1:
        case SIF_SYS_SEL_FM_RADIO_EUROPE2:
        case SIF_SYS_SEL_FM_RADIO_EUROPE3:
        {
            
            enMode = HI_UNF_SIF_AAOS_MODE_MONO;
            break;
        }
        default:
        {
            enMode = HI_UNF_SIF_AAOS_MODE_MONO;
            break;
        }
    }

    g_stSifDrvDev.enAaosMode = enMode;

    *penAAOSMode = enMode;

    return HI_SUCCESS;
}

static HI_S32 SIF_SetOutMode(HI_UNF_SIF_OUTMODE_E enOutMode)
{    
    if (bFlag == HI_FALSE)
    {
        HI_ERR_SIF("current state is not open,can not start ASD Detect!\n");
        return HI_FAILURE;
    }
    
    if (enOutMode >= HI_UNF_SIF_OUTMODE_BUTT)
    {
        SIF_TRACE(HI_SIF_ERR, "Invalid Audio Output Mode Error: %d of ADEMOD \n", enOutMode);
        return HI_FAILURE;
    }

    if(SIF_CHANNEL_STATUS_START!= g_stSifDrvDev.enCurnStatus)
    {
        HI_ERR_SIF("current state is stop,can not set out mode!\n");
        return HI_FAILURE;
    }
    
    switch (enOutMode)
    {
        case HI_UNF_SIF_OUTMODE_MONO:
        case HI_UNF_SIF_OUTMODE_NICAM_MONO:
            g_stSifDrvDev.stDevAttr.L_output = SIF_AAOS_OUTMODE_MONO;
            g_stSifDrvDev.stDevAttr.R_output = SIF_AAOS_OUTMODE_MONO;             
            g_stSifDrvDev.stDevAttr.bAAOSEn  = HI_TRUE;
            break;
        case HI_UNF_SIF_OUTMODE_BTSC_MONO:
#ifdef SIF_OTP_CHECK_SUPPORT
            if (SIF_CheckChipOTP() != HI_SUCCESS)
            {
                HI_ERR_SIF("The Chip is not Support!\n");
            }
#else
            g_stSifDrvDev.stDevAttr.L_output = SIF_AAOS_OUTMODE_MONO;
            g_stSifDrvDev.stDevAttr.R_output = SIF_AAOS_OUTMODE_MONO;             
            g_stSifDrvDev.stDevAttr.bAAOSEn  = HI_TRUE;
#endif
            break;
        case HI_UNF_SIF_OUTMODE_NICAM_FORCED_MONO:
            g_stSifDrvDev.stDevAttr.L_output = SIF_AAOS_OUTMODE_MONO;
            g_stSifDrvDev.stDevAttr.R_output = SIF_AAOS_OUTMODE_MONO;             
            g_stSifDrvDev.stDevAttr.bAAOSEn  = HI_FALSE;
            break;             
        case HI_UNF_SIF_OUTMODE_STEREO:     
        case HI_UNF_SIF_OUTMODE_NICAM_STEREO:
            g_stSifDrvDev.stDevAttr.L_output = SIF_AAOS_OUTMODE_L_OR_R;
            g_stSifDrvDev.stDevAttr.R_output = SIF_AAOS_OUTMODE_L_OR_R;    
            g_stSifDrvDev.stDevAttr.bAAOSEn = HI_TRUE;
            break;
        case HI_UNF_SIF_OUTMODE_BTSC_STEREO:             
#ifdef SIF_OTP_CHECK_SUPPORT
            if (SIF_CheckChipOTP() != HI_SUCCESS)
            {
                HI_ERR_SIF("The Chip is not Support!\n");
            }
#else
            g_stSifDrvDev.stDevAttr.L_output = SIF_AAOS_OUTMODE_L_OR_R;
            g_stSifDrvDev.stDevAttr.R_output = SIF_AAOS_OUTMODE_L_OR_R;    
            g_stSifDrvDev.stDevAttr.bAAOSEn = HI_TRUE;
#endif
            break;
        case HI_UNF_SIF_OUTMODE_DUAL_A:            
        case HI_UNF_SIF_OUTMODE_NICAM_DUAL_A:            
            g_stSifDrvDev.stDevAttr.L_output = SIF_AAOS_OUTMODE_A;
            g_stSifDrvDev.stDevAttr.R_output = SIF_AAOS_OUTMODE_A;               
            g_stSifDrvDev.stDevAttr.bAAOSEn = HI_TRUE;
            break;
        case HI_UNF_SIF_OUTMODE_DUAL_B:
        case HI_UNF_SIF_OUTMODE_NICAM_DUAL_B:  
        {
            HI_UNF_SIF_STANDARD_TYPE_E enSysSel;
            SIF_GetSysSel(&enSysSel);                
            if (g_stSifDrvDev.stDevAttr.enSysSel == SIF_SYS_SEL_BTSC)
            {
                g_stSifDrvDev.stDevAttr.bBTSCSap = HI_TRUE;
                SIF_HAL_SetBTSCSap(SIF_SIGSEL_BTSC_SAP);            
            }
            
            g_stSifDrvDev.stDevAttr.L_output = SIF_AAOS_OUTMODE_B;
            g_stSifDrvDev.stDevAttr.R_output = SIF_AAOS_OUTMODE_B;                
            g_stSifDrvDev.stDevAttr.bAAOSEn = HI_TRUE;            
            break;
        }
        case HI_UNF_SIF_OUTMODE_BTSC_SAP:
        {
#ifdef SIF_OTP_CHECK_SUPPORT
            if (SIF_CheckChipOTP() != HI_SUCCESS)
            {
                HI_ERR_SIF("The Chip is not Support!\n");
            }
#else
            HI_UNF_SIF_STANDARD_TYPE_E enSysSel;
            SIF_GetSysSel(&enSysSel);                
            if (g_stSifDrvDev.stDevAttr.enSysSel == SIF_SYS_SEL_BTSC)
            {
                g_stSifDrvDev.stDevAttr.bBTSCSap = HI_TRUE;
                SIF_HAL_SetBTSCSap(SIF_SIGSEL_BTSC_SAP);            
            }
            
            g_stSifDrvDev.stDevAttr.L_output = SIF_AAOS_OUTMODE_B;
            g_stSifDrvDev.stDevAttr.R_output = SIF_AAOS_OUTMODE_B;                
            g_stSifDrvDev.stDevAttr.bAAOSEn = HI_TRUE;            
#endif
            break;
        }
        case HI_UNF_SIF_OUTMODE_DUAL_AB:
        case HI_UNF_SIF_OUTMODE_NICAM_DUAL_AB:  
        {            
            HI_UNF_SIF_STANDARD_TYPE_E enSysSel;
            SIF_GetSysSel(&enSysSel);                
            if (g_stSifDrvDev.stDevAttr.enSysSel == SIF_SYS_SEL_BTSC)
            {
                g_stSifDrvDev.stDevAttr.bBTSCSap = HI_TRUE;
                SIF_HAL_SetBTSCSap(SIF_SIGSEL_BTSC_SAP);            
            }
            g_stSifDrvDev.stDevAttr.L_output = SIF_AAOS_OUTMODE_A;
            g_stSifDrvDev.stDevAttr.R_output = SIF_AAOS_OUTMODE_B;  
            g_stSifDrvDev.stDevAttr.bAAOSEn = HI_TRUE;            
            break;   
        }
         default:
            g_stSifDrvDev.stDevAttr.L_output = SIF_AAOS_OUTMODE_L_OR_R;
            g_stSifDrvDev.stDevAttr.R_output = SIF_AAOS_OUTMODE_L_OR_R;   
            g_stSifDrvDev.stDevAttr.bAAOSEn = HI_TRUE;
            break;            
    }


    SIF_HAL_SetAAOSLfSel(g_stSifDrvDev.stDevAttr.L_output);
    SIF_HAL_SetAAOSRtSel(g_stSifDrvDev.stDevAttr.R_output);
    SIF_HAL_AAOSEn(g_stSifDrvDev.stDevAttr.bAAOSEn);

    return HI_SUCCESS;
}

static HI_S32 SIF_SetCarriShift(HI_U32 u32CarriShift)
{
    if (bFlag == HI_FALSE)
    {
        HI_ERR_SIF("current state is not open,can not start ASD Detect!\n");
        return HI_FAILURE;
    }

    if(SIF_CHANNEL_STATUS_START!= g_stSifDrvDev.enCurnStatus)
    {
        HI_ERR_SIF("current state is not stop,can not set attr!\n");
        return HI_FAILURE;
    }
    
    g_stSifDrvDev.stDevAttr.enCrriFreq1 = u32CarriShift;
    SIF_HAL_SetDemodCarriFreq1(g_stSifDrvDev.stDevAttr.enCrriFreq1);
    
    return HI_SUCCESS;
}

static HI_S32 SIF_SetOverMode(SIF_OVER_DEVIATION_E enOverMode)
{
    if (bFlag == HI_FALSE)
    {
        HI_ERR_SIF("current state is not open,can not start ASD Detect!\n");
        return HI_FAILURE;
    }
        
    if(SIF_CHANNEL_STATUS_START!= g_stSifDrvDev.enCurnStatus)
    {
        HI_ERR_SIF("current state is not stop,can not set attr!\n");
        return HI_FAILURE;
    }
    if (enOverMode >= SIF_OVER_DEVIATION_BUTT)
    {
        SIF_TRACE(HI_SIF_ERR, "Invalid Over Mode Param Error: %d of SIF \n", enOverMode);
        return HI_FAILURE;
    }
    
    g_stSifDrvDev.stDevAttr.enFlt1       = (SIF_FILTER1_E)enOverMode;
    g_stSifDrvDev.stDevAttr.enDeviation1 = (SIF_DEVIATION1_E)enOverMode;
    
    SIF_HAL_SetFilter1(g_stSifDrvDev.stDevAttr.enFlt1);
    SIF_HAL_SetDeviation1(g_stSifDrvDev.stDevAttr.enDeviation1);
    SIF_HAL_DemulatorMode(SIF_DEMOD1_MODE_FM);
    
    return HI_SUCCESS;
}

static HI_S32 SifSetAutoMute(HI_BOOL bAutoMute)
{
    if (bAutoMute == HI_FALSE)
    {
        SIF_HAL_SetMuteRight(HI_FALSE);
        SIF_HAL_SetMuteLeft(HI_FALSE);
    }

    bAutoMute = (bAutoMute == HI_FALSE)?HI_TRUE:HI_FALSE;
    
    SIF_HAL_SetMuteAuto(bAutoMute);

    return HI_SUCCESS;
}

static HI_S32 SifSetFreqError(HI_UNF_SIF_FREQ_ERR_THRESHOLD_E enFreqErr)
{
    SIF_FREQ_ERR_THRESHOLD_E enHalFreqErr = SIF_FREQ_ERR_THRESHOLD_27K;
    
    switch (enFreqErr)
    {
        case HI_UNF_SIF_FREQ_ERR_THRESHOLD_10K:
            enHalFreqErr = SIF_FREQ_ERR_THRESHOLD_10K;
            break;
        case HI_UNF_SIF_FREQ_ERR_THRESHOLD_20K:
            enHalFreqErr = SIF_FREQ_ERR_THRESHOLD_20K;
            break;        
        case HI_UNF_SIF_FREQ_ERR_THRESHOLD_27K:
            enHalFreqErr = SIF_FREQ_ERR_THRESHOLD_27K;
            break;
        case HI_UNF_SIF_FREQ_ERR_THRESHOLD_30K:
            enHalFreqErr = SIF_FREQ_ERR_THRESHOLD_30K;
            break;
        case HI_UNF_SIF_FREQ_ERR_THRESHOLD_40K:
            enHalFreqErr = SIF_FREQ_ERR_THRESHOLD_40K;
            break;
        case HI_UNF_SIF_FREQ_ERR_THRESHOLD_50K:
            enHalFreqErr = SIF_FREQ_ERR_THRESHOLD_50K;
            break;
        default:
            enHalFreqErr = SIF_FREQ_ERR_THRESHOLD_27K;
            break;
    }
    
    SIF_HAL_SetFreqErr(enHalFreqErr);

    return HI_SUCCESS;
}

static HI_S32 SIF_SetAttr(HI_UNF_SIF_ATTR_S stAttr)
{
     if (bFlag == HI_FALSE)
     {
         HI_ERR_SIF("current state is not open,can not start ASD Detect!\n");
         return HI_FAILURE;
     }

    if(SIF_CHANNEL_STATUS_STOP != g_stSifDrvDev.enCurnStatus)
    {
        HI_ERR_SIF("current state is not stop,can not set attr!\n");
        return HI_FAILURE;
    }

    memcpy(&g_stSifDrvDev.stAttr, &stAttr, sizeof(stAttr));
        
    SifSetFreqError(g_stSifDrvDev.stAttr.enFreqThreshold);
    SifSetAutoMute(g_stSifDrvDev.stAttr.bAutoMute);
    
    return HI_SUCCESS;
}

static HI_S32 SIF_GetAttr(HI_UNF_SIF_ATTR_S *pstAttr)
{    
    SIF_CHECK_NULL_PTR(pstAttr);    

    if (bFlag == HI_FALSE)
    {
        HI_ERR_SIF("current state is not open,can not start ASD Detect!\n");
        return HI_FAILURE;
    }

    if(SIF_CHANNEL_STATUS_START!= g_stSifDrvDev.enCurnStatus)
    {
        HI_ERR_SIF("current state is not start,can not set attr!\n");
        return HI_FAILURE;
    }

    memcpy(pstAttr, &g_stSifDrvDev.stAttr, sizeof(HI_UNF_SIF_ATTR_S));
  
    return HI_SUCCESS;
}

static HI_S32 SIF_Open(HI_UNF_SIF_OPENPARMS_S stOpenParam)
{
    memcpy(&g_stSifDrvDev.stOpenParam, &stOpenParam, sizeof(stOpenParam));
    
    /**/
    //时钟，分频比，解复位
    //现在在AIF中设置，移植到S5V100中    
    SIF_CRG_HAL_Reset();    
    SIF_CRG_HAL_NoReset(g_stSifDrvDev.stOpenParam.enAIFMode);

    g_stSifDrvDev.enCurnStatus = SIF_CHANNEL_STATUS_STOP;

    switch (stOpenParam.enAIFMode)
    {
        case HI_UNF_SIF_AIF_MODE_INTERNEL:
        {
            U_PERI_ADEC_SIF_DATA_SEL uTmpVal;
            uTmpVal.u32 = g_pstRegPeri->PERI_ADEC_SIF_DATA_SEL.u32;
            uTmpVal.bits.peri_adec_sif_data_sel = 0;/*0:外置;1:内置*/
            g_pstRegPeri->PERI_ADEC_SIF_DATA_SEL.u32 = uTmpVal.u32;
            break;
        }
        case HI_UNF_SIF_AIF_MODE_EXTERN:
        {
            U_PERI_ADEC_SIF_DATA_SEL uTmpVal;
            uTmpVal.u32 = g_pstRegPeri->PERI_ADEC_SIF_DATA_SEL.u32;
            uTmpVal.bits.peri_adec_sif_data_sel = 1;/*0:外置;1:内置*/
            g_pstRegPeri->PERI_ADEC_SIF_DATA_SEL.u32 = uTmpVal.u32;
            break;
        }
        default:
        {
            U_PERI_ADEC_SIF_DATA_SEL uTmpVal;
            uTmpVal.u32 = g_pstRegPeri->PERI_ADEC_SIF_DATA_SEL.u32;
            uTmpVal.bits.peri_adec_sif_data_sel = 0;/*0:外置;1:内置*/
            g_pstRegPeri->PERI_ADEC_SIF_DATA_SEL.u32 = uTmpVal.u32;
            break;
        }
    }
    
    bFlag = HI_TRUE;
    
    
    return HI_SUCCESS;
}

static HI_S32 SIF_Close(HI_VOID)
{
   //复位即ok
   if(SIF_CHANNEL_STATUS_STOP!= g_stSifDrvDev.enCurnStatus)
   {
       HI_ERR_SIF("current state is not stop,can not set attr!\n");
       return HI_FAILURE;
   }
   
   bFlag = HI_FALSE;
    
    SIF_CRG_HAL_Reset();    
    return HI_SUCCESS;
}

static HI_S32 SIF_Start(HI_VOID)
{
    if (bFlag == HI_FALSE)
    {
        HI_ERR_SIF("current state is not open,can not start ASD Detect!\n");
        return HI_FAILURE;
    }
        
    g_stSifDrvDev.enCurnStatus = SIF_CHANNEL_STATUS_START;
    return HI_SUCCESS;
}

static HI_S32 SIF_Stop(HI_VOID)
{   
    if (bFlag == HI_FALSE)
    {
        HI_ERR_SIF("current state is not open,can not start ASD Detect!\n");
        return HI_FAILURE;
    }
    
    g_stSifDrvDev.enCurnStatus = SIF_CHANNEL_STATUS_STOP;
    return HI_SUCCESS;
}

static HI_U32 SIF_GetQuality1(HI_VOID)
{
    if(SIF_CHANNEL_STATUS_START!= g_stSifDrvDev.enCurnStatus)
    {
        HI_ERR_SIF("current state is not stop,can not set attr!\n");
        return HI_FAILURE;
    }
    return SIF_HAL_GetQuality1();
}

static HI_U32 SIF_GetQuality2(HI_VOID)
{
    if(SIF_CHANNEL_STATUS_START!= g_stSifDrvDev.enCurnStatus)
    {
        HI_ERR_SIF("current state is not stop,can not set attr!\n");
        return HI_FAILURE;
    }
    
    return SIF_HAL_GetQuality2();
}

static HI_S32 SIF_GetCarriShiftValue(HI_U32 *pu32ShiftValue)
{
    SIF_CHECK_NULL_PTR(pu32ShiftValue);

    if(SIF_CHANNEL_STATUS_START!= g_stSifDrvDev.enCurnStatus)
    {
        HI_ERR_SIF("current state is not stop,can not set attr!\n");
        return HI_FAILURE;
    }

    *pu32ShiftValue = SIF_HAL_GetCarrierShiftValue();

    #if 0
    if ((*pu32ShiftValue) & 0x8000)
    {
        *pu32ShiftValue = 0xffff - *pu32ShiftValue;
    }
    #endif
    
    g_stSifDrvDev.stDevAttr.u32CarriShiftValue = *pu32ShiftValue;
    
    return HI_SUCCESS;
}

static HI_S32 SIF_GetAsdComplete(HI_BOOL *pbAsdComplete)
{
    SIF_CHECK_NULL_PTR(pbAsdComplete);

    if (bFlag == HI_FALSE)
    {
        HI_ERR_SIF("current state is not open,can not start ASD Detect!\n");
        return HI_FAILURE;
    }

    if(SIF_CHANNEL_STATUS_START!= g_stSifDrvDev.enCurnStatus)
    {
        HI_ERR_SIF("current state is not stop,can not set attr!\n");
        return HI_FAILURE;
    }

    *pbAsdComplete = SIF_HAL_IsASDComplete();
        
    return HI_SUCCESS;
}

static HI_S32 SIF_Suspend(HI_VOID)
{
    HI_UNF_SIF_STANDARD_TYPE_E enSysSel;
    
    if(!g_SifSuspendFlag)
    {
        g_SifSuspendFlag = 1;
    }
    
    /*7. sap状态*/
    /*仅在设置输出时设置，默认为解Stereo,没有改变就无需设置*/    
    
    /*6. auto mute*/
    /*设置属性中已经保存该值*/

    /*5. 输出选择,从寄存器中获取状态*/
    g_stSifDrvDev.stDevAttr.L_output = SIF_HAL_GetAAOSLfSel();
    g_stSifDrvDev.stDevAttr.R_output = SIF_HAL_GetAAOSRtSel();
    g_stSifDrvDev.stDevAttr.bAAOSEn  = SIF_HAL_GetAAOSEn();
    
    /*4. 制式*/
    SIF_GetSysSel(&enSysSel);

    /*3. 阈值*/
    /*设置属性中已经保存该值*/

    /*1. 时钟*/
    /*2. 打开方式*/
    SIF_CRG_HAL_Reset();
    
    g_SifResumeFlag = 0;
    
    return HI_SUCCESS;
}

static HI_S32 SIF_Resume(HI_VOID)
{
    if(!g_SifResumeFlag)
    {      
        /*1. 时钟*/
        /*2. 打开方式*/
        SIF_CRG_HAL_NoReset(g_stSifDrvDev.stOpenParam.enAIFMode);

        /*3. 阈值*/
        SifSetFreqError(g_stSifDrvDev.stAttr.enFreqThreshold);
        
        /*4. 制式*/
        SIF_SetSysSel(g_stSifDrvDev.enSifStand);

        /*5. 输出选择*/
        SIF_HAL_SetAAOSLfSel(g_stSifDrvDev.stDevAttr.L_output);
        SIF_HAL_SetAAOSRtSel(g_stSifDrvDev.stDevAttr.R_output);
        SIF_HAL_AAOSEn(g_stSifDrvDev.stDevAttr.bAAOSEn);
        
        /*6. auto mute*/        
        SifSetAutoMute(g_stSifDrvDev.stDevAttr.bAutoMute);
        
        /*7. sap状态*/
        if (g_stSifDrvDev.stDevAttr.bBTSCSap == HI_TRUE)
        {
            SIF_HAL_SetBTSCSap(SIF_SIGSEL_BTSC_SAP);  
        }       
        
        g_SifResumeFlag = 1;
    }
    
    g_SifSuspendFlag =0;
    return HI_SUCCESS;
}

#if 0
static HI_S32 SIF_SetBTSCSap(HI_BOOL bSap)
{
    if ((bSap != HI_TRUE) && (bSap != HI_FALSE))
    {
        SIF_TRACE(HI_SIF_ERR, "Invalid Btsc Sap Param : %d of ADEMOD \n", bSap);
        return HI_FAILURE;
    }

    g_stSifDrvDev.stDevAttr.bBTSCSap      = bSap;

    SIF_HAL_SetBTSCSap((SIF_STAND_SEL_E)g_stSifDrvDev.stDevAttr.bBTSCSap);
    
    return HI_SUCCESS;
}
#endif

static int SIFDrvIoctl(struct inode *inode, struct file *pFile, unsigned int cmd, HI_VOID* arg)
{
    HI_S32 s32Ret = HI_FAILURE;
        
    switch(cmd)
    {
        case CMD_SIF_START_ASD:
        {
			SIF_SYSCTL_S *pstSysCtl;
            
			pstSysCtl = (SIF_SYSCTL_S *)arg;
			s32Ret = SIF_StartAsdDetect(pstSysCtl->enSysCtl);            
            break;
        }
        case CMD_SIF_SET_STANDDARD:
        {
			SIF_STANDARD_TYPE_S *pstSysSel;
            
			pstSysSel = (SIF_STANDARD_TYPE_S *)arg;
			s32Ret = SIF_SetSysSel(pstSysSel->enStand);      
            break;
        }
        case CMD_SIF_GET_STANDARD:
        case CMD_SIF_GET_ASD_RESULT:
        {			
            SIF_STANDARD_TYPE_S *pstSysSel;
            
			pstSysSel = (SIF_STANDARD_TYPE_S *)arg;
			s32Ret = SIF_GetSysSel(&pstSysSel->enStand);
            
            break;
        }
        case CMD_SIF_SET_OVER_DEV:
        {
			SIF_OVER_DEVIATION_S *pstOverMod;
            
			pstOverMod = (SIF_OVER_DEVIATION_S *)arg;
			s32Ret = SIF_SetOverMode(pstOverMod->enOverMode);
            
            break;
        }        
        case CMD_SIF_SET_CARRI_SHIFT:
        {
			SIF_CARRISHIFT_S *pstCarriShift;
            
			pstCarriShift = (SIF_CARRISHIFT_S *)arg;
			s32Ret = SIF_SetCarriShift(pstCarriShift->u32CarriShift);
            
            break;
        }        
        case CMD_SIF_SET_OUTMODE:
        {
			SIF_OUTMODE_S *pstOutMode;
            
			pstOutMode = (SIF_OUTMODE_S *)arg;
			s32Ret = SIF_SetOutMode(pstOutMode->enOutMode);
            
            break;
        }    
        case CMD_SIF_GET_OUTMODE:
        {
			SIF_AAOS_MODE_S *pstAAOSMode;
            
			pstAAOSMode = (SIF_AAOS_MODE_S *)arg;
			s32Ret = SIF_GetOutMode(&pstAAOSMode->enAAOSMode);
            
            break;
        }   
        case CMD_SIF_GET_ASD_CMPL:
        {
			SIF_ASD_COMPLETE_S *pstAsdCmpl;
            
			pstAsdCmpl = (SIF_ASD_COMPLETE_S *)arg;
			s32Ret = SIF_GetAsdComplete(&pstAsdCmpl->bAsdComplete);
            
            break;
        }
        case CMD_SIF_SET_ATTR:
        {
			SIF_ATTR_S *pstAttr;
            
			pstAttr = (SIF_ATTR_S *)arg;
			s32Ret = SIF_SetAttr(pstAttr->stSifAttr);            
            break;
        }
        case CMD_SIF_GET_ATTR:
        {
			SIF_ATTR_S *pstAttr;
            
			pstAttr = (SIF_ATTR_S *)arg;
			s32Ret = SIF_GetAttr(&pstAttr->stSifAttr);
            
            break;
        }

        case CMD_SIF_OPEN:
        {
			SIF_OPEN_PARAM_S *pstOpenParam;
            
			pstOpenParam = (SIF_OPEN_PARAM_S *)arg;
			s32Ret = SIF_Open(pstOpenParam->stSifOpenParam);
            
            break;
        }
        case CMD_SIF_CLOSE:
        {
			HI_UNF_SIF_ID_E *penSifID;
            
			penSifID = (HI_UNF_SIF_ID_E *)arg;
			s32Ret = SIF_Close();  
            break;
        }
        case CMD_SIF_SET_START:
        {
			HI_UNF_SIF_ID_E *penSifID;
            
			penSifID = (HI_UNF_SIF_ID_E *)arg;
			s32Ret = SIF_Start();     
            break;
        }        
        case CMD_SIF_SET_STOP:
        {
			HI_UNF_SIF_ID_E *penSifID;
            
			penSifID = (HI_UNF_SIF_ID_E *)arg;
			s32Ret = SIF_Stop();   
            break;
        }
        default:
        {
            //SIF_TRACE(HI_SIF_EMERG,"ERR IOCTL CMD 0x%x\n\r", cmd);
            
            HI_ERR_SIF("ERR IOCTL CMD 0x%x\n\r", cmd);
            
            return -ENOIOCTLCMD;
        }
    }
    
    return s32Ret;
}

long SIF_DRV_Ioctl(struct file  *pFile, unsigned int  cmd, unsigned long arg)
{
    long Ret;

    Ret = down_interruptible(&g_SIFMutex);
        
    Ret = HI_DRV_UserCopy(pFile->f_dentry->d_inode, pFile, cmd, arg, SIFDrvIoctl);    
    
    up(&g_SIFMutex);
    return Ret;

}
