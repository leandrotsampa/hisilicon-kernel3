/******************************************************************************

                  ��Ȩ���� (C), 2001-2011, ��Ϊ�������޹�˾

 ******************************************************************************
  �� �� ��   : dmac_mgmt_ap.h
  �� �� ��   : ����
  ��    ��   : 
  ��������   : 2013��6��7��
  ����޸�   :
  ��������   : dmac_mgmt_ap.c ��ͷ�ļ�
  �����б�   :
  �޸���ʷ   :
  1.��    ��   : 2013��6��7��
    ��    ��   : 
    �޸�����   : �����ļ�

******************************************************************************/

#ifndef __DMAC_MGMT_AP_H__
#define __DMAC_MGMT_AP_H__

#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif
#endif


/*****************************************************************************
  1 ����ͷ�ļ�����
*****************************************************************************/
#include "oal_ext_if.h"
#include "dmac_vap.h"


#undef  THIS_FILE_ID
#define THIS_FILE_ID OAM_FILE_ID_DMAC_MGMT_AP_H
/*****************************************************************************
  2 �궨��
*****************************************************************************/


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


/*****************************************************************************
  8 UNION����
*****************************************************************************/


/*****************************************************************************
  9 OTHERS����
*****************************************************************************/


/*****************************************************************************
  10 ��������
*****************************************************************************/
extern oal_uint32  dmac_ap_up_rx_probe_req(dmac_vap_stru *pst_dmac_vap, oal_netbuf_stru *pst_netbuf);
extern oal_uint32  dmac_ap_up_rx_generate_chtxt(dmac_vap_stru                 *pst_dmac_vap,
                                                            oal_netbuf_stru                *pst_netbuf,
                                                            frw_event_mem_stru             *pst_event_mem);

extern oal_uint16  dmac_mgmt_encap_probe_response(dmac_vap_stru *pst_dmac_vap, oal_netbuf_stru *pst_netbuf, oal_uint8 *puc_ra, oal_bool_enum_uint8 en_is_p2p_req);











#ifdef __cplusplus
    #if __cplusplus
        }
    #endif
#endif

#endif /* end of dmac_mgmt_ap.h */