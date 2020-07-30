/******************************************************************************
*
* Copyright (C) 2015 Hisilicon Technologies Co., Ltd.  All rights reserved.
*
* This program is confidential and proprietary to Hisilicon  Technologies Co., Ltd. (Hisilicon),
*  and may not be copied, reproduced, modified, disclosed to others, published or used, in
* whole or in part, without the express prior written permission of Hisilicon.
*
*****************************************************************************

  File Name     : drv_pq_proc.c
  Version       : Initial Draft
  Author        : p00203646
  Created       : 2015/09/22
  Author        : p00203646
******************************************************************************/
#include "hi_math.h"
#include "drv_pq.h"

#define  PQ_MODIFY_TIME     "(2016033101)"

extern HI_BOOL     g_bLoadPqBin;
extern PQ_PARAM_S* g_pstPqParam;
extern HI_DRV_PQ_PARAM_S stPqParam;

extern HI_U32   g_u32ImageWidth;
extern HI_U32   g_u32ImageHeight;
extern HI_U32   g_u32OutWidth;
extern HI_U32   g_u32OutHeight;

extern HI_U32 g_u32ColorTempR;
extern HI_U32 g_u32ColorTempG;
extern HI_U32 g_u32ColorTempB;

/*proc info struct*/
typedef struct hiPQ_PROC_INFO_S
{
    /* DEI FMD */
    HI_BOOL bDeiEn;
    HI_U32  u32DeiOutSel;
    HI_U32  u32DeiGloblGain;
    HI_S32  s32DeiDirMch;
    HI_S32  s32DeiFieldOrder;      /* ¶¥µ×³¡Ðò */
    HI_U32  u32DeiEdgeSmEn;
    /* ZME */
    HI_BOOL bVpssZmeFirEn;
    HI_BOOL bVdpZmeFirEn;
    HI_BOOL bVpssZmeMedEn;
    HI_BOOL bVdpZmeMedEn;
    /* SR */
    HI_BOOL bSrEn;
    HI_U32  u32SrMode;
    HI_U32  u32SrSharpStr;
    /* Dither Enable */
    HI_BOOL bDnrDithEn;
    HI_BOOL bVpssDithEn;
    HI_BOOL bVdpDithEn;
    /* DCI */
    HI_BOOL bDciEn;
    HI_U32  u32DciLevelGain;
    HI_U16  u16DciGain0;
    HI_U16  u16DciGain1;
    HI_U16  u16DciGain2;
    HI_U16  u16DciHStart;
    HI_U16  u16DciHEnd;
    HI_U16  u16DciVStart;
    HI_U16  u16DciVEnd;
    /* ACM */
    HI_BOOL bAcmEn;
    HI_U32  u32AcmLumaGain;
    HI_U32  u32AcmHueGain;
    HI_U32  u32AcmSatGain;
    HI_U32  u32ColorMode;
    HI_U32  u32FleshStr;
    /* DBDM/DBDR */
    HI_BOOL bDbEn;
    HI_BOOL bDmEn;
    HI_BOOL bDrEn;
    HI_U32  u32DbStr;
    HI_U32  u32DmStr;
    /* Deshoot */
    HI_BOOL bDeshootEn;
    HI_U32  u32DeshootMode;
    /* TNR */
    HI_BOOL bTnrEn;
    HI_U32  u32TnrStr;
    /* CSC */
    HI_PQ_VDP_CSC_S stCSC[HI_PQ_CSC_TYPE_BUUT];
} PQ_PROC_INFO_S;

#ifndef HI_ADVCA_FUNCTION_RELEASE

HI_U8* g_pPQProcSourceType[SOURCE_MODE_ALL] =
{
    "Unknown",
    "SD",
    "HD",
    "UHD",
};

#ifdef PQ_ALG_ACM
HI_U8* g_pPQProcFleshTone[FLE_GAIN_BUTT] =
{
    "off",
    "low",
    "middle",
    "high",
};

HI_U8* g_pPQProcEnhanceMode[COLOR_MODE_BUTT] =
{
    "optimal",
    "blue",
    "green",
    "bg",
};
#endif

#ifdef PQ_ALG_FMD
HI_U8* g_pPQProcFldMode[ALG_DEI_MODE_BUTT] =
{
    "5Field",
    "4Field",
    "3Field",
};
#endif

#ifdef PQ_ALG_CSC
HI_U8* g_pPQProcCSC[HI_PQ_CSC_BUTT + 1] =
{
    "YCbCr_601 LIMIT-> RGB",
    "YCbCr_709 LIMIT-> RGB",
    "RGB->YCbCr_601 LIMIT",
    "RGB->YCbCr_709 LIMIT",
    "YCbCr_709 LIMIT->YCbCr_601 LIMIT",
    "YCbCr_601 LIMIT->YCbCr_709 LIMIT",
    "YCbCr LIMIT->YCbCr LIMIT",

    "RGB_709 -> RGB_2020",
    "RGB_2020 -> YUV_2020 LIMIT",
    "RGB_2020 -> RGB_709",
    "RGB_2020 -> YUV_601 LIMIT",

    "RGB_601 -> RGB_2020",
    "RGB_2020 -> RGB_601",
    "RGB_2020 -> YUV_601 LIMIT",

    "YUV_709 LIMIT-> YUV_2020 LIMIT",
    "YUV_709 LIMIT-> RGB_2020",

    "YUV_601 LIMIT-> YUV_2020 LIMIT",
    "YUV_601 LIMIT-> RGB_2020",

    "YUV_2020 LIMIT -> YUV_2020 LIMIT",
    "YUV_2020 LIMIT -> YUV_709 LIMIT",
    "YUV_2020 LIMIT -> YUV_601 LIMIT",
    "YUV_2020 LIMIT -> RGB_2020",
    "YUV_2020 LIMIT -> RGB_709",

    "YUV_601 FULL-> RGB",
    "YUV_709 FULL-> RGB",
    "RGB->YUV_601 FULL",
    "RGB->YUV_709 FULL",
    "RGB->RGB",

    "NULL",
};
#endif


#endif

static HI_S32 DRV_PQ_SetTunMode(PQ_TUN_MODE_E enTunMode)
{
    HI_U32 i;

    for (i = 0; i < HI_PQ_MODULE_BUTT; i++)
    {
        if (GET_ALG(i) && GET_ALG_FUN(i)->SetTunMode)
        {
            GET_ALG_FUN(i)->SetTunMode(enTunMode);
        }
    }

    return HI_SUCCESS;
}

HI_S32 DRV_PQ_ProcRead(struct seq_file* s, HI_VOID* data)
{

#ifndef HI_ADVCA_FUNCTION_RELEASE

    HI_BOOL bEableEn    = HI_FALSE;
    HI_BOOL bDemoEn     = HI_FALSE;
    HI_BOOL u32Strength = 0;
    PQ_DEMO_MODE_E enDemoMode = PQ_DEMO_ENABLE_L;
    HI_U32 u32SizeOfPqParam = sizeof(PQ_PARAM_S);
    HI_S32 i = 0;
    HI_VDP_CHANNEL_TIMING_S  stHDTimingInfo = g_stPqStatus.stTimingInfo[HI_PQ_DISPLAY_1];
    HI_VDP_CHANNEL_TIMING_S  stSDTimingInfo = g_stPqStatus.stTimingInfo[HI_PQ_DISPLAY_0];
    PQ_PROC_INFO_S stProcInfo;
#ifdef PQ_ALG_FMD
    HI_S32 s32DeiMdLum = 0;
    HI_PQ_IFMD_PLAYBACK_S stIfmdPlayBack = {0};
#endif

    memset(&stProcInfo, 0, sizeof(PQ_PROC_INFO_S));

    PROC_PRINT(s, "================================ PQ Bin Information =================================\n");
    PROC_PRINT(s, "%-20s: %s %s\n", "Driver version", "PQ_V4_0"PQ_MODIFY_TIME, "[Build Time:"__DATE__", "__TIME__"]");
    PROC_PRINT(s, "%-20s: %s\n", "PQ Bin version", PQ_VERSION);
    PROC_PRINT(s, "%-20s: %d\n", "PQ Bin size", u32SizeOfPqParam);

    if (HI_FALSE == g_bLoadPqBin)
    {
        PROC_PRINT(s, "%-20s: failure\n", "PQ Bin Load");
    }
    else
    {
        PROC_PRINT(s, "%-20s: success\n", "PQ Bin Load");
        PROC_PRINT(s, "%-20s: %s\n", "PQ Bin version", g_pstPqParam->stPQFileHeader.u8Version);
        PROC_PRINT(s, "%-20s: %s\n", "PQ Bin chipname", g_pstPqParam->stPQFileHeader.u8ChipName);
        PROC_PRINT(s, "%-20s: %s\n", "PQ Bin SDK version", g_pstPqParam->stPQFileHeader.u8SDKVersion);
        PROC_PRINT(s, "%-20s: %s\n", "PQ Bin author", g_pstPqParam->stPQFileHeader.u8Author);
        PROC_PRINT(s, "%-20s: %s\n", "PQ Bin describe", g_pstPqParam->stPQFileHeader.u8Desc);
        PROC_PRINT(s, "%-20s: %s\n", "PQ Bin time", g_pstPqParam->stPQFileHeader.u8Time);
    }

    PROC_PRINT(s, "================================ Picture Information ================================\n");
    PROC_PRINT(s, "%-20s: %-20d", "HD brightness", NUM2LEVEL(stPqParam.stHDVideoSetting.u16Brightness));
    PROC_PRINT(s, "%-20s: %-20d\n", "SD brightness", NUM2LEVEL(stPqParam.stSDVideoSetting.u16Brightness));
    PROC_PRINT(s, "%-20s: %-20d", "HD contrast", NUM2LEVEL(stPqParam.stHDVideoSetting.u16Contrast));
    PROC_PRINT(s, "%-20s: %-20d\n", "SD contrast", NUM2LEVEL(stPqParam.stSDVideoSetting.u16Contrast));
    PROC_PRINT(s, "%-20s: %-20d", "HD hue", NUM2LEVEL(stPqParam.stHDVideoSetting.u16Hue));
    PROC_PRINT(s, "%-20s: %-20d\n", "SD hue", NUM2LEVEL(stPqParam.stSDVideoSetting.u16Hue));
    PROC_PRINT(s, "%-20s: %-20d", "HD saturation", NUM2LEVEL(stPqParam.stHDVideoSetting.u16Saturation));
    PROC_PRINT(s, "%-20s: %-20d\n", "SD saturation", NUM2LEVEL(stPqParam.stSDVideoSetting.u16Saturation));
    PROC_PRINT(s, "%-20s: %-20s\n", "3D type", g_stPqStatus.b3dType ? "yes" : "no");
    PROC_PRINT(s, "%-20s: %s (%d*%d)\n", "Source", g_pPQProcSourceType[g_u32SourceMode], g_u32ImageWidth, g_u32ImageHeight);
    PROC_PRINT(s, "%-20s: %4d*%4d, progressive:%d, refresh rate:%d\n", "HD output", stHDTimingInfo.stFmtRect.s32Width,
               stHDTimingInfo.stFmtRect.s32Height, stHDTimingInfo.bProgressive, stHDTimingInfo.u32RefreshRate / 100);
    PROC_PRINT(s, "%-20s: %4d*%4d, progressive:%d, refresh rate:%d\n", "SD output", stSDTimingInfo.stFmtRect.s32Width,
               stSDTimingInfo.stFmtRect.s32Height, stSDTimingInfo.bProgressive, stSDTimingInfo.u32RefreshRate / 100);

    PROC_PRINT(s, "================================ Algorithm Information ==============================\n");

    for (i = 0; i < HI_PQ_MODULE_BUTT; i++)
    {
        if (HI_NULL == GET_ALG(i))
        {
            continue;
        }

        PROC_PRINT(s, "------------------------------------ %s ------------------------------------\n", PQ_COMM_GetAlgName(i));
        if (REG_TYPE_VPSS == PQ_COMM_GetAlgTypeID(i))
        {
            PROC_PRINT(s, "%-20s: %-20s", "bind to", "vpss");
        }
        else if (REG_TYPE_VDP == PQ_COMM_GetAlgTypeID(i))
        {
            PROC_PRINT(s, "%-20s: %-20s", "bind to", "vdp");
        }

        if (GET_ALG_FUN(i)->GetEnable)
        {
            GET_ALG_FUN(i)->GetEnable(&bEableEn);
            PROC_PRINT(s, "%-20s: %-20s\n", "module", bEableEn ? "on" : "off");
        }

        if (GET_ALG_FUN(i)->GetStrength)
        {
            GET_ALG_FUN(i)->GetStrength(&u32Strength);
            PROC_PRINT(s, "%-20s: %-20d", "strength", u32Strength);
        }

        if (GET_ALG_FUN(i)->GetDemo)
        {
            GET_ALG_FUN(i)->GetDemo(&bDemoEn);
            PROC_PRINT(s, "%-20s: %-20s\n", "demo", bDemoEn ? "on" : "off");
            if (bDemoEn && GET_ALG_FUN(i)->GetDemoMode)
            {
                GET_ALG_FUN(i)->GetDemoMode(&enDemoMode);
                PROC_PRINT(s, "%-20s: %-20s\n", "demo mode", enDemoMode ? "enable right" : "enable left");
            }
        }
        else if (REG_TYPE_BUTT != PQ_COMM_GetAlgTypeID(i)
                 || GET_ALG_FUN(i)->GetEnable
                 || GET_ALG_FUN(i)->GetStrength)
        {
            PROC_PRINT(s, "\n");
        }

#ifdef PQ_ALG_ACM
        if (i == HI_PQ_MODULE_COLOR)
        {
            DRV_PQ_GetColorEnhanceMode(&(stProcInfo.u32ColorMode));
            DRV_PQ_GetFleshToneLevel(&(stProcInfo.u32FleshStr));

            PROC_PRINT(s, "%-20s: %-20s", "enhance mode", g_pPQProcEnhanceMode[stProcInfo.u32ColorMode]);
            PROC_PRINT(s, "%-20s: %s\n", "flesh tone level", g_pPQProcFleshTone[stProcInfo.u32FleshStr]);
        }
#endif

#ifdef PQ_ALG_CSC
        if (i == HI_PQ_MODULE_CSC)
        {
            if (GET_ALG_FUN(i)->GetCSCMode == HI_NULL)
            {
                continue;
            }

            GET_ALG_FUN(i)->GetCSCMode(HI_PQ_CSC_TUNING_V0, &stProcInfo.stCSC[HI_PQ_CSC_TUNING_V0]);
            GET_ALG_FUN(i)->GetCSCMode(HI_PQ_CSC_TUNING_V1, &stProcInfo.stCSC[HI_PQ_CSC_TUNING_V1]);
            GET_ALG_FUN(i)->GetCSCMode(HI_PQ_CSC_TUNING_V3, &stProcInfo.stCSC[HI_PQ_CSC_TUNING_V3]);
            GET_ALG_FUN(i)->GetCSCMode(HI_PQ_CSC_TUNING_V4, &stProcInfo.stCSC[HI_PQ_CSC_TUNING_V4]);

            PROC_PRINT(s, "%-10s: %-20s", "V0 enable", stProcInfo.stCSC[HI_PQ_CSC_TUNING_V0].bCSCEn  ? "on" : "off");
            PROC_PRINT(s, "%-10s: %-40s\n", "CSC mode", g_pPQProcCSC[stProcInfo.stCSC[HI_PQ_CSC_TUNING_V0].enCscMode]);
            PROC_PRINT(s, "%-10s: %-20s", "V1 enable", stProcInfo.stCSC[HI_PQ_CSC_TUNING_V1].bCSCEn  ? "on" : "off");
            PROC_PRINT(s, "%-10s: %-40s\n", "CSC mode", g_pPQProcCSC[stProcInfo.stCSC[HI_PQ_CSC_TUNING_V1].enCscMode]);
            PROC_PRINT(s, "%-10s: %-20s", "V3 enable", stProcInfo.stCSC[HI_PQ_CSC_TUNING_V3].bCSCEn  ? "on" : "off");
            PROC_PRINT(s, "%-10s: %-40s\n", "CSC mode", g_pPQProcCSC[stProcInfo.stCSC[HI_PQ_CSC_TUNING_V3].enCscMode]);
            PROC_PRINT(s, "%-10s: %-20s", "V4 Enable", stProcInfo.stCSC[HI_PQ_CSC_TUNING_V4].bCSCEn  ? "on" : "off");
            PROC_PRINT(s, "%-10s: %-40s\n", "CSC mode", g_pPQProcCSC[stProcInfo.stCSC[HI_PQ_CSC_TUNING_V4].enCscMode]);
        }
#endif

#ifdef PQ_ALG_ZME
        if (i == HI_PQ_MODULE_ZME)
        {
            if (GET_ALG_FUN(i)->GetZmeEnMode == HI_NULL)
            {
                continue;
            }

            GET_ALG_FUN(HI_PQ_MODULE_ZME)->GetZmeEnMode(PQ_ZME_MODE_VPSS_FIR, &(stProcInfo.bVpssZmeFirEn));
            GET_ALG_FUN(HI_PQ_MODULE_ZME)->GetZmeEnMode(PQ_ZME_MODE_VPSS_MED, &(stProcInfo.bVpssZmeMedEn));
            GET_ALG_FUN(HI_PQ_MODULE_ZME)->GetZmeEnMode(PQ_ZME_MODE_VDP_FIR, &(stProcInfo.bVdpZmeFirEn));
            GET_ALG_FUN(HI_PQ_MODULE_ZME)->GetZmeEnMode(PQ_ZME_MODE_VDP_MED, &(stProcInfo.bVdpZmeMedEn));

            PROC_PRINT(s, "%-20s: %-20s", "vpss fir/copy mode", stProcInfo.bVpssZmeFirEn ? "fir" : "copy");
            PROC_PRINT(s, "%-20s: %-20s\n", "vpss med enable", stProcInfo.bVpssZmeMedEn ? "on" : "off");
            PROC_PRINT(s, "%-20s: %-20s", "vdp fir/copy mode", stProcInfo.bVdpZmeFirEn ? "fir" : "copy");
            PROC_PRINT(s, "%-20s: %-20s\n", "vdp med enable", stProcInfo.bVdpZmeMedEn ? "on" : "off");
        }
#endif

#ifdef PQ_ALG_FMD
        if (i == HI_PQ_MODULE_FMD)
        {
            if (GET_ALG_FUN(i)->GetIfmdDectInfo)
            {
                GET_ALG_FUN(i)->GetIfmdDectInfo(&stIfmdPlayBack);
                PROC_PRINT(s, "%-20s: %-20s", "fir/copy mode", stIfmdPlayBack.die_out_sel ? "copy" : "fir");
                PROC_PRINT(s, "%-20s: %-20d\n", "dir mch", stIfmdPlayBack.dir_mch);
                PROC_PRINT(s, "%-20s: %-20s", "field order", stIfmdPlayBack.s32FieldOrder ? "bottom first" : "top first");
                PROC_PRINT(s, "%-20s: %-20s\n", "edge smooth", stIfmdPlayBack.u32EdgeSmoothEn ? "enable" : "disable");
            }

            if (GET_ALG_FUN(i)->GetDeiMdLum)
            {
                s32DeiMdLum = GET_ALG_FUN(i)->GetDeiMdLum();
                PROC_PRINT(s, "%-20s: %-20s\n", "field mode", g_pPQProcFldMode[(ALG_DEI_MODE_E)s32DeiMdLum]);
            }
        }
#endif

    }

#if 0
    PQ_PROC_INFO_S stProcInfo;
    HI_PQ_IFMD_PLAYBACK_S stIfmdInfo;

    memset(&stProcInfo, 0, sizeof(PQ_PROC_INFO_S));
    memset(&stIfmdInfo, 0, sizeof(HI_PQ_IFMD_PLAYBACK_S));

    /* DEI And Fmd */
    PQ_HAL_GetDeiEn(0, &(stProcInfo.bDeiEn));
    PQ_MNG_GetGlobMotiGain(&(stProcInfo.u32DeiGloblGain));
    PQ_MNG_GetIfmdDectInfo((REG_PLAYBACK_CONFIG_S*)(&stIfmdInfo));
    stProcInfo.u32DeiOutSel     = stIfmdInfo.die_out_sel;
    stProcInfo.s32DeiDirMch     = stIfmdInfo.dir_mch;
    stProcInfo.s32DeiFieldOrder = stIfmdInfo.s32FieldOrder;
    stProcInfo.u32DeiEdgeSmEn   = stIfmdInfo.u32EdgeSmoothEn;
    /* Zme */
    PQ_MNG_GetVdpZmeFirEn(&(stProcInfo.bVdpZmeFirEn));
    PQ_MNG_GetVdpZmeMedEn(&(stProcInfo.bVdpZmeMedEn));
    PQ_MNG_GetVpssZmeFirEn(&(stProcInfo.bVpssZmeFirEn));
    PQ_MNG_GetVpssZmeMedEn(&(stProcInfo.bVdpZmeMedEn));

    /* Dci */
    PQ_HAL_GetDCIWindow(&(stProcInfo.u16DciHStart), &(stProcInfo.u16DciHEnd), &(stProcInfo.u16DciVStart), &(stProcInfo.u16DciVEnd));
    PQ_HAL_GetDCIlevel(VDP_LAYER_VP0, &(stProcInfo.u16DciGain0), &(stProcInfo.u16DciGain1), &(stProcInfo.u16DciGain2));
    PQ_MNG_GetDCILevelGain(&stProcInfo.u32DciLevelGain);

    /* Acm */
    PQ_HAL_GetACMGain(VDP_LAYER_VP0, &(stProcInfo.u32AcmLumaGain), &(stProcInfo.u32AcmHueGain), &(stProcInfo.u32AcmSatGain));
    PQ_MNG_GetColorEnhanceMode(&(stProcInfo.u32ColorMode));/* prinrk Word, Not Number(Use enum) */
    PQ_MNG_GetFleshToneLevel(&(stProcInfo.u32FleshStr));

    /* DBDM/DBDR */
    DRV_PQ_GetPQModule(HI_PQ_MODULE_DB, &(stProcInfo.bDbEn));
    DRV_PQ_GetPQModule(HI_PQ_MODULE_DM, &(stProcInfo.bDmEn));

    /* SR */
    DRV_PQ_GetPQModule(HI_PQ_MODULE_SR, &(stProcInfo.bSrEn));
    PQ_HAL_GetSRSharpStr(VDP_LAYER_VID0, &(stProcInfo.u32SrSharpStr));
    DRV_PQ_GetSRMode(&(stProcInfo.u32SrMode));/* prinrk Word, Not Number(Use enum) */

    /* Dither */
    PQ_HAL_GetVpssDitherEn(0, &(stProcInfo.bVpssDithEn));
    PQ_HAL_GetDnrDitherEn(0, &(stProcInfo.bDnrDithEn));
    PQ_HAL_GetVdpDitherEn(&(stProcInfo.bVdpDithEn));

    /* CSC */
    PQ_MNG_GetCSCMode(HAL_DISP_LAYER_V0, &stProcInfo.stCSC[HAL_DISP_LAYER_V0]);
    PQ_MNG_GetCSCMode(HAL_DISP_LAYER_V1, &stProcInfo.stCSC[HAL_DISP_LAYER_V1]);
    PQ_MNG_GetCSCMode(HAL_DISP_LAYER_V3, &stProcInfo.stCSC[HAL_DISP_LAYER_V3]);
    PQ_MNG_GetCSCMode(HAL_DISP_LAYER_V4, &stProcInfo.stCSC[HAL_DISP_LAYER_V4]);


    PROC_PRINT(s, "================================ PQ Bin Information =================================\n");
    PROC_PRINT(s, "%-20s: %s\n", "PQ driver version", PQ_VERSION);
    PROC_PRINT(s, "%-20s: %d\n", "PQ Bin size", sizeof(PQ_PARAM_S));

    if (HI_FALSE == g_bLoadPqBin)
    {
        PROC_PRINT(s, "%-20s: failure\n", "PQ Bin Load");
    }
    else
    {
        PROC_PRINT(s, "%-20s: success\n", "PQ Bin Load");
        PROC_PRINT(s, "%-20s: %s\n", "PQ Bin version", g_pstPqParam->stPQFileHeader.u8Version);
        PROC_PRINT(s, "%-20s: %s\n", "PQ Bin chipname", g_pstPqParam->stPQFileHeader.u8ChipName);
        PROC_PRINT(s, "%-20s: %s\n", "PQ Bin SDK version", g_pstPqParam->stPQFileHeader.u8SDKVersion);
        PROC_PRINT(s, "%-20s: %s\n", "PQ Bin author", g_pstPqParam->stPQFileHeader.u8Author);
        PROC_PRINT(s, "%-20s: %s\n", "PQ Bin describe", g_pstPqParam->stPQFileHeader.u8Desc);
        PROC_PRINT(s, "%-20s: %s\n", "PQ Bin time", g_pstPqParam->stPQFileHeader.u8Time);
    }

    PROC_PRINT(s, "================================ Picture Information ================================\n");
    PROC_PRINT(s, "%-20s: %-20d", "HD brightness", NUM2LEVEL(stPqParam.stHDPictureSetting.u16Brightness));
    PROC_PRINT(s, "%-20s: %-20d\n", "SD brightness", NUM2LEVEL(stPqParam.stSDPictureSetting.u16Brightness));
    PROC_PRINT(s, "%-20s: %-20d", "HD contrast", NUM2LEVEL(stPqParam.stHDPictureSetting.u16Contrast));
    PROC_PRINT(s, "%-20s: %-20d\n", "SD contrast", NUM2LEVEL(stPqParam.stSDPictureSetting.u16Contrast));
    PROC_PRINT(s, "%-20s: %-20d", "HD hue", NUM2LEVEL(stPqParam.stHDPictureSetting.u16Hue));
    PROC_PRINT(s, "%-20s: %-20d\n", "SD hue", NUM2LEVEL(stPqParam.stSDPictureSetting.u16Hue));
    PROC_PRINT(s, "%-20s: %-20d", "HD saturation", NUM2LEVEL(stPqParam.stHDPictureSetting.u16Saturation));
    PROC_PRINT(s, "%-20s: %-20d\n", "SD saturation", NUM2LEVEL(stPqParam.stSDPictureSetting.u16Saturation));

    PROC_PRINT(s, "%-20s: %d\n", "sharpness", stPqParam.u32Strength[HI_PQ_MODULE_SHARPNESS]);
    PROC_PRINT(s, "%-20s: %d\n", "DCI gain", stPqParam.u32Strength[HI_PQ_MODULE_DCI]);
    PROC_PRINT(s, "%-20s: %s\n", "flesh tone level", g_pPQProcFleshTone[stProcInfo.u32FleshStr]);
    PROC_PRINT(s, "%-20s: %s (%d*%d)\n", "source", g_pPQProcSourceType[sg_u32SourceMode], sg_u32ImageWidth, sg_u32ImageHeight);
    PROC_PRINT(s, "%-20s: %s (%d*%d)\n", "output", g_pPQProcSourceType[sg_u32OutputMode], sg_u32OutWidth, sg_u32OutHeight);


    PROC_PRINT(s, "================================ Algorithm Information ==============================\n");
    PROC_PRINT(s, "-------------------------------------- DEI/FMD ------------------------------------\n");
    PROC_PRINT(s, "%-20s: %-20s", "module", stProcInfo.bDeiEn ? "on" : "off");
    PROC_PRINT(s, "%-20s: %-20s\n", "demo", stPqParam.bDemoOnOff[HI_PQ_MODULE_DEI] ? "on" : "off");
    PROC_PRINT(s, "%-20s: %-20s", "fir/copy mode", stProcInfo.u32DeiOutSel ? "copy" : "fir");
    PROC_PRINT(s, "%-20s: %-20d\n", "global motion gain", stProcInfo.u32DeiGloblGain);
    PROC_PRINT(s, "%-20s: %-20d", "dir mch", stProcInfo.s32DeiDirMch);
    PROC_PRINT(s, "%-20s: %-20s\n", "field order", stProcInfo.s32DeiFieldOrder ? "bottom first" : "top first");
    PROC_PRINT(s, "%-20s: %-20s", "edge smooth", stProcInfo.u32DeiEdgeSmEn ? "enable" : "disable");
    PROC_PRINT(s, "%-20s: %-20s\n", "field mode", g_pPQProcFldMode[(ALG_DEI_MODE_E)PQ_MNG_GetDeiMdLum()]);

    PROC_PRINT(s, "--------------------------------------- ZME ---------------------------------------\n");
    PROC_PRINT(s, "%-20s: %-20s", "vpss fir/copy mode", stProcInfo.bVpssZmeFirEn ? "fir" : "copy");
    PROC_PRINT(s, "%-20s: %-20s\n", "vpss med enable", stProcInfo.bVpssZmeMedEn ? "on" : "off");
    PROC_PRINT(s, "%-20s: %-20s", "vdp fir/copy mode", stProcInfo.bVdpZmeFirEn ? "fir" : "copy");
    PROC_PRINT(s, "%-20s: %-20s\n", "vdp med enable", stProcInfo.bVdpZmeMedEn ? "on" : "off");


    PROC_PRINT(s, "--------------------------------------- DCI ---------------------------------------\n");
    PROC_PRINT(s, "%-20s: %-20s", "module", stPqParam.bModuleOnOff[HI_PQ_MODULE_DCI] ? "on" : "off");
    PROC_PRINT(s, "%-20s: %-20s\n", "demo", stPqParam.bDemoOnOff[HI_PQ_DEMO_DCI] ? "on" : "off");
    PROC_PRINT(s, "%-20s: %-20d", "h start", stProcInfo.u16DciHStart);
    PROC_PRINT(s, "%-20s: %-20d\n", "h end", stProcInfo.u16DciHEnd);
    PROC_PRINT(s, "%-20s: %-20d", "v start", stProcInfo.u16DciVStart);
    PROC_PRINT(s, "%-20s: %-20d\n", "v end", stProcInfo.u16DciVEnd);
    PROC_PRINT(s, "%-20s: %-20d", "gain 0", stProcInfo.u16DciGain0);
    PROC_PRINT(s, "%-20s: %-20d\n", "gain 1", stProcInfo.u16DciGain1);
    PROC_PRINT(s, "%-20s: %-20d", "gain 2", stProcInfo.u16DciGain2);
    PROC_PRINT(s, "%-40s\n", "");

    PROC_PRINT(s, "-------------------------------------- DBDM ---------------------------------------\n");
    PROC_PRINT(s, "%-20s: %-20s", "DB module", stPqParam.bModuleOnOff[HI_PQ_MODULE_DB] ? "on" : "off");
    PROC_PRINT(s, "%-20s: %-20s\n", "demo", stPqParam.bDemoOnOff[HI_PQ_DEMO_DB] ? "on" : "off");
    PROC_PRINT(s, "%-20s: %-20s", "DM module", stPqParam.bModuleOnOff[HI_PQ_MODULE_DM] ? "on" : "off");
    PROC_PRINT(s, "%-20s: %-20s\n", "demo", stPqParam.bDemoOnOff[HI_PQ_DEMO_DM] ? "on" : "off");

    PROC_PRINT(s, "--------------------------------------- ACM ---------------------------------------\n");
    PROC_PRINT(s, "%-20s: %-20s", "module", stPqParam.bModuleOnOff[HI_PQ_MODULE_COLOR] ? "on" : "off");
    PROC_PRINT(s, "%-20s: %-20s\n", "demo", stPqParam.bDemoOnOff[HI_PQ_DEMO_COLOR] ? "on" : "off");
    PROC_PRINT(s, "%-20s: %-20s", "enhance mode", g_pPQProcEnhanceMode[stProcInfo.u32ColorMode]);
    PROC_PRINT(s, "%-20s: %-20d\n", "luma gain", stProcInfo.u32AcmLumaGain);
    PROC_PRINT(s, "%-20s: %-20d", "hue gain", stProcInfo.u32AcmHueGain);
    PROC_PRINT(s, "%-20s: %-20d\n", "sat gain", stProcInfo.u32AcmSatGain);

    PROC_PRINT(s, "--------------------------------------- SR ----------------------------------------\n");
    PROC_PRINT(s, "%-20s: %-20s", "module", stPqParam.bModuleOnOff[HI_PQ_MODULE_SR] ? "on" : "off");
    PROC_PRINT(s, "%-20s: %-20s\n", "demo", stPqParam.bDemoOnOff[HI_PQ_DEMO_SR] ? "on" : "off");
    PROC_PRINT(s, "%-20s: %-20s", "SR demo mode", g_pPQProcSRDemoMode[stProcInfo.u32SrMode]);
    PROC_PRINT(s, "%-20s: %-20d\n", "sharp strength", stProcInfo.u32SrSharpStr);

    PROC_PRINT(s, "-------------------------------------- Sharpn -------------------------------------\n");
    PROC_PRINT(s, "%-20s: %-20s", "module", stPqParam.bModuleOnOff[HI_PQ_MODULE_SHARPNESS] ? "on" : "off");
    PROC_PRINT(s, "%-20s: %-20s\n", "demo", stPqParam.bDemoOnOff[HI_PQ_DEMO_SHARPNESS] ? "on" : "off");

    PROC_PRINT(s, "--------------------------------------- CSC ---------------------------------------\n");
    PROC_PRINT(s, "%-10s: %-20s", "V0 enable", stProcInfo.stCSC[HAL_DISP_LAYER_V0].bCSCEn  ? "on" : "off");
    PROC_PRINT(s, "%-10s: %-40s\n", "CSC mode", g_pPQProcCSC[stProcInfo.stCSC[HAL_DISP_LAYER_V0].enCSC]);
    PROC_PRINT(s, "%-10s: %-20s", "V1 enable", stProcInfo.stCSC[HAL_DISP_LAYER_V1].bCSCEn  ? "on" : "off");
    PROC_PRINT(s, "%-10s: %-40s\n", "CSC mode", g_pPQProcCSC[stProcInfo.stCSC[HAL_DISP_LAYER_V1].enCSC]);
    PROC_PRINT(s, "%-10s: %-20s", "V2 enable", stProcInfo.stCSC[HAL_DISP_LAYER_V2].bCSCEn  ? "on" : "off");
    PROC_PRINT(s, "%-10s: %-40s\n", "CSC mode", g_pPQProcCSC[stProcInfo.stCSC[HAL_DISP_LAYER_V2].enCSC]);
    PROC_PRINT(s, "%-10s: %-20s", "V3 enable", stProcInfo.stCSC[HAL_DISP_LAYER_V3].bCSCEn  ? "on" : "off");
    PROC_PRINT(s, "%-10s: %-40s\n", "CSC mode", g_pPQProcCSC[stProcInfo.stCSC[HAL_DISP_LAYER_V3].enCSC]);
    PROC_PRINT(s, "%-10s: %-20s", "V4 Enable", stProcInfo.stCSC[HAL_DISP_LAYER_V4].bCSCEn  ? "on" : "off");
    PROC_PRINT(s, "%-10s: %-40s\n", "CSC mode", g_pPQProcCSC[stProcInfo.stCSC[HAL_DISP_LAYER_V4].enCSC]);

    PROC_PRINT(s, "--------------------------------------- TNR ---------------------------------------\n");
    PROC_PRINT(s, "%-20s: %-20s", "module", stPqParam.bModuleOnOff[HI_PQ_MODULE_TNR] ? "on" : "off");
    PROC_PRINT(s, "%-20s: %-20s\n", "demo", stPqParam.bDemoOnOff[HI_PQ_DEMO_TNR] ? "on" : "off");

    PROC_PRINT(s, "-------------------------------------- Dither -------------------------------------\n");
    PROC_PRINT(s, "%-20s: %-20s", "DNR dither", stProcInfo.bDnrDithEn  ? "enable" : "disable");
    PROC_PRINT(s, "%-20s: %-20s\n", "vpss dither", stProcInfo.bVpssDithEn  ? "enable" : "disable");
    PROC_PRINT(s, "%-20s: %-20s", "vdp dither", stProcInfo.bVdpDithEn  ? "enable" : "disable");
    PROC_PRINT(s, "%-40s\n", "");

    PROC_PRINT(s, "=====================================================================================\n");

#endif
#endif
    return HI_SUCCESS;
}

static HI_VOID DRV_PQ_ProcPrintHelp(HI_VOID)
{
#ifndef HI_ADVCA_FUNCTION_RELEASE

    HI_DRV_PROC_EchoHelper("\n");
    HI_DRV_PROC_EchoHelper("help message:\n");
    HI_DRV_PROC_EchoHelper("echo help                        > /proc/msp/pq\n");
    HI_DRV_PROC_EchoHelper("echo bright          <0~100>     > /proc/msp/pq\n");
    HI_DRV_PROC_EchoHelper("echo contrast        <0~100>     > /proc/msp/pq\n");
    HI_DRV_PROC_EchoHelper("echo hue             <0~100>     > /proc/msp/pq\n");
    HI_DRV_PROC_EchoHelper("echo satu            <0~100>     > /proc/msp/pq\n");
    HI_DRV_PROC_EchoHelper("echo mode            debug/normal     > /proc/msp/pq\n");
    HI_DRV_PROC_EchoHelper("echo scd/scenechange on/off           > /proc/msp/pq\n");
    HI_DRV_PROC_EchoHelper("echo printbin        <hex>/all/multi  > /proc/msp/pq\n");
    HI_DRV_PROC_EchoHelper("echo printalgbin     <0~20>           > /proc/msp/pq\n");
    HI_DRV_PROC_EchoHelper("echo printtype       <hex>            > /proc/msp/pq\n");
    HI_DRV_PROC_EchoHelper("echo printalgbin     <0~20>           > /proc/msp/pq\n");
    HI_DRV_PROC_EchoHelper("echo setbin          default          > /proc/msp/pq\n");
    HI_DRV_PROC_EchoHelper("echo setbin<list>    value            > /proc/msp/pq\n");
    HI_DRV_PROC_EchoHelper("echo sethdrcfg       default/debug    > /proc/msp/pq\n");
    HI_DRV_PROC_EchoHelper("echo colortemp       rrggbb           > /proc/msp/pq\n");
    HI_DRV_PROC_EchoHelper("echo fleshtone       off/low/mid/high           > /proc/msp/pq\n");
    HI_DRV_PROC_EchoHelper("echo colormode       blue/green/bg/optimal/off  > /proc/msp/pq\n");
    HI_DRV_PROC_EchoHelper("echo deimode         auto/fir/copy              > /proc/msp/pq\n");
    HI_DRV_PROC_EchoHelper("echo fodmode         auto/top1st/bottom1st      > /proc/msp/pq\n");
    HI_DRV_PROC_EchoHelper("echo deshoot         flat/medfir                > /proc/msp/pq\n");
    HI_DRV_PROC_EchoHelper("echo demomode        fixr/fixl/scrollr/scrolll  > /proc/msp/pq\n");
    HI_DRV_PROC_EchoHelper("echo zme             vdpfir/vdpcopy/vdpmedon/vdpmedoff            > /proc/msp/pq\n");
    HI_DRV_PROC_EchoHelper("echo zme             vpssfir/vpsscopy/vpssmedon/vpssmedoff        > /proc/msp/pq\n");
    HI_DRV_PROC_EchoHelper("echo sharp/dci/color/tnr/snr/dei/db/dm/all        <0~100>         > /proc/msp/pq\n");
    HI_DRV_PROC_EchoHelper("echo sharp/dci/color/tnr/snr/dei/db/dm/dr/ds/all  enable/disable  > /proc/msp/pq\n");
    HI_DRV_PROC_EchoHelper("echo sharp/dci/color/tnr/snr/dei/db/all           demoon/demooff  > /proc/msp/pq\n");

    HI_DRV_PROC_EchoHelper("\n");

#endif
}

static HI_S32 DRV_PQ_ProcParsePara(HI_CHAR* pProcPara, HI_CHAR** ppArg1, HI_CHAR** ppArg2)
{
    HI_CHAR* pChar = HI_NULL;

    if (strlen(pProcPara) == 0)
    {
        /* not fined arg1 and arg2, return failed */
        *ppArg1  = HI_NULL;
        *ppArg2  = HI_NULL;
        return HI_FAILURE;
    }

    /* find arg1 */
    pChar = pProcPara;
    while ( (*pChar == ' ') && (*pChar != '\0') )
    {
        pChar++;
    }

    if (*pChar != '\0')
    {
        *ppArg1 = pChar;
    }
    else
    {
        *ppArg1  = HI_NULL;

        return HI_FAILURE;
    }

    /* ignor arg1 */
    while ( (*pChar != ' ') && (*pChar != '\0') )
    {
        pChar++;
    }

    /* Not find arg2, return */
    if (*pChar == '\0')
    {
        *ppArg2 = HI_NULL;

        return HI_SUCCESS;
    }

    /* add '\0' for arg1 */
    *pChar = '\0';

    /* start to find arg2 */
    pChar = pChar + 1;
    while ( (*pChar == ' ') && (*pChar != '\0') )
    {
        pChar++;
    }

    if (*pChar != '\0')
    {
        *ppArg2 = pChar;
    }
    else
    {
        *ppArg2 = HI_NULL;
    }

    return HI_SUCCESS;
}

static HI_S32 DRV_PQ_ProcCmdProcess(HI_CHAR* pArg1, HI_CHAR* pArg2)
{
    HI_U32 u32Data = 0;
    HI_U32 u32Strength = 0;
    HI_PQ_MODULE_E enModule = HI_PQ_MODULE_BUTT;

    if ((pArg1 == HI_NULL) || (pArg2 == HI_NULL) )
    {
        return HI_FAILURE;
    }

    if (0 == HI_OSAL_Strncmp(pArg1, "bright", sizeof("bright")))
    {
        u32Data = (HI_U32)simple_strtol(pArg2, NULL, 10);
        DRV_PQ_SetSDBrightness(u32Data);
        DRV_PQ_SetHDBrightness(u32Data);
        return HI_SUCCESS;
    }
    else if (0 == HI_OSAL_Strncmp(pArg1, "contrast", sizeof("contrast")))
    {
        u32Data = (HI_U32)simple_strtol(pArg2, NULL, 10);
        DRV_PQ_SetSDContrast(u32Data);
        DRV_PQ_SetHDContrast(u32Data);
        return HI_SUCCESS;
    }
    else if (0 == HI_OSAL_Strncmp(pArg1, "hue", sizeof("hue")))
    {
        u32Data = (HI_U32)simple_strtol(pArg2, NULL, 10);
        DRV_PQ_SetSDHue(u32Data);
        DRV_PQ_SetHDHue(u32Data);
        return HI_SUCCESS;
    }
    else if (0 == HI_OSAL_Strncmp(pArg1, "satu", sizeof("satu")))
    {
        u32Data = (HI_U32)simple_strtol(pArg2, NULL, 10);
        DRV_PQ_SetSDSaturation(u32Data);
        DRV_PQ_SetHDSaturation(u32Data);
        return HI_SUCCESS;
    }
    else if (0 == HI_OSAL_Strncmp(pArg1, "demomode", sizeof("demomode")))
    {
        HI_PQ_DEMO_MODE_E enDemoMode = HI_PQ_DEMO_MODE_BUTT;
        if (0 == HI_OSAL_Strncmp(pArg2, "fixr", strlen("fixr")))
        {
            enDemoMode = HI_PQ_DEMO_MODE_FIXED_R;
        }
        else if (0 == HI_OSAL_Strncmp(pArg2, "fixl", strlen("fixl")))
        {
            enDemoMode = HI_PQ_DEMO_MODE_FIXED_L;
        }
        else if (0 == HI_OSAL_Strncmp(pArg2, "scrollr", strlen("scrollr")))
        {
            enDemoMode = HI_PQ_DEMO_MODE_SCROLL_R;
        }
        else if (0 == HI_OSAL_Strncmp(pArg2, "scrolll", strlen("scrolll")))
        {
            enDemoMode = HI_PQ_DEMO_MODE_SCROLL_L;
        }
        else if ((0 <= simple_strtol(pArg2, NULL, 10))
                 && (simple_strtol(pArg2, NULL, 10) <= 100))
        {
            DRV_PQ_SetDemoCoordinate(REG_TYPE_VPSS, simple_strtol(pArg2, NULL, 10));
            DRV_PQ_SetDemoCoordinate(REG_TYPE_VDP, simple_strtol(pArg2, NULL, 10));
            return HI_SUCCESS;
        }
        else
        {
            return HI_FAILURE;
        }

        DRV_PQ_SetDemoDispMode(REG_TYPE_VPSS, enDemoMode);
        DRV_PQ_SetDemoDispMode(REG_TYPE_VDP, enDemoMode);

        return HI_SUCCESS;
    }
    else if (0 == HI_OSAL_Strncmp(pArg1, "mode", sizeof("mode")))
    {
        if (0 == HI_OSAL_Strncmp(pArg2, "debug", strlen("debug")))
        {
            DRV_PQ_SetTunMode(PQ_TUN_DEBUG);
        }
        else if (0 == HI_OSAL_Strncmp(pArg2, "normal", strlen("normal")))
        {
            DRV_PQ_SetTunMode(PQ_TUN_NORMAL);
        }

        return HI_SUCCESS;
    }
    else if (0 == HI_OSAL_Strncmp(pArg1, "colormode", sizeof("colormode")))
    {
        HI_PQ_COLOR_SPEC_MODE_E enColorSpecMode;
        if (0 == HI_OSAL_Strncmp(pArg2, "blue", strlen("blue")))
        {
            enColorSpecMode = HI_PQ_COLOR_MODE_BLUE;
        }
        else if (0 == HI_OSAL_Strncmp(pArg2, "green", strlen("green")))
        {
            enColorSpecMode = HI_PQ_COLOR_MODE_GREEN;
        }
        else if (0 == HI_OSAL_Strncmp(pArg2, "bg", strlen("bg")))
        {
            enColorSpecMode = HI_PQ_COLOR_MODE_BG;
        }
        else if (0 == HI_OSAL_Strncmp(pArg2, "optimal", strlen("optimal")))
        {
            enColorSpecMode = HI_PQ_COLOR_MODE_RECOMMEND;
        }
        else if (0 == HI_OSAL_Strncmp(pArg2, "off", strlen("off")))
        {
            enColorSpecMode = HI_PQ_COLOR_MODE_ORIGINAL;
        }
        else
        {
            return HI_FAILURE;
        }

        return DRV_PQ_SetColorEnhanceMode(enColorSpecMode);
    }
    else if (0 == HI_OSAL_Strncmp(pArg1, "fleshtone", sizeof("fleshtone")))
    {
        HI_PQ_FLESHTONE_E enFleshToneLevel;
        if (0 == HI_OSAL_Strncmp(pArg2, "off", strlen("off")))
        {
            enFleshToneLevel = HI_PQ_FLESHTONE_GAIN_OFF;
        }
        else if (0 == HI_OSAL_Strncmp(pArg2, "low", strlen("low")))
        {
            enFleshToneLevel = HI_PQ_FLESHTONE_GAIN_LOW;
        }
        else if (0 == HI_OSAL_Strncmp(pArg2, "mid", strlen("mid")))
        {
            enFleshToneLevel = HI_PQ_FLESHTONE_GAIN_MID;
        }
        else if (0 == HI_OSAL_Strncmp(pArg2, "high", strlen("high")))
        {
            enFleshToneLevel = HI_PQ_FLESHTONE_GAIN_HIGH;
        }
        else
        {
            return HI_FAILURE;
        }

        return DRV_PQ_SetFleshToneLevel(enFleshToneLevel);
    }
    else if (0 == HI_OSAL_Strncmp(pArg1, "deimode", sizeof("deimode")))
    {
        HI_S32 s32Ret = HI_FAILURE;
        enModule = HI_PQ_MODULE_FMD;

        if ((HI_NULL == GET_ALG(enModule))
            || (HI_NULL == GET_ALG_FUN(enModule)->SetDeiOutMode))
        {
            return s32Ret;
        }

        if (0 == HI_OSAL_Strncmp(pArg2, "auto", strlen("auto")))
        {
            s32Ret = GET_ALG_FUN(enModule)->SetDeiOutMode(PQ_DIE_OUT_MODE_AUTO);
        }
        else if (0 == HI_OSAL_Strncmp(pArg2, "fir", strlen("fir")))
        {
            s32Ret = GET_ALG_FUN(enModule)->SetDeiOutMode(PQ_DIE_OUT_MODE_FIR);
        }
        else if (0 == HI_OSAL_Strncmp(pArg2, "copy", strlen("copy")))
        {
            s32Ret = GET_ALG_FUN(enModule)->SetDeiOutMode(PQ_DIE_OUT_MODE_COPY);
        }

        return s32Ret;
    }
    else if (0 == HI_OSAL_Strncmp(pArg1, "fodmode", sizeof("fodmode")))
    {
        HI_S32 s32Ret = HI_FAILURE;
        enModule = HI_PQ_MODULE_FMD;

        if ((HI_NULL == GET_ALG(enModule))
            || (HI_NULL == GET_ALG_FUN(enModule)->SetFodMode))
        {
            return s32Ret;
        }

        if (0 == HI_OSAL_Strncmp(pArg2, "auto", strlen("auto")))
        {
            s32Ret = GET_ALG_FUN(enModule)->SetFodMode(PQ_FOD_ENABLE_AUTO);
        }
        else if (0 == HI_OSAL_Strncmp(pArg2, "top1st", strlen("top1st")))
        {
            s32Ret = GET_ALG_FUN(enModule)->SetFodMode(PQ_FOD_TOP_FIRST);
        }
        else if (0 == HI_OSAL_Strncmp(pArg2, "bottom1st", strlen("bottom1st")))
        {
            s32Ret = GET_ALG_FUN(enModule)->SetFodMode(PQ_FOD_BOTTOM_FIRST);
        }

        return s32Ret;
    }
    else if (0 == HI_OSAL_Strncmp(pArg1, "printbin", sizeof("printbin")))
    {
        if (0 == HI_OSAL_Strncmp(pArg2, "all", strlen("all")))
        {
            PQ_MNG_PrintTable(PRN_TABLE_ALL, u32Data);
        }
        else if (0 == HI_OSAL_Strncmp(pArg2, "multi", strlen("multi")))
        {
            PQ_MNG_PrintTable(PRN_TABLE_MULTI, u32Data);
        }
        else
        {
            u32Data = (HI_U32)simple_strtol(pArg2, NULL, 16);
            PQ_MNG_PrintTable(PRN_TABLE_SINGLE, u32Data);
        }

        return HI_SUCCESS;
    }
    else if (0 == HI_OSAL_Strncmp(pArg1, "printalgbin", sizeof("printalgbin")))
    {
        u32Data = (HI_U32)simple_strtol(pArg2, NULL, 10);
        PQ_MNG_PrintTable(PRN_TABLE_ALG, u32Data);

        return HI_SUCCESS;
    }
    else if (0 == HI_OSAL_Strncmp(pArg1, "setbin", sizeof("setbin")))
    {
        if (0 == HI_OSAL_Strncmp(pArg2, "default", strlen("default")))
        {
            PQ_MNG_PrintTable(PRN_TABLE_SET_DEFAULT, 0);
            return HI_SUCCESS;
        }
        return HI_FAILURE;
    }
    else if ((0 == HI_OSAL_Strncmp(pArg1, "setbin", strlen("setbin")))
             && (strlen(pArg1) > strlen("setbin")))
    {
        HI_CHAR achList[8] = "\0";
        HI_U8  u8MinLen = MIN2((sizeof(achList) - 1), (strlen(pArg1) - strlen("setbin")));
        HI_U32 u32List  = 0;
        HI_U32 u32Value = 0;

        memcpy(achList, pArg1 + strlen("setbin") , u8MinLen);
        u32List = (HI_U32)simple_strtol(achList, NULL, 10);
        u32Value = (HI_U32)simple_strtol(pArg2, NULL, 10);

        PQ_MNG_SetTable(u32List, u32Value);
        return HI_SUCCESS;
    }
    else if (0 == HI_OSAL_Strncmp(pArg1, "sethdrcfg", sizeof("sethdrcfg")))
    {
        if (0 == HI_OSAL_Strncmp(pArg2, "default", strlen("default")))
        {
            if (GET_ALG(HI_PQ_MODULE_HDR) && (GET_ALG_FUN(HI_PQ_MODULE_HDR)->SetHdrCfg))
            {
                GET_ALG_FUN(HI_PQ_MODULE_HDR)->SetHdrCfg(HI_TRUE);
            }

            return HI_SUCCESS;
        }
        else if (0 == HI_OSAL_Strncmp(pArg2, "debug", strlen("debug")))
        {
            if (GET_ALG(HI_PQ_MODULE_HDR) && (GET_ALG_FUN(HI_PQ_MODULE_HDR)->SetHdrCfg))
            {
                GET_ALG_FUN(HI_PQ_MODULE_HDR)->SetHdrCfg(HI_FALSE);
            }

            return HI_SUCCESS;
        }

        return HI_FAILURE;
    }
    else if (0 == HI_OSAL_Strncmp(pArg1, "printtype", sizeof("printtype")))
    {

        u32Data = (HI_U32)simple_strtol(pArg2, NULL, 16);
        PQ_HAL_SetPrintType(u32Data);
        return HI_SUCCESS;
    }
    else if ((0 == HI_OSAL_Strncmp(pArg1, "scenechange", sizeof("scenechange")))
             || (0 == HI_OSAL_Strncmp(pArg1, "scd", sizeof("scd"))))
    {
        if (0 == HI_OSAL_Strncmp(pArg2, "on", strlen("on")))
        {
            if (GET_ALG(HI_PQ_MODULE_DCI) && (GET_ALG_FUN(HI_PQ_MODULE_DCI)->SetDciScd))
            {
                GET_ALG_FUN(HI_PQ_MODULE_DCI)->SetDciScd(HI_TRUE);
            }
        }
        else if (0 == HI_OSAL_Strncmp(pArg2, "off", strlen("off")))
        {
            if (GET_ALG(HI_PQ_MODULE_DCI) && (GET_ALG_FUN(HI_PQ_MODULE_DCI)->SetDciScd))
            {
                GET_ALG_FUN(HI_PQ_MODULE_DCI)->SetDciScd(HI_FALSE);
            }
        }
        else
        {
            return HI_FAILURE;
        }

        return HI_SUCCESS;
    }
    else if (0 == HI_OSAL_Strncmp(pArg1, "colortemp", sizeof("colortemp")))
    {
        HI_CHAR achList[8] = "\0";
        HI_U32 u32DateR, u32DateG, u32DateB;

        if (strlen(pArg2) - 1 != 6)
        {
            return HI_FAILURE;
        }

        memset(achList, 0, sizeof(achList));
        memcpy(achList, pArg2 , 2);
        u32DateR = (HI_U32)simple_strtol(achList, NULL, 10);

        memset(achList, 0, sizeof(achList));
        memcpy(achList, pArg2 + 2 , 2);
        u32DateG = (HI_U32)simple_strtol(achList, NULL, 10);

        memset(achList, 0, sizeof(achList));
        memcpy(achList, pArg2 + 4 , 2);
        u32DateB = (HI_U32)simple_strtol(achList, NULL, 10);

#ifndef HI_ADVCA_FUNCTION_RELEASE
        HI_DRV_PROC_EchoHelper("color temp: R=%d, G=%d, B=%d\n", u32DateR, u32DateG, u32DateB);
#endif
        g_u32ColorTempR = u32DateR;
        g_u32ColorTempG = u32DateG;
        g_u32ColorTempB = u32DateB;

        return HI_SUCCESS;
    }

    else if (0 == HI_OSAL_Strncmp(pArg1, "fmd", sizeof("fmd")))
    {
        enModule = HI_PQ_MODULE_FMD;
    }
    else if (0 == HI_OSAL_Strncmp(pArg1, "tnr", sizeof("tnr")))
    {
        enModule = HI_PQ_MODULE_TNR;
    }
    else if (0 == HI_OSAL_Strncmp(pArg1, "snr", sizeof("snr")))
    {
        enModule = HI_PQ_MODULE_SNR;
    }
    else if (0 == HI_OSAL_Strncmp(pArg1, "db", sizeof("db")))
    {
        enModule = HI_PQ_MODULE_DB;
    }
    else if (0 == HI_OSAL_Strncmp(pArg1, "dr", sizeof("dr")))
    {
        enModule = HI_PQ_MODULE_DR;
    }
    else if (0 == HI_OSAL_Strncmp(pArg1, "dm", sizeof("dm")))
    {
        enModule = HI_PQ_MODULE_DM;
    }
    else if (0 == HI_OSAL_Strncmp(pArg1, "sharp", sizeof("sharp")))
    {
        enModule = HI_PQ_MODULE_SHARPNESS;
    }
    else if (0 == HI_OSAL_Strncmp(pArg1, "dci", sizeof("dci")))
    {
        enModule = HI_PQ_MODULE_DCI;
    }
    else if (0 == HI_OSAL_Strncmp(pArg1, "color", sizeof("color")))
    {
        enModule = HI_PQ_MODULE_COLOR;
    }
    else if (0 == HI_OSAL_Strncmp(pArg1, "csc", sizeof("csc")))
    {
        enModule = HI_PQ_MODULE_CSC;
    }
    else if (0 == HI_OSAL_Strncmp(pArg1, "zme", sizeof("zme")))
    {
        HI_S32 s32Ret = HI_FAILURE;
        enModule = HI_PQ_MODULE_ZME;
        if ((HI_NULL == GET_ALG(HI_PQ_MODULE_ZME))
            || (HI_NULL == GET_ALG_FUN(HI_PQ_MODULE_ZME)->SetZmeEnMode))
        {
            return s32Ret;
        }

        if (0 == HI_OSAL_Strncmp(pArg2, "vdpfir", strlen("vdpfir")))
        {
            GET_ALG_FUN(HI_PQ_MODULE_ZME)->SetZmeEnMode(PQ_ZME_MODE_VDP_FIR, HI_TRUE);
        }
        else if (0 == HI_OSAL_Strncmp(pArg2, "vdpcopy", strlen("vdpcopy")))
        {
            GET_ALG_FUN(HI_PQ_MODULE_ZME)->SetZmeEnMode(PQ_ZME_MODE_VDP_FIR, HI_FALSE);
        }
        else if (0 == HI_OSAL_Strncmp(pArg2, "vdpmedon", strlen("vdpmedon")))
        {
            GET_ALG_FUN(HI_PQ_MODULE_ZME)->SetZmeEnMode(PQ_ZME_MODE_VDP_MED, HI_TRUE);
        }
        else if (0 == HI_OSAL_Strncmp(pArg2, "vdpmedoff", strlen("vdpmedoff")))
        {
            GET_ALG_FUN(HI_PQ_MODULE_ZME)->SetZmeEnMode(PQ_ZME_MODE_VDP_MED, HI_FALSE);
        }
        else if (0 == HI_OSAL_Strncmp(pArg2, "vpssfir", strlen("vpssfir")))
        {
            GET_ALG_FUN(HI_PQ_MODULE_ZME)->SetZmeEnMode(PQ_ZME_MODE_VPSS_FIR, HI_TRUE);
        }
        else if (0 == HI_OSAL_Strncmp(pArg2, "vpsscopy", strlen("vercopy")))
        {
            GET_ALG_FUN(HI_PQ_MODULE_ZME)->SetZmeEnMode(PQ_ZME_MODE_VPSS_FIR, HI_FALSE);
        }
        else if (0 == HI_OSAL_Strncmp(pArg2, "vpssmedon", strlen("vpssmedon")))
        {
            GET_ALG_FUN(HI_PQ_MODULE_ZME)->SetZmeEnMode(PQ_ZME_MODE_VPSS_MED, HI_TRUE);
        }
        else if (0 == HI_OSAL_Strncmp(pArg2, "vpssmedoff", strlen("vpssmedoff")))
        {
            GET_ALG_FUN(HI_PQ_MODULE_ZME)->SetZmeEnMode(PQ_ZME_MODE_VPSS_MED, HI_FALSE);
        }
        else
        {
            return HI_FAILURE;
        }
        return HI_SUCCESS;
    }
    else if (0 == HI_OSAL_Strncmp(pArg1, "dei", sizeof("dei")))
    {
        enModule = HI_PQ_MODULE_DEI;
    }
    else if (0 == HI_OSAL_Strncmp(pArg1, "ds", sizeof("ds")))
    {
        enModule = HI_PQ_MODULE_DS;
    }
    else if (0 == HI_OSAL_Strncmp(pArg1, "artds", sizeof("artds")))
    {
        enModule = HI_PQ_MODULE_ARTDS;
    }
    else if (0 == HI_OSAL_Strncmp(pArg1, "gfxcsc", sizeof("gfxcsc")))
    {
        enModule = HI_PQ_MODULE_GFXCSC;
    }
    else if (0 == HI_OSAL_Strncmp(pArg1, "gfxzme", sizeof("gfxzme")))
    {
        enModule = HI_PQ_MODULE_GFXZME;
    }
    else if (0 == HI_OSAL_Strncmp(pArg1, "all", sizeof("all")))
    {
        enModule = HI_PQ_MODULE_ALL;
    }

    if (enModule == HI_PQ_MODULE_BUTT)
    {
        return HI_FAILURE;
    }

    if (0 == HI_OSAL_Strncmp(pArg2, "enable", strlen("enable")))
    {
        DRV_PQ_SetPQModule(enModule, HI_TRUE);
    }
    else if (0 == HI_OSAL_Strncmp(pArg2, "disable", strlen("disable")))
    {
        DRV_PQ_SetPQModule(enModule, HI_FALSE);
    }
    else if (0 == HI_OSAL_Strncmp(pArg2, "demoon", strlen("demoon")))
    {
        DRV_PQ_SetDemoMode(enModule, HI_TRUE);
    }
    else if (0 == HI_OSAL_Strncmp(pArg2, "demooff", strlen("demooff")))
    {
        DRV_PQ_SetDemoMode(enModule, HI_FALSE);
    }
    else
    {
        u32Strength = simple_strtol(pArg2, NULL, 10);
        if (u32Strength > 100)
        {
            return HI_FAILURE;
        }

        if (GET_ALG(enModule) && GET_ALG_FUN(enModule)->SetStrength)
        {
            stPqParam.u32Strength[enModule] = u32Strength;
            GET_ALG_FUN(enModule)->SetStrength(u32Strength);
        }
    }

    return HI_SUCCESS;
}

HI_S32 DRV_PQ_ProcWrite(struct file* file,
                        const char __user* buf, size_t count, loff_t* ppos)
{
    HI_S32 s32Ret;
    HI_CHAR u8PQProcBuffer[256];
    HI_CHAR* pArg1, *pArg2;

    if (count >= sizeof(u8PQProcBuffer))
    {
        HI_ERR_PQ("your parameter string is too long!\n");
        return HI_FAILURE;
    }

    memset(u8PQProcBuffer, 0, sizeof(u8PQProcBuffer));
    if (copy_from_user(u8PQProcBuffer, buf, count))
    {
        HI_ERR_PQ("MMZ: copy_from_user failed!\n");
        return HI_FAILURE;
    }
    u8PQProcBuffer[count] = 0;

    s32Ret = DRV_PQ_ProcParsePara(u8PQProcBuffer, &pArg1, &pArg2);
    if (  (s32Ret != HI_SUCCESS)
          || (0 == HI_OSAL_Strncmp(pArg1, "help", strlen("help")))
          || (pArg2 == HI_NULL) )
    {
        DRV_PQ_ProcPrintHelp();
        return count;
    }

    s32Ret = DRV_PQ_ProcCmdProcess(pArg1, pArg2);
    if (s32Ret != HI_SUCCESS)
    {
        DRV_PQ_ProcPrintHelp();
        HI_ERR_PQ("proc cmd procee failed!\n");
    }
    return count;
}


