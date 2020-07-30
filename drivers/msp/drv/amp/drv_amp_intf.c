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
#include "hi_drv_amp.h"
#include "drv_amp_ext.h"
#include "drv_amp_private.h"

#ifdef HI_AMP_LINUX_CFG
#include "drv_amp_ioctl.h"
#endif

#ifdef __cplusplus
 #if __cplusplus
extern "C" {
 #endif
#endif /* #ifdef __cplusplus */

static struct file_operations s_stDevFileOpts =
{
    .owner          = THIS_MODULE,
    .unlocked_ioctl = AMP_DRV_Ioctl,
#ifdef CONFIG_COMPAT
    .compat_ioctl   = AMP_DRV_Ioctl,        //?|━：a3??：：?32Bit App|━?ioctl
#endif
    .open           = AMP_DRV_Open,
    .release        = AMP_DRV_Release,
};

static PM_BASEOPS_S s_stDrvOps =
{
    .probe        = NULL,
    .remove       = NULL,
    .shutdown     = NULL,
    .prepare      = NULL,
    .complete     = NULL,
    .suspend      = AMP_DRV_Suspend,
    .suspend_late = NULL,
    .resume_early = NULL,
    .resume       = AMP_DRV_Resume,
};
/* the attribute struct of audio filter device */
static UMAP_DEVICE_S s_stAfltUmapDev;

static __inline__ HI_S32 AMP_DRV_RegisterDev(HI_VOID)
{
    snprintf(s_stAfltUmapDev.devfs_name, sizeof(s_stAfltUmapDev.devfs_name), UMAP_DEVNAME_AMP);
    s_stAfltUmapDev.fops    = &s_stDevFileOpts;
    s_stAfltUmapDev.minor   = UMAP_MIN_MINOR_AMP;
    s_stAfltUmapDev.owner   = THIS_MODULE;
    s_stAfltUmapDev.drvops  = &s_stDrvOps;
    if (HI_DRV_DEV_Register(&s_stAfltUmapDev) < 0)
    {
        HI_FATAL_AMP("FATAL: register amp device failed\n");
        return HI_FAILURE;
    }

    return HI_SUCCESS;
}

static __inline__ HI_VOID AMP_DRV_UnRegisterDev(HI_VOID)
{
    /*unregister aenc chn device*/
    HI_DRV_DEV_UnRegister(&s_stAfltUmapDev);
}

HI_S32 AMP_DRV_ModInit(HI_VOID)
{
    HI_S32 ret;

#ifdef HI_AMP_LINUX_CFG
#if defined(CHIP_TYPE_hi3751v620)
	AMP_INFO_S stAmpInfo = {0};
	stAmpInfo.u8I2CNum			 = 0;
	stAmpInfo.u8DeviceType 		 = HI_DRV_AMP_TAS5707;
	stAmpInfo.u8DeviceAddr 		 = HI_DRV_AMP_I2C_ADDR_TAS5707_H;
	stAmpInfo.u8ResetGPIONum	 = 18*8 + 7;
	stAmpInfo.u8ResetPolarity 	 = 0;
	stAmpInfo.u8HWMuteGPIONum 	 = 19*8 + 5;
	stAmpInfo.u8HWMutePolarity	 = 0;
	stAmpInfo.u8GPIOOutputPolarity = 0;
	
	AMP_DRV_Init(&stAmpInfo);
#endif
#endif

    ret = AMP_DRV_RegisterProc(/*&s_stProcParam*/);
    if (HI_SUCCESS != ret)
    {
        HI_FATAL_AMP("Reg amp proc fail!\n");
        return HI_FAILURE;
    }

    ret = AMP_DRV_RegisterDev();
    if (HI_SUCCESS != ret)
    {
        AMP_DRV_UnRegisterProc();
        HI_FATAL_AMP("Reg amp dev fail!\n");
        return HI_FAILURE;
    }

#ifdef MODULE
    HI_PRINT("Load hi_amp.ko success.\t(%s)\n", VERSION_STRING);
#endif

    return HI_SUCCESS;
}

HI_VOID AMP_DRV_ModExit(HI_VOID)
{
    AMP_DRV_UnRegisterDev();
    AMP_DRV_UnRegisterProc();

    AMP_DRV_Exit();

    return;
}

#ifdef MODULE
module_init(AMP_DRV_ModInit);
module_exit(AMP_DRV_ModExit);
#endif

MODULE_AUTHOR("HISILICON");
MODULE_LICENSE("GPL");

#ifdef __cplusplus
 #if __cplusplus
}
 #endif
#endif /* End of #ifdef __cplusplus */
