/******************************************************************************

  Copyright (C), 2012-2050, Hisilicon Tech. Co., Ltd.

 ******************************************************************************
  File Name     : tvd_hal.c
  Version       : Initial Draft
  Author        : Hisilicon multimedia software group
  Created       : 2013/11/05
  Description   : 
  History       :
  1.Date        : 2014/01/16
    Author      : t00202585
    Modification: Created file
******************************************************************************/
#include <asm/io.h>         // ioremap_nocache
#include <linux/kernel.h>
#include <linux/delay.h>
//#include <linux/sched.h> 

#include "hal_hdmirx.h"
#include "hal_hdmirx_reg.h"
#include "drv_hdmirx.h"
#include "hi_unf_hdmirx.h"
#include "hi_reg_common.h"
#include "hi_drv_module.h"
#include "drv_gpio_ext.h"
#if !(defined(CHIP_TYPE_hi3796cv100)||defined(CHIP_TYPE_hi3796cv100_a)|| defined(CHIP_TYPE_hi3798cv100)\
    || defined(CHIP_TYPE_hi3798cv100_a))
#include "hi_board.h"
#endif


#ifdef __cplusplus
 #if __cplusplus
extern "C" {
 #endif
#endif /* End of #ifdef __cplusplus */

static HI_U32 s_pu32HdmirxRegBase;
#if SUPPORT_DOUBLE_CTRL
static HI_U32 s_pu32HdmirxRegBase0;
#endif

static const HI_U32 AecDefalut[3] = {0xC1, 0x07, 0x01};
static HI_U32 RegBase[4];




/*------------------------------------------------------------------------------
 Function:    	GetRightHigh
 Description: 	Get the the bit map of first one from the right position.
 Parameters:  	u32Mask: bit field mask
 Returns:     	It returns the bit map of the rightmost set bit
------------------------------------------------------------------------------*/

static HI_U32 GetRightHigh(HI_U32 u32Mask)
{
     HI_U32 u32Index;
     
     for(u32Index=0; u32Index<32; u32Index++) 
     {
        if((u32Mask & 0x01) == 0x01) 
        {
            break;
        }
        else 
        {
            u32Mask >>= 1;
        }
     }
     
     return u32Index;
     
}

/*------------------------------------------------------------------------------
// Function:    	HDMIRX_HAL_RegRead
// Description: 	Read reg
// Parameters:  	The offset addr of reg
// Returns:     	It returns the value of desired reg
//------------------------------------------------------------------------------*/
static HI_U32 HDMIRX_HAL_RegRead(HI_UNF_HDMIRX_PORT_E enPort,HI_U32 u32Addr)
{
    HI_U32 u32Temp;
    u32Temp = (*((volatile unsigned int *)(RegBase[enPort] + u32Addr)));

    return u32Temp;
}

/*------------------------------------------------------------------------------
// Function:    	HDMIRX_HAL_RegReadFldAlign
// Description: 	read the field of reg.
// Parameters:  	u32Addr: the offset addr of reg.
//              		u32Mask: the disired field of reg.
// Returns:    	It returns the value of desired reg by special bit mask.
//------------------------------------------------------------------------------*/
static HI_U32 HDMIRX_HAL_RegReadFldAlign(HI_UNF_HDMIRX_PORT_E enPort,HI_U32 u32Addr, HI_U32 u32Mask)
{
    HI_U32 u32Temp;
    HI_U32 u32Index;

    if (u32Mask == 0) 
    {
        //HDMIRX_TRACE(HI_DBG_ERR, "the mask of reg read error!\n");
        
        return HI_FAILURE;
    }
    
    u32Temp = HDMIRX_HAL_RegRead(enPort,u32Addr);
    u32Index = GetRightHigh(u32Mask);
    return ((u32Temp&u32Mask) >> u32Index);   
}

/*
------------------------------------------------------------------------------
 Function:    	HDMIRX_HAL_RegReadBlock
 Description: 	read the some couple of reg.
 Parameters:  	u32Addr: the start reg.
              	pDst:    the dest.
              	u32Num:  the number of reg.
 Returns:     	None.
------------------------------------------------------------------------------
*/
static HI_VOID HDMIRX_HAL_RegReadBlock(HI_UNF_HDMIRX_PORT_E enPort,HI_U32 u32Addr, HI_U32 *pDst, HI_U32 u32Num)
{
    while(u32Num > 0) 
    {
        *pDst = HDMIRX_HAL_RegRead(enPort,u32Addr);
        pDst++;
        u32Addr += 4;
        u32Num--;
    }
}

/*
------------------------------------------------------------------------------
 Function:    	HDMIRX_HAL_RegWrite
 Description: 	Write reg
 Parameters:  	u32Addr:    the offset addr of reg
            		u32Value:   the target value
 Returns:     	None
------------------------------------------------------------------------------
*/
static HI_VOID HDMIRX_HAL_RegWrite(HI_UNF_HDMIRX_PORT_E enPort,HI_U32 u32Addr, HI_U32 u32Value)
{
    (*((volatile unsigned int *)(RegBase[enPort] + u32Addr)) = (u32Value & 0xff));
    
    //printk("Address 0x%x, Value 0x%x\n",(s_pu32HdmirxRegBase + u32Addr), u32Value & 0xff);
}

/*
------------------------------------------------------------------------------
 Function:    	HDMI_HAL_RegWriteBlock
 Description: 	Write the some couple of reg.
 Parameters:  	u32Addr: the start reg.
            	pSrc:    the source.
            	u32Num:  the number of reg.
 Returns:     	None.
------------------------------------------------------------------------------
*/
static HI_VOID HDMIRX_HAL_RegWriteBlock(HI_UNF_HDMIRX_PORT_E enPort,HI_U32 u32Addr, HI_U32 *pSrc, HI_U32 u32Num)
{
    while(u32Num > 0) 
    {
        HDMIRX_HAL_RegWrite(enPort,u32Addr,*pSrc);
        pSrc++;
        u32Addr += 4;
        u32Num -= 1;
    }
}

/*
------------------------------------------------------------------------------
 Function:    	HDMI_HAL_RegWriteFldAlign
 Description: 	Write the desired field of reg.
 Parameters: 	u32Addr:    the desired reg.
	          u32Mask:    the desired field.
              	u32Value:   the desired value
 Returns:     	None.
------------------------------------------------------------------------------
*/
static HI_VOID HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT_E enPort,HI_U32 u32Addr, HI_U32 u32Mask, 
    HI_U32 u32Value)
{
    HI_U32 u32Temp;
    HI_U32 u32Index;
   
    u32Temp = HDMIRX_HAL_RegRead(enPort,u32Addr);
    u32Index = GetRightHigh(u32Mask);
    u32Value <<= u32Index;
    u32Temp &= ~u32Mask;
    u32Temp |= u32Value;
    HDMIRX_HAL_RegWrite(enPort,u32Addr, u32Temp);
	
}

/*
------------------------------------------------------------------------------
 Function:   	HDMI_HAL_RegSetBits
 Description: 	Set/clear the desired field of reg.
 Parameters:   u32Addr:    the desired reg.
              	u32Mask:    the desired field.
              	u32Value:   true/false
 Returns:     	None.
------------------------------------------------------------------------------
*/
static HI_VOID HDMIRX_HAL_RegSetBits(HI_UNF_HDMIRX_PORT_E enPort,HI_U32 u32Addr, HI_U32 u32Mask, HI_BOOL bValue)
{
    HI_U32 u32Temp;
    
    u32Temp = HDMIRX_HAL_RegRead(enPort,u32Addr);
    if(bValue == HI_TRUE) 
    {
        u32Temp |= (HI_U32)u32Mask;
    }
    else if(bValue == HI_FALSE) 
    {
        u32Temp &= ~(HI_U32)u32Mask;
    }
    HDMIRX_HAL_RegWrite(enPort,u32Addr, u32Temp);
}
//*****************************************************************************

HI_U32 HDMIRX_HAL_ReadFldAlign(HI_UNF_HDMIRX_PORT_E enPort,HI_U32 u32Addr, HI_U32 u32Mask)
{
    return HDMIRX_HAL_RegReadFldAlign(enPort,u32Addr,u32Mask);
}

HI_VOID HDMIRX_HAL_WriteFldAlign(HI_UNF_HDMIRX_PORT_E enPort,HI_U32 u32Addr, HI_U32 u32Mask, 
    HI_U32 u32Value)
{
    HDMIRX_HAL_RegWriteFldAlign(enPort,u32Addr, u32Mask,u32Value);
}

HI_VOID HDMIRX_HAL_WriteBlock(HI_UNF_HDMIRX_PORT_E enPort,HI_U32 u32Addr, HI_U32 *pSrc, HI_U32 u32Num)
{
    HDMIRX_HAL_RegWriteBlock(enPort,u32Addr,pSrc,u32Num);
}
HI_VOID HDMIRX_HAL_ReadBlock(HI_UNF_HDMIRX_PORT_E enPort,HI_U32 u32Addr, HI_U32 *pDst, HI_U32 u32Num)
{
    HDMIRX_HAL_RegReadBlock(enPort,u32Addr,pDst,u32Num);
}
    
/*
------------------------------------------------------------------------------
 Function:   	HDMIRX_HAL_GetInterrupt
 Description: 	Get the int status.
 Parameters:  None
 Returns:     	True for interrupt on.
------------------------------------------------------------------------------
*/
HI_BOOL HDMIRX_HAL_IsInterrupt(HI_UNF_HDMIRX_PORT_E enPort)
{
	HI_BOOL bInt;

	bInt = (HI_BOOL)HDMIRX_HAL_RegReadFldAlign(enPort,RX_INTR_STATE, reg_intr);

	return bInt;
}
/*
------------------------------------------------------------------------------
 Function:   	HDMIRX_HAL_IsHdcpCrcDone
 Description: 	Get the flag of hdcp crc check done.
 Parameters:  u32Port: the port index
 Returns:     	True for done.
------------------------------------------------------------------------------
*/
#if 0
static HI_BOOL HDMIRX_HAL_IsHdcpCrcDone(HI_U32 u32PortIdx)
{
	HI_BOOL bDone;
	HI_U32 u32RegOffset;

	u32RegOffset = P0_RX_EPST+ (u32PortIdx<<3);
		
	bDone = (HI_BOOL)HDMIRX_HAL_RegReadFldAlign(u32RegOffset, p0_reg_cmd_done_clr);

	return bDone;
}
#endif
/*
------------------------------------------------------------------------------
 Function:      HDMIRX_HAL_GetBksv
 Description:   Get the bksv.
 Parameters:    u32KsvIdx: the ksv index
 Returns:       ksv.
------------------------------------------------------------------------------
*/
#if 0

static HI_U32 HDMIRX_HAL_GetBksv(HI_U32 u32KsvIdx)
{
	return HDMIRX_HAL_RegReadFldAlign(RX_SHD_BKSV_0+(u32KsvIdx<<2), otp_bksv0);
}
#endif
HI_VOID HDMIRX_HAL_SetInterruptEn(HI_UNF_HDMIRX_PORT_E enPort,HDMIRX_INTERRUPT_IDX enIdx, HI_BOOL bEn)
{
    switch(enIdx)
    {
        case HDMIRX_INT_ACP:
            HDMIRX_HAL_RegWriteFldAlign(enPort,RX_INTR6_MASK, intr_new_acp, bEn);
            break;
        case HDMIRX_INT_VRES_CHG:
            HDMIRX_HAL_RegWriteFldAlign(enPort,RX_INTR5_MASK, reg_vres_chg, bEn);
            break;
        case HDMIRX_INT_NEW_SPD:
            HDMIRX_HAL_RegWriteFldAlign(enPort,RX_INTR3_MASK, intr_new_spd, bEn);
            break;
        case HDMIRX_INT_CP:
            HDMIRX_HAL_RegWriteFldAlign(enPort,RX_INTR3_MASK, intr_cp_set_mute, bEn);
            break;
        case HDMIRX_INT_NO_AVI:
            HDMIRX_HAL_RegWriteFldAlign(enPort,RX_INTR4_MASK, intr_no_avi, bEn);
            break;
        case HDMIRX_INT_AUDIO_MUTE:
            HDMIRX_HAL_RegWriteFldAlign(enPort,RX_INTR5_MASK, intr_audio_muted, bEn);
            break;
        default:
            break;
    }
}
/*
------------------------------------------------------------------------------
 Function:      HDMIRX_HAL_GetPacketType
 Description:   Get the head of packet.
 Parameters:    u32Addr: the reg of head
 Returns:       head.
------------------------------------------------------------------------------
*/
HI_U32 HDMIRX_HAL_GetPacketType(HI_UNF_HDMIRX_PORT_E enPort,HI_U32 u32Addr)
{
    return HDMIRX_HAL_RegRead(enPort,u32Addr);
}
/*
------------------------------------------------------------------------------
 Function:      HDMIRX_HAL_Getvidpath
 Description:   Get the Video path
 Parameters:    u32Addr: the reg of head
 Returns:       head.
------------------------------------------------------------------------------
*/
HI_U32 HDMIRX_HAL_Getvidpath(HI_UNF_HDMIRX_PORT_E enPort)
{
    return HDMIRX_HAL_RegReadFldAlign(enPort,RX_TEST_STAT, reg_byp_vid_path);
}
/*
------------------------------------------------------------------------------
 Function:      HDMIRX_HAL_Setvidpath
 Description:   Set the Video path
 Parameters:    u32Addr: the reg of head
 Returns:       head.
------------------------------------------------------------------------------
*/
HI_VOID HDMIRX_HAL_Setvidpath(HI_UNF_HDMIRX_PORT_E enPort,HI_U32 bEn)
{
    HDMIRX_HAL_RegWriteFldAlign(enPort,RX_TEST_STAT, reg_byp_vid_path,bEn);
}

/*
------------------------------------------------------------------------------
 Function:      HDMIRX_HAL_GetCoreiso
 Description:   Get the Core iso enable
 Parameters:    u32Addr: the reg of head
 Returns:       head.
------------------------------------------------------------------------------
*/
HI_U32 HDMIRX_HAL_GetCoreiso(HI_UNF_HDMIRX_PORT_E enPort)
{
    return HDMIRX_HAL_RegReadFldAlign(enPort,RX_PWD_CTRL, reg_core_iso_en);
}
/*
------------------------------------------------------------------------------
 Function:      HDMIRX_HAL_SetCoreiso
 Description:   Set the Core iso enable
 Parameters:    u32Addr: the reg of head
 Returns:       head.
------------------------------------------------------------------------------
*/
HI_VOID HDMIRX_HAL_SetCoreiso(HI_UNF_HDMIRX_PORT_E enPort,HI_U32 bEn)
{
    HDMIRX_HAL_RegWriteFldAlign(enPort,RX_PWD_CTRL, reg_core_iso_en,bEn);
}

/*
------------------------------------------------------------------------------
Function:       HDMIRX_HAL_GetPacketContent
Description:    copy the body of packet.
Parameters:     u32Addr: the start reg of body
                au32Data: the dest
                u32Length: copy length.
Returns:        None.
------------------------------------------------------------------------------
*/
HI_VOID HDMIRX_HAL_GetPacketContent(HI_UNF_HDMIRX_PORT_E enPort,HI_U32 u32Addr, 
    HI_U32 *au32Data, HI_U32 u32Length)
{
    HDMIRX_HAL_RegReadBlock(enPort,u32Addr, au32Data, u32Length);
}
/* 
-----------------------------------------------------------------------------
Function:       HDMIRX_HAL_SetAviIntOnlyNew
Description:    to set the avi int by new avi only or any avi.
Parameters:     bNew: 1, only new; 0, any.
Returns:        None
NOTE: 	  
-----------------------------------------------------------------------------
*/
HI_VOID HDMIRX_HAL_SetAviIntOnlyNew(HI_UNF_HDMIRX_PORT_E enPort,HI_BOOL bNew)
{
	HDMIRX_HAL_RegWriteFldAlign(enPort,RX_INT_IF_CTRL, reg_new_avi_only, !bNew);
}

/*
------------------------------------------------------------------------------
 Function:      HDMIRX_HAL_ClearInterrupt
 Description:   Clear the special interrupt.
 Parameters:    enIdx: the interrupt index
 Returns:       None.
------------------------------------------------------------------------------
*/
HI_VOID HDMIRX_HAL_ClearInterrupt(HI_UNF_HDMIRX_PORT_E enPort,HDMIRX_INTERRUPT_IDX enIdx)
{
	switch(enIdx)
	{
		case HDMIRX_INT_CTS:
			HDMIRX_HAL_RegWriteFldAlign(enPort,RX_INTR2, intr_got_cts, 1);
			break;
			
		case HDMIRX_INT_NEW_AUD_PACKET:
			HDMIRX_HAL_RegWriteFldAlign(enPort,RX_INTR2, intr_new_aud_pkt, 1);
			break;

		case HDMIRX_INT_NEW_AUD:
			HDMIRX_HAL_RegWriteFldAlign(enPort,RX_INTR3, intr_new_aud, 1);
			break;

		case HDMIRX_INT_VRES_CHG:
			HDMIRX_HAL_RegWriteFldAlign(enPort,RX_INTR5, reg_vres_chg, 1);
			break;
			
		case HDMIRX_INT_AUD_MUTE:
			HDMIRX_HAL_RegWriteFldAlign(enPort,RX_INTR5, intr_audio_muted, 1);
			break;

		case HDMIRX_INT_HW_CTS_CHG:
			HDMIRX_HAL_RegWriteFldAlign(enPort,RX_INTR1, intr_hw_cts_changed, 1);
			break;

		case HDMIRX_INT_CTS_DROP_ERR:
			HDMIRX_HAL_RegWriteFldAlign(enPort,RX_INTR4, intr_cts_dropped_err, 1);
			break;

		case HDMIRX_INT_CTS_REUSE_ERR:
			HDMIRX_HAL_RegWriteFldAlign(enPort,RX_INTR4, intr_cts_reused_err, 1);
			break;

		case HDMIRX_INT_NEW_SPD:
			HDMIRX_HAL_RegWriteFldAlign(enPort,RX_INTR3,intr_new_spd, 1);
			break;

		case HDMIRX_INT_NEW_MPEG:
			HDMIRX_HAL_RegWriteFldAlign(enPort,RX_INTR3,intr_new_mpeg, 1);
			break;
	    case HDMIRX_INT_AVI:
            HDMIRX_HAL_RegWriteFldAlign(enPort,RX_INTR3, intr_new_avi, 1);
            break;
        case HDMIRX_INT_AUDIO_FIFO:
            HDMIRX_HAL_RegWriteFldAlign(enPort,RX_INTR4, intr_overun, 1);
            HDMIRX_HAL_RegWriteFldAlign(enPort,RX_INTR4, intr_underun, 1);
            break;
        case HDMIRX_INT_SCDT:
            HDMIRX_HAL_RegWriteFldAlign(enPort,RX_INTR2_AON, intr_scdt, HI_TRUE);
            HDMIRX_HAL_RegSetBits(enPort,RX_INTR5, reg_vres_chg|reg_hres_chg, HI_TRUE);
            break;
        case HDMIRX_INT_CP:
            HDMIRX_HAL_RegWriteFldAlign(enPort,RX_INTR3, intr_cp_set_mute, 1);
            break;
        case HDMIRX_INT_NO_AVI:
            HDMIRX_HAL_RegWriteFldAlign(enPort,RX_INTR4, intr_no_avi, 1);
            break;
        case HDMIRX_INT_FIFO_OF:
            HDMIRX_HAL_RegWriteFldAlign(enPort,RX_INTR4, intr_overun, HI_TRUE);
            break;
        case HDMIRX_INT_FIFO_UF:
            HDMIRX_HAL_RegWriteFldAlign(enPort,RX_INTR4, intr_underun, HI_TRUE);
            break;
		default:
			break;
	}
}
/*
------------------------------------------------------------------------------
 Function:      HDMIRX_HAL_SwitchVsifDec
 Description:   Switch the dec between VSFI and SPD.
 Parameters:    bVsif: True for Vsif, false for spd.
 Returns:       None.
------------------------------------------------------------------------------
*/
HI_VOID HDMIRX_HAL_SwitchVsifDec(HI_UNF_HDMIRX_PORT_E enPort,HI_BOOL bVsif)
{
	if (HI_TRUE == bVsif)
	{
		HDMIRX_HAL_RegWrite(enPort,RX_SPD_DEC, HDMIRX_VSIF);
	}
	else
	{
		HDMIRX_HAL_RegWrite(enPort,RX_SPD_DEC, HDMIRX_SPD);
	}
	HDMIRX_HAL_ClearInterrupt(enPort,HDMIRX_INT_NEW_SPD);
}
#if SUPPORT_AUDIO_INFOFRAME
/*
------------------------------------------------------------------------------
 Function:      HDMIRX_HAL_AudioInfoFrameIntCfg
 Description:   Switch the int between any and new.
 Parameters:    bVsif: True for any, false for new.
 Returns:       None.
------------------------------------------------------------------------------
*/
HI_VOID HDMIRX_HAL_AudioInfoFrameIntCfg(HI_UNF_HDMIRX_PORT_E enPort,HI_BOOL bAny)
{
    HDMIRX_HAL_RegWriteFldAlign(enPort,RX_INT_IF_CTRL, reg_new_aud_only,(HI_U32)bAny);

    HDMIRX_HAL_ClearInterrupt(enPort,HDMIRX_INT_NEW_AUD);
}
#endif

/*
------------------------------------------------------------------------------
 Function:   	HDMIRX_HAL_InterruptRegInit
 Description: 	Init the reg releated interrupt.
 Parameters:  pau32IntmaskTable: the interrupt mask table.
 Returns:     	None.
------------------------------------------------------------------------------
*/
HI_VOID HDMIRX_HAL_InterruptRegInit(HI_UNF_HDMIRX_PORT_E enPort,HI_U32* pau32IntmaskTable)
{
	HDMIRX_HAL_RegWriteBlock(enPort,RX_INTR1_MASK, pau32IntmaskTable, 8);
    HDMIRX_HAL_RegWrite(enPort,RX_INTR8_MASK_AON, pau32IntmaskTable[HDMIRX_INTR8_AON]);
    HDMIRX_HAL_RegWriteBlock(enPort,RX_INTR2_MASK_AON, &(pau32IntmaskTable[HDMIRX_INTR2_AON]), 2);
    
	// receive every packets (this register will be changed later under some conditions)
    HDMIRX_HAL_RegWrite(enPort,RX_INT_IF_CTRL, reg_new_mpeg_only|reg_new_spd_only|reg_new_avi_only);

	HDMIRX_HAL_RegWriteFldAlign(enPort,RX_INT_IF_CTRL, reg_new_acp_only, 1);

    HDMIRX_HAL_RegWrite(enPort,IF_CTRL2, reg_gcp_clr_en);

    HDMIRX_HAL_RegWriteFldAlign(enPort,RX_INTR7_MASK_AON, cec_interrupt, 1);
}

/*
------------------------------------------------------------------------------
Function:   	 HDMIRX_HAL_EnableLoadHdcpKey
Description:    enable/disable load hdcp.
Parameters:     bEn: true for enable.
Returns:        None.
------------------------------------------------------------------------------
*/
#if 1
HI_VOID HDMIRX_HAL_LoadHdcpKey(HI_UNF_HDMIRX_PORT_E enPort,HI_BOOL bEn)
{
	if(bEn == HI_TRUE)
	{
		HDMIRX_HAL_RegWriteFldAlign(enPort,P0_RX_EPST, reg_ld_ksv, 1);
	}
	else
	{
		HDMIRX_HAL_RegWriteFldAlign(enPort,P0_RX_EPST, reg_ld_ksv, 0);
	}
}
HI_VOID HDMIRX_HAL_HdcpCrcCheck(HI_UNF_HDMIRX_PORT_E enPort,HI_U32 u32Port)
{
	HI_U32 u32RegOffset1, u32RegOffset2;
	HI_U32 U32TimeOut = 4;
	HI_BOOL bEpst;
	
	u32RegOffset1 = P0_RX_EPST+((u32Port)<<3);
	u32RegOffset2 = P0_RX_EPCM+((u32Port)<<3);
	


	HDMIRX_HAL_RegWrite(enPort,u32RegOffset1, 0);
	
	bEpst = HDMIRX_HAL_RegReadFldAlign(enPort,u32RegOffset1, p0_reg_cmd_done_clr);
	


	while((bEpst != HI_TRUE) && (U32TimeOut != 0))
	{
		
		bEpst = HDMIRX_HAL_RegReadFldAlign(enPort,u32RegOffset1, p0_reg_cmd_done_clr);
		msleep(10);
		U32TimeOut--;
	}


	

	// check crc
	HDMIRX_HAL_RegWrite(enPort,u32RegOffset1, 0);
	HDMIRX_HAL_RegWriteFldAlign(enPort,u32RegOffset2, p0_reg_epcm, 4);
	//time_out = 4;
	U32TimeOut = 4;
	bEpst = HDMIRX_HAL_RegReadFldAlign(enPort,u32RegOffset1, p0_reg_cmd_done_clr);

	while((bEpst != HI_TRUE)&&(U32TimeOut != 0))
	{
		bEpst = HDMIRX_HAL_RegReadFldAlign(enPort,u32RegOffset1, p0_reg_cmd_done_clr);
		msleep(10);
		U32TimeOut--;
	}
	bEpst = HDMIRX_HAL_RegReadFldAlign(enPort,u32RegOffset1, p0_reg_bist_err_clr);
	if(bEpst == HI_TRUE)
	{
		printk("hdcp crc check is error!\n");
	}
	else
	{
		printk("bksv0 = 0x%x \n", HDMIRX_HAL_RegReadFldAlign(enPort,RX_SHD_BKSV_0, otp_bksv0));
		printk("bksv1 = 0x%x \n", HDMIRX_HAL_RegReadFldAlign(enPort,RX_SHD_BKSV_1, otp_bksv0));
		printk("bksv2 = 0x%x \n", HDMIRX_HAL_RegReadFldAlign(enPort,RX_SHD_BKSV_2, otp_bksv0));
		printk("bksv3 = 0x%x \n", HDMIRX_HAL_RegReadFldAlign(enPort,RX_SHD_BKSV_3, otp_bksv0));
		printk("bksv4 = 0x%x \n", HDMIRX_HAL_RegReadFldAlign(enPort,RX_SHD_BKSV_4, otp_bksv0));
	}
	
}

#endif
/*
------------------------------------------------------------------------------
Function:       HDMIRX_HAL_EdidInit
Description:    inital edid setting
Parameters:     pau32EdidTable: edid table.
Returns:        None.
------------------------------------------------------------------------------
*/
HI_VOID HDMIRX_HAL_EdidInit(HI_U32* pau32EdidTable,HI_U32* pau32Addr)
{
	HI_U16 u16Index;
    HI_U8 u8PAOffset = 0;
	HI_U8 u8CheckSum;
	HI_U8 u8Temp;
    HI_U32 u32AddrTmp;
		
    for (u16Index=0; u16Index<=255; u16Index++) 
	{
#if SUPPORT_DOUBLE_CTRL
        HDMIRX_HAL_RegWrite(HI_UNF_HDMIRX_PORT0,EDID_START+(u16Index<<2), pau32EdidTable[u16Index]);
#endif
        HDMIRX_HAL_RegWrite(HI_UNF_HDMIRX_PORT1,EDID_START+(u16Index<<2), pau32EdidTable[u16Index]);
        if(u16Index>128)
		{
        	if ((pau32EdidTable[u16Index] == 0x3) && (pau32EdidTable[u16Index+1] == 0xc) && \
        	 	(pau32EdidTable[u16Index+2] == 0x0))
        	{
            	u8PAOffset = u16Index+3;
        	}
		}
    }
    if(u8PAOffset > 255)
    {
        return;
    }
#if SUPPORT_DOUBLE_CTRL    
	HDMIRX_HAL_RegWrite(HI_UNF_HDMIRX_PORT0,CEC_PA_ADDR, u8PAOffset);
#endif
    HDMIRX_HAL_RegWrite(HI_UNF_HDMIRX_PORT1,CEC_PA_ADDR, u8PAOffset);
    //-------------------------------------------------------
    u8CheckSum = (HI_U8)((HI_U16)(pau32EdidTable[255]+pau32EdidTable[u8PAOffset])%256);
    // p0 setting -->
    u32AddrTmp = pau32Addr[0];
    HDMIRX_HAL_RegWrite(HI_UNF_HDMIRX_PORT0,P0_CEC_PAD_L, u32AddrTmp);
	HDMIRX_HAL_RegWrite(HI_UNF_HDMIRX_PORT0,P0_CEC_PAD_H, 0x00);
    if(u8CheckSum >= u32AddrTmp)
	{
		u8Temp = u8CheckSum - u32AddrTmp;
	}
	else 
	{
		u8Temp = u8CheckSum + (0x100 - u32AddrTmp);
	}
    HDMIRX_HAL_RegWrite(HI_UNF_HDMIRX_PORT0,P0_CHECKSUM, u8Temp);
    
#if !SUPPORT_PORT0_ONLY
    // p1 setting -->
    u32AddrTmp = pau32Addr[1];
    HDMIRX_HAL_RegWrite(HI_UNF_HDMIRX_PORT1,P1_CEC_PAD_L, u32AddrTmp);
	HDMIRX_HAL_RegWrite(HI_UNF_HDMIRX_PORT1,P1_CEC_PAD_H, 0x00);
    if(u8CheckSum >= u32AddrTmp)
	{
		u8Temp = u8CheckSum - u32AddrTmp;
	}
	else 
	{
		u8Temp = u8CheckSum + (0x100 - u32AddrTmp);
	}
    HDMIRX_HAL_RegWrite(HI_UNF_HDMIRX_PORT1,P1_CHECKSUM, u8Temp);
    // p2 setting -->
    u32AddrTmp = pau32Addr[2];
    HDMIRX_HAL_RegWrite(HI_UNF_HDMIRX_PORT2,P2_CEC_PAD_L, u32AddrTmp);
	HDMIRX_HAL_RegWrite(HI_UNF_HDMIRX_PORT2,P2_CEC_PAD_H, 0x00);
    if(u8CheckSum >= u32AddrTmp)
	{
		u8Temp = u8CheckSum - u32AddrTmp;
	}
	else 
	{
		u8Temp = u8CheckSum + (0x100 - u32AddrTmp);
	}
    HDMIRX_HAL_RegWrite(HI_UNF_HDMIRX_PORT2,P2_CHECKSUM, u8Temp);
    // p3 setting -->
    u32AddrTmp = pau32Addr[3];
    HDMIRX_HAL_RegWrite(HI_UNF_HDMIRX_PORT3,P3_CEC_PAD_L, u32AddrTmp);
	HDMIRX_HAL_RegWrite(HI_UNF_HDMIRX_PORT3,P3_CEC_PAD_H, 0x00);
    if(u8CheckSum >= u32AddrTmp)
	{
		u8Temp = u8CheckSum - u32AddrTmp;
	}
	else 
	{
		u8Temp = u8CheckSum + (0x100 - u32AddrTmp);
	}
    HDMIRX_HAL_RegWrite(HI_UNF_HDMIRX_PORT3,P3_CHECKSUM, u8Temp);
#endif
   
}
/*
------------------------------------------------------------------------------
 Function:      HDMIRX_SYS_SetHpdPullUpEn
 Description:   Enable the hpd pull up.
 Parameters:    enPort: port index.
                bEn: true for enable.
 Returns:     	 None.
------------------------------------------------------------------------------
*/
HI_VOID HDMIRX_HAL_SetHpdPullUpEn(HI_UNF_HDMIRX_PORT_E enPort, HI_BOOL bEn)
{
	HI_U32 u32Temp;
	HI_U32 u32Value;
	
	u32Temp = HDMIRX_HAL_RegReadFldAlign(enPort,HPD_PE_CTRL, reg_hpd_pe_ctrl);
    /*
    if (enPort == HI_UNF_HDMIRX_PORT_ALL)
	{
		u32Value = 0x0f;
	}
	else 
	{
		u32Value = (1<<enPort);
	}*/
	u32Value = (1<<enPort);
	if(bEn == HI_TRUE)
	{
		u32Temp |= u32Value;
	}
	else
	{
		u32Temp &= ~u32Value;
	}
	//HDMIRX_HAL_RegWriteFldAlign(HPD_PU_CTRL, reg_hpd_pu_ctrl, u32Temp);
	HDMIRX_HAL_RegWriteFldAlign(enPort,HPD_PE_CTRL, reg_hpd_pe_ctrl, u32Temp);	
}
HI_VOID HDMIRX_HAL_SetHpdManual(HI_UNF_HDMIRX_PORT_E enPort, HI_BOOL bEn)
{
    HI_U32 u32Temp;
    
    u32Temp = HDMIRX_HAL_RegReadFldAlign(enPort,HPD_OVRT_CTRL, reg_hpd_ovrt_ctrl);
    /*
    if (enPort == HI_UNF_HDMIRX_PORT_ALL)
	{
        if(bEn)
        {
            u32Temp = 0x0f;
        }
        else
        {
            u32Temp = 0;
        }
	}
	else 
	{
        if(bEn)
        {
            u32Temp |= (1<<enPort);
        }
        else
        {
            u32Temp &= ~(1<<enPort);
        }
	}
	*/
	if(bEn)
    {
        u32Temp |= (1<<enPort);
    }
    else
    {
        u32Temp &= ~(1<<enPort);
    }
    if(bEn == HI_FALSE)
    {
        HDMIRX_HAL_RegWriteFldAlign(enPort,HPD_OEN_CTRL, reg_hpd_oen_ctrl, u32Temp);
    }
	HDMIRX_HAL_RegWriteFldAlign(enPort,HPD_OVRT_CTRL, reg_hpd_ovrt_ctrl, u32Temp);
}
/*
------------------------------------------------------------------------------
Function:       HDMIRX_HAL_SetHpdLevel
Description: 	 Set assigned port hpd level
Parameters:     enPort: port index.
                bHigh: true for high.
Returns:        None.
------------------------------------------------------------------------------
*/

 
HI_VOID HDMIRX_HAL_SetHpdValue(HI_UNF_HDMIRX_PORT_E enPort, HI_BOOL bValue)
{
    HI_U32 u32Temp;
	HI_U32 u32Value;
    u32Value = (1<<enPort);
    u32Temp = HDMIRX_HAL_RegReadFldAlign(enPort,HPD_C_CTRL, reg_hpd_c_ctrl);
	if (bValue == HI_TRUE) 
	{
		u32Temp |= u32Value;
	}
	else 
	{
		u32Temp &= ~u32Value;
		
	}
	HDMIRX_HAL_RegWriteFldAlign(enPort,HPD_C_CTRL, reg_hpd_c_ctrl, u32Temp);
}

HI_VOID HDMIRX_HAL_HpdOenEn(HI_UNF_HDMIRX_PORT_E enPort, HI_BOOL bValue)
{
    HI_U32 u32Temp;
    HI_U32 u32Value;
    u32Value = (1<<enPort);
    u32Temp = HDMIRX_HAL_RegReadFldAlign(enPort,HPD_OEN_CTRL, reg_hpd_oen_ctrl);
    if (bValue == HI_TRUE) 
	{
		u32Temp |= u32Value;
	}
	else 
	{
		u32Temp &= ~u32Value;		
	}
    HDMIRX_HAL_RegWriteFldAlign(enPort,HPD_OEN_CTRL, reg_hpd_oen_ctrl, u32Temp);
}




HI_VOID HDMIRX_HAL_SetHpdLevel(HI_UNF_HDMIRX_PORT_E enPort, HI_BOOL bHigh)
{
    HI_U32 u32Temp;
	HI_U32 u32Value;
    printk("++++port %d ,Value %d \n",enPort , bHigh);
#ifdef HI_BOARD_HDMIRX_HPD_INVERT
    if(HI_BOARD_HDMIRX_HPD_INVERT == HI_TRUE)
#else
    if(1)
#endif
    {

	//----------- set the manual control --------------------------------------
	u32Temp = HDMIRX_HAL_RegReadFldAlign(enPort,HPD_OVRT_CTRL, reg_hpd_ovrt_ctrl);
    /*
	if (enPort == HI_UNF_HDMIRX_PORT_ALL)
	{
		u32Value = 0x0f;
	}
	else 
	{
		u32Value = (1<<enPort);
	}
	*/
	u32Value = (1<<enPort);
	u32Temp |= u32Value;
	HDMIRX_HAL_RegWriteFldAlign(enPort,HPD_OVRT_CTRL, reg_hpd_ovrt_ctrl, u32Temp);
	//------------------- set the high or low -----------------------------------
	u32Temp = HDMIRX_HAL_RegReadFldAlign(enPort,HPD_C_CTRL, reg_hpd_c_ctrl);
	if (bHigh == HI_TRUE) 
	{
		u32Temp |= u32Value;
	}
	else 
	{
		u32Temp &= ~u32Value;
		
	}
	HDMIRX_HAL_RegWriteFldAlign(enPort,HPD_C_CTRL, reg_hpd_c_ctrl, u32Temp);
	//-------------- enable output ---------------------------------------------
	u32Temp = HDMIRX_HAL_RegReadFldAlign(enPort,HPD_OEN_CTRL, reg_hpd_oen_ctrl);
	u32Temp &= ~u32Value;
	HDMIRX_HAL_RegWriteFldAlign(enPort,HPD_OEN_CTRL, reg_hpd_oen_ctrl, u32Temp);
    }
    else
    {   
    if(bHigh == HI_FALSE)
    {
        
        //----------- set the manual control --------------------------------------
        u32Temp = HDMIRX_HAL_RegReadFldAlign(enPort,HPD_OVRT_CTRL, reg_hpd_ovrt_ctrl);
        /*
        if (enPort == HI_UNF_HDMIRX_PORT_ALL)
        {
        	u32Value = 0x0f;
        }
        else 
        {
        	u32Value = (1<<enPort);
        }
        */
        u32Value = (1<<enPort);
        u32Temp |= u32Value;
        HDMIRX_HAL_RegWriteFldAlign(enPort,HPD_OVRT_CTRL, reg_hpd_ovrt_ctrl, u32Temp);
        //------------------- set the high or low -----------------------------------
        u32Temp = HDMIRX_HAL_RegReadFldAlign(enPort,HPD_C_CTRL, reg_hpd_c_ctrl);
        {
        	u32Temp &= ~u32Value;		
        }
        HDMIRX_HAL_RegWriteFldAlign(enPort,HPD_C_CTRL, reg_hpd_c_ctrl, u32Temp);
        //-------------- enable output ---------------------------------------------
        u32Temp = HDMIRX_HAL_RegReadFldAlign(enPort,HPD_OEN_CTRL, reg_hpd_oen_ctrl);
        u32Temp &= ~u32Value;
        HDMIRX_HAL_RegWriteFldAlign(enPort,HPD_OEN_CTRL, reg_hpd_oen_ctrl, u32Temp);
    }
    else
    {
        //----------- set the manual control --------------------------------------
        u32Temp = HDMIRX_HAL_RegReadFldAlign(enPort,HPD_OVRT_CTRL, reg_hpd_ovrt_ctrl);
        /*
        if (enPort == HI_UNF_HDMIRX_PORT_ALL)
        {
        	u32Value = 0x0f;
        }
        else 
        {
        	u32Value = (1<<enPort);
        }
        */
        u32Value = (1<<enPort);
        u32Temp |= u32Value;
        HDMIRX_HAL_RegWriteFldAlign(enPort,HPD_OVRT_CTRL, reg_hpd_ovrt_ctrl, u32Temp);
        //-------------- enable output ---------------------------------------------
    	u32Temp = HDMIRX_HAL_RegReadFldAlign(enPort,HPD_OEN_CTRL, reg_hpd_oen_ctrl);
    	u32Temp |= u32Value;
    	HDMIRX_HAL_RegWriteFldAlign(enPort,HPD_OEN_CTRL, reg_hpd_oen_ctrl, u32Temp);
    }
    }
   
}
/* 
------------------------------------------------------------------------------
Function:       HDMIRX_HAL_GetHdcpDone
Description: 	 To get the status of hdcp authentication.
Parameters:     enIdx: port index
Returns:        True:  hdcp ok.
			 False: hdcp fail
Note:           1. called if mode change in current port.
			 2. called every loop in non-current port.
			 3. switch port.
-----------------------------------------------------------------------------
*/
HI_BOOL HDMIRX_HAL_GetHdcpDone(HI_UNF_HDMIRX_PORT_E enIdx)
{
	HI_BOOL bDecrypt;
	HI_BOOL bAuth;
	
	bAuth =(HI_BOOL)HDMIRX_HAL_RegReadFldAlign(enIdx,PAUTH_STAT1, ro_p0_hdcp_authenticated<<(enIdx-HI_UNF_HDMIRX_PORT0));
	bDecrypt = (HI_BOOL)HDMIRX_HAL_RegReadFldAlign(enIdx,PAUTH_STAT1, ro_p0_hdcp_decrypting_on<<(enIdx-HI_UNF_HDMIRX_PORT0));

	if(bDecrypt && bAuth)
	{
		return HI_TRUE;
	}
	
	return HI_FALSE;
}
/* 
------------------------------------------------------------------------------
Function:      HDMIRX_HAL_GetPwr5vStatus
Description: 	To get the pwr5v status of input port.
Parameters:    enIdx: port index
Returns:       True: pwr5v exist.
			False: pwr5v not exist.
Note:		1. if switch port, be called.
			2. debug usage.
-----------------------------------------------------------------------------
*/
HI_BOOL HDMIRX_HAL_GetPwr5vStatus(HI_UNF_HDMIRX_PORT_E enIdx)
{
	HI_U32 u32Temp;

	u32Temp = HDMIRX_HAL_RegReadFldAlign(enIdx,HDMI_TX_STATUS, tctl_hdmi_tx_connected);
	if (u32Temp & (1<<(enIdx - HI_UNF_HDMIRX_PORT0)))
	{
		return HI_TRUE;
	}
	
	return HI_FALSE;
}

/* 
------------------------------------------------------------------------------
Function:       HDMIRX_HAL_HdcpPrepare
Description:    To set the HDCP module capability.
                and turn off the int releated HDCP
Parameters:     enPort: port index
Returns:        None
Note:           Just called in .
-----------------------------------------------------------------------------
*/
#if 0
static HI_VOID HDMIRX_HAL_HdcpPrepare(HI_UNF_HDMIRX_PORT_E enPort)
{

	switch(enPort)
	{
       case HI_UNF_HDMIRX_PORT0:
            HDMIRX_HAL_RegWrite (RX_HDCP_FAST_CAP, p0_reg_hdmi_capable);
            break;
       case HI_UNF_HDMIRX_PORT1:
            HDMIRX_HAL_RegWrite (RX_HDCP_FAST_CAP, p1_reg_hdmi_capable);
            break;
       case HI_UNF_HDMIRX_PORT2:
            HDMIRX_HAL_RegWrite (RX_HDCP_FAST_CAP, p2_reg_hdmi_capable);
            break;
       case HI_UNF_HDMIRX_PORT3:
            HDMIRX_HAL_RegWrite (RX_HDCP_FAST_CAP, p3_reg_hdmi_capable);
            break;
       default:
            break;
	}
}
#endif
/* 
------------------------------------------------------------------------------
Function:       HDMIRX_HAL_GetCkdt
Description:    To check ckdt present or not
Parameters:     None.
Returns:        True:   ckdt.
                False:  None.
Note:           Just called in HDMIRX_STATE_VIDEO_OFF.
-----------------------------------------------------------------------------
*/
HI_BOOL HDMIRX_HAL_GetCkdt(HI_UNF_HDMIRX_PORT_E enPort)
{
    HI_BOOL bCkdt;
	
    bCkdt = HDMIRX_HAL_RegReadFldAlign(enPort,RX_STATE_AON, ckdt);
    return bCkdt;
}

HI_U32 HDMIRX_HAL_GetEQtable(HI_UNF_HDMIRX_PORT_E enPort,HI_U32 u32cnt)
{   
    return HDMIRX_HAL_RegRead(enPort, Alice0_eq_data0 + 4*u32cnt);
}

HI_VOID HDMIRX_HAL_SetEQtable(HI_UNF_HDMIRX_PORT_E enPort,HI_U32 u32cnt,HI_U32 u32Value)
{
    HDMIRX_HAL_RegWrite(enPort, Alice0_eq_data0 + 4*u32cnt, u32Value);
}

/* 
------------------------------------------------------------------------------
Function:     	HDMIRX_HAL_GetScdt
Description:  	To check scdt present or not
Parameters:  	None.
Returns:      	True:   scdt.
     		False:  None.
Note:          
-----------------------------------------------------------------------------
*/
HI_BOOL HDMIRX_HAL_GetScdt(HI_UNF_HDMIRX_PORT_E enPort)
{
    HI_BOOL bScdt;
	
    bScdt = HDMIRX_HAL_RegReadFldAlign(enPort,RX_STATE_AON, scdt);
    
    return bScdt;
}
/* 
------------------------------------------------------------------------------
Function:       HDMIRX_HAL_SetAutoCfgEn
Description:    To turn on/off the auto configuare, video, audio, aac out
Parameters:     eType: video, audio, audio out
                bEn: True for enable.
Returns:        None.
Note:           Just called once if system power on.
-----------------------------------------------------------------------------
*/
static HI_VOID HDMIRX_HAL_SetAutoCfgEn(HI_UNF_HDMIRX_PORT_E enPort,HDMIRX_AUTO_CFG_IDX eType, HI_BOOL bEn)
{
    switch(eType) 
    {
        case HDMIRX_AUTO_CFG_VDO:
            HDMIRX_HAL_RegWriteFldAlign(enPort,RX_VID_CTRL2, reg_avc_en, (HI_U32)bEn);
            break;
        case HDMIRX_AUTO_CFG_AUD:
            #if SUPPORT_AEC
            HDMIRX_HAL_RegWriteFldAlign(enPort,AEC0_CTRL, reg_aac_en, (HI_U32)bEn);
            #endif
            break;
        case HDMIRX_AUTO_CFG_AUD_OUT:
            HDMIRX_HAL_RegWriteFldAlign(enPort,AEC0_CTRL, reg_aac_out_off_en, (HI_U32)bEn);
            break;
        case HDMIRX_AUTO_CFG_ALL:
            HDMIRX_HAL_RegWriteFldAlign(enPort,RX_VID_CTRL2, reg_avc_en, (HI_U32)bEn);
            #if SUPPORT_AEC
            HDMIRX_HAL_RegWriteFldAlign(enPort,AEC0_CTRL, reg_aac_en, (HI_U32)bEn);
            #endif
            HDMIRX_HAL_RegWriteFldAlign(enPort,AEC0_CTRL, reg_aac_out_off_en, (HI_U32)bEn);
            break;
        default:
            break;
    }
}
/* 
------------------------------------------------------------------------------
    Function:       HDMIRX_HAL_SetPreambleCfg
    Description:    To set the de-packet configuaration.
    Parameters:     None.
    Returns:        None.
    Note:           Just called once if system power on.
-----------------------------------------------------------------------------
*/
static HI_VOID HDMIRX_HAL_SetPreambleCfg(HI_UNF_HDMIRX_PORT_E enPort)
{
     /* according the spec, the PREAMBLE is 8 pixel clock. HDCP_PREAMBLE: 8+4(min) */
    HDMIRX_HAL_RegWrite(enPort,RX_PREAMBLE_CRIT, 0x06);
    HDMIRX_HAL_RegWrite(enPort,RX_HDCP_PREAMBLE_CRIT, 0x0c);
}
/* 
------------------------------------------------------------------------------
Function:		HDMIRX_HAL_SetXpclkDft
Description:   To set the pclk-xclk counter configuaration.
Parameters:    None.
Returns:       None.
Note:          Just called once if system power on.
-----------------------------------------------------------------------------
*/
static HI_VOID HDMIRX_HAL_SetXpclkDft(HI_UNF_HDMIRX_PORT_E enPort)
{

    // 2048*Pclk/xclk = counter.
    HDMIRX_HAL_RegWriteFldAlign(enPort,RX_VID_XPCLK_EN, reg_vid_xclkpclk_en, 1);
    HDMIRX_HAL_RegWrite(enPort,VID_XPCLK_Base, 0xff);
}
/* 
------------------------------------------------------------------------------
Function:       HDMIRX_HAL_SetHdcpDftThr
Description:    To set the pclk-xclk counter configuaration.
Parameters:     None.
Returns:        None.
Note:           Just called once if system power on.
-----------------------------------------------------------------------------
*/
static HI_VOID HDMIRX_HAL_SetHdcpDftThr(HI_UNF_HDMIRX_PORT_E enPort)
{
    HDMIRX_HAL_RegWrite(enPort,RX_HDCP_THRES, 0x40);
    HDMIRX_HAL_RegWrite(enPort,RX_HDCP_THRES2, 0x0b);
}

HI_VOID HDMIRX_HAL_ClearAvMute(HI_UNF_HDMIRX_PORT_E enPort,HI_BOOL bEn)
{
   HDMIRX_HAL_RegWriteFldAlign(enPort,DEC_AV_MUTE, reg_clear_av_mute, (HI_U32)bEn);   
}
/* 
------------------------------------------------------------------------------
Function:       HDMIRX_HAL_MuteOnOff
Description:    To mute video or audio.
Parameters:     enType: video or audio
                bEn: true for mute.
Returns:        None
Note:           1. called by audio power on, to mute audio.
                2. called by HDMIRX_STATE_INIT. to mute all.
                3. called after ckdt, to mute video.
-----------------------------------------------------------------------------
*/
HI_VOID HDMIRX_HAL_SetMuteEn(HI_UNF_HDMIRX_PORT_E enPort,HDMIRX_MUTE_TYPE enType, HI_BOOL bEn)
{
   // return;
    switch(enType) 
    {
        case HDMIRX_MUTE_AUD:
            HDMIRX_HAL_RegWriteFldAlign(enPort,RX_AUDP_MUTE, reg_audio_mute, (HI_U32)bEn);
            break;
            
        case HDMIRX_MUTE_VDO:
            HDMIRX_HAL_RegWriteFldAlign(enPort,DEC_AV_MUTE, reg_video_mute, (HI_U32)bEn);
         //   HDMIRX_HAL_RegWriteFldAlign(DEC_AV_MUTE, reg_clear_av_mute, (HI_U32)!bEn);
            break;

        case HDMIRX_MUTE_ALL:
            HDMIRX_HAL_RegWriteFldAlign(enPort,RX_AUDP_MUTE, reg_audio_mute, (HI_U32)bEn);
            HDMIRX_HAL_RegWriteFldAlign(enPort,DEC_AV_MUTE, reg_video_mute, (HI_U32)bEn);
        //    HDMIRX_HAL_RegWriteFldAlign(DEC_AV_MUTE, reg_clear_av_mute, (HI_U32)!bEn);
            break;

        default:
            break;
    }
}
/* 
------------------------------------------------------------------------------
Function:       HDMIRX_HAL_GetDeviceId
Description:    To get the chip id.
Parameters:     None.
Returns:        None.
Note:           called once if power on.
-----------------------------------------------------------------------------
*/

HI_U32 HDMIRX_HAL_GetDeviceId(HI_UNF_HDMIRX_PORT_E enPort)
{
	HI_U32 u32Id;
	u32Id = HDMIRX_HAL_RegReadFldAlign(enPort,RX_DEV_IDL, BIT7_0);
	u32Id += (HDMIRX_HAL_RegReadFldAlign(enPort,RX_DEV_IDH, BIT7_0) << 8);

	return u32Id;
}
/* 
------------------------------------------------------------------------------
Function:       	HDMIRX_HAL_GetDeviceReversion
Description:    	To get the chip reversion.
Parameters:     	None.
Returns:        	None.
Note:           	called once if power on.
-----------------------------------------------------------------------------
*/
HI_U32 HDMIRX_HAL_GetDeviceReversion(HI_UNF_HDMIRX_PORT_E enPort)
{
	HI_U32 u32Rev;

	u32Rev = HDMIRX_HAL_RegReadFldAlign(enPort,RX_DEV_REV, BIT7_0);

	return u32Rev;
}
/* 
------------------------------------------------------------------------------
Function:       HDMIRX_HAL_SetHdcpDdcEn
Description:    Turn on/off the hdcp ddc.. 
Parameters:     ePortIdx:   index of port.
                bOnOff:     on/off.
Returns:        None.
Note:           Called once if power on.
------------------------------------------------------------------------------
*/
HI_VOID HDMIRX_HAL_SetHdcpDdcEn(HI_UNF_HDMIRX_PORT_E ePortIdx, HI_BOOL bEn)
{
    HI_U32 u32Temp;
    /*
    if (ePortIdx == HI_UNF_HDMIRX_PORT_ALL) 
    {
        HDMIRX_HAL_RegSetBits(RX_DDC_EN, reg_hdcp_ddc_en, bEn);
    }
    else 
    {*/
        u32Temp = HDMIRX_HAL_RegReadFldAlign(ePortIdx,RX_DDC_EN, reg_hdcp_ddc_en);
        if(HI_TRUE == bEn)
        {
           u32Temp |= ((HI_U32)1<<ePortIdx);
        }
        else 
        {
            u32Temp &= (~((HI_U32)1<<ePortIdx));
        }
        HDMIRX_HAL_RegWriteFldAlign(ePortIdx,RX_DDC_EN, reg_hdcp_ddc_en, u32Temp);
    //}
}

/* 
------------------------------------------------------------------------------
Function:       HDMIRX_HAL_SetEdidDdcEn
Description:    turn on/off the edid ddc.. 
Parameters:     ePortIdx:   index of port.
                bOnOff:     on/off.
Returns:        None.
Note:           called once if power on.
------------------------------------------------------------------------------
*/
HI_VOID HDMIRX_HAL_SetEdidDdcEn(HI_UNF_HDMIRX_PORT_E ePortIdx, HI_BOOL bEn)
{
    HI_U32 u32Temp;
    /*
    if (ePortIdx == HI_UNF_HDMIRX_PORT_ALL) 
    {
        HDMIRX_HAL_RegSetBits(RX_DDC_EN, reg_edid_ddc_en, bEn);
    }
    else 
    {*/
        u32Temp = HDMIRX_HAL_RegReadFldAlign(ePortIdx,RX_DDC_EN, reg_edid_ddc_en);
        if(HI_TRUE == bEn)
        {
           u32Temp |= ((HI_U32)0x1<<ePortIdx);
        }
        else 
        {
            u32Temp &= (~((HI_U32)0x1<<ePortIdx));
        }
        HDMIRX_HAL_RegWriteFldAlign(ePortIdx,RX_DDC_EN, reg_edid_ddc_en, u32Temp);
    //}
}
/* 
------------------------------------------------------------------------------
Function:       	HDMIRX_HAL_SetResetEn
Description:    	turn on/off the special module reset. 
Parameters:    	eRst:   reset type.
                	bEn:    on/off.
Returns:        	None.
Note:           	1. if power on, all reset and un-reset.
                	2. after power on, hold the soft reset.
                	3. if connect, cancel the soft reset.
               	4. in HDMIRX_STATE_INIT, reset the dc fifo and un-reset.
                	5. in HDMIRX_STATE_INIT, reset the hdcp and un-reset.
                	6. if ckdt, reset the dc fifo and un-reset.
                    
------------------------------------------------------------------------------
*/
HI_VOID HDMIRX_HAL_SetResetEn(HI_UNF_HDMIRX_PORT_E enPort,HDMIRX_RESET_TYPE enRst, HI_BOOL bEn)
{
	
	switch(enRst)
    {
       case HDMIRX_SOFT_RST:
            HDMIRX_HAL_RegWriteFldAlign(enPort,RX_AON_SRST, reg_sw_rst, (HI_U32)bEn);
            break;
            
       case HDMIRX_DC_FIFO_RST:
            HDMIRX_HAL_RegWriteFldAlign(enPort,RX_PWD_SRST, dc_fifo_rst, (HI_U32)bEn);
            break;

       case HDMIRX_HDCP_RST:
            break;

       	case HDMIRX_BUS_RST:
            break;

	   	case HDMIRX_DDC_RST:
	   		HDMIRX_HAL_RegWriteFldAlign(enPort,SYS_RESET_CTRL, reg_ddc_rst, (HI_U32)bEn);
			break;

		case HDMIRX_ACR_RST:
			HDMIRX_HAL_RegWriteFldAlign(enPort,RX_PWD_SRST, acr_rst, (HI_U32)bEn);
			break;
			
		case HDMIRX_AUDIO_FIFO_RST:	
			HDMIRX_HAL_RegWriteFldAlign(enPort,RX_PWD_SRST, fifo_rst, (HI_U32)bEn);
			break;
		case HDMIRX_HDMIM_RST:
            HDMIRX_HAL_RegWriteFldAlign(enPort,RX_C0_SRST2, reg_hdmim_sw_rst,(HI_U32)bEn);
            break;
       	case HDMIRX_ALL_RST:
        	HDMIRX_HAL_RegSetBits(enPort,RX_PWD_SRST, aac_rst|dc_fifo_rst|acr_rst|fifo_rst, bEn);
			HDMIRX_HAL_RegWriteFldAlign(enPort,RX_AON_SRST, reg_sw_rst, (HI_U32)bEn);
            break;
        
       	default:
            break;
    }
}
/*
------------------------------------------------------------------------------
Function:       	HDMIRX_HAL_SetAutoRstEn
Description:    	Turn on/off the auto-reset of special module . 
Parameters:     	eAutoRst:   auto-reset type.
                	bOnOff:     on/off.
Returns:        	None.
Note:           	1. turn off all auto-reset if power on.
                	2. turn on soft and hdcp auto-reset in HDMIRX_STATE_INIT.
                	3. turn off hdcp auto-reset after ckdt.
------------------------------------------------------------------------------
*/
HI_VOID HDMIRX_HAL_SetAutoRstEn(HI_UNF_HDMIRX_PORT_E enPort,HDMIRX_AUTO_RESET_TYPE enAutoRst, HI_BOOL bEn)
{
    switch(enAutoRst)
    {
        case HDMIRX_AUTORST_HDCP:
            break;
            
        case HDMIRX_AUTORST_AUDIO_FIFO:
            HDMIRX_HAL_RegWriteFldAlign(enPort,RX_PWD_SRST, aud_fifo_rst_auto, bEn);
            break;
            
        case HDMIRX_AUTORST_ACR:
            HDMIRX_HAL_RegWriteFldAlign(enPort,RX_PWD_SRST, acr_rst_auto, bEn);
            break;
            
        case HDMIRX_AUTORST_SOFT:
            HDMIRX_HAL_RegWriteFldAlign(enPort,RX_AON_SRST, reg_sw_rst_auto, bEn);
            break;

        case HDMIRX_AUTORST_ALL:
            HDMIRX_HAL_RegSetBits(enPort,RX_PWD_SRST, aud_fifo_rst_auto|acr_rst_auto, bEn);
            HDMIRX_HAL_RegWriteFldAlign(enPort,RX_AON_SRST, reg_sw_rst_auto, bEn);
            break;
            
        default:
            break;
    }
}
/*
------------------------------------------------------------------------------
Function:       HDMIRX_HAL_SetPowerOnEn
Description:    Turn on/off the system power. 
Parameters:     bEn: True for power on.
Returns:        None.
Note:           1. called by system power on
------------------------------------------------------------------------------

static HI_VOID HDMIRX_HAL_SetPowerOnEn(HI_BOOL bEn)
{
    HDMIRX_HAL_RegWriteFldAlign(RX_SYS_CTRL1, reg_pd_all, (HI_U32)bEn);
}*/
/*
------------------------------------------------------------------------------
Function:       HDMIRX_HAL_SelectPort
Description:    To switch port. 
Parameters:     u32Port: port index.
Returns:        None.
Note:           
------------------------------------------------------------------------------
*/
HI_VOID HDMIRX_HAL_SelectPort(HI_UNF_HDMIRX_PORT_E enPort)
{
    HDMIRX_HAL_RegWriteFldAlign(enPort,CORE_SEL, reg_ics0_sel, enPort);
    //printk("port = %d \n",HDMIRX_HAL_RegReadFldAlign(CORE_SEL, reg_ics0_sel));
}
/*
------------------------------------------------------------------------------
Function:       HDMIRX_HAL_GetInterruptSta
Description:    To copy all interrupt status to array.
Parameters:     pu32Int: the point of array.
Returns:        None.
Note:           
------------------------------------------------------------------------------
*/
HI_VOID HDMIRX_HAL_GetInterruptSta(HI_UNF_HDMIRX_PORT_E enPort,HI_U32 *pu32Int)
{
    HDMIRX_HAL_RegReadBlock(enPort, RX_INTR1, pu32Int, 8);
    pu32Int[HDMIRX_INTR2_AON] = HDMIRX_HAL_RegRead(enPort, RX_INTR2_AON);
    pu32Int[HDMIRX_INTR6_AON] = HDMIRX_HAL_RegRead(enPort, RX_INTR6_AON);
    pu32Int[HDMIRX_INTR8_AON] = HDMIRX_HAL_RegRead(enPort, RX_INTR8_AON);
}
/*
------------------------------------------------------------------------------
Function:       HDMIRX_HAL_SetInterruptSta
Description:    To clear all interrupt.
Parameters:     pu32Int: the point of array.
Returns:        None.
Note:           
------------------------------------------------------------------------------
*/
HI_VOID HDMIRX_HAL_SetInterruptSta(HI_UNF_HDMIRX_PORT_E enPort,HI_U32 *pu32Int)
{
    HDMIRX_HAL_RegWriteBlock(enPort, RX_INTR1, pu32Int, 8);
    HDMIRX_HAL_RegWrite(enPort, RX_INTR2_AON, pu32Int[HDMIRX_INTR2_AON]);
    HDMIRX_HAL_RegWrite(enPort, RX_INTR6_AON, pu32Int[HDMIRX_INTR6_AON]);
    HDMIRX_HAL_RegWrite(enPort, RX_INTR8_AON, pu32Int[HDMIRX_INTR8_AON]);
}
/*
------------------------------------------------------------------------------
Function:       HDMIRX_HAL_GetDeepColorSta
Description:    Get the deep color status.
Parameters:     None.
Returns:        deep color status.
Note:           
------------------------------------------------------------------------------
*/
HDMIRX_INPUT_WIDTH_E HDMIRX_HAL_GetDeepColorSta(HI_UNF_HDMIRX_PORT_E enPort)
{
    HDMIRX_INPUT_WIDTH_E enDeepStatus;
    
    enDeepStatus = HDMIRX_HAL_RegReadFldAlign(enPort, RX_DC_STAT, reg_pixelDepth);

    return enDeepStatus;
}
/*
------------------------------------------------------------------------------
Function:       HDMIRX_HAL_GetDeepColorSta
Description:    Set the deep color mode.
Parameters:     enMode: deep status.
Returns:        none.
Note:           
------------------------------------------------------------------------------
*/
HI_VOID HDMIRX_HAL_SetDeepColor(HI_UNF_HDMIRX_PORT_E enPort, 
HDMIRX_INPUT_WIDTH_E enMode)
{
    //HDMIRX_HAL_RegWriteFldAlign(RX_TMDS_CCTRL2, reg_dc_ctl, enMode);
    //HDMIRX_HAL_RegWriteFldAlign(RX_TMDS_CCTRL2, reg_dc_ctl_ow, 1);
    if(enMode == HDMIRX_INPUT_WIDTH_30)  // 10bit
    {
        switch(enPort)
        {
            case HI_UNF_HDMIRX_PORT0:
                HDMIRX_HAL_RegWriteFldAlign(enPort, TMDS0_CTRL4, reg_p0_dpcolor_ctl, 2);
#if !SUPPORT_DOUBLE_CTRL
                HDMIRX_HAL_RegWriteFldAlign(enPort, TMDS0_CTRL4, reg_p0_dpcolor_sw_ovr, 1);
#endif
                break;
            #if !SUPPORT_PORT0_ONLY
            case HI_UNF_HDMIRX_PORT1:
                HDMIRX_HAL_RegWriteFldAlign(enPort, TMDS1_CTRL4, reg_p1_dpcolor_ctl, 2);
#if !SUPPORT_DOUBLE_CTRL
                HDMIRX_HAL_RegWriteFldAlign(enPort, TMDS1_CTRL4, reg_p1_dpcolor_sw_ovr, 1);
#endif
                break;
            case HI_UNF_HDMIRX_PORT2:
                HDMIRX_HAL_RegWriteFldAlign(enPort, TMDS2_CTRL4, reg_p2_dpcolor_ctl, 2);
#if !SUPPORT_DOUBLE_CTRL
                HDMIRX_HAL_RegWriteFldAlign(enPort, TMDS2_CTRL4, reg_p2_dpcolor_sw_ovr, 1);
#endif
                break;
            case HI_UNF_HDMIRX_PORT3:
                HDMIRX_HAL_RegWriteFldAlign(enPort, TMDS3_CTRL4, reg_p3_dpcolor_ctl, 2);
#if !SUPPORT_DOUBLE_CTRL
                HDMIRX_HAL_RegWriteFldAlign(enPort, TMDS3_CTRL4, reg_p3_dpcolor_sw_ovr, 1);
#endif
                break;
            #endif
            default:
                break;
        }
    }
    else if(enMode == HDMIRX_INPUT_WIDTH_36)    // 12 bit
    {
        switch(enPort)
        {
            case HI_UNF_HDMIRX_PORT0:
                HDMIRX_HAL_RegWriteFldAlign(enPort, TMDS0_CTRL4, reg_p0_dpcolor_ctl, 1);
#if !SUPPORT_DOUBLE_CTRL
                HDMIRX_HAL_RegWriteFldAlign(enPort, TMDS0_CTRL4, reg_p0_dpcolor_sw_ovr, 1);
#endif
                break;
            #if !SUPPORT_PORT0_ONLY
            case HI_UNF_HDMIRX_PORT1:
                HDMIRX_HAL_RegWriteFldAlign(enPort, TMDS1_CTRL4, reg_p1_dpcolor_ctl, 1);
#if !SUPPORT_DOUBLE_CTRL
                HDMIRX_HAL_RegWriteFldAlign(enPort, TMDS1_CTRL4, reg_p1_dpcolor_sw_ovr, 1);
#endif
                break;
            case HI_UNF_HDMIRX_PORT2:
                HDMIRX_HAL_RegWriteFldAlign(enPort, TMDS2_CTRL4, reg_p2_dpcolor_ctl, 1);
#if !SUPPORT_DOUBLE_CTRL
                HDMIRX_HAL_RegWriteFldAlign(enPort, TMDS2_CTRL4, reg_p2_dpcolor_sw_ovr, 1);
#endif
                break;
            case HI_UNF_HDMIRX_PORT3:
                HDMIRX_HAL_RegWriteFldAlign(enPort, TMDS3_CTRL4, reg_p3_dpcolor_ctl, 1);
#if !SUPPORT_DOUBLE_CTRL
                HDMIRX_HAL_RegWriteFldAlign(enPort, TMDS3_CTRL4, reg_p3_dpcolor_sw_ovr, 1);
#endif
                break;
            #endif
            default:
                break;
        }
    }
    else // 8 bit
    {
        switch(enPort)
        {
            case HI_UNF_HDMIRX_PORT0:
                HDMIRX_HAL_RegWriteFldAlign(enPort, TMDS0_CTRL4, reg_p0_dpcolor_ctl, 0);
#if !SUPPORT_DOUBLE_CTRL
                HDMIRX_HAL_RegWriteFldAlign(enPort, TMDS0_CTRL4, reg_p0_dpcolor_sw_ovr, 0);
#endif
                break;
            #if !SUPPORT_PORT0_ONLY
            case HI_UNF_HDMIRX_PORT1:
                HDMIRX_HAL_RegWriteFldAlign(enPort, TMDS1_CTRL4, reg_p1_dpcolor_ctl, 0);
#if !SUPPORT_DOUBLE_CTRL
                HDMIRX_HAL_RegWriteFldAlign(enPort, TMDS1_CTRL4, reg_p1_dpcolor_sw_ovr, 0);
#endif
                break;
            case HI_UNF_HDMIRX_PORT2:
                HDMIRX_HAL_RegWriteFldAlign(enPort, TMDS2_CTRL4, reg_p2_dpcolor_ctl, 0);
#if !SUPPORT_DOUBLE_CTRL
                HDMIRX_HAL_RegWriteFldAlign(enPort, TMDS2_CTRL4, reg_p2_dpcolor_sw_ovr, 0);
#endif
                break;
            case HI_UNF_HDMIRX_PORT3:
                HDMIRX_HAL_RegWriteFldAlign(enPort, TMDS3_CTRL4, reg_p3_dpcolor_ctl, 0);
#if !SUPPORT_DOUBLE_CTRL
                HDMIRX_HAL_RegWriteFldAlign(enPort, TMDS3_CTRL4, reg_p3_dpcolor_sw_ovr, 0);
#endif
                break;
            #endif
            default:
                break;
        }
    }
}
/*
------------------------------------------------------------------------------
Function:       HDMIRX_HAL_GetAviType
Description:    Get the header of avi packet.
Parameters:     None.
Returns:        header of avi packet.
Note:           
------------------------------------------------------------------------------
*/
HI_U32 HDMIRX_HAL_GetAviType(HI_UNF_HDMIRX_PORT_E enPort)
{
    return HDMIRX_HAL_RegReadFldAlign(enPort, RX_AVIRX_TYPE, BIT7_0);
}
/*
------------------------------------------------------------------------------
Function:       HDMIRX_HAL_GetHtotal
Description:    Get the h total.
Parameters:     None.
Returns:        Htotal.
Note:           
------------------------------------------------------------------------------
*/
HI_U32 HDMIRX_HAL_GetHtotal(HI_UNF_HDMIRX_PORT_E enPort)
{
    return (HDMIRX_HAL_RegRead(enPort, RX_H_RESL)+(HDMIRX_HAL_RegRead(enPort, RX_H_RESH) << 8));
}
/*
------------------------------------------------------------------------------
Function:       HDMIRX_HAL_GetVtotal
Description:    Get the v total.
Parameters:     None.
Returns:        Vtotal.
Note:           
------------------------------------------------------------------------------
*/
HI_U32 HDMIRX_HAL_GetVtotal(HI_UNF_HDMIRX_PORT_E enPort)
{
    return (HDMIRX_HAL_RegRead(enPort, RX_V_RESL)+(HDMIRX_HAL_RegRead(enPort, RX_V_RESH) << 8));
}
/*
------------------------------------------------------------------------------
Function:       HDMIRX_HAL_GetReplication
Description:    Get repeation of pixel.
Parameters:     None.
Returns:        Repeation rate..
Note:           
------------------------------------------------------------------------------
*/
HI_U32 HDMIRX_HAL_GetReplication(HI_UNF_HDMIRX_PORT_E enPort)
{
    return HDMIRX_HAL_RegReadFldAlign(enPort, RX_VID_CTRL4, reg_iclk);
}
/*
------------------------------------------------------------------------------
Function:       HDMIRX_HAL_GetInterlance
Description:    To check the video is progressive or interlance.
Parameters:     None.
Returns:        True for progressive.
Note:           
------------------------------------------------------------------------------
*/
HI_BOOL HDMIRX_HAL_GetInterlance(HI_UNF_HDMIRX_PORT_E enPort)
{
    return HDMIRX_HAL_RegReadFldAlign(enPort, RX_VID_STAT, InterlacedOut);
}

/*
------------------------------------------------------------------------------
Function:       HDMIRX_HAL_GetHpol
Description:    To get the pol of hsync.
Parameters:     None.
Returns:        True for positive.
Note:           
------------------------------------------------------------------------------
*/
HI_BOOL HDMIRX_HAL_GetHpol(HI_UNF_HDMIRX_PORT_E enPort)
{
    return (!(HI_BOOL)HDMIRX_HAL_RegReadFldAlign(enPort, RX_VID_STAT, HsyncPol));
}
/*
------------------------------------------------------------------------------
Function:       HDMIRX_HAL_GetVpol
Description:    To get the pol of vsync.
Parameters:     None.
Returns:        True for positive.
Note:           
------------------------------------------------------------------------------
*/
HI_BOOL HDMIRX_HAL_GetVpol(HI_UNF_HDMIRX_PORT_E enPort)
{
    return (!(HI_BOOL)HDMIRX_HAL_RegReadFldAlign(enPort, RX_VID_STAT, VsyncPol));
}
/*
------------------------------------------------------------------------------
Function:       HDMIRX_HAL_SetBlankLv
Description:    To set the blank level.
Parameters:     pau32BlankLv: blank level for three component.
Returns:        None.
Note:           
------------------------------------------------------------------------------
*/
HI_VOID HDMIRX_HAL_SetBlankLv(HI_UNF_HDMIRX_PORT_E enPort,HI_U32 *pau32BlankLv)
{
    HDMIRX_HAL_RegWriteBlock(enPort, RX_VID_BLANK1, pau32BlankLv, 3);
}
/*
------------------------------------------------------------------------------
Function:       HDMIRX_HAL_GetDitherMode
Description:    To get the dither mode of chip.
Parameters:     None.
Returns:        dither mode:00 - dither to 8 bits (defualt); 
                            01 - dither to 10 bits; 
                            10 - dither to 12 bits; 
                            11 - reserved;
Note:           
------------------------------------------------------------------------------
*/
HI_U32 HDMIRX_HAL_GetDitherMode(HI_UNF_HDMIRX_PORT_E enPort)
{
    return (HDMIRX_HAL_RegRead(enPort, RX_VID_MODE2) & reg_dither_mode);
}
/*
------------------------------------------------------------------------------
Function:       HDMIRX_HAL_SetOutFormat
Description:    To set the special format.
Parameters:     None.
Returns:        
Note:           
------------------------------------------------------------------------------
*/
HI_VOID HDMIRX_HAL_SetOutFormat(HI_UNF_HDMIRX_PORT_E enPort,HI_U32 *pau32Format)
{
    HDMIRX_HAL_RegWriteBlock(enPort, RX_VID_CTRL, pau32Format, 3);
}

HI_VOID HDMIRX_HAL_SetChannelMap(HI_UNF_HDMIRX_PORT_E enPort,HDMIRX_COLOR_SPACE_E enColor , HDMIRX_OVERSAMPLE_E enReplication)
{

    if(enColor == HDMIRX_COLOR_SPACE_RGB)
	{
		HDMIRX_HAL_RegWriteFldAlign(enPort, RX_VID_CH_MAP, reg_channel_map, 0);
	}
	else if(enColor == HDMIRX_COLOR_SPACE_YCBCR444)
	{
		HDMIRX_HAL_RegWriteFldAlign(enPort, RX_VID_CH_MAP, reg_channel_map, 3);
	}
	else if(enColor == HDMIRX_COLOR_SPACE_YCBCR422)
	{
        //将输入422输出改为444
        if(enReplication > HDMIRX_OVERSAMPLE_NONE)
        {
           HDMIRX_HAL_RegWriteFldAlign(enPort, RX_VID_CH_MAP, reg_channel_map, 3);
        }
        else
        {
            HDMIRX_HAL_RegWriteFldAlign(enPort, RX_VID_CH_MAP, reg_channel_map, 2);
        }
       // HDMIRX_HAL_RegWriteFldAlign(RX_VID_CH_MAP, reg_channel_map, 2);
	}
    
}


HI_U32 HDMIRX_HAL_GetOclkCfg(HI_UNF_HDMIRX_PORT_E enPort)
{
    return HDMIRX_HAL_RegRead(enPort, RX_VID_CTRL4);
}
HI_VOID HDMIRX_HAL_SetOclkCfg(HI_UNF_HDMIRX_PORT_E enPort,HI_U32 u32Cfg)
{
    HDMIRX_HAL_RegWrite(enPort, RX_VID_CTRL4 , u32Cfg);
}
HI_VOID HDMIRX_HAL_ClearT4Error(HI_UNF_HDMIRX_PORT_E enPort)
{
    // Clear BCH counter and the interrupt associated with it.
	// It'll help avoiding a false HDCP Error interrupt caused by pre-HDMI counter content.
	// Capture and clear BCH T4 errors.
	HDMIRX_HAL_RegWriteFldAlign(enPort, RX_ECC_CTRL, reg_capture_cnt, 1);
	HDMIRX_HAL_RegWriteFldAlign(enPort, RX_INTR4, intr_HDCP_packet_err, 1); // reset the HDCP BCH error interrupt
}
HI_BOOL HDMIRX_HAL_GetMuteSta(HI_UNF_HDMIRX_PORT_E enPort)
{
    return HDMIRX_HAL_RegReadFldAlign(enPort, RX_AUDP_STAT, hdmi_mute);
}
/* 
------------------------------------------------------------------------------
Function:       HDMIRX_HAL_GetPixClk
Description:    calculated the pix clock frequency in 10kHz units.
Parameters:     None.
Returns:        the pix frequency in 10kHz
Note:           1. called if timing search.
-----------------------------------------------------------------------------
*/
HI_U32 HDMIRX_HAL_GetPixClk(HI_UNF_HDMIRX_PORT_E enPort)
{
	HI_U32 xcnt = 0;
	HI_U32 pixel_freq = 0;
	
	xcnt = (HDMIRX_HAL_RegRead(enPort, RX_VID_XPCNT2)<<8) + HDMIRX_HAL_RegRead(enPort, RX_VID_XPCNT1);
	pixel_freq = HDMIRX_XCLK;
    if(xcnt == 0) 
	{
      return 0; 
    }
	pixel_freq /= xcnt;

	if(pixel_freq > 65535)
	{
		pixel_freq = 65535;
	}
	
	return pixel_freq;
}

HI_VOID HDMIRX_HAL_ResetPaCore(HI_UNF_HDMIRX_PORT_E enPort,HI_BOOL bReset)
{
    HDMIRX_HAL_RegWriteFldAlign(enPort, PAUTH_MISC_CTRL1, ri_irst_n, bReset);
}
/*
------------------------------------------------------------------------------
Function:       HDMIRX_HAL_SystemRegInit
Description:    initial the system reg. 
Parameters:     None
Returns:        None.
Note:           1. called by system power on
------------------------------------------------------------------------------
*/
static HI_VOID HDMIRX_HAL_SystemRegInit(HI_VOID)
{
	//HDMIRX_HAL_SetPowerOnEn(HI_TRUE);
#if SUPPORT_DOUBLE_CTRL	
	HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT0, RX_SYS_CTRL1, reg_pd_all, 1);
    HDMIRX_HAL_RegWrite(HI_UNF_HDMIRX_PORT0, PA_DDC_DIS_EN, 0);
#endif    
    HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT1, RX_SYS_CTRL1, reg_pd_all, 1);
    HDMIRX_HAL_RegWrite(HI_UNF_HDMIRX_PORT1, PA_DDC_DIS_EN, 0);
    
    HDMIRX_HAL_SetTermValue(HI_UNF_HDMIRX_PORT0 ,HDMIRX_TERM_CTL_45);
#if !SUPPORT_PORT0_ONLY   
    HDMIRX_HAL_SetTermValue(HI_UNF_HDMIRX_PORT1 ,HDMIRX_TERM_CTL_45);
    HDMIRX_HAL_SetTermValue(HI_UNF_HDMIRX_PORT2 ,HDMIRX_TERM_CTL_45);
    HDMIRX_HAL_SetTermValue(HI_UNF_HDMIRX_PORT3 ,HDMIRX_TERM_CTL_45);
#endif 

    //HDMIRX_HAL_SetHpdLevel(HI_UNF_HDMIRX_PORT_ALL, HI_FALSE);
    HDMIRX_HAL_SetHpdPullUpEn(HI_UNF_HDMIRX_PORT0, HI_TRUE);

#if !SUPPORT_PORT0_ONLY
    HDMIRX_HAL_SetHpdPullUpEn(HI_UNF_HDMIRX_PORT1, HI_FALSE);
    HDMIRX_HAL_SetHpdPullUpEn(HI_UNF_HDMIRX_PORT2, HI_FALSE);
    HDMIRX_HAL_SetHpdPullUpEn(HI_UNF_HDMIRX_PORT3, HI_FALSE);
#endif 
    if(HDMIRX_HAL_GetCbusSense(HI_UNF_HDMIRX_PORT0) == HI_TRUE)
    {
        //HDMIRX_HAL_SetHpdLevel(HI_UNF_HDMIRX_PORT0, HI_FALSE);
        //msleep(500);
        HDMIRX_HAL_MHLRstEn(HI_TRUE);
    }
    else
    {
        HDMIRX_HAL_SetHpdLevel(HI_UNF_HDMIRX_PORT0, HI_FALSE);
    }
    
#if !SUPPORT_PORT0_ONLY
    HDMIRX_HAL_SetHpdLevel(HI_UNF_HDMIRX_PORT1, HI_FALSE);
    HDMIRX_HAL_SetHpdLevel(HI_UNF_HDMIRX_PORT2, HI_FALSE);
    HDMIRX_HAL_SetHpdLevel(HI_UNF_HDMIRX_PORT3, HI_FALSE);
#endif

    

#if SUPPORT_MHL
        //HDMIRX_HAL_RegWriteFldAlign(pauth_mhl_config1, ri_mp_m1080p_det_en, 1);
       // HDMIRX_HAL_RegWriteFldAlign(pauth_mhl_config1, ri_bch_code_en, 1);
        HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT0, pauth_mhl_config1, ri_prmbl_thrshld, 6);
#endif

#if SUPPORT_DOUBLE_CTRL
    HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT0,RX_SYS_CTRL1, reg_sync_pol, 0);
	HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT0,RX_TMDS_CCTRL2, reg_offset_coen, 0);
	//HDMIRX_HAL_RegWrite(HI_UNF_HDMIRX_PORT0,DDC_CTRL, 0x09);
    HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT0,DDC_CTRL,reg_ddc_sda_in_del_en,0);
    HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT0,DDC_CTRL,reg_ddc_filter_sel,1);
    HDMIRX_HAL_RegWrite(HI_UNF_HDMIRX_PORT0,PAUTH_CTRL, 9);
    HDMIRX_HAL_SetAutoRstEn(HI_UNF_HDMIRX_PORT0,HDMIRX_AUTORST_ALL, HI_FALSE);
    HDMIRX_HAL_SetResetEn(HI_UNF_HDMIRX_PORT0,HDMIRX_ALL_RST, HI_TRUE);

	HDMIRX_HAL_RegWrite(HI_UNF_HDMIRX_PORT0,SYS_TMDS_D_IR, 0x6b);
    
    HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT0,RX_TMDS_CCTRL2, reg_dc_ctl_ow, 0);

    HDMIRX_HAL_SetResetEn(HI_UNF_HDMIRX_PORT0,HDMIRX_ALL_RST, HI_FALSE);
    HDMIRX_HAL_SetResetEn(HI_UNF_HDMIRX_PORT0,HDMIRX_SOFT_RST, HI_TRUE);
    
	HDMIRX_HAL_RegWrite(HI_UNF_HDMIRX_PORT0,PAUTH_INV_CTRL, 0);
	 // set the bus width is 30bit
    HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT0,RX_VID_CTRL4, reg_bsel, 1);

	HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT0,RX_VID_CH_MAP, reg_channel_map, 3);
    HDMIRX_HAL_SetXpclkDft(HI_UNF_HDMIRX_PORT0);
    HDMIRX_HAL_SetHdcpDftThr(HI_UNF_HDMIRX_PORT0);
    HDMIRX_HAL_SetPreambleCfg(HI_UNF_HDMIRX_PORT0);
    HDMIRX_HAL_SetAutoCfgEn(HI_UNF_HDMIRX_PORT0,HDMIRX_AUTO_CFG_ALL, HI_FALSE);
    HDMIRX_HAL_RegWrite(HI_UNF_HDMIRX_PORT0,PAUTH_ECC_CTRL, 0x31);
#endif


	HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT1,RX_SYS_CTRL1, reg_sync_pol, 0);
	HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT1,RX_TMDS_CCTRL2, reg_offset_coen, 0);
	//HDMIRX_HAL_RegWrite(HI_UNF_HDMIRX_PORT1,DDC_CTRL, 0x08);
	HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT1,DDC_CTRL,reg_ddc_sda_in_del_en,0);
    HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT1,DDC_CTRL,reg_ddc_filter_sel,1);
    #if 0
	HDMIRX_HAL_RegWrite(PAUTH_CTRL, 0x67);
    
    HDMIRX_HAL_RegWriteFldAlign(PA_CONF_REG_46, ri_rp_ecc_err_chk_en, 1);
    HDMIRX_HAL_RegWriteFldAlign(PA_CONF_REG_42, ri_mp_use_auto_ecc_chk_on, 1);
    HDMIRX_HAL_RegWriteFldAlign(PAUTH_ECC_CHKTIME, reg_pauth_cnt2chk_ecc_err, 1);
    HDMIRX_HAL_RegWriteFldAlign(PA_CONF_REG_42, ri_rp_use_auto_ecc_chk_on, 1);
    HDMIRX_HAL_RegWriteFldAlign(PAUTH_MISC_CTRL0, reg_pauth_recov_en, 1);
    HDMIRX_HAL_RegWriteFldAlign(PAUTH_MISC_CTRL1, reg_pauth_ecc_auto_video_mute, 1);
    
    HDMIRX_HAL_RegWriteFldAlign(PAUTH_MISC_CTRL1, reg_pauth_ecc_auto_audio_mute, 1);
    
    HDMIRX_HAL_RegWriteFldAlign(PAUTH_MISC_CTRL1, reg_pauth_wide_vs_phase, 1);
    
    //HDMIRX_HAL_RegWriteFldAlign(PAUTH_MISC_CTRL1, ri_use_ckdt_in_good, 1);
    HDMIRX_HAL_RegWriteFldAlign(PAUTH_FRAME_ECC_THR, reg_pauth_frame_ecc_thr, 2);
    HDMIRX_HAL_RegWriteFldAlign(PAUTH_ECC_THRES0, reg_pauth_ecc_err_thr7_0, 1);
    #else
    HDMIRX_HAL_RegWrite(HI_UNF_HDMIRX_PORT1,PAUTH_CTRL, 9);
    #endif
    HDMIRX_HAL_SetAutoRstEn(HI_UNF_HDMIRX_PORT1,HDMIRX_AUTORST_ALL, HI_FALSE);
    HDMIRX_HAL_SetResetEn(HI_UNF_HDMIRX_PORT1,HDMIRX_ALL_RST, HI_TRUE);
    
	//HDMIRX_HAL_RegWrite(SYS_TMDS_CH_MAP, 0x12);
	HDMIRX_HAL_RegWrite(HI_UNF_HDMIRX_PORT1,SYS_TMDS_D_IR, 0x6b);
    
	//HDMIRX_HAL_RegWriteFldAlign(RX_TMDS_CCTRL2, reg_dc_ctl, 1);
    HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT1,RX_TMDS_CCTRL2, reg_dc_ctl_ow, 0);

    HDMIRX_HAL_SetResetEn(HI_UNF_HDMIRX_PORT1,HDMIRX_ALL_RST, HI_FALSE);
    HDMIRX_HAL_SetResetEn(HI_UNF_HDMIRX_PORT1,HDMIRX_SOFT_RST, HI_TRUE);
    
	HDMIRX_HAL_RegWrite(HI_UNF_HDMIRX_PORT1,PAUTH_INV_CTRL, 0);
	 // set the bus width is 30bit
    HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT1,RX_VID_CTRL4, reg_bsel, 1);

	HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT1,RX_VID_CH_MAP, reg_channel_map, 3);
    HDMIRX_HAL_SetXpclkDft(HI_UNF_HDMIRX_PORT1);
    HDMIRX_HAL_SetHdcpDftThr(HI_UNF_HDMIRX_PORT1);
    HDMIRX_HAL_SetPreambleCfg(HI_UNF_HDMIRX_PORT1);
    HDMIRX_HAL_SetAutoCfgEn(HI_UNF_HDMIRX_PORT1,HDMIRX_AUTO_CFG_ALL, HI_FALSE);
    HDMIRX_HAL_RegWrite(HI_UNF_HDMIRX_PORT1,PAUTH_ECC_CTRL, 0x31);
}
/*
------------------------------------------------------------------------------
Function:       HDMIRX_HAL_AudioRegInit
Description:    initial the audio reg. 
Parameters:     None
Returns:        None.
Note:           1. called by system power on
------------------------------------------------------------------------------
*/
HI_VOID HDMIRX_HAL_AudioRegInit(HI_UNF_HDMIRX_PORT_E enPort)
{
	HDMIRX_HAL_RegWrite(enPort, RX_I2S_CTRL2, reg_sd0_en|reg_mclk_en);
    // [0] no shit 
    // [1] msb first
    // [2] left justified
    // [3] low -left
    // [4] sign ex-extend
    // [5] 32 bit
    // [6] positive edge
    // [7] send only valid data.
    HDMIRX_HAL_RegWrite(enPort, RX_I2S_CTRL1, reg_clk_edge|reg_size);
    
    /* 
        init threshold for PLL unlock interrupt.if last pixel colocks is within 
        +/-(previous count)/128 for 0x20 samples cycles, the intr[4] is deasserted
    */
    HDMIRX_HAL_RegWrite(enPort, RX_LK_WIN_SVAL, 0x0f);
    HDMIRX_HAL_RegWrite(enPort, RX_LK_THRS_SVAL1, 0x20);
    HDMIRX_HAL_RegWrite(enPort, RX_LK_THRS_SVAL2, 0x00);
    HDMIRX_HAL_RegWrite(enPort, RX_LK_THRS_SVAL3, 0x00);

    /* 
        reg_cts_thresh: the CTS change threshold is 0x05, it means if the cts value 
        change more than 0x0a, the cts change flag is on. 
     */
    HDMIRX_HAL_RegWrite(enPort, RX_ACR_CTRL3, 0x50|reg_mclk_loopback);

    HDMIRX_HAL_RegWrite(enPort, RX_APLL_POLE, 0x88);  //set pll config #1
    HDMIRX_HAL_RegWrite(enPort, RX_APLL_CLIP, 0x16);  //set pll config #2
    
    // set the aec conditions.
    HDMIRX_HAL_RegWriteBlock(enPort, RX_AEC_EN1,(HI_U32 *)AecDefalut, 3);

    // aec control
    HDMIRX_HAL_RegSetBits(enPort, AEC3_CTRL, AAC_UNMUTE_NEW_AUDIO|AAC_UNMUTE_CTS, HI_TRUE);
    HDMIRX_HAL_RegSetBits(enPort, AEC2_CTRL, AAC_UNMUTE_GOT_FIFO_OVER|AAC_UNMUTE_GOT_FIFO_UNDER|AAC_UNMUTE_GOT_HDMI, HI_TRUE);
    HDMIRX_HAL_RegWrite(enPort, AEC1_CTRL, AAC_UNMUTE_TIME_OUT|AAC_NEW_ALGORITH|0x02|AAC_SIMPLE_METHOD);
    #if SUPPORT_AEC
    HDMIRX_HAL_RegSetBits(enPort, AEC0_CTRL, reg_aac_en|reg_aac_all|reg_aac_out_off_en|reg_ctrl_acr_en, HI_TRUE); 
    #else
    HDMIRX_HAL_RegSetBits(enPort, AEC0_CTRL, reg_aac_out_off_en|reg_ctrl_acr_en, HI_TRUE); 
    #endif
    HDMIRX_HAL_SetMuteEn(enPort, HDMIRX_MUTE_AUD, HI_TRUE);
    
    
    HDMIRX_HAL_RegWriteFldAlign(enPort, AAC_MCLK_SEL, reg_vcnt_max, 3);   //add for unmute timing    
    // [0] 1: spdif out enable
    // [2] 1: i2s enable
    // [3] 1: pass the data regardless of the error.
    // [4] 1: pass all data regardless of the error.
    // [5] 1: output is dsiable if hardware mute.
    // [7] 0: length take from hdmi packet.
    HDMIRX_HAL_RegWrite(enPort, RX_AUDRX_CTRL, reg_i2s_mode|reg_pass_aud_err|reg_pass_spdif_err|reg_hw_mute_en);
    #if SUPPORT_AEC
    HDMIRX_HAL_RegWriteFldAlign(enPort, AEC4_CTRL, BIT0, HI_TRUE);
    
    #endif
    HDMIRX_HAL_RegWriteFldAlign(enPort, AAC_MCLK_SEL, reg_mclk4hbra, 1);
}
/*
------------------------------------------------------------------------------
Function:       HDMIRX_HAL_VideoRegInit
Description:    initial the video reg. 
Parameters:     None
Returns:        None.
Note:           1. called by system power on
------------------------------------------------------------------------------
*/
HI_VOID HDMIRX_HAL_VideoRegInit(HI_UNF_HDMIRX_PORT_E enPort)
{
	// Setting the RX video mode
    HDMIRX_HAL_RegWrite(enPort, RX_VID_MODE, 0);

    HDMIRX_HAL_RegWrite(enPort, RX_VID_AOF, 0); // Video output format, digital RGB format
    
     // Enable color space converstion, YCbCr to RGB
	//HDMIRX_HAL_RegWriteFldAlign(RX_VID_MODE2, reg_enycbcr2rgb, 1);
	 
	HDMIRX_HAL_RegWriteFldAlign(enPort, RX_VID_MODE2, reg_dither_mode, HDMIRX_INPUT_WIDTH_36);
    HDMIRX_HAL_RegWriteFldAlign(enPort, RX_VID_CTRL2, reg_hsync_jitter_en, 0);
	HDMIRX_HAL_RegWriteFldAlign(enPort, RX_VID_F2BPM, reg_Field2Backporch, 1);
}
HI_VOID HDMIRX_HAL_PacketRegInit(HI_UNF_HDMIRX_PORT_E enPort)
{
    HDMIRX_HAL_RegWrite(enPort, RX_ACP_DEC,4);
      // set BCH threshold and reset BCH counter
    HDMIRX_HAL_RegWriteFldAlign(enPort, RX_BCH_THRES, reg_bch_thresh, 0x02);
    // Capture and clear BCH T4 errors.
    HDMIRX_HAL_RegWriteFldAlign(enPort, RX_ECC_CTRL, reg_capture_cnt, HI_TRUE);
}
/* 
-----------------------------------------------------------------------------
Function:    	HDMIRX_HAL_SetResChangeAecEn
Description: 	to enable the aec caused by H/V resolution changed
Parameters:  	bOnOff: true for enable. false for disable
Returns:     	none
NOTE: 		1. called if 3d signal.
-----------------------------------------------------------------------------
*/
#if SUPPORT_AEC
HI_VOID HDMIRX_HAL_SetResChangeAecEn(HI_UNF_HDMIRX_PORT_E enPort,HI_BOOL bEn)
{
	
    HDMIRX_HAL_RegWriteFldAlign(enPort, RX_AEC_EN3, BIT_V_RES_CHANGED, !bEn);
	HDMIRX_HAL_RegWriteFldAlign(enPort, RX_AEC_EN2, BIT_H_RES_CHANGED, bEn);
}
#endif
/* 
-----------------------------------------------------------------------------
Function:    	HDMIRX_HAL_GetAudp
Description: 	
Parameters:  	
Returns:     	
NOTE:           
-----------------------------------------------------------------------------
*/
HI_U32 HDMIRX_HAL_GetAudp(HI_UNF_HDMIRX_PORT_E enPort)
{
    return HDMIRX_HAL_RegRead(enPort, RX_AUDP_STAT);
}
//------------------------------------------------------------------------------
// Function:    HDMIRX_HAL_GetCts
// Description: get the CTS value in audio packet. 
// Parameters:  None.
// Returns:     the CTS value.
//------------------------------------------------------------------------------
HI_U32 HDMIRX_HAL_GetCts(HI_UNF_HDMIRX_PORT_E enPort)
{
    HI_U32 u32Temp = 0;
    
    u32Temp += ((HDMIRX_HAL_RegRead(enPort, RX_CTS_HVAL3)&0xff) << 16);
    u32Temp += ((HDMIRX_HAL_RegRead(enPort, RX_CTS_HVAL2)&0xff) << 8);
    u32Temp += (HDMIRX_HAL_RegRead(enPort, RX_CTS_HVAL1)&0xff);

    return u32Temp;
}
HI_BOOL HDMIRX_HAL_IsAudioPacketGot(HI_UNF_HDMIRX_PORT_E enPort)
{
    HI_BOOL bFlag = HI_FALSE;
    
    if (HDMIRX_HAL_RegReadFldAlign(enPort, RX_INTR2, intr_new_aud_pkt))
    {
        bFlag = HI_TRUE;
    }
     
    return bFlag;
}
HI_BOOL HDMIRX_HAL_IsCtsGot(HI_UNF_HDMIRX_PORT_E enPort)
{
    return (0 != HDMIRX_HAL_RegReadFldAlign(enPort, RX_INTR2, intr_got_cts));
}
HI_BOOL HDMIRX_HAL_IsClockStable(HI_UNF_HDMIRX_PORT_E enPort)
{
    // if there are CTS dropped or reused interrupts, then clock is not stable,
	// if there are no interrupt, the clock is stable
	if((HDMIRX_HAL_RegRead(enPort, RX_INTR4) & (intr_cts_reused_err | intr_cts_dropped_err)) == 0)
	{
		return HI_TRUE;
	}
	
	return HI_FALSE;
}
#if SUPPORT_AEC
HI_VOID HDMIRX_HAL_SetExceptionEn(HI_UNF_HDMIRX_PORT_E enPort, HI_BOOL bEn)
{
    if(bEn)
	{
		// Clear AAC Done interrupt which might be raised by previous events.
		// If the conditions for AAC Done still exist, the interrupt bit
		// will be set when the exceptions are turned on.
		HDMIRX_HAL_ClearInterrupt(enPort, HDMIRX_INT_AUD_MUTE);

		HDMIRX_HAL_RegWrite(enPort, AEC0_CTRL, reg_aac_en|reg_aac_all);
	}
	else
	{
		HDMIRX_HAL_RegWrite(enPort, AEC0_CTRL, 0);

		// Clear AAC Done bit to not generate extra interrupts.
		HDMIRX_HAL_ClearInterrupt(enPort, HDMIRX_INT_AUD_MUTE);
	}
}
#endif
//------------------------------------------------------------------------------
// Function:    HDMIRX_HAL_GetN
// Description: get the N value in audio packet. 
// Parameters:  None.
// Returns:     the N value.
//------------------------------------------------------------------------------
HI_U32 HDMIRX_HAL_GetN(HI_UNF_HDMIRX_PORT_E enPort)
{
    HI_U32 u32Temp = 0;
    
    u32Temp += ((HDMIRX_HAL_RegRead(enPort, RX_N_HVAL3)&0x000000ff) << 16);
    u32Temp += ((HDMIRX_HAL_RegRead(enPort, RX_N_HVAL2)&0x000000ff) << 8);
    u32Temp += (HDMIRX_HAL_RegRead(enPort, RX_N_HVAL1)&0x000000ff);

    return u32Temp;
}
//HI_VOID HDMIRX_HAL_SetHbrMclk(HI_U32 u32Mclk)
//{
//    HDMIRX_HAL_RegWriteFldAlign(AAC_MCLK_SEL, reg_mclk4hbra, u32Mclk);
//}

HI_VOID HDMIRX_HAL_SetFsSel(HI_UNF_HDMIRX_PORT_E enPort, HI_BOOL bSoft)
{
    HDMIRX_HAL_RegWriteFldAlign(enPort, RX_ACR_CTRL1, reg_fs_hw_sw_sel, bSoft);    
}
//------------------------------------------------------------------------------
// Function:    HDMIRX_HAL_ClearAudioInt
// Description: clear all the int about audio. 
// Parameters:  None.
// Returns:     None.
//------------------------------------------------------------------------------
HI_VOID HDMIRX_HAL_ClearAudioInt(HI_UNF_HDMIRX_PORT_E enPort)
{

	HDMIRX_HAL_RegWriteFldAlign(enPort, RX_INTR2, intr_got_cts, 1);
    HDMIRX_HAL_RegWriteFldAlign(enPort, RX_INTR2, intr_new_aud_pkt, 1);

    HDMIRX_HAL_RegWriteFldAlign(enPort, RX_INTR4, intr_underun, 1);
    HDMIRX_HAL_RegWriteFldAlign(enPort, RX_INTR4, intr_overun, 1);
    HDMIRX_HAL_RegWriteFldAlign(enPort, RX_INTR4, intr_cts_reused_err, 1);

    HDMIRX_HAL_RegWriteFldAlign(enPort, RX_INTR5, intr_audio_muted, 1);
    HDMIRX_HAL_RegWriteFldAlign(enPort, RX_INTR5, reg_audio_link_err, 1);
    HDMIRX_HAL_RegWriteFldAlign(enPort, RX_INTR5, reg_fn_chg, 1);
    HDMIRX_HAL_RegWriteFldAlign(enPort, RX_INTR5, intr_aud_sample_f, 1);
}
HI_VOID HDMIRX_HAL_DisableI2sOut(HI_UNF_HDMIRX_PORT_E enPort)
{
    HDMIRX_HAL_RegSetBits(enPort, RX_I2S_CTRL2, reg_sd3_en|reg_sd2_en|reg_sd1_en|reg_sd0_en|reg_mclk_en, HI_FALSE);
}


HI_VOID HDMIRX_HAL_SetMclk(HI_UNF_HDMIRX_PORT_E enPort, HI_U32 u32Code)
{
    HDMIRX_HAL_RegWrite(enPort,RX_FREQ_SVAL, u32Code);
}
HI_BOOL HDMIRX_HAL_IsFifoStable(HI_UNF_HDMIRX_PORT_E enPort)
{
    //if(0 == (HDMIRX_HAL_RegRead(RX_INTR4) & (intr_underun | intr_overun)))
    if((HDMIRX_HAL_RegReadFldAlign(enPort,RX_INTR4, intr_underun) \
        || HDMIRX_HAL_RegReadFldAlign(enPort,RX_INTR4, intr_overun)) == HI_FALSE)
    {
        return HI_TRUE;
    }
    return HI_FALSE;
}
HI_VOID HDMIRX_HAL_GetChannelSta(HI_UNF_HDMIRX_PORT_E enPort, HI_U32 *pau32Data)
{
    HDMIRX_HAL_RegReadBlock(enPort, RX_CHST1, pau32Data, 3);
	HDMIRX_HAL_RegReadBlock(enPort, RX_CHST4, &pau32Data[3], 2);
}
HI_U32 HDMIRX_HAL_GetHwSampleRate(HI_UNF_HDMIRX_PORT_E enPort)
{
    return HDMIRX_HAL_RegReadFldAlign(enPort, RX_TCLK_FS, rhdmi_aud_sample_f);
}
HI_VOID HDMIRX_HAL_SetSpdifOutEn(HI_UNF_HDMIRX_PORT_E enPort, HI_BOOL bOut)
{
    HDMIRX_HAL_RegWriteFldAlign(enPort, RX_AUDRX_CTRL, reg_spdif_en, (HI_U32)bOut);
}
HI_VOID HDMIRX_HAL_SetI2sOutCfg(HI_UNF_HDMIRX_PORT_E enPort, HI_U32 u32Cfg)
{
    HDMIRX_HAL_RegWrite(enPort, RX_I2S_CTRL2, u32Cfg);
}
HI_VOID HDMIRX_HAL_SetI2sOutDft(HI_UNF_HDMIRX_PORT_E enPort)
{
    HDMIRX_HAL_RegWriteFldAlign(enPort, RX_AUDRX_CTRL, reg_pass_spdif_err, 1);
    HDMIRX_HAL_RegWriteFldAlign(enPort, RX_AUDRX_CTRL, reg_i2s_mode, 1);
}
HI_VOID HDMIRX_HAL_SetHwMute(HI_UNF_HDMIRX_PORT_E enPort, HI_BOOL bHw)
{
    HDMIRX_HAL_RegWriteFldAlign(enPort, RX_AUDRX_CTRL, reg_hw_mute_en, bHw);
}
HI_U32 HDMIRX_HAL_GetLayout(HI_UNF_HDMIRX_PORT_E enPort)
{
    return HDMIRX_HAL_RegReadFldAlign(enPort, RX_AUDP_STAT, hdmi_layout);
}
HI_VOID HDMIRX_HAL_SetAcrStart(HI_UNF_HDMIRX_PORT_E enPort)
{
    HDMIRX_HAL_RegWriteFldAlign(enPort, RX_ACR_CTRL1, reg_acr_init, 1);
}

HI_BOOL HDMIRX_HAL_GetHdmiMode(HI_UNF_HDMIRX_PORT_E enPort)
{
    return HDMIRX_HAL_RegReadFldAlign(enPort, RX_AUDP_STAT, hdmi_mode_en);
}

HI_U32 HDMIRX_HAL_GetVactive(HI_UNF_HDMIRX_PORT_E enPort)
{
    return (HDMIRX_HAL_RegReadFldAlign(enPort, RX_DE_LINE1, BIT7_0) + (HDMIRX_HAL_RegReadFldAlign(enPort, RX_DE_LINE2, vid_DELines12_8) << 8));
}

HI_VOID HDMIRX_HAL_SetPdSysEn(HI_UNF_HDMIRX_PORT_E enPort, HI_BOOL bEn)
{
    HI_U32 u32Value;
    if(bEn)
    {
        u32Value = 0x3e;        
    }
    else
    {
        u32Value = 0x15;
    }
    HDMIRX_HAL_RegWrite(enPort, TMDS0_PD_SYS2 + (enPort - HI_UNF_HDMIRX_PORT0)*0x30 , u32Value);
    /*
    if(bEn)
    {
        HDMIRX_HAL_RegWrite(TMDS0_PD_SYS2, 0x3e);
        HDMIRX_HAL_RegWrite(TMDS1_PD_SYS2, 0x3e);
        HDMIRX_HAL_RegWrite(TMDS2_PD_SYS2, 0x3e);
        HDMIRX_HAL_RegWrite(TMDS3_PD_SYS2, 0x3e);
    }
    else
    {
    
        HDMIRX_HAL_RegWrite(TMDS0_PD_SYS2, 0x15);
        HDMIRX_HAL_RegWrite(TMDS1_PD_SYS2, 0x15);
        HDMIRX_HAL_RegWrite(TMDS2_PD_SYS2, 0x15);
        HDMIRX_HAL_RegWrite(TMDS3_PD_SYS2, 0x15);
       
    }
    */
}

HI_VOID HDMIRX_HAL_SetExtEqEn(HI_UNF_HDMIRX_PORT_E enPort, HI_BOOL bMain,HI_BOOL bEn)
{
    if(bEn)
    {
       if(bMain)
       {
            HDMIRX_HAL_RegWriteFldAlign(enPort, Alice0_cntl1, reg_tmds0_ext_eq, 1);
             
       }
       else
       {
        
       }
    }
    else
    {
        if(bMain)
       {
            HDMIRX_HAL_RegWriteFldAlign(enPort, Alice0_cntl1, reg_tmds0_ext_eq, 0);          
       }
       else
       {

       }    
    }
}

/*###########---MHL---###########*/


HI_BOOL HDMIRX_HAL_GetCbusSense(HI_UNF_HDMIRX_PORT_E enPort)
{        
    return HDMIRX_HAL_RegReadFldAlign(enPort, CBUS_STATUS, reg_mhl_cable_present);
}

HI_VOID HDMIRX_HAL_MHLSetCbus1x(HI_UNF_HDMIRX_PORT_E enPort, HI_BOOL bEn)
{
    HDMIRX_HAL_RegWriteFldAlign(enPort, MHL_1X_EN, reg_mhl_1x_en, bEn);
}

HI_VOID HDMIRX_HAL_MHLSetCmd_Offset(HI_UNF_HDMIRX_PORT_E enPort, HI_U32 Cmd_Offset)
{
    HDMIRX_HAL_RegWrite(enPort, MSC_CMD_OR_OFFSET, Cmd_Offset);
}

HI_VOID HDMIRX_HAL_MHLSet1STDATA(HI_UNF_HDMIRX_PORT_E enPort, HI_U32 Data)
{
    HDMIRX_HAL_RegWrite(enPort, MSC_1ST_TRANSMIT_DATA, Data);        
}

HI_VOID HDMIRX_HAL_MHLSet2NDDATA(HI_UNF_HDMIRX_PORT_E enPort, HI_U32 Data)
{
    HDMIRX_HAL_RegWrite(enPort, MSC_2ND_TRANSMIT_DATA, Data);        
}

HI_VOID HDMIRX_HAL_MHLSetBustLen(HI_UNF_HDMIRX_PORT_E enPort, HI_U32 Len)
{
    HDMIRX_HAL_RegWriteFldAlign(enPort, MSC_WRITE_BURST_DATA_LEN, reg_msc_write_burst_len,Len);        
}

HI_VOID HDMIRX_HAL_MHLSetCmdStart(HI_UNF_HDMIRX_PORT_E enPort, HI_U32 u32Startbit)
{
    HDMIRX_HAL_RegWriteFldAlign(enPort, MSC_COMMAND_START, u32Startbit,1);       
}

HI_U32 HDMIRX_HAL_MHLReadReg(HI_UNF_HDMIRX_PORT_E enPort, HDMIRX_MHL_Reg_TYPE Reg_Type)
{
    HI_U32 U32Ret=0;
    switch(Reg_Type)
    {
        case HDMIRX_MHL_CBUS_INT0:
            U32Ret = HDMIRX_HAL_RegRead(enPort, CBUS_INT_0);
            break;
        case HDMIRX_MHL_CBUS_INT1:
            U32Ret = HDMIRX_HAL_RegRead(enPort, CBUS_INT_1);
            break;
        case HDMIRX_MHL_INT0:
            U32Ret = HDMIRX_HAL_RegRead(enPort, MHL_INT_0);
            break;
        case HDMIRX_MHL_STAT_0:
            U32Ret = HDMIRX_HAL_RegRead(enPort, MHL_STAT_0);
            break;
        case HDMIRX_MHL_STAT_1:
            U32Ret = HDMIRX_HAL_RegRead(enPort, MHL_STAT_1);
            break;
        default:
            U32Ret = 0;
            break;
    }
    return U32Ret;
}

HI_VOID HDMIRX_HAL_MHLWriteReg(HI_UNF_HDMIRX_PORT_E enPort, HDMIRX_MHL_Reg_TYPE Reg_Type,HI_U32 U32Ret)
{
    switch(Reg_Type)
    {
        case HDMIRX_MHL_CBUS_INT0:
            HDMIRX_HAL_RegWrite(enPort, CBUS_INT_0,U32Ret);
            break;
        case HDMIRX_MHL_CBUS_INT1:
            HDMIRX_HAL_RegWrite(enPort, CBUS_INT_1,U32Ret);
            break;
        case HDMIRX_MHL_INT0:
            HDMIRX_HAL_RegWrite(enPort, MHL_INT_0,U32Ret);
            break;
        case HDMIRX_MHL_STAT_0:
            HDMIRX_HAL_RegWrite(enPort, MHL_STAT_0,U32Ret);
            break;
        case HDMIRX_MHL_STAT_1:
            HDMIRX_HAL_RegWrite(enPort, MHL_STAT_1,U32Ret);
            break;
        default:
            
            break;
    }    
}

HI_U32 HDMIRX_HAL_MSC_RCVD_1STDATA(HI_UNF_HDMIRX_PORT_E enPort)
{
    return HDMIRX_HAL_RegRead(enPort, MSC_MR_MSC_MSG_RCVD_1ST_DATA );
}

HI_U32 HDMIRX_HAL_MSC_RCVD_2NDDATA(HI_UNF_HDMIRX_PORT_E enPort)
{
    return HDMIRX_HAL_RegRead(enPort, MSC_MR_MSC_MSG_RCVD_2ND_DATA );
}

HI_U32 HDMIRX_HAL_MSCMT_RCVD_DATA0(HI_UNF_HDMIRX_PORT_E enPort)
{
    return HDMIRX_HAL_RegRead(enPort, MSC_MT_RCVD_DATA0);
}

HI_U32 HDMIRX_HAL_MSCMT_RCVD_DATA1(HI_UNF_HDMIRX_PORT_E enPort)
{
    return HDMIRX_HAL_RegRead(enPort, MSC_MT_RCVD_DATA1);
}

HI_BOOL HDMIRX_HAL_GetCBUS_Connected(HI_UNF_HDMIRX_PORT_E enPort)
{
   return HDMIRX_HAL_RegReadFldAlign(enPort, CBUS_STATUS, reg_cbus_connected);
}

HI_U32 HDMIRX_HAL_GetABORT_INT(HI_UNF_HDMIRX_PORT_E enPort, HDMIRX_ABORT_TYPE ABORT_TYPE)
{
    HI_U32 U32Ret=0;
    switch(ABORT_TYPE)
    {
        case HDMIRX_CEC_ABORT:
            U32Ret = HDMIRX_HAL_RegRead(enPort, CEC_ABORT_INT);
            break;
        case HDMIRX_DDC_ABORT:
            U32Ret = HDMIRX_HAL_RegRead(enPort, DDC_ABORT_INT);
            break;
        case HDMIRX_MSC_MR_ABORT:
            U32Ret = HDMIRX_HAL_RegRead(enPort, MSC_MR_ABORT_INT);
            break;
        default:
            break;
    }
    return U32Ret;
}

HI_VOID HDMIRX_HAL_SetABORT_INT(HI_UNF_HDMIRX_PORT_E enPort, HDMIRX_ABORT_TYPE ABORT_TYPE,HI_U32 U32Ret)
{
    
    switch(ABORT_TYPE)
    {
        case HDMIRX_CEC_ABORT:
            HDMIRX_HAL_RegWrite(enPort, CEC_ABORT_INT,U32Ret);
            break;
        case HDMIRX_DDC_ABORT:
            HDMIRX_HAL_RegWrite(enPort, DDC_ABORT_INT,U32Ret);
            break;
        case HDMIRX_MSC_MR_ABORT:
            HDMIRX_HAL_RegWrite(enPort, MSC_MR_ABORT_INT,U32Ret);
            break;
        default:
            break;
    }    
}

HI_VOID HDMIRX_HAL_SetTermMode(HI_UNF_HDMIRX_PORT_E enPort, HDMIRX_TERM_SEL enMode)
{
    HDMIRX_HAL_RegWriteFldAlign(enPort, TMDS0_TERMCTRL0 +(enPort - HI_UNF_HDMIRX_PORT0)*0x30, reg_term_sel_0, enMode);     
}

HI_VOID HDMIRX_HAL_SetTermValue(HI_UNF_HDMIRX_PORT_E enPort, HDMIRX_TERM_CTL enValue)
{
    HDMIRX_HAL_RegWriteFldAlign(enPort, TMDS0_TERMCTRL0 +(enPort - HI_UNF_HDMIRX_PORT0)*0x30, reg_term_ctl0, enValue);     
}

HI_VOID HDMIRX_HAL_SetGPIO5_1(HI_BOOL bEn)
{
#ifdef HI_BOARD_MHL_CHARGE_GPIONUM 
    GPIO_EXT_FUNC_S *pstGpioFunc = NULL;
    HI_S32 s32Ret;
    if (HI_BOARD_MHL_CHARGE_GPIONUM != HI_BOARD_HDMIRX_INVALID)
    {
        /* Use GPIO control tuner AGC select */
        printk("Rst Change GPIO5_1 \n");
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_GPIO, (HI_VOID**)(&pstGpioFunc));
        if (HI_SUCCESS != s32Ret)
        {
            printk("SetMhlEn:Get gpio function failure!\n");
            return;
        }
    	if (!pstGpioFunc ||
    	!pstGpioFunc->pfnGpioDirSetBit ||
    	!pstGpioFunc->pfnGpioWriteBit )
        {
            printk("SetMhlEn:GPIO not found\n");
            return;
        }        
        s32Ret = pstGpioFunc->pfnGpioDirSetBit(HI_BOARD_MHL_CHARGE_GPIONUM, HI_FALSE);  // output
        if(bEn == HI_TRUE)
        {
            s32Ret |= pstGpioFunc->pfnGpioWriteBit(HI_BOARD_MHL_CHARGE_GPIONUM, HI_BOARD_MHL_CHARGE_ON);
        }
        else
        {
            s32Ret |= pstGpioFunc->pfnGpioWriteBit(HI_BOARD_MHL_CHARGE_GPIONUM, HI_BOARD_MHL_CHARGE_OFF);
        }
        if (HI_SUCCESS != s32Ret)
        {       
            printk("SetMhlEn:Call Gpio function failure!\n");
            return ;
        }    
    }
#endif    
}

HI_VOID HDMIRX_HAL_SetMhlEn(HI_BOOL bEn)
{   
#ifdef HI_BOARD_MHL_CHARGE_GPIONUM 
    HI_S32 s32Ret;
    GPIO_EXT_FUNC_S *pstGpioFunc = NULL;
#endif
    if(bEn == HI_FALSE)
    { 
        HDMIRX_HAL_SetTermMode(HI_UNF_HDMIRX_PORT0, HDMIRX_TERM_SEL_HDMI);
        HDMIRX_HAL_SetTermValue(HI_UNF_HDMIRX_PORT0, HDMIRX_TERM_CTL_45);
        HDMIRX_HAL_SetHpdLevel(HI_UNF_HDMIRX_PORT0,HI_TRUE);
        //HDMIRX_HAL_SetHpdManual(HI_UNF_HDMIRX_PORT0, HI_FALSE);
    }
    else
    {
       
        HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT0, DPLL_MULTZONE_CTRL,ri_vcocal_in,0);
        HDMIRX_HAL_SetTermValue(HI_UNF_HDMIRX_PORT0, HDMIRX_TERM_CTL_48);
        HDMIRX_HAL_SetTermMode(HI_UNF_HDMIRX_PORT0, HDMIRX_TERM_SEL_MHL);
        HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT0, TMDS0_TERMCTRL0, reg0_eq_noise_dec,0);        
        HDMIRX_HAL_SetHpdManual(HI_UNF_HDMIRX_PORT0, HI_FALSE);
     //   printk("\n#############HAL MHL Reset!\n");
        //return;
        /*
        HDMIRX_HAL_SetResetEn(HI_UNF_HDMIRX_PORT0, HDMIRX_BUS_RST, HI_TRUE);
        udelay(40);
        HDMIRX_HAL_SetResetEn(HI_UNF_HDMIRX_PORT0, HDMIRX_BUS_RST, HI_FALSE);
        HDMIRX_HAL_SetHpdLevel(HI_UNF_HDMIRX_PORT0, HI_FALSE);
        msleep(400);
        HDMIRX_HAL_SetHpdLevel(HI_UNF_HDMIRX_PORT0, HI_TRUE);
        msleep(200);
        HDMIRX_HAL_SetHpdManual(HI_UNF_HDMIRX_PORT0, HI_FALSE);
        */
    }
#ifdef HI_BOARD_MHL_CHARGE_GPIONUM   
    if (HI_BOARD_MHL_CHARGE_GPIONUM != HI_BOARD_HDMIRX_INVALID)
    {
        /* Use GPIO control tuner AGC select */
        printk("Change GPIO5_1 \n");
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_GPIO, (HI_VOID**)(&pstGpioFunc));
        if (HI_SUCCESS != s32Ret)
        {
            printk("SetMhlEn:Get gpio function failure!\n");
            return;
        }
    	if (!pstGpioFunc ||
    	!pstGpioFunc->pfnGpioDirSetBit ||
    	!pstGpioFunc->pfnGpioWriteBit )
        {
            printk("SetMhlEn:GPIO not found\n");
            return;
        }        
        s32Ret = pstGpioFunc->pfnGpioDirSetBit(HI_BOARD_MHL_CHARGE_GPIONUM, HI_FALSE);  // output
        if(bEn == HI_TRUE)
        {
            s32Ret |= pstGpioFunc->pfnGpioWriteBit(HI_BOARD_MHL_CHARGE_GPIONUM, HI_BOARD_MHL_CHARGE_ON);
        }
        else
        {
            s32Ret |= pstGpioFunc->pfnGpioWriteBit(HI_BOARD_MHL_CHARGE_GPIONUM, HI_BOARD_MHL_CHARGE_OFF);
        }
        if (HI_SUCCESS != s32Ret)
        {       
            printk("SetMhlEn:Call Gpio function failure!\n");
            return ;
        }    
    } 
#endif
}

HI_VOID HDMIRX_HAL_MHL_SENSE_Enable(HI_BOOL bEn)
{
    HI_VOID *pvMcuMux =(HI_VOID *) ioremap_nocache(0xf8008000 , 0x100);
    if(bEn)
    {
        *(volatile HI_U32 *)(pvMcuMux + 0x0c) = 2;
    }
    else
    {
        HI_S32 s32Ret;
        GPIO_EXT_FUNC_S *pstGpioFunc = NULL;
        *(volatile HI_U32 *)(pvMcuMux + 0x0c) = 1;
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_GPIO, (HI_VOID**)(&pstGpioFunc));
        if (HI_SUCCESS != s32Ret)
        {
            printk("SetMhlSENSE:Get gpio function failure!\n");
            return;
        }
    	if (!pstGpioFunc ||
    	!pstGpioFunc->pfnGpioDirSetBit ||
    	!pstGpioFunc->pfnGpioWriteBit )
        {
            printk("SetMhlEn:GPIO not found\n");
            return;
        }        
        s32Ret = pstGpioFunc->pfnGpioDirSetBit((18*8+6), HI_FALSE);  // output
        s32Ret |= pstGpioFunc->pfnGpioWriteBit((18*8+6), 0);
    }

}

HI_VOID HDMIRX_HAL_MHLDevcapInit(HI_UNF_HDMIRX_PORT_E enPort, HI_U32 u32Addr , HI_U32 u32Value)
{
    HDMIRX_HAL_RegWrite(enPort, u32Addr,u32Value);    
}

HI_VOID HDMIRX_HAL_MhlChRstEn(HI_BOOL bEn)
{
    if(bEn)
    {
        HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT0, RX_CBUS_CH_RST_CTRL,reg_mhl_disc_sw_rst,1);
    }
    else
    {
        HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT0, RX_CBUS_CH_RST_CTRL,reg_mhl_disc_sw_rst,0);
    }
}

HI_VOID HDMIRX_HAL_MHLRstEn(HI_BOOL bEn)
{
    if(bEn)
    {
      //  HDMIRX_HAL_SetTermMode(HI_UNF_HDMIRX_PORT0, HDMIRX_TERM_SEL_OPEN);
        HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT0,HPD_PE_CTRL,BIT0,0);
        HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT0,HPD_PU_CTRL,BIT0,1);
        HDMIRX_HAL_SetHpdManual(HI_UNF_HDMIRX_PORT0,HI_TRUE);
    }
    else
    {
      //  HDMIRX_HAL_SetTermMode(HI_UNF_HDMIRX_PORT0, HDMIRX_TERM_SEL_MHL);
        HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT0,HPD_PE_CTRL,BIT0,0);
        HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT0,HPD_PU_CTRL,BIT0,0);
        HDMIRX_HAL_SetHpdManual(HI_UNF_HDMIRX_PORT0,HI_TRUE);
        msleep(50);
        HDMIRX_HAL_SetHpdManual(HI_UNF_HDMIRX_PORT0,HI_FALSE);
    }
}

HI_VOID HDMIRX_HAL_MHLInit(HI_UNF_HDMIRX_PORT_E enPort)
{

    HDMIRX_HAL_RegWriteFldAlign(enPort, RX_HDMIM_CP_CTRL, reg_force_hdmim_mode0, 0);
    
   // Enable the VS commands, all interrupts, and clear legacy
    HDMIRX_HAL_RegWrite(enPort, CBUS_INT_0_MASK, 0xFF);      // Enable desired interrupts
    HDMIRX_HAL_RegWrite(enPort, CBUS_INT_1_MASK, 0x4C);      // Enable desired interrupts  
    //add 20140408   
    
    HDMIRX_HAL_RegWriteFldAlign(enPort, TMDST_TXDAT1,ri_vcocal_def_mhl1x,0xE);
    HDMIRX_HAL_RegWriteFldAlign(enPort, PLL0_VCOCAL,reg_pll0_vcocal_def,0x07);
    HDMIRX_HAL_RegWriteFldAlign(enPort, TMDS0_CTRL2,reg_hdmi_rx0_lobw,1);
   // HDMIRX_HAL_RegWriteFldAlign(TMDS0_CTRL2,reg_mhl_test_soft_ctrl,1);
    HDMIRX_HAL_RegWrite(enPort, mhl1x_eq_data0, 0x26);
    HDMIRX_HAL_RegWrite(enPort, mhl1x_eq_data1, 0x46);
    HDMIRX_HAL_RegWrite(enPort, mhl1x_eq_data2, 0x26);
    HDMIRX_HAL_RegWrite(enPort, mhl1x_eq_data3, 0x54);
    HDMIRX_HAL_RegWriteFldAlign(enPort, RX_RSEN_CTRL, NVRAM_mhl_hpd_en, 1);
   // HDMIRX_HAL_RegWriteFldAlign(enPort, 0x27E0,BIT3,1);
    HDMIRX_HAL_RegWriteFldAlign(enPort, pauth_num_smps, ri_mhl1x_eq_en, 1);
    HDMIRX_HAL_MhlChRstEn(HI_TRUE);
    msleep(100);
    
    
    
}
/*###########---MHL---###########*/
#if SUPPORT_DOUBLE_CTRL
HI_VOID HDMIRX_HAL_SetAudioMux(HI_UNF_HDMIRX_PORT_E enPort)
{
    volatile U_PERI_RESERVED PERI_RESERVED;
    HI_U32 u32Value;
    PERI_RESERVED.u32 = g_pstRegPeri->PERI_RESERVED.u32;
    if(enPort == HI_UNF_HDMIRX_PORT0)
    {
        u32Value = 0;          
    }
    else
    {
        u32Value = 1;           
    }
    PERI_RESERVED.bits.peri_hdmirx_i2s_sel = u32Value;
    PERI_RESERVED.bits.peri_arc_sel = u32Value;
    g_pstRegPeri->PERI_RESERVED.u32 = PERI_RESERVED.u32;   
}
#endif

HI_U32 HDMIRX_HAL_GetHactive(HI_UNF_HDMIRX_PORT_E enPort)
{
    return (HDMIRX_HAL_RegReadFldAlign(enPort, RX_DE_PIX1, BIT7_0) + (HDMIRX_HAL_RegReadFldAlign(enPort, RX_DE_PIX2, vid_DEPixels12_8) << 8));
}

#ifndef HI_FPGA
HI_VOID HDMIRX_HAL_CrgInit(HI_VOID)
{
    volatile U_PERI_CRG120 PERI_CRG120;
#if SUPPORT_DOUBLE_CTRL    
    volatile U_PERI_CRG152 PERI_CRG152;
#endif
    volatile U_SC_CLKGATE_SRST_CTRL SC_CLKGATE_SRST_CTRL;
    volatile U_SC_HDMI_RX_HPD_PWR_PCTRL SC_HDMI_RX_HPD_PWR_PCTRL;
    
    PERI_CRG120.u32 = g_pstRegCrg->PERI_CRG120.u32;
    PERI_CRG120.bits.hdmirxphy_tmds_div20sync_cken = 0x0f;
    PERI_CRG120.bits.hdmirxphy_pre_pll_cken = 0x0f;
    PERI_CRG120.bits.hdmirxphy_tmds_clk1x_cken = 0x0f;
    PERI_CRG120.bits.hdmirxphy_dp_clr_cken = 0x0f;
    g_pstRegCrg->PERI_CRG120.u32 = PERI_CRG120.u32;
    
#if SUPPORT_DOUBLE_CTRL
    PERI_CRG152.u32 = g_pstRegCrg->PERI_CRG152.u32;
    PERI_CRG152.bits.hdmirx_osc_cken = 1;
    PERI_CRG152.bits.hdmirx_edid_cken = 1;
    PERI_CRG152.bits.hdmirx_cbus_cken = 1;
    PERI_CRG152.bits.hdmirx_cec_cken = 1;
    PERI_CRG152.bits.hdmirx_apb_cken = 1;
    PERI_CRG152.bits.hdmirx_mpllref_cken =1;
    PERI_CRG152.bits.hdmirx_mpllref_pll_cken =1;
    PERI_CRG152.bits.hdmirx_mosc_cken =1;
    PERI_CRG152.bits.hdmirx_mosc_cksel = 1;//0;
    PERI_CRG152.bits.hdmirx_cbus_cksel = 1;
    PERI_CRG152.bits.hdmirx_cec_cksel = 0;
    PERI_CRG152.bits.hdmirx_mpllref_cksel = 1;
    g_pstRegCrg->PERI_CRG152.u32 = PERI_CRG152.u32;
    
#endif    
//    g_pstRegCrg->PERI_CRG124.bits.mpll_hdmi_cfg_bypass = 0;

    SC_CLKGATE_SRST_CTRL.u32 = g_pstRegSysCtrl->SC_CLKGATE_SRST_CTRL.u32;
    SC_CLKGATE_SRST_CTRL.bits.hdmirx_mpllref_cksel = 1;
    SC_CLKGATE_SRST_CTRL.bits.hdmirx_cec_cksel = 0;
    SC_CLKGATE_SRST_CTRL.bits.hdmirx_cbus_cksel = 1;
    SC_CLKGATE_SRST_CTRL.bits.hdmirx_mosc_cken = 1;
    g_pstRegSysCtrl->SC_CLKGATE_SRST_CTRL.u32 = SC_CLKGATE_SRST_CTRL.u32;    

    SC_HDMI_RX_HPD_PWR_PCTRL.u32 = g_pstRegSysCtrl->SC_HDMI_RX_HPD_PWR_PCTRL.u32;   
#if (defined(CHIP_TYPE_hi3796cv100)||defined(CHIP_TYPE_hi3796cv100_a)|| defined(CHIP_TYPE_hi3798cv100)\
        || defined(CHIP_TYPE_hi3798cv100_a))
    SC_HDMI_RX_HPD_PWR_PCTRL.bits.hdmi_rx_hpd_pctrl = 0x0e;
    SC_HDMI_RX_HPD_PWR_PCTRL.bits.hdmi_rx_pwr_pctrl = 0x0e;
#else
    if (HI_BOARD_HDMIRX_HPD_INVERT == HI_TRUE)
    {
        SC_HDMI_RX_HPD_PWR_PCTRL.bits.hdmi_rx_hpd_pctrl = 0x0e;
    }
    else
    {
        SC_HDMI_RX_HPD_PWR_PCTRL.bits.hdmi_rx_hpd_pctrl = 0;
    }
    
    if (HI_BOARD_HDMIRX_PWR_INVERT == HI_TRUE)
    {
        SC_HDMI_RX_HPD_PWR_PCTRL.bits.hdmi_rx_pwr_pctrl = 0x0f;
    }
    else
    {
        SC_HDMI_RX_HPD_PWR_PCTRL.bits.hdmi_rx_pwr_pctrl = 0;
    }
#endif    
    g_pstRegSysCtrl->SC_HDMI_RX_HPD_PWR_PCTRL.u32 = SC_HDMI_RX_HPD_PWR_PCTRL.u32;
    
}
#endif
HI_S32 HDMIRX_HAL_Init(HI_VOID)
{
    HI_U32 Alice0_eq_data_HDMI[8] = {0xA0,0xB0,0xC0,0xB1,0xA2,0xE3,0xC3,0xA0};    
    s_pu32HdmirxRegBase  = (HI_U32)ioremap_nocache(HDMIRX_REGS_ADDR, HDMIRX_REGS_SIZE);
    if (HI_NULL == s_pu32HdmirxRegBase)
    {
        return HI_FAILURE;
    }
#if SUPPORT_DOUBLE_CTRL    
    s_pu32HdmirxRegBase0 = (HI_U32)ioremap_nocache(HDMIRX_REGS0_ADDR, HDMIRX_REGS_SIZE);
    if (HI_NULL == s_pu32HdmirxRegBase0)
    {
        return HI_FAILURE;
    }  
    RegBase[0]=s_pu32HdmirxRegBase0;
#else
    RegBase[0]=s_pu32HdmirxRegBase;
#endif
    RegBase[1]=s_pu32HdmirxRegBase;
    RegBase[2]=s_pu32HdmirxRegBase;
    RegBase[3]=s_pu32HdmirxRegBase;
    
    #ifndef HI_FPGA
    HDMIRX_HAL_CrgInit();
    #endif

    HDMIRX_HAL_SystemRegInit();
    //add 20140407
   // HDMIRX_HAL_SetMhlEn(HI_FALSE);
#if SUPPORT_DOUBLE_CTRL
    HDMIRX_HAL_RegWriteBlock(HI_UNF_HDMIRX_PORT0, Alice0_eq_data0, Alice0_eq_data_HDMI,8);
    HDMIRX_HAL_RegWriteBlock(HI_UNF_HDMIRX_PORT0, Alice1_eq_data0, Alice0_eq_data_HDMI,8);
    HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT0, PLL0_CALREFSEL, reg_pll0_calrefsel, 0x0a);
    HDMIRX_HAL_RegWrite(HI_UNF_HDMIRX_PORT0, PLL1_CALREFSEL,0x0a);
    HDMIRX_HAL_RegWrite(HI_UNF_HDMIRX_PORT0, PLL2_CALREFSEL,0x0a);
    HDMIRX_HAL_RegWrite(HI_UNF_HDMIRX_PORT0, PLL3_CALREFSEL,0x0a);
    HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT0, DPLL_MULTZONE_CTRL,BIT7_4,0x02);
#endif

    HDMIRX_HAL_RegWriteBlock(HI_UNF_HDMIRX_PORT1, Alice0_eq_data0, Alice0_eq_data_HDMI,8);
    HDMIRX_HAL_RegWriteBlock(HI_UNF_HDMIRX_PORT1, Alice1_eq_data0, Alice0_eq_data_HDMI,8);
    HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT1, PLL0_CALREFSEL, reg_pll0_calrefsel, 0x0a);
    HDMIRX_HAL_RegWrite(HI_UNF_HDMIRX_PORT1, PLL1_CALREFSEL,0x0a);
    HDMIRX_HAL_RegWrite(HI_UNF_HDMIRX_PORT1, PLL2_CALREFSEL,0x0a);
    HDMIRX_HAL_RegWrite(HI_UNF_HDMIRX_PORT1, PLL3_CALREFSEL,0x0a);
    HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT1, DPLL_MULTZONE_CTRL,BIT7_4,0x02);

  //  HDMIRX_INPUT_SetHdmiRtEn(HI_UNF_HDMIRX_PORT0, HI_FALSE);
    if(HDMIRX_HAL_GetCbusSense(HI_UNF_HDMIRX_PORT0))
    {
        HDMIRX_HAL_SetTermMode(HI_UNF_HDMIRX_PORT0 ,HDMIRX_TERM_SEL_OPEN);
        //printk("\n#####Get Mhl++++++\n");
    }
    else
    {
        HDMIRX_HAL_SetTermMode(HI_UNF_HDMIRX_PORT0 ,HDMIRX_TERM_SEL_OPEN);
    }
    //HDMIRX_HAL_SetTermMode(HI_UNF_HDMIRX_PORT0 ,HDMIRX_TERM_SEL_OPEN);
    HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT0 ,TMDS0_TERMCTRL0,reg0_eq_bias_rstb,0x01);
    HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT0 ,TMDS0_TERMCTRL0,reg0_eq_noise_dec,0);
    HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT0 ,TMDS0_TERMCTRL0,reg0_pclk_en,0);

#if !SUPPORT_PORT0_ONLY
  //  HDMIRX_INPUT_SetHdmiRtEn(HI_UNF_HDMIRX_PORT1, HI_FALSE);
    HDMIRX_HAL_SetTermMode(HI_UNF_HDMIRX_PORT1 ,HDMIRX_TERM_SEL_OPEN);
    HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT1 ,TMDS1_TERMCTRL0,reg1_eq_bias_rstb,0x01);
    HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT1 ,TMDS1_TERMCTRL0,reg1_eq_noise_dec,0);
    HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT1 ,TMDS1_TERMCTRL0,reg1_pclk_en,0);

 //   HDMIRX_INPUT_SetHdmiRtEn(HI_UNF_HDMIRX_PORT2, HI_FALSE);
    HDMIRX_HAL_SetTermMode(HI_UNF_HDMIRX_PORT2 ,HDMIRX_TERM_SEL_OPEN);
    HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT2 ,TMDS2_TERMCTRL0,reg2_eq_bias_rstb,0x01);
    HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT2 ,TMDS2_TERMCTRL0,reg2_eq_noise_dec,0);
    HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT2 ,TMDS2_TERMCTRL0,reg2_pclk_en,0);

    
 //   HDMIRX_INPUT_SetHdmiRtEn(HI_UNF_HDMIRX_PORT3, HI_FALSE);
    HDMIRX_HAL_SetTermMode(HI_UNF_HDMIRX_PORT3 ,HDMIRX_TERM_SEL_OPEN);
    HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT3 ,TMDS3_TERMCTRL0,reg3_eq_bias_rstb,0x01);
    HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT3 ,TMDS3_TERMCTRL0,reg3_eq_noise_dec,0);
    HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT3 ,TMDS3_TERMCTRL0,reg3_pclk_en,0);
#endif

#if SUPPORT_DOUBLE_CTRL
    HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT0, DEC_AV_MUTE, reg_clear_av_mute, 0);
#endif
    HDMIRX_HAL_RegWriteFldAlign(HI_UNF_HDMIRX_PORT1, DEC_AV_MUTE, reg_clear_av_mute, 0);

    
    return HI_SUCCESS;
}
/*
HI_U32 HDMIRX_HAL_Readtmp(HI_VOID)
{
    return HDMIRX_HAL_RegReadFldAlign(0x1b84, BIT7_5 | BIT4_2);
}
*/

HI_U32 HDMIRX_HAL_GetBchErrCnt(HI_UNF_HDMIRX_PORT_E enPort)
{
    return (HDMIRX_HAL_RegRead(enPort,RX_BCH_ERR) + (HDMIRX_HAL_RegRead(enPort,RX_BCH_ERR2) << 8));
}

HI_U32 HDMIRX_HAL_GetHdcpErrCnt(HI_UNF_HDMIRX_PORT_E enPort)
{
    return (HDMIRX_HAL_RegRead(enPort,RX_HDCP_ERR) + (HDMIRX_HAL_RegRead(enPort,RX_HDCP_ERR2) << 8));
}


#ifdef __cplusplus
 #if __cplusplus
}
 #endif
#endif /* __cplusplus */

