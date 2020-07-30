/***********************************************************************************
*              Copyright 2004 - 2014, Hisilicon Tech. Co., Ltd.
*                           ALL RIGHTS RESERVED
* FileName:
* Description: driver aiao common header
*
* History:
* Version   Date         Author         DefectNum    Description
* main\1       AudioGroup     NULL         Create this file.
***********************************************************************************/
#ifndef __DRV_SIF_PRIVATE_H__
#define __DRV_SIF_PRIVATE_H__

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
#include "hi_drv_proc.h"
#include "hi_module.h"
#include "drv_sif_ioctl.h"
#include "hal_sif.h"
#include "drv_sif.h"
#include "hi_osal.h"
#include "drv_sif_private.h"


typedef struct tagSIF_REGISTER_PARAM_S
{
    DRV_PROC_READ_FN  pfnReadProc;
    DRV_PROC_WRITE_FN pfnWriteProc;
} SIF_REGISTER_PARAM_S;

typedef struct hiSIF_GLOBAL_RESOURCE_S
{ 
    HI_U32                      u32BitFlag_SIF;
}SIF_GLOBAL_RESOURCE_S;


HI_S32 SIF_DRV_Open(struct inode *finode, struct file  *ffile);
long   SIF_DRV_Ioctl(struct file *file, HI_U32 cmd, unsigned long arg);
HI_S32 SIF_DRV_Close(struct inode *finode, struct file  *ffile);
HI_S32 SIF_DRV_Init(HI_VOID);
HI_VOID SIF_DRV_Exit(HI_VOID);
HI_S32 SIF_DRV_ReadProc( struct seq_file* p, HI_VOID* v );
HI_S32 SIF_DRV_Suspend(PM_BASEDEV_S * pdev,pm_message_t   state);
HI_S32 SIF_DRV_Resume(PM_BASEDEV_S * pdev); 

#ifdef __cplusplus
 #if __cplusplus
}
 #endif
#endif /* __cplusplus */

#endif 

