/******************************************************************************

  Copyright (C), 2012-2014, Hisilicon Tech. Co., Ltd.

 ******************************************************************************
  File Name     : drv_vi_intf.c
  Version       : Initial Draft
  Author        : Hisilicon multimedia software group
  Created       : 2013/11/14
  Description   : 
  History       :
  1.Date        : 2013/11/14
    Author      : c00186004
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
#include "hi_drv_proc.h"
#include "hi_kernel_adapt.h"
#include "hi_drv_dev.h"
#include "drv_sif_ioctl.h"
#include "hal_sif.h"
#include "drv_sif.h"
#include "hi_osal.h"
#include "drv_sif_private.h"

static atomic_t g_SIFModInitFlag = ATOMIC_INIT(0);
static UMAP_DEVICE_S g_stSifDevice;

static struct file_operations s_stAdemodFileOps = 
{
    .owner          = THIS_MODULE,
    .unlocked_ioctl = SIF_DRV_Ioctl,
    .open           = SIF_DRV_Open,
    .release        = SIF_DRV_Close,
};

static PM_BASEOPS_S s_stDemodDrvOps =
{
    .probe        = NULL,
    .remove       = NULL,
    .shutdown     = NULL,
    .prepare      = NULL,
    .complete     = NULL,
    .suspend      = SIF_DRV_Suspend,
    .suspend_late = NULL,
    .resume_early = NULL,
    .resume       = SIF_DRV_Resume,
};

HI_S32 __init SIF_DRV_ModInit(HI_VOID)
{   
    HI_S32 s32Ret = HI_FAILURE;
    DRV_PROC_ITEM_S*  pProcItem = HI_NULL;

    s32Ret = HI_OSAL_Snprintf(g_stSifDevice.devfs_name, sizeof(g_stSifDevice.devfs_name),
                           "%s", UMAP_DEVNAME_SIF);
    if (0 == s32Ret)
    {
        HI_ERR_SIF("HI_OSAL_Snprintf failed\n");
        return HI_FAILURE;
    }
    
	g_stSifDevice.fops   = &s_stAdemodFileOps;
	g_stSifDevice.minor  = UMAP_MIN_MINOR_SIF; 
    g_stSifDevice.owner  = THIS_MODULE;
    g_stSifDevice.drvops = &s_stDemodDrvOps;
    
    s32Ret = HI_DRV_DEV_Register(&g_stSifDevice);
    if (s32Ret != HI_SUCCESS)
    {          
        SIF_TRACE(HI_SIF_EMERG,"SIF register failed\n");
        goto err_dev;
    }

    s32Ret = HI_DRV_MODULE_Register(HI_ID_SIF, UMAP_DEVNAME_SIF,
                                    HI_NULL);
    if (HI_SUCCESS != s32Ret)
    {
        SIF_TRACE(HI_SIF_EMERG,"ADEMOD register failed\n");
        goto err_mod;
    }

    pProcItem = HI_DRV_PROC_AddModule(UMAP_DEVNAME_SIF, HI_NULL, HI_NULL);
    if (pProcItem == HI_NULL)
    {
        SIF_TRACE(HI_SIF_EMERG,"ADEMOD register failed\n");
        goto err_proc;
    }
    
    pProcItem->read  = SIF_DRV_ReadProc;
    
    atomic_inc(&g_SIFModInitFlag);
    
    HI_PRINT("Load hi_sif.ko success.\t\t(%s)\n", VERSION_STRING);
	return HI_SUCCESS;
    
 err_proc:
     HI_DRV_MODULE_UnRegister(HI_ID_SIF);
 err_mod:  
    HI_DRV_DEV_UnRegister(&g_stSifDevice);    
 err_dev:    
    return HI_FAILURE;
}

HI_VOID __exit SIF_DRV_ModExit(HI_VOID)
{      
    HI_DRV_MODULE_UnRegister(HI_ID_SIF);
    HI_DRV_PROC_RemoveModule(UMAP_DEVNAME_SIF);
    HI_DRV_DEV_UnRegister(&g_stSifDevice); 
    
    atomic_dec(&g_SIFModInitFlag);
}

#ifdef MODULE
module_init(SIF_DRV_ModInit);
module_exit(SIF_DRV_ModExit);
#endif

MODULE_AUTHOR("HISILICON");
MODULE_LICENSE("GPL");

