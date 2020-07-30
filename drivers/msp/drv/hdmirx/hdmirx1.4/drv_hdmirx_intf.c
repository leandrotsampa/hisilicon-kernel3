//******************************************************************************
//  Copyright (C), 2007-2014, Hisilicon Technologies Co., Ltd.
//
//******************************************************************************
// File name     : drv_hdmirx_intf.c
// Version       : 1.0
// Author        : j00169368
// Created       : 2011-06-04
// Last Modified : 
// Description   :  The C union definition file for the module tvd
// Function List : 
// History       : 
// 1 Date        : 2014-06-14
// Author        : l00214567
// Modification  : Create file
//******************************************************************************

#include <linux/vmalloc.h>
#include <linux/kernel.h>
#include <linux/version.h>
#include <linux/module.h>
#include <linux/types.h>
#include <linux/errno.h>
#include <linux/fcntl.h>
#include <linux/mm.h>
#include <linux/miscdevice.h>
#include <linux/proc_fs.h>
#include <linux/fs.h>
#include <linux/slab.h>
#include <linux/init.h>
#include <linux/delay.h>
#include <asm/uaccess.h>
#include <asm/io.h>
#if (LINUX_VERSION_CODE < KERNEL_VERSION(3, 18, 0))
#include <asm/system.h>
#endif
#include <linux/interrupt.h>
#include <linux/ioport.h>
#include <linux/string.h>

#include "hi_drv_dev.h"
#include "hi_drv_proc.h"
#include "hi_drv_module.h"
#include "hi_module.h"
#include "hi_kernel_adapt.h"

#include "hi_error_mpi.h"
#include "hi_module.h"
#include "hi_kernel_adapt.h"

#include "hi_drv_hdmirx.h"
#include "drv_hdmirx.h"
#include "drv_hdmirx_video.h"
#include "drv_hdmirx_video_internal.h"
#include "drv_hdmirx_audio.h"


#ifdef __cplusplus
#if __cplusplus
extern "C"{
#endif
#endif

#define HDMIRX_NAME         "HI_HDMIRX"
extern struct hdmistatus hdmi_ctx;

static UMAP_DEVICE_S        g_HdmirxRegisterData;

HI_DECLARE_MUTEX(g_stHdmiRxSemaphore);

static HI_S32 HDMIRX_ProcRead(struct seq_file *p, HI_VOID *v)
{
    struct seq_file *s=p;
    struct hdmistatus *pstCtrlCtx = &hdmi_ctx;
    HI_BOOL pbHdcp;

    /* TVD Attr Information */
    PROC_PRINT(s, "\n--------------- HDMIRX Attr ---------------\n");
    PROC_PRINT(s,"DevId                :   %d\n",pstCtrlCtx->u32DevId );
    PROC_PRINT(s,"ConnectState         :   %s\n",pstCtrlCtx->bConnect? "Yes" : "No");
    PROC_PRINT(s,"bRtState             :   %s\n",pstCtrlCtx->bRtState? "Yes" : "No");
    PROC_PRINT(s,"HdmiState            :   %s\n",(HDMI_STATE_VIDEO_ON == pstCtrlCtx->u32HdmiState)? "Yes" : "No");
    PROC_PRINT(s,"HdmiMode             :   %s\n",pstCtrlCtx->bHdmiMode? "HDMI" : "DVI");
    PROC_PRINT(s,"bKsvValid            :   %d\n",pstCtrlCtx->bKsvValid);
    
    HDMIRX_DRV_CTRL_GetHdcpStatus(&pbHdcp);
    PROC_PRINT(s,"HdcpCheck            :   %s\n",pbHdcp? "Yes":"No");
    if (HDMI_STATE_VIDEO_ON != pstCtrlCtx->u32HdmiState)
    {
        return HI_SUCCESS;
    }
    
    /* HDMIRX Signal Timing Information */
    HDMI_DB_ShowTimingInfo(p);


    /* HDMIRX Signal Audio Information */
    if(pstCtrlCtx->bHdmiMode == HI_TRUE)
    {
        HDMI_DB_ShowAudioInfo(p);
    }
    
    return HI_SUCCESS;
}

static HI_S32 HDMIRX_ProcWrite(struct file * file,
    const char __user * buf, size_t count, loff_t *ppos)

{
    return count;
}

HI_S32 HDMIRX_Create(HI_VOID)
{
    DRV_PROC_ITEM_S  *pProcItem;
    HI_CHAR           ProcName[12];

    snprintf(ProcName, sizeof(ProcName),"%s", HI_MOD_HDMIRX);
    pProcItem = HI_DRV_PROC_AddModule(ProcName, HI_NULL, HI_NULL);
    if (!pProcItem)
    {
        HDMIRX_DEBUG("add %s proc failed.\n", ProcName);
        return HI_FAILURE;
    }
    pProcItem->read = HDMIRX_ProcRead;
    pProcItem->write = HDMIRX_ProcWrite;

    return HI_SUCCESS;
}

HI_S32 HDMIRX_Destroy(HI_VOID)
{
    HI_CHAR           ProcName[17];
    
    memset(ProcName, 0, sizeof(ProcName));    

    snprintf(ProcName, sizeof(ProcName), "%s", HI_MOD_HDMIRX);
    HI_DRV_PROC_RemoveModule(ProcName);

    return HI_SUCCESS;
}

HI_S32 HDMIRX_Ioctl(struct inode *inode, struct file *file, unsigned int cmd, HI_VOID *arg)
{
    HI_S32 s32Ret = HI_SUCCESS;

    s32Ret = down_interruptible(&g_stHdmiRxSemaphore);
    if (s32Ret != HI_SUCCESS)
    {
        HDMIRX_DEBUG("Acquire HdmiRx mutex failed!\n");
        return s32Ret;
    }
    
    switch (cmd)
    {
        case HIIOC_HDMIRX_CONNECT:
        {
            //s32Ret = HDMI_Connect();
            break;
        }
        
        case HIIOC_HDMIRX_DISCONNECT:
        {
           // s32Ret = HDMI_DisConnect();
            break;
        }
        
        case HIIOC_HDMIRX_G_STATUS:
        {
            HI_UNF_SIG_STATUS_E *pstSigStatus;
            
            pstSigStatus = (HI_UNF_SIG_STATUS_E *)arg;
            
            s32Ret = HDMIRX_GetStatus(pstSigStatus);
            break;
        }
        
        case HIIOC_HDMIRX_G_TIMING_INFO:
        {
            HI_UNF_HDMIRX_TIMING_INFO_S *pstTiming;
            
            pstTiming = (HI_UNF_HDMIRX_TIMING_INFO_S *)arg;
            
            s32Ret = HDMIRX_GetTiming(pstTiming);
            break;
        }
        case HIIOC_HDMIRX_G_AudioSTATUS:
        {
            HI_UNF_SIG_STATUS_E *penSigSta;
            penSigSta = (HI_UNF_SIG_STATUS_E *)arg;
            s32Ret = HDMIRX_DRV_CTRL_GetAudioStatus(penSigSta);
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
          //  s32Ret = HDMIRX_DRV_CTRL_GetOffLineDetStatus(pbOffLineDetSta);
            s32Ret = HI_FAILURE;
            break;
        }
        case HIIOC_HDMIRX_S_LOAD_HDCP:
        {
            HI_UNF_HDMIRX_HDCP_S *pstEncryptHdcp;
            pstEncryptHdcp = (HI_UNF_HDMIRX_HDCP_S *)arg;
            s32Ret = HDMIRX_DRV_CTRL_LoadHdcp(pstEncryptHdcp);
            break;
        }
        case HIIOC_HDMIRX_S_UPDATE_EDID:
        {
            HI_UNF_HDMIRX_EDID_S *pstEdid;
            pstEdid = (HI_UNF_HDMIRX_EDID_S *)arg;
            s32Ret = HDMIRX_DRV_CTRL_UpdateEdid(pstEdid);
            break;
        }
        
        default:
        {
            //HDMIRX_TRACE(HI_DBG_ERR, "No Such IOCTL Command: %d\n", cmd);
            up(&g_stHdmiRxSemaphore);
            return -ENOIOCTLCMD;
        }
    }

    up(&g_stHdmiRxSemaphore);

    return s32Ret;
}


static HI_S32 HDMIRX_DRV_Open(struct inode *finode, struct file  *ffile)
{ 
    return 0;
}

static HI_S32 HDMIRX_DRV_Close(struct inode *finode, struct file  *ffile)
{
    return 0;
}

static long HDMIRX_DRV_Ioctl(struct file *ffile, unsigned int cmd, unsigned long arg)
{
    HI_S32 Ret;

    Ret = HI_DRV_UserCopy(ffile->f_dentry->d_inode, ffile, cmd, arg, HDMIRX_Ioctl);

    return Ret;
}

static struct file_operations HDMIRX_FOPS =
{
    .owner          =  THIS_MODULE,
    .open           =  HDMIRX_DRV_Open,
    .unlocked_ioctl =  HDMIRX_DRV_Ioctl,
    .release        =  HDMIRX_DRV_Close,
};

/*****************************************************************************
 Prototype    : HDMIRX_Suspend
 Description  : 
 Input        : None
 Output       : None
 Return Value :
 Calls        :
 Called By    :
  History        :
  1.Date         : 2010/5/15
    Author       : weideng
    Modification : Created function
*****************************************************************************/
static HI_S32 HDMIRX_Suspend(PM_BASEDEV_S *pdev, pm_message_t state)
{
    //HI_FATAL_HDMIRX("HDMIRX suspend OK.\n");

    return 0;
}

/*****************************************************************************
 Prototype    : HDMIRX_Resume
 Description  : 
 Input        : None
 Output       : None
 Return Value :
 Calls        :
 Called By    :
  History        :
  1.Date         : 2010/5/15
    Author       : wei deng
    Modification : Created function
*****************************************************************************/
static HI_S32 HDMIRX_Resume(PM_BASEDEV_S *pdev)
{
    //HI_FATAL_HDMIRX("HDMIRX resume OK.\n");
    
    return 0;
}

static PM_BASEOPS_S HDMIRX_DRVOPS = {
    .probe        = NULL,
    .remove       = NULL,
    .shutdown     = NULL,
    .prepare      = NULL,
    .complete     = NULL,
    .suspend      = HDMIRX_Suspend,
    .suspend_late = NULL,
    .resume_early = NULL,
    .resume       = HDMIRX_Resume,
};

HI_S32 HDMIRX_DRV_ModInit(HI_VOID)
{
    HI_S32      Ret;

    Ret = HI_DRV_MODULE_Register(HI_ID_HDMIRX, HDMIRX_NAME, HI_NULL);
    if(HI_SUCCESS != Ret)
    {
        HDMIRX_DEBUG("ERR: HI_DRV_MODULE_Register, Ret = %#x!\n", Ret);
        return HI_FAILURE;
    }

    snprintf(g_HdmirxRegisterData.devfs_name,sizeof(g_HdmirxRegisterData.devfs_name), "%s",UMAP_DEVNAME_HDMIRX);

    g_HdmirxRegisterData.fops = &HDMIRX_FOPS;
    g_HdmirxRegisterData.minor = UMAP_MIN_MINOR_HDMIRX;
    g_HdmirxRegisterData.owner  = THIS_MODULE;
    g_HdmirxRegisterData.drvops = &HDMIRX_DRVOPS;
    if (HI_DRV_DEV_Register(&g_HdmirxRegisterData) < 0)
    {
        HDMIRX_DEBUG("register HDMIRX failed.\n");
        goto err_mod;
    }

    Ret = HDMIRX_Create();
    if (Ret != HI_SUCCESS)
    {
        HDMIRX_DEBUG("HDMIRX PROC Create Fail!\n");
        goto err_proc;
    }

    HDMI_Connect();

    HDMIRX_DEBUG("[%s] module initialized\n", HI_MOD_HDMIRX);
    
    return HI_SUCCESS;
    
err_proc:
    HI_DRV_DEV_UnRegister(&g_HdmirxRegisterData);
err_mod:
    HI_DRV_MODULE_UnRegister(HI_ID_HDMIRX);

    return Ret;
}

HI_VOID HDMIRX_DRV_ModExit(HI_VOID)
{
    HDMI_DisConnect();
    HDMIRX_Destroy();
    HI_DRV_DEV_UnRegister(&g_HdmirxRegisterData);
    HI_DRV_MODULE_UnRegister(HI_ID_HDMIRX);
    
}

#ifdef MODULE
module_init(HDMIRX_DRV_ModInit);
module_exit(HDMIRX_DRV_ModExit);
#endif

MODULE_AUTHOR("HISILICON");
MODULE_LICENSE("GPL");

#ifdef __cplusplus
#if __cplusplus
}
#endif
#endif
