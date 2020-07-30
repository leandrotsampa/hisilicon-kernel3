/******************************************************************************

  Copyright (C), 2012-2050, Hisilicon Tech. Co., Ltd.

 ******************************************************************************
  File Name     : drv_hdmi_ctrl.c
  Version       : Initial Draft
  Author        : Hisilicon multimedia software group
  Created       : 2014/01/16
  Description   : 
  History       :
  1.Date        : 2014/01/16
    Author      :  t00202585
    Modification: Created file
******************************************************************************/

#include <linux/kthread.h>
#include <linux/delay.h>
#include <linux/semaphore.h>
#include <asm/io.h>
#include <asm/uaccess.h>
#include <linux/slab.h>

#include "hi_drv_proc.h"
#include "hi_drv_dev.h"
#include "drv_hdmirx_common.h"
#include "drv_hdmirx_ctrl.h"
#include "hal_hdmirx.h"
#include "hal_hdmirx_reg.h"
#include "drv_hdmirx_mhl.h"
#include "drv_hdmirx_video.h"
#include "drv_hdmirx_audio.h"
#include "drv_hdmirx_mhl.h"
#include "drv_hdmirx.h"
#include "drv_hdmirx_packet.h"
#include "drv_hdmirx_input.h"
#include "hal_hdmirx.h"
#include "hi_drv_module.h"
#include "drv_gpioi2c_ext.h"
#include "drv_cipher_ext.h"
#include "hi_reg_common.h"
#include "drv_hdmirx_ext.h"
#if !(defined(CHIP_TYPE_hi3796cv100)||defined(CHIP_TYPE_hi3796cv100_a)|| defined(CHIP_TYPE_hi3798cv100)\
    || defined(CHIP_TYPE_hi3798cv100_a))
#include "hi_board.h"
#endif


#ifdef __cplusplus
 #if __cplusplus
    extern "C" {
 #endif
#endif /* __cplusplus */

#define HDMIRX_HDCP_ERR_CNT_THR        40   // 80
#define HDMIRX_HDCP_M_RST_WAITMS       400 

static DEFINE_SEMAPHORE(s_stHdmirxCtrlCtxLock);

static HDMIRX_CTRL_CONTEXT_S s_stHdmirxCtrlCtx;
HI_UNF_HDMIRX_HDCP_S stHdcpData;
HI_UNF_HDMIRX_EDID_S stEdidData;

static HI_U32  au32ShadowIntMask[HDMIRX_INTR_BUTT];
static const HI_U32 InterruptMask[HDMIRX_INTR_BUTT] =
{
	0,  // INTR1
	0,  // INTR2
	intr_cp_set_mute | INTR3_SERVING_PACKETS_MASK |	0,  // INTR3
	intr_HDCP_packet_err | 0,  // INTR4
	intr_audio_muted |
    reg_vres_chg | reg_hres_chg | intr_aud_sample_f | 0,  // INTR5
	intr_dc_packet_err | intr_new_acp | intr_dsd_on | 0, // INTR6
	0,  // INTR7
	0,  // INTR8
	intr_ckdt | 0,   // INTR2_AON
    intr_pwr5v | 0, // INTR6_AON
    0, // INTR8_AON
};

static const HI_CHAR *s_apsStateString[] =
{
    "no signal",
    "signal stabel",
    "signal unstable",
    "BUTT"
};

static const HI_CHAR *s_apsPortString[] =
{
    "Port_0",
    "Port_1",
    "Port_2",
    "Port_3",
    "Port_all",
    "BUTT"
};

inline HI_VOID HDMIRX_DRV_CTRL_CtxLock(HI_VOID)
{
    down(&s_stHdmirxCtrlCtxLock);
}

inline HI_VOID HDMIRX_DRV_CTRL_CtxUnlock(HI_VOID)
{
    up(&s_stHdmirxCtrlCtxLock);
}

HI_UNF_HDMIRX_PORT_E HDMIRX_CTRL_GetSubPort(HI_VOID)
{
    return HI_UNF_HDMIRX_PORT_BUTT;
    /*
#ifdef HI_BOARD_HDMIRX_SUBPORT
    return HI_BOARD_HDMIRX_SUBPORT;
#else
    return HI_UNF_HDMIRX_PORT_BUTT;
#endif
*/
}

HI_BOOL HDMIRX_CTRL_GetSubPortStatus(HI_VOID)
{
    return HI_FALSE;
}

HI_UNF_HDMIRX_PORT_E HDMIRX_CTRL_GetCurPort(HI_VOID)
{
    HDMIRX_CTRL_CONTEXT_S *pstCtrlCtx;

    pstCtrlCtx = HDMIRX_CTRL_GET_CTX();
    
    return pstCtrlCtx->enCurPort;
}

HI_VOID HDMIRX_CTRL_UpdateSubPortStatus(HI_VOID)
{
    HDMIRX_CTRL_CONTEXT_S *pstCtrlCtx;

    pstCtrlCtx = HDMIRX_CTRL_GET_CTX();

    pstCtrlCtx->bNeedSubPort = HDMIRX_CTRL_GetSubPortStatus();
}

HI_BOOL HDMIRX_CTRL_IsNeedSubPort(HI_VOID)
{
    HDMIRX_CTRL_CONTEXT_S *pstCtrlCtx;
    pstCtrlCtx = HDMIRX_CTRL_GET_CTX();
    
    if((HDMIRX_CTRL_GetCurPort() == HI_UNF_HDMIRX_PORT0)\
        &&(HDMIRX_CTRL_GetSubPort()!= HI_UNF_HDMIRX_PORT_BUTT)&&(pstCtrlCtx->bNeedSubPort == HI_TRUE))
    {
        return HI_TRUE;
    }
    else
    {
        return HI_FALSE;
    }
        
}

HI_VOID HDMIRX_CTRL_ModeChgAdd(HDMIRX_MODECHG_TYPE_E enModeChgType)
{
    HDMIRX_CTRL_CONTEXT_S *pstCtrlCtx; 
    HI_U32 u32Cnt;
    pstCtrlCtx = HDMIRX_CTRL_GET_CTX();
    for(u32Cnt = 0;u32Cnt < MODECHGCNT ; u32Cnt++)
    {
        if(pstCtrlCtx->enModeChgType[u32Cnt] == HDMIRX_MODECHG_TYPE_NONE)
        {
            break;
        }
    }
    if(u32Cnt < MODECHGCNT)
    {
        pstCtrlCtx->enModeChgType[u32Cnt]= enModeChgType;
    }
    else
    {
        for(u32Cnt = 0;u32Cnt < MODECHGCNT-1;u32Cnt++)
        {
            pstCtrlCtx->enModeChgType[u32Cnt] = pstCtrlCtx->enModeChgType[u32Cnt+1];
        }
        pstCtrlCtx->enModeChgType[MODECHGCNT-1] = enModeChgType;
    }
}

HDMIRX_RST_TYPE_E HDMIRX_CTRL_GetHdmirxRstReason(HI_VOID)
{
    HDMIRX_CTRL_CONTEXT_S *pstCtrlCtx; 
    pstCtrlCtx = HDMIRX_CTRL_GET_CTX();
    return pstCtrlCtx->enModeRstReason;
}

HI_VOID HDMIRX_CTRL_SetHdmirxRstReason(HDMIRX_RST_TYPE_E enRstType)
{
    HDMIRX_CTRL_CONTEXT_S *pstCtrlCtx; 
    pstCtrlCtx = HDMIRX_CTRL_GET_CTX();
    pstCtrlCtx->enModeRstReason = enRstType;
}

HI_VOID HDMIRX_CTRL_HdmirxRstChg(HI_VOID)
{
    static HI_U32 u32Cnt = 0;
    HDMIRX_RST_TYPE_E enRstType;
    enRstType = HDMIRX_CTRL_GetHdmirxRstReason();
    if((enRstType == HDMIRX_RST_MHL)&&(HDMIRX_CTRL_GetCurPort() == HI_UNF_HDMIRX_PORT0))
    {
        u32Cnt++;
        if(u32Cnt > 100)
        {
            u32Cnt = 0;
            HDMIRX_CTRL_SetHdmirxRstReason(HDMIRX_RST_NONE);
            HDMIRX_HAL_SetResetEn(HI_UNF_HDMIRX_PORT0, HDMIRX_HDMIM_RST, HI_FALSE);
        }
    }
}

HI_BOOL HDMIRX_CTRL_HdcpErrCheck(HI_U32 u32ERRCNT)
{
    HI_U32 u32BchErrCnt, u32HdcpErrCnt;
    HI_U32 u32CurPort;
    HDMIRX_CTRL_CONTEXT_S *pstCtrlCtx;    

    pstCtrlCtx = HDMIRX_CTRL_GET_CTX();
    u32CurPort = pstCtrlCtx->enCurPort;
    if(u32CurPort >= HI_UNF_HDMIRX_PORT_BUTT)
    {
        return HI_FALSE;
    }
    
    u32BchErrCnt = HDMIRX_HAL_GetBchErrCnt(u32CurPort);
    u32HdcpErrCnt = HDMIRX_HAL_GetHdcpErrCnt(u32CurPort);

    if(u32BchErrCnt && u32HdcpErrCnt)
    {
        HDMIRX_HAL_ClearT4Error(u32CurPort);
        if(HDMIRX_CTRL_IsNeedSubPort() == HI_TRUE)
        {
            HDMIRX_HAL_ClearT4Error(HDMIRX_CTRL_GetSubPort());
        }
        pstCtrlCtx->u32HdcpErrCnt++;

        if(u32CurPort < HI_UNF_HDMIRX_PORT_BUTT)
        {
            HDMI_INFO("[%s] : [u32BchErr = %d, u32HdcpErr = %d] : [%d]\n", 
            s_apsStateString[pstCtrlCtx->astPortStatus[u32CurPort].enState], 
            u32BchErrCnt, 
            u32HdcpErrCnt,
            pstCtrlCtx->u32HdcpErrCnt);
        }
           
        if(pstCtrlCtx->u32HdcpErrCnt > u32ERRCNT)
        {          
            pstCtrlCtx->u32HdcpErrCnt = 0;  
            pstCtrlCtx->astPortStatus[u32CurPort].u32HdcpStableCnt = 0;
            pstCtrlCtx->astPortStatus[u32CurPort].u32WaitCnt = 0;            
#if SUPPORT_MHL
            if((HDMIRX_MHL_GetCbusSense(HI_UNF_HDMIRX_PORT0) == HI_TRUE)&&(HDMIRX_CTRL_GetCurPort() == HI_UNF_HDMIRX_PORT0))
            {
                HDMI_WARN("------> Reset MHL HDCP...... \n");
                /*
                HDMIRX_INPUT_SetHpdManual(u32CurPort, HI_FALSE);
                HDMIRX_MHL_OnOff(HI_FALSE);
                msleep(HDMIRX_HDCP_M_RST_WAITMS);
                HDMIRX_MHL_OnOff(HI_TRUE);
                */
                HDMIRX_HAL_SetResetEn(HI_UNF_HDMIRX_PORT0, HDMIRX_HDMIM_RST, HI_TRUE);
                HDMIRX_CTRL_SetHdmirxRstReason(HDMIRX_RST_MHL);
            }
            else
#endif
            {        
                HDMI_WARN("------> Reset HDMI HDCP...... \n");
                
                HDMIRX_INPUT_SetHpdLv(u32CurPort, HI_FALSE);
                if(HDMIRX_CTRL_IsNeedSubPort() == HI_TRUE)
                {
                	HDMIRX_INPUT_SetHpdLv(HDMIRX_CTRL_GetSubPort(), HI_FALSE);
                }
                msleep(HDMIRX_HDCP_M_RST_WAITMS);
                HDMIRX_INPUT_SetHpdLv(u32CurPort, HI_TRUE);
                if(HDMIRX_CTRL_IsNeedSubPort() == HI_TRUE)
                {
                	HDMIRX_INPUT_SetHpdLv(HDMIRX_CTRL_GetSubPort(), HI_TRUE);
                }
            }           
            HDMIRX_CTRL_ModeChgAdd(HDMIRX_MODECHG_TYPE_HDCPERR);            
            HDMIRX_CTRL_ModeChange();
            HDMIRX_CTRL_ChangeState(HDMIRX_STATE_VIDEO_OFF); 

            return HI_TRUE;
        }
    }
    else
    {
        pstCtrlCtx->u32HdcpErrCnt = 0;   
    }

    return HI_FALSE;
}

HI_BOOL HDMIRX_CTRL_IsNeed2beDone(HI_VOID)
{
    HDMIRX_CTRL_CONTEXT_S *pstCtrlCtx;

    pstCtrlCtx = HDMIRX_CTRL_GET_CTX();
    if(pstCtrlCtx->astPortStatus[pstCtrlCtx->enCurPort].enState == HDMIRX_STATE_VIDEO_OFF)
    {
        return HI_FALSE;
    }

    return HI_TRUE;
}

HI_U32 HDMIRX_CTRL_GetShadowIntMask(HI_U32 u32Idx)
{
    if(u32Idx >= HDMIRX_INTR_BUTT)
    {
        return 0;
    }

    return au32ShadowIntMask[u32Idx];
}
HI_VOID HDMIRX_CTRL_SetShadowIntMask(HI_U32 u32Idx, HI_U32 u32Mask, HI_BOOL bEn)
{
    if(u32Idx >= HDMIRX_INTR_BUTT)
    {
        return;
    }
    
    if( HI_TRUE == bEn)
	{
        au32ShadowIntMask[u32Idx] |= u32Mask;
	}
	else
	{
        au32ShadowIntMask[u32Idx] &= ~u32Mask;
	}    
}
/*
------------------------------------------------------------------------------
 Function:    HDMIRX_CTRL_IsVideoOnState
 Description: To Check the fw state is in stable or not 
 Parameters:  None.
 Returns:     True for video stable..
------------------------------------------------------------------------------
*/
HI_BOOL HDMIRX_CTRL_IsVideoOnState(HI_VOID)
{
    HDMIRX_CTRL_CONTEXT_S *pstCtrlCtx;

    pstCtrlCtx = HDMIRX_CTRL_GET_CTX();
    if(pstCtrlCtx->astPortStatus[pstCtrlCtx->enCurPort].enState == HDMIRX_STATE_VIDEO_ON)
    {
        return HI_TRUE;
    }

    return HI_FALSE;
}

HI_VOID HDMIRX_CTRL_TryEQ(HI_BOOL bflag)
{
    static HI_U32 u32trycnt=0;
    HI_U32 u32Value,u32Tmp;
    HI_UNF_HDMIRX_PORT_E u32CurPort;
    u32CurPort = HDMIRX_CTRL_GetCurPort();
    if(bflag == HI_FALSE)
    {
       u32trycnt=0;
       return;
    }
    if((u32trycnt < 8)&&(u32CurPort < HI_UNF_HDMIRX_PORT_BUTT))
    {        
        u32trycnt++;        
        u32Value = HDMIRX_HAL_GetEQtable(u32CurPort,7);
        printk("###get EQ :0x%x \n",u32Value);
        u32Tmp = (u32Value & 0x70)>>4;
        if(u32Tmp >0)
        {
            u32Tmp--;
        }
        else
        {
            u32Tmp=0x7;
        }
        u32Value = (u32Value &0x8f)+ (u32Tmp << 4);
        HDMIRX_HAL_SetEQtable(u32CurPort,7,u32Value);
        printk("####set EQ :0x%x \n",u32Value);
        
    }
    else if((u32trycnt == 8)&&(u32CurPort < HI_UNF_HDMIRX_PORT_BUTT))
    {
        u32trycnt++;
        HDMIRX_HAL_SetEQtable(u32CurPort,7,0xA0);
    }
    
}

/*
------------------------------------------------------------------------------
 Function:    HDMIRX_CTRL_ChangeState
 Description: Switch to the desired state 
 Parameters:  eNewState: the new state of ctrl layer.
 Returns:     called by every state shift.
------------------------------------------------------------------------------
*/
HI_VOID HDMIRX_CTRL_ChangeState(HDMIRX_CTRL_STATE_E eNewState)
{
    HDMIRX_CTRL_CONTEXT_S *pstCtrlCtx;

    pstCtrlCtx = HDMIRX_CTRL_GET_CTX();
    
	pstCtrlCtx->astPortStatus[pstCtrlCtx->enCurPort].enState = eNewState;
   
}
#if 0
static HI_VOID HDMIRX_CTRL_ModeChangeDone(HI_VOID)
{
    HDMIRX_CTRL_CONTEXT_S *pstCtrlCtx;

    pstCtrlCtx = HDMIRX_CTRL_GET_CTX();
    
	pstCtrlCtx->bModeChangeDone = HI_TRUE;
}
#endif
#if 1
HI_VOID HDMIRX_CTRL_ModeChange(HI_VOID)
{
    HDMIRX_CTRL_CONTEXT_S *pstCtrlCtx;

    pstCtrlCtx = HDMIRX_CTRL_GET_CTX();
    pstCtrlCtx->bModeChange = HI_TRUE;
	pstCtrlCtx->astPortStatus[pstCtrlCtx->enCurPort].u32WaitCnt = 0;

    if(HDMIRX_HAL_GetScdt(pstCtrlCtx->enCurPort) == HI_FALSE)
    {
        HDMIRX_VIDEO_SetVideoIdx(TIMING_NOSIGNAL);
    }
    HDMIRX_HAL_SetMuteEn(pstCtrlCtx->enCurPort,HDMIRX_MUTE_ALL, HI_TRUE);
    if(HDMIRX_CTRL_IsNeedSubPort() == HI_TRUE)
    {
        HDMIRX_HAL_SetMuteEn(HDMIRX_CTRL_GetSubPort(),HDMIRX_MUTE_ALL, HI_TRUE);
    }
    HDMIRX_AUDIO_Initial();
    HDMIRX_AUDIO_AssertOff(pstCtrlCtx->enCurPort);
    pstCtrlCtx->u32NoSyncCnt = 0;
    //pstCtrlCtx->astPortStatus[pstCtrlCtx->enCurPort].u32WaitTimeOut = 0;
}
#endif
/*
------------------------------------------------------------------------------
 Function:      HDMIRX_CTRL_CkdtProc
 Description:   the proc if ckdt
 Parameters:    None.
 Returns:       None.
 Note:          1. called if 
------------------------------------------------------------------------------
*/
static HI_BOOL HDMIRX_CTRL_CkdtProc(HI_UNF_HDMIRX_PORT_E enPort)
{
    HI_BOOL bCkdt;

    bCkdt = HDMIRX_HAL_GetCkdt(enPort);
    if(bCkdt == HI_TRUE) 
    {       
        // reset dc fifo
        HDMIRX_HAL_SetResetEn(enPort,HDMIRX_DC_FIFO_RST,HI_TRUE);
        udelay(10);
        HDMIRX_HAL_SetResetEn(enPort,HDMIRX_DC_FIFO_RST,HI_FALSE);
        // mute the video
        HDMIRX_HAL_SetMuteEn(enPort,HDMIRX_MUTE_VDO, HI_TRUE);
        // clear scdt int
        HDMIRX_HAL_ClearInterrupt(enPort,HDMIRX_INT_SCDT);
        
        HDMIRX_VIDEO_RstTimingData();
        
        HDMIRX_HAL_SetAutoRstEn(enPort,HDMIRX_AUTORST_HDCP, HI_FALSE);

        if(HDMIRX_CTRL_IsNeedSubPort() == HI_TRUE)
        {
            // reset dc fifo
            HDMIRX_HAL_SetResetEn(enPort,HDMIRX_DC_FIFO_RST,HI_TRUE);
            udelay(10);
            HDMIRX_HAL_SetResetEn(enPort,HDMIRX_DC_FIFO_RST,HI_FALSE);
            // mute the video
            HDMIRX_HAL_SetMuteEn(enPort,HDMIRX_MUTE_VDO, HI_TRUE);
            // clear scdt int
            HDMIRX_HAL_ClearInterrupt(enPort,HDMIRX_INT_SCDT);
            
            HDMIRX_HAL_SetAutoRstEn(enPort,HDMIRX_AUTORST_HDCP, HI_FALSE);

        }
        return HI_TRUE;    

    }
    return HI_FALSE;
}
/* 
-----------------------------------------------------------------------------
    Function:    	HDMIRX_CTRL_InterruptInitial
    Description: 	To reset all isr struct and turn on int
    Parameters:  	none
    Returns:    	none
    NOTE: 		1. reset all the isr struct member to zero.
          			2. initial int mask.
          			3. receive all packets.
-----------------------------------------------------------------------------
*/
static HI_VOID HDMIRX_CTRL_InterruptInitial(HI_VOID)
{
	memcpy(au32ShadowIntMask, InterruptMask, sizeof(au32ShadowIntMask));
}

/*
------------------------------------------------------------------------------
 Function:      HDMIRX_CTRL_Resume
 Description:   Initialize the sofware var.
 Parameters:    pstCtrlCtx: the point of context in control layer.
 Returns:       None.
 Note:          1. called once if the mode change.
------------------------------------------------------------------------------
*/
static HI_VOID HDMIRX_CTRL_Resume(HI_VOID)
{
    HDMIRX_CTRL_CONTEXT_S *pstCtrlCtx;
    
    pstCtrlCtx = HDMIRX_CTRL_GET_CTX();
    HDMIRX_HAL_SetMuteEn(pstCtrlCtx->enCurPort,HDMIRX_MUTE_ALL, HI_TRUE);
    if(HDMIRX_CTRL_IsNeedSubPort() == HI_TRUE)
    {
        HDMIRX_HAL_SetMuteEn(HDMIRX_CTRL_GetSubPort(),HDMIRX_MUTE_ALL, HI_TRUE);
    }
    HDMIRX_PACKET_Initial(); 
    HDMIRX_CTRL_InterruptInitial();
    HDMIRX_AUDIO_Initial();
    HDMIRX_VIDEO_TimingDataInit();
    HDMIRX_AUDIO_AssertOff(pstCtrlCtx->enCurPort);
    HDMIRX_HAL_SetResetEn(pstCtrlCtx->enCurPort,HDMIRX_SOFT_RST,HI_TRUE);
    if(HDMIRX_CTRL_IsNeedSubPort() == HI_TRUE)
    {
        HDMIRX_HAL_SetResetEn(HDMIRX_CTRL_GetSubPort(),HDMIRX_SOFT_RST,HI_TRUE);
    }
    udelay(40);
    HDMIRX_HAL_SetResetEn(pstCtrlCtx->enCurPort,HDMIRX_SOFT_RST,HI_FALSE);
    if(HDMIRX_CTRL_IsNeedSubPort() == HI_TRUE)
    {
        HDMIRX_HAL_SetResetEn(HDMIRX_CTRL_GetSubPort(),HDMIRX_SOFT_RST,HI_FALSE);
    }
	// Fw initial -->
    pstCtrlCtx->u32NoSyncCnt = 0;
    //pstCtrlCtx->astPortStatus[pstCtrlCtx->enCurPort].u32WaitTimeOut = 0;
	// <--
}
/*
------------------------------------------------------------------------------
 Function:      HDMIRX_CTRL_WaitStableProc
 Description:   The process of the wait stable state.
 Parameters:    pstCtrlCtx: the context of control
 Returns:       None.
 Note:          1. called if signal change or switch port.
------------------------------------------------------------------------------
*/
static HI_VOID HDMIRX_CTRL_WaitStableProc(HI_UNF_HDMIRX_PORT_E enPort)
{
    HI_U32 u32CurPort;
    HI_BOOL bScdt;
    HI_BOOL bHdcpStable;
    HI_BOOL bStable;
    HI_BOOL bSupport;
    HI_BOOL bPwr5v;
    static HI_U32 u32Curnt=0;

//    HI_BOOL bIsMHL = HI_FALSE;
    HDMIRX_CTRL_CONTEXT_S *pstCtrlCtx;
        
    pstCtrlCtx = HDMIRX_CTRL_GET_CTX();
    u32CurPort = pstCtrlCtx->enCurPort;
    if(u32CurPort >= HI_UNF_HDMIRX_PORT_BUTT)
    {
        return;
    }
    // the current port process
	pstCtrlCtx->astPortStatus[u32CurPort].u32WaitCnt++;
    HDMIRX_CTRL_UpdateSubPortStatus();
    bPwr5v = HDMIRX_HAL_GetPwr5vStatus(pstCtrlCtx->enCurPort);
    if(bPwr5v == HI_FALSE)
    {       
        pstCtrlCtx->u32NoSyncCnt = 0;
        pstCtrlCtx->au8Pwr5v[pstCtrlCtx->enCurPort] = 0;
#if SUPPORT_HPD_ACTION        
        HDMIRX_HAL_SetEdidDdcEn(pstCtrlCtx->enCurPort,HI_FALSE);
        HDMIRX_HAL_SetHdcpDdcEn(pstCtrlCtx->enCurPort,HI_FALSE);
        HDMIRX_HAL_SetTermMode(pstCtrlCtx->enCurPort ,HDMIRX_TERM_SEL_OPEN);     
        msleep(40);
        HDMIRX_INPUT_SetHpdLv(pstCtrlCtx->enCurPort, HI_FALSE);
        if(HDMIRX_CTRL_IsNeedSubPort() == HI_TRUE)
        {
        	HDMIRX_INPUT_SetHpdLv(HDMIRX_CTRL_GetSubPort(), HI_FALSE);
        }
        printk("\n port=%d hpd is low. \n", pstCtrlCtx->enCurPort);
#endif        
		HDMIRX_CTRL_ChangeState(HDMIRX_STATE_VIDEO_OFF);
        return;        
    }
    else
	{
		if(pstCtrlCtx->astPortStatus[u32CurPort].u32WaitCnt >= \
            HDMIRX_WAIT_TIMEOUT)
        {
           	pstCtrlCtx->astPortStatus[u32CurPort].u32WaitCnt = \
                HDMIRX_WAIT_TIMEOUT;
            pstCtrlCtx->bModeChange = HI_FALSE;
        }
        
        if(pstCtrlCtx->bHdcpCheckEn == HI_TRUE &&
       (HDMIRX_CTRL_HdcpErrCheck(20) == HI_TRUE))
        {
            printk("+++++++HDCP ERR In Wait!+++++\n");
            return;
        }
        
		// check no signal -->
		bScdt = HDMIRX_HAL_GetScdt(enPort);
        if (bScdt == HI_FALSE) 
    	{ 
            pstCtrlCtx->u32NoSyncCnt++;
            pstCtrlCtx->astPortStatus[u32CurPort].u32WaitCnt = 0;
        	if(pstCtrlCtx->u32NoSyncCnt == HDMIRX_NO_SIGNAL_THR) 
        	{
                pstCtrlCtx->u32NoSyncCnt = 0;
            	HDMIRX_CTRL_ChangeState(HDMIRX_STATE_VIDEO_OFF);
        	} 
    	}
        // <--
    	else 
    	{	

            pstCtrlCtx->u32NoSyncCnt = 0;
            HDMIRX_VIDEO_HdmiDviTrans(enPort);
            HDMIRX_VIDEO_SetDeepColorMode(enPort);
			// use hdcp to check stable -->
        	bHdcpStable = HDMIRX_HAL_GetHdcpDone(u32CurPort);
        	if(bHdcpStable == HI_TRUE) 
        	{
                pstCtrlCtx->astPortStatus[u32CurPort].u32HdcpStableCnt++;
            	if (pstCtrlCtx->astPortStatus[u32CurPort].u32HdcpStableCnt >= \
                    HDMIRX_HDCP_STABLE_THR) 
            	{   
                	pstCtrlCtx->astPortStatus[u32CurPort].u32HdcpStableCnt = \
                        HDMIRX_HDCP_STABLE_THR;
					
            	}
        	}
        	else 
        	{
            	pstCtrlCtx->astPortStatus[u32CurPort].u32HdcpStableCnt = 0;
        	} 
            // <--
			// hdcp stable case -->
        	if((pstCtrlCtx->astPortStatus[u32CurPort].u32HdcpStableCnt == \
				HDMIRX_HDCP_STABLE_THR) || \
				(pstCtrlCtx->astPortStatus[u32CurPort].u32WaitCnt > 80))
        	{
            	bStable = HDMIRX_VIDEO_CheckStable(enPort);                
            	if (bStable == HI_TRUE) 
            	{
					if(pstCtrlCtx->astPortStatus[u32CurPort].u32WaitCnt == HDMIRX_WAIT_TIMEOUT)
					{
                        HDMIRX_CTRL_ModeChgAdd(HDMIRX_MODECHG_TYPE_WAITOUT);
                        HDMIRX_CTRL_ModeChange();
						pstCtrlCtx->astPortStatus[u32CurPort].u32WaitCnt = 60;
						return;
					}
                    HDMIRX_CTRL_UpdateSubPortStatus();
					HDMIRX_VIDEO_ModeDet(enPort);
                    bSupport = HDMIRX_VIDEO_IsSupport();
        			if(bSupport == HI_TRUE)
        			{
                        HDMIRX_VIDEO_SetVideoPath(enPort);
            			HDMIRX_VIDEO_SetDeepColorMode(enPort);
            			HDMIRX_HAL_SetMuteEn(enPort,HDMIRX_MUTE_VDO, HI_FALSE);
                        if(HDMIRX_CTRL_IsNeedSubPort() == HI_TRUE)
                        {
                            HDMIRX_HAL_SetMuteEn(HDMIRX_CTRL_GetSubPort(),HDMIRX_MUTE_VDO, HI_FALSE);
                        }
            			if (HDMIRX_VIDEO_GetHdmiMode(enPort) == HI_TRUE) 
            			{
							if(HDMIRX_AUDIO_IsRequest() == HI_FALSE)
							{
								HDMIRX_AUDIO_Restart(enPort);
							}
            			}
            			else 
            			{
                			HDMIRX_AUDIO_Stop(enPort);
            			}
        			}
        			else 
        			{
                        HDMIRX_HAL_SetMuteEn(enPort,HDMIRX_MUTE_VDO, HI_TRUE);
                        if(HDMIRX_CTRL_IsNeedSubPort() == HI_TRUE)
                        {
                            HDMIRX_HAL_SetMuteEn(HDMIRX_CTRL_GetSubPort(),HDMIRX_MUTE_VDO, HI_TRUE);
                        }
            			HDMIRX_AUDIO_Stop(enPort);
        			}

                 //   HDMIRX_HAL_ClearAvMute(HI_TRUE);
                    msleep(50);
                    if((HDMIRX_PACKET_AVI_IsDataValid() == HI_FALSE)&&(HDMIRX_VIDEO_GetHdmiMode(enPort)== HI_TRUE))
                    {                      
                       // msleep(500);
                        u32Curnt++;
                        if(u32Curnt > 50)
                        {
                            printk("Can not get AVI,Wait 500ms...\n");
                            u32Curnt = 0;
                            HDMIRX_CTRL_ChangeState(HDMIRX_STATE_VIDEO_ON);
                        }
                    }
                    else
                    {
                        u32Curnt = 0;
                        HDMIRX_CTRL_ChangeState(HDMIRX_STATE_VIDEO_ON);
                    }
        			

            	}
        	}	
    	}
	}
}

/*
------------------------------------------------------------------------------
 Function:      HDMIRX_CTRL_NoSignalProc
 Description:   The process while no signal.
 Parameters:    None.
 Returns:       None.
 Note:          1. called if no signal
------------------------------------------------------------------------------
*/
static HI_VOID HDMIRX_CTRL_NoSignalProc(HI_UNF_HDMIRX_PORT_E enPort)
{
#if !SUPPORT_PORT0_ONLY
    HI_BOOL bHdcpStable;
#endif
    static HI_BOOL bCkdt = HI_FALSE;
    static HI_BOOL bScdt = HI_FALSE;

    HI_BOOL bPwr5v;
    
    HDMIRX_CTRL_CONTEXT_S *pstCtrlCtx;
        
    pstCtrlCtx = HDMIRX_CTRL_GET_CTX();
    HDMIRX_CTRL_UpdateSubPortStatus();    
    //-------------------------------------------
    if(pstCtrlCtx->enCurPort == pstCtrlCtx->enLoopPort)
    {
        bPwr5v = HDMIRX_HAL_GetPwr5vStatus(pstCtrlCtx->enLoopPort);
        if(bPwr5v == HI_FALSE)
        {
            pstCtrlCtx->u8Pwr5vCnt = 0;
            pstCtrlCtx->au8Pwr5v[pstCtrlCtx->enCurPort] = 0;
            return;
        }
        else if(
            #if SUPPORT_MHL
            ((HDMIRX_HAL_GetCbusSense(HI_UNF_HDMIRX_PORT0) == HI_FALSE)&&(pstCtrlCtx->enCurPort == HI_UNF_HDMIRX_PORT0)) || 
            #endif
            (pstCtrlCtx->enCurPort != HI_UNF_HDMIRX_PORT0))
        {
            if(pstCtrlCtx->au8Pwr5v[pstCtrlCtx->enCurPort] != (HI_U8)bPwr5v)
            {
                pstCtrlCtx->u8Pwr5vCnt = 1;
                //HDMIRX_HAL_SetEdidDdcEn(pstCtrlCtx->enCurPort,HI_FALSE);
                //HDMIRX_HAL_SetHdcpDdcEn(pstCtrlCtx->enCurPort,HI_FALSE);
                //msleep(20);
                //HDMIRX_HAL_SetTermMode(pstCtrlCtx->enCurPort ,HDMIRX_TERM_SEL_OPEN);
                
                //msleep(80);
                //HDMIRX_INPUT_SetHpdLv(pstCtrlCtx->enCurPort, HI_FALSE);
                /*
                if(HDMIRX_CTRL_IsNeedSubPort() == HI_TRUE)
                {
                    HDMIRX_INPUT_SetHpdLv(HDMIRX_CTRL_GetSubPort(), HI_FALSE);
                }*/
                pstCtrlCtx->au8Pwr5v[pstCtrlCtx->enCurPort] = 1;
                printk("\n current port hpd is low. \n");
                return;
            }
            else if(pstCtrlCtx->u8Pwr5vCnt > 0)
            {
                pstCtrlCtx->u8Pwr5vCnt++;
                if(pstCtrlCtx->u8Pwr5vCnt >= 10)
                {
#if SUPPORT_HPD_ACTION
                    HDMIRX_HAL_SetTermMode(pstCtrlCtx->enCurPort ,HDMIRX_TERM_SEL_HDMI);
                    HDMIRX_HAL_SetEdidDdcEn(pstCtrlCtx->enCurPort,HI_TRUE);
                    msleep(20);
                    HDMIRX_HAL_SetHdcpDdcEn(pstCtrlCtx->enCurPort,HI_TRUE);
                    msleep(80);
                    HDMIRX_INPUT_SetHpdLv(pstCtrlCtx->enCurPort, HI_TRUE);
                    if(HDMIRX_CTRL_IsNeedSubPort() == HI_TRUE)
                    {
                        HDMIRX_INPUT_SetHpdLv(HDMIRX_CTRL_GetSubPort(), HI_TRUE);
                    }
                    printk("\n current port hpd is high. \n");
                    msleep(40);
#endif
                    bCkdt = HI_FALSE;
                    pstCtrlCtx->u8Pwr5vCnt = 0;
                }
                else
                {
                    return;
                }
            }
        }
        if((HDMIRX_HAL_GetCbusSense(HI_UNF_HDMIRX_PORT0) == HI_TRUE)&&(pstCtrlCtx->enCurPort == HI_UNF_HDMIRX_PORT0))
        {
            bScdt = HI_TRUE;
        }
        else
        {
            bScdt = HDMIRX_HAL_GetScdt(enPort);
        }
        if(bCkdt == HI_FALSE)
		{
            bCkdt = HDMIRX_CTRL_CkdtProc(enPort);
		}      
        if((bCkdt == HI_TRUE)&&(bScdt == HI_TRUE))
        {
            bCkdt = HI_FALSE;
            pstCtrlCtx->u32NoSyncCnt = 0;
            HDMIRX_CTRL_Resume();
            HDMIRX_CTRL_ModeChgAdd(HDMIRX_MODECHG_TYPE_CKDT);
			HDMIRX_CTRL_ModeChange();
			HDMIRX_CTRL_ChangeState(HDMIRX_STATE_WAIT);
        } 

    }
    //-----------------other port-------------------
#if !SUPPORT_PORT0_ONLY
    else 
    {
        bPwr5v = HDMIRX_HAL_GetPwr5vStatus(pstCtrlCtx->enLoopPort);
        if(bPwr5v == HI_TRUE)
        {
            pstCtrlCtx->au8Pwr5v[pstCtrlCtx->enLoopPort] = 1;
            bHdcpStable = HDMIRX_HAL_GetHdcpDone(pstCtrlCtx->enLoopPort);
    		
            if (bHdcpStable == HI_TRUE) 
            {
                pstCtrlCtx->astPortStatus[pstCtrlCtx->enLoopPort].u32HdcpStableCnt++;
                if(pstCtrlCtx->astPortStatus[pstCtrlCtx->enLoopPort].u32HdcpStableCnt \
                    >= HDMIRX_HDCP_STABLE_THR) 
                {   
                    pstCtrlCtx->astPortStatus[pstCtrlCtx->enLoopPort].u32HdcpStableCnt \
                        = HDMIRX_HDCP_STABLE_THR;
                }
             }
             else 
             {
                pstCtrlCtx->astPortStatus[pstCtrlCtx->enLoopPort].u32HdcpStableCnt = 0;
             }
        }
        else
        {
            pstCtrlCtx->au8Pwr5v[pstCtrlCtx->enLoopPort] = 0;
        }
    }
#endif
}
/*
------------------------------------------------------------------------------
 Function:      HDMIRX_CTRL_VideoOnProc
 Description:   The process of video on.
 Parameters:    None.
 Returns:       None.
 Note:          1. called if video on.
------------------------------------------------------------------------------
*/
static HI_VOID HDMIRX_CTRL_VideoOnProc(HI_UNF_HDMIRX_PORT_E enPort)
{
    HI_BOOL bScdt;
    HI_BOOL bPwr5v;
    HI_U32  u32ModeChgType;
    HDMIRX_CTRL_CONTEXT_S *pstCtrlCtx;
        
    pstCtrlCtx = HDMIRX_CTRL_GET_CTX();
    HDMIRX_CTRL_UpdateSubPortStatus();
    bPwr5v = HDMIRX_HAL_GetPwr5vStatus(pstCtrlCtx->enCurPort);
    if(bPwr5v == HI_FALSE)
    {
        pstCtrlCtx->u32NoSyncCnt = 0;
        HDMIRX_CTRL_ModeChgAdd(HDMIRX_MODECHG_TYPE_NOPOW);
		HDMIRX_CTRL_ModeChange();
        printk("state On :cannot get pwr5v\n");
		HDMIRX_CTRL_ChangeState(HDMIRX_STATE_WAIT);
        return;
    }
    
    if(pstCtrlCtx->bHdcpCheckEn == HI_TRUE &&
       (HDMIRX_CTRL_HdcpErrCheck(HDMIRX_HDCP_ERR_CNT_THR) == HI_TRUE))
    {
        printk("HDCP check ERRO!\n");
        return;
    }
    bScdt = HDMIRX_HAL_GetScdt(enPort) ;

    if (bScdt == HI_FALSE)
    {
        pstCtrlCtx->u32NoSyncCnt++;
        HDMIRX_HAL_ClearAvMute(enPort,HI_FALSE);
        if(HDMIRX_CTRL_IsNeedSubPort() == HI_TRUE)
        {
            HDMIRX_HAL_ClearAvMute(HDMIRX_CTRL_GetSubPort(),HI_FALSE);
        }
        if (pstCtrlCtx->u32NoSyncCnt >= NO_SIGNAL_THR_IN_VIDEO_ON) 
        {
            pstCtrlCtx->u32NoSyncCnt = 0;
            HDMIRX_CTRL_ModeChgAdd(HDMIRX_MODECHG_TYPE_NOSCDT);
			HDMIRX_CTRL_ModeChange();
            printk("state On :cannot get Scdt\n");
			HDMIRX_CTRL_ChangeState(HDMIRX_STATE_WAIT);
            return;
        }    
    }
    else         
    {     
   	    pstCtrlCtx->u32NoSyncCnt = 0;
        // check mode change 
        u32ModeChgType = HDMIRX_VIDEO_GetModeChgType(enPort);
        if(HDMIRX_VIDEO_IsNeedModeChange(enPort,u32ModeChgType) == HI_TRUE)
        {
			HDMIRX_CTRL_ChangeState(HDMIRX_STATE_WAIT);
        //    HDMIRX_HAL_ClearAvMute(HI_FALSE);
            HDMIRX_HAL_SetMuteEn(enPort,HDMIRX_MUTE_VDO, HI_TRUE);
            if(HDMIRX_CTRL_IsNeedSubPort() == HI_TRUE)
            {
                HDMIRX_HAL_SetMuteEn(HDMIRX_CTRL_GetSubPort(),HDMIRX_MUTE_VDO, HI_TRUE);
            }
            printk("state On :cannot get ModeChange\n");
            HDMIRX_CTRL_ModeChgAdd(HDMIRX_MODECHG_TYPE_TIMINGCHG);
			HDMIRX_CTRL_ModeChange();
			
        }
        
    }
}
/*
------------------------------------------------------------------------------
 Function:      HDMIRX_CTRL_State
 Description:   the main proc of hdmi video
 Parameters:    None.
 Returns:       None.
 Note:          1. called every 10ms
------------------------------------------------------------------------------
*/
static HI_VOID HDMIRX_CTRL_State(HDMIRX_CTRL_CONTEXT_S *pstCtrlCtx)
{    
    static HI_U32 u32Power = 0;
   // HI_U32 u32BchErrCnt,u32HdcpErrCnt;
    HI_UNF_HDMIRX_PORT_E tmp_port;
    HI_BOOL portPowerStat; 
    for (pstCtrlCtx->enLoopPort = pstCtrlCtx->enStartPort; 
    pstCtrlCtx->enLoopPort <= pstCtrlCtx->enEndPort; pstCtrlCtx->enLoopPort++)
    {
        if (pstCtrlCtx->astPortStatus[pstCtrlCtx->enLoopPort].enLastState != \
            pstCtrlCtx->astPortStatus[pstCtrlCtx->enLoopPort].enState) 
        {
		    pstCtrlCtx->astPortStatus[pstCtrlCtx->enLoopPort].enLastState = \
                pstCtrlCtx->astPortStatus[pstCtrlCtx->enLoopPort].enState;
		    printk("=======enloopPort =%d ========enState=%d :===========\n", \
                pstCtrlCtx->enLoopPort, pstCtrlCtx->astPortStatus[pstCtrlCtx->enLoopPort].enState);
        }
        //-------------------------------------------------------------------
        tmp_port = pstCtrlCtx->enLoopPort;
        portPowerStat = (u32Power & (1 << (tmp_port - HI_UNF_HDMIRX_PORT0)))>0 ? HI_TRUE : HI_FALSE;
        if(HDMIRX_HAL_GetPwr5vStatus(tmp_port) != portPowerStat)
        {
            if(HDMIRX_HAL_GetPwr5vStatus(tmp_port))
            {
                HDMIRX_HAL_SetPdSysEn(tmp_port, HI_TRUE);
                u32Power |= (1 << (tmp_port - HI_UNF_HDMIRX_PORT0));
            }
            else
            {
                HDMIRX_HAL_SetPdSysEn(tmp_port, HI_FALSE);
                u32Power &= (~(1 << (tmp_port - HI_UNF_HDMIRX_PORT0)));
            }
        }
        //---------------------------------------------------------------------------------
        switch(pstCtrlCtx->astPortStatus[pstCtrlCtx->enLoopPort].enState) 
        {
         case HDMIRX_STATE_WAIT:
            HDMIRX_CTRL_WaitStableProc(pstCtrlCtx->enLoopPort);
            break;
            
         case HDMIRX_STATE_VIDEO_OFF:
            HDMIRX_CTRL_NoSignalProc(pstCtrlCtx->enLoopPort);
            break;
            
          case HDMIRX_STATE_VIDEO_ON:
            HDMIRX_CTRL_VideoOnProc(pstCtrlCtx->enLoopPort);
            break;
			
        default:
            break;
        }
        /*
        u32BchErrCnt = HDMIRX_HAL_GetBchErrCnt(pstCtrlCtx->enLoopPort);
        u32HdcpErrCnt = HDMIRX_HAL_GetHdcpErrCnt(pstCtrlCtx->enLoopPort);
        if(u32BchErrCnt && u32HdcpErrCnt)
        {
            printk("######port %d HDCP ERRO!\n",pstCtrlCtx->enLoopPort);
        }
        */
    }
}

static HI_VOID HDMIRX_CTRL_IsrHandler(HI_UNF_HDMIRX_PORT_E enPort)
{
    HI_U32      au32Interrupts[HDMIRX_INTR_BUTT];
    HI_BOOL     bNoAvi;
    HI_U32      i;
	HI_BOOL 	bInt;
    HDMIRX_CTRL_CONTEXT_S *pstCtrlCtx;
        
    pstCtrlCtx = HDMIRX_CTRL_GET_CTX(); 
    if(pstCtrlCtx->astPortStatus[pstCtrlCtx->enCurPort].enState 
        == HDMIRX_STATE_VIDEO_OFF)
    {
        return ;
    }
	
	bInt = HDMIRX_HAL_IsInterrupt(enPort);
    if(bInt == HI_TRUE) 
    {
       
        // get interrupt requests
        HDMIRX_HAL_GetInterruptSta(enPort,au32Interrupts);
		// clear interrupt requests
       // HDMIRX_HAL_SetInterruptSta(enPort,au32Interrupts); 
        // do not touch interrupts which are masked out
        i = HDMIRX_INTR1;
        do 
        {
           //printk("#####get Inter[%d]:%x\n",i,au32Interrupts[i]); 
           au32Interrupts[i] &= au32ShadowIntMask[i];
      //     if((au32Interrupts[i] >0) && (i !=2 ))
      //     {
      //      printk("au32Interrupts[%d]:0x%x\n",i,au32Interrupts[i]); 
      //     }
           i++;
        }while(i < HDMIRX_INTR_BUTT);
        
        // clear interrupt requests
        HDMIRX_HAL_SetInterruptSta(enPort,au32Interrupts);
        
        if(au32Interrupts[HDMIRX_INTR5] & intr_audio_muted) 
        {
          //  HDMIRX_AUDIO_AacDone(enPort);
        }
        
        #if SUPPORT_DSD
        if (au32Interrupts[HDMIRX_INTR6] & intr_dsd_on) 
		{
            HDMIRX_AUDIO_StreamTypeChanged(enPort);
        }
		else
		#endif
		#if SUPPORT_HBR
		if(au32Interrupts[HDMIRX_INTR6] & intr_hbra_on)
		{
            HDMIRX_AUDIO_StreamTypeChanged(enPort);
		}
		#endif
        if((au32Interrupts[HDMIRX_INTR5] & intr_aud_sample_f) || \
            (au32Interrupts[HDMIRX_INTR6] & intr_chst_ready))
		{
			// Note: INTR6__CHST_READY interrupt may be disabled
			HDMIRX_AUDIO_OnChannelStatusChg(enPort);
		}
        #if 0
        if (au32Interrupts[HDMIRX_INTR2_AON] & intr_scdt) 
        {
            
           // HDMIRX_HAL_SetMuteEn(HDMIRX_MUTE_VDO, HI_TRUE);


			// Following line is a remedy for incomplaint sources
			// which do not keep the minimum 100ms off time
			// and start transmitting encrypted data before authentication.
			// Since the deep color packets are encrypted,
			// RX chip is not able receiving even H/V syncs
			// and detect resolution if it is set for wrong deep color mode.
           // printk("inter-----Scdt\n");
            HDMIRX_HAL_ClearAvMute(HI_FALSE);
            HDMIRX_VIDEO_SetDeepColorMode();
            //HDMIRX_VIDEO_HdmiDviTrans();
          //  HDMIRX_AUDIO_Stop();
        }
        
        if (au32Interrupts[HDMIRX_INTR2] & intr_hdmi_mode) 
		{
            printk("inter-----hdmi_mode\n");
            HDMIRX_VIDEO_HdmiDviTrans();
        }
        #endif
        if (HDMIRX_VIDEO_GetHdmiMode(enPort) == HI_TRUE) 
		{
            bNoAvi = (au32Interrupts[HDMIRX_INTR4] & intr_no_avi) ? HI_TRUE : HI_FALSE;
            if(bNoAvi) 
            {
				if(au32Interrupts[HDMIRX_INTR3] & intr_new_avi) 
				{
                	// controversial info: both AVI and NO AVI bits are set, try to resolve the conflict
					if(0 != HDMIRX_HAL_GetAviType(enPort)) // check if AVI header is valid
					{
                        bNoAvi = HI_FALSE;  // decision: AVI bit is correct
					}
					else
					{
						au32Interrupts[HDMIRX_INTR3] &= ~intr_new_avi; // decision: NO AVI bit is correct
					}
                }
            }
            if(bNoAvi) 
			{
                HDMIRX_PACKET_AVI_SetNoAviIntEn(enPort,HI_FALSE);
                if(HDMIRX_CTRL_IsNeedSubPort() == HI_TRUE)
                {
                    HDMIRX_PACKET_AVI_SetNoAviIntEn(HDMIRX_CTRL_GetSubPort(),HI_FALSE);
                }
				HDMIRX_PACKET_AVI_NoAviHandler();
                pstCtrlCtx->bNoAvi = HI_TRUE;
            }
            else 
            {
                if (au32Interrupts[HDMIRX_INTR3] & intr_new_avi) 
                {
                    HDMIRX_PACKET_AVI_SetNoAviIntEn(enPort,HI_TRUE);
                    if(HDMIRX_CTRL_IsNeedSubPort() == HI_TRUE)
                    {
                        HDMIRX_PACKET_AVI_SetNoAviIntEn(HDMIRX_CTRL_GetSubPort(),HI_TRUE);
                    }
                }
                pstCtrlCtx->bNoAvi = HI_FALSE;
            }
            if(au32Interrupts[HDMIRX_INTR3] & INTR3_SERVING_PACKETS_MASK) 
            {
                HDMIRX_PACKET_InterruptHandler(enPort,au32Interrupts[HDMIRX_INTR3]);
            }
			#if SUPPORT_ACP
            if(au32Interrupts[HDMIRX_INTR6] & intr_new_acp) 
            {
                HDMIRX_PACKET_AcpIntHandler(enPort);
            }
			#endif
			#if 0//SUPPORT_CP_MUTE
            if(au32Interrupts[HDMIRX_INTR3] & intr_cp_set_mute) 
            {
                HDMIRX_PACKET_CpHandler(enPort);
                // Clear the interrupt request if it was set since the beginning of this function.
			    // It reduces CPU load by excluding excessive interrupting.
                HDMIRX_HAL_ClearInterrupt(enPort,HDMIRX_INT_CP);
            }
			#endif
        }
    }
}

static HI_S32 HDMIRX_Ctrl_MainTask(HI_VOID *pvData)
{
    HDMIRX_CTRL_CONTEXT_S *pstCtrlCtx;
#if SUPPORT_MHL
    static HI_U32 u32MHLCnt=0;
#endif
    pstCtrlCtx = HDMIRX_CTRL_GET_CTX();
    while (1)
    {
        if (kthread_should_stop()) 
        {
            HDMIRX_DRV_CTRL_CtxUnlock();
            break;
        }
        
        HDMIRX_DRV_CTRL_CtxLock();
        if (HI_TRUE == pstCtrlCtx->bRun) 
        {
            HDMIRX_CTRL_State(pstCtrlCtx);
            HDMIRX_CTRL_UpdateSubPortStatus();
            HDMIRX_CTRL_IsrHandler(pstCtrlCtx->enCurPort);
            HDMIRX_PACKET_MainThread(pstCtrlCtx->enCurPort);
            HDMIRX_AUDIO_MainLoop(pstCtrlCtx->enCurPort);
            #if SUPPORT_MHL
            if(u32MHLCnt >0)
            {
            HDMIRX_MHL_MainHandler(HI_UNF_HDMIRX_PORT0);
			HDMIRX_MHL_CbusIsr(HI_UNF_HDMIRX_PORT0);
            u32MHLCnt=0;
            }
            u32MHLCnt++;
            #endif
            HDMIRX_CTRL_HdmirxRstChg();           
        }
        
        HDMIRX_DRV_CTRL_CtxUnlock();
        msleep(10);
    }

    return 0;
}

HI_U32 HDMIRX_DRV_CTRL_GetDataRoute(HI_VOID)
{
    // TODO:
    HDMIRX_CTRL_CONTEXT_S *pstCtrlCtx;
    pstCtrlCtx = HDMIRX_CTRL_GET_CTX();
    if(pstCtrlCtx->enCurPort == HI_UNF_HDMIRX_PORT0)
    {
#if SUPPORT_DOUBLE_CTRL    
        return HI_DRV_HDMIRX_DATA_ROUTE_CTRL1;
#else
        return HI_DRV_HDMIRX_DATA_ROUTE_CTRL0;
#endif
    }
    else
    {
        return HI_DRV_HDMIRX_DATA_ROUTE_CTRL0;
    }
    
}

static HI_VOID HDMIRX_Ctrl_CtxInit(HDMIRX_CTRL_CONTEXT_S *pstCtrlCtx)
{
    pstCtrlCtx->astPortStatus[0].enState = HDMIRX_STATE_VIDEO_OFF;
    pstCtrlCtx->astPortStatus[1].enState = HDMIRX_STATE_VIDEO_OFF;
    pstCtrlCtx->astPortStatus[2].enState = HDMIRX_STATE_VIDEO_OFF;
    pstCtrlCtx->astPortStatus[3].enState = HDMIRX_STATE_VIDEO_OFF;
    pstCtrlCtx->astPortStatus[0].enLastState = HDMIRX_STATE_BUTT;
    pstCtrlCtx->astPortStatus[1].enLastState = HDMIRX_STATE_BUTT;
    pstCtrlCtx->astPortStatus[2].enLastState = HDMIRX_STATE_BUTT;
    pstCtrlCtx->astPortStatus[3].enLastState = HDMIRX_STATE_BUTT;
    //pstCtrlCtx->bConnect = HI_FALSE;
    pstCtrlCtx->bModeChange = HI_FALSE;
    //pstCtrlCtx->bModeChangeDone = HI_TRUE;
    pstCtrlCtx->enCurPort = HI_UNF_HDMIRX_PORT_BUTT;
    pstCtrlCtx->enStartPort = HI_UNF_HDMIRX_PORT0;
    #if SUPPORT_PORT0_ONLY
    pstCtrlCtx->enEndPort= HI_UNF_HDMIRX_PORT0;
    #else
    pstCtrlCtx->enEndPort= HI_UNF_HDMIRX_PORT3;
    #endif
    pstCtrlCtx->u32DevId = HDMIRX_HAL_GetDeviceId(HI_UNF_HDMIRX_PORT0);
    pstCtrlCtx->u32DevicRev = HDMIRX_HAL_GetDeviceReversion(HI_UNF_HDMIRX_PORT0);
}
/* 
------------------------------------------------------------------------------
    Function:       HDMIRX_Ctrl_SelectPortInit
    Description:    To initialize the FW var.
    Parameters:    	enPort: the current port used.
    Returns:        none
    Note:			1. called by connecting new hdmi source every time.
-----------------------------------------------------------------------------
*/
static HI_VOID HDMIRX_Ctrl_SelectPortInit(HI_UNF_HDMIRX_PORT_E enCurPort)
{
	HI_U32 i;
	HDMIRX_CTRL_CONTEXT_S *pstCtrlCtx;
	
	pstCtrlCtx = HDMIRX_CTRL_GET_CTX();
	pstCtrlCtx->enCurPort = enCurPort;
    printk("cur port is %d\n",pstCtrlCtx->enCurPort);
	for(i = pstCtrlCtx->enStartPort; i <= pstCtrlCtx->enEndPort; i++)
	{
        if(i< HI_UNF_HDMIRX_PORT_BUTT)
        {
            pstCtrlCtx->astPortStatus[i].enState = HDMIRX_STATE_VIDEO_OFF;
        }
	}    
    pstCtrlCtx->bRun= HI_TRUE;
    //pstCtrlCtx->bModeChangeDone = HI_FALSE;
    g_pstRegPeri->FPGA_CTRL1.u32 = 1;
    HDMIRX_VIDEO_RstTimingData();
}

HI_UNF_SIG_STATUS_E HDMIRX_CTRL_GetPortStatus(HI_UNF_HDMIRX_PORT_E enPort)
{
    HDMIRX_CTRL_CONTEXT_S *pstCtrlCtx;
    HI_UNF_SIG_STATUS_E enSigSta;
    pstCtrlCtx = HDMIRX_CTRL_GET_CTX();
    if(enPort > HI_UNF_HDMIRX_PORT3)
    {
        return HI_UNF_SIG_NO_SIGNAL;
    }
    if(pstCtrlCtx->astPortStatus[enPort].enState == HDMIRX_STATE_WAIT)
    {
        enSigSta = HI_UNF_SIG_UNSTABLE;
    }
    else if(pstCtrlCtx->astPortStatus[enPort].enState == HDMIRX_STATE_VIDEO_ON)
    {
        enSigSta = HI_UNF_SIG_SUPPORT;
    }
    else
    {
        enSigSta = HI_UNF_SIG_NO_SIGNAL;
    }
    return enSigSta;
}


/*
------------------------------------------------------------------------------
 Function:      HDMIRX_DRV_CTRL_GetSigStatus
 Description:   Get current port signal status as support/not support/no signal/unstable
 Parameters:    penSigSta: support/not support/no signal/unstable.
 Returns:       None.
 Note:          	
------------------------------------------------------------------------------
*/
HI_S32 HDMIRX_DRV_CTRL_GetSigStatus(HI_UNF_SIG_STATUS_E *penSigSta)
{
    HDMIRX_CTRL_CONTEXT_S *pstCtrlCtx;

    
    HDMIRX_CHECK_NULL_PTR(penSigSta);


    
    pstCtrlCtx = HDMIRX_CTRL_GET_CTX();
    if(pstCtrlCtx->bModeChange == HI_TRUE)
    {
		pstCtrlCtx->bModeChange = HI_FALSE;
        *penSigSta = HI_UNF_SIG_UNSTABLE;
    }
    #if 0
	else if(pstCtrlCtx->bModeChangeDone == HI_TRUE)
	{
		if(pstCtrlCtx->astPortStatus[pstCtrlCtx->enCurPort].enState 
            == HDMIRX_STATE_VIDEO_OFF)
		{
            *penSigSta = HI_UNF_SIG_NO_SIGNAL;
		}
        else
        {
            if(HDMIRX_VIDEO_IsSupport() == HI_TRUE)
            {
                *penSigSta = HI_UNF_SIG_SUPPORT;
            }
            else
            {
                *penSigSta = HI_UNF_SIG_NOT_SUPPORT;
            }
        }
	}

    else 
    {
        if(pstCtrlCtx->astPortStatus[pstCtrlCtx->enCurPort].enState 
            == HDMIRX_STATE_VIDEO_OFF)
        {
            *penSigSta = HI_UNF_SIG_NO_SIGNAL;
        }
        else
        {
            *penSigSta = HI_UNF_SIG_UNSTABLE;
        }
    }
    #else
    else
    {
        if(pstCtrlCtx->astPortStatus[pstCtrlCtx->enCurPort].enState 
            == HDMIRX_STATE_VIDEO_OFF)
        {
            *penSigSta = HI_UNF_SIG_NO_SIGNAL;
        }
        else if(pstCtrlCtx->astPortStatus[pstCtrlCtx->enCurPort].enState 
            == HDMIRX_STATE_VIDEO_ON)
        {
            if(HDMIRX_VIDEO_IsTimingActive() == HI_TRUE)
            {
                *penSigSta = HI_UNF_SIG_SUPPORT;
            }
            else
            {
                *penSigSta = HI_UNF_SIG_NOT_SUPPORT;
            }
        }
        else if(pstCtrlCtx->astPortStatus[pstCtrlCtx->enCurPort].enState 
            == HDMIRX_STATE_WAIT)
        {
            if(pstCtrlCtx->astPortStatus[pstCtrlCtx->enCurPort].u32WaitCnt == \
                HDMIRX_WAIT_TIMEOUT)
            {
                *penSigSta = HI_UNF_SIG_NOT_SUPPORT;
            }
            else
            {
                *penSigSta = HI_UNF_SIG_UNSTABLE;
            }
        }
    }
    #endif
    return HI_SUCCESS;
}

HDMIRX_CTRL_STATE_E HDMIRX_DRV_CTRL_GetState(HI_VOID)
{
    HDMIRX_CTRL_CONTEXT_S *pstCtrlCtx;       
    pstCtrlCtx = HDMIRX_CTRL_GET_CTX();
    return pstCtrlCtx->astPortStatus[pstCtrlCtx->enCurPort].enState;
}


HI_S32 HDMIRX_DRV_CTRL_GetAudioStatus(HI_UNF_SIG_STATUS_E *penSigSta)
{

    HDMIX_AUDIO_STATE_E Audio_state;
    HI_UNF_HDMIRX_PORT_E enPort = HDMIRX_CTRL_GetCurPort();
    HDMIRX_CHECK_NULL_PTR(penSigSta);
    
    Audio_state = HDMIRX_AUDIO_Getstatus();
    if(enPort != HI_UNF_HDMIRX_PORT_BUTT)
    {
        if(HDMIRX_VIDEO_GetHdmiMode(enPort)==HI_FALSE)
        {
            *penSigSta = HI_UNF_SIG_NO_SIGNAL;
        }
        else
        {
            switch(Audio_state)
            {
                case AUDIO_STATE_OFF:
                    *penSigSta = HI_UNF_SIG_NO_SIGNAL;
                    break;
                case AUDIO_STATE_ON:
                    *penSigSta = HI_UNF_SIG_SUPPORT;
                    break;
                case AUDIO_STATE_REQ:
                case AUDIO_STATE_READY:
                    *penSigSta = HI_UNF_SIG_UNSTABLE;
                    break;
                default:
                    *penSigSta = HI_UNF_SIG_NOT_SUPPORT;
                    break;   
            }
        }
    }
    else
    {
        *penSigSta = HI_UNF_SIG_NO_SIGNAL;
    }
    

    return HI_SUCCESS;
}
/*
------------------------------------------------------------------------------
 Function:      HDMIRX_DRV_CTRL_SetMonitorRun
 Description:   Enable the thread run or not.
 Parameters:    bRun: true for enable thread run.
 Returns:       None.
 Note:          	
------------------------------------------------------------------------------
*/
HI_S32 HDMIRX_DRV_CTRL_SetMonitorRun(HI_BOOL bRun)
{
    HDMIRX_CTRL_CONTEXT_S *pstCtrlCtx;

    pstCtrlCtx = HDMIRX_CTRL_GET_CTX();
    //HDMIRX_CTRL_CHECK_CONNECT();
    pstCtrlCtx->bRun = bRun;
    
    return HI_SUCCESS;
}
/*
------------------------------------------------------------------------------
 Function:      HDMIRX_DRV_CTRL_GetHdcpStatus
 Description:   Get the signal encrypted or not.
 Parameters:    pbHdcp: true for encrypted.
 Returns:       None.
 Note:          	
------------------------------------------------------------------------------
*/
HI_S32 HDMIRX_DRV_CTRL_GetHdcpStatus(HI_BOOL *pbHdcp)
{
    HDMIRX_CTRL_CONTEXT_S *pstCtrlCtx;
    
    HDMIRX_CHECK_NULL_PTR(pbHdcp);
    //HDMIRX_CTRL_CHECK_CONNECT();
    
    pstCtrlCtx = HDMIRX_CTRL_GET_CTX();

    *pbHdcp = HDMIRX_HAL_GetHdcpDone(pstCtrlCtx->enCurPort);
    /*
    if(pstCtrlCtx->astPortStatus[pstCtrlCtx->enCurPort].u32HdcpStableCnt > 0)
    {
        *pbHdcp = HI_TRUE;
    }
    else
    {
        *pbHdcp = HI_FALSE;
    }
    */
    return HI_SUCCESS;
}
/*
------------------------------------------------------------------------------
 Function:      HDMIRX_DRV_CTRL_GetTiming
 Description:   
 Parameters:    
 Returns:       
 Note:          	
------------------------------------------------------------------------------
*/
HI_S32 HDMIRX_DRV_CTRL_GetTiming(HI_UNF_HDMIRX_TIMING_INFO_S *pstTimingInfo)
{
    
    HDMIRX_CHECK_NULL_PTR(pstTimingInfo);
    if(HDMIRX_VIDEO_IsSupport() == HI_FALSE)
    {
        printk("\nNo signal or un-support!\n");
        return HI_FAILURE;
    }
    HDMIRX_VIDEO_GetTimingInfo(pstTimingInfo);
    
    return HI_SUCCESS;
}
/*
------------------------------------------------------------------------------
 Function:      HDMIRX_DRV_CTRL_GetTiming
 Description:   
 Parameters:    
 Returns:       
 Note:          	
------------------------------------------------------------------------------
*/
HI_S32 HDMIRX_DRV_CTRL_GetAudioInfo(HI_UNF_AI_HDMI_ATTR_S *pstAudioInfo)
{
    
    HDMIRX_CHECK_NULL_PTR(pstAudioInfo);
    if(HDMIRX_VIDEO_IsSupport() == HI_FALSE)
    {
        printk("\nNo signal or un-support!\n");
        return HI_FAILURE;
    }
    HDMIRX_AUDIO_GetInfo(pstAudioInfo);
    
    return HI_SUCCESS;
}
 
HI_S32 HDMIRX_DRV_CTRL_GetOffLineDetStatus(HI_UNF_HDMIRX_OFF_LINE_DET_S *pstOffLineDet)
{
    HI_U32 u32OffLineDetStatus;
    HDMIRX_CHECK_NULL_PTR(pstOffLineDet);
    #if SUPPORT_PORT0_ONLY  
    return HI_SUCCESS;    
    #endif
    u32OffLineDetStatus = HDMIRX_HAL_GetPwr5vStatus(pstOffLineDet->enPort);
    if(pstOffLineDet->enPort == HI_UNF_HDMIRX_PORT0)
    {
        if(HDMIRX_HAL_GetCkdt(pstOffLineDet->enPort) == HI_TRUE)
        {
            u32OffLineDetStatus = 1;
        }
        else
        {
            u32OffLineDetStatus = 0;
        }
    
    }

#if SUPPORT_MHL
    if((HDMIRX_HAL_GetCbusSense(HI_UNF_HDMIRX_PORT0) == HI_TRUE)&&(pstOffLineDet->enPort == HI_UNF_HDMIRX_PORT0))
    {
        u32OffLineDetStatus = 0;
        if (HDMIRX_MHL_IsBusConnected() == HI_TRUE)
        {
            u32OffLineDetStatus = 1;
        }
    }
#endif 

    pstOffLineDet->bConnected = u32OffLineDetStatus; 
    return HI_SUCCESS;
}

HI_S32 HDMIRX_DRV_CTRL_LoadHdcp(HI_UNF_HDMIRX_HDCP_S *pstHdcpKey)
{
    HI_S32 s32Ret;
    CIPHER_EXPORT_FUNC_S *pstCipherFunc = HI_NULL;
    HI_DRV_CIPHER_FLASH_ENCRYPT_HDCPKEY_S *pstFlashEncrytedHdcpKey;
    HDMIRX_CHECK_NULL_PTR(pstHdcpKey);
    memcpy(&stHdcpData,pstHdcpKey,sizeof(HI_UNF_HDMIRX_HDCP_S));
    s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_CIPHER, (HI_VOID**)&pstCipherFunc);
    if(s32Ret == HI_FAILURE)
    {
        HDMI_ERROR("########can't open Cipher!\n");
        return HI_FAILURE;
    }
    HDMIRX_CHECK_NULL_PTR(pstCipherFunc);
    pstFlashEncrytedHdcpKey = (HI_DRV_CIPHER_FLASH_ENCRYPT_HDCPKEY_S *)kmalloc(sizeof(HI_DRV_CIPHER_FLASH_ENCRYPT_HDCPKEY_S ),GFP_KERNEL);
    if(pstFlashEncrytedHdcpKey == NULL)
    {
        HDMI_ERROR("########kmalloc fail!\n");
        return HI_FAILURE;
    }
    memcpy(pstFlashEncrytedHdcpKey->u8Key, pstHdcpKey->au32Hdcp, 332);
    pstFlashEncrytedHdcpKey->u32KeyLen = 332;
    pstFlashEncrytedHdcpKey->enHDCPKeyType = HI_DRV_HDCPKEY_RX0;
    pstFlashEncrytedHdcpKey->enHDCPVersion = HI_DRV_HDCP_VERIOSN_1x;
    printk("\n###use new Cipher!#\n");
   // HDMIRX_INPUT_SetDdcEn(HDMIRX_INPUT_DDC_HDCP, HI_UNF_HDMIRX_PORT_ALL, HI_FALSE);
    pstCipherFunc->pfnCipherLoadHdcpKey(pstFlashEncrytedHdcpKey);
    kfree(pstFlashEncrytedHdcpKey);
    HDMIRX_HAL_LoadHdcpKey(HI_UNF_HDMIRX_PORT0,HI_FALSE);
#if SUPPORT_DOUBLE_CTRL
    HDMIRX_HAL_LoadHdcpKey(HI_UNF_HDMIRX_PORT1,HI_FALSE);
#endif
    udelay(20);
    HDMIRX_HAL_LoadHdcpKey(HI_UNF_HDMIRX_PORT0,HI_TRUE);
#if SUPPORT_DOUBLE_CTRL
    HDMIRX_HAL_LoadHdcpKey(HI_UNF_HDMIRX_PORT1,HI_TRUE);
#endif

#if !SUPPORT_HPD_ACTION
    HDMIRX_INPUT_SetDdcEn(HDMIRX_INPUT_DDC_EDID, HI_UNF_HDMIRX_PORT0, HI_TRUE);
    HDMIRX_INPUT_SetDdcEn(HDMIRX_INPUT_DDC_HDCP, HI_UNF_HDMIRX_PORT0, HI_TRUE);
    HDMIRX_INPUT_SetHdmiRtEn(HI_UNF_HDMIRX_PORT0, HI_TRUE);
    msleep(100);
    if(HDMIRX_HAL_GetCbusSense(HI_UNF_HDMIRX_PORT0) == HI_TRUE)
    {
        //HDMIRX_HAL_SetHpdManual(HI_UNF_HDMIRX_PORT0, HI_FALSE); 
        HDMIRX_HAL_MHLRstEn(HI_FALSE);
        HDMIRX_HAL_MhlChRstEn(HI_FALSE);
    }
    else
    {
        HDMIRX_INPUT_SetHpdLv(HI_UNF_HDMIRX_PORT0, HI_TRUE);
    }
#if !SUPPORT_PORT0_ONLY 
    HDMIRX_INPUT_SetDdcEn(HDMIRX_INPUT_DDC_EDID, HI_UNF_HDMIRX_PORT1, HI_TRUE);
    HDMIRX_INPUT_SetDdcEn(HDMIRX_INPUT_DDC_HDCP, HI_UNF_HDMIRX_PORT1, HI_TRUE);
    HDMIRX_INPUT_SetHdmiRtEn(HI_UNF_HDMIRX_PORT1, HI_TRUE);
    msleep(100);
    HDMIRX_INPUT_SetHpdLv(HI_UNF_HDMIRX_PORT1, HI_TRUE);

    msleep(500);
    HDMIRX_INPUT_SetDdcEn(HDMIRX_INPUT_DDC_EDID, HI_UNF_HDMIRX_PORT2, HI_TRUE);
    HDMIRX_INPUT_SetDdcEn(HDMIRX_INPUT_DDC_HDCP, HI_UNF_HDMIRX_PORT2, HI_TRUE);
    HDMIRX_INPUT_SetHdmiRtEn(HI_UNF_HDMIRX_PORT2, HI_TRUE);
    msleep(100);
    HDMIRX_INPUT_SetHpdLv(HI_UNF_HDMIRX_PORT2, HI_TRUE);
    
    msleep(500);
    HDMIRX_INPUT_SetDdcEn(HDMIRX_INPUT_DDC_EDID, HI_UNF_HDMIRX_PORT3, HI_TRUE);
    HDMIRX_INPUT_SetDdcEn(HDMIRX_INPUT_DDC_HDCP, HI_UNF_HDMIRX_PORT3, HI_TRUE);
    HDMIRX_INPUT_SetHdmiRtEn(HI_UNF_HDMIRX_PORT3, HI_TRUE);
    msleep(100);
    HDMIRX_INPUT_SetHpdLv(HI_UNF_HDMIRX_PORT3, HI_TRUE); 
#endif
    HDMIRX_DRV_CTRL_Connect(HI_UNF_HDMIRX_PORT1);
#endif

/*
    msleep(40);
    //HDMIRX_HAL_HdcpCrcCheck(0);
   // HDMIRX_INPUT_SetDdcEn(HDMIRX_INPUT_DDC_EDID, HI_UNF_HDMIRX_PORT_ALL, HI_TRUE);
    HDMIRX_INPUT_SetDdcEn(HDMIRX_INPUT_DDC_EDID, HI_UNF_HDMIRX_PORT0, HI_TRUE);

#if !SUPPORT_PORT0_ONLY    
    HDMIRX_INPUT_SetDdcEn(HDMIRX_INPUT_DDC_EDID, HI_UNF_HDMIRX_PORT1, HI_TRUE);
    HDMIRX_INPUT_SetDdcEn(HDMIRX_INPUT_DDC_EDID, HI_UNF_HDMIRX_PORT2, HI_TRUE);
    HDMIRX_INPUT_SetDdcEn(HDMIRX_INPUT_DDC_EDID, HI_UNF_HDMIRX_PORT3, HI_TRUE);
#endif    
   // HDMIRX_INPUT_SetDdcEn(HDMIRX_INPUT_DDC_HDCP, HI_UNF_HDMIRX_PORT_ALL, HI_TRUE);
    HDMIRX_INPUT_SetDdcEn(HDMIRX_INPUT_DDC_HDCP, HI_UNF_HDMIRX_PORT0, HI_TRUE);

#if !SUPPORT_PORT0_ONLY
    HDMIRX_INPUT_SetDdcEn(HDMIRX_INPUT_DDC_HDCP, HI_UNF_HDMIRX_PORT1, HI_TRUE);
    HDMIRX_INPUT_SetDdcEn(HDMIRX_INPUT_DDC_HDCP, HI_UNF_HDMIRX_PORT2, HI_TRUE);
    HDMIRX_INPUT_SetDdcEn(HDMIRX_INPUT_DDC_HDCP, HI_UNF_HDMIRX_PORT3, HI_TRUE);
#endif 

    #if 0//!SUPPORT_PWR5V_DET
    msleep(40);
    //HDMIRX_INPUT_SetHpdLv(HI_UNF_HDMIRX_PORT_ALL, HI_TRUE);
    HDMIRX_INPUT_SetHpdLv(HI_UNF_HDMIRX_PORT0, HI_TRUE);
    HDMIRX_INPUT_SetHpdLv(HI_UNF_HDMIRX_PORT1, HI_TRUE);
    HDMIRX_INPUT_SetHpdLv(HI_UNF_HDMIRX_PORT2, HI_TRUE);
    HDMIRX_INPUT_SetHpdLv(HI_UNF_HDMIRX_PORT3, HI_TRUE);       
    #endif
*/

    return HI_SUCCESS;
}
HI_S32 HDMIRX_DRV_CTRL_UpdateEdid(HI_UNF_HDMIRX_EDID_S *pstEdid)
{
    HDMIRX_CHECK_NULL_PTR(pstEdid);
    memcpy(&stEdidData,pstEdid,sizeof(HI_UNF_HDMIRX_EDID_S));
    HDMIRX_INPUT_EdidInitial(pstEdid->au32Edid,pstEdid->au32Addr);
    return HI_SUCCESS;
}
/*
HI_S32 HDMIRX_DRV_CTRL_SendRCPKey(HI_UNF_HDMIRX_RCP_KEY_E *enKey)
{
    HDMIRX_CHECK_NULL_PTR(enKey);
    if((HDMIRX_CTRL_GetPortStatus(HI_UNF_HDMIRX_PORT0) == HI_UNF_SIG_SUPPORT) && \
        (HDMIRX_MHL_SignalEnable() == HI_TRUE))
    {
        printk("####send RCP:%d\n",*enKey);
        HDMIRX_MHL_SendRcp(*enKey);
        return HI_SUCCESS;
    }
    else
    {
        return HI_FAILURE;
    }
    
    
}
*/

/*
------------------------------------------------------------------------------
 Function:      HDMIRX_DRV_CTRL_DeInit
 Description:   Get the signal encrypted or not.
 Parameters:    pbHdcp: true for encrypted.
 Returns:       None.
 Note:          	
------------------------------------------------------------------------------
*/
HI_VOID HDMIRX_DRV_CTRL_DeInit(HI_VOID)
{
    HDMIRX_CTRL_CONTEXT_S *pstCtrlCtx;
    
    pstCtrlCtx = HDMIRX_CTRL_GET_CTX();

    HDMIRX_DRV_CTRL_Disconnect();
    
    pstCtrlCtx->bRun= HI_FALSE;
    kthread_stop(pstCtrlCtx->pstProcessTask);
}

HI_S32 HDMIRX_DRV_CTRL_Init(HI_VOID)
{
    HI_S32 s32Ret;
    #ifdef HI_FPGA
    GPIO_I2C_EXT_FUNC_S *pstGpioI2cFunc = HI_NULL;
    HI_U32 u32I2cNum ;
    #endif
    HDMIRX_CTRL_CONTEXT_S *pstCtrlCtx;
    
    pstCtrlCtx = HDMIRX_CTRL_GET_CTX();
    memset(pstCtrlCtx, 0, sizeof(HDMIRX_CTRL_CONTEXT_S));
    memset(&stEdidData,0, sizeof(HI_UNF_HDMIRX_EDID_S));
    memset(&stHdcpData,0, sizeof(HI_UNF_HDMIRX_HDCP_S));
#ifdef HI_FPGA
    s32Ret= HI_DRV_MODULE_GetFunction(HI_ID_GPIO_I2C, (HI_VOID**)&pstGpioI2cFunc);
    if(s32Ret == HI_FAILURE)
    {
        return HI_FAILURE;
    }
    HDMIRX_CHECK_NULL_PTR(pstGpioI2cFunc);
    s32Ret = pstGpioI2cFunc->pfnGpioI2cCreateChannel(&u32I2cNum, 24, 25);
    if (s32Ret != HI_SUCCESS)
    {
        HI_ERR_DEV("I2C1 Init Failure!\n");
        goto hal_init_err;
    }
    else
    {
        pstGpioI2cFunc->pfnGpioI2cWrite(u32I2cNum, 0x62, 0x5c, 0x0a);
        pstGpioI2cFunc->pfnGpioI2cWrite(u32I2cNum, 0x62, 0x69, 0x9c);
        pstGpioI2cFunc->pfnGpioI2cWrite(u32I2cNum, 0x62, 0x02, 0x02);
        pstGpioI2cFunc->pfnGpioI2cWrite(u32I2cNum, 0x62, 0x0a, 0xa0);
        pstGpioI2cFunc->pfnGpioI2cWrite(u32I2cNum, 0x62, 0x0b, 0xf3);
        pstGpioI2cFunc->pfnGpioI2cWrite(u32I2cNum, 0x62, 0x0c, 0xe3);
        pstGpioI2cFunc->pfnGpioI2cWrite(u32I2cNum, 0x62, 0x0d, 0xf3);
        pstGpioI2cFunc->pfnGpioI2cWrite(u32I2cNum, 0x62, 0x0e, 0xa0);
        pstGpioI2cFunc->pfnGpioI2cWrite(u32I2cNum, 0x62, 0x0f, 0xa0);
        pstGpioI2cFunc->pfnGpioI2cWrite(u32I2cNum, 0x62, 0x10, 0xa0);
		//pstGpioI2cFunc->pfnGpioI2cWrite(u32I2cNum, 0x62, 0x08, 0xe3);
        //pstGpioI2cFunc->pfnGpioI2cWrite(u32I2cNum, 0x62, 0x09, 0xa0);
        pstGpioI2cFunc->pfnGpioI2cWrite(u32I2cNum, 0x62, 0x05, 0x88);

    }
    s32Ret = pstGpioI2cFunc->pfnGpioI2cCreateChannel(&u32I2cNum, 28, 29);
    if (s32Ret != HI_SUCCESS)
    {
        HI_ERR_DEV("I2C0 Init Failure!\n");
        goto hal_init_err;
    }
    else
    {
        pstGpioI2cFunc->pfnGpioI2cWrite(u32I2cNum, 0x62, 0x5c, 0x0a);
        pstGpioI2cFunc->pfnGpioI2cWrite(u32I2cNum, 0x62, 0x69, 0x9c);
        pstGpioI2cFunc->pfnGpioI2cWrite(u32I2cNum, 0x62, 0x02, 0x02);
        pstGpioI2cFunc->pfnGpioI2cWrite(u32I2cNum, 0x62, 0x0a, 0xa0);
        pstGpioI2cFunc->pfnGpioI2cWrite(u32I2cNum, 0x62, 0x0b, 0xf3);
        pstGpioI2cFunc->pfnGpioI2cWrite(u32I2cNum, 0x62, 0x0c, 0xe3);
        pstGpioI2cFunc->pfnGpioI2cWrite(u32I2cNum, 0x62, 0x0d, 0xf3);
        pstGpioI2cFunc->pfnGpioI2cWrite(u32I2cNum, 0x62, 0x0e, 0xa0);
        pstGpioI2cFunc->pfnGpioI2cWrite(u32I2cNum, 0x62, 0x0f, 0xa0);
        pstGpioI2cFunc->pfnGpioI2cWrite(u32I2cNum, 0x62, 0x10, 0xa0);
		//pstGpioI2cFunc->pfnGpioI2cWrite(u32I2cNum, 0x62, 0x08, 0xe3);
        //pstGpioI2cFunc->pfnGpioI2cWrite(u32I2cNum, 0x62, 0x09, 0xa0);
        pstGpioI2cFunc->pfnGpioI2cWrite(u32I2cNum, 0x62, 0x05, 0x88);
    }
#endif
    s32Ret = HDMIRX_HAL_Init();
    if (s32Ret != HI_SUCCESS)
    {
        HI_ERR_DEV("TVD Init Failure!\n");
        goto hal_init_err;
    }
    HDMIRX_HAL_SetPdSysEn(HI_UNF_HDMIRX_PORT0, HI_FALSE);
    #if !SUPPORT_PORT0_ONLY       
    HDMIRX_HAL_SetPdSysEn(HI_UNF_HDMIRX_PORT1, HI_FALSE);
    HDMIRX_HAL_SetPdSysEn(HI_UNF_HDMIRX_PORT2, HI_FALSE);
    HDMIRX_HAL_SetPdSysEn(HI_UNF_HDMIRX_PORT3, HI_FALSE);
    #endif
    HDMIRX_INPUT_Init();
#if SUPPORT_MHL
    HDMIRX_MHL_Initialize(HI_UNF_HDMIRX_PORT0);
#endif
    HDMIRX_CTRL_InterruptInitial();

#if SUPPORT_DOUBLE_CTRL
    HDMIRX_HAL_InterruptRegInit(HI_UNF_HDMIRX_PORT0,au32ShadowIntMask);
#endif
    HDMIRX_HAL_InterruptRegInit(HI_UNF_HDMIRX_PORT1,au32ShadowIntMask);

    HDMIRX_AUDIO_Initial();

#if SUPPORT_DOUBLE_CTRL
    HDMIRX_HAL_AudioRegInit(HI_UNF_HDMIRX_PORT0);
    HDMIRX_HAL_VideoRegInit(HI_UNF_HDMIRX_PORT0);
    HDMIRX_HAL_PacketRegInit(HI_UNF_HDMIRX_PORT0);
    HDMIRX_HAL_SetResetEn(HI_UNF_HDMIRX_PORT0,HDMIRX_SOFT_RST, HI_FALSE);
#endif
    HDMIRX_HAL_AudioRegInit(HI_UNF_HDMIRX_PORT1);
    HDMIRX_HAL_VideoRegInit(HI_UNF_HDMIRX_PORT1);
    HDMIRX_HAL_PacketRegInit(HI_UNF_HDMIRX_PORT1);
    HDMIRX_HAL_SetResetEn(HI_UNF_HDMIRX_PORT1,HDMIRX_SOFT_RST, HI_FALSE);

    
  //  HDMIRX_HAL_SetAutoRstEn(HDMIRX_AUTORST_SOFT, HI_TRUE);
    /* 上下文初始化 */
    HDMIRX_Ctrl_CtxInit(pstCtrlCtx); 
    pstCtrlCtx->pstProcessTask = kthread_run(HDMIRX_Ctrl_MainTask, NULL,
        "HDMIRX main task");
  //  HDMIRX_DRV_CTRL_Connect(HI_UNF_HDMIRX_PORT1);
    pstCtrlCtx->bHdcpCheckEn = HI_TRUE;
    
    return HI_SUCCESS;


hal_init_err:
    
    return HI_FAILURE;
}

HI_S32 HDMIRX_DRV_CTRL_Suspend(HI_VOID)
{

    return HI_SUCCESS;
}

HI_S32 HDMIRX_DRV_CTRL_Resume(HI_VOID)
{
    HI_S32 s32Ret;
    s32Ret = HDMIRX_HAL_Init();
    if (s32Ret != HI_SUCCESS)
    {
        HI_ERR_DEV("TVD Init Failure!\n");
        goto hal_init_err;
    }
    HDMIRX_INPUT_Init();
 //   HDMIRX_INPUT_SetDdcEn(HDMIRX_INPUT_DDC_HDCP, HI_UNF_HDMIRX_PORT_ALL, HI_TRUE);
#if SUPPORT_MHL
    HDMIRX_MHL_Initialize(HI_UNF_HDMIRX_PORT0);
#endif
    HDMIRX_CTRL_InterruptInitial();

#if SUPPORT_DOUBLE_CTRL
    HDMIRX_HAL_InterruptRegInit(HI_UNF_HDMIRX_PORT0,au32ShadowIntMask);
#endif
    HDMIRX_HAL_InterruptRegInit(HI_UNF_HDMIRX_PORT1,au32ShadowIntMask);


#if SUPPORT_AUDIO_INFOFRAME
#if SUPPORT_DOUBLE_CTRL
    HDMIRX_PACKET_ResetAudInfoFrameData(HI_UNF_HDMIRX_PORT0);
#endif
    HDMIRX_PACKET_ResetAudInfoFrameData(HI_UNF_HDMIRX_PORT1);
#endif

#if SUPPORT_DOUBLE_CTRL
        HDMIRX_HAL_AudioRegInit(HI_UNF_HDMIRX_PORT0);
        HDMIRX_HAL_VideoRegInit(HI_UNF_HDMIRX_PORT0);
        HDMIRX_HAL_PacketRegInit(HI_UNF_HDMIRX_PORT0);
        HDMIRX_HAL_SetResetEn(HI_UNF_HDMIRX_PORT0,HDMIRX_SOFT_RST, HI_FALSE);
#endif
        HDMIRX_HAL_AudioRegInit(HI_UNF_HDMIRX_PORT1);
        HDMIRX_HAL_VideoRegInit(HI_UNF_HDMIRX_PORT1);
        HDMIRX_HAL_PacketRegInit(HI_UNF_HDMIRX_PORT1);
        HDMIRX_HAL_SetResetEn(HI_UNF_HDMIRX_PORT1,HDMIRX_SOFT_RST, HI_FALSE);
   //     HDMIRX_DRV_CTRL_Connect(HI_UNF_HDMIRX_PORT1);
    return HI_SUCCESS;

hal_init_err:    
    return HI_FAILURE;    
}

/*
------------------------------------------------------------------------------
 Function:      HDMIRX_DRV_CTRL_Connect
 Description:   Select the port.
 Parameters:    None.
 Returns:       None.
 Note:          1. called every switch source.
------------------------------------------------------------------------------
*/
HI_S32 HDMIRX_DRV_CTRL_Connect(HI_UNF_HDMIRX_PORT_E enPort)
{
    HDMIRX_CTRL_CONTEXT_S *pstCtrlCtx;
	
    if (enPort >= HI_UNF_HDMIRX_PORT_BUTT)
    {
        HI_ERR_DEV("Port Index is invalid!\n");
        return HI_FAILURE;
    }
    pstCtrlCtx = HDMIRX_CTRL_GET_CTX();
    pstCtrlCtx->bModeChange = HI_TRUE;
#if SUPPORT_PORT0_ONLY    
    enPort= HI_UNF_HDMIRX_PORT0;
#endif
    if(enPort == pstCtrlCtx->enCurPort)
	{
		return HI_SUCCESS;
	}
    HDMIRX_Ctrl_SelectPortInit(enPort);
	HDMIRX_INPUT_SwitchPort(enPort);
#if SUPPORT_HPD_ACTION

#if !SUPPORT_PORT0_ONLY
    if((pstCtrlCtx->enCurPort != HI_UNF_HDMIRX_PORT0)
        #if SUPPORT_MHL
        && (HDMIRX_HAL_GetCbusSense(HI_UNF_HDMIRX_PORT0) == HI_FALSE)
        #endif
        )
    {
        HDMIRX_HAL_SetEdidDdcEn(HI_UNF_HDMIRX_PORT0,HI_TRUE);
        HDMIRX_HAL_SetHdcpDdcEn(HI_UNF_HDMIRX_PORT0,HI_TRUE);
        HDMIRX_INPUT_SetHdmiRtEn(HI_UNF_HDMIRX_PORT0, HI_TRUE);
        msleep(40);

        HDMIRX_INPUT_SetHpdLv(HI_UNF_HDMIRX_PORT0, HI_TRUE);        
        printk("\n port0 hpd is high. \n");
    }
    if(pstCtrlCtx->enCurPort != HI_UNF_HDMIRX_PORT1)
    {      
        HDMIRX_HAL_SetEdidDdcEn(HI_UNF_HDMIRX_PORT1,HI_TRUE);
        HDMIRX_HAL_SetHdcpDdcEn(HI_UNF_HDMIRX_PORT1,HI_TRUE);
        HDMIRX_INPUT_SetHdmiRtEn(HI_UNF_HDMIRX_PORT1, HI_TRUE);
        msleep(40);
        HDMIRX_INPUT_SetHpdLv(HI_UNF_HDMIRX_PORT1, HI_TRUE);
        printk("\n port1 hpd is high. \n");
    }
    if(pstCtrlCtx->enCurPort != HI_UNF_HDMIRX_PORT2)
    {
        HDMIRX_HAL_SetEdidDdcEn(HI_UNF_HDMIRX_PORT2,HI_TRUE);
        HDMIRX_HAL_SetHdcpDdcEn(HI_UNF_HDMIRX_PORT2,HI_TRUE);
        HDMIRX_INPUT_SetHdmiRtEn(HI_UNF_HDMIRX_PORT2, HI_TRUE);
        msleep(40);
        HDMIRX_INPUT_SetHpdLv(HI_UNF_HDMIRX_PORT2, HI_TRUE);
        printk("\n port2 hpd is high. \n");
    }
    if(pstCtrlCtx->enCurPort != HI_UNF_HDMIRX_PORT3)
    {
        HDMIRX_HAL_SetEdidDdcEn(HI_UNF_HDMIRX_PORT3,HI_TRUE);
        HDMIRX_HAL_SetHdcpDdcEn(HI_UNF_HDMIRX_PORT3,HI_TRUE);
        HDMIRX_INPUT_SetHdmiRtEn(HI_UNF_HDMIRX_PORT3, HI_TRUE);
        msleep(40);
        HDMIRX_INPUT_SetHpdLv(HI_UNF_HDMIRX_PORT3, HI_TRUE);
        printk("\n port3 hpd is high. \n");
    }
#endif  
#endif

#if SUPPORT_DOUBLE_CTRL
    HDMIRX_HAL_SetAudioMux(enPort);
#endif
    return HI_SUCCESS;

}
HI_S32 HDMIRX_DRV_CTRL_Disconnect(HI_VOID)
{    
    return HI_SUCCESS;
}

static HI_S32 HDMIRX_DRV_CTRL_PROCParseCmd(HI_CHAR *pProcCmd,HI_CHAR **ppArg1,HI_CHAR **ppArg2)
{
    HI_CHAR *pChar = HI_NULL;

    if (strlen(pProcCmd) == 0) {
        /* not fined arg1 and arg2, return failed */
        *ppArg1  = HI_NULL;
        *ppArg2  = HI_NULL;        
        return HI_FAILURE;
    }

    /* find arg1 */
    pChar = pProcCmd;
    while( (*pChar == ' ') && (*pChar != '\0') ) {
        pChar++;
    }
   
    if (*pChar != '\0') {
        *ppArg1 = pChar;
    } else {
        *ppArg1  = HI_NULL;
        
        return HI_FAILURE;
    }

    /* ignor arg1 */
    while( (*pChar != ' ') && (*pChar != '\0') ) {
        pChar++;
    }

    /* Not find arg2, return */
    if (*pChar == '\0') {
        *ppArg2 = HI_NULL;
        
        return HI_SUCCESS;
    }

    /* add '\0' for arg1 */
    *pChar = '\0';

    /* start to find arg2 */
    pChar++;
    while( (*pChar == ' ') && (*pChar != '\0') ) {
        pChar++;
    }

    if (*pChar != '\0') {
        *ppArg2 = pChar;
    } else {
        *ppArg2 = HI_NULL;
    }

    return HI_SUCCESS;
}

HI_S32 DRV_HDMIRX_CTRL_ProcRead(struct seq_file *s, HI_VOID *data)
{
    HDMIRX_CTRL_CONTEXT_S *pstCtrlCtx;
    HI_UNF_HDMIRX_TIMING_INFO_S pstTimingInfo;
    HDMIRX_COLOR_SPACE_E enColorSpace;
    HDMIRX_AUDIO_CONTEXT_S *pstAudioCtx;
    HDMIRX_AUDIO_CONTEXT_S AudioCtx;
    HI_UNF_HDMIRX_OFF_LINE_DET_S pstOffLineDet;
    HI_U32          u32Cts;
    HI_U32          u32N;
    HI_U32          u32TmdsClk;
    HI_U32          fs_100Hz = 0;  
    HI_UNF_HDMIRX_PORT_E  u32TmpPort;
    HI_BOOL pbHdcp;
    pstCtrlCtx = HDMIRX_CTRL_GET_CTX();
    
    /* TVD Attr Information */
    PROC_PRINT(s, "\n--------------- HDMIRX Attr ---------------\n");
    PROC_PRINT(s,"Version              :   14.10.15\n");
    PROC_PRINT(s,"ConnectState         :   %s\n",pstCtrlCtx->bRun? "Yes" : "No");
    PROC_PRINT(s,"CurPort              :   %s\n",s_apsPortString[pstCtrlCtx->enCurPort]);
    PROC_PRINT(s,"CurPortState         :   %s\n",s_apsStateString[pstCtrlCtx->astPortStatus[pstCtrlCtx->enCurPort].enState]);
    PROC_PRINT(s,"CurPortWaitCnt       :   %d\n",pstCtrlCtx->astPortStatus[pstCtrlCtx->enCurPort].u32WaitCnt);
    PROC_PRINT(s,"CurPortHdcpStableCnt :   %d\n",pstCtrlCtx->astPortStatus[pstCtrlCtx->enCurPort].u32HdcpStableCnt);
    HDMIRX_DRV_CTRL_GetHdcpStatus(&pbHdcp);
    PROC_PRINT(s,"HdcpCheck            :   %s\n",pbHdcp? "Yes":"No");
    PROC_PRINT(s,"HdcpErrCheckEn       :   %s\n",pstCtrlCtx->bHdcpCheckEn? "Enable":"Disable");
    PROC_PRINT(s,"OffLineDetStatus:    :\n");
    for(u32TmpPort=pstCtrlCtx->enStartPort;u32TmpPort<=pstCtrlCtx->enEndPort;u32TmpPort++)
    {
        pstOffLineDet.enPort= u32TmpPort;
        if(HDMIRX_DRV_CTRL_GetOffLineDetStatus(&pstOffLineDet) == HI_SUCCESS)
        {
            PROC_PRINT(s,"port%d:%-4d   ",u32TmpPort,pstOffLineDet.bConnected);
        }
        else
        {
            PROC_PRINT(s,"port%d:-1   ",u32TmpPort);
        }
    }
    PROC_PRINT(s,"\n");
#if SUPPORT_MHL
    if((HDMIRX_HAL_GetCbusSense(HI_UNF_HDMIRX_PORT0) == HI_TRUE)&&(pstCtrlCtx->enCurPort == HI_UNF_HDMIRX_PORT0))
    {
        HDMIRX_MHL_ProcRead(s);
    }
#endif     
    
    if (HI_TRUE != pstCtrlCtx->bRun || 
        HDMIRX_STATE_VIDEO_OFF == pstCtrlCtx->astPortStatus[pstCtrlCtx->enCurPort].enState)
    {
        return HI_SUCCESS;
    }
    
    /* HDMIRX Signal Timing Information */
    if(pstCtrlCtx->astPortStatus[pstCtrlCtx->enCurPort].enState == HDMIRX_STATE_VIDEO_ON)
    {
        
        HDMIRX_VIDEO_GetTimingInfo(&pstTimingInfo);
        PROC_PRINT(s, "\n---------------HDMIRX Timing---------------\n");
        PROC_PRINT(s,"TimingIndex          :   %d\n",pstTimingInfo.u32TimingIdx);
        PROC_PRINT(s,"Width                :   %d\n",pstTimingInfo.u32Width);
        PROC_PRINT(s,"Height               :   %d\n",pstTimingInfo.u32Height);
        PROC_PRINT(s,"FrameRate            :   %d\n",pstTimingInfo.u32FrameRate);
        PROC_PRINT(s,"Interlace            :   %s\n",pstTimingInfo.bInterlace? "Interlace":"Progressive");
        PROC_PRINT(s,"Htotal               :   %d\n",HDMIRX_HAL_GetHtotal(pstCtrlCtx->enCurPort));
        PROC_PRINT(s,"Vtotal               :   %d\n",HDMIRX_HAL_GetVtotal(pstCtrlCtx->enCurPort));
        PROC_PRINT(s,"PixelFreq            :   %d\n",HDMIRX_HAL_GetPixClk(pstCtrlCtx->enCurPort));
        PROC_PRINT(s,"Hpol                 :   %s\n",HDMIRX_HAL_GetHpol(pstCtrlCtx->enCurPort)? "POS" : "NEG");
        PROC_PRINT(s,"Vpol                 :   %s\n",HDMIRX_HAL_GetVpol(pstCtrlCtx->enCurPort)? "POS" : "NEG");
        if(pstTimingInfo.bPcMode)
        {
            PROC_PRINT(s,"TimingMode           :   PcMode\n");
        }
        else if((pstTimingInfo.u32TimingIdx >= TIMING_MAX) && (pstTimingInfo.u32TimingIdx < (TIMING_MAX+NMB_OF_HDMI_VIDEO_MODES)))
        {
          PROC_PRINT(s,"TimingMode           :   2D_4K*2K\n");
        }
        else if(pstTimingInfo.en3dFmt == HI_UNF_FRAME_PACKING_TYPE_FRAME_PACKING)
        {
            PROC_PRINT(s,"TimingMode           :   3D_FRAME_PACKING\n");
        }
        else if(pstTimingInfo.en3dFmt == HI_UNF_FRAME_PACKING_TYPE_SIDE_BY_SIDE)
        {
            PROC_PRINT(s,"TimingMode           :   3D_SIDE_BY_SIDE\n");
        }
        else if(pstTimingInfo.en3dFmt == HI_UNF_FRAME_PACKING_TYPE_TOP_AND_BOTTOM)
        {
            PROC_PRINT(s,"TimingMode           :   3D_TOP_AND_BOTTOM\n");
        }
        else if(pstTimingInfo.en3dFmt == HI_UNF_FRAME_PACKING_TYPE_TIME_INTERLACED)
        {
            PROC_PRINT(s,"TimingMode           :   3D_TIME_INTERLACED\n");
        }
        else
        {
           PROC_PRINT(s,"TimingMode           :   2D_General\n"); 
        }

        //PROC_PRINT(s,"HdmiMode             :   %s\n",pstTimingInfo.bHdmiMode? "HDMI":"DVI");
        if(pstTimingInfo.bHdmiMode == HI_FALSE)
        {
            PROC_PRINT(s,"HdmiMode             :   %s\n","DVI");
        }
        else
        {
            PROC_PRINT(s,"HdmiMode             :   %s\n","HDMI");
        }
#if SUPPORT_MHL        
        if(pstTimingInfo.bMHL== HI_TRUE)
        {
            PROC_PRINT(s,"bMHLMode             :   Yes\n");
        }
        else
        {
            PROC_PRINT(s,"bMHLMode             :   No\n");
        }
#endif
        if(pstTimingInfo.enColorSpace == HI_UNF_COLOR_SPACE_BT601_YUV_LIMITED)
        {
            PROC_PRINT(s,"ColorSpace           :   SPACE_YCBCR_601\n"); 
        }
        else if(pstTimingInfo.enColorSpace == HI_UNF_COLOR_SPACE_BT709_YUV_LIMITED)
        {
            PROC_PRINT(s,"ColorSpace           :   SPACE_YCBCR_709\n"); 
        }
        else
        {
            PROC_PRINT(s,"ColorSpace           :   SPACE_RGB\n");             
        }
        
        enColorSpace = HDMIRX_PACKET_AVI_GetColorSpace();
        if(enColorSpace == HDMIRX_COLOR_SPACE_YCBCR422)
        {
            PROC_PRINT(s,"InputPixelFmt        :   YCBCR422\n");        
        }
        else if(enColorSpace == HDMIRX_COLOR_SPACE_YCBCR444)
        {
            PROC_PRINT(s,"InputPixelFmt        :   YCBCR444\n");        
        }
        else
        {
            PROC_PRINT(s,"InputPixelFmt        :   RGB444\n");        
        }
        
        if(enColorSpace == HDMIRX_COLOR_SPACE_RGB)
         {
            if(pstTimingInfo.enRGBRange == HI_UNF_RGB_LIMIT_RANGE)
            {
                PROC_PRINT(s,"RGB Quantization Range:   LIMIT_RANGE\n");
            }
            else if(pstTimingInfo.enRGBRange == HI_UNF_RGB_FULL_RANGE)
            {
                PROC_PRINT(s,"RGB Quantization Range:   FULL_RANGE\n");
            }
            else
            {
                PROC_PRINT(s,"RGB Quantization Range:   depended on video format\n");
            }
        }

        if(pstTimingInfo.enPixelFmt == HI_UNF_FORMAT_YUV_SEMIPLANAR_422)
        {
            PROC_PRINT(s,"OutputPixelFmt       :   YCBCR422\n");        
        }
        else if(pstTimingInfo.enPixelFmt == HI_UNF_FORMAT_YUV_SEMIPLANAR_444)
        {
            PROC_PRINT(s,"OutputPixelFmt       :   YCBCR444\n");        
        }
        else
        {
            PROC_PRINT(s,"OutputPixelFmt       :   RGB444\n");        
        }
        PROC_PRINT(s,"BitWidth(Bit)        :   %d\n",(pstTimingInfo.enBitWidth*2+8));
        if(pstTimingInfo.enOversample == HI_UNF_OVERSAMPLE_1X)
        {
            PROC_PRINT(s,"Oversample           :   1x\n");
        }
        else
        {
            PROC_PRINT(s,"Oversample           :   %dx\n",pstTimingInfo.enOversample*2);
        }
        /*
        if(pstTimingInfo.bHdmiMode == HI_TRUE)
        {
            HDMIRX_AUDIO_ProcRead(s, data);
        }
        */
    }
    else
    {
        PROC_PRINT(s, "\n---------------HDMIRX Timing---------------\n");
        PROC_PRINT(s,"Htotal               :   %d\n",HDMIRX_HAL_GetHtotal(pstCtrlCtx->enCurPort));
        PROC_PRINT(s,"Vtotal               :   %d\n",HDMIRX_HAL_GetVtotal(pstCtrlCtx->enCurPort));
        PROC_PRINT(s,"Interlace            :   %s\n",HDMIRX_HAL_GetInterlance(pstCtrlCtx->enCurPort) ? "YES" : "NO");
        PROC_PRINT(s,"PixelFreq            :   %d\n",HDMIRX_HAL_GetPixClk(pstCtrlCtx->enCurPort));
        PROC_PRINT(s,"Hpol                 :   %s\n",HDMIRX_HAL_GetHpol(pstCtrlCtx->enCurPort)? "POS" : "NEG");
        PROC_PRINT(s,"Vpol                 :   %s\n",HDMIRX_HAL_GetVpol(pstCtrlCtx->enCurPort)? "POS" : "NEG");
    }
    if(pstTimingInfo.bHdmiMode == HI_TRUE)
    {
        HDMIRX_AUDIO_GetAudioInfo(&AudioCtx);
    pstAudioCtx = &AudioCtx;
    PROC_PRINT(s, "\n---------------HDMIRX Audio---------------\n");
    switch(pstAudioCtx->enAudioState)
    {
        case AUDIO_STATE_OFF:
            PROC_PRINT(s,"AudioState           :   OFF\n"); 
            break;
        case AUDIO_STATE_REQ:
            PROC_PRINT(s,"AudioState           :   REQ\n"); 
            break;
        case AUDIO_STATE_READY:
            PROC_PRINT(s,"AudioState           :   READY\n"); 
            break;
        case AUDIO_STATE_ON:
            PROC_PRINT(s,"AudioState           :   ON\n"); 
            break;
        default:
            PROC_PRINT(s,"AudioState           :   ERRO\n"); 
            break;
    }
  //  PROC_PRINT(s,"u32Ca                :   %d\n",pstAudioCtx->u32Ca);
    PROC_PRINT(s,"u32Fs                :   %d\n",pstAudioCtx->u32Fs);
  
    u32N = HDMIRX_HAL_GetN(pstCtrlCtx->enCurPort);
    u32Cts = HDMIRX_HAL_GetCts(pstCtrlCtx->enCurPort);
    u32TmdsClk = HDMIRX_AUDIO_GetTmdsClk_10k();
    if (u32TmdsClk && u32Cts) 
    {
        fs_100Hz = (u32TmdsClk*u32N/u32Cts)*100/128;
    }
    PROC_PRINT(s,"fs_100Hz             :   %d\n",fs_100Hz);
  //  PROC_PRINT(s,"StatusReceived       :   %s\n",pstAudioCtx->bStatusReceived? "Yes":"No");
  //  PROC_PRINT(s,"Enc                  :   %s\n",pstAudioCtx->bEnc? "Yes":"No");
    #if SUPPORT_DSD
    PROC_PRINT(s,"DsdMode              :   %s\n",pstAudioCtx->bDsdMode? "Yes":"No");
    #endif
    PROC_PRINT(s,"HbrMode              :   %s\n",pstAudioCtx->bHbrMode? "Yes":"No");
    PROC_PRINT(s,"StartReq             :   %s\n",pstAudioCtx->bStartReq? "Yes":"No");
    if(pstAudioCtx->bHbrMode == HI_TRUE)
    {
        PROC_PRINT(s,"AudioDataFormat      :   HBR\n");
    }
    else
    {
        if(pstAudioCtx->bEnc == HI_TRUE)
        {
            PROC_PRINT(s,"AudioDataFormat      :   LBR\n");
        }
        else
        {
            PROC_PRINT(s,"AudioDataFormat      :   LPCM\n");       
        }
    }
        
    
  //  PROC_PRINT(s,"SoftMute             :   %s\n",pstAudioCtx->bSoftMute? "Yes":"No");
  //  PROC_PRINT(s,"layout               :   %s\n",pstAudioCtx->blayout1? "Yes":"No");
    #if SUPPORT_AEC
 //   PROC_PRINT(s,"ExceptionsEn         :   %s\n",pstAudioCtx->bExceptionsEn? "Yes":"No");
    #endif
   // PROC_PRINT(s,"AudioIsOn            :   %s\n",pstAudioCtx->bAudioIsOn? "Yes":"No");
    PROC_PRINT(s,"MeasuredFs           :   %d\n",pstAudioCtx->u32MeasuredFs);
    switch (pstAudioCtx->u32MeasuredFs)
	{
		case AUDIO_CHST4_FS_44:
            PROC_PRINT(s,"Audio sample rate    :   %s\n","44kHz");
			break;
		case AUDIO_CHST4_FS_48:
            PROC_PRINT(s,"Audio sample rate    :   %s\n","48kHz");
			break;
		case AUDIO_CHST4_FS_32:
            PROC_PRINT(s,"Audio sample rate    :   %s\n","32kHz");
			break;
		case AUDIO_CHST4_FS_22:
            PROC_PRINT(s,"Audio sample rate    :   %s\n","22kHz");
			break;
		case AUDIO_CHST4_FS_24:
            PROC_PRINT(s,"Audio sample rate    :   %s\n","24kHz");
			break;
		case AUDIO_CHST4_FS_88:
            PROC_PRINT(s,"Audio sample rate    :   %s\n","88kHz");
			break;
		case AUDIO_CHST4_FS_96:
            PROC_PRINT(s,"Audio sample rate    :   %s\n","96kHz");
			break;
		case AUDIO_CHST4_FS_176:
            PROC_PRINT(s,"Audio sample rate    :   %s\n","176kHz");
			break;			
		case AUDIO_CHST4_FS_192:
            PROC_PRINT(s,"Audio sample rate    :   %s\n","192kHz");
			break;
        case AUDIO_CHST4_FS_768:
            PROC_PRINT(s,"Audio sample rate    :   %s\n","768kHz");
			break;	
		default:
            PROC_PRINT(s,"Audio sample rate    :   %s\n","unknown");
			break;			
	}
	
    
    PROC_PRINT(s,"au32ChannelSta       :   0x%x,0x%x,0x%x,0x%x,0x%x\n",\
    pstAudioCtx->au32ChannelSta[0],pstAudioCtx->au32ChannelSta[1],pstAudioCtx->au32ChannelSta[2],\
    pstAudioCtx->au32ChannelSta[3],pstAudioCtx->au32ChannelSta[4]);
    }
    
   

   
    return HI_SUCCESS;
}

HI_S32 DRV_HDMIRX_CTRL_ProcWrite(struct file * file,
        const char __user * buf, size_t count, loff_t *ppos)
{
    HI_CHAR buffer[128];
    HI_CHAR *pArg1, *pArg2; 
    HI_U32 u32Temp,u32Value;
    HI_BOOL  u32PrintHelp = HI_FALSE;
    HDMIRX_CTRL_CONTEXT_S *pstCtrlCtx;  
    HDMIRX_COLOR_SPACE_E enColorSpace;
    HI_UNF_HDMIRX_PORT_E enCurPort;
    VIDEO_TIMING_DEFINE_S TimingInfo;
        
    HI_CHAR *s_outputcfg[] = 
    {
        "Red; Green; Blue",
        "Red; Blue; Green",
        "Green; Red; Blue",
        "Green; Blue; Red",
        "Blue; Red; Green",
        "Blue; Green; red"
    };
    HI_CHAR *s_inputcfg[] = 
    {
        " phy data[23:16]",
        " phy data[15:8]",
        " phy data[7:0]"
    }; 
    pstCtrlCtx = HDMIRX_CTRL_GET_CTX();
    enCurPort = pstCtrlCtx->enCurPort;
    if (count > (sizeof(buffer) - 1))
    {
        HI_DRV_PROC_EchoHelper("The command string is out of buf space :%d bytes !\n", sizeof(buffer));
        return 0;
    }

    if (copy_from_user(buffer, buf, count))
    {
        HI_DRV_PROC_EchoHelper("failed to call copy_from_user !\n");
        return 0;
    }
    buffer[count] = '\0';

    if(HDMIRX_DRV_CTRL_PROCParseCmd(buffer, &pArg1, &pArg2) == HI_SUCCESS) 
    {      
        if(strncmp("stop", pArg1, 4) == 0)
        {
            pstCtrlCtx->bRun=HI_FALSE;
            HI_DRV_PROC_EchoHelper("Thread stop\n");
        }
        else if(strncmp("resume", pArg1, 6) == 0)
        {
            pstCtrlCtx->bRun=HI_TRUE;
            HI_DRV_PROC_EchoHelper("Thread resume\n");
        }
        else if(strncmp("bypass", pArg1, 6) == 0)
        {
            if(HDMIRX_HAL_Getvidpath(enCurPort) == HDMIRX_VIDPATH_NORMAL)
            {
               HDMIRX_HAL_Setvidpath(enCurPort,HDMIRX_VIDPATH_BYPASS);
               HI_DRV_PROC_EchoHelper("Video path is bypass mode !\n");
            }
            else
            {
                HDMIRX_HAL_Setvidpath(enCurPort,HDMIRX_VIDPATH_NORMAL); 
                HI_DRV_PROC_EchoHelper("Video path is normal mode !\n"); 
            }           
        }
        else if(strncmp("pwrinv", pArg1, 6) == 0)
        {
            
            volatile U_SC_HDMI_RX_HPD_PWR_PCTRL SC_HDMI_RX_HPD_PWR_PCTRL;;
            u32Temp = 1<<enCurPort;
            SC_HDMI_RX_HPD_PWR_PCTRL.u32 = g_pstRegSysCtrl->SC_HDMI_RX_HPD_PWR_PCTRL.u32;
            if((SC_HDMI_RX_HPD_PWR_PCTRL.bits.hdmi_rx_pwr_pctrl & u32Temp)==0)
            {
                SC_HDMI_RX_HPD_PWR_PCTRL.bits.hdmi_rx_pwr_pctrl |=u32Temp;   
            }
            else
            {
                SC_HDMI_RX_HPD_PWR_PCTRL.bits.hdmi_rx_pwr_pctrl &=~u32Temp;
            }
            g_pstRegSysCtrl->SC_HDMI_RX_HPD_PWR_PCTRL.u32 = SC_HDMI_RX_HPD_PWR_PCTRL.u32;
            HI_DRV_PROC_EchoHelper("now: reg 0x44 = 0x%x. \n",SC_HDMI_RX_HPD_PWR_PCTRL.bits.hdmi_rx_pwr_pctrl);
        
        }
        else if(strncmp("avs", pArg1, 3) == 0)
        {
            if(HDMIRX_HAL_GetCoreiso(enCurPort) == HDMIRX_Coreiso_NORMAL)
            {
               HDMIRX_HAL_SetCoreiso(enCurPort,HDMIRX_Coreiso_BYPASS);
               HI_DRV_PROC_EchoHelper("A/V split bypass!\n");
            }
            else
            {
                HDMIRX_HAL_SetCoreiso(enCurPort,HDMIRX_Coreiso_NORMAL); 
                HI_DRV_PROC_EchoHelper("A/V split normal!\n"); 
            } 
        }
        else if(strncmp("fhdmi", pArg1, 5) == 0)
        {
            if(HDMIRX_HAL_ReadFldAlign(enCurPort,RX_SW_HDMI_MODE, reg_hdmi_mode_overwrite))
            {
                HDMIRX_HAL_WriteFldAlign(enCurPort,RX_SW_HDMI_MODE,reg_hdmi_mode_sw_value,0);
                HDMIRX_HAL_WriteFldAlign(enCurPort,RX_SW_HDMI_MODE,reg_hdmi_mode_overwrite,0);
                HI_DRV_PROC_EchoHelper("auto hdmi mode!\n");
            }
            else
            {
                HDMIRX_HAL_WriteFldAlign(enCurPort,RX_SW_HDMI_MODE,reg_hdmi_mode_sw_value,1);
                HDMIRX_HAL_WriteFldAlign(enCurPort,RX_SW_HDMI_MODE,reg_hdmi_mode_overwrite,1);
                HI_DRV_PROC_EchoHelper("force hdmi mode!\n");
            }
        }
        else if(strncmp("outchan", pArg1, 7) == 0)
        {
            enColorSpace = HDMIRX_PACKET_AVI_GetColorSpace();
            if(enColorSpace == HDMIRX_COLOR_SPACE_RGB)
            {
            u32Temp = HDMIRX_HAL_ReadFldAlign(enCurPort,RX_VID_CH_MAP, reg_channel_map)&0x07;
            if(u32Temp == 5)
            {
                u32Temp = 0;
            }
            else
            {
                u32Temp++;
            }
            HDMIRX_HAL_WriteFldAlign(enCurPort,RX_VID_CH_MAP, reg_channel_map,u32Temp);
            u32Temp = HDMIRX_HAL_ReadFldAlign(enCurPort,RX_VID_CH_MAP, reg_channel_map);
            HI_DRV_PROC_EchoHelper(" the output is {%s}. \n", s_outputcfg[u32Temp]);
            }
            else
            {
            u32PrintHelp = HI_TRUE;
            HI_DRV_PROC_EchoHelper("the input is not RGB!\n");
            }
        }
        else if(strncmp("ch0sel", pArg1, 6) == 0)
        {
            u32Temp = HDMIRX_HAL_ReadFldAlign(enCurPort,SYS_TMDS_CH_MAP, reg_di_ch0_sel);
            if(u32Temp == 0)
            {
                u32Temp = 1;
            }
            else if(u32Temp == 1)
            {
               u32Temp = 2;
            }
            else if(u32Temp == 2)
            {
                u32Temp = 0;
            }
            HDMIRX_HAL_WriteFldAlign(enCurPort,SYS_TMDS_CH_MAP, reg_di_ch0_sel, u32Temp);
            HI_DRV_PROC_EchoHelper("TMDS Data select for channel #0 will take tmds %s. \n", s_inputcfg[u32Temp]);             
        }
        else if(strncmp("ch1sel", pArg1, 6) == 0)
        {
            u32Temp = HDMIRX_HAL_ReadFldAlign(enCurPort,SYS_TMDS_CH_MAP, reg_di_ch1_sel);
            if(u32Temp == 0)
            {
                u32Temp = 1;
            }
            else if(u32Temp == 1)
            {
               u32Temp = 2;
            }
            else if(u32Temp == 2)
            {
                u32Temp = 0;
            }
            HDMIRX_HAL_WriteFldAlign(enCurPort,SYS_TMDS_CH_MAP, reg_di_ch1_sel, u32Temp);
            HI_DRV_PROC_EchoHelper("TMDS Data select for channel #1 will take tmds %s. \n", s_inputcfg[u32Temp]);
        }
        else if(strncmp("ch2sel", pArg1, 6) == 0)
        {
            u32Temp = HDMIRX_HAL_ReadFldAlign(enCurPort,SYS_TMDS_CH_MAP, reg_di_ch2_sel);
            if(u32Temp == 0)
            {
                u32Temp = 1;
            }
            else if(u32Temp == 1)
            {
               u32Temp = 2;
            }
            else if(u32Temp == 2)
            {
                u32Temp = 0;
            }
            HDMIRX_HAL_WriteFldAlign(enCurPort,SYS_TMDS_CH_MAP, reg_di_ch2_sel, u32Temp);
            HI_DRV_PROC_EchoHelper("TMDS Data select for channel #2 will take tmds %s. \n", s_inputcfg[u32Temp]);
        }
        else if(strncmp("selport", pArg1, 7) == 0)
        {
            if((pArg2!= NULL)&&(pArg2[0] >= '0') && (pArg2[0] <= '3'))
            {
                u32Temp = pArg2[0] - '0';
                HDMIRX_DRV_CTRL_Disconnect();
                HDMIRX_DRV_CTRL_Connect(u32Temp);
                HI_DRV_PROC_EchoHelper("Connect port %d SUCESS!\n",u32Temp);
            }
            else
            {
                u32PrintHelp = HI_TRUE;
                HI_DRV_PROC_EchoHelper("Input Error!\n");
            }

        }
        else if(strncmp("sethpd", pArg1, 6) == 0)
        {
            if((pArg2!= NULL)&&((pArg2[0] == '0') || (pArg2[0] == '1')))
            {
             u32Value = pArg2[0] - '0'; 
             HDMIRX_HAL_SetHpdLevel(enCurPort,u32Value);            
            }
            else
            {
                u32PrintHelp = HI_TRUE;
                HI_DRV_PROC_EchoHelper("Input Error!\n");
            }
        }
        else if(strncmp("swrst", pArg1, 5) == 0)
        {
            HDMIRX_HAL_SetResetEn(enCurPort,HDMIRX_SOFT_RST,HI_TRUE);
            HI_DRV_PROC_EchoHelper("Hold soft reset!\n");
            msleep(10);
            HDMIRX_HAL_SetResetEn(enCurPort,HDMIRX_SOFT_RST,HI_FALSE);
            HI_DRV_PROC_EchoHelper("Cancel soft reset!\n");
        }
        else if(strncmp("rstfifo", pArg1, 7) == 0)
        {
            HDMIRX_HAL_SetResetEn(enCurPort,HDMIRX_AUDIO_FIFO_RST, HI_TRUE);
		    udelay(10);
		    HDMIRX_HAL_SetResetEn(enCurPort,HDMIRX_AUDIO_FIFO_RST, HI_FALSE);
        }
        else if(strncmp("getid", pArg1, 5) == 0)
        {
            u32Value = 0;            
            if((pArg2!= NULL))
            {
                for(u32Temp = 0;(pArg2[u32Temp] != '\0');u32Temp++)  
                {
                    if((pArg2[u32Temp]>='0')&&(pArg2[u32Temp]<='9'))
                    {
                        u32Value = u32Value*10 + (pArg2[u32Temp] - '0') ;                      
                    }                      
                }
                if(u32Value <= TIMING_MAX)
                {
                    memset(&TimingInfo , 0, sizeof(VIDEO_TIMING_DEFINE_S));
                    HDMIRX_VIDEO_GetTableInfo(u32Value, &TimingInfo);
                    HI_DRV_PROC_EchoHelper("-------Timing Table Info------\n");
                    HI_DRV_PROC_EchoHelper("ID      :%d\n",u32Value);
                    HI_DRV_PROC_EchoHelper("HTotal  :%d-----%d\n",TimingInfo.strTotal.H - PIXELS_TOLERANCE,TimingInfo.strTotal.H + PIXELS_TOLERANCE);
                    HI_DRV_PROC_EchoHelper("VTotal  :%d-----%d\n",TimingInfo.strTotal.V - LINES_TOLERANCE,TimingInfo.strTotal.V + LINES_TOLERANCE);
                    HI_DRV_PROC_EchoHelper("PixClk  :%d-----%d\n",TimingInfo.PixClk - FPIX_TOLERANCE,TimingInfo.PixClk + FPIX_TOLERANCE);
                    HI_DRV_PROC_EchoHelper("Hpol    :%s\n",TimingInfo.HPol ? "POS" : "NEG");
                    HI_DRV_PROC_EchoHelper("Vpol    :%s\n",TimingInfo.VPol ? "POS" : "NEG");
                    
                }
                else
                {
                    u32PrintHelp = HI_TRUE;
                    HI_DRV_PROC_EchoHelper("Timing ID should not exceed 46!\n");   
                }
            }
            else
            {
                u32PrintHelp = HI_TRUE;
                HI_DRV_PROC_EchoHelper("Please input Timing ID!\n");
            }
        }
        else if(strncmp("getedid", pArg1, 7) == 0)
        {
            HI_DRV_PROC_EchoHelper("####EDID:");
            for(u32Temp=0;u32Temp<256;u32Temp++)
            {
                if(u32Temp%16 == 0)
                {
                    HI_DRV_PROC_EchoHelper("\n");
                }
                HI_DRV_PROC_EchoHelper("0x%-4x",stEdidData.au32Edid[u32Temp]);              
            }
            HI_DRV_PROC_EchoHelper("\n");
        }
        else if(strncmp("gethdcp", pArg1, 7) == 0)
        {
            HI_DRV_PROC_EchoHelper("####HDCP:");
            for(u32Temp=0;u32Temp<332;u32Temp++)
            {
                if(u32Temp%16 == 0)
                {
                    HI_DRV_PROC_EchoHelper("\n");
                }
                HI_DRV_PROC_EchoHelper("0x%-4x",stHdcpData.au32Hdcp[u32Temp]);              
            }
            HI_DRV_PROC_EchoHelper("\n");
        } 
        else if(strncmp("modechg", pArg1, 7) == 0)
        {
            for(u32Temp=0;u32Temp < MODECHGCNT;u32Temp++)
            {
                switch(pstCtrlCtx->enModeChgType[u32Temp])
                {
                    case HDMIRX_MODECHG_TYPE_HDCPERR:
                       HI_DRV_PROC_EchoHelper("%d: HDCP ERR \n",u32Temp);
                       break;
                    case HDMIRX_MODECHG_TYPE_WAITOUT:
                       HI_DRV_PROC_EchoHelper("%d: Time Wait Out \n",u32Temp);
                       break; 
                    case HDMIRX_MODECHG_TYPE_CKDT:
                       HI_DRV_PROC_EchoHelper("%d: Get CKDT \n",u32Temp);
                       break;
                    case HDMIRX_MODECHG_TYPE_NOPOW:
                       HI_DRV_PROC_EchoHelper("%d: No Pwr5V \n",u32Temp);
                       break;
                    case HDMIRX_MODECHG_TYPE_NOSCDT:
                       HI_DRV_PROC_EchoHelper("%d: No SCDT \n",u32Temp);
                       break;
                    case HDMIRX_MODECHG_TYPE_TIMINGCHG:
                       HI_DRV_PROC_EchoHelper("%d: Timing Change \n",u32Temp);
                       break;
                    case HDMIRX_MODECHG_TYPE_NOAVI:
                       HI_DRV_PROC_EchoHelper("%d: NO AVI \n",u32Temp);
                       break;
                    case HDMIRX_MODECHG_TYPE_AVICHG:
                       HI_DRV_PROC_EchoHelper("%d: AVI Info CHG \n",u32Temp);
                       break;
                    case HDMIRX_MODECHG_TYPE_VSIFCHG:
                       HI_DRV_PROC_EchoHelper("%d: VSIF Info CHG \n",u32Temp);
                       break;
                    default:
                        break;
                       
                }   
                    
            }
            
        }
        else if(strncmp("termmode", pArg1, 8) == 0)
        {
            if((pArg2!= NULL)&&((pArg2[0] == '0') || (pArg2[0] == '1')))
            {
                u32Value = pArg2[0] - '0';
                if(u32Value == 0)
                {
                    HDMIRX_HAL_SetTermMode(enCurPort, HDMIRX_TERM_SEL_OPEN);
                    HI_DRV_PROC_EchoHelper("set TermMode open!\n");
                }
                else
                {
                    if((HDMIRX_HAL_GetCbusSense(HI_UNF_HDMIRX_PORT0) == HI_TRUE) &&(enCurPort == HI_UNF_HDMIRX_PORT0))
                    {
                        HDMIRX_HAL_SetTermMode(enCurPort, HDMIRX_TERM_SEL_MHL);
                    }
                    else
                    {
                        HDMIRX_HAL_SetTermMode(enCurPort, HDMIRX_TERM_SEL_HDMI);
                    }
                    HI_DRV_PROC_EchoHelper("set TermMode HDMI!\n");
                }
            }
        }
#if SUPPORT_MHL       
        else if(strncmp("mhlset", pArg1, 6) == 0)
        {
            if((pArg2!= NULL)&&((pArg2[0] == '0') || (pArg2[0] == '1')))
            {
                u32Value = pArg2[0] - '0'; 
                if(u32Value == 0)
                {
                    HI_DRV_PROC_EchoHelper("Set MHL Rst False!\n");
                    HDMIRX_HAL_MHLRstEn(HI_FALSE); 
                }
                else
                {
                    HI_DRV_PROC_EchoHelper("Set MHL Rst True!\n");
                    HDMIRX_HAL_MHLRstEn(HI_TRUE);
                }
            }            
        }
        else if(strncmp("mhlcd", pArg1, 5) == 0)
        {
            if((pArg2!= NULL)&&((pArg2[0] == '0') || (pArg2[0] == '1')))
            {
                u32Value = pArg2[0] - '0'; 
                if(u32Value == 0)
                {
                    HDMIRX_HAL_MHL_SENSE_Enable(HI_FALSE);
                    HI_DRV_PROC_EchoHelper("Set CDSense false!\n");
                }
                else
                {
                    HDMIRX_HAL_MHL_SENSE_Enable(HI_TRUE);
                    HI_DRV_PROC_EchoHelper("Set CDSense true!\n");
                }
            }            
        }
        
        else if(strncmp("mhlreset", pArg1, 8) == 0)
        {
            //HDMIRX_MHL_Reset();
            HDMIRX_HAL_SetResetEn(HI_UNF_HDMIRX_PORT0, HDMIRX_HDMIM_RST, HI_TRUE);
            //HDMIRX_CTRL_SetHdmirxRstReason(HDMIRX_RST_MHL);
            msleep(400);
            HDMIRX_HAL_SetResetEn(HI_UNF_HDMIRX_PORT0, HDMIRX_HDMIM_RST, HI_FALSE);
        }
        /*
        else if(strncmp("mhlleft", pArg1, 7) == 0)
        {
            HDMIRX_MHL_SendRcp(3);
        }
        else if(strncmp("mhlright", pArg1, 8) == 0)
        {
            HDMIRX_MHL_SendRcp(4);
        }
        else if(strncmp("mhlup", pArg1, 5) == 0)
        {
            HDMIRX_MHL_SendRcp(1);
        }
        else if(strncmp("mhldown", pArg1, 7) == 0)
        {
            HDMIRX_MHL_SendRcp(2);
        }
        else if(strncmp("mhlsel", pArg1, 6) == 0)
        {
            HDMIRX_MHL_SendRcp(0);
        }
        else if(strncmp("mhlexit", pArg1, 7) == 0)
        {
            HDMIRX_MHL_SendRcp(13);
        }
          */         
#endif
        /*
        else if(strncmp("hdcperrch", pArg1, 9) == 0)
        {
            if(strncmp("en", pArg2, 2) == 0) 
            {
                pstCtrlCtx->bHdcpCheckEn = HI_TRUE;
            } 
            else if(strncmp("dis", pArg2, 3) == 0) 
            {
                pstCtrlCtx->bHdcpCheckEn = HI_FALSE;
            } else {
                u32PrintHelp = HI_TRUE;
            }  
        }
        */
        else
        {
            u32PrintHelp = HI_TRUE;
        }
              
    }
    else 
    {
        u32PrintHelp = HI_TRUE;
    }
    if(u32PrintHelp)
    {
        HI_DRV_PROC_EchoHelper("HDMI PROC CMD Help info:\n");
        HI_DRV_PROC_EchoHelper("CMD  : [echo cmd option > proc file]\n");
        HI_DRV_PROC_EchoHelper("HDMI PROC support cmd : \n");
        HI_DRV_PROC_EchoHelper("stop            : Disable HDMI Process\n");
        HI_DRV_PROC_EchoHelper("resume          : Restart HDMI Process\n");
        HI_DRV_PROC_EchoHelper("bypass          : Video path is enable or bypassed\n");
        HI_DRV_PROC_EchoHelper("pwrinv          : Change the curport 5v pol\n");
        HI_DRV_PROC_EchoHelper("avs             : bypass A/V split\n");
        HI_DRV_PROC_EchoHelper("fhdmi           : force hdmi mode\n");
        HI_DRV_PROC_EchoHelper("outchan         : swaps the three Byte digital video output\n");
        HI_DRV_PROC_EchoHelper("ch0sel          : TMDS Data select for channel #0:\n");
        HI_DRV_PROC_EchoHelper("ch1sel          : TMDS Data select for channel #1:\n");
        HI_DRV_PROC_EchoHelper("ch2sel          : TMDS Data select for channel #2:\n");
        HI_DRV_PROC_EchoHelper("selport x       : Change curport to x\n");
        HI_DRV_PROC_EchoHelper("sethpd x        : set the curport HPD to x\n");
        HI_DRV_PROC_EchoHelper("swrst           : soft reset\n");
        HI_DRV_PROC_EchoHelper("getid x         : get Timing information from Table\n");
        HI_DRV_PROC_EchoHelper("getedid         : get EDID data\n");
        HI_DRV_PROC_EchoHelper("gethdcp         : get HDCP data\n");        
        HI_DRV_PROC_EchoHelper("modechg         : get Mode Change Info\n");    
        HI_DRV_PROC_EchoHelper("termmode x      : set TermMode x, 0:open 1:HDMI\n");
#if SUPPORT_MHL
        HI_DRV_PROC_EchoHelper("mhlset x        : set Rst to x\n");
        HI_DRV_PROC_EchoHelper("mhlcd x         : Set CDSense to x\n");
        HI_DRV_PROC_EchoHelper("mhlreset        : MHL reset\n");
        /*
        HI_DRV_PROC_EchoHelper("mhlleft         : MHL LEFT\n");
        HI_DRV_PROC_EchoHelper("mhlright        : MHL reset\n");
        HI_DRV_PROC_EchoHelper("mhlup           : MHL reset\n");
        HI_DRV_PROC_EchoHelper("mhldown         : MHL reset\n");
        HI_DRV_PROC_EchoHelper("mhlsel          : MHL reset\n");
        HI_DRV_PROC_EchoHelper("mhlexit         : MHL reset\n");
        */
#endif
        HI_DRV_PROC_EchoHelper("rstfifo         : reset the Audio fifo and un-reset\n");
        HI_DRV_PROC_EchoHelper("hdcperrch en    : HDCP err check enable.\n");
        HI_DRV_PROC_EchoHelper("hdcperrch dis   : HDCP err check disable.\n");
        HI_DRV_PROC_EchoHelper("For example, if you want to set the curport HPD to 1\n");   
        HI_DRV_PROC_EchoHelper("  echo sethpd 1 > /proc/msp/hdmirx\n");
        
    }
    
    return count;
    
}

#ifdef __cplusplus
 #if __cplusplus
}
 #endif
#endif /* __cplusplus */
