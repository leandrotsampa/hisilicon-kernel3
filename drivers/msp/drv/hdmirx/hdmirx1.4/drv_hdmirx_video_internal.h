#ifndef __DRV_HDMIRX_VIDEO_INTERNAL_H__
#define __DRV_HDMIRX_VIDEO_INTERNAL_H__

#include "hal_hdmirx.h"
#include "hal_hdmirx_reg.h"
#include "drv_hdmirx.h"
#include "drv_hdmirx_isr.h"
#include "drv_hdmirx_audio.h"
#include "drv_hdmirx_video.h"
#include "drv_hdmirx_sys.h"
#include "drv_hdmirx_info.h"

#define HDMI_XCLK                   5529600 // 2048*27MHz UNIT OF 10kHz

#define HDMI_3D_RESOLUTION_MASK   0x80
#define VIDEO_PATH_MASK 0x3F
#define PASS_REPLICATED_PIXELS_MASK	0x80	// if true- pixel clock is multiplied by pixel repeatition rate

#define NMB_OF_CEA861_VIDEO_MODES 43
#define NMB_OF_HDMI_VIDEO_MODES 4

//range limits to satisfy all 861D video modes
#define VIDEO_MIN_V_HZ			(22)
#define VIDEO_MAX_V_HZ			(243)
#define VIDEO_MIN_H_KHZ			(14)
#define VIDEO_MAX_H_KHZ			(134)
#define VIDEO_MAX_PIX_CLK_10MHZ	(30) // to support 300 MHz resolutions
#define VIDEO_MAX_TMDS_CLK_5MHZ	(300/5) // 300MHz

#define RX_DC_8BPP				0x00
#define RX_DC_10BPP				0x01
#define RX_DC_12BPP				0x02

#define	FPIX_TOLERANCE		200	// in 10 kHz units, i.e. 100 means +-1MHz
#define	PIXELS_TOLERANCE	30	// should be no more then 55 to distinguish all CEA861C modes
#define	LINES_TOLERANCE		15	// should be no more then 29 to distinguish all CEA861C modes
#define	H_FREQ_TOLERANCE	2	// H Freq tolerance in kHz, used for analog video detection

#define DC_CLK_8BPP_1X		0x00
#define DC_CLK_8BPP_2X		0x02
#define DC_CLK_10BPP_1X		0x04
#define DC_CLK_12BPP_1X		0x05
#define DC_CLK_10BPP_2X		0x06
#define DC_CLK_12BPP_2X		0x07

#define	RX_OUTPUT_DIV_BY_1 0x00
#define	RX_OUTPUT_DIV_BY_2 0x40
#define	RX_OUTPUT_DIV_BY_4 0xC0

#define	FH_TOLERANCE	1	// H freq in 1 kHz units, used for range check
#define	FV_TOLERANCE	2	// V Freq in 1 Hz units, used for range check

typedef enum
{
	Timing_1_640x480p = 0,			//0
	Timing_2_3_720x480p,
	Timing_4_69_1280x720p,	
	Timing_5_1920x1080i,				//3
	Timing_6_7_720_1440x480i,		//4
	Timing_8_9_720_1440x240p_1,		//5
	Timing_8_9_720_1440x240p_2,		//6
	Timing_10_11_2880x480i,			//7
	Timing_12_13_2880x240p_1,		//8
	Timing_12_13_2880x240p_2,		//9
	Timing_14_15_1440x480p,			//10
	Timing_16_76_1920x1080p,			//11
	Timing_17_18_720x576p,			//12
	Timing_19_68_1280x720p,			//13
	Timing_20_1920x1080i,			//14
	Timing_21_22_720_1440x576i,		//15
	Timing_23_24_720_1440x288p_1,	//16
	Timing_23_24_720_1440x288p_2,	//17
	Timing_23_24_720_1440x288p_3,	//18
	Timing_25_26_2880x576i,			//19
	Timing_27_28_2880x288p_1,		//20
	Timing_27_28_2880x288p_2,		//21
	Timing_27_28_2880x288p_3,		//22
	Timing_29_30_1440x576p,			//23
	Timing_31_75_1920x1080p,			//24
	Timing_32_72_1920x1080p,		//25
	Timing_33_73_1920x1080p,			//26
	Timing_34_74_1920x1080p,			//27
	Timing_35_36_2880x480p,			//28
	Timing_37_38_2880x576p,			//29
	Timing_39_1920x1080i_1250_total,//30
	Timing_40_1920x1080i,			//31
	Timing_41_70_1280x720p,			//32
	Timing_42_43_720x576p,			//33
	Timing_44_45_720_1440x576i,		//34
	Timing_46_1920x1080i,			//35
	Timing_47_71_1280x720p,			//36
	Timing_48_49_720x480p,			//37
	Timing_50_51_720_1440x480i,		//38
	Timing_52_53_720x576p,			//39
	Timing_54_55_720_1440x576i,		//40
	Timing_56_57_720x480p,			//41
	Timing_58_59_720_1440x480i,		//42
	Timing_60_65_1280x720_24,			//43
	Timing_61_66_1280x720_25,			//44
	Timing_62_67_1280x720_30,			//45
	Timing_63_78_1920x1080p_120,       //46
	Timing_64_77_1920x1080p_100,       //47
	Timing_79_1680x720p_24,         //48
	Timing_80_1680x720p_25,         //49
	Timing_81_1680x720p_30,         //50
	Timing_82_1680x720p_50,         //51
	Timing_83_1680x720p_60,         //52
	Timing_84_1680x720p_100,         //53
	Timing_85_1680x720p_120,         //54
	Timing_86_2560x1080p_24,         //55
	Timing_87_2560x1080p_25,         //56
	Timing_88_2560x1080p_30,         //57
	Timing_89_2560x1080p_50,         //58
	Timing_90_2560x1080p_60,         //59
	Timing_91_2560x1080p_100,         //60
	Timing_92_2560x1080p_120,         //61
	TIMING_MAX,
	TIMING_PC_MODE = 0x200,
	TIMING_NOT_SUPPORT,
	TIMING_NOSIGNAL
} video_index_type;


// repetition factor
#define	RP1		0x01	// x1 (no repetition)
#define	RP2		0x02	// x2 (doubled)
#define	RP4		0x04	// x4
#define	RP5		0x08	// x5
#define	RP7		0x10	// x7
#define	RP8		0x20	// x8
#define	RP10	0x40	// x10

#define	PROG	0	// progressive scan
#define INTL	1	// interlaced scan
#define	POS		0	// positive pulse
#define	NEG		1	// negative pulse

#define NTSC	1	// NTSC system (60Hz)
#define PAL		2	// PAL system (50Hz)

typedef struct
{
	HI_U16  H; // Number of horizontal pixels
	HI_U16	V; // Number of vertical pixels
} pixs_type;

typedef struct
{
	HI_U32		Vic4x3; // CEA VIC for 4:3 picture aspect rate, 0 if not avaliable
	HI_U32		Vic16x9; // CEA VIC for 16:9 picture aspect rate, 0 if not avaliable
	HI_U32		HdmiVic; // HDMI VIC for 16:9 picture aspect rate, 0 if not avaliable
	pixs_type	strActive; // Number of active pixels
	pixs_type	strTotal; // Total number of pixels
	pixs_type	strBlank; // Number of blank pixels
	pixs_type	strSyncOffset; //front porch
	pixs_type	strSyncWidth; // Width of sync pulse
	HI_U32		HFreq; // in kHz
	HI_U32		VFreq; // in Hz
	HI_U32      PixFreq; // in MHz
	HI_U32		PixClk; // in 10kHz units
	HI_BOOL		Interlaced; // true for interlaced video
	HI_BOOL		HPol; // true on negative polarity for horizontal pulses
	HI_BOOL		VPol; // true on negative polarity for vertical pulses
	HI_BOOL		NtscPal; // 60/120/240Hz (false) or 50/100/200Hz (true) TVs
	HI_U32		Repetition; // Allowed video pixel repetition
	HI_U32		MaxAudioSr8Ch; // maximum allowed audio sample rate for 8 channel audio in kHz
} video_timing_type;



typedef enum
{
	PATH_RGB,					    // RGB, single edge clock
	PATH_YCbCr444,				    // YCbCr 4:4:4, single edge clock
	//PATH_RGB_2_EDGE,		        // RGB, clock on both edges
	//PATH_YCbCr444_2_EDGE,	        // YCbCr 4:4:4, clock on both edges
	//PATH_RGB_48B,				    // RGB, 2 pixels at single edge clock
	//PATH_YCbCr444_48B,			    // YCbCr 4:4:4, 2 pixels per clock (both edges used)
	PATH_YCbCr422,				    // YCbCr 4:2:2, single edge clock, Y is separate, Cb and Cr multiplexed
	//PATH_YCbCr422_MUX8B,		    // YCbCr 4:2:2, single edge at 2x clock, Y multiplexed with Cb and Cr, 8 bit bus
	//PATH_YCbCr422_MUX10B,		    // YCbCr 4:2:2, single edge at 2x clock, Y multiplexed with Cb and Cr, 10 bit bus
	//PATH_YCbCr422_16B,			    // YCbCr 4:2:2, single edge clock, Y is separate, Cb and Cr multiplexed, 16 bit bus
	//PATH_YCbCr422_20B,			// YCbCr 4:2:2, single edge clock, Y is separate, Cb and Cr multiplexed, 20 bit bus
	//PATH_YCbCr422_16B_2_PIX_CLK,	// YCbCr 4:2:2, clock on both edges, Y is separate, Cb and Cr multiplexed, 16 bit bus
	//PATH_YCbCr422_20B_2_PIX_CLK,	// YCbCr 4:2:2, clock on both edges, Y is separate, Cb and Cr multiplexed, 20 bit bus
	PATH_BUTT
} VideoPath_t;

typedef enum
{
    RX_VBUS_FORMAT_RGB,          //! 3 channels: R, G, and B
    RX_VBUS_FORMAT_YCBCR444,     //! 3 Channels: Y, Cb, and Cr
    RX_VBUS_FORMAT_YCBCR422,     //! 2 channels: Y and Cb/Cr
    RX_VBUS_FORMAT_YCBCR422_MUX, //! 1 channel: Y/Cb/Y/Cr
}
RxVideoBusFormat;

typedef	struct
{
	HI_U32	    u32ClocksPerLine; // number of pixel clocks per line
	HI_U32	    u32TotalLines; // number of lines
	HI_U32 	    u32PixelFreq; // pixel frequency in 10kHz units
	HI_BOOL     Interlaced	; // true for interlaced video
	HI_BOOL	    HPol		; // true on negative polarity for horizontal pulses
	HI_BOOL	    VPol		; // true on negative polarity for vertical pulses
}
sync_info_type;

#endif
