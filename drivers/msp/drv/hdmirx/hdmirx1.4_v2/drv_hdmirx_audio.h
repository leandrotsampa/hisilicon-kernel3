/******************************************************************************

  Copyright (C), 2012-2050, Hisilicon Tech. Co., Ltd.

 ******************************************************************************
  File Name     : drv_hdmirx_audio.h
  Version       : Initial Draft
  Author        : Hisilicon multimedia software group
  Created       : 2014/01/16
  Description   : 
  History       :
  1.Date        : 2014/01/16
    Author      : t00202585
    Modification: Created file
******************************************************************************/

#ifndef __DRV_HDMIRX_AUDIO_H__
#define __DRV_HDMIRX_AUDIO_H__

#include "drv_hdmirx.h"
#include "drv_hdmirx_packet.h"

#define HDMIRX_AUDIO_GET_CTX()  (&s_stHdmirxAudioCtx)

#define AUDIO_CHANNEL_MASK_TABLE_LENGTH     32
#define AUDIO_FS_LIST_LENGTH                9

#define AUDIO_CHST1_ENCODED				    0x02 // 0-PCM, 1- for other purposes

#define AUDIO_CHST4_FS_44					0x00 // Fs = 44.1 kHz
#define AUDIO_CHST4_FS_UNKNOWN				0x01 //
#define AUDIO_CHST4_FS_48					0x02 // Fs = 48 kHz
#define AUDIO_CHST4_FS_32					0x03 // Fs = 32 kHz
#define AUDIO_CHST4_FS_22					0x04 // Fs = 22.05 kHz
#define AUDIO_CHST4_FS_24					0x06 // Fs = 24 kHz
#define AUDIO_CHST4_FS_88					0x08 // Fs = 88.2 kHz
#define AUDIO_CHST4_FS_768					0x09 // Fs = 768 kHz (HBR Audio 4x192kHz)
#define AUDIO_CHST4_FS_96					0x0A // Fs = 96 kHz
#define AUDIO_CHST4_FS_176					0x0C // Fs = 176.4 kHz
#define AUDIO_CHST4_FS_192					0x0E // Fs = 192 kHz

typedef enum hiHMDIRX_AUDIO_BIT_WIDTH_E
{
    RX_AUDIO_BIT_UNKNOWN1 = 0,
    RX_AUDIO_BIT_BIT16,
    RX_AUDIO_BIT_BIT18,
    RX_AUDIO_BIT_BIT19 = 4,
    RX_AUDIO_BIT_BIT20,
    RX_AUDIO_BIT_BIT17,
    RX_AUDIO_BIT_UNKNOWN2 = 8,
    RX_AUDIO_BIT_BIT20_1,
    RX_AUDIO_BIT_BIT22,
    RX_AUDIO_BIT_BIT23 = 12,
    RX_AUDIO_BIT_BIT24,
    RX_AUDIO_BIT_BIT21,
    RX_AUDIO_BIT_BUTT
}HMDIRX_AUDIO_BIT_WIDTH_E;

typedef enum hiHDMIRX_AUDIO_CHANNEL_NUM_E
{
    RX_AUDIO_UNKNOWN,
    RX_AUDIO_2CH,
    RX_AUDIO_3CH,
    RX_AUDIO_4CH,
    RX_AUDIO_5CH,
    RX_AUDIO_6CH,
    RX_AUDIO_7CH,
    RX_AUDIO_8CH,
    RX_AUDIO_CH_BUTT
}HDMIRX_AUDIO_CHANNEL_NUM_E;

typedef enum hiHDMIRX_AUDIO_MCLK_E
{
	RX_CFG_128FS = 0,
	RX_CFG_256FS = 1,
	RX_CFG_384FS = 2,
	RX_CFG_512FS = 3,
}HDMIRX_AUDIO_MCLK_E;

typedef struct hiAUDIO_FS_SEARCH_S
{
	HI_U32		u32Code; // corresponding audio status Fs code
	HI_U32	    u32RefFs;     // reference Fs frequency in 100 Hz units
	HI_U32	    u32MinFs;     // minimum Fs frequency in 100 Hz units
	HI_U32	    u32MaxFs;     // maximum Fs frequency in 100 Hz units
}AUDIO_FS_SEARCH_S;

typedef enum hiHDMIX_AUDIO_STATE_E
{
	AUDIO_STATE_OFF,
	AUDIO_STATE_REQ,
	AUDIO_STATE_READY,
	AUDIO_STATE_ON,
	AUDIO_STATE_BUTT
}HDMIX_AUDIO_STATE_E;

typedef struct hiHDMIRX_AUDIO_CONTEXT_S
{
    
    HDMIX_AUDIO_STATE_E enAudioState;
	HI_U32		u32Ca;                  // Channel Allocation field from Audio Info Fram
	HI_U32		u32Fs;                  // sample frequency from the Audio Channel Status
	HI_BOOL	    bStatusReceived;        // true if channel status data is valid
	
    HI_BOOL	    bEnc ;                  // false for PCM, true for encoded streams
	HI_BOOL	    bProtected ;            // true for audio with protected context and with ACP packet
	#if SUPPORT_DSD
	HI_BOOL	    bDsdMode;               // true for DSD mode
    #endif
	HI_BOOL	    bHbrMode;               // true for HBR Audio mode

    HI_BOOL	    bStartReq;              // a flag to start audio processing
	HI_BOOL	    bSoftMute;              // true if soft mute is enabled
	HI_BOOL     blayout1;               // true for layout 1; false for layout 0
	HI_U32		u32MeasuredFs;          // calculated sample frequency in Channel Status's format
	#if SUPPORT_AEC
	HI_BOOL	    bExceptionsEn;          // true if audio exceptions are on, false otherwise (shadow bit of 0x60.0xB5.0)
	#endif
	HI_BOOL	    bAudioIsOn;             // static variable used in switch_audio()
	HI_U32      au32ChannelSta[5];      // first 5 bytes of audio status channel
	HI_U32      u32TimeOut;
    //HDMIRX_AUDIO_CHANNEL_NUM_E enChannelNum;
	HI_U32  	u32FifoErrCnt;
}HDMIRX_AUDIO_CONTEXT_S;
HI_VOID HDMIRX_AUDIO_Initial(HI_VOID);
HI_VOID HDMIRX_AUDIO_AssertOff(HI_UNF_HDMIRX_PORT_E enPort);
HI_BOOL HDMIRX_AUDIO_IsRequest(HI_VOID);
HI_VOID HDMIRX_AUDIO_Restart(HI_UNF_HDMIRX_PORT_E enPort);
HI_VOID HDMIRX_AUDIO_Stop(HI_UNF_HDMIRX_PORT_E enPort);
HI_VOID HDMIRX_AUDIO_GetAudioInfo(HDMIRX_AUDIO_CONTEXT_S *AudioCtx);
HI_VOID HDMIRX_AUDIO_AacDone(HI_UNF_HDMIRX_PORT_E enPort);
HI_VOID HDMIRX_AUDIO_StreamTypeChanged(HI_UNF_HDMIRX_PORT_E enPort);
HI_VOID HDMIRX_AUDIO_OnChannelStatusChg(HI_UNF_HDMIRX_PORT_E enPort);
HI_VOID HDMIRX_AUDIO_SetCa(HI_U32 u32Ca);
HI_VOID HDMIRX_AUDIO_Update(HI_UNF_HDMIRX_PORT_E enPort);
HI_VOID HDMIRX_AUDIO_UpdateOnAcp(HI_UNF_HDMIRX_PORT_E enPort,HDMIRX_ACP_TYPE_E enType);
HI_VOID HDMIRX_AUDIO_MainLoop(HI_UNF_HDMIRX_PORT_E enPort);
HI_VOID HDMIRX_AUDIO_GetInfo(HI_UNF_AI_HDMI_ATTR_S *pstAudioInfo);
//HI_VOID HDMIRX_AUDIO_SetChannelNum(HDMIRX_AUDIO_CHANNEL_NUM_E enNum);
HI_VOID HDMIRX_AUDIO_ProcRead(struct seq_file *s, HI_VOID *data);
HDMIX_AUDIO_STATE_E HDMIRX_AUDIO_Getstatus(HI_VOID);
HI_U32 HDMIRX_AUDIO_GetTmdsClk_10k(HI_VOID);

#endif

