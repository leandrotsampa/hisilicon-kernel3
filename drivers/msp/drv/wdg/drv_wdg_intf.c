/*********************************************************************************
*
*  Copyright (C) 2014 Hisilicon Technologies Co., Ltd.  All rights reserved.
*
*  This program is confidential and proprietary to Hisilicon Technologies Co., Ltd.
*  (Hisilicon), and may not be copied, reproduced, modified, disclosed to
*  others, published or used, in whole or in part, without the express prior
*  written permission of Hisilicon.
*
***********************************************************************************/

#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/types.h>
#include <linux/timer.h>
#include <linux/miscdevice.h>
//#include <linux/watchdog.h>
#include <linux/fs.h>
#include <linux/notifier.h>
#include <linux/reboot.h>
#include <linux/init.h>
#include <asm/uaccess.h>
#include <asm/io.h>
#include <linux/kthread.h>
#include <linux/string.h>
#include <linux/interrupt.h>

//#include "himedia.h"
#include "drv_wdg_ioctl.h"
#include "drv_wdg.h"
#include "hi_common.h"
#include "hi_reg_common.h"

#include "hi_module.h"
#include "hi_drv_module.h"
#include "hi_drv_sys.h"
#include "hi_drv_dev.h"

#include "drv_wdg_ext.h"

#define WDG_CLK_HZ (24 * 1000 * 1000)  /* select crystal,freq fix:24M*/

#if    defined(CHIP_TYPE_hi3716cv200)   \
    || defined(CHIP_TYPE_hi3716mv400)   \
    || defined(CHIP_TYPE_hi3718cv100)   \
    || defined(CHIP_TYPE_hi3719cv100)   \
    || defined(CHIP_TYPE_hi3718mv100)   \
    || defined(CHIP_TYPE_hi3719mv100)

    #define HIWDG0_BASE     0xF8A2C000
    #define HIWDG1_BASE     0xF8A2D000

    static unsigned int g_au32RegBase[HI_WDG_NUM] =
    {
        HIWDG0_BASE,
        HIWDG1_BASE,
    };
#elif  defined(CHIP_TYPE_hi3716mv410)   \
    || defined(CHIP_TYPE_hi3716mv420)   \
    || defined(CHIP_TYPE_hi3798mv100)   \
    || defined(CHIP_TYPE_hi3796mv100)   \
    || defined(CHIP_TYPE_hi3798cv200)

    #define HIWDG0_BASE     0xF8A2C000

    static unsigned int g_au32RegBase[HI_WDG_NUM] =
    {
        HIWDG0_BASE,
    };
#endif

static unsigned char *g_IoRegBase[HI_WDG_NUM];

#define HIWDG_LOAD      0x000
#define HIWDG_VALUE     0x004
#define HIWDG_CTRL      0x008
#define HIWDG_INTCLR    0x00C
#define HIWDG_RIS       0x010
#define HIWDG_MIS       0x014
#define HIWDG_LOCK      0xC00

#define HIWDG_UNLOCK_VAL 0x1ACCE551

static unsigned long wdg_load[HI_WDG_NUM];
static unsigned long wdg_value[HI_WDG_NUM];
static unsigned long wdg_ris[HI_WDG_NUM];
static unsigned long wdg_mis[HI_WDG_NUM];

static unsigned long g_bWdgPmocing[HI_WDG_NUM];

/* debug */
//#define HIDOG_PFX "HiDog: "

/* module param */
#define HIDOG_TIMER_MARGIN (60)  /*60 Second*/
static int default_margin = HIDOG_TIMER_MARGIN; /* in second */
module_param(default_margin, int, 0);

/* local var */
static DEFINE_SPINLOCK(hidog_lock);
static int cur_margin[HI_WDG_NUM];

static unsigned long driver_open = 0;
static int options[HI_WDG_NUM]; //WDIOS_ENABLECARD;
static HI_S32 wdg_pm_suspend (PM_BASEDEV_S *pdev, pm_message_t state);
static HI_S32 wdg_pm_resume (PM_BASEDEV_S *pdev);

static WDG_EXT_FUNC_S g_stWdgExtFuncs =
{
    .pfnWdgSuspend      = wdg_pm_suspend,
    .pfnWdgResume       = wdg_pm_resume
};

static unsigned long hiwdt_readl(unsigned int u32wdgIndex, unsigned int u32offset)
{
    unsigned long value = 0;

    if (u32wdgIndex < HI_WDG_NUM)
    {
        value = readl(g_IoRegBase[u32wdgIndex] + u32offset);
    }

    return value;
}

static void hiwdt_writel(unsigned long value, unsigned int u32wdgIndex, unsigned int u32offset)
{
    if (u32wdgIndex < HI_WDG_NUM)
    {
        
        writel(value, (g_IoRegBase[u32wdgIndex] + u32offset));
    }
}

static void hidog_set_timeout(unsigned int wdgindex,unsigned int nr)
{
    unsigned long flags;
    int cnt = nr;

    spin_lock_irqsave(&hidog_lock, flags);

    if (nr == 0)
    {
        cnt = ~0x0;
    }

    //HI_INFO_WDG("set timeout cnt=0x%x\n", cnt);

    /* unlock watchdog registers */
    hiwdt_writel(HIWDG_UNLOCK_VAL, wdgindex, HIWDG_LOCK);
    hiwdt_writel(cnt, wdgindex,HIWDG_LOAD);
    hiwdt_writel(cnt, wdgindex,HIWDG_VALUE);

    /* lock watchdog registers */
    hiwdt_writel(0, wdgindex,HIWDG_LOCK);
    spin_unlock_irqrestore(&hidog_lock, flags);
};

static void hidog_feed(unsigned int wdgindex)
{
    unsigned long flags;

    spin_lock_irqsave(&hidog_lock, flags);

    /* unlock watchdog registers */
    hiwdt_writel(HIWDG_UNLOCK_VAL, wdgindex, HIWDG_LOCK);

    /* clear watchdog */
    hiwdt_writel(0x00, wdgindex, HIWDG_INTCLR);

    /* lock watchdog registers */
    hiwdt_writel(0, wdgindex, HIWDG_LOCK);
    spin_unlock_irqrestore(&hidog_lock, flags);
};

static void hidog_reset_board(unsigned int wdgindex)
{
    unsigned long flags;

    spin_lock_irqsave(&hidog_lock, flags);

    /* unlock watchdog registers */
    hiwdt_writel(HIWDG_UNLOCK_VAL, wdgindex, HIWDG_LOCK);

    /** set load value */
    hiwdt_writel(1, wdgindex, HIWDG_LOAD);

    /* clear watchdog */
    hiwdt_writel(0x00, wdgindex, HIWDG_INTCLR);

    /* lock watchdog registers */
    hiwdt_writel(0, wdgindex, HIWDG_LOCK);
	
    spin_unlock_irqrestore(&hidog_lock, flags);
}

/* parameter : timeout time by second*/
static int hidog_set_heartbeat(unsigned int wdgindex, int t)
{
    int ret = 0;
    unsigned int u32WdgLoad;

    if (t > ((0xffffffff / WDG_CLK_HZ) * 2))
    {
        //HI_INFO_WDG("too large timeout value, then set to 0xffffffff\n");
        u32WdgLoad = 0xffffffff;
        cur_margin[wdgindex] = ((0xffffffff / WDG_CLK_HZ) * 2);
    }
    else
    {
        /* crystal :24M, calculate out initial value */
        u32WdgLoad = WDG_CLK_HZ / 2 * t;

        //HI_INFO_WDG("set wdg timeout clk cnt: 0x%x\n", u32WdgLoad);
        cur_margin[wdgindex] = t;
    }

    hidog_set_timeout(wdgindex, u32WdgLoad);
    hidog_feed(wdgindex);

    return ret;
}

static void hidog_start(unsigned int wdgindex)
{
    unsigned long flags;

    //  unsigned long t;

    spin_lock_irqsave(&hidog_lock, flags);

    /* unlock watchdog registers */
    hiwdt_writel(HIWDG_UNLOCK_VAL, wdgindex, HIWDG_LOCK);
    hiwdt_writel(0x00, wdgindex, HIWDG_CTRL);
    hiwdt_writel(0x00, wdgindex, HIWDG_INTCLR);
    hiwdt_writel(0x03, wdgindex, HIWDG_CTRL);

    /* lock watchdog registers */
    hiwdt_writel(0, wdgindex, HIWDG_LOCK);

    /* use soft to control WDG reset, can not open
       0: not send reset signal, 1: send reset signal by WDG_RST pin */

    spin_unlock_irqrestore(&hidog_lock, flags);

    options[wdgindex] = WDIOS_ENABLECARD;
}

static void hidog_stop(unsigned int wdgindex)
{
    unsigned long flags;
    U_SC_WDG_RST_CTRL uTmpValue;

    //  unsigned long t;

    spin_lock_irqsave(&hidog_lock, flags);

    /* disable watchdog clock */
    uTmpValue.u32 = g_pstRegSysCtrl->SC_WDG_RST_CTRL.u32;
    uTmpValue.bits.wdg_rst_ctrl = 0;
    g_pstRegSysCtrl->SC_WDG_RST_CTRL.u32 = uTmpValue.u32;

    /* unlock watchdog registers */
    hiwdt_writel(HIWDG_UNLOCK_VAL, wdgindex, HIWDG_LOCK);

    /* stop watchdog timer */
    hiwdt_writel(0x00, wdgindex, HIWDG_CTRL);
    hiwdt_writel(0x00, wdgindex, HIWDG_INTCLR);

    /* lock watchdog registers */
    hiwdt_writel(0, wdgindex, HIWDG_LOCK);

    spin_unlock_irqrestore(&hidog_lock, flags);

    hidog_set_timeout(wdgindex, 0);

    options[wdgindex] = WDIOS_DISABLECARD;
}

static int hidog_open(struct inode *inode, struct file *file)
{
    int ret = 0;
    unsigned int wdgindex;

    if (test_and_set_bit(0, &driver_open))
    {
        return -EBUSY;
    }

    /*
     *  Activate timer
     */
    for (wdgindex = 0; wdgindex < HI_WDG_NUM; wdgindex++)
    {
        hidog_feed(wdgindex);
    }

    return ret;
}

static int hidog_release(struct inode *inode, struct file *file)
{
    unsigned int wdgindex;
    clear_bit(0, &driver_open);
    for (wdgindex = 0; wdgindex < HI_WDG_NUM; wdgindex++)
    {    	
        hidog_stop(wdgindex);
    }
    return 0;
}

static long hidog_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
{
    void __user *argp = (void __user *)arg;
    int __user *p = argp;

    switch (cmd)
    {
        case WDIOC_KEEP_ALIVE:
        {
            int index = 0;

            if (get_user(index, p))
            {
                return -EFAULT;
            }

            hidog_feed(index);
        }

        return 0;

        case WDIOC_SET_TIMEOUT:
        {
            WDG_TIMEOUT_S stTimeout;

            if (copy_from_user(&stTimeout, (WDG_TIMEOUT_S*)arg, sizeof(WDG_TIMEOUT_S)))
            {
                return -EFAULT;
            }

            if (hidog_set_heartbeat(stTimeout.u32WdgIndex, stTimeout.s32Timeout))
            {
                return -EINVAL;
            }

            hidog_feed(stTimeout.u32WdgIndex);
        }

        return 0;

        case WDIOC_GET_TIMEOUT:
        {
            WDG_TIMEOUT_S stTimeout;

            if (copy_from_user(&stTimeout, (WDG_TIMEOUT_S*)arg, sizeof(WDG_TIMEOUT_S)))
            {
                return -EFAULT;
            }

            if (stTimeout.u32WdgIndex >= HI_WDG_NUM)
            {
                return HI_FAILURE;
            }

            stTimeout.s32Timeout = cur_margin[stTimeout.u32WdgIndex];

            return copy_to_user((WDG_TIMEOUT_S*)arg, &stTimeout, sizeof(WDG_TIMEOUT_S));
        }

        case WDIOC_SET_OPTIONS:
        {
            WDG_OPTION_S stOption;

            if (copy_from_user(&stOption, (WDG_OPTION_S*)arg, sizeof(WDG_OPTION_S)))
            {
                return -EFAULT;
            }

            if (stOption.u32WdgIndex >= HI_WDG_NUM)
            {
                return HI_FAILURE;
            }

            if (stOption.s32Option == WDIOS_ENABLECARD)
            {
                hidog_set_heartbeat(stOption.u32WdgIndex, cur_margin[stOption.u32WdgIndex]);
                hidog_start(stOption.u32WdgIndex);

                return 0;
            }
            else if (stOption.s32Option == WDIOS_DISABLECARD)
            {
                hidog_stop(stOption.u32WdgIndex);
                return 0;
            }
            else if (stOption.s32Option == WDIOS_RESET_BOARD)
            {
                if (options[stOption.u32WdgIndex] != WDIOS_ENABLECARD)
                {
                    return HI_FAILURE;
                }

                hidog_reset_board(stOption.u32WdgIndex);
                return 0;
            }
            else
            {
                return -WDIOS_UNKNOWN;
            }
        }

    default:
        return -ENOIOCTLCMD;
    }
}

/*
 *  Kernel Interfaces
 */

static struct file_operations hidog_fops =
{
    .owner   = THIS_MODULE,
    .llseek  = no_llseek,

    //  .write      = hidog_write,
    .unlocked_ioctl   = hidog_ioctl,
#ifdef CONFIG_COMPAT    
	.compat_ioctl = hidog_ioctl,
#endif    
    .open    = hidog_open,
    .release = hidog_release,
};

static HI_S32 wdg_pm_suspend (PM_BASEDEV_S *pdev, pm_message_t state)
{
    unsigned int wdgindex;

    for (wdgindex = 0; wdgindex < HI_WDG_NUM; wdgindex++)
    {
        if (WDIOS_ENABLECARD == options[wdgindex])
        {
            wdg_ris[wdgindex]   = hiwdt_readl(wdgindex, HIWDG_RIS);
            wdg_mis[wdgindex]   = hiwdt_readl(wdgindex, HIWDG_MIS);
            wdg_load[wdgindex]  = hiwdt_readl(wdgindex, HIWDG_LOAD);
            wdg_value[wdgindex] = hiwdt_readl(wdgindex, HIWDG_VALUE); //After resume, the time of timeout will continue(subtract the time consume before suspend)
            //HI_INFO_WDG("> %s: [%d], 0x%x, wdg_mis=0x%x\n", __FUNCTION__, __LINE__, wdg_ris, wdg_mis);
            //HI_INFO_WDG("> %s: [%d], 0x%x, wdg_value=0x%x\n", __FUNCTION__, __LINE__, wdg_load, wdg_value);
            if ((0 != wdg_ris[wdgindex]) && (0 != wdg_mis[wdgindex])) //have already produce one interrupt
            {
                wdg_value[wdgindex] = wdg_value[wdgindex] / 2;
            }
            else
            {
                wdg_value[wdgindex] = (wdg_load[wdgindex] + wdg_value[wdgindex]) / 2;
            }

            options[wdgindex] = WDIOS_DISABLECARD; //WDIOS_ENABLECARD;
            hidog_stop(wdgindex);
            g_bWdgPmocing[wdgindex] = 1;
        }
    }

    return 0;
}

static HI_S32 wdg_pm_resume(PM_BASEDEV_S *pdev)
{
    unsigned int wdgindex;

    for (wdgindex = 0; wdgindex < HI_WDG_NUM; wdgindex++)
    {
        if ((WDIOS_DISABLECARD == options[wdgindex]) && (1 == g_bWdgPmocing[wdgindex]))
        {
            hidog_set_timeout(wdgindex, wdg_value[wdgindex]);
            hidog_feed(wdgindex);

            hidog_start(wdgindex);
        }
    }

    //wdg_value = hiwdt_readl(HIWDG_VALUE);
    //HI_INFO_WDG("> %s: [%d], 0x%x, wdg_value=0x%x\n", __FUNCTION__, __LINE__, wdg_load, wdg_value);
    return 0;
}

static PM_BASEOPS_S wdg_baseOps = {
    .probe        = NULL,
    .remove       = NULL,
    .shutdown     = NULL,
    .prepare      = NULL,
    .complete     = NULL,
    .suspend      = wdg_pm_suspend,
    .suspend_late = NULL,
    .resume_early = NULL,
    .resume       = wdg_pm_resume
};


static UMAP_DEVICE_S g_WdgRegisterData;

HI_S32 WDG_DRV_ModInit(HI_VOID)
{
    int ret = 0;
    unsigned int wdgindex;

    (HI_VOID)HI_DRV_MODULE_Register(HI_ID_WDG, "HI_WDG", (HI_VOID *)&g_stWdgExtFuncs);

    for (wdgindex = 0; wdgindex < HI_WDG_NUM; wdgindex++)
    {
        cur_margin[wdgindex] = default_margin;
        g_bWdgPmocing[wdgindex] = HI_FALSE;
        options[wdgindex] = WDIOS_DISABLECARD;

		g_IoRegBase[wdgindex] = (unsigned char *)ioremap_nocache(g_au32RegBase[wdgindex], 0x1000);
	    if(g_IoRegBase[wdgindex] == HI_NULL)
	    {
	   		HI_ERR_WDG("ioremap_nocache map error\n");
        	return -EFAULT;;
	    }

        /* Check that the default_margin value is within it's range ; if not reset to the default */
        hidog_set_heartbeat(wdgindex, default_margin);
    }

    snprintf(g_WdgRegisterData.devfs_name, sizeof(g_WdgRegisterData.devfs_name), UMAP_DEVNAME_WDG);
    g_WdgRegisterData.minor = UMAP_MIN_MINOR_WDG;
    g_WdgRegisterData.owner = THIS_MODULE;
    g_WdgRegisterData.fops   = &hidog_fops;
    g_WdgRegisterData.drvops = &wdg_baseOps;
    if (HI_DRV_DEV_Register(&g_WdgRegisterData) < 0)
    {
        //HI_INFO_WDG (KERN_ERR HIDOG_PFX "HI_DRV_DEV_Register err (err=%d)\n", ret);
        return HI_FAILURE;
    }

#ifdef MODULE
    HI_PRINT("Load hi_wdg.ko success   \t(%s)\n", VERSION_STRING);
#endif

    return ret;
}

HI_VOID WDG_DRV_ModExit(HI_VOID)
{
    unsigned int wdgindex;

    HI_DRV_MODULE_UnRegister(HI_ID_WDG);

    HI_DRV_DEV_UnRegister(&g_WdgRegisterData);

    for (wdgindex = 0; wdgindex < HI_WDG_NUM; wdgindex++)
    {
        hidog_set_timeout(wdgindex, 0);
		iounmap(g_IoRegBase[wdgindex]);
		g_IoRegBase[wdgindex] = HI_NULL;
    }
}

#ifdef MODULE
module_init(WDG_DRV_ModInit);
module_exit(WDG_DRV_ModExit);
#endif

MODULE_AUTHOR("HISILICON");
MODULE_DESCRIPTION("Hisilicon Watchdog Device Driver");
MODULE_LICENSE("GPL");
