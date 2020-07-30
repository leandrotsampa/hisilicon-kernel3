/******************************************************************************

  Copyright (C), 2012-2050, Hisilicon Tech. Co., Ltd.

 ******************************************************************************
  File Name     : drv_hdmirx_audio.c
  Version       : Initial Draft
  Author        : Hisilicon multimedia software group
  Created       : 2014/01/16
  Description   : 
  History       :
  1.Date        : 2014/01/16
    Author      :  t00202585
    Modification: Created file
******************************************************************************/
#include <linux/delay.h>
#include <linux/sched.h> 

#include "hi_drv_proc.h"

#include "hal_hdmirx_reg.h"
//#include "drv_hdmirx.h"
#include "drv_hdmirx_common.h"
#include "drv_hdmirx_ctrl.h"
#include "drv_hdmirx_audio.h"
#include "drv_hdmirx_video.h"
#include "drv_hdmirx_packet.h"

#ifdef __cplusplus
 #if __cplusplus
        extern "C" {
 #endif
#endif /* __cplusplus */

static const HI_CHAR *s_apsHdmirxAudioStateString[] =
{
	"AUDIO_STATE_OFF",
	"AUDIO_STATE_REQ",
	"AUDIO_STATE_READY",
	"AUDIO_STATE_ON",
	"AUDIO_STATE_BUTT"
};

static HDMIRX_AUDIO_CONTEXT_S s_stHdmirxAudioCtx;


static const AUDIO_FS_SEARCH_S AudioFsList[AUDIO_FS_LIST_LENGTH+1] =
{
	{ AUDIO_CHST4_FS_22,		220,	200,	230  },
	{ AUDIO_CHST4_FS_24,		240,	230,	280  },
	{ AUDIO_CHST4_FS_32,		320,	280,	380  },
	{ AUDIO_CHST4_FS_44,		441,	380,	460  },
	{ AUDIO_CHST4_FS_48,		480,	460,	540  },
	{ AUDIO_CHST4_FS_88,		882,	820,	921  },
	{ AUDIO_CHST4_FS_96,		960,	921,	1100 },
	{ AUDIO_CHST4_FS_176,		1764,	1600,	1792 },
	{ AUDIO_CHST4_FS_192,		1920,	1792,	2500 },
	{ AUDIO_CHST4_FS_UNKNOWN,	0,    	0,		0 }

};


#if SUPPORT_AUDIO_INFOFRAME
static const HI_U32 AudioChannelMask[AUDIO_CHANNEL_MASK_TABLE_LENGTH] =
{
	0x10, 0x30, 0x30, 0x30, 0x70, 0x70, 0x70, 0x70,
	0x70, 0x70, 0x70, 0x70, 0xF0, 0xF0, 0xF0, 0xF0,
	0xF0, 0xF0, 0xF0, 0xF0, 0xB0, 0xB0, 0xB0, 0xB0,
	0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0,
};
#endif

#if SUPPORT_AEC
static HI_VOID HDMIRX_AUDIO_SetAacDoneIntEn(HI_UNF_HDMIRX_PORT_E enPort,HI_BOOL bEn)
{

	HI_U32 u32Mask5;
    
    u32Mask5 = HDMIRX_CTRL_GetShadowIntMask(HDMIRX_INTR5);
    HDMIRX_CTRL_SetShadowIntMask(HDMIRX_INTR5, intr_audio_muted, bEn);
	
	if (u32Mask5 != HDMIRX_CTRL_GetShadowIntMask(HDMIRX_INTR5)) 
    {
		//HDMIRX_HAL_SetAudioMuteIntEn(bEn);
        HDMIRX_HAL_SetInterruptEn(enPort,HDMIRX_INT_AUDIO_MUTE, bEn);
	}
}
#endif
static HI_VOID HDMIRX_AUDIO_Refresh(HI_UNF_HDMIRX_PORT_E enPort)
{
	HI_U32 u32Stat;
    HDMIRX_AUDIO_CONTEXT_S *pstAudioCtx;

    pstAudioCtx = HDMIRX_AUDIO_GET_CTX();
    u32Stat = HDMIRX_HAL_GetAudp(enPort);

	if((u32Stat & 0x90) || (0x60 == (u32Stat & 0x60)))
	{
		// It happens when a source sends encrypted data before authentication
		// (or forgets disabling HDCP encryption after a break in video clock).

		
		// No reason to continue- audio data is broken
	}
	else
	{
		// RX_A__AUDP_STAT looks correct
        #if SUPPORT_DSD
		if(u32Stat & hdmi_aud_dsd_on)
		{
			// DSD (One Bit) Audio
			pstAudioCtx->bDsdMode= HI_TRUE;
			#if SUPPORT_HBR
			pstAudioCtx->bHbrMode= HI_FALSE;
			#endif
		}
		else
		#endif
		#if SUPPORT_HBR
		if(u32Stat & hdmi_hbra_on)
		{
			// HBR Audio
			#if SUPPORT_DSD
			pstAudioCtx->bDsdMode = HI_FALSE;
			#endif
			pstAudioCtx->bHbrMode = HI_TRUE;
		}
		else
		#endif
		{
			#if SUPPORT_DSD
			pstAudioCtx->bDsdMode = HI_FALSE;
			#endif
			#if SUPPORT_HBR
			pstAudioCtx->bHbrMode = HI_FALSE;
			#endif
		}

	}
}




//------------------------------------------------------------------------------
// Function:    HDMIRX_AUDIO_GetTmdsClk_10k
// Description: get the TMDS clk in 10k unit. 
// Parameters:  None.
// Returns:     the TMDS clk.
//------------------------------------------------------------------------------
HI_U32 HDMIRX_AUDIO_GetTmdsClk_10k(HI_VOID)
{
    HI_U32 tmds_clk_10kHz;
    tmds_clk_10kHz = HDMIRX_VIDEO_GetPixelClk();
	// this is Pix Clock (not TMDS clock at that moment) in 100 Hz units

	// convert pixel clock into TMDS clock
	switch(HDMIRX_VIDEO_GetInputWidth())
	{
		case HDMIRX_INPUT_WIDTH_30: // DC 30 bit
			tmds_clk_10kHz = tmds_clk_10kHz * 5 / 4; // *1.25
		    break;
		case HDMIRX_INPUT_WIDTH_36: // DC 36 bit
			tmds_clk_10kHz = tmds_clk_10kHz * 3 / 2; // *1.5
		    break;
		case HDMIRX_INPUT_WIDTH_48: // DC 48 bit (reserved for the future)
			tmds_clk_10kHz *= 2; // *2
		    break;
        default:
            break;
	}
    
	return tmds_clk_10kHz;
}



static HI_BOOL HDMIRX_AUDIO_IsCtsInRange(HI_UNF_HDMIRX_PORT_E enPort)
{
    HI_U32 tmds_clk_100Hz = HDMIRX_AUDIO_GetTmdsClk_10k() * 100;
    HI_U32 cts = HDMIRX_HAL_GetCts(enPort);

    // HDMI spec.:
    // N shall be an integer number and shall meet the following restriction:
    // 128*fS / 1500Hz <= N <= 128*fS / 300Hz with a recommended optimal value of 128..fS / 1000Hz approximately equals N
    // HDMI spec.:
    // CTS shall be an integer number that satisfies the following:
    // (Average CTS value) = (fTMDS_clock * N ) / (128 * fS)


    // Ftmds/1500 <= CTS <= Ftmds/300
    // for simplicity and some headroom:
    // (Ftmds/100)/16 <= CTS <= (Ftmds/100)/2
    // which is
    // (Ftmds/100)>>4 <= CTS <= (Ftmds/100)>>1
    // or
    // ((Ftmds/100) <= CTS<<4) && (CTS<<1 <= (Ftmds/100))
    // or
    // (Ftmds_in100Hz <= CTS<<4) && (Ftmds_in100Hz >= CTS<<1)
    return (tmds_clk_100Hz <= (cts<<4)) && (tmds_clk_100Hz >= (cts<<1));
}



static HI_BOOL HDMIRX_AUDIO_IsCtsError(HI_UNF_HDMIRX_PORT_E enPort)
{
    HI_BOOL bErr = HI_FALSE;

    if (HDMIRX_HAL_IsAudioPacketGot(enPort) == HI_FALSE)
	{
        bErr = HI_TRUE;
    }
    else if(HDMIRX_HAL_IsCtsGot(enPort) == HI_FALSE)
	{
        bErr = HI_TRUE;
    }
    else if (HDMIRX_AUDIO_IsCtsInRange(enPort) == HI_FALSE)
	{
        bErr = HI_TRUE;
    }
    else if (HDMIRX_HAL_IsClockStable(enPort) == HI_FALSE)
	{
        bErr = HI_TRUE;
    }
	
    return bErr;
}

// wait until FIFO underrun and overrun are gone
static HI_BOOL HDMIRX_AUDIO_IsFifoStable(HI_UNF_HDMIRX_PORT_E enPort)
{
	HI_U32 timeout = 10;
	msleep(1);
	do
	{
		// reset audio FIFO
		HDMIRX_HAL_SetResetEn(enPort,HDMIRX_AUDIO_FIFO_RST, HI_TRUE);
		udelay(10);
		HDMIRX_HAL_SetResetEn(enPort,HDMIRX_AUDIO_FIFO_RST, HI_FALSE);
		// clear FIFO underrun and overrun interrupts

        HDMIRX_HAL_ClearInterrupt(enPort,HDMIRX_INT_FIFO_OF);
        HDMIRX_HAL_ClearInterrupt(enPort,HDMIRX_INT_FIFO_UF);
		msleep(1);
        
		// check whether the interrupt has raised
		if(HDMIRX_HAL_IsFifoStable(enPort) == HI_TRUE) 
		{
			break; // success
		}
	} while(--timeout);
    
	if(0 != timeout)
	{
		return HI_TRUE;
	}
	return HI_FALSE;
}

static HI_BOOL HDMIRX_AUDIO_IsStatusChanged(HI_UNF_HDMIRX_PORT_E enPort)
{

	HI_U32 d[5];
    HDMIRX_AUDIO_CONTEXT_S *pstAudioCtx;

    pstAudioCtx = HDMIRX_AUDIO_GET_CTX();
	HDMIRX_HAL_GetChannelSta(enPort,d);
	d[3] &= ~CHST4_SAMPLE_F;

	if(AUDIO_CHST4_FS_UNKNOWN != pstAudioCtx->u32MeasuredFs)
	{
		// replace with FW measured values
		d[3] |= pstAudioCtx->u32MeasuredFs;
	}
	else
	{
		// replace with HW measured values
		d[3] |= HDMIRX_HAL_GetHwSampleRate(enPort); // replace with HW measured values
	}
	if(memcmp(d, pstAudioCtx->au32ChannelSta, 20) == 0)
	{
		return HI_FALSE;
	}
	
	return HI_TRUE;

}

/*
------------------------------------------------------------------------------
 Function:    HDMIRX_AUDIO_Start
 Description: Start the audio. 
 Parameters:  None.
 Returns:     None.
------------------------------------------------------------------------------
*/
static HI_VOID HDMIRX_AUDIO_Start(HI_VOID)
{
    HDMIRX_AUDIO_CONTEXT_S *pstAudioCtx;

    pstAudioCtx = HDMIRX_AUDIO_GET_CTX();
    pstAudioCtx->bStartReq = HI_TRUE;
}

/*
------------------------------------------------------------------------------
 Function:    HDMIRX_AUDIO_ExceptionsOnOff
 Description: AEC on/off. 
 Parameters:  None.
 Returns:     None.
------------------------------------------------------------------------------
*/
#if SUPPORT_AEC
static HI_VOID HDMIRX_AUDIO_SetExceptionsEn(HI_UNF_HDMIRX_PORT_E enPort,HI_BOOL bEn)
{
    HDMIRX_AUDIO_CONTEXT_S *pstAudioCtx;

    pstAudioCtx = HDMIRX_AUDIO_GET_CTX();
    HDMIRX_HAL_SetExceptionEn(enPort,bEn);
	pstAudioCtx->bExceptionsEn = bEn;
}
#endif
static HI_VOID HDMIRX_AUDIO_OnOff(HI_UNF_HDMIRX_PORT_E enPort,HI_BOOL bOnOff)
{
    HDMIRX_AUDIO_CONTEXT_S *pstAudioCtx;

    pstAudioCtx = HDMIRX_AUDIO_GET_CTX();
    if(bOnOff)
	{
		if(HI_FALSE == pstAudioCtx->bAudioIsOn) // reduce extra log prints
		{
			pstAudioCtx->bAudioIsOn = HI_TRUE;
		}
        #if SUPPORT_AEC
		HDMIRX_AUDIO_SetExceptionsEn(enPort,HI_TRUE);
        #endif
		//HDMIRX_HAL_RegWriteFldAlign(RX_AUDP_MUTE, reg_audio_mute, HI_FALSE);
		HDMIRX_HAL_SetMuteEn(enPort,HDMIRX_MUTE_AUD, HI_FALSE);
	}
	else
	{
		if(pstAudioCtx->bAudioIsOn == HI_TRUE) // reduce extra log prints
		{
			pstAudioCtx->bAudioIsOn = HI_FALSE;
		}
		
		HDMIRX_HAL_SetMuteEn(enPort,HDMIRX_MUTE_AUD, HI_TRUE);

		// disable I2S output, but keep MCLKenable, SPDIF is on with flat output
		//HDMIRX_HAL_RegWrite(RX_AUDRX_CTRL, reg_pass_spdif_err | reg_i2s_mode); // maybe
	}
    #if SUPPORT_AEC
	HDMIRX_AUDIO_SetAacDoneIntEn(enPort,bOnOff);
    #endif
}
/*
------------------------------------------------------------------------------
Function:    	HDMIRX_AUDIO_ChangeState
Description: 	Change the audio fw state and set the timeout for this state. 
Parameters:  	enNewState: 	the new audio fw state.
                	Counter:    	the timeout for the new state in unit of 10ms.
 Returns:     	None
------------------------------------------------------------------------------
*/
static HI_VOID HDMIRX_AUDIO_ChangeState(HDMIX_AUDIO_STATE_E enNewState, 
HI_U32 u32Delay)
{
    HDMIRX_AUDIO_CONTEXT_S *pstAudioCtx;

    pstAudioCtx = HDMIRX_AUDIO_GET_CTX();
    pstAudioCtx->enAudioState = enNewState;
    pstAudioCtx->u32TimeOut = u32Delay;
}

//------------------------------------------------------------------------------
// Function:    HDMIRX_AUDIO_IsSpdifOutEnable
// Description: check the spdif is permitted to output or not. 
// Parameters:  None.
// Returns:     True:  spdif can output.
//              False: output is forbidden
//------------------------------------------------------------------------------
static HI_BOOL HDMIRX_AUDIO_IsSpdifOutEnable(HI_VOID)
{
    HDMIRX_AUDIO_CONTEXT_S *pstAudioCtx;

    pstAudioCtx = HDMIRX_AUDIO_GET_CTX();
    if ((pstAudioCtx->bProtected 
		#if SUPPORT_HBR
		|| pstAudioCtx->bHbrMode
		#endif
		#if SUPPORT_DSD
		||pstAudioCtx->bDsdMode 
		#endif
		|| ((!pstAudioCtx->bEnc)
		#if SUPPORT_AUDIO_INFOFRAME
		&& pstAudioCtx->u32Ca
		#endif
		)))
    {
        return HI_FALSE;
	}
    return HI_TRUE;
}

//------------------------------------------------------------------------------
// Function:    	HDMIRX_AUDIO_IsSpdifOutEnable
// Description: 	set the spdif output on acp packet.. 
// Parameters:  	enType: 	acp_GeneralAudio
//                      			acp_IEC60958
//                      			acp_DvdAudio
//                      			acp_SuperAudioCD
// Returns:     	None
//------------------------------------------------------------------------------
#if SUPPORT_ACP
HI_VOID HDMIRX_AUDIO_UpdateOnAcp(HI_UNF_HDMIRX_PORT_E enPort,HDMIRX_ACP_TYPE_E enType)
{
    HI_BOOL bProctect = HI_FALSE;
    HI_BOOL bOutEn;
    HDMIRX_AUDIO_CONTEXT_S *pstAudioCtx;

    pstAudioCtx = HDMIRX_AUDIO_GET_CTX();
    if(enType != ACP_GENERAL_AUDIO) 
	{
        bProctect = HI_TRUE;
    }
    if (pstAudioCtx->bProtected != bProctect) 
	{
        pstAudioCtx->bProtected = bProctect;
        if ((pstAudioCtx->enAudioState == AUDIO_STATE_ON) || \
            (pstAudioCtx->enAudioState == AUDIO_STATE_READY)) 
		{
           bOutEn = HDMIRX_AUDIO_IsSpdifOutEnable();
           //HDMIRX_HAL_RegWriteFldAlign(RX_AUDRX_CTRL, reg_spdif_en, (HI_U32)bOutEn); 
           HDMIRX_HAL_SetSpdifOutEn(enPort, bOutEn);
        }
    }
}
#endif

static HI_VOID HDMIRX_AUDIO_SetMclk(HI_UNF_HDMIRX_PORT_E enPort)
{
    HDMIRX_AUDIO_MCLK_E enMclk = RX_CFG_256FS;
    HI_U32          fs_code = AUDIO_CHST4_FS_UNKNOWN;
    HI_U32          u32Cts;
    HI_U32          u32N;
    HI_U32          u32TmdsClk;
    HI_U32          fs_100Hz;
    HI_U32          i;
    HDMIRX_AUDIO_CONTEXT_S *pstAudioCtx;

    pstAudioCtx = HDMIRX_AUDIO_GET_CTX();
    pstAudioCtx->u32MeasuredFs = AUDIO_CHST4_FS_UNKNOWN;
    fs_code = AUDIO_CHST4_FS_UNKNOWN;
	#if SUPPORT_DSD
    if (pstAudioCtx->bDsdMode) 
    {
        enMclk = RX_CFG_256FS;
        fs_code = AUDIO_CHST4_FS_44;
    }
    else
	#endif
    {
        u32N = HDMIRX_HAL_GetN(enPort);
        u32Cts = HDMIRX_HAL_GetCts(enPort);
        u32TmdsClk = HDMIRX_AUDIO_GetTmdsClk_10k();
        if (u32TmdsClk && u32Cts) 
        {
            fs_100Hz = (u32TmdsClk*u32N/u32Cts)*100/128;
            for(i = 0; i < AUDIO_FS_LIST_LENGTH; i++)
			{
				if((fs_100Hz <= AudioFsList[i].u32MaxFs)
					&& (fs_100Hz > AudioFsList[i].u32MinFs))
				{
					// search if calculated Fs close to the Fs in the table
                    //HDMI_INFO("%s:%d\n ",__FUNCTION__,i);
                    break;
				}
			}
			fs_code = AudioFsList[i].u32Code;
        }
     //   HDMI_INFO("%s code:%d\n ",__FUNCTION__,fs_code);
		#if SUPPORT_HBR
        if(pstAudioCtx->bHbrMode)
		{
            if(AUDIO_CHST4_FS_UNKNOWN == fs_code)
			{
				fs_code = AUDIO_CHST4_FS_192;
             //   pstAudioCtx->u32MeasuredFs = AUDIO_CHST4_FS_768;
			}
           // fs_code = AUDIO_CHST4_FS_768;
            //enMclk = RX_CFG_128FS;
            #if 0
			if(AUDIO_CHST4_FS_192 == fs_code)
			{
				enMclk = RX_CFG_256FS;
				//pstAudioCtx->u32MeasuredFs = AUDIO_CHST4_FS_768;
			}
            #endif
		}
        #endif
		//else
		if(fs_code != AUDIO_CHST4_FS_UNKNOWN)
		{
            pstAudioCtx->u32MeasuredFs = fs_code;         
        }
        else
        {
            pstAudioCtx->u32MeasuredFs = HDMIRX_HAL_GetHwSampleRate(enPort);
        }
		if(pstAudioCtx->u32MeasuredFs == AUDIO_CHST4_FS_UNKNOWN)
		{
            pstAudioCtx->u32MeasuredFs = AUDIO_CHST4_FS_48;            
        }
			
		
	}
    
    HDMIRX_HAL_SetMclk(enPort,(enMclk << 6) | (enMclk << 4) | fs_code);
    if(
		#if SUPPORT_DSD
		(pstAudioCtx->bDsdMode) || 
		#endif
		(fs_code == AUDIO_CHST4_FS_UNKNOWN)) 
	{
		//if DSD mode or calculated Fs invalid
		HDMIRX_HAL_SetFsSel(enPort,HI_FALSE);
	}
	else
	{
		// use SW selected Fs
		HDMIRX_HAL_SetFsSel(enPort,HI_TRUE);
	}
        
}
#if SUPPORT_AUDIO_INFOFRAME
static HI_U32 HDMIRX_AUDIO_GetChannelMask(HI_U32 u32Ca)
{
	HI_U32 audio_mask = 0x10; // default: stereo
	
	if(u32Ca < AUDIO_CHANNEL_MASK_TABLE_LENGTH)
	{
		audio_mask = AudioChannelMask[u32Ca];
	}
    
	return audio_mask;
}
#endif
static HI_VOID HDMIRX_AUDIO_SetOut(HI_UNF_HDMIRX_PORT_E enPort)
{
    HI_U32 out_mask =
		reg_mclk_en   | // always enabled
		reg_sd0_en    | // at least one I2S (two DSD) channel
		reg_mute_flat; // mute invalid packets
    HDMIRX_AUDIO_CONTEXT_S *pstAudioCtx;

    pstAudioCtx = HDMIRX_AUDIO_GET_CTX();
	#if SUPPORT_HBR
	if(pstAudioCtx->bHbrMode)
	{
		out_mask |= reg_sd3_en | reg_sd2_en | reg_sd1_en | reg_sd0_en;  // All 4 I2S lines are used for HBRA
	}
	else 
	#endif
	#if SUPPORT_DSD
	if(pstAudioCtx->bDsdMode)
	{
		if(pstAudioCtx->blayout1)
		{
			out_mask |= reg_sd2_en | reg_sd1_en | reg_sd0_en;
		}
	}
	else
	#endif
	#if SUPPORT_AUDIO_INFOFRAME
	if(HDMIRX_PACKET_AIF_IsGot() == HI_TRUE)
	{
        if(pstAudioCtx->bEnc == HI_FALSE)
		{
			out_mask |= HDMIRX_AUDIO_GetChannelMask(pstAudioCtx->u32Ca);
		}
		// Encoded data can be whether through 1 I2S channel or through HBRA;
		// it cannot be through multiple I2S channels in non-HBRA mode.
		else 
		{
			out_mask |= reg_vucp;
		}
	}
	#endif
    HDMIRX_HAL_SetI2sOutCfg(enPort,out_mask);

	// enable SPDIF if allowed
	HDMIRX_HAL_SetSpdifOutEn(enPort,HDMIRX_AUDIO_IsSpdifOutEnable());
    HDMIRX_HAL_SetI2sOutDft(enPort);
    HDMIRX_HAL_SetHwMute(enPort,pstAudioCtx->bSoftMute);
}


HDMIX_AUDIO_STATE_E HDMIRX_AUDIO_Getstatus(HI_VOID)
{
    HDMIRX_AUDIO_CONTEXT_S *pstAudioCtx;
    
    pstAudioCtx = HDMIRX_AUDIO_GET_CTX();

    return pstAudioCtx->enAudioState;
}


HI_VOID HDMIRX_AUDIO_Initial(HI_VOID)
{
    HDMIRX_AUDIO_CONTEXT_S *pstAudioCtx;

    pstAudioCtx = HDMIRX_AUDIO_GET_CTX();
    memset(pstAudioCtx, 0, sizeof(HDMIRX_AUDIO_CONTEXT_S));
   	HDMIRX_AUDIO_ChangeState(AUDIO_STATE_OFF, 0);
	
    pstAudioCtx->u32Fs= AUDIO_CHST4_FS_UNKNOWN; // means "not indicated", default values for 48kHz audio will be used.
    pstAudioCtx->bSoftMute = HI_TRUE;
    // default audio settings (set to I2S)

    // allow SPDIF clocking even if audio is not coming out

	#if SUPPORT_AUDIO_INFOFRAME
#if SUPPORT_DOUBLE_CTRL
    HDMIRX_PACKET_ResetAudInfoFrameData(HI_UNF_HDMIRX_PORT0);
#endif
    HDMIRX_PACKET_ResetAudInfoFrameData(HI_UNF_HDMIRX_PORT1);
	#endif
}

HI_VOID HDMIRX_AUDIO_SetCa(HI_U32 u32Ca)
{
    HDMIRX_AUDIO_CONTEXT_S *pstAudioCtx;

    pstAudioCtx = HDMIRX_AUDIO_GET_CTX();
    pstAudioCtx->u32Ca= u32Ca;
}

/*HI_VOID HDMIRX_AUDIO_SetChannelNum(HDMIRX_AUDIO_CHANNEL_NUM_E enNum)
{
    HDMIRX_AUDIO_CONTEXT_S *pstAudioCtx;

    pstAudioCtx = HDMIRX_AUDIO_GET_CTX();
    pstAudioCtx->enChannelNum = enNum;
}*/


HI_VOID HDMIRX_AUDIO_Update(HI_UNF_HDMIRX_PORT_E enPort)
{
    HDMIRX_AUDIO_CONTEXT_S *pstAudioCtx;

    pstAudioCtx = HDMIRX_AUDIO_GET_CTX();
    if((AUDIO_STATE_ON== pstAudioCtx->enAudioState) || (AUDIO_STATE_READY== pstAudioCtx->enAudioState))
	{
		HDMIRX_AUDIO_SetOut(enPort);
		HDMIRX_AUDIO_SetMclk(enPort); // couldn't it make audio restart if MCLK changed?
	}
}
#if 0//SUPPORT_AUDIO_INFOFRAME
static HI_VOID HDMIRX_AUDIO_OnAudioInfoFrame(HI_U32 *pu32Data, HI_U32 length)
{
    HDMIRX_AUDIO_CONTEXT_S *pstAudioCtx;

    pstAudioCtx = HDMIRX_AUDIO_GET_CTX();
    if(pu32Data && (length >= 5))
	{
		HDMIRX_PACKET_AIF_SetGotFlag(HI_TRUE);
		pstAudioCtx->u32Ca= pu32Data[3];
	}
	else
	{
		HDMIRX_PACKET_AIF_SetGotFlag(HI_FALSE);
	}

	if(HDMIRX_PACKET_AIF_IsGot()== HI_TRUE)
	{
		// update() function has to be called since channel allocation (CA) field my be changed
		HDMIRX_AUDIO_Update();
	}
}
#endif




/*
------------------------------------------------------------------------------
 Function:    	HDMIRX_AUDIO_AacDone
 Description: 	Close aac and audio. 
 Parameters:  None.
 Returns:     	None.
 Note:		1/ called if enter audio_off
 			2/ called if no scdt.
------------------------------------------------------------------------------
*/
HI_VOID HDMIRX_AUDIO_AacDone(HI_UNF_HDMIRX_PORT_E enPort)
{
    #if SUPPORT_AEC
    HDMIRX_AUDIO_CONTEXT_S *pstAudioCtx;
    
    pstAudioCtx = HDMIRX_AUDIO_GET_CTX();
    if(pstAudioCtx->bExceptionsEn)
    #endif
	{
		#if SUPPORT_AUDIO_INFOFRAME
		HDMIRX_PACKET_ResetAudInfoFrameData(enPort);
		#endif
        #if SUPPORT_AEC
		HDMIRX_AUDIO_SetExceptionsEn(enPort,HI_FALSE);
        #endif
	}

	HDMIRX_AUDIO_OnOff(enPort,HI_FALSE);
	HDMIRX_HAL_DisableI2sOut(enPort);

	HDMIRX_AUDIO_ChangeState(AUDIO_STATE_OFF, 0);
    
}

HI_VOID HDMIRX_AUDIO_Stop(HI_UNF_HDMIRX_PORT_E enPort)
{
    HDMIRX_AUDIO_CONTEXT_S *pstAudioCtx;

    pstAudioCtx = HDMIRX_AUDIO_GET_CTX();
    {
		HDMIRX_AUDIO_AacDone(enPort);
	}
	pstAudioCtx->bStartReq = HI_FALSE;
}

HI_VOID HDMIRX_AUDIO_AssertOff(HI_UNF_HDMIRX_PORT_E enPort)
{
    HDMIRX_AUDIO_CONTEXT_S *pstAudioCtx;

    pstAudioCtx = HDMIRX_AUDIO_GET_CTX();
    if(AUDIO_STATE_OFF != pstAudioCtx->enAudioState)
	{
        HDMIRX_AUDIO_Stop(enPort);
	}
}
HI_BOOL HDMIRX_AUDIO_IsRequest(HI_VOID)
{
    HDMIRX_AUDIO_CONTEXT_S *pstAudioCtx;

    pstAudioCtx = HDMIRX_AUDIO_GET_CTX();
    
    return pstAudioCtx->bStartReq;
}

HI_VOID HDMIRX_AUDIO_Restart(HI_UNF_HDMIRX_PORT_E enPort)
{
    if (HDMIRX_AUDIO_IsRequest()) 
    {
        HDMIRX_AUDIO_Stop(enPort);
    }
    HDMIRX_AUDIO_Start();
}
#if 0
static HI_BOOL HDMIRX_AUDIO_IsAvMute(HI_VOID)
{
    HI_U32 u32Value;

    u32Value = HDMIRX_HAL_GetAudp();
    if ((u32Value &(hdmi_mode_det | hdmi_mute)) == hdmi_mute) 
    {
        return HI_TRUE;
    }
    else 
    {
        return HI_FALSE;
    }
}
#endif
HI_VOID HDMIRX_AUDIO_StreamTypeChanged(HI_UNF_HDMIRX_PORT_E enPort)
{

	HDMIRX_AUDIO_Stop(enPort);
	HDMIRX_AUDIO_Start();
}

HI_VOID HDMIRX_AUDIO_OnChannelStatusChg(HI_UNF_HDMIRX_PORT_E enPort)
{
    HDMIRX_AUDIO_CONTEXT_S *pstAudioCtx;

    pstAudioCtx = HDMIRX_AUDIO_GET_CTX();
    HDMIRX_HAL_GetChannelSta(enPort, pstAudioCtx->au32ChannelSta);
	#if SUPPORT_DSD
    if (pstAudioCtx->bDsdMode) 
    {
        pstAudioCtx->bEnc = HI_FALSE;
    }
    else
	#endif
    {
    	#if SUPPORT_HBR
        if(pstAudioCtx->bHbrMode == HI_TRUE)
        {
			pstAudioCtx->bEnc = HI_TRUE;
        }
		else
		#endif
		if((pstAudioCtx->au32ChannelSta[0] & AUDIO_CHST1_ENCODED) != 0)
		{
			pstAudioCtx->bEnc = HI_TRUE;
		}
		else
		{
			pstAudioCtx->bEnc = HI_FALSE;
		}
    }
    //HDMIRX_HAL_RegReadBlock(RX_CHST4, &pstAudioCtx->au32ChannelSta[3], 2);  // maybe
    #if 1
    // Fs data read from RX_CHST4 may be not the actual value coming
	// from HDMI input, but the Fs written into RX_FREQ_SVAL.
	// To have real Fs value, get it from RX_TCLK_FS register
	// and replace in the audio status channel byte 4.
	pstAudioCtx->au32ChannelSta[3] &= ~CHST4_SAMPLE_F;
	pstAudioCtx->u32Fs= HDMIRX_HAL_GetHwSampleRate(enPort); // HW measured Fs
	
    if(AUDIO_CHST4_FS_UNKNOWN != pstAudioCtx->u32MeasuredFs)
	{
		// replace with FW measured values
		pstAudioCtx->au32ChannelSta[3] |= pstAudioCtx->u32MeasuredFs;
	}
	else
	{
		// replace with HW measured values
		pstAudioCtx->au32ChannelSta[3] |= pstAudioCtx->u32Fs;
	}
	
    #endif
    // Note: DSD does not have Audio Status Channel, so all bytes in the Audio
	// Status Channel registers are zeros.
	// That should not cause problems because the DSD format is fixed.

    pstAudioCtx->blayout1 = (HI_BOOL)HDMIRX_HAL_GetLayout(enPort);

	pstAudioCtx->bStatusReceived = HI_TRUE;
    HDMIRX_AUDIO_Update(enPort);
}

static HI_VOID HDMIRX_AUDIO_AcrProcess(HI_UNF_HDMIRX_PORT_E enPort)
{
	HI_BOOL bCtsError;


	HDMIRX_HAL_ClearInterrupt(enPort,HDMIRX_INT_HW_CTS_CHG);
    //HDMIRX_HAL_RegWriteFldAlign(RX_ECC_CTRL, reg_capture_cnt, 1);
    HDMIRX_HAL_ClearT4Error(enPort);
    
    HDMIRX_HAL_ClearInterrupt(enPort,HDMIRX_INT_CTS_DROP_ERR);
    HDMIRX_HAL_ClearInterrupt(enPort,HDMIRX_INT_CTS_REUSE_ERR);
    udelay(64);
    bCtsError = HDMIRX_AUDIO_IsCtsError(enPort);
   
    if (bCtsError) 
	{
        //audio errors still present
        HDMIRX_HAL_ClearInterrupt(enPort,HDMIRX_INT_HW_CTS_CHG);
        
        HDMIRX_HAL_SetResetEn(enPort,HDMIRX_ACR_RST, HI_TRUE);
		udelay(2);
        HDMIRX_HAL_SetResetEn(enPort,HDMIRX_ACR_RST, HI_FALSE);
        // schedule next check
        HDMIRX_AUDIO_ChangeState(AUDIO_STATE_REQ, 30000);
    }
    else 
	{
        // no errors, prepare for the next step, the bit will be cleared automatically
        HDMIRX_HAL_SetAcrStart(enPort);
        
        HDMIRX_AUDIO_Refresh(enPort);
        HDMIRX_AUDIO_SetMclk(enPort);
        HDMIRX_AUDIO_ChangeState(AUDIO_STATE_READY, 30000);
    }
    
    HDMIRX_HAL_ClearInterrupt(enPort,HDMIRX_INT_CTS);
    HDMIRX_HAL_ClearInterrupt(enPort,HDMIRX_INT_NEW_AUD_PACKET);
}
static HI_BOOL HDMIRX_AUDIO_IsTimeOut(HI_VOID)
{
    static struct timeval stAudioTime;
    struct timeval stCurTime;
    HDMIRX_AUDIO_CONTEXT_S *pstAudioCtx;

    pstAudioCtx = HDMIRX_AUDIO_GET_CTX();
	if(pstAudioCtx->u32TimeOut == 0)
	{
		return HI_TRUE;
	}
	do_gettimeofday(&stCurTime);	
	if (HDMIRX_TIME_DIFF_US(stCurTime, stAudioTime) >= pstAudioCtx->u32TimeOut) 
    {
        do_gettimeofday(&stAudioTime);
        return HI_TRUE;
    }
	
    return HI_FALSE;
}

HI_VOID HDMIRX_AUDIO_GetInfo(HI_UNF_AI_HDMI_ATTR_S *pstAudioInfo)
{
    HDMIRX_AUDIO_CONTEXT_S *pstAudioCtx;

    pstAudioCtx = HDMIRX_AUDIO_GET_CTX();
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
	return ; 
}
HI_VOID HDMIRX_AUDIO_GetAudioInfo(HDMIRX_AUDIO_CONTEXT_S *AudioCtx)
{
    HDMIRX_AUDIO_CONTEXT_S *pstAudioCtx;

    pstAudioCtx = HDMIRX_AUDIO_GET_CTX();

    memcpy(AudioCtx,pstAudioCtx,sizeof(HDMIRX_AUDIO_CONTEXT_S));
    
}


HI_VOID HDMIRX_AUDIO_MainLoop(HI_UNF_HDMIRX_PORT_E enPort)
{
    HI_BOOL bTimeOut;
	HI_BOOL bClkStable;
	HI_BOOL bFifoStable;
	HI_BOOL bChannelStatusChg;
    HDMIRX_AUDIO_CONTEXT_S *pstAudioCtx;

    pstAudioCtx = HDMIRX_AUDIO_GET_CTX();
    if((HDMIRX_HAL_IsFifoStable(enPort) == HI_FALSE) && \
        (pstAudioCtx->enAudioState == AUDIO_STATE_ON))
    {
        pstAudioCtx->u32FifoErrCnt++;
    }
    bTimeOut = HDMIRX_AUDIO_IsTimeOut();
    if(bTimeOut == HI_FALSE) 
    {
        return;
    }
    
    switch (pstAudioCtx->enAudioState) 
	{
        //------------------------------------------------------------------------
        case AUDIO_STATE_OFF:
            pstAudioCtx->bStatusReceived = HI_FALSE;
            #if SUPPORT_AEC
            if (pstAudioCtx->bExceptionsEn == HI_TRUE) 
			{
                HDMIRX_AUDIO_AacDone(enPort);
                break;
            }
            #endif
            if(pstAudioCtx->bStartReq == HI_TRUE) 
            {
                #if SUPPORT_AEC
                HDMIRX_HAL_SetResetEn(enPort,HDMIRX_AAC_RST, HI_TRUE);
			 	udelay(4);
			 	HDMIRX_HAL_SetResetEn(enPort,HDMIRX_AAC_RST, HI_FALSE);
                #endif
             	HDMIRX_AUDIO_ChangeState(AUDIO_STATE_REQ, 0);
			 	#if SUPPORT_AUDIO_INFOFRAME
             	HDMIRX_PACKET_ResetAudInfoFrameData(enPort);
				#endif
             	pstAudioCtx->u32MeasuredFs = AUDIO_CHST4_FS_UNKNOWN;  
            }
            else 
			{
                HDMIRX_AUDIO_ChangeState(AUDIO_STATE_OFF, 30000);
            }
            break;
        //------------------------------------------------------------------------
        case AUDIO_STATE_REQ:
            pstAudioCtx->bStatusReceived = HI_FALSE;
            HDMIRX_AUDIO_AcrProcess(enPort);
            break;
		//------------------------------------------------------------------------	
        case AUDIO_STATE_READY:
             bClkStable = HDMIRX_HAL_IsClockStable(enPort);
			 bFifoStable = HDMIRX_AUDIO_IsFifoStable(enPort);
            if((bClkStable == HI_FALSE) || (bFifoStable == HI_FALSE)) 
			{   
                HDMIRX_AUDIO_ChangeState(AUDIO_STATE_REQ, 0);
            }
            else 
			{
                pstAudioCtx->bEnc = HI_TRUE;
                pstAudioCtx->au32ChannelSta[0] = 0x03;
                HDMIRX_AUDIO_OnOff(enPort,HI_TRUE);
                pstAudioCtx->u32FifoErrCnt = 0;
                HDMIRX_AUDIO_ChangeState(AUDIO_STATE_ON, 200000);
            }
            break;
		//------------------------------------------------------------------------	
        case AUDIO_STATE_ON:
			bChannelStatusChg = HDMIRX_AUDIO_IsStatusChanged(enPort);
            if(bChannelStatusChg == HI_TRUE) 
			{
                HDMIRX_AUDIO_OnChannelStatusChg(enPort);
            }
            HDMIRX_AUDIO_ChangeState(AUDIO_STATE_ON, 200000);
            break;
        default:
            break;
    }
}

HI_VOID HDMIRX_AUDIO_ProcRead(struct seq_file *s, HI_VOID *data)
{
    HDMIRX_AUDIO_CONTEXT_S *pstAudioCtx;

    pstAudioCtx = HDMIRX_AUDIO_GET_CTX();
    PROC_PRINT(s, "\n---------------HDMIRX AUDIO INFORMATION:---------------\n");
    if(pstAudioCtx->enAudioState <= AUDIO_STATE_BUTT )
    {
        PROC_PRINT(s,"Audio state is         :   %s\n",s_apsHdmirxAudioStateString[pstAudioCtx->enAudioState]);
    }
    //-----------------------------------------------------------
    switch (pstAudioCtx->u32MeasuredFs)
	{
		case AUDIO_CHST4_FS_44:
            PROC_PRINT(s,"Audio sample rate is         :   %s\n","44kHz");
			break;
		case AUDIO_CHST4_FS_48:
            PROC_PRINT(s,"Audio sample rate is         :   %s\n","48kHz");
			break;
		case AUDIO_CHST4_FS_32:
            PROC_PRINT(s,"Audio sample rate is         :   %s\n","32kHz");
			break;
		case AUDIO_CHST4_FS_22:
            PROC_PRINT(s,"Audio sample rate is         :   %s\n","22kHz");
			break;
		case AUDIO_CHST4_FS_24:
            PROC_PRINT(s,"Audio sample rate is         :   %s\n","24kHz");
			break;
		case AUDIO_CHST4_FS_88:
            PROC_PRINT(s,"Audio sample rate is         :   %s\n","88kHz");
			break;
		case AUDIO_CHST4_FS_96:
            PROC_PRINT(s,"Audio sample rate is         :   %s\n","96kHz");
			break;
		case AUDIO_CHST4_FS_176:
            PROC_PRINT(s,"Audio sample rate is         :   %s\n","176kHz");
			break;			
		case AUDIO_CHST4_FS_192:
            PROC_PRINT(s,"Audio sample rate is         :   %s\n","192kHz");
			break;
        case AUDIO_CHST4_FS_768:
            PROC_PRINT(s,"Audio sample rate is         :   %s\n","768kHz");
			break;	
		default:
            PROC_PRINT(s,"Audio sample rate is         :   %s\n","unknown");
			break;			
	}
	//----------------------------------------------------------------
	if(pstAudioCtx->bEnc)
	{
        PROC_PRINT(s,"Audio is Encoded.       \n");
	}
    else
    {
        PROC_PRINT(s,"Audio is PCM.       \n");
    }
    //------------------------------------------------------------------
    if(pstAudioCtx->blayout1)
	{
        PROC_PRINT(s,"Audio layout1 is true.       \n");
	}
    else
    {
        PROC_PRINT(s,"Audio layout1 is false.       \n");
    }
    //------------------------------------------------------------------
    if(pstAudioCtx->bHbrMode)
    {
        PROC_PRINT(s,"Audio is HBR.       \n");
    }
    else
    {
        PROC_PRINT(s,"Audio is LBR.       \n");
    }
    //------------------------------------------------------------------
    PROC_PRINT(s,"Audio fifo error cnt = %d.       \n",pstAudioCtx->u32FifoErrCnt);
    //------------------------------------------------------------------
    if(pstAudioCtx->bProtected)
    {
        PROC_PRINT(s,"Audio is protected.       \n");
    }
    else
    {
        PROC_PRINT(s,"Audio is dis-protected.       \n");
    }
    PROC_PRINT(s,"Audio channel status[0]  = 0x%x.       \n",pstAudioCtx->au32ChannelSta[0]);
    PROC_PRINT(s,"Audio channel status[1]  = 0x%x.       \n",pstAudioCtx->au32ChannelSta[1]);
    PROC_PRINT(s,"Audio channel status[2]  = 0x%x.       \n",pstAudioCtx->au32ChannelSta[2]);
    PROC_PRINT(s,"Audio channel status[3]  = 0x%x.       \n",pstAudioCtx->au32ChannelSta[3]);
    PROC_PRINT(s,"Audio channel status[4]  = 0x%x.       \n",pstAudioCtx->au32ChannelSta[4]);
}
#ifdef __cplusplus
 #if __cplusplus
}
 #endif
#endif /* __cplusplus */
