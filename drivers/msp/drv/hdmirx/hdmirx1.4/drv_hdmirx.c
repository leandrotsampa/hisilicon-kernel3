#include <linux/kthread.h>
#include <linux/init.h>
#include <linux/delay.h>
//#include <linux/sched.h>
//#include <linux/spinlock.h>
#include <asm/io.h>

#include <linux/interrupt.h>
#include "drv_hdmirx_isr_internal.h"


//#include "int.h"

//#include "command.h"
#include "drv_hdmirx_isr.h"
#include "drv_hdmirx_audio.h"
#include "drv_hdmirx.h"
#include "drv_hdmirx_sys.h"
#include "drv_hdmirx_video.h"
#include "drv_hdmirx_info.h"
#include "drv_hdmirx_cec.h"
#include "hi_drv_hdmirx.h"
#include "hal_hdmirx.h"
#include "hi_drv_module.h"
#include "drv_gpioi2c_ext.h"
#include "drv_cipher_ext.h"
#include "hi_reg_common.h"


#define HDMI_BASE 0xf8cf0000
#define HDMIRX_INT_NUM (87+32)

extern struct hdmistatus hdmi_ctx;
extern HI_U32 HDMI_VIRTUL_ADDR_BASE;
HI_BOOL  HDMI_RUN;

extern HI_VOID HDMI_VDO_GetWH(HI_U16 *pu16W, HI_U16 *pu16H);


int HDMI_MainLoop(void *data)
{

    while(HDMI_RUN) {

#if 0 /*--NO MODIFY : COMMENT BY CODINGPARTNER--*/
        HI_INFO_HDMIRX("%d\n",hdmi_ctx.u32HdmiState);
#endif /*--NO MODIFY : COMMENT BY CODINGPARTNER--*/
        
        if(hdmi_ctx.bConnect == HI_FALSE)
            goto sleep;
        // the totoal timer
        if (hdmi_ctx.Timer[HDMI_TIMER_IDX_ISR] > 0) {
            hdmi_ctx.Timer[HDMI_TIMER_IDX_ISR]++;        /* for ISR handler */
        }
        if (hdmi_ctx.Timer[HDMI_TIMER_IDX_ISR_1] > 0) {
            hdmi_ctx.Timer[HDMI_TIMER_IDX_ISR_1]++;        /* for isr timer handler */
        }
        if (hdmi_ctx.Timer[HDMI_TIMER_IDX_VIDEO] > 0) {
            hdmi_ctx.Timer[HDMI_TIMER_IDX_VIDEO]++;        /* for video handler */
        }
        #if SUPPORT_AUDIO
        hdmi_ctx.Timer[HDMI_TIMER_IDX_AUDIO]++;        /* for audio statemachine */
        #endif
        if (hdmi_ctx.Timer[HDMI_TIMER_IDX_AUDIO] >= AUDIO_TIMER_MAX) {
            hdmi_ctx.Timer[HDMI_TIMER_IDX_AUDIO] = AUDIO_TIMER_MAX;
        }

        if (hdmi_ctx.Timer[HDMI_TIMER_IDX_INFO] > 0) {
            hdmi_ctx.Timer[HDMI_TIMER_IDX_INFO]++;
        }
        if ((hdmi_ctx.Timer[HDMI_TIMER_IDX_VIDEO] >= hdmi_ctx.u32SleepTime)&&(hdmi_ctx.Timer[HDMI_TIMER_IDX_VIDEO] > 0)) {
            hdmi_ctx.Timer[HDMI_TIMER_IDX_VIDEO] = 1;

        if(hdmi_ctx.Timer[HDMI_TIMER_IDX_CEC_SEND] > 0) {
            hdmi_ctx.Timer[HDMI_TIMER_IDX_CEC_SEND]++;
        }
        switch(hdmi_ctx.u32HdmiState) {
            
            case HDMI_STATE_INIT:
                
                HDMI_Initial();
                HDMI_HDCP_Reset();
                //HI_INFO_HDMIRX("DDC On 1 \n");
                HDMI_SYS_DdcOnOff(HI_TRUE);
                HDMI_SYS_DisPipe();
                HDMI_SYS_InputOnOff(HI_TRUE);
                HDMI_VDO_ChangeState(HDMI_STATE_IDLE);
                HDMI_VDO_MuteOnOff(HI_TRUE);
                break;
                
            case HDMI_STATE_IDLE:  
                
                HDMI_PowerDownProc();
                break;

            case HDMI_STATE_SYNC_SEARCH:
                
                HDMI_SyncInChangeProc();
                break;

             case HDMI_STATE_SYNC_STABLE:
                if (HDMI_VDO_ModeDet() == HI_TRUE) {
                    HDMI_VDO_ChangeState(HDMI_STATE_FORMAT_DETECTED);
                    //HI_INFO_HDMIRX("DDC On 2 \n");
                    //HDMI_SYS_DdcOnOff(HI_TRUE);
                }
                else {
                    HDMI_VDO_MuteOnOff(HI_TRUE);
                    #if SUPPORT_AUDIO
                    HDMI_AUD_Stop(HI_TRUE);
                    #endif
                    //HI_INFO_HDMIRX("HDMI_AUD_Stop-- HDMI_STATE_SYNC_STABLE \n");
                    #if 0
                    HDMI_INFO_AvMuteRequest(HI_TRUE, RX_OUT_AV_MUTE_M__RX_IS_NOT_READY);
                    #endif
                    HDMI_VDO_ChangeState(HDMI_STATE_NOT_SUPPORTED);
                }
                    
                break;
            case HDMI_STATE_FORMAT_DETECTED:
                HDMI_VDO_SetVideoPath();
                HDMI_VDO_ChangeState(HDMI_STATE_VIDEO_ON);
                HDMI_VDO_MuteOnOff(HI_FALSE);
                #if SUPPORT_AUDIO
                if (hdmi_ctx.bHdmiMode == HI_TRUE) {
                    HDMI_AUD_Restart();
                   // HI_INFO_HDMIRX("audio Restart 2 \n");
                }
                else {
                    HDMI_AUD_UpdateFs();
                }
                #endif
                break;
             case HDMI_STATE_VIDEO_ON:
                
                #if SUPPORT_AUDIO
                if(HDMI_AUD_IsAvMute() == HI_TRUE) {
                    HDMI_SYS_SwReset();
                }
                #endif
                break;
             case HDMI_STATE_RECHECK_FORMAT:
                
				// VMD_DetectVideoResolution() does following:
				// 1. Checks if video timing is valid.
				// 2. Updates RTPI registers with timing info.
				if(HDMI_VDO_ModeDet() == HI_TRUE)
				{
					// Resolution successfully detected.
					// Return to previous state - RXVS__VIDEO_ON.
					HDMI_VDO_ChangeState(HDMI_STATE_VIDEO_ON);
				}
				else
				{
					// cannot find video resolution
					HDMI_VDO_MuteOnOff(HI_TRUE);
                    #if SUPPORT_AUDIO
					HDMI_AUD_Stop(HI_TRUE);
                    #endif
                    //HI_INFO_HDMIRX("HDMI_AUD_Stop-- HDMI_STATE_RECHECK_FORMAT \n");
					HDMI_VDO_ChangeState(HDMI_STATE_NOT_SUPPORTED);
				}
				break;
             default:
                break;
            
        }
        }
         #if 1
         #if SUPPORT_AUDIO
            HDMI_AUD_MainLoop();
         #endif
        if (hdmi_ctx.Timer[HDMI_TIMER_IDX_ISR] > 1) {
            hdmi_ctx.Timer[HDMI_TIMER_IDX_ISR] = 1;
          //	/*libo@201404*/	  HDMI_ISR_Handler();
            #if SUPPORT_CEC
            HDMI_CEC_Isr();
            #endif
        }
       
        if (hdmi_ctx.Timer[HDMI_TIMER_IDX_ISR_1] > 5) {
            hdmi_ctx.Timer[HDMI_TIMER_IDX_ISR_1] = 1;
            HDMI_ISR_TimerHandler();
        }
        
        if (hdmi_ctx.Timer[HDMI_TIMER_IDX_INFO] > INFO_TIME_UNIT) {
            hdmi_ctx.Timer[HDMI_TIMER_IDX_INFO] = 1;
            HDMI_INFO_TimerProc();
        }
        #endif
        #if SUPPORT_CEC
        hdmi_ctx.Timer[HDMI_TIMER_IDX_CEC]++;
        if (hdmi_ctx.Timer[HDMI_TIMER_IDX_CEC_SEND] > 0) {
            hdmi_ctx.Timer[HDMI_TIMER_IDX_CEC_SEND]++;
        }
        HDMI_CEC_Handler();
        if (hdmi_ctx.Timer[HDMI_TIMER_IDX_COM]) {
            hdmi_ctx.Timer[HDMI_TIMER_IDX_COM]++;
        }
        #endif
        
sleep:
        msleep(10);
        
    }
    return 0;
}

HI_VOID HDMI_CRG_CFG(HI_VOID)
#if 0 /*--NO MODIFY : COMMENT BY CODINGPARTNER--*/
{
    HDMI_HAL_HAL_Init();

    HDMI_HAL_Write(0x62, 0x5c, 0x0a); //œÒÀÿ ±÷”X1£¨ƒ¨»œŒ™X2Ωµ∆µ“ª∞Î
    HDMI_HAL_Write(0x62, 0x69, 0x9c); //
    HDMI_HAL_Write(0x62, 0x02, 0x02); //
    HDMI_HAL_Write(0x62, 0x0a, 0xa0); //
    HDMI_HAL_Write(0x62, 0x0b, 0xf3); //
    HDMI_HAL_Write(0x62, 0x0c, 0xe3); //
    HDMI_HAL_Write(0x62, 0x0d, 0xf3); //
    HDMI_HAL_Write(0x62, 0x0e, 0xa0); //
    HDMI_HAL_Write(0x62, 0x0f, 0xa0); //
    HDMI_HAL_Write(0x62, 0x10, 0xa0); //
    HDMI_HAL_Write(0x62, 0x10, 0xa0); //
    HDMI_HAL_Write(0x62, 0x08, 0xe3); //
    HDMI_HAL_Write(0x62, 0x09, 0xa0); //

}
#else
{
    HI_VOID *pvIOCFG    = HI_NULL;
    HI_VOID *pvIOCFGPhy = HI_NULL;
    
    /* ≈‰÷√π‹Ω≈∏¥”√ */
    pvIOCFG = (HI_VOID *)ioremap_nocache(0xf8a20000 ,0x1000);
    if (HI_NULL == pvIOCFG)
    {
        HDMIRX_DEBUG("IOCFG remap failed\n");
        return;
    }

    *(HI_U32 *)(pvIOCFG + 0x0008) &= 0xe7ffffff;
    iounmap(pvIOCFG);
    pvIOCFG = HI_NULL;
    
    /* ≈‰÷√π‹Ω≈∏¥”√ */
    pvIOCFG = (HI_VOID *)ioremap_nocache(0xf8a21000 ,0x1000);
    if (HI_NULL == pvIOCFG)
    {
        HDMIRX_DEBUG("IOCFG remap failed\n");
        return;
    }

    //*(HI_U32 *)(pvIOCFG + 0x014) = 0x2;
    //*(HI_U32 *)(pvIOCFG + 0x018) = 0x2;
    *(HI_U32 *)(pvIOCFG + 0x01c) = 0x1;
    *(HI_U32 *)(pvIOCFG + 0x020) = 0x1;
    *(HI_U32 *)(pvIOCFG + 0x024) = 0x1;
    
    *(HI_U32 *)(pvIOCFG + 0x00b0) = 0x01;
    *(HI_U32 *)(pvIOCFG + 0x00b4) = 0x01;
    *(HI_U32 *)(pvIOCFG + 0x00b8) = 0x01;
    *(HI_U32 *)(pvIOCFG + 0x00bc) = 0x01;
    *(HI_U32 *)(pvIOCFG + 0x00c0) = 0x01;
    *(HI_U32 *)(pvIOCFG + 0x00c4) = 0x01;
    *(HI_U32 *)(pvIOCFG + 0x00c8) = 0x01;
    *(HI_U32 *)(pvIOCFG + 0x00cc) = 0x01;
    *(HI_U32 *)(pvIOCFG + 0x00d0) = 0x01;
    *(HI_U32 *)(pvIOCFG + 0x00d4) = 0x01;

    iounmap(pvIOCFG);
    pvIOCFG = HI_NULL;

    /* ≈‰÷√ ±÷” */
    pvIOCFG = (HI_VOID *)ioremap_nocache(0xf8a22000 ,0x1000);
    if (HI_NULL == pvIOCFG)
    {
        HDMIRX_DEBUG("IOCFG remap failed\n");
        return;
    }
    *(HI_U32 *)(pvIOCFG + 0x0104) = 0x3f;

    *(HI_U32 *)(pvIOCFG + 0x0108) = 0xE17;
    
    msleep(10);

    *(HI_U32 *)(pvIOCFG + 0x0108) = 0x07;//0x207;

    msleep(10);

    /* ≈‰÷√phy */
    pvIOCFGPhy = (HI_VOID *)ioremap_nocache(0xf8cf3000 ,0x1000);
    if (HI_NULL == pvIOCFG)
    {
        HDMIRX_DEBUG("IOCFG remap failed\n");
        return;
    }

    /*
    *(HI_U32 *)(pvIOCFGPhy + 0x0DA4) = 0x9c ;
    *(HI_U32 *)(pvIOCFGPhy + 0x0DB0) = 0x12 ;
    *(HI_U32 *)(pvIOCFGPhy + 0x0D9C) = 0x33 ;
    *(HI_U32 *)(pvIOCFGPhy + 0x0D94) = 0x7f ;
    *(HI_U32 *)(pvIOCFGPhy + 0x0C00) = 0x0  ;
    *(HI_U32 *)(pvIOCFGPhy + 0x0C04) = 0x2  ;
    *(HI_U32 *)(pvIOCFGPhy + 0x0C14) = 0x48 ;
    *(HI_U32 *)(pvIOCFGPhy + 0x0d70) = 0xa  ;
    *(HI_U32 *)(pvIOCFGPhy + 0x0C60) = 0x0  ;
    *(HI_U32 *)(pvIOCFGPhy + 0x0C68) = 0x0  ;
    *(HI_U32 *)(pvIOCFGPhy + 0x0CE0) = 0x40 ;
*/

    *(HI_U32 *)(pvIOCFGPhy + 0x0D7C) = 0x09;
    *(HI_U32 *)(pvIOCFGPhy + 0x0c08) = 0x02;
    *(HI_U32 *)(pvIOCFGPhy + 0x0C28) = 0xA0;
    *(HI_U32 *)(pvIOCFGPhy + 0x0C2C) = 0xf3;
    *(HI_U32 *)(pvIOCFGPhy + 0x0C30) = 0xe3;
    *(HI_U32 *)(pvIOCFGPhy + 0x0C34) = 0xf3;
    *(HI_U32 *)(pvIOCFGPhy + 0x0C38) = 0xA0;
    *(HI_U32 *)(pvIOCFGPhy + 0x0C3C) = 0xA0;
    *(HI_U32 *)(pvIOCFGPhy + 0x0C40) = 0xA0;
    *(HI_U32 *)(pvIOCFGPhy + 0x0C44) = 0xA0;
    *(HI_U32 *)(pvIOCFGPhy + 0x0D94) = 0x4f;
    *(HI_U32 *)(pvIOCFGPhy + 0x0D9C) = 0x33;
    *(HI_U32 *)(pvIOCFGPhy + 0x0D70) = 0x0a;
    *(HI_U32 *)(pvIOCFGPhy + 0x0D90) = 0xc1;
    *(HI_U32 *)(pvIOCFGPhy + 0x0C20) = 0xe3;
    *(HI_U32 *)(pvIOCFGPhy + 0x0C14) = 0x08;

    HI_INFO_HDMIRX("phy cfg 0x0C24 = %#x:0xa0\n", *(HI_U32 *)(pvIOCFGPhy + 0x0C24));

    iounmap(pvIOCFGPhy);
    pvIOCFGPhy = HI_NULL;
    

    msleep(10);

    *(HI_U32 *)(pvIOCFG + 0x0104) = 0x71F;

    msleep(10);

    *(HI_U32 *)(pvIOCFG + 0x0104) = 0x1F;

    iounmap(pvIOCFG);
    pvIOCFG = HI_NULL;

    

}
#endif /*--NO MODIFY : COMMENT BY CODINGPARTNER--*/

irqreturn_t HDMIRX_PHY_InterruptHandler(int irq, void *dev_id)
{
    HI_U32      *interrupts;
    HI_U32      i;
    HI_U32 u32INT[INTR_BUTT]=
    {   RX_INTR1, RX_INTR2, RX_INTR3, RX_INTR4, RX_INTR5, RX_INTR6,\
        RX_INTR7, RX_INTR8, RX_INTR2_AON, RX_INTR6_AON, RX_INTR8_AON
    };

    interrupts = hdmi_ctx.strRxInt.u32Int;

    for(i = INTR1; i < INTR_BUTT; i++)
    {
        interrupts[i] = HDMI_HAL_RegRead(u32INT[i]);
        HDMI_HAL_RegWrite(u32INT[i], interrupts[i]);
        //HI_INFO_HDMIRX("INT[%d]:0x%x\n", i+1, interrupts[i]);      /*libo@201312*/ 
    }
    HDMI_ISR_Handler(interrupts);

    return IRQ_HANDLED;
}


/* HDMI initial */
HI_S32 HDMI_Connect(void)
{

    /* ≈‰÷√π‹Ω≈∏¥”√πÿœµ */
    HDMI_CRG_CFG();
    
    HDMI_VIRTUL_ADDR_BASE = (HI_U32)IO_ADDRESS(HDMI_BASE);
    
    hdmi_ctx.u32HdmiState = HDMI_STATE_BUTT;
    hdmi_ctx.Timer[HDMI_TIMER_IDX_ISR] = 0;
    hdmi_ctx.Timer[HDMI_TIMER_IDX_ISR_1] = 0;
    hdmi_ctx.Timer[HDMI_TIMER_IDX_VIDEO] = 1;
    hdmi_ctx.Timer[HDMI_TIMER_IDX_COM] = 0;
    HDMI_VDO_PowerOnRegInit();
    HDMI_SYS_GetDevId();
   // HDMI_ISR_PowerOnRegInit();
    #if SUPPORT_AUDIO
    HDMI_AUD_PowerOnRegInit();
    #endif
 // /*libo @201403*/  msleep(100*1000);
    msleep(1000);
    
    hdmi_ctx.u32SleepTime = 0;
    hdmi_ctx.bConnect = HI_TRUE;
    HI_INFO_HDMIRX("\n------------connect----------- \n");
    HDMI_VDO_ChangeState(HDMI_STATE_INIT);
    HDMI_SYS_EdidInit();
   // HDMI_SYS_SwRstOnOff(HI_FALSE);  // to cancel the soft reset.
    #if SUPPORT_CEC
    HDMI_CEC_Init(0x0000);
    HDMI_CEC_Resume();
    #endif
    msleep(800);

    HDMI_RUN = HI_TRUE;
    
    if (0 != request_irq(HDMIRX_INT_NUM, HDMIRX_PHY_InterruptHandler, IRQF_DISABLED, "hi_hdmirx_irq", HI_NULL))
    {
        HI_FATAL_HDMIRX("HDMIRX request_irq error.\n");
        return HI_FAILURE;
    }
    kthread_run(HDMI_MainLoop, NULL, "do nothing");
    
    return HI_SUCCESS;
}

void HDMI_DisConnect(void)
{
    HI_U32 i;
    HI_U32 u32INT[INTR_BUTT]=
    {   RX_INTR1_MASK, RX_INTR2_MASK, RX_INTR3_MASK, RX_INTR4_MASK, RX_INTR5_MASK, RX_INTR6_MASK,\
        RX_INTR7_MASK_AON, RX_INTR8_MASK, RX_INTR2_MASK_AON, RX_INTR6_MASK_AON, RX_INTR8_MASK_AON
    };
    
    for(i = INTR1; i < INTR_BUTT; i++)
    {
        HDMI_HAL_RegWrite(u32INT[i], 0x00);
       // HDMIRX_DEBUG("INT[%d]:0x%x\n", i, u32INT[i]);      /*libo@201312*/ 
    }
    
    HDMI_RUN = HI_FALSE;
    free_irq(HDMIRX_INT_NUM, HI_NULL);

    msleep(100);
}

HI_S32 HDMIRX_GetStatus(HI_UNF_SIG_STATUS_E *pstSigStatus)
{
    if(hdmi_ctx.u32HdmiState == HDMI_STATE_VIDEO_ON)
    {
        *pstSigStatus = HI_UNF_SIG_SUPPORT;
    }
    else
    {
        *pstSigStatus = HI_UNF_SIG_NO_SIGNAL;
    }
    

    return HI_SUCCESS;
}

HI_S32 HDMIRX_GetTiming(HI_UNF_HDMIRX_TIMING_INFO_S *pstTiming)
{

    pstTiming->u32Width = hdmi_ctx.strTimingInfo.u16Hactive;
    pstTiming->u32Height = hdmi_ctx.strTimingInfo.u16Vactive;
    pstTiming->u32FrameRate = hdmi_ctx.strTimingInfo.u8FrameRate;
    if(ColorSpace_RGB == hdmi_ctx.strTimingInfo.eColorM)
    {
        pstTiming->enColorSpace = HI_UNF_COLOR_SPACE_RGB;    
        pstTiming->enPixelFmt = HI_UNF_FORMAT_RGB_SEMIPLANAR_444;
    }
    else
    {
        pstTiming->enColorSpace = hdmi_ctx.strTimingInfo.eColorM;    
        pstTiming->enPixelFmt = HI_UNF_FORMAT_YUV_SEMIPLANAR_444;
    }
    pstTiming->enBitWidth = HI_UNF_PIXEL_BITWIDTH_10BIT;
    pstTiming->bInterlace = hdmi_ctx.strTimingInfo.bInterlaced;
    pstTiming->enOversample = HI_UNF_OVERSAMPLE_1X;
    pstTiming->en3dFmt = HI_UNF_FRAME_PACKING_TYPE_NONE;         
    pstTiming->bPcMode = hdmi_ctx.bHdmiMode ^ 0x01;     
    pstTiming->u32Vblank = 0;       
    pstTiming->u32TimingIdx = hdmi_ctx.strTimingInfo.u32VideoIdx;

    return HI_SUCCESS;
}


HI_S32 HDMIRX_DRV_CTRL_GetAudioStatus(HI_UNF_SIG_STATUS_E *penSigSta)
{

    hdmi_audio_state Audio_state;
    HDMIRX_CHECK_NULL_PTR(penSigSta);
    Audio_state = HDMIRX_AUDIO_Getstatus();

    if(HDMI_VDO_IsHdmiMode() == HI_FALSE)
    {
        *penSigSta = HI_UNF_SIG_NO_SIGNAL;
    }
    else
    {
        switch(Audio_state)
        {
            case as_AudioOff:
                *penSigSta = HI_UNF_SIG_NO_SIGNAL;
                break;
            case as_AudioOn:
                *penSigSta = HI_UNF_SIG_SUPPORT;
                break;
            case as_WaitReqAudio:
            case as_ReqAudio:
            case as_WaitForAudioPllLock:
            case as_AudioReady:
                *penSigSta = HI_UNF_SIG_UNSTABLE;
                break;
            default:
                *penSigSta = HI_UNF_SIG_NOT_SUPPORT;
                break;   
        }
    }

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
    hdmi_audio_type *pstAudioCtx;
    
    HDMIRX_CHECK_NULL_PTR(pstAudioInfo);
    
    if(HDMIRX_AUDIO_Getstatus() != as_AudioOn)
    {
        HI_INFO_HDMIRX("\nNo signal or un-support!\n");
        return HI_FAILURE;
    }
    
    
    pstAudioCtx = HDMIRX_AUDIO_GetInfo();
    //---------------------------channel number----------------------------------------------------
    pstAudioInfo->enChannel = HI_UNF_I2S_CHNUM_2;
    if(pstAudioCtx->bHbrMode == HI_TRUE)
    {
        pstAudioInfo->enChannel = HI_UNF_I2S_CHNUM_8;
    }
    else 
    {
        if(pstAudioCtx->blayout1 == HI_FALSE)
        {
            pstAudioInfo->enChannel = HI_UNF_I2S_CHNUM_2;

        }
        else 
        {
            pstAudioInfo->enChannel = HI_UNF_I2S_CHNUM_8;
        }
    }
    //-------------------------bit width-----------------------------------------------------------
    pstAudioInfo->enBitDepth = HI_UNF_I2S_BIT_DEPTH_16;
    //-------------------------format-----------------------------------------------------------
    pstAudioInfo->enHdmiAudioDataFormat = HI_UNF_AI_HDMI_FORMAT_LPCM;
    if(pstAudioCtx->bHbrMode == HI_TRUE)
    {
        pstAudioInfo->enHdmiAudioDataFormat = HI_UNF_AI_HDMI_FORMAT_HBR;
    }
    else 
    {
        if(pstAudioCtx->bEnc == HI_FALSE)
        {
            pstAudioInfo->enHdmiAudioDataFormat = HI_UNF_AI_HDMI_FORMAT_LPCM;
        }
        else
        {
            pstAudioInfo->enHdmiAudioDataFormat = HI_UNF_AI_HDMI_FORMAT_LBR;
        }
    }
    //-------------------------sample rate---------------------------------------------------------
    switch (pstAudioCtx->u32MeasuredFs)
    {
        case AUDIO_CHST4_FS_44:
            pstAudioInfo->enSampleRate = HI_UNF_SAMPLE_RATE_44K;
            break;
        case AUDIO_CHST4_FS_48:
            pstAudioInfo->enSampleRate = HI_UNF_SAMPLE_RATE_48K;
            break;
        case AUDIO_CHST4_FS_32:
            pstAudioInfo->enSampleRate = HI_UNF_SAMPLE_RATE_32K;
            break;
        case AUDIO_CHST4_FS_22:
            pstAudioInfo->enSampleRate = HI_UNF_SAMPLE_RATE_22K;
            break;
        case AUDIO_CHST4_FS_24:
            pstAudioInfo->enSampleRate = HI_UNF_SAMPLE_RATE_24K;
            break;
        case AUDIO_CHST4_FS_88:
            pstAudioInfo->enSampleRate = HI_UNF_SAMPLE_RATE_88K;
            break;
        case AUDIO_CHST4_FS_96:
            pstAudioInfo->enSampleRate = HI_UNF_SAMPLE_RATE_96K;
            break;
        case AUDIO_CHST4_FS_176:
            pstAudioInfo->enSampleRate = HI_UNF_SAMPLE_RATE_176K;
            break;          
        case AUDIO_CHST4_FS_192:
            pstAudioInfo->enSampleRate = HI_UNF_SAMPLE_RATE_192K;
            break;              
        default:
            pstAudioInfo->enSampleRate = HI_UNF_SAMPLE_RATE_UNKNOWN;
            break;          
    }
    
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

    *pbHdcp = HDMIRX_HAL_GetHdcpDone();
    
    return HI_SUCCESS;
}




HI_S32 HDMIRX_DRV_CTRL_LoadHdcp(HI_UNF_HDMIRX_HDCP_S *pstHdcpKey)
{
    HI_S32 s32Ret;
    CIPHER_EXPORT_FUNC_S *pstCipherFunc = HI_NULL;
    HI_DRV_CIPHER_FLASH_ENCRYPT_HDCPKEY_S stFlashHdcpkey;
    
    HDMIRX_CHECK_NULL_PTR(pstHdcpKey);
    s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_CIPHER, (HI_VOID**)&pstCipherFunc);
    if(s32Ret == HI_FAILURE)
    {
        return HI_FAILURE;
    }
    HDMIRX_CHECK_NULL_PTR(pstCipherFunc);
    //HDMIRX_INPUT_SetDdcEn(HDMIRX_INPUT_DDC_HDCP, HI_UNF_HDMIRX_PORT_ALL, HI_FALSE);
    memset(&stFlashHdcpkey, 0x00, sizeof(HI_DRV_CIPHER_FLASH_ENCRYPT_HDCPKEY_S));
    memcpy(stFlashHdcpkey.u8Key, pstHdcpKey->au32Hdcp, 332);
    stFlashHdcpkey.enHDCPKeyType = HI_DRV_HDCPKEY_RX0;
    stFlashHdcpkey.enHDCPVersion = HI_DRV_HDCP_VERIOSN_1x;
    stFlashHdcpkey.u32KeyLen = 332;

    s32Ret = pstCipherFunc->pfnCipherLoadHdcpKey(&stFlashHdcpkey);
    if(s32Ret == HI_FAILURE)
    {
        return HI_FAILURE;
    }
    HDMIRX_HAL_LoadHdcpKey(HI_FALSE);
    udelay(20);
    HDMIRX_HAL_LoadHdcpKey(HI_TRUE);
    msleep(40);
#if 0 /*--NO MODIFY : COMMENT BY CODINGPARTNER--*/
    
    //HDMIRX_HAL_HdcpCrcCheck(0);
   // HDMIRX_INPUT_SetDdcEn(HDMIRX_INPUT_DDC_EDID, HI_UNF_HDMIRX_PORT_ALL, HI_TRUE);
    HDMIRX_INPUT_SetDdcEn(HDMIRX_INPUT_DDC_EDID, HI_UNF_HDMIRX_PORT0, HI_TRUE);

   // HDMIRX_INPUT_SetDdcEn(HDMIRX_INPUT_DDC_HDCP, HI_UNF_HDMIRX_PORT_ALL, HI_TRUE);
    HDMIRX_INPUT_SetDdcEn(HDMIRX_INPUT_DDC_HDCP, HI_UNF_HDMIRX_PORT0, HI_TRUE);


    #if !SUPPORT_PWR5V_DET
    msleep(40);
    //HDMIRX_INPUT_SetHpdLv(HI_UNF_HDMIRX_PORT_ALL, HI_TRUE);
    HDMIRX_INPUT_SetHpdLv(HI_UNF_HDMIRX_PORT0, HI_TRUE);
    #endif
#endif /*--NO MODIFY : COMMENT BY CODINGPARTNER--*/

    HDMI_Connect();

    return HI_SUCCESS;
}





