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

#ifndef __DRV_HDMIRX_CTRL_H__
#define __DRV_HDMIRX_CTRL_H__

#include <linux/seq_file.h>

#include "hi_unf_hdmirx.h"

#define HDMIRX_WAIT_TIMEOUT 250
#define HDMIRX_NO_SIGNAL_THR    20
#define HDMIRX_HDCP_STABLE_THR  30
#define NO_SIGNAL_THR_IN_VIDEO_ON 4
#define MODECHGCNT 10
#define HDMIRX_CTRL_GET_CTX()          (&s_stHdmirxCtrlCtx)

#define HDMIRX_CTRL_CHECK_CONNECT()    \
    do\
    {\
        if (HI_TRUE != s_stHdmirxCtrlCtx.bConnect)\
        {\
            HI_ERR_DEV("hdmirx is not connected!\n");\
            return HI_FAILURE;\
        }\
    } while (0)

typedef enum hiHDMIRX_CTRL_STATE_E
{
    HDMIRX_STATE_VIDEO_OFF,
    HDMIRX_STATE_VIDEO_ON,
    HDMIRX_STATE_WAIT,
    HDMIRX_STATE_BUTT
}HDMIRX_CTRL_STATE_E;
        
typedef enum hiHDMIRX_CTRL_VIDPATH_E
{
    HDMIRX_VIDPATH_NORMAL,
    HDMIRX_VIDPATH_BYPASS,
    HDMIRX_VIDPATH_BUTT
}HDMIRX_CTRL_VIDPATH_E;

typedef enum hiHDMIRX_CTRL_Coreiso_E
{
    HDMIRX_Coreiso_NORMAL,
    HDMIRX_Coreiso_BYPASS,
    HDMIRX_Coreiso_BUTT
}HDMIRX_CTRL_Coreiso_E;

typedef enum hiHDMIRX_MODECHG_TYPE_E
{
    HDMIRX_MODECHG_TYPE_NONE,
    HDMIRX_MODECHG_TYPE_HDCPERR,
    HDMIRX_MODECHG_TYPE_WAITOUT,
    HDMIRX_MODECHG_TYPE_CKDT,
    HDMIRX_MODECHG_TYPE_NOPOW,
    HDMIRX_MODECHG_TYPE_NOSCDT,
    HDMIRX_MODECHG_TYPE_TIMINGCHG,
    HDMIRX_MODECHG_TYPE_NOAVI,
    HDMIRX_MODECHG_TYPE_AVICHG,
    HDMIRX_MODECHG_TYPE_VSIFCHG,
    HDMIRX_MODECHG_TYPE_BUTT        
}HDMIRX_MODECHG_TYPE_E;

typedef enum hiHDMIRX_RST_TYPE_E
{
    HDMIRX_RST_NONE= 0,
    HDMIRX_RST_HDMI,
    HDMIRX_RST_MHL
}HDMIRX_RST_TYPE_E;

typedef struct hiHDMIRX_CTRL_PORT_CTX_S
{
    HI_U32                  u32HdcpStableCnt;
    HDMIRX_CTRL_STATE_E     enState;
    HDMIRX_CTRL_STATE_E     enLastState;
    HI_U32                  u32WaitTimeOut;
	HI_U32					u32WaitCnt;
}HDMIRX_CTRL_PORT_CTX_S;

typedef struct hiHDMIRX_CTRL_CONTEXT_S
{
    HI_U32              	u32DevId;			/* device id of ip*/	
    HI_U32              	u32DevicRev;		/* revision of  device*/
	//HI_BOOL 				bConnect;
    HI_UNF_HDMIRX_PORT_E    enCurPort;			/* current port*/
	HI_UNF_HDMIRX_PORT_E    enStartPort;		/* current used port*/
    HI_UNF_HDMIRX_PORT_E    enEndPort;			/* the start port to loop check */
    HI_UNF_HDMIRX_PORT_E    enLoopPort;			/* loop count of port */
    struct task_struct		*pstProcessTask;	/* the point of thread */
    HI_BOOL             	bRun;				/* the switch of the thread running*/
    HI_U32              	u32NoSyncCnt;		/* the counter of no sync*/
	HI_BOOL 				bModeChange;		/* the flag of mode change */
	//HI_BOOL					bModeChangeDone;	/* the flag of mode detect done*/
	HDMIRX_CTRL_PORT_CTX_S	astPortStatus[4];	/* the status of port */
    HI_BOOL                 bNoAvi;
    HI_U8                   au8Pwr5v[4];
    HI_U8                   u8Pwr5vCnt;
    HI_BOOL                 bNeedSubPort;
    HI_BOOL                 bHdcpCheckEn;
    HI_U32                  u32HdcpErrCnt;
    HDMIRX_MODECHG_TYPE_E   enModeChgType[MODECHGCNT];
    HDMIRX_RST_TYPE_E       enModeRstReason;
}HDMIRX_CTRL_CONTEXT_S;

HI_VOID HDMIRX_DRV_CTRL_CtxLock(HI_VOID);
HI_VOID HDMIRX_DRV_CTRL_CtxUnlock(HI_VOID);
HI_S32 HDMIRX_DRV_CTRL_Connect(HI_UNF_HDMIRX_PORT_E enPort);
HI_S32 HDMIRX_DRV_CTRL_Disconnect(HI_VOID);

HI_S32 HDMIRX_DRV_CTRL_GetSigStatus(HI_UNF_SIG_STATUS_E *penSigSta);
HI_S32 HDMIRX_DRV_CTRL_GetAudioStatus(HI_UNF_SIG_STATUS_E *penSigSta);
HI_S32 HDMIRX_DRV_CTRL_GetTiming(HI_UNF_HDMIRX_TIMING_INFO_S *pstTimingInfo);
HI_S32 HDMIRX_DRV_CTRL_GetHdcpStatus(HI_BOOL *pbHdcp);
HI_S32 HDMIRX_DRV_CTRL_SetMonitorRun(HI_BOOL bRun);
HI_S32 DRV_HDMIRX_CTRL_ProcRead(struct seq_file *s, HI_VOID *data);
HI_S32 DRV_HDMIRX_CTRL_ProcWrite(struct file * file,const char __user * buf, size_t count, loff_t *ppos);
HI_S32 HDMIRX_DRV_CTRL_Init(HI_VOID);
HI_S32 HDMIRX_DRV_CTRL_Suspend(HI_VOID);
HI_S32 HDMIRX_DRV_CTRL_Resume(HI_VOID);
HI_VOID HDMIRX_DRV_CTRL_DeInit(HI_VOID);
HI_BOOL HDMIRX_CTRL_IsNeed2beDone(HI_VOID);
HI_BOOL HDMIRX_CTRL_IsVideoOnState(HI_VOID);
HI_U32 HDMIRX_CTRL_GetShadowIntMask(HI_U32 u32Idx);
HI_VOID HDMIRX_CTRL_SetShadowIntMask(HI_U32 u32Idx, HI_U32 u32Mask, HI_BOOL bEn);
HI_VOID HDMIRX_CTRL_ModeChange(HI_VOID);
HI_VOID HDMIRX_CTRL_ChangeState(HDMIRX_CTRL_STATE_E eNewState);
HI_UNF_HDMIRX_PORT_E HDMIRX_CTRL_GetCurPort(HI_VOID);
HI_S32 HDMIRX_DRV_CTRL_GetAudioInfo(HI_UNF_AI_HDMI_ATTR_S *pstAudioInfo);
HI_S32 HDMIRX_DRV_CTRL_GetOffLineDetStatus(HI_UNF_HDMIRX_OFF_LINE_DET_S *pstOffLineDet);
HI_S32 HDMIRX_DRV_CTRL_LoadHdcp(HI_UNF_HDMIRX_HDCP_S *pstHdcpKey);
HI_S32 HDMIRX_DRV_CTRL_UpdateEdid(HI_UNF_HDMIRX_EDID_S *pstEdid);
HDMIRX_CTRL_STATE_E HDMIRX_DRV_CTRL_GetState(HI_VOID);
HI_U32 HDMIRX_DRV_CTRL_GetDataRoute(HI_VOID);
HI_UNF_SIG_STATUS_E HDMIRX_CTRL_GetPortStatus(HI_UNF_HDMIRX_PORT_E enPort);
HI_UNF_HDMIRX_PORT_E HDMIRX_CTRL_GetSubPort(HI_VOID);
HI_BOOL HDMIRX_CTRL_GetSubPortStatus(HI_VOID);
HI_BOOL HDMIRX_CTRL_IsNeedSubPort(HI_VOID);
HI_VOID HDMIRX_CTRL_ModeChgAdd(HDMIRX_MODECHG_TYPE_E enModeChgType);
HI_VOID HDMIRX_CTRL_TryEQ(HI_BOOL bflag);
HDMIRX_RST_TYPE_E HDMIRX_CTRL_GetHdmirxRstReason(HI_VOID);
HI_VOID HDMIRX_CTRL_SetHdmirxRstReason(HDMIRX_RST_TYPE_E enRstType);
//HI_S32 HDMIRX_DRV_CTRL_SendRCPKey(HI_UNF_HDMIRX_RCP_KEY_E *enKey);


#endif

