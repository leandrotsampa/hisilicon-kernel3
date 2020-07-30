//******************************************************************************
//  Copyright (C), 2007-2014, Hisilicon Technologies Co., Ltd.
//
//******************************************************************************
// File name     : hal_hdmirx.c
// Version       : 1.0
// Author        : t00202585
// Created       : 2011-06-04
// Last Modified : 
// Description   :  The C union definition file for the module tvd
// Function List : 
// History       : 
// 1 Date        : 2014-06-14
// Author        : l00214567
// Modification  : Create file
//******************************************************************************
#include <linux/kernel.h>       /* HDMIRX_DEBUG */
#include <asm/io.h>             /* ioremap_nocache */
//#include <linux/sched.h>
//#include <linux/delay.h>

//#include "hi_tvd.h"
#include "hi_type.h"
//#include "command.h"
//#include "int.h"

/*libo @201403*/

#include "drv_i2c_ext.h"
#include "hi_drv_i2c.h"
#include "drv_gpio_ext.h"
#include "drv_gpioi2c_ext.h"
#include "hi_drv_hdmirx.h"
#include "hi_drv_module.h"


/****************************************************************************************
    basic function of read and write the value of reg
*****************************************************************************************/


#define ABS(x) ((x) >= 0 ? (x) : (-(x)))

#define HDMIRX_I2C_RATE_50K    50000   /*50k*/

static I2C_EXT_FUNC_S* gsHdmiRxI2cFunc   = HI_NULL;
static GPIO_I2C_EXT_FUNC_S* pstGpioI2cExt = HI_NULL;

HI_BOOL gbHdmiRxSwI2c = HI_FALSE;
HI_U32 g_u32HdmiRxI2cNum = 1;  //I2C_3

HI_U32 gpioScl = 20; //gpio2_4
HI_U32 gpioSda = 19; //gpio2_3
HI_U32 gpioRst = 81; //gpio2_0
HI_U32 gpioInt = 82; //gpio2_1
bool bLowCi2ca = 1; //CI2CA Signal, affect System Control and Status REGISTER

//static inline
HI_VOID HDMI_HAL_Read(HI_U32 u32Dev, HI_U32 u32Addr, HI_U8* pu8Value)
{
    HI_S32 s32Ret;
    if (HI_TRUE == gbHdmiRxSwI2c)
    {
        s32Ret = pstGpioI2cExt->pfnGpioI2cReadExt(g_u32HdmiRxI2cNum, u32Dev, u32Addr, 1, pu8Value, 1);
    }
    else
    {
        s32Ret = gsHdmiRxI2cFunc->pfnI2cRead(g_u32HdmiRxI2cNum, (HI_U8)u32Dev, u32Addr, 1, pu8Value, 1);
    }

    if (HI_SUCCESS != s32Ret)
    {
        HI_ERR_HDMIRX("I2cNum:%d, u32Dev:%#x, u32Addr%#x, u8Value:%#x HDMI_HAL_Read failed!\n",
                      g_u32HdmiRxI2cNum, u32Dev, u32Addr, *pu8Value);
    }
}

//static inline
HI_VOID HDMI_HAL_Write(HI_U32 u32Dev, HI_U32 u32Addr, HI_U8 u8Value)
{
    HI_S32 s32Ret;
    if (HI_TRUE == gbHdmiRxSwI2c)
    {
        s32Ret = pstGpioI2cExt->pfnGpioI2cWriteExt(g_u32HdmiRxI2cNum, u32Dev, u32Addr, 1, &u8Value, 1);
    }
    else
    {
        s32Ret = gsHdmiRxI2cFunc->pfnI2cWrite(g_u32HdmiRxI2cNum, u32Dev, u32Addr, 1, &u8Value, 1);
    }
    if (HI_SUCCESS != s32Ret)
    {
        HI_ERR_HDMIRX("I2cNum:%d, u32Dev:%#x, u32Addr%#x, u8Value:%#x HDMI_HAL_Write failed!\n",
                      g_u32HdmiRxI2cNum, u32Dev, u32Addr, u8Value);
    }
}

HI_VOID HDMI_HAL_Read2B(HI_U32 u32Dev, HI_U32 u32Addr, HI_U32* pu32Value)
{
    HI_U32 i, u32Cnt = 0;
    HI_S32 s32Ret;
    HI_U16 u16Tmp;
    HI_U16 u16TmpLast = 0;

    for (i = 0; i < 100; i++)
    {
        if (HI_TRUE == gbHdmiRxSwI2c)
        {
            s32Ret = pstGpioI2cExt->pfnGpioI2cReadExt(g_u32HdmiRxI2cNum, u32Dev, u32Addr, 1, (HI_U8*)(&u16Tmp), 2);
        }
        else
        {
            s32Ret = gsHdmiRxI2cFunc->pfnI2cRead(g_u32HdmiRxI2cNum, u32Dev, u32Addr, 1, (HI_U8*)(&u16Tmp), 2);
        }
        if (HI_SUCCESS != s32Ret)
        {
            HI_ERR_HDMIRX("I2cNum:%d, u32Dev:%#x, u32Addr%#x, u8Value:%#x HDMI_HAL_Read failed!\n",
                          g_u32HdmiRxI2cNum, u32Dev, u32Addr, u16Tmp);
            i = 0;
            continue;
        }

        if (ABS(u16TmpLast - u16Tmp) < 5)
        {
            u32Cnt++;

            if (u32Cnt > 3)
            {
                break;
            }
        }
        else
        {
            u32Cnt = 0;
            u16TmpLast = u16Tmp;
        }
    }

    if (i == 100)
    {
        HI_ERR_HDMIRX("HDMI_HAL_Read2B read err\n");
    }

    *pu32Value = (HI_U32)(u16Tmp);
}

HI_S32 HDMI_HAL_HAL_Init(HI_VOID)
{
    HI_S32 s32Ret;
    GPIO_EXT_FUNC_S* pstGpioExt = HI_NULL;

    s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_GPIO, (HI_VOID**)&pstGpioExt);
    if ((HI_NULL == pstGpioExt) || (HI_SUCCESS != s32Ret))
    {
        HI_ERR_HDMIRX("Get Function from GPIO failed.\n");
        return HI_FAILURE;
    }

    if (HI_STD_I2C_NUM < g_u32HdmiRxI2cNum)
    {
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_GPIO_I2C, (HI_VOID**)&pstGpioI2cExt);
        if ((HI_NULL == pstGpioI2cExt) || (HI_SUCCESS != s32Ret))
        {
            HI_ERR_HDMIRX("Get Function from GPIO_I2C failed.\n");
            return HI_FAILURE;
        }

        s32Ret = pstGpioI2cExt->pfnGpioI2cCreateChannel(&g_u32HdmiRxI2cNum, gpioScl, gpioSda);
        if (HI_SUCCESS != s32Ret)
        {
            HI_ERR_HDMIRX("pfnGpioI2cCreateChannel failed\n");
            return s32Ret;
        }
        gbHdmiRxSwI2c = HI_TRUE;
        
        HI_INFO_HDMIRX("SW I2c Num:%d\n",g_u32HdmiRxI2cNum);   
    }
    else
    {
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_I2C, (HI_VOID**)&gsHdmiRxI2cFunc);
        if ((HI_SUCCESS != s32Ret) || !gsHdmiRxI2cFunc \
            || !gsHdmiRxI2cFunc->pfnI2cWrite \
            || !gsHdmiRxI2cFunc->pfnI2cRead \
            || !gsHdmiRxI2cFunc->pfnI2cReadDirectly \
            || !gsHdmiRxI2cFunc->pfnI2cWriteNostop )
        {
            HI_ERR_HDMIRX("I2C not found\n");
            return HI_FAILURE;
        }
        #if 0 /*--NO MODIFY : COMMENT BY CODINGPARTNER--*/
        if ((HI_SUCCESS != s32Ret) || !gsHdmiRxI2cFunc \
            || !gsHdmiRxI2cFunc->pfnI2cWrite \
            || !gsHdmiRxI2cFunc->pfnI2cRead \
            || !gsHdmiRxI2cFunc->pfnI2cReadDirectly \
            || !gsHdmiRxI2cFunc->pfnI2cWriteNostop \
            || !gsHdmiRxI2cFunc->pfnI2cSetRate)
        {
            HI_ERR_HDMIRX("I2C not found\n");
            return HI_FAILURE;
        }
        s32Ret = gsHdmiRxI2cFunc->pfnI2cSetRate(g_u32HdmiRxI2cNum, HDMIRX_I2C_RATE_50K);
        if (HI_SUCCESS != s32Ret)
        {
            HI_ERR_HDMIRX("I2C RATE 50K failed:%d\n", s32Ret);
            return HI_FAILURE;
        }
        #endif /*--NO MODIFY : COMMENT BY CODINGPARTNER--*/
        gbHdmiRxSwI2c = HI_FALSE;
        
        HI_INFO_HDMIRX("HW I2c Num:%d\n",g_u32HdmiRxI2cNum);   
    }
    return HI_SUCCESS;
}



extern HI_U32 HDMI_VIRTUL_ADDR_BASE;
/*
    read the value of reg
*/

static HI_U8 GetRightHigh(HI_U32 u32Mask)
{
     HI_U32 i;
     for(i=0;;i++) {
        if((u32Mask & 0x01) == 0x01) {
            break;
        }
        else {
            u32Mask >>= 1;
        }
     }
     return i;
     
}
HI_U32 HDMI_HAL_RegRead(HI_U32 u32Addr)
{
    HI_U32 u32Temp;
    
    u32Temp = (*((volatile unsigned int *)(HDMI_VIRTUL_ADDR_BASE + u32Addr)));
   // HDMIRX_DEBUG("himd.l 0x%04x  0x%02x\n",u32Addr, u32Temp );

    return u32Temp;
}

/*
    read the value of special field of the reg
*/
HI_U32 HDMI_HAL_RegReadFldAlign(HI_U32 u32Addr, HI_U32 u32Mask)
{
    HI_U32 u32Temp;
    HI_U32 i;
    
    u32Temp = HDMI_HAL_RegRead(u32Addr);
    i = GetRightHigh(u32Mask);
    return ((u32Temp&(HI_U32)u32Mask)>>i);   
}

void HDMI_HAL_RegReadBlock(HI_U32 u32Addr, HI_U32 *pDst, HI_U32 u32Num)
{
    while(u32Num > 0) {
        *pDst = HDMI_HAL_RegRead(u32Addr);
        pDst++;
        u32Addr += 4;
        u32Num -= 1;
    }
}

/*
    write the reg with value
*/
void HDMI_HAL_RegWrite(HI_U32 u32Addr, HI_U32 u32Value)
{
    (*((volatile unsigned int *)(HDMI_VIRTUL_ADDR_BASE + u32Addr)) = (u32Value & 0x000000ff));
    
  //  HDMIRX_DEBUG("himm 0xf8cf%04x  0x%02x\n",u32Addr,(u32Value & 0x000000ff));
}

void HDMI_HAL_RegWriteBlock(HI_U32 u32Addr, HI_U32 *pSrc, HI_U32 u32Num)
{
    while(u32Num > 0) {
        HDMI_HAL_RegWrite(u32Addr,*pSrc);
        pSrc++;
        u32Addr += 4;
        u32Num -= 1;
    }
}
/*
    write the special field of reg with value
*/

void HDMI_HAL_RegWriteFldAlign(HI_U32 u32Addr, HI_U32 u32Mask, HI_U32 u32Value)
{
    HI_U32 u32Temp;
    //HI_U8 u8Temp;
    HI_U8 i;

//    u8Temp = u8Mask;
    u32Temp = HDMI_HAL_RegRead(u32Addr);
    #if 0
    for(i=0; ;i++) {
        if ((u8Temp & 0x01) == 0x01) {
            break;
        }
        else {
            u8Temp >>= 1;
        }
    }
    #endif
    i = GetRightHigh(u32Mask);
    u32Value <<= i;
    u32Temp &= ~u32Mask;
    u32Temp |= u32Value;
    HDMI_HAL_RegWrite(u32Addr, u32Temp);
}

void HDMI_HAL_RegSetBits(HI_U32 u32Addr,HI_U32 u32Mask, HI_BOOL bValue)
{
    HI_U32 u32Temp;
    
    u32Temp = HDMI_HAL_RegRead(u32Addr);
    if(bValue == HI_TRUE) {
        u32Temp |= (HI_U32)u32Mask;
    }
    else if(bValue == HI_FALSE) {
        u32Temp &= ~(HI_U32)u32Mask;
    }
    HDMI_HAL_RegWrite(u32Addr, u32Temp);
}



