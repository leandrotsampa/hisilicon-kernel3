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
    
#ifndef __HIDVBC_H__
#define __HIDVBC_H__

#ifdef __cplusplus
extern "C"
{
#endif

extern HI_S32 hiDVBC_connect(HI_U32 u32TunerPort,TUNER_ACC_QAM_PARAMS_S *pstChannel);

extern HI_S32 hiDVBC_get_status (HI_U32 u32TunerPort, HI_UNF_TUNER_LOCK_STATUS_E  *penTunerStatus);

extern HI_S32 hiDVBC_get_ber(HI_U32 u32TunerPort, HI_U32 * pu32BERa);

extern HI_S32 hiDVBC_get_snr(HI_U32 u32TunerPort, HI_U32 * pu32SignalStrength);

extern HI_S32 hiDVBC_get_signal_strength(HI_U32 u32TunerPort, HI_U32 * pu32strength);

extern HI_S32 hiDVBC_get_signal_info(HI_U32 u32TunerPort, HI_UNF_TUNER_SIGNALINFO_S *pstInfo);

extern HI_S32 hiDVBC_set_ts_out(HI_U32 u32TunerPort, HI_UNF_TUNER_TSOUT_SET_S *pstTSOut);

extern HI_S32 hiDVBC_get_freq_symb_offset(HI_U32 u32TunerPort, HI_U32 * pu32Freq, HI_U32 * pu32Symb);
#ifdef __cplusplus
}
#endif

#endif


