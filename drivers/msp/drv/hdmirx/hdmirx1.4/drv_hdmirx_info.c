//******************************************************************************
//  Copyright (C), 2007-2011, Hisilicon Technologies Co., Ltd.
//
//******************************************************************************
// File name     : hi_tvd.c
// Version       : 1.0
// Author        : tanglin/202585
// Created       : 2011-06-04
// Last Modified : 
// Description   :  The C union definition file for the module tvd
// Function List : 
// History       : 
// 1 Date        : 
// Author        : tanglin/202585
// Modification  : Create file
//******************************************************************************
#include <linux/kernel.h>       /* HDMIRX_DEBUG */
#include <asm/io.h>             /* ioremap_nocache */
//#include <linux/sched.h>
//#include <linux/delay.h>
#include <linux/string.h>

//#include "hi_tvd.h"
#include "hi_type.h"
//#include "command.h"
//#include "int.h"

#include "drv_hdmirx_info_internal.h"



/****************************************************************************************
    basic function of avi
*****************************************************************************************/
static HI_BOOL HDMI_INFO_IsCheckSumOk(HI_U32 *p_data, HI_U32 length)
{
    HI_U8 i;
    HI_U8 check_sum = 0;
    for (i = 0; i < length; i++, p_data++) {
        check_sum += (HI_U8)((*p_data)&0x000000ff);
    }
    
    return (0 == check_sum);
}

HI_U32 HDMI_INFO_AvMuteRequest(HI_BOOL bOnOff, HI_U8 u8Cause)
{
    if (u8Cause > 0) {
        if (bOnOff) {
            hdmi_ctx.StrInfo.u8AvMask |= u8Cause;
            if (u8Cause & AV_MUTE_NO_AVI) {
                hdmi_ctx.StrInfo.u32NoAviMuteTimeout = 1000;
            }
        }
        else {
            hdmi_ctx.StrInfo.u8AvMask &= ~u8Cause;
            if (u8Cause & AV_MUTE_NO_AVI) {
                hdmi_ctx.StrInfo.u32NoAviMuteTimeout = 0;
            }
        }

    }
    return hdmi_ctx.StrInfo.u8AvMask;
}
static void HDMI_AVI_StoreData(HI_U32 *p_data)
{
	memcpy(hdmi_ctx.au32AviData, &p_data[IF_HEADER_LENGTH], AVI_LENGTH<<2);

	hdmi_ctx.u32AviVersion= p_data[1];
	if(hdmi_ctx.u32AviVersion < 2)
	{
		hdmi_ctx.au32AviData[3] = 0; // VIC=0
		hdmi_ctx.au32AviData[4] = 0; // Repetition
	}
}

static void HDMI_AVI_OnPacketReceiving(void)
{
	hdmi_ctx.strTimingInfo.bHdmiVicReceived = HI_TRUE;
	hdmi_ctx.strTimingInfo.u8Cea861Vic = (hdmi_ctx.au32AviData[3] & 0x0000007f);
    HDMIRX_DEBUG("avi vic = %d \n",hdmi_ctx.strTimingInfo.u8Cea861Vic);
    #if SUPPORT_3D
    if(hdmi_ctx.strTimingInfo.bHdmi3dVsifReceived) {
        HDMI_VDO_Verify1P4Format(HI_TRUE);
    }
    #endif
}

colorimetry_type HDMI_AVI_GetColorMetry(void)
{
	colorimetry_type c = (colorimetry_type) ((hdmi_ctx.au32AviData[1] >> 6) & 0x00000003);
	if(Colorimetry_Extended == c)
	{
		HI_U32 ec = (hdmi_ctx.au32AviData[2] >> 4) & 0x07;
		if(ec < 2)
		{
			c = Colorimetry_xv601 + (colorimetry_type)ec;
		}
		else
		{
			c = Colorimetry_NoInfo;
		}
	}
	return c;
}

color_space_type HDMI_AVI_GetColorSpace(void)
{
	return (color_space_type) ((hdmi_ctx.au32AviData[0] >> 5) & 0x00000003);
}

HI_U32 HDMI_AVI_GetReplication(void)
{
    return (hdmi_ctx.au32AviData[4]&0x0f);
}

HI_BOOL HDMI_AVI_GetDataValid(void)
{
    return (hdmi_ctx.u32AviVersion >= 2);
}

void HDMI_AVI_ResetData(void)
{
	memset(hdmi_ctx.au32AviData, 0, sizeof(hdmi_ctx.au32AviData));
	hdmi_ctx.u32AviVersion = 0;
}
#if 0
void HDMI_INFO_AvMuteRequest(HI_BOOL bOnOff, HI_U32 u32Cause)
{

	if(u32Cause)
	{
		if(bOnOff)
		{
			//  mute ON
			hdmi_ctx.HDMI_RxInfo.u32AvMask |= u32Cause;
			if(u32Cause & RX_OUT_AV_MUTE_M__NO_AVI)
				hdmi_ctx.HDMI_RxInfo.no_avi_mute_timeout = 1000;  // ms
		}
		else
		{
			//  mute OFF
			hdmi_ctx.HDMI_RxInfo.u32AvMask &= ~u32Cause;
			if(u32Cause & RX_OUT_AV_MUTE_M__NO_AVI)
			{
				hdmi_ctx.HDMI_RxInfo.u32AvMask = 0;
			}
		}
	}

}
#endif
void HDMI_INFO_ResetInfoFrameData(void)
{
	hdmi_ctx.strTimingInfo.bAviReceived = HI_FALSE;
	hdmi_ctx.strTimingInfo.bHdmi3dVsifReceived= HI_FALSE;
	hdmi_ctx.strTimingInfo.bHdmiVicReceived= HI_FALSE;
}

static void HDMI_VSIF_ChangeState(vsif_spd_state enNewstate, HI_U16 u16Timeout)
{
    hdmi_ctx.StrInfo.u16VsifTimer = u16Timeout;
    hdmi_ctx.StrInfo.u8VsifState = enNewstate;
    hdmi_ctx.StrInfo.u16ElapseTime[0] = 0;
}

/* 
------------------------------------------------------------------------------
    Function:    HDMI_INFO_ResetData
    Description: to reset all infoframe/infopacket struct and some process
    Parameters:  none
    Returns:     none
    NOTE: 1. reset all the infoframe struct member to zero.
          2. reset the avi struct.
          3. acp type reset to General and turn on the spdif.
          4. turn on the acp int.
          5. clr the flag of avi/vsif/vic received.
-----------------------------------------------------------------------------
*/
static void HDMI_ISRC_ChangeState(isrc_states enNewState, HI_U16 u16TimeOut);

void HDMI_INFO_ResetData(void)
{
    memset(&hdmi_ctx.StrInfo, 0, sizeof(hdmi_ctx.StrInfo));
    HDMI_AVI_ResetData();
    #if SUPPORT_AUDIO
    hdmi_ctx.StrInfo.enAcpType = acp_GeneralAudio;
    HDMI_AUD_UpdateOnAcp(hdmi_ctx.StrInfo.enAcpType);
    HDMI_ISR_AcpIntOnOff(HI_TRUE);
    #endif
    HDMI_ISR_DisVResChangeEventsOnOff(HI_FALSE);
    #if 1
    HDMI_INFO_AvMuteRequest(HI_FALSE, AV_MUTE_INP_AV_MUTE_CAME | AV_MUTE_NO_AVI);
    #endif
    HDMI_VSIF_ChangeState(VSIF_SPD_INIT, 1);
    #if SUPPORT_ISRC
    HDMI_ISRC_ChangeState(ISRC_ST_INIT, 1);
    #endif
    HDMI_INFO_ResetInfoFrameData();
}

void HDMI_INFO_Initial(void)
{
    /* 
        according the spec,the acp infopacket is x04.
    */
    HDMI_HAL_RegWrite(RX_ACP_DEC,4);
    
    HDMI_INFO_ResetData();
    #if 1
    HDMI_INFO_AvMuteRequest(HI_FALSE, AV_MUTE_INP_AV_MUTE_CAME | AV_MUTE_NO_AVI);
    #endif
}

void HDMI_INFO_CpHandler(void)
{
    if (HDMI_INFO_AvMuteRequest(HI_FALSE, 0) & AV_MUTE_INP_AV_MUTE_CAME) {
        // TX is muted by AV Mute from RX, see whether it need to be UNmuted
		if(0 == HDMI_HAL_RegReadFldAlign(RX_AUDP_STAT, hdmi_mute))
		{
			HDMI_INFO_AvMuteRequest(HI_FALSE, AV_MUTE_INP_AV_MUTE_CAME);
			HDMI_ISR_CpInterruptOnOff(HI_TRUE); // prepare for fast muting when required
		}
    }
    else {
        if (HDMI_HAL_RegReadFldAlign(RX_AUDP_STAT, hdmi_mute)) {
            HDMI_INFO_AvMuteRequest(HI_TRUE, AV_MUTE_INP_AV_MUTE_CAME);
            HDMI_ISR_CpInterruptOnOff(HI_FALSE); // stop CP Mute serving in RxIsr module
        }
    }
}
void HDMI_AVI_NoAviHandler(void)
{
    HDMI_AVI_ResetData();

    if (hdmi_ctx.u32HdmiState == HDMI_STATE_VIDEO_ON) {
        HDMI_VDO_SetVideoPath();
    }
    #if 1
    HDMI_INFO_AvMuteRequest(HI_TRUE, AV_MUTE_NO_AVI);
    #endif
}



vsif_check_result HDMI_VSIF_GetType(HI_U32 *pPacket, HI_U8 u8Length)
{
    vsif_check_result Analysis = NOT_HDMI_VSIF;
     // Check HDMI VSIF signature.
	// HDMI IEEE Registration Identifier is 0x000C03 (least significant byte first).
	if((0x03 == pPacket[0]) && (0x0C == pPacket[1]) && (0x00 == pPacket[2]))
	{
		// HDMI VSIF signature is found.
		// Check HDMI format.

		HI_U8 hdmi_video_format = (HI_U8)(pPacket[3] >> 5);

		switch(hdmi_video_format)
		{
		case 1:
			// HDMI VIC format (extended resolution format)
			Analysis = NEW_EXTENDED_RESOLUTION;
			if(
				hdmi_ctx.strTimingInfo.bHdmiVicReceived&&
				(hdmi_ctx.strTimingInfo.u8HdmiVic== (HI_U8)pPacket[4])
				)
			{
				// HDMI VIC has been received and the new packet
				// caries the same HDMI VIC.
				Analysis = OLD_EXTENDED_RESOLUTION;
			}
			break;
		case 2:
			// 3D format.
			if(hdmi_ctx.strTimingInfo.bHdmi3dVsifReceived)
			{
				Analysis = OLD_3D;
				// may be modified by the next few lines.

				// Check if new 3D structure field matches
				// previously received packet.
				if(hdmi_ctx.strTimingInfo.u8Hdmi3dStructure != (HI_U8)(pPacket[4] >> 4))
				{
					// 3D_Structure is different; the packet is new 3D.
					Analysis = NEW_3D;
				}
				// Side-by-Side (Half) has at least one additional parameter.
				// Check if it matches to the previously received one.
				if((8 == hdmi_ctx.strTimingInfo.u8Hdmi3dStructure) && (u8Length > 4))
				{
					// 3D_Ext_Data field
					if(hdmi_ctx.strTimingInfo.u8Hdmi3dExtData!= (HI_U8)(pPacket[5] >> 4))
					{
						// 3D_Structure is different; the packet is new 3D.
						Analysis = NEW_3D;
					}
				}
			}
			else
			{
				// First 3D packet receiving.
				Analysis = NEW_3D;
			}
			break;
		}
	}
	return Analysis;   
}

void HDMI_VSIF_Process(HI_U32* pPacket, HI_U8 u8Length)
{
    HI_U32 u32HdmiFormat;
    
    u32HdmiFormat = (pPacket[3]>>5);
    switch(u32HdmiFormat) {
        case 1:
            hdmi_ctx.strTimingInfo.u8HdmiVic = (HI_U8)(pPacket[4]);
            hdmi_ctx.strTimingInfo.bHdmiVicReceived = HI_TRUE;
            hdmi_ctx.strTimingInfo.bHdmi3dVsifReceived = HI_FALSE;
            hdmi_ctx.strTimingInfo.u8Hdmi3dStructure = 0;
            hdmi_ctx.strTimingInfo.u8Hdmi3dExtData = 0;
            // HDMI VIC (4K2K) video detected.
		    // RX Video State Machine has to be informed
		    // as video re-detection may be required.
            HDMI_VDO_Verify1P4Format(HI_TRUE);
            break;
         case 2:
            // 3D format
		    // Get 3D structure field.
		    // Timing from VideoModeTable[] has to be modified
		    // depending on the 3d_Structure field.
		    // Store it for further processing.
		    hdmi_ctx.strTimingInfo.u8Hdmi3dStructure = (HI_U8)(pPacket[4] >> 4);
		    // Side-by-Side (Half) has at least one additional parameter,
		    // collect it.
		    hdmi_ctx.strTimingInfo.u8Hdmi3dExtData = (hdmi_ctx.strTimingInfo.u8Hdmi3dStructure >= 8) && (u8Length > 4) ?
			(HI_U8)(pPacket[5] >> 4) : // has 3D_Ext_Data field
			0;
		    hdmi_ctx.strTimingInfo.bHdmi3dVsifReceived = HI_TRUE;

		    // Reset HDMI VIC info
		    // (HDMI 1.4 spec does not allow HDMI VIC & 3D at the same time)
		    hdmi_ctx.strTimingInfo.u8HdmiVic = 0;
		    hdmi_ctx.strTimingInfo.bHdmiVicReceived = HI_TRUE;

		    if(hdmi_ctx.strTimingInfo.bAviReceived)
		    {
			    // 3D video detected.
			    // RX Video State Machine has to be informed
			    // as video re-detection may be required.
			    HDMI_VDO_Verify1P4Format(HI_TRUE);
		    }
		    break;
            
    }
}

static void HDMI_SPD_OnReceiving(HI_U32 packet[IF_BUFFER_LENGTH])
{
	HI_U8 u8Length = packet[IF_LENGTH_INDEX];

	hdmi_ctx.StrInfo.bSpdReceived = HI_TRUE;

	if( (u8Length >= IF_MIN_SPD_LENGTH) && (u8Length <= IF_MAX_SPD_LENGTH) &&
		HDMI_INFO_IsCheckSumOk(packet, u8Length + IF_HEADER_LENGTH) )
	{
		// The packet looks valid.
		hdmi_ctx.StrInfo.strReceivedPacket.SPD = HI_TRUE;
		if(memcmp(packet, hdmi_ctx.StrInfo.au32SpdBuffer, sizeof(hdmi_ctx.StrInfo.au32SpdBuffer)))
		{
			// The received packet differs from the previous one.
			// Copy received packet into the shadow buffer.
			// It will be used to compare with the newly coming ones.
			memcpy(hdmi_ctx.StrInfo.au32SpdBuffer, packet, SPD_BUFFER_LENGTH);

		}
	}
	else
	{
		// The packet is invalid.
		hdmi_ctx.StrInfo.strFailedPackets.SPD = HI_TRUE;
	}

	// No SPD has been received during given timeout.
	if(hdmi_ctx.StrInfo.bSpdReceived && hdmi_ctx.StrInfo.bVsifReceived)
	{
		// Since both HDMI VSIF and SPD are received,
		// switching to VSIF receiving right now can
		// cause unnecessary short SPD and VSIF
		// receiving service loop and cause unnecessary
		// extensive I2C traffic. To reduce it, go to the
		// delay state for a short time.
		HDMI_VSIF_ChangeState(VSIF_SPD_DELAY, 20);
		// Disable SPD/VSIF interrupts for a while.
		HDMI_ISR_SpdIntOnOff(HI_FALSE);
	}
	else
	{
		// At least one of the searching packets has not been received.
		// Check VSIF now.
		//HDMIRX_DEBUG("VSIF state will change to VSIF_SPD_ANY_VSIF after 4 .. 1\n");
		HDMI_VSIF_ChangeState(VSIF_SPD_ANY_VSIF, 4);
		// Program to receive VSIF on every frame.
		HDMI_HAL_RegWrite(SPD_DEC,  HDMI_IF_VSIF);
		// Clear buffer interrupt as it may remain set from previous packet receiving
		HDMI_HAL_RegWriteFldAlign(RX_INTR3, intr_new_spd, HI_TRUE);
	}
}

void HDMI_VSIF_OnReceiving(HI_U32 Packet[IF_BUFFER_LENGTH])
{
    HI_U32 u32Length;
    
    u32Length = Packet[IF_LENGTH_INDEX];
    hdmi_ctx.StrInfo.bVsifReceived= HI_TRUE;

	// checksum and length verification
	if( (u32Length >= IF_MIN_VSIF_LENGTH) && (u32Length <= IF_MAX_VSIF_LENGTH) &&
		HDMI_INFO_IsCheckSumOk(Packet, u32Length + IF_HEADER_LENGTH) )
	{
		HI_BOOL packet_new = HI_FALSE;

		switch(HDMI_VSIF_GetType(&Packet[IF_HEADER_LENGTH], Packet[IF_LENGTH_INDEX]))
		{
		case NEW_3D:
		case NEW_EXTENDED_RESOLUTION:
			packet_new = true;
			// no break here
		case OLD_3D:
		case OLD_EXTENDED_RESOLUTION:
			// restart VSIF OFF timeout countdown
			hdmi_ctx.StrInfo.bFoundHdmiVsif= HI_TRUE;

			if(packet_new)
			{
				
				HDMI_VSIF_Process(&Packet[IF_HEADER_LENGTH], Packet[IF_LENGTH_INDEX]);
			}
		default :
			break;
		}
	}

	// Program to receive VSIF on every frame.
	// Set state timeout 200 ms.
	HDMI_VSIF_ChangeState(VSIF_SPD_ANY_SPD, 4);

	// Program to receive SPD on every frame.
	HDMI_HAL_RegWrite(SPD_DEC,  HDMI_IF_SPD);
	// Clear buffer interrupt as it may remain set from previous packet receiving
	HDMI_HAL_RegWriteFldAlign(RX_INTR3,intr_new_spd, HI_TRUE);
    
}

#if SUPPORT_ISRC
static void HDMI_ISRC_ChangeState(isrc_states enNewState, HI_U16 u16TimeOut)
{
    hdmi_ctx.StrInfo.u8IsrcState = enNewState;
    hdmi_ctx.StrInfo.u16IsrcTimer = u16TimeOut;
    hdmi_ctx.StrInfo.u16IsrcCounter = 0;
}

void HDMI_ISRC1_OnReceiving(HI_U32 packet[IF_BUFFER_LENGTH])
{
    // ISRC1 received.
	if(HDMI_IF_ISRC1 == packet[IF_TITLE_INDEX])
	{
		HI_U32 u32Hb1 = packet[1]; // Header HB1 byte
		HI_BOOL bPacketChanged = HI_FALSE;

		// Make sure new packet is different from previously sent.
		bPacketChanged = (0 != memcmp(packet, hdmi_ctx.StrInfo.au32Isrc1Buffer, ISRC1_BUFFER_LENGTH<<2));
		// Note: ISRC specific: if ISRC1 not changed,
		// ISRC2 can be considered the same.


		if(bPacketChanged)
		{
			// Copy received packet into the shadow buffer.
			// It will be used to compare with the newly coming ones.
			memcpy(hdmi_ctx.StrInfo.au32Isrc1Buffer, packet, ISRC1_BUFFER_LENGTH);
		}

		if(bPacketChanged && (0xC0 == (u32Hb1 & 0xC0)))
		{
			// Newly received packet differs from previously received.
			// ISRC_Count and ISRC_Valid flags are set meaning
			// that ISRC2 packet is expected.
			// Start looking for ISRC2.
			// Re-program the packet buffer for ISRC2 receiving.
			HDMI_HAL_RegWrite(MPEG_DEC, HDMI_IF_ISRC2);
            HDMI_HAL_RegWriteFldAlign(RX_INT_IF_CTRL, reg_new_mpeg_only, HI_TRUE);
			// Clear buffer interrupt as it may remain set from previous packet receiving
            HDMI_HAL_RegWriteFldAlign(RX_INTR3, intr_new_mpeg, HI_TRUE);
			// Go to Wait for ISRC2 state with 2 sec timeout.
			HDMI_ISRC_ChangeState(ISRC_ST_WAIT_ANY_ISRC2, 200/INFO_TIME_UNIT);
            //HDMIRX_DEBUG("got a ISRC1!!!! \n");
		}
		else
		{
			// ISRC2 packet is NOT expected.
			// Change interrupt to packet change mode.
			HDMI_HAL_RegWriteFldAlign(RX_INTR3, intr_new_mpeg, HI_TRUE);
			HDMI_HAL_RegWriteFldAlign(RX_INT_IF_CTRL, reg_new_mpeg_only, HI_FALSE);
			// Enable an interrupt to detect ISRC1 packet discontinuation.
			HDMI_HAL_RegWriteFldAlign(RX_INTR8_MASK, reg_intr8_mask4, HI_TRUE);
			// Wait 2 sec to see if the buffer content changes.
			HDMI_ISRC_ChangeState(ISRC_ST_WAIT_NEW_ISRC1, 200/INFO_TIME_UNIT);
		}

		if(bPacketChanged || (!hdmi_ctx.StrInfo.bIsrcRetransmitted))
		{
			if(u32Hb1 & 0x40)
			{
				// Packet has valid information;

				if(0 == (u32Hb1 & 0x80))
				{
					// No ISRC2 expected
					//SiiRxInfoPacketNtf(SII_IF_ISRC2, NULL);
				}
			}
			else
			{
				// Packet is not valid;
				// Stop transmission.
				//SiiRxInfoPacketNtf(SII_IF_ISRC1, NULL);
				//SiiRxInfoPacketNtf(SII_IF_ISRC2, NULL);
				// Note: rx_info[pipe].isrc_retransmitted has to be true
				// to avoid sending the stop functions in a loop.
			}
		}
		hdmi_ctx.StrInfo.bIsrcRetransmitted = HI_TRUE;
	}
}

void HDMI_ISRC2_OnReceiving(HI_U32 packet[IF_BUFFER_LENGTH])
{
    // ISRC2 received.
	if(HDMI_IF_ISRC2 == packet[IF_TITLE_INDEX])
	{
		// Re-program the packet buffer for ISRC1 receiving.
		HDMI_HAL_RegWrite(MPEG_DEC, HDMI_IF_ISRC1);


		// Clear buffer interrupt as it may remain set from previous packet receiving
		HDMI_HAL_RegWriteFldAlign(RX_INTR3, intr_new_mpeg, HI_TRUE);

		// Continue looking for ISRC1.
		HDMI_ISRC_ChangeState(ISRC_ST_WAIT_ANY_ISRC1, ISRC1_TIMEOUT);
        HDMIRX_DEBUG("got a ISRC2!!!! \n");
	}
}
#endif

static void HDMI_INFO_PacketProc(HI_U32 u32Addr)
{
    HI_U32 Data[IF_BUFFER_LENGTH];
    HI_U32 u32Length;
    HI_BOOL bCheckSum = HI_FALSE;
    HI_U32 u32Type;

    u32Type = HDMI_HAL_RegRead(u32Addr);
    if (u32Type == HDMI_IF_AVI) {
        // clear AVI interrupt if it was raised after clearing in the beginning RxIsr_InterruptHandler() and this moment
		HDMI_HAL_RegWriteFldAlign(RX_INTR3, intr_new_avi, HI_TRUE);

		HDMI_HAL_RegReadBlock(AVIRX_TYPE, Data, IF_MAX_AVI_LENGTH + IF_HEADER_LENGTH);
		u32Length = Data[IF_LENGTH_INDEX];
        bCheckSum = HDMI_INFO_IsCheckSumOk(Data, u32Length + IF_HEADER_LENGTH);
        //HDMIRX_DEBUG("avi length = %d bCheckSum = %d \n", u32Length, bCheckSum);
		if((u32Length >= IF_MIN_AVI_LENGTH) && (u32Length <= IF_MAX_AVI_LENGTH) && bCheckSum)
		{
			HDMI_AVI_StoreData(Data);
			HDMI_AVI_OnPacketReceiving();
			if(hdmi_ctx.u32HdmiState == HDMI_STATE_VIDEO_ON)
			{
				HDMI_VDO_SetVideoPath();
			}
            HDMI_INFO_AvMuteRequest(HI_FALSE, AV_MUTE_NO_AVI);
			hdmi_ctx.StrInfo.strReceivedPacket.AVI = HI_TRUE;
		}
		else
		{
			hdmi_ctx.StrInfo.strFailedPackets.AVI = HI_TRUE;
		}
    }
    #if SUPPORT_AUDIO
    else if (u32Type == HDMI_IF_AUDIO) {
        //HDMIRX_DEBUG("HDMI_IF_AUDIO \n");
        HDMI_HAL_RegReadBlock(AUDRX_TYPE, Data, IF_MAX_AUDIO_LENGTH + IF_HEADER_LENGTH);
		u32Length = Data[IF_LENGTH_INDEX];
		if( (u32Length >= IF_MIN_AUDIO_LENGTH) && (u32Length <= IF_MAX_AUDIO_LENGTH) &&
			HDMI_INFO_IsCheckSumOk(Data, u32Length + IF_HEADER_LENGTH) )
		{
			hdmi_ctx.StrInfo.strReceivedPacket.Audio = HI_TRUE;
			//SiiRxInfoPacketNtf(SII_IF_AUDIO, d);
			HDMI_AUD_OnAudioInfoFrame(&Data[IF_HEADER_LENGTH], u32Length);
		}
		else
		{
			hdmi_ctx.StrInfo.strFailedPackets.Audio = HI_TRUE;
		}
    }
    #endif
    else if (u32Type == HDMI_IF_SPD) {
        //HDMIRX_DEBUG("yes, get the SPD! \n");
        HDMI_HAL_RegReadBlock(SPDRX_TYPE, Data, IF_MAX_SPD_LENGTH + IF_HEADER_LENGTH);
		HDMI_SPD_OnReceiving(Data);
    }
    else if (u32Type == HDMI_IF_VSIF) {
        HDMIRX_DEBUG("yes, get the VSIF! \n");
        HDMI_HAL_RegReadBlock(SPDRX_TYPE, Data, IF_BUFFER_LENGTH);
        hdmi_ctx.StrInfo.strReceivedPacket.VSIF = HI_TRUE;
        HDMI_VSIF_OnReceiving(Data);
    }
    #if SUPPORT_ISRC
    else if (u32Type == HDMI_IF_ISRC1) {
        hdmi_ctx.StrInfo.strReceivedPacket.ISRC1 = HI_TRUE;
        HDMI_HAL_RegReadBlock(MPEGRX_TYPE, Data, IF_BUFFER_LENGTH);
        HDMI_ISRC1_OnReceiving(Data);
    }
    else if (u32Type == HDMI_IF_ISRC2) {
        hdmi_ctx.StrInfo.strReceivedPacket.ISRC2 = HI_TRUE;
        HDMI_HAL_RegReadBlock(MPEGRX_TYPE, Data, IF_BUFFER_LENGTH);
        HDMI_ISRC2_OnReceiving(Data);
    }
    #if SUPPORT_AUDIO
    else if (HDMI_IF_ACP == u32Type) {
        HDMI_HAL_RegReadBlock(u32Addr, Data, IF_BUFFER_LENGTH);
		{
			hdmi_ctx.StrInfo.strReceivedPacket.ACP = HI_TRUE;
			hdmi_ctx.StrInfo.enAcpType = (hdmi_acp_type) Data[1];
			hdmi_ctx.StrInfo.u8AcpCntdwn = (70/INFO_TIME_UNIT); // 600ms by the standard and 100ms headroom

			// Do not check ACP interrupt several video frames.
			// Otherwise if it comes every frame, TX will fail to change packet data so often.
			HDMI_ISR_AcpIntOnOff(HI_FALSE);
			hdmi_ctx.StrInfo.u8AcpIntCntdwn = (15/INFO_TIME_UNIT);

			HDMI_AUD_UpdateOnAcp(hdmi_ctx.StrInfo.enAcpType);
		}
    }
    #endif
    #endif
}

void HDMI_INFO_IntHandler(HI_U32 u32Int)
{
    //HDMIRX_DEBUG("u32Int = %x \n",u32Int);
    if (u32Int & intr_new_avi) {
        //HDMIRX_DEBUG("new avi.........\n");
        HDMI_INFO_PacketProc(AVIRX_TYPE);
    }
    if (u32Int & intr_new_aud) {
        HDMI_ISR_ReceiveAudioInfoFrameOnEveryPacketOnOff(HI_FALSE);
        HDMI_INFO_PacketProc(AUDRX_TYPE);
    }
    if (u32Int & intr_new_spd) {
        //HDMIRX_DEBUG("new spd.........\n");
		HDMI_INFO_PacketProc(SPDRX_TYPE);
	}
    if (u32Int & intr_new_mpeg) {
        //HDMIRX_DEBUG("new mpeg int \n");
        HDMI_INFO_PacketProc(MPEGRX_TYPE);
    }
}
#if SUPPORT_AUDIO
void HDMI_ACP_IntHandler(void)
{
    HDMI_INFO_PacketProc(RX_ACP_BYTE1);
}
#endif

void HDMI_INFO_ResetAudInfoFrameData(void)
{
    HDMIRX_DEBUG("HDMI_INFO_ResetAudInfoFrameData \n");
    HDMI_AUD_OnAudioInfoFrame(NULL,0);
    HDMI_ISR_ReceiveAudioInfoFrameOnEveryPacketOnOff(HI_TRUE);
}

static void HDMI_VSIF_OnPacketDiscontinuation(void)
{
    // Forget HDMI VSIF data
	hdmi_ctx.strTimingInfo.u8HdmiVic = 0;
	hdmi_ctx.strTimingInfo.bHdmiVicReceived = HI_FALSE;
	hdmi_ctx.strTimingInfo.u8Hdmi3dStructure = 0;
	hdmi_ctx.strTimingInfo.u8Hdmi3dExtData = 0;
	hdmi_ctx.strTimingInfo.bHdmi3dVsifReceived = HI_FALSE;

	// Changing from 3D/4K2K to non-3D/4K2K in most cases causes pixel clock interruption
	// that change RX state machine's state. In this case no other processing is required.
	// However, some 3D to 2D formats have compatible timings and it is possible
	// skipping such transaction. This function is called when HDMI VSIF packets
	// are no longer comming. That event may happen on 3D to 2D change.
	// The function starts format verification.
	HDMI_VDO_Verify1P4Format(HI_FALSE);
}
void HDMI_VSIF_Mloop(void)
{
    hdmi_ctx.StrInfo.u16ElapseTime[0]++ ;
    if(hdmi_ctx.StrInfo.u16ElapseTime[1] > 0) {
        hdmi_ctx.StrInfo.u16ElapseTime[1]++ ;
    }
    if(hdmi_ctx.StrInfo.u16ElapseTime[0] > hdmi_ctx.StrInfo.u16VsifTimer) {
        switch (hdmi_ctx.StrInfo.u8VsifState) {
            default:
            case VSIF_SPD_INIT:
                //HDMIRX_DEBUG("VSIF STATE is VSIF_SPD_INIT \n");
                HDMI_HAL_RegWrite(SPD_DEC, HDMI_IF_VSIF);
                HDMI_HAL_RegWriteFldAlign(RX_INTR3,intr_new_spd, HI_TRUE);
                //HDMIRX_DEBUG("vsif state will change to VSIF_SPD_ANY_VSIF after 40 \n");
                HDMI_VSIF_ChangeState(VSIF_SPD_ANY_VSIF, (2000/MLOOP_TIME_UNIT)/INFO_TIME_UNIT);
                memset(hdmi_ctx.StrInfo.au32SpdBuffer, 0, SPD_BUFFER_LENGTH);
                hdmi_ctx.StrInfo.bSpdReceived = HI_FALSE;
                hdmi_ctx.StrInfo.bVsifReceived = HI_FALSE;
                hdmi_ctx.StrInfo.bFoundHdmiVsif = HI_FALSE;
                hdmi_ctx.StrInfo.u16NoHdmiVsifTimeout = 0;
                HDMI_ISR_SpdIntOnOff(HI_TRUE);
                break;
             case VSIF_SPD_ANY_VSIF:
                //HDMIRX_DEBUG("VSIF STATE is VSIF_SPD_ANY_VSIF \n");
                // VSIF packet has not been received during during given timeout.
			    // Program to receive SPD on every frame.
                HDMI_HAL_RegWrite(SPD_DEC, HDMI_IF_SPD);
                HDMI_HAL_RegWriteFldAlign(RX_INTR3,intr_new_spd, HI_TRUE);
                HDMI_VSIF_ChangeState(VSIF_SPD_ANY_SPD, (2000/MLOOP_TIME_UNIT)/INFO_TIME_UNIT);
                //HDMIRX_DEBUG("vsif state will change to VSIF_SPD_ANY_SPD after 40 \n");
                break;
             case VSIF_SPD_ANY_SPD:
                //HDMIRX_DEBUG("VSIF STATE is VSIF_SPD_ANY_SPD \n");
                HDMI_VSIF_ChangeState(VSIF_SPD_ANY_VSIF, (200/MLOOP_TIME_UNIT)/INFO_TIME_UNIT);
                HDMI_HAL_RegWrite(SPD_DEC, HDMI_IF_VSIF);
                HDMI_HAL_RegWriteFldAlign(RX_INTR3,intr_new_spd, HI_TRUE);
                //HDMIRX_DEBUG("vsif state will change to VSIF_SPD_ANY_VSIF after 4 .. 2 \n");
                break;
             case VSIF_SPD_DELAY:
                //HDMIRX_DEBUG("VSIF STATE is VSIF_SPD_DELAY \n");
                HDMI_VSIF_ChangeState(VSIF_SPD_ANY_VSIF, (200/MLOOP_TIME_UNIT)/INFO_TIME_UNIT);
                HDMI_HAL_RegWrite(SPD_DEC, HDMI_IF_VSIF);
                HDMI_HAL_RegWriteFldAlign(RX_INTR3,intr_new_spd, HI_TRUE);
                HDMI_ISR_SpdIntOnOff(HI_TRUE);
                //HDMIRX_DEBUG("vsif state will change to VSIF_SPD_ANY_VSIF after 4 .. 3 \n");
                break;
        }
        
    }
    if (hdmi_ctx.StrInfo.bFoundHdmiVsif) {
        hdmi_ctx.StrInfo.bFoundHdmiVsif = HI_FALSE;
        // Received VSIF is recognized as HDMI VSIF.
		// Start count down to detect if HDMI VSIF stopped.
		hdmi_ctx.StrInfo.u16NoHdmiVsifTimeout = (2000/MLOOP_TIME_UNIT)/INFO_TIME_UNIT;
		// If no 3D/4K2K packet found within this time,
		// the program assumes video is non-HDMI-VSIF.
		hdmi_ctx.StrInfo.u16ElapseTime[1] = 1;  ;
    }
    else if ((hdmi_ctx.StrInfo.u16ElapseTime[1] > hdmi_ctx.StrInfo.u16NoHdmiVsifTimeout) && (hdmi_ctx.StrInfo.u16NoHdmiVsifTimeout > 0)) {
        // No HDMI VSIF packet was received during HDMI_VSIF_TIMEOUT time.

		// Clear also vsif_received flag (indicating any VSIF packet detection).
		// If there is any other VSIF packet, the flag will be set again shortly.
		hdmi_ctx.StrInfo.bVsifReceived = HI_FALSE;

		HDMI_VSIF_OnPacketDiscontinuation();
        hdmi_ctx.StrInfo.u16ElapseTime[1] = 0;
    }
}

#if SUPPORT_ISRC
static void HDMI_ISRC_StopTransmission(void)
{
    if (hdmi_ctx.StrInfo.bIsrcRetransmitted) {
        hdmi_ctx.StrInfo.bIsrcRetransmitted = HI_FALSE;
    }
}



void HDMI_ISRC_MLoop(void)
{
    hdmi_ctx.StrInfo.u16IsrcCounter++;
    if(hdmi_ctx.StrInfo.u16IsrcCounter > hdmi_ctx.StrInfo.u16IsrcTimer) {
        switch(hdmi_ctx.StrInfo.u8IsrcState)
		{
		    default:
		    case ISRC_ST_INIT:
			    // Start looking for ISRC1.
			    // Re-program the packet buffer for ISRC1 receiving.
			    HDMI_HAL_RegWrite(MPEG_DEC,  HDMI_IF_ISRC1);
			    HDMI_HAL_RegWriteFldAlign(RX_INT_IF_CTRL, reg_new_mpeg_only, HI_TRUE); // any
			    // Clear buffer interrupt as it may remain set from previous packet receivng
			    HDMI_HAL_RegWriteFldAlign(RX_INTR3, intr_new_mpeg, HI_TRUE);
                HDMI_HAL_RegWriteFldAlign(RX_INTR8_MASK, reg_intr8_mask4, HI_FALSE);
			    // Make sure nothing is re-transmitted.
			    hdmi_ctx.StrInfo.bIsrcRetransmitted= HI_FALSE;
			    HDMI_ISRC_StopTransmission();
			    // Clear ISRC1 buffer
			    // (used for checking if receiving ISRC1 is new or not).
			    memset(hdmi_ctx.StrInfo.au32Isrc1Buffer, 0, ISRC1_BUFFER_LENGTH);
			    // Go to Wait for ISRC1 state with ISRC1_TIMEOUT timeout.
			    HDMI_ISRC_ChangeState(ISRC_ST_WAIT_ANY_ISRC1, ISRC1_TIMEOUT/INFO_TIME_UNIT);
			    break;
		    case ISRC_ST_WAIT_ANY_ISRC1:
			    // No ISRC1 has been received during the timeout.
			    // Stop corresponding packets at TX if required.
			    HDMI_ISRC_StopTransmission();
			    // Continue looking for ISRC1.
			    HDMI_ISRC_ChangeState(ISRC_ST_WAIT_ANY_ISRC1, ISRC1_TIMEOUT/INFO_TIME_UNIT);
			    break;
		    case ISRC_ST_WAIT_NEW_ISRC1:
			    break;
		    case ISRC_ST_WAIT_ANY_ISRC2:
			    // No ISRC2 detected within given timeout.
			    // Return to looking for ISRC1.
			    // Re-program the packet buffer for ISRC1 receiving.
			    HDMI_HAL_RegWrite(MPEG_DEC,  HDMI_IF_ISRC1);
			    // Clear buffer interrupt as it may remain set from previous packet receivng
			    HDMI_HAL_RegWriteFldAlign(RX_INTR3, intr_new_mpeg, HI_TRUE);
			    // Go to Wait for ISRC1 state with ISRC1_TIMEOUT timeout.
			    HDMI_ISRC_ChangeState(ISRC_ST_WAIT_ANY_ISRC1, ISRC1_TIMEOUT/INFO_TIME_UNIT);
			    break;
		}
    }
}
#endif
// -----------------------------------------------

void HDMI_INFO_TimerProc(void)
{
    #if SUPPORT_AUDIO
    hdmi_ctx.StrInfo.u8AcpCnt += 1;
    if (hdmi_ctx.StrInfo.u8AcpCnt > hdmi_ctx.StrInfo.u8AcpCntdwn) {
        hdmi_ctx.StrInfo.u8AcpCnt = 0;
        hdmi_ctx.StrInfo.enAcpType = acp_GeneralAudio;
        HDMI_AUD_UpdateOnAcp(acp_GeneralAudio);
    }
    else if (hdmi_ctx.StrInfo.u8AcpCnt == hdmi_ctx.StrInfo.u8AcpIntCntdwn) {
        HDMI_ISR_AcpIntOnOff(HI_TRUE);
    }
    #endif
    #if SUPPORT_ISRC
    HDMI_ISRC_MLoop();
    #endif
    HDMI_VSIF_Mloop();
}

