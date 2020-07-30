#ifndef __DRV_HDMIRX_SYS_DRV_H__
#define __DRV_HDMIRX_SYS_DRV_H__



void HDMI_PHY_HpdAuto(HI_BOOL);
void  HDMI_PHY_ManualHpd(HI_BOOL);
void HDMI_SYS_PowerOnOff(HI_BOOL);
void HDMI_SYS_DcFifoReset(void);
void HDMI_SYS_SwReset(void);

void HDMI_SYS_DdcOnOff(HI_BOOL);
void HDMI_SYS_DisPipe(void);
void HDMI_SYS_InputOnOff(HI_BOOL);
void HDMI_SYS_ServeRt(void);
void HDMI_HDCP_Reset(void);
void HDMI_SYS_GetDevId(void);
void HDMI_SYS_SwRstOnOff(HI_BOOL);
void HDMI_SYS_EdidInit(void);
HI_S32 HDMIRX_DRV_CTRL_UpdateEdid(HI_UNF_HDMIRX_EDID_S *pstEdid);

#endif
