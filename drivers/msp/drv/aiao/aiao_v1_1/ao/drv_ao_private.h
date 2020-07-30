/***********************************************************************************
*              Copyright 2004 - 2014, Hisilicon Tech. Co., Ltd.
*                           ALL RIGHTS RESERVED
* FileName:
* Description: driver ao common header
*
* History:
* Version   Date         Author         DefectNum    Description
* main\1       AudioGroup     NULL         Create this file.
***********************************************************************************/
#ifndef __DRV_AO_PRIVATE_H__
#define __DRV_AO_PRIVATE_H__

#include "hi_type.h"
#include "hi_module.h"
#include "hi_drv_dev.h"
#include "hi_drv_mmz.h"
#include "hi_drv_mem.h"
#include "hi_drv_proc.h"
#include "drv_hdmi_ext.h"
#include "drv_adsp_ext.h"
#include "drv_ao_ext.h"
#include "drv_gpio_ext.h"
#include "drv_ao_ioctl.h"//HI_ALSA_I2S_ONLY_SUPPORT
#include "drv_pdm_ext.h"
#include "hal_aoe_common.h"

#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif
#endif /* __cplusplus */
#define AO_MAX_TOTAL_SND_NUM (HI_UNF_SND_BUTT)

#define AO_SND_FILE_NOUSE_FLAG  0xFFFFFFFF

#define AO_SOUND_PATH_NAME_MAXLEN 256    //for proc write
#define AO_SOUND_FILE_NAME_MAXLEN 256
#ifdef ENA_AO_IRQ_PROC
#define AO_IRQ_NUM (38 + 32)           /*interrupt adetor*/
#endif
#define AO_NAME "HI_AO"

#define SND_MAX_OPEN_NUM 32

#ifdef HI_SND_MUTECTL_SUPPORT  
#define AO_SND_MUTE_RESUME_DISABLE_TIMEMS 500
#define AO_SND_MUTE_BOOT_DISABLE_TIMEMS   400
#endif 

#define AO_STRING_SKIP_BLANK(str)   \
    while (str[0] == ' ')           \
    {                               \
        (str)++;                    \
    }

#define AO_STRING_SKIP_NON_BLANK(str)       \
    while (str[0] != ' ' && str[0] != '\0') \
    {                               \
        (str)++;                    \
    }

#if (1 == HI_PROC_SUPPORT)
#if 0
#define AO_DEBUG_SHOW_HELP(u32Snd) \
    do                                                         \
    {                                                          \
        HI_DRV_PROC_EchoHelper("\nfunction: save pcm data from track\n"); \
        HI_DRV_PROC_EchoHelper("commad:   echo save_track track_id start|stop > /proc/msp/sound%d\n", u32Snd); \
        HI_DRV_PROC_EchoHelper("example:  echo save_track 0 start > /proc/msp/sound%d\n", u32Snd); \
        HI_DRV_PROC_EchoHelper("\nfunction: save pcm data from sound\n"); \
        HI_DRV_PROC_EchoHelper("commad:   echo save_sound start|stop > /proc/msp/sound%d\n", u32Snd); \
        HI_DRV_PROC_EchoHelper("example:  echo save_sound start > /proc/msp/sound%d\n\n", u32Snd); \
        HI_DRV_PROC_EchoHelper("\nfunction: save pcm data with audio effect proccess from sound\n"); \
        HI_DRV_PROC_EchoHelper("commad:   echo save_sound aef start|stop > /proc/msp/sound%d\n", u32Snd); \
        HI_DRV_PROC_EchoHelper("example:  echo save_sound aef start > /proc/msp/sound%d\n\n", u32Snd); \
    } while (0)

#define AO_DEBUG_SHOW_INHELP(u32Snd) \
    do                                                         \
    {                                                          \
        HI_DRV_PROC_EchoHelper("\necho track0 weight -40dB > /proc/msp/sound%d\n", u32Snd); \
        HI_DRV_PROC_EchoHelper("echo track0 prescale -10.500dB > /proc/msp/sound%d\n", u32Snd); \
        HI_DRV_PROC_EchoHelper("echo track0 mute on|off > /proc/msp/sound%d\n", u32Snd); \
        HI_DRV_PROC_EchoHelper("\necho DAC0 aefbypass on|off > /proc/msp/sound%d\n", u32Snd); \
        HI_DRV_PROC_EchoHelper("echo DAC0 drc attacktime|releasetime 1000ms|1000ms > /proc/msp/sound%d\n", u32Snd); \
        HI_DRV_PROC_EchoHelper("echo DAC0 drc thrhd|limit -10dB|-20dB > /proc/msp/sound%d\n", u32Snd); \
        HI_DRV_PROC_EchoHelper("echo DAC0 mute on|off > /proc/msp/sound%d\n", u32Snd); \
        HI_DRV_PROC_EchoHelper("echo DAC0 volume -40dB > /proc/msp/sound%d\n", u32Snd); \
        HI_DRV_PROC_EchoHelper("echo DAC0 precivolume -40dB > /proc/msp/sound%d\n", u32Snd); \
        HI_DRV_PROC_EchoHelper("echo DAC0 balance -40 > /proc/msp/sound%d\n", u32Snd); \
        HI_DRV_PROC_EchoHelper("\necho aef0 attach|detach > /proc/msp/sound%d\n", u32Snd); \
        HI_DRV_PROC_EchoHelper("\necho peq on|off > /proc/msp/sound%d\n", u32Snd); \
        HI_DRV_PROC_EchoHelper("echo peq band0 type|gain|Q|freq HP|-10dB|0.7|1000Hz> /proc/msp/sound%d\n", u32Snd); \
        HI_DRV_PROC_EchoHelper("echo geq on|off > /proc/msp/sound%d\n", u32Snd); \
        HI_DRV_PROC_EchoHelper("echo geq band0 gain -10dB > /proc/msp/sound%d\n", u32Snd); \
        HI_DRV_PROC_EchoHelper("echo geq freq switch > /proc/msp/sound%d\n\n", u32Snd); \
        HI_DRV_PROC_EchoHelper("echo castsimulateop I2S1 on|off > /proc/msp/sound%d\n\n", u32Snd); \
    } while (0)
#else
#define AO_DEBUG_SHOW_HELP(u32Snd) \
    do                                                         \
    {                                                          \
        HI_DRV_PROC_EchoHelper("\nfunction: save pcm data from track\n"); \
        HI_DRV_PROC_EchoHelper("commad:   echo save_track track_id start|stop > /proc/msp/sound%d\n", u32Snd); \
        HI_DRV_PROC_EchoHelper("example:  echo save_track 0 start > /proc/msp/sound%d\n", u32Snd); \
        HI_DRV_PROC_EchoHelper("function: \nfunction: save pcm data from sound\n"); \
        HI_DRV_PROC_EchoHelper("commad:   echo save_sound start|stop > /proc/msp/sound%d\n", u32Snd); \
        HI_DRV_PROC_EchoHelper("example:  echo save_sound start > /proc/msp/sound%d\n", u32Snd); \
        HI_DRV_PROC_EchoHelper("function: \nfunction: save hdmi or spdif output mode\n"); \
        HI_DRV_PROC_EchoHelper("commad:   echo hdmi=pcm|hdmi=auto|hdmi=raw|hdmi=hbr2lbr|spdif=pcm|spdif=raw > /proc/msp/sound%d\n", u32Snd); \
        HI_DRV_PROC_EchoHelper("example:  echo hdmi=hbr2lbr > /proc/msp/sound%d\n", u32Snd); \
        HI_DRV_PROC_EchoHelper("example:  echo spdif=raw > /proc/msp/sound%d\n\n", u32Snd); \
    } while (0) 
#endif
#endif

typedef enum
{
    SND_DEBUG_CMD_CTRL_START = 0,
    SND_DEBUG_CMD_CTRL_STOP,
    SND_DEBUG_CMD_CTRL_BUTT
} SND_DEBUG_CMD_CTRL_E;

typedef enum
{
    SND_DEBUG_CMD_PROC_SAVE_TRACK = 0,
    SND_DEBUG_CMD_PROC_SAVE_SOUND,
    SND_DEBUG_CMD_PROC_BUTT
} SND_DEBUG_CMD_PROC_E;

typedef enum
{
    SND_PCM_OUTPUT_CERTAIN = 0,  //attach pcm outport. for example adac i2s etc.
    SND_PCM_OUTPUT_VIR_SPDIFORHDMI,  //only attach spdif or hdmi
} SND_PCM_OUTPUT_E;

typedef enum
{
    SND_HDMI_MODE_NONE = 0,  //don't attatch hdmi
    SND_HDMI_MODE_PCM,
    SND_HDMI_MODE_LBR,
    SND_HDMI_MODE_HBR,
} SND_HDMI_MODE_E;

typedef enum
{
    SND_SPDIF_MODE_NONE = 0,  //don't attatch spdif
    SND_SPDIF_MODE_PCM,
    SND_SPDIF_MODE_LBR,
    SND_SPDIF_MODE_HBR,    //For Arc dd+
} SND_SPDIF_MODE_E;

typedef enum
{
    SND_ENGINE_TYPE_PCM = 0,
    SND_ENGINE_TYPE_SPDIF_RAW = 1,
    SND_ENGINE_TYPE_HDMI_RAW = 2,
    SND_ENGINE_TYPE_BUTT
} SND_ENGINE_TYPE_E;

typedef enum
{
    SND_AIP_TYPE_PCM = 0,        //store slave pcm2.0 or master pcm2.0 or master downmix pcm
    SND_AIP_TYPE_MC_PCM = 1,     //store multichannel pcm
    SND_AIP_TYPE_ASSOC_PCM = 2,  //store associate pcm
    SND_AIP_TYPE_SPDIF_RAW = 3,
    SND_AIP_TYPE_HDMI_RAW = 4,
    SND_AIP_TYPE_BUTT
} SND_AIP_TYPE_E;

typedef enum
{
    SND_TRACK_STATUS_STOP = 0,
    SND_TRACK_STATUS_START,
    SND_TRACK_STATUS_PAUSE,
    SND_TRACK_STATUS_BUTT,
} SND_TRACK_STATUS_E;

typedef enum
{
    SND_TRACK_ATTR_RETAIN = 0,
    SND_TRACK_ATTR_MODIFY,
    SND_TRACK_ATTR_MASTER2SLAVE,        //RECREATE
    SND_TRACK_ATTR_SLAVE2MASTER,        //RECREATE
    SND_TRACK_ATTR_BUTT,
} SND_TRACK_ATTR_SETTING_E;

typedef enum
{
    SND_OP_STATUS_STOP = 0,
    SND_OP_STATUS_START,
    SND_OP_STATUS_CAST_BUTT,
} SND_OP_STATUS_E;

/*track aoe engine state*/
typedef struct
{
    AOE_ENGINE_CHN_ATTR_S stUserEngineAttr;

    /* internal state */
    AOE_ENGINE_ID_E   enEngine;
    SND_ENGINE_TYPE_E enEngineType;
} SND_ENGINE_STATE_S;

#if 1//def HI_ALSA_I2S_ONLY_SUPPORT
typedef struct
{
    HI_U32  u32BufPhyAddr;
    HI_U8*  pu8BufVirAddr;
    HI_U32  u32BufSize;
    HI_U32  u32PeriodByteSize;
    HI_U32  u32Periods;
} AO_ALSA_BUF_ATTR_S;

typedef struct hiAO_ALSA_Param_S //HI_ALSA_I2S_ONLY_SUPPORT
{
    HI_BOOL                  bAlsaI2sUse; //if HI_ALSA_I2S_ONLY_SUPPORT //0730
    HI_UNF_SAMPLE_RATE_E     enRate;
    AO_ALSA_BUF_ATTR_S       stBuf; //for  alsa  mmap dma buffer
    HI_VOID*                 IsrFunc;    //for alsa ISR func
    HI_VOID*                 pSubstream;  //for alsa ISR func params
} AO_ALSA_I2S_Param_S;
#endif

typedef struct
{
    AO_ALSA_I2S_Param_S     stUserOpenParamI2s;//for i2s only card resume  HI_ALSA_I2S_ONLY_SUPPORT
    DRV_SND_ATTR_S       stUserOpenParam;
    HI_UNF_SAMPLE_RATE_E    enUserSampleRate;
    HI_UNF_SND_HDMI_MODE_E  enUserHdmiMode;
    HI_UNF_SND_SPDIF_MODE_E enUserSpdifMode;
#if 0
    HI_UNF_SND_TRACK_INFO_S stTrackInfo;
    HI_UNF_SND_GEQ_ATTR_S   stGeqAttr;
    HI_UNF_SND_AVC_ATTR_S   stAvcAttr;
    HI_BOOL                 bGeqEnable;
    HI_BOOL                 bAvcEnable;

    HI_BOOL                     bUserArcEnable;
    HI_UNF_SND_ARC_AUDIO_MODE_E enUserArcMode;
    HI_UNF_SND_ARC_AUDIO_CAP_S  stUserArcCap;
#endif
    /* internal state */
    SND_PCM_OUTPUT_E        enPcmOutput;          /*0(pcm output surely), 1(whether pcm output according spdif or hdmi)*/    
#if 0
    HI_BOOL                 enPcmAssocStart;
    HI_BOOL                 enPcmMcStart;
#endif
    SND_HDMI_MODE_E         enHdmiPassthrough;   /*0(no hdmi),  1(pcm), 2(lbr), 3(hbr/7.1 lpcm)*/
    SND_SPDIF_MODE_E        enSpdifPassthrough;  /*0(no spdif),  1(pcm), 2(lbr)*/
    HI_U32                  u32HdmiDataFormat;
    HI_U32                  u32SpdifDataFormat;
    HDMI_EXPORT_FUNC_S      *pstHdmiFunc;
    //AMP_EXPORT_FUNC_S      *pstAmpFunc;

#ifdef HI_SND_MUTECTL_SUPPORT
    GPIO_EXT_FUNC_S*        pstGpioFunc;
    struct timer_list       stMuteDisableTimer;
#endif

    HI_U32                  uSndTrackInitFlag;
    HI_VOID*                pSndOp[HI_UNF_SND_OUTPUTPORT_MAX];
    HI_VOID*                pSndTrack[AO_MAX_TOTAL_TRACK_NUM];
    HI_BOOL                 bAllTrackMute;  //exclude alsa track
    HI_VOID*                pSndEngine[SND_ENGINE_TYPE_BUTT];
    MMZ_BUFFER_S            stTrackRbfMmz[SND_AIP_TYPE_BUTT];

#ifdef HI_SND_AFLT_SUPPORT
    HI_U32                  u32AttAef;         //attached aef (bit)
    HI_U32                  u32AefFrameDelay;  //Frame Delay of Aef
    HI_U32                  u32AefMcSupported; //Is support mc input (bit)
    MMZ_BUFFER_S            stAefSetting;  
    HI_VOID*                pAefProc[AOE_AEF_MAX_CHAN_NUM * 2];  
#endif

    HI_BOOL                 bHdmiDebug;
    HI_BOOL                 bSndDestoryFlag;    /*for suspent popfree, Destory snd flag,when suspent or normal */
    HI_BOOL                 bAdacEnable;
    //HI_BOOL                 bAllCastMute;
    HI_U32                  uSndCastInitFlag;
    HI_VOID*                pCast[AO_MAX_CAST_NUM];
    HI_VOID*                pCastOp[AO_MAX_CAST_NUM]; /*op cast used */
    HI_U32                  u32ExtDelayMs;

#ifdef HI_SND_USER_AEF_SUPPORT
    /*User Aef Buffer Attr*/
    MMZ_BUFFER_S            stAefInBufMmz;
    MMZ_BUFFER_S            stAefOutBufMmz;
#endif

#if (1 == HI_PROC_SUPPORT)
    /*save pcm*/
    SND_DEBUG_CMD_CTRL_E    enSaveState;
    HI_U32                  u32SaveCnt;
    struct file*            pstFileHandle;
#endif

#if 0  // TODO : castÄ£ÄâAOP
    HI_BOOL                 bCastSimulateOp;
    HI_UNF_SND_OUTPUTPORT_E enCastSimulatePort;
#endif
} SND_CARD_STATE_S;

typedef struct tagAO_REGISTER_PARAM_S
{
    DRV_PROC_READ_FN  pfnReadProc;
    DRV_PROC_WRITE_FN pfnWriteProc;
} AO_REGISTER_PARAM_S;

typedef struct
{
    HI_UNF_SND_E                enSound;
    HI_UNF_AUDIOTRACK_ATTR_S    stTrackAttr;
    HI_BOOL                     bAlsaTrack;
    AO_BUF_ATTR_S               stBufAttr;
    HI_UNF_SND_ABSGAIN_ATTR_S   stTrackAbsGain;
#if 0
    HI_UNF_SND_PRECIGAIN_ATTR_S stPrescale;
#endif
    HI_BOOL                     bMute;
    HI_BOOL                     bPriority;
    HI_BOOL                     bBypass;        //AIP Fifo Bypass
    HI_UNF_TRACK_MODE_E         enChannelMode;
    SND_TRACK_STATUS_E          enCurnStatus;
    AO_SND_SPEEDADJUST_TYPE_E   enType;
    HI_S32                      s32Speed;
#ifdef HI_AUDIO_AI_SUPPORT
    HI_BOOL                     bAttAi;
    HI_HANDLE                   hAi;
#endif
} SND_TRACK_SETTINGS_S;

#if defined(HI_SND_DRV_SUSPEND_SUPPORT)
typedef struct
{
    HI_UNF_SND_ABSGAIN_ATTR_S   stCastAbsGain;
    HI_BOOL                     bMute;
    HI_UNF_SND_E                enSound;
    HI_BOOL                     bUserEnableSetting;
    HI_VIRT_ADDR_T              tUserVirtAddr;
    HI_UNF_SND_CAST_ATTR_S      stCastAttr;
} SND_CAST_SETTINGS_S;

typedef struct
{
    HI_UNF_SND_GAIN_ATTR_S stUserGain;
#if 0
    HI_UNF_SND_PRECIGAIN_ATTR_S stUserPreciGain;
    HI_S32                 s32UserBalance;
#endif
    HI_UNF_TRACK_MODE_E    enUserTrackMode;
    HI_U32                 u32UserMute;
    HI_BOOL                bBypass;
    HI_BOOL                u32LatencyMs;        //Aop Buffer threshold
    HI_U32                 u32DelayMs;          //HI_SOUND_SPDIF_COMPENSATION_SUPPORT
    SND_OP_STATUS_E        enCurnStatus;
#if 0
    HI_BOOL                bDrcEnable;
    HI_UNF_SND_DRC_ATTR_S  stDrcAttr;
#endif
} SND_OUTPORT_ATTR_S;

typedef struct
{
    AO_ALSA_I2S_Param_S     stUserOpenParamI2s;//for i2s only card resume  HI_ALSA_I2S_ONLY_SUPPORT
    DRV_SND_ATTR_S       stUserOpenParam;
    HI_UNF_SND_HDMI_MODE_E  enUserHdmiMode;
    HI_UNF_SND_SPDIF_MODE_E enUserSpdifMode;
    SND_OUTPORT_ATTR_S      stPortAttr[HI_UNF_SND_OUTPUTPORT_MAX];
    HI_BOOL                 bAllTrackMute;
    HI_U32                  u32AttAef;
    HI_BOOL                 bAdacEnable;
#if 0
    HI_U32                  u32AefMcSupported;
    HI_U32                  u32AefFrameDelay;

    HI_BOOL                     bUserArcEnable;
    HI_UNF_SND_ARC_AUDIO_MODE_E enUserArcMode;
    HI_UNF_SND_ARC_AUDIO_CAP_S  stUserArcCap;
    HI_BOOL                 bAllCastMute;
#endif

    HI_VOID*                pAefProc[AOE_AEF_MAX_CHAN_NUM * 2];

} SND_CARD_SETTINGS_S;
#endif

#if (1 == HI_PROC_SUPPORT)
/* Echo proc save sound pcm */
typedef struct
{
    HI_UNF_SND_E enSound;
    HI_BOOL      bAefBypass;
    struct file* pstFileHandle;
    struct file* pstDevfileHandle;
} SND_PCM_SAVE_ATTR_S;
#endif

/* private dev state Save AO Resource opened */
typedef struct
{
    HI_U32      u32SndBit;
    HI_U32      u32TrackBit;
    //todo
} AO_STATE_S;

/* Cast entity */
typedef struct tagAO_Cast_ENTITY_S
{
    HI_U32       u32ReqSize;
    MMZ_BUFFER_S stRbfMmz;     /* mmz dont release at suspend */
#if defined (HI_SND_DRV_SUSPEND_SUPPORT)
    SND_CAST_SETTINGS_S stSuspendAttr;
#endif
    struct file* pstFile;          /* File handle */
    atomic_t atmUseCnt;        /* Cast use count, only support single user */
} AO_CAST_ENTITY_S;

/* Track entity */
typedef struct tagAO_CHAN_ENTITY_S
{
#if defined (HI_SND_DRV_SUSPEND_SUPPORT)
    SND_TRACK_SETTINGS_S stSuspendAttr;
#endif
    struct file* pstFile;          /* File handle */
    atomic_t atmUseCnt;        /* Track use count, only support single user */
} AO_CHAN_ENTITY_S;

/* Snd entity */
typedef struct tagAO_SND_ENTITY_S
{
    SND_CARD_STATE_S*     pCard;                /* Snd structure pointer */
#if defined (HI_SND_DRV_SUSPEND_SUPPORT)
    SND_CARD_SETTINGS_S stSuspendAttr;
#endif
    struct file* pstFile[SND_MAX_OPEN_NUM];                     /* File handle */
    atomic_t atmUseTotalCnt;     /* Snd use count, support multi user */
} AO_SND_ENTITY_S;

/* Global parameter */
typedef struct
{
    HI_U32           u32CastNum;        /* Record AO Cast num */
    AO_CAST_ENTITY_S astCastEntity[AO_MAX_CAST_NUM];
    HI_U32           u32TrackNum;        /* Record AO track num */
    HI_BOOL          bLowLatencyCreated;
    AO_CHAN_ENTITY_S astTrackEntity[AO_MAX_TOTAL_TRACK_NUM];   /* Track parameter */

    HI_U32          u32SndNum;           /* Record AO snd num */
    AO_SND_ENTITY_S astSndEntity[AO_MAX_TOTAL_SND_NUM];   /* Snd parameter */

    atomic_t               atmOpenCnt;      /* Open times */
    HI_BOOL                bReady;          /* Init flag */

#if (1 == HI_PROC_SUPPORT)
    AO_REGISTER_PARAM_S*   pstProcParam;    /* AO Proc functions */
#endif

    ADSP_EXPORT_FUNC_S*    pAdspFunc;       /* AO need ADSP extenal functions */
    PDM_EXPORT_FUNC_S*     pstPDMFunc;      /* AO need PDM extenal functions */

    AIAO_EXPORT_FUNC_S     stExtFunc;       /* AO provide extenal functions */
} AO_GLOBAL_PARAM_S;

typedef struct hiDRV_AO_STATE_S
{
    atomic_t atmUserOpenCnt[AO_MAX_TOTAL_SND_NUM];      /*user snd Open times */
    HI_S32  u32FileId[AO_MAX_TOTAL_SND_NUM];
} DRV_AO_STATE_S;

HI_S32  AO_DRV_Init(HI_VOID);
HI_VOID AO_DRV_Exit(HI_VOID);
long    AO_DRV_Ioctl(struct file* file, HI_U32 cmd, unsigned long arg);
HI_S32  AO_DRV_Open(struct inode* inode, struct file*  filp);
HI_S32  AO_DRV_Release(struct inode* inode, struct file*  filp);

#if (1 == HI_PROC_SUPPORT)
HI_S32  AO_DRV_RegisterProc(AO_REGISTER_PARAM_S* pstParam);
HI_VOID AO_DRV_UnregisterProc(HI_VOID);
#endif

HI_S32  AO_DRV_Suspend(PM_BASEDEV_S* pdev, pm_message_t state);
HI_S32  AO_DRV_Resume(PM_BASEDEV_S* pdev);

#if (1 == HI_PROC_SUPPORT)
HI_S32  AO_DRV_WriteProc(struct file* file,
                         const char __user* buf, size_t count, loff_t* ppos);

HI_S32  AO_DRV_ReadProc(struct seq_file* p, HI_VOID* v);
#endif

#ifdef __cplusplus
#if __cplusplus
}
#endif
#endif /* __cplusplus */

#endif
