/******************************************************************************

  Copyright (C), 2012-2014, Hisilicon Tech. Co., Ltd.

 ******************************************************************************
  File Name     : ademod_regs.h
  Version       : Initial Draft
  Author        : Hisilicon multimedia software group
  Created       : 2012/11/05
  Description   : 
  History       :
  1.Date        : 2012/11/05
    Author      : m00196336
    Modification: Created file
******************************************************************************/
#ifndef __ADEMOD_REG_H__
#define __ADEMOD_REG_H__

#ifdef __cplusplus
#if __cplusplus
extern "C"{
#endif
#endif /* End of #ifdef __cplusplus */

#pragma pack(1) //one byte align

/*OverView:
*	Start	End		Description
*	0x00  ~  0x3F	General
*	0x40  ~  0x5F	Automatic Audio Output Select
*	0x60  ~  0x7F	Reserved
*	0x80  ~  0x8F	Automatic System	Detection
*	0x90  ~  0x9F	Automatic Volume 	Correction
*/

/**********************************************************************************/
/***********************Interrupt Demodulator Registers****************************/
/**********************************************************************************/
#define ADEMOD_REG_INTR_RAW                 0x100   /*interrupt raw offset addr:0x400*/
#define ADEMOD_REG_INTR_STATUS              0x101   /*interrupt raw offset addr:0x404*/
#define ADEMOD_REG_INTR_EN                  0x102   /*interrupt raw offset addr:0x408*/
#define ADEMOD_REG_INTR_CLR                 0x103   /*interrupt raw offset addr:0x40c*/

/**********************************************************************************/
/***********************Audio Demodulator Register Offset**************************/
/**********************************************************************************/
#define ADEMOD_REG_SYS_SEL                  0x00    /*ASD select/Mannual setting(read only)*/
#define ADEMOD_REG_STAND_SEL                0x01    /*when select BTSC mono/stereo or mono/SAP, this register must be set*/
#define ADEMOD_REG_SAMP_RATE                0x02    /*set sample rate*/
#define ADEMOD_REG_AAOS_CTL                 0x09    /*set the Left/Right channel signal select, 6.5MHZ,4.5MHZ*/
#define ADEMOD_REG_ASCS_CTL                 0x2E    /*(0x2E) Stereo Carrier Search Control  */ 
#define ADEMOD_REG_MUTE_CTL                 0x41    /*(0x41) Mute Control Register   */
#define ADEMOD_REG_ASD_CTL                  0x80    /*(0x80) Automatic System Detect Control Register   */

#define ADEMOD_REG_DEMOD1_CTL               0x03    /*Demod 1 Deviation Control*/
#define ADEMOD_REG_DEMOD1_FREQ_H            0x04    /*Demod 1 Carrier Frequency Register,0x04-0x05 */
#define ADEMOD_REG_DEMOD1_FREQ_L            0x05    /*Demod 1 Carrier Frequency Register,0x04-0x05 */
#define ADEMOD_REG_DEMOD2_CTL               0x06    /*Demod 2 Deviation Control*/
#define ADEMOD_REG_DEMOD2_FREQ_H            0x07    /*Demod 2 Carrier Frequency Register,0x07-0x08 */
#define ADEMOD_REG_DEMOD2_FREQ_L            0x08    /*Demod 2 Carrier Frequency Register,0x07-0x08 */

#define ADEMOD_REG_NICAM_CTL_H              0x22    /*(0x22 – 0x23) NICAM Control Bits Register */ 
#define ADEMOD_REG_NICAM_CTL_L              0x23    /*(0x22 – 0x23) NICAM Control Bits Register */ 
#define ADEMOD_REG_AGC_CTL                  0x24    /*(0x24) AGC Control */ 
#define ADEMOD_REG_AGC_CTL_AM               0x25    /*(0x25) AGC Control for AM  */ 
#define ADEMOD_REG_PILOT_CTL                0x26    /*(0x26) Pilot Control  */ 
#define ADEMOD_REG_STATUS_PIN_CTL           0x2B    /*(0x2B) Status Pin Control,RW*/ 
#define ADEMOD_REG_AD_HEADROOM              0x2C    /*(0x2C) A/D Headroom*/ 
#define ADEMOD_REG_AGC_FREEZE_CTL           0x2D    /*(0x2D) AGC Freeze Control */ 

#define ADEMOD_REG_AAOS_QUAL_THD_H_1        0x4A    /*(0x4A) Carrier 1 Quality AAOS Threshold High Register  */
#define ADEMOD_REG_AAOS_QUAL_THD_L_1        0x4B    /*(0x4B) Carrier 1 Quality AAOS Threshold Low Register */
#define ADEMOD_REG_AAOS_QUAL_THD_H_2        0x4C    /*(0x4C) Carrier 2 Quality AAOS Threshold High Register  */
#define ADEMOD_REG_AAOS_QUAL_THD_L_2        0x4D    /*(0x4D) Carrier 2 Quality AAOS Threshold Low Register  */
#define ADEMOD_REG_AAOS_PHASENOISE_THD_H_1  0x4E    /*(0x4E) Carrier 1 Phase Noise AAOS Threshold High Register*/
#define ADEMOD_REG_AAOS_PHASENOISE_THD_L_1  0x4F    /*(0x4F) Carrier 1 Phase Noise AAOS Threshold Low Register*/
#define ADEMOD_REG_AAOS_FM_SUBC_MAG_THD_H   0x50    /*(0x50 – 0x51) FM Subcarrier Magnitude AAOS Threshold High & Low Registers */
#define ADEMOD_REG_AAOS_FM_SUBC_MAG_THD_L   0x51    /*(0x50 – 0x51) FM Subcarrier Magnitude AAOS Threshold High & Low Registers */
#define ADEMOD_REG_AAOS_FM_SUBC_NOISE_THD_H 0x52    /*(0x52 – 0x53) FM Subcarrier Noise AAOS Threshold High & Low Registers */
#define ADEMOD_REG_AAOS_FM_SUBC_NOISE_THD_L 0x53    /*(0x52 – 0x53) FM Subcarrier Noise AAOS Threshold High & Low Registers */
#define ADEMOD_REG_AAOS_NICAM_ER_THD_H      0x54    /*(0x54) NICAM Error Rate AAOS Threshold High Register */
#define ADEMOD_REG_AAOS_NICAM_ER_THD_L      0x55    /*(0x55) NICAM Error Rate AAOS Threshold Low Register */  
#define ADEMOD_REG_AAOS_PILOT_MAG_THD_H     0x56    /*(0x56) Pilot Magnitude AAOS Threshold High Register */
#define ADEMOD_REG_AAOS_PILOT_MAG_THD_L     0x57    /*(0x57) Pilot Magnitude AAOS Threshold Low Register  */
#define ADEMOD_REG_AAOS_HIGH_QUAL_THD_H     0x58    /*(0x58) Carrier 1 High Quality AAOS Threshold High Register */
#define ADEMOD_REG_AAOS_HIGH_QUAL_THD_L     0x59    /*(0x59) Carrier 1 High Quality AAOS Threshold Low Register */
#define ADEMOD_REG_ID_MAG_THD_H             0x5A    /*(0x5A) ID Magnitude Threshold High Register  */
#define ADEMOD_REG_ID_MAG_THD_L             0x5B    /*(0x5B) ID Magnitude Threshold Low Register  */

#define ADEMOD_REG_CARRIER_MAG_THD          0x81    /*(0x81) Carrier Magnitude Threshold  */
#define ADEMOD_REG_CARRIER_AVERAGE_FREQ_THD 0x82    /*(0x82) Carrier Average Frequency Threshold  */
#define ADEMOD_REG_ASD_FM_QUAL_CARRIER      0x83    /*(0x83) Carrier FM Quality ASD Threshold   */
#define ADEMOD_REG_ASD_AM_NOISE             0x84    /*(0x84) Carrier AM Noise ASD Threshold   */
#define ADEMOD_REG_ASD_NICAM_NOISE          0x85    /*(0x85) NICAM Noise ASD Threshold   */
#define ADEMOD_REG_NICAM_NOISE_H            0x8A    /*(0x8A – 0x8B) NICAM Noise   */
#define ADEMOD_REG_NICAM_NOISE_L            0x8B    /*(0x8A – 0x8B) NICAM Noise   */
#define ADEMOD_REG_ASCS_FM_QUAL_THD         0x8D    /*(0x8D) Carrier FM Quality SCS Threshold */
#define ADEMOD_REG_ASCS_NICAM_NOISE_THD     0x8E    /*(0x8E) NICAM Noise SCS Threshold    */

#define ADEMOD_REG_AVC_CTL                  0x90    /*(0x90) Automatic Volume Correction    */
#define ADEMOD_REG_LEVEL_PRE_CTL            0x91    /*(0x91) Level Prescaler Control */
#define ADEMOD_REG_LEVEL_PRE_LEFT_CTL       0x92    /*(0x92) Prescaler Level Left Channel */
#define ADEMOD_REG_LEVEL_PRE_RIGHT_CTL      0x93    /*(0x93) Prescaler Level Right Channel  */
#define ADEMOD_REG_MANUAL_OUT_LEVEL_LEFT    0x94    /*(0x94) Manual Output Level Left Channel */
#define ADEMOD_REG_MANUAL_OUT_LEVEL_RIGHT   0x95    /*(0x95) Manual Output Level Right Channel */
#define ADEMOD_REG_AVC_LEVEL_THD            0x96    /*(0x96 – 0x97) AVC Level Thresholds High & Low  */
#define ADEMOD_REG_NCAM_AMONO_PRE           0x98    /*(0x98) NICAM Analog Mono Prescaler Level */
#define ADEMOD_REG_NICAM_PRE                0x99    /*(0x99) NICAM Prescaler Level  */
#define ADEMOD_REG_A2_PRE_LEVEL             0x9A    /*(0x9A) A2 Prescaler Level  */
#define ADEMOD_REG_LEGACY_LEVEL_CTL         0x9B    /*(0x9B) Legacy Levels Control */

#define ADEMOD_REG_SIF_DROP_CTL             0xAA    /*(0xAA) SIF Drop Interpolation Control  */

#define ADEMOD_REG_MODE_DET                 0x0A    /*mono/biligual/stereo*/
#define ADEMOD_REG_STATUS                   0x2A    /*(0x2A) Status,ASDComplete/BiSAP/Primary Carrier,etc. */ 
#define ADEMOD_REG_ASCS_RESULT              0x2F    /*(0x2F) Stereo Carrier Search Result  */ 
#define ADEMOD_REG_AAOS_RESULT              0x40    /*(0x40) Audio Output Result Register, read left/right channel signal status  */

#define ADEMOD_REG_AVERAGE_FREQ_1_H         0x0C    /*(0x0C – 0x0D) Carrier 1 Average Frequency Register */
#define ADEMOD_REG_AVERAGE_FREQ_1_L         0x0D    /*(0x0C – 0x0D) Carrier 1 Average Frequency Register */
#define ADEMOD_REG_PHASE_NOISE_1_H          0x0E    /*(0x0E – 0x0F) Carrier 1 Phase Noise Register */
#define ADEMOD_REG_PHASE_NOISE_1_L          0x0F    /*(0x0E – 0x0F) Carrier 1 Phase Noise Register */
#define ADEMOD_REG_AVERAGE_MAG_1_H          0x10    /*(0x10 – 0x11) Carrier 1 Average Magnitude Register */
#define ADEMOD_REG_AVERAGE_MAG_1_L          0x11    /*(0x10 – 0x11) Carrier 1 Average Magnitude Register */
#define ADEMOD_REG_MAG_NOISE_1_H            0x12    /*(0x12 – 0x13) Carrier 1 Magnitude Noise Register */
#define ADEMOD_REG_MAG_NOISE_1_L            0x13    /*(0x12 – 0x13) Carrier 1 Magnitude Noise Register */
#define ADEMOD_REG_FM_QUAL_1_H              0x14    /*(0x14 – 0x15) Carrier 1 FM Quality Register */
#define ADEMOD_REG_FM_QUAL_1_L              0x15    /*(0x14 – 0x15) Carrier 1 FM Quality Register */
#define ADEMOD_REG_AVERAGE_MAG_2_H          0x16    /*(0x16 – 0x17) Carrier 2 Average Magnitude Register */
#define ADEMOD_REG_AVERAGE_MAG_2_L          0x17    /*(0x16 – 0x17) Carrier 2 Average Magnitude Register */
#define ADEMOD_REG_MAG_NOISE_2_H            0x18    /*(0x18 – 0x19) Carrier 2 Magnitude Noise Register */
#define ADEMOD_REG_MAG_NOISE_2_L            0x19    /*(0x18 – 0x19) Carrier 2 Magnitude Noise Register */
#define ADEMOD_REG_FM_QUAL_2_H              0x1A    /*(0x1A – 0x1B) Carrier 2 FM Quality Register*/
#define ADEMOD_REG_FM_QUAL_2_L              0x1B    /*(0x1A – 0x1B) Carrier 2 FM Quality Register*/
#define ADEMOD_REG_PILOT_MAG                0x1C    /*(0x1C) Pilot Magnitude Register */
#define ADEMOD_REG_PLL_STATUS               0x1D    /*(0x1D) Pilot PLL Status Register */
#define ADEMOD_REG_FM_SUBCARRIER_MAG        0x1E    /*(0x1E) FM Subcarrier Magnitude Register  */
#define ADEMOD_REG_FM_SUBCARRIER_NOISE      0x1F    /*(0x1F) FM Subcarrier Noise Register  */
#define ADEMOD_REG_NICAM_ERROR_RATE_H       0x20    /*(0x20 – 0x21) NICAM Error Rate Register  */ 
#define ADEMOD_REG_NICAM_ERROR_RATE_L       0x21    /*(0x20 – 0x21) NICAM Error Rate Register  */ 

#define ADEMOD_REG_AVERAGE_FREQ_2_H         0x30    /*(0x30 – 0x31) Carrier 2 Average Frequency Register  */
#define ADEMOD_REG_AVERAGE_FREQ_2_L         0x31    /*(0x30 – 0x31) Carrier 2 Average Frequency Register  */
#define ADEMOD_REG_STER_BILIGUAL_MAG_H      0x32    /*(0x32 – 0x33) Stereo & Bilingual ID Magnitudes,R  */
#define ADEMOD_REG_STER_BILIGUAL_MAGE_L     0x33    /*(0x32 – 0x33) Stereo & Bilingual ID Magnitudes,R  */

/*****************************************CRG CLOCK************************************************/
#define SIF_CRG_OFFSET                      0x19c

//System Select Register
typedef union
{
	struct 
	{
		unsigned int 	sys_sel 		: 4 ;   //[3..0] 
		unsigned int 	ASDEn		    : 1 ;   //[4]
		unsigned int 	Reserved		: 17;   //[31..5]
	}bits;
    
	unsigned int    u32;
    
}U_ADEMOD_SYS_SEL;	    

//Standard Select Register
typedef union 
{
	struct
	{
		unsigned int	stndrd		    : 3 ;   //[2..0]
		unsigned int	Reserved		: 29;   //[31..3]
	}bits;
    
	unsigned int    u32;
    
}U_ADEMOD_STNDRD_SEL;	    

//Sample Rate Register
typedef	union
{
    
	struct
	{
		unsigned int	samprt		    : 3 ;   //[2..0]
		unsigned int 	Reserved 		: 29;   //[31..3]
	}bits;
    
	unsigned int    u32;

}U_ADEMOD_SAMPRT;

//FM/AM Demodulator(Demod1) Control Register
typedef	union
{
	struct 
	{
		unsigned int 	dmd1_dv0		: 1 ;   //[0]
		unsigned int 	dmd1_dv1		: 1 ;   //[1]
		unsigned int	dmd1_md		    : 1 ;   //[2]
		unsigned int 	dmd1_fl0		: 1 ;   //[3]
		unsigned int 	dmd1_fl1		: 1 ;   //[4]
		unsigned int 	dmd1_dv2		: 1 ;   //[5]
		unsigned int	dmd1_fl2		: 1 ;   //[6]
		unsigned int	Reserved  		: 25;   //[31..7]
	}bits;
    
	unsigned int    u32;
	
}U_ADEMOD_DMD1_CTL;		   

//FM/DQPSK Demodulator(Deomd2) Control Register
typedef	union
{
	struct	
	{
		unsigned int	dmd2_dv0		: 1 ;   //[0]
		unsigned int	dmd2_dv1		: 1 ;   //[1]
		unsigned int	Reserved0		: 1 ;   //[2]
		unsigned int	dmd2_fl0		: 1 ;   //[3]
		unsigned int	dmd2_fl1		: 1 ;   //[4]
		unsigned int	dmd2_dv2		: 1 ;   //[5]
		unsigned int	Reserved1		: 26;   //[31..6]
	}bits;
    
	unsigned int    u32;

}U_ADEMOD_DMD2_CTL;		    

//Audio Output (LeFt/RighT) Control Register
typedef	union
{
	struct 
	{
		unsigned int	rtsel			: 2 ;   //[1..0]
		unsigned int	lfsel			: 2 ;   //[3..2] 
		unsigned int	aout_en			: 1 ;   //[4]
		unsigned int	lrsum			: 1 ;   //[5] 
		unsigned int	ROL				: 1 ;   //[6] 
		unsigned int	LOR				: 1 ;   //[7]
		unsigned int    Reserved        : 24;   //[31..8]
	}bits;
    
	unsigned int    u32;

}U_ADEMOD_AOUT_CTL;		    

//Audio Mode Dectect Register
typedef	union
{
	struct
	{
		unsigned int	audmod			: 2 ;   //[1..0]
		unsigned int	Reserved		: 30;   //[31..2]
	}bits;
    
	unsigned int    u32;			

}U_ADEMOD_AMODE;

//Pilot Magnitude Register
typedef	union
{
    struct
    {
    	unsigned int    PltMag          : 8 ;   //[7..0]
        unsigned int    Reserved        : 24;   //[31..8]
    }bits;
    
    unsigned int    u32;
    
}U_ADEMOD_PLT_MG;			    

//Pilot PLL Status Register
typedef	union
{
	struct
	{
		unsigned int    PLLLok	        : 1 ;   //[0]
		unsigned int    Reserved	    : 31;   //[31..1]
	}bits;
    
	unsigned int    u32;
	
}U_ADEMOD_PLT_STATUS;		    

//FM Subcarrier Magnitude Register
typedef	union
{
    struct
    {
    	unsigned int    SubMag          : 8 ;   //[7..0]
    	unsigned int    Reserved        : 24;   //[31..8]
    }bits;
    
    unsigned int    u32;
	
}U_ADEMOD_FMSUBCR_MG;	    

//FM Subcarrier Noise Register
typedef	union
{
    struct
    {
    	unsigned int    SubNs           : 8 ;   //[7..0]
    	unsigned int    Reserved        : 24;   //[31..8]
	}bist;
    
    unsigned int    u32;

}U_ADEMOD_FMSUBCR_NS;	    

//NICAM Control Register
typedef	union
{
    struct
	{
		unsigned int    c0				: 1 ;   //[0]
		unsigned int    c321			: 3 ;   //[3..1]
		unsigned int    c4				: 1 ;   //[4]
		unsigned int    NICAD			: 11;   //[15..5]
		unsigned int    Reserved        : 16;   //[31..16]
	}bits;
    
	unsigned int    u32;			
    	
}U_ADEMOD_NIC_CTL;		    

//AGC Control
typedef union
{
	struct 
	{
		unsigned int	decay			: 4 ;   //[3..0] 
		unsigned int	attack			: 4 ;   //[7..4] 
		unsigned int    Reserved        : 24;   //[31..8]
	}bits;
    
	unsigned int    u32;

}U_ADEMOD_AGC_CTL;		   

//AGC Control for AM
typedef	union
{
	struct 
	{
		unsigned int 	decay			: 4 ;   //[3..0] 
		unsigned int	attack			: 4 ;   //[7..4]
		unsigned int    Reserved        : 24;   //[31..8]
	}bits;
    
	unsigned int    u32;
    
}U_ADEMOD_AGC_CTL4AM;	   

//Pilot Control
typedef union
{
	struct
	{
		unsigned int 	PALN			: 1 ;   //[0] 
		unsigned int	SAPPhs			: 1 ;   //[1]
		unsigned int	Reserved		: 30;   //[31..2]
	}bits;
    
	unsigned int    u32;

}U_ADEMOD_PLT_CTL;			

//Status Register
typedef	union
{
	struct
	{
		unsigned int	PrmCarDet		: 1 ;   //[0]
		unsigned int	SecCarDet		: 1 ;   //[1]
		unsigned int	SndStat			: 2 ;   //[3..2]
		unsigned int	mono_str		: 1 ;   //[4]
		unsigned int 	imono			: 1 ;   //[5]
		unsigned int	bili_SAP		: 1 ;   //[6]
		unsigned int	ASDComplete		: 1 ;   //[7]
		unsigned int    Reserved        : 24;   //[31..8]
	}bits;
    
	unsigned int    u32; 	
    
}U_ADEMOD_STAT;			    

//Status Pin Control
typedef	union
{
	struct
	{
		unsigned int	StatEn			: 1 ;   //[0]
		unsigned int	StatPl			: 1 ;   //[1]
		unsigned int	AStat			: 1 ;   //[2]
		unsigned int	Reserved		: 29;   //[31..3]
	}bits;
    
	unsigned int    u32;		

}U_ADEMOD_STAT_PINCTL;		

//A/D Headroom
typedef	union
{
	struct
	{
		unsigned int	headrm			: 3 ;   //[2..0]
		unsigned int 	Reserved		: 29;   //[31..3]
	}bits;
    
	unsigned int    u32;
	
}U_ADEMOD_AD_HEADRM;		    

//AGC Freeze Control
typedef	union
{
	struct
	{
		unsigned int 	AGCFrz			: 1;    //[0]
		unsigned int	Reserved		: 31;   //[31..1]	
	}bits;
    
	unsigned int    u32;

}U_ADEMOD_AGC_FRZCTL;		

//Stereo	Carrier Search Control
typedef union
{
	struct
	{
		unsigned int	SrchEn			: 2 ;   //[1..0]
		unsigned int	ChgMod			: 2 ;   //[3..2]
		unsigned int	Reserved		: 1 ;   //[4]
		unsigned int	A2DK1skip		: 1 ;   //[5]
		unsigned int	A2DK2skip		: 1 ;   //[6]
		unsigned int	A2DK3skip		: 1 ;   //[7]
		unsigned int    Reserved1       : 24;   //[31..8]
	}bits;
    
	unsigned int    u32;

}U_ADEMOD_SCS_CTL;	        

//Stereo Carrier Search Result
typedef	union
{
	struct
	{
		unsigned int	SrchRsl			: 4 ;   //[3..0]
		unsigned int	SrchSt			: 1 ;   //[4] search status
		unsigned int	SrchCmp			: 1 ;   //[5]
		unsigned int	SrchInd			: 1 ;   //[6]
		unsigned int	Reserved 		: 25;   //[31..7]
	}bits;
    
	unsigned int    u32;

}U_ADEMOD_SCS_RSLT;	       

//Stereo & Bilingual ID Magnitude
typedef	union
{
	struct
	{
		unsigned int	BiMag			: 8 ;   //[7..0]
		unsigned int    Reserved        : 24;   //[31..8]
	}bits;
    
	unsigned int    u32;

}U_ADEMOD_BIID_MG;	        

//Stereo & Bilingual ID Magnitude
typedef union
{
    struct
    {
        unsigned int  StMag             : 8 ;   //[7..0]
        unsigned int  Reserved          : 24;   //[31..8]
    }bits;
    
    unsigned int    u32;
    
}U_ADEMOD_STID_MG;          

//Audio Output Result Register
typedef union
{
	struct
	{
		unsigned int	RtRslt			: 2 ;   //[1..0]
		unsigned int	LfRslt			: 2 ;   //[3..2]
		unsigned int	Reserved		: 1 ;   //[4]
		unsigned int	LRsum			: 1 ;   //[5]
		unsigned int	ROL				: 1 ;   //[6]
		unsigned int	LOR				: 1 ;   //[7]
		unsigned int    Reserved1       : 24;   //[31..8]
	}bits;
    
	unsigned int    u32;			

}U_ADEMOD_AOUT_RSLT;		   

//Mute Control Register
typedef	union
{
	struct
	{
		unsigned int	MuteRBCTL		: 1 ;   //[0]
		unsigned int    MuteLACTL       : 1 ;   //[1]
		unsigned int	MuteOv			: 1 ;   //[2]
        unsigned int	MuteRightRslt	: 1 ;   //[3]
        unsigned int	MuteLeftRslt	: 1 ;   //[4]
		unsigned int	ASDMut		    : 1 ;   //[5]
		unsigned int	AAOSMut			: 1 ;   //[6]
		unsigned int	Reserved		: 25;   //[31..7]
	}bits;
    
    unsigned int    u32;
    
}U_ADEMOD_MUTE_CTL;		    

//Mute Control Register
typedef	union
{
	struct
	{
		unsigned int	MuteRightCtrl   : 1 ;   //[0]  
		unsigned int	MuteLeftCtrl    : 1 ;   //[1]  
		unsigned int	MuteOv			: 1 ;   //[2]
		unsigned int	MuteRightRst    : 1 ;   //[3]
		unsigned int	MuteLeftRst     : 1 ;   //[4]
		unsigned int	ASDMut			: 1 ;   //[5]
		unsigned int	AAOSMut			: 1 ;   //[6]
		unsigned int	Reserved		: 25;   //[31..7]
	}bits;
    
    unsigned int    u32;				
    
}U_ADEMOD_MUTE_CTRL;		

//Automatic System Detect Control Register
typedef	union
{
	struct
	{
		unsigned int	FrFive			: 3 ;   //[2..0]
		unsigned int	SxFive			: 1 ;   //[3]  
		unsigned int	Reserved		: 28;   //[31..4]
	}bits;
    
	unsigned int    u32;
    
}U_ADEMOD_ASD_CTL;		    

//Automatic Volume Correction
typedef	union
{
	struct
	{
		unsigned int	AVCEn			: 1 ;   //[0]
		unsigned int	AVCDcy			: 2 ;   //[2..1]
		unsigned int	AVCAtk			: 2 ;   //[4..3]
		unsigned int	Reserved		: 27;   //[31..5]
	}bits;
    
	unsigned int    u32;
    
}U_ADEMOD_AVC;				

//Level Prescaler Control
typedef	union
{
	struct
	{
		unsigned int	PreCtrl			: 1 ;   //[0]
		unsigned int	Reserved		: 31;   //[31..1]
	}bits;
    
	unsigned int    u32;
    
}U_ADEMOD_PRESCAL_CTL;	   

//Legacy Levels Control 
typedef	union
{
	struct
	{
		unsigned int	LgLevEn			: 1 ;   //[0] 
		unsigned int	Reserved		: 31;   //[31..1]
	}bits;
    
	unsigned int    u32;
	
}U_ADEMOD_LEGLEV_CTL;	    

//SIF Drop Interpolation Control
typedef	union
{
	struct
	{
		unsigned int	SFDEn		    : 1 ;   //[0]
		unsigned int 	Reserved		: 31;   //[31..1]
	}bits;
    
	unsigned int    u32;
    
}U_ADEMOD_SFD_CTL;	

//All PreScaler Output Level Type
typedef	union
{
    struct
    {
    	unsigned int    value           : 8 ;   //[7..0]
        unsigned int    Reserved        : 24;   //[31..8]
    }bits;
    
    unsigned int    u32;
    
}U_ADEMOD_PRESCAL_LEV;		

//8 bit Threshold, 4A~5B,81~85,8D~8E,96~97
typedef union
{
    struct
    {
	    unsigned int    value           : 8 ;   //[7..0]
	    unsigned int    Reserved        : 24;   //[31..8]
    }bits;
    
    unsigned int    u32;   
    
}U_ADEMOD_TH8;			    

//common structer for 16 bits registers(RO/RW)
//addr为高8位的地址，即低地址。04~05,07~08,0C~1B,20~21,30~31,8A~8B, except22~23
typedef struct
{
        unsigned int    addr;
		unsigned int	value;
	
}U_ADEMOD_REG16; 		      

// Define the union U_ADEMOD_INT_RAW
typedef union
{
    // Define the struct bits
    struct
    {
        unsigned int    int_raw         : 1 ;   // [0]
        unsigned int    Reserved_0      : 31;   // [31..1]
    } bits;

    // Define an unsigned member
    unsigned int    u32;

} U_ADEMOD_INT_RAW;

// Define the union U_ADEMOD_INT_STATUS
typedef union
{
    // Define the struct bits
    struct
    {
        unsigned int    int_status      : 1 ;   // [0]
        unsigned int    Reserved_0      : 31;   // [31..1]
    } bits;

    // Define an unsigned member
    unsigned int    u32;

} U_ADEMOD_INT_STATUS;

// Define the union U_ADEMOD_INT_ENABLE
typedef union
{
    // Define the struct bits
    struct
    {
        unsigned int    int_enable      : 1 ;   // [0]
        unsigned int    Reserved_0      : 31;   // [31..1]
    } bits;

    // Define an unsigned member
    unsigned int    u32;

} U_ADEMOD_INT_ENABLE;

// Define the union U_ADEMOD_INT_CLR
typedef union
{
    // Define the struct bits
    struct
    {
        unsigned int    int_clr         : 1 ;   // [0]
        unsigned int    Reserved_0      : 31;   // [31..1]
    } bits;

    // Define an unsigned member
    unsigned int    u32;

} U_ADEMOD_INT_CLR;

#if 0

// Define the union U_ADEMOD_INT_CLR
typedef union
{
    // Define the struct bits
    struct
    {
        unsigned int    demod_cken      : 1 ;   // [0]
        unsigned int    afe2_cken       : 1 ;   // [1]
        unsigned int    sif_cken        : 1 ;   // [2]
        unsigned int    pwm_sif_cken    : 1 ;   // [3]
        unsigned int    demod_srst_req  : 1 ;   // [4]
        unsigned int    demod_cksel     : 1 ;   // [5]
        unsigned int    afe2_clkin_pctrl: 1 ;   // [6]
        unsigned int    pwm_sif_srst_req: 1 ;   // [7]
        unsigned int    demod_bclk_div  : 4 ;   // [11:8]
        unsigned int    demod_fsclk_div : 3 ;   // [14:12]
        unsigned int    Reserved_0      : 17;   // [31..15]
    } bits;

    // Define an unsigned member
    unsigned int    u32;

} U_PERI_CRG103;
#endif

#ifdef __cplusplus
#if __cplusplus
}
#endif
#endif /* __cplusplus */

#endif /*__ADEMOD_REG_H__*/
