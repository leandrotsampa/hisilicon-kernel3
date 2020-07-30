#include <linux/kthread.h>
#include <linux/init.h>
#include <linux/delay.h>
//#include "int.h"
#include <linux/string.h>

//#include "drv_hdmirx_isr.h"
#include "drv_hdmirx.h"
#include "drv_hdmirx_info.h"
#include "drv_hdmirx_isr.h"
#include "drv_hdmirx_audio.h"
#include "drv_hdmirx_video.h"
#include "hal_hdmirx_reg.h"
#include "hal_hdmirx.h"

extern struct hdmistatus hdmi_ctx;

HI_U8  EDID_TAB[256] = {

    0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x22, 0xE0, 0x30, 0x31, 0xD6, 0x0E, 0x00, 0x00,
    0x20, 0x18, 0x01, 0x03, 0x80, 0x30, 0x1B, 0x78, 0xE8, 0xAB, 0xD5, 0xA5, 0x55, 0x4D, 0x9D, 0x25,
    0x11, 0x50, 0x54, 0x21, 0x08, 0x00, 0xB3, 0x00, 0x81, 0x80, 0x71, 0x40, 0x81, 0xC0, 0x81, 0x00,
    0x95, 0x00, 0x90, 0x40, 0xA9, 0xC0, 0x02, 0x3A, 0x80, 0x18, 0x71, 0x38, 0x2D, 0x40, 0x58, 0x2C,
    0x45, 0x00, 0xFD, 0x1E, 0x11, 0x00, 0x00, 0x1E, 0x21, 0x39, 0x90, 0x30, 0x62, 0x1A, 0x27, 0x40,
    0x68, 0xB0, 0x36, 0x00, 0xFD, 0x1E, 0x11, 0x00, 0x00, 0x1C, 0x00, 0x00, 0x00, 0xFD, 0x00, 0x38,
    0x3D, 0x1E, 0x45, 0x0F, 0x00, 0x0A, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x00, 0x00, 0x00, 0xFC,
    0x00, 0x48, 0x75, 0x61, 0x57, 0x65, 0x69, 0x33, 0x37, 0x39, 0x38, 0x0A, 0x20, 0x20, 0x01, 0x59,
    
    0x02, 0x03, 0x1D, 0xF1, 0x4E, 0x90, 0x04, 0x03, 0x01, 0x14, 0x12, 0x05, 0x1F, 0x10, 0x21, 0x11,
    0x06, 0x02, 0x15, 0x23, 0x09, 0x7F, 0x07, 0x65, 0x03, 0x0C, 0x00, 0x10, 0x00, 0x02, 0x3A, 0x80,
    0x18, 0x71, 0x38, 0x2D, 0x40, 0x58, 0x2C, 0x45, 0x00, 0xDC, 0x0C, 0x11, 0x00, 0x00, 0x1A, 0x01,
    0x1D, 0x80, 0x18, 0x71, 0x1C, 0x16, 0x20, 0x58, 0x2C, 0x25, 0x00, 0xDC, 0x0C, 0x11, 0x00, 0x00,
    0x9E, 0x01, 0x1D, 0x00, 0x72, 0x51, 0xD0, 0x1E, 0x20, 0x6E, 0x28, 0x55, 0x00, 0xDC, 0x0C, 0x11,
    0x00, 0x00, 0x1E, 0x01, 0x1D, 0x80, 0xD0, 0x72, 0x1C, 0x16, 0x20, 0x10, 0x2C, 0x25, 0x80, 0xC4,
    0x8E, 0x21, 0x00, 0x00, 0x9E, 0x02, 0x3A, 0x80, 0xD0, 0x72, 0x38, 0x2D, 0x40, 0x10, 0x2C, 0x45,
    0x20, 0xDC, 0x0C, 0x11, 0x00, 0x00, 0x1E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x39,
};

/****************************************************************************************
    basic function of PHY
*****************************************************************************************/

/*
    function:   enable HPD auto
    input:      switch of hpd auto
                    1: auto
                    0: manual
*/
void HDMI_PHY_HpdAuto(HI_BOOL bEnable)
{
    bEnable = bEnable;
    HDMI_HAL_RegSetBits(RX_HPD_OVRT_CTRL, reg_hpd_ovrt_ctrl, HI_FALSE);
    HDMI_HAL_RegWrite(RX_DUMMY_CONFIG1, 0x01);
    
}

/*
    function:   manual HPD
    input:      level of hpd output
                    1: high levl
                    0: low level
    proc:       a.set the level
                b.enable the pull up
                c.enable the hpd function
                d.enable the manual control
*/
void  HDMI_PHY_ManualHpd(HI_BOOL bLevel)
{
    /* set the hpd level */
    HDMI_HAL_RegSetBits(RX_HPD_C_CTRL, reg_hpd_c_ctrl, bLevel);
    /* the hpd pull up -option */
    HDMI_HAL_RegSetBits(RX_HPD_PU_CTRL, reg_hpd_pu_ctrl, HI_TRUE);
    /* set the hpd pull up -option */
    HDMI_HAL_RegSetBits(RX_HPD_PE_CTRL, reg_hpd_pe_ctrl, HI_TRUE);
    /* enable the hpd ouput function -option */
    HDMI_HAL_RegSetBits(RX_HPD_OEN_CTRL, reg_hpd_oen_ctrl, HI_TRUE);
    /* enable the hpd controlled by manual -option */
    HDMI_HAL_RegSetBits(RX_HPD_OVRT_CTRL, reg_hpd_ovrt_ctrl, HI_TRUE);
}
/****************************************************************************************
    basic function of system
*****************************************************************************************/
/*
    function:   hdmi power on or off
    input:      switch of hdmi power
                    1: power normal
                    0: power off
*/

void HDMI_SYS_PowerOnOff(HI_BOOL bOnOff)
{

    HDMI_HAL_RegWriteFldAlign(RX_SYS_CTRL1, reg_pd_all, bOnOff);
}

/*
    function:   reset hdmi deep color fifo
*/
void HDMI_SYS_DcFifoReset(void)
{
    HDMI_HAL_RegWriteFldAlign(RX_PWD_SRST, dc_fifo_rst, HI_TRUE);
    udelay(4);
    HDMI_HAL_RegWriteFldAlign(RX_PWD_SRST, dc_fifo_rst, HI_FALSE);
}

/*
    function:   hdmi soft reset on or off
    input:      switch of reset
                    1: reset on
                    0: reset off
*/
void HDMI_SYS_SwRstOnOff(HI_BOOL bOnOff)
{
    //return;
    //dump_stack();	
    HDMI_HAL_RegWriteFldAlign(RX_AON_SRST, reg_sw_rst, bOnOff);
}

/*
    function:   hdmi soft reset
*/
void HDMI_SYS_SwReset(void)
{
    HDMI_SYS_SwRstOnOff(HI_TRUE);
    HDMI_SYS_SwRstOnOff(HI_FALSE);
    mdelay(20);
}


/* 
-----------------------------------------------------------------------------
    Function:    HDMI_SYS_DdcOnOff
    Description: for turn on/off ddc.
    Parameters:  bOnOff -> switch of ddc
                    1: ddc on
                    0: ddc off
    Returns:     none

    NOTE: 1. if the Rt is not enable, the ddc can not be on.
-----------------------------------------------------------------------------
*/
void HDMI_SYS_DdcOnOff(HI_BOOL bOnOff)
{
    if ((bOnOff == HI_TRUE) && (hdmi_ctx.bDdcEn == HI_FALSE)) {
        
        if(hdmi_ctx.bRtEn == HI_TRUE) {    
            HDMI_HAL_RegWriteFldAlign(RX_SYS_SWTCHC, reg_ddc_en, HI_TRUE);
        }
    }
    else if ((bOnOff == HI_FALSE) && (hdmi_ctx.bDdcEn == HI_TRUE)) {
        HDMI_HAL_RegWriteFldAlign(RX_SYS_SWTCHC, reg_ddc_en, HI_FALSE);
    }
    hdmi_ctx.bDdcEn = bOnOff;
}

/*
    function:   hdmi input on or off
    input:      switch of port
                    1: pipe on
                    0: pipe off
    proc:       a. if port on, enable ddc and Rt.
                b. if port off, disable ddc and Rt.
*/
void HDMI_SYS_InputOnOff(HI_BOOL bOnOff)
{

    if (bOnOff == HI_TRUE) {
        if((0 != hdmi_ctx.u32RtOffCnt) || hdmi_ctx.bRtOffStart)
		{
			// RxTerm was switched OFF recently and
			// it is not allowed yet enabling it.
			// Delay switching it ON.
			hdmi_ctx.bRtOnReq = HI_TRUE;
		}
		else
		{
		
			if(hdmi_ctx.bDdcEn == HI_TRUE)
			{
				HDMI_HAL_RegWriteFldAlign(RX_SYS_SWTCHC, reg_ddc_en, HI_TRUE);
			}
            else {
                HDMI_HAL_RegWriteFldAlign(RX_SYS_SWTCHC, reg_ddc_en, HI_FALSE);
            }
			//Fei 2 DDC channle in sequoia
     
            HDMI_HAL_RegWriteFldAlign(RX_SYS_SWTCHC, reg_ddc_sda_in_del_en, HI_TRUE);
			
			// TODO: Enable the Rt

			hdmi_ctx.bRtOnReq = HI_FALSE;

			if(HI_FALSE == hdmi_ctx.bRtState)
			{
				hdmi_ctx.bRtState = HI_TRUE;
			}
		}
    }
    else {
        // switch off all RX inputs
		// 080320- including DDC
        // Fei, for Sequoia has 2 DDC channel, should not set 0

		HDMI_HAL_RegWriteFldAlign(RX_SYS_SWTCHC, reg_ddc_en, HI_FALSE);

		// TODO: disable the Rt

		if(HI_TRUE == hdmi_ctx.bRtState)
		{
			hdmi_ctx.bRtOffStart = HI_TRUE;
			hdmi_ctx.bRtOnReq = HI_FALSE;
			hdmi_ctx.bRtState = HI_FALSE;
		}
    }
}

/*
    function:   hdmi pipe on or off
    input:      switch of pipe
                    1: pipe on
                    0: pipe off
    proc:       a. if pipe on, enable ddc and Rt.
                b. if pipe off, disable ddc and Rt.
*/
void HDMI_SYS_DisPipe(void)
{
    #if SUPPORT_AUDIO
    HDMI_AUD_AssertOff();
    #endif
    HDMI_VDO_ResetTimingData();
    HDMI_INFO_ResetData();
    HDMI_SYS_InputOnOff(HI_FALSE);
    hdmi_ctx.bKsvValid = HI_FALSE;
    hdmi_ctx.bAuthStartRequest = HI_FALSE;
    HDMI_VDO_HdmiDviTrans();
    HDMI_HAL_RegWriteFldAlign(RX_PWD_SRST, hdcp_rst_auto, HI_TRUE);
    HDMI_SYS_PowerOnOff(HI_FALSE);
    //HDMIRX_DEBUG("DDC OFF 4 \n");
    //HDMI_SYS_DdcOnOff(HI_FALSE);
}

static void HDMI_HDCP_PrepareRx(void)
{
	HDMI_HAL_RegWrite (RX_BCAPS_SET, reg_hdmi_capable);
	HDMI_ISR_HdcpIntOnOff(HI_FALSE);
}

/* 
------------------------------------------------------------------------------
    Function:    HDMI_HDCP_Reset
    Description: for HDCP FW and module reset.
    Parameters:  none
    Returns:     none

    NOTE: 1. hdcp module reset.
          2. clear the Fw status.
          3. clear Bstatus.
          4. enable for hdcp rx and turn off int of hdcp.
-----------------------------------------------------------------------------
*/
void HDMI_HDCP_Reset(void)
{
    HDMI_HAL_RegSetBits(RX_PWD_SRST, hdcp_rst_auto|hdcp_rst, HI_TRUE);
    udelay(10);
    HDMI_HAL_RegWriteFldAlign(RX_PWD_SRST, hdcp_rst, HI_FALSE);
    hdmi_ctx.bAuthStartRequest = HI_FALSE;
    hdmi_ctx.bKsvValid = HI_FALSE;
    HDMI_HAL_RegWrite(RX_SHD_BSTATUS1, 0);
    HDMI_HDCP_PrepareRx();
    
}

/*
    function:   main routine of Rt
    proc:       to check the Rt is on or not.
*/
void HDMI_SYS_ServeRt(void)
{

	if(hdmi_ctx.bRtOffStart)
	{
		hdmi_ctx.bRtOffStart = HI_FALSE;
		hdmi_ctx.u32RtOffCnt = 2;
	}
	else if(0 != hdmi_ctx.u32RtOffCnt)
	{
        if (hdmi_ctx.u32RtOffCnt > 0) {
            hdmi_ctx.u32RtOffCnt--;
        }
	}

	if((0 == hdmi_ctx.u32RtOffCnt) && hdmi_ctx.bRtOnReq)
	{
		HDMI_SYS_InputOnOff(HI_TRUE);
	}
}

/*
    function:   get the Device id.
*/
void HDMI_SYS_GetDevId(void)
{
    hdmi_ctx.u32DevId = HDMI_HAL_RegRead(RX_DEV_IDL) + (HDMI_HAL_RegRead(RX_DEV_IDH) << 8);
    hdmi_ctx.u32DevicRev = HDMI_HAL_RegRead(RX_DEV_REV);
}

void HDMI_SYS_EdidInit(void)
{
    HI_U16 u16Index;
    
    for (u16Index=0; u16Index<256; u16Index++) {
        HDMI_HAL_RegWrite(EDID_START+(u16Index<<2),EDID_TAB[u16Index]);
    }
}

HI_S32 HDMIRX_DRV_CTRL_UpdateEdid(HI_UNF_HDMIRX_EDID_S *pstEdid)
{
    HI_U16 u16Index;
    
    HDMIRX_CHECK_NULL_PTR(pstEdid);
    
    for (u16Index=0; u16Index<256; u16Index++) 
    {
        EDID_TAB[u16Index] = ((HI_U8) pstEdid->au32Edid[u16Index]);
    }
    return HI_SUCCESS;
    
}




