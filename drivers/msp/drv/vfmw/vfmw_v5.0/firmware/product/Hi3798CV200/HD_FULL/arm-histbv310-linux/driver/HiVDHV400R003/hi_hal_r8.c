/*$$$!!Warning: Huawei key information asset. No spread without permission.$$$*/
/*CODEMARK:EG4uRhTwMmgcVFBsBnYHCDadN5jJKSuVyxmmaCmKFU6eJEbB2fyHF9weu4/jer/hxLHb+S1e
E0zVg4C3NiZh4SXu1DUPt3BK64ZJx2SaroS3rXSLw17NxVPR0UnlD+OwiYx/+ktYlVm/Xqii
03IHVnxp8Vl6WABpnrwCatebuN0fNXnKfGdZ4C2W5s/lfG/2XI5RWKUJydSizbc3AsFy7Meq
HqaXnMYmw4ExWXqtUqHDEbmPfltPXhkK2V9PqWFCYevF1pzSsEQGzWcyZbOguQ==#*/
/*$$$!!Warning: Deleting or modifying the preceding information is prohibited.$$$*/




















/***********************************************************************
*
* Copyright (c) 2010 Hisilicon - All Rights Reserved
*
* File: $vdm_hal_real8.c$
* Date: $2010/06/09$
* Revision: $v1.0$
* Purpose: HiVDHV100 IP REAL8 VDM HAL Module.
*
* Change History:
*
* Date       Author            Change
* ======     ======            ======
* 20100609   q45134            Original
*
************************************************************************/

#ifndef __VDM_HAL_REAL8_C__
#define __VDM_HAL_REAL8_C__

#include "vdm_hal.h"
#include "decparam.h"

VOID RV8HAL_V400R003_WriteReg(VDMHAL_HWMEM_S *pHwMem, RV8_DEC_PARAM_S *pRv8DecParam, SINT32 VdhId, VOID *pTask);
VOID RV8HAL_V400R003_WritePicMsg(VDMHAL_HWMEM_S *pHwMem, RV8_DEC_PARAM_S *pRv8DecParam);
VOID RV8HAL_V400R003_WriteSliceMsg(VDMHAL_HWMEM_S *pHwMem, RV8_DEC_PARAM_S *pRv8DecParam);


SINT32 RV8HAL_V400R003_InitHal( VOID )
{
    return VDMHAL_OK;
}


SINT32 RV8HAL_V400R003_StartDec( RV8_DEC_PARAM_S *pRv8DecParam, SINT32 VdhId, VOID *pTask)
{
    return -1;
}

VOID RV8HAL_V400R003_WriteReg(VDMHAL_HWMEM_S *pHwMem, RV8_DEC_PARAM_S *pRv8DecParam, SINT32 VdhId, VOID *pTask)
{
    return;
}


VOID RV8HAL_V400R003_WritePicMsg(VDMHAL_HWMEM_S *pHwMem, RV8_DEC_PARAM_S *pRv8DecParam)
{
    return;
}


VOID RV8HAL_V400R003_WriteSliceMsg(VDMHAL_HWMEM_S *pHwMem, RV8_DEC_PARAM_S *pRv8DecParam)
{
    return;
}


#endif //__VDM_HAL_REAL8_C__
