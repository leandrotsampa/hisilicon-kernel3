/*
 * Copyright (c) (2014 - ...) Device Chipset Source Algorithm and Chipset Platform Development Dept
 * Hisilicon. All rights reserved.
 *
 * File:    omxvdec.c
 *
 * Purpose: omxvdec main entry
 *
 * Author:  yangyichang 00226912
 *
 * Date:    26, 11, 2014
 *
 */

#include <linux/platform_device.h>

#include "omxvdec.h"
#include "channel.h"
#include "task.h"


/*================ EXTERN VALUE ================*/
extern HI_BOOL  g_FrameRateLimit;
extern HI_BOOL  g_DeInterlaceEnable;
extern HI_BOOL  g_BypassVpss;
extern HI_BOOL  g_DynamicFsEnable;
extern HI_BOOL  g_LowDelayStatistics;
extern HI_U32   g_DispNum;
extern HI_U32   g_SegSize;         // (M)
extern HI_BOOL  g_RawMoveEnable;   // 码流搬移使能标志，解决scd切割失败不释放码流的情况
extern HI_BOOL  g_FastOutputMode;

/*=================== MACRO ====================*/
#ifndef HI_ADVCA_FUNCTION_RELEASE

#define DBG_CMD_LEN             (256)
#define DBG_CMD_START           "start"
#define DBG_CMD_STOP            "stop"
#define DBG_CMD_ON              "on"
#define DBG_CMD_OFF             "off"
#define DBG_CMD_FRAME_RATE      "limit_framerate"
#define DBG_CMD_RAW             "save_raw"
#define DBG_CMD_YUV             "save_yuv"
#define DBG_CMD_PATH            "save_path"
#define DBG_CMD_TRACE           "set_print"
#define DBG_CMD_NAME            "set_SaveName"
#define DBG_CMD_RAWMOVE         "set_rawmove"
#define DBG_CMD_DEI             "set_dei"
#define DBG_CMD_BYPASS          "set_bypass"
#define DBG_CMD_FAST_OUTPUT     "set_fastoutput"
#define DBG_CMD_DISPNUM         "set_dispnum"
#define DBG_CMD_SEGSIZE         "set_segsize"
#define DBG_CMD_DFS             "set_dfs"
#define DBG_CMD_LOWDELAY_TIME   "set_LD"
#define DBG_CMD_LD_CNT_FRM      "set_LDCountFrm"
#define DBG_CMD_HELP            "help"
#endif

/*================ GLOBAL VALUE ================*/


HI_U32   g_TraceOption           = 0; //(1<<OMX_FATAL)+(1<<OMX_ERR);
HI_BOOL  g_SaveRawEnable         = HI_FALSE;
HI_BOOL  g_SaveYuvEnable         = HI_FALSE;

#ifndef HI_ADVCA_FUNCTION_RELEASE
HI_CHAR  g_SavePath[PATH_LEN]    = {'/','m','n','t','\0'};
HI_CHAR  g_SaveName[NAME_LEN]    = {'o','m','x','\0'};
HI_U32   g_SaveNum               = 0;
#endif
HI_U32   g_lowdelay_count_frame  = 100;
extern HI_BOOL  g_FastOutputMode;
OMXVDEC_ENTRY  *g_OmxVdec               = HI_NULL;
OMXVDEC_FUNC    g_stOmxFunc             = {HI_NULL};


/*================ STATIC VALUE ================*/
static struct class *g_OmxVdecClass     = HI_NULL;
static const HI_CHAR g_OmxVdecDrvName[] = OMXVDEC_NAME;
static dev_t         g_OmxVdecDevNum;

MODULE_DESCRIPTION("omxvdec driver");
MODULE_AUTHOR("y00226912, 2013-03-14");
MODULE_LICENSE("GPL");

#ifdef VFMW_VPSS_BYPASS_EN
static HI_VOID OMXVDEC_List_Init(OMXVDEC_List_S *pList);
static HI_VOID OMXVDEC_List_Deinit(OMXVDEC_List_S *pList);
static HI_S32 omxvdec_get_occoupied_frame_info(OMXVDEC_PROC_OCCOUPY_FRAME_INFO *p_proc_occoupy_frame);
#endif


/* ==========================================================================
 * FUNTION
 * =========================================================================*/
HI_VOID omxvdec_release_mem(HI_VOID *pBuffer, eMEM_ALLOC eMemAlloc)
{
	MMZ_BUFFER_S *pTmpBuffer = HI_NULL;

	OMXVDEC_ASSERT_RETURN_NULL(pBuffer != HI_NULL, "invalid param");

	pTmpBuffer= (MMZ_BUFFER_S *)pBuffer;

	if (pTmpBuffer->u32Size == 0 || pTmpBuffer->u32StartPhyAddr == HI_NULL)
	{
	    OmxPrint(OMX_WARN, "%s Can NOT releae mem: size:%d addr:0x%x\n", __func__, pTmpBuffer->u32Size, pTmpBuffer->u32StartPhyAddr);

		return;
	}

    switch (eMemAlloc)
	{
	    case ALLOC_BY_MMZ:
            {
    		    HI_DRV_OMXVDEC_UnmapAndRelease(pTmpBuffer);
    		    break;
            }

	    case ALLOC_BY_MMZ_UNMAP:
            {
    		    HI_DRV_OMXVDEC_Release(pTmpBuffer, 0);
    		    break;
            }

	    case ALLOC_BY_SEC:
            {
                HI_DRV_OMXVDEC_Release(pTmpBuffer, 1);
    			break;
            }

    #if (1 == PRE_ALLOC_VDEC_VDH_MMZ)
	    case ALLOC_BY_PRE:
            {
                VDEC_Chan_ReleasePreMMZ(pTmpBuffer);
		        break;
            }
	#endif

	    default:
            {
		        OmxPrint(OMX_FATAL, "%s invalid eMemAlloc = %d\n", __func__, eMemAlloc);
    			break;
            }
	}

    memset(pBuffer, 0, sizeof(MMZ_BUFFER_S));

    return;
}

/* ==========================================================================
 * omxvdec device mode
 * =========================================================================*/
static HI_S32 omxvdec_setup_cdev(OMXVDEC_ENTRY *omxvdec, const struct file_operations *fops)
{
	HI_S32 rc = -ENODEV;
	struct device *dev;

	g_OmxVdecClass = class_create(THIS_MODULE, "omxvdec_class");
	if (IS_ERR(g_OmxVdecClass))
    {
        rc = PTR_ERR(g_OmxVdecClass);
		g_OmxVdecClass = HI_NULL;
        OmxPrint(OMX_FATAL, "%s call class_create failed, rc = %d\n", __func__, rc);
		return rc;
	}

	rc = alloc_chrdev_region(&g_OmxVdecDevNum, 0, 1, "hisi video decoder");
	if (rc)
    {
        OmxPrint(OMX_FATAL, "%s call alloc_chrdev_region failed, rc = %d\n", __func__, rc);
		goto cls_destroy;
	}

	dev = device_create(g_OmxVdecClass, NULL, g_OmxVdecDevNum, NULL, OMXVDEC_NAME);
	if (IS_ERR(dev))
    {
        rc = PTR_ERR(dev);
        OmxPrint(OMX_FATAL, "%s call device_create failed, rc = %d\n", __func__, rc);
		goto unregister_region;
	}

	cdev_init(&omxvdec->cdev, fops);
	omxvdec->cdev.owner = THIS_MODULE;
	omxvdec->cdev.ops = fops;
	rc = cdev_add(&omxvdec->cdev, g_OmxVdecDevNum , 1);
	if (rc < 0)
    {
        OmxPrint(OMX_FATAL, "%s call cdev_add failed, rc = %d\n", __func__, rc);
		goto dev_destroy;
	}

	return HI_SUCCESS;

dev_destroy:
	device_destroy(g_OmxVdecClass, g_OmxVdecDevNum);
unregister_region:
	unregister_chrdev_region(g_OmxVdecDevNum, 1);
cls_destroy:
	class_destroy(g_OmxVdecClass);
    g_OmxVdecClass = HI_NULL;

	return rc;
}

static HI_S32 omxvdec_cleanup_cdev(OMXVDEC_ENTRY *omxvdec)
{
    if (HI_NULL == g_OmxVdecClass)
    {
        OmxPrint(OMX_FATAL, "%s FATAL: g_OmxVdecClass = NULL", __func__);
		return HI_FAILURE;
    }
	else
	{
		cdev_del(&omxvdec->cdev);
		device_destroy(g_OmxVdecClass, g_OmxVdecDevNum);
		unregister_chrdev_region(g_OmxVdecDevNum, 1);
		class_destroy(g_OmxVdecClass);
		return HI_SUCCESS;
	}
}

/* ==========================================================================
 * HI_CHAR device ops functions
 * =========================================================================*/
static HI_S32 omxvdec_open(struct inode *inode, struct file *fd)
{
	HI_S32  ret = -EBUSY;
	unsigned long  flags;
	OMXVDEC_ENTRY *omxvdec = HI_NULL;

	OmxPrint(OMX_TRACE, "omxvdec prepare to open.\n");

	omxvdec = container_of(inode->i_cdev, OMXVDEC_ENTRY, cdev);

	spin_lock_irqsave(&omxvdec->lock, flags);
	if (omxvdec->open_count < MAX_OPEN_COUNT)
    {
        omxvdec->open_count++;

        if (1 == omxvdec->open_count)
        {
           spin_unlock_irqrestore(&omxvdec->lock, flags);

           memset(&g_stOmxFunc, 0, sizeof(OMXVDEC_FUNC));

           ret = channel_init();
           if(ret != HI_SUCCESS)
           {
               OmxPrint(OMX_FATAL, "%s init channel failed!\n", __func__);
               goto error;
           }

           if (HI_TRUE == g_DynamicFsEnable && HI_NULL == omxvdec->task.task_thread)
           {
               ret = task_create_thread(omxvdec);
               if (ret != HI_SUCCESS)
               {
                   OmxPrint(OMX_FATAL, "%s call channel_create_task failed!\n", __func__);
                   goto error1;
               }
           }

           OMX_PTSREC_Init();

           spin_lock_irqsave(&omxvdec->lock, flags);
        }

        fd->private_data = omxvdec;

        OmxPrint(OMX_TRACE, "omxvdec open ok.\n");
        ret = HI_SUCCESS;
	}
    else
    {
        OmxPrint(OMX_FATAL, "%s open omxvdec instance too much! \n", __func__);
		ret = -EBUSY;
	}
	spin_unlock_irqrestore(&omxvdec->lock, flags);

	return ret;

error1:
    channel_exit();
error:
    omxvdec->open_count--;
    return ret;

}

static HI_S32 omxvdec_release(struct inode *inode, struct file *fd)
{
	unsigned long     flags;
	OMXVDEC_ENTRY	 *omxvdec = HI_NULL;
	OMXVDEC_CHAN_CTX *pchan   = HI_NULL;
	OMXVDEC_CHAN_CTX *n       = HI_NULL;

	OmxPrint(OMX_TRACE, "omxvdec prepare to release.\n");

    omxvdec = fd->private_data;
    if (HI_NULL == omxvdec)
    {
	    OmxPrint(OMX_FATAL, "%s: omxvdec = null, error!\n", __func__);
	    return -EFAULT;
    }

	spin_lock_irqsave(&omxvdec->channel_lock, flags);
	if (!list_empty(&omxvdec->chan_list))
    {
		list_for_each_entry_safe(pchan, n, &omxvdec->chan_list, chan_list)
        {
             if ((pchan->file_dec == (HI_U32*)fd) && (CHAN_STATE_INVALID != pchan->state))
             {
                 spin_unlock_irqrestore(&omxvdec->channel_lock, flags);
                 channel_release_inst(pchan);
                 spin_lock_irqsave(&omxvdec->channel_lock, flags);
             }
        }
	}
	spin_unlock_irqrestore(&omxvdec->channel_lock, flags);

	spin_lock_irqsave(&omxvdec->lock, flags);
	if(omxvdec->open_count > 0)
    {
        omxvdec->open_count--;
    }
	spin_unlock_irqrestore(&omxvdec->lock, flags);

    if(0 == omxvdec->open_count)
    {
        channel_exit();
        task_destroy_thread(omxvdec);
        OMX_PTSREC_DeInit();
    }

	fd->private_data = HI_NULL;
    memset(&g_stOmxFunc, 0, sizeof(OMXVDEC_FUNC));

	OmxPrint(OMX_TRACE, "omxvdec release ok.\n");

	return 0;
}

static long omxvdec_ioctl(struct file *fd, unsigned int code, unsigned long arg)
{
    HI_S32 ret        = HI_FAILURE;
    HI_S32 chan_id = -1;
    ePORT_DIR flush_dir;
    OMXVDEC_MSG_INFO msg;
    OMXVDEC_DRV_CFG chan_cfg;
    OMXVDEC_IOCTL_MSG vdec_msg;
    OMXVDEC_BUF_DESC  user_buf;

    OMXVDEC_CHAN_CTX *pchan   = HI_NULL;
    HI_VOID          *u_arg   = (HI_VOID *)arg;
    OMXVDEC_ENTRY	 *omxvdec = fd->private_data;

#ifdef VFMW_VPSS_BYPASS_EN
    HI_BOOL vpssBypassEn = 0;
#endif
    if (copy_from_user(&vdec_msg, u_arg, sizeof(OMXVDEC_IOCTL_MSG)))
    {
        OmxPrint(OMX_FATAL, "%s call copy_from_user failed! \n", __func__);
        return -EFAULT;
    }

    if (code != VDEC_IOCTL_CHAN_CREATE)
    {
        chan_id = vdec_msg.chan_num;
        if (chan_id < 0)
        {
            OmxPrint(OMX_FATAL, "%s Invalid Chan Num: %d.\n", __func__, chan_id);
            return -EINVAL;
        }

        pchan = channel_find_inst_by_channel_id(omxvdec, chan_id);
        if (HI_NULL == pchan)
        {
            OmxPrint(OMX_ERR, "%s can't find Chan(%d).\n", __func__, chan_id);
            return -EFAULT;
        }
    }

    /* handle ioctls */
    switch (code)
    {
        /* when alloc buffer in omx ,we need to sync it with omxvdec, because the buffer is share with omx
        & player & driver, here we use a input/output buf table to record its info */

        case VDEC_IOCTL_CHAN_BIND_BUFFER:
            if (copy_from_user(&user_buf, (VOID *)(HI_SIZE_T)vdec_msg.in, sizeof(OMXVDEC_BUF_DESC)))
            {
                OmxPrint(OMX_FATAL, "%s %d: case call copy_from_user failed!\n", __func__, __LINE__);
                return -EIO;
            }

            ret = channel_bind_user_buffer(pchan, &user_buf);
            if (ret != HI_SUCCESS)
            {
                OmxPrint(OMX_FATAL, "%s %d: case call bind_buffer failed!\n", __func__, __LINE__);
                return -EFAULT;
            }
            break;

        case VDEC_IOCTL_CHAN_UNBIND_BUFFER:
            if (copy_from_user(&user_buf, (VOID *)(HI_SIZE_T)vdec_msg.in, sizeof(OMXVDEC_BUF_DESC)))
            {
                OmxPrint(OMX_FATAL, "%s %d: case call copy_from_user failed!\n", __func__, __LINE__);
                return -EIO;
            }

            ret = channel_unbind_user_buffer(pchan, &user_buf);
            if (ret != HI_SUCCESS)
            {
                OmxPrint(OMX_FATAL, "%s %d: case call unbind_buffer failed!\n", __func__, __LINE__);
                return -EFAULT;
            }
            break;

        case VDEC_IOCTL_EMPTY_INPUT_STREAM:
            if (copy_from_user(&user_buf, (VOID *)(HI_SIZE_T)vdec_msg.in, sizeof(OMXVDEC_BUF_DESC)))
            {
                OmxPrint(OMX_FATAL, "%s %d: case call copy_from_user failed!\n", __func__, __LINE__);
                return -EIO;
            }

            ret = channel_empty_this_stream(pchan, &user_buf);
            if (ret != HI_SUCCESS)
            {
                OmxPrint(OMX_FATAL, "%s %d: case call empty_stream failed!\n", __func__, __LINE__);
                return -EFAULT;
            }
            break;

        case VDEC_IOCTL_FILL_OUTPUT_FRAME:
            if (copy_from_user(&user_buf, (VOID *)(HI_SIZE_T)vdec_msg.in, sizeof(OMXVDEC_BUF_DESC)))
            {
                OmxPrint(OMX_FATAL, "%s %d: case call copy_from_user failed!\n", __func__, __LINE__);
                return -EIO;
            }

            ret = channel_fill_this_frame(pchan, &user_buf);
            if (ret != HI_SUCCESS)
            {
                OmxPrint(OMX_FATAL, "%s %d: case call fill_frame failed!\n", __func__, __LINE__);
                return -EFAULT;
            }
            break;

        case VDEC_IOCTL_FLUSH_PORT:
            if (copy_from_user(&flush_dir, (VOID *)(HI_SIZE_T)vdec_msg.in, sizeof(ePORT_DIR)))
            {
                OmxPrint(OMX_FATAL, "%s %d: case call copy_from_user failed!\n", __func__, __LINE__);
                return -EFAULT;
            }

            ret = channel_flush_inst(pchan, flush_dir);
            if (ret != HI_SUCCESS)
            {
                OmxPrint(OMX_FATAL, "%s %d: case call flush_port failed!\n", __func__, __LINE__);
                return -EFAULT;
            }
            break;

        case VDEC_IOCTL_CHAN_GET_MSG:
            ret = channel_get_message(pchan, &msg);
            if (ret != HI_SUCCESS)
            {
                if (ret == -EAGAIN)
                {
                    OmxPrint(OMX_WARN, "%s %d: no msg found, try again.\n", __func__, __LINE__);
                    return -EAGAIN;
                }
                else
                {
                    OmxPrint(OMX_WARN, "%s %d: get msg error!\n", __func__, __LINE__);
                    return -EFAULT;
                }
            }

            if (copy_to_user((VOID *)(HI_SIZE_T)vdec_msg.out, &msg, sizeof(OMXVDEC_MSG_INFO)))
            {
                OmxPrint(OMX_FATAL, "%s %d: case call copy_from_user failed!\n", __func__, __LINE__);
                return -EIO;
            }
            break;

        case VDEC_IOCTL_CHAN_PAUSE:
            ret = channel_pause_inst(pchan);
            if (ret != HI_SUCCESS)
            {
                OmxPrint(OMX_FATAL, "%s %d: case call pause failed!\n", __func__, __LINE__);
                return -EFAULT;
            }
            break;

        case VDEC_IOCTL_CHAN_RESUME:
            ret = channel_resume_inst(pchan);
            if (ret != HI_SUCCESS)
            {
                OmxPrint(OMX_FATAL, "%s %d: case call resume failed!\n", __func__, __LINE__);
                return -EFAULT;
            }
            break;

        case VDEC_IOCTL_CHAN_START:
            ret = channel_start_inst(pchan);
            if (ret != HI_SUCCESS)
            {
                OmxPrint(OMX_FATAL, "%s %d: case call start failed!\n", __func__, __LINE__);
                return -EFAULT;
            }
            break;

        case VDEC_IOCTL_CHAN_STOP:
            ret = channel_stop_inst(pchan);
            if (ret != HI_SUCCESS)
            {
                OmxPrint(OMX_FATAL, "%s %d: case call stop failed!\n", __func__, __LINE__);
                return -EFAULT;
            }
            break;

        case VDEC_IOCTL_CHAN_CREATE:
            if (copy_from_user(&chan_cfg, (VOID *)(HI_SIZE_T)vdec_msg.in, sizeof(OMXVDEC_DRV_CFG)))
            {
                OmxPrint(OMX_FATAL, "%s %d: case call copy_from_user failed!\n", __func__, __LINE__);
                return -EFAULT;
            }

            chan_id = channel_create_inst(fd, &chan_cfg);
            if (chan_id < 0)
            {
                OmxPrint(OMX_FATAL, "%s %d: case call channel_create_inst failed!\n", __func__, __LINE__);
                return -EFAULT;
            }

            if (copy_to_user((VOID *)(HI_SIZE_T)vdec_msg.out, &chan_id, sizeof(HI_S32)))
            {
                OmxPrint(OMX_FATAL, "%s %d: case call copy_from_user failed!\n", __func__, __LINE__);
                return -EIO;
            }
            break;

        case VDEC_IOCTL_CHAN_RELEASE:
            ret = channel_release_inst(pchan);
            if (ret != HI_SUCCESS)
            {
                OmxPrint(OMX_FATAL, "%s %d: case call release failed!\n", __func__, __LINE__);
                return -EFAULT;
            }
            break;
#ifdef VFMW_VPSS_BYPASS_EN
        case VDEC_IOCTL_CHAN_RLS_FRM:
            if (copy_from_user(&user_buf, (VOID *)(HI_SIZE_T)vdec_msg.in, sizeof(OMXVDEC_BUF_DESC)))
            {
                OmxPrint(OMX_FATAL, "%s %d: case call copy_from_user failed!\n", __func__, __LINE__);
                return -EIO;
            }

            ret = channel_release_frame(pchan, &user_buf);
            if (ret != HI_SUCCESS)
            {
                OmxPrint(OMX_FATAL, "%s %d: case call VDEC_IOCTL_CHAN_RLS_FRM failed!\n", __func__, __LINE__);
                return -EFAULT;
            }
            break;

        case VDEC_IOCTL_CHAN_GET_BYPASS_INFO:
            if (copy_from_user(&chan_cfg, (VOID *)(HI_SIZE_T)vdec_msg.in, sizeof(OMXVDEC_DRV_CFG)))
            {
                OmxPrint(OMX_FATAL, "%s %d: case call copy_from_user failed!\n", __func__, __LINE__);
                return -EFAULT;
            }
            ret = channel_get_processor_bypass(pchan,&chan_cfg);
            if (ret != HI_SUCCESS)
            {
                OmxPrint(OMX_FATAL, "%s %d: case call VDEC_IOCTL_CHAN_GET_BYPASS_INFO failed!\n", __func__, __LINE__);
                return -EFAULT;
            }

			vpssBypassEn = pchan->bVpssBypass;

            if (copy_to_user((VOID *)(HI_SIZE_T)vdec_msg.out, &vpssBypassEn, sizeof(HI_BOOL)))
            {
                OmxPrint(OMX_FATAL, "%s %d: case call copy_from_user failed!\n", __func__, __LINE__);
                return -EIO;
            }
            break;
        case VDEC_IOCTL_CHAN_SET_BYPASS_INFO:
            if (copy_from_user(&chan_cfg, (VOID *)(HI_SIZE_T)vdec_msg.in, sizeof(OMXVDEC_DRV_CFG)))
            {
                OmxPrint(OMX_FATAL, "%s %d: case call copy_from_user failed!\n", __func__, __LINE__);
                return -EFAULT;
            }
			pchan->bVpssBypass = chan_cfg.bVpssBypass;
            ret = channel_set_processor_bypass(pchan);
            if (ret != HI_SUCCESS)
            {
                OmxPrint(OMX_FATAL, "%s %d: case call VDEC_IOCTL_CHAN_SET_BYPASS_INFO failed!\n", __func__, __LINE__);
                return -EFAULT;
            }
            break;
#endif
        default:
            /* could not handle ioctl */
            OmxPrint(OMX_FATAL, "%s %d: ERROR cmd=%d is not supported!\n", __func__, __LINE__, _IOC_NR(code));
            return -ENOTTY;
    }

    return 0;
}

static const struct file_operations omxvdec_fops = {

	.owner             = THIS_MODULE,
	.open              = omxvdec_open,
	.unlocked_ioctl    = omxvdec_ioctl,
	.release           = omxvdec_release,
};

static HI_S32 omxvdec_probe(struct platform_device * pltdev)
{
	HI_S32         ret     = HI_FAILURE;
	OMXVDEC_ENTRY *omxvdec = HI_NULL;

	OmxPrint(OMX_TRACE, "omxvdec prepare to probe.\n");

	platform_set_drvdata(pltdev, HI_NULL);

	omxvdec = kzalloc(sizeof(OMXVDEC_ENTRY), GFP_KERNEL);
	if (HI_NULL == omxvdec)
    {
        OmxPrint(OMX_FATAL, "%s call kzalloc failed!\n", __func__);
		return -ENOMEM;
	}

	INIT_LIST_HEAD(&omxvdec->chan_list);
	spin_lock_init(&omxvdec->lock);
	spin_lock_init(&omxvdec->channel_lock);

	ret = omxvdec_setup_cdev(omxvdec, &omxvdec_fops);
	if(ret < 0)
    {
        OmxPrint(OMX_FATAL, "%s call omxvdec_setup_cdev failed!\n", __func__);
		goto cleanup;
	}

	omxvdec->device = &pltdev->dev;
	platform_set_drvdata(pltdev, omxvdec);
	g_OmxVdec = omxvdec;

#ifdef VFMW_VPSS_BYPASS_EN
    OMXVDEC_List_Init(&g_OmxVdec->stRemainFrmList);
#endif

	OmxPrint(OMX_TRACE, "omxvdec probe ok.\n");

	return 0;

cleanup:
	kfree(omxvdec);

	return ret;
}

static HI_S32 omxvdec_remove(struct platform_device *pltdev)
{
	OMXVDEC_ENTRY *omxvdec = HI_NULL;

	OmxPrint(OMX_TRACE, "omxvdec prepare to remove.\n");

#ifdef VFMW_VPSS_BYPASS_EN
    OMXVDEC_List_Deinit(&g_OmxVdec->stRemainFrmList);
#endif

	omxvdec = platform_get_drvdata(pltdev);
	if (HI_NULL == omxvdec)
	{
		OmxPrint(OMX_ERR, "call platform_get_drvdata err!\n");
	}
    else if (IS_ERR(omxvdec))
    {
		OmxPrint(OMX_ERR, "call platform_get_drvdata err, errno = %ld!\n", PTR_ERR(omxvdec));
    }
	else
	{
		omxvdec_cleanup_cdev(omxvdec);
    	kfree(omxvdec);
    	g_OmxVdec = HI_NULL;
	}

	platform_set_drvdata(pltdev, HI_NULL);

	OmxPrint(OMX_TRACE, "remove omxvdec ok.\n");

	return 0;
}

UINT32 OMX_GetTimeInMs(VOID)
{
    UINT64   SysTime;

    SysTime = sched_clock();
    do_div(SysTime, 1000000);
    return (UINT32)SysTime;
}

/* ==========================================================================
 * omxvdec proc entrance
 * =========================================================================*/
static inline HI_S32 omxvdec_string_to_value(HI_PCHAR str, HI_U32 *data)
{
    HI_U32 i, d, dat, weight;

    dat = 0;
    if(str[0] == '0' && (str[1] == 'x' || str[1] == 'X'))
    {
        i = 2;
        weight = 16;
    }
    else
    {
        i = 0;
        weight = 10;
    }

    for(; i < 10; i++)
    {
        if(str[i] < 0x20)
        {
            break;
        }
        else if (weight == 16 && str[i] >= 'a' && str[i] <= 'f')
        {
            d = str[i] - 'a' + 10;
        }
        else if (weight == 16 && str[i] >= 'A' && str[i] <= 'F')
        {
            d = str[i] - 'A' + 10;
        }
        else if (str[i] >= '0' && str[i] <= '9')
        {
            d = str[i] - '0';
        }
        else
        {
            return -1;
        }

        dat = dat * weight + d;
    }

    *data = dat;

    return HI_SUCCESS;
}

#ifndef HI_ADVCA_FUNCTION_RELEASE

HI_VOID omxvdec_help_proc(HI_VOID)
{
    HI_DRV_PROC_EchoHelper(
    "\n"
    "================== OMXVDEC HELP ===========\n"
    "USAGE:echo [cmd] [para] > /proc/msp/omxvdec\n"
    "cmd = save_raw,         para = start/stop   :start/stop to save raw data\n"
    "cmd = save_yuv,         para = start/stop   :start/stop to save yuv data\n"
    "cmd = save_path,        para = path         :config path to save data\n"
    "cmd = set_bypass,        para = on/off       :enable/disable bypass\n");
    HI_DRV_PROC_EchoHelper(
    "cmd = limit_framerate,  para = on/off       :enable/disable frame rate limit\n"
    "cmd = set_rawmove,      para = on/off       :enable/disable raw move\n"
    "cmd = set_dei,          para = on/off       :enable/disable deinterlace\n"
    "cmd = set_fastoutput,   para = on/off       :enable/disable fast output\n"
    "cmd = set_dfs,          para = on/off       :enable/disable dynamic frame store\n");
    HI_DRV_PROC_EchoHelper(
    "cmd = set_print,        para = value        :set print      = value\n"
    "cmd = set_dispnum,      para = value        :set DispNum    = value\n"
    "cmd = set_segsize,      para = value        :set SegSize    = value\n"
    "cmd = set_InBufThred,   para = value        :set InBufThred = value\n"
    "cmd = set_LDCountFrm,   para = value        :set LDCountFrm = value\n");
    HI_DRV_PROC_EchoHelper(
    "cmd = set_LD,           para = value        :set LowDelayStatistics = value\n"
    "\n");
    HI_DRV_PROC_EchoHelper(
    "TraceOption(32bits):\n"
    "0(FATAL)   1(ERR)     2(WARN)     3(INFO)\n"
    "4(TRACE)   5(INBUF)   6(OUTBUF)   7(PP)\n"
    "8(VERBOSE) 9(PTS)                        \n"
    "-------------------------------------------\n"
    "\n");
}

static HI_S32 omxvdec_read_proc(struct seq_file *p, HI_VOID *v)
{
    unsigned long flags;
    OMXVDEC_CHAN_CTX *pchan = NULL;

#ifdef VFMW_VPSS_BYPASS_EN
	HI_U32 i = 0;
	OMXVDEC_PROC_OCCOUPY_FRAME_INFO proc_occoupy_frame;
#endif

    if (HI_NULL == g_OmxVdec)
    {
        PROC_PRINT(p, "Warnning: g_OmxVdec = NULL\n");
        return 0;
    }

    PROC_PRINT(p, "\n");
    PROC_PRINT(p, "============ OMXVDEC INFO ============\n");
    PROC_PRINT(p, "%-25s :%d\n", "Version",           OMXVDEC_VERSION);
    PROC_PRINT(p, "%-25s :%d\n", "ActiveChanNum",     g_OmxVdec->total_chan_num);

    PROC_PRINT(p, "%-25s :%d\n", "Print",             g_TraceOption);
    PROC_PRINT(p, "%-25s :%d\n", "SaveRawEnable",     g_SaveRawEnable);
    PROC_PRINT(p, "%-25s :%d\n", "SaveYuvEnable",     g_SaveYuvEnable);
    PROC_PRINT(p, "%-25s :%s\n", "SaveName",          g_SaveName);
    PROC_PRINT(p, "%-25s :%s\n", "SavePath",          g_SavePath);
    PROC_PRINT(p, "%-25s :%d\n", "DispNum",           g_DispNum);
    PROC_PRINT(p, "%-25s :%d\n", "SegSize(M)",        g_SegSize);
    PROC_PRINT(p, "%-25s :%d\n", "RawMoveEnable",     g_RawMoveEnable);
    PROC_PRINT(p, "%-25s :%d\n", "DynamicFsEnable",   g_DynamicFsEnable);
    PROC_PRINT(p, "%-25s :%d\n", "FrameRateLimit",    g_FrameRateLimit);
    PROC_PRINT(p, "%-25s :%d\n", "DeInterlaceEnable", g_DeInterlaceEnable);
    PROC_PRINT(p, "%-25s :%d\n", "BypassVpss",        g_BypassVpss);
    PROC_PRINT(p, "%-25s :%d\n", "FastOutputMode",    g_FastOutputMode);
    PROC_PRINT(p, "%-25s :%d\n", "LowDelayStatistics", g_LowDelayStatistics);
    if (HI_TRUE == g_DynamicFsEnable && HI_NULL != g_OmxVdec->task.task_thread)
    {
        task_proc_entry(p, &g_OmxVdec->task);
    }

#ifdef VFMW_VPSS_BYPASS_EN
	memset(&proc_occoupy_frame, 0, sizeof(proc_occoupy_frame));

	omxvdec_get_occoupied_frame_info(&proc_occoupy_frame);

    PROC_PRINT(p, "%-25s :%d\n", "occoupy frame",  proc_occoupy_frame.occoupy_frame_num);

    if (proc_occoupy_frame.occoupy_frame_num != 0)
    {
        for (i = 0; i < proc_occoupy_frame.occoupy_frame_num; i++)
        {
        	PROC_PRINT(p, "%-25s:0x%x/%p/%d\n", "Phy/Vir/Size",  proc_occoupy_frame.frmBufRec[i].u32StartPhyAddr,\
				       proc_occoupy_frame.frmBufRec[i].pu8StartVirAddr, proc_occoupy_frame.frmBufRec[i].u32Size);
        }
    }
#endif
    PROC_PRINT(p, "\n");

    if (0 != g_OmxVdec->total_chan_num)
    {
       spin_lock_irqsave(&g_OmxVdec->channel_lock, flags);
       list_for_each_entry(pchan, &g_OmxVdec->chan_list, chan_list)
       {
           channel_proc_entry(p, pchan);
       }
       spin_unlock_irqrestore(&g_OmxVdec->channel_lock, flags);
    }

    return 0;
}

HI_S32 omxvdec_write_proc(struct file *file, const char __user *buffer, size_t count, loff_t *data)
{
    HI_S32  i,j;
    HI_U32  dat2;
    HI_CHAR buf[DBG_CMD_LEN];
    HI_CHAR str1[DBG_CMD_LEN];
    HI_CHAR str2[DBG_CMD_LEN];

    if(count >= sizeof(buf))
    {
        OmxPrint(OMX_ALWS, "parameter string is too long!\n");
        return HI_FAILURE;
    }

    memset(buf, 0, sizeof(buf));
    if (copy_from_user(buf, buffer, count))
    {
        OmxPrint(OMX_ALWS, "copy_from_user failed!\n");
        return HI_FAILURE;
    }
    buf[count] = 0;

    if (count < 1)
    {
        goto error;
    }
    else
    {
        /* dat1 */
        i = 0;
        j = 0;
        for(; i < count; i++)
        {
            if(j==0 && buf[i]==' ')
            {
                continue;
            }
            if(buf[i] > ' ')
            {
                str1[j++] = buf[i];
            }
            if(j>0 && buf[i]==' ')
            {
                break;
            }
        }
        str1[j] = 0;

        /* dat2 */
        j = 0;
        for(; i < count; i++)
        {
            if(j==0 && buf[i]==' ')
            {
                continue;
            }
            if(buf[i] > ' ')
            {
                str2[j++] = buf[i];
            }
            if(j>0 && buf[i]==' ')
            {
                break;
            }
        }
        str2[j] = 0;

        if (!strncmp(str1, DBG_CMD_TRACE, DBG_CMD_LEN))
        {
            if(omxvdec_string_to_value(str2, &dat2) != 0)
            {
                goto error;
            }

            OmxPrint(OMX_ALWS, "print: %u\n", dat2);
            g_TraceOption = dat2;
        }
        else if (!strncmp(str1, DBG_CMD_RAW, DBG_CMD_LEN))
        {
            if (!strncmp(str2, DBG_CMD_START, DBG_CMD_LEN))
            {
                OmxPrint(OMX_ALWS, "Enable raw save.\n");
                g_SaveRawEnable = HI_TRUE;
                g_SaveNum++;
            }
            else if (!strncmp(str2, DBG_CMD_STOP, DBG_CMD_LEN))
            {
                OmxPrint(OMX_ALWS, "Disable raw save.\n");
                g_SaveRawEnable = HI_FALSE;
            }
            else
            {
                goto error;
            }
        }
        else if (!strncmp(str1, DBG_CMD_YUV, DBG_CMD_LEN))
        {
            if (!strncmp(str2, DBG_CMD_START, DBG_CMD_LEN))
            {
                OmxPrint(OMX_ALWS, "Enable yuv save.\n");
                g_SaveYuvEnable = HI_TRUE;
                g_SaveNum++;
            }
            else if (!strncmp(str2, DBG_CMD_STOP, DBG_CMD_LEN))
            {
                OmxPrint(OMX_ALWS, "Disable yuv save.\n");
                g_SaveYuvEnable = HI_FALSE;
            }
            else
            {
                goto error;
            }
        }
        else if (!strncmp(str1, DBG_CMD_PATH, DBG_CMD_LEN))
        {
            if (j > 0 && j < sizeof(g_SavePath) && str2[0] == '/')
            {
                if(str2[j-1] == '/')
                {
                   str2[j-1] = 0;
                }
                strncpy(g_SavePath, str2, PATH_LEN);
                g_SavePath[PATH_LEN-1] = '\0';
                OmxPrint(OMX_ALWS, "SavePath: %s\n", g_SavePath);
            }
            else
            {
                goto error;
            }
        }
        else if (!strncmp(str1, DBG_CMD_NAME, DBG_CMD_LEN))
        {
            if (j > 0 && j < sizeof(g_SaveName))
            {
                strncpy(g_SaveName, str2, NAME_LEN);
                g_SaveName[NAME_LEN-1] = '\0';
                OmxPrint(OMX_ALWS, "SaveName: %s\n", g_SaveName);
            }
            else
            {
                goto error;
            }
        }
        else if (!strncmp(str1, DBG_CMD_FRAME_RATE, DBG_CMD_LEN))
        {
            if (!strncmp(str2, DBG_CMD_ON, DBG_CMD_LEN))
            {
                OmxPrint(OMX_ALWS, "Enable frame rate limit.\n");
                g_FrameRateLimit = HI_TRUE;
            }
            else if (!strncmp(str2, DBG_CMD_OFF, DBG_CMD_LEN))
            {
                OmxPrint(OMX_ALWS, "Disable frame rate limit.\n");
                g_FrameRateLimit = HI_FALSE;
            }
            else
            {
                goto error;
            }
        }
        else if (!strncmp(str1, DBG_CMD_RAWMOVE, DBG_CMD_LEN))
        {
            if (!strncmp(str2, DBG_CMD_ON, DBG_CMD_LEN))
            {
                OmxPrint(OMX_ALWS, "Enable Raw Move.\n");
                g_RawMoveEnable = HI_TRUE;
            }
            else if (!strncmp(str2, DBG_CMD_OFF, DBG_CMD_LEN))
            {
                OmxPrint(OMX_ALWS, "Disable Raw Move.\n");
                g_RawMoveEnable = HI_FALSE;
            }
            else
            {
                goto error;
            }
        }
        else if (!strncmp(str1, DBG_CMD_DEI, DBG_CMD_LEN))
        {
            if (!strncmp(str2, DBG_CMD_ON, DBG_CMD_LEN))
            {
                OmxPrint(OMX_ALWS, "Enable DeInterlace.\n");
                g_DeInterlaceEnable = HI_TRUE;
            }
            else if (!strncmp(str2, DBG_CMD_OFF, DBG_CMD_LEN))
            {
                OmxPrint(OMX_ALWS, "Disable DeInterlace.\n");
                g_DeInterlaceEnable = HI_FALSE;
            }
            else
            {
                goto error;
            }
        }
        else if (!strncmp(str1, DBG_CMD_BYPASS, DBG_CMD_LEN))
        {
            if (!strncmp(str2, DBG_CMD_ON, DBG_CMD_LEN))
            {
                OmxPrint(OMX_ALWS, "Without vpss.\n");
                g_BypassVpss = HI_TRUE;
            }
            else if (!strncmp(str2, DBG_CMD_OFF, DBG_CMD_LEN))
            {
                OmxPrint(OMX_ALWS, "With vpss.\n");
                g_BypassVpss = HI_FALSE;
            }
            else
            {
                goto error;
            }
        }
        else if (!strncmp(str1, DBG_CMD_FAST_OUTPUT, DBG_CMD_LEN))
        {
            if (!strncmp(str2, DBG_CMD_ON, DBG_CMD_LEN))
            {
                OmxPrint(OMX_ALWS, "Enable FastOutputMode.\n");
                g_FastOutputMode = HI_TRUE;
            }
            else if (!strncmp(str2, DBG_CMD_OFF, DBG_CMD_LEN))
            {
                OmxPrint(OMX_ALWS, "Disable FastOutputMode.\n");
                g_FastOutputMode = HI_FALSE;
            }
            else
            {
                goto error;
            }
        }
        else if (!strncmp(str1, DBG_CMD_DISPNUM, DBG_CMD_LEN))
        {
            if(omxvdec_string_to_value(str2, &dat2) != 0)
            {
                goto error;
            }

            OmxPrint(OMX_ALWS, "DispNum: %u\n", dat2);
            g_DispNum = dat2;
        }
        else if (!strncmp(str1, DBG_CMD_SEGSIZE, DBG_CMD_LEN))
        {
            if(omxvdec_string_to_value(str2, &dat2) != 0)
            {
                goto error;
            }

            OmxPrint(OMX_ALWS, "SegSize: %u\n", dat2);
            g_SegSize = dat2;
        }
        else if (!strncmp(str1, DBG_CMD_DFS, DBG_CMD_LEN))
        {
            if (!strncmp(str2, DBG_CMD_ON, DBG_CMD_LEN))
            {
                OmxPrint(OMX_ALWS, "Enable DynamicFs.\n");
                g_DynamicFsEnable = HI_TRUE;
            }
            else if (!strncmp(str2, DBG_CMD_OFF, DBG_CMD_LEN))
            {
                OmxPrint(OMX_ALWS, "Disable DynamicFs.\n");
                g_DynamicFsEnable = HI_FALSE;
            }
            else
            {
                goto error;
            }
        }
        else if (!strncmp(str1, DBG_CMD_LD_CNT_FRM, DBG_CMD_LEN))
        {
            if(omxvdec_string_to_value(str2, &dat2) != 0)
            {
                goto error;
            }

            OmxPrint(OMX_ALWS, "LowDelay Count Frame Number: %u\n", dat2);
            g_lowdelay_count_frame= dat2;
        }
        else if (!strncmp(str1, DBG_CMD_LOWDELAY_TIME, DBG_CMD_LEN))
        {
            if (!strncmp(str2, DBG_CMD_ON, DBG_CMD_LEN))
            {
                OmxPrint(OMX_ALWS, "Enable low_delay_statistics.\n");
                g_LowDelayStatistics = HI_TRUE;
            }
            else if (!strncmp(str2, DBG_CMD_OFF, DBG_CMD_LEN))
            {
                OmxPrint(OMX_ALWS, "Disable low_delay_statistics.\n");
                g_LowDelayStatistics = HI_FALSE;
            }
            else
            {
                goto error;
            }
        }
        else if (!strncmp(str1, DBG_CMD_HELP, DBG_CMD_LEN))
        {
            omxvdec_help_proc();
        }
        else
        {
            goto error;
        }
    }

    return count;

error:
    OmxPrint(OMX_ALWS, "Invalid echo command!\n");
    omxvdec_help_proc();

    return count;
}

HI_S32 omxvdec_init_proc (HI_VOID)
{
    HI_CHAR aszBuf[16];
    DRV_PROC_ITEM_S *pstItem;

    /* Create proc */
    snprintf(aszBuf, sizeof(aszBuf), "omxvdec");
    pstItem = HI_DRV_PROC_AddModule(aszBuf, HI_NULL, HI_NULL);
    if (!pstItem)
    {
        OmxPrint(OMX_FATAL, "Create omxvdec proc entry fail!\n");
        return HI_FAILURE;
    }

    /* Set functions */
    pstItem->read  = omxvdec_read_proc;
    pstItem->write = omxvdec_write_proc;

	return HI_SUCCESS;
}

HI_VOID omxvdec_exit_proc(HI_VOID)
{
    HI_CHAR aszBuf[16];

    snprintf(aszBuf, sizeof(aszBuf), "omxvdec");
    HI_DRV_PROC_RemoveModule(aszBuf);

    return;
}
#endif


static HI_S32 omxvdec_suspend(struct platform_device *pltdev, pm_message_t state)
{
	return HI_SUCCESS;
}

static HI_S32 omxvdec_resume(struct platform_device *pltdev)
{
	return HI_SUCCESS;
}

static HI_VOID omxvdec_device_release(struct device* dev)
{
	return;
}

static struct platform_driver omxvdec_driver = {

	.probe             = omxvdec_probe,
	.remove            = omxvdec_remove,
	.suspend           = omxvdec_suspend,
	.resume            = omxvdec_resume,
	.driver = {
	    .name          = (HI_PCHAR)g_OmxVdecDrvName,
	    .owner         = THIS_MODULE,
	},
};

static struct platform_device omxvdec_device = {

	.name              = g_OmxVdecDrvName,
	.id                = -1,
    .dev = {
        .platform_data = NULL,
        .release       = omxvdec_device_release,
    },
};

HI_S32 OMXVDEC_DRV_ModInit(HI_VOID)
{
    HI_S32 ret;

    ret = platform_device_register(&omxvdec_device);
    if(ret < 0)
    {
        OmxPrint(OMX_FATAL, "%s call platform_device_register failed!\n", __func__);
        return ret;
    }

    ret = platform_driver_register(&omxvdec_driver);
    if(ret < 0)
    {
        OmxPrint(OMX_FATAL, "%s call platform_driver_register failed!\n", __func__);
        goto exit;
    }

#ifndef HI_ADVCA_FUNCTION_RELEASE
    ret = omxvdec_init_proc();
    if (ret != HI_SUCCESS)
    {
        OmxPrint(OMX_FATAL, "omxvdec_init_proc failed!\n");
        goto exit1;
    }

#ifdef MODULE
	HI_PRINT("Load hi_omxvdec.ko success.\t(%s)\n", VERSION_STRING);
#endif
#endif

	return HI_SUCCESS;

exit1:
	platform_driver_unregister(&omxvdec_driver);
exit:
	platform_device_unregister(&omxvdec_device);

	return ret;
}

HI_VOID OMXVDEC_DRV_ModExit(HI_VOID)
{
	platform_driver_unregister(&omxvdec_driver);
	platform_device_unregister(&omxvdec_device);

#ifndef HI_ADVCA_FUNCTION_RELEASE
    omxvdec_exit_proc();

#ifdef MODULE
    HI_PRINT("Unload hi_omxvdec.ko success.\t(%s)\n", VERSION_STRING);
#endif
#endif

}

#ifdef VFMW_VPSS_BYPASS_EN

static HI_VOID OMXVDEC_List_Init(OMXVDEC_List_S *pList)
{
   D_OMXVDEC_CHECK_PTR(pList);

   if (HI_FALSE == pList->bInit)
   {
      memset(&pList->stSpecialFrmRec[0],0, sizeof(OMXVDEC_FRM_INFO_S)*OMXVDEC_MAX_REMAIN_FRM_NUM);

      VDEC_INIT_MUTEX(&pList->bypass_mutex);

	  pList->bInit = HI_TRUE;
	  pList->s32Num = 0;
   }
   return;
}

static HI_VOID OMXVDEC_List_Deinit(OMXVDEC_List_S *pList)
{
    HI_U32 i = 0;
    OMXVDEC_FRM_INFO_S *pSpecialFrmRec;

	D_OMXVDEC_CHECK_PTR(pList);

    for (i = 0; i < OMXVDEC_MAX_REMAIN_FRM_NUM; i++)
    {
        pSpecialFrmRec = &pList->stSpecialFrmRec[i];
        if ((ALLOC_BY_MMZ == pSpecialFrmRec->enbufferNodeStatus || ALLOC_BY_MMZ_UNMAP== pSpecialFrmRec->enbufferNodeStatus)
			&&(pSpecialFrmRec->frmBufRec.u32StartPhyAddr != 0)
			&& (pSpecialFrmRec->frmBufRec.u32StartPhyAddr != 0xffffffff))
        {
            omxvdec_release_mem(&pSpecialFrmRec->frmBufRec, pSpecialFrmRec->enbufferNodeStatus);
        }
		else if (ALLOC_BY_SEC == pSpecialFrmRec->enbufferNodeStatus)
		{
		    OmxPrint(OMX_FATAL,"%s,bypass not support tvp yet!\n",__func__);
		}
	   //清空该节点内容，视为空闲节点
	   memset(pSpecialFrmRec, 0, sizeof(OMXVDEC_FRM_INFO_S));
    }
	pList->s32Num = 0;
    pList->bInit = HI_FALSE;
    return ;
}

HI_S32 OMXVDEC_List_FindNode(OMXVDEC_List_S *pList,HI_U32 u32TargetPhyAddr,HI_U32 *pIndex)
{
   HI_U32 index = 0;
   OMXVDEC_FRM_INFO_S *pSpecialFrmRec;

   D_OMXVDEC_CHECK_PTR_RET(pList);
   D_OMXVDEC_CHECK_PTR_RET(pIndex);

   VDEC_DOWN_INTERRUPTIBLE(&pList->bypass_mutex);

   for (index = 0; index < OMXVDEC_MAX_REMAIN_FRM_NUM; index++)
   {
       pSpecialFrmRec = &pList->stSpecialFrmRec[index];
       if ( pSpecialFrmRec->frmBufRec.u32StartPhyAddr == u32TargetPhyAddr )
       {
           *pIndex = index;
		   break;
	   }
   }

   VDEC_UP_INTERRUPTIBLE(&pList->bypass_mutex);

   if (index >= OMXVDEC_MAX_REMAIN_FRM_NUM)
   {
       return HI_FAILURE;
   }
   else
   {
       return HI_SUCCESS;
   }
}

#if 0
HI_S32 OMXVDEC_List_FindNodeCanRls(OMXVDEC_List_S *pList, HI_U32 *pIndex)
{
   HI_U32 index = 0;
   OMXVDEC_FRM_INFO_S *pSpecialFrmRec;

   D_OMXVDEC_CHECK_PTR_RET(pList);

   for (index = 0; index < OMXVDEC_MAX_REMAIN_FRM_NUM; index++)
   {
       pSpecialFrmRec = &pList->stSpecialFrmRec[index];
       if ( pSpecialFrmRec->bCanRls == HI_TRUE )
       {
           *pIndex = index;
		   break;
	   }
   }
   if (index >= OMXVDEC_MAX_REMAIN_FRM_NUM)
   {
       return HI_FAILURE;
   }
   else
   {
       return HI_SUCCESS;
   }
}
#endif

HI_S32 OMXVDEC_List_Add(OMXVDEC_List_S *pList,OMXVDEC_FRM_INFO_S *pSpecialFrmRec)
{

   HI_U32 index;
   OMXVDEC_FRM_INFO_S *pListRec;

   D_OMXVDEC_CHECK_PTR_RET(pList);
   D_OMXVDEC_CHECK_PTR_RET(pSpecialFrmRec);

   for (index = 0; index < OMXVDEC_MAX_REMAIN_FRM_NUM; index++)
   {
       pListRec = &pList->stSpecialFrmRec[index];
       if (pListRec->frmBufRec.u32StartPhyAddr == 0)
       {
           memcpy(pListRec, pSpecialFrmRec, sizeof(OMXVDEC_FRM_INFO_S));
		   pList->s32Num++;
		   if (pList->s32Num > OMXVDEC_MAX_REMAIN_FRM_NUM)
		   {
		       OmxPrint(OMX_FATAL,"Remain Frame num = %d larger than Max(%d),force to be %d\n",pList->s32Num,OMXVDEC_MAX_REMAIN_FRM_NUM,OMXVDEC_MAX_REMAIN_FRM_NUM);
			   pList->s32Num = OMXVDEC_MAX_REMAIN_FRM_NUM;
		   }
		   break;
       }
   }
   if (index >= OMXVDEC_MAX_REMAIN_FRM_NUM)
   {
       OmxPrint(OMX_FATAL,"can't find the idle node of the global frame list! Remain Frame num = %d\n",pList->s32Num);
   }
   return HI_SUCCESS;
}

HI_S32 OMXVDEC_List_Del(OMXVDEC_List_S *pList,HI_U32 u32Index)
{
   OMXVDEC_FRM_INFO_S *pSpecialFrmRec;

   D_OMXVDEC_CHECK_PTR_RET(pList);

   if (u32Index >= OMXVDEC_MAX_REMAIN_FRM_NUM)
   {
      OmxPrint(OMX_FATAL,"want to delete index(%d) >= %d(max), error!!!\n",u32Index,OMXVDEC_MAX_REMAIN_FRM_NUM);
	  return HI_FAILURE;
   }

   VDEC_DOWN_INTERRUPTIBLE(&pList->bypass_mutex);

   pSpecialFrmRec = &pList->stSpecialFrmRec[u32Index];

   //清空该节点内容，视为空闲节点
   memset(pSpecialFrmRec, 0, sizeof(OMXVDEC_FRM_INFO_S));
   pList->s32Num--;
   if (pList->s32Num < 0)
   {
      OmxPrint(OMX_FATAL,"the vdec global remain frame < 0 ??!  force to be 0!\n");
	  pList->s32Num = 0;
   }

   VDEC_UP_INTERRUPTIBLE(&pList->bypass_mutex);

   return HI_SUCCESS;
}

/******************************************************/
/***            获取special帧信息                   ***/
/** 提供给 vdec_ctrl 查看proc信息的函数             ***/
/******************************************************/
HI_S32 omxvdec_get_occoupied_frame_info(OMXVDEC_PROC_OCCOUPY_FRAME_INFO *p_proc_occoupy_frame)
{
    HI_U32 u32Index = 0;
    HI_U32 SpecialFrmCnt = 0;

	OMXVDEC_FRM_INFO_S *p_occoupy_frame;

    p_proc_occoupy_frame->occoupy_frame_num = g_OmxVdec->stRemainFrmList.s32Num;

    if (p_proc_occoupy_frame->occoupy_frame_num != 0)
    {
        for (u32Index = 0; u32Index < OMXVDEC_MAX_REMAIN_FRM_NUM; u32Index++)
        {
            p_occoupy_frame = &g_OmxVdec->stRemainFrmList.stSpecialFrmRec[u32Index];
            if (p_occoupy_frame->frmBufRec.u32StartPhyAddr != 0)
            {
                memcpy(&p_proc_occoupy_frame->frmBufRec[SpecialFrmCnt], &p_occoupy_frame->frmBufRec, sizeof(MMZ_BUFFER_S));
                SpecialFrmCnt++;
            }
        }
    }

    return HI_SUCCESS;
}

#endif

#ifdef MODULE
module_init(OMXVDEC_DRV_ModInit);
module_exit(OMXVDEC_DRV_ModExit);
#endif



