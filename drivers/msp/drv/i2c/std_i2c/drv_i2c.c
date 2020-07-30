/*********************************************************************************
*
*  Copyright (C) 2014 Hisilicon Technologies Co., Ltd.  All rights reserved.
*
*  This program is confidential and proprietary to Hisilicon Technologies Co., Ltd.
*  (Hisilicon), and may not be copied, reproduced, modified, disclosed to
*  others, published or used, in whole or in part, without the express prior
*  written permission of Hisilicon.
*
***********************************************************************************/

#include <linux/device.h>
#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/fs.h>
#include <asm/uaccess.h>
#include <asm/io.h>
#include <asm/delay.h>
#include <linux/poll.h>
#include <linux/interrupt.h>
#include <linux/slab.h>
#include <linux/sched.h>

#include "hi_kernel_adapt.h"
#include "hi_drv_reg.h"
#include "hi_drv_dev.h"
#include "hi_drv_proc.h"
#include "hi_drv_sys.h"
#include "drv_i2c.h"
#include "drv_i2c_ioctl.h"
#include "drv_i2c_ext.h"
#include "hi_common.h"
#include "hi_reg_common.h"
#include "hi_drv_i2c.h"
#include "hi_module.h"
#include "hi_drv_module.h"
#include "hi_drv_mem.h"
#include <linux/compat.h>



#define SONY_I2C_START_EN   (0x01)  /**< Output START (S) */
#define SONY_I2C_STOP_EN    (0x02)  /**< Output STOP  (P) */

#define I2C_WAIT_TIME_OUT   0x1000
#define I2C_ADDR_SIZE       0x1000

#define I2C_WRITE_REG(Addr, Value) ((*(volatile HI_U32 *)(Addr)) = (Value))
#define I2C_READ_REG(Addr) (*(volatile HI_U32 *)(Addr))

HI_DECLARE_MUTEX(g_I2cMutex);

#define HI_MAX_I2C_NUM  8

typedef struct tagI2C_DATA_EXCHANGE_S
{
    HI_U32  u32Direction;  /*0:stop/start condition, 1:write;2:read*/
    HI_U8   u8Data;
    HI_U32  u32Command;
}I2C_DATA_EXCHANGE_S;

typedef struct tagI2C_BUF_S
{
    I2C_DATA_EXCHANGE_S     stDataExchange[HI_I2C_MAX_LENGTH];
    HI_U32                  u32Len;
    HI_U32                  u32Index;
}I2C_BUF_S;

typedef struct tagI2C_SHARE_S
{
    struct semaphore         I2cSem;
    wait_queue_head_t        I2cWaitQueue;
}I2C_SHARE_S;

static HI_U8 ack_err[HI_MAX_I2C_NUM]={0};
static HI_U8* g_I2cKernelAddr[HI_MAX_I2C_NUM];
static HI_U32 regI2CStore[HI_MAX_I2C_NUM] = {0};
HI_U32 g_aI2cRate[HI_MAX_I2C_NUM] = {0};
static I2C_BUF_S g_astI2CBuff[HI_MAX_I2C_NUM];
static I2C_SHARE_S g_astI2cShare[HI_MAX_I2C_NUM];

#if    defined(CHIP_TYPE_hi3716cv200)   \
    || defined(CHIP_TYPE_hi3716mv400)   \
    || defined(CHIP_TYPE_hi3718cv100)   \
    || defined(CHIP_TYPE_hi3719cv100)   \
    || defined(CHIP_TYPE_hi3718mv100)   \
    || defined(CHIP_TYPE_hi3719mv100)

static HI_U32 g_I2cPhyAddr[HI_STD_I2C_NUM] = {I2C0_PHY_ADDR, I2C1_PHY_ADDR, I2C2_PHY_ADDR, I2C3_PHY_ADDR, I2C4_PHY_ADDR, I2CQAM_PHY_ADDR};

#elif  defined(CHIP_TYPE_hi3716mv410) || defined(CHIP_TYPE_hi3716mv420)

static HI_U32 g_I2cPhyAddr[HI_STD_I2C_NUM] = {I2C0_PHY_ADDR, I2C1_PHY_ADDR, I2C2_PHY_ADDR, I2C3_PHY_ADDR, I2C4_PHY_ADDR, I2CADC_PHY_ADDR, I2CQAM_PHY_ADDR};

#elif  defined(CHIP_TYPE_hi3798mv100) || defined(CHIP_TYPE_hi3796mv100)

static HI_U32 g_I2cPhyAddr[HI_STD_I2C_NUM] = {I2C0_PHY_ADDR, I2C1_PHY_ADDR, I2C2_PHY_ADDR};

#elif  defined(CHIP_TYPE_hi3798cv200) || defined(CHIP_TYPE_hi3798hv100)

static HI_U32 g_I2cPhyAddr[HI_STD_I2C_NUM] = {I2C0_PHY_ADDR, I2C1_PHY_ADDR, I2C2_PHY_ADDR, I2C3_PHY_ADDR, I2C4_PHY_ADDR};

#endif

#ifdef EXCHANGE_IN_INTERRUPT

#if    defined(CHIP_TYPE_hi3716cv200)   \
    || defined(CHIP_TYPE_hi3716mv400)   \
    || defined(CHIP_TYPE_hi3718cv100)   \
    || defined(CHIP_TYPE_hi3719cv100)   \
    || defined(CHIP_TYPE_hi3718mv100)   \
    || defined(CHIP_TYPE_hi3719mv100)

static HI_U32   g_astI2cIRQ[HI_MAX_I2C_NUM] = {I2C0_IRQ, I2C1_IRQ, I2C2_IRQ, I2C3_IRQ, I2C4_IRQ, I2CQAM_IRQ};

#elif  defined(CHIP_TYPE_hi3716mv410) || defined(CHIP_TYPE_hi3716mv420)

static HI_U32   g_astI2cIRQ[HI_MAX_I2C_NUM] = {I2C0_IRQ, I2C1_IRQ, I2C2_IRQ, I2C3_IRQ, I2C4_IRQ, I2CADC_IRQ, I2CQAM_IRQ};

#elif  defined(CHIP_TYPE_hi3798mv100) || defined(CHIP_TYPE_hi3796mv100)

static HI_U32   g_astI2cIRQ[HI_MAX_I2C_NUM] = {I2C0_IRQ, I2C1_IRQ, I2C2_IRQ};

#elif  defined(CHIP_TYPE_hi3798cv200) || defined(CHIP_TYPE_hi3798hv100)

static HI_U32   g_astI2cIRQ[HI_MAX_I2C_NUM] = {I2C0_IRQ, I2C1_IRQ, I2C2_IRQ, I2C3_IRQ, I2C4_IRQ};

#endif

#endif

HI_S32 i2c_pm_suspend(PM_BASEDEV_S *pdev, pm_message_t state);
HI_S32 i2c_pm_resume(PM_BASEDEV_S *pdev);

static I2C_EXT_FUNC_S g_stI2cExtFuncs =
{
    .pfnI2cWriteConfig  = HI_DRV_I2C_WriteConfig,
    .pfnI2cWrite        = HI_DRV_I2C_Write,
    .pfnI2cRead         = HI_DRV_I2C_Read,
    .pfnI2cWriteNostop  = HI_DRV_I2C_Write_NoSTOP,
    .pfnI2cReadDirectly = HI_DRV_I2C_ReadDirectly,
    .pfnI2cSetRate      = HI_DRV_I2C_SetRate,
    .pfnI2cSuspend      = i2c_pm_suspend,
    .pfnI2cResume       = i2c_pm_resume,
};

HI_VOID I2C_HAL_EnableInt(HI_U32 u32Num, HI_U32 u32Interupt)
{
    HI_U32 u32Value = I2C_READ_REG((g_I2cKernelAddr[u32Num] + I2C_CTRL_REG));

    u32Value |= u32Interupt;

    I2C_WRITE_REG((g_I2cKernelAddr[u32Num] + I2C_CTRL_REG), u32Value);

    return;

}

HI_VOID I2C_HAL_DisableInt(HI_U32 u32Num, HI_U32 u32Interupt)
{
    HI_U32 u32Value = I2C_READ_REG((g_I2cKernelAddr[u32Num] + I2C_CTRL_REG));

    u32Value &= (~u32Interupt);

    I2C_WRITE_REG((g_I2cKernelAddr[u32Num] + I2C_CTRL_REG), u32Value);

    return;

}

HI_VOID I2C_HAL_ClearInt(HI_U32 u32Num, HI_U32 u32Interupt)
{
    HI_U32 u32Value = I2C_READ_REG((g_I2cKernelAddr[u32Num] + I2C_ICR_REG));

    u32Value |= u32Interupt;

    I2C_WRITE_REG((g_I2cKernelAddr[u32Num] + I2C_ICR_REG), u32Value);

    return;
}

HI_U32 I2C_HAL_GetSR(HI_U32 I2cNum)
{
    return I2C_READ_REG((g_I2cKernelAddr[I2cNum] + I2C_SR_REG));
}

HI_VOID I2C_DRV_ReadRXR(HI_U32 I2cNum, HI_U32 u32Index)
{
    HI_U8  u8Data;

    HI_INFO_I2C("Num:%d, index:%d\n", I2cNum, u32Index);
    /*if last direction is read, read RXR Register to get byte*/
    if (u32Index > 0)
    {
        if (g_astI2CBuff[I2cNum].stDataExchange[u32Index-1].u32Direction == 2)
        {
            u8Data = I2C_READ_REG((g_I2cKernelAddr[I2cNum] + I2C_RXR_REG));
            g_astI2CBuff[I2cNum].stDataExchange[u32Index-1].u8Data = u8Data & 0xff;
        }
    }

}

HI_VOID I2C_DRV_ExchangeByte(HI_U32 I2cNum, HI_U32 u32Index)
{
    HI_U8  u8Data;
    HI_U32 u32Cmd = g_astI2CBuff[I2cNum].stDataExchange[u32Index].u32Command;

    if (g_astI2CBuff[I2cNum].stDataExchange[u32Index].u32Direction == 0)
    {
        I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_COM_REB), u32Cmd);
    }
    else if (g_astI2CBuff[I2cNum].stDataExchange[u32Index].u32Direction == 1)
    {
        u8Data = g_astI2CBuff[I2cNum].stDataExchange[u32Index].u8Data;
        I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_TXR_REG), u8Data);
        I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_COM_REB), u32Cmd);

    }
    else if (g_astI2CBuff[I2cNum].stDataExchange[u32Index].u32Direction == 2)
    {
        I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_COM_REB), u32Cmd);
    }
}

HI_S32 I2C_DRV_SetRate(HI_U32 I2cNum, HI_U32 I2cRate)
{
    HI_U32 Value = 0;
    HI_U32 SclH = 0;
    HI_U32 SclL = 0;
    HI_U32 SysClock = I2C_DFT_SYSCLK;

    if (I2cNum >= HI_STD_I2C_NUM)
    {
        HI_ERR_I2C("I2cNum(%d) is wrong, STD_I2C_NUM is %d\n", I2cNum, HI_STD_I2C_NUM);
        return HI_FAILURE;
    }

    g_aI2cRate[I2cNum] = I2cRate;

    /* read i2c I2C_CTRL register*/
    Value = I2C_READ_REG((g_I2cKernelAddr[I2cNum] + I2C_CTRL_REG));

    /* close all i2c  interrupt */
    I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_CTRL_REG), (Value & (~I2C_UNMASK_TOTAL)));

    SclH = (SysClock / (I2cRate * 2)) / 2 - 1;
    I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_SCL_H_REG), SclH);

    SclL = (SysClock / (I2cRate * 2)) / 2 - 1;
    I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_SCL_L_REG), SclL);

    /*enable i2c interrupt, resume original  interrupt*/
    I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_CTRL_REG), Value);

    return HI_SUCCESS;
}

HI_S32 I2C_DRV_WaitWriteEnd(HI_U32 I2cNum)
{
    HI_U32 I2cSrReg;
    HI_U32 i = 0;

    do
    {
        I2cSrReg = I2C_READ_REG((g_I2cKernelAddr[I2cNum] + I2C_SR_REG));

        if (i > I2C_WAIT_TIME_OUT)
        {
            HI_ERR_I2C("wait write data timeout!\n");
            return HI_FAILURE;
        }

        i++;
    } while ((I2cSrReg & I2C_OVER_INTR) != I2C_OVER_INTR);

    if (I2cSrReg & I2C_ACK_INTR)
    {
        HI_ERR_I2C("wait write data timeout!\n");
        return HI_FAILURE;
    }

    I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_ICR_REG), I2C_CLEAR_ALL);

    return HI_SUCCESS;
}

HI_S32 I2C_DRV_WaitRead(HI_U32 I2cNum)
{
    HI_U32 I2cSrReg;
    HI_U32 i = 0;

    do
    {
        I2cSrReg = I2C_READ_REG((g_I2cKernelAddr[I2cNum] + I2C_SR_REG));

        if (i > I2C_WAIT_TIME_OUT)
        {
            HI_ERR_I2C("wait Read data timeout!\n");
            return HI_FAILURE;
        }

        i++;
    } while ((I2cSrReg & I2C_RECEIVE_INTR) != I2C_RECEIVE_INTR);

    return HI_SUCCESS;
}

/*
add by Jiang Lei 2010-08-24
I2C write finished acknowledgement function
it use to e2prom device ,make sure it finished write operation.
i2c master start next write operation must waiting when it acknowledge e2prom write cycle finished.
 */
HI_S32 I2C_DRV_WriteConfig(HI_U32 I2cNum, HI_U8 I2cDevAddr)
{
    HI_U32 i = 0;
    HI_U32 j = 0;
    HI_U32 I2cSrReg;

    do
    {
        I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_TXR_REG), (I2cDevAddr & WRITE_OPERATION));
        I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_COM_REB), (I2C_WRITE | I2C_START));

        j = 0;
        do
        {
            I2cSrReg = I2C_READ_REG((g_I2cKernelAddr[I2cNum] + I2C_SR_REG));

            if (j > I2C_WAIT_TIME_OUT)
            {
                HI_ERR_I2C("wait write data timeout!\n");
                return HI_FAILURE;
            }

            j++;
        } while ((I2cSrReg & I2C_OVER_INTR) != I2C_OVER_INTR);

        I2cSrReg = I2C_READ_REG((g_I2cKernelAddr[I2cNum] + I2C_SR_REG));
        I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_ICR_REG), I2C_CLEAR_ALL);

        i++;

        if (i > 0x200000) //I2C_WAIT_TIME_OUT)
        {
            HI_ERR_I2C("wait write ack ok timeout!\n");
            return HI_FAILURE;
        }
    } while ((I2cSrReg & I2C_ACK_INTR));

    return HI_SUCCESS;
}

HI_S32 I2C_DRV_Write(HI_U32 I2cNum, HI_U8 I2cDevAddr, HI_U32 I2cRegAddr, HI_U32 I2cRegAddrByteNum, HI_U8 *pData,
                     HI_U32 DataLen, HI_BOOL bWithStop)
{
    HI_U32 i;

    //    unsigned long   IntFlag;
    HI_U32 RegAddr;

    //local_irq_save(IntFlag);

    /*  clear interrupt flag*/
    I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_ICR_REG), I2C_CLEAR_ALL);

    /* send devide address */
    I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_TXR_REG), (I2cDevAddr & WRITE_OPERATION));
    I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_COM_REB), (I2C_WRITE | I2C_START));

    if (I2C_DRV_WaitWriteEnd(I2cNum))
    {
        //local_irq_restore(IntFlag);
        //HI_ERR_I2C("wait write data timeout!%s, %d\n", __func__, __LINE__);
        return HI_ERR_I2C_WRITE_TIMEOUT;
    }

    /* send register address which will need to write */
    for (i = 0; i < I2cRegAddrByteNum; i++)
    {
        RegAddr = I2cRegAddr >> ((I2cRegAddrByteNum - i - 1) * 8);
        I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_TXR_REG), RegAddr);

        I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_COM_REB), I2C_WRITE);

        if (I2C_DRV_WaitWriteEnd(I2cNum))
        {
            //local_irq_restore(IntFlag);
            //HI_ERR_I2C("wait write data timeout!%s, %d\n", __func__, __LINE__);
            return HI_ERR_I2C_WRITE_TIMEOUT;
        }
    }

    /* send data */
    for (i = 0; i < DataLen; i++)
    {
        I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_TXR_REG), (*(pData + i)));
        I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_COM_REB), I2C_WRITE);

        if (I2C_DRV_WaitWriteEnd(I2cNum))
        {
            //local_irq_restore(IntFlag);
            //HI_ERR_I2C("wait write data timeout!%s, %d\n", __func__, __LINE__);
            return HI_ERR_I2C_WRITE_TIMEOUT;
        }
    }

    if (bWithStop)
    {
        /*   send stop flag bit*/
        I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_COM_REB), I2C_STOP);
        if (I2C_DRV_WaitWriteEnd(I2cNum))
        {
            //local_irq_restore(IntFlag);
            //HI_ERR_I2C("wait write data timeout!%s, %d\n", __func__, __LINE__);
            return HI_ERR_I2C_WRITE_TIMEOUT;
        }
    }

    //local_irq_restore(IntFlag);

    return HI_SUCCESS;
}

int I2C_DRV_Read(HI_U32 I2cNum, HI_U8 I2cDevAddr, HI_BOOL bSendSlave, HI_U32 I2cRegAddr, HI_U32 I2cRegAddrByteNum,
                 HI_U8 *pData, HI_U32 DataLen)
{
    HI_U32 dataTmp = 0xff;
    HI_U32 i;

    //    unsigned long   IntFlag;
    HI_U32 RegAddr;

    //local_irq_save(IntFlag);

    /* clear interrupt flag*/
    I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_ICR_REG), I2C_CLEAR_ALL);

    if (bSendSlave)
    {
        /* send devide address*/
        I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_TXR_REG), (I2cDevAddr & WRITE_OPERATION));
        I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_COM_REB), (I2C_WRITE | I2C_START));

        if (I2C_DRV_WaitWriteEnd(I2cNum))
        {
            //local_irq_restore(IntFlag);
            //HI_ERR_I2C("wait write data timeout!\n");
            return HI_ERR_I2C_WRITE_TIMEOUT;
        }
    }

    /* send register address which will need to write*/
    for (i = 0; i < I2cRegAddrByteNum; i++)
    {
        RegAddr = I2cRegAddr >> ((I2cRegAddrByteNum - i - 1) * 8);
        I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_TXR_REG), RegAddr);

        I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_COM_REB), I2C_WRITE);

        if (I2C_DRV_WaitWriteEnd(I2cNum))
        {
            //local_irq_restore(IntFlag);
            //HI_ERR_I2C("wait write data timeout!\n");
            return HI_ERR_I2C_WRITE_TIMEOUT;
        }
    }

    /* send register address which will need to read */
    I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_TXR_REG), (I2cDevAddr | READ_OPERATION));
    I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_COM_REB), I2C_WRITE | I2C_START);

    if (I2C_DRV_WaitWriteEnd(I2cNum))
    {
        //local_irq_restore(IntFlag);
        return HI_ERR_I2C_WRITE_TIMEOUT;
    }

    /* repetitivily read data */
    for (i = 0; i < DataLen; i++)
    {
        /*  the last byte don't need send ACK*/
        if (i == (DataLen - 1))
        {
            I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_COM_REB), (I2C_READ | (~I2C_SEND_ACK)));
        }
        /*  if i2c master receive data will send ACK*/
        else
        {
            I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_COM_REB), I2C_READ);
        }

        if (I2C_DRV_WaitRead(I2cNum))
        {
            //local_irq_restore(IntFlag);
            //HI_ERR_I2C("wait read data timeout!\n");
            return HI_ERR_I2C_READ_TIMEOUT;
        }

        dataTmp = I2C_READ_REG((g_I2cKernelAddr[I2cNum] + I2C_RXR_REG));
        *(pData + i) = dataTmp & 0xff;

        if (I2C_DRV_WaitWriteEnd(I2cNum))
        {
            //local_irq_restore(IntFlag);
            //HI_ERR_I2C("wait write data timeout!\n");
            return HI_ERR_I2C_WRITE_TIMEOUT;
        }
    }

    /* send stop flag bit*/
    I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_COM_REB), I2C_STOP);
    if (I2C_DRV_WaitWriteEnd(I2cNum))
    {
        //local_irq_restore(IntFlag);
        //HI_ERR_I2C("wait write data timeout!\n");
        return HI_ERR_I2C_WRITE_TIMEOUT;
    }

    //local_irq_restore(IntFlag);

    return HI_SUCCESS;
}

int I2C_DRV_Read_SiLabs(HI_U32 I2cNum, HI_U8 I2cDevAddr, HI_BOOL bSendSlave, HI_U32 I2cRegAddr, HI_U32 I2cRegAddrByteNum,
                 HI_U8 *pData, HI_U32 DataLen)
{
    HI_U32 dataTmp = 0xff;
    HI_U32 i;
    //    unsigned long   IntFlag;

    //local_irq_save(IntFlag);

    /* clear interrupt flag*/
    I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_ICR_REG), I2C_CLEAR_ALL);

    /* send register address which will need to read */
    I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_TXR_REG), (I2cDevAddr | READ_OPERATION));
    I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_COM_REB), I2C_WRITE | I2C_START);

    if (I2C_DRV_WaitWriteEnd(I2cNum))
    {
        //local_irq_restore(IntFlag);
        return HI_ERR_I2C_WRITE_TIMEOUT;
    }

    /* repetitivily read data */
    for (i = 0; i < 1; i++)
    {
        /*  the last byte don't need send ACK*/
        if (i == (DataLen - 1))
        {
            I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_COM_REB), (I2C_READ | (~I2C_SEND_ACK)));
        }
        /*  if i2c master receive data will send ACK*/
        else
        {
            I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_COM_REB), I2C_READ);
        }

        if (I2C_DRV_WaitRead(I2cNum))
        {
            //local_irq_restore(IntFlag);
            //HI_ERR_I2C("wait read data timeout!\n");
            return HI_ERR_I2C_READ_TIMEOUT;
        }

        dataTmp = I2C_READ_REG((g_I2cKernelAddr[I2cNum] + I2C_RXR_REG));
        *(pData + i) = dataTmp & 0xff;

        if (I2C_DRV_WaitWriteEnd(I2cNum))
        {
            //local_irq_restore(IntFlag);
            //HI_ERR_I2C("wait write data timeout!\n");
            return HI_ERR_I2C_WRITE_TIMEOUT;
        }
    }

    I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_COM_REB), I2C_STOP);
    if (I2C_DRV_WaitWriteEnd(I2cNum))
    {
        //local_irq_restore(IntFlag);
        //HI_ERR_I2C("wait write data timeout!\n");
        return HI_ERR_I2C_WRITE_TIMEOUT;
    }
    udelay(5);

    /* send register address which will need to read */
    I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_TXR_REG), (I2cDevAddr | READ_OPERATION));
    I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_COM_REB), I2C_WRITE | I2C_START);

    if (I2C_DRV_WaitWriteEnd(I2cNum))
    {
        //local_irq_restore(IntFlag);
        return HI_ERR_I2C_WRITE_TIMEOUT;
    }

    /* repetitivily read data */
    for (i = 0; i < DataLen; i++)
    {
        /*  the last byte don't need send ACK*/
        if (i == (DataLen - 1))
        {
            I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_COM_REB), (I2C_READ | (~I2C_SEND_ACK)));
        }
        /*  if i2c master receive data will send ACK*/
        else
        {
            I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_COM_REB), I2C_READ);
        }

        if (I2C_DRV_WaitRead(I2cNum))
        {
            //local_irq_restore(IntFlag);
            //HI_ERR_I2C("wait read data timeout!\n");
            return HI_ERR_I2C_READ_TIMEOUT;
        }

        dataTmp = I2C_READ_REG((g_I2cKernelAddr[I2cNum] + I2C_RXR_REG));
        *(pData + i) = dataTmp & 0xff;

        if (I2C_DRV_WaitWriteEnd(I2cNum))
        {
            //local_irq_restore(IntFlag);
            //HI_ERR_I2C("wait write data timeout!\n");
            return HI_ERR_I2C_WRITE_TIMEOUT;
        }
    }

    /* send stop flag bit*/
    I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_COM_REB), I2C_STOP);
    if (I2C_DRV_WaitWriteEnd(I2cNum))
    {
        //local_irq_restore(IntFlag);
        //HI_ERR_I2C("wait write data timeout!\n");
        return HI_ERR_I2C_WRITE_TIMEOUT;
    }

    //local_irq_restore(IntFlag);

    return HI_SUCCESS;

}

int I2C_DRV_Read_SiLabsx(HI_U32 I2cNum, HI_U8 I2cDevAddr, HI_BOOL bSendSlave, HI_U32 I2cRegAddr, HI_U32 I2cRegAddrByteNum,
                 HI_U8 *pData, HI_U32 DataLen)
{
    HI_U32 dataTmp = 0xff;
    HI_U32 i;

    //    unsigned long   IntFlag;

    //local_irq_save(IntFlag);
    I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_ICR_REG), I2C_CLEAR_ALL);

    if (bSendSlave)
    {
        /* clear interrupt flag*/
        I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_ICR_REG), I2C_CLEAR_ALL);

        /* send devide address*/
        I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_TXR_REG), (I2cDevAddr | READ_OPERATION));
        I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_COM_REB), (I2C_WRITE | I2C_START));


        if (I2C_DRV_WaitWriteEnd(I2cNum))
        {

            //local_irq_restore(IntFlag);
            //HI_ERR_I2C("wait write data timeout!\n");
            return HI_ERR_I2C_WRITE_TIMEOUT;
        }
    }
    I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_COM_REB), (I2C_READ | (~I2C_SEND_ACK)));

    /* send register address which will need to read */
    I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_TXR_REG), (I2cDevAddr | READ_OPERATION));
    I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_COM_REB), I2C_WRITE | I2C_START);
    if (I2C_DRV_WaitWriteEnd(I2cNum))
    {
        //local_irq_restore(IntFlag);
        return HI_ERR_I2C_WRITE_TIMEOUT;
    }

    /* repetitivily read data */
    for (i = 0; i < DataLen; i++)
    {
        /*  the last byte don't need send ACK*/
        if (i == (DataLen - 1))
        {
            I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_COM_REB), (I2C_READ | (~I2C_SEND_ACK)));
        }
        /*  if i2c master receive data will send ACK*/
        else
        {
            I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_COM_REB), I2C_READ);
        }

        if (I2C_DRV_WaitRead(I2cNum))
        {
            //local_irq_restore(IntFlag);
            //HI_ERR_I2C("wait read data timeout!\n");
            return HI_ERR_I2C_READ_TIMEOUT;
        }

        dataTmp = I2C_READ_REG((g_I2cKernelAddr[I2cNum] + I2C_RXR_REG));
        *(pData + i) = dataTmp & 0xff;

        if (I2C_DRV_WaitWriteEnd(I2cNum))
        {
            //local_irq_restore(IntFlag);
            //HI_ERR_I2C("wait write data timeout!\n");
            return HI_ERR_I2C_WRITE_TIMEOUT;
        }
    }

    /* send stop flag bit*/
    I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_COM_REB), I2C_STOP);
    if (I2C_DRV_WaitWriteEnd(I2cNum))
    {
        //local_irq_restore(IntFlag);
        //HI_ERR_I2C("wait write data timeout!\n");
        return HI_ERR_I2C_WRITE_TIMEOUT;
    }

    //local_irq_restore(IntFlag);

    return HI_SUCCESS;
}

HI_S32 I2C_DRV_Write_sony(HI_U32 I2cNum, HI_U8 I2cDevAddr, HI_U32 I2cRegAddr, HI_U32 I2cRegAddrByteNum, HI_U8 *pData, HI_U32 DataLen, HI_U8 u8Mode)
{
    HI_U32          i;
//    unsigned long   IntFlag;
    HI_U32          RegAddr;

    //local_irq_save(IntFlag);

    /*  clear interrupt flag*/
    I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_ICR_REG), I2C_CLEAR_ALL);

    /* send devide address */
    I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_TXR_REG), (I2cDevAddr & WRITE_OPERATION));

    if (u8Mode & SONY_I2C_START_EN)
    {
        I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_COM_REB),(I2C_WRITE | I2C_START));
    }
    else
    {
        I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_COM_REB),I2C_WRITE);
    }

    if (I2C_DRV_WaitWriteEnd(I2cNum))
    {
        //local_irq_restore(IntFlag);
        HI_ERR_I2C("wait write data timeout!%s, %d\n", __func__, __LINE__);
        return HI_ERR_I2C_WRITE_TIMEOUT;
    }

    /* send register address which will need to write */
    for(i=0; i<I2cRegAddrByteNum; i++)
    {
        RegAddr = I2cRegAddr >> ((I2cRegAddrByteNum -i -1) * 8);
        I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_TXR_REG), RegAddr);

        I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_COM_REB), I2C_WRITE);

        if (I2C_DRV_WaitWriteEnd(I2cNum))
        {
            //local_irq_restore(IntFlag);
            HI_ERR_I2C("wait write data timeout!%s, %d\n", __func__, __LINE__);
            return HI_ERR_I2C_WRITE_TIMEOUT;
        }
    }

    /* send data */
    for (i=0; i<DataLen; i++)
    {
        I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_TXR_REG), (*(pData+i)));
        I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_COM_REB), I2C_WRITE);

        if (I2C_DRV_WaitWriteEnd(I2cNum))
        {
            //local_irq_restore(IntFlag);
            HI_ERR_I2C("wait write data timeout!%s, %d\n", __func__, __LINE__);
            return HI_ERR_I2C_WRITE_TIMEOUT;
        }
    }

    /*   send stop flag bit*/
    if (u8Mode & SONY_I2C_STOP_EN)
    {
        I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_COM_REB), I2C_STOP);
        if (I2C_DRV_WaitWriteEnd(I2cNum))
        {
            //local_irq_restore(IntFlag);
            HI_ERR_I2C("wait write data timeout!%s, %d\n", __func__, __LINE__);
            return HI_ERR_I2C_WRITE_TIMEOUT;
        }
        //local_irq_restore(IntFlag);
    }

    return HI_SUCCESS;
}

int I2C_DRV_Read_sony(HI_U32 I2cNum, HI_U8 I2cDevAddr, HI_U32 I2cRegAddr, HI_U32 I2cRegAddrByteNum, HI_U8 *pData, HI_U32 DataLen, HI_U8 u8Mode)
{
    HI_U32          dataTmp = 0xff;
    HI_U32          i;
//    unsigned long   IntFlag;
    //HI_U32          RegAddr;

    //local_irq_save(IntFlag);

    if (u8Mode & SONY_I2C_START_EN)
    {
        /* send register address which will need to read */
        I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_TXR_REG), (I2cDevAddr | READ_OPERATION));
        I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_COM_REB), I2C_WRITE | I2C_START);

        if (I2C_DRV_WaitWriteEnd(I2cNum))
        {
            //local_irq_restore(IntFlag);
            return HI_ERR_I2C_WRITE_TIMEOUT;
        }
    }

    /* repetitivily read data */
    for(i=0; i<DataLen; i++)
    {
        /*  the last byte don't need send ACK*/
        if (i == (DataLen - 1))
        {
            I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_COM_REB), (I2C_READ | (~I2C_SEND_ACK)));
        }
        /*  if i2c master receive data will send ACK*/
        else
        {
            I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_COM_REB), I2C_READ);
        }

        if (I2C_DRV_WaitRead(I2cNum))
        {
            //local_irq_restore(IntFlag);
            HI_ERR_I2C("wait read data timeout!\n");
            return HI_ERR_I2C_READ_TIMEOUT;
        }

        dataTmp = I2C_READ_REG((g_I2cKernelAddr[I2cNum] + I2C_RXR_REG));
        *(pData+i)= dataTmp & 0xff;

        if (I2C_DRV_WaitWriteEnd(I2cNum))
        {
            //local_irq_restore(IntFlag);
            HI_ERR_I2C("wait write data timeout!\n");
            return HI_ERR_I2C_WRITE_TIMEOUT;
        }
    }

    if (u8Mode & SONY_I2C_STOP_EN)
    {
        /* send stop flag bit*/
        I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_COM_REB), I2C_STOP);
        if (I2C_DRV_WaitWriteEnd(I2cNum))
        {
            //local_irq_restore(IntFlag);
            HI_ERR_I2C("wait write data timeout!\n");
            return HI_ERR_I2C_WRITE_TIMEOUT;
        }
    }

    //local_irq_restore(IntFlag);

    return HI_SUCCESS;
}

HI_S32 I2C_DRV_Write_sonyIsr(HI_U32 I2cNum, HI_U8 I2cDevAddr, HI_U32 I2cRegAddr, HI_U32 I2cRegAddrByteNum, HI_U8 *pData, HI_U32 DataLen, HI_U8 u8Mode)
{
    HI_U32          i;
//    unsigned long   IntFlag;
    HI_U32          RegAddr;
    HI_U32          u32Len;
    HI_S32          s32Ret = HI_SUCCESS;
    HI_U32          u32TimeOut;

    /*  clear interrupt flag*/
    I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_ICR_REG), I2C_CLEAR_ALL);

    memset(&(g_astI2CBuff[I2cNum]), 0, sizeof(I2C_BUF_S));

    /* send devide address */
    u32Len = g_astI2CBuff[I2cNum].u32Len;
    g_astI2CBuff[I2cNum].stDataExchange[u32Len].u32Direction = 1;
    g_astI2CBuff[I2cNum].stDataExchange[u32Len].u8Data = I2cDevAddr & WRITE_OPERATION;
    if (u8Mode & SONY_I2C_START_EN)
    {
        g_astI2CBuff[I2cNum].stDataExchange[u32Len].u32Command = I2C_WRITE | I2C_START;
    }
    else
    {
        g_astI2CBuff[I2cNum].stDataExchange[u32Len].u32Command = I2C_WRITE;
    }
    g_astI2CBuff[I2cNum].u32Len++;


    /* send register address which will need to write */
    for (i = 0; i < I2cRegAddrByteNum; i++)
    {
        RegAddr = I2cRegAddr >> ((I2cRegAddrByteNum - i - 1) * 8);
        u32Len = g_astI2CBuff[I2cNum].u32Len;
        g_astI2CBuff[I2cNum].stDataExchange[u32Len].u32Direction = 1;
        g_astI2CBuff[I2cNum].stDataExchange[u32Len].u8Data = (HI_U8)RegAddr;
        g_astI2CBuff[I2cNum].stDataExchange[u32Len].u32Command = I2C_WRITE;
        g_astI2CBuff[I2cNum].u32Len++;
    }

    /* send data */
    for (i = 0; i < DataLen; i++)
    {
        u32Len = g_astI2CBuff[I2cNum].u32Len;
        g_astI2CBuff[I2cNum].stDataExchange[u32Len].u32Direction = 1;
        g_astI2CBuff[I2cNum].stDataExchange[u32Len].u8Data = *(pData + i);
        g_astI2CBuff[I2cNum].stDataExchange[u32Len].u32Command = I2C_WRITE;
        g_astI2CBuff[I2cNum].u32Len++;
    }


    /*   send stop flag bit*/
    if (u8Mode & SONY_I2C_STOP_EN)
    {
        /*   send stop flag bit*/
        u32Len = g_astI2CBuff[I2cNum].u32Len;
        g_astI2CBuff[I2cNum].stDataExchange[u32Len].u32Direction = 0;
        g_astI2CBuff[I2cNum].stDataExchange[u32Len].u32Command = I2C_STOP;
        g_astI2CBuff[I2cNum].u32Len++;
    }

    HI_INFO_I2C("index:%d, len:%d\n", g_astI2CBuff[I2cNum].u32Index, g_astI2CBuff[I2cNum].u32Len);
    I2C_DRV_ExchangeByte(I2cNum, g_astI2CBuff[I2cNum].u32Index++);

    u32TimeOut = g_astI2CBuff[I2cNum].u32Len * 8 * 100 * 1000 / g_aI2cRate[I2cNum];
    if (u32TimeOut < 100)
    {
        u32TimeOut = 100;
    }

    HI_INFO_I2C("timeout:%d\n", u32TimeOut);

    s32Ret = wait_event_interruptible_timeout(g_astI2cShare[I2cNum].I2cWaitQueue,
                                       (g_astI2CBuff[I2cNum].u32Index == g_astI2CBuff[I2cNum].u32Len)&&(ack_err[I2cNum]==0),
                                       msecs_to_jiffies(u32TimeOut));

    HI_INFO_I2C("s32Ret:%d\n", s32Ret);
    ack_err[I2cNum]=0;
    if (s32Ret > 0)
    {
        return HI_SUCCESS;
    }
    else
    {
        HI_ERR_I2C("%s, index:%d, len:%d\n", __FUNCTION__, g_astI2CBuff[I2cNum].u32Index, g_astI2CBuff[I2cNum].u32Len);
    }

    return HI_ERR_I2C_WRITE_TIMEOUT;
}

int I2C_DRV_Read_sonyIsr(HI_U32 I2cNum, HI_U8 I2cDevAddr, HI_U32 I2cRegAddr, HI_U32 I2cRegAddrByteNum, HI_U8 *pData, HI_U32 DataLen, HI_U8 u8Mode)
{
    HI_U32          i;
//    unsigned long   IntFlag;
    HI_S32 s32Ret = HI_SUCCESS;
    HI_U32  u32TimeOut;
    HI_U32 u32Len;

    /* clear interrupt flag*/
    I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_ICR_REG), I2C_CLEAR_ALL);

    memset(&(g_astI2CBuff[I2cNum]), 0, sizeof(I2C_BUF_S));

    if (u8Mode & SONY_I2C_START_EN)
    {
        /* send register address which will need to read */
        u32Len = g_astI2CBuff[I2cNum].u32Len;
        g_astI2CBuff[I2cNum].stDataExchange[u32Len].u32Direction = 1;
        g_astI2CBuff[I2cNum].stDataExchange[u32Len].u8Data = I2cDevAddr | READ_OPERATION;
        g_astI2CBuff[I2cNum].stDataExchange[u32Len].u32Command = I2C_WRITE | I2C_START;
        g_astI2CBuff[I2cNum].u32Len++;
    }

    /* repetitivily read data */
    for (i = 0; i < DataLen; i++)
    {
        u32Len = g_astI2CBuff[I2cNum].u32Len;
        g_astI2CBuff[I2cNum].stDataExchange[u32Len].u32Direction = 2;
        g_astI2CBuff[I2cNum].u32Len++;

        /*  the last byte don't need send ACK*/
        if (i == (DataLen - 1))
        {
            g_astI2CBuff[I2cNum].stDataExchange[u32Len].u32Command = I2C_READ | (~I2C_SEND_ACK);
        }
        /*  if i2c master receive data will send ACK*/
        else
        {
            g_astI2CBuff[I2cNum].stDataExchange[u32Len].u32Command = I2C_READ;
        }
    }

    if (u8Mode & SONY_I2C_STOP_EN)
    {
        /* send stop flag bit*/
        u32Len = g_astI2CBuff[I2cNum].u32Len;
        g_astI2CBuff[I2cNum].stDataExchange[u32Len].u32Direction = 0;
        g_astI2CBuff[I2cNum].stDataExchange[u32Len].u32Command = I2C_STOP;
        g_astI2CBuff[I2cNum].u32Len++;
    }

    HI_INFO_I2C("index:%d, len:%d\n", g_astI2CBuff[I2cNum].u32Index, g_astI2CBuff[I2cNum].u32Len);
    I2C_DRV_ExchangeByte(I2cNum, g_astI2CBuff[I2cNum].u32Index++);

    u32TimeOut = g_astI2CBuff[I2cNum].u32Len * 8 * 100 * 1000 / g_aI2cRate[I2cNum];
    if (u32TimeOut < 100)
    {
        u32TimeOut = 100;
    }

    HI_INFO_I2C("timeout:%d\n", u32TimeOut);
    s32Ret = wait_event_interruptible_timeout(g_astI2cShare[I2cNum].I2cWaitQueue,
                                        (g_astI2CBuff[I2cNum].u32Index == g_astI2CBuff[I2cNum].u32Len)&&(ack_err[I2cNum]==0),
                                       msecs_to_jiffies(u32TimeOut));

    HI_INFO_I2C("s32Ret:%d\n", s32Ret);
    ack_err[I2cNum]=0;
    if (s32Ret > 0)
    {
        for (i=0; i<g_astI2CBuff[I2cNum].u32Len;i++)
        {
            if (2 == g_astI2CBuff[I2cNum].stDataExchange[i].u32Direction)
            {
                *pData = g_astI2CBuff[I2cNum].stDataExchange[i].u8Data;
                pData++;
            }
        }

        return HI_SUCCESS;
    }
    else
    {
        HI_ERR_I2C("%s, index:%d, len:%d\n", __FUNCTION__, g_astI2CBuff[I2cNum].u32Index, g_astI2CBuff[I2cNum].u32Len);
    }

    return HI_ERR_I2C_READ_TIMEOUT;
}

HI_S32 I2C_DRV_WriteIsr(HI_U32 I2cNum, HI_U8 I2cDevAddr, HI_U32 I2cRegAddr, HI_U32 I2cRegAddrByteNum, HI_U8 *pData,
                     HI_U32 DataLen, HI_BOOL bWithStop)
{
    HI_U32 i;
    HI_S32 s32Ret = HI_SUCCESS;
    HI_U32  u32TimeOut;

    //    unsigned long   IntFlag;
    HI_U32 RegAddr;

    HI_U32 u32Len;

    //local_irq_save(IntFlag);

    /*  clear interrupt flag*/
    I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_ICR_REG), I2C_CLEAR_ALL);

    memset(&(g_astI2CBuff[I2cNum]), 0, sizeof(I2C_BUF_S));

    /* send devide address */
    u32Len = g_astI2CBuff[I2cNum].u32Len;
    g_astI2CBuff[I2cNum].stDataExchange[u32Len].u32Direction = 1;
    g_astI2CBuff[I2cNum].stDataExchange[u32Len].u8Data = I2cDevAddr & WRITE_OPERATION;
    g_astI2CBuff[I2cNum].stDataExchange[u32Len].u32Command = I2C_WRITE | I2C_START;
    g_astI2CBuff[I2cNum].u32Len++;

    /* send register address which will need to write */
    for (i = 0; i < I2cRegAddrByteNum; i++)
    {
        RegAddr = I2cRegAddr >> ((I2cRegAddrByteNum - i - 1) * 8);
        u32Len = g_astI2CBuff[I2cNum].u32Len;
        g_astI2CBuff[I2cNum].stDataExchange[u32Len].u32Direction = 1;
        g_astI2CBuff[I2cNum].stDataExchange[u32Len].u8Data = (HI_U8)RegAddr;
        g_astI2CBuff[I2cNum].stDataExchange[u32Len].u32Command = I2C_WRITE;
        g_astI2CBuff[I2cNum].u32Len++;
    }

    /* send data */
    for (i = 0; i < DataLen; i++)
    {
        u32Len = g_astI2CBuff[I2cNum].u32Len;
        g_astI2CBuff[I2cNum].stDataExchange[u32Len].u32Direction = 1;
        g_astI2CBuff[I2cNum].stDataExchange[u32Len].u8Data = *(pData + i);
        g_astI2CBuff[I2cNum].stDataExchange[u32Len].u32Command = I2C_WRITE;
        g_astI2CBuff[I2cNum].u32Len++;
    }

    if (bWithStop)
    {
        /*   send stop flag bit*/
        u32Len = g_astI2CBuff[I2cNum].u32Len;
        g_astI2CBuff[I2cNum].stDataExchange[u32Len].u32Direction = 0;
        g_astI2CBuff[I2cNum].stDataExchange[u32Len].u32Command = I2C_STOP;
        g_astI2CBuff[I2cNum].u32Len++;
    }

    HI_INFO_I2C("index:%d, len:%d\n", g_astI2CBuff[I2cNum].u32Index, g_astI2CBuff[I2cNum].u32Len);
    I2C_DRV_ExchangeByte(I2cNum, g_astI2CBuff[I2cNum].u32Index++);

    u32TimeOut = g_astI2CBuff[I2cNum].u32Len * 8 * 100 * 1000 / g_aI2cRate[I2cNum];
    //u32TimeOut = g_astI2CBuff[I2cNum].u32Len * 10;
    if (u32TimeOut < 100)
    {
        u32TimeOut = 100;
    }

    HI_INFO_I2C("timeout:%d\n", u32TimeOut);

    s32Ret = wait_event_interruptible_timeout(g_astI2cShare[I2cNum].I2cWaitQueue,
                                        (g_astI2CBuff[I2cNum].u32Index == g_astI2CBuff[I2cNum].u32Len)&&(ack_err[I2cNum]==0),
                                       msecs_to_jiffies(u32TimeOut));

    HI_INFO_I2C("s32Ret:%d\n", s32Ret);
    ack_err[I2cNum]=0;
    if (s32Ret > 0)
    {
        return HI_SUCCESS;
    }
    else
    {
        HI_ERR_I2C("%s, I2cNum=%d, I2cDevAddr=0x%x, index:%d, len:%d\n", __FUNCTION__, I2cNum, I2cDevAddr, g_astI2CBuff[I2cNum].u32Index, g_astI2CBuff[I2cNum].u32Len);
    }
    //local_irq_restore(IntFlag);

    return HI_ERR_I2C_WRITE_TIMEOUT;
}

int I2C_DRV_ReadIsr(HI_U32 I2cNum, HI_U8 I2cDevAddr, HI_BOOL bSendSlave, HI_U32 I2cRegAddr, HI_U32 I2cRegAddrByteNum,
                 HI_U8 *pData, HI_U32 DataLen)
{
    HI_U32 i;
    HI_S32 s32Ret = HI_SUCCESS;
    HI_U32  u32TimeOut;

    //    unsigned long   IntFlag;
    HI_U32 RegAddr;
    HI_U32 u32Len;

    //local_irq_save(IntFlag);

    /* clear interrupt flag*/
    I2C_WRITE_REG((g_I2cKernelAddr[I2cNum] + I2C_ICR_REG), I2C_CLEAR_ALL);

    memset(&(g_astI2CBuff[I2cNum]), 0, sizeof(I2C_BUF_S));

    if (bSendSlave)
    {
        u32Len = g_astI2CBuff[I2cNum].u32Len;
        g_astI2CBuff[I2cNum].stDataExchange[u32Len].u32Direction = 1;
        g_astI2CBuff[I2cNum].stDataExchange[u32Len].u8Data = I2cDevAddr & WRITE_OPERATION;
        g_astI2CBuff[I2cNum].stDataExchange[u32Len].u32Command = I2C_WRITE | I2C_START;
        g_astI2CBuff[I2cNum].u32Len++;
    }

    /* send register address which will need to write*/
    for (i = 0; i < I2cRegAddrByteNum; i++)
    {
        RegAddr = I2cRegAddr >> ((I2cRegAddrByteNum - i - 1) * 8);

        u32Len = g_astI2CBuff[I2cNum].u32Len;
        g_astI2CBuff[I2cNum].stDataExchange[u32Len].u32Direction = 1;
        g_astI2CBuff[I2cNum].stDataExchange[u32Len].u8Data = (HI_U8)RegAddr;
        g_astI2CBuff[I2cNum].stDataExchange[u32Len].u32Command = I2C_WRITE;
        g_astI2CBuff[I2cNum].u32Len++;
    }

    /* send device address which will need to read */
    u32Len = g_astI2CBuff[I2cNum].u32Len;
    g_astI2CBuff[I2cNum].stDataExchange[u32Len].u32Direction = 1;
    g_astI2CBuff[I2cNum].stDataExchange[u32Len].u8Data = I2cDevAddr | READ_OPERATION;
    g_astI2CBuff[I2cNum].stDataExchange[u32Len].u32Command = I2C_WRITE | I2C_START;
    g_astI2CBuff[I2cNum].u32Len++;

    /* repetitivily read data */
    for (i = 0; i < DataLen; i++)
    {
        u32Len = g_astI2CBuff[I2cNum].u32Len;
        g_astI2CBuff[I2cNum].stDataExchange[u32Len].u32Direction = 2;
        g_astI2CBuff[I2cNum].u32Len++;

        /*  the last byte don't need send ACK*/
        if (i == (DataLen - 1))
        {
            g_astI2CBuff[I2cNum].stDataExchange[u32Len].u32Command = I2C_READ | (~I2C_SEND_ACK);
        }
        /*  if i2c master receive data will send ACK*/
        else
        {
            g_astI2CBuff[I2cNum].stDataExchange[u32Len].u32Command = I2C_READ;
        }
    }

    /* send stop flag bit*/
    u32Len = g_astI2CBuff[I2cNum].u32Len;
    g_astI2CBuff[I2cNum].stDataExchange[u32Len].u32Direction = 0;
    g_astI2CBuff[I2cNum].stDataExchange[u32Len].u32Command = I2C_STOP;
    g_astI2CBuff[I2cNum].u32Len++;

    HI_INFO_I2C("index:%d, len:%d\n", g_astI2CBuff[I2cNum].u32Index, g_astI2CBuff[I2cNum].u32Len);
    I2C_DRV_ExchangeByte(I2cNum, g_astI2CBuff[I2cNum].u32Index++);

    u32TimeOut = g_astI2CBuff[I2cNum].u32Len * 8 * 100 * 1000 / g_aI2cRate[I2cNum];
    //u32TimeOut = g_astI2CBuff[I2cNum].u32Len * 10;
    if (u32TimeOut < 100)
    {
        u32TimeOut = 100;
    }

    HI_INFO_I2C("timeout:%d\n", u32TimeOut);
    s32Ret = wait_event_interruptible_timeout(g_astI2cShare[I2cNum].I2cWaitQueue,
                                      (g_astI2CBuff[I2cNum].u32Index == g_astI2CBuff[I2cNum].u32Len)&&(ack_err[I2cNum]==0),
                                       msecs_to_jiffies(u32TimeOut));

    HI_INFO_I2C("s32Ret:%d\n", s32Ret);
    ack_err[I2cNum]=0;
    if (s32Ret > 0)
    {
        for (i=0; i<g_astI2CBuff[I2cNum].u32Len;i++)
        {
            if (2 == g_astI2CBuff[I2cNum].stDataExchange[i].u32Direction)
            {
                *pData = g_astI2CBuff[I2cNum].stDataExchange[i].u8Data;
                pData++;
            }
        }

        return HI_SUCCESS;
    }
    else
    {
        HI_ERR_I2C("%s, I2cNum=%d, I2cDevAddr = 0x%x, index:%d, len:%d\n", __FUNCTION__, I2cNum, I2cDevAddr, g_astI2CBuff[I2cNum].u32Index, g_astI2CBuff[I2cNum].u32Len);
    }
    //local_irq_restore(IntFlag);

    return HI_ERR_I2C_READ_TIMEOUT;
}

/*****************************************************************************
 Prototype    :
 Description  : I2C  mudole suspend function
 Input        : None
 Output       : None
 Return Value : None
*****************************************************************************/
struct i2c_pm_Info
{
    unsigned int rsclh;
    unsigned int rscll;
};
static int i2cState = 0;
static struct i2c_pm_Info pmStatus[HI_I2C_MAX_NUM];

/*
static void  i2c_pm_reset(void)
{
    int i;
    i2cState = 0;
    for(i = 0; i < HI_I2C_MAX_NUM; i++)
    {
        if (i > HI_UNF_I2C_CHANNEL_QAM)
        {
            break;
        }
        pmStatus[i].rsclh = I2C_DFT_RATE;
        pmStatus[i].rscll = I2C_DFT_RATE;
    }
    return;
}
 */

/* beacuse this mudule have opened in  tuner/e2prom ModeuleInit, so relational opened operation register need to  store */
HI_S32 i2c_pm_suspend(PM_BASEDEV_S *pdev, pm_message_t state)
{
    int i;
    int ret;

    ret = down_trylock(&g_I2cMutex);
    if (ret)
    {
        HI_INFO_I2C("lock err!\n");
        return -1;
    }

    // 1

    // 2
    for (i = 0; i < HI_STD_I2C_NUM; i++)
    {
        /* disable all i2c interrupt */
        I2C_WRITE_REG((g_I2cKernelAddr[i] + I2C_CTRL_REG), 0x0);

        /* clear all i2c interrupt*/
        I2C_WRITE_REG((g_I2cKernelAddr[i] + I2C_ICR_REG), I2C_CLEAR_ALL);

        /*store  I2C_SCL_H and  I2C_SCL_L  register*/
        pmStatus[i].rsclh = I2C_READ_REG(g_I2cKernelAddr[i] + I2C_SCL_H_REG);
        pmStatus[i].rscll = I2C_READ_REG(g_I2cKernelAddr[i] + I2C_SCL_L_REG);
    }

    regI2CStore[0] = g_pstRegCrg->PERI_CRG27.u32;

    up(&g_I2cMutex);
    HI_PRINT("I2C suspend OK\n");
    return 0;
}

HI_S32 i2c_pm_resume(PM_BASEDEV_S *pdev)
{
    int i;
    int ret;

    ret = down_trylock(&g_I2cMutex);
    if (ret)
    {
        HI_INFO_I2C("lock err!\n");
        return -1;
    }

    g_pstRegCrg->PERI_CRG27.u32 = regI2CStore[0];

    for (i = 0; i < HI_STD_I2C_NUM; i++)
    {
        /*disable all i2c interrupt*/
        I2C_WRITE_REG((g_I2cKernelAddr[i] + I2C_CTRL_REG), 0x0);

        /*resume previous store register before suspend*/
        I2C_WRITE_REG((g_I2cKernelAddr[i] + I2C_SCL_H_REG), pmStatus[i].rsclh);
        I2C_WRITE_REG((g_I2cKernelAddr[i] + I2C_SCL_L_REG), pmStatus[i].rscll);

        /*  config scl clk rate*/
        (HI_VOID)I2C_DRV_SetRate(i, I2C_DFT_RATE);

        /*clear all i2c interrupt*/
        I2C_WRITE_REG((g_I2cKernelAddr[i] + I2C_ICR_REG), I2C_CLEAR_ALL);

        /*enable relative interrupt*/
        I2C_WRITE_REG((g_I2cKernelAddr[i] + I2C_CTRL_REG), (I2C_ENABLE | I2C_UNMASK_TOTAL | I2C_UNMASK_ALL));
    }

    //i2c_pm_reset();
    up(&g_I2cMutex);
    HI_PRINT("I2C resume OK\n");
    return 0;
}

HI_VOID ByteTransferOver(HI_U32 I2cNum)
{
    if (I2cNum >= HI_STD_I2C_NUM)
    {
        return ;
    }

    if (g_astI2CBuff[I2cNum].u32Index < g_astI2CBuff[I2cNum].u32Len)
    {
        I2C_DRV_ReadRXR(I2cNum, g_astI2CBuff[I2cNum].u32Index);
        I2C_DRV_ExchangeByte(I2cNum, g_astI2CBuff[I2cNum].u32Index);
        g_astI2CBuff[I2cNum].u32Index++;
    }
    else
    {
        /*最后一个命令是读时,需要处理*/
        if ((g_astI2CBuff[I2cNum].stDataExchange[g_astI2CBuff[I2cNum].u32Len-1].u32Command & I2C_READ) == I2C_READ)
        {
            HI_INFO_I2C("wakeup:index:%d, Len:%d\n", g_astI2CBuff[I2cNum].u32Index, g_astI2CBuff[I2cNum].u32Len);
            I2C_DRV_ReadRXR(I2cNum, g_astI2CBuff[I2cNum].u32Index);
            wake_up_interruptible(&g_astI2cShare[I2cNum].I2cWaitQueue);

        }
        else
        {
            HI_INFO_I2C("wakeup:index:%d, Len:%d\n", g_astI2CBuff[I2cNum].u32Index, g_astI2CBuff[I2cNum].u32Len);
            wake_up_interruptible(&g_astI2cShare[I2cNum].I2cWaitQueue);
        }
    }
}

#ifdef EXCHANGE_IN_INTERRUPT
irqreturn_t I2C_Isr(HI_S32 irq, HI_VOID *dev_id)
{
    HI_U32 IntState;
    HI_U32 u32Index;

    for (u32Index=0; u32Index<HI_STD_I2C_NUM; u32Index++)
    {
        if (irq == g_astI2cIRQ[u32Index])
        {
            break;
        }
    }

    if (u32Index >= HI_STD_I2C_NUM)
    {
        return IRQ_HANDLED;
    }

    IntState = I2C_HAL_GetSR(u32Index);

    if (IntState & I2C_OVER_INTR)
    {
        if(IntState & I2C_ACK_INTR)
        {
            ack_err[u32Index]=1;
        }
        else
        {
            ByteTransferOver(u32Index);
        }
    }
    if(IntState & I2C_ACK_INTR)
    {
            ack_err[u32Index]=1;
    }

    I2C_HAL_ClearInt(u32Index, I2C_CLEAR_OVER | I2C_CLEAR_ACK);

    return IRQ_HANDLED;
}
#endif

/*****************************************************************************/
static HI_VOID HI_DRV_I2C_Open(HI_VOID)
{
    HI_S32 Ret;
    HI_U32 i;
    static HI_CHAR szIrqName[HI_MAX_I2C_NUM][8];

    if (1 == i2cState)
    {
        return;
    }

    Ret = down_interruptible(&g_I2cMutex);
    if (Ret)
    {
        HI_INFO_I2C("lock g_I2cMutex error.\n");
        return;
    }

    for (i = 0; i < HI_STD_I2C_NUM; i++)
    {
        /*disable all i2c interrupt*/
        I2C_WRITE_REG((g_I2cKernelAddr[i] + I2C_CTRL_REG), 0x0);

        /*  config scl clk rate*/
        (HI_VOID)I2C_DRV_SetRate(i, I2C_DFT_RATE);

        /*clear all i2c interrupt*/
        I2C_WRITE_REG((g_I2cKernelAddr[i] + I2C_ICR_REG), I2C_CLEAR_ALL);

        /*enable relative interrupt*/
        I2C_WRITE_REG((g_I2cKernelAddr[i] + I2C_CTRL_REG), (I2C_ENABLE | I2C_UNMASK_TOTAL | I2C_UNMASK_ALL));

        HI_INIT_MUTEX(&g_astI2cShare[i].I2cSem);

        init_waitqueue_head(&g_astI2cShare[i].I2cWaitQueue);

        memset(&szIrqName[i], 0, sizeof(szIrqName[i]));
        snprintf(szIrqName[i], sizeof(szIrqName[0]), "hi_i2c%d_irq", i);

    #ifdef EXCHANGE_IN_INTERRUPT
        Ret = request_irq(g_astI2cIRQ[i], I2C_Isr, IRQF_DISABLED, szIrqName[i], NULL);
        if (Ret != HI_SUCCESS)
        {
            HI_FATAL_I2C("register i2c %d Isr failed 0x%x.\n", i, Ret);
        }
		else
		{
			if(HI_SUCCESS != HI_DRV_SYS_SetIrqAffinity(HI_ID_I2C, g_astI2cIRQ[i]))
			{
            	HI_FATAL_I2C("HI_DRV_SYS_SetIrqAffinity failed.\n");
        	}	
		}
    #endif
    }

    i2cState = 1;

    up(&g_I2cMutex);
    return;
}

HI_S32 I2C_Ioctl(struct file *file, unsigned int cmd, unsigned long arg)
{
    HI_S32  Ret;
    HI_U8  *pData = NULL;
    I2C_DATA_S I2cData;
    I2C_RATE_S I2cRate;
    void __user *argp = (void __user*)arg;

    switch (cmd)
    {
        case CMD_I2C_WRITE:
        {
            if (copy_from_user(&I2cData, argp, sizeof(I2C_DATA_S)))
            {
                HI_INFO_I2C("copy data from user fail!\n");
                Ret = HI_ERR_I2C_COPY_DATA_ERR;
                break;
            }

            if ((I2cData.DataLen > HI_I2C_MAX_LENGTH) || (I2cData.I2cNum >= HI_MAX_I2C_NUM))
            {
                Ret = HI_ERR_I2C_INVALID_PARA;
                break;
            }

            pData = HI_KMALLOC(HI_ID_I2C, I2cData.DataLen, GFP_KERNEL);
            if (!pData)
            {
                HI_ERR_I2C("i2c kmalloc fail!\n");
                Ret = HI_ERR_I2C_MALLOC_ERR;
                break;
            }

            if (copy_from_user(pData, I2cData.pData, I2cData.DataLen))
            {
                HI_INFO_I2C("copy data from user fail!\n");
                HI_KFREE(HI_ID_I2C, pData);
                Ret = HI_ERR_I2C_COPY_DATA_ERR;
                break;
            }

            Ret = down_interruptible(&(g_astI2cShare[I2cData.I2cNum].I2cSem));
            if (Ret)
            {
                HI_KFREE(HI_ID_I2C, pData);
                HI_INFO_I2C("lock g_I2cMutex error.\n");
                return HI_FAILURE;
            }

            #ifdef EXCHANGE_IN_INTERRUPT
            Ret = I2C_DRV_WriteIsr(I2cData.I2cNum, I2cData.I2cDevAddr, I2cData.I2cRegAddr, I2cData.I2cRegCount, pData,
                                I2cData.DataLen, HI_TRUE);
            #else
            Ret = I2C_DRV_Write(I2cData.I2cNum, I2cData.I2cDevAddr, I2cData.I2cRegAddr, I2cData.I2cRegCount, pData,
                                I2cData.DataLen, HI_TRUE);
            #endif
            HI_KFREE(HI_ID_I2C, pData);

            up(&(g_astI2cShare[I2cData.I2cNum].I2cSem));

            break;
        }

        case CMD_I2C_READ:
        {
            if (copy_from_user(&I2cData, argp, sizeof(I2C_DATA_S)))
            {
                HI_INFO_I2C("copy data from user fail!\n");
                Ret = HI_ERR_I2C_COPY_DATA_ERR;
                break;
            }

            if ((I2cData.DataLen > HI_I2C_MAX_LENGTH) || (I2cData.I2cNum >= HI_MAX_I2C_NUM))
            {
                Ret = HI_ERR_I2C_INVALID_PARA;
                break;
            }

            pData = HI_KMALLOC(HI_ID_I2C, I2cData.DataLen, GFP_KERNEL);
            if (!pData)
            {
                HI_ERR_I2C("i2c kmalloc fail!\n");
                Ret = HI_ERR_I2C_MALLOC_ERR;
                break;
            }

            Ret = down_interruptible(&(g_astI2cShare[I2cData.I2cNum].I2cSem));
            if (Ret)
            {
                HI_KFREE(HI_ID_I2C, pData);
                HI_INFO_I2C("lock g_I2cMutex error.\n");
                return HI_FAILURE;
            }

            #ifdef EXCHANGE_IN_INTERRUPT
            Ret = I2C_DRV_ReadIsr(I2cData.I2cNum, I2cData.I2cDevAddr, HI_TRUE, I2cData.I2cRegAddr, I2cData.I2cRegCount,
                               pData, I2cData.DataLen);
            #else
            Ret = I2C_DRV_Read(I2cData.I2cNum, I2cData.I2cDevAddr, HI_TRUE, I2cData.I2cRegAddr, I2cData.I2cRegCount,
                               pData, I2cData.DataLen);
            #endif
            if (HI_SUCCESS == Ret)
            {
                if (copy_to_user(I2cData.pData, pData, I2cData.DataLen))
                {
                    HI_INFO_I2C("copy data to user fail!\n");
                    Ret = HI_ERR_I2C_COPY_DATA_ERR;
                }
            }

            HI_KFREE(HI_ID_I2C, pData);

            up(&(g_astI2cShare[I2cData.I2cNum].I2cSem));

            break;
        }

        case  CMD_I2C_SET_RATE:
        {
            if (copy_from_user(&I2cRate, argp, sizeof(I2C_RATE_S)))
            {
                HI_INFO_I2C("copy data from user fail!\n");
                Ret = HI_FAILURE;
                break;
            }

            if (I2cRate.I2cNum >= HI_MAX_I2C_NUM)
            {
                Ret = HI_ERR_I2C_INVALID_PARA;
                break;
            }

            Ret = down_interruptible(&(g_astI2cShare[I2cRate.I2cNum].I2cSem));
            if (Ret)
            {
                HI_INFO_I2C("lock g_I2cMutex error.\n");
                return HI_FAILURE;
            }

            Ret = I2C_DRV_SetRate(I2cRate.I2cNum, I2cRate.I2cRate);

            up(&(g_astI2cShare[I2cRate.I2cNum].I2cSem));
            break;
        }

        default:
        {
            return -ENOIOCTLCMD;
        }
    }

    return Ret;
}

#ifdef CONFIG_COMPAT
HI_S32 I2C_Compat_Ioctl(struct file *file, unsigned int cmd, unsigned long arg)
{
    HI_S32  Ret;
    HI_U8  *pData = NULL;
    I2C_DATA_COMPAT_S I2cData;
    I2C_RATE_S I2cRate;
    void __user *argp = (void __user*)arg;

    switch (cmd)
    {
        case CMD_I2C_WRITE:
        {
            if (copy_from_user(&I2cData, argp, sizeof(I2C_DATA_COMPAT_S)))
            {
                HI_INFO_I2C("copy data from user fail!\n");
                Ret = HI_ERR_I2C_COPY_DATA_ERR;
                break;
            }

            if ((I2cData.DataLen > HI_I2C_MAX_LENGTH) || (I2cData.I2cNum >= HI_MAX_I2C_NUM))
            {
                Ret = HI_ERR_I2C_INVALID_PARA;
                break;
            }

            pData = HI_KMALLOC(HI_ID_I2C, I2cData.DataLen, GFP_KERNEL);
            if (!pData)
            {
                HI_ERR_I2C("i2c kmalloc fail!\n");
                Ret = HI_ERR_I2C_MALLOC_ERR;
                break;
            }

            if (copy_from_user(pData, (HI_U8 *)compat_ptr(I2cData.pData), I2cData.DataLen))
            {
                HI_INFO_I2C("copy data from user fail!\n");
                HI_KFREE(HI_ID_I2C, pData);
                Ret = HI_ERR_I2C_COPY_DATA_ERR;
                break;
            }

            Ret = down_interruptible(&(g_astI2cShare[I2cData.I2cNum].I2cSem));
            if (Ret)
            {
                HI_KFREE(HI_ID_I2C, pData);
                HI_INFO_I2C("lock g_I2cMutex error.\n");
                return HI_FAILURE;
            }

            #ifdef EXCHANGE_IN_INTERRUPT
            Ret = I2C_DRV_WriteIsr(I2cData.I2cNum, I2cData.I2cDevAddr, I2cData.I2cRegAddr, I2cData.I2cRegCount, pData,
                                I2cData.DataLen, HI_TRUE);
            #else
            Ret = I2C_DRV_Write(I2cData.I2cNum, I2cData.I2cDevAddr, I2cData.I2cRegAddr, I2cData.I2cRegCount, pData,
                                I2cData.DataLen, HI_TRUE);
            #endif
            HI_KFREE(HI_ID_I2C, pData);

            up(&(g_astI2cShare[I2cData.I2cNum].I2cSem));

            break;
        }

        case CMD_I2C_READ:
        {
            if (copy_from_user(&I2cData, argp, sizeof(I2C_DATA_COMPAT_S)))
            {
                HI_INFO_I2C("copy data from user fail!\n");
                Ret = HI_ERR_I2C_COPY_DATA_ERR;
                break;
            }

            if ((I2cData.DataLen > HI_I2C_MAX_LENGTH) || (I2cData.I2cNum >= HI_MAX_I2C_NUM))
            {
                Ret = HI_ERR_I2C_INVALID_PARA;
                break;
            }

            pData = HI_KMALLOC(HI_ID_I2C, I2cData.DataLen, GFP_KERNEL);
            if (!pData)
            {
                HI_ERR_I2C("i2c kmalloc fail!\n");
                Ret = HI_ERR_I2C_MALLOC_ERR;
                break;
            }

            Ret = down_interruptible(&(g_astI2cShare[I2cData.I2cNum].I2cSem));
            if (Ret)
            {
                HI_KFREE(HI_ID_I2C, pData);
                HI_INFO_I2C("lock g_I2cMutex error.\n");
                return HI_FAILURE;
            }

            #ifdef EXCHANGE_IN_INTERRUPT
            Ret = I2C_DRV_ReadIsr(I2cData.I2cNum, I2cData.I2cDevAddr, HI_TRUE, I2cData.I2cRegAddr, I2cData.I2cRegCount,
                               pData, I2cData.DataLen);
            #else
            Ret = I2C_DRV_Read(I2cData.I2cNum, I2cData.I2cDevAddr, HI_TRUE, I2cData.I2cRegAddr, I2cData.I2cRegCount,
                               pData, I2cData.DataLen);
            #endif
            if (HI_SUCCESS == Ret)
            {
                if (copy_to_user((HI_U8 *)compat_ptr(I2cData.pData), pData, I2cData.DataLen))
                {
                    HI_INFO_I2C("copy data to user fail!\n");
                    Ret = HI_ERR_I2C_COPY_DATA_ERR;
                }
            }

            HI_KFREE(HI_ID_I2C, pData);

            up(&(g_astI2cShare[I2cData.I2cNum].I2cSem));

            break;
        }

        case  CMD_I2C_SET_RATE:
        {
            if (copy_from_user(&I2cRate, argp, sizeof(I2C_RATE_S)))
            {
                HI_INFO_I2C("copy data from user fail!\n");
                Ret = HI_FAILURE;
                break;
            }

            if (I2cRate.I2cNum >= HI_MAX_I2C_NUM)
            {
                Ret = HI_ERR_I2C_INVALID_PARA;
                break;
            }

            Ret = down_interruptible(&(g_astI2cShare[I2cRate.I2cNum].I2cSem));
            if (Ret)
            {
                HI_INFO_I2C("lock g_I2cMutex error.\n");
                return HI_FAILURE;
            }

            Ret = I2C_DRV_SetRate(I2cRate.I2cNum, I2cRate.I2cRate);

            up(&(g_astI2cShare[I2cRate.I2cNum].I2cSem));
            break;
        }

        default:
        {
            return -ENOIOCTLCMD;
        }
    }

    return Ret;
}
#endif

HI_S32 I2C_EnableClock(HI_VOID)
{
	HI_U32 u32RegVal = 0;
	HI_U32 u32Timeout = 0;

    u32RegVal  = g_pstRegCrg->PERI_CRG27.u32;
    u32RegVal &= ~0x222222;
    u32RegVal |= 0x111111;
    g_pstRegCrg->PERI_CRG27.u32 = u32RegVal;
	while(u32Timeout < 100)
	{
		u32RegVal  = g_pstRegCrg->PERI_CRG27.u32;
		if((u32RegVal & 0xFFFFFF) != 0x111111 )
		{
			u32Timeout++;
			udelay(1);
		}
		else
		{
			break;
		}
	}
	if(u32Timeout >= 100)
	{
		HI_ERR_I2C("I2C Open clock timeout!!\n");
		return HI_FAILURE;
	}
	mb();
	return HI_SUCCESS;
}

HI_S32 I2C_Reset(HI_VOID)
{
	HI_U32 u32RegVal = 0;
	HI_U32 u32Timeout = 0;
	
	u32RegVal  = g_pstRegCrg->PERI_CRG27.u32;
    u32RegVal |= 0x222222;
    g_pstRegCrg->PERI_CRG27.u32 = u32RegVal;

	while(u32Timeout < 100)
	{
		u32RegVal  = g_pstRegCrg->PERI_CRG27.u32;
		if((u32RegVal & 0x222222) != 0x222222 )
		{
			u32Timeout++;
			udelay(1);
		}
		else
		{
			break;
		}
	}
	if(u32Timeout >= 100)
	{
		HI_ERR_I2C("I2C reset clock timeout!!\n");
		return HI_FAILURE;
	}
	mb();
	return HI_SUCCESS;

}

HI_S32 HI_DRV_I2C_Init(HI_VOID)
{
    HI_S32 s32Ret = HI_SUCCESS;
    HI_U32 i;

    s32Ret = HI_DRV_MODULE_Register(HI_ID_I2C, "HI_I2C", (HI_VOID *)&g_stI2cExtFuncs);
    if (HI_SUCCESS != s32Ret)
    {
        HI_ERR_I2C("I2C register failed\n");
        return HI_FAILURE;
    }

    for (i = 0; i < HI_STD_I2C_NUM; i++)
    {
        g_I2cKernelAddr[i] = (HI_U8 *)ioremap_nocache(g_I2cPhyAddr[i], I2C_ADDR_SIZE);
        if (g_I2cKernelAddr[i] == HI_NULL)
        {
            HI_ERR_I2C("ioremap_nocache err! \n");
            return HI_FAILURE;
        }
    }

#if    defined(CHIP_TYPE_hi3716cv200)   \
    || defined(CHIP_TYPE_hi3716mv400)   \
    || defined(CHIP_TYPE_hi3718cv100)   \
    || defined(CHIP_TYPE_hi3719cv100)   \
    || defined(CHIP_TYPE_hi3718mv100)   \
    || defined(CHIP_TYPE_hi3719mv100)   \
    || defined(CHIP_TYPE_hi3798mv100)   \
    || defined(CHIP_TYPE_hi3796mv100)
	if(I2C_EnableClock())
		goto ERR;
#elif defined(CHIP_TYPE_hi3716mv410) || defined(CHIP_TYPE_hi3716mv420)
	if(I2C_EnableClock())
		goto ERR;
#elif  defined(CHIP_TYPE_hi3798cv200) || defined(CHIP_TYPE_hi3798hv100)
	if(I2C_EnableClock())
		goto ERR;
#endif

    HI_DRV_I2C_Open();

    return HI_SUCCESS;

ERR:
	for (i = 0; i < HI_STD_I2C_NUM; i++)
    {
        iounmap(g_I2cKernelAddr[i]);
        g_I2cKernelAddr[i] = HI_NULL;
    }

	s32Ret = HI_DRV_MODULE_UnRegister(HI_ID_I2C);
    if (HI_SUCCESS != s32Ret)
    {
        HI_ERR_I2C("I2C unregister failed\n");
    }
	return HI_FAILURE;
}

HI_VOID HI_DRV_I2C_DeInit(HI_VOID)
{
    HI_S32 s32Ret = HI_SUCCESS;
    HI_U32 i;

#if    defined(CHIP_TYPE_hi3716cv200)   \
    || defined(CHIP_TYPE_hi3716mv400)   \
    || defined(CHIP_TYPE_hi3718cv100)   \
    || defined(CHIP_TYPE_hi3719cv100)   \
    || defined(CHIP_TYPE_hi3718mv100)   \
    || defined(CHIP_TYPE_hi3719mv100)   \
    || defined(CHIP_TYPE_hi3798mv100)   \
    || defined(CHIP_TYPE_hi3796mv100)
	if(I2C_Reset())
		return;
#elif defined(CHIP_TYPE_hi3716mv410) || defined(CHIP_TYPE_hi3716mv420)
	if(I2C_Reset())
		return;
#elif  defined(CHIP_TYPE_hi3798cv200) || defined(CHIP_TYPE_hi3798hv100)
	if(I2C_Reset())
		return;
#endif

#ifdef EXCHANGE_IN_INTERRUPT
    for (i = 0; i < HI_STD_I2C_NUM; i++)
    {
        free_irq(g_astI2cIRQ[i], HI_NULL);
    }
#endif

    i2cState = 0;

    for (i = 0; i < HI_STD_I2C_NUM; i++)
    {
        iounmap(g_I2cKernelAddr[i]);
        g_I2cKernelAddr[i] = HI_NULL;
    }

    s32Ret = HI_DRV_MODULE_UnRegister(HI_ID_I2C);
    if (HI_SUCCESS != s32Ret)
    {
        HI_ERR_I2C("I2C unregister failed\n");
    }

    return;
}

HI_S32 HI_DRV_I2C_WriteConfig(HI_U32 I2cNum, HI_U8 I2cDevAddr)
{
    HI_S32 Ret;

    if (I2cNum >= HI_STD_I2C_NUM)
    {
        HI_ERR_I2C("I2cNum(%d) is wrong, STD_I2C_NUM is %d\n", I2cNum, HI_STD_I2C_NUM);
        return HI_FAILURE;
    }

    Ret = down_interruptible(&(g_astI2cShare[I2cNum].I2cSem));
    if (Ret)
    {
        HI_INFO_I2C("lock g_I2cMutex error.\n");
        return HI_FAILURE;
    }

    Ret = I2C_DRV_WriteConfig(I2cNum, I2cDevAddr);

    up(&(g_astI2cShare[I2cNum].I2cSem));

    return Ret;
}

HI_S32 HI_DRV_I2C_Write(HI_U32 I2cNum, HI_U8 I2cDevAddr, HI_U32 I2cRegAddr, HI_U32 I2cRegAddrByteNum, HI_U8 *pData,
                        HI_U32 DataLen)
{
    HI_S32 Ret;

    if (I2cNum >= HI_STD_I2C_NUM)
    {
        HI_ERR_I2C("I2cNum(%d) is wrong, STD_I2C_NUM is %d\n", I2cNum, HI_STD_I2C_NUM);
        return HI_FAILURE;
    }

    Ret = down_interruptible(&(g_astI2cShare[I2cNum].I2cSem));
    if (Ret)
    {
        HI_INFO_I2C("lock g_I2cMutex error.\n");
        return HI_FAILURE;
    }

    #ifdef EXCHANGE_IN_INTERRUPT
    Ret = I2C_DRV_WriteIsr(I2cNum, I2cDevAddr, I2cRegAddr, I2cRegAddrByteNum, pData, DataLen, HI_TRUE);
    #else
    Ret = I2C_DRV_Write(I2cNum, I2cDevAddr, I2cRegAddr, I2cRegAddrByteNum, pData, DataLen, HI_TRUE);
    #endif
    HI_INFO_I2C("Ret=0x%x, I2cNum=%d, DevAddr=0x%x, RegAddr=0x%x, Num=%d, Len=%d, data0=0x%x\n", Ret, I2cNum,
                I2cDevAddr, I2cRegAddr, I2cRegAddrByteNum, DataLen, pData[0]);

    up(&(g_astI2cShare[I2cNum].I2cSem));

    return Ret;
}

HI_S32 HI_DRV_I2C_Write_NoSTOP(HI_U32 I2cNum, HI_U8 I2cDevAddr, HI_U32 I2cRegAddr, HI_U32 I2cRegAddrByteNum,
                               HI_U8 *pData, HI_U32 DataLen)
{
    HI_S32 Ret;

    if (I2cNum >= HI_STD_I2C_NUM)
    {
        HI_ERR_I2C("I2cNum(%d) is wrong, STD_I2C_NUM is %d\n", I2cNum, HI_STD_I2C_NUM);
        return HI_FAILURE;
    }

    Ret = down_interruptible(&(g_astI2cShare[I2cNum].I2cSem));
    if (Ret)
    {
        HI_ERR_I2C("lock g_I2cMutex error.\n");
        return HI_FAILURE;
    }

    #ifdef EXCHANGE_IN_INTERRUPT
    Ret = I2C_DRV_WriteIsr(I2cNum, I2cDevAddr, I2cRegAddr, I2cRegAddrByteNum, pData, DataLen, HI_FALSE);
    #else
    Ret = I2C_DRV_Write(I2cNum, I2cDevAddr, I2cRegAddr, I2cRegAddrByteNum, pData, DataLen, HI_FALSE);
    #endif
    HI_INFO_I2C("Ret=0x%x, I2cNum=%d, DevAddr=0x%x, RegAddr=0x%x, Num=%d, Len=%d, data0=0x%x\n", Ret, I2cNum,
                I2cDevAddr, I2cRegAddr, I2cRegAddrByteNum, DataLen, pData[0]);

    up(&(g_astI2cShare[I2cNum].I2cSem));

    return Ret;
}

HI_S32 HI_DRV_I2C_Read(HI_U32 I2cNum, HI_U8 I2cDevAddr, HI_U32 I2cRegAddr, HI_U32 I2cRegAddrByteNum, HI_U8 *pData,
                       HI_U32 DataLen)
{
    HI_S32 Ret;

    if (I2cNum >= HI_STD_I2C_NUM)
    {
        HI_ERR_I2C("I2cNum(%d) is wrong, STD_I2C_NUM is %d\n", I2cNum, HI_STD_I2C_NUM);
        return HI_FAILURE;
    }

    Ret = down_interruptible(&(g_astI2cShare[I2cNum].I2cSem));
    if (Ret)
    {
        HI_ERR_I2C("lock g_I2cMutex error.\n");
        return HI_FAILURE;
    }

    #ifdef EXCHANGE_IN_INTERRUPT
    Ret = I2C_DRV_ReadIsr(I2cNum, I2cDevAddr, HI_TRUE, I2cRegAddr, I2cRegAddrByteNum, pData, DataLen);
    #else
    Ret = I2C_DRV_Read(I2cNum, I2cDevAddr, HI_TRUE, I2cRegAddr, I2cRegAddrByteNum, pData, DataLen);
    #endif
    HI_INFO_I2C("Ret=0x%x, I2cNum=%d, DevAddr=0x%x, RegAddr=0x%x, Num=%d, Len=%d\n", Ret, I2cNum, I2cDevAddr,
                I2cRegAddr, I2cRegAddrByteNum, DataLen);

    up(&(g_astI2cShare[I2cNum].I2cSem));

    return Ret;
}

HI_S32 HI_DRV_I2C_Read_SiLabs(HI_U32 I2cNum, HI_U8 I2cDevAddr, HI_U32 I2cRegAddr, HI_U32 I2cRegAddrByteNum, HI_U8 *pData,
                       HI_U32 DataLen)
{
    HI_S32 Ret;

    if (I2cNum >= HI_STD_I2C_NUM)
    {
        HI_ERR_I2C("I2cNum(%d) is wrong, STD_I2C_NUM is %d\n", I2cNum, HI_STD_I2C_NUM);
        return HI_FAILURE;
    }

    Ret = down_interruptible(&g_I2cMutex);
    if (Ret)
    {
        HI_INFO_I2C("lock g_I2cMutex error.\n");
        return HI_FAILURE;
    }

    Ret = I2C_DRV_Read_SiLabs(I2cNum, I2cDevAddr, HI_TRUE, I2cRegAddr, I2cRegAddrByteNum, pData, DataLen);
    HI_INFO_I2C("Ret=0x%x, I2cNum=%d, DevAddr=0x%x, RegAddr=0x%x, Num=%d, Len=%d\n", Ret, I2cNum, I2cDevAddr,
                I2cRegAddr, I2cRegAddrByteNum, DataLen);

    up(&g_I2cMutex);

    return Ret;
}

HI_S32 HI_DRV_I2C_Write_sony(HI_U32 I2cNum, HI_U8 I2cDevAddr, HI_U32 I2cRegAddr, HI_U32 I2cRegAddrByteNum, HI_U8 *pData, HI_U32 DataLen, HI_U8 u8Mode)
{
    HI_S32  Ret;

    Ret = down_interruptible(&(g_astI2cShare[I2cNum].I2cSem));
    if (Ret)
    {
        HI_ERR_I2C("lock g_I2cMutex error.\n");
        return HI_FAILURE;
    }

    #ifdef EXCHANGE_IN_INTERRUPT
    Ret = I2C_DRV_Write_sonyIsr(I2cNum, I2cDevAddr, I2cRegAddr, I2cRegAddrByteNum, pData, DataLen, u8Mode);
    #else
    Ret = I2C_DRV_Write_sony(I2cNum, I2cDevAddr, I2cRegAddr, I2cRegAddrByteNum, pData, DataLen, u8Mode);
    #endif
    HI_INFO_I2C("Ret=0x%x, I2cNum=%d, DevAddr=0x%x, RegAddr=0x%x, Num=%d, Len=%d, data0=0x%x\n", Ret, I2cNum, I2cDevAddr, I2cRegAddr, I2cRegAddrByteNum, DataLen, pData[0]);

    up(&(g_astI2cShare[I2cNum].I2cSem));

    return Ret;
}

HI_S32 HI_DRV_I2C_Read_sony(HI_U32 I2cNum, HI_U8 I2cDevAddr, HI_U32 I2cRegAddr, HI_U32 I2cRegAddrByteNum, HI_U8 *pData, HI_U32 DataLen, HI_U8 u8Mode)
{
    HI_S32  Ret;

    Ret = down_interruptible(&(g_astI2cShare[I2cNum].I2cSem));
    if (Ret)
    {
        HI_ERR_I2C("lock g_I2cMutex error.\n");
        return HI_FAILURE;
    }

    #ifdef EXCHANGE_IN_INTERRUPT
    Ret = I2C_DRV_Read_sonyIsr(I2cNum, I2cDevAddr, I2cRegAddr, I2cRegAddrByteNum, pData, DataLen, u8Mode);
    #else
    Ret = I2C_DRV_Read_sony(I2cNum, I2cDevAddr, I2cRegAddr, I2cRegAddrByteNum, pData, DataLen, u8Mode);
    #endif
    HI_INFO_I2C("Ret=0x%x, I2cNum=%d, DevAddr=0x%x, RegAddr=0x%x, Num=%d, Len=%d\n", Ret, I2cNum, I2cDevAddr, I2cRegAddr, I2cRegAddrByteNum, DataLen);

    up(&(g_astI2cShare[I2cNum].I2cSem));

    return Ret;
}

/* Added begin: l00185424 20120131, for avl6211 demod */
/* Some I2C needn't send slave address before read */
HI_S32 HI_DRV_I2C_ReadDirectly(HI_U32 I2cNum, HI_U8 I2cDevAddr, HI_U32 I2cRegAddr, HI_U32 I2cRegAddrByteNum,
                               HI_U8 *pData, HI_U32 DataLen)
{
    HI_S32 Ret;

    if (I2cNum >= HI_STD_I2C_NUM)
    {
        HI_ERR_I2C("I2cNum(%d) is wrong, STD_I2C_NUM is %d\n", I2cNum, HI_STD_I2C_NUM);
        return HI_FAILURE;
    }

    Ret = down_interruptible(&(g_astI2cShare[I2cNum].I2cSem));
    if (Ret)
    {
        HI_INFO_I2C("lock g_I2cMutex error.\n");
        return HI_FAILURE;
    }

    #ifdef EXCHANGE_IN_INTERRUPT
    Ret = I2C_DRV_ReadIsr(I2cNum, I2cDevAddr, HI_FALSE, I2cRegAddr, I2cRegAddrByteNum, pData, DataLen);
    #else
    Ret = I2C_DRV_Read(I2cNum, I2cDevAddr, HI_FALSE, I2cRegAddr, I2cRegAddrByteNum, pData, DataLen);
    #endif
    HI_INFO_I2C("Ret=0x%x, I2cNum=%d, DevAddr=0x%x, RegAddr=0x%x, Num=%d, Len=%d\n", Ret, I2cNum, I2cDevAddr,
                I2cRegAddr, I2cRegAddrByteNum, DataLen);

    up(&(g_astI2cShare[I2cNum].I2cSem));

    return Ret;
}

HI_S32 HI_DRV_I2C_SetRate(HI_U32 I2cNum, HI_U32 I2cRate)
{
    return I2C_DRV_SetRate(I2cNum, I2cRate);
}

/* Added end: l00185424 20120131, for avl6211 demod */

#ifndef MODULE
EXPORT_SYMBOL(I2C_Ioctl);
#endif

EXPORT_SYMBOL(HI_DRV_I2C_Init);
EXPORT_SYMBOL(HI_DRV_I2C_DeInit);

#if 1
EXPORT_SYMBOL(HI_DRV_I2C_WriteConfig);
EXPORT_SYMBOL(HI_DRV_I2C_Write);
EXPORT_SYMBOL(HI_DRV_I2C_Read);
EXPORT_SYMBOL(HI_DRV_I2C_Read_SiLabs);
EXPORT_SYMBOL(HI_DRV_I2C_Read_sony);
EXPORT_SYMBOL(HI_DRV_I2C_Write_sony);
EXPORT_SYMBOL(HI_DRV_I2C_ReadDirectly);
EXPORT_SYMBOL(HI_DRV_I2C_Write_NoSTOP);
EXPORT_SYMBOL(HI_DRV_I2C_SetRate);
#endif
