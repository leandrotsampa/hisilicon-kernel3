//******************************************************************************
//  Copyright (C), 2007-2014, Hisilicon Technologies Co., Ltd.
//
//******************************************************************************
// File name     : drv_hdmirx_isr.c
// Version       : 1.0
// Author        : t00202585
// Created       : 2011-06-04
// Last Modified : 
// Description   :  The C union definition file for the module tvd
// Function List : 
// History       : 
// 1 Date        : 2014-06-14
// Author        : l00214567
// Modification  : Create file
//******************************************************************************
#include <linux/kernel.h>       /* HDMIRX_DEBUG */
#include <asm/io.h>             /* ioremap_nocache */
//#include <linux/sched.h>
//#include <linux/delay.h>
#include <linux/string.h>

//#include "hi_tvd.h"
#include "hi_type.h"
//#include "command.h"
//#include "int.h"
#include "drv_hdmirx_isr_internal.h"

/***********************************************************************************************************/

static HI_U32 InterruptMask[INTR_BUTT] =
{
	intr_auth_start | 0,  // INTR1
	
	intr_hdmi_mode | 0,  // INTR2

	//RX_M__INTR3__NEW_CP_PACKET | // for Deep Color (called on every packet, not on the packet change)
	intr_cp_set_mute | INTR3_SERVING_PACKETS_MASK |	0,  // INTR3

	intr_HDCP_packet_err | 0,  // INTR4

    #if SUPPORT_AAC
	intr_audio_muted |
	#endif
    reg_vres_chg | reg_hres_chg | intr_aud_sample_f | 0,  // INTR5

	intr_dc_packet_err | intr_new_acp | intr_dsd_on | 0, // INTR6
	
	0,  // INTR7
	
	0,  // INTR8
	
	intr_ckdt | intr_scdt | 0,   // INTR2_AON

    intr_unplug | 0, // INTR6_AON


    0, // INTR8_AON
	
};


/****************************************************************************************
    basic function of ISR
*****************************************************************************************/


static void HDMI_ISR_DisableVResChangeExceptionsOnOff(HI_BOOL bOnOff)
{
	
    HDMI_HAL_RegWriteFldAlign(RX_AEC_EN3, BIT_V_RES_CHANGED, !bOnOff);
	HDMI_HAL_RegWriteFldAlign(RX_AEC_EN2, BIT_H_RES_CHANGED, bOnOff);
}

static void HDMI_ISR_VResChgIntOnOff(HI_BOOL bOnOff)
{
	//HI_U32 mask5 = hdmi_ctx.strRxInt.aShadowIntMask[4];
	if(bOnOff)
	{
		hdmi_ctx.strRxInt.au32ShadowIntMask[4] |= reg_vres_chg;
        // clear V Resolution Change interrupt flag
		// as it could be set previously during 3D video processing
        HDMI_HAL_RegWrite(RX_INTR5, reg_vres_chg);
	}
	else
	{
		hdmi_ctx.strRxInt.au32ShadowIntMask[4] &= ~reg_vres_chg;
	}
	HDMI_HAL_RegWrite(RX_INTR5_MASK, hdmi_ctx.strRxInt.au32ShadowIntMask[4]);

}

static void HDMI_ISR_HdcpFailureChkWithVsyncOnOff(HI_BOOL bOnOff)
{
	if(bOnOff)
	{
        #if 0
		HDMI_INFO_AvMuteRequest(HI_TRUE, RX_OUT_AV_MUTE_M__RX_HDCP_ERROR);
        #endif

		hdmi_ctx.strRxInt.u32HdcpFailCnt= 1;
		hdmi_ctx.strRxInt.bCheckHdcpOnVsync = HI_TRUE; // don't clear HDCP Failure Int if this bit is set
		hdmi_ctx.strRxInt.au32ShadowIntMask[INTR2] |= intr_Vsync;
		hdmi_ctx.strRxInt.au32ShadowIntMask[INTR2] |= video_clock_change;
		hdmi_ctx.strRxInt.au32ShadowIntMask[INTR4] &= ~intr_HDCP_packet_err;
	}
	else
	{
		hdmi_ctx.strRxInt.u32HdcpFailCnt = 0;
        #if 0
		if(hdmi_ctx.strRxInt.bCheckHdcpOnVsync)
		{
			HDMI_INFO_AvMuteRequest(HI_FALSE, RX_OUT_AV_MUTE_M__RX_HDCP_ERROR);
		}
        #endif
		hdmi_ctx.strRxInt.bCheckHdcpOnVsync = HI_FALSE;
		hdmi_ctx.strRxInt.au32ShadowIntMask[INTR2] &= ~intr_Vsync;
		hdmi_ctx.strRxInt.au32ShadowIntMask[INTR4] |= intr_HDCP_packet_err;
	}
	HDMI_HAL_RegWrite(RX_INTR2_MASK, hdmi_ctx.strRxInt.au32ShadowIntMask[INTR2]);
	HDMI_HAL_RegWrite(RX_INTR4_MASK, hdmi_ctx.strRxInt.au32ShadowIntMask[INTR4]);

	// Clear BCH counter.
	// The counter accomulates BCH errors and  if it is not cleared it can cause an HDCP failure interrupt
	// Capture and clear BCH T4 errors.
	HDMI_HAL_RegWrite(RX_ECC_CTRL, reg_capture_cnt);

}

HI_BOOL HDMI_ISR_IsInterrupt(void)
{
    if (HDMI_HAL_RegReadFldAlign(RX_INTR_STATE, reg_intr)) {
        
        return HI_TRUE;
    }
    else {
        return HI_FALSE;
    }
}

static void HDMI_ISR_HdcpErrHandler(HI_BOOL bVsyncMode)
{

	if(bVsyncMode)
	{
		if(0 == (HDMI_HAL_RegRead(RX_HDCP_ERR)+ (HDMI_HAL_RegRead(RX_HDCP_ERR2) << 8)))
		{
			// Recovered- return to normal checking mode
			HDMI_ISR_HdcpFailureChkWithVsyncOnOff(HI_FALSE);
		}
		else
		{
			// Another failure
			hdmi_ctx.strRxInt.u32HdcpFailCnt++;
			if(HDCP_FAIL_THRESHOLD_1ST == hdmi_ctx.strRxInt.u32HdcpFailCnt)
			{
				// Reset Ri to notify an upstream device about the failure.
				// In most cases Ri is already mismatched if we see BCH errors,
				// but there is one rare case when the reseting can help.
				// It is when Ri and Ri' are matched all the time but Ri and Ri'
				// switching happens not synchronously causing a snow
				// screen flashing every 2 seconds. It may happen with
				// some old incomplaint sources or sinks (especially DVI).
				HDMI_HAL_RegWriteFldAlign(RX_HDCP_DEBUG, stop_en, HI_TRUE);
				// 080409 SiiRegWrite(RX_A__HDCP_DEBUG, 0);

				// Clear BCH counter.
				// The counter accumulates BCH errors and
				// if it is not cleared it can cause an HDCP failure interrupt.
				// Capture and clear BCH T4 errors.
				HDMI_HAL_RegWriteFldAlign(RX_ECC_CTRL, reg_capture_cnt, HI_TRUE);


				// repeat HPD cycle if HDCP is not recovered
				// in some time
				hdmi_ctx.strRxInt.u32HdcpFailCnt = HDCP_FAIL_THRESHOLD_1ST - HDCP_FAIL_THRESHOLD_CONTINUED;
			}
		}
	}
	else
	{
		HDMI_ISR_HdcpFailureChkWithVsyncOnOff(HI_TRUE);	
	}
}


void HDMI_ISR_HdcpIntOnOff(HI_BOOL bOnOff)
{
	if(bOnOff)
	{
		hdmi_ctx.strRxInt.au32ShadowIntMask[INTR1] |= (intr_auth_start | intr_auth_done);

		HDMI_HAL_RegSetBits(RX_INTR1, intr_auth_start | intr_auth_done, HI_TRUE); // interrupt reset
	}
	else
	{
		hdmi_ctx.strRxInt.au32ShadowIntMask[INTR1] &= ~intr_auth_start;
		hdmi_ctx.strRxInt.au32ShadowIntMask[INTR1] |= intr_auth_done;
	}
	HDMI_HAL_RegWrite(RX_INTR1_MASK, hdmi_ctx.strRxInt.au32ShadowIntMask[INTR1]); // set mask

	if(!bOnOff) // just in case: reset interrupt if they were set
	{
		HDMI_HAL_RegSetBits(RX_INTR1, intr_auth_start | intr_auth_done, HI_TRUE);
	}
}

void HDMI_ISR_NoAviIntOnOff(HI_BOOL bOnOff)
{
    HI_U32 mask4 = hdmi_ctx.strRxInt.au32ShadowIntMask[INTR4];
	if(bOnOff)
	{
		HDMI_HAL_RegWriteFldAlign(RX_INTR4, intr_no_avi, HI_TRUE); // clear No AVI interrupt if it was raised
		hdmi_ctx.strRxInt.au32ShadowIntMask[INTR4] |= intr_no_avi;
	}
	else
	{
		hdmi_ctx.strRxInt.au32ShadowIntMask[INTR4] &= ~intr_no_avi;
	}
	if (mask4 != hdmi_ctx.strRxInt.au32ShadowIntMask[INTR4]) {
		HDMI_HAL_RegWrite(RX_INTR4_MASK, hdmi_ctx.strRxInt.au32ShadowIntMask[INTR4]);
	}

	// If NO AVI interrupt is ON, look for NEW AVI only.
	// If NO AVI interrupt is OFF, look for ANY AVI.
	HDMI_HAL_RegWriteFldAlign(RX_INT_IF_CTRL, reg_new_avi_only, !bOnOff);
}

#if SUPPORT_AAC
void HDMI_ISR_AacDoneIntOnOff(HI_BOOL bOnOff)
{

	HI_U32 u32Mask5 = hdmi_ctx.strRxInt.au32ShadowIntMask[INTR5];
	if(bOnOff)
		hdmi_ctx.strRxInt.au32ShadowIntMask[INTR5] |= intr_audio_muted;
	else
		hdmi_ctx.strRxInt.au32ShadowIntMask[INTR5] &= ~intr_audio_muted;
	if (u32Mask5 != hdmi_ctx.strRxInt.au32ShadowIntMask[INTR5]) {
		HDMI_HAL_RegWrite(RX_INTR5_MASK, hdmi_ctx.strRxInt.au32ShadowIntMask[INTR5]);
	}
}
#endif
#if 0
void HDMI_ISR_GetIntStatus(HI_U32 *pDst)
{
    pDst[INTR2_AON] = HDMI_HAL_RegRead(RX_INTR2_AON);
    pDst[INTR6_AON] = HDMI_HAL_RegRead(RX_INTR6_AON);
    pDst[INTR8_AON] = HDMI_HAL_RegRead(RX_INTR8_AON);
    HDMI_HAL_RegReadBlock(RX_INTR1, pDst, 8);
}
#endif


void HDMI_ISR_ClearScdtInt(void)
{
    HDMI_HAL_RegWriteFldAlign(RX_INTR2_AON, intr_scdt, HI_TRUE);
    
    HDMI_HAL_RegSetBits(RX_INTR5, reg_vres_chg|reg_hres_chg, HI_TRUE);
}

void HDMI_ISR_AcpIntOnOff(HI_BOOL bOnOff)
{
	//HI_U32   mask6 = hdmi_ctx.strRxInt.aShadowIntMask[5];
	if(bOnOff)
		hdmi_ctx.strRxInt.au32ShadowIntMask[INTR6] |= intr_new_acp;
	else
		hdmi_ctx.strRxInt.au32ShadowIntMask[INTR6] &= ~intr_new_acp;
	
		HDMI_HAL_RegWrite(RX_INTR6_MASK, hdmi_ctx.strRxInt.au32ShadowIntMask[INTR6]);
}

void HDMI_ISR_ReceiveAudioInfoFrameOnEveryPacketOnOff(HI_BOOL bOnOff)
{
    HDMI_HAL_RegWriteFldAlign(RX_INT_IF_CTRL, reg_new_aud_only,(HI_U32)bOnOff);
    //HDMI_HAL_RegWrite(RX_INTR3, intr_new_aud);
    HDMI_HAL_RegWriteFldAlign(RX_INTR3, intr_new_aud, HI_TRUE);
}


void HDMI_ISR_DisVResChangeEventsOnOff(HI_BOOL bOnOff)
{
	// V Resolution Change interrupts cannot be used in 3D.
	HDMI_ISR_VResChgIntOnOff(!bOnOff);

	// Audio exception on V Resolution Change cannot be used in 3D.
	HDMI_ISR_DisableVResChangeExceptionsOnOff(bOnOff);
}

void HDMI_ISR_CpInterruptOnOff(HI_BOOL bOnOff)
{

	HI_U32 mask3 = hdmi_ctx.strRxInt.au32ShadowIntMask[INTR3];
	if (bOnOff) {
		hdmi_ctx.strRxInt.au32ShadowIntMask[INTR3] |= intr_cp_set_mute;
	}
	else {
		hdmi_ctx.strRxInt.au32ShadowIntMask[INTR3] &= ~intr_cp_set_mute;
	}
	if (mask3 != hdmi_ctx.strRxInt.au32ShadowIntMask[INTR3]) {
		HDMI_HAL_RegWrite(RX_INTR3_MASK, hdmi_ctx.strRxInt.au32ShadowIntMask[INTR3]); 
	}
}


/* 
------------------------------------------------------------------------------
    Function:    HDMI_ISR_Initial
    Description: to reset all isr struct and turn on int
    Parameters:  none
    Returns:     none
    NOTE: 1. reset all the isr struct member to zero.
          2. initial int mask.
          3. receive all packets.
-----------------------------------------------------------------------------
*/
void HDMI_ISR_Initial(void)
{
    hdmi_ctx.strRxInt.bCheckHdcpOnVsync = HI_FALSE;
    hdmi_ctx.strRxInt.u32HdcpFailCnt = 0;

	memcpy(hdmi_ctx.strRxInt.au32ShadowIntMask, InterruptMask, sizeof(hdmi_ctx.strRxInt.au32ShadowIntMask));
    hdmi_ctx.strRxInt.au32ShadowIntMask[INTR2] |= video_clock_change;

    HDMI_HAL_RegWrite(RX_INTR2_MASK, hdmi_ctx.strRxInt.au32ShadowIntMask[INTR2]);
    //HDMI_HAL_RegWriteFldAlign(RX_INTR2_MASK, video_clock_change, HI_TRUE);
   
	HDMI_HAL_RegWriteBlock(RX_INTR1_MASK, hdmi_ctx.strRxInt.au32ShadowIntMask,8);
    //HDMI_HAL_RegWrite(RX_INTR2_MASK_AON, hdmi_ctx.strRxInt.au32ShadowIntMask[INTR2_AON]);
    	HDMI_HAL_RegWrite(RX_INTR8_MASK_AON, hdmi_ctx.strRxInt.au32ShadowIntMask[INTR8_AON]);
    
	// receive every packets (this register will be changed later under some conditions)
    HDMI_HAL_RegWrite(RX_INT_IF_CTRL, reg_new_acp_only|reg_new_mpeg_only|reg_new_spd_only|reg_new_avi_only|reg_new_aud_only);
    HDMI_HAL_RegWrite(IF_CTRL2, reg_gcp_clr_en);

    HDMI_HAL_RegWriteFldAlign(RX_INTR7_MASK_AON, cec_interrupt, HI_TRUE);
    hdmi_ctx.strRxInt.u32ResChgChkTimer = 0;
}

void HDMI_ISR_Handler(HI_U32  *interrupts)
{
 //   HI_U32      interrupts[INTR_BUTT];
    HI_BOOL     bNoAvi;
    HI_U32      i;
    
    switch(hdmi_ctx.u32HdmiState)
    {
	    case HDMI_STATE_SYNC_SEARCH:
	    case HDMI_STATE_SYNC_STABLE:
	    case HDMI_STATE_FORMAT_DETECTED:
	    case HDMI_STATE_NOT_SUPPORTED:
	    case HDMI_STATE_VIDEO_ON:
            //HDMIRX_DEBUG("HDMI_ISR_Handler \n");
            HDMI_ISR_IsInterrupt();
            if (interrupts[INTR2] & video_clock_change)//	 ///*libo@201404*/	(HDMI_ISR_IsInterrupt()) 
                {
                // get interrupt requests
#if 0 /*--NO MODIFY : COMMENT BY CODINGPARTNER--*/
                HDMI_HAL_RegReadBlock(RX_INTR1, interrupts, 8);
                interrupts[INTR2_AON] = HDMI_HAL_RegRead(RX_INTR2_AON);
                //HDMIRX_DEBUG("INT2_AON is %x \n",interrupts[INT2_AON]);
                interrupts[INTR6_AON] = HDMI_HAL_RegRead(RX_INTR6_AON);
                interrupts[INTR8_AON] = HDMI_HAL_RegRead(RX_INTR8_AON);
#endif /*--NO MODIFY : COMMENT BY CODINGPARTNER--*/
                //HDMIRX_DEBUG("................. INT5 = 0x%x \n", interrupts[INTR5]);
                // do not touch interrupts which are masked out
                i = 0;
                do {
                    #if 0
                   if(i == INTR5) {
                         HDMIRX_DEBUG("................. INT5_2 = 0x%x \n", interrupts[i]);
                         HDMIRX_DEBUG("................. INT5_MASK = 0x%x \n", hdmi_ctx.strRxInt.au32ShadowIntMask[i]);
                   }
                   #endif
                   interrupts[i] &= hdmi_ctx.strRxInt.au32ShadowIntMask[i];
                   
                   //HDMIRX_DEBUG("--INT[%d]:0x%x\n", i, interrupts[i]);      /*libo@201312*/ 
                   i++;
                }while(i < INTR_BUTT);
                
#if 0 /*--NO MODIFY : COMMENT BY CODINGPARTNER--*/
                // clear interrupt requests
                HDMI_HAL_RegWriteBlock(RX_INTR1, interrupts, 8);
                HDMI_HAL_RegWrite(RX_INTR2_AON, interrupts[INTR2_AON]);
                HDMI_HAL_RegWrite(RX_INTR6_AON, interrupts[INTR6_AON]);
                
#endif /*--NO MODIFY : COMMENT BY CODINGPARTNER--*/
                #if SUPPORT_AAC && SUPPORT_AUDIO
                if(interrupts[INTR5] & intr_audio_muted) {
                    HDMI_AUD_AacDone();
                    //HDMIRX_DEBUG("HDMI_AUD_AacDone \n");
                }
                #endif
                if (interrupts[INTR5] & (reg_vres_chg | reg_hres_chg)) {
                    // video resolution has changed
                    #if 1
                 	// do not spend time on resolution check if sync detect has disapeared
                    if ((interrupts[INTR2_AON] & intr_scdt) == 0) {
                        switch(hdmi_ctx.u32HdmiState) {
                            case HDMI_STATE_VIDEO_ON:
                            case HDMI_STATE_FORMAT_DETECTED:
                            //case HDMI_STATE_SYNC_STABLE:
                                // There could be a false Resolution Change interrupt on pixel replication change,
							    // on Deep Color change or DVI->HDMI change.
							    // To avoid extra RX restart, check that condition after a short period of time.
                                hdmi_ctx.strRxInt.u32ResChgChkTimer = 20;
                                HDMI_VDO_SetDcMode();
                                break;
                            default:
                                #if SUPPORT_AUDIO
                                HDMI_AUD_AssertOff();
                                #endif
                                //HDMI_VDO_ChangeState(HDMI_STATE_SYNC_SEARCH);
                                //HDMIRX_DEBUG("HDMI_STATE_SYNC_SEARCH-- scdt on to off \n");
                                //HDMIRX_DEBUG("DDC OFF 1 \n");
                                //HDMI_SYS_DdcOnOff(HI_FALSE);
                                break;
                        }
                    }
                    #endif
                }
                #if SUPPORT_AUDIO
                if (interrupts[INTR6] & (intr_dsd_on | intr_hbra_on)) {
                    //HDMIRX_DEBUG("INTR6 on \n");
                    HDMI_AUD_StreamTypeChanged();
                }
                #endif
                // Check plug out interrupt
				if (interrupts[INTR6_AON] & intr_unplug )
				{
				    if ( !HDMI_HAL_RegReadFldAlign(RX_STATE_AON, hdmi_tx_connected)) {
				    	
						// The cable in interrupt will get set when pwr5v will became 1.
						// It will continue to be set as long as pwr5v is 1, so mask it out after we get it
						// and unmask it only after get plug out interrupt
						HDMI_HAL_RegWriteFldAlign(RX_INTR8_MASK_AON, intr_cable_in, HI_TRUE);
                        HDMI_HAL_RegWriteFldAlign(RX_INTR6_MASK_AON, intr_unplug, HI_FALSE);

				    }
				}

                // Check plug in interrupt
                if (interrupts[INTR8_AON] & intr_cable_in ) {
                     if (HDMI_HAL_RegReadFldAlign(RX_STATE_AON, hdmi_tx_connected) == HI_TRUE) {
                    	 HDMI_HAL_RegWriteFldAlign(RX_INTR8_MASK_AON, intr_cable_in, HI_FALSE);
                        HDMI_HAL_RegWriteFldAlign(RX_INTR6_MASK_AON, intr_unplug, HI_TRUE);
                     }
                }
                #if SUPPORT_AUDIO
                if((interrupts[INTR5] & intr_aud_sample_f) || (interrupts[INTR6] & intr_chst_ready))
				{
					// Note: RX_M__INTR6__CHST_READY interrupt may be disabled
                    HDMIRX_DEBUG("audio sample rate change!! \n");
					HDMI_AUD_OnChannelStatusChg();
				}
                #endif
                if (interrupts[INTR2_AON] & intr_scdt) {
                    HDMI_SYS_DcFifoReset();
                    HDMI_ISR_HdcpFailureChkWithVsyncOnOff(HI_FALSE);
                    //HDMIRX_DEBUG("DDC OFF 2 \n");
                    //HDMI_SYS_DdcOnOff(HI_FALSE);
                    HDMI_VDO_MuteOnOff(HI_TRUE);
                    //HDMIRX_DEBUG("......2....hdmi isr state is HDMI_STATE_SYNC_SEARCH \n");
                    HDMI_VDO_ChangeState(HDMI_STATE_SYNC_SEARCH);
                    HDMIRX_DEBUG("HDMI_STATE_SYNC_SEARCH--scdt off to on \n");
                    hdmi_ctx.bKsvValid = HI_FALSE;
                    // 081116
					// Following line is a remedy for incomplaint sources
					// which do not keep the minimum 100ms off time
					// and start transmitting encrypted data before authentication.
					// Since the deep color packets are encrypted,
					// RX chip is not able receiving even H/V syncs
					// and detect resolution if it is set for wrong deep color mode.
					HDMI_VDO_SetDcMode();
                    HDMI_VDO_HdmiDviTrans();
                    #if SUPPORT_AUDIO
                    HDMI_AUD_Stop(HI_FALSE);
                    #endif
                    //HDMIRX_DEBUG("HDMI_AUD_Stop ... xxx \n");
                }
                
                if (interrupts[INTR2] & intr_hdmi_mode) {
                    HDMI_VDO_HdmiDviTrans();
                }
                
                if (hdmi_ctx.bHdmiMode) {
                    if (interrupts[INTR1] & intr_auth_done) {
						HDMI_ISR_HdcpFailureChkWithVsyncOnOff(HI_FALSE);
                    }
                    if (hdmi_ctx.strRxInt.bCheckHdcpOnVsync == HI_TRUE) {
                        if (interrupts[INTR2] & intr_Vsync) {
                            HDMI_ISR_HdcpErrHandler(HI_TRUE);
                        }                  
                    }
                    else {
                        if (interrupts[INTR4] & intr_HDCP_packet_err) {
                             HDMI_ISR_HdcpErrHandler(HI_FALSE);
                        }
                    }
                    bNoAvi = (interrupts[INTR4] & intr_no_avi) ? HI_TRUE : HI_FALSE;
                    if (bNoAvi) {
                        if (interrupts[INTR3] & intr_new_avi) {
                            // controversial info: both AVI and NO AVI bits are set,
								// try to resolve the conflict
								if(0 != HDMI_HAL_RegRead(AVIRX_TYPE)) // check if AVI header is valid
									// decision: AVI bit is correct
									bNoAvi = HI_FALSE;
								else
									// decision: NO AVI bit is correct
									interrupts[INTR3] &= ~intr_new_avi;
                        }
                    }
                    if (bNoAvi) {
                        HDMI_ISR_NoAviIntOnOff(HI_FALSE);
						HDMI_AVI_NoAviHandler();
                    }
                    else {
                        if (interrupts[INTR3] & intr_new_avi) {
                            HDMI_ISR_NoAviIntOnOff(HI_TRUE);
                        }
                    }
                    //HDMIRX_DEBUG("interrupts[INTR3] = %x \n", interrupts[INTR3]);
                    if (interrupts[INTR3] & INTR3_SERVING_PACKETS_MASK) {
                        HDMI_INFO_IntHandler(interrupts[INTR3]);
                    }
                    #if SUPPORT_AUDIO
                    if (interrupts[INTR6] & intr_new_acp) {
                        HDMI_ACP_IntHandler();
                    }
                    #endif
                    if (interrupts[INTR3] & intr_cp_set_mute) {
                        HDMI_INFO_CpHandler();
                        // Clear the interrupt request if it was set since the beginning of this function.
					    // It reduces CPU load by excluding excessive interrupting.
                        HDMI_HAL_RegWriteFldAlign(RX_INTR3, intr_cp_set_mute, 1);
                    }
                }
            }
            break;
        default:
            break;
   }
}

void HDMI_ISR_TimerHandler(void)
{
    HDMI_VDO_SetDcMode();
    switch(hdmi_ctx.u32HdmiState) {
        case HDMI_STATE_VIDEO_ON:
        case HDMI_STATE_FORMAT_DETECTED:
            if (hdmi_ctx.strRxInt.u32ResChgChkTimer > 0) {
                hdmi_ctx.strRxInt.u32ResChgChkTimer--;
                if(hdmi_ctx.strRxInt.u32ResChgChkTimer == 0) {
                    if (HDMI_VDO_IsTimingChg()) {
                        #if SUPPORT_AUDIO
                        HDMI_AUD_Stop(HI_TRUE);
                        #endif
                        //HDMIRX_DEBUG("HDMI_AUD_Stop-- %s \n", __FUNCTION__);
                        HDMI_VDO_ChangeState(HDMI_STATE_SYNC_SEARCH);
                        //HDMIRX_DEBUG("DDC OFF 3 \n");
                        //HDMI_SYS_DdcOnOff(HI_FALSE);
                    }
                }
            }
            break;
         default:
            hdmi_ctx.strRxInt.u32ResChgChkTimer = 0;
            break;
    }
    HDMI_SYS_ServeRt();
    //HDMI_VSIF_Mloop();
}

// just enable the unplug int.
void HDMI_ISR_PowerOnRegInit(void)
{
    HDMI_HAL_RegWriteFldAlign(RX_INTR6_MASK_AON, intr_unplug, HI_TRUE);
}

void HDMI_ISR_SpdIntOnOff(HI_BOOL bOnOff)
{
	HI_U32 mask3 = hdmi_ctx.strRxInt.au32ShadowIntMask[INTR3];
    
	if(bOnOff)
		hdmi_ctx.strRxInt.au32ShadowIntMask[INTR3] |= intr_new_spd;
	else
		hdmi_ctx.strRxInt.au32ShadowIntMask[INTR3] &= ~intr_new_spd;

	if(mask3 != hdmi_ctx.strRxInt.au32ShadowIntMask[INTR3])
		HDMI_HAL_RegWrite(RX_INTR3_MASK, hdmi_ctx.strRxInt.au32ShadowIntMask[INTR3]);
}

HI_BOOL HDMI_ISR_IsCecInt(void)
{
#if 0 /*--NO MODIFY : COMMENT BY CODINGPARTNER--*/
   if (HDMI_HAL_RegReadFldAlign(RX_INTR7_AON, cec_interrupt)) 
#endif /*--NO MODIFY : COMMENT BY CODINGPARTNER--*/
    if (hdmi_ctx.strRxInt.u32Int[INTR7] & cec_interrupt) 
    {
        HDMI_HAL_RegWriteFldAlign(RX_INTR7_AON, cec_interrupt, HI_TRUE);
        return HI_TRUE;
    }
    else 
    {
        return HI_FALSE;
    }
}

