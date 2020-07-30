/******************************************************************************

  Copyright (C), 2014-2015, Hisilicon Tech. Co., Ltd.

******************************************************************************
  File Name     : drv_pq_table.h
  Version       : Initial Draft
  Author        : p00203646
  Created       : 2013/10/15
  Description   :

******************************************************************************/

#ifndef __PQ_MNG_PQ_TABLE_H__
#define __PQ_MNG_PQ_TABLE_H__

#include "hi_drv_pq.h"
#include "drv_pq_comm.h"


#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif
#endif


/*PQ Source Mode*/
typedef enum hiPQ_SOURCE_MODE_E
{
    SOURCE_MODE_NO = 0,
    SOURCE_MODE_SD,
    SOURCE_MODE_HD,
    SOURCE_MODE_UHD,
    SOURCE_MODE_ALL,
} PQ_SOURCE_MODE_E;

/*PQ Output Mode*/
typedef enum hiPQ_OUTPUT_MODE_E
{
    OUTPUT_MODE_NO = 0,
    OUTPUT_MODE_SD,
    OUTPUT_MODE_HD,
    OUTPUT_MODE_UHD,
    OUTPUT_MODE_ALL,
} PQ_OUTPUT_MODE_E;

/*PQ Reg Type*/
typedef enum hiPQ_PRN_TABLE_TYPE_E
{
    PRN_TABLE_ALL = 0,
    PRN_TABLE_MULTI,
    PRN_TABLE_SINGLE,
    PRN_TABLE_ALG,
    PRN_TABLE_SET_DEFAULT,
} PQ_PRN_TABLE_TYPE_E;

typedef struct hiPQ_BIN_MODULE_POS_S
{
    HI_U32 u32StartPos;
    HI_U32 u32EndPos;
} HI_PQ_BIN_MODULE_POS_S;

/* check Timing Source Mode*/
PQ_SOURCE_MODE_E PQ_MNG_CheckSourceMode(HI_U32 u32Width, HI_U32 u32Height);
/* check Timing Output Mode*/
PQ_OUTPUT_MODE_E PQ_MNG_CheckOutputMode(HI_S32 s32Width);

HI_S32 PQ_MNG_DeInitPQTable(HI_VOID);

HI_S32 PQ_MNG_InitPQTable(PQ_PARAM_S* pstPqParam, HI_BOOL bDefault);

HI_S32 PQ_MNG_LoadPhyList(PQ_REG_TYPE_E enRegType, PQ_SOURCE_MODE_E enSourceMode, PQ_OUTPUT_MODE_E enOutputMode);

HI_S32 PQ_MNG_LoadMultiList(PQ_REG_TYPE_E enRegType, PQ_SOURCE_MODE_E enSourceMode, PQ_OUTPUT_MODE_E enOutputMode);

HI_S32 PQ_MNG_InitPhyList(HI_U32 u32ID, HI_PQ_MODULE_E enModule, PQ_SOURCE_MODE_E enSourceMode, PQ_OUTPUT_MODE_E enOutputMode);

HI_U32 PQ_MNG_GetSoftTable(HI_U32 u32Lut, PQ_SOURCE_MODE_E enSourceMode, PQ_OUTPUT_MODE_E enOutputMode, HI_U32 u32DefaultValue);

HI_S32 PQ_MNG_SetSoftTable(HI_U32 u32Lut, PQ_SOURCE_MODE_E enSourceMode, PQ_OUTPUT_MODE_E enOutputMode, HI_U32 u32Value);

HI_U32 PQ_MNG_GetArraySoftTable(HI_U32 u32Lut, HI_U32* pArray, HI_U32 u32Num, PQ_SOURCE_MODE_E enSourceMode, PQ_OUTPUT_MODE_E enOutputMode, HI_U32 u32DefaultArray[]);

HI_S32 PQ_MNG_SetReg(HI_PQ_REGISTER_S* pstAttr, PQ_SOURCE_MODE_E enSourceMode, PQ_OUTPUT_MODE_E enOutputMode);

HI_S32 PQ_MNG_GetReg(HI_PQ_REGISTER_S* pstAttr);

HI_S32 PQ_MNG_FindBinPos(HI_PQ_MODULE_E enModule, HI_U32* pu32StartPos, HI_U32* pu32EndPos);

HI_S32 PQ_MNG_LoadPhyListOfAlg(HI_PQ_MODULE_E enModule, PQ_SOURCE_MODE_E enSourceMode, PQ_OUTPUT_MODE_E enOutputMode);

HI_VOID PQ_MNG_PrintTable(PQ_PRN_TABLE_TYPE_E enType, HI_U32 u32PriAddr);

HI_VOID PQ_MNG_SetTable(HI_U32 u32List, HI_U32 u32Value);





#ifdef __cplusplus
#if __cplusplus
}
#endif
#endif

#endif
