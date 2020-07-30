/******************************************************************************

  Copyright (C), 2011-2015, Hisilicon Tech. Co., Ltd.

 ******************************************************************************
  File Name     :mpi_hiao_track.h
  Version       : Initial Draft
  Author        : Hisilicon multimedia software group
  Created       : 2012/12/12
  Description  : 
  History       :
  1.Date        : 2012/12/12
    Author      : h00213218
    Modification: Created file

 *******************************************************************************/

#ifndef  __MPI_HIAO_LOWLATENCY_H__
#define  __MPI_HIAO_LOWLATENCY_H__

#include "hi_mpi_ao.h"
#include "hi_drv_ao.h"

#if 0
typedef struct hiS_AIP_REGS_EXAMPLE
{
    HI_U32    reserver_0;
    HI_U32    reserver_1;
    HI_U32    reserver_2;
    HI_U32    reserver_3;
    HI_U32    reserver_4;
    HI_U32    AIP_BUF_ADDR;
    HI_U32    AIP_BUF_SIZE;
    HI_U32    AIP_BUF_WPTR;
    HI_U32    AIP_BUF_RPTR;
    HI_U32    reserver_5;
    HI_U32    reserver_6;
    HI_U32    AIP_BUF_PHY_ADDR;
    HI_U32    reserver_8;
    HI_U32    reserver_9;
    HI_U32    reserver_10;
    HI_U32    reserver_11;
    HI_U32    reserver_12;
} S_AIP_REGS_EXAMPLE;
#endif
#if 0
typedef struct
{
    volatile U_AIP_BUFF_ATTR      AIP_BUFF_ATTR;
    volatile U_AIP_FIFO_ATTR      AIP_FIFO_ATTR;
    volatile U_AIP_CTRL           AIP_CTRL;
    volatile U_AIP_SRC_ATTR_EXT   AIP_SRC_ATTR_EXT;
    volatile unsigned int         AIP_BUF_ADDR;
    volatile U_AIP_BUF_SIZE       AIP_BUF_SIZE;
    volatile unsigned int         AIP_BUF_WPTR;
    volatile unsigned int         AIP_BUF_RPTR;
    volatile U_AIP_BUF_TRANS_SIZE AIP_BUF_TRANS_SIZE;
    volatile U_AIP_EXT_CTRL       AIP_EXT_CTRL;
    volatile unsigned int         AIP_BUF_PHYADDR;
    volatile U_AIP_STATUS0        AIP_STATUS0;
    volatile unsigned int         AIP_FIFO_ADDR;
    volatile U_AIP_FIFO_SIZE      AIP_FIFO_SIZE;
    volatile unsigned int         AIP_FIFO_WPTR;
    volatile unsigned int         AIP_FIFO_RPTR;

} S_AIP_REGS_TYPE;
#endif


HI_BOOL LOWLATENCY_CheckIsLowlcyTrack(HI_HANDLE hTrack);
HI_S32 LOWLATENCY_EnableLowLatencyAttr( HI_HANDLE hTrack,HI_BOOL bEanble);
HI_S32 LOWLATENCY_SendData(HI_HANDLE hTrack,const HI_UNF_AO_FRAMEINFO_S *pstAOFrame);
HI_S32 LOWLATENCY_GetAIPDelayMs(HI_HANDLE hTrack,HI_U32 *pDelayMs);

#endif
