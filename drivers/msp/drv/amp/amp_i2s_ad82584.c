/*********************************************************************

Copyright (C), 2001-2011, Hisilicon Tech. Co., Ltd.

**********************************************************************
File Name     :    amp_i2s_ad82584.c
Version         :    Initial    Draft
Author         :
Created         :    2015/12/23
Last Modified:
Description   :    AD82584 Driver
Function List :
History         :
* Version     Date       Author     DefectNum          Description
           2015/12/23   lWX321970      NULL            Create this file.
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

#define ENDTBL_FLAG (0xff)
#define AMP_DEBUG (0)
#define MAX_AMP_REG_LEN (20)
#define AD82584_MAX_VOL (0x00)
#define AD82584_MIN_VOL (0xFF) //Mute
#define AMP_MUTE_REGISTER 0x02 //Master channel mute register
#define AD82584_INIT_INTERVAL (65) //Delay 65ms

static AMP_GLOBAL_PARAM_S* pstAd82584Drv = HI_NULL;
extern AMP_DRV_FUNC_S stAd82584Func;
static HI_S32 AMP_SetMute(HI_BOOL bMute);

typedef struct
{
    HI_U8 bAddr;
    HI_U8 bLength;
    HI_U8 bArray[MAX_AMP_REG_LEN];
}AD82584_REGMAP;

static AD82584_REGMAP Ad82584_DefautTbl[] =
{
    {0x02 ,0x01,{0x0f}}, //mute
    {0x03 ,0x01,{0x18}}, //Master Vol default=0dB
    {0x04 ,0x01,{0x13}}, //CH1 Vol default=2.5dB
    {0x05 ,0x01,{0x13}}, //CH2 Vol default=2.5dB
    {0x07 ,0x01,{0x10}}, //Bass_tone_control 12dB~-12dB 360Hz 0dB
    {0x08 ,0x01,{0x15}}, //Treble_tone_control 12dB~-12dB 7KHz -5dB
    {0x09 ,0x01,{0x02}}, //Bass_management_crossover_frequency 0x01=120Hz
    {0x0A ,0x01,{0x98}}, //State_Control_4(surround_off+Bass_treble_off+EQ_CH1toCH2)
    {0x0B ,0x01,{0x12}}, //CH1 DRC & Power clipping enable RMS mode+HPF-off
    {0x0C ,0x01,{0x12}}, //CH2 DRC & Power clipping enable RMS mode+HPF-off
    {0x11 ,0x01,{0x30}}, //State_Control_4(reset_off+MCLK_on+power_saving_off+PWM_Q_mode)
    {0x12 ,0x01,{0x81}}, //PVDD_UVP default=0x81=off+9.7V   0x01=on+9.7V
    /*Noise gate SETTING*/
    {0x75 ,0x03,{0x00,0x1a,0x07}}, //Noise gate ATH=-62dB
    {0x76 ,0x03,{0x00,0x20,0xc4}}, //Noise gate RTH=-60dB
    {ENDTBL_FLAG ,0x01,{0x00}},
};

static HI_S32 AMPWriteReg(HI_U8 u1Addr, HI_U8 *pu1Buf, HI_U16 u2ByteCnt)
{
    HI_S32 s32Ret = 0;

    if (pstAd82584Drv->pI2CFunc == HI_NULL)
    {
        HI_ERR_AMP("I2C Function Null \n");
        return HI_FAILURE;
    }

    s32Ret = pstAd82584Drv->pI2CFunc->pfnI2cWrite(pstAd82584Drv->u32I2CNum,
             pstAd82584Drv->u8DeviceAddr, u1Addr, 1, pu1Buf, u2ByteCnt);
    if (s32Ret != HI_SUCCESS)
    {

        HI_ERR_AMP("AD82584i2c write error :I2cNum:0x%x, I2cDevAddr:0x%x, "
                   "u1Addr:0x%x, addlen:0x%x, pu1Buf:0x%x, u2ByteCnt:0x%x\n",
                   pstAd82584Drv->u32I2CNum, pstAd82584Drv->u8DeviceAddr,
                   u1Addr, 1, pu1Buf[0], u2ByteCnt);
    }

    return s32Ret;
}

static HI_S32 AMPReadReg(HI_U8 u1Addr, HI_U8 *pu1Buf, HI_U16 u2ByteCnt)
{
    HI_S32 s32Ret = 0;

    if (pstAd82584Drv->pI2CFunc == HI_NULL)
    {
        HI_ERR_AMP("I2C Function Null \n");
        return HI_FAILURE;
    }

    s32Ret = pstAd82584Drv->pI2CFunc->pfnI2cRead(pstAd82584Drv->u32I2CNum,
             pstAd82584Drv->u8DeviceAddr, u1Addr, 1, pu1Buf, u2ByteCnt);
    if (s32Ret != HI_SUCCESS)
    {
        HI_ERR_AMP("AD82584 read fail :%d!\n", s32Ret );
    }

    return s32Ret;
}

static HI_VOID AMPReset(HI_BOOL bReset)
{
    HI_S32 s32Ret;

    if (pstAd82584Drv == HI_NULL)
    {
        HI_ERR_AMP("AD82584 no Init! \n");
        return;
    }

    if (pstAd82584Drv->pGpioFunc== HI_NULL)
    {
        HI_ERR_AMP("GPIO Function Null \n");
        return;
    }

    if (pstAd82584Drv->pGpioFunc->pfnGpioDirSetBit)
    {
        s32Ret = pstAd82584Drv->pGpioFunc->pfnGpioDirSetBit(pstAd82584Drv->u32ResetGPIONum,
                pstAd82584Drv->u32GPIOOutputPolarity); //Output Mode
        if(s32Ret == HI_FAILURE)
        {
            HI_ERR_AMP("GPIO Function Set bit failed\n");
        }
    }

    msleep(1);

    if (pstAd82584Drv->pGpioFunc->pfnGpioWriteBit)
    {
        if (bReset)
        {
            s32Ret = pstAd82584Drv->pGpioFunc->pfnGpioWriteBit(pstAd82584Drv->u32ResetGPIONum,
                                                       pstAd82584Drv->u32ResetPolarity);
            if(s32Ret == HI_FAILURE)
            {
                HI_ERR_AMP("GPIO Function write bit bit failed\n");
            }
        }
        else
        {
            s32Ret = pstAd82584Drv->pGpioFunc->pfnGpioWriteBit(pstAd82584Drv->u32ResetGPIONum,
                                                       !(pstAd82584Drv->u32ResetPolarity));
            if(s32Ret == HI_FAILURE)
            {
                HI_ERR_AMP("GPIO Function write bit bit failed\n");
            }
        }
    }

    msleep(AD82584_INIT_INTERVAL);

    return;
}

static HI_VOID AMPHWMute(HI_BOOL bMute)
{
    HI_S32 s32Ret;

    if (pstAd82584Drv == HI_NULL)
    {
        HI_ERR_AMP("AD82584 no Init! \n");
        return;
    }

    if (pstAd82584Drv->pGpioFunc== HI_NULL)
    {
        HI_ERR_AMP("GPIO Function Null \n");
        return;
    }

    if (pstAd82584Drv->pGpioFunc->pfnGpioDirSetBit)
    {
        s32Ret = pstAd82584Drv->pGpioFunc->pfnGpioDirSetBit(pstAd82584Drv->u32HWMuteGPIONum,
                                      pstAd82584Drv->u32GPIOOutputPolarity); //Output Mode
        if(s32Ret == HI_FAILURE)
        {
            HI_ERR_AMP("GPIO Function Set bit failed\n");
        }
    }

    msleep(1);

    if (pstAd82584Drv->pGpioFunc->pfnGpioWriteBit)
    {
        if (bMute)
        {
            s32Ret = pstAd82584Drv->pGpioFunc->pfnGpioWriteBit(pstAd82584Drv->u32HWMuteGPIONum,
                                                       pstAd82584Drv->u32HWMutePolarity);
            if(s32Ret == HI_FAILURE)
            {
                HI_ERR_AMP("GPIO Function write bit bit failed\n");
            }
        }
        else
        {
            s32Ret = pstAd82584Drv->pGpioFunc->pfnGpioWriteBit(pstAd82584Drv->u32HWMuteGPIONum,
                                                       !(pstAd82584Drv->u32HWMutePolarity));
            if(s32Ret == HI_FAILURE)
            {
                HI_ERR_AMP("GPIO Function write bit bit failed\n");
            }
        }
    }

    return;
}

static HI_S32 AMP_Init(AMP_GLOBAL_PARAM_S* pstAmpDrv)
{
    //#ifndef HI_BOOT_MUSIC_SUPPORT //AMP need strictly stable MCLK should init whether has bootmusic or not
    HI_S32            s32Ret = 0;
    HI_U8             u8Index, u8Addr, u8Length, u8CountLoop;
    HI_U8             u8Array[MAX_AMP_REG_LEN];
    AD82584_REGMAP    *pstAd82584InitTbl;

    //Set AD82584 Software ops and Hardware setting
    if (pstAmpDrv == HI_NULL)
    {
        HI_ERR_AMP("Cannot get Any Setting for AD83586! \n");
        return HI_FAILURE;
    }
    else
    {
        pstAd82584Drv = pstAmpDrv;
    }

    pstAd82584InitTbl = Ad82584_DefautTbl;

    AMPHWMute(HI_FALSE);
    AMPReset(HI_FALSE);
    //Release Reset AMP
    msleep(20);
    AMPReset(HI_TRUE);
    msleep(20);

    AMPReset(HI_FALSE);
    msleep(20);

    for(u8Index = 0; ; u8Index ++)
    {
        u8Addr = pstAd82584InitTbl[u8Index].bAddr;
        if(u8Addr == ENDTBL_FLAG)
        {
            break;
        }

        u8Length = pstAd82584InitTbl[u8Index].bLength;
        for(u8CountLoop = 0; u8CountLoop < u8Length; u8CountLoop ++)
        {
            u8Array[u8CountLoop] = *(pstAd82584InitTbl[u8Index].bArray + u8CountLoop);
        }

        s32Ret = AMPWriteReg(u8Addr, u8Array, u8Length);
        if(s32Ret != HI_SUCCESS)
        {
            HI_ERR_AMP("AD82584 Init Fail \n");
        }

#if AMP_DEBUG
        HI_U8 readArray[MAX_AMP_REG_LEN] = {0};
        s32Ret = AMPReadReg(u8Addr, readArray, u8Length);
        HI_ERR_AMP("addr:0x%x, length:0x%x, ",    u8Addr,    u8Length);
        for(u8CountLoop = 0; u8CountLoop < u8Length; u8CountLoop ++)
        {
            HI_ERR_AMP("0x%x,",    readArray[u8CountLoop]);
        }
        HI_ERR_AMP("\n");
#endif

    }
//#endif //end #ifndef HI_BOOT_MUSIC_SUPPORT

#ifndef HI_AMP_LINUX_CFG
    AMP_SetMute(HI_TRUE);
#endif

    return HI_SUCCESS;
}

static HI_S32 AMP_Resume(AMP_GLOBAL_PARAM_S* pstAmpDrv)
{
    HI_S32            s32Ret = 0;
    HI_U8             u8Index, u8Addr, u8Length, u8CountLoop;
    HI_U8             u8Array[MAX_AMP_REG_LEN];
    AD82584_REGMAP    *pstAd82584InitTbl;

    //Set AD82584 Software ops and Hardware setting
    if (pstAmpDrv == HI_NULL)
    {
        HI_ERR_AMP("Cannot get Any Setting for AD82584! \n");
        return HI_FAILURE;
    }
    else
    {
        pstAd82584Drv = pstAmpDrv;
    }

    pstAd82584InitTbl = Ad82584_DefautTbl;

    AMPHWMute(HI_FALSE);
    AMPReset(HI_FALSE);
    //Release Reset AMP
    msleep(10);
    AMPReset(HI_TRUE);
    msleep(10);

    AMPReset(HI_FALSE);
    msleep(10);

    for(u8Index = 0; ; u8Index ++)
    {
        u8Addr = pstAd82584InitTbl[u8Index].bAddr;
        if(u8Addr == ENDTBL_FLAG)
        {
            break;
        }

        u8Length = pstAd82584InitTbl[u8Index].bLength;
        for(u8CountLoop = 0; u8CountLoop < u8Length; u8CountLoop ++)
        {
            u8Array[u8CountLoop] = *(pstAd82584InitTbl[u8Index].bArray + u8CountLoop);
        }

        s32Ret = AMPWriteReg(u8Addr, u8Array, u8Length);
        if(s32Ret != HI_SUCCESS)
        {
            HI_ERR_AMP("AD82584 Init Fail \n");
        }

#if AMP_DEBUG
        HI_U8 readArray[MAX_AMP_REG_LEN] = {0};
        s32Ret = AMPReadReg(u8Addr, readArray, u8Length);
        HI_ERR_AMP("addr:0x%x, length:0x%x, ",    u8Addr,    u8Length);
        for(u8CountLoop = 0; u8CountLoop < u8Length; u8CountLoop ++)
        {
            HI_ERR_AMP("0x%x,",    readArray[u8CountLoop]);
        }
        HI_ERR_AMP("\n");
#endif

    }

    return HI_SUCCESS;
}

static HI_VOID AMP_DeInit(HI_VOID)
{
    if (pstAd82584Drv == HI_NULL)
    {
        HI_ERR_AMP("AD82584 is not initialized yet! \n");
        return;
    }

    //Reset AMP
    AMPReset(HI_TRUE);

    pstAd82584Drv = HI_NULL;

    return;
}

static HI_S32 AMP_SetMute(HI_BOOL bMute)
{
    HI_S32 s32Ret;
    HI_U8  u8Gain[1]= {0};

    if (pstAd82584Drv == HI_NULL)
    {
        HI_ERR_AMP("AD82584 is not initialized yet! \n");
        return HI_FAILURE;
    }

    if (bMute)
    {
        u8Gain[0] = AD82584_MIN_VOL;
        s32Ret = AMPWriteReg(AMP_MUTE_REGISTER, u8Gain, 1);
    }
    else
    {
        u8Gain[0] = AD82584_MAX_VOL;
        s32Ret = AMPWriteReg(AMP_MUTE_REGISTER, u8Gain, 1);
    }

    return s32Ret;
}

static HI_S32 AMP_GetMute(HI_BOOL* pbMute)
{
    HI_S32 s32Ret;
    HI_U8  u8Gain[1] = {0};

    if (pstAd82584Drv == HI_NULL)
    {
        HI_ERR_AMP("AD82584 is not initialized yet! \n");
        return HI_FAILURE;
    }

    s32Ret = AMPReadReg(AMP_MUTE_REGISTER, u8Gain, 1);
    if (u8Gain[0] == AD82584_MIN_VOL)
    {
        *pbMute = HI_TRUE;
    }
    else
    {
        *pbMute = HI_FALSE;
    }

    return s32Ret;
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

    if (pstAd82584Drv == HI_NULL)
    {
        HI_ERR_AMP("AD82584 is not initialized yet! \n");
        return HI_FAILURE;
    }

    if (u32ByteSize > MAX_AMP_REG_LEN)
    {
        HI_ERR_AMP("AD82584 reg length MAX is 20\n");
        u32ByteSize = MAX_AMP_REG_LEN;
    }

    Ret = copy_from_user(RegArray, pu8Value, u32ByteSize);
    if(Ret != HI_SUCCESS)
    {
        HI_ERR_AMP("AD82584 copy_from_user Fail \n");
    }

    Ret = AMPWriteReg(u32RegAddr, RegArray, u32ByteSize);
    if(Ret != HI_SUCCESS)
    {
        HI_ERR_AMP("AD82584 write I2C Fail \n");
    }

    return HI_SUCCESS;
}

static HI_S32 AMP_ReadReg(HI_U32 u32RegAddr, HI_U32 u32ByteSize, HI_U8* pu8Value)
{
    HI_S32 Ret;
    HI_U8  RegArray[MAX_AMP_REG_LEN];

    if (pstAd82584Drv == HI_NULL)
    {
        HI_ERR_AMP("AD82584 is not initialized yet! \n");
        return HI_FAILURE;
    }

    if (u32ByteSize > MAX_AMP_REG_LEN)
    {
        HI_ERR_AMP("AD82584 reg length MAX is 20\n");
        u32ByteSize = MAX_AMP_REG_LEN;
    }

    Ret = AMPReadReg(u32RegAddr, RegArray, u32ByteSize);
    if(Ret != HI_SUCCESS)
    {
        HI_ERR_AMP("AD82584 Read I2C Fail \n");
    }

    Ret = copy_to_user(pu8Value, RegArray, u32ByteSize);
    if(Ret != HI_SUCCESS)
    {
        HI_ERR_AMP("AD82584 copy_to_user Fail \n");
    }

    return HI_SUCCESS;
}

static HI_S32 AMP_Proc(struct seq_file *p, HI_VOID *pData)
{
    HI_U8             u8Index, u8Addr, u8Length, u8CountLoop;
    HI_U8             u8Array[MAX_AMP_REG_LEN];
    AD82584_REGMAP    *pstAd82584InitTbl;

    if (pstAd82584Drv == HI_NULL)
    {
        HI_ERR_AMP("AD82584 is not initialized yet! \n");
        return HI_FAILURE;
    }

    PROC_PRINT(p, "AMP Modul:        AD82584\n");
    PROC_PRINT(p, "I2C Num:          %d\n" ,  pstAd82584Drv->u32I2CNum);
    PROC_PRINT(p, "I2C Addr:         0x%x\n", pstAd82584Drv->u8DeviceAddr);
    PROC_PRINT(p, "Mute  GPIO Group: %d\n", pstAd82584Drv->u32HWMuteGPIONum/8);
    PROC_PRINT(p, "Mute  GPIO Bit:   %d\n", pstAd82584Drv->u32HWMuteGPIONum%8);
    PROC_PRINT(p, "Mute  Polarity:   %d\n", pstAd82584Drv->u32HWMutePolarity);

    PROC_PRINT(p, "Reset GPIO Group: %d\n", pstAd82584Drv->u32ResetGPIONum/8);
    PROC_PRINT(p, "Reset GPIO Bit:   %d\n", pstAd82584Drv->u32ResetGPIONum%8);
    PROC_PRINT(p, "Reset Polarity:   %d\n", pstAd82584Drv->u32ResetPolarity);

    pstAd82584InitTbl     = Ad82584_DefautTbl;

    PROC_PRINT(p,"\n--------------------- AD82584 REGMAP -------------------------------------------------");
    for(u8Index = 0; ; u8Index ++)
    {
        u8Addr = pstAd82584InitTbl[u8Index].bAddr;
        if(u8Addr == ENDTBL_FLAG)
        {
            break;
        }
        u8Length = pstAd82584InitTbl[u8Index].bLength;
        PROC_PRINT(p, "\nAddr[0x%x] Len[%d]: ",u8Addr,u8Length);
        memset(u8Array,0,MAX_AMP_REG_LEN);
        AMPReadReg(u8Addr, u8Array, u8Length);

        for(u8CountLoop = 0; u8CountLoop < u8Length; u8CountLoop ++)
        {
            PROC_PRINT(p, "0x%x ", u8Array[u8CountLoop]);
        }
    }
    PROC_PRINT(p,"\n--------------------- END AD82584 REGMAP -------------------------------------------------\n");

    return HI_SUCCESS;
}

AMP_DRV_FUNC_S stAd82584Func =
{
    .bExtMClkFlag  = HI_TRUE,
    .pfnAmpReadProc = AMP_Proc,
    .pfnAmpWriteProc = HI_NULL,
    .pfnAmpReadReg = AMP_ReadReg,
    .pfnAmpWriteReg = AMP_WriteReg,
    .pfnAmpGetSubWooferVol = AMP_GetSubWooferVol,
    .pfnAmpSetSubWooferVol = AMP_SetSubWooferVol,
    .pfnAmpGetMute = AMP_GetMute,
    .pfnAmpSetMute = AMP_SetMute,
    .pfnAmpDeinit = AMP_DeInit,
    .pfnAmpInit = (FN_AMP_INIT)AMP_Init,
    .pfnAmpResume = (FN_AMP_INIT)AMP_Resume,
};

#ifdef __cplusplus
 #if __cplusplus
}
 #endif
#endif /* End of #ifdef __cplusplus */






