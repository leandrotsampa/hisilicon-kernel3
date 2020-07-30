/**
 \file
 \brief CI hal interface
 \copyright Shenzhen Hisilicon Co., Ltd.
 \date 2011-2021
 \version draft
 \author l00185424
 \date 2011-7-20
 */

/***************************** Include files  ******************************/
#include <linux/delay.h>
#include <mach/hardware.h>
#include <asm/io.h>
#include <asm/uaccess.h>

#include "drv_gpio_ext.h"
#include "hi_drv_mem.h"
#include "hi_drv_module.h"
#include "hal_ci.h"

/************************** Macro Definition ******************************/
#if defined(CHIP_TYPE_hi3751v100)     \
    || defined(CHIP_TYPE_hi3796cv100) \
    || defined(CHIP_TYPE_hi3798cv100)  
#define CI_PHY_BASE_ADDR        (0xF9850000L)
#define PERI_CTRL_BASE_ADDR     (0xF8A20000L)
#define PERI_CRG_BASE_ADDR      (0xF8A22000L)
#define PERI_CRG63_ADDR         (PERI_CRG_BASE_ADDR + 0x00FC)
#define PVR_TSI4_CKSEL_BIT      (23)
#define PVR_TSI4_CKSEL_TSIN     (0x00)
#define PVR_TSI4_CKSEL_QAMC     (0x01) 
#define PVR_TSI4_CKSEL_QAMT     (0x02) 
#define PVR_TSI4_CKSEL_TSOUT0   (0x03) 
#define PERI_CRG_CI_ADDR        (PERI_CRG_BASE_ADDR + 0x0188)
#define PERI_QOS_CFG00_ADDR     (PERI_CRG_BASE_ADDR + 0x0200)
#define PERI_QAMC_QAMT_SEL_BIT  (10)
#define PERI_QAMC_QAMT_SEL_QAMT (0x00)
#define PERI_QAMC_QAMT_SEL_QAMC (0x01)
#define PERI_IO_OEN             (PERI_CTRL_BASE_ADDR + 0x08AC)
#elif defined(CHIP_TYPE_hi3798cv200_a) || defined (CHIP_TYPE_hi3798cv200_b)
#define CI_PHY_BASE_ADDR        (0xF9C60000L)
#define PERI_CTRL_BASE_ADDR     (0xF8A20000L)
#define PERI_CRG_BASE_ADDR      (0xF8A22000L)
#define PVR_BASE_ADDR           (0xF9C00000L)
#define PERI_CRG_CI_ADDR        (PERI_CRG_BASE_ADDR + 0x0328)
#define PVR_TSOUT0_BYPASS       (PVR_BASE_ADDR + 0x0FF0)
#endif

#define PERI_IO_OEN_TSO_ENABLE  (0x00)
#define PERI_IO_OEN_TSO_DISABLE (0x01)

#define HI_CIV100_DIRMODE  1
#define HI_CIV100_INDIRMODE  0

#define CI_PCCD_READY_COUNT       (5) 

#ifndef BIT
#define BIT(bit) (0x01 << (bit))
#endif                       

#define CIV100_WRITE_REG(offset, value) \
    (*(volatile HI_U32*)(s_u32CIRegBase + (offset)) = (value))
#define CIV100_READ_REG(offset) \
    (*(volatile HI_U32*)(s_u32CIRegBase + (offset)))

#if defined(CHIP_TYPE_hi3751v100) || defined(CHIP_TYPE_hi3796cv100) || defined(CHIP_TYPE_hi3798cv100)  
#define HI_CI_CHECK_PCCD_VALID(enCardId) \
    { \
        if (HI_UNF_CI_PCCD_A != enCardId) \
        { \
            HI_ERR_CI("Invalid Card Id:%d.\n", enCardId); \
            return HI_ERR_CI_INVALID_PARA; \
        } \
    }
#elif defined(CHIP_TYPE_hi3798cv200_a) || defined (CHIP_TYPE_hi3798cv200_b)
#define HI_CI_CHECK_PCCD_VALID(enCardId) \
    { \
        if (HI_UNF_CI_PCCD_BUTT<= enCardId) \
        { \
            HI_ERR_CI("Invalid Card Id:%d.\n", enCardId); \
            return HI_ERR_CI_INVALID_PARA; \
        } \
    }
#endif
    
/*CI register offset*/
#define SLAVE_MODE_REG_OFFSET       (0x008)   /*slave mode select register*/
#define CI_INF_CMD_MODE_REG_OFFSET  (0x00C)   /*interface operation config register*/
#define CI_INF_SET_REG_OFFSET       (0x010)   /*ci info set register*/
#define CI_CMD_CFG_REG_OFFSET       (0x114)   /*operation config register*/
#define CI_RAW_CARD_REG_OFFSET      (0x200)   /*interrupt original status register*/
#define CI_EN_CARD_REG_OFFSET       (0x204)   /*interrupt enable register*/
#define CI_INT_CARD_REG_OFFSET      (0x208)   /*interrupt status register*/
#define CI_DBG_IN_SIG_REG_OFFSET    (0x308)   /*Input signal status register*/
#define CI_CMD0_SET_REG_OFFSET      (0x500)   /*indirect address cmd0 register*/
#define CI_CMD0_RDATA_REG_OFFSET    (0x504)   /*indirect address data0 register*/
#define CI_CMD1_BASE_REG_OFFSET     (0x508)   /*direct base address register*/
#define CI_CMD1_IO0_REG_OFFSET      (0x510)   /*direct address IO0 data register*/

typedef struct hiHICI_PARAMETER_S
{
    HI_BOOL bIsPowerCtrlGpioUsed;
    HI_U32 u32PowerCtrlGpioNo[HI_UNF_CI_PCCD_BUTT];
    HI_BOOL bTSByPass[HI_UNF_CI_PCCD_BUTT];
    HI_CI_PCCD_RUN_STEP enRunStep[HI_UNF_CI_PCCD_BUTT];
    HI_UNF_CI_PCCD_ACCESSMODE_E enAccessMode[HI_UNF_CI_PCCD_BUTT];
    HI_U32 u32Slavemode;
} HICI_PARAMETER_S;
/********************GLOBAL STATIC DECLARATIONS************************/
static HI_U32 s_u32CIRegBase;
static GPIO_EXT_FUNC_S* s_pGpioFunc = HI_NULL;
static HICI_PARAMETER_S s_astHiciParam[HI_UNF_CI_PORT_BUTT];

/*********************************CODE *******************************/
static HI_U32 HI_SYS_WriteRegister(HI_U32 u32RegAddr, HI_U32 u32Value)
{
	HI_U32* u32VirRegAddr;
	u32VirRegAddr = ioremap_nocache(u32RegAddr, 0x1000);
	(*(volatile HI_U32 *)(HI_U32)(u32VirRegAddr)) = u32Value;
	iounmap(u32VirRegAddr);
    
	return HI_SUCCESS;
}

static HI_U32 HI_SYS_ReadRegister(HI_U32 u32RegAddr, HI_U32* pu32Value)
{
	HI_U32* u32VirRegAddr;
	u32VirRegAddr = ioremap_nocache(u32RegAddr, 0x1000);
	*pu32Value = (*(volatile HI_U32 *)((HI_U32)(u32VirRegAddr)));
	iounmap(u32VirRegAddr);
    
    return HI_SUCCESS;   
}

HI_U32 ci_rdone(HI_VOID)
{
    HI_U32	u32Tmp = 0; 
    HI_U32  u32TimeOut = 10000;

    while(((u32Tmp & 0x100) != 0x100) && (u32TimeOut > 0))
    {	
        u32Tmp = CIV100_READ_REG(CI_CMD0_RDATA_REG_OFFSET);	
        u32TimeOut--;
    }
    return(u32Tmp & 0xff);		
}

void ci_wdone(HI_VOID)
{
    HI_U32	u32Tmp = 0; 
    HI_U32  u32TimeOut = 10000;

    while(((u32Tmp & 0x100) != 0x100) && (u32TimeOut > 0))
    {		
        u32Tmp = CIV100_READ_REG(CI_CMD0_RDATA_REG_OFFSET);
        u32TimeOut--;
    }
}

static HI_VOID HICI_SET_REG_BIT(HI_U32 u32RegOffset, HI_U32 u32Idx, HI_BOOL bVal)
{
    HI_U32 u32Value = 0;
    
    u32Value = CIV100_READ_REG(u32RegOffset);

    if (bVal)
    {
        u32Value |= 0x01 << u32Idx;
    }
    else
    {
        u32Value &= ~(0x01 << u32Idx);
    }

    CIV100_WRITE_REG(u32RegOffset, u32Value);
}

HI_S32 HICI_Init(HI_UNF_CI_PORT_E enCIPort)
{

    HI_U32 u32Ret;
    HI_U32 u32Value;

    if (HI_UNF_CI_PORT_0 == enCIPort)
    {
#if defined(CHIP_TYPE_hi3751v100)     \
    || defined(CHIP_TYPE_hi3796cv100) \
    || defined(CHIP_TYPE_hi3798cv100)  
        /*Open CI clock and reset*/
        u32Ret = HI_SYS_ReadRegister(PERI_CRG_CI_ADDR, &u32Value);
        if(u32Ret != HI_SUCCESS)
        {
            HI_ERR_CI("HI_SYS_ReadRegister(%d) falied.\n", PERI_CRG_CI_ADDR);
            return u32Ret;
        }
        u32Value |= 0x12;
        u32Ret = HI_SYS_WriteRegister(PERI_CRG_CI_ADDR, u32Value);
        if(u32Ret != HI_SUCCESS)
        {
            HI_ERR_CI("HI_SYS_WriteRegister(%d, %d) falied.\n", PERI_CRG_CI_ADDR, u32Value);
            return u32Ret;
        }
        msleep(50);
        u32Value &= ~0x02;
        u32Ret = HI_SYS_WriteRegister(PERI_CRG_CI_ADDR, u32Value);
        if(u32Ret != HI_SUCCESS)
        {
            HI_ERR_CI("HI_SYS_WriteRegister(%d, %d) falied.\n", PERI_CRG_CI_ADDR, u32Value);
            return u32Ret;
        }
        msleep(50);
#elif defined(CHIP_TYPE_hi3798cv200_a) || defined (CHIP_TYPE_hi3798cv200_b)
        /*Open CI clock and reset*/
        u32Ret = HI_SYS_ReadRegister(PERI_CRG_CI_ADDR, &u32Value);
        if(u32Ret != HI_SUCCESS)
        {
            HI_ERR_CI("HI_SYS_ReadRegister(%d) falied.\n", PERI_CRG_CI_ADDR);
            return u32Ret;
        }
        u32Value |= 0x11;
        u32Ret = HI_SYS_WriteRegister(PERI_CRG_CI_ADDR, u32Value);
        if(u32Ret != HI_SUCCESS)
        {
            HI_ERR_CI("HI_SYS_WriteRegister(%d, %d) falied.\n", PERI_CRG_CI_ADDR, u32Value);
            return u32Ret;
        }
        msleep(50);
        u32Value &= ~0x10;
        u32Ret = HI_SYS_WriteRegister(PERI_CRG_CI_ADDR, u32Value);
        if(u32Ret != HI_SUCCESS)
        {
            HI_ERR_CI("HI_SYS_WriteRegister(%d, %d) falied.\n", PERI_CRG_CI_ADDR, u32Value);
            return u32Ret;
        }
        msleep(50);
#endif
        s_u32CIRegBase = (HI_U32)ioremap_nocache(CI_PHY_BASE_ADDR, 0x10000);
        
        /*reset等输出信号可以输出*/
        u32Value = CIV100_READ_REG( CI_INF_SET_REG_OFFSET);
        u32Value &= ~(0x00033000);
        CIV100_WRITE_REG(CI_INF_SET_REG_OFFSET, u32Value);
        
        /*操作时不检查inpackn信号*/
        u32Value = CIV100_READ_REG( CI_CMD_CFG_REG_OFFSET);
        u32Value &= ~(0x01);
        CIV100_WRITE_REG(CI_CMD_CFG_REG_OFFSET, u32Value);

    }
    else
    {
        HI_ERR_CI("Only support HI_UNF_CI_PORT_0 now.\n");
        return HI_ERR_CI_UNSUPPORT;
    } 
    
    return HI_SUCCESS;
}

HI_S32 HICI_DeInit(HI_UNF_CI_PORT_E enCIPort)
{
    HI_U32 u32Ret;
    HI_U32 u32Value;

    if (HI_UNF_CI_PORT_0 == enCIPort)
    {
#if defined(CHIP_TYPE_hi3751v100)     \
    || defined(CHIP_TYPE_hi3796cv100) \
    || defined(CHIP_TYPE_hi3798cv100)  
        /*Close CI clock*/
        u32Ret = HI_SYS_ReadRegister(PERI_CRG_CI_ADDR, &u32Value);
        if(u32Ret != HI_SUCCESS)
        {
            HI_ERR_CI("HI_SYS_ReadRegister(%d) falied.\n", PERI_CRG_CI_ADDR);
            return HI_FAILURE;
        }
        u32Value |= 0x02;
        u32Value &= ~0x10;
        u32Ret = HI_SYS_WriteRegister(PERI_CRG_CI_ADDR, u32Value);
        if(u32Ret != HI_SUCCESS)
        {
            HI_ERR_CI("HI_SYS_WriteRegister(%d, %d) falied.\n", PERI_CRG_CI_ADDR, u32Value);
            return HI_FAILURE;
        }
#elif defined(CHIP_TYPE_hi3798cv200_a) || defined (CHIP_TYPE_hi3798cv200_b)
        /*Close CI clock*/
        u32Ret = HI_SYS_ReadRegister(PERI_CRG_CI_ADDR, &u32Value);
        if(u32Ret != HI_SUCCESS)
        {
            HI_ERR_CI("HI_SYS_ReadRegister(%d) falied.\n", PERI_CRG_CI_ADDR);
            return HI_FAILURE;
        }
        u32Value |= 0x10;
        u32Value &= ~0x01;
        u32Ret = HI_SYS_WriteRegister(PERI_CRG_CI_ADDR, u32Value);
        if(u32Ret != HI_SUCCESS)
        {
            HI_ERR_CI("HI_SYS_WriteRegister(%d, %d) falied.\n", PERI_CRG_CI_ADDR, u32Value);
            return HI_FAILURE;
        }
#endif
        iounmap((HI_VOID*)s_u32CIRegBase);
    }
    else
    {
        HI_ERR_CI("Only support HI_UNF_CI_PORT_0 now.\n");
        return HI_ERR_CI_UNSUPPORT;
    } 

    return HI_SUCCESS;
    
}

HI_S32 HICI_Open(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_ATTR_S stAttr)
{
    HI_S32 s32Ret = HI_SUCCESS;
    HI_U32 i;

    if (HI_UNF_CI_PORT_0 == enCIPort)
    {      
        memset(&s_astHiciParam, 0x00, sizeof(s_astHiciParam));
        s_astHiciParam[enCIPort].bIsPowerCtrlGpioUsed = stAttr.unDevAttr.stCIHICI.bIsPowerCtrlGpioUsed;
        s_astHiciParam[enCIPort].u32Slavemode = HI_CIV100_INDIRMODE;
        for(i=0; i<HI_UNF_CI_PCCD_BUTT; i++)
        {
            s_astHiciParam[enCIPort].u32PowerCtrlGpioNo[i]
                = stAttr.unDevAttr.stCIHICI.u32PowerCtrlGpioNo[HI_UNF_CI_PCCD_A];
            s_astHiciParam[enCIPort].enRunStep[i] = HI_CI_PCCD_RUN_STEP_RUNNING;
            s_astHiciParam[enCIPort].bTSByPass[i] = HI_TRUE;
            s_astHiciParam[enCIPort].enAccessMode[i] = HI_UNF_CI_PCCD_ACCESS_ATTR;
        }
        s_pGpioFunc = HI_NULL;
        
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_GPIO, (HI_VOID**)&s_pGpioFunc);
        if (HI_SUCCESS != s32Ret)
        {
            HI_ERR_CI("Call HI_DRV_MODULE_GetFunction fail.\n");
            return s32Ret;
        }
        s32Ret =  HICI_Init(enCIPort); 
        if (HI_SUCCESS != s32Ret)
        {
            HI_ERR_CI("HICI init fail.\n");
            return s32Ret;
        }
        HICI_SET_REG_BIT(SLAVE_MODE_REG_OFFSET, 0, s_astHiciParam[enCIPort].u32Slavemode);
    }
    else
    {
        HI_ERR_CI("Only support HI_UNF_CI_PORT_0 now.\n");
        return HI_ERR_CI_UNSUPPORT;
    } 
    
    return HI_SUCCESS;
}

HI_VOID HICI_Close(HI_UNF_CI_PORT_E enCIPort)
{
	HICI_DeInit(enCIPort);
}

HI_S32 HICI_PCCD_Open(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId)
{
    if (HI_UNF_CI_PORT_0 == enCIPort)
    {
        HI_CI_CHECK_PCCD_VALID(enCardId);
    }
    else
    {
        HI_ERR_CI("Only support HI_UNF_CI_PORT_0 now.\n");
        return HI_ERR_CI_UNSUPPORT;
    } 

    return HI_SUCCESS;
}

HI_VOID HICI_PCCD_Close(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId)
{

}

static HI_VOID HICI_PCCD_SEL(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId)
{
    HI_BOOL bValue = 0;
    
    bValue = (enCardId == HI_UNF_CI_PCCD_A ? 0 : 1);   

    HICI_SET_REG_BIT(CI_INF_SET_REG_OFFSET, 31, bValue);
}

/* Read data, IO or ATTR, offset automatically */
HI_S32 HICI_PCCD_ReadByte(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId,
                            HI_U32 u32Address, HI_U8 *pu8Value)
{
	HI_U32 u32Tmp = 0;
	HI_U32 u32addr = 0;

    if (HI_UNF_CI_PORT_0 == enCIPort)
    {
        HI_CI_CHECK_PCCD_VALID(enCardId);
        HICI_PCCD_SEL(enCIPort, enCardId);
        
        if(s_astHiciParam[enCIPort].u32Slavemode == HI_CIV100_INDIRMODE) 
        {
            if(s_astHiciParam[enCIPort].enAccessMode[enCardId] == HI_UNF_CI_PCCD_ACCESS_ATTR)
            {
    			u32Tmp = 0x00000300 + (u32Address<<16);
    			CIV100_WRITE_REG( CI_CMD0_SET_REG_OFFSET, u32Tmp);
            	ci_wdone();
        	    u32Tmp = ci_rdone();
        		*pu8Value = u32Tmp;
            } 
        	else
        	{
        		u32Tmp = 0x00000100 + (u32Address<<16);
                CIV100_WRITE_REG( CI_CMD0_SET_REG_OFFSET, u32Tmp);
        	    ci_wdone();
        	    u32Tmp = ci_rdone();
        		*pu8Value = u32Tmp;
        	}
        }
    	else //HI_CIV100_DIRMODE
        {	
            if(s_astHiciParam[enCIPort].enAccessMode[enCardId] == HI_UNF_CI_PCCD_ACCESS_ATTR)
            {
                CIV100_WRITE_REG( 0x508, (u32Address >> 8) & 0xFF);
        		u32addr = ((u32Address & 0xFF) <<2) + 0x1000;
                u32Tmp = CIV100_READ_REG( u32addr);
        		*pu8Value = u32Tmp;
            }
        	else
        	{
        		u32addr = CI_CMD1_IO0_REG_OFFSET + (u32Address*4);
                u32Tmp = CIV100_READ_REG( u32addr);
        		*pu8Value = u32Tmp;
        	}
        }
    }
    else
    {
        HI_ERR_CI("Only support HI_UNF_CI_PORT_0 now.\n");
        return HI_ERR_CI_UNSUPPORT;
    } 
    
	return HI_SUCCESS;
    
}

/* Write data, IO or ATTR, offset automatically */
HI_S32 HICI_PCCD_WriteByte(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId,
                             HI_U32 u32Address, HI_U8 u8Value)
{
    HI_S32 s32Ret = HI_SUCCESS;
    HI_U32 u32Tmp = 0;	
    HI_U32 u32addr = 0;

    if (HI_UNF_CI_PORT_0 == enCIPort)
    {
        HI_CI_CHECK_PCCD_VALID(enCardId);
        HICI_PCCD_SEL(enCIPort, enCardId);

        if(s_astHiciParam[enCIPort].u32Slavemode == HI_CIV100_INDIRMODE) 
        {
            if(s_astHiciParam[enCIPort].enAccessMode[enCardId] == HI_UNF_CI_PCCD_ACCESS_ATTR)
            {
                u32Tmp = 0x00000200 + (u32Address<<16) + (u8Value);
                CIV100_WRITE_REG( CI_CMD0_SET_REG_OFFSET, u32Tmp);
                ci_wdone();
            }
            else
            {
                u32Tmp = 0x00000000 + (u32Address<<16) + (u8Value);
                CIV100_WRITE_REG( CI_CMD0_SET_REG_OFFSET, u32Tmp);
                ci_wdone();
            }
        }
        else
        {
            if(s_astHiciParam[enCIPort].enAccessMode[enCardId] == HI_UNF_CI_PCCD_ACCESS_ATTR)
            {            
                CIV100_WRITE_REG( 0x508, (u32Address >> 8) & 0xFF);
                u32addr = ((u32Address & 0xFF) <<2) + 0x1000;
                CIV100_WRITE_REG( u32addr, u8Value);
            }
            else 
            {
                u32addr = CI_CMD1_IO0_REG_OFFSET + (u32Address*4);
                CIV100_WRITE_REG( u32addr, u8Value);		
            }
        }
    }
    else
    {
        HI_ERR_CI("Only support HI_UNF_CI_PORT_0 now.\n");
        return HI_ERR_CI_UNSUPPORT;
    }

    return s32Ret;

}

HI_S32 HICI_PCCD_Detect(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId,
                         HI_UNF_CI_PCCD_STATUS_E_PTR penCardIdStatus)
{
	HI_U32 u32CmdMode = 0;
    HI_U32 u32SignalStatus = 0;
    HI_U32 u32TryCount;
    HI_U32 u32PresentCount = 0;

    if (HI_UNF_CI_PORT_0 == enCIPort)
    {
        HI_CI_CHECK_PCCD_VALID(enCardId);

        if (s_astHiciParam[enCIPort].enRunStep[enCardId] == HI_CI_PCCD_RUN_STEP_RESUME)
        {
            *penCardIdStatus = HI_UNF_CI_PCCD_STATUS_ABSENT;
            s_astHiciParam[enCIPort].enRunStep[enCardId] = HI_CI_PCCD_RUN_STEP_RUNNING;
        }
        else
        {
            for(u32TryCount=0; u32TryCount<5; u32TryCount++)
            {
                u32CmdMode = CIV100_READ_REG(CI_INF_CMD_MODE_REG_OFFSET);
                if (enCardId == HI_UNF_CI_PCCD_A)
                {
                    u32SignalStatus = CIV100_READ_REG(CI_DBG_IN_SIG_REG_OFFSET);
                    if((u32CmdMode >> 4) & 0x1)
                    {
                        if(((u32SignalStatus >>1) & 0x01) == 0x00)
                        {
                            u32PresentCount++;
                        }
                    }
                    else
                    {
                        if((u32SignalStatus & 0x03) == 0x00)
                        {
                            *penCardIdStatus = HI_UNF_CI_PCCD_STATUS_PRESENT;
                            u32PresentCount++;
                        }
                    } 
                }
                else
                {
                    u32SignalStatus = CIV100_READ_REG(CI_INF_SET_REG_OFFSET);
                    if((u32CmdMode >> 4) & 0x1)
                    {
                        if(((u32SignalStatus >>29) & 0x01) == 0x00)
                        {
                            u32PresentCount++;
                        }
                    }
                    else
                    {
                        if(((u32SignalStatus >> 28) & 0x03) == 0x00)
                        {
                            *penCardIdStatus = HI_UNF_CI_PCCD_STATUS_PRESENT;
                            u32PresentCount++;
                        }
                    } 
                }
                msleep(CI_TIME_10MS);
            }
            if (u32PresentCount >= 3)
            {
                *penCardIdStatus = HI_UNF_CI_PCCD_STATUS_PRESENT;
            }
            else
            {
                *penCardIdStatus = HI_UNF_CI_PCCD_STATUS_ABSENT;
            }
        }
    }
    else
    {
        HI_ERR_CI("Only support HI_UNF_CI_PORT_0 now.\n");
        return HI_ERR_CI_UNSUPPORT;
    }

    return HI_SUCCESS;
}

HI_S32 HICI_PCCD_ReadyOrBusy(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId,
                             HI_UNF_CI_PCCD_READY_E_PTR penCardReady)
{
	HI_U32 u32Tmp = 0;
	HI_U32 civ100_rdy_check = 0;
    HI_U32 u32ElapsedTime = 0;
    
	u32Tmp=CIV100_READ_REG(CI_CMD_CFG_REG_OFFSET);
    if((u32Tmp & 0x2) == 0x2)
    {   
        civ100_rdy_check = 0x1;
    }
	else
	{
        civ100_rdy_check = 0x0;
	}
    *penCardReady = HI_UNF_CI_PCCD_BUSY;
    if (HI_UNF_CI_PORT_0 == enCIPort)
    {
        HI_CI_CHECK_PCCD_VALID(enCardId);

        if(civ100_rdy_check == 0x1)
        {
    	    /*The Host shall explicitly check for the READY signal until it is set by the
    	              * module or until a timeout of 5s has expired.
    	              */
    		for(u32ElapsedTime=0; u32ElapsedTime<CI_PCCD_READY_COUNT;u32ElapsedTime++)
    		{
    			u32Tmp = CIV100_READ_REG(CI_DBG_IN_SIG_REG_OFFSET);
                if (enCardId == HI_UNF_CI_PCCD_A)
                {
                    if ((u32Tmp & 0x4) == 0x4)
                    {
                        *penCardReady = HI_UNF_CI_PCCD_READY;
                        break;
                    }
                }
                else
                {
                    if ((u32Tmp & 0x80) == 0x80)
                    {
                        *penCardReady = HI_UNF_CI_PCCD_READY;
                        break;
                    } 
                }
    			msleep(10);
    		}		  
        }
    }
    else
    {
        HI_ERR_CI("Only support HI_UNF_CI_PORT_0 now.\n");
        return HI_ERR_CI_UNSUPPORT;
    }

    return HI_SUCCESS;
}

HI_S32 HICI_PCCD_Reset(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId)
{
	HI_U32 u32Tmp = 0;

    if (HI_UNF_CI_PORT_0 == enCIPort)
    {
        HI_CI_CHECK_PCCD_VALID(enCardId);

        if (enCardId == HI_UNF_CI_PCCD_A)
        {
        	u32Tmp = CIV100_READ_REG( CI_INF_SET_REG_OFFSET);
            u32Tmp |= 0x1100;
        	CIV100_WRITE_REG( CI_INF_SET_REG_OFFSET, u32Tmp);
        	msleep(CI_TIME_10MS);
        	u32Tmp &= ~0x1100;
        	CIV100_WRITE_REG( CI_INF_SET_REG_OFFSET, u32Tmp);
            msleep(CI_TIME_10MS * 5);
        }
        else
        {
        	u32Tmp = CIV100_READ_REG( CI_INF_SET_REG_OFFSET);
            u32Tmp |= 0x2200;
        	CIV100_WRITE_REG( CI_INF_SET_REG_OFFSET, u32Tmp);
        	msleep(CI_TIME_10MS);
        	u32Tmp &= ~0x2200;
        	CIV100_WRITE_REG( CI_INF_SET_REG_OFFSET, u32Tmp);
            msleep(CI_TIME_10MS * 50);
        }
    	HI_INFO_CI("Reset CAM OK!\n");
    }
    else
    {
        HI_ERR_CI("Only support HI_UNF_CI_PORT_0 now.\n");
        return HI_ERR_CI_UNSUPPORT;
    }

    return HI_SUCCESS;
}

HI_S32 HICI_PCCD_SetAccessMode(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId,
                            HI_UNF_CI_PCCD_ACCESSMODE_E enAccessMode)
{
    if (HI_UNF_CI_PORT_0 == enCIPort)
    {
        HI_CI_CHECK_PCCD_VALID(enCardId);

        s_astHiciParam[enCIPort].enAccessMode[enCardId] = enAccessMode;
    }
    else
    {
        HI_ERR_CI("Only support HI_UNF_CI_PORT_0 now.\n");
        return HI_ERR_CI_UNSUPPORT;
    }

    return HI_SUCCESS;
}

HI_S32 HICI_PCCD_GetAccessMode(HI_UNF_CI_PORT_E enCIPort,
                                    HI_UNF_CI_PCCD_E enCardId, HI_UNF_CI_PCCD_ACCESSMODE_E *penAccessMode)
{
    if (HI_UNF_CI_PORT_0 == enCIPort)
    {
        HI_CI_CHECK_PCCD_VALID(enCardId);
        
	    *penAccessMode = s_astHiciParam[enCIPort].enAccessMode[enCardId];
    }
    else
    {
        HI_ERR_CI("Only support HI_UNF_CI_PORT_0 now.\n");
        return HI_ERR_CI_UNSUPPORT;
    }

    return HI_SUCCESS;
}

/* Get Read/Write status: FR/DA/RE/WE */
HI_S32 HICI_PCCD_GetRWStatus(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, HI_U8 *pu8Value)
{    
	HI_S32 u32Ret = HI_SUCCESS;
	
    if (HI_UNF_CI_PORT_0 == enCIPort)
    {
        HI_CI_CHECK_PCCD_VALID(enCardId);
            
        u32Ret = HICI_PCCD_SetAccessMode(enCIPort, enCardId, HI_UNF_CI_PCCD_ACCESS_IO);
        if (u32Ret == HI_SUCCESS)
        {
        	u32Ret = HICI_PCCD_ReadByte(enCIPort, enCardId, COM_STAT_REG, pu8Value);
        }
    }
    else
    {
        HI_ERR_CI("Only support HI_UNF_CI_PORT_0 now.\n");
        u32Ret = HI_ERR_CI_UNSUPPORT;
    }
    
    return u32Ret;
}

/* 
 * Power ON/OFF 
 * Notice: Current solution only support power control on CI Port, but not for each PCCD.
 * So, if you call power off but some cards are present, will return HI_ERR_CI_CANNOT_POWEROFF.
 */
HI_S32 HICI_PCCD_CtrlPower(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId,
                           HI_UNF_CI_PCCD_CTRLPOWER_E enCtrlPower)
{
    HI_S32 s32Ret = HI_SUCCESS;
    HI_U32 u32GpioNo;
    HI_U32 u32GpioVal;

    if (HI_UNF_CI_PORT_0 == enCIPort)
    {
        HI_CI_CHECK_PCCD_VALID(enCardId);

        if (s_astHiciParam[enCIPort].bIsPowerCtrlGpioUsed)
        {
            if ((s_pGpioFunc) && (s_pGpioFunc->pfnGpioDirSetBit) && (s_pGpioFunc->pfnGpioWriteBit))
            {
                u32GpioNo = s_astHiciParam[enCIPort].u32PowerCtrlGpioNo[enCardId];
                u32GpioVal = (enCtrlPower == HI_UNF_CI_PCCD_CTRLPOWER_ON ? 1 : 0);
                s32Ret = s_pGpioFunc->pfnGpioDirSetBit(u32GpioNo, 0);
                msleep(1);
                s32Ret |= s_pGpioFunc->pfnGpioWriteBit(u32GpioNo, u32GpioVal); 
                if (HI_SUCCESS != s32Ret)
                {
                    HI_ERR_CI("Power off device fail, GPIO %d_%d.\n", u32GpioNo/8, u32GpioNo%8);
                    return HI_FAILURE;
                }
                msleep(CI_TIME_10MS*5);
            }
            else
            {
                HI_ERR_CI("Gpio Func invalid.\n");
                return HI_FAILURE;
            }
        }
    }
    else
    {
        HI_ERR_CI("Only support HI_UNF_CI_PORT_0 now.\n");
        s32Ret = HI_ERR_CI_UNSUPPORT;
    }
    
    return s32Ret;
    
}

HI_S32 HICI_PCCD_TSByPass(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, HI_BOOL bByPass)
{    
    HI_U32 u32Ret;
    HI_U32 u32Val;
    
    if (HI_UNF_CI_PORT_0 == enCIPort)
    {
#if defined(CHIP_TYPE_hi3751v100)     \
    || defined(CHIP_TYPE_hi3796cv100) \
    || defined(CHIP_TYPE_hi3798cv100)  
        HI_U32 u32Channal = PVR_TSI4_CKSEL_TSIN;
        HI_U32 u32TsoEnable = PERI_IO_OEN_TSO_ENABLE;

        if (HI_UNF_CI_PCCD_A != enCardId)
        {
           HI_ERR_CI("Only support HI_UNF_CI_PCCD_A now.\n");
           return HI_ERR_CI_UNSUPPORT;  
        }
          
        if(bByPass)
        {
             u32Channal = PVR_TSI4_CKSEL_TSOUT0;
             u32TsoEnable = PERI_IO_OEN_TSO_DISABLE;
        }
        /*set pvr_tsi4_cksel */
        HI_INFO_CI("Channal=%d.\n", PERI_CRG63_ADDR, u32Channal);
        u32Ret = HI_SYS_ReadRegister(PERI_CRG63_ADDR, &u32Val);
        if(u32Ret != HI_SUCCESS)
        {
            HI_ERR_CI("HI_SYS_ReadRegister(%d) falied.\n", PERI_CRG63_ADDR);
            return u32Ret;
        }
        HI_INFO_CI("Read PERI_CRG63 success, addr=0x%x,value=0x%x.\n", PERI_CRG63_ADDR, u32Val);
        u32Val &= ~(0x03 << PVR_TSI4_CKSEL_BIT);/*clean PVR_TSI4_CKSEL_BIT*/
        u32Val |= u32Channal << PVR_TSI4_CKSEL_BIT;
        u32Ret = HI_SYS_WriteRegister(PERI_CRG63_ADDR, u32Val);
        if(u32Ret != HI_SUCCESS)
        {
            HI_ERR_CI("HI_SYS_WriteRegister(%d, %d) falied.\n", PERI_CRG63_ADDR, u32Val);
            return u32Ret;
        }
        /*set peri_tso0_oen */
        u32Ret = HI_SYS_ReadRegister(PERI_IO_OEN, &u32Val);
        if(u32Ret != HI_SUCCESS)
        {
            HI_ERR_CI("HI_SYS_ReadRegister(%d) falied.\n", PERI_IO_OEN);
            return u32Ret;
        }
        HI_INFO_CI("Read PERI_IO_OEN success, addr=0x%x,value=0x%x.\n", PERI_IO_OEN, u32Val);
        u32Val &= ~(0x01);
        u32Val |= u32TsoEnable;
        u32Ret = HI_SYS_WriteRegister(PERI_IO_OEN, u32Val);
        if(u32Ret != HI_SUCCESS)
        {
            HI_ERR_CI("HI_SYS_WriteRegister(%d, %d) falied.\n", PERI_IO_OEN, u32Val);
            return u32Ret;
        }
#elif defined(CHIP_TYPE_hi3798cv200_a) || defined (CHIP_TYPE_hi3798cv200_b)
        u32Ret = HI_SYS_ReadRegister(PVR_TSOUT0_BYPASS, &u32Val);
        if(u32Ret != HI_SUCCESS)
        {
            HI_ERR_CI("HI_SYS_ReadRegister(%d) falied.\n", PVR_TSOUT0_BYPASS);
            return u32Ret;
        }
        if (bByPass)
        {
            u32Val |= 0x02;     //DVB1送入DMX的流选TSOUT0来的流
        }
        else
        {
            u32Val &= ~(0x02); //DVB1送入DMX的流选TSI0来的流
        }
        u32Ret = HI_SYS_WriteRegister(PVR_TSOUT0_BYPASS, u32Val);
        if(u32Ret != HI_SUCCESS)
        {
            HI_ERR_CI("HI_SYS_WriteRegister(%d, %d) falied.\n", PVR_TSOUT0_BYPASS, u32Val);
            return u32Ret;
        }
#endif
        s_astHiciParam[enCIPort].bTSByPass[enCardId] = bByPass;
    }
    else
    {
        HI_ERR_CI("Unsupport HI_UNF_CI_PORT_1 now.\n");
        return HI_ERR_CI_UNSUPPORT;
    }

    return HI_SUCCESS;
}

HI_S32 HICI_PCCD_GetBypassMode(HI_UNF_CI_PORT_E enCIPort,
                                HI_UNF_CI_PCCD_E enCardId, HI_BOOL *bBypass)
{
    *bBypass = s_astHiciParam[enCIPort].bTSByPass[enCardId];
    return HI_SUCCESS;
}

/* Low Power */
HI_S32 HICI_Standby(HI_UNF_CI_PORT_E enCIPort)
{
    HI_UNF_CI_PCCD_E enCardId;

    for(enCardId = HI_UNF_CI_PCCD_A; enCardId < HI_UNF_CI_PCCD_BUTT; enCardId++)
    {
        s_astHiciParam[enCIPort].enRunStep[enCardId] = HI_CI_PCCD_RUN_STEP_STANDBY;
    }
        
    return HICI_DeInit(enCIPort);
}

/* Resume CI */
HI_S32 HICI_Resume(HI_UNF_CI_PORT_E enCIPort)
{
    HI_UNF_CI_PCCD_E enCardId;
    

    for(enCardId = HI_UNF_CI_PCCD_A; enCardId < HI_UNF_CI_PCCD_BUTT; enCardId++)
    {
        s_astHiciParam[enCIPort].enRunStep[enCardId] = HI_CI_PCCD_RUN_STEP_RESUME;
    }
    
    return HICI_Init(enCIPort);
}

/*********************************** END ******************************/

