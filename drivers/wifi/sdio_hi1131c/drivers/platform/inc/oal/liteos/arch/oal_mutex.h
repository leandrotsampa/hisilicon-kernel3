/******************************************************************************

                  版权所有 (C), 2001-2011, 华为技术有限公司

 ******************************************************************************
  文 件 名   : oal_mutex.h
  版 本 号   : 初稿
  作    者   : 
  生成日期   : 2016年07月29日
  最近修改   :
  功能描述   : oal_mutex.h 的头文件
  函数列表   :
  修改历史   :
  1.日    期   : 2016年07月29日
    作    者   : 
    修改内容   : 创建文件

******************************************************************************/

#ifndef __OAL_LITEOS_MUTEX_H__
#define __OAL_LITEOS_MUTEX_H__

#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif
#endif


/*****************************************************************************
  1 其他头文件包含
*****************************************************************************/
#include <mutex.h>

/*****************************************************************************
  2 STRUCT定义
*****************************************************************************/
typedef pthread_mutex_t oal_mutex_stru;

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

# define    OAL_MUTEX_INIT(mutex)        pthread_mutex_init(mutex, NULL)
# define    OAL_MUTEX_DESTROY(mutex)        pthread_mutex_destroy(mutex)

/*****************************************************************************
  8 UNION定义
*****************************************************************************/


/*****************************************************************************
  9 OTHERS定义
*****************************************************************************/


/*****************************************************************************
  10 函数声明
*****************************************************************************/


OAL_STATIC OAL_INLINE oal_void oal_mutex_lock(oal_mutex_stru *lock)
{
    pthread_mutex_lock(lock);
}

OAL_STATIC OAL_INLINE oal_int32 oal_mutex_trylock(oal_mutex_stru *lock)
{
    return pthread_mutex_trylock(lock);
}

OAL_STATIC OAL_INLINE oal_void oal_mutex_unlock(oal_mutex_stru *lock)
{
    pthread_mutex_unlock(lock);
}




#ifdef __cplusplus
    #if __cplusplus
        }
    #endif
#endif

#endif /* end of oal_mutex.h */


