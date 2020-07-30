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
#include "hi_board.h"

/* Drv headers */
#include "drv_amp_private.h"
#include "drv_amp_ioctl.h"

#include "amp_i2s.h"

#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif
#endif /* __cplusplus */

/***************************** Static Definition *****************************/

DECLARE_MUTEX(g_AmpMutex);

static AMP_GLOBAL_PARAM_S s_stAmpDrv =
{
    .atmOpenCnt            = ATOMIC_INIT(0),
};

static AMP_DRV_FUNC_S* pfnAMPFunc;
/****************************** Static Function *********************************/

static HI_S32 AMP_ReadProc(struct seq_file *p, HI_VOID *pData)
{
    HI_S32 s32Ret = -1;

    if(!pfnAMPFunc) {
        HI_FATAL_AMP("Amp has not initilized\n");
        return HI_FAILURE;
    }

    s32Ret = pfnAMPFunc->pfnAmpReadProc(p, pData);
    if(HI_FAILURE == s32Ret)
    {
        HI_FATAL_AMP("pfnAmpWriteProc failed\n");
        return HI_FAILURE;
    }

    return HI_SUCCESS;
}

static HI_S32 AMP_WriteProc(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
{
    HI_S32 s32Ret = -1;

    if(!pfnAMPFunc) {
        HI_FATAL_AMP("Amp has not initilized\n");
        return HI_FAILURE;
    }

    s32Ret = pfnAMPFunc->pfnAmpWriteProc(file, buf, count, ppos);

    return s32Ret;
}


static HI_S32 AMP_RegChanProc(HI_VOID)
{
    DRV_PROC_ITEM_S* pstItem;

    /* Create proc */
    pstItem = HI_DRV_PROC_AddModule("amp", HI_NULL, HI_NULL);
    if (!pstItem)
    {
        HI_FATAL_AMP("Create audio AMP proc fail!\n");
        return HI_FAILURE;
    }

    pstItem->read  = AMP_ReadProc;
    pstItem->write = AMP_WriteProc;

    HI_INFO_AMP("Create proc for audio AMP OK!\n");

    return HI_SUCCESS;
}

static HI_VOID AMP_UnRegChanProc(HI_VOID)
{
    HI_DRV_PROC_RemoveModule("amp");

    return;
}

static HI_S32 AMP_OpenDev(HI_VOID)
{
    return HI_SUCCESS;
}

static HI_S32 AMP_CloseDev(HI_VOID)
{
    return HI_SUCCESS;
}

static HI_S32 AMP_Ioctl(struct inode* inode, struct file* file, HI_U32 cmd, HI_VOID* arg)
{
    HI_S32 s32Ret = HI_SUCCESS;

    switch (cmd)
    {
        case CMD_AMP_INIT:
        {
            AMP_INFO_S *pstAmpInfo = (AMP_INFO_S*)arg;
            AMP_DRV_Init(pstAmpInfo);
            break;
        }
        case CMD_AMP_SETMUTE:
        {
            HI_BOOL bMute = *(HI_BOOL*)arg;
            if(!pfnAMPFunc)
            {
                HI_ERR_AMP("Amp is not initialized! \n");
                return -1;
            }
            s32Ret = pfnAMPFunc->pfnAmpSetMute(bMute);
            break;
        }

        case CMD_AMP_GETMUTE:
        {
            HI_BOOL* pbMute = (HI_BOOL*)arg;
            if(!pfnAMPFunc)
            {
                HI_ERR_AMP("Amp is not initialized! \n");
                return -1;
            }
            s32Ret = pfnAMPFunc->pfnAmpGetMute(pbMute);
            break;
        }

        case CMD_AMP_SETSUBWOOFERVOL:
        {
            HI_U32 u32Volume = *(HI_U32*)arg;
            if(!pfnAMPFunc)
            {
                HI_ERR_AMP("Amp is not initialized! \n");
                return -1;
            }
            s32Ret = pfnAMPFunc->pfnAmpSetSubWooferVol(u32Volume);
            break;
        }

        case CMD_AMP_GETSUBWOOFERVOL:
        {
            HI_U32* pu32Volume = (HI_U32*)arg;
            if(!pfnAMPFunc)
            {
                HI_ERR_AMP("Amp is not initialized! \n");
                return -1;
            }
            s32Ret = pfnAMPFunc->pfnAmpGetSubWooferVol(pu32Volume);
            break;
        }

        case CMD_AMP_WRITEREG:
        {
            AMP_REG_OPERATE_PARAM_S_PTR pstRegParam = (AMP_REG_OPERATE_PARAM_S_PTR)arg;
            if(!pfnAMPFunc)
            {
                HI_ERR_AMP("Amp is not initialized! \n");
                return -1;
            }
            s32Ret = pfnAMPFunc->pfnAmpWriteReg(pstRegParam->u32RegAddr, pstRegParam->u32ByteSize, pstRegParam->pu8Value);
            break;
        }

        case CMD_AMP_READREG:
        {
            AMP_REG_OPERATE_PARAM_S_PTR pstRegParam = (AMP_REG_OPERATE_PARAM_S_PTR)arg;
            if(!pfnAMPFunc)
            {
                HI_ERR_AMP("Amp is not initialized! \n");
                return -1;
            }
            s32Ret = pfnAMPFunc->pfnAmpReadReg(pstRegParam->u32RegAddr, pstRegParam->u32ByteSize, pstRegParam->pu8Value);
            break;
        }

        default:
        {
            s32Ret = HI_FAILURE;
            HI_ERR_AMP("unknown custom audio AMP cmd: 0x%x\n", cmd);
            break;
        }
    }

    return s32Ret;
}

/******************************Extern Function *********************************/
HI_S32 AMP_DRV_RegisterProc()
{
    return AMP_RegChanProc();
}
HI_VOID AMP_DRV_UnRegisterProc(HI_VOID)
{
    AMP_UnRegChanProc();
    return;
}
long AMP_DRV_Ioctl(struct file* file, HI_U32 cmd, unsigned long arg)
{
    long s32Ret = HI_SUCCESS;

    s32Ret = down_interruptible(&g_AmpMutex);

    //cmd process
    s32Ret = (long)HI_DRV_UserCopy(file->f_dentry->d_inode, file, cmd, arg, AMP_Ioctl);

    up(&g_AmpMutex);

    return s32Ret;
}

HI_S32 AMP_DRV_Open(struct inode* inode, struct file*  filp)
{
    HI_S32 s32Ret;

    s32Ret = down_interruptible(&g_AmpMutex);

    if (atomic_inc_return(&s_stAmpDrv.atmOpenCnt) == 1)
    {
        /* Init device */
        if (HI_SUCCESS != AMP_OpenDev())
        {
            HI_FATAL_AMP("AMP_OpenDev err!\n");
            goto err;
        }
    }

    up(&g_AmpMutex);
    return HI_SUCCESS;

err:
    atomic_dec(&s_stAmpDrv.atmOpenCnt);
    up(&g_AmpMutex);
    return HI_FAILURE;
}

HI_S32 AMP_DRV_Release(struct inode* inode, struct file*  filp)
{
    long s32Ret = HI_SUCCESS;

    s32Ret = down_interruptible(&g_AmpMutex);

    /* Not the last close, only close the channel match with the 'filp' */
    if (atomic_dec_return(&s_stAmpDrv.atmOpenCnt) != 0)
    {}
    /* Last close */
    else
    {
        AMP_CloseDev();
    }

    up(&g_AmpMutex);
    return HI_SUCCESS;
}

HI_S32 AMP_DRV_Suspend(PM_BASEDEV_S* pdev, pm_message_t state)
{
    AMP_DRV_Exit();
    HI_PRINT("AMP suspend OK\n");

    return HI_SUCCESS;
}

HI_S32 AMP_DRV_Resume(PM_BASEDEV_S* pdev)
{
    HI_S32 s32Ret;

    if(!pfnAMPFunc)
    {
        HI_ERR_AMP("Amp is not initialized! \n");
        return -1;
    }

    AMP_DRV_RegisterProc();

    s32Ret = down_interruptible(&g_AmpMutex);

    /* Get I2C functions */
    s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_I2C, (HI_VOID**)&s_stAmpDrv.pI2CFunc);

    if (HI_SUCCESS != s32Ret)
    {
        HI_FATAL_AMP("Get i2c function err:%#x!\n", s32Ret);
        goto err1;
    }

    if (HI_SUCCESS != HI_DRV_MODULE_GetFunction(HI_ID_GPIO, (HI_VOID**)&s_stAmpDrv.pGpioFunc))
    {
        HI_ERR_AMP("Get gpio function err\n");
        goto err1;
    }

    s32Ret = pfnAMPFunc->pfnAmpResume((AMP_GLOBAL_PARAM_S *)&s_stAmpDrv);
    if (HI_SUCCESS != s32Ret)
    {
        HI_FATAL_AMP("Amp Resume err:%#x!\n", s32Ret);
        goto err1;
    }

    up(&g_AmpMutex);

    HI_PRINT("AMP resume OK\n");

    return HI_SUCCESS;

err1:
    HI_DRV_MODULE_UnRegister(HI_ID_AMP);
    up(&g_AmpMutex);

    return s32Ret;
}



HI_S32 AMP_DRV_Init(AMP_INFO_S *pstAmpInfo)

{
    HI_S32 s32Ret;

    /* Get I2C functions */
    s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_I2C, (HI_VOID**)&s_stAmpDrv.pI2CFunc);
    if (HI_SUCCESS != s32Ret)
    {
        HI_FATAL_AMP("Get i2c function err:%#x!\n", s32Ret);
        goto err1;
    }

    if (HI_SUCCESS != HI_DRV_MODULE_GetFunction(HI_ID_GPIO, (HI_VOID**)&s_stAmpDrv.pGpioFunc))
    {
        HI_ERR_AMP("Get gpio function err\n");
        goto err1;
    }

    if(pstAmpInfo->u8DeviceType == HI_DRV_AMP_ANALOG)
    {
#ifdef HI_BOARD_AMP_PW_ON_GPIO
        s_stAmpDrv.u32ResetGPIONum       = (HI_U32)pstAmpInfo->u8ResetGPIONum;
        s_stAmpDrv.u32ResetPolarity      = (HI_U32)pstAmpInfo->u8ResetPolarity;
#else
        s_stAmpDrv.u32ResetGPIONum       = 0;
        s_stAmpDrv.u32ResetPolarity      = 0;
#endif
        s_stAmpDrv.u32HWMuteGPIONum      = (HI_U32)pstAmpInfo->u8HWMuteGPIONum;
        s_stAmpDrv.u32HWMutePolarity     = (HI_U32)pstAmpInfo->u8HWMutePolarity;
        s_stAmpDrv.u32I2CNum             = 0;
        s_stAmpDrv.u8DeviceAddr          = 0;
        s_stAmpDrv.u32GPIOOutputPolarity = (HI_U32)pstAmpInfo->u8GPIOOutputPolarity;
        s_stAmpDrv.u8DeviceType          = pstAmpInfo->u8DeviceType;
    }
    else{
        s_stAmpDrv.u32ResetGPIONum       = pstAmpInfo->u8ResetGPIONum;
        s_stAmpDrv.u32ResetPolarity      = pstAmpInfo->u8ResetPolarity;
        s_stAmpDrv.u32HWMuteGPIONum      = (HI_U32)pstAmpInfo->u8HWMuteGPIONum;
        s_stAmpDrv.u32HWMutePolarity     = (HI_U32)pstAmpInfo->u8HWMutePolarity;
        s_stAmpDrv.u32I2CNum             = (HI_U32)pstAmpInfo->u8I2CNum;
        s_stAmpDrv.u8DeviceAddr          = pstAmpInfo->u8DeviceAddr;
        s_stAmpDrv.u32GPIOOutputPolarity = (HI_U32)pstAmpInfo->u8GPIOOutputPolarity;
        s_stAmpDrv.u8DeviceType          = pstAmpInfo->u8DeviceType;
    }

    switch (pstAmpInfo->u8DeviceType)
    {
        case HI_DRV_AMP_TAS5707:
        {
            extern AMP_DRV_FUNC_S stTas5707Func;
            pfnAMPFunc = &stTas5707Func;
            break;
        }

        case HI_DRV_AMP_TAS5711:
        {
            extern AMP_DRV_FUNC_S stTas5711Func;
            pfnAMPFunc = &stTas5711Func;
            break;
        }

        case HI_DRV_AMP_NTP8214:
        {
            extern AMP_DRV_FUNC_S stNTP8214Func;
            pfnAMPFunc = &stNTP8214Func;
            break;
        }

        case HI_DRV_AMP_NTP8212:
        {
            extern AMP_DRV_FUNC_S stNTP8212Func;
            pfnAMPFunc = &stNTP8212Func;
            break;
        }

        case HI_DRV_AMP_RT9107B:
        {
            extern AMP_DRV_FUNC_S stRt9107bFunc;
            pfnAMPFunc = &stRt9107bFunc;
            break;
        }

        case HI_DRV_AMP_ALC1310:
        {
            extern AMP_DRV_FUNC_S stAlc1310Func;
            pfnAMPFunc = &stAlc1310Func;
            break;
        }

        case HI_DRV_AMP_AD83586:
        {
            extern AMP_DRV_FUNC_S stAd83586Func;
            pfnAMPFunc = &stAd83586Func;
            break;
        }

        case HI_DRV_AMP_ANALOG:
        {
            extern AMP_DRV_FUNC_S stAnalogAMPFunc;
            pfnAMPFunc = &stAnalogAMPFunc;
            break;
        }
        case HI_DRV_AMP_AD82584:
        {
            extern AMP_DRV_FUNC_S stAd82584Func;
            pfnAMPFunc = &stAd82584Func;
            break;
        }

        default:
        {
            HI_FATAL_AMP("Amp init err: AMP type not define\n");
            goto err1;
            break;
        }
    }
    s32Ret = pfnAMPFunc->pfnAmpInit((AMP_GLOBAL_PARAM_S *)&s_stAmpDrv);

    return s32Ret;

err1:
    HI_DRV_MODULE_UnRegister(HI_ID_AMP);
    up(&g_AmpMutex);

    return s32Ret;
}

HI_VOID AMP_DRV_Exit(HI_VOID)
{
    HI_S32 s32Ret;

    if(!pfnAMPFunc)
    {
        HI_ERR_AMP("Amp is not initialized! \n");
        return;
    }

    s32Ret = down_interruptible(&g_AmpMutex);
    pfnAMPFunc->pfnAmpDeinit();
    s_stAmpDrv.pGpioFunc = HI_NULL;
    s_stAmpDrv.pI2CFunc = HI_NULL;


    AMP_UnRegChanProc();
    up(&g_AmpMutex);

    return;
}

#ifdef __cplusplus
#if __cplusplus
}
#endif
#endif /* End of #ifdef __cplusplus */
