#ifndef __DRV_HDMIRX_AUDIO_H__
#define __DRV_HDMIRX_AUDIO_H__

#include "drv_hdmirx.h"



#define TIMER



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

typedef enum
{
	as_AudioOff,
	as_WaitReqAudio, // not used
	as_ReqAudio,
	as_WaitForAudioPllLock, // not used
	as_AudioReady,
	as_AudioOn
}
hdmi_audio_state;


typedef enum
{
	acp_GeneralAudio = 0,
	acp_IEC60958 = 1,
	acp_DvdAudio = 2,
	acp_SuperAudioCD = 3
}hdmi_acp_type;


typedef struct
{
    
    hdmi_audio_state eAudioState;
    
	HI_U32		ca; // Channel Allocation field from Audio Info Fram
	HI_U32		fs; // sample frequency from the Audio Channel Status
	HI_BOOL	    bAudioInfoFrameReceived; // true if audio info frame has been received
	HI_BOOL	    bStatusReceived : 1; // true if channel status data is valid
	
	HI_U32		u32Error; // error bit mask
    HI_BOOL	    bEnc ; // false for PCM, true for encoded streams
	HI_BOOL	    bProtected ; // true for audio with protected context and with ACP packet
	
	HI_BOOL	    bDsdMode; // true for DSD mode
	HI_BOOL	    bHbrMode; // true for HBR Audio mode

    HI_BOOL	    bStartReq; // a flag to start audio processing
	HI_BOOL	    soft_mute; // true if soft mute is enabled
	HI_BOOL	    bNew_CntDn; // a request for a new count down in RxAudio_TimerHandler()
	HI_BOOL     blayout1; // true for layout 1; false for layout 0
	HI_U32      u16CntDn; // a countdown timer
	HI_U32		u32MeasuredFs; // calculated sample frequency in Channel Status's format
	HI_BOOL	    bExceptionsEn; // true if audio exceptions are on, false otherwise (shadow bit of 0x60.0xB5.0)
	HI_BOOL	    bAudioIsOn; // static variable used in switch_audio()
	HI_U32      au32ChannelSta[5]; // first 5 bytes of audio status channel
	HI_U32      u32Timer;
    
    //HDMIRX_AUDIO_CHANNEL_NUM_E enChannelNum;
	HI_U32  	u32FifoErrCnt;
    //bit_fld_t	muted : 1; // set if Audio Mute pin is asserted by FW, cleared otherwise
	
}
hdmi_audio_type;


void HDMI_AUD_Init(void);
void HDMI_AUD_Restart(void);
void HDMI_AUD_UpdateFs(void);
void HDMI_AUD_AacDone(void);
//void HDMI_VDO_SetDcMode(void);
void HDMI_AUD_AssertOff(void);
void HDMI_AUD_StreamTypeChanged(void);
void HDMI_AUD_OnChannelStatusChg(void);
void HDMI_VDO_DcReset(void);
void HDMI_VDO_HdmiDviTrans(void);
void HDMI_AUD_Stop(HI_BOOL immediately);
void HDMI_AUD_PowerOnRegInit(void);
void HDMI_AUD_UpdateOnAcp(hdmi_acp_type enAcpType);
HI_BOOL HDMI_AUD_IsAvMute(void);
void HDMI_AUD_OnAudioInfoFrame(HI_U32 *p_data, HI_U32 length);
void HDMI_AUD_MainLoop(void);
hdmi_audio_state HDMIRX_AUDIO_Getstatus(HI_VOID);
hdmi_audio_type* HDMIRX_AUDIO_GetInfo(HI_VOID);
void HDMI_DB_ShowAudioInfo(struct seq_file *s);


#endif
