#ifndef __DRV_HDMIRX_AUDIO_INTERNAL_H__
#define __DRV_HDMIRX_AUDIO_INTERNAL_H__

#include "hal_hdmirx_reg.h"
#include "hal_hdmirx.h"
#include "drv_hdmirx.h"
#include "drv_hdmirx_isr.h"
#include "drv_hdmirx_info.h"

// Audio Channel Status byte 1
#define AUDIO_CHST1__ENCODED				0x02 // 0-PCM, 1- for other purposes

// Audio Channel Status byte 4
#define AUDIO_CHST4__FS_44					0x00 // Fs = 44.1 kHz
#define AUDIO_CHST4__FS_UNKNOWN				0x01 //
#define AUDIO_CHST4__FS_48					0x02 // Fs = 48 kHz
#define AUDIO_CHST4__FS_32					0x03 // Fs = 32 kHz
#define AUDIO_CHST4__FS_22					0x04 // Fs = 22.05 kHz
#define AUDIO_CHST4__FS_24					0x06 // Fs = 24 kHz
#define AUDIO_CHST4__FS_88					0x08 // Fs = 88.2 kHz
#define AUDIO_CHST4__FS_768					0x09 // Fs = 768 kHz (HBR Audio 4x192kHz)
#define AUDIO_CHST4__FS_96					0x0A // Fs = 96 kHz
#define AUDIO_CHST4__FS_176					0x0C // Fs = 176.4 kHz
#define AUDIO_CHST4__FS_192					0x0E // Fs = 192 kHz

#define AUDIO_FS_LIST_LENGTH                9
#define AUDIO_CHANNEL_MASK_TABLE_LENGTH     32

#define AUDIO_ERR__NO_AUDIO_PACKETS		0x01
#define AUDIO_ERR__NO_CTS_PACKETS		0x02
#define AUDIO_ERR__CTS_OUT_OF_RANGE		0x04
#define AUDIO_ERR__CTS_IRREGULAR		0x08
#define AUDIO_ERR__PLL_UNLOCKED			0x10
#define AUDIO_ERR__FIFO_UNSTABLE		0x20

typedef struct
{
	HI_U32		code_value; // corresponding audio status Fs code
	HI_U32	    ref_Fs; // reference Fs frequency in 100 Hz units
	HI_U32	    min_Fs; // minimum Fs frequency in 100 Hz units
	HI_U32	    max_Fs; // maximum Fs frequency in 100 Hz units
}audio_fs_search;

typedef enum
{
	RX_CFG_128FS = 0,
	RX_CFG_256FS = 1,
	RX_CFG_384FS = 2,
	RX_CFG_512FS = 3,
}
hdmi_Audio_Mclk;

extern struct hdmistatus hdmi_ctx;

#endif