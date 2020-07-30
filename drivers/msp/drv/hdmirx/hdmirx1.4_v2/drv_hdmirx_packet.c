/******************************************************************************

  Copyright (C), 2012-2050, Hisilicon Tech. Co., Ltd.

 ******************************************************************************
  File Name     : drv_hdmirx_packet.c
  Version       : Initial Draft
  Author        : Hisilicon multimedia software group
  Created       : 2014/01/16
  Description   : 
  History       :
  1.Date        : 2014/01/16
    Author      :  t00202585
    Modification: Created file
******************************************************************************/
#include <linux/sched.h> 

#include "hal_hdmirx.h"
#include "hal_hdmirx_reg.h"

#include "drv_hdmirx.h"
#include "drv_hdmirx_ctrl.h"
#include "drv_hdmirx_packet.h"
#include "drv_hdmirx_video.h"
#include "drv_hdmirx_audio.h"

#ifdef __cplusplus
 #if __cplusplus
        extern "C" {
 #endif
#endif /* __cplusplus */

static HDMIRX_PACKET_CONTEXT_S s_stHdmirxPacketCtx;
static struct timeval s_stPacketTime = {0};
#if SUPPORT_ACP
static struct timeval s_stAcpTime = {0};
#endif



static HI_VOID HDMIRX_PACKET_AvMuteReq(HI_BOOL bEn, HI_U32 u32Cause)
{
    HDMIRX_PACKET_CONTEXT_S *pstPacketCtx;
    
    pstPacketCtx = HDMIRX_PACKET_GET_CTX();
    if (u32Cause > 0) 
	{
        if (bEn == HI_TRUE) 
		{
            pstPacketCtx->u32AvMask |= u32Cause;
        }
        else 
		{
            pstPacketCtx->u32AvMask &= ~u32Cause;
        }
    }
}
/* 
-----------------------------------------------------------------------------
Function:       HDMIRX_PACKET_IsCheckSumOk
Description:    crc check result.
Parameters:     pu32Data: the array to be check.
                u32Length: the crc check length.
Returns:        true for crc check ok.
NOTE: 
-----------------------------------------------------------------------------
*/
static HI_BOOL HDMIRX_PACKET_IsCheckSumOk(HI_U32 *pu32Data, HI_U32 u32Length)
{
    HI_U8 i;
    HI_U8 u8CheckSum = 0;
    
    for (i = 0; i < u32Length; i++, pu32Data++) 
    {
        u8CheckSum += (HI_U8)((*pu32Data) & 0x000000ff);
    }
    
    return (0 == u8CheckSum);
}

/* 
-----------------------------------------------------------------------------
Function:       HDMIRX_PACKET_SetAcpIntEn
Description:    To turn on/off the int releated the acp.
Parameters:     bEn: true for enable.
Returns:        None
NOTE: 
-----------------------------------------------------------------------------
*/
#if SUPPORT_ACP
static HI_VOID HDMIRX_PACKET_SetAcpIntEn(HI_UNF_HDMIRX_PORT_E enPort,HI_BOOL bEn)
{
	HI_U32 u32Temp;

	u32Temp = HDMIRX_CTRL_GetShadowIntMask(HDMIRX_INTR6);
	HDMIRX_CTRL_SetShadowIntMask(HDMIRX_INTR6, intr_new_acp, bEn);
	if(u32Temp != HDMIRX_CTRL_GetShadowIntMask(HDMIRX_INTR6))
	{
		HDMIRX_HAL_SetInterruptEn(enPort,HDMIRX_INT_ACP, bEn);
        if(HDMIRX_CTRL_IsNeedSubPort() == HI_TRUE)
        {
            HDMIRX_HAL_SetInterruptEn(HDMIRX_CTRL_GetSubPort(),HDMIRX_INT_ACP, bEn);
        }
	}
}
#endif
static HI_VOID HDMIRX_PACKET_VSIF_DiscontinuationProc(HI_UNF_HDMIRX_PORT_E enPort)
{
    HDMIRX_PACKET_CONTEXT_S *pstPacketCtx;

    pstPacketCtx = HDMIRX_PACKET_GET_CTX();
    // Forget HDMI VSIF data
    #if SUPPORT_4K_VIC
	pstPacketCtx->stVsif.bHdmiVicReceived = HI_FALSE;
    #endif
	pstPacketCtx->stVsif.bHdmi3dVsifReceived = HI_FALSE;
    
	pstPacketCtx->stVsif.u16NoHdmiVsifTimeout = 0;
    HDMIRX_VIDEO_Clear4k3dInfo();
	// Changing from 3D/4K2K to non-3D/4K2K in most cases causes pixel clock interruption
	// that change RX state machine's state. In this case no other processing is required.
	// However, some 3D to 2D formats have compatible timings and it is possible
	// skipping such transaction. This function is called when HDMI VSIF packets
	// are no longer comming. That event may happen on 3D to 2D change.
	// The function starts format verification.
	HDMIRX_VIDEO_Verify1P4Format(enPort,HI_FALSE);
}

static HI_VOID HDMIRX_PACKET_VSIF_ChangeState(
HDMIRX_VSIF_SPD_STATE_E enNewstate, HI_U32 u32Timeout)
{
    HDMIRX_PACKET_CONTEXT_S *pstPacketCtx;
    struct timeval  *pstTime;

    pstTime = HDMIRX_PACKET_GET_TIME();
    pstPacketCtx = HDMIRX_PACKET_GET_CTX();
    pstPacketCtx->stVsif.u16VsifTimer = u32Timeout;
    pstPacketCtx->stVsif.enVsifState = enNewstate;
    
	do_gettimeofday(pstTime);

}
#if SUPPORT_4K_VIC
HI_BOOL HDMIRX_PACKET_VSIF_IsGotHdmiVic(HI_VOID)
{
    HDMIRX_PACKET_CONTEXT_S *pstPacketCtx;
    
    pstPacketCtx = HDMIRX_PACKET_GET_CTX();
    
    return (pstPacketCtx->stVsif.bHdmiVicReceived);
}
#endif
HI_BOOL HDMIRX_PACKET_VSIF_IsGot3d(HI_VOID)
{
    HDMIRX_PACKET_CONTEXT_S *pstPacketCtx;
    
    pstPacketCtx = HDMIRX_PACKET_GET_CTX();
    
    return (pstPacketCtx->stVsif.bHdmi3dVsifReceived);
}
static HI_VOID HDMIRX_PACKET_VSIF_SetIntEn(HI_UNF_HDMIRX_PORT_E enPort,HI_BOOL bEn)
{
	HI_U32 mask3;
    
	mask3 = HDMIRX_CTRL_GetShadowIntMask(HDMIRX_INTR3);
    HDMIRX_CTRL_SetShadowIntMask(HDMIRX_INTR3, intr_new_spd, bEn);
	if(mask3 != HDMIRX_CTRL_GetShadowIntMask(HDMIRX_INTR3))
	{
        HDMIRX_HAL_SetInterruptEn(enPort,HDMIRX_INT_NEW_SPD, bEn);
        if(HDMIRX_CTRL_IsNeedSubPort() == HI_TRUE)
        {
            HDMIRX_HAL_SetInterruptEn(HDMIRX_CTRL_GetSubPort(),HDMIRX_INT_NEW_SPD, bEn);
        }
	}
}

static HI_VOID HDMIRX_PACKET_VSIF_MainProc(HI_UNF_HDMIRX_PORT_E enPort)
{
	struct timeval sCurTime;
	static struct timeval sNoVsifTime = {0};
    HDMIRX_PACKET_CONTEXT_S *pstPacketCtx;
    
    pstPacketCtx = HDMIRX_PACKET_GET_CTX();
	
    do_gettimeofday(&sCurTime);
	if(pstPacketCtx->stVsif.bFoundHdmiVsif == HI_TRUE) 
	{
        pstPacketCtx->stVsif.bFoundHdmiVsif = HI_FALSE;
        // Received VSIF is recognized as HDMI VSIF. Start count down to detect if HDMI VSIF stopped.
		pstPacketCtx->stVsif.u16NoHdmiVsifTimeout = 2000;
		// If no 3D/4K2K packet found within this time,
		// the program assumes video is non-HDMI-VSIF.
		do_gettimeofday(&sNoVsifTime);
    }
    else if ((HDMIRX_TIME_DIFF_MS(sCurTime, sNoVsifTime) > 
        pstPacketCtx->stVsif.u16NoHdmiVsifTimeout) && \
        (pstPacketCtx->stVsif.u16NoHdmiVsifTimeout > 0)) 
	{
        // No HDMI VSIF packet was received during HDMI_VSIF_TIMEOUT time.

		// Clear also vsif_received flag (indicating any VSIF packet detection).
		// If there is any other VSIF packet, the flag will be set again shortly.
		pstPacketCtx->stVsif.bVsifReceived = HI_FALSE;
		
		HDMIRX_PACKET_VSIF_DiscontinuationProc(enPort);
		
    }
	if(HDMIRX_TIME_DIFF_MS(sCurTime, s_stPacketTime) < \
        pstPacketCtx->stVsif.u16VsifTimer)
	{
		return;
	}
    switch (pstPacketCtx->stVsif.enVsifState) 
	{
        default:
        case VSIF_SPD_INIT:
			// Clear buffer interrupt as it may remain set from previous packet receiving
            memset(pstPacketCtx->stSpd.au32SpdBuffer, 0, SPD_BUFFER_LENGTH);
            pstPacketCtx->stSpd.bSpdReceived = HI_FALSE;
            pstPacketCtx->stVsif.bVsifReceived = HI_FALSE;
            pstPacketCtx->stVsif.bFoundHdmiVsif = HI_FALSE;
            pstPacketCtx->stVsif.u16NoHdmiVsifTimeout = 0;
			// Program to receive VSIF on every frame.
            HDMIRX_HAL_SwitchVsifDec(enPort,HI_TRUE);
            if(HDMIRX_CTRL_IsNeedSubPort() == HI_TRUE)
            {
                HDMIRX_HAL_SwitchVsifDec(HDMIRX_CTRL_GetSubPort(),HI_TRUE);
            }
            HDMIRX_PACKET_VSIF_SetIntEn(enPort,VSIF_DEC);
			// Set state timeout 2 sec (such timeout is for first time only).
			HDMIRX_PACKET_VSIF_ChangeState(VSIF_SPD_ANY_VSIF, 2000);
			
            break;
         case VSIF_SPD_ANY_VSIF:
            // VSIF packet has not been received during during given timeout.
		    // Program to receive SPD on every frame.
            HDMIRX_HAL_SwitchVsifDec(enPort,SPD_DEC);
            if(HDMIRX_CTRL_IsNeedSubPort() == HI_TRUE)
            {
                HDMIRX_HAL_SwitchVsifDec(HDMIRX_CTRL_GetSubPort(),SPD_DEC);
            }
			// Set state timeout to 2 sec as SPD can come as rare as once per second.
            HDMIRX_PACKET_VSIF_ChangeState(VSIF_SPD_ANY_SPD, 2000);
			
            break;
         case VSIF_SPD_ANY_SPD:
            // No SPD has been received during given timeout. At least one of the searching packets has not been received.
			// Check VSIF now.
            HDMIRX_PACKET_VSIF_ChangeState(VSIF_SPD_ANY_VSIF, 200);
			
            HDMIRX_HAL_SwitchVsifDec(enPort,VSIF_DEC);
            if(HDMIRX_CTRL_IsNeedSubPort() == HI_TRUE)
            {
                HDMIRX_HAL_SwitchVsifDec(HDMIRX_CTRL_GetSubPort(),VSIF_DEC);
            }
            break;
         case VSIF_SPD_DELAY:
            // Time to check VSIF again.
            HDMIRX_PACKET_VSIF_ChangeState(VSIF_SPD_ANY_VSIF, 200);
			
			// Program to receive VSIF on every frame.
            HDMIRX_HAL_SwitchVsifDec(enPort,VSIF_DEC);
			if(HDMIRX_CTRL_IsNeedSubPort() == HI_TRUE)
            {
                HDMIRX_HAL_SwitchVsifDec(HDMIRX_CTRL_GetSubPort(),VSIF_DEC);
            }
			// Clear buffer interrupt as it may remain set from previous packet receiving
			// Enable SPD/VSIF interrupts.
            HDMIRX_PACKET_VSIF_SetIntEn(enPort,HI_TRUE);
            break;
    }  
}
/* 
-----------------------------------------------------------------------------
Function:       HDMIRX_PACKET_VSIF_GetType
Description:    To analysis the type of vsif.
Parameters:     None.
Returns:        3d/4k.
NOTE: 
-----------------------------------------------------------------------------
*/
static VSIF_CHECK_RESULT_E HDMIRX_PACKET_VSIF_GetType(HI_U32 *pPacket, 
    HI_U32 u32Length)
{
    VSIF_CHECK_RESULT_E enAnalysis = VSIF_NOT_HDMI_VSIF;
    HI_U32 u32Format;
    HDMIRX_PACKET_CONTEXT_S *pstPacketCtx;
    
    pstPacketCtx = HDMIRX_PACKET_GET_CTX();
     // Check HDMI VSIF signature.
	// HDMI IEEE Registration Identifier is 0x000C03 (least significant byte first).
	if((0x03 == pPacket[0]) && (0x0C == pPacket[1]) && (0x00 == pPacket[2]))
	{
		// HDMI VSIF signature is found. Check HDMI format.
		u32Format = (pPacket[3] >> 5);
        #if SUPPORT_4K_VIC
		switch(u32Format)
		{
		case 1:
			// HDMI VIC format (extended resolution format)
			enAnalysis = VSIF_NEW_EXTENDED_RESOLUTION;
			if(pstPacketCtx->stVsif.bHdmiVicReceived && 
                (HDMIRX_VIDEO_GetCurHdmiVic() == pPacket[4]))
			{
				// HDMI VIC has been received and the new packet caries the same HDMI VIC.
				enAnalysis = VSIF_OLD_EXTENDED_RESOLUTION;
			}
			break;
		case 2:
			// 3D format.
			enAnalysis = VSIF_NEW_3D;
			if(pstPacketCtx->stVsif.bHdmi3dVsifReceived)
			{
				enAnalysis = VSIF_OLD_3D;
				// may be modified by the next few lines. Check if new 3D structure field matches
				// previously received packet.
				if(HDMIRX_VIDEO_GetCur3dStructure()!= (pPacket[4] >> 4))
				{
					// 3D_Structure is different; the packet is new 3D.
					enAnalysis = VSIF_NEW_3D;
				}
				// Side-by-Side (Half) has at least one additional parameter.
				// Check if it matches to the previously received one.
				if((8 == HDMIRX_VIDEO_GetCur3dStructure()) && (u32Length > 4))
				{
					// 3D_Ext_Data field
					if(HDMIRX_VIDEO_GetCur3dExtData() != (pPacket[5] >> 4))
					{
						// 3D_Structure is different; the packet is new 3D.
						enAnalysis = VSIF_NEW_3D;
					}
				}
			}
			break;
		}
        #else
        if(u32Format == 2)
        {
            enAnalysis = VSIF_NEW_3D;
			if(pstPacketCtx->stVsif.bHdmi3dVsifReceived)
			{
				enAnalysis = VSIF_OLD_3D;
				// may be modified by the next few lines. Check if new 3D structure field matches
				// previously received packet.
				if(HDMIRX_VIDEO_GetCur3dStructure()!= (pPacket[4] >> 4))
				{
					// 3D_Structure is different; the packet is new 3D.
					enAnalysis = VSIF_NEW_3D;
				}
				// Side-by-Side (Half) has at least one additional parameter.
				// Check if it matches to the previously received one.
				if((8 == HDMIRX_VIDEO_GetCur3dStructure()) && (u32Length > 4))
				{
					// 3D_Ext_Data field
					if(HDMIRX_VIDEO_GetCur3dExtData() != (pPacket[5] >> 4))
					{
						// 3D_Structure is different; the packet is new 3D.
						enAnalysis = VSIF_NEW_3D;
					}
				}
			}
        }
        #endif
	}
	return enAnalysis;   
}
/* 
-----------------------------------------------------------------------------
Function:       HDMIRX_PACKET_VSIF_Process
Description:    To 3d/4k process of vsif.
Parameters:     None.
Returns:        None.
NOTE: 
-----------------------------------------------------------------------------
*/
static HI_VOID HDMIRX_PACKET_VSIF_Process(HI_UNF_HDMIRX_PORT_E enPort,HI_U32* pPacket, HI_U8 u8Length)
{
    HI_U32 u32HdmiFormat;
    HDMIRX_PACKET_CONTEXT_S *pstPacketCtx;
    
    pstPacketCtx = HDMIRX_PACKET_GET_CTX();
    u32HdmiFormat = (pPacket[3]>>5);
    switch(u32HdmiFormat) 
    {
        case 1:
            // 4k
            #if SUPPORT_4K_VIC
            HDMIRX_VIDEO_SetCurHdmiVic(pPacket[4]);
            pstPacketCtx->stVsif.bHdmiVicReceived = HI_TRUE;
            pstPacketCtx->stVsif.bHdmi3dVsifReceived = HI_FALSE;
            HDMIRX_VIDEO_SetCur3dStructure(HDMIRX_3D_TYPE_BUTT);
            HDMIRX_VIDEO_SetCur3dExtData(0);
            // HDMI VIC (4K2K) video detected. RX Video State Machine has to be informed
		    // as video re-detection may be required.
            HDMIRX_VIDEO_Verify1P4Format(enPort,HI_TRUE);
            #else
            pstPacketCtx->stVsif.bHdmi3dVsifReceived = HI_FALSE;
            HDMIRX_VIDEO_SetCur3dStructure(HDMIRX_3D_TYPE_BUTT);
            HDMIRX_VIDEO_SetCur3dExtData(0);
            #endif
            break;
         case 2:
            // 3D format
		    // Get 3D structure field.Timing from VideoModeTable[] has to be modified
		    // depending on the 3d_Structure field.Store it for further processing.
            HDMIRX_VIDEO_SetCur3dStructure(pPacket[4] >> 4);
		    // Side-by-Side (Half) has at least one additional parameter, collect it.
			if((HDMIRX_VIDEO_GetCur3dStructure() >= 8)&&(u8Length > 4))
			{
				HDMIRX_VIDEO_SetCur3dExtData(pPacket[5] >> 4);  // has 3D_Ext_Data field
			}
			else
			{
                HDMIRX_VIDEO_SetCur3dExtData(0);
			}
			
		    pstPacketCtx->stVsif.bHdmi3dVsifReceived = HI_TRUE;
            #if SUPPORT_4K_VIC
		    // Reset HDMI VIC info (HDMI 1.4 spec does not allow HDMI VIC & 3D at the same time)
            HDMIRX_VIDEO_SetCurHdmiVic(0);
		    pstPacketCtx->stVsif.bHdmiVicReceived = HI_FALSE;
            #endif
		    if(pstPacketCtx->stAvi.bAviReceived)
		    {
			    // 3D video detected.
			    // RX Video State Machine has to be informed as video re-detection may be required.
			    HDMIRX_VIDEO_Verify1P4Format(enPort,HI_TRUE);
			    
		    }
		    break;
    }
}
/* 
-----------------------------------------------------------------------------
Function:       HDMIRX_PACKET_VSIF_OnReceiving
Description:    To process of vsif.
Parameters:     None.
Returns:        None.
NOTE: 
-----------------------------------------------------------------------------
*/
static HI_VOID HDMIRX_PACKET_VSIF_OnReceiving(HI_UNF_HDMIRX_PORT_E enPort,HI_U32 *pau32Packet)
{
    HI_U32 u32Length;
    HI_BOOL bChkSum;
	VSIF_CHECK_RESULT_E enType;
	HDMIRX_PACKET_CONTEXT_S *pstPacketCtx;
    HI_BOOL packet_new = HI_FALSE;
    
    pstPacketCtx = HDMIRX_PACKET_GET_CTX();
    u32Length = pau32Packet[IF_LENGTH_INDEX];
    pstPacketCtx->stVsif.bVsifReceived= HI_TRUE;

	// checksum and length verification
	
	if( (u32Length >= IF_MIN_VSIF_LENGTH) && (u32Length <= IF_MAX_VSIF_LENGTH))
	{
        bChkSum = HDMIRX_PACKET_IsCheckSumOk(pau32Packet, u32Length + IF_HEADER_LENGTH);    
        if(bChkSum == HI_FALSE)
        {
            return;
        }
      //  packet_new = HI_FALSE;
		enType = HDMIRX_PACKET_VSIF_GetType(&pau32Packet[IF_HEADER_LENGTH], pau32Packet[IF_LENGTH_INDEX]);
		switch(enType)
		{
		case VSIF_NEW_3D:
		case VSIF_NEW_EXTENDED_RESOLUTION:
			packet_new = HI_TRUE;
			// no break here
		case VSIF_OLD_3D:
		case VSIF_OLD_EXTENDED_RESOLUTION:
			pstPacketCtx->stVsif.bFoundHdmiVsif= HI_TRUE;
			if(packet_new)
			{
                HDMIRX_PACKET_VSIF_Process(enPort,&pau32Packet[IF_HEADER_LENGTH], \
                    pau32Packet[IF_LENGTH_INDEX]);
			}
		default :
			break;
		}
	}

	// Program to receive spd on every frame. Set state timeout 200 ms.
	HDMIRX_PACKET_VSIF_ChangeState(VSIF_SPD_ANY_SPD, 200);

	// Program to receive SPD on every frame.
	HDMIRX_HAL_SwitchVsifDec(enPort,SPD_DEC);
	// Clear buffer interrupt as it may remain set from previous packet receiving
    
}
/* 
-----------------------------------------------------------------------------
Function:       HDMIRX_PACKET_SPD_OnReceiving
Description:    To process of spd.
Parameters:     None.
Returns:        None.
NOTE: 
-----------------------------------------------------------------------------
*/
static HI_VOID HDMIRX_PACKET_SPD_OnReceiving(HI_UNF_HDMIRX_PORT_E enPort,HI_U32 *pau32Packet)
{
	HI_U32 u32Length;
	HI_BOOL bChkSum;
    HDMIRX_PACKET_CONTEXT_S *pstPacketCtx;
    
    pstPacketCtx = HDMIRX_PACKET_GET_CTX();
	u32Length = pau32Packet[IF_LENGTH_INDEX];
	
	pstPacketCtx->stSpd.bSpdReceived = HI_TRUE;
	
	if((u32Length >= IF_MIN_SPD_LENGTH) && (u32Length <= IF_MAX_SPD_LENGTH))
	{
        bChkSum = HDMIRX_PACKET_IsCheckSumOk(pau32Packet, u32Length + IF_HEADER_LENGTH);
        if(bChkSum == HI_FALSE)
        {
            return;
        }
        // The packet looks valid.
		if(memcmp(pau32Packet, pstPacketCtx->stSpd.au32SpdBuffer, \
            sizeof(pstPacketCtx->stSpd.au32SpdBuffer))!= 0)
		{
			// The received packet differs from the previous one. Copy received packet into the shadow buffer.
			// It will be used to compare with the newly coming ones.
			memcpy(pstPacketCtx->stSpd.au32SpdBuffer, pau32Packet, SPD_BUFFER_LENGTH);

		}
	}
	// No SPD has been received during given timeout.
	if(/*bSpdReceived &&*/pstPacketCtx->stVsif.bVsifReceived)
	{
		// Since both HDMI VSIF and SPD are received, switching to VSIF receiving right now can
		// cause unnecessary short SPD and VSIF receiving service loop. To reduce it, go to the
		// delay state for a short time.
		HDMIRX_PACKET_VSIF_ChangeState(VSIF_SPD_DELAY, 1000);
		// Disable SPD/VSIF interrupts for a while.
		HDMIRX_PACKET_VSIF_SetIntEn(enPort,HI_FALSE);
	}
	else
	{
		// At least one of the searching packets has not been received. Check VSIF now.
		HDMIRX_PACKET_VSIF_ChangeState(VSIF_SPD_ANY_VSIF, 200);
		// Program to receive VSIF on every frame.
		HDMIRX_HAL_SwitchVsifDec(enPort,VSIF_DEC);
		// Clear buffer interrupt as it may remain set from previous packet receiving
	}
}
/* 
-----------------------------------------------------------------------------
Function:       HDMIRX_PACKET_AVI_IsGot
Description:    To check whether got avi infoframe.
Parameters:     None.
Returns:        true for got.
NOTE: 
-----------------------------------------------------------------------------
*/
HI_BOOL HDMIRX_PACKET_AVI_IsGot(HI_VOID)
{
    HDMIRX_PACKET_CONTEXT_S *pstPacketCtx;
    
    pstPacketCtx = HDMIRX_PACKET_GET_CTX();
    
    return (pstPacketCtx->stAvi.bAviReceived);
}

/* 
-----------------------------------------------------------------------------
Function:       HDMIRX_PACKET_AVI_GetReplication
Description:    To get the oversample rate in avi infoframe.
Parameters:     None.
Returns:        oversample rate.
NOTE: 
-----------------------------------------------------------------------------
*/
HDMIRX_OVERSAMPLE_E HDMIRX_PACKET_AVI_GetReplication(HI_VOID)
{
    HDMIRX_OVERSAMPLE_E enRate;
    HDMIRX_PACKET_CONTEXT_S *pstPacketCtx;
    
    pstPacketCtx = HDMIRX_PACKET_GET_CTX();
    
    if(((pstPacketCtx->stAvi.au32AviData[4+IF_HEADER_LENGTH])& 0x0f) >= \
        HDMIRX_OVERSAMPLE_BUTT)
    {
        enRate = HDMIRX_OVERSAMPLE_NONE;
    }
    else
    {
        enRate = ((pstPacketCtx->stAvi.au32AviData[4+IF_HEADER_LENGTH])&0x0f);
    }
    
    return enRate;
}
/* 
-----------------------------------------------------------------------------
Function:       HDMIRX_PACKET_AVI_IsDataValid
Description:    To check the avi version.
Parameters:     None.
Returns:        true for version 2.
NOTE: 
-----------------------------------------------------------------------------
*/
HI_BOOL HDMIRX_PACKET_AVI_IsDataValid(HI_VOID)
{
    HI_BOOL bValid = HI_FALSE;
    HDMIRX_PACKET_CONTEXT_S *pstPacketCtx;
    
    pstPacketCtx = HDMIRX_PACKET_GET_CTX();
    if (pstPacketCtx->stAvi.u8AviVersion >= AVI_VERSION) 
    {
        bValid = HI_TRUE;
    }
	
    return bValid;
}
/* 
-----------------------------------------------------------------------------
Function:       HDMIRX_PACKET_AVI_GetColorSpace
Description:    To get the color space.
Parameters:     None.
Returns:        color space: rgb/ycbcr444/ycbcr422.
NOTE: 
-----------------------------------------------------------------------------
*/
HDMIRX_COLOR_SPACE_E HDMIRX_PACKET_AVI_GetColorSpace(HI_VOID)
{
    HDMIRX_PACKET_CONTEXT_S *pstPacketCtx;
    
    pstPacketCtx = HDMIRX_PACKET_GET_CTX();
    
    if(HDMIRX_PACKET_AVI_IsDataValid() == HI_FALSE)
    {
        return HDMIRX_COLOR_SPACE_BUTT;
    }
    return (HDMIRX_COLOR_SPACE_E)((pstPacketCtx->stAvi.au32AviData[IF_HEADER_LENGTH] >> 5) & 0x03);
}

/* 
-----------------------------------------------------------------------------
Function:       HDMIRX_PACKET_AVI_GetRGBRange
Description:    To get the RGB Quantization Range.
Parameters:     None.
Returns:        RGB Quantization Range: default/Limited Range/Full Range.
NOTE: 
-----------------------------------------------------------------------------
*/
HDMIRX_RGB_RANGE_E HDMIRX_PACKET_AVI_GetRGBRange(HI_VOID)
{
    HDMIRX_PACKET_CONTEXT_S *pstPacketCtx;
    
    pstPacketCtx = HDMIRX_PACKET_GET_CTX();
    
    return (HDMIRX_RGB_RANGE_E)((pstPacketCtx->stAvi.au32AviData[IF_HEADER_LENGTH+IF_LENGTH_INDEX] >> 2) & 0x03);
}


/* 
-----------------------------------------------------------------------------
Function:       HDMIRX_PACKET_AVI_GetColorMetry
Description:    To get the color metry.
Parameters:     None.
Returns:        color metry: 601/709.
NOTE: 
-----------------------------------------------------------------------------
*/
HDMIRX_COLOR_METRY_E HDMIRX_PACKET_AVI_GetColorMetry(HI_VOID)
{
	HDMIRX_COLOR_METRY_E enMetry;
    HI_U32 u32ExtendMetry;
    HDMIRX_PACKET_CONTEXT_S *pstPacketCtx;

    pstPacketCtx = HDMIRX_PACKET_GET_CTX();
    enMetry = pstPacketCtx->stAvi.au32AviData[1+IF_HEADER_LENGTH];
    enMetry = enMetry >> 6;
    enMetry&= 0x03;
	if(HDMIRX_COLOR_METRY_Extended == enMetry)
	{
		u32ExtendMetry = pstPacketCtx->stAvi.au32AviData[2+IF_HEADER_LENGTH];
        u32ExtendMetry = (u32ExtendMetry >> 4);
        u32ExtendMetry &= 0x07;
		if(u32ExtendMetry < 2)
		{
			enMetry = HDMIRX_COLOR_METRY_xv601 + u32ExtendMetry;
		}
		else
		{
			enMetry = HDMIRX_COLOR_METRY_NoInfo;
		}
	}
    
	return enMetry;
}
/* 
-----------------------------------------------------------------------------
Function:       HDMIRX_PACKET_AVI_ResetData
Description:    To reset the avi data, and start to receive any avi.
Parameters:     None.
Returns:        None.
NOTE: 
-----------------------------------------------------------------------------
*/
static HI_VOID HDMIRX_PACKET_AVI_ResetData(HI_VOID)
{
    HDMIRX_PACKET_CONTEXT_S *pstPacketCtx;
    
    pstPacketCtx = HDMIRX_PACKET_GET_CTX();
    memset(pstPacketCtx->stAvi.au32AviData, 0, sizeof(pstPacketCtx->stAvi.au32AviData));
	pstPacketCtx->stAvi.u8AviVersion = 0;
#if SUPPORT_DOUBLE_CTRL
    HDMIRX_HAL_SetAviIntOnlyNew(HI_UNF_HDMIRX_PORT0,HI_FALSE);
#endif
	HDMIRX_HAL_SetAviIntOnlyNew(HI_UNF_HDMIRX_PORT1,HI_FALSE);
}
/* 
-----------------------------------------------------------------------------
Function:       HDMIRX_PACKET_AVI_StoreData
Description:    To save the avi data into array.
Parameters:     pu32Data: the point of array.
Returns:        None
NOTE: 
-----------------------------------------------------------------------------
*/
static HI_VOID HDMIRX_PACKET_AVI_StoreData(HI_U32 *pu32Data)
{
    HDMIRX_PACKET_CONTEXT_S *pstPacketCtx;
    
    pstPacketCtx = HDMIRX_PACKET_GET_CTX();
    memcpy(pstPacketCtx->stAvi.au32AviData, pu32Data, (AVI_LENGTH+IF_HEADER_LENGTH)<<2);
   
	pstPacketCtx->stAvi.u8AviVersion= pu32Data[1];
	if(pstPacketCtx->stAvi.u8AviVersion < 2)
	{
		pstPacketCtx->stAvi.au32AviData[3+IF_HEADER_LENGTH] = 0; // VIC=0
		pstPacketCtx->stAvi.au32AviData[4+IF_HEADER_LENGTH] = 0; // Repetition
	}
}
/* 
-----------------------------------------------------------------------------
Function:       HDMIRX_PACKET_AVI_OnReceiving
Description:    The isr of avi int
Parameters:     None
Returns:        None
NOTE: 
-----------------------------------------------------------------------------
*/
static HI_VOID HDMIRX_PACKET_AVI_OnReceiving(HI_UNF_HDMIRX_PORT_E enPort)
{
    HDMIRX_PACKET_CONTEXT_S *pstPacketCtx;
    
    pstPacketCtx = HDMIRX_PACKET_GET_CTX();
    pstPacketCtx->stAvi.bAviReceived = HI_TRUE;
    HDMIRX_VIDEO_Set861Vic(pstPacketCtx->stAvi.au32AviData[3+IF_HEADER_LENGTH] & 0x7f);
    if(pstPacketCtx->stVsif.bHdmi3dVsifReceived) 
	{
        HDMIRX_VIDEO_Verify1P4Format(enPort,HI_TRUE);
    }
	HDMIRX_HAL_SetAviIntOnlyNew(enPort,HI_TRUE);
}

/* 
-----------------------------------------------------------------------------
    Function:    HDMIRX_PACKET_AVI_SetNoAviIntEn
    Description: to turn on/off the int releated the no avi.
    Parameters: bOnOff: 1, on; 0, off.
    Returns:      none
    NOTE: 
-----------------------------------------------------------------------------
*/
HI_VOID HDMIRX_PACKET_AVI_SetNoAviIntEn(HI_UNF_HDMIRX_PORT_E enPort,HI_BOOL bEn)
{
    HI_U32 mask4;
    
    mask4 = HDMIRX_CTRL_GetShadowIntMask(HDMIRX_INTR4);

    HDMIRX_CTRL_SetShadowIntMask(HDMIRX_INTR4, intr_no_avi, bEn);
	if(bEn)
	{
        HDMIRX_HAL_ClearInterrupt(enPort,HDMIRX_INT_NO_AVI);// clear No AVI interrupt if it was raised
	}
	
	if (mask4 != HDMIRX_CTRL_GetShadowIntMask(HDMIRX_INTR4)) 
    {
		HDMIRX_HAL_SetInterruptEn(enPort,HDMIRX_INT_NO_AVI, bEn);
	}

	// If NO AVI interrupt is ON, look for NEW AVI only. If NO AVI interrupt is OFF, look for ANY AVI.
	HDMIRX_HAL_SetAviIntOnlyNew(enPort,bEn);
}


HI_VOID HDMIRX_PACKET_AVI_NoAviHandler(HI_VOID)
{
    HDMIRX_PACKET_AVI_ResetData();

    if (HDMIRX_CTRL_IsVideoOnState()) 
    {
        HDMIRX_CTRL_ModeChgAdd(HDMIRX_MODECHG_TYPE_NOAVI);
        HDMIRX_CTRL_ModeChange();
    }
	
    HDMIRX_PACKET_AvMuteReq(HI_TRUE, AV_MUTE_NO_AVI);

}
/*
------------------------------------------------------------------------------
 Function:    	HDMIRX_PACKET_ResetAudInfoFrameData
 Description: 	Clear audio infoframe and enable the int only if new infoframe. 
 Parameters:  None.
 Returns:     	None.
 Note:		1/ called if enter audio_off state
------------------------------------------------------------------------------
*/
#if SUPPORT_AUDIO_INFOFRAME
static HI_VOID HDMIRX_PACKET_AIF_OnReceiving(HI_UNF_HDMIRX_PORT_E enPort,HI_U32 *pu32data, HI_U32 length)
{
    HDMIRX_PACKET_CONTEXT_S *pstPacketCtx;
    
    pstPacketCtx = HDMIRX_PACKET_GET_CTX();
    if(pu32data && (length>=5))
	{
		pstPacketCtx->bAudioInfoFrameReceived = HI_TRUE;
		HDMIRX_AUDIO_SetCa(pu32data[3]);
//        HDMIRX_AUDIO_SetChannelNum(pu32data[3] & 0x07);
	}
	else
	{
		pstPacketCtx->bAudioInfoFrameReceived = HI_FALSE;
	}

	if(pstPacketCtx->bAudioInfoFrameReceived == HI_TRUE)
	{
		HDMIRX_AUDIO_Update(enPort);
	}
}

//HI_VOID HDMIRX_PACKET_AIF_SetGotFlag(HI_BOOL bGot)
//{
 //   HDMIRX_PACKET_CONTEXT_S *pstPacketCtx;
    
  //  pstPacketCtx = HDMIRX_PACKET_GET_CTX();
  //  pstPacketCtx->bAudioInfoFrameReceived = bGot;
//}
HI_BOOL HDMIRX_PACKET_AIF_IsGot(HI_VOID)
{
    HDMIRX_PACKET_CONTEXT_S *pstPacketCtx;
    
    pstPacketCtx = HDMIRX_PACKET_GET_CTX();

    return pstPacketCtx->bAudioInfoFrameReceived;
}
HI_VOID HDMIRX_PACKET_ResetAudInfoFrameData(HI_UNF_HDMIRX_PORT_E enPort)
{
   
    HDMIRX_PACKET_AIF_OnReceiving(enPort,NULL,0);
    HDMIRX_HAL_AudioInfoFrameIntCfg(enPort,HI_TRUE);
	
}


#endif

static HI_VOID HDMIRX_PACKET_RstInfoFrameData(HI_VOID)
{
    HDMIRX_PACKET_CONTEXT_S *pstPacketCtx;
    pstPacketCtx = HDMIRX_PACKET_GET_CTX();
    pstPacketCtx->stAvi.bAviReceived = HI_FALSE;
	pstPacketCtx->stVsif.bHdmi3dVsifReceived= HI_FALSE;
    #if SUPPORT_4K_VIC
	pstPacketCtx->stVsif.bHdmiVicReceived= HI_FALSE;
    #endif
}


HI_VOID HDMIRX_PACKET_ResetData(HI_VOID)
{
    HDMIRX_PACKET_CONTEXT_S *pstPacketCtx;
    
    pstPacketCtx = HDMIRX_PACKET_GET_CTX();
    memset(pstPacketCtx, 0, sizeof(HDMIRX_PACKET_CONTEXT_S));
    pstPacketCtx->stAvi.au32AviData[IF_HEADER_LENGTH] = (HDMIRX_COLOR_SPACE_BUTT<< 5);
    pstPacketCtx->stAvi.au32AviData[4+IF_HEADER_LENGTH] =  HDMIRX_OVERSAMPLE_BUTT;
	#if SUPPORT_ACP
    pstPacketCtx->enAcpType = ACP_GENERAL_AUDIO; // default acp is general
#if SUPPORT_DOUBLE_CTRL
    HDMIRX_AUDIO_UpdateOnAcp(HI_UNF_HDMIRX_PORT0,pstPacketCtx->enAcpType);
    HDMIRX_PACKET_SetAcpIntEn(HI_UNF_HDMIRX_PORT0,HI_TRUE);
#endif
    // set the spdif out on the acp
    HDMIRX_AUDIO_UpdateOnAcp(HI_UNF_HDMIRX_PORT1,pstPacketCtx->enAcpType);
    // turn on the acp int.
    HDMIRX_PACKET_SetAcpIntEn(HI_UNF_HDMIRX_PORT1,HI_TRUE);
	#endif
    // enable the int of v res change
    // enable the aec of v res change.
    // disable the aec of v res change.
#if SUPPORT_DOUBLE_CTRL
    HDMIRX_VIDEO_SetResChgEventsEn(HI_UNF_HDMIRX_PORT0,HI_TRUE);
#endif
    HDMIRX_VIDEO_SetResChgEventsEn(HI_UNF_HDMIRX_PORT1,HI_TRUE);
    // sw initial
    HDMIRX_PACKET_AvMuteReq(HI_FALSE, AV_MUTE_INP_AV_MUTE_CAME | AV_MUTE_NO_AVI);
    HDMIRX_PACKET_VSIF_ChangeState(VSIF_SPD_INIT, 1);
    HDMIRX_PACKET_RstInfoFrameData();
	HDMIRX_PACKET_AVI_ResetData();
}

HI_VOID HDMIRX_PACKET_MainThread(HI_UNF_HDMIRX_PORT_E enPort)
{
	#if SUPPORT_ACP
	struct timeval sCurTime;
    HDMIRX_PACKET_CONTEXT_S *pstPacketCtx;
    
    pstPacketCtx = HDMIRX_PACKET_GET_CTX();
	#endif
    
	if (HDMIRX_CTRL_IsNeed2beDone() == HI_FALSE)
	{
		return;
	}
	#if SUPPORT_ACP
	do_gettimeofday(&sCurTime);
   	if((HDMIRX_TIME_DIFF_MS(sCurTime, s_stAcpTime) > 700) \
        && (pstPacketCtx->enAcpType != ACP_GENERAL_AUDIO))
	{
        pstPacketCtx->enAcpType = ACP_GENERAL_AUDIO;
        HDMIRX_AUDIO_UpdateOnAcp(enPort,ACP_GENERAL_AUDIO);
    }
    if((HDMIRX_TIME_DIFF_MS(sCurTime, s_stAcpTime) > 150)) 
	{
        HDMIRX_PACKET_SetAcpIntEn(enPort,HI_TRUE);
    }
	#endif
    HDMIRX_PACKET_VSIF_MainProc(enPort);
}
#if 0//SUPPORT_CP_MUTE
static HI_VOID HDMIRX_PACKET_SetCpIntEn(HI_UNF_HDMIRX_PORT_E enPort,HI_BOOL bEn)
{

	HI_U32 mask3;
    
    mask3 = HDMIRX_CTRL_GetShadowIntMask(HDMIRX_INTR3);
    HDMIRX_CTRL_SetShadowIntMask(HDMIRX_INTR3, intr_cp_set_mute, bEn);
	
	if (mask3 != HDMIRX_CTRL_GetShadowIntMask(HDMIRX_INTR3)) 
    {
		HDMIRX_HAL_SetInterruptEn(enPort,HDMIRX_INT_CP, bEn);
	}
}

HI_VOID HDMIRX_PACKET_CpHandler(HI_UNF_HDMIRX_PORT_E enPort)
{
	HI_BOOL bMute;
	HDMIRX_PACKET_CONTEXT_S *pstPacketCtx;

    pstPacketCtx = HDMIRX_PACKET_GET_CTX();
	HDMIRX_PACKET_AvMuteReq(HI_FALSE, 0);
	bMute = HDMIRX_HAL_GetMuteSta(enPort);
	if(pstPacketCtx->u32AvMask & AV_MUTE_INP_AV_MUTE_CAME) 
	{
        // TX is muted by AV Mute from RX, see whether it need to be UNmuted.
		if(bMute == HI_FALSE)
		{
			HDMIRX_PACKET_AvMuteReq(HI_FALSE, AV_MUTE_INP_AV_MUTE_CAME);
			HDMIRX_PACKET_SetCpIntEn(enPort,HI_TRUE); // prepare for fast muting when required
		}
    }
    else 
	{
        if(bMute == HI_TRUE) 
		{
            HDMIRX_PACKET_AvMuteReq(HI_TRUE, AV_MUTE_INP_AV_MUTE_CAME);
            HDMIRX_PACKET_SetCpIntEn(enPort,HI_FALSE); // stop CP Mute serving in RxIsr module
        }
    }
}
#endif



static HI_VOID HDMIRX_PACKET_Proc(HI_UNF_HDMIRX_PORT_E enPort,HI_U32 u32Addr)
{
    HI_U32 au32Data[PACKET_BUFFER_LENGTH];
    HI_U32 u32Length;
    HDMIRX_OVERSAMPLE_E enPReplication;
    HDMIRX_COLOR_SPACE_E enPInColorSpace;
    HDMIRX_COLOR_METRY_E enPInColorMetry;
    HI_BOOL bCheckSum = HI_FALSE;
    HI_U32 u32Type;
    HDMIRX_PACKET_CONTEXT_S *pstPacketCtx;

    pstPacketCtx = HDMIRX_PACKET_GET_CTX();
    u32Type = HDMIRX_HAL_GetPacketType(enPort,u32Addr);
    if(u32Type == HDMIRX_AVI) 
    {
        // clear AVI interrupt if it was raised after clearing in the beginning RxIsr_InterruptHandler() and this moment
		HDMIRX_HAL_ClearInterrupt(enPort,HDMIRX_INT_AVI);

        HDMIRX_HAL_GetPacketContent(enPort,u32Addr, au32Data, IF_MAX_AVI_LENGTH + IF_HEADER_LENGTH);
		u32Length = au32Data[IF_LENGTH_INDEX];
        
		if((u32Length >= IF_MIN_AVI_LENGTH) && (u32Length <= IF_MAX_AVI_LENGTH))
		{
            bCheckSum = HDMIRX_PACKET_IsCheckSumOk(au32Data, u32Length + IF_HEADER_LENGTH);
            if(bCheckSum == HI_FALSE)
            {
                return;
            }
            enPReplication = (au32Data[4+IF_HEADER_LENGTH] & 0x0f);
            enPInColorSpace = ((au32Data[IF_HEADER_LENGTH] >> 5) & 0x03);
            enPInColorMetry = ((au32Data[1+IF_HEADER_LENGTH]>>6) & 0x03);
           // printk("###tmp:%d,old:%d\n",enPInColorSpace,HDMIRX_PACKET_AVI_GetColorSpace());
            if((enPReplication != HDMIRX_PACKET_AVI_GetReplication())|| \
            (enPInColorSpace != HDMIRX_PACKET_AVI_GetColorSpace()) || \
            (enPInColorMetry !=HDMIRX_PACKET_AVI_GetColorMetry()))
            {
                printk("Packet Change##%d = %d ,%d =%d ,%d=%d\n",enPReplication,HDMIRX_PACKET_AVI_GetReplication(),\
                   enPInColorSpace, HDMIRX_PACKET_AVI_GetColorSpace(),
                   enPInColorMetry,HDMIRX_PACKET_AVI_GetColorMetry());
                //HDMIRX_VIDEO_SetVideoPath();
			    HDMIRX_CTRL_ChangeState(HDMIRX_STATE_WAIT);
            //  HDMIRX_HAL_ClearAvMute(HI_FALSE);
                HDMIRX_HAL_SetMuteEn(enPort,HDMIRX_MUTE_VDO, HI_TRUE);
                if(HDMIRX_CTRL_IsNeedSubPort() == HI_TRUE)
                {
                    HDMIRX_HAL_SetMuteEn(HDMIRX_CTRL_GetSubPort(),HDMIRX_MUTE_VDO, HI_TRUE);
                }
                HDMIRX_CTRL_ModeChgAdd(HDMIRX_MODECHG_TYPE_AVICHG);
		        HDMIRX_CTRL_ModeChange();
            }
		    
            //HDMIRX_VIDEO_SetVideoPath(enPort);
           
            HDMIRX_PACKET_AVI_StoreData(au32Data);
			HDMIRX_PACKET_AVI_OnReceiving(enPort);
            enPReplication = HDMIRX_PACKET_AVI_GetReplication();
            enPInColorSpace = HDMIRX_PACKET_AVI_GetColorSpace();
            enPInColorMetry = HDMIRX_PACKET_AVI_GetColorMetry(); 
            
            HDMIRX_PACKET_AvMuteReq(HI_FALSE, AV_MUTE_NO_AVI);
		}
		return;
    }
	#if SUPPORT_AUDIO_INFOFRAME
	if (u32Type == HDMIRX_AUDIO) 
	{
        HDMIRX_HAL_GetPacketContent(enPort,u32Addr, au32Data, \
            IF_MAX_AUDIO_LENGTH + IF_HEADER_LENGTH);
		u32Length = au32Data[IF_LENGTH_INDEX];
		if( (u32Length >= IF_MIN_AUDIO_LENGTH) && (u32Length <= IF_MAX_AUDIO_LENGTH))
		{
            bCheckSum = HDMIRX_PACKET_IsCheckSumOk(au32Data, u32Length + IF_HEADER_LENGTH);
            if(bCheckSum == HI_FALSE)
            {
                return;
            }
            HDMIRX_PACKET_AIF_OnReceiving(enPort,&au32Data[IF_HEADER_LENGTH], u32Length);
		}
		return;
    }
	#endif
    if(u32Type == HDMIRX_SPD)
	{
        HDMIRX_HAL_GetPacketContent(enPort,u32Addr, au32Data, IF_MAX_SPD_LENGTH + IF_HEADER_LENGTH);
		HDMIRX_PACKET_SPD_OnReceiving(enPort,au32Data);
		return;
    }
    if (u32Type == HDMIRX_VSIF)
	{
        HDMIRX_HAL_GetPacketContent(enPort,u32Addr, au32Data, IF_BUFFER_LENGTH);
        HDMIRX_PACKET_VSIF_OnReceiving(enPort,au32Data);
		return;
    }
	#if SUPPORT_ACP
    if(HDMIRX_ACP == u32Type) 
    {
        HDMIRX_HAL_GetPacketContent(enPort,u32Addr, au32Data, IF_BUFFER_LENGTH);
		pstPacketCtx->enAcpType = (HDMIRX_ACP_TYPE_E)au32Data[1];
		do_gettimeofday(&s_stAcpTime);

		// Do not check ACP interrupt several video frames.
		// Otherwise if it comes every frame, TX will fail to change packet data so often.
		HDMIRX_PACKET_SetAcpIntEn(enPort,HI_FALSE);

		HDMIRX_AUDIO_UpdateOnAcp(enPort,pstPacketCtx->enAcpType);
		return;

    }
	#endif
}

HI_VOID HDMIRX_PACKET_InterruptHandler(HI_UNF_HDMIRX_PORT_E enPort,HI_U32 u32Int)
{
	if (u32Int & intr_new_avi) 
	{
        HDMIRX_PACKET_Proc(enPort,RX_AVIRX_TYPE);
    }
	#if SUPPORT_AUDIO_INFOFRAME
    if (u32Int & intr_new_aud) 
	{
        HDMIRX_HAL_AudioInfoFrameIntCfg(enPort,HI_FALSE);
        HDMIRX_PACKET_Proc(enPort,RX_AUDRX_TYPE);
    }
	#endif
    if (u32Int & intr_new_spd) 
    {
		HDMIRX_PACKET_Proc(enPort,RX_SPDRX_TYPE);
	}
    if (u32Int & intr_new_mpeg) 
    {
        HDMIRX_PACKET_Proc(enPort,RX_MPEGRX_TYPE);
    }
}
#if SUPPORT_ACP
HI_VOID HDMIRX_PACKET_AcpIntHandler(HI_UNF_HDMIRX_PORT_E enPort)
{
    HDMIRX_PACKET_Proc(enPort,RX_ACP_BYTE1);
}
#endif
HI_VOID HDMIRX_PACKET_Initial(HI_VOID)
{
	HDMIRX_PACKET_ResetData();
    HDMIRX_PACKET_AvMuteReq(HI_FALSE, AV_MUTE_INP_AV_MUTE_CAME | AV_MUTE_NO_AVI);
}

#ifdef __cplusplus
 #if __cplusplus
}
 #endif
#endif /* __cplusplus */

