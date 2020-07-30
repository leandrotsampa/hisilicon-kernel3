/******************************************************************************
  Copyright (C), 2001-2015, Hisilicon Tech. Co., Ltd.
 ******************************************************************************
  File Name     : drv_win_hdr.h
  Version       : Initial Draft
  Author        : Hisilicon multimedia software group
  Created       : 2015-09-23
  Description   :structures define and functions declaration for processing 
                 Dolby HDR in window.
  History       :
  1.Date        : 2015-09-23
    Author      : q00293180
    Modification: Created file
*******************************************************************************/

#ifndef __DRV_WIN_HDR_H__
#define __DRV_WIN_HDR_H__

#include "hi_type.h"
#include "hi_drv_win.h"
#include "hi_drv_video.h"
#include "drv_win_buffer.h"

#ifdef __cplusplus
#if __cplusplus
extern "C"{
#endif
#endif

#ifdef VDP_DOLBY_HDR_SUPPORT
HI_S32 WinQueueDolbyFrame(HI_HANDLE                hWin, 
                          HI_DRV_VIDEO_FRAME_S    *pBLFrmInfo, 
                          HI_DRV_VIDEO_FRAME_S    *pELFrmInfo,
                          HI_BOOL                  bELValid,
                          HI_DRV_DOLBY_META_INFO_S *pstDolbyMdInfo);


HI_S32 WIN_SetMode(HI_HANDLE hWin, HI_DRV_WINDOW_MODE_E enWinMode);

/* default enable win's hdr function. */
HI_S32 WIN_CloseHdrPath(HI_HANDLE hWin,HI_BOOL bEnable);


//move this statement to drv_window.c,cause it will use drv_window.c static variable.
//HI_BOOL WinCheckDolbyMode(HI_VOID);

//release Dolby frame.pstFrame is indicated BL frame.
HI_S32 WinBuf_RlsDolbyFrame(WB_POOL_S *pstWinBP, HI_DRV_VIDEO_FRAME_S *pstFrame);

//put a new Dolby frame into buffer
HI_S32 WinBuf_PutNewDolbyFrame(WB_POOL_S                *pstWinBP, 
                               HI_DRV_VIDEO_FRAME_S     *pstBLFrame, 
                               HI_DRV_VIDEO_FRAME_S     *pstELFrame,
                               HI_BOOL                  bELValid,
                               HI_DRV_DOLBY_META_INFO_S *pstDolbyMdInfo);

/* put a new hdr10 frame into buffer,bHisiHdr10 indicate whether go through Hisi-self HDR path */
HI_S32 WinBuf_PutNewHdr10Frame(WB_POOL_S                *pstWinBP,
                               HI_DRV_VIDEO_FRAME_S     *pstFrame,
                               HI_BOOL                   bHisiHdr10);

//get next frame for winDoviRefInfo ,note:the node of current frame has been removed in FULL array in this interrupt.
HI_DRV_VIDEO_FRAME_S* WinBuf_GetNextCfgFrm(WB_POOL_S *pstWinBP);

/* get display output type. */
HI_S32 WIN_GetDispOutput(HI_HANDLE hWin, HI_DRV_DISP_OUT_TYPE_E *penDispType);

/* set window whether to go through Hisi-self path */
HI_S32 WIN_SetHisiPath(HI_HANDLE hWin,HI_BOOL bEnable);

HI_S32 WIN_SetDolbyLibInfo(WIN_DOLBY_LIB_INFO_S  *pstDolbyLibInfo);

HI_VOID WIN_ShowDolbyLibInfo(HI_VOID);

HI_BOOL WIN_GetDolbyLibStatus(HI_VOID);

#else

#define WinQueueDolbyFrame(a,b,c,d,e)       HI_SUCCESS
#define WIN_SetMode(a,b)                    HI_SUCCESS
#define WIN_CloseHdrPath(a,b)               HI_SUCCESS
#define WinBuf_RlsDolbyFrame(a,b)           HI_SUCCESS
#define WinBuf_GetNextCfgFrm(a)             HI_NULL
#define WIN_GetDispOutput(a,b)              HI_SUCCESS
#define WinBuf_PutNewDolbyFrame(a,b,c,d,e)  HI_SUCCESS
#define WinBuf_PutNewHdr10Frame(a,b,c)      HI_SUCCESS
#define WIN_SetHisiPath(a,b)              HI_SUCCESS
#define WIN_SetDolbyLibInfo(a)				HI_SUCCESS
#define WIN_GetDolbyLibStatus()             HI_TRUE
#define WIN_ShowDolbyLibInfo()

#endif
#ifdef __cplusplus
#if __cplusplus
}
#endif
#endif

#endif

