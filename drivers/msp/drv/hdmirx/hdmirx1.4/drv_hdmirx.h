//******************************************************************************
//  Copyright (C), 2012-2014, Hisilicon Technologies Co., Ltd.
//
//******************************************************************************
// File name     : drv_hdmirx.h
// Version       : 1.0
// Author        : j00169368
// Created       : 2013-0c-04
// Last Modified : 
// Description   :  The C union definition file for the module tvd
// Function List : 
// History       : 
// 1 Date        : 2014-06-14
// Author        : l00214567
// Modification  : Create file
//******************************************************************************


#ifndef __DRV_HDMIRX_H__
#define __DRV_HDMIRX_H__

#include <linux/seq_file.h>
#include <linux/mm.h>
#include <linux/interrupt.h>
#include "hi_drv_hdmirx.h"

#include "hi_debug.h"

//#include "hi_drv_hdmirx.h"
#include "hi_unf_hdmirx.h"
#include "drv_hdmirx_audio.h"

#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif
#endif

#include "hi_type.h"


#define FPGA_ONLY                               1
#define SUPPORT_3D                              1
#define SUPPORT_ISRC                            1
#define SUPPORT_AUDIO                           1
#define SUPPORT_AAC                             (SUPPORT_AUDIO&&1)
#define SUPPORT_CEC                             0

#define MLOOP_TIME_UNIT             10 // ms
#define INFO_TIME_UNIT              2
#define AUDIO_TIMER_MAX             30
#define HDMI_VIDEO_CLK_EDGE_INV     1
//#define TIMING_PC_MODE              0xfe;
//#define TIMING_NO_FOUND             0xff
#define AVI_LENGTH                  5
#define ISRC1_BUFFER_LENGTH			(16+3)
#define HDMI_OUTPUT_COLOR_SPACE		PATH_YCbCr444



//#define NMB_OF_RX_INTERRUPTS	11

// Propagation of incoming AV Mute packet from upstream to downstream
#define AV_MUTE_INP_AV_MUTE_CAME	BIT1
// mute due to RX chip is not ready
#define AV_MUTE_RX_IS_NOT_READY		BIT2
// mute because of no AVI packet coming and therefore input color space is unknown
#define AV_MUTE_NO_AVI				BIT4
// mute due to an HDCP error
#define AV_MUTE_RX_HDCP_ERROR		BIT7

#define SPD_BUFFER_LENGTH 25     

#define ABS_DIFF(A, B) ((A>B) ? (A-B) : (B-A))

#define CEC_MAX_CMD_SIZE 16
// indexes in Vic2IdxTable[]
#define TASK_QUEUE_LENGTH   6

#define INPUT_PORT_COUNT 1



#define HI_DBG_EMERG      HI_LOG_LEVEL_FATAL   /* system is unusable                   */
#define HI_DBG_ALERT      HI_LOG_LEVEL_WARNING   /* action must be taken immediately     */
#define HI_DBG_CRIT       HI_LOG_LEVEL_WARNING   /* critical conditions                  */
#define HI_DBG_ERR        HI_LOG_LEVEL_ERROR   /* error conditions                     */
#define HI_DBG_WARN       HI_LOG_LEVEL_WARNING   /* warning conditions                   */
#define HI_DBG_NOTICE     HI_LOG_LEVEL_INFO   /* normal but significant condition     */
#define HI_DBG_INFO       HI_LOG_LEVEL_INFO   /* informational                        */
#define HI_DBG_DEBUG      HI_LOG_LEVEL_INFO   /* debug-level messages                 */


#ifndef HI_ADVCA_FUNCTION_RELEASE
#define HDMIRX_DEBUG printk
#else
#define HDMIRX_DEBUG(format, arg...)
#endif


#define HDMIRX_TRACE(level, fmt...) \
do{\
    /* HI_TRACE(level, HI_ID_HDMIRX,"[Func]:%s [Line]:%d [Info]:", __FUNCTION__, __LINE__);*/\
    /* HI_TRACE(level, HI_ID_HDMIRX, ##fmt);*/\
}while(0)

#define HDMIRX_CHECK_NULL_PTR(ptr) \
do{\
    if (NULL == ptr){\
        HDMIRX_TRACE(HI_DBG_ERR, "[%s] failed, pointer is NULL!\n", __FUNCTION__);\
        return HI_FAILURE;\
    }\
}while(0)

#define HDMIRX_CHECK_ENABLE(bEnable) \
do{\
    if (HI_FALSE == bEnable){\
        HDMIRX_TRACE(HI_DBG_ERR, "[%s] failed, HDMIRX is not enable!\n", __FUNCTION__);\
        return HI_FAILURE;\
    }\
}while(0)

#define HDMIRX_CHECK_BOOL_VAILD(bValue, name) \
do{\
    if ((HI_TRUE != bValue) && (HI_FALSE != bValue)){\
        HDMIRX_TRACE(HI_DBG_ERR, "%s [%d] out of range! FUNC[%s]\n",\
            name, bValue, __FUNCTION__);\
        return HI_FAILURE;\
    }\
}while(0)

enum intr_define{
    INTR1,
    INTR2,
    INTR3,
    INTR4,
    INTR5,
    INTR6,
    INTR7,
    INTR8 = 7,
    INTR2_AON,
    INTR6_AON,
    INTR8_AON,
    INTR_BUTT
};

enum hdmi_dith_mode{
    HDMI_OUTPUT_DEPTH_24,
    HDMI_OUTPUT_DEPTH_30,
    HDMI_OUTPUT_DEPTH_36,
    HDMI_OUTPUT_DEPTH_BUTT
};

enum HDMI_FW_STATE{
    HDMI_STATE_INIT,                // 0
    HDMI_STATE_IDLE,                // 1
    HDMI_STATE_SYNC_SEARCH,         // 2
    HDMI_STATE_SYNC_STABLE,         // 3
    HDMI_STATE_FORMAT_DETECTED,     // 4
    HDMI_STATE_NOT_SUPPORTED,       // 5
    HDMI_STATE_VIDEO_ON,            // 6
    HDMI_STATE_REQ_IDLE,            // 7
    HDMI_STATE_STANDBY,             // 8
    HDMI_STATE_RECHECK_FORMAT,      // 9
    HDMI_STATE_BUTT
};

enum {
    HDMI_TIMER_IDX_ISR,
    HDMI_TIMER_IDX_ISR_1,
    HDMI_TIMER_IDX_VIDEO,
    HDMI_TIMER_IDX_AUDIO,
    HDMI_TIMER_IDX_INFO,
    HDMI_TIMER_IDX_CEC,
    HDMI_TIMER_IDX_CEC_SEND,
    HDMI_TIMER_IDX_COM,
    HDMI_TIMER_IDX_BUTT
};

/**
* @brief RX video color depth
*/
typedef enum
{
	RX_VBUS_WIDTH_24, //!< Color Depth is 8 bit per channel, 24 bit per pixel
	RX_VBUS_WIDTH_30, //!< Color Depth is 10 bit per channel, 30 bit per pixel 
	RX_VBUS_WIDTH_36, //!< Color Depth is 12 bit per channel, 36 bit per pixel
	RX_VBUS_WIDTH_48, //!< Color Depth is 16 bit per channel, 48 bit per pixel
}
hdmi_bus_width;


typedef struct
{
	HI_BOOL bCheckHdcpOnVsync;
	HI_U32  u32HdcpFailCnt;
	HI_U32  au32ShadowIntMask[INTR_BUTT];
	HI_U32  u32Int[INTR_BUTT];
    HI_U32  u32ResChgChkTimer;
}hdmi_isr_type;

typedef enum
{
	ColorSpace_RGB,
    ColorSpace_YCbCr444,
	ColorSpace_YCbCr422,
	ColorSpace_BUTT
} color_space_type;

typedef enum
{
	Colorimetry_NoInfo,
	Colorimetry_ITU601,
	Colorimetry_ITU709,
	Colorimetry_Extended, // if extended, but unknown
	Colorimetry_xv601 = 10,
	Colorimetry_xv709,
} colorimetry_type;




typedef struct
{
	HI_BOOL	AVI		;
	HI_BOOL	SPD		;
	HI_BOOL	Audio	;
	HI_BOOL	VSIF	;
	HI_BOOL	ISRC1	;
	HI_BOOL	ISRC2	;
	HI_BOOL	ACP		;
	HI_BOOL	GBD		;
}
hdmi_packets_type;


typedef struct
{
	hdmi_packets_type   strReceivedPacket;
	hdmi_packets_type   strFailedPackets;
	hdmi_acp_type       enAcpType;
	HI_U8               u8AcpCntdwn;
	HI_U8               u8AcpIntCntdwn;
	HI_U8               u8AvMask; // RX AV muting sources
	HI_U16              no_avi_mute_timeout;
    HI_U8               u8AcpCnt;
	//HI_BOOL             bISRC_TimerStart;
    
	//HI_BOOL vsif_spd_timer_start;
	HI_BOOL bIsrcRetransmitted;
	HI_BOOL bSpdReceived; // set on any SPD reception (even with incorrect check sum)
	HI_BOOL bVsifReceived; // set on any VSIF reception, not necessay HDMI VSIF
	HI_BOOL bFoundHdmiVsif;
	HI_U16 u16IsrcTimer;
	HI_U16 u16VsifTimer;
	HI_U16 u16NoHdmiVsifTimeout;
    HI_U32 au32SpdBuffer[SPD_BUFFER_LENGTH];
    HI_U8  u8VsifState;
    HI_U16 u16ElapseTime[2];
    HI_U16 u16IsrcCounter;
    HI_U8 u8IsrcState;
    HI_U32 au32Isrc1Buffer[ISRC1_BUFFER_LENGTH];
    HI_U32 u32NoAviMuteTimeout;
}
hdmi_info_type;

typedef struct
{
	HI_U32		u32VideoIdx;
	HI_U8		u8Cea861Vic;
	HI_U8		u8HdmiVic;
	HI_U8		u8Hdmi3dStructure;
	HI_U8		u8Hdmi3dExtData;
	HI_U32		u32PixFreq; // pixel frequency in 10kHz units
	HI_U16      u16Vactive;
    HI_U16      u16Hactive;
    HI_U8       u8FrameRate;
	HI_BOOL     bAviReceived;
	HI_BOOL	    bHdmi3dVsifReceived;
	HI_BOOL 	bHdmiVicReceived;
	/*libo@201404*/
	HI_BOOL     bInterlaced	; // true for interlaced video
    colorimetry_type    eColorM;
    color_space_type    eColorSpace; 
	/*libo@201404*/
    
} hdmi_timing_struct;

struct hdmistatus{
        HI_U32                  u32DevId;
        HI_U32                  u32DevicRev;
        HI_BOOL                 bConnect;
        HI_BOOL                 bAuthStartRequest;
        HI_BOOL                 bKsvValid;
		HI_U32                  u32HdmiState;
        HI_U32                  u32SleepTime;
        HI_BOOL                 bHdmiMode;          /* 1: HDMI, 0: DVI */
        hdmi_timing_struct      strTimingInfo;
        HI_U32                  au32AviData[AVI_LENGTH];
        HI_U32                  u32AviVersion;
        hdmi_info_type          StrInfo;
        hdmi_isr_type           strRxInt;
        hdmi_audio_type         strAudio;
        hdmi_bus_width          eInputWidth;
        HI_U32                  Timer[HDMI_TIMER_IDX_BUTT];
        HI_BOOL                 bDdcEn;
        HI_BOOL                 bRtEn;
        HI_U32                  u32RtOffCnt;
        HI_BOOL                 bRtOffStart;
        HI_BOOL                 bRtOnReq;
        HI_BOOL                 bRtState;
};

typedef struct {
    HI_U16   deviceType;     // 0 - Device is a TV.
                             // 1 - Device is a Recording device
                             // 2 - Device is a reserved device
                             // 3 - Device is a Tuner
                             // 4 - Device is a Playback device
                             // 5 - Device is an Audio System
    HI_U16       port;       // HDMI port index for this device.
    HI_U16       selected;   // This logical address was selected on this port
    HI_U16       cecPA;      // CEC Physical address of the device.
} CecLogicalDevice;

typedef enum {
    CECOP_SENDPING                  = 0x100,    // Special opcode for SiiDrvCpiWrite()
    CECOP_FEATURE_ABORT             = 0x00,
    CECOP_IMAGE_VIEW_ON             = 0x04,
    CECOP_TUNER_STEP_INCREMENT      = 0x05,     // N/A
    CECOP_TUNER_STEP_DECREMENT      = 0x06,     // N/A
    CECOP_TUNER_DEVICE_STATUS       = 0x07,     // N/A
    CECOP_GIVE_TUNER_DEVICE_STATUS  = 0x08,     // N/A
    CECOP_RECORD_ON                 = 0x09,     // N/A
    CECOP_RECORD_STATUS             = 0x0A,     // N/A
    CECOP_RECORD_OFF                = 0x0B,     // N/A
    CECOP_TEXT_VIEW_ON              = 0x0D,
    CECOP_RECORD_TV_SCREEN          = 0x0F,     // N/A
    CECOP_GIVE_DECK_STATUS          = 0x1A,
    CECOP_DECK_STATUS               = 0x1B,
    CECOP_SET_MENU_LANGUAGE         = 0x32,
    CECOP_CLEAR_ANALOGUE_TIMER      = 0x33,     // Spec 1.3A
    CECOP_SET_ANALOGUE_TIMER        = 0x34,     // Spec 1.3A
    CECOP_TIMER_STATUS              = 0x35,     // Spec 1.3A
    CECOP_STANDBY                   = 0x36,
    CECOP_PLAY                      = 0x41,
    CECOP_DECK_CONTROL              = 0x42,
    CECOP_TIMER_CLEARED_STATUS      = 0x43,     // Spec 1.3A
    CECOP_USER_CONTROL_PRESSED      = 0x44,
    CECOP_USER_CONTROL_RELEASED     = 0x45,
    CECOP_GIVE_OSD_NAME             = 0x46,
    CECOP_SET_OSD_NAME              = 0x47,
    CECOP_SET_OSD_STRING            = 0x64,
    CECOP_SET_TIMER_PROGRAM_TITLE   = 0x67,     // Spec 1.3A
    CECOP_SYSTEM_AUDIO_MODE_REQUEST = 0x70,     // Spec 1.3A
    CECOP_GIVE_AUDIO_STATUS         = 0x71,     // Spec 1.3A
    CECOP_SET_SYSTEM_AUDIO_MODE     = 0x72,     // Spec 1.3A
    CECOP_REPORT_AUDIO_STATUS       = 0x7A,     // Spec 1.3A
    CECOP_GIVE_SYSTEM_AUDIO_MODE_STATUS = 0x7D, // Spec 1.3A
    CECOP_SYSTEM_AUDIO_MODE_STATUS  = 0x7E,     // Spec 1.3A
    CECOP_ROUTING_CHANGE            = 0x80,
    CECOP_ROUTING_INFORMATION       = 0x81,
    CECOP_ACTIVE_SOURCE             = 0x82,
    CECOP_GIVE_PHYSICAL_ADDRESS     = 0x83,
    CECOP_REPORT_PHYSICAL_ADDRESS   = 0x84,
    CECOP_REQUEST_ACTIVE_SOURCE     = 0x85,
    CECOP_SET_STREAM_PATH           = 0x86,
    CECOP_DEVICE_VENDOR_ID          = 0x87,
    CECOP_VENDOR_COMMAND            = 0x89,
    CECOP_VENDOR_REMOTE_BUTTON_DOWN = 0x8A,
    CECOP_VENDOR_REMOTE_BUTTON_UP   = 0x8B,
    CECOP_GIVE_DEVICE_VENDOR_ID     = 0x8C,
    CECOP_MENU_REQUEST              = 0x8D,
    CECOP_MENU_STATUS               = 0x8E,
    CECOP_GIVE_DEVICE_POWER_STATUS  = 0x8F,
    CECOP_REPORT_POWER_STATUS       = 0x90,
    CECOP_GET_MENU_LANGUAGE         = 0x91,
    CECOP_SELECT_ANALOGUE_SERVICE   = 0x92,     // Spec 1.3A    N/A
    CECOP_SELECT_DIGITAL_SERVICE    = 0x93,     //              N/A
    CECOP_SET_DIGITAL_TIMER         = 0x97,     // Spec 1.3A
    CECOP_CLEAR_DIGITAL_TIMER       = 0x99,     // Spec 1.3A
    CECOP_SET_AUDIO_RATE            = 0x9A,     // Spec 1.3A
    CECOP_INACTIVE_SOURCE           = 0x9D,     // Spec 1.3A
    CECOP_CEC_VERSION               = 0x9E,     // Spec 1.3A
    CECOP_GET_CEC_VERSION           = 0x9F,     // Spec 1.3A
    CECOP_VENDOR_COMMAND_WITH_ID    = 0xA0,     // Spec 1.3A
    CECOP_CLEAR_EXTERNAL_TIMER      = 0xA1,     // Spec 1.3A
    CECOP_SET_EXTERNAL_TIMER        = 0xA2,     // Spec 1.3A

    CECOP_REPORT_SHORT_AUDIO    	= 0xA3,     // Spec 1.4
    CECOP_REQUEST_SHORT_AUDIO    	= 0xA4,     // Spec 1.4

    CECOP_INITIATE_ARC              = 0xC0,
    CECOP_REPORT_ARC_INITIATED      = 0xC1,
    CECOP_REPORT_ARC_TERMINATED     = 0xC2,

    CECOP_REQUEST_ARC_INITIATION    = 0xC3,
    CECOP_REQUEST_ARC_TERMINATION   = 0xC4,
    CECOP_TERMINATE_ARC             = 0xC5,

    CDCOP_HEADER                    = 0xF8,
    CECOP_ABORT                     = 0xFF,

} CecOpcodes;

typedef enum {
    RESULT_CEC_SUCCESS,             // Success result code
    RESULT_CEC_FAIL,                // General Failure result code

    RESULT_CEC_INVALID_LOGICAL_ADDRESS,
    RESULT_CEC_INVALID_PHYSICAL_ADDRESS,
    RESULT_CEC_INVALID_PORT_INDEX,
    RESULT_CEC_NOT_ADJACENT,
    RESULT_CEC_NO_PA_FOUND,
    RESULT_CEC_TASK_QUEUE_FULL,

} Drv_cec_error;


typedef enum
{
    TX_IDLE          = 0,
    TX_WAITCMD,
    TX_SENDING,
    TX_SENDACKED,
    TX_SENDFAILED,
    TX_TIMEOUT
} cec_tx_state;

typedef struct {
    HI_U8           u8SrcDestAddr;            // Source in upper nibble, dest in lower nibble
    CecOpcodes      enOpcode;
    HI_U32          au32Args[CEC_MAX_CMD_SIZE];
    HI_U8           u8ArgCount;
    cec_tx_state    enTxState;
    HI_U16          u16MsgId;
} cec_msg;

typedef enum    // Operands for <Power Status> Opcode
{
    CEC_POWERSTATUS_ON              = 0x00,
    CEC_POWERSTATUS_STANDBY         = 0x01,
    CEC_POWERSTATUS_STANDBY_TO_ON   = 0x02,
    CEC_POWERSTATUS_ON_TO_STANDBY   = 0x03,
} CecPowerstatus;


typedef struct
{
    HI_U16          u16InIndex;
    HI_U16          u16OutIndex;
    HI_U32          u32Timeout;
    HI_U32          u32Start;
    cec_msg         queue[4];
} cec_msg_queue;

typedef struct {
    HI_BOOL         bRxState;
    cec_tx_state    enTxState;
    HI_U8           u8CecError;
    HI_U16          u16MsgId;

} cpi_status;

typedef enum {
    RESULT_CPI_SUCCESS,             // Success result code
    RESULT_CPI_FAIL,                // General Failure result code
    RESULT_CPI_WRITE_QUEUE_FULL,    // CPI Write Queue was full
} DrvCpiError;

typedef struct {
    //int                 structVersion;
    //int                 instanceIndex;
    DrvCpiError         enLastResultCode;     // Contains the result of the last API function called
    HI_U16              u16CpiStatus;

    cpi_status          strCecStatus;          // Valid only after interrupt

    //int                 deviceId;           // Device I2C address for instance registers.
    //SiiSystemTypes_t    systemType;         // Type of system (SINK, REPEATER, etc.)
    HI_U8               u8LogicalAddr;        // CEC logical address for this instance

    cec_msg_queue       strMsgQueueOut;        // CEC output message queue

}cpi_data;

typedef enum {
    CECTASK_IDLE                 = 0,
    CECTASK_RX_ENUMERATE_SINK,
    CECTASK_RX_ENUMERATE,
    CECTASK_TX_ENUMERATE,
    CECTASK_TX_ENUMERATE_SINK,
    CECTASK_ONETOUCH,
    CECTASK_SENDMSG,

    CECTASK_COUNT
} cec_tasks;

typedef enum {
    CecTaskQueueStateIdle     = 0,
    CecTaskQueueStateQueued,
    CecTaskQueueStateRunning,
} cec_queue_states;

typedef enum {
    CPI_IDLE            = 0,
    CPI_WAIT_ACK,
    CPI_WAIT_RESPONSE,
    CPI_RESPONSE
} cpi_states;


typedef struct {
    cec_tasks           enTask;       // This CEC task #
    cec_queue_states    enQueueState; // Task running or waiting to be run
    HI_U8               taskState;  // Internal task state
    cpi_states          enCpiState;   // State of CPI transactions
    HI_U8               destLA;     // Logical address of target device
    HI_U8               taskData1;  // BYTE Data unique to task.
    HI_U16              taskData2;  // WORD Data unique to task.
    HI_U16              u16MsgId;      // Helps serialize CPI transactions

} cec_task_state;

typedef enum {
    CEC_LOGADDR_TV          = 0x00,
    CEC_LOGADDR_RECDEV1     = 0x01,
    CEC_LOGADDR_RECDEV2     = 0x02,
    CEC_LOGADDR_TUNER1      = 0x03,     // STB1 in Spev v1.3
    CEC_LOGADDR_PLAYBACK1   = 0x04,     // DVD1 in Spev v1.3
    CEC_LOGADDR_AUDSYS      = 0x05,
    CEC_LOGADDR_TUNER2      = 0x06,     // STB2 in Spec v1.3
    CEC_LOGADDR_TUNER3      = 0x07,     // STB3 in Spec v1.3
    CEC_LOGADDR_PLAYBACK2   = 0x08,     // DVD2 in Spec v1.3
    CEC_LOGADDR_RECDEV3     = 0x09,
    CEC_LOGADDR_TUNER4      = 0x0A,     // RES1 in Spec v1.3
    CEC_LOGADDR_PLAYBACK3   = 0x0B,     // RES2 in Spec v1.3
    CEC_LOGADDR_RES3        = 0x0C,
    CEC_LOGADDR_RES4        = 0x0D,
    CEC_LOGADDR_FREEUSE     = 0x0E,
    CEC_LOGADDR_UNREGORBC   = 0x0F

} cec_logical_addr;

typedef struct {
    HI_U8               u8LogicAddr;
    HI_BOOL             bEnable;
    CecPowerstatus      enPowerState;
    HI_U8               u8SrcLogicAddr;
    HI_U16              u16PhyAddr;
    HI_U8               u8PaShift;
    HI_U16              u16PaChildMask;
    CecLogicalDevice    astrLogicalDeviceInfo[16];
    //HI_BOOL             bRxState;
    //HI_U8               u8Error;
    HI_U16              u16StatusFlag;
    HI_BOOL             bInt;
    cec_msg             strRxMsg;
    HI_BOOL             bActiveSource;
    CecPowerstatus      enSourcePowerStatus;
    //cec_msg_queue       strMsgQueueOut;
    cpi_data            strCpi;
    cec_tasks           enCurrentTask;
    cec_task_state      astrTaskQueue[TASK_QUEUE_LENGTH];
    HI_U16              u16TaskQueueIn;
    HI_U16              u16TaskQueueOut;
    cec_logical_addr    enActiveSrcLogical;
    HI_U16              u16ActiveSrcPhysical;
    HI_U8               u8PortSel;
    Drv_cec_error       enLastResultCode;
}cec_status;



void HDMI_VDO_Initial(void);
//void HDMI_AUD_Initial(void);

//HI_BOOL HDMI_AUD_IsAvMute(void);
//void HDMI_SYS_SwReset(void);

//void HDMI_SW_ResetInfoFrameData(void);
//void HDMI_AUD_UpdateOnAcp(hdmi_acp_type);
//void HDMI_AUD_ExceptionsOnOff(HI_BOOL);
//void HDMI_AUD_Stop(HI_BOOL);
#if 0
void HDMI_INFO_AvMuteRequest(HI_BOOL, HI_U32);
#endif
//void HDMI_AUD_Restart(void);
//void HDMI_AUD_UpdateFs(void);
//void HDMI_AUD_AacDone(void);

//void HDMI_AUD_AssertOff(void);
//void HDMI_AUD_StreamTypeChanged(void);
//void HDMI_AUD_OnChannelStatusChg(void);

//void HDMI_HDCP_Reset(void);
//void HDMI_SYS_DdcOnOff(HI_BOOL);
//void HDMI_SYS_DisPipe(void);
//void HDMI_SYS_InputOnOff(HI_BOOL);
//void HDMI_SYS_ServeRt(void);

//HI_S32 HDMIRX_ProcShow(struct seq_file *s);

HI_S32 HDMI_Connect(HI_VOID);
void HDMI_DisConnect(void);
HI_S32 HDMIRX_GetStatus(HI_UNF_SIG_STATUS_E *pstSigStatus);
HI_S32 HDMIRX_GetTiming(HI_UNF_HDMIRX_TIMING_INFO_S *pstTiming);
HI_S32 HDMIRX_DRV_CTRL_GetAudioStatus(HI_UNF_SIG_STATUS_E *penSigSta);
HI_S32 HDMIRX_DRV_CTRL_GetAudioInfo(HI_UNF_AI_HDMI_ATTR_S *pstAudioInfo);
HI_S32 HDMIRX_DRV_CTRL_GetHdcpStatus(HI_BOOL *pbHdcp);
HI_S32 HDMIRX_DRV_CTRL_LoadHdcp(HI_UNF_HDMIRX_HDCP_S *pstHdcpKey);
HI_S32 HDMIRX_DRV_CTRL_UpdateEdid(HI_UNF_HDMIRX_EDID_S *pstEdid);




#ifdef __cplusplus
 #if __cplusplus
}
 #endif
#endif /* __cplusplus */

#endif  /* __DRV_HDMIRX_H__ */


