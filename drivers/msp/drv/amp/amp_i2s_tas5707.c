/*********************************************************************

Copyright (C), 2001-2011, Hisilicon Tech. Co., Ltd.

**********************************************************************
File Name     :    amp_i2s_tas5707.h
Version         :    Initial    Draft
Author         :    l00191026
Created         :    2014/2/28
Last Modified:
Description   :    TAS5707 Driver
Function List :
History         :
* Version     Date       Author     DefectNum          Description
                2014/2/28     l00191026      NULL            Create this file.
           2014/3/24   l00191026      NULL            Update type define.
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
#define TAS5707_MAX_VOL (0x05)
#define TAS5707_MIN_VOL (0xff) //Mute
#define TAS5707_INIT_INTERVAL (65) //Delay 65ms

static AMP_GLOBAL_PARAM_S* pstTas5707Drv = HI_NULL;

typedef struct
{
    HI_U8 bAddr;
    HI_U8 bLength;
    HI_U8 bArray[MAX_AMP_REG_LEN];
}TAS5707_REGMAP;

static TAS5707_REGMAP Tas5707_DefautTbl[] = //Shenzhen1 name: DrvTas5711InitTbl1_8K10_U1
{
    {0x1B,0x01,{0x00}},                    //0:factory trim
    {0x06,0x01,{0x00}},                    //0:soft mute
    {0x20,0x04,{0x00,0x89,0x77,0x72}},    //0x98->0x89 to invert L/R output, BD Mode
    {0x11,0x01,{0xB8}},                    //0xB8:BD Mode
    {0x12,0x01,{0x60}},                    //0x60:BD Mode
    {0x13,0x01,{0xB8}},                    //0xA0:BD Mode
    {0x14,0x01,{0x60}},                    //0x48:BD Mode
    {0x50,0x04,{0x00,0x00,0x00,0x00}},    //Band switch and EQ Control


    {0x29,0x14,{0x00,0x7F,0x55,0x51,0x0F,0x80,0xAA,0xAF,0x00,0x00,0x00,0x00,0x00,0x7E,0xAA,0xA3,0x00,0x00,0x00,0x00}},
    {0x2A,0x14,{0x00,0x7F,0x83,0xD8,0x0F,0x02,0xD2,0xDA,0x00,0x7D,0xDB,0x4F,0x00,0xFD,0x2D,0x26,0x0F,0x82,0xA0,0xD8}},
    {0x2B,0x14,{0x00,0x80,0x7C,0xA0,0x0F,0x02,0x35,0x8E,0x00,0x7D,0xD9,0x39,0x00,0xFD,0xCA,0x72,0x0F,0x81,0xAA,0x27}},
    {0x2C,0x14,{0x00,0x81,0xA3,0xAE,0x0F,0x08,0xB0,0x42,0x00,0x78,0xC1,0x41,0x00,0xF7,0x4F,0xBE,0x0F,0x85,0x9B,0x11}},
    {0x2D,0x14,{0x00,0x85,0x2A,0x32,0x0F,0x2E,0x41,0x33,0x00,0x61,0xCB,0xB8,0x00,0xD1,0xBE,0xCD,0x0F,0x99,0x0A,0x15}},
    {0x2E,0x14,{0x00,0x8B,0xBA,0xC9,0x0F,0xA7,0xEC,0xDA,0x00,0x3B,0x67,0x91,0x00,0x58,0x13,0x26,0x0F,0xB8,0xDD,0xA6}},
    {0x2F,0x14,{0x00,0x80,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00}},
    {0x30,0x14,{0x00,0x7F,0x55,0x51,0x0F,0x80,0xAA,0xAF,0x00,0x00,0x00,0x00,0x00,0x7E,0xAA,0xA3,0x00,0x00,0x00,0x00}},
    {0x31,0x14,{0x00,0x7F,0x83,0xD8,0x0F,0x02,0xD2,0xDA,0x00,0x7D,0xDB,0x4F,0x00,0xFD,0x2D,0x26,0x0F,0x82,0xA0,0xD8}},
    {0x32,0x14,{0x00,0x80,0x7C,0xA0,0x0F,0x02,0x35,0x8E,0x00,0x7D,0xD9,0x39,0x00,0xFD,0xCA,0x72,0x0F,0x81,0xAA,0x27}},
    {0x33,0x14,{0x00,0x81,0xA3,0xAE,0x0F,0x08,0xB0,0x42,0x00,0x78,0xC1,0x41,0x00,0xF7,0x4F,0xBE,0x0F,0x85,0x9B,0x11}},
    {0x34,0x14,{0x00,0x85,0x2A,0x32,0x0F,0x2E,0x41,0x33,0x00,0x61,0xCB,0xB8,0x00,0xD1,0xBE,0xCD,0x0F,0x99,0x0A,0x15}},
    {0x35,0x14,{0x00,0x8B,0xBA,0xC9,0x0F,0xA7,0xEC,0xDA,0x00,0x3B,0x67,0x91,0x00,0x58,0x13,0x26,0x0F,0xB8,0xDD,0xA6}},
    {0x36,0x14,{0x00,0x80,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00}},


    //Energy Filter Params(a,w)
    {0x3A,0x08,{0x00,0x02,0xA3,0x9A,0x00,0x7D,0x5C,0x65}},
    //Attack and Decay filters
    {0x3B,0x08,{0x00,0x02,0xA3,0x9A,0x00,0x7D,0x5C,0x65}},
    {0x3C,0x08,{0x00,0x00,0x06,0xd3,0x00,0x7f,0xf9,0x2c}},
    //Compression Control(T,K,O)
    //{0x40,0x04,{0xFD,0x82,0x30,0x98}},
    {0x40,0x04,{0xFD,0xB7,0x57,0x36}},//referred to spinach
    {0x41,0x04,{0x0F,0x81,0x47,0xAF}},
    {0x42,0x04,{0x00,0x08,0x42,0x10}},    
    
    {0x46,0x04,{0x00,0x00,0x00,0x03}},    //DRC Control    
    {0x08,0x01,{0x1d}},	//referred to spinach
    {0x09,0x01,{0x1d}},	//referred to spinach
    {0x07,0x01,{0x05}},                    //default umute,mute:0xff,umute:0x5
    {0x05,0x01,{0x00}},                    //0: start play, 1:power down and hard mute
    
    {ENDTBL_FLAG ,0x01,{0x00}},
};

static HI_S32 AMP_SetMute(HI_BOOL bMute);

static HI_S32 AMPWriteReg(HI_U8 u1Addr, HI_U8 *pu1Buf, HI_U16 u2ByteCnt)
{
    HI_S32 s32Ret = 0;

    if (pstTas5707Drv->pI2CFunc  == HI_NULL)
    {
        HI_ERR_AMP("I2C Function Null \n");
        return HI_FAILURE;
    }
    
    s32Ret = pstTas5707Drv->pI2CFunc->pfnI2cWrite(pstTas5707Drv->u32I2CNum,
             pstTas5707Drv->u8DeviceAddr, u1Addr, 1, pu1Buf, u2ByteCnt);
    if (s32Ret != HI_SUCCESS)
    {
        
        HI_ERR_AMP("5707 i2c write error :I2cNum:0x%x, I2cDevAddr:0x%x, "
                   "u1Addr:0x%x, addlen:0x%x, pu1Buf:0x%x, u2ByteCnt:0x%x\n",
                   pstTas5707Drv->u32I2CNum, pstTas5707Drv->u8DeviceAddr,
                   u1Addr, 1, pu1Buf[0], u2ByteCnt);
    }
    return s32Ret;
}

static HI_S32 AMPReadReg(HI_U8 u1Addr, HI_U8 *pu1Buf, HI_U16 u2ByteCnt)
{
    HI_S32 s32Ret = 0;

    if (pstTas5707Drv->pI2CFunc == HI_NULL)
    {
        HI_ERR_AMP("I2C Function Null \n");
        return HI_FAILURE;
    }

    s32Ret = pstTas5707Drv->pI2CFunc->pfnI2cRead(pstTas5707Drv->u32I2CNum,
             pstTas5707Drv->u8DeviceAddr, u1Addr, 1, pu1Buf, u2ByteCnt);
    if (s32Ret != HI_SUCCESS)
    {
        //HI_ERR_AMP("5707 read fail :%d!\n", s32Ret );
    }
    return s32Ret;
}

static HI_VOID AMPReset(HI_BOOL bReset)
{
    if (pstTas5707Drv == HI_NULL)
    {
        HI_ERR_AMP("TAS5707 no Init! \n");
        return;
    }

    if (pstTas5707Drv->pGpioFunc== HI_NULL)
    {
        HI_ERR_AMP("GPIO Function Null \n");
        return;
    }

    if (pstTas5707Drv->pGpioFunc->pfnGpioDirSetBit)
    {
        pstTas5707Drv->pGpioFunc->pfnGpioDirSetBit(pstTas5707Drv->u32ResetGPIONum,
                pstTas5707Drv->u32GPIOOutputPolarity); //Output Mode
    }

    msleep(1);

    if (pstTas5707Drv->pGpioFunc->pfnGpioWriteBit)
    {
        if (bReset)
        {
            pstTas5707Drv->pGpioFunc->pfnGpioWriteBit(pstTas5707Drv->u32ResetGPIONum, 
                                                       pstTas5707Drv->u32ResetPolarity);
        }
        else
        {
            pstTas5707Drv->pGpioFunc->pfnGpioWriteBit(pstTas5707Drv->u32ResetGPIONum, 
                                                       !(pstTas5707Drv->u32ResetPolarity));
        }
    }

    msleep(TAS5707_INIT_INTERVAL);

    return;
}

static HI_VOID AMPHWMute(HI_BOOL bMute)
{
    if (pstTas5707Drv == HI_NULL)
    {
        HI_ERR_AMP("TAS5707 no Init! \n");
        return;
    }

    if (pstTas5707Drv->pGpioFunc== HI_NULL)
    {
        HI_ERR_AMP("GPIO Function Null \n");
        return;
    }
    if (pstTas5707Drv->pGpioFunc->pfnGpioDirSetBit)
    {
        pstTas5707Drv->pGpioFunc->pfnGpioDirSetBit(pstTas5707Drv->u32HWMuteGPIONum, 
                                      pstTas5707Drv->u32GPIOOutputPolarity); //Output Mode
    }

    msleep(1);

    if (pstTas5707Drv->pGpioFunc->pfnGpioWriteBit)
    {
        if (bMute)
        {
            pstTas5707Drv->pGpioFunc->pfnGpioWriteBit(pstTas5707Drv->u32HWMuteGPIONum, 
                                                       pstTas5707Drv->u32HWMutePolarity);
        }
        else
        {
            pstTas5707Drv->pGpioFunc->pfnGpioWriteBit(pstTas5707Drv->u32HWMuteGPIONum, 
                                                       !(pstTas5707Drv->u32HWMutePolarity));
        }
    }

    return;
}

static HI_S32 AMP_Init(AMP_GLOBAL_PARAM_S* pstAmpDrv)
{
#ifndef HI_BOOT_MUSIC_SUPPORT
    HI_S32             s32Ret = 0;
    HI_U8             u8Index, u8Addr, u8Length, u8CountLoop;
    HI_U8             u8Array[MAX_AMP_REG_LEN];
    TAS5707_REGMAP     *pstTas5707InitTbl;
    
    pstTas5707InitTbl     = Tas5707_DefautTbl;
#endif
    //Set TAS5707 Software ops and Hardware setting
    if (pstAmpDrv == HI_NULL)
    {
        HI_ERR_AMP("Cannot get Any Setting for TAS5707! \n");
        return HI_FAILURE;
    }
    else
    {
        pstTas5707Drv         = pstAmpDrv;
    }

#ifndef HI_AMP_LINUX_CFG
    AMP_SetMute(HI_TRUE);
#endif
	
#ifndef HI_BOOT_MUSIC_SUPPORT
    AMPHWMute(HI_FALSE);
    msleep(10);
    AMPReset(HI_TRUE);        //gmh add 20140423
    msleep(10);
    //Release Reset AMP
    AMPReset(HI_FALSE);        

    for(u8Index = 0; ; u8Index ++)
    {
        u8Addr = pstTas5707InitTbl[u8Index].bAddr;
        if(u8Addr == ENDTBL_FLAG)
        {
            break;
        }

        u8Length = pstTas5707InitTbl[u8Index].bLength;
        for(u8CountLoop = 0; u8CountLoop < u8Length; u8CountLoop ++)
        {        
            u8Array[u8CountLoop] = *(pstTas5707InitTbl[u8Index].bArray + u8CountLoop);
        }
        
        s32Ret = AMPWriteReg(u8Addr, u8Array, u8Length);
        if(s32Ret != HI_SUCCESS)
        {
        //    HI_ERR_AMP("TAS5707 Init Fail \n");
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
    TAS5707_REGMAP     *pstTas5707InitTbl;

    //Set TAS5707 Software ops and Hardware setting
    if (pstAmpDrv == HI_NULL)
    {
        HI_ERR_AMP("Cannot get Any Setting for TAS5707! \n");
        return HI_FAILURE;
    }
    else
    {
        pstTas5707Drv         = pstAmpDrv;
    }
    
    pstTas5707InitTbl     = Tas5707_DefautTbl;

    AMPHWMute(HI_FALSE);
    msleep(10);
    AMPReset(HI_TRUE);        //gmh add 20140423
    msleep(10);
    //Release Reset AMP
    AMPReset(HI_FALSE);        

    for(u8Index = 0; ; u8Index ++)
    {
        u8Addr = pstTas5707InitTbl[u8Index].bAddr;
        if(u8Addr == ENDTBL_FLAG)
        {
            break;
        }

        u8Length = pstTas5707InitTbl[u8Index].bLength;
        for(u8CountLoop = 0; u8CountLoop < u8Length; u8CountLoop ++)
        {        
            u8Array[u8CountLoop] = *(pstTas5707InitTbl[u8Index].bArray + u8CountLoop);
        }
        
        s32Ret = AMPWriteReg(u8Addr, u8Array, u8Length);
        if(s32Ret != HI_SUCCESS)
        {
        //    HI_ERR_AMP("TAS5707 Init Fail \n");
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
    if (pstTas5707Drv == HI_NULL)
    {
        HI_ERR_AMP("TAS5707 is not initialized yet! \n");
        return;
    }

    //Reset AMP
    AMPReset(HI_TRUE);    

    pstTas5707Drv = HI_NULL;
    
    return;
}

static HI_S32 AMP_SetMute(HI_BOOL bMute)
{
    HI_S32 s32Ret;
    HI_U8  u8Gain[1]= {0};

    if (pstTas5707Drv == HI_NULL)
    {
        HI_ERR_AMP("TAS5707 is not initialized yet! \n");
        return HI_FAILURE;
    }

    if (bMute)
    {
        u8Gain[0] = TAS5707_MIN_VOL;
        s32Ret = AMPWriteReg(0x07, u8Gain, 1);
    }
    else
    {
        u8Gain[0] = TAS5707_MAX_VOL;
        s32Ret = AMPWriteReg(0x07, u8Gain, 1);
    }
    return s32Ret;
}

static HI_S32 AMP_GetMute(HI_BOOL* pbMute)
{
    HI_S32 s32Ret;
    HI_U8  u8Gain = 0;
    
    if (pstTas5707Drv == HI_NULL)
    {
        HI_ERR_AMP("TAS5707 is not initialized yet! \n");
        return HI_FAILURE;
    }

    s32Ret = AMPReadReg(0x07, &u8Gain, 1);
    if (u8Gain == TAS5707_MIN_VOL)
    {
        *pbMute = HI_TRUE;
    }
    else
    {
        *pbMute = HI_FALSE;
    }
    return s32Ret; 
}

static HI_S32 AMP_SetDrcEn(HI_BOOL bEn)
{
    HI_S32 s32Ret;
    HI_U8 u8DRCVal[4] = {0x0, 0x0, 0x0, 0x0};

    s32Ret = AMPReadReg(0x46, u8DRCVal, 4);
    if (s32Ret != HI_SUCCESS)
    {
       HI_ERR_AMP("i2c read failed!\n");
    }

    if (HI_TRUE == bEn)
    {
        u8DRCVal[3] |= 0x01;
    }
    else
    {
        u8DRCVal[3] &= ~0x01;
    }

    s32Ret = AMPWriteReg(0x46, u8DRCVal, 4);
    if (s32Ret != HI_SUCCESS)
    {
       HI_ERR_AMP("i2c write failed!\n");
    }

    return HI_SUCCESS;

}

static HI_S32 AMP_GetDrcEn(HI_BOOL* pbEn)
{
    HI_S32 s32Ret;
    HI_U8 u8DRCVal[4] = {0x0, 0x0, 0x0, 0x0};

    s32Ret = AMPReadReg(0x46, u8DRCVal, 4);
    if (s32Ret != HI_SUCCESS)
    {
       HI_ERR_AMP("i2c read failed!\n");
    }

    if (0x01 == (u8DRCVal[3] & 0x01))
    {
        *pbEn = HI_TRUE;
    }
    else
    {
        *pbEn = HI_FALSE;
    }

    return HI_SUCCESS;
}

static HI_S32 AMP_SetPeqEn(HI_BOOL bEn)
{
    HI_S32 s32Ret;
    HI_U8 u8DRCVal[4] = {0x0, 0x0, 0x0, 0x0};

    s32Ret = AMPReadReg(0x50, u8DRCVal, 4);
    if (s32Ret != HI_SUCCESS)
    {
       HI_ERR_AMP("i2c read failed!\n");
    }

    if (HI_TRUE == bEn)
    {
        u8DRCVal[3] &= ~0x80;
    }
    else
    {
        u8DRCVal[3] |= 0x80;
    }

    s32Ret = AMPWriteReg(0x50, u8DRCVal, 4);
    if (s32Ret != HI_SUCCESS)
    {
       HI_ERR_AMP("i2c write failed!\n");
    }

    return HI_SUCCESS;

}

static HI_S32 AMP_GetPeqEn(HI_BOOL* pbEn)
{
    HI_S32 s32Ret;
    HI_U8 u8DRCVal[4] = {0x0, 0x0, 0x0, 0x0};

    s32Ret = AMPReadReg(0x50, u8DRCVal, 4);
    if (s32Ret != HI_SUCCESS)
    {
       HI_ERR_AMP("i2c read failed!\n");
    }

    if (0x80 == (u8DRCVal[3] & 0x80))
    {
        *pbEn = HI_FALSE;
    }
    else
    {
        *pbEn = HI_TRUE;
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

    if (pstTas5707Drv == HI_NULL)
    {
        HI_ERR_AMP("TAS5707 is not initialized yet! \n");
        return HI_FAILURE;
    }

    if (u32ByteSize > MAX_AMP_REG_LEN)
    {
        HI_ERR_AMP("TAS5707 reg length MAX is 20\n");
        u32ByteSize = MAX_AMP_REG_LEN;
    }

    Ret = copy_from_user(RegArray, pu8Value, u32ByteSize);
    if(Ret != HI_SUCCESS)
    {
        HI_ERR_AMP("TAS5707 copy_from_user Fail \n");
    }

    Ret = AMPWriteReg(u32RegAddr, RegArray, u32ByteSize);
    if(Ret != HI_SUCCESS)
    {
        HI_ERR_AMP("TAS5707 write I2C Fail \n");
    }

    return HI_SUCCESS;
}

static HI_S32 AMP_ReadReg(HI_U32 u32RegAddr, HI_U32 u32ByteSize, HI_U8* pu8Value)
{
    HI_S32 Ret;
    HI_U8  RegArray[MAX_AMP_REG_LEN];

    if (pstTas5707Drv == HI_NULL)
    {
        HI_ERR_AMP("TAS5707 is not initialized yet! \n");
        return HI_FAILURE;
    }

    if (u32ByteSize > MAX_AMP_REG_LEN)
    {
        HI_ERR_AMP("TAS5707 reg length MAX is 20\n");
        u32ByteSize = MAX_AMP_REG_LEN;
    }

    Ret = AMPReadReg(u32RegAddr, RegArray, u32ByteSize);
    if(Ret != HI_SUCCESS)
    {
        HI_ERR_AMP("TAS5707 Read I2C Fail \n");
    }

    Ret = copy_to_user(pu8Value, RegArray, u32ByteSize);
    if(Ret != HI_SUCCESS)
    {
        HI_ERR_AMP("TAS5707 copy_to_user Fail \n");
    }

    return HI_SUCCESS;
}

static HI_S32 AMP_ReadProc(struct seq_file *p, HI_VOID *pData)
{
    HI_S32            s32Ret;
    HI_BOOL           bMuteEn = HI_FALSE, bDrcEn = HI_FALSE, bPeqEn = HI_FALSE;
    HI_U8             u8Index, u8Addr, u8Length, u8CountLoop;
    HI_U8             u8Array[MAX_AMP_REG_LEN];
    TAS5707_REGMAP    *pstTas5707InitTbl;

    if (pstTas5707Drv == HI_NULL)
    {
        HI_ERR_AMP("TAS5707 is not initialized yet! \n");
        return HI_FAILURE;
    }
	
    PROC_PRINT(p,"\n====================================================AMP PROC====================================================\n");
    PROC_PRINT(p, "AMP Modul:        TI TAS5707\n");
    PROC_PRINT(p, "I2C Num:          %d\n" ,  pstTas5707Drv->u32I2CNum);
    PROC_PRINT(p, "I2C Addr:         0x%x\n", pstTas5707Drv->u8DeviceAddr);
    PROC_PRINT(p, "Mute  GPIO Group: %d\n", pstTas5707Drv->u32HWMuteGPIONum/8);
    PROC_PRINT(p, "Mute  GPIO Bit:   %d\n",    pstTas5707Drv->u32HWMuteGPIONum%8);
    PROC_PRINT(p, "Mute  Polarity:   %d\n",    pstTas5707Drv->u32HWMutePolarity);

    PROC_PRINT(p, "Reset GPIO Group: %d\n", pstTas5707Drv->u32ResetGPIONum/8);
    PROC_PRINT(p, "Reset GPIO Bit:   %d\n", pstTas5707Drv->u32ResetGPIONum%8);
    PROC_PRINT(p, "Reset Polarity:   %d\n", pstTas5707Drv->u32ResetPolarity);

    pstTas5707InitTbl     = Tas5707_DefautTbl;

    PROC_PRINT(p,"-------------------------------------------------TAS5707 REGMAP-------------------------------------------------");
    for(u8Index = 0; ; u8Index ++)
    {
        u8Addr = pstTas5707InitTbl[u8Index].bAddr;
        if(u8Addr == ENDTBL_FLAG)
        {
            break;
        }
        u8Length = pstTas5707InitTbl[u8Index].bLength;
        PROC_PRINT(p, "\nAddr[0x%x] Len[%d]: ",u8Addr,u8Length);
        memset(u8Array,0,MAX_AMP_REG_LEN);
        s32Ret = AMPReadReg(u8Addr, u8Array, u8Length);
		if (s32Ret != HI_SUCCESS)
		{
			HI_ERR_AMP("i2c read failed!\n");
		}

        for(u8CountLoop = 0; u8CountLoop < u8Length; u8CountLoop ++)
        {
            PROC_PRINT(p, "0x%x ", u8Array[u8CountLoop]);
        }
    }

    PROC_PRINT(p,"\n-------------------------------------------------TAS5707 STATUS-------------------------------------------------\n");

    s32Ret = AMP_GetMute(&bMuteEn);
    if (s32Ret != HI_SUCCESS)
    {
        HI_ERR_AMP("AMP GetMute failed!\n");
    }

    PROC_PRINT(p, "MUTE: %s\n", (bMuteEn) ? "ON" : "OFF");

    s32Ret = AMP_GetDrcEn(&bDrcEn);
    if (s32Ret != HI_SUCCESS)
    {
        HI_ERR_AMP("AMP GetDrcEn failed!\n");
    }

    PROC_PRINT(p, "DRC: %s\n", (bDrcEn) ? "ON" : "OFF");

    s32Ret = AMP_GetPeqEn(&bPeqEn);
    if (s32Ret != HI_SUCCESS)
    {
        HI_ERR_AMP("AMP GetPeqEn failed!\n");
    }

    PROC_PRINT(p, "PEQ: %s\n", (bPeqEn) ? "ON" : "OFF");
	
    PROC_PRINT(p,"================================================================================================================\n");

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

    if (pstTas5707Drv == HI_NULL)
    {
        HI_ERR_AMP("TAS5707 is not initialized yet! \n");
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
        HI_BOOL bGetEn;
        HI_BOOL bSetEn;

        s32Ret = AMP_GetMute(&bGetEn);
        if (HI_SUCCESS != s32Ret)
        {
            goto CMD_FAULT;
        }

        if ((strstr(pcBuf, "on")) || (strstr(pcBuf, "1")))
        {
            bSetEn = HI_TRUE;
        }
        else if((strstr(pcBuf, "off")) || (strstr(pcBuf, "0")))
        {
		    bSetEn = HI_FALSE;
        }
        else
        {
            goto CMD_FAULT;
        }

		s32Ret = AMP_SetMute(bSetEn);
		if (HI_SUCCESS != s32Ret)
		{
			goto CMD_FAULT;
		}
		
		HI_DRV_PROC_EchoHelper("Set amp mute %s success:%d(%s) -> %d(%s)\n", (bSetEn ? "ON" : "OFF"), (HI_U32)bGetEn, 
			(bGetEn ? "ON" : "OFF"), (HI_U32)bSetEn, (bSetEn ? "ON" : "OFF"));
    }

    if(AMP_CMD_PROC_SET_DRC == enProcCmd)
    {
        HI_BOOL bGetEn;
        HI_BOOL bSetEn;

        s32Ret = AMP_GetDrcEn(&bGetEn);
        if (HI_SUCCESS != s32Ret)
        {
            goto CMD_FAULT;
        }

        if ((strstr(pcBuf, "on")) || (strstr(pcBuf, "1")))
        {
            bSetEn = HI_TRUE;
        }
        else if((strstr(pcBuf, "off")) || (strstr(pcBuf, "0")))
        {
            bSetEn = HI_FALSE;
        }
        else
        {
            goto CMD_FAULT;
        }

        s32Ret = AMP_SetDrcEn(bSetEn);
        if (HI_SUCCESS != s32Ret)
        {
            goto CMD_FAULT;
        }
		
		HI_DRV_PROC_EchoHelper("Set amp drc %s success:%d(%s) -> %d(%s)\n", (bSetEn ? "ON" : "OFF"), (HI_U32)bGetEn, 
			(bGetEn ? "ON" : "OFF"), (HI_U32)bSetEn, (bSetEn ? "ON" : "OFF"));

    }

    if(AMP_CMD_PROC_SET_PEQ == enProcCmd)
    {
        HI_BOOL bGetEn;
        HI_BOOL bSetEn;

        s32Ret = AMP_GetPeqEn(&bGetEn);
        if (HI_SUCCESS != s32Ret)
        {
            goto CMD_FAULT;
        }

        if ((strstr(pcBuf, "on")) || (strstr(pcBuf, "1")))
        {
            bSetEn = HI_TRUE;
        }
        else if((strstr(pcBuf, "off")) || (strstr(pcBuf, "0")))
        {
            bSetEn = HI_FALSE;
        }
        else
        {
            goto CMD_FAULT;
        }

        s32Ret = AMP_SetPeqEn(bSetEn);
        if (HI_SUCCESS != s32Ret)
        {
            goto CMD_FAULT;
        }

		HI_DRV_PROC_EchoHelper("Set amp peq %s success:%d(%s) -> %d(%s)\n", (bSetEn ? "ON" : "OFF"), (HI_U32)bGetEn, 
			(bGetEn ? "ON" : "OFF"), (HI_U32)bSetEn, (bSetEn ? "ON" : "OFF"));

    }

    return count;

CMD_FAULT:
    HI_ERR_AMP("proc cmd is fault\n");
    AMP_PROC_SHOW_HELP();

    return HI_FAILURE;
}

AMP_DRV_FUNC_S stTas5707Func =
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
