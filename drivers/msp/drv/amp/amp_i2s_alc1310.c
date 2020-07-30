/*********************************************************************

Copyright (C), 2001-2011, Hisilicon Tech. Co., Ltd.

**********************************************************************
File Name     :    amp_i2s_alc1310.h
Version         :    Initial    Draft
Author         :    l00191026
Created         :    2015/4/3
Last Modified:
Description   :    ALC1310 Driver
Function List :
History         :
* Version     Date       Author     DefectNum          Description
                2015/4/3     l00191026      NULL            Create this file.
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
#define ALC1310_MAX_VOL (0xff)
#define ALC1310_MIN_VOL (0x00) //Mute
#define AMP_MUTE_REGISTER 0x12 //volume register
#define ALC1310_INIT_INTERVAL (65) //Delay 65ms

static AMP_GLOBAL_PARAM_S* pstAlc1310Drv = HI_NULL;

typedef struct
{
    HI_U8 bAddr;
    HI_U8 bLength;
    HI_U8 bArray[MAX_AMP_REG_LEN];
}ALC1310_REGMAP;

static ALC1310_REGMAP Alc1310_DefautTbl[] = 
{
    //init
    {0x05,0x02,{0x40,0x3e}},                    //
    {0x02,0x02,{0x80,0x00}},                    //
    {0x09,0x02,{0x80,0x00}},                    //
    //DC
    {0x6a,0x02,{0x00,0xdc}},                    //
    {0x6c,0x02,{0x00,0x24}},                    //
    //D9
    {0x14,0x02,{0x00,0xd9}},                    //
    {0x50,0x02,{0xa4,0x10}},                    //

    //DRC
    {0x09,0x02,{0xC8,0x00}},//DRC Enable
    {0x0a,0x02,{0x06,0x06}},					//
    {0x0c,0x02,{0x04,0x02}},					//
    {0x0e,0x02,{0x00,0x00}},					//

    /* down layer register and value */
    {0x6a,0x02,{0x00,0x9d}},					//
    {0x6c,0x02,{0x46,0x00}},					//

    {0x6a,0x02,{0x00,0x9e}},					//
    {0x6c,0x02,{0x23,0x23}},					//

    //b0
    {0x6a,0x02,{0x00,0xb0}},                    
    {0x6c,0x02,{0x88,0x03}},                    //Silence detection:level is -80dB

    {0x13,0x02,{0x00,0x0c}},                    //unmute
    {0x13,0x02,{0x00,0x0c}},                    //unmute
#ifdef HI_AMP_LINUX_CFG
    {0x12,0x02,{0xff,0xff}},                    //L/R Volume
#else
    {0x12,0x02,{0x00,0x00}},                    //L/R Volume    
#endif


    //BQ1 BQ1Ty= 4 BQ1Fs=44100 BQ1Fc=100BQ1Ga=1 BQ1Fb=120
    {0x6a,0x02,{0x00,0x00}}, 
    {0x6c,0x02,{0x02,0x00}},
                            
    {0x6a,0x02,{0x00,0x01}},
    {0x6c,0x02,{0x87,0x8E}},
                            
    {0x6a,0x02,{0x00,0x02}},
    {0x6c,0x02,{0x1C,0x09}},

    {0x6a,0x02,{0x00,0x03}},
    {0x6c,0x02,{0xD4,0xC5}},
		                        
    {0x6a,0x02,{0x00,0x04}},
    {0x6c,0x02,{0x01,0xF6}},
                            
    {0x6a,0x02,{0x00,0x05}},
    {0x6c,0x02,{0x45,0x96}},
                            
    {0x6a,0x02,{0x00,0x06}},
    {0x6c,0x02,{0x03,0xF7}},
                            
    {0x6a,0x02,{0x00,0x07}},
    {0x6c,0x02,{0x37,0xBD}},
                            
    {0x6a,0x02,{0x00,0x08}},
    {0x6c,0x02,{0x1E,0x08}},
		                        
    {0x6a,0x02,{0x00,0x09}},
    {0x6c,0x02,{0xAD,0xE1}},


    //BQ2 BQ2Ty= 4 BQ2Fs=44100 BQ2Fc=6000 BQ2Ga=0.5 BQ2Fb=1500
    {0x6a,0x02,{0x00,0xa}}, 
    {0x6c,0x02,{0x02,0x02}},
                            
    {0x6a,0x02,{0x00,0x0b}},
    {0x6c,0x02,{0x9D,0x55}},
                            
    {0x6a,0x02,{0x00,0x0c}},
    {0x6c,0x02,{0x1D,0x9C}},
                            
    {0x6a,0x02,{0x00,0x0d}},
    {0x6c,0x02,{0xF6,0x0A}},
                            
    {0x6a,0x02,{0x00,0x0e}},
    {0x6c,0x02,{0x01,0xA2}},
                            
    {0x6a,0x02,{0x00,0x0f}},
    {0x6c,0x02,{0xFE,0xEA}},
                            
    {0x6a,0x02,{0x00,0x10}},
    {0x6c,0x02,{0x02,0x66}},
                            
    {0x6a,0x02,{0x00,0x11}},
    {0x6c,0x02,{0x28,0xC3}},
                            
    {0x6a,0x02,{0x00,0x12}},
    {0x6c,0x02,{0x1E,0x58}},
                            
    {0x6a,0x02,{0x00,0x13}},
    {0x6c,0x02,{0x40,0x03}},


    //BQ3 BQ3Ty= 4 BQ3Fs=44100 BQ3Fc=11000 BQ3Ga=1.5 BQ3Fb=14000
    {0x6a,0x02,{0x00,0x14}},
    {0x6c,0x02,{0x02,0x25}},
                            
    {0x6a,0x02,{0x00,0x15}},
    {0x6c,0x02,{0x88,0x62}},
                            
    {0x6a,0x02,{0x00,0x16}},
    {0x6c,0x02,{0x1F,0xFD}},
                            
    {0x6a,0x02,{0x00,0x17}},
    {0x6c,0x02,{0xEC,0x29}},
                            
    {0x6a,0x02,{0x00,0x18}},
    {0x6c,0x02,{0x00,0x47}},
                            
    {0x6a,0x02,{0x00,0x19}},
    {0x6c,0x02,{0x09,0xFB}},
                            
    {0x6a,0x02,{0x00,0x1a}},
    {0x6c,0x02,{0x00,0x02}},
                            
    {0x6a,0x02,{0x00,0x1b}},
    {0x6c,0x02,{0x3A,0xD3}},
                            
    {0x6a,0x02,{0x00,0x1c}},
    {0x6c,0x02,{0x1F,0x8E}},
                            
    {0x6a,0x02,{0x00,0x1d}},
    {0x6c,0x02,{0x38,0x7E}},

    {0x04,0x02,{0xc7,0x00}},


    {ENDTBL_FLAG ,0x01,{0x00}},
};

static HI_S32 AMP_SetMute(HI_BOOL bMute);

static HI_S32 AMPWriteReg(HI_U8 u1Addr, HI_U8 *pu1Buf, HI_U16 u2ByteCnt)
{
    HI_S32 s32Ret = 0;

    if (pstAlc1310Drv->pI2CFunc  == HI_NULL)
    {
        HI_ERR_AMP("ALC1301 I2C Function Null \n");
        return HI_FAILURE;
    }
    
    s32Ret = pstAlc1310Drv->pI2CFunc->pfnI2cWrite(pstAlc1310Drv->u32I2CNum,
             pstAlc1310Drv->u8DeviceAddr, u1Addr, 1, pu1Buf, u2ByteCnt);
    if (s32Ret != HI_SUCCESS)
    {
        
        HI_ERR_AMP("ALC1301 i2c write error :I2cNum:0x%x, I2cDevAddr:0x%x, "
                   "u1Addr:0x%x, addlen:0x%x, pu1Buf:0x%x, u2ByteCnt:0x%x\n",
                   pstAlc1310Drv->u32I2CNum, pstAlc1310Drv->u8DeviceAddr,
                   u1Addr, 1, pu1Buf[0], u2ByteCnt);
    }
    return s32Ret;
}

static HI_S32 AMPReadReg(HI_U8 u1Addr, HI_U8 *pu1Buf, HI_U16 u2ByteCnt)
{
    HI_S32 s32Ret = 0;

    if (pstAlc1310Drv->pI2CFunc == HI_NULL)
    {
        HI_ERR_AMP("ALC1301 I2C Function Null \n");
        return HI_FAILURE;
    }

    s32Ret = pstAlc1310Drv->pI2CFunc->pfnI2cRead(pstAlc1310Drv->u32I2CNum,
             pstAlc1310Drv->u8DeviceAddr, u1Addr, 1, pu1Buf, u2ByteCnt);
    if (s32Ret != HI_SUCCESS)
    {
        //HI_ERR_AMP("5707 read fail :%d!\n", s32Ret );
    }
    return s32Ret;
}

static HI_VOID AMPReset(HI_BOOL bReset)
{
    if (pstAlc1310Drv == HI_NULL)
    {
        HI_ERR_AMP("ALC1310 no Init! \n");
        return;
    }

    if (pstAlc1310Drv->pGpioFunc== HI_NULL)
    {
        HI_ERR_AMP("GPIO Function Null \n");
        return;
    }    
    
    if (pstAlc1310Drv->pGpioFunc->pfnGpioDirSetBit)
    {
        pstAlc1310Drv->pGpioFunc->pfnGpioDirSetBit(pstAlc1310Drv->u32ResetGPIONum,
                pstAlc1310Drv->u32GPIOOutputPolarity); //Output Mode
    }
    
    msleep(1);
    
    if (pstAlc1310Drv->pGpioFunc->pfnGpioWriteBit)
    { 
        if (bReset)
        {            
            pstAlc1310Drv->pGpioFunc->pfnGpioWriteBit(pstAlc1310Drv->u32ResetGPIONum, 
                                                       pstAlc1310Drv->u32ResetPolarity);
        }
        else
        {
            pstAlc1310Drv->pGpioFunc->pfnGpioWriteBit(pstAlc1310Drv->u32ResetGPIONum, 
                                                       !(pstAlc1310Drv->u32ResetPolarity));
        }
    }        
    
    msleep(ALC1310_INIT_INTERVAL);

    return;
}

#if 1
static HI_VOID AMPHWMute(HI_BOOL bMute)
{
    if (pstAlc1310Drv == HI_NULL)
    {
        HI_ERR_AMP("ALC1310 no Init! \n");
        return;
    }

    if (pstAlc1310Drv->pGpioFunc== HI_NULL)
    {
        HI_ERR_AMP("GPIO Function Null \n");
        return;
    }    
    if (pstAlc1310Drv->pGpioFunc->pfnGpioDirSetBit)
    {
        pstAlc1310Drv->pGpioFunc->pfnGpioDirSetBit(pstAlc1310Drv->u32HWMuteGPIONum, 
                                      pstAlc1310Drv->u32GPIOOutputPolarity); //Output Mode
    }
    
    msleep(1);
    
    if (pstAlc1310Drv->pGpioFunc->pfnGpioWriteBit)
    { 
        if (bMute)
        {            
            pstAlc1310Drv->pGpioFunc->pfnGpioWriteBit(pstAlc1310Drv->u32HWMuteGPIONum, 
                                                       pstAlc1310Drv->u32HWMutePolarity);
        }
        else
        {
            pstAlc1310Drv->pGpioFunc->pfnGpioWriteBit(pstAlc1310Drv->u32HWMuteGPIONum, 
                                                       !(pstAlc1310Drv->u32HWMutePolarity));
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
    ALC1310_REGMAP     *pstAlc1310InitTbl;
#endif

    //Set ALC1310 Software ops and Hardware setting
    if (pstAmpDrv == HI_NULL)
    {
        HI_ERR_AMP("Cannot get Any Setting for ALC1310! \n");
        return HI_FAILURE;
    }
    else
    {
        pstAlc1310Drv         = pstAmpDrv;
    }
    
#ifndef HI_AMP_LINUX_CFG
    AMP_SetMute(HI_TRUE);
#endif
	AMPHWMute(HI_TRUE);

#ifndef HI_BOOT_MUSIC_SUPPORT
    pstAlc1310InitTbl     = Alc1310_DefautTbl;

	msleep(10);
	AMPReset(HI_TRUE);		//gmh add 20140423
	msleep(10);
	//Release Reset AMP
	AMPReset(HI_FALSE);		

    for(u8Index = 0; ; u8Index ++)
    {
        u8Addr = pstAlc1310InitTbl[u8Index].bAddr;
        if(u8Addr == ENDTBL_FLAG)
        {
            break;
        }

        u8Length = pstAlc1310InitTbl[u8Index].bLength;
        for(u8CountLoop = 0; u8CountLoop < u8Length; u8CountLoop ++)
        {        
            u8Array[u8CountLoop] = *(pstAlc1310InitTbl[u8Index].bArray + u8CountLoop);
        }
        
        s32Ret = AMPWriteReg(u8Addr, u8Array, u8Length);
        if(s32Ret != HI_SUCCESS)
        {
        //    HI_ERR_AMP("ALC1310 Init Fail \n");
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
    ALC1310_REGMAP     *pstAlc1310InitTbl;

    //Set ALC1310 Software ops and Hardware setting
    if (pstAmpDrv == HI_NULL)
    {
        HI_ERR_AMP("Cannot get Any Setting for ALC1310! \n");
        return HI_FAILURE;
    }
    else
    {
        pstAlc1310Drv         = pstAmpDrv;
    }
    
    pstAlc1310InitTbl     = Alc1310_DefautTbl;

    AMPHWMute(HI_TRUE);
    msleep(10);
    AMPReset(HI_TRUE);        //gmh add 20140423
    msleep(10);
    //Release Reset AMP
    AMPReset(HI_FALSE);        

    for(u8Index = 0; ; u8Index ++)
    {
        u8Addr = pstAlc1310InitTbl[u8Index].bAddr;
        if(u8Addr == ENDTBL_FLAG)
        {
            break;
        }

        u8Length = pstAlc1310InitTbl[u8Index].bLength;
        for(u8CountLoop = 0; u8CountLoop < u8Length; u8CountLoop ++)
        {        
            u8Array[u8CountLoop] = *(pstAlc1310InitTbl[u8Index].bArray + u8CountLoop);
        }
        
        s32Ret = AMPWriteReg(u8Addr, u8Array, u8Length);
        if(s32Ret != HI_SUCCESS)
        {
        //    HI_ERR_AMP("ALC1310 Init Fail \n");
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
    if (pstAlc1310Drv == HI_NULL)
    {
        HI_ERR_AMP("Alc1310 is not initialized yet! \n");
        return;
    }

    //Reset AMP
    AMPReset(HI_TRUE);    

    pstAlc1310Drv = HI_NULL;
    
    return;
}

static HI_S32 AMP_SetMute(HI_BOOL bMute)
{
    HI_S32 s32Ret;
    HI_U8  u8Gain[2]= {0,0};

    if (pstAlc1310Drv == HI_NULL)
    {
        HI_ERR_AMP("Alc1310 is not initialized yet! \n");
        return HI_FAILURE;
    }

    if (bMute)
    {
        u8Gain[0] = ALC1310_MIN_VOL;
        u8Gain[1] = ALC1310_MIN_VOL;
        s32Ret = AMPWriteReg(AMP_MUTE_REGISTER, u8Gain, 2);
    }
    else
    {
        u8Gain[0] = ALC1310_MAX_VOL;
        u8Gain[1] = ALC1310_MAX_VOL;
        s32Ret = AMPWriteReg(AMP_MUTE_REGISTER, u8Gain, 2);
    }
    
    AMPHWMute(HI_FALSE);
    msleep(10);
    
    return s32Ret;
}

static HI_S32 AMP_GetMute(HI_BOOL* pbMute)
{
    HI_S32 s32Ret;
    HI_U8  u8Gain = 0;
    
    if (pstAlc1310Drv == HI_NULL)
    {
        HI_ERR_AMP("Alc1310 is not initialized yet! \n");
        return HI_FAILURE;
    }

    s32Ret = AMPReadReg(AMP_MUTE_REGISTER, &u8Gain, 1);
    if (u8Gain == ALC1310_MIN_VOL)
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

    if (pstAlc1310Drv == HI_NULL)
    {
        HI_ERR_AMP("Alc1310 is not initialized yet! \n");
        return HI_FAILURE;
    }

    if (u32ByteSize > MAX_AMP_REG_LEN)
    {
        HI_ERR_AMP("ALC1310 reg length MAX is 20\n");
        u32ByteSize = MAX_AMP_REG_LEN;
    }

    Ret = copy_from_user(RegArray, pu8Value, u32ByteSize);
    if(Ret != HI_SUCCESS)
    {
        HI_ERR_AMP("ALC1310 copy_from_user Fail \n");
    }

    Ret = AMPWriteReg(u32RegAddr, RegArray, u32ByteSize);
    if(Ret != HI_SUCCESS)
    {
        HI_ERR_AMP("ALC1310 write I2C Fail \n");
    }
    
    return HI_SUCCESS; 
}

static HI_S32 AMP_ReadReg(HI_U32 u32RegAddr, HI_U32 u32ByteSize, HI_U8* pu8Value)
{
    HI_S32 Ret;
    HI_U8  RegArray[MAX_AMP_REG_LEN];

    if (pstAlc1310Drv == HI_NULL)
    {
        HI_ERR_AMP("Alc1310 is not initialized yet! \n");
        return HI_FAILURE;
    }

    if (u32ByteSize > MAX_AMP_REG_LEN)
    {
        HI_ERR_AMP("ALC1310 reg length MAX is 20\n");
        u32ByteSize = MAX_AMP_REG_LEN;
    }
    
    Ret = AMPReadReg(u32RegAddr, RegArray, u32ByteSize);
    if(Ret != HI_SUCCESS)
    {
        HI_ERR_AMP("ALC1310 Read I2C Fail \n");
    }

    Ret = copy_to_user(pu8Value, RegArray, u32ByteSize);
    if(Ret != HI_SUCCESS)
    {
        HI_ERR_AMP("ALC1310 copy_to_user Fail \n");
    }

    return HI_SUCCESS; 
}

static HI_S32 AMP_Proc(struct seq_file *p, HI_VOID *pData)
{
    HI_U8             u8Index, u8Addr, u8Length, u8CountLoop;
    HI_U8             u8Array[MAX_AMP_REG_LEN];
    ALC1310_REGMAP     *pstAlc1310InitTbl;

    if (pstAlc1310Drv == HI_NULL)
    {
        HI_ERR_AMP("Alc1310 is not initialized yet! \n");
        return HI_FAILURE;
    }

    PROC_PRINT(p, "AMP Modul:        TI ALC1310\n");
    PROC_PRINT(p, "I2C Num:          %d\n" ,  pstAlc1310Drv->u32I2CNum);
    PROC_PRINT(p, "I2C Addr:         0x%x\n", pstAlc1310Drv->u8DeviceAddr);    
    PROC_PRINT(p, "Mute  GPIO Group: %d\n", pstAlc1310Drv->u32HWMuteGPIONum/8);
    PROC_PRINT(p, "Mute  GPIO Bit:   %d\n",    pstAlc1310Drv->u32HWMuteGPIONum%8);
    PROC_PRINT(p, "Mute  Polarity:   %d\n",    pstAlc1310Drv->u32HWMutePolarity);                                                                    
    
    PROC_PRINT(p, "Reset GPIO Group: %d\n", pstAlc1310Drv->u32ResetGPIONum/8);
    PROC_PRINT(p, "Reset GPIO Bit:   %d\n", pstAlc1310Drv->u32ResetGPIONum%8);
    PROC_PRINT(p, "Reset Polarity:   %d\n", pstAlc1310Drv->u32ResetPolarity);

    pstAlc1310InitTbl     = Alc1310_DefautTbl;

    PROC_PRINT(p,"\n--------------------- ALC1310 REGMAP -------------------------------------------------");
    for(u8Index = 0; ; u8Index ++)
    {
        u8Addr = pstAlc1310InitTbl[u8Index].bAddr;
        if(u8Addr == ENDTBL_FLAG)
        {
            break;
        }
        u8Length = pstAlc1310InitTbl[u8Index].bLength;
        PROC_PRINT(p, "\nAddr[0x%x] Len[%d]: ",u8Addr,u8Length);
        memset(u8Array,0,MAX_AMP_REG_LEN);    
        AMPReadReg(u8Addr, u8Array, u8Length);
        
        for(u8CountLoop = 0; u8CountLoop < u8Length; u8CountLoop ++)
        {
            PROC_PRINT(p, "0x%x ", u8Array[u8CountLoop]);
        }    
    }
    PROC_PRINT(p,"\n--------------------- END ALC1310 REGMAP -------------------------------------------------\n");
    
    return HI_SUCCESS;
    
}

AMP_DRV_FUNC_S stAlc1310Func =
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
    .pfnAmpResume= (FN_AMP_INIT)AMP_Resume,
};

#ifdef __cplusplus
 #if __cplusplus
}
 #endif
#endif /* End of #ifdef __cplusplus */
