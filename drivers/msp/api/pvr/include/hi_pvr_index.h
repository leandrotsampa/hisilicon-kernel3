/******************************************************************************

  Copyright (C), 2001-2011, Hisilicon Tech. Co., Ltd.

 ******************************************************************************
  File Name     : hi_pvr_index.h
  Version       : Initial Draft
  Author        : Hisilicon multimedia software group
  Created       : 2008/04/24
  Description   :
  History       :
  1.Date        : 2008/04/24
    Author      : q46153
    Modification: Created file

******************************************************************************/

#ifndef __HI_PVR_INDEX_H__
#define __HI_PVR_INDEX_H__

#include <sys/ioctl.h>

#include "hi_type.h"
#include "hi_pvr_priv.h"
#include "hi_pvr_fifo.h"

#include "hi_unf_demux.h"

#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif
#endif /* End of #ifdef __cplusplus */

#define PVR_TPLAY_MIN_DISTANCE       25  /* the min interval of trickmode for sending frame, the max value, decode 40 frame per second with 1920*1080 definition */

#define PVR_TPLAY_MIN_FRAME_RATE     40  /* ms, per frame */

#define PVR_TPLAY_FRAME_SHOW_TIME    40UL  /* ms, no need to play too fast at TrickMode  */ 

#define PVR_INDEX_REC                0
#define PVR_INDEX_PLAY               1
#define PVR_IDX_CACHE_LOCK(p_mutex)       (void)pthread_mutex_lock(p_mutex)
#define PVR_IDX_CACHE_UNLOCK(p_mutex)     (void)pthread_mutex_unlock(p_mutex)

#if 0
#define PVR_INDEX_LOCK(p_mutex)        HI_INFO_PVR("==>\n");(void)pthread_mutex_lock(p_mutex);HI_INFO_PVR("==|\n")
#define PVR_INDEX_UNLOCK(p_mutex)      HI_INFO_PVR("<==\n");(void)pthread_mutex_unlock(p_mutex);HI_INFO_PVR("==|\n")
#else
#define PVR_INDEX_LOCK(p_mutex) \
do{\
    (void)pthread_mutex_lock(p_mutex);\
}while(0)

#define PVR_INDEX_UNLOCK(p_mutex) \
do{\
    (void)pthread_mutex_unlock(p_mutex);\
}while(0)
#endif

#define PVR_INDEX_ERR_INVALID    (-2)

/* frame type definition                                                    */
    /*
    001 intra-coded (I)
    010 predictive-coded (P)
    011 bidirectionally-predictive-coded (B)
    100 shall not be used
    (dc intra-coded (D) in ISO/IEC11172-2)
    */
#define PVR_INDEX_FRAME_I            0x01
#define PVR_INDEX_FRAME_P            0x02
#define PVR_INDEX_FRAME_B            0x03

/* start code type definition(data from SCD buffer) */
#define PVR_INDEX_SC_TYPE_TS         0x1      /* ts packet header */
#define PVR_INDEX_SC_TYPE_PTS        0x2      /* pes packet header */
#define PVR_INDEX_SC_TYPE_PAUSE      0x3      /* pause flag */
#define PVR_INDEX_SC_TYPE_PIC        0x4      /* the start 00 00 01 of frame data */
#define PVR_INDEX_SC_TYPE_PIC_SHORT  0x5      /* the short head 00 01 of frame data */
#define PVR_INDEX_SC_TYPE_PES_ERR    0xf      /* the header of PES syntax error */


#define PVR_INDEX_HEADER_CODE               0x5A5A5A5A
#define PVR_DFT_RESERVED_REC_SIZE           (1024*1024)
#define PVR_DFT_IDX_WRITECACHE_SIZE         (4*1024)
#define PVR_DFT_IDX_READCACHE_SIZE          (16*1024)

#define PVR_MIN_CYC_SIZE (50 * 1024 * 1024LLU)
#define PVR_MIN_CYC_TIMEMS (60 *1000)

#define PVR_MIN_CYC_DIFF (4LLU * 1024LLU * 1024LLU)

#define PVR_INDEX_PAUSE_INVALID_OFFSET      ((HI_U32)(-1))
#define PVR_INDEX_STEPBACK_INVALID_OFFSET   ((HI_U32)(-1))
#define PVR_INDEX_INVALID_PTSMS             ((HI_U32)(-1))
#define PVR_INDEX_DEFFRAME_PTSMS            (40)
#define PVR_INDEX_INVALID_SEQHEAD_OFFSET    ((HI_U64)(-1))
#define PVR_INDEX_INVALID_I_FRAME_OFFSET    (0x3fffU)
#define PVR_INDEX_PAUSE_SEQHEAD_OFFSET      ((HI_U64)(-2))
#define PVR_INDEX_SCD_WRAP_MS               (47721858)/*scd Wrap-around value in MS:0xffffffff/90*/
#define PVR_INDEX_DEFAULT_FRAME_TIMESTAMP   (40)  //default frame gop is 40ms
#define PVR_INDEX_MAX_TIMESTAMP_BASE        (20)  //the max frames we must calc the (first) time_stamp 
#define PVR_INDEX_MAX_TIMESTAMP_GOP         (70)  //the range of the timestamp gop (15~60 have been meet)
#define PVR_INDEX_MIN_TIMESTAMP_GOP         (10)  //the range of the timestamp gop (15~60 have been meet)

#define MAX_FRAME_NUM_ONCE_FETCH 256
#define MAX_GOP_NUM_ONCE_FETCH 256

#define PVR_REC_INDEX_MAGIC_WORD            0x696E6478 //ASCII code of "indx"

#ifdef HI_PVR_FIFO_DIO
#define PVR_INDEX_LEAST_COMMON_MULTIPLE     24064   // the least common multiple of 188 and 512
#else
#define PVR_INDEX_LEAST_COMMON_MULTIPLE     752     //the least common multiple of 188 and 16 
#endif

#ifdef HI_PVR_L2_CACHE_SUPPORT
 #ifdef HI_PVR_FIFO_DIO
  #define PVR_INDEX_WRITE_CACHE_NUM         3600
  #define PVR_INDEX_WRITE_FILE_LIMIT        1800
  #define PVR_INDEX_READ_CACHE_NUM          3600
 #else
  #define PVR_INDEX_WRITE_CACHE_NUM         100
  #define PVR_INDEX_WRITE_FILE_LIMIT        50
  #define PVR_INDEX_READ_CACHE_NUM          400
  #endif
#endif

/* rewind record or not */
#define PVR_INDEX_IS_REWIND(handle)         ((handle)->stCycMgr.bIsRewind)

/* record or not */
#define PVR_INDEX_IS_REC(handle)            ((handle)->stCycMgr.bIsRec)

/* play or not */
#define PVR_INDEX_IS_PLAY(handle)           ((handle)->stCycMgr.bIsPlay)

/*whether index type is audio or not */
#define PVR_INDEX_IS_TYPE_AUDIO(handle)     ((handle)->enIndexType == HI_UNF_PVR_REC_INDEX_TYPE_AUDIO)

/* the max size of ts file */
#define PVR_INDEX_MAX_FILE_SIZE(handle)     ((handle)->stCycMgr.u64MaxCycSize)



/* get frame type macro                                                      */
#define PVR_INDEX_get_frameType(pEntry) \
(((pEntry)->u16FrameTypeAndGop >> 14) & 0x3UL)

/* get offset from previous I frame macro                                   */
#define PVR_INDEX_get_preIoffset(pEntry) \
((pEntry)->u16FrameTypeAndGop & 0x3fffUL)


/* judgement of frame type                                                  */
#define PVR_INDEX_is_Iframe(pEntry) \
((((pEntry)->u16FrameTypeAndGop >> 14) & 0x3UL) == PVR_INDEX_FRAME_I)

#define PVR_INDEX_is_Bframe(pEntry) \
((((pEntry)->u16FrameTypeAndGop >> 14) & 0x3UL) == PVR_INDEX_FRAME_B)

#define PVR_INDEX_is_Pframe(pEntry) \
((((pEntry)->u16FrameTypeAndGop >> 14) & 0x3UL) == PVR_INDEX_FRAME_P)

#define PVR_INDEX_OverFlow(pEntry)\
((((pEntry)->u16UpFlowFlag) & 0x1UL) == 0x1UL)

#define PVR_INDEX_Masked(pEntry) \
((((pEntry)->u16UpFlowFlag >> 1) & 0x1UL) == 0x1UL)

#define PVR_INDEX_REC_CHN_UNUSED 0
#define PVR_INDEX_REC_CHN_USED 1

/*Enable using new demux api, acquire ts data and index at same time*/
#define PVR_ACQUIREDATAINDX


#define PVR_IS_SPEED_SEND_ALL(speed) \
    (HI_UNF_PVR_PLAY_SPEED_NORMAL == (speed) \
     || HI_UNF_PVR_PLAY_SPEED_2X_FAST_FORWARD == (speed)\
     || HI_UNF_PVR_PLAY_SPEED_4X_FAST_FORWARD == (speed)\
     || HI_UNF_PVR_PLAY_SPEED_2X_SLOW_FORWARD == (speed)\
     || HI_UNF_PVR_PLAY_SPEED_4X_SLOW_FORWARD == (speed)\
     || HI_UNF_PVR_PLAY_SPEED_8X_SLOW_FORWARD == (speed)\
     || HI_UNF_PVR_PLAY_SPEED_16X_SLOW_FORWARD == (speed)\
     || HI_UNF_PVR_PLAY_SPEED_32X_SLOW_FORWARD == (speed))

/* pvr index user list                                                      */
typedef enum hiPVR_INDEX_USER_E
{
    PVR_INDEX_USER_FREE = 0x00,                   /* no one use it */
    PVR_INDEX_USER_REC  = 0x01,                   /* used by record */
    PVR_INDEX_USER_PLAY = 0x02,                   /* used by play */
    PVR_INDEX_USER_BOTH = 0x03,                   /* used by record and play meantime */
    PVR_INDEX_USER_BUTT
} PVR_INDEX_USER_E;

typedef enum hiPVR_INDEX_REWIND_TYPE_E
{
    PVR_INDEX_REWIND_BY_SIZE = 0x00,                   /* rewind by size */
    PVR_INDEX_REWIND_BY_TIME = 0x01,                   /* rewind by time */
    PVR_INDEX_REWIND_BY_BOTH = 0x02,
    PVR_INDEX_REWIND_BUTT
} PVR_INDEX_REWIND_TYPE_E;

/* rewind record control info */
typedef struct hiPVR_CYC_MGR_S
{
    HI_BOOL bIsRewind;          /* rewind record or not */
    HI_U32  u32StartFrame;      /* the first valid frame number in index on cycle playing */
    HI_U32  u32EndFrame;        /* the last valid frame number in index on cycle playing */
    HI_U32  u32LastFrame;       /* the last number of frame cycle end */

    HI_U32  u32CycTimes;        /* the times for cycle record */
    HI_U32  u32Reserve;         /* u64 aligned */
    HI_U32  u32MaxCycTimeInMs;  /* max time length of cycle record */
    HI_U64  u64MaxCycSize;      /* max file size of cycle record */
    HI_U64  u64StartFrameOffset;
    PVR_INDEX_REWIND_TYPE_E enRewindType;  /* rewind type */
}PVR_CYC_MGR_S;

/*idx cache buffer*/
typedef struct
{
    HI_U8* pu8Addr;                              /*buffer addr*/

    /* used for normal*/
    HI_U32 u32BufferLen;                         /*buffer length*/
    HI_U32 u32UsedSize;                          /*used size of buffer*/
    HI_U32 u32StartOffset;                       /*start offset*/

    /* used for l2-cache*/
    HI_U32 u32StartNum;
    HI_U32 u32UsedNum;
    HI_U32 u32Write;
    HI_U32 u32Read;
    HI_U32 u32RewindCacheWrite;
    HI_BOOL bDirty;

    pthread_mutex_t stCacheMutex;                /*cache lock*/
} HIPVR_IDX_BUF_S;

/* the gop info struction of index */
typedef struct hiPVR_INDEX_INFO
{
    HI_U32          u32GopTotalNum;     
    HI_U32          u32FrameTotalNum;  
    HI_U32          u32MaxGopSize;          /* the max size of GOP in history */
    HI_U32          u32GopSizeInfo[13];    /* gopnum of gopsize in 0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120 */
} PVR_INDEX_INFO_S;

typedef struct hiPVR_REC_PTS_INFO_S
{
    HI_U32                      u32FrameNum;
    HI_U32                      u32PtsMs;
}PVR_REC_PTS_INFO_S;

typedef struct hiPVR_REC_TIMESTAMP_S
{
    HI_U32                      u32FrameNum;
    HI_U32                      u32DeltaTimeStamp;
    HI_U32                      u32CurFrameTimeMs;
    HI_BOOL                     bNeedAdjustByPts;
    HI_BOOL                     bShouldUpdateTimeStamp;
    PVR_REC_PTS_INFO_S          stLastIFrmPtsInfo;
    PVR_REC_PTS_INFO_S          stCurIFrmPtsInfo;
}PVR_REC_TIMESTAMP_S;

typedef struct hiPVR_REC_INDEX_INFO
{
    HI_U32 u32MagicWord;
    HI_U32 u32LastGopSize;
    HI_U32 u32Reserved[14];
    PVR_INDEX_INFO_S stIdxInfo;
}PVR_REC_INDEX_INFO_S;

/* pvr index handle descriptor                                              */
typedef struct hiPVR_INDEXER_S
{
    HI_BOOL              bIsRec;                 /* record or not */
    HI_BOOL              bIsPlay;                /* play or not */

    PVR_FILE             s32ReadFd;              /* read descriptor for index file */
    PVR_FILE             s32SeekFd;              /* seek descriptor for index file */
    PVR_FILE             s32WriteFd;             /* write descriptor for index file */
    PVR_FILE             s32HeaderFd;            /* write index header for index file */

    HI_UNF_PVR_REC_INDEX_TYPE_E enIndexType;     /* the type of index, in common about record and play. assigned init index */
    PVR_CYC_MGR_S               stCycMgr;        /* control rewind record, and save the frame position, regardless of rewind record */

    HI_U64               u64GlobalOffset;        /* last write frame offset, the total data size from start record to current play or record, included the rewind data */
    HI_U64               u64FileSizeGlobal;      /* the total file saved size, for debug only  */
    HI_U64               u64OverflowOffset;      /* the global offset when overflow happen */
    
    HI_U32               u32IdxStartOffsetLen;   /* the length of file header, included header info and user info. in common between record and play*/

    HI_U32               u32DavBufSize;          /* demux dav buffer size, on recording, save the size of dav buffer */

    HI_U32               u32PauseFrame;          /* mark a pause flag for recording file, included pause the record file on live and pause the playing timeshif */
    HI_U64               u64PauseOffset;         /* the offset from the record start to pause flag. used for checking the pause position rewriten or not by rewind record. */

    HI_U16               u16RecLastIframe;       /* on recording, save the previous I frame position */
    HI_U32               u32RecLastValidPtsMs;   /* on recording, save the previous valid PTS */
    HI_U32               u32RecPicParser;        /* on recording, FIDX ID */
    HI_U32               u32RecFirstFrmTimeMs;   /* on recording, save the system time at the first frame incoming */

    HI_U32               u32WriteFrame;          /* the write pointer, frame number of index file on recording */
    HI_U32               u32ReadFrame;           /* the read porinter, frame number of index file on playing */
    PVR_INDEX_ENTRY_S    stCurRecFrame;          /* the current frame info of recording */
    PVR_INDEX_ENTRY_S    stCurPlayFrame;         /* the current frame info of outputing */
    PVR_INDEX_ENTRY_S    stStartFrame;           /* the start frame info */
    PVR_INDEX_ENTRY_S    stLastFrame;            /* the last frame info */
    PVR_INDEX_ENTRY_S    stEndFrame;             /* the end frame info */
    HI_BOOL              bRecReachPlay;          /* record catchs up the play or not, catched and reset it */
    HI_BOOL              bRecReachFix;

    HI_U32               u32DmxClkTimeMs;
    HI_U32               u32FRollTime;

    HI_UNF_PVR_FILE_ATTR_S    stIndexFileAttr;   /* for pure play, the file attribute of the exist index file, and just only assigned on creating play channel */

    HI_CHAR              szIdxFileName[PVR_MAX_FILENAME_LEN];
    pthread_mutex_t      stMutex;
    HIPVR_IDX_BUF_S      stIdxWriteCache;
    HIPVR_IDX_BUF_S      stIdxReadCache;
    
    HI_U32               u32LastDispTime;                      /* the latest recording disptime */
    HI_U32               u32DeltaDispTimeMs;                   /* the delta value of disptime after the signal lose */
    HI_U32               u32TimeShiftTillEndTimeMs;            /* the recording disptime when timeshift till end */
    HI_U32               u32TimeShiftTillEndCnt;               /* the counter of timeshift till end */
    PVR_REC_INDEX_INFO_S stRecIdxInfo;
    HI_BOOL              bRewindFlagForIndex;
    HI_BOOL              bTimeRewinding;
    HI_BOOL              bTimeRewindFlagForFile;
    HI_U64               u64TimeRewindMaxSize;
    HI_U64               u64DeltaGlobalOffset;
    PVR_REC_TIMESTAMP_S  stTimeStamp;                         /* the struct only for IP record*/
#ifdef HI_PVR_L2_CACHE_SUPPORT
    PVR_CYC_HEADER_INFO_S stFileCycInfo;
#endif
}PVR_INDEX_S, *PVR_INDEX_HANDLE;

typedef struct
{
    HI_U32  u32FrameNum;  
    HI_U32  u32PTS;
    HI_U32  u32FrameSize;
    HI_U32  u32FrameType;
    PVR_INDEX_ENTRY_S stIndexEntry;
} HI_PVR_FETCH_FRAME_S;

typedef struct
{
    HI_U32  u32TotalFrameNum; 
    HI_U32  u32PFrameNum;
    HI_U32  u32BFrameNum;
} HI_PVR_FETCH_GOP_ATTR_S;

typedef struct
{
    HI_U32  u32TotalFrameNum;    /* total frame numbers */
    HI_U32  u32IFrameNum;        /* total I frame numbers */
    HI_U32  u32PFrameNum;        /* total P frame numbers */
    HI_U32  u32BFrameNum;        /* total B frame numbers */
    HI_U32  u32GopNum;          /* total GOP numbers */

    /* the description of every frame, contains 256 frames .
    1 2 3 4      5 6 7 8     9 10 11 12 13      14 15 16
    --gop1----|---gop2-----|-------gop3------|----gop4--->  
    1. For FF,  for num in sFrame[] should be as same as up.
    2. For FB: 
        a. Choose Frame , for num in sFrame[] should be:  14 15 16, 9 10 11 12 13, 5 6 7 8, 1 2 3 4
        b. 2xOptimize,    for num in sFrame[] should be:  14 15 16  (only one GOP each time of fetching)
    */
    HI_PVR_FETCH_FRAME_S    stFrame[MAX_FRAME_NUM_ONCE_FETCH];

    /*only FB will use sGop[] for choose frame*/
    HI_PVR_FETCH_GOP_ATTR_S stGop[MAX_GOP_NUM_ONCE_FETCH];
} HI_PVR_FETCH_RESULT_S;

typedef struct
{
    HI_U32  u32TotalFrameNum;        /* total frame numbers */
    HI_PVR_FETCH_FRAME_S  stFrame[MAX_FRAME_NUM_ONCE_FETCH];  /* the description of every frame, contains 256 frames */
} HI_PVR_SEND_RESULT_S;

/* frame tag from pvr to demux */
typedef struct hiPVR_FRAME_TAG
{
    HI_U32          u32DispEnableFlag;       
    HI_U32          u32DispDistance; 
    /*After extract frame by distance ,the number of frame remaind in this GOP not be displayed. 
    attention: understand this is a little difficult ,as it is uesd in FB ,and a GOP will be output reversely after decode.
    so  it means in reverse direction.       
    I .......................................this GOP........................I.......................the next GOP.....................I
     d           d           d           d           d           d           d           d           d    (d means frame be displayed)
    |<----------|                                                       |<--|
   FrmRemainsInThisGop                                        FrmRemainsBeforeThisGop
    */
    HI_U32          u32FrmRemainsInThisGop;
    HI_U32          u32GopNum;
} PVR_FRAME_TAG_S;

typedef struct
{
    HI_BOOL             bBK2xOptimize;
    HI_U32              u32DispDistance;   /* for -2* FastBackward Optimize, the gap of displaying frame. */
    HI_U32              u32MaxGopSize;     /* the max frame numbers can be send to demux in on GOP*/
    HI_U32              u32FrmRemainsBeforeThisGop;     /*Frame number not be displayed till now*/
    HI_U32              u32GopCnt;
    HI_U32              u32BackCount;
    HI_U32              u32BackAverageVORate;
    HI_BOOL             bNeedDropI;
    PVR_FRAME_TAG_S     stFrmTag;     /*only useful for -2* FastBackward Optimize*/
}HI_PVR_FAST_BACKWARD_S;

typedef struct
{
    HI_U32              u32StartFrame;
    HI_U32              u32EndFrame;
    HI_U32              u32LastFrame;
    HI_U32              u32ReadFrame;
}HI_PVR_SMOOTH_INDEX_INFO;

typedef struct
{
    HI_BOOL                     bPrintFlg;        /*for debug*/
    //芯片固有特性
    HI_U32                      u32DecodeAblity;    /* chipset can decoded how many frames(HD:1080p) in 1s */

    //录制码流特性
    HI_BOOL                     bRewindFlag;
    HI_BOOL                     bNoPFrame;
    HI_U32                      u32MaxDecFrmNum1S;    /* For this stream , How many Frames can be decoded in 1s ,accordint to DecodeAblity*/
    HI_U32                      u32SourceFrameRate;   
    HI_U32                      u32Width;
    HI_U32                      u32Heigth;
    HI_BOOL                     bFieldFlg;
    HI_UNF_VCODEC_TYPE_E        enVcodeType;

    //SDK 参数配置和计算
    HI_U32                      u32VoRate;       /* input frame rate of VO */
    HI_U32                      u32VoDropFrame;  /* flag of VO drop frame */
    HI_U32                      u32DispFrmBufNum; /* Frmae buffer of VPSS*/
    HI_U32                      u32VoUsedFrmBufNum; /*frame buffers be hold by VO*/
    HI_UNF_AVPLAY_CONTROL_INFO_S  stVdecCtrlInfo;

    //PVR 挑帧公共参数
    HI_BOOL                     bPVRExtract;      /*flag of Extract frame by PVR*/
    HI_U32                      u32TryFrameNum;    /*The input range of Extract frame*/
    HI_U32                      u32StartFrmNum ;   /*the start frame of this turn of Extracting frame*/
    HI_U32                      u32EndFrmNum ;     /*the end frame of this turn of Extracting frame*/
    HI_U32                      u32EntryFrameNum;
    HI_U32                      u32LastPFrameNum;
    HI_U32                      u32LastIFrameNum;

    //快退控制相关参数   
    HI_PVR_FAST_BACKWARD_S      stBKInfo;
    HI_PVR_SEND_RESULT_S        *pstSendFrame; 
    HI_PVR_FETCH_RESULT_S       *pstPvrFetchRes;
        
    //快进控制相关参数，包括时间控制相关参数
    HI_HANDLE                   hAvplay;                 /* avplay handle */
    HI_VOID*                    pChnAttr;
    PVR_INDEX_HANDLE*           pIndexHandle;
    HI_UNF_PVR_PLAY_STATE_E     enState; 
    HI_UNF_PVR_PLAY_SPEED_E     enSpeed;
    HI_U32                      u32GopNumOfStart;
    HI_S32                      s32FFFBStatus;             /*the status of smooth*/
    HI_U32                      u32ExtractLeftFrm;         /*CNcomment:快进快退挑帧帧数不一定为倍速整数倍，
                                                                       遗留帧累计会导致时间不准确，
                                                                       需要处理遗留帧情况*/
        
    HI_UNF_PVR_PLAY_SPEED_E     enFBTimeCtrlLastSpeed;
    HI_U32                      u32StartCtrlTimeInMs;   
    HI_U32                      u32LastCtrlTimeInMs;
    HI_U32                      u32StartCtrlPtsInMs;
    HI_PVR_SMOOTH_INDEX_INFO    stLastSmoothIndexInfo;
    HI_PVR_SMOOTH_INDEX_INFO    stCurSmoothIndexInfo;
}HI_PVR_SMOOTH_PARA_S;


/* init index module, and create index handle, and destroy   */
HI_S32 PVR_Index_Init(HI_VOID);
PVR_INDEX_HANDLE PVR_Index_CreatPlay(HI_U32 chnID,
                                const HI_UNF_PVR_PLAY_ATTR_S *pstPlayAttr,
                                HI_BOOL *pIsNoIdx);
PVR_INDEX_HANDLE PVR_Index_CreatRec(HI_U32 chnID,
                                HI_UNF_PVR_REC_ATTR_S *pstRecAttr);

HI_S32 PVR_Index_Destroy(PVR_INDEX_HANDLE handle, HI_U32 u32PlayOrRec);

/* attr opration */
HI_VOID PVR_Index_ResetRecAttr(PVR_INDEX_HANDLE handle);
HI_VOID PVR_Index_ResetPlayAttr(PVR_INDEX_HANDLE handle);
HI_S32 PVR_Index_ChangePlayMode(PVR_INDEX_HANDLE handle);

/***** save frame *****/
HI_S32 PVR_Index_SaveFramePosition(PVR_INDEX_HANDLE handle, HI_UNF_DMX_REC_INDEX_S *pstScInfo,HI_U32 u32DirectFlag);
HI_S32 PVR_Index_FlushIdxWriteCache(PVR_INDEX_HANDLE    handle);
HI_S32 PVR_Index_IfOffsetInWriteCache(PVR_INDEX_HANDLE    handle,HI_U32 u32Offset,HI_U32 u32Size);

/* get frame opration    */
HI_S32 PVR_Index_GetNextFrame(PVR_INDEX_HANDLE handle, PVR_INDEX_ENTRY_S *pstFrame);
HI_S32 PVR_Index_GetPreFrame(PVR_INDEX_HANDLE handle, PVR_INDEX_ENTRY_S *pFrame);
HI_S32 PVR_Index_GetCurrentFrame(const PVR_INDEX_HANDLE handle,  PVR_INDEX_ENTRY_S *pEntry);
HI_S32 PVR_Index_QueryFrameByTime(const PVR_INDEX_HANDLE handle, HI_U32 u32SearchTime, PVR_INDEX_ENTRY_S *pEntry, HI_U32 *pu32Pos);
HI_S32 PVR_Index_GetFrameByNum(const PVR_INDEX_HANDLE handle,  PVR_INDEX_ENTRY_S *pEntry, HI_U32 num);


/* seek opration */
HI_S32 PVR_Index_SeekToTime(PVR_INDEX_HANDLE handle, HI_U32 u32TimeMs);
HI_S32 PVR_Index_SeekToStart(PVR_INDEX_HANDLE handle);
HI_S32 PVR_Index_SeekToEnd(PVR_INDEX_HANDLE handle);
HI_S32 PVR_Index_SeekToPauseOrStart(PVR_INDEX_HANDLE handle);
HI_S32 PVR_Index_SeekByTime(PVR_INDEX_HANDLE handle, HI_S64 offset, HI_S32 whence, HI_U32 curplaytime);
HI_S32 PVR_Index_SeekByFrame2I(PVR_INDEX_HANDLE handle, HI_S32 offset, HI_S32 whence);


/* for timeshift pause  */
HI_S32 PVR_Index_MarkPausePos(PVR_INDEX_HANDLE handle);

/*file opration*/
HI_S32 PVR_Index_PlayGetFileAttrByFileName(const HI_CHAR *pFileName, PVR_INDEX_HANDLE pIdxHandle, HI_UNF_PVR_FILE_ATTR_S *pAttr);
HI_S32 PVR_Index_GetRecStatus(PVR_INDEX_HANDLE handle, HI_UNF_PVR_REC_STATUS_S *pstRecStatus);
HI_VOID PVR_Index_GetIdxFileName(HI_CHAR* pIdxFileName, HI_CHAR* pSrcFileName);
HI_S32 PVR_Index_PrepareHeaderInfo(PVR_INDEX_HANDLE handle, HI_U32 u32UsrDataLen, HI_U32 u32Vtype);
HI_S32 PVR_Index_GetUsrDataInfo(HI_S32 s32Fd, HI_U8* pBuff, HI_U32 u32BuffSize);
HI_S32 PVR_Index_SetUsrDataInfo(HI_S32 s32Fd, HI_U8* pBuff, HI_U32 u32UsrDataLen);
HI_S32 PVR_Index_GetCADataInfo(HI_S32 s32Fd, HI_U8* pBuff, HI_U32 u32BuffSize);
HI_S32 PVR_Index_SetCADataInfo(HI_S32 s32Fd, HI_U8* pBuff, HI_U32 u32CADataLen);
HI_VOID PVR_Index_GetIdxInfo(PVR_INDEX_HANDLE handle);
HI_VOID PVR_Index_GetRecIdxInfo(PVR_INDEX_HANDLE handle);
HI_BOOL PVR_Index_CheckSetRecReachPlay(PVR_INDEX_HANDLE handle, HI_U32 u32Distance);

HI_S32 PVR_Index_GetVtype(PVR_INDEX_HANDLE handle);
HI_S32 PVR_Index_GetMaxBitrate(PVR_INDEX_HANDLE piIndexHandle);
HI_S32 PVR_Index_GetStreamBitRate(PVR_INDEX_HANDLE piIndexHandle,HI_U32 *pBitRate,HI_U32 u32StartFrameNum,HI_U32 u32EndFrameNum);
HI_S32 PVR_Index_GetFBwardIPBFrameNum(PVR_INDEX_HANDLE handle, HI_U32 u32Direction, HI_U32 u32FrameType, HI_U32 u32CurFrameNum, HI_U32 *pu32NextFrameNum);
HI_S32 PVR_Index_GetCurGOPAttr(PVR_INDEX_HANDLE piIndexHandle, HI_PVR_FETCH_RESULT_S *pstFetchResult, HI_U32 u32StartIFrameNum);
HI_S32 PVR_Index_GetForwardGOPAttr(PVR_INDEX_HANDLE piIndexHandle, HI_PVR_FETCH_RESULT_S *pPvrFetchRes, HI_U32 u32StartFrameNum, HI_U32 u32FrameNum);
HI_S32 PVR_Index_GetBackwardGOPAttr(PVR_INDEX_HANDLE piIndexHandle, HI_PVR_FETCH_RESULT_S *pPvrFetchRes, HI_U32 u32StartFrameNum, HI_U32 u32FrameNum);
HI_S32 PVR_Index_GetFrmNumByEntry(PVR_INDEX_HANDLE pstIndexHandle, PTR_PVR_INDEX_ENTRY pstIndexEntry, HI_S32 *ps32FrmNum);
HI_S32 PVR_Index_GetFrameRate(PVR_INDEX_HANDLE piIndexHandle, HI_U32 *pFrameRate);

PVR_CYC_MGR_S* PVR_Index_GetCycMgr(PVR_INDEX_HANDLE IndexHandle);
PVR_INDEX_INFO_S* PVR_Index_GetPVRIdxInfo(PVR_INDEX_HANDLE IndexHandle);
HI_U32 PVR_Index_GetCurReadFrameNum(PVR_INDEX_HANDLE IndexHandle);
HI_S32 PVR_Index_SetCurReadFrameNum(PVR_INDEX_HANDLE IndexHandle,HI_U32 u32ReadFrame);

#ifdef HI_PVR_L2_CACHE_SUPPORT
HI_S32 PVR_Index_SaveToCache(PVR_INDEX_HANDLE hIndex, const HI_UNF_DMX_REC_INDEX_S *pstDmxIndexInfo);
HI_S32 PVR_Index_SaveToFile(PVR_INDEX_HANDLE hIndex, HI_BOOL bDirecWrite);
HI_S32 PVR_Index_FlushToFile(PVR_INDEX_HANDLE hIndex);
#endif

HI_S32 PVR_Index_CycMoveFrmNum(PVR_INDEX_HANDLE handle, HI_BOOL bForward,HI_S32 s32CurFrmNum,HI_U32 Distance, HI_S32 *ps32NextFrameNum);
HI_VOID PVR_Index_ProcOverFlow(PVR_INDEX_HANDLE handle);
HI_S32 PVR_Index_GetPreIFrame(PVR_INDEX_HANDLE handle, HI_U32 u32CurFrameNum, HI_U32 *PreIFrameNum,PVR_INDEX_ENTRY_S *PreIFrame);
HI_S32 PVR_Index_GetNextIFrame(PVR_INDEX_HANDLE handle, HI_U32 u32CurFrameNum, HI_U32 *pNextIFrameNum,PVR_INDEX_ENTRY_S* pNextIFrame);

HI_BOOL PVR_Index_CheckIndexFrmValid(HI_U32 u32IndexFrm, PVR_CYC_MGR_S *pstIndexCycMgr);
HI_U32 PVR_Index_CalcFrameDistance(HI_U32 u32Dst, HI_U32 u32Src, HI_U32 u32Direction,PVR_CYC_MGR_S *pstCycMgr);
HI_U32 PVR_Index_GetNextFrameNum(HI_U32 u32FrmNum, PVR_CYC_MGR_S *pstCycMgr);
HI_U32 PVR_Index_GetPrevFrameNum(HI_U32 u32FrmNum, PVR_CYC_MGR_S *pstCycMgr);
HI_VOID PVR_Index_CycMoveReadFrm(PVR_INDEX_HANDLE handle, HI_S32 s32Offset);
HI_S32 PVR_Index_PushStartWhenTsLead(PVR_INDEX_HANDLE handle, HI_U64 u64CurFileSize);

#ifdef __cplusplus
#if __cplusplus
}
#endif
#endif /* End of #ifdef __cplusplus */

#endif /* End of #ifdef __HI_PVR_INDEX_H__ */

