/******************************************************************************
*
* Copyright (C) 2015 Hisilicon Technologies Co., Ltd.  All rights reserved. 
*
* This program is confidential and proprietary to Hisilicon  Technologies Co., Ltd. (Hisilicon), 
* and may not be copied, reproduced, modified, disclosed to others, published or used, in
* whole or in part, without the express prior written permission of Hisilicon.
*
******************************************************************************
File Name	    : jpeg_drv_osr.c
Version		    : Initial Draft
Author		    : 
Created		    : 2015/03/01
Description	    : 
Function List 	: 

			  		  
History       	:
Date				Author        		Modification
2015/03/01		    y00181162  		    Created file      	
******************************************************************************/



/*********************************add include here******************************/
#ifndef HI_BUILD_IN_BOOT
	#include <linux/module.h>
	#include <linux/init.h>
	#include <linux/moduleparam.h>
	#include <linux/sched.h>
	#include <linux/kernel.h>
	#include <linux/types.h>
	#include <linux/fs.h>
	#include <linux/miscdevice.h>
	#include <linux/interrupt.h>
	#include <linux/ioport.h>
	#include <linux/ioctl.h>
	#include <linux/delay.h>
	#include <linux/device.h>
	#include <linux/errno.h>
	#include <linux/spinlock.h>
	#include <linux/mm.h>
	#include <linux/stddef.h>
	#include <linux/fcntl.h>
	#include <linux/slab.h>
	#include <asm/atomic.h>
	#include <asm/bitops.h>
	#include <asm/io.h>
	#include <asm/uaccess.h>
	#include <asm/pgtable.h>
	#include <asm/barrier.h>
    
	#include "hi_jpeg_config.h"
	
	#ifdef CONFIG_JPEG_USE_KERNEL_SIGNAL
	#include "jpeg_drv_signal.h"
	#endif

	#ifdef CONFIG_JPEG_PROC_ENABLE
		#include "jpeg_drv_proc.h"
	#endif

	#ifdef CONFIG_JPEG_USE_SDK_CRG_ENABLE
		#include "hi_reg_common.h"
		#if   defined(CHIP_TYPE_hi3712)      \
		   || defined(CHIP_TYPE_hi3716m)     \
		   || defined(CHIP_TYPE_hi3716mv310) \
		   || defined(CHIP_TYPE_hi3110ev500) \
	       || defined(CHIP_TYPE_hi3716mv320) \
	       || defined(CHIP_TYPE_hi3716mv330) \
		   || defined(CONFIG_GFX_BVT_SDK)
			#include "hi_reg_sys.h"
			#include "hi_reg_peri.h"
			#include "hi_reg_crg.h"
		#else
			#include "hi_drv_reg.h"
		#endif
	#endif

	#ifndef CONFIG_GFX_BVT_SDK
	#include "drv_jpeg_ext.h"
	#endif

#endif

#include "hi_jpeg_drv_api.h"
#include "hi_jpeg_reg.h"
#include "jpeg_drv_hal.h"
#include "jpeg_drv_suspend.h"
#include "jpeg_drv_error.h"
#include "jpeg_drv_parse.h"
#include "jpeg_drv_setpara.h"
#include "jpeg_drv_osr.h"
#include "jpeg_drv_mem.h"
#include "hi_type.h"

/***************************** Macro Definition ******************************/


/** module register name */
/** CNcomment:向SDK注册模块名 */
#define JPEGNAME                  "hi_jpeg_irq"
#define JPEGDEVNAME               "jpeg"

#ifndef HI_BUILD_IN_BOOT

/*************************** Structure Definition ****************************/

/********************** Global Variable declaration **************************/

extern HI_JPEG_PROC_INFO_S s_stJpeg6bProcInfo;

/** read or write register value */
/** CNcomment: 读或写寄存器的值  */
#ifndef CONFIG_JPEG_USE_SDK_CRG_ENABLE
static volatile HI_U32  *s_pJpegCRG     = HI_NULL;
#endif
static volatile HI_U32  *s_pJpegRegBase = HI_NULL;
static JPG_OSRDEV_S *s_pstruJpgOsrDev   = HI_NULL;

HI_GFX_DECLARE_MUTEX(s_JpegMutex);      /**< dec muxtex     *//**<CNcomment:解码多线程保护 */
HI_GFX_DECLARE_MUTEX(s_SuspendMutex);   /**< suspend muxtex *//**<CNcomment:待机多线程保护 */

/******************************* API forward declarations *******************/
static long jpg_osr_ioctl(struct file *file, HI_U32 Cmd, unsigned long Arg);

/******************************* API realization *****************************/

#ifndef CONFIG_GFX_BVT_SDK
DECLARE_GFX_NODE(JPEGDEVNAME,jpg_osr_open, jpg_osr_close,jpg_osr_mmap,jpg_osr_ioctl,jpg_osr_suspend, jpg_osr_resume);
#else
DECLARE_GFX_NODE(JPEGDEVNAME,jpg_osr_open, jpg_osr_close,jpg_osr_mmap,jpg_osr_ioctl,NULL, NULL);
#endif

/***************************************************************************************
* func			: jpg_do_cancel_reset
* description	: cancel reset jpeg register
				  CNcomment: 测消复位 CNend\n
* param[in] 	: HI_VOID
* retval		: NA
* others:		: NA
***************************************************************************************/
HI_VOID jpg_do_cancel_reset(HI_VOID)
{
#ifdef CONFIG_JPEG_USE_SDK_CRG_ENABLE
		volatile U_PERI_CRG31 unTempValue;

		unTempValue.u32 = g_pstRegCrg->PERI_CRG31.u32;
		unTempValue.bits.jpgd_srst_req  = 0x0;
		g_pstRegCrg->PERI_CRG31.u32 = unTempValue.u32;
        mb();/**保证寄存器已经写完**/
#else
		volatile HI_U32* pResetAddr = s_pJpegCRG;
		volatile HI_U32* pBusyAddr  = s_pJpegRegBase;

		*pResetAddr |= JPGD_RESET_REG_VALUE;
        /** waite 20ms, release cpu **/
		schedule_timeout(HZ / 50);
		*pResetAddr &= JPGD_UNRESET_REG_VALUE;
#endif
}

/***************************************************************************************
* func			: jpg_do_reset
* description	: reset jpeg register
				  CNcomment: 复位 CNend\n
* param[in] 	: HI_VOID
* retval		: NA
* others:		: NA
***************************************************************************************/
HI_VOID jpg_do_reset(HI_VOID)
{
#ifdef CONFIG_JPEG_USE_SDK_CRG_ENABLE
        HI_U32 u32StartTimeMs = 0;
        HI_U32 u32EndTimeMs   = 0;
        HI_U32 u32TotalTime   = 0;
		volatile U_PERI_CRG31 unTempValue;
        volatile HI_U32* pBusyAddr = s_pJpegRegBase;
        
		unTempValue.u32 = g_pstRegCrg->PERI_CRG31.u32;
		unTempValue.bits.jpgd_srst_req  = 0x1;
		g_pstRegCrg->PERI_CRG31.u32 = unTempValue.u32;
        mb();

		if(0 == unTempValue.bits.jpgd_cken){
            /** the clock is off, should not read and write register **/
            return;
        }
        HI_GFX_GetTimeStamp(&u32StartTimeMs,NULL);
		while (*pBusyAddr & 0x2){
			/*nothing to do!*/
            HI_GFX_GetTimeStamp(&u32EndTimeMs,NULL);
			/** avoid dead lock **/
			u32TotalTime = u32EndTimeMs - u32StartTimeMs;
			if(u32TotalTime >= 20){
                 break;
			}
        }
#else
		volatile HI_U32* pResetAddr = s_pJpegCRG;
		*pResetAddr |= JPGD_RESET_REG_VALUE;
#endif
}

/***************************************************************************************
* func			: jpg_do_clock_off
* description	: close the jpeg clock
				  CNcomment: 关闭jpeg时钟 CNend\n
* param[in] 	: HI_VOID
* retval		: NA
* others:		: NA
***************************************************************************************/
HI_VOID jpg_do_clock_off(HI_VOID)
{
#ifdef CONFIG_JPEG_USE_SDK_CRG_ENABLE
		volatile U_PERI_CRG31 unTempValue;
		unTempValue.u32 = g_pstRegCrg->PERI_CRG31.u32;
		unTempValue.bits.jpgd_cken = 0x0;
		//g_pstRegCrg->PERI_CRG31.u32 = unTempValue.u32;
        mb();
#else
		volatile HI_U32* pResetAddr = s_pJpegCRG;
		*pResetAddr &= JPGD_CLOCK_OFF;
#endif
}

/***************************************************************************************
* func			: jpg_do_clock_on
* description	: open the jpeg clock
				  CNcomment: 打开jpeg时钟 CNend\n
* param[in] 	: HI_VOID
* retval		: NA
* others:		: NA
***************************************************************************************/
HI_VOID jpg_do_clock_on(HI_VOID)
{
#ifdef CONFIG_JPEG_USE_SDK_CRG_ENABLE
        HI_S32 s32Cnt = 0;
		volatile U_PERI_CRG31 unTempValue;
        
		unTempValue.u32 = g_pstRegCrg->PERI_CRG31.u32;
		unTempValue.bits.jpgd_cken  = 0x1;
		g_pstRegCrg->PERI_CRG31.u32 = unTempValue.u32;
        mb();
        do{/** ensure the clock is on **/
            s32Cnt++;
            unTempValue.u32 = g_pstRegCrg->PERI_CRG31.u32;
            if(0x1 == unTempValue.bits.jpgd_cken){
                break;
            }
        }while(s32Cnt < 10);
#else
		volatile HI_U32* pResetAddr = s_pJpegCRG;
		*pResetAddr |= JPGD_CLOCK_ON;
#endif
}

 /***************************************************************************************
 * func 		 : jpg_select_clock_frep
 * description	 : select the clock frequence
				   CNcomment: jpeg时钟频率选择 CNend\n
 * param[in]	 : HI_VOID
 * retval		 : NA
 * others:		 : NA
 ***************************************************************************************/
HI_VOID jpg_select_clock_frep(HI_VOID)
 {
#ifdef CONFIG_JPEG_USE_SDK_CRG_ENABLE

		volatile U_PERI_CRG31 unTempValue;
		unTempValue.u32 = g_pstRegCrg->PERI_CRG31.u32;
		/** the 8 bit write 0(200M) or 1(150M) **/
		/** CNcomment:第8bit写0，或 1,这里寄存器可以通过himd.l JPGD_CRG_REG_PHYADDR来查看 **/
		unTempValue.bits.jpgd_clk_sel  = 0x0;
		g_pstRegCrg->PERI_CRG31.u32 = unTempValue.u32;
        mb();
#else
		volatile HI_U32* pResetAddr = s_pJpegCRG;
		*pResetAddr = 0x000;
#endif
 }

 /***************************************************************************************
 * func 		 : jpg_osr_mmap
 * description	 : mmap jpeg device
				   CNcomment: 映射jpeg设备 CNend\n
 * param[in]	 : *filp
 * param[in]	 : *vma
 * retval		 : HI_SUCCESS
 * retval		 : HI_FAILURE
 * others:		 : NA
 ***************************************************************************************/
HI_S32 jpg_osr_mmap(struct file * filp, struct vm_area_struct *vma)
{
      
		/** if api call mmap,will call this function */
		/** CNcomment: 上层map jpeg设备的时候调用 */
        HI_U32 Phys;
        HI_U64 u64BaseAddr = JPGD_REG_BASEADDR;
		HI_U32 u32Length   = 0;
		
        /**
         ** set map parameter 
         **/
        /**
         **页按照4096对齐
         **/
        u32Length = (JPGD_REG_LENGTH + 4096 - 1) & (~(4096 - 1));
        if((vma->vm_end - vma->vm_start) > u32Length)
        {/**
          **安全问题：【新增】长整型溢出导致本地提权拿ROOT
          **这里保证超过寄存器长度
          **/
			return -EINVAL;
 		}
		
		Phys = (u64BaseAddr >> PAGE_SHIFT);
#if (LINUX_VERSION_CODE < KERNEL_VERSION(3, 10, 0))
        vma->vm_flags |= VM_RESERVED | VM_LOCKED | VM_IO;
#else
		vma->vm_flags |= VM_LOCKED | VM_IO;
#endif

        /** cancel map **/
        vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);

        if (remap_pfn_range(vma, vma->vm_start, Phys, vma->vm_end - vma->vm_start, 
                            vma->vm_page_prot))
        {
            return -EAGAIN;
        }

        return HI_SUCCESS;

    
}
/***************************************************************************************
* func 		 : jpg_osr_getintstatus
* description: 
			   CNcomment: 获取中断状态 CNend\n
* param[in]	 : *pdev
* retval	 : HI_SUCCESS 成功
* retval	 : HI_FAILURE 失败
* others:	 : NA
***************************************************************************************/
static HI_S32 jpg_osr_getintstatus(DRV_JPEG_EXT_GETINTTYPE_S *pstIntType)
{
	JPG_GETINTTYPE_S IntInfo;
	HI_S32 Ret = 0;
	HI_S32 loop = 0;
	HI_U32 FirstCount = 1;
	HI_S32 IRQ_NUM    = JPGD_IRQ_NUM;
	HI_U32 u32StartTimeMs = 0; /** ms **/
	HI_U32 u32EndTimeMs   = 0; /** ms **/
	/**
	 ** checkt parameter
	 **/
	if(NULL == pstIntType)
	{
		return HI_FAILURE;
	}

	IntInfo.IntType = pstIntType->IntType;
	IntInfo.TimeOut = pstIntType->TimeOut;

	
	disable_irq(IRQ_NUM);

   /**
	** get the halt type 
	**/
	if((JPG_INTTYPE_NONE != s_pstruJpgOsrDev->IntType) || (0 == IntInfo.TimeOut))
	{

		
		IntInfo.IntType = s_pstruJpgOsrDev->IntType;
		s_pstruJpgOsrDev->IntType = JPG_INTTYPE_NONE;
		enable_irq(IRQ_NUM);

		pstIntType->IntType = IntInfo.IntType;

		return HI_SUCCESS;
	}
	enable_irq(IRQ_NUM);

	do
	{			
		Ret = wait_event_interruptible_timeout(s_pstruJpgOsrDev->QWaitInt, 
					  JPG_INTTYPE_NONE != s_pstruJpgOsrDev->IntType, 
					  IntInfo.TimeOut * HZ/1000);
		 
		loop = 0;

		if(Ret > 0 || (JPG_INTTYPE_NONE != s_pstruJpgOsrDev->IntType))
		{

			disable_irq(IRQ_NUM);
			IntInfo.IntType = s_pstruJpgOsrDev->IntType;
			s_pstruJpgOsrDev->IntType = JPG_INTTYPE_NONE;
			enable_irq(IRQ_NUM);
			break;
		} 
		else if( -ERESTARTSYS == Ret)
		{

			if(FirstCount)
			{
				HI_GFX_GetTimeStamp(&u32StartTimeMs,NULL);
				FirstCount = 0;
				loop = 1;
			} 
			else
			{
				HI_GFX_GetTimeStamp(&u32EndTimeMs,NULL);
				/** avoid dead lock **/
				loop = ((u32EndTimeMs - u32StartTimeMs) <  IntInfo.TimeOut)?1:0; 
				/** check timeout **/
				if(!loop)
				{
					 return HI_FAILURE;
				}
			}
			
		} 
		else /** == 0(wait timeout) and others **/ 
		{
			return HI_FAILURE;
		}
		
	}while(loop);

	pstIntType->IntType = IntInfo.IntType;

	return HI_SUCCESS;

}


#ifndef CONFIG_GFX_BVT_SDK

/***************************************************************************************
* func 		 : jpg_osr_suspend
* description: get the suspend signale.
			   CNcomment: 收到待机信号 CNend\n
* param[in]	 : *pdev
* param[in]	 : state
* retval	 : HI_SUCCESS 成功
* retval	 : HI_FAILURE 失败
* others:	 : NA
***************************************************************************************/
HI_S32 jpg_osr_suspend(PM_BASEDEV_S *pdev, pm_message_t state)
{

#ifdef CONFIG_JPEG_USE_SDK_CRG_ENABLE
	 volatile U_PERI_CRG31 unTempValue;
#endif

#ifdef CONFIG_JPEG_SUSPEND
 
	 HI_S32 Ret  = 0;
 
	 /** if you continue suspend and resume,this can be protected */
	 /** CNcomment:如果不停的待机唤醒，这里会起保护作用，始终使待机与唤醒配对操作 */
	 Ret  = down_interruptible(&s_SuspendMutex);
	 if(HI_TRUE == s_pstruJpgOsrDev->bDecTask)
	 {
		 JPG_WaitDecTaskDone();
		 /** tell the api received suspend signal */
		 /** CNcomment:通知应用层有待机信号了 */
		 s_pstruJpgOsrDev->bSuspendSignal = HI_TRUE;
		 #if defined(CONFIG_JPEG_FPGA_TEST_ENABLE) && defined(CONFIG_JPEG_FPGA_TEST_SUSPEND_ENABLE)
		 JPEG_TRACE("\n======================================\n");
		 JPEG_TRACE("=== %s 设置待机信号成功!\n",__FUNCTION__);
		 JPEG_TRACE("======================================\n");
		 #endif
	 }
#endif

#ifdef CONFIG_JPEG_USE_SDK_CRG_ENABLE
	 unTempValue.u32 = g_pstRegCrg->PERI_CRG31.u32;
	 if(0x1 == unTempValue.bits.jpgd_cken)
	 {
		s_pstruJpgOsrDev->bClockOpen = HI_TRUE;/** 时钟打开的 **/
	 }
	 else
	 {
		s_pstruJpgOsrDev->bClockOpen = HI_FALSE;/** 时钟关闭的 **/
	 }
	 if(0x1 == unTempValue.bits.jpgd_srst_req)
	 {
		s_pstruJpgOsrDev->bResetState = HI_TRUE;/** 复位状态 **/
	 }
	 else
	 {
		s_pstruJpgOsrDev->bResetState = HI_FALSE;/** 撤消复位状态 **/
	 }
#endif
     
     jpg_do_reset();
     jpg_do_clock_off();

     JPEG_TRACE("JPEG Suspend Ok\n");
     
	 return HI_SUCCESS;
	 
	 
}
 
/***************************************************************************************
* func 		 : jpg_osr_resume
* description: get the resume signale.
			   CNcomment: 收到待机唤醒信号 CNend\n
* param[in]	 : *pdev
* retval	 : HI_SUCCESS 成功
* retval	 : HI_FAILURE 失败
* others:	 : NA
***************************************************************************************/
HI_S32 jpg_osr_resume(PM_BASEDEV_S *pdev)
{	 
 
#ifdef CONFIG_JPEG_SUSPEND
 
	 /** tell the api received resume signal */
	 /** CNcomment:通知应用层有待机唤醒信号了 */
	 if(HI_TRUE == s_pstruJpgOsrDev->bDecTask)
	 {
		 s_pstruJpgOsrDev->bResumeSignal  = HI_TRUE;
		 #if defined(CONFIG_JPEG_FPGA_TEST_ENABLE) && defined(CONFIG_JPEG_FPGA_TEST_SUSPEND_ENABLE)
		 JPEG_TRACE("\n======================================\n");
		 JPEG_TRACE("=== %s 设置待机唤醒信号成功!\n",__FUNCTION__);
		 JPEG_TRACE("======================================\n");
		 #endif
	 }
	 up(&s_SuspendMutex);
#endif

     HI_GFX_InitSmmu((HI_U32)(JPGD_MMU_REG_BASEADDR));

	 /** if suspend resume,the clock should open,if not open **/
	 /** when you read and write register,the system will no work**/
	 /** CNcomment:由于待机已经把时钟关闭了，要是唤醒的时候没有打开，则
      **           系统会挂死而无法正常工作 **/
     if(HI_TRUE == s_pstruJpgOsrDev->bClockOpen)
     {
		 jpg_do_clock_on();
		 if(HI_FALSE == s_pstruJpgOsrDev->bResetState)
		 {/**待机前属于撤消复位状态，所以这里要撤消复位 **/
		 	 jpg_do_reset();
	     	 jpg_do_cancel_reset();
		 }
     }

     JPEG_TRACE("JPEG Resume Ok\n");
     
	 return HI_SUCCESS;
	 
}

/***************************************************************************************
* func 		 : jpg_osr_getdev
* description: 
			   CNcomment: 获取设备 CNend\n
* param[in]	 : *pdev
* retval	 : HI_SUCCESS 成功
* retval	 : HI_FAILURE 失败
* others:	 : NA
***************************************************************************************/
static HI_S32 jpg_osr_getdev(HI_VOID)
{
#ifdef HI_MCE_SUPPORT
    if(down_interruptible(&s_JpegMutex))
    {
	   return HI_FAILURE;
    }
    /** open the clock          **/
	/** CNcomment: 打开工作时钟 **/
	jpg_do_clock_on();
	/** select clock frequence  **/
	/** CNcomment: 选择时钟频率 **/
	jpg_select_clock_frep();
	
	/** reset register                        **/
	/** CNcomment: 复位寄存器使之能够重新工作 **/
	jpg_do_reset();
	/** cancle the reset,now can work   **/
	/** CNcomment: 撤消复位使之能够工作 **/
	jpg_do_cancel_reset();
	
	/** trun the halt status  **/
	/** CNcomment:            **/
	JpgHalSetIntMask(0x0);
    
	s_pstruJpgOsrDev->bMceUse = HI_TRUE;
		
#endif
	
 	return HI_SUCCESS;
	
}

/***************************************************************************************
* func 		 : jpg_osr_releasedev
* description: 
			   CNcomment: 释放设备 CNend\n
* param[in]	 : *pdev
* retval	 : HI_SUCCESS 成功
* retval	 : HI_FAILURE 失败
* others:	 : NA
***************************************************************************************/
static HI_S32 jpg_osr_releasedev(HI_VOID)
{
	#ifdef HI_MCE_SUPPORT
		up(&s_JpegMutex);
        jpg_do_clock_off();
		s_pstruJpgOsrDev->bMceUse = HI_FALSE;
	#endif
 	return HI_SUCCESS;
}

/***************************************************************************************
* func 		 : jpg_osr_reset
* description: 
			   CNcomment: 复位 CNend\n
* param[in]	 : *pdev
* retval	 : HI_SUCCESS 成功
* retval	 : HI_FAILURE 失败
* others:	 : NA
***************************************************************************************/
static HI_VOID jpg_osr_reset(HI_VOID)
{
	#ifdef HI_MCE_SUPPORT
		jpg_do_reset();
		jpg_do_cancel_reset();
	#endif
}

static JPEG_EXPORT_FUNC_S s_JpegExportFuncs =
{ 
	.pfnJpegGetIntStatus = jpg_osr_getintstatus,
	.pfnJpegGetDev		 = jpg_osr_getdev,
	.pfnJpegReleaseDev	 = jpg_osr_releasedev,
	.pfnJpegReset		 = jpg_osr_reset,
	.pfnJpegSuspend 	 = jpg_osr_suspend,
	.pfnJpegResume		 = jpg_osr_resume,
};

#endif



/***************************************************************************************
* func 		 : jpg_osr_showversion
* description: 
			   CNcomment: 打印版本号 CNend\n
* param[in]	 : *pdev
* retval	 : HI_SUCCESS 成功
* retval	 : HI_FAILURE 失败
* others:	 : NA
***************************************************************************************/
static HI_VOID jpg_osr_showversion(HIGFX_MODE_ID_E ModID)
{
#if !defined(CONFIG_GFX_COMM_VERSION_DISABLE) && !defined(CONFIG_GFX_COMM_DEBUG_DISABLE) && defined(MODULE)	
 
	 HI_CHAR MouleName[7][10] = {"tde","jpegdec","jpegenc","fb","png", "higo", "gfx2d"};
	 HI_CHAR Version[160]	  = "SDK_VERSION:["MKMARCOTOSTR(SDK_VERSION)"] Build Time:["__DATE__", "__TIME__"]";
 
	 if (ModID >= HIGFX_BUTT_ID)
		 return;
	 
	 GFX_Printk("Load hi_%s.ko success.\t(%s)\n", MouleName[ModID],Version);
	
	 return;
 
#endif
}


#ifdef CONFIG_JPEG_USE_KERNEL_SIGNAL
 /***************************************************************************************
 * func 		 : jpg_osr_open
 * description	 : open jpeg device
				   CNcomment: 打开jpeg设备 CNend\n
 * param[in]	 : *inode
 * param[in]	 : *file
 * retval		 : HI_SUCCESS
 * retval		 : HI_FAILURE
 * others:		 : NA
 ***************************************************************************************/
 HI_S32 jpg_osr_open(struct inode *inode, struct file *file)
 {/**
   **这里可以分配一个结构体变量内存然后赋值给file->private_data
   **因为file->private_data这个是一直存在的，后面可以使用这个变量来操作
   **自己定义的结构体变量，相当于全局变量
   **/
#ifdef HI_MCE_SUPPORT
	 if(HI_TRUE == s_pstruJpgOsrDev->bMceUse)
	 {/**
	   ** 在有开机动画的情况下，打开失败，上层使用软解
	   ** 这样就不会对硬件进行操作了，等MCE操作完之后再使用硬件解码，这样
	   ** 避免了操作锁的复杂性，防止后续close调用失败死锁的问题发生。
	   ** 还有一种情况没法避免，就是刚好mce release设备的时候启动用户态的解码。
	   ** 这个就没有办法规避了，只能让用户等MCE完成之后启动解码了。
	   **/
		 return HI_FAILURE;
	 }
#endif
		 
	 return HI_SUCCESS;
 
 }
 
  /***************************************************************************************
  * func		  : jpg_osr_close
  * description   : close jpeg device
					CNcomment: 关闭jpeg设备 CNend\n
  * param[in]	  : *inode
  * param[in]	  : *file
  * retval		  : HI_SUCCESS
  * retval		  : HI_FAILURE
  * others: 	  : NA
  ***************************************************************************************/
 HI_S32 jpg_osr_close( struct inode *inode, struct file *file)
 {
	 /**
	  **解码任务完成
	  **/
	  s_pstruJpgOsrDev->bDecTask	   = HI_FALSE;
	  s_pstruJpgOsrDev->bSuspendSignal = HI_FALSE;
	  s_pstruJpgOsrDev->bResumeSignal  = HI_FALSE;
	  
	 /**
	  **关闭设备之后复位并关闭时钟，低带宽使用
	  **/
	  jpg_do_clock_off();
 
	  return HI_SUCCESS;
 
 }

#else

 /***************************************************************************************
 * func 		 : jpg_osr_open
 * description	 : open jpeg device
				   CNcomment: 打开jpeg设备 CNend\n
 * param[in]	 : *inode
 * param[in]	 : *file
 * retval		 : HI_SUCCESS
 * retval		 : HI_FAILURE
 * others:		 : NA
 ***************************************************************************************/
 HI_S32 jpg_osr_open(struct inode *inode, struct file *file)
 {	 
 
	 
		 JPG_DISPOSE_CLOSE_S *sDisposeClose = NULL;
		 HI_S32 s32Ret = HI_SUCCESS;
		 
		 sDisposeClose = (JPG_DISPOSE_CLOSE_S *)HI_GFX_KMALLOC(HIGFX_JPGDEC_ID, 		  \
																sizeof(JPG_DISPOSE_CLOSE_S),\
																GFP_KERNEL);
		 if ( HI_NULL == sDisposeClose )
		 {	  
			 return -ENOMEM;
		 }
		 
		 memset(sDisposeClose, 0x0, sizeof(JPG_DISPOSE_CLOSE_S));
		 file->private_data 			= sDisposeClose;
		 sDisposeClose->s32DecClose 	= HI_SUCCESS;
		 sDisposeClose->s32SuspendClose = HI_FAILURE;
		 sDisposeClose->bOpenUp 		= HI_FALSE;
		 sDisposeClose->bSuspendUp		= HI_FALSE;
		 sDisposeClose->bRealse 		= HI_FALSE;

#if 1
		 s32Ret = wait_event_interruptible_timeout(s_pstruJpgOsrDev->QWaitMutex, \
												   (HI_FALSE == s_pstruJpgOsrDev->bLock && HI_FALSE == s_pstruJpgOsrDev->bDecTask),\
												   10000 * HZ/1000);/** waite 10s **/
#else
         s32Ret = wait_event_interruptible_timeout(s_pstruJpgOsrDev->QWaitMutex,       \
												   HI_FALSE == s_pstruJpgOsrDev->bLock,\
												   5000 * HZ/1000);/** waite 5s **/
#endif
		 if(s32Ret <= 0)
		 {
			 //JPEG_TRACE("open dev failure %d\n",__LINE__);
			 up(&s_JpegMutex);
			 s_pstruJpgOsrDev->bLock = HI_FALSE;/** 锁释放了 **/
			 return HI_FAILURE;
		 }
 
		 return HI_SUCCESS;
	 
 }
 
  /***************************************************************************************
  * func		  : jpg_osr_close
  * description   : close jpeg device
					CNcomment: 关闭jpeg设备 CNend\n
  * param[in]	  : *inode
  * param[in]	  : *file
  * retval		  : HI_SUCCESS
  * retval		  : HI_FAILURE
  * others: 	  : NA
  ***************************************************************************************/
 HI_S32 jpg_osr_close( struct inode *inode, struct file *file)
 {
		  
 
		 JPG_DISPOSE_CLOSE_S *sDisposeClose = NULL;
 
		 sDisposeClose = file->private_data;
		 if(NULL == sDisposeClose)
		 {	
			return HI_FAILURE;
		 }
 
		 /**
		  **if device has not initial, return failure
		  **/
		 if (HI_NULL == s_pstruJpgOsrDev)
		 {	  
			 up(&s_JpegMutex);
			 wake_up_interruptible(&s_pstruJpgOsrDev->QWaitMutex);/** 唤醒，否则等超时 **/
			 return HI_FAILURE;
		 }
 
		 /**
		  **解码任务完成
		  **/
		  s_pstruJpgOsrDev->bSuspendSignal = HI_FALSE;
		  s_pstruJpgOsrDev->bResumeSignal  = HI_FALSE;
		 
		 /** if suspend dispose */
		 /** CNcomment: 如果是待机则将待机需要的设备关回掉即可 */
		 if(HI_SUCCESS==sDisposeClose->s32SuspendClose)
		 {
			  if(HI_TRUE == sDisposeClose->bSuspendUp)
			  {
				 up(&s_JpegMutex);
				 s_pstruJpgOsrDev->bLock = HI_FALSE;/** 锁释放了 **/
				 wake_up_interruptible(&s_pstruJpgOsrDev->QWaitMutex);/** 唤醒，否则等超时 **/
			  }
			  HI_GFX_KFREE(HIGFX_JPGDEC_ID, (HI_VOID *)sDisposeClose);
			  return HI_SUCCESS;
		 }
 
		 if(HI_SUCCESS==sDisposeClose->s32DecClose)
		 {
			  if(HI_TRUE == sDisposeClose->bOpenUp)
			  {
				 up(&s_JpegMutex);
				 s_pstruJpgOsrDev->bLock = HI_FALSE;/** 锁释放了 **/
				 wake_up_interruptible(&s_pstruJpgOsrDev->QWaitMutex);/** 唤醒，否则等超时 **/
			  }
			  HI_GFX_KFREE(HIGFX_JPGDEC_ID, (HI_VOID *)sDisposeClose);
			  return HI_SUCCESS;
		 }
 
 
		 /**
		  **  if call realse, should not call this
		  **/
		 if(HI_FALSE == sDisposeClose->bRealse)
		 {
			 /**
			  ** set file private data to HI_NULL 
			  **/
			 HI_GFX_KFREE(HIGFX_JPGDEC_ID, (HI_VOID *)sDisposeClose);
 
			 /**
			  ** if the file occupy the device, set this device to not occupied,
			  ** wake up waiting halt waiting queue
			  **/
			 if(down_interruptible(&s_pstruJpgOsrDev->SemGetDev))
			 {
			   /*nothing to do!*/
			 }
 
			 if ((HI_TRUE == s_pstruJpgOsrDev->bEngageFlag) && (file == s_pstruJpgOsrDev->pFile))
			 {
			 
				 s_pstruJpgOsrDev->bEngageFlag = HI_FALSE;
				 (HI_VOID)wake_up_interruptible(&s_pstruJpgOsrDev->QWaitInt);				 
			 }
			 /**
			  ** to JPG reset operation, open the clock
			  **/
			 if(s_pstruJpgOsrDev->bEngageFlag != HI_FALSE)
			 {
                #if 0/**在多CPU情况下，CPUa解码进程被杀死处理不能影响CPUb解码进程，否则容易挂死 **/   
				 jpg_do_reset();
				 jpg_do_clock_off();
                #endif
				 up(&s_pstruJpgOsrDev->SemGetDev);
				 up(&s_JpegMutex);
				 s_pstruJpgOsrDev->bLock = HI_FALSE;/** 锁释放了 **/
				 wake_up_interruptible(&s_pstruJpgOsrDev->QWaitMutex);/** 唤醒，否则等超时 **/
				 return HI_FAILURE;
			 }
			 if(s_pstruJpgOsrDev->IntType != JPG_INTTYPE_NONE)
			 {
				 //jpg_do_clock_off();
				 up(&s_pstruJpgOsrDev->SemGetDev);
				 up(&s_JpegMutex);
				 s_pstruJpgOsrDev->bLock = HI_FALSE;/** 锁释放了 **/
				 wake_up_interruptible(&s_pstruJpgOsrDev->QWaitMutex);/** 唤醒，否则等超时 **/
				 return HI_FAILURE;
			 }

			 //jpg_do_clock_off();
#if 0
			 /**
			  **测试没有被释放的情况
			  **/
			 static HI_S32 s32MutexCnt = 0;
			 s32MutexCnt++;
			 if(10 == s32MutexCnt)
			 {
				 JPEG_TRACE("=========s32MutexCnt = %d\n",s32MutexCnt);
				 s32MutexCnt = 0;
				 up(&s_pstruJpgOsrDev->SemGetDev);
				 return HI_FAILURE;
			 }
#endif
			 up(&s_JpegMutex);
			 s_pstruJpgOsrDev->bLock = HI_FALSE;/** 锁释放了 **/
			 wake_up_interruptible(&s_pstruJpgOsrDev->QWaitMutex);/** 唤醒，否则等超时 **/
			 
			 up(&s_pstruJpgOsrDev->SemGetDev);
			 
			 return HI_SUCCESS;
			 
			 
		 }

		 //jpg_do_clock_off();
		 /**
		  ** set file private data to HI_NULL 
		  **/
		 HI_GFX_KFREE(HIGFX_JPGDEC_ID, (HI_VOID *)sDisposeClose);
 
		 return HI_SUCCESS;
 
		 
 }
#endif


#else
/***************************************************************************************
 * func 		 : jpg_dec_getintstatus
 * description	 : 
				   CNcomment: 获取中断状态 CNend\n
 * param[in]	 : irq
 * param[in]	 : * devId
 * param[in]	 : * ptrReg
 * retval		 : HI_SUCCESS 成功
 * retval		 : HI_FAILURE 失败
 * others:		 : NA
 ***************************************************************************************/
static HI_VOID jpg_dec_getintstatus(JPG_INTTYPE_E *pIntType)
{

	HI_U32 IntType = 0;

	JpgHalGetIntStatus(&IntType);
	JpgHalSetIntStatus(IntType);
	
	if(IntType & 0x1){
	    *pIntType = JPG_INTTYPE_FINISH;	  
	}else if (IntType & 0x2){
	    *pIntType = JPG_INTTYPE_ERROR;
	}else if (IntType & 0x4){
	    *pIntType = JPG_INTTYPE_CONTINUE;
	}else{
		*pIntType = JPG_INTTYPE_NONE;
	}
	return;
}
#endif/**HI_BUILD_IN_BOOT**/


#ifdef CONFIG_JPEG_OMX_FUNCTION

 /*****************************************************************************
 * func            : jpg_dec_start
 * description     : begin to decode
 * param[in]       : offset
 * param[in]       : value
 * retval          : none
 *****************************************************************************/
 static HI_S32 jpg_dec_start(HI_VOID)
 {

	 #ifndef HI_BUILD_IN_BOOT
	     HI_S32 s32Ret = HI_SUCCESS;
	 #endif
	 JPG_GETINTTYPE_S IntInfo = {0};
	 
     jpeg_reg_write(JPGD_REG_RESUME, 0x2);
	 #ifdef CONFIG_JPEG_4KDDR_DISABLE
     	jpeg_reg_write(JPGD_REG_START, 0x5);
	 #else
     	jpeg_reg_write(JPGD_REG_START, 0x1);
	 #endif

	 #ifndef HI_BUILD_IN_BOOT
	     IntInfo.IntType = JPG_INTTYPE_NONE;
	     IntInfo.TimeOut = 10000;/** 10s **/
	     s32Ret = jpg_osr_getintstatus((DRV_JPEG_EXT_GETINTTYPE_S*)&IntInfo);
	     if(HI_FAILURE == s32Ret){
	         return HI_FAILURE;
	     }
	     if(JPG_INTTYPE_FINISH == IntInfo.IntType){
	        //JPEG_TRACE("dec success\n");
	        return HI_SUCCESS;
	     }else if(JPG_INTTYPE_CONTINUE == IntInfo.IntType){
	         JPEG_TRACE("dec continue\n");
	         return HI_FAILURE;
	     }else{
	         JPEG_TRACE("dec failure\n");
	         return HI_FAILURE;
	     }
	 #else
	 	 while(1){
	 	   /** 查询中断 **/
	 	   IntInfo.IntType = JPG_INTTYPE_NONE;
		   jpg_dec_getintstatus(&(IntInfo.IntType));
			if(JPG_INTTYPE_FINISH == IntInfo.IntType){
		        return HI_SUCCESS;
		     }else if(JPG_INTTYPE_CONTINUE == IntInfo.IntType || JPG_INTTYPE_ERROR == IntInfo.IntType){
		         return HI_FAILURE;
		     }else{
		         continue;
		     }
	 	 }
	 #endif
	 
     
     return HI_SUCCESS;
 }

	
#ifndef HI_BUILD_IN_BOOT
/*****************************************************************************
 * func            : jpg_dec_continue
 * description     : begin to decode
 * param[in]       : offset
 * param[in]       : value
 * retval          : none
 *****************************************************************************/
 static HI_S32 jpg_dec_continue(HI_U64 u64DecHandle)
 {

     HI_S32 s32Ret = HI_SUCCESS;
     HI_BOOL bStartDec = HI_FALSE;
     HI_BOOL bReachEOF = HI_FALSE;
     HI_S32  s32Offset = 0;
     JPG_GETINTTYPE_S IntInfo = {0};
     IMAG_INFO_S *pstImgInfo = (IMAG_INFO_S*)(unsigned long)u64DecHandle;

     IntInfo.TimeOut = 10000;/** 10s **/
     
     do 
     {
         s32Ret = jpeg_send_stream(u64DecHandle,&s32Offset,&bReachEOF);
         if(HI_SUCCESS != s32Ret)
         {
            return HI_FAILURE;
         }
         /** 数据buffer结束地址 **/
         jpeg_reg_write(JPGD_REG_ENDADD,(HI_U32)(pstImgInfo->u32StreamPhy + s32Offset));
         
         if(HI_FALSE == bStartDec)
	     { 
			jpeg_reg_write(JPGD_REG_RESUME,(bReachEOF ? 0x02 : 0x0));
#ifdef CONFIG_JPEG_4KDDR_DISABLE
			jpeg_reg_write(JPGD_REG_START, 0x5);
#else
			jpeg_reg_write(JPGD_REG_START, 0x1);
#endif
		    bStartDec  = HI_TRUE;
		 }
		 else
		 {
			jpeg_reg_write(JPGD_REG_RESUME,(bReachEOF ? (0x02|0x01) : 0x01));
		 }
            
         IntInfo.IntType = JPG_INTTYPE_NONE;
         s32Ret = jpg_osr_getintstatus((DRV_JPEG_EXT_GETINTTYPE_S*)&IntInfo);
         if(HI_FAILURE == s32Ret)
         {
             return HI_FAILURE;
         }
         if(JPG_INTTYPE_FINISH == IntInfo.IntType)
         {
             break;
         }
         else if(JPG_INTTYPE_CONTINUE == IntInfo.IntType)
         {
             continue;
         }
         else
         {
             JPEG_TRACE("dec failure\n");
             return HI_FAILURE;
         }

      } while(JPG_INTTYPE_FINISH != IntInfo.IntType);

      return HI_SUCCESS;
}
#endif/**HI_BUILD_IN_BOOT**/


#endif/**CONFIG_JPEG_OMX_FUNCTION**/


 /***************************************************************************************
 * func          : jpg_osr_dec
 * description   : jpeg hard decode
                   CNcomment: jpeg解码 CNend\n
 * param[in]     : *stDecInfo
 * retval        : HI_SUCCESS
 * retval        : HI_FAILURE
 * others:       : NA
 ***************************************************************************************/
 HI_S32 jpg_osr_dec(HI_JPEG_DECINFO_S *stDecInfo)
{
#ifdef CONFIG_JPEG_OMX_FUNCTION
    HI_S32 s32Ret = HI_FAILURE;
	#ifdef CONFIG_JPEG_OUTPUT_LUPIXSUM
		HI_U32 u32RegistLuaPixSum0 = 0;
		HI_U64 u64RegistLuaPixSum1 = 0;
		IMAG_INFO_S *pstImgInfo = NULL;
	#endif
	
    if(NULL == stDecInfo){
        JPEG_TRACE("the dec info is null\n");
        return HI_ERR_JPEG_PARA_NULL;
    }
        
    if(0 == stDecInfo->stInMsg.u32SavePhy){
    /** 不支持码流内存为虚拟内存 **/
        JPEG_TRACE("the input ddr is null\n");
        return HI_ERR_JPEG_PARA_NULL;
    }
    if(0 == stDecInfo->stOutMsg.u32OutPhy[0]){
    /** 不支持输出内存为虚拟内存 **/
        JPEG_TRACE("the output ddr is null\n");
        return HI_ERR_JPEG_PARA_NULL;
    }
    
    s32Ret = jpg_dec_setpara(stDecInfo);
    if(HI_SUCCESS != s32Ret){
    	JPEG_TRACE("jpg_dec_setpara failure\n");
        return s32Ret;
    }
	
    if(HI_TRUE == stDecInfo->stInMsg.bUserPhyMem){
        s32Ret = jpg_dec_start();
    }
#ifndef HI_BUILD_IN_BOOT
    else{
        s32Ret = jpg_dec_continue(stDecInfo->stInMsg.u64DecHandle);
    }
#endif
    if(HI_SUCCESS != s32Ret){
    	JPEG_TRACE("start decode failure\n");
        return s32Ret;
    }

	#ifdef CONFIG_JPEG_OUTPUT_LUPIXSUM
		/**
		 ** get the lu pixle value
		 ** CNcomment: 获取亮度值大小,这个解码之后信息值可以直接获取 CNend\n
		 **/
		pstImgInfo = (IMAG_INFO_S*)(unsigned long)(stDecInfo->stInMsg.u64DecHandle);
		if(NULL == pstImgInfo){
			return HI_FAILURE;
		}
		if(HI_TRUE == stDecInfo->stOutMsg.bLuPixSum){
		   	u32RegistLuaPixSum0  = (HI_U32)jpeg_reg_read(JPGD_REG_LPIXSUM0);
			u64RegistLuaPixSum1  = (HI_U64)(jpeg_reg_read(JPGD_REG_LPIXSUM1) & 0xf);
			pstImgInfo->u64LuPixValue = (HI_U64)((u64RegistLuaPixSum1 << 32) | u32RegistLuaPixSum0);
			stDecInfo->stOutMsg.u64LuPixValue = pstImgInfo->u64LuPixValue;
		}
	#endif
    
    return HI_SUCCESS;
#else
    return HI_FAILURE;
#endif

}


#ifndef HI_BUILD_IN_BOOT

/***************************************************************************************
* func			: jpg_osr_getlupixsum
* description	: get lu pix sum
				  CNcomment: 获取亮度值和 CNend\n
* param[in] 	: u64DecHandle
* retval		: HI_SUCCESS
* retval		: HI_FAILURE
* others:		: NA
***************************************************************************************/
HI_VOID jpg_osr_getlupixsum(HI_U64 u64DecHandle,HI_U64* pu64LuPixValue)
{
#ifdef CONFIG_JPEG_OMX_FUNCTION
	IMAG_INFO_S *pstImgInfo = (IMAG_INFO_S*)(unsigned long)(u64DecHandle);
	*pu64LuPixValue = pstImgInfo->u64LuPixValue;
#endif
	return;
}

 /***************************************************************************************
 * func 		 : JpgOsrISR
 * description	 : the halt function
				   CNcomment: 中断响应函数 CNend\n
 * param[in]	 : irq
 * param[in]	 : * devId
 * param[in]	 : * ptrReg
 * retval		 : HI_SUCCESS 成功
 * retval		 : HI_FAILURE 失败
 * others:		 : NA
 ***************************************************************************************/
static HI_S32 JpgOsrISR(HI_S32 irq, HI_VOID * devId, struct pt_regs * ptrReg)
{

	HI_U32 IntType = 0;
    HI_S32 s32Ret  = HI_SUCCESS;

	/** get and set the halt status  **/
	/** CNcomment:获取当前的中断状态 **/
	JpgHalGetIntStatus(&IntType);
	/** get and set the halt status **/
	/** CNcomment:重新设置中断状态  **/
	JpgHalSetIntStatus(IntType);

	s32Ret = HI_GFX_SmmuIsr("HI_MOD_JPEG");
    if(HI_SUCCESS != s32Ret){
		JPEG_TRACE("========SMMU Error\n");
        s_pstruJpgOsrDev->IntType = JPG_INTTYPE_ERROR;
    }
	
	if (IntType & 0x1)
	{
	    s_pstruJpgOsrDev->IntType = JPG_INTTYPE_FINISH;	  
	}
	else if (IntType & 0x2)
	{
	    s_pstruJpgOsrDev->IntType = JPG_INTTYPE_ERROR;
	}
	else if (IntType & 0x4)
	{
	    s_pstruJpgOsrDev->IntType = JPG_INTTYPE_CONTINUE;
	}
    
	/** AI7D02761 wake up the waiting halt **/
	/** CNcomment:等待中断唤醒             **/
	wake_up_interruptible(&s_pstruJpgOsrDev->QWaitInt);

	return IRQ_HANDLED;
        
    
}

/***************************************************************************************
* func			: Jpg_Request_irq
* description	: register the halt function
				  CNcomment: 根据中断号注册中断响应函数 CNend\n
* param[in] 	: HI_VOID
* retval		: NA
* others:		: NA
***************************************************************************************/
static HI_VOID Jpg_Request_irq(HI_VOID)
{

	HI_S32 s32Ret = HI_SUCCESS;
	s32Ret = request_irq(JPGD_IRQ_NUM, (irq_handler_t)JpgOsrISR, IRQF_SHARED, JPEGNAME, s_pstruJpgOsrDev);
	if(HI_SUCCESS != s32Ret){   
		HI_GFX_KFREE(HIGFX_JPGDEC_ID, (HI_VOID *)s_pstruJpgOsrDev);
	    s_pstruJpgOsrDev = HI_NULL;
	}
    
    s32Ret = HI_GFX_SetIrq(HIGFX_JPGDEC_ID,JPGD_IRQ_NUM);
    if(HI_SUCCESS != s32Ret ){
        free_irq(JPGD_IRQ_NUM, (HI_VOID *)s_pstruJpgOsrDev);
		HI_GFX_KFREE(HIGFX_JPGDEC_ID, (HI_VOID *)s_pstruJpgOsrDev);
	    s_pstruJpgOsrDev = HI_NULL;
	}
}
/***************************************************************************************
* func			: Jpg_Free_irq
* description	: free the halt
				  CNcomment: 销毁中断响应 CNend\n
* param[in] 	: HI_VOID
* retval		: NA
* others:		: NA
***************************************************************************************/
static HI_VOID Jpg_Free_irq(HI_VOID)
{
    free_irq(JPGD_IRQ_NUM, (HI_VOID *)s_pstruJpgOsrDev);
}


/***************************************************************************************
* func			: JpgOsrDeinit
* description	: when remout driver,call this deinit function
				  CNcomment: 卸载设备的时候去初始化 CNend\n
* param[in] 	: *pOsrDev
* retval		: NA
* others:		: NA
***************************************************************************************/
static HI_VOID JpgOsrDeinit(JPG_OSRDEV_S *pOsrDev)
{    


	    /** use to initial waitqueue head and mutex */
		/** CNcomment:初始参数 */
	    pOsrDev->IntType     = JPG_INTTYPE_NONE;

#ifndef CONFIG_JPEG_USE_KERNEL_SIGNAL
		pOsrDev->bEngageFlag = HI_FALSE;
	    pOsrDev->pFile       = HI_NULL;
		init_waitqueue_head(&pOsrDev->QWaitMutex);
		HI_GFX_INIT_MUTEX(&pOsrDev->SemGetDev);
#endif

	    /** initial the waiting halt waiting queue  */
		/** CNcomment: */
	    init_waitqueue_head(&pOsrDev->QWaitInt);

	    /** initial device occupy operation singnal */
		/** CNcomment: */
	    HI_GFX_INIT_MUTEX(&s_SuspendMutex);

        #ifdef CONFIG_JPEG_PROC_ENABLE
	    JPEG_Proc_Cleanup();
        #endif
		
	    /** unmap the register address and set s_u32JpgRegAddr with zero */
		/** CNcomment: */
	    JpgHalExit();
		
}


 /***************************************************************************************
 * func 		 : JPEG_DRV_ModExit
 * description	 : remount the jpeg driver
				   CNcomment: 卸载设备 CNend\n
 * param[in]	 : *pOsrDev
 * retval		 : NA
 * others:		 : NA
 ***************************************************************************************/
HI_VOID JPEG_DRV_ModExit(HI_VOID)
{


	JPG_OSRDEV_S *pDev = s_pstruJpgOsrDev;

#ifdef CONFIG_JPEG_USE_KERNEL_SIGNAL
	jpeg_destory_signal(s_pstruJpgOsrDev->s32SignalId);
#endif

	/** unregister the jpeg from sdk   **/
	/** CNcomment: 将jpeg模块从SDK去除 **/
#ifndef CONFIG_GFX_BVT_SDK
	HI_GFX_MODULE_UnRegister(HIGFX_JPGDEC_ID);
#endif
	/** uninstall the device  **/
	/** CNcomment: 卸载设备   **/
	HI_GFX_PM_UnRegister();

	/** free the halt        **/
	/** CNcomment: 释放中断  **/
	Jpg_Free_irq();

	jpg_do_clock_off();

	JpgOsrDeinit(pDev);

	HI_GFX_KFREE(HIGFX_JPGDEC_ID, (HI_VOID *)pDev);
	s_pstruJpgOsrDev = HI_NULL;

	HI_GFX_REG_UNMAP((HI_VOID*)s_pJpegRegBase);
	s_pJpegRegBase  = NULL;

#ifndef CONFIG_JPEG_USE_SDK_CRG_ENABLE
	HI_GFX_REG_UNMAP((HI_VOID*)s_pJpegCRG);
	s_pJpegCRG      = NULL;
#endif    

	return;

    
}


/***************************************************************************************
* func			: JpgOsrInit
* description	: when insmod the driver call this function
				  CNcomment: 加载设备初始化 CNend\n
* param[in] 	: *pOsrDev
* retval		: HI_SUCCESS
* retval		: HI_FAILURE
* others:		: NA
***************************************************************************************/
static HI_VOID JpgOsrInit(JPG_OSRDEV_S *pOsrDev)
{
		
        HI_GFX_INIT_MUTEX(&s_JpegMutex);

        /** request halt  */
		/** CNcomment:   */
        Jpg_Request_irq();

        /** use to initial waitqueue head and mutex */
		/** CNcomment:   */
        pOsrDev->IntType      = JPG_INTTYPE_NONE;

        /** initial the waiting halt waiting queue */
		/** CNcomment:   */
        init_waitqueue_head(&pOsrDev->QWaitInt);
		
        /** initial device occupy operation singnal  */
		/** CNcomment:   */
	    HI_GFX_INIT_MUTEX(&s_SuspendMutex);

#ifndef CONFIG_JPEG_USE_KERNEL_SIGNAL
		pOsrDev->bEngageFlag  = HI_FALSE;
        pOsrDev->pFile        = HI_NULL;
		pOsrDev->bLock        = HI_FALSE;
		init_waitqueue_head(&pOsrDev->QWaitMutex);
		HI_GFX_INIT_MUTEX(&pOsrDev->SemGetDev);
#endif
}
/***************************************************************************************
* func			: JPEG_DRV_K_ModInit
* description	: build into kernel to mce
				  CNcomment: 编译到内核中进行MCE操作 CNend\n
* param[in] 	: NA
* retval		: HI_SUCCESS
* retval		: HI_FAILURE
* others:		: NA
***************************************************************************************/
HI_S32 JPEG_DRV_K_ModInit(HI_VOID)
{

		HI_S32 Ret = HI_SUCCESS;
		HI_U64 u64BaseAddr = JPGD_REG_BASEADDR;
#ifndef CONFIG_JPEG_USE_SDK_CRG_ENABLE
		HI_U64 u64CRGAddr  = JPGD_CRG_REG_PHYADDR;
#endif
        HIGFX_CHIP_TYPE_E enChipType = HIGFX_CHIP_TYPE_BUTT;

        if (HI_NULL != s_pstruJpgOsrDev)
        {   
            return -EBUSY;
        }
		
		 HI_GFX_SYS_GetChipVersion(&enChipType);
		
		 s_pJpegRegBase = (volatile HI_U32*)HI_GFX_REG_MAP(u64BaseAddr, JPGD_REG_LENGTH);

#ifndef CONFIG_JPEG_USE_SDK_CRG_ENABLE
		 s_pJpegCRG 	= (volatile HI_U32*)HI_GFX_REG_MAP(u64CRGAddr, JPGD_CRG_REG_LENGTH);
#endif
 

#ifndef CONFIG_GFX_BVT_SDK
		Ret = HI_GFX_MODULE_Register(HIGFX_JPGDEC_ID, JPEGDEVNAME, &s_JpegExportFuncs);
#endif
		if(HI_SUCCESS != Ret)
		{
			 JPEG_DRV_ModExit();
			 return HI_FAILURE;
		 }
		 
        /** malloc and initial the struct that drive needed to s_pstruJpgOsrDev,if malloc failure, return -NOMEM  */
		/** CNcomment:  */
        s_pstruJpgOsrDev = (JPG_OSRDEV_S *)HI_GFX_KMALLOC(HIGFX_JPGDEC_ID,sizeof(JPG_OSRDEV_S),GFP_KERNEL);
        if ( HI_NULL == s_pstruJpgOsrDev )
        {   
            return -ENOMEM;
        }
        memset(s_pstruJpgOsrDev, 0x0, sizeof(JPG_OSRDEV_S));

        JpgHalInit(s_pJpegRegBase);
        
       /** call JpgOsrInit to initial OSR modual, if failure should release the
        ** resource and return failure
        **/
        JpgOsrInit(s_pstruJpgOsrDev);

#ifdef CONFIG_JPEG_USE_KERNEL_SIGNAL
		 Ret = jpeg_create_signal(&s_pstruJpgOsrDev->s32SignalId);
		 if(HI_SUCCESS != Ret)
		 {
			 JPEG_DRV_ModExit();
			 return HI_FAILURE;
		 }
#endif

		 return HI_SUCCESS;
		 
}

/***************************************************************************************
* func			: JPEG_DRV_ModInit
* description	: when insmod the driver call this function
				  CNcomment: 加载设备初始化 CNend\n
* param[in] 	: NA
* retval		: HI_SUCCESS
* retval		: HI_FAILURE
* others:		: NA
***************************************************************************************/
HI_S32 JPEG_DRV_ModInit(HI_VOID)
{

        HI_S32 Ret = HI_FAILURE;

#ifndef HI_MCE_SUPPORT
		Ret = JPEG_DRV_K_ModInit();
		if (HI_SUCCESS != Ret)
        { 
        	if(NULL != s_pstruJpgOsrDev)
        	{
				HI_GFX_KFREE(HIGFX_JPGDEC_ID, (HI_VOID *)s_pstruJpgOsrDev);
        	}
			s_pstruJpgOsrDev = HI_NULL;
            return HI_FAILURE;
        }
#endif

        Ret = HI_GFX_PM_Register();
        if (HI_SUCCESS != Ret)
        { 
        	if(NULL != s_pstruJpgOsrDev)
        	{
				HI_GFX_KFREE(HIGFX_JPGDEC_ID, (HI_VOID *)s_pstruJpgOsrDev);
        	}
			s_pstruJpgOsrDev = HI_NULL;
            return HI_FAILURE;
        }

#ifdef CONFIG_JPEG_PROC_ENABLE
		JPEG_Proc_init();
#endif

        s_pstruJpgOsrDev->bDecTask	= HI_FALSE;
		HI_GFX_InitSmmu((HI_U32)(JPGD_MMU_REG_BASEADDR));

		/** display the version message  */
		/** CNcomment: 显示版本号  */
		jpg_osr_showversion(HIGFX_JPGDEC_ID);
    	   
        return HI_SUCCESS;

    
} 
 /*****************************************************************************
* func            : jpg_osr_ioctl
* description     : jpeg device control interface
* param[in]       : inode  
* param[in]       : flip    device file message
* param[in]       : Cmd  
* param[in]       : Arg    
* output          : none
* retval          : HI_SUCCESS
* retval          : HI_ERR_JPG_DEC_BUSY
* retval          : -EINVAL
* retval          : -EAGAIN
* others:	      : nothing
*****************************************************************************/
static long jpg_osr_ioctl(struct file *file, HI_U32 Cmd, unsigned long Arg)
{

    switch(Cmd)
    {
		case CMD_JPG_GETSIGNAL_ID:
		{
			#ifdef CONFIG_JPEG_USE_KERNEL_SIGNAL
			if(copy_to_user((HI_VOID *)Arg, (HI_VOID *)&s_pstruJpgOsrDev->s32SignalId, sizeof(int)))
		        { 
                return -EFAULT;  
       	    }
			#endif
			break;
		}
		case CMD_JPG_OPEN_RESET_CLOCK:
		{
			/** open the clock          **/
			/** CNcomment: 打开工作时钟 **/
			jpg_do_clock_on();
			/** select clock frequence  **/
			/** CNcomment: 选择时钟频率 **/
			jpg_select_clock_frep();
			
			/** reset register                        **/
			/** CNcomment: 复位寄存器使之能够重新工作 **/
			jpg_do_reset();
			/** cancle the reset,now can work   **/
			/** CNcomment: 撤消复位使之能够工作 **/
			jpg_do_cancel_reset();
			
			/** trun the halt status  **/
			/** CNcomment:            **/
			JpgHalSetIntMask(0x0);
			
			s_pstruJpgOsrDev->IntType    = JPG_INTTYPE_NONE;
			s_pstruJpgOsrDev->bDecTask   = HI_TRUE; /** 开始解码任务 **/
			break;
		}
        case CMD_JPG_GETDEVICE:
        {

            JPG_DISPOSE_CLOSE_S *sDisposeClose = NULL;
            sDisposeClose = file->private_data;
			
        	if(down_interruptible(&s_JpegMutex)){
        	      sDisposeClose->bOpenUp = HI_FALSE;
				  return HI_FAILURE;
            }	
            /**
             ** if has not initial device, return failure
             **/
            if (HI_NULL == s_pstruJpgOsrDev)
            {   
                return HI_FAILURE;
            }
            /**
             ** locked the occupied device 
             **/
            if(down_interruptible(&s_pstruJpgOsrDev->SemGetDev))
            {
               /*nothing to do!*/
            }

            s_pstruJpgOsrDev->bEngageFlag = HI_TRUE;
            s_pstruJpgOsrDev->IntType    = JPG_INTTYPE_NONE;
            s_pstruJpgOsrDev->pFile      = file;
            s_pstruJpgOsrDev->bLock      = HI_TRUE;/** 已经被锁住了 **/
			
            sDisposeClose->s32DecClose   = HI_FAILURE;
            sDisposeClose->bOpenUp       = HI_TRUE;
            sDisposeClose->bRealse       = HI_FALSE;

             /** select clock frequence  */
	         /** CNcomment: 选择时钟频率 */
	         jpg_select_clock_frep();
	         /** open the clock  */
	         /** CNcomment: 打开工作时钟 */
             jpg_do_clock_on();
             /**
              ** to JPG reset operation, open the clock
              **/
             jpg_do_reset();
	         /** cancle the reset,now can work  */
	         /** CNcomment: 撤消复位使之能够工作 */
	         jpg_do_cancel_reset();
             /** trun the halt status  */
	         /** CNcomment:   */
             JpgHalSetIntMask(0x0);
			 HI_GFX_InitSmmu((HI_U32)(JPGD_MMU_REG_BASEADDR));
             
             up(&s_pstruJpgOsrDev->SemGetDev);
			 
             /**
              **开始解码任务
              **/
			 s_pstruJpgOsrDev->bDecTask = HI_TRUE;
			 
             break;
             
        }
        case CMD_JPG_SUSPEND:
        {    
			 #ifdef CONFIG_JPEG_SUSPEND
            	pm_message_t state = {0};
			 	jpg_osr_suspend(NULL,state);
			 #endif
             break;
        }
        case CMD_JPG_RESUME:
        {    
			 #ifdef CONFIG_JPEG_SUSPEND
             	jpg_osr_resume(NULL);
			 #endif
             break;
        }
        case CMD_JPG_GETINTSTATUS:
        {

			
            JPG_GETINTTYPE_S IntInfo;
            HI_S32 s32Ret = HI_SUCCESS;
            /**
             ** checkt parameter
             **/
            if (0 == Arg)
            {
                s_pstruJpgOsrDev->bDecTask	= HI_FALSE;
                return HI_FAILURE;
            }
            /**
             ** copy input parameter
             **/
           if(copy_from_user((HI_VOID *)&IntInfo, (HI_VOID *)Arg, sizeof(JPG_GETINTTYPE_S)))
		   {   
		        s_pstruJpgOsrDev->bDecTask	= HI_FALSE;
                return -EFAULT;  
           	}
			s32Ret = jpg_osr_getintstatus((DRV_JPEG_EXT_GETINTTYPE_S*)&IntInfo);
			if(HI_FAILURE == s32Ret)
			{
			    s_pstruJpgOsrDev->bDecTask	= HI_FALSE;
				return HI_FAILURE;
			}

            /** 
             ** get halt status and return
             **/
            if(copy_to_user((HI_VOID *)Arg, (HI_VOID *)&IntInfo,sizeof(JPG_GETINTTYPE_S)))
		    {
		        s_pstruJpgOsrDev->bDecTask	= HI_FALSE;
                return -EFAULT;  
           	}

            if(JPG_INTTYPE_ERROR == IntInfo.IntType || JPG_INTTYPE_FINISH == IntInfo.IntType){
                s_pstruJpgOsrDev->bDecTask	= HI_FALSE;
            }
            
            break;
        }
        case CMD_JPG_READPROC:
        {   

             #ifdef CONFIG_JPEG_PROC_ENABLE 
	            HI_BOOL bIsProcOn = HI_FALSE;
				JPEG_Get_Proc_Status(&bIsProcOn);
	            if(HI_TRUE == bIsProcOn)
	            {
		            if (0 == Arg)
		            {
		                return HI_FAILURE;
		            }
		                        
		            if(copy_from_user((HI_VOID *)&s_stJpeg6bProcInfo, (HI_VOID *)Arg, sizeof(HI_JPEG_PROC_INFO_S)))
				    {  
		                return -EFAULT;  
		           	}
	            }
			#endif
			
            break;
			
        }   	
        case CMD_JPG_GETRESUMEVALUE:
        {/** 获取待机唤醒信息 **/
			#ifdef CONFIG_JPEG_SUSPEND
                HI_JPG_SAVEINFO_S stSaveInfo = {0};
	            if (0 == Arg)
	            {
	                return HI_FAILURE;
	            }
	            JPG_GetResumeValue(&stSaveInfo);
	            if(copy_to_user((HI_VOID *)Arg, (HI_VOID *)&stSaveInfo,sizeof(stSaveInfo)))
			    {
	                return -EFAULT;
	           	}
				s_pstruJpgOsrDev->bSuspendSignal = HI_FALSE;
    			s_pstruJpgOsrDev->bResumeSignal  = HI_FALSE;
			#endif
            break;
			
        }
        case CMD_JPG_GETSUSPEND:
        { /** 获取待机信息 **/
			
            #ifdef CONFIG_JPEG_SUSPEND
	            if (0 == Arg)
	            {
	                return HI_FAILURE;
	            }
	            if(copy_to_user((HI_VOID *)Arg, (HI_VOID *)&s_pstruJpgOsrDev->bSuspendSignal,sizeof(s_pstruJpgOsrDev->bSuspendSignal)))
			    {  
	                return -EFAULT;
	           	}
			#endif
            break;
			
        }
        case CMD_JPG_GETRESUME:
        {/** 获取待机唤醒信息 **/  
			#ifdef CONFIG_JPEG_SUSPEND
	            if (0 == Arg)
	            {
	                return HI_FAILURE;
	            }
	                        
	            if(copy_to_user((HI_VOID *)Arg, (HI_VOID *)&s_pstruJpgOsrDev->bResumeSignal,sizeof(s_pstruJpgOsrDev->bResumeSignal)))
			    {
	                return -EFAULT;
	           	}
			#endif
            break;
			
        }
        case CMD_JPG_CANCEL_RESET:
		{
             jpg_do_cancel_reset();
			 break;
        }
        case CMD_JPG_RESET:
		{
             jpg_do_reset();
			 break;
        }
#ifdef CONFIG_JPEG_OMX_FUNCTION
        case CMD_JPG_CREATEDEC:
        {
             HI_U64 u64DecHandle = 0;
             u64DecHandle = (unsigned long)HI_GFX_KMALLOC(HIGFX_JPGDEC_ID,sizeof(IMAG_INFO_S),GFP_KERNEL);
             if(0 == u64DecHandle ){
                return HI_FAILURE;
             }
             memset((HI_VOID*)(unsigned long)u64DecHandle,0,sizeof(IMAG_INFO_S));
             if(copy_to_user((HI_VOID *)Arg, (HI_VOID *)&u64DecHandle,sizeof(HI_U64)))
		     {
                return -EFAULT;
           	 }
             //JPEG_TRACE("=====###%s u64DecHandle = 0x%llx\n",__FUNCTION__,u64DecHandle);
             break;
        }
        case CMD_JPG_DECINFO:
        {
             HI_S32 s32Ret = HI_SUCCESS;
             HI_DRV_JPEG_INMSG_S stInMsg;
             if (0 == Arg)
                return HI_FAILURE;

             memset(&stInMsg,0,sizeof(HI_DRV_JPEG_INMSG_S));
             if(copy_from_user((HI_VOID *)&stInMsg, (HI_VOID *)Arg, sizeof(HI_DRV_JPEG_INMSG_S)))
		     {
                return -EFAULT;
           	 }
             if(0 == stInMsg.u64DecHandle)
             {
                JPEG_TRACE("the dec handle has been destoryed\n");
                return HI_FAILURE;
             }
             s32Ret = jpg_dec_parse(&stInMsg);
             if(HI_SUCCESS != s32Ret)
             {
                JPEG_TRACE("jpg_dec_parse failure s32Ret = 0x%x\n",s32Ret);
                return HI_FAILURE;
             }
             jpeg_get_imginfo(&stInMsg);

             if(copy_to_user((HI_VOID *)Arg, (HI_VOID *)&stInMsg,sizeof(HI_DRV_JPEG_INMSG_S)))
		     {
                return -EFAULT;
           	 }
             
             break;
        }
        case CMD_JPG_DECOUTINFO:
        {
             HI_S32 s32Ret = HI_SUCCESS;
             HI_DRV_JPEG_OUTMSG_S stOutMsg;
             if (0 == Arg)
                return HI_FAILURE;

             memset(&stOutMsg,0,sizeof(HI_DRV_JPEG_OUTMSG_S));
             if(copy_from_user((HI_VOID *)&stOutMsg, (HI_VOID *)Arg, sizeof(HI_DRV_JPEG_OUTMSG_S)))
		     {
                return -EFAULT;
           	 }
             if(0 == stOutMsg.u64DecHandle)
             {
                JPEG_TRACE("the dec handle has been destoryed\n");
                return HI_FAILURE;
             }
             
             s32Ret = jpeg_get_sofn(&stOutMsg);
             if(HI_SUCCESS != s32Ret)
             {
                JPEG_TRACE("jpeg_get_sofn failure\n");
                return HI_FAILURE;
             }

             if(copy_to_user((HI_VOID *)Arg, (HI_VOID *)&stOutMsg,sizeof(HI_DRV_JPEG_OUTMSG_S)))
		     {
                return -EFAULT;
           	 }
             break;
        }
        case CMD_JPG_DECODE:
        {
             HI_S32 s32Ret = HI_SUCCESS;
             HI_JPEG_DECINFO_S stDecInfo;
             JPG_DISPOSE_CLOSE_S *sDisposeClose = NULL;
             sDisposeClose = file->private_data;
             
             if (0 == Arg)
                return HI_FAILURE;
             
             memset(&stDecInfo,0,sizeof(HI_JPEG_DECINFO_S));
             if(copy_from_user((HI_VOID *)&stDecInfo, (HI_VOID *)Arg, sizeof(HI_JPEG_DECINFO_S)))
		     {
                return -EFAULT;
           	 }
             if(0 == stDecInfo.stOutMsg.u64DecHandle || 0 == stDecInfo.stInMsg.u64DecHandle)
             {
                JPEG_TRACE("the dec handle has been destoryed\n");
                return HI_FAILURE;
             }
             
             if(down_interruptible(&s_JpegMutex))
             {
				return HI_FAILURE;
             }
             
             s_pstruJpgOsrDev->bEngageFlag = HI_TRUE;
             s_pstruJpgOsrDev->IntType     = JPG_INTTYPE_NONE;
             s_pstruJpgOsrDev->pFile       = file;
             sDisposeClose->s32DecClose    = HI_FAILURE;
             sDisposeClose->bOpenUp        = HI_TRUE;
             sDisposeClose->bRealse        = HI_TRUE;
            
             /** set clock and reset **/
	         jpg_select_clock_frep();
             jpg_do_clock_on();
             jpg_do_reset();
	         jpg_do_cancel_reset();
             JpgHalSetIntMask(0x0);

             s32Ret = jpg_osr_dec(&stDecInfo);
             if(HI_SUCCESS != s32Ret)
             {
                JPEG_TRACE("jpg_osr_dec failure s32Ret = 0x%x\n",s32Ret);
                up(&s_JpegMutex);
                wake_up_interruptible(&s_pstruJpgOsrDev->QWaitMutex);
                return HI_FAILURE;
             }             
             up(&s_JpegMutex);
             wake_up_interruptible(&s_pstruJpgOsrDev->QWaitMutex);
             
             break;
             
        }
        case CMD_JPG_GETLUPIXSUM:
        {
			 HI_U64 u64LuPixValue = 0;
             HI_DRV_JPEG_OUTMSG_S stOutMsg;
             if (0 == Arg)
                return HI_FAILURE;

             memset(&stOutMsg,0,sizeof(HI_DRV_JPEG_OUTMSG_S));
             if(copy_from_user((HI_VOID *)&stOutMsg, (HI_VOID *)Arg, sizeof(HI_DRV_JPEG_OUTMSG_S)))
		     {
                return -EFAULT;
           	 }

             if(0 == stOutMsg.u64DecHandle)
             {
                JPEG_TRACE("the dec handle has been destoryed\n");
                return HI_FAILURE;
             }

             jpg_osr_getlupixsum(stOutMsg.u64DecHandle,&u64LuPixValue);

             stOutMsg.u64LuPixValue = u64LuPixValue;
             
             if(copy_to_user((HI_VOID *)Arg, (HI_VOID *)&stOutMsg,sizeof(HI_DRV_JPEG_OUTMSG_S)))
		     {
                return -EFAULT;
           	 }
             break;
        }
        case CMD_JPG_DESTORYDEC:
        {
            HI_U64 u64DecHandle = 0;
            if (0 == Arg)
            {
                return HI_FAILURE;
            }
            if(copy_from_user((HI_VOID *)&u64DecHandle, (HI_VOID *)Arg, sizeof(HI_U64)))
		    {
                return -EFAULT;
           	}
            if(0 == u64DecHandle){
				return HI_FAILURE;
            }
            
            jpeg_mem_destory(u64DecHandle);

            HI_GFX_KFREE(HIGFX_JPGDEC_ID, (HI_VOID *)(unsigned long)u64DecHandle);
            
            break;
        }
#endif
        default:
        {
            return -EINVAL;
        }
        
    }
	
    return HI_SUCCESS;


}



/** 这两个函数要按此命名 **/
#ifdef MODULE
/** 
 ** this two function is defined at msp/drv/include/drv_jpeg_ext.h
 **/
module_init(JPEG_DRV_ModInit);
module_exit(JPEG_DRV_ModExit);
#endif


EXPORT_SYMBOL(JPEG_DRV_K_ModInit);


#ifndef HI_ADVCA_FUNCTION_RELEASE
MODULE_DESCRIPTION("driver for the all jpeg");
MODULE_AUTHOR("HISILICON");
MODULE_LICENSE("GPL");
#else
MODULE_DESCRIPTION("");
MODULE_AUTHOR("");
MODULE_LICENSE("GPL");
#endif


#endif/**HI_BUILD_IN_BOOT**/
