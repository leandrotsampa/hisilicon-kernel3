/**
 \file
 \brief CI hal interface
 \copyright Shenzhen Hisilicon Co., Ltd.
 \version draft
 \author l00185424
 \date 2011-7-20
 */

/***************************** Include files  *******************************/
#include <linux/delay.h>
#include <mach/hardware.h>
#include <asm/io.h>

#include <linux/fs.h>
#include <linux/sched.h>
#include <linux/kthread.h>
#include <asm/uaccess.h>

#include "hi_debug.h"
#include "hi_common.h"
#include "drv_gpio_ext.h"
#include "hi_drv_mem.h"
#include "hi_drv_module.h"
#include "hi_drv_ci.h"
#include "drv_gpio_spi.h"


/***************************** Macro Definition ******************************/
#define MAX_GPIO_SPI_GROUP_ID              7
#define INVALID_GPIO_SPI_GROUP_ID          0xFF

#define GPIO_DIR_INPUT  HI_TRUE
#define GPIO_DIR_OUTPUT HI_FALSE

#define SPI_ENABLE(id, x)   s_pGpioFunc->pfnGpioWriteBit(s_astGpioSpiGroup[id].stGpioSpi.u32CS, !x)
#define SPI_CLK_D(id, x)    s_pGpioFunc->pfnGpioWriteBit(s_astGpioSpiGroup[id].stGpioSpi.u32CLK, x)
#define SPI_MISO_D(id, x)   s_pGpioFunc->pfnGpioReadBit(s_astGpioSpiGroup[id].stGpioSpi.u32MISO, &x)
#define SPI_MOSI_D(id, x)   s_pGpioFunc->pfnGpioWriteBit(s_astGpioSpiGroup[id].stGpioSpi.u32MOSI, x)

/*************************** Structure Definition ****************************/
typedef struct hiGPIO_SPI_GROUP
{
    HI_U8 u8GpioGroupId;
    HI_BOOL bIsUsed;
    GPIO_SPI_S stGpioSpi;
}GPIO_SPI_GROUP_S;

/*************************** Global Declarations *****************************/


/*************************** Static Declarations *****************************/
static GPIO_EXT_FUNC_S* s_pGpioFunc = HI_NULL;
static GPIO_SPI_GROUP_S s_astGpioSpiGroup[MAX_GPIO_SPI_GROUP_ID+1];

/******************************* API declaration *****************************/
static HI_VOID SPI_Delay(void)
{
    volatile HI_U32 i;

    for (i=0; i<100; i++)
    {
        
    }
}

HI_S32 GPIO_SPI_Init(HI_VOID)
{
    s_pGpioFunc = HI_NULL;
    HI_DRV_MODULE_GetFunction(HI_ID_GPIO, (HI_VOID**)&s_pGpioFunc);
    if (s_pGpioFunc->pfnGpioDirSetBit == HI_NULL
      || s_pGpioFunc->pfnGpioReadBit == HI_NULL
      || s_pGpioFunc->pfnGpioWriteBit == HI_NULL)
    {
        HI_ERR_CI("Init GPIO FUNC error.\n");
        return HI_FAILURE;
    }

    memset(&s_astGpioSpiGroup, 0x00, sizeof(s_astGpioSpiGroup));

    return HI_SUCCESS;
}

HI_U8 GPIO_SPI_Create(GPIO_SPI_S *pstGpioSpi, HI_U32 *pu32GroupId)
{
    HI_U32 i;
    HI_U32 s32Ret;
    HI_U32  u32GroupNum = INVALID_GPIO_SPI_GROUP_ID;

    if (pstGpioSpi == HI_NULL)
    {
        HI_ERR_CI("Invalid param.\n");
        return HI_FAILURE;
    }

    for (i=0; i<=MAX_GPIO_SPI_GROUP_ID; i++)
    {
        if (s_astGpioSpiGroup[i].bIsUsed == HI_FALSE)
        {
            s_astGpioSpiGroup[i].stGpioSpi = *pstGpioSpi;
            u32GroupNum = i;
            break;
        }
    }
    if (u32GroupNum == INVALID_GPIO_SPI_GROUP_ID)
    {
        HI_ERR_CI("All the Gpio Spi Group are used.\n");
        return HI_FAILURE;
    }

    if ((s_pGpioFunc) && (s_pGpioFunc->pfnGpioDirSetBit))
    {
        s32Ret = s_pGpioFunc->pfnGpioDirSetBit(pstGpioSpi->u32MISO, GPIO_DIR_INPUT);
        if (HI_SUCCESS != s32Ret)
        {
            HI_ERR_CI("GPIO of MISO set direction fail.\n");
            return HI_FAILURE;
        }
        s32Ret = s_pGpioFunc->pfnGpioDirSetBit(pstGpioSpi->u32MOSI, GPIO_DIR_OUTPUT);
        if (HI_SUCCESS != s32Ret)
        {
            HI_ERR_CI("GPIO of MOSI set direction fail.\n");
            return HI_FAILURE;
        }
        s32Ret = s_pGpioFunc->pfnGpioDirSetBit(pstGpioSpi->u32CLK, GPIO_DIR_OUTPUT);
        if (HI_SUCCESS != s32Ret)
        {
            HI_ERR_CI("GPIO of CLK set direction fail.\n");
            return HI_FAILURE;
        }
        s32Ret = s_pGpioFunc->pfnGpioDirSetBit(pstGpioSpi->u32CS, GPIO_DIR_OUTPUT);
        if (HI_SUCCESS != s32Ret)
        {
            HI_ERR_CI("GPIO of CS set direction fail.\n");
            return HI_FAILURE;
        }
    }

    *pu32GroupId = u32GroupNum;
        
    return HI_SUCCESS;
}

HI_U32 GPIO_SPI_Destory(HI_U32 u32GroupId)
{
    if (u32GroupId > MAX_GPIO_SPI_GROUP_ID)
    {
        HI_ERR_CI("Invalid param.\n");
        return HI_FAILURE;
    }
    
    if (s_astGpioSpiGroup[u32GroupId].bIsUsed == HI_TRUE)
    {
        memset(&s_astGpioSpiGroup[u32GroupId], 0x00, sizeof(GPIO_SPI_GROUP_S));
    }
    return HI_SUCCESS;
}

HI_S32 GPIO_SPI_ReadByte(HI_U32 u32GroupId,  HI_U8 *pbByte)
{
    HI_S32 n ;
    HI_S32 dat = 0; 
    HI_S32 bit_t = 0;  

    if ((pbByte == HI_NULL) || (u32GroupId > MAX_GPIO_SPI_GROUP_ID))
    {
        HI_ERR_CI("Invalid param.\n");
        return HI_FAILURE;
    }

    SPI_ENABLE(u32GroupId, 1);
     
    for(n=0;n<8;n++)
    {     
        SPI_CLK_D(u32GroupId, 0);
        SPI_Delay();
        dat<<=1;  
        SPI_MISO_D(u32GroupId, bit_t);
        if(bit_t)
        {
            dat|=0x01; 
        }
        else 
        {
            dat&=0xfe; 
        }
        SPI_CLK_D(u32GroupId, 1); 
        SPI_Delay();
    }
    
    SPI_ENABLE(u32GroupId, 0);

    *pbByte = dat;

    return HI_SUCCESS;
}

HI_S32 GPIO_SPI_WriteByte(HI_U32 u32GroupId, HI_U8 bByte)
{
    HI_U32 n , bit_t; 

    if (u32GroupId > MAX_GPIO_SPI_GROUP_ID)
    {
        HI_ERR_CI("Invalid param.\n");
        return HI_FAILURE;
    }

    SPI_ENABLE(u32GroupId, 1);
     
    for(n=0;n<8;n++)
    {   
        SPI_CLK_D(u32GroupId, 0); 
        SPI_Delay();
        bit_t = (bByte & 0x80) >> 7;
        SPI_MOSI_D(u32GroupId, bit_t);        
        SPI_CLK_D(u32GroupId, 1);
        SPI_Delay();
        bByte<<=1; 
    }
    
    SPI_ENABLE(u32GroupId, 1);
    
    return HI_SUCCESS;
}

HI_S32 GPIO_SPI_WriteReadByte(HI_U32 u32GroupId,  HI_U8 bWByte, HI_U8 *pbRByte)
{
    HI_U32 n , bit_t; 
    HI_U8 dat = 0;

    if ((pbRByte == HI_NULL) || (u32GroupId > MAX_GPIO_SPI_GROUP_ID))
    {
        HI_ERR_CI("Invalid param.\n");
        return HI_FAILURE;
    }

    SPI_ENABLE(u32GroupId, 1);
    SPI_Delay();
     
    for(n=0;n<8;n++)
    {   
        SPI_CLK_D(u32GroupId, 0); 
        bit_t = (bWByte & 0x80) >> 7;
        SPI_MOSI_D(u32GroupId, bit_t);   
        SPI_Delay();
        SPI_CLK_D(u32GroupId, 1);
        SPI_Delay();
        SPI_MISO_D(u32GroupId, bit_t);
        if(bit_t)
        {
            dat|=0x01; 
        }
        else 
        {
            dat&=0xfe; 
        }
        
        bWByte<<=1;         
        dat<<=1;
    }

    *pbRByte = dat;
 
    SPI_CLK_D(u32GroupId, 0); 
    SPI_ENABLE(u32GroupId, 1);

    return HI_SUCCESS;
}

HI_S32 GPIO_SPI_Read(HI_U32 u32GroupId,  HI_U8 *pbData, HI_U32 u32Size)
{
    HI_U32 i;

    if ((pbData == HI_NULL) || (u32GroupId > MAX_GPIO_SPI_GROUP_ID))
    {
        HI_ERR_CI("Invalid param.\n");
        return HI_FAILURE;
    }

    for(i=0; i<u32Size; i++)
    {
       GPIO_SPI_ReadByte(u32GroupId, &pbData[i]); 
    }
    
    return HI_SUCCESS;
}

HI_S32 GPIO_SPI_Write(HI_U32 u32GroupId, HI_U8 *pbData, HI_U32 u32Size)
{
    HI_U32 i;

    if ((pbData == HI_NULL) || (u32GroupId > MAX_GPIO_SPI_GROUP_ID))
    {
        HI_ERR_CI("Invalid param.\n");
        return HI_FAILURE;
    }

    for(i=0; i<u32Size; i++)
    {
       GPIO_SPI_WriteByte(u32GroupId, pbData[i]); 
    }

    return HI_SUCCESS; 
}

HI_S32 GPIO_SPI_WriteRead(HI_U32 u32GroupId, HI_U8 *pbSendData,  HI_U8 *pbRecvData, HI_U32 u32Size)
{
    HI_U32 i;

    if ((pbSendData == HI_NULL) || (pbRecvData == HI_NULL) || (u32GroupId > MAX_GPIO_SPI_GROUP_ID))
    {
        HI_ERR_CI("Invalid param.\n");
        return HI_FAILURE;
    }

    for(i=0; i<u32Size; i++)
    {
       GPIO_SPI_WriteReadByte(u32GroupId, pbSendData[i], &pbRecvData[i]); 
    }

    return HI_SUCCESS; 
}


