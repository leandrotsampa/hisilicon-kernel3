/***********************************************************************************
*              Copyright 2004 - 2014, Hisilicon Tech. Co., Ltd.
*                           ALL RIGHTS RESERVED
* FileName:
* Description: TianLai internal audio dac hal 
*
* History:
* Version   Date         Author         DefectNum    Description
* main\1    2012-11-06   AudioGroup     NULL         Create this file.
***********************************************************************************/
#ifndef __HAL_AFLT_H__
#define __HAL_AFLT_H__

#include "hi_audsp_aflt.h"
#include "hi_drv_aflt.h"

#ifdef __cplusplus
 #if __cplusplus
extern "C" {
 #endif
#endif /* __cplusplus */

typedef struct
{
    AFLT_STATUS_E enCurnStatus;
}
AFLT_CHN_STATE_S;

typedef struct
{
    HI_PHYS_ADDR_T tBufPhyAddr;
    HI_VIRT_ADDR_T tBufVirAddr;
    HI_U32   u32MsgPoolSize;
} HAL_AFLT_MSGPOOL_ATTR_S;

typedef struct
{
    HI_PHYS_ADDR_T tBufPhyAddr;
    HI_VIRT_ADDR_T tBufVirAddr;
    HI_U32   u32BufSize;
    HI_U32   u32Wpos;
    HI_U32   u32Rpos;
    HI_U32   u32StreamReadPos;   /* pts read pos */
    HI_U32   u32PtsBoundary;      /* pts read pointers wrap point */
    HI_U32   u32BufFlag;
    HI_BOOL  bEosFlag;
} HAL_AFLT_INBUF_ATTR_S;

typedef struct
{
    HI_PHYS_ADDR_T tBufPhyAddr;
    HI_VIRT_ADDR_T tBufVirAddr;
    HI_U32   u32BufSize;
    HI_U32   u32Widx;
    HI_U32   u32Wwrap;
    HI_U32   u32Ridx;
    HI_U32   u32Rwrap;
    HI_U32   u32PeriodNumber;   
    HI_U32   u32PeriodBufSize;
    HI_U32   u32UnitHeadSize;
} HAL_AFLT_OUTBUF_ATTR_S;

HI_VOID AFLT_HAL_Init(HI_U32 u32AfltRegBase, HI_BOOL bSwAfltFlag);
HI_VOID AFLT_HAL_DeInit(HI_VOID);
HI_S32 AFLT_HAL_Create(HI_U32 u32AfltId, AFLT_CREATE_ATTR_S* pstAttr);
HI_S32 AFLT_HAL_Destroy(HI_U32 u32AfltId);
HI_S32 AFLT_HAL_Start(HI_U32 u32AfltId);
HI_S32 AFLT_HAL_Stop(HI_U32 u32AfltId);
HI_S32 AFLT_HAL_SetParam(HI_U32 u32AfltId, AFLT_PARAM_S stParam);
HI_S32 AFLT_HAL_GetParam(HI_U32 u32AfltId, AFLT_PARAM_S *pstParam);
HI_S32 AFLT_HAL_SetConfig(HI_U32 u32AfltId, AFLT_CONFIG_S stConfig);
HI_S32 AFLT_HAL_GetConfig(HI_U32 u32AfltId, AFLT_CONFIG_S *pstConfig);
HI_S32 AFLT_HAL_StoreSetting(HI_U32 u32AfltId);
HI_S32 AFLT_HAL_RestoreSetting(HI_U32 u32AfltId);
HI_VOID AFLT_HAL_SetMsgPoolAttr(HI_U32 u32AfltId, HAL_AFLT_MSGPOOL_ATTR_S *pstAttr);
HI_S32 AFLT_HAL_InitInbuf(HI_U32 u32AfltId, HAL_AFLT_INBUF_ATTR_S* pstAttr);
HI_S32 AFLT_HAL_DeInitInbuf(HI_U32 u32AfltId);
HI_S32 AFLT_HAL_DeInitOutbuf(HI_U32 u32AfltId);
HI_S32 AFLT_HAL_InitOutbuf(HI_U32 u32AfltId, HAL_AFLT_OUTBUF_ATTR_S* pstAttr);
HI_VOID AFLT_HAL_GetInbufWritePos(HI_U32 u32AfltId, HI_U32 *pu32WritePos);
HI_VOID AFLT_HAL_GetInbufReadPos(HI_U32 u32AfltId, HI_U32 *pu32ReadPos);
HI_VOID AFLT_HAL_GetInbufStreamReadPos(HI_U32 u32AfltId, HI_U32 *pu32StreamReadPos);
HI_VOID AFLT_HAL_SetInbufWritePos(HI_U32 u32AfltId, HI_U32 u32WritePos);
HI_VOID AFLT_HAL_GetOutbufWriteIdxAndWrap(HI_U32 u32AfltId, HI_U32 *pu32WriteIdx, HI_U32 *pu32WriteWrap);
HI_VOID AFLT_HAL_GetOutbufReadIdxAndWrap(HI_U32 u32AfltId, HI_U32 *pu32ReadIdx, HI_U32 *pu32ReadWrap);
HI_VOID AFLT_HAL_GetExeFrameStatisticsInfo(HI_U32 u32AfltId, HI_U32 *pu32TryExeCnt, HI_U32 *pu32FrameCnt, HI_U32 *pu32ErrFrameCnt);
HI_VOID AFLT_HAL_GetTimeOutStatisticsInfo(HI_U32 u32AfltId, HI_U32 *pu32ScheTimeOutCnt, HI_U32 *pu32ExeTimeOutCnt);
HI_VOID AFLT_HAL_SetOutBufRptrAndWrap(HI_U32 u32AfltId, HI_U32 u32ReadIdx);
HI_VOID AFLT_HAL_SetEosFlag(HI_U32 u32AfltId, HI_BOOL bEosFlag);
HI_VOID AFLT_HAL_GetEndOfFrame(HI_U32 u32AfltId, HI_BOOL *pbEndOfFrame);
HI_S32 AFLT_HAL_GetCunrStatus(HI_U32 u32AfltId, AFLT_STATUS_E* pstCunrStatus);

#ifdef __cplusplus
 #if __cplusplus
}
 #endif
#endif /* __cplusplus */

#endif /* __HAL_AFLT_H__ */
