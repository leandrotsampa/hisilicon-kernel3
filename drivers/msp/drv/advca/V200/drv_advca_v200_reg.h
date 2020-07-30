/******************************************************************************

  Copyright (C), 2001-2014, Hisilicon Tech. Co., Ltd.
 ******************************************************************************
  File Name     : drv_advca_v200_reg.h
  Version       : Initial Draft
  Author        : Hisilicon hisecurity team
  Created       : 2013/08/28
  Last Modified :
  Description   : CA REG DEFINE
  Function List :
******************************************************************************/

#ifndef __DRV_ADVCA_V200_REG_H__
#define __DRV_ADVCA_V200_REG_H__

#include "drv_advca_external.h"

#ifdef __cplusplus
#if __cplusplus
extern "C"{
#endif
#endif /* __cplusplus */

typedef union
{
    struct 
    {
        HI_U32 Valid       : 1;
        HI_U32 SecBootEn   : 1;
        HI_U32 SecFlashSel : 2;
        HI_U32 OtpBootEn   : 1;
        HI_U32 PinBootEn   : 1;
        HI_U32 OtpFlashSel : 2;
        HI_U32 PinFlashSel : 2;
        HI_U32 DbgDisable  : 1;
        HI_U32 Rsved       : 5;
        HI_U32 RsaKeyLen   : 1;
        HI_U32 JtagKeyLen  : 1;
        HI_U32 Reserved    : 14;
    }Bits;

    HI_U32 Value;
}CA_SECBOOTCFG_U;

typedef union
{
    struct 
    {
        HI_U32 BootRomStart : 1;
        HI_U32 GoinNormal   : 1;
        HI_U32 VerifyEnd    : 1;
        HI_U32 VerifyRslt   : 1;
        HI_U32 Reserved     : 28;
    }Bits;
    HI_U32 Value;
}CA_SECBOOTSTAT_U;

typedef union
{
    struct 
    {
        HI_U32 AlgSel     : 1;
        HI_U32 KeyLadSel  : 2;
        HI_U32 CwOrR2r    : 1;
        HI_U32 OddOrEven  : 1;
        HI_U32 EnOrDecrpt : 1;
        HI_U32 Rsved      : 1;
        HI_U32 CaStart    : 1;
        HI_U32 KeyAddr    : 6;
        HI_U32 Reserved   : 18;
    }Bits;
    HI_U32 Value;
}CA_CTRL_U;

typedef union
{
    struct 
    {
        HI_U32 CwLadSet  : 2;
        HI_U32 R2rLadSet : 2;
        HI_U32 CaWdogEn  : 1;
        HI_U32 Reserved  : 27;
    }Bits;
    HI_U32 Value;
}CA_LADDERSET_U;

typedef union
{
    struct 
    {
        HI_U32 CwKeyLad2Rdy  : 1;
        HI_U32 CwKeyLad1Rdy  : 1;
        HI_U32 CwKeyLad0Rdy  : 1;
        HI_U32 TdesKeyErr    : 1;
        HI_U32 Rsved         : 1;
        HI_U32 R2rKeyLad2Rdy : 1;
        HI_U32 R2rKeyLad1Rdy : 1;
        HI_U32 R2rKeyLad0Rdy : 1;
        HI_U32 LastKeyErr    : 1;
        HI_U32 KeyLadErr     : 1;
        HI_U32 Reserved      : 22;
    }Bits;
    HI_U32 Value;
}CA_STAT_U;

typedef union
{
    struct 
    {
        HI_U32 CaFinishInt   : 1;
        HI_U32 CaErrInt      : 1;
        HI_U32 WdgOverInt    : 1;
        HI_U32 Reserved      : 29;
    }Bits;
    HI_U32 Value;
}CA_INTSTAT_U;

typedef union
{
    struct 
    {
        HI_U32 CaFinishIntEn   : 1;
        HI_U32 CaErrIntEn      : 1;
        HI_U32 WdgOverIntEn    : 1;
        HI_U32 Reserved1       : 4;
        HI_U32 CaIntEn         : 1;
        HI_U32 Reserved2       : 24;
    }Bits;
    HI_U32 Value;
}CA_INTEN_U;

typedef union
{
    struct 
    {
        HI_U32 CaFinishRawInt  : 1;
        HI_U32 CaErrRawInt     : 1;
        HI_U32 WdgOverRawInt   : 1;
        HI_U32 Reserved        : 29;
    }Bits;
    HI_U32 Value;
}CA_INTRAW_U;

typedef union
{
    struct 
    {
        HI_U32 LoadOtp         : 1;
        HI_U32 Reserved        : 31;
    }Bits;
    HI_U32 Value;
}CA_LOADOPT_U;

typedef union
{
    struct 
    {
        HI_U32 RstStat         : 1;
        HI_U32 Reserved        : 31;
    }Bits;
    HI_U32 Value;
}CA_RSTSTAT_U;

typedef union hiCA_CTRLPROC_U
{
    struct 
    {
        HI_U32 BootModeSel0    : 1;
        HI_U32 BootModeSel1    : 1;
        HI_U32 ScsActivation   : 1;
        HI_U32 JtagPrtMode0    : 1;
        HI_U32 JtagPrtMode1    : 1;
        HI_U32 CwKeyDeactive   : 1;
        HI_U32 R2rKeyDeactive  : 1;
        HI_U32 DebugDisable    : 1;
        HI_U32 Reserved0       : 1;
        HI_U32 JtagKeyLen      : 1;
        HI_U32 MarketIdP       : 1;
        HI_U32 StbSnP          : 1;
        HI_U32 CwLvOrg         : 1;
        HI_U32 CwLvSel         : 1;
        HI_U32 SecureChipP     : 1;
        HI_U32 CwInfoP         : 1;
        HI_U32 BootDecEn       : 1;
        HI_U32 R2rLvSel        : 1;
        HI_U32 LkpDisable      : 1;
        HI_U32 BootSelLock     : 1;
        HI_U32 CaRsvLock       : 1;
        HI_U32 TdesLock        : 1;
        HI_U32 CwLvLock        : 1;
        HI_U32 R2rLvLock       : 1;
        HI_U32 R2rHKeyLock     : 1;
        HI_U32 SlfBootDisable  : 1;
        HI_U32 Reserved        : 2;
        HI_U32 CaVendor        : 4;
    }Bits;

    HI_U32 Value;
}CA_CTRLPROC_U;

typedef union
{
    struct 
    {
        HI_U32 ParaOrLpk       : 1;
        HI_U32 LinkFlag        : 1;
        HI_U32 BootEncFlag     : 1;
        HI_U32 BootDecFlag     : 1;
        HI_U32 Reserved        : 28;
    }Bits;
    
    HI_U32 Value;
}CA_FUNCSET_U;

typedef union
{
    struct 
    {
        HI_U32 WorkFlag        : 2;
        HI_U32 JtagCurStat     : 4;
        HI_U32 JtagLoadOtp     : 1;
        HI_U32 JtagMode        : 2;
        HI_U32 CwLvSet         : 2;
        HI_U32 Reserved        : 21;
    }Bits;
    
    HI_U32 Value;
}CA_DBGINFO_U;

typedef union
{
    struct 
    {
        HI_U32 LpkReady        : 1;
        HI_U32 Reserved        : 31;
    }Bits;
    
    HI_U32 Value;
}CA_LPKREADY_U;


typedef struct hiCA_REG_S
{
    CA_SECBOOTCFG_U  SecBootCfg;
    CA_SECBOOTSTAT_U SecBootStat;
    HI_U32           MarketId;
    HI_U32           ChipId;
    HI_U32           StbSn;       
    HI_U32           Reserved0[3];    
    HI_U32           CaDataIn0;   
    HI_U32           CaDataIn1;
    HI_U32           CaDataIn2;
    HI_U32           CaDataIn3;
    CA_CTRL_U        CaCtrl;
    CA_LADDERSET_U   CaSetLadder;
    CA_STAT_U        CaStat;
    HI_U32           Reserve0;
    CA_INTSTAT_U     CaIntStat;
    CA_INTEN_U       CaIntEn;
    CA_INTRAW_U      CaIntRaw;
    CA_LOADOPT_U     CaLoadOtp;
    CA_RSTSTAT_U     CaRstStat;    
    HI_U32           Reserve1[3]; 
    HI_U32           KeyDataOut0;
    HI_U32           KeyDataOut1;
    HI_U32           KeyDataOut2;
    HI_U32           KeyDataOut3;
    HI_U32           JtagKey[2];
    CA_CTRLPROC_U    CaCtrlProc;
    HI_U32           CaPrmOtp;
    HI_U32           Reserved2[8];
    CA_FUNCSET_U     FuncSet;
    CA_DBGINFO_U     DebugInfo;
    CA_LPKREADY_U    LpkReady;
    HI_U32           Reserved3;
    HI_U32           LpPara[4];
    HI_U32           RsvInfo[4];
    HI_U32           Version;
}CA_REG_S;


#ifdef __cplusplus
#if __cplusplus
}
#endif
#endif /* __cplusplus */

#endif	/* __DRV_ADVCA_V200_REG_H__ */

