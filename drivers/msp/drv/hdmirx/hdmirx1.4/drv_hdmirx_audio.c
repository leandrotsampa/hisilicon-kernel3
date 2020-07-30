//******************************************************************************
//  Copyright (C), 2007-2014, Hisilicon Technologies Co., Ltd.
//
//******************************************************************************
// File name     : drv_hdmirx_audio.c
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
#include <linux/sched.h>
#include <linux/delay.h>
#include "hi_drv_proc.h"

//#include "hi_tvd.h"
#include "hi_type.h"
//#include "command.h"
//#include "int.h"
//#include "hal_hdmirx_reg.h"
#include "drv_hdmirx.h"
//#include "drv_hdmirx_isr.h"
#include "drv_hdmirx_audio_internal.h"
/***********************************************************************************************************/





static const audio_fs_search audio_fs_list[AUDIO_FS_LIST_LENGTH+1] =
{
	{ AUDIO_CHST4__FS_22,		220,	200,	230  },
	{ AUDIO_CHST4__FS_24,		240,	230,	280  },
	{ AUDIO_CHST4__FS_32,		320,	280,	380  },
	{ AUDIO_CHST4__FS_44,		441,	380,	460  },
	{ AUDIO_CHST4__FS_48,		480,	460,	540  },
	{ AUDIO_CHST4__FS_88,		882,	820,	921  },
	{ AUDIO_CHST4__FS_96,		960,	921,	1100 },
	{ AUDIO_CHST4__FS_176,		1764,	1600,	1792 },
	{ AUDIO_CHST4__FS_192,		1920,	1792,	2500 },
	{ AUDIO_CHST4__FS_UNKNOWN,	0,    	0,		0 }

};

static HI_U32 default_aec_regs[3] = {0xC1, 0x07, 0x01};

static const HI_U8 audio_channel_mask[AUDIO_CHANNEL_MASK_TABLE_LENGTH] =
{
	0x10, 0x30, 0x30, 0x30, 0x70, 0x70, 0x70, 0x70,
	0x70, 0x70, 0x70, 0x70, 0xF0, 0xF0, 0xF0, 0xF0,
	0xF0, 0xF0, 0xF0, 0xF0, 0xB0, 0xB0, 0xB0, 0xB0,
	0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0,
};

/*
                                128    256     384     512
AUDIO_CHST4__FS_44		        12     6       4        4
AUDIO_CHST4__FS_UNKNOWN	        6       6       6       6   
AUDIO_CHST4__FS_48		        12      6       4        4
AUDIO_CHST4__FS_32		        24      12      8         6    
AUDIO_CHST4__FS_22	            6       6       6       6
AUDIO_CHST4__FS_22              6       6       6       6
AUDIO_CHST4__FS_24              6       6       6       6		        
AUDIO_CHST4__FS_24              6       6       6       6
AUDIO_CHST4__FS_88              6       4       2       2		
AUDIO_CHST4__FS_768              6       6       6       6		
AUDIO_CHST4__FS_96              6       4       2       2
AUDIO_CHST4__FS_96              6       4       2       2
AUDIO_CHST4__FS_176              4       2       6       6
AUDIO_CHST4__FS_176              4       2       6       6
AUDIO_CHST4__FS_192              4       2       6       6
*/

static const HI_U32 enreg_post_val_sw[15][4] ={
    {12, 6, 4, 4},
    {6,  6, 6, 6},
    {12, 6, 4, 4},
    {24, 12, 8, 6},
    {6, 6, 6, 6},
    {6, 6, 6, 6},
    {6, 6, 6, 6},
    {6, 6, 6, 6},
    {6, 4, 2, 2},
    {6, 6, 6, 6},
    {6, 4, 2, 2},
    {6, 4, 2, 2},
    {4, 2, 6, 6},
    {4, 2, 6, 6},
    {4, 2, 6, 6}    
};

/****************************************************************************************
    basic function of audio
*****************************************************************************************/
static void HDMI_AUD_ChangeState(HI_U32 u32NewState, HI_U32 Counter)
{
    hdmi_ctx.strAudio.eAudioState = u32NewState;
    if (AUDIO_TIMER_MAX < Counter) {
        Counter = AUDIO_TIMER_MAX;
    }
    hdmi_ctx.strAudio.u32Timer = Counter;
    hdmi_ctx.Timer[HDMI_TIMER_IDX_AUDIO] = 0;
}



static HI_U32 HDMI_AUD_GetChannelMask(HI_U32 ca)
{
	HI_U32 audio_mask = 0x10; // default: stereo
	
	if(ca < AUDIO_CHANNEL_MASK_TABLE_LENGTH)
	{
		audio_mask = audio_channel_mask[ca];
	}
    
	return audio_mask;
}

static HI_BOOL HDMI_AUD_IsSpdifOutEnable(void)
{
	if (0 != ((hdmi_ctx.strAudio.bProtected) || hdmi_ctx.strAudio.bHbrMode || hdmi_ctx.strAudio.bDsdMode || 	((!hdmi_ctx.strAudio.bEnc) && hdmi_ctx.strAudio.ca))) {
        return HI_FALSE;
	}
    
    return HI_TRUE;
}

static HI_U32 HDMI_AUD_GetTmdsClk_10k(void)
{
    HI_U32 tmds_clk_10kHz = hdmi_ctx.strTimingInfo.u32PixFreq;
	// this is Pix Clock (not TMDS clock at that moment) in 100 Hz units

	// convert pixel clock into TMDS clock
	//HI_INFO_HDMIRX("hdmi_ctx.eInputWidth = %d \n", hdmi_ctx.eInputWidth);
	switch(hdmi_ctx.eInputWidth)
	{
		case RX_VBUS_WIDTH_30: // DC 30 bit
			tmds_clk_10kHz = tmds_clk_10kHz * 5 / 4; // *1.25
		    break;
		case RX_VBUS_WIDTH_36: // DC 36 bit
			tmds_clk_10kHz = tmds_clk_10kHz * 3 / 2; // *1.5
		    break;
		case RX_VBUS_WIDTH_48: // DC 48 bit (reserved for the future)
			tmds_clk_10kHz *= 2; // *2
		    break;
        default:
            break;
	}
	return tmds_clk_10kHz;
}

static HI_U32 HDMI_AUD_GetN(void)
{
    HI_U32 u32Temp = 0;
    
    u32Temp += ((HDMI_HAL_RegRead(RX_N_HVAL3)&0x000000ff) << 16);
    u32Temp += ((HDMI_HAL_RegRead(RX_N_HVAL2)&0x000000ff) << 8);
    u32Temp += (HDMI_HAL_RegRead(RX_N_HVAL1)&0x000000ff);

    return u32Temp;
}

static HI_U32 HDMI_AUD_GetCts(void)
{
    HI_U32 u32Temp = 0;
    
    u32Temp += ((HDMI_HAL_RegRead(RX_CTS_HVAL3)&0x000000ff) << 16);
    u32Temp += ((HDMI_HAL_RegRead(RX_CTS_HVAL2)&0x000000ff) << 8);
    u32Temp += (HDMI_HAL_RegRead(RX_CTS_HVAL1)&0x000000ff);

    return u32Temp;
}
static void HDMI_AUD_SetMclk(void)
{
    hdmi_Audio_Mclk mclk = RX_CFG_256FS;
    HI_U32          fs_code = AUDIO_CHST4__FS_UNKNOWN;
    HI_U32          u32Cts;
    HI_U32          u32N;
    HI_U32          u32TmdsClk;
   // HI_U32          fs_Freq = 0;
    HI_U32          fs_100Hz;
    HI_U32          i;
    
    hdmi_ctx.strAudio.u32MeasuredFs = AUDIO_CHST4__FS_UNKNOWN;
    fs_code = AUDIO_CHST4__FS_UNKNOWN;
    //HI_INFO_HDMIRX("HDMI_AUD_SetMclk = %d ...................................................\n", hdmi_ctx.strAudio.bDsdMode);
    if (hdmi_ctx.strAudio.bDsdMode) {
        mclk = RX_CFG_256FS;
        fs_code = AUDIO_CHST4__FS_44;
    }
    else {
        u32N = HDMI_AUD_GetN();
        u32Cts = HDMI_AUD_GetCts();
        u32TmdsClk = HDMI_AUD_GetTmdsClk_10k();
        //HI_INFO_HDMIRX("u32TmdsClk= %d \n", u32TmdsClk);
          //  HI_INFO_HDMIRX("u32N= %d \n", u32N);
          //  HI_INFO_HDMIRX("u32Cts = %d \n", u32Cts);
        if (u32TmdsClk && u32Cts) {
            fs_100Hz = (u32TmdsClk*u32N/u32Cts)*100/128;
            
            
            for(i = 0; i < AUDIO_FS_LIST_LENGTH; i++)
			{
				if((fs_100Hz <= ( audio_fs_list[i].max_Fs))
					&& (fs_100Hz > ( audio_fs_list[i].min_Fs) ))
				{
					// search if calculated Fs close to the Fs in the table
					break;
				}
			}
			fs_code = audio_fs_list[i].code_value;
			//fs_Freq= audio_fs_list[i].ref_Fs;
        }
        if(hdmi_ctx.strAudio.bHbrMode)
		{
            if(AUDIO_CHST4__FS_UNKNOWN == fs_code)
			{
				fs_code = AUDIO_CHST4__FS_192;
			}

			if(AUDIO_CHST4__FS_192 == fs_code)
			{
				mclk = RX_CFG_128FS;
				hdmi_ctx.strAudio.u32MeasuredFs = AUDIO_CHST4__FS_768;
			}
			else if(mclk > RX_CFG_256FS)
			{
				mclk = RX_CFG_256FS;
			}
		}
		else
		{
			// limit master clock to the maximum allowed by the chip
			switch(fs_code)
			{
				default:
					break;
				case AUDIO_CHST4__FS_88:
				case AUDIO_CHST4__FS_96:
					if(mclk > RX_CFG_256FS)
					{
						mclk = RX_CFG_256FS;
					}
					break;
				case AUDIO_CHST4__FS_176:
				case AUDIO_CHST4__FS_192:
				//case AUDIO_CHST4__FS_768: // it should not be used if not in HBR mode
					//mclk = RX_CFG_128FS;
					break;
			}
			hdmi_ctx.strAudio.u32MeasuredFs = fs_code;
		}
	}
    switch(hdmi_ctx.strAudio.u32MeasuredFs) {
        case  AUDIO_CHST4__FS_44:
            HI_INFO_HDMIRX("Audio Sampled rate is 44kHz. \n");
            break;
        default:
        case AUDIO_CHST4__FS_UNKNOWN:
            HI_INFO_HDMIRX("Audio Sampled rate is unknown. \n");
            break;
        case AUDIO_CHST4__FS_48:
            HI_INFO_HDMIRX("Audio Sampled rate is 48kHz. \n");
            break;
        case AUDIO_CHST4__FS_32:
            HI_INFO_HDMIRX("Audio Sampled rate is 32kHz. \n");
            break;
        case AUDIO_CHST4__FS_22:
            HI_INFO_HDMIRX("Audio Sampled rate is 22kHz. \n");
            break;
        case AUDIO_CHST4__FS_24:
            HI_INFO_HDMIRX("Audio Sampled rate is 24kHz. \n");
            break;
        case AUDIO_CHST4__FS_88:
            HI_INFO_HDMIRX("Audio Sampled rate is 88kHz. \n");
            break;
        case AUDIO_CHST4__FS_768:
            HI_INFO_HDMIRX("Audio Sampled rate is 768kHz. \n");
            break;
        case AUDIO_CHST4__FS_96:
            HI_INFO_HDMIRX("Audio Sampled rate is 96kHz. \n");
            break;
        case AUDIO_CHST4__FS_176:
            HI_INFO_HDMIRX("Audio Sampled rate is 176kHz. \n");
            break;
        case AUDIO_CHST4__FS_192:
            HI_INFO_HDMIRX("Audio Sampled rate is 192kHz. \n");
            break;
        
    }
    //HI_INFO_HDMIRX("hdmi_ctx.strAudio.u32MeasuredFs = %d \n", hdmi_ctx.strAudio.u32MeasuredFs);
    HDMI_HAL_RegWrite(RX_FREQ_SVAL, (mclk << 6) | (mclk << 4) | fs_code);
    if((hdmi_ctx.strAudio.bDsdMode) || (fs_code == AUDIO_CHST4__FS_UNKNOWN)) 
	{
		//if DSD mode or calculated Fs invalid
		HDMI_HAL_RegWriteFldAlign(RX_ACR_CTRL1, reg_fs_hw_sw_sel, HI_FALSE);
	}
	else
	{
		// use SW selected Fs
		HDMI_HAL_RegWriteFldAlign(RX_ACR_CTRL1, reg_fs_hw_sw_sel, HI_TRUE);

        //reg_post_hw_sw_sel
        //HDMI_HAL_RegWriteFldAlign(RX_ACR_CTRL1, reg_post_hw_sw_sel, HI_TRUE);


        //RX_POST_SVAL--reg_post_val_sw
        
        //HDMI_HAL_RegWriteFldAlign(RX_POST_SVAL, reg_post_val_sw, 
        //enreg_post_val_sw[hdmi_ctx.strAudio.u32MeasuredFs][mclk]);
        
	}
        
}

static void HDMI_AUD_SetOut(void)
{
    HI_U8 out_mask =
		reg_mclk_en   | // always enabled
		reg_sd0_en    | // at least one I2S (two DSD) channel
		reg_mute_flat; // mute invalid packets

   // HI_INFO_HDMIRX("HDMI_AUD_SetOut!!!!!  \n");
   // HI_INFO_HDMIRX("bHbrMode = %d \n",hdmi_ctx.strAudio.bHbrMode);
   // HI_INFO_HDMIRX("bDsdMode = %d, blayout1 = %d \n",hdmi_ctx.strAudio.bDsdMode,hdmi_ctx.strAudio.blayout1);
	if(hdmi_ctx.strAudio.bHbrMode)
	{
		out_mask |= reg_sd3_en | reg_sd2_en | reg_sd1_en | reg_sd0_en;  // All 4 I2S lines are used for HBRA
	}
	else if(hdmi_ctx.strAudio.bDsdMode)
	{

		if(hdmi_ctx.strAudio.blayout1)
		{
			out_mask |= reg_sd2_en | reg_sd1_en | reg_sd0_en;
		}
	}
	else if(hdmi_ctx.strAudio.bAudioInfoFrameReceived)
	{
        //HI_INFO_HDMIRX("bEnc = %d \n", hdmi_ctx.strAudio.bEnc);
        //HI_INFO_HDMIRX("ca = %d \n", hdmi_ctx.strAudio.ca);
        if(!hdmi_ctx.strAudio.bEnc)
		{
			out_mask |= HDMI_AUD_GetChannelMask(hdmi_ctx.strAudio.ca);
		}
		// Encoded data can be whether through 1 I2S channel or through HBRA;
		// it cannot be through multiple I2S channels in non-HBRA mode.
	};
	HDMI_HAL_RegWrite(RX_I2S_CTRL2, out_mask);

	// enable SPDIF if allowed
	HDMI_HAL_RegWrite(RX_AUDRX_CTRL, reg_pass_spdif_err | reg_i2s_mode |	(hdmi_ctx.strAudio.soft_mute ? reg_hw_mute_en : 0) | (HDMI_AUD_IsSpdifOutEnable() ? reg_spdif_en : 0));
}


void HDMI_AUD_Update(void)
{
    if((as_AudioOn == hdmi_ctx.strAudio.eAudioState) || (as_AudioReady== hdmi_ctx.strAudio.eAudioState))
	{
		HDMI_AUD_SetOut();
		HDMI_AUD_SetMclk(); // couldn't it make audio restart if MCLK changed?
	}
}

HI_BOOL HDMI_AUD_IsAvMute(void)
{
    HI_U32 u32Value;

    u32Value = HDMI_HAL_RegRead(RX_AUDP_STAT);
    if ((u32Value &(hdmi_mode_det | hdmi_mute)) == hdmi_mute) {
        return HI_TRUE;
    }
    else {
        return HI_FALSE;
    }
}


#if SUPPORT_AAC
static void HDMI_AUD_ExceptionsOnOff(HI_BOOL bOnOff)
{
	if(bOnOff)
	{
		// Clear AAC Done interrupt which might be raised by previous events.
		// If the conditions for AAC Done still exist, the interrupt bit
		// will be set when the exceptions are turned on.
		HDMI_HAL_RegWrite(RX_INTR5, intr_audio_muted);

	//	/*libo@201404*/		HDMI_HAL_RegWrite(AEC0_CTRL, reg_aac_en|reg_aac_all);
	}
	else
	{
		HDMI_HAL_RegWrite(AEC0_CTRL, 0);

		// Clear AAC Done bit to not generate extra interrupts.
		HDMI_HAL_RegWrite(RX_INTR5, intr_audio_muted);
	}
	hdmi_ctx.strAudio.bExceptionsEn = bOnOff;
}
#endif
static void HDMI_AUD_OnOff(HI_BOOL bOnOff)
{

	if(bOnOff)
	{
		if(!hdmi_ctx.strAudio.bAudioIsOn) // reduce extra log prints
		{
			hdmi_ctx.strAudio.bAudioIsOn = HI_TRUE;
		}
        #if SUPPORT_AAC
		HDMI_AUD_ExceptionsOnOff(HI_TRUE);
        #endif
		HDMI_HAL_RegWriteFldAlign(RX_AUDP_MUTE, reg_audio_mute, HI_FALSE);
	}
	else
	{
		if(hdmi_ctx.strAudio.bAudioIsOn) // reduce extra log prints
		{
			hdmi_ctx.strAudio.bAudioIsOn = HI_FALSE;
		}
		HDMI_HAL_RegWriteFldAlign(RX_AUDP_MUTE, reg_audio_mute, HI_TRUE);

		// disable I2S output, but keep MCLKenable, SPDIF is on with flat output
		HDMI_HAL_RegWrite(RX_AUDRX_CTRL, reg_pass_spdif_err | reg_i2s_mode | 0);
	}
    #if SUPPORT_AAC
	HDMI_ISR_AacDoneIntOnOff(bOnOff);
    #endif
}

static void HDMI_AUD_Start(void)
{
    hdmi_ctx.strAudio.bStartReq = HI_TRUE;
}


void HDMI_AUD_UpdateOnAcp(hdmi_acp_type enAcpType)
{
    HI_BOOL bProctect = HI_FALSE;
    
    if(enAcpType != acp_GeneralAudio) {
        bProctect = HI_TRUE;
    }
    if (hdmi_ctx.strAudio.bProtected != bProctect) {
        hdmi_ctx.strAudio.bProtected = bProctect;
        if ((hdmi_ctx.strAudio.eAudioState == as_AudioOn) ||(hdmi_ctx.strAudio.eAudioState == as_AudioReady)) {
           HDMI_HAL_RegWriteFldAlign(RX_AUDRX_CTRL, reg_spdif_en, HDMI_AUD_IsSpdifOutEnable()); 
        }
    }

}

 //-------------------------------------------------------------------------------------------------
void HDMI_AUD_OnAudioInfoFrame(HI_U32 *p_data, HI_U32 length)
{
    HI_INFO_HDMIRX("HDMI_AUD_OnAudioInfoFrame \n");
    HI_INFO_HDMIRX("length = %d \n", length);
    
    if(p_data && (length>=5))
	{
		hdmi_ctx.strAudio.bAudioInfoFrameReceived = HI_TRUE;
		hdmi_ctx.strAudio.ca = p_data[3];
	}
	else
	{
		hdmi_ctx.strAudio.bAudioInfoFrameReceived = HI_FALSE;
	}

	if(hdmi_ctx.strAudio.bAudioInfoFrameReceived)
	{
		// update() function has to be called
		// since channel allocation (CA) field my be changed
		//HI_INFO_HDMIRX("%s \n",__FUNCTION__);
		HDMI_AUD_Update();
	}
}

void HDMI_AUD_ResetAudInfoFrameData(void)
{
    HI_INFO_HDMIRX("HDMI_AUD_ResetAudInfoFrameData \n");
    HDMI_AUD_OnAudioInfoFrame(NULL, 0);
    HDMI_ISR_ReceiveAudioInfoFrameOnEveryPacketOnOff(HI_TRUE);
}

#if SUPPORT_AAC
void HDMI_AUD_AacDone(void)
{
    if(hdmi_ctx.strAudio.bExceptionsEn)
	{
		HDMI_AUD_ResetAudInfoFrameData();
		HDMI_AUD_ExceptionsOnOff(HI_FALSE);
	}

	HDMI_AUD_OnOff(HI_FALSE);
	HDMI_HAL_RegSetBits(RX_I2S_CTRL2, reg_sd3_en|reg_sd2_en|reg_sd1_en|reg_sd0_en|reg_mclk_en, HI_FALSE);

	HDMI_AUD_ChangeState(as_AudioOff, 1);
    HI_INFO_HDMIRX("AS-- chang to 'AudioOff' because of aac mute\n ");
}
#endif

void HDMI_AUD_Stop(HI_BOOL immediately)
{
    if(hdmi_ctx.strAudio.soft_mute && (!immediately))
	{
		HDMI_HAL_RegWriteFldAlign(RX_AUDP_MUTE, reg_audio_mute, HI_TRUE);

		// set a timeout for switching to the Audio Off mode
		//change_audio_state(as_AudioOff, 200);
		HDMI_AUD_ChangeState(as_AudioOff, 30);
        HI_INFO_HDMIRX("AS-- change to 'AudioOff' because of audio stop\n ");
	}
    #if SUPPORT_AAC
	else
	{
		HDMI_AUD_AacDone();
        //HI_INFO_HDMIRX("HDMI_AUD_AacDone ... 3 \n");
	}
    #endif
	hdmi_ctx.strAudio.bStartReq = HI_FALSE;
}



void HDMI_AUD_StreamTypeChanged(void)
{
//	DEBUG_PRINT(MSG_DBG_RX | MSG_PIPE, ("Audio stream changed\n"));
    //HI_INFO_HDMIRX("HDMI_AUD_Stop-- %s \n", __FUNCTION__);
	HDMI_AUD_Stop(HI_TRUE);
	HDMI_AUD_Start();
}

void HDMI_AUD_AssertOff(void)
{
    if(as_AudioOff != hdmi_ctx.strAudio.eAudioState)
	{
        //HI_INFO_HDMIRX("HDMI_AUD_Stop-- %s \n", __FUNCTION__);
        HDMI_AUD_Stop(HI_TRUE);
	}
}

void HDMI_AUD_Restart(void)
{
    if (hdmi_ctx.strAudio.bStartReq) {
        HDMI_AUD_Stop(HI_TRUE);
        //HI_INFO_HDMIRX("HDMI_AUD_Stop-- %s \n", __FUNCTION__);
    }
    HDMI_AUD_Start();
}

void HDMI_AUD_UpdateFs(void)
{  
    HI_INFO_HDMIRX("%s \n",__FUNCTION__);
    HDMI_AUD_Update();
}

static void HDMI_AUD_ClearAllInt(void)
{
    HDMI_HAL_RegWriteFldAlign(RX_INTR2, intr_got_cts, HI_TRUE);
    HDMI_HAL_RegWriteFldAlign(RX_INTR2, intr_new_aud_pkt, HI_TRUE);
    
    HDMI_HAL_RegWriteFldAlign(RX_INTR4, intr_underun, HI_TRUE);
    HDMI_HAL_RegWriteFldAlign(RX_INTR4, intr_overun, HI_TRUE);
    HDMI_HAL_RegWriteFldAlign(RX_INTR4, intr_cts_reused_err, HI_TRUE);
    
    HDMI_HAL_RegWriteFldAlign(RX_INTR5, intr_audio_muted, HI_TRUE);
    HDMI_HAL_RegWriteFldAlign(RX_INTR5, reg_audio_link_err, HI_TRUE);
    HDMI_HAL_RegWriteFldAlign(RX_INTR5, reg_fn_chg, HI_TRUE);
    HDMI_HAL_RegWriteFldAlign(RX_INTR5, intr_aud_sample_f, HI_TRUE);

}

void HDMI_AUD_PowerOnRegInit(void)
{
//    HI_U32 intStatus[3] = { 0xFF, 0xFF, 0xFF };
    //HDMI_HAL_I2sEdgeSel(HI_TRUE);
    HDMI_HAL_RegSetBits(RX_I2S_CTRL1, reg_clk_edge, HI_TRUE);   
    HDMI_HAL_RegWrite(RX_APLL_POLE, 0x88);  //set pll config #1
    HDMI_HAL_RegWrite(RX_APLL_CLIP, 0x16);  //set pll config #2

#if 0 /*--NO MODIFY : COMMENT BY CODINGPARTNER--*/
    HDMI_AUD_ClearAllInt();
#endif /*--NO MODIFY : COMMENT BY CODINGPARTNER--*/	/*libo@201404*/	
    
    HDMI_HAL_RegSetBits(RX_AEC_EN1, BIT_CKDT_DETECT|BIT_SYNC_DETECT|BIT_CABLE_UNPLUG, HI_TRUE);
    HDMI_HAL_RegSetBits(RX_AEC_EN2, BIT_H_RES_CHANGED|BIT_FS_CHANGED|BIT_AUDIO_FIFO_OVERRUN|BIT_AUDIO_FIFO_UNDERUN|BIT_HDMI_MODE_CHANGED, HI_TRUE);
    HDMI_HAL_RegSetBits(RX_AEC_EN3, BIT_V_RES_CHANGED, HI_TRUE);
    
    HDMI_HAL_RegSetBits(AEC3_CTRL, AAC_UNMUTE_NEW_AUDIO|AAC_UNMUTE_CTS, HI_TRUE);
    HDMI_HAL_RegSetBits(AEC2_CTRL, AAC_UNMUTE_GOT_FIFO_OVER|AAC_UNMUTE_GOT_FIFO_UNDER|AAC_UNMUTE_GOT_HDMI, HI_TRUE);
    HDMI_HAL_RegWrite(AEC1_CTRL, 0x17);

    //HDMI_HAL_RegWrite(RX_I2S_CTRL1, reg_clk_edge);
   

    HDMI_HAL_RegWriteFldAlign(AAC_MCLK_SEL, reg_vcnt_max, 3);   //add for unmute timing    
    HDMI_HAL_RegSetBits(RX_AUDRX_CTRL, reg_spdif_en|reg_i2s_mode|reg_pass_aud_err|reg_pass_spdif_err|reg_hw_mute_en, HI_TRUE);
    HDMI_HAL_RegSetBits(RX_I2S_CTRL2, reg_sd3_en|reg_sd2_en|reg_sd1_en|reg_sd0_en|reg_mclk_en|reg_pcm, HI_TRUE);    //enable MCLK  
    HDMI_HAL_RegWriteFldAlign(RX_AUDP_MUTE, reg_audio_mute, HI_FALSE);
    
    HDMI_HAL_RegSetBits(AEC0_CTRL, reg_aac_en|reg_aac_all|reg_aac_out_off_en|reg_ctrl_acr_en, HI_TRUE); 

    HDMI_HAL_RegWriteFldAlign(RX_TCLK_FS, reg_fs_filter_en, HI_TRUE);  // EDA
    HDMI_HAL_RegWrite(RX_I2S_MAP, 0x78); // EDA
    HDMI_HAL_RegWriteFldAlign(RX_I2S_CTRL1, reg_ws, HI_TRUE); // EDA
    //HDMI_HAL_RegWriteFldAlign(RX_I2S_CTRL1, reg_data_dir, HI_TRUE); // EDA
}

/* 
------------------------------------------------------------------------------
    Function:    HDMI_AUD_Init
    Description: initial audio reg setting and struct if HDMI_STATE_INIT.
    Parameters:  none
    Returns:     none
    NOTE: 1. initial audio struct to zero
          2. enable i2s setting
          3. aec setting
          4. clear flag of infopacket receiving, and enable int of every audio packet
-----------------------------------------------------------------------------
*/
void HDMI_AUD_Init(void)
{
    memset(&hdmi_ctx.strAudio, 0, sizeof(hdmi_audio_type));
    HI_INFO_HDMIRX("AS-- chang to 'AudioOff' because of audio init \n ");
    hdmi_ctx.strAudio.fs = AUDIO_CHST4__FS_UNKNOWN;     // means "not indicated", default values for 48kHz audio will be used.
    hdmi_ctx.strAudio.soft_mute = HI_TRUE;
    //HDMI_HAL_RegWriteFldAlign(RX_SW_OW, reg_dsd_on_i2s, HI_FALSE);
    // default audio settings (set to I2S)
    HDMI_HAL_RegWriteFldAlign(RX_I2S_CTRL1, reg_clk_edge, HI_TRUE);
    // Audio PLL setting
    HDMI_HAL_RegWrite(RX_APLL_POLE, 0x88);  //set pll config #1
    HDMI_HAL_RegWrite(RX_APLL_CLIP, 0x16);  //set pll config #2
    // allow SPDIF clocking even if audio is not coming out
    HDMI_HAL_RegWrite(RX_AUDRX_CTRL, reg_i2s_mode);
    // init AEC registers
    HDMI_HAL_RegWriteBlock(RX_AEC_EN1,default_aec_regs, 3);

    HDMI_AUD_ResetAudInfoFrameData();
    
#if 0 /*--NO MODIFY : COMMENT BY CODINGPARTNER--*/
	//hdmi_ctx.strRxInt.au32ShadowIntMask[INTR4] |= intr_underun | intr_overun | intr_cts_reused_err |intr_cts_dropped_err ;
	HDMI_HAL_RegWrite(RX_INTR4_MASK, hdmi_ctx.strRxInt.au32ShadowIntMask[INTR4]);
#endif /*--NO MODIFY : COMMENT BY CODINGPARTNER--*/
	/*libo@201404*/	



    hdmi_ctx.strAudio.u32Timer = 1;
}

void HDMI_AUD_OnChannelStatusChg(void)
{
    //HI_U8 i;
    HDMI_HAL_RegReadBlock(RX_CHST1, hdmi_ctx.strAudio.au32ChannelSta,3);
    if (hdmi_ctx.strAudio.bDsdMode) {
        hdmi_ctx.strAudio.bEnc = HI_FALSE;
    }
    else {
        hdmi_ctx.strAudio.bEnc = (hdmi_ctx.strAudio.bHbrMode ? HI_TRUE : (0 != (hdmi_ctx.strAudio.au32ChannelSta[0] & AUDIO_CHST1__ENCODED)));
    }
    HDMI_HAL_RegReadBlock(RX_CHST4, &hdmi_ctx.strAudio.au32ChannelSta[3], 2);

    // Fs data read from RX_CHST4 may be not the actual value coming
	// from HDMI input, but the Fs written into RX_FREQ_SVAL.
	// To have real Fs value, get it from RX_TCLK_FS register
	// and replace in the audio status channel byte 4.
	hdmi_ctx.strAudio.au32ChannelSta[3] &= ~CHST4_SAMPLE_F;
	hdmi_ctx.strAudio.fs= (HDMI_HAL_RegRead(RX_TCLK_FS) & rhdmi_aud_sample_f); // HW measured Fs
    //HI_INFO_HDMIRX("MeasuredFs = %d \n", hdmi_ctx.strAudio.u32MeasuredFs);
    //HI_INFO_HDMIRX("Fs = %d \n", hdmi_ctx.strAudio.fs);
    if(AUDIO_CHST4__FS_UNKNOWN != hdmi_ctx.strAudio.u32MeasuredFs)
	{
		// replace with FW measured values
		hdmi_ctx.strAudio.au32ChannelSta[3] |= hdmi_ctx.strAudio.u32MeasuredFs;
	}
	else
	{
		// replace with HW measured values
		hdmi_ctx.strAudio.au32ChannelSta[3] |= hdmi_ctx.strAudio.fs;
	}

    // Note: DSD does not have Audio Status Channel, so all bytes in the Audio
	// Status Channel registers are zeros.
	// That should not cause problems because the DSD format is fixed.

    hdmi_ctx.strAudio.blayout1 = (HI_BOOL)HDMI_HAL_RegReadFldAlign(RX_AUDP_STAT, hdmi_layout);

	hdmi_ctx.strAudio.bStatusReceived = HI_TRUE;
    //HI_INFO_HDMIRX("%s \n",__FUNCTION__);
    #if 0
    for(i=0; i<5; i++) {
    //HI_INFO_HDMIRX("d[%d]= 0x%x \n",i,d[i]);
    HI_INFO_HDMIRX("au32ChannelSta[%d]= 0x%x \n",i,hdmi_ctx.strAudio.au32ChannelSta[i]);
    }
    #endif
    HDMI_AUD_Update();
}



static void HDMI_AUD_Refresh(void)
{
	HI_U32 u32Stat = HDMI_HAL_RegRead(RX_AUDP_STAT);

	if((u32Stat & 0x90) || (0x60 == (u32Stat & 0x60)))
	{
		// It happens when a source sends encrypted data
		// before authentication
		// (or forgets disabling HDCP encryption after a break
		// in video clock).

		
		// 080110
		// No reason to continue- audio data is broken
	}
	else
	{
		// RX_A__AUDP_STAT looks correct
        
		if(u32Stat & hdmi_aud_dsd_on)
		{
			// DSD (One Bit) Audio
			//HI_INFO_HDMIRX("hdmi_ctx.strAudio.bDsdMode ???????????????????????????????????????????????\n");
			hdmi_ctx.strAudio.bDsdMode= HI_TRUE;
			hdmi_ctx.strAudio.bHbrMode= HI_FALSE;
			hdmi_ctx.strAudio.bEnc= HI_FALSE; // no support for DST (encoded DSD)
		}
		else if(u32Stat & hdmi_hbra_on)
		{
			// HBR Audio
			hdmi_ctx.strAudio.bDsdMode = HI_FALSE;
			hdmi_ctx.strAudio.bHbrMode = HI_TRUE;
			hdmi_ctx.strAudio.bEnc = HI_TRUE;
		}
		else
		{
			hdmi_ctx.strAudio.bDsdMode = HI_FALSE;
			hdmi_ctx.strAudio.bHbrMode = HI_FALSE;
			// audio_vars[pipe].encoded is set by a bit from the audio status in RxAudio_OnChannelStatusChange()
		}

	}
}

static HI_BOOL HDMI_AUD_IsAudioPacketGot(void)
{
    HI_BOOL bFlag;
    
    //HI_INFO_HDMIRX("RX_INTR2 =  0x%x \n", HDMI_HAL_RegRead(RX_INTR2));
#if 0 /*--NO MODIFY : COMMENT BY CODINGPARTNER--*/
    bFlag = (HI_BOOL)HDMI_HAL_RegReadFldAlign(RX_INTR2, intr_new_aud_pkt);
#endif /*--NO MODIFY : COMMENT BY CODINGPARTNER--*/	/*libo@201404*/	
    bFlag =  hdmi_ctx.strRxInt.u32Int[INTR2] & intr_new_aud_pkt; 
    return bFlag;
}

static HI_BOOL HDMI_AUD_IsCtsGot(void)
{
#if 0 /*--NO MODIFY : COMMENT BY CODINGPARTNER--*/
    return (0 != HDMI_HAL_RegReadFldAlign(RX_INTR2, intr_got_cts));
#endif /*--NO MODIFY : COMMENT BY CODINGPARTNER--*/	/*libo@201404*/	
return (0 != (hdmi_ctx.strRxInt.u32Int[INTR2] & intr_got_cts));

}

static HI_BOOL HDMI_AUD_IsCtsInRange( void )
{
    HI_U32 tmds_clk_100Hz = HDMI_AUD_GetTmdsClk_10k() * 100;
    HI_U32 cts = HDMI_AUD_GetCts();

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
   // HI_INFO_HDMIRX("tmds_clk_100Hz = %d \n", tmds_clk_100Hz);
    //HI_INFO_HDMIRX("cts = 0x%x \n", cts);
    return (tmds_clk_100Hz <= (cts<<4)) && (tmds_clk_100Hz >= (cts<<1));
}

static HI_BOOL HDMI_AUD_IsClockStable(void)
{
    // if there are CTS dropped or reused interrupts, then clock is not stable,
	// if there are no interrupt, the clock is stable
#if 0 /*--NO MODIFY : COMMENT BY CODINGPARTNER--*/
	return (0 == (HDMI_HAL_RegRead(RX_INTR4) & (intr_cts_reused_err | intr_cts_dropped_err)));
#endif /*--NO MODIFY : COMMENT BY CODINGPARTNER--*/	/*libo@201404*/	
    return (0 == (hdmi_ctx.strRxInt.u32Int[INTR4] & (intr_cts_reused_err | intr_cts_dropped_err)));
}

static HI_BOOL HDMI_AUD_IsCtsError(void)
{
    HI_BOOL bErr = HI_FALSE;

    if (!HDMI_AUD_IsAudioPacketGot()) {
        bErr = HI_TRUE;
        hdmi_ctx.strAudio.u32Error |= AUDIO_ERR__NO_AUDIO_PACKETS;
        //return bErr;
    }
    else if (!HDMI_AUD_IsCtsGot()) {
        bErr = HI_TRUE;
        hdmi_ctx.strAudio.u32Error |= AUDIO_ERR__NO_CTS_PACKETS;
        //return bErr;
    }
    else if (!HDMI_AUD_IsCtsInRange()) {
        bErr = HI_TRUE;
        hdmi_ctx.strAudio.u32Error |= AUDIO_ERR__CTS_OUT_OF_RANGE;
        //return bErr;
    }
    else if (!HDMI_AUD_IsClockStable()) {
        bErr = HI_TRUE;
        hdmi_ctx.strAudio.u32Error |= AUDIO_ERR__CTS_IRREGULAR;
        //return bErr;
    }
    HI_INFO_HDMIRX("err = 0x%x \n", hdmi_ctx.strAudio.u32Error);
    return bErr;
}

// wait until FIFO underrun and overrun are gone
static HI_BOOL HDMI_AUD_IsFifoStable(void)
{
	HI_U32 timeout = 10;
	mdelay(1);
	do
	{
		// reset audio FIFO
		HDMI_HAL_RegWriteFldAlign(RX_PWD_SRST, fifo_rst, HI_TRUE);
        HDMI_HAL_RegWriteFldAlign(RX_PWD_SRST, fifo_rst, HI_FALSE);
		// clear FIFO underrun and overrun interrupts
		HDMI_HAL_RegWriteFldAlign(RX_INTR4, intr_overun, HI_TRUE);
        HDMI_HAL_RegWriteFldAlign(RX_INTR4, intr_underun, HI_TRUE);
		mdelay(2);;

		// check whether the interrupt has raised
		if(0 == (HDMI_HAL_RegRead(RX_INTR4) & (intr_underun | intr_overun))) {
			break; // success
		}
	} while(--timeout);
    
	return (0 != timeout);
}

static HI_BOOL HDMI_AUD_IsStatusChanged(void)
{

	HI_U32 d[5];
   // HI_U32 i=0;
	HDMI_HAL_RegReadBlock(RX_CHST1, d, 3);
	HDMI_HAL_RegReadBlock(RX_CHST4, &d[3], 2);
	d[3] &= ~CHST4_SAMPLE_F;

	if(AUDIO_CHST4__FS_UNKNOWN != hdmi_ctx.strAudio.u32MeasuredFs)
	{
		// replace with FW measured values
		d[3] |= hdmi_ctx.strAudio.u32MeasuredFs;
	}
	else
	{
		// replace with HW measured values
		//d[3] |= audio_vars[pipe].fs;
		d[3] |= HDMI_HAL_RegReadFldAlign(RX_TCLK_FS, rhdmi_aud_sample_f); // replace with HW measured values
	}
    #if 0
    for(i=0; i<5; i++) {
    HI_INFO_HDMIRX("d[%d]= 0x%x \n",i,d[i]);
    HI_INFO_HDMIRX("hdmi_ctx.strAudio.au32ChannelSta[%d]= 0x%x \n",i,hdmi_ctx.strAudio.au32ChannelSta[i]);
    }
    #endif
	return (memcmp(d, hdmi_ctx.strAudio.au32ChannelSta, sizeof(hdmi_ctx.strAudio.au32ChannelSta)));

}

static void HDMI_AUD_AcrProcess(void)
{

    HDMI_HAL_RegWriteFldAlign(RX_ECC_CTRL, reg_capture_cnt, HI_TRUE);
    HDMI_HAL_RegWriteFldAlign(RX_INTR1, intr_hw_cts_changed, HI_TRUE);
    
    HDMI_HAL_RegWriteFldAlign(RX_INTR4, intr_cts_dropped_err, HI_TRUE);
    HDMI_HAL_RegWriteFldAlign(RX_INTR4, intr_cts_reused_err, HI_TRUE);
    #if 0
    HDMI_HAL_RegWriteFldAlign(RX_INTR2, intr_got_cts, HI_TRUE);
    HDMI_HAL_RegWriteFldAlign(RX_INTR2, intr_new_aud_pkt, HI_TRUE);
    #endif
    //mdelay(2);
    if (HDMI_AUD_IsCtsError()) {
        //audio errors still present
        HDMI_HAL_RegWriteFldAlign(RX_INTR1, intr_hw_cts_changed, HI_TRUE);
        
        HDMI_HAL_RegWriteFldAlign(RX_PWD_SRST, acr_rst, HI_TRUE);
        HDMI_HAL_RegWriteFldAlign(RX_PWD_SRST, acr_rst, HI_FALSE);
        // schedule next check
        HDMI_AUD_ChangeState(as_ReqAudio, 3);
        HI_INFO_HDMIRX("AS-- chang to 'ReqAudio' because of cts error \n ");
    }
    else {
        // no errors, prepare for the next step
        // the bit will be cleared automatically
        HDMI_HAL_RegWriteFldAlign(RX_ACR_CTRL1, reg_acr_init, HI_TRUE);
        
        HDMI_AUD_Refresh();
        HDMI_AUD_SetMclk();
        HDMI_AUD_ChangeState(as_AudioReady, 3);
        HI_INFO_HDMIRX("AS-- change to 'AudioReady' because of the cts ok \n");
    }
    
#if 1
    HDMI_HAL_RegWriteFldAlign(RX_INTR2, intr_got_cts, HI_TRUE);
    HDMI_HAL_RegWriteFldAlign(RX_INTR2, intr_new_aud_pkt, HI_TRUE);
#endif
}


void HDMI_AUD_MainLoop(void)
{
    if (hdmi_ctx.Timer[HDMI_TIMER_IDX_AUDIO] < hdmi_ctx.strAudio.u32Timer) {
        return;
    }
    else {
        hdmi_ctx.Timer[HDMI_TIMER_IDX_AUDIO] = 0;
    }
   // HI_INFO_HDMIRX("RX_INTR2 = 0x%x,%d \n", HDMI_HAL_RegRead(RX_INTR2),hdmi_ctx.strAudio.eAudioState);
    switch (hdmi_ctx.strAudio.eAudioState) {
        case as_AudioOff:
            //HI_INFO_HDMIRX("as_AudioOff \n");
            if (hdmi_ctx.strAudio.bStatusReceived) {
                hdmi_ctx.strAudio.bStatusReceived = HI_FALSE;
            }
            #if SUPPORT_AAC
            if (hdmi_ctx.strAudio.bExceptionsEn) {
                HDMI_AUD_AacDone();
                break;
            }
            #endif
            if (hdmi_ctx.strAudio.bStartReq) {
                 #if SUPPORT_AAC
                 HDMI_HAL_RegWriteFldAlign(RX_PWD_SRST, aac_rst, HI_TRUE);
                 HDMI_HAL_RegWriteFldAlign(RX_PWD_SRST, aac_rst, HI_FALSE);
                 #endif
                 HDMI_AUD_ChangeState(as_ReqAudio, 1);
                 HI_INFO_HDMIRX("AS- change to 'ReqAudio' because of start require audio\n");
                 hdmi_ctx.strAudio.u32Error = 0;
                 HDMI_INFO_ResetAudInfoFrameData();
                 hdmi_ctx.strAudio.u32MeasuredFs = AUDIO_CHST4__FS_UNKNOWN;

                 
            }
            else {
                HDMI_AUD_ChangeState(as_AudioOff, 3);
                HI_INFO_HDMIRX("AS- chang to 'AudioOff' because of no requirement \n ");
            }
            
            break;
        case as_ReqAudio:
            //HI_INFO_HDMIRX("as_ReqAudio \n");
            if (hdmi_ctx.strAudio.bStatusReceived) {
                hdmi_ctx.strAudio.bStatusReceived = HI_FALSE;
            }
            HDMI_AUD_AcrProcess();
            break;
        case as_AudioReady:
#if 0 /*--NO MODIFY : COMMENT BY CODINGPARTNER--*/
             //HI_INFO_HDMIRX("AudioReady \n");
            if (!HDMI_AUD_IsClockStable() || (!HDMI_AUD_IsFifoStable())) 
#endif /*--NO MODIFY : COMMENT BY CODINGPARTNER--*///	/*libo@201404*/	
                if (!HDMI_AUD_IsClockStable()) 
                {
                HDMI_AUD_ChangeState(as_ReqAudio, 1);
                HI_INFO_HDMIRX("AS change to 'ReqAudio' because of fifo error \n");
            }
            else {
                hdmi_ctx.strAudio.bEnc = HI_TRUE;
                hdmi_ctx.strAudio.au32ChannelSta[0] = 0x03;
                HDMI_AUD_OnOff(HI_TRUE);//	/*libo@201404*/	
                HDMI_AUD_ChangeState(as_AudioOn, 20);
                HI_INFO_HDMIRX("AS change to 'AudioOn' because of fifo ok\n");
            }

            break;
        case as_AudioOn:
            #if SUPPORT_AAC
            if (HDMI_AUD_IsStatusChanged()) {
                HI_INFO_HDMIRX("channel status change \n");
                HDMI_AUD_OnChannelStatusChg();
            }
            //else {
              //  HI_INFO_HDMIRX("channel status do not change \n");
           // }
            #else 
                if ((hdmi_ctx.strRxInt.u32Int[INTR4] & intr_overun) ||( hdmi_ctx.strRxInt.u32Int[INTR4] & intr_underun)) 
                {
                HDMI_HAL_RegWriteFldAlign(RX_PWD_SRST, fifo_rst, HI_TRUE);
                udelay(40);
                HDMI_HAL_RegWriteFldAlign(RX_PWD_SRST, fifo_rst, HI_FALSE);
                HI_INFO_HDMIRX("hdmi fifo reset \n");
                HDMI_HAL_RegWriteFldAlign(RX_INTR4, intr_overun, HI_TRUE);
                //HI_INFO_HDMIRX("fifo o=%d \n", HDMI_HAL_RegReadFldAlign(RX_INTR4, intr_overun));
                HDMI_HAL_RegWriteFldAlign(RX_INTR4, intr_underun, HI_TRUE);
                //HI_INFO_HDMIRX("fifo u=%d \n", HDMI_HAL_RegReadFldAlign(RX_INTR4, intr_underun));
;            }
            #endif
            HDMI_AUD_ChangeState(as_AudioOn, 10);
            //HI_INFO_HDMIRX("AS change to AudioOn ...2\n");
            break;
        default:
            break;
    }
}

void HDMI_DB_ShowAudioInfo(struct seq_file *s)
{
    hdmi_audio_type *pstAudioCtx;
 
    pstAudioCtx = & hdmi_ctx.strAudio;
    PROC_PRINT(s, "\n---------------HDMIRX Audio---------------\n");
    switch(pstAudioCtx->eAudioState)
    {
        case as_AudioOff:
            PROC_PRINT(s,"AudioState           :   OFF\n"); 
            break;
        case as_ReqAudio:
            PROC_PRINT(s,"AudioState           :   REQ\n"); 
            break;
        case as_AudioReady:
            PROC_PRINT(s,"AudioState           :   READY\n"); 
            break;
        case as_AudioOn:
            PROC_PRINT(s,"AudioState           :   ON\n"); 
            break;
        default:
            PROC_PRINT(s,"AudioState           :   ERRO\n"); 
            break;
    }

    PROC_PRINT(s,"StatusReceived       :   %s\n",pstAudioCtx->bStatusReceived? "Yes":"No");
    PROC_PRINT(s,"Streams              :   %s\n",pstAudioCtx->bEnc? "Encoded":"PCM");
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
            PROC_PRINT(s,"AudioDataFormat      :   LPCM\n");
        }
        else
        {
            PROC_PRINT(s,"AudioDataFormat      :   LBR\n");       
        }
    }
        
    
     PROC_PRINT(s,"layout               :   %s\n",pstAudioCtx->blayout1? "Yes":"No");
    PROC_PRINT(s,"AudioIsOn            :   %s\n",pstAudioCtx->bAudioIsOn? "Yes":"No");
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

hdmi_audio_state HDMIRX_AUDIO_Getstatus(HI_VOID)
{
    return hdmi_ctx.strAudio.eAudioState;
}

hdmi_audio_type* HDMIRX_AUDIO_GetInfo(HI_VOID)
{

    return &hdmi_ctx.strAudio;
    
}




