/******************************************************************************

  Copyright (C), 2012-2050, Hisilicon Tech. Co., Ltd.

 ******************************************************************************
  File Name     : drv_hdmirx_mhl.c
  Version       : Initial Draft
  Author        : Hisilicon multimedia software group
  Created       : 2014/03/19
  Description   : 
  History       :
  1.Date        : 2014/03/19
    Author      :  c00189109
    Modification: Created file
******************************************************************************/
#include <linux/sched.h> 
#include <linux/delay.h>
#include "hi_drv_proc.h"


//#include <ctype.h>
//#include <stdlib.h>
//#include <stdio.h>
//#include <sys/types.h>
//#include <sys/stat.h>
//#include <fcntl.h>
//#include <string.h>
/*
#include <fcntl.h>
#include <unistd.h>
#include <pthread.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/time.h>
#include <linux/fb.h>
#include <assert.h>
#include <pthread.h>
#include <sys/wait.h>
*/
#include "hal_hdmirx.h"
#include "hal_hdmirx_reg.h"
#include "drv_hdmirx_common.h"
#include "drv_hdmirx.h"
#include "drv_hdmirx_ctrl.h"
#include "drv_hdmirx_mhl.h"



#ifdef __cplusplus
 #if __cplusplus
        extern "C" {
 #endif
#endif /* __cplusplus */

#if SUPPORT_MHL


static HDMIRX_MHL_CONTEXT_S s_stHdmirxMhlCtx;

static HI_U32 CbusRegsList[30]=
{
    MHL_DEVCAP_1, 	MHL_VERSION,
    MHL_DEVCAP_2,	MHL_DEV_CAT_POW,			// MHL PLIM0/PLIM1 needs to be set according to VBUS power it can supply
    MHL_DEVCAP_3,   MHL_DEV_CAT_ADOPTER_ID_H,
    MHL_DEVCAP_4,   MHL_DEV_CAT_ADOPTER_ID_L,
    MHL_DEVCAP_5,   MHL_VID_LINK_MODE,
    MHL_DEVCAP_6,   MHL_AUDIO_LINK_MODE_SUPORT,
    MHL_DEVCAP_7,   MHL_VIDEO_TYPE,
    MHL_DEVCAP_8,   MHL_LOG_DEV_MAP,
    MHL_DEVCAP_9,   MHL_BANDWIDTH_LIMIT,
    MHL_DEVCAP_A,   MHL_FEATURE_SUPPORT,
    MHL_DEVCAP_B,   MHL_DEVICE_ID_H,
    MHL_DEVCAP_C,   MHL_DEVICE_ID_L,
    MHL_DEVCAP_D,   MHL_SCRATCHPAD_SIZE,
    MHL_DEVCAP_E,   MHL_INT_STAT_SIZE,
    MHL_DEVCAP_F,   0x00
};
/*
static HDMIRX_RCPKEY_TYPE_E RcpKeyList[HI_UNF_HDMIRX_RCP_KEY_BUTT]=
{
    MHL_RCP_CMD_SELECT ,        
    MHL_RCP_CMD_UP,             
    MHL_RCP_CMD_DOWN ,          
    MHL_RCP_CMD_LEFT ,          
    MHL_RCP_CMD_RIGHT ,
    MHL_RCP_CMD_ROOT_MENU,
    MHL_RCP_CMD_EXIT,
};
*/
#if SUPPORT_MHL_20
static HI_U32 u32Seq;
#endif

//------------------------------------------------------------------------------
//  CBUS Driver local Data
//------------------------------------------------------------------------------

/*static HI_U32 CbusRegsList[30]=
{
    MHL_DEVCAP_1, 	MHL_VERSION,
    MHL_DEVCAP_2,	MHL_DEV_CAT_POW,			// MHL PLIM0/PLIM1 needs to be set according to VBUS power it can supply
    MHL_DEVCAP_3,   MHL_DEV_CAT_ADOPTER_ID_H,
    MHL_DEVCAP_4,   MHL_DEV_CAT_ADOPTER_ID_L,
    MHL_DEVCAP_5,   MHL_VID_LINK_MODE,
    MHL_DEVCAP_6,   MHL_AUDIO_LINK_MODE_SUPORT,
    MHL_DEVCAP_7,   MHL_VIDEO_TYPE,
    MHL_DEVCAP_8,   MHL_LOG_DEV_MAP,
    MHL_DEVCAP_9,   MHL_BANDWIDTH_LIMIT,
    MHL_DEVCAP_A,   MHL_FEATURE_SUPPORT,
    MHL_DEVCAP_B,   MHL_DEVICE_ID_H,
    MHL_DEVCAP_C,   MHL_DEVICE_ID_L,
    MHL_DEVCAP_D,   MHL_SCRATCHPAD_SIZE,
    MHL_DEVCAP_E,   MHL_INT_STAT_SIZE,
    MHL_DEVCAP_F,   0x00
};*/
static HI_U32 rcpValidate[128] =
{
    LD_MHL_RCP_CMD_SELECT,
    LD_MHL_RCP_CMD_UP,
    LD_MHL_RCP_CMD_DOWN,
    LD_MHL_RCP_CMD_LEFT,
    LD_MHL_RCP_CMD_RIGHT,
    LD_MHL_RCP_CMD_RIGHT_UP,
    LD_MHL_RCP_CMD_RIGHT_DOWN,
    LD_MHL_RCP_CMD_LEFT_UP,
    LD_MHL_RCP_CMD_LEFT_DOWN,
    LD_MHL_RCP_CMD_ROOT_MENU,
    LD_MHL_RCP_CMD_SETUP_MENU,
    LD_MHL_RCP_CMD_CONTENTS_MENU,
    LD_MHL_RCP_CMD_FAVORITE_MENU,
    LD_MHL_RCP_CMD_EXIT,

    //0x0E - 0x1F Reserved
    MHL_LD_INVALID, MHL_LD_INVALID,
    MHL_LD_INVALID, MHL_LD_INVALID, MHL_LD_INVALID, MHL_LD_INVALID,
    MHL_LD_INVALID, MHL_LD_INVALID, MHL_LD_INVALID, MHL_LD_INVALID,
    MHL_LD_INVALID, MHL_LD_INVALID, MHL_LD_INVALID, MHL_LD_INVALID,
    MHL_LD_INVALID, MHL_LD_INVALID, MHL_LD_INVALID, MHL_LD_INVALID,

    LD_MHL_RCP_CMD_NUM_0,
    LD_MHL_RCP_CMD_NUM_1,
    LD_MHL_RCP_CMD_NUM_2,
    LD_MHL_RCP_CMD_NUM_3,
    LD_MHL_RCP_CMD_NUM_4,
    LD_MHL_RCP_CMD_NUM_5,
    LD_MHL_RCP_CMD_NUM_6,
    LD_MHL_RCP_CMD_NUM_7,
    LD_MHL_RCP_CMD_NUM_8,
    LD_MHL_RCP_CMD_NUM_9,
    LD_MHL_RCP_CMD_DOT,
    LD_MHL_RCP_CMD_ENTER,
    LD_MHL_RCP_CMD_CLEAR,

    //0x2D - 0x2F Reserved
    MHL_LD_INVALID, MHL_LD_INVALID, MHL_LD_INVALID,

    LD_MHL_RCP_CMD_CH_UP,
    LD_MHL_RCP_CMD_CH_DOWN,
    LD_MHL_RCP_CMD_PRE_CH,
    LD_MHL_RCP_CMD_SOUND_SELECT,
    LD_MHL_RCP_CMD_INPUT_SELECT,
    LD_MHL_RCP_CMD_SHOW_INFO,
    LD_MHL_RCP_CMD_HELP,
    LD_MHL_RCP_CMD_PAGE_UP,
    LD_MHL_RCP_CMD_PAGE_DOWN,

    //0x39 - 0x3F Reserved
    MHL_LD_INVALID, MHL_LD_INVALID, MHL_LD_INVALID,
    MHL_LD_INVALID, MHL_LD_INVALID, MHL_LD_INVALID, MHL_LD_INVALID,

    LD_MHL_RAP_CONTENT_ON,
    LD_MHL_RCP_CMD_VOL_UP,
    LD_MHL_RCP_CMD_VOL_DOWN,
    LD_MHL_RCP_CMD_MUTE,
    LD_MHL_RCP_CMD_PLAY,
    LD_MHL_RCP_CMD_STOP,
    LD_MHL_RCP_CMD_PAUSE,
    LD_MHL_RCP_CMD_RECORD,
    LD_MHL_RCP_CMD_REWIND,
    LD_MHL_RCP_CMD_FAST_FWD,
    LD_MHL_RCP_CMD_EJECT,
    LD_MHL_RCP_CMD_FWD,
    LD_MHL_RCP_CMD_BKWD,

    //0x4D - 0x4F Reserved
    MHL_LD_INVALID, MHL_LD_INVALID, MHL_LD_INVALID,

    LD_MHL_RCP_CMD_ANGLE,
    LD_MHL_RCP_CMD_SUBPICTURE,

    //0x52 - 0x5F Reserved
    MHL_LD_INVALID, MHL_LD_INVALID,
    MHL_LD_INVALID, MHL_LD_INVALID, MHL_LD_INVALID, MHL_LD_INVALID,
    MHL_LD_INVALID, MHL_LD_INVALID, MHL_LD_INVALID, MHL_LD_INVALID,
    MHL_LD_INVALID, MHL_LD_INVALID, MHL_LD_INVALID, MHL_LD_INVALID,

    LD_MHL_RCP_CMD_PLAY_FUNC,
    LD_MHL_RCP_CMD_PAUSE_PLAY_FUNC,
    LD_MHL_RCP_CMD_RECORD_FUNC,
    LD_MHL_RCP_CMD_PAUSE_REC_FUNC,
    LD_MHL_RCP_CMD_STOP_FUNC,
    LD_MHL_RCP_CMD_MUTE_FUNC,
    LD_MHL_RCP_CMD_UN_MUTE_FUNC,
    LD_MHL_RCP_CMD_TUNE_FUNC,
    LD_MHL_RCP_CMD_MEDIA_FUNC,

    //0x69 - 0x70 Reserved
    MHL_LD_INVALID, MHL_LD_INVALID, MHL_LD_INVALID,
    MHL_LD_INVALID, MHL_LD_INVALID, MHL_LD_INVALID, MHL_LD_INVALID,
    MHL_LD_INVALID,

    LD_MHL_RCP_CMD_F1,
    LD_MHL_RCP_CMD_F2,
    LD_MHL_RCP_CMD_F3,
    LD_MHL_RCP_CMD_F4,
    LD_MHL_RCP_CMD_F5,

    // 0x76 - 0x7F Reserved
    MHL_LD_INVALID, MHL_LD_INVALID,
    MHL_LD_INVALID, MHL_LD_INVALID, MHL_LD_INVALID, MHL_LD_INVALID,
    MHL_LD_INVALID, MHL_LD_INVALID, MHL_LD_INVALID, MHL_LD_INVALID,
};


HI_BOOL HDMIRX_MHL_GetCbusSense(HI_UNF_HDMIRX_PORT_E enPort)
{
	HI_BOOL bExist;
	
	bExist = (HI_BOOL)HDMIRX_HAL_GetCbusSense(enPort);
	
	return bExist;
}

//------------------------------------------------------------------------------
// Function:    
// Description: Set the specified channel state to IDLE. Clears any messages that
//              are in progress or queued.  Usually used if a channel connection
//              changed or the channel heartbeat has been lost.
//------------------------------------------------------------------------------

HI_VOID HDMIRX_MHL_ResetToIdle(HI_VOID)
{
	HI_U32 supportMask;
    HDMIRX_MHL_CONTEXT_S *pstmhlCtx;
    
    pstmhlCtx = HDMIRX_MHL_GET_CTX();

	// we have to preserve the port and instance information
	//port = pstmhlCtx->u32Port;
	//instanceIndex = pCbus->instanceIndex;
	supportMask = pstmhlCtx->u32SupportMask;

	memset( pstmhlCtx, 0, sizeof(HDMIRX_MHL_CONTEXT_S));
    memset( &(pstmhlCtx->stRequest), 0, sizeof(cbus_req) * CBUS_MAX_COMMAND_QUEUE);

    // fill back the port and instance information
	//pstmhlCtx->u32Port = port;
	//pCbus->instanceIndex = instanceIndex;
	pstmhlCtx->u32SupportMask = supportMask;
    HDMIRX_HAL_SetResetEn(HI_UNF_HDMIRX_PORT0,HDMIRX_BUS_RST, HI_TRUE);
    udelay(40);
    HDMIRX_HAL_SetResetEn(HI_UNF_HDMIRX_PORT0,HDMIRX_BUS_RST, HI_FALSE);
 //   pstmhlCtx->u32RepeatSend = 2;
}


//------------------------------------------------------------------------------
// Function:    
// Description: Wrapper for the GPIO Component at the application level
// Parameters:  none
// Returns:     none
//------------------------------------------------------------------------------
static HI_VOID HDMIRX_MHL_CusSense(HI_UNF_HDMIRX_PORT_E enPort)
{
    HI_BOOL bSense;
    static HI_BOOL bCbuEn = HI_FALSE;
    HDMIRX_MHL_CONTEXT_S *pstmhlCtx;
    pstmhlCtx = HDMIRX_MHL_GET_CTX();
    
    bSense = HDMIRX_MHL_GetCbusSense(enPort);
    if(bSense != pstmhlCtx->bCbusSense )
    {
        pstmhlCtx->bCbusSense = bSense;
        pstmhlCtx->bCbusEn = bSense;
    //	HDMIRX_HAL_SetMhlEn(bSense);
        printk("CbusSense Change:%s\n",bSense?"true":"false");
        if(bSense == HI_FALSE)
        {
            HDMIRX_MHL_ResetToIdle(); 
        }
    }
    if(bCbuEn != bSense)
    {
        printk("now is %s\n",bSense ? "MHL":"HDMI");
        HDMIRX_HAL_SetMhlEn(bSense);
        bCbuEn = bSense;
    }
	
}

//------------------------------------------------------------------------------
// Function:    
// Description: Place a command in the CBUS message queue.
//
// Parameters:  pReq    - Pointer to a cbus_req_t structure containing the
//                        command to write
// Returns:     true    - successful queue/write
//              false   - write and/or queue failed
//------------------------------------------------------------------------------

static HI_BOOL HDMIRX_MHL_WriteCommand(cbus_req *pReq)
{
    HI_U32   u32QueueIndex;
	HI_U32   u32Count;
    HI_BOOL  bSuccess = HI_FALSE;
    HDMIRX_MHL_CONTEXT_S *pstmhlCtx;
    
    pstmhlCtx = HDMIRX_MHL_GET_CTX();
    
    /* Copy the request to the queue.   */
    if(pstmhlCtx->bBusConnected)
    {
    	u32QueueIndex = ((CH_ACTIVE_INDEX == ( CBUS_MAX_COMMAND_QUEUE - 1 )) ? 0 : (CH_ACTIVE_INDEX + 1));
		for(u32Count = 0; u32Count < CBUS_MAX_COMMAND_QUEUE; u32Count++)
		{
			if(pstmhlCtx->stRequest[u32QueueIndex].u32ReqStatus == CBUS_REQ_IDLE)
			{
				// Found an idle queue entry, copy the request and set to pending.
				memcpy( &pstmhlCtx->stRequest[u32QueueIndex], pReq, sizeof(cbus_req));
				pstmhlCtx->stRequest[u32QueueIndex].u32ReqStatus = CBUS_REQ_PENDING;                
				pstmhlCtx->u32QueueDepth++;
				bSuccess = HI_TRUE;
				break;
			}
			u32QueueIndex++;
			if(u32QueueIndex == CBUS_MAX_COMMAND_QUEUE)
			{
				u32QueueIndex = 0;
			}
		}

		if (bSuccess == HI_FALSE)
		{
			HDMI_INFO("CBUS:: Queue Full\n");
			for(u32QueueIndex = 0; u32QueueIndex < CBUS_MAX_COMMAND_QUEUE; u32QueueIndex++)
			{
				HDMI_INFO("\nCBUS:: CBusWriteCommand:: Queue Index: %02X, Cmd: %02X data: %02X\n",u32QueueIndex, pstmhlCtx->stRequest[u32QueueIndex].u32Command, pstmhlCtx->stRequest[u32QueueIndex].u32OffsetData);
			}
		}
    }
    else
    {
    	HDMI_INFO("%s:CBus is not connected yet! MHL command could not be sent!\n",__FUNCTION__ );
    }

    return bSuccess;
}


//------------------------------------------------------------------------------
// Function:    
// Description: sends general MHL commands
//------------------------------------------------------------------------------
HI_BOOL HDMIRX_MHL_SendMscCommand(HI_U32 u32Cmd)
{
	cbus_req 	stReq;
	HI_BOOL		bSuccess = HI_TRUE;

	stReq.u32Command = u32Cmd;

	switch(u32Cmd)
	{
		case MHL_GET_STATE:
		case MHL_GET_VENDOR_ID:
		case MHL_SET_HPD:
		case MHL_CLR_HPD:
		case MHL_GET_SC1_ERRORCODE:
		case MHL_GET_DDC_ERRORCODE:
		case MHL_GET_MSC_ERRORCODE:
		case MHL_GET_SC3_ERRORCODE:
			bSuccess = HDMIRX_MHL_WriteCommand(&stReq);
			if(bSuccess == HI_FALSE)
			{
				HDMI_INFO("%s:Couldn't send cmd: %02X to peer\n",__FUNCTION__, u32Cmd);
			}
			break;

		default:
			HDMI_INFO("%s:Invalid command send request %02x!!\n",__FUNCTION__, u32Cmd );
			bSuccess = HI_FALSE;
	}
	return bSuccess;
}

//------------------------------------------------------------------------------
// Function:    
// Description: write peer's status registers
//				regOffset - peer's register offset
//				regBit - bit to be set
//------------------------------------------------------------------------------
static HI_BOOL HDMIRX_MHL_SendSetInt(HI_U32 regOffset, HI_U32 regBit)
{
	cbus_req stReq;
    HDMIRX_MHL_CONTEXT_S *pstmhlCtx;
    
    pstmhlCtx = HDMIRX_MHL_GET_CTX();
    
	stReq.u32Command = MHL_SET_INT;
	stReq.u32OffsetData = regOffset;
	stReq.u32MsgData[0] = regBit;

	//if(pstmhlCtx->bBusConnected)
	if(1)
	{
		if(HDMIRX_MHL_WriteCommand(&stReq) == HI_FALSE)
		{
			HDMI_INFO("Couldn't send MHL_SET_INT to peer\n");
			return HI_FALSE;
		}
	}
    printk("\n####pstmhlCtx->bBusConnected:%d\n",pstmhlCtx->bBusConnected);
	return HI_TRUE;
}


//------------------------------------------------------------------------------
// Function:    SiiMhlRxSendEdidChange
// Description: set edid_chg interrupt
//------------------------------------------------------------------------------
static HI_BOOL HDMIRX_MHL_SendEdidChange(HI_VOID)
{
	return (HDMIRX_MHL_SendSetInt(1, BIT1));
}

//------------------------------------------------------------------------------
// Function:    
// Description: write peer's status registers
// Parameters:  regOffset - peer's register offset
//				value - value to be written
//------------------------------------------------------------------------------
static HI_BOOL HDMIRX_MHL_SendWriteStatus ( HI_U32 u32RegOffset, HI_U32 u32Value )
{
    cbus_req stReq;
    
	stReq.u32Command = MHL_WRITE_STAT;
	stReq.u32OffsetData = u32RegOffset;
	stReq.u32MsgData[0] = u32Value;

	if(HDMIRX_MHL_WriteCommand(&stReq) == HI_FALSE)
	{
		HDMI_INFO("Couldn't send MHL_WRITE_STAT to peer\n");
		
		return HI_FALSE;
	}

	return HI_TRUE;
    
}


static HI_BOOL HDMIRX_MHL_SetPathEn(HI_BOOL bEnable)
{
    HI_BOOL bSuccess = HI_TRUE;
    HDMIRX_MHL_CONTEXT_S *pstmhlCtx;
    
    pstmhlCtx = HDMIRX_MHL_GET_CTX();
    

    if(bEnable)
    {
		if(pstmhlCtx->bPathEnableSent == HI_FALSE)
		{
            // enable PATH_EN bit on peer's appropriate status register (offset 0x31)
			bSuccess = HDMIRX_MHL_SendWriteStatus(0x01, BIT3);
		//	HDMI_INFO("MHL_SetPathEn():: Setting bit 3 to peer's status register.\n" );
			if(bSuccess == HI_TRUE)
			{
				pstmhlCtx->bPathEnableSent = HI_TRUE;
			}
		}
    }
    else
    {
    	if(pstmhlCtx->bPathEnableSent == HI_TRUE)
    	{
            // disable PATH_EN bit on peer's appropriate status register (offset 0x31)
    	//	HDMI_INFO("MHL_SetPathEn():: Clearing bit 3 to peer's status register.\n");
			bSuccess = HDMIRX_MHL_SendWriteStatus(0x01, 0);
    		if(bSuccess == HI_TRUE)
    		{
    			pstmhlCtx->bPathEnableSent = HI_FALSE;
    		}
    	}
    }

	return bSuccess;
}


//------------------------------------------------------------------------------
// Function:    
// Description: Send MHL_SET_HPD to source
// parameters:	setHpd - self explanatory :)
// Returns:     true/false
//------------------------------------------------------------------------------
HI_BOOL HDMIRX_MHL_OnOff(HI_BOOL bOn)
{
    HDMIRX_MHL_CONTEXT_S *pstmhlCtx;
    
    pstmhlCtx = HDMIRX_MHL_GET_CTX();
    
    if(bOn == HI_TRUE)
    {
        if(pstmhlCtx->bBusConnected)
        {
            
            if(HDMIRX_MHL_SendMscCommand(MHL_SET_HPD) == HI_FALSE)
        	{
        		HDMI_INFO("MHL SET HPD FAILED\n");
        		return HI_FALSE;
        	}
        	if(HDMIRX_MHL_SendEdidChange() == HI_FALSE)
        	{
                HDMI_INFO("SendEdid Failed\n");
                return HI_FALSE;
        	}
        	
        	if(HDMIRX_MHL_SetPathEn(HI_TRUE) == HI_FALSE)
        	{
                HDMI_INFO("SetPathEn Failed\n");
                return HI_FALSE;
        	}
            HDMIRX_HAL_MHLSetCbus1x(HI_UNF_HDMIRX_PORT0,HI_TRUE);
            
        	
        }    
    }
    else
	{
        if(pstmhlCtx->bBusConnected)
		{
			if(HDMIRX_MHL_SetPathEn(HI_FALSE) == HI_FALSE)
			{
				return HI_FALSE;
			}
            
			if(HDMIRX_MHL_SendMscCommand(MHL_CLR_HPD) == HI_FALSE)
			{
				return HI_FALSE;
			}
		}
    }
    return HI_TRUE;
}

static HI_BOOL HDMIRX_MHL_SendDcapRdy(HI_VOID)
{
	HI_BOOL bTemp;

	bTemp = HDMIRX_MHL_SendWriteStatus(0x00, BIT0);
	
	return bTemp;

}

static HI_BOOL HDMIRX_MHL_SendDevCapChange(HI_VOID)
{
	HI_BOOL bTemp;

	bTemp = HDMIRX_MHL_SendSetInt(0x00, BIT0);
	
	return bTemp;
}


//------------------------------------------------------------------------------
// Function:    CBusSendDcapRdyMsg
// Description: Send a msg to peer informing the devive capability registers are
//				ready to be read.
// Returns:     TRUE    - success
//              FALSE   - failure
//------------------------------------------------------------------------------

static HI_BOOL HDMIRX_MHL_SendDcapRdyMsg(HI_VOID)
{
    HI_BOOL bResult = HI_TRUE;
    HDMIRX_MHL_CONTEXT_S *pstmhlCtx;
    
    pstmhlCtx = HDMIRX_MHL_GET_CTX();
    if(pstmhlCtx->bBusConnected == HI_TRUE)
	{
        pstmhlCtx->u32MiscFlags |= FLAGS_SENT_DCAP_RDY;

		//send a msg to peer that the device capability registers are ready to be read.
		//set DCAP_RDY bit
		
		bResult = HDMIRX_MHL_SendDcapRdy();
		if(bResult)
		{
			HDMI_INFO("Device capability sent successfully\n");
		}
        
		//set DCAP_CHG bit
		
		bResult = HDMIRX_MHL_SendDevCapChange();
		if(bResult == HI_TRUE)
		{
			HDMI_INFO("Device capability change sent successfully\n");
		}
		
	}

	return bResult;
    
}

static HI_BOOL HDMIRX_MHL_IsCbusInt(HI_VOID)
{
    HDMIRX_MHL_CONTEXT_S *pstmhlCtx;
    
    pstmhlCtx = HDMIRX_MHL_GET_CTX();

    if ( pstmhlCtx->u32StatusFlags & CBUS_INT )
	{
		pstmhlCtx->u32StatusFlags &= ~CBUS_INT;
		
		return HI_TRUE;
	}
	return HI_FALSE;
}

//------------------------------------------------------------------------------
// Function:    
// Description: Returns the last VS cmd and data bytes retrieved by the CBUS ISR.
// Parameters:  pData - pointer to return data buffer (2 bytes).
// Returns:     pData[0] - VS_CMD value
//              pData[1] - VS_DATA value
//------------------------------------------------------------------------------
HI_BOOL HDMIRX_MHL_GetVsData( HI_U32 *pData )
{
    HDMIRX_MHL_CONTEXT_S *pstmhlCtx;
    
    pstmhlCtx = HDMIRX_MHL_GET_CTX();

    if(pstmhlCtx->u32StatusFlags & CBUS_MSC_MSG_RCVD)
	{
        *pData++ = pstmhlCtx->u32VsCmd;
        *pData = pstmhlCtx->u32VsData;
		pstmhlCtx->u32StatusFlags &= ~CBUS_MSC_MSG_RCVD;
		return HI_TRUE;
	}
    return HI_FALSE;
}


//------------------------------------------------------------------------------
// Function:    
// Description: Process a sub-command
//------------------------------------------------------------------------------
static HI_VOID HDMIRX_MHL_ProcessSubCommand (HI_U32* u32VsCmdData)
{
    //HI_U32 vs_cmd, vs_data;
    HDMIRX_MHL_CONTEXT_S *pstmhlCtx;
    
    pstmhlCtx = HDMIRX_MHL_GET_CTX();
    //vs_cmd = u32VsCmdData[0];
    //vs_data = u32VsCmdData[1];

    // Save MSC_MSG data in the request structure to be returned to the upper level.
    pstmhlCtx->u32LastCbusRcvdCmd = u32VsCmdData[0];
    pstmhlCtx->u32LastCbusRcvdData = u32VsCmdData[1];
}

//------------------------------------------------------------------------------
// Function:    
// Description: return response from peer
// Parameters:  pData - pointer to return data buffer (2 bytes).
//------------------------------------------------------------------------------
HI_BOOL HDMIRX_MHL_GetCmdRetData(HI_U32 *pData)
{
    HDMIRX_MHL_CONTEXT_S *pstmhlCtx;
    
    pstmhlCtx = HDMIRX_MHL_GET_CTX();
    
    if ( pstmhlCtx->u32StatusFlags & CBUS_MSC_CMD_DONE )
	{
		*pData++ = pstmhlCtx->u32MsgData0;
		*pData = pstmhlCtx->u32MsgData1;
		pstmhlCtx->u32StatusFlags &= ~CBUS_MSC_CMD_DONE;
		return HI_TRUE;
	}
	
    return HI_FALSE;
}

//------------------------------------------------------------------------------
// Function:    
// Description: Returns the last DDC Abort reason received by the CBUS ISR.
// Parameters:  pData - pointer to return data buffer (1 byte).
// Returns:     pData - Destination for DDC Abort reason data.
//------------------------------------------------------------------------------
HI_BOOL HDMIRX_MHL_GetDdcAbortReason(HI_U32 *pData)
{
    HDMIRX_MHL_CONTEXT_S *pstmhlCtx;
    
    pstmhlCtx = HDMIRX_MHL_GET_CTX();
    if ( pstmhlCtx->u32StatusFlags & CBUS_DDC_ABORT )
	{
    	*pData = pstmhlCtx->u32DdcAbortReason;
		pstmhlCtx->u32StatusFlags &= ~CBUS_DDC_ABORT;
		
		return HI_TRUE;
	}
    return HI_FALSE;
}

//------------------------------------------------------------------------------
// Function:    
// Description: Returns the last MSC Abort reason received by the CBUS ISR.
// Parameters:  pData - pointer to return data buffer (1 byte).
// Returns:     pData - Destination for MSC Abort reason data.
//------------------------------------------------------------------------------
HI_BOOL HDMIRX_MHL_GetMscAbortTxReason(HI_U32 *pData)
{
    HDMIRX_MHL_CONTEXT_S *pstmhlCtx;
    
    pstmhlCtx = HDMIRX_MHL_GET_CTX();
    if ( pstmhlCtx->u32StatusFlags & CBUS_XFR_ABORT_T )
	{
    	*pData = pstmhlCtx->u32MscAbortFmPeerReason;
		pstmhlCtx->u32StatusFlags &= ~CBUS_XFR_ABORT_T;
		return HI_TRUE;
	}
    return HI_FALSE;
}

//------------------------------------------------------------------------------
// Function:    
// Description: Returns the last MSC Abort reason received by the CBUS ISR.
// Parameters:  pData - pointer to return data buffer (1 byte).
// Returns:     pData - Destination for MSC Abort reason data.
//------------------------------------------------------------------------------
HI_BOOL HDMIRX_MHL_GetCbusMscAbortRxReason(HI_U32 *pData)
{
    HDMIRX_MHL_CONTEXT_S *pstmhlCtx;
    
    pstmhlCtx = HDMIRX_MHL_GET_CTX();
    if ( pstmhlCtx->u32StatusFlags & CBUS_XFR_ABORT_R )
	{
    	*pData = pstmhlCtx->u32MscAbortFmPeerReason;
		pstmhlCtx->u32StatusFlags &= ~CBUS_XFR_ABORT_R;
		return HI_TRUE;
	}
    return HI_FALSE;
}

//------------------------------------------------------------------------------
// Function:    
// Description: Returns the last Bus Status data retrieved by the CBUS ISR.
// Parameters:  pData - pointer to return data buffer (1 byte).
// Returns:     pData - Destination for bus status data.
//------------------------------------------------------------------------------
static HI_BOOL HDMIRX_MHL_GetBusStatus(HI_U32 *pData)
{
    HDMIRX_MHL_CONTEXT_S *pstmhlCtx;
    
    pstmhlCtx = HDMIRX_MHL_GET_CTX();
    //DEBUG_PRINT(MSG_DBG,"CBUS STATUS FLAG :%d, CBUS DRV CONNECTION :%d",pDrvCbus->statusFlags,pDrvCbus->busConnected);
    if((pstmhlCtx->u32StatusFlags & CBUS_CBUS_CONNECTION_CHG) > 0)
	{
    	*pData = pstmhlCtx->bBusConnected;
		pstmhlCtx->u32StatusFlags &= ~CBUS_CBUS_CONNECTION_CHG;
		
		return HI_TRUE;
	}
    return HI_FALSE;
}


//------------------------------------------------------------------------------
// Function:    
// Description: Returns if the peer is requesting for scratchpad write permission
// Returns:     true/false
//------------------------------------------------------------------------------
static HI_BOOL HDMIRX_MHL_GetReqWrt(HI_VOID)
{
    HDMIRX_MHL_CONTEXT_S *pstmhlCtx;
    
    pstmhlCtx = HDMIRX_MHL_GET_CTX();    
    if(pstmhlCtx->u32StatusFlags & CBUS_REQ_WRT_RECEIVED_FM_PEER)
    {
        pstmhlCtx->u32StatusFlags &= ~CBUS_REQ_WRT_RECEIVED_FM_PEER;
		
        return HI_TRUE;
    }
    return HI_FALSE;
}

static HI_BOOL HDMIRX_MHL_SendGrtWrt(HI_VOID)
{
	return (HDMIRX_MHL_SendSetInt(0, BIT3));
}

//------------------------------------------------------------------------------
// Function:    
// Description: Returns if the peer has written the scratchpad
// Returns:     true/false
//------------------------------------------------------------------------------
static HI_BOOL HDMIRX_MHL_GetScratchpadWrtn(HI_VOID)
{
    HDMIRX_MHL_CONTEXT_S *pstmhlCtx;
    
    pstmhlCtx = HDMIRX_MHL_GET_CTX(); 
    if (pstmhlCtx->u32StatusFlags & CBUS_SCRATCHPAD_WRITTEN_BY_PEER)
    {
        pstmhlCtx->u32StatusFlags &= ~CBUS_SCRATCHPAD_WRITTEN_BY_PEER;
		
        return HI_TRUE;
    }
    return HI_FALSE;
}

//------------------------------------------------------------------------------
// Function:    
// Description: Returns if the peer is requesting for scratchpad write permission
// Returns:     true/false
//------------------------------------------------------------------------------
static HI_BOOL HDMIRX_MHL_GetGrtWrt(HI_VOID)
{
    HDMIRX_MHL_CONTEXT_S *pstmhlCtx;
    
    pstmhlCtx = HDMIRX_MHL_GET_CTX();    
    if ( pstmhlCtx->u32StatusFlags & CBUS_GRT_WRT_RECEIVED_FM_PEER )
    {
        pstmhlCtx->u32StatusFlags &= ~CBUS_GRT_WRT_RECEIVED_FM_PEER;
        return HI_TRUE;
    }
    return HI_FALSE;
}

//------------------------------------------------------------------------------
// Function:    
// Description: sends MHL write burst cmd
//------------------------------------------------------------------------------
static HI_BOOL HDMIRX_MHL_SendWriteBurstCmd(HI_VOID)
{
	cbus_req stReq;
    HDMIRX_MHL_CONTEXT_S *pstmhlCtx;
    
    pstmhlCtx = HDMIRX_MHL_GET_CTX();

	stReq.u32Command = MHL_WRITE_BURST;
	stReq.u32OffsetData = pstmhlCtx->u32WbStartOffset;
	stReq.u32Length = pstmhlCtx->u32WbLength;

	if(HDMIRX_MHL_WriteCommand(&stReq) == HI_FALSE)
	{
		HDMI_INFO("Couldn't send Write Burst to peer\n" );
		
		return HI_FALSE;
	}

	return HI_TRUE;
}

//------------------------------------------------------------------------------
// Function:    
// Description: Returns if the peer is requesting for 3D information
// Returns:     true/false
//------------------------------------------------------------------------------
#if SUPPORT_MHL_20
HI_BOOL HDMIRX_MHL_GetCbus3DReq(HI_VOID)
{
    HDMIRX_MHL_CONTEXT_S *pstmhlCtx;
    
    pstmhlCtx = HDMIRX_MHL_GET_CTX();
    if ( pstmhlCtx->u32StatusFlags & CBUS_3D_REQ_RECEIVED_FM_PEER )
    {
        pstmhlCtx->u32StatusFlags &= ~CBUS_3D_REQ_RECEIVED_FM_PEER;
        return HI_TRUE;
    }
    return HI_FALSE;
}
#endif


//------------------------------------------------------------------------------
// Function:    
// Description: If any interrupts on the specified channel are set, process them.
// Parameters:  none
// Returns:     success or error code
//------------------------------------------------------------------------------
static HI_U32 HDMIRX_MHL_CheckInterruptStatus(HI_VOID)
{
    HI_U32 u32Result;
    HI_U32 u32BusStatus;
    HI_U32 u32Temp;
    HI_U32 u32Data[2];
    HDMIRX_MHL_CONTEXT_S *pstmhlCtx;
    
    pstmhlCtx = HDMIRX_MHL_GET_CTX();
    u32Result = SUCCESS;
    
    if (HDMIRX_MHL_IsCbusInt())
    {
        if(HDMIRX_MHL_GetVsData(u32Data))
        {
            HDMIRX_MHL_ProcessSubCommand(u32Data);
            pstmhlCtx->enState |= CBUS_RECEIVED;
        }
        if(HDMIRX_MHL_GetCmdRetData(&pstmhlCtx->stRequest[CH_ACTIVE_INDEX].u32MsgData[0]))
        {
            pstmhlCtx->enState &= ~CBUS_SENT; 
           
			/* A previous MSC sub-command has been acknowledged by the responder.   */
			pstmhlCtx->enState |= CBUS_XFR_DONE;
        }
        else
        {
            
            if(HDMIRX_MHL_GetDdcAbortReason(&u32Temp))
            {
                HDMI_INFO("CBUS DDC ABORT happened, reason: %02x\n", u32Temp);
				pstmhlCtx->enState &= ~CBUS_SENT;
    			do_gettimeofday(&pstmhlCtx->stAbortTime);
				pstmhlCtx->bAbortTimeValid = HI_TRUE;
    			u32Result = ERROR_CBUS_ABORT;
    			pstmhlCtx->enState |= CBUS_FAILED;
            }
            
            if (HDMIRX_MHL_GetMscAbortTxReason(&u32Temp))
            {
                
                HDMI_INFO("MSC CMD aborted (this device was a transmitter), reason: %02x\n", u32Temp);
                pstmhlCtx->enState &= ~CBUS_SENT;
                do_gettimeofday(&pstmhlCtx->stAbortTime);
                pstmhlCtx->bAbortTimeValid = HI_TRUE;
                u32Result = ERROR_CBUS_ABORT;
                pstmhlCtx->enState |= CBUS_FAILED;
            }

            if (HDMIRX_MHL_GetCbusMscAbortRxReason(&u32Temp))
    		{
    			
    			HDMI_INFO("MSC CMD aborted (this device was a receiver) , reason: %02x\n", u32Temp);
    			pstmhlCtx->enState &= ~CBUS_SENT;
    			do_gettimeofday(&pstmhlCtx->stAbortTime);
				pstmhlCtx->bAbortTimeValid = HI_TRUE;
    			u32Result = ERROR_CBUS_ABORT;
    			pstmhlCtx->enState |= CBUS_FAILED;
    		}

        }
        if(HDMIRX_MHL_GetBusStatus(&u32BusStatus))
        {
        	/* The connection change interrupt has been received.   */
        	HDMI_INFO("CBUS:: ----Connection Change---- %s \n", pstmhlCtx->bBusConnected? "Connected" : "Disconnected" );
			if(pstmhlCtx->bBusConnected)
			{
				do_gettimeofday(&pstmhlCtx->stInitTime);
				pstmhlCtx->bInitTimeValid = HI_TRUE;
			}
			else
			{
				//set the cbus to idle
				HDMIRX_MHL_ResetToIdle();

			}
			//SiiMhlCbRxConnectChange(pCbus->connected);
        }
        // request received from peer to write into scratchpad
    	if (HDMIRX_MHL_GetReqWrt() == HI_TRUE)
    	{
            
            if((pstmhlCtx->u32MiscFlags & FLAGS_SCRATCHPAD_BUSY) == HI_FALSE)
			{
				HDMI_INFO("granting peer's request to write scratchpad!!\n");
				HDMIRX_MHL_SendGrtWrt();
				pstmhlCtx->u32MiscFlags |= FLAGS_SCRATCHPAD_BUSY;
			}
			else
			{
				HDMI_INFO( "Got request from peer for scratchpad write, couldn't grant request as the scartchpad is busy!!\n" );
			}
		}
        // scratchpad write notification received from peer
    	if(HDMIRX_MHL_GetScratchpadWrtn())
		{
            
            pstmhlCtx->u32MiscFlags &= ~FLAGS_SCRATCHPAD_BUSY;
			// send it to app layer
			HDMI_INFO("Notification to Application:: Scratchpad written!!\n" );
		}

    	// request to write into peer's scratchpad is granted
    	if(HDMIRX_MHL_GetGrtWrt())
    	{
           
            HDMI_INFO("peer sent grtWrt!!\n");
    		if(pstmhlCtx->u32MiscFlags & FLAGS_SCRATCHPAD_BUSY)
			{
				pstmhlCtx->bReqWrtTimeValid = HI_FALSE;
				HDMIRX_MHL_SendWriteBurstCmd();
			}
        }
#if SUPPORT_MHL_20
    	// request to send over 3D information
    	if(HDMIRX_MHL_GetCbus3DReq())
    	{
    		pstmhlCtx->u32Sending_3D_info = HI_TRUE;
    		pstmhlCtx->u32Cbus3Dstate = WB_3D_SENDING_VIC;
    		u32Seq = 0;
    		//CBusSend3DInfo();
        }
#endif
    }

    pstmhlCtx->u32StatusFlags = 0;
	pstmhlCtx->u32InterruptStatus0 = 0;
    pstmhlCtx->u32InterruptStatus1 = 0;
	
    return u32Result;
}

//------------------------------------------------------------------------------
// Function:    
// Description: clear a particular entry from the queue
// Parameters:  cmd - the one that needs to be removed
// Returns:     void
//------------------------------------------------------------------------------
static HI_VOID HDMIRX_MHL_ClearQueueEntry(HI_U32 u32Cmd)
{
    HI_U32 u32QueueIndex;
     HDMIRX_MHL_CONTEXT_S *pstmhlCtx;
    
    pstmhlCtx = HDMIRX_MHL_GET_CTX();

	for ( u32QueueIndex = 0; u32QueueIndex < CBUS_MAX_COMMAND_QUEUE; u32QueueIndex++ )
	{
		if(pstmhlCtx->stRequest[u32QueueIndex].u32Command == u32Cmd)
		{
			memset(&(pstmhlCtx->stRequest[u32QueueIndex]), 0, sizeof(cbus_req));
			break;
		}
	}
}


static HI_VOID HDMIRX_MHL_ChkTimers(HI_VOID)
{
	struct timeval stCurTime;
    HDMIRX_MHL_CONTEXT_S *pstmhlCtx;
    
    pstmhlCtx = HDMIRX_MHL_GET_CTX();

	do_gettimeofday(&stCurTime);
	
	if((pstmhlCtx->bHpdWaitTimeValid)&&(HDMIRX_TIME_DIFF_MS(stCurTime, pstmhlCtx->stHpdWaitTime) > CBUS_HPD_WAIT_TIMER))
	{
		pstmhlCtx->bHpdWaitTimeValid = HI_FALSE;
	}

	if((pstmhlCtx->bAbortTimeValid) && (HDMIRX_TIME_DIFF_MS(stCurTime, pstmhlCtx->stAbortTime) > CBUS_ABORT_TIMER))
	{ 
		pstmhlCtx->bAbortTimeValid = HI_FALSE;
	}
	if((pstmhlCtx->bInitTimeValid) && (HDMIRX_TIME_DIFF_MS(stCurTime, pstmhlCtx->stInitTime) > CBUS_INIT_TIMER))
	{
		pstmhlCtx->bInitTimeValid = HI_FALSE;
	}
	if((pstmhlCtx->bRcpeRcpkGapTimeValid) && (HDMIRX_TIME_DIFF_MS(stCurTime, pstmhlCtx->stRcpeRcpkGapTime) > CBUS_RCPE_RCPK_GAP_TIMER))
	{
		pstmhlCtx->bRcpeRcpkGapTimeValid = HI_FALSE;
	}
    if((pstmhlCtx->u32RcpSentStatus == 1) && (HDMIRX_TIME_DIFF_MS(stCurTime,pstmhlCtx->stRcpSentAbortTime)>1000))
    {
        pstmhlCtx->u32RcpSentStatus = 2;
    }
    /*
	if((pstmhlCtx->u32RepeatSend == 0) && (HDMIRX_TIME_DIFF_MS(stCurTime, pstmhlCtx->stCbusRepeatTime) > 2000))	
	{
        pstmhlCtx->u32RepeatSend = 1;
	}
	*/
	if((pstmhlCtx->bReqWrtTimeValid) && (HDMIRX_TIME_DIFF_MS(stCurTime, pstmhlCtx->stReqWrtTime) > CBUS_WB_REQ_TIMER))
	{
		HDMIRX_MHL_ClearQueueEntry(MHL_WRITE_BURST);
		pstmhlCtx->bReqWrtTimeValid = HI_FALSE;
		pstmhlCtx->u32MiscFlags &= ~FLAGS_SCRATCHPAD_BUSY;
		HDMI_INFO("GrtWrt interrupt did not come from peer within the timeout limit!! \n");
	}
	
	if((pstmhlCtx->bWaitTimeValid) && (HDMIRX_TIME_DIFF_MS(stCurTime, pstmhlCtx->stWaitTime) > CBUS_MSG_RSP_TIMER))
	{
		pstmhlCtx->enState |= CBUS_FAILED;
		pstmhlCtx->bWaitTimeValid = HI_FALSE;
	}
	if((pstmhlCtx->bRcpRapAbortTimeValid) && (HDMIRX_TIME_DIFF_MS(stCurTime, pstmhlCtx->stRcpRapAbortTime) > CBUS_RCP_RCP_ABORT_TIMER))
	{
		pstmhlCtx->enState |= CBUS_FAILED;
		pstmhlCtx->bRcpRapAbortTimeValid = HI_FALSE;
	}
}

//------------------------------------------------------------------------------
// Function:    
// Description: Write the specified Sideband Channel command to the CBUS.
//              	Command can be a MSC_MSG command (RCP/MCW/RAP), or another command 
//              	such as READ_DEVCAP, GET_VENDOR_ID, SET_HPD, CLR_HPD, etc.
//
// Parameters:  pReq    - Pointer to a cbus_req_t structure containing the
//                        command to write
// Returns:     TRUE    - successful write
//              FALSE   - write failed
//------------------------------------------------------------------------------
static HI_BOOL HDMIRX_MHL_InternalWriteCommand(HI_UNF_HDMIRX_PORT_E enPort,cbus_req *pReq )
{
    HI_U32 		u32Startbit;
    HI_BOOL  	bSuccess = HI_TRUE;
    HDMIRX_MHL_CONTEXT_S *pstmhlCtx;
    
    pstmhlCtx = HDMIRX_MHL_GET_CTX();

    /****************************************************************************************/
    /* Setup for the command - write appropriate registers and determine the correct        */
    /*                         start bit.                                                   */
    /****************************************************************************************/
	if(pstmhlCtx->u32StatusFlags & CBUS_XFR_ABORT_R)
    {
    	msleep(2000); // 2 sec delay
    	pstmhlCtx->u32StatusFlags &= ~CBUS_XFR_ABORT_R;
    }
    // Set the offset and outgoing data byte right away
   // COBRA_HAL_RegWrite(MSC_CMD_OR_OFFSET, pReq->u32OffsetData);   // set offset
   // COBRA_HAL_RegWrite(MSC_1ST_TRANSMIT_DATA, pReq->u32MsgData[0]);
   HDMIRX_HAL_MHLSetCmd_Offset(enPort,pReq->u32OffsetData);
   HDMIRX_HAL_MHLSet1STDATA(enPort,pReq->u32MsgData[0]);

    u32Startbit = 0;
  //  HDMI_INFO("\n #####:0x%x\n",pReq->u32Command);
    switch (pReq->u32Command)
    {
        case MHL_SET_INT:   // Set one interrupt register = 0x60
            HDMIRX_HAL_MHLSetCmd_Offset(enPort,pReq->u32OffsetData + 0x20);   // set offset
            u32Startbit = reg_msc_write_stat_cmd;
            break;

        case MHL_WRITE_STAT:    // Write one status register = 0x60 | 0x80
            HDMIRX_HAL_MHLSetCmd_Offset(enPort,pReq->u32OffsetData + 0x30);   // set offset
            u32Startbit = reg_msc_write_stat_cmd;
            break;

        case MHL_READ_DEVCAP:
            u32Startbit = reg_msc_read_devcap_cmd;
            break;

        case MHL_GET_STATE:
        case MHL_GET_VENDOR_ID:
        case MHL_SET_HPD:
        case MHL_CLR_HPD:
        case MHL_GET_SC1_ERRORCODE:      // 0x69 - Get channel 1 command error code
        case MHL_GET_DDC_ERRORCODE:      // 0x6A - Get DDC channel command error code.
        case MHL_GET_MSC_ERRORCODE:      // 0x6B - Get MSC command error code.
        case MHL_GET_SC3_ERRORCODE:      // 0x6D - Get channel 3 command error code.
            HDMIRX_HAL_MHLSetCmd_Offset(enPort,pReq->u32Command);
            u32Startbit = reg_msc_peer_cmd;
            break;

        case MHL_MSC_MSG:
            HDMIRX_HAL_MHLSet2NDDATA(enPort, pReq->u32MsgData[1]);
            HDMIRX_HAL_MHLSetCmd_Offset(enPort,pReq->u32Command);
			HDMI_INFO("CBUS:: MSG_MSC CMD:    0x%02X\n", pReq->u32Command );
            HDMI_INFO("CBUS:: MSG_MSC Data 0: 0x%02X\n", pReq->u32MsgData[0] );
            HDMI_INFO("CBUS:: MSG_MSC Data 1: 0x%02X\n", (int)pReq->u32MsgData[1] );
            u32Startbit = reg_msc_msc_msg_cmd;
            break;

        case MHL_WRITE_BURST:
            HDMIRX_HAL_MHLSetCmd_Offset(enPort, pReq->u32OffsetData + 0x40);
          //  COBRA_HAL_RegWriteFldAlign(MSC_WRITE_BURST_DATA_LEN, reg_msc_write_burst_len, pReq->u32Length - 1);
            HDMIRX_HAL_MHLSetBustLen(enPort, pReq->u32Length - 1);
            u32Startbit = reg_msc_write_burst_cmd;
            break;

        default:
            bSuccess = HI_FALSE;
            break;
    }

    /****************************************************************************************/
    /* Trigger the CBUS command transfer using the determined start bit.                    */
    /****************************************************************************************/
    if (bSuccess == HI_TRUE)
    {
       // COBRA_HAL_RegWriteFldAlign(MSC_COMMAND_START, u32Startbit, 1);
        HDMIRX_HAL_MHLSetCmdStart(enPort, u32Startbit);
    }

    return bSuccess;
}


//------------------------------------------------------------------------------
// Function:    
// Description: Starting at the current active index, send the next pending
//              entry, if any
//------------------------------------------------------------------------------

HI_U32 HDMIRX_MHL_SendNextInQueue(HI_UNF_HDMIRX_PORT_E enPort)
{
    HI_U32   u32Result = SUCCESS;
    HI_U32   u32NextIndex = 0;
    HDMIRX_MHL_CONTEXT_S *pstmhlCtx;
    
    pstmhlCtx = HDMIRX_MHL_GET_CTX();

    if ((pstmhlCtx->bHpdWaitTimeValid == HI_FALSE) && (pstmhlCtx->bAbortTimeValid == HI_FALSE) && (pstmhlCtx->bWaitTimeValid == HI_FALSE))
    {

        u32NextIndex = (CH_ACTIVE_INDEX == ( CBUS_MAX_COMMAND_QUEUE - 1 )) ? 0 : (CH_ACTIVE_INDEX + 1);
		while((pstmhlCtx->stRequest[u32NextIndex].u32ReqStatus != CBUS_REQ_PENDING ) ||
				(((pstmhlCtx->stRequest[u32NextIndex].u32MsgData[0] == MHL_MSC_MSG_RCPK) || (pstmhlCtx->stRequest[u32NextIndex].u32MsgData[0] == MHL_MSC_MSG_UCPK))) ||
				((pstmhlCtx->stRequest[u32NextIndex].u32MsgData[0] == MHL_MSC_MSG))
				)
		{
            if(u32NextIndex == CH_ACTIVE_INDEX )     // Searched whole queue, no pending
			{
				CH_ACTIVE_INDEX = CBUS_MAX_COMMAND_QUEUE - 1;
				return SUCCESS;  // No pending messages is still success
				
			}
			u32NextIndex = (u32NextIndex == (CBUS_MAX_COMMAND_QUEUE - 1)) ? 0 : (u32NextIndex + 1);
		}

		HDMI_INFO("Active Index: %0x---%x\n", u32NextIndex,pstmhlCtx->stRequest[u32NextIndex].u32Command);

		// Found a pending message, send it out
		if(HDMIRX_MHL_InternalWriteCommand(enPort,  &pstmhlCtx->stRequest[u32NextIndex]))
		{
			CH_ACTIVE_INDEX = u32NextIndex;
			
			do_gettimeofday(&pstmhlCtx->stWaitTime);
			pstmhlCtx->bWaitTimeValid = HI_TRUE;
			pstmhlCtx->enState = CBUS_SENT;
			pstmhlCtx->u32LastCbusSentCmd = pstmhlCtx->stRequest[CH_ACTIVE_INDEX].u32Command;

			if( pstmhlCtx->stRequest[CH_ACTIVE_INDEX].u32Command == MHL_CLR_HPD )
			{
				do_gettimeofday(&pstmhlCtx->stHpdWaitTime);
				pstmhlCtx->bHpdWaitTimeValid = HI_TRUE;
			}
			if( (pstmhlCtx->stRequest[CH_ACTIVE_INDEX].u32Command == MHL_SET_INT) && (pstmhlCtx->stRequest[CH_ACTIVE_INDEX].u32MsgData[0] == BIT2) )
			{
				HDMI_INFO( "Waiting for peer to respond to reqWrt!!\n");
				
				do_gettimeofday(&pstmhlCtx->stReqWrtTime);
			}

			if(pstmhlCtx->stRequest[u32NextIndex].u32Command == MHL_MSC_MSG )
			{
				if((pstmhlCtx->stRequest[u32NextIndex].u32MsgData[0] != MHL_MSC_MSG_RCPK) &&
					(pstmhlCtx->stRequest[u32NextIndex].u32MsgData[0] != MHL_MSC_MSG_RAPK) &&
					(pstmhlCtx->stRequest[u32NextIndex].u32MsgData[0] != MHL_MSC_MSG_UCPK))
				{
					do_gettimeofday(&pstmhlCtx->stRcpRapAbortTime);
					pstmhlCtx->bRcpRapAbortTimeValid = HI_TRUE;
				}
				if((pstmhlCtx->stRequest[u32NextIndex].u32MsgData[0] == MHL_MSC_MSG_RCPE) || (pstmhlCtx->stRequest[u32NextIndex].u32MsgData[0] == MHL_MSC_MSG_UCPE))
				{
					do_gettimeofday(&pstmhlCtx->stRcpeRcpkGapTime);
					pstmhlCtx->bRcpeRcpkGapTimeValid = HI_TRUE;
				}
			}
		}
		else
		{
            u32Result = ERROR_WRITE_FAILED;
           
		}
    }

    return u32Result;
}


#if SUPPORT_CBUS_CEC
HI_VOID HDMIRX_MHL_CecSendVendorId(HI_U32 *u32VendorId)
{
	//HDMIRX_CEC_SendVendorId(stCobraMhlSta.u32CecLa, CEC_LOGADDR_UNREGORBC, u32VendorId);
}
#endif

static HI_BOOL HDMIRX_MHL_SendDscrChange(HI_VOID)
{
	HI_BOOL bTemp;

	bTemp = HDMIRX_MHL_SendSetInt(0x00, BIT1);
	return bTemp;
}

//------------------------------------------------------------------------------
//! @brief  Check for valid CBUS RCP key code.  Although there is a one-to-one
//!         correspondence for most of the key codes, some codes supported by
//!         CEC are not supported by RCP and should be ignored.
//! @param[in]  CEC RC key
//------------------------------------------------------------------------------
HI_BOOL HDMIRX_MHL_ValidateRcpKeyCode(HI_U32 u32KeyData, HI_U32 u32SupportMask)
{
    HI_BOOL  bValidKey = HI_TRUE;

    // Is it valid for the specified logical device types
    if ((rcpValidate[u32KeyData & 0x7f] & u32SupportMask) == 0)
    {
        bValidKey = HI_FALSE;
    }

    return bValidKey;
 }

//------------------------------------------------------------------------------
// Function:    
// Description: Send MSC_MSG message to the specified CBUS channel (port)
//
// Parameters:  subCmd   - MSC_MSG cmd (RCP/RAP/ACP)
//              data     - MSC_MSG data
// Returns:     true     - successful queue/write
//              false    - write and/or queue failed
//------------------------------------------------------------------------------

static HI_BOOL HDMIRX_MHL_SendMscMsg(HI_U32 subCmd, HI_U32 data)
{
    cbus_req  stReq;

    stReq.u32Command     = MHL_MSC_MSG;
    stReq.u32MsgData[0]  = subCmd;
    stReq.u32MsgData[1]  = data;
	if(HDMIRX_MHL_WriteCommand(&stReq) == HI_FALSE)
	{
		HDMI_INFO("Couldn't send MHL_MSC_MSG to peer\n");
		return HI_FALSE;
	}
	
	return HI_TRUE;
}


//------------------------------------------------------------------------------
// Function:    SiiMhlRxSendRcpe
// Description: Send RCPE (error) message
//
// Parameters:  cmdStatus
// Returns:     true        - successful queue/write
//              false       - write and/or queue failed
//------------------------------------------------------------------------------
HI_BOOL HDMIRX_MHL_SendRcpe(HI_U32 u32CmdStatus)
{
    return(HDMIRX_MHL_SendMscMsg(MHL_MSC_MSG_RCPE, u32CmdStatus));
}
/*
HI_BOOL HDMIRX_MHL_SendRcp(HI_UNF_HDMIRX_RCP_KEY_E u32CmdStatus)
{
    HDMIRX_MHL_CONTEXT_S *pstmhlCtx;
    HI_BOOL bSendStatus = HI_FALSE;

    pstmhlCtx = HDMIRX_MHL_GET_CTX();
    if(u32CmdStatus < HI_UNF_HDMIRX_RCP_KEY_BUTT)
    {
        bSendStatus = HDMIRX_MHL_SendMscMsg(MHL_MSC_MSG_RCP, RcpKeyList[u32CmdStatus]);
        if(bSendStatus)
        {
            pstmhlCtx->u32RcpSentStatus = 1;
            do_gettimeofday(&pstmhlCtx->stRcpSentAbortTime); 
        }
    }
    return bSendStatus;
}
*/
//------------------------------------------------------------------------------
// Function:    
// Description: Process the passed RCP message.
// Returns:     The RCPK status code.
//------------------------------------------------------------------------------
static HI_U32 HDMIRX_MHL_ProcessRcpMessage (HI_U32 rcpData)
{
    HI_U32 rcpkStatus  = MHL_MSC_MSG_RCP_NO_ERROR;

    HDMI_INFO("RCP Key Code: 0x%02x\n", rcpData);


#if SUPPORT_CBUS_CEC
    {
        {
            // Message wasn't processed, send it to CEC bus
         //   HDMIRX_MHL_RcpToCec(rcpData);
        }
    }
#endif

	return rcpkStatus;
}

//------------------------------------------------------------------------------
//! @brief  Part of the callback from the CBUS component used for RAPx messages
// Returns:     The RAPK status code.
//------------------------------------------------------------------------------
static HI_U32 HDMIRX_MHL_ProcessRapMessage(HI_U32 u32Cmd, HI_U32 u32RapData)
{
    HI_U32 u32RapkStatus = MHL_MSC_MSG_RAP_NO_ERROR;

    HDMI_INFO("RAP Action Code: 0x%02x\n", u32RapData );

    if (u32Cmd == MHL_MSC_MSG_RAP)
    {
        switch (u32RapData)
        {
            case MHL_RAP_CMD_POLL:
                break;

            case MHL_RAP_CONTENT_ON:
                // MHL device sent a CONTENT ON message, change our source
                // selection to match the MHL device. If CEC is enabled, send
                // appropriate CEC messages.
               // app.newSource = (SiiSwitchSource_t)pAppCbus->port;

                HDMIRX_MHL_SetPathEn(HI_TRUE);


#if SUPPORT_CBUS_CEC
              //  HDMIRX_MHL_RapToCec;
#endif
                break;
            case MHL_RAP_CONTENT_OFF:
                // MHL device sent a CONTENT OFF message.  We need do nothing
                // unless CEC is enabled, in which case send appropriate CEC messages.


#if SUPPORT_CBUS_CEC
               // COBRA_MHL_RapToCec(u32RapData);
#endif
                break;
            default:
                u32RapData = MHL_MSC_MSG_RAP_UNRECOGNIZED_ACT_CODE;
                break;
        }
        /*
        if ((u32RapkStatus == MHL_MSC_MSG_RAP_UNSUPPORTED_ACT_CODE ) || (u32RapkStatus == MHL_MSC_MSG_RAP_UNRECOGNIZED_ACT_CODE ))
        {
            HDMI_INFO("Unsupported or unrecognized MHL RAP Action Code!!\n" );
        }
        */
    }
    else    // Process RAPK command.
    {
#if SUPPORT_CBUS_CEC
       // COBRA_MHL_RapToCec(u32RapData);
#endif
    }

    return u32RapkStatus;
}

//------------------------------------------------------------------------------
// Function:    
// Description: Process the passed UCP message.
// Returns:     The UCPK status code.
//------------------------------------------------------------------------------

static HI_U32 HDMIRX_MHL_ProcessUcpMessage(HI_U32 u32UcpData)
{
    HI_U32 u32UcpkStatus = MHL_MSC_MSG_UCP_NO_ERROR;

    HDMI_INFO("UCP ascii Code: 0x%02x\n", u32UcpData );

    if( u32UcpData > CBUS_UCP_ASCII_LIMIT )
    {
        u32UcpkStatus = MHL_MSC_MSG_UCP_INEFFECTIVE_KEY_CODE;
        HDMI_INFO("code not effective!!\n");
    }

    return u32UcpkStatus;
}


//------------------------------------------------------------------------------
//! @brief  This function is called from the CBUS component when a
//!         MSC_MSG (RCP/RAP) is received.  The prototype is defined in
//!         si_cbus_component.h
//! @param[in]  cmd     - RCP/RCPK/RCPE, RAP/RAPK
//!				msgData - RCP/RAP data
//! @return     RCP/RAP error status
//------------------------------------------------------------------------------
static HI_U32 HDMIRX_MHL_RcpRapReceived(HI_U32 u32Cmd, HI_U32 u32MsgData)
{
    HI_U32     u32Status = MHL_MSC_MSG_RCP_NO_ERROR;
    HDMIRX_MHL_CONTEXT_S *pstmhlCtx;
    pstmhlCtx = HDMIRX_MHL_GET_CTX();
    HDMI_INFO("Application layer:: MhlCbRxRcpRapReceived( %02x, %02x )\n", u32Cmd, u32MsgData );
    switch(u32Cmd)
    {
        case MHL_MSC_MSG_RCP:
            HDMI_INFO("RCP received by app.\n" );
            u32Status = HDMIRX_MHL_ProcessRcpMessage(u32MsgData);
            break;
        case MHL_MSC_MSG_RCPK:
            HDMI_INFO("RCPK received by app.\n" );
           
            pstmhlCtx->u32RcpSentStatus = 0;
#if 0//INC_CEC
            // If this RCPK follows an RCPE, and the initial RCP
            // originated from a CEC message, send a feature abort back
            // to the source of the CEC message.
            if ( pAppCbus->lastRcpFailed )
            {
                SkAppCbusCecFeatureAbort( msgData );
                pAppCbus->lastRcpFailed = false;
            }
            else
            {
            	switch(msgData)
            	{
            	case MHL_RCP_CMD_PLAY:
                	SiiCecSendActiveSource(pAppCbus->cecLa, pAppCbus->cecPa);
            		pAppCbus->deckStatus = CEC_DECKSTATUS_PLAY;
            		break;
            	case MHL_RCP_CMD_STOP:
            		pAppCbus->deckStatus = CEC_DECKSTATUS_STOP;
            		break;
            	case MHL_RCP_CMD_PAUSE:
            		pAppCbus->deckStatus = CEC_DECKSTATUS_STILL;
            		break;
            	default:
            		pAppCbus->deckStatus = CEC_DECKSTATUS_PLAY;
            		break;
            	}
            	SiiCecSendDeckStatus(pAppCbus->cecLa, pAppCbus->cecPa, pAppCbus->deckStatus);
            }
#endif
            break;
        case MHL_MSC_MSG_RCPE:
            HDMI_INFO("RCPE received by app.\n" );

#if 0//INC_CEC
            pAppCbus->lastRcpFailed = true;
#endif
            break;
        case MHL_MSC_MSG_RAP:
            HDMI_INFO("RAP received by app.\n" );
            u32Status = HDMIRX_MHL_ProcessRapMessage(u32Cmd, u32MsgData);
            break;
        case MHL_MSC_MSG_RAPK:
            HDMI_INFO("RAPK received by app.\n" );
            u32Status = HDMIRX_MHL_ProcessRapMessage(u32Cmd, u32MsgData);
           break;
        case MHL_MSC_MSG_UCP:
            HDMI_INFO("UCP received.\n" );
            u32Status = HDMIRX_MHL_ProcessUcpMessage(u32MsgData);
            break;
        case MHL_MSC_MSG_UCPK:
            HDMI_INFO("UCPK received.\n" );
            break;
        case MHL_MSC_MSG_UCPE:
            HDMI_INFO("UCPE received.\n" );
           break;
        default:
            break;
    }

    return u32Status;
}

//------------------------------------------------------------------------------
// Function:    
// Description: Send RCPK (ack) message
//
// Parameters:  keyCode
// Returns:     true        - successful queue/write
//              false       - write and/or queue failed
//------------------------------------------------------------------------------
HI_BOOL HDMIRX_MHL_SendRcpk(HI_U32 u32KeyCode)
{
    return(HDMIRX_MHL_SendMscMsg(MHL_MSC_MSG_RCPK, u32KeyCode));
}

//------------------------------------------------------------------------------
// Function:    
// Description: Send RAPK (acknowledge) message to the specified CBUS channel
//              and set the request status to idle.
//
// Parameters:  cmdStatus
// Returns:     true        - successful queue/write
//              false       - write and/or queue failed
//------------------------------------------------------------------------------

HI_BOOL HDMIRX_MHL_SendRapk (HI_U32 cmdStatus)
{
    return(HDMIRX_MHL_SendMscMsg(MHL_MSC_MSG_RAPK, cmdStatus));
}

HI_VOID HDMIRX_MHL_Reset(HI_VOID)
{
    printk("\n#############MHL Reset!\n");
   // return;
    
    HDMIRX_HAL_SetHpdLevel(HI_UNF_HDMIRX_PORT0, HI_FALSE);
    msleep(100);
    HDMIRX_HAL_SetHpdLevel(HI_UNF_HDMIRX_PORT0, HI_TRUE);
  //  HDMIRX_HAL_SetResetEn(HI_UNF_HDMIRX_PORT0, HDMIRX_BUS_RST, HI_TRUE);
    msleep(30);   
  //  HDMIRX_HAL_SetResetEn(HI_UNF_HDMIRX_PORT0, HDMIRX_BUS_RST, HI_FALSE);
    HDMIRX_HAL_SetHpdManual(HI_UNF_HDMIRX_PORT0, HI_FALSE);
    msleep(100);
       
}
//------------------------------------------------------------------------------
// Function:    
// Description: Send ACPE (error) message
//
// Parameters:  cmdStatus
// Returns:     true        - successful queue/write
//              false       - write and/or queue failed
//------------------------------------------------------------------------------
HI_BOOL HDMIRX_MHL_SendUcpe (HI_U32 u32CmdStatus)
{
    return(HDMIRX_MHL_SendMscMsg( MHL_MSC_MSG_UCPE, u32CmdStatus));
}

HI_BOOL HDMIRX_MHL_SendUcpk ( HI_U32 u32AsciiCode)
{
    return(HDMIRX_MHL_SendMscMsg( MHL_MSC_MSG_UCPK, u32AsciiCode));
}

HI_BOOL HDMIRX_MHL_SendMsge(HI_VOID)
{
    return(HDMIRX_MHL_SendMscMsg(MHL_MSC_MSG_E, MHL_MSC_INVALID_SUBCMD));
}


//------------------------------------------------------------------------------
//! @brief  Transfer a CBUS message to CEC
//! @param[in]
//------------------------------------------------------------------------------
HI_VOID HDMIRX_MHL_ProcessRcpRap (HI_U32 u32Cmd, HI_U32 u32MsgData)
{
    HI_U32  u32Status;
    HDMIRX_MHL_CONTEXT_S *pstmhlCtx;
    
    pstmhlCtx = HDMIRX_MHL_GET_CTX();
    switch(u32Cmd)
    {
#if 0
        case MHL_MSC_MSG_RCP:
            HDMI_INFO("RCP received. Key Code: %02x\n", u32MsgData);
            // Don't bother application with basic key code validation, do it here.
            if (HDMIRX_MHL_ValidateRcpKeyCode(u32MsgData, pstmhlCtx->u32SupportMask) == HI_FALSE)
            {
                HDMIRX_MHL_SendRcpe(MHL_MSC_MSG_RCP_INEFFECTIVE_KEY_CODE);
            }
            else
            {
                // Allow application to process key.
                u32Status = HDMIRX_MHL_RcpRapReceived(u32Cmd, u32MsgData);
                if(u32Status != MHL_MSC_MSG_RCP_NO_ERROR)
                {
                    HDMIRX_MHL_SendRcpe(u32Status);
                }
            }
            // Acknowledge command whether there was an error or not.
            HDMIRX_MHL_SendRcpk(u32MsgData);
            break;
#endif
        case MHL_MSC_MSG_RAP:
        	HDMI_INFO("RAP received. Action Code: %02x\n", u32MsgData);
            u32Status = HDMIRX_MHL_RcpRapReceived(u32Cmd, u32MsgData);
            HDMIRX_MHL_SendRapk(u32Status);
           break;
#if SUPPORT_MHL_20
        case MHL_MSC_MSG_UCP:
            HDMI_INFO("UCP received. Key Code: %02x\n", u32MsgData);
            // Allow application to process key.
            u32Status = HDMIRX_MHL_RcpRapReceived(u32Cmd, u32MsgData);
            if (u32Status != MHL_MSC_MSG_UCP_NO_ERROR )
            {
                HDMIRX_MHL_SendUcpe(u32Status);
            }
            HDMIRX_MHL_SendUcpk(u32MsgData);
            break;
#endif

        case MHL_MSC_MSG_RCPK:
        case MHL_MSC_MSG_RCPE:
        case MHL_MSC_MSG_RAPK:
        case MHL_MSC_MSG_UCPK:
        case MHL_MSC_MSG_UCPE:
            u32Status = HDMIRX_MHL_RcpRapReceived(u32Cmd, u32MsgData);
            break;

        default:
            HDMI_INFO("MSC_MSG sub-command not recognized!! Sending back MSGE code !!\n" );
            HDMIRX_MHL_SendMsge();
            break;
    }
}

HI_BOOL HDMIRX_MHL_IsBusConnected(HI_VOID)
{
    HDMIRX_MHL_CONTEXT_S *pstmhlCtx;
    
    pstmhlCtx = HDMIRX_MHL_GET_CTX();

    return pstmhlCtx->bBusConnected;
}

HI_VOID HDMIRX_MHL_HDMIMRST(HI_VOID)
{
    static HI_BOOL u32Step = 0;
    static HI_U32 u32Setpime = 0;
    HDMIRX_MHL_CONTEXT_S *pstmhlCtx;
    pstmhlCtx = HDMIRX_MHL_GET_CTX();
    
    if((HDMIRX_CTRL_GetCurPort() == HI_UNF_HDMIRX_PORT0) && (pstmhlCtx->bBusConnected == HI_TRUE)\
        && (pstmhlCtx->bCbusSense== HI_TRUE)&&(u32Step ==2))
    {
        u32Step =0 ;
        u32Setpime = 0;
    }

    if((HDMIRX_CTRL_GetCurPort() == HI_UNF_HDMIRX_PORT0) && (pstmhlCtx->bBusConnected == HI_FALSE)\
        && (pstmhlCtx->bCbusSense== HI_TRUE) && (u32Step == 0))
    {
        u32Setpime++; 
        if(u32Setpime > 100)
         {
            u32Step = 1;
            printk("MHL RST True\n");
            HDMIRX_HAL_SetTermMode(HI_UNF_HDMIRX_PORT0, HDMIRX_TERM_SEL_OPEN);
            HDMIRX_HAL_MHLRstEn(HI_TRUE);
            HDMIRX_HAL_MhlChRstEn(HI_TRUE);
            //HDMIRX_HAL_MHL_SENSE_Enable(HI_FALSE);

        }
    }
    if((HDMIRX_CTRL_GetCurPort() == HI_UNF_HDMIRX_PORT0)  && (u32Step == 1))
    {
        u32Setpime++; 
        if(u32Setpime > 125)
         {
            u32Step = 2;
            printk("MHL RST False\n");
            //HDMIRX_HAL_MHL_SENSE_Enable(HI_TRUE);
            HDMIRX_HAL_MHLRstEn(HI_FALSE);
            HDMIRX_HAL_MhlChRstEn(HI_FALSE);

        }
    }
}

HI_VOID HDMIRX_MHL_ConRST(HI_VOID)
{
    static HI_BOOL u32ConStep = 0;
    static HI_U32 u32Setime = 0;
    HI_UNF_SIG_STATUS_E  penSigSta;
    HDMIRX_MHL_CONTEXT_S *pstmhlCtx;
    pstmhlCtx = HDMIRX_MHL_GET_CTX();
    penSigSta = HDMIRX_CTRL_GetPortStatus(HI_UNF_HDMIRX_PORT0);
    if((HDMIRX_CTRL_GetCurPort() == HI_UNF_HDMIRX_PORT0) && (pstmhlCtx->bBusConnected == HI_TRUE)\
        && ((penSigSta == HI_UNF_SIG_NO_SIGNAL)))
    {
        u32Setime++;
        if((u32Setime > 250)&&(u32ConStep == 0))
        {
            printk("MHL Connect RST True\n");
            u32ConStep = 1;
            HDMIRX_HAL_SetResetEn(HI_UNF_HDMIRX_PORT0, HDMIRX_HDMIM_RST, HI_TRUE);
            //   HDMIRX_HAL_SetGPIO5_1(HI_FALSE);
        } 
    }
    else if((HDMIRX_CTRL_GetCurPort() == HI_UNF_HDMIRX_PORT0) && (pstmhlCtx->bBusConnected == HI_TRUE)\
        && ((penSigSta != HI_UNF_SIG_NO_SIGNAL)))
    {
        u32Setime = 0;
        u32ConStep = 0;
    }
    
    if((HDMIRX_CTRL_GetCurPort() == HI_UNF_HDMIRX_PORT0)  && (u32ConStep == 1))
    {
        u32Setime++; 
        if(u32Setime > 350)
         {
            u32ConStep = 0;
            u32Setime = 0;
            printk("MHL Connect RST False\n");
            HDMIRX_HAL_SetResetEn(HI_UNF_HDMIRX_PORT0, HDMIRX_HDMIM_RST, HI_FALSE);
          //  HDMIRX_HAL_SetGPIO5_1(HI_TRUE);
        }
    }
    
}

HI_VOID HDMIRX_MHL_CheckCbusState(HI_VOID)
{
    static HI_BOOL bFirstState = HI_TRUE;
    static HI_BOOL bFirstOnly= HI_TRUE;
    struct timeval stCurtime;
    static struct timeval stCbusime;
    HDMIRX_MHL_CONTEXT_S *pstmhlCtx;
    pstmhlCtx = HDMIRX_MHL_GET_CTX();
    if((HDMIRX_CTRL_GetCurPort() == HI_UNF_HDMIRX_PORT0) && (pstmhlCtx->bBusConnected == HI_FALSE)\
        && (pstmhlCtx->bCbusSense== HI_TRUE) && bFirstOnly)
    {
        if(bFirstState)
        {
            do_gettimeofday(&stCbusime); 
            bFirstState = HI_FALSE;
        }
        else
        {
            do_gettimeofday(&stCurtime);
            if(HDMIRX_TIME_DIFF_MS(stCurtime, stCbusime)>3000 ? HI_TRUE : HI_FALSE)
             {
                HDMIRX_MHL_Reset(); 
                bFirstState = HI_TRUE;
                bFirstOnly = HI_FALSE;
             }
        }
        
    }
    else if(bFirstState == HI_FALSE)
    {
        bFirstState = HI_TRUE;   
    }   
}

HI_U32 HDMIRX_MHL_RcpSendStatus(HI_VOID)
{
    HDMIRX_MHL_CONTEXT_S *pstmhlCtx;

    pstmhlCtx = HDMIRX_MHL_GET_CTX();

    return pstmhlCtx->u32RcpSentStatus ;
}
/*
HI_VOID HDMIRX_MHL_CheckConnState(HI_VOID)
{
    static HI_BOOL bCurportCon = HI_TRUE;
    HDMIRX_MHL_CONTEXT_S *pstmhlCtx;
    struct timeval stCurtime;
    HI_UNF_SIG_STATUS_E  penSigSta;
    pstmhlCtx = HDMIRX_MHL_GET_CTX();
    penSigSta = HDMIRX_CTRL_GetPortStatus(HI_UNF_HDMIRX_PORT0);
   // HDMIRX_DRV_CTRL_GetSigStatus(&penSigSta);
     if((HDMIRX_CTRL_GetCurPort() == HI_UNF_HDMIRX_PORT0) && (pstmhlCtx->bBusConnected == HI_TRUE)\
            && (penSigSta == HI_UNF_SIG_NO_SIGNAL))
    {
        if(bCurportCon == HI_TRUE)
        {
            do_gettimeofday(&pstmhlCtx->stCbuConAbortTime); 
            bCurportCon = HI_FALSE;
        }
        else
        {
            do_gettimeofday(&stCurtime);
             if(HDMIRX_TIME_DIFF_MS(stCurtime, pstmhlCtx->stCbuConAbortTime)>3000 ? HI_TRUE : HI_FALSE)
             { 
                HDMIRX_MHL_Reset();
                bCurportCon = HI_TRUE;
             }
        }
        
    }   
    else if(bCurportCon == HI_FALSE)
    {
        bCurportCon = HI_TRUE;
    }
}
*/
HI_VOID HDMIRX_MHL_SetEn(HI_BOOL bEn)
{
    if(bEn)
    {
        HDMIRX_MHL_OnOff(HI_TRUE);
		HDMIRX_MHL_SendDcapRdyMsg();
    }
    else
    {
        HDMIRX_MHL_OnOff(HI_FALSE);
    }
}

static HI_U32 HDMIRX_MHL_Handler(HI_UNF_HDMIRX_PORT_E enPort)
{
    HI_U32 u32Result = SUCCESS;
    HDMIRX_MHL_CONTEXT_S *pstmhlCtx;

    pstmhlCtx = HDMIRX_MHL_GET_CTX();
  //  HDMI_INFO("pstmhlCtx :%d,%d,%d\n",pstmhlCtx->bInitTimeValid,pstmhlCtx->bBusConnected,pstmhlCtx->u32MiscFlags);
    if((pstmhlCtx->bInitTimeValid == HI_FALSE) && (pstmhlCtx->bBusConnected == HI_TRUE) && 
		((pstmhlCtx->u32MiscFlags & FLAGS_SENT_DCAP_RDY) == HI_FALSE))
	{
        pstmhlCtx->u32MiscFlags |= FLAGS_SENT_DCAP_RDY;
        msleep(20);
        HDMIRX_HAL_SetTermMode(HI_UNF_HDMIRX_PORT0, HDMIRX_TERM_SEL_MHL);
      //  HDMIRX_MHL_OnOff(HI_FALSE);
        //msleep(400);
        HDMIRX_MHL_OnOff(HI_TRUE);
		HDMIRX_MHL_SendDcapRdyMsg();
 //       pstmhlCtx->u32RepeatSend = 0;
        do_gettimeofday(&pstmhlCtx->stCbusRepeatTime);
	}
   
    u32Result = HDMIRX_MHL_CheckInterruptStatus();
    HDMIRX_MHL_ChkTimers();
    /*
    if(pstmhlCtx->u32RepeatSend == 1)
    {
        printk("\n#############MHL RePeat send!\n");
        HDMIRX_HAL_SetHpdLevel(HI_UNF_HDMIRX_PORT0, HI_FALSE);
        msleep(400);
        HDMIRX_HAL_SetHpdLevel(HI_UNF_HDMIRX_PORT0, HI_TRUE);
        HDMIRX_HAL_SetHpdManual(HI_UNF_HDMIRX_PORT0, HI_FALSE);
        HDMIRX_MHL_OnOff(HI_TRUE);
	    HDMIRX_MHL_SendDcapRdyMsg();
        pstmhlCtx->u32RepeatSend = 2;
    }
    */
    if(pstmhlCtx->enState == CBUS_IDLE)
	{
		u32Result = HDMIRX_MHL_SendNextInQueue(enPort);
	}
    if(pstmhlCtx->enState & CBUS_XFR_DONE)
	{
		pstmhlCtx->enState = pstmhlCtx->enState & ~CBUS_XFR_DONE;
		if ( pstmhlCtx->u32LastCbusSentCmd == MHL_READ_DEVCAP )
		{
			pstmhlCtx->u32LastReadDevCapReg = pstmhlCtx->stRequest[CH_ACTIVE_INDEX].u32MsgData[0];
			HDMI_INFO(" Last read peer's device capability register is: %02x\n", pstmhlCtx->u32LastReadDevCapReg);
		}
#if SUPPORT_CBUS_CEC
		if (pstmhlCtx->u32LastCbusSentCmd == MHL_GET_VENDOR_ID )
		{
			HDMIRX_MHL_CecSendVendorId(pstmhlCtx->stRequest[CH_ACTIVE_INDEX].u32MsgData );
		}
#endif

		else if(pstmhlCtx->u32LastCbusSentCmd == MHL_WRITE_BURST)
		{
			// send DSCR_CHG interrupt to peer
			if(HDMIRX_MHL_SendDscrChange() == HI_FALSE)
			{
				HDMI_INFO("Couldn't send DSCR_CHG to peer\n");
			}
			pstmhlCtx->u32MiscFlags &= ~FLAGS_SCRATCHPAD_BUSY;

#if SUPPORT_MHL_20
			if(pstmhlCtx->u32Sending_3D_info)
			{
				//CBusSend3DInfo();
			}
#endif
		}

		pstmhlCtx->bWaitTimeValid = HI_FALSE;
		if(pstmhlCtx->u32QueueDepth > 0)
		{
			pstmhlCtx->u32QueueDepth--;
		}
		HDMI_INFO("\n-------Transfer Done!!------ Queue Depth: %02x active index(cbus): %02x\n", pstmhlCtx->u32QueueDepth, CH_ACTIVE_INDEX);
		memset(&(pstmhlCtx->stRequest[CH_ACTIVE_INDEX]), 0, sizeof( cbus_req));
	}

	if(pstmhlCtx->enState & CBUS_RECEIVED)
	{
	    // Process RCPx/RAPx messages
		pstmhlCtx->enState = pstmhlCtx->enState & ~CBUS_RECEIVED;
		if((pstmhlCtx->u32LastCbusRcvdCmd == MHL_MSC_MSG_RCPK) || (pstmhlCtx->u32LastCbusRcvdCmd == MHL_MSC_MSG_RAPK) || (pstmhlCtx->u32LastCbusRcvdCmd == MHL_MSC_MSG_UCPK))
		{
			pstmhlCtx->bRcpRapAbortTimeValid = HI_FALSE;
		}
		HDMIRX_MHL_ProcessRcpRap(pstmhlCtx->u32LastCbusRcvdCmd, pstmhlCtx->u32LastCbusRcvdData);
	}

	if(pstmhlCtx->enState & CBUS_FAILED)
	{
		pstmhlCtx->enState = pstmhlCtx->enState & ~CBUS_FAILED;
		pstmhlCtx->stRequest[CH_ACTIVE_INDEX].u32ReqStatus = CBUS_REQ_IDLE;
		if(pstmhlCtx->u32QueueDepth)
		{
			pstmhlCtx->u32QueueDepth--;
		}
		HDMI_INFO("\n-----Last Cbus cmd failed!!------Queue Depth: 0x%02x cmd failed: 0x%02x\n", pstmhlCtx->u32QueueDepth, pstmhlCtx->stRequest[CH_ACTIVE_INDEX].u32Command);
		memset(&(pstmhlCtx->stRequest[CH_ACTIVE_INDEX]), 0, sizeof(cbus_req));
	}
	
	return u32Result;
}
    
HI_BOOL HDMIRX_MHL_SignalEnable(HI_VOID)
{
   
    HDMIRX_MHL_CONTEXT_S *pstmhlCtx;
    HI_BOOL bEn;
    pstmhlCtx = HDMIRX_MHL_GET_CTX();
    bEn = (pstmhlCtx->bBusConnected)&& (HDMIRX_CTRL_GetCurPort() == HI_UNF_HDMIRX_PORT0);

    return bEn;
    
    
}

HI_VOID HDMIRX_MHL_MainHandler(HI_UNF_HDMIRX_PORT_E enPort)
{
    HI_U32 u32Result;
    HI_BOOL bExpired;
//    static HI_BOOL bfirst=HI_TRUE;
    struct timeval  stCurtime;
   // static HI_BOOL bFirst = HI_TRUE;
    HDMIRX_MHL_CONTEXT_S *pstmhlCtx;
    pstmhlCtx = HDMIRX_MHL_GET_CTX();
    
    HDMIRX_MHL_CusSense(enPort);
    HDMIRX_MHL_HDMIMRST();
    HDMIRX_MHL_ConRST();
    if(pstmhlCtx->bCbusEn == HI_FALSE)
    {   
        return;
    }
   // HDMIRX_MHL_CheckCbusState();
    /*
    if(bfirst && (HDMIRX_CTRL_GetCurPort() == HI_UNF_HDMIRX_PORT0))
    {
        HDMIRX_MHL_Reset();
        bfirst=HI_FALSE;
    }*/
    #if 0
    if(pstmhlCtx->bCbusEn == HI_FALSE)
    {
       // HDMI_INFO("bCbusEn fail\n");
       if(bFirst == HI_FALSE)
       {
       printk("####this is HDMI\n");

       HDMIRX_HAL_SetMhlEn(HI_TRUE);
        bFirst = HI_TRUE;
       }   
        return;
    }
    if(bFirst)
    {
       printk("####this is MHL\n");
        HDMIRX_HAL_SetMhlEn(HI_FALSE);
        bFirst = HI_FALSE;
    }
    #endif
    do_gettimeofday(&stCurtime);
    bExpired = (HDMIRX_TIME_DIFF_US(stCurtime, pstmhlCtx->stCbusTime)>20000 ? HI_TRUE : HI_FALSE);    
    if((pstmhlCtx->bCbusInterrupt == HI_FALSE) &&(bExpired == HI_FALSE) )
	{
        return;
    }    
    //HDMIRX_MHL_CheckConnState();
    if(pstmhlCtx->bCbusInterrupt == HI_TRUE)
    {
        pstmhlCtx->bCbusInterrupt = HI_FALSE;
    }
    do_gettimeofday(&pstmhlCtx->stCbusTime);
    u32Result = HDMIRX_MHL_Handler(enPort);
	
	if(u32Result != SUCCESS)
	{
		//printk("COBRA_MHL_Handler() failed with error :: %02x\n", u32Result);
		HDMI_INFO("%s:MHL_Handler fail\n",__FUNCTION__);
	}
    

}

static HI_VOID HDMIRX_MHL_CbusChannelIntproc(HI_UNF_HDMIRX_PORT_E enPort)
{
    HI_U32 u32IntStatus0, u32IntStatus1, u32IntStatusTemp;
    HDMIRX_MHL_CONTEXT_S *pstmhlCtx;
    pstmhlCtx = HDMIRX_MHL_GET_CTX();

    // Read CBUS interrupt status. Return if nothing happening on the interrupt front
    //u32IntStatus0 = COBRA_HAL_RegRead(CBUS_INT_0);
    //u32IntStatus1 = COBRA_HAL_RegRead(CBUS_INT_1);
    u32IntStatus0 = HDMIRX_HAL_MHLReadReg(enPort,HDMIRX_MHL_CBUS_INT0);
    u32IntStatus1 = HDMIRX_HAL_MHLReadReg(enPort,HDMIRX_MHL_CBUS_INT1);
   // HDMI_INFO("u32IntStatus0:0x%x , 0x%x \n",u32IntStatus0,u32IntStatus1);
    // clear the interrupts
    //COBRA_HAL_RegWrite(CBUS_INT_0, u32IntStatus0);
    //COBRA_HAL_RegWrite(CBUS_INT_1, u32IntStatus1);
    HDMIRX_HAL_MHLWriteReg(enPort,HDMIRX_MHL_CBUS_INT0,u32IntStatus0);
    HDMIRX_HAL_MHLWriteReg(enPort,HDMIRX_MHL_CBUS_INT1,u32IntStatus1);

    // mask out the interrupts that we don't care about
    u32IntStatus1 &= ~(msc_hb_max_fail | msc_mr_cec_capture_id | cbus_rcvd_valid);

    // Return if nothing happening on the interrupt front
    if(((u32IntStatus0&0xff) == 0) && ((u32IntStatus1&0xff) == 0))
    {
        return;
    }

  //  HDMI_INFO("useful IntStatus: 0x%x , 0x%x \n",u32IntStatus0,u32IntStatus1);
    // An interrupt occurred, save the status.
    pstmhlCtx->u32InterruptStatus0 = u32IntStatus0;
    pstmhlCtx->u32InterruptStatus1 = u32IntStatus1;
    pstmhlCtx->u32StatusFlags |= CBUS_INT ;

    if((u32IntStatus0 & 0xff) != 0)
    {
    	if ( u32IntStatus0 & msc_mt_done_nack )
		{
			pstmhlCtx->u32StatusFlags |= CBUS_NACK_RECEIVED_FM_PEER;
            HDMI_INFO("\n CBUS_NACK_RECEIVED_FM_PEER \n");
		}

    	if ( u32IntStatus0 & set_int )
		{
			u32IntStatusTemp = HDMIRX_HAL_MHLReadReg(enPort,HDMIRX_MHL_INT0);
			if( u32IntStatusTemp & BIT0 )
			{
				pstmhlCtx->u32StatusFlags |= CBUS_DCAP_CHG_RECEIVED_FM_PEER;
			}
			if ( u32IntStatusTemp & BIT1 )
			{
				pstmhlCtx->u32StatusFlags |= CBUS_SCRATCHPAD_WRITTEN_BY_PEER;
			}
			if( u32IntStatusTemp & BIT2 )
			{
				pstmhlCtx->u32StatusFlags |= CBUS_REQ_WRT_RECEIVED_FM_PEER;
			}
			if( u32IntStatusTemp & BIT3 )
			{
				pstmhlCtx->u32StatusFlags |= CBUS_GRT_WRT_RECEIVED_FM_PEER;
			}
			if( u32IntStatusTemp & BIT4 )
			{
				pstmhlCtx->u32StatusFlags |= CBUS_3D_REQ_RECEIVED_FM_PEER;
			}
            HDMI_INFO("\n set_int :%d \n",u32IntStatusTemp);
			HDMIRX_HAL_MHLWriteReg(enPort,HDMIRX_MHL_INT0, u32IntStatusTemp);   // Clear received interrupts
		}

    	// This step is redundant as we do get DSCR_CHG interrupt up there
    	if ( u32IntStatus0 & msc_mr_write_burst )
		{
    		pstmhlCtx->u32StatusFlags |= CBUS_SCRATCHPAD_WRITTEN_BY_PEER;
            HDMI_INFO("\nmsc_mr_write_burst\n");
		}

		// Get any VS or MSC data received
		if (u32IntStatus0 & msc_mr_msc_msg)
		{
			pstmhlCtx->u32StatusFlags |= CBUS_MSC_MSG_RCVD;
			pstmhlCtx->u32VsCmd= HDMIRX_HAL_MSC_RCVD_1STDATA(enPort);//COBRA_HAL_RegRead(MSC_MR_MSC_MSG_RCVD_1ST_DATA );
			pstmhlCtx->u32VsData= HDMIRX_HAL_MSC_RCVD_2NDDATA(enPort);//COBRA_HAL_RegRead(MSC_MR_MSC_MSG_RCVD_2ND_DATA );
            HDMI_INFO("\nmsc_mr_msc_msg\n");
        }

		if (u32IntStatus0 & msc_mr_write_stat)
		{
			// see if device capability values are changed
			u32IntStatusTemp = HDMIRX_HAL_MHLReadReg(enPort,HDMIRX_MHL_STAT_0);//COBRA_HAL_RegRead(MHL_STAT_0);
			if(u32IntStatusTemp & BIT0)
			{
				pstmhlCtx->u32StatusFlags |= CBUS_DCAP_RDY_RECEIVED_FM_PEER;
				HDMIRX_HAL_MHLWriteReg(enPort,HDMIRX_MHL_STAT_0, u32IntStatusTemp);
			}
            HDMI_INFO("HDMIRX_MHL_STAT_0:0x%x \n",u32IntStatusTemp);
			u32IntStatusTemp = HDMIRX_HAL_MHLReadReg(enPort,HDMIRX_MHL_STAT_1);//COBRA_HAL_RegRead(MHL_STAT_1);
			if(u32IntStatusTemp & BIT3)
			{
				pstmhlCtx->u32StatusFlags |= CBUS_PATH_EN_RECEIVED_FM_PEER;
				HDMIRX_HAL_MHLWriteReg(enPort,HDMIRX_MHL_STAT_1, u32IntStatusTemp);
  //              pstmhlCtx->u32RepeatSend = 2;
			}
            HDMI_INFO("HDMIRX_MHL_STAT_1:0x%x \n",u32IntStatusTemp);
            HDMI_INFO("\nmsc_mr_write_stat\n");
		}

		if ( u32IntStatus0 & msc_mt_done )
		{
			pstmhlCtx->u32StatusFlags |= CBUS_MSC_CMD_DONE;
			pstmhlCtx->u32MsgData0 = HDMIRX_HAL_MSCMT_RCVD_DATA0(enPort); //COBRA_HAL_RegRead(MSC_MT_RCVD_DATA0);
			pstmhlCtx->u32MsgData1 = HDMIRX_HAL_MSCMT_RCVD_DATA1(enPort); //COBRA_HAL_RegRead(MSC_MT_RCVD_DATA1);
            HDMI_INFO("\nmsc_mt_done\n");
        }

	    // Bus status changed?
	    if ( u32IntStatus0 & cbus_cnx_chg )
	    {
	    	pstmhlCtx->u32StatusFlags |= CBUS_CBUS_CONNECTION_CHG;
	        pstmhlCtx->bBusConnected = HDMIRX_HAL_GetCBUS_Connected(enPort);//COBRA_HAL_RegReadFldAlign(CBUS_STATUS, reg_cbus_connected);
            if(pstmhlCtx->bBusConnected == HI_FALSE)
            {
                pstmhlCtx->u32MiscFlags = 0;
             //   HDMIRX_MHL_ResetToIdle();
            }
            printk("\ncbus_cnx_chg:%s\n",pstmhlCtx->bBusConnected ? "connect" :"disconnect");
        }
    }

    if(u32IntStatus1)
    {
        if (u32IntStatus1 & cec_abrt)
        {
            pstmhlCtx->u32CecAbortReason = HDMIRX_HAL_GetABORT_INT(enPort,HDMIRX_CEC_ABORT);//COBRA_HAL_RegRead( CEC_ABORT_INT );
            pstmhlCtx->u32StatusFlags |= CBUS_CEC_ABORT;
            //COBRA_HAL_RegWrite( CEC_ABORT_INT, pstmhlCtx->u32CecAbortReason );
            HDMIRX_HAL_SetABORT_INT(enPort,HDMIRX_CEC_ABORT,pstmhlCtx->u32CecAbortReason);
            HDMI_INFO("\ncec_abrt\n");
        }

        if (u32IntStatus1 & ddc_abrt)
        {
            pstmhlCtx->u32DdcAbortReason = HDMIRX_HAL_GetABORT_INT(enPort,HDMIRX_DDC_ABORT);//COBRA_HAL_RegRead(DDC_ABORT_INT);
            pstmhlCtx->u32StatusFlags |= CBUS_DDC_ABORT;
            //COBRA_HAL_RegWrite(DDC_ABORT_INT, pstmhlCtx->u32DdcAbortReason);
            HDMIRX_HAL_SetABORT_INT(enPort,HDMIRX_DDC_ABORT,pstmhlCtx->u32DdcAbortReason);
            HDMI_INFO("\nddc_abrt\n");
        }

        // MSC_ABORT received from peer
        if ( u32IntStatus1 & msc_mr_abrt )
        {
            pstmhlCtx->u32MscAbortFmPeerReason = HDMIRX_HAL_GetABORT_INT(enPort,HDMIRX_MSC_MR_ABORT);//COBRA_HAL_RegRead(MSC_MR_ABORT_INT);
            pstmhlCtx->u32StatusFlags |= CBUS_XFR_ABORT_R;
            //COBRA_HAL_RegWrite( MSC_MR_ABORT_INT, pstmhlCtx->u32MscAbortFmPeerReason);
            HDMIRX_HAL_SetABORT_INT(enPort,HDMIRX_MSC_MR_ABORT,pstmhlCtx->u32MscAbortFmPeerReason);
            HDMI_INFO("\nmsc_mr_abrt\n");
        }

        // MSC_ABORT happened at this device itself
        if (u32IntStatus1 & msc_mt_abrt)
        {
            pstmhlCtx->u32MscAbortReason = HDMIRX_HAL_GetABORT_INT(enPort,HDMIRX_MSC_MR_ABORT);//COBRA_HAL_RegRead(MSC_MT_ABORT_INT);
            pstmhlCtx->u32StatusFlags |= CBUS_XFR_ABORT_T;
            //COBRA_HAL_RegWrite( MSC_MT_ABORT_INT, pstmhlCtx->u32MscAbortReason);
            HDMIRX_HAL_SetABORT_INT(enPort,HDMIRX_MSC_MR_ABORT,pstmhlCtx->u32MscAbortReason);
            HDMI_INFO("\nmsc_mt_abrt\n");
        }
    }
}    


//------------------------------------------------------------------------------
// Function:    
// Description: Check CBUS registers for a CBUS event
//------------------------------------------------------------------------------

HI_VOID HDMIRX_MHL_CbusIsr(HI_UNF_HDMIRX_PORT_E enPort)
{
    HDMIRX_MHL_CONTEXT_S *pstmhlCtx;

    pstmhlCtx = HDMIRX_MHL_GET_CTX();

    if(pstmhlCtx->bCbusSense == HI_FALSE)
    {
        return;
    }
    HDMIRX_MHL_CbusChannelIntproc(enPort);
    
    //SiiSchedSendSignal(SI_EVENT_ID_CBUS_INT, 0);
    if(pstmhlCtx->u32StatusFlags & CBUS_INT)
    {
		pstmhlCtx->bCbusInterrupt = HI_TRUE;
    }
}

HI_VOID HDMIRX_MHL_ProcRead(struct seq_file *s)
{
    HDMIRX_MHL_CONTEXT_S *pstmhlCtx;
    pstmhlCtx = HDMIRX_MHL_GET_CTX();
    
    PROC_PRINT(s, "\n---------------HDMIRX MHL---------------\n");
  //PROC_PRINT(s,"AudioState           :   OFF\n"); 
    PROC_PRINT(s,"MHLState             :   0x%x\n",pstmhlCtx->u32StatusFlags); 
  //  PROC_PRINT(s,"InterruptStatus0     :   0x%x\n",pstmhlCtx->u32InterruptStatus0);
  //  PROC_PRINT(s,"InterruptStatus1     :   0x%x\n",pstmhlCtx->u32InterruptStatus1);
    PROC_PRINT(s,"bBusConnected        :   %s\n",pstmhlCtx->bBusConnected?"Yes":"No");
 //   PROC_PRINT(s,"VsCmd                :   0x%x\n",pstmhlCtx->u32VsCmd);
 //   PROC_PRINT(s,"VsData               :   0x%x\n",pstmhlCtx->u32VsData);
 //   PROC_PRINT(s,"MsgData0             :   0x%x\n",pstmhlCtx->u32MsgData0);
 //   PROC_PRINT(s,"MsgData1             :   0x%x\n",pstmhlCtx->u32MsgData1);
 //   PROC_PRINT(s,"CecAbortReason       :   0x%x\n",pstmhlCtx->u32CecAbortReason);
 //   PROC_PRINT(s,"DdcAbortReason       :   0x%x\n",pstmhlCtx->u32DdcAbortReason);
 //   PROC_PRINT(s,"MscAbortFmPeerReason :   0x%x\n",pstmhlCtx->u32MscAbortFmPeerReason);
 //   PROC_PRINT(s,"MscAbortReason       :   0x%x\n",pstmhlCtx->u32MscAbortReason);
 //   PROC_PRINT(s,"CbusInterrupt        :   %s\n",pstmhlCtx->bCbusInterrupt?"Yes":"No");
    PROC_PRINT(s,"CbusEn               :   %s\n",pstmhlCtx->bCbusEn?"Yes":"No");
    PROC_PRINT(s,"CbusSense            :   %s\n",pstmhlCtx->bCbusSense?"Yes":"No");
  //  PROC_PRINT(s,"Port                 :   %d\n",pstmhlCtx->u32Port);
 //   PROC_PRINT(s,"SupportMask          :   %d\n",pstmhlCtx->u32SupportMask);
    PROC_PRINT(s,"State                :   0x%x\n",pstmhlCtx->enState);
    PROC_PRINT(s,"QueueDepth           :   %d\n",pstmhlCtx->u32QueueDepth);
 //   PROC_PRINT(s,"LastCbusRcvdCmd      :   %d\n",pstmhlCtx->u32LastCbusRcvdCmd);
 //   PROC_PRINT(s,"LastCbusRcvdData     :   %d\n",pstmhlCtx->u32LastCbusRcvdData);
 //   PROC_PRINT(s,"LastCbusRcvdData     :   %d\n",pstmhlCtx->u32LastCbusRcvdData);
 //   PROC_PRINT(s,"2MiscFlags           :   %d\n",pstmhlCtx->u32MiscFlags);
    PROC_PRINT(s,"PathEnableSent       :   %d\n",pstmhlCtx->bPathEnableSent);
    PROC_PRINT(s,"InitTimeValid        :   %d\n",pstmhlCtx->bInitTimeValid);
    PROC_PRINT(s,"RcpSendStatus        :   %d\n",HDMIRX_MHL_RcpSendStatus());
    
}

HI_VOID HDMIRX_MHL_Suspend(HI_VOID)
{
    HDMIRX_MHL_CONTEXT_S *pstmhlCtx;
    pstmhlCtx = HDMIRX_MHL_GET_CTX();
    memset(pstmhlCtx,0,sizeof(HDMIRX_MHL_CONTEXT_S));
}

HI_VOID HDMIRX_MHL_Initialize(HI_UNF_HDMIRX_PORT_E enPort)
{
    HI_U8  u8Index;
    HDMIRX_MHL_CONTEXT_S *pstmhlCtx;
    pstmhlCtx = HDMIRX_MHL_GET_CTX();
    memset(pstmhlCtx,0,sizeof(HDMIRX_MHL_CONTEXT_S));
 //   pstmhlCtx->u32RepeatSend = 2;
   // pstmhlCtx->u32Port = 0;
    /*
    //Set Min and Max discover pulse width
    //This gives us ~153.5us if OSC=20MHz and ~139.6us if OSC=22MHz (20MHz + 10%).
    SiiRegWrite( REG_CBUS_DISC_PWIDTH_MIN, 0x4E );
    SiiRegWrite( REG_CBUS_DISC_PWIDTH_MAX, 0xC0 );

    // Set default CBUS bit offset
    SiiRegModify(REG_CBUS_LINK_CTRL11, MSK_CBUS_LINK_BIT_OFFSET, 0x4 << SFT_CBUS_LINK_BIT_OFFSET);
    */
    
//    HDMIRX_HAL_SetResetEn(enPort,HDMIRX_HDMIM_RST, HI_TRUE);
//	udelay(10);
//	HDMIRX_HAL_SetResetEn(enPort,HDMIRX_HDMIM_RST, HI_FALSE);
     // Setup local DEVCAP registers for read by the peer per rc7
   for (u8Index=0; u8Index<30; )
   {
       HDMIRX_HAL_MHLDevcapInit(enPort,CbusRegsList[u8Index], CbusRegsList[u8Index+1]);
       u8Index+=2 ;
   }
    HDMIRX_HAL_MHLInit(enPort);
    //mhlPortBits = SiiDrvCbusPortSelectBitsGet();      // Get the MHL selected port bit-field.

    //SiiRegWrite( REG_MHL_1X2X_PORT_REG2, 0x00 );  // SVR

	//Enable Cbus Cable sense
    //SiiRegWrite( REG_CH0_INTR4_MASK, mhlPortBits );

    // Set up both MHL GPIOs for cable sense.
/*    TODO: GPIO used for MHL Cable Detect
    SiiDrvGpioPinType( SII_GPIO_PIN_0, SII_GPIO_ALT_MHL_CABLE_CONN0 );
    SiiDrvGpioPinType( SII_GPIO_PIN_1, SII_GPIO_ALT_MHL_CABLE_CONN1);
   
    SiiDrvGpioPinConfigure(
            SII_GPIO_PIN_0 | SII_GPIO_PIN_1,
            SII_GPIO_INPUT | SII_GPIO_INT_RISING_EDGE |
            SII_GPIO_INT_FALLING_EDGE );
    SiiDrvGpioIntEnable( SII_GPIO_PIN_0 | SII_GPIO_PIN_1, SII_GPIO_PIN_0 | SII_GPIO_PIN_1 );
*/
    pstmhlCtx->u32SupportMask = MHL_LOG_DEV_MAP;
  
}

#endif
#ifdef __cplusplus
 #if __cplusplus
}
 #endif
#endif /* __cplusplus */

