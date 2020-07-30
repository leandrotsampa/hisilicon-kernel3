//******************************************************************************
//  Copyright (C), 2007-2014, Hisilicon Technologies Co., Ltd.
//
//******************************************************************************
// File name     : drv_hdmirx_cec.c
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
//#include <linux/sched.h>
//#include <linux/delay.h>
#include <linux/string.h>


#include "hi_type.h"
//#include "command.h"
//#include "int.h"
#include "hal_hdmirx_reg.h"
#include "hal_hdmirx.h"
#include "drv_hdmirx_isr.h"

#include "drv_hdmirx.h"
/***********************************************************************************************************/
#define MAKE_SRCDEST( src, dest)    ((( (src) << 4) & 0xF0) | ((dest) & 0x0F))
#define ACTIVE_TASK     Cec_ctx.astrTaskQueue[Cec_ctx.u16TaskQueueOut]

typedef enum {
    CEC_SHORTPULSE       = 0x80,
    CEC_BADSTART         = 0x40,
    CEC_RXOVERFLOW       = 0x20,
    CEC_ERRORS           = (CEC_SHORTPULSE | CEC_BADSTART | CEC_RXOVERFLOW)
} CecError;

typedef enum {
    CEC_INT          = 0x0001,
    CEC_STATUS_VALID = 0x0002,
    CEC_DISABLED     = 0x0004,
} DrvCecStatus;

typedef enum
{
    CEC_PORT_CHANGE          = 0x0001,
    CEC_POWERSTATE_CHANGE    = 0x0002,
    CEC_SOURCE_LOST          = 0x0004,
} CecStatus;

typedef enum      // Operand for <Play> Opcode
{
    CEC_PLAY_SCAN_FWD_MIN           = 0x05,
    CEC_PLAY_SCAN_FWD_MED           = 0x06,
    CEC_PLAY_SCAN_FWD_MAX           = 0x07,
    CEC_PLAY_SCAN_REV_MIN           = 0x09,
    CEC_PLAY_SCAN_REV_MED           = 0x0A,
    CEC_PLAY_SCAN_REV_MAX           = 0x0B,
    CEC_PLAY_SLOW_FWD_MIN           = 0x15,
    CEC_PLAY_SLOW_FWD_MED           = 0x16,
    CEC_PLAY_SLOW_FWD_MAX           = 0x17,
    CEC_PLAY_SLOW_REV_MIN           = 0x19,
    CEC_PLAY_SLOW_REV_MED           = 0x1A,
    CEC_PLAY_SLOW_REV_MAX           = 0x1B,
    CEC_PLAY_REVERSE                = 0x20,
    CEC_PLAY_FORWARD                = 0x24,
    CEC_PLAY_STILL                  = 0x25
} CecPlayModes;

typedef enum   // Operands for <Feature Abort> Opcode
{
    CECAR_UNRECOG_OPCODE            = 0x00,
    CECAR_NOT_CORRECT_MODE,
    CECAR_CANT_PROVIDE_SOURCE,
    CECAR_INVALID_OPERAND,
    CECAR_REFUSED,
    CECAR_UNABLE_TO_DETERMINE
} CecAbortReason;

typedef enum   // CEC device types
{
    CEC_DT_TV,
    CEC_DT_RECORDING_DEVICE,
    CEC_DT_RSVD,
    CEC_DT_TUNER,
    CEC_DT_PLAYBACK,
    CEC_DT_AUDIO_SYSTEM,
    CEC_DT_PURE_CEC_SWITCH,
    CEC_DT_VIDEO_PROCESSOR,

    CEC_DT_COUNT
} CecDeviceTypeS;



typedef struct {
	cec_msg     *pMsg;
	HI_BOOL     bTx;
} CecLogger;

HI_U8 l_devTypes[16] ={
    CEC_LOGADDR_TV,
    CEC_LOGADDR_RECDEV1,
    CEC_LOGADDR_RECDEV1,
    CEC_LOGADDR_TUNER1,
    CEC_LOGADDR_PLAYBACK1,
    CEC_LOGADDR_AUDSYS,
    CEC_LOGADDR_TUNER1,
    CEC_LOGADDR_TUNER1,
    CEC_LOGADDR_PLAYBACK1,
    CEC_LOGADDR_RECDEV1,
    CEC_LOGADDR_TUNER1,
    CEC_LOGADDR_PLAYBACK1,
    CEC_LOGADDR_RECDEV2,
    CEC_LOGADDR_RECDEV2,
    CEC_LOGADDR_TV,
    CEC_LOGADDR_TV
};

cec_status Cec_ctx;
extern struct hdmistatus hdmi_ctx;
void HDMI_CEC_SetLogicAddr(cec_logical_addr enLogicAddr)
{
    HI_U32 capture_address[2];
    HI_U8 capture_addr_sel = 0x01;

    capture_address[0] = 0;
    capture_address[1] = 0;
    if ( enLogicAddr == 0xFF )
    {
        enLogicAddr = 0x0F;  // unregistered LA
    }
    else if ( enLogicAddr < 8 )
    {
        capture_addr_sel = capture_addr_sel << enLogicAddr;
        capture_address[0] = capture_addr_sel;
    }
    else
    {
        capture_addr_sel   = capture_addr_sel << ( enLogicAddr - 8 );
        capture_address[1] = capture_addr_sel;
    }

        // Set Capture Address

    HDMI_HAL_RegWriteBlock( CEC_CAPTURE_ID0, capture_address, 2 );
    HDMI_HAL_RegWriteFldAlign(CEC_TX_INIT, reg_cec_init_id, enLogicAddr&0x0f );

    Cec_ctx.u8LogicAddr = enLogicAddr&0x0f;
}

void HDMI_CEC_SetPhyAddr(HI_U16 u16PhyAddr)
{
    HI_U8   u8Index;
    HI_U16  u16Mask;

    Cec_ctx.u16PhyAddr = u16PhyAddr;
    u16Mask = 0xf0;
    for (u8Index = 1; u8Index < 4; u8Index++) {
        if ((u16PhyAddr & u16Mask) != 0) {
            break;
        }
        u16Mask <<= 4;
    }
    Cec_ctx.u8PaShift = (u8Index-1)<<2;
    Cec_ctx.u16PaChildMask = 0x000f << Cec_ctx.u8PaShift;
}

void HDMI_CEC_Enable(HI_BOOL bEnable)
{
    Cec_ctx.bEnable = bEnable;
    if(bEnable) {
        
        HDMI_HAL_RegWrite(CEC_CONFIG_CPI, 0);
        HDMI_HAL_RegWriteFldAlign(CEC_RX_CONTROL, reg_cec_rx_clr_all, HI_TRUE);
        HDMI_HAL_RegSetBits(CEC_INT_STATUS_0, rx_command_received | tx_fifo_empty | tx_transmit_buffer_change, HI_TRUE);
        HDMI_HAL_RegSetBits(CEC_INT_STATUS_1, rx_start_bit_irregular | tx_frame_retx_count_exceed | rx_short_pulse_detected| rx_fifo_overrun_error, HI_TRUE);
        HDMI_HAL_RegSetBits(CEC_INT_ENABLE_0, rx_command_received | tx_fifo_empty | tx_transmit_buffer_change, HI_TRUE);
        HDMI_HAL_RegSetBits(CEC_INT_ENABLE_1, rx_start_bit_irregular | tx_frame_retx_count_exceed | rx_short_pulse_detected| rx_fifo_overrun_error, HI_TRUE);
        #if 0
        HDMI_HAL_RegWriteFldAlign(CEC_INT_STATUS_0, rx_command_received, HI_TRUE);
        HDMI_HAL_RegWriteFldAlign(CEC_INT_STATUS_0, tx_fifo_empty, HI_TRUE);
        HDMI_HAL_RegWriteFldAlign(CEC_INT_STATUS_0, tx_transmit_buffer_change, HI_TRUE);

        
        HDMI_HAL_RegWriteFldAlign(CEC_INT_STATUS_1, rx_start_bit_irregular, HI_TRUE);
        HDMI_HAL_RegWriteFldAlign(CEC_INT_STATUS_1, tx_frame_retx_count_exceed, HI_TRUE);
        HDMI_HAL_RegWriteFldAlign(CEC_INT_STATUS_1, rx_short_pulse_detected, HI_TRUE);
        HDMI_HAL_RegWriteFldAlign(CEC_INT_STATUS_1, rx_fifo_overrun_error, HI_TRUE);

        HDMI_HAL_RegWriteFldAlign(CEC_INT_ENABLE_0, rx_command_received, HI_TRUE);
        HDMI_HAL_RegWriteFldAlign(CEC_INT_ENABLE_0, tx_fifo_empty, HI_TRUE);
        HDMI_HAL_RegWriteFldAlign(CEC_INT_ENABLE_0, tx_transmit_buffer_change, HI_TRUE);

        HDMI_HAL_RegWriteFldAlign(CEC_INT_ENABLE_1, rx_start_bit_irregular, HI_TRUE);
        HDMI_HAL_RegWriteFldAlign(CEC_INT_ENABLE_1, tx_frame_retx_count_exceed, HI_TRUE);
        HDMI_HAL_RegWriteFldAlign(CEC_INT_ENABLE_1, rx_short_pulse_detected, HI_TRUE);
        HDMI_HAL_RegWriteFldAlign(CEC_INT_ENABLE_1, rx_fifo_overrun_error, HI_TRUE);
        #endif
        Cec_ctx.strCpi.u16CpiStatus &= ~CEC_DISABLED;
        
        HDMIRX_DEBUG(" \n CEC_INT_ENABLE_0 = %x \n", HDMI_HAL_RegRead(CEC_INT_ENABLE_0));
    }
}

HI_U8* HDMI_CEC_TranslateOpcodeName ( cec_msg *pMsg )
    {
    HI_U8   *pName, *pOperand;


    switch ( pMsg->enOpcode)
        {
        case CECOP_SENDPING:                    pName = "PING";                         break;
        case CECOP_FEATURE_ABORT:               pName = "FEATURE_ABORT";                break;
        case CECOP_IMAGE_VIEW_ON:               pName = "IMAGE_VIEW_ON";                break;
        case CECOP_TUNER_STEP_INCREMENT:        pName = "TUNER_STEP_INCREMENT";         break;
        case CECOP_TUNER_STEP_DECREMENT:        pName = "TUNER_STEP_DECREMENT";         break;
        case CECOP_TUNER_DEVICE_STATUS:         pName = "TUNER_DEVICE_STATUS";          break;
        case CECOP_GIVE_TUNER_DEVICE_STATUS:    pName = "GIVE_TUNER_DEVICE_STATUS";     break;
        case CECOP_RECORD_ON:                   pName = "RECORD_ON";                    break;
        case CECOP_RECORD_STATUS:               pName = "RECORD_STATUS";                break;
        case CECOP_RECORD_OFF:                  pName = "RECORD_OFF";                   break;
        case CECOP_TEXT_VIEW_ON:                pName = "TEXT_VIEW_ON";                 break;
        case CECOP_RECORD_TV_SCREEN:            pName = "RECORD_TV_SCREEN";             break;
        case CECOP_GIVE_DECK_STATUS:            pName = "GIVE_DECK_STATUS";             break;
        case CECOP_DECK_STATUS:                 pName = "DECK_STATUS";                  break;
        case CECOP_SET_MENU_LANGUAGE:           pName = "SET_MENU_LANGUAGE";            break;
        case CECOP_CLEAR_ANALOGUE_TIMER:        pName = "CLEAR_ANALOGUE_TIMER";         break;
        case CECOP_SET_ANALOGUE_TIMER:          pName = "SET_ANALOGUE_TIMER";           break;
        case CECOP_TIMER_STATUS:                pName = "TIMER_STATUS";                 break;
        case CECOP_STANDBY:                     pName = "STANDBY";                      break;
        case CECOP_PLAY:
            pName = "PLAY";
            switch ( pMsg->au32Args[0])
                {
                case CEC_PLAY_SCAN_FWD_MIN: pOperand = "SCAN_FWD_MIN";  break;
                case CEC_PLAY_SCAN_FWD_MED: pOperand = "SCAN_FWD_MED";  break;
                case CEC_PLAY_SCAN_FWD_MAX: pOperand = "SCAN_FWD_MAX";  break;
                case CEC_PLAY_SCAN_REV_MIN: pOperand = "SCAN_REV_MIN";  break;
                case CEC_PLAY_SCAN_REV_MED: pOperand = "SCAN_REV_MED";  break;
                case CEC_PLAY_SCAN_REV_MAX: pOperand = "SCAN_REV_MAX";  break;
                case CEC_PLAY_SLOW_FWD_MIN: pOperand = "SLOW_FWD_MIN";  break;
                case CEC_PLAY_SLOW_FWD_MED: pOperand = "SLOW_FWD_MED";  break;
                case CEC_PLAY_SLOW_FWD_MAX: pOperand = "SLOW_FWD_MAX";  break;
                case CEC_PLAY_SLOW_REV_MIN: pOperand = "SLOW_REV_MIN";  break;
                case CEC_PLAY_SLOW_REV_MED: pOperand = "SLOW_REV_MED";  break;
                case CEC_PLAY_SLOW_REV_MAX: pOperand = "SLOW_REV_MAX";  break;
                case CEC_PLAY_REVERSE:      pOperand = "REVERSE";       break;
                case CEC_PLAY_FORWARD:      pOperand = "FORWARD";       break;
                case CEC_PLAY_STILL:        pOperand = "STILL";         break;
                default:                    pOperand = "UNKNOWN";       break;
                };
            #if 0
            SkSprintf( l_descBuffer, "%s (%s)", pName, pOperand );
            pName = l_descBuffer;
            #endif
            break;
        case CECOP_DECK_CONTROL:
            pName = "DECK_CONTROL";
            //SkSprintf( l_descBuffer, "%s (%s)", pName, deckControlMsgs[ pMsg->args[0] - 1] );
            //pName = l_descBuffer;
            break;
        case CECOP_TIMER_CLEARED_STATUS:        pName = "TIMER_CLEARED_STATUS";         break;
        case CECOP_USER_CONTROL_PRESSED:        pName = "USER_CONTROL_PRESSED";         break;
        case CECOP_USER_CONTROL_RELEASED:       pName = "USER_CONTROL_RELEASED";        break;
        case CECOP_GIVE_OSD_NAME:               pName = "GIVE_OSD_NAME";                break;
        case CECOP_SET_OSD_NAME:
        {
            pName = "SET_OSD_NAME";
            #if 0
            outIndex = SkSprintf( l_descBuffer, "%s (", pName );
            for ( i = 0; i < pMsg->argCount; i++ )
            {
                l_descBuffer[ outIndex++] = pMsg->args[i];
            }
            l_descBuffer[ outIndex] = 0;

            strncat( l_descBuffer, ")",strlen(")") );
            pName = l_descBuffer;
            #endif
            break;
        }
        case CECOP_SET_OSD_STRING:
        {
            pName = "SET_OSD_STRING";
            #if 0
            outIndex = SkSprintf( l_descBuffer, "%s (", pName );
            for ( i = 1; i < pMsg->argCount; i++ )
                l_descBuffer[ outIndex++] = pMsg->args[i];
            l_descBuffer[ outIndex] = 0;

            strncat( l_descBuffer, ")",strlen(")") );
            pName = l_descBuffer;
            #endif
            break;
        }
        case CECOP_SET_TIMER_PROGRAM_TITLE:     pName = "SET_TIMER_PROGRAM_TITLE";      break;
        case CECOP_SYSTEM_AUDIO_MODE_REQUEST:   pName = "SYSTEM_AUDIO_MODE_REQUEST";    break;
        case CECOP_GIVE_AUDIO_STATUS:           pName = "GIVE_AUDIO_STATUS";            break;
        case CECOP_SET_SYSTEM_AUDIO_MODE:       pName = "SET_SYSTEM_AUDIO_MODE";        break;
        case CECOP_REPORT_AUDIO_STATUS:         pName = "REPORT_AUDIO_STATUS";          break;
        case CECOP_GIVE_SYSTEM_AUDIO_MODE_STATUS: pName = "GIVE_SYSTEM_AUDIO_MODE_STATUS";  break;
        case CECOP_SYSTEM_AUDIO_MODE_STATUS:    pName = "SYSTEM_AUDIO_MODE_STATUS";     break;
        case CECOP_ROUTING_CHANGE:              pName = "ROUTING_CHANGE";               break;
        case CECOP_ROUTING_INFORMATION:         pName = "ROUTING_INFORMATION";          break;
        case CECOP_ACTIVE_SOURCE:               pName = "ACTIVE_SOURCE";                break;
        case CECOP_GIVE_PHYSICAL_ADDRESS:       pName = "GIVE_PHYSICAL_ADDRESS";        break;
        case CECOP_REPORT_PHYSICAL_ADDRESS:     pName = "REPORT_PHYSICAL_ADDRESS";      break;
        case CECOP_REQUEST_ACTIVE_SOURCE:       pName = "REQUEST_ACTIVE_SOURCE";        break;
        case CECOP_SET_STREAM_PATH:             pName = "SET_STREAM_PATH";              break;
        case CECOP_DEVICE_VENDOR_ID:            pName = "DEVICE_VENDOR_ID";             break;
        case CECOP_VENDOR_COMMAND:              pName = "VENDOR_COMMAND";               break;
        case CECOP_VENDOR_REMOTE_BUTTON_DOWN:   pName = "VENDOR_REMOTE_BUTTON_DOWN";    break;
        case CECOP_VENDOR_REMOTE_BUTTON_UP:     pName = "VENDOR_REMOTE_BUTTON_UP";      break;
        case CECOP_GIVE_DEVICE_VENDOR_ID:       pName = "GIVE_DEVICE_VENDOR_ID";        break;
        case CECOP_MENU_REQUEST:                pName = "MENU_REQUEST";                 break;
        case CECOP_MENU_STATUS:                 pName = "MENU_STATUS";                  break;
        case CECOP_GIVE_DEVICE_POWER_STATUS:    pName = "GIVE_DEVICE_POWER_STATUS";     break;
        case CECOP_REPORT_POWER_STATUS:         pName = "REPORT_POWER_STATUS";          break;
        case CECOP_GET_MENU_LANGUAGE:           pName = "GET_MENU_LANGUAGE";            break;
        case CECOP_SELECT_ANALOGUE_SERVICE:     pName = "SELECT_ANALOGUE_SERVICE";      break;
        case CECOP_SELECT_DIGITAL_SERVICE:      pName = "SELECT_DIGITAL_SERVICE";       break;
        case CECOP_SET_DIGITAL_TIMER:           pName = "SET_DIGITAL_TIMER";            break;
        case CECOP_CLEAR_DIGITAL_TIMER:         pName = "CLEAR_DIGITAL_TIMER";          break;
        case CECOP_SET_AUDIO_RATE:              pName = "SET_AUDIO_RATE";               break;
        case CECOP_INACTIVE_SOURCE:             pName = "INACTIVE_SOURCE";              break;
        case CECOP_CEC_VERSION:                 pName = "CEC_VERSION";                  break;
        case CECOP_GET_CEC_VERSION:             pName = "GET_CEC_VERSION";              break;
        case CECOP_VENDOR_COMMAND_WITH_ID:      pName = "VENDOR_COMMAND_WITH_ID";       break;
        case CECOP_CLEAR_EXTERNAL_TIMER:        pName = "CLEAR_EXTERNAL_TIMER";         break;
        case CECOP_SET_EXTERNAL_TIMER:          pName = "SET_EXTERNAL_TIMER";           break;
        case CECOP_REPORT_SHORT_AUDIO:          pName = "REPORT_SHORT_AUDIO";           break;
        case CECOP_REQUEST_SHORT_AUDIO:         pName = "REQUEST_SHORT_AUDIO";          break;

        case CECOP_INITIATE_ARC:                pName = "INITIATE_ARC";                 break;
        case CECOP_REPORT_ARC_INITIATED:        pName = "REPORT_ARC_INITIATED";         break;
        case CECOP_REPORT_ARC_TERMINATED:       pName = "REPORT_ARC_TERMINATED";        break;
        case CECOP_REQUEST_ARC_INITIATION:      pName = "REQUEST_ARC_INITIATION";       break;
        case CECOP_REQUEST_ARC_TERMINATION:     pName = "REQUEST_ARC_TERMINATION";      break;
        case CECOP_TERMINATE_ARC:               pName = "TERMINATE_ARC";                break;

        case CDCOP_HEADER:
        {
            pName = "CDC Header opcode";
            break;
        }
        case CECOP_ABORT:                       pName = "ABORT";                        break;
        default:                                pName = "UNKNOWN";                      break;
    }

    return( pName );
}

void HDMI_CEC_MessageLogger(CecLogger *pLog)
{
    int 		i;

	cec_msg *pMsg = pLog->pMsg;

	HI_BOOL isTx = pLog->bTx;
    HDMIRX_DEBUG("\n");
    if (isTx) {
        
        HDMIRX_DEBUG("TV send msg to %02x %02x \n", pMsg->u8SrcDestAddr, pMsg->enOpcode);
    }
	
	if ( pMsg->u8ArgCount > 14 )
	{
		pMsg->u8ArgCount = 14;
	}
	for ( i = 0; i < pMsg->u8ArgCount; i++ )
	{
        HDMIRX_DEBUG("%x ", pMsg->au32Args[i]);
	}
    if (!isTx) {
        HDMIRX_DEBUG("\n");
    }
	/* Add human readable command name	*/

    HDMIRX_DEBUG("%s!! eeeeeeeeee\n\n\n\n", HDMI_CEC_TranslateOpcodeName(pMsg));
}

void HDMI_CEC_SoftInit(void)
{
    Cec_ctx.strCpi.enLastResultCode = RESULT_CEC_SUCCESS;
    Cec_ctx.strCpi.u16CpiStatus = 0;
    memset(&Cec_ctx.strCpi.strCecStatus, 0, sizeof(cpi_status));
    Cec_ctx.strCpi.u8LogicalAddr = CEC_LOGADDR_TV;
    memset(&Cec_ctx.strCpi.strMsgQueueOut, 0, sizeof(cec_msg_queue));
}

void HDMI_CEC_Init(HI_U16 u16PhyAddr)
{
    HI_U8 i;

    HDMI_HAL_RegWriteFldAlign(RX_C0_SRST2, reg_cec_sw_rst, HI_FALSE);
    HDMI_CEC_SetLogicAddr(CEC_LOGADDR_TV);
    memset(&Cec_ctx, 0, sizeof(cec_status));
    HDMI_CEC_SoftInit();
    Cec_ctx.u8LogicAddr = CEC_LOGADDR_UNREGORBC;
    Cec_ctx.enPowerState = 1;
    Cec_ctx.u8SrcLogicAddr = CEC_LOGADDR_UNREGORBC;
    HDMI_CEC_SetPhyAddr(u16PhyAddr);
    Cec_ctx.strCpi.u16CpiStatus = 0;
    // Mark all devices as not found
    for ( i = 0; i <= CEC_LOGADDR_UNREGORBC; i++)
    {
        Cec_ctx.astrLogicalDeviceInfo[i].cecPA = 0xFFFF;
    }
    HDMI_CEC_Enable(HI_TRUE);
}

//------------------------------------------------------------------------------
// Function:    SiiDrvCpiServiceWriteQueue
// Description: If there is a CEC message waiting in the write queue and the
//              hardware TX buffer is empty, send the message.
//------------------------------------------------------------------------------

void HDMI_CEC_WriteQueue ( void )
{
    cec_msg*    pOutMsg;
    HI_U32      cecStatus[2];

	CecLogger   pLogger;

    do
    {
        // No message in the queue?  Get out.
        if ( Cec_ctx.strCpi.strMsgQueueOut.queue[Cec_ctx.strCpi.strMsgQueueOut.u16OutIndex].enTxState == TX_IDLE )
        {
            break;
        }

        // If last TX command is still being sent (waiting for ACK/NACK), check timeout
        if ( Cec_ctx.strCpi.strMsgQueueOut.queue[ Cec_ctx.strCpi.strMsgQueueOut.u16OutIndex ].enTxState == TX_SENDING)
        {
            // If a timeout has occurred, mark the current message as failed.
            // This will be picked up by the SiiDrvCpiHwStatusGet function and passed to the CEC controller
            //HDMIRX_DEBUG("HDMI_TIMER_IDX_CEC_SEND = %d \n", hdmi_ctx.Timer[HDMI_TIMER_IDX_CEC_SEND]);
            if (hdmi_ctx.Timer[HDMI_TIMER_IDX_CEC_SEND] >= Cec_ctx.strCpi.strMsgQueueOut.u32Timeout )
            {
                Cec_ctx.strCpi.strMsgQueueOut.queue[ Cec_ctx.strCpi.strMsgQueueOut.u16OutIndex ].enTxState = TX_TIMEOUT;
                HDMIRX_DEBUG( "%s:CEC Message [%02X][%02X] send timeout!\n", "TX", Cec_ctx.strCpi.strMsgQueueOut.queue[Cec_ctx.strCpi.strMsgQueueOut.u16OutIndex].u8SrcDestAddr, Cec_ctx.strCpi.strMsgQueueOut.queue[Cec_ctx.strCpi.strMsgQueueOut.u16OutIndex].enOpcode);
                Cec_ctx.strCpi.u16CpiStatus |= CEC_STATUS_VALID;
                hdmi_ctx.Timer[HDMI_TIMER_IDX_CEC_SEND] = 0;
                break;
            }
        }

        // If NOT waiting to be sent, get out.
        if ( Cec_ctx.strCpi.strMsgQueueOut.queue[ Cec_ctx.strCpi.strMsgQueueOut.u16OutIndex ].enTxState != TX_WAITCMD)
        {
            break;
        }

        // Current queue entry is waiting to be sent, so send it
        Cec_ctx.strCpi.strMsgQueueOut.queue[ Cec_ctx.strCpi.strMsgQueueOut.u16OutIndex ].enTxState = TX_SENDING;
        pOutMsg = &Cec_ctx.strCpi.strMsgQueueOut.queue[ Cec_ctx.strCpi.strMsgQueueOut.u16OutIndex ];

        // Clear Tx-related interrupts; write 1 to bits to be cleared.
        cecStatus[0] = tx_transmit_buffer_full | tx_transmit_buffer_change | tx_fifo_empty;
        cecStatus[1] = tx_frame_retx_count_exceed;
        HDMI_HAL_RegWriteBlock(CEC_INT_STATUS_0, cecStatus, 2 );

        // Special handling for a special opcode.

        if ( pOutMsg->enOpcode == CECOP_SENDPING )
        {
            HDMI_HAL_RegWrite( CEC_TX_DEST, reg_cec_sd_poll | pOutMsg->u8SrcDestAddr);
        }
        else
        {
            // Send the command
            HDMI_HAL_RegWriteFldAlign(CEC_TX_DEST, reg_cec_dest_id, pOutMsg->u8SrcDestAddr & 0x0F );
            HDMI_HAL_RegWrite(CEC_TX_COMMAND, pOutMsg->enOpcode );
            HDMI_HAL_RegWriteBlock(CEC_TX_OPERAND_0, pOutMsg->au32Args, pOutMsg->u8ArgCount);
            HDMI_HAL_RegWriteFldAlign(CEC_TRANSMIT_DATA, reg_cec_tx_cmd_cnt, pOutMsg->u8ArgCount);
            HDMI_HAL_RegWriteFldAlign(CEC_TRANSMIT_DATA, reg_transmit_cec_cmd, HI_TRUE);
        }

        hdmi_ctx.Timer[HDMI_TIMER_IDX_CEC_SEND] = 1;

        // If there is a logging callback, do it now.
        //if ( pCpi->pLogger != 0)
        {
			pLogger.pMsg = pOutMsg;
			//cpiLogger.systemType = pCpi->systemType;
			pLogger.bTx= HI_TRUE;
			//(*pCpi->pLogger)( pCpiLogger );
			HDMI_CEC_MessageLogger(&pLogger);
        }

    } while (0);

}


HI_U16  HDMI_CEC_SendMsg(cec_msg* pMsg)
{
    HI_U16    msgId = 0;
    HI_BOOL   success = HI_TRUE;

    // Store the message in the output queue
    if ( Cec_ctx.strCpi.strMsgQueueOut.queue[Cec_ctx.strCpi.strMsgQueueOut.u16InIndex].enTxState == TX_IDLE )
    {
        memcpy( &(Cec_ctx.strCpi.strMsgQueueOut.queue[ Cec_ctx.strCpi.strMsgQueueOut.u16InIndex ]), pMsg, sizeof(cec_msg));
        Cec_ctx.strCpi.strMsgQueueOut.u32Timeout = 200;     // timeout after 2 seconds
        Cec_ctx.strCpi.strMsgQueueOut.queue[ Cec_ctx.strCpi.strMsgQueueOut.u16InIndex ].enTxState = TX_WAITCMD;
        msgId = (Cec_ctx.strCpi.strMsgQueueOut.u16InIndex << 8) | (pMsg->enOpcode - 1);
        Cec_ctx.strCpi.strMsgQueueOut.queue[Cec_ctx.strCpi.strMsgQueueOut.u16InIndex].u16MsgId = msgId;

        Cec_ctx.strCpi.strMsgQueueOut.u16InIndex = (Cec_ctx.strCpi.strMsgQueueOut.u16InIndex + 1) % 4;
    }
    else
    {
        HDMIRX_DEBUG( "HDMI_CEC_SendMsg:: CEC Write Queue full!\n" );
        success = HI_FALSE;
    }

    HDMI_CEC_WriteQueue();  // Send the message if possible

    Cec_ctx.strCpi.enLastResultCode = (success) ? RESULT_CPI_SUCCESS : RESULT_CPI_WRITE_QUEUE_FULL;
    
    return( msgId );
}
HI_BOOL HDMI_CEC_ReceiveMsg(cec_msg* pMsg)
{
    HI_U8       u8ArgCnt;
    CecLogger   MsgLog;
    HI_BOOL     bRet = HI_TRUE;

    u8ArgCnt = HDMI_HAL_RegRead(CEC_RX_COUNT);
    if (u8ArgCnt & cec_rx_error) {
        bRet = HI_FALSE;
    }
    else {
        pMsg->u8ArgCount = (u8ArgCnt & cec_reg_rx_cmd_byte_cnt);
        pMsg->u8SrcDestAddr = HDMI_HAL_RegRead(CEC_RX_CMD_HEADER);
        pMsg->enOpcode = HDMI_HAL_RegRead(CEC_RX_COMMAND);
        if (pMsg->u8ArgCount > 0) {
            HDMI_HAL_RegReadBlock(CEC_RX_OPERAND_0, pMsg->au32Args, pMsg->u8ArgCount);
        }
    }
    // Clear CLR_RX_FIFO_CUR;
    // Clear current frame from Rx FIFO
    HDMI_HAL_RegWriteFldAlign(CEC_RX_CONTROL, reg_cec_rx_clr_all, HI_TRUE);
    if (bRet) {
        MsgLog.pMsg = pMsg;
        MsgLog.bTx = HI_FALSE;
        HDMI_CEC_MessageLogger(&MsgLog);
    }
    
    return bRet;
}

void HDMI_CEC_Isr(void)
{
    HI_U32 CecInt[2];

    if (!HDMI_ISR_IsCecInt() || (Cec_ctx.bEnable == HI_FALSE)) {
        return;
    }
    
    HDMI_HAL_RegReadBlock(CEC_INT_STATUS_0, CecInt, 2);
    if ((CecInt[0] & 0x7f) || (CecInt[1])) {
        
        Cec_ctx.strCpi.strCecStatus.bRxState = HI_FALSE;
        Cec_ctx.strCpi.strCecStatus.u8CecError = 0;
        Cec_ctx.strCpi.strCecStatus.enTxState = TX_IDLE;
    
        // Clear interrupts
        if ( CecInt[1] & tx_frame_retx_count_exceed )
        {
            /* Flush TX, otherwise after clearing the BIT_FRAME_RETRANSM_OV */
            /* interrupt, the TX command will be re-sent.                   */

            HDMI_HAL_RegWriteFldAlign( CEC_DEBUG_3,reg_cec_flush_tx_ff, HI_TRUE);
        }

        // Clear interrupt bits that are set
        HDMI_HAL_RegWriteBlock(CEC_INT_STATUS_0, CecInt, 2);
        // RX Processing
        if ( CecInt[0] & rx_fifo_not_empty ) 
        {
            Cec_ctx.strCpi.strCecStatus.bRxState = HI_TRUE;    // Flag caller that CEC frames are present in RX FIFO
        }
         // RX Errors processing
        if ( CecInt[1] & rx_short_pulse_detected )
        {
            Cec_ctx.strCpi.strCecStatus.u8CecError |= CEC_SHORTPULSE;
        }

        if ( CecInt[1] & rx_start_bit_irregular )
        {
            Cec_ctx.strCpi.strCecStatus.u8CecError |= CEC_BADSTART;
        }

        if ( CecInt[1] & rx_fifo_overrun_error )
        {
            Cec_ctx.strCpi.strCecStatus.u8CecError |= CEC_RXOVERFLOW;
        }
        
        // TX Processing
        if ( CecInt[0] & tx_transmit_buffer_change)
        {
            Cec_ctx.strCpi.strCecStatus.enTxState = TX_SENDACKED;
        }
        if ( CecInt[1] & tx_frame_retx_count_exceed)
        {
            Cec_ctx.strCpi.strCecStatus.enTxState = TX_SENDFAILED;
        }
        
        // Indicate that an interrupt occurred and status is valid.
        Cec_ctx.strCpi.u16CpiStatus |= CEC_STATUS_VALID;
        Cec_ctx.bInt = HI_TRUE;
    }
}

static HI_BOOL HDMI_CEC_ValidateMessage(cec_msg *pMsg)
{
    HI_U8   parameterCount = 0;
    HI_BOOL countOK = HI_TRUE;
    HI_BOOL isFromUnregistered = HI_FALSE;

    // If message is from Broadcast address, we ignore it except for
    // some specific cases.

    if (( pMsg->u8SrcDestAddr & 0xF0 ) == 0xF0 ) {
        switch ( pMsg->enOpcode ) {
            //case CECOP_STANDBY:
            case CECOP_SYSTEM_AUDIO_MODE_REQUEST:
            case CECOP_ROUTING_CHANGE:
            case CECOP_ROUTING_INFORMATION:
            case CECOP_INACTIVE_SOURCE:             
            case CECOP_GIVE_PHYSICAL_ADDRESS:
            case CECOP_REPORT_PHYSICAL_ADDRESS:
            case CECOP_REQUEST_ACTIVE_SOURCE:
            case CECOP_GET_MENU_LANGUAGE:
            case CECOP_SET_STREAM_PATH:
            case CDCOP_HEADER:
                break;
            default:
                isFromUnregistered = HI_TRUE;          // All others should be ignored
                break;
        }
    }

    /* Determine required parameter count   */

    switch ( pMsg->enOpcode )
    {
        case CECOP_IMAGE_VIEW_ON:
        case CECOP_TEXT_VIEW_ON:
        case CECOP_STANDBY:
        case CECOP_GIVE_PHYSICAL_ADDRESS:
        case CECOP_GIVE_DEVICE_VENDOR_ID:
        case CECOP_GIVE_DEVICE_POWER_STATUS:
        case CECOP_GET_MENU_LANGUAGE:
        case CECOP_GET_CEC_VERSION:
        case CECOP_INITIATE_ARC:
        case CECOP_REPORT_ARC_INITIATED:
        case CECOP_REPORT_ARC_TERMINATED:
        case CECOP_REQUEST_ARC_INITIATION:
        case CECOP_REQUEST_ARC_TERMINATION:
        case CECOP_TERMINATE_ARC:
        case CECOP_ABORT:
            parameterCount = 0;
            break;
        case CECOP_REPORT_POWER_STATUS:         // power status
        case CECOP_CEC_VERSION:                 // cec version
            parameterCount = 1;
            break;
        case CECOP_INACTIVE_SOURCE:             // physical address
        case CECOP_FEATURE_ABORT:               // feature opcode / abort reason
        case CECOP_ACTIVE_SOURCE:               // physical address
            parameterCount = 2;
            break;
        case CECOP_REPORT_PHYSICAL_ADDRESS:     // physical address / device type
        case CECOP_DEVICE_VENDOR_ID:            // vendor id
            parameterCount = 3;
            break;
        case CECOP_USER_CONTROL_PRESSED:        // UI command
        case CECOP_SET_OSD_NAME:                // osd name (1-14 bytes)
        case CECOP_SET_OSD_STRING:              // 1 + x   display control / osd string (1-13 bytes)
            parameterCount = 1;                 // must have a minimum of 1 operands
            break;

        default:
            break;
    }

    /* Test for correct parameter count.    */

    if (( pMsg->u8ArgCount < parameterCount ) || isFromUnregistered )
    {
        countOK = HI_FALSE;
    }

    return( countOK );
}

//------------------------------------------------------------------------------
// Function:    UpdateLogicalDeviceInfo
// Description: Store the LA, PA, and type of the new device.
//------------------------------------------------------------------------------

void HDMI_CEC_UpdateLogicalDeviceInfo ( HI_U8 newLA, HI_U16 newPA, HI_BOOL isActive )
{
    HI_U16     i, portIndex;



    if ( newLA > CEC_LOGADDR_UNREGORBC )
    {
        Cec_ctx.enLastResultCode = RESULT_CEC_INVALID_LOGICAL_ADDRESS;
        return;
    }

    portIndex = ((newPA & Cec_ctx.u16PaChildMask ) >> Cec_ctx.u8PaShift) - 1;  // Determine actual child port.
    if (portIndex < 0)
    {
    	portIndex = 0;
    }

    if ( portIndex < INPUT_PORT_COUNT )
    {
        Cec_ctx.astrLogicalDeviceInfo[ newLA ].cecPA      = newPA;
        Cec_ctx.astrLogicalDeviceInfo[ newLA ].port       = portIndex;
        Cec_ctx.astrLogicalDeviceInfo[ newLA ].selected   = HI_FALSE;
        Cec_ctx.astrLogicalDeviceInfo[ newLA ].deviceType = l_devTypes[ newLA ];

        // If called from an ACTIVE SOURCE handler, mark this device as the
        // selected device for this port.

        if ( isActive )
        {
            for ( i = 0; i <= CEC_LOGADDR_UNREGORBC; i++ )
            {
                // Update all logical addresses on this port.

                if (  Cec_ctx.astrLogicalDeviceInfo[ i ].port == portIndex )
                {
                    if ( i == newLA )
                    {
                        // The requested port is selected
                         Cec_ctx.astrLogicalDeviceInfo[ newLA ].selected = HI_TRUE;
                    }
                    else
                    {
                        Cec_ctx.astrLogicalDeviceInfo[ newLA ].selected = HI_FALSE;
                    }
                }
            }
        }

        Cec_ctx.enLastResultCode = RESULT_CEC_SUCCESS;
    }
    else
    {
        Cec_ctx.astrLogicalDeviceInfo[ newLA ].cecPA      = 0xFFFF;
        Cec_ctx.astrLogicalDeviceInfo[ newLA ].port       = INPUT_PORT_COUNT;
        Cec_ctx.astrLogicalDeviceInfo[ newLA ].selected   = HI_FALSE;
        Cec_ctx.astrLogicalDeviceInfo[ newLA ].deviceType = 0;

        Cec_ctx.enLastResultCode = RESULT_CEC_INVALID_PHYSICAL_ADDRESS;
    }
}

//------------------------------------------------------------------------------
// Function:    CecSendFeatureAbort
// Description: Send a feature abort as a response to this message unless
//              it was broadcast (illegal).
//------------------------------------------------------------------------------

HI_U16 HDMI_CEC_SendFeatureAbort ( HI_U8 opCode, HI_U8 reason, HI_U8 destLA )
{
    cec_msg cecFrame;

    cecFrame.enOpcode        = CECOP_FEATURE_ABORT;
    cecFrame.u8SrcDestAddr   = MAKE_SRCDEST( Cec_ctx.u8LogicAddr, destLA );
    cecFrame.au32Args[0]       = opCode;
    cecFrame.au32Args[1]       = reason;
    cecFrame.u8ArgCount      = 2;

    return( HDMI_CEC_SendMsg(&cecFrame));
}



//------------------------------------------------------------------------------
// Function:    CecHandleActiveSource
// Description: Process the CEC Active Source command by switching to the
//              broadcast port.
//------------------------------------------------------------------------------

static void HDMI_CEC_HandleActiveSource ( cec_msg *pMsg )
{
    // Extract the logical and physical addresses of the new active source.

    Cec_ctx.enActiveSrcLogical = (pMsg->u8SrcDestAddr >> 4) & 0x0F;
    Cec_ctx.u16ActiveSrcPhysical = ((HI_U16)pMsg->au32Args[0] << 8 ) | pMsg->au32Args[1];

    HDMI_CEC_UpdateLogicalDeviceInfo( Cec_ctx.enActiveSrcLogical, Cec_ctx.u16ActiveSrcPhysical, HI_TRUE );

    // Determine the index of the HDMI port that is handling this physical address.

    Cec_ctx.u8PortSel = ((Cec_ctx.u16ActiveSrcPhysical >> Cec_ctx.u8PaShift) & 0x000F) - 1;

    // Signal App layer that a port select change has occurred.
    // The App layer will perform the physical port switch.

    Cec_ctx.u16StatusFlag |= CEC_PORT_CHANGE;
}

//------------------------------------------------------------------------------
// Function:    CecHandleInactiveSource
// Description: Process the CEC Inactive Source command
//------------------------------------------------------------------------------

static void HDMI_CEC_HandleInactiveSource ( cec_msg *pMsg )
{
    HI_U8 la;

    la = (pMsg->u8SrcDestAddr >> 4) & 0x0F;
    if (la == Cec_ctx.enActiveSrcLogical)    // The active source has deserted us!
    {
        Cec_ctx.enActiveSrcLogical  = CEC_LOGADDR_TV;
        Cec_ctx.u16ActiveSrcPhysical = 0x0000;
    }
    // Signal upper layer that the active source has been lost

    Cec_ctx.u16StatusFlag |= CEC_SOURCE_LOST;
}

//------------------------------------------------------------------------------
// Function:    CecHandleReportPhysicalAddress
// Description: Store the PA and LA of the subsystem.
//              This routine is called when a physical address was broadcast.
//              usually this routine is used for a system which configure as TV or Repeater.
//------------------------------------------------------------------------------

static void HDMI_CEC_HandleReportPa ( cec_msg *pMsg )
{
    HDMI_CEC_UpdateLogicalDeviceInfo((pMsg->u8SrcDestAddr >> 4) & 0xF,         // broadcast logical address
        (((HI_U16)pMsg->au32Args[0]) << 8) | pMsg->au32Args[1],   // broadcast physical address
        HI_FALSE
        );
}

static HI_BOOL HDMI_CEC_HandlerFirt(cec_msg *pMsg)
{
    cec_msg  cecFrame;
    HI_BOOL  usedMessage = HI_TRUE;
    HI_BOOL  isDirectAddressed   = !((pMsg->u8SrcDestAddr & 0x0F ) == CEC_LOGADDR_UNREGORBC );

    switch ( pMsg->enOpcode)
    {
        case CECOP_FEATURE_ABORT:
            if ( isDirectAddressed )                // Ignore as broadcast message
            {
                HDMIRX_DEBUG("cec msg %02X was Feature Aborted (%02X) by logical address %d\n", pMsg->au32Args[0], pMsg->au32Args[1], pMsg->u8SrcDestAddr >> 4);
            }
            break;

        case CECOP_STANDBY:                                             // Direct and Broadcast
            if ( Cec_ctx.enPowerState != CEC_POWERSTATUS_STANDBY )
            {
                // Next time through the main loop, power will be cycled off

                Cec_ctx.enPowerState = CEC_POWERSTATUS_ON_TO_STANDBY;
                Cec_ctx.u16StatusFlag |= CEC_POWERSTATE_CHANGE;        // Signal upper layer
                Cec_ctx.bActiveSource = HI_FALSE;                           // Only impacts TX
            }
            break;

        case CECOP_GIVE_PHYSICAL_ADDRESS:
            if ( isDirectAddressed )                    // Ignore as broadcast message
            {
                //SiiCecSendReportPhysicalAddress();
            }
            break;

        case CECOP_GIVE_DEVICE_POWER_STATUS:
            if ( isDirectAddressed )                // Ignore as broadcast message
            {
                cecFrame.enOpcode        = CECOP_REPORT_POWER_STATUS;
                cecFrame.u8SrcDestAddr   = MAKE_SRCDEST( Cec_ctx.u8LogicAddr, pMsg->u8SrcDestAddr >> 4 );
                cecFrame.au32Args[0]       = Cec_ctx.enPowerState;
                cecFrame.u8ArgCount      = 1;
                HDMI_CEC_SendMsg( &cecFrame );
            }
            break;

        case CECOP_REPORT_POWER_STATUS:                 // Someone sent us their power state.
            if ( isDirectAddressed )                    // Ignore as broadcast message
            {
                Cec_ctx.enSourcePowerStatus = pMsg->au32Args[0];
            }
            break;

        default:
            usedMessage = HI_FALSE;                        // Didn't use the message
            break;
    }

    return( usedMessage );
}

static void HDMI_CEC_HandlerLast(cec_msg *pMsg)
{
    HI_BOOL     bIsDirectAddressed;
    cec_msg     cecFrame;

    bIsDirectAddressed = ((pMsg->u8SrcDestAddr & 0x0F ) != CEC_LOGADDR_UNREGORBC);
    switch ( pMsg->enOpcode )
    {
            // These messages have already been handled for internal purposes
            // by CecRxMsgHandler and passed to the application level
            // and/or were ignored but not consumed by the application level.
            // Ignore them here.

        case CECOP_IMAGE_VIEW_ON:
        case CECOP_TEXT_VIEW_ON:
        case CECOP_GET_MENU_LANGUAGE:
        case CECOP_USER_CONTROL_PRESSED:
        case CECOP_USER_CONTROL_RELEASED:
            break;

            // Handle this here because the app level may have upgraded the version
            // and handled it before it gets here.

        case CECOP_GET_CEC_VERSION:
            if ( bIsDirectAddressed )                    // Ignore as broadcast message
            {
                // Respond to this request with the CEC version support.

                cecFrame.u8SrcDestAddr   = MAKE_SRCDEST( Cec_ctx.u8LogicAddr, pMsg->u8SrcDestAddr >> 4 );
                cecFrame.enOpcode        = CECOP_CEC_VERSION;
                cecFrame.au32Args[0]     = 0x05;       // Report CEC1.4
                cecFrame.u8ArgCount      = 1;
                HDMI_CEC_SendMsg( &cecFrame );
            }
            break;

            // Ignore these messages if unrecognized AND broadcast
            // but feature abort them if directly addressed
        case CECOP_GIVE_DEVICE_VENDOR_ID:
        case CDCOP_HEADER:
            if ( bIsDirectAddressed )
            {
                HDMI_CEC_SendFeatureAbort( pMsg->enOpcode, CECAR_UNRECOG_OPCODE, MAKE_SRCDEST( pMsg->u8SrcDestAddr, pMsg->u8SrcDestAddr >> 4 ));
            }
            break;

            // Any directly addressed message that gets here is not supported by this
            // device, so feature abort it with unrecognized opcode.
            // This means that the app layer must be sure to properly handle any messages
            // that it should be able to handle.

        case CECOP_ABORT:
        default:
            if ( bIsDirectAddressed )                    // Ignore as broadcast message
            {
                HDMI_CEC_SendFeatureAbort( pMsg->enOpcode, CECAR_UNRECOG_OPCODE, MAKE_SRCDEST( pMsg->u8SrcDestAddr, pMsg->u8SrcDestAddr >> 4 ));
            }
            break;
    }
}

void HDMI_CEC_GetHwStatus(cpi_status *pCpiStat)
{
    memset( pCpiStat, 0, sizeof( cpi_status ));     // Always clear status for return
    if (Cec_ctx.strCpi.u16CpiStatus & CEC_STATUS_VALID)
    {
        memcpy( pCpiStat, &Cec_ctx.strCpi.strCecStatus, sizeof(cpi_status));
        if ( Cec_ctx.strCpi.strMsgQueueOut.queue[ Cec_ctx.strCpi.strMsgQueueOut.u16OutIndex ].enTxState == TX_TIMEOUT)
        {
            // A CPI write timed out; mark it as a NACK.  Since the CPI writes
            // are serialized, there is no other TX status currently valid.
            pCpiStat->enTxState = TX_SENDFAILED;
        }

        // Add the message ID to the returned status

        pCpiStat->u16MsgId = Cec_ctx.strCpi.strMsgQueueOut.queue[ Cec_ctx.strCpi.strMsgQueueOut.u16OutIndex ].u16MsgId;

        // If the status indicates an ACKed or NACKed transmission,
        // update the sent message queue so that any pending message
        // may be sent.  Note that this is the only way that a message
        // waiting in the CPI output message queue can be sent.

        if (( pCpiStat->enTxState == TX_SENDACKED ) || ( pCpiStat->enTxState == TX_SENDFAILED))
        {
            // Mark this queue entry as available and bump to next entry in queue

            Cec_ctx.strCpi.strMsgQueueOut.queue[ Cec_ctx.strCpi.strMsgQueueOut.u16OutIndex ].enTxState = TX_IDLE;
            Cec_ctx.strCpi.strMsgQueueOut.u16OutIndex = (Cec_ctx.strCpi.strMsgQueueOut.u16OutIndex + 1) % 4;
        }

        Cec_ctx.strCpi.u16CpiStatus &= ~CEC_STATUS_VALID;

    }

}

//------------------------------------------------------------------------------
// Function:    HDMI_CEC_RxMsgHandler
// Description: This is the first RX message handler called in the chain. It parses
//              messages that it needs to keep the internal component status
//              up to date.
//------------------------------------------------------------------------------

HI_BOOL HDMI_CEC_RxMsgHandler ( cec_msg *pMsg )
{
    HI_BOOL  usedMessage         = HI_TRUE;
    HI_BOOL  isDirectAddressed   = !((pMsg->u8SrcDestAddr & 0x0F ) == CEC_LOGADDR_UNREGORBC );

    switch ( pMsg->enOpcode )
    {
        case CECOP_IMAGE_VIEW_ON:       // In our case, respond the same to both these messages
        case CECOP_TEXT_VIEW_ON:
            if ( !isDirectAddressed )   break;          // Ignore as broadcast message

            // Make sure the system is powered on.  The application layer
            // must handle any other procedures needed to turn on the display

            if ( Cec_ctx.enPowerState != CEC_POWERSTATUS_ON )
            {
                // Next time through the main loop, power will be cycled on

                Cec_ctx.enPowerState = CEC_POWERSTATUS_STANDBY_TO_ON;
                Cec_ctx.u16StatusFlag |= CEC_POWERSTATE_CHANGE;            // Signal upper layer
            }
            // don't tell anyone we looked at this message.  The app layer
            // likely needs to see it also.
            usedMessage = HI_FALSE;
            break;

        case CECOP_ACTIVE_SOURCE:
            if ( !isDirectAddressed )                   // Ignore as direct message
            {
                HDMI_CEC_HandleActiveSource(pMsg);
            }
            break;

        case CECOP_REPORT_PHYSICAL_ADDRESS:
            if ( !isDirectAddressed )                   // Ignore as direct message
            {
                HDMI_CEC_HandleReportPa(pMsg);

                    /* Let Enumerate task know about it.   */

                if ( ACTIVE_TASK.enTask == CECTASK_RX_ENUMERATE )
                {
                    ACTIVE_TASK.enCpiState = CPI_RESPONSE;
                }
            }
            break;

        case CECOP_INACTIVE_SOURCE:
            if ( isDirectAddressed )                    // Ignore as broadcast message
            {
                HDMI_CEC_HandleInactiveSource( pMsg );
            }
            break;

        default:
            usedMessage = HI_FALSE;                        // Didn't use the message
            break;
    }

    return( usedMessage );
}

//------------------------------------------------------------------------------
// Function:    HDMI_CEC_RxMsgHandler2
// Description: Parse received messages and execute response as necessary
//              Only handle the messages needed at the top level to interact
//              with the Port Switch hardware.  The SiiAPI message handler
//              handles all messages not handled here.
// Parameters:  none
// Returns:     Returns true if message was processed by this handler
//------------------------------------------------------------------------------

HI_BOOL HDMI_CEC_RxMsgHandler2 ( cec_msg *pMsg )
{
    HI_BOOL  processedMsg, isDirectAddressed;

    isDirectAddressed = !((pMsg->u8SrcDestAddr & 0x0F ) == CEC_LOGADDR_UNREGORBC );

    processedMsg = HI_FALSE;
    switch ( pMsg->enOpcode )
    {
        case CECOP_IMAGE_VIEW_ON:       // In our case, respond the same to both these messages
        case CECOP_TEXT_VIEW_ON:
            if ( !isDirectAddressed )   break;          // Ignore as broadcast message

            // The CEC Component "First Message Handler" has already seen this message
            // and turned on the system power status (as necessary).  Now, the application
            // must do whatever else needs to be done to turn on the display.

            //TODO:OEM - Do whatever else is required to turn on the TV display.

            HDMIRX_DEBUG( "**============================**\n");
            HDMIRX_DEBUG( "**     IMAGE/TEXT VIEW ON     **\n");
            HDMIRX_DEBUG( "**============================**\n");
            processedMsg = HI_TRUE;
            break;

        case CECOP_USER_CONTROL_PRESSED:
        case CECOP_USER_CONTROL_RELEASED:
            if ( !isDirectAddressed )   break;          // Ignore as broadcast message
            processedMsg = HI_TRUE;
            break;

        case CECOP_INACTIVE_SOURCE:
            if ( !isDirectAddressed )   break;          // Ignore as broadcast message

            HDMIRX_DEBUG( "**============================**\n");
            HDMIRX_DEBUG( "** SWITCH TO INTERNAL SOURCE  **\n");
            HDMIRX_DEBUG( "**============================**\n");
            processedMsg = HI_TRUE;
            break;
        default:
            break;
    }

    return( processedMsg );
}

//------------------------------------------------------------------------------
// Function:    SiiDrvCpiSendPing
// Description: Initiate sending a ping, and used for checking available
//              CEC devices
//------------------------------------------------------------------------------

HI_U16 HDMI_CEC_SendPing ( HI_U8 destLA )
{
    cec_msg cecFrame;

    // Send the ping via the normal CPI message queue.

    cecFrame.enOpcode         = CECOP_SENDPING;
    cecFrame.u8SrcDestAddr    = destLA;
    cecFrame.u8ArgCount       = 0;
    return( HDMI_CEC_SendMsg(&cecFrame ));
}

//------------------------------------------------------------------------------
// Function:    SiiCecSendMessage
// Description: Send a single byte (no parameter) message on the CEC bus.  Does
//              no wait for a reply.
//------------------------------------------------------------------------------

uint16_t HDMI_CEC_SendMessage ( HI_U8 opCode, HI_U8 dest )
{
    cec_msg cecFrame;

    if ( !Cec_ctx.bEnable)
    {
        Cec_ctx.enLastResultCode = RESULT_CEC_FAIL;
        return( 0 );
    }
    cecFrame.enOpcode        = opCode;
    cecFrame.u8SrcDestAddr   = MAKE_SRCDEST( Cec_ctx.u8LogicAddr, dest );
    cecFrame.u8ArgCount      = 0;

    Cec_ctx.enLastResultCode = RESULT_CEC_SUCCESS;
    return( HDMI_CEC_SendMsg(&cecFrame ));
}

//------------------------------------------------------------------------------
// Function:    HDMI_CEC_RxEnumerateSink
// Description: Ping logical addresses CEC_LOGADDR_TV and CEC_LOGADDR_FREEUSE
//              to determine the root address of this sink device
//
// cecTaskState.taskData1 == Not used
// cecTaskState.taskData2 == Not used
//------------------------------------------------------------------------------

HI_U8 HDMI_CEC_RxEnumerateSink ( cpi_status *pCecStatus )
{
    HI_U8 newTask = ACTIVE_TASK.enTask;

    switch ( Cec_ctx.astrTaskQueue[Cec_ctx.u16TaskQueueOut].enCpiState )
    {
        case CPI_IDLE:
            
            ACTIVE_TASK.u16MsgId = HDMI_CEC_SendPing( ACTIVE_TASK.destLA );
            ACTIVE_TASK.enCpiState = CPI_WAIT_ACK;
            break;

        case CPI_WAIT_ACK:

            // Make sure this message status is associated with the message we sent.
            if ( pCecStatus->u16MsgId != ACTIVE_TASK.u16MsgId )
            {
                break;
            }

            // If this address is available, take it.

            if ( pCecStatus->enTxState == TX_SENDFAILED )
            {

                Cec_ctx.u8LogicAddr = ACTIVE_TASK.destLA;
                HDMI_CEC_SetLogicAddr(Cec_ctx.u8LogicAddr );
                newTask = CECTASK_IDLE;

                // Find out who is the active source connected to this  */
                /* sink.  Let the ACTIVE_SOURCE handler do the rest.    */

                HDMI_CEC_SendMessage( CECOP_REQUEST_ACTIVE_SOURCE, CEC_LOGADDR_UNREGORBC );
            }
            else if ( pCecStatus->enTxState == TX_SENDACKED )
            {
                // If it was ack'ed, try the second address.  If we tried
                // it already, get out.

                if ( ACTIVE_TASK.destLA == CEC_LOGADDR_FREEUSE)
                {
                    newTask = CECTASK_IDLE;
                }
                else
                {
                    // Try next address.
                    ACTIVE_TASK.enCpiState = CPI_IDLE;
                    ACTIVE_TASK.destLA = CEC_LOGADDR_FREEUSE;
                }
            }
            break;
        default:
            break;
    }
    return( newTask );
}

//------------------------------------------------------------------------------
// Function:    UpdateTaskQueueState
// Description: If the current task is idle, clear the queue state and bump
//              the task out index to the next task.
// NOTE:        This function is to be called ONLY after the task server has
//              run a task function.
//------------------------------------------------------------------------------

static void HDMI_CEC_UpdateTaskQueueState ( void )
{
    if ( Cec_ctx.enCurrentTask == CECTASK_IDLE )
    {
        ACTIVE_TASK.enQueueState = CecTaskQueueStateIdle;
        Cec_ctx.u16TaskQueueOut = (Cec_ctx.u16TaskQueueOut + 1) % TASK_QUEUE_LENGTH;
    }
}

//------------------------------------------------------------------------------
// Function:    HDMI_CEC_RxEnumerate
// Description: Ping every logical address on the CEC bus to see if anything
//              is attached.
//
//              As a side effect, we determine our Initiator address as
//              the first available address of 0x00 or 0x0E.
//
// cecTaskState.taskData1 == Not Used.
// cecTaskState.taskData2 == Not used
//------------------------------------------------------------------------------

HI_U8 HDMI_CEC_RxEnumerate ( cpi_status *pCecStatus )
{
    HI_U8 newTask = ACTIVE_TASK.enTask;

    switch ( ACTIVE_TASK.enCpiState )
    {
    case CPI_IDLE:
        if ( ACTIVE_TASK.destLA < CEC_LOGADDR_UNREGORBC )   // Don't ping broadcast address
        {
            ACTIVE_TASK.u16MsgId = HDMI_CEC_SendPing( ACTIVE_TASK.destLA );
            ACTIVE_TASK.enCpiState = CPI_WAIT_ACK;
        }
        else
        {
            /* Go to idle task, we're done. */

            //DEBUG_PRINT( CEC_MSG_DBG, "ENUM DONE\n" );
            ACTIVE_TASK.enCpiState = CPI_IDLE;
            newTask = CECTASK_IDLE;
        }
        break;

    case CPI_WAIT_ACK:
        // Make sure this message status is associated with the message we sent.
        if ( pCecStatus->u16MsgId != ACTIVE_TASK.u16MsgId )
        {
            break;
        }
        if ( pCecStatus->enTxState == TX_SENDFAILED )
        {
            //DEBUG_PRINT( MSG_DBG, "Rx Enum NoAck" );
            //CecPrintLogAddr( ACTIVE_TASK.destLA );
            //DEBUG_PRINT( MSG_DBG, "\n" );

            // Remove LA from active list

            if ( Cec_ctx.astrLogicalDeviceInfo[ ACTIVE_TASK.destLA].cecPA != 0xFFFF )
            {
                //DEBUG_PRINT( CEC_MSG_DBG, "Remove LA %X from CEC list\n", ACTIVE_TASK.destLA );
                Cec_ctx.astrLogicalDeviceInfo[ ACTIVE_TASK.destLA].cecPA = 0xFFFF;
                Cec_ctx.astrLogicalDeviceInfo[ ACTIVE_TASK.destLA].deviceType = CEC_DT_COUNT;
                Cec_ctx.astrLogicalDeviceInfo[ ACTIVE_TASK.destLA].selected = HI_FALSE;
            }

            /* Restore Tx State to IDLE to try next address.    */

            ACTIVE_TASK.enCpiState = CPI_IDLE;
            ACTIVE_TASK.destLA++;
        }
        else if ( pCecStatus->enTxState == TX_SENDACKED )
        {
            //DEBUG_PRINT( MSG_DBG, "Rx Enum Ack" );
            //CecPrintLogAddr( ACTIVE_TASK.destLA );
            //DEBUG_PRINT( MSG_DBG, "\n" );

            /* Get the physical address from this source and add it to our  */
            /* list if it responds within 2 seconds, otherwise, ignore it.  */

            ACTIVE_TASK.u16MsgId = HDMI_CEC_SendMessage( CECOP_GIVE_PHYSICAL_ADDRESS, ACTIVE_TASK.destLA );
            //SiiTimerSet( TIMER_2, 2000 );
            hdmi_ctx.Timer[HDMI_TIMER_IDX_COM] = 1;
            ACTIVE_TASK.enCpiState = CPI_WAIT_RESPONSE;
        }
        break;

    case CPI_WAIT_RESPONSE:
        if ( hdmi_ctx.Timer[HDMI_TIMER_IDX_COM] >= 200)
        {
            //DEBUG_PRINT( CEC_MSG_DBG, "RX Enumerate: Timed out waiting for response\n" );

            /* Ignore this LA and move on to the next.  */

            ACTIVE_TASK.enCpiState = CPI_IDLE;
            ACTIVE_TASK.destLA++;
            hdmi_ctx.Timer[HDMI_TIMER_IDX_COM] = 0;
        }
        break;

    case CPI_RESPONSE:

        // The CEC Rx Message Handler has updated the child port list,
        // restore Tx State to IDLE to try next address.
        ACTIVE_TASK.enCpiState = CPI_IDLE;
        ACTIVE_TASK.destLA++;
        break;

    }

    return( newTask );
}

//------------------------------------------------------------------------------
// Function:    HDMI_CEC_TaskServer
// Description: Calls the current task handler.  A task is used to handle cases
//              where we must send and receive a specific set of CEC commands.
//
// NOTE:        If the contents of the SiiCpiStatus_t structure are not new,
//              they should be set to 0 before calling.
//------------------------------------------------------------------------------

static void HDMI_CEC_TaskServer ( cpi_status *pCecStatus )
{
    //HI_U16   regTaskIndex;

    switch ( Cec_ctx.enCurrentTask )
    {
        case CECTASK_IDLE:
            if ( Cec_ctx.astrTaskQueue[Cec_ctx.u16TaskQueueOut].enQueueState == CecTaskQueueStateQueued )
            {
                Cec_ctx.astrTaskQueue[Cec_ctx.u16TaskQueueOut].enQueueState = CecTaskQueueStateRunning;
                Cec_ctx.enCurrentTask = Cec_ctx.astrTaskQueue[Cec_ctx.u16TaskQueueOut].enTask;
            }
            break;

        case CECTASK_RX_ENUMERATE_SINK:
            Cec_ctx.enCurrentTask = HDMI_CEC_RxEnumerateSink( pCecStatus );
            HDMI_CEC_UpdateTaskQueueState();
            break;

        case CECTASK_RX_ENUMERATE:
            Cec_ctx.enCurrentTask = HDMI_CEC_RxEnumerate( pCecStatus );
            HDMI_CEC_UpdateTaskQueueState();
            break;
#if 0
        case SiiCECTASK_TX_ENUMERATE:
            pCec->currentTask = CecTaskTxEnumerate( pCecStatus );
            UpdateTaskQueueState();
            break;

        case SiiCECTASK_TX_ENUMERATE_SINK:
			pCec->currentTask = CecTaskTxEnumerateSink( pCecStatus );
			UpdateTaskQueueState();
			break;

        case SiiCECTASK_ONETOUCH:
            pCec->currentTask = CecTaskOneTouchPlay( pCecStatus );
            UpdateTaskQueueState();
            break;
#endif
        case CECTASK_SENDMSG:
            break;

        default:

            // Check the registered task list.
            #if 0
            regTaskIndex = Cec_ctx.enCurrentTask - CECTASK_COUNT;
            
            if (( regTaskIndex < MAX_CEC_TASKS) && ( pCec->pTasks[ regTaskIndex ] != 0))
            {
                Cec_ctx.enCurrentTask = (*pCec->pTasks[ regTaskIndex])( pCecStatus );
            }
            #endif
            break;
    }
}

void HDMI_CEC_Handler(void)
{
    HI_U16  u16FrameCnt;
    HI_BOOL bProcessedMsg;
    cpi_status cecStatus;
    cec_msg Msg;
    
    if (!Cec_ctx.bEnable) {
        return;
    }
    
    if ((hdmi_ctx.Timer[HDMI_TIMER_IDX_CEC] < 10) && (!Cec_ctx.bInt)) {
        return;
    }
    if (hdmi_ctx.Timer[HDMI_TIMER_IDX_CEC] >= 10) {
        hdmi_ctx.Timer[HDMI_TIMER_IDX_CEC] = 1;
    }
    HDMI_CEC_WriteQueue();
    HDMI_CEC_GetHwStatus(&cecStatus);
    
    if (cecStatus.bRxState) {
        cecStatus.bRxState = HI_FALSE;
        //HDMIRX_DEBUG("HDMI_CEC_Handler \n");
        while(1) {
            u16FrameCnt = HDMI_HAL_RegReadFldAlign(CEC_RX_COUNT, cec_reg_rx_ff_wr_sel);
            if (u16FrameCnt == 0) {
                break;
            }
            if (!HDMI_CEC_ReceiveMsg(&Msg)) {
                break;
            }
            bProcessedMsg = HI_FALSE;
             // If invalid message, ignore it, but treat it as handled
            if (!HDMI_CEC_ValidateMessage(&Msg)) {
                bProcessedMsg = HI_TRUE;
            }
            // Handle the common system messages
            if (HDMI_CEC_HandlerFirt(&Msg)) {
                bProcessedMsg = HI_TRUE;
            }
                if (!HDMI_CEC_RxMsgHandler(&Msg)) {
                    bProcessedMsg = HI_TRUE;
                }
                    
            }
            if (!bProcessedMsg) {
                if (!HDMI_CEC_RxMsgHandler2(&Msg)) {
                     bProcessedMsg = HI_TRUE;
                }
            }
            if (!bProcessedMsg) {
                HDMI_CEC_HandlerLast(&Msg);
            }
        }
    HDMI_CEC_TaskServer(&cecStatus);
    Cec_ctx.bInt = HI_FALSE;
}


//------------------------------------------------------------------------------
// Function:    HDMI_CEC_AddTask
// Description: Add the passed task to the CEC task queue if room.
//------------------------------------------------------------------------------

void HDMI_CEC_AddTask( cec_task_state *pNewTask )
{
    HI_BOOL success = HI_TRUE;

    // Store the message in the task queue
    if ( Cec_ctx.astrTaskQueue[Cec_ctx.u16TaskQueueIn].enQueueState == CecTaskQueueStateIdle )
    {
        memcpy( &Cec_ctx.astrTaskQueue[Cec_ctx.u16TaskQueueIn], pNewTask, sizeof(cec_task_state));
        Cec_ctx.astrTaskQueue[Cec_ctx.u16TaskQueueIn].enQueueState = CecTaskQueueStateQueued;

        Cec_ctx.u16TaskQueueIn = (Cec_ctx.u16TaskQueueIn + 1) % TASK_QUEUE_LENGTH;
    }
    else
    {
        //DEBUG_PRINT( MSG_DBG, "CEC Task Queue full\n" );
        success = HI_FALSE;
    }

    Cec_ctx.enLastResultCode= (success) ? RESULT_CEC_SUCCESS : RESULT_CEC_TASK_QUEUE_FULL;
    //return( success );
}

//------------------------------------------------------------------------------
// Function:    SiiCecEnumerateSinkAddress
// Description: Ping logical addresses CEC_LOGADDR_TV and CEC_LOGADDR_FREEUSE
//              to determine the root address of this sink device
//------------------------------------------------------------------------------

void HDMI_CEC_EnumerateSinkAddress ( void )
{
    cec_task_state newTask;

    newTask.enTask        = CECTASK_RX_ENUMERATE_SINK;
    newTask.taskState   = 0;
    newTask.destLA      = CEC_LOGADDR_TV;
    newTask.enCpiState    = CPI_IDLE;
    newTask.taskData1   = 0;
    newTask.taskData2   = 0;
    HDMI_CEC_AddTask(&newTask);
}   

//------------------------------------------------------------------------------
// Function:    SiiCecEnumerate
// Description: Send the appropriate CEC commands to enumerate all the logical
//              devices on the CEC bus.
//------------------------------------------------------------------------------

void HDMI_CEC_Enumerate ( void )
{
    cec_task_state  newTask;

    newTask.enTask        = CECTASK_RX_ENUMERATE;
    newTask.taskState   = 0;
    newTask.destLA      = CEC_LOGADDR_RECDEV1;  // Don't need to look at TV address
    newTask.enCpiState    = CPI_IDLE;
    newTask.taskData1   = 0;
    newTask.taskData2   = 0;
    HDMI_CEC_AddTask( &newTask );
}

//------------------------------------------------------------------------------
// Function:    SiiCecSetPowerState
// Description: Set the CEC local power state.
//
// Valid values:    CEC_POWERSTATUS_ON
//                  CEC_POWERSTATUS_STANDBY
//                  CEC_POWERSTATUS_STANDBY_TO_ON
//                  CEC_POWERSTATUS_ON_TO_STANDBY
//------------------------------------------------------------------------------

void HDMI_CEC_SetPowerState ( CecPowerstatus newPowerState )
{
    if ( !Cec_ctx.bEnable )
    {
        return;
    }

    if ( Cec_ctx.enPowerState != newPowerState )
    {
        switch ( newPowerState )
        {
            case CEC_POWERSTATUS_STANDBY_TO_ON:
            case CEC_POWERSTATUS_ON:
                newPowerState = CEC_POWERSTATUS_ON;
                break;

            case CEC_POWERSTATUS_ON_TO_STANDBY:
            case CEC_POWERSTATUS_STANDBY:
                newPowerState = CEC_POWERSTATUS_STANDBY;
                break;

            default:
                break;
        }

    Cec_ctx.enPowerState = newPowerState;
    }
}

void HDMI_CEC_Resume(void)
{
    if (!Cec_ctx.bEnable) {
        return;
    }
    HDMI_CEC_SetPowerState(CEC_POWERSTATUS_STANDBY_TO_ON);
    HDMI_CEC_EnumerateSinkAddress();
    HDMI_CEC_Enumerate();
}



