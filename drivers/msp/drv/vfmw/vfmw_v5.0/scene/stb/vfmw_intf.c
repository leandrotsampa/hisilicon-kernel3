/*$$$!!Warning: Huawei key information asset. No spread without permission.$$$*/
/*CODEMARK:EG4uRhTwMmgcVFBsBnYHCDadN5jJKSuVyxmmaCmKFU6eJEbB2fyHF9weu4/jer/hxLHb+S1e
E0zVg4C3NiZh4SXu1DUPt3BK64ZJx2SaroTK5QUHRI9UX5KeSe3MjVz/EbC4xx64tuANphe3
Vboa6TNnGeo+6N1fhdeNfSMmmG1FnUMAXGrkf3hm0PkRSKRJRF8HuN1MltSNR0TlcHCvEGSG
NHiLGCLW7cCwQ7teFPz79550ch0RzjzlXloDCwHwS4yRpTTUXy0Z4S+BOBd8OQ==#*/
/*$$$!!Warning: Deleting or modifying the preceding information is prohibited.$$$*/






























#include "hi_type.h"
#include "hi_common.h"
#include "hi_module.h"
#include "hi_drv_module.h"
#include "hi_debug.h"
#include "syn_cmn.h"
#include "mem_manage.h"
#include "syntax.h"

#include "vfmw.h"
#include "vfmw_ext.h"
#include "vfmw_debug.h"

#include "vfmw_osal_ext.h"

#include "vfmw_osal.h"

extern Vfmw_Osal_Func_Ptr vfmw_Osal_Func_Ptr_S;

#define VFMW_NAME       "HI_VFMW"

#ifdef HI_TEE_SUPPORT
extern HI_VOID TVP_VDEC_OpenModule(HI_VOID);
extern HI_VOID TVP_VDEC_ExitModule(HI_VOID);
extern HI_S32  TVP_VDEC_Init(HI_S32 (*VdecCallback)(HI_S32, HI_S32, HI_VOID *));
extern HI_S32  TVP_VDEC_InitWithOperation(VDEC_OPERATION_S *pArgs);
extern HI_S32  TVP_VDEC_Exit(HI_VOID);
extern HI_S32  TVP_VDEC_Control(HI_S32 ChanID, VDEC_CID_E eCmdID, HI_VOID *pArgs);
extern HI_S32  TVP_VDEC_Suspend(HI_VOID);
extern HI_S32  TVP_VDEC_Resume(HI_VOID);
extern HI_S32  TVP_VDEC_SetDbgOption (HI_U32 opt, HI_U8 *p_args);
extern HI_S32  TVP_VDEC_TrustDecoderInit(VDEC_OPERATION_S *pArgs);
extern HI_S32  TVP_VDEC_TrustDecoderExit(HI_VOID);
#endif

/* svdec used vfmw function */
#ifdef VFMW_H263_SUPPORT
extern HI_S32  VFMW_SVDE_DRV_Init (HI_VOID);
extern HI_VOID VFMW_SVDEC_DRV_Exit (HI_VOID);
#endif

extern HI_VOID SVDEC_ModeInit(HI_VOID);
extern HI_VOID SVDEC_ModeExit(HI_VOID);


/* internal function */
SINT32 VFMW_DRV_Suspend(VOID);
SINT32 VFMW_DRV_Resume(VOID);


#ifdef HI_TEE_SUPPORT
static VFMW_EXPORT_FUNC_S s_VfmwExportFuncs =
{
    .pfnVfmwOpenModule              = TVP_VDEC_OpenModule,
    .pfnVfmwExitModule              = TVP_VDEC_ExitModule,
    .pfnVfmwInit                    = TVP_VDEC_Init,
    .pfnVfmwInitWithOperation       = TVP_VDEC_InitWithOperation,
    .pfnVfmwControl                 = TVP_VDEC_Control,
    .pfnVfmwExit                    = TVP_VDEC_Exit,
    .pfnVfmwSuspend                 = VFMW_DRV_Suspend,
    .pfnVfmwResume                  = VFMW_DRV_Resume,
    .pfnVfmwSetDbgOption            = TVP_VDEC_SetDbgOption,
    .pfnVfmwTrustDecoderInit        = TVP_VDEC_TrustDecoderInit,
    .pfnVfmwTrustDecoderExit        = TVP_VDEC_TrustDecoderExit,
};
#else
static VFMW_EXPORT_FUNC_S s_VfmwExportFuncs =
{
    .pfnVfmwOpenModule              = VDEC_OpenModule,
    .pfnVfmwExitModule              = VDEC_ExitModule,
    .pfnVfmwInit                    = VDEC_Init,
    .pfnVfmwInitWithOperation       = VDEC_InitWithOperation,
    .pfnVfmwControl                 = VDEC_Control,
    .pfnVfmwExit                    = VDEC_Exit,
    .pfnVfmwSuspend                 = VFMW_DRV_Suspend,
    .pfnVfmwResume                  = VFMW_DRV_Resume,
    .pfnVfmwSetDbgOption            = VCTRL_SetDbgOption,
    .pfnVfmwTrustDecoderInit        = HI_NULL,
    .pfnVfmwTrustDecoderExit        = HI_NULL,
};
#endif

SINT32 VFMW_DRV_Suspend(VOID)
{
    SINT32 ret;

    ret = VDEC_Suspend();
    if (ret != VDEC_OK)
    {
        HI_FATAL_VFMW("%s Call VDEC_Suspend Failed!\n", __func__);
    }
 
#ifdef HI_TEE_SUPPORT
    ret = TVP_VDEC_Suspend();
    if (ret != VDEC_OK)
    {
        HI_FATAL_VFMW("%s Call TVP_VDEC_Suspend Failed!\n", __func__);
    }
#endif

#ifdef VDH_DISTRIBUTOR_ENABLE
    if (g_HalDisable != 1)
    {
        VDH_Suspend();
    }
#endif

    return VDEC_OK;
}

SINT32 VFMW_DRV_Resume(VOID)
{
    SINT32 ret;
    
#ifdef VDH_DISTRIBUTOR_ENABLE
    if (g_HalDisable != 1)
    {
        VDH_Resume();
    }
#endif

    ret = VDEC_Resume();
    if (ret != VDEC_OK)
    {
        HI_FATAL_VFMW("%s Call VDEC_Resume Failed!\n", __func__);
    }
    
#ifdef HI_TEE_SUPPORT
    ret = TVP_VDEC_Resume();
    if (ret != VDEC_OK)
    {
        HI_FATAL_VFMW("%s Call TVP_VDEC_Resume Failed!\n", __func__);
    }
#endif

    return VDEC_OK;
}

HI_S32 VFMW_DRV_Init(HI_VOID)
{
    HI_S32  ret;

    InitVfmwInterface();
    ret = HI_DRV_MODULE_Register(HI_ID_VFMW, VFMW_NAME, (HI_VOID *)&s_VfmwExportFuncs);

    if (HI_SUCCESS != ret)
    {
        HI_FATAL_VFMW("HI_DRV_MODULE_VDEC_Register failed\n");
        return ret;
    }

    VDEC_OpenModule();   // open proc
    HI_INFO_VFMW("inner vfmw mod init OK\n");
    return HI_SUCCESS;
}

HI_VOID VFMW_DRV_Exit(HI_VOID)
{
    VDEC_ExitModule();   // clcose proc
    HI_DRV_MODULE_UnRegister(HI_ID_VFMW);
}

HI_S32 VFMW_DRV_ModInit(void)
{
#ifndef HI_MCE_SUPPORT
    HI_U32 i;
#endif

    //InitVfmwInterface();

#ifndef VFMW_SUPPORT
#ifndef HI_MCE_SUPPORT
    if (HI_SUCCESS != VFMW_DRV_Init())
    {
        return -1;
    }

#endif

    /* svdec */
#ifdef VFMW_H263_SUPPORT
    if (HI_SUCCESS != VFMW_SVDE_DRV_Init())
    {
        return -1;
    }
#endif
#endif

#ifndef HI_MCE_SUPPORT

    for (i = 0; i < MAX_VDH_NUM; i++)
    {
        VDM_CloseHardware(i);
        DSP_CloseHardware(i);
    }

    BPD_CloseHardware(0);
#endif

#ifdef HI_TEE_SUPPORT
    TVP_VDEC_OpenModule();
#endif

#ifdef VDH_DISTRIBUTOR_ENABLE
    VDH_Init_Proc();
#endif

#ifdef MODULE
    HI_PRINT("Load hi_vfmw.ko success.\t(%s)\n", VERSION_STRING);
#endif

    return 0;
}

HI_VOID VFMW_DRV_ModExit(void)
{
#ifndef VFMW_SUPPORT
#ifndef HI_MCE_SUPPORT
    VFMW_DRV_Exit();
#endif
    /* svdec */
#ifdef VFMW_H263_SUPPORT
    VFMW_SVDEC_DRV_Exit();
#endif
#endif

#ifdef HI_TEE_SUPPORT
    TVP_VDEC_ExitModule();
#endif

#ifdef VDH_DISTRIBUTOR_ENABLE
    VDH_Exit_Proc();
#endif

#ifdef MODULE
    HI_PRINT("Unload hi_vfmw.ko success.\t(%s)\n", VERSION_STRING);
#endif
    return ;
}

#ifdef MODULE
module_init(VFMW_DRV_ModInit);
module_exit(VFMW_DRV_ModExit);
#endif

EXPORT_SYMBOL(vfmw_Osal_Func_Ptr_S);

MODULE_AUTHOR("HISILICON");
MODULE_LICENSE("GPL");

