/******************************************************************************

  Copyright (C), 2012-2050, Hisilicon Tech. Co., Ltd.

 ******************************************************************************
  File Name     : drv_hdmirx_mhl.h
  Version       : Initial Draft
  Author        : Hisilicon multimedia software group
  Created       : 2014/03/19
  Description   : 
  History       :
  1.Date        : 2014/03/19
    Author      : c00189109
    Modification: Created file
******************************************************************************/

#ifndef __DRV_HDMIRX_MHL_H__
#define __DRV_HDMIRX_MHL_H__

#include "hi_type.h"
#include "hal_hdmirx.h"
#include "hi_unf_hdmirx.h"
#include <linux/sched.h>    //  struct timeval

#define     MHL_SCRATCHPAD_SIZE             16
#define     MHL_MAX_BUFFER_SIZE             MHL_SCRATCHPAD_SIZE // manually define highest number

#define HDMIRX_MHL_GET_CTX()  (&s_stHdmirxMhlCtx)


// Version that this chip supports
#define MHL_VER_MAJOR      	(0x02 << 4) // bits 4..7
#define MHL_VER_MINOR      	0x00        // bits 0..3
#define MHL_VERSION        	(MHL_VER_MAJOR | MHL_VER_MINOR)
#define MHL_DEV_CAT_POW    	0x31	// bits{6,5} would be {0,1} = Device delivers at least 900mA

#define MHL_DEVICE_ID_H            (0x95)

#define MHL_DEVICE_ID_L            (0x33)

#define MHL_INT_STAT_SIZE          			0x33    // Bits set dynamically

#define MHL_DEV_CAT_ADOPTER_ID_H			0x01
#define MHL_DEV_CAT_ADOPTER_ID_L			0x42
#define MHL_VID_LINK_MODE					0x17
#define MHL_AUDIO_LINK_MODE_SUPORT      	0x03       // Bit 0 = 2-Channel
#define MHL_VIDEO_TYPE                  	0x8C       // VT_GAME| VT_CENEMA
// initialize MHL registers with the correct values
#define MHL_DEV_STATE						0x00
#if 0
#define MHL_DEV_SUPPORTS_DISPLAY_OUTPUT    	(0x01 << 0)
#define MHL_DEV_SUPPORTS_VIDEO_OUTPUT    	(0x01 << 1)
#define MHL_DEV_SUPPORTS_AUDIO_OUTPUT      	(0x01 << 2)
#define MHL_DEV_SUPPORTS_MEDIA_HANDLING     (0x01 << 3)
#define MHL_DEV_SUPPORTS_TUNER     			(0x01 << 4)
#define MHL_DEV_SUPPORTS_RECORDING         	(0x01 << 5)
#define MHL_DEV_SUPPORTS_SPEAKERS           (0x01 << 6)
#define MHL_DEV_SUPPORTS_GUI            	(0x01 << 7)
#define MHL_LOG_DEV_MAP (MHL_DEV_SUPPORTS_GUI |MHL_DEV_SUPPORTS_SPEAKERS | MHL_DEV_SUPPORTS_DISPLAY_OUTPUT)

#endif
#define MHL_LD_DISPLAY		0x01
#define MHL_LD_VIDEO		0x02
#define MHL_LD_AUDIO		0x04
#define MHL_LD_MEDIA		0x08
#define MHL_LD_TUNER		0x10
#define MHL_LD_RECORD		0x20
#define MHL_LD_SPEAKER		0x40
#define MHL_LD_GUI			0x80
#define MHL_LOG_DEV_MAP	(MHL_LD_GUI|MHL_LD_SPEAKER|MHL_LD_DISPLAY)



#define MHL_BANDWIDTH_LIMIT             	0x0F      // 75 MHz

#define MHL_FEATURE_SUPPORT          		0x1F    // Feature Support for RCP/RAP/Scratch Pad/UCP_SEND/UCP_RECV

#define CBUS_MAX_COMMAND_QUEUE      12
#define CH_ACTIVE_INDEX     (s_stHdmirxMhlCtx.u32ActiveIndex)

#define CBUS_HPD_WAIT_TIMER         	120
#define CBUS_ABORT_TIMER				2100
#define CBUS_MSG_RSP_TIMER				3200
#define CBUS_WB_REQ_TIMER				1100
#define CBUS_INIT_TIMER					500
#define CBUS_RCPE_RCPK_GAP_TIMER		300
#define	CBUS_RCP_RCP_ABORT_TIMER		1050

#define 	CBUS_UCP_ASCII_LIMIT                0x7F

enum
{
	MHL_MSC_NO_ERROR			= 0x00, 	// no error
	MHL_MSC_INVALID_SUBCMD		= 0X01,		// invalid sub command
};

#if 0
typedef enum
{
    MHL_LD_DISPLAY                  = 0x01,
    MHL_LD_VIDEO                    = 0x02,
    MHL_LD_AUDIO                    = 0x04,
    MHL_LD_MEDIA                    = 0x08,
    MHL_LD_TUNER                    = 0x10,
    MHL_LD_RECORD                   = 0x20,
    MHL_LD_SPEAKER                  = 0x40,
    MHL_LD_GUI                      = 0x80,
}MhlLogicalDeviceTypes;
#endif
#define MHL_LD_INVALID  (0)

#define MHL_LD_NONE     (0x00)
#define MHL_LD_ALL      (0xFF)
#define MHL_LD_NUMBER   (MHL_LD_VIDEO | MHL_LD_AUDIO | MHL_LD_MEDIA | MHL_LD_TUNER)
#define MHL_LD_AV       (MHL_LD_VIDEO | MHL_LD_AUDIO)
#define MHL_LD_AV_REC   (MHL_LD_VIDEO | MHL_LD_AUDIO | MHL_LD_RECORD)
#define MHL_LD_AV_MEDIA (MHL_LD_VIDEO | MHL_LD_AUDIO | MHL_LD_MEDIA )
#define MHL_LD_NUMBER   (MHL_LD_VIDEO | MHL_LD_AUDIO | MHL_LD_MEDIA | MHL_LD_TUNER)

#define  LD_MHL_RCP_CMD_SELECT          MHL_LD_GUI
#define  LD_MHL_RCP_CMD_UP              MHL_LD_GUI
#define  LD_MHL_RCP_CMD_DOWN            MHL_LD_GUI
#define  LD_MHL_RCP_CMD_LEFT            MHL_LD_GUI
#define  LD_MHL_RCP_CMD_RIGHT           MHL_LD_GUI
#define  LD_MHL_RCP_CMD_RIGHT_UP        MHL_LD_NONE
#define  LD_MHL_RCP_CMD_RIGHT_DOWN      MHL_LD_NONE
#define  LD_MHL_RCP_CMD_LEFT_UP         MHL_LD_NONE
#define  LD_MHL_RCP_CMD_LEFT_DOWN       MHL_LD_NONE
#define  LD_MHL_RCP_CMD_ROOT_MENU       MHL_LD_GUI
#define  LD_MHL_RCP_CMD_SETUP_MENU      MHL_LD_NONE
#define  LD_MHL_RCP_CMD_CONTENTS_MENU   MHL_LD_NONE
#define  LD_MHL_RCP_CMD_FAVORITE_MENU   MHL_LD_NONE
#define  LD_MHL_RCP_CMD_EXIT            MHL_LD_GUI
#define  LD_MHL_RCP_CMD_NUM_0           MHL_LD_NUMBER
#define  LD_MHL_RCP_CMD_NUM_1           MHL_LD_NUMBER
#define  LD_MHL_RCP_CMD_NUM_2           MHL_LD_NUMBER
#define  LD_MHL_RCP_CMD_NUM_3           MHL_LD_NUMBER
#define  LD_MHL_RCP_CMD_NUM_4           MHL_LD_NUMBER
#define  LD_MHL_RCP_CMD_NUM_5           MHL_LD_NUMBER
#define  LD_MHL_RCP_CMD_NUM_6           MHL_LD_NUMBER
#define  LD_MHL_RCP_CMD_NUM_7           MHL_LD_NUMBER
#define  LD_MHL_RCP_CMD_NUM_8           MHL_LD_NUMBER
#define  LD_MHL_RCP_CMD_NUM_9           MHL_LD_NUMBER
#define  LD_MHL_RCP_CMD_DOT             MHL_LD_NONE
#define  LD_MHL_RCP_CMD_ENTER           MHL_LD_NUMBER
#define  LD_MHL_RCP_CMD_CLEAR           MHL_LD_NUMBER
#define  LD_MHL_RCP_CMD_CH_UP           MHL_LD_TUNER
#define  LD_MHL_RCP_CMD_CH_DOWN         MHL_LD_TUNER
#define  LD_MHL_RCP_CMD_PRE_CH          MHL_LD_TUNER
#define  LD_MHL_RCP_CMD_SOUND_SELECT    MHL_LD_AUDIO
#define  LD_MHL_RCP_CMD_INPUT_SELECT    MHL_LD_NONE
#define  LD_MHL_RCP_CMD_SHOW_INFO       MHL_LD_NONE
#define  LD_MHL_RCP_CMD_HELP            MHL_LD_NONE
#define  LD_MHL_RCP_CMD_PAGE_UP         MHL_LD_NONE
#define  LD_MHL_RCP_CMD_PAGE_DOWN       MHL_LD_NONE
#define  LD_MHL_RAP_CONTENT_ON          MHL_LD_NONE
#define  LD_MHL_RCP_CMD_VOL_UP          MHL_LD_SPEAKER
#define  LD_MHL_RCP_CMD_VOL_DOWN        MHL_LD_SPEAKER
#define  LD_MHL_RCP_CMD_MUTE            MHL_LD_SPEAKER
#define  LD_MHL_RCP_CMD_PLAY            MHL_LD_AV
#define  LD_MHL_RCP_CMD_STOP            MHL_LD_AV_REC
#define  LD_MHL_RCP_CMD_PAUSE           MHL_LD_AV_REC
#define  LD_MHL_RCP_CMD_RECORD          MHL_LD_RECORD
#define  LD_MHL_RCP_CMD_REWIND          MHL_LD_AV
#define  LD_MHL_RCP_CMD_FAST_FWD        MHL_LD_AV
#define  LD_MHL_RCP_CMD_EJECT           MHL_LD_MEDIA
#define  LD_MHL_RCP_CMD_FWD             MHL_LD_AV_MEDIA
#define  LD_MHL_RCP_CMD_BKWD            MHL_LD_AV_MEDIA
#define  LD_MHL_RCP_CMD_ANGLE           MHL_LD_NONE
#define  LD_MHL_RCP_CMD_SUBPICTURE      MHL_LD_NONE
#define  LD_MHL_RCP_CMD_PLAY_FUNC       MHL_LD_AV
#define  LD_MHL_RCP_CMD_PAUSE_PLAY_FUNC MHL_LD_AV
#define  LD_MHL_RCP_CMD_RECORD_FUNC     MHL_LD_RECORD
#define  LD_MHL_RCP_CMD_PAUSE_REC_FUNC  MHL_LD_RECORD
#define  LD_MHL_RCP_CMD_STOP_FUNC       MHL_LD_AV_REC
#define  LD_MHL_RCP_CMD_MUTE_FUNC       MHL_LD_SPEAKER
#define  LD_MHL_RCP_CMD_UN_MUTE_FUNC    MHL_LD_SPEAKER
#define  LD_MHL_RCP_CMD_TUNE_FUNC       MHL_LD_NONE
#define  LD_MHL_RCP_CMD_MEDIA_FUNC      MHL_LD_NONE
#define  LD_MHL_RCP_CMD_F1              MHL_LD_NONE
#define  LD_MHL_RCP_CMD_F2              MHL_LD_NONE
#define  LD_MHL_RCP_CMD_F3              MHL_LD_NONE
#define  LD_MHL_RCP_CMD_F4              MHL_LD_NONE
#define  LD_MHL_RCP_CMD_F5              MHL_LD_NONE

enum
{
	MHL_CMD_NO_RSP_RQD			= 0x00,         // general enum for all commands that don't require response data
    MHL_ACK                     = 0x33,         // Command or Data byte acknowledge
    MHL_NACK                    = 0x34,         // Command or Data byte not acknowledge
    MHL_ABORT                   = 0x35,         // Transaction abort
    MHL_WRITE_STAT              = 0x60 | 0x80,  // Write one status register strip top bit
    MHL_SET_INT                 = 0x60,         // Write one interrupt register
    MHL_READ_DEVCAP             = 0x61,         // Read one register
    MHL_GET_STATE               = 0x62,         // Read CBUS revision level from follower
    MHL_GET_VENDOR_ID           = 0x63,         // Read vendor ID value from follower.
    MHL_SET_HPD                 = 0x64,         // Set Hot Plug Detect in follower
    MHL_CLR_HPD                 = 0x65,         // Clear Hot Plug Detect in follower
    MHL_MSC_MSG                 = 0x68,         // VS command to send RCP sub-commands
    MHL_GET_SC1_ERRORCODE       = 0x69,         // Get Vendor-Specific command error code.
    MHL_GET_DDC_ERRORCODE       = 0x6A,         // Get DDC channel command error code.
    MHL_GET_MSC_ERRORCODE       = 0x6B,         // Get MSC command error code.
    MHL_WRITE_BURST             = 0x6C,         // Write 1-16 bytes to responder’s scratchpad.
    MHL_GET_SC3_ERRORCODE       = 0x6D,         // Get channel 3 command error code.
};
// ACPK/ACPE status values
enum
{
	MHL_MSC_MSG_UCP_NO_ERROR        		= 0x00,     // UCP No Error
	MHL_MSC_MSG_UCP_INEFFECTIVE_KEY_CODE  	= 0x01,     // The key code in the UCP sub-command is not recognized
};

typedef enum
{
    MHL_MSC_MSG_RCP_NO_ERROR                = 0x00,     // RCP No Error
    MHL_MSC_MSG_RCP_INEFFECTIVE_KEY_CODE    = 0x01,     // The key code in the RCP sub-command is not recognized
    MHL_MSC_MSG_RCP_RESPONDER_BUSY          = 0x02,     // RCP Response busy
    MHL_MSC_MSG_RCP_OTHER_ERROR             = 0xFF      // NOT RCP code: Hardware or Queue problem caused error
} MhlMscMsgRcpErrorCodes;
//RAPK status values
typedef enum
{
    MHL_MSC_MSG_RAP_NO_ERROR                = 0x00,     // RAP No Error
    MHL_MSC_MSG_RAP_UNRECOGNIZED_ACT_CODE   = 0x01,
    MHL_MSC_MSG_RAP_UNSUPPORTED_ACT_CODE    = 0x02,
    MHL_MSC_MSG_RAP_RESPONDER_BUSY          = 0x03,
    MHL_MSC_MSG_RAP_OTHER_ERROR             = 0xFF      // NOT RAP code: Hardware or Queue problem caused error
} MscMsgRapErrorCodes;
typedef enum
{
    MHL_RAP_CMD_POLL            = 0x00,
    MHL_RAP_CONTENT_ON          = 0x10,
    MHL_RAP_CONTENT_OFF         = 0x11,
    MHL_RAP_CMD_END             = 0x12
} RapActionCodes;

//
// structure to hold command details from upper layer to CBUS module
//
typedef struct
{
    HI_U32 	u32ReqStatus;                      // CBUS_IDLE, CBUS_PENDING etc
    HI_U32 u32Command;                        // MHL command or offset
    HI_U32 u32OffsetData;                     // Offset of register on CBUS
    HI_U32 u32Length;                         // Write Burst length, only applicable to write burst. ignored otherwise.
    HI_U32 u32MsgData[MHL_MAX_BUFFER_SIZE];   // Pointer to message data area, used for sending RCP/RAP cmds and for return data
} cbus_req;

typedef enum
{
    CBUS_IDLE           = 0x00,    			// BUS idle
    CBUS_XFR_DONE		= 0x01,             // Translation layer complete
    CBUS_RECEIVED		= 0x02,             // Message received, verify and send ACK
    CBUS_FAILED			= 0x04,				// last cbus cmd failed
    CBUS_SENT			= 0x08,             // Translation layer complete
} CbusState;

typedef struct
{
    //int         structVersion;
    //int         instanceIndex;
    //int         lastResultCode;              // Contains the result of the last API function called
    HI_U32    u32StatusFlags;
    //uint16_t    statusWakeFlags;

    // CBUS transfer values read at last interrupt for each specific channel
    //uint8_t     port;
    HI_U32     	u32InterruptStatus0;
    HI_U32     	u32InterruptStatus1;
    //uint8_t     intWakeStatus;
    HI_BOOL    	bBusConnected;
    HI_U32	   	u32VsCmd;
    HI_U32     	u32VsData;
    HI_U32     	u32MsgData0;
    HI_U32     	u32MsgData1;
    HI_U32     	u32CecAbortReason;
    HI_U32     	u32DdcAbortReason;
    HI_U32     	u32MscAbortFmPeerReason;
    HI_U32     	u32MscAbortReason;
	HI_BOOL    	bCbusInterrupt;              // CBUS interrupt flag
    HI_BOOL     bCbusEn;                 // true == CBusEnable
    HI_BOOL     bCbusSense;                 // true == CBusEnable
	//HI_U32      u32Port;           		// Port assigned to this CBUS channel
    HI_U32      u32SupportMask;            // Logical Device support bitmap for this CBUS channel
	CbusState 	enState;          		// State of command execution for this channel
	HI_U32 		u32ActiveIndex;    		// Active queue entry.
	HI_U32		u32QueueDepth;			// cbus queue depth
	HI_U32		u32WbStartOffset;			// write burst start offset
	HI_U32 		u32WbLength;				// write burst length
	HI_U32		u32LastCbusRcvdCmd;		// last cmd received on cbus
    HI_U32		u32LastCbusRcvdData;		// last data received on cbus
    HI_U32    	u32MiscFlags;				// misc flags on cbus showing the state it is in
    HI_BOOL		bPathEnableSent;			// PATH_EN sent or not
    HI_U32		u32LastReadDevCapReg;		// last read device capability re
    struct timeval		stHpdWaitTime;			// Timer for hpd_toggle
	struct timeval		stCbusMsgRspWaitTime;		// Timer for hpd_toggle
	struct timeval 		stAbortTime;				// timer to stop sending cmds after an abort is received
	struct timeval		stWaitTime;				// wait until the cbus cmd is completed before sending a new one..
	struct timeval		stRcpRapAbortTime;		// if we don't receive RCPE/RCPK by this time, we should abort RCP/RAP cmd
	struct timeval		stRcpeRcpkGapTime;		// Time gap between two RCPE and RCPK commands
	struct timeval		stReqWrtTime;			// Timer for request write during a WRITE_BURST command
	struct timeval		stInitTime;
	struct timeval	stCbusTime;
    struct timeval      stCbusRepeatTime;
    struct timeval  stCbuConAbortTime;
	HI_BOOL 	bInitTimeValid;
	HI_BOOL		bHpdWaitTimeValid;
	HI_BOOL		bAbortTimeValid;
	HI_BOOL 	bRcpeRcpkGapTimeValid;
	HI_BOOL 	bRcpRapAbortTimeValid;
	HI_BOOL 	bWaitTimeValid;
	HI_BOOL 	bReqWrtTimeValid;
 //   HI_U32      u32RepeatSend;
	HI_U32		u32LastCbusSentCmd;		// last cmd sent on cbus
    HI_U32      u32RcpSentStatus;     //0:idle 1:sent 2:waitout
    struct timeval stRcpSentAbortTime;
	cbus_req 	stRequest[ CBUS_MAX_COMMAND_QUEUE ];	// cbus queue
	HI_U32      u32CecLa;
    HI_U32      u32CecPa;
	HI_U8       u8LastRcpCecSourceLa;
	HI_BOOL 	bCecIsActiveSource;
	// 3D related
	HI_U32		u32Sending_3D_info;		// sending 3D info
	HI_U32		u32Cbus3Dstate;			// state of sending 3D info

	HI_U32*		pu32TdVic;				// ptr to 2D SVDs supported in 3D
	HI_U32*		pu32TdDtd;				// ptr to 2D DTDs that are supported in 3D
	HI_U32		u32Cur3dVicSeq;			// current Write Burst sequence for SVDs' transfer
	HI_U32		u32Cur3dDtdSeq;			// current Write Burst sequence for DTDs' transfer
	HI_BOOL		bServing3dVicReq;		// if we are sending SVD data
	HI_BOOL		bServing3dDtdReq;		// if we are sending DTD data
	HI_BOOL     bCbuEn;
}	HDMIRX_MHL_CONTEXT_S;


typedef enum
{
    CBUS_INT                     		= 0x0001,   // A CBUS interrupt has occurred
    CBUS_NACK_RECEIVED_FM_PEER 			= 0x0002,	// Peer sent a NACK
    CBUS_DCAP_RDY_RECEIVED_FM_PEER		= 0x0004,   // DCAP_RDY received
    CBUS_PATH_EN_RECEIVED_FM_PEER		= 0x0008,   // PATH_EN received
    CBUS_DCAP_CHG_RECEIVED_FM_PEER		= 0x0010,   // DCAP_CHG received
    CBUS_SCRATCHPAD_WRITTEN_BY_PEER		= 0x0020,   // DSCR_CHG received.peer writes into scrAtchpad
    CBUS_REQ_WRT_RECEIVED_FM_PEER		= 0x0040,   // REQ_WRT received
    CBUS_GRT_WRT_RECEIVED_FM_PEER		= 0x0080,   // GRT_WRT received
    CBUS_3D_REQ_RECEIVED_FM_PEER		= 0x0100,   // GRT_WRT received

    CBUS_CEC_ABORT						= 0x0200,   // DDC_ABORT
    CBUS_DDC_ABORT						= 0x0400,   // DDC_ABORT
    CBUS_XFR_ABORT_R					= 0x0800,   // DDC_ABORT
    CBUS_XFR_ABORT_T					= 0x1000,   // DDC_ABORT

    CBUS_MSC_MSG_RCVD					= 0x2000,	// MSC_MSG received
    CBUS_MSC_CMD_DONE					= 0x4000,	// MSC_MSG received
    CBUS_CBUS_CONNECTION_CHG			= 0x8000,	// MSC_MSG received

} CbusStatus;
typedef enum
{
    CBUS_REQ_IDLE       = 0,
    CBUS_REQ_PENDING,           // Request is waiting to be sent
    CBUS_REQ_SENT,
    CBUS_REQ_RECEIVED,
} CbusRequest;
enum
{
	MHL_MSC_MSG_E				= 0x02,
    MHL_MSC_MSG_RCP             = 0x10,     // RCP sub-command
    MHL_MSC_MSG_RCPK            = 0x11,     // RCP Acknowledge sub-command
    MHL_MSC_MSG_RCPE            = 0x12,     // RCP Error sub-command
    MHL_MSC_MSG_RAP             = 0x20,     // RAP sub-command
    MHL_MSC_MSG_RAPK            = 0x21,     // RAP Acknowledge sub-command
    MHL_MSC_MSG_UCP				= 0x30,		// UCP sub-command
    MHL_MSC_MSG_UCPK			= 0x31,		// UCP Acknowledge sub-command
    MHL_MSC_MSG_UCPE			= 0x32,		// UCP Error sub-command
};
typedef enum
{
    FLAGS_SCRATCHPAD_BUSY         = 0x0001,
    FLAGS_REQ_WRT_PENDING         = 0x0002,
    FLAGS_WRITE_BURST_PENDING     = 0x0004,
    FLAGS_SENT_DCAP_RDY           = 0x0008,
    FLAGS_SENT_PATH_EN            = 0x0010,
} CBUS_MISC_FLAGS;

typedef enum
{
    SUCCESS = 0,
    ERROR_CBUS_ABORT,
    ERROR_WRITE_FAILED,
} CBUS_SOFTWARE_ERRORS;
typedef enum  // 3D state
{
    WB_3D_IDLE = 0,
    WB_3D_SENDING_VIC,
    WB_3D_SENDING_DTD
}Cbus3DState;

typedef enum hiHDMIRX_RCPKEY_TYPE_E
{
    MHL_RCP_CMD_SELECT          ,
    MHL_RCP_CMD_UP              ,
    MHL_RCP_CMD_DOWN            ,
    MHL_RCP_CMD_LEFT            ,
    MHL_RCP_CMD_RIGHT           ,
    MHL_RCP_CMD_RIGHT_UP        ,
    MHL_RCP_CMD_RIGHT_DOWN      ,
    MHL_RCP_CMD_LEFT_UP         ,
    MHL_RCP_CMD_LEFT_DOWN       ,
    MHL_RCP_CMD_ROOT_MENU       ,
    MHL_RCP_CMD_SETUP_MENU      ,
    MHL_RCP_CMD_CONTENTS_MENU   ,
    MHL_RCP_CMD_FAVORITE_MENU   ,
    MHL_RCP_CMD_EXIT            ,
    MHL_RCP_CMD_NUM_0           ,
    MHL_RCP_CMD_NUM_1           ,
    MHL_RCP_CMD_NUM_2           ,
    MHL_RCP_CMD_NUM_3           ,
    MHL_RCP_CMD_NUM_4           ,
    MHL_RCP_CMD_NUM_5           ,
    MHL_RCP_CMD_NUM_6           ,
    MHL_RCP_CMD_NUM_7           ,
    MHL_RCP_CMD_NUM_8           ,
    MHL_RCP_CMD_NUM_9           ,
    MHL_RCP_CMD_DOT             ,
    MHL_RCP_CMD_ENTER           ,
    MHL_RCP_CMD_CLEAR           ,
    MHL_RCP_CMD_CH_UP           ,
    MHL_RCP_CMD_CH_DOWN         ,
    MHL_RCP_CMD_PRE_CH          ,
    MHL_RCP_CMD_SOUND_SELECT    ,
    MHL_RCP_CMD_INPUT_SELECT    ,
    MHL_RCP_CMD_SHOW_INFO       ,
    MHL_RCP_CMD_HELP            ,
    MHL_RCP_CMD_PAGE_UP         ,
    MHL_RCP_CMD_PAGE_DOWN       ,
    MHL_RAP_CMD_CONTENT_ON      ,
    MHL_RCP_CMD_VOL_UP          ,
    MHL_RCP_CMD_VOL_DOWN        ,
    MHL_RCP_CMD_MUTE            ,
    MHL_RCP_CMD_PLAY            ,
    MHL_RCP_CMD_STOP            ,
    MHL_RCP_CMD_PAUSE           ,
    MHL_RCP_CMD_RECORD          ,
    MHL_RCP_CMD_REWIND          ,
    MHL_RCP_CMD_FAST_FWD        ,
    MHL_RCP_CMD_EJECT           ,
    MHL_RCP_CMD_FWD             ,
    MHL_RCP_CMD_BKWD            ,
    MHL_RCP_CMD_ANGLE           ,
    MHL_RCP_CMD_SUBPICTURE      ,
    MHL_RCP_CMD_PLAY_FUNC       ,
    MHL_RCP_CMD_PAUSE_PLAY_FUNC ,
    MHL_RCP_CMD_RECORD_FUNC     ,
    MHL_RCP_CMD_PAUSE_REC_FUNC  ,
    MHL_RCP_CMD_STOP_FUNC       ,
    MHL_RCP_CMD_MUTE_FUNC       ,
    MHL_RCP_CMD_UN_MUTE_FUNC    ,
    MHL_RCP_CMD_TUNE_FUNC       ,
    MHL_RCP_CMD_MEDIA_FUNC      ,
    MHL_RCP_CMD_F1              ,
    MHL_RCP_CMD_F2              ,
    MHL_RCP_CMD_F3              ,
    MHL_RCP_CMD_F4              ,
    MHL_RCP_CMD_F5              ,
}HDMIRX_RCPKEY_TYPE_E;
//------------------------------------------------------------------------------
// Function:    
// Description: Set the correct HPD state as determined by the request and
//              the current operating mode of the port.
// Parameter:   port:       HDMI Port to control
//              newState:   Requested new state for HPD
//
//              If Port is in CDC, MHD, or HDMI1.4 modes:
//
//                  SiiHPD_ACTIVE       - Send HPD HI command
//                  SiiHPD_INACTIVE     - Send HPD LOW command
//                  SiiHPD_ACTIVE_EX    - Send HPD HI command
//                  SiiHPD_INACTIVE_EX  - Send HPD LOW command
//                  SiiHPD_TOGGLE       - MHD - Toggle HPD pin HI then LOW
//                                        All other modes, nothing
//
//                  HDCP, EDID, RX Term enabled for all values of newState.
//                  MHD mode RX term enabled is MHD termination.
//
//              If Port is in HDMI1.3a mode:
//
//                  SiiHPD_ACTIVE       - HPD HI, HDCP, EDID, RX Term enabled
//                  SiiHPD_INACTIVE     - HPD LOW, HDCP, RX Term disabled
//                  SiiHPD_ACTIVE_EX    - EDID, RX Term enabled
//                  SiiHPD_INACTIVE_EX  - HPD LOW, HDCP, EDID, RX Term disabled
//                  SiiHPD_TOGGLE       - Nothing
//
//                  RX term enabled is HDMI termination.
//
// Returns:     TRUE if change to new state was successful.
//              FALSE otherwise.
//------------------------------------------------------------------------------

// Note that these enums match the values of the corresponding CdcHpdState_t enums
typedef enum
{
    HPD_INACTIVE_EX,     // HPD HI, HDCP, EDID, RX Term disabled
    HPD_ACTIVE,          // HPD HI, HDCP, EDID, RX Term enabled
    HPD_TOGGLE,          // All Toggle Off then On
    HPD_INACTIVE_EDID,   // EDID disabled
    HPD_ACTIVE_EX,       // EDID, RX Term enabled
    HPD_TOGGLE_EDID,     // EDID Toggle Off then On
    HPD_UNUSED,          // Unused to help match CDC values
    HPD_INACTIVE,        // HPD LOW, HDCP, RX Term disabled
} HpdOperations;

extern HI_VOID HDMIRX_MHL_CbusIsr(HI_UNF_HDMIRX_PORT_E enPort);

extern HI_VOID HDMIRX_MHL_MainHandler(HI_UNF_HDMIRX_PORT_E enPort);

extern HI_VOID HDMIRX_MHL_Initialize(HI_UNF_HDMIRX_PORT_E enPort);

extern HI_BOOL HDMIRX_MHL_SignalEnable(HI_VOID);

extern HI_VOID HDMIRX_MHL_ProcRead(struct seq_file *s);

HI_BOOL HDMIRX_MHL_IsBusConnected(HI_VOID);

HI_BOOL HDMIRX_MHL_OnOff(HI_BOOL bOn);

//HI_VOID HDMIRX_MHL_ResetToIdle(HI_VOID);

HI_VOID HDMIRX_MHL_Reset(HI_VOID);

//HI_BOOL HDMIRX_MHL_SendRcp(HI_UNF_HDMIRX_RCP_KEY_E u32CmdStatus);

HI_U32 HDMIRX_MHL_RcpSendStatus(HI_VOID);

HI_BOOL HDMIRX_MHL_GetCbusSense(HI_UNF_HDMIRX_PORT_E enPort);

HI_VOID HDMIRX_MHL_Suspend(HI_VOID);

HI_VOID HDMIRX_MHL_SetEn(HI_BOOL bEn);

#endif

