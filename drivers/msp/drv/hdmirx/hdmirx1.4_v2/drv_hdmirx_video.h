/******************************************************************************

  Copyright (C), 2012-2050, Hisilicon Tech. Co., Ltd.

 ******************************************************************************
  File Name     : drv_hdmirx_video.h
  Version       : Initial Draft
  Author        : Hisilicon multimedia software group
  Created       : 2014/01/16
  Description   : 
  History       :
  1.Date        : 2014/01/16
    Author      : t00202585
    Modification: Created file
******************************************************************************/

#ifndef __DRV_HDMIRX_VIDEO_H__
#define __DRV_HDMIRX_VIDEO_H__

#include "hi_type.h"

#define HDMIRX_VIDEO_GET_CTX()  (&s_stHdmirxVideoCtx)

#define DC_CLK_8BPP_1X		    0x00
#define DC_CLK_8BPP_2X		    0x02
#define DC_CLK_10BPP_1X		    0x04
#define DC_CLK_12BPP_1X		    0x05
#define DC_CLK_10BPP_2X		    0x06
#define DC_CLK_12BPP_2X		    0x07
#define LAST_KNOWN_HDMI_VIC	    10
#define LAST_KNOWN_VIC	        92  // 59 for cea-861d, 64 for cea-861e 92 for cea-861f
#define HDMI_3D_RESOLUTION_MASK   0x80
#define NMB_OF_HDMI_VIDEO_MODES LAST_KNOWN_HDMI_VIC

//range limits to satisfy all 861D video modes
#define VIDEO_MIN_V_HZ			(22)
#define VIDEO_MAX_V_HZ			(243)
#define VIDEO_MIN_H_KHZ			(14)
#define VIDEO_MAX_H_KHZ			(134)
#define VIDEO_MAX_PIX_CLK_10MHZ	(30) // to support 300 MHz resolutions
#define VIDEO_MAX_TMDS_CLK_5MHZ	(300/5) // 300MHz

#define	FPIX_TOLERANCE		200	// in 10 kHz units, i.e. 100 means +-1MHz
#define	PIXELS_TOLERANCE	30	// should be no more then 55 to distinguish all CEA861C modes
#define	LINES_TOLERANCE		3	// should be no more then 29 to distinguish all CEA861C modes
#define	H_FREQ_TOLERANCE	2	// H Freq tolerance in kHz, used for analog video detection
#define	FH_TOLERANCE	    1	// H freq in 1 kHz units, used for range check
#define	FV_TOLERANCE	    2	// V Freq in 1 Hz units, used for range check


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

#define PASS_REPLICATED_PIXELS_MASK	0x80	// if true- pixel clock is multiplied by pixel repeatition rate

#define MODE_STABLE_CNT_THR 20

#define ABS_DIFF(A, B) ((A>B) ? (A-B) : (B-A))

enum
{
    MODE_CHG_HVRES = 1,
    MODE_CHG_PIXCLK = 2,
    MODE_CHG_BUTT
};
typedef struct hiPIXEL_TYPE_S
{
	HI_U16  H; // Number of horizontal pixels
	HI_U16	V; // Number of vertical pixels
} PIXEL_TYPE_S;

typedef struct hiVIDEO_TIMING_DEFINE_S
{
	HI_U32		    Vic4x3; // CEA VIC for 4:3 picture aspect rate, 0 if not avaliable
	HI_U32		    Vic16x9; // CEA VIC for 16:9 picture aspect rate, 0 if not avaliable
	HI_U32		    HdmiVic; // HDMI VIC for 16:9 picture aspect rate, 0 if not avaliable
	PIXEL_TYPE_S	strActive; // Number of active pixels
	PIXEL_TYPE_S	strTotal; // Total number of pixels
	PIXEL_TYPE_S	strBlank; // Number of blank pixels
	PIXEL_TYPE_S	strSyncOffset; //front porch
	PIXEL_TYPE_S	strSyncWidth; // Width of sync pulse
	HI_U32		    HFreq; // in kHz
	HI_U32		    VFreq; // in Hz
	HI_U32          PixFreq; // in MHz
	HI_U32		    PixClk; // in 10kHz units
	HI_BOOL		    Interlaced; // true for interlaced video
	HI_BOOL		    HPol; // true on negative polarity for horizontal pulses
	HI_BOOL		    VPol; // true on negative polarity for vertical pulses
	HI_BOOL		    NtscPal; // 60/120/240Hz (false) or 50/100/200Hz (true) TVs
	HI_U32		    Repetition; // Allowed video pixel repetition
	HI_U32		    MaxAudioSr8Ch; // maximum allowed audio sample rate for 8 channel audio in kHz
} VIDEO_TIMING_DEFINE_S;

typedef enum hiVIDEO_TIMING_IDX_E
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
} VIDEO_TIMING_IDX_E;




typedef enum hiHDMIRX_OUTPUT_FORMAT_E
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
} HDMIRX_OUTPUT_FORMAT_E;

typedef	struct hiSIGNAL_TIMING_INFO_S
{
	HI_U32	    u32ClocksPerLine;   // number of pixel clocks per line
	HI_U32	    u32TotalLines;      // number of lines
	HI_U32 	    u32PixelFreq;       // pixel frequency in 10kHz units
	HI_BOOL     Interlaced;         // true for interlaced video
	HI_BOOL	    HPol;               // true on negative polarity for horizontal pulses
	HI_BOOL	    VPol;               // true on negative polarity for vertical pulses
}SIGNAL_TIMING_INFO_S;

typedef struct hiHDMIRX_TIMING_INFO_S
{
	VIDEO_TIMING_IDX_E		enVideoIdx;
	HI_U32		u32Cea861Vic;
    #if SUPPORT_4K_VIC
	HI_U32		u32HdmiVic;
    #endif
	HI_U32		u32Hdmi3dStructure;
	HI_U32		u32Hdmi3dExtData;
	HI_U32		u32PixFreq;         // pixel frequency in 10kHz units
	HI_U32      u32Vactive;
    HI_U32      u32Hactive;
    HI_U32      u32FrameRate;
    HI_U32      u32Htotal;
    HI_U32      u32Vtotal;
} HDMIRX_TIMING_INFO_S;

typedef enum hiHDMIRX_3D_TYPE_E
{
    HDMIRX_3D_TYPE_FP = 0,
    HDMIRX_3D_TYPE_FIELD_ALT,
    HDMIRX_3D_TYPE_LINE_ALT,
    HDMIRX_3D_TYPE_SBS_FULL,
    HDMIRX_3D_TYPE_L_DEPTH,
    HDMIRX_3D_TYPE_L_DEPTH_GRAP,
    HDMIRX_3D_TYPE_TB,
    HDMIRX_3D_TYPE_RESERVE,
    HDMIRX_3D_TYPE_SBS_HALF,
    HDMIRX_3D_TYPE_BUTT
}HDMIRX_3D_TYPE_E;

typedef struct hiHDMIRX_VIDEO_CTX_S
{
    HDMIRX_TIMING_INFO_S    stHdmirxTimingInfo;
    HDMIRX_INPUT_WIDTH_E    enInputWidth;
    HI_BOOL                 bHdmiMode;
    HI_U32                  u32ModeChgHVResCnt;
    HI_U32                  u32ModeChgPixClkCnt;
    HI_U32                  u32ModeStableCnt;
}HDMIRX_VIDEO_CTX_S;

HI_VOID HDMIRX_VIDEO_RstTimingData(HI_VOID);
HI_VOID HDMIRX_VIDEO_TimingDataInit(HI_VOID);
HI_VOID HDMIRX_VIDEO_SetDeepColorMode(HI_UNF_HDMIRX_PORT_E enPort);
HI_BOOL HDMIRX_VIDEO_CheckStable(HI_UNF_HDMIRX_PORT_E enPort);
HI_VOID HDMIRX_VIDEO_ModeDet(HI_UNF_HDMIRX_PORT_E enPort);
HI_BOOL HDMIRX_VIDEO_IsSupport(HI_VOID);
HI_VOID HDMIRX_VIDEO_SetVideoPath(HI_UNF_HDMIRX_PORT_E enPort);
HI_BOOL HDMIRX_VIDEO_GetHdmiMode(HI_UNF_HDMIRX_PORT_E enPort);
HI_U32 HDMIRX_VIDEO_GetModeChgType(HI_UNF_HDMIRX_PORT_E enPort);
HI_BOOL HDMIRX_VIDEO_IsNeedModeChange(HI_UNF_HDMIRX_PORT_E enPort,HI_U32 u32Type);
HI_BOOL HDMIRX_VIDEO_HdmiDviTrans(HI_UNF_HDMIRX_PORT_E enPort);
HI_VOID HDMIRX_VIDEO_Clear4k3dInfo(HI_VOID);
HI_VOID HDMIRX_VIDEO_Verify1P4Format(HI_UNF_HDMIRX_PORT_E enPort,HI_BOOL bVsifReceived);
#if SUPPORT_4K_VIC
HI_U32 HDMIRX_VIDEO_GetCurHdmiVic(HI_VOID);
HI_VOID HDMIRX_VIDEO_SetCurHdmiVic(HI_U32 u32Vic);
#endif
HI_U32 HDMIRX_VIDEO_GetCur3dStructure(HI_VOID);
HI_U32 HDMIRX_VIDEO_GetCur3dExtData(HI_VOID);
HI_VOID HDMIRX_VIDEO_SetCur3dStructure(HI_U32 u32Structure);
HI_VOID HDMIRX_VIDEO_SetCur3dExtData(HI_U32 u32TdExtData);
HI_VOID HDMIRX_VIDEO_Set861Vic(HI_U32 u32Vic);
HI_VOID HDMIRX_VIDEO_SetResChgEventsEn(HI_UNF_HDMIRX_PORT_E enPort,HI_BOOL bEn);
HI_U32 HDMIRX_VIDEO_GetPixelClk(HI_VOID);
HDMIRX_INPUT_WIDTH_E HDMIRX_VIDEO_GetInputWidth(HI_VOID);
HI_VOID HDMIRX_VIDEO_GetTimingInfo(HI_UNF_HDMIRX_TIMING_INFO_S *pstTimingInfo);
HI_U32 HDMIRX_VIDEO_GetFrameRate(HI_VOID);
HI_U32 HDMIRX_VIDEO_GetHactive(HI_VOID);
HI_U32 HDMIRX_VIDEO_GetVactive(HI_VOID);
HI_VOID HDMIRX_VIDEO_SetVideoIdx(VIDEO_TIMING_IDX_E enIdx);
HI_BOOL HDMIRX_VIDEO_IsTimingActive(HI_VOID);
HI_VOID HDMIRX_VIDEO_GetTableInfo(HI_U32 u32id , VIDEO_TIMING_DEFINE_S * pstTableInfo);
#endif

