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
#include "hi_drv_mmz.h"
#include "hi_drv_stat.h"
#include "hi_drv_sys.h"
#include "hi_drv_proc.h"

/* Drv headers */
#include "drv_aflt_ext.h"
#include "drv_aflt_private.h"

#ifdef __cplusplus
 #if __cplusplus
extern "C" {
 #endif
#endif /* #ifdef __cplusplus */

static struct file_operations s_stDevFileOpts = 
{
    .owner          = THIS_MODULE,
    .unlocked_ioctl = AFLT_DRV_Ioctl,
    .open           = AFLT_DRV_Open,
    .release        = AFLT_DRV_Release,
#ifdef CONFIG_COMPAT
    .compat_ioctl   = AFLT_DRV_Ioctl,        //?|━：a3??：：?32Bit App|━?ioctl
#endif
};

static PM_BASEOPS_S s_stDrvOps = 
{
    .probe        = NULL,
    .remove       = NULL,
    .shutdown     = NULL,
    .prepare      = NULL,
    .complete     = NULL,
    .suspend      = AFLT_DRV_Suspend,
    .suspend_late = NULL,
    .resume_early = NULL,
    .resume       = AFLT_DRV_Resume,
};

static AFLT_REGISTER_PARAM_S s_stProcParam = 
{
    .pfnReadProc  = AFLT_DRV_ReadProc,
    .pfnWriteProc = AFLT_DRV_WriteProc,     
};

/* the attribute struct of audio filter device */
static UMAP_DEVICE_S s_stAfltUmapDev;

static __inline__ HI_S32 AFLT_DRV_RegisterDev(HI_VOID)
{
    snprintf(s_stAfltUmapDev.devfs_name, sizeof(s_stAfltUmapDev.devfs_name), UMAP_DEVNAME_AFLT);
    s_stAfltUmapDev.fops    = &s_stDevFileOpts;
    s_stAfltUmapDev.minor   = UMAP_MIN_MINOR_AFLT;
    s_stAfltUmapDev.owner   = THIS_MODULE;
    s_stAfltUmapDev.drvops  = &s_stDrvOps;
    if (HI_DRV_DEV_Register(&s_stAfltUmapDev) < 0)
    {
        HI_FATAL_AFLT("FATAL: register aflt device failed\n");
        return HI_FAILURE;
    }

    return HI_SUCCESS;
}

static __inline__ HI_VOID AFLT_DRV_UnRegisterDev(HI_VOID)
{
    /*unregister aenc chn device*/
    HI_DRV_DEV_UnRegister(&s_stAfltUmapDev);
}

HI_S32 AFLT_DRV_ModInit(HI_VOID)
{
    HI_S32 ret;
    
#ifndef HI_MCE_SUPPORT
    ret = AFLT_DRV_Init();
    if (HI_SUCCESS != ret)
    {
        HI_FATAL_AFLT("Init aflt drv fail!\n");
        return HI_FAILURE;
    }
#endif

    ret = AFLT_DRV_RegisterProc(&s_stProcParam);
    if (HI_SUCCESS != ret)
    {
        HI_FATAL_AFLT("Reg aflt proc fail!\n");
        return HI_FAILURE;
    }

    ret = AFLT_DRV_RegisterDev();
    if (HI_SUCCESS != ret)
    {
        AFLT_DRV_UnRegisterProc();
        HI_FATAL_AFLT("Reg aflt dev fail!\n");
        return HI_FAILURE;
    }

#ifdef MODULE
    HI_PRINT("Load hi_aflt.ko success.\t(%s)\n", VERSION_STRING);
#endif

    return HI_SUCCESS;
}

HI_VOID AFLT_DRV_ModExit(HI_VOID)
{
    AFLT_DRV_UnRegisterDev();
    AFLT_DRV_UnRegisterProc();

#ifndef HI_MCE_SUPPORT
    AFLT_DRV_Exit();
#endif

    return;
}

#ifdef MODULE
module_init(AFLT_DRV_ModInit);
module_exit(AFLT_DRV_ModExit);
#endif

MODULE_AUTHOR("HISILICON");
MODULE_LICENSE("GPL");

#ifdef __cplusplus
 #if __cplusplus
}
 #endif
#endif /* End of #ifdef __cplusplus */
