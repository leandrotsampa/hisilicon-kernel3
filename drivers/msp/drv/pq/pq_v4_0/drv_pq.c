/******************************************************************************
*
* Copyright (C) 2014 Hisilicon Technologies Co., Ltd.  All rights reserved.
*
* This program is confidential and proprietary to Hisilicon  Technologies Co., Ltd. (Hisilicon),
*  and may not be copied, reproduced, modified, disclosed to others, published or used, in
* whole or in part, without the express prior written permission of Hisilicon.
*
*****************************************************************************

  File Name     : drv_pq.c
  Version       : Initial Draft
  Author        : p00203646
  Created       : 2014/04/01
  Author        : p00203646
******************************************************************************/
#include "drv_pq.h"
#include "drv_pdm_ext.h"
#include "drv_pq_ext.h"
#include "hi_drv_dev.h"
#include "drv_pq_comm.h"

PQ_PARAM_S*        g_pstPqParam = HI_NULL; /*PQ BIN */
PQ_MMZ_BUF_S       g_stPqBinBuf;
HI_BOOL            g_bLoadPqBin;
HI_PQ_ALGIP_SEL_E  g_enAlgIPSel = HI_PQ_ALGIP_SEL_VPSS; /* Alg Sel Vpss */

HI_U32  g_u32SourceMode = SOURCE_MODE_NO;
HI_U32  g_u32OutputMode = OUTPUT_MODE_NO;

HI_U32 g_u32ImageWidth  = 1280;
HI_U32 g_u32ImageHeight = 720;
HI_U32 g_u32OutWidth    = 1280;
HI_U32 g_u32OutHeight   = 720;

HI_DRV_PQ_PARAM_S stPqParam;
PQ_STATUS_S g_stPqStatus = {0};

static HI_U32 sg_u32DemoCoordinate = 50; /*0~100*/

static HI_BOOL sg_bFastBoot     = HI_FALSE;
static HI_S32 DRV_PQ_GetFlashPqBin(PQ_PARAM_S* pstPqParam);
static HI_S32 DRV_PQ_GetPicSetting(HI_VOID);


PQ_EXPORT_FUNC_S   g_PqExportFuncs =
{
    .pfnPQ_UpdateVpssPQ           = DRV_PQ_UpdateVpssPQ,
    .pfnPQ_UpdateVdpPQ            = DRV_PQ_UpdateVdpPQ,
    .pfnPQ_UpdateVdpCSC           = DRV_PQ_UpdateVdpCSC,
    .pfnPQ_UpdateDCIWin           = DRV_PQ_UpdateDCIWin,
    .pfnPQ_SetZme                 = DRV_PQ_SetZme,
    .pfnPQ_SetVpssZme             = DRV_PQ_SetVpssZme,
    .pfnPQ_GetCSCCoef             = DRV_PQ_GetCSCCoef,
    .pfnPQ_Get8BitCSCCoef         = DRV_PQ_Get8BitCSCCoef,
    .pfnPQ_GetWbcInfo             = DRV_PQ_GetWbcInfo,
    .pfnPQ_SetAlgCalcCfg          = DRV_PQ_SetAlgCalcCfg,
    .pfnPQ_SetVdpAlgCalcCfg       = DRV_PQ_SetVdpAlgCalcCfg,
    .pfnPQ_GetHDPictureSetting    = DRV_PQ_GetHDPictureSetting,
    .pfnPQ_GetSDPictureSetting    = DRV_PQ_GetSDPictureSetting,
    .pfnPQ_SetHDPictureSetting    = DRV_PQ_SetHDPictureSetting,
    .pfnPQ_SetSDPictureSetting    = DRV_PQ_SetSDPictureSetting,
    .pfnPQ_GetHDVideoSetting      = DRV_PQ_GetHDVideoSetting,
    .pfnPQ_GetSDVideoSetting      = DRV_PQ_GetSDVideoSetting,
    .pfnPQ_SetHDVideoSetting      = DRV_PQ_SetHDVideoSetting,
    .pfnPQ_SetSDVideoSetting      = DRV_PQ_SetSDVideoSetting,
    .pfnPQ_GetVdpZmeCoef          = DRV_PQ_GetVdpZmeCoef,
    .pfnPQ_GetVdpZmeStrategy      = DRV_PQ_GetVdpZmeStrategy,
    .pfnPQ_SetGfxZme              = DRV_PQ_SetGfxZme,
    .pfnPQ_SetGfxCscCoef          = DRV_PQ_SetGfxCscCoef,
    .pfnPQ_GetWcgGmmCoef          = DRV_PQ_GetWcgGmmCoef,
    .pfnPQ_GetWcgDeGmmCoef        = DRV_PQ_GetWcgDeGmmCoef,
    .pfnPQ_GetGfxWcgGmmCoef       = DRV_PQ_GetGfxWcgGmmCoef,
    .pfnPQ_GetGfxWcgDeGmmCoef     = DRV_PQ_GetGfxWcgDeGmmCoef,
};

HI_S32 HI_DRV_PQ_DeInit(HI_VOID)
{
    HI_S32 s32Ret;
    HI_S32 i;

    HI_DRV_MODULE_UnRegister(HI_ID_PQ);
    PQ_HAL_UnmapAndRelease(&g_stPqBinBuf);

    s32Ret = PQ_MNG_DeInitPQTable();
    if (HI_SUCCESS != s32Ret)
    {
        HI_ERR_PQ("Deinit PQ table error!\n");
        return HI_FAILURE;
    }

    s32Ret = PQ_HAL_Deinit();
    if (HI_SUCCESS != s32Ret)
    {
        HI_ERR_PQ("Deinit PQ device error!\n");
        return HI_FAILURE;
    }

    for (i = 0; i < HI_PQ_MODULE_BUTT; i++)
    {
        if (GET_ALG(i) && GET_ALG_FUN(i)->DeInit)
        {
            GET_ALG_FUN(i)->DeInit();
        }
    }

#ifdef PQ_ALG_ZME
    PQ_MNG_UnRegisterZme();
#endif
#ifdef PQ_ALG_CSC
    PQ_MNG_UnRegisterCSC();
#endif
#ifdef PQ_ALG_DEI
    PQ_MNG_UnRegisterDEI();
#endif
#ifdef PQ_ALG_DB
    PQ_MNG_UnRegisterDB();
#endif
#ifdef PQ_ALG_DM
    PQ_MNG_UnRegisterDM();
#endif
#ifdef PQ_ALG_DERING
    PQ_MNG_UnRegisterDR();
#endif
#ifdef PQ_ALG_DESHOOT
    PQ_MNG_UnRegisterDS();
#endif
#ifdef PQ_ALG_ARTDS
    PQ_MNG_UnRegisterArtDS();
#endif
#ifdef PQ_ALG_TNR
    PQ_MNG_UnRegisterTNR();
#endif
#ifdef PQ_ALG_SNR
    PQ_MNG_UnRegisterSNR();
#endif
#ifdef PQ_ALG_GFXCSC
    PQ_MNG_UnRegisterGfxCSC();
#endif
#ifdef PQ_ALG_GFXZME
    PQ_MNG_UnRegisterGfxZme();
#endif
#ifdef PQ_ALG_SHARPEN
    PQ_MNG_UnRegisterSharp();
#endif
#ifdef PQ_ALG_ACM
    PQ_MNG_UnRegisterACM();
#endif
#ifdef PQ_ALG_DCI
    PQ_MNG_UnRegisterDCI();
#endif
#ifdef PQ_ALG_FMD
    PQ_MNG_UnRegisterFMD();
#endif
#ifdef PQ_ALG_HDR
    PQ_MNG_UnRegisterHDR();
#endif

    return HI_SUCCESS;
}


HI_S32 HI_DRV_PQ_Init(HI_CHAR* pszPath)
{
    HI_S32 s32Ret;
    HI_S32 i;
    g_bLoadPqBin = HI_FALSE;
    g_pstPqParam = HI_NULL;

    s32Ret = HI_DRV_MODULE_Register(HI_ID_PQ, PQ_NAME, (HI_VOID*)&g_PqExportFuncs);

    if (HI_SUCCESS != s32Ret)
    {
        HI_FATAL_PQ("ERR: HI_DRV_MODULE_Register!\n");
        return s32Ret;
    }

    s32Ret = PQ_HAL_AllocAndMap("PQ_FLASH_BIN", HI_NULL, sizeof(PQ_PARAM_S), 0, &g_stPqBinBuf);
    if (HI_SUCCESS != s32Ret)
    {
        HI_FATAL_PQ("ERR: Pqdriver mmz memory failed!\n");
        g_bLoadPqBin = HI_FALSE;
        return s32Ret;
    }

    g_pstPqParam = (PQ_PARAM_S*)g_stPqBinBuf.pu8StartVirAddr;
    HI_INFO_PQ("\ng_stPqBinBuf.u32StartVirAddr = 0x%x,g_stPqBinBuf.u32StartVirAddr = 0x%x\n", g_stPqBinBuf.u32StartPhyAddr, g_stPqBinBuf.pu8StartVirAddr);

    s32Ret = DRV_PQ_GetFlashPqBin(g_pstPqParam);
    if (HI_SUCCESS != s32Ret)
    {
        //HI_ERR_PQ("Load PQBin failed!\n");
        g_bLoadPqBin = HI_FALSE;
    }
    else
    {
        g_bLoadPqBin = HI_TRUE;
    }

    s32Ret = DRV_PQ_GetPicSetting();
    if (HI_SUCCESS != s32Ret)
    {
        HI_WARN_PQ("ERR: DRV_PQ_GetPicSetting failed!\n");
        stPqParam.stSDPictureSetting.u16Brightness = 50;
        stPqParam.stSDPictureSetting.u16Contrast   = 50;
        stPqParam.stSDPictureSetting.u16Hue        = 50;
        stPqParam.stSDPictureSetting.u16Saturation = 50;
        stPqParam.stHDPictureSetting.u16Brightness = 50;
        stPqParam.stHDPictureSetting.u16Contrast   = 50;
        stPqParam.stHDPictureSetting.u16Hue        = 50;
        stPqParam.stHDPictureSetting.u16Saturation = 50;
        stPqParam.stSDVideoSetting.u16Brightness   = 128;
        stPqParam.stSDVideoSetting.u16Contrast     = 128;
        stPqParam.stSDVideoSetting.u16Hue          = 128;
        stPqParam.stSDVideoSetting.u16Saturation   = 128;
        stPqParam.stHDVideoSetting.u16Brightness   = 128;
        stPqParam.stHDVideoSetting.u16Contrast     = 128;
        stPqParam.stHDVideoSetting.u16Hue          = 128;
        stPqParam.stHDVideoSetting.u16Saturation   = 128;
    }

#ifdef PQ_ALG_ZME
    PQ_MNG_RegisterZme(REG_TYPE_BUTT);
#endif
#ifdef PQ_ALG_CSC
    PQ_MNG_RegisterCSC(REG_TYPE_VDP);
#endif
#ifdef PQ_ALG_DEI
    PQ_MNG_RegisterDEI(REG_TYPE_VPSS);
#endif
#ifdef PQ_ALG_TNR
    PQ_MNG_RegisterTNR(REG_TYPE_VPSS);
#endif
#ifdef PQ_ALG_SNR
    PQ_MNG_RegisterSNR(REG_TYPE_VPSS);
#endif
#ifdef PQ_ALG_DB
    PQ_MNG_RegisterDB(REG_TYPE_VPSS);
#endif
#ifdef PQ_ALG_DM
    PQ_MNG_RegisterDM(REG_TYPE_VPSS);
#endif
#ifdef PQ_ALG_DERING
    PQ_MNG_RegisterDR(REG_TYPE_VPSS);
#endif
#ifdef PQ_ALG_DESHOOT
    PQ_MNG_RegisterDS(REG_TYPE_VPSS);
#endif
#ifdef PQ_ALG_ARTDS
    PQ_MNG_RegisterArtDS(REG_TYPE_VDP);
#endif
#ifdef PQ_ALG_GFXCSC
    PQ_MNG_RegisterGfxCSC();
#endif
#ifdef PQ_ALG_GFXZME
    PQ_MNG_RegisterGfxZme();
#endif
#ifdef PQ_ALG_SHARPEN
    PQ_MNG_RegisterSharp(REG_TYPE_VDP);
#endif
#ifdef PQ_ALG_ACM
    PQ_MNG_RegisterACM(REG_TYPE_VDP);
#endif
#ifdef PQ_ALG_DCI
    PQ_MNG_RegisterDCI(REG_TYPE_VDP);
#endif
#ifdef PQ_ALG_FMD
    PQ_MNG_RegisterFMD(REG_TYPE_VPSS);
#endif
#ifdef PQ_ALG_HDR
    PQ_MNG_RegisterHDR(REG_TYPE_VDP);
#endif

    s32Ret = PQ_HAL_Init();
    if (HI_SUCCESS != s32Ret)
    {
        HI_ERR_PQ("Init PQ device error!\n");
        return HI_FAILURE;
    }

    s32Ret = PQ_MNG_InitPQTable(g_pstPqParam, !g_bLoadPqBin);
    if (HI_SUCCESS != s32Ret)
    {
        HI_ERR_PQ("Init PQ table failure!\n");
        return HI_FAILURE;
    }

    for (i = 0; i < HI_PQ_MODULE_BUTT; i++)
    {
        if (HI_NULL == GET_ALG(i))
        {
            continue;
        }

        if (GET_ALG_FUN(i)->Init)
        {
            GET_ALG_FUN(i)->Init(g_pstPqParam, !g_bLoadPqBin);
        }

        stPqParam.bDemoOnOff[i]   = HI_FALSE;
        stPqParam.bModuleOnOff[i] = HI_TRUE;
        stPqParam.u32Strength[i]  = 50;
    }

    stPqParam.stColorEnhance.enColorEnhanceType      = HI_PQ_COLOR_ENHANCE_SPEC_COLOR_MODE;
    stPqParam.stColorEnhance.unColorGain.enColorMode = HI_PQ_COLOR_MODE_RECOMMEND;
    stPqParam.enDemoMode                             = HI_PQ_DEMO_MODE_FIXED_L;  /*default left enable */

    /*set gfx  brightness/contrast/hue/saturation*/
    if (GET_ALG(HI_PQ_MODULE_GFXCSC) && GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->SetGfxCSCPictureSetting)
    {
        GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->SetGfxCSCPictureSetting(HI_PQ_DISPLAY_0, (HI_PQ_PICTURE_SETTING_S*)&stPqParam.stSDPictureSetting);
        GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->SetGfxCSCPictureSetting(HI_PQ_DISPLAY_1, (HI_PQ_PICTURE_SETTING_S*)&stPqParam.stHDPictureSetting);
    }

    return HI_SUCCESS;
}

HI_S32 DRV_PQ_Suspend(PM_BASEDEV_S* pdev, pm_message_t state)
{
    if (PM_EVENT_FREEZE == state.event)
    {
        sg_bFastBoot = HI_TRUE;
    }
    else
    {
        sg_bFastBoot = HI_FALSE;
    }

    return HI_SUCCESS;
}

HI_S32 DRV_PQ_Resume(PM_BASEDEV_S* pdev)
{
    HI_S32 s32Ret;

    if (HI_TRUE == sg_bFastBoot)
    {
        s32Ret = DRV_PQ_GetPicSetting();
        if (HI_SUCCESS != s32Ret)
        {
            HI_WARN_PQ("ERR: DRV_PQ_GetPicSetting failed!\n");
        }
    }

    /*set gfx  brightness/contrast/hue/saturation*/
    if (GET_ALG(HI_PQ_MODULE_GFXCSC) && GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->SetGfxCSCPictureSetting)
    {
        GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->SetGfxCSCPictureSetting(HI_PQ_DISPLAY_0, (HI_PQ_PICTURE_SETTING_S*)&stPqParam.stSDPictureSetting);
        GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->SetGfxCSCPictureSetting(HI_PQ_DISPLAY_1, (HI_PQ_PICTURE_SETTING_S*)&stPqParam.stHDPictureSetting);
    }

    if (GET_ALG(HI_PQ_MODULE_GFXZME) && GET_ALG_FUN(HI_PQ_MODULE_GFXZME)->SetResume)
    {
        GET_ALG_FUN(HI_PQ_MODULE_GFXZME)->SetResume(!g_bLoadPqBin);
    }

    return HI_SUCCESS;
}

/**
 \brief 获取标清亮度
 \attention \n
无

 \param[out] pu32Brightness 亮度值,有效范围: 0~100;

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_GetSDBrightness(HI_U32* pu32Brightness)
{
    HI_PQ_PICTURE_SETTING_S stPictureSetting;
    HI_S32 s32Ret = HI_FAILURE;

    PQ_CHECK_NULL_PTR(pu32Brightness);

    if (GET_ALG(HI_PQ_MODULE_CSC) && GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting(HI_PQ_DISPLAY_0, &stPictureSetting);
        if (HI_SUCCESS == s32Ret)
        {
            *pu32Brightness = NUM2LEVEL(stPictureSetting.u16Brightness);
            pqprint(PQ_PRN_CSC, "Get SD Brightness: %d\n", *pu32Brightness);
        }
        else
        {
            HI_ERR_PQ("get csc error\n");
        }
    }

    return s32Ret;
}

/**
 \brief 设置标清亮度
 \attention \n
无

 \param[in] u32Brightness, 亮度值,有效范围: 0~100;

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_SetSDBrightness(HI_U32 u32Brightness)
{
    HI_PQ_PICTURE_SETTING_S stPictureSetting;
    HI_S32 s32Ret = HI_FAILURE;

    if (u32Brightness > 100)
    {
        HI_ERR_PQ("%d:u32Brightness is over range!\n", u32Brightness);
        return HI_FAILURE;
    }

    if (GET_ALG(HI_PQ_MODULE_CSC) && GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting(HI_PQ_DISPLAY_0, &stPictureSetting);
    }

    stPictureSetting.u16Brightness = LEVEL2NUM(u32Brightness);

    if (GET_ALG(HI_PQ_MODULE_CSC) && GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting)
    {
        s32Ret |= GET_ALG_FUN(HI_PQ_MODULE_CSC)->SetCSCVideoSetting(HI_PQ_DISPLAY_0, &stPictureSetting);
        stPqParam.stSDVideoSetting.u16Brightness = LEVEL2NUM(u32Brightness);
    }

    /*gfx*/
    if (GET_ALG(HI_PQ_MODULE_GFXCSC) && GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->GetGfxCSCPictureSetting)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->GetGfxCSCPictureSetting(HI_PQ_DISPLAY_0, &stPictureSetting);
    }

    stPictureSetting.u16Brightness = u32Brightness;
    if (GET_ALG(HI_PQ_MODULE_GFXCSC) && GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->SetGfxCSCPictureSetting)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->SetGfxCSCPictureSetting(HI_PQ_DISPLAY_0, &stPictureSetting);
        stPqParam.stSDPictureSetting.u16Brightness = u32Brightness;
    }

    pqprint(PQ_PRN_CSC, "Set SD Brightness: %d\n", u32Brightness);
    return s32Ret;
}

/**
 \brief 获取标清对比度
 \attention \n
无

 \param[out] pu32Contrast 对比度, 有效范围: 0~100;

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_GetSDContrast(HI_U32* pu32Contrast)
{
    HI_PQ_PICTURE_SETTING_S stPictureSetting;
    HI_S32 s32Ret = HI_FAILURE;

    PQ_CHECK_NULL_PTR(pu32Contrast);

    if (GET_ALG(HI_PQ_MODULE_CSC) && GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting(HI_PQ_DISPLAY_0, &stPictureSetting);
        if (HI_SUCCESS == s32Ret)
        {
            *pu32Contrast = NUM2LEVEL(stPictureSetting.u16Contrast);
        }
        else
        {
            HI_ERR_PQ("get csc error\n");
        }
    }

    pqprint(PQ_PRN_CSC, "Get SD Contrast: %d\n", *pu32Contrast);

    return s32Ret;
}

/**
 \brief 设置标清对比度
 \attention \n
无

 \param[in] u32Contrast, 对比度, 有效范围: 0~100;

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_SetSDContrast(HI_U32 u32Contrast)
{
    HI_PQ_PICTURE_SETTING_S stPictureSetting;
    HI_S32 s32Ret = HI_FAILURE;

    if (u32Contrast > 100)
    {
        HI_ERR_PQ("%d:u32Contrast is over range!\n", u32Contrast);
        return HI_FAILURE;
    }

    if (GET_ALG(HI_PQ_MODULE_CSC) && GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting(HI_PQ_DISPLAY_0, &stPictureSetting);
    }

    stPictureSetting.u16Contrast = LEVEL2NUM(u32Contrast);

    if (GET_ALG(HI_PQ_MODULE_CSC) && GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting)
    {
        s32Ret |= GET_ALG_FUN(HI_PQ_MODULE_CSC)->SetCSCVideoSetting(HI_PQ_DISPLAY_0, &stPictureSetting);
        stPqParam.stSDVideoSetting.u16Contrast   = LEVEL2NUM(u32Contrast);
    }

    /*gfx*/
    if (GET_ALG(HI_PQ_MODULE_GFXCSC) && GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->GetGfxCSCPictureSetting)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->GetGfxCSCPictureSetting(HI_PQ_DISPLAY_0, &stPictureSetting);
    }

    stPictureSetting.u16Contrast = u32Contrast;
    if (GET_ALG(HI_PQ_MODULE_GFXCSC) && GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->SetGfxCSCPictureSetting)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->SetGfxCSCPictureSetting(HI_PQ_DISPLAY_0, &stPictureSetting);
        stPqParam.stSDPictureSetting.u16Contrast = u32Contrast;
    }

    pqprint(PQ_PRN_CSC, "Set SD Contrast: %d\n", u32Contrast);
    return s32Ret;
}

/**
 \brief 获取标清色调
 \attention \n
无

 \param[out] pu32Hue  色调, 有效范围: 0~100;

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_GetSDHue(HI_U32* pu32Hue)
{
    HI_PQ_PICTURE_SETTING_S stPictureSetting;
    HI_S32 s32Ret = HI_FAILURE;

    PQ_CHECK_NULL_PTR(pu32Hue);

    if (GET_ALG(HI_PQ_MODULE_CSC) && GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting(HI_PQ_DISPLAY_0, &stPictureSetting);
        if (HI_SUCCESS == s32Ret)
        {
            *pu32Hue = NUM2LEVEL(stPictureSetting.u16Hue);
        }
        else
        {
            HI_ERR_PQ("get csc error\n");
        }
    }

    pqprint(PQ_PRN_CSC, "Get SD Hue: %d\n", *pu32Hue);
    return s32Ret;
}

/**
 \brief 设置标清色调
 \attention \n
无

 \param[in] u32Hue   色调, 有效范围: 0~100;

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_SetSDHue(HI_U32 u32Hue)
{
    HI_PQ_PICTURE_SETTING_S stPictureSetting;
    HI_S32 s32Ret = HI_FAILURE;

    if (u32Hue > 100)
    {
        HI_ERR_PQ("%d:u32Hue is over range!\n", u32Hue);
        return HI_FAILURE;
    }

    if (GET_ALG(HI_PQ_MODULE_CSC) && GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting(HI_PQ_DISPLAY_0, &stPictureSetting);
    }

    stPictureSetting.u16Hue = LEVEL2NUM(u32Hue);

    if (GET_ALG(HI_PQ_MODULE_CSC) && GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting)
    {
        s32Ret |= GET_ALG_FUN(HI_PQ_MODULE_CSC)->SetCSCVideoSetting(HI_PQ_DISPLAY_0, &stPictureSetting);
        stPqParam.stSDVideoSetting.u16Hue   = LEVEL2NUM(u32Hue);
    }

    /*gfx*/
    if (GET_ALG(HI_PQ_MODULE_GFXCSC) && GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->GetGfxCSCPictureSetting)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->GetGfxCSCPictureSetting(HI_PQ_DISPLAY_0, &stPictureSetting);
    }

    stPictureSetting.u16Hue = u32Hue;
    if (GET_ALG(HI_PQ_MODULE_GFXCSC) && GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->SetGfxCSCPictureSetting)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->SetGfxCSCPictureSetting(HI_PQ_DISPLAY_0, &stPictureSetting);
        stPqParam.stSDPictureSetting.u16Hue = u32Hue;
    }

    pqprint(PQ_PRN_CSC, "Set SD Hue: %d\n", u32Hue);
    return s32Ret;
}

/**
 \brief 获取标清饱和度
 \attention \n
无

 \param[out] pu32Saturation  饱和度, 有效范围: 0~100;

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_GetSDSaturation(HI_U32* pu32Saturation)
{
    HI_PQ_PICTURE_SETTING_S stPictureSetting;
    HI_S32 s32Ret = HI_FAILURE;

    PQ_CHECK_NULL_PTR(pu32Saturation);

    if (GET_ALG(HI_PQ_MODULE_CSC) && GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting(HI_PQ_DISPLAY_0, &stPictureSetting);
        if (HI_SUCCESS == s32Ret)
        {
            *pu32Saturation = NUM2LEVEL(stPictureSetting.u16Saturation);
        }
        else
        {
            HI_ERR_PQ("get csc error\n");
        }
    }

    pqprint(PQ_PRN_CSC, "Get SD Saturation: %d\n", *pu32Saturation);
    return s32Ret;
}

/**
 \brief 设置标清饱和度
 \attention \n
无

 \param[in] u32Saturation 饱和度,有效范围: 0~100;

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_SetSDSaturation(HI_U32 u32Saturation)
{
    HI_PQ_PICTURE_SETTING_S stPictureSetting;
    HI_S32 s32Ret = HI_FAILURE;

    if (u32Saturation > 100)
    {
        HI_ERR_PQ("%d:u32Saturation is over range!\n", u32Saturation);
        return HI_FAILURE;
    }

    if (GET_ALG(HI_PQ_MODULE_CSC) && GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting(HI_PQ_DISPLAY_0, &stPictureSetting);
    }

    stPictureSetting.u16Saturation = LEVEL2NUM(u32Saturation);

    if (GET_ALG(HI_PQ_MODULE_CSC) && GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting)
    {
        s32Ret |= GET_ALG_FUN(HI_PQ_MODULE_CSC)->SetCSCVideoSetting(HI_PQ_DISPLAY_0, &stPictureSetting);
        stPqParam.stSDVideoSetting.u16Saturation   = LEVEL2NUM(u32Saturation);
    }

    /*gfx*/
    if (GET_ALG(HI_PQ_MODULE_GFXCSC) && GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->GetGfxCSCPictureSetting)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->GetGfxCSCPictureSetting(HI_PQ_DISPLAY_0, &stPictureSetting);
    }

    stPictureSetting.u16Saturation = u32Saturation;
    if (GET_ALG(HI_PQ_MODULE_GFXCSC) && GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->SetGfxCSCPictureSetting)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->SetGfxCSCPictureSetting(HI_PQ_DISPLAY_0, &stPictureSetting);
        stPqParam.stSDPictureSetting.u16Saturation = u32Saturation;
    }

    pqprint(PQ_PRN_CSC, "Set SD Saturation: %d\n", u32Saturation);
    return s32Ret;
}

/**
 \brief 获取高清亮度
 \attention \n
无

 \param[out] pu32Brightness 亮度值,有效范围: 0~100;

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_GetHDBrightness(HI_U32* pu32Brightness)
{
    HI_PQ_PICTURE_SETTING_S stPictureSetting;
    HI_S32 s32Ret = HI_FAILURE;

    PQ_CHECK_NULL_PTR(pu32Brightness);

    if (GET_ALG(HI_PQ_MODULE_CSC) && GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting(HI_PQ_DISPLAY_1, &stPictureSetting);
        if (HI_SUCCESS == s32Ret)
        {
            *pu32Brightness = NUM2LEVEL(stPictureSetting.u16Brightness);
        }
        else
        {
            HI_ERR_PQ("get csc error\n");
        }
    }

    pqprint(PQ_PRN_CSC, "Get HD Brightness: %d\n", *pu32Brightness);
    return s32Ret;
}

/**
 \brief 设置高清亮度
 \attention \n
无

 \param[in] u32Brightness, 亮度值,有效范围: 0~100;

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_SetHDBrightness(HI_U32 u32Brightness)
{
    HI_PQ_PICTURE_SETTING_S stPictureSetting;
    HI_S32 s32Ret = HI_FAILURE;

    if (u32Brightness > 100)
    {
        HI_ERR_PQ("%d:u32Brightness is over range!\n", u32Brightness);
        return HI_FAILURE;
    }

    /*video*/
    if (GET_ALG(HI_PQ_MODULE_CSC) && GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting(HI_PQ_DISPLAY_1, &stPictureSetting);
    }

    stPictureSetting.u16Brightness = LEVEL2NUM(u32Brightness);

    if (GET_ALG(HI_PQ_MODULE_CSC) && GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting)
    {
        s32Ret |= GET_ALG_FUN(HI_PQ_MODULE_CSC)->SetCSCVideoSetting(HI_PQ_DISPLAY_1, &stPictureSetting);
        stPqParam.stHDVideoSetting.u16Brightness   = LEVEL2NUM(u32Brightness);
    }

    /*gfx*/
    if (GET_ALG(HI_PQ_MODULE_GFXCSC) && GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->GetGfxCSCPictureSetting)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->GetGfxCSCPictureSetting(HI_PQ_DISPLAY_1, &stPictureSetting);
    }

    stPictureSetting.u16Brightness = u32Brightness;
    if (GET_ALG(HI_PQ_MODULE_GFXCSC) && GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->SetGfxCSCPictureSetting)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->SetGfxCSCPictureSetting(HI_PQ_DISPLAY_1, &stPictureSetting);
        stPqParam.stHDPictureSetting.u16Brightness = u32Brightness;
    }

    pqprint(PQ_PRN_CSC, "Set HD Brightness: %d\n", u32Brightness);

    return s32Ret;
}

/**
 \brief 获取高清对比度
 \attention \n
无

 \param[out] pu32Contrast 对比度, 有效范围: 0~100;

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_GetHDContrast(HI_U32* pu32Contrast)
{
    HI_PQ_PICTURE_SETTING_S stPictureSetting;
    HI_S32 s32Ret = HI_FAILURE;

    PQ_CHECK_NULL_PTR(pu32Contrast);

    if (GET_ALG(HI_PQ_MODULE_CSC) && GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting(HI_PQ_DISPLAY_1, &stPictureSetting);
        if (HI_SUCCESS == s32Ret)
        {
            *pu32Contrast = NUM2LEVEL(stPictureSetting.u16Contrast);
        }
        else
        {
            HI_ERR_PQ("get csc error\n");
        }
    }

    pqprint(PQ_PRN_CSC, "Get HD Contrast: %d\n", *pu32Contrast);
    return s32Ret;
}

/**
 \brief 设置高清对比度
 \attention \n
无

 \param[in] u32Contrast, 对比度, 有效范围: 0~100;

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_SetHDContrast(HI_U32 u32Contrast)
{
    HI_PQ_PICTURE_SETTING_S stPictureSetting;
    HI_S32 s32Ret = HI_FAILURE;

    if (u32Contrast > 100)
    {
        HI_ERR_PQ("%d:u32Contrast is over range!\n", u32Contrast);
        return HI_FAILURE;
    }

    /*video*/
    if (GET_ALG(HI_PQ_MODULE_CSC) && GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting(HI_PQ_DISPLAY_1, &stPictureSetting);
    }

    stPictureSetting.u16Contrast = LEVEL2NUM(u32Contrast);

    if (GET_ALG(HI_PQ_MODULE_CSC) && GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting)
    {
        s32Ret |= GET_ALG_FUN(HI_PQ_MODULE_CSC)->SetCSCVideoSetting(HI_PQ_DISPLAY_1, &stPictureSetting);
        stPqParam.stHDVideoSetting.u16Contrast = LEVEL2NUM(u32Contrast);
    }

    /*gfx*/
    if (GET_ALG(HI_PQ_MODULE_GFXCSC) && GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->GetGfxCSCPictureSetting)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->GetGfxCSCPictureSetting(HI_PQ_DISPLAY_1, &stPictureSetting);
    }

    stPictureSetting.u16Contrast = u32Contrast;
    if (GET_ALG(HI_PQ_MODULE_GFXCSC) && GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->SetGfxCSCPictureSetting)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->SetGfxCSCPictureSetting(HI_PQ_DISPLAY_1, &stPictureSetting);
        stPqParam.stHDPictureSetting.u16Contrast = u32Contrast;
    }

    pqprint(PQ_PRN_CSC, "Set HD Contrast: %d\n", u32Contrast);
    return s32Ret;
}


/**
 \brief 获取高清色调
 \attention \n
无

 \param[out] pu32Hue  色调, 有效范围: 0~100;

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_GetHDHue(HI_U32* pu32Hue)
{
    HI_PQ_PICTURE_SETTING_S stPictureSetting;
    HI_S32 s32Ret = HI_FAILURE;

    PQ_CHECK_NULL_PTR(pu32Hue);

    if (GET_ALG(HI_PQ_MODULE_CSC) && GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting(HI_PQ_DISPLAY_1, &stPictureSetting);
        if (HI_SUCCESS == s32Ret)
        {
            *pu32Hue = NUM2LEVEL(stPictureSetting.u16Hue);
        }
        else
        {
            HI_ERR_PQ("get csc error\n");
        }
    }

    pqprint(PQ_PRN_CSC, "Get HD Hue: %d\n", *pu32Hue);
    return s32Ret;
}


/**
 \brief 设置高清色调
 \attention \n
无

 \param[in] u32Hue   色调, 有效范围: 0~100;

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_SetHDHue(HI_U32 u32Hue)
{
    HI_PQ_PICTURE_SETTING_S stPictureSetting;
    HI_S32 s32Ret = HI_FAILURE;

    if (u32Hue > 100)
    {
        HI_ERR_PQ("%d:u32Hue is over range!\n", u32Hue);
        return HI_FAILURE;
    }

    if (GET_ALG(HI_PQ_MODULE_CSC) && GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting(HI_PQ_DISPLAY_1, &stPictureSetting);
    }

    stPictureSetting.u16Hue = LEVEL2NUM(u32Hue);

    if (GET_ALG(HI_PQ_MODULE_CSC) && GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting)
    {
        s32Ret |= GET_ALG_FUN(HI_PQ_MODULE_CSC)->SetCSCVideoSetting(HI_PQ_DISPLAY_1, &stPictureSetting);
        stPqParam.stHDVideoSetting.u16Hue   = LEVEL2NUM(u32Hue);
    }

    /*gfx*/
    if (GET_ALG(HI_PQ_MODULE_GFXCSC) && GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->GetGfxCSCPictureSetting)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->GetGfxCSCPictureSetting(HI_PQ_DISPLAY_1, &stPictureSetting);
    }

    stPictureSetting.u16Hue = u32Hue;
    if (GET_ALG(HI_PQ_MODULE_GFXCSC) && GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->SetGfxCSCPictureSetting)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->SetGfxCSCPictureSetting(HI_PQ_DISPLAY_1, &stPictureSetting);
        stPqParam.stHDPictureSetting.u16Hue = u32Hue;
    }

    pqprint(PQ_PRN_CSC, "Set HD Hue: %d\n", u32Hue);
    return HI_SUCCESS;
}


/**
 \brief 获取高清饱和度
 \attention \n
无

 \param[out] pu32Saturation  饱和度, 有效范围: 0~100;

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_GetHDSaturation(HI_U32* pu32Saturation)
{
    HI_PQ_PICTURE_SETTING_S stPictureSetting;
    HI_S32 s32Ret = HI_FAILURE;

    PQ_CHECK_NULL_PTR(pu32Saturation);

    if (GET_ALG(HI_PQ_MODULE_CSC) && GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting(HI_PQ_DISPLAY_1, &stPictureSetting);
        if (HI_SUCCESS == s32Ret)
        {
            *pu32Saturation = NUM2LEVEL(stPictureSetting.u16Saturation);
        }
        else
        {
            HI_ERR_PQ("get csc error\n");
        }
    }

    pqprint(PQ_PRN_CSC, "Get HD Saturation: %d\n", *pu32Saturation);
    return s32Ret;
}


/**
 \brief 设置高清饱和度
 \attention \n
无

 \param[in] u32Saturation 饱和度,有效范围: 0~100;

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_SetHDSaturation(HI_U32 u32Saturation)
{
    HI_PQ_PICTURE_SETTING_S stPictureSetting;
    HI_S32 s32Ret = HI_FAILURE;

    if (u32Saturation > 100)
    {
        HI_ERR_PQ("%d:u32Saturation is over range!\n", u32Saturation);
        return HI_FAILURE;
    }

    if (GET_ALG(HI_PQ_MODULE_CSC) && GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting(HI_PQ_DISPLAY_1, &stPictureSetting);
    }

    stPictureSetting.u16Saturation = LEVEL2NUM(u32Saturation);

    if (GET_ALG(HI_PQ_MODULE_CSC) && GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting)
    {
        s32Ret |= GET_ALG_FUN(HI_PQ_MODULE_CSC)->SetCSCVideoSetting(HI_PQ_DISPLAY_1, &stPictureSetting);
        stPqParam.stHDVideoSetting.u16Saturation   = LEVEL2NUM(u32Saturation);
    }

    /*gfx*/
    if (GET_ALG(HI_PQ_MODULE_GFXCSC) && GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->GetGfxCSCPictureSetting)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->GetGfxCSCPictureSetting(HI_PQ_DISPLAY_1, &stPictureSetting);
    }

    stPictureSetting.u16Saturation = u32Saturation;
    if (GET_ALG(HI_PQ_MODULE_GFXCSC) && GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->SetGfxCSCPictureSetting)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->SetGfxCSCPictureSetting(HI_PQ_DISPLAY_1, &stPictureSetting);
        stPqParam.stHDPictureSetting.u16Saturation = u32Saturation;
    }

    pqprint(PQ_PRN_CSC, "Set HD Saturation: %d\n", u32Saturation);

    return s32Ret;
}


/**
 \brief 获取视频高清亮度/对比度/色调/饱和度
 \attention \n
无

 \param[out] u32Hue   亮度/对比度/色调/饱和度

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_GetHDVideoSetting(HI_PQ_PICTURE_SETTING_S* pstSetting)
{
    HI_PQ_PICTURE_SETTING_S stSetting;
    HI_S32 s32Ret = HI_FAILURE;

    PQ_CHECK_NULL_PTR(pstSetting);

    if (GET_ALG(HI_PQ_MODULE_CSC) && GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting(HI_PQ_DISPLAY_1, &stSetting);
        if (HI_SUCCESS == s32Ret)
        {
            pstSetting->u16Brightness = NUM2LEVEL(stSetting.u16Brightness);
            pstSetting->u16Contrast   = NUM2LEVEL(stSetting.u16Contrast);
            pstSetting->u16Hue        = NUM2LEVEL(stSetting.u16Hue);
            pstSetting->u16Saturation = NUM2LEVEL(stSetting.u16Saturation);
        }
        else
        {
            HI_ERR_PQ("get csc error\n");
        }
    }

    return HI_SUCCESS;
}


/**
 \brief 获取视频标清亮度/对比度/色调/饱和度
 \attention \n
无

 \param[out] u32Hue   亮度/对比度/色调/饱和度

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_GetSDVideoSetting(HI_PQ_PICTURE_SETTING_S* pstSetting)
{
    HI_PQ_PICTURE_SETTING_S stSetting;
    HI_S32 s32Ret = HI_FAILURE;

    PQ_CHECK_NULL_PTR(pstSetting);

    if (GET_ALG(HI_PQ_MODULE_CSC) && GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCVideoSetting(HI_PQ_DISPLAY_0, &stSetting);
        if (HI_SUCCESS == s32Ret)
        {
            pstSetting->u16Brightness = NUM2LEVEL(stSetting.u16Brightness);
            pstSetting->u16Contrast   = NUM2LEVEL(stSetting.u16Contrast);
            pstSetting->u16Hue        = NUM2LEVEL(stSetting.u16Hue);
            pstSetting->u16Saturation = NUM2LEVEL(stSetting.u16Saturation);
        }
        else
        {
            HI_ERR_PQ("get csc error\n");
        }
    }

    return s32Ret;
}


/**
 \brief 设置视频高清亮度/对比度/色调/饱和度
 \attention \n
无

 \param[in] u32Hue   亮度/对比度/色调/饱和度

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_SetHDVideoSetting(HI_PQ_PICTURE_SETTING_S* pstSetting)
{
    HI_PQ_PICTURE_SETTING_S stSetting;
    HI_S32 s32Ret = HI_FAILURE;

    PQ_CHECK_NULL_PTR(pstSetting);

    if ((pstSetting->u16Brightness > 100)
        || (pstSetting->u16Contrast > 100)
        || (pstSetting->u16Saturation > 100)
        || (pstSetting->u16Hue > 100))
    {
        HI_ERR_PQ("out of range!\n");
        return HI_FAILURE;
    }

    pqprint(PQ_PRN_CSC, "Set Brightness:%d, Contrast:%d, Hue:%d, Saturation:%d\n",
            pstSetting->u16Brightness, pstSetting->u16Contrast, pstSetting->u16Hue, pstSetting->u16Saturation);

    /* 0~100 to 0~255 */
    stSetting.u16Brightness = LEVEL2NUM(pstSetting->u16Brightness);
    stSetting.u16Contrast   = LEVEL2NUM(pstSetting->u16Contrast);
    stSetting.u16Hue        = LEVEL2NUM(pstSetting->u16Hue);
    stSetting.u16Saturation = LEVEL2NUM(pstSetting->u16Saturation);

    if (GET_ALG(HI_PQ_MODULE_CSC) && GET_ALG_FUN(HI_PQ_MODULE_CSC)->SetCSCVideoSetting)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_CSC)->SetCSCVideoSetting(HI_PQ_DISPLAY_1, &stSetting);
    }

    /* up drv layer; we use 0~100 level value */
    stPqParam.stHDVideoSetting.u16Brightness = LEVEL2NUM(pstSetting->u16Brightness);
    stPqParam.stHDVideoSetting.u16Contrast   = LEVEL2NUM(pstSetting->u16Contrast);
    stPqParam.stHDVideoSetting.u16Hue        = LEVEL2NUM(pstSetting->u16Hue);
    stPqParam.stHDVideoSetting.u16Saturation = LEVEL2NUM(pstSetting->u16Saturation);

    return s32Ret;
}


/**
 \brief 设置视频标清亮度/对比度/色调/饱和度
 \attention \n
无

 \param[in] u32Hue   亮度/对比度/色调/饱和度

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_SetSDVideoSetting(HI_PQ_PICTURE_SETTING_S* pstSetting)
{
    HI_PQ_PICTURE_SETTING_S stSetting;
    HI_S32 s32Ret = HI_FAILURE;

    PQ_CHECK_NULL_PTR(pstSetting);

    if ((pstSetting->u16Brightness > 100)
        || (pstSetting->u16Contrast > 100)
        || (pstSetting->u16Saturation > 100)
        || (pstSetting->u16Hue > 100))
    {
        HI_ERR_PQ("out of range!\n");
        return HI_FAILURE;
    }

    pqprint(PQ_PRN_CSC, "Set Brightness:%d, Contrast:%d, Hue:%d, Saturation:%d\n",
            pstSetting->u16Brightness, pstSetting->u16Contrast, pstSetting->u16Hue, pstSetting->u16Saturation);

    stSetting.u16Brightness = LEVEL2NUM(pstSetting->u16Brightness);
    stSetting.u16Contrast   = LEVEL2NUM(pstSetting->u16Contrast);
    stSetting.u16Hue        = LEVEL2NUM(pstSetting->u16Hue);
    stSetting.u16Saturation = LEVEL2NUM(pstSetting->u16Saturation);

    if (GET_ALG(HI_PQ_MODULE_CSC) && GET_ALG_FUN(HI_PQ_MODULE_CSC)->SetCSCVideoSetting)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_CSC)->SetCSCVideoSetting(HI_PQ_DISPLAY_0, &stSetting);
    }

    stPqParam.stSDVideoSetting.u16Brightness = LEVEL2NUM(pstSetting->u16Brightness);
    stPqParam.stSDVideoSetting.u16Contrast   = LEVEL2NUM(pstSetting->u16Contrast);
    stPqParam.stSDVideoSetting.u16Hue        = LEVEL2NUM(pstSetting->u16Hue);
    stPqParam.stSDVideoSetting.u16Saturation = LEVEL2NUM(pstSetting->u16Saturation);

    return s32Ret;
}


/**
 \brief 获取图形高清亮度/对比度/色调/饱和度
 \attention \n
无

 \param[out] u32Hue   亮度/对比度/色调/饱和度

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_GetHDPictureSetting(HI_PQ_PICTURE_SETTING_S* pstSetting)
{
    PQ_CHECK_NULL_PTR(pstSetting);

    pstSetting->u16Brightness  = stPqParam.stHDPictureSetting.u16Brightness;
    pstSetting->u16Contrast    = stPqParam.stHDPictureSetting.u16Contrast;
    pstSetting->u16Hue         = stPqParam.stHDPictureSetting.u16Hue;
    pstSetting->u16Saturation  = stPqParam.stHDPictureSetting.u16Saturation;

    return HI_SUCCESS;
}


/**
 \brief 获取图形标清亮度/对比度/色调/饱和度
 \attention \n
无

 \param[out] u32Hue   亮度/对比度/色调/饱和度

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_GetSDPictureSetting(HI_PQ_PICTURE_SETTING_S* pstSetting)
{
    PQ_CHECK_NULL_PTR(pstSetting);

    pstSetting->u16Brightness  = stPqParam.stSDPictureSetting.u16Brightness;
    pstSetting->u16Contrast    = stPqParam.stSDPictureSetting.u16Contrast;
    pstSetting->u16Hue         = stPqParam.stSDPictureSetting.u16Hue;
    pstSetting->u16Saturation  = stPqParam.stSDPictureSetting.u16Saturation;

    return HI_SUCCESS;
}


/**
 \brief 设置图形高清亮度/对比度/色调/饱和度
 \attention \n
无

 \param[in] u32Hue   亮度/对比度/色调/饱和度

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_SetHDPictureSetting(HI_PQ_PICTURE_SETTING_S* pstSetting)
{
    HI_S32 s32Ret = HI_FAILURE;

    PQ_CHECK_NULL_PTR(pstSetting);

    if ((pstSetting->u16Brightness > 100)
        || (pstSetting->u16Contrast > 100)
        || (pstSetting->u16Saturation > 100)
        || (pstSetting->u16Hue > 100))
    {
        HI_ERR_PQ("out of range!\n");
        return HI_FAILURE;
    }

    if (GET_ALG(HI_PQ_MODULE_GFXCSC) && GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->SetGfxCSCPictureSetting)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->SetGfxCSCPictureSetting(HI_PQ_DISPLAY_1, pstSetting);
    }

    stPqParam.stHDPictureSetting.u16Brightness = pstSetting->u16Brightness;
    stPqParam.stHDPictureSetting.u16Contrast   = pstSetting->u16Contrast;
    stPqParam.stHDPictureSetting.u16Hue        = pstSetting->u16Hue;
    stPqParam.stHDPictureSetting.u16Saturation = pstSetting->u16Saturation;

    HI_DEBUG_PQ("SetHDPicture Brightness:%d, Contrast:%d, Hue:%d, Saturation:%d\n", \
                pstSetting->u16Brightness, pstSetting->u16Contrast, pstSetting->u16Hue, pstSetting->u16Saturation);

    return s32Ret;
}


/**
 \brief 设置图形标清亮度/对比度/色调/饱和度
 \attention \n
无

 \param[in] u32Hue   亮度/对比度/色调/饱和度

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_SetSDPictureSetting(HI_PQ_PICTURE_SETTING_S* pstSetting)
{
    HI_S32 s32Ret = HI_FAILURE;

    PQ_CHECK_NULL_PTR(pstSetting);

    if ((pstSetting->u16Brightness > 100)
        || (pstSetting->u16Contrast > 100)
        || (pstSetting->u16Saturation > 100)
        || (pstSetting->u16Hue > 100))
    {
        HI_ERR_PQ("out of range!\n");
        return HI_FAILURE;
    }

    if (GET_ALG(HI_PQ_MODULE_GFXCSC) && GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->SetGfxCSCPictureSetting)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->SetGfxCSCPictureSetting(HI_PQ_DISPLAY_0, pstSetting);
    }

    stPqParam.stSDPictureSetting.u16Brightness = pstSetting->u16Brightness;
    stPqParam.stSDPictureSetting.u16Contrast   = pstSetting->u16Contrast;
    stPqParam.stSDPictureSetting.u16Hue        = pstSetting->u16Hue;
    stPqParam.stSDPictureSetting.u16Saturation = pstSetting->u16Saturation;

    return s32Ret;
}

/**
 \brief 获取清晰度
 \attention \n
无

 \param[out] pu32Sharpness  清晰度, 有效范围: 0~100;

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_GetSharpness(HI_U32* pu32Sharpness)
{
    HI_S32 s32Ret = HI_FAILURE;

    PQ_CHECK_NULL_PTR(pu32Sharpness);

    if (GET_ALG(HI_PQ_MODULE_SHARPNESS) && GET_ALG_FUN(HI_PQ_MODULE_SHARPNESS)->GetStrength)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_SHARPNESS)->GetStrength(pu32Sharpness);
        pqprint(PQ_PRN_SHARPEN, "Get sharpen Level: %d\n", *pu32Sharpness);
    }

    return s32Ret;
}

/**
 \brief 设置清晰度
 \attention \n
无

 \param[in] u32Sharpness, 清晰度, 有效范围: 0~100;

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_SetSharpness(HI_U32 u32Sharpness)
{
    HI_S32 s32Ret = HI_FAILURE;

    if (u32Sharpness > 100)
    {
        HI_ERR_PQ("%d:Sharpness is over range!\n", u32Sharpness);
        return HI_FAILURE;
    }

    if (GET_ALG(HI_PQ_MODULE_SHARPNESS) && GET_ALG_FUN(HI_PQ_MODULE_SHARPNESS)->SetStrength)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_SHARPNESS)->SetStrength(u32Sharpness);
        stPqParam.u32Strength[HI_PQ_MODULE_SHARPNESS] = u32Sharpness;
        pqprint(PQ_PRN_SHARPEN, "Set sharpen level: %d\n", u32Sharpness);
    }

    return s32Ret;
}

/**
 \brief 获取颜色增强
 \attention \n
无

 \param[out] pu32ColorGainLevel

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_GetColorEhance(HI_U32* pu32ColorGainLevel)
{
    HI_S32 s32Ret = HI_FAILURE;

    PQ_CHECK_NULL_PTR(pu32ColorGainLevel);

    if (GET_ALG(HI_PQ_MODULE_COLOR) && GET_ALG_FUN(HI_PQ_MODULE_COLOR)->GetStrength)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_COLOR)->GetStrength(pu32ColorGainLevel);
        pqprint(PQ_PRN_ACM, "Get ColorGainLevel: %d\n", *pu32ColorGainLevel);
    }

    return s32Ret;
}


/**
 \brief 设置颜色增强
 \attention \n
无

 \param[in] u32ColorGainLevel

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_SetColorEhance(HI_U32 u32ColorGainLevel)
{
    HI_S32 s32Ret = HI_FAILURE;

    if (GET_ALG(HI_PQ_MODULE_COLOR) && GET_ALG_FUN(HI_PQ_MODULE_COLOR)->SetStrength)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_COLOR)->SetStrength(u32ColorGainLevel);
        stPqParam.u32Strength[HI_PQ_MODULE_COLOR] = u32ColorGainLevel;
        pqprint(PQ_PRN_ACM, "Set ColorGainLevel: %d\n", u32ColorGainLevel);
    }

    return s32Ret;
}

/**
 \brief 获取肤色增强
 \attention \n
  无

 \param[out] pu32FleshToneLevel

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_GetFleshToneLevel(HI_U32* pu32FleshToneLevel)
{
    HI_S32 s32Ret = HI_FAILURE;

    PQ_CHECK_NULL_PTR(pu32FleshToneLevel);

    if (GET_ALG(HI_PQ_MODULE_COLOR) && GET_ALG_FUN(HI_PQ_MODULE_COLOR)->GetFleshToneLevel)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_COLOR)->GetFleshToneLevel(pu32FleshToneLevel);
        pqprint(PQ_PRN_ACM, "Get FleshToneLevel: %d\n", *pu32FleshToneLevel);
    }

    return s32Ret;
}

/**
 \brief 设置肤色增强
 \attention \n
  无

 \param[in] enFleshToneLevel

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_SetFleshToneLevel(HI_PQ_FLESHTONE_E enFleshToneLevel)
{
    HI_S32 s32Ret = HI_FAILURE;

    stPqParam.stColorEnhance.enColorEnhanceType      = HI_PQ_COLOR_ENHANCE_FLESHTONE;
    stPqParam.stColorEnhance.unColorGain.enFleshtone = enFleshToneLevel;

    if (GET_ALG(HI_PQ_MODULE_COLOR) && GET_ALG_FUN(HI_PQ_MODULE_COLOR)->SetFleshToneLevel)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_COLOR)->SetFleshToneLevel(enFleshToneLevel);
        pqprint(PQ_PRN_ACM, "Set FleshToneLevel: %d\n", enFleshToneLevel);
    }

    return s32Ret;
}

/**
 \brief 六基色控制设置
 \attention \n
  无

 \param[in] enSixColorType;

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_SetSixBaseColorLevel(HI_PQ_SIX_BASE_S* pstSixBaseColorOffset)
{
    HI_S32 s32Ret = HI_FAILURE;

    PQ_CHECK_NULL_PTR(pstSixBaseColorOffset);

    stPqParam.stColorEnhance.enColorEnhanceType    = HI_PQ_COLOR_ENHANCE_SIX_BASE;
    stPqParam.stColorEnhance.unColorGain.stSixBase = *pstSixBaseColorOffset;

    if (GET_ALG(HI_PQ_MODULE_COLOR) && GET_ALG_FUN(HI_PQ_MODULE_COLOR)->SetSixBaseColorLevel)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_COLOR)->SetSixBaseColorLevel(pstSixBaseColorOffset);
        pqprint(PQ_PRN_ACM, "Set SixBaseColor Red:%d, Green: %d, Blue: %d, Cyan: %d, Magenta: %d, Yellow: %d\n",
                pstSixBaseColorOffset->u32Red, pstSixBaseColorOffset->u32Green,
                pstSixBaseColorOffset->u32Blue, pstSixBaseColorOffset->u32Cyan,
                pstSixBaseColorOffset->u32Magenta, pstSixBaseColorOffset->u32Yellow);
    }

    return s32Ret;
}

HI_S32 DRV_PQ_GetSixBaseColorLevel(HI_PQ_SIX_BASE_S* pstSixBaseColorOffset)
{
    HI_S32 s32Ret = HI_FAILURE;

    PQ_CHECK_NULL_PTR(pstSixBaseColorOffset);

    if (GET_ALG(HI_PQ_MODULE_COLOR) && GET_ALG_FUN(HI_PQ_MODULE_COLOR)->GetSixBaseColorLevel)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_COLOR)->GetSixBaseColorLevel(pstSixBaseColorOffset);
        pqprint(PQ_PRN_ACM, "Get SixBaseColor Red:%d, Green: %d, Blue: %d, Cyan: %d, Magenta: %d, Yellow: %d\n",
                pstSixBaseColorOffset->u32Red, pstSixBaseColorOffset->u32Green,
                pstSixBaseColorOffset->u32Blue, pstSixBaseColorOffset->u32Cyan,
                pstSixBaseColorOffset->u32Magenta, pstSixBaseColorOffset->u32Yellow);
    }

    return s32Ret;
}


/**
 \brief 颜色增强模式设置
 \attention \n
  无

 \param[in] enColorSpecMode 0-RECOMMEND;1-BLUE;2-GREEN;3-BG;

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_SetColorEnhanceMode(HI_PQ_COLOR_SPEC_MODE_E enColorSpecMode)
{
    HI_S32 s32Ret = HI_FAILURE;

    stPqParam.stColorEnhance.enColorEnhanceType      = HI_PQ_COLOR_ENHANCE_SPEC_COLOR_MODE;
    stPqParam.stColorEnhance.unColorGain.enColorMode = enColorSpecMode;

    if (GET_ALG(HI_PQ_MODULE_COLOR) && GET_ALG_FUN(HI_PQ_MODULE_COLOR)->SetColorEnhanceMode)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_COLOR)->SetColorEnhanceMode(enColorSpecMode);
        pqprint(PQ_PRN_ACM, "Set ColorEnhanceMode: %d\n", enColorSpecMode);
    }

    return s32Ret;
}

HI_S32 DRV_PQ_GetColorEnhanceMode(HI_PQ_COLOR_SPEC_MODE_E* penColorSpecMode)
{
    HI_S32 s32Ret = HI_FAILURE;

    PQ_CHECK_NULL_PTR(penColorSpecMode);

    if (GET_ALG(HI_PQ_MODULE_COLOR) && GET_ALG_FUN(HI_PQ_MODULE_COLOR)->GetColorEnhanceMode)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_COLOR)->GetColorEnhanceMode(penColorSpecMode);
        pqprint(PQ_PRN_ACM, "Get ColorEnhanceMode: %d\n", *penColorSpecMode);
    }

    return s32Ret;
}


/**
 \brief 设置DCI强度增益等级
 \attention \n
无

 \param[in] u32DCILevelGain;

 \retval ::HI_SUCCESS

 */

HI_S32 DRV_PQ_SetDCILevel(HI_U32 u32DCILevel)
{
    HI_S32 s32Ret = HI_FAILURE;

    if (u32DCILevel > 100)
    {
        HI_ERR_PQ("%d:DCILevelGain is over range!\n", u32DCILevel);
        return HI_FAILURE;
    }

    if (GET_ALG(HI_PQ_MODULE_DCI) && GET_ALG_FUN(HI_PQ_MODULE_DCI)->SetStrength)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_DCI)->SetStrength(u32DCILevel);
        stPqParam.u32Strength[HI_PQ_MODULE_DCI] = u32DCILevel;
        pqprint(PQ_PRN_DCI, "Set DCILevelGain: %d\n", u32DCILevel);
    }

    return s32Ret;
}


HI_S32 DRV_PQ_GetDCILevel(HI_U32* pu32DCILevel)
{
    HI_S32 s32Ret = HI_FAILURE;

    PQ_CHECK_NULL_PTR(pu32DCILevel);

    if (GET_ALG(HI_PQ_MODULE_DCI) && GET_ALG_FUN(HI_PQ_MODULE_DCI)->GetStrength)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_DCI)->GetStrength(pu32DCILevel);
        pqprint(PQ_PRN_DCI, "Get DCI Level: %d\n", *pu32DCILevel);
    }

    return s32Ret;
}

/**
 \brief 获取时域降噪强度
 \attention \n
无

 \param[out] pu32NRLevel: 降噪等级, 有效范围: 0~255

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_GetTnrLevel(HI_U32* pu32TnrLevel)
{
    HI_S32 s32Ret = HI_FAILURE;

    PQ_CHECK_NULL_PTR(pu32TnrLevel);

    if (GET_ALG(HI_PQ_MODULE_TNR) && GET_ALG_FUN(HI_PQ_MODULE_TNR)->GetStrength)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_TNR)->GetStrength(pu32TnrLevel);
        pqprint(PQ_PRN_TNR, "Get TNR Level: %d\n", *pu32TnrLevel);
    }

    return s32Ret;
}

/**
 \brief 设置时域降噪强度
 \attention \n
无

 \param[in] u32tNRLevel: 降噪等级, 有效范围: 0~100

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_SetTnrLevel(HI_U32 u32TnrLevel)
{
    HI_S32 s32Ret = HI_FAILURE;

    if (GET_ALG(HI_PQ_MODULE_TNR) && GET_ALG_FUN(HI_PQ_MODULE_TNR)->SetStrength)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_TNR)->SetStrength(u32TnrLevel);
        stPqParam.u32Strength[HI_PQ_MODULE_TNR] = u32TnrLevel;
        pqprint(PQ_PRN_TNR, "Set TNR Level: %d\n", u32TnrLevel);
    }

    return s32Ret;
}

/**
 \brief 获取空域降噪强度
 \attention \n
无

 \param[out] pu32NRLevel: 降噪等级, 有效范围: 0~255


 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_GetSnrLevel(HI_U32* pu32SnrLevel)
{
    HI_S32 s32Ret = HI_FAILURE;

    PQ_CHECK_NULL_PTR(pu32SnrLevel);

    if (GET_ALG(HI_PQ_MODULE_SNR) && GET_ALG_FUN(HI_PQ_MODULE_SNR)->GetStrength)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_SNR)->GetStrength(pu32SnrLevel);
        pqprint(PQ_PRN_SNR, "Get SNR Level: %d\n", *pu32SnrLevel);
    }

    return s32Ret;
}

/**
 \brief 设置空域降噪强度
 \attention \n
无

 \param[in] u32tNRLevel: 降噪等级, 有效范围: 0~100

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_SetSnrLevel(HI_U32 u32SnrLevel)
{
    HI_S32 s32Ret = HI_FAILURE;

    if (GET_ALG(HI_PQ_MODULE_SNR) && GET_ALG_FUN(HI_PQ_MODULE_SNR)->SetStrength)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_SNR)->SetStrength(u32SnrLevel);
        stPqParam.u32Strength[HI_PQ_MODULE_SNR] = u32SnrLevel;
        pqprint(PQ_PRN_SNR, "Set SNR Level: %d\n", u32SnrLevel);
    }

    return s32Ret;
}

HI_S32 DRV_PQ_GetDbLevel(HI_U32* pu32DbLevel)
{
    HI_S32 s32Ret = HI_FAILURE;

    PQ_CHECK_NULL_PTR(pu32DbLevel);

    if (GET_ALG(HI_PQ_MODULE_DB) && GET_ALG_FUN(HI_PQ_MODULE_DB)->GetStrength)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_DB)->GetStrength(pu32DbLevel);
        pqprint(PQ_PRN_DB_READ, "Get DB Level: %d\n", *pu32DbLevel);
    }

    return s32Ret;
}

HI_S32 DRV_PQ_SetDbLevel(HI_U32 u32DbLevel)
{
    HI_S32 s32Ret = HI_FAILURE;

    if (GET_ALG(HI_PQ_MODULE_DB) && GET_ALG_FUN(HI_PQ_MODULE_DB)->SetStrength)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_DB)->SetStrength(u32DbLevel);
        stPqParam.u32Strength[HI_PQ_MODULE_DB] = u32DbLevel;
        pqprint(PQ_PRN_DB_READ, "Set DB Level: %d\n", u32DbLevel);
    }

    return s32Ret;
}

HI_S32 DRV_PQ_GetDmLevel(HI_U32* pu32DmLevel)
{
    HI_S32 s32Ret = HI_FAILURE;

    PQ_CHECK_NULL_PTR(pu32DmLevel);

    if (GET_ALG(HI_PQ_MODULE_DM) && GET_ALG_FUN(HI_PQ_MODULE_DM)->GetStrength)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_DM)->GetStrength(pu32DmLevel);
        pqprint(PQ_PRN_DM, "Get DM Level: %d\n", *pu32DmLevel);
    }

    return s32Ret;
}

HI_S32 DRV_PQ_SetDmLevel(HI_U32 u32DmLevel)
{
    HI_S32 s32Ret = HI_FAILURE;

    if (GET_ALG(HI_PQ_MODULE_DM) && GET_ALG_FUN(HI_PQ_MODULE_DM)->SetStrength)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_DM)->SetStrength(u32DmLevel);
        stPqParam.u32Strength[HI_PQ_MODULE_DM] = u32DmLevel;
        pqprint(PQ_PRN_DM, "Set DM Level: %d\n", u32DmLevel);
    }

    return s32Ret;
}

/**
 \brief 获取PQ模块开关状态
 \attention \n
  无

 \param[in] enFlags
 \param[out] *pu32OnOff

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_GetPQModule(HI_PQ_MODULE_E enModule, HI_U32* pu32OnOff)
{
    HI_S32 s32Ret = HI_FAILURE;

    PQ_CHECK_NULL_PTR(pu32OnOff);

    if (HI_PQ_MODULE_ALL == enModule)
    {
        *pu32OnOff = stPqParam.bModuleOnOff[HI_PQ_MODULE_ALL];
        s32Ret = HI_SUCCESS;
    }
    else if (GET_ALG(enModule) && GET_ALG_FUN(enModule)->GetEnable)
    {
        s32Ret = GET_ALG_FUN(enModule)->GetEnable(pu32OnOff);
    }

    return s32Ret;
}


/**
 \brief 设置PQ模块开关
 \attention \n
  无

 \param[in] enFlags
 \param[in] u32OnOff

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_SetPQModule(HI_PQ_MODULE_E enModule, HI_U32 u32OnOff)
{
    HI_S32 s32Ret = HI_FAILURE;
    HI_U32 i;

    if (HI_PQ_MODULE_ALL == enModule)
    {
        stPqParam.bModuleOnOff[HI_PQ_MODULE_ALL] = u32OnOff;

        for (i = 0; i < HI_PQ_MODULE_BUTT; i++)
        {
            if (GET_ALG(i) && GET_ALG_FUN(i)->SetEnable)
            {
                s32Ret = GET_ALG_FUN(i)->SetEnable(u32OnOff);
                stPqParam.bModuleOnOff[i] = u32OnOff;
            }
        }
    }
    else if (GET_ALG(enModule) && GET_ALG_FUN(enModule)->SetEnable)
    {
        s32Ret = GET_ALG_FUN(enModule)->SetEnable(u32OnOff);
        stPqParam.bModuleOnOff[enModule] = u32OnOff;
    }

    return s32Ret;
}

/**
 \brief 设置卖场模式开关
 \attention \n
无

 \param[in] enFlags
 \param[in] bOnOff

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_SetDemoMode(HI_PQ_MODULE_E enModule, HI_BOOL bOnOff)
{
    HI_S32 s32Ret = HI_FAILURE;
    HI_U32 i;

    if (HI_PQ_MODULE_ALL == enModule)
    {
        stPqParam.bDemoOnOff[HI_PQ_MODULE_ALL] = bOnOff;

        for (i = 0; i < HI_PQ_MODULE_BUTT; i++)
        {
            if (GET_ALG(i) && GET_ALG_FUN(i)->SetDemo)
            {
                s32Ret = GET_ALG_FUN(i)->SetDemo(bOnOff);
                stPqParam.bDemoOnOff[i] = bOnOff;
            }
        }
    }
    else if (GET_ALG(enModule) && GET_ALG_FUN(enModule)->SetDemo)
    {
        s32Ret = GET_ALG_FUN(enModule)->SetDemo(bOnOff);
        stPqParam.bDemoOnOff[enModule] = bOnOff;
    }

    return s32Ret;
}

/* set demo display mode */
HI_S32 DRV_PQ_SetDemoDispMode(PQ_REG_TYPE_E enType, HI_PQ_DEMO_MODE_E enDemoMode)
{
    HI_S32 s32Ret = HI_FAILURE;
    HI_U32 i = 0;
    PQ_DEMO_MODE_E enSetMode = PQ_DEMO_ENABLE_L;

    if ((HI_PQ_DEMO_MODE_FIXED_R == enDemoMode) || (HI_PQ_DEMO_MODE_SCROLL_R == enDemoMode))
    {
        enSetMode = PQ_DEMO_ENABLE_R;
    }
    else if ((HI_PQ_DEMO_MODE_FIXED_L == enDemoMode) || (HI_PQ_DEMO_MODE_SCROLL_L == enDemoMode))
    {
        enSetMode = PQ_DEMO_ENABLE_L;
    }

    for (i = 0; i < HI_PQ_MODULE_BUTT; i++)
    {
        if (GET_ALG(i) && GET_ALG_FUN(i)->SetDemoMode)
        {
            if (enType != PQ_COMM_GetAlgTypeID(i))
            {
                continue;
            }

            s32Ret = GET_ALG_FUN(i)->SetDemoMode(enSetMode);
        }
    }

    stPqParam.enDemoMode = enDemoMode;
    return s32Ret;
}

/**
 \brief get demo display mode
 \attention \n
  无

 \param[in] penDemoMode ;

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_GetDemoDispMode(HI_PQ_DEMO_MODE_E* penDemoMode)
{
    PQ_CHECK_NULL_PTR(penDemoMode);

    *penDemoMode = stPqParam.enDemoMode;

    return HI_SUCCESS;
}

static HI_VOID DRV_PQ_RefreshMktCoordinate(PQ_REG_TYPE_E enType)
{
    /* DEMO */
    HI_U32 i = 0;
    HI_U32 u32Step = 1;
    static HI_U32 s_u32Pos = 0;

    if ((HI_PQ_DEMO_MODE_FIXED_R == stPqParam.enDemoMode) || (HI_PQ_DEMO_MODE_FIXED_L == stPqParam.enDemoMode))
    {
        DRV_PQ_SetDemoCoordinate(enType, sg_u32DemoCoordinate);
        return;
    }

    for (i = 0; i < HI_PQ_MODULE_BUTT; i++)
    {
        if ((HI_NULL == GET_ALG(i)) || (HI_NULL == GET_ALG_FUN(i)->SetDemoModeCoor))
        {
            continue;
        }

        if (enType != PQ_COMM_GetAlgTypeID(i))
        {
            continue;
        }

        /* set demo display mode*/
        if ((HI_PQ_DEMO_MODE_SCROLL_R == stPqParam.enDemoMode) || (HI_PQ_DEMO_MODE_SCROLL_L == stPqParam.enDemoMode))
        {
            if (0 == g_u32ImageWidth)
            {
                return;
            }

            if (REG_TYPE_VPSS == enType)
            {
                GET_ALG_FUN(i)->SetDemoModeCoor(s_u32Pos);
            }
            else if (REG_TYPE_VDP == enType)
            {
                GET_ALG_FUN(i)->SetDemoModeCoor(s_u32Pos * g_u32OutWidth / g_u32ImageWidth);
            }
        }
    }

    s_u32Pos = s_u32Pos + u32Step;
    if (g_u32ImageWidth < s_u32Pos)
    {
        s_u32Pos = 0;
    }

    return;
}

HI_S32 DRV_PQ_SetDemoCoordinate(PQ_REG_TYPE_E enType, HI_U32 u32X)
{
    HI_U32 i;

    if (u32X > 100)
    {
        return HI_FAILURE;
    }

    sg_u32DemoCoordinate = u32X;

    for (i = 0; i < HI_PQ_MODULE_BUTT; i++)
    {
        if ((HI_NULL == GET_ALG(i)) || (HI_NULL == GET_ALG_FUN(i)->SetDemoModeCoor))
        {
            continue;
        }

        if (enType != PQ_COMM_GetAlgTypeID(i))
        {
            continue;
        }

        /* set demo display mode*/
        if (REG_TYPE_VPSS == enType)
        {
            GET_ALG_FUN(i)->SetDemoModeCoor(g_u32ImageWidth * u32X / 100);
        }
        else if (REG_TYPE_VDP == enType)
        {
            GET_ALG_FUN(i)->SetDemoModeCoor(g_u32OutWidth * u32X / 100);
        }
    }

    return HI_SUCCESS;
}

HI_S32 DRV_PQ_GetDemoCoordinate(HI_U32* pu32X)
{
    PQ_CHECK_NULL_PTR(pu32X);

    *pu32X = sg_u32DemoCoordinate;

    return HI_SUCCESS;
}

static HI_VOID DRV_PQ_RefreshVdpCfg(HI_VOID)
{
    DRV_PQ_RefreshMktCoordinate(REG_TYPE_VDP);

    return;
}

static HI_S32 DRV_PQ_ResetPqStatusParam(PQ_REG_TYPE_E enType)
{
    HI_S32 s32Ret = HI_SUCCESS;
    HI_U32 i = 0;

    for (i = 0; i < HI_PQ_MODULE_BUTT; i++)
    {
        if (HI_NULL == GET_ALG(i))
        {
            continue;
        }

        if (enType != PQ_COMM_GetAlgTypeID(i))
        {
            continue;
        }

        if (GET_ALG_FUN(i)->SetEnable)
        {
            s32Ret = GET_ALG_FUN(i)->SetEnable(stPqParam.bModuleOnOff[i]);
            if (HI_SUCCESS != s32Ret)
            {
                HI_ERR_PQ("Alg ID:%d, SetEnable error!\n", i);
            }
        }

        if (GET_ALG_FUN(i)->SetDemo)
        {
            s32Ret = GET_ALG_FUN(i)->SetDemo(stPqParam.bDemoOnOff[i]);
            if (HI_SUCCESS != s32Ret)
            {
                HI_ERR_PQ("Alg ID:%d, SetDemo error!\n", i);
            }
        }

        if (GET_ALG_FUN(i)->SetStrength)
        {
            s32Ret = GET_ALG_FUN(i)->SetStrength(stPqParam.u32Strength[i]);
            if (HI_SUCCESS != s32Ret)
            {
                HI_ERR_PQ("Alg ID:%d, SetStrength error!\n", i);
            }
        }
    }

    return s32Ret;
}

/**
 \brief Timming变化后进行VPSS PQ参数更新
 \attention \n
无

 \param[in]  *u32HandleNo:   VPSS通道号
 \param[in]  *pstTimingInfo: Timming Info
 \param[in]  *pstVPSSReg:    VPSS 虚拟寄存器地址
 \param[out] *pstPQModule:   PQ传给驱动的开关参数

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_UpdateVpssPQ(HI_U32 u32HandleNo, HI_VPSS_PQ_INFO_S* pstTimingInfo, PQ_VPSS_CFG_REG_S* pstVPSSReg, PQ_VPSS_WBC_REG_S* pstWbcReg, HI_PQ_VPSS_MODULE_S* pstPQModule)
{
    HI_S32 s32Ret;

    PQ_HAL_UpdateVpssReg(u32HandleNo, pstVPSSReg, pstWbcReg);

    if (pstVPSSReg != HI_NULL && pstTimingInfo != HI_NULL)
    {
        pqprint(PQ_PRN_VPSS, "[%s]: HandleNo:%d, Width:%d, Height:%d, FrameRate:%d, Interlace:%d\n",
                __FUNCTION__, u32HandleNo, pstTimingInfo->u32Width, pstTimingInfo->u32Height,
                pstTimingInfo->u32FrameRate, pstTimingInfo->bInterlace);

        g_u32ImageWidth  = pstTimingInfo->u32Width;
        g_u32ImageHeight = pstTimingInfo->u32Height;
        g_u32SourceMode  = PQ_MNG_CheckSourceMode(pstTimingInfo->u32Width, pstTimingInfo->u32Height);

        /* Load VPSS Physical Register */
        s32Ret = PQ_MNG_LoadPhyList(REG_TYPE_VPSS, g_u32SourceMode, g_u32OutputMode);
        if (HI_SUCCESS != s32Ret)
        {
            HI_ERR_PQ("PQ_MNG_LoadPhyList VPSS failed!\n");
            return s32Ret;
        }

        if (GET_ALG(HI_PQ_MODULE_DS) && GET_ALG_FUN(HI_PQ_MODULE_DS)->SetDeShootThr)
        {
            /* Refresh DS API CFG */
            s32Ret = GET_ALG_FUN(HI_PQ_MODULE_DS)->SetDeShootThr(u32HandleNo, pstTimingInfo->u32Width);

            if (HI_SUCCESS != s32Ret)
            {
                HI_ERR_PQ("DS CfgRefresh failed!\n");
                return s32Ret;
            }
        }

        /* Ifmd Para cfg Init again; consumer problem: when scene change, the convergence time of field mode detection too long, need init again */
        if (GET_ALG(HI_PQ_MODULE_FMD) && GET_ALG_FUN(HI_PQ_MODULE_FMD)->SofeParaInitByHandle)
        {
            s32Ret = GET_ALG_FUN(HI_PQ_MODULE_FMD)->SofeParaInitByHandle(u32HandleNo);
            if (HI_SUCCESS != s32Ret)
            {
                HI_ERR_PQ("SofeParaInitByHandle failed!\n");
                return s32Ret;
            }
        }

        //PQ_MNG_UpdataVpssPQ(u32HandleNo, pstTimingInfo);

        if (GET_ALG(HI_PQ_MODULE_DB) && GET_ALG_FUN(HI_PQ_MODULE_DB)->DBCfgRefresh)
        {
            /* Refresh DB API CFG */
            s32Ret = GET_ALG_FUN(HI_PQ_MODULE_DB)->DBCfgRefresh(u32HandleNo, pstTimingInfo->u32Height, pstTimingInfo->u32Width, pstTimingInfo->u32FrameRate);

            if (GET_ALG(HI_PQ_MODULE_DM) && GET_ALG_FUN(HI_PQ_MODULE_DM)->DMCfgRefresh)
            {
                /* Refresh DM API CFG */
                s32Ret |= GET_ALG_FUN(HI_PQ_MODULE_DM)->DMCfgRefresh();
            }
            if (HI_SUCCESS != s32Ret)
            {
                HI_ERR_PQ("DB DM CfgRefresh failed!\n");
                return s32Ret;
            }
        }

        /*************************************************************************
            *   reset vpss customer pq setting
            *************************************************************************/
        s32Ret = DRV_PQ_ResetPqStatusParam(REG_TYPE_VPSS);
        if (HI_SUCCESS != s32Ret)
        {
            HI_ERR_PQ("ResetPqStatusParam VPSS failed!\n");
        }

        /* set demo mode*/
        DRV_PQ_SetDemoDispMode(REG_TYPE_VPSS, stPqParam.enDemoMode);
        DRV_PQ_SetDemoCoordinate(REG_TYPE_VPSS, sg_u32DemoCoordinate);
    }

    return HI_SUCCESS;
}

/**
 \brief Timming变化后进行VDP PQ参数更新
 \attention \n
无

 \param[in] pstTimingInfo: Timming Info
 \param[in] *pstVDPReg:VDP 虚拟寄存器地址

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_UpdateVdpPQ(HI_PQ_DISPLAY_E enDisplayId, HI_VDP_PQ_INFO_S* pstTimingInfo, S_VDP_REGS_TYPE* pstVDPReg)
{
    HI_S32      s32Ret;
    HI_U32      u32TmpOutputMode;
    HI_BOOL     bTimingChange = HI_FALSE;
    HI_PQ_DCI_WIN_S stDciWin;
    static HI_VDP_PQ_INFO_S stTimingInfo[HI_PQ_DISPLAY_BUTT] = {{0}};

    /* Update VDP Register point */
    PQ_HAL_UpdateVdpReg(pstVDPReg);
    /* Update VDP confignure every interrupt */
    DRV_PQ_RefreshVdpCfg();

    /*DCI scene change software alg*/
    if (GET_ALG(HI_PQ_MODULE_DCI) && (GET_ALG_FUN(HI_PQ_MODULE_DCI)->CalDCIScd))
    {
        GET_ALG_FUN(HI_PQ_MODULE_DCI)->CalDCIScd();
    }

    if (pstVDPReg != HI_NULL && pstTimingInfo != HI_NULL)
    {
        pqprint(PQ_PRN_VDP, "[%s]: DisplayId:%d, enLayerId:%d, Width:%d, Height:%d, OutWidth:%d, OutHeight:%d, bSRState:%d, b3dType:%d\n",
                __FUNCTION__, enDisplayId, pstTimingInfo->enLayerId, pstTimingInfo->u32Width, pstTimingInfo->u32Height,
                pstTimingInfo->stVideo.s32Width, pstTimingInfo->stVideo.s32Height, pstTimingInfo->bSRState, pstTimingInfo->b3dType);
        pqprint(PQ_PRN_VDP, "bProgressive:%d, Width:%d, Height:%d,  s32X:%d, s32Y:%d, u32RefreshRate:%d\n",
                pstTimingInfo->stChannelTiming[enDisplayId].bProgressive, pstTimingInfo->stChannelTiming[enDisplayId].stFmtRect.s32Width,
                pstTimingInfo->stChannelTiming[enDisplayId].stFmtRect.s32Height, pstTimingInfo->stChannelTiming[enDisplayId].stFmtRect.s32X,
                pstTimingInfo->stChannelTiming[enDisplayId].stFmtRect.s32Y,
                pstTimingInfo->stChannelTiming[enDisplayId].u32RefreshRate);

        bTimingChange  =  (stTimingInfo[enDisplayId].u32Width != pstTimingInfo->u32Width)
                          || (stTimingInfo[enDisplayId].u32Height != pstTimingInfo->u32Height)
                          || (stTimingInfo[enDisplayId].stVideo.s32Width != pstTimingInfo->stVideo.s32Width)
                          || (stTimingInfo[enDisplayId].stVideo.s32Height != pstTimingInfo->stVideo.s32Height)
                          || (stTimingInfo[enDisplayId].bSRState != pstTimingInfo->bSRState)
                          || (stTimingInfo[enDisplayId].b3dType != pstTimingInfo->b3dType)
                          || (0 != memcmp((HI_VOID*)&g_stPqStatus.stTimingInfo[enDisplayId], &pstTimingInfo->stChannelTiming[enDisplayId], sizeof(HI_VDP_CHANNEL_TIMING_S)));

        if ((HI_TRUE == pstTimingInfo->bPartUpdate) && (HI_FALSE == bTimingChange))
        {
            return HI_SUCCESS;
        }

        if ((HI_PQ_DISPLAY_1 == enDisplayId)
            && (stTimingInfo[HI_PQ_DISPLAY_1].u32Width != pstTimingInfo->u32Width)
            && GET_ALG(HI_PQ_MODULE_SNR) && (GET_ALG_FUN(HI_PQ_MODULE_SNR)->SetSNRMotionEdgeLut))
        {
            GET_ALG_FUN(HI_PQ_MODULE_SNR)->SetSNRMotionEdgeLut(pstTimingInfo->u32Width);
        }

        memcpy(&stTimingInfo[enDisplayId], pstTimingInfo, sizeof(HI_VDP_PQ_INFO_S));
        memcpy(&(g_stPqStatus.stTimingInfo[enDisplayId]), &(pstTimingInfo->stChannelTiming[enDisplayId]), sizeof(HI_VDP_CHANNEL_TIMING_S));

        /*ignored sd*/
        if (HI_PQ_DISPLAY_0 == enDisplayId)
        {
            return HI_SUCCESS;
        }

        g_u32ImageWidth  = pstTimingInfo->u32Width;
        g_u32ImageHeight = pstTimingInfo->u32Height;
        g_u32SourceMode = PQ_MNG_CheckSourceMode(pstTimingInfo->u32Width, pstTimingInfo->u32Height);
        u32TmpOutputMode = PQ_MNG_CheckOutputMode(pstTimingInfo->stChannelTiming[enDisplayId].stFmtRect.s32Width);
        g_stPqStatus.bIsogenyMode = pstTimingInfo->bIsogenyMode;
        g_stPqStatus.b3dType      = pstTimingInfo->b3dType;

        if ((HI_PQ_DISPLAY_1 == enDisplayId) && (PQ_VDP_LAYER_VID0 ==  pstTimingInfo->enLayerId))
        {
            g_u32OutWidth   = pstTimingInfo->stVideo.s32Width;
            g_u32OutHeight  = pstTimingInfo->stVideo.s32Height;
            g_u32OutputMode = u32TmpOutputMode;

            stDciWin.u16HStar = 0;
            stDciWin.u16HEnd  = g_u32OutWidth;
            stDciWin.u16VStar = 0;
            stDciWin.u16VEnd  = g_u32OutHeight;

            DRV_PQ_UpdateDCIWin(&stDciWin, HI_TRUE);
        }

        /* Load VDP Physical Register */
        if (HI_TRUE == pstTimingInfo->bPartUpdate)
        {
            /*Set Partly update*/
            s32Ret = PQ_MNG_LoadMultiList(REG_TYPE_VDP, g_u32SourceMode, u32TmpOutputMode);
            if (HI_SUCCESS != s32Ret)
            {
                HI_ERR_PQ("PQ_MNG_LoadMultiList VDP failed!\n");
                return s32Ret;
            }

            /* Set Color Enhance */
            //s32Ret = PQ_MNG_SetACMGain(sg_u32SourceMode);
            //if (HI_SUCCESS != s32Ret)
            //{
            //    HI_ERR_PQ("Set ACMGain failed!\n");
            //    return s32Ret;
            //}
        }
        else
        {
            /*Set FULL update*/
            s32Ret = PQ_MNG_LoadPhyList(REG_TYPE_VDP, g_u32SourceMode, u32TmpOutputMode);
            if (HI_SUCCESS != s32Ret)
            {
                HI_ERR_PQ("PQ_MNG_LoadPhyList VDP failed!\n");
                return s32Ret;
            }

            /*Set Picture Setting*/
            if (GET_ALG(HI_PQ_MODULE_CSC) && GET_ALG_FUN(HI_PQ_MODULE_CSC)->SetCSCVideoSetting)
            {
                GET_ALG_FUN(HI_PQ_MODULE_CSC)->SetCSCVideoSetting(HI_PQ_DISPLAY_0, (HI_PQ_PICTURE_SETTING_S*)&stPqParam.stSDVideoSetting);
                GET_ALG_FUN(HI_PQ_MODULE_CSC)->SetCSCVideoSetting(HI_PQ_DISPLAY_1, (HI_PQ_PICTURE_SETTING_S*)&stPqParam.stHDVideoSetting);
            }

            /* Set Color Enhance */
            if (HI_PQ_COLOR_ENHANCE_FLESHTONE == stPqParam.stColorEnhance.enColorEnhanceType)
            {
                s32Ret = DRV_PQ_SetFleshToneLevel(stPqParam.stColorEnhance.unColorGain.enFleshtone);
            }
            else if (HI_PQ_COLOR_ENHANCE_SIX_BASE == stPqParam.stColorEnhance.enColorEnhanceType)
            {
                HI_PQ_SIX_BASE_S* pstPQSixBase = &(stPqParam.stColorEnhance.unColorGain.stSixBase);
                s32Ret = DRV_PQ_SetSixBaseColorLevel(pstPQSixBase);
            }
            else if (HI_PQ_COLOR_ENHANCE_SPEC_COLOR_MODE == stPqParam.stColorEnhance.enColorEnhanceType)
            {
                s32Ret = DRV_PQ_SetColorEnhanceMode(stPqParam.stColorEnhance.unColorGain.enColorMode);
            }

            /* Update Coef */
            if (GET_ALG(HI_PQ_MODULE_DCI))
            {
                if (GET_ALG_FUN(HI_PQ_MODULE_DCI)->SetResume)
                {
                    GET_ALG_FUN(HI_PQ_MODULE_DCI)->SetResume(!g_bLoadPqBin);
                }

                if (GET_ALG_FUN(HI_PQ_MODULE_DCI)->UpdatDCICoef)
                {
                    GET_ALG_FUN(HI_PQ_MODULE_DCI)->UpdatDCICoef(PQ_VDP_LAYER_VID0);
                }
            }

            if (GET_ALG(HI_PQ_MODULE_COLOR) && GET_ALG_FUN(HI_PQ_MODULE_COLOR)->UpdatACMCoef)
            {
                GET_ALG_FUN(HI_PQ_MODULE_COLOR)->UpdatACMCoef(PQ_VDP_LAYER_VP0);
            }

        }

        /* set isogeny mode */

        if (GET_ALG(HI_PQ_MODULE_CSC) && GET_ALG_FUN(HI_PQ_MODULE_CSC)->SetIsogenyMode)
        {
            GET_ALG_FUN(HI_PQ_MODULE_CSC)->SetIsogenyMode(pstTimingInfo->bIsogenyMode);
        }

        /*************************************************************************
         *   reset VDP customer pq setting
         *************************************************************************/

        s32Ret = DRV_PQ_ResetPqStatusParam(REG_TYPE_VDP);
        if (HI_SUCCESS != s32Ret)
        {
            HI_ERR_PQ("ResetPqStatusParam VDP failed!\n");
        }

        /* set demo mode*/
        DRV_PQ_SetDemoDispMode(REG_TYPE_VDP, stPqParam.enDemoMode);
        DRV_PQ_SetDemoCoordinate(REG_TYPE_VDP, sg_u32DemoCoordinate);
    }

    return HI_SUCCESS;
}


/**
 \brief 设置各通道的CSC
 \attention \n
无

 \param[in] enDisplayId:
 \param[in] pstCscMode: 色彩空间

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_UpdateVdpCSC(HI_PQ_CSC_TYPE_E enCscTypeId, HI_PQ_VDP_CSC_S* pstCscMode)
{
    return HI_SUCCESS;
}

/**
 \brief 更新DCI直方图统计窗口
 \attention \n
无

 \param[in] *pstWin;

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_UpdateDCIWin(HI_PQ_DCI_WIN_S* pstWin, HI_BOOL bDciEnable)
{
    HI_S32 s32Ret = HI_FAILURE;

    PQ_CHECK_NULL_PTR(pstWin);

    if (GET_ALG(HI_PQ_MODULE_DCI) && GET_ALG_FUN(HI_PQ_MODULE_DCI)->UpdateDCIWin)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_DCI)->UpdateDCIWin(pstWin);
        pqprint(PQ_PRN_DCI, "[%s]: HStar:%d, HEnd: %d, VStar: %d, VEnd:%d, bDciEnable:%d\n",
                __FUNCTION__, pstWin->u16HStar, pstWin->u16HEnd, pstWin->u16VStar,
                pstWin->u16VEnd, bDciEnable);
    }

    return s32Ret;
}

/**
 \brief 获取CSC系数
 \attention \n
无

 \param[in]  pstCscCtrl:
 \param[in]  enCSCMode:
 \param[out] pstCSCCoef:
 \param[out] pstCSCDCCoef:

 \retval ::HI_SUCCESS

 */

/* Vedio CSC Port must Every frame  */
HI_S32 DRV_PQ_GetCSCCoef(HI_PQ_CSC_CRTL_S* pstCscCtrl, HI_PQ_CSC_MODE_E enCscMode, HI_PQ_CSC_COEF_S* pstCscCoef, HI_PQ_CSC_DCCOEF_S* pstCscDcCoef)
{
    HI_S32 s32Ret = HI_FAILURE;

    if (GET_ALG(HI_PQ_MODULE_CSC) && GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCCoef)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetCSCCoef(pstCscCtrl, enCscMode, pstCscCoef, pstCscDcCoef);
    }

    return s32Ret;
}


/* Gfx CSC Port must Every frame  */
HI_S32 DRV_PQ_SetGfxCscCoef(HI_PQ_GFX_LAYER_E enGfxCscLayer, HI_PQ_GFX_CSC_PARA_S* pstGfxCscPara)
{
    HI_S32 s32Ret = HI_FAILURE;

    if (GET_ALG(HI_PQ_MODULE_GFXCSC) && GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->SetGfxCscCoef)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->SetGfxCscCoef(enGfxCscLayer, pstGfxCscPara);
    }

    return s32Ret;
}


/**
 \brief 获取8bit CSC系数
 \attention \n
无

 \param[in] enCSCMode:
 \param[out] pstCSCCoef:
 \param[out] pstCSCDCCoef:

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_Get8BitCSCCoef(HI_PQ_CSC_MODE_E  enCSCMode, HI_PQ_CSC_COEF_S* pstCSCCoef, HI_PQ_CSC_DCCOEF_S* pstCSCDCCoef)
{
    HI_S32 s32Ret = HI_FAILURE;

    if (GET_ALG(HI_PQ_MODULE_CSC) && GET_ALG_FUN(HI_PQ_MODULE_CSC)->Get8BitCSCCoef)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_CSC)->Get8BitCSCCoef(enCSCMode, pstCSCCoef, pstCSCDCCoef);
    }

    return s32Ret;
}

HI_S32 DRV_PQ_GetWcgGmmCoef(HI_U32 u32Layer, HI_PQ_GAMM_PARA_S* pstGmmCoef, HI_U32* pu32GamPre)
{
    HI_S32 s32Ret = HI_FAILURE;

    if (GET_ALG(HI_PQ_MODULE_CSC) && GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetWcgGmmCoef)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetWcgGmmCoef(u32Layer, pstGmmCoef, pu32GamPre);
    }

    return s32Ret;
}

HI_S32 DRV_PQ_GetWcgDeGmmCoef(HI_U32 u32Layer, HI_PQ_GAMM_PARA_S* pstDeGmmCoef, HI_U32* pu32DeGamPre)
{
    HI_S32 s32Ret = HI_FAILURE;

    if (GET_ALG(HI_PQ_MODULE_CSC) && GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetWcgDeGmmCoef)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_CSC)->GetWcgDeGmmCoef(u32Layer, pstDeGmmCoef, pu32DeGamPre);
    }

    return s32Ret;
}

HI_S32 DRV_PQ_GetGfxWcgGmmCoef(HI_U32 u32Layer, HI_PQ_GAMM_PARA_S* pstGmmCoef, HI_U32* pu32GamPre)
{
    HI_S32 s32Ret = HI_FAILURE;

    if (GET_ALG(HI_PQ_MODULE_GFXCSC) && GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->GetWcgGmmCoef)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->GetGfxWcgGmmCoef(u32Layer, pstGmmCoef, pu32GamPre);
    }

    return s32Ret;
}

HI_S32 DRV_PQ_GetGfxWcgDeGmmCoef(HI_U32 u32Layer, HI_PQ_GAMM_PARA_S* pstDeGmmCoef, HI_U32* pu32DeGamPre)
{
    HI_S32 s32Ret = HI_FAILURE;

    if (GET_ALG(HI_PQ_MODULE_GFXCSC) && GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->GetWcgDeGmmCoef)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_GFXCSC)->GetGfxWcgDeGmmCoef(u32Layer, pstDeGmmCoef, pu32DeGamPre);
    }

    return s32Ret;
}

HI_S32 DRV_PQ_SetZme(HI_PQ_ZME_LAYER_E enLayerId, HI_PQ_ZME_PARA_IN_S* pstZmeDrvPara, HI_BOOL  bFirEnable)
{
    HI_S32 s32Ret = HI_FAILURE;
    if (GET_ALG(HI_PQ_MODULE_ZME) && GET_ALG_FUN(HI_PQ_MODULE_ZME)->SetVdpZme)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_ZME)->SetVdpZme(enLayerId, pstZmeDrvPara, bFirEnable);
    }

    return s32Ret;
}

HI_S32 DRV_PQ_SetVpssZme(HI_PQ_VPSS_ZME_LAYER_E enLayerId, S_CAS_REGS_TYPE* pstReg, HI_PQ_ZME_PARA_IN_S* pstZmePara, HI_BOOL  bFirEnable)
{
    HI_S32 s32Ret = HI_FAILURE;
    if (GET_ALG(HI_PQ_MODULE_ZME) && GET_ALG_FUN(HI_PQ_MODULE_ZME)->SetVpssZme)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_ZME)->SetVpssZme(enLayerId, pstReg, pstZmePara, bFirEnable);
    }

    return s32Ret;
}

HI_S32 DRV_PQ_GetVdpZmeCoef(HI_PQ_ZME_COEF_RATIO_E enCoefRatio, HI_PQ_ZME_COEF_TYPE_E enCoefType, HI_PQ_ZME_TAP_E enZmeTap, HI_S16* ps16Coef)
{
    HI_S32 s32Ret = HI_FAILURE;

    PQ_CHECK_NULL_PTR(ps16Coef);

    if (GET_ALG(HI_PQ_MODULE_ZME) && GET_ALG_FUN(HI_PQ_MODULE_ZME)->GetZmeCoef)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_ZME)->GetZmeCoef(enCoefRatio, enCoefType, enZmeTap, ps16Coef);
    }

    return s32Ret;

}

HI_S32 DRV_PQ_GetVdpZmeStrategy (HI_PQ_ZME_LAYER_E enLayerId, HI_PQ_ZME_STRATEGY_IN_U* pstZmeIn, HI_PQ_ZME_STRATEGY_OUT_U* pstZmeOut)
{
    HI_S32 s32Ret = HI_FAILURE;

    PQ_CHECK_NULL_PTR(pstZmeIn);
    PQ_CHECK_NULL_PTR(pstZmeOut);

    if (GET_ALG(HI_PQ_MODULE_ZME) && GET_ALG_FUN(HI_PQ_MODULE_ZME)->GetVdpZmeStrategy)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_ZME)->GetVdpZmeStrategy(enLayerId, pstZmeIn, pstZmeOut);
    }

    return s32Ret;
}

/**
 \brief VPSS ZME二级缩放校验;
 \attention \n
无

 \param[in]
 u32InWitdh: 输入宽; u32InHeigh: 输入高; stZmeWin: 各层输出宽高;

 \param[out]
 u32OutWitdh 输出宽; u32OutHeigh 输出高;

 \retval : HI_SUCCESS : 需要二级缩放
           HI_FAILURE : 不需要二级缩放

 */
HI_S32 DRV_PQ_ZME_2L_Check(HI_U32 u32InWitdh, HI_U32 u32InHeigh, HI_PQ_ZME_WIN_S stZmeWin, HI_U32* pu32OutWitdh, HI_U32* pu32OutHeigh)
{
    HI_S32 s32Ret = HI_FAILURE;
    if (GET_ALG(HI_PQ_MODULE_ZME) && GET_ALG_FUN(HI_PQ_MODULE_ZME)->CheckZme2L)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_ZME)->CheckZme2L(u32InWitdh, u32InHeigh, stZmeWin, pu32OutWitdh, pu32OutHeigh);
    }

    return s32Ret;
}


/**
 \brief 获取WbcInfo信息
 \attention \n
无

 \param[in]  HI_PQ_WBC_INFO_S* pstWbcInfo

 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_GetWbcInfo(HI_PQ_WBC_INFO_S* pstVpssWbcInfo)
{
    HI_S32 s32Ret = HI_FAILURE;

    PQ_CHECK_NULL_PTR(pstVpssWbcInfo);

    if (HI_FALSE == pstVpssWbcInfo->bProgressive) /* interace */
    {
        if (GET_ALG(HI_PQ_MODULE_DEI) && GET_ALG_FUN(HI_PQ_MODULE_DEI)->SetDeiParam)
        {
            s32Ret = GET_ALG_FUN(HI_PQ_MODULE_DEI)->SetDeiParam(pstVpssWbcInfo);
        }
    }

    return s32Ret;
}

static HI_S32 DRV_PQ_SetAlgIPSel(HI_PQ_ALGIP_SEL_E  enAlgIPSel)
{
    HI_S32 s32Ret;
    PQ_REG_TYPE_E enPqRegType = REG_TYPE_VPSS;

    if (HI_PQ_ALGIP_SEL_VDP == enAlgIPSel)
    {
        enPqRegType = REG_TYPE_VDP;
    }
    else if (HI_PQ_ALGIP_SEL_VPSS == enAlgIPSel)
    {
        enPqRegType = REG_TYPE_VPSS;
    }

#ifdef PQ_ALG_TNR
    PQ_MNG_RegisterTNR(enPqRegType);
#endif
#ifdef PQ_ALG_SNR
    PQ_MNG_RegisterSNR(enPqRegType);
#endif
#ifdef PQ_ALG_DB
    PQ_MNG_RegisterDB(enPqRegType);
#endif
#ifdef PQ_ALG_DM
    PQ_MNG_RegisterDM(enPqRegType);
#endif

    HI_INFO_PQ("Set Alg IPSel to %s\n", !enPqRegType ? "vpss" : "vdp");


    if (GET_ALG(HI_PQ_MODULE_TNR)
        && (REG_TYPE_VDP == PQ_COMM_GetAlgTypeID(HI_PQ_MODULE_TNR))
        && GET_ALG_FUN(HI_PQ_MODULE_TNR)->InitVdpTnr)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_TNR)->InitVdpTnr();
    }

    if (GET_ALG(HI_PQ_MODULE_SNR)
        && (REG_TYPE_VDP == PQ_COMM_GetAlgTypeID(HI_PQ_MODULE_SNR))
        && GET_ALG_FUN(HI_PQ_MODULE_SNR)->InitVdpSnr)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_SNR)->InitVdpSnr();
    }

    if (GET_ALG(HI_PQ_MODULE_DB)
        && (REG_TYPE_VDP == PQ_COMM_GetAlgTypeID(HI_PQ_MODULE_DB))
        && GET_ALG_FUN(HI_PQ_MODULE_DB)->InitVdpDbm)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_DB)->InitVdpDbm();
    }

    if (GET_ALG(HI_PQ_MODULE_DB)
        && (REG_TYPE_VDP == PQ_COMM_GetAlgTypeID(HI_PQ_MODULE_DB))
        && GET_ALG_FUN(HI_PQ_MODULE_DB)->DBCfgRefresh)
    {
        /* Refresh DB API CFG */
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_DB)->DBCfgRefresh(0, g_u32OutHeight, g_u32OutWidth, 0);
    }

    if (GET_ALG(HI_PQ_MODULE_SNR))
    {
        if (GET_ALG_FUN(HI_PQ_MODULE_SNR)->SetSNRMotionEdgeLut)
        {
            GET_ALG_FUN(HI_PQ_MODULE_SNR)->SetSNRMotionEdgeLut(g_u32ImageWidth);
        }
        if (GET_ALG_FUN(HI_PQ_MODULE_SNR)->SetSNRCbCrLut)
        {
            GET_ALG_FUN(HI_PQ_MODULE_SNR)->SetSNRCbCrLut();
        }
        PQ_MNG_LoadPhyListOfAlg(HI_PQ_MODULE_SNR, g_u32SourceMode, g_u32OutputMode);
    }

    if (GET_ALG(HI_PQ_MODULE_DM)
        && (REG_TYPE_VDP == PQ_COMM_GetAlgTypeID(HI_PQ_MODULE_DM)))
    {
        PQ_MNG_LoadPhyListOfAlg(HI_PQ_MODULE_DM, g_u32SourceMode, g_u32OutputMode);
    }

    s32Ret = DRV_PQ_ResetPqStatusParam(enPqRegType);
    if (HI_SUCCESS != s32Ret)
    {
        HI_ERR_PQ("ResetPqStatusParam PqRegType[%d] failed!\n", enPqRegType);
    }

    return s32Ret;
}


/**
 \brief 设置算法运算完之后的寄存器
 \attention \n
无

 \param[in]  *pstWbcInfo
 \param[out] *pstVpssCfgInfo
 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_SetAlgCalcCfg(HI_PQ_WBC_INFO_S* pstVpssWbcInfo, HI_PQ_CFG_INFO_S* pstVpssCfgInfo)
{
    HI_S32 s32Ret = HI_FAILURE;

    /* IFMD */
    HI_PQ_IFMD_CALC_S      stIfmdCalcInfo;
    HI_PQ_IFMD_PLAYBACK_S  stIfmdCalcResult = {0};

    /* DB */
    HI_PQ_DB_CALC_INFO_S  stDbCalcInfo = {0};

    if (HI_NULL == pstVpssWbcInfo)
    {
        HI_ERR_PQ("Wbc Info pointer is null!\n");

        return HI_FAILURE;
    }

    DRV_PQ_RefreshMktCoordinate(REG_TYPE_VPSS);

    /********
     * IFMD  interace
     ********/
    if ((HI_FALSE == pstVpssWbcInfo->bProgressive) && (GET_ALG(HI_PQ_MODULE_FMD) && GET_ALG_FUN(HI_PQ_MODULE_FMD)->IfmdDect))
    {
        /* IFMD Calc Info transfer */
        stIfmdCalcInfo.u32HandleNo       = pstVpssWbcInfo->u32HandleNo;
        stIfmdCalcInfo.u32WidthY         = pstVpssWbcInfo->u32Width;
        stIfmdCalcInfo.u32HeightY        = pstVpssWbcInfo->u32Height;
        stIfmdCalcInfo.s32FieldOrder     = pstVpssWbcInfo->s32FieldOrder;
        stIfmdCalcInfo.s32FieldMode      = pstVpssWbcInfo->s32FieldMode;
        stIfmdCalcInfo.u32FrameRate      = pstVpssWbcInfo->u32FrameRate;
        stIfmdCalcInfo.bPreInfo          = pstVpssWbcInfo->bPreInfo;
        stIfmdCalcInfo.pstIfmdHardOutReg = pstVpssWbcInfo->pstVPSSWbcReg;
        memcpy(&(stIfmdCalcInfo.stVdecInfo), &(pstVpssWbcInfo->stVdecInfo), sizeof(PQ_VDEC_INFO_S));

        /* FMD After Calc Set CFG Reg to Reg */
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_FMD)->IfmdDect(&stIfmdCalcInfo, &stIfmdCalcResult);

        /* fmdCalcResult Tran to Vpss CFG */
        pstVpssCfgInfo->die_reset        = stIfmdCalcResult.die_reset;
        pstVpssCfgInfo->die_stop         = stIfmdCalcResult.die_stop;
        pstVpssCfgInfo->dir_mch          = stIfmdCalcResult.dir_mch;
        pstVpssCfgInfo->die_out_sel      = stIfmdCalcResult.die_out_sel;
        pstVpssCfgInfo->s32FieldOrder    = stIfmdCalcResult.s32FieldOrder;
        pstVpssCfgInfo->s32SceneChanged  = stIfmdCalcResult.s32SceneChanged;
        pstVpssCfgInfo->s32FilmType      = stIfmdCalcResult.s32FilmType;
        pstVpssCfgInfo->u32KeyValue      = stIfmdCalcResult.u32KeyValue;
    }

    /********
     * DB DM
     ********/

    /* DEBUG: CLOSE DB SOFTWARE ALG */
    if (GET_ALG(HI_PQ_MODULE_DB) && GET_ALG_FUN(HI_PQ_MODULE_DB)->DBCalcConfigCfg && (HI_PQ_ALGIP_SEL_VPSS == g_enAlgIPSel))
    {
        HI_S32 s32OriX,  s32OriY,  s32OriWidth,  s32OriHeight;
        HI_S32 s32CropX, s32CropY, s32CropWidth, s32CropHeight;
        /* In practical using, In Vpss Db process before crop,and in vdp Db process after scaler */
        if (HI_TRUE == pstVpssWbcInfo->bCropBeforeDB)
        {
            s32OriX       = pstVpssWbcInfo->stOriCoordinate.s32X;
            s32OriY       = pstVpssWbcInfo->stOriCoordinate.s32Y;
            s32OriWidth   = pstVpssWbcInfo->stOriCoordinate.s32Width;
            s32OriHeight  = pstVpssWbcInfo->stOriCoordinate.s32Height;
            s32CropX      = pstVpssWbcInfo->stCropCoordinate.s32X;
            s32CropY      = pstVpssWbcInfo->stCropCoordinate.s32Y;
            s32CropWidth  = pstVpssWbcInfo->stCropCoordinate.s32Width;
            s32CropHeight = pstVpssWbcInfo->stCropCoordinate.s32Height;

            stDbCalcInfo.u32LeftOffset   = s32OriX - s32CropX;
            stDbCalcInfo.u32TopOffset    = s32OriY - s32CropY;
            stDbCalcInfo.u32RightOffset  = s32OriWidth  - s32CropWidth;
            stDbCalcInfo.u32BottomOffset = s32OriHeight - s32CropHeight;
        }
        else
        {
            stDbCalcInfo.u32LeftOffset   = 0;
            stDbCalcInfo.u32TopOffset    = 0;
            stDbCalcInfo.u32RightOffset  = 0;
            stDbCalcInfo.u32BottomOffset = 0;
        }

        /* DB Clac Info transfer */
        stDbCalcInfo.u32HandleNo       = pstVpssWbcInfo->u32HandleNo;
        stDbCalcInfo.u32BitDepth       = pstVpssWbcInfo->u32BitDepth;
        stDbCalcInfo.u32Width          = pstVpssWbcInfo->u32Width;
        stDbCalcInfo.u32Height         = pstVpssWbcInfo->u32Height;

        stDbCalcInfo.u32SingleModeFlag = pstVpssWbcInfo->u32SingleModeFlag;
        stDbCalcInfo.u32DBDeiEnFlag    = pstVpssWbcInfo->u32DeiEnFlag;
        stDbCalcInfo.u32FlagLine       = pstVpssWbcInfo->s32FieldMode;
        stDbCalcInfo.u32Protocol       = pstVpssWbcInfo->u32Protocol;
        stDbCalcInfo.u32ImageAvgQP     = pstVpssWbcInfo->u32ImageAvgQP;
        stDbCalcInfo.u32VdhInfoAddr    = pstVpssWbcInfo->u32VdhInfoAddr;
        stDbCalcInfo.u32VdhInfoStride  = pstVpssWbcInfo->u32VdhInfoStride;
        stDbCalcInfo.u32ImageStruct    = pstVpssWbcInfo->u32ImageStruct;
        stDbCalcInfo.pstVPSSWbcReg     = pstVpssWbcInfo->pstVPSSWbcReg;

        stDbCalcInfo.bDbBlkPosModeEn   = HI_FALSE;
        stDbCalcInfo.bDbFltDetModeEn   = HI_TRUE;
        /* Filter Control Enable; need judgement condition or not */
        stDbCalcInfo.bDBLumHorEn       = HI_TRUE;
        stDbCalcInfo.bDBLumVerEn       = HI_TRUE;

        /* DB After Calc Set CFG Reg to Reg */
        s32Ret  = GET_ALG_FUN(HI_PQ_MODULE_DB)->DBCalcConfigCfg(&stDbCalcInfo);

        if (GET_ALG(HI_PQ_MODULE_DM) && GET_ALG_FUN(HI_PQ_MODULE_DM)->DMCalcConfigCfg)
        {
            s32Ret |= GET_ALG_FUN(HI_PQ_MODULE_DM)->DMCalcConfigCfg(&stDbCalcInfo);
        }

        if (HI_SUCCESS != s32Ret)
        {
            HI_ERR_PQ("DB DM CalcConfigCfg failed!\n");
            return s32Ret;
        }

        /*
        DRV_PQ_RefreshCfg();
        */
        pqprint(PQ_PRN_FMD_READ, "[%s]: W:%d, H:%d, FldOrder:%d, FldMode:%d, FrmRate:%d, PreInfo:%d,PFrm:%d, PSeq:%d, RealFrmRate:%d\n",
                __FUNCTION__,
                pstVpssWbcInfo->u32Width,
                pstVpssWbcInfo->u32Height,
                pstVpssWbcInfo->s32FieldOrder,
                pstVpssWbcInfo->s32FieldMode,
                pstVpssWbcInfo->u32FrameRate,
                pstVpssWbcInfo->bPreInfo,
                pstVpssWbcInfo->stVdecInfo.IsProgressiveFrm,
                pstVpssWbcInfo->stVdecInfo.IsProgressiveSeq,
                pstVpssWbcInfo->stVdecInfo.RealFrmRate);
        pqprint(PQ_PRN_FMD_CALC, "[%s]: reset:%d, stop:%d, mch:%d, outsel:%d, FldOrder:%d, SceneChang:%d, FilmType:%d, KeyValue:%d\n",
                __FUNCTION__,
                pstVpssCfgInfo->die_reset,
                pstVpssCfgInfo->die_stop,
                pstVpssCfgInfo->dir_mch,
                pstVpssCfgInfo->die_out_sel,
                pstVpssCfgInfo->s32FieldOrder,
                pstVpssCfgInfo->s32SceneChanged,
                pstVpssCfgInfo->s32FilmType,
                pstVpssCfgInfo->u32KeyValue);
        pqprint(PQ_PRN_DB_READ, "[%s]: W:%d, H:%d\n",
                __FUNCTION__,
                pstVpssWbcInfo->u32Width,
                pstVpssWbcInfo->u32Height);
    }

    return HI_SUCCESS;
}


/**
 \brief Vdp设置算法运算完之后的寄存器
 \attention \n

 \param[in]  *pstVdpWbcInfo
 \param[out] *pstVdpCfgInfo
 \retval ::HI_SUCCESS

 */
HI_S32 DRV_PQ_SetVdpAlgCalcCfg(HI_PQ_VDP_WBC_INFO_S* pstVdpWbcInfo)
{
    HI_U32 u32VId = PQ_VDP_LAYER_VID0;
    HI_S32 s32Ret = HI_FAILURE;
    HI_PQ_DB_CALC_INFO_S  stDbCalcInfo = {0};  /* DB */

    if (HI_NULL == pstVdpWbcInfo)
    {
        HI_ERR_PQ("Wbc Info pointer is null!\n");

        return HI_FAILURE;
    }

    if (g_enAlgIPSel != pstVdpWbcInfo->enAlgIPSel)
    {
        g_enAlgIPSel = pstVdpWbcInfo->enAlgIPSel;
        s32Ret = DRV_PQ_SetAlgIPSel(g_enAlgIPSel);
        if (HI_SUCCESS != s32Ret)
        {
            HI_ERR_PQ("SetAlgIPSel failed!\n");
        }
    }

    if (GET_ALG(HI_PQ_MODULE_TNR)
        && GET_ALG_FUN(HI_PQ_MODULE_TNR)->SetVdpTnrParaUpd
        && GET_ALG_FUN(HI_PQ_MODULE_TNR)->SetVdpTnrLutUpd
        && (REG_TYPE_VDP == PQ_COMM_GetAlgTypeID(HI_PQ_MODULE_TNR)))
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_TNR)->SetVdpTnrParaUpd(u32VId);
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_TNR)->SetVdpTnrLutUpd(u32VId);
    }

    if (GET_ALG(HI_PQ_MODULE_SNR)
        && GET_ALG_FUN(HI_PQ_MODULE_SNR)->SetVdpSnrParaUpd
        && (REG_TYPE_VDP == PQ_COMM_GetAlgTypeID(HI_PQ_MODULE_SNR)))
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_SNR)->SetVdpSnrParaUpd(u32VId);
    }

    if (GET_ALG(HI_PQ_MODULE_DB)
        && GET_ALG_FUN(HI_PQ_MODULE_DB)->SetVdpDbmParaUpd
        && (REG_TYPE_VDP == PQ_COMM_GetAlgTypeID(HI_PQ_MODULE_DB)))
    {
        if (GET_ALG_FUN(HI_PQ_MODULE_DB)->SetVdpDbmInfo)
        {
            s32Ret = GET_ALG_FUN(HI_PQ_MODULE_DB)->SetVdpDbmInfo(pstVdpWbcInfo);
        }

        if (GET_ALG_FUN(HI_PQ_MODULE_DB)->SetVdpDbmParaUpd)
        {
            s32Ret = GET_ALG_FUN(HI_PQ_MODULE_DB)->SetVdpDbmParaUpd(u32VId);
        }
    }


    /********
     * DB DM
     ********/

    if (GET_ALG(HI_PQ_MODULE_DB)
        && GET_ALG_FUN(HI_PQ_MODULE_DB)->DBCalcConfigCfg
        && (REG_TYPE_VDP == PQ_COMM_GetAlgTypeID(HI_PQ_MODULE_DB))
        && (PQ_VDP_LAYER_VID0 == pstVdpWbcInfo->enLayerId))
    {
        HI_S32 s32OriX,  s32OriY,  s32OriWidth,  s32OriHeight;
        HI_S32 s32CropX, s32CropY, s32CropWidth, s32CropHeight;

        /* In practical using, In Vpss Db process before crop,and in vdp Db process after scaler */
        if (HI_TRUE == pstVdpWbcInfo->bCropBeforeDB)
        {
            s32OriX       = pstVdpWbcInfo->stOriCoordinate.s32X;
            s32OriY       = pstVdpWbcInfo->stOriCoordinate.s32Y;
            s32OriWidth   = pstVdpWbcInfo->stOriCoordinate.s32Width;
            s32OriHeight  = pstVdpWbcInfo->stOriCoordinate.s32Height;
            s32CropX      = pstVdpWbcInfo->stCropCoordinate.s32X;
            s32CropY      = pstVdpWbcInfo->stCropCoordinate.s32Y;
            s32CropWidth  = pstVdpWbcInfo->stCropCoordinate.s32Width;
            s32CropHeight = pstVdpWbcInfo->stCropCoordinate.s32Height;

            stDbCalcInfo.u32LeftOffset   = s32OriX - s32CropX;
            stDbCalcInfo.u32TopOffset    = s32OriY - s32CropY;
            stDbCalcInfo.u32RightOffset  = s32OriWidth  - s32CropWidth;
            stDbCalcInfo.u32BottomOffset = s32OriHeight - s32CropHeight;
        }
        else
        {
            stDbCalcInfo.u32LeftOffset   = 0;
            stDbCalcInfo.u32TopOffset    = 0;
            stDbCalcInfo.u32RightOffset  = 0;
            stDbCalcInfo.u32BottomOffset = 0;
        }

        /* DB Clac Info transfer */
        stDbCalcInfo.u32HandleNo       = 0;
        stDbCalcInfo.u32BitDepth       = pstVdpWbcInfo->u32BitDepth;
        /* del width and height from vdp; because DB real width and Height is the W and H after Crop*/
        stDbCalcInfo.u32Width          = g_u32OutWidth;
        stDbCalcInfo.u32Height         = g_u32OutHeight;

        stDbCalcInfo.u32SingleModeFlag = pstVdpWbcInfo->u32SingleModeFlag;
        /* must be after dei in vpss; s32FieldMode and u32DeiEnFlag are useless in vdp; */
        stDbCalcInfo.u32DBDeiEnFlag    = 0;
        stDbCalcInfo.u32FlagLine       = 0;
        stDbCalcInfo.u32Protocol       = pstVdpWbcInfo->enVdecProtocol;
        stDbCalcInfo.u32ImageAvgQP     = pstVdpWbcInfo->u32ImageAvgQP;
        stDbCalcInfo.u32VdhInfoAddr    = pstVdpWbcInfo->u32VdhInfoAddr;
        stDbCalcInfo.u32VdhInfoStride  = pstVdpWbcInfo->u32VdhInfoStride;
        stDbCalcInfo.u32ImageStruct    = pstVdpWbcInfo->u32ImageStruct;
        stDbCalcInfo.pstVPSSWbcReg     = pstVdpWbcInfo->pstVdpWbcReg;

        stDbCalcInfo.bDbBlkPosModeEn   = HI_FALSE;
        stDbCalcInfo.bDbFltDetModeEn   = HI_TRUE;
        /* Filter Control Enable; need judgement condition or not */
        stDbCalcInfo.bDBLumHorEn       = HI_TRUE;
        stDbCalcInfo.bDBLumVerEn       = HI_TRUE;

        /* DB After Calc Set CFG Reg to Reg */
        s32Ret  = GET_ALG_FUN(HI_PQ_MODULE_DB)->DBCalcConfigCfg(&stDbCalcInfo);

        if (GET_ALG(HI_PQ_MODULE_DM) && GET_ALG_FUN(HI_PQ_MODULE_DM)->DMCalcConfigCfg)
        {
            s32Ret |= GET_ALG_FUN(HI_PQ_MODULE_DM)->DMCalcConfigCfg(&stDbCalcInfo);
        }

        if (HI_SUCCESS != s32Ret)
        {
            HI_ERR_PQ("DB DM CalcConfigCfg failed!\n");
            return s32Ret;
        }

        pqprint(PQ_PRN_DB_READ, "[%s]: W:%d, H:%d\n",
                __FUNCTION__,
                stDbCalcInfo.u32Width,
                stDbCalcInfo.u32Height);
    }

    return HI_SUCCESS;
}

static HI_S32 DRV_PQ_GetFlashPqBin(PQ_PARAM_S* pstPqParam)
{
    HI_S32 s32Ret;
    PQ_FILE_HEADER_S* pstPqFileHead = HI_NULL;
    HI_U32 u32CheckSize = 0;
    HI_U32 u32CheckPos  = 0;
    HI_U32 u32CheckSum  = 0;
    HI_U32 u32PqLen     = 0;
    HI_U8*  pu8PqAddr   = HI_NULL;
    PDM_EXPORT_FUNC_S*   pstPdmFuncs = HI_NULL;
    PQ_PARAM_S* pstPqBinParam = HI_NULL;

    memset((HI_VOID*)pstPqParam, 0x0, sizeof(PQ_PARAM_S));

    /* get pq bin from pdm */
    s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_PDM, (HI_VOID**)&pstPdmFuncs);

    if (s32Ret != HI_SUCCESS)
    {
        HI_FATAL_PQ("HI_DRV_MODULE_GetFunction failed!\n");
        return HI_FAILURE;
    }

    if (NULL == pstPdmFuncs)
    {
        HI_FATAL_PQ("\npstPdmFuncs is NULL\n");
        return HI_FAILURE;
    }

    if (NULL == pstPdmFuncs->pfnPDM_GetData)
    {
        HI_ERR_PQ("\npstPdmFuncs->pfnPDM_GetData is NULL\n");
        return HI_FAILURE;
    }

    s32Ret = pstPdmFuncs->pfnPDM_GetData(PQ_DEF_NAME, &pu8PqAddr, &u32PqLen);

    if ((HI_SUCCESS != s32Ret) || (HI_NULL == pu8PqAddr) )
    {
        HI_ERR_PQ("PQ bin param may not burned\r\n");
        return HI_FAILURE;
    }

    pstPqBinParam = (PQ_PARAM_S*)pu8PqAddr;
    pstPqFileHead = &(pstPqBinParam->stPQFileHeader);

    u32CheckPos = (HI_U8*) & (pstPqBinParam->stPQCoef) - (HI_U8*)pstPqBinParam;
    u32CheckSize = pstPqFileHead->u32ParamSize;

    if (u32CheckSize != sizeof(PQ_PARAM_S))
    {
        HI_ERR_PQ( "check PQbin size error, Param Size = %d,sizeof(PQ_PARAM_S) = %d\n", u32CheckSize, sizeof(PQ_PARAM_S));
        return HI_FAILURE;
    }

    if (0 != strncmp(pstPqFileHead->u8Version, PQ_VERSION, strlen(PQ_VERSION)))
    {
        HI_ERR_PQ( "check PQbin Version[%s] error\n", PQ_VERSION);
        return HI_FAILURE;
    }

    if (HI_SUCCESS != PQ_COMM_CheckChipName(pstPqFileHead->u8ChipName))
    {
        HI_ERR_PQ( "check PQbin ChipName[%s] error\n", pstPqFileHead->u8ChipName);
        return HI_FAILURE;
    }

    while (u32CheckPos < u32CheckSize)
    {
        u32CheckSum += *(HI_U8*)(((HI_U8*)pstPqBinParam) + u32CheckPos);
        u32CheckPos++;
    }

    if (u32CheckSum != pstPqFileHead->u32FileCheckSum)
    {
        HI_ERR_PQ( "PQbin checksum error,declare checksum = %d,calcsum = %d\r\n", pstPqFileHead->u32FileCheckSum, u32CheckSum);
        //pstPdmFuncs->pfnPDM_ReleaseReserveMem(PQ_DEF_NAME);
        return HI_FAILURE;
    }

    memcpy((HI_VOID*)(pstPqParam), (HI_VOID*)pstPqBinParam, sizeof(PQ_PARAM_S));

    return HI_SUCCESS;
}

HI_S32 DRV_PQ_GetBinPhyAddr(HI_U32* pu32Addr)
{
    *pu32Addr = g_stPqBinBuf.u32StartPhyAddr;

    return HI_SUCCESS;
}

HI_S32 DRV_PQ_GetPicSetting(HI_VOID)
{
    HI_S32 s32Ret;
    HI_DISP_PARAM_S stSDDispParam;
    HI_DISP_PARAM_S stHDDispParam;
    PDM_EXPORT_FUNC_S* pstPdmFuncs = HI_NULL;

    s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_PDM, (HI_VOID**)&pstPdmFuncs);

    if (s32Ret != HI_SUCCESS)
    {
        HI_WARN_PQ("HI_DRV_MODULE_GetFunction failed!\n");
        return HI_FAILURE;
    }

    if (NULL == pstPdmFuncs)
    {
        HI_FATAL_PQ("\npstPdmFuncs is NULL\n");
        return HI_FAILURE;
    }

    if (NULL == pstPdmFuncs->pfnPDM_GetDispParam)
    {
        HI_ERR_PQ("\npstPdmFuncs->pfnPDM_GetDispParam is NULL\n");
        return HI_FAILURE;
    }

    s32Ret = pstPdmFuncs->pfnPDM_GetDispParam(HI_UNF_DISPLAY0, &stSDDispParam);

    if (HI_SUCCESS != s32Ret)
    {
        HI_WARN_PQ("baseparam may not burned\r\n");
        return HI_FAILURE;
    }

    stPqParam.stSDPictureSetting.u16Brightness = stSDDispParam.u32Brightness;
    stPqParam.stSDPictureSetting.u16Contrast   = stSDDispParam.u32Contrast;
    stPqParam.stSDPictureSetting.u16Hue        = stSDDispParam.u32HuePlus;
    stPqParam.stSDPictureSetting.u16Saturation = stSDDispParam.u32Saturation;

    stPqParam.stSDVideoSetting.u16Brightness = LEVEL2NUM(stSDDispParam.u32Brightness);
    stPqParam.stSDVideoSetting.u16Contrast   = LEVEL2NUM(stSDDispParam.u32Contrast);
    stPqParam.stSDVideoSetting.u16Hue        = LEVEL2NUM(stSDDispParam.u32HuePlus);
    stPqParam.stSDVideoSetting.u16Saturation = LEVEL2NUM(stSDDispParam.u32Saturation);


    s32Ret = pstPdmFuncs->pfnPDM_GetDispParam(HI_UNF_DISPLAY1, &stHDDispParam);

    if (HI_SUCCESS != s32Ret)
    {
        HI_WARN_PQ("baseparam may not burned\r\n");
        return HI_FAILURE;
    }

    stPqParam.stHDPictureSetting.u16Brightness = stHDDispParam.u32Brightness;
    stPqParam.stHDPictureSetting.u16Contrast   = stHDDispParam.u32Contrast;
    stPqParam.stHDPictureSetting.u16Hue        = stHDDispParam.u32HuePlus;
    stPqParam.stHDPictureSetting.u16Saturation = stHDDispParam.u32Saturation;

    stPqParam.stHDVideoSetting.u16Brightness = LEVEL2NUM(stHDDispParam.u32Brightness);
    stPqParam.stHDVideoSetting.u16Contrast   = LEVEL2NUM(stHDDispParam.u32Contrast);
    stPqParam.stHDVideoSetting.u16Hue        = LEVEL2NUM(stHDDispParam.u32HuePlus);
    stPqParam.stHDVideoSetting.u16Saturation = LEVEL2NUM(stHDDispParam.u32Saturation);

    return HI_SUCCESS;
}

HI_S32 DRV_PQ_SetReg(HI_PQ_REGISTER_S* pstAttr)
{
    return PQ_MNG_SetReg(pstAttr, g_u32SourceMode, g_u32OutputMode);
}


HI_S32 DRV_PQ_GetReg(HI_PQ_REGISTER_S* pstAttr)
{
    return PQ_MNG_GetReg(pstAttr);
}


HI_S32 DRV_PQ_SetDefaultParam(HI_BOOL bDefault)
{
    HI_U32 u32DefLevel = 50;

    if (HI_FALSE == bDefault)
    {
        return HI_SUCCESS;
    }

    DRV_PQ_SetSDBrightness(u32DefLevel);
    DRV_PQ_SetHDBrightness(u32DefLevel);
    DRV_PQ_SetSDContrast(u32DefLevel);
    DRV_PQ_SetHDContrast(u32DefLevel);
    DRV_PQ_SetSDSaturation(u32DefLevel);
    DRV_PQ_SetHDSaturation(u32DefLevel);
    DRV_PQ_SetSDHue(u32DefLevel);
    DRV_PQ_SetHDHue(u32DefLevel);

    DRV_PQ_SetPQModule(HI_PQ_MODULE_ALL, HI_FALSE);

    if (GET_ALG(HI_PQ_MODULE_ZME) && GET_ALG_FUN(HI_PQ_MODULE_ZME)->SetZmeDefault)
    {
        GET_ALG_FUN(HI_PQ_MODULE_ZME)->SetZmeDefault(HI_TRUE);
    }

    return HI_SUCCESS;
}

HI_S32 DRV_PQ_SetGfxZme(HI_PQ_GFX_LAYER_E enGfxZmeLayer, HI_PQ_GFX_ZME_PARA_S* pstGfxZmePara)
{
    HI_S32 s32Ret = HI_FAILURE;

    if (GET_ALG(HI_PQ_MODULE_GFXZME) && GET_ALG_FUN(HI_PQ_MODULE_GFXZME)->SetGfxZme)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_GFXZME)->SetGfxZme(enGfxZmeLayer, pstGfxZmePara);
    }

    return s32Ret;
}

HI_S32 DRV_PQ_GetHdrCfg(HI_PQ_WIN_HDR_INFO* pstWinHdrInfo, HI_PQ_HDR_CFG* pstPqHdrCfg)
{
    HI_S32 s32Ret = HI_FAILURE;

    if (GET_ALG(HI_PQ_MODULE_HDR) && GET_ALG_FUN(HI_PQ_MODULE_HDR)->GetHdrCfg)
    {
        s32Ret = GET_ALG_FUN(HI_PQ_MODULE_HDR)->GetHdrCfg(pstWinHdrInfo, pstPqHdrCfg);
    }

    return s32Ret;
}

MODULE_LICENSE("GPL");

EXPORT_SYMBOL(DRV_PQ_UpdateVpssPQ);
EXPORT_SYMBOL(DRV_PQ_UpdateVdpPQ);
EXPORT_SYMBOL(DRV_PQ_UpdateVdpCSC);
EXPORT_SYMBOL(DRV_PQ_UpdateDCIWin);
EXPORT_SYMBOL(DRV_PQ_GetWbcInfo);
EXPORT_SYMBOL(DRV_PQ_SetAlgCalcCfg);
EXPORT_SYMBOL(DRV_PQ_SetVdpAlgCalcCfg);
EXPORT_SYMBOL(DRV_PQ_GetCSCCoef);
EXPORT_SYMBOL(DRV_PQ_Get8BitCSCCoef);
EXPORT_SYMBOL(DRV_PQ_GetWcgGmmCoef);
EXPORT_SYMBOL(DRV_PQ_GetWcgDeGmmCoef);
EXPORT_SYMBOL(DRV_PQ_GetGfxWcgGmmCoef);
EXPORT_SYMBOL(DRV_PQ_GetGfxWcgDeGmmCoef);
EXPORT_SYMBOL(DRV_PQ_SetZme);
EXPORT_SYMBOL(DRV_PQ_SetVpssZme);
EXPORT_SYMBOL(DRV_PQ_ZME_2L_Check);
EXPORT_SYMBOL(DRV_PQ_GetHDPictureSetting);
EXPORT_SYMBOL(DRV_PQ_GetSDPictureSetting);
EXPORT_SYMBOL(DRV_PQ_SetHDPictureSetting);
EXPORT_SYMBOL(DRV_PQ_SetSDPictureSetting);
EXPORT_SYMBOL(DRV_PQ_GetHDVideoSetting);
EXPORT_SYMBOL(DRV_PQ_GetSDVideoSetting);
EXPORT_SYMBOL(DRV_PQ_SetHDVideoSetting);
EXPORT_SYMBOL(DRV_PQ_SetSDVideoSetting);
EXPORT_SYMBOL(DRV_PQ_GetVdpZmeCoef);
EXPORT_SYMBOL(DRV_PQ_GetVdpZmeStrategy);
EXPORT_SYMBOL(DRV_PQ_SetGfxZme);
EXPORT_SYMBOL(DRV_PQ_SetGfxCscCoef);
EXPORT_SYMBOL(DRV_PQ_GetHdrCfg);






