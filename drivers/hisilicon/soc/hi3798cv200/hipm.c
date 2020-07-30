#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/pm.h>
#include <linux/suspend.h>
#include <asm/memory.h>
#include <linux/delay.h>
#include <linux/suspend.h>
#include <linux/syscalls.h>
#include <linux/slab.h>
#include <linux/kmemleak.h>
#include <linux/device.h>
#include <linux/irqchip/arm-gic.h>
#ifndef CONFIG_ARM64
#include <mach/hardware.h>
#endif
#include <linux/hikapi.h>
#include <asm/suspend.h>
#include <asm/bug.h>

void __iomem *hi_sc_virtbase;

/**/
#define MCU_START_CTRL  0xf840f000      /* mcu start control */
#define OTP_IDWORD_ADDR 0xf8ab0128      /* OTP shadow register to indicate if it is advca chipset */

extern void *hi_otp_idword_addr;
extern void *hi_mcu_start_ctrl;

asmlinkage int hi_pm_sleep(unsigned long arg);

int (* ca_pm_suspend)(void) = NULL;
EXPORT_SYMBOL(ca_pm_suspend);

/*****************************************************************************/
void do_ca_pm_suspend(void)
{
	BUG_ON(NULL == ca_pm_suspend);

	if (ca_pm_suspend)
		ca_pm_suspend();

	BUG();
}
/*****************************************************************************/

static int hi_pm_suspend(void)
{
	int ret = 0;
#ifdef CONFIG_ARM64
	ret = cpu_suspend(1);
#else
	ret = cpu_suspend(0, hi_pm_sleep);
#endif

	return ret;
}

static int hi_pm_enter(suspend_state_t state)
{
	int ret = 0;
	switch (state) {
	case PM_SUSPEND_STANDBY:
	case PM_SUSPEND_MEM:
		ret = hi_pm_suspend();
		break;
	default:
		ret = -EINVAL;
	}

	return ret;
}

int hi_pm_valid(suspend_state_t state)
{
	return 1;
}

static const struct platform_suspend_ops hi_pm_ops = {
	.enter = hi_pm_enter,
	.valid = hi_pm_valid,
};
/*****************************************************************************/

static int __init hi_pm_init(void)
{
#ifdef CONFIG_ARM
	hi_sc_virtbase = (void __iomem *)IO_ADDRESS(REG_BASE_SCTL);

	hi_otp_idword_addr = (void __iomem *)ioremap_nocache(OTP_IDWORD_ADDR, 0x1000);
	hi_mcu_start_ctrl = (void __iomem *)ioremap_nocache(MCU_START_CTRL, 0x1000);
#endif
	suspend_set_ops(&hi_pm_ops);

	return 0;
}

module_init(hi_pm_init);
