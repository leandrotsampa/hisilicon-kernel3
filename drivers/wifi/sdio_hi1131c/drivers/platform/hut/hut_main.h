/******************************************************************************

                  ��Ȩ���� (C), 2001-2011, ��Ϊ�������޹�˾

 ******************************************************************************
  �� �� ��   : hut_main.h
  �� �� ��   : ����
  ��    ��   : 
  ��������   : 2013��10��15��
  ����޸�   :
  ��������   : hut_main.c ��ͷ�ļ�
  �����б�   :
  �޸���ʷ   :
  1.��    ��   : 2013��10��15��
    ��    ��   : 
    �޸�����   : �����ļ�

******************************************************************************/

#ifndef __HUT_MAIN_H__
#define __HUT_MAIN_H__

#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif
#endif


/*****************************************************************************
  1 ����ͷ�ļ�����
*****************************************************************************/
#include "oal_ext_if.h"

#undef  THIS_FILE_ID
#define THIS_FILE_ID OAM_FILE_ID_HUT_MAIN_H


/*****************************************************************************
  2 �궨��
*****************************************************************************/
#define HUT_ERR_LOG(_uc_vap_id, _puc_string)
#define HUT_ERR_LOG1(_uc_vap_id, _puc_string, _l_para1)
#define HUT_ERR_LOG2(_uc_vap_id, _puc_string, _l_para1, _l_para2)
#define HUT_ERR_LOG3(_uc_vap_id, _puc_string, _l_para1, _l_para2, _l_para3)
#define HUT_ERR_LOG4(_uc_vap_id, _puc_string, _l_para1, _l_para2, _l_para3, _l_para4)
#define HUT_ERR_VAR(_uc_vap_id, _c_fmt, ...)

#define HUT_WARNING_LOG(_uc_vap_id, _puc_string)
#define HUT_WARNING_LOG1(_uc_vap_id, _puc_string, _l_para1)
#define HUT_WARNING_LOG2(_uc_vap_id, _puc_string, _l_para1, _l_para2)
#define HUT_WARNING_LOG3(_uc_vap_id, _puc_string, _l_para1, _l_para2, _l_para3)
#define HUT_WARNING_LOG4(_uc_vap_id, _puc_string, _l_para1, _l_para2, _l_para3, _l_para4)
#define HUT_WARNING_VAR(_uc_vap_id, _c_fmt, ...)

#define HUT_INFO_LOG(_uc_vap_id, _puc_string)
#define HUT_INFO_LOG1(_uc_vap_id, _puc_string, _l_para1)
#define HUT_INFO_LOG2(_uc_vap_id, _puc_string, _l_para1, _l_para2)
#define HUT_INFO_LOG3(_uc_vap_id, _puc_string, _l_para1, _l_para2, _l_para3)
#define HUT_INFO_LOG4(_uc_vap_id, _puc_string, _l_para1, _l_para2, _l_para3, _l_para4)
#define HUT_INFO_VAR(_uc_vap_id, _c_fmt, ...)

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
  7 STRUCT����
*****************************************************************************/
typedef struct
{
    oal_uint8 *puc_base_addr_origin;   /* �ڴ��������ʼ��ַ */
    oal_uint8 *puc_base_addr_align;    /* 4�ֽڶ�������ʼ��ַ */
}hut_mem_addr_stru;

/* ˽��֡ͷ�ṹ */
typedef struct
{
    oal_uint8    bit_flag : 1,   /* 0: ���ֶ�; 1: �ֶ� */
                 bit_last : 1,   /* 0: �м�ķֶ�; 1: ���һ���ֶ�*/
                 bit_resv : 6;
    oal_uint8    uc_num;
    oal_uint16   us_len;         /* ֡��(������֡ͷ) */
}hut_frag_hdr_stru;

/*****************************************************************************
  8 UNION����
*****************************************************************************/


/*****************************************************************************
  9 OTHERS����
*****************************************************************************/


/*****************************************************************************
  10 ��������
*****************************************************************************/


#ifdef __cplusplus
    #if __cplusplus
        }
    #endif
#endif

#endif /* end of hut_main.h */