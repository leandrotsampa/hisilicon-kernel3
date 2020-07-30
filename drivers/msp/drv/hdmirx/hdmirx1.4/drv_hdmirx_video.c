//******************************************************************************
//  Copyright (C), 2007-2014, Hisilicon Technologies Co., Ltd.
//
//******************************************************************************
// File name     : drv_hdmirx_video.c
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
#include "drv_hdmirx_video_internal.h"
#include "drv_hdmirx.h"

/***********************************************************************************************************/
#define LAST_KNOWN_HDMI_VIC	4
#define LAST_KNOWN_VIC	59


struct hdmistatus hdmi_ctx;
HI_U32 HDMI_VIRTUL_ADDR_BASE;


static HI_U32 HDMI_PollingTime[HDMI_STATE_BUTT] =
{
	0,		// INITIAL
	20,	    // IDLE
	10,	    // SYNC_SEARCH
	5,		// SYNC_STABLE
	3,		// FORMAT_DETECTED -- wait at least one frame to allow AVI receiving
	0,		// NOT_SUPPORTED
	1,		// VIDEO_ON
	6,		// REQ_IDLE
};

static video_timing_type VideoTimingTable[NMB_OF_CEA861_VIDEO_MODES + NMB_OF_HDMI_VIDEO_MODES +  1]=
{
  //{VICs HVIC {H/V active}, {H/V  total},{H/V blank),{HVSyncO}, {HVSyncW},Fh , Fv , Fpix, Pclk, I/P , HPol, VPol, syst, repetition, audio},

 // CEA-861D video modes
	{1,0  , 0, {640 , 480 }, {800 , 525 }, {160, 45}, {16 , 10}, {96 , 2}, 31 , 60 , 25 ,  2518, PROG, NEG,  NEG,  0   , RP1,  48},     // 0    640*480*60Hz
	{2,3  , 0, {720 , 480 }, {858 , 525 }, {138, 45}, {16 ,  9}, {62 , 6}, 31 , 60 , 27 ,  2700, PROG, NEG,  NEG,  NTSC, RP1,  48},     // 1    480p
	{0,4  , 0, {1280, 720 }, {1650, 750 }, {370, 30}, {110,  5}, {40 , 5}, 45 , 60 , 74 ,  7425, PROG, POS,  POS,  NTSC, RP1, 192},     // 2    720p60
	{0,5  , 0, {1920, 1080}, {2200, 1125}, {280, 22}, {88 ,  2}, {44 , 5}, 34 , 60 , 74 ,  7425, INTL, POS,  POS,  NTSC, RP1, 192},     // 3    1080i60
	{6,7  , 0, {1440, 480 }, {1716, 525 }, {276, 22}, {38 ,  4}, {124, 3}, 16 , 60 , 27 ,  2700, INTL, NEG,  NEG,  NTSC, RP2,  48},     // 4    480i*2
	{8,9  , 0, {1440, 240 }, {1716, 262 }, {276, 22}, {38 ,  4}, {124, 3}, 16 , 60 , 27 ,  2700, PROG, NEG,  NEG,  NTSC, RP2,  48},     // 5    240p*2
	{8,9  , 0, {1440, 240 }, {1716, 263 }, {276, 23}, {38 ,  5}, {124, 3}, 16 , 60 , 27 ,  2700, PROG, NEG,  NEG,  NTSC, RP2,  48},     // 6    240p*2
	{10,11, 0, {2880, 480 }, {3432, 525 }, {552, 22}, {76 ,  4}, {248, 3}, 16 , 60 , 54 ,  5400, INTL, NEG,  NEG,  NTSC, RP4|RP5|RP7|RP8|RP10,  96},    // 7    480i*4
	{12,13, 0, {2880, 240 }, {3432, 262 }, {552, 22}, {76 ,  4}, {248, 3}, 16 , 60 , 54 ,  5400, PROG, NEG,  NEG,  NTSC, RP4|RP5|RP7|RP8|RP10,  96},    // 8    240p*4
	{12,13, 0, {2880, 240 }, {3432, 263 }, {552, 23}, {76 ,  5}, {248, 3}, 16 , 60 , 54 ,  5400, PROG, NEG,  NEG,  NTSC, RP4|RP5|RP7|RP8|RP10,  96},    // 9    240p*4
	{14,15, 0, {1440, 480 }, {1716, 525 }, {276, 45}, {32 ,  9}, {124, 6}, 31 , 60 , 54 ,  5400, PROG, NEG,  NEG,  NTSC, RP1|RP2,  96}, // 10
	{0,16,  0, {1920, 1080}, {2200, 1125}, {280, 45}, {88 ,  4}, {44 , 5}, 67 , 60 , 148, 14850, PROG, POS,  POS,  NTSC, RP1, 192},     // 11
	{17,18, 0, {720 , 576 }, {864 , 625 }, {144, 49}, {12 ,  5}, {64 , 5}, 31 , 50 , 27 ,  2700, PROG, NEG,  NEG,  PAL , RP1,  48},     // 12
	{0,19,  0, {1280, 720 }, {1980, 750 }, {700, 30}, {440,  5}, {40 , 5}, 38 , 50 , 74 ,  7425, PROG, POS,  POS,  PAL , RP1, 192},     // 13   720p50
	{0,20,  0, {1920, 1080}, {2640, 1125}, {720, 22}, {528,  2}, {44 , 5}, 28 , 50 , 74 ,  7425, INTL, POS,  POS,  PAL , RP1, 192},
	{21,22, 0, {1440, 576 }, {1728, 625 }, {288, 24}, {24 ,  2}, {126, 3}, 16 , 50 , 27 ,  2700, INTL, NEG,  NEG,  PAL , RP2,  48},
	{23,24, 0, {1440, 288 }, {1728, 312 }, {288, 24}, {24 ,  2}, {126, 3}, 16 , 50 , 27 ,  2700, PROG, NEG,  NEG,  PAL , RP2,  48},
	{23,24, 0, {1440, 288 }, {1728, 313 }, {288, 25}, {24 ,  3}, {126, 3}, 16 , 49 , 27 ,  2700, PROG, NEG,  NEG,  PAL , RP2,  48},
	{23,24, 0, {1440, 288 }, {1728, 314 }, {288, 26}, {24 ,  4}, {126, 3}, 16 , 49 , 27 ,  2700, PROG, NEG,  NEG,  PAL , RP2,  48},
	{25,26, 0, {2880, 576 }, {3456, 625 }, {576, 24}, {48 ,  2}, {252, 3}, 16 , 50 , 54 ,  5400, INTL, NEG,  NEG,  PAL , RP4|RP5|RP7|RP8|RP10,  96},
	{27,28, 0, {2880, 288 }, {3456, 312 }, {576, 24}, {48 ,  2}, {252, 3}, 16 , 50 , 54 ,  5400, PROG, NEG,  NEG,  PAL , RP4|RP5|RP7|RP8|RP10,  96},
	{27,28, 0, {2880, 288 }, {3456, 313 }, {576, 25}, {48 ,  3}, {252, 3}, 16 , 49 , 54 ,  5400, PROG, NEG,  NEG,  PAL , RP4|RP5|RP7|RP8|RP10,  96},
	{27,28, 0, {2880, 288 }, {3456, 314 }, {576, 26}, {48 ,  4}, {252, 3}, 16 , 49 , 54 ,  5400, PROG, NEG,  NEG,  PAL , RP4|RP5|RP7|RP8|RP10,  96},
	{29,30, 0, {1440, 576 }, {1728, 625 }, {288, 49}, {24 ,  5}, {128, 5}, 31 , 50 , 54 ,  5400, PROG, NEG,  POS,  PAL , RP1|RP2,  96}, // H-neg, V-pos
	{0,31,  0, {1920, 1080}, {2640, 1125}, {720, 45}, {528,  4}, {44 , 5}, 56 , 50 , 148, 14850, PROG, POS,  POS,  PAL , RP1, 192},
	{0,32,  0, {1920, 1080}, {2750, 1125}, {830, 45}, {638,  4}, {44 , 5}, 27 , 24 , 74 ,  7425, PROG, POS,  POS,  0   , RP1, 192},
	{0,33,  0, {1920, 1080}, {2640, 1125}, {720, 45}, {528,  4}, {44 , 5}, 28 , 25 , 74 ,  7425, PROG, POS,  POS,  PAL , RP1, 192},
	{0,34,  0, {1920, 1080}, {2200, 1125}, {280, 45}, {88 ,  4}, {44 , 5}, 34 , 30 , 74 ,  7425, PROG, POS,  POS,  NTSC, RP1, 192},
	{35,36, 0, {2880, 480 }, {3432, 525 }, {552, 45}, {96 ,  9}, {248, 6}, 31 , 60 , 108, 10800, PROG, NEG,  NEG,  NTSC, RP1|RP2|RP4, 192},
	{37,38, 0, {2880, 576 }, {3456, 625 }, {576, 49}, {48 ,  5}, {256, 5}, 31 , 50 , 108, 10800, PROG, NEG,  NEG,  PAL , RP1|RP2|RP4, 192},
	{0,39,  0, {1920, 1080}, {2304, 1250}, {384, 85}, {32 , 23}, {168, 5}, 31 , 50 , 72 ,  7200, INTL, POS,  NEG,  PAL , RP1, 192}, // H-pos, V-neg, 1,2 blanks are same = 85
	{0,40,  0, {1920, 1080}, {2640, 1125}, {720, 22}, {528,  2}, {44 , 5}, 56 , 100, 148, 14850, INTL, POS,  POS,  PAL , RP1, 192},
	{0,41,  0, {1280, 720 }, {1980, 750 }, {700, 30}, {440,  5}, {40 , 5}, 75 , 100, 148, 14850, PROG, POS,  POS,  PAL , RP1, 192},
	{42,43, 0, {720 , 576 }, {864 , 625 }, {144, 49}, {12 ,  5}, {64 , 5}, 63 , 100, 54 ,  5400, PROG, NEG,  NEG,  PAL , RP1,  96},
	{44,45, 0, {1440, 576 }, {1728, 625 }, {288, 24}, {24 ,  2}, {126, 3}, 31 , 100, 54 ,  5400, INTL, NEG,  NEG,  PAL , RP2,  96},
	{0,46,  0, {1920, 1080}, {2200, 1125}, {280, 22}, {88 ,  2}, {44 , 5}, 68 , 120, 148, 14850, INTL, POS,  POS,  NTSC, RP1, 192},
	{0,47,  0, {1280, 720 }, {1650, 750 }, {370, 30}, {110,  5}, {40 , 5}, 90 , 120, 148, 14850, PROG, POS,  POS,  NTSC, RP1, 192},
	{48,49, 0, {720 , 480 }, {858 , 525 }, {138, 45}, {16 ,  9}, {62 , 6}, 63 , 120, 54 ,  5400, PROG, NEG,  NEG,  NTSC, RP1,  96},
	{50,51, 0, {1440, 480 }, {1716, 525 }, {276, 22}, {38 ,  4}, {124, 3}, 32 , 120, 54 ,  5400, INTL, NEG,  NEG,  NTSC, RP2,  96},
	{52,53, 0, {720 , 576 }, {864 , 625 }, {144, 49}, {12 ,  5}, {64 , 5}, 125, 200, 108, 10800, PROG, NEG,  NEG,  PAL , RP1, 192},
	{54,55, 0, {1440, 576 }, {1728, 625 }, {288, 24}, {24 ,  2}, {126, 3}, 63 , 200, 108, 10800, INTL, NEG,  NEG,  PAL , RP2, 192},
	{56,57, 0, {720 , 480 }, {858 , 525 }, {138, 45}, {16 ,  9}, {62 , 6}, 126, 240, 108, 10800, PROG, NEG,  NEG,  NTSC, RP1, 192},
	{58,59, 0, {1440, 480 }, {1716, 525 }, {276, 22}, {38 ,  4}, {124, 3}, 63 , 240, 108, 10800, INTL, NEG,  NEG,  NTSC, RP2, 192},

 // HDMI 1.4a video modes
	{0,0  , 1, {3840, 2160}, {4400, 2250}, {560, 90}, {176 , 8}, {88 ,10},132 , 30 , 297, 29700, PROG, POS,  POS,  NTSC, RP1,  96},
	{0,0  , 2, {3840, 2160}, {5280, 2250}, {1440,90}, {1056, 8}, {88 ,10},132 , 25 , 297, 29700, PROG, POS,  POS,  PAL , RP1, 192},
	{0,0  , 3, {3840, 2160}, {5500, 2250}, {1660,90}, {1276, 8}, {88 ,10},132 , 24 , 297, 29700, PROG, POS,  POS,  0   , RP1, 192},
	{0,0  , 4, {4096, 2160}, {5500, 2250}, {1404,90}, {1020, 8}, {88 ,10},132 , 24 , 297, 29700, PROG, POS,  POS,  0   , RP1, 192}, // SMPTE (caannot be distingushed from #3)

	{0,0  , 0, {0   , 0   }, {0   , 0   }, {0  , 0 }, {0  ,  0}, {0  , 0}, 0  , 0  , 0  ,     0, 0   , 0  ,  0  ,  0   , 0,   0}
};

const HI_U32 HdmiVic2IdxTable[LAST_KNOWN_HDMI_VIC + 1] =
{
	NMB_OF_CEA861_VIDEO_MODES + NMB_OF_HDMI_VIDEO_MODES,
	//no VIC (dummy, to start real indexes from 1, but not from 0)

	NMB_OF_CEA861_VIDEO_MODES + 0,  // HDMI VIC=1
	NMB_OF_CEA861_VIDEO_MODES + 1,  // HDMI VIC=2
	NMB_OF_CEA861_VIDEO_MODES + 2,  // HDMI VIC=3
	NMB_OF_CEA861_VIDEO_MODES + 3,  // HDMI VIC=4
};

const HI_U8 Vic2IdxTable[LAST_KNOWN_VIC + 1] =
{
	NMB_OF_CEA861_VIDEO_MODES + NMB_OF_HDMI_VIDEO_MODES,
	//no VIC (dummy, to start real indexes from 1, but not from 0)

	0,  //VIC=1
	1,  //VIC=2
	1,  //VIC=3
	2,  //VIC=4
	3,  //VIC=5
	4,  //VIC=6
	4,  //VIC=7
	5,  //VIC=8  Possible indexes: 5,6
	5,  //VIC=9  Possible indexes: 5,6
	7,  //VIC=10
	7,  //VIC=11
	8,  //VIC=12 Possible indexes: 8,9
	8,  //VIC=13 Possible indexes: 8,9
	10, //VIC=14
	10, //VIC=15
	11, //VIC=16
	12, //VIC=17
	12, //VIC=18
	13, //VIC=19
	14, //VIC=20
	15, //VIC=21
	15, //VIC=22
	16, //VIC=23 Possible indexes: 16,17,18
	16, //VIC=24 Possible indexes: 16,17,18
	19, //VIC=25
	19, //VIC=26
	20, //VIC=27 Possible indexes: 20,21,22
	20, //VIC=28 Possible indexes: 20,21,22
	23, //VIC=29
	23, //VIC=30
	24, //VIC=31
	25, //VIC=32
	26, //VIC=33
	27, //VIC=34
	28, //VIC=35
	28, //VIC=36
	29, //VIC=37
	29, //VIC=38
	30, //VIC=39
	31, //VIC=40
	32, //VIC=41
	33, //VIC=42
	33, //VIC=43
	34, //VIC=44
	34, //VIC=45
	35, //VIC=46
	36, //VIC=47
	37, //VIC=48
	37, //VIC=49
	38, //VIC=50
	38, //VIC=51
	39, //VIC=52
	39, //VIC=53
	40, //VIC=54
	40, //VIC=55
	41, //VIC=56
	41, //VIC=57
	42, //VIC=58
	42, //VIC=59
};

static HI_U32 video_regs_49_4A[3][PATH_BUTT][2] =
{
// RGB input ----------------------------
    {
	// RGB output
	{0x00,
	0x00},

	// 444 output
	{0x00,
	reg_EnRGB2YCbCr},
    #if 0
	// RGB 2PixClk output
	{0x00,
	0x00},

	// 444 2PixClk output
	{0x00,
	reg_EnRGB2YCbCr},
    
	// RGB 48B output
	0x00,
	0x00,

	// 444 48B output
	0x00,
	reg_EnRGB2YCbCr,
    #endif
	// 422 output
	{0x00,
	reg_EnRGB2YCbCr | reg_EnDownSample},
	
    #if 0
	// 422 MUX 8 bit output
	{0x00,
	reg_EnRGB2YCbCr | reg_EnDownSample | reg_EnMuxYC | reg_EnDither},

	// 422 MUX 10 bit output
	{0x00,
	reg_EnRGB2YCbCr | reg_EnDownSample | reg_EnMuxYC},
	
	// 422 16 bit output
	{0x00,
	reg_EnRGB2YCbCr | reg_EnDownSample | reg_EnDither},
	// 422 20 bit output
	0x00,
	reg_EnRGB2YCbCr | reg_EnDownSample,
    
	// 422 16 bit 2PixClk output
	0x00,
	reg_EnRGB2YCbCr | reg_EnDownSample | reg_EnDither,

	// 422 20 bit 2PixClk output
	0x00,
	reg_EnRGB2YCbCr | reg_EnDownSample,
    #endif
    },
// YCbCr 422 input ----------------------
    {
	// RGB output
	{reg_enycbcr2rgb,
	reg_EnUpSample},

	// 444 output
	{0x00,
	reg_EnUpSample},
    #if 0
	// RGB 2PixClk output
	{reg_enycbcr2rgb,
	reg_EnUpSample},

	// 444 2PixClk output
	{0x00,
	reg_EnUpSample},
    
	// RGB 48B output
	reg_enycbcr2rgb,
	reg_EnUpSample,

	// 444 48B output
	0x00,
	reg_EnUpSample,
    #endif
	// 422 output
	{0x00,
	0x00},

    #if 0
	// 422 MUX 8 bit output
	{0x00,
	reg_EnMuxYC | reg_EnDither},

	// 422 MUX 10 bit output
	{0x00,
	reg_EnMuxYC},

	// 422 16 bit output
	{0x00,
	reg_EnDither},
	// 422 20 bit output
	0x00,
	0x00,

	// 422 16 bit 2PixClk output
	0x00,
	reg_EnDither,

	// 422 20 bit 2PixClk output
	0x00,
	0x00,
    #endif
    },

// YCbCr 444 input ----------------------
    {
	// RGB output
	{reg_enycbcr2rgb,
	0x00},

	// 444 output
	{0x00,
	0x00},
    #if 0
	// RGB 2PixClk output
	{reg_enycbcr2rgb,
	0x00},

	// 444 2PixClk output
	{0x00,
	0x00},
    
	// RGB 48B output
	reg_enycbcr2rgb,
	0x00,
    
	// 444 48B output
	0x00,
	0x00,
    #endif
	// 422 output
	{0x00,
	reg_EnDownSample},

    #if 0
	// 422 MUX 8 bit output
	{0x00,
	reg_EnDownSample | reg_EnMuxYC | reg_EnDither},

	// 422 MUX 10 bit output
	{0x00,
	reg_EnDownSample | reg_EnMuxYC},

	// 422 16 bit output
	{0x00,
	reg_EnDownSample | reg_EnDither},

	// 422 20 bit output
	0x00,
	reg_EnDownSample,

	// 422 16 bit 2PixClk output
	0x00,
	reg_EnDownSample | reg_EnDither,

	// 422 20 bit 2PixClk output
	0x00,
	reg_EnDownSample,
    #endif
    }
};

/****************************************************************************************
    basic function of video
*****************************************************************************************/
/* function :   get the ckdt status.

   return:      1: the clk is det.
                0: the clk is not det.
*/

static HI_BOOL HDMI_VDO_GetCkdt(void)
{
    HI_BOOL bCkdt;
    bCkdt = HDMI_HAL_RegReadFldAlign(RX_STATE_AON, ckdt);
    return bCkdt;
}

/* function :   get the sync status.

   return:      1: the sync is decoded ok.
                0: the sync is not found.
*/
static HI_BOOL HDMI_VDO_GetScdt(void)
{
    HI_BOOL bScdt;
    bScdt = HDMI_HAL_RegReadFldAlign(RX_STATE_AON, scdt);
    return bScdt;
}

/* function:    calculated  the pix clock frequency in 10kHz units.
                pix clk = 2048*2400/cnt.
                
   return:      the pix frequency in 10kHz
*/
static HI_U32 HDMI_VDO_GetPixClk(void)
{
	HI_U32 xcnt = 0;
	HI_U32 pixel_freq = 0;
	
	xcnt = (HDMI_HAL_RegRead(RX_VID_XPCNT2)<<8) + HDMI_HAL_RegRead(RX_VID_XPCNT1);
	xcnt &=  0x0FFF;
	  
	pixel_freq = HDMI_XCLK;
    if(xcnt == 0) {
      return 0; 
    }
	pixel_freq /= xcnt;

	if(pixel_freq > 65535)
		pixel_freq = 65535;
	
	return pixel_freq;
}

/* function:    video mute switch.

   input:       bOnOff--switch parameter.
                        1: mute video
                        0: unmute video.
*/
void HDMI_VDO_MuteOnOff(HI_BOOL bOnOff)
{
   // if (bOnOff == HI_TRUE) {
        HDMI_HAL_RegWriteFldAlign(DEC_AV_MUTE, reg_video_mute, bOnOff);
   // }
   // else {
  //      HDMI_HAL_RegWriteFldAlign(DEC_AV_MUTE, reg_video_mute, HI_FALSE);
   // }
}
/* function:    judge the replication is allowed or not.

   input:       u32Rep--the replication id.
                    0 0 0 0 No Repetition (i.e., pixel sent once)
                    0 0 0 1 pixel sent 2 times (i.e., repeated once)
                    0 0 1 0 pixel sent 3 times
                    0 0 1 1 pixel sent 4 times
                    0 1 0 0 pixel sent 5 times
                    0 1 0 1 pixel sent 6 times
                    0 1 1 0 pixel sent 7 times
                    0 1 1 1 pixel sent 8 times
                    1 0 0 0 pixel sent 9 times
                    1 0 0 1 pixel sent 10 times
                u32Idx--the video timing index.
                
   return:      1: the replication is valid
                0: the replication is invalid.
*/

HI_BOOL HDMI_VDO_GetRepAllowed(HI_U32 u32Rep, HI_U32 u32Idx)
{
    HI_U32  u32TableIdx;
    HI_U32  u32TableRep;
    HI_BOOL bValid = HI_FALSE;
    
    if (u32Idx != TIMING_NOT_SUPPORT) {
		// Resolution has been measured and AVI InfoFrame data is valid
		u32TableIdx = u32Idx & ~HDMI_3D_RESOLUTION_MASK;

		if(u32TableIdx < (NMB_OF_CEA861_VIDEO_MODES + NMB_OF_HDMI_VIDEO_MODES))
		{
			// check whether given repetition is allowed or not
			u32TableRep = VideoTimingTable[u32TableIdx].Repetition;

			switch(u32Rep)
			{
			case 0:
				if(u32TableRep & RP1)
				{
					bValid = HI_TRUE;
				}
				break;
			case 1:
				if(u32TableRep & RP2)
				{
					bValid = HI_TRUE;
				}
				break;
			case 3:
				if(u32TableRep & RP4)
				{
					bValid = HI_TRUE;
				}
				break;
			case 4:
				if(u32TableRep & RP5)
				{
					bValid = HI_TRUE;
				}
				break;
			case 6:
				if(u32TableRep & RP7)
				{
					bValid = HI_TRUE;
				}
				break;
			case 7:
				if(u32TableRep & RP8)
				{
					bValid = HI_TRUE;
				}
				break;
			case 9:
				if(u32TableRep & RP10)
				{
					bValid = HI_TRUE;
				}
				break;
			}
		}
	}
    return bValid;
}

/* function:    get the default replication of special timing .

   input:       u32Idx--the video timing index.
                
   return:      the default replication.
                    0: 1x
                    1: 2x
                    3: 4x
                    4: 5x
                    6: 7x
                    7: 9x
                    9: 10x
*/
static HI_U32 HDMI_VDO_GetDefaultRepetition(HI_U32 u32Idx)
{
	HI_U32 u32Rep = 0;

	// Note: no PC modes have repetition

	if( (TIMING_NOT_SUPPORT != u32Idx) && (TIMING_PC_MODE != u32Idx) )
	{
		HI_U32 repetition =	VideoTimingTable[u32Idx & ~HDMI_3D_RESOLUTION_MASK].Repetition;

		// chose smallest allowed replication
		if(repetition & RP1)
			u32Rep = 0;
		else if(repetition & RP2)
			u32Rep = 1;
		else if(repetition & RP4)
			u32Rep = 3;
		else if(repetition & RP5)
			u32Rep = 4;
		else if(repetition & RP7)
			u32Rep = 6;
		else if(repetition & RP8)
			u32Rep = 7;
		else if(repetition & RP10)
			u32Rep = 9;
	}
	return u32Rep;
}

/* function:    reset the driver timing stuct.
*/
void HDMI_VDO_ResetTimingData(void)
{
    hdmi_ctx.strTimingInfo.u32VideoIdx = TIMING_NOT_SUPPORT;
    //hdmi_ctx.strTimingInfo.u32PixFreq = 0;
    //hdmi_ctx.strTimingInfo.u16Vactive = 0;
}

/* function:    set the blank level regarding the input color space.
   input:       eInputColorSpace--input color space
                    0: rgb
                    1: ycbcr422
                    2: ycbcr444
                u32Idx--timing index. for 640*480p           
*/
static void HDMI_VDO_SetBlankLv(color_space_type eInputColorSpace, HI_U32 u32Idx)
{
	HI_U32 blank_levels[3];

	// default are levels for RGB PC modes
	blank_levels[0] = 0;
	blank_levels[1] = 0;
	blank_levels[2] = 0;

	switch(eInputColorSpace)
	{
	case ColorSpace_RGB:
		switch(u32Idx)
		{
		case TIMING_PC_MODE:
		case Timing_1_640x480p:
		case (Timing_1_640x480p | HDMI_3D_RESOLUTION_MASK):
			// RGB IT - all 0s
			break;
		default:
			// RGB CE
			blank_levels[0] = 0x10;
			blank_levels[1] = 0x10;
			blank_levels[2] = 0x10;
		}
		break;
	case ColorSpace_YCbCr444:
		// YCbCr 4:4:4
		blank_levels[0] = 0x80;
		blank_levels[1] = 0x10;
		blank_levels[2] = 0x80;
		break;
	case ColorSpace_YCbCr422:
		// YCbCr 4:2:2
		blank_levels[0] = 0x00;
		blank_levels[1] = 0x10;
		blank_levels[2] = 0x80;
		break;
    default:
        break;
	}

    HDMI_HAL_RegWriteBlock(RX_VID_BLANK1, blank_levels, 3);
}

/* 
   function:    sets video options depending on input and output color spaces.
   input:       output_format--YCbCr 4:4:4, single edge clock.
                in_color_space--input color space
                    0: rgb
                    1: ycbcr422
                    2: ycbcr444
                colorimetry--input color metry
                    1: 601
                    2: 709
                pc_format--if timing is pc or not
                    1: pc timing
                    0: no pc timing.
                force_compression--not used
                output_format:
                    0: rgb/30bit
                    1: ycbcr444/30bit
                    2: ycbcr422/30bit
*/
static void HDMI_VDO_SetColorPath(HI_U32 output_format, HI_U32 in_color_space,	colorimetry_type colorimetry, HI_BOOL pc_format, HI_BOOL force_compression)
{
	HI_U32 video_format_data[3];
    HI_U32 reg_49;
    HI_U32 reg_4a;

	video_format_data[0] = 0x00;
	video_format_data[1] = (HDMI_HAL_RegRead(RX_VID_MODE2) & reg_dither_mode);
	video_format_data[2] = 0x00;

	output_format &= VIDEO_PATH_MASK; //  discard the option MSB bits

	if( (in_color_space <= ColorSpace_BUTT) && (output_format < PATH_BUTT) )
	{
		reg_49 = video_regs_49_4A[in_color_space][output_format][0];
		reg_4a = video_regs_49_4A[in_color_space][output_format][1];
		video_format_data[1] = reg_49;
		video_format_data[2] = reg_4a;
	}


	// for Deep Color featured RX chips
    #if 0
	switch(output_format)
	{
	case PATH_YCbCr422:
	//case PATH_YCbCr422_20B:
	//case PATH_YCbCr422_20B_2_PIX_CLK:
	case PATH_YCbCr422_MUX10B:
		// 422 10 and 12 bit per channel output
		video_format_data[2] &= ~reg_EnDither; // pass all bits to output without dithering
		break;
	default:
		// For all output formats except YCbCr 422 which are able to carry more then 8 bit per channel
		// enable dithering.
		// Note, dithering mode will depend on 0x049.6 and 0x049.7 bits which are set separately.
		video_format_data[2] |=  reg_EnDither; // allows converting Deep Color to Standard Color
	}
	#else
    if (output_format == PATH_YCbCr422) {
        // 422 10 and 12 bit per channel output
        video_format_data[2] &= ~reg_EnDither; // pass all bits to output without dithering
    }
    // For all output formats except YCbCr 422 which are able to carry more then 8 bit per channel
	// enable dithering.
	// Note, dithering mode will depend on 0x049.6 and 0x049.7 bits which are set separately.
    else {
        video_format_data[2] |=  reg_EnDither; // allows converting Deep Color to Standard Color
    }
    #endif
	// Chips without Deep Color support can dither to 8 bit only and the dithering mode is set
	// according to video_regs_49_4A table.

	if (ColorSpace_YCbCr422 == in_color_space) {
		video_format_data[0] |=  reg_ExtBitMode; // enable receiving YCbCr 422 12bit per channel mode
	}
    else {
        video_format_data[0] &= ~reg_ExtBitMode;
    }


	video_format_data[2] &= ~reg_EnSyncCodes;

 
    if ((colorimetry == Colorimetry_ITU709)||(colorimetry == Colorimetry_xv709)) {
        video_format_data[0] |= (reg_RGB2YCbCrMode | reg_YCbCr2RGBMode);
    }

	if(pc_format)
	{
        HDMIRX_DEBUG("PC Timing\n");
		// PC formats only (only VGA from CEA-861)
		if(video_format_data[2] & reg_EnRGB2YCbCr)
		{
			// If input is RGB and output is YCbCr
			// do data compression.
			video_format_data[2] |= reg_EnRGB2YCbCrRange;
		}
		else if(video_format_data[1] & reg_enycbcr2rgb)
		{
			// If input is YCbCr and output is RGB
			// do data expansion.
			video_format_data[1] |= reg_enycbcr2rgbrange;
		}
	}

    if(video_format_data[2] & reg_EnRGB2YCbCr)
	{
		// If input is RGB and output is YCbCr
		// do data compression.

        HDMIRX_DEBUG("RGB IN YPBPR OUT.....\n");
		video_format_data[2] = video_format_data[2] & (~reg_EnRGB2YCbCr);
	}


    if(video_format_data[1] & reg_enycbcr2rgb)
    {
        HDMIRX_DEBUG("YCBCR IN RGB OUT.....\n");

        video_format_data[1] = video_format_data[1] & (~reg_enycbcr2rgb);
    }

    
    HDMI_HAL_RegWriteBlock(RX_VID_CTRL, video_format_data, 3);
}

/* 
   function:    sets output data restored to original clock or not.
                if iclk/oclk more than 4x. it can not restore to original clk
   input:       bMuxMode--mux mode or not.
                    1: mux mode
                    0: not mux mode
                bRestoreOriPixClk--restored to original clock
                    1: oclk=iclk/rep
                    0: oclk=iclk
                u32PixRepl--replication.
                    0: 1x.
                    1: 2x.
                    2: 4x.
*/

void HDMI_VDO_SetOclkdivider(HI_BOOL bRestoreOriPixClk, HI_BOOL bMuxMode, HI_U32 u32PixRepl)
{

	HI_U32 reg_val = HDMI_HAL_RegRead(RX_VID_CTRL4);

	reg_val &= ~(reg_iclk |reg_oclkdiv);    // clear bits of input and output dividers

	reg_val |= (u32PixRepl << 4);           // Set bits for input divider equal Pixel Replication
    #if 0
	// in YCbCr422Mux mode output clock should be doubled
	if(bMuxMode)
	{
		u32PixRepl += 1;
		u32PixRepl >>= 1; // divide by 2
		if(u32PixRepl)
		{
			u32PixRepl -= 1;
		}
	}
    #endif
	 if(bRestoreOriPixClk == HI_TRUE)
	{
		reg_val |= (u32PixRepl << 6);   // Set bits for output divider to restore original pixel clock
	}
     
	HDMI_HAL_RegWrite(RX_VID_CTRL4 , reg_val);
}


// sets parameters depending on video resolution
void HDMI_VDO_SetClockPath(HI_U32 u32Rep, HI_U32 u32OutFormat)
{
	HI_BOOL bRestoreOriPixelClk = HI_TRUE;
	HI_BOOL bMux_mode = HI_FALSE;

	if(u32OutFormat & PASS_REPLICATED_PIXELS_MASK)
		bRestoreOriPixelClk = HI_FALSE;
    #if 0
    if ((u32OutFormat == PATH_YCbCr422_MUX8B) ||(u32OutFormat == PATH_YCbCr422_MUX8B)) {
        bMux_mode = HI_TRUE;
    }
    #endif
	//switch(u8OutFormat)
	//{
	//case PATH_RGB_48B:                // SiI9021/31
	//case PATH_YCbCr444_48B:           // SiI9021/31
	//	HDMI_VDO_SetOclkdivider(HI_TRUE, bRestoreOriPixelClk, bMux_mode, u8Rep);
	//	break;
	//default:
		HDMI_VDO_SetOclkdivider(bRestoreOriPixelClk, bMux_mode, u32Rep);
	//}
}

/* 
    function:    adaptive setting the video path.
*/

void HDMI_VDO_SetVideoPath(void)
{
    HI_U32              u32Idx;
    HI_U32              u32Replication;
    color_space_type    eInColorSpace; 
    HI_U32              u32OutPath;
    HI_BOOL             bPcMode;
    HI_U32              u32TableIdx;
    colorimetry_type    eColorM;
    
    u32Idx = hdmi_ctx.strTimingInfo.u32VideoIdx;
    u32Replication = HDMI_AVI_GetReplication();
    if(!HDMI_VDO_GetRepAllowed(u32Replication, u32Idx) || !HDMI_AVI_GetDataValid()) {
        u32Replication = HDMI_VDO_GetDefaultRepetition(u32Idx);
    }
    HDMIRX_DEBUG("replication = %d\n", u32Replication);
    eInColorSpace = HDMI_AVI_GetColorSpace();
    HDMI_VDO_SetBlankLv(eInColorSpace, u32Idx);
    u32OutPath = HDMI_OUTPUT_COLOR_SPACE;
    
    hdmi_ctx.strTimingInfo.eColorSpace = HDMI_OUTPUT_COLOR_SPACE;//ColorSpace_YCbCr444;
    //	/*libo@201404*/	u32OutPath |= PASS_REPLICATED_PIXELS_MASK;
    
    eColorM = HDMI_AVI_GetColorMetry();
	bPcMode = HI_FALSE;
	if(TIMING_NOT_SUPPORT != u32Idx)
	{
		if(Colorimetry_NoInfo == eColorM)
		{
			if(TIMING_PC_MODE == u32Idx)
			{
				eColorM = Colorimetry_ITU601;
			}
			else
			{
				u32TableIdx = u32Idx & ~HDMI_3D_RESOLUTION_MASK;
				switch(VideoTimingTable[u32TableIdx].strActive.V)
				{
				case 480:
				case 576:
				case 240:
				case 288:
					eColorM = Colorimetry_ITU601;
					break;
				default:
					eColorM = Colorimetry_ITU709;
				}
			}
		}
		switch(u32Idx)
		{
		case TIMING_PC_MODE:
		case Timing_1_640x480p:
		case (Timing_1_640x480p | HDMI_3D_RESOLUTION_MASK):
			bPcMode = HI_TRUE;
            break;
        default:
            break;
		}
	}
    
    hdmi_ctx.strTimingInfo.eColorM = eColorM;
    
    HDMIRX_DEBUG("eInColorSpace = %d, eColorM = %d \n",eInColorSpace,eColorM);
	HDMI_VDO_SetColorPath(u32OutPath, eInColorSpace, eColorM, bPcMode, HI_FALSE);
	HDMI_VDO_SetClockPath(u32Replication, u32OutPath);
}

/* 
    function:    get the timing infomation of input signal.
                 include:   replication(1x,2x,4x)
                            horizontal total.
                            vertical total.
                            pixel clock
                            interlace mode
                            hsync pol.
                            vsync pol.
*/

void HDMI_VDO_GetSyncInfo(sync_info_type *pstrSyncInfo)
{
    HI_U32  u32HRes;
    HI_U32  u32VRes;
    HI_U32  u32PixReplication;

    u32PixReplication = HDMI_HAL_RegReadFldAlign(RX_VID_CTRL4, reg_iclk);
    
    u32HRes = HDMI_HAL_RegRead(RX_H_RESL)+(HDMI_HAL_RegRead(RX_H_RESH) << 8);
    u32VRes = HDMI_HAL_RegRead(RX_V_RESL)+(HDMI_HAL_RegRead(RX_V_RESH) << 8);
    //HDMIRX_DEBUG("u32VRes is %d \n",u32VRes);
    //HDMIRX_DEBUG("RX_V_RESL is %x \n",HDMI_HAL_RegRead(RX_V_RESL));
    //HDMIRX_DEBUG("RX_V_RESH is %x \n",HDMI_HAL_RegRead(RX_V_RESH));
    pstrSyncInfo->u32ClocksPerLine = u32HRes;
    pstrSyncInfo->u32TotalLines = u32VRes;
    pstrSyncInfo->u32ClocksPerLine *= (u32PixReplication + 1);
    pstrSyncInfo->u32PixelFreq = HDMI_VDO_GetPixClk();

    pstrSyncInfo->Interlaced = HDMI_HAL_RegReadFldAlign(RX_VID_STAT, InterlacedOut);
    pstrSyncInfo->HPol = !HDMI_HAL_RegReadFldAlign(RX_VID_STAT, HsyncPol);
    pstrSyncInfo->VPol = !HDMI_HAL_RegReadFldAlign(RX_VID_STAT, VsyncPol);
    
}

/* 
    function:    judge the timing infomation of input signal is valid or not.
                 htotal > 100 and vtotal>100
                 pixclk < 302MHz
                 HF>=13kHz and HF<=135kHz
                 VF>=20Hz and VF<=245Hz
    return:      timing is valid or not
                    1: valid.
                    0: invalid.
*/

HI_BOOL HDMI_VDO_IsTimingInRange(sync_info_type *pstrSyncInfo)
{
    HI_BOOL bPass = HI_FALSE;
    HI_U32  u32PixelClk = 0;
    HI_U32  u32HFreq = 0; 
    HI_U32  u32VFreq = 0;
    
    if( (pstrSyncInfo->u32ClocksPerLine < 100) || (pstrSyncInfo->u32TotalLines < 100) )
	{
		// Also prevents from devision by 0 in h_freq and v_freq calculations.
		HDMIRX_DEBUG("RX: Unsuitable Video: %d clocks per line, %d total lines\n", pstrSyncInfo->u32ClocksPerLine, pstrSyncInfo->u32TotalLines);
	}
    else {
        u32PixelClk = pstrSyncInfo->u32PixelFreq;
        u32HFreq = ( (pstrSyncInfo->u32PixelFreq) * 10 + 5)/pstrSyncInfo->u32ClocksPerLine;  // in 1 kHz units
		u32VFreq = ( u32HFreq * 1000 + 500)/pstrSyncInfo->u32TotalLines;   // in 1 Hz units
		if((u32PixelClk <= (((HI_U32) VIDEO_MAX_PIX_CLK_10MHZ)* 1000 + FPIX_TOLERANCE))&&(u32PixelClk > (((HI_U32)2)* 1000 + FPIX_TOLERANCE)))
		{
			if((u32HFreq + FH_TOLERANCE >= VIDEO_MIN_H_KHZ) && (u32HFreq <= (VIDEO_MAX_H_KHZ + FH_TOLERANCE))) // in 1 kHz units
			{
				if((u32VFreq + FV_TOLERANCE >= VIDEO_MIN_V_HZ) && (u32VFreq <= VIDEO_MAX_V_HZ + FV_TOLERANCE))
				{
					bPass = HI_TRUE;
				}
			}
		}
    }
    if(!bPass)
	{
        HDMIRX_DEBUG("RX: Out Of Range: Fpix=%d0 kHz Fh=%d00 Hz Fv=%d Hz\n",u32PixelClk, u32HFreq, u32VFreq);
	}
    return bPass;
}

/* 
    function:   hdmi timing search proc in CEA861 range.
                to compare interlace/vtotal/htotal/pixel clock/polarity
    input:      timing detail infomation.             
    return:     timing index or timing not found.
*/
HI_U32 HDMI_VDO_Search861(sync_info_type *pstrSyncInfo)
{
	int i;
	HI_U32      u32DviTiming = TIMING_NOT_SUPPORT;
    HI_BOOL     bInterlaced;
    HI_U32      u32VtotalMeasured;
	video_timing_type *p_video_table;

	for(i=0; VideoTimingTable[i].Vic4x3 || VideoTimingTable[i].Vic16x9; i++)
	{
		p_video_table = &VideoTimingTable[i];
		bInterlaced = pstrSyncInfo->Interlaced;
		u32VtotalMeasured = (bInterlaced ?(pstrSyncInfo->u32TotalLines * 2): pstrSyncInfo->u32TotalLines);
        #if 0
        if(i == 1)
        {
            HDMIRX_DEBUG("bInterlaced=%d,u32VtotalMeasured=%d,u32ClocksPerLine=%d,u32PixelFreq=%d,hpol=%d,vpol=%d \n",bInterlaced,u32VtotalMeasured,pstrSyncInfo->u32ClocksPerLine,pstrSyncInfo->u32PixelFreq,pstrSyncInfo->HPol,pstrSyncInfo->VPol);
            HDMIRX_DEBUG("bInterlaced=%d,u32VtotalMeasured=%d,u32ClocksPerLine=%d,u32PixelFreq=%d,hpol=%d,vpol=%d \n",p_video_table->Interlaced,p_video_table->strTotal.V,p_video_table->strTotal.H,pstrSyncInfo->u32PixelFreq,p_video_table->HPol,p_video_table->VPol);
        }
        #endif
		// check progressive/interlaced
		if(bInterlaced != p_video_table->Interlaced)
			continue;

		// check number of lines
		if(ABS_DIFF(u32VtotalMeasured, p_video_table->strTotal.V) > LINES_TOLERANCE)
			continue;

		// check number of clocks per line (it works for all possible replications)
		if(ABS_DIFF(pstrSyncInfo->u32ClocksPerLine, p_video_table->strTotal.H) > PIXELS_TOLERANCE)
			continue;

		// check Pixel Freq (in 10kHz units)
		if(ABS_DIFF(pstrSyncInfo->u32PixelFreq, p_video_table->PixClk) > FPIX_TOLERANCE)
			continue;

		// check exact number of lines
		if(ABS_DIFF(u32VtotalMeasured, p_video_table->strTotal.V) > 1)
			continue;
        #if 1
		// check polarities
		if ((pstrSyncInfo->HPol == p_video_table->HPol) && (pstrSyncInfo->VPol == p_video_table->VPol))	{
			// if all previous checks passed
			u32DviTiming = i;
			break;
		}
        #endif
	}
	return u32DviTiming;
}

/* 
    function:   the caller of hdmi timing search proc.
                to get the timing info first.
    input:      timing detail infomation.             
    return:     timing index.
*/
HI_U32 HDMI_VDO_TimingSearch(sync_info_type *pstrSyncInfo)
{
    HI_U32 u32TimingIdx = TIMING_NOT_SUPPORT;
    
    if (u32TimingIdx == TIMING_NOT_SUPPORT) {
        msleep(600);
        HDMIRX_DEBUG("wait stable...\n");
        HDMI_VDO_GetSyncInfo(pstrSyncInfo);
        if (HDMI_VDO_IsTimingInRange(pstrSyncInfo) == HI_TRUE) {
            u32TimingIdx = HDMI_VDO_Search861(pstrSyncInfo);
            if (u32TimingIdx == TIMING_NOT_SUPPORT) {
                u32TimingIdx = TIMING_PC_MODE;
            }
        }
    }
    
    return u32TimingIdx;
}

static HI_U32 HDMI_VDO_GetTimingIdxFromVsif(void)
{

	HI_U32 u32Index = TIMING_NOT_SUPPORT;

	if(hdmi_ctx.strTimingInfo.bHdmiVicReceived)
	{
		HI_U8 u8HdmiVic = hdmi_ctx.strTimingInfo.u8HdmiVic;
		if((u8HdmiVic > 0) && (u8HdmiVic <= LAST_KNOWN_HDMI_VIC))
		{
			u32Index = HdmiVic2IdxTable[u8HdmiVic];
		}
	}
	else if(hdmi_ctx.strTimingInfo.bAviReceived && hdmi_ctx.strTimingInfo.bHdmi3dVsifReceived)
	{
		HI_U8 u8CeaVic = hdmi_ctx.strTimingInfo.u8Cea861Vic;
		if((u8CeaVic > 0) && (u8CeaVic <= LAST_KNOWN_VIC))
		{
			u32Index = Vic2IdxTable[u8CeaVic] | HDMI_3D_RESOLUTION_MASK;
		}
	}
	return u32Index;
}

// This function takes video timing based information from the video timing table
// and fills p_sync_info structure with this timing information for vid_idx video index.
// Returnstrue on success, false on failure.
// Note: Repetition is not taken in account by this function because the function
// is used for 3D and HDMI VIC (4K2K) formats which do not use repetition
// by HDMI 1.4a specification. Moreover, HDMI 1.4a does not specify how exactly treat
// the formats with repetition. The function might require modification in the future
// if such support is required.
static HI_BOOL HDMI_VDO_FillTimingInfoFromTable(sync_info_type *pInfo, HI_U32 u32Idx)
{
	HI_BOOL success = HI_FALSE;

	if(u32Idx < (NMB_OF_CEA861_VIDEO_MODES + NMB_OF_HDMI_VIDEO_MODES))
	{
		const video_timing_type *p_video_table = &VideoTimingTable[u32Idx];
		pInfo->Interlaced = p_video_table->Interlaced;
		pInfo->u32ClocksPerLine = p_video_table->strTotal.H;
		pInfo->u32TotalLines = p_video_table->strTotal.V;
		pInfo->u32PixelFreq = p_video_table->PixClk;
		pInfo->HPol = p_video_table->HPol;
		pInfo->VPol = p_video_table->VPol;
		if(pInfo->Interlaced)
		{
			pInfo->u32TotalLines /= 2;
		}
		success = HI_TRUE;
	}
	return success;
}

// 3D timing depends not only on the CEA-861D VIC code, but also on a parameter
// called 3D_Structure. This function corrects the timing according to the parameter.
static void HDMI_VDO_CorrectTimingInfoTo3d(sync_info_type *p_sync_info)
{

	switch(hdmi_ctx.strTimingInfo.u8Hdmi3dStructure)
	{
	case 0:	// Frame packing: progressive/interlaced
		if(p_sync_info->Interlaced)
		{
			// One frame contains even and odd images
			// and even it is interlaced ia a scaler perspective,
			// it appears as progressive format for HDMI chip HW.
			p_sync_info->u32TotalLines *= 2;
			p_sync_info->Interlaced = HI_FALSE;
		}
		// no break here
	case 2:	// Line alternative: progressive only
	case 4:	// L + depth: progressive only
		// multiply lines x2; multiply clock x2
		p_sync_info->u32TotalLines *= 2;
		p_sync_info->u32PixelFreq *= 2;
		break;

	case 1:	// Field alternative: interlaced only
		// multiply clock x2
		p_sync_info->u32PixelFreq *= 2;
		break;

	case 3:	// Side-by-Side (Full): progressive/interlaced
		// multiply pixel x2; multiply clock x2
		p_sync_info->u32ClocksPerLine *= 2;
		p_sync_info->u32PixelFreq *= 2;
		break;

	case 5:	// L + depth + graphics + graphics-depth: progressive only
		// multiply lines x4; multiply clock x4
		p_sync_info->u32TotalLines *= 4;
		p_sync_info->u32PixelFreq *= 4;
		break;

	default: // 2D timing compatible: progressive/interlaced
		break;
	}
}



HI_VOID HDMI_VDO_GetFrameRate(HI_U8 *pu32FrameRate, sync_info_type *pstrSyncInfo)
{
    HI_U32 u32PixClk;
    HI_U32 u32HTotal;
    HI_U32 u32VTotal;
    HI_U32 u32FrmRateTmp;

    /*
     * FrmaeRate = PixClock/(H_TOTAL*V_TOTAL)
     * PixClock = XTALIN(XCLK)*2048/clock count
     */
    u32PixClk = pstrSyncInfo->u32ClocksPerLine;
    u32HTotal = pstrSyncInfo->u32PixelFreq;
    u32VTotal = pstrSyncInfo->u32TotalLines;

 
    if ((0 == u32PixClk) || (0 == (u32HTotal * u32VTotal)))
    {
        *pu32FrameRate = 0;
        return;
    }

    u32FrmRateTmp = u32PixClk * 10 * 1000 / (u32HTotal * u32VTotal);

    if ((u32FrmRateTmp <= 24) && (u32FrmRateTmp >= 23))
    {
        *pu32FrameRate = 24;
    }
    else if ((u32FrmRateTmp <= 26) && (u32FrmRateTmp >= 25))
    {
        *pu32FrameRate = 25;
    }
    else if ((u32FrmRateTmp <= 31) && (u32FrmRateTmp >= 29))
    {
        *pu32FrameRate = 30;
    }
    else if ((u32FrmRateTmp <= 51) && (u32FrmRateTmp >= 49))
    {
        *pu32FrameRate = 50;
    }
    else if ((u32FrmRateTmp <= 57) && (u32FrmRateTmp >= 55))
    {
        /* not support 56, force to 60 */
        *pu32FrameRate = 60;
    }
    else if ((u32FrmRateTmp <= 61) && (u32FrmRateTmp >= 59))
    {
        *pu32FrameRate = 60;
    }
    else if ((u32FrmRateTmp <= 68) && (u32FrmRateTmp >= 65))
    {
        *pu32FrameRate = 67;
    }
    else if ((u32FrmRateTmp <= 71) && (u32FrmRateTmp >= 69))
    {
        *pu32FrameRate = 70;
    }
    else if ((u32FrmRateTmp <= 73) && (u32FrmRateTmp >= 71))
    {
        *pu32FrameRate = 72;
    }
    else if ((u32FrmRateTmp <= 76) && (u32FrmRateTmp >= 74))
    {
        *pu32FrameRate = 75;
    }
    else if ((u32FrmRateTmp <= 86) && (u32FrmRateTmp >= 84))
    {
        *pu32FrameRate = 85;
    }
    else
    {
        *pu32FrameRate = 60;
        HI_ERR_HDMIRX("No Fix FrameRate:u32FrmRateTmp=%d\n", u32FrmRateTmp);
    }
}


/* 
------------------------------------------------------------------------------
    Function:    HDMI_VDO_ModeDet
    Description: the mode detection of hdmi.
    Parameters:  none
    Returns:     timing found or not.
                    1: found
                    0: not found.
    NOTE: 
-----------------------------------------------------------------------------
*/
HI_VOID HDMI_VDO_GetWH(HI_U16 *pu16W, HI_U16 *pu16H)
{
    HI_U32 reg_val ;
    
    reg_val = HDMI_HAL_RegRead(RX_DE_PIX1) & L_DEPixels;
    reg_val |= (HDMI_HAL_RegRead(RX_DE_PIX2) & H_DEPixels) << 8;
    *pu16W = (HI_U16)reg_val;    


    reg_val = HDMI_HAL_RegRead(RX_DE_LINE1) & L_DEPixels;
    reg_val |= (HDMI_HAL_RegRead(RX_DE_LINE2) & H_DEPixels) << 8;
    *pu16H = (HI_U16)reg_val;    

}

/*
------------------------------------------------------------------------------
    Function:    HDMI_VDO_ModeDet
    Description: the mode detection of hdmi.
    Parameters:  none
    Returns:     timing found or not.
                    1: found
                    0: not found.
    NOTE: 
-----------------------------------------------------------------------------
*/
HI_BOOL HDMI_VDO_ModeDet(void)
{
    sync_info_type  strSyncInfo;
    HI_U32          u32TimingIdx;
    HI_BOOL         bResult = HI_FALSE;
    HI_U32 rp ;
    
    u32TimingIdx = HDMI_VDO_GetTimingIdxFromVsif();
    if (u32TimingIdx == TIMING_NOT_SUPPORT) {
        u32TimingIdx = HDMI_VDO_TimingSearch(&strSyncInfo);
    }
    else if (u32TimingIdx & HDMI_3D_RESOLUTION_MASK) {
        if(HDMI_VDO_FillTimingInfoFromTable(&strSyncInfo, (u32TimingIdx & ~HDMI_3D_RESOLUTION_MASK)))
		{
			HDMI_VDO_CorrectTimingInfoTo3d(&strSyncInfo);
			if(!HDMI_VDO_IsTimingInRange(&strSyncInfo))
			{
				// Input video is out of range, do not use it.
				u32TimingIdx = TIMING_NOT_SUPPORT;
			}
		}
		else
		{
			u32TimingIdx = TIMING_NOT_SUPPORT;
		}
    }
    hdmi_ctx.strTimingInfo.u32VideoIdx = u32TimingIdx;
    HDMIRX_DEBUG("u32TimingIdx = 0x%x \n",u32TimingIdx);
    if ((u32TimingIdx != TIMING_NOT_SUPPORT)&&(u32TimingIdx != TIMING_PC_MODE)) {
         hdmi_ctx.strTimingInfo.u32PixFreq = strSyncInfo.u32PixelFreq;
         hdmi_ctx.strTimingInfo.u8FrameRate = VideoTimingTable[u32TimingIdx].VFreq;
         hdmi_ctx.strTimingInfo.bInterlaced = VideoTimingTable[u32TimingIdx].Interlaced;
         hdmi_ctx.strTimingInfo.u16Vactive = VideoTimingTable[u32TimingIdx].strActive.V;
         hdmi_ctx.strTimingInfo.u16Hactive = VideoTimingTable[u32TimingIdx].strActive.H;
         rp = VideoTimingTable[u32TimingIdx & ~HDMI_3D_RESOLUTION_MASK].Repetition;
         if((0 != rp)&&(RP4 >= rp))
         {
             hdmi_ctx.strTimingInfo.u16Hactive /= rp ;
         }
         
         bResult = HI_TRUE;
    }    
    else 
    {
        hdmi_ctx.strTimingInfo.u32PixFreq = strSyncInfo.u32PixelFreq;
        HDMI_VDO_GetFrameRate(&(hdmi_ctx.strTimingInfo.u8FrameRate), &strSyncInfo);   
        HDMI_VDO_GetWH(&(hdmi_ctx.strTimingInfo.u16Hactive), &(hdmi_ctx.strTimingInfo.u16Vactive));
        hdmi_ctx.strTimingInfo.bInterlaced = strSyncInfo.Interlaced;
        hdmi_ctx.strTimingInfo.u16Vactive *= (hdmi_ctx.strTimingInfo.bInterlaced) ? 2 : 1;
       // HDMI_VDO_ResetTimingData();
    }
    HDMIRX_DEBUG("TimingIdx: %d \n",u32TimingIdx);
    HDMIRX_DEBUG("@@%dx%d@%d\n",hdmi_ctx.strTimingInfo.u16Hactive , hdmi_ctx.strTimingInfo.u16Vactive, hdmi_ctx.strTimingInfo.u8FrameRate);     /*libo@201312*/    
    return bResult;
}

/* 
------------------------------------------------------------------------------
    Function:    HDMI_VDO_IsTimingChg
    Description: judge the timing change or not.
    Parameters:  none
    Returns:     timing change or not.
                    1: timing change
                    0: not change.
    NOTE: 
-----------------------------------------------------------------------------
*/
HI_BOOL HDMI_VDO_IsTimingChg(void)
{
    sync_info_type  sync_info;
	HI_U32          u32MeasuredIdx = HDMI_VDO_TimingSearch(&sync_info);
	HI_BOOL         bChanged = HI_FALSE;
    HI_U32          u32CurrentIdx;

	if(u32MeasuredIdx == TIMING_PC_MODE)
	{
		// PC resolutions.
		// Since we do not keep the timing information for PC resolutions,
		// assume that the resolution change event is real.
		// It is acceptable because in most cases the false resolution
		// change ocures due to deep color mode changing
		// and the deep color is rarely used with PC resolutions.
		// In the worst case when PC resolution is used with deep color,
		// returning true on false resolution change will only delay
		// the video at the sink.
		bChanged = HI_TRUE;
	}
	if(u32MeasuredIdx < NMB_OF_CEA861_VIDEO_MODES)
	{
		// CEA-861D resolutions only
		u32CurrentIdx = hdmi_ctx.strTimingInfo.u32VideoIdx;
		bChanged = (u32CurrentIdx != u32MeasuredIdx);
	}
	return bChanged;
}

/* 
------------------------------------------------------------------------------
    Function:    HDMI_VDO_PowerOnRegInit
    Description: Initialize registers that need to be set to non-default values
                 at startup.  In general, these registers are not changed
                 after startup.
    Parameters:  none
    Returns:     none

    NOTE: it is in soft reset state if leave the function. so the ip must 
          be into HDMI_STATE_INIT state for cancel soft reset.
-----------------------------------------------------------------------------
*/
void HDMI_VDO_PowerOnRegInit(void)
{

     /* system power normal operation */
    HDMI_SYS_PowerOnOff(HI_TRUE);
    
    HDMI_HAL_RegSetBits(RX_RPT_RDY_CTRL, reg_hdmi_mode_clr_en, HI_FALSE);/*libo @201403*/
    /* HDCP and EEPROM audio FIFO reset */
    HDMI_HAL_RegSetBits(RX_PWD_SRST, /*aac_rst|acr_rst||dc_fifo_rst|*/hdcp_rst|fifo_rst, HI_TRUE);
    udelay(10);
    HDMI_HAL_RegSetBits(RX_PWD_SRST, hdcp_rst|fifo_rst, HI_FALSE);

    HDMI_HAL_RegWrite(RX_PWD_SRST,0xff);
    HDMI_HAL_RegWrite(RX_PWD_SRST,0);

    /* enable DDC*/
    HDMI_HAL_RegWrite(RX_SYS_SWTCHC, reg_ddc_sda_in_del_en|reg_ddc_en);
    
    /* Enable HPD */
    HDMI_PHY_HpdAuto(HI_FALSE);
   
    
    #if SUPPORT_AUDIO
    HDMI_HAL_RegWrite(RX_I2S_CTRL2, reg_sd3_en|reg_sd2_en|reg_sd1_en|reg_sd0_en|reg_mclk_en|reg_pcm);
    // sample sd and ws data in negative edge.
    HDMI_HAL_RegWrite(RX_I2S_CTRL1, reg_clk_edge);
    // enable I2S mode
    HDMI_HAL_RegWrite(RX_AUDRX_CTRL, reg_i2s_mode);
    #endif

    /* default setting is rgb 30bit output */
    HDMI_HAL_RegWrite(RX_VID_MODE, 0);
    HDMI_HAL_RegWrite(RX_VID_MODE2, reg_enycbcr2rgb|reg_enycbcr2rgbrange);
    HDMI_HAL_RegWriteFldAlign(RX_VID_MODE2, reg_dither_mode, HDMI_OUTPUT_DEPTH_30);
    HDMI_HAL_RegWrite(RX_VID_AOF, 0x80);


    // to enable the xclk to pclk counter.
    HDMI_HAL_RegWrite(VID_XPCLK_EN, reg_vid_xclkpclk_en);


     /* sw reset */
    HDMI_SYS_SwRstOnOff(HI_TRUE);
    HDMI_HAL_RegSetBits(RX_AON_SRST, reg_sw_rst_auto, HI_FALSE);
    HDMI_SYS_SwRstOnOff(HI_FALSE);


    // set the bus width is 30bit
    HDMI_HAL_RegWriteFldAlign(RX_VID_CTRL4, reg_bsel, HI_TRUE);
    
    HDMI_HAL_RegWriteFldAlign(RX_SYS_CTRL1,reg_sync_pol, HI_TRUE); // EDA
    HDMI_HAL_RegWrite(SYS_TMDS_D_IR, 0x4d); // EDA
    HDMI_HAL_RegWriteFldAlign(RX_SW_HDMI_MODE, reg_fix_dvihdcp, HI_FALSE); // EDA
    /* cec reset */
    HDMI_HAL_RegWriteFldAlign(RX_C0_SRST2, reg_cec_sw_rst, HI_TRUE);
    
}

/* 
------------------------------------------------------------------------------
    Function:    HDMI_VDO_TimingDataInit
    Description: reset the timing struct
    Parameters:  none
    Returns:     none

    NOTE: 
-----------------------------------------------------------------------------
*/

void HDMI_VDO_TimingDataInit(void)
{
    memset(&hdmi_ctx.strTimingInfo, 0, sizeof(hdmi_timing_struct));
	HDMI_VDO_ResetTimingData();
}

/* 
    function:   set the clock according the pixel depth of GCP.
*/
void HDMI_VDO_SetDcMode(void)
{
    HI_U32 reg_val = DC_CLK_8BPP_1X;
	// Read incoming pixel depth from latest General Control Packet
	hdmi_bus_width pd = HDMI_HAL_RegReadFldAlign(RX_DC_STAT, reg_pixelDepth);
    //HDMIRX_DEBUG("pd = %d \n", pd);
	if(pd != hdmi_ctx.eInputWidth)
	{
		// If it differs from the current setting
		// Update current setting
		hdmi_ctx.eInputWidth = pd;
    	// Update the value in hardware

        #if 0
		reg_val = ((HDMI_HAL_RegRead(RX_TMDS_CCTRL2)) & (~((HI_U32)reg_dc_ctl)));
		switch (pd)
		{
		case RX_DC_8BPP:
			reg_val |= RX_C__TMDS_ECTRL__DC_CLK_8BPP_1X;
			break;
		case RX_DC_10BPP:
			reg_val |= RX_C__TMDS_ECTRL__DC_CLK_10BPP_1X;
			break;
		case RX_DC_12BPP:
			reg_val |= RX_C__TMDS_ECTRL__DC_CLK_12BPP_1X;
			break;
		default:
			break;
		}
		HDMI_HAL_RegWrite(RX_TMDS_CCTRL2, reg_val);
        #else
        switch (pd)
		{
		case RX_DC_8BPP:
			reg_val |= DC_CLK_8BPP_1X;
			break;
		case RX_DC_10BPP:
			reg_val |= DC_CLK_10BPP_1X;
			break;
		case RX_DC_12BPP:
			reg_val |= DC_CLK_12BPP_1X;
			break;
		default:
            reg_val |= DC_CLK_8BPP_1X;
			break;
		}
        HDMI_HAL_RegWriteFldAlign(RX_TMDS_CCTRL2, reg_dc_ctl, reg_val);
        HDMI_HAL_RegWriteFldAlign(RX_TMDS_CCTRL2, reg_dc_ctl_ow, HI_TRUE);
        #endif

        HDMIRX_DEBUG("Dc_FiFo Reset, pd=%d   0:8;1:10;2:12\n", pd);
		HDMI_SYS_DcFifoReset();
	}
}

/* 
------------------------------------------------------------------------------
    Function:    HDMI_VDO_DcReset
    Description: reset deep color setting
    Parameters:  none
    Returns:     none

    NOTE: 1. reset the input width is 24bit.
          2. deep color mode setting.
-----------------------------------------------------------------------------
*/
void HDMI_VDO_DcReset()
{
    hdmi_ctx.eInputWidth= RX_VBUS_WIDTH_24;
	
	HDMI_HAL_RegWrite(RX_TMDS_CCTRL2, 0);
	HDMI_VDO_SetDcMode();
}

/*
    function:   to get the hdmi mode or dvi mode.
    return:     hdmi or dvi
                    1: hdmi mode
                    0: dvi mode
*/
HI_BOOL HDMI_VDO_IsHdmiMode(void)
{
	// NOTE: this function checks HDMI_MODE_ENABLED but not HDMI_MODE_DETECTED bit
	return  HDMI_HAL_RegReadFldAlign( RX_AUDP_STAT, hdmi_mode_det);
}

/*
    function:  the process of HDMI and DVI transition.
*/
void HDMI_VDO_HdmiDviTrans()
{
    if (HDMI_VDO_IsHdmiMode()) {
        
        // Clear BCH counter and the interrupt associated with it.
		// It'll help avoiding a false HDCP Error interrupt caused by pre-HDMI
		// counter content.
		// Capture and clear BCH T4 errors.
		HDMI_HAL_RegWriteFldAlign(RX_ECC_CTRL, reg_capture_cnt, HI_TRUE);
		HDMI_HAL_RegWriteFldAlign(RX_INTR4, intr_HDCP_packet_err, HI_TRUE); // reset the HDCP BCH error interrupt

		hdmi_ctx.bHdmiMode = HI_TRUE;
        #if SUPPORT_AUDIO
		HDMI_AUD_Restart();
        HDMIRX_DEBUG("audio Restart 1 \n");
        #endif
    }
    else {
        hdmi_ctx.bHdmiMode = HI_FALSE;
        // forget all HDMI settings
        HDMI_INFO_ResetData();
        HDMI_ISR_NoAviIntOnOff(HI_FALSE);
        #if SUPPORT_AUDIO
        HDMI_AUD_Stop(HI_FALSE);
        #endif
        //HDMIRX_DEBUG("HDMI_AUD_Stop.....xxxx1111 \n");
    }
}

/*
    function:  the process of HDMI sw statemachine transtion.
*/
void HDMI_VDO_ChangeState(HI_U32 u32State)
{
    hdmi_ctx.u32HdmiState = u32State;
    hdmi_ctx.u32SleepTime = HDMI_PollingTime[u32State];
}




/****************************************************************************************
    basic function of software
*****************************************************************************************/


void HDMI_PowerDownProc(void)
{
    if (HDMI_VDO_GetCkdt() == HI_TRUE) {
        HDMI_SYS_PowerOnOff(HI_TRUE);
        HDMI_SYS_DcFifoReset();
        HDMI_VDO_MuteOnOff(HI_TRUE);
        HDMI_VDO_ChangeState(HDMI_STATE_SYNC_SEARCH);
        HDMIRX_DEBUG("HDMI_STATE_SYNC_SEARCH--ckdt \n");
        HDMI_ISR_ClearScdtInt();
        hdmi_ctx.bAuthStartRequest = HI_FALSE;
        hdmi_ctx.bKsvValid = HI_FALSE;
        HDMI_VDO_ResetTimingData();
        HDMI_INFO_ResetData();
        HDMI_HAL_RegWriteFldAlign(RX_PWD_SRST, hdcp_rst_auto, HI_FALSE);
        hdmi_ctx.Timer[HDMI_TIMER_IDX_ISR] = 1;
        hdmi_ctx.Timer[HDMI_TIMER_IDX_ISR_1] = 1;
        hdmi_ctx.Timer[HDMI_TIMER_IDX_INFO] = 1;
    }
}

void HDMI_SyncInChangeProc(void)
{
	if (HDMI_VDO_GetScdt()) {
       HDMI_VDO_ChangeState(HDMI_STATE_SYNC_STABLE);
       HDMIRX_DEBUG("HDMI_STATE_SYNC_STABLE-- scdt \n");
	}
    else {
        #if SUPPORT_AUDIO
        HDMI_AUD_AssertOff();
        #endif
        HDMI_INFO_ResetData();
        HDMI_SYS_PowerOnOff(HI_FALSE);
        HDMI_VDO_ChangeState(HDMI_STATE_IDLE);
        HDMIRX_DEBUG("HDMI_STATE_IDLE--no scdt \n");
    }
    HDMI_VDO_ResetTimingData();
}

/* 
------------------------------------------------------------------------------
    Function:    HDMI_Initial
    Description: Fw and chip initial where the FW state is trans to HDMI_STATE_INIT
    Parameters:  none
    Returns:     none

    NOTE: only once time if in HDMI_STATE_INIT
-----------------------------------------------------------------------------
*/
void HDMI_Initial(void)
{
    //HI_U32 i;
    /* auto software reset */
    HDMI_HAL_RegWriteFldAlign(RX_AON_SRST, reg_sw_rst_auto, HI_TRUE);
   // HDMI_HAL_RegWriteFldAlign(RX_AON_SRST, reg_sw_rst, HI_TRUE);

    //HDMI_HAL_RegWriteFldAlign(RX_EPST, reg_ld_ksv_clr, HI_FALSE);
    //HDMI_HAL_RegWriteFldAlign(RX_EPCM, reg_ld_ksv, HI_FALSE);
    //HDMI_HAL_RegWriteFldAlign(RX_ACR_CTRL3, reg_cts_thresh, 0x0a);
    //HDMI_HAL_RegWriteFldAlign(RX_ACR_CTRL3, reg_mclk_loopback, HI_TRUE);
    /* 
        reg_cts_thresh: the CTS change threshold is 0x0a, it means if the cts value 
        change more than 0x0a, the cts change flag is on. 
     */
     #if SUPPORT_AUDIO
    HDMI_HAL_RegWrite(RX_ACR_CTRL3, 0x50|reg_mclk_loopback);
    #endif
    /* 
        init threshold for PLL unlock interrupt.if last pixel colocks is within 
        +/-(previous count)/128 for 0x20 samples cycles, the intr[4] is deasserted
    */
    HDMI_HAL_RegWrite(RX_LK_WIN_SVAL, 0x0f);
    HDMI_HAL_RegWrite(RX_LK_THRS_SVAL1, 0x20);
    HDMI_HAL_RegWrite(RX_LK_THRS_SVAL2, 0x00);
    HDMI_HAL_RegWrite(RX_LK_THRS_SVAL3, 0x00);
    
    /* set Video bus width and Video data edge */
    //HDMI_HAL_RegWrite(RX_VID_CTRL4, reg_bsel|reg_edge);  // EDA
    HDMI_HAL_RegWriteFldAlign(RX_VID_CTRL4, reg_bsel, HI_TRUE); // EDA
    //HDMI_HAL_RegWrite(RX_VID_AOF, 0x00000080);

    /*
        according the spec, the PREAMBLE is 8 pixel clock.
        HDCP_PREAMBLE: 8+4(min)
    */
    HDMI_HAL_RegWrite(RX_PREAMBLE_CRIT, 0x06);
    HDMI_HAL_RegWrite(RX_HDCP_PREAMBLE_CRIT, 0x0c);
    
    /* Audio and Video Mute ON */
    HDMI_HAL_RegWriteFldAlign(RX_AUDP_MUTE, reg_audio_mute, HI_TRUE);
    HDMI_HAL_RegWriteFldAlign(DEC_AV_MUTE, reg_video_mute, HI_TRUE);
    
    HDMI_HAL_RegWriteFldAlign(RX_VID_CTRL2, reg_hsync_jitter_en, HI_FALSE);
    
    // disable any Auto Config
    HDMI_HAL_RegWriteFldAlign(RX_VID_CTRL2, reg_avc_en, HI_FALSE);
    HDMI_HAL_RegWriteFldAlign(AEC0_CTRL, reg_aac_en, HI_FALSE);
    HDMI_HAL_RegWriteFldAlign(AEC0_CTRL, reg_aac_out_off_en, HI_FALSE);
    
    // set BCH threshold and reset BCH counter
    HDMI_HAL_RegWriteFldAlign(RX_BCH_THRES, reg_bch_thresh, 0x02);
    // Capture and clear BCH T4 errors.
    HDMI_HAL_RegWriteFldAlign(RX_ECC_CTRL, reg_capture_cnt, HI_TRUE); 
    
    
    // TODO: PHY SETTING
    
    HDMI_INFO_Initial();
    HDMI_ISR_Initial();
    #if SUPPORT_AUDIO
    HDMI_AUD_Init();
    #endif
    HDMI_VDO_TimingDataInit();
    HDMI_VDO_DcReset();
    hdmi_ctx.bHdmiMode = HI_FALSE;
    
    HDMI_HAL_RegWrite(RX_HDCP_THRES, 0x40);
    HDMI_HAL_RegWrite(RX_HDCP_THRES2, 0x0b);
    
    // enable XPCLK counter counting for zone control verification
    // 2048*Pclk/xclk = counter.
    HDMI_HAL_RegWriteFldAlign(VID_XPCLK_EN, reg_vid_xclkpclk_en, HI_TRUE);
    HDMI_HAL_RegWrite(VID_XPCLK_Base, 0xff);

    /* cec reset */
    //HDMI_HAL_RegWriteFldAlign(RX_C0_SRST2, reg_cec_sw_rst, HI_TRUE);

    #if 0
    HDMI_HAL_RegWriteFldAlign(RX_EPCM, reg_ld_ksv, HI_TRUE);
    while (!HDMI_HAL_RegReadFldAlign(RX_EPST,reg_ld_ksv_clr)) {
        mdelay(10);
        i++;
        if(i>=10) {
            HDMIRX_DEBUG("Hdcp load fail!!!!!! \n");
            break;
        }
    }
    if(i<10) {
        HDMIRX_DEBUG("Hdcp load sucess!!!!!! \n");
    }
    
    #endif
    //HDMI_HAL_RegWriteFldAlign(RX_AON_SRST, reg_sw_rst, HI_FALSE);
}
#if SUPPORT_3D
void HDMI_VDO_Verify1P4Format(HI_BOOL bVsifReceived)
{
    switch (hdmi_ctx.u32HdmiState) {
        
        case HDMI_STATE_NOT_SUPPORTED:
        case HDMI_STATE_FORMAT_DETECTED:
            HDMI_VDO_ChangeState(HDMI_STATE_SYNC_STABLE);
            break;
        case HDMI_STATE_VIDEO_ON:
            HDMI_VDO_ChangeState(HDMI_STATE_RECHECK_FORMAT);
            break;
        default:
            break;
    }
    HDMI_ISR_DisVResChangeEventsOnOff(bVsifReceived);
}
#endif
/******************************************************************************************/

void HDMI_DB_ShowTimingInfo(struct seq_file *s)
{
    colorimetry_type  eColorM ;   
    color_space_type enColorSpace;
    sync_info_type strTemp;
    
    HI_UNF_HDMIRX_TIMING_INFO_S pstTimingInfo;

    HDMI_VDO_GetSyncInfo(&strTemp);
    HDMIRX_GetTiming(&pstTimingInfo);
    
    PROC_PRINT(s, "\n---------------HDMIRX Timing---------------\n");
    PROC_PRINT(s,"TimingIndex          :   %d\n",pstTimingInfo.u32TimingIdx);
    PROC_PRINT(s,"Width                :   %d\n",pstTimingInfo.u32Width);
    PROC_PRINT(s,"Height               :   %d\n",pstTimingInfo.u32Height);
    PROC_PRINT(s,"FrameRate            :   %d\n",pstTimingInfo.u32FrameRate);
    PROC_PRINT(s,"Interlace            :   %s\n",pstTimingInfo.bInterlace? "Interlace":"Progressive");
    PROC_PRINT(s,"Htotal               :   %d\n",strTemp.u32ClocksPerLine);
    PROC_PRINT(s,"Vtotal               :   %d\n",strTemp.u32TotalLines);
    PROC_PRINT(s,"PixelFreq            :   %d.%d MHz\n", strTemp.u32PixelFreq/100, strTemp.u32PixelFreq%100);
    PROC_PRINT(s,"Hpol                 :   %s\n",(strTemp.HPol == POS)? "POS" : "NEG");
    PROC_PRINT(s,"Vpol                 :   %s\n",(strTemp.VPol == POS)? "POS" : "NEG");
    if(pstTimingInfo.bPcMode)
    {
        PROC_PRINT(s,"TimingMode           :   PcMode\n");
    }
    else if((pstTimingInfo.u32TimingIdx >= TIMING_MAX) && (pstTimingInfo.u32TimingIdx < (TIMING_MAX+NMB_OF_HDMI_VIDEO_MODES)))
    {
        PROC_PRINT(s,"TimingMode           :   2D_4K*2K\n");
    }
    else if(pstTimingInfo.en3dFmt == HI_UNF_FRAME_PACKING_TYPE_FRAME_PACKING)
    {
        PROC_PRINT(s,"TimingMode           :   3D_FRAME_PACKING\n");
    }
    else if(pstTimingInfo.en3dFmt == HI_UNF_FRAME_PACKING_TYPE_SIDE_BY_SIDE)
    {
        PROC_PRINT(s,"TimingMode           :   3D_SIDE_BY_SIDE\n");
    }
    else if(pstTimingInfo.en3dFmt == HI_UNF_FRAME_PACKING_TYPE_TOP_AND_BOTTOM)
    {
        PROC_PRINT(s,"TimingMode           :   3D_TOP_AND_BOTTOM\n");
    }
    else if(pstTimingInfo.en3dFmt == HI_UNF_FRAME_PACKING_TYPE_TIME_INTERLACED)
    {
        PROC_PRINT(s,"TimingMode           :   3D_TIME_INTERLACED\n");
    }
    else
    {
        PROC_PRINT(s,"TimingMode           :   2D_General\n"); 
    }

    //PROC_PRINT(s,"HdmiMode             :   %s\n",pstTimingInfo.bHdmiMode? "HDMI":"DVI");
    if(pstTimingInfo.bHdmiMode == HI_FALSE)
    {
        PROC_PRINT(s,"HdmiMode             :   %s\n","DVI");
    }
    else
    {
        PROC_PRINT(s,"HdmiMode             :   %s\n","HDMI");
    }
#if SUPPORT_MHL        
    if(pstTimingInfo.bMHL== HI_FALSE)
    {
        PROC_PRINT(s,"bMHLMode             :   Yes\n");
    }
    else
    {
        PROC_PRINT(s,"bMHLMode             :   No\n");
    }
#endif
    eColorM = HDMI_AVI_GetColorMetry();

    if((eColorM == Colorimetry_ITU601)||(eColorM == Colorimetry_xv601))
    {
        PROC_PRINT(s,"InputColorSpace      :   SPACE_YCBCR_601\n"); 
    }
    else if((eColorM == Colorimetry_ITU709)||(eColorM == Colorimetry_xv709))
    {
        PROC_PRINT(s,"InputColorSpace      :   SPACE_YCBCR_709\n"); 
    }
    else
    {
        PROC_PRINT(s,"InputColorSpace      :  %d \n",eColorM);             
    }

    
    enColorSpace = HDMI_AVI_GetColorSpace();
    if(enColorSpace == ColorSpace_YCbCr422)
    {
        PROC_PRINT(s,"InputPixelFmt        :   YCBCR422\n");        
    }
    else if(enColorSpace == ColorSpace_YCbCr444)
    {
        PROC_PRINT(s,"InputPixelFmt        :   YCBCR444\n");        
    }
    else
    {
        PROC_PRINT(s,"InputPixelFmt        :   RGB444\n");        
    }
    

    if(pstTimingInfo.enPixelFmt == HI_UNF_FORMAT_YUV_SEMIPLANAR_422)
    {
        PROC_PRINT(s,"OutputPixelFmt       :   YCBCR422\n");        
    }
    else if(pstTimingInfo.enPixelFmt == HI_UNF_FORMAT_YUV_SEMIPLANAR_444)
    {
        PROC_PRINT(s,"OutputPixelFmt       :   YCBCR444\n");        
    }
    else
    {
        PROC_PRINT(s,"OutputPixelFmt       :   RGB444\n");        
    }
    PROC_PRINT(s,"BitWidth(Bit)        :   %d\n",(pstTimingInfo.enBitWidth*2+8));
    if(pstTimingInfo.enOversample == HI_UNF_OVERSAMPLE_1X)
    {
        PROC_PRINT(s,"Oversample           :   1x\n");
    }
    else
    {
        PROC_PRINT(s,"Oversample           :   %dx\n",pstTimingInfo.enOversample*2);
    }
}

void HDMI_DB_ShowHdcpInfo(struct seq_file *p)
{
    if (HDMI_HAL_RegReadFldAlign(RX_HDCP_STAT, hdcp_decrypting) == HI_TRUE) {
        PROC_PRINT(p, "HDCP is decrypting!! \n");
    }
    else {
        PROC_PRINT(p, "Pwr5v is not decrypting!! \n");
    }
    if (HDMI_HAL_RegReadFldAlign(RX_HDCP_STAT, hdcp_authenticated) == HI_TRUE) {
        PROC_PRINT(p, "HDCP authentication is sucess!! \n");
    }
    else {
        PROC_PRINT(p, "HDCP authentication is fail!! \n");
    }
}

HI_BOOL HDMIRX_HAL_GetHdcpDone(void)
{
    if ((HDMI_HAL_RegReadFldAlign(RX_HDCP_STAT, hdcp_decrypting) == HI_TRUE)\
     &&(HDMI_HAL_RegReadFldAlign(RX_HDCP_STAT, hdcp_authenticated) == HI_TRUE))
    {
        return HI_TRUE;
    }
    
    return HI_FALSE;
}

HI_VOID HDMIRX_HAL_LoadHdcpKey(HI_BOOL bEn)
{
	if(bEn == HI_TRUE)
	{
        HDMI_HAL_RegWriteFldAlign(RX_EPCM, reg_ld_ksv, HI_TRUE);
	}
	else
	{
        HDMI_HAL_RegWriteFldAlign(RX_EPCM, reg_ld_ksv, HI_FALSE);
	}
}


