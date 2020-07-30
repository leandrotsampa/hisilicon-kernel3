/********************************************************************************/
/* 
 *              Copyright 2004 - 2050, Hisilicon Tech. Co., Ltd.
 *
 *                           ALL RIGHTS RESERVED
 *
 * file-name     : amp_i2s_rt9107b.c
 * version       : 1.0 
 * author        : wujunxin w00281826
 * email         : wujunxin@hisilicon.com
 * description   : Driver of RT9107b 
 * last-modified : Thu 13 Nov 2014 06:32:50 PM HKT
 */
/********************************************************************************/

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
#define RT9107B_MAX_VOL (0x05)
#define RT9107B_MIN_VOL (0xff) //Mute
#define RT9107B_INIT_INTERVAL (65) //Delay 65ms

static AMP_GLOBAL_PARAM_S* pstRt9107bDrv = HI_NULL;

typedef struct
{
    HI_U8 bAddr;
    HI_U8 bLength;
    HI_U8 bArray[MAX_AMP_REG_LEN];
}RT9107B_REGMAP;

static RT9107B_REGMAP Rt9107b_DefautTbl[] = 
{
    {0x1B,0x01,{0x00}},                    //0:factory trim
    {0x06,0x01,{0x00}},                    //0:soft mute
    {0x20,0x04,{0x00,0x89,0x77,0x72}},    //0x98->0x89 to invert L/R output, BD Mode
    {0x11,0x01,{0xB8}},                    //0xB8:BD Mode
    {0x12,0x01,{0x60}},                    //0x60:BD Mode
    {0x13,0x01,{0xB8}},                    //0xA0:BD Mode
    {0x14,0x01,{0x60}},                    //0x48:BD Mode
    {0x50,0x04,{0x00,0x00,0x00,0x00}},    //Band switch and EQ Control

    /* EQ */
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
    {0x40,0x04,{0xFD,0x82,0x30,0x98}},
    {0x41,0x04,{0x0F,0x81,0x47,0xAF}},
    {0x42,0x04,{0x00,0x08,0x42,0x10}},    
    
    {0x46,0x04,{0x00,0x00,0x00,0x03}},    //DRC Control    
    {0x07,0x01,{0x05}},                    //default umute,mute:0xff,umute:0x5
    {0x05,0x01,{0x00}},                    //0: start play, 1:power down and hard mute
    
    {ENDTBL_FLAG ,0x01,{0x00}},
};

#ifdef AMP_SUBWOOFER_SUPPORTED
static RT9107B_REGMAP Rt9107b_SubwooferDefautTbl[] = 
{
    {0x1B,0x01,{0x00}},                    //0:factory trim
    {0x06,0x01,{0x00}},                    //0:soft mute
    {0x20,0x04,{0x00,0x89,0x77,0x72}},    //0x98->0x89 to invert L/R output, BD Mode
    {0x11,0x01,{0xB8}},                    //0xB8:BD Mode
    {0x12,0x01,{0x60}},                    //0x60:BD Mode
    {0x13,0x01,{0xB8}},                    //0xA0:BD Mode
    {0x14,0x01,{0x60}},                    //0x48:BD Mode
    {0x50,0x04,{0x00,0x00,0x00,0x00}},    //Band switch and EQ Control

    /* EQ */
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
    {0x40,0x04,{0xFD,0x82,0x30,0x98}},
    {0x41,0x04,{0x0F,0x81,0x47,0xAF}},
    {0x42,0x04,{0x00,0x08,0x42,0x10}},    
    
    {0x25,0x04,{0x01, 0x00, 0x22, 0x45}}, //subwoofer output, PBTL mode
    {0x51,0x0c,{0x00, 0x40, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}},

    {0x46,0x04,{0x00,0x00,0x00,0x03}},    //DRC Control    
    {0x07,0x01,{0x05}},                    //default umute,mute:0xff,umute:0x5
    {0x05,0x01,{0x00}},                    //0: start play, 1:power down and hard mute
    
    {ENDTBL_FLAG ,0x01,{0x00}},
};
#endif // End #ifdef AMP_SUBWOOFER_SUPPORTED

static HI_S32 AMP_SetMute(HI_BOOL bMute);

static HI_S32 AMPWriteReg(HI_U8 u1Addr, HI_U8 *pu1Buf, HI_U16 u2ByteCnt)
{
    HI_S32 s32Ret = 0;

    if (pstRt9107bDrv->pI2CFunc  == HI_NULL)
    {
        HI_ERR_AMP("I2C Function Null \n");
        return HI_FAILURE;
    }
    
    s32Ret = pstRt9107bDrv->pI2CFunc->pfnI2cWrite(pstRt9107bDrv->u32I2CNum,
             pstRt9107bDrv->u8DeviceAddr, u1Addr, 1, pu1Buf, u2ByteCnt);
    if (s32Ret != HI_SUCCESS)
    {
        HI_ERR_AMP("Rt9107B i2c write error :I2cNum:0x%x, I2cDevAddr:0x%x, "
                   "u1Addr:0x%x, addlen:0x%x, pu1Buf:0x%x, u2ByteCnt:0x%x\n",
                   pstRt9107bDrv->u32I2CNum, pstRt9107bDrv->u8DeviceAddr,
                   u1Addr, 1, pu1Buf[0], u2ByteCnt);
    }

    return s32Ret;
}

static HI_S32 AMPReadReg(HI_U8 u1Addr, HI_U8 *pu1Buf, HI_U16 u2ByteCnt)
{
    HI_S32 s32Ret = 0;

    if (pstRt9107bDrv->pI2CFunc == HI_NULL)
    {
        HI_ERR_AMP("I2C Function Null \n");
        return HI_FAILURE;
    }

    s32Ret = pstRt9107bDrv->pI2CFunc->pfnI2cRead(pstRt9107bDrv->u32I2CNum,
             pstRt9107bDrv->u8DeviceAddr, u1Addr, 1, pu1Buf, u2ByteCnt);
    if (s32Ret != HI_SUCCESS)
    {
        HI_ERR_AMP("Rt9107b read fail :%d!\n", s32Ret );
    }
    return s32Ret;
}

static HI_VOID AMPReset(HI_BOOL bReset)
{
    if (pstRt9107bDrv == HI_NULL)
    {
        HI_ERR_AMP("RT9107B no Init! \n");
        return;
    }

    if (pstRt9107bDrv->pGpioFunc== HI_NULL)
    {
        HI_ERR_AMP("GPIO Function Null \n");
        return;
    }    
    
    if (pstRt9107bDrv->pGpioFunc->pfnGpioDirSetBit)
    {
        pstRt9107bDrv->pGpioFunc->pfnGpioDirSetBit(pstRt9107bDrv->u32ResetGPIONum,
                pstRt9107bDrv->u32GPIOOutputPolarity); //Output Mode
    }
    
    msleep(1);
    
    if (pstRt9107bDrv->pGpioFunc->pfnGpioWriteBit)
    { 
        if (bReset)
        {            
            pstRt9107bDrv->pGpioFunc->pfnGpioWriteBit(pstRt9107bDrv->u32ResetGPIONum, 
                                                       pstRt9107bDrv->u32ResetPolarity);
        }
        else
        {
            pstRt9107bDrv->pGpioFunc->pfnGpioWriteBit(pstRt9107bDrv->u32ResetGPIONum, 
                                                       !(pstRt9107bDrv->u32ResetPolarity));
        }
    }        
    
    msleep(RT9107B_INIT_INTERVAL);

    return;
}

static HI_VOID AMPHWMute(HI_BOOL bMute)
{
    if (pstRt9107bDrv == HI_NULL)
    {
        HI_ERR_AMP("RT9107B no Init! \n");
        return;
    }

    if (pstRt9107bDrv->pGpioFunc== HI_NULL)
    {
        HI_ERR_AMP("GPIO Function Null \n");
        return;
    }    
    if (pstRt9107bDrv->pGpioFunc->pfnGpioDirSetBit)
    {
        pstRt9107bDrv->pGpioFunc->pfnGpioDirSetBit(pstRt9107bDrv->u32HWMuteGPIONum, 
                                      pstRt9107bDrv->u32GPIOOutputPolarity); //Output Mode
    }
    
    msleep(1);
    
    if (pstRt9107bDrv->pGpioFunc->pfnGpioWriteBit)
    { 
        if (bMute)
        {            
            pstRt9107bDrv->pGpioFunc->pfnGpioWriteBit(pstRt9107bDrv->u32HWMuteGPIONum, 
                                                       pstRt9107bDrv->u32HWMutePolarity);
        }
        else
        {
            pstRt9107bDrv->pGpioFunc->pfnGpioWriteBit(pstRt9107bDrv->u32HWMuteGPIONum, 
                                                       !(pstRt9107bDrv->u32HWMutePolarity));
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
    RT9107B_REGMAP     *pstRt9107bInitTbl;
#endif

    //Set RT9107B Software ops and Hardware setting
    if (pstAmpDrv == HI_NULL)
    {
        HI_ERR_AMP("Cannot get Any Setting for RT9107B! \n");
        return HI_FAILURE;
    }
    else
    {
        pstRt9107bDrv   = pstAmpDrv;
    }
    
#ifndef HI_AMP_LINUX_CFG
    AMP_SetMute(HI_TRUE);
#endif

#ifndef HI_BOOT_MUSIC_SUPPORT
    pstRt9107bInitTbl     = Rt9107b_DefautTbl;

    AMPHWMute(HI_FALSE);
    msleep(10);

    //Reset AMP
    AMPReset(HI_TRUE);        
    msleep(10);
    //Release Reset AMP
    AMPReset(HI_FALSE);        

    for(u8Index = 0; ; u8Index++)
    {
        u8Addr = pstRt9107bInitTbl[u8Index].bAddr;
        if(u8Addr == ENDTBL_FLAG)
        {
            break;
        }

        u8Length = pstRt9107bInitTbl[u8Index].bLength;
        for(u8CountLoop = 0; u8CountLoop < u8Length; u8CountLoop ++)
        {        
            u8Array[u8CountLoop] = *(pstRt9107bInitTbl[u8Index].bArray + u8CountLoop);
        }
        
        s32Ret = AMPWriteReg(u8Addr, u8Array, u8Length);
        if(s32Ret != HI_SUCCESS)
        {
            HI_ERR_AMP("RT9107B Init Fail \n");
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
        for(u8CountLoop = 0; u8CountLoop < u8Length;    u8CountLoop ++)
        {
            printk("0x%x,",    readArray[u8CountLoop]);
        }    
        printk("\n");
#endif
    }

#ifdef AMP_SUBWOOFER_SUPPORTED
    pstRt9107bDrv->u8DeviceAddr = 0x34; //A_SEL pin is pull down

    for(u8Index = 0; ; u8Index++)
    {
        u8Addr = Rt9107b_SubwooferDefautTbl[u8Index].bAddr;
        if(u8Addr == ENDTBL_FLAG)
        {
            break;
        }

        u8Length = Rt9107b_SubwooferDefautTbl[u8Index].bLength;
        for(u8CountLoop = 0; u8CountLoop < u8Length; u8CountLoop ++)
        {        
            u8Array[u8CountLoop] = *(Rt9107b_SubwooferDefautTbl[u8Index].bArray + u8CountLoop);
        }
        
        s32Ret = AMPWriteReg(u8Addr, u8Array, u8Length);
        if(s32Ret != HI_SUCCESS)
        {
            HI_ERR_AMP("RT9107B Init Fail \n");
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
        for(u8CountLoop = 0; u8CountLoop < u8Length; u8CountLoop ++)
        {
            printk("0x%x,",    readArray[u8CountLoop]);
        }    
        printk("\n");
#endif
    }

    pstRt9107bDrv->u8DeviceAddr = 0x36; //A_SEL pin is pull up
#endif //end #ifdef AMP_SUBWOOFER_SUPPORTED
#endif //end #ifndef HI_BOOT_MUSIC_SUPPORT

    return HI_SUCCESS; 
}

static HI_S32 AMP_Resume(AMP_GLOBAL_PARAM_S* pstAmpDrv)
{
    HI_S32             s32Ret = 0;
    HI_U8             u8Index, u8Addr, u8Length, u8CountLoop;
    HI_U8             u8Array[MAX_AMP_REG_LEN];
    RT9107B_REGMAP     *pstRt9107bInitTbl;

    //Set RT9107B Software ops and Hardware setting
    if (pstAmpDrv == HI_NULL)
    {
        HI_ERR_AMP("Cannot get Any Setting for RT9107B! \n");
        return HI_FAILURE;
    }
    else
    {
        pstRt9107bDrv   = pstAmpDrv;
    }
    
    pstRt9107bInitTbl     = Rt9107b_DefautTbl;

    AMPHWMute(HI_FALSE);
    msleep(10);

    //Reset AMP
    AMPReset(HI_TRUE);        
    msleep(10);
    //Release Reset AMP
    AMPReset(HI_FALSE);        

    for(u8Index = 0; ; u8Index++)
    {
        u8Addr = pstRt9107bInitTbl[u8Index].bAddr;
        if(u8Addr == ENDTBL_FLAG)
        {
            break;
        }

        u8Length = pstRt9107bInitTbl[u8Index].bLength;
        for(u8CountLoop = 0; u8CountLoop < u8Length; u8CountLoop ++)
        {        
            u8Array[u8CountLoop] = *(pstRt9107bInitTbl[u8Index].bArray + u8CountLoop);
        }
        
        s32Ret = AMPWriteReg(u8Addr, u8Array, u8Length);
        if(s32Ret != HI_SUCCESS)
        {
            HI_ERR_AMP("RT9107B Init Fail \n");
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
        for(u8CountLoop = 0; u8CountLoop < u8Length;    u8CountLoop ++)
        {
            printk("0x%x,",    readArray[u8CountLoop]);
        }    
        printk("\n");
#endif
    }

#ifdef AMP_SUBWOOFER_SUPPORTED
    pstRt9107bDrv->u8DeviceAddr = 0x34; //A_SEL pin is pull down

    for(u8Index = 0; ; u8Index++)
    {
        u8Addr = Rt9107b_SubwooferDefautTbl[u8Index].bAddr;
        if(u8Addr == ENDTBL_FLAG)
        {
            break;
        }

        u8Length = Rt9107b_SubwooferDefautTbl[u8Index].bLength;
        for(u8CountLoop = 0; u8CountLoop < u8Length; u8CountLoop ++)
        {        
            u8Array[u8CountLoop] = *(Rt9107b_SubwooferDefautTbl[u8Index].bArray + u8CountLoop);
        }
        
        s32Ret = AMPWriteReg(u8Addr, u8Array, u8Length);
        if(s32Ret != HI_SUCCESS)
        {
            HI_ERR_AMP("RT9107B Init Fail \n");
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
        for(u8CountLoop = 0; u8CountLoop < u8Length; u8CountLoop ++)
        {
            printk("0x%x,",    readArray[u8CountLoop]);
        }    
        printk("\n");
#endif
    }

    pstRt9107bDrv->u8DeviceAddr = 0x36; //A_SEL pin is pull up
#endif //end #ifdef AMP_SUBWOOFER_SUPPORTED

    return HI_SUCCESS; 
}
static HI_VOID AMP_DeInit(HI_VOID)
{
    if (pstRt9107bDrv == HI_NULL)
    {
        HI_ERR_AMP("pstNTP8212Drv is not initialized yet! \n");
        return;
    }

    //Reset AMP
    AMPReset(HI_TRUE);    

    pstRt9107bDrv = HI_NULL;
    
    return;
}

static HI_S32 AMP_SetMute(HI_BOOL bMute)
{
    HI_S32 s32Ret;
    HI_U8  u8Gain[1]= {0};

    if (pstRt9107bDrv == HI_NULL)
    {
        HI_ERR_AMP("pstNTP8212Drv is not initialized yet! \n");
        return HI_FAILURE;
    }

    if (bMute)
    {
        u8Gain[0] = RT9107B_MIN_VOL;
        s32Ret = AMPWriteReg(0x07, u8Gain, 1);
    }
    else
    {
        u8Gain[0] = RT9107B_MAX_VOL;
        s32Ret = AMPWriteReg(0x07, u8Gain, 1);
    }

    return s32Ret;
}

static HI_S32 AMP_GetMute(HI_BOOL* pbMute)
{
    HI_S32 s32Ret;
    HI_U8  u8Gain = 0;
    
    if (pstRt9107bDrv == HI_NULL)
    {
        HI_ERR_AMP("pstNTP8212Drv is not initialized yet! \n");
        return HI_FAILURE;
    }

    s32Ret = AMPReadReg(0x07, &u8Gain, 1);
    if (u8Gain == RT9107B_MIN_VOL)
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

    if (pstRt9107bDrv == HI_NULL)
    {
        HI_ERR_AMP("pstNTP8212Drv is not initialized yet! \n");
        return HI_FAILURE;
    }

    if (u32ByteSize > MAX_AMP_REG_LEN)
    {
        HI_ERR_AMP("RT9107B reg length MAX is 20\n");
        u32ByteSize = MAX_AMP_REG_LEN;
    }

    Ret = copy_from_user(RegArray, pu8Value, u32ByteSize);
    if(Ret != HI_SUCCESS)
    {
        HI_ERR_AMP("RT9107B copy_from_user Fail \n");
    }

    Ret = AMPWriteReg(u32RegAddr, RegArray, u32ByteSize);
    if(Ret != HI_SUCCESS)
    {
        HI_ERR_AMP("RT9107B write I2C Fail \n");
    }
    
    return HI_SUCCESS; 
}

static HI_S32 AMP_ReadReg(HI_U32 u32RegAddr, HI_U32 u32ByteSize, HI_U8* pu8Value)
{
    HI_S32 Ret;
    HI_U8  RegArray[MAX_AMP_REG_LEN];

    if (pstRt9107bDrv == HI_NULL)
    {
        HI_ERR_AMP("pstNTP8212Drv is not initialized yet! \n");
        return HI_FAILURE;
    }

    if (u32ByteSize > MAX_AMP_REG_LEN)
    {
        HI_ERR_AMP("RT9107B reg length MAX is 20\n");
        u32ByteSize = MAX_AMP_REG_LEN;
    }
    
    Ret = AMPReadReg(u32RegAddr, RegArray, u32ByteSize);
    if(Ret != HI_SUCCESS)
    {
        HI_ERR_AMP("RT9107B Read I2C Fail \n");
    }

    Ret = copy_to_user(pu8Value, RegArray, u32ByteSize);
    if(Ret != HI_SUCCESS)
    {
        HI_ERR_AMP("RT9107B copy_to_user Fail \n");
    }

    return HI_SUCCESS; 
}

static HI_S32 AMP_Proc(struct seq_file *p, HI_VOID *pData)
{
    HI_U8             u8Index, u8Addr, u8Length, u8CountLoop;
    HI_U8             u8Array[MAX_AMP_REG_LEN];
    RT9107B_REGMAP     *pstRt9107bInitTbl;

    if (pstRt9107bDrv == HI_NULL)
    {
        HI_ERR_AMP("pstNTP8212Drv is not initialized yet! \n");
        return HI_FAILURE;
    }

    PROC_PRINT(p, "AMP Modul:        TI RT9107B\n");
    PROC_PRINT(p, "I2C Num:          %d\n" ,  pstRt9107bDrv->u32I2CNum);
    PROC_PRINT(p, "I2C Addr:         0x%x\n", pstRt9107bDrv->u8DeviceAddr);    
    PROC_PRINT(p, "Mute  GPIO Group: %d\n", pstRt9107bDrv->u32HWMuteGPIONum/8);
    PROC_PRINT(p, "Mute  GPIO Bit:   %d\n",    pstRt9107bDrv->u32HWMuteGPIONum%8);
    PROC_PRINT(p, "Mute  Polarity:   %d\n",    pstRt9107bDrv->u32HWMutePolarity);                                                                    
    
    PROC_PRINT(p, "Reset GPIO Group: %d\n", pstRt9107bDrv->u32ResetGPIONum/8);
    PROC_PRINT(p, "Reset GPIO Bit:   %d\n", pstRt9107bDrv->u32ResetGPIONum%8);
    PROC_PRINT(p, "Reset Polarity:   %d\n", pstRt9107bDrv->u32ResetPolarity);

    pstRt9107bInitTbl     = Rt9107b_DefautTbl;

    PROC_PRINT(p,"\n--------------------- RT9107B REGMAP -------------------------------------------------");
    for(u8Index = 0; ; u8Index ++)
    {
        u8Addr = pstRt9107bInitTbl[u8Index].bAddr;
        if(u8Addr == ENDTBL_FLAG)
        {
            break;
        }
        u8Length = pstRt9107bInitTbl[u8Index].bLength;
        PROC_PRINT(p, "\nAddr[0x%x] Len[%d]: ",u8Addr,u8Length);
        memset(u8Array,0,MAX_AMP_REG_LEN);    
        AMPReadReg(u8Addr, u8Array, u8Length);
        
        for(u8CountLoop = 0; u8CountLoop < u8Length; u8CountLoop ++)
        {
            PROC_PRINT(p, "0x%x ", u8Array[u8CountLoop]);
        }    
    }
    PROC_PRINT(p,"\n--------------------- END RT9107B REGMAP -------------------------------------------------\n");
    
#ifdef AMP_SUBWOOFER_SUPPORTED
    pstRt9107bDrv->u8DeviceAddr = 0x34; //A_SEL pin is pull down 

    PROC_PRINT(p,"\n--------------------- SubWoofer REGMAP -------------------------------------------------");
    for(u8Index = 0; ; u8Index++)
    {
        u8Addr = Rt9107b_SubwooferDefautTbl[u8Index].bAddr;
        if(u8Addr == ENDTBL_FLAG)
        {
            break;
        }
        u8Length = Rt9107b_SubwooferDefautTbl[u8Index].bLength;
        PROC_PRINT(p, "\nAddr[0x%x] Len[%d]: ",u8Addr,u8Length);
        memset(u8Array,0,MAX_AMP_REG_LEN);    
        AMPReadReg(u8Addr, u8Array, u8Length);
        
        for(u8CountLoop = 0; u8CountLoop < u8Length; u8CountLoop ++)
        {
            PROC_PRINT(p, "0x%x ", u8Array[u8CountLoop]);
        }    
    }
    PROC_PRINT(p,"\n--------------------- END SubWoofer REGMAP -------------------------------------------------\n");

    pstRt9107bDrv->u8DeviceAddr = 0x36; //A_SEL pin is pull up
#endif //end #ifdef AMP_SUBWOOFER_SUPPORTED    

    return 0;
}

AMP_DRV_FUNC_S stRt9107bFunc =
{
    .bExtMClkFlag  = HI_FALSE,
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
