/******************************************************************************

  Copyright (C), 2012-2050, Hisilicon Tech. Co., Ltd.

 ******************************************************************************
  File Name     : drv_hdmirx_ctrl.h
  Version       : Initial Draft
  Author        : Hisilicon multimedia software group
  Created       : 2014/01/16
  Description   : 
  History       :
  1.Date        : 2014/01/16
    Author      : t00202585
    Modification: Created file
******************************************************************************/

#ifndef __DRV_HDMIRX_INPUT_H__
#define __DRV_HDMIRX_INPUT_H__

typedef enum hiHDMIRX_INPUT_DDC_E
{
    HDMIRX_INPUT_DDC_EDID,
    HDMIRX_INPUT_DDC_HDCP,
    HDMIRX_INPUT_DDC_BUTT
}HDMIRX_INPUT_DDC_E;

HI_VOID HDMIRX_INPUT_SwitchPort(HI_UNF_HDMIRX_PORT_E enPort);
HI_VOID HDMIRX_INPUT_SetDdcEn(HDMIRX_INPUT_DDC_E enType, HI_UNF_HDMIRX_PORT_E enIdx, HI_BOOL bEn);
HI_VOID HDMIRX_INPUT_Init(HI_VOID);
HI_VOID HDMIRX_INPUT_EdidInitial(HI_U32 *pau32Table,HI_U32* pau32Addr);
HI_VOID HDMIRX_INPUT_SetHpdLv(HI_UNF_HDMIRX_PORT_E enIdx, HI_BOOL bLv);
HI_VOID HDMIRX_INPUT_SetHpdManual(HI_UNF_HDMIRX_PORT_E enIdx, HI_BOOL bManual);
HI_VOID HDMIRX_INPUT_SetHdmiRtEn(HI_UNF_HDMIRX_PORT_E enPortIdx, HI_BOOL bEn);


#endif
