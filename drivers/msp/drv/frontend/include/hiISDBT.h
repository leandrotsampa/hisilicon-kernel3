/***********************************************************************************
*
*  Copyright (C) 2015 Hisilicon Technologies Co., Ltd.  All rights reserved. 
*
*  This program is confidential and proprietary to Hisilicon Technologies Co., Ltd.
*  (Hisilicon), and may not be copied, reproduced, modified, disclosed to
*  others, published or used, in whole or in part, without the express prior
*  written permission of Hisilicon.
*
* FileName: hi3138.c
* Description:
*
* History:
* Version   Date             Author                         DefectNum        Description
* main\1    2015-06-26   w203631\w313507         NULL                Create this file.
***********************************************************************************/
    
#ifndef __HIISDBT_H__
#define __HIISDBT_H__

#ifdef __cplusplus
extern "C"
{
#endif

extern HI_S32 hiISDBT_monitor_layer(HI_U32 u32TunerPort, HI_UNF_TUNER_ISDBT_MONITOR_LAYER_E enMonLayer);

extern HI_S32 hiISDBT_get_TMCC_info(HI_U32 u32TunerPort, HI_UNF_TUNER_TMCC_INFO_S *pstTMCCInfo);

extern HI_S32 hiISDBT_connect(HI_U32 u32TunerPort,TUNER_ACC_QAM_PARAMS_S *pstChannel);

#ifdef __cplusplus
}
#endif

#endif

