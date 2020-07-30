/******************************************************************************
*
* Copyright (C) 2014 Hisilicon Technologies Co., Ltd.  All rights reserved. 
*
* This program is confidential and proprietary to Hisilicon  Technologies Co., Ltd. (Hisilicon), 
* and may not be copied, reproduced, modified, disclosed to others, published or used, in
* whole or in part, without the express prior written permission of Hisilicon.
*
******************************************************************************
File Name           : hifb_comm.h
Version             : Initial Draft
Author              : 
Created             : 2014/09/09
Description         : 
Function List       : 
History             :
Date                       Author                   Modification
2014/09/09                 y00181162                Created file        
******************************************************************************/

#ifndef __HIFB_COMM_H__
#define __HIFB_COMM_H__


/*********************************add include here******************************/

#include "hifb.h"
#include "hi_debug.h"
#include "hi_gfx_comm_k.h"


/*****************************************************************************/


#ifdef __cplusplus
#if __cplusplus
   extern "C"
{
#endif
#endif /* __cplusplus */



/***************************** Macro Definition ******************************/

/* define debug level */
#define HIFB_FATAL(fmt...)              HI_GFX_COMM_LOG_FATAL(HIGFX_FB_ID,fmt)
#define HIFB_ERROR(fmt...)              HI_GFX_COMM_LOG_ERROR(HIGFX_FB_ID,fmt)
#define HIFB_WARNING(fmt...)            HI_GFX_COMM_LOG_WARNING(HIGFX_FB_ID,fmt)
#define HIFB_INFO(fmt...)               HI_GFX_COMM_LOG_INFO(HIGFX_FB_ID,fmt)

#define HIFB_FILE_PATH_MAX_LEN         256
#define HIFB_FILE_NAME_MAX_LEN         32


/* unit rect */
#define HIFB_UNITE_RECT(stDstRect, stSrcRect) do\
{\
    HIFB_RECT stRect;\
    stRect.x = (stDstRect.x < stSrcRect.x)? stDstRect.x : stSrcRect.x;\
    stRect.y = (stDstRect.y < stSrcRect.y)? stDstRect.y : stSrcRect.y;\
    stRect.w = ((stDstRect.x + stDstRect.w) > (stSrcRect.x + stSrcRect.w))? \
        (stDstRect.x + stDstRect.w - stRect.x) : (stSrcRect.x + stSrcRect.w - stRect.x);\
    stRect.h = ((stDstRect.y + stDstRect.h) > (stSrcRect.y + stSrcRect.h))? \
        (stDstRect.y + stDstRect.h - stRect.y) : (stSrcRect.y + stSrcRect.h - stRect.y);\
    memcpy(&stDstRect, &stRect, sizeof(HIFB_RECT));\
}while(0)


#define HIFB_MIN(m, n) (m) > (n) ? (n) : (m)


/*************************** Structure Definition ****************************/

/********************** Global Variable declaration **************************/



/******************************* API declaration *****************************/

HI_VOID hifb_version(HI_VOID);

HI_VOID *hifb_buf_map(HI_U32 u32PhyAddr);

HI_S32 hifb_buf_ummap(HI_VOID *pViraddr);

HI_VOID hifb_buf_freemem(HI_U32 u32Phyaddr, HI_BOOL bSmmu);
HI_U32 hifb_buf_allocmem(HI_CHAR *pName, HI_CHAR* pZoneName, HI_U32 u32LayerSize);
HI_U32 hifb_buf_map2smmu(HI_U32 u32PhyBuf);
HI_S32 hifb_buf_unmapsmmu(HI_U32 u32SmmuBuf);

HI_BOOL HIFB_IsIntersectRect(const HIFB_RECT* pRect1, const HIFB_RECT* pRect2);

HI_VOID hifb_addrect(HIFB_RECT *pRectHead, HI_U32 TotalNum, HI_U32 *pValidNum, HIFB_RECT *pRect);

HI_BOOL hifb_iscontain(HIFB_RECT *pstParentRect, HIFB_RECT *pstChildRect);

HI_BOOL hifb_isoverlay(HIFB_RECT *pstSrcRect, HIFB_RECT *pstDstRect);

HI_U32 hifb_getbppbyfmt(HIFB_COLOR_FMT_E enColorFmt);

HI_S32 hifb_bitfieldcmp(struct fb_bitfield x, struct fb_bitfield y);

#ifdef __cplusplus
#if __cplusplus
}
#endif
#endif /* __cplusplus */

#endif /* __HIFB_COMM_H__ */
