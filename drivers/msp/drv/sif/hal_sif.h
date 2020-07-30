/******************************************************************************

  Copyright (C), 2012-2014, Hisilicon Tech. Co., Ltd.

 ******************************************************************************
  File Name     : hal_ademod.h
  Version       : Initial Draft
  Author        : Hisilicon multimedia software group
  Created       : 2012/09/19
  Description   : 
  History       :
  1.Date        : 2012/09/19
    Author      : m00196336
    Modification: Created file
******************************************************************************/
#ifndef __HAL_ADEMOD_H__
#define __HAL_ADEMOD_H__

#include "hi_unf_sif.h"
#include "hi_type.h"

#ifdef __cplusplus
#if __cplusplus
extern "C"{
#endif
#endif /* __cplusplus */

/*“Ù∆µ∞È“Ù÷∆ Ω*/
typedef enum hiSIF_SYS_SEL_E 
{
    SIF_SYS_SEL_BG_FM   = 0  ,/*BG_FM-Stereo/BG_A2,A2BG*/
    SIF_SYS_SEL_BG_NICAM 	  ,/*BG_FM-mono/BG_NICAM NICAMBG*/
    SIF_SYS_SEL_L              ,/*L_AM-mono/L_NICAM NICAML*/
    SIF_SYS_SEL_I              ,/*I_FM(mono)/I_NICAM  NICAMI*/
    SIF_SYS_SEL_DK1            ,/*DK1_A2(FM-Stereo) A2DK1*/
    SIF_SYS_SEL_DK2            ,/*DK2_A2(FM-Stereo) A2DK2*/
    SIF_SYS_SEL_DK3            ,/*DK3_A2(FM-Stereo) A2DK3*/
    SIF_SYS_SEL_DK_NICAM       ,/*DK_FM(mono)/DK_NICAM NICAMDK*/
    SIF_SYS_SEL_KOREA          ,/*M_Korea(FM-Stereo), A2MN*/ 
    SIF_SYS_SEL_EIAJ           ,/*M_FM(Stereo)(EIA- J) EIAJ*/
    SIF_SYS_SEL_BTSC           ,/*M_FM(Stereo)+SAP(BTSC)****BTSC = 1*/
    SIF_SYS_SEL_FM_RADIO_EUROPE  ,/**Radio-Europe****BTSC = 0*/
    SIF_SYS_SEL_FM_RADIO_US      ,/*Radio-US*/
    SIF_SYS_SEL_FM_RADIO_EUROPE1 ,/*Radio-Europe*/
    SIF_SYS_SEL_FM_RADIO_EUROPE2 ,/*Radio-Europe*/
    SIF_SYS_SEL_FM_RADIO_EUROPE3 ,/*Radio-Europe*/
    SIF_SYS_SEL_BUTT             ,/*Unknown/FM(stereo)/Radio-europe*/
} SIF_SYS_SEL_E;


typedef enum hiSIF_STAND_SEL_E
{
    SIF_SIGSEL_BTSC_STEREO   = 0x0,  /*BTSC(Mono/Stereo) or FM Radio 50us(i1BTSCSelect = 0)*/
    SIF_SIGSEL_BTSC_SAP      = 0x1,  /*BTSC(Mono/SAP) or FM Radio 50us(i1BTSCSelect = 0)*/   
    SIF_SIGSEL_BTSC_Expand   = 0x2,  /*BTSC (Mono/Stereo(replaced w/75¶Ãs deemphasis) or FM Radio 50us(i1BTSCSelect = 0) */  
    SIF_SIGSEL_EIA_J         = 0x3,  /*EIA-J*/
    SIF_SIGSEL_A2            = 0x4,  /*A2*/    
    SIF_SIGSEL_FM_RADIO_US   = 0x5,  /*FM Radio 75us*/
    SIF_SIGSEL_FM_RADIO_EUR  = 0x6,  /*FM Radio 50us*/
    SIF_SIGSEL_NICAM         = 0x7,  /*NICAM*/
    
    SIF_SIGSEL_BUTT
} SIF_STAND_SEL_E;

typedef enum hiSIF_SAMPLE_RATE_E
{
    SIF_SAM_RATE_48K         = 0x0,
    SIF_SAM_RATE_32K         = 0x1,
    SIF_SAM_RATE_44K         = 0x2,
    SIF_SAM_RATE_44K_1       = 0x3,
    SIF_SAM_RATE_46K         = 0x4,
    SIF_SAM_RATE_31K         = 0x5,
    SIF_SAM_RATE_31K_1       = 0x6,
    SIF_SAM_RATE_31K_2       = 0x7,  
    
    SIF_SAM_RATE_BUTT           
} SIF_SAMPLE_RATE_E;

typedef enum hiSIF_ASDCTL_45M_E
{
    SIF_ASDCTL_45M_BTSC      = 0x0,  /*BTSC*/
    SIF_ASDCTL_45M_EIAJ      = 0x1,  /*EIAJ*/
    SIF_ASDCTL_45M_M_KOREA   = 0x2,  /*M-Korea*/
    SIF_ASDCTL_45M_PAL_SUM   = 0x3,  /*PAL Chroma Carrier */
    SIF_ASDCTL_45M_FM_US     = 0x4,  /*FM-Stereo Radio US */
    SIF_ASDCTL_45M_FM_EURO   = 0x5,  /*FM-Stereo Radio Europe */
    SIF_ASDCTL_45M_FM_EURO1  = 0x6,  /*FM-Stereo Radio Europe */
    SIF_ASDCTL_45M_FM_EURO2  = 0x7,  /*FM-Stereo Radio Europe */
    
    SIF_ASDCTL_45M_BUTT
} SIF_ASDCTL_45M_E;

typedef enum hiSIF_ASDCTL_65M_E
{
    SIF_ASDCTL_65M_SECAM_L   = 0x0,  /*SECAM L NICAM */
    SIF_ASDCTL_65M_DK        = 0x1,  /*D/K1, D/K2, D/K3 or D/K NICAM */
    
    SIF_ASDCTL_65M_BUTT
} SIF_ASDCTL_65M_E;

typedef enum hiSIF_ASCS_CHGMODE_E
{
    SIF_ASCS_CHGMODE_NOT_ATUO = 0x0, /*not change atuomatically*/
    SIF_ASCS_CHGMODE_AFTER_RST= 0x1, /*change status after detect stereo*/
    SIF_ASCS_CHGMODE_AUTO     = 0x2, /*auto*/
    SIF_ASCS_CHGMODE_AUTO1    = 0x3, /*auto2,the same as auto*/
    
    SIF_ASCS_CHGMODE_BUTT,
} SIF_ASCS_CHGMODE_E;

typedef enum hiSIF_ASCS_MODE_E
{
    SIF_ASCS_MODE_DISABLE    = 0x0,  /*not search*/
    SIF_ASCS_MODE_ONETIME    = 0x1,  /*only search once*/
    SIF_ASCS_MODE_ALWAYS     = 0x2,  /*search always*/
    SIF_ASCS_MODE_ALWAYS1    = 0x3,  /*search always, the same as 'search always'*/
    
    SIF_ASCS_MODE_BUTT       
} SIF_ASCS_MODE_E;

typedef enum hiSIF_AAOS_OUTMODE_E
{
    SIF_AAOS_OUTMODE_MONO    = 0x0,       
    SIF_AAOS_OUTMODE_L_OR_R  = 0x1,       
    SIF_AAOS_OUTMODE_A       = 0x2,        
    SIF_AAOS_OUTMODE_B       = 0x3,    
    
    SIF_AAOS_OUTMODE_BUTT      
} SIF_AAOS_OUTMODE_E;

typedef enum hiSIF_AUDMODE_DET_E
{
    SIF_AUDMODE_MONO         = 0x0,   
    SIF_AUDMODE_STEREO       = 0x1,
    SIF_AUDMODE_BILIGUAL     = 0x2,           
    
    SIF_AUDMODE_BUTT      
} SIF_AUDMODE_DET_E;

typedef enum hiSIF_ANADIG_STATUS_E
{
    SIF_ANADIG_STATUS_ANA    = 0x0,       
    SIF_ANADIG_STATUS_NOANA  = 0x1,       
    SIF_ANADIG_STATUS_DIG    = 0x2,
    SIF_ANADIG_STATUS_NODIG  = 0x3,   
    
    SIF_ANADIG_STATUS_BUTT      
} SIF_ANADIG_STATUS_E;

typedef enum hiSIF_OUTMODE_E
{
    SIF_OUTMODE_MONO         = 0x0,
    SIF_OUTMODE_STRERO       = 0x1,
    SIF_OUTMODE_DUALA        = 0x2,
    SIF_OUTMODE_DUALB        = 0x3,
    
    SIF_OUTMODE_BUTT
}SIF_OUTMODE_E;

typedef enum hiSIF_NICAM_CTRL_E
{
    SIF_NICAM_CTRL_STEREO    = 0x0,
    SIF_NICAM_CTRL_MONODATA  = 0x1,
    SIF_NICAM_CTRL_DUALMONO  = 0x2,
    SIF_NICAM_CTRL_MONO      = 0x3,
    
    SIF_NICAM_CTRL_BUTT,      
} SIF_NICAM_CTRL_E;

typedef enum hiSIF_ASCS_RESULT_E
{
    SIF_ASCS_RST_A2BG        = 0x0,  
    SIF_ASCS_RST_NICAMBG     = 0x1,     
    SIF_ASCS_RST_A2DK1       = 0x4, 
    SIF_ASCS_RST_A2DK2       = 0x5,   
    SIF_ASCS_RST_A2DK3       = 0x6,  
    SIF_ASCS_RST_NICAMDK     = 0x7, 
    SIF_ASCS_RST_NORST       = 0xF,
    SIF_ASCS_RST_IS_SEARCHING= 1<<4,
    SIF_ASCS_RST_DIFF        = 1<<5,
    SIF_ASCS_RST_INDICATER   = 1<<6,
    
    SIF_ASCS_RST_BUTT      
} SIF_ASCS_RESULT_E;

typedef enum hiSIF_DEMOD1_MODE_E
{
    SIF_DEMOD1_MODE_FM       = 0x0,
    SIF_DEMOD1_MODE_AM       = 0x1,
    
    SIF_DEMOD1_MODE_BUTT
} SIF_DEMOD1_MODE_E;

typedef enum hiSIF_DEMOD1_CARRI_FREQ_E
{
    SIF_DEMOD1_45M_169344M   = 0xbbf9,
    SIF_DEMOD1_55M_169344M   = 0xacdb,
    SIF_DEMOD1_60M_169344M   = 0xa54c,
    SIF_DEMOD1_65M_169344M   = 0x9dbd,
    SIF_DEMOD1_45M_18M       = 0xc000,
    SIF_DEMOD1_55M_18M       = 0xb1c7,
    SIF_DEMOD1_60M_18M       = 0xaaab,
    SIF_DEMOD1_65M_18M       = 0xa38e,
    SIF_DEMOD1_45M_18432M    = 0xc180,
    SIF_DEMOD1_55M_18432M    = 0xb39c,
    SIF_DEMOD1_60M_18432M    = 0xacab,
    SIF_DEMOD1_65M_18432M    = 0xa5b9
} SIF_DEMOD1_CARRI_FREQ_E;

typedef enum hiSIF_DEMOD2_CARRI_FREQ_E
{
    SIF_DEMOD2_4_724212M_169344M    = 0xb895,
    SIF_DEMOD2_57421875M_169344M    = 0xa932,
    SIF_DEMOD2_585M_169344M         = 0xa791,
    SIF_DEMOD2_62578125M_169344M    = 0xa166,
    SIF_DEMOD2_6552M_169344M        = 0x9cf4,
    SIF_DEMOD2_6741875M_169344M     = 0x9a14,

    SIF_DEMOD2_4_724212M_18M        = 0xbcd0,
    SIF_DEMOD2_57421875M_18M        = 0xae55,
    SIF_DEMOD2_585M_18M             = 0xaccd,
    SIF_DEMOD2_62578125M_18M        = 0xa700,
    SIF_DEMOD2_6552M_18M            = 0xa2d1,
    SIF_DEMOD2_6741875M_18M         = 0xa01c,

    SIF_DEMOD2_4_724212M_18432M     = 0xbe63,
    SIF_DEMOD2_57421875M_18432M     = 0xb03f,
    SIF_DEMOD2_585M_18432M          = 0xaec0,
    SIF_DEMOD2_62578125M_18432M     = 0xa916,
    SIF_DEMOD2_6552M_18432M         = 0xa500,
    SIF_DEMOD2_6741875M_18432M      = 0xa25c
}SIF_DEMOD2_CARRI_FREQ_E;

typedef enum hiSIF_FILTER1_E
{
    SIF_DEMOD1_FILTER_50K    = 0x0,
    SIF_DEMOD1_FILTER_100K   = 0x1,
    SIF_DEMOD1_FILTER_384K   = 0x2,
    SIF_DEMOD1_FILTER_540K   = 0x3,
    SIF_DEMOD1_FILTER_200K   = 0x4,
    
    SIF_DEMOD1_FILTER_BUTT      
} SIF_FILTER1_E;

typedef enum hiSIF_DEVIATION1_E
{
    SIF_DEVIATION_50K        = 0x0,
    SIF_DEVIATION_100K       = 0x1,
    SIF_DEVIATION_384K       = 0x2,
    SIF_DEVIATION_540K       = 0x3,
    SIF_DEVIATION_200K       = 0x4,
    
    SIF_DEVIATION_BUTT
} SIF_DEVIATION1_E;

typedef enum hiSIF_CRG_DEMODE_CKSEL_E
{
    SIF_CRG_DEMODE_CKSEL_INTERL        = 0x0,
    SIF_CRG_DEMODE_CKSEL_EXTERNEL       = 0x1,    
    SIF_CRG_DEMODE_CKSEL_BUTT
} SIF_CRG_DEMODE_CKSEL_E;

typedef enum hiSIF_CRG_DEMODE_FSCLKDIV_E
{
    SIF_CRG_DEMODE_FSCLKDIV_16       = 0x0,
    SIF_CRG_DEMODE_FSCLKDIV_32       = 0x1,    
    SIF_CRG_DEMODE_FSCLKDIV_48       = 0x2,    
    SIF_CRG_DEMODE_FSCLKDIV_64       = 0x3,    
    SIF_CRG_DEMODE_FSCLKDIV_128      = 0x4,    
    SIF_CRG_DEMODE_FSCLKDIV_256      = 0x5,    
    SIF_CRG_DEMODE_FSCLKDIV_BUTT
} SIF_CRG_DEMODE_FSCLKDIV_E;

typedef enum hiSIF_CRG_DEMODE_BCLKDIV_E
{
    SIF_CRG_DEMODE_BCLKDIV_1    = 0x0,
    SIF_CRG_DEMODE_BCLKDIV_3    = 0x1,    
    SIF_CRG_DEMODE_BCLKDIV_2    = 0x2,    
    SIF_CRG_DEMODE_BCLKDIV_4    = 0x3,    
    SIF_CRG_DEMODE_BCLKDIV_6    = 0x4,    
    SIF_CRG_DEMODE_BCLKDIV_8    = 0x5,    
    SIF_CRG_DEMODE_BCLKDIV_12   = 0x6,    
    SIF_CRG_DEMODE_BCLKDIV_16   = 0x7,    
    SIF_CRG_DEMODE_BCLKDIV_24   = 0x8, 
    SIF_CRG_DEMODE_BCLKDIV_32   = 0x9,    
    SIF_CRG_DEMODE_BCLKDIV_48   = 0xa,    
    SIF_CRG_DEMODE_BCLKDIV_64   = 0xb,  
    SIF_CRG_DEMODE_BCLKDIV_BUTT
} SIF_CRG_DEMODE_BCLKDIV_E;

/******************************************************************************************************
**********************************************Proc Parameters******************************************
*******************************************************************************************************/
typedef struct hiSIF_HAL_ATTR_S
{
    HI_BOOL                     bASDEn;       /*0x00,Automatic System Detection */
    SIF_ASDCTL_65M_E            enASD65CTL;   /*0x80,6.5 MHz Carrier Interpretation */
    SIF_ASDCTL_45M_E            enASD45CTL;   /*0x80,4.5 MHz Carrier Interpretation */
    SIF_SYS_SEL_E               enSysSel;     /*0x00, if bASDEn = true, please set this attr*/
    HI_BOOL                     bBTSCSap;

    SIF_SAMPLE_RATE_E           enSmpRate;    /*0x02,set sample rate*/
        
    HI_BOOL                     bAAOSEn;      /*0x09,AAOS enalbe,Automatic Audio Output Selection */
    SIF_AAOS_OUTMODE_E          L_output;     /*0x09, if bAAOSEn = true, please set this attr*/
    SIF_AAOS_OUTMODE_E          R_output;     /*0x09, if bAAOSEn = true, please set this attr*/
    
    SIF_ASCS_CHGMODE_E          enASCSChgMode;/*ASCS Change Mode, SysSel changes automatically*/
    SIF_ASCS_MODE_E             enASCSCtl;    /*0x2e,Stereo search enable*/
    
    SIF_FILTER1_E               enFlt1;       /*0x06, set filter mode*/
    SIF_DEVIATION1_E            enDeviation1; /*0x06,set deviation*/
    SIF_DEMOD1_CARRI_FREQ_E     enCrriFreq1;
    SIF_DEMOD2_CARRI_FREQ_E     enCrriFreq2;
    SIF_DEMOD1_MODE_E           enDemulaMode; /*set demodulator mode,FM/AM*/
    HI_U32                      u32QualValue;
    HI_U32                      u32CarriShiftValue;

    HI_BOOL                     bMuteEn;
    HI_BOOL                     bMuteL;
    HI_BOOL                     bMuteR;

    HI_BOOL                     bAutoMute;

    HI_U32                   u32FreqError;
} SIF_HAL_ATTR_S;

HI_S32  SIF_HAL_Init(HI_VOID);
HI_S32  SIF_HAL_DeInit(HI_VOID);
HI_BOOL SIF_HAL_GetIntRaw(HI_VOID);
HI_BOOL SIF_HAL_GetIntStatus(HI_VOID);
HI_VOID SIF_HAL_SetIntEn(HI_BOOL bEn);
HI_VOID SIF_HAL_SetIntClr(HI_VOID);
HI_VOID SIF_HAL_ASDEn(HI_BOOL bEnable);
HI_VOID SIF_HAL_SetSysSel(SIF_SYS_SEL_E enValue);
HI_U32  SIF_HAL_GetDetStandard(HI_VOID);
HI_VOID SIF_HAL_SetBTSCSap(SIF_STAND_SEL_E enValue);
HI_VOID SIF_HAL_SetSampleRate(SIF_SAMPLE_RATE_E enValue);
HI_VOID SIF_HAL_SetASDCtl45(SIF_ASDCTL_45M_E enValue);
HI_VOID SIF_HAL_SetASDCtl65(SIF_ASDCTL_65M_E enValue);
HI_BOOL SIF_HAL_IsAAOSMute(HI_VOID);
HI_BOOL SIF_HAL_IsASDMute(HI_VOID);
HI_BOOL SIF_HAL_IsLeftMute(HI_VOID);
HI_BOOL SIF_HAL_IsRightMute(HI_VOID);
HI_VOID SIF_HAL_SetMuteAuto(HI_BOOL bEn);
HI_BOOL SIF_HAL_IsMuteAuto(HI_VOID);
HI_VOID SIF_HAL_SetMuteLeft(HI_BOOL bmute);
HI_VOID SIF_HAL_SetMuteRight(HI_BOOL bmute);
HI_VOID SIF_HAL_SetAscsDK1Skip(HI_BOOL bSkip);
HI_VOID SIF_HAL_SetAscsDK2Skip(HI_BOOL bSkip);
HI_VOID SIF_HAL_SetAscsDK3Skip(HI_BOOL bSkip);
HI_VOID SIF_HAL_SetAscsChgMod(SIF_ASCS_CHGMODE_E enValue);
HI_VOID SIF_HAL_SetAscsEn(SIF_ASCS_MODE_E enValue);
HI_VOID SIF_HAL_SetLOR(HI_BOOL bLOutR);
HI_VOID SIF_HAL_SetROL(HI_BOOL bROutL);
HI_VOID SIF_HAL_SetLRSum(HI_BOOL bLRSum);
HI_VOID SIF_HAL_AAOSEn(HI_BOOL bAAOSAutoEn);
HI_VOID SIF_HAL_SetAAOSLfSel(SIF_AAOS_OUTMODE_E enAAOSMode);
HI_VOID SIF_HAL_SetAAOSRtSel(SIF_AAOS_OUTMODE_E enAAOSMode);
HI_BOOL SIF_HAL_GetAAOSEn(HI_VOID);
SIF_AAOS_OUTMODE_E SIF_HAL_GetAAOSLfSel(HI_VOID);
SIF_AAOS_OUTMODE_E SIF_HAL_GetAAOSRtSel(HI_VOID);
SIF_AUDMODE_DET_E SIF_HAL_GetAudModDet(HI_VOID);
HI_BOOL SIF_HAL_IsASDComplete(HI_VOID);
HI_BOOL SIF_HAL_IsBiSAP(HI_VOID);
HI_BOOL SIF_HAL_IsNICAMMono(HI_VOID);
HI_BOOL SIF_HAL_IsStereo(HI_VOID);
SIF_ANADIG_STATUS_E SIF_HAL_GetAnaDigStatus(HI_VOID);
HI_BOOL SIF_HAL_IsPrmCarExist(HI_VOID);
HI_BOOL SIF_HAL_IsSecCarExist(HI_VOID);
SIF_ASCS_RESULT_E SIF_HAL_GetASCSResult(HI_VOID);
HI_BOOL SIF_HAL_IsASCSSearching(HI_VOID);
HI_BOOL SIF_HAL_IsASCSCompare(HI_VOID);
HI_BOOL SIF_HAL_IsASCSIndicator(HI_VOID);
HI_BOOL SIF_HAL_IsAAOSLOR(HI_VOID);
HI_BOOL SIF_HAL_IsAAOSROL(HI_VOID);
HI_BOOL SIF_HAL_IsAAOSLRSum(HI_VOID);
SIF_OUTMODE_E SIF_HAL_GetAAOSLfResult(HI_VOID);
SIF_OUTMODE_E SIF_HAL_GetAAOSRtResult(HI_VOID);
HI_BOOL SIF_HAL_GetPLLStatus(HI_VOID);
HI_BOOL SIF_HAL_GetFrameFlag(HI_VOID);
SIF_NICAM_CTRL_E SIF_HAL_GetNICAMCtrl(HI_VOID);
HI_BOOL SIF_HAL_IsNICAMDig(HI_VOID);
HI_VOID SIF_HAL_SetFilter1(SIF_FILTER1_E enFilter);
HI_VOID SIF_HAL_SetDeviation1(SIF_DEVIATION1_E enDeviation);
HI_VOID SIF_HAL_DemulatorMode(SIF_DEMOD1_MODE_E enMode);
HI_VOID SIF_HAL_SetDemodCarriFreq1(HI_U32 enCrriFreq1);
HI_VOID SIF_HAL_SetDemodCarriFreq2(HI_U32 enCrriFreq2);
HI_U32  SIF_HAL_GetQualityValue(HI_VOID);
HI_U32  SIF_HAL_GetCarrierShiftValue(HI_VOID);
HI_U32 SIF_HAL_GetPhaseValue(HI_VOID);
HI_U32 SIF_HAL_GetQuality1(HI_VOID);
HI_U32 SIF_HAL_GetQuality2(HI_VOID);
HI_U32 SIF_HAL_GetCarri1Freq(HI_VOID);
HI_U32 SIF_HAL_GetCarri12Freq(HI_VOID);
HI_VOID SIF_HAL_SetFreqErr(HI_U32 u32Value);
HI_U32 SIF_HAL_GetFreqErr(HI_U32 u32Value);

HI_S32 SIF_CRG_HAL_Init(HI_VOID);
HI_S32 SIF_CRG_HAL_DeInit(HI_VOID);
HI_S32 SIF_CRG_HAL_Reset(HI_VOID);
HI_S32 SIF_CRG_HAL_NoReset(HI_UNF_SIF_AIF_MODE_E enOpenParam);

//HI_U32 ADEMOD_DEBUG_MUTE(HI_VOID);

#ifdef __cplusplus
#if __cplusplus
}
#endif
#endif /* __cplusplus */

#endif/* __HAL_ADEMOD_H__ */

