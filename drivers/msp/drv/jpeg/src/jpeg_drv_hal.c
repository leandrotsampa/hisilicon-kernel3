/******************************************************************************
*
* Copyright (C) 2015 Hisilicon Technologies Co., Ltd.  All rights reserved. 
*
* This program is confidential and proprietary to Hisilicon  Technologies Co., Ltd. (Hisilicon), 
* and may not be copied, reproduced, modified, disclosed to others, published or used, in
* whole or in part, without the express prior written permission of Hisilicon.
*
******************************************************************************
File Name	    : jpeg_drv_hal.c
Version		    : Initial Draft
Author		    : 
Created		    : 2015/03/01
Description	    : 操作寄存器
Function List 	: 

			  		  
History       	:
Date				Author        		Modification
2015/03/01		    y00181162  		    Created file      	
******************************************************************************/



/*********************************add include here******************************/
#include "hi_jpeg_config.h"
#include "jpeg_drv_hal.h"
#include "hi_jpeg_reg.h"

/***************************** Macro Definition ******************************/


/*************************** Structure Definition ****************************/



/********************** Global Variable declaration **************************/

static volatile HI_U32 *s_pu32JpgRegAddr = 0;

/******************************* API forward declarations *******************/

/******************************* API realization *****************************/

/*****************************************************************************
* func            : jpeg_reg_read
* description     : read register value
* param[in]       : offset
* retval          : none
*****************************************************************************/
HI_U32 jpeg_reg_read(HI_U32 offset)
{
	return (*(volatile HI_U32 *)((s_pu32JpgRegAddr) + (offset) / 4));
}

/*****************************************************************************
* func			  : jpeg_reg_write
* description	  : write register value
* param[in] 	  : offset
* param[in] 	  : value
* retval		  : none
*****************************************************************************/
HI_VOID  jpeg_reg_write(HI_U32 offset, HI_U32 value)
{/** 指针地址，u32类型，+1等于偏移4个字节 **/
	(*(volatile HI_U32 *)((s_pu32JpgRegAddr) + (offset) / 4) = (value));
}


/*****************************************************************************
* func			  : jpeg_reg_write
* description	  : write register value
* param[in] 	  : offset
* param[in] 	  : value
* retval		  : none
*****************************************************************************/
HI_VOID jpeg_reg_writebuf(const HI_VOID *pInMem,HI_S32 s32PhyOff,HI_U32 u32Bytes)
{
	HI_U32 u32Cnt = 0;
	for(u32Cnt = 0; u32Cnt < u32Bytes; u32Cnt += 4)
	{
		*(volatile int *)((s_pu32JpgRegAddr) + (s32PhyOff + u32Cnt) / 4) = *(int *)((char*)pInMem + u32Cnt); 
	}
}

/*****************************************************************************
* func            : JpgHalInit
* description     : initial the jpeg device
* param[in]       : none
* retval          : none
* output          : none
* others:	      : nothing
*****************************************************************************/
HI_VOID JpgHalInit(volatile HI_U32 *pu32JpegRegBase)
{
	  s_pu32JpgRegAddr = pu32JpegRegBase;
}

 /*****************************************************************************
* func            : JpgHalExit
* description     : exit initial the jpeg device
* param[in]       : none
* retval          : none
* output          : none
* others:	      : nothing
*****************************************************************************/
HI_VOID JpgHalExit(HI_VOID)
{
    s_pu32JpgRegAddr = 0;
}

/*****************************************************************************
* func            : JpgHalGetIntStatus
* description     : get halt status
* param[in]       : none
* retval          : none
* output          : pIntStatus  the value of halt state
* others:	      : nothing
*****************************************************************************/
HI_VOID JpgHalGetIntStatus(HI_U32 *pIntStatus)
{
    /**
     ** read the halt register and write it to *pIntStatus
     **/
    *pIntStatus = jpeg_reg_read(JPGD_REG_INT);
}

/*****************************************************************************
* func            : JpgHalSetIntStatus
* description     : set halt status
* param[in]       : IntStatus    the halt value
* retval          : none
* output          : none
* others:	      : nothing
*****************************************************************************/
HI_VOID JpgHalSetIntStatus(HI_U32 IntStatus)
{
    /**
     ** read halt register and write it to *pIntStatus
     **/
    jpeg_reg_write(JPGD_REG_INT, IntStatus);
}

/*****************************************************************************
* func            : JpgHalSetIntMask
* description     : set halt mask
* param[in]       : IntMask     halt mask
* retval          : none
* output          : none
* others:	      : nothing
*****************************************************************************/
HI_VOID JpgHalSetIntMask(HI_U32 IntMask)
{
    /** set halt mask with IntMask **/
    jpeg_reg_write(JPGD_REG_INTMASK, IntMask);
}


/*****************************************************************************
* func            : JpgHalGetIntMask
* description     : get halt mask
* param[in]       : none
* retval          : none
* output          : pIntMask   halt mask
* others:	      : nothing
*****************************************************************************/
HI_VOID JpgHalGetIntMask(HI_U32 *pIntMask)
{
    /** get halt mask and write it to *pIntMask **/
    *pIntMask = jpeg_reg_read(JPGD_REG_INTMASK);
}
