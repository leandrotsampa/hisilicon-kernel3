#include <linux/device.h>
#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/fs.h>
#include <asm/uaccess.h>
#include <asm/io.h>
#include <asm/delay.h>
#include <linux/poll.h>
#include <mach/hardware.h>
#include <linux/interrupt.h>
#include <linux/slab.h>

#include "hi_kernel_adapt.h"
#include "hi_drv_dev.h"
#include "hi_drv_module.h"
#include "hi_drv_proc.h"
#include "drv_ci_ioctl.h"
#include "drv_ci_ext.h"
#include "hal_ci.h"

typedef enum
{
    CI_PROC_SETACCESSMODE = 0,
    CI_PROC_TSBYPASSCTRL,
    CI_PROC_IOPRINTCTRL,
    CI_PROC_BUTT
} CI_PROC_COMMAND_E;

static UMAP_DEVICE_S g_CiRegisterData;
static atomic_t s_CICount = ATOMIC_INIT(0);
static HI_BOOL s_bSupportStandby = HI_FALSE;

HI_S32 CI_ProcRead(struct seq_file *p, HI_VOID *v)
{
    HI_UNF_CI_PORT_E enCIPort;
    HI_UNF_CI_PCCD_E enCardId;
    CI_PCCD_DEBUGINFO_S stDebugInfo;
    HI_S32 s32Ret;

    for (enCIPort = HI_UNF_CI_PORT_0; enCIPort < HI_UNF_CI_PORT_BUTT; enCIPort++)
    {
        for (enCardId = HI_UNF_CI_PCCD_A; enCardId < HI_UNF_CI_PCCD_BUTT; enCardId++)
        {
            PROC_PRINT(p, "----Hisilicon CI[%d] PCCD[%d] Info----\n", enCIPort, enCardId);

            stDebugInfo.enStatus = HI_UNF_CI_PCCD_STATUS_ABSENT;
            stDebugInfo.enReady = HI_UNF_CI_PCCD_BUSY;
            stDebugInfo.enAccessMode = HI_UNF_CI_PCCD_ACCESS_ATTR;
            stDebugInfo.bByPass = HI_TRUE;

            /* Get status */
            s32Ret = CI_PCCD_GetDebugInfo(enCIPort, enCardId, &stDebugInfo);

            switch (s32Ret)
            {
            case HI_SUCCESS:
            {
                /* Output detect status */
                switch (stDebugInfo.enStatus)
                {
                case HI_UNF_CI_PCCD_STATUS_PRESENT:
                    PROC_PRINT(p, "Detect:\t\tpresent\n");
                    break;

                case HI_UNF_CI_PCCD_STATUS_ABSENT:
                default:
                    PROC_PRINT(p, "Detect:\t\tabsent\n");
                    break;
                }

                /* If card absent, break */
                if (HI_UNF_CI_PCCD_STATUS_ABSENT == stDebugInfo.enStatus)
                {
                    break;
                }

                /* Ready or busy */
                switch (stDebugInfo.enReady)
                {
                case HI_UNF_CI_PCCD_READY:
                    PROC_PRINT(p, "Card:\t\tready\n");
                    break;

                case HI_UNF_CI_PCCD_BUSY:
                default:
                    PROC_PRINT(p, "Card:\t\tbusy\n");
                    break;
                }

                /* Access mode */
                switch (stDebugInfo.enAccessMode)
                {
                case HI_UNF_CI_PCCD_ACCESS_ATTR:
                    PROC_PRINT(p, "AccessMode:\tAttr\n");
                    break;

                case HI_UNF_CI_PCCD_ACCESS_IO:
                    PROC_PRINT(p, "AccessMode:\tIO\n");
                    break;

                case HI_UNF_CI_PCCD_ACCESS_COMMON:
                    PROC_PRINT(p, "AccessMode:\tCommon\n");
                    break;

                default:
                    PROC_PRINT(p, "AccessMode:\tUnknown\n");
                    break;
                }

                /* TS mode */
                switch (stDebugInfo.bByPass)
                {
                case HI_TRUE:
                    PROC_PRINT(p, "TS Mode:\tByPass\n");
                    break;

                case HI_FALSE:
                default:
                    PROC_PRINT(p, "TS Mode:\tPass through\n");
                    break;
                }

                PROC_PRINT(p, "CI PLUS:\t%c\n", stDebugInfo.bIsCiplus ? 'Y' : 'N');
                PROC_PRINT(p, "Buffer size:\t%d\n", stDebugInfo.u16BufferSize);
                PROC_PRINT(p, "IO Read Cnt:\t%d\n", stDebugInfo.u32IOCnt);

                switch (stDebugInfo.stAttr.enDevType)
                {
                case HI_UNF_CI_DEV_CIMAX:
                    PROC_PRINT(p, "DEV TYPE:\tCIMAX\n");
                    PROC_PRINT(p, "SMIBitWidth:\t0x%x\n", stDebugInfo.stAttr.unDevAttr.stCIMaX.u32SMIBitWidth);         /**< SMI Bit Width */
                    PROC_PRINT(p, "SMIBaseAddr:\t0x%x\n", stDebugInfo.stAttr.unDevAttr.stCIMaX.u32SMIBaseAddr);        /**< SMI Base Address */
                    PROC_PRINT(p, "I2cNum:\t0x%x\n", stDebugInfo.stAttr.unDevAttr.stCIMaX.u32I2cNum);              	 /**< I2C Group */
                    PROC_PRINT(p, "DevAddress:\t0x%x\n", stDebugInfo.stAttr.unDevAttr.stCIMaX.u8DevAddress);           /**< I2C device address */
                    break;

                case HI_UNF_CI_DEV_CIMAXPLUS:
                    PROC_PRINT(p, "DEV TYPE:\tCIMAXPLUS\n");
                    PROC_PRINT(p, "ResetGpioNo:\t%d\n", stDebugInfo.stAttr.unDevAttr.stCIMaXPlus.u32ResetGpioNo); /**< The GPIO to reset the device */
                    PROC_PRINT(p, "IntGpioNo:\t%d\n", stDebugInfo.stAttr.unDevAttr.stCIMaXPlus.u32IntGpioNo);   /**< The GPIO to receive the device's Interrupt signal */
                    PROC_PRINT(p, "TsiSerialPort:\t%d\n", stDebugInfo.stAttr.unDevAttr.stCIMaXPlus.enTsiSerialPort[enCardId]); /**< The TSI serial port of device*/
                    PROC_PRINT(p, "CmdExchangeChan:\t%d\n", stDebugInfo.stAttr.unDevAttr.stCIMaXPlus.enCmdExchangeChan);     /**< The command exchange channel between the host and device*/
                    if (stDebugInfo.stAttr.unDevAttr.stCIMaXPlus.enCmdExchangeChan == HI_UNF_CI_CMD_EXCHANGE_CHAN_SPI)
                    {
                    	PROC_PRINT(p, "SPIDevNo:\t%d\n", stDebugInfo.stAttr.unDevAttr.stCIMaXPlus.u32SPIDevNo);           /**< The SPI device number*/
                    }
					
                    break;
                case HI_UNF_CI_DEV_HICI:
                    PROC_PRINT(p, "DEV TYPE:\tHICI\n");
                    PROC_PRINT(p, "Power Ctrl By Gpio:\t%c\n", stDebugInfo.stAttr.unDevAttr.stCIHICI.bIsPowerCtrlGpioUsed ? 'Y' : 'N');
                    PROC_PRINT(p, "Power Ctrl Gpio:\t%d\n", stDebugInfo.stAttr.unDevAttr.stCIHICI.u32PowerCtrlGpioNo[enCardId]);/**< The GPIO to power on/off the device */

                    break;
                default:
                    PROC_PRINT(p, "DEV TYPE:\tUnsupport\n");
                    break;
                }
                
                break;
            }

            case HI_ERR_CI_UNSUPPORT:
            {
                PROC_PRINT(p, "Unsupport.\n");
                break;
            }

            case HI_ERR_CI_NOT_INIT:
            {
                PROC_PRINT(p, "Close.\n");
                break;
            }

            default:
            {
                PROC_PRINT(p, "Get status fail: 0x%08x.\n", s32Ret);
                break;
            }
            }
        }
    }

    return HI_SUCCESS;
}

/* Print communication data */
HI_S32 CI_ProcWrite(struct file * file,
                    const char __user * buf, size_t count, loff_t *ppos)
{
    HI_CHAR *p;
    HI_CHAR *org;
    HI_UNF_CI_PORT_E enCIPort;
    HI_UNF_CI_PCCD_E enCardId;
    CI_PROC_COMMAND_E u32CMD;
    HI_U32 u32Param;
    HI_S32 s32Ret;
    HI_UNF_CI_PCCD_TSCTRL_PARAM_U unParam;

    if ((count == 7) || (count == 8))
    {
        p = (char *)__get_free_page(GFP_KERNEL);
        if (p == HI_NULL)
        {
            HI_DRV_PROC_EchoHelper("get_free_page failed\n");
            return HI_FAILURE;
        }
        memset(p, 0, PAGE_SIZE);
        if (copy_from_user(p, buf, count))
        {
            HI_DRV_PROC_EchoHelper("copy from user failed\n");
            return HI_FAILURE;
        }

        org = p;

        enCIPort = (HI_U32)simple_strtoul(p, &p, 10);
        enCardId = (HI_U32)simple_strtoul(p + 1, &p, 10);
        u32CMD   = (HI_U32)simple_strtoul(p + 1, &p, 10);
        u32Param = (HI_U32)simple_strtoul(p + 1, &p, 10);

        switch (u32CMD)
        {
        case CI_PROC_SETACCESSMODE:
        {
            s32Ret = CI_PCCD_SetAccessMode(enCIPort, enCardId, (HI_UNF_CI_PCCD_ACCESSMODE_E)u32Param);
            if (HI_SUCCESS != s32Ret)
            {
                HI_DRV_PROC_EchoHelper("SetAccessMode fail: 0x%08x\n", s32Ret);
            }

            break;
        }

        case CI_PROC_TSBYPASSCTRL:
        {
            unParam.stByPass.bByPass = u32Param;
            s32Ret = CI_PCCD_DbgTSCtrl(enCIPort, enCardId, HI_UNF_CI_PCCD_TSCTRL_BYPASS, (HI_VOID*)&unParam);
            if (HI_SUCCESS != s32Ret)
            {
                HI_DRV_PROC_EchoHelper("TSCtrl fail: 0x%08x\n", s32Ret);
            }

            break;
        }

        case CI_PROC_IOPRINTCTRL:
        {
            s32Ret = CI_PCCD_DbgIOPrintCtrl(enCIPort, enCardId, (HI_BOOL)u32Param);
            if (HI_SUCCESS != s32Ret)
            {
                HI_DRV_PROC_EchoHelper("IO print control fail: 0x%08x\n", s32Ret);
            }

            break;
        }

        default:
            break;
        }

        free_page((HI_U32)org);
        org = NULL;
        p = NULL;
    }
    else
    {
        HI_DRV_PROC_EchoHelper("Usage: echo P1 P2 P3 P4 > /proc/msp/ci\n");
        HI_DRV_PROC_EchoHelper("\tP1: CI Port, 0 or 1\n");
        HI_DRV_PROC_EchoHelper("\tP2: PC Card on CI Port, 0 or 1\n");
        HI_DRV_PROC_EchoHelper("\tP3: Command, 0 SetAccessMode, 1 TS bypass control, 2 Print IO data\n");
        HI_DRV_PROC_EchoHelper("\tP4: Value\n");
        HI_DRV_PROC_EchoHelper("\t\tFor SetAccessMode: 0 Attribute, 1 IO, 2 Common\n");
        HI_DRV_PROC_EchoHelper("\t\tFor TS bypass: 0 Pass through, 1 Bypass\n");
        HI_DRV_PROC_EchoHelper("\t\tFor Print IO data: 0 Close, 1 Open\n");
        HI_DRV_PROC_EchoHelper("Example:\n");
        HI_DRV_PROC_EchoHelper("\techo 0 0 1 1  > /proc/msp/ci ---> Set ts bypass\n");
        HI_DRV_PROC_EchoHelper("\techo 0 0 2 1  > /proc/msp/ci ---> Start print IO data\n");
        HI_DRV_PROC_EchoHelper("\techo 0 0 2 1  > /proc/msp/ci ---> stop print IO data\n");
    }

    return count;
}

HI_S32 CI_Ioctl(struct inode *inode, struct file *file, unsigned int cmd, HI_VOID *arg)
{
    HI_S32 s32Ret;

    switch (cmd)
    {
    case CMD_CI_OPEN:
    {
        s32Ret = CI_Open(*((HI_UNF_CI_PORT_E *)arg));
        break;
    }

    case CMD_CI_CLOSE:
    {
        CI_Close(*((HI_UNF_CI_PORT_E *)arg));
        s32Ret = HI_SUCCESS;
        break;
    }

    case CMD_CI_PCCD_OPEN:
    {
        CI_PCCD_S *pCiPCCD = (CI_PCCD_S *)arg;

        s32Ret = CI_PCCD_Open(pCiPCCD->enCIPort, pCiPCCD->enCardId);
        break;
    }

    case CMD_CI_PCCD_CLOSE:
    {
        CI_PCCD_S *pCiPCCD = (CI_PCCD_S *)arg;

        CI_PCCD_Close(pCiPCCD->enCIPort, pCiPCCD->enCardId);
        s32Ret = HI_SUCCESS;
        break;
    }

    case CMD_CI_PCCD_CTRLPOWER:
    {
        CI_PCCD_CTRLPOWER_S *pCiCtrlPower = (CI_PCCD_CTRLPOWER_S *)arg;

        s32Ret = CI_PCCD_CtrlPower(pCiCtrlPower->enCIPort, pCiCtrlPower->enCardId, pCiCtrlPower->enCtrlPower);
        break;
    }

    case CMD_CI_PCCD_RESET:
    {
        CI_PCCD_S *pCiPCCD = (CI_PCCD_S *)arg;

        s32Ret = CI_PCCD_Reset(pCiPCCD->enCIPort, pCiPCCD->enCardId);
        break;
    }

    case CMD_CI_PCCD_READY:
    {
        CI_PCCD_READY_S *pCiReady = (CI_PCCD_READY_S *)arg;

        s32Ret = CI_PCCD_IsReady(pCiReady->enCIPort, pCiReady->enCardId, pCiReady->penCardReady);
        break;
    }

    case CMD_CI_PCCD_DETECT:
    {
        CI_PCCD_DETECT_S *pCiDetect = (CI_PCCD_DETECT_S *)arg;

        s32Ret = CI_PCCD_Detect(pCiDetect->enCIPort, pCiDetect->enCardId, pCiDetect->penCardStatus);
        break;
    }

    case CMD_CI_PCCD_SET_ACCESSMODE:
    {
        CI_PCCD_ACCESSMODE_S *pCiAccessMode = (CI_PCCD_ACCESSMODE_S *)arg;

        s32Ret = CI_PCCD_SetAccessMode(pCiAccessMode->enCIPort, pCiAccessMode->enCardId, pCiAccessMode->enAccessMode);
        break;
    }

    case CMD_CI_PCCD_GET_STATUS:
    {
        CI_PCCD_STATUS_S *pCiStatus = (CI_PCCD_STATUS_S *)arg;

        s32Ret = CI_PCCD_GetStatus(pCiStatus->enCIPort, pCiStatus->enCardId, pCiStatus->pu8Value);
        break;
    }

    case CMD_CI_PCCD_READ:
    {
        CI_PCCD_READ_S *pCiRead = (CI_PCCD_READ_S *)arg;

        s32Ret = CI_PCCD_IORead(pCiRead->enCIPort, pCiRead->enCardId, pCiRead->pu8Buffer, pCiRead->pu32ReadLen);
        break;
    }

    case CMD_CI_PCCD_WRITE:
    {
        CI_PCCD_WRITE_S *pCiWrite = (CI_PCCD_WRITE_S *)arg;

        s32Ret = CI_PCCD_IOWrite(pCiWrite->enCIPort, pCiWrite->enCardId,
                                 pCiWrite->pu8Buffer, pCiWrite->u32WriteLen, pCiWrite->pu32WriteOKLen);
        break;
    }

    case CMD_CI_PCCD_CHECKCIS:
    {
        CI_PCCD_S *pCiPCCD = (CI_PCCD_S *)arg;

        s32Ret = CI_PCCD_CheckCIS(pCiPCCD->enCIPort, pCiPCCD->enCardId);
        break;
    }

    case CMD_CI_PCCD_WRITECOR:
    {
        CI_PCCD_S *pCiPCCD = (CI_PCCD_S *)arg;

        s32Ret = CI_PCCD_WriteCOR(pCiPCCD->enCIPort, pCiPCCD->enCardId);
        break;
    }

    case CMD_CI_PCCD_IORESET:
    {
        CI_PCCD_S *pCiPCCD = (CI_PCCD_S *)arg;

        s32Ret = CI_PCCD_IOReset(pCiPCCD->enCIPort, pCiPCCD->enCardId);
        break;
    }

    case CMD_CI_PCCD_NEG_BUFFERSIZE:
    {
        CI_PCCD_BUFFERSIZE_S *pCiBufferSize = (CI_PCCD_BUFFERSIZE_S *)arg;

        s32Ret = CI_PCCD_NegBufferSize(pCiBufferSize->enCIPort, pCiBufferSize->enCardId, pCiBufferSize->pu16BufferSize);
        break;
    }

    case CMD_CI_PCCD_TSCTRL:
    {
        CI_PCCD_TSCTRL_S *pCiTSCtrl = (CI_PCCD_TSCTRL_S *)arg;

        s32Ret = CI_PCCD_TSCtrl(pCiTSCtrl->enCIPort, pCiTSCtrl->enCardId, pCiTSCtrl->enCMD, pCiTSCtrl->pParam);
        break;
    }

    /* Added begin 2012-04-24 l00185424: support various CI device */
    case CMD_CI_SETATTR:
    {
        CI_ATTR_S *pCiAttr = (CI_ATTR_S *)arg;

        s32Ret = CI_SetAttr(pCiAttr->enCIPort, pCiAttr->stCIAttr);
        break;
    }

    case CMD_CI_GETATTR:
    {
        CI_ATTR_S *pCiAttr = (CI_ATTR_S *)arg;

        s32Ret = CI_GetAttr(pCiAttr->enCIPort, &(pCiAttr->stCIAttr));
        break; 
    }
    
    case CMD_CI_PCCD_GETCIS:
    {
        CI_PCCD_CIS_S *pCIS = (CI_PCCD_CIS_S *)arg;

        s32Ret = CI_PCCD_GetCIS(pCIS->enCIPort, pCIS->enCardId, pCIS->pu8Buffer, pCIS->pu32CisLen);
        break;
    }
        
    case CMD_CI_PCCD_WRITECOREX:
    {
        CI_PCCD_COR_S *pCOR = (CI_PCCD_COR_S *)arg;

        s32Ret = CI_PCCD_WriteCOREx(pCOR->enCIPort, pCOR->enCardId, pCOR->u16Addr, pCOR->u8Data);
        break;
    }
    
    /* Added end 2012-04-24 l00185424: support various CI device */

    default:
    {
        HI_ERR_CI("Unknow cmd, MOD_ID=0x%02X, NR=0x%02x!\n", _IOC_TYPE (cmd), _IOC_NR (cmd));
        s32Ret = HI_FAILURE;
        break;
    }
    }

    return s32Ret;
}

static HI_S32 CI_DRV_Open(struct inode *inode, struct file *filp)
{
    HI_S32 s32Ret = HI_SUCCESS;

    if (1 == atomic_inc_return(&s_CICount))
    {
        s32Ret = CI_Init();
        s_bSupportStandby = HI_TRUE;
    }

    return s32Ret;
}

static HI_S32 CI_DRV_Close(struct inode *inode, struct file *filp)
{
    HI_UNF_CI_PORT_E enCIPort;

    if (atomic_dec_and_test(&s_CICount))
    {
        /* Every port close */
        for (enCIPort = HI_UNF_CI_PORT_0; enCIPort < HI_UNF_CI_PORT_BUTT; enCIPort++)
        {
            CI_Close(enCIPort);
        }

        CI_DeInit();
        s_bSupportStandby = HI_FALSE;
    }
    return 0;
}

static long CI_DRV_Ioctl(struct file *ffile, unsigned int cmd, unsigned long arg)
{
    long Ret;
    Ret = (long)HI_DRV_UserCopy(ffile->f_dentry->d_inode, ffile, cmd, arg, CI_Ioctl);
    return Ret;    
}

static struct file_operations CI_FOPS =
{
    .owner          = THIS_MODULE,
    .open           = CI_DRV_Open,
    .unlocked_ioctl = CI_DRV_Ioctl,
    .release        = CI_DRV_Close,
};

static HI_S32 ci_pm_suspend(PM_BASEDEV_S *pdev, pm_message_t state)
{
    HI_S32 s32Ret;
    HI_UNF_CI_PORT_E enCIPort;

    /* If didn't been init, can't standby. */
    if (s_bSupportStandby)
    {
        /* Every port standby */
        for (enCIPort = HI_UNF_CI_PORT_0; enCIPort < HI_UNF_CI_PORT_BUTT; enCIPort++)
        {
            s32Ret = CI_Standby(enCIPort);

            /* Standby fail handling */
            if (!((HI_SUCCESS == s32Ret) || (HI_ERR_CI_NOT_INIT == s32Ret)))
            {
                HI_ERR_CI("CI_Standby %d fail: 0x%08x!\n", enCIPort, s32Ret);
            }
        }
    }

    HI_PRINT("CI suspend OK\n");
    return HI_SUCCESS;
}

static HI_S32 ci_pm_resume(PM_BASEDEV_S *pdev)
{
    HI_S32 s32Ret;
    HI_UNF_CI_PORT_E enCIPort;

    /* If didn't been init, can't resume. */
    if (s_bSupportStandby)
    {
        /* Every port resume */
        for (enCIPort = HI_UNF_CI_PORT_0; enCIPort < HI_UNF_CI_PORT_BUTT; enCIPort++)
        {
            s32Ret = CI_Resume(enCIPort);

            /* fail handling */
            if (!((HI_SUCCESS == s32Ret) || (HI_ERR_CI_NOT_INIT == s32Ret)))
            {
                HI_ERR_CI("CI_Resume %d fail: 0x%08x!\n", enCIPort, s32Ret);
            }
        }
    }

    HI_PRINT("CI resume OK\n");
    return HI_SUCCESS;
}

static PM_BASEOPS_S ci_drvops =
{
    .probe        = NULL,
    .remove       = NULL,
    .shutdown     = NULL,
    .prepare      = NULL,
    .complete     = NULL,
    .suspend      = ci_pm_suspend,
    .suspend_late = NULL,
    .resume_early = NULL,
    .resume       = ci_pm_resume,
};

HI_S32 CI_DRV_ModInit(HI_VOID)
{
    DRV_PROC_ITEM_S  *pProcItem;

    snprintf(g_CiRegisterData.devfs_name, sizeof(g_CiRegisterData.devfs_name), UMAP_DEVNAME_CI);
    g_CiRegisterData.minor  = UMAP_MIN_MINOR_CI;
    g_CiRegisterData.owner  = THIS_MODULE;
    g_CiRegisterData.drvops = &ci_drvops;
    g_CiRegisterData.fops = &CI_FOPS;

    /* CI device regeister */
    if (HI_DRV_DEV_Register(&g_CiRegisterData) < 0)
    {
        HI_FATAL_CI("register CI failed.\n");
        return HI_FAILURE;
    }
    
    if (HI_DRV_MODULE_Register(HI_ID_CI, MODULE_CI, HI_NULL) < 0)
    {
        HI_FATAL_CI("Register CI module failed.\n");
        HI_DRV_DEV_UnRegister(&g_CiRegisterData);
        return HI_FAILURE;
    }

    /* register SCI proc function*/
    pProcItem = HI_DRV_PROC_AddModule(HI_MOD_CI, HI_NULL, HI_NULL);
    if (!pProcItem)
    {
        HI_FATAL_CI("add ci proc failed.\n");
        HI_DRV_MODULE_UnRegister(HI_ID_CI);
        HI_DRV_DEV_UnRegister(&g_CiRegisterData);
        return HI_FAILURE;
    }

    pProcItem->read  = CI_ProcRead;
    pProcItem->write = CI_ProcWrite;

#ifdef MODULE
    HI_PRINT("Load hi_ci.ko success.  \t(%s)\n", VERSION_STRING);
#endif

    return HI_SUCCESS;
}

HI_VOID CI_DRV_ModExit(HI_VOID)
{
    HI_DRV_PROC_RemoveModule(HI_MOD_CI);
    HI_DRV_MODULE_UnRegister(HI_ID_CI);
    HI_DRV_DEV_UnRegister(&g_CiRegisterData);

#ifdef MODULE
    HI_PRINT("Unload hi_ci.ko success.  \t(%s)\n", VERSION_STRING);
#endif

    return;
}

#ifdef MODULE
module_init(CI_DRV_ModInit);
module_exit(CI_DRV_ModExit);
#endif

MODULE_AUTHOR("HISILICON");
MODULE_LICENSE("GPL");
