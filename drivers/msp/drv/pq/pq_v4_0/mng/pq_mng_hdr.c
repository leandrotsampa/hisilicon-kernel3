/******************************************************************************
*
* Copyright (C) 2016 Hisilicon Technologies Co., Ltd.  All rights reserved.
*
* This program is confidential and proprietary to Hisilicon  Technologies Co., Ltd. (Hisilicon),
*  and may not be copied, reproduced, modified, disclosed to others, published or used, in
* whole or in part, without the express prior written permission of Hisilicon.
*
*****************************************************************************

  File Name    : pq_mng_hdr.c
  Version       : Initial Draft
  Author        : p00203646
  Created      : 2016/03/19
  Description  :

******************************************************************************/
#include "hi_math.h"
#include "pq_mng_hdr_alg.h"
#include "pq_mng_hdr.h"
#include "pq_hal_comm.h"

extern HI_S16 as16TMDefaultLut[16 * PQ_HDR_ALG_TM_LUT_SIZE];
extern HI_S16 as16TMWorkLut[16 * PQ_HDR_ALG_TM_LUT_SIZE];

static HI_BOOL sg_bHdrInitFlag      = HI_FALSE;
static PQ_PARAM_S* sg_pstPqHdrParam = HI_NULL;

PQ_HDR_ALG_TM g_stHdrCfg;

HI_S32 PQ_MNG_InitHdr(PQ_PARAM_S* pstPqParam, HI_BOOL bDefault)
{
    if (HI_TRUE == sg_bHdrInitFlag)
    {
        return HI_SUCCESS;
    }

    sg_pstPqHdrParam = pstPqParam;

    PQ_CHECK_NULL_PTR(sg_pstPqHdrParam);

    memset(&g_stHdrCfg, 0, sizeof(g_stHdrCfg));

    if (HI_TRUE == bDefault)
    {
        memcpy(sg_pstPqHdrParam->stPQCoef.stHdrTmCoef.as16TMLut, as16TMDefaultLut, sizeof(as16TMDefaultLut));
        memcpy(as16TMWorkLut, as16TMDefaultLut, sizeof(as16TMDefaultLut));
    }
    else
    {
        memcpy(as16TMWorkLut, sg_pstPqHdrParam->stPQCoef.stHdrTmCoef.as16TMLut, sizeof(as16TMDefaultLut));
    }

    PQ_MNG_DescrambleHdrCfg(PQ_HDR_ALG_CFG_TYPE_TM, &g_stHdrCfg);

    sg_bHdrInitFlag = HI_TRUE;

    return HI_SUCCESS;
}

HI_S32 PQ_MNG_DeInitHdr(HI_VOID)
{
    if (HI_FALSE == sg_bHdrInitFlag)
    {
        return HI_SUCCESS;
    }

    sg_bHdrInitFlag   = HI_FALSE;

    return HI_SUCCESS;
}

HI_S32 PQ_MNG_GetHdrCfg(HI_PQ_WIN_HDR_INFO* pstWinHdrInfo, HI_PQ_HDR_CFG* pstPqHdrCfg)
{
    PQ_CHECK_NULL_PTR(pstWinHdrInfo);
    PQ_CHECK_NULL_PTR(pstPqHdrCfg);

    if (HI_DRV_VIDEO_FRAME_TYPE_HDR10 != pstWinHdrInfo->enSrcFrameType)
    {
        return HI_FAILURE;
    }

    if (HI_PQ_DISP_TYPE_NORMAL == pstWinHdrInfo->enDispType)
    {
        memcpy((HI_VOID*) & (pstPqHdrCfg->stPQHdrTm), (HI_VOID*)(g_stHdrCfg.s16aTMLut), sizeof(HI_PQ_HDR_TM));
    }

    return HI_SUCCESS;
}

HI_S32 PQ_MNG_SetHdrCfg(HI_BOOL bDefault)
{
    if (bDefault == HI_FALSE)
    {
        PQ_MNG_ScrambleHdrCfg(PQ_HDR_ALG_CFG_TYPE_TM);
    }
    else
    {
        PQ_CHECK_NULL_PTR(sg_pstPqHdrParam);
        memcpy(sg_pstPqHdrParam->stPQCoef.stHdrTmCoef.as16TMLut, as16TMDefaultLut, sizeof(as16TMDefaultLut));
    }

    return HI_SUCCESS;
}


static stPQAlgFuncs stHDRFuncs =
{
    .Init               = PQ_MNG_InitHdr,
    .DeInit             = PQ_MNG_DeInitHdr,
    .GetHdrCfg          = PQ_MNG_GetHdrCfg,
    .SetHdrCfg          = PQ_MNG_SetHdrCfg,
};

HI_S32 PQ_MNG_RegisterHDR(PQ_REG_TYPE_E  enType)
{
    HI_S32 s32Ret;

    s32Ret = PQ_COMM_AlgRegister(HI_PQ_MODULE_HDR, enType, PQ_BIN_ADAPT_SINGLE, "hdr", HI_NULL, &stHDRFuncs);

    return s32Ret;
}

HI_S32 PQ_MNG_UnRegisterHDR(HI_VOID)
{
    HI_S32 s32Ret;

    s32Ret = PQ_COMM_AlgUnRegister(HI_PQ_MODULE_HDR);

    return s32Ret;
}

