#ifndef HDMI_BUILD_IN_BOOT
#include <linux/device.h>
#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/fs.h>
#include <asm/uaccess.h>
#include <asm/io.h>
#include <asm/delay.h>
#include <asm/thread_info.h>
#include <linux/poll.h>
#include <linux/interrupt.h>
#include <linux/vmalloc.h>
#include <linux/slab.h>
#include <linux/string.h>
#include <linux/kernel.h>
#include <linux/errno.h>
#include <linux/kthread.h>
#include <linux/timer.h>
#include <linux/delay.h>
#include <linux/string.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/errno.h>
#if defined(CONFIG_HDMI_STB_SDK)
#include "hi_drv_disp.h"
#endif
#include "si_drv_tpg_api.h"
#include "si_lib_seq_api.h"
#include "si_drv_vtg_api.h"
#include "si_drv_pll_vo_api.h"
#include "si_drv_cpi_api.h"
#include "si_lib_video_api.h"
#include "drv_hdmi_platform.h"
#include "drv_hdmi_intf.h"
#endif
#include "si_datatypes.h"
#include "si_lib_time_api.h"
#include "si_drv_tx_api.h"
#include "si_drv_cra_api.h"
#include "si_lib_log_api.h"
#include "si_drv_tx_api.h"
#include "si_drv_tx_regs.h"
#include "si_drv_common.h"
#include "si_lib_malloc_api.h"
#include "hdmi_hal.h"
#include "hdmi_platform.h"
#if defined(CONFIG_HDMI_STB_SDK)
#include "hi_reg_common.h"
#endif

/***** local macro definitions ***********************************************/
#ifdef HDMI_BUILD_IN_BOOT
#include "boot_hdmi_intf.h"
#endif

typedef enum
{
    HDMI_CLK_FROM_CRG,
    HDMI_CLK_FROM_PHY   
}HDMI_CLK_TYPE_E;

#define CHECK_POINTER(p) \
do{                      \
    if(p == HI_NULL){ \
        HDMI_ERR("Error In %s,Line %d\n",__FUNCTION__,__LINE__);       \
        return 1;\
    } \
}while(0)
#define HAL_NULL_CHK_NO_RET(p) \
do{                      \
    if(p == HI_NULL){ \
        HDMI_ERR("%s=null !\n",#p);       \
        return ;\
    } \
}while(0)

#define HDMI_UCONVSTD_2_KCONVSTD(uconvstd, kconvstd) \
do{\
    if (HDMI_CONV_STD_BT_709 == uconvstd)\
    {\
        kconvstd = SII_DRV_TX_CONV_STD__BT_709;\
    }\
    else if (HDMI_CONV_STD_BT_601 == uconvstd)\
    {\
        kconvstd = SII_DRV_TX_CONV_STD__BT_601;\
    }\
    else if (HDMI_CONV_STD_BT_2020_non_const_luminous == uconvstd) \
    {\
        kconvstd = SII_DRV_TX_CONV_STD__BT_2020_non_const_luminous;\
    }\
    else if (HDMI_CONV_STD_BT_2020_const_luminous == uconvstd) \
    {\
        kconvstd = SII_DRV_TX_CONV_STD__BT_2020_const_luminous;\
    }\
    else\
    {\
        kconvstd = SII_DRV_TX_CONV_STD__BUTT;\
    }\
}while(0)

#define HDMI_KCONVSTD_2_UCONVSTD(kconvstd, uconvstd) \
do{\
    if (SII_DRV_TX_CONV_STD__BT_709 == kconvstd)\
    {\
        uconvstd = HDMI_CONV_STD_BT_709;\
    }\
    else if (SII_DRV_TX_CONV_STD__BT_601 == kconvstd)\
    {\
        uconvstd = HDMI_CONV_STD_BT_601;\
    }\
    else if (SII_DRV_TX_CONV_STD__BT_2020_non_const_luminous == kconvstd) \
    {\
        uconvstd = HDMI_CONV_STD_BT_2020_non_const_luminous;\
    }\
    else if (SII_DRV_TX_CONV_STD__BT_2020_const_luminous == kconvstd) \
    {\
        uconvstd = HDMI_CONV_STD_BT_2020_const_luminous;\
    }\
    else\
    {\
        uconvstd = HDMI_CONV_STD_BUTT;\
    }\
}while(0)


/***** local type definitions ************************************************/
static  SiiInst_t instCra = HI_NULL;

#if defined(CONFIG_HDMI_STB_SDK)

SiiDrvPhyPara_t  s_stPhyParam[] = 
{	
    /*data-swing,CLK-swing,src_termination, driver_vnb, clk_src_fine,pll_band_witdth,pll_loop_filter,pll_vco_bias, pll_pi,brg&bias,fine_adj_data,data_drv_ctrl,pll_ldo,pll_zone,pll_charge,in_bgr_reg,reg_zone, rise_time, fall_time*/
	{0x19,      0x1f,     0xd5,          0x02,      0x01,      0x14,         0x32,        0x68,        0x40,0xc4,    0x01,       0x31,       0x06,  0x04,   0x68,     0x0f,     0x03,     0x00,    0x10},	// u32TmdsClk > 27000 && u32TmdsClk < 74250
	{0x19,      0x1f,     0xd5,          0x02,      0x01,      0x14,         0x32,        0x68,        0x40,0xc4,    0x01,       0x31,       0x06,  0x04,   0x68,     0x0f,     0x02,     0x00,    0x10},	// u32TmdsClk >= 74250 && u32TmdsClk < 165000
	{0x20,      0x1f,     0xd5,          0x02,      0x01,      0x14,         0x32,        0x68,        0x40,0xc4,    0x01,       0x31,       0x06,  0x04,   0x68,     0x0f,     0x01,     0x00,    0x10},	// u32TmdsClk >= 165000 && u32TmdsClk < 297000 
	{0x20,      0x1f,     0xd5,          0x02,      0x01,      0x14,         0x32,        0x68,        0x40,0xc4,    0x01,       0x31,       0x06,  0x04,   0x68,     0x0f,     0x01,     0x00,    0x90},	// u32TmdsClk >= 297000 && u32TmdsClk < 340000 
	{0x36,      0x12,     0x7f,          0x02,      0x03,      0x14,         0x32,        0x68,        0x40,0xc4,    0x01,       0x31,       0x06,  0x04,   0x68,     0x0f,     0x00,     0x00,    0x00}, 	// u32TmdsClk >= 340000 && u32TmdsClk < 594000
};

static HI_S32 HalHdmiPhyParamGet(HI_U32 u32PixClk,SiiDrvPhyPara_t **ppstParam)
{
    CHECK_POINTER(ppstParam);

    if (u32PixClk >= FMT_PIX_CLK_13400 && u32PixClk < FMT_PIX_CLK_74250)
    {
        *ppstParam = &s_stPhyParam[0];
    }
    else if (u32PixClk >= FMT_PIX_CLK_74250 && u32PixClk < FMT_PIX_CLK_165000)
    {
        *ppstParam = &s_stPhyParam[1];
    }
    else if(u32PixClk >= FMT_PIX_CLK_165000 && u32PixClk < FMT_PIX_CLK_297000)
    {
        *ppstParam = &s_stPhyParam[2];
    }
    else if(u32PixClk >= FMT_PIX_CLK_297000 && u32PixClk < FMT_PIX_CLK_340000)
    {
        *ppstParam = &s_stPhyParam[3];
    }
    else if (u32PixClk >= FMT_PIX_CLK_340000)
    {
        *ppstParam = &s_stPhyParam[4];
    }
    else
    {
        *ppstParam = &s_stPhyParam[0];
    }
    return HI_SUCCESS;
}


#elif defined(CONFIG_HDMI_BVT_SDK)
SiiDrvPhyPara_t  s_stPhyParam[] = 
{
    /*data-swing,CLK-swing,src_termination, driver_vnb, clk_src_fine,pll_band_witdth,pll_loop_filter,pll_vco_bias, pll_pi,brg&bias,fine_adj_data,data_drv_ctrl,pll_ldo,pll_zone,pll_charge,in_bgr_reg,reg_zone, rise_time, fall_time*/
    {0x16,      0x15,     0x00,          0x02,      0x01,      0x14,         0x02,        0x68,        0x40,0xc4,    0x01,       0x31,       0x06,  0x04,   0x68,     0x0f,     0x03,     0x00,    0x01},  //u32TmdsClk > 13400 && u32TmdsClk <=74250
    {0x16,      0x15,     0x00,          0x02,      0x01,      0x14,         0x02,        0x68,        0x40,0xc4,    0x01,       0x31,       0x06,  0x04,   0x68,     0x0f,     0x02,     0x00,    0x01},  //u32TmdsClk > 74250 && u32TmdsClk <= 165000
    {0x20,      0x1f,     0x55,          0x02,      0x01,      0x14,         0x02,        0x68,        0x40,0xc4,    0x01,       0x31,       0x06,  0x04,   0x68,     0x0f,     0x01,     0xf0,    0xf0},  //u32TmdsClk > 165000 && u32TmdsClk <= 297000
    {0x20,      0x1f,     0x55,          0x02,      0x01,      0x14,         0x02,        0x68,        0x40,0xc4,    0x01,       0x31,       0x06,  0x04,   0x68,     0x0f,     0x01,     0xf0,    0xf0},  //u32TmdsClk > 297000 && u32TmdsClk <= 340000,same as  pre
    {0x36,      0x28,     0xff,          0x02,      0x03,      0x14,         0x02,        0x68,        0x40,0xc4,    0x01,       0x31,       0x06,  0x04,   0x68,     0x0f,     0x00,     0x00,    0x01},  //u32TmdsClk > 340000
};

  
static HI_S32 HalHdmiPhyParamGet(HI_U32 u32PixClk,SiiDrvPhyPara_t **ppstParam)
{
    CHECK_POINTER(ppstParam);

    if (u32PixClk > FMT_PIX_CLK_13400 && u32PixClk <= FMT_PIX_CLK_74250)
    {
        *ppstParam = &s_stPhyParam[0];
    }
    else if (u32PixClk > FMT_PIX_CLK_74250 && u32PixClk <= FMT_PIX_CLK_165000)
    {
        *ppstParam = &s_stPhyParam[1];
    }
    else if(u32PixClk > FMT_PIX_CLK_165000 && u32PixClk <= FMT_PIX_CLK_297000)
    {
        *ppstParam = &s_stPhyParam[2];
    }
    else if(u32PixClk > FMT_PIX_CLK_297000 && u32PixClk <= FMT_PIX_CLK_340000)
    {
        *ppstParam = &s_stPhyParam[3];
    }
    else if (u32PixClk > FMT_PIX_CLK_340000)
    {
        *ppstParam = &s_stPhyParam[4];
    }
    else
    {
        *ppstParam = &s_stPhyParam[0];
    }

    return HI_SUCCESS;
}
#endif

#ifdef HDMI_HDCP_SUPPORT
#define HDMI_HDCP2_CCHK_DONE  (0x1 << 25)
#define HDMI_HDCP2_CUPD_START (0x1 << 15)
#define HDMI_HDCP2_CUPD_DONE  (0x1 << 13)
#define C8051_PRAM_BASE_ADDR  0xf8cf0000

/* 2016.02.23 EC change */
#define HDMI_HDCP2_CUPD_HW    (0x1 << 7)
#define HDMI_HDCP2_PRAM_LOCK_EN (0x1 << 12) // pram write enable
#define HDMI_HDCP2_PRAM_RD_LOCK (0x1 << 13) // pram read enable
#define C8051_PRAM_LENGTH     (4 * 16 * 1024)


static HI_S32 Hdcp22ProgramLoad(HDMI_HAL_S *pstHdmiHal, HI_U32 u32Length, HI_U8 u8BinaryCode[]);
static HI_U8 s_u8C8051Hdcp22Program[] =
{
    #include "c8051_hdcp22_program.bin"
};
#endif

#ifndef HDMI_BUILD_IN_BOOT
#if defined(CONFIG_HDMI_STB_SDK)
static HI_S32 CipherHdmiClkSet(HI_DRV_HDCPKEY_TYPE_E enKeyType)
{
#ifndef HDMI_FPGA_SUPPORT    
    HI_S32 s32Ret = HI_FAILURE;
    CIPHER_EXPORT_FUNC_S* pstCipherExportFuncs = HI_NULL;
    s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_CIPHER, (HI_VOID**)&pstCipherExportFuncs);
    if (s32Ret == HI_FAILURE || pstCipherExportFuncs == HI_NULL || pstCipherExportFuncs->pfnCipherSetHdmiReadClk == HI_NULL)
    {
        HDMI_ERR("Get cipher funcs fail\n");
        return HI_FAILURE;   
    }
    pstCipherExportFuncs->pfnCipherSetHdmiReadClk(enKeyType);
    HDMI_INFO("CipherHdmiClkSet HDMI\n");
#endif    
    return HI_SUCCESS; 
}
#endif

static HI_VOID HalEventCallback(HI_VOID* data, SiiDrvTxEvent_t event)
{
    HDMI_HAL_S *pstHdmiHal = (HDMI_HAL_S *)data;
    HI_BOOL bHotPlug;
    HDMI_EVENT_E enEvent = 0;

    if (pstHdmiHal)
    {
        switch (event)
        {
            case (SII_DRV_TX_EVENT__HOT_PLUG_CHNG | SII_DRV_TX_EVENT__RSEN_CHNG):
                bHotPlug = SiiDrvTxHotPlugStatusGet(pstHdmiHal->stHalCtx.hHdmiHw);
                if (bHotPlug)
                {
                    enEvent = HDMI_EVENT_HOTPLUG;                   
                }
                else
                {
                    enEvent = HDMI_EVENT_HOTUNPLUG;
                }              
                break;
            case SII_DRV_TX_EVENT__HDMI_STATE_CHNG:
                break;
            case SII_DRV_TX_EVENT__HDCP_STATE_CHNG:
            {
             #ifdef HDMI_HDCP_SUPPORT
                SiiDrvHdcpStatus_t hdcpStatus;
                SiiDrvTxHdcpStateStatusGet(pstHdmiHal->stHalCtx.hHdmiHw, &hdcpStatus);
                if (hdcpStatus == SII_DRV_HDCP_STATUS__SUCCESS_1X || hdcpStatus == SII_DRV_HDCP_STATUS__SUCCESS_22)
                {
                    enEvent = HDMI_EVENT_HDCP_SUCCESS;
                }
                else if (hdcpStatus == SII_DRV_HDCP_STATUS__FAILED)
                {
                    enEvent = HDMI_EVENT_HDCP_FAIL;
                }
            #endif                
            }
                break;
            case SII_DRV_CEC_EVENT:
                break;
            case SII_DRV_TX_EVENT_SCRAMBLE_SUCCESS:
                enEvent = HDMI_EVENT_SCRAMBLE_SUCCESS;
                break;            
            case SII_DRV_TX_EVENT_SCRAMBLE_FAIL:
                enEvent = HDMI_EVENT_SCRAMBLE_FAIL;
                break;
            default:
                break;
        }
        
        if (pstHdmiHal->stHalCtx.pCallback && enEvent != 0)
           pstHdmiHal->stHalCtx.pCallback(pstHdmiHal->stHalCtx.hHdmiDev, enEvent);
    }
}  
#endif

HI_U32 *HAL_HDMI_BaseAddrGet(HDMI_HAL_S *pstHdmiHal)
{    
    HI_U32 *pu32Addr = HI_NULL;
    HDMI_INFO("HAL_HDMI_BaseAddrGet in... \n");
#ifndef HDMI_BUILD_IN_BOOT 
    
    pu32Addr = SiiDrvVirtualAddrGet(instCra);
    
#else
    pu32Addr = (HI_U32 *)HDMI_CTRL_BASE_ADDR;
#endif

    HDMI_INFO("HAL_HDMI_BaseAddrGet out... 0x%p\n", pu32Addr);
    return pu32Addr;
}

static HI_VOID HalHdmiSwReset(HDMI_HAL_S *pstHdmiHal, HI_BOOL bReset)
{
#if defined(CONFIG_HDMI_STB_SDK)
        HI_U32 *pu32BaseAddr = HI_NULL;

        pu32BaseAddr = (uint32_t *)HDMI_IO_MAP(HDMI_CRG_BASE_ADDR + 0x210c, 4);

        /* HDMI hw reset */
        *(volatile HI_U32 *)( pu32BaseAddr )= 0x433f;

#ifndef HDMI_BUILD_IN_BOOT        
        msleep(10);
#endif
        *(volatile HI_U32 *)( pu32BaseAddr )= 0x403f;
        HDMI_IO_UNMAP(pu32BaseAddr);

#else
        HI_U32 u32RegValue = 0;
        HI_U32 *pu32BaseAddr = HI_NULL;

        pu32BaseAddr = (uint32_t *)HDMI_IO_MAP(HDMI_CRG_BASE_ADDR, 4); 

        u32RegValue = *(volatile HI_U32 *)( pu32BaseAddr );
        *(volatile HI_U32 *)( pu32BaseAddr ) = u32RegValue | HDMITX_CTRL_SRST_REQ | HDMITX_CTRL_BUS_SRST_REQ;
        msleep(10);
        *(volatile HI_U32 *)( pu32BaseAddr ) = u32RegValue &(~( HDMITX_CTRL_SRST_REQ | HDMITX_CTRL_BUS_SRST_REQ));
        HDMI_IO_UNMAP(pu32BaseAddr);
#endif
#ifndef HDMI_BUILD_IN_BOOT        
        msleep(10);
#endif


 #if 0   
    SiiDrvTxReset(pstHdmiHal->stHalCtx.hHdmiHw, SII_RESET_TYPE__SOFTWARE, bReset);
    SiiDrvTxReset(pstHdmiHal->stHalCtx.hHdmiHw, SII_RESET_TYPE__AUDIO, bReset);
    SiiDrvTxReset(pstHdmiHal->stHalCtx.hHdmiHw, SII_RESET_TYPE__TPI, bReset);
    SiiDrvTxReset(pstHdmiHal->stHalCtx.hHdmiHw, SII_RESET_TYPE__HDCP2x, bReset);
    SiiDrvTxReset(pstHdmiHal->stHalCtx.hHdmiHw, SII_RESET_TYPE__CEC, bReset);
#endif
}

static HI_VOID HalHdmiHwReset(HI_BOOL bReset)
{
#ifndef HDMI_FPGA_SUPPORT   
    HI_U32 u32NewValue = 0;
    volatile HI_VOID* pRegAddr = HI_NULL;
    HI_U32 u32OldValue = 0;

    #if defined(CONFIG_HDMI_STB_SDK)
    pRegAddr = (volatile HI_VOID*)&(g_pstRegCrg->PERI_CRG67.u32);    
    #elif defined(CONFIG_HDMI_BVT_SDK)
    
    pRegAddr = (volatile HI_VOID*)HDMI_IO_MAP(HDMI_CRG_BASE_ADDR, 4);
    #endif
    
    u32OldValue = HdmiRegRead(pRegAddr);
    u32NewValue = u32OldValue;
    if (bReset)
    {
        u32NewValue |= HDMITX_CTRL_SRST_REQ | HDMITX_CTRL_BUS_SRST_REQ;
        HdmiRegWrite(pRegAddr, u32NewValue);
    }
    else
    {
        u32NewValue &= ~(HDMITX_CTRL_SRST_REQ | HDMITX_CTRL_BUS_SRST_REQ);
        HdmiRegWrite(pRegAddr, u32NewValue);
    }  
#ifdef CONFIG_HDMI_BVT_SDK
    HDMI_IO_UNMAP(pRegAddr);
#endif
    
#endif

    return;    
}

static HI_VOID HalHdmiClkSet(HDMI_CLK_TYPE_E enClkType)
{
#ifndef HDMI_FPGA_SUPPORT   
    HI_U32 u32NewValue1 = 0, u32OldValue1 = 0;
    volatile HI_VOID *pRegAddr = HI_NULL;

#if defined(CONFIG_HDMI_STB_SDK)
    HI_U32 u32NewValue2 = 0, u32OldValue2 = 0;

    pRegAddr = (volatile HI_VOID*)&(g_pstRegCrg->PERI_CRG67.u32);

    u32OldValue1 = HdmiRegRead(pRegAddr);
    u32NewValue1 = u32OldValue1;
    u32NewValue1 |= 0x3f;
    if (enClkType == HDMI_CLK_FROM_CRG)
    {
        u32NewValue1 &= ~HDMITX_CTRL_ASCLK_SEL;
        u32NewValue2 |= HDMITX_CTRL_OSCLK_SEL;
    }
    else if (enClkType == HDMI_CLK_FROM_PHY)
    {
        u32NewValue1 |= HDMITX_CTRL_ASCLK_SEL;
        u32NewValue2 &= ~HDMITX_CTRL_OSCLK_SEL;
    }
    
    HdmiRegWrite(pRegAddr, u32NewValue1);

    pRegAddr = (volatile HI_VOID*)&(g_pstRegCrg->PERI_CRG158.u32);    
    u32OldValue2 = HdmiRegRead(pRegAddr);
    u32NewValue2 |= u32OldValue2;
    u32NewValue2 |= 0x7;
    HdmiRegWrite(pRegAddr, u32NewValue2);

#elif defined(CONFIG_HDMI_BVT_SDK)
    pRegAddr = (volatile HI_VOID *)HDMI_IO_MAP(HDMI_CRG_BASE_ADDR, 4);

    u32OldValue1 = HdmiRegRead(pRegAddr);
    u32NewValue1 = u32OldValue1;

    u32NewValue1 |= ( HDMITX_CTRL_AS_CKEN
                    | HDMITX_CTRL_OS_CKEN
                    | HDMITX_CTRL_MHL_CKEN
                    | HDMITX_CTRL_ID_CKEN
                    | HDMITX_CTRL_CEC_CKEN
                    | HDMITX_CTRL_BUS_CKEN );

    if (enClkType == HDMI_CLK_FROM_CRG)
    {
        u32NewValue1 &= ~HDMITX_CTRL_ASCLK_SEL;
        u32NewValue1 |= HDMITX_CTRL_OSCLK_SEL;
        
    }
    else if (enClkType == HDMI_CLK_FROM_PHY)
    {
        u32NewValue1 |= HDMITX_CTRL_ASCLK_SEL;
        u32NewValue1 &= ~HDMITX_CTRL_OSCLK_SEL;
    }

    u32NewValue1 |=  ( HDMITX_CTRL_PIXEL_CKEN 
                     | HDMITX_CTRL_PIXELNX_CKEN
                     | HDMITX_CTRL_XCLK_CKEN );
    HdmiRegWrite(pRegAddr, u32NewValue1);
    HDMI_IO_UNMAP(pRegAddr);
#endif
#endif
    return;
}

//when input is YUV420,idclk need div2. when output is YUV420,pixelnx clk need div2
static HI_VOID HalHdmiClkDivSet(HI_BOOL bIdClkDiv, HI_BOOL bPixelnxClkDiv)
{
#ifndef HDMI_FPGA_SUPPORT     
    HI_U32 u32NewValue = 0, u32OldValue = 0;
    volatile HI_VOID* pRegAddr = HI_NULL;

#if defined(CONFIG_HDMI_STB_SDK)
    pRegAddr = (volatile HI_VOID*)&(g_pstRegCrg->PERI_CRG158.u32);
#elif defined(CONFIG_HDMI_BVT_SDK)
    pRegAddr = (volatile HI_VOID*)HDMI_IO_MAP(HDMI_CRG_BASE_ADDR, 4);
#endif

    u32NewValue = u32OldValue = HdmiRegRead(pRegAddr);
    if (bIdClkDiv)
    {
        u32NewValue |= HDMITX_CTRL_ID_CKSEL;  
    }
    else
    {
        u32NewValue &= ~HDMITX_CTRL_ID_CKSEL;
    }
    
    if (bPixelnxClkDiv)
    {
        u32NewValue |= HDMITX_CTRL_PIXELNX_CKSEL;
    }
    else
    {
        u32NewValue &= ~HDMITX_CTRL_PIXELNX_CKSEL;
    }
    HdmiRegWrite(pRegAddr, u32NewValue);
#ifdef CONFIG_HDMI_BVT_SDK
    HDMI_IO_UNMAP(pRegAddr);
#endif
#endif    
}
    
#ifndef HDMI_BUILD_IN_BOOT
static HI_VOID HalHdmiColorBarEnable(HI_BOOL bEnable)
{
    HI_U32               *pu32RegAddr = HI_NULL;
    HI_U32               u32RegValue = 0;

    
    pu32RegAddr = (HI_U32 *)HDMI_IO_MAP(HDMI_COLOR_BAR_BASE, 4);
    u32RegValue = HdmiRegRead(pu32RegAddr);
    
    if (bEnable)
    {
        u32RegValue |= HDMI_COLOR_BAR_MASK;
        u32RegValue |=HDMI_COLOR_BAR_UPDATE_MASK;
    }
    else
    {
        u32RegValue &= ~HDMI_COLOR_BAR_MASK;
        u32RegValue |=HDMI_COLOR_BAR_UPDATE_MASK;
    }
    HdmiRegWrite(pu32RegAddr, u32RegValue);
    HDMI_IO_UNMAP(pu32RegAddr);

}
#endif

HI_VOID HAL_HDMI_HardwareInit(HDMI_HAL_S *pstHdmiHal)
{
    volatile HI_VOID *u32PeriHdmiTxCtrl = HI_NULL;
    HI_U32 u32Value = 0;

    u32PeriHdmiTxCtrl = (volatile HI_VOID *)HDMI_IO_MAP(PERI_HDMITX_CTRL_ADDR, 4);

#if defined(CONFIG_HDMI_STB_SDK)
    u32Value = HdmiRegRead(u32PeriHdmiTxCtrl) & (~0x1f); //clear bit0~bit4
#elif defined(CONFIG_HDMI_BVT_SDK)
    u32Value = HdmiRegRead(u32PeriHdmiTxCtrl) & (~0x7c0);//0xfffff83f
#endif
    
#ifndef HDMI_BUILD_IN_BOOT    
#if defined(CONFIG_HDMI_STB_SDK)
    CipherHdmiClkSet(HI_DRV_HDCPKEY_TX0);
#endif
#endif
    SiiDrvTxSoftwareInit(pstHdmiHal->stHalCtx.hHdmiHw);
    
    HalHdmiHwReset(HI_TRUE);
    HalHdmiClkSet(HDMI_CLK_FROM_PHY);
    HalHdmiClkDivSet(HI_FALSE, HI_FALSE);
    SiiLibTimeMilliDelay(1);
    HalHdmiHwReset(HI_FALSE);
    SiiLibTimeMilliDelay(1);
    
    HalHdmiSwReset(pstHdmiHal, HI_TRUE);
    SiiLibTimeMilliDelay(1);
    HalHdmiSwReset(pstHdmiHal, HI_FALSE);
    SiiLibTimeMilliDelay(1);
    
    SiiDrvTxHardwareInit(pstHdmiHal->stHalCtx.hHdmiHw);

    u32Value |= HDMI_AUDIO_SOURCE_I2S;
    HdmiRegWrite(u32PeriHdmiTxCtrl, u32Value); 
    
    HDMI_IO_UNMAP(u32PeriHdmiTxCtrl);
};

HI_VOID HAL_HDMI_IrqEnableSet(HDMI_HAL_S *pstHdmiHal, HDMI_INT_TYPE_E enIntType, HI_BOOL bEnable)
{
    SiiDrvTxInterruptEnableSet(pstHdmiHal->stHalCtx.hHdmiHw, enIntType, bEnable);
}
    
#ifndef HDMI_BUILD_IN_BOOT
HI_VOID HAL_HDMI_SequencerHandlerProcess(HDMI_HAL_S *pstHdmiHal)
{
    SiiSequencerHandler();
}

HI_VOID HAL_HDMI_ScdcStatusGet(HDMI_HAL_S  *pstHdmiHal, HDMI_SCDC_STATUS_S *pstScdcStatus)    
{
    SiiScdcStatus_t scdcStatus;
    
    SiiDrvTxHwScdcStatusGet(pstHdmiHal->stHalCtx.hHdmiHw, &scdcStatus);
    /* scdc status*/
    pstScdcStatus->bSinkScrambleOn   = scdcStatus.bSinkScrambleOn;
    pstScdcStatus->bSourceScrambleOn = scdcStatus.bSourceScrambleOn;
    pstScdcStatus->u8TmdsBitClkRatio = scdcStatus.tmdsBitClkRatio;
}

HI_VOID HAL_HDMI_ScdcStatusSet(HDMI_HAL_S  *pstHdmiHal, HDMI_SCDC_STATUS_S *pstScdcStatus)    
{
    SiiScdcStatus_t scdcStatus;
    
    /* scdc status*/
    scdcStatus.bSinkScrambleOn      =     pstScdcStatus->bSinkScrambleOn;
    scdcStatus.bSourceScrambleOn    =     pstScdcStatus->bSourceScrambleOn;
    scdcStatus.tmdsBitClkRatio      =     pstScdcStatus->u8TmdsBitClkRatio;
    SiiDrvTxHwScdcStatusSet(pstHdmiHal->stHalCtx.hHdmiHw, &scdcStatus);
}
HI_VOID HAL_HDMI_HardwareStatusGet(HDMI_HAL_S  *pstHdmiHal, HDMI_HARDWARE_STATUS_S* pstHwStatus)
{
    SiiHardwareStatus_t hwStatus;
    SiiHdmiStatus_t *phdmiStatus = HI_NULL;
    SiiVideoStatus_t *pvideoStatus = HI_NULL;
    HDMI_COMMON_STATUS_S *pstCommonStatus = HI_NULL;
    HDMI_PHY_STATUS_S *pstPhyStatus = HI_NULL;
    HDMI_VIDEO_STATUS_S *pstVideoStatus = HI_NULL;
    HDMI_AUDIO_STATUS_S *pstAudioStatus = HI_NULL;  
    HDMI_INFOFRAME_STATUS_S *pstInfoFrameStatus = HI_NULL;

    if (HI_NULL == pstHwStatus || HI_NULL == pstHdmiHal)
    {
        HDMI_ERR("pstHwStatus=%p pstHdmiHal=%p is invald!!!\n", pstHwStatus, pstHdmiHal);
        return;
    }

    pstCommonStatus = &(pstHwStatus->stCommonStatus);
    pstAudioStatus  = &(pstHwStatus->stAudioStatus);
    pstVideoStatus  = &(pstHwStatus->stVideoStatus);
    pstPhyStatus    = &(pstHwStatus->stPhyStatus);
    pstInfoFrameStatus = &(pstHwStatus->stInfoFrameStatus);

    SiiDrvTxHardwareStatusGet(pstHdmiHal->stHalCtx.hHdmiHw, &hwStatus);
    phdmiStatus = &(hwStatus.hdmiStatus);
    pvideoStatus = &(hwStatus.videoStatus);
        
    pstCommonStatus->bHotPlug    = phdmiStatus->hotPlug;
    pstCommonStatus->bRsen       = phdmiStatus->rsen;
    pstCommonStatus->enTmdsMode  = phdmiStatus->tmdsMode;
    pstCommonStatus->bAvMute     = phdmiStatus->avMute;

    pstAudioStatus->bAudioEnable = phdmiStatus->audioEnable;
    pstAudioStatus->bAudioMute   = phdmiStatus->audioMute;
    pstAudioStatus->enLayout     = phdmiStatus->audioFmt.layout1;
    pstAudioStatus->bDownSample  = phdmiStatus->audioFmt.downSample;

    if (phdmiStatus->audioFmt.i2s)
    {
        pstAudioStatus->enSoundIntf = HDMI_AUDIO_INTERFACE__I2S;
    }
    else if (phdmiStatus->audioFmt.spdif)
    {
        pstAudioStatus->enSoundIntf = HDMI_AUDIO_INTERFACE__SPDIF;
    }
    else if (phdmiStatus->audioFmt.hbrA)
    {
        pstAudioStatus->enSoundIntf = HDMI_AUDIO_INTERFACE__HBRA;
    }
    
    switch (phdmiStatus->audioFmt.audioFs)
    {
        case SII_AUDIO_FS__22_05KHZ:
            pstAudioStatus->enSampleFs = HDMI_SAMPLE_RATE_22K;
            break;
        case SII_AUDIO_FS__24KHZ:
            pstAudioStatus->enSampleFs = HDMI_SAMPLE_RATE_24K;
            break;
        case SII_AUDIO_FS__32KHZ:
            pstAudioStatus->enSampleFs = HDMI_SAMPLE_RATE_32K;
            break;
        case SII_AUDIO_FS__44_1KHZ:
            pstAudioStatus->enSampleFs = HDMI_SAMPLE_RATE_44K;
            break;
        case SII_AUDIO_FS__48KHZ:
            pstAudioStatus->enSampleFs = HDMI_SAMPLE_RATE_48K;
            break;
        case SII_AUDIO_FS__88_2KHZ:
            pstAudioStatus->enSampleFs = HDMI_SAMPLE_RATE_88K;
            break;
        case SII_AUDIO_FS__96KHZ:
            pstAudioStatus->enSampleFs = HDMI_SAMPLE_RATE_96K;
            break;
        case SII_AUDIO_FS__176_4KHZ:
            pstAudioStatus->enSampleFs = HDMI_SAMPLE_RATE_176K;
            break;
        case SII_AUDIO_FS__192KHZ:
            pstAudioStatus->enSampleFs = HDMI_SAMPLE_RATE_192K;
            break;
        case SII_AUDIO_FS__768KHZ:
            pstAudioStatus->enSampleFs = HDMI_SAMPLE_RATE_768K;
            break;
         default:
            break;
    }

    switch (phdmiStatus->channelStatus.i2s_chst4 & 0xf)
    {
		case 0x2:
            pstAudioStatus->enSampleDepth = HDMI_AUDIO_BIT_DEPTH_16;
            break;

		case 0x4:
            pstAudioStatus->enSampleDepth = HDMI_AUDIO_BIT_DEPTH_18;
            break;
	
        case 0xb:
            pstAudioStatus->enSampleDepth = HDMI_AUDIO_BIT_DEPTH_24;
            break;
        
        case 0xa:
            pstAudioStatus->enSampleDepth = HDMI_AUDIO_BIT_DEPTH_20;
            break;
         default:
		 	pstAudioStatus->enSampleDepth = HDMI_AUDIO_BIT_DEPTH_16;
            break;
    }
    
    pstPhyStatus->bPhyPowerOn     = phdmiStatus->phyPower;
    pstPhyStatus->bPhyOe          = phdmiStatus->phyOutput;
    pstPhyStatus->enDeepColor     = phdmiStatus->phyBitDepth;

    memcpy(&(pstPhyStatus->stPhyConfig), &(phdmiStatus->PhyConfig), sizeof(HDMI_PHY_CONFIG_S));
    
    pstVideoStatus->bVideoMute    = pvideoStatus->bVideoMute;
    pstVideoStatus->bIn420Ydemux  = pvideoStatus->in420Ydemux;
    pstVideoStatus->bOut420Ydemux = pvideoStatus->out420Ydemux;
    pstVideoStatus->bRGB2YCbCr    = pvideoStatus->RGB2YUV;
    pstVideoStatus->bYCbCr2RGB    = pvideoStatus->YUV2RGB;
    pstVideoStatus->bYCbCr420_422 = pvideoStatus->YUV420_422;
    pstVideoStatus->bYCbCr422_444 = pvideoStatus->YUV422_444;
    pstVideoStatus->bYCbCr444_422 = pvideoStatus->YUV444_422;
    pstVideoStatus->bYCbCr422_420 = pvideoStatus->YUV422_420; 
    pstVideoStatus->enHvSyncPol   = pvideoStatus->hvSyncPol;
    pstVideoStatus->enOutBitDepth = phdmiStatus->outBitDepth;
    pstVideoStatus->bDither       = pvideoStatus->dither;
    pstVideoStatus->bVSyncPol     = pvideoStatus->bVSyncPol;
    pstVideoStatus->bHSyncPol     = pvideoStatus->bHSyncPol;
    pstVideoStatus->bCSyncPol     = pvideoStatus->bCSyncPol;
    pstVideoStatus->bDEPol        = pvideoStatus->bDEPol;
    pstVideoStatus->bSwapHsCs     = pvideoStatus->bSwapHsCs;
	switch (pvideoStatus->eCscOutQuan)
    {
        case QUANTIZATION_VIDEO_LEVELS:
            pstVideoStatus->eOutCscQuantization = HDMI_QUANTIZATION_RANGE_LIMITED;
            break;
            
        case QUANTIZATION_PC_LEVELS:
        default:
            pstVideoStatus->eOutCscQuantization = HDMI_QUANTIZATION_RANGE_FULL;
            break;
    }

    pstInfoFrameStatus->bVSIFEnable  = phdmiStatus->bIfOn[SII_INFO_FRAME_ID__VS];
    pstInfoFrameStatus->bAVIEnable   = phdmiStatus->bIfOn[SII_INFO_FRAME_ID__AVI]; 
    pstInfoFrameStatus->bSPDEnable   = phdmiStatus->bIfOn[SII_INFO_FRAME_ID__SPD];   
    pstInfoFrameStatus->bAUDIOEnable = phdmiStatus->bIfOn[SII_INFO_FRAME_ID__AUDIO]; 
    pstInfoFrameStatus->bMPEGEnable  = phdmiStatus->bIfOn[SII_INFO_FRAME_ID__MPEG]; 
    pstInfoFrameStatus->bGBDEnable   = phdmiStatus->bIfOn[SII_INFO_FRAME_ID__GBD];
#ifdef HDMI_HDR_SUPPORT
    pstInfoFrameStatus->bDRMEnable   = phdmiStatus->bIfOn[SII_INFO_FRAME_ID__DRM];
    memcpy(pstInfoFrameStatus->u8DRM, phdmiStatus->infoframe[SII_INFO_FRAME_ID__DRM].b, HDMI_INFO_FRAME_MAX_SIZE);
#endif
 
    memcpy(pstInfoFrameStatus->u8AVI,   phdmiStatus->infoframe[SII_INFO_FRAME_ID__AVI].b, HDMI_INFO_FRAME_MAX_SIZE);
    memcpy(pstInfoFrameStatus->u8AUDIO, phdmiStatus->infoframe[SII_INFO_FRAME_ID__AUDIO].b, HDMI_INFO_FRAME_MAX_SIZE);
    memcpy(pstInfoFrameStatus->u8VSIF,  phdmiStatus->infoframe[SII_INFO_FRAME_ID__VS].b, HDMI_INFO_FRAME_MAX_SIZE);
    memcpy(pstInfoFrameStatus->u8SPD,   phdmiStatus->infoframe[SII_INFO_FRAME_ID__SPD].b, HDMI_INFO_FRAME_MAX_SIZE);
    memcpy(pstInfoFrameStatus->u8MPEG,  phdmiStatus->infoframe[SII_INFO_FRAME_ID__MPEG].b, HDMI_INFO_FRAME_MAX_SIZE);
    memcpy(pstInfoFrameStatus->u8GDB,   phdmiStatus->infoframe[SII_INFO_FRAME_ID__GBD].b, HDMI_INFO_FRAME_MAX_SIZE);

    if (pstInfoFrameStatus->bAVIEnable)
    {
        if (!pstVideoStatus->bOut420Ydemux)
        {
            pstVideoStatus->enOutColorSpace = (pstInfoFrameStatus->u8AVI[4] >> 5) & 0x3;
        }
        else
        {
            pstVideoStatus->enOutColorSpace = HDMI_COLORSPACE_YCbCr420;
        }
    }
    else
    {
        pstVideoStatus->enOutColorSpace = HDMI_COLORSPACE_BUTT;
    }
    
   // if (pstCommonStatus->enTmdsMode == HDMI_TMDS_MODE_DVI)
    //{
     //   pstVideoStatus->enOutColorSpace = HDMI_COLORSPACE_RGB;
    //}
    
}

HI_VOID HAL_HDMI_HotPlugStatusGet(HDMI_HAL_S *pstHdmiHal, HI_BOOL* bHotPlug)
{
    SiiHardwareStatus_t hwStatus;
    SiiDrvTxHardwareStatusGet(pstHdmiHal->stHalCtx.hHdmiHw, &hwStatus);
    /* Some TV sometimes has no hotPlug but has rsen*/
    *bHotPlug = hwStatus.hdmiStatus.hotPlug;
}
#endif

#ifdef HDMI_SCDC_SUPPORT
HI_VOID HAL_HDMI_ScdcConfig(HDMI_HAL_S *pstHdmiHal, HDMI_SCDC_CONFIG_S* pstScdcConfig)
{
    SiiModTxScdcSinKCaps_t scdcSinkCaps;
    scdcSinkCaps.bScdcEnable         = pstScdcConfig->bScdcEnable;
    scdcSinkCaps.b3DOsdDisparity     = pstScdcConfig->b3DOsdDisparity;
    scdcSinkCaps.bDc30bit420         = pstScdcConfig->bDc30bit420;
    scdcSinkCaps.bDc36bit420         = pstScdcConfig->bDc36bit420;
    scdcSinkCaps.bDc48bit420         = pstScdcConfig->bDc48bit420;
    scdcSinkCaps.bDualView           = pstScdcConfig->bDualView;
    scdcSinkCaps.bIndependentView    = pstScdcConfig->bIndependentView;
    scdcSinkCaps.bLTE340MscsScramble = pstScdcConfig->bLTE340McscScramble;
    scdcSinkCaps.bReadReqCapable     = pstScdcConfig->bRRCapable;
    scdcSinkCaps.bScdcPresent        = pstScdcConfig->bScdcPresent;
    scdcSinkCaps.vclk_mb             = pstScdcConfig->u32MaxTmdsCharacterRate / 1000000;
    SiiDrvTxScdcConfig(pstHdmiHal->stHalCtx.hHdmiHw, &scdcSinkCaps);
}
#endif

HI_VOID HAL_HDMI_TxCapabilityGet(HDMI_HAL_S *pstHdmiHal,  HDMI_TX_CAPABILITY_S *pstTxCapability)
{
    *pstTxCapability = pstHdmiHal->stHalCtx.stTxCapability;
}


HI_VOID HAL_HDMI_TmdsModeSet(HDMI_HAL_S *pstHdmiHal, HDMI_TMDS_MODE_E enTmdsMode)
{
    SiiTmdsMode_t enTmds = SII_TMDS_MODE__NONE;
    switch(enTmdsMode)
    {
        case HDMI_TMDS_MODE_DVI:
            enTmds = SII_TMDS_MODE__DVI;
            break;
        case HDMI_TMDS_MODE_HDMI_1_4:
            enTmds = SII_TMDS_MODE__HDMI1;
            break;
        case HDMI_TMDS_MODE_HDMI_2_0:
            enTmds = SII_TMDS_MODE__HDMI2;
            break;
        case HDMI_TMDS_MODE_AUTO:
            enTmds = SII_TMDS_MODE__AUTO;
            break;
        default:
            enTmds = SII_TMDS_MODE__NONE;
            break;
    }
   
    SiiDrvTxTmdsModeSet(pstHdmiHal->stHalCtx.hHdmiHw, enTmds);
}


HI_VOID HAL_HDMI_AvMuteSet(HDMI_HAL_S *pstHdmiHal, HI_BOOL bAvMute)
{
    SiiDrvTxAvMuteSet(pstHdmiHal->stHalCtx.hHdmiHw, bAvMute);
}

HI_VOID HAL_HDMI_EmiSet(HDMI_HAL_S *pstHdmiHal, HDMI_EMI_CONFIG_S* pstEmiCfg)
{
    HDMI_EmiSet(pstEmiCfg);
}

HI_VOID HAL_HDMI_EmiStatusGet(HDMI_HAL_S *pstHdmiHal, HDMI_EMI_STATUS_S *pstEmiStatus)
{
    HDMI_EmiStatusGet(pstEmiStatus);
}
#ifndef HDMI_BUILD_IN_BOOT
HI_VOID HAL_HDMI_AudioMuteSet(HDMI_HAL_S *pstHdmiHal, HI_BOOL bAudioMute)
{
    SiiDrvTxAudioMuteSet(pstHdmiHal->stHalCtx.hHdmiHw, bAudioMute);
}

HI_VOID HAL_HDMI_VideoMuteSet(HDMI_HAL_S *pstHdmiHal, HI_BOOL bVideoMute)
{
    SiiDrvTxVideoMuteSet(pstHdmiHal->stHalCtx.hHdmiHw, bVideoMute);
}

HI_VOID HAL_HDMI_BlackDataSet(HDMI_HAL_S *pstHdmiHal, HDMI_BLACK_FRAME_INFO_S *pstBlackPram)
{

    SiiBlackPramInfo_t stBlackPram;
    stBlackPram.bBlacEnable = pstBlackPram->bBlacEnable;
    stBlackPram.inBitDepth = pstBlackPram->inBitDepth;
    stBlackPram.inColorSpace = pstBlackPram->inColorSpace;
    stBlackPram.inQuantization = pstBlackPram->inQuantization;
    
    SiiDrvTxVideoInputPramSet(pstHdmiHal->stHalCtx.hHdmiHw, &stBlackPram);
    SiiDrvTxVideoBlackDataSet(pstHdmiHal->stHalCtx.hHdmiHw, pstBlackPram->bBlacEnable);

    return;
}

HI_VOID HAL_HDMI_Debug(HDMI_HAL_S *pstHdmiHal, HDMI_HAL_DEBUG_CMD_E enDebugCmd,HI_VOID *pData)
{
    
    SiiColorConvertion_t enConvertion ;
    uint32_t             u32DdcSpeed = 0;
    HDMI_HAL_REG_S       *pstReg = HI_NULL;
    SiiDrvPhyPara_t      *pstPhyParam = HI_NULL;
    uint32_t             *pu32Addr = HI_NULL;

    switch(enDebugCmd)
    {
        case HDMI_DEBUG_CMD_COLOR_BAR:
            HAL_NULL_CHK_NO_RET(pData);
            HalHdmiColorBarEnable(*(HI_BOOL *)pData);
            break;
            
        case HDMI_DEBUG_CMD_SW_RESET:
            HalHdmiSwReset(pstHdmiHal, HI_TRUE);
            break;
            
        case HDMI_DEBUG_CMD_RGB2YUV:
            HAL_NULL_CHK_NO_RET(pData);
            enConvertion = *(HI_BOOL *)pData ?  SII_COLORSAPCE_RGB2YUV : SII_COLORSPACE_NO_CONVERT;
            SiiDrvTxYuvRgbConvertion(pstHdmiHal->stHalCtx.hHdmiHw, &enConvertion);
            break;
            
        case HDMI_DEBUG_CMD_YUV2RGB:
            HAL_NULL_CHK_NO_RET(pData);
            enConvertion = *(HI_BOOL *)pData ?  SII_COLORSAPCE_YUV2RGB : SII_COLORSPACE_NO_CONVERT;
            SiiDrvTxYuvRgbConvertion(pstHdmiHal->stHalCtx.hHdmiHw, &enConvertion);
            break;
            
        case HDMI_DEBUG_CMD_DITHER:
            
            break;
            
        case HDMI_DEBUG_CMD_BYPASS:
            HAL_NULL_CHK_NO_RET(pData);
            SiiDrvTxTansCodeBypassConfig(pstHdmiHal->stHalCtx.hHdmiHw,*(bool_t *)pData);
            break;
            
        case HDMI_DEBUG_CMD_DDC_FREQ:
            HAL_NULL_CHK_NO_RET(pData);
            u32DdcSpeed = *(uint32_t *)pData; 
            SiiDrvTxDdcSpeedConfig(pstHdmiHal->stHalCtx.hHdmiHw, u32DdcSpeed);
            break;
            
        case HDMI_DEBUG_CMD_PHY_DEFAULT_GET:
            HAL_NULL_CHK_NO_RET(pData);
            HalHdmiPhyParamGet(pstHdmiHal->stHalCtx.stVideoCfg.u32PixelClk,&pstPhyParam);
            HDMI_MEMCPY(pData,pstPhyParam,sizeof(SiiDrvPhyPara_t));
            break;
            
        case HDMI_DEBUG_CMD_PHY_PARA_SET:
            HAL_NULL_CHK_NO_RET(pData);
            pstPhyParam = (SiiDrvPhyPara_t *)pData;
            SiiDrvTxPhyConfig(pstHdmiHal->stHalCtx.hHdmiHw,pstPhyParam);
            break;
            
        case HDMI_DEBUG_CMD_DUMP:
            HAL_NULL_CHK_NO_RET(pData);
            pstReg  = (HDMI_HAL_REG_S *)pData;            
            pu32Addr = (uint32_t *)HDMI_IO_MAP(pstReg->u32RegAddr, 4);
            pstReg->u32RegVaule = HdmiRegRead((HI_VOID *)pu32Addr);
            HDMI_IO_UNMAP(pu32Addr);
            
            break;
            
        default:
            HDMI_ERR("enDebugCmd = %d\n",enDebugCmd);
            break;
    }
    
    return;
}

#endif

static SiiInfoFrameId_t	s_ifId[HDMI_INFOFRAME_TYPE_BUTT - HDMI_INFOFRAME_TYPE_VENDOR] = 
{
    SII_INFO_FRAME_ID__VS,	
    SII_INFO_FRAME_ID__AVI,
    SII_INFO_FRAME_ID__SPD,
    SII_INFO_FRAME_ID__AUDIO,
    SII_INFO_FRAME_ID__MPEG,
    SII_INFO_FRAME_ID__GBD,
    
#ifdef HDMI_HDR_SUPPORT
    SII_INFO_FRAME_ID__DRM
#endif
};

HI_VOID HAL_HDMI_InfoframeSet(HDMI_HAL_S *pstHdmiHal, HDMI_INFOFRAME_ID_E enInfoFrameId, HI_U8 u8InBuffer[])
{
    SiiInfoFrame_t InfoFrame;
    SiiInfoFrameId_t ifId = s_ifId[enInfoFrameId - HDMI_INFOFRAME_TYPE_VENDOR];

    SiiDrvClearInfoFrame(ifId, &InfoFrame);
    memcpy(InfoFrame.b, u8InBuffer, SII_INFOFRAME_MAX_LEN);
    
    SiiDrvTxInfoframeSet(pstHdmiHal->stHalCtx.hHdmiHw, ifId, &InfoFrame);
}

HI_VOID HAL_HDMI_InfoframeEnableSet(HDMI_HAL_S *pstHdmiHal, HDMI_INFOFRAME_ID_E enInfoFrameId, HI_BOOL bEnable)
{
    SiiInfoFrameId_t ifId = s_ifId[enInfoFrameId - HDMI_INFOFRAME_TYPE_VENDOR];
    SiiDrvTxInfoframeOnOffSet(pstHdmiHal->stHalCtx.hHdmiHw, ifId, bEnable);
}

#ifndef HDMI_BUILD_IN_BOOT

static unsigned char s_chst3aTable[SII_AUDIO_FS__768KHZ + 1] = {0x4,0x6,0x3,0x0,0x2,0x8,0xa,0xc,0x9,0x9};
HI_S32 HAL_HDMI_AudioPathSet(HDMI_HAL_S *pstHdmiHal, HDMI_AUDIO_CONFIG_S* pstAudioCfg)
{
    
    SiiAudioFormat_t AudioFormat = {0};
    SiiChannelStatus_t ChannelStatus = {0};
    HI_U32 u32Value = 0;
	volatile HI_VOID *u32PeriHdmiTxCtrl = HI_NULL;

	u32PeriHdmiTxCtrl = (volatile HI_VOID *)HDMI_IO_MAP(PERI_HDMITX_CTRL_ADDR, 4);
#if defined(CONFIG_HDMI_STB_SDK)
    u32Value = HdmiRegRead(u32PeriHdmiTxCtrl) & (~0x1f); //clear bit0~bit4
#elif defined(CONFIG_HDMI_BVT_SDK)
    u32Value = HdmiRegRead(u32PeriHdmiTxCtrl) & (~0x7c0);//0xfffff83f
#endif

    switch (pstAudioCfg->enSoundIntf)
    {
        case HDMI_AUDIO_INTERFACE__I2S:
            AudioFormat.i2s = HI_TRUE;
            u32Value |= HDMI_AUDIO_SOURCE_I2S;
            HdmiRegWrite(u32PeriHdmiTxCtrl, u32Value);  
            break;
        case HDMI_AUDIO_INTERFACE__SPDIF:
            AudioFormat.spdif = HI_TRUE;
            u32Value |= HDMI_AUDIO_SOURCE_SPDIF;
            HdmiRegWrite(u32PeriHdmiTxCtrl, u32Value); 
            break;            
        case HDMI_AUDIO_INTERFACE__HBRA:
            AudioFormat.hbrA = HI_TRUE;
            u32Value |= HDMI_AUDIO_SOURCE_HBRA;
            HdmiRegWrite(u32PeriHdmiTxCtrl, u32Value);             
            break;
        default : 
            AudioFormat.i2s = HI_TRUE;
            break;
    }

    if (pstAudioCfg->bDownSample)
    {
        AudioFormat.downSample = HI_TRUE;
    }
    
    switch (pstAudioCfg->enSampleFs)
    {
        case HDMI_SAMPLE_RATE_22K:
            AudioFormat.audioFs = SII_AUDIO_FS__22_05KHZ;
            break;
        case HDMI_SAMPLE_RATE_24K:
            AudioFormat.audioFs = SII_AUDIO_FS__24KHZ;
            break;            
        case HDMI_SAMPLE_RATE_32K:
            AudioFormat.audioFs = SII_AUDIO_FS__32KHZ;
            break;
        case HDMI_SAMPLE_RATE_44K:
            AudioFormat.audioFs = SII_AUDIO_FS__44_1KHZ;
            break;
        case HDMI_SAMPLE_RATE_48K:
            AudioFormat.audioFs = SII_AUDIO_FS__48KHZ;
            break;
        case HDMI_SAMPLE_RATE_88K:
            AudioFormat.audioFs = SII_AUDIO_FS__88_2KHZ;
            break;
        case HDMI_SAMPLE_RATE_96K:
            AudioFormat.audioFs = SII_AUDIO_FS__96KHZ;
            break;
        case HDMI_SAMPLE_RATE_176K:
            AudioFormat.audioFs = SII_AUDIO_FS__176_4KHZ;
            break;
        case HDMI_SAMPLE_RATE_192K:
            AudioFormat.audioFs = SII_AUDIO_FS__192KHZ;
            break;
        case HDMI_SAMPLE_RATE_768K:
            AudioFormat.audioFs = SII_AUDIO_FS__768KHZ;
            break;
        default:
            AudioFormat.audioFs = SII_AUDIO_FS__48KHZ;
            break;      
    }
    ChannelStatus.i2s_chst3 = s_chst3aTable[AudioFormat.audioFs];

    switch (pstAudioCfg->enSampleDepth)
    {
        case HDMI_AUDIO_BIT_DEPTH_16:
            ChannelStatus.i2s_chst4 = 0x2;
            break;
        case HDMI_AUDIO_BIT_DEPTH_18:
            ChannelStatus.i2s_chst4 = 0x4;
            break;
        case HDMI_AUDIO_BIT_DEPTH_20:
            ChannelStatus.i2s_chst4 = 0xa;
            break;
        case HDMI_AUDIO_BIT_DEPTH_24:
            ChannelStatus.i2s_chst4 = 0xb;
            break;
        default :
            ChannelStatus.i2s_chst4 = 0x2;
            break;           
    }
    
    AudioFormat.layout1 = pstAudioCfg->enLayout;
    SiiDrvTxChannelStatusSet(pstHdmiHal->stHalCtx.hHdmiHw, &ChannelStatus);
    SiiDrvTxAudioFormatSet(pstHdmiHal->stHalCtx.hHdmiHw, &AudioFormat);
    memcpy(&pstHdmiHal->stHalCtx.stAudioCfg, pstAudioCfg, sizeof(HDMI_AUDIO_CONFIG_S));

    HDMI_IO_UNMAP(u32PeriHdmiTxCtrl);
    
    return HI_SUCCESS;
}

HI_VOID HAL_HDMI_AudioPathEnableSet(HDMI_HAL_S *pstHdmiHal, HI_BOOL bEnable)
{
    SiiDrvTxAudioEnableSet(pstHdmiHal->stHalCtx.hHdmiHw, bEnable);

    return;
}
#endif

static SiiDrvTxClrSpc_t s_clrSpc[HDMI_COLORSPACE_BUTT][HDMI_CONV_STD_BUTT] =
{
    {SII_DRV_TX_CLRSPC__RGB_FULL,SII_DRV_TX_CLRSPC__RGB_FULL,SII_DRV_TX_CLRSPC__RGB_FULL,SII_DRV_TX_CLRSPC__RGB_FULL},
    {SII_DRV_TX_CLRSPC__YC422_709,SII_DRV_TX_CLRSPC__YC422_601,SII_DRV_TX_CLRSPC__YC422_2020,SII_DRV_TX_CLRSPC__YC422_2020},
    {SII_DRV_TX_CLRSPC__YC444_709,SII_DRV_TX_CLRSPC__YC444_601,SII_DRV_TX_CLRSPC__YC444_2020,SII_DRV_TX_CLRSPC__YC444_2020},
    {SII_DRV_TX_CLRSPC__YC420_709,SII_DRV_TX_CLRSPC__YC420_601,SII_DRV_TX_CLRSPC__YC420_2020,SII_DRV_TX_CLRSPC__YC420_2020},
};

HI_S32 HAL_HDMI_VideoPathSet(HDMI_HAL_S *pstHdmiHal, HDMI_VIDEO_CONFIG_S* pstVideoCfg)
{
    HI_BOOL bIdClkDiv = HI_FALSE, bPixelnxClkDiv = HI_FALSE;
    SiiDrvTxColorInfoCfg_t clrInfo;
    SiiDrvTxClrSpc_t clrSpc;
    SiiOutPutSyncCfg_t stOutPutSyncCfg = {0};
    SiiDrvBitDepth_t stBitDepth;

#ifndef HDMI_FPGA_SUPPORT    
    SiiDrvPhyPara_t *pstPhyParam = HI_NULL;
#endif
    CHECK_POINTER(pstHdmiHal);
    CHECK_POINTER(pstVideoCfg);
    
    /* when input is YUV420,idclk need div2. when output is YUV420,pixelnx clk need div2*/
    bIdClkDiv = pstVideoCfg->enInColorSpace == HDMI_COLORSPACE_YCbCr420? HI_TRUE : HI_FALSE ;
    bPixelnxClkDiv = pstVideoCfg->enOutColorSpace == HDMI_COLORSPACE_YCbCr420 ? HI_TRUE : HI_FALSE;

#ifndef HDMI_FPGA_SUPPORT 
    HalHdmiClkDivSet(bIdClkDiv, bPixelnxClkDiv); 
#endif    
    SiiLibTimeMilliDelay(1);    
    
    stOutPutSyncCfg.bVSyncPol = pstVideoCfg->bVSyncPol;
    stOutPutSyncCfg.bHSyncPol = pstVideoCfg->bHSyncPol;
    stOutPutSyncCfg.bDEPol    = pstVideoCfg->bDEPol;
    SiiDrvTxHvSyncPolaritySet(pstHdmiHal->stHalCtx.hHdmiHw, &stOutPutSyncCfg);
    
#ifndef HDMI_FPGA_SUPPORT     
    HalHdmiPhyParamGet(pstVideoCfg->u32PixelClk,&pstPhyParam);
    if (pstPhyParam)
    {
        SiiDrvTxPhyConfig(pstHdmiHal->stHalCtx.hHdmiHw, pstPhyParam);
    }
    else
    {
        HDMI_ERR("get phy param error!\n");
    }
#endif    
    //if (pstVideoCfg->enDeepColor != pstHdmiHal->stHalCtx.stVideoCfg.enDeepColor)
    {
        SiiDrvTxReset(pstHdmiHal->stHalCtx.hHdmiHw, SII_RESET_TYPE__SOFTWARE, HI_TRUE);
        SiiLibTimeMilliDelay(1);
#ifndef HDMI_FPGA_SUPPORT

        switch(pstVideoCfg->enDeepColor)
        {
            case HDMI_DEEP_COLOR_30BIT:
                stBitDepth = SII_DRV_BIT_DEPTH__10_BIT;
                break;
            case HDMI_DEEP_COLOR_36BIT:
                stBitDepth = SII_DRV_BIT_DEPTH__12_BIT;
                break;
            case HDMI_DEEP_COLOR_48BIT:
                stBitDepth = SII_DRV_BIT_DEPTH__16_BIT;
                break;
            default:
                stBitDepth = SII_DRV_BIT_DEPTH__8_BIT;
                break;
        }

        SiiDrvTxOutputBitDepthSet(pstHdmiHal->stHalCtx.hHdmiHw, stBitDepth);
#endif
        SiiLibTimeMilliDelay(1);
        SiiDrvTxReset(pstHdmiHal->stHalCtx.hHdmiHw, SII_RESET_TYPE__SOFTWARE, HI_FALSE);
    }
    /* pattern tpg enbale reg should enable before SiiDrvTxReset to avoid no signal when the blackfame enable. */
    SiiDrvTxPatternTpgEnable(pstHdmiHal->stHalCtx.hHdmiHw, HI_TRUE);

    clrSpc = s_clrSpc[pstVideoCfg->enOutColorSpace][pstVideoCfg->enConvStd];
    if (    (SII_DRV_TX_CLRSPC__RGB_FULL == clrSpc) 
         && (HDMI_QUANTIZATION_RANGE_LIMITED == pstVideoCfg->eOutCscQuantization))
    {
        clrSpc = SII_DRV_TX_CLRSPC__RGB_LIMITED;
    }
    
    SiiDrvTxOutputColorSpaceSet(pstHdmiHal->stHalCtx.hHdmiHw, &clrSpc);

    HDMI_UCONVSTD_2_KCONVSTD(pstVideoCfg->enConvStd, clrInfo.inputClrConvStd);
    clrInfo.inputVidDcDepth = pstVideoCfg->enInBitDepth; // SII_DRV_BIT_DEPTH__10_BIT;
    clrInfo.inputClrSpc = s_clrSpc[pstVideoCfg->enInColorSpace][pstVideoCfg->enConvStd];
    SiiDrvTxColorInfoConfig(pstHdmiHal->stHalCtx.hHdmiHw, &clrInfo);
    
    if (pstVideoCfg->enOutColorSpace != HDMI_COLORSPACE_YCbCr422)
    {
        SiiDrvTxOutputMappingSet(pstHdmiHal->stHalCtx.hHdmiHw,HI_FALSE);
    }
    else
    {
        SiiDrvTxOutputMappingSet(pstHdmiHal->stHalCtx.hHdmiHw,HI_TRUE);
    }
    
    memcpy(&pstHdmiHal->stHalCtx.stVideoCfg, pstVideoCfg, sizeof(HDMI_VIDEO_CONFIG_S));
    return HI_SUCCESS;
}
#if 0
HI_S32 HAL_HDMI_DeepColorSet(HDMI_HAL_S *pstHdmiHal, HDMI_DEEP_COLOR_E enDeepColor)
{
    SiiDrvBitDepth_t bitDepth = SII_DRV_BIT_DEPTH__PASSTHOUGH;

    pstHdmiHal->stHalCtx.stVideoCfg.enDeepColor = enDeepColor;
    switch (enDeepColor)
    {
        case HDMI_DEEP_COLOR_24BIT:
            bitDepth = SII_DRV_BIT_DEPTH__8_BIT;
            break;
        case HDMI_DEEP_COLOR_30BIT:
            bitDepth = SII_DRV_BIT_DEPTH__10_BIT;
            break;
        case HDMI_DEEP_COLOR_36BIT:
            bitDepth = SII_DRV_BIT_DEPTH__12_BIT;
            break;
        case HDMI_DEEP_COLOR_48BIT:
            bitDepth = SII_DRV_BIT_DEPTH__16_BIT;
            break;
        default:
            bitDepth = SII_DRV_BIT_DEPTH__8_BIT;
            break;
    }
    SiiDrvTxReset(pstHdmiHal->stHalCtx.hHdmiHw, SII_RESET_TYPE__SOFTWARE, HI_TRUE);
    SiiDrvTxOutputBitDepthSet(pstHdmiHal->stHalCtx.hHdmiHw, bitDepth);
    SiiDrvTxReset(pstHdmiHal->stHalCtx.hHdmiHw, SII_RESET_TYPE__SOFTWARE, HI_FALSE);
    return 0;
}
#endif

#ifdef HDMI_HDCP_SUPPORT
HI_VOID HAL_HDMI_HdcpEnableSet(HDMI_HAL_S *pstHdmiHal, HI_BOOL bEnable)
{ 
    if (bEnable)
    {
        /* select clk of hdmi*/
        CipherHdmiClkSet(HI_DRV_HDCPKEY_TX0);
    }
    SiiDrvTxHdcpProtectionSet(pstHdmiHal->stHalCtx.hHdmiHw, bEnable);
}

HI_S32 HAL_HDMI_HdcpModeSet(HDMI_HAL_S *pstHdmiHal, HDMI_HDCP_MODE_E enHdcpMode)
{
    SiiModDsHdcpVersion_t hdcpVer = SII_DRV_DS_HDCP_VER__1X;
    
    if (enHdcpMode == HDMI_HDCP_MODE_2_2)
    {
        hdcpVer = SII_DRV_DS_HDCP_VER__22;
        if (HI_SUCCESS != Hdcp22ProgramLoad(pstHdmiHal, sizeof(s_u8C8051Hdcp22Program), s_u8C8051Hdcp22Program))
        {
            HDMI_ERR("Load c8051 Hdcp2.2 program fail!!!\n");
            return HI_FAILURE;
        }
    }
    SiiDrvTxHdcpVersionSet(pstHdmiHal->stHalCtx.hHdmiHw, hdcpVer);
    return HI_SUCCESS;
}

HI_VOID HAL_HDMI_SinkHdcp22CapabilityGet(HDMI_HAL_S *pstHdmiHal, HI_BOOL* bSupport)
{
    SiiDrvTxHdcp22CapabilityGet(pstHdmiHal->stHalCtx.hHdmiHw, bSupport);
}

static HI_S32 Hdcp22ProgramLoad(HDMI_HAL_S *pstHdmiHal, HI_U32 u32Length, HI_U8 u8BinaryCode[])
{
    HI_S32 timeout = 3000;
    HI_U32 value = 0, u32Len = 0;
    HI_S32 ret = HI_SUCCESS;
    volatile HI_U32 *pu32VirAddr = HI_NULL;
 
    volatile HI_U32 *u32PeriHdmiTxCtrl = (HI_U32 *)HDMI_IO_MAP(PERI_HDMITX_CTRL_ADDR, 4);
    volatile HI_U32 *u32HdmiHdcp2xCtrl = (HI_U32 *)HDMI_IO_MAP(PERI_HDMITX_AVCTTPT, 4);
                
    CHECK_POINTER(pstHdmiHal);
    /* enable pram readable and writeable */
    value = HdmiRegRead(u32HdmiHdcp2xCtrl);
    value &= ~(HDMI_HDCP2_PRAM_LOCK_EN | HDMI_HDCP2_PRAM_RD_LOCK);
    HdmiRegWrite(u32HdmiHdcp2xCtrl, value);
    
    /* reset hdcp2.2*/
    SiiDrvTxReset(pstHdmiHal->stHalCtx.hHdmiHw, SII_RESET_TYPE__HDCP2x, HI_TRUE);
    SiiLibTimeMilliDelay(5);
    SiiDrvTxReset(pstHdmiHal->stHalCtx.hHdmiHw, SII_RESET_TYPE__HDCP2x, HI_FALSE);

    /* hdcp2tx_cupd_start high*/
    value = HdmiRegRead(u32PeriHdmiTxCtrl);
    value |= HDMI_HDCP2_CUPD_START;
    HdmiRegWrite(u32PeriHdmiTxCtrl, value);
    SiiLibTimeMilliDelay(2);
    /* hdcp2tx_cupd_hw high*/
    value = HdmiRegRead(u32HdmiHdcp2xCtrl);
    value |= HDMI_HDCP2_CUPD_HW;
    HdmiRegWrite(u32HdmiHdcp2xCtrl, value);
    SiiLibTimeMilliDelay(2);
    
    /* write PRAM*/
    /********************************************************/
    pu32VirAddr = (HI_U32 *)HDMI_IO_MAP(C8051_PRAM_BASE_ADDR, C8051_PRAM_LENGTH);
    while (u32Len < u32Length)
    {
        HdmiRegWrite(pu32VirAddr + u32Len, u8BinaryCode[u32Len]);
        u32Len++;
    }

    /********************************************************/
    
    /* hdcp2tx_cupd_hw   low */
    value = HdmiRegRead(u32HdmiHdcp2xCtrl);
    value &= ~HDMI_HDCP2_CUPD_HW;
    HdmiRegWrite(u32HdmiHdcp2xCtrl, value);
    SiiLibTimeMilliDelay(2);
    /* hdcp2tx_cupd_done  high*/
    value = HdmiRegRead(u32PeriHdmiTxCtrl);
    value |= HDMI_HDCP2_CUPD_DONE;
    HdmiRegWrite(u32PeriHdmiTxCtrl, value);
    SiiLibTimeMilliDelay(2);
    
    /* hdcp2tx_cchk_done  high*/
    while (!(HDMI_HDCP2_CCHK_DONE & HdmiRegRead(u32PeriHdmiTxCtrl)) && --timeout > 0)
    {
        SiiLibTimeMilliDelay(1);   
    }

    if (!timeout && !(HDMI_HDCP2_CCHK_DONE & HdmiRegRead(u32PeriHdmiTxCtrl)))
    {
       ret = HI_FAILURE;
       HDMI_ERR("Hdcp2.2 check done error\n");
    }
    else
    {
        SiiDrvHdcp2xCupdChkStat_t hdcp2xCupdStat;
        SiiDrvTxHdcp2xCupdStatusGet(pstHdmiHal->stHalCtx.hHdmiHw, &hdcp2xCupdStat);
        if (SII_DRV_HDCP2X_CUPD_CHK__FAIL == hdcp2xCupdStat)
        {
            HDMI_ERR("Hdcp2.2 cupd check fail\n");
            ret = HI_FAILURE;
        }
    }
    
    /* hdcp2tx_cupd_done low*/
    value = HdmiRegRead(u32PeriHdmiTxCtrl);
    value &= ~HDMI_HDCP2_CUPD_DONE;
    HdmiRegWrite(u32PeriHdmiTxCtrl, value);
    SiiLibTimeMilliDelay(2);
    /* hdcp2tx_cupd_start low*/
    value = HdmiRegRead(u32PeriHdmiTxCtrl);
    value &= ~HDMI_HDCP2_CUPD_START;
    HdmiRegWrite(u32PeriHdmiTxCtrl, value); 

    HDMI_IO_UNMAP(pu32VirAddr);
    HDMI_IO_UNMAP(u32HdmiHdcp2xCtrl);
    HDMI_IO_UNMAP(u32PeriHdmiTxCtrl);

    return ret;
}
#endif

//HI_S32 (*HAL_HDMI_HdcpKsvListGet)(HDMI_HAL_S *pstHdmiHal, HDMI_HDCP_KSVLIST_S* pstKsvList);
HI_VOID HAL_HDMI_PhyOutputEnableSet(HDMI_HAL_S *pstHdmiHal, HI_BOOL bEnable)
{
#ifndef HDMI_FPGA_SUPPORT    
    SiiDrvTxPhyOutputEnableSet(pstHdmiHal->stHalCtx.hHdmiHw, bEnable);
#endif
}


HI_VOID HAL_HDMI_PhyPowerEnableSet(HDMI_HAL_S *pstHdmiHal, HI_BOOL bEnable)
{
#ifndef HDMI_FPGA_SUPPORT      
    SiiDrvTxPhyPowerOnOffSet(pstHdmiHal->stHalCtx.hHdmiHw, bEnable);
#endif
}

#ifndef HDMI_BUILD_IN_BOOT
HI_VOID HAL_HDMI_PhyOutputEnableGet(struct hiHDMI_HAL_S *pstHdmiHal, HI_BOOL* bEnable)
{
#ifndef HDMI_FPGA_SUPPORT
   *bEnable =  SiiDrvTxPhyOutputEnableGet(pstHdmiHal->stHalCtx.hHdmiHw);
#endif
}

HI_U32 HAL_HDMI_EdidRawDataRead(HDMI_HAL_S *pstHdmiHal, HI_U32 u32Size, HI_U8 u8OutBuffer[])
{
    SiiEdid_t Edid;
    memset(&Edid, 0, sizeof(SiiEdid_t));
    if (SiiDrvTxEdidGet(pstHdmiHal->stHalCtx.hHdmiHw, &Edid))
    {
        memcpy(u8OutBuffer, Edid.b, u32Size);
        return Edid.validLen;
    }
    return 0;
}
#endif

#ifdef HDMI_CEC_SUPPORT
HI_VOID HAL_HDMI_CecEnableSet(HDMI_HAL_S *pstHdmiHal, HI_BOOL bEnable)
{
    HDMI_HAL_CEC_S* pstCec = pstHdmiHal->stHalCtx.pstCec;

    SiiCecEnable(pstCec, bEnable);
}

HI_S32 HAL_HDMI_CecAutoPing(HDMI_HAL_S *pstHdmiHal, HI_U16 u16PhyAddr, HDMI_CEC_NETWORK_S* pstCecNetwork)
{
    HI_S32 s32Ret;
    HDMI_HAL_CEC_S* pstCec = pstHdmiHal->stHalCtx.pstCec;
    pstCec->physicalAddr = u16PhyAddr;
    //pstCec->physicalAddr = SiiDrvTxCecPhysicalAddrGet(pstHdmiHal->stHalCtx.hHdmiHw);
    s32Ret = SiiCecAutoPing(pstCec);
    if (s32Ret != HI_SUCCESS)
    {
        return HI_FAILURE;
    }
    pstCecNetwork->logicalAddr = pstCec->logicalAddr;
    memcpy(pstCecNetwork->network, pstCec->network, sizeof(pstCec->network));
    return HI_SUCCESS;
}

HI_S32 HAL_HDMI_CecMsgSend(HDMI_HAL_S *pstHdmiHal, HDMI_CEC_CMD_S* sptMsg)
{
    HDMI_HAL_CEC_S* pstCec = pstHdmiHal->stHalCtx.pstCec;
    SiiCpiData_t cecFrame;
    memset(&cecFrame, 0, sizeof(SiiCpiData_t));
    cecFrame.opcode = sptMsg->u8Opcode;
    cecFrame.srcDestAddr = MAKE_SRCDEST(sptMsg->enSrcAdd, sptMsg->enDstAdd);
    cecFrame.argCount = sptMsg->stOperand.stRawData.u8Length;
    memcpy((cecFrame.args), sptMsg->stOperand.stRawData.u8Data, cecFrame.argCount);
    return SiiCecMsgSend(pstCec, &cecFrame);
}

HI_S32 HAL_HDMI_CecMsgReceive(HDMI_HAL_S *pstHdmiHal, HDMI_CEC_CMD_S* pstCecCmd)
{
    HI_S32 s32Ret = HI_FAILURE;
    HDMI_HAL_CEC_S* pstCec = pstHdmiHal->stHalCtx.pstCec;
    HDMI_CEC_MSG_S  msg;
    
    memset(&msg, 0, sizeof(HDMI_CEC_MSG_S));
    s32Ret = SiiCecMsgRead(pstCec, &msg);
    if (s32Ret == HI_SUCCESS)
    {
        pstCecCmd->enSrcAdd = GET_CEC_SRC(msg.srcDestAddr);
        pstCecCmd->enDstAdd = GET_CEC_DEST(msg.srcDestAddr);
        pstCecCmd->u8Opcode = msg.opcode;
        pstCecCmd->stOperand.stRawData.u8Length = msg.argCount;
        memcpy(pstCecCmd->stOperand.stRawData.u8Data, msg.args, msg.argCount);
    }

    return s32Ret;
}
#endif

#ifndef HDMI_BUILD_IN_BOOT
#if defined(CONFIG_HDMI_STB_SDK)
static HI_DRV_DISP_FMT_E DISP_TVHDFmtU2V(HI_UNF_ENC_FMT_E U)
{
    if (U <= HI_UNF_ENC_FMT_480P_60)
    {
        return (HI_DRV_DISP_FMT_E)(HI_DRV_DISP_FMT_1080P_60 + (U - HI_UNF_ENC_FMT_1080P_60));
    }
    else
    {
        return HI_DRV_DISP_FMT_1080i_50;
    }
}

static HI_DRV_DISP_FMT_E DISP_TVSDFmtU2V(HI_UNF_ENC_FMT_E U)
{
    switch (U)
    {
        case HI_UNF_ENC_FMT_PAL:
            return HI_DRV_DISP_FMT_PAL;
        case HI_UNF_ENC_FMT_PAL_N:
            return HI_DRV_DISP_FMT_PAL_N;
        case HI_UNF_ENC_FMT_PAL_Nc:
            return HI_DRV_DISP_FMT_PAL_Nc;
        case HI_UNF_ENC_FMT_NTSC:
            return HI_DRV_DISP_FMT_NTSC;
        case HI_UNF_ENC_FMT_NTSC_J:
            return HI_DRV_DISP_FMT_NTSC_J;
        case HI_UNF_ENC_FMT_NTSC_PAL_M:
            return HI_DRV_DISP_FMT_PAL_M;
        case HI_UNF_ENC_FMT_SECAM_SIN:
            return HI_DRV_DISP_FMT_SECAM_SIN;
        case HI_UNF_ENC_FMT_SECAM_COS:
            return HI_DRV_DISP_FMT_SECAM_COS;
        default:
            return HI_DRV_DISP_FMT_PAL;
    }
}

static HI_DRV_DISP_FMT_E DISP_3DFmtU2V(HI_UNF_ENC_FMT_E U)
{
    if (U <= HI_UNF_ENC_FMT_720P_50_FRAME_PACKING)
    {
        return (HI_DRV_DISP_FMT_E)(HI_DRV_DISP_FMT_1080P_24_FP + (U - HI_UNF_ENC_FMT_1080P_24_FRAME_PACKING));
    }
    else
    {
        return HI_DRV_DISP_FMT_1080P_24_FP;
    }
}

static HI_DRV_DISP_FMT_E DISP_4KFmtU2V(HI_UNF_ENC_FMT_E U)
{
    if (U <= HI_UNF_ENC_FMT_4096X2160_60)
    {
        return (HI_DRV_DISP_FMT_E)(HI_DRV_DISP_FMT_3840X2160_24 + (U - HI_UNF_ENC_FMT_3840X2160_24));
    }
    else
    {
        return HI_DRV_DISP_FMT_3840X2160_24;
    }
}

static HI_DRV_DISP_FMT_E DISP_DecimalFmtU2V(HI_UNF_ENC_FMT_E U)
{
    if (U <= HI_UNF_ENC_FMT_1080i_59_94)
    {
        return (HI_DRV_DISP_FMT_E)(HI_DRV_DISP_FMT_3840X2160_23_976 + (U - HI_UNF_ENC_FMT_3840X2160_23_976));
    }
    else
    {
        return HI_DRV_DISP_FMT_3840X2160_23_976;
    }
}


static HI_DRV_DISP_FMT_E DISP_DVIFmtU2V(HI_UNF_ENC_FMT_E U)
{
    if (U <= HI_UNF_ENC_FMT_VESA_2560X1600_60_RB)
    {
        return (HI_DRV_DISP_FMT_E)(HI_DRV_DISP_FMT_861D_640X480_60 + (U - HI_UNF_ENC_FMT_861D_640X480_60));
    }
    else
    {
        return HI_DRV_DISP_FMT_861D_640X480_60;
    }
}

static HI_DRV_DISP_FMT_E DISP_GetEncFmt(HI_UNF_ENC_FMT_E enUnFmt)
{
    if (enUnFmt <= HI_UNF_ENC_FMT_480P_60)
    {
        return DISP_TVHDFmtU2V(enUnFmt);
    }
    else if (enUnFmt <= HI_UNF_ENC_FMT_SECAM_COS)
    {
        return DISP_TVSDFmtU2V(enUnFmt);
    }
    else if (enUnFmt <= HI_UNF_ENC_FMT_720P_50_FRAME_PACKING)
    {
        return DISP_3DFmtU2V(enUnFmt);
    }
    else if (enUnFmt <= HI_UNF_ENC_FMT_VESA_2560X1600_60_RB)
    {
        return DISP_DVIFmtU2V(enUnFmt);
    }
    else if (enUnFmt <= HI_UNF_ENC_FMT_4096X2160_24)
    {
        return DISP_4KFmtU2V(enUnFmt);
    }
    else if (enUnFmt <= HI_UNF_ENC_FMT_1080i_59_94)
    {
        return DISP_DecimalFmtU2V(enUnFmt);
    }
    else if (enUnFmt == HI_UNF_ENC_FMT_BUTT)
    {
        return HI_DRV_DISP_FMT_CUSTOM;
    }
    else
    {
        return HI_DRV_DISP_FMT_PAL;
    }
}

HI_S32 HAL_HDMI_DispFmtGet(HDMI_HAL_S *pstHdmiHal, HDMI_HAL_BASE_PARAM_S *pstBaseParam)
{
    HI_S32 s32Ret = HI_FAILURE;
    HI_DISP_PARAM_S   stDispParam;
    PDM_EXPORT_FUNC_S   *pstPdmFuncs  = HI_NULL;

    CHECK_POINTER(pstHdmiHal);
    CHECK_POINTER(pstBaseParam);
    
    pstBaseParam->u32DispFmt    = HI_UNF_ENC_FMT_720P_50;
    pstBaseParam->enDeepColor   = HDMI_DEEP_COLOR_24BIT;
    pstBaseParam->enColorSpace  = HDMI_COLORSPACE_YCbCr444;
    s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_PDM, (HI_VOID**)&pstPdmFuncs);
    if (s32Ret == HI_FAILURE || NULL == pstPdmFuncs
        || NULL == pstPdmFuncs->pfnPDM_GetDispParam)
    {
        HDMI_ERR("get pdm module function failed\r\n");
        return HI_FAILURE;
    }

    s32Ret = pstPdmFuncs->pfnPDM_GetDispParam(HI_DRV_DISPLAY_1, &stDispParam);
    if (s32Ret == HI_FAILURE)
    {
        HDMI_ERR("PDM_GetDispParam failed\r\n");
        return HI_FAILURE;
    }
    pstBaseParam->u32DispFmt    = DISP_GetEncFmt(stDispParam.enFormat);
    HI_DRV_HDMI_PixClkGet(stDispParam.enFormat , &pstBaseParam->u32PixClk);
    
    switch(stDispParam.enDeepColorMode)
    {          
        case HI_UNF_HDMI_DEEP_COLOR_30BIT:
            pstBaseParam->enDeepColor = HDMI_DEEP_COLOR_30BIT;
            break;
        case HI_UNF_HDMI_DEEP_COLOR_36BIT:         
            pstBaseParam->enDeepColor = HDMI_DEEP_COLOR_36BIT;
            break;
            
        case HI_UNF_HDMI_DEEP_COLOR_OFF:
        case HI_UNF_HDMI_DEEP_COLOR_24BIT :
        default:
            pstBaseParam->enDeepColor = HDMI_DEEP_COLOR_24BIT;
            break;
    }

    switch(stDispParam.enVidOutMode)
    {
        case HI_UNF_HDMI_VIDEO_MODE_RGB444:
            pstBaseParam->enColorSpace = HDMI_COLORSPACE_RGB;
            break;
        case HI_UNF_HDMI_VIDEO_MODE_YCBCR422:
            pstBaseParam->enColorSpace = HDMI_COLORSPACE_YCbCr422;
            break;
        case HI_UNF_HDMI_VIDEO_MODE_YCBCR444:
            pstBaseParam->enColorSpace = HDMI_COLORSPACE_YCbCr444;
            break;
    	case HI_UNF_HDMI_VIDEO_MODE_YCBCR420:
            pstBaseParam->enColorSpace = HDMI_COLORSPACE_YCbCr420;
            break;

    	default:
    	    HDMI_ERR("stDispParam.enVidOutMode=%d\n",stDispParam.enVidOutMode);
            pstBaseParam->enColorSpace = HDMI_COLORSPACE_RGB;
	        break;
    }
    
    return s32Ret;
}
#endif
#endif

#if defined(CONFIG_HDMI_STB_SDK)
HDMI_VIDEO_TIMING_E HAL_HDMI_DispFmt2HdmiTiming(HDMI_HAL_S *pstHdmiHal, HI_U32 u32DispFmt)
{
    HDMI_VIDEO_TIMING_E VideoTimingMode;
    switch (u32DispFmt)
    {
        case HI_DRV_DISP_FMT_1080P_60:
        case HI_DRV_DISP_FMT_1080P_59_94:
            VideoTimingMode = HDMI_VIDEO_TIMING_1920X1080P_60000;
            break;
        case HI_DRV_DISP_FMT_1080P_50:
            VideoTimingMode = HDMI_VIDEO_TIMING_1920X1080P_50000;
            break;
        case HI_DRV_DISP_FMT_1080P_30:
        case HI_DRV_DISP_FMT_1080P_29_97:
            VideoTimingMode = HDMI_VIDEO_TIMING_1920X1080P_30000;
            break;
        case HI_DRV_DISP_FMT_1080P_25:
            VideoTimingMode = HDMI_VIDEO_TIMING_1920X1080P_25000;
            break;
        case HI_DRV_DISP_FMT_1080P_24:
        case HI_DRV_DISP_FMT_1080P_23_976:
        case HI_DRV_DISP_FMT_1080P_24_FP:
            VideoTimingMode = HDMI_VIDEO_TIMING_1920X1080P_24000;
            break;
        case HI_DRV_DISP_FMT_1080i_60:
        case HI_DRV_DISP_FMT_1080i_59_94:
            VideoTimingMode = HDMI_VIDEO_TIMING_1920X1080I_60000;
            break;
        case HI_DRV_DISP_FMT_1080i_50:
            VideoTimingMode = HDMI_VIDEO_TIMING_1920X1080I_50000;
            break;
        case HI_DRV_DISP_FMT_720P_60:
        case HI_DRV_DISP_FMT_720P_59_94:
        case HI_DRV_DISP_FMT_720P_60_FP:
            VideoTimingMode = HDMI_VIDEO_TIMING_1280X720P_60000;
            break;
        case HI_DRV_DISP_FMT_720P_50:
        case HI_DRV_DISP_FMT_720P_50_FP:
            VideoTimingMode = HDMI_VIDEO_TIMING_1280X720P_50000;
            break;
        case HI_DRV_DISP_FMT_576P_50:
            VideoTimingMode = HDMI_VIDEO_TIMING_720X576P_50000;
            break;
        case HI_DRV_DISP_FMT_480P_60:
            VideoTimingMode = HDMI_VIDEO_TIMING_720X480P_60000;
            break;
        case HI_DRV_DISP_FMT_3840X2160_24:
        case HI_DRV_DISP_FMT_3840X2160_23_976:
            VideoTimingMode = HDMI_VIDEO_TIMING_3840X2160P_24000;
            break;            
        case HI_DRV_DISP_FMT_3840X2160_25:
            VideoTimingMode = HDMI_VIDEO_TIMING_3840X2160P_25000;
            break;  
        case HI_DRV_DISP_FMT_3840X2160_30:
        case HI_DRV_DISP_FMT_3840X2160_29_97:
            VideoTimingMode = HDMI_VIDEO_TIMING_3840X2160P_30000;
            break;  
        case HI_DRV_DISP_FMT_4096X2160_24:    
            VideoTimingMode = HDMI_VIDEO_TIMING_4096X2160P_24000;
            break;
        case HI_DRV_DISP_FMT_4096X2160_25:    
            VideoTimingMode = HDMI_VIDEO_TIMING_4096X2160P_25000;
            break;
        case HI_DRV_DISP_FMT_4096X2160_30:    
            VideoTimingMode = HDMI_VIDEO_TIMING_4096X2160P_30000;
            break;
        case HI_DRV_DISP_FMT_3840X2160_50:
            VideoTimingMode = HDMI_VIDEO_TIMING_3840X2160P_50000;
            break;  
        case HI_DRV_DISP_FMT_3840X2160_60:
            VideoTimingMode = HDMI_VIDEO_TIMING_3840X2160P_60000;
            break; 
        case HI_DRV_DISP_FMT_4096X2160_50:    
            VideoTimingMode = HDMI_VIDEO_TIMING_4096X2160P_50000;
            break;
        case HI_DRV_DISP_FMT_4096X2160_60:    
            VideoTimingMode = HDMI_VIDEO_TIMING_4096X2160P_60000;
            break;
        case HI_DRV_DISP_FMT_1440x576i_50:
        case HI_DRV_DISP_FMT_PAL:
        case HI_DRV_DISP_FMT_PAL_B:
        case HI_DRV_DISP_FMT_PAL_B1:
        case HI_DRV_DISP_FMT_PAL_D:
        case HI_DRV_DISP_FMT_PAL_D1:
        case HI_DRV_DISP_FMT_PAL_G:
        case HI_DRV_DISP_FMT_PAL_H:
        case HI_DRV_DISP_FMT_PAL_K:
        case HI_DRV_DISP_FMT_PAL_I:
        case HI_DRV_DISP_FMT_PAL_M:
        case HI_DRV_DISP_FMT_PAL_N:
        case HI_DRV_DISP_FMT_PAL_Nc:
        case HI_DRV_DISP_FMT_PAL_60:

        case HI_DRV_DISP_FMT_SECAM_SIN:
        case HI_DRV_DISP_FMT_SECAM_COS:
        case HI_DRV_DISP_FMT_SECAM_L:
        case HI_DRV_DISP_FMT_SECAM_B:
        case HI_DRV_DISP_FMT_SECAM_G:
        case HI_DRV_DISP_FMT_SECAM_D:
        case HI_DRV_DISP_FMT_SECAM_K:
        case HI_DRV_DISP_FMT_SECAM_H:
            VideoTimingMode = HDMI_VIDEO_TIMING_1440X576I_50000;
            break;
        case HI_DRV_DISP_FMT_1440x480i_60:
            VideoTimingMode = HDMI_VIDEO_TIMING_1440X480I_60000;
            break;
        case HI_DRV_DISP_FMT_NTSC:
        case HI_DRV_DISP_FMT_NTSC_J:
        case HI_DRV_DISP_FMT_NTSC_443:
            VideoTimingMode = HDMI_VIDEO_TIMING_1440X480I_60000;
            break;
        case HI_DRV_DISP_FMT_861D_640X480_60:
            VideoTimingMode = HDMI_VIDEO_TIMING_640X480P_60000;
            break;
        default:
            HDMI_INFO("Not CEA video timing:%d\n", u32DispFmt);
            //  vesa
            VideoTimingMode = HDMI_VIDEO_TIMING_UNKNOWN;
            break;
    }
    return VideoTimingMode;
}
#endif

HI_S32 HAL_HDMI_Open(HDMI_HAL_INIT_S *pstHalInit, HDMI_HAL_S** pstHalHandle)
{
    SiiInst_t instTx = HI_NULL;
	SiiDrvCraConfig_t craConfig = {0};
    SiiDrvTxConfig_t  txConfig = {0};
    HDMI_HAL_S* pstHdmiHal = HI_NULL;

    memset(&craConfig,0,sizeof(craConfig));
    memset(&txConfig,0,sizeof(txConfig));

    pstHdmiHal = (HDMI_HAL_S *)SiiLibMallocCreate(sizeof(HDMI_HAL_S));
    if (pstHdmiHal == HI_NULL)
    {
        HDMI_ERR("Alloc HDMI_HAL_S struct memory fail\n");
        return HI_FAILURE;
    }
	
    if(pstHalInit != HI_NULL)
    {
        pstHdmiHal->stHalCtx.pCallback  = pstHalInit->pfnEventCallBack;
        pstHdmiHal->stHalCtx.hHdmiDev   = pstHalInit->pvEventData;
        pstHdmiHal->stHalCtx.u32HdmiID  = pstHalInit->u32HdmiDevId;
    }
    
    pstHdmiHal->HAL_HDMI_HardwareInit            = HAL_HDMI_HardwareInit;  
    pstHdmiHal->HAL_HDMI_AvMuteSet               = HAL_HDMI_AvMuteSet;
    pstHdmiHal->HAL_HDMI_TmdsModeSet             = HAL_HDMI_TmdsModeSet;
    pstHdmiHal->HAL_HDMI_InfoframeSet            = HAL_HDMI_InfoframeSet;
    pstHdmiHal->HAL_HDMI_InfoframeEnableSet      = HAL_HDMI_InfoframeEnableSet;    
    pstHdmiHal->HAL_HDMI_VideoPathSet            = HAL_HDMI_VideoPathSet;
    pstHdmiHal->HAL_HDMI_PhyPowerEnableSet       = HAL_HDMI_PhyPowerEnableSet;
    pstHdmiHal->HAL_HDMI_PhyOutputEnableSet      = HAL_HDMI_PhyOutputEnableSet; 
    pstHdmiHal->HAL_HDMI_TxCapabilityGet         = HAL_HDMI_TxCapabilityGet;
    pstHdmiHal->HAL_HDMI_EmiSet                  = HAL_HDMI_EmiSet;
    pstHdmiHal->HAL_HDMI_EmiStatusGet            = HAL_HDMI_EmiStatusGet;
    
#if defined(CONFIG_HDMI_STB_SDK)
    pstHdmiHal->HAL_HDMI_DispFmt2HdmiTiming      = HAL_HDMI_DispFmt2HdmiTiming;
#endif
#ifndef HDMI_BUILD_IN_BOOT
    pstHdmiHal->HAL_HDMI_ScdcStatusGet           = HAL_HDMI_ScdcStatusGet;
    pstHdmiHal->HAL_HDMI_ScdcStatusSet           = HAL_HDMI_ScdcStatusSet;
    pstHdmiHal->HAL_HDMI_HardwareStatusGet       = HAL_HDMI_HardwareStatusGet;
    pstHdmiHal->HAL_HDMI_SequencerHandlerProcess = HAL_HDMI_SequencerHandlerProcess;
    pstHdmiHal->HAL_HDMI_AudioMuteSet            = HAL_HDMI_AudioMuteSet;
    pstHdmiHal->HAL_HDMI_AudioPathSet            = HAL_HDMI_AudioPathSet;
    pstHdmiHal->HAL_HDMI_AudioPathEnableSet      = HAL_HDMI_AudioPathEnableSet;
    pstHdmiHal->HAL_HDMI_EdidRawDataRead         = HAL_HDMI_EdidRawDataRead;  
    pstHdmiHal->HAL_HDMI_PhyOutputEnableGet      = HAL_HDMI_PhyOutputEnableGet;
    pstHdmiHal->HAL_HDMI_HotPlugStatusGet        = HAL_HDMI_HotPlugStatusGet;
    pstHdmiHal->HAL_HDMI_IrqEnableSet            = HAL_HDMI_IrqEnableSet;
    pstHdmiHal->HAL_HDMI_VideoMuteSet            = HAL_HDMI_VideoMuteSet;
    pstHdmiHal->HAL_HDMI_BlackDataSet            = HAL_HDMI_BlackDataSet;
    pstHdmiHal->HAL_HDMI_Debug                   = HAL_HDMI_Debug;
    pstHdmiHal->HAL_HDMI_BaseAddrGet             = HAL_HDMI_BaseAddrGet;
#if defined(CONFIG_HDMI_STB_SDK)
    pstHdmiHal->HAL_HDMI_DispFmtGet              = HAL_HDMI_DispFmtGet;
#endif
#endif
#ifdef HDMI_HDCP_SUPPORT
    pstHdmiHal->HAL_HDMI_HdcpEnableSet           = HAL_HDMI_HdcpEnableSet;
    pstHdmiHal->HAL_HDMI_HdcpModeSet             = HAL_HDMI_HdcpModeSet;
    pstHdmiHal->HAL_HDMI_SinkHdcp22CapabilityGet = HAL_HDMI_SinkHdcp22CapabilityGet;
#endif
#ifdef HDMI_CEC_SUPPORT
    pstHdmiHal->HAL_HDMI_CecEnableSet            = HAL_HDMI_CecEnableSet;
    pstHdmiHal->HAL_HDMI_CecAutoPing             = HAL_HDMI_CecAutoPing;
    pstHdmiHal->HAL_HDMI_CecMsgSend              = HAL_HDMI_CecMsgSend;  
    pstHdmiHal->HAL_HDMI_CecMsgReceive           = HAL_HDMI_CecMsgReceive; 
#endif    
#ifdef HDMI_SCDC_SUPPORT
    pstHdmiHal->HAL_HDMI_ScdcConfig              = HAL_HDMI_ScdcConfig;
#endif

       
    *pstHalHandle = pstHdmiHal;

	//Configure Cra
	craConfig.baseAddr  = BASE_ADDRESS;
	instCra	= SiiDrvCraCreate(&craConfig);
    if (instCra == HI_NULL)
    {
        HDMI_ERR("SiiDrvCraCreate fail\n");
        return HI_FAILURE;
    }  

    //Configure & Create Tx
    txConfig.instCra     = instCra;
    txConfig.baseAddr    = BASE_ADDRESS;
    txConfig.pu32CtrlVirBaseAddr = HAL_HDMI_BaseAddrGet(pstHdmiHal);
	txConfig.bHdcp2xEn	 = HI_FALSE;
	txConfig.bMhlen		 = HI_FALSE;
	txConfig.bMhl3en     = HI_FALSE;
	txConfig.bEsmcEn	 = HI_FALSE;
	txConfig.bMDTEn		 = HI_FALSE;
    txConfig.bCpiEn      = HI_FALSE;
    txConfig.bProgramDino  = HI_FALSE;
    txConfig.bVidPathEn	   = HI_TRUE;

	instTx = SiiDrvTxCreate("Hisilicon", &txConfig);
    if (instTx == HI_NULL)
    {
        SiiDrvCraDelete(instCra);
        HDMI_ERR("SiiDrvTxCreate fail!\n"); 
        return HI_FAILURE;
    }

    pstHdmiHal->stHalCtx.hHdmiHw = instTx;

    /* Tx Capability */
    pstHdmiHal->stHalCtx.stTxCapability.bTxHdmi_14      = HI_TRUE;
    pstHdmiHal->stHalCtx.stTxCapability.bTxHdmi_20      = HI_TRUE;

    pstHdmiHal->stHalCtx.stTxCapability.bTxHdcp_14      = HI_TRUE;
    pstHdmiHal->stHalCtx.stTxCapability.bTxHdcp_22      = HI_TRUE;

    pstHdmiHal->stHalCtx.stTxCapability.bTxRGB444       = HI_TRUE;
    pstHdmiHal->stHalCtx.stTxCapability.bTxYCBCR444     = HI_TRUE;
    pstHdmiHal->stHalCtx.stTxCapability.bTxYCBCR422     = HI_TRUE;
    pstHdmiHal->stHalCtx.stTxCapability.bTxYCBCR420     = HI_TRUE;

    pstHdmiHal->stHalCtx.stTxCapability.bTxDeepClr10Bit = HI_TRUE;
    pstHdmiHal->stHalCtx.stTxCapability.bTxDeepClr12Bit = HI_TRUE;
    pstHdmiHal->stHalCtx.stTxCapability.bTxDeepClr16Bit = HI_FALSE;

    pstHdmiHal->stHalCtx.stTxCapability.bTxRGB_YCbCR444 = HI_TRUE;
    pstHdmiHal->stHalCtx.stTxCapability.bTxYCBCR444_422 = HI_TRUE;
    pstHdmiHal->stHalCtx.stTxCapability.bTxYCBCR422_420 = HI_TRUE;

    pstHdmiHal->stHalCtx.stTxCapability.bTxYCBCR420_422 = HI_TRUE;
    pstHdmiHal->stHalCtx.stTxCapability.bTxYCBCR422_444 = HI_TRUE;
    pstHdmiHal->stHalCtx.stTxCapability.bTxYCBCR444_RGB = HI_TRUE;

    pstHdmiHal->stHalCtx.stTxCapability.bTxScdc         = HI_TRUE;
    pstHdmiHal->stHalCtx.stTxCapability.u32TxMaxTmdsClk = 600; /*in MHz*/
    

    pstHdmiHal->stHalCtx.stVideoCfg.enDeepColor = HDMI_DEEP_COLOR_BUTT;
    pstHdmiHal->stHalCtx.stVideoCfg.u32PixelClk = 74250;
#ifndef HDMI_BUILD_IN_BOOT
    SiiDrvTxRegisterCallBack(instTx, HalEventCallback, pstHdmiHal);
#endif

#ifdef HDMI_CEC_SUPPORT
    pstHdmiHal->stHalCtx.pstCec = SiiCecDeviceCreate(instCra, CEC_BASE_ADDRESS);
    if (pstHdmiHal->stHalCtx.pstCec == HI_NULL)
    {
        SiiDrvTxDelete(instTx);
        SiiDrvCraDelete(instCra);
        HDMI_ERR("SiiCecDeviceCreate fail!\n"); 
        return HI_FAILURE;
    }
#endif    

    HDMI_INFO("Open hdmi hal device success\n");

    return HI_SUCCESS;
}

void HAL_HDMI_Close(HDMI_HAL_S* pstHdmiHal)
{
    if (pstHdmiHal != HI_NULL)
    {
        /* 20150818, l232354 hdmi requred to lowpower, so need open the PLL 
           in HdWareInit function and and close PLL in HAL_HDMI_Close */
        HAL_HDMI_PhyPowerEnableSet(pstHdmiHal, HI_FALSE);

    #ifdef HDMI_CEC_SUPPORT
        SiiCecDeviceDelete(pstHdmiHal->stHalCtx.pstCec);
    #endif
        SiiDrvTxDelete(pstHdmiHal->stHalCtx.hHdmiHw);
        SiiDrvCraDelete(instCra);
        SiiLibMallocDelete(pstHdmiHal);
        HDMI_INFO("\nClose hdmi hal device success\n");
    }   
}


