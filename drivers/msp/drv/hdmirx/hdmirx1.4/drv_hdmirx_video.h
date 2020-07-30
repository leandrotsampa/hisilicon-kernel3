#ifndef __DRV_HDMIRX_VIDEO_DRV_H__
#define __DRV_HDMIRX_VIDEO_DRV_H__

#include "hi_drv_proc.h"
#include "hi_drv_hdmirx.h"


void HDMI_VDO_DcReset(void);
void HDMI_VDO_HdmiDviTrans(void);
HI_BOOL HDMI_VDO_IsTimingChg(void);
void HDMI_VDO_SetDcMode(void);
void HDMI_Initial(void);
void HDMI_PowerDownProc(void);
void HDMI_SyncInChangeProc(void);
void HDMI_VDO_ChangeState(HI_U32);
void HDMI_VDO_ResetTimingData(void);
HI_BOOL HDMI_VDO_ModeDet(void);
void HDMI_VDO_MuteOnOff(HI_BOOL);
void HDMI_VDO_SetVideoPath(void);
void HDMI_VDO_ResetTimingData(void);
void HDMI_VDO_ShowTimingInfo(void);
void HDMI_VDO_PowerOnRegInit(void);
void HDMI_VDO_Verify1P4Format(HI_BOOL);
void HDMI_DB_ShowTimingInfo(struct seq_file *s);
void HDMI_DB_ShowInterfaceInfo(struct seq_file *p);
void HDMI_DB_ShowHdcpInfo(struct seq_file *p);
HI_BOOL HDMI_VDO_IsHdmiMode(void);
HI_BOOL HDMIRX_HAL_GetHdcpDone(void);
HI_VOID HDMIRX_HAL_LoadHdcpKey(HI_BOOL bEn);



#endif
