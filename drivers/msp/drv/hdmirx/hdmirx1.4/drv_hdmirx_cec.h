#ifndef __DRV_HDMIRX_CEC_H__
#define __DRV_HDMIRX_CEC_H__

//#include "hal_hdmirx_reg.h"
#include "hi_type.h"





void HDMI_CEC_Init(HI_U16);
void HDMI_CEC_Isr(void);
void HDMI_CEC_Handler(void);
void HDMI_CEC_Resume(void);

#endif
