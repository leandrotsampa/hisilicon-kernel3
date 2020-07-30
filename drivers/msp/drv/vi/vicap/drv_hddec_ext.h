/******************************************************************************

  Copyright (C), 2012-2014, Hisilicon Tech. Co., Ltd.

 ******************************************************************************
  File Name     : drv_hddec_ext.h
  Version       : Initial Draft
  Author        : Hisilicon multimedia software group
  Created       : 2013/10/28
  Description   : 
  History       :
  1.Date        : 2013/10/28
    Author      : t00202585/z00185248
    Modification: Created file
******************************************************************************/
#ifndef __DRV_HDDEC_EXT_H__
#define __DRV_HDDEC_EXT_H__

#include "hi_type.h"

typedef enum hiDRV_HDDEC_DATA_ORDER_E 
{
    HI_DRV_HDDEC_DATA_ORDER_RGB = 0, // PrYPb
    HI_DRV_HDDEC_DATA_ORDER_RBG,     // PrPbY
    HI_DRV_HDDEC_DATA_ORDER_GRB,     // YPrPb
    HI_DRV_HDDEC_DATA_ORDER_GBR,     // YPrPb   
    HI_DRV_HDDEC_DATA_ORDER_BRG,     // PbPrY
    HI_DRV_HDDEC_DATA_ORDER_BGR,     // PbYPr

    HI_DRV_HDDEC_DATA_ORDER_BUTT,
} HI_DRV_HDDEC_DATA_ORDER_E;

typedef struct
{    
    HI_U32 (*pfnHDDECGetDataOrder)(HI_VOID); 
} HDDEC_EXPORT_FUNC_S;

HI_S32 HDDEC_DRV_ModInit(HI_VOID);
HI_VOID HDDEC_DRV_ModExit(HI_VOID);

#endif

