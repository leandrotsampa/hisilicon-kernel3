/******************************************************************************

  Copyright (C), 2012-2014, Hisilicon Tech. Co., Ltd.

******************************************************************************
  File Name     : pq_mng_db.c
  Version       : Initial Draft
  Author        :
  Created       :
  Description   : De-blocking and De-Ringning

******************************************************************************/
#include "hi_math.h"
#include "drv_pq_table.h"
#include "pq_mng_db.h"
#include "pq_mng_db_alg.h"
#include "pq_hal_algchange.h"

/* ----------add by z00214841 2015.7.20---------------- */
const static HI_U16 DbStr_Delta_LutUltraStrong[16] = {4, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 6, 2, 0};
const static HI_U16 DbStr_Delta_LutStrong[16]      = {4, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 6, 4, 2, 0, 0};
const static HI_U16 DbStr_Delta_LutMiddle[16]      = {4, 8, 8, 8, 8, 4, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0};
const static HI_U16 DbStr_Delta_LutWeak[16]        = {0, 2, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
const static HI_U16 DbStr_Delta_LutLumVer[16]      = {6, 8, 8, 8, 6, 4, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0};
const static HI_U16 DbStr_Delta_LutChroma[16]      = {8, 8, 8, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

const static HI_U16 ptrBlkVarCore[16]  = { 0,  3,  5,  8, 11, 13, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24}; /* texture Th */
const static HI_U16 ptrBlkVarGain1[16] = { 4,  4,  3,  3,  2,  2,  1,  1,  0,  0,  0, 0, 0, 0, 0, 0}; /* [0,8] */
const static HI_U16 ptrBlkVarGain2[16] = { 8,  8,  7,  7,  6,  6,  5,  5,  4,  4,  4, 4, 4, 4, 4, 4}; /* [0,8] */

const static HI_U16 g_DbSobelStrLut_H26X[26] = {16, 15, 14, 13, 12, 11, 10,  8,  6,  5,  5,  4,  4,  4,  4,  4, 2,   2,  1,  1,  0, 0, 0, 0, 0, 0};
const static HI_U16 g_DbSobelStrLut_MPEG[26] = {16, 15, 14, 13, 12, 12, 11, 10,  9,  7,  6,  5,  5,  4,  4,  4, 2,   2,  2,  2,  2, 2, 1, 0, 0, 0};

const static HI_U16 g_DbDirStrLut[16]      = {16, 14, 12, 10,  10,  8,  4,  2,  0,  0,  0,  0,  0,  0,  0,  0};
const static HI_U16 g_DbDirStrLut_Pro4[16] = {16, 16, 16, 16,  16,  16,  16,  12,  2,  2,  0,  0,  0,  0,  0,  0};
const static HI_U16 g_DbDirStrGainLut[10]  = {16, 14, 12, 10,   8,  6,  4,  2,  0,  0};

const static HI_U16 DiffMapLut_MPEG[8]    = {8, 12, 24, 28, 36, 40, 80, 120};
const static HI_U16 DiffStrLut_MPEG[7]    = {0, 8, 28, 32, 40, 44, 60};
const static HI_U16 DiffWeightLut_MPEG[6] = {480, 416, 224, 112, 224, 99};

const static HI_U16 DiffMapLut_H26X[8]    = { 4, 8, 20, 28, 36, 46, 80, 120};
const static HI_U16 DiffStrLut_H26X[7]    = { 0, 6, 32, 46, 52, 56, 60};
const static HI_U16 DiffWeightLut_H26X[6] = {352, 544, 432, 176, 90, 26};

const static HI_U16 BorderStrLutH_MPEG[17 * 8] =
    //  0   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15
{
    2,  4,  6,  8, 10, 12, 14, 15, 14, 12, 10,  8,  6,  4,  2,  0,//0
    2,  4,  6,  8, 10, 12, 14, 15, 14, 12, 10,  8,  6,  4,  2,
    2,  4,  6,  8, 10, 12, 14, 15, 13, 12, 10,  8,  6,  4,
    2,  4,  6,  8, 10, 12, 14, 14, 12, 12, 10,  8,  6,
    2,  4,  6,  8, 10, 12, 15, 15, 14, 12, 10,  8,
    2,  4,  6,  8, 10, 12, 14, 15, 14, 12, 10,//5
    2,  4,  6,  8, 10, 14, 15, 15, 14, 12,//6
    2,  4,  6,  8, 10, 12, 14, 14, 14,//7
    2,  4,  6,  8, 10, 12, 14, 15,//8
    2,  4,  6,  8, 10, 12, 14,//9
    2,  4,  6,  8, 10, 12,//10
    2,  4,  6,  8, 10,//11
    2,  4,  6,  8,//12
    2,  4,  6,//13
    2,  4,//14
    2//15
};

const static HI_U16 BorderStrLutV_MPEG[17 * 8] =
    //  0   1   2   3  4   5   6   7   8   9   10  11  12  13  14  15
{
    2,  4,  6,  8, 10, 12, 14, 12, 10, 8,  7,  6,  4,  3,  2,  0,//0
    2,  4,  6,  8, 10, 12, 14, 12, 10, 8,  7,  6,  5,  4,  2,
    2,  4,  6,  8, 10, 12, 14, 12, 10, 8,  7,  6,  5,  4,
    2,  4,  6,  8, 10, 12, 13, 11, 9,  8,  7,  6,  5,
    2,  4,  6,  8, 10, 12, 14, 12, 10, 8,  7,  6,
    2,  4,  6,  8, 10, 14, 12, 11, 8,  7,  6,//5
    2,  4,  6,  8, 12, 12, 12, 10, 7,  6,//6
    2,  4,  6,  8, 10, 10, 8,  6,  4,//7
    2,  4,  6,  8, 8,  6,  4,  2,//8
    2,  4,  6,  6, 4,  3,  2,//9
    2,  4,  4,  3, 2,  1,//10
    2,  2,  2,  1, 0,//11
    0,  1,  0,  0,//12
    0,  0,  0,//13
    0,  0,//14
    0//15
};

const static HI_U16 BorderStrLutH_H26X[17 * 8] =
    //  0   1   2   3   4   5   6   7   8   9   10  11  12  13  14  15
{
    4,  6,  10, 12, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15,//0
    4,  6,  10, 12, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15,
    4,  7,  10, 12, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15,
    6,  9,  14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15,
    7,  10, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15,
    7,  9,  12, 14, 15, 15, 15, 15, 12, 10, 8,//5
    8,  12, 14, 14, 15, 14, 12, 10, 8,  6,//6
    9,  12, 13, 14, 12, 10, 8,  6,  4,//7
    10, 12, 13, 10, 8,  6,  4,  2,//8
    9,  9,  8,  6,  4,  3,  2,//9
    7,  6,  5,  3,  2,  1,//10
    4,  4,  2,  1,  0,//11
    3,  1,  0,  0,//12
    0,  0,  0,//13
    0,  0,//14
    0//15
};

const static HI_U16 BorderStrLutV_H26X[17 * 8] =
    //  0   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15
{
    6,  8, 12, 14, 15, 15, 14, 12, 10,  8,  6,  4,  2,  0,  0,  0,//0
    6,  8, 12, 14, 15, 15, 14, 12, 10,  8,  6,  4,  2,  0,  0,
    6,  8, 12, 14, 15, 15, 14, 12, 10,  8,  6,  4,  2,  0,
    6,  8, 12, 14, 15, 15, 14, 12, 10,  8,  6,  4,  2,
    6,  8, 12, 14, 15, 15, 14, 12, 10,  8,  6,  4,
    6,  8, 12, 13, 15, 15, 14, 12, 10,  8,  6,//5
    6,  8, 10, 12, 14, 12, 10, 8,  6,   4,//6
    6,  8, 10, 12, 10, 9,  8,  6,  2,//7
    6,  8, 10, 8,  7,  6,  3,  0,//8
    6,  8, 7,  6,  5,  2,  0,//9
    4,  6, 5,  4,  2,  0,//10
    4,  4, 3,  1,  0,//11
    3,  3, 1,  0,//12
    2,  1, 0,//13
    1,  0,//14
    0//15
};

const static HI_U16 DbStrFadLut1[16]           = {16, 8, 0, 0, 0, 0, 0, 0, 0,  0, 0, 0, 0, 0, 0, 0 };  /* size 4 */
const static HI_U16 DbStrFadLut2[16]           = {16, 8, 4, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };   /* size 8 */
const static HI_U16 DbStrFadLut2_MPEG[16]      = {16, 16, 12, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }; /* size 8 */
const static HI_U16 DbStrFadLut2_MPEG_Pro4[16] = {16, 16, 12, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };/* size 8 */

//HI_U8 DbStrFadLut2_H26X_Pro4[16]             = {16, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };/* size 8 */
const static HI_U16 DbStrFadLut1_H26X_Pro4[16] = {8, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };/* size 4 */
const static HI_U16 DbStrFadLut2_H26X_Pro4[16] = {8, 4, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };/* size 8 */
const static HI_U16 DbStrFadLut3_H26X_Pro4[16] = {8, 4, 3, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };/* size 16 */
const static HI_U16 DbStrFadLut4_H26X_Pro4[16] = {8, 7, 6, 5, 4, 3, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0 };/* size 32 */

const static HI_U16 DbStrFadLut3[16]      = {16, 14, 12, 10, 8, 6, 4, 2, 0,  0,  0,  0, 0, 0, 0, 0 };      /* size 16 */
const static HI_U16 DbStrFadLut4[16]      = {16, 15, 14, 13, 12, 11, 10, 9, 7,  5,  3,  1,  0,  0,  0, 0 };/* size 32 */

const static HI_U16 DbStrFadLut1_H26x[16] = {16,  10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };/* size 4 */
const static HI_U16 DbStrFadLut2_H26x[16] = {16, 12, 8, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }; /* size 8 */

const static HI_U16 DbStrFadLutV_MPEG[16] = {16, 8, 8, 4, 0, 0, 0, 0, 0,  0, 0, 0, 0, 0, 0, 0 };/* only for org vertical */
const static HI_U16 DbStrFadLutV_H26X[16] = {16, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }; /* only for org vertical */


#define DB_SIZE_CLIP(x) ((x>0x3F)?(-1):(x))

HI_U32  g_u32DbStr = 8;

DB_DET_INFO_S     g_astDbDetInf[VPSS_HANDLE_NUM];
DB_API_REG_S      g_astDBValue[VPSS_HANDLE_NUM];
DB_DET_INFO_S     g_astDbDetInf_Out[VPSS_HANDLE_NUM];
DetStaticUsing_S  g_astDetUsingInf[VPSS_HANDLE_NUM];

static HI_BOOL        sg_bDBInitFlag   = HI_FALSE;
static HI_BOOL        sg_bDB_EnFlag;
static HI_BOOL        sg_bDB_Demo_EnFlag;
static HI_U32         sg_u32DBStrength = 50;
static PQ_DEMO_MODE_E sg_enMode        = PQ_DEMO_ENABLE_R;
static PQ_TUN_MODE_E  sg_enDBTunMode   = PQ_TUN_NORMAL;
static HI_U32         sg_u32PreGMotion[VPSS_HANDLE_NUM];


//const static HI_U8 DB_DELTA_LUM_VER[16]          = {6, 8, 8, 8, 8, 6, 4, 2, 0, 0, 0, 0, 0, 0, 0, 0}; /* LUMA_VER p0-p15 */
const static HI_U8 DB_DELTA_LUM_VER[16]            = {0, 6, 4, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}; /* LUMA_VER p0-p15 */
const static HI_U8 DB_DELTA_CHR_HOR[16]            = {8, 8, 8, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}; /* CHR_HOR  p0-p15 */
const static HI_U8 DB_DELTA_LUM_H_STRONG[16]       = {4, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 6, 4, 2, 0, 0}; /* LUMA_HOR p0-p15 */
const static HI_U8 DB_DELTA_LUM_H_ULTRA_STRONG[16] = {4, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 6, 2, 0}; /* LUMA_HOR p0-p15 */

/* 遗留问题: Fade强度调小，会不会影响水平方向的滤波强度 */
//const static HI_U8 DB_STR_FADE_LUM_VER[12] = {4, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}; /* LUMA_VER p0-p11 */
const static HI_U8 DB_STR_FADE_LUM_VER[12]   = {2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}; /* LUMA_VER p0-p11 */
const static HI_U8 DB_STR_FADE_LUT_1[12]     = {4, 4, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0};
const static HI_U8 DB_STR_FADE_LUT_2[12]     = {4, 4, 4, 4, 3, 3, 3, 0, 0, 0, 0, 0};
const static HI_U8 DB_STR_FADE_LUT_3[12]     = {4, 4, 4, 4, 4, 4, 4, 3, 3, 3, 3, 0};

const static HI_U8 DB_DIR_GAIN_LUT[8]    = {8, 5, 3, 1, 0, 0, 0, 0}; /* dir_str_gain_lut p0-p7 */
const static HI_U8 DB_DIR_LUT[16]        = {8, 8, 8, 8, 8, 8, 8, 6, 1, 1, 0, 0, 0, 0, 0, 0}; /* dir_str_lut p0-p15 */
const static HI_U8 RAT_INDEX_LUT[16]     = {0, 1, 2, 3, 4, 5, 5, 6, 6, 7, 8, 8, 8, 8, 8, 8};
const static DB_DynmcPara STRONG_PARAM   = {12, 0, 0, 0, 24, 0, 4, 7, 8};
const static DB_DynmcPara MID_PARAM      = {12, 0, 0, 0, 16, 0, 4, 7, 24};
const static DB_DynmcPara WEAK_PARAM     = {4, 0, 8, 8, 0, 4, 8, 7, 24};


HI_S32 PQ_MNG_SetDbTunMode(PQ_TUN_MODE_E enTunMode)
{
    sg_enDBTunMode = enTunMode;

    return HI_SUCCESS;
}

HI_S32 PQ_MNG_GetDbTunMode(PQ_TUN_MODE_E* penTunMode)
{
    *penTunMode = sg_enDBTunMode;

    return HI_SUCCESS;
}

/* 获取DB模块的初始参数值 */
static HI_S32 DB_Init_Value(DB_PARAM_S* pstDBValue)
{
    HI_U32 i = 0;

    PQ_CHECK_NULL_PTR(pstDBValue);

    /* set flag */
    sg_bDB_EnFlag      = HI_TRUE;
    sg_bDB_Demo_EnFlag = HI_FALSE;

    pstDBValue->bDBM_En          = 1;
    pstDBValue->u16DbmDemoEn     = 0;
    pstDBValue->u16DbmDemoMode   = 0;
    pstDBValue->u16DbmOutSelGain = 4;
    pstDBValue->u16DbmOutMode    = 5; //1;//3;

    //VPSS_DB_CTRL
    pstDBValue->u16Luma_en       = 1;
    pstDBValue->u16Luma_ver_en   = 1;
    pstDBValue->u16Luma_hor_en   = 1;
    pstDBValue->u16Db_cb_en      = 1;
    pstDBValue->u16Db_cr_en      = 1;
    pstDBValue->u16Db_chr_ver_en = 0; //此版本固定为0, 关闭DB的垂直色度的使能
    pstDBValue->u16Db_chr_hor_en = 1;
    pstDBValue->u16Db_chr_hor_mid_grey_en = 1;
    pstDBValue->u16Det_size_en   = 1;
    pstDBValue->u16Det_hy_en     = 1;
    pstDBValue->u16Det_hc_en     = 0; //根据api调节
    pstDBValue->u16Det_vy_en     = 1; //根据api调节

    //VPSS_DBD_THDEDGE
    pstDBValue->u16Hy_thd_edge  = 32;
    pstDBValue->u16Hc_thd_edge  = 32;
    pstDBValue->u16Vy_thd_edge  = 32;

    //VPSS_DBD_THDTXT
    pstDBValue->u16Hy_thd_txt   = 16;
    pstDBValue->u16Hc_thd_txt   = 16;
    pstDBValue->u16Vy_thd_txt   = 16;

    //VPSS_DBD_LUTWGT0
    pstDBValue->u16Det_lut_wgt0 = 0;
    pstDBValue->u16Det_lut_wgt1 = 0;
    pstDBValue->u16Det_lut_wgt2 = 1;
    pstDBValue->u16Det_lut_wgt3 = 2;
    pstDBValue->u16Det_lut_wgt4 = 5;
    pstDBValue->u16Det_lut_wgt5 = 7;
    pstDBValue->u16Det_lut_wgt6 = 10;
    pstDBValue->u16Det_lut_wgt7 = 12;

    //VPSS_DBD_LUTWGT1
    pstDBValue->u16Det_lut_wgt8  = 12;
    pstDBValue->u16Det_lut_wgt9  = 13;
    pstDBValue->u16Det_lut_wgt10 = 13;
    pstDBValue->u16Det_lut_wgt11 = 14;
    pstDBValue->u16Det_lut_wgt12 = 14;
    pstDBValue->u16Det_lut_wgt13 = 15;
    pstDBValue->u16Det_lut_wgt14 = 15;
    pstDBValue->u16Det_lut_wgt15 = 15;

    //VPSS_DBD_RTNBDTXT
    /* Debug: modify Hy 12 to 16 to 20 */
    pstDBValue->u16Hy_rtn_bd_txt = 20; //16;//12;
    pstDBValue->u16Hc_rtn_bd_txt = 16; //16;//12;
    pstDBValue->u16Vy_rtn_bd_txt = 16; //16;//12;

    //VPSS_DBD_TSTBLKNUM
    /* Debug: modify Vy 45 to 60 */
    pstDBValue->u16Hy_tst_blk_num = 90;
    pstDBValue->u16Hc_tst_blk_num = 45; //60;
    pstDBValue->u16Vy_tst_blk_num = 60; //45;

    //VPSS_DBD_HYRDX8BINLUT0
    pstDBValue->u16Hy_rdx8bin_lut0 = 16;
    pstDBValue->u16Hy_rdx8bin_lut1 = 48;

    //VPSS_DBD_HYRDX8BINLUT1
    pstDBValue->u16Hy_rdx8bin_lut2 = 80;
    pstDBValue->u16Hy_rdx8bin_lut3 = 112;

    //VPSS_DBD_HYRDX8BINLUT2
    pstDBValue->u16Hy_rdx8bin_lut4 = 144;
    pstDBValue->u16Hy_rdx8bin_lut5 = 176;

    //VPSS_DBD_HYRDX8BINLUT3
    pstDBValue->u16Hy_rdx8bin_lut6 = 208;

    //VPSS_DBD_HCRDX8BINLUT0
    pstDBValue->u16Hc_rdx8bin_lut0 = 16;
    pstDBValue->u16Hc_rdx8bin_lut1 = 48;

    //VPSS_DBD_HCRDX8BINLUT1
    pstDBValue->u16Hc_rdx8bin_lut2 = 80;
    pstDBValue->u16Hc_rdx8bin_lut3 = 112;

    //VPSS_DBD_HCRDX8BINLUT2
    pstDBValue->u16Hc_rdx8bin_lut4 = 144;
    pstDBValue->u16Hc_rdx8bin_lut5 = 176;

    //VPSS_DBD_HCRDX8BINLUT3
    pstDBValue->u16Hc_rdx8bin_lut6 = 208;

    //VPSS_DBD_VYRDX8BINLUT0
    pstDBValue->u16Vy_rdx8bin_lut0 = 16;
    pstDBValue->u16Vy_rdx8bin_lut1 = 48;

    //VPSS_DBD_VYRDX8BINLUT1
    pstDBValue->u16Vy_rdx8bin_lut2 = 80;
    pstDBValue->u16Vy_rdx8bin_lut3 = 112;

    //VPSS_DBD_VYRDX8BINLUT2
    pstDBValue->u16Vy_rdx8bin_lut4 = 144;
    pstDBValue->u16Vy_rdx8bin_lut5 = 176;

    //VPSS_DBD_VYRDX8BINLUT3
    pstDBValue->u16Vy_rdx8bin_lut6 = 208;

    //VPSS_DBD_BLKSIZE
    pstDBValue->u16Min_blk_size    = 4;  //6;
    pstDBValue->u16Hy_max_blk_size = 16; //需根据api调节
    pstDBValue->u16Hc_max_blk_size = 16; //需根据api调节
    pstDBValue->u16Vy_max_blk_size = 16; //需根据api调节

    //VPSS_DB_BORD_FLAG
    for (i = 0; i < 128; ++i)
    {
        pstDBValue->u32Vpss_db_bord_flag[i] = 0;
    }

    //VPSS_DB_DIR
    pstDBValue->u16Grad_sub_ratio = 24;
    pstDBValue->u16Ctrst_thresh   = 2;

    //VPSS_DB_BLK
    pstDBValue->u16Lum_h_blk_size = 8; //l_h_bs;
    pstDBValue->u16Lum_v_blk_size = 8; //l_v_bs;
    pstDBValue->u16Chr_h_blk_size = 8; //c_h_bs;
    pstDBValue->u16Chr_v_blk_size = 0;

    //VPSS_DB_RATIO
    pstDBValue->u16Lum_hor_scale_ratio   = 1;
    pstDBValue->u16Lum_ver_scale_ratio   = 1;
    pstDBValue->u16Chr_hor_scale_ratio   = 1; //(pstDBValue->u16Chr_h_blk_size + 7)/8;
    pstDBValue->u16Chr_ver_scale_ratio   = 0;
    pstDBValue->u16Lum_hor_filter_sel    = 1;
    pstDBValue->u16Chr_hor_filter_sel    = 1; //(pstDBValue->u16Lum_v_blk_size + 7)/8;
    pstDBValue->u16Glabal_db_strenth_lum = 8; //调整DB全局强度
    pstDBValue->u16Glabal_db_strenth_chr = 8; //调整DB全局强度
    pstDBValue->u16Lum_hor_txt_win_size  = 4;

    //VPSS_DB_LHHF
    pstDBValue->u16Lum_hor_hf_diff_core  = 0;
    pstDBValue->u16Lum_hor_hf_diff_gain1 = 0;
    pstDBValue->u16Lum_hor_hf_diff_gain2 = 0;
    pstDBValue->u16Lum_hor_hf_var_core   = 24;
    pstDBValue->u16Lum_hor_hf_var_gain1  = 0;
    pstDBValue->u16Lum_hor_hf_var_gain2  = 4;

    //VPSS_DB_LVHF
    pstDBValue->u16Lum_ver_hf_var_core   = 24;
    pstDBValue->u16Lum_hor_bord_adj_gain = 7;
    pstDBValue->u16Lum_hor_adj_gain      = 12;
    pstDBValue->u16Lum_ver_hf_var_gain1  = 0;
    pstDBValue->u16Lum_ver_hf_var_gain2  = 4;
    pstDBValue->u16Lum_ver_bord_adj_gain = 7;
    pstDBValue->u16Lum_ver_adj_gain      = 12;

    //VPSS_DB_CTRS
    pstDBValue->u16Ctrst_adj_core      = 0;
    pstDBValue->u16Dir_smooth_mode     = 2;
    pstDBValue->u16Ctrst_adj_gain1     = 0;
    pstDBValue->u16Ctrst_adj_gain2     = 8;
    pstDBValue->u16Max_lum_hor_db_dist = 4;
    pstDBValue->u16Max_chr_hor_db_dist = 4;

    pstDBValue->pu8Lum_hor_delta_lut  = DB_DELTA_LUM_H_STRONG; /* VPSS_DB_LUT0--VPSS_DB_LUT1 */
    pstDBValue->pu8Lum_ver_delta_lut  = DB_DELTA_LUM_VER;      /* VPSS_DB_LUT2--VPSS_DB_LUT3 */
    pstDBValue->pu8Chr_hor_delta_lut  = DB_DELTA_CHR_HOR;      /* VPSS_DB_LUT4--VPSS_DB_LUT5 */
    pstDBValue->pu8Lum_h_str_fade_lut = DB_STR_FADE_LUT_1;     /* VPSS_DB_LUT6--VPSS_DB_LUT9 */
    pstDBValue->pu8Lum_v_str_fade_lut = DB_STR_FADE_LUM_VER;   /* VPSS_DB_LUT7--VPSS_DB_LUT9 */
    pstDBValue->pu8Chr_h_str_fade_lut = DB_STR_FADE_LUT_1;     /* VPSS_DB_LUT8--VPSS_DB_LUT9 */
    pstDBValue->pu8Dir_str_gain_lut   = DB_DIR_GAIN_LUT;       /* VPSS_DB_LUT10 p0-p7        */
    pstDBValue->pu8Dir_str_lut        = DB_DIR_LUT;            /* VPSS_DB_LUT11-- VPSS_DB_LUT12*/

    return HI_SUCCESS;
}

/* Init DB, Vpss Handle ID = 0, Other Handle Init At Top Layer */
HI_S32 PQ_MNG_InitDB(PQ_PARAM_S* pstPqParam, HI_BOOL bDefault)
{
    HI_U32     u32HandleNo = 0;
    HI_S32     s32Ret;
    DB_PARAM_S stParamValueDB;

    if (HI_TRUE == sg_bDBInitFlag)
    {
        return HI_SUCCESS;
    }

    s32Ret = DB_Init_Value(&stParamValueDB);
    if (HI_SUCCESS != s32Ret)
    {
        HI_ERR_PQ("DB parameter init error!\n");
        return HI_FAILURE;
    }
    /*
        s32Ret = PQ_HAL_SetDBParamRegister(u32HandleNo, &stParamValueDB);
        if (HI_SUCCESS != s32Ret)
        {
            HI_ERR_PQ("Set DB register error!\n");
            return HI_FAILURE;
        }
    */
    s32Ret = PQ_MNG_InitPhyList(u32HandleNo, HI_PQ_MODULE_DB, SOURCE_MODE_NO, OUTPUT_MODE_NO);
    if (HI_SUCCESS != s32Ret)
    {
        HI_ERR_PQ("db InitPhyList error\n");
        return HI_FAILURE;
    }

    sg_bDBInitFlag = HI_TRUE;

    return HI_SUCCESS;
}

/* Deinit DB */
HI_S32 PQ_MNG_DeinitDB(HI_VOID)
{
    if (HI_FALSE == sg_bDBInitFlag)
    {
        return HI_SUCCESS;
    }

    sg_bDBInitFlag   = HI_FALSE;

    memset(sg_u32PreGMotion, 0, sizeof(sg_u32PreGMotion));

    return HI_SUCCESS;
}

/* 开关DB模块 */
HI_S32 PQ_MNG_EnableDB(HI_BOOL bOnOff)
{
    HI_U32  u32HandleNo = 0;
    HI_U32  u32Vid      = PQ_VDP_LAYER_VID0;
    HI_S32  s32Ret      = HI_SUCCESS;

    sg_bDB_EnFlag = bOnOff;

    if (REG_TYPE_VPSS == PQ_COMM_GetAlgTypeID(HI_PQ_MODULE_DB))
    {
        for (u32HandleNo = 0; u32HandleNo < VPSS_HANDLE_NUM; u32HandleNo++)
        {
            if (HI_TRUE == PQ_HAL_CheckVpssValid(u32HandleNo))
            {
                s32Ret = PQ_HAL_EnableDB(u32HandleNo, bOnOff);
            }
        }
    }
    else
    {
        s32Ret = PQ_HAL_EnableDB(u32Vid, bOnOff);
    }

    return s32Ret;
}

/* Get DB Enable state */
HI_S32 PQ_MNG_GetDBEnableFlag(HI_BOOL* pbOnOff)
{
    PQ_CHECK_NULL_PTR(pbOnOff);
    *pbOnOff = sg_bDB_EnFlag;

    return HI_SUCCESS;
}

/* u32Strength[0,100] */
HI_S32 PQ_MNG_SetDBStrength(HI_U32 u32Strength)
{
    sg_u32DBStrength = u32Strength;
    g_u32DbStr       = u32Strength * 15 / 100; /* 0~15; Low:4; Mid:8; High:12 */

    return HI_SUCCESS;
}

/* u32Strength[0,100] */
HI_S32 PQ_MNG_GetDBStrength(HI_U32* pu32Strength)
{
    *pu32Strength = sg_u32DBStrength; /* 0~100 */

    return HI_SUCCESS;
}

/* DB Demo Enable */
HI_S32 PQ_MNG_EnableDBDemo(HI_BOOL bOnOff)
{
    HI_U32 u32HandleNo = 0, u32Vid = PQ_VDP_LAYER_VID0;
    HI_S32 s32Ret = HI_SUCCESS;

    sg_bDB_Demo_EnFlag = bOnOff;

    if (REG_TYPE_VPSS == PQ_COMM_GetAlgTypeID(HI_PQ_MODULE_DB))
    {
        for (u32HandleNo = 0; u32HandleNo < VPSS_HANDLE_NUM; ++u32HandleNo)
        {
            if (HI_TRUE == PQ_HAL_CheckVpssValid(u32HandleNo))
            {
                s32Ret = PQ_HAL_EnableDBDemo(u32HandleNo, bOnOff);
            }
        }
    }
    else
    {
        s32Ret = PQ_HAL_EnableDBDemo(u32Vid, bOnOff);
    }

    return s32Ret;
}

/* Get DB Demo Enable Falg */
HI_S32 PQ_MNG_GetDBDemo(HI_BOOL* pbOnOff)
{
    PQ_CHECK_NULL_PTR(pbOnOff);
    *pbOnOff = sg_bDB_Demo_EnFlag;

    return HI_SUCCESS;
}

HI_S32 PQ_MNG_SetDbmDemoMode(PQ_DEMO_MODE_E enMode)
{
    HI_U32 u32HandleNo;
    HI_S32 s32Ret = HI_SUCCESS;

    sg_enMode = enMode;

    for (u32HandleNo = 0; u32HandleNo < VPSS_HANDLE_NUM; u32HandleNo++)
    {
        if (HI_TRUE == PQ_HAL_CheckVpssValid(u32HandleNo))
        {
            s32Ret = PQ_HAL_SetDbmDemoMode(u32HandleNo, (DBM_DEMO_MODE_E)enMode);
        }
    }

    return s32Ret;
}

HI_S32 PQ_MNG_GetDbmDemoMode(PQ_DEMO_MODE_E* penMode)
{
    PQ_CHECK_NULL_PTR(penMode);
    *penMode = sg_enMode;
    return HI_SUCCESS;
}


HI_S32 PQ_MNG_SetDbmDemoModeCoor (HI_U32 u32XPos)
{
    HI_S32 s32Ret = HI_SUCCESS;
    HI_U32 u32HandleNo;
    HI_U32 u32Vid = PQ_VDP_LAYER_VID0;

    if (REG_TYPE_VPSS == PQ_COMM_GetAlgTypeID(HI_PQ_MODULE_DB))
    {
        for (u32HandleNo = 0; u32HandleNo < VPSS_HANDLE_NUM; u32HandleNo++)
        {
            if (HI_TRUE == PQ_HAL_CheckVpssValid(u32HandleNo))
            {
                s32Ret = PQ_HAL_DBDemoPos(u32HandleNo, u32XPos);
            }
        }
    }
    else
    {
        s32Ret = PQ_HAL_DBDemoPos(u32Vid, u32XPos);
    }

    return s32Ret;
}


/* software alg  begin*/

static HI_S32 PQ_MNG_InitDbApi(HI_U32 u32HandleNo)
{
    g_astDetUsingInf[u32HandleNo].NumberWindow           = 6;
    g_astDetUsingInf[u32HandleNo].SaturatWindow          = 12;
    g_astDetUsingInf[u32HandleNo].HyMINBlkNum            = 10;
    g_astDetUsingInf[u32HandleNo].HchrMINBlkNum          = 10;
    g_astDetUsingInf[u32HandleNo].VyMINBlkNum            = 10;
    g_astDetUsingInf[u32HandleNo].UsingSizeHy            = -1;
    g_astDetUsingInf[u32HandleNo].UsingSizeHchr          = -1;
    g_astDetUsingInf[u32HandleNo].UsingSizeVy            = -1;
    g_astDetUsingInf[u32HandleNo].UsingHyCounterBorder   = 0;
    g_astDetUsingInf[u32HandleNo].UsingVyCounterBorder   = 0;
    g_astDetUsingInf[u32HandleNo].UsingHchrCounterBorder = 0;

    memset(g_astDetUsingInf[u32HandleNo].UsingBorderIndex, 0, sizeof( HI_U8 )* MAXLINESIZE);
    g_astDetUsingInf[u32HandleNo].ptrUsingHyBorderIndex   = g_astDetUsingInf[u32HandleNo].UsingBorderIndex;
    g_astDetUsingInf[u32HandleNo].ptrUsingHchrBorderIndex = g_astDetUsingInf[u32HandleNo].ptrUsingHyBorderIndex   + 1920;
    g_astDetUsingInf[u32HandleNo].ptrUsingVyBorderIndex   = g_astDetUsingInf[u32HandleNo].ptrUsingHchrBorderIndex + 960;
    g_astDetUsingInf[u32HandleNo].frms_NumsHy             = 0;
    g_astDetUsingInf[u32HandleNo].frms_NumsHchr           = 0;
    g_astDetUsingInf[u32HandleNo].frms_NumsVy             = 0;
    g_astDetUsingInf[u32HandleNo].keyfrm_num              = 4;
    g_astDetUsingInf[u32HandleNo].HyBordCountThreshold    = 15;
    g_astDetUsingInf[u32HandleNo].HchrBordCountThreshold  = 15;
    g_astDetUsingInf[u32HandleNo].VyBordCountThreshold    = 15;

    memset(g_astDetUsingInf[u32HandleNo].BorderCnt, 0, sizeof(HI_S8)*MAXLINESIZE);
    g_astDetUsingInf[u32HandleNo].ptrHyCnt          = g_astDetUsingInf[u32HandleNo].BorderCnt;
    g_astDetUsingInf[u32HandleNo].ptrHchrCnt        = g_astDetUsingInf[u32HandleNo].ptrHyCnt   + 1920;
    g_astDetUsingInf[u32HandleNo].ptrVyCnt          = g_astDetUsingInf[u32HandleNo].ptrHchrCnt + 960;
    g_astDetUsingInf[u32HandleNo].frmsCntTempHy     = 0;
    g_astDetUsingInf[u32HandleNo].frmsCntTempHchr   = 0;
    g_astDetUsingInf[u32HandleNo].frmsCntTempVy     = 0;

    g_astDetUsingInf[u32HandleNo].frmsWindowTemp    = 4;
    g_astDetUsingInf[u32HandleNo].frmsSatWindowTemp = 8;

    return HI_SUCCESS;
}

static HI_S32 PQ_MNG_DB_API_Init(HI_U32 u32HandleNo, HI_U32 u32Height, HI_U32 u32Width, HI_U32 u32FRate)
{
    if (u32HandleNo >= VPSS_HANDLE_NUM)
    {
        HI_ERR_PQ("u32HandleNo :%d\n", u32HandleNo);
        return HI_FAILURE;
    }

    g_astDbDetInf[u32HandleNo].s32LumWidth  = u32Width;
    g_astDbDetInf[u32HandleNo].s32LumHeight = u32Height;
    g_astDbDetInf[u32HandleNo].s32ChrWidth  = u32Width / 2;
    g_astDbDetInf[u32HandleNo].s32ChrHeight = u32Height / 2;
    PQ_HAL_GetDBDetEnReg(u32HandleNo, &(g_astDbDetInf[u32HandleNo].det_size_en), &(g_astDbDetInf[u32HandleNo].det_hy_en),
                         &(g_astDbDetInf[u32HandleNo].det_hc_en), &(g_astDbDetInf[u32HandleNo].det_vy_en));

    if (u32Height >= 2160 && u32Width >= 3840 && u32FRate >= 60)
    {
        //g_astDbDetInf[u32HandleNo].det_size_en = 0;
    }
#if 0
    g_astDbDetInf[u32HandleNo].det_size_en = g_astDBValue.det_size_en;
    g_astDbDetInf[u32HandleNo].det_hy_en   = g_astDBValue.det_hy_en;
    g_astDbDetInf[u32HandleNo].det_hc_en   = g_astDBValue.det_hc_en;
    g_astDbDetInf[u32HandleNo].det_vy_en   = g_astDBValue.det_vy_en;
#endif

    return PQ_MNG_InitDbApi(u32HandleNo);
}


/* DB API Init; refresh when timing change */
HI_S32 PQ_MNG_DBCfgRefresh(HI_U32 u32HandleNo, HI_U32 u32Height, HI_U32 u32Width, HI_U32 u32FRate)
{
    PQ_MNG_DB_API_Init(u32HandleNo, u32Height, u32Width, u32FRate);

    return HI_SUCCESS;
}

static HI_S32 PQ_MNG_GetDbSttInfo(DB_DET_INFO_S* pDBDetInput, HI_PQ_DB_CALC_INFO_S* pstDbCalcInfo)
{
    int i = 0;

    PQ_CHECK_NULL_PTR(pstDbCalcInfo);
    PQ_CHECK_NULL_PTR(pstDbCalcInfo->pstVPSSWbcReg);

    pDBDetInput->hy_counter = pstDbCalcInfo->pstVPSSWbcReg->DB_HY_SIZE.bits.hy_counter;
    pDBDetInput->hy_size    = DB_SIZE_CLIP( pstDbCalcInfo->pstVPSSWbcReg->DB_HY_SIZE.bits.hy_size );
    pDBDetInput->vy_counter = pstDbCalcInfo->pstVPSSWbcReg->DB_VY_SIZE.bits.vy_counter;
    pDBDetInput->vy_size    = DB_SIZE_CLIP( pstDbCalcInfo->pstVPSSWbcReg->DB_VY_SIZE.bits.vy_size );
    pDBDetInput->hc_counter = pstDbCalcInfo->pstVPSSWbcReg->DB_HC_SIZE.bits.hc_counter;
    pDBDetInput->hc_size    = DB_SIZE_CLIP( pstDbCalcInfo->pstVPSSWbcReg->DB_HC_SIZE.bits.hc_size );

    //("addr:%#x,%d,%d,%d,%d,%d,%d\n", (HI_U32)pstDbCalcInfo->pstVPSSWbcReg, pDBDetInput->hy_counter, pDBDetInput->hy_size,
    //       pDBDetInput->vy_counter, pDBDetInput->vy_size, pDBDetInput->hc_counter,
    //       pDBDetInput->hc_size);
    PQ_HAL_GetDBDetEnReg(pstDbCalcInfo->u32HandleNo, &(pDBDetInput->det_size_en), &(pDBDetInput->det_hy_en),
                         &(pDBDetInput->det_hc_en), &(pDBDetInput->det_vy_en));

    for (i = 0; i < 128; i++)
    {
        pDBDetInput->db_border[i] = pstDbCalcInfo->pstVPSSWbcReg->DB_BORDER[i].u32;
    }

    for (i = 0; i < 1920; i++)
    {
        pDBDetInput->db_hy_counter[i] = pstDbCalcInfo->pstVPSSWbcReg->DB_HY_COUNTER[i].u32;
    }

    return HI_SUCCESS;
}

static HI_S32 PQ_MNG_DBCfgFilter(DB_API_REG_S* pInput, DB_DET_INFO_S* p_Inf, DB_CALC_INFO_S* pstDbCalcInfo)
{
    /*
    HI_S32 u32W;
    HI_S32 DetBlkNum = 0;
    */
    HI_U32 u32HandleNo  = pstDbCalcInfo->u32HandleNo;
    HI_U8  DetRatioLumH = 0, DetRatioLumV = 0, tempAvgDetRatioLumH = 0, tempAvgDetRatioLumV = 0, tempDiffDetRatioLumH = 0, tempDiffDetRatioLumV = 0;
    HI_U16 StrIdxLumH   = 0, StrIdxLumV   = 0;
    /* move  m00290082 */
    //HI_U8 RatIdxLut[16]      = {0, 1, 2, 3, 4, 5, 5, 6, 6, 7, 8, 8, 8, 8, 8, 8};
    //HI_U8 ptrGradSubRatio[9] = {32, 28, 24, 24, 24, 24, 24, 16, 8};

    HI_U8 RatIdxLut[16]       = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15}; //change by m00290082
    HI_U8 ptrGradSubRatio[16] = {34, 33, 32, 31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 16, 8}; //change by m00290082 later maybe changed by img quality

    HI_U16 tempCnt = 0, curCnt = 0;
    HI_U8  tempDiffDetRatioLumHLut[16] = {0, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2};
    HI_U8  tempDiffDetRatioLumVLut[16] = {0, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2};
    /*
        HI_U8 DBTextAdpGain1 = 8;
        HI_U8 DBTextAdpGain2 = 4;
    */
    DB_REG_S* pReg = &(pInput->stDbRegs);

    //u32W = pInf->u32W;
    pReg->u8DBLumHorTrue = HI_FALSE;
    pReg->u8DBLumVerTrue = HI_FALSE;


    pReg->DBTextStrGain      = 10;//pDbCfg->u32TextStrGain;
    /* set default value */
    pReg->u8DBGradSubRatio   = 32;
    pReg->u8DBCtrstThresh    = 2;
    pReg->u16DBDirSmoothMode = 3;

    pReg->u32DBYWidth   = pstDbCalcInfo->u32Width;
    pReg->u32DBYHeight  = pstDbCalcInfo->u32Height;
    pReg->u32DBBitDepth = pstDbCalcInfo->u32BitDepth;

    pReg->DB_DET_EN   = pstDbCalcInfo->bDbFltDetModeEn;
    pReg->bBlkPosMode = pstDbCalcInfo->bDbBlkPosModeEn;
    pReg->DBprotocol  = pstDbCalcInfo->u32Protocol;

    pReg->TLXOffset = pstDbCalcInfo->u32LeftOffset;
    pReg->TLYOffset = pstDbCalcInfo->u32TopOffset;
    pReg->BRXOffset = pstDbCalcInfo->u32RightOffset;
    pReg->BRYOffset = pstDbCalcInfo->u32BottomOffset;

    pReg->u8DBLumHorEn = (pstDbCalcInfo->bDBLumHorEn == HI_TRUE) ? 1 : 0;
    pReg->u8DBLumVerEn = (pstDbCalcInfo->bDBLumVerEn == HI_TRUE) ? 1 : 0;

    pReg->u8DBLumHorTrue = HI_FALSE;
    pReg->u8DBLumVerTrue = HI_FALSE;

    p_Inf->DbDetBlkNumWindow = 3;

    PQ_HAL_SetReg_Dir_Str_Gain_Lut (u32HandleNo, g_DbDirStrGainLut);
    PQ_HAL_SetReg_Dir_Str_Lut      (u32HandleNo, g_DbDirStrLut);
    PQ_HAL_SetReg_Lum_Hor_Fade_Lut1(u32HandleNo, DbStrFadLut1);
    PQ_HAL_SetReg_Lum_Hor_Fade_Lut3(u32HandleNo, DbStrFadLut3);
    PQ_HAL_SetReg_Lum_Hor_Fade_Lut4(u32HandleNo, DbStrFadLut4);
    /*
    memcpy(pReg->u8DBDirStrGainLut,   g_DbDirStrGainLut, 10 * sizeof(HI_U8));
    memcpy(pReg->u8DBDirStrLut,       g_DbDirStrLut,     16 * sizeof(HI_U8));
    memcpy(pReg->u8DBLumHStrFadeLut1, DbStrFadLut1,      2  * sizeof(HI_U8));
    memcpy(pReg->u8DBLumHStrFadeLut3, DbStrFadLut3,      8  * sizeof(HI_U8));
    memcpy(pReg->u8DBLumHStrFadeLut4, DbStrFadLut4,      12 * sizeof(HI_U8));
    */
    if ((pReg->DBprotocol == 0 || pReg->DBprotocol == 1 || pReg->DBprotocol == 3) && (pReg->bBlkPosMode == HI_TRUE))
    {
        PQ_HAL_SetReg_Lum_Hor_Fade_Lut1(u32HandleNo, DbStrFadLut1_H26X_Pro4);
        PQ_HAL_SetReg_Lum_Hor_Fade_Lut2(u32HandleNo, DbStrFadLut2_H26X_Pro4);
        PQ_HAL_SetReg_Lum_Hor_Fade_Lut3(u32HandleNo, DbStrFadLut3_H26X_Pro4);
        PQ_HAL_SetReg_Lum_Hor_Fade_Lut4(u32HandleNo, DbStrFadLut4_H26X_Pro4);
        /*
        memcpy(pReg->u8DBLumHStrFadeLut1, DbStrFadLut1_H26X_Pro4, 2  * sizeof(HI_U8));
        memcpy(pReg->u8DBLumHStrFadeLut2, DbStrFadLut2_H26X_Pro4, 4  * sizeof(HI_U8));
        memcpy(pReg->u8DBLumHStrFadeLut3, DbStrFadLut3_H26X_Pro4, 8  * sizeof(HI_U8));
        memcpy(pReg->u8DBLumHStrFadeLut4, DbStrFadLut4_H26X_Pro4, 12 * sizeof(HI_U8));
        */
    }

    //if (pReg->DBprotocol == 2 || pReg->DBprotocol == 4)
    if (pReg->DBprotocol == 2 || pReg->DBprotocol == 4 || pReg->DBprotocol == 0 || pReg->DBprotocol == 1 || pReg->DBprotocol == 3) //to be match with zll result, match, but later can be change
    {
        PQ_HAL_SetReg_Diff_Map_Lut(u32HandleNo,       DiffMapLut_MPEG);
        PQ_HAL_SetReg_Diff_Str_Lut(u32HandleNo,       DiffStrLut_MPEG);
        PQ_HAL_SetReg_Diff_Weight_Lut(u32HandleNo,    DiffWeightLut_MPEG);
        PQ_HAL_SetReg_Sobel_Str_Lut(u32HandleNo,      g_DbSobelStrLut_MPEG);
        PQ_HAL_SetReg_Lum_V_Str_Fade_Lut(u32HandleNo, DbStrFadLutV_MPEG);
        /*
        memcpy(pReg->u16DBDiffMpaLut,    DiffMapLut_MPEG,      8  * sizeof(HI_U16));
        memcpy(pReg->u8DBDiffStrLut,     DiffStrLut_MPEG,      7  * sizeof(HI_U8));
        memcpy(pReg->u16DBDiffWeightLut, DiffWeightLut_MPEG,   6  * sizeof(HI_U16));
        memcpy(pReg->u8DBSobelStrLut,    g_DbSobelStrLut_MPEG, 26 * sizeof(HI_U8));
        memcpy(pReg->u8DBLumVStrFadeLut, DbStrFadLutV_MPEG,    2  * sizeof(HI_U8));

        //memcpy(pReg->u8DBLumHStrFadeLut2, DbStrFadLut2_MPEG, 4 * sizeof(HI_U8));
        */
        pReg->DBLumHBorderStrTh = 32; /* 16 or 32 */
        pReg->DBLumVBorderStrTh = 16;
    }
    else
    {
        PQ_HAL_SetReg_Diff_Map_Lut      (u32HandleNo, DiffMapLut_H26X);
        PQ_HAL_SetReg_Diff_Str_Lut      (u32HandleNo, DiffStrLut_H26X);
        PQ_HAL_SetReg_Diff_Weight_Lut   (u32HandleNo, DiffWeightLut_H26X);
        PQ_HAL_SetReg_Sobel_Str_Lut     (u32HandleNo, g_DbSobelStrLut_H26X);
        PQ_HAL_SetReg_Lum_V_Str_Fade_Lut(u32HandleNo, DbStrFadLutV_H26X);
        /*
        memcpy(pReg->u16DBDiffMpaLut,    DiffMapLut_H26X,      8  * sizeof(HI_U16));
        memcpy(pReg->u8DBDiffStrLut,     DiffStrLut_H26X,      7  * sizeof(HI_U8));
        memcpy(pReg->u16DBDiffWeightLut, DiffWeightLut_H26X,   6  * sizeof(HI_U16));
        memcpy(pReg->u8DBSobelStrLut,    g_DbSobelStrLut_H26X, 26 * sizeof(HI_U8));
        memcpy(pReg->u8DBLumVStrFadeLut, DbStrFadLutV_H26X,    2  * sizeof(HI_U8));
        */
        pReg->DBLumHBorderStrTh = 16;
        pReg->DBLumVBorderStrTh = 16;
    }
    if ( pReg->u32DBYWidth >= 1920 )
    {
        PQ_HAL_SetReg_Lum_Hor_Fade_Lut2(u32HandleNo, DbStrFadLut2_H26X_Pro4);
        //memcpy(pReg->u8DBLumHStrFadeLut2, DbStrFadLut2_H26X_Pro4, 4 * sizeof(HI_U8));
    }
    else
    {
        PQ_HAL_SetReg_Lum_Hor_Fade_Lut2(u32HandleNo, DbStrFadLut2_MPEG_Pro4);
        //memcpy(pReg->u8DBLumHStrFadeLut2, DbStrFadLut2_MPEG_Pro4, 4 * sizeof(HI_U8));
    }
    PQ_HAL_SetReg_Dir_Str_Lut(u32HandleNo, g_DbDirStrLut_Pro4);
    //memcpy(pReg->u8DBDirStrLut, g_DbDirStrLut_Pro4, 16 * sizeof(HI_U8));

    pReg->u8GlobalDbStrengthLum = g_u32DbStr;
    if (pReg->DB_DET_EN == 1)
    {
        if (p_Inf->hy_size >= 4)
        {
            //DetBlkNum  = DB_CountBorderNum(pReg->pLumHorBordFlag, pReg->DBYWidth) + 1;
            DetRatioLumH = DBM_CLIP3(0, 15, 16 * p_Inf->hy_counter / p_Inf->s32LumHBlkNum);
        }
        else
        {
            DetRatioLumH = 0;
        }
        if (p_Inf->vy_size >= 4)
        {
            //DetBlkNum  = DB_CountBorderNum(pReg->pLumVerBordFlag, pReg->DBYHeight) + 1;
            DetRatioLumV = DBM_CLIP3(0, 15, 16 * p_Inf->vy_counter / p_Inf->s32LumVBlkNum);
        }
        else
        {
            DetRatioLumV = 0;
        }

        //if (pDbCfg->s32DbSmoothDetNumEn == 1) /* open smooth */
        {
            curCnt = p_Inf->DbFrmCnt;
            if (curCnt < p_Inf->DbDetBlkNumWindow)
            {
                p_Inf->DBTempDetBlkRatioH[curCnt] = DetRatioLumH;
                p_Inf->DBTempDetBlkRatioV[curCnt] = DetRatioLumV;
                p_Inf->DbFrmCnt++;
            }
            else
            {
                for (tempCnt = 0; tempCnt < p_Inf->DbDetBlkNumWindow; tempCnt++)
                {
                    tempAvgDetRatioLumH += p_Inf->DBTempDetBlkRatioH[tempCnt];
                    tempAvgDetRatioLumV += p_Inf->DBTempDetBlkRatioV[tempCnt];
                }
                tempAvgDetRatioLumH  = tempAvgDetRatioLumH / (p_Inf->DbDetBlkNumWindow);
                tempDiffDetRatioLumH = ABS(DetRatioLumH - tempAvgDetRatioLumH);
                tempDiffDetRatioLumH = tempDiffDetRatioLumHLut[tempDiffDetRatioLumH];

                tempAvgDetRatioLumV  = tempAvgDetRatioLumV / (p_Inf->DbDetBlkNumWindow);
                tempDiffDetRatioLumV = ABS(DetRatioLumV - tempAvgDetRatioLumV);
                tempDiffDetRatioLumV = tempDiffDetRatioLumVLut[tempDiffDetRatioLumV];

                if (DetRatioLumH > tempAvgDetRatioLumH)
                {
                    DetRatioLumH = DBM_CLIP3(0, DetRatioLumH, tempAvgDetRatioLumH + tempDiffDetRatioLumH);
                }
                else
                {
                    DetRatioLumH = DBM_CLIP3(DetRatioLumH, tempAvgDetRatioLumH, tempAvgDetRatioLumH - tempDiffDetRatioLumH);
                }

                if (DetRatioLumV > tempAvgDetRatioLumV)
                {
                    DetRatioLumV = DBM_CLIP3(0, DetRatioLumV, tempAvgDetRatioLumV + tempDiffDetRatioLumV);
                }
                else
                {
                    DetRatioLumV = DBM_CLIP3(DetRatioLumV, tempAvgDetRatioLumV, tempAvgDetRatioLumV - tempDiffDetRatioLumV);
                }


                for (tempCnt = 0; tempCnt < p_Inf->DbDetBlkNumWindow - 1; tempCnt++)
                {
                    p_Inf->DBTempDetBlkRatioH[tempCnt] = p_Inf->DBTempDetBlkRatioH[tempCnt + 1];
                    p_Inf->DBTempDetBlkRatioV[tempCnt] = p_Inf->DBTempDetBlkRatioV[tempCnt + 1];
                }
                p_Inf->DBTempDetBlkRatioH[p_Inf->DbDetBlkNumWindow - 1] = DetRatioLumH;
                p_Inf->DBTempDetBlkRatioV[p_Inf->DbDetBlkNumWindow - 1] = DetRatioLumV;
            }
        }
        if (p_Inf->hy_size >= 4)
        {
            if (DetRatioLumH > 15)
            {
                return HI_FAILURE;
            }

            StrIdxLumH = RatIdxLut[DetRatioLumH];/* m00290082 stridx change from 0~8 to 0~15 */
            if (p_Inf->vy_size >= 4)
            {
                /* m00290082 */
                //StrIdxLumV = DBM_CLIP3(0, 8, RatIdxLut[DetRatioLumV] * StrIdxLumH / 8);
                StrIdxLumV   = DBM_CLIP3(0, 8, RatIdxLut[DetRatioLumV] * StrIdxLumH / 16);
            }
        }
        else
        {
            StrIdxLumH = 0;
            StrIdxLumV = 0;
        }

        pReg->DBDetectRatioH = DetRatioLumH;
        pReg->DBDetectRatioV = DetRatioLumV;
    }

    if (pReg->u8DBLumHorEn) /* in cfg open lumhoren */
    {
        /* Debug: Modify Lum Hor Init */
        pReg->u8DBLumHorTrue = pReg->u8DBLumHorEn && HI_TRUE;/* true used in filter, even lumhoren = 1 when det no block true will turn to false */
        //pReg->u8DBLumHorTrue = HI_FALSE; /* true used in filter, even lumhoren = 1 when det no block true will turn to false */

        if (pReg->DB_DET_EN == 1) /* open detect */
        {
            if (p_Inf->hy_size < 4)
            {
                pReg->u8DBLumHorTrue = HI_FALSE;
            }

            /* Debug: Modify Lum Hor Init */
            /*
            if (p_Inf->hy_size > 4)
            {
                pReg->u8DBLumHorTrue = HI_TRUE;
            }
            */
            else /* size >= 4 */
            {
                if (p_Inf->hy_size <= 8)
                {
                    PQ_HAL_SetReg_Hor_Delta_Lut(u32HandleNo, DbStr_Delta_LutStrong);
                    //memcpy(pReg->u8DBLumHorDeltaLut, DbStr_Delta_LutStrong, 16 * sizeof(HI_U8));
                }
                else
                {
                    PQ_HAL_SetReg_Hor_Delta_Lut(u32HandleNo, DbStr_Delta_LutUltraStrong);
                    //memcpy(pReg->u8DBLumHorDeltaLut, DbStr_Delta_LutUltraStrong, 16 * sizeof(HI_U8));
                }
                pReg->u16LumHorVarCore = ptrBlkVarCore[StrIdxLumH];/* m00290082  BlkVarCore should change with StridxLumH */
                pReg->u16LumHorGain1   = ptrBlkVarGain1[StrIdxLumH];
                pReg->u16LumHorGain2   = ptrBlkVarGain2[StrIdxLumH];
                pReg->u8DBGradSubRatio = ptrGradSubRatio[StrIdxLumH];
            }
        }
    }
    else
    {
        pReg->u8DBLumHorTrue = HI_FALSE;
    }

    /* vy */
    if (pReg->u8DBLumVerEn)
    {
        /* Debug: Modify Lum Ver Init */
        pReg->u8DBLumVerTrue = pReg->u8DBLumVerEn && HI_TRUE;
        //pReg->u8DBLumVerTrue = HI_FALSE;
        if (pReg->DB_DET_EN == 1)
        {
            PQ_HAL_SetReg_Ver_Delta_Lut(u32HandleNo, DbStr_Delta_LutLumVer);
            //memcpy(pReg->u8DBLumVerDeltaLut, DbStr_Delta_LutLumVer, 16 * sizeof(HI_U8));
            if (p_Inf->hy_size < 4)
            {
                pReg->u8DBLumVerTrue = HI_FALSE;
            }
            /* Debug: Modify Lum Ver Init */
            /*
            if (p_Inf->hy_size > 4)
            {
                pReg->u8DBLumVerTrue = HI_TRUE;
            }
            */
        }
    }
    else
    {
        pReg->u8DBLumVerTrue = HI_FALSE;
    }

    //if (pReg->DBBitDepth == 10)
    {
        pReg->u8DBCtrstThresh  <<= 2;
        pReg->u16LumHorVarCore <<= 2;
    }

    /* total switch */
    pReg->u8DBLumTrue = (pReg->u8DBLumHorTrue || pReg->u8DBLumVerTrue);
    pReg->u8DBLumTrue = pReg->u8DBEn && pReg->u8DBLumTrue;

    return HI_SUCCESS;

#if 0
    //HI_U32 u32FilterStrength;
    HI_S32 StrIdxLumH = 0, StrIdxLumV = 0, StrIdxChr = 0;

    pInput->db_lum_en              = HI_TRUE;
    pInput->db_cb_en               = HI_TRUE;
    pInput->db_cr_en               = HI_TRUE;
    pInput->db_chr_hor_mid_grey_en = HI_TRUE;
    pInput->db_chr_ver_en          = HI_FALSE;
    pInput->chr_v_blk_size         = 0;
    /* config direction detect para */
    pInput->grad_sub_ratio         = 24;

    if (p_Inf->s32LumWidth > 1920 || p_Inf->s32LumHeight > 1080)
    {
        pInput->db_lum_ver_en = 0;
        pInput->db_cb_en      = 0;
        pInput->db_cr_en      = 0;
        pInput->db_chr_hor_en = 0;
    }

    /* if size changed, the paras should been updated */
    StrIdxLumH = DB_UpdateLumHorPara(pInput, p_Inf, u32HandleNo);
    /* add u32HandleNo d00241380 */
    //StrIdxLumV = DB_UpdateLumVerPara(pInput, p_Inf, StrIdxLumH);
    StrIdxLumV = DB_UpdateLumVerPara(pInput, p_Inf, StrIdxLumH, u32HandleNo);
    StrIdxChr  = DB_UpdateChrHorPara(pInput, p_Inf, StrIdxLumH, u32HandleNo);
#if 0
    /* Distinguish That exist Scaler or not; set golbal strength */
    if (pInput->lum_hor_scale_ratio > 1)
    {
        /* scaled image use weaker filter */
        u32FilterStrength               = 6 * 15;
        //pInput->glabal_db_strenth_lum = 6;
        //pInput->glabal_db_strenth_chr = 6;
    }
    else
    {
        /* original image use normal filter */
        u32FilterStrength               = 8 * 15;
        //pInput->glabal_db_strenth_lum = 8;
        //pInput->glabal_db_strenth_chr = 8;
    }
    PQ_MNG_SetDBStrength(u32FilterStrength);
#endif
#endif
    return HI_SUCCESS;
}

static HI_S32 PQ_MNG_DBCfg(DB_API_REG_S* pInput, DB_DET_INFO_S* p_Inf, DetStaticUsing_S* pDetUsing_info, HI_PQ_DB_CALC_INFO_S* pstDbCalcInfo)
{
    PQ_MNG_ALG_DBCfgDetector(pInput, p_Inf, pDetUsing_info);

    PQ_MNG_DBCfgFilter(pInput, p_Inf, (DB_CALC_INFO_S*)pstDbCalcInfo);

    return HI_SUCCESS;
}

/* refresh every frame */
HI_S32 PQ_MNG_DBCalcConfigCfg(HI_PQ_DB_CALC_INFO_S* pstDbCalcInfo)
{
    PQ_CHECK_NULL_PTR(pstDbCalcInfo);
    /* read reg value from VPSS WBC stt, tranfer to g_astDbDetInf */
    PQ_MNG_GetDbSttInfo(&g_astDbDetInf[pstDbCalcInfo->u32HandleNo], pstDbCalcInfo);

    /* Calc counter and size, Update result */
    PQ_MNG_ALG_GetDbDetInfo(&g_astDbDetInf_Out[pstDbCalcInfo->u32HandleNo], &g_astDetUsingInf[pstDbCalcInfo->u32HandleNo], &g_astDbDetInf[pstDbCalcInfo->u32HandleNo]);

    /* 配置VDH block info 信息 */
    PQ_MNG_ALG_VDHTransinfoUpdata(&g_astDBValue[pstDbCalcInfo->u32HandleNo], (DB_CALC_INFO_S*)pstDbCalcInfo);

    /* Calc to detection and filter */
    PQ_MNG_DBCfg(&g_astDBValue[pstDbCalcInfo->u32HandleNo], &g_astDbDetInf_Out[pstDbCalcInfo->u32HandleNo], &g_astDetUsingInf[pstDbCalcInfo->u32HandleNo], pstDbCalcInfo);

    /* DB detect and filter para Info Set to Reg After Calc */
    PQ_HAL_SetDBApiReg(pstDbCalcInfo->u32HandleNo, &g_astDBValue[pstDbCalcInfo->u32HandleNo]);

    return HI_SUCCESS;
}
/* software alg  end*/

HI_S32 PQ_MNG_SetVdpDbmParaUpd (HI_U32 u32Data)
{
    HI_U32 u32VId = PQ_VDP_LAYER_VID0;
    return PQ_HAL_SetVdpDbmParaUpd(u32VId);
}

HI_S32 PQ_MNG_InitVdpDbm(HI_VOID)
{
    HI_U32 u32VId = PQ_VDP_LAYER_VID0;
    PQ_HAL_InitVdpDbm();
    PQ_HAL_SetMadWbcEnable(u32VId, HI_TRUE);
    PQ_HAL_SetDbmDetEnable(u32VId, HI_TRUE);
    PQ_HAL_SetDbmInfoEnable(u32VId, HI_TRUE);
    PQ_HAL_SetMadWbcRegUp(u32VId);
    return PQ_HAL_SetVdpDbmEnable(u32VId, HI_TRUE);
}

HI_S32 PQ_MNG_SetVdpDbmInfo(HI_PQ_VDP_WBC_INFO_S* pstInfo)
{
    HI_U32 u32VId = PQ_VDP_LAYER_VID0;
    PQ_CHECK_NULL_PTR(pstInfo);

    PQ_HAL_SetSttWbcAddr(u32VId, pstInfo->u32VdpWbcRegPhyAddr);

    return PQ_HAL_SetDbmInfoReso(u32VId, pstInfo->stCropCoordinate.s32Width, pstInfo->stCropCoordinate.s32Height);
}

static stPQAlgFuncs stDbFuncs =
{
    .Init               = PQ_MNG_InitDB,
    .DeInit             = PQ_MNG_DeinitDB,
    .SetEnable          = PQ_MNG_EnableDB,
    .GetEnable          = PQ_MNG_GetDBEnableFlag,
    .SetStrength        = PQ_MNG_SetDBStrength,
    .GetStrength        = PQ_MNG_GetDBStrength,
    .SetDemo            = PQ_MNG_EnableDBDemo,
    .GetDemo            = PQ_MNG_GetDBDemo,
    .SetDemoMode        = PQ_MNG_SetDbmDemoMode,
    .GetDemoMode        = PQ_MNG_GetDbmDemoMode,
    .SetDemoModeCoor    = PQ_MNG_SetDbmDemoModeCoor,
    .SetTunMode         = PQ_MNG_SetDbTunMode,
    .GetTunMode         = PQ_MNG_GetDbTunMode,
    .DBCfgRefresh       = PQ_MNG_DBCfgRefresh,
    .DBCalcConfigCfg    = PQ_MNG_DBCalcConfigCfg,
    .SetVdpDbmParaUpd   = PQ_MNG_SetVdpDbmParaUpd,
    .InitVdpDbm         = PQ_MNG_InitVdpDbm,
    .SetVdpDbmInfo      = PQ_MNG_SetVdpDbmInfo,
};

HI_S32 PQ_MNG_RegisterDB(PQ_REG_TYPE_E enType)
{
    HI_S32 s32Ret;

    s32Ret = PQ_COMM_AlgRegister(HI_PQ_MODULE_DB, enType, PQ_BIN_ADAPT_SINGLE, "db", HI_NULL, &stDbFuncs);

    return s32Ret;
}

HI_S32 PQ_MNG_UnRegisterDB(HI_VOID)
{
    HI_S32 s32Ret;

    s32Ret = PQ_COMM_AlgUnRegister(HI_PQ_MODULE_DB);

    return s32Ret;
}


