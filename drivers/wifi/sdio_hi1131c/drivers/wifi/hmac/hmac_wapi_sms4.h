/******************************************************************************

                  ��Ȩ���� (C), 2001-2011, ��Ϊ�������޹�˾

 ******************************************************************************
  �� �� ��   : hmac_sms4.h
  �� �� ��   : ����
  ��    ��   : 
  ��������   : 2015��5��20��
  ����޸�   :
  ��������   : hmac_sms4.c��ͷ�ļ�
  �����б�   :
  �޸���ʷ   :
  1.��    ��   : 2015��5��20��
    ��    ��   : 
    �޸�����   : �����ļ�

******************************************************************************/


#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif
#endif


/*****************************************************************************
  1 ͷ�ļ�����
*****************************************************************************/
//#include "mac_resource.h"
//#include "hmac_vap.h"
//#include "hmac_user.h"
//#include "mac_11i.h"

#undef  THIS_FILE_ID
#define THIS_FILE_ID OAM_FILE_ID_HMAC_WAPI_SMS4_H
#ifdef _PRE_WLAN_FEATURE_WAPI
/*****************************************************************************/
/*****************************************************************************
  2 �궨��
*****************************************************************************/
#define Rotl(_x, _y) (((_x) << (_y)) | ((_x) >> (32 - (_y)))) /* ѭ������ */
#define getbyte(_x,_y) (((unsigned char *)&(_x))[_y]) /* ��yΪ�±꣬��ȡx��Ӧ���ֽ�ֵ */

#define ByteSub(_S, _A) ((_S)[((oal_uint32)(_A)) >> 24 & 0xFF] << 24 ^ \
                     (_S)[((oal_uint32)(_A)) >> 16 & 0xFF] << 16 ^ \
                     (_S)[((oal_uint32)(_A)) >>  8 & 0xFF] <<  8 ^ \
                     (_S)[((oal_uint32)(_A)) & 0xFF])

#define L1(_B) ((_B) ^ Rotl(_B, 2) ^ Rotl(_B, 10) ^ Rotl(_B, 18) ^ Rotl(_B, 24))

#define L2(_B) ((_B) ^ Rotl(_B, 13) ^ Rotl(_B, 23))

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


extern    oal_void hmac_sms4_crypt(oal_uint8 *puc_Input, oal_uint8 *puc_Output, oal_uint32 *pul_rk);
extern    oal_void hmac_sms4_keyext(oal_uint8 *puc_key, oal_uint32 *pul_rk);

#endif



#ifdef __cplusplus
    #if __cplusplus
        }
    #endif
#endif


