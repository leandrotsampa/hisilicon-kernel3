/******************************************************************************

  Copyright (C), 2012-2050, Hisilicon Tech. Co., Ltd.

 ******************************************************************************
  File Name     : drv_hdmirx_intf.c
  Version       : Initial Draft
  Author        : Hisilicon multimedia software group
  Created       : 2014/01/16
  Description   : 
  History       :
  1.Date        : 2014/01/16
    Author      : t00202585
    Modification: Created file
******************************************************************************/

#include <linux/kthread.h>
#include <linux/init.h>
#include <linux/delay.h>

#include "hi_type.h"
#include "hi_drv_dev.h"
#include "hi_drv_proc.h"
#include "hi_osal.h"
#include "hi_drv_module.h"
#include "drv_hdmirx_ctrl.h"
#include "drv_hdmirx_input.h"
#include "hi_drv_hdmirx.h"
#include "drv_hdmirx_ext.h"
#include "drv_hdmirx_common.h"


#ifdef __cplusplus
 #if __cplusplus
    extern "C" {
 #endif
#endif /* __cplusplus */


static HI_S32 HDMIRX_DRV_Open(struct inode *node, struct file *filp)
{
    return HI_SUCCESS;
}

static HI_S32 HDMIRX_DRV_Close(struct inode *node, struct file *filp)
{
    return HI_SUCCESS;
}

static HI_S32 HDMIRXIoctl(struct inode *inode, struct file *filp, unsigned int cmd, HI_VOID *arg)
{
    HI_S32 s32Ret;
    static HI_BOOL bEdidState = HI_FALSE;
    static HI_BOOL bHdcpState = HI_FALSE;
    HDMIRX_DRV_CTRL_CtxLock();

    switch (cmd)
    {
        case HIIOC_HDMIRX_CONNECT:
        {
            HI_UNF_HDMIRX_PORT_E *penPortIdx;
            if(bHdcpState == HI_FALSE)
            {
                HDMI_ERROR("Please Load HDCP before Connect port!\n");
            }
            penPortIdx = (HI_UNF_HDMIRX_PORT_E *)arg;
            s32Ret = HDMIRX_DRV_CTRL_Connect(*penPortIdx);
            printk("####Get Connect %d \n",*penPortIdx);
            break;
        }
        case HIIOC_HDMIRX_DISCONNECT:
        {
            s32Ret = HDMIRX_DRV_CTRL_Disconnect();
            
            break;
        }
        case HIIOC_HDMIRX_G_STATUS:
        {
            HI_UNF_SIG_STATUS_E *penSigSta;
            penSigSta = (HI_UNF_SIG_STATUS_E *)arg;
            s32Ret = HDMIRX_DRV_CTRL_GetSigStatus(penSigSta);
            break;
        }
        case HIIOC_HDMIRX_G_AudioSTATUS:
        {
            HI_UNF_SIG_STATUS_E *penSigSta;
            penSigSta = (HI_UNF_SIG_STATUS_E *)arg;
            s32Ret = HDMIRX_DRV_CTRL_GetAudioStatus(penSigSta);
            break;
        }
        case HIIOC_HDMIRX_G_TIMING_INFO:
        {
            HI_UNF_HDMIRX_TIMING_INFO_S *pstTimingInfo;
            pstTimingInfo = (HI_UNF_HDMIRX_TIMING_INFO_S *)arg;
            s32Ret = HDMIRX_DRV_CTRL_GetTiming(pstTimingInfo);
            break;
        }        
        case HIIOC_HDMIRX_G_HDCP_STATUS:
        {
            HI_BOOL *pbHdcp;
            pbHdcp = (HI_BOOL *)arg;
            s32Ret = HDMIRX_DRV_CTRL_GetHdcpStatus(pbHdcp);
            break;
        }
        /*
        case HIIOC_HDMIRX_EN_MONITOR:
        {
            HI_BOOL bEnMonitor;
            bEnMonitor = *((HI_BOOL *)arg);
            s32Ret = HDMIRX_DRV_CTRL_SetMonitorRun(bEnMonitor);
            break;
        }
        */
        case HIIOC_HDMIRX_G_AUDIO_INFO:
        {
            HI_UNF_AI_HDMI_ATTR_S *pstAudioInfo;
            pstAudioInfo = (HI_UNF_AI_HDMI_ATTR_S*)arg;
            s32Ret = HDMIRX_DRV_CTRL_GetAudioInfo(pstAudioInfo);
            break;
        }
        case HIIOC_HDMIRX_G_OFF_LINE_DET_STA:
        {
            HI_UNF_HDMIRX_OFF_LINE_DET_S *pbOffLineDetSta;
            pbOffLineDetSta = (HI_UNF_HDMIRX_OFF_LINE_DET_S *)arg;
            s32Ret = HDMIRX_DRV_CTRL_GetOffLineDetStatus(pbOffLineDetSta);
            break;
        }
        case HIIOC_HDMIRX_S_LOAD_HDCP:
        {                      
            HI_UNF_HDMIRX_HDCP_S *pstEncryptHdcp;
            if(bEdidState== HI_FALSE)
            {
                HDMI_ERROR("Please Update EDID before LOAD HDCP!\n");
            } 
            pstEncryptHdcp = (HI_UNF_HDMIRX_HDCP_S *)arg;
            s32Ret = HDMIRX_DRV_CTRL_LoadHdcp(pstEncryptHdcp);
            bHdcpState = HI_TRUE;
            printk("#####Load HCDCP!\n");
            break;
        }
        case HIIOC_HDMIRX_S_UPDATE_EDID:
        {
            HI_UNF_HDMIRX_EDID_S *pstEdid;
            pstEdid = (HI_UNF_HDMIRX_EDID_S *)arg;
            s32Ret = HDMIRX_DRV_CTRL_UpdateEdid(pstEdid);
            bEdidState = HI_TRUE;
            printk("#####UPDATE EDID!\n");
            break;
        }  
        /*
        case HIIOC_HDMIRX_S_MHL_RCPKEY:
        {   
            HI_UNF_HDMIRX_RCP_KEY_E *enKey;
            enKey = (HI_UNF_HDMIRX_RCP_KEY_E *)arg;
            s32Ret = HDMIRX_DRV_CTRL_SendRCPKey(enKey);           
            break;

        }
        */
        default:
        {
            HDMIRX_DRV_CTRL_CtxUnlock();
            HI_ERR_DEV("No Such IOCTL Command: %d\n", cmd);
            return -ENOIOCTLCMD;
        }
    }
    
    HDMIRX_DRV_CTRL_CtxUnlock();

    return s32Ret;
}

long HDMIRX_DRV_Ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
{
    return (long)HI_DRV_UserCopy(filp->f_dentry->d_inode, filp, cmd, arg, HDMIRXIoctl);
}

HI_S32 HDMIRX_DRV_Suspend(PM_BASEDEV_S *pdev, pm_message_t state)
{
    HI_S32 s32Ret = HI_SUCCESS;    
    
    s32Ret = HDMIRX_DRV_CTRL_Suspend();
    if (s32Ret != HI_SUCCESS)
    {
        HI_ERR_DEV("HDMIRX_DRV_CTRL_Suspend Fail!\n");
        
        return s32Ret;
    }

#ifdef MODULE
    HI_PRINT("Suspend hi_hdmirx.ko success.\t\t(%s)\n", VERSION_STRING);
#endif
    
    return s32Ret;
}

HI_S32 HDMIRX_DRV_Resume(PM_BASEDEV_S *pdev)
{    
    HI_S32 s32Ret;
    
    s32Ret = HDMIRX_DRV_CTRL_Resume();
    if (s32Ret != HI_SUCCESS)
    {
        HI_ERR_DEV("HDMIRX_DRV_CTRL_Resume Fail!\n");
        
        return s32Ret;
    }
    
    #ifdef MODULE
    HI_PRINT("Reusme hi_hdmirx.ko success.\t\t(%s)\n", VERSION_STRING);
    #endif
   
    return s32Ret;
}

static struct file_operations s_stHdmirxFileOps =
{
    .owner          = THIS_MODULE,
    .open           = HDMIRX_DRV_Open,
    .release        = HDMIRX_DRV_Close,
    .unlocked_ioctl = HDMIRX_DRV_Ioctl,
};

static PM_BASEOPS_S  s_stHdmirxDrvOps = {
    .probe        = NULL,
    .remove       = NULL,
    .shutdown     = NULL,
    .prepare      = NULL,
    .complete     = NULL,
    .suspend      = HDMIRX_DRV_Suspend,
    .suspend_late = NULL,
    .resume_early = NULL,
    .resume       = HDMIRX_DRV_Resume,
};

static UMAP_DEVICE_S s_stHdmirxDev =
{
    .minor      = UMAP_MIN_MINOR_HDMIRX,
    .owner      = THIS_MODULE,
    .fops       = &s_stHdmirxFileOps,
    .drvops     = &s_stHdmirxDrvOps,
};

static const HDMIRX_EXPORT_FUNC_S g_HDMIRXExtFuncs =
{    
    .pfnHDMIRXGetDataRoute = HDMIRX_DRV_CTRL_GetDataRoute,    
};

HI_S32 __init HDMIRX_DRV_ModuleInit(HI_VOID)
{
    HI_S32 s32Ret;
    DRV_PROC_ITEM_S *pstHdmirxProc = NULL;

    HI_OSAL_Snprintf(s_stHdmirxDev.devfs_name, HIMEDIA_DEVICE_NAME_MAX_LEN, "%s", UMAP_DEVNAME_HDMIRX);
    s32Ret = HI_DRV_DEV_Register(&s_stHdmirxDev);
    if (s32Ret != HI_SUCCESS)
    {
        HI_ERR_DEV("HDMIRX Device Register Fail!\n");
        
        return s32Ret;
    }
    
    //s32Ret = HI_DRV_MODULE_Register(HI_ID_HDMI, "HI_HDMI", HI_NULL);
    s32Ret = HI_DRV_MODULE_Register(HI_ID_HDMIRX, "HI_HDMIRX", (HI_VOID *)&g_HDMIRXExtFuncs);
    if (s32Ret != HI_SUCCESS)
    {
        HI_ERR_DEV("HDMIRX Proc Register Fail!\n");
        HI_DRV_DEV_UnRegister(&s_stHdmirxDev);
        return s32Ret;
    }
        
    pstHdmirxProc = HI_DRV_PROC_AddModule("hdmirx", NULL, NULL);
    if (NULL == pstHdmirxProc)
    {
        HI_ERR_DEV("HDMIRX Proc Register Fail!\n");
        HI_DRV_DEV_UnRegister(&s_stHdmirxDev);
        
        return s32Ret;
    }
    pstHdmirxProc->read = DRV_HDMIRX_CTRL_ProcRead;
    pstHdmirxProc->write = DRV_HDMIRX_CTRL_ProcWrite;
    pstHdmirxProc->ioctl = NULL;
    
    s32Ret = HDMIRX_DRV_CTRL_Init();
    if (s32Ret != HI_SUCCESS)
    {
        HI_DRV_DEV_UnRegister(&s_stHdmirxDev);
        HI_DRV_PROC_RemoveModule("hdmirx");
        HI_ERR_DEV("HDMIRX Hal Init Fail!\n");
        
        return s32Ret;
    }
    #ifdef MODULE
    HI_PRINT("Load hi_hdmirx.ko success.\t\t(%s)\n", VERSION_STRING);
    #endif
    
    return HI_SUCCESS;
}

HI_VOID __exit HDMIRX_DRV_ModuleExit(HI_VOID)
{
    HDMIRX_DRV_CTRL_DeInit();
    HI_DRV_MODULE_UnRegister(HI_ID_HDMIRX); 
    HI_DRV_PROC_RemoveModule("hdmirx");
    HI_DRV_DEV_UnRegister(&s_stHdmirxDev);
    
    HI_PRINT("remove hi_hdmirx.ko success.\n");
}

MODULE_LICENSE("GPL");

#ifdef MODULE
module_init(HDMIRX_DRV_ModuleInit);
module_exit(HDMIRX_DRV_ModuleExit);
#endif

#ifdef __cplusplus
 #if __cplusplus
}
 #endif
#endif /* __cplusplus */
