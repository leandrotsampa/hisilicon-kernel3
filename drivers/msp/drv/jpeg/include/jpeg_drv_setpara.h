/******************************************************************************
*
* Copyright (C) 2015 Hisilicon Technologies Co., Ltd.  All rights reserved. 
*
* This program is confidential and proprietary to Hisilicon  Technologies Co., Ltd. (Hisilicon), 
* and may not be copied, reproduced, modified, disclosed to others, published or used, in
* whole or in part, without the express prior written permission of Hisilicon.
*
******************************************************************************
File Name	    : jpeg_drv_setpara.h
Version		    : Initial Draft
Author		    : 
Created		    : 2015/01/25
Description	    :
Function List 	: 

			  		  
History       	:
Date				Author        		Modification
2015/01/25		    y00181162  		    Created file      	
******************************************************************************/

#ifndef __JPEG_DRV_SETPARA_H__
#define __JPEG_DRV_SETPARA_H__


/*********************************add include here******************************/
#include "hi_type.h"
#include "hi_jpeg_drv_api.h"
#include "hi_jpeg_config.h"

#ifdef CONFIG_JPEG_OMX_FUNCTION

/*****************************************************************************/


#ifdef __cplusplus
#if __cplusplus
   extern "C" 
{
#endif
#endif /* __cplusplus */


     /***************************** Macro Definition ******************************/
	 /** \addtogroup	  JPEG */
	 /** @{ */	/** <!--[JPEG]*/


     /** @} */  /** <!-- ==== Macro Definition end ==== */

	 /*************************** Enum Definition ****************************/
    /****************************************************************************/
	/*							   jpeg enum    					            */
	/****************************************************************************/
	
	/** \addtogroup	  JPEG */
	/** @{ */	/** <!--[JPEG]*/

    /** @} */  /** <!-- ==== enum Definition end ==== */
	
	/*************************** Structure Definition ****************************/
    /****************************************************************************/
	/*							   jpeg api structure    					    */
	/****************************************************************************/
	
	/** \addtogroup	  JPEG */
	/** @{ */	/** <!--[JPEG]*/

	
	/** @} */  /** <!-- ==== Structure Definition End ==== */
	
    /********************** Global Variable declaration **************************/
 
    /******************************* API declaration *****************************/

	/** \addtogroup	  JPEG */
	/** @{ */	/** <!--[JPEG]*/

	/***************************************************************************
	* func			: jpg_dec_setpara
	* description	: set para that hard dec needed.
					  CNcomment: 配置硬件解码需要的参数信息 CNend\n
	* param[in] 	: pstDecInfo
	* retval		: HI_SUCCESS 成功
	* retval		: HI_FAILURE 失败
	* others:		: NA
	****************************************************************************/
    HI_S32 jpg_dec_setpara(HI_JPEG_DECINFO_S *pstDecInfo);

    /***************************************************************************
    * func          : jpeg_send_stream
    * description   : send the continue stream.
                     CNcomment: 送续码流 CNend\n
    * param[in]     : u64DecHandle
    * param[in] 	: ps32Offset
    * param[in] 	: pbReachEOF
    * retval        : HI_SUCCESS 成功
    * retval        : HI_FAILURE 失败
    * others:       : NA
    ****************************************************************************/
    HI_S32 jpeg_send_stream(HI_U64 u64DecHandle,HI_S32 *ps32Offset,HI_BOOL *pbReachEOF);
    
	/** @} */  /** <!-- ==== API Declaration End ==== */

    /****************************************************************************/



#ifdef __cplusplus
    
#if __cplusplus
   
}
#endif
#endif /* __cplusplus */

#endif

#endif /* __JPEG_DRV_SETPARA_H__*/
