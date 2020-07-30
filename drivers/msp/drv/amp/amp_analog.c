/*********************************************************************

Copyright (C), 2001-2011, Hisilicon Tech. Co., Ltd.

**********************************************************************
File Name     :    amp_analog.c
Version         :    Initial    Draft
Author         :    l00191026
Created         :    2015/7/16
Last Modified:
Description   :    analog amp Driver
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

#define AMP_DEBUG         (0)

static AMP_GLOBAL_PARAM_S* pstAnalogAMPDrv = HI_NULL;

static HI_S32 AMP_SetMute(HI_BOOL bMute);

#ifdef HI_BOARD_AMP_PW_ON_GPIO
static HI_VOID AMPReset(HI_BOOL bReset)
{
    HI_S32 s32Ret;

    if (pstAnalogAMPDrv == HI_NULL)
    {
        HI_ERR_AMP("analog amp no Init! \n");
        return;
    }

    if (pstAnalogAMPDrv->pGpioFunc== HI_NULL)
    {
        HI_ERR_AMP("GPIO Function Null \n");
        return;
    }
    if (pstAnalogAMPDrv->pGpioFunc->pfnGpioDirSetBit)
    {
        s32Ret = pstAnalogAMPDrv->pGpioFunc->pfnGpioDirSetBit(pstAnalogAMPDrv->u32ResetGPIONum,
                                      pstAnalogAMPDrv->u32GPIOOutputPolarity);
        if(HI_SUCCESS != s32Ret)
        {
            HI_ERR_AMP("pfnGpioDirSetBit failed\n");
        }
    }

    msleep(1);

    if (pstAnalogAMPDrv->pGpioFunc->pfnGpioWriteBit)
    {
        if (bReset)
        {
            s32Ret = pstAnalogAMPDrv->pGpioFunc->pfnGpioWriteBit(pstAnalogAMPDrv->u32ResetGPIONum,
                                                       pstAnalogAMPDrv->u32ResetPolarity);
            if(HI_SUCCESS != s32Ret)
            {
                HI_ERR_AMP("pfnGpioWriteBit failed, line = %d\n", __LINE__);
            }
        }
        else
        {
            s32Ret = pstAnalogAMPDrv->pGpioFunc->pfnGpioWriteBit(pstAnalogAMPDrv->u32ResetGPIONum,
                                                       !(pstAnalogAMPDrv->u32ResetPolarity));
            if(HI_SUCCESS != s32Ret)
            {
                HI_ERR_AMP("pfnGpioWriteBit failed, line = %d\n", __LINE__);
            }
        }
    }

    return;
}
#endif //endif HI_BOARD_AMP_PW_ON_GPIO

static HI_VOID AMPHWMute(HI_BOOL bMute)
{
    HI_S32 s32Ret;

    if (pstAnalogAMPDrv == HI_NULL)
    {
        HI_ERR_AMP("analog amp no Init! \n");
        return;
    }

    if (pstAnalogAMPDrv->pGpioFunc== HI_NULL)
    {
        HI_ERR_AMP("GPIO Function Null, line = %d \n", __LINE__);
        return;
    }
    if (pstAnalogAMPDrv->pGpioFunc->pfnGpioDirSetBit)
    {
        s32Ret = pstAnalogAMPDrv->pGpioFunc->pfnGpioDirSetBit(pstAnalogAMPDrv->u32HWMuteGPIONum,
                                      pstAnalogAMPDrv->u32GPIOOutputPolarity);
        if(HI_SUCCESS != s32Ret)
        {
            HI_ERR_AMP("pfnGpioDirSetBit failed, line = %d\n", __LINE__);
        }
    }

    msleep(1);

    if (pstAnalogAMPDrv->pGpioFunc->pfnGpioWriteBit)
    {
        if (bMute)
        {
            s32Ret = pstAnalogAMPDrv->pGpioFunc->pfnGpioWriteBit(pstAnalogAMPDrv->u32HWMuteGPIONum,
                                                       pstAnalogAMPDrv->u32HWMutePolarity);
            if(HI_SUCCESS != s32Ret)
            {
                HI_ERR_AMP("pfnGpioWriteBit failed, line =%d\n", __LINE__);
            }
        }
        else
        {
            s32Ret = pstAnalogAMPDrv->pGpioFunc->pfnGpioWriteBit(pstAnalogAMPDrv->u32HWMuteGPIONum,
                                                       !(pstAnalogAMPDrv->u32HWMutePolarity));
            if(HI_SUCCESS != s32Ret)
            {
                HI_ERR_AMP("pfnGpioWriteBit failed, line = %d\n", __LINE__);
            }
        }
    }

    return;

}

static HI_S32 AMP_Init(AMP_GLOBAL_PARAM_S* pstAmpDrv)
{
    if (pstAmpDrv == HI_NULL)
    {
        HI_ERR_AMP("Cannot get Any Setting for AnalogAMP! \n");
        return HI_FAILURE;
    }
    else
    {
        pstAnalogAMPDrv = pstAmpDrv;
    }
#ifdef HI_BOARD_AMP_PW_ON_GPIO
    AMPReset(HI_TRUE);
    msleep(10);
#endif

    AMPHWMute(HI_TRUE);
    msleep(10);

    return HI_SUCCESS;
}

static HI_S32 AMP_Resume(AMP_GLOBAL_PARAM_S* pstAmpDrv)
{
    if (pstAmpDrv == HI_NULL)
    {
        HI_ERR_AMP("Cannot get Any Setting for AnalogAMP! \n");
        return HI_FAILURE;
    }
    else
    {
        pstAnalogAMPDrv = pstAmpDrv;
    }

    AMPHWMute(HI_TRUE);
    msleep(10);

#ifdef HI_BOARD_AMP_PW_ON_GPIO
    AMPReset(HI_TRUE);
    msleep(10);
#endif

    AMPHWMute(HI_FALSE);
    msleep(10);

    return HI_SUCCESS;
}
static HI_VOID AMP_DeInit(HI_VOID)
{
    if (pstAnalogAMPDrv == HI_NULL)
    {
        HI_ERR_AMP("TAS5707 is not initialized yet! \n");
        return;
    }

    //Reset AMP
#ifdef HI_BOARD_AMP_PW_ON_GPIO
    AMPReset(HI_FALSE);
#endif

    pstAnalogAMPDrv = HI_NULL;

    return;
}

static HI_S32 AMP_SetMute(HI_BOOL bMute)
{
    if (pstAnalogAMPDrv == HI_NULL)
    {
        HI_ERR_AMP("TAS5707 is not initialized yet! \n");
        return HI_FAILURE;
    }

    if(bMute)
    {
        AMPHWMute(HI_TRUE);
    }
    else
    {
        AMPHWMute(HI_FALSE);
    }

    return HI_SUCCESS;
}

static HI_S32 AMP_GetMute(HI_BOOL* pbMute)
{
    HI_S32 s32Ret;
    HI_U32 u32MuteGPIOPolarity;

    if (pstAnalogAMPDrv == HI_NULL)
    {
        HI_ERR_AMP("TAS5707 is not initialized yet! \n");
        return HI_FAILURE;
    }

    s32Ret = pstAnalogAMPDrv->pGpioFunc->pfnGpioDirSetBit(pstAnalogAMPDrv->u32HWMuteGPIONum, !pstAnalogAMPDrv->u32GPIOOutputPolarity);
    if(HI_SUCCESS != s32Ret)
    {
        HI_ERR_AMP("pfnGpioDirSetBit failed, line = %d\n", __LINE__);
        return HI_FAILURE;
    }

    s32Ret = pstAnalogAMPDrv->pGpioFunc->pfnGpioReadBit(pstAnalogAMPDrv->u32HWMuteGPIONum, &u32MuteGPIOPolarity);
    if(HI_SUCCESS != s32Ret)
    {
        HI_ERR_AMP("pfnGpioDirSetBit failed, line = %d\n", __LINE__);
        return HI_FAILURE;
    }

    if(pstAnalogAMPDrv->u32HWMutePolarity == u32MuteGPIOPolarity)
    {
        *pbMute = HI_TRUE;
    }
    else {
        *pbMute = HI_FALSE;
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
    return HI_SUCCESS;
}

static HI_S32 AMP_ReadReg(HI_U32 u32RegAddr, HI_U32 u32ByteSize, HI_U8* pu8Value)
{
    return HI_SUCCESS;
}

static HI_S32 AMP_Proc(struct seq_file *p, HI_VOID *pData)
{
    if (pstAnalogAMPDrv == HI_NULL)
    {
        HI_ERR_AMP("TAS5707 is not initialized yet! \n");
        return HI_FAILURE;
    }

    PROC_PRINT(p, "AMP Modul:        Analog AMP\n");
    PROC_PRINT(p, "Mute  GPIO Group: %d\n", pstAnalogAMPDrv->u32HWMuteGPIONum/8);
    PROC_PRINT(p, "Mute  GPIO Bit:   %d\n",    pstAnalogAMPDrv->u32HWMuteGPIONum%8);
    PROC_PRINT(p, "Mute  Polarity:   %d\n",    pstAnalogAMPDrv->u32HWMutePolarity);
    PROC_PRINT(p, "Reset GPIO Group: %d\n", pstAnalogAMPDrv->u32ResetGPIONum/8);
    PROC_PRINT(p, "Reset GPIO Bit:   %d\n", pstAnalogAMPDrv->u32ResetGPIONum%8);
    PROC_PRINT(p, "Reset Polarity:   %d\n", pstAnalogAMPDrv->u32ResetPolarity);

    return HI_SUCCESS;
}

AMP_DRV_FUNC_S stAnalogAMPFunc =
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
