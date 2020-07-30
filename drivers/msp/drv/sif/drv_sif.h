/******************************************************************************

  Copyright (C), 2012-2014, Hisilicon Tech. Co., Ltd.

 ******************************************************************************
  File Name     : drv_ademod.h
  Version       : Initial Draft
  Author        : Hisilicon multimedia software group
  Created       : 2012/11/06
  Description   : 
  History       :
  1.Date        : 2012/11/06
    Author      : m00196336/l00191026
    Modification: Created file
******************************************************************************/
#ifndef __DRV_ADEMOD_H__
#define __DRV_ADEMOD_H__

#include "hi_debug.h"
#include "hal_sif.h"
#include "hi_module.h"

#ifdef __cplusplus
#if __cplusplus
extern "C"{
#endif
#endif /* __cplusplus */

#define HI_SIF_ERR        HI_LOG_LEVEL_ERROR   /* error conditions                     */
#define HI_SIF_EMERG      HI_LOG_LEVEL_FATAL   /* system is unusable                   */

#define SIF_TRACE(level, fmt...)\
do { \
        HI_TRACE(level, HI_ID_SIF, "[Func]:%s [Line]:%d [Info]:", __FUNCTION__, __LINE__);\
        HI_TRACE(level, HI_ID_SIF, ##fmt);\
} while(0)

#define SIF_CHECK_NULL_PTR(ptr)\
do{\
    if (NULL == ptr)\
    {\
        SIF_TRACE(HI_SIF_ERR,"NULL point \n");\
        return HI_FAILURE;\
    }\
}while(0)

typedef enum
{
    SIF_CHANNEL_STATUS_STOP = 0,
    SIF_CHANNEL_STATUS_START,
    SIF_CHANNEL_STATUS_CAST_BUTT,
} SIF_CHANNEL_STATUS_E;

typedef enum 
{
    SIF_FREQ_ERR_THRESHOLD_10K = 0x09,          /**<Freqency error threshold 10K*/ /**<CNcomment:?¦Ì?¨º??¨°??D?¦Ì 10K*/
    SIF_FREQ_ERR_THRESHOLD_20K = 0x12,              /**<Freqency error threshold 20K*/ /**<CNcomment:?¦Ì?¨º??¨°??D?¦Ì 20K*/
    SIF_FREQ_ERR_THRESHOLD_27K = 0x18,              /**<Freqency error threshold 27K*/ /**<CNcomment:?¦Ì?¨º??¨°??D?¦Ì 27K*/
    SIF_FREQ_ERR_THRESHOLD_30K = 0x1b,              /**<Freqency error threshold 30K*/ /**<CNcomment:?¦Ì?¨º??¨°??D?¦Ì 30K*/
    SIF_FREQ_ERR_THRESHOLD_40K = 0x24,              /**<Freqency error threshold 40K*/ /**<CNcomment:?¦Ì?¨º??¨°??D?¦Ì 40K*/
    SIF_FREQ_ERR_THRESHOLD_50K = 0x2c,              /**<Freqency error threshold 50K*/ /**<CNcomment:?¦Ì?¨º??¨°??D?¦Ì 50K*/
    SIF_FREQ_ERR_THRESHOLD_BUTT
} SIF_FREQ_ERR_THRESHOLD_E;

/* Ademod Device Context*/
typedef struct hiADEMOD_DRV_CTX_S
{
    SIF_HAL_ATTR_S          stDevAttr;  /*device attributes*/
    SIF_CHANNEL_STATUS_E    enCurnStatus;
    HI_UNF_SIF_ATTR_S       stAttr;
    HI_UNF_SIF_OPENPARMS_S  stOpenParam;
    HI_UNF_SIF_STANDARD_TYPE_E enSifStand;
    HI_UNF_SIF_AAOS_MODE_E     enAaosMode;
} SIF_DRV_CTX_S;

#ifdef __cplusplus
#if __cplusplus
}
#endif
#endif /* __cplusplus */

#endif/* __HAL_ADEMOD_H__ */


