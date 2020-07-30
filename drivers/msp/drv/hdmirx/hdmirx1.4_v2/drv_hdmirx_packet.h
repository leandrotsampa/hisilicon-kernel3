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

#ifndef __DRV_HDMIRX_PACKET_H__
#define __DRV_HDMIRX_PACKET_H__

#include "hi_type.h"
#include "hal_hdmirx.h"

#define HDMIRX_PACKET_GET_CTX()  (&s_stHdmirxPacketCtx)
#define HDMIRX_PACKET_GET_TIME() (&s_stPacketTime)

#define AV_MUTE_INP_AV_MUTE_CAME	BIT1
// mute due to RX chip is not ready
#define AV_MUTE_RX_IS_NOT_READY		BIT2
// mute because of no AVI packet coming and therefore input color space is unknown
#define AV_MUTE_NO_AVI				BIT4
// mute due to an HDCP error
#define AV_MUTE_RX_HDCP_ERROR		BIT7

#define PACKET_BUFFER_LENGTH        31
#define	PACKET_TITLE_INDEX			0
#define	IF_HEADER_LENGTH		    4
#define	IF_LENGTH_INDEX		    2

#define	IF_MIN_AUDIO_LENGTH     10 // the 861C standard defines the length as 10
#define	IF_MAX_AUDIO_LENGTH     10 // maximum allowed by the chip

#define	IF_MIN_AVI_LENGTH       13 // the 861C standard defines the length as 13
#define	IF_MAX_AVI_LENGTH       15 // maximum allowed by the chip

#define	IF_MIN_MPEG_LENGTH      10 // the 861C standard defines the length as 10
#define	IF_MAX_MPEG_LENGTH      27 // maximum allowed by the chip

#define	IF_MIN_SPD_LENGTH       25 // the 861C standard defines the length as 25
#define	IF_MAX_SPD_LENGTH       27 // maximum allowed by the chip

#define	IF_MIN_VSIF_LENGTH      4 // minimum length by HDMI 1.4
#define	IF_MAX_VSIF_LENGTH      27 // maximum allowed by the chip

#define SPD_BUFFER_LENGTH   25 
#define IF_BUFFER_LENGTH    31
#define AVI_LENGTH  13
#define AVI_VERSION 2

#define VSIF_DEC 1
#define SPD_DEC 0


typedef enum hiHDMIRX_COLOR_METRY_E
{
	HDMIRX_COLOR_METRY_NoInfo,
	HDMIRX_COLOR_METRY_ITU601,
	HDMIRX_COLOR_METRY_ITU709,
	HDMIRX_COLOR_METRY_Extended, // if extended, but unknown
	HDMIRX_COLOR_METRY_xv601 = 10,
	HDMIRX_COLOR_METRY_xv709,
	HDMIRX_COLOR_METRY_BUTT
} HDMIRX_COLOR_METRY_E;

typedef enum hiVSIF_CHECK_RESULT_E
{
	VSIF_NOT_HDMI_VSIF,			// VSIF packet is not HDMI VSIF
	VSIF_NEW_EXTENDED_RESOLUTION, // VSIF packet carries Extended Resolution info: first detection
	VSIF_OLD_EXTENDED_RESOLUTION, // VSIF packet carries Extended Resolution info: no change
	VSIF_NEW_3D,					// VSIF packet with 3D info: first detection
	VSIF_OLD_3D					// VSIF packet with 3D info: no change from last time
}VSIF_CHECK_RESULT_E;



typedef enum hiHDMIRX_VSIF_SPD_STATE_E
{
	VSIF_SPD_INIT,
	VSIF_SPD_ANY_VSIF,
	VSIF_SPD_ANY_SPD,
	VSIF_SPD_DELAY,
} HDMIRX_VSIF_SPD_STATE_E;

typedef enum hiHDMIRX_ACP_TYPE_E
{
	ACP_GENERAL_AUDIO = 0,
	ACP_IEC60958,
	ACP_DVD_AUDIO,
	ACP_SUPER_AUDIO_CD,
	ACP_BUTT
}HDMIRX_ACP_TYPE_E;

// for avi infoframe structure -->
typedef struct hiHDMIRX_AVI_S
{
	HI_U32	au32AviData[AVI_LENGTH+IF_HEADER_LENGTH];
	HI_U8   u8AviVersion;
	HI_BOOL bAviReceived;
}HDMIRX_AVI_S;

typedef struct hiHDMIRX_SPD_S
{
	HI_BOOL bSpdReceived; // set on any SPD reception (even with incorrect check sum)
	HI_U32  au32SpdBuffer[SPD_BUFFER_LENGTH];
}HDMIRX_SPD_S;

// for vsif infoframe structure -->
typedef struct hiHDMIRX_VSIF_S
{
	HDMIRX_VSIF_SPD_STATE_E enVsifState;
	HI_U16              	u16VsifTimer;		// time unit in ms
	HI_BOOL             	bVsifReceived; 		// set on any VSIF reception
	HI_BOOL             	bFoundHdmiVsif;
	HI_BOOL             	bHdmi3dVsifReceived;
    #if SUPPORT_4K_VIC
	HI_BOOL             	bHdmiVicReceived;
    #endif
	HI_U16 					u16NoHdmiVsifTimeout;
}HDMIRX_VSIF_S;
typedef enum hiHDMIRX_ISRC_STATE_E
{
	ISRC_ST_INIT,
	ISRC_ST_WAIT_ANY_ISRC1,
	ISRC_ST_WAIT_NEW_ISRC1,
	ISRC_ST_WAIT_ANY_ISRC2,
} HDMIRX_ISRC_STATE_E;

typedef struct hiHDMIRX_PACKET_CONTEXT_S
{
    HDMIRX_AVI_S        stAvi;
    HDMIRX_SPD_S        stSpd;
    HDMIRX_VSIF_S       stVsif;
	HDMIRX_ACP_TYPE_E   enAcpType;
	HI_U32              u32AvMask; // RX AV muting sources
    HI_BOOL             bAudioInfoFrameReceived;
    /*
    HI_U32              u32Replication;
    HI_U32              enInColorSpace;
    HI_U32              enInColorMetry;
    */
}HDMIRX_PACKET_CONTEXT_S;

HI_VOID HDMIRX_PACKET_AVI_SetNoAviIntEn(HI_UNF_HDMIRX_PORT_E enPort,HI_BOOL bEn);
HI_VOID HDMIRX_PACKET_AVI_NoAviHandler(HI_VOID);
HI_VOID HDMIRX_PACKET_InterruptHandler(HI_UNF_HDMIRX_PORT_E enPort,HI_U32 u32Int);
HI_VOID HDMIRX_PACKET_AcpIntHandler(HI_UNF_HDMIRX_PORT_E enPort);
//HI_VOID HDMIRX_PACKET_CpHandler(HI_UNF_HDMIRX_PORT_E enPort);
HI_VOID HDMIRX_PACKET_MainThread(HI_UNF_HDMIRX_PORT_E enPort);
HI_BOOL HDMIRX_PACKET_AVI_IsGot(HI_VOID);
HI_BOOL HDMIRX_PACKET_VSIF_IsGot3d(HI_VOID);
HDMIRX_OVERSAMPLE_E HDMIRX_PACKET_AVI_GetReplication(HI_VOID);
HI_BOOL HDMIRX_PACKET_AVI_IsDataValid(HI_VOID);
HDMIRX_COLOR_SPACE_E HDMIRX_PACKET_AVI_GetColorSpace(HI_VOID);
HDMIRX_RGB_RANGE_E HDMIRX_PACKET_AVI_GetRGBRange(HI_VOID);
HI_VOID HDMIRX_PACKET_ResetData(HI_VOID);
HDMIRX_COLOR_METRY_E HDMIRX_PACKET_AVI_GetColorMetry(HI_VOID);
HI_VOID HDMIRX_PACKET_AVI_SetNoAviIntEn(HI_UNF_HDMIRX_PORT_E enPort,HI_BOOL bEn);
HI_BOOL HDMIRX_PACKET_AIF_IsGot(HI_VOID);
HI_VOID HDMIRX_PACKET_ResetAudInfoFrameData(HI_UNF_HDMIRX_PORT_E enPort);
//HI_VOID HDMIRX_PACKET_AIF_SetGotFlag(HI_BOOL bGot);
HI_VOID HDMIRX_PACKET_Initial(HI_VOID);
#if SUPPORT_4K_VIC
HI_BOOL HDMIRX_PACKET_VSIF_IsGotHdmiVic(HI_VOID);
#endif

#endif
