/******************************************************************************
*
* Copyright (C) 2015 Hisilicon Technologies Co., Ltd.  All rights reserved.
*
* This program is confidential and proprietary to Hisilicon  Technologies Co., Ltd. (Hisilicon),
*  and may not be copied, reproduced, modified, disclosed to others, published or used, in
* whole or in part, without the express prior written permission of Hisilicon.
*
*****************************************************************************

  File Name     : pq_mng_gfxcsc.c
  Version       : Initial Draft
  Author        : p00203646
  Created       : 2015/10/15
  Description   :

******************************************************************************/


#ifndef __PQ_MNG_GFX_CSC_H__
#define __PQ_MNG_GFX_CSC_H__


#include "drv_pq_comm.h"

#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif
#endif /* __cplusplus */

HI_S32 PQ_MNG_RegisterGfxCSC(HI_VOID);

HI_S32 PQ_MNG_UnRegisterGfxCSC(HI_VOID);

HI_S32 PQ_MNG_SetGfxWcgGmmCoef( HI_PQ_GAMM_PARA_S* pstGmmCoef);

HI_S32 PQ_MNG_SetGfxWcgDeGmmCoef(HI_PQ_GAMM_PARA_S* pstDeGmmCoef);

HI_S32 PQ_MNG_GetGfxWcgGmmCoef(HI_U32 u32Layer, HI_PQ_GAMM_PARA_S* pstGmmCoef, HI_U32* pu32GamPre);

HI_S32 PQ_MNG_GetGfxWcgDeGmmCoef(HI_U32 u32Layer, HI_PQ_GAMM_PARA_S* pstDeGmmCoef, HI_U32* pu32DeGamPre);


#ifdef __cplusplus
#if __cplusplus
}
#endif
#endif /* __cplusplus */

#endif
