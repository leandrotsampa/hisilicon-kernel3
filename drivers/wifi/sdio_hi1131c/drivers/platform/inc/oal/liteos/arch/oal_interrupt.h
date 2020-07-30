/******************************************************************************

                  版权所有 (C), 2001-2011, 华为技术有限公司

 ******************************************************************************
  文 件 名   : oal_interrupt.h
  版 本 号   : 初稿
  作    者   : 
  生成日期   : 2016年8月4日
  最近修改   :
  功能描述   : oal_interrupt.h 的头文件
  函数列表   :
  修改历史   :
  1.日    期   : 2016年8月4日
    作    者   : 
    修改内容   : 创建文件

******************************************************************************/

#ifndef __OAL_LITEOS_INTERRUPT_H__
#define __OAL_LITEOS_INTERRUPT_H__

#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif
#endif


/*****************************************************************************
  1 其他头文件包含
*****************************************************************************/
#include <linux/interrupt.h>

/*****************************************************************************
  2 STRUCT定义
*****************************************************************************/

/*****************************************************************************
  3 枚举定义
*****************************************************************************/


/*****************************************************************************
  4 全局变量声明
*****************************************************************************/


/*****************************************************************************
  5 消息头定义
*****************************************************************************/


/*****************************************************************************
  6 消息定义
*****************************************************************************/


/*****************************************************************************
  7 宏定义
*****************************************************************************/

/*****************************************************************************
  8 UNION定义
*****************************************************************************/


/*****************************************************************************
  9 OTHERS定义
*****************************************************************************/


/*****************************************************************************
  10 函数声明
*****************************************************************************/



OAL_STATIC OAL_INLINE oal_int32 oal_request_irq(oal_uint32 irq, irq_handler_t handler, oal_ulong flags,
	    const oal_int8 *name, oal_void *dev)
{
    return request_irq(irq,handler,flags,name, dev);
}

OAL_STATIC OAL_INLINE oal_void oal_free_irq(oal_uint32 irq,oal_void *dev)
{
    free_irq(irq,dev);  
}

OAL_STATIC OAL_INLINE oal_void oal_enable_irq(oal_uint32 irq)
{
    enable_irq(irq);  
}

OAL_STATIC OAL_INLINE oal_void oal_disable_irq(oal_uint32 irq)
{
    disable_irq(irq);  
}

OAL_STATIC OAL_INLINE oal_void oal_disable_irq_nosync(oal_uint32 irq)
{
    disable_irq(irq);  
}

#ifdef __cplusplus
    #if __cplusplus
        }
    #endif
#endif

#endif /* end of oal_interrupt.h */


