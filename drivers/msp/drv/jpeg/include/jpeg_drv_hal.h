/******************************************************************************
*
* Copyright (C) 2015 Hisilicon Technologies Co., Ltd.  All rights reserved. 
*
* This program is confidential and proprietary to Hisilicon  Technologies Co., Ltd. (Hisilicon), 
* and may not be copied, reproduced, modified, disclosed to others, published or used, in
* whole or in part, without the express prior written permission of Hisilicon.
*
******************************************************************************
File Name	    : jpeg_drv_hal.h
Version		    : Initial Draft
Author		    : 
Created		    : 2015/03/01
Description	    : 
Function List 	: 

			  		  
History       	:
Date				Author        		Modification
2015/03/01		    y00181162  		    Created file      	
******************************************************************************/



#ifndef  _JPEG_DRV_HAL_H_
#define  _JPEG_DRV_HAL_H_


/*********************************add include here******************************/
#include "hi_type.h"

/*****************************************************************************/


/*****************************************************************************/


#ifdef __cplusplus
      #if __cplusplus
   
extern "C" 
{

      #endif
#endif /* __cplusplus */

    /***************************** Macro Definition ******************************/


    /*************************** Structure Definition ****************************/

    /***************************  The enum of Jpeg image format  ******************/

    /********************** Global Variable declaration **************************/


    /******************************* API declaration *****************************/

	
	
	/*****************************************************************************
	* func			  : JpgHalInit
	* description	  : initial the jpeg device
	* param[in] 	  : none
	* retval		  : none
	* output		  : none
	* others:		  : nothing
	*****************************************************************************/
	HI_VOID JpgHalInit(volatile HI_U32 *pu32JpegRegBase);
	
	
	 /*****************************************************************************
	* func			  : JpgHalExit
	* description	  : exit initial the jpeg device
	* param[in] 	  : none
	* retval		  : none
	* output		  : none
	* others:		  : nothing
	*****************************************************************************/
	
	HI_VOID JpgHalExit(HI_VOID);
	
	/*****************************************************************************
	* func			  : JpgHalGetIntStatus
	* description	  : get halt status
	* param[in] 	  : none
	* retval		  : none
	* output		  : pIntStatus	the value of halt state
	* others:		  : nothing
	*****************************************************************************/
	
	HI_VOID JpgHalGetIntStatus(HI_U32 *pIntStatus);
	
	
	
	/*****************************************************************************
	* func			  : JpgHalSetIntMask
	* description	  : set halt mask
	* param[in] 	  : IntMask 	halt mask
	* retval		  : none
	* output		  : none
	* others:		  : nothing
	*****************************************************************************/
	
	HI_VOID JpgHalSetIntMask(HI_U32 IntMask);
	
	
	/*****************************************************************************
	* func			  : JpgHalGetIntMask
	* description	  : get halt mask
	* param[in] 	  : none
	* retval		  : none
	* output		  : pIntMask   halt mask
	* others:		  : nothing
	*****************************************************************************/
	
	HI_VOID JpgHalGetIntMask(HI_U32 *pIntMask);
	
	 
	/*****************************************************************************
	* func			  : JpgHalSetIntStatus
	* description	  : set halt status
	* param[in] 	  : IntStatus	 the halt value
	* retval		  : none
	* output		  : none
	* others:		  : nothing
	*****************************************************************************/
	
	HI_VOID JpgHalSetIntStatus(HI_U32 IntStatus);


    #ifdef __cplusplus

        #if __cplusplus



}
      
        #endif
        
   #endif /* __cplusplus */

#endif /*_JPEG_DRV_HAL_H_ */
