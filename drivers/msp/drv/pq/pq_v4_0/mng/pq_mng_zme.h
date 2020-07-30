/******************************************************************************
*
* Copyright (C) 2014 Hisilicon Technologies Co., Ltd.  All rights reserved.
*
* This program is confidential and proprietary to Hisilicon  Technologies Co., Ltd. (Hisilicon),
*  and may not be copied, reproduced, modified, disclosed to others, published or used, in
* whole or in part, without the express prior written permission of Hisilicon.
*
*****************************************************************************

  File Name     : pq_mng_zme.h
  Version       : Initial Draft
  Author        : pengjunwei 00203646
  Created       : 2014/04/01
  Author        : pengjunwei 00203646
******************************************************************************/
#ifndef __PQ_MNG_ZME_H__
#define __PQ_MNG_ZME_H__

#include <linux/string.h>

#include "hi_type.h"
#include "hi_reg_common.h"
#include "drv_pq_comm.h"
#include "pq_hal_zme.h"

#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif
#endif


#define ALG_V_HZME_PRECISION 1048576
#define ALG_V_VZME_PRECISION 4096


typedef struct
{
    HI_U32 u32Ratio;
    HI_U32 u32TapL;
    HI_U32 u32TapC;
} VZME_PICKCOEF_PARA_S;

typedef struct hiALG_RECT_S
{
    HI_S32 s32X;
    HI_S32 s32Y;
    HI_S32 s32Width;
    HI_S32 s32Height;
} ALG_RECT_S;

typedef struct
{
    HI_U32 u32ZmeFrmWIn;      /* zme input frame width */
    HI_U32 u32ZmeFrmHIn;      /* zme input frame height */
    HI_U32 u32ZmeFrmWOut;     /* zme output frame width */
    HI_U32 u32ZmeFrmHOut;     /* zme output frame height */

    HI_U8 u8ZmeYCFmtIn;       /* video format for zme input: 0-422; 1-420; 2-444 */
    HI_U8 u8ZmeYCFmtOut;      /* video format for zme Output: 0-422; 1-420; 2-444 */

    HI_BOOL bZmeFrmFmtIn;     /* Frame format for zme input: 0-field; 1-frame */
    HI_BOOL bZmeFrmFmtOut;    /* Frame format for zme Output: 0-field; 1-frame */
    HI_BOOL bZmeBFIn;         /* Input field polar when input is field format: 0-top field; 1-bottom field */
    HI_BOOL bZmeBFOut;        /* Output field polar when Output is field format: 0-top field; 1-bottom field */

    /* 1.OriRect; 2.InFrameRate; 3.OutRate; 4.Out I/P */
    ALG_RECT_S stOriRect;
    HI_U32  u32InRate;        /* Vpss out Rate  RealRate*1000 */
    HI_U32  u32OutRate;       /* Disp Rate      RealRate*1000 */
    HI_BOOL bDispProgressive; /* 1:Progressive  0:Interlace */
    HI_U32  u32Fidelity;      /* rwzb info >0:is rwzb */
} ALG_VZME_DRV_PARA_S;

/* PORT缩放的窗口大小 */
typedef struct hiZME_PORT_WIN_S
{
    HI_U32    u32Height;
    HI_U32    u32Width;
} ZME_PORT_WIN_S;

/* ZME各Layer缩放窗口大小*/
typedef struct hiZME_LAYER_WIN_S
{
    ZME_PORT_WIN_S    stPort0Win;
    ZME_PORT_WIN_S    stPort1Win;
    ZME_PORT_WIN_S    stPort2Win;
    ZME_PORT_WIN_S    stHSCLWin;
} ZME_LAYER_WIN_S;


HI_S32 PQ_MNG_RegisterZme(PQ_REG_TYPE_E  enType);

HI_S32 PQ_MNG_UnRegisterZme(HI_VOID);




#ifdef __cplusplus
#if __cplusplus
}
#endif
#endif

#endif


