/******************************************************************************
*
* Copyright (C) 2014 Hisilicon Technologies Co., Ltd.  All rights reserved. 
*
* This program is confidential and proprietary to Hisilicon  Technologies Co., Ltd. (Hisilicon), 
* and may not be copied, reproduced, modified, disclosed to others, published or used, in
* whole or in part, without the express prior written permission of Hisilicon.
*
******************************************************************************
File Name           : hifb_DMABUF.h
Version             : Initial Draft
Author              : 
Created             : 2014/09/09
Description         : 
Function List       : 
History             :
Date                       Author                   Modification
2014/09/09                 y00181162                Created file        
******************************************************************************/

#ifndef __HIFB_DMABUF_H__
#define __HIFB_DMABUF_H__


/*********************************add include here******************************/





/*****************************************************************************/


#ifdef __cplusplus
#if __cplusplus
   extern "C"
{
#endif
#endif /* __cplusplus */



/*************************** Structure Definition ****************************/

/********************** Global Variable declaration **************************/

#include <linux/dma-buf.h>


/******************************* API declaration *****************************/
struct dma_buf *hifb_memblock_export(phys_addr_t base, size_t size, int flags);

#ifdef __cplusplus

#if __cplusplus

}
#endif
#endif /* __cplusplus */

#endif /* __HIFB_DMABUF_H__ */
