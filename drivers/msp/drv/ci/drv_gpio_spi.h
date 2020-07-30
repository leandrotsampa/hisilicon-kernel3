#ifndef _HAL_CIMAXPLUS_SPI_H
#define _HAL_CIMAXPLUS_SPI_H

#include "hi_type.h"

typedef struct hiGPIO_SPi
{
    HI_U32  u32CS;    /**< The GPIO number of CS for SPI simulate BUS */     
    HI_U32  u32CLK;   /**< The GPIO number of CLK for SPI simulate BUS */       
    HI_U32  u32MISO;  /**< The GPIO number of MISO for SPI simulate BUS */           
    HI_U32  u32MOSI;  /**< The GPIO number of MOSI for SPI simulate BUS */        
}GPIO_SPI_S;

HI_S32 GPIO_SPI_Init(HI_VOID);
HI_U8 GPIO_SPI_Create(GPIO_SPI_S *pstGpioSpi, HI_U32 *pu32GroupId);
HI_U32 GPIO_SPI_Destory(HI_U32 u32GroupId);
HI_S32 GPIO_SPI_ReadByte(HI_U32 u32GroupId,  HI_U8 *pbByte);
HI_S32 GPIO_SPI_WriteByte(HI_U32 u32GroupId, HI_U8 bByte);
HI_S32 GPIO_SPI_WriteRead(HI_U32 u32GroupId, HI_U8 *pbSendData,  HI_U8 *pbRecvData, HI_U32 u32Size);
HI_S32 GPIO_SPI_Read(HI_U32 u32GroupId,  HI_U8 *pbData, HI_U32 u32Size);
HI_S32 GPIO_SPI_Write(HI_U32 u32GroupId, HI_U8 *pbData, HI_U32 u32Size);
HI_S32 GPIO_SPI_WriteRead(HI_U32 u32GroupId, HI_U8 *pbSendData,  HI_U8 *pbRecvData, HI_U32 u32Size);

#endif
