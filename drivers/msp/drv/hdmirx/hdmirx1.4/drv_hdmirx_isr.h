#ifndef __DRV_HDMIRX_ISR_H__
#define __DRV_HDMIRX_ISR_H__

//#include "hal_hdmirx_reg.h"
#include "hi_type.h"

HI_BOOL HDMI_ISR_IsInterrupt(void);
void HDMI_ISR_GetIntStatus(HI_U32*);
void HDMI_ISR_AacDoneIntOnOff(HI_BOOL);
void HDMI_ISR_ReceiveAudioInfoFrameOnEveryPacketOnOff(HI_BOOL);
void HDMI_ISR_AcpIntOnOff(HI_BOOL);
void HDMI_ISR_DisVResChangeEventsOnOff(HI_BOOL);
void HDMI_ISR_Initial(void);
HI_BOOL HDMI_ISR_IsInterrupt(void);
//void HDMI_ISR_GetIntStatus(HI_U32*);
void HDMI_ISR_ClearScdtInt(void);
void HDMI_ISR_NoAviIntOnOff(HI_BOOL);
void HDMI_ISR_Handler(HI_U32 *interrupts);
void HDMI_ISR_TimerHandler(void);
void HDMI_ISR_HdcpIntOnOff(HI_BOOL);
void HDMI_ISR_PowerOnRegInit(void);
void HDMI_ISR_SpdIntOnOff(HI_BOOL);
void HDMI_ISR_CpInterruptOnOff(HI_BOOL);
HI_BOOL HDMI_ISR_IsInterrupt(void);
HI_BOOL HDMI_ISR_IsCecInt(void);
#endif