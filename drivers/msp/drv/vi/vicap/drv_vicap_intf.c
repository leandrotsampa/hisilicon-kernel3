/******************************************************************************

  Copyright (C), 2012-2050, Hisilicon Tech. Co., Ltd.

 ******************************************************************************
  File Name     : drv_vicap_intf.c
  Version       : Initial Draft
  Author        : Hisilicon multimedia software group
  Created       : 2013/11/14
  Description   : 
  History       :
  1.Date        : 2013/11/14
    Author      : w00248302
    Modification: Created file
******************************************************************************/
#include <linux/init.h>
#include <linux/module.h>
#include <linux/ioctl.h>
#include <asm/uaccess.h>
#include <linux/fs.h>
#include <linux/err.h>
#include <linux/slab.h>

#include "hi_drv_module.h"
#include "hi_kernel_adapt.h"
#include "hi_drv_dev.h"
#include "hi_drv_vicap.h"
#include "drv_vicap.h"
#include "drv_vicap_ext.h"
#include "hi_drv_proc.h"
#include "drv_vicap_ioctl.h"
#include "hi_osal.h"


VICAP_EXPORT_FUNC_S  g_VicapExtFuncs = 
{
    .pfnVicapCreate = HI_DRV_VICAP_Create,
    .pfnVicapDestroy = HI_DRV_VICAP_Destroy,
    .pfnVicapStart = HI_DRV_VICAP_Start,
    .pfnVicapStop = HI_DRV_VICAP_Stop,
    .pfnVicapAcquireFrame = HI_DRV_VICAP_AcquireFrame,
    .pfnVicapReleaseFrame = HI_DRV_VICAP_ReleaseFrame,
    .pfnVicapGetOutputAttr = HI_DRV_VICAP_GetOutputAttr,
    .pfnVicapSetOutputAttr = HI_DRV_VICAP_SetOutputAttr,
    .pfnVicapUserAcquireFrame = HI_DRV_VICAP_UserAcquireFrame,
    .pfnVicapUserReleaseFrame = HI_DRV_VICAP_UserReleaseFrame,
    .pfnVicapSetExtBuf = HI_DRV_VICAP_SetExtBuf,
    .pfnVicapRegistHook = HI_DRV_VICAP_RegistHook
};

static HI_S32 VICAP_DRV_Open(struct inode *node, struct file *filp)
{
    return HI_SUCCESS;
}

static HI_S32 VICAP_DRV_Close(struct inode *node, struct file *filp)
{
    return HI_SUCCESS;
}
HI_S32 VICAP_DRV_Suspend(PM_BASEDEV_S *pdev, pm_message_t state)
{
    return HI_SUCCESS;
}

HI_S32 VICAP_DRV_Resume(PM_BASEDEV_S *pdev)
{
    return HI_SUCCESS;
}

static HI_S32 VicapDrvIoctl(struct inode *inode, struct file *filp, unsigned int cmd, HI_VOID *arg)
{
    HI_S32 s32Ret;

    switch (cmd)
        {
        case CMD_VICAP_CREATE:
        {
            VICAP_CREATE_S *pstCreate;
            pstCreate = (VICAP_CREATE_S *)arg;
            s32Ret = HI_DRV_VICAP_Create(&pstCreate->stVicapAttr, &pstCreate->hVicap);
            break;
        }
        case CMD_VICAP_DESTROY:
        {
            HI_HANDLE hVicap;
            hVicap = *(HI_HANDLE *)arg;
            s32Ret = HI_DRV_VICAP_Destroy(hVicap);
            break;
        }
        case CMD_VICAP_START:
        {
            HI_HANDLE hVicap;
            hVicap = *(HI_HANDLE *)arg;
            s32Ret = HI_DRV_VICAP_Start(hVicap);
            break;
        }
        case CMD_VICAP_STOP:
        {
            HI_HANDLE hVicap;
            hVicap = *(HI_HANDLE *)arg;
            s32Ret = HI_DRV_VICAP_Stop(hVicap);
            break;
        }
        case CMD_VICAP_GETOUTPUTATTR:
        {
            VICAP_OUTPUT_ATTR_S *pstOutAttr;
            pstOutAttr = (VICAP_OUTPUT_ATTR_S*)arg;
            s32Ret = HI_DRV_VICAP_GetOutputAttr(pstOutAttr->hVicap, &pstOutAttr->stVicapOutAttr);
            break;
        }
        case CMD_VICAP_SETOUTPUTATTR:
        {
            VICAP_OUTPUT_ATTR_S *pstOutAttr;
            pstOutAttr = (VICAP_OUTPUT_ATTR_S*)arg;
            s32Ret = HI_DRV_VICAP_SetOutputAttr(pstOutAttr->hVicap, &pstOutAttr->stVicapOutAttr);
            break;
        }
        case CMD_VICAP_ACQUIREFRAME:
        {
            VICAP_FRAME_S *pVicapFrame;
            pVicapFrame = (VICAP_FRAME_S *)arg;
            s32Ret = HI_DRV_VICAP_AcquireFrame(pVicapFrame->hVicap, &pVicapFrame->stVicapFrame);
            break;
        }
        case CMD_VICAP_RELEASEFRAME:
        {
            VICAP_FRAME_S *pVicapFrame;
            pVicapFrame = (VICAP_FRAME_S *)arg;
            s32Ret = HI_DRV_VICAP_ReleaseFrame(pVicapFrame->hVicap, &pVicapFrame->stVicapFrame);
            break;
        }
        case CMD_VICAP_USERACQUIREFRAME:
        {
            VICAP_FRAME_S *pVicapFrame;
            pVicapFrame = (VICAP_FRAME_S *)arg;
            s32Ret = HI_DRV_VICAP_UserAcquireFrame(pVicapFrame->hVicap, &pVicapFrame->stVicapFrame, pVicapFrame->u32TimeoutMs);
            break;
        }
        case CMD_VICAP_USERRELEASEFRAME:
        {
            VICAP_FRAME_S *pVicapFrame;
            pVicapFrame = (VICAP_FRAME_S *)arg;
            s32Ret = HI_DRV_VICAP_UserReleaseFrame(pVicapFrame->hVicap, &pVicapFrame->stVicapFrame);
            break;
        }
        case CMD_VICAP_SET_EXTBUF:
        {
            VICAP_BUFFER_ATTR_S *pBufferAttr;
            pBufferAttr = (VICAP_BUFFER_ATTR_S *)arg;
            s32Ret = HI_DRV_VICAP_SetExtBuf(pBufferAttr->hVicap, &pBufferAttr->stBufAttr);
            break;
        }
        default:
        {
            HI_ERR_VICAP("vicap cmd value err, cmd=%x\n", cmd);
            s32Ret = HI_FAILURE;
            break;
        }
        }

    return s32Ret;
}

long VICAP_DRV_Ioctl(struct file *file, unsigned int cmd, unsigned long arg)
{
    HI_S32 s32Ret;

    s32Ret = HI_DRV_UserCopy(file->f_dentry->d_inode, file, cmd, arg, VicapDrvIoctl);
    
    return s32Ret;
}

static struct file_operations s_stVicapFileOps =
{
    .owner          = THIS_MODULE,
    .open           = VICAP_DRV_Open,
    .release        = VICAP_DRV_Close,
    .unlocked_ioctl = VICAP_DRV_Ioctl,
};

static PM_BASEOPS_S  s_stVicapDrvOps = {
    .probe        = NULL,
    .remove       = NULL,
    .shutdown     = NULL,
    .prepare      = NULL,
    .complete     = NULL,
    .suspend      = VICAP_DRV_Suspend,
    .suspend_late = NULL,
    .resume_early = NULL,
    .resume       = VICAP_DRV_Resume,
};

static UMAP_DEVICE_S s_stVicapDev =
{
    .minor      = UMAP_MIN_MINOR_VICAP,
    .owner      = THIS_MODULE,
    .fops       = &s_stVicapFileOps,
    .drvops     = &s_stVicapDrvOps,
};


HI_S32 VICAP_DRV_ModInit(HI_VOID)
{
    HI_S32 s32Ret = 0;    

    HI_OSAL_Snprintf(s_stVicapDev.devfs_name, HIMEDIA_DEVICE_NAME_MAX_LEN, "%s", UMAP_DEVNAME_VICAP);
    s32Ret = HI_DRV_DEV_Register(&s_stVicapDev);
    if (s32Ret != HI_SUCCESS)
    {
        HI_ERR_DEV("Vicap Device Register Fail!\n");
        return s32Ret;
    }
    
    s32Ret = HI_DRV_MODULE_Register(HI_ID_VICAP, "HI_VICAP", &g_VicapExtFuncs);
    if (s32Ret != HI_SUCCESS)
    {
        HI_ERR_VICAP("HI_DRV_MODULE_Register failed, mode ID = 0x%08X\n", HI_ID_VICAP);
        HI_DRV_DEV_UnRegister(&s_stVicapDev);
        return HI_FAILURE;
    }

    HI_DRV_VICAP_Init();        
#ifdef MODULE
    HI_PRINT("Load hi_vicap.ko success.\t\t(%s)\n", VERSION_STRING);
#endif

    return HI_SUCCESS;
}

HI_VOID VICAP_DRV_ModExit(HI_VOID)
{
    HI_DRV_VICAP_DeInit();
    HI_DRV_PROC_RemoveModule(HI_MOD_VICAP);
    HI_DRV_MODULE_UnRegister(HI_ID_VICAP); 
    HI_DRV_DEV_UnRegister(&s_stVicapDev);
#ifdef MODULE
    HI_PRINT("remove hi_vicap.ko success.\t\t(%s)\n", VERSION_STRING);
#endif
}

#ifdef MODULE
module_init(VICAP_DRV_ModInit);
module_exit(VICAP_DRV_ModExit);
#endif

MODULE_AUTHOR("HISILICON");
MODULE_LICENSE("GPL");

