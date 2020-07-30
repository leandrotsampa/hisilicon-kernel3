/******************************************************************************

                  ��Ȩ���� (C), 2001-2011, ��Ϊ�������޹�˾

 ******************************************************************************
  �� �� ��   : oal_timer.h
  �� �� ��   : ����
  ��    ��   : 
  ��������   : 2016��07��29��
  ����޸�   :
  ��������   : oal_timer.h ��ͷ�ļ�
  �����б�   :
  �޸���ʷ   :
  1.��    ��   : 2016��07��29��
    ��    ��   : 
    �޸�����   : �����ļ�

******************************************************************************/

#ifndef __OAL_LITEOS_TIMER_H__
#define __OAL_LITEOS_TIMER_H__

#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif
#endif


/*****************************************************************************
  1 ����ͷ�ļ�����
*****************************************************************************/
#include <linux/timer.h>
#include <los_swtmr.h>
#include "oal_time.h"

/*****************************************************************************
  2 STRUCT����
*****************************************************************************/
typedef struct timer_list              oal_timer_list_stru;

/*****************************************************************************
  3 ö�ٶ���
*****************************************************************************/


/*****************************************************************************
  4 ȫ�ֱ�������
*****************************************************************************/


/*****************************************************************************
  5 ��Ϣͷ����
*****************************************************************************/


/*****************************************************************************
  6 ��Ϣ����
*****************************************************************************/


/*****************************************************************************
  7 �궨��
*****************************************************************************/


/*****************************************************************************
  8 UNION����
*****************************************************************************/


/*****************************************************************************
  9 OTHERS����
*****************************************************************************/
typedef void (*oal_timer_func)(oal_uint);

/*****************************************************************************
  10 ��������
*****************************************************************************/

/*****************************************************************************
 �� �� ��  : oal_timer_init
 ��������  : ��ʼ����ʱ��
 �������  : pst_timer: ��ʱ���ṹ��ָ��
 �������  : ��
 �� �� ֵ  :
 ���ú���  :
 ��������  :

 �޸���ʷ      :
  1.��    ��   : 2012��11��13��
    ��    ��   : 
    �޸�����   : �����ɺ���

*****************************************************************************/
OAL_STATIC OAL_INLINE oal_void  oal_timer_init(oal_timer_list_stru *pst_timer, oal_uint32 ul_delay, oal_timer_func p_func, oal_uint ui_arg)
{
    init_timer(pst_timer);
    pst_timer->expires = OAL_MSECS_TO_JIFFIES(ul_delay);
    pst_timer->function = p_func;
    pst_timer->data = ui_arg;
}

/*****************************************************************************
 �� �� ��  : oal_timer_delete
 ��������  : ɾ����ʱ��
 �������  : pst_timer: ��ʱ���ṹ��ָ��
 �������  : ��
 �� �� ֵ  :
 ���ú���  :
 ��������  :

 �޸���ʷ      :
  1.��    ��   : 2012��11��13��
    ��    ��   : 
    �޸�����   : �����ɺ���

*****************************************************************************/
OAL_STATIC OAL_INLINE oal_int32  oal_timer_delete(oal_timer_list_stru *pst_timer)
{
    return del_timer(pst_timer);
}

/*****************************************************************************
 �� �� ��  : oal_timer_delete_sync
 ��������  : ͬ��ɾ����ʱ�������ڶ��
 �������  : pst_timer: ��ʱ���ṹ��ָ��
 �������  : ��
 �� �� ֵ  :
 ���ú���  :
 ��������  :

 �޸���ʷ      :
  1.��    ��   : 2012��11��13��
    ��    ��   : 
    �޸�����   : �����ɺ���

*****************************************************************************/
OAL_STATIC OAL_INLINE oal_int32  oal_timer_delete_sync(oal_timer_list_stru *pst_timer)
{
    return del_timer_sync(pst_timer);
}

/*****************************************************************************
 �� �� ��  : oal_timer_add
 ��������  : ���ʱ��
 �������  : pst_timer: ��ʱ���ṹ��ָ��
 �������  : ��
 �� �� ֵ  :
 ���ú���  :
 ��������  :

 �޸���ʷ      :
  1.��    ��   : 2012��11��13��
    ��    ��   : 
    �޸�����   : �����ɺ���

*****************************************************************************/
OAL_STATIC OAL_INLINE oal_void  oal_timer_add(oal_timer_list_stru *pst_timer)
{
    add_timer(pst_timer);
}

/*****************************************************************************
 �� �� ��  : oal_timer_start
 ��������  : ������ʱ��
 �������  : pst_timer: �ṹ��ָ��
             ui_expires: ����������¼�
 �������  : ��
 �� �� ֵ  :
 ���ú���  :
 ��������  :

 �޸���ʷ      :
  1.��    ��   : 2012��11��13��
    ��    ��   : 
    �޸�����   : �����ɺ���

*****************************************************************************/
OAL_STATIC OAL_INLINE oal_int32  oal_timer_start(oal_timer_list_stru *pst_timer, oal_uint ui_delay)
{
     
    if (FALSE == pst_timer->used)
    {
        pst_timer->expires = OAL_MSECS_TO_JIFFIES(ui_delay);
        add_timer(pst_timer);
        return OAL_SUCC;
    }
    else
    {
        return mod_timer(pst_timer, OAL_MSECS_TO_JIFFIES(ui_delay));
    }
}

/*****************************************************************************
 �� �� ��  : oal_timer_start_on
 ��������  : ָ��cpu,������ʱ��,����ʱtimerҪ���ڷǼ���״̬���߻�����
 �������  : pst_timer: �ṹ��ָ��
             ui_expires: ����������¼�
 �������  : ��
 �� �� ֵ  :
 ���ú���  :
 ��������  :

 �޸���ʷ      :
  1.��    ��   : 2016��1��20��
    ��    ��   : 
    �޸�����   : �����ɺ���

*****************************************************************************/
OAL_STATIC OAL_INLINE oal_void  oal_timer_start_on(oal_timer_list_stru *pst_timer, oal_uint ui_delay, oal_int32 cpu)
{
    pst_timer->expires = OAL_MSECS_TO_JIFFIES(ui_delay);
    add_timer(pst_timer);
}



#ifdef __cplusplus
    #if __cplusplus
        }
    #endif
#endif

#endif /* end of oal_timer.h */


