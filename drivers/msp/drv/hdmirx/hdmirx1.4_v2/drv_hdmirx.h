/******************************************************************************

  Copyright (C), 2012-2050, Hisilicon Tech. Co., Ltd.

 ******************************************************************************
  File Name     : drv_hdmirx.h
  Version       : Initial Draft
  Author        : Hisilicon multimedia software group
  Created       : 2014/01/16
  Description   : 
  History       :
  1.Date        : 2014/01/16
    Author      : t00202585
    Modification: Created file
******************************************************************************/

#ifndef __DRV_HDMIRX_H__
#define __DRV_HDMIRX_H__

#define SUPPORT_ACP 1
//#define SUPPORT_CP_MUTE 0
#define SUPPORT_AUDIO_INFOFRAME 1
#define SUPPORT_HBR 1
#define SUPPORT_DSD 0
#define SUPPORT_MHL 1
    #define SUPPORT_MHL_20	(SUPPORT_MHL&&0)
    #define SUPPORT_CBUS_CEC (SUPPORT_MHL&&0&&SUPPORT_CEC)

#define SUPPORT_AEC 1
#define SUPPORT_HPD_ACTION 0
//#define SUPPORT_PWR5V_DET 1
#if (defined(CHIP_TYPE_hi3796cv100)||defined(CHIP_TYPE_hi3796cv100_a)|| defined(CHIP_TYPE_hi3798cv100)\
    || defined(CHIP_TYPE_hi3798cv100_a))
    #define SUPPORT_PORT0_ONLY 1
#else
    #define SUPPORT_PORT0_ONLY 0
#endif

#define SUPPORT_TRYEQ  0

#define SUPPORT_4K_VIC 0

#if (defined (CHIP_TYPE_hi3751v100)||defined(CHIP_TYPE_hi3796cv100)||defined(CHIP_TYPE_hi3798cv100))
    #define SUPPORT_DOUBLE_CTRL 1
#else
    #define SUPPORT_DOUBLE_CTRL 0 
#endif

#define SUPPORT_SUBPORT 0

#define HDMIRX_CHECK_NULL_PTR(ptr) \
    do\
    {\
        if (NULL == ptr)\
        {\
            HI_ERR_DEV("Null pointer!\n");\
            return HI_FAILURE;\
        }\
    } while(0)

#define HDMIRX_TIME_DIFF_US(CurTime, LastTime) (((CurTime.tv_sec-LastTime.tv_sec)*1000000)+(CurTime.tv_usec-LastTime.tv_usec))
#define HDMIRX_TIME_DIFF_MS(CurTime, LastTime) (((CurTime.tv_sec-LastTime.tv_sec)*1000)+(CurTime.tv_usec-LastTime.tv_usec)/1000)

#endif
