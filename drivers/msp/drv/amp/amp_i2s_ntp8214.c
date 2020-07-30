/*********************************************************************

Copyright (C), 2001-2011, Hisilicon Tech. Co., Ltd.

**********************************************************************
File Name     :    amp_i2s_NTP8214.h
Version         :    Initial    Draft
Author         :    l00191026
Created         :    2014/2/28
Last Modified:
Description   :    NTP8214 Driver
Function List :
History         :
* Version     Date       Author     DefectNum          Description
           2014/6/25   l00191026      NULL            Update driver.
*********************************************************************/

/******************************* Include Files *******************************/

/* Sys headers */
#include <linux/version.h>
#include <linux/proc_fs.h>
#include <linux/ioport.h>
#include <linux/string.h>
#include <linux/ioctl.h>
#include <linux/fs.h>
#include <linux/delay.h>
#include <linux/sched.h>
#include <linux/vmalloc.h>
#include <linux/interrupt.h>
#include <linux/seq_file.h>
#include <asm/uaccess.h>
#include <asm/io.h>

/* Unf headers */
#include "hi_error_mpi.h"
#include "hi_drv_mem.h"
#include "hi_module.h"

/* Drv headers */
#include "hi_type.h"
#include "drv_i2c_ext.h"
#include "drv_gpio_ext.h"
#include "drv_amp_private.h"
#include "drv_amp_ioctl.h"
#include "hi_drv_amp.h"
#include "drv_amp_ext.h"
#include "amp_i2s.h"
//========== Board Changed! ==================         
#include "hi_board.h"
//================= End ===================


#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif
#endif /* __cplusplus */

#define ENDTBL_FLAG     (0xff)
#define AMP_DEBUG         (0)
#define MAX_AMP_REG_LEN (20)
#define NTP8214_MAX_VOL (0xff)
#define NTP8214_MIN_VOL (0x00) //Mute
#define NTP8214_INIT_INTERVAL (10) //Delay 65ms

static AMP_GLOBAL_PARAM_S* pstNTP8214Drv = HI_NULL;

typedef struct
{
    HI_U8 bAddr;
    HI_U8 bLength;
    HI_U8 bArray[MAX_AMP_REG_LEN];
} NTP8214_REGMAP;

static NTP8214_REGMAP NTP8214_DefautTbl[] =
{
    // Address  DataLength   DataN       DataN+1...
    // I2C Configuration file for NTP8214
    {0x02, 1, {0x00}},    // Master clock 12.288MHz
    {0x00, 1, {0x00}},    // Audio interface setup,I2S slave, 48kHz
    {0x5D, 1, {0x01}},    // Driver Control SHDN go to high
    {0x3C, 1, {0x67}},    // Prescaler Value for L/R
    {0x17, 1, {0xB7}},    // Channel 1 Volume +12dB, 0x9F == 0dB
    {0x18, 1, {0xB7}},    // Channel 2 Volume +12dB
    {0x20, 1, {0xA8}},    // LR DRC Low Side Enable with +0dB
    {0x21, 1, {0x72}},    // LR DRC Low Side Attack 15ms, release 0.2sec
    {0x22, 1, {0xA8}},    // LR DRC High Side Enable with +0dB
    {0x23, 1, {0x01}},    // LR DRC High Side Attack 8ms, release 0.5sec
    {0x26, 1, {0xA8}},    // POST DRC Enable with +0dB
    {0x27, 1, {0x51}},    // POST DRC Attack 15ms, release 0.2sec
    {0x2A, 1, {0xEA}},    // Sub DRC Enable with -9dB
    {0x2B, 1, {0x01}},    // Sub DRC Attack 8ms, release 0.5sec
    {0x29, 1, {0x11}},    // 2Band DRC mode enable
    {0x2C, 1, {0x01}},    // Sub band DRC mode enable
    //{0x68, 1, {0x00}},    // Phase 0
    {0x60, 1, {0x28}},    // DC, unstable frequency check enable
    {0x41, 1, {0x12}},    // Minimum pulse width 40ns

    {0x43, 1, {0x02}},    // BTL output DBTL mode
    {0x4A, 1, {0x00}},    // PWM Soft start control , Soft start disable
    //{0x3A, 1, {0x46}},    // Auto Mute when little signal

#ifdef HI_AMP_LINUX_CFG
    {0x0c, 1, {0xff}},
#else
    {0x0c, 1, {0x0}},    //  PWM MASK ON -> PWM ON -> Softmute off -> Master volume 0dB
#endif
    {ENDTBL_FLAG ,0x01,{0x00}}
};

static HI_S32 AMP_SetMute(HI_BOOL bMute);

static HI_S32 AMPWriteReg(HI_U8 u1Addr, HI_U8 *pu1Buf, HI_U16 u2ByteCnt)
{
    HI_S32 s32Ret = 0;

    if (pstNTP8214Drv->pI2CFunc  == HI_NULL)
    {
        HI_ERR_AMP("I2C Function Null \n");
        return HI_FAILURE;
    }
    
    s32Ret = pstNTP8214Drv->pI2CFunc->pfnI2cWrite(pstNTP8214Drv->u32I2CNum,
             pstNTP8214Drv->u8DeviceAddr, u1Addr, 1, pu1Buf, u2ByteCnt);
    if (s32Ret != HI_SUCCESS)
    {
        HI_ERR_AMP("NTP8214 i2c write error :I2cNum:0x%x, I2cDevAddr:0x%x, "
                   "u1Addr:0x%x, addlen:0x%x, pu1Buf:0x%x, u2ByteCnt:0x%x\n",
                   pstNTP8214Drv->u32I2CNum, pstNTP8214Drv->u8DeviceAddr,
                   u1Addr, 1, pu1Buf[0], u2ByteCnt);
    }
    return s32Ret;
}

static HI_S32 AMPReadReg(HI_U8 u1Addr, HI_U8 *pu1Buf, HI_U16 u2ByteCnt)
{
    HI_S32 s32Ret = 0;

    if (pstNTP8214Drv->pI2CFunc == HI_NULL)
    {
        HI_ERR_AMP("I2C Function Null \n");
        return HI_FAILURE;
    }

    s32Ret = pstNTP8214Drv->pI2CFunc->pfnI2cRead(pstNTP8214Drv->u32I2CNum,
             pstNTP8214Drv->u8DeviceAddr, u1Addr, 1, pu1Buf, u2ByteCnt);
    if (s32Ret != HI_SUCCESS)
    {
        //HI_ERR_AMP("5711read fail :%d!\n", s32Ret );
    }
    return s32Ret;
}

static HI_VOID AMPReset(HI_BOOL bReset)
{
    if (pstNTP8214Drv == HI_NULL)
    {
        HI_ERR_AMP("NTP8214 no Init! \n");
        return;
    }

    if (pstNTP8214Drv->pGpioFunc== HI_NULL)
    {
        HI_ERR_AMP("GPIO Function Null \n");
        return;
    }    
    
    if (pstNTP8214Drv->pGpioFunc->pfnGpioDirSetBit)
    {
        pstNTP8214Drv->pGpioFunc->pfnGpioDirSetBit(pstNTP8214Drv->u32ResetGPIONum,
                pstNTP8214Drv->u32GPIOOutputPolarity); //Output Mode
    }
    
    msleep(1);
    
    if (pstNTP8214Drv->pGpioFunc->pfnGpioWriteBit)
    { 
        if (bReset)
        {            
            pstNTP8214Drv->pGpioFunc->pfnGpioWriteBit(pstNTP8214Drv->u32ResetGPIONum, 
                                                       pstNTP8214Drv->u32ResetPolarity);
        }
        else
        {
            pstNTP8214Drv->pGpioFunc->pfnGpioWriteBit(pstNTP8214Drv->u32ResetGPIONum, 
                                                       !(pstNTP8214Drv->u32ResetPolarity));
        }
    }        
    
    msleep(NTP8214_INIT_INTERVAL);

    return;
}

#if 1
static HI_VOID AMPHWMute(HI_BOOL bMute)
{
    if (pstNTP8214Drv == HI_NULL)
    {
        HI_ERR_AMP("NTP8214 no Init! \n");
        return;
    }

    if (pstNTP8214Drv->pGpioFunc== HI_NULL)
    {
        HI_ERR_AMP("GPIO Function Null \n");
        return;
    }    
    if (pstNTP8214Drv->pGpioFunc->pfnGpioDirSetBit)
    {
        pstNTP8214Drv->pGpioFunc->pfnGpioDirSetBit(pstNTP8214Drv->u32HWMuteGPIONum, 
                                      pstNTP8214Drv->u32GPIOOutputPolarity); //Output Mode
    }
    
    msleep(1);
    
    if (pstNTP8214Drv->pGpioFunc->pfnGpioWriteBit)
    { 
        if (bMute)
        {            
            pstNTP8214Drv->pGpioFunc->pfnGpioWriteBit(pstNTP8214Drv->u32HWMuteGPIONum, 
                                                       pstNTP8214Drv->u32HWMutePolarity);
        }
        else
        {
            pstNTP8214Drv->pGpioFunc->pfnGpioWriteBit(pstNTP8214Drv->u32HWMuteGPIONum, 
                                                       !(pstNTP8214Drv->u32HWMutePolarity));
        }
    }        
    
    return;
}
#endif

static HI_S32 AMP_Init(AMP_GLOBAL_PARAM_S* pstAmpDrv)
{
#ifndef HI_BOOT_MUSIC_SUPPORT
    HI_S32             s32Ret = 0;
    HI_U8             u8Index, u8Addr, u8Length, u8CountLoop;
    HI_U8             u8Array[MAX_AMP_REG_LEN];
    NTP8214_REGMAP     *pstNTP8214InitTbl;
#endif
    //Set NTP8214 Software ops and Hardware setting
    if (pstAmpDrv == HI_NULL)
    {
        HI_ERR_AMP("Cannot get Any Setting for NTP8214! \n");
        return HI_FAILURE;
    }
    else
    {
        pstNTP8214Drv         = pstAmpDrv;
    }

#ifndef HI_AMP_LINUX_CFG
    AMP_SetMute(HI_TRUE);
#endif

#ifndef HI_BOOT_MUSIC_SUPPORT
    pstNTP8214InitTbl     = NTP8214_DefautTbl;

    AMPHWMute(HI_FALSE);

    msleep(10);
    
    //Reset AMP
    AMPReset(HI_TRUE);
    
    msleep(10);        
    
    //Release Reset AMP
    AMPReset(HI_FALSE);        

    for(u8Index = 0; ; u8Index ++)
    {
        u8Addr = pstNTP8214InitTbl[u8Index].bAddr;
        if(u8Addr == ENDTBL_FLAG)
        {
            break;
        }

        u8Length = pstNTP8214InitTbl[u8Index].bLength;
        for(u8CountLoop = 0; u8CountLoop < u8Length; u8CountLoop ++)
        {        
            u8Array[u8CountLoop] = *(pstNTP8214InitTbl[u8Index].bArray + u8CountLoop);
        }
        
        s32Ret = AMPWriteReg(u8Addr, u8Array, u8Length);
        if(s32Ret != HI_SUCCESS)
        {
        //    HI_ERR_AMP("NTP8214Init Fail \n");
        }

        //0x1B:Oscillator Trim, 0x46:DRC Control, 0x50:EQ Control, 0xF9:I2C Device Addr
        if((u8Addr == 0x1B) || (u8Addr == 0x46) || (u8Addr == 0x50) || (u8Addr == 0xF9))
        {    
            msleep(1);
        }

#if AMP_DEBUG
        HI_U8 readArray[MAX_AMP_REG_LEN]    =    {0};
        s32Ret = AMPReadReg(u8Addr, readArray, u8Length);
        if (s32Ret != HI_SUCCESS)
        {
           HI_ERR_AMP("i2c read failed!\n");
        }
        printk("addr:0x%x, length:0x%x, ",    u8Addr,    u8Length);
        for(u8CountLoop = 0;    u8CountLoop < u8Length;    u8CountLoop ++)
        {
            printk("0x%x,",    readArray[u8CountLoop]);
        }    
        printk("\n");
#endif

    }
#endif //end #ifndef HI_BOOT_MUSIC_SUPPORT

    return HI_SUCCESS; 
}

static HI_S32 AMP_Resume(AMP_GLOBAL_PARAM_S* pstAmpDrv)
{
    HI_S32             s32Ret = 0;
    HI_U8             u8Index, u8Addr, u8Length, u8CountLoop;
    HI_U8             u8Array[MAX_AMP_REG_LEN];
    NTP8214_REGMAP     *pstNTP8214InitTbl;

    //Set NTP8214 Software ops and Hardware setting
    if (pstAmpDrv == HI_NULL)
    {
        HI_ERR_AMP("Cannot get Any Setting for NTP8214! \n");
        return HI_FAILURE;
    }
    else
    {
        pstNTP8214Drv         = pstAmpDrv;
    }
    
    pstNTP8214InitTbl     = NTP8214_DefautTbl;

    AMPHWMute(HI_FALSE);

    msleep(10);
    
    //Reset AMP
    AMPReset(HI_TRUE);
    
    msleep(10);        
    
    //Release Reset AMP
    AMPReset(HI_FALSE);        

    for(u8Index = 0; ; u8Index ++)
    {
        u8Addr = pstNTP8214InitTbl[u8Index].bAddr;
        if(u8Addr == ENDTBL_FLAG)
        {
            break;
        }

        u8Length = pstNTP8214InitTbl[u8Index].bLength;
        for(u8CountLoop = 0; u8CountLoop < u8Length; u8CountLoop ++)
        {        
            u8Array[u8CountLoop] = *(pstNTP8214InitTbl[u8Index].bArray + u8CountLoop);
        }
        
        s32Ret = AMPWriteReg(u8Addr, u8Array, u8Length);
        if(s32Ret != HI_SUCCESS)
        {
        //    HI_ERR_AMP("NTP8214Init Fail \n");
        }

        //0x1B:Oscillator Trim, 0x46:DRC Control, 0x50:EQ Control, 0xF9:I2C Device Addr
        if((u8Addr == 0x1B) || (u8Addr == 0x46) || (u8Addr == 0x50) || (u8Addr == 0xF9))
        {    
            msleep(1);
        }

#if AMP_DEBUG
        HI_U8 readArray[MAX_AMP_REG_LEN]    =    {0};
        s32Ret = AMPReadReg(u8Addr, readArray, u8Length);
        if (s32Ret != HI_SUCCESS)
        {
           HI_ERR_AMP("i2c read failed!\n");
        }
        printk("addr:0x%x, length:0x%x, ",    u8Addr,    u8Length);
        for(u8CountLoop = 0;    u8CountLoop < u8Length;    u8CountLoop ++)
        {
            printk("0x%x,",    readArray[u8CountLoop]);
        }    
        printk("\n");
#endif

    }

    return HI_SUCCESS; 
}
static HI_VOID AMP_DeInit(HI_VOID)
{
    if (pstNTP8214Drv == HI_NULL)
    {
        HI_ERR_AMP("NTP8214 is not initialized yet! \n");
        return;
    }

    //Reset AMP
    AMPReset(HI_TRUE);    

    pstNTP8214Drv = HI_NULL;
    
    return;
}

static HI_S32 AMP_SetMute(HI_BOOL bMute)
{
    HI_S32 s32Ret;
    HI_U8  u8Gain[1]= {0};

    if (pstNTP8214Drv == HI_NULL)
    {
        HI_ERR_AMP("NTP8214 is not initialized yet! \n");
        return HI_FAILURE;
    }

    if (bMute)
    {
        u8Gain[0] = NTP8214_MIN_VOL;
        s32Ret = AMPWriteReg(0x0c, u8Gain, 1);
    }
    else
    {
        u8Gain[0] = NTP8214_MAX_VOL;
        s32Ret = AMPWriteReg(0x0c, u8Gain, 1);
    }
    return s32Ret;
}

static HI_S32 AMP_GetMute(HI_BOOL* pbMute)
{
    HI_S32 s32Ret;
    HI_U8  u8Gain = 0;
    
    if (pstNTP8214Drv == HI_NULL)
    {
        HI_ERR_AMP("NTP8214 is not initialized yet! \n");
        return HI_FAILURE;
    }

    s32Ret = AMPReadReg(0x0c, &u8Gain, 1);
    if (s32Ret != HI_SUCCESS)
    {
       HI_ERR_AMP("i2c read failed!\n");
    }
    if (u8Gain == NTP8214_MIN_VOL)
    {
        *pbMute = HI_TRUE;
    }
    else
    {
        *pbMute = HI_FALSE;
    }
    return s32Ret; 
}

typedef enum hi_AMP_DRC_TYPE_E
{ 
    HI_AMP_POST_DRC_BANK,
    HI_AMP_HIGH_DRC_BANK,
    HI_AMP_LOW_DRC_BANK,
    HI_AMP_SUB_DRC_BANK
}HI_AMP_DRC_TYPE_E;

typedef enum hi_PEQ_BQ_E
{  
    HI_PEQ_BQ_1 = 1,
    HI_PEQ_BQ_2,
    HI_PEQ_BQ_3,
    HI_PEQ_BQ_4,
    HI_PEQ_BQ_5,
    HI_PEQ_BQ_6,
    HI_PEQ_BQ_7,
    HI_PEQ_BQ_8,
    HI_PEQ_BQ_9,
    HI_PEQ_BQ_10,
    HI_PEQ_BQ_11,
    HI_PEQ_BQ_12,
}HI_PEQ_BQ_E;

typedef enum hi_AMP_CH_E
{   
    HI_AMP_CH_1,
    HI_AMP_CH_2,
    HI_AMP_CH_BOTH
}HI_AMP_CH_E;

#define LDRCCtrlRegAddr  0x20    //bit7
#define HDRCCtrlRegAddr  0x22    //bits7
#define SDRCRegAddr      0x2a
#define PDRCRegAddr      0x26

#define PEQCtrl0CH1RegAddr      0x0e/* Ctr0 include BQ1-BQ3 */
#define PEQCtrl0CH2RegAddr      0x0f
#define PEQCtrl1CH1RegAddr      0x10/* Ctr1 include BQ4-BQ6 */
#define PEQCtrl1CH2RegAddr      0x11
#define APEQCtrl0CH1RegAddr     0x12/* Ctr0 include BQ7-BQ10 */
#define APEQCtrl0CH2RegAddr     0x13
#define APEQCtrl1CH1RegAddr     0x14/* Ctr0 include BQ11-BQ12 */
#define APEQCtrl1CH2RegAddr     0x15

#define AMP_PEQ_ON  HI_TRUE
#define AMP_PEQ_OFF HI_FALSE

#define BIT0    0x01
#define BIT1    0x02
#define BIT2    0x04
#define BIT3    0x08
#define BIT4    0x10
#define BIT5    0x20
#define BIT6    0x40
#define BIT7    0x80

#define BIT0_1  0x03
#define BIT2_3  0x0C
#define BIT4_5  0x30
#define BIT6_7  0xC0

static HI_S32 AMP_SetDrcEn(HI_AMP_DRC_TYPE_E u32DRCType, HI_BOOL bEn)
{
    HI_S32 s32Ret;
    HI_U32 u32RegAddr = 0;
    HI_U8 u8DRCVal = 0;

    switch(u32DRCType)
    {
        case HI_AMP_LOW_DRC_BANK:
            u32RegAddr = LDRCCtrlRegAddr;
            break;
        case HI_AMP_HIGH_DRC_BANK:
            u32RegAddr = HDRCCtrlRegAddr;
            break;
        case HI_AMP_POST_DRC_BANK:
            u32RegAddr = PDRCRegAddr;
            break;
        case HI_AMP_SUB_DRC_BANK:
            u32RegAddr = SDRCRegAddr;
            break;
        default:
            HI_ERR_AMP("unknown DRC Type\n");
            return HI_FAILURE;
    }

    s32Ret = AMPReadReg(u32RegAddr, &u8DRCVal, 1);
    if (s32Ret != HI_SUCCESS)
    {
       HI_ERR_AMP("i2c read failed!\n");
    }

    if (HI_TRUE == bEn)
    {
        u8DRCVal |= BIT7;
    }
    else
    {
        u8DRCVal &= ~BIT7;
    }

    s32Ret = AMPWriteReg(u32RegAddr, &u8DRCVal, 1);
    if (s32Ret != HI_SUCCESS)
    {
       HI_ERR_AMP("i2c write failed!\n");
    }

    return HI_SUCCESS;
}

static HI_S32 AMP_GetDrcEn(HI_AMP_DRC_TYPE_E u32DRCType, HI_BOOL *bEn)
{
    HI_S32 s32Ret;
    HI_U32 u32RegAddr = 0;
    HI_U8 u8DRCVal = 0;

    switch(u32DRCType)
    {
        case HI_AMP_LOW_DRC_BANK:
            u32RegAddr = LDRCCtrlRegAddr;
            break;
        case HI_AMP_HIGH_DRC_BANK:
            u32RegAddr = HDRCCtrlRegAddr;
            break;
        case HI_AMP_POST_DRC_BANK:
            u32RegAddr = PDRCRegAddr;
            break;
        case HI_AMP_SUB_DRC_BANK:
            u32RegAddr = SDRCRegAddr;
            break;
        default:
            HI_ERR_AMP("unknown DRC Type\n");
            return HI_FAILURE;
    }

    s32Ret = AMPReadReg(u32RegAddr, &u8DRCVal, 1);
    if (s32Ret != HI_SUCCESS)
    {
       HI_ERR_AMP("i2c read failed!\n");
    }

    if ((u8DRCVal & BIT7) == BIT7)
    {
        *bEn = HI_TRUE;
    }
    else
    {
        *bEn = HI_FALSE;
    }

    return HI_SUCCESS;
}

static HI_S32 AMP_SetPEQEn(HI_AMP_CH_E enChNo, HI_PEQ_BQ_E enBQNum, HI_BOOL bEn)
{
    HI_S32 s32Ret;
    HI_U8 u8PEQVal = 0;
    HI_U32 u32RegAddr = 0;

    /* initial RegAddr */
    switch(enBQNum)
    {
        case HI_PEQ_BQ_1:
        case HI_PEQ_BQ_2:
        case HI_PEQ_BQ_3:
            if(HI_AMP_CH_1 == enChNo)
            {
                u32RegAddr = PEQCtrl0CH1RegAddr;
            }
            else if(HI_AMP_CH_2 == enChNo)
            {
                u32RegAddr = PEQCtrl0CH2RegAddr;
            }
            else
            {
                HI_ERR_AMP("unknown amp channel \n");
                return HI_FAILURE;
            }

            break;

        case HI_PEQ_BQ_4:
        case HI_PEQ_BQ_5:
        case HI_PEQ_BQ_6:
            if(HI_AMP_CH_1 == enChNo)
            {
                u32RegAddr = PEQCtrl1CH1RegAddr;
            }
            else if(HI_AMP_CH_2 == enChNo)
            {
                u32RegAddr = PEQCtrl1CH2RegAddr;
            }
            else
            {
                HI_ERR_AMP("unknown amp channel \n");
                return HI_FAILURE;
            }

            break;

        case HI_PEQ_BQ_7:
        case HI_PEQ_BQ_8:
        case HI_PEQ_BQ_9:
        case HI_PEQ_BQ_10:
            if(HI_AMP_CH_1 == enChNo)
            {
                u32RegAddr = APEQCtrl0CH1RegAddr;
            }
            else if(HI_AMP_CH_2 == enChNo)
            {
                u32RegAddr = APEQCtrl0CH2RegAddr;
            }
            else
            {
                HI_ERR_AMP("unknown amp channel \n");
                return HI_FAILURE;
            }
            break;

        case HI_PEQ_BQ_11:
        case HI_PEQ_BQ_12:
            if(HI_AMP_CH_1 == enChNo)
            {
                u32RegAddr = APEQCtrl1CH1RegAddr;
            }
            else if(HI_AMP_CH_2 == enChNo)
            {
                u32RegAddr = APEQCtrl1CH2RegAddr;
            }
            else
            {
                HI_ERR_AMP("unknown amp channel \n");
                return HI_FAILURE;
            }
            break;
#if 0   //avoid CodeCC       
        default:
            HI_ERR_AMP("unknown BQ number \n");
            return HI_FAILURE;
#endif
    }

    s32Ret = AMPReadReg(u32RegAddr, &u8PEQVal, 1);
    if (s32Ret != HI_SUCCESS)
    {
        HI_ERR_AMP("i2c read failed!\n");
    }

    if(AMP_PEQ_ON == bEn)
    {
        switch(enBQNum)
        {
            case HI_PEQ_BQ_4:
                u8PEQVal |= BIT0;
                break;
            case HI_PEQ_BQ_1:
            case HI_PEQ_BQ_7:
            case HI_PEQ_BQ_11:
                u8PEQVal &= ~BIT0_1;
                u8PEQVal |= BIT0;
                break;
            case HI_PEQ_BQ_5:
                u8PEQVal |= BIT1;
                break;
            case HI_PEQ_BQ_6:
                u8PEQVal |= BIT2;
                break;
            case HI_PEQ_BQ_2:
            case HI_PEQ_BQ_8:
            case HI_PEQ_BQ_12:
                u8PEQVal &= ~BIT2_3;
                u8PEQVal |= BIT2;
                break;
            case HI_PEQ_BQ_3:
            case HI_PEQ_BQ_9:
                u8PEQVal &= ~BIT4_5;
                u8PEQVal |= BIT4;
                break;
            case HI_PEQ_BQ_10:
                u8PEQVal &= ~BIT6_7;
                u8PEQVal |= BIT6;
                break;
#if 0   //avoid CodeCC       
            default:
                HI_ERR_AMP("unknown BQ number \n");
                return HI_FAILURE;
#endif
        }
    }
    else if(AMP_PEQ_OFF == bEn)
    {
        switch(enBQNum)
        {
            case HI_PEQ_BQ_4:
                u8PEQVal &= ~BIT0;
                break;
            case HI_PEQ_BQ_1:
            case HI_PEQ_BQ_7:
            case HI_PEQ_BQ_11:
                u8PEQVal &= ~BIT0_1;
                break;
            case HI_PEQ_BQ_5:
                u8PEQVal &= ~BIT1;
                break;
            case HI_PEQ_BQ_6:
                u8PEQVal &= ~BIT2;
                break;
            case HI_PEQ_BQ_2:
            case HI_PEQ_BQ_8:
            case HI_PEQ_BQ_12:
                u8PEQVal &= ~BIT2_3;
                break;
            case HI_PEQ_BQ_3:
            case HI_PEQ_BQ_9:
                u8PEQVal &= ~BIT4_5;
                break;
            case HI_PEQ_BQ_10:
                u8PEQVal &= ~BIT6_7;
                break;
#if 0   //avoid CodeCC       
            default:
                HI_ERR_AMP("unknown BQ number \n");
                return HI_FAILURE;
#endif
        }
    }
    else
    {
        HI_ERR_AMP("unknown cmd\n");
    }

    s32Ret = AMPWriteReg(u32RegAddr, &u8PEQVal, 1);
    if (s32Ret != HI_SUCCESS)
    {
       HI_ERR_AMP("i2c write failed!\n");
    }    

    return HI_SUCCESS;
}

static HI_S32 AMP_GetPEQEn(HI_AMP_CH_E enChNo, HI_PEQ_BQ_E enBQNum, HI_BOOL *bEn)
{
    HI_S32 s32Ret;
    HI_U8 u8PEQVal = 0;
    HI_U32 u32RegAddr = 0;

    /* initial RegAddr */
    switch(enBQNum)
    {
        case HI_PEQ_BQ_1:
        case HI_PEQ_BQ_2:
        case HI_PEQ_BQ_3:
            if(HI_AMP_CH_1 == enChNo)
            {
                u32RegAddr = PEQCtrl0CH1RegAddr;
            }
            else if(HI_AMP_CH_2 == enChNo)
            {
                u32RegAddr = PEQCtrl0CH2RegAddr;
            }
            else
            {
                HI_ERR_AMP("unknown amp channel \n");
                return HI_FAILURE;
            }

            break;

        case HI_PEQ_BQ_4:
        case HI_PEQ_BQ_5:
        case HI_PEQ_BQ_6:
            if(HI_AMP_CH_1 == enChNo)
            {
                u32RegAddr = PEQCtrl1CH1RegAddr;
            }
            else if(HI_AMP_CH_2 == enChNo)
            {
                u32RegAddr = PEQCtrl1CH2RegAddr;
            }
            else
            {
                HI_ERR_AMP("unknown amp channel \n");
                return HI_FAILURE;
            }

            break;

        case HI_PEQ_BQ_7:
        case HI_PEQ_BQ_8:
        case HI_PEQ_BQ_9:
        case HI_PEQ_BQ_10:
            if(HI_AMP_CH_1 == enChNo)
            {
                u32RegAddr = APEQCtrl0CH1RegAddr;
            }
            else if(HI_AMP_CH_2 == enChNo)
            {
                u32RegAddr = APEQCtrl0CH2RegAddr;
            }
            else
            {
                HI_ERR_AMP("unknown amp channel \n");
                return HI_FAILURE;
            }
            break;

        case HI_PEQ_BQ_11:
        case HI_PEQ_BQ_12:
            if(HI_AMP_CH_1 == enChNo)
            {
                u32RegAddr = APEQCtrl1CH1RegAddr;
            }
            else if(HI_AMP_CH_2 == enChNo)
            {
                u32RegAddr = APEQCtrl1CH2RegAddr;
            }
            else
            {
                HI_ERR_AMP("unknown amp channel \n");
                return HI_FAILURE;
            }
            break;
#if 0   //avoid CodeCC                   
        default:
            HI_ERR_AMP("unknown BQ number \n");
            return HI_FAILURE;
#endif
    }

    s32Ret = AMPReadReg(u32RegAddr, &u8PEQVal, 1);
    if (s32Ret != HI_SUCCESS)
    {
        HI_ERR_AMP("i2c read failed!\n");
    }

    switch(enBQNum)
    {
        case HI_PEQ_BQ_4:
        {
            if((u8PEQVal & BIT0) == BIT0)
            {
                *bEn = AMP_PEQ_ON;
            }
            else
            {
                *bEn = AMP_PEQ_OFF;
            }
            break;
        }
        case HI_PEQ_BQ_1:
        case HI_PEQ_BQ_7:
        case HI_PEQ_BQ_11:
        {
            if((u8PEQVal & BIT0_1) == BIT0)
            {
                *bEn = AMP_PEQ_ON;
            }
            else
            {
                *bEn = AMP_PEQ_OFF;
            }
            break;
        }
        case HI_PEQ_BQ_5:
        {
            if((u8PEQVal & BIT1) == BIT1)
            {
                *bEn = AMP_PEQ_ON;
            }
            else
            {
                *bEn = AMP_PEQ_OFF;
            }
            break;
        }
        case HI_PEQ_BQ_6:
        {
            if((u8PEQVal & BIT2) == BIT2)
            {
                *bEn = AMP_PEQ_ON;
            }
            else
            {
                *bEn = AMP_PEQ_OFF;
            }
            break;
        }
        case HI_PEQ_BQ_2:
        case HI_PEQ_BQ_8:
        case HI_PEQ_BQ_12:
        {
            if((u8PEQVal & BIT2_3) == BIT2)
            {
                *bEn = AMP_PEQ_ON;
            }
            else
            {
                *bEn = AMP_PEQ_OFF;
            }
            break;
        }
        case HI_PEQ_BQ_3:
        case HI_PEQ_BQ_9:
        {
            if((u8PEQVal & BIT4_5) == BIT4)
            {
                *bEn = AMP_PEQ_ON;
            }
            else
            {
                *bEn = AMP_PEQ_OFF;
            }
            break;
        }
        case HI_PEQ_BQ_10:
        {
            if((u8PEQVal & BIT6_7) == BIT6)
            {
                *bEn = AMP_PEQ_ON;
            }
            else
            {
                *bEn = AMP_PEQ_OFF;
            }
            break;
        }
#if 0   //avoid CodeCC       
        default:
            HI_ERR_AMP("unknown BQ number \n");
            return HI_FAILURE;
#endif

    }

    return HI_SUCCESS;
}

static HI_S32 AMP_SetSubWooferVol(HI_U32 u32Volume)
{
    return HI_SUCCESS; 
}

static HI_S32 AMP_GetSubWooferVol(HI_U32* pu32Volume)
{
    return HI_SUCCESS; 
}

static HI_S32 AMP_WriteReg(HI_U32 u32RegAddr, HI_U32 u32ByteSize, HI_U8* pu8Value)
{
    HI_S32 Ret;
    HI_U8  RegArray[MAX_AMP_REG_LEN];

    if (pstNTP8214Drv == HI_NULL)
    {
        HI_ERR_AMP("NTP8214 is not initialized yet! \n");
        return HI_FAILURE;
    }

    if (u32ByteSize > MAX_AMP_REG_LEN)
    {
        HI_ERR_AMP("NTP8214 reg length MAX is 20\n");
        u32ByteSize = MAX_AMP_REG_LEN;
    }

    Ret = copy_from_user(RegArray, pu8Value, u32ByteSize);
    if(Ret != HI_SUCCESS)
    {
        HI_ERR_AMP("NTP8214 copy_from_user Fail \n");
    }

    Ret = AMPWriteReg(u32RegAddr, RegArray, u32ByteSize);
    if(Ret != HI_SUCCESS)
    {
        HI_ERR_AMP("NTP8214 write I2C Fail \n");
    }

    return HI_SUCCESS; 
}

static HI_S32 AMP_ReadReg(HI_U32 u32RegAddr, HI_U32 u32ByteSize, HI_U8* pu8Value)
{
    HI_S32 Ret;
    HI_U8  RegArray[MAX_AMP_REG_LEN];

    if (pstNTP8214Drv == HI_NULL)
    {
        HI_ERR_AMP("NTP8214 is not initialized yet! \n");
        return HI_FAILURE;
    }

    if (u32ByteSize > MAX_AMP_REG_LEN)
    {
        HI_ERR_AMP("NTP8214 reg length MAX is 20\n");
        u32ByteSize = MAX_AMP_REG_LEN;
    }

    Ret = AMPReadReg(u32RegAddr, RegArray, u32ByteSize);
    if(Ret != HI_SUCCESS)
    {
        HI_ERR_AMP("NTP8214 Read I2C Fail \n");
    }

    Ret = copy_to_user(pu8Value, RegArray, u32ByteSize);
    if(Ret != HI_SUCCESS)
    {
        HI_ERR_AMP("NTP8214 copy_to_user Fail \n");
    }

    return HI_SUCCESS; 
}

static HI_S32 AMP_ReadProc(struct seq_file *p, HI_VOID *pData)
{
    HI_S32            Ret;
    HI_BOOL           bMuteEn = HI_NULL, bDrcEn = HI_NULL, bPeqEn = HI_NULL;
    HI_U8             u8Index, u8Addr, u8Length, u8CountLoop;
    HI_U8             u8Array[MAX_AMP_REG_LEN];
    NTP8214_REGMAP    *pstNTP8214InitTbl;
    HI_PEQ_BQ_E enPeqBand;
    HI_AMP_CH_E enChNo;

    if (pstNTP8214Drv == HI_NULL)
    {
        HI_ERR_AMP("NTP8214 is not initialized yet! \n");
        return HI_FAILURE;
    }

    PROC_PRINT(p, "AMP Modul:        NTP8214\n");
    PROC_PRINT(p, "I2C Num:          %d\n" ,  pstNTP8214Drv->u32I2CNum);
    PROC_PRINT(p, "I2C Addr:         0x%x\n", pstNTP8214Drv->u8DeviceAddr);    
    PROC_PRINT(p, "Mute  GPIO Group: %d\n", pstNTP8214Drv->u32HWMuteGPIONum/8);
    PROC_PRINT(p, "Mute  GPIO Bit:   %d\n",    pstNTP8214Drv->u32HWMuteGPIONum%8);
    PROC_PRINT(p, "Mute  Polarity:   %d\n",    pstNTP8214Drv->u32HWMutePolarity);                                                                    

    PROC_PRINT(p, "Reset GPIO Group: %d\n", pstNTP8214Drv->u32ResetGPIONum/8);
    PROC_PRINT(p, "Reset GPIO Bit:   %d\n", pstNTP8214Drv->u32ResetGPIONum%8);
    PROC_PRINT(p, "Reset Polarity:   %d\n", pstNTP8214Drv->u32ResetPolarity);

    pstNTP8214InitTbl     = NTP8214_DefautTbl;

    PROC_PRINT(p,"\n--------------------- NTP8214 REGMAP -------------------------------------------------");
    for(u8Index = 0; ; u8Index ++)
    {
        u8Addr = pstNTP8214InitTbl[u8Index].bAddr;
        if(u8Addr == ENDTBL_FLAG)
        {
            break;
        }
        u8Length = pstNTP8214InitTbl[u8Index].bLength;
        PROC_PRINT(p, "\nAddr[0x%x] Len[%d]: ",u8Addr,u8Length);
        memset(u8Array,0,MAX_AMP_REG_LEN);    
        Ret = AMPReadReg(u8Addr, u8Array, u8Length);
        if(Ret != HI_SUCCESS)
        {
            HI_ERR_AMP("NTP8214 Read I2C Fail \n");
        }

        for(u8CountLoop = 0; u8CountLoop < u8Length; u8CountLoop++)
        {
            PROC_PRINT(p, "0x%x ", u8Array[u8CountLoop]);
        }    
    }
    PROC_PRINT(p,"\n--------------------- END NTP8214 REGMAP -------------------------------------------------\n");

    PROC_PRINT(p,"\n--------------------- NTP8214 STATUS -------------------------------------------------\n");

    Ret = AMP_GetMute(&bMuteEn);
    if (Ret != HI_SUCCESS)
    {
        HI_ERR_AMP("AMP GetMute failed!\n");
    }

    PROC_PRINT(p, "MUTE: %s\n", (bMuteEn) ? "ON" : "OFF");

    PROC_PRINT(p, "DRC:\n");

    Ret = AMP_GetDrcEn(HI_AMP_HIGH_DRC_BANK, &bDrcEn);
    if (Ret != HI_SUCCESS)
    {
        HI_ERR_AMP("AMP GetDrcEn failed!\n");
    }
    PROC_PRINT(p, "  HIGH BAND: %s\n", (bDrcEn) ? "ON" : "OFF");

    Ret = AMP_GetDrcEn(HI_AMP_LOW_DRC_BANK, &bDrcEn);
    if (Ret != HI_SUCCESS)
    {
        HI_ERR_AMP("AMP GetDrcEn failed!\n");
    }
    PROC_PRINT(p, "  LOW BAND: %s\n", (bDrcEn) ? "ON" : "OFF");

    Ret = AMP_GetDrcEn(HI_AMP_SUB_DRC_BANK, &bDrcEn);
    if (Ret != HI_SUCCESS)
    {
        HI_ERR_AMP("AMP GetDrcEn failed!\n");
    }
    PROC_PRINT(p, "  SUB BAND: %s\n", (bDrcEn) ? "ON" : "OFF");

    Ret = AMP_GetDrcEn(HI_AMP_POST_DRC_BANK, &bDrcEn);
    if (Ret != HI_SUCCESS)
    {
        HI_ERR_AMP("AMP GetDrcEn failed!\n");
    }
    PROC_PRINT(p, "  POST BAND: %s\n", (bDrcEn) ? "ON" : "OFF");

    PROC_PRINT(p, "PEQ:\n");

    for (enChNo = HI_AMP_CH_1; enChNo < HI_AMP_CH_BOTH; enChNo++)
    {
        PROC_PRINT(p, "  CH_%d:\n", (HI_U32)enChNo + 1);

        for (enPeqBand = HI_PEQ_BQ_1; enPeqBand <= HI_PEQ_BQ_12; enPeqBand++)
        {
            Ret = AMP_GetPEQEn(enChNo, enPeqBand, &bPeqEn);
            if (HI_SUCCESS != Ret)
            {
                HI_ERR_AMP("AMP GetPeqEn failed!\n");
            }

            PROC_PRINT(p, "   BQ_%d: %s\n", (HI_U32)enPeqBand, (bPeqEn) ? "ON" : "OFF");
        }
    }

    PROC_PRINT(p,"--------------------- END NTP8214 STATUS -------------------------------------------------\n");

    PROC_PRINT(p,"Get setting command:   echo help > /proc/msp/amp\n");

    return HI_SUCCESS;
}

static HI_S32 AMP_WriteProc(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
{
    HI_S32 s32Ret;
    AMP_CMD_PROC_E enProcCmd;

    HI_CHAR szBuf[48];
    HI_CHAR *pcBuf      = szBuf;
    HI_CHAR *pcMuteCmd  = "mute";
    HI_CHAR *pcDrcCmd   = "drc";
    HI_CHAR *pcPeqCmd   = "peq";
    HI_CHAR *pcHelpCmd  = "help";

    if (pstNTP8214Drv == HI_NULL)
    {
        HI_ERR_AMP("NTP8214 is not initialized yet! \n");
        return HI_FAILURE;
    }

    if (copy_from_user(szBuf, buf, count))
    {
        HI_ERR_AMP("copy from user failed\n");
        return HI_FAILURE;
    }

    AMP_STRING_SKIP_BLANK(pcBuf);

    if (strstr(pcBuf, pcMuteCmd))
    {
        enProcCmd = AMP_CMD_PROC_SET_MUTE;
        pcBuf += strlen(pcMuteCmd);
    }
    else if (strstr(pcBuf, pcDrcCmd))
    {
        enProcCmd = AMP_CMD_PROC_SET_DRC;
        pcBuf += strlen(pcDrcCmd);
    }
    else if (strstr(pcBuf, pcPeqCmd))
    {
        enProcCmd = AMP_CMD_PROC_SET_PEQ;
        pcBuf += strlen(pcPeqCmd);
    }
    else if (strstr(pcBuf, pcHelpCmd))
    {
        AMP_PROC_SHOW_HELP();
        return count;
    }
    else
    {
        goto CMD_FAULT;
    }

    AMP_STRING_SKIP_BLANK(pcBuf);

    if(AMP_CMD_PROC_SET_MUTE == enProcCmd)
    {
        HI_BOOL bEn;

        if (strstr(pcBuf, "on"))
        {
            bEn = HI_TRUE;
        }
        else if(strstr(pcBuf, "off"))
        {
            bEn = HI_FALSE;
        }
        else
        {
            goto CMD_FAULT;
        }

        s32Ret = AMP_SetMute(bEn);
        if (HI_SUCCESS != s32Ret)
        {
            goto CMD_FAULT;
        }
    }

    if(AMP_CMD_PROC_SET_DRC == enProcCmd)
    {
        HI_AMP_DRC_TYPE_E enDrcType;
        HI_BOOL bEn;

        if (strstr(pcBuf, "on"))
        {
            bEn = HI_TRUE;
        }
        else if(strstr(pcBuf, "off"))
        {
            bEn = HI_FALSE;
        }
        else
        {
            goto CMD_FAULT;
        }
        
        for (enDrcType = HI_AMP_POST_DRC_BANK; enDrcType <= HI_AMP_SUB_DRC_BANK; enDrcType++)
        {
            s32Ret = AMP_SetDrcEn(enDrcType, bEn);
            if (HI_SUCCESS != s32Ret)
            {
                goto CMD_FAULT;
            }
        }
    }
    
    if(AMP_CMD_PROC_SET_PEQ == enProcCmd)
    {
        HI_PEQ_BQ_E enPeqBand;
        HI_AMP_CH_E enChNo;
        HI_BOOL bEn;

        if (strstr(pcBuf, "on"))
        {
            bEn = HI_TRUE;
        }
        else if(strstr(pcBuf, "off"))
        {
            bEn = HI_FALSE;
        }
        else
        {
            goto CMD_FAULT;
        }

        for (enChNo = HI_AMP_CH_1; enChNo < HI_AMP_CH_BOTH; enChNo++)
        {
            for (enPeqBand = HI_PEQ_BQ_1; enPeqBand <= HI_PEQ_BQ_12; enPeqBand++)
            {
                s32Ret = AMP_SetPEQEn(enChNo, enPeqBand, bEn);
                if (HI_SUCCESS != s32Ret)
                {
                    goto CMD_FAULT;
                }
            }
        }
    }

    return count;

CMD_FAULT:
    HI_ERR_AMP("proc cmd is fault\n");
    AMP_PROC_SHOW_HELP();

    return HI_FAILURE;
}

AMP_DRV_FUNC_S stNTP8214Func =
{
    .bExtMClkFlag           = HI_FALSE,
    .pfnAmpReadProc         = AMP_ReadProc,
    .pfnAmpWriteProc        = AMP_WriteProc,
    .pfnAmpReadReg          = AMP_ReadReg,
    .pfnAmpWriteReg         = AMP_WriteReg,
    .pfnAmpGetSubWooferVol  = AMP_GetSubWooferVol,
    .pfnAmpSetSubWooferVol  = AMP_SetSubWooferVol,
    .pfnAmpGetMute          = AMP_GetMute,
    .pfnAmpSetMute          = AMP_SetMute,
    .pfnAmpDeinit           = AMP_DeInit,
    .pfnAmpInit             = (FN_AMP_INIT)AMP_Init,
    .pfnAmpResume           = (FN_AMP_INIT)AMP_Resume,
};

#ifdef __cplusplus
 #if __cplusplus
}
 #endif
#endif /* End of #ifdef __cplusplus */

