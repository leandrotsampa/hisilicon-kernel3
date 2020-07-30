#ifndef __DRV_HDMIRX_INFO_DRV_H__
#define __DRV_HDMIRX_INFO_DRV_H__



HI_U32 HDMI_AVI_GetReplication(void);
HI_BOOL HDMI_AVI_GetDataValid(void);
color_space_type HDMI_AVI_GetColorSpace(void);
colorimetry_type HDMI_AVI_GetColorMetry(void);
void HDMI_INFO_ResetData(void);
void HDMI_INFO_Initial(void);
void HDMI_AVI_NoAviHandler(void);
void HDMI_INFO_IntHandler(HI_U32);
void HDMI_INFO_ResetAudInfoFrameData(void);
void HDMI_VSIF_Mloop(void);
void HDMI_ISRC_MLoop(void);
void HDMI_ACP_IntHandler(void);
void HDMI_INFO_TimerProc(void);
void HDMI_INFO_CpHandler(void);
#endif