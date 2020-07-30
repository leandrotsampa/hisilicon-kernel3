/***********************************************************************************
*              Copyright 2004 - 2014, Hisilicon Tech. Co., Ltd.
*                           ALL RIGHTS RESERVED
* FileName:
* Description: driver aiao common header
*
* History:
* Version   Date         Author         DefectNum    Description
* main\1       AudioGroup     NULL         Create this file.
***********************************************************************************/
#ifndef __DRV_AI_COMMON_H__
#define __DRV_AI_COMMON_H__

#include "circ_buf.h"
#include "hal_aiao_common.h"
#include <sound/pcm.h>
#include "drv_ai_ext.h"


#ifdef __cplusplus
 #if __cplusplus
extern "C" {
 #endif
#endif /* __cplusplus */

#define AI_NAME "HI_AI"

#define AI_LATENCYMS_PERFRAME_DF  (20)
#define AI_SAMPLE_PERFRAME_DF (48000/1000*AI_LATENCYMS_PERFRAME_DF)
#define AI_BUFF_FRAME_NUM_DF  (6)

#define AI_I2S0_MSK   (0)
#define AI_I2S1_MSK   (1)
#define AI_ADAC_MSK  (2)
#define AI_HDMI_MSK  (3)

#define AI_OPEN_CNT_MAX  (2)

#define AI_QUERY_BUF_CNT_MAX  (AI_LATENCYMS_PERFRAME_DF*6) //48k/8k = 6


//AI BUF ATTR
#if 0
typedef struct hiAI_BUF_ATTR_S
{
    HI_U32      u32Start;
    HI_U32      u32Read;
    HI_U32      u32Write;
    HI_U32      u32End;
    /* user space virtual address */
    HI_U32 u32UserVirBaseAddr;
    /* kernel space virtual address */
    HI_U32 u32KernelVirBaseAddr;
    //TO DO
    //MMZ Handle
    
} AI_BUF_ATTR_S;
#endif

#define AI_PATH_NAME_MAXLEN 256		//for proc
#define AI_FILE_NAME_MAXLEN 256


#define AI_STRING_SKIP_BLANK(str)       \
    while (str[0] == ' ')           \
    {                               \
        (str)++;                    \
    }  


#define AI_PROC_SHOW_HELP(u32Ai) \
    do                                                         \
    {                                                          \
        HI_DRV_PROC_EchoHelper("\nfunction: record pcm data from ai\n"); \
        HI_DRV_PROC_EchoHelper("commad:   echo save start|stop > /proc/msp/ai%d\n", u32Ai); \
        HI_DRV_PROC_EchoHelper("example:  echo save start > /proc/msp/ai%d\n", u32Ai); \
    } while (0)

#if 0
        HI_DRV_PROC_EchoHelper("\nfunction: ai dre switch\n"); \
        HI_DRV_PROC_EchoHelper("commad:   echo dre on|off > /proc/msp/ai%d\n", u32Ai); \
        HI_DRV_PROC_EchoHelper("example:  echo dre off > /proc/msp/ai%d\n", u32Ai); \
        HI_DRV_PROC_EchoHelper("\nfunction: ai set delay\n"); \
        HI_DRV_PROC_EchoHelper("commad:   echo setdelay 0~500 > /proc/msp/ai%d\n", u32Ai); \
        HI_DRV_PROC_EchoHelper("example:  echo setdelay 200 > /proc/msp/ai%d\n", u32Ai); \
    } while (0)        
#endif

typedef enum
{
    AI_CMD_CTRL_STOP = 0,
    AI_CMD_CTRL_START,
    AI_CMD_CTRL_BUTT
} AI_CMD_CTRL_E;     

typedef enum
{
    AI_CMD_PROC_SAVE_AI = 0,
    AI_CMD_PROC_DRE_SWITCH,    
    AI_CMD_PROC_SET_DELAY,      
    AI_CMD_PROC_BUTT
} AI_CMD_PROC_E;        

typedef struct
{
    HI_PHYS_ADDR_T  tBufPhyAddr;  
    HI_VIRT_ADDR_T  tBufVirAddr;  
    HI_U32  u32BufSize;
    HI_U32  u32PeriodByteSize;
    HI_U32  u32Periods;
} AI_ALSA_BUF_ATTR_S;

typedef struct hiAI_ALSA_Param_S
{
    AI_ALSA_BUF_ATTR_S       stBuf; //for  alsa  mmap dma buffer
    AIAO_IsrFunc             *IsrFunc;
    HI_VOID *pSubstream;  //for alsa ISR func params   
}AI_ALSA_Param_S;

typedef enum
{
    AI_CHANNEL_STATUS_STOP = 0,
    AI_CHANNEL_STATUS_START,
    AI_CHANNEL_STATUS_CAST_BUTT,
} AI_CHANNEL_STATUS_E;

typedef struct 
{
    HI_U32         u32AqcTryCnt;
    HI_U32         u32AqcCnt;
    HI_U32         u32RelTryCnt;
    HI_U32         u32RelCnt;
} AI_PROC_INFO_S;

typedef struct
{
    HI_UNF_AI_ATTR_S  stSndPortAttr;
    HI_UNF_AI_E       enAiPort;
    AIAO_PORT_ID_E    enPort;
    AI_CHANNEL_STATUS_E  enCurnStatus;
    MMZ_BUFFER_S            stRbfMmz;    //port mmz buf
    MMZ_BUFFER_S            stAiRbfMmz;  //ai mmz buf
    AI_BUF_ATTR_S           stAiBuf;     //the same as stAiRbfMmz In physics
    struct file *           pstFile;
    AI_PROC_INFO_S          stAiProc;
	HI_BOOL                 bAttach;
    HI_HANDLE               hTrack;
    HI_U32                  u32Rptr;
    HI_U32                  u32Wptr;
    HI_BOOL                 bAlsa;
    HI_VOID                 *pAlsaPara;
    HI_UNF_AI_DELAY_S       stDelayComps;
#if 1
    HI_BOOL                 bDre;
    HI_BOOL                     bIsBitsStream;
    //HI_UNF_AI_HDMI_DATA_TYPE_E  enDataType;
    HI_U32                      u32BitsBytesPerFrame;
    HI_U32                      u32BitsBytesNotRlease;
#endif
    /*save pcm*/
    AI_CMD_CTRL_E           enSaveState;
    HI_U32                  u32SaveCnt;
    struct file             *fileHandle;
    HI_VOID                 *pSaveBuf;  //for save ai data proc
    HI_U32                  u32SaveReadPos;
    HI_BOOL                 bSaveThreadRun;   
} AI_CHANNEL_STATE_S;

//AI
typedef struct hiAI_RESOURCE_S
{
    HI_UNF_AI_E              enAIPortID;               //AI Port ID
    //HI_UNF_AI_INPUTTYPE_E  enAIType;                //AI Type
    //CIRC_BUF_S               stCB;
    MMZ_BUFFER_S            stRbfMmz;
    
} AI_RESOURCE_S;

typedef struct tagAI_REGISTER_PARAM_S
{
    DRV_PROC_READ_FN  pfnReadProc;
    DRV_PROC_WRITE_FN pfnWriteProc;
} AI_REGISTER_PARAM_S;


//AI GLOABL RESOURCE 
typedef struct hiAI_GLOBAL_RESOURCE_S
{ 
    HI_U32                      u32BitFlag_AI;                              //resource usage such as  (1 << I2S | 1  << HDMI RX | 1 <<  ...)
    AI_CHANNEL_STATE_S       *pstAI_ATTR_S[AI_MAX_TOTAL_NUM];
    AI_REGISTER_PARAM_S*   pstProcParam;    /* AI Proc functions */
    //to do
    AI_EXPORT_FUNC_S     stExtFunc;       /* AI provide extenal functions */
}AI_GLOBAL_RESOURCE_S;


/* private dev state Save AI Resource opened */
typedef struct hiAI_AOESTATE_S
{
    //ai
    HI_U32 *RecordId[AI_MAX_TOTAL_NUM];
    //todo
    
} AI_STATE_S;

HI_S32 AI_DRV_Open(struct inode *finode, struct file  *ffile);
long AI_DRV_Ioctl(struct file *file, HI_U32 cmd, unsigned long arg);
HI_S32 AI_DRV_Release(struct inode *finode, struct file  *ffile);
HI_S32 AI_DRV_Init(HI_VOID);
HI_VOID AI_DRV_Exit(HI_VOID);
HI_S32 AI_DRV_ReadProc( struct seq_file* p, HI_VOID* v );
HI_S32 AI_DRV_WriteProc( struct file* file, const char __user* buf, size_t count, loff_t* ppos );
HI_S32 AI_DRV_RegisterProc(AI_REGISTER_PARAM_S * pstParam);
HI_VOID AI_DRV_UnregisterProc(HI_VOID);
HI_S32 AI_DRV_Suspend(PM_BASEDEV_S * pdev,pm_message_t   state);
HI_S32 AI_DRV_Resume(PM_BASEDEV_S * pdev);
HI_S32 AI_GetPortBuf(HI_HANDLE hAi, AIAO_RBUF_ATTR_S* pstAiaoBuf);
HI_S32 AI_GetPortAttr(HI_HANDLE hAi, AIAO_PORT_ATTR_S *pstPortAttr);
HI_S32 AI_GetDreEnableStatus(HI_HANDLE hAi, HI_BOOL *pbDre);
HI_S32 AI_SetAttachFlag(HI_HANDLE hAi, HI_HANDLE hTrack, HI_BOOL bAttachFlag);
HI_S32 AI_GetEnable(HI_HANDLE hAi, HI_BOOL *pbEnable);
HI_S32 AI_SetEnable(HI_HANDLE hAi, HI_BOOL bEnable, HI_BOOL bTrackResume);

#ifdef __cplusplus
 #if __cplusplus
}
 #endif
#endif /* __cplusplus */

#endif 
