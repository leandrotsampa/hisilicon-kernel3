/******************************************************************************
*
* Copyright (C) 2014 Hisilicon Technologies Co., Ltd.  All rights reserved.
*
* This program is confidential and proprietary to Hisilicon  Technologies Co., Ltd. (Hisilicon),
*  and may not be copied, reproduced, modified, disclosed to others, published or used, in
* whole or in part, without the express prior written permission of Hisilicon.
*
*****************************************************************************

  File Name     : pq_hal_zme.c
  Version       : Initial Draft
  Author        : p00203646
  Created       : 2014/04/01
  Author        : p00203646
******************************************************************************/
#include <linux/fs.h>

#include "pq_hal_zme.h"
#include "pq_mng_zme_coef.h"


#define V0_SCALER1_ENABLE_THD       2
#define V0_READ_FMT_ZME_THD         3
#define V0_PREZME_ENABLE_2_THD      6
#define V0_PREZME_ENABLE_4_THD      12
#define V0_PREZME_ENABLE_8_THD      24
#define WBC_HSCALER_THD             4
#define DHD0_OUT_RESOLUTION_W_THD   3840
#define DHD0_OUT_RESOLUTION_H_THD   2160


static S_VDP_REGS_TYPE* pVdpReg;

static HI_BOOL sg_bV0ReadFmtIn = HI_TRUE;
static ZME_WBC_POINT_SEL_E    sg_enWbcPointSel  = ZME_WBC_POINT_V0;
static HI_PQ_PREZME_HOR_MUL_E sg_enV0PreHScaler = HI_PQ_PREZME_HOR_DISABLE;
static HI_PQ_PREZME_VER_MUL_E sg_enV0PreVScaler = HI_PQ_PREZME_VER_DISABLE;

static HI_BOOL sg_bVpssZmeDefault = HI_FALSE;
static HI_BOOL sg_bVdpZmeDefault  = HI_FALSE;



/****************************Load VDP ZME COEF START*****************************************/
static HI_U32 VdpZmeTransCoefAlign(const HI_S16* ps16Coef, VZME_TAP_E enTap, ZME_COEF_BITARRAY_S* pBitCoef)
{
    HI_U32 i, u32Cnt, u32Tap, u32Tmp;

    switch (enTap)
    {
        case VZME_TAP_8T32P:
            u32Tap = 8;
            break;
        case VZME_TAP_6T32P:
            u32Tap = 6;
            break;
        case VZME_TAP_4T32P:
            u32Tap = 4;
            break;
        case VZME_TAP_2T32P:
            u32Tap = 2;
            break;
        default:
            u32Tap = 4;
            break;
    }

    /* Tran ZME coef to 128 bits order */
    u32Cnt = 18 * u32Tap / 12;
    for (i = 0; i < u32Cnt; i++)
    {
        pBitCoef->stBit[i].bits_0 = VouBitValue(*ps16Coef++);
        pBitCoef->stBit[i].bits_1 = VouBitValue(*ps16Coef++);
        pBitCoef->stBit[i].bits_2 = VouBitValue(*ps16Coef++);

        u32Tmp = VouBitValue(*ps16Coef++);
        pBitCoef->stBit[i].bits_32 = u32Tmp;
        pBitCoef->stBit[i].bits_38 = (u32Tmp >> 2);

        pBitCoef->stBit[i].bits_4 = VouBitValue(*ps16Coef++);
        pBitCoef->stBit[i].bits_5 = VouBitValue(*ps16Coef++);

        u32Tmp = VouBitValue(*ps16Coef++);
        pBitCoef->stBit[i].bits_64 = u32Tmp;
        pBitCoef->stBit[i].bits_66 = u32Tmp >> 4;

        pBitCoef->stBit[i].bits_7 = VouBitValue(*ps16Coef++);
        pBitCoef->stBit[i].bits_8 = VouBitValue(*ps16Coef++);

        u32Tmp = VouBitValue(*ps16Coef++);
        pBitCoef->stBit[i].bits_96 = u32Tmp;
        pBitCoef->stBit[i].bits_94 = u32Tmp >> 6;

        pBitCoef->stBit[i].bits_10 = VouBitValue(*ps16Coef++);
        pBitCoef->stBit[i].bits_11 = VouBitValue(*ps16Coef++);
        pBitCoef->stBit[i].bits_12 = 0;
    }

    pBitCoef->u32Size = u32Cnt * sizeof(ZME_COEF_BIT_S);

    return HI_SUCCESS;
}

/* load hor coef */
static HI_U32 VdpZmeLoadCoefH(PQ_HAL_ZME_COEF_RATIO_E enCoefRatio, VZME_COEF_TYPE_E enCoefType, VZME_TAP_E enZmeTap, HI_U8* pu8Addr)
{
    ZME_COEF_BITARRAY_S stArray;

    /* load horizontal zoom coef */
    VdpZmeTransCoefAlign(g_pVZmeCoef[enCoefRatio][enCoefType], enZmeTap, &stArray);
    memcpy(pu8Addr, stArray.stBit, stArray.u32Size);

    return HI_SUCCESS;
}

/* load vert coef */
static HI_S32 VdpZmeLoadCoefV(PQ_HAL_ZME_COEF_RATIO_E enCoefRatio, VZME_COEF_TYPE_E enCoefType, VZME_TAP_E enZmeTap, HI_U8* pu8Addr)
{
    ZME_COEF_BITARRAY_S stArray;

    /* load vertical zoom coef */
    VdpZmeTransCoefAlign(g_pVZmeCoef[enCoefRatio][enCoefType], enZmeTap, &stArray);
    memcpy(pu8Addr, stArray.stBit, stArray.u32Size);

    return HI_SUCCESS;
}

HI_VOID PQ_HAL_VdpLoadCoef(ALG_VZME_MEM_S* pstVZmeCoefMem)
{
    HI_U8* pu8CurAddr;
    HI_U32 u32PhyAddr;
    HI_U32 u32NumSizeLuma, u32NumSizeChro;
    ALG_VZME_COEF_ADDR_S* pstAddrTmp;

    pu8CurAddr = pstVZmeCoefMem->stMBuf.pu8StartVirAddr;
    u32PhyAddr = pstVZmeCoefMem->stMBuf.u32StartPhyAddr;
    pstAddrTmp = &(pstVZmeCoefMem->stZmeCoefAddr);


    /* H_L8C4:Luma-Hor-8T32P Chroma-Hor-4T32P */
    u32NumSizeLuma = 192; /* (8x18) / 12 * 16 = 192 */
    u32NumSizeChro = 96;  /* (4x18) / 12 * 16 = 96 */
    VdpZmeLoadCoefH(PQ_HAL_ZME_COEF_1, VZME_COEF_8T32P_LH, VZME_TAP_8T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrHL8_1 = u32PhyAddr;
    pstAddrTmp->u32ZmeCoefAddrHL8C4_1 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeLuma;
    pu8CurAddr  += u32NumSizeLuma;
    VdpZmeLoadCoefH(PQ_HAL_ZME_COEF_1, VZME_COEF_4T32P_CH, VZME_TAP_4T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrHC4_1 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeChro;
    pu8CurAddr  += u32NumSizeChro;

    VdpZmeLoadCoefH(PQ_HAL_ZME_COEF_E1, VZME_COEF_8T32P_LH, VZME_TAP_8T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrHL8_E1 = u32PhyAddr;
    pstAddrTmp->u32ZmeCoefAddrHL8C4_E1 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeLuma;
    pu8CurAddr  += u32NumSizeLuma;
    VdpZmeLoadCoefH(PQ_HAL_ZME_COEF_E1, VZME_COEF_4T32P_CH, VZME_TAP_4T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrHC4_E1 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeChro;
    pu8CurAddr  += u32NumSizeChro;

    VdpZmeLoadCoefH(PQ_HAL_ZME_COEF_075, VZME_COEF_8T32P_LH, VZME_TAP_8T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrHL8_075 = u32PhyAddr;
    pstAddrTmp->u32ZmeCoefAddrHL8C4_075 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeLuma;
    pu8CurAddr  += u32NumSizeLuma;
    VdpZmeLoadCoefH(PQ_HAL_ZME_COEF_075, VZME_COEF_4T32P_CH, VZME_TAP_4T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrHC4_075 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeChro;
    pu8CurAddr  += u32NumSizeChro;

    VdpZmeLoadCoefH(PQ_HAL_ZME_COEF_05, VZME_COEF_8T32P_LH, VZME_TAP_8T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrHL8_05 = u32PhyAddr;
    pstAddrTmp->u32ZmeCoefAddrHL8C4_05 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeLuma;
    pu8CurAddr  += u32NumSizeLuma;
    VdpZmeLoadCoefH(PQ_HAL_ZME_COEF_05, VZME_COEF_4T32P_CH, VZME_TAP_4T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrHC4_05 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeChro;
    pu8CurAddr  += u32NumSizeChro;

    VdpZmeLoadCoefH(PQ_HAL_ZME_COEF_033, VZME_COEF_8T32P_LH, VZME_TAP_8T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrHL8_033 = u32PhyAddr;
    pstAddrTmp->u32ZmeCoefAddrHL8C4_033 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeLuma;
    pu8CurAddr  += u32NumSizeLuma;
    VdpZmeLoadCoefH(PQ_HAL_ZME_COEF_033, VZME_COEF_4T32P_CH, VZME_TAP_4T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrHC4_033 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeChro;
    pu8CurAddr  += u32NumSizeChro;

    VdpZmeLoadCoefH(PQ_HAL_ZME_COEF_025, VZME_COEF_8T32P_LH, VZME_TAP_8T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrHL8_025 = u32PhyAddr;
    pstAddrTmp->u32ZmeCoefAddrHL8C4_025 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeLuma;
    pu8CurAddr  += u32NumSizeLuma;
    VdpZmeLoadCoefH(PQ_HAL_ZME_COEF_025, VZME_COEF_4T32P_CH, VZME_TAP_4T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrHC4_025 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeChro;
    pu8CurAddr  += u32NumSizeChro;

    VdpZmeLoadCoefH(PQ_HAL_ZME_COEF_0, VZME_COEF_8T32P_LH, VZME_TAP_8T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrHL8_0 = u32PhyAddr;
    pstAddrTmp->u32ZmeCoefAddrHL8C4_0 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeLuma;
    pu8CurAddr  += u32NumSizeLuma;
    VdpZmeLoadCoefH(PQ_HAL_ZME_COEF_0, VZME_COEF_4T32P_CH, VZME_TAP_4T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrHC4_0 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeChro;
    pu8CurAddr  += u32NumSizeChro;


    /* V_L6C4:Luma-Vert-6T32P Chroma-Vert-4T32P */
    u32NumSizeLuma = 144;  /* (6x18) / 12 * 16 = 144 */
    u32NumSizeChro = 96;   /* (4x18) / 12 * 16 = 96 */
    VdpZmeLoadCoefV(PQ_HAL_ZME_COEF_1, VZME_COEF_6T32P_LV, VZME_TAP_6T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVL6_1 = u32PhyAddr;
    pstAddrTmp->u32ZmeCoefAddrVL6C4_1 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeLuma;
    pu8CurAddr  += u32NumSizeLuma;
    VdpZmeLoadCoefV(PQ_HAL_ZME_COEF_1, VZME_COEF_4T32P_CV,  VZME_TAP_4T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVC4_1 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeChro;
    pu8CurAddr  += u32NumSizeChro;

    VdpZmeLoadCoefV(PQ_HAL_ZME_COEF_E1, VZME_COEF_6T32P_LV, VZME_TAP_6T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVL6_E1 = u32PhyAddr;
    pstAddrTmp->u32ZmeCoefAddrVL6C4_E1 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeLuma;
    pu8CurAddr  += u32NumSizeLuma;
    VdpZmeLoadCoefV(PQ_HAL_ZME_COEF_E1, VZME_COEF_4T32P_CV,  VZME_TAP_4T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVC4_E1 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeChro;
    pu8CurAddr  += u32NumSizeChro;


    VdpZmeLoadCoefV(PQ_HAL_ZME_COEF_075, VZME_COEF_6T32P_LV, VZME_TAP_6T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVL6_075 = u32PhyAddr;
    pstAddrTmp->u32ZmeCoefAddrVL6C4_075 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeLuma;
    pu8CurAddr  += u32NumSizeLuma;
    VdpZmeLoadCoefV(PQ_HAL_ZME_COEF_075, VZME_COEF_4T32P_CV,  VZME_TAP_4T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVC4_075 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeChro;
    pu8CurAddr  += u32NumSizeChro;

    VdpZmeLoadCoefV(PQ_HAL_ZME_COEF_05, VZME_COEF_6T32P_LV, VZME_TAP_6T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVL6_05 = u32PhyAddr;
    pstAddrTmp->u32ZmeCoefAddrVL6C4_05 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeLuma;
    pu8CurAddr  += u32NumSizeLuma;
    VdpZmeLoadCoefV(PQ_HAL_ZME_COEF_05, VZME_COEF_4T32P_CV,  VZME_TAP_4T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVC4_05 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeChro;
    pu8CurAddr  += u32NumSizeChro;

    VdpZmeLoadCoefV(PQ_HAL_ZME_COEF_033, VZME_COEF_6T32P_LV, VZME_TAP_6T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVL6_033 = u32PhyAddr;
    pstAddrTmp->u32ZmeCoefAddrVL6C4_033 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeLuma;
    pu8CurAddr  += u32NumSizeLuma;
    VdpZmeLoadCoefV(PQ_HAL_ZME_COEF_033, VZME_COEF_4T32P_CV,  VZME_TAP_4T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVC4_033 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeChro;
    pu8CurAddr  += u32NumSizeChro;

    VdpZmeLoadCoefV(PQ_HAL_ZME_COEF_025, VZME_COEF_6T32P_LV, VZME_TAP_6T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVL6_025 = u32PhyAddr;
    pstAddrTmp->u32ZmeCoefAddrVL6C4_025 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeLuma;
    pu8CurAddr  += u32NumSizeLuma;
    VdpZmeLoadCoefV(PQ_HAL_ZME_COEF_033, VZME_COEF_4T32P_CV,  VZME_TAP_4T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVC4_025 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeChro;
    pu8CurAddr  += u32NumSizeChro;

    VdpZmeLoadCoefV(PQ_HAL_ZME_COEF_0, VZME_COEF_6T32P_LV, VZME_TAP_6T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVL6_0 = u32PhyAddr;
    pstAddrTmp->u32ZmeCoefAddrVL6C4_0 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeLuma;
    pu8CurAddr  += u32NumSizeLuma;
    VdpZmeLoadCoefV(PQ_HAL_ZME_COEF_0, VZME_COEF_4T32P_CV,  VZME_TAP_4T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVC4_0 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeChro;
    pu8CurAddr  += u32NumSizeChro;


    /* V_L4C4:Luma-Vert-4T32P Chroma-Vert-4T32P */
    u32NumSizeLuma = 96; /*(4x18) / 12 * 16 */
    u32NumSizeChro = 96; /*(4x18) / 12 * 16 */
    VdpZmeLoadCoefV(PQ_HAL_ZME_COEF_1, VZME_COEF_4T32P_LV,  VZME_TAP_4T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVL4_1 = u32PhyAddr;
    pstAddrTmp->u32ZmeCoefAddrVL4C4_1 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeLuma;
    pu8CurAddr  += u32NumSizeLuma;
    VdpZmeLoadCoefH(PQ_HAL_ZME_COEF_1, VZME_COEF_4T32P_CH, VZME_TAP_4T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVC4_1 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeChro;
    pu8CurAddr  += u32NumSizeChro;

    VdpZmeLoadCoefV(PQ_HAL_ZME_COEF_E1, VZME_COEF_4T32P_LV,  VZME_TAP_4T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVL4_E1 = u32PhyAddr;
    pstAddrTmp->u32ZmeCoefAddrVL4C4_E1 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeLuma;
    pu8CurAddr  += u32NumSizeLuma;
    VdpZmeLoadCoefH(PQ_HAL_ZME_COEF_E1, VZME_COEF_4T32P_CH, VZME_TAP_4T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVC4_E1 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeChro;
    pu8CurAddr  += u32NumSizeChro;

    VdpZmeLoadCoefV(PQ_HAL_ZME_COEF_075, VZME_COEF_4T32P_LV,  VZME_TAP_4T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVL4_075 = u32PhyAddr;
    pstAddrTmp->u32ZmeCoefAddrVL4C4_075 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeLuma;
    pu8CurAddr  += u32NumSizeLuma;
    VdpZmeLoadCoefH(PQ_HAL_ZME_COEF_075, VZME_COEF_4T32P_CH, VZME_TAP_4T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVC4_075 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeChro;
    pu8CurAddr  += u32NumSizeChro;

    VdpZmeLoadCoefV(PQ_HAL_ZME_COEF_05, VZME_COEF_4T32P_LV,  VZME_TAP_4T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVL4_05 = u32PhyAddr;
    pstAddrTmp->u32ZmeCoefAddrVL4C4_05 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeLuma;
    pu8CurAddr  += u32NumSizeLuma;
    VdpZmeLoadCoefH(PQ_HAL_ZME_COEF_05, VZME_COEF_4T32P_CH, VZME_TAP_4T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVC4_05 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeChro;
    pu8CurAddr  += u32NumSizeChro;

    VdpZmeLoadCoefV(PQ_HAL_ZME_COEF_033, VZME_COEF_4T32P_LV,  VZME_TAP_4T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVL4_033 = u32PhyAddr;
    pstAddrTmp->u32ZmeCoefAddrVL4C4_033 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeLuma;
    pu8CurAddr  += u32NumSizeLuma;
    VdpZmeLoadCoefH(PQ_HAL_ZME_COEF_033, VZME_COEF_4T32P_CH, VZME_TAP_4T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVC4_033 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeChro;
    pu8CurAddr  += u32NumSizeChro;

    VdpZmeLoadCoefV(PQ_HAL_ZME_COEF_025, VZME_COEF_4T32P_LV,  VZME_TAP_4T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVL4_025 = u32PhyAddr;
    pstAddrTmp->u32ZmeCoefAddrVL4C4_025 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeLuma;
    pu8CurAddr  += u32NumSizeLuma;
    VdpZmeLoadCoefH(PQ_HAL_ZME_COEF_025, VZME_COEF_4T32P_CH, VZME_TAP_4T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVC4_025 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeChro;
    pu8CurAddr  += u32NumSizeChro;

    VdpZmeLoadCoefV(PQ_HAL_ZME_COEF_0, VZME_COEF_4T32P_LV,  VZME_TAP_4T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVL4_0 = u32PhyAddr;
    pstAddrTmp->u32ZmeCoefAddrVL4C4_0 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeLuma;
    pu8CurAddr  += u32NumSizeLuma;
    VdpZmeLoadCoefH(PQ_HAL_ZME_COEF_0, VZME_COEF_4T32P_CH, VZME_TAP_4T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVC4_0 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeChro;
    pu8CurAddr  += u32NumSizeChro;


    /* Chroma-Hor-8T32P */
    u32NumSizeChro = 192; /* (8x18) / 12 * 16 = 192 */
    VdpZmeLoadCoefH(PQ_HAL_ZME_COEF_1, VZME_COEF_8T32P_CH, VZME_TAP_8T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrHC8_1 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeChro;
    pu8CurAddr  += u32NumSizeChro;

    VdpZmeLoadCoefH(PQ_HAL_ZME_COEF_E1, VZME_COEF_8T32P_CH, VZME_TAP_8T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrHC8_E1 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeChro;
    pu8CurAddr  += u32NumSizeChro;

    VdpZmeLoadCoefH(PQ_HAL_ZME_COEF_075, VZME_COEF_8T32P_CH, VZME_TAP_8T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrHC8_075 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeChro;
    pu8CurAddr  += u32NumSizeChro;

    VdpZmeLoadCoefH(PQ_HAL_ZME_COEF_05, VZME_COEF_8T32P_CH, VZME_TAP_8T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrHC8_05 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeChro;
    pu8CurAddr  += u32NumSizeChro;

    VdpZmeLoadCoefH(PQ_HAL_ZME_COEF_033, VZME_COEF_8T32P_CH, VZME_TAP_8T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrHC8_033 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeChro;
    pu8CurAddr  += u32NumSizeChro;

    VdpZmeLoadCoefH(PQ_HAL_ZME_COEF_025, VZME_COEF_8T32P_CH, VZME_TAP_8T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrHC8_025 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeChro;
    pu8CurAddr  += u32NumSizeChro;

    VdpZmeLoadCoefH(PQ_HAL_ZME_COEF_0, VZME_COEF_8T32P_CH, VZME_TAP_8T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrHC8_0 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeChro;
    pu8CurAddr  += u32NumSizeChro;


    /* Chroma-Vert-6T32P */
    u32NumSizeChro = 144; /* (6x18) / 12 * 16 = 144 */
    VdpZmeLoadCoefV(PQ_HAL_ZME_COEF_1, VZME_COEF_6T32P_CV,  VZME_TAP_6T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVC6_1 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeChro;
    pu8CurAddr  += u32NumSizeChro;

    VdpZmeLoadCoefV(PQ_HAL_ZME_COEF_E1, VZME_COEF_6T32P_CV,  VZME_TAP_6T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVC6_E1 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeChro;
    pu8CurAddr  += u32NumSizeChro;

    VdpZmeLoadCoefV(PQ_HAL_ZME_COEF_075, VZME_COEF_6T32P_CV,  VZME_TAP_6T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVC6_075 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeChro;
    pu8CurAddr  += u32NumSizeChro;

    VdpZmeLoadCoefV(PQ_HAL_ZME_COEF_05, VZME_COEF_6T32P_CV,  VZME_TAP_6T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVC6_05 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeChro;
    pu8CurAddr  += u32NumSizeChro;

    VdpZmeLoadCoefV(PQ_HAL_ZME_COEF_033, VZME_COEF_6T32P_CV,  VZME_TAP_6T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVC6_033 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeChro;
    pu8CurAddr  += u32NumSizeChro;

    VdpZmeLoadCoefV(PQ_HAL_ZME_COEF_025, VZME_COEF_6T32P_CV,  VZME_TAP_6T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVC6_025 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeChro;
    pu8CurAddr  += u32NumSizeChro;

    VdpZmeLoadCoefV(PQ_HAL_ZME_COEF_0, VZME_COEF_6T32P_CV,  VZME_TAP_6T32P, pu8CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVC6_0 = u32PhyAddr;
    u32PhyAddr  += u32NumSizeChro;
    pu8CurAddr  += u32NumSizeChro;

    return;
}
/*****************************Load VDP ZME COEF END*****************************************/

/*******************************VDP V0 ZME START***************************************/
static HI_VOID PQ_HAL_VID_SetZmeHorLumEn(HI_U32 u32Data, HI_U32 u32bEnable)
{
    U_V0_HSP V0_HSP;

    pVdpReg = PQ_HAL_GetVdpReg();

    if (u32Data >= VID_MAX)
    {
        HI_ERR_PQ("Error,VDP_VID_SetZmeEnable() Select Wrong Video Layer ID\n");
        return;
    }

    /* VHD layer zoom enable */
    V0_HSP.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&(pVdpReg->V0_HSP.u32)) + u32Data * PQ_VID_OFFSET));
    V0_HSP.bits.hlmsc_en  = u32bEnable;
    PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->V0_HSP.u32)) + u32Data * PQ_VID_OFFSET), V0_HSP.u32);

    return;
}

static HI_VOID PQ_HAL_VID_SetZmeVerLumEn(HI_U32 u32Data, HI_U32 u32bEnable)
{
    U_V0_VSP V0_VSP;

    pVdpReg = PQ_HAL_GetVdpReg();

    if (u32Data >= VID_MAX)
    {
        HI_ERR_PQ("Error,VDP_VID_SetZmeEnable() Select Wrong Video Layer ID\n");
        return;
    }

    /* VHD layer zoom enable */
    V0_VSP.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&(pVdpReg->V0_VSP.u32)) + u32Data * PQ_VID_OFFSET));
    V0_VSP.bits.vlmsc_en  = u32bEnable;
    PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->V0_VSP.u32)) + u32Data * PQ_VID_OFFSET), V0_VSP.u32);

    /* It exist logic limit or not: vlmsc_en in V1 ==0 */
    V0_VSP.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&(pVdpReg->V0_VSP.u32)) + 1 * PQ_VID_OFFSET));
    V0_VSP.bits.vlmsc_en  = 0;
    PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->V0_VSP.u32)) + 1 * PQ_VID_OFFSET), V0_VSP.u32);

    return;
}

static HI_VOID PQ_HAL_VID_SetZmeHorChmEn(HI_U32 u32Data, HI_U32 u32bEnable)
{
    U_V0_HSP V0_HSP;

    pVdpReg = PQ_HAL_GetVdpReg();

    if (u32Data >= VID_MAX)
    {
        HI_ERR_PQ("Error,VDP_VID_SetZmeEnable() Select Wrong Video Layer ID\n");
        return;
    }

    /* VHD layer zoom enable */
    V0_HSP.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&(pVdpReg->V0_HSP.u32)) + u32Data * PQ_VID_OFFSET));
    V0_HSP.bits.hchmsc_en = u32bEnable;
    PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->V0_HSP.u32)) + u32Data * PQ_VID_OFFSET), V0_HSP.u32);

    return;
}

static HI_VOID PQ_HAL_VID_SetZmeVerChmEn(HI_U32 u32Data, HI_U32 u32bEnable)
{
    U_V0_VSP V0_VSP;

    pVdpReg = PQ_HAL_GetVdpReg();

    if (u32Data >= VID_MAX)
    {
        HI_ERR_PQ("Error,VDP_VID_SetZmeEnable() Select Wrong Video Layer ID\n");
        return;
    }

    /* VHD layer zoom enable */
    V0_VSP.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&(pVdpReg->V0_VSP.u32)) + u32Data * PQ_VID_OFFSET));
    V0_VSP.bits.vchmsc_en = u32bEnable;
    PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->V0_VSP.u32)) + u32Data * PQ_VID_OFFSET), V0_VSP.u32);

    return;
}

static HI_VOID PQ_HAL_VID_SetZmePhaseH(HI_U32 u32Data, HI_S32 s32PhaseL, HI_S32 s32PhaseC)
{
    U_V0_HLOFFSET V0_HLOFFSET;
    U_V0_HCOFFSET V0_HCOFFSET;

    pVdpReg = PQ_HAL_GetVdpReg();

    if (u32Data >= VID_MAX)
    {
        HI_ERR_PQ("Error,VDP_VID_SetZmePhase() Select Wrong Video Layer ID\n");
        return;
    }
    /* VHD layer zoom enable */
    V0_HLOFFSET.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&(pVdpReg->V0_HLOFFSET.u32)) + u32Data * PQ_VID_OFFSET));
    V0_HLOFFSET.bits.hor_loffset = s32PhaseL;
    PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->V0_HLOFFSET.u32)) + u32Data * PQ_VID_OFFSET), V0_HLOFFSET.u32);

    V0_HCOFFSET.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&(pVdpReg->V0_HCOFFSET.u32)) + u32Data * PQ_VID_OFFSET));
    V0_HCOFFSET.bits.hor_coffset = s32PhaseC;
    PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->V0_HCOFFSET.u32)) + u32Data * PQ_VID_OFFSET), V0_HCOFFSET.u32);

    return;
}

static HI_VOID PQ_HAL_VID_SetZmePhaseV(HI_U32 u32Data, HI_S32 s32PhaseL, HI_S32 s32PhaseC)
{
    U_V0_VOFFSET V0_VOFFSET;

    pVdpReg = PQ_HAL_GetVdpReg();

    if (u32Data >= VID_MAX)
    {
        HI_ERR_PQ("Error,VDP_VID_SetZmePhase() Select Wrong Video Layer ID\n");
        return;
    }

    V0_VOFFSET.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&(pVdpReg->V0_VOFFSET.u32)) + u32Data * PQ_VID_OFFSET));
    V0_VOFFSET.bits.vluma_offset   = s32PhaseL;
    V0_VOFFSET.bits.vchroma_offset = s32PhaseC;
    PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->V0_VOFFSET.u32)) + u32Data * PQ_VID_OFFSET), V0_VOFFSET.u32);

    return;
}

static HI_VOID PQ_HAL_VID_SetZmePhaseVB(HI_U32 u32Data, HI_S32 s32PhaseL, HI_S32 s32PhaseC)
{
    U_V0_VBOFFSET V0_VBOFFSET;

    pVdpReg = PQ_HAL_GetVdpReg();

    if (u32Data >= VID_MAX)
    {
        HI_ERR_PQ("Error,VDP_VID_SetZmePhase() Select Wrong Video Layer ID\n");
        return;
    }

    V0_VBOFFSET.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&(pVdpReg->V0_VBOFFSET.u32)) + u32Data * PQ_VID_OFFSET));
    V0_VBOFFSET.bits.vbluma_offset   = s32PhaseL;
    V0_VBOFFSET.bits.vbchroma_offset = s32PhaseC;
    PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->V0_VBOFFSET.u32)) + u32Data * PQ_VID_OFFSET), V0_VBOFFSET.u32);

    return;
}

static HI_VOID PQ_HAL_VID_SetZmeFirEnable2(HI_U32 u32Data, HI_U32 u32bEnableHl, HI_U32 u32bEnableHc, HI_U32 u32bEnableVl, HI_U32 u32bEnableVc)
{
    U_V0_HSP V0_HSP;
    U_V0_VSP V0_VSP;

    pVdpReg = PQ_HAL_GetVdpReg();

    if (u32Data >= VID_MAX)
    {
        HI_ERR_PQ("Error,VDP_VID_SetZmeFirEnable() Select Wrong Video Layer ID\n");
        return;
    }

    V0_HSP.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&(pVdpReg->V0_HSP.u32)) + u32Data * PQ_VID_OFFSET));
    V0_HSP.bits.hlfir_en  = u32bEnableHl;
    V0_HSP.bits.hchfir_en = u32bEnableHc;
    PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->V0_HSP.u32)) + u32Data * PQ_VID_OFFSET), V0_HSP.u32);

    V0_VSP.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&(pVdpReg->V0_VSP.u32)) + u32Data * PQ_VID_OFFSET));
    V0_VSP.bits.vlfir_en  = u32bEnableVl;
    V0_VSP.bits.vchfir_en = u32bEnableVc;
    PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->V0_VSP.u32)) + u32Data * PQ_VID_OFFSET), V0_VSP.u32);

    return;
}

static HI_VOID PQ_HAL_VID_SetZmeMidEnable2(HI_U32 u32Data, HI_U32 u32bEnable)
{
    U_V0_HSP V0_HSP;
    U_V0_VSP V0_VSP;

    pVdpReg = PQ_HAL_GetVdpReg();

    if (u32Data >= VID_MAX)
    {
        HI_ERR_PQ("Error,VDP_VID_SetZmeMidEnable() Select Wrong Video Layer ID\n");
        return;
    }
    /* VHD layer zoom enable */
    V0_HSP.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&(pVdpReg->V0_HSP.u32)) + u32Data * PQ_VID_OFFSET));
    V0_HSP.bits.hlmid_en = u32bEnable;
    V0_HSP.bits.hchmid_en = u32bEnable;
    PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->V0_HSP.u32)) + u32Data * PQ_VID_OFFSET), V0_HSP.u32);

    V0_VSP.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&(pVdpReg->V0_VSP.u32)) + u32Data * PQ_VID_OFFSET));
    V0_VSP.bits.vlmid_en  = u32bEnable;
    V0_VSP.bits.vchmid_en = u32bEnable;
    PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->V0_VSP.u32)) + u32Data * PQ_VID_OFFSET), V0_VSP.u32);

    return;
}

static HI_VOID PQ_HAL_VID_SetZmeVchTap(HI_U32 u32Data, HI_U32 u32VscTap)
{
    /* in 3798cv100,   you can't set vsc_chroma_tap, so this func should fall into chip dir */
    /* in 3798mv100_a, you can't set vsc_chroma_tap, so this func should fall into chip dir */
    /* in 3798mv100,   you can't set vsc_chroma_tap, so this func should fall into chip dir */
    return;
}

static HI_VOID PQ_HAL_VID_SetZmeHorRatio(HI_U32 u32Data, HI_U32 u32Ratio)
{
    U_V0_HSP V0_HSP;

    pVdpReg = PQ_HAL_GetVdpReg();

    if (u32Data >= VID_MAX)
    {
        HI_ERR_PQ("Error,PQ_HAL_VID_SetZmeHorRatio() Select Wrong Video Layer ID\n");
        return;
    }

    V0_HSP.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&(pVdpReg->V0_HSP.u32)) + u32Data * PQ_VID_OFFSET));
    V0_HSP.bits.hratio = u32Ratio;
    PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->V0_HSP.u32)) + u32Data * PQ_VID_OFFSET), V0_HSP.u32);

    return;
}

static HI_VOID PQ_HAL_VID_SetZmeVerRatio(HI_U32 u32Data, HI_U32 u32Ratio)
{
    U_V0_VSR V0_VSR;

    pVdpReg = PQ_HAL_GetVdpReg();

    if (u32Data >= VID_MAX)
    {
        HI_ERR_PQ("Error,PQ_HAL_VID_SetZmeVerRatio() Select Wrong Video Layer ID\n");
        return;
    }

    V0_VSR.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&(pVdpReg->V0_VSR.u32)) + u32Data * PQ_VID_OFFSET));
    V0_VSR.bits.vratio = u32Ratio;
    PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->V0_VSR.u32)) + u32Data * PQ_VID_OFFSET), V0_VSR.u32);

    return;
}

static HI_VOID PQ_HAL_VID_SetZmeHfirOrder(HI_U32 u32Data, HI_U32 u32HfirOrder)
{
    U_V0_HSP V0_HSP;

    pVdpReg = PQ_HAL_GetVdpReg();

    if (u32Data >= VID_MAX)
    {
        HI_ERR_PQ("Error,PQ_HAL_VID_SetZmeHfirOrder() Select Wrong Video Layer ID\n");
        return;
    }

    V0_HSP.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&(pVdpReg->V0_HSP.u32)) + u32Data * PQ_VID_OFFSET));
    V0_HSP.bits.hfir_order = u32HfirOrder;
    PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->V0_HSP.u32)) + u32Data * PQ_VID_OFFSET), V0_HSP.u32);

    return;
}

static HI_VOID PQ_HAL_VID_SetZmeCoefAddr(HI_U32 u32Data, HI_U32 u32Mode, HI_U32 u32LAddr, HI_U32 u32CAddr)
{
    U_V0_HLCOEFAD V0_HLCOEFAD;
    U_V0_HCCOEFAD V0_HCCOEFAD;
    U_V0_VLCOEFAD V0_VLCOEFAD;
    U_V0_VCCOEFAD V0_VCCOEFAD;

    pVdpReg = PQ_HAL_GetVdpReg();

    if (u32Data >= VID_MAX)
    {
        HI_ERR_PQ("Error,PQ_HAL_VID_SetZmeCoefAddr() Select Wrong Video Layer ID\n");
        return;
    }

    if (u32Mode == VDP_VID_PARA_ZME_HOR)
    {
        V0_HLCOEFAD.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&(pVdpReg->V0_HLCOEFAD.u32)) + u32Data * PQ_VID_OFFSET));
        V0_HLCOEFAD.bits.coef_addr = u32LAddr;
        PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->V0_HLCOEFAD.u32)) + u32Data * PQ_VID_OFFSET), u32LAddr);

        V0_HCCOEFAD.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&(pVdpReg->V0_HCCOEFAD.u32)) + u32Data * PQ_VID_OFFSET));
        V0_HCCOEFAD.bits.coef_addr = u32CAddr;
        PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->V0_HCCOEFAD.u32)) + u32Data * PQ_VID_OFFSET), u32CAddr);
    }
    else if (u32Mode == VDP_VID_PARA_ZME_VER)
    {
        V0_VLCOEFAD.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&(pVdpReg->V0_VLCOEFAD.u32)) + u32Data * PQ_VID_OFFSET));
        V0_VLCOEFAD.bits.coef_addr = u32LAddr;
        PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->V0_VLCOEFAD.u32)) + u32Data * PQ_VID_OFFSET), u32LAddr);

        V0_VCCOEFAD.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&(pVdpReg->V0_VCCOEFAD.u32)) + u32Data * PQ_VID_OFFSET));
        V0_VCCOEFAD.bits.coef_addr = u32CAddr;
        PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->V0_VCCOEFAD.u32)) + u32Data * PQ_VID_OFFSET), u32CAddr);
    }
    else
    {
        HI_ERR_PQ("Error,PQ_HAL_VID_SetZmeCoefAddr() Select a Wrong Mode!\n");
    }

    return;
}

static HI_VOID PQ_HAL_VID_SetParaUpd(HI_U32 u32Data, VDP_VID_PARA_E enMode)
{
    U_V0_PARAUP V0_PARAUP;

    pVdpReg = PQ_HAL_GetVdpReg();

    if (u32Data >= VID_MAX)
    {
        HI_ERR_PQ("error,PQ_HAL_VID_SetParaUpd() select wrong video layer id\n");
        return;
    }

    V0_PARAUP.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&(pVdpReg->V0_PARAUP.u32)) + u32Data * PQ_VID_OFFSET));
    if (enMode == VDP_VID_PARA_ZME_HOR)
    {

        V0_PARAUP.bits.v0_hlcoef_upd = 0x1;
        V0_PARAUP.bits.v0_hccoef_upd = 0x1;
    }
    else if (enMode == VDP_VID_PARA_ZME_VER)
    {
        V0_PARAUP.bits.v0_vlcoef_upd = 0x1;
        V0_PARAUP.bits.v0_vccoef_upd = 0x1;
    }
    else
    {
        HI_ERR_PQ("error,PQ_HAL_VID_SetParaUpd() select wrong mode!\n");
    }
    PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->V0_PARAUP.u32)) + u32Data * PQ_VID_OFFSET), V0_PARAUP.u32);

    return;
}

static HI_VOID PQ_HAL_VID_SetZmeInFmt(HI_U32 u32Data, VDP_PROC_FMT_E u32Fmt)
{
    U_V0_VSP V0_VSP;

    pVdpReg = PQ_HAL_GetVdpReg();

    if (u32Data >= VID_MAX)
    {
        HI_ERR_PQ("Error,PQ_HAL_VID_SetZmeInFmt() Select Wrong Video Layer ID\n");
        return;
    }

    V0_VSP.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&(pVdpReg->V0_VSP.u32)) + u32Data * PQ_VID_OFFSET));
    V0_VSP.bits.zme_in_fmt = u32Fmt;
    PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->V0_VSP.u32)) + u32Data * PQ_VID_OFFSET), V0_VSP.u32);

    return;
}

static HI_VOID PQ_HAL_VID_SetZmeOutFmt(HI_U32 u32Data, VDP_PROC_FMT_E u32Fmt)
{
    U_V0_VSP V0_VSP;

    pVdpReg = PQ_HAL_GetVdpReg();

    if (u32Data >= VID_MAX)
    {
        HI_ERR_PQ("Error,PQ_HAL_VID_SetZmeOutFmt() Select Wrong Video Layer ID\n");
        return;
    }

    V0_VSP.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&(pVdpReg->V0_VSP.u32)) + u32Data * PQ_VID_OFFSET));
    V0_VSP.bits.zme_out_fmt = u32Fmt;
    PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->V0_VSP.u32)) + u32Data * PQ_VID_OFFSET), V0_VSP.u32);

    return;
}

static HI_VOID PQ_HAL_VdpSetCvfirCoef(HI_U32 u32Data)
{
    // TODO
    //    U_V0_ZME_CVFIR_COEF0 V0_ZME_CVFIR_COEF0;
    //    U_V0_ZME_CVFIR_COEF1 V0_ZME_CVFIR_COEF1;
    //    U_V0_ZME_CVFIR_COEF2 V0_ZME_CVFIR_COEF2;
    //
    //    if (u32Data >= VID_MAX)
    //    {
    //        HI_PRINT("Error,PQ_HAL_VdpSetCvfirCoef() Select Wrong Video Layer ID\n");
    //        return;
    //    }
    //
    //    V0_ZME_CVFIR_COEF0.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&(pVdpReg->V0_ZME_CVFIR_COEF0.u32)) + u32Data * PQ_VID_OFFSET));
    //    V0_ZME_CVFIR_COEF1.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&(pVdpReg->V0_ZME_CVFIR_COEF1.u32)) + u32Data * PQ_VID_OFFSET));
    //    V0_ZME_CVFIR_COEF2.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&(pVdpReg->V0_ZME_CVFIR_COEF2.u32)) + u32Data * PQ_VID_OFFSET));
    //
    //    V0_ZME_CVFIR_COEF0.bits.cvfir_coef00 = s16Cvfir_4T32P_5M_a15[0][0];
    //    V0_ZME_CVFIR_COEF0.bits.cvfir_coef01 = s16Cvfir_4T32P_5M_a15[0][1];
    //    V0_ZME_CVFIR_COEF0.bits.cvfir_coef02 = s16Cvfir_4T32P_5M_a15[0][2];
    //    V0_ZME_CVFIR_COEF1.bits.cvfir_coef03 = s16Cvfir_4T32P_5M_a15[0][3];
    //    V0_ZME_CVFIR_COEF1.bits.cvfir_coef10 = s16Cvfir_4T32P_5M_a15[1][0];
    //    V0_ZME_CVFIR_COEF1.bits.cvfir_coef11 = s16Cvfir_4T32P_5M_a15[1][1];
    //    V0_ZME_CVFIR_COEF2.bits.cvfir_coef12 = s16Cvfir_4T32P_5M_a15[1][2];
    //    V0_ZME_CVFIR_COEF2.bits.cvfir_coef13 = s16Cvfir_4T32P_5M_a15[1][3];
    //
    //    PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->V0_ZME_CVFIR_COEF0.u32)) + u32Data * PQ_VID_OFFSET), V0_ZME_CVFIR_COEF0.u32);
    //    PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->V0_ZME_CVFIR_COEF1.u32)) + u32Data * PQ_VID_OFFSET), V0_ZME_CVFIR_COEF1.u32);
    //    PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->V0_ZME_CVFIR_COEF2.u32)) + u32Data * PQ_VID_OFFSET), V0_ZME_CVFIR_COEF2.u32);

    return;
}

HI_VOID PQ_HAL_VdpZmeRegCfg(HI_U32 u32LayerId, ALG_VZME_RTL_PARA_S* pstZmeRtlPara, HI_BOOL bFirEnable)
{
    PQ_HAL_VID_SetZmeHorRatio(u32LayerId, pstZmeRtlPara->u32ZmeRatioHL);
    PQ_HAL_VID_SetZmeVerRatio(u32LayerId, pstZmeRtlPara->u32ZmeRatioVL);

    PQ_HAL_VID_SetZmePhaseH(u32LayerId, pstZmeRtlPara->s32ZmeOffsetHL, pstZmeRtlPara->s32ZmeOffsetHC);
    PQ_HAL_VID_SetZmePhaseV(u32LayerId, pstZmeRtlPara->s32ZmeOffsetVL, pstZmeRtlPara->s32ZmeOffsetVC);
    PQ_HAL_VID_SetZmePhaseVB(u32LayerId, pstZmeRtlPara->s32ZmeOffsetVLBtm, pstZmeRtlPara->s32ZmeOffsetVCBtm);

    PQ_HAL_VID_SetZmeMidEnable2(u32LayerId, pstZmeRtlPara->bZmeMedHL);
    PQ_HAL_VID_SetZmeHfirOrder(u32LayerId, pstZmeRtlPara->bZmeOrder);

    /* in 3798mv100_a and 3798mv100, it does not exist vsc_chroma_tap and vsc_luma_tap */
    PQ_HAL_VID_SetZmeVchTap(u32LayerId, pstZmeRtlPara->bZmeTapVC);

    if (pstZmeRtlPara->bZmeMdHL || pstZmeRtlPara->bZmeMdHC)
    {
        PQ_HAL_VID_SetZmeCoefAddr(u32LayerId, VDP_VID_PARA_ZME_HOR, pstZmeRtlPara->u32ZmeCoefAddrHL, pstZmeRtlPara->u32ZmeCoefAddrHC);
        PQ_HAL_VID_SetParaUpd(u32LayerId, VDP_VID_PARA_ZME_HOR);
    }

    if (pstZmeRtlPara->bZmeMdVL || pstZmeRtlPara->bZmeMdVC)
    {
        PQ_HAL_VID_SetZmeCoefAddr(u32LayerId, VDP_VID_PARA_ZME_VER, pstZmeRtlPara->u32ZmeCoefAddrVL, pstZmeRtlPara->u32ZmeCoefAddrVC);
        PQ_HAL_VID_SetParaUpd(u32LayerId, VDP_VID_PARA_ZME_VER);
    }

    /* debug start z00128410 2012-1-30 debug config for SDK debug: fixed to copy mode that don't need zme coefficient */
    /*
    pstZmeRtlPara->bZmeMdHL = 1;
    pstZmeRtlPara->bZmeMdHC = 1;
    pstZmeRtlPara->bZmeMdVL = 1;
    pstZmeRtlPara->bZmeMdVC = 1;
    */
    /* debug end z00128410 2012-1-30 */

    if (!bFirEnable)
    {
        /* for fidelity output */
        PQ_HAL_VID_SetZmeFirEnable2(u32LayerId,
                                    pstZmeRtlPara->bZmeMdHL,
                                    pstZmeRtlPara->bZmeMdHC,
                                    HI_FALSE,
                                    HI_FALSE);
    }
    else
    {
        /* for normal output */
        PQ_HAL_VID_SetZmeFirEnable2(u32LayerId,
                                    pstZmeRtlPara->bZmeMdHL,
                                    pstZmeRtlPara->bZmeMdHC,
                                    pstZmeRtlPara->bZmeMdVL,
                                    pstZmeRtlPara->bZmeMdVC);
    }

    PQ_HAL_VID_SetZmeInFmt(u32LayerId, pstZmeRtlPara->u8ZmeYCFmtIn);
    PQ_HAL_VID_SetZmeOutFmt(u32LayerId, VDP_PROC_FMT_SP_422);
    PQ_HAL_VID_SetZmeHorLumEn(u32LayerId, pstZmeRtlPara->bZmeEnVL);
    PQ_HAL_VID_SetZmeVerLumEn(u32LayerId, pstZmeRtlPara->bZmeEnVL);
    PQ_HAL_VID_SetZmeHorChmEn(u32LayerId, pstZmeRtlPara->bZmeEnVL);
    PQ_HAL_VID_SetZmeVerChmEn(u32LayerId, pstZmeRtlPara->bZmeEnVL);
    /* Set Cvifr Coef; Only V1 */
    PQ_HAL_VdpSetCvfirCoef(VDP_ZME_LAYER_V1);

    return;
}

/*******************************VDP V0 ZME END***************************************/


/*******************************WBC ZME START***************************************/
static HI_VOID PQ_HAL_WBC_SetZmePhaseH(VDP_LAYER_WBC_E enLayer, HI_S32 s32PhaseL, HI_S32 s32PhaseC)
{
    U_WBC_DHD0_ZME_HLOFFSET WBC_DHD0_ZME_HLOFFSET;
    U_WBC_DHD0_ZME_HCOFFSET WBC_DHD0_ZME_HCOFFSET;

    pVdpReg = PQ_HAL_GetVdpReg();
    if (enLayer == VDP_LAYER_WBC_HD0 )
    {
        /* VHD layer zoom enable */
        WBC_DHD0_ZME_HLOFFSET.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&pVdpReg->WBC_DHD0_ZME_HLOFFSET.u32)));
        WBC_DHD0_ZME_HLOFFSET.bits.hor_loffset = s32PhaseL;
        PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->WBC_DHD0_ZME_HLOFFSET.u32))), WBC_DHD0_ZME_HLOFFSET.u32);

        WBC_DHD0_ZME_HCOFFSET.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&pVdpReg->WBC_DHD0_ZME_HCOFFSET.u32)));
        WBC_DHD0_ZME_HCOFFSET.bits.hor_coffset = s32PhaseC;
        PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->WBC_DHD0_ZME_HCOFFSET.u32))), WBC_DHD0_ZME_HCOFFSET.u32);
    }
    else if (enLayer == VDP_LAYER_WBC_GP0)
    {}

    return;
}

static HI_VOID PQ_HAL_WBC_SetZmePhaseV(VDP_LAYER_WBC_E enLayer, HI_S32 s32PhaseL, HI_S32 s32PhaseC)
{
    U_WBC_DHD0_ZME_VOFFSET WBC_DHD0_ZME_VOFFSET;
    pVdpReg = PQ_HAL_GetVdpReg();

    if (enLayer == VDP_LAYER_WBC_HD0 )
    {
        /* VHD layer zoom enable */
        WBC_DHD0_ZME_VOFFSET.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&pVdpReg->WBC_DHD0_ZME_VOFFSET.u32)));
        WBC_DHD0_ZME_VOFFSET.bits.vluma_offset = s32PhaseL;
        PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->WBC_DHD0_ZME_VOFFSET.u32))), WBC_DHD0_ZME_VOFFSET.u32);

        WBC_DHD0_ZME_VOFFSET.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&pVdpReg->WBC_DHD0_ZME_VOFFSET.u32)));
        WBC_DHD0_ZME_VOFFSET.bits.vchroma_offset = s32PhaseC;
        PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->WBC_DHD0_ZME_VOFFSET.u32))), WBC_DHD0_ZME_VOFFSET.u32);
    }
    else if (enLayer == VDP_LAYER_WBC_GP0)
    {}

    return;
}

static HI_VOID PQ_HAL_WBC_SetZmeHorRatio(VDP_LAYER_WBC_E enLayer, HI_U32 u32Ratio)
{
    U_WBC_DHD0_ZME_HSP WBC_DHD0_ZME_HSP;

    pVdpReg = PQ_HAL_GetVdpReg();
    if (enLayer == VDP_LAYER_WBC_HD0 || enLayer == VDP_LAYER_WBC_ME)
    {
        WBC_DHD0_ZME_HSP.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&(pVdpReg->WBC_DHD0_ZME_HSP.u32)) + enLayer * PQ_WBC_OFFSET));
        WBC_DHD0_ZME_HSP.bits.hratio = u32Ratio;
        PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->WBC_DHD0_ZME_HSP.u32)) + enLayer * PQ_WBC_OFFSET), WBC_DHD0_ZME_HSP.u32);
    }

    return;
}

static HI_VOID PQ_HAL_WBC_SetZmeVerRatio(VDP_LAYER_WBC_E enLayer, HI_U32 u32Ratio)
{
    U_WBC_DHD0_ZME_VSR WBC_DHD0_ZME_VSR;

    pVdpReg = PQ_HAL_GetVdpReg();
    if (enLayer == VDP_LAYER_WBC_HD0 || enLayer == VDP_LAYER_WBC_ME)
    {
        WBC_DHD0_ZME_VSR.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&(pVdpReg->WBC_DHD0_ZME_VSR.u32)) + enLayer * PQ_WBC_OFFSET));
        WBC_DHD0_ZME_VSR.bits.vratio = u32Ratio;
        PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->WBC_DHD0_ZME_VSR.u32)) + enLayer * PQ_WBC_OFFSET), WBC_DHD0_ZME_VSR.u32);
    }

    return;
}

static HI_VOID PQ_HAL_WBC_SetZmeEnable(VDP_LAYER_WBC_E enLayer, VDP_ZME_MODE_E enMode, HI_U32 u32bEnable, HI_U32 u32firMode)
{
    U_WBC_DHD0_ZME_HSP WBC_DHD0_ZME_HSP;
    U_WBC_DHD0_ZME_VSP WBC_DHD0_ZME_VSP;

    pVdpReg = PQ_HAL_GetVdpReg();
    /* WBC zoom enable */
    if (enLayer == VDP_LAYER_WBC_HD0 || enLayer == VDP_LAYER_WBC_ME)
    {
        if ((enMode == VDP_ZME_MODE_HORL) || (enMode == VDP_ZME_MODE_HOR) || (enMode == VDP_ZME_MODE_ALL))
        {
            WBC_DHD0_ZME_HSP.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&(pVdpReg->WBC_DHD0_ZME_HSP.u32)) + enLayer * PQ_WBC_OFFSET));
            WBC_DHD0_ZME_HSP.bits.hlmsc_en = u32bEnable;
            WBC_DHD0_ZME_HSP.bits.hlfir_en = u32firMode;
            PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->WBC_DHD0_ZME_HSP.u32)) + enLayer * PQ_WBC_OFFSET), WBC_DHD0_ZME_HSP.u32);
        }

        if ((enMode == VDP_ZME_MODE_HORC) || (enMode == VDP_ZME_MODE_HOR) || (enMode == VDP_ZME_MODE_ALL))
        {
            WBC_DHD0_ZME_HSP.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&(pVdpReg->WBC_DHD0_ZME_HSP.u32)) + enLayer * PQ_WBC_OFFSET));
            WBC_DHD0_ZME_HSP.bits.hchmsc_en = u32bEnable;
            WBC_DHD0_ZME_HSP.bits.hchfir_en = u32firMode;
            PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->WBC_DHD0_ZME_HSP.u32)) + enLayer * PQ_WBC_OFFSET), WBC_DHD0_ZME_HSP.u32);
        }

        /* non_lnr_en does not exist in 3798m_a and 3798m */
#if 0
        if ((enMode == VDP_ZME_MODE_NONL) || (enMode == VDP_ZME_MODE_ALL))
        {
            WBC_DHD0_ZME_HSP.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&(pVdpReg->WBC_DHD0_ZME_HSP.u32))));
            WBC_DHD0_ZME_HSP.bits.non_lnr_en = u32bEnable;
            PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->WBC_DHD0_ZME_HSP.u32)), WBC_DHD0_ZME_HSP.u32);
        }
#endif
                        if ((enMode == VDP_ZME_MODE_VERL) || (enMode == VDP_ZME_MODE_VER) || (enMode == VDP_ZME_MODE_ALL))
        {
            WBC_DHD0_ZME_VSP.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&(pVdpReg->WBC_DHD0_ZME_VSP.u32)) + enLayer * PQ_WBC_OFFSET));
            WBC_DHD0_ZME_VSP.bits.vlmsc_en = u32bEnable;
            WBC_DHD0_ZME_VSP.bits.vlfir_en = u32firMode;
            PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->WBC_DHD0_ZME_VSP.u32)) + enLayer * PQ_WBC_OFFSET), WBC_DHD0_ZME_VSP.u32);
        }

        if ((enMode == VDP_ZME_MODE_VERC) || (enMode == VDP_ZME_MODE_VER) || (enMode == VDP_ZME_MODE_ALL))
        {
            WBC_DHD0_ZME_VSP.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&(pVdpReg->WBC_DHD0_ZME_VSP.u32)) + enLayer * PQ_WBC_OFFSET));
            WBC_DHD0_ZME_VSP.bits.vchmsc_en = u32bEnable;
            WBC_DHD0_ZME_VSP.bits.vchfir_en = u32firMode;
            PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->WBC_DHD0_ZME_VSP.u32)) + enLayer * PQ_WBC_OFFSET), WBC_DHD0_ZME_VSP.u32);
        }
    }

    return;
}

static HI_VOID PQ_HAL_WBC_SetMidEnable(VDP_LAYER_WBC_E enLayer, VDP_ZME_MODE_E enMode, HI_U32 bEnable)
{
    U_WBC_DHD0_ZME_HSP WBC_DHD0_ZME_HSP;
    U_WBC_DHD0_ZME_VSP WBC_DHD0_ZME_VSP;
    pVdpReg = PQ_HAL_GetVdpReg();
    if (enLayer == VDP_LAYER_WBC_HD0 || enLayer == VDP_LAYER_WBC_ME)
    {
        if ((enMode == VDP_ZME_MODE_HORL) || (enMode == VDP_ZME_MODE_HOR) || (enMode == VDP_ZME_MODE_ALL))
        {
            WBC_DHD0_ZME_HSP.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&(pVdpReg->WBC_DHD0_ZME_HSP.u32)) + enLayer * PQ_WBC_OFFSET));
            WBC_DHD0_ZME_HSP.bits.hlmid_en = bEnable;
            PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->WBC_DHD0_ZME_HSP.u32)) + enLayer * PQ_WBC_OFFSET), WBC_DHD0_ZME_HSP.u32);
        }

        if ((enMode == VDP_ZME_MODE_HORC) || (enMode == VDP_ZME_MODE_HOR) || (enMode == VDP_ZME_MODE_ALL))
        {
            WBC_DHD0_ZME_HSP.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&(pVdpReg->WBC_DHD0_ZME_HSP.u32)) + enLayer * PQ_WBC_OFFSET));
            WBC_DHD0_ZME_HSP.bits.hchmid_en = bEnable;
            PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->WBC_DHD0_ZME_HSP.u32)) + enLayer * PQ_WBC_OFFSET), WBC_DHD0_ZME_HSP.u32);
        }

        if ((enMode == VDP_ZME_MODE_VERL) || (enMode == VDP_ZME_MODE_VER) || (enMode == VDP_ZME_MODE_ALL))
        {
            WBC_DHD0_ZME_VSP.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&(pVdpReg->WBC_DHD0_ZME_VSP.u32)) + enLayer * PQ_WBC_OFFSET));
            WBC_DHD0_ZME_VSP.bits.vlmid_en = bEnable;
            PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->WBC_DHD0_ZME_VSP.u32)) + enLayer * PQ_WBC_OFFSET), WBC_DHD0_ZME_VSP.u32);
        }

        if ((enMode == VDP_ZME_MODE_VERC) || (enMode == VDP_ZME_MODE_VER) || (enMode == VDP_ZME_MODE_ALL))
        {
            WBC_DHD0_ZME_VSP.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&(pVdpReg->WBC_DHD0_ZME_VSP.u32)) + enLayer * PQ_WBC_OFFSET));
            WBC_DHD0_ZME_VSP.bits.vchmid_en = bEnable;
            PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->WBC_DHD0_ZME_VSP.u32)) + enLayer * PQ_WBC_OFFSET), WBC_DHD0_ZME_VSP.u32);
        }
    }

    return;
}

static HI_VOID PQ_HAL_WBC_SetZmeHfirOrder(VDP_LAYER_WBC_E enLayer, HI_U32 u32HfirOrder)
{
    U_WBC_DHD0_ZME_HSP WBC_DHD0_ZME_HSP;
    pVdpReg = PQ_HAL_GetVdpReg();
    if (enLayer == VDP_LAYER_WBC_HD0 || enLayer == VDP_LAYER_WBC_ME)
    {
        WBC_DHD0_ZME_HSP.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&(pVdpReg->WBC_DHD0_ZME_HSP.u32)) + enLayer * PQ_WBC_OFFSET));
        WBC_DHD0_ZME_HSP.bits.hfir_order = u32HfirOrder;
        PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->WBC_DHD0_ZME_HSP.u32)) + enLayer * PQ_WBC_OFFSET), WBC_DHD0_ZME_HSP.u32);
    }

    return;
}

static HI_VOID PQ_HAL_WBC_SetZmeVerTap(VDP_LAYER_WBC_E enLayer, VDP_ZME_MODE_E enMode, HI_U32 u32VerTap)
{
    /* vsc_luma_tap does not exist in 3798m_a and 3798m */
    /* vsc_chroma_tap does not exist in 3798m_a and 3798m */
    return;
}

static HI_VOID PQ_HAL_WBC_SetZmeCoefAddr(VDP_LAYER_WBC_E enLayer, VDP_WBC_PARA_E u32Mode, HI_U32 u32Addr, HI_U32 u32CAddr)
{
    pVdpReg = PQ_HAL_GetVdpReg();

    if ( enLayer == VDP_LAYER_WBC_HD0 ||  enLayer == VDP_LAYER_WBC_ME  )
    {
        if (u32Mode == VDP_WBC_PARA_ZME_HOR)
        {
            PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->WBC_DHD0_HLCOEFAD.u32)) + enLayer * PQ_WBC_OFFSET), u32Addr);
            PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->WBC_DHD0_HCCOEFAD.u32)) + enLayer * PQ_WBC_OFFSET), u32CAddr);
        }
        else if (u32Mode == VDP_WBC_PARA_ZME_VER)
        {
            PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->WBC_DHD0_VLCOEFAD.u32)) + enLayer * PQ_WBC_OFFSET), u32Addr);
            PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->WBC_DHD0_VCCOEFAD.u32)) + enLayer * PQ_WBC_OFFSET), u32CAddr);
        }
        else
        {
            HI_ERR_PQ("Error,PQ_HAL_WBC_SetZmeCoefAddr() Select a Wrong Mode!\n");
        }
    }

    return;
}

static HI_VOID PQ_HAL_WBC_SetParaUpd (VDP_LAYER_WBC_E enLayer, VDP_WBC_PARA_E enMode)
{
    U_WBC_DHD0_PARAUP WBC_DHD0_PARAUP;
    /* WBC_ME exist in 98cv100, using for MEMC, does not exist in 98mv100_a and 98m */

    pVdpReg = PQ_HAL_GetVdpReg();

    if ( enLayer == VDP_LAYER_WBC_HD0 )
    {
        WBC_DHD0_PARAUP.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&(pVdpReg->WBC_DHD0_PARAUP.u32))));
        if (enMode == VDP_WBC_PARA_ZME_HOR)
        {
            WBC_DHD0_PARAUP.bits.wbc_hlcoef_upd = 0x1;
            WBC_DHD0_PARAUP.bits.wbc_hccoef_upd = 0x1;
        }
        else if (enMode == VDP_WBC_PARA_ZME_VER)
        {
            WBC_DHD0_PARAUP.bits.wbc_vlcoef_upd = 0x1;
            WBC_DHD0_PARAUP.bits.wbc_vccoef_upd = 0x1;
        }
        else
        {
            HI_ERR_PQ("error,VDP_WBC_DHD0_SetParaUpd() select wrong mode!\n");
        }
        PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->WBC_DHD0_PARAUP.u32))), WBC_DHD0_PARAUP.u32);
    }
    else
    {}

    return;
}

static HI_VOID PQ_HAL_WBC_SetZmeInFmt(VDP_LAYER_WBC_E enLayer, VDP_PROC_FMT_E u32Fmt)
{
    U_WBC_DHD0_ZME_VSP WBC_DHD0_ZME_VSP;
    pVdpReg = PQ_HAL_GetVdpReg();

    if (enLayer == VDP_LAYER_WBC_HD0 || enLayer == VDP_LAYER_WBC_ME)
    {
        WBC_DHD0_ZME_VSP.u32 = PQ_HAL_RegRead((HI_U32*)((unsigned long)(&(pVdpReg->WBC_DHD0_ZME_VSP.u32)) + enLayer * PQ_WBC_OFFSET));
        WBC_DHD0_ZME_VSP.bits.zme_in_fmt = u32Fmt;
        PQ_HAL_RegWrite((HI_U32*)((unsigned long)(&(pVdpReg->WBC_DHD0_ZME_VSP.u32)) + enLayer * PQ_WBC_OFFSET), WBC_DHD0_ZME_VSP.u32);
    }
    else
    {}

    return;
}

/* Vdp WBC Cfg Set to reg*/
/* explanation: In WBC We just pay atention to WBC_HD0 */
HI_VOID PQ_HAL_WbcZmeRegCfg(HI_U32 u32LayerId, ALG_VZME_RTL_PARA_S* pstZmeRtlPara, HI_BOOL bFirEnable)
{
    if (u32LayerId >= VDP_ZME_LAYER_WBC0)
    {
        u32LayerId = u32LayerId - VDP_ZME_LAYER_WBC0;
    }

    PQ_HAL_WBC_SetZmeHorRatio(u32LayerId, pstZmeRtlPara->u32ZmeRatioHL);
    PQ_HAL_WBC_SetZmeVerRatio(u32LayerId, pstZmeRtlPara->u32ZmeRatioVL);

    PQ_HAL_WBC_SetZmePhaseH(u32LayerId, pstZmeRtlPara->s32ZmeOffsetHL, pstZmeRtlPara->s32ZmeOffsetHC);
    PQ_HAL_WBC_SetZmePhaseV(u32LayerId, pstZmeRtlPara->s32ZmeOffsetVL, pstZmeRtlPara->s32ZmeOffsetVC);

#if 1
    /* zme enable and fir enable should not fix to a value. */
    PQ_HAL_WBC_SetZmeEnable(u32LayerId, VDP_ZME_MODE_HORL, pstZmeRtlPara->bZmeEnHL, pstZmeRtlPara->bZmeMdHL);
    PQ_HAL_WBC_SetZmeEnable(u32LayerId, VDP_ZME_MODE_HORC, pstZmeRtlPara->bZmeEnHC, pstZmeRtlPara->bZmeMdHC);
    PQ_HAL_WBC_SetZmeEnable(u32LayerId, VDP_ZME_MODE_VERL, pstZmeRtlPara->bZmeEnVL, pstZmeRtlPara->bZmeMdVL);
    PQ_HAL_WBC_SetZmeEnable(u32LayerId, VDP_ZME_MODE_VERC, pstZmeRtlPara->bZmeEnVC, pstZmeRtlPara->bZmeMdVC);
#else
    /* zme enable and  fir enable should not fix to a value.*/
    PQ_HAL_WBC_SetZmeEnable(u32LayerId, VDP_ZME_MODE_HORL, 0, 0);
    PQ_HAL_WBC_SetZmeEnable(u32LayerId, VDP_ZME_MODE_HORC, 0, 0);
    PQ_HAL_WBC_SetZmeEnable(u32LayerId, VDP_ZME_MODE_VERL, 0, 0);
    PQ_HAL_WBC_SetZmeEnable(u32LayerId, VDP_ZME_MODE_VERC, 0, 0);
#endif
    /* set media fir. */
    PQ_HAL_WBC_SetMidEnable(VDP_LAYER_WBC_HD0, VDP_ZME_MODE_HORL, pstZmeRtlPara->bZmeMedHL);
    PQ_HAL_WBC_SetMidEnable(VDP_LAYER_WBC_HD0, VDP_ZME_MODE_HORC, pstZmeRtlPara->bZmeMedHC);
    PQ_HAL_WBC_SetMidEnable(VDP_LAYER_WBC_HD0, VDP_ZME_MODE_VERL, pstZmeRtlPara->bZmeMedVL);
    PQ_HAL_WBC_SetMidEnable(VDP_LAYER_WBC_HD0, VDP_ZME_MODE_VERC, pstZmeRtlPara->bZmeMedVC);

    /* set zme order, h first or v first */
    PQ_HAL_WBC_SetZmeHfirOrder(VDP_LAYER_WBC_HD0, pstZmeRtlPara->bZmeOrder);

    /* It does not exist in 98m_a and 98m */
    /* set v chroma zme tap */
    PQ_HAL_WBC_SetZmeVerTap(VDP_LAYER_WBC_HD0, VDP_ZME_MODE_VERC, pstZmeRtlPara->bZmeTapVC);

    /* set hor fir coef addr, and set updata flag */
    if (pstZmeRtlPara->u32ZmeRatioHL)
    {
        PQ_HAL_WBC_SetZmeCoefAddr(VDP_LAYER_WBC_HD0, VDP_WBC_PARA_ZME_HOR, pstZmeRtlPara->u32ZmeCoefAddrHL, pstZmeRtlPara->u32ZmeCoefAddrHC);
        PQ_HAL_WBC_SetParaUpd(VDP_LAYER_WBC_HD0, VDP_WBC_PARA_ZME_HOR);
    }

    /* set ver fir coef addr, and set updata flag */
    if (pstZmeRtlPara->u32ZmeRatioVL)
    {
        PQ_HAL_WBC_SetZmeCoefAddr(VDP_LAYER_WBC_HD0, VDP_WBC_PARA_ZME_VER, pstZmeRtlPara->u32ZmeCoefAddrVL, pstZmeRtlPara->u32ZmeCoefAddrVC);
        PQ_HAL_WBC_SetParaUpd(VDP_LAYER_WBC_HD0, VDP_WBC_PARA_ZME_VER);
    }

    PQ_HAL_WBC_SetZmeInFmt(VDP_LAYER_WBC_HD0, VDP_PROC_FMT_SP_422);

    return;
}

/*******************************WBC ZME END***************************************/


/*********************************SR ZME******************************************/


/**************************************SR ZME END******************************************/

/*******************************Load VPSS ZME COEF START***********************************/
static HI_U32 VpssZmeTransCoefAlign(const HI_S16* ps16Coef, VZME_TAP_E enTap, ZME_COEF_BITARRAY_S* pBitCoef)
{
    HI_U32 i, j, u32Tap, k;
    HI_S32 s32CoefTmp1, s32CoefTmp2, s32CoefTmp3;

    switch (enTap)
    {
        case VZME_TAP_8T32P:
            u32Tap = 8;
            break;
        case VZME_TAP_6T32P:
            u32Tap = 6;
            break;
        case VZME_TAP_4T32P:
            u32Tap = 4;
            break;
        case VZME_TAP_2T32P:
            u32Tap = 2;
            break;
        default:
            u32Tap = 4;
            break;
    }

    j = 0;
    /* when tap == 8, there are 8 number in one group */
    if (u32Tap == 8)
    {
        /* 4 Bytes，32bits is the unit，every filter number is 10bits,
           There are 8 numbers in one group， take place at one group include 3*4 Bytes,
           Array s32CoefAttr[51] add 1，The last 4 Bytes  only contain two numbers
           */
        for (i = 0; i < 17; i++)
        {
            s32CoefTmp1 = (HI_S32) * ps16Coef++;
            s32CoefTmp2 = (HI_S32) * ps16Coef++;
            s32CoefTmp3 = (HI_S32) * ps16Coef++;
            pBitCoef->s32CoefAttr[j++] = (s32CoefTmp1 & 0x3ff) + ((s32CoefTmp2 << 10) & 0xffc00) + (s32CoefTmp3 << 20);

            s32CoefTmp1 = (HI_S32) * ps16Coef++;
            s32CoefTmp2 = (HI_S32) * ps16Coef++;
            s32CoefTmp3 = (HI_S32) * ps16Coef++;
            pBitCoef->s32CoefAttr[j++] = (s32CoefTmp1 & 0x3ff) + ((s32CoefTmp2 << 10) & 0xffc00) + (s32CoefTmp3 << 20);

            s32CoefTmp1 = (HI_S32) * ps16Coef++;
            s32CoefTmp2 = (HI_S32) * ps16Coef++;
            pBitCoef->s32CoefAttr[j++] = (s32CoefTmp1 & 0x3ff) + ((s32CoefTmp2 << 10) & 0xffc00);
        }

        pBitCoef->u32Size = 17 * 3 * 4; /* size unit is Byte */
    }
    else
    {
        for (i = 0; i < 17; i++)
        {
            for (k = 1; k <= (u32Tap / 2); k++)
            {
                s32CoefTmp1 = (HI_S32) * ps16Coef++;
                s32CoefTmp2 = (HI_S32) * ps16Coef++;
                pBitCoef->s32CoefAttr[j++] = (s32CoefTmp1 & 0xffff) + (s32CoefTmp2 << 16);
            }
        }
        pBitCoef->u32Size = 17 * (u32Tap / 2) * 4;
    }

    return HI_SUCCESS;
}

/* load hor and vert coef */
static HI_U32 VZmeLoadVpssCoef(PQ_HAL_ZME_COEF_RATIO_E enCoefRatio, VZME_VPSS_COEF_TYPE_E enCoefType, VZME_TAP_E enZmeTap, HI_U32* pu32Addr)
{
    ZME_COEF_BITARRAY_S stArray;

    //load chroma horizontal zoom coef
    VpssZmeTransCoefAlign(g_pVZmeVpssCoef[enCoefRatio][enCoefType], enZmeTap, &stArray);
    memcpy(pu32Addr, stArray.s32CoefAttr, stArray.u32Size);

    return HI_SUCCESS;
}

/* Vpss in 3716mv410 is LH8、CH4、LV4、CV4 */
HI_VOID PQ_HAL_VpssLoadCoef(HI_U32* pu32CurAddr, HI_U32 u32PhyAddr, ALG_VZME_COEF_ADDR_S* pstAddrTmp)
{
    HI_U32 u32NumSize;

    /* HL8 */
    u32NumSize = 256;
    VZmeLoadVpssCoef(PQ_HAL_ZME_COEF_1, VZME_VPSS_COEF_8T32P_LH, VZME_TAP_8T32P, pu32CurAddr);
    pstAddrTmp->u32ZmeCoefAddrHL8_1 = u32PhyAddr;
    u32PhyAddr  += u32NumSize;
    pu32CurAddr += u32NumSize / 4;

    VZmeLoadVpssCoef(PQ_HAL_ZME_COEF_E1, VZME_VPSS_COEF_8T32P_LH, VZME_TAP_8T32P, pu32CurAddr);
    pstAddrTmp->u32ZmeCoefAddrHL8_E1 = u32PhyAddr;
    u32PhyAddr  += u32NumSize;
    pu32CurAddr += u32NumSize / 4;

    VZmeLoadVpssCoef(PQ_HAL_ZME_COEF_075, VZME_VPSS_COEF_8T32P_LH, VZME_TAP_8T32P, pu32CurAddr);
    pstAddrTmp->u32ZmeCoefAddrHL8_075 = u32PhyAddr;
    u32PhyAddr  += u32NumSize;
    pu32CurAddr += u32NumSize / 4;

    VZmeLoadVpssCoef(PQ_HAL_ZME_COEF_05, VZME_VPSS_COEF_8T32P_LH, VZME_TAP_8T32P, pu32CurAddr);
    pstAddrTmp->u32ZmeCoefAddrHL8_05 = u32PhyAddr;
    u32PhyAddr  += u32NumSize;
    pu32CurAddr += u32NumSize / 4;

    VZmeLoadVpssCoef(PQ_HAL_ZME_COEF_033, VZME_VPSS_COEF_8T32P_LH, VZME_TAP_8T32P, pu32CurAddr);
    pstAddrTmp->u32ZmeCoefAddrHL8_033 = u32PhyAddr;
    u32PhyAddr  += u32NumSize;
    pu32CurAddr += u32NumSize / 4;

    VZmeLoadVpssCoef(PQ_HAL_ZME_COEF_025, VZME_VPSS_COEF_8T32P_LH, VZME_TAP_8T32P, pu32CurAddr);
    pstAddrTmp->u32ZmeCoefAddrHL8_025 = u32PhyAddr;
    u32PhyAddr  += u32NumSize;
    pu32CurAddr += u32NumSize / 4;

    VZmeLoadVpssCoef(PQ_HAL_ZME_COEF_0, VZME_VPSS_COEF_8T32P_LH, VZME_TAP_8T32P, pu32CurAddr);
    pstAddrTmp->u32ZmeCoefAddrHL8_0 = u32PhyAddr;
    u32PhyAddr  += u32NumSize;
    pu32CurAddr += u32NumSize / 4;

    /* HC4 */
    u32NumSize = 256;
    VZmeLoadVpssCoef(PQ_HAL_ZME_COEF_1, VZME_VPSS_COEF_4T32P_CH, VZME_TAP_4T32P, pu32CurAddr);
    pstAddrTmp->u32ZmeCoefAddrHC4_1 = u32PhyAddr;
    u32PhyAddr  += u32NumSize;
    pu32CurAddr += u32NumSize / 4;

    VZmeLoadVpssCoef(PQ_HAL_ZME_COEF_E1, VZME_VPSS_COEF_4T32P_CH, VZME_TAP_4T32P, pu32CurAddr);
    pstAddrTmp->u32ZmeCoefAddrHC4_E1 = u32PhyAddr;
    u32PhyAddr  += u32NumSize;
    pu32CurAddr += u32NumSize / 4;

    VZmeLoadVpssCoef(PQ_HAL_ZME_COEF_075, VZME_VPSS_COEF_4T32P_CH, VZME_TAP_4T32P, pu32CurAddr);
    pstAddrTmp->u32ZmeCoefAddrHC4_075 = u32PhyAddr;
    u32PhyAddr  += u32NumSize;
    pu32CurAddr += u32NumSize / 4;

    VZmeLoadVpssCoef(PQ_HAL_ZME_COEF_05, VZME_VPSS_COEF_4T32P_CH, VZME_TAP_4T32P, pu32CurAddr);
    pstAddrTmp->u32ZmeCoefAddrHC4_05 = u32PhyAddr;
    u32PhyAddr  += u32NumSize;
    pu32CurAddr += u32NumSize / 4;

    VZmeLoadVpssCoef(PQ_HAL_ZME_COEF_033, VZME_VPSS_COEF_4T32P_CH, VZME_TAP_4T32P, pu32CurAddr);
    pstAddrTmp->u32ZmeCoefAddrHC4_033 = u32PhyAddr;
    u32PhyAddr  += u32NumSize;
    pu32CurAddr += u32NumSize / 4;

    VZmeLoadVpssCoef(PQ_HAL_ZME_COEF_025, VZME_VPSS_COEF_4T32P_CH, VZME_TAP_4T32P, pu32CurAddr);
    pstAddrTmp->u32ZmeCoefAddrHC4_025 = u32PhyAddr;
    u32PhyAddr  += u32NumSize;
    pu32CurAddr += u32NumSize / 4;

    VZmeLoadVpssCoef(PQ_HAL_ZME_COEF_0, VZME_VPSS_COEF_4T32P_CH, VZME_TAP_4T32P, pu32CurAddr);
    pstAddrTmp->u32ZmeCoefAddrHC4_0 = u32PhyAddr;
    u32PhyAddr  += u32NumSize;
    pu32CurAddr += u32NumSize / 4;

    /* VL4 */
    u32NumSize = 256;
    VZmeLoadVpssCoef(PQ_HAL_ZME_COEF_1, VZME_VPSS_COEF_4T32P_LV, VZME_TAP_4T32P, pu32CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVL4_1 = u32PhyAddr;
    u32PhyAddr  += u32NumSize;
    pu32CurAddr += u32NumSize / 4;

    VZmeLoadVpssCoef(PQ_HAL_ZME_COEF_E1, VZME_VPSS_COEF_4T32P_LV, VZME_TAP_4T32P, pu32CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVL4_E1 = u32PhyAddr;
    u32PhyAddr  += u32NumSize;
    pu32CurAddr += u32NumSize / 4;

    VZmeLoadVpssCoef(PQ_HAL_ZME_COEF_075, VZME_VPSS_COEF_4T32P_LV, VZME_TAP_4T32P, pu32CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVL4_075 = u32PhyAddr;
    u32PhyAddr  += u32NumSize;
    pu32CurAddr += u32NumSize / 4;

    VZmeLoadVpssCoef(PQ_HAL_ZME_COEF_05, VZME_VPSS_COEF_4T32P_LV, VZME_TAP_4T32P, pu32CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVL4_05 = u32PhyAddr;
    u32PhyAddr  += u32NumSize;
    pu32CurAddr += u32NumSize / 4;

    VZmeLoadVpssCoef(PQ_HAL_ZME_COEF_033, VZME_VPSS_COEF_4T32P_LV, VZME_TAP_4T32P, pu32CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVL4_033 = u32PhyAddr;
    u32PhyAddr  += u32NumSize;
    pu32CurAddr += u32NumSize / 4;

    VZmeLoadVpssCoef(PQ_HAL_ZME_COEF_025, VZME_VPSS_COEF_4T32P_LV, VZME_TAP_4T32P, pu32CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVL4_025 = u32PhyAddr;
    u32PhyAddr  += u32NumSize;
    pu32CurAddr += u32NumSize / 4;

    VZmeLoadVpssCoef(PQ_HAL_ZME_COEF_0, VZME_VPSS_COEF_4T32P_LV, VZME_TAP_4T32P, pu32CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVL4_0 = u32PhyAddr;
    u32PhyAddr  += u32NumSize;
    pu32CurAddr += u32NumSize / 4;

    /* VC4 */
    u32NumSize = 256;
    VZmeLoadVpssCoef(PQ_HAL_ZME_COEF_1, VZME_VPSS_COEF_4T32P_CV, VZME_TAP_4T32P, pu32CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVC4_1 = u32PhyAddr;
    u32PhyAddr  += u32NumSize;
    pu32CurAddr += u32NumSize / 4;

    VZmeLoadVpssCoef(PQ_HAL_ZME_COEF_E1, VZME_VPSS_COEF_4T32P_CV, VZME_TAP_4T32P, pu32CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVC4_E1 = u32PhyAddr;
    u32PhyAddr  += u32NumSize;
    pu32CurAddr += u32NumSize / 4;

    VZmeLoadVpssCoef(PQ_HAL_ZME_COEF_075, VZME_VPSS_COEF_4T32P_CV, VZME_TAP_4T32P, pu32CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVC4_075 = u32PhyAddr;
    u32PhyAddr  += u32NumSize;
    pu32CurAddr += u32NumSize / 4;

    VZmeLoadVpssCoef(PQ_HAL_ZME_COEF_05, VZME_VPSS_COEF_4T32P_CV, VZME_TAP_4T32P, pu32CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVC4_05 = u32PhyAddr;
    u32PhyAddr  += u32NumSize;
    pu32CurAddr += u32NumSize / 4;

    VZmeLoadVpssCoef(PQ_HAL_ZME_COEF_033, VZME_VPSS_COEF_4T32P_CV, VZME_TAP_4T32P, pu32CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVC4_033 = u32PhyAddr;
    u32PhyAddr  += u32NumSize;
    pu32CurAddr += u32NumSize / 4;

    VZmeLoadVpssCoef(PQ_HAL_ZME_COEF_025, VZME_VPSS_COEF_4T32P_CV, VZME_TAP_4T32P, pu32CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVC4_025 = u32PhyAddr;
    u32PhyAddr  += u32NumSize;
    pu32CurAddr += u32NumSize / 4;

    VZmeLoadVpssCoef(PQ_HAL_ZME_COEF_0, VZME_VPSS_COEF_4T32P_CV, VZME_TAP_4T32P, pu32CurAddr);
    pstAddrTmp->u32ZmeCoefAddrVC4_0 = u32PhyAddr;
    u32PhyAddr  += u32NumSize;
    pu32CurAddr += u32NumSize / 4;

    return;
}

/***********************************Load VPSS ZME COEF END*******************************************/

/***************************************VPSS ZME START*******************************************/

static HI_S32 PQ_HAL_VPSS_SetZmeEnable(HI_U32 u32HandleNo, VPSS_REG_PORT_E ePort, S_CAS_REGS_TYPE* pstReg, REG_ZME_MODE_E eMode, HI_BOOL bEnable)
{
    switch (ePort)
    {
        case VPSS_REG_HD:
            if ((eMode ==  REG_ZME_MODE_HORL ) || (eMode == REG_ZME_MODE_HOR) || (eMode == REG_ZME_MODE_ALL))
            {
                pstReg->VPSS_VHD0_HSP.bits.hlmsc_en = bEnable;
            }
            if ((eMode == REG_ZME_MODE_HORC) || (eMode == REG_ZME_MODE_HOR) || (eMode == REG_ZME_MODE_ALL))
            {
                pstReg->VPSS_VHD0_HSP.bits.hchmsc_en = bEnable;
            }
            if ((eMode == REG_ZME_MODE_VERL) || (eMode == REG_ZME_MODE_VER) || (eMode == REG_ZME_MODE_ALL))
            {
                pstReg->VPSS_VHD0_VSP.bits.vlmsc_en = bEnable;
            }
            if ((eMode == REG_ZME_MODE_VERC) || (eMode == REG_ZME_MODE_VER) || (eMode == REG_ZME_MODE_ALL))
            {
                pstReg->VPSS_VHD0_VSP.bits.vchmsc_en = bEnable;
            }
            break;

        default:
            HI_ERR_PQ("Error,PQ_HAL_VPSS_SetZmeEnable error\n");
            break;
    }

    return HI_SUCCESS;
}

static HI_S32 PQ_HAL_VPSS_SetZmeInSize(HI_U32 u32HandleNo, VPSS_REG_PORT_E ePort, S_CAS_REGS_TYPE* pstReg, HI_U32 u32Height, HI_U32 u32Width)
{
    switch (ePort)
    {
        case VPSS_REG_HD:

            break;
        default:
            HI_ERR_PQ("Error,PQ_HAL_VPSS_SetZmeInSize error\n");
            break;
    }

    return HI_SUCCESS;
}

static HI_S32 PQ_HAL_VPSS_SetZmeOutSize(HI_U32 u32HandleNo, VPSS_REG_PORT_E ePort, S_CAS_REGS_TYPE* pstReg, HI_U32 u32Height, HI_U32 u32Width)
{
    switch (ePort)
    {
        case VPSS_REG_HD:
            pstReg->VPSS_VHD0_ZMEORESO.bits.vhd0_zme_oh = u32Height - 1;
            pstReg->VPSS_VHD0_ZMEORESO.bits.vhd0_zme_ow = u32Width  - 1;
            break;

        default:
            HI_ERR_PQ("Error,PQ_HAL_VPSS_SetZmeOutSize error\n");
            break;
    }

    return HI_SUCCESS;
}

static HI_S32 PQ_HAL_VPSS_SetZmeFirEnable(HI_U32 u32HandleNo, VPSS_REG_PORT_E ePort, S_CAS_REGS_TYPE* pstReg, REG_ZME_MODE_E eMode, HI_BOOL bEnable)
{
    switch (ePort)
    {
        case VPSS_REG_HD:
            if ((eMode ==  REG_ZME_MODE_HORL ) || (eMode == REG_ZME_MODE_HOR) || (eMode == REG_ZME_MODE_ALL))
            {
                pstReg->VPSS_VHD0_HSP.bits.hlfir_en = bEnable;
            }
            if ((eMode == REG_ZME_MODE_HORC) || (eMode == REG_ZME_MODE_HOR) || (eMode == REG_ZME_MODE_ALL))
            {
                pstReg->VPSS_VHD0_HSP.bits.hchfir_en = bEnable;
            }
            if ((eMode == REG_ZME_MODE_VERL) || (eMode == REG_ZME_MODE_VER) || (eMode == REG_ZME_MODE_ALL))
            {
                pstReg->VPSS_VHD0_VSP.bits.vlfir_en = bEnable;
            }
            if ((eMode == REG_ZME_MODE_VERC) || (eMode == REG_ZME_MODE_VER) || (eMode == REG_ZME_MODE_ALL))
            {
                pstReg->VPSS_VHD0_VSP.bits.vchfir_en = bEnable;
            }
            break;

        default:
            HI_ERR_PQ("Error,PQ_HAL_VPSS_SetZmeFirEnable error\n");
            break;
    }

    return HI_SUCCESS;
}

static HI_S32 PQ_HAL_VPSS_SetZmeMidEnable(HI_U32 u32HandleNo, VPSS_REG_PORT_E ePort, S_CAS_REGS_TYPE* pstReg, REG_ZME_MODE_E eMode, HI_BOOL bEnable)
{
    switch (ePort)
    {
        case VPSS_REG_HD:
            if ((eMode == REG_ZME_MODE_HORL) || (eMode == REG_ZME_MODE_HOR) || (eMode == REG_ZME_MODE_ALL))
            {
                pstReg->VPSS_VHD0_HSP.bits.hlmid_en = bEnable;
            }
            if ((eMode ==  REG_ZME_MODE_HORC) || (eMode == REG_ZME_MODE_HOR) || (eMode == REG_ZME_MODE_ALL))
            {
                pstReg->VPSS_VHD0_HSP.bits.hchmid_en = bEnable;
            }
            if ((eMode == REG_ZME_MODE_VERL) || (eMode == REG_ZME_MODE_VER) || (eMode == REG_ZME_MODE_ALL))
            {
                pstReg->VPSS_VHD0_VSP.bits.vlmid_en = bEnable;
            }
            if ((eMode == REG_ZME_MODE_VERC) || (eMode == REG_ZME_MODE_VER) || (eMode == REG_ZME_MODE_ALL))
            {
                pstReg->VPSS_VHD0_VSP.bits.vchmid_en = bEnable;
            }
            break;

        default:
            HI_ERR_PQ("Error,PQ_HAL_VPSS_SetZmeMidEnable error\n");
            break;
    }

    return HI_SUCCESS;
}

static HI_S32 PQ_HAL_VPSS_SetZmePhase(HI_U32 u32HandleNo, VPSS_REG_PORT_E ePort, S_CAS_REGS_TYPE* pstReg, REG_ZME_MODE_E eMode, HI_S32 s32Phase)
{
    switch (ePort)
    {
        case VPSS_REG_HD:
            if (eMode == REG_ZME_MODE_HORC)
            {
                pstReg->VPSS_VHD0_HCOFFSET.bits.hor_coffset = s32Phase;
            }
            else if (eMode == REG_ZME_MODE_HORL)
            {
                pstReg->VPSS_VHD0_HLOFFSET.bits.hor_loffset = s32Phase;
            }
            else if (eMode == REG_ZME_MODE_VERC)
            {
                pstReg->VPSS_VHD0_VOFFSET.bits.vchroma_offset = s32Phase;
            }
            else if (eMode == REG_ZME_MODE_VERL)
            {
                pstReg->VPSS_VHD0_VOFFSET.bits.vluma_offset = s32Phase;
            }
            else
            {
                HI_ERR_PQ("Error,VPSS_REG_SetZmePhase error\n");
            }
            break;

        default:
            HI_ERR_PQ("Error,PQ_HAL_VPSS_SetZmePhase error\n");
            break;
    }

    return HI_SUCCESS;
}

static HI_S32 PQ_HAL_VPSS_SetZmeRatio(HI_U32 u32HandleNo, VPSS_REG_PORT_E ePort, S_CAS_REGS_TYPE* pstReg, REG_ZME_MODE_E eMode, HI_U32 u32Ratio)
{
    switch (ePort)
    {
        case VPSS_REG_HD:
            if (eMode == REG_ZME_MODE_HOR)
            {
                pstReg->VPSS_VHD0_HSP.bits.hratio = u32Ratio;
            }
            else
            {
                pstReg->VPSS_VHD0_VSR.bits.vratio = u32Ratio;
            }
            break;

        default:
            HI_ERR_PQ("Error,PQ_HAL_VPSS_SetZmeRatio error\n");
            break;
    }

    return HI_SUCCESS;
}

static HI_S32 PQ_HAL_VPSS_SetZmeHfirOrder(HI_U32 u32HandleNo, VPSS_REG_PORT_E ePort, S_CAS_REGS_TYPE* pstReg, HI_BOOL bVfirst)
{
    switch (ePort)
    {
        case VPSS_REG_HD:
            //pstReg->VPSS_VHD_HSP.bits.hfir_order = bVfirst;
            break;

        default:
            HI_ERR_PQ("Error,PQ_HAL_VPSS_SetZmeHfirOrder error\n");
            break;
    }

    return HI_SUCCESS;
}

static HI_S32 PQ_HAL_VPSS_SetZmeInFmt(HI_U32 u32HandleNo, VPSS_REG_PORT_E ePort, S_CAS_REGS_TYPE* pstReg, HI_DRV_PIX_FORMAT_E eFormat)
{
    HI_U32 u32Format;

    switch (eFormat)
    {
        case HI_DRV_PIX_FMT_NV21_TILE_CMP:
        case HI_DRV_PIX_FMT_NV12_TILE_CMP:
        case HI_DRV_PIX_FMT_NV21_TILE:
        case HI_DRV_PIX_FMT_NV12_TILE:
        case HI_DRV_PIX_FMT_NV21:
        case HI_DRV_PIX_FMT_NV12:
        case HI_DRV_PIX_FMT_NV61:
        case HI_DRV_PIX_FMT_NV16:
        case HI_DRV_PIX_FMT_YUV400:
        case HI_DRV_PIX_FMT_YUV422_1X2:
        case HI_DRV_PIX_FMT_YUV420p:
        case HI_DRV_PIX_FMT_YUV410p:
            u32Format = 0x1;
            break;
        case HI_DRV_PIX_FMT_NV61_2X1:
        case HI_DRV_PIX_FMT_NV16_2X1:
        case HI_DRV_PIX_FMT_YUV_444:
        case HI_DRV_PIX_FMT_YUV422_2X1:
        case HI_DRV_PIX_FMT_YUV411:
        case HI_DRV_PIX_FMT_YUYV:
        case HI_DRV_PIX_FMT_YVYU:
        case HI_DRV_PIX_FMT_UYVY:
            u32Format = 0x0;
            break;
        default:
            HI_ERR_PQ("Error,PQ_HAL_VPSS_SetZmeInFmt error\n");
            return HI_FAILURE;
    }

    switch (ePort)
    {
        case VPSS_REG_HD:
            pstReg->VPSS_VHD0_VSP.bits.zme_in_fmt = u32Format;
            break;

        default:
            HI_ERR_PQ("Error,PQ_HAL_VPSS_SetZmeInFmt error\n");
            break;
    }

    return HI_SUCCESS;
}

static HI_S32 PQ_HAL_VPSS_SetZmeOutFmt(HI_U32 u32HandleNo, VPSS_REG_PORT_E ePort, S_CAS_REGS_TYPE* pstReg, HI_DRV_PIX_FORMAT_E eFormat)
{
    HI_U32 u32Format;

    switch (eFormat)
    {
        case HI_DRV_PIX_FMT_NV21:
        case HI_DRV_PIX_FMT_NV12:
        case HI_DRV_PIX_FMT_NV21_CMP:
        case HI_DRV_PIX_FMT_NV12_CMP:
        case HI_DRV_PIX_FMT_NV12_TILE:
        case HI_DRV_PIX_FMT_NV21_TILE:
        case HI_DRV_PIX_FMT_NV12_TILE_CMP:
        case HI_DRV_PIX_FMT_NV21_TILE_CMP:
            u32Format = 0x1;
            break;
        case HI_DRV_PIX_FMT_NV61_2X1:
        case HI_DRV_PIX_FMT_NV16_2X1:
        case HI_DRV_PIX_FMT_NV61_2X1_CMP:
        case HI_DRV_PIX_FMT_NV16_2X1_CMP:
        case HI_DRV_PIX_FMT_YUYV:
        case HI_DRV_PIX_FMT_YVYU:
        case HI_DRV_PIX_FMT_UYVY:
        case HI_DRV_PIX_FMT_ARGB8888:   /* sp420->sp422->csc->rgb */
        case HI_DRV_PIX_FMT_ABGR8888:
            //case HI_DRV_PIX_FMT_KBGR8888:
            u32Format = 0x0;
            break;
        default:
            HI_ERR_PQ("Error,PQ_HAL_VPSS_SetZmeOutFmt error\n");
            return HI_FAILURE;
    }

    switch (ePort)
    {
        case VPSS_REG_HD:
            pstReg->VPSS_VHD0_VSP.bits.zme_out_fmt = u32Format;
            break;

        default:
            HI_ERR_PQ("Error,PQ_HAL_VPSS_SetZmeOutFmt error\n");
            break;
    }

    return HI_SUCCESS;
}

static HI_S32 PQ_HAL_VPSS_SetZmeCoefAddr(HI_U32 u32HandleNo, VPSS_REG_PORT_E ePort, S_CAS_REGS_TYPE* pstReg, REG_ZME_MODE_E eMode, HI_U32 u32Addr)
{
    switch (ePort)
    {
        case VPSS_REG_HD:
            if (eMode == REG_ZME_MODE_HORC)
            {
                pstReg->VPSS_VHD0_ZME_CHADDR = u32Addr;
            }
            else if (eMode == REG_ZME_MODE_HORL)
            {
                pstReg->VPSS_VHD0_ZME_LHADDR = u32Addr;
            }
            else if (eMode == REG_ZME_MODE_VERC)
            {
                pstReg->VPSS_VHD0_ZME_CVADDR = u32Addr;
            }
            else if (eMode == REG_ZME_MODE_VERL)
            {
                pstReg->VPSS_VHD0_ZME_LVADDR = u32Addr;
            }
            else
            {
                HI_ERR_PQ("Error,PQ_HAL_VPSS_SetZmeCoefAddr error\n");
            }
            break;

        default:
            HI_ERR_PQ("Error,PQ_HAL_VPSS_SetZmeCoefAddr error\n");
            break;
    }

    return HI_SUCCESS;
}

/* Vpss Cfg Set to reg */
HI_VOID PQ_HAL_VpssZmeRegCfg(HI_U32 u32LayerId, S_CAS_REGS_TYPE* pstReg, ALG_VZME_RTL_PARA_S* pstZmeRtlPara, HI_BOOL bFirEnable)
{
    HI_U32 ih;
    HI_U32 iw;
    HI_U32 oh;
    HI_U32 ow;
    HI_U32 u32HandleNo = 0;

    ih = pstZmeRtlPara->u32ZmeHIn;
    iw = pstZmeRtlPara->u32ZmeWIn;
    oh = pstZmeRtlPara->u32ZmeHOut;
    ow = pstZmeRtlPara->u32ZmeWOut;

    if (ih == oh && iw == ow && iw > 1920 && ih > 1200)
    {
        PQ_HAL_VPSS_SetZmeEnable(u32HandleNo, u32LayerId, pstReg, REG_ZME_MODE_ALL, HI_FALSE);
    }
    else
    {
        PQ_HAL_VPSS_SetZmeEnable(u32HandleNo, u32LayerId, pstReg, REG_ZME_MODE_ALL, HI_TRUE);
    }

    /* debug start z00128410 2012-1-30; debug config for SDK debug: fixed to copy mode that don't need zme coefficient */
    /*
    pstZmeRtlPara->bZmeMdHL = 0;
    pstZmeRtlPara->bZmeMdHC = 0;
    pstZmeRtlPara->bZmeMdVL = 0;
    pstZmeRtlPara->bZmeMdVC = 0;
    */
    /* debug end z00128410 2012-1-30 */

    if (!bFirEnable)
    {
        /* for fidelity output */
        PQ_HAL_VPSS_SetZmeFirEnable(u32HandleNo, u32LayerId, pstReg, REG_ZME_MODE_HORL, pstZmeRtlPara->bZmeMdHL);
        PQ_HAL_VPSS_SetZmeFirEnable(u32HandleNo, u32LayerId, pstReg, REG_ZME_MODE_HORC, pstZmeRtlPara->bZmeMdHC);
        PQ_HAL_VPSS_SetZmeFirEnable(u32HandleNo, u32LayerId, pstReg, REG_ZME_MODE_VERL, HI_FALSE);
        PQ_HAL_VPSS_SetZmeFirEnable(u32HandleNo, u32LayerId, pstReg, REG_ZME_MODE_VERC, HI_FALSE);
    }
    else
    {
        /* for normal output */
        PQ_HAL_VPSS_SetZmeFirEnable(u32HandleNo, u32LayerId, pstReg, REG_ZME_MODE_HORL, pstZmeRtlPara->bZmeMdHL);
        PQ_HAL_VPSS_SetZmeFirEnable(u32HandleNo, u32LayerId, pstReg, REG_ZME_MODE_HORC, pstZmeRtlPara->bZmeMdHC);
        PQ_HAL_VPSS_SetZmeFirEnable(u32HandleNo, u32LayerId, pstReg, REG_ZME_MODE_VERL, pstZmeRtlPara->bZmeMdVL);
        PQ_HAL_VPSS_SetZmeFirEnable(u32HandleNo, u32LayerId, pstReg, REG_ZME_MODE_VERC, pstZmeRtlPara->bZmeMdVC);
    }

    PQ_HAL_VPSS_SetZmeMidEnable(u32HandleNo, u32LayerId, pstReg, REG_ZME_MODE_HORL, pstZmeRtlPara->bZmeMedHL);
    PQ_HAL_VPSS_SetZmeMidEnable(u32HandleNo, u32LayerId, pstReg, REG_ZME_MODE_HORC, pstZmeRtlPara->bZmeMedHC);
    PQ_HAL_VPSS_SetZmeMidEnable(u32HandleNo, u32LayerId, pstReg, REG_ZME_MODE_VERL, pstZmeRtlPara->bZmeMedVL);
    PQ_HAL_VPSS_SetZmeMidEnable(u32HandleNo, u32LayerId, pstReg, REG_ZME_MODE_VERC, pstZmeRtlPara->bZmeMedVC);

    PQ_HAL_VPSS_SetZmePhase(u32HandleNo, u32LayerId, pstReg, REG_ZME_MODE_VERL, pstZmeRtlPara->s32ZmeOffsetVL);
    PQ_HAL_VPSS_SetZmePhase(u32HandleNo, u32LayerId, pstReg, REG_ZME_MODE_VERC, pstZmeRtlPara->s32ZmeOffsetVC);

    PQ_HAL_VPSS_SetZmeRatio(u32HandleNo, u32LayerId, pstReg, REG_ZME_MODE_HOR, pstZmeRtlPara->u32ZmeRatioHL);
    PQ_HAL_VPSS_SetZmeRatio(u32HandleNo, u32LayerId, pstReg, REG_ZME_MODE_VER, pstZmeRtlPara->u32ZmeRatioVL);

    if (u32LayerId == VPSS_REG_SD)
    {
        PQ_HAL_VPSS_SetZmeHfirOrder(u32HandleNo, u32LayerId, pstReg, pstZmeRtlPara->bZmeOrder);
    }

    if (pstZmeRtlPara->u8ZmeYCFmtIn == PQ_ALG_ZME_PIX_FORMAT_SP420)
    {
        PQ_HAL_VPSS_SetZmeInFmt(u32HandleNo, u32LayerId, pstReg, HI_DRV_PIX_FMT_NV21);
    }
    else
    {
        PQ_HAL_VPSS_SetZmeInFmt(u32HandleNo, u32LayerId, pstReg, HI_DRV_PIX_FMT_NV61_2X1);
    }

    if (pstZmeRtlPara->u8ZmeYCFmtOut == PQ_ALG_ZME_PIX_FORMAT_SP420)
    {
        PQ_HAL_VPSS_SetZmeOutFmt(u32HandleNo, u32LayerId, pstReg, HI_DRV_PIX_FMT_NV21);
    }
    else
    {
        PQ_HAL_VPSS_SetZmeOutFmt(u32HandleNo, u32LayerId, pstReg, HI_DRV_PIX_FMT_NV61_2X1);
    }

    PQ_HAL_VPSS_SetZmeInSize(u32HandleNo, u32LayerId, pstReg, ih, iw);
    PQ_HAL_VPSS_SetZmeOutSize(u32HandleNo, u32LayerId, pstReg, oh, ow);

    PQ_HAL_VPSS_SetZmeCoefAddr(u32HandleNo, u32LayerId, pstReg, REG_ZME_MODE_HORL, pstZmeRtlPara->u32ZmeCoefAddrHL);
    PQ_HAL_VPSS_SetZmeCoefAddr(u32HandleNo, u32LayerId, pstReg, REG_ZME_MODE_HORC, pstZmeRtlPara->u32ZmeCoefAddrHC);
    PQ_HAL_VPSS_SetZmeCoefAddr(u32HandleNo, u32LayerId, pstReg, REG_ZME_MODE_VERL, pstZmeRtlPara->u32ZmeCoefAddrVL);
    PQ_HAL_VPSS_SetZmeCoefAddr(u32HandleNo, u32LayerId, pstReg, REG_ZME_MODE_VERC, pstZmeRtlPara->u32ZmeCoefAddrVC);

    return;
}

/*******************************VPSS ZME END*********************************/

static HI_VOID PQ_HAL_ColorSpaceTrans(PQ_HAL_DHD_COLORSPACE_E* penHDOutColorSpace, PQ_HAL_DHD_COLORSPACE_E* penSDOutColorSpace)
{
    HI_DRV_COLOR_SPACE_E enColorSpace_Dhd_HD, enColorSpace_Dhd_SD;

    if ((penHDOutColorSpace == HI_NULL) || (penSDOutColorSpace == HI_NULL))
    {
        return;
    }

    enColorSpace_Dhd_HD = g_stPqStatus.stTimingInfo[HI_PQ_DISPLAY_1].enOutColorSpace;
    enColorSpace_Dhd_SD = g_stPqStatus.stTimingInfo[HI_PQ_DISPLAY_0].enOutColorSpace;

    /* SD */
    if ((HI_DRV_CS_BT601_RGB_LIMITED == enColorSpace_Dhd_SD) || (HI_DRV_CS_BT601_RGB_FULL == enColorSpace_Dhd_SD)
        || (HI_DRV_CS_BT709_RGB_LIMITED == enColorSpace_Dhd_SD) || (HI_DRV_CS_BT709_RGB_FULL == enColorSpace_Dhd_SD)
        || (HI_DRV_CS_BT2020_RGB_LIMITED == enColorSpace_Dhd_SD) || (HI_DRV_CS_BT2020_RGB_FULL == enColorSpace_Dhd_SD))
    {
        *penSDOutColorSpace = PQ_HAL_DHD_OUT_RGB;
    }
    else
    {
        *penSDOutColorSpace = PQ_HAL_DHD_OUT_YUV;
    }

    /* HD */
    if ((HI_DRV_CS_BT601_RGB_LIMITED == enColorSpace_Dhd_HD) || (HI_DRV_CS_BT601_RGB_FULL == enColorSpace_Dhd_HD)
        || (HI_DRV_CS_BT709_RGB_LIMITED == enColorSpace_Dhd_HD) || (HI_DRV_CS_BT709_RGB_FULL == enColorSpace_Dhd_HD)
        || (HI_DRV_CS_BT2020_RGB_LIMITED == enColorSpace_Dhd_HD) || (HI_DRV_CS_BT2020_RGB_FULL == enColorSpace_Dhd_HD))
    {
        *penHDOutColorSpace = PQ_HAL_DHD_OUT_RGB;
    }
    else
    {
        *penHDOutColorSpace = PQ_HAL_DHD_OUT_YUV;
    }

    return;
}

HI_S32 PQ_HAL_GetZmeCoef(PQ_HAL_ZME_COEF_RATIO_E enCoefRatio, PQ_HAL_ZME_COEF_TYPE_E enCoefType, PQ_HAL_ZME_TAP_E enZmeTap, HI_S16* ps16Coef)
{
    HI_U32 u32CoefSize = 0;
    VZME_COEF_TYPE_E enZmeCoefType;

    switch (enZmeTap)
    {
        case PQ_HAL_ZME_TAP_8T32P:
        {
            if (PQ_HAL_ZME_COEF_TYPE_LH == enCoefType)
            {
                enZmeCoefType = VZME_COEF_8T32P_LH;
            }
            else if (PQ_HAL_ZME_COEF_TYPE_CH == enCoefType)
            {
                enZmeCoefType = VZME_COEF_8T32P_CH;
            }
            else
            {
                HI_ERR_PQ("enZmeTap:%d, enCoefType:%d,unsupport zme coef type!\n", enZmeTap, enCoefType);
                return HI_FAILURE;
            }

            u32CoefSize = sizeof(HI_S16) * 8 * 18;
            break;
        }

        case PQ_HAL_ZME_TAP_6T32P:
        {
            if (PQ_HAL_ZME_COEF_TYPE_LV == enCoefType)
            {
                enZmeCoefType = VZME_COEF_6T32P_LV;
            }
            else if (PQ_HAL_ZME_COEF_TYPE_CV == enCoefType)
            {
                enZmeCoefType = VZME_COEF_6T32P_CV;
            }
            else
            {
                HI_ERR_PQ("enZmeTap:%d, enCoefType:%d,unsupport zme coef type!\n", enZmeTap, enCoefType);
                return HI_FAILURE;
            }

            u32CoefSize = sizeof(HI_S16) * 6 * 18;

            break;
        }

        case PQ_HAL_ZME_TAP_4T32P:
        {
            if (PQ_HAL_ZME_COEF_TYPE_LV == enCoefType)
            {
                enZmeCoefType = VZME_COEF_4T32P_LV;
            }
            else if (PQ_HAL_ZME_COEF_TYPE_CH == enCoefType)
            {
                enZmeCoefType = VZME_COEF_4T32P_CH;
            }
            else if (PQ_HAL_ZME_COEF_TYPE_CV == enCoefType)
            {
                enZmeCoefType = VZME_COEF_4T32P_CV;
            }
            else
            {
                HI_ERR_PQ("enZmeTap:%d, enCoefType:%d,unsupport zme coef type!\n", enZmeTap, enCoefType);
                return HI_FAILURE;
            }

            u32CoefSize = sizeof(HI_S16) * 4 * 18;

            break;
        }

        case PQ_HAL_ZME_TAP_5T32P:
        {
            if (PQ_HAL_ZME_COEF_TYPE_LV == enCoefType)
            {
                enZmeCoefType = VZME_COEF_5T32P_LV;
            }
            else
            {
                HI_ERR_PQ("enZmeTap:%d, enCoefType:%d,unsupport zme coef type!\n", enZmeTap, enCoefType);
                return HI_FAILURE;
            }

            u32CoefSize = sizeof(HI_S16) * 5 * 18;

            break;
        }

        case PQ_HAL_ZME_TAP_3T32P:
        {
            if (PQ_HAL_ZME_COEF_TYPE_CV == enCoefType)
            {
                enZmeCoefType = VZME_COEF_3T32P_CV;
            }
            else
            {
                HI_ERR_PQ("enZmeTap:%d, enCoefType:%d,unsupport zme coef type!\n", enZmeTap, enCoefType);
                return HI_FAILURE;
            }

            u32CoefSize = sizeof(HI_S16) * 3 * 18;

            break;
        }

        case PQ_HAL_ZME_TAP_8T2P:
        {
            if ((PQ_HAL_ZME_COEF_TYPE_LH == enCoefType)
                || (PQ_HAL_ZME_COEF_TYPE_CH == enCoefType))
            {
                enZmeCoefType = VZME_COEF_8T2P_HOR;
            }
            else
            {
                HI_ERR_PQ("enZmeTap:%d, enCoefType:%d,unsupport zme coef type!\n", enZmeTap, enCoefType);
                return HI_FAILURE;
            }

            u32CoefSize = sizeof(HI_S16) * 8 * 2;

            break;
        }

        case PQ_HAL_ZME_TAP_6T2P:
        {
            if ((PQ_HAL_ZME_COEF_TYPE_LV == enCoefType)
                || (PQ_HAL_ZME_COEF_TYPE_CV == enCoefType))
            {
                enZmeCoefType = VZME_COEF_6T2P_VER;
            }
            else
            {
                HI_ERR_PQ("enZmeTap:%d, enCoefType:%d,unsupport zme coef type!\n", enZmeTap, enCoefType);
                return HI_FAILURE;
            }

            u32CoefSize = sizeof(HI_S16) * 6 * 2;

            break;
        }

        case PQ_HAL_ZME_TAP_2T32P:
            HI_ERR_PQ("enZmeTap:%d, enCoefType:%d,unsupport zme coef type!\n", enZmeTap, enCoefType);
            return HI_FAILURE;
        default:
            HI_ERR_PQ("enZmeTap:%d, enCoefType:%d,unsupport zme coef type!\n", enZmeTap, enCoefType);
            return HI_FAILURE;
    }


    if (0 != u32CoefSize)
    {
        memcpy((HI_VOID*)ps16Coef, (HI_VOID*)g_pVZmeCoef[enCoefRatio][enZmeCoefType], u32CoefSize);
    }
    else
    {
        HI_FATAL_PQ("Wrong Coef Size\n");
    }

    return HI_SUCCESS;
}

HI_S32 PQ_HAL_SetZmeDefault(HI_BOOL bOnOff)
{
    sg_bVpssZmeDefault = bOnOff;
    sg_bVdpZmeDefault  = bOnOff;

    return HI_SUCCESS;
}

static HI_S32 PQ_HAL_GetV0ZmeStrategy (HI_PQ_LAYER_STRATEGY_IN_S stZmeIn, HI_PQ_LAYER_STRATEGY_OUT_S* pstZmeOut)
{
    PQ_CHECK_NULL_PTR(pstZmeOut);

    pstZmeOut->bOpenP2I  = HI_FALSE; /* 可以认为是DHD0的P2I */

    /***
       (1) 如果HD接口输出Progressive格式 (如: 720P/1080P制式), 则V0按帧读入数据;
       (2) 如果HD接口输出Interlace格式 (如: 1080i制式), 则分以下三种情况:
           a) 如果源resolution==目的resolution (如: 输入1080P, 输出1080i), 则V0按场读入数据, 需要匹配场极性;
           b) 如果垂直真实缩放比<THD (如: 1/4, 此阈值需要测试后再确定), 则V0按场读入;
              (相当于两级缩小, 为了提升大比例缩小的图像效果);
           c) Else, V0按帧读入;

        注意: 当缩小比例较大(3倍以上), 为获得更好的缩小质量或提升缩放性能, 开启Prescaler抽行. 98CV200的Prescaler仅支持垂直抽行(1/2、1/4、1/8), 不支持水平抽点.
           ***/
    /* ToDo: test preferential ver prescaler or read field */
    if ((HI_FALSE == g_stPqStatus.stTimingInfo[HI_PQ_DISPLAY_1].bProgressive)
        && ((stZmeIn.u32FrmWIn == stZmeIn.u32FrmWOut) && (stZmeIn.u32FrmHIn == stZmeIn.u32FrmHOut))) /* Interlace output and source resolution == out resolution */
    {
        pstZmeOut->bReadFmtIn   = HI_FALSE; /* preferential read field; 按接口时序读顶底场 */
        pstZmeOut->eVScalerMode = HI_PQ_PREZME_VER_DISABLE;
        pstZmeOut->eHScalerMode = HI_PQ_PREZME_HOR_DISABLE; /* there is not hor prescaler in logic */
    }
    else /* Progressive or Interlace(1080i, 480i, 576i), 或帧分辨率不相等 */
    {
        pstZmeOut->bReadFmtIn = HI_TRUE; /* 0-field; 1-frame */

        /***
            Progressive Output List:
                     in        out          mode  multiple               scheme                zme tap
              1) 3840x2160  1920x1080         1      2       read frame and Ver prescaler  1     8644
              2) 1920x1080  1280x 720        1/4     6       read frame and Ver prescaler 1/2    8543
              3) 3840x2160  1280x 720        1/4     12      read frame and Ver prescaler 1/4    8543
              4) 4096x2304  1280x 720        1/4    12.8     read frame and Ver prescaler 1/8    8644

            Interlace Output List:
                     in        out          mode   multiple              scheme                 zme tap
              1) 720 x 576  720 x 576(288)    1       2      read field and Ver prescaler  1     8644
              2) 1920x1080  1920x1080(540)    1       2      read field and Ver prescaler  1     8644
              3) 720 x 576  720 x 480(240)    1      2.4     read frame and Ver prescaler  1     8644  ---zme出隔行
              4) 1920x1080  720 x 576(288)    1      3.75    read frame and Ver prescaler 1/2    8644
              5) 1920x1080  720 x 480(240)   1/4      18     read frame and Ver prescaler 1/8    8644  ---1080P源的极限场景, 不需要读场
              6) 3840x2160  1920x1080(540)   1/4      16     read frame and Ver prescaler 1/8    8644
              7) 3840x2160  720 x 576(288)   1/3     22.5    read frame and Ver prescaler 1/8    8543  ---需要zme降阶, 8644 -> 8543的场景, cbb消化
              8) 3840x2160  720 x 480(240)   1/4      36     read frame and Ver prescaler 1/8    8543
              9) 4096x2304  720 x 480(240)   1/4     38.4    read frame and Ver prescaler 1/8    8543  ---极限场景, 4K源能否读场?

              以上列举可以看出: FHD源, 除1080i制式输出之外，其余不需要读场; 极限场景需要打开P2I或者读场的, 都是4K源;
            ***/
        if (stZmeIn.u32FrmHIn <= V0_READ_FMT_ZME_THD * stZmeIn.u32FrmHOut) /* (in <= out) or (> 1 ~ <= 3); read frame and close prescaler*/
        {
            pstZmeOut->eVScalerMode = HI_PQ_PREZME_VER_DISABLE;
        }
        else if ((stZmeIn.u32FrmHIn > V0_READ_FMT_ZME_THD * stZmeIn.u32FrmHOut)
                 && (stZmeIn.u32FrmHIn <= V0_PREZME_ENABLE_2_THD * stZmeIn.u32FrmHOut)) /* > 3 ~ <= 6; read frame and 1/2 prescaler*/
        {
            pstZmeOut->eVScalerMode = HI_PQ_PREZME_VER_2X;
        }
        else if ((stZmeIn.u32FrmHIn > V0_PREZME_ENABLE_2_THD * stZmeIn.u32FrmHOut)
                 && (stZmeIn.u32FrmHIn <= V0_PREZME_ENABLE_4_THD * stZmeIn.u32FrmHOut)) /* > 6 ~ <= 12; read frame and 1/4 prescaler */
        {
            pstZmeOut->eVScalerMode = HI_PQ_PREZME_VER_4X;
        }
        else if ((stZmeIn.u32FrmHIn > V0_PREZME_ENABLE_4_THD * stZmeIn.u32FrmHOut)
                 && (stZmeIn.u32FrmHIn <= V0_PREZME_ENABLE_8_THD * stZmeIn.u32FrmHOut)) /* > 12 ~ <= 24; read frame and 1/8 prescaler */
        {
            pstZmeOut->eVScalerMode = HI_PQ_PREZME_VER_8X;
        }
        else if (stZmeIn.u32FrmHIn > V0_PREZME_ENABLE_8_THD * stZmeIn.u32FrmHOut)       /* > 24; read field and 1/8 prescaler */
        {
            /* 该倍数只在4K源(Vpss ByPass)时才会进入, 但4K没有场的概念, 理论上只能读帧; read field可认为是读基数行, 偶数行 */
            pstZmeOut->bReadFmtIn   = HI_FALSE;
            pstZmeOut->eVScalerMode = HI_PQ_PREZME_VER_8X;
        }
        else
        {
            pstZmeOut->eVScalerMode = HI_PQ_PREZME_VER_DISABLE;
        }
        pstZmeOut->eHScalerMode = HI_PQ_PREZME_HOR_DISABLE;
    }
    sg_bV0ReadFmtIn   = pstZmeOut->bReadFmtIn;
    sg_enV0PreHScaler = pstZmeOut->eHScalerMode;
    sg_enV0PreVScaler = pstZmeOut->eVScalerMode;

    /***
       There is two Scaler in V0 of 98CV200, Scaler1 + sharpen = SR.
       Logic Limit: Only 4K output, 输出是8的倍数(输入是4的倍数) 且放大倍数超过两倍(仅支持水平、垂直固定放大两倍), 开启Scaler1;
                    e.g.: 480->1080 open Scaler0, but close Scaler1;
                           nvr scene: resolution at 1920 ~ 3840/4096 do not open Scaler1
      ***/
    if (((stZmeIn.u32FrmWOut >= DHD0_OUT_RESOLUTION_W_THD) && (0 == stZmeIn.u32FrmWOut % 8))
        && ((stZmeIn.u32FrmHOut >= DHD0_OUT_RESOLUTION_H_THD) && (0 == stZmeIn.u32FrmHOut % 8))
        && (stZmeIn.u32FrmHOut > stZmeIn.u32FrmHIn * V0_SCALER1_ENABLE_THD))
    {
        pstZmeOut->stZmeFmt[0].u32FrmInHeight  = stZmeIn.u32FrmHIn;
        pstZmeOut->stZmeFmt[0].u32FrmInWidth   = stZmeIn.u32FrmWIn;
        pstZmeOut->stZmeFmt[0].u32FrmOutHeight = stZmeIn.u32FrmHOut / V0_SCALER1_ENABLE_THD;
        pstZmeOut->stZmeFmt[0].u32FrmOutWidth  = stZmeIn.u32FrmWOut / V0_SCALER1_ENABLE_THD;

        pstZmeOut->stZmeFmt[1].u32FrmInHeight  = pstZmeOut->stZmeFmt[0].u32FrmOutHeight;
        pstZmeOut->stZmeFmt[1].u32FrmInWidth   = pstZmeOut->stZmeFmt[0].u32FrmOutWidth;
        pstZmeOut->stZmeFmt[1].u32FrmOutHeight = stZmeIn.u32FrmHOut;
        pstZmeOut->stZmeFmt[1].u32FrmOutWidth  = stZmeIn.u32FrmWOut;

        pstZmeOut->u32ZmeNum = 2; /* zme number */
    }
    else
    {
        /* prescaler will change Height, cbb does not use the height of cbb calc; but we clac it in pq for strategy
           Absolutely condition: when open scaler1, prescaler must be closed */
        pstZmeOut->stZmeFmt[0].u32FrmInHeight  = stZmeIn.u32FrmHIn / (1 << pstZmeOut->eVScalerMode);
        pstZmeOut->stZmeFmt[0].u32FrmInWidth   = stZmeIn.u32FrmWIn / (1 << pstZmeOut->eHScalerMode);
        pstZmeOut->stZmeFmt[0].u32FrmOutHeight = stZmeIn.u32FrmHOut;
        pstZmeOut->stZmeFmt[0].u32FrmOutWidth  = stZmeIn.u32FrmWOut;

        pstZmeOut->stZmeFmt[1].u32FrmInHeight  = pstZmeOut->stZmeFmt[0].u32FrmOutHeight;
        pstZmeOut->stZmeFmt[1].u32FrmInWidth   = pstZmeOut->stZmeFmt[0].u32FrmOutWidth;
        pstZmeOut->stZmeFmt[1].u32FrmOutHeight = stZmeIn.u32FrmHOut;
        pstZmeOut->stZmeFmt[1].u32FrmOutWidth  = stZmeIn.u32FrmWOut;

        pstZmeOut->u32ZmeNum = 1;
    }

    if (stZmeIn.u32FrmWIn >= 2048)
    {
        /*Logic Limit: when inwith >= 2048, close  Scaler1*/
        pstZmeOut->stZmeFmt[0].u32FrmInHeight  = stZmeIn.u32FrmHIn / (1 << pstZmeOut->eVScalerMode);
        pstZmeOut->stZmeFmt[0].u32FrmInWidth   = stZmeIn.u32FrmWIn / (1 << pstZmeOut->eHScalerMode);
        pstZmeOut->stZmeFmt[0].u32FrmOutHeight = stZmeIn.u32FrmHOut;
        pstZmeOut->stZmeFmt[0].u32FrmOutWidth  = stZmeIn.u32FrmWOut;

        pstZmeOut->stZmeFmt[1].u32FrmInHeight  = pstZmeOut->stZmeFmt[0].u32FrmOutHeight;
        pstZmeOut->stZmeFmt[1].u32FrmInWidth   = pstZmeOut->stZmeFmt[0].u32FrmOutWidth;
        pstZmeOut->stZmeFmt[1].u32FrmOutHeight = stZmeIn.u32FrmHOut;
        pstZmeOut->stZmeFmt[1].u32FrmOutWidth  = stZmeIn.u32FrmWOut;

        pstZmeOut->u32ZmeNum = 1;
    }

    pstZmeOut->stZmeFmt[0].u32PixInFmt  = stZmeIn.u32FmtIn;
    pstZmeOut->stZmeFmt[0].u32PixOutFmt = 0; /* zme output: 0-422; 1-420; 2-444 */
    pstZmeOut->stZmeFmt[1].u32PixInFmt  = 0; /* zme input:  0-422; 1-420; 2-444 */
    pstZmeOut->stZmeFmt[1].u32PixOutFmt = 0; /* zme output: 0-422; 1-420; 2-444 */

    /* config zme mode; when frame resolution does not have change, can not open fir mode; e.g: 1920x1080 -> 1920x1080; other must open fir mode; */
    pstZmeOut->bZmeFirHL = (pstZmeOut->stZmeFmt[0].u32FrmOutWidth  == pstZmeOut->stZmeFmt[0].u32FrmInWidth)  ? HI_FALSE : HI_TRUE;
    pstZmeOut->bZmeFirVL = (pstZmeOut->stZmeFmt[0].u32FrmOutHeight == pstZmeOut->stZmeFmt[0].u32FrmInHeight) ? HI_FALSE : HI_TRUE;
    /* in format may be 420; out format must be 422; when 420 -> 422; vertical need up-sampling, but horizontal does not need */
    pstZmeOut->bZmeFirHC = (HI_FALSE == pstZmeOut->bZmeFirHL) ? HI_FALSE : HI_TRUE;
    pstZmeOut->bZmeFirVC = (HI_FALSE == pstZmeOut->bZmeFirVL) ? ((pstZmeOut->stZmeFmt[0].u32PixOutFmt == pstZmeOut->stZmeFmt[0].u32PixInFmt) ? HI_FALSE : HI_TRUE) : HI_TRUE;

    pstZmeOut->bZmeMedH  = HI_FALSE; /* zme Median filter enable of horizontal luma: 0-off; 1-on*/
    pstZmeOut->bZmeMedV  = HI_FALSE;

    if (HI_TRUE == sg_bVdpZmeDefault)
    {
        pstZmeOut->bZmeFirHL   = HI_FALSE;
        pstZmeOut->bZmeFirHC   = HI_FALSE;
        pstZmeOut->bZmeFirVL   = HI_FALSE;
        pstZmeOut->bZmeFirVC   = HI_FALSE;
        pstZmeOut->bZmeDefault = HI_TRUE; /* 1: rwzb */
    }
    else
    {
        pstZmeOut->bZmeDefault = HI_FALSE; /* 0: no rwzb */
    }

    return HI_SUCCESS;
}

static HI_S32 PQ_HAL_GetV1ZmeStrategy (HI_PQ_LAYER_STRATEGY_IN_S stZmeIn, HI_PQ_LAYER_STRATEGY_OUT_S* pstZmeOut)
{
    PQ_CHECK_NULL_PTR(pstZmeOut);

    pstZmeOut->u32ZmeNum    = 1; /* chroma up-sampling */
    pstZmeOut->eHScalerMode = HI_PQ_PREZME_HOR_DISABLE;
    pstZmeOut->eVScalerMode = HI_PQ_PREZME_VER_DISABLE;
    pstZmeOut->bOpenP2I     = HI_FALSE;

    if (HI_TRUE == g_stPqStatus.stTimingInfo[HI_PQ_DISPLAY_1].bProgressive)
    {
        pstZmeOut->bReadFmtIn = HI_TRUE; /* read frame */
    }
    else
    {
        pstZmeOut->bReadFmtIn = HI_FALSE;
    }

    pstZmeOut->bZmeFirHL = (stZmeIn.u32FrmWOut == stZmeIn.u32FrmWIn) ? HI_FALSE : HI_TRUE;
    pstZmeOut->bZmeFirVL = (stZmeIn.u32FrmHOut == stZmeIn.u32FrmHIn) ? HI_FALSE : HI_TRUE;
    pstZmeOut->bZmeFirHC = (HI_FALSE == pstZmeOut->bZmeFirHL) ? HI_FALSE : HI_TRUE;
    pstZmeOut->bZmeFirVC = (HI_FALSE == pstZmeOut->bZmeFirVL) ? ((stZmeIn.u32FmtIn == 0) ? HI_FALSE : HI_TRUE) : HI_TRUE;

    pstZmeOut->bZmeMedH  = HI_FALSE; /* zme Median filter enable of horizontal luma: 0-off; 1-on*/
    pstZmeOut->bZmeMedV  = HI_FALSE;

    if (HI_TRUE == sg_bVdpZmeDefault)
    {
        pstZmeOut->bZmeFirHL   = HI_FALSE;
        pstZmeOut->bZmeFirHC   = HI_FALSE;
        pstZmeOut->bZmeFirVL   = HI_FALSE;
        pstZmeOut->bZmeFirVC   = HI_FALSE;
        pstZmeOut->bZmeDefault = HI_TRUE; /* 1: rwzb */
    }
    else
    {
        pstZmeOut->bZmeDefault = HI_FALSE; /* 0: no rwzb */
    }

    return HI_SUCCESS;
}

static HI_S32 PQ_HAL_GetWbcVpZmeStrategy (HI_PQ_WBC_STRATEGY_IN_S stZmeIn, HI_PQ_WBC_VP_STRATEGY_OUT_S* pstZmeOut)
{
    HI_BOOL bAPointProgressive = HI_TRUE; /* A point frame format: 0-field; 1-frame */
    HI_U32  bAPointPixFmt      = 0;       /* A point video format: 0-422; 1-420; 2-444 */
    HI_U32  u32InWidth         = 0;
    HI_U32  u32InHeight        = 0;
    HI_U32  u32OutWidth        = 0;
    HI_U32  u32OutHeight       = 0;

    PQ_HAL_DHD_COLORSPACE_E enHDOutColorSpace = PQ_HAL_DHD_OUT_YUV;
    PQ_HAL_DHD_COLORSPACE_E enSDOutColorSpace = PQ_HAL_DHD_OUT_YUV;

    PQ_CHECK_NULL_PTR(pstZmeOut);

    pqprint(PQ_PRN_ZME, "V0 WIn:%d, HIn:%d, WOut:%d, HOut:%d\t", stZmeIn.stLayerInfo[0].u32FrmWIn, stZmeIn.stLayerInfo[0].u32FrmHIn,
            stZmeIn.stLayerInfo[0].u32FrmWOut, stZmeIn.stLayerInfo[0].u32FrmHOut);
    pqprint(PQ_PRN_ZME, "V3 WIn:%d, HIn:%d, WOut:%d, HOut:%d\n", stZmeIn.stLayerInfo[1].u32FrmWIn, stZmeIn.stLayerInfo[1].u32FrmHIn,
            stZmeIn.stLayerInfo[1].u32FrmWOut, stZmeIn.stLayerInfo[1].u32FrmHOut);


    PQ_HAL_ColorSpaceTrans(&enHDOutColorSpace, &enSDOutColorSpace);

    /***
        回写点选择策略:
        (1) 过指标场景: 回写点在V0;
        (2) 多窗口情况: 选择VP上CSC之后的回写点;
        (3) 水印场景:   选择VP上CSC之后的回写点;
        (4) 毛玻璃场景: 选择VP上CSC之后的回写点;
        (5) 大比例缩小情况:
            即(源->SD显示的缩小比例，如缩小10倍)> (源->HD显示的缩小比例，如缩小6倍), 则选择VP上CSC之后的回写点;
              (SD输出有两级缩小, 可以提升SD输出缩小的图像质量) -- 等价于高清通路是缩小场景;
        (6) Else, 选择V0 Scaler0之前的回写点;
      ***/
    if (HI_TRUE == sg_bVdpZmeDefault) /* rwzb */
    {
        pstZmeOut->enVpPoint = HI_PQ_WBC_POINT_V0;
    }
    else if (PQ_HAL_DHD_OUT_RGB == enHDOutColorSpace) /* Add 20160325 d00241380 when HD RGB out, write back from V0 */
    {
        pstZmeOut->enVpPoint = HI_PQ_WBC_POINT_V0;
    }
    else if (HI_TRUE == stZmeIn.bForceWbcPoint2Vp) /* (1)multi-window, (2)watermark, (3)forstglass; force to vp0 */
    {
        pstZmeOut->enVpPoint = HI_PQ_WBC_POINT_VP;
    }
    else if ((stZmeIn.stLayerInfo[0].u32FrmWIn == stZmeIn.stLayerInfo[1].u32FrmWOut)
             && (stZmeIn.stLayerInfo[0].u32FrmHIn == stZmeIn.stLayerInfo[1].u32FrmHOut)) /* Interlace output and source resolution == out resolution */
    {
        /* Add 20160325 d00241380 非指标场景, 但是源与CVBS的分辨率一致也要从V0回写 */
        pstZmeOut->enVpPoint = HI_PQ_WBC_POINT_V0;
    }
    else if ((stZmeIn.stLayerInfo[0].u32FrmHOut < stZmeIn.stLayerInfo[0].u32FrmHIn)
             && (stZmeIn.stLayerInfo[0].u32FrmHOut > stZmeIn.stLayerInfo[1].u32FrmHOut))
    {
        /* Modify 20160325 d00241380
           Non Absolutely condition: 高清输出必定大于标清输出; 该条件等价于缩放方向一致, 两级缩小
           example: 720x576-->600x480(HD)  需要从V0回写;
           Judgement condition is heifht of V0, not the height of VP
            */
        pstZmeOut->enVpPoint = HI_PQ_WBC_POINT_VP;
    }
    else
    {
        /* e.g.: 576i --> 576p --> 576i(Hdmi), 576i(Cvbs); 回写点在V0;
                 480i --> 480p --> 480i(Hdmi), 480i(Cvbs); 回写点在V0;
                           4k  -->  4k (Hdmi), 480i(Cvbs); 回写点在V0; */
        pstZmeOut->enVpPoint = HI_PQ_WBC_POINT_V0;
    }
    sg_enWbcPointSel = (ZME_WBC_POINT_SEL_E)pstZmeOut->enVpPoint;

    /* 计算WBC层的输入输出宽、高、帧/场 */
    /* Test: 比如退出播放时, Vo赋给标清的值可能是个默认值; 会不会导致切换制式时的宽高出错 */
    if (ZME_WBC_POINT_V0 == sg_enWbcPointSel)
    {
        u32InWidth         = stZmeIn.stLayerInfo[0].u32FrmWIn / (1 << (HI_U32)sg_enV0PreHScaler);
        u32InHeight        = stZmeIn.stLayerInfo[0].u32FrmHIn / (1 << (HI_U32)sg_enV0PreVScaler);
        u32OutWidth        = stZmeIn.stLayerInfo[1].u32FrmWOut; /* V3 FrmWOut */
        u32OutHeight       = stZmeIn.stLayerInfo[1].u32FrmHOut; /* V3 FrmHOut */

        bAPointProgressive = sg_bV0ReadFmtIn; /* V0 读入数据隔逐行 */
        if (2 == stZmeIn.stLayerInfo[0].u32FmtIn) /* pix format: 0-422; 1-420; 2-444 */
        {
            bAPointPixFmt = 0; /* pix format: 0-422; 1-420; 2-444 */
        }
        else
        {
            bAPointPixFmt = stZmeIn.stLayerInfo[0].u32FmtIn; /* V0 读入数据格式 */
        }
    }
    else if (ZME_WBC_POINT_VP == sg_enWbcPointSel)
    {
        /* 当绑定在VP上, 配给缩放的宽高应该是接口的宽高, 不是层的宽高; 否则PIP、预览无法回写全屏;
           Remark: 窗口宽高等于V0上实际宽高, 制式宽高等于VP上的宽高 */
        u32InWidth         = g_stPqStatus.stTimingInfo[HI_PQ_DISPLAY_1].stFmtRect.s32Width;
        u32InHeight        = g_stPqStatus.stTimingInfo[HI_PQ_DISPLAY_1].stFmtRect.s32Height;
        u32OutWidth        = g_stPqStatus.stTimingInfo[HI_PQ_DISPLAY_0].stFmtRect.s32Width;
        u32OutHeight       = g_stPqStatus.stTimingInfo[HI_PQ_DISPLAY_0].stFmtRect.s32Height;

        bAPointProgressive = g_stPqStatus.stTimingInfo[HI_PQ_DISPLAY_1].bProgressive; /* 输出接口隔逐行 */
        bAPointPixFmt      = 0; /* pix format: 0-422; 1-420; 2-444 */
    }
    pstZmeOut->bReadFmtIn = bAPointProgressive; /* Frame format for zme Intput: 0-field; 1-frame */

    /***
      WBC_VP回写数据的格式：本质上是根据HD接口和SD接口之间是否需要帧率转换来决定回写格式：
      (1) 如果HD帧率<SD帧率(如: HD输出1080P24，SD输出NTSC制式), 则WBC_VP回写帧数据;
          (以保证SD输出图像不会出现回退或上下抖动)
      (2) Else, WBC_VP回写场数据. 此种情况需要注意, HD输出60hz, 而SD输出NTSC(59.94hz)的情况,
          HD每隔16s比SD播放快一次, SD丢弃数据时要保证一次丢弃两场, 否则会出现极性反转的情况从而导致图像上下抖动;

      注意: HD-4KP30, SD-NTSC; HD-4KP25, SD-PAL; HD-1080P24, SD-NTSC; 需要V3按帧读数据, Vdp做场的重复适配接口输出;
      ***/
    if (HI_TRUE == stZmeIn.bForceWbcFieldMode) /* 强制回写场 */
    {
        pstZmeOut->stZme.bOutFmt = 0; /* Frame format for zme output: 0-field; 1-frame */
    }
    else if (g_stPqStatus.stTimingInfo[HI_PQ_DISPLAY_1].u32RefreshRate < g_stPqStatus.stTimingInfo[HI_PQ_DISPLAY_0].u32RefreshRate)
    {
        pstZmeOut->stZme.bOutFmt = 1;
    }
    else
    {
        pstZmeOut->stZme.bOutFmt = 0;
    }

    /* 缩放绑定位置: (1)同源模式, ZME绑定在WBC上; (2)非同源模式, ZME绑定在V3上; */
    if (HI_TRUE == g_stPqStatus.bIsogenyMode) /* 同源 */
    {
        pstZmeOut->eZmePosition = HI_PQ_ZME_BIND_WBC;
    }
    else
    {
        pstZmeOut->eZmePosition = HI_PQ_ZME_BIND_V3;
    }

    /***
       WBC_VP P2I的开启策略: (参考3798cv200 算法流程图)
       (1) 如果B点输出Progressive, 则P2I关闭;
       (2) 如果B点输出Interlace, 则分两种情况;
           A) 如果A点输入Interlace, 则P2I关闭;
           B) 如果A点输入Progressive, 则又分三种情况:
              a) 如果源resolution==目的resolution, 则P2I开启且需要匹配场极性;
              b) 如果垂直缩放比<THD'(如1/4, 此阈值需要测试后再确定), 则P2I开启(相当于两级缩小，为了提升大比例缩小的图像效果);
              c) Else, P2I关闭
      ***/
    if (HI_FALSE == g_stPqStatus.bIsogenyMode)
    {
        /* 非同源模式: ZME绑定在V3上, do not care B Point is Progressive or not */
        pstZmeOut->bOpenP2I = HI_FALSE;
    }
    else
    {
        /* 同源模式: ZME绑定在WBC上, 因为标清输出必须是Interlace, 则B点输出为 Interlace */
        if (HI_TRUE == pstZmeOut->stZme.bOutFmt) /* WBC输出是Progressive, 即B点Progressive */
        {
            pstZmeOut->bOpenP2I = HI_FALSE;
        }
        else if (HI_FALSE == bAPointProgressive) /* B点输出Interlace, A点输入Interlace */
        {
            pstZmeOut->bOpenP2I = HI_FALSE;
        }
        else if (HI_TRUE == bAPointProgressive)  /* B点输出Interlace, A点输入Progressive */
        {
            /* 1. 绝对条件: 即只在4K到Hscaler时, 才会开启,因此不需要在如下的判断条件中除以Hscaler.
               2. cvbs的输出固定是pal或ntsc, 符合如下条件的只有: 576p --> 576i; 480p --> 480i;
               */
            if ((u32OutWidth == u32InWidth) && (u32OutHeight == u32InHeight))
            {
                /* e.g.: 576i --> 576p --> 576i(Hdmi), 576i(Cvbs); 回写点在V0上, V0读场, 则A点为Interlace;   不进到该条件;
                         576i --> 576p --> 720p(Hdmi), 576i(Cvbs); 回写点在V0上, V0读帧, 则A点为Progressive; 进到该条件;
                         */
                pstZmeOut->bOpenP2I = HI_TRUE;
            }
            else if (u32InHeight > WBC_HSCALER_THD * u32OutHeight)
            {
                pstZmeOut->bOpenP2I = HI_TRUE;
            }
            else
            {
                pstZmeOut->bOpenP2I = HI_FALSE;
            }
        }
    }

    /* 98CV200 WBC HScaler的开关受缩放性能的限制, 当输入大于等于4K时打开; 后续芯片无法保证判断Hscaler开启的条件的一致性;
       策略中不涉及Hscaler的实现; PQ将Hsacaler + Scaler(WBC)看成一个完整的Scaler;
       Hsacler的策略由底层cbb自己做, 计算ratio配给zme的宽高, 同样在cbb消化;
       */
    if (u32InWidth >= DHD0_OUT_RESOLUTION_W_THD)
    {
        pstZmeOut->eHScalerMode = HI_PQ_PREZME_HOR_2X; /* 固定2抽1 */
    }
    else
    {
        pstZmeOut->eHScalerMode = HI_PQ_PREZME_HOR_DISABLE;
    }

    /* Scaler Info Calc */
    pstZmeOut->stZme.u32FrmInHeight  = u32InHeight;
    pstZmeOut->stZme.u32FrmInWidth   = u32InWidth; /* can not divide 2 */
    pstZmeOut->stZme.u32FrmOutWidth  = u32OutWidth;
    pstZmeOut->stZme.u32FrmOutHeight = u32OutHeight;
    pstZmeOut->stZme.u32PixInFmt     = bAPointPixFmt;
    pstZmeOut->stZme.u32PixOutFmt    = 0; /* 0-422; 1-420; 2-444; write back must be 422 */

    if (HI_TRUE == pstZmeOut->bOpenP2I)
    {
        pstZmeOut->stZme.bInFmt = 0; /* 0-field; 1-frame */
    }
    else
    {
        pstZmeOut->stZme.bInFmt = bAPointProgressive; /* e.g.: 576i -> 576p -> 576i(Hdmi), 576i(Cvbs); Write back from V0, V0 read field, A point is interlace */
    }

    /* config zme mode; when frame resolution does not have change, can not open fir mode; e.g: (480i-->480i) or (576i --> 576i); other must open fir mode; */
    pstZmeOut->bZmeFirHL = (pstZmeOut->stZme.u32FrmOutWidth  == pstZmeOut->stZme.u32FrmInWidth)  ? HI_FALSE : HI_TRUE;

    pstZmeOut->bZmeFirVL = (pstZmeOut->stZme.u32FrmOutHeight == pstZmeOut->stZme.u32FrmInHeight) ? HI_FALSE : HI_TRUE;
    /* in format may be 420(write back from v0) or must be 422(write back from vp0), out format must be 422; when 420 -> 422; vertical need up-sampling, but horizontal does not need */
    pstZmeOut->bZmeFirHC = (HI_FALSE == pstZmeOut->bZmeFirHL) ? HI_FALSE : HI_TRUE;
    pstZmeOut->bZmeFirVC = (HI_FALSE == pstZmeOut->bZmeFirVL) ? ((pstZmeOut->stZme.u32PixOutFmt == pstZmeOut->stZme.u32PixInFmt) ? HI_FALSE : HI_TRUE) : HI_TRUE;

    pstZmeOut->bZmeMedH  = HI_FALSE; /* zme Median filter enable of horizontal: 0-off; 1-on*/
    pstZmeOut->bZmeMedV  = HI_FALSE;

    if (HI_TRUE == sg_bVdpZmeDefault)
    {
        pstZmeOut->bZmeFirHL   = HI_FALSE;
        pstZmeOut->bZmeFirHC   = HI_FALSE;
        pstZmeOut->bZmeFirVL   = HI_FALSE;
        pstZmeOut->bZmeFirVC   = HI_FALSE;
        pstZmeOut->bZmeDefault = HI_TRUE; /* 1: rwzb */
    }
    else
    {
        pstZmeOut->bZmeDefault = HI_FALSE; /* 0: no rwzb */
    }

    pqprint(PQ_PRN_ZME, "OUT WIn:%d, HIn:%d, WOut:%d, HOut:%d\n", pstZmeOut->stZme.u32FrmInWidth, pstZmeOut->stZme.u32FrmInHeight,
            pstZmeOut->stZme.u32FrmOutWidth, pstZmeOut->stZme.u32FrmOutHeight);

    return HI_SUCCESS;
}

static HI_S32 PQ_HAL_GetWbcDhdZmeStrategy (HI_PQ_LAYER_STRATEGY_IN_S stZmeIn, HI_PQ_WBC_DHD0_STRATEGY_OUT_S* pstZmeOut)
{
    PQ_CHECK_NULL_PTR(pstZmeOut);

    /* 由于逻辑性能的限制, Hscaler固定抽行1/2; 与WBC_VP的Hscaler一致, PQ不做策略 */
    pstZmeOut->eHScalerMode = HI_PQ_PREZME_HOR_2X;

    pstZmeOut->bInWbcVpZmeFmt = g_stPqStatus.stTimingInfo[HI_PQ_DISPLAY_1].bProgressive; /* 固定叠加之后回写 */

    pstZmeOut->stZme.u32FrmInHeight  = stZmeIn.u32FrmHIn;
    pstZmeOut->stZme.u32FrmInWidth   = stZmeIn.u32FrmWIn; /* can not divide 2 */
    pstZmeOut->stZme.u32FrmOutWidth  = stZmeIn.u32FrmWOut;
    pstZmeOut->stZme.u32FrmOutHeight = stZmeIn.u32FrmHOut;
    /* Layer strategry: input 444, output 420 */
    pstZmeOut->stZme.u32PixInFmt     = 2; /* video format for zme : 0-422; 1-420; 2-444 */
    pstZmeOut->stZme.u32PixOutFmt    = 1; /* video format for zme : 0-422; 1-420; 2-444 */

    pstZmeOut->bZmeFirHL = HI_TRUE; /* 0-copy mode; 1-FIR filter mode*/

    pstZmeOut->bZmeFirVL = HI_TRUE;
    pstZmeOut->bZmeFirHC = HI_TRUE;
    pstZmeOut->bZmeFirVC = HI_TRUE;

    pstZmeOut->bZmeMedH  = HI_FALSE; /* zme Median filter enable of horizontal luma: 0-off; 1-on*/
    pstZmeOut->bZmeMedV  = HI_FALSE;

    return HI_SUCCESS;
}

HI_S32 PQ_HAL_GetVdpZmeStrategy (VDP_ZME_LAYER_E enLayerId, HI_PQ_ZME_STRATEGY_IN_U* pstZmeIn, HI_PQ_ZME_STRATEGY_OUT_U* pstZmeOut)
{
    HI_S32 s32Ret = HI_FAILURE;

    if (VDP_ZME_LAYER_V0 == enLayerId)
    {
        s32Ret = PQ_HAL_GetV0ZmeStrategy(pstZmeIn->stLayerStrategy, &(pstZmeOut->stStrategyLayerId));
    }
    else if (VDP_ZME_LAYER_V1 == enLayerId)
    {
        s32Ret = PQ_HAL_GetV1ZmeStrategy(pstZmeIn->stLayerStrategy, &(pstZmeOut->stStrategyLayerId));
    }
    else if (VDP_ZME_LAYER_WBC0 == enLayerId)
    {
        /*非同源场景VDP需要调用V3策略，不调用WBC策略 */
        s32Ret = PQ_HAL_GetWbcVpZmeStrategy(pstZmeIn->stWbcStrategy, &(pstZmeOut->stStrategyWbcVp));
    }
    else if (VDP_ZME_LAYER_WBC_DHD == enLayerId)
    {
        s32Ret = PQ_HAL_GetWbcDhdZmeStrategy(pstZmeIn->stLayerStrategy, &(pstZmeOut->stStrategyWbcDhd));
    }
    else
    {
        HI_ERR_PQ("LayerId:%d, unsupport zme strategy!\n", enLayerId);
    }

    return s32Ret;
}


