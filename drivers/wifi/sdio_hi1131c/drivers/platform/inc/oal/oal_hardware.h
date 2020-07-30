/******************************************************************************

                  版权所有 (C), 2001-2011, 华为技术有限公司

 ******************************************************************************
  文 件 名   : oal_hardware.h
  版 本 号   : 初稿
  作    者   : 
  生成日期   : 2012年11月29日
  最近修改   :
  功能描述   : 操作系统硬件相关接口封装
  函数列表   :
  修改历史   :
  1.日    期   : 2012年11月29日
    作    者   : 
    修改内容   : 创建文件

******************************************************************************/

#ifndef __OAL_HARDWARE_H__
#define __OAL_HARDWARE_H__

#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif
#endif


/*****************************************************************************
  1 其他头文件包含
*****************************************************************************/
#include "oal_types.h"
#include "oal_pci_if.h"
#include "arch/oal_hardware.h"

/*****************************************************************************
  2 宏定义
*****************************************************************************/
#define OAL_CONST                                   const

#define OAL_IRQ_NUM             (5)       /* 中断号 TBD */

#define PCI_ANY_ID              (~0)

#define OAL_IRQ_INIT_MAC_DEV(_dev, _irq, _type, _name, _arg, _func) \
    {(_dev).ul_irq          = (_irq); \
     (_dev).l_irq_type      = (_type); \
     (_dev).pc_name         = (_name); \
     (_dev).p_drv_arg       = (_arg); \
     (_dev).p_irq_intr_func = (_func);}

#define OAL_PCI_GET_DEV_ID(_dev)   (_dev->device);

#define MAX_NUM_CORES               2

/*****************************************************************************
  3 枚举定义
*****************************************************************************/

/*****************************************************************************
  5 消息头定义
*****************************************************************************/


/*****************************************************************************
  6 消息定义
*****************************************************************************/


/*****************************************************************************
  7 STRUCT定义
*****************************************************************************/

/*timer寄存器*/

/*TIMER外部控制寄存器*/
typedef struct
{
    volatile oal_uint32 *pul_sc_ctrl;
} oal_hi_timer_ctrl_reg_stru;

/*****************************************************************************
  8 UNION定义
*****************************************************************************/


/*****************************************************************************
  4 全局变量声明
*****************************************************************************/


/*****************************************************************************
  9 OTHERS定义
*****************************************************************************/


/*****************************************************************************
  10 函数声明
*****************************************************************************/


#ifdef __cplusplus
    #if __cplusplus
        }
    #endif
#endif

#endif /* end of oal_hardware.h */
