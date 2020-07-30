#include "hi_drv_dev.h"
#include "drv_pmoc_priv.h"
#include "hi_drv_pmoc.h"

#include "hi_drv_module.h"
#include "drv_ao_ext.h"
#ifdef HI_AUDIO_AI_SUPPORT
#include "drv_ai_ext.h"
#endif

#include "drv_hdmi_ext.h"
#include "drv_disp_ext.h"
#include "drv_win_ext.h"
#include "drv_sci_ext.h"
#include "drv_venc_ext.h"
#include "drv_png_ext.h"
#include "drv_jpge_ext.h"
#include "drv_jpeg_ext.h"
#include "drv_wdg_ext.h"
#include "drv_tuner_ext.h"
#include "drv_adsp_ext.h"
#include "drv_cipher_ext.h"
#include "drv_vdec_ext.h"
#include "drv_otp_ext.h"
#include "drv_tde_ext.h"
#include "drv_i2c_ext.h"
#include "drv_gpio_ext.h"
#include "drv_vpss_ext.h"
#include "clock.h"
#include <linux/cpu.h>
#include <asm/io.h>
#include <linux/platform_device.h>

typedef enum
{
    PMOC_HOLD_ETH = 0x0001,   /**<Keep eth working */    /**<CNcomment:网口不下电 */
    PMOC_HOLD_WIFI = 0x0002,  /**<Keep WIFI working */   /**<CNcomment:WIFI不下电 */
    PMOC_HOLD_USB = 0x0004,   /**<Keep USB working */    /**<CNcomment:USB不下电 */
    PMOC_HOLD_TUNER = 0x0008, /**<Keep tuner working */  /**<CNcomment:Tuner不下电 */
    PMOC_HOLD_DEMUX = 0x0010, /**<Keep demux working */  /**<CNcomment:Demux不下电 */
    PMOC_HOLD_SDIO = 0x0020,  /**<Keep SDIO working */   /**<CNcomment:SD卡不下电 */
    PMOC_HOLD_SCI = 0x0040,   /**<Keep SCI working */    /**<CNcomment:SCI不下电 */
    PMOC_HOLD_VENC = 0x0080,  /**<Keep VENC working */   /**<CNcomment:VENC不下电 */
    PMOC_HOLD_PNG = 0x0100,   /**<Keep PNG working */    /**<CNcomment:PNG不下电 */
    PMOC_HOLD_JPGE = 0x0200,  /**<Keep JPGE working */   /**<CNcomment:JPGE不下电 */
    PMOC_HOLD_JPEG = 0x0400,  /**<Keep JPEG working */   /**<CNcomment:JPEG不下电 */
    PMOC_HOLD_WDG = 0x0800,   /**<Keep WDG working */    /**<CNcomment:WDG不下电 */
    PMOC_HOLD_HDMI = 0x1000,  /**<Keep HDMI working */   /**<CNcomment:HDMI不下电 */
    PMOC_HOLD_VO = 0x2000,    /**<Keep VO working */     /**<CNcomment:VO不下电 */
    PMOC_HOLD_DISP = 0x4000,  /**<Keep DISP working */   /**<CNcomment:DISP不下电 */
    PMOC_HOLD_AO = 0x8000,    /**<Keep AO working */     /**<CNcomment:AO不下电 */
    PMOC_HOLD_AI = 0x10000,   /**<Keep AI working */     /**<CNcomment:AI不下电 */
    PMOC_HOLD_ADSP = 0x20000, /**<Keep ADSP working */   /**<CNcomment:ADSP不下电 */
    PMOC_HOLD_CIPHER = 0x40000, /**<Keep CIPHER working */   /**<CNcomment:CIPHER不下电 */
    PMOC_HOLD_VDEC = 0x80000, /**<Keep VDEC working */   /**<CNcomment:VDEC不下电 */
    PMOC_HOLD_VPSS = 0x100000, /**<Keep VPSS working */  /**<CNcomment:VPSS不下电 */
    PMOC_HOLD_OTP = 0x200000, /**<Keep OTP working */    /**<CNcomment:OTP不下电 */
    PMOC_HOLD_TDE = 0x400000, /**<Keep TDE working */    /**<CNcomment:TDE不下电 */
    PMOC_HOLD_I2C = 0x800000, /**<Keep I2C working */    /**<CNcomment:I2C不下电 */
    PMOC_HOLD_GPIO = 0x1000000,/**<Keep GPIO working */  /**<CNcomment:GPIO不下电 */
    PMOC_HOLD_BUTT = 0x80000000,
}PMOC_HOLD_MOD_E;

static HI_U32 g_u32HoldModules = 0x0;

#define PM_LOW_SUSPEND_FLAG   0x5FFFFFFF

#ifdef HI_DVFS_CPU_SUPPORT
extern unsigned int cpu_dvfs_enable;
#endif

#ifdef HI_AVS_SUPPORT
extern void CPU_AVS_Enable(unsigned int enable);
#endif

extern struct clk mpu_ck;
extern int cpu_volt_scale(unsigned int volt);
extern int core_volt_scale(unsigned int volt);

#ifdef CONFIG_HIETH_GMAC
extern int higmac_dev_suspend(struct platform_device *dev, pm_message_t state);
extern int higmac_dev_resume(struct platform_device *dev);
#elif defined(CONFIG_HIETH_SWITCH_FABRIC)
extern int hieth_plat_driver_suspend(struct platform_device *pdev, pm_message_t state);
extern int hieth_plat_driver_resume(struct platform_device *pdev);
#endif

HI_S32 PMEnterSmartStandby(HI_U32 u32HoldModules)
{
    HI_S32 s32Ret;
    pm_message_t state = {0};
    AIAO_EXPORT_FUNC_S *pstAoFunc;
#ifdef HI_AUDIO_AI_SUPPORT
    AI_EXPORT_FUNC_S *pstAiFunc;
#endif
    HDMI_EXPORT_FUNC_S *pstHdmiFunc;
    DISP_EXPORT_FUNC_S *pstDispFunc;
    WIN_EXPORT_FUNC_S *pstWinFunc;

    SCI_EXT_FUNC_S *pstSciFunc;
    VENC_EXPORT_FUNC_S *pstVencFunc;
    PNG_EXPORT_FUNC_S *pstPngFunc;
#if !defined(CHIP_TYPE_hi3719mv100) && !defined(CHIP_TYPE_hi3718mv100) && !defined(CHIP_TYPE_hi3798cv200)
    JPGE_EXPORT_FUNC_S *pstJpgeFunc;
#endif
    //JPEG_EXPORT_FUNC_S *pstJpegFunc;

    WDG_EXT_FUNC_S *pstWdgFunc;
    TUNER_EXPORT_FUNC_S *pstTunerFunc;
    ADSP_EXPORT_FUNC_S *pstAdspFunc;

    CIPHER_EXPORT_FUNC_S *pstCipherFunc;

    VDEC_EXPORT_FUNC_S *pstVdecFunc;
    OTP_EXPORT_FUNC_S *pstOtpFunc;
    //TDE_EXPORT_FUNC_S *pstTdeFunc;
    I2C_EXT_FUNC_S *pstI2cFunc;
    GPIO_EXT_FUNC_S *pstGpioFunc;
    VPSS_EXPORT_FUNC_S *pstVpssFunc;

    g_u32HoldModules = u32HoldModules;

#ifdef HI_DVFS_CPU_SUPPORT
    /* close dvfs, avs */
    cpu_dvfs_enable = HI_FALSE;

 #ifdef HI_AVS_SUPPORT
    CPU_AVS_Enable(HI_FALSE);
 #endif

#endif

    if (0 == (u32HoldModules & PMOC_HOLD_SCI))
    {
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_SCI, (HI_VOID**)&pstSciFunc);
        if ((HI_SUCCESS == s32Ret) && (pstSciFunc && pstSciFunc->pfnSciSuspend))
        {
            if (HI_SUCCESS != pstSciFunc->pfnSciSuspend(HI_NULL, state))
            {
                HI_ERR_PM("SCI suspend fail.\n");
            }
        }
    }

    if (0 == (u32HoldModules & PMOC_HOLD_VENC))
    {
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_VENC, (HI_VOID**)&pstVencFunc);
        if ((HI_SUCCESS == s32Ret) && (pstVencFunc && pstVencFunc->pfnVencSuspend))
        {
            if (HI_SUCCESS != pstVencFunc->pfnVencSuspend())
            {
                HI_ERR_PM("VENC suspend fail.\n");
            }
        }
    }

    if (0 == (u32HoldModules & PMOC_HOLD_PNG))
    {
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_PNG, (HI_VOID**)&pstPngFunc);
        if ((HI_SUCCESS == s32Ret) && (pstPngFunc && pstPngFunc->pfnPngSuspend))
        {
            if (HI_SUCCESS != pstPngFunc->pfnPngSuspend(HI_NULL, state))
            {
                HI_ERR_PM("PNG suspend fail.\n");
            }
        }
    }

#if !defined(CHIP_TYPE_hi3719mv100) && !defined(CHIP_TYPE_hi3718mv100) && !defined(CHIP_TYPE_hi3798cv200)
    if (0 == (u32HoldModules & PMOC_HOLD_JPGE))
    {
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_JPGENC, (HI_VOID**)&pstJpgeFunc);
        if ((HI_SUCCESS == s32Ret) && (pstJpgeFunc && pstJpgeFunc->pfnJpgeSuspend))
        {
            if (HI_SUCCESS != pstJpgeFunc->pfnJpgeSuspend(HI_NULL, state))
            {
                HI_ERR_PM("JPGE suspend fail.\n");
            }
        }
    }
#endif

#if 0 //del for skyplay
    if (0 == (u32HoldModules & PMOC_HOLD_JPEG))
    {
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_JPGDEC, (HI_VOID**)&pstJpegFunc);
        if ((HI_SUCCESS == s32Ret) && (pstJpegFunc && pstJpegFunc->pfnJpegSuspend))
        {
            if (HI_SUCCESS != pstJpegFunc->pfnJpegSuspend(HI_NULL, state))
            {
                HI_ERR_PM("JPEG suspend fail.\n");
            }
        }
    }
#endif

    if (0 == (u32HoldModules & PMOC_HOLD_WDG))
    {
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_WDG, (HI_VOID**)&pstWdgFunc);
        if ((HI_SUCCESS == s32Ret) && (pstWdgFunc && pstWdgFunc->pfnWdgSuspend))
        {
            if (HI_SUCCESS != pstWdgFunc->pfnWdgSuspend(HI_NULL, state))
            {
                HI_ERR_PM("WDG suspend fail.\n");
            }
        }
    }

    if (0 == (u32HoldModules & PMOC_HOLD_TUNER))
    {
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_TUNER, (HI_VOID**)&pstTunerFunc);
        if ((HI_SUCCESS == s32Ret) && (pstTunerFunc && pstTunerFunc->pfnTunerSuspend))
        {
            if (HI_SUCCESS != pstTunerFunc->pfnTunerSuspend(HI_NULL, state))
            {
                HI_ERR_PM("TUNER suspend fail.\n");
            }
        }
    }

    if (0 == (u32HoldModules & PMOC_HOLD_HDMI))
    {
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_HDMI, (HI_VOID**)&pstHdmiFunc);
        if ((HI_SUCCESS == s32Ret) && (pstHdmiFunc && pstHdmiFunc->pfnHdmiSuspend))
        {
            if (HI_SUCCESS != pstHdmiFunc->pfnHdmiSuspend(HI_NULL, state))
            {
                HI_ERR_PM("HDMI suspend fail.\n");
            }
        }
    }

    if (0 == (u32HoldModules & PMOC_HOLD_VO))
    {
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_VO, (HI_VOID**)&pstWinFunc);
        if ((HI_SUCCESS == s32Ret) && (pstWinFunc && pstWinFunc->pfnWinSuspend))
        {
            if (HI_SUCCESS != pstWinFunc->pfnWinSuspend(HI_NULL, state))
            {
                HI_ERR_PM("WIN suspend fail.\n");
            }
        }
    }

    if (0 == (u32HoldModules & PMOC_HOLD_DISP))
    {
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_DISP, (HI_VOID**)&pstDispFunc);
        if ((HI_SUCCESS == s32Ret) && (pstDispFunc && pstDispFunc->pfnDispSuspend))
        {
            if (HI_SUCCESS != pstDispFunc->pfnDispSuspend(HI_NULL, state))
            {
                HI_ERR_PM("DISP suspend fail.\n");
            }
        }
    }

    if (0 == (u32HoldModules & PMOC_HOLD_AO))
    {
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_AO, (HI_VOID**)&pstAoFunc);
        if ((HI_SUCCESS == s32Ret) && (pstAoFunc && pstAoFunc->pfnAO_DrvSuspend))
        {
            state.event = PM_LOW_SUSPEND_FLAG;
            if (HI_SUCCESS != pstAoFunc->pfnAO_DrvSuspend(HI_NULL, state))
            {
                HI_ERR_PM("AO suspend fail.\n");
            }
        }
    }

#ifdef HI_AUDIO_AI_SUPPORT
    if (0 == (u32HoldModules & PMOC_HOLD_AI))
    {
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_AI, (HI_VOID**)&pstAiFunc);
        if ((HI_SUCCESS == s32Ret) && (pstAiFunc && pstAiFunc->pfnAI_DrvSuspend))
        {
            if (HI_SUCCESS != pstAiFunc->pfnAI_DrvSuspend(HI_NULL, state))
            {
                HI_ERR_PM("AI suspend fail.\n");
            }
        }
    }
#endif

    if (0 == (u32HoldModules & PMOC_HOLD_ADSP))
    {
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_ADSP, (HI_VOID**)&pstAdspFunc);
        if ((HI_SUCCESS == s32Ret) && (pstAdspFunc && pstAdspFunc->pfnADSP_DrvSuspend))
        {
            if (HI_SUCCESS != pstAdspFunc->pfnADSP_DrvSuspend(HI_NULL, state))
            {
                HI_ERR_PM("ADSP suspend fail.\n");
            }
        }
    }

    if (0 == (u32HoldModules & PMOC_HOLD_CIPHER))
    {
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_CIPHER, (HI_VOID**)&pstCipherFunc);
        if ((HI_SUCCESS == s32Ret) && (pstCipherFunc && pstCipherFunc->pfnCipherSuspend))
        {
            pstCipherFunc->pfnCipherSuspend();
        }
    }

    if (0 == (u32HoldModules & PMOC_HOLD_VDEC))
    {
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_VDEC, (HI_VOID**)&pstVdecFunc);
        if ((HI_SUCCESS == s32Ret) && (pstVdecFunc && pstVdecFunc->pfnVDEC_Suspend))
        {
            if (HI_SUCCESS != pstVdecFunc->pfnVDEC_Suspend(HI_NULL, state))
            {
                HI_ERR_PM("VDEC suspend fail.\n");
            }
        }
    }

    if (0 == (u32HoldModules & PMOC_HOLD_VPSS))
    {
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_VPSS, (HI_VOID**)&pstVpssFunc);
        if ((HI_SUCCESS == s32Ret) && (pstVpssFunc && pstVpssFunc->pfnVpssSuspend))
        {
            if (HI_SUCCESS != pstVpssFunc->pfnVpssSuspend(HI_NULL, state))
            {
                HI_ERR_PM("VPSS suspend fail.\n");
            }
        }
    }

    if (0 == (u32HoldModules & PMOC_HOLD_OTP))
    {
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_OTP, (HI_VOID**)&pstOtpFunc);
        if ((HI_SUCCESS == s32Ret) && (pstOtpFunc && pstOtpFunc->pfnOTPSuspend))
        {
            if (HI_SUCCESS != pstOtpFunc->pfnOTPSuspend())
            {
                HI_ERR_PM("OTP suspend fail.\n");
            }
        }
    }

#if 0 //del for skyplay
    if (0 == (u32HoldModules & PMOC_HOLD_TDE))
    {
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_TDE, (HI_VOID**)&pstTdeFunc);
        if ((HI_SUCCESS == s32Ret) && (pstTdeFunc && pstTdeFunc->pfnTdeSuspend))
        {
            if (HI_SUCCESS != pstTdeFunc->pfnTdeSuspend(HI_NULL, state))
            {
                HI_ERR_PM("TDE suspend fail.\n");
            }
        }
    }
#endif

    if (0 == (u32HoldModules & PMOC_HOLD_I2C))
    {
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_I2C, (HI_VOID**)&pstI2cFunc);
        if ((HI_SUCCESS == s32Ret) && (pstI2cFunc && pstI2cFunc->pfnI2cSuspend))
        {
            if (HI_SUCCESS != pstI2cFunc->pfnI2cSuspend(HI_NULL, state))
            {
                HI_ERR_PM("I2C suspend fail.\n");
            }
        }
    }

    if (0 == (u32HoldModules & PMOC_HOLD_GPIO))
    {
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_GPIO, (HI_VOID**)&pstGpioFunc);
        if ((HI_SUCCESS == s32Ret) && (pstGpioFunc && pstGpioFunc->pfnGpioSuspend))
        {
            if (HI_SUCCESS != pstGpioFunc->pfnGpioSuspend(HI_NULL, state))
            {
                HI_ERR_PM("GPIO suspend fail.\n");
            }
        }
    }

#if 0
    if (0 == (u32HoldModules & PMOC_HOLD_ETH))
    {
#ifdef CONFIG_HIETH_GMAC
        s32Ret = higmac_dev_suspend(HI_NULL, state);
#elif defined(CONFIG_HIETH_SWITCH_FABRIC)
        s32Ret = hieth_plat_driver_suspend(HI_NULL, state);
#endif
        if (HI_SUCCESS != s32Ret)
        {
            HI_ERR_PM("ETH suspend fail.\n");
        }
    }
#endif

#ifdef CONFIG_SMP
    //cpu_down(1);
#endif
    return HI_SUCCESS;
}

HI_S32 PMQuitSmartStandby(HI_VOID)
{
    HI_S32 s32Ret;

    AIAO_EXPORT_FUNC_S *pstAoFunc;
#ifdef HI_AUDIO_AI_SUPPORT
    AI_EXPORT_FUNC_S *pstAiFunc;
#endif
    HDMI_EXPORT_FUNC_S *pstHdmiFunc;
    DISP_EXPORT_FUNC_S *pstDispFunc;
    WIN_EXPORT_FUNC_S *pstWinFunc;

    SCI_EXT_FUNC_S *pstSciFunc;
    VENC_EXPORT_FUNC_S *pstVencFunc;
    PNG_EXPORT_FUNC_S *pstPngFunc;
#if !defined(CHIP_TYPE_hi3719mv100) && !defined(CHIP_TYPE_hi3718mv100) && !defined(CHIP_TYPE_hi3798cv200)
    JPGE_EXPORT_FUNC_S *pstJpgeFunc;
#endif
    //JPEG_EXPORT_FUNC_S *pstJpegFunc;

    WDG_EXT_FUNC_S *pstWdgFunc;

    TUNER_EXPORT_FUNC_S *pstTunerFunc;
    ADSP_EXPORT_FUNC_S *pstAdspFunc;
    CIPHER_EXPORT_FUNC_S *pstCipherFunc;

    VDEC_EXPORT_FUNC_S *pstVdecFunc;
    OTP_EXPORT_FUNC_S *pstOtpFunc;
    //TDE_EXPORT_FUNC_S *pstTdeFunc;
    I2C_EXT_FUNC_S *pstI2cFunc;
    GPIO_EXT_FUNC_S *pstGpioFunc;
    VPSS_EXPORT_FUNC_S *pstVpssFunc;
#ifdef CONFIG_SMP
    //cpu_up(1);
#endif

#if 0
#ifdef CONFIG_HIETH_GMAC
    s32Ret = higmac_dev_resume(HI_NULL);
#elif defined(CONFIG_HIETH_SWITCH_FABRIC)
    s32Ret = hieth_plat_driver_resume(HI_NULL);
#endif
    if (HI_SUCCESS != s32Ret)
    {
        HI_ERR_PM("ETH resume fail.\n");
    }
#endif

    if (0 == (g_u32HoldModules & PMOC_HOLD_GPIO))
    {
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_GPIO, (HI_VOID**)&pstGpioFunc);
        if ((HI_SUCCESS == s32Ret) && (pstGpioFunc && pstGpioFunc->pfnGpioResume))
        {
            if (HI_SUCCESS != pstGpioFunc->pfnGpioResume(HI_NULL))
            {
                HI_ERR_PM("GPIO resume fail.\n");
            }
        }
        }

    if (0 == (g_u32HoldModules & PMOC_HOLD_I2C))
    {
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_I2C, (HI_VOID**)&pstI2cFunc);
        if ((HI_SUCCESS == s32Ret) && (pstI2cFunc && pstI2cFunc->pfnI2cResume))
        {
            if (HI_SUCCESS != pstI2cFunc->pfnI2cResume(HI_NULL))
            {
                HI_ERR_PM("I2C resume fail.\n");
            }
        }
    }

#if 0 //del for skyplay
    if (0 == (g_u32HoldModules & PMOC_HOLD_TDE))
    {
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_TDE, (HI_VOID**)&pstTdeFunc);
        if ((HI_SUCCESS == s32Ret) && (pstTdeFunc && pstTdeFunc->pfnTdeResume))
        {
            if (HI_SUCCESS != pstTdeFunc->pfnTdeResume(HI_NULL))
            {
                HI_ERR_PM("TDE resume fail.\n");
            }
        }
    }
#endif

    if (0 == (g_u32HoldModules & PMOC_HOLD_OTP))
    {
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_OTP, (HI_VOID**)&pstOtpFunc);
        if ((HI_SUCCESS == s32Ret) && (pstOtpFunc && pstOtpFunc->pfnOTPResume))
        {
            if (HI_SUCCESS != pstOtpFunc->pfnOTPResume())
            {
                HI_ERR_PM("OTP resume fail.\n");
            }
        }
    }

    if (0 == (g_u32HoldModules & PMOC_HOLD_VPSS))
    {
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_VPSS, (HI_VOID**)&pstVpssFunc);
        if ((HI_SUCCESS == s32Ret) && (pstVpssFunc && pstVpssFunc->pfnVpssResume))
        {
            if (HI_SUCCESS != pstVpssFunc->pfnVpssResume(HI_NULL))
            {
                HI_ERR_PM("VPSS resume fail.\n");
            }
        }
    }

    if (0 == (g_u32HoldModules & PMOC_HOLD_VDEC))
    {
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_VDEC, (HI_VOID**)&pstVdecFunc);
        if ((HI_SUCCESS == s32Ret) && (pstVdecFunc && pstVdecFunc->pfnVDEC_Resume))
        {
            if (HI_SUCCESS != pstVdecFunc->pfnVDEC_Resume(HI_NULL))
            {
                HI_ERR_PM("VDEC resume fail.\n");
            }
        }
    }

    if (0 == (g_u32HoldModules & PMOC_HOLD_CIPHER))
    {
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_CIPHER, (HI_VOID**)&pstCipherFunc);
        if ((HI_SUCCESS == s32Ret) && (pstCipherFunc && pstCipherFunc->pfnCipherResume))
        {
            if (HI_SUCCESS != pstCipherFunc->pfnCipherResume())
            {
                HI_ERR_PM("CIPHER resume fail.\n");
            }
        }
    }

    if (0 == (g_u32HoldModules & PMOC_HOLD_ADSP))
    {
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_ADSP, (HI_VOID**)&pstAdspFunc);
        if ((HI_SUCCESS == s32Ret) && (pstAdspFunc && pstAdspFunc->pfnADSP_DrvResume))
        {
            if (HI_SUCCESS != pstAdspFunc->pfnADSP_DrvResume(HI_NULL))
            {
                HI_ERR_PM("ADSP resume fail.\n");
            }
        }
    }

#ifdef HI_AUDIO_AI_SUPPORT
    if (0 == (g_u32HoldModules & PMOC_HOLD_AI))
    {
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_AI, (HI_VOID**)&pstAiFunc);
        if ((HI_SUCCESS == s32Ret) && (pstAiFunc && pstAiFunc->pfnAI_DrvResume))
        {
            if (HI_SUCCESS != pstAiFunc->pfnAI_DrvResume(HI_NULL))
            {
                HI_ERR_PM("\nAI resume fail.\n");
            }
        }
    }
#endif
    if (0 == (g_u32HoldModules & PMOC_HOLD_AO))
    {
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_AO, (HI_VOID**)&pstAoFunc);
        if ((HI_SUCCESS == s32Ret) && (pstAoFunc && pstAoFunc->pfnAO_DrvResume))
        {
            if (HI_SUCCESS != pstAoFunc->pfnAO_DrvResume(HI_NULL))
            {
                HI_ERR_PM("AO resume fail.\n");
            }
        }
    }

    if (0 == (g_u32HoldModules & PMOC_HOLD_DISP))
    {
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_DISP, (HI_VOID**)&pstDispFunc);
        if ((HI_SUCCESS == s32Ret) && (pstDispFunc && pstDispFunc->pfnDispResume))
        {
            if (HI_SUCCESS != pstDispFunc->pfnDispResume(HI_NULL))
            {
                HI_ERR_PM("DISP resume fail.\n");
            }
        }
    }

    if (0 == (g_u32HoldModules & PMOC_HOLD_VO))
    {
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_VO, (HI_VOID**)&pstWinFunc);
        if ((HI_SUCCESS == s32Ret) && (pstWinFunc && pstWinFunc->pfnWinResume))
        {
            if (HI_SUCCESS != pstWinFunc->pfnWinResume(HI_NULL))
            {
                HI_ERR_PM("WIN resume fail.\n");
            }
        }
    }

    if (0 == (g_u32HoldModules & PMOC_HOLD_HDMI))
    {
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_HDMI, (HI_VOID**)&pstHdmiFunc);
        if ((HI_SUCCESS == s32Ret) && (pstHdmiFunc && pstHdmiFunc->pfnHdmiResume))
        {
            if (HI_SUCCESS != pstHdmiFunc->pfnHdmiResume(HI_NULL))
            {
                HI_ERR_PM("HDMI resume fail.\n");
            }
        }
    }

    if (0 == (g_u32HoldModules & PMOC_HOLD_TUNER))
    {
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_TUNER, (HI_VOID**)&pstTunerFunc);
        if ((HI_SUCCESS == s32Ret) && (pstTunerFunc && pstTunerFunc->pfnTunerResume))
        {
            if (HI_SUCCESS != pstTunerFunc->pfnTunerResume(HI_NULL))
            {
                HI_ERR_PM("TUNER suspend fail.\n");
            }
        }
    }

    if (0 == (g_u32HoldModules & PMOC_HOLD_WDG))
    {
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_WDG, (HI_VOID**)&pstWdgFunc);
        if ((HI_SUCCESS == s32Ret) && (pstWdgFunc && pstWdgFunc->pfnWdgResume))
        {
            if (HI_SUCCESS != pstWdgFunc->pfnWdgResume(HI_NULL))
            {
                HI_ERR_PM("WDG resume fail.\n");
            }
        }
    }

#if 0 //del for skyplay
    if (0 == (g_u32HoldModules & PMOC_HOLD_JPEG))
    {
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_JPGDEC, (HI_VOID**)&pstJpegFunc);
        if ((HI_SUCCESS == s32Ret) && (pstJpegFunc && pstJpegFunc->pfnJpegResume))
        {
            if (HI_SUCCESS != pstJpegFunc->pfnJpegResume(HI_NULL))
            {
                HI_ERR_PM("JPEG resume fail.\n");
            }
        }
    }
#endif

#if !defined(CHIP_TYPE_hi3719mv100) && !defined(CHIP_TYPE_hi3718mv100) && !defined(CHIP_TYPE_hi3798cv200)
    if (0 == (g_u32HoldModules & PMOC_HOLD_JPGE))
    {
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_JPGENC, (HI_VOID**)&pstJpgeFunc);
        if ((HI_SUCCESS == s32Ret) && (pstJpgeFunc && pstJpgeFunc->pfnJpgeResume))
        {
            if (HI_SUCCESS != pstJpgeFunc->pfnJpgeResume(HI_NULL))
            {
                HI_ERR_PM("JPGE resume fail.\n");
            }
        }
    }
#endif

    if (0 == (g_u32HoldModules & PMOC_HOLD_PNG))
    {
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_PNG, (HI_VOID**)&pstPngFunc);
        if ((HI_SUCCESS == s32Ret) && (pstPngFunc && pstPngFunc->pfnPngResume))
        {
            if (HI_SUCCESS != pstPngFunc->pfnPngResume(HI_NULL))
            {
                HI_ERR_PM("PNG resume fail.\n");
            }
        }
    }

    if (0 == (g_u32HoldModules & PMOC_HOLD_VENC))
    {
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_VENC, (HI_VOID**)&pstVencFunc);
        if ((HI_SUCCESS == s32Ret) && (pstVencFunc && pstVencFunc->pfnVencResume))
        {
            if (HI_SUCCESS != pstVencFunc->pfnVencResume())
            {
                HI_ERR_PM("VENC resume fail.\n");
            }
        }
    }

    if (0 == (g_u32HoldModules & PMOC_HOLD_SCI))
    {
        s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_SCI, (HI_VOID**)&pstSciFunc);
        if ((HI_SUCCESS == s32Ret) && (pstSciFunc && pstSciFunc->pfnSciResume))
        {
            if (HI_SUCCESS != pstSciFunc->pfnSciResume(HI_NULL))
            {
                HI_ERR_PM("SCI resume fail.\n");
            }
        }
    }

#ifdef HI_DVFS_CPU_SUPPORT
     cpu_dvfs_enable = HI_TRUE;
#endif

    return HI_SUCCESS;
}

