/*****************************************************************************
 *
 * Copyright (C) 2014-2015 Hisilicon Technologies Co., Ltd.  All rights reserved.
 *
 * This program is confidential and proprietary to Hisilicon  Technologies Co., Ltd. (Hisilicon),
 *  and may not be copied, reproduced, modified, disclosed to others, published or used, in
 * whole or in part, without the express prior written permission of Hisilicon.
 *
 *****************************************************************************

   File Name     : pq_hal_table_default.h
   Version       : initial draft for hi3708cv200
   Author        : p00203646
   Created       : 2015/09/17
   Author      : p00203646
 ******************************************************************************/

#ifndef __PQ_HAL_PQ_TABLE_DEFAULT_H__
#define __PQ_HAL_PQ_TABLE_DEFAULT_H__

#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif
#endif /* __cplusplus */

extern PQ_PHY_REG_S sg_stPhyReg[PHY_REG_MAX];
extern PQ_PHY_REG_S sg_stPQSoftReg[SOFT_REG_MAX];


/*soft table pq bin define*/
/* Fmd */
#define PQ_SOFT_IP_DETECT                0xfffe0001
#define PQ_SOFT_FRMRATETHR_L             0xfffe0005
#define PQ_SOFT_FRMRATETHR_H             0xfffe0009


/* DB Init */
#define PQ_SOFT_DB_NUM_WIN               0xfffe0105
#define PQ_SOFT_DB_HYMINBLKNUM           0xfffe0109
#define PQ_SOFT_DB_HCMINBLKNUM           0xfffe010d
#define PQ_SOFT_DB_VYMINBLKNUM           0xfffe0111
#define PQ_SOFT_DB_KEYFRM_NUM            0xfffe0115
#define PQ_SOFT_DB_HYBORDCOUNTHRD        0xfffe0119
#define PQ_SOFT_DB_HCBORDCOUNTHRD        0xfffe011d
#define PQ_SOFT_DB_VYBORDCOUNTHRD        0xfffe0121
#define PQ_SOFT_DB_FRMWINTMP             0xfffe0125
#define PQ_SOFT_DB_FRMSATWINTMP          0xfffe0129

/* DB Filter */
#define PQ_SOFT_DB_HL_DELTA_STRONG_2     0xfffe0141
#define PQ_SOFT_DB_HL_DELTA_STRONG_1     0xfffe0142
#define PQ_SOFT_DB_HL_DELTA_ULT_STR_2    0xfffe0143
#define PQ_SOFT_DB_HL_DELTA_ULT_STR_1    0xfffe0144
#define PQ_SOFT_DB_HL_DELTA_MID_2        0xfffe0145
#define PQ_SOFT_DB_HL_DELTA_MID_1        0xfffe0146

#define PQ_SOFT_DB_LV_DELTA_2            0xfffe0147
#define PQ_SOFT_DB_LV_DELTA_1            0xfffe0148

#define PQ_SOFT_DB_HC_DELTA_2            0xfffe0149
#define PQ_SOFT_DB_HC_DELTA_1            0xfffe014a



#define PQ_SOFT_DB_STR_FADE_1_2          0xfffe0151
#define PQ_SOFT_DB_STR_FADE_1_1          0xfffe0152

#define PQ_SOFT_DB_STR_FADE_1_4_2        0xfffe0153
#define PQ_SOFT_DB_STR_FADE_1_4_1        0xfffe0154

#define PQ_SOFT_DB_STR_FADE_2_2          0xfffe0155
#define PQ_SOFT_DB_STR_FADE_2_1          0xfffe0156

#define PQ_SOFT_DB_STR_FADE_3_2          0xfffe0157
#define PQ_SOFT_DB_STR_FADE_3_1          0xfffe0158

#define PQ_SOFT_DB_STR_V_FADE_2          0xfffe0159
#define PQ_SOFT_DB_STR_V_FADE_1          0xfffe015a



#define PQ_SOFT_DB_DIR_STR               0xfffe0161

#define PQ_SOFT_DB_DIR_GAIN_2            0xfffe0163
#define PQ_SOFT_DB_DIR_GAIN_1            0xfffe0164


#define PQ_SOFT_DB_DYN_PARA_STR_1        0xfffe0171
#define PQ_SOFT_DB_DYN_PARA_STR_2        0xfffe0172
#define PQ_SOFT_DB_DYN_PARA_STR_3        0xfffe0173
#define PQ_SOFT_DB_DYN_PARA_STR_4        0xfffe0174
#define PQ_SOFT_DB_DYN_PARA_STR_5        0xfffe0175
#define PQ_SOFT_DB_DYN_PARA_STR_6        0xfffe0176
#define PQ_SOFT_DB_DYN_PARA_STR_7        0xfffe0177
#define PQ_SOFT_DB_DYN_PARA_STR_8        0xfffe0178
#define PQ_SOFT_DB_DYN_PARA_STR_9        0xfffe0179

#define PQ_SOFT_DB_DYN_PARA_MID_1        0xfffe0181
#define PQ_SOFT_DB_DYN_PARA_MID_2        0xfffe0182
#define PQ_SOFT_DB_DYN_PARA_MID_3        0xfffe0183
#define PQ_SOFT_DB_DYN_PARA_MID_4        0xfffe0184
#define PQ_SOFT_DB_DYN_PARA_MID_5        0xfffe0185
#define PQ_SOFT_DB_DYN_PARA_MID_6        0xfffe0186
#define PQ_SOFT_DB_DYN_PARA_MID_7        0xfffe0187
#define PQ_SOFT_DB_DYN_PARA_MID_8        0xfffe0188
#define PQ_SOFT_DB_DYN_PARA_MID_9        0xfffe0189

#define PQ_SOFT_DB_DYN_PARA_WEK_1        0xfffe0191
#define PQ_SOFT_DB_DYN_PARA_WEK_2        0xfffe0192
#define PQ_SOFT_DB_DYN_PARA_WEK_3        0xfffe0193
#define PQ_SOFT_DB_DYN_PARA_WEK_4        0xfffe0194
#define PQ_SOFT_DB_DYN_PARA_WEK_5        0xfffe0195
#define PQ_SOFT_DB_DYN_PARA_WEK_6        0xfffe0196
#define PQ_SOFT_DB_DYN_PARA_WEK_7        0xfffe0197
#define PQ_SOFT_DB_DYN_PARA_WEK_8        0xfffe0198
#define PQ_SOFT_DB_DYN_PARA_WEK_9        0xfffe0199


#ifdef __cplusplus
#if __cplusplus
}
#endif
#endif /* __cplusplus */

#endif

