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

#include "hi_drv_module.h"
#include "drv_i2c_ext.h"
#include "hal_ci.h"

/***************************** Macro Definition ******************************/

#define SMI_REG_BASE_ADDR 0x60000000
#define CRG_BASE_ADDR 0x101f5000

#define DEF_IO_BASE_ADDRESS_A (0)           /* IO base address of card A */
#define DEF_ATTR_BASE_ADDRESS_A (0)         /* Attribute base address of card A */
#define DEF_IO_BASE_ADDRESS_B (0x8000)      /* IO base address of card B */
#define DEF_ATTR_BASE_ADDRESS_B (0x8000)    /* Attribute base address of card B */

/* For SSMC register */
#define SSMC_CLK (1 << 8)
#define SSMC_RESET (1)

/* CIMAX registers internal addresses */
#define MOD_A_CTRL          0x00
#define AAUTOSEL_MASK_H     0x01
#define AAUTOSEL_MASK_L     0x02
#define AAUTOSEL_PAT_H      0x03
#define AAUTOSEL_PAT_L      0x04
#define ACCESS_TIME_REG_A   0x05
#define MOD_B_CTRL          0x09
#define BAUTOSEL_MASK_H     0x0A
#define BAUTOSEL_MASK_L     0x0B
#define BAUTOSEL_PAT_H      0x0C
#define BAUTOSEL_PAT_L      0x0D
#define ACCESS_TIME_REG_B   0x0E
#define XAUTOSEL_MASK_H     0x12
#define DEST_SEL            0x17
#define PWR_CTRL            0x18
#define INT_STAT            0x1A
#define INT_MASK            0x1B
#define INT_CNF             0x1C
#define PROC_CNF            0x1D
#define ACK_CNF             0x1E
#define CIM_CTRL            0x1F
#define TS_CONFIG           0x20
#define SYN_CONFIG          0x21

/* CIMAX Config bit */
#define CIMAX_MODULE_RST 0x80
#define CIMAX_ACCESS_MODE_MASK_0 0x04
#define CIMAX_ACCESS_MODE_MASK_1 0x08
#define CIMAX_CARD_READY_MASK_A 0x04
#define CIMAX_CARD_READY_MASK_B 0x08
#define CIMAX_CARD_TSIN_MASK 0x20
#define CIMAX_CARD_TSOUT_MASK 0x40
#define CIMAX_POWER_BIT 0x01
#define CIMAX_STANDBY_BIT 0x02
#define CIMAX_WAKEUP 0x01

/*************************** Structure Definition ****************************/

/* CI PC CARD configure and management structure */
typedef struct hiCI_HAL_PCCD_PARAMETER
{
    CI_PCCD_ATTR_S stAttr;          /* Voltage, speed, ... */
    HI_BOOL        bTSByPass;       /* Slot TS ByPass status */
    HI_U32         u32IOBaseAddress;/* Address offset to read/write IO */
    HI_U32         u32AttrBaseAddress; /* Address offset to read/write attribute */
    HI_U8          u8OldModuleCtrlReg; /* Save reg value, please refer to PATCH1. */
} CIMAX_PCCD_PARAMETER_S;

/* CI driver configure structure */
typedef struct hiCI_HAL_PARAMETER_S
{
    HI_U32                 u32SMIBitWidth;
    HI_U32                 u32SMIBaseAddr;  /* SMI Base Address */
    HI_U32                 u32I2cNum;       /* I2C Group */
    HI_U8                  u8DevAddress;    /* I2C device address */
    HI_UNF_CI_TS_MODE_E    enTSMode;        /* TS mode, support serial or parallel */
    CIMAX_PCCD_PARAMETER_S astCardParam[HI_UNF_CI_PCCD_BUTT];
} CIMAX_PARAMETER_S;

/*************************** Global Declarations *****************************/

extern HI_VOID HI_DRV_SYS_GetChipVersion(HI_CHIP_TYPE_E *penChipType, HI_CHIP_VERSION_E *penChipVersion);

/*************************** Static Declarations *****************************/

static I2C_EXT_FUNC_S* s_pI2cFunc = HI_NULL;
static CIMAX_PARAMETER_S s_astCIMaXParam[HI_UNF_CI_PORT_BUTT];

/* Read CIMAX extended register */
static HI_S32  CIMAX_ReadExReg(HI_U32 u32I2cNum, HI_U8 u8I2cDevAddr,
                               HI_U32 u32Address, HI_U8* pu8Buffer);

/* Write CIMAX extended register */
static HI_S32  CIMAX_WriteExReg(HI_U32 u32I2cNum, HI_U8 u8I2cDevAddr,
                                HI_U32 u32Address, HI_U8* pu8Buffer);

/******************************* API declaration *****************************/

/* Read extended register, for example, CIMAX */
HI_S32 CIMAX_ReadExReg(HI_U32 u32I2cNum, HI_U8 u8I2cDevAddr,
                       HI_U32 u32Address, HI_U8* pu8Buffer)
{
    
    if ((!s_pI2cFunc) || (!s_pI2cFunc->pfnI2cRead))
    {
        return HI_FAILURE;
    }
    else
    {
        return s_pI2cFunc->pfnI2cRead(u32I2cNum, u8I2cDevAddr, u32Address, 1, pu8Buffer, 1);
    }
}

/* Write extended register, for example, CIMAX */
HI_S32 CIMAX_WriteExReg(HI_U32 u32I2cNum, HI_U8 u8I2cDevAddr,
                        HI_U32 u32Address, HI_U8* pu8Buffer)
{
    if ((!s_pI2cFunc) || (!s_pI2cFunc->pfnI2cWrite))
    {
        return HI_FAILURE;
    }
    else
    {
        return s_pI2cFunc->pfnI2cWrite(u32I2cNum, u8I2cDevAddr, u32Address, 1, pu8Buffer, 1);
    }
}

static HI_S32 SMI_Init(HI_UNF_CI_PORT_E enCIPort, HI_U32 u32BitWidth)
{
    HI_U32 u32CRGBaseAddr;
    HI_U32 u32RegValue;
    //HI_CHIP_TYPE_E enChipType;
    //HI_U32 u32ChipVersion = 0;

    HI_INFO_CI("CIMaX: SMI_Init start\n");

    //HI_DRV_SYS_GetChipVersion(&enChipType, &u32ChipVersion);

    /* MV300 unsupport SSMC/SMI */

    /*if ((HI_CHIP_TYPE_HI3716M == enChipType) && (HI_CHIP_VERSION_V300 == u32ChipVersion))
    {
        HI_ERR_CI("Hi3716MV300 unsupport SSMC/SMI\n");
        return HI_FAILURE;
    }*/

    s_astCIMaXParam[enCIPort].u32SMIBitWidth = u32BitWidth;

    /* SSMC config */
    u32CRGBaseAddr = (HI_U32)IO_ADDRESS(CRG_BASE_ADDR);
    u32RegValue = *(volatile HI_U32*)(0xc0 + u32CRGBaseAddr);

    /* If SSMC clock close, open it */
    if (!(u32RegValue & SSMC_CLK))
    {
        u32RegValue &= ~SSMC_RESET;
        *(volatile HI_U32*)(0xc0 + u32CRGBaseAddr) = u32RegValue | SSMC_CLK;
    }

    /* SMI 0 BCR */
    u32CRGBaseAddr = (HI_U32)IO_ADDRESS(SMI_REG_BASE_ADDR);
    u32RegValue = *(volatile HI_U32*)(0x14 + u32CRGBaseAddr);
    if (u32BitWidth == 8)
    {
        u32RegValue &= ~0x30;
    }
    else if (u32BitWidth == 16)
    {
        u32RegValue &= ~0x30;
        u32RegValue |= 0x10;
    }

    /* Wait enable */
    *(volatile HI_U32*)(0x14 + u32CRGBaseAddr) = u32RegValue | 0x4;

    HI_INFO_CI("CIMaX: SMI_Init end\n");
    return HI_SUCCESS;
}

static HI_S32 SMI_DeInit(HI_VOID)
{
    HI_U32 u32CRGBaseAddr;
    HI_U32 u32RegValue;
    HI_CHIP_TYPE_E enChipType;
    HI_U32 u32ChipVersion = 0;

    HI_INFO_CI("CIMaX: SMI_DeInit start\n");

    HI_DRV_SYS_GetChipVersion(&enChipType, &u32ChipVersion);

    /* MV300 unsupport SSMC/SMI */

    if ((HI_CHIP_TYPE_HI3716M == enChipType) && (HI_CHIP_VERSION_V300 == u32ChipVersion))
    {
        HI_ERR_CI("Hi3716MV300 unsupport SSMC/SMI\n");
        return HI_FAILURE;
    }

    /* SSMC close */
    u32CRGBaseAddr = (HI_U32)IO_ADDRESS(CRG_BASE_ADDR);
    u32RegValue  = *(volatile HI_U32*)(0xc0 + u32CRGBaseAddr);
    u32RegValue &= ~SSMC_CLK;

    /* Close SSMC clock */
    *(volatile HI_U32*)(0xc0 + u32CRGBaseAddr) = u32RegValue | SSMC_RESET;

    HI_INFO_CI("CIMaX: SMI_DeInit end\n");
    return HI_SUCCESS;
}

static HI_S32 SMI_Open(HI_UNF_CI_PORT_E enCIPort)
{
    HI_CHIP_TYPE_E enChipType;
    HI_U32 u32ChipVersion = 0;

    HI_INFO_CI("CIMaX: SMI_Open start\n");

    HI_DRV_SYS_GetChipVersion(&enChipType, &u32ChipVersion);

    /* MV300 unsupport SSMC/SMI */

    if ((HI_CHIP_TYPE_HI3716M == enChipType) && (HI_CHIP_VERSION_V300 == u32ChipVersion))
    {
        HI_ERR_CI("Hi3716MV300 unsupport SSMC/SMI\n");
        return HI_FAILURE;
    }

    s_astCIMaXParam[enCIPort].u32SMIBaseAddr =
        (HI_U32)ioremap_nocache(s_astCIMaXParam[enCIPort].u32SMIBaseAddr, 0x10000);
    HI_INFO_CI("CI %d SMI_Open,s_astCIMaXParam[enCIPort].u32SMIBaseAddr = 0x%08x\n",
               enCIPort, s_astCIMaXParam[enCIPort].u32SMIBaseAddr);
    HI_INFO_CI("CIMaX: SMI_Open end\n");
    return HI_SUCCESS;
}

static HI_S32 SMI_Close(HI_UNF_CI_PORT_E enCIPort)
{
    HI_INFO_CI("CIMaX: SMI_Close start\n");

    if (HI_NULL != (HI_VOID *)s_astCIMaXParam[enCIPort].u32SMIBaseAddr)
    {
        iounmap((HI_VOID *)s_astCIMaXParam[enCIPort].u32SMIBaseAddr);
    }

    HI_INFO_CI("CIMaX: SMI_Close end\n");
    return HI_SUCCESS;
}

static HI_S32 SMI_Read(HI_U32 u32SMIBitWidth, HI_U32 u32SMIBaseAddr,
                       HI_U32 u32From, HI_U32 u32Bytes, HI_U8 *pu8Buffer)
{
    HI_S32 i = 0;
    HI_U32 u32UtiFrom = 0;
    HI_U32 u32UtiByte = u32Bytes;

    if ((-1 == u32SMIBaseAddr) || (0 == u32SMIBaseAddr))
    {
        HI_ERR_CI("SMI_Read fail, invalid u32SMIBaseAddr:%d.\n", u32SMIBaseAddr);
        return HI_FAILURE;
    }

    if (pu8Buffer == HI_NULL_PTR)
    {
        HI_ERR_CI("SMI_Read fail, NULL buffer.\n");
        return HI_FAILURE;
    }

    u32UtiFrom = u32From;

    /* read from u32SMIBaseAddr */
    if (u32SMIBitWidth == 16)
    {
        /* input odd address, we should read previous byte together */
        if ((u32From & 0x01) == 1)
        {
            u32UtiFrom -= 1;
            u32UtiByte++;
        }

        /* total odd bytes */
        if ((u32UtiByte & 0x01) == 0x01)
        {
            u32UtiByte++;
        }

        for (i = 0; i < u32UtiByte / 2; i++)
        {
            *(HI_U16*)(pu8Buffer + (i * 2)) =
                *(volatile HI_U16*)(u32UtiFrom + (i * 2) + u32SMIBaseAddr);
        }

        /* input odd address */
        if ((u32From & 0x01) == 1)
        {
            for (i = 0; i < u32Bytes; i++)
            {
                pu8Buffer[i] = pu8Buffer[i + 1];
            }
        }
    }
    else
    {
        for (i = 0; i < u32Bytes; i++)
        {
            *(HI_U8*)(pu8Buffer + i) = *(volatile HI_U8*)(u32UtiFrom + i + u32SMIBaseAddr);
        }
    }

    return HI_SUCCESS;
}

static HI_S32 SMI_Write(HI_U32 u32SMIBitWidth, HI_U32 u32SMIBaseAddr,
                        HI_U32 u32From, HI_U32 u32Bytes, HI_U8 *pu8Buffer)
{
    HI_S32 i = 0;
    HI_U32 u32UtiFrom   = 0;
    HI_U16 u16TempShort = 0;
    HI_U8 au8TempBuffer[70];
    HI_U32 u32UtiByte = u32Bytes;

    if ((-1 == u32SMIBaseAddr))
    {
        HI_ERR_CI("SMI_Write failed, invalid u32SMIBaseAddr:%d.\n", u32SMIBaseAddr);
        return HI_FAILURE;
    }

    if (pu8Buffer == HI_NULL_PTR)
    {
        HI_ERR_CI("SMI_Write failed, NULL buffer.\n");
        return HI_FAILURE;
    }

    u32UtiFrom = u32From;

    /* write to u32SMIBaseAddr */
    if (u32SMIBitWidth == 16)
    {
        /* input odd address, read previous byte and put info write buffer */
        if ((u32From & 0x01) == 1)
        {
            u32UtiFrom  -= 1;
            u16TempShort = *(volatile HI_U16*)(u32UtiFrom + u32SMIBaseAddr);
            au8TempBuffer[0] = u16TempShort & 0x00FF;

            for (i = 0; i < u32Bytes; i++)
            {
                au8TempBuffer[i + 1] = pu8Buffer[i];
            }

            u32UtiByte++;
        }
        else
        {
            for (i = 0; i < u32Bytes; i++)
            {
                au8TempBuffer[i] = pu8Buffer[i];
            }
        }

        /* input odd bytes, read following byte and put info write buffer */
        if ((u32UtiByte & 0x01) == 0x01)
        {
            u16TempShort = *(volatile HI_U16*)(u32UtiFrom + (u32UtiByte - 1) + u32SMIBaseAddr);
            u32UtiByte++;
            au8TempBuffer[u32UtiByte - 1] = u16TempShort >> 8;
        }

        for (i = 0; i < u32UtiByte / 2; i++)
        {
            *(volatile HI_U16*)(u32UtiFrom + (i * 2) + u32SMIBaseAddr) =
                *(HI_U16*)(au8TempBuffer + (i * 2));
        }
    }
    else
    {
        for (i = 0; i < u32Bytes; i++)
        {
            *(volatile HI_U8*)(u32UtiFrom + i + u32SMIBaseAddr) = *(HI_U8*)(pu8Buffer + i);
        }
    }

    return HI_SUCCESS;
}

static HI_S32 CIMAX_Init(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_TS_MODE_E enTSMode)
{
    HI_U32 u32I2cNum   = s_astCIMaXParam[enCIPort].u32I2cNum;
    HI_U8 u8DevAddress = s_astCIMaXParam[enCIPort].u8DevAddress;
    HI_U8 b = 0;

    HI_INFO_CI("CIMaX: CIMAX_Init start\n");

    /* reset CIMaX */
    b = 0x80;
    if (HI_SUCCESS != CIMAX_WriteExReg(u32I2cNum, u8DevAddress, CIM_CTRL, &b))
    {
        return HI_ERR_CI_REG_WRITE_ERR;
    }

    b = 0x00;
    if (HI_SUCCESS != CIMAX_WriteExReg(u32I2cNum, u8DevAddress, CIM_CTRL, &b))
    {
        return HI_ERR_CI_REG_WRITE_ERR;
    }

    /* VCCEN pin configuration :	 */
    /* active level 1;               */
    /* push-pull mode       	 */
    b = 0xC0;
    if (HI_SUCCESS != CIMAX_WriteExReg(u32I2cNum, u8DevAddress, PWR_CTRL, &b))
    {
        return HI_ERR_CI_REG_WRITE_ERR;
    }

    /* EXTCS pin configuration  */
    /* active level 0           */
    /* push pull mode           */

    /* module selection         */
    /* auto-select mode         */
    /* b = 0x02:select moduel A */
    /* b = 0x04:select moduel B */
    b = 0x21;
    if (HI_SUCCESS != CIMAX_WriteExReg(u32I2cNum, u8DevAddress, DEST_SEL, &b))
    {
        return HI_ERR_CI_REG_WRITE_ERR;
    }

    /* INT output pin configuration    */
    /* active level 0                  */
    /* push pull mode                  */

    /* EXTINT input pin configuration  */
    /* active level 0                  */
    b = 0x04;
    if (HI_SUCCESS != CIMAX_WriteExReg(u32I2cNum, u8DevAddress, INT_CNF, &b))
    {
        return HI_ERR_CI_REG_WRITE_ERR;
    }

    /* WAIT/ACK pin configuration	   */
    /* WAIT mode                       */
    /* active level 1                  */
    /* push pull mode                  */
    b = 0x02;
    if (HI_SUCCESS != CIMAX_WriteExReg(u32I2cNum, u8DevAddress, ACK_CNF, &b))
    {
        return HI_ERR_CI_REG_WRITE_ERR;
    }

    /* CS pin configuration            */
    /* active level 0                  */

    /* RD/DIR and WR/STR pins configuration */
    /* RD/WR mode                           */
    /* Read cycle when RD/DIR = 0           */
    /* Write cycle when WR/STR = 0          */
    b = 0x00;
    if (HI_SUCCESS != CIMAX_WriteExReg(u32I2cNum, u8DevAddress, PROC_CNF, &b))
    {
        return HI_ERR_CI_REG_WRITE_ERR;
    }

    /* automatic selection between the modules A,B      */
    /* or the external device connected on the EXTCS    */
    /* external device selected by default              */
    /* ==> XAUTOSEL_MASK_L useless                      */
    b = 0x80;
    if (HI_SUCCESS != CIMAX_WriteExReg(u32I2cNum, u8DevAddress, XAUTOSEL_MASK_H, &b))
    {
        return HI_ERR_CI_REG_WRITE_ERR;
    }

    /* take care about A[15], use A15 to select module */
    b = 0x00;
    if (HI_SUCCESS != CIMAX_WriteExReg(u32I2cNum, u8DevAddress, AAUTOSEL_MASK_H, &b))
    {
        return HI_ERR_CI_REG_WRITE_ERR;
    }

    if (HI_SUCCESS != CIMAX_WriteExReg(u32I2cNum, u8DevAddress, BAUTOSEL_MASK_H, &b))
    {
        return HI_ERR_CI_REG_WRITE_ERR;
    }

    b = 0x01;
    if (HI_SUCCESS != CIMAX_WriteExReg(u32I2cNum, u8DevAddress, AAUTOSEL_MASK_L, &b))
    {
        return HI_ERR_CI_REG_WRITE_ERR;
    }

    if (HI_SUCCESS != CIMAX_WriteExReg(u32I2cNum, u8DevAddress, BAUTOSEL_MASK_L, &b))
    {
        return HI_ERR_CI_REG_WRITE_ERR;
    }

    /* module A selected on @ 0x00000 to @ 0x07FFF  */
    /* module B selected on @ 0x08000 to @ 0x0FFFF  */
    b = 0x00;
    if (HI_SUCCESS != CIMAX_WriteExReg(u32I2cNum, u8DevAddress, AAUTOSEL_PAT_H, &b))
    {
        return HI_ERR_CI_REG_WRITE_ERR;
    }

    if (HI_SUCCESS != CIMAX_WriteExReg(u32I2cNum, u8DevAddress, BAUTOSEL_PAT_H, &b))
    {
        return HI_ERR_CI_REG_WRITE_ERR;
    }

    b = 0x00;
    if (HI_SUCCESS != CIMAX_WriteExReg(u32I2cNum, u8DevAddress, AAUTOSEL_PAT_L, &b))
    {
        return HI_ERR_CI_REG_WRITE_ERR;
    }

    b = 0x01;
    if (HI_SUCCESS != CIMAX_WriteExReg(u32I2cNum, u8DevAddress, BAUTOSEL_PAT_L, &b))
    {
        return HI_ERR_CI_REG_WRITE_ERR;
    }

    switch (enTSMode)
    {
    case HI_UNF_CI_TS_SERIAL:
    default:
        b = 0x11;   /* Serial, MSB */
        break;
    case HI_UNF_CI_TS_PARALLEL:
        b = 0x00;   /* Parallel */
        break;
    }
    /* Configure TS input/output mode */
    if (HI_SUCCESS != CIMAX_WriteExReg(u32I2cNum, u8DevAddress, TS_CONFIG, &b))
    {
        return HI_ERR_CI_REG_WRITE_ERR;
    }

    /* Disable syn process */
    b = 0x00;
    if (HI_SUCCESS != CIMAX_WriteExReg(u32I2cNum, u8DevAddress, SYN_CONFIG, &b))
    {
        return HI_ERR_CI_REG_WRITE_ERR;
    }

    /* lock configuration  */
    b = 0x01;
    if (HI_SUCCESS != CIMAX_WriteExReg(u32I2cNum, u8DevAddress, CIM_CTRL, &b))
    {
        return HI_ERR_CI_REG_WRITE_ERR;
    }

    /* turn module VCC on */
    b = 0x01;
    if (HI_SUCCESS != CIMAX_WriteExReg(u32I2cNum, u8DevAddress, PWR_CTRL, &b))
    {
        return HI_ERR_CI_REG_WRITE_ERR;
    }

    HI_INFO_CI("CIMaX: CIMAX_Init end\n");
    return HI_SUCCESS;
}

/* Open CI Port */
HI_S32 CIMAX_Open(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_ATTR_S stAttr)
{
    HI_S32 s32Ret = HI_SUCCESS;

    /* CIMaX only support daisy-chained */
    if (HI_UNF_CI_TSI_INDEPENDENT <= stAttr.enTSIMode)
    {
        HI_ERR_CI("CIMaX only support daisy-chained\n");
        return HI_ERR_CI_UNSUPPORT;
    }

    if (HI_UNF_CI_TS_USB2SERIAL <= stAttr.enTSMode[HI_UNF_CI_PCCD_A])
    {
        HI_ERR_CI("CIMaX only support parallel or serial\n");
        return HI_ERR_CI_UNSUPPORT;
    }

    memset(&s_astCIMaXParam[enCIPort], 0, sizeof(CIMAX_PARAMETER_S));

    /* Init parameters */
    s_astCIMaXParam[enCIPort].u32SMIBitWidth = stAttr.unDevAttr.stCIMaX.u32SMIBitWidth;
    s_astCIMaXParam[enCIPort].u32SMIBaseAddr = stAttr.unDevAttr.stCIMaX.u32SMIBaseAddr;
    s_astCIMaXParam[enCIPort].u32I2cNum = stAttr.unDevAttr.stCIMaX.u32I2cNum;
    s_astCIMaXParam[enCIPort].u8DevAddress = stAttr.unDevAttr.stCIMaX.u8DevAddress;
    s_astCIMaXParam[enCIPort].enTSMode = stAttr.enTSMode[HI_UNF_CI_PCCD_A];

    s_pI2cFunc = HI_NULL;
    HI_DRV_MODULE_GetFunction(HI_ID_I2C, (HI_VOID**)&s_pI2cFunc);

    /* Init and open SMI */
    s32Ret = SMI_Init(enCIPort, stAttr.unDevAttr.stCIMaX.u32SMIBitWidth);
    if (HI_SUCCESS != s32Ret)
    {
        return s32Ret;
    }

    s32Ret = SMI_Open(enCIPort);
    if (HI_SUCCESS != s32Ret)
    {
        return s32Ret;
    }

    /* Configure CIMAX */
    s32Ret = CIMAX_Init(enCIPort, s_astCIMaXParam[enCIPort].enTSMode);

    return s32Ret;
}

/* Close CI Port */
HI_VOID CIMAX_Close(HI_UNF_CI_PORT_E enCIPort)
{
    SMI_Close(enCIPort);
    SMI_DeInit();

    memset(s_astCIMaXParam, 0, sizeof(s_astCIMaXParam));
    s_pI2cFunc = HI_NULL;
}

/* Open Card */
HI_S32 CIMAX_PCCD_Open(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId)
{
    switch (enCardId)
    {
    case HI_UNF_CI_PCCD_A:
    default:
        s_astCIMaXParam[enCIPort].astCardParam[enCardId].u32IOBaseAddress   = DEF_IO_BASE_ADDRESS_A;
        s_astCIMaXParam[enCIPort].astCardParam[enCardId].u32AttrBaseAddress = DEF_ATTR_BASE_ADDRESS_A;
        break;

    case HI_UNF_CI_PCCD_B:
        s_astCIMaXParam[enCIPort].astCardParam[enCardId].u32IOBaseAddress   = DEF_IO_BASE_ADDRESS_B;
        s_astCIMaXParam[enCIPort].astCardParam[enCardId].u32AttrBaseAddress = DEF_ATTR_BASE_ADDRESS_B;
        break;
    }

    /* Init parameters */
    s_astCIMaXParam[enCIPort].astCardParam[enCardId].bTSByPass = HI_TRUE;

    /* Do nothing on hardware */

    return HI_SUCCESS;
}

/* Close Card */
HI_VOID CIMAX_PCCD_Close(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId)
{
    /* Do nothing on hardware */

    s_astCIMaXParam[enCIPort].astCardParam[enCardId].bTSByPass = HI_TRUE;
}

/* Read IO data, one byte */
HI_S32 CIMAX_ReadIOByte(HI_U32 u32SMIBitWidth, HI_U32 u32SMIBaseAddr,
                        HI_U32 u32Address, HI_U8 *pu8Value)
{
    return SMI_Read(u32SMIBitWidth, u32SMIBaseAddr, u32Address, 1, pu8Value);
}

/* Write IO data, one byte */
HI_S32 CIMAX_WriteIOByte(HI_U32 u32SMIBitWidth, HI_U32 u32SMIBaseAddr,
                         HI_U32 u32Address, HI_U8 u8Value)
{
    return SMI_Write(u32SMIBitWidth, u32SMIBaseAddr, u32Address, 1, &u8Value);
}

/* Read data, IO or ATTR, offset automatically */
HI_S32 CIMAX_PCCD_ReadByte(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId,
                           HI_U32 u32Address, HI_U8 *pu8Value)
{
    return SMI_Read(s_astCIMaXParam[enCIPort].u32SMIBitWidth,
                    s_astCIMaXParam[enCIPort].u32SMIBaseAddr,
                    s_astCIMaXParam[enCIPort].astCardParam[enCardId].u32IOBaseAddress + u32Address,
                    1, pu8Value);
}

/* Write data, IO or ATTR, offset automatically */
HI_S32 CIMAX_PCCD_WriteByte(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId,
                            HI_U32 u32Address, HI_U8 u8Value)
{
    HI_S32 s32Ret;

    s32Ret = SMI_Write(s_astCIMaXParam[enCIPort].u32SMIBitWidth,
                       s_astCIMaXParam[enCIPort].u32SMIBaseAddr,
                       s_astCIMaXParam[enCIPort].astCardParam[enCardId].u32IOBaseAddress + u32Address,
                       1, &u8Value);
    udelay(CI_DELAY_AFTER_WRITE_US);

    return s32Ret;
}

/* Card present or absent detect */
HI_S32 CIMAX_PCCD_Detect(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId,
                         HI_UNF_CI_PCCD_STATUS_E_PTR penCardIdStatus)
{
    HI_U32 u32Address;
    HI_U8 u8Tmp = 0;

    switch (enCardId)
    {
    case HI_UNF_CI_PCCD_A:
        u32Address = MOD_A_CTRL;
        break;

    case HI_UNF_CI_PCCD_B:
        u32Address = MOD_B_CTRL;
        break;

    default:
        return HI_ERR_CI_INVALID_PARA;
    }

    if (CIMAX_ReadExReg(s_astCIMaXParam[enCIPort].u32I2cNum,
                        s_astCIMaXParam[enCIPort].u8DevAddress,
                        u32Address, &u8Tmp))
    {
        return HI_ERR_CI_REG_READ_ERR;
    }
    else
    {
        *penCardIdStatus = u8Tmp & 0x01;
    }

    return HI_SUCCESS;
}

/* Card busy or ready detect */
HI_S32 CIMAX_PCCD_ReadyOrBusy(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId,
                              HI_UNF_CI_PCCD_READY_E_PTR penCardReady)
{
    HI_U32 u32Address;
    HI_U8 u8Tmp = 0;
    HI_U8 u8Mask;

    u32Address = INT_STAT;

    if (CIMAX_ReadExReg(s_astCIMaXParam[enCIPort].u32I2cNum,
                        s_astCIMaXParam[enCIPort].u8DevAddress,
                        u32Address, &u8Tmp))
    {
        return HI_ERR_CI_REG_READ_ERR;
    }
    else
    {
        switch (enCardId)
        {
        case HI_UNF_CI_PCCD_A:
            u8Mask = CIMAX_CARD_READY_MASK_A;
            break;

        case HI_UNF_CI_PCCD_B:
            u8Mask = CIMAX_CARD_READY_MASK_B;
            break;

        default:
            return HI_ERR_CI_INVALID_PARA;
        }

        /* This mask bit is low active */
        if ((u8Tmp & u8Mask) == 0)
        {
            *penCardReady = HI_UNF_CI_PCCD_READY;
        }
        else
        {
            *penCardReady = HI_UNF_CI_PCCD_BUSY;
        }
    }

    return HI_SUCCESS;
}

/* Reset PCCD */
HI_S32 CIMAX_PCCD_Reset(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId)
{
    HI_U32 u32Address;
    HI_U8 u8Tmp = 0;

    switch (enCardId)
    {
    case HI_UNF_CI_PCCD_A:
        u32Address = MOD_A_CTRL;
        break;

    case HI_UNF_CI_PCCD_B:
        u32Address = MOD_B_CTRL;
        break;

    default:
        return HI_ERR_CI_INVALID_PARA;
    }

    if (CIMAX_ReadExReg(s_astCIMaXParam[enCIPort].u32I2cNum,
                        s_astCIMaXParam[enCIPort].u8DevAddress,
                        u32Address, &u8Tmp))
    {
        return HI_ERR_CI_REG_READ_ERR;
    }
    else
    {
        /* Set reset bit to 1 */
        u8Tmp |= CIMAX_MODULE_RST;
        if (CIMAX_WriteExReg(s_astCIMaXParam[enCIPort].u32I2cNum,
                             s_astCIMaXParam[enCIPort].u8DevAddress,
                             u32Address, &u8Tmp))
        {
            return HI_ERR_CI_REG_WRITE_ERR;
        }

        /* Keep 10ms */
        msleep(CI_TIME_10MS);

        /* Set reset bit to 0 */
        u8Tmp &= ~CIMAX_MODULE_RST;
        if (CIMAX_WriteExReg(s_astCIMaXParam[enCIPort].u32I2cNum,
                             s_astCIMaXParam[enCIPort].u8DevAddress,
                             u32Address, &u8Tmp))
        {
            return HI_ERR_CI_REG_WRITE_ERR;
        }
    }

    return HI_SUCCESS;
}

/* Set access mode of card */
HI_S32 CIMAX_PCCD_SetAccessMode(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId,
                                HI_UNF_CI_PCCD_ACCESSMODE_E enAccessMode)
{
    HI_U32 u32Address;
    HI_U8 u8Tmp = 0;

    switch (enCardId)
    {
    case HI_UNF_CI_PCCD_A:
        u32Address = MOD_A_CTRL;
        break;

    case HI_UNF_CI_PCCD_B:
        u32Address = MOD_B_CTRL;
        break;

    default:
        return HI_ERR_CI_INVALID_PARA;
    }

    if (CIMAX_ReadExReg(s_astCIMaXParam[enCIPort].u32I2cNum,
                        s_astCIMaXParam[enCIPort].u8DevAddress,
                        u32Address, &u8Tmp))
    {
        return HI_ERR_CI_REG_READ_ERR;
    }
    else
    {
        switch (enAccessMode)
        {
            /* Set bit3bit2 = 00 */
        case HI_UNF_CI_PCCD_ACCESS_ATTR:
            u8Tmp &= ~(CIMAX_ACCESS_MODE_MASK_0 | CIMAX_ACCESS_MODE_MASK_1);
            break;

            /* Set bit3bit2 = 01 */
        case HI_UNF_CI_PCCD_ACCESS_IO:
            u8Tmp = (u8Tmp & (~CIMAX_ACCESS_MODE_MASK_1)) | CIMAX_ACCESS_MODE_MASK_0;
            break;

            /* Set bit3bit2 = 10 */
        case HI_UNF_CI_PCCD_ACCESS_COMMON:
            u8Tmp = (u8Tmp & (~CIMAX_ACCESS_MODE_MASK_0)) | CIMAX_ACCESS_MODE_MASK_1;
            break;

        default:
            return HI_ERR_CI_INVALID_PARA;
        }

        /*
         * PATCH1:
         * Normally, AccessMode is ATTR before negotiate buffer size, IO after negotiate buffer size.
         * But when read some Conax smart card's entitlement info, MOD_A_CTRL/MOD_B_CTRL would be
         * changed automatically.
         * So save the reg value here, resume it momentarily.
         */

        /* If different, need config */
        if (s_astCIMaXParam[enCIPort].astCardParam[enCardId].u8OldModuleCtrlReg != u8Tmp)
        {
            if (CIMAX_WriteExReg(s_astCIMaXParam[enCIPort].u32I2cNum,
                                 s_astCIMaXParam[enCIPort].u8DevAddress,
                                 u32Address, &u8Tmp))
            {
                return HI_ERR_CI_REG_WRITE_ERR;
            }

            /* Save reg value here */
            s_astCIMaXParam[enCIPort].astCardParam[enCardId].u8OldModuleCtrlReg = u8Tmp;
            HI_WARN_CI("Config module control reg: 0x%02x.\n", u8Tmp);

            /* Maybe need resume TS control. */
            return CIMAX_PCCD_TSByPass(enCIPort, enCardId,
                                       s_astCIMaXParam[enCIPort].astCardParam[enCardId].bTSByPass);
        }
    }

    return HI_SUCCESS;
}

/* Get Read/Write status: FR/DA/RE/WE */
HI_S32 CIMAX_PCCD_GetRWStatus(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, HI_U8 *pu8Value)
{
    /* Change to IO access mode. */
    CIMAX_PCCD_SetAccessMode(enCIPort, enCardId, HI_UNF_CI_PCCD_ACCESS_IO);
    return CIMAX_ReadIOByte(s_astCIMaXParam[enCIPort].u32SMIBitWidth,
                            s_astCIMaXParam[enCIPort].u32SMIBaseAddr,
                            s_astCIMaXParam[enCIPort].astCardParam[enCardId].u32IOBaseAddress + COM_STAT_REG,
                            pu8Value);
}

/* TS ByPass */
HI_S32 CIMAX_PCCD_TSByPass(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, HI_BOOL bByPass)
{
    HI_U32 u32Address;
    HI_U8 u8Tmp = 0;

    switch (enCardId)
    {
    case HI_UNF_CI_PCCD_A:
        u32Address = MOD_A_CTRL;
        break;

    case HI_UNF_CI_PCCD_B:
        u32Address = MOD_B_CTRL;
        break;

    default:
        return HI_ERR_CI_INVALID_PARA;
    }

    if (CIMAX_ReadExReg(s_astCIMaXParam[enCIPort].u32I2cNum,
                        s_astCIMaXParam[enCIPort].u8DevAddress,
                        u32Address, &u8Tmp))
    {
        return HI_ERR_CI_REG_READ_ERR;
    }
    else
    {
        if (!bByPass)
        {
            /* Set TSIN valid first */
            u8Tmp |= CIMAX_CARD_TSIN_MASK;
            if (CIMAX_WriteExReg(s_astCIMaXParam[enCIPort].u32I2cNum,
                                 s_astCIMaXParam[enCIPort].u8DevAddress,
                                 u32Address, &u8Tmp))
            {
                return HI_ERR_CI_REG_WRITE_ERR;
            }

            /* Then, set TSOUT valid */
            u8Tmp |= CIMAX_CARD_TSOUT_MASK | CIMAX_CARD_TSIN_MASK;
            if (CIMAX_WriteExReg(s_astCIMaXParam[enCIPort].u32I2cNum,
                                 s_astCIMaXParam[enCIPort].u8DevAddress,
                                 u32Address, &u8Tmp))
            {
                return HI_ERR_CI_REG_WRITE_ERR;
            }

            /* Save ByPass flag */
            s_astCIMaXParam[enCIPort].astCardParam[enCardId].bTSByPass = HI_FALSE;

            /* Save reg value here */
            s_astCIMaXParam[enCIPort].astCardParam[enCardId].u8OldModuleCtrlReg = u8Tmp;
            HI_WARN_CI("Config module control reg: 0x%02x.\n", u8Tmp);
        }
        else
        {
            /* Close TSIN/TSOUT */
            u8Tmp &= ~(CIMAX_CARD_TSOUT_MASK | CIMAX_CARD_TSIN_MASK);
            if (CIMAX_WriteExReg(s_astCIMaXParam[enCIPort].u32I2cNum,
                                 s_astCIMaXParam[enCIPort].u8DevAddress,
                                 u32Address, &u8Tmp))
            {
                return HI_ERR_CI_REG_WRITE_ERR;
            }

            /* Save ByPass flag */
            s_astCIMaXParam[enCIPort].astCardParam[enCardId].bTSByPass = HI_TRUE;

            /* Save reg value here */
            s_astCIMaXParam[enCIPort].astCardParam[enCardId].u8OldModuleCtrlReg = u8Tmp;
            HI_WARN_CI("Config module control reg: 0x%02x.\n", u8Tmp);
        }
    }

    return HI_SUCCESS;
}

/* Switch TS mode */
HI_S32 CIMAX_PCCD_SetTSMode(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId, HI_UNF_CI_TS_MODE_E enTSMode)
{
    HI_U32 u32Address;
    HI_U8 u8Tmp = 0;

    u32Address = TS_CONFIG;

    /* Unlock */
    u8Tmp = 0x00;
    if (HI_SUCCESS != CIMAX_WriteExReg(s_astCIMaXParam[enCIPort].u32I2cNum, 
                                       s_astCIMaXParam[enCIPort].u8DevAddress, 
                                       CIM_CTRL, &u8Tmp))
    {
        return HI_ERR_CI_REG_WRITE_ERR;
    }

    switch (enTSMode)
    {
    case HI_UNF_CI_TS_SERIAL:
    default:
        u8Tmp = 0x11;   /* Serial, MSB */
        break;
    case HI_UNF_CI_TS_PARALLEL:
        u8Tmp = 0x00;   /* Parallel */
        break;
    }
    
    /* Configure TS input/output mode */
    if (HI_SUCCESS != CIMAX_WriteExReg(s_astCIMaXParam[enCIPort].u32I2cNum, 
                                       s_astCIMaXParam[enCIPort].u8DevAddress, 
                                       TS_CONFIG, &u8Tmp))
    {
        return HI_ERR_CI_REG_WRITE_ERR;
    }

    /* Lock */
    u8Tmp = 0x01;
    if (HI_SUCCESS != CIMAX_WriteExReg(s_astCIMaXParam[enCIPort].u32I2cNum, 
                                       s_astCIMaXParam[enCIPort].u8DevAddress, 
                                       CIM_CTRL, &u8Tmp))
    {
        return HI_ERR_CI_REG_WRITE_ERR;
    }

    return HI_SUCCESS;
}

/*
 * Power ON/OFF
 * Notice: Current solution only support power control on CI Port, but not for each PCCD.
 * So, if you call power off but some cards are present, will don't power down but return HI_SUCCESS.
 */
HI_S32 CIMAX_PCCD_CtrlPower(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId,
                            HI_UNF_CI_PCCD_CTRLPOWER_E enCtrlPower)
{
    HI_U8 u8Tmp = 0;
    HI_UNF_CI_PCCD_E enCard;
    HI_UNF_CI_PCCD_STATUS_E enStatus;

    /* If find any card present, can't power off. */
    if (HI_UNF_CI_PCCD_CTRLPOWER_OFF == enCtrlPower)
    {
        for (enCard = HI_UNF_CI_PCCD_A; enCard < HI_UNF_CI_PCCD_BUTT; enCard++)
        {
            enStatus = HI_UNF_CI_PCCD_STATUS_ABSENT;
            CIMAX_PCCD_Detect(enCIPort, enCard, &enStatus);

            /* Card present */
            if (HI_UNF_CI_PCCD_STATUS_PRESENT == enStatus)
            {
                return HI_SUCCESS;
            }
        }
    }

    /* Get lock status */
    if (CIMAX_ReadExReg(s_astCIMaXParam[enCIPort].u32I2cNum,
                        s_astCIMaXParam[enCIPort].u8DevAddress,
                        CIM_CTRL, &u8Tmp))
    {
        return HI_ERR_CI_REG_READ_ERR;
    }
    else
    {
        /* If LOCK==1, allow to control power */
        if (u8Tmp & 0x01)
        {
            if (CIMAX_ReadExReg(s_astCIMaXParam[enCIPort].u32I2cNum,
                                s_astCIMaXParam[enCIPort].u8DevAddress,
                                PWR_CTRL, &u8Tmp))
            {
                return HI_ERR_CI_REG_READ_ERR;
            }

            switch (enCtrlPower)
            {
            case HI_UNF_CI_PCCD_CTRLPOWER_ON:

                /* Set power bit 1 to power ON */
                u8Tmp = u8Tmp | CIMAX_POWER_BIT;
                break;

            case HI_UNF_CI_PCCD_CTRLPOWER_OFF:

                /* Set power bit 0 to power OFF */
                u8Tmp = u8Tmp & (~CIMAX_POWER_BIT);
                break;

            default:
                return HI_ERR_CI_INVALID_PARA;
            }

            if (CIMAX_WriteExReg(s_astCIMaXParam[enCIPort].u32I2cNum,
                                 s_astCIMaXParam[enCIPort].u8DevAddress,
                                 PWR_CTRL, &u8Tmp))
            {
                return HI_ERR_CI_REG_WRITE_ERR;
            }
        }
        /*
         * If LOCK!=1, forbid to control power
         * If power off after standby, it will come here.
         */
        else
        {
            return HI_ERR_CI_CANNOT_POWEROFF;
        }
    }

    return HI_SUCCESS;
}

/* Low Power */
HI_S32 CIMAX_Standby(HI_UNF_CI_PORT_E enCIPort)
{
    HI_U8 u8Tmp = 0;

    /* STANDBY bit: 1 */
    u8Tmp = CIMAX_STANDBY_BIT;
    if (CIMAX_WriteExReg(s_astCIMaXParam[enCIPort].u32I2cNum,
                         s_astCIMaXParam[enCIPort].u8DevAddress,
                         CIM_CTRL, &u8Tmp))
    {
        return HI_ERR_CI_REG_WRITE_ERR;
    }

    return HI_SUCCESS;
}

/* Resume CI */
HI_S32 CIMAX_Resume(HI_UNF_CI_PORT_E enCIPort)
{
    HI_U8 u8Tmp = 0;

    /* LOCK bit: 1 */
    u8Tmp = CIMAX_WAKEUP;
    if (CIMAX_WriteExReg(s_astCIMaXParam[enCIPort].u32I2cNum,
                         s_astCIMaXParam[enCIPort].u8DevAddress,
                         CIM_CTRL, &u8Tmp))
    {
        return HI_ERR_CI_REG_WRITE_ERR;
    }

    return HI_SUCCESS;
}

HI_S32 CIMAX_PCCD_GetAccessMode(HI_UNF_CI_PORT_E enCIPort,
                                HI_UNF_CI_PCCD_E enCardId, HI_UNF_CI_PCCD_ACCESSMODE_E *penAccessMode)
{
    HI_U32 u32Address;
    HI_U8 u8Tmp  = 0;
    HI_U8 u8Bit2 = 0;
    HI_U8 u8Bit3 = 0;

    switch (enCardId)
    {
    case HI_UNF_CI_PCCD_A:
        u32Address = MOD_A_CTRL;
        break;

    case HI_UNF_CI_PCCD_B:
        u32Address = MOD_B_CTRL;
        break;

    default:
        return HI_ERR_CI_INVALID_PARA;
    }

    /* Read control reg */
    if (CIMAX_ReadExReg(s_astCIMaXParam[enCIPort].u32I2cNum,
                        s_astCIMaXParam[enCIPort].u8DevAddress,
                        u32Address, &u8Tmp))
    {
        return HI_ERR_CI_REG_READ_ERR;
    }

    /* Get bit */
    u8Bit2 = u8Tmp & CIMAX_ACCESS_MODE_MASK_0;
    u8Bit3 = u8Tmp & CIMAX_ACCESS_MODE_MASK_1;

    if ((!u8Bit2) && (!u8Bit3))
    {
        *penAccessMode = HI_UNF_CI_PCCD_ACCESS_ATTR;
    }
    else if ((u8Bit2) && (!u8Bit3))
    {
        *penAccessMode = HI_UNF_CI_PCCD_ACCESS_IO;
    }
    else if ((!u8Bit2) && (u8Bit3))
    {
        *penAccessMode = HI_UNF_CI_PCCD_ACCESS_COMMON;
    }
    else
    {
        *penAccessMode = HI_UNF_CI_PCCD_ACCESS_BUTT;
    }

    return HI_SUCCESS;
}

HI_S32 CIMAX_PCCD_GetBypassMode(HI_UNF_CI_PORT_E enCIPort,
                            HI_UNF_CI_PCCD_E enCardId, HI_BOOL *bBypass)
{
    HI_U32 u32Address;
    HI_U8 u8Tmp = 0;
    HI_U8 u8TSINBit  = 0;
    HI_U8 u8TSOUTBit = 0;

    switch (enCardId)
    {
    case HI_UNF_CI_PCCD_A:
        u32Address = MOD_A_CTRL;
        break;

    case HI_UNF_CI_PCCD_B:
        u32Address = MOD_B_CTRL;
        break;

    default:
        return HI_ERR_CI_INVALID_PARA;
    }

    /* Read control reg */
    if (CIMAX_ReadExReg(s_astCIMaXParam[enCIPort].u32I2cNum,
                        s_astCIMaXParam[enCIPort].u8DevAddress,
                        u32Address, &u8Tmp))
    {
        return HI_ERR_CI_REG_READ_ERR;
    }

    /* Get bit */
    u8TSINBit  = u8Tmp & CIMAX_CARD_TSIN_MASK;
    u8TSOUTBit = u8Tmp & CIMAX_CARD_TSOUT_MASK;

    if ((!u8TSINBit) && (!u8TSOUTBit))
    {
        *bBypass = HI_TRUE;
    }
    else if ((u8TSINBit) && (u8TSOUTBit))
    {
        *bBypass = HI_FALSE;
    }
    else
    {
        return HI_ERR_CI_UNKONWN;
    }

    return HI_SUCCESS;
}

HI_S32 CIMAX_PCCD_SetAttr(HI_UNF_CI_PORT_E enCIPort, HI_UNF_CI_PCCD_E enCardId,
                          CI_PCCD_ATTR_S *pstAttr)
{
    HI_U32 u32Address;
    HI_U8 u8Tmp = 0;

    s_astCIMaXParam[enCIPort].astCardParam[enCardId].stAttr = *pstAttr;

    /* Unsupport switch card voltage now */

    /* Switch card attribute read/write speed */
    u32Address = (HI_UNF_CI_PCCD_A==enCardId) ? ACCESS_TIME_REG_A : ACCESS_TIME_REG_B;
    switch (pstAttr->enSpeed)
    {
    case CI_PCCD_SPEED_600NS:
    default:
        u8Tmp = 0x04;
        break;
    case CI_PCCD_SPEED_250NS:
        u8Tmp = 0x03;
        break;
    case CI_PCCD_SPEED_200NS:
        u8Tmp = 0x02;
        break;
    case CI_PCCD_SPEED_150NS:
        u8Tmp = 0x01;
        break;
    case CI_PCCD_SPEED_100NS:
        u8Tmp = 0x00;
        break;
    }

    if (CIMAX_WriteExReg(s_astCIMaXParam[enCIPort].u32I2cNum,
                         s_astCIMaXParam[enCIPort].u8DevAddress,
                         u32Address, &u8Tmp))
    {
        return HI_ERR_CI_REG_WRITE_ERR;
    }
    return HI_SUCCESS;
}

/*********************************** END ************************************************/
