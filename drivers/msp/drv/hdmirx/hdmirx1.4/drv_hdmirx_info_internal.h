#ifndef __DRV_HDMIRX_INFO_INTERNAL_H__
#define __DRV_HDMIRX_INFO_INTERNAL_H__

#include "hal_hdmirx_reg.h"
#include "hal_hdmirx.h"
#include "drv_hdmirx.h"
#include "drv_hdmirx_isr.h"
#include "drv_hdmirx_audio.h"
#include "drv_hdmirx_video.h"


#define IF_BUFFER_LENGTH        31
#define	IF_HEADER_LENGTH		4
#define	IF_TITLE_INDEX			0
#define	IF_VERSION_INDEX		1
#define	IF_LENGTH_INDEX		    2
#define	IF_CHECKSUM_INDEX		3
#define	IF_DATA_INDEX			IF_HEADER_LENGTH

#define	IF_MIN_AVI_LENGTH       13 // the 861C standard defines the length as 13
#define	IF_MAX_AVI_LENGTH       15 // maximum allowed by the chip

#define	IF_MIN_AUDIO_LENGTH     10 // the 861C standard defines the length as 10
#define	IF_MAX_AUDIO_LENGTH     10 // maximum allowed by the chip

#define	IF_MIN_MPEG_LENGTH      10 // the 861C standard defines the length as 10
#define	IF_MAX_MPEG_LENGTH      27 // maximum allowed by the chip

#define	IF_MIN_SPD_LENGTH       25 // the 861C standard defines the length as 25
#define	IF_MAX_SPD_LENGTH       27 // maximum allowed by the chip

#define	IF_MIN_VSIF_LENGTH      4 // minimum length by HDMI 1.4
#define	IF_MAX_VSIF_LENGTH      27 // maximum allowed by the chip

#define ISRC1_TIMEOUT           (5000/MLOOP_TIME_UNIT)  // unit: 10ms
     
extern struct hdmistatus hdmi_ctx;

typedef enum
{
	NOT_HDMI_VSIF,			// VSIF packet is not HDMI VSIF
	NEW_EXTENDED_RESOLUTION, // VSIF packet carries Extended Resolution info: first detection
	OLD_EXTENDED_RESOLUTION, // VSIF packet carries Extended Resolution info: no change
	NEW_3D,					// VSIF packet with 3D info: first detection
	OLD_3D					// VSIF packet with 3D info: no change from last time
}
vsif_check_result;

typedef enum
{
	VSIF_SPD_INIT,
	VSIF_SPD_ANY_VSIF,
	VSIF_SPD_ANY_SPD,
	VSIF_SPD_DELAY,
} vsif_spd_state;

typedef enum
{
	HDMI_IF_AVI   = 0x82, //!< AVI InfoFrame
	HDMI_IF_SPD   = 0x83, //!< SPD InfoFrame
	HDMI_IF_AUDIO = 0x84, //!< Audio InfoFrame
	HDMI_IF_MPEG  = 0x85, //!< MPEG InfoFrame
	HDMI_IF_ISRC1 = 0x05, //!< ISRC1 InfoPacket
	HDMI_IF_ISRC2 = 0x06, //!< ISRC2 InfoPacket
	HDMI_IF_ACP   = 0x04, //!< ACP InfoPacket
	HDMI_IF_GC    = 0x03, //!< General Control InfoPacket
	HDMI_IF_GBD   = 0x0A, //!< GBD InfoPacket
	HDMI_IF_VSIF  = 0x81, //!< VSIF InfoFrame
}
InfoFramePacket;

typedef enum
{
	ISRC_ST_INIT,
	ISRC_ST_WAIT_ANY_ISRC1,
	ISRC_ST_WAIT_NEW_ISRC1,
	ISRC_ST_WAIT_ANY_ISRC2,
} isrc_states;

#endif