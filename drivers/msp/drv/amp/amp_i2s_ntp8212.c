/*********************************************************************

Copyright (C), 2001-2011, Hisilicon Tech. Co., Ltd.

**********************************************************************
File Name     :    amp_i2s_NTP8212.h
Version         :    Initial    Draft
Author         :    l00191026
Created         :    2014/2/28
Last Modified:
Description   :    NTP8212 Driver
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
#define AMP_MASTER_VOL_REG 0x2e
#define NTP8212_MAX_VOL (0xff)
#define NTP8212_MIN_VOL (0x00) //Mute
#define NTP8212_INIT_INTERVAL (10) //Delay 65ms


static AMP_GLOBAL_PARAM_S* pstNTP8212Drv = HI_NULL;

typedef struct
{
    HI_U8 bAddr;
    HI_U8 bLength;
    HI_U8 bArray[MAX_AMP_REG_LEN];
} NTP8212_REGMAP;

static NTP8212_REGMAP NTP8212_DefautTbl[] = 
{
    // Address  DataLength   DataN       DataN+1...
    // I2C Configuration file for NTP8212
    {0x02, 1, {0x02}},    // Master clock 18.432MHz 
    {0x00, 1, {0x00}},    // Audio interface setup,I2S slave, 48kHz 
    {0x38, 1, {0x02}},    // DBTL
    {0x4E, 1, {0x0E}},    // DBTL MINIMUM PW for ch12
    {0x50, 1, {0x03}},    // NS Selection for ch12 
    {0x52, 1, {0x10}},    // Softstart off for ch12 
    {0x62, 1, {0x18}},    // 2 CHANNEL MODE
    {0x55, 1, {0x0A}},    // MINIMUM PW 4 for ch12
    {0x15, 1, {0xE7}},    // Prescaler Value for L/R
    {0x61, 1, {0x81}},    // I2S Glitch filter Setting 
    {0x2C, 1, {0x43}},    // POE control Enable
    {0x28, 1, {0x04}},    // PWM MASK ON 
#ifdef HI_AMP_LINUX_CFG
    {0x2E, 1, {0xCF}},    // Master Volume 0dB 
#else
    {0x2E, 1, {0xCF}},    // Master Volume 0dB 
#endif
    {0x2F, 1, {0xCF}},    // Channel 1 Volume 0dB 
    {0x30, 1, {0xCF}},    // Channel 2 Volume 0dB 
    {0x25, 1, {0x00}},    // Enhanced DRC Enable, allpass disable
    {0x1C, 1, {0xA8}},    // LR DRC Low Side Enable with +0dB 
    
    {0x62, 1, {0x18}},    //2CH / SB ON 
    {0x28, 1, {0x04}},    // PWM MASK ON 
    
    {0x27, 1, {0x00}},    // PWM Switching ON 
    {0x26, 1, {0x00}},    // Soft-mute OFF 

    {ENDTBL_FLAG ,0x01,{0x00}},
};

static HI_S32 AMP_SetMute(HI_BOOL bMute);

static HI_S32 AMPWriteReg(HI_U8 u1Addr, HI_U8 *pu1Buf, HI_U16 u2ByteCnt)
{
    HI_S32 s32Ret = 0;

    if (pstNTP8212Drv == HI_NULL)
    {
        HI_ERR_AMP("NTP8212 is not initialized yet! \n");
        return HI_FAILURE;
    }

    if (pstNTP8212Drv->pI2CFunc  == HI_NULL)
    {
        HI_ERR_AMP("I2C Function Null \n");
        return HI_FAILURE;
    }
    
    s32Ret = pstNTP8212Drv->pI2CFunc->pfnI2cWrite(pstNTP8212Drv->u32I2CNum,
             pstNTP8212Drv->u8DeviceAddr, u1Addr, 1, pu1Buf, u2ByteCnt);
    if (s32Ret != HI_SUCCESS)
    {
        HI_ERR_AMP("NTP8212 i2c write error :I2cNum:0x%x, I2cDevAddr:0x%x, "
                   "u1Addr:0x%x, addlen:0x%x, pu1Buf:0x%x, u2ByteCnt:0x%x\n",
                   pstNTP8212Drv->u32I2CNum, pstNTP8212Drv->u8DeviceAddr,
                   u1Addr, 1, pu1Buf[0], u2ByteCnt);
    }
    return s32Ret;
}

static HI_S32 AMPReadReg(HI_U8 u1Addr, HI_U8 *pu1Buf, HI_U16 u2ByteCnt)
{
    HI_S32 s32Ret = 0;

    if (pstNTP8212Drv->pI2CFunc == HI_NULL)
    {
        HI_ERR_AMP("I2C Function Null \n");
        return HI_FAILURE;
    }

    s32Ret = pstNTP8212Drv->pI2CFunc->pfnI2cRead(pstNTP8212Drv->u32I2CNum,
             pstNTP8212Drv->u8DeviceAddr, u1Addr, 1, pu1Buf, u2ByteCnt);
    if (s32Ret != HI_SUCCESS)
    {
        //HI_ERR_AMP("5711read fail :%d!\n", s32Ret );
    }
    return s32Ret;
}

static HI_VOID AMPReset(HI_BOOL bReset)
{
    if (pstNTP8212Drv == HI_NULL)
    {
        HI_ERR_AMP("NTP8212 no Init! \n");
        return;
    }

    if (pstNTP8212Drv->pGpioFunc== HI_NULL)
    {
        HI_ERR_AMP("GPIO Function Null \n");
        return;
    }    
    
    if (pstNTP8212Drv->pGpioFunc->pfnGpioDirSetBit)
    {
        pstNTP8212Drv->pGpioFunc->pfnGpioDirSetBit(pstNTP8212Drv->u32ResetGPIONum,
                pstNTP8212Drv->u32GPIOOutputPolarity); //Output Mode
    }
    
    msleep(1);
    
    if (pstNTP8212Drv->pGpioFunc->pfnGpioWriteBit)
    { 
        if (bReset)
        {            
            pstNTP8212Drv->pGpioFunc->pfnGpioWriteBit(pstNTP8212Drv->u32ResetGPIONum, 
                                                       pstNTP8212Drv->u32ResetPolarity);
        }
        else
        {
            pstNTP8212Drv->pGpioFunc->pfnGpioWriteBit(pstNTP8212Drv->u32ResetGPIONum, 
                                                       !(pstNTP8212Drv->u32ResetPolarity));
        }
    }        
    
    msleep(NTP8212_INIT_INTERVAL);

    return;
}

#if 1
static HI_VOID AMPHWMute(HI_BOOL bMute)
{
    if (pstNTP8212Drv == HI_NULL)
    {
        HI_ERR_AMP("NTP8212 no Init! \n");
        return;
    }

    if (pstNTP8212Drv->pGpioFunc== HI_NULL)
    {
        HI_ERR_AMP("GPIO Function Null \n");
        return;
    }    
    if (pstNTP8212Drv->pGpioFunc->pfnGpioDirSetBit)
    {
        pstNTP8212Drv->pGpioFunc->pfnGpioDirSetBit(pstNTP8212Drv->u32HWMuteGPIONum, 
                                      pstNTP8212Drv->u32GPIOOutputPolarity); //Output Mode
    }
    
    msleep(1);
    
    if (pstNTP8212Drv->pGpioFunc->pfnGpioWriteBit)
    { 
        if (bMute)
        {            
            pstNTP8212Drv->pGpioFunc->pfnGpioWriteBit(pstNTP8212Drv->u32HWMuteGPIONum, 
                                                       pstNTP8212Drv->u32HWMutePolarity);
        }
        else
        {
            pstNTP8212Drv->pGpioFunc->pfnGpioWriteBit(pstNTP8212Drv->u32HWMuteGPIONum, 
                                                       !(pstNTP8212Drv->u32HWMutePolarity));
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
    NTP8212_REGMAP     *pstNTP8212InitTbl;
#endif

    //Set NTP8212 Software ops and Hardware setting
    if (pstAmpDrv == HI_NULL)
    {
        HI_ERR_AMP("Cannot get Any Setting for NTP8212! \n");
        return HI_FAILURE;
    }
    else
    {
        pstNTP8212Drv         = pstAmpDrv;
    }

#ifndef HI_AMP_LINUX_CFG
    AMP_SetMute(HI_TRUE);
#endif
    
#ifndef HI_BOOT_MUSIC_SUPPORT
    pstNTP8212InitTbl     = NTP8212_DefautTbl;

    AMPHWMute(HI_FALSE);

    msleep(10);
    
    //Reset AMP
    AMPReset(HI_TRUE);
    
    msleep(10);        
    
    //Release Reset AMP
    AMPReset(HI_FALSE);        

    for(u8Index = 0; ; u8Index ++)
    {
        u8Addr = pstNTP8212InitTbl[u8Index].bAddr;
        if(u8Addr == ENDTBL_FLAG)
        {
            break;
        }

        u8Length = pstNTP8212InitTbl[u8Index].bLength;
        for(u8CountLoop = 0; u8CountLoop < u8Length; u8CountLoop ++)
        {        
            u8Array[u8CountLoop] = *(pstNTP8212InitTbl[u8Index].bArray + u8CountLoop);
        }
        
        s32Ret = AMPWriteReg(u8Addr, u8Array, u8Length);
        if(s32Ret != HI_SUCCESS)
        {
        //    HI_ERR_AMP("NTP8212Init Fail \n");
        }

        //0x1B:Oscillator Trim, 0x46:DRC Control, 0x50:EQ Control, 0xF9:I2C Device Addr
        if((u8Addr == 0x1B) || (u8Addr == 0x46) || (u8Addr == 0x50) || (u8Addr == 0xF9))
        {    
            msleep(1);
        }

#if AMP_DEBUG
        HI_U8 readArray[MAX_AMP_REG_LEN]    =    {0};
        s32Ret = AMPReadReg(u8Addr, readArray, u8Length);
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
    NTP8212_REGMAP     *pstNTP8212InitTbl;

    //Set NTP8212 Software ops and Hardware setting
    if (pstAmpDrv == HI_NULL)
    {
        HI_ERR_AMP("Cannot get Any Setting for NTP8212! \n");
        return HI_FAILURE;
    }
    else
    {
        pstNTP8212Drv         = pstAmpDrv;
    }
    
    pstNTP8212InitTbl     = NTP8212_DefautTbl;

    AMPHWMute(HI_FALSE);

    msleep(10);
    
    //Reset AMP
    AMPReset(HI_TRUE);
    
    msleep(10);        
    
    //Release Reset AMP
    AMPReset(HI_FALSE);        

    for(u8Index = 0; ; u8Index ++)
    {
        u8Addr = pstNTP8212InitTbl[u8Index].bAddr;
        if(u8Addr == ENDTBL_FLAG)
        {
            break;
        }

        u8Length = pstNTP8212InitTbl[u8Index].bLength;
        for(u8CountLoop = 0; u8CountLoop < u8Length; u8CountLoop ++)
        {        
            u8Array[u8CountLoop] = *(pstNTP8212InitTbl[u8Index].bArray + u8CountLoop);
        }
        
        s32Ret = AMPWriteReg(u8Addr, u8Array, u8Length);
        if(s32Ret != HI_SUCCESS)
        {
        //    HI_ERR_AMP("NTP8212Init Fail \n");
        }

        //0x1B:Oscillator Trim, 0x46:DRC Control, 0x50:EQ Control, 0xF9:I2C Device Addr
        if((u8Addr == 0x1B) || (u8Addr == 0x46) || (u8Addr == 0x50) || (u8Addr == 0xF9))
        {    
            msleep(1);
        }

#if AMP_DEBUG
        HI_U8 readArray[MAX_AMP_REG_LEN]    =    {0};
        s32Ret = AMPReadReg(u8Addr, readArray, u8Length);
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
    if (pstNTP8212Drv == HI_NULL)
    {
        HI_ERR_AMP("NTP8212 is not initialized yet! \n");
        return;
    }

    //Reset AMP
    AMPReset(HI_TRUE);    

    pstNTP8212Drv = HI_NULL;
    
    return;
}

static HI_S32 AMP_SetMute(HI_BOOL bMute)
{
    HI_S32 s32Ret;
    HI_U8  u8Gain[1]= {0};

    if (bMute)
    {
        u8Gain[0] = NTP8212_MIN_VOL;
        s32Ret = AMPWriteReg(AMP_MASTER_VOL_REG, u8Gain, 1);
    }
    else
    {
        u8Gain[0] = NTP8212_MAX_VOL;
        s32Ret = AMPWriteReg(AMP_MASTER_VOL_REG, u8Gain, 1);
    }
    return s32Ret;
}

static HI_S32 AMP_GetMute(HI_BOOL* pbMute)
{
    HI_S32 s32Ret;
    HI_U8  u8Gain = 0;
    
    if (pstNTP8212Drv == HI_NULL)
    {
        HI_ERR_AMP("NTP8212 is not initialized yet! \n");
        return HI_FAILURE;
    }

    s32Ret = AMPReadReg(AMP_MASTER_VOL_REG, &u8Gain, 1);
    if (u8Gain == NTP8212_MIN_VOL)
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

    if (u32ByteSize > MAX_AMP_REG_LEN)
    {
        HI_ERR_AMP("NTP8212 reg length MAX is 20\n");
        u32ByteSize = MAX_AMP_REG_LEN;
    }

    Ret = copy_from_user(RegArray, pu8Value, u32ByteSize);
    if(Ret != HI_SUCCESS)
    {
        HI_ERR_AMP("NTP8212 copy_from_user Fail \n");
    }

    Ret = AMPWriteReg(u32RegAddr, RegArray, u32ByteSize);
    if(Ret != HI_SUCCESS)
    {
        HI_ERR_AMP("NTP8212 write I2C Fail \n");
    }
    
    return HI_SUCCESS; 
}

static HI_S32 AMP_ReadReg(HI_U32 u32RegAddr, HI_U32 u32ByteSize, HI_U8* pu8Value)
{
    HI_S32 Ret;
    HI_U8  RegArray[MAX_AMP_REG_LEN];

    if (pstNTP8212Drv == HI_NULL)
    {
        HI_ERR_AMP("NTP8212 is not initialized yet! \n");
        return HI_FAILURE;
    }

    if (u32ByteSize > MAX_AMP_REG_LEN)
    {
        HI_ERR_AMP("NTP8212 reg length MAX is 20\n");
        u32ByteSize = MAX_AMP_REG_LEN;
    }
    
    Ret = AMPReadReg(u32RegAddr, RegArray, u32ByteSize);
    if(Ret != HI_SUCCESS)
    {
        HI_ERR_AMP("NTP8212 Read I2C Fail \n");
    }

    Ret = copy_to_user(pu8Value, RegArray, u32ByteSize);
    if(Ret != HI_SUCCESS)
    {
        HI_ERR_AMP("NTP8212 copy_to_user Fail \n");
    }

    return HI_SUCCESS; 
}

static HI_S32 AMP_ReadProc(struct seq_file *p, HI_VOID *pData)
{
    HI_S32          Ret;
    HI_U8             u8Index, u8Addr, u8Length, u8CountLoop;
    HI_U8             u8Array[MAX_AMP_REG_LEN];
    NTP8212_REGMAP     *pstNTP8212InitTbl;
    
    if (pstNTP8212Drv == HI_NULL)
    {
        HI_ERR_AMP("NTP8212 is not initialized yet! \n");
        return HI_FAILURE;
    }

    PROC_PRINT(p, "AMP Modul:        NTP8212\n");
    PROC_PRINT(p, "I2C Num:          %d\n" ,  pstNTP8212Drv->u32I2CNum);
    PROC_PRINT(p, "I2C Addr:         0x%x\n", pstNTP8212Drv->u8DeviceAddr);    
    PROC_PRINT(p, "Mute  GPIO Group: %d\n", pstNTP8212Drv->u32HWMuteGPIONum/8);
    PROC_PRINT(p, "Mute  GPIO Bit:   %d\n",    pstNTP8212Drv->u32HWMuteGPIONum%8);
    PROC_PRINT(p, "Mute  Polarity:   %d\n",    pstNTP8212Drv->u32HWMutePolarity);                                                                    
    
    PROC_PRINT(p, "Reset GPIO Group: %d\n", pstNTP8212Drv->u32ResetGPIONum/8);
    PROC_PRINT(p, "Reset GPIO Bit:   %d\n", pstNTP8212Drv->u32ResetGPIONum%8);
    PROC_PRINT(p, "Reset Polarity:   %d\n", pstNTP8212Drv->u32ResetPolarity);

    pstNTP8212InitTbl     = NTP8212_DefautTbl;

    PROC_PRINT(p,"\n--------------------- NTP8212 REGMAP -------------------------------------------------");
    for(u8Index = 0; ; u8Index ++)
    {
        u8Addr = pstNTP8212InitTbl[u8Index].bAddr;
        if(u8Addr == ENDTBL_FLAG)
        {
            break;
        }
        u8Length = pstNTP8212InitTbl[u8Index].bLength;
        PROC_PRINT(p, "\nAddr[0x%x] Len[%d]: ",u8Addr,u8Length);
        memset(u8Array,0,MAX_AMP_REG_LEN);    
        Ret = AMPReadReg(u8Addr, u8Array, u8Length);
        if(Ret != HI_SUCCESS)
        {
            HI_ERR_AMP("NTP8212 Read I2C Fail \n");
        }
        
        for(u8CountLoop = 0; u8CountLoop < u8Length; u8CountLoop++)
        {
            PROC_PRINT(p, "0x%x ", u8Array[u8CountLoop]);
        }    
    }
    PROC_PRINT(p,"\n--------------------- END NTP8212 REGMAP -------------------------------------------------\n");
    
    return HI_SUCCESS;
}

static HI_S32 AMP_WriteProc(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
{
    AMP_CMD_PROC_E enProcCmd;

    HI_CHAR szBuf[48];
    HI_CHAR *pcBuf      = szBuf;
    HI_CHAR *pcDrcCmd   = "drc";
    HI_CHAR *pcPeqCmd   = "peq";
    HI_CHAR *pcHelpCmd  = "help";
    
    if (pstNTP8212Drv == HI_NULL)
    {
        HI_ERR_AMP("NTP8212 is not initialized yet! \n");
        return HI_FAILURE;
    }

    if (copy_from_user(szBuf, buf, count))
    {
        HI_ERR_AMP("copy from user failed\n");
        return HI_FAILURE;
    }

    AMP_STRING_SKIP_BLANK(pcBuf);
    
    if (strstr(pcBuf, pcDrcCmd))
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

    if(AMP_CMD_PROC_SET_DRC == enProcCmd)
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
        
#if 0
        for (enDrcType = HI_AMP_POST_DRC_BANK; enDrcType <= HI_AMP_SUB_DRC_BANK; enDrcType++)
        {
            s32Ret = AMP_SetDrcEn(enDrcType, bEn);
            if (HI_SUCCESS != s32Ret)
            {
                goto CMD_FAULT;
            }
        }
#endif 
    }
    
    if(AMP_CMD_PROC_SET_PEQ == enProcCmd)
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
#if 0
        for (enChNo = HI_AMP_CH_1; enChNo < HI_AMP_CH_BOTH; enChNo++)
        {
            for (enPeqBand = HI_PEQ_BQ_1; enPeqBand < HI_PEQ_BQ_12; enPeqBand++)
            {
                s32Ret = AMP_SetPEQEn(enChNo, enPeqBand, bEn);
                if (HI_SUCCESS != s32Ret)
                {
                    goto CMD_FAULT;
                }
            }
        }
#endif
    }

    return count;

CMD_FAULT:
    HI_ERR_AMP("proc cmd is fault\n");
    AMP_PROC_SHOW_HELP();
    
    return HI_FAILURE;
}

AMP_DRV_FUNC_S stNTP8212Func =
{
    .bExtMClkFlag  = HI_FALSE,
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

