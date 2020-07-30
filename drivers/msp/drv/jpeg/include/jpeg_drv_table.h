/******************************************************************************
*
* Copyright (C) 2015 Hisilicon Technologies Co., Ltd.  All rights reserved. 
*
* This program is confidential and proprietary to Hisilicon  Technologies Co., Ltd. (Hisilicon), 
* and may not be copied, reproduced, modified, disclosed to others, published or used, in
* whole or in part, without the express prior written permission of Hisilicon.
*
******************************************************************************
File Name	    : jpeg_drv_table.h
Version		    : Initial Draft
Author		    : 
Created		    : 2015/01/25
Description	    :
Function List 	: 

			  		  
History       	:
Date				Author        		Modification
2015/01/25		    y00181162  		    Created file      	
******************************************************************************/

#ifndef __JPEG_DRV_TABLE_H__
#define __JPEG_DRV_TABLE_H__


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
    /** \addtogroup 	 JPEG TABLE MACRO */
    /** @{ */  /** <!-- 【JPEG TABLE MACRO】 */


	 /** @} */	/*! <!-- Macro Definition end */


	 /*************************** Enum Definition ****************************/

	/** \addtogroup      JPEG TABLE ENUM */
    /** @{ */  /** <!-- 【JPEG TABLE ENUM】 */


	
    /** @} */  /*! <!-- enum Definition end */

	/*************************** Structure Definition ****************************/

	/** \addtogroup      JPEG TABLE STRUCTURE */
    /** @{ */  /** <!-- 【JPEG TABLE STRUCTURE】 */

	/** @} */  /*! <!-- Structure Definition end */

	
    /********************** Global Variable declaration **************************/
 
    /******************************* API declaration *****************************/

	/** \addtogroup      JPEG TABLE API */
    /** @{ */  /** <!-- 【JPEG TABLE API】 */
	

	/*****************************************************************************
	* func			: jpeg_set_dqt
	* description	: set the dqt
	                  CNcomment:  设置量化表信息          CNend\n
	* param[in] 	:
	* retval		: NA
	* others:		: NA
	*****************************************************************************/
	HI_VOID	jpeg_set_dqt(HI_DRV_JPEG_OUTMSG_S *pstOutMsg);
	
	/*****************************************************************************
	* func			: jpeg_set_dht
	* description	: set the dht
	                  CNcomment:  设置哈夫曼表信息      CNend\n
	* param[in] 	:
	* retval		: NA
	* others:		: NA
	*****************************************************************************/
	HI_S32 jpeg_set_dht(HI_DRV_JPEG_OUTMSG_S *pstOutMsg);

	/** @} */  /*! <!-- API declaration end */
	
    /****************************************************************************/



#ifdef __cplusplus
    
#if __cplusplus
   
}
#endif
#endif /* __cplusplus */

#endif

#endif /* __JPEG_DRV_TABLE_H__*/
