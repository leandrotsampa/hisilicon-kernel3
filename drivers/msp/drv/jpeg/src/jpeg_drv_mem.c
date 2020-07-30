/******************************************************************************
*
* Copyright (C) 2015 Hisilicon Technologies Co., Ltd.  All rights reserved. 
*
* This program is confidential and proprietary to Hisilicon  Technologies Co., Ltd. (Hisilicon), 
* and may not be copied, reproduced, modified, disclosed to others, published or used, in
* whole or in part, without the express prior written permission of Hisilicon.
*
******************************************************************************
File Name	    : jpeg_drv_mem.c
Version		    : Initial Draft
Author		    : 
Created		    : 2015/01/25
Description	    :
Function List 	: 

			  		  
History       	:
Date				Author        		Modification
2015/01/25		    y00181162  		    Created file      	
******************************************************************************/

#ifndef HI_BUILD_IN_BOOT
/*********************************add include here******************************/

#include "hi_jpeg_config.h"
#include "jpeg_drv_parse.h"
#include "jpeg_drv_mem.h"

#ifdef CONFIG_JPEG_OMX_FUNCTION

/***************************** Macro Definition ******************************/


/*************************** Structure Definition ****************************/


/********************** Global Variable declaration **************************/


/******************************* API forward declarations *******************/

/******************************* API realization *****************************/
/***************************************************************************************
* func			: jpeg_mem_alloc
* description	: alloc all memory
				  CNcomment: 分配所有内存 CNend\n
* param[in] 	: 
* others:		: NA
***************************************************************************************/
HI_S32 jpeg_mem_alloc(HI_U64 u64DecHandle)
{
    HI_U32 u32LayerSize = JPGD_DRV_STREAM_BUFFER;
    HI_CHAR* pDataVir   = NULL;
    HI_U32   u32DataPhy = 0;
    HI_BOOL bMemMMUType = HI_FALSE;
    IMAG_INFO_S *pstImgInfo = (IMAG_INFO_S*)(unsigned long)u64DecHandle;
	
	u32DataPhy = HI_GFX_AllocMem("JPEG_STREAM_BUF", "iommu", u32LayerSize, &bMemMMUType);
	if(0 == u32DataPhy){
        return HI_FAILURE;
    }

    pDataVir = (HI_CHAR*)HI_GFX_MapCached(u32DataPhy,u32LayerSize, bMemMMUType);
    if(NULL == pDataVir){
        HI_GFX_FreeMem((HI_U32)u32DataPhy, bMemMMUType);
        return HI_FAILURE;
    }
    pstImgInfo->u32StreamPhy = u32DataPhy;
    pstImgInfo->pStreamVir   = pDataVir;

#ifdef CONFIG_GFX_MMU_SUPPORT
	if(HI_TRUE != bMemMMUType){
		return HI_FAILURE;
	}
#endif

    return HI_SUCCESS;

}

/***************************************************************************************
* func			: jpeg_mem_destory
* description	: destory all memory
				  CNcomment: 销毁所有内存 CNend\n
* param[in] 	: 
* others:		: NA
***************************************************************************************/
HI_VOID jpeg_mem_destory(HI_U64 u64DecHandle)
{
    IMAG_INFO_S *pstImgInfo = NULL;
		
    if(0 == u64DecHandle){
        return;
    }
    pstImgInfo = (IMAG_INFO_S*)(unsigned long)u64DecHandle;
    if(NULL == pstImgInfo){
        return;
    }

    if(NULL != pstImgInfo->pStreamVir){
		HI_GFX_Unmap((HI_VOID*)pstImgInfo->pStreamVir, HI_TRUE);
        pstImgInfo->pStreamVir = NULL;
    }
    
    if(0 != pstImgInfo->u32StreamPhy){
		HI_GFX_FreeMem(pstImgInfo->u32StreamPhy, HI_TRUE);
        pstImgInfo->u32StreamPhy = 0;
    }
}
#endif/** CONFIG_JPEG_OMX_FUNCTION **/

#endif/** HI_BUILD_IN_BOOT **/
