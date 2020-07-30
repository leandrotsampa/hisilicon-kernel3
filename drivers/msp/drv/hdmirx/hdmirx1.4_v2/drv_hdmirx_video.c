/******************************************************************************

  Copyright (C), 2012-2050, Hisilicon Tech. Co., Ltd.

 ******************************************************************************
  File Name     : drv_hdmirx_video.c
  Version       : Initial Draft
  Author        : Hisilicon multimedia software group
  Created       : 2014/01/16
  Description   : 
  History       :
  1.Date        : 2014/01/16
    Author      :  t00202585
    Modification: Created file
******************************************************************************/

//#include <linux/kthread.h>
#include <linux/delay.h>
#include <linux/string.h>


//#include "hi_drv_proc.h"
#include "hal_hdmirx_reg.h"
#include "hal_hdmirx.h"
#include "drv_hdmirx_common.h"
#include "drv_hdmirx_video.h"
#include "drv_hdmirx_packet.h"
#include "drv_hdmirx_ctrl.h"
#include "drv_hdmirx_mhl.h"


#ifdef __cplusplus
 #if __cplusplus
    extern "C" {
 #endif
#endif /* __cplusplus */
static HDMIRX_VIDEO_CTX_S s_stHdmirxVideoCtx;

static const VIDEO_TIMING_DEFINE_S VideoTimingTable[TIMING_MAX + NMB_OF_HDMI_VIDEO_MODES + 1]=
{
  //{VICs HVIC {H/V active}, {H/V  total},{H/V blank),{HVSyncO}, {HVSyncW},Fh , Fv , Fpix, Pclk, I/P , HPol, VPol, syst, repetition, audio},

 // CEA-861E video modes
	{1,0  , 0, {640 , 480 }, {800 , 525 }, {160, 45}, {16 , 10}, {96 , 2}, 31 , 60 , 25 ,  2518, PROG, NEG,  NEG,  0   , RP1,  48},     // 0    640*480*60Hz
	{2,3  , 0, {720 , 480 }, {858 , 525 }, {138, 45}, {16 ,  9}, {62 , 6}, 31 , 60 , 27 ,  2700, PROG, NEG,  NEG,  NTSC, RP1,  48},     // 1    480p
	{0,4  , 0, {1280, 720 }, {1650, 750 }, {370, 30}, {110,  5}, {40 , 5}, 45 , 60 , 74 ,  7425, PROG, POS,  POS,  NTSC, RP1, 192},     // 2    720p60
	{0,5  , 0, {1920, 1080}, {2200, 1125}, {280, 22}, {88 ,  2}, {44 , 5}, 34 , 60 , 74 ,  7425, INTL, POS,  POS,  NTSC, RP1, 192},     // 3    1080i60
	{6,7  , 0, {1440, 480 }, {1716, 525 }, {276, 22}, {38 ,  4}, {124, 3}, 16 , 60 , 27 ,  2700, INTL, NEG,  NEG,  NTSC, RP2,  48},     // 4    480i*2
	{8,9  , 0, {1440, 240 }, {1716, 262 }, {276, 22}, {38 ,  4}, {124, 3}, 16 , 60 , 27 ,  2700, PROG, NEG,  NEG,  NTSC, RP2,  48},     // 5    240p*2
	{8,9  , 0, {1440, 240 }, {1716, 263 }, {276, 23}, {38 ,  5}, {124, 3}, 16 , 60 , 27 ,  2700, PROG, NEG,  NEG,  NTSC, RP2,  48},     // 6    240p*2
	{10,11, 0, {2880, 480 }, {3432, 525 }, {552, 22}, {76 ,  4}, {248, 3}, 16 , 60 , 54 ,  5400, INTL, NEG,  NEG,  NTSC, RP4,  96},    	// 7    480i*4
	{12,13, 0, {2880, 240 }, {3432, 262 }, {552, 22}, {76 ,  4}, {248, 3}, 16 , 60 , 54 ,  5400, PROG, NEG,  NEG,  NTSC, RP4,  96},    	// 8    240p*4
	{12,13, 0, {2880, 240 }, {3432, 263 }, {552, 23}, {76 ,  5}, {248, 3}, 16 , 60 , 54 ,  5400, PROG, NEG,  NEG,  NTSC, RP4,  96},    	// 9    240p*4
	{14,15, 0, {1440, 480 }, {1716, 525 }, {276, 45}, {32 ,  9}, {124, 6}, 31 , 60 , 54 ,  5400, PROG, NEG,  NEG,  NTSC, RP1|RP2,  96}, // 10  480p*2
	{0,16,  0, {1920, 1080}, {2200, 1125}, {280, 45}, {88 ,  4}, {44 , 5}, 67 , 60 , 148, 14850, PROG, POS,  POS,  NTSC, RP1, 192},     // 11  1080p60
	{17,18, 0, {720 , 576 }, {864 , 625 }, {144, 49}, {12 ,  5}, {64 , 5}, 31 , 50 , 27 ,  2700, PROG, NEG,  NEG,  PAL , RP1,  48},     // 12  576p
	{0,19,  0, {1280, 720 }, {1980, 750 }, {700, 30}, {440,  5}, {40 , 5}, 38 , 50 , 74 ,  7425, PROG, POS,  POS,  PAL , RP1, 192},     // 13   720p50
	{0,20,  0, {1920, 1080}, {2640, 1125}, {720, 22}, {528,  2}, {44 , 5}, 28 , 50 , 74 ,  7425, INTL, POS,  POS,  PAL , RP1, 192},		// 14  1080i50
	{21,22, 0, {1440, 576 }, {1728, 625 }, {288, 24}, {24 ,  2}, {126, 3}, 16 , 50 , 27 ,  2700, INTL, NEG,  NEG,  PAL , RP2,  48},		// 15  1440*576i
	{23,24, 0, {1440, 288 }, {1728, 312 }, {288, 24}, {24 ,  2}, {126, 3}, 16 , 50 , 27 ,  2700, PROG, NEG,  NEG,  PAL , RP2,  48},		// 16  1440*288p
	{23,24, 0, {1440, 288 }, {1728, 313 }, {288, 25}, {24 ,  3}, {126, 3}, 16 , 49 , 27 ,  2700, PROG, NEG,  NEG,  PAL , RP2,  48},		// 17  1440*288p
	{23,24, 0, {1440, 288 }, {1728, 314 }, {288, 26}, {24 ,  4}, {126, 3}, 16 , 49 , 27 ,  2700, PROG, NEG,  NEG,  PAL , RP2,  48},		// 18  1440*288p
	{25,26, 0, {2880, 576 }, {3456, 625 }, {576, 24}, {48 ,  2}, {252, 3}, 16 , 50 , 54 ,  5400, INTL, NEG,  NEG,  PAL , RP4,  96},		// 19  2880*576i
	{27,28, 0, {2880, 288 }, {3456, 312 }, {576, 24}, {48 ,  2}, {252, 3}, 16 , 50 , 54 ,  5400, PROG, NEG,  NEG,  PAL , RP4,  96},		// 20  2880*288p
	{27,28, 0, {2880, 288 }, {3456, 313 }, {576, 25}, {48 ,  3}, {252, 3}, 16 , 49 , 54 ,  5400, PROG, NEG,  NEG,  PAL , RP4,  96},		// 21  2880*288p
	{27,28, 0, {2880, 288 }, {3456, 314 }, {576, 26}, {48 ,  4}, {252, 3}, 16 , 49 , 54 ,  5400, PROG, NEG,  NEG,  PAL , RP4,  96},		// 22  2880*288p
	{29,30, 0, {1440, 576 }, {1728, 625 }, {288, 49}, {24 ,  5}, {128, 5}, 31 , 50 , 54 ,  5400, PROG, NEG,  NEG,  PAL , RP1|RP2,  96},	// 23  1440*576P
	{0,31,  0, {1920, 1080}, {2640, 1125}, {720, 45}, {528,  4}, {44 , 5}, 56 , 50 , 148, 14850, PROG, POS,  POS,  PAL , RP1, 192},		// 24  1080p50
	{0,32,  0, {1920, 1080}, {2750, 1125}, {830, 45}, {638,  4}, {44 , 5}, 27 , 24 , 74 ,  7425, PROG, POS,  POS,  0   , RP1, 192},		//25  1080P24
	{0,33,  0, {1920, 1080}, {2640, 1125}, {720, 45}, {528,  4}, {44 , 5}, 28 , 25 , 74 ,  7425, PROG, POS,  POS,  PAL , RP1, 192},		// 26  1080p25
	{0,34,  0, {1920, 1080}, {2200, 1125}, {280, 45}, {88 ,  4}, {44 , 5}, 34 , 30 , 74 ,  7425, PROG, POS,  POS,  NTSC, RP1, 192},		// 27  1080p30
	{35,36, 0, {2880, 480 }, {3432, 525 }, {552, 45}, {96 ,  9}, {248, 6}, 31 , 60 , 108, 10800, PROG, NEG,  NEG,  NTSC, RP1|RP2|RP4, 192},	// 28  2880*480p
	{37,38, 0, {2880, 576 }, {3456, 625 }, {576, 49}, {48 ,  5}, {256, 5}, 31 , 50 , 108, 10800, PROG, NEG,  NEG,  PAL , RP1|RP2|RP4, 192},	// 29  2880*576p
	{0,39,  0, {1920, 1080}, {2304, 1250}, {384, 85}, {32 , 23}, {168, 5}, 31 , 50 , 72 ,  7200, INTL, POS,  NEG,  PAL , RP1, 192}, // 30 H-pos, V-neg, 1,2 blanks are same = 85 1080i50
	{0,40,  0, {1920, 1080}, {2640, 1125}, {720, 22}, {528,  2}, {44 , 5}, 56 , 100, 148, 14850, INTL, POS,  POS,  PAL , RP1, 192},	// 31  1080i*100
	{0,41,  0, {1280, 720 }, {1980, 750 }, {700, 30}, {440,  5}, {40 , 5}, 75 , 100, 148, 14850, PROG, POS,  POS,  PAL , RP1, 192},	// 32  720p100
	{42,43, 0, {720 , 576 }, {864 , 625 }, {144, 49}, {12 ,  5}, {64 , 5}, 63 , 100, 54 ,  5400, PROG, NEG,  NEG,  PAL , RP1,  96},	// 33  576p100
	{44,45, 0, {1440, 576 }, {1728, 625 }, {288, 24}, {24 ,  2}, {126, 3}, 31 , 100, 54 ,  5400, INTL, NEG,  NEG,  PAL , RP2,  96},	// 34  1440*576i*100
	{0,46,  0, {1920, 1080}, {2200, 1125}, {280, 22}, {88 ,  2}, {44 , 5}, 68 , 120, 148, 14850, INTL, POS,  POS,  NTSC, RP1, 192},	// 35  1080i*120
	{0,47,  0, {1280, 720 }, {1650, 750 }, {370, 30}, {110,  5}, {40 , 5}, 90 , 120, 148, 14850, PROG, POS,  POS,  NTSC, RP1, 192},	// 36  720p*120
	{48,49, 0, {720 , 480 }, {858 , 525 }, {138, 45}, {16 ,  9}, {62 , 6}, 63 , 120, 54 ,  5400, PROG, NEG,  NEG,  NTSC, RP1,  96},	// 37  480p*120
	{50,51, 0, {1440, 480 }, {1716, 525 }, {276, 22}, {38 ,  4}, {124, 3}, 32 , 120, 54 ,  5400, INTL, NEG,  NEG,  NTSC, RP2,  96},	// 38  1440*480i*120
	{52,53, 0, {720 , 576 }, {864 , 625 }, {144, 49}, {12 ,  5}, {64 , 5}, 125, 200, 108, 10800, PROG, NEG,  NEG,  PAL , RP1, 192},	// 39  720*576p*200
	{54,55, 0, {1440, 576 }, {1728, 625 }, {288, 24}, {24 ,  2}, {126, 3}, 63 , 200, 108, 10800, INTL, NEG,  NEG,  PAL , RP2, 192},	// 40  1440*576i*200
	{56,57, 0, {720 , 480 }, {858 , 525 }, {138, 45}, {16 ,  9}, {62 , 6}, 126, 240, 108, 10800, PROG, NEG,  NEG,  NTSC, RP1, 192},	// 41  720*480p*240
	{58,59, 0, {1440, 480 }, {1716, 525 }, {276, 22}, {38 ,  4}, {124, 3}, 63 , 240, 108, 10800, INTL, NEG,  NEG,  NTSC, RP2, 192},	// 42  1440*480i*240
    {0,60,  0, {1280, 720 }, {3300, 750 }, {2020,30}, {1760, 5}, {40,  5}, 18,  24,  59 ,  5940, PROG, POS,  POS,  NTSC, RP1, 192},	// 43 720P24
    {0,61,  0, {1280, 720 }, {3960, 750 }, {2680,30}, {2420, 5}, {40,  5}, 18,  25,  74 ,  7425, PROG, POS,  POS,  NTSC, RP1, 192},	// 44 720P25
    {0,62,  0, {1280, 720 }, {3300, 750 }, {2020,30}, {1760, 5}, {40,  5}, 22,  30,  74 ,  7425, PROG, POS,  POS,  NTSC, RP1, 192},	// 45 720P30
    {0,63,  0, {1920, 1080}, {2200, 1125}, {280 ,45}, {88 ,  4}, {44 , 5}, 135, 120, 297, 29700, PROG, POS,  POS,  PAL , RP1, 192},	// 46 1920*1080p*120
    {0,64,  0, {1920, 1080}, {2640, 1125}, {720, 45}, {528,  4}, {44 , 5}, 113, 100, 297, 29700, PROG, POS,  POS,  PAL , RP1, 192},	// 47 1920*1080p*100
    {0,79,  0, {1680, 720 }, {3300, 750 }, {1620,30}, {1360, 5}, {40 , 5},  18,  24,  59,  5940, PROG, POS,  POS,  0   , RP1, 192}, // 48 1680*720p *24
    {0,80,  0, {1680, 720 }, {3168, 750 }, {1488,30}, {1228, 5}, {40 , 5},  19,  25,  59,  5940, PROG, POS,  POS,  PAL , RP1, 192}, // 49 1680*720p *25
    {0,81,  0, {1680, 720 }, {2640, 750 }, {960 ,30}, { 700, 5}, {40 , 5},  23,  30,  59,  5940, PROG, POS,  POS,  0   , RP1, 192}, // 50 1680*720p *30
    {0,82,  0, {1680, 720 }, {2200, 750 }, {520 ,30}, { 260, 5}, {40 , 5},  38,  50,  82,  8250, PROG, POS,  POS,  PAL , RP1, 192}, // 51 1680*720p *50
    {0,83,  0, {1680, 720 }, {2200, 750 }, {520 ,30}, { 260, 5}, {40 , 5}, 45 ,  60,  99,  9900, PROG, POS,  POS,  NTSC, RP1, 192}, // 52 1680*720p *60 
    {0,84,  0, {1680, 720 }, {2000, 825 }, {320,105}, {  60, 5}, {40 , 5}, 83 , 100, 165, 16500, PROG, POS,  POS,  PAL , RP1, 192}, // 53 1680*720p *100
    {0,85,  0, {1680, 720 }, {2000, 825 }, {320,105}, {  60, 5}, {40 , 5}, 99 , 120, 198, 19800, PROG, POS,  POS,  NTSC, RP1, 192}, // 54 1680*720p *120
    {0,86,  0, {2560, 1080}, {3750, 1100}, {1190,20}, { 998, 4}, {44 , 5}, 26 ,  24,  99,  9900, PROG, POS,  POS,  0   , RP1, 192}, // 55 2560*1080p*24
    {0,87,  0, {2560, 1080}, {3200, 1125}, {640 ,45}, { 448, 4}, {44 , 5}, 28 ,  25,  90,  9000, PROG, POS,  POS,  PAL , RP1, 192}, // 56 2560*1080p*25
    {0,88,  0, {2560, 1080}, {3520, 1125}, {960 ,45}, { 768, 4}, {44 , 5}, 34 ,  30, 118, 11880, PROG, POS,  POS,  NTSC, RP1, 192}, // 57 2560*1080p*30
    {0,89,  0, {2560, 1080}, {3300, 1125}, {740 ,45}, { 548, 4}, {44 , 5}, 56 ,  50, 185, 18562, PROG, POS,  POS,  PAL , RP1, 192}, // 58 2560*1080p*50
    {0,90,  0, {2560, 1080}, {3000, 1100}, {440 ,20}, { 248, 4}, {44 , 5}, 66 ,  60, 198, 19800, PROG, POS,  POS,  NTSC, RP1, 192}, // 59 2560*1080p*60
    {0,91,  0, {2560, 1080}, {2970, 1250}, {410,170}, { 218, 4}, {44 , 5}, 125, 100, 371, 37125, PROG, POS,  POS,  PAL , RP1, 192}, // 60 2560*1080p*100
    {0,92,  0, {2560, 1080}, {3300, 1250}, {740,170}, { 548, 4}, {44 , 5}, 150, 120, 495, 49500, PROG, POS,  POS,  NTSC, RP1, 192}, // 61 2560*1080p*120    
 // HDMI 1.4a video modes
    {0,93 , 3, {3840, 2160}, {5500, 2250}, {1660,90}, {1276, 8}, {88 ,10},132 , 24 , 297, 29700, PROG, POS,  POS,  0   , RP1, 192}, // 62 4k*2k*24
    {0,94 , 2, {3840, 2160}, {5280, 2250}, {1440,90}, {1056, 8}, {88 ,10},132 , 25 , 297, 29700, PROG, POS,  POS,  PAL , RP1, 192}, // 63 4k*2k*25
	{0,95 , 1, {3840, 2160}, {4400, 2250}, {560, 90}, {176 , 8}, {88 ,10},132 , 30 , 297, 29700, PROG, POS,  POS,  NTSC, RP1,  96},	// 64 4k*2k*30
    {0,96 , 0, {3840, 2160}, {5280, 2250}, {1440,90}, {1056, 8}, {88 ,10},113 , 50 , 594, 59400, PROG, POS,  POS,  PAL , RP1,  96}, // 65 3840*2160p*50
    {0,97 , 0, {3840, 2160}, {4400, 2250}, {560 ,90}, {176 , 8}, {88 ,10},135 , 60 , 594, 59400, PROG, POS,  POS,  NTSC, RP1, 192}, // 66 3840*2160p*60
    {0,98 , 4, {4096, 2160}, {5500, 2250}, {1404,90}, {1020, 8}, {88 ,10},132 , 24 , 297, 29700, PROG, POS,  POS,  0   , RP1, 192}, // 67 SMPTE (caannot be distingushed from #3)
    {0,99 , 0, {4096, 2160}, {5280, 2250}, {1184,90}, {968 , 8}, {88 ,10},56  , 25 , 297, 29700, PROG, POS,  POS,  PAL , RP1, 192}, // 68 4096*2160p*25
    {0,100, 0, {4096, 2160}, {4400, 2250}, {304 ,90}, { 88 , 8}, {88 ,10},68  , 30 , 297, 29700, PROG, POS,  POS,  NTSC, RP1, 192}, // 69 4096*2160p*30
    {0,101, 0, {4096, 2160}, {5280, 2250}, {1184,90}, {968 , 8}, {88 ,10},113 , 50 , 594, 59400, PROG, POS,  POS,  PAL , RP1, 192}, // 70 4096*2160p*50
    {0,102, 0, {4096, 2160}, {4400, 2250}, {304 ,90}, { 88 , 8}, {88 ,10},135 , 60 , 594, 59400, PROG, POS,  POS,  NTSC, RP1, 192}, // 71 4096*2160p*60
	{0,0  , 0, {0   , 0   }, {0   , 0   }, {0  , 0 }, {0  ,  0}, {0  , 0}, 0  , 0  , 0  ,     0, 0   , 0  ,  0  ,  0   , 0,   0}
};
#if SUPPORT_4K_VIC
static const HI_U32 HdmiVic2IdxTable[LAST_KNOWN_HDMI_VIC + 1] =
{
	TIMING_MAX + NMB_OF_HDMI_VIDEO_MODES,
	//no VIC (dummy, to start real indexes from 1, but not from 0)

	TIMING_MAX + 2,  // HDMI VIC=1
	TIMING_MAX + 1,  // HDMI VIC=2
	TIMING_MAX + 0,  // HDMI VIC=3
	TIMING_MAX + 5,  // HDMI VIC=4
	TIMING_MAX + NMB_OF_HDMI_VIDEO_MODES,
	TIMING_MAX + NMB_OF_HDMI_VIDEO_MODES,
	TIMING_MAX + NMB_OF_HDMI_VIDEO_MODES,
	TIMING_MAX + NMB_OF_HDMI_VIDEO_MODES,
	TIMING_MAX + NMB_OF_HDMI_VIDEO_MODES,
	TIMING_MAX + NMB_OF_HDMI_VIDEO_MODES
};
#endif
static const HI_U32 Vic2IdxTable[LAST_KNOWN_VIC + 1] =
{
	TIMING_MAX + NMB_OF_HDMI_VIDEO_MODES,
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
	43, // VIC=60
	44,	// VIC=61
	45,	// VIC=62
	46, // VIC=63
	47, // VIC=64
	43, // VIC=65
	44, // VIC=66
	45, // VIC=67
	13, // VIC=68
	 2, // VIC=69
	32, // VIC=70
	36, // VIC=71
	25, // VIC=72
	26, // VIC=73
	27, // VIC=74
	24, // VIC=75
	11, // VIC=76
	47, // VIC=77
	46, // VIC=78
	48, // VIC=79
	49, // VIC=80
	50, // VIC=81
	51, // VIC=82
	52, // VIC=83
	53, // VIC=84
	54, // VIC=85
	55, // VIC=86
	56, // VIC=87
	57, // VIC=88
	58, // VIC=89
	59, // VIC=90
	60, // VIC=91
	61, // VIC=92
};

/* 
------------------------------------------------------------------------------
    Function:       HDMIRX_VIDEO_GetSyncInfo
    Description:    get the timing infomation of input signal.
    Parameters:     None.
    Returns:        None.
    Note:           replication(1x,2x,4x)
                    horizontal total.
                    vertical total.
                    pixel clock
                    interlace mode
                    hsync pol.
                    vsync pol..    
-----------------------------------------------------------------------------
*/
static HI_VOID HDMIRX_VIDEO_GetSyncInfo(HI_UNF_HDMIRX_PORT_E enPort,SIGNAL_TIMING_INFO_S *pstSyncInfo)
{
    HI_U32  u32PixReplication;

    u32PixReplication = HDMIRX_HAL_GetReplication(enPort);
    
    pstSyncInfo->u32ClocksPerLine = HDMIRX_HAL_GetHtotal(enPort);
    pstSyncInfo->u32TotalLines = HDMIRX_HAL_GetVtotal(enPort);


    pstSyncInfo->u32ClocksPerLine *= (u32PixReplication +1 ) ;

    pstSyncInfo->u32PixelFreq = HDMIRX_HAL_GetPixClk(enPort);

    pstSyncInfo->Interlaced = HDMIRX_HAL_GetInterlance(enPort);
    pstSyncInfo->HPol = HDMIRX_HAL_GetHpol(enPort);
    pstSyncInfo->VPol = HDMIRX_HAL_GetVpol(enPort);
    
}

HI_U32 HDMIRX_VIDEO_GetModeChgType(HI_UNF_HDMIRX_PORT_E enPort)
{
    SIGNAL_TIMING_INFO_S stSyncTmp;
    HI_U32  u32ModeChgType = 0;
   // static HI_U32 u32Bcnt=0;
   // HI_BOOL bFlag;
    HDMIRX_VIDEO_CTX_S *pstVideoCtx;

    pstVideoCtx = HDMIRX_VIDEO_GET_CTX();
    HDMIRX_VIDEO_GetSyncInfo(enPort,&stSyncTmp);
    /*
    if((stSyncTmp.u32ClocksPerLine <400) || (stSyncTmp.u32TotalLines <400))
    {
        HDMI_WARN("now H:%d V:%d \n",stSyncTmp.u32ClocksPerLine,stSyncTmp.u32TotalLines);
        u32Bcnt++;
        if(u32Bcnt > 5)
        {
            u32Bcnt=0;
            HDMIRX_CTRL_TryEQ(HI_TRUE);            
        }
        return u32ModeChgType;
    }
    
    HDMIRX_CTRL_TryEQ(HI_FALSE);
    */
    if ((ABS_DIFF(stSyncTmp.u32ClocksPerLine, pstVideoCtx->stHdmirxTimingInfo.u32Htotal) > 5)|| \
    (ABS_DIFF(stSyncTmp.u32TotalLines, pstVideoCtx->stHdmirxTimingInfo.u32Vtotal) > 2))
     {
        
            HDMI_INFO("now H:%d V:%d \n",stSyncTmp.u32ClocksPerLine,stSyncTmp.u32TotalLines);
            HDMI_INFO("old H:%d V:%d \n",pstVideoCtx->stHdmirxTimingInfo.u32Htotal,pstVideoCtx->stHdmirxTimingInfo.u32Vtotal);
            u32ModeChgType += MODE_CHG_HVRES;
            HDMIRX_HAL_ClearAvMute(enPort,HI_FALSE);
            if(HDMIRX_CTRL_IsNeedSubPort() == HI_TRUE)
            {
                HDMIRX_HAL_ClearAvMute(HDMIRX_CTRL_GetSubPort(),HI_FALSE);
            }
            
            
      }
    
    if(ABS_DIFF(stSyncTmp.u32PixelFreq, pstVideoCtx->stHdmirxTimingInfo.u32PixFreq)\
        > (pstVideoCtx->stHdmirxTimingInfo.u32PixFreq/10))
    {
        HDMI_INFO("PixelFreq now:%d ,old:%d \n",stSyncTmp.u32PixelFreq,pstVideoCtx->stHdmirxTimingInfo.u32PixFreq);
        u32ModeChgType += MODE_CHG_PIXCLK;
        HDMIRX_HAL_ClearAvMute(enPort,HI_FALSE);
        if(HDMIRX_CTRL_IsNeedSubPort() == HI_TRUE)
        {
            HDMIRX_HAL_ClearAvMute(HDMIRX_CTRL_GetSubPort(),HI_FALSE);
        }
    }

    return u32ModeChgType;
}

HI_BOOL HDMIRX_VIDEO_IsNeedModeChange(HI_UNF_HDMIRX_PORT_E enPort,HI_U32 u32Type)
{
    HDMIRX_VIDEO_CTX_S *pstVideoCtx;

    pstVideoCtx = HDMIRX_VIDEO_GET_CTX();
    
    if(u32Type & MODE_CHG_HVRES)
    {
        pstVideoCtx->u32ModeChgHVResCnt++;
    }
    else 
    {
        pstVideoCtx->u32ModeChgHVResCnt = 0;
    }
    if (u32Type & MODE_CHG_PIXCLK)
    {
        pstVideoCtx->u32ModeChgPixClkCnt++;
    }
    else
    {
         pstVideoCtx->u32ModeChgPixClkCnt = 0;
    }
    if ((pstVideoCtx->u32ModeChgHVResCnt > 10) || (pstVideoCtx->u32ModeChgPixClkCnt > 10))
    {
        pstVideoCtx->u32ModeChgHVResCnt = 0;
        pstVideoCtx->u32ModeChgPixClkCnt = 0;
        return HI_TRUE;
    }
    if(HDMIRX_VIDEO_HdmiDviTrans(enPort))
    {
        return HI_TRUE;
    }
    return HI_FALSE;
}
HI_BOOL HDMIRX_VIDEO_GetHdmiMode(HI_UNF_HDMIRX_PORT_E enPort)
{
    //HDMIRX_VIDEO_CTX_S *pstVideoCtx;

    //pstVideoCtx = HDMIRX_VIDEO_GET_CTX();

    //return pstVideoCtx->bHdmiMode;
    return HDMIRX_HAL_GetHdmiMode(enPort);
}
HI_BOOL HDMIRX_VIDEO_IsSupport(HI_VOID)
{
    HDMIRX_VIDEO_CTX_S *pstVideoCtx;

    pstVideoCtx = HDMIRX_VIDEO_GET_CTX();
    
    if((pstVideoCtx->stHdmirxTimingInfo.enVideoIdx != TIMING_NOT_SUPPORT) && \
        (pstVideoCtx->stHdmirxTimingInfo.enVideoIdx != TIMING_NOSIGNAL))
     {
        
        return HI_TRUE;
    }
    HDMI_INFO("video timing idx = %d \n", pstVideoCtx->stHdmirxTimingInfo.enVideoIdx);
    return HI_FALSE;    
}
HI_BOOL HDMIRX_VIDEO_CheckStable(HI_UNF_HDMIRX_PORT_E enPort)
{
    SIGNAL_TIMING_INFO_S stSyncTmp;
    HDMIRX_VIDEO_CTX_S *pstVideoCtx;
#if SUPPORT_TRYEQ      
    static HI_U32 u32cnt=0;
#endif 
    pstVideoCtx = HDMIRX_VIDEO_GET_CTX();
    HDMIRX_VIDEO_GetSyncInfo(enPort,&stSyncTmp);
	if((stSyncTmp.u32ClocksPerLine < 100) || (stSyncTmp.u32TotalLines < 100))
	{
       // HDMI_INFO("\nwait: <100 unstable!\n");
       HDMI_INFO("V:%d ,H:%d \n",stSyncTmp.u32ClocksPerLine,stSyncTmp.u32TotalLines);
#if SUPPORT_TRYEQ  
       u32cnt++;
       if(u32cnt > 5)
       {
            u32cnt=0;
            HDMIRX_CTRL_TryEQ(HI_TRUE);            
       }
#endif       
        return HI_FALSE;
	}
#if SUPPORT_TRYEQ    
    HDMIRX_CTRL_TryEQ(HI_FALSE);
#endif
    if (ABS_DIFF(stSyncTmp.u32ClocksPerLine, pstVideoCtx->stHdmirxTimingInfo.u32Htotal) \
        < PIXELS_TOLERANCE) 
    {
        if(ABS_DIFF(stSyncTmp.u32TotalLines, pstVideoCtx->stHdmirxTimingInfo.u32Vtotal) \
            < LINES_TOLERANCE) 
        {
            pstVideoCtx->u32ModeStableCnt++;
            if (pstVideoCtx->u32ModeStableCnt >= MODE_STABLE_CNT_THR) 
            {
                pstVideoCtx->stHdmirxTimingInfo.u32Htotal = stSyncTmp.u32ClocksPerLine;
                pstVideoCtx->stHdmirxTimingInfo.u32Vtotal = stSyncTmp.u32TotalLines;
				pstVideoCtx->u32ModeStableCnt = 0;
                return HI_TRUE;
            }
        }
        else 
        {
            HDMI_INFO("\nwait: TotalLines unstable!\n");
            HDMI_INFO("V:%d ,H:%d \n",stSyncTmp.u32ClocksPerLine,stSyncTmp.u32TotalLines);
            pstVideoCtx->u32ModeStableCnt = 0;
        }
    }
    else 
    {
        HDMI_INFO("\nwait: ClocksPerLine unstable!\n");
        pstVideoCtx->u32ModeStableCnt = 0;    
    }
    
    pstVideoCtx->stHdmirxTimingInfo.u32Htotal = stSyncTmp.u32ClocksPerLine;
    pstVideoCtx->stHdmirxTimingInfo.u32Vtotal = stSyncTmp.u32TotalLines;
    return HI_FALSE;
}

/* 
------------------------------------------------------------------------------
Function:       HDMIRX_VIDEO_RstTimingData
Description:    inital the timing index.
Parameters:     None
Returns:        None
Note:           1.just called only if scdt. 
-----------------------------------------------------------------------------
*/
HI_VOID HDMIRX_VIDEO_RstTimingData(HI_VOID)
{
    HDMIRX_VIDEO_CTX_S *pstVideoCtx;

    pstVideoCtx = HDMIRX_VIDEO_GET_CTX();
    pstVideoCtx->stHdmirxTimingInfo.enVideoIdx = TIMING_NOSIGNAL;
}
/* 
------------------------------------------------------------------------------
    Function:       HDMIRX_VIDEO_TimingDataInit
    Description:    Reset video sw data.
    Parameters:     None
    Returns:        None
    Note:           1.called in 
-----------------------------------------------------------------------------
*/
HI_VOID HDMIRX_VIDEO_TimingDataInit(HI_VOID)
{
    HDMIRX_VIDEO_CTX_S *pstVideoCtx;

    pstVideoCtx = HDMIRX_VIDEO_GET_CTX();
    memset(&pstVideoCtx->stHdmirxTimingInfo, 0, sizeof(HDMIRX_TIMING_INFO_S));
	pstVideoCtx->stHdmirxTimingInfo.enVideoIdx = TIMING_NOSIGNAL;
    pstVideoCtx->enInputWidth = HDMIRX_INPUT_WIDTH_BUTT;
    pstVideoCtx->u32ModeChgHVResCnt = 0;
	pstVideoCtx->u32ModeChgPixClkCnt = 0;
}
/* 
------------------------------------------------------------------------------
    Function:       HDMIRX_VIDEO_SetDeepColorMode
    Description:    set the configuaration in deep color signal.
    Parameters:     None
    Returns:        None.
    Note:           1. called by mode change if signal on->off.
                    2. called if signal off->on.
                    3. called if into .
                    4. called every 50ms.
-----------------------------------------------------------------------------
*/
HI_VOID HDMIRX_VIDEO_SetDeepColorMode(HI_UNF_HDMIRX_PORT_E enPort)
{
    //HI_U32 reg_val = DC_CLK_8BPP_1X;
    HDMIRX_INPUT_WIDTH_E pd; 
    HDMIRX_VIDEO_CTX_S *pstVideoCtx;
    HDMIRX_COLOR_SPACE_E enInColorSpace;
    pstVideoCtx = HDMIRX_VIDEO_GET_CTX();
	// Read incoming pixel depth from latest General Control Packet
	
    pd = HDMIRX_HAL_GetDeepColorSta(enPort);
    enInColorSpace = HDMIRX_PACKET_AVI_GetColorSpace();
    if(enInColorSpace == HDMIRX_COLOR_SPACE_YCBCR422)
    {
        pd = HDMIRX_INPUT_WIDTH_36 ;   
    }
   // printk("port%d:old:%d , new:%d\n",enPort,pstVideoCtx->enInputWidth,pd);
	if(pd != pstVideoCtx->enInputWidth)
	{
		// If it differs from the current setting Update current setting
        
        pstVideoCtx->enInputWidth = pd;
    	// Update the value in hardware   
    	#if 0
        switch (pd)
		{
		case HDMIRX_INPUT_WIDTH_24:
			reg_val |= DC_CLK_8BPP_1X;
			break;
		case HDMIRX_INPUT_WIDTH_30:
			reg_val |= DC_CLK_10BPP_1X;
			break;
		case HDMIRX_INPUT_WIDTH_36:
			reg_val |= DC_CLK_12BPP_1X;
			break;
		default:
            reg_val |= DC_CLK_8BPP_1X;
			break;
		}
        #endif
        if(enPort < HI_UNF_HDMIRX_PORT_BUTT)
        {
            HDMIRX_HAL_SetDeepColor(enPort, pd);
            if(HDMIRX_CTRL_IsNeedSubPort() == HI_TRUE)
            {
                HDMIRX_HAL_SetDeepColor(HDMIRX_CTRL_GetSubPort(), pd);                
            }
        
    		HDMIRX_HAL_SetResetEn(enPort,HDMIRX_DC_FIFO_RST, HI_TRUE);
            if(HDMIRX_CTRL_IsNeedSubPort() == HI_TRUE)
            {
                HDMIRX_HAL_SetResetEn(HDMIRX_CTRL_GetSubPort(),HDMIRX_DC_FIFO_RST, HI_TRUE);
            }
    		udelay(10);
            HDMIRX_HAL_SetResetEn(enPort,HDMIRX_DC_FIFO_RST, HI_FALSE);
            if(HDMIRX_CTRL_IsNeedSubPort() == HI_TRUE)
            {
                HDMIRX_HAL_SetResetEn(HDMIRX_CTRL_GetSubPort(),HDMIRX_DC_FIFO_RST, HI_FALSE);
            }
        }    
	}
}
/* 
------------------------------------------------------------------------------
    Function:       HDMIRX_VIDEO_GetTimingIdxFromVsif
    Description:    get the vic from vsif or avi.
    Parameters:     None.
    Returns:        the index of vic or 3d vic 
                    or TIMING_NO_FOUND.
    Note:           None.    
-----------------------------------------------------------------------------
*/
static HI_U32 HDMIRX_VIDEO_GetTimingIdxFromVsif(HI_VOID)
{

	HI_U32 u32Index = TIMING_NOT_SUPPORT;
	HI_U32 u32CeaVic = 0;
    #if SUPPORT_4K_VIC
    HI_U32 u32HdmiVic; 
    #endif
    HI_BOOL bGotAvi;
    HI_BOOL bGot3d;
    HDMIRX_VIDEO_CTX_S *pstVideoCtx;

    pstVideoCtx = HDMIRX_VIDEO_GET_CTX();
    bGotAvi = HDMIRX_PACKET_AVI_IsGot();
    bGot3d = HDMIRX_PACKET_VSIF_IsGot3d();
    #if SUPPORT_4K_VIC
	if(HI_TRUE == HDMIRX_PACKET_VSIF_IsGotHdmiVic())
	{        
        /*
        u32HdmiVic = pstVideoCtx->stHdmirxTimingInfo.u32HdmiVic;
		if((u32HdmiVic > 0) && (u32HdmiVic <= LAST_KNOWN_HDMI_VIC))
		{
			u32Index = HdmiVic2IdxTable[u32HdmiVic];
		}
		*/
		// TODO:4K*2K采用查表的模式
		u32Index = TIMING_NOT_SUPPORT;
	}
    
	else
    #endif
    if((bGotAvi == HI_TRUE) && (bGot3d == HI_TRUE))
	{
        u32CeaVic = pstVideoCtx->stHdmirxTimingInfo.u32Cea861Vic;
		if((u32CeaVic > 0) && (u32CeaVic <= LAST_KNOWN_VIC))
		{
			u32Index = Vic2IdxTable[u32CeaVic] | HDMI_3D_RESOLUTION_MASK;
		}
	}
	
	return u32Index;
}
/* 
------------------------------------------------------------------------------
    Function:       HDMIRX_VIDEO_IsTimingInRange
    Description:    to check the signal timing is in range or not
    Parameters:     pstrSyncInfo:   input signal timing information.
    Returns:        true:   in range.
                    false:  not in range
    Note:           None.
-----------------------------------------------------------------------------
*/
static HI_BOOL HDMIRX_VIDEO_IsTimingInRange(SIGNAL_TIMING_INFO_S *pstSyncInfo)
{
    HI_BOOL bPass = HI_FALSE;
    HI_U32  u32PixelClk = 0;
    HI_U32  u32HFreq = 0; 
    HI_U32  u32VFreq = 0;
    if ((pstSyncInfo->u32ClocksPerLine > 100) && (pstSyncInfo->u32TotalLines > 100))
    {
        u32PixelClk = pstSyncInfo->u32PixelFreq;
        u32HFreq = ( (pstSyncInfo->u32PixelFreq) * 10 + 5)/pstSyncInfo->u32ClocksPerLine;  // in 1 kHz units
		u32VFreq = ( u32HFreq * 1000 + 500)/pstSyncInfo->u32TotalLines;   // in 1 Hz units
		if((u32PixelClk <= (((HI_U32) VIDEO_MAX_PIX_CLK_10MHZ)* 1000 + FPIX_TOLERANCE)) \
            && (u32PixelClk > (((HI_U32)2)* 1000 + FPIX_TOLERANCE)))
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
    return bPass;
}
/* 
------------------------------------------------------------------------------
    Function:       HDMIRX_VIDEO_Search861
    Description:    timing search in table
    Parameters:     pstrSyncInfo:   timing infomation.
    Returns:        
    Note:           None.    
-----------------------------------------------------------------------------
*/
static HI_U32 HDMIRX_VIDEO_Search861(SIGNAL_TIMING_INFO_S *pstrSyncInfo)
{
	int i;
	HI_U32      u32Timing = TIMING_NOT_SUPPORT;
    HI_BOOL     bInterlaced;
    HI_U32      u32VtotalMeasured;
    HI_U32      u32HactiveMeasured;
    HI_U32  u32PixReplication;
	VIDEO_TIMING_DEFINE_S *pstVideoTable;
    HI_UNF_HDMIRX_PORT_E enport;
    enport = HDMIRX_CTRL_GetCurPort();
    if(enport != HI_UNF_HDMIRX_PORT_BUTT)
    {
        u32PixReplication = HDMIRX_HAL_GetReplication(enport);
        u32HactiveMeasured = HDMIRX_HAL_GetHactive(enport);
    }
    else
    {
        u32PixReplication = 0;
        u32HactiveMeasured = 0;
    }
    for(i=0; VideoTimingTable[i].Vic4x3 || VideoTimingTable[i].Vic16x9; i++)
	{
		pstVideoTable = (VIDEO_TIMING_DEFINE_S *)(&VideoTimingTable[i]);
		bInterlaced = pstrSyncInfo->Interlaced;
		u32VtotalMeasured = (bInterlaced ?(pstrSyncInfo->u32TotalLines<<1) \
            : pstrSyncInfo->u32TotalLines);
		if(bInterlaced != pstVideoTable->Interlaced)
		{
			continue;
		}
		// check number of lines
		if(ABS_DIFF(u32VtotalMeasured, pstVideoTable->strTotal.V) > LINES_TOLERANCE)
			continue;

		// check number of clocks per line (it works for all possible replications)
		if(ABS_DIFF(pstrSyncInfo->u32ClocksPerLine, pstVideoTable->strTotal.H) > PIXELS_TOLERANCE)
			continue;
        
        if(u32HactiveMeasured > 1920)
        {
            if(ABS_DIFF(u32HactiveMeasured*(u32PixReplication+1) ,pstVideoTable->strActive.H) >PIXELS_TOLERANCE )
                continue;
        }
        
		// check Pixel Freq (in 10kHz units)
		if(ABS_DIFF(pstrSyncInfo->u32PixelFreq, pstVideoTable->PixClk) > FPIX_TOLERANCE)
           continue;
        
        u32Timing = i;
           
	    break;
		// check exact number of lines
		//if(ABS_DIFF(u32VtotalMeasured, p_video_table->strTotal.V) > 1)
		//	continue;

		// check polarities
        /*
        if ((pstrSyncInfo->HPol == pstVideoTable->HPol) && \
            (pstrSyncInfo->VPol == pstVideoTable->VPol))    
		{
			// if all previous checks passed
			u32Timing = i;
           
			break;
		}
        */
	}

	return u32Timing;
}

/* 
------------------------------------------------------------------------------
    Function:       HDMIRX_VIDEO_TimingSearch
    Description:    the caller of hdmi timing search proc.
                    to get the timing info first.
    Parameters:     pstrSyncInfo:   timing detail infomation.
    Returns:        timing index.
    Note:           None.    
-----------------------------------------------------------------------------
*/
HI_U32 HDMIRX_VIDEO_TimingSearch(HI_UNF_HDMIRX_PORT_E enPort,SIGNAL_TIMING_INFO_S *pstSyncInfo)
{
    HI_U32 u32TimingIdx = TIMING_NOT_SUPPORT;
	HI_BOOL bInRange;
    
    HDMIRX_VIDEO_GetSyncInfo(enPort,pstSyncInfo);
	bInRange = HDMIRX_VIDEO_IsTimingInRange(pstSyncInfo);
    if (bInRange == HI_TRUE) 
    {
        u32TimingIdx = HDMIRX_VIDEO_Search861(pstSyncInfo);
        if (u32TimingIdx == TIMING_NOT_SUPPORT) 
        {
            u32TimingIdx = TIMING_PC_MODE;
        }
    }

    return u32TimingIdx;
}
/* 
------------------------------------------------------------------------------
    Function:       
    Description:    takes video timing based information from the video timing table
                    and fills p_sync_info structure with this timing information
                    for vid_idx video index.
    Parameters:     None.
    Returns:        true on success, false on failure.
    Note:           
-----------------------------------------------------------------------------
*/
static HI_BOOL HDMIRX_VIDEO_FillTimingInfoFromTable(SIGNAL_TIMING_INFO_S *pInfo, HI_U32 u32Idx)
{
	HI_BOOL success = HI_FALSE;

	if(u32Idx < (TIMING_MAX + NMB_OF_HDMI_VIDEO_MODES))
	{
		const VIDEO_TIMING_DEFINE_S *pastTable = &VideoTimingTable[u32Idx];
		pInfo->Interlaced = pastTable->Interlaced;
		pInfo->u32ClocksPerLine = pastTable->strTotal.H;
		pInfo->u32TotalLines = pastTable->strTotal.V;
		pInfo->u32PixelFreq = pastTable->PixClk;
		pInfo->HPol = pastTable->HPol;
		pInfo->VPol = pastTable->VPol;
		if(pInfo->Interlaced)
		{
			pInfo->u32TotalLines /= 2;
		}
		success = HI_TRUE;
	}
	return success;
}
/* 
------------------------------------------------------------------------------
    Function:       HDMIRX_VIDEO_CorrectTimingInfoTo3d
    Description:    To set the correct timing info according 3d format.
    Parameters:     pstrSyncInfo:   timing detail infomation in 2d.
    Returns:        None.
    Note:           3D timing depends not only on the CEA-861D VIC code, 
                    but also on a parameter called 3D_Structure. 
                    This function corrects the timing according to the parameter.    
-----------------------------------------------------------------------------
*/
static HI_VOID HDMIRX_VIDEO_CorrectTimingInfoTo3d
(SIGNAL_TIMING_INFO_S *pstSyncInfo)
{
    HDMIRX_VIDEO_CTX_S *pstVideoCtx;

    pstVideoCtx = HDMIRX_VIDEO_GET_CTX();
	switch(pstVideoCtx->stHdmirxTimingInfo.u32Hdmi3dStructure)
	{
	case 0:	// Frame packing: progressive/interlaced
		if(pstSyncInfo->Interlaced)
		{
			// One frame contains even and odd images and even it is interlaced ia a scaler perspective,
			// it appears as progressive format for HDMI chip HW.
			pstSyncInfo->u32TotalLines *= 2;
			//pstSyncInfo->Interlaced = HI_FALSE;
		}
		// no break here
	case 2:	// Line alternative: progressive only
	//case 4:	// L + depth: progressive only
		// multiply lines x2; multiply clock x2
		pstSyncInfo->u32TotalLines *= 2;
		pstSyncInfo->u32PixelFreq *= 2;
		break;

	case 1:	// Field alternative: interlaced only
		// multiply clock x2
		pstSyncInfo->u32PixelFreq *= 2;
		break;

	case 3:	// Side-by-Side (Full): progressive/interlaced
		// multiply pixel x2; multiply clock x2
		pstSyncInfo->u32ClocksPerLine *= 2;
		pstSyncInfo->u32PixelFreq *= 2;
		break;
    #if 0
	case 5:	// L + depth + graphics + graphics-depth: progressive only
		// multiply lines x4; multiply clock x4
		pstSyncInfo->u32TotalLines *= 4;
		pstSyncInfo->u32PixelFreq *= 4;
		break;
    #endif
	default: // 2D timing compatible: progressive/interlaced
		break;
	}
}

/* 
------------------------------------------------------------------------------
    Function:       HDMI_VDO_ModeDet
    Description:    the mode detection of hdmi.
    Parameters:     None
    Returns:        True: found
                    False: not found.
    Note:           None.      
-----------------------------------------------------------------------------
*/
HI_VOID HDMIRX_VIDEO_ModeDet(HI_UNF_HDMIRX_PORT_E enPort)
{
    SIGNAL_TIMING_INFO_S  stSyncInfo;
    HI_U32          u32TimingIdx;
    HI_BOOL         bResult;
	HI_BOOL			bValid;
    HI_U32			u32Temp = 0;
	HDMIRX_VIDEO_CTX_S *pstVideoCtx;
    //HI_U32 enRate;
    pstVideoCtx = HDMIRX_VIDEO_GET_CTX();
    u32TimingIdx = HDMIRX_VIDEO_GetTimingIdxFromVsif();
    stSyncInfo.u32PixelFreq = 0;
    if (u32TimingIdx == TIMING_NOT_SUPPORT) 
    {
        u32TimingIdx = HDMIRX_VIDEO_TimingSearch(enPort,&stSyncInfo);
    }
    else if(u32TimingIdx & HDMI_3D_RESOLUTION_MASK)
    {
		u32Temp = (u32TimingIdx & ~HDMI_3D_RESOLUTION_MASK);
		bResult = HDMIRX_VIDEO_FillTimingInfoFromTable(&stSyncInfo, u32Temp);
        if(bResult == HI_TRUE)
		{
			HDMIRX_VIDEO_CorrectTimingInfoTo3d(&stSyncInfo);
			bValid = HDMIRX_VIDEO_IsTimingInRange(&stSyncInfo);
			if(bValid == HI_FALSE)
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
	else if((u32TimingIdx >= TIMING_MAX) && (u32TimingIdx < (TIMING_MAX+NMB_OF_HDMI_VIDEO_MODES)))
	{
		bResult = HDMIRX_VIDEO_FillTimingInfoFromTable(&stSyncInfo, u32TimingIdx);
		if(bResult == HI_TRUE)
		{
			bValid = HDMIRX_VIDEO_IsTimingInRange(&stSyncInfo);
			if(bValid == HI_FALSE)
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
    pstVideoCtx->stHdmirxTimingInfo.enVideoIdx = u32TimingIdx;
    pstVideoCtx->stHdmirxTimingInfo.u32PixFreq = stSyncInfo.u32PixelFreq;
    
	if (u32TimingIdx < (TIMING_MAX + NMB_OF_HDMI_VIDEO_MODES)) // 2d case
    {
         //pstVideoCtx->stHdmirxTimingInfo.u32PixFreq = stSyncInfo.u32PixelFreq;
         pstVideoCtx->stHdmirxTimingInfo.u32Vactive = VideoTimingTable[u32TimingIdx].strActive.V;
		 pstVideoCtx->stHdmirxTimingInfo.u32Hactive = VideoTimingTable[u32TimingIdx].strActive.H;
		 pstVideoCtx->stHdmirxTimingInfo.u32FrameRate = VideoTimingTable[u32TimingIdx].VFreq;
         return ;
    }
    else if(u32TimingIdx == TIMING_PC_MODE) // pc timing case
    {
        HDMI_INFO("\nin PCMode H:%d\n",HDMIRX_HAL_GetHactive(enPort));
        pstVideoCtx->stHdmirxTimingInfo.u32Vactive = HDMIRX_HAL_GetVactive(enPort);
        pstVideoCtx->stHdmirxTimingInfo.u32Hactive = HDMIRX_HAL_GetHactive(enPort);
        pstVideoCtx->stHdmirxTimingInfo.u32FrameRate = HDMIRX_VIDEO_GetFrameRate();
        return ;
    }
    else if((u32TimingIdx & HDMI_3D_RESOLUTION_MASK) && (u32TimingIdx < TIMING_NOT_SUPPORT)) // 3d case
    {
        u32Temp = (u32TimingIdx & ~HDMI_3D_RESOLUTION_MASK);
        //pstVideoCtx->stHdmirxTimingInfo.enVideoIdx = u32Temp;
        if(u32Temp < TIMING_MAX)
        {
           // enRate = HDMIRX_PACKET_AVI_GetReplication() - HDMIRX_OVERSAMPLE_NONE + 1;
            pstVideoCtx->stHdmirxTimingInfo.u32FrameRate = \
                VideoTimingTable[u32Temp].VFreq;
            pstVideoCtx->stHdmirxTimingInfo.u32Vactive = HDMIRX_HAL_GetVactive(enPort);
          //  pstVideoCtx->stHdmirxTimingInfo.u32Hactive = HDMIRX_HAL_GetHactive()* enRate;
            pstVideoCtx->stHdmirxTimingInfo.u32Hactive = VideoTimingTable[u32Temp].strActive.H;
            if(pstVideoCtx->stHdmirxTimingInfo.u32Hdmi3dStructure == HDMIRX_3D_TYPE_SBS_FULL)
            {
                pstVideoCtx->stHdmirxTimingInfo.u32Hactive *=2;    
            }
           // printk("\nH:%d,Table H:%d\n",HDMIRX_HAL_GetHactive(),VideoTimingTable[u32Temp].strActive.H);
            return ;
        }
    }
    pstVideoCtx->stHdmirxTimingInfo.u32Vactive = 1;
    pstVideoCtx->stHdmirxTimingInfo.u32Hactive = 1;
    pstVideoCtx->stHdmirxTimingInfo.u32FrameRate = 1;
}
/* 
------------------------------------------------------------------------------
    Function:       HDMIRX_VIDEO_IsRepAllowed
    Description:    check the replication is allowed or not.
    Parameters:     u32Idx: timing index.
                    u32Rep: replication
    Returns:        True:   valid.
                    False:  not valid.
    Note:           1. called if mode change.
                    2. called if avi change.
-----------------------------------------------------------------------------
*/
static HI_BOOL HDMIRX_VIDEO_IsRepAllowed(HI_U32 u32Rep, HI_U32 u32Idx)
{
    HI_U32  u32TableIdx;
    HI_U32  u32TableRep;
    HI_BOOL bValid = HI_FALSE;
    
    if (u32Idx != TIMING_NOT_SUPPORT) 
    {
		// Resolution has been measured and AVI InfoFrame data is valid
		u32TableIdx = u32Idx & ~HDMI_3D_RESOLUTION_MASK;

		if(u32TableIdx < (TIMING_MAX + NMB_OF_HDMI_VIDEO_MODES))
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
/* 
------------------------------------------------------------------------------
    Function:       HDMIRX_VIDEO_GetDefaultRepetition
    Description:    get the default replication of special timing .
    Parameters:     u32Idx: timing index.
    Returns:        None
    Note:           1. called if mode change.
                    2. called if avi change.
-----------------------------------------------------------------------------
*/
static HI_U32 HDMIRX_VIDEO_GetDefaultRepetition(HI_U32 u32Idx)
{
	HI_U32 u32Rep = 0;

	// Note: no PC modes have repetition

	if( (TIMING_NOT_SUPPORT!= u32Idx) && (TIMING_PC_MODE != u32Idx) )
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
/* 
------------------------------------------------------------------------------
Function:      	HDMIRX_VIDEO_SetBlankLv
Description:    	Set the blank level regarding the input color space.
Parameters:    	enOutputColorSpace:  the color space of signal. 
                    u32Idx: timing index.
Returns:        	None
Note:           	1. called by SetVideoPath
				1. called if mode change.
                	2. called if avi change.
-----------------------------------------------------------------------------
*/
static HI_VOID HDMIRX_VIDEO_SetBlankLv
(HI_UNF_HDMIRX_PORT_E enPort,HDMIRX_OUTPUT_FORMAT_E enOutputColorSpace, HI_U32 u32Idx)
{
	HI_U32 blank_levels[3];

	// default are levels for RGB PC modes
	blank_levels[0] = 0;
	blank_levels[1] = 0;
	blank_levels[2] = 0;

	switch(enOutputColorSpace)
	{
	case PATH_RGB:
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
	case PATH_YCbCr444:
		// YCbCr 4:4:4
		blank_levels[0] = 0x80;
		blank_levels[1] = 0x10;
		blank_levels[2] = 0x80;
		break;
	case PATH_YCbCr422:
		// YCbCr 4:2:2
		blank_levels[0] = 0x00;
		blank_levels[1] = 0x10;
		blank_levels[2] = 0x80;
		break;
    default:
        break;
	}

    HDMIRX_HAL_SetBlankLv(enPort,blank_levels);
    if(HDMIRX_CTRL_IsNeedSubPort() == HI_TRUE)
    {
        HDMIRX_HAL_SetBlankLv(HDMIRX_CTRL_GetSubPort(),blank_levels);        
    }
}
/* 
------------------------------------------------------------------------------
    Function:       HDMIRX_VIDEO_SetOclkdivider
    Description:    sets output data restored to original clock or not.
                    if iclk/oclk more than 4x. it can not restore to original clk
    Parameters:     bMuxMode:   mux mode or not.
                    bRestoreOriPixClk:  restored to original clock.
                    u32PixRepl: replication
    Returns:        None
    Note:           1. called if mode change.
                    2. called if avi change.
-----------------------------------------------------------------------------
*/
static HI_VOID HDMIRX_VIDEO_SetOclkdivider(HI_UNF_HDMIRX_PORT_E enPort,HI_BOOL bRestoreOriPixClk, HI_U32 u32PixRepl)
{

	HI_U32 u32Cfg = HDMIRX_HAL_GetOclkCfg(enPort);

	u32Cfg &= ~(reg_iclk |reg_oclkdiv);    // clear bits of input and output dividers

	u32Cfg |= (u32PixRepl << 4);           // Set bits for input divider equal Pixel Replication
	 if(bRestoreOriPixClk == HI_TRUE)
	{
		u32Cfg |= (u32PixRepl << 6);   // Set bits for output divider to restore original pixel clock
	}
     
	HDMIRX_HAL_SetOclkCfg(enPort,u32Cfg);
    if(HDMIRX_CTRL_IsNeedSubPort() == HI_TRUE)
    {
        HDMIRX_HAL_SetOclkCfg(HDMIRX_CTRL_GetSubPort(),u32Cfg);
    }
}

/* 
------------------------------------------------------------------------------
Function:       HDMIRX_VIDEO_SetClockPath
Description:    sets parameters depending on video resolution.
Parameters:     u32OutFormat:   the output format. 
                u32Rep: replication
Returns:        None
Note:           1. called if mode change.
                2. called if avi change.
-----------------------------------------------------------------------------
*/
static HI_VOID HDMIRX_VIDEO_SetClockPath(HI_UNF_HDMIRX_PORT_E enPort,HI_U32 u32Rep, HI_U32 u32OutFormat)
{
	HI_BOOL bRestoreOriPixelClk = HI_TRUE;

	if(u32OutFormat & PASS_REPLICATED_PIXELS_MASK)
	{
        bRestoreOriPixelClk = HI_FALSE;
	}
	
	HDMIRX_VIDEO_SetOclkdivider(enPort,bRestoreOriPixelClk, u32Rep);

}

/* 
------------------------------------------------------------------------------
    Function:       HDMIRX_VIDEO_SetColorPath
    Description:    sets video options depending on input and output color spaces.
    Parameters:     output_format:  the output format. 
                    in_color_space: the color space of signal
                    colorimetry:    the color space of signal
                    pc_format:      pc mode.
    Returns:        None
    Note:           1. called if mode change.
                    2. called if avi change.
-----------------------------------------------------------------------------
*/
static HI_VOID HDMIRX_VIDEO_SetColorPath
(HI_UNF_HDMIRX_PORT_E enPort,HDMIRX_OUTPUT_FORMAT_E output_format, HDMIRX_COLOR_SPACE_E enInColorSpace )
{
	HI_U32 au32VideoFormatCfg[3];
    HDMIRX_OVERSAMPLE_E enReplication;
	au32VideoFormatCfg[0] = 0x00;
	au32VideoFormatCfg[1] = HDMIRX_HAL_GetDitherMode(enPort);
	au32VideoFormatCfg[2] = 0x00;

    enReplication = HDMIRX_PACKET_AVI_GetReplication();
	// for Deep Color featured RX chips
    output_format &= 0x3f;
    if (output_format == PATH_YCbCr422) 
	{
        // 422 10 and 12 bit per channel output
        au32VideoFormatCfg[2] &= ~reg_EnDither; // pass all bits to output without dithering
    }
    // For all output formats except YCbCr 422 which are able to carry more then 8 bit per channel
	// enable dithering.
	// Note, dithering mode will depend on 0x049.6 and 0x049.7 bits which are set separately.
    else 
	{
        au32VideoFormatCfg[2] |=  reg_EnDither; 
    }
    //将输入422输出改为444
    if((output_format == PATH_YCbCr444)&&(enInColorSpace == HDMIRX_COLOR_SPACE_YCBCR422))
    {
        au32VideoFormatCfg[2] |=  reg_EnUpSample;
    }

	// Chips without Deep Color support can dither to 8 bit only and the dithering mode is set
	// according to video_regs_49_4A table.
	 //将输入422输出改为444
	// au32VideoFormatCfg[0] &= ~reg_ExtBitMode;
    
	if (output_format == PATH_YCbCr422)
	{
  
        au32VideoFormatCfg[0] |=  reg_ExtBitMode; // enable receiving YCbCr 422 12bit per channel mode
	}
    else 
	{
        au32VideoFormatCfg[0] &= ~reg_ExtBitMode;
    }
#if 0//SUPPORT_STB
    if(output_format == PATH_YCbCr422)
    {
        au32VideoFormatCfg[2] |=  reg_EnDither;
        au32VideoFormatCfg[0] &= ~reg_ExtBitMode;
   //     au32VideoFormatCfg[1] = reg_clipinputisyc;
    }
    
    if((output_format == PATH_YCbCr422)&&(enInColorSpace == HDMIRX_COLOR_SPACE_YCBCR444))
    {
        au32VideoFormatCfg[2] |=  reg_EnDownSample;
    }
    if((output_format == PATH_YCbCr422)&&(enInColorSpace == HDMIRX_COLOR_SPACE_RGB))
    {
        au32VideoFormatCfg[2] |=  reg_EnDownSample;
        au32VideoFormatCfg[2] |=  reg_EnRGB2YCbCr;
     //   au32VideoFormatCfg[2] |=  reg_EnRGB2YCbCrRange;
    }
#endif    

    HDMIRX_HAL_SetOutFormat(enPort,au32VideoFormatCfg);
    HDMIRX_HAL_SetChannelMap(enPort,enInColorSpace,enReplication);
    if(HDMIRX_CTRL_IsNeedSubPort() == HI_TRUE)
    {
        HDMIRX_HAL_SetOutFormat(HDMIRX_CTRL_GetSubPort(),au32VideoFormatCfg);
        HDMIRX_HAL_SetChannelMap(HDMIRX_CTRL_GetSubPort(),enInColorSpace,enReplication);
    }
}

/* 
------------------------------------------------------------------------------
Function:       HDMIRX_VIDEO_SetVideoPath
Description:    set the configuaration in video according the color space of signal.
Parameters:     None
Returns:        None.
Note:           1. called by avi change.
                2. called by mode change.      
-----------------------------------------------------------------------------
*/
HI_VOID HDMIRX_VIDEO_SetVideoPath(HI_UNF_HDMIRX_PORT_E enPort)
{
    HI_U32              u32Idx;
    HI_U32              u32Replication;
    HDMIRX_COLOR_SPACE_E    enInColorSpace; 
    HDMIRX_OUTPUT_FORMAT_E  enOutPath;
    //HI_BOOL             bPcMode;
    //HI_U32              u32TableIdx;
    //HDMIRX_COLOR_METRY_E    enColorM;
    HI_BOOL             bAviValid, bRepAllowed;
    HDMIRX_VIDEO_CTX_S *pstVideoCtx;

    pstVideoCtx = HDMIRX_VIDEO_GET_CTX();
    u32Idx = pstVideoCtx->stHdmirxTimingInfo.enVideoIdx;
    // get the replication
    u32Replication = (HI_U32)HDMIRX_PACKET_AVI_GetReplication();
    
    // to check the avi and replication valid, if not, then get the default replication.
    bAviValid = HDMIRX_PACKET_AVI_IsDataValid();
    bRepAllowed = HDMIRX_VIDEO_IsRepAllowed(u32Replication, u32Idx);
    if((HI_FALSE == bRepAllowed) || (HI_FALSE == bAviValid)) 
    {
        u32Replication = HDMIRX_VIDEO_GetDefaultRepetition(u32Idx);
    }
   
    
    // get the color space of signal.  
    if(HDMIRX_VIDEO_GetHdmiMode(enPort) == HI_TRUE)
    {
        enInColorSpace = HDMIRX_PACKET_AVI_GetColorSpace();
    }
    else
    {
        enInColorSpace = HDMIRX_COLOR_SPACE_RGB;   
    }
    

    // set the output format.
    if (enInColorSpace == HDMIRX_COLOR_SPACE_RGB) 
    {
		enOutPath = PATH_RGB;
    }
	else if(enInColorSpace == HDMIRX_COLOR_SPACE_YCBCR422) 
	{
        //将输入422输出改为444
        if(u32Replication > HDMIRX_OVERSAMPLE_NONE)
       {
            enOutPath = PATH_YCbCr444;
        }
       else
        {
            enOutPath = PATH_YCbCr422;
        }
	}
	else 
	{
		enOutPath = PATH_YCbCr444;
	}
#if 0//SUPPORT_STB
    enOutPath = PATH_YCbCr422;     
#endif
    // set the blank level accroding the cs.
    if(enOutPath != PATH_BUTT)
    {
        HDMIRX_VIDEO_SetBlankLv(enPort,enOutPath, u32Idx);
    }
    
    enOutPath |= PASS_REPLICATED_PIXELS_MASK;


    // get the color Metry of signal
    //enColorM = HDMIRX_PACKET_AVI_GetColorMetry();
    // default is not pc mode.
//	bPcMode = HI_FALSE;
    /*
	if(TIMING_NOT_SUPPORT != u32Idx)
	{
        // the proc without any info of color metry.
        #if 0
        if(HDMIRX_COLOR_METRY_NoInfo == enColorM)
		{
			if(TIMING_PC_MODE == u32Idx)
			{
				enColorM = HDMIRX_COLOR_METRY_ITU601;
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
					enColorM = HDMIRX_COLOR_METRY_ITU601;
					break;
				default:
					enColorM = HDMIRX_COLOR_METRY_ITU709;
				}
			}
		}
        #endif
        
        // check pc mode
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
		
	}*/
	HDMIRX_VIDEO_SetColorPath(enPort,enOutPath, enInColorSpace/*, enColorM, bPcMode*/);
	HDMIRX_VIDEO_SetClockPath(enPort,u32Replication, enOutPath);
}
/* 
------------------------------------------------------------------------------
Function:       HDMIRX_VIDEO_HdmiDviTrans
Description:    the proc of hdmi/dvi transtions.
Parameters:     None
Returns:        None
Note:           1.just called once only if system power on 
-----------------------------------------------------------------------------
*/
HI_BOOL HDMIRX_VIDEO_HdmiDviTrans(HI_UNF_HDMIRX_PORT_E enPort)
{
    HDMIRX_VIDEO_CTX_S *pstVideoCtx;
    pstVideoCtx = HDMIRX_VIDEO_GET_CTX();
    
    if(pstVideoCtx->bHdmiMode != HDMIRX_VIDEO_GetHdmiMode(enPort))
    {
        
        pstVideoCtx->bHdmiMode = HDMIRX_VIDEO_GetHdmiMode(enPort);
    	if (pstVideoCtx->bHdmiMode == HI_TRUE) 
        {
            HDMIRX_HAL_ClearT4Error(enPort);
            if(HDMIRX_CTRL_IsNeedSubPort() == HI_TRUE)
            {
                HDMIRX_HAL_ClearT4Error(HDMIRX_CTRL_GetSubPort());
            }
        }
        else 
        {
            // forget all HDMI settings
            HDMIRX_HAL_SetResetEn(enPort,HDMIRX_SOFT_RST,HI_TRUE);
            if(HDMIRX_CTRL_IsNeedSubPort() == HI_TRUE)
            {
                HDMIRX_HAL_SetResetEn(HDMIRX_CTRL_GetSubPort(),HDMIRX_SOFT_RST,HI_TRUE);
            }
         //   HDMIRX_HAL_SetResetEn(HDMIRX_DC_FIFO_RST,HI_TRUE);
            msleep(10);
            HDMIRX_HAL_SetResetEn(enPort,HDMIRX_SOFT_RST,HI_FALSE);
         //   HDMIRX_HAL_SetResetEn(HDMIRX_DC_FIFO_RST,HI_FALSE);
            HDMIRX_PACKET_ResetData();
            HDMIRX_PACKET_AVI_SetNoAviIntEn(enPort,HI_FALSE);
            HDMIRX_HAL_SetOclkCfg(enPort,0x04);
            if(HDMIRX_CTRL_IsNeedSubPort() == HI_TRUE)
            {
                HDMIRX_HAL_SetResetEn(HDMIRX_CTRL_GetSubPort(),HDMIRX_SOFT_RST,HI_FALSE);
                HDMIRX_PACKET_AVI_SetNoAviIntEn(HDMIRX_CTRL_GetSubPort(),HI_FALSE);
                HDMIRX_HAL_SetOclkCfg(HDMIRX_CTRL_GetSubPort(),0x04);
            }
        }
        return HI_TRUE;
    }
    return HI_FALSE;
}

static HI_VOID HDMIRX_VIDEO_SetVresChgIntEn(HI_UNF_HDMIRX_PORT_E enPort,HI_BOOL bEn)
{
    HDMIRX_CTRL_SetShadowIntMask(HDMIRX_INTR5, reg_vres_chg, bEn);
    if(bEn == HI_TRUE)
	{
		//au32ShadowIntMask[4] |= reg_vres_chg;
        HDMIRX_HAL_SetInterruptEn(enPort,HDMIRX_INT_VRES_CHG, HI_TRUE);
        // clear V Resolution Change interrupt flag
		// as it could be set previously during 3D video processing
        HDMIRX_HAL_ClearInterrupt(enPort,HDMIRX_INT_VRES_CHG);
	}
	else
	{
		//au32ShadowIntMask[4] &= ~reg_vres_chg;
        HDMIRX_HAL_SetInterruptEn(enPort,HDMIRX_INT_VRES_CHG, HI_FALSE);
	}
}

HI_VOID HDMIRX_VIDEO_SetResChgEventsEn(HI_UNF_HDMIRX_PORT_E enPort,HI_BOOL bEn)
{
	// V Resolution Change interrupts cannot be used in 3D.
	HDMIRX_VIDEO_SetVresChgIntEn(enPort,!bEn);

	// Audio exception on V Resolution Change cannot be used in 3D.
	#if SUPPORT_AEC
	HDMIRX_HAL_SetResChangeAecEn(enPort,bEn);
    #endif
}

HI_VOID HDMIRX_VIDEO_Clear4k3dInfo(HI_VOID)
{
    HDMIRX_VIDEO_CTX_S *pstVideoCtx;
    pstVideoCtx = HDMIRX_VIDEO_GET_CTX();
    #if SUPPORT_4K_VIC
    pstVideoCtx->stHdmirxTimingInfo.u32HdmiVic = 0;
    #endif
    pstVideoCtx->stHdmirxTimingInfo.u32Hdmi3dStructure = 0;
    pstVideoCtx->stHdmirxTimingInfo.u32Hdmi3dExtData = 0;
}
HI_VOID HDMIRX_VIDEO_Verify1P4Format(HI_UNF_HDMIRX_PORT_E enPort,HI_BOOL bVsifReceived)
{
    HDMIRX_CTRL_ModeChgAdd(HDMIRX_MODECHG_TYPE_VSIFCHG);
    HDMIRX_CTRL_ModeChange();
	HDMIRX_CTRL_ChangeState(HDMIRX_STATE_WAIT);
   	HDMIRX_VIDEO_SetResChgEventsEn(enPort,bVsifReceived);
    if(HDMIRX_CTRL_IsNeedSubPort() == HI_TRUE)
    {
        HDMIRX_VIDEO_SetResChgEventsEn(HDMIRX_CTRL_GetSubPort(),bVsifReceived);
    }
}
HI_VOID HDMIRX_VIDEO_SetVideoIdx(VIDEO_TIMING_IDX_E enIdx)
{
    HDMIRX_VIDEO_CTX_S *pstVideoCtx;

    pstVideoCtx = HDMIRX_VIDEO_GET_CTX();
    pstVideoCtx->stHdmirxTimingInfo.enVideoIdx = enIdx;
}
HI_VOID HDMIRX_VIDEO_Set861Vic(HI_U32 u32Vic)
{
    HDMIRX_VIDEO_CTX_S *pstVideoCtx;

    pstVideoCtx = HDMIRX_VIDEO_GET_CTX();
    pstVideoCtx->stHdmirxTimingInfo.u32Cea861Vic = u32Vic;
}
HDMIRX_3D_TYPE_E HDMIRX_VIDEO_GetCur3dStructure(HI_VOID)
{
    HDMIRX_VIDEO_CTX_S *pstVideoCtx;

    pstVideoCtx = HDMIRX_VIDEO_GET_CTX();
    
    return pstVideoCtx->stHdmirxTimingInfo.u32Hdmi3dStructure;
}
HI_U32 HDMIRX_VIDEO_GetCur3dExtData(HI_VOID)
{
    HDMIRX_VIDEO_CTX_S *pstVideoCtx;

    pstVideoCtx = HDMIRX_VIDEO_GET_CTX();
    
    return pstVideoCtx->stHdmirxTimingInfo.u32Hdmi3dExtData;
}
#if SUPPORT_4K_VIC
HI_U32 HDMIRX_VIDEO_GetCurHdmiVic(HI_VOID)
{
    HDMIRX_VIDEO_CTX_S *pstVideoCtx;

    pstVideoCtx = HDMIRX_VIDEO_GET_CTX();
    
    return pstVideoCtx->stHdmirxTimingInfo.u32HdmiVic;
}
HI_VOID HDMIRX_VIDEO_SetCurHdmiVic(HI_U32 u32Vic)
{
    HDMIRX_VIDEO_CTX_S *pstVideoCtx;

    pstVideoCtx = HDMIRX_VIDEO_GET_CTX();
    
    pstVideoCtx->stHdmirxTimingInfo.u32HdmiVic = u32Vic;
}
#endif
HI_VOID HDMIRX_VIDEO_SetCur3dExtData(HI_U32 u32TdExtData)
{
    HDMIRX_VIDEO_CTX_S *pstVideoCtx;

    pstVideoCtx = HDMIRX_VIDEO_GET_CTX();
    
    pstVideoCtx->stHdmirxTimingInfo.u32Hdmi3dExtData = u32TdExtData;
}
HI_VOID HDMIRX_VIDEO_SetCur3dStructure(HDMIRX_3D_TYPE_E enStructure)
{
    HDMIRX_VIDEO_CTX_S *pstVideoCtx;

    pstVideoCtx = HDMIRX_VIDEO_GET_CTX();
    
    pstVideoCtx->stHdmirxTimingInfo.u32Hdmi3dStructure = enStructure;
}
HI_U32 HDMIRX_VIDEO_GetPixelClk(HI_VOID)
{
    HDMIRX_VIDEO_CTX_S *pstVideoCtx;

    pstVideoCtx = HDMIRX_VIDEO_GET_CTX();
    
    return pstVideoCtx->stHdmirxTimingInfo.u32PixFreq;
}
HDMIRX_INPUT_WIDTH_E HDMIRX_VIDEO_GetInputWidth(HI_VOID)
{
    HDMIRX_VIDEO_CTX_S *pstVideoCtx;

    pstVideoCtx = HDMIRX_VIDEO_GET_CTX();
    
    return pstVideoCtx->enInputWidth;
}

HI_U32 HDMIRX_VIDEO_GetFrameRate(HI_VOID)
{
    HI_U32 u32Rate = 1;
    HI_U32 u32Temp;
    HDMIRX_VIDEO_CTX_S *pstVideoCtx;

    pstVideoCtx = HDMIRX_VIDEO_GET_CTX();
    if(pstVideoCtx->stHdmirxTimingInfo.enVideoIdx < TIMING_MAX+NMB_OF_HDMI_VIDEO_MODES )
    {
        u32Rate = VideoTimingTable[pstVideoCtx->stHdmirxTimingInfo.enVideoIdx].VFreq;
    }
    else if(pstVideoCtx->stHdmirxTimingInfo.enVideoIdx == TIMING_PC_MODE)
    {
        u32Rate = pstVideoCtx->stHdmirxTimingInfo.u32PixFreq;
        u32Temp = pstVideoCtx->stHdmirxTimingInfo.u32Vtotal*pstVideoCtx->stHdmirxTimingInfo.u32Htotal;
        u32Rate *= 10000;
        u32Rate = (u32Rate + u32Temp-1)/u32Temp;
        if ((u32Rate <= 31) && (u32Rate >= 29))
        {
            u32Rate = 30;
        }
        else if ((u32Rate <= 51) && (u32Rate >= 49))
        {
            u32Rate = 50;
        }
        else if ((u32Rate <= 57) && (u32Rate >= 55))
        {
            u32Rate = 56;
        }
        else if ((u32Rate <= 61) && (u32Rate >= 59))
        {
            u32Rate = 60;
        }
        else if ((u32Rate <= 68) && (u32Rate >= 65))
        {
            u32Rate = 67;
        }
        else if ((u32Rate <= 71) && (u32Rate >= 69))
        {
            u32Rate = 70;
        }
        else if ((u32Rate <= 73) && (u32Rate >= 71))
        {
            u32Rate = 72;
        }
        else if ((u32Rate <= 76) && (u32Rate >= 74))
        {
            u32Rate = 75;
        }
        else if ((u32Rate <= 86) && (u32Rate >= 84))
        {
            u32Rate = 85;
        }

    }
    else if(pstVideoCtx->stHdmirxTimingInfo.enVideoIdx & HDMI_3D_RESOLUTION_MASK)
    {
        if((pstVideoCtx->stHdmirxTimingInfo.enVideoIdx - HDMI_3D_RESOLUTION_MASK)< (TIMING_MAX + NMB_OF_HDMI_VIDEO_MODES + 1))
        {
            u32Rate = VideoTimingTable[pstVideoCtx->stHdmirxTimingInfo.enVideoIdx - HDMI_3D_RESOLUTION_MASK].VFreq;
        }
    }
    
    return u32Rate;
}
HI_U32 HDMIRX_VIDEO_GetHactive(HI_VOID)
{
    HDMIRX_VIDEO_CTX_S *pstVideoCtx;

    pstVideoCtx = HDMIRX_VIDEO_GET_CTX();

    return pstVideoCtx->stHdmirxTimingInfo.u32Hactive;
}

HI_U32 HDMIRX_VIDEO_GetVactive(HI_VOID)
{
    HDMIRX_VIDEO_CTX_S *pstVideoCtx;

    pstVideoCtx = HDMIRX_VIDEO_GET_CTX();

    return pstVideoCtx->stHdmirxTimingInfo.u32Vactive;
}
 
HI_BOOL HDMIRX_VIDEO_IsTimingActive(HI_VOID)
{
    HDMIRX_VIDEO_CTX_S *pstVideoCtx;
    HI_U32          u32TimingIdx;
    HDMIRX_OVERSAMPLE_E enOverSample;
    HI_U32 u32FrameRate;
    HI_U32 u32Width;

    pstVideoCtx = HDMIRX_VIDEO_GET_CTX();    
    u32TimingIdx = pstVideoCtx->stHdmirxTimingInfo.enVideoIdx;    
    enOverSample = HDMIRX_PACKET_AVI_GetReplication();
    u32FrameRate = HDMIRX_VIDEO_GetFrameRate();
    u32Width = pstVideoCtx->stHdmirxTimingInfo.u32Hactive;
    switch(enOverSample)
    {
        case HDMIRX_OVERSAMPLE_2X:
            u32Width >>= 1;
            break;
        case HDMIRX_OVERSAMPLE_4X:
            u32Width >>= 2;
            break;
        default:               
            break;
    }
    if((u32TimingIdx < TIMING_MAX) &&(u32Width > 2000))
        return HI_FALSE;
    else if(u32FrameRate > 90)
        return HI_FALSE;
    else
        return HI_TRUE;
       
}

HI_VOID HDMIRX_VIDEO_GetTableInfo(HI_U32 u32id , VIDEO_TIMING_DEFINE_S * pstTableInfo)
{
    memcpy(pstTableInfo , &VideoTimingTable[u32id] , sizeof(VIDEO_TIMING_DEFINE_S));   
}
 
HI_VOID HDMIRX_VIDEO_GetTimingInfo(HI_UNF_HDMIRX_TIMING_INFO_S *pstTimingInfo)
{
    //HI_U32 u32Temp;
    HDMIRX_OVERSAMPLE_E enOverSample;
    HDMIRX_RGB_RANGE_E enRGBRange;
    HDMIRX_COLOR_SPACE_E enColorSpace;
    HDMIRX_VIDEO_CTX_S *pstVideoCtx;
    HI_UNF_HDMIRX_PORT_E enport;
    
    enport = HDMIRX_CTRL_GetCurPort();
    pstVideoCtx = HDMIRX_VIDEO_GET_CTX();

   //  printk("\nin GetTiming H:%d,state:%d\n",HDMIRX_HAL_GetHactive(),HDMIRX_DRV_CTRL_GetState());
    //------------------------------------------------------------
#if SUPPORT_MHL
        pstTimingInfo->bMHL= HDMIRX_MHL_SignalEnable();
#endif 
    if(pstVideoCtx->bHdmiMode == HI_TRUE)
    {
        pstTimingInfo->bHdmiMode = HI_TRUE;
    }
    else
    {
        pstTimingInfo->bHdmiMode = HI_FALSE;
    }
    //pstTimingInfo->bHdmiMode = pstVideoCtx->bHdmiMode;
    //--------------------------------------------------------------------
    if(enport != HI_UNF_HDMIRX_PORT_BUTT)
    {
        pstTimingInfo->bInterlace = HDMIRX_HAL_GetInterlance(enport);                    
    }
    else
    {
        pstTimingInfo->bInterlace = HI_FALSE;
    }
    //3D 信号无法识别 Interlace
    if(pstVideoCtx->stHdmirxTimingInfo.enVideoIdx & HDMI_3D_RESOLUTION_MASK)
    {
    pstTimingInfo->bInterlace = VideoTimingTable[pstVideoCtx->stHdmirxTimingInfo.enVideoIdx & ~HDMI_3D_RESOLUTION_MASK].Interlaced;
    }
    //-------------------------------------------------------------------------------
    if(pstVideoCtx->stHdmirxTimingInfo.enVideoIdx == TIMING_PC_MODE)
    {
        pstTimingInfo->bPcMode = HI_TRUE;
    }
    else
    {
        pstTimingInfo->bPcMode = HI_FALSE;
    }
    //--------------------------------------------------------------------------------
    pstTimingInfo->u32Height = pstVideoCtx->stHdmirxTimingInfo.u32Vactive;
    pstTimingInfo->u32Width = pstVideoCtx->stHdmirxTimingInfo.u32Hactive;
    //-------------------------------------------------------------------------------------
    pstTimingInfo->u32FrameRate = HDMIRX_VIDEO_GetFrameRate();
    pstTimingInfo->u32TimingIdx = pstVideoCtx->stHdmirxTimingInfo.enVideoIdx;
    if(pstVideoCtx->bHdmiMode == HI_FALSE)
    {
        pstTimingInfo->enColorSpace = HI_UNF_COLOR_SPACE_BT709_RGB_FULL;
        pstTimingInfo->enBitWidth = HI_UNF_PIXEL_BITWIDTH_8BIT;
        pstTimingInfo->enOversample = HI_UNF_OVERSAMPLE_1X;
        pstTimingInfo->enPixelFmt = HI_UNF_FORMAT_RGB_SEMIPLANAR_444;
        pstTimingInfo->en3dFmt = HI_UNF_FRAME_PACKING_TYPE_NONE;
        pstTimingInfo->u32Vblank = 0;
    }
    else
    {

        //------------------------------------------------------------------------------------------
        enColorSpace = HDMIRX_PACKET_AVI_GetColorSpace();
        enRGBRange = HDMIRX_PACKET_AVI_GetRGBRange();
        if((enColorSpace == HDMIRX_COLOR_SPACE_YCBCR422) || (enColorSpace == HDMIRX_COLOR_SPACE_YCBCR444))
        {
            if(HDMIRX_PACKET_AVI_GetColorMetry() == HDMIRX_COLOR_METRY_ITU601)
            {
                pstTimingInfo->enColorSpace = HI_UNF_COLOR_SPACE_BT601_YUV_LIMITED;
            }
            else if(HDMIRX_PACKET_AVI_GetColorMetry() == HDMIRX_COLOR_METRY_ITU709)
            {
                pstTimingInfo->enColorSpace = HI_UNF_COLOR_SPACE_BT709_YUV_LIMITED;
            }
            else if(pstTimingInfo->u32Height < 720)
            {
                pstTimingInfo->enColorSpace = HI_UNF_COLOR_SPACE_BT601_YUV_LIMITED;
            }
            else
            {
                pstTimingInfo->enColorSpace = HI_UNF_COLOR_SPACE_BT709_YUV_LIMITED;
            }
        }
        else if(enColorSpace == HDMIRX_COLOR_SPACE_RGB)
        {
            //pstTimingInfo->enColorSpace = HI_UNF_COLOR_SPACE_RGB;
            if(enRGBRange == HDMIRX_RGB_FULL_RANGE)
            {
                pstTimingInfo->enColorSpace = HI_UNF_COLOR_SPACE_BT709_RGB_FULL;
            }
            else
            {
                pstTimingInfo->enColorSpace = HI_UNF_COLOR_SPACE_BT709_RGB_LIMITED;
            }
        }
        else if(pstVideoCtx->stHdmirxTimingInfo.enVideoIdx < TIMING_MAX)
        {
            if(pstTimingInfo->u32Height < 720)
            {
                pstTimingInfo->enColorSpace = HI_UNF_COLOR_SPACE_BT601_YUV_LIMITED;
            }
            else
            {
                pstTimingInfo->enColorSpace = HI_UNF_COLOR_SPACE_BT709_YUV_LIMITED;
            }
        }
        else if(pstVideoCtx->stHdmirxTimingInfo.enVideoIdx == TIMING_PC_MODE)
        {
            pstTimingInfo->enColorSpace = HI_UNF_COLOR_SPACE_BT709_RGB_FULL;
        }
        
        //------------------------------------------------------------------------------------------
          
         if(enColorSpace == HDMIRX_COLOR_SPACE_RGB)
         {
            if(enRGBRange == HDMIRX_RGB_LIMIT_RANGE)
            {
                pstTimingInfo->enRGBRange = HI_UNF_RGB_LIMIT_RANGE;
            }
            else if(enRGBRange == HDMIRX_RGB_FULL_RANGE)
            {
                pstTimingInfo->enRGBRange = HI_UNF_RGB_FULL_RANGE;
            }
            else
            {
                if((pstTimingInfo->bPcMode)||(pstVideoCtx->stHdmirxTimingInfo.enVideoIdx == Timing_1_640x480p))
                {
                    pstTimingInfo->enRGBRange = HI_UNF_RGB_FULL_RANGE;
                }
                else
                {
                    pstTimingInfo->enRGBRange = HI_UNF_RGB_LIMIT_RANGE;
                }
                
            }
         }
         else
         {
            pstTimingInfo->enRGBRange = HI_UNF_RGB_LIMIT_RANGE;
         }
        //-----------------------------------------------------------------------------
        switch(pstVideoCtx->enInputWidth)
        {
            case HDMIRX_INPUT_WIDTH_24:
                pstTimingInfo->enBitWidth = HI_UNF_PIXEL_BITWIDTH_8BIT;
                break;
            case HDMIRX_INPUT_WIDTH_30:
                pstTimingInfo->enBitWidth = HI_UNF_PIXEL_BITWIDTH_10BIT;
                break;
            case HDMIRX_INPUT_WIDTH_36:
                pstTimingInfo->enBitWidth = HI_UNF_PIXEL_BITWIDTH_12BIT;
                break;
            default:
                pstTimingInfo->enBitWidth = HI_UNF_PIXEL_BITWIDTH_8BIT;
                break;
        }
        //------------------------------------------------------------------------        
        enOverSample = HDMIRX_PACKET_AVI_GetReplication();
        switch(enOverSample)
        {
            case HDMIRX_OVERSAMPLE_2X:
                pstTimingInfo->enOversample = HI_UNF_OVERSAMPLE_2X;
                pstTimingInfo->u32Width >>= 1;
                break;
            case HDMIRX_OVERSAMPLE_4X:
                pstTimingInfo->enOversample = HI_UNF_OVERSAMPLE_4X;
                pstTimingInfo->u32Width >>= 2;
                break;
            default:
                pstTimingInfo->enOversample = HI_UNF_OVERSAMPLE_1X;
                break;
        }
        //---------------------------------------------------------------------------------
        pstTimingInfo->enPixelFmt =  HI_UNF_FORMAT_YUV_SEMIPLANAR_444;
        //enColorSpace = HDMIRX_PACKET_AVI_GetColorSpace();
        if(enColorSpace == HDMIRX_COLOR_SPACE_YCBCR422)
        {
            //将输入422输出改为444
            if(enOverSample > HDMIRX_OVERSAMPLE_NONE)
            {
                pstTimingInfo->enPixelFmt = HI_UNF_FORMAT_YUV_SEMIPLANAR_444;
            }
            else
            {
                pstTimingInfo->enPixelFmt = HI_UNF_FORMAT_YUV_SEMIPLANAR_422;
            }
        }
        else if(enColorSpace == HDMIRX_COLOR_SPACE_YCBCR444)
        {
            pstTimingInfo->enPixelFmt = HI_UNF_FORMAT_YUV_SEMIPLANAR_444;
        }
        else if(enColorSpace == HDMIRX_COLOR_SPACE_RGB)
        {
            pstTimingInfo->enPixelFmt = HI_UNF_FORMAT_RGB_SEMIPLANAR_444;
        }
        //---------------------------------------------------------------------------------
        pstTimingInfo->en3dFmt = HI_UNF_FRAME_PACKING_TYPE_NONE;
        pstTimingInfo->u32Vblank = 0;
        if(HDMIRX_PACKET_VSIF_IsGot3d() == HI_TRUE)
        {
            switch(pstVideoCtx->stHdmirxTimingInfo.u32Hdmi3dStructure)
            {
               case  HDMIRX_3D_TYPE_FP:
                pstTimingInfo->en3dFmt = HI_UNF_FRAME_PACKING_TYPE_FRAME_PACKING;
                break;
               case HDMIRX_3D_TYPE_SBS_FULL:
               case HDMIRX_3D_TYPE_SBS_HALF:
                pstTimingInfo->en3dFmt = HI_UNF_FRAME_PACKING_TYPE_SIDE_BY_SIDE;
                break;
               case HDMIRX_3D_TYPE_TB:
                pstTimingInfo->en3dFmt = HI_UNF_FRAME_PACKING_TYPE_TOP_AND_BOTTOM;
                break;
               case HDMIRX_3D_TYPE_FIELD_ALT:
                pstTimingInfo->en3dFmt = HI_UNF_FRAME_PACKING_TYPE_TIME_INTERLACED;
                break;
               default:
                pstTimingInfo->en3dFmt = HI_UNF_FRAME_PACKING_TYPE_NONE;
                break;
            }
            //-----------------------------------------------------------------------------------------
            if(pstTimingInfo->en3dFmt == HI_UNF_FRAME_PACKING_TYPE_FRAME_PACKING)
            {
                if(((pstVideoCtx->stHdmirxTimingInfo.enVideoIdx - HDMI_3D_RESOLUTION_MASK) \
                    < TIMING_MAX) && \
                    (pstVideoCtx->stHdmirxTimingInfo.enVideoIdx & HDMI_3D_RESOLUTION_MASK))
                {
                    pstTimingInfo->u32Vblank = \
                        VideoTimingTable[pstVideoCtx->stHdmirxTimingInfo.enVideoIdx - HDMI_3D_RESOLUTION_MASK].strBlank.V;
                }
                #if 0
                else
                {
                    pstTimingInfo->u32Vblank = 0;
                }
                #endif
            }
            else if((pstTimingInfo->en3dFmt == HI_UNF_FRAME_PACKING_TYPE_SIDE_BY_SIDE)||(pstTimingInfo->en3dFmt == HI_UNF_FRAME_PACKING_TYPE_TOP_AND_BOTTOM))
            {
                if(pstTimingInfo->bInterlace ==  HI_TRUE)
                {
                    pstTimingInfo->u32Height *=2;                    
                }
            }
          
          
        }
        #if 0
        else
        {
            pstTimingInfo->u32Vblank = 0;
        }
        #endif
        
    }
    
    
}
#ifdef __cplusplus
 #if __cplusplus
}
 #endif
#endif /* __cplusplus */


