/******************************************************************************

                  版权所有 (C), 2001-2011, 华为技术有限公司

 ******************************************************************************
  文 件 名   : oal_spinlock.h
  版 本 号   : 初稿
  作    者   : ds
  生成日期   : 2016年7月27日
  最近修改   :
  功能描述   : oal_spinlock.h 的头文件
  函数列表   :
  修改历史   :
  1.日    期   : 2016年7月27日
    作    者   : ds
    修改内容   : 创建文件

******************************************************************************/

#ifndef __OAL_LITEOS_SPINLOCK_H__
#define __OAL_LITEOS_SPINLOCK_H__

#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif
#endif

#undef  THIS_FILE_ID
#define THIS_FILE_ID OAM_FILE_ID_OAL_SPINLOCK_H
/*****************************************************************************
  1 其他头文件包含
*****************************************************************************/
#include <los_task.h>

/*****************************************************************************
  2 宏定义
*****************************************************************************/
typedef struct _oal_spin_lock_stru_
{
    oal_uint32  lock;
}oal_spin_lock_stru;


#define oal_spin_lock_init(lock) do {}while(0)

#define oal_spin_lock(lock) do { LOS_TaskLock();}while(0)

#define oal_spin_unlock(lock) do { LOS_TaskUnlock();}while(0)

#define oal_spin_lock_bh(lock) do { LOS_IntLock();}while(0)
                                                        
#define oal_spin_unlock_bh(lock) do { LOS_IntUnLock();}while(0)

#define oal_spin_lock_irq(lock) do { LOS_IntLock();}while(0)

#define oal_spin_unlock_irq(lock) do { LOS_IntUnLock();}while(0)

#define oal_spin_lock_irq_save(lock, flags)  do { *flags = LOS_IntLock();} while(0)

#define oal_spin_unlock_irq_restore(lock, flags)  do { LOS_IntRestore(*flags);} while(0)

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
  7 STRUCT定义
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





#ifdef __cplusplus
    #if __cplusplus
        }
    #endif
#endif

#endif /* end of oal_spinlock.h */

