/******************************************************************************

  Copyright (C), 2001-2011, Hisilicon Tech. Co., Ltd.

******************************************************************************
  File Name     : drv_ao.c
  Version       : Initial Draft
  Author        : Hisilicon multimedia software group
  Created       : 2013/04/17
  Description   :
  History       :
  1.Date        : 2013/04/17
    Author      : zgjie
    Modification: Created file

******************************************************************************/

/******************************* Include Files *******************************/

/* Sys headers */
#include <linux/version.h>
#include <linux/proc_fs.h>
#include <linux/ioport.h>
#include <linux/string.h>
#include <linux/ioctl.h>
#include <linux/fs.h>
#include <linux/delay.h>
#include <linux/sched.h>
#include <linux/vmalloc.h>
#include <linux/interrupt.h>
#include <linux/seq_file.h>
#include <asm/uaccess.h>
#include <asm/io.h>

/* Unf headers */
#include "hi_error_mpi.h"
#include "hi_drv_module.h"
#include "hi_drv_proc.h"

/* Drv headers */
#include "hi_drv_ao.h"
#include "hi_drv_ai.h"
#include "drv_ao_ioctl.h"
#include "drv_ao_ext.h"
#include "drv_adsp_ext.h"
#include "drv_ao_private.h"

#include "hi_audsp_aoe.h"
#include "hal_aoe.h"
#include "hal_cast.h"
#include "hal_aiao.h"

#include "drv_ao_op.h"
#include "drv_ao_track.h"
#include "drv_ao_aef.h"
#include "audio_util.h"
#if defined (HI_AUDIO_AI_SUPPORT)
#include "drv_ai_private.h"
#endif

#include "drv_hdmi_ext.h"
#include "drv_ao_cast.h"
#include "hi_drv_file.h"

#ifdef HI_ALSA_AO_SUPPORT
#include <linux/platform_device.h>

#ifdef CONFIG_PM
extern int snd_soc_suspend(struct device* dev);	//kernel inteface
extern int snd_soc_resume(struct device* dev);
static  HI_BOOL bu32shallowSuspendActive = HI_FALSE;
#endif

extern struct platform_device* hisi_snd_device;

#define PM_LOW_SUSPEND_FLAG   0x5FFFFFFF      //TODO
#endif

#ifdef HI_AIAO_TIMER_SUPPORT
#include "drv_timer_private.h"
#endif

#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif
#endif /* __cplusplus */

struct file  g_filp;

#if defined(HI_AIAO_VERIFICATION_SUPPORT)
#include "drv_aiao_ioctl_veri.h"
extern HI_VOID AIAO_VERI_Open(HI_VOID);
extern HI_VOID AIAO_VERI_Release(HI_VOID);
extern HI_S32  AIAO_VERI_ProcRead(struct seq_file* p, HI_VOID* v);
extern HI_S32 AIAO_VERI_ProcessCmd( struct inode* inode, struct file* file, HI_U32 cmd, HI_VOID* arg );
#endif

#if (1 == HI_PROC_SUPPORT)
static HI_S32 AO_RegProc(HI_U32 u32Snd);
static HI_VOID AO_UnRegProc(HI_U32 u32Snd);
#endif

HI_S32 AO_DRV_Resume(PM_BASEDEV_S* pdev);
HI_S32 AO_DRV_Suspend(PM_BASEDEV_S* pdev, pm_message_t   state);
HI_S32 AO_Track_GetDefAttr(HI_UNF_AUDIOTRACK_ATTR_S* pstDefAttr);
HI_S32 AO_Track_AllocHandle(HI_HANDLE *phHandle, HI_UNF_SND_TRACK_TYPE_E enTrackType, struct file *pstFile);
HI_VOID AO_Track_FreeHandle(HI_HANDLE hHandle);
HI_S32 AO_Track_PreCreate(HI_UNF_SND_E enSound, HI_UNF_AUDIOTRACK_ATTR_S* pstAttr,
                          HI_BOOL bAlsaTrack, AO_BUF_ATTR_S* pstBuf, HI_HANDLE hTrack);
HI_S32 AO_Track_Destory(HI_U32 u32TrackID);
HI_S32 AO_Track_Start(HI_U32 u32TrackID);
HI_S32 AO_Track_Stop(HI_U32 u32TrackID);
HI_S32 AO_Track_SendData(HI_U32 u32TrackID, AO_FRAMEINFO_S* pstAOFrame);


HI_S32 AO_DRV_Kopen(struct file*  file);
HI_S32 AO_DRV_Krelease(struct file*  file);
HI_S32 AO_Snd_Kclose(HI_UNF_SND_E  arg, struct file* file);
HI_S32 AO_Snd_Kclose(HI_UNF_SND_E  arg, struct file* file);

DEFINE_SEMAPHORE(g_AoMutex);

static AO_GLOBAL_PARAM_S s_stAoDrv =
{
    .u32TrackNum         =  0,
    .u32SndNum           =  0,
    .bLowLatencyCreated  =  HI_FALSE,
    .atmOpenCnt          = ATOMIC_INIT(0),
    .bReady              = HI_FALSE,
#if (1 == HI_PROC_SUPPORT)
    .pstProcParam        = HI_NULL,
#endif
    .pAdspFunc           = HI_NULL,
    .pstPDMFunc          = HI_NULL,
    .stExtFunc           =
    {
        .pfnAO_DrvResume = AO_DRV_Resume,
        .pfnAO_DrvSuspend = AO_DRV_Suspend,

        .pfnAO_TrackGetDefAttr = AO_Track_GetDefAttr,
        .pfnAO_TrackAllocHandle = AO_Track_AllocHandle,
        .pfnAO_TrackFreeHandle = AO_Track_FreeHandle,

        .pfnAO_TrackCreate = AO_Track_PreCreate,
        .pfnAO_TrackDestory = AO_Track_Destory,
        .pfnAO_TrackStart = AO_Track_Start,
        .pfnAO_TrackStop = AO_Track_Stop,
        .pfnAO_TrackSendData = AO_Track_SendData,
    }
};

/***************************** Original Static Definition *****************************/
#ifdef HI_SND_USER_AEF_SUPPORT
static HI_S32 AOAllocAefBuf(SND_CARD_STATE_S *pCard)
{
    HI_S32 Ret;
    HI_U32 u32FrmSize, u32McFrmSize;
    HI_U32 u32BufSize, u32PeriodSize, u32DmxBufSize, u32AssocBufSize, u32AefBufSize;
    HI_U32 u32Samples;
#ifdef DRV_SND_24BIT_OUTPUT        
    u32FrmSize = AUTIL_CalcFrameSize(AO_TRACK_NORMAL_CHANNELNUM, AO_TRACK_BITDEPTH_HIGH);
    u32McFrmSize = AUTIL_CalcFrameSize(AO_TRACK_MC_CHANNELNUM, AO_TRACK_BITDEPTH_HIGH);
#else
    u32FrmSize = AUTIL_CalcFrameSize(AO_TRACK_NORMAL_CHANNELNUM, AO_TRACK_BITDEPTH_LOW);
    u32McFrmSize = AUTIL_CalcFrameSize(AO_TRACK_MC_CHANNELNUM, AO_TRACK_BITDEPTH_LOW);
#endif
    u32Samples      = AOE_ENGINE_PROC_SAMPLES * AOE_AEF_PERIODBUF_NUM;
    u32DmxBufSize   = AOE_ENGINE_PROC_SAMPLES * u32FrmSize;
    u32AssocBufSize = u32DmxBufSize;
    u32McFrmSize    = AOE_ENGINE_PROC_SAMPLES * u32McFrmSize;
    u32AefBufSize   = u32DmxBufSize;
    u32PeriodSize   = sizeof(AOE_AEF_FRAME_INFO_S);
    u32PeriodSize  += u32DmxBufSize;
#ifdef DRV_SND_AD_OUTPUT_SUPPORT  
    u32PeriodSize  += u32AssocBufSize;
#endif

#ifdef DRV_SND_MULTICH_AEF_SUPPORT 
    u32PeriodSize  += u32McFrmSize;
#endif

    u32BufSize      = u32PeriodSize * AOE_AEF_PERIODBUF_NUM;

#if 0//#ifndef HI_SND_AOE_HW_SUPPORT  //sw aoe  //AOEIMP noise
    Ret = HI_DRV_MMZ_Alloc("AO_AefInbuf", MMZ_OTHERS, u32BufSize, AIAO_BUFFER_ADDR_ALIGN,
                                 &pCard->stAefInBufMmz);
    if (HI_SUCCESS != Ret)
    {
        HI_ERR_AO("HI_DRV_MMZ_Alloc AO_AefInbuf failed\n");
        return Ret;
    }
    Ret = HI_DRV_MMZ_MapCache(&pCard->stAefInBufMmz);
    if (HI_SUCCESS != Ret)
    {
        HI_DRV_MMZ_Release(&pCard->stAefInBufMmz);
        HI_ERR_AO("HI_DRV_MMZ_MapCache AO_AefInbuf failed\n");
        return Ret;
    }
#else
    Ret = HI_DRV_MMZ_AllocAndMap("AO_AefInbuf", MMZ_OTHERS, u32BufSize, 0, &pCard->stAefInBufMmz);//Cache todo
    if(HI_SUCCESS != Ret)
    {
        HI_ERR_AO("HI_DRV_MMZ_AllocAndMap AO_AefInbuf failed\n");
        return Ret;
    }    
#endif    

    u32PeriodSize = u32DmxBufSize;

#ifdef DRV_SND_AD_OUTPUT_SUPPORT  
    u32PeriodSize += u32AssocBufSize;
#endif

    u32PeriodSize += u32AefBufSize;
    u32BufSize = u32PeriodSize * AOE_AEF_PERIODBUF_NUM;
    
#if 0//#ifndef HI_SND_AOE_HW_SUPPORT  //sw aoe  //AOEIMP noise
    Ret = HI_DRV_MMZ_Alloc("AO_AefOutbuf", MMZ_OTHERS, u32BufSize, AIAO_BUFFER_ADDR_ALIGN,
                                 &pCard->stAefOutBufMmz);
    if (HI_SUCCESS != Ret)
    {
        HI_DRV_MMZ_Unmap(&pCard->stAefInBufMmz);
        HI_DRV_MMZ_Release(&pCard->stAefInBufMmz);
        HI_ERR_AO("HI_DRV_MMZ_Alloc AO_AefOutbuf failed\n");
        return Ret;
    }
    Ret = HI_DRV_MMZ_MapCache(&pCard->stAefOutBufMmz);
    if (HI_SUCCESS != Ret)
    {
        HI_DRV_MMZ_Release(&pCard->stAefOutBufMmz);
        HI_DRV_MMZ_Unmap(&pCard->stAefInBufMmz);
        HI_DRV_MMZ_Release(&pCard->stAefInBufMmz);
        HI_ERR_AO("HI_DRV_MMZ_MapCache AO_AefOutbuf failed\n");
        return Ret;
    }
#else
    Ret = HI_DRV_MMZ_AllocAndMap("AO_AefOutbuf", MMZ_OTHERS, u32BufSize, 0, &pCard->stAefOutBufMmz);
    if(HI_SUCCESS != Ret)
    {
        HI_DRV_MMZ_UnmapAndRelease(&pCard->stAefInBufMmz);
        HI_ERR_AO("HI_DRV_MMZ_AllocAndMap AO_AefOutbuf failed\n");
        return Ret;
    }
#endif

    return HI_SUCCESS;
}

static HI_VOID AOReleaseAefBuf(SND_CARD_STATE_S *pCard)
{
#ifndef HI_SND_AOE_HW_SUPPORT  //sw aoe
    if(pCard->stAefOutBufMmz.u32StartPhyAddr)
    {
        HI_DRV_MMZ_Unmap(&pCard->stAefOutBufMmz);
        HI_DRV_MMZ_Release(&pCard->stAefOutBufMmz);
        memset(&pCard->stAefOutBufMmz, 0, sizeof(MMZ_BUFFER_S));
    }

    if(pCard->stAefInBufMmz.u32StartPhyAddr)
    {
        HI_DRV_MMZ_Unmap(&pCard->stAefInBufMmz);
        HI_DRV_MMZ_Release(&pCard->stAefInBufMmz);
        memset(&pCard->stAefInBufMmz, 0, sizeof(MMZ_BUFFER_S));
    }
#else  //hw aoe
    if(pCard->stAefOutBufMmz.u32StartPhyAddr)
    {
        HI_DRV_MMZ_UnmapAndRelease(&pCard->stAefOutBufMmz);
        memset(&pCard->stAefOutBufMmz, 0, sizeof(MMZ_BUFFER_S));
    }
    if(pCard->stAefInBufMmz.u32StartPhyAddr)
    {
        HI_DRV_MMZ_UnmapAndRelease(&pCard->stAefInBufMmz);
        memset(&pCard->stAefInBufMmz, 0, sizeof(MMZ_BUFFER_S));
    }
#endif

    return; 
}
#endif

static SND_CARD_STATE_S* SND_CARD_GetCard(HI_UNF_SND_E enSound)
{
    return s_stAoDrv.astSndEntity[enSound].pCard;
}

static HI_UNF_SND_E SND_CARD_GetSnd(SND_CARD_STATE_S* pCard)
{
    HI_U32 i;

    for (i = 0; i < AO_MAX_TOTAL_SND_NUM; i++)
    {
        if (s_stAoDrv.astSndEntity[i].pCard  ==  pCard)
        {
            return i;
        }
    }
    return AO_MAX_TOTAL_SND_NUM;
}

static HI_VOID AO_Snd_FreeHandle(HI_UNF_SND_E enSound, struct file* pstFile)
{
    SND_CARD_STATE_S* pCard = s_stAoDrv.astSndEntity[enSound].pCard;
    HI_U32 u32FileId = ((DRV_AO_STATE_S*)(pstFile->private_data))->u32FileId[enSound];

    if (0 == atomic_read(&s_stAoDrv.astSndEntity[enSound].atmUseTotalCnt))
    {
#ifdef HI_SND_AFLT_SUPPORT
        HI_U32 u32AefId;
        for(u32AefId = 0; u32AefId < AOE_AEF_MAX_CHAN_NUM * 2; u32AefId++)
        {
            if (pCard->u32AttAef & ((HI_U32)1L << u32AefId))
            {
                AEF_DetachSnd(pCard, u32AefId);
            }
        }
#endif

#ifdef HI_SND_USER_AEF_SUPPORT
        AOReleaseAefBuf(pCard);
#endif
        
        AUTIL_AO_FREE(HI_ID_AO, pCard);
        s_stAoDrv.astSndEntity[enSound].pCard = HI_NULL;
        s_stAoDrv.u32SndNum--;
    }

    if (u32FileId < SND_MAX_OPEN_NUM)
    {
        s_stAoDrv.astSndEntity[enSound].pstFile[u32FileId] = HI_NULL;
    }

    ((DRV_AO_STATE_S*)(pstFile->private_data))->u32FileId[enSound] = AO_SND_FILE_NOUSE_FLAG;

    return;
}

static HI_S32 SNDGetFreeFileId(HI_UNF_SND_E enSound)
{
    HI_U32 i;

    for (i = 0; i < SND_MAX_OPEN_NUM; i++)
    {
        if (s_stAoDrv.astSndEntity[enSound].pstFile[i]  == HI_NULL)
        {
            return i;
        }
    }

    return SND_MAX_OPEN_NUM;
}

static HI_S32 AO_Snd_AllocHandle(HI_UNF_SND_E enSound, struct file* pstFile)
{
#ifdef HI_SND_USER_AEF_SUPPORT  
    HI_S32 s32Ret;
#endif
    SND_CARD_STATE_S* pCard;
    HI_U32 u32FreeId;

    if (enSound >= HI_UNF_SND_BUTT)
    {
        HI_ERR_AO("Bad param!\n");
        goto err0;
    }

    /* Check ready flag */
    if (s_stAoDrv.bReady != HI_TRUE)
    {
        HI_ERR_AO("Need open first!\n");
        goto err0;
    }

    u32FreeId = SNDGetFreeFileId(enSound);
    if (u32FreeId >= SND_MAX_OPEN_NUM)
    {
        HI_ERR_AO("Get free file id faied!\n");
        goto err0;
    }
    if (AO_SND_FILE_NOUSE_FLAG == ((DRV_AO_STATE_S*)(pstFile->private_data))->u32FileId[enSound])
    {
        ((DRV_AO_STATE_S*)(pstFile->private_data))->u32FileId[enSound] = u32FreeId;
        s_stAoDrv.astSndEntity[enSound].pstFile[u32FreeId] = pstFile;
    }
    /* Allocate new snd resource */
    if (0 == atomic_read(&s_stAoDrv.astSndEntity[enSound].atmUseTotalCnt))
    {
        pCard = (SND_CARD_STATE_S*)AUTIL_AO_MALLOC(HI_ID_AO, sizeof(SND_CARD_STATE_S), GFP_KERNEL);
        if (HI_NULL == pCard)
        {
            HI_ERR_AO("Kmalloc card failed!\n");
            goto err1;
        }
        memset(pCard, 0, sizeof(SND_CARD_STATE_S));
        
#ifdef HI_SND_USER_AEF_SUPPORT  
        s32Ret = AOAllocAefBuf(pCard);
        if(HI_SUCCESS != s32Ret)
        {
            HI_ERR_AO("Alloc aef buffer failed!\n");
            goto err2;
        }
#endif

        s_stAoDrv.astSndEntity[enSound].pCard = pCard;
        s_stAoDrv.u32SndNum++;
    }

    return HI_SUCCESS;

#ifdef HI_SND_USER_AEF_SUPPORT 
err2:    
    AUTIL_AO_FREE(HI_ID_AO, pCard);
#endif
err1:
    s_stAoDrv.astSndEntity[enSound].pstFile[u32FreeId] = HI_NULL;
err0:
    return HI_FAILURE;
}

/******************************Snd process FUNC*************************************/
HI_BOOL AOCheckOutPortIsAttached(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort)
{
    HI_U32 u32Snd;
    HI_U32 u32Port;
    SND_CARD_STATE_S* pCard;
    for (u32Snd = 0; u32Snd < (HI_U32)HI_UNF_SND_BUTT; u32Snd++)
    {
        if (u32Snd != (HI_U32)enSound)
        {
            pCard = SND_CARD_GetCard((HI_UNF_SND_E)u32Snd);
            if (HI_NULL != pCard)
            {
                for (u32Port = 0; u32Port < pCard->stUserOpenParam.u32PortNum; u32Port++)
                {
                    if (enOutPort == pCard->stUserOpenParam.stOutport[u32Port].enOutPort)
                    {
                        return HI_TRUE;
                    }
                }
            }
        }
    }

    return HI_FALSE;
}

static HI_S32 AOGetSndOpenAttrFromPDM(AO_SND_OpenDefault_Param_S *pstSndDefaultAttr)
{
    HI_S32 s32Ret = HI_SUCCESS;
    HI_UNF_PDM_SOUND_PARAM_S stSoundPdmParam;
    if (s_stAoDrv.pstPDMFunc && s_stAoDrv.pstPDMFunc->pfnGetSoundParam)
    {
        HI_U32 i;
        s32Ret = (s_stAoDrv.pstPDMFunc->pfnGetSoundParam)(pstSndDefaultAttr->enSound, &stSoundPdmParam);
        if (HI_SUCCESS == s32Ret)
        {
            if (stSoundPdmParam.u32PortNum <= HI_UNF_SND_OUTPUTPORT_MAX)
            {
                pstSndDefaultAttr->stAttr.u32PortNum = stSoundPdmParam.u32PortNum;
                for (i = 0; i < stSoundPdmParam.u32PortNum; i++)
                {
                    pstSndDefaultAttr->stAttr.stOutport[i].enOutPort = stSoundPdmParam.stOutport[i].enOutPort;
                    switch (pstSndDefaultAttr->stAttr.stOutport[i].enOutPort)
                    {
                        case HI_UNF_SND_OUTPUTPORT_DAC0:
                            HI_INFO_AO(">> HI_UNF_SND_OUTPUTPORT_DAC0\n");
                            pstSndDefaultAttr->stAttr.stOutport[i].unAttr.u32DacAttr = HI_NULL;
                            pstSndDefaultAttr->stAttr.enSampleRate = HI_UNF_SAMPLE_RATE_48K;
                            break;
                        case HI_UNF_SND_OUTPUTPORT_SPDIF0:
                            HI_INFO_AO(">> HI_UNF_SND_OUTPUTPORT_SPDIF0\n");
                            pstSndDefaultAttr->stAttr.stOutport[i].unAttr.u32SpdifAttr = HI_NULL;
                            pstSndDefaultAttr->stAttr.enSampleRate = HI_UNF_SAMPLE_RATE_48K;
                            break;
                        case HI_UNF_SND_OUTPUTPORT_HDMI0:
                            HI_INFO_AO(">> HI_UNF_SND_OUTPUTPORT_HDMI0\n");
                            pstSndDefaultAttr->stAttr.stOutport[i].unAttr.u32HDMIAttr = HI_NULL;
                            pstSndDefaultAttr->stAttr.enSampleRate = HI_UNF_SAMPLE_RATE_48K;
                            break;
                        case HI_UNF_SND_OUTPUTPORT_I2S0:	//default support
                            HI_INFO_AO(">> HI_UNF_SND_OUTPUTPORT_I2S0\n");
                            pstSndDefaultAttr->stAttr.stOutport[i].unAttr.stI2sAttr.stAttr.bMaster = stSoundPdmParam.stOutport[i].unAttr.stI2sAttr.stAttr.bMaster;
                            pstSndDefaultAttr->stAttr.stOutport[i].unAttr.stI2sAttr.stAttr.enI2sMode = stSoundPdmParam.stOutport[i].unAttr.stI2sAttr.stAttr.enI2sMode;
                            pstSndDefaultAttr->stAttr.stOutport[i].unAttr.stI2sAttr.stAttr.enMclkSel = stSoundPdmParam.stOutport[i].unAttr.stI2sAttr.stAttr.enMclkSel;
                            pstSndDefaultAttr->stAttr.stOutport[i].unAttr.stI2sAttr.stAttr.enBclkSel = stSoundPdmParam.stOutport[i].unAttr.stI2sAttr.stAttr.enBclkSel;
                            /*Compatible with old base param,  force to 2ch output */
							//pstSndDefaultAttr->stAttr.stOutport[i].unAttr.stI2sAttr.stAttr.enChannel = stSoundPdmParam.stOutport[i].unAttr.stI2sAttr.stAttr.enChannel;
                            pstSndDefaultAttr->stAttr.stOutport[i].unAttr.stI2sAttr.stAttr.enChannel = HI_UNF_I2S_CHNUM_2;
                            pstSndDefaultAttr->stAttr.stOutport[i].unAttr.stI2sAttr.stAttr.enBitDepth = stSoundPdmParam.stOutport[i].unAttr.stI2sAttr.stAttr.enBitDepth;
                            pstSndDefaultAttr->stAttr.stOutport[i].unAttr.stI2sAttr.stAttr.bPcmSampleRiseEdge = stSoundPdmParam.stOutport[i].unAttr.stI2sAttr.stAttr.bPcmSampleRiseEdge;
                            pstSndDefaultAttr->stAttr.stOutport[i].unAttr.stI2sAttr.stAttr.enPcmDelayCycle = stSoundPdmParam.stOutport[i].unAttr.stI2sAttr.stAttr.enPcmDelayCycle;
                            HI_INFO_AO("bMaster:0x%x\n", pstSndDefaultAttr->stAttr.stOutport[i].unAttr.stI2sAttr.stAttr.bMaster);
                            HI_INFO_AO("enI2sMode:0x%x\n", pstSndDefaultAttr->stAttr.stOutport[i].unAttr.stI2sAttr.stAttr.enI2sMode);
                            HI_INFO_AO("enMclkSel:0x%x\n", pstSndDefaultAttr->stAttr.stOutport[i].unAttr.stI2sAttr.stAttr.enMclkSel);
                            HI_INFO_AO("enBclkSel:0x%x\n", pstSndDefaultAttr->stAttr.stOutport[i].unAttr.stI2sAttr.stAttr.enBclkSel);
                            HI_INFO_AO("enChannel:0x%x\n", pstSndDefaultAttr->stAttr.stOutport[i].unAttr.stI2sAttr.stAttr.enChannel);
                            HI_INFO_AO("enBitDepth:0x%x\n", pstSndDefaultAttr->stAttr.stOutport[i].unAttr.stI2sAttr.stAttr.enBitDepth);
                            HI_INFO_AO("bPcmSampleRiseEdge:0x%x\n", pstSndDefaultAttr->stAttr.stOutport[i].unAttr.stI2sAttr.stAttr.bPcmSampleRiseEdge);
                            HI_INFO_AO("enPcmDelayCycle:0x%x\n", pstSndDefaultAttr->stAttr.stOutport[i].unAttr.stI2sAttr.stAttr.enPcmDelayCycle);
                            break;
                        case HI_UNF_SND_OUTPUTPORT_I2S1:	//default support
                            HI_INFO_AO(">> HI_UNF_SND_OUTPUTPORT_I2S1\n");
                            pstSndDefaultAttr->stAttr.stOutport[i].unAttr.stI2sAttr.stAttr.bMaster = stSoundPdmParam.stOutport[i].unAttr.stI2sAttr.stAttr.bMaster;
                            pstSndDefaultAttr->stAttr.stOutport[i].unAttr.stI2sAttr.stAttr.enI2sMode = stSoundPdmParam.stOutport[i].unAttr.stI2sAttr.stAttr.enI2sMode;
                            pstSndDefaultAttr->stAttr.stOutport[i].unAttr.stI2sAttr.stAttr.enMclkSel = stSoundPdmParam.stOutport[i].unAttr.stI2sAttr.stAttr.enMclkSel;
                            pstSndDefaultAttr->stAttr.stOutport[i].unAttr.stI2sAttr.stAttr.enBclkSel = stSoundPdmParam.stOutport[i].unAttr.stI2sAttr.stAttr.enBclkSel;
                            /* I2S do not support 1&8 channel output, so force to 2ch output */
                            pstSndDefaultAttr->stAttr.stOutport[i].unAttr.stI2sAttr.stAttr.enChannel = HI_UNF_I2S_CHNUM_2;
                            pstSndDefaultAttr->stAttr.stOutport[i].unAttr.stI2sAttr.stAttr.enBitDepth = stSoundPdmParam.stOutport[i].unAttr.stI2sAttr.stAttr.enBitDepth;
                            pstSndDefaultAttr->stAttr.stOutport[i].unAttr.stI2sAttr.stAttr.bPcmSampleRiseEdge = stSoundPdmParam.stOutport[i].unAttr.stI2sAttr.stAttr.bPcmSampleRiseEdge;
                            pstSndDefaultAttr->stAttr.stOutport[i].unAttr.stI2sAttr.stAttr.enPcmDelayCycle = stSoundPdmParam.stOutport[i].unAttr.stI2sAttr.stAttr.enPcmDelayCycle;
                            HI_INFO_AO("bMaster:0x%x\n", pstSndDefaultAttr->stAttr.stOutport[i].unAttr.stI2sAttr.stAttr.bMaster);
                            HI_INFO_AO("enI2sMode:0x%x\n", pstSndDefaultAttr->stAttr.stOutport[i].unAttr.stI2sAttr.stAttr.enI2sMode);
                            HI_INFO_AO("enMclkSel:0x%x\n", pstSndDefaultAttr->stAttr.stOutport[i].unAttr.stI2sAttr.stAttr.enMclkSel);
                            HI_INFO_AO("enBclkSel:0x%x\n", pstSndDefaultAttr->stAttr.stOutport[i].unAttr.stI2sAttr.stAttr.enBclkSel);
                            HI_INFO_AO("enChannel:0x%x\n", pstSndDefaultAttr->stAttr.stOutport[i].unAttr.stI2sAttr.stAttr.enChannel);
                            HI_INFO_AO("enBitDepth:0x%x\n", pstSndDefaultAttr->stAttr.stOutport[i].unAttr.stI2sAttr.stAttr.enBitDepth);
                            HI_INFO_AO("bPcmSampleRiseEdge:0x%x\n", pstSndDefaultAttr->stAttr.stOutport[i].unAttr.stI2sAttr.stAttr.bPcmSampleRiseEdge);
                            HI_INFO_AO("enPcmDelayCycle:0x%x\n", pstSndDefaultAttr->stAttr.stOutport[i].unAttr.stI2sAttr.stAttr.enPcmDelayCycle);
                            break;
                        default:
                            HI_WARN_AO("SND Not support OUTPUTPORT:0x%x\n", pstSndDefaultAttr->stAttr.stOutport[i].enOutPort);
                            break;
                    }
                }

                return HI_SUCCESS;
            }
            HI_ERR_AO("Get PDM param invalid u32PortNum=0x%x\n", stSoundPdmParam.u32PortNum);
        }
        HI_WARN_AO("Get PDM param failed, use default param!\n");
    }
    HI_WARN_AO("Get PDMFunc Symbol failed, use default param!\n");
    return HI_FAILURE;
}

HI_S32 AOGetSndDefOpenAttr(AO_SND_OpenDefault_Param_S *pstSndDefaultAttr)
{
#if defined(CHIP_TYPE_hi3751v100)
	pstSndDefaultAttr->stAttr.u32PortNum = 5;

    pstSndDefaultAttr->stAttr.stOutport[0].enOutPort = HI_UNF_SND_OUTPUTPORT_DAC0;
    pstSndDefaultAttr->stAttr.stOutport[0].unAttr.stDacAttr.pPara = HI_NULL;

    pstSndDefaultAttr->stAttr.stOutport[1].enOutPort = HI_UNF_SND_OUTPUTPORT_EXT_DAC1;
    pstSndDefaultAttr->stAttr.stOutport[1].unAttr.stSpdifAttr.pPara = HI_NULL;
    pstSndDefaultAttr->stAttr.stOutport[2].enOutPort = HI_UNF_SND_OUTPUTPORT_EXT_DAC2;
    pstSndDefaultAttr->stAttr.stOutport[2].unAttr.stHDMIAttr.pPara = HI_NULL;
    pstSndDefaultAttr->stAttr.stOutport[3].enOutPort = HI_UNF_SND_OUTPUTPORT_EXT_DAC3;/*Analog Amp*/
    pstSndDefaultAttr->stAttr.stOutport[3].unAttr.stDacAttr.pPara = HI_NULL;
    pstSndDefaultAttr->stAttr.stOutport[4].enOutPort = HI_UNF_SND_OUTPUTPORT_SPDIF0;
    pstSndDefaultAttr->stAttr.stOutport[4].unAttr.stSpdifAttr.pPara = HI_NULL;
#else
    HI_S32 s32Ret = HI_SUCCESS;
    s32Ret = AOGetSndOpenAttrFromPDM(pstSndDefaultAttr);
    if (HI_SUCCESS == s32Ret)
    {
        return HI_SUCCESS;
    }

    // use default open attr
#if 0
    pstSndDefaultAttr->stAttr.u32PortNum = 2;

    pstSndDefaultAttr->stAttr.stOutport[0].enOutPort = HI_UNF_SND_OUTPUTPORT_DAC0;
    pstSndDefaultAttr->stAttr.stOutport[0].unAttr.u32DacAttr = HI_NULL;
    pstSndDefaultAttr->stAttr.stOutport[1].enOutPort = HI_UNF_SND_OUTPUTPORT_SPDIF0;
    pstSndDefaultAttr->stAttr.stOutport[1].unAttr.u32SpdifAttr = HI_NULL;

#else
    pstSndDefaultAttr->stAttr.u32PortNum = 3;
    pstSndDefaultAttr->stAttr.stOutport[0].enOutPort = HI_UNF_SND_OUTPUTPORT_DAC0;
    pstSndDefaultAttr->stAttr.stOutport[0].unAttr.u32DacAttr = HI_NULL;

    /*pstSndDefaultAttr->stAttr.stOutport[1].enOutPort = HI_UNF_SND_OUTPUTPORT_EXT_DAC1;
    pstSndDefaultAttr->stAttr.stOutport[1].unAttr.stSpdifAttr.pPara = HI_NULL;
    pstSndDefaultAttr->stAttr.stOutport[2].enOutPort = HI_UNF_SND_OUTPUTPORT_EXT_DAC2;
    pstSndDefaultAttr->stAttr.stOutport[2].unAttr.stHDMIAttr.pPara = HI_NULL;
    pstSndDefaultAttr->stAttr.stOutport[3].enOutPort = HI_UNF_SND_OUTPUTPORT_EXT_DAC3;//Analog Amp
    pstSndDefaultAttr->stAttr.stOutport[3].unAttr.stDacAttr.pPara = HI_NULL; */
    pstSndDefaultAttr->stAttr.stOutport[1].enOutPort = HI_UNF_SND_OUTPUTPORT_SPDIF0;
    pstSndDefaultAttr->stAttr.stOutport[1].unAttr.u32SpdifAttr = HI_NULL;
    pstSndDefaultAttr->stAttr.stOutport[2].enOutPort = HI_UNF_SND_OUTPUTPORT_HDMI0;
    pstSndDefaultAttr->stAttr.stOutport[2].unAttr.u32HDMIAttr = HI_NULL;
#endif
#endif

    pstSndDefaultAttr->stAttr.enSampleRate = HI_UNF_SAMPLE_RATE_48K;

#if 0
    pstSndDefaultAttr->stAttr.stOutport[pstSndDefaultAttr->stAttr.u32PortNum].enOutPort = HI_UNF_SND_OUTPUTPORT_I2S0;
    pstSndDefaultAttr->stAttr.stOutport[pstSndDefaultAttr->stAttr.u32PortNum].unAttr.stI2sAttr.stAttr.bMaster = HI_TRUE;
    pstSndDefaultAttr->stAttr.stOutport[pstSndDefaultAttr->stAttr.u32PortNum].unAttr.stI2sAttr.stAttr.enI2sMode = HI_UNF_I2S_STD_MODE;
    pstSndDefaultAttr->stAttr.stOutport[pstSndDefaultAttr->stAttr.u32PortNum].unAttr.stI2sAttr.stAttr.enMclkSel = HI_UNF_I2S_MCLK_256_FS;
    pstSndDefaultAttr->stAttr.stOutport[pstSndDefaultAttr->stAttr.u32PortNum].unAttr.stI2sAttr.stAttr.enBclkSel = HI_UNF_I2S_BCLK_4_DIV;
    pstSndDefaultAttr->stAttr.stOutport[pstSndDefaultAttr->stAttr.u32PortNum].unAttr.stI2sAttr.stAttr.enChannel = HI_UNF_I2S_CHNUM_2;
    pstSndDefaultAttr->stAttr.stOutport[pstSndDefaultAttr->stAttr.u32PortNum].unAttr.stI2sAttr.stAttr.enBitDepth = HI_UNF_I2S_BIT_DEPTH_16;
    pstSndDefaultAttr->stAttr.stOutport[pstSndDefaultAttr->stAttr.u32PortNum].unAttr.stI2sAttr.stAttr.bPcmSampleRiseEdge = HI_TRUE;
    pstSndDefaultAttr->stAttr.stOutport[pstSndDefaultAttr->stAttr.u32PortNum].unAttr.stI2sAttr.stAttr.enPcmDelayCycle = HI_UNF_I2S_PCM_1_DELAY;
    pstSndDefaultAttr->stAttr.u32PortNum++;
#endif
#if defined(CHIP_TYPE_hi3751v100)
#if defined(HI_I2S1_SUPPORT)
    pstSndDefaultAttr->stAttr.stOutport[pstSndDefaultAttr->stAttr.u32PortNum].enOutPort = HI_UNF_SND_OUTPUTPORT_I2S1;
    pstSndDefaultAttr->stAttr.stOutport[pstSndDefaultAttr->stAttr.u32PortNum].unAttr.stI2sAttr.stAttr.bMaster = HI_TRUE;
    pstSndDefaultAttr->stAttr.stOutport[pstSndDefaultAttr->stAttr.u32PortNum].unAttr.stI2sAttr.stAttr.enI2sMode = HI_UNF_I2S_STD_MODE;
    pstSndDefaultAttr->stAttr.stOutport[pstSndDefaultAttr->stAttr.u32PortNum].unAttr.stI2sAttr.stAttr.enMclkSel = HI_UNF_I2S_MCLK_256_FS;
    pstSndDefaultAttr->stAttr.stOutport[pstSndDefaultAttr->stAttr.u32PortNum].unAttr.stI2sAttr.stAttr.enBclkSel = HI_UNF_I2S_BCLK_4_DIV;
    pstSndDefaultAttr->stAttr.stOutport[pstSndDefaultAttr->stAttr.u32PortNum].unAttr.stI2sAttr.stAttr.enChannel = HI_UNF_I2S_CHNUM_2;
    pstSndDefaultAttr->stAttr.stOutport[pstSndDefaultAttr->stAttr.u32PortNum].unAttr.stI2sAttr.stAttr.enBitDepth = HI_UNF_I2S_BIT_DEPTH_16;
    pstSndDefaultAttr->stAttr.stOutport[pstSndDefaultAttr->stAttr.u32PortNum].unAttr.stI2sAttr.stAttr.bPcmSampleRiseEdge = HI_TRUE;
    pstSndDefaultAttr->stAttr.stOutport[pstSndDefaultAttr->stAttr.u32PortNum].unAttr.stI2sAttr.stAttr.enPcmDelayCycle = HI_UNF_I2S_PCM_1_DELAY;
    pstSndDefaultAttr->stAttr.u32PortNum++;
#endif
#else

#endif
    return HI_SUCCESS;
}

static HI_BOOL AOCheckOutPortIsValid(HI_UNF_SND_OUTPUTPORT_E enOutPort)
{
#if    defined(CHIP_TYPE_hi3716cv200)   \
    || defined(CHIP_TYPE_hi3716mv400)   \
    || defined(CHIP_TYPE_hi3718cv100)   \
    || defined(CHIP_TYPE_hi3719cv100)   \
    || defined(CHIP_TYPE_hi3719mv100_a) \
    || defined(CHIP_TYPE_hi3798cv100)   \
    || defined(CHIP_TYPE_hi3798mv100)   \
    || defined(CHIP_TYPE_hi3796mv100)
    if ((HI_UNF_SND_OUTPUTPORT_DAC0 != enOutPort) && (HI_UNF_SND_OUTPUTPORT_SPDIF0 != enOutPort)
        && (HI_UNF_SND_OUTPUTPORT_HDMI0 != enOutPort) && (HI_UNF_SND_OUTPUTPORT_I2S0 != enOutPort)
        && (HI_UNF_SND_OUTPUTPORT_I2S1 != enOutPort))
    {
        HI_ERR_AO("just support I2S0, I2S1, DAC0, SPDIF0 and HDMI0 Port!\n");
        return HI_FALSE;
    }
#elif    defined(CHIP_TYPE_hi3719mv100)   \
      || defined(CHIP_TYPE_hi3718mv100)   \
      || defined(CHIP_TYPE_hi3798cv200_a) \
      || defined(CHIP_TYPE_hi3798cv200_b) \
      || defined(CHIP_TYPE_hi3798cv200)   \
      || defined(CHIP_TYPE_hi3798hv100)   \
      || defined(CHIP_TYPE_hi3716mv420)
    if ((HI_UNF_SND_OUTPUTPORT_DAC0 != enOutPort) && (HI_UNF_SND_OUTPUTPORT_SPDIF0 != enOutPort)
        && (HI_UNF_SND_OUTPUTPORT_HDMI0 != enOutPort) && (HI_UNF_SND_OUTPUTPORT_I2S0 != enOutPort))
    {
        HI_ERR_AO("just support I2S0, DAC0, SPDIF0 and HDMI0 Port!\n");
        return HI_FALSE;
    }
#elif defined(CHIP_TYPE_hi3716mv410)
    if ((HI_UNF_SND_OUTPUTPORT_DAC0 != enOutPort) && (HI_UNF_SND_OUTPUTPORT_SPDIF0 != enOutPort)
        && (HI_UNF_SND_OUTPUTPORT_HDMI0 != enOutPort))
    {
        HI_ERR_AO("just support DAC0, SPDIF0 and HDMI0 Port!\n");
        return HI_FALSE;
    }
#elif defined(CHIP_TYPE_hi3751v100)  || defined(CHIP_TYPE_hi3751v100b)
    if ((HI_UNF_SND_OUTPUTPORT_DAC0 != enOutPort) && (HI_UNF_SND_OUTPUTPORT_EXT_DAC1 != enOutPort)
        && (HI_UNF_SND_OUTPUTPORT_EXT_DAC2 != enOutPort) && (HI_UNF_SND_OUTPUTPORT_EXT_DAC3 != enOutPort)
        && (HI_UNF_SND_OUTPUTPORT_SPDIF0 != enOutPort) && (HI_UNF_SND_OUTPUTPORT_I2S0 != enOutPort)
        && (HI_UNF_SND_OUTPUTPORT_I2S1 != enOutPort))
    {
        HI_ERR_AO("just support I2S0, I2S1, DAC0, DAC1, DAC2, DAC3 and SPDIF0 Port!\n");
        return HI_FALSE;
    }
#elif defined(CHIP_TYPE_hi3751v600) || defined (CHIP_TYPE_hi3751lv500)
    if ((HI_UNF_SND_OUTPUTPORT_DAC0 != enOutPort) && (HI_UNF_SND_OUTPUTPORT_EXT_DAC1 != enOutPort)
        && (HI_UNF_SND_OUTPUTPORT_EXT_DAC2 != enOutPort) && (HI_UNF_SND_OUTPUTPORT_SPDIF0 != enOutPort)
        && (HI_UNF_SND_OUTPUTPORT_I2S0 != enOutPort) && (HI_UNF_SND_OUTPUTPORT_I2S1 != enOutPort))
    {
        HI_ERR_AO("just support I2S0, I2S1, DAC0, DAC1, DAC2 and SPDIF0 Port!\n");
        return HI_FALSE;
    }
#elif defined(CHIP_TYPE_hi3751av500)
    if ((HI_UNF_SND_OUTPUTPORT_DAC0 != enOutPort) && (HI_UNF_SND_OUTPUTPORT_EXT_DAC1 != enOutPort)
        && (HI_UNF_SND_OUTPUTPORT_EXT_DAC2 != enOutPort) && (HI_UNF_SND_OUTPUTPORT_SPDIF0 != enOutPort)
        && (HI_UNF_SND_OUTPUTPORT_I2S1 != enOutPort))
    {
        HI_ERR_AO("just support I2S0, I2S1, DAC0, DAC1, DAC2 and SPDIF0 Port!\n");
        return HI_FALSE;
    }
#else
#error YOU MUST DEFINE  CHIP_TYPE!
#endif

    return HI_TRUE;
}

#if 0
static HI_VOID AOGetDefAvcAttr(HI_UNF_SND_AVC_ATTR_S*  pstAvcAttr)
{
    HI_UNF_SND_AVC_ATTR_S  stDfAvcAttr ={50, 100, -32, 5, -10};
    memcpy(pstAvcAttr, &stDfAvcAttr, sizeof(HI_UNF_SND_AVC_ATTR_S));
    return;
}

static HI_VOID AOGetDefGeqAttr(HI_UNF_SND_GEQ_ATTR_S*  pstGeqAttr)
{
    HI_UNF_SND_GEQ_ATTR_S  stDfGeqAttr =
    {
        5,
        {
            {120, 0},
            {500, 0},
            {1500, 0},
            {5000, 0},
            {10000, 0},
            {0, 0},
            {0, 0},
            {0, 0},
            {0, 0},
            {0, 0}
        }
    };
    memcpy(pstGeqAttr, &stDfGeqAttr, sizeof(HI_UNF_SND_GEQ_ATTR_S));
    return;
}
#endif

#ifndef HI_SND_AOE_HW_SUPPORT
static HI_S32 AOAllocCacheAipBuf(SND_CARD_STATE_S* pCard)
{
    HI_S32 Ret = HI_SUCCESS;

    Ret = HI_DRV_MMZ_Alloc("AO_MAipPcm", MMZ_OTHERS, AO_TRACK_PCM_BUFSIZE_BYTE_MAX, AIAO_BUFFER_ADDR_ALIGN,
                           &pCard->stTrackRbfMmz[SND_AIP_TYPE_PCM]);
    if (HI_SUCCESS != Ret)
    {
        HI_ERR_AO("MMZ_AllocAndMap(AO_MAipPcm) failed\n");
        goto ALLOCATE_MAIPPCM_ERR;
    }

    Ret = HI_DRV_MMZ_MapCache(&pCard->stTrackRbfMmz[SND_AIP_TYPE_PCM]);
    if (HI_SUCCESS != Ret)
    {
        HI_ERR_AO("HI_DRV_MMZ_MapCache(AO_MAipPcm) failed\n");
        goto MAPCACHE_MAIPPCM_ERR;
    }

#ifdef DRV_SND_MULTICH_AEF_SUPPORT
    Ret = HI_DRV_MMZ_Alloc("AO_MAipMcPcm", MMZ_OTHERS, AO_TRACK_HBR_BUFSIZE_BYTE_MAX, AIAO_BUFFER_ADDR_ALIGN,
                           &pCard->stTrackRbfMmz[SND_AIP_TYPE_MC_PCM]);
    if (HI_SUCCESS != Ret)
    {
        HI_ERR_AO("MMZ_AllocAndMap(AO_MAipMcPcm) failed\n");
        goto ALLOCATE_MAIPMCPCM_ERR;
    }

    Ret = HI_DRV_MMZ_MapCache(&pCard->stTrackRbfMmz[SND_AIP_TYPE_MC_PCM]);
    if (HI_SUCCESS != Ret)
    {
        HI_ERR_AO("HI_DRV_MMZ_MapCache(AO_MAipMcPcm) failed\n");
        goto MAPCACHE_MAIPMCPCM_ERR;
    }
#endif

#ifdef DRV_SND_AD_OUTPUT_SUPPORT
    Ret = HI_DRV_MMZ_Alloc("AO_MAipAssocPcm", MMZ_OTHERS, AO_TRACK_PCM_BUFSIZE_BYTE_MAX, AIAO_BUFFER_ADDR_ALIGN,
                           &pCard->stTrackRbfMmz[SND_AIP_TYPE_ASSOC_PCM]);
    if (HI_SUCCESS != Ret)
    {
        HI_ERR_AO("MMZ_AllocAndMap(AO_MAipAssocPcm) failed\n");
        goto ALLOCATE_MAIPASSOCPCM_ERR;
    }

    Ret = HI_DRV_MMZ_MapCache(&pCard->stTrackRbfMmz[SND_AIP_TYPE_ASSOC_PCM]);
    if (HI_SUCCESS != Ret)
    {
        HI_ERR_AO("HI_DRV_MMZ_MapCache(AO_MAipAssocPcm) failed\n");
        goto MAPCACHE_MAIPASSOCPCM_ERR;
    }
#endif

    if (SND_SPDIF_MODE_NONE != pCard->enSpdifPassthrough)
    {
        Ret = HI_DRV_MMZ_Alloc("AO_MAipSpdRaw", MMZ_OTHERS, AO_TRACK_LBR_BUFSIZE_BYTE_MAX, AIAO_BUFFER_ADDR_ALIGN,
                               &pCard->stTrackRbfMmz[SND_AIP_TYPE_SPDIF_RAW]);
        if (HI_SUCCESS != Ret)
        {
            HI_ERR_AO("MMZ_AllocAndMap(AO_MAipSpdRaw) failed\n");
            goto ALLOCATE_MAIPSPDRAW_ERR;
        }

        Ret = HI_DRV_MMZ_MapCache(&pCard->stTrackRbfMmz[SND_AIP_TYPE_SPDIF_RAW]);
        if (HI_SUCCESS != Ret)
        {
            HI_ERR_AO("HI_DRV_MMZ_MapCache(AO_MAipSpdRaw) failed\n");
            goto MAPCACHE_MAIPSPDRAW_ERR;
        }
    }

    if (SND_HDMI_MODE_NONE != pCard->enHdmiPassthrough)
    {
        Ret = HI_DRV_MMZ_Alloc("AO_MAipHdmiRaw", MMZ_OTHERS, AO_TRACK_HBR_BUFSIZE_BYTE_MAX, AIAO_BUFFER_ADDR_ALIGN,
                               &pCard->stTrackRbfMmz[SND_AIP_TYPE_HDMI_RAW]);
        if (HI_SUCCESS != Ret)
        {
            HI_ERR_AO("HI_DRV_MMZ_Alloc(AO_MAipHdmiRaw) failed\n");
            goto ALLOCATE_MAIPHDMIRAW_ERR;
        }

        Ret = HI_DRV_MMZ_MapCache(&pCard->stTrackRbfMmz[SND_AIP_TYPE_HDMI_RAW]);
        if (HI_SUCCESS != Ret)
        {
            HI_ERR_AO("HI_DRV_MMZ_MapCache(AO_MAipHdmiRaw) failed\n");
            goto MAPCACHE_MAIPHDMIRAW_ERR;
        }
    }
    return HI_SUCCESS;

MAPCACHE_MAIPHDMIRAW_ERR:
    if (SND_HDMI_MODE_NONE != pCard->enHdmiPassthrough)
    {
        HI_DRV_MMZ_Release(&pCard->stTrackRbfMmz[SND_AIP_TYPE_HDMI_RAW]);
    }
ALLOCATE_MAIPHDMIRAW_ERR:
    if (SND_SPDIF_MODE_NONE != pCard->enSpdifPassthrough)
    {
        HI_DRV_MMZ_Unmap(&pCard->stTrackRbfMmz[SND_AIP_TYPE_SPDIF_RAW]);
    }
MAPCACHE_MAIPSPDRAW_ERR:
    if (SND_SPDIF_MODE_NONE != pCard->enSpdifPassthrough)
    {
        HI_DRV_MMZ_Release(&pCard->stTrackRbfMmz[SND_AIP_TYPE_SPDIF_RAW]);
    }
ALLOCATE_MAIPSPDRAW_ERR:

#ifdef DRV_SND_AD_OUTPUT_SUPPORT
    HI_DRV_MMZ_Unmap(&pCard->stTrackRbfMmz[SND_AIP_TYPE_ASSOC_PCM]);
MAPCACHE_MAIPASSOCPCM_ERR:
    HI_DRV_MMZ_Release(&pCard->stTrackRbfMmz[SND_AIP_TYPE_ASSOC_PCM]);
ALLOCATE_MAIPASSOCPCM_ERR:
#endif

#ifdef DRV_SND_MULTICH_AEF_SUPPORT
    HI_DRV_MMZ_Unmap(&pCard->stTrackRbfMmz[SND_AIP_TYPE_MC_PCM]);
MAPCACHE_MAIPMCPCM_ERR:
    HI_DRV_MMZ_Release(&pCard->stTrackRbfMmz[SND_AIP_TYPE_MC_PCM]);
ALLOCATE_MAIPMCPCM_ERR:
#endif

    HI_DRV_MMZ_Unmap(&pCard->stTrackRbfMmz[SND_AIP_TYPE_PCM]);
MAPCACHE_MAIPPCM_ERR:
    HI_DRV_MMZ_Release(&pCard->stTrackRbfMmz[SND_AIP_TYPE_PCM]);
ALLOCATE_MAIPPCM_ERR:

    return HI_FAILURE;
}

static HI_VOID   AOReleaseCacheAipBuf(SND_CARD_STATE_S* pCard)
{
    HI_DRV_MMZ_Unmap(&pCard->stTrackRbfMmz[SND_AIP_TYPE_PCM]);
    HI_DRV_MMZ_Release(&pCard->stTrackRbfMmz[SND_AIP_TYPE_PCM]);

#ifdef DRV_SND_AD_OUTPUT_SUPPORT
    HI_DRV_MMZ_Unmap(&pCard->stTrackRbfMmz[SND_AIP_TYPE_ASSOC_PCM]);
    HI_DRV_MMZ_Release(&pCard->stTrackRbfMmz[SND_AIP_TYPE_ASSOC_PCM]);
#endif

#ifdef DRV_SND_MULTICH_AEF_SUPPORT
    HI_DRV_MMZ_Unmap(&pCard->stTrackRbfMmz[SND_AIP_TYPE_MC_PCM]);
    HI_DRV_MMZ_Release(&pCard->stTrackRbfMmz[SND_AIP_TYPE_MC_PCM]);
#endif

    if (SND_SPDIF_MODE_NONE != pCard->enSpdifPassthrough)
    {
        HI_DRV_MMZ_Unmap(&pCard->stTrackRbfMmz[SND_AIP_TYPE_SPDIF_RAW]);
        HI_DRV_MMZ_Release(&pCard->stTrackRbfMmz[SND_AIP_TYPE_SPDIF_RAW]);
    }

    if (SND_HDMI_MODE_NONE != pCard->enHdmiPassthrough)
    {
        HI_DRV_MMZ_Unmap(&pCard->stTrackRbfMmz[SND_AIP_TYPE_HDMI_RAW]);
        HI_DRV_MMZ_Release(&pCard->stTrackRbfMmz[SND_AIP_TYPE_HDMI_RAW]);
    }

    return;
}

#else

static HI_S32 AOAllocNoCacheAipBuf(SND_CARD_STATE_S* pCard)
{
    HI_S32 Ret = HI_SUCCESS;

    Ret = HI_DRV_MMZ_AllocAndMap("AO_MAipPcm", MMZ_OTHERS, AO_TRACK_PCM_BUFSIZE_BYTE_MAX, AIAO_BUFFER_ADDR_ALIGN,
                                 &pCard->stTrackRbfMmz[SND_AIP_TYPE_PCM]);
    if (HI_SUCCESS != Ret)
    {
        HI_ERR_AO("MMZ_AllocAndMap(AO_MAipPcm) failed\n");
        goto ALLOCATE_MAIPPCM_ERR;
    }

#ifdef DRV_SND_MULTICH_AEF_SUPPORT
    Ret = HI_DRV_MMZ_AllocAndMap("AO_MAipMcPcm", MMZ_OTHERS, AO_TRACK_HBR_BUFSIZE_BYTE_MAX, AIAO_BUFFER_ADDR_ALIGN,
                                 &pCard->stTrackRbfMmz[SND_AIP_TYPE_MC_PCM]);
    if (HI_SUCCESS != Ret)
    {
        HI_ERR_AO("MMZ_AllocAndMap(AO_MAipMcPcm) failed\n");
        goto ALLOCATE_MAIPMCPCM_ERR;
    }
#endif

#ifdef DRV_SND_AD_OUTPUT_SUPPORT
    Ret = HI_DRV_MMZ_AllocAndMap("AO_MAipAssocPcm", MMZ_OTHERS, AO_TRACK_PCM_BUFSIZE_BYTE_MAX, AIAO_BUFFER_ADDR_ALIGN,
                                 &pCard->stTrackRbfMmz[SND_AIP_TYPE_ASSOC_PCM]);
    if (HI_SUCCESS != Ret)
    {
        HI_ERR_AO("MMZ_AllocAndMap(AO_MAipAssocPcm) failed\n");
        goto ALLOCATE_MAIPASSOCPCM_ERR;
    }
#endif

    if (SND_SPDIF_MODE_NONE != pCard->enSpdifPassthrough)
    {
        Ret = HI_DRV_MMZ_AllocAndMap("AO_MAipSpdRaw", MMZ_OTHERS, AO_TRACK_LBR_BUFSIZE_BYTE_MAX, AIAO_BUFFER_ADDR_ALIGN,
                                     &pCard->stTrackRbfMmz[SND_AIP_TYPE_SPDIF_RAW]);
        if (HI_SUCCESS != Ret)
        {
            HI_ERR_AO("MMZ_AllocAndMap(AO_MAipSpdRaw) failed\n");
            goto ALLOCATE_MAIPSPDRAW_ERR;
        }
    }

    if (SND_HDMI_MODE_NONE != pCard->enHdmiPassthrough)
    {
        Ret = HI_DRV_MMZ_AllocAndMap("AO_MAipHdmiRaw", MMZ_OTHERS, AO_TRACK_HBR_BUFSIZE_BYTE_MAX, AIAO_BUFFER_ADDR_ALIGN,
                                     &pCard->stTrackRbfMmz[SND_AIP_TYPE_HDMI_RAW]);
        if (HI_SUCCESS != Ret)
        {
            HI_ERR_AO("MMZ_AllocAndMap(AO_MAipHdmiRaw) failed\n");
            goto ALLOCATE_MAIPHDMIRAW_ERR;
        }
    }

    return HI_SUCCESS;

ALLOCATE_MAIPHDMIRAW_ERR:
    if (SND_SPDIF_MODE_NONE != pCard->enSpdifPassthrough)
    {
        HI_DRV_MMZ_UnmapAndRelease(&pCard->stTrackRbfMmz[SND_AIP_TYPE_SPDIF_RAW]);
    }

ALLOCATE_MAIPSPDRAW_ERR:
#ifdef DRV_SND_AD_OUTPUT_SUPPORT
    HI_DRV_MMZ_UnmapAndRelease(&pCard->stTrackRbfMmz[SND_AIP_TYPE_ASSOC_PCM]);
ALLOCATE_MAIPASSOCPCM_ERR:
#endif

#ifdef DRV_SND_MULTICH_AEF_SUPPORT
    HI_DRV_MMZ_UnmapAndRelease(&pCard->stTrackRbfMmz[SND_AIP_TYPE_MC_PCM]);
ALLOCATE_MAIPMCPCM_ERR:
#endif

    HI_DRV_MMZ_UnmapAndRelease(&pCard->stTrackRbfMmz[SND_AIP_TYPE_PCM]);
ALLOCATE_MAIPPCM_ERR:

    return HI_FAILURE;
}

static HI_VOID   AOReleaseNoCacheAipBuf(SND_CARD_STATE_S* pCard)
{
    HI_DRV_MMZ_UnmapAndRelease(&pCard->stTrackRbfMmz[SND_AIP_TYPE_PCM]);

#ifdef DRV_SND_AD_OUTPUT_SUPPORT
    HI_DRV_MMZ_UnmapAndRelease(&pCard->stTrackRbfMmz[SND_AIP_TYPE_ASSOC_PCM]);
#endif

#ifdef DRV_SND_MULTICH_AEF_SUPPORT
    HI_DRV_MMZ_UnmapAndRelease(&pCard->stTrackRbfMmz[SND_AIP_TYPE_MC_PCM]);
#endif

    if (SND_SPDIF_MODE_NONE != pCard->enSpdifPassthrough)
    {
        HI_DRV_MMZ_UnmapAndRelease(&pCard->stTrackRbfMmz[SND_AIP_TYPE_SPDIF_RAW]);
    }

    if (SND_HDMI_MODE_NONE != pCard->enHdmiPassthrough)
    {
        HI_DRV_MMZ_UnmapAndRelease(&pCard->stTrackRbfMmz[SND_AIP_TYPE_HDMI_RAW]);
    }

    return;
}
#endif

HI_S32 AO_SND_Open( HI_UNF_SND_E enSound, DRV_SND_ATTR_S* pstAttr,
                    AO_ALSA_I2S_Param_S* pstAoI2sParam, HI_BOOL bResume)//pstAoI2sParam is i2s only param
{
    HI_S32 Ret = HI_SUCCESS;
    HI_U32 i;
    //HI_U32 u32PortFlag = 0;
    HDMI_AUDIO_ATTR_S stHDMIAttr;
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    // check attr
    CHECK_AO_SNDCARD( enSound );
    CHECK_AO_PORTNUM( pstAttr->u32PortNum );
    CHECK_AO_SAMPLERATE( pstAttr->enSampleRate );
    memset(pCard, 0, sizeof(SND_CARD_STATE_S));

    pCard->enPcmOutput  = SND_PCM_OUTPUT_VIR_SPDIFORHDMI;
    pCard->enHdmiPassthrough = SND_HDMI_MODE_NONE;
    pCard->enSpdifPassthrough = SND_SPDIF_MODE_NONE;
    pCard->bHdmiDebug = HI_FALSE;
    //pCard->bCastSimulateOp = HI_FALSE;

#if (1 == HI_PROC_SUPPORT)
    pCard->enSaveState   = SND_DEBUG_CMD_CTRL_STOP;
    pCard->u32SaveCnt    = 0;
    pCard->pstFileHandle = HI_NULL;
#endif

#if 0
    pCard->bAllTrackMute = HI_FALSE;
    pCard->bAllCastMute = HI_FALSE;

    AOGetDefAvcAttr(&pCard->stAvcAttr);
    AOGetDefGeqAttr(&pCard->stGeqAttr);
    pCard->bGeqEnable = HI_FALSE;
    pCard->bAvcEnable = HI_FALSE;
#endif

    for (i = 0; i < pstAttr->u32PortNum; i++)
    {
#if 0  // dpt
        if (pstAttr->stOutport[i].enOutPort >= HI_UNF_SND_OUTPUTPORT_EXT_DAC1)
        {
            u32PortFlag |= (HI_U32)0x10000 << (pstAttr->stOutport[i].enOutPort & 0xf);
        }
        else
        {
            u32PortFlag |= (HI_U32)1 << pstAttr->stOutport[i].enOutPort;
        }
#if defined (CHIP_TYPE_hi3751v600) || defined (CHIP_TYPE_hi3751lv500)
        if ((u32PortFlag & ((HI_U32)1 << HI_UNF_SND_OUTPUTPORT_DAC0)) && (u32PortFlag & ((HI_U32)1 << HI_UNF_SND_OUTPUTPORT_I2S1)))
        {
            HI_ERR_AO("I2S1 and DAC0 can not coexist!\n");
            return HI_FAILURE;
        }
#endif

#if defined (CHIP_TYPE_hi3751av500)
        if ((u32PortFlag & ((HI_U32)0x10000 << (HI_UNF_SND_OUTPUTPORT_EXT_DAC2 & 0xf))) && (u32PortFlag & ((HI_U32)1 << HI_UNF_SND_OUTPUTPORT_I2S1)))
        {
            HI_ERR_AO("I2S1 and DAC2 can not coexist!\n");
            return HI_FAILURE;
        }
#endif
#endif
        if (HI_FALSE == AOCheckOutPortIsValid(pstAttr->stOutport[i].enOutPort))
        {
            HI_ERR_AO("port(%d) is invalid.\n", pstAttr->stOutport[i].enOutPort);
            return HI_FAILURE;
        }

        if (HI_TRUE == AOCheckOutPortIsAttached(enSound, pstAttr->stOutport[i].enOutPort))
        {
            HI_ERR_AO("port(%d) is aready attatched.\n", pstAttr->stOutport[i].enOutPort);
            return HI_FAILURE;
        }

        if (HI_UNF_SND_OUTPUTPORT_HDMI0 == pstAttr->stOutport[i].enOutPort)
        {
            /* Get hdmi functions */
            Ret = HI_DRV_MODULE_GetFunction(HI_ID_HDMI, (HI_VOID**)&pCard->pstHdmiFunc);
            if (HI_SUCCESS != Ret)
            {
                HI_ERR_AO("Get hdmi function err:%#x!\n", Ret);
                return Ret;
            }

            if(pCard->pstHdmiFunc && pCard->pstHdmiFunc->pfnHdmiSetAudioMute)
            {
                (pCard->pstHdmiFunc->pfnHdmiSetAudioMute)(HI_UNF_HDMI_ID_0);
            }            

            if(pCard->pstHdmiFunc && pCard->pstHdmiFunc->pfnHdmiGetAoAttr)
            {
                (pCard->pstHdmiFunc->pfnHdmiGetAoAttr)(HI_UNF_HDMI_ID_0, &stHDMIAttr);
            }

            stHDMIAttr.enSoundIntf  = HDMI_AUDIO_INTERFACE_I2S;
            stHDMIAttr.enSampleRate = HI_UNF_SAMPLE_RATE_48K;
            stHDMIAttr.u32Channels  = AO_TRACK_NORMAL_CHANNELNUM;
            /*get the capability of the max pcm channels of the output device*/
            if (pCard->pstHdmiFunc && pCard->pstHdmiFunc->pfnHdmiAudioChange)
            {
                (pCard->pstHdmiFunc->pfnHdmiAudioChange)(HI_UNF_HDMI_ID_0, &stHDMIAttr);
            }

            pCard->enHdmiPassthrough = SND_HDMI_MODE_PCM;
        }

        else if(HI_UNF_SND_OUTPUTPORT_SPDIF0 == pstAttr->stOutport[i].enOutPort)
        {
            pCard->enSpdifPassthrough = SND_SPDIF_MODE_PCM;
        }

        else if(HI_UNF_SND_OUTPUTPORT_DAC0 == pstAttr->stOutport[i].enOutPort
            || HI_UNF_SND_OUTPUTPORT_EXT_DAC1 == pstAttr->stOutport[i].enOutPort
            || HI_UNF_SND_OUTPUTPORT_EXT_DAC2 == pstAttr->stOutport[i].enOutPort
            || HI_UNF_SND_OUTPUTPORT_EXT_DAC3 == pstAttr->stOutport[i].enOutPort
            || HI_UNF_SND_OUTPUTPORT_I2S0 == pstAttr->stOutport[i].enOutPort
            || HI_UNF_SND_OUTPUTPORT_I2S1 == pstAttr->stOutport[i].enOutPort)
        {
            pCard->enPcmOutput  = SND_PCM_OUTPUT_CERTAIN;
        }
        else
        {
            HI_INFO_AO("SND_OUTPUTPORT Invalid!\n");
            //return HI_FAILURE;
        }

        /* I2S pcm mode only support mono output */
        if (HI_UNF_SND_OUTPUTPORT_I2S0 == pstAttr->stOutport[i].enOutPort
            || HI_UNF_SND_OUTPUTPORT_I2S1 == pstAttr->stOutport[i].enOutPort)
        {
            if (pstAttr->stOutport[i].unAttr.stI2sAttr.stAttr.enI2sMode == HI_UNF_I2S_PCM_MODE
                && pstAttr->stOutport[i].unAttr.stI2sAttr.stAttr.enChannel != HI_UNF_I2S_CHNUM_1)
            {
                HI_ERR_AO("I2S PCM MODE only supprt mono output!\n");
                return HI_FAILURE;
            }
        }

    }

    Ret = SND_CreateOp(pCard, pstAttr, pstAoI2sParam, bResume);
    if (HI_SUCCESS != Ret)
    {
        HI_ERR_AO( "Create snd op failed!" );
        goto CREATE_OP_ERR_EXIT;
    }

#ifndef HI_SND_AOE_HW_SUPPORT
    Ret = AOAllocCacheAipBuf(pCard);
#else
    Ret = AOAllocNoCacheAipBuf(pCard);
#endif
    if (HI_SUCCESS != Ret)
    {
        HI_ERR_AO( "AO Alloc Aip Buf failed!" );
        goto ALLOC_AIPBUF_ERR_EXIT;
    }

#if (1 == HI_PROC_SUPPORT)
    AO_RegProc((HI_U32)enSound);
#endif
    return HI_SUCCESS;

ALLOC_AIPBUF_ERR_EXIT:
    SND_DestroyOp(pCard, HI_FALSE);
CREATE_OP_ERR_EXIT:
    return HI_FAILURE;
}

HI_S32 AO_SND_Close(HI_UNF_SND_E enSound, HI_BOOL bSuspend)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);
#if (1 == HI_PROC_SUPPORT)
    AO_UnRegProc((HI_U32)enSound);
#endif
#ifndef HI_SND_AOE_HW_SUPPORT
    AOReleaseCacheAipBuf(pCard);
#else
    AOReleaseNoCacheAipBuf(pCard);
#endif

    SND_DestroyOp(pCard, bSuspend);
#if 0
    AEF_DestroyDebugAddr(pCard);
#endif
    TRACK_DestroyEngine(pCard);

    return HI_SUCCESS;
}

HI_S32 AO_SND_SetMute(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort, HI_BOOL bMute)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_OUTPORT(enOutPort);
    CHECK_AO_NULL_PTR(pCard);
    CHECK_AO_PORTEXIST(pCard->stUserOpenParam.u32PortNum);

    return SND_SetOpMute(pCard, enOutPort, bMute);
}

HI_S32 AO_SND_GetMute(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort, HI_BOOL *pbMute)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_OUTPORT(enOutPort);
    CHECK_AO_NULL_PTR(pbMute);
    CHECK_AO_NULL_PTR(pCard);
    CHECK_AO_PORTEXIST(pCard->stUserOpenParam.u32PortNum);

    return SND_GetOpMute(pCard, enOutPort, pbMute);
}

static HI_S32 AO_SND_SetHdmiMode(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort, HI_UNF_SND_HDMI_MODE_E enMode)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_OUTPORT(enOutPort);
    CHECK_AO_HDMIMODE(enMode);
    CHECK_AO_NULL_PTR(pCard);
    CHECK_AO_PORTEXIST(pCard->stUserOpenParam.u32PortNum);

    return SND_SetOpHdmiMode(pCard, enOutPort, enMode);
}

static HI_S32 AO_SND_GetHdmiMode(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort, HI_UNF_SND_HDMI_MODE_E* penMode)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_OUTPORT(enOutPort);
    CHECK_AO_NULL_PTR(penMode);
    CHECK_AO_NULL_PTR(pCard);
    CHECK_AO_PORTEXIST(pCard->stUserOpenParam.u32PortNum);

    return SND_GetOpHdmiMode(pCard, enOutPort, penMode);
}

static HI_S32 AO_SND_SetSpdifMode(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort, HI_UNF_SND_SPDIF_MODE_E enMode)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_OUTPORT(enOutPort);
    CHECK_AO_SPDIFMODE(enMode);
    CHECK_AO_NULL_PTR(pCard);
    CHECK_AO_PORTEXIST(pCard->stUserOpenParam.u32PortNum);

    return SND_SetOpSpdifMode(pCard, enOutPort, enMode);
}

static HI_S32 AO_SND_GetSpdifMode(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort, HI_UNF_SND_SPDIF_MODE_E* penMode)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_OUTPORT(enOutPort);
    CHECK_AO_NULL_PTR(penMode);
    CHECK_AO_NULL_PTR(pCard);
    CHECK_AO_PORTEXIST(pCard->stUserOpenParam.u32PortNum);

    return SND_GetOpSpdifMode(pCard, enOutPort, penMode);
}

#if 0  // dpt
static HI_S32 AO_SND_SetArcEnable(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort, HI_BOOL bEnable)
{
    SND_CARD_STATE_S *pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_OUTPORT(enOutPort);
    CHECK_AO_NULL_PTR(pCard);
    CHECK_AO_PORTEXIST(pCard->stUserOpenParam.u32PortNum);

    return SND_SetOpArcEnable(pCard, enOutPort, bEnable);
}

static HI_S32 AO_SND_GetArcEnable(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort, HI_BOOL *pbEnable)
{
    SND_CARD_STATE_S *pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_OUTPORT(enOutPort);
    CHECK_AO_NULL_PTR(pbEnable);
    CHECK_AO_NULL_PTR(pCard);
    CHECK_AO_PORTEXIST(pCard->stUserOpenParam.u32PortNum);

    return SND_GetOpArcEnable(pCard, enOutPort, pbEnable);
}

static HI_S32 AO_SND_SetArcMode(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort, HI_UNF_SND_ARC_AUDIO_MODE_E enMode)
{
    SND_CARD_STATE_S *pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_OUTPORT(enOutPort);
    CHECK_AO_ARCMODE(enMode);
    CHECK_AO_NULL_PTR(pCard);
    CHECK_AO_PORTEXIST(pCard->stUserOpenParam.u32PortNum);

    return SND_SetOpArcMode(pCard, enOutPort, enMode);
}

static HI_S32 AO_SND_GetArcMode(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort, HI_UNF_SND_ARC_AUDIO_MODE_E *penMode)
{
    SND_CARD_STATE_S *pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_OUTPORT(enOutPort);
    CHECK_AO_NULL_PTR(penMode);
    CHECK_AO_NULL_PTR(pCard);
    CHECK_AO_PORTEXIST(pCard->stUserOpenParam.u32PortNum);

    return SND_GetOpArcMode(pCard, enOutPort, penMode);
}

static HI_S32 AO_SND_SetArcCap(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort, HI_UNF_SND_ARC_AUDIO_CAP_S stCap)
{
    SND_CARD_STATE_S *pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_OUTPORT(enOutPort);
    CHECK_AO_NULL_PTR(pCard);
    CHECK_AO_PORTEXIST(pCard->stUserOpenParam.u32PortNum);

    return SND_SetOpArcCap(pCard, enOutPort, stCap);
}

static HI_S32 AO_SND_GetArcCap(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort, HI_UNF_SND_ARC_AUDIO_CAP_S *pstCap)
{
    SND_CARD_STATE_S *pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_OUTPORT(enOutPort);
    CHECK_AO_NULL_PTR(pstCap);
    CHECK_AO_NULL_PTR(pCard);
    CHECK_AO_PORTEXIST(pCard->stUserOpenParam.u32PortNum);

    return SND_GetOpArcCap(pCard, enOutPort, pstCap);
}
#endif

HI_S32 AO_SND_SetVolume(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort, HI_UNF_SND_GAIN_ATTR_S stGain)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_OUTPORT(enOutPort);
    if (HI_TRUE == stGain.bLinearMode)
    {
        CHECK_AO_LINEARVOLUME(stGain.s32Gain);
    }
    else
    {
        CHECK_AO_ABSLUTEVOLUME(stGain.s32Gain);
    }
    CHECK_AO_NULL_PTR(pCard);
    CHECK_AO_PORTEXIST(pCard->stUserOpenParam.u32PortNum);

    return SND_SetOpVolume(pCard, enOutPort, stGain);
}

static HI_S32 AO_SND_GetVolume(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort, HI_UNF_SND_GAIN_ATTR_S* pstGain)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_OUTPORT(enOutPort);
    CHECK_AO_NULL_PTR(pstGain);
    CHECK_AO_NULL_PTR(pCard);
    CHECK_AO_PORTEXIST(pCard->stUserOpenParam.u32PortNum);

    // TODO: Check volumn Attr

    return SND_GetOpVolume(pCard, enOutPort, pstGain);
}

static HI_S32 AO_SND_SetSpdifCategoryCode(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort,
        HI_UNF_SND_SPDIF_CATEGORYCODE_E enCategoryCode)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);
    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_OUTPORT(enOutPort);
    CHECK_AO_CATEGORYCODE(enCategoryCode);
    CHECK_AO_NULL_PTR(pCard);
    CHECK_AO_PORTEXIST(pCard->stUserOpenParam.u32PortNum);
    return SND_SetOpSpdifCategoryCode(pCard, enOutPort, enCategoryCode);
}

static HI_S32 AO_SND_GetSpdifCategoryCode(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort,
        HI_UNF_SND_SPDIF_CATEGORYCODE_E* penCategoryCode)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);
    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_OUTPORT(enOutPort);
    CHECK_AO_NULL_PTR(penCategoryCode);
    CHECK_AO_NULL_PTR(pCard);
    CHECK_AO_PORTEXIST(pCard->stUserOpenParam.u32PortNum);
    return SND_GetOpSpdifCategoryCode(pCard, enOutPort, penCategoryCode);
}

static HI_S32 AO_SND_SetSpdifSCMSMode(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort,
                                      HI_UNF_SND_SPDIF_SCMSMODE_E enSCMSMode)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_OUTPORT(enOutPort);
    CHECK_AO_SPDIFSCMSMODE(enSCMSMode);
    CHECK_AO_NULL_PTR(pCard);
    CHECK_AO_PORTEXIST(pCard->stUserOpenParam.u32PortNum);

    return SND_SetOpSpdifSCMSMode(pCard, enOutPort, enSCMSMode);
}

static HI_S32 AO_SND_GetSpdifSCMSMode(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort,
                                      HI_UNF_SND_SPDIF_SCMSMODE_E* penSCMSMode)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_OUTPORT(enOutPort);
    CHECK_AO_NULL_PTR(penSCMSMode);
    CHECK_AO_NULL_PTR(pCard);
    CHECK_AO_PORTEXIST(pCard->stUserOpenParam.u32PortNum);

    return SND_GetOpSpdifSCMSMode(pCard, enOutPort, penSCMSMode);
}

//zgjiere; HAL_AIAO_P_SetSampleRate 不能动态修改，建议HI_UNF_SND_ATTR_S确定
static HI_S32 AO_SND_SetSampleRate(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort,
                                   HI_UNF_SAMPLE_RATE_E enSampleRate)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_OUTPORT(enOutPort);
    CHECK_AO_SAMPLERATE(enSampleRate);
    CHECK_AO_NULL_PTR(pCard);

    return SND_SetOpSampleRate(pCard, enOutPort, enSampleRate);
}

static HI_S32 AO_SND_GetSampleRate(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort,
                                   HI_UNF_SAMPLE_RATE_E* penSampleRate)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_OUTPORT(enOutPort);
    CHECK_AO_NULL_PTR(penSampleRate);
    CHECK_AO_NULL_PTR(pCard);

    return SND_GetOpSampleRate(pCard, enOutPort, penSampleRate);
}

static HI_S32 AO_SND_SetTrackMode(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort, HI_UNF_TRACK_MODE_E enMode)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_OUTPORT(enOutPort);
    CHECK_AO_TRACKMODE(enMode);
    CHECK_AO_NULL_PTR(pCard);
    CHECK_AO_PORTEXIST(pCard->stUserOpenParam.u32PortNum);

    return SND_SetOpTrackMode(pCard, enOutPort, enMode);
}

static HI_S32 AO_SND_GetTrackMode(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort, HI_UNF_TRACK_MODE_E* penMode)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_OUTPORT(enOutPort);
    CHECK_AO_NULL_PTR(penMode);
    CHECK_AO_NULL_PTR(pCard);
    CHECK_AO_PORTEXIST(pCard->stUserOpenParam.u32PortNum);

    return SND_GetOpTrackMode(pCard, enOutPort, penMode);
}

#ifdef HI_SOUND_SPDIF_COMPENSATION_SUPPORT
static HI_S32 AO_SND_SetDelayCompensation(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort, HI_U32 u32DelayMs)
{
    HI_S32 s32Ret;
    SND_CARD_STATE_S *pCard = SND_CARD_GetCard(enSound);
    CHECK_AO_NULL_PTR(pCard);

    if (u32DelayMs > AO_MAX_DELAYMS)
    {
        HI_ERR_AO("Invalid u32DelayMs(%d),Max(%d)\n", u32DelayMs, AO_MAX_DELAYMS);
        return HI_FAILURE;
    }

    s32Ret = SND_SetDelayCompensation(pCard, enOutPort, u32DelayMs, HI_TRUE);
    if(HI_SUCCESS != s32Ret)
    {
       HI_ERR_AO("SetDelayCompensation port %d,delayms %d failed\n",enOutPort,u32DelayMs); 
    }    
    return s32Ret;
}

static HI_S32 AO_SND_GetDelayCompensation(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort, HI_U32 *pu32DelayMs)
{
    HI_S32 s32Ret;
    SND_CARD_STATE_S *pCard = SND_CARD_GetCard(enSound);
    CHECK_AO_NULL_PTR(pCard);
    
    s32Ret = SND_GetDelayCompensation(pCard, enOutPort, pu32DelayMs);
    if(HI_SUCCESS != s32Ret)
    {
        HI_ERR_AO("GetDelayCompensation port %d failed\n",enOutPort); 
    }    
    return s32Ret;
}
#endif

static HI_S32 AO_SND_SetAllTrackMute(HI_UNF_SND_E enSound, HI_BOOL bMute)
{
    HI_S32 s32Ret;
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);
    CHECK_AO_NULL_PTR(pCard);

    s32Ret = TRACK_SetAllMute(pCard, bMute);
    if (HI_SUCCESS != s32Ret)
    {
        // TODO:
    }

    pCard->bAllTrackMute = bMute;
    HI_INFO_AO("Track ALL get Mute Staues %d\n", pCard->bAllTrackMute);

    return s32Ret;
}

static HI_S32 AO_SND_GetAllTrackMute(HI_UNF_SND_E enSound, HI_BOOL* pbMute)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_NULL_PTR(pbMute);
    CHECK_AO_NULL_PTR(pCard);

    *pbMute = pCard->bAllTrackMute;
    return HI_SUCCESS;
}

static HI_S32  AO_SND_SetSmartVolume(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort, HI_BOOL bSmartVolume)
{
    // TODO:
    //verify
    return HI_SUCCESS;
}

static HI_S32 AO_SND_GetSmartVolume(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort, HI_BOOL* pbSmartVolume)
{
    // TODO:
    //verify
    return HI_SUCCESS;
}

static HI_S32 AO_Snd_SetLowLatency(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E eOutPort, HI_U32 u32LatencyMs)
{
    SND_CARD_STATE_S *pCard = SND_CARD_GetCard(enSound);
    CHECK_AO_NULL_PTR(pCard);

    return  SND_SetLowLatency(pCard, eOutPort, u32LatencyMs);
}

static HI_S32 AO_Snd_GetLowLatency(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E eOutPort, HI_U32* pu32LatencyMs)
{
    SND_CARD_STATE_S *pCard = SND_CARD_GetCard(enSound);
    CHECK_AO_NULL_PTR(pCard);

    return  SND_GetLowLatency(pCard,eOutPort,pu32LatencyMs);
}

static HI_S32 AO_Snd_SetExtDelayMs(HI_UNF_SND_E enSound, HI_U32 u32DelayMs)
{
    SND_CARD_STATE_S *pCard = SND_CARD_GetCard(enSound);
    CHECK_AO_NULL_PTR(pCard);
    return SND_SetExtDelayMs(pCard, u32DelayMs);
}

#if 0
static HI_S32 AO_SND_SetPreciVol(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort, HI_UNF_SND_PRECIGAIN_ATTR_S stPreciGain)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_OUTPORT(enOutPort);
    CHECK_AO_ABSLUTEPRECIVOLUME(stPreciGain.s32IntegerGain, stPreciGain.s32DecimalGain);
    CHECK_AO_NULL_PTR(pCard);
    CHECK_AO_PORTEXIST(pCard->stUserOpenParam.u32PortNum);

    return SND_SetOpPreciVol(pCard, enOutPort, stPreciGain);
}

static HI_S32 AO_SND_GetPreciVol(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort, HI_UNF_SND_PRECIGAIN_ATTR_S* pstPreciGain)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_OUTPORT(enOutPort);
    CHECK_AO_NULL_PTR(pstPreciGain);
    CHECK_AO_NULL_PTR(pCard);
    CHECK_AO_PORTEXIST(pCard->stUserOpenParam.u32PortNum);

    return SND_GetOpPreciVol(pCard, enOutPort, pstPreciGain);
}

static HI_S32 AO_SND_SetBalance(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort, HI_S32 s32Balance)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_OUTPORT(enOutPort);
    CHECK_AO_BALANCE(s32Balance);
    CHECK_AO_NULL_PTR(pCard);
    CHECK_AO_PORTEXIST(pCard->stUserOpenParam.u32PortNum);

    return SND_SetOpBalance(pCard, enOutPort, s32Balance);
}

static HI_S32 AO_SND_GetBalance(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort, HI_S32* ps32Balance)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_OUTPORT(enOutPort);
    CHECK_AO_NULL_PTR(ps32Balance);
    CHECK_AO_NULL_PTR(pCard);
    CHECK_AO_PORTEXIST(pCard->stUserOpenParam.u32PortNum);

    return SND_GetOpBalance(pCard, enOutPort, ps32Balance);
}

static HI_S32 AO_SND_SetDrcEnable(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort,  HI_BOOL bEnable)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_OUTPORT(enOutPort);
    CHECK_AO_NULL_PTR(pCard);
    CHECK_AO_PORTEXIST(pCard->stUserOpenParam.u32PortNum);

    return SND_SetOpDrcEnable(pCard, enOutPort, bEnable);
}

static HI_S32 AO_SND_GetDrcEnable(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort, HI_BOOL* pbEnable)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_OUTPORT(enOutPort);
    CHECK_AO_NULL_PTR(pCard);
    CHECK_AO_PORTEXIST(pCard->stUserOpenParam.u32PortNum);

    return SND_GetOpDrcEnable(pCard, enOutPort, pbEnable);
}

static HI_S32 AO_SND_SetDrcAttr(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort, HI_UNF_SND_DRC_ATTR_S* pstDrcAttr)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_OUTPORT(enOutPort);
    CHECK_AO_NULL_PTR(pstDrcAttr);
    CHECK_AO_NULL_PTR(pCard);
    CHECK_AO_DRCATTR(pstDrcAttr);
    CHECK_AO_PORTEXIST(pCard->stUserOpenParam.u32PortNum);

    return SND_SetOpDrcAttr(pCard, enOutPort, pstDrcAttr);
}

static HI_S32 AO_SND_GetDrcAttr(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort, HI_UNF_SND_DRC_ATTR_S* pstDrcAttr)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_OUTPORT(enOutPort);
    CHECK_AO_NULL_PTR(pstDrcAttr);
    CHECK_AO_NULL_PTR(pCard);
    CHECK_AO_PORTEXIST(pCard->stUserOpenParam.u32PortNum);

    return SND_GetOpDrcAttr(pCard, enOutPort, pstDrcAttr);
}

static HI_S32 AO_Check_PeqAttr(HI_UNF_SND_PEQ_ATTR_S* pstPeqAttr)
{
    HI_U32 i;
    if ((pstPeqAttr->u32BandNum < 1) || (pstPeqAttr->u32BandNum > 10))
    {
        HI_ERR_AO("Invalid Peq BandNum! bandnum(%d)!\n", pstPeqAttr->u32BandNum);
        return HI_ERR_AO_INVALID_PARA;
    }

    for (i = 0; i < pstPeqAttr->u32BandNum; i++)
    {
        switch (pstPeqAttr->stEqParam[i].enFltType)
        {
            case HI_UNF_PEQ_FILTER_TYPE_HP:
                if ((pstPeqAttr->stEqParam[i].u32Q != 7))
                {
                    HI_ERR_AO("Invalid Q value %d\n", pstPeqAttr->stEqParam[i].u32Q);

                    return HI_ERR_AO_INVALID_PARA;
                }

                if ((pstPeqAttr->stEqParam[i].u32freq < 20) || (pstPeqAttr->stEqParam[i].u32freq > 4000))
                {
                    HI_ERR_AO("Invalid Peq Gain value %d\n", pstPeqAttr->stEqParam[i].u32freq);
                    return HI_ERR_AO_INVALID_PARA;
                }

                break;

            case HI_UNF_PEQ_FILTER_TYPE_LP:
                if ((pstPeqAttr->stEqParam[i].u32Q != 7))
                {
                    HI_ERR_AO("Invalid Q value %d\n", pstPeqAttr->stEqParam[i].u32Q);

                    return HI_ERR_AO_INVALID_PARA;
                }

                if ((pstPeqAttr->stEqParam[i].u32freq < 4000) || (pstPeqAttr->stEqParam[i].u32freq > 22000))
                {
                    HI_ERR_AO("Invalid Peq Gain value %d\n", pstPeqAttr->stEqParam[i].u32freq);
                    return HI_ERR_AO_INVALID_PARA;
                }
                break;

            case HI_UNF_PEQ_FILTER_TYPE_LS:
                if ((pstPeqAttr->stEqParam[i].u32Q < 7) || (pstPeqAttr->stEqParam[i].u32Q > 10))
                {
                    HI_ERR_AO("Invalid Q value %d\n", pstPeqAttr->stEqParam[i].u32Q);

                    return HI_ERR_AO_INVALID_PARA;
                }

                if ((pstPeqAttr->stEqParam[i].u32freq < 20) || (pstPeqAttr->stEqParam[i].u32freq > 4000))
                {
                    HI_ERR_AO("Invalid Peq Gain value %d\n", pstPeqAttr->stEqParam[i].u32freq);
                    return HI_ERR_AO_INVALID_PARA;
                }

                break;

            case HI_UNF_PEQ_FILTER_TYPE_HS:
                if ((pstPeqAttr->stEqParam[i].u32Q < 7) || (pstPeqAttr->stEqParam[i].u32Q > 10))
                {
                    HI_ERR_AO("Invalid Q value %d\n", pstPeqAttr->stEqParam[i].u32Q);

                    return HI_ERR_AO_INVALID_PARA;
                }

                if ((pstPeqAttr->stEqParam[i].u32freq < 4000) || (pstPeqAttr->stEqParam[i].u32freq > 22000))
                {
                    HI_ERR_AO("Invalid Peq Gain value %d\n", pstPeqAttr->stEqParam[i].u32freq);
                    return HI_ERR_AO_INVALID_PARA;
                }

                break;

            case HI_UNF_PEQ_FILTER_TYPE_PK:
                if ((pstPeqAttr->stEqParam[i].u32Q < 5) || (pstPeqAttr->stEqParam[i].u32Q > 100))
                {
                    HI_ERR_AO("Invalid Q value %d \n", pstPeqAttr->stEqParam[i].u32Q);

                    return HI_ERR_AO_INVALID_PARA;
                }

                if ((pstPeqAttr->stEqParam[i].u32freq < 20) || (pstPeqAttr->stEqParam[i].u32freq > 22000))
                {
                    HI_ERR_AO("Invalid Peq Gain value %d\n", pstPeqAttr->stEqParam[i].u32freq);
                    return HI_ERR_AO_INVALID_PARA;
                }

                break;

            default:
                HI_ERR_AO("Invalid Filter Type %d\n", pstPeqAttr->stEqParam[i].enFltType);
                return HI_ERR_AO_INVALID_PARA;

        }

        if ((pstPeqAttr->stEqParam[i].s32Gain < -15000) || (pstPeqAttr->stEqParam[i].s32Gain > 15000) || (pstPeqAttr->stEqParam[i].s32Gain % 125))
        {
            HI_ERR_AO("Invalid Peq Gain value %d\n", pstPeqAttr->stEqParam[i].s32Gain);
            return HI_ERR_AO_INVALID_PARA;
        }
    }
    return HI_SUCCESS;
}

static HI_S32 AO_SND_SetPeqAttr(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort, HI_UNF_SND_PEQ_ATTR_S* pstPeqAttr)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_OUTPORT(enOutPort);
    CHECK_AO_NULL_PTR(pstPeqAttr);
    CHECK_AO_NULL_PTR(pCard);
    AO_Check_PeqAttr(pstPeqAttr);
    CHECK_AO_PORTEXIST(pCard->stUserOpenParam.u32PortNum);

    return SND_SetOpPeqAttr(pCard, enOutPort, pstPeqAttr);
}

static HI_S32 AO_SND_GetPeqAttr(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort, HI_UNF_SND_PEQ_ATTR_S* pstPeqAttr)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_OUTPORT(enOutPort);
    CHECK_AO_NULL_PTR(pstPeqAttr);
    CHECK_AO_NULL_PTR(pCard);
    CHECK_AO_PORTEXIST(pCard->stUserOpenParam.u32PortNum);

    return SND_GetOpPeqAttr(pCard, enOutPort, pstPeqAttr);
}

static HI_S32 AO_SND_SetPeqEnable(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort, HI_BOOL bEnable)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_OUTPORT(enOutPort);
    CHECK_AO_NULL_PTR(pCard);
    CHECK_AO_PORTEXIST(pCard->stUserOpenParam.u32PortNum);

    return SND_SetOpPeqEnable(pCard, enOutPort, bEnable);
}

static HI_S32 AO_SND_GetPeqEnable(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort, HI_BOOL* pbEnable)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_OUTPORT(enOutPort);
    CHECK_AO_NULL_PTR(pCard);
    CHECK_AO_PORTEXIST(pCard->stUserOpenParam.u32PortNum);

    return SND_GetOpPeqEnable(pCard, enOutPort, pbEnable);
}

static HI_S32 AO_Check_AvcAttr(HI_UNF_SND_AVC_ATTR_S* pstAvcAttr)
{      
    if((pstAvcAttr->u32AttackTime < 20) || (pstAvcAttr->u32ReleaseTime< 20)
      || (pstAvcAttr->u32AttackTime > 2000) || (pstAvcAttr->u32ReleaseTime > 2000)
      || (pstAvcAttr->s32ThresholdLevel < -39) || (pstAvcAttr->s32ThresholdLevel > -17)
      || (pstAvcAttr->s32Gain < 0) || (pstAvcAttr->s32Gain > 8)
      || (pstAvcAttr->s32LimiterLevel < -16) || (pstAvcAttr->s32LimiterLevel > -6))
    {
        return HI_ERR_AO_INVALID_PARA;
    }

    return HI_SUCCESS;
}

static HI_S32 AO_SND_SetAvcAttr(HI_UNF_SND_E enSound, HI_UNF_SND_AVC_ATTR_S* pstAvcAttr)
{
    HI_S32 Ret;
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);
    SND_ENGINE_STATE_S* pstEnginestate = (SND_ENGINE_STATE_S*)pCard->pSndEngine[SND_ENGINE_TYPE_PCM];
	
    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_NULL_PTR(pstAvcAttr);
    CHECK_AO_NULL_PTR(pCard);
    Ret = AO_Check_AvcAttr(pstAvcAttr);
    if (HI_SUCCESS != Ret)
    {
        HI_ERR_AO("invalid avc attr!\n");
        return Ret;
    }
	
    if (!pstEnginestate)
    {
        memcpy(&pCard->stAvcAttr, pstAvcAttr, sizeof(HI_UNF_SND_AVC_ATTR_S));
        HI_INFO_AO("pcm engine do not exist!\n");
        return HI_SUCCESS;
    }
	
    Ret = HAL_AOE_ENGINE_SetAvcAttr(pstEnginestate->enEngine, pstAvcAttr);
    if (HI_SUCCESS != Ret)
    {
        HI_ERR_AO("HAL_AOE_ENGINE_SetAvcAttr failed!\n");
        return Ret;
    }
    memcpy(&pCard->stAvcAttr, pstAvcAttr, sizeof(HI_UNF_SND_AVC_ATTR_S));
	
    return Ret;
}

static HI_S32 AO_SND_GetAvcAttr(HI_UNF_SND_E enSound, HI_UNF_SND_AVC_ATTR_S* pstAvcAttr)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);
	
    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_NULL_PTR(pstAvcAttr);
    CHECK_AO_NULL_PTR(pCard);
    memcpy(pstAvcAttr, &pCard->stAvcAttr, sizeof(HI_UNF_SND_AVC_ATTR_S));
	
    return HI_SUCCESS;
}

static HI_S32 AO_SND_SetAvcEnable(HI_UNF_SND_E enSound, HI_BOOL bEnable)
{
    HI_S32 Ret;
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);
    SND_ENGINE_STATE_S* pstEnginestate = (SND_ENGINE_STATE_S*)pCard->pSndEngine[SND_ENGINE_TYPE_PCM];
	
    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_NULL_PTR(pCard);
	
    if (!pstEnginestate)
    {
        pCard->bAvcEnable = bEnable;
        HI_INFO_AO("pcm engine do not exist!\n");
        return HI_SUCCESS;
    }
	
    Ret = HAL_AOE_ENGINE_SetAvcEnable(pstEnginestate->enEngine, bEnable);
    if (HI_SUCCESS != Ret)
    {
        HI_ERR_AO("HAL_AOE_ENGINE_SetAvcEnable failed!\n");
        return Ret;
    }
	
    pCard->bAvcEnable = bEnable;
    return Ret;
}

static HI_S32 AO_SND_GetAvcEnable(HI_UNF_SND_E enSound, HI_BOOL* pbEnable)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);
	
    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_NULL_PTR(pCard);
    *pbEnable = pCard->bAvcEnable;
	
    return HI_SUCCESS;
}

static HI_S32 AO_Check_GeqAttr(HI_UNF_SND_GEQ_ATTR_S* pstGeqAttr)
{
    HI_U32 i;
    if ((pstGeqAttr->u32BandNum < 5) || (pstGeqAttr->u32BandNum > 10))
    {
        HI_ERR_AO("Invalid Geq BandNum! bandnum(%d)!\n", pstGeqAttr->u32BandNum);
        return HI_ERR_AO_INVALID_PARA;
    }

    for (i = 0; i < pstGeqAttr->u32BandNum; i++)
    {
        if ((pstGeqAttr->stEqParam[i].s32Gain < -15000) || (pstGeqAttr->stEqParam[i].s32Gain > 15000) || (pstGeqAttr->stEqParam[i].s32Gain % 125))
        {
            HI_ERR_AO("Invalid Geq Gain value!\n");
            return HI_ERR_AO_INVALID_PARA;
        }

        if ((pstGeqAttr->stEqParam[i].u32freq < 20) || (pstGeqAttr->stEqParam[i].u32freq > 20000))
        {
            HI_ERR_AO("Invalid Geq Gain value!\n");
            return HI_ERR_AO_INVALID_PARA;
        }
    }
    return HI_SUCCESS;
}

static HI_S32 AO_SND_SetGeqAttr(HI_UNF_SND_E enSound, HI_UNF_SND_GEQ_ATTR_S* pstGeqAttr)
{
    HI_S32 Ret;
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);
    SND_ENGINE_STATE_S* pstEnginestate = (SND_ENGINE_STATE_S*)pCard->pSndEngine[SND_ENGINE_TYPE_PCM];

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_NULL_PTR(pstGeqAttr);
    CHECK_AO_NULL_PTR(pCard);

    Ret = AO_Check_GeqAttr(pstGeqAttr);
    if (HI_SUCCESS != Ret)
    {
        HI_ERR_AO("invalid geq attr!\n");
        return Ret;
    }

    if (!pstEnginestate)
    {
        memcpy(&pCard->stGeqAttr, pstGeqAttr, sizeof(HI_UNF_SND_GEQ_ATTR_S));
        HI_INFO_AO("pcm engine do not exist!\n");
        return HI_SUCCESS;
    }

    Ret = HAL_AOE_ENGINE_SetGeqAttr(pstEnginestate->enEngine, pstGeqAttr);
    if (HI_SUCCESS != Ret)
    {
        HI_ERR_AO("HAL_AOE_ENGINE_SetGeqAttr failed!\n");
        return Ret;
    }
    memcpy(&pCard->stGeqAttr, pstGeqAttr, sizeof(HI_UNF_SND_GEQ_ATTR_S));
    return Ret;
}

static HI_S32 AO_SND_GetGeqAttr(HI_UNF_SND_E enSound, HI_UNF_SND_GEQ_ATTR_S* pstGeqAttr)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_NULL_PTR(pstGeqAttr);
    CHECK_AO_NULL_PTR(pCard);

    memcpy(pstGeqAttr, &pCard->stGeqAttr, sizeof(HI_UNF_SND_GEQ_ATTR_S));
    return HI_SUCCESS;

}

static HI_S32 AO_SND_SetGeqEnable(HI_UNF_SND_E enSound, HI_BOOL bEnable)
{
    HI_S32 Ret;
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);
    SND_ENGINE_STATE_S* pstEnginestate = (SND_ENGINE_STATE_S*)pCard->pSndEngine[SND_ENGINE_TYPE_PCM];

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_NULL_PTR(pCard);

    if (!pstEnginestate)
    {
        pCard->bGeqEnable = bEnable;
        HI_INFO_AO("pcm engine do not exist!\n");
        return HI_SUCCESS;
    }

    Ret = HAL_AOE_ENGINE_SetGeqEnable(pstEnginestate->enEngine, bEnable);
    if (HI_SUCCESS != Ret)
    {
        HI_ERR_AO("HAL_AOE_ENGINE_SetGeqEnable failed!\n");
        return Ret;
    }
    pCard->bGeqEnable = bEnable;
    return Ret;
}

static HI_S32 AO_SND_GetGeqEnable(HI_UNF_SND_E enSound, HI_BOOL* pbEnable)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_NULL_PTR(pCard);

    *pbEnable = pCard->bGeqEnable;
    return HI_SUCCESS;
}

static HI_S32 AO_SND_SetGeqGain(HI_UNF_SND_E enSound, HI_U32 u32Band, HI_S32 s32Gain)
{
    HI_S32 Ret;
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);
    SND_ENGINE_STATE_S* pstEnginestate;

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_NULL_PTR(pCard);

    pstEnginestate = (SND_ENGINE_STATE_S*)pCard->pSndEngine[SND_ENGINE_TYPE_PCM];

    if ((s32Gain < -15000) || (s32Gain > 15000) || (s32Gain % 125))
    {
        HI_ERR_AO("invalid geq gain!\n");
        return HI_ERR_AO_INVALID_PARA;
    }

    if (!pstEnginestate)
    {
        pCard->stGeqAttr.stEqParam[u32Band].s32Gain = s32Gain;
        HI_INFO_AO("pcm engine do not exist!\n");
        return HI_SUCCESS;
    }

    Ret = HAL_AOE_ENGINE_SetGeqGain(pstEnginestate->enEngine, u32Band, s32Gain);
    if (HI_SUCCESS != Ret)
    {
        HI_ERR_AO("HAL_AOE_ENGINE_SetGeqGain failed!\n");
        return Ret;
    }
    pCard->stGeqAttr.stEqParam[u32Band].s32Gain = s32Gain;
    return Ret;
}

static HI_S32 AO_SND_GetGeqGain(HI_UNF_SND_E enSound, HI_U32 u32Band, HI_S32* ps32Gain)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_NULL_PTR(pCard);

    *ps32Gain = pCard->stGeqAttr.stEqParam[u32Band].s32Gain;
    return HI_SUCCESS;
}


HI_S32 AO_WriteProc_CastSimulateOp(SND_CARD_STATE_S* pCard, HI_CHAR* pcBuf)
{
    HI_CHAR* pcOnCmd  = "on";
    HI_CHAR* pcOffCmd = "off";

    pCard->enCastSimulatePort = AUTIL_PortName2Port(pcBuf);

    AO_STRING_SKIP_BLANK(pcBuf);

    if (strstr(pcBuf, pcOnCmd))
    {
        pCard->bCastSimulateOp = HI_TRUE;
    }
    else if (strstr(pcBuf, pcOffCmd))
    {
        pCard->bCastSimulateOp = HI_FALSE;
    }
    else
    {
        return HI_FAILURE;
    }

    return HI_SUCCESS;
}
#endif

#ifdef HI_SND_AFLT_SUPPORT
static HI_S32 AO_SND_AttachAef(HI_UNF_SND_E enSound, HI_U32 u32AefId, AO_AEF_ATTR_S* pstAefAttr, HI_U32* pu32AefProcAddr)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_NULL_PTR(pu32AefProcAddr);
    CHECK_AO_NULL_PTR(pCard);

    return AEF_AttachSnd(pCard, u32AefId, pstAefAttr, pu32AefProcAddr);
}

static HI_S32 AO_SND_DetachAef(HI_UNF_SND_E enSound, HI_U32 u32AefId, AO_AEF_ATTR_S* pstAefAttr)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_NULL_PTR(pCard);

    return AEF_DetachSnd(pCard, u32AefId, pstAefAttr);
}

static HI_S32 AO_SND_SetAefBypass(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort, HI_BOOL bBypass)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_OUTPORT(enOutPort);
    CHECK_AO_NULL_PTR(pCard);
    CHECK_AO_PORTEXIST(pCard->stUserOpenParam.u32PortNum);

    return SND_SetOpAefBypass(pCard, enOutPort, bBypass);
}

static HI_S32 AO_SND_GetAefBypass(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort, HI_BOOL* pbBypass)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_OUTPORT(enOutPort);
    CHECK_AO_NULL_PTR(pbBypass);
    CHECK_AO_NULL_PTR(pCard);
    CHECK_AO_PORTEXIST(pCard->stUserOpenParam.u32PortNum);

    return SND_GetOpAefBypass(pCard, enOutPort, pbBypass);
}

#else

static HI_S32 AO_SND_AttachAef(HI_UNF_SND_E enSound, HI_U32 u32AefId, AO_AEF_ATTR_S* pstAefAttr, HI_U32* pu32AefProcAddr)
{
    return HI_SUCCESS;
}

static HI_S32 AO_SND_DetachAef(HI_UNF_SND_E enSound, HI_U32 u32AefId, AO_AEF_ATTR_S* pstAefAttr)
{
    return HI_SUCCESS;
}

static HI_S32 AO_SND_SetAefBypass(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort, HI_BOOL bBypass)
{
    return HI_SUCCESS;
}

static HI_S32 AO_SND_GetAefBypass(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort, HI_BOOL* pbBypass)
{
    return HI_SUCCESS;
}
#endif

static HI_S32 AO_Snd_GetXRunCount(HI_UNF_SND_E enSound, HI_U32* pu32Count)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_NULL_PTR(pCard);
    SND_GetXRunCount(pCard, pu32Count);

    return HI_SUCCESS;
}

#if 0
static HI_S32 AO_Snd_GetAefBufAttr(HI_UNF_SND_E enSound, AO_AEF_BUF_ATTR_S* pstAefBuf)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_NULL_PTR(pstAefBuf);
    CHECK_AO_NULL_PTR(pCard);

    return AEF_GetBufAttr(pCard, pstAefBuf);
}

static HI_S32 AO_Snd_GetDebugAttr(HI_UNF_SND_E enSound, AO_DEBUG_ATTR_S *pstDebugAttr)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_NULL_PTR(pstDebugAttr);
    CHECK_AO_NULL_PTR(pCard);

    switch (pstDebugAttr->enDebugType)
    {
        case AO_SND_DEBUG_TYPE_AEF:
            AEF_GetDebugAddr(pCard, &(pstDebugAttr->unDebugAttr.stAefDebugAttr));
            break;
        default:
            break;        
    }

    return HI_SUCCESS;
}

static HI_S32 AO_SND_SetADOutputEnable(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort, HI_BOOL bEnable)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_OUTPORT(enOutPort);
    CHECK_AO_NULL_PTR(pCard);
    CHECK_AO_PORTEXIST(pCard->stUserOpenParam.u32PortNum);

    return SND_SetOpADOutputEnable(pCard, enOutPort, bEnable);
}

static HI_S32 AO_SND_GetADOutputEnable(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort, HI_BOOL* pbEnable)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_OUTPORT(enOutPort);
    CHECK_AO_NULL_PTR(pCard);
    CHECK_AO_PORTEXIST(pCard->stUserOpenParam.u32PortNum);

    return SND_GetOpADOutputEnable(pCard, enOutPort, pbEnable);
}
#endif

/******************************Snd Track FUNC*************************************/
static SND_CARD_STATE_S* TRACK_CARD_GetCard(HI_U32 Id)
{
    HI_UNF_SND_E sndx;
    SND_CARD_STATE_S* pCard = HI_NULL;

    if (Id >= AO_MAX_TOTAL_TRACK_NUM)
    {
        return HI_NULL;
    }

    for (sndx = HI_UNF_SND_0; sndx < HI_UNF_SND_BUTT; sndx++)
    {
        pCard = SND_CARD_GetCard(sndx);
        if (pCard)
        {
            if (pCard->uSndTrackInitFlag & (1L << Id))
            {
                return pCard;
            }
        }
    }

    return HI_NULL;
}

#if 0
static HI_S32 AO_SND_TrackDuplicate(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort, HI_U32 u32TrackID, HI_BOOL bEnable)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);
    
    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_NULL_PTR(pCard);
    CHECK_AO_PORTEXIST(pCard->stUserOpenParam.u32PortNum);

    u32TrackID &= AO_TRACK_CHNID_MASK;
    if(pCard != TRACK_CARD_GetCard(u32TrackID))
    {
        HI_ERR_AO("this track is not in the sound!\n");
        return HI_FAILURE;
    }

    if((HI_UNF_SND_OUTPUTPORT_DAC0 != enOutPort) && (HI_UNF_SND_OUTPUTPORT_EXT_DAC1!= enOutPort) &&
        (HI_UNF_SND_OUTPUTPORT_EXT_DAC2!= enOutPort) && (HI_UNF_SND_OUTPUTPORT_EXT_DAC3!= enOutPort))
    {
        HI_ERR_AO("enOutPort(%d)is invalid, only support DAC port!\n",AUTIL_Port2Name(enOutPort));
        return HI_FAILURE;
    }

    return TRACK_Duplicate2Aop(pCard, enOutPort, u32TrackID, bEnable);    
}

static HI_S32 AO_SND_GetTrackInfo(HI_UNF_SND_E enSound, HI_UNF_SND_TRACK_INFO_S* pstTrackInfo)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_SNDCARD(enSound);
    CHECK_AO_NULL_PTR(pstTrackInfo);
    CHECK_AO_NULL_PTR(pCard);

    memcpy(pstTrackInfo, &pCard->stTrackInfo, sizeof(HI_UNF_SND_TRACK_INFO_S));

    return HI_SUCCESS;
}
#endif

static HI_S32 AO_Snd_SetAdacEnable(HI_UNF_SND_E enSound, HI_BOOL bEnable)
{
    HI_S32 Ret = HI_SUCCESS;
    SND_CARD_STATE_S *pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_NULL_PTR(pCard);
    Ret = SND_SetAdacEnable(pCard, bEnable);
    if(Ret != HI_SUCCESS)
    {
        HI_ERR_AO("Set Adac Enable Failed\n");
    }
    pCard->bAdacEnable = bEnable;

    return Ret;    
}

static HI_S32 AO_Snd_GetAdacEnable(HI_UNF_SND_E enSound, HI_BOOL *pbEnable)
{
    HI_S32 Ret = HI_SUCCESS;
    SND_CARD_STATE_S *pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_NULL_PTR(pCard);

    *pbEnable = pCard->bAdacEnable;

    return Ret;    
}

/* snd open kernel intf */
HI_S32 AO_Snd_Kopen(AO_SND_Open_Param_S_PTR arg, AO_ALSA_I2S_Param_S* pstAoI2sParam, struct file* file)
{
    HI_S32 s32Ret;
    HI_UNF_SND_E enSound = HI_UNF_SND_BUTT;
    AO_SND_Open_Param_S_PTR pstSndParam = ( AO_SND_Open_Param_S_PTR )arg;
    DRV_AO_STATE_S* pAOState = file->private_data;

    enSound = pstSndParam->enSound;
    CHECK_AO_SNDCARD( enSound );

    s32Ret = down_interruptible(&g_AoMutex);
    if (HI_SUCCESS == AO_Snd_AllocHandle(enSound, file))
    {
        if (0 == atomic_read(&s_stAoDrv.astSndEntity[enSound].atmUseTotalCnt))
        {
            s32Ret = AO_SND_Open( enSound, &pstSndParam->stAttr, pstAoI2sParam, HI_FALSE);
            if (HI_SUCCESS != s32Ret)
            {
                AO_Snd_FreeHandle(enSound, file);
                up(&g_AoMutex);
                return HI_FAILURE;
            }
        }
    }

    atomic_inc(&s_stAoDrv.astSndEntity[enSound].atmUseTotalCnt);
    atomic_inc(&pAOState->atmUserOpenCnt[enSound]);

    up(&g_AoMutex);

    return HI_SUCCESS;
}

/* snd close kernel intf */
HI_S32 AO_Snd_Kclose(HI_UNF_SND_E  arg, struct file* file)
{
    HI_S32 s32Ret;
    HI_UNF_SND_E enSound = HI_UNF_SND_BUTT;
    DRV_AO_STATE_S* pAOState = file->private_data;
    enSound = arg;
    CHECK_AO_SNDCARD_OPEN( enSound );

    s32Ret = down_interruptible(&g_AoMutex);
    if (atomic_dec_and_test(&pAOState->atmUserOpenCnt[enSound]))
    {
        if (atomic_dec_and_test(&s_stAoDrv.astSndEntity[enSound].atmUseTotalCnt))
        {
            s32Ret = AO_SND_Close( enSound, HI_FALSE );
            if (HI_SUCCESS != s32Ret)
            {
                atomic_inc(&s_stAoDrv.astSndEntity[enSound].atmUseTotalCnt);
                up(&g_AoMutex);
                return HI_FAILURE;
            }

            AO_Snd_FreeHandle(enSound, file);
        }
    }
    else
    {
        atomic_dec(&s_stAoDrv.astSndEntity[enSound].atmUseTotalCnt);
    }

    up(&g_AoMutex);

    return HI_SUCCESS;
}

#if 0
static HI_VOID AO_SND_UpdateTrackInfo(HI_HANDLE hTrack, HI_BOOL bAdd)
{
    HI_U32 i, j;
    SND_CARD_STATE_S* pCard = TRACK_CARD_GetCard(hTrack & AO_TRACK_CHNID_MASK);

    if (HI_NULL == pCard)
    {
        HI_WARN_AO("Sound card is null!\n");
        return;
    }

    if (HI_TRUE == bAdd)
    {
        if (pCard->stTrackInfo.u32TrackNum >= HI_UNF_SND_TRACK_MAX)
        {
            HI_WARN_AO("Track number is up to max!\n");
            return;
        }
        pCard->stTrackInfo.hTrack[pCard->stTrackInfo.u32TrackNum++] = hTrack;
    }
    else
    {
        for (i = 0; i < pCard->stTrackInfo.u32TrackNum; i++)
        {
            if (hTrack == pCard->stTrackInfo.hTrack[i] || hTrack == (pCard->stTrackInfo.hTrack[i] & AO_TRACK_CHNID_MASK))
                break;
        }
        if (i == pCard->stTrackInfo.u32TrackNum)
            return;

        for (j = i; j < pCard->stTrackInfo.u32TrackNum - 1; j++)
        {
            pCard->stTrackInfo.hTrack[j] = pCard->stTrackInfo.hTrack[j + 1];
        }
        pCard->stTrackInfo.u32TrackNum--;
    }

    return;
}
#endif

HI_S32 AO_Track_AllocHandle(HI_HANDLE *phHandle, HI_UNF_SND_TRACK_TYPE_E enTrackType, struct file *pstFile)
{
    HI_U32 i;

    if (HI_NULL == phHandle)
    {
        HI_ERR_AO("Bad param!\n");
        return HI_FAILURE;
    }

    /* Check ready flag */
    if (s_stAoDrv.bReady != HI_TRUE)
    {
        HI_ERR_AO("Need open first!\n");
        return HI_FAILURE;
    }

    /* Check channel number */
    if (s_stAoDrv.u32TrackNum >= AO_MAX_TOTAL_TRACK_NUM)
    {
        HI_ERR_AO("Too many track:%d!\n", s_stAoDrv.u32TrackNum);
        goto err0;
    }

    if(enTrackType == HI_UNF_SND_TRACK_TYPE_LOWLATENCY)
    {
        if(s_stAoDrv.bLowLatencyCreated == HI_TRUE)
        {
            HI_ERR_AO("Too many LowLatency track!\n");
            goto err0;
        }
    }

    /* Allocate new channel */
    for (i = 0; i < AO_MAX_TOTAL_TRACK_NUM; i++)
    {
        if (0 == atomic_read(&s_stAoDrv.astTrackEntity[i].atmUseCnt))
        {
            s_stAoDrv.astTrackEntity[i].pstFile = HI_NULL;
            break;
        }
    }

    if (i >= AO_MAX_TOTAL_TRACK_NUM)
    {
        HI_ERR_AO("Too many track!\n");
        goto err0;
    }

    /* Allocate resource */

    s_stAoDrv.astTrackEntity[i].pstFile = pstFile;
    s_stAoDrv.u32TrackNum++;
    atomic_inc(&s_stAoDrv.astTrackEntity[i].atmUseCnt);
    /*
      define of Track Handle :
      bit31                                                           bit0
        |<----   16bit --------->|<---   8bit    --->|<---  8bit   --->|
        |--------------------------------------------------------------|
        |      HI_MOD_ID_E            |  sub_mod defined  |     chnID       |
        |--------------------------------------------------------------|
      */
    if(enTrackType == HI_UNF_SND_TRACK_TYPE_LOWLATENCY)
    {
        *phHandle = (HI_ID_AO << 16) | (HI_ID_LOWLATENCY_TRACK << 8) | i;
        s_stAoDrv.bLowLatencyCreated = HI_TRUE;
    }
    else
    {
        *phHandle = (HI_ID_AO << 16) | (HI_ID_MASTER_SLAVE_TRACK << 8) | i;
    }

    return HI_SUCCESS;

err0:
    return HI_FAILURE;
}

HI_VOID AO_Track_FreeHandleById(HI_U32 u32TrackID)
{
    s_stAoDrv.bLowLatencyCreated = HI_FALSE;  //low latency track

    if (0 == atomic_read(&s_stAoDrv.astTrackEntity[u32TrackID].atmUseCnt))
    {
        return;
    }

    s_stAoDrv.astTrackEntity[u32TrackID].pstFile = (HI_U32)HI_NULL;
    s_stAoDrv.u32TrackNum--;
    atomic_set(&s_stAoDrv.astTrackEntity[u32TrackID].atmUseCnt, 0);
}


HI_VOID AO_Track_FreeHandle(HI_HANDLE hHandle)
{
    if ((hHandle & 0xff00) == (HI_ID_LOWLATENCY_TRACK << 8)) //low latency track
    {
        s_stAoDrv.bLowLatencyCreated = HI_FALSE;
    }

    hHandle &= AO_TRACK_CHNID_MASK;
    if (0 == atomic_read(&s_stAoDrv.astTrackEntity[hHandle].atmUseCnt))
		return;
    s_stAoDrv.astTrackEntity[hHandle].pstFile = HI_NULL;
    s_stAoDrv.u32TrackNum--;
    atomic_set(&s_stAoDrv.astTrackEntity[hHandle].atmUseCnt, 0);
}

static HI_VOID AO_TRACK_SaveSuspendAttr(HI_HANDLE hHandle, AO_Track_Create_Param_S_PTR pstTrack)
{
    hHandle &= AO_TRACK_CHNID_MASK;
    s_stAoDrv.astTrackEntity[hHandle].stSuspendAttr.enSound = pstTrack->enSound;
    s_stAoDrv.astTrackEntity[hHandle].stSuspendAttr.bAlsaTrack = pstTrack->bAlsaTrack;
    memcpy(&s_stAoDrv.astTrackEntity[hHandle].stSuspendAttr.stBufAttr, &pstTrack->stBuf, sizeof(AO_BUF_ATTR_S));
}

HI_S32 AO_Track_GetDefAttr(HI_UNF_AUDIOTRACK_ATTR_S* pstDefAttr)
{
    return TRACK_GetDefAttr(pstDefAttr);
}

static HI_S32 AO_Track_GetAttr(HI_U32 u32TrackID, HI_UNF_AUDIOTRACK_ATTR_S* pstTrackAttr)
{
    SND_CARD_STATE_S* pCard;
    u32TrackID &= AO_TRACK_CHNID_MASK;
    pCard = TRACK_CARD_GetCard(u32TrackID);

    if (pCard)
    {
        return TRACK_GetAttr(pCard, u32TrackID, pstTrackAttr);
    }
    else
    {
        return HI_FAILURE;
    }
}

static HI_S32 AO_Track_SetAttr(HI_U32 u32TrackID, HI_UNF_AUDIOTRACK_ATTR_S* pstTrackAttr)
{
    HI_S32 s32Ret;
    SND_CARD_STATE_S* pCard;

    u32TrackID &= AO_TRACK_CHNID_MASK;
    pCard = TRACK_CARD_GetCard(u32TrackID);

    if (pCard)
    {

        s32Ret = TRACK_SetAttr(pCard, u32TrackID, pstTrackAttr);
        if (HI_SUCCESS != s32Ret)
        {
            HI_FATAL_AO("TRACK_SetAttr fail\n");
            return HI_FAILURE;
        }
        return s32Ret;
    }
    return HI_FAILURE;
}

HI_S32 AO_Track_Create(HI_UNF_SND_E enSound, HI_UNF_AUDIOTRACK_ATTR_S* pstAttr,
                       HI_BOOL bAlsaTrack, AO_BUF_ATTR_S* pstBuf, HI_HANDLE hTrack)
{
    HI_S32 s32Ret;
    SND_CARD_STATE_S* pCard;
    hTrack &= AO_TRACK_CHNID_MASK;
    pCard = SND_CARD_GetCard(enSound);

    if (pCard)
    {
        s32Ret = TRACK_CreateNew(pCard, pstAttr, bAlsaTrack, pstBuf, hTrack);
        if (HI_SUCCESS == s32Ret)
        {
            if (HI_FALSE == bAlsaTrack)  //No alsa track
            {
                HI_INFO_AO("set track %d mute \n", hTrack);
                return TRACK_SetMute(pCard, hTrack, HI_FALSE);
            }
        }
        return s32Ret;
    }
    else
    {
        return HI_ERR_AO_SOUND_NOT_OPEN;
    }
}

HI_S32 AO_Track_Destory(HI_U32 u32TrackID)
{
    SND_CARD_STATE_S* pCard;
    u32TrackID &= AO_TRACK_CHNID_MASK;
    pCard = TRACK_CARD_GetCard(u32TrackID);

    if (pCard)
    {
        return TRACK_Destroy(pCard, u32TrackID);
    }
    else
    {
        return HI_ERR_AO_SOUND_NOT_OPEN;
    }
}

HI_S32 AO_Track_Start(HI_U32 u32TrackID)
{
    SND_CARD_STATE_S* pCard;
    u32TrackID &= AO_TRACK_CHNID_MASK;
    pCard = TRACK_CARD_GetCard(u32TrackID);

    if (pCard)
    {
        return TRACK_Start(pCard, u32TrackID);
    }
    else
    {
        return HI_ERR_AO_SOUND_NOT_OPEN;
    }
}

HI_S32 AO_Track_Stop(HI_U32 u32TrackID)
{
    SND_CARD_STATE_S* pCard;
    u32TrackID &= AO_TRACK_CHNID_MASK;
    pCard = TRACK_CARD_GetCard(u32TrackID);

    if (pCard)
    {
        return TRACK_Stop(pCard, u32TrackID);
    }
    else
    {
        return HI_ERR_AO_SOUND_NOT_OPEN;
    }
}

HI_S32 AO_Track_Pause(HI_U32 u32TrackID)
{
    SND_CARD_STATE_S* pCard;
    u32TrackID &= AO_TRACK_CHNID_MASK;
    pCard = TRACK_CARD_GetCard(u32TrackID);

    if (pCard)
    {
        return TRACK_Pause(pCard, u32TrackID);
    }
    else
    {
        return HI_ERR_AO_SOUND_NOT_OPEN;
    }
}

HI_S32 AO_Track_Flush(HI_U32 u32TrackID)
{
    SND_CARD_STATE_S* pCard;
    u32TrackID &= AO_TRACK_CHNID_MASK;
    pCard = TRACK_CARD_GetCard(u32TrackID);

    if (pCard)
    {
        return TRACK_Flush(pCard, u32TrackID);
    }
    else
    {
        return HI_ERR_AO_SOUND_NOT_OPEN;
    }
}

HI_S32 AO_TrackSetAipFiFoBypass(HI_U32 u32TrackID, HI_BOOL bEnable)
{
	SND_CARD_STATE_S *pCard;
    u32TrackID &= AO_TRACK_CHNID_MASK;
    pCard = TRACK_CARD_GetCard(u32TrackID);
    if (pCard)
    {
        return TRACK_SetAipFiFoBypass(pCard, u32TrackID, bEnable);
    }
    else
    {
        return HI_ERR_AO_SOUND_NOT_OPEN;
    }
}

HI_S32 AO_Track_SendData(HI_U32 u32TrackID, AO_FRAMEINFO_S * pstAOFrame)
{
    SND_CARD_STATE_S* pCard;
    u32TrackID &= AO_TRACK_CHNID_MASK;
    pCard = TRACK_CARD_GetCard(u32TrackID);

    if (pCard)
    {
        return TRACK_SendData(pCard, u32TrackID, pstAOFrame);
    }
    else
    {
        return HI_ERR_AO_SOUND_NOT_OPEN;
    }
}

static HI_S32 AO_Track_MmapTrackAttr(HI_U32 u32TrackID, AO_Track_GetTrackMapInfo_Param_S *pstTrackMapInfo)
{
    SND_CARD_STATE_S* pCard;
    u32TrackID &= AO_TRACK_CHNID_MASK;
    pCard = TRACK_CARD_GetCard(u32TrackID);
    if (pCard)
    {
        return TRACK_MmapTrackAttr(pCard, u32TrackID, pstTrackMapInfo);
    }
    else
    {
        HI_ERR_AO("TRACK_MmapTrackAttr trace HI_ERR_AO_SOUND_NOT_OPEN!!!\n");
        return HI_ERR_AO_SOUND_NOT_OPEN;
    }
}

static HI_S32 AO_Track_SetWeight(HI_U32 u32TrackID, HI_UNF_SND_GAIN_ATTR_S stTrackGain)
{
    SND_CARD_STATE_S* pCard;
    u32TrackID &= AO_TRACK_CHNID_MASK;
    pCard = TRACK_CARD_GetCard(u32TrackID);

    if (pCard)
    {
        return TRACK_SetWeight(pCard, u32TrackID, &stTrackGain);
    }
    else
    {
        return HI_ERR_AO_SOUND_NOT_OPEN;
    }
}

static HI_S32 AO_Track_GetWeight(HI_U32 u32TrackID, HI_UNF_SND_GAIN_ATTR_S* pstTrackGain)
{
    SND_CARD_STATE_S* pCard;
    u32TrackID &= AO_TRACK_CHNID_MASK;
    pCard = TRACK_CARD_GetCard(u32TrackID);

    if (pCard)
    {
        return TRACK_GetWeight(pCard, u32TrackID, pstTrackGain);
    }
    else
    {
        return HI_ERR_AO_SOUND_NOT_OPEN;
    }
}

static HI_S32 AO_Track_SetAbsGain(HI_U32 u32TrackID, HI_UNF_SND_ABSGAIN_ATTR_S stTrackAbsGain)
{
    SND_CARD_STATE_S* pCard;
    u32TrackID &= AO_TRACK_CHNID_MASK;
    pCard = TRACK_CARD_GetCard(u32TrackID);

    if (pCard)
    {
        return TRACK_SetAbsGain(pCard, u32TrackID, &stTrackAbsGain);
    }
    else
    {
        return HI_ERR_AO_SOUND_NOT_OPEN;
    }
}

static HI_S32 AO_Track_GetAbsGain(HI_U32 u32TrackID, HI_UNF_SND_ABSGAIN_ATTR_S* pstTrackAbsGain)
{
    SND_CARD_STATE_S* pCard;
    u32TrackID &= AO_TRACK_CHNID_MASK;
    pCard = TRACK_CARD_GetCard(u32TrackID);

    if (pCard)
    {
        return TRACK_GetAbsGain(pCard, u32TrackID, pstTrackAbsGain);
    }
    else
    {
        return HI_ERR_AO_SOUND_NOT_OPEN;
    }
}

#if 0
static HI_S32 AO_Track_SetPrescale(HI_U32 u32TrackID, HI_UNF_SND_PRECIGAIN_ATTR_S stPreciGain)
{
    SND_CARD_STATE_S* pCard;
    u32TrackID &= AO_TRACK_CHNID_MASK;
    pCard = TRACK_CARD_GetCard(u32TrackID);

    if (pCard)
    {
        return TRACK_SetPrescale(pCard, u32TrackID, &stPreciGain);
    }
    else
    {
        return HI_ERR_AO_SOUND_NOT_OPEN;
    }
}

static HI_S32 AO_Track_GetPrescale(HI_U32 u32TrackID, HI_UNF_SND_PRECIGAIN_ATTR_S* pstPreciGain)
{
    SND_CARD_STATE_S* pCard;
    u32TrackID &= AO_TRACK_CHNID_MASK;
    pCard = TRACK_CARD_GetCard(u32TrackID);

    if (pCard)
    {
        return TRACK_GetPrescale(pCard, u32TrackID, pstPreciGain);
    }
    else
    {
        return HI_ERR_AO_SOUND_NOT_OPEN;
    }
}
#endif

static HI_S32 AO_Track_SetMute(HI_U32 u32TrackID, HI_BOOL bMute)
{
    SND_CARD_STATE_S* pCard;
    u32TrackID &= AO_TRACK_CHNID_MASK;
    pCard = TRACK_CARD_GetCard(u32TrackID);

    if (pCard)
    {
        return TRACK_SetMute(pCard, u32TrackID, bMute);
    }
    else
    {
        return HI_ERR_AO_SOUND_NOT_OPEN;
    }
}

static HI_S32 AO_Track_GetMute(HI_U32 u32TrackID, HI_BOOL* pbMute)
{
    SND_CARD_STATE_S* pCard;
    u32TrackID &= AO_TRACK_CHNID_MASK;
    pCard = TRACK_CARD_GetCard(u32TrackID);

    if (pCard)
    {
        return TRACK_GetMute(pCard, u32TrackID, pbMute);
    }
    else
    {
        return HI_ERR_AO_SOUND_NOT_OPEN;
    }
}

static HI_S32 AO_Track_SetChannelMode(HI_U32 u32TrackID, HI_UNF_TRACK_MODE_E enMode)
{
    SND_CARD_STATE_S* pCard;
    u32TrackID &= AO_TRACK_CHNID_MASK;
    pCard = TRACK_CARD_GetCard(u32TrackID);

    if (pCard)
    {
        return TRACK_SetChannelMode(pCard, u32TrackID, &enMode);
    }
    else
    {
        return HI_ERR_AO_SOUND_NOT_OPEN;
    }
}

static HI_S32 AO_Track_GetChannelMode(HI_U32 u32TrackID, HI_UNF_TRACK_MODE_E* penMode)
{
    SND_CARD_STATE_S* pCard;
    u32TrackID &= AO_TRACK_CHNID_MASK;
    pCard = TRACK_CARD_GetCard(u32TrackID);

    if (pCard)
    {
        return TRACK_GetChannelMode(pCard, u32TrackID, penMode);
    }
    else
    {
        return HI_ERR_AO_SOUND_NOT_OPEN;
    }
}

static HI_S32 AO_Track_SePriority(HI_U32 u32TrackID, HI_BOOL bEnable)
{
    SND_CARD_STATE_S *pCard;
    u32TrackID &= AO_TRACK_CHNID_MASK;
    pCard = TRACK_CARD_GetCard(u32TrackID);

    if (pCard)
    {
        return TRACK_SetPriority(pCard, u32TrackID, bEnable);
    }
    else
    {
        return HI_ERR_AO_SOUND_NOT_OPEN;
    }
}

static HI_S32 AO_Track_GePriority(HI_U32 u32TrackID, HI_BOOL *pbEnable)
{
    SND_CARD_STATE_S *pCard;
    u32TrackID &= AO_TRACK_CHNID_MASK;
    pCard = TRACK_CARD_GetCard(u32TrackID);

    if (pCard)
    {
        return TRACK_GetPriority(pCard, u32TrackID, pbEnable);
    }
    else
    {
        return HI_ERR_AO_SOUND_NOT_OPEN;
    }
}

static HI_S32 AO_Track_SetSpeedAdjust(HI_U32 u32TrackID, AO_SND_SPEEDADJUST_TYPE_E enType, HI_S32 s32Speed)
{
    SND_CARD_STATE_S* pCard;
    u32TrackID &= AO_TRACK_CHNID_MASK;
    pCard = TRACK_CARD_GetCard(u32TrackID);

    if (pCard)
    {
        return TRACK_SetSpeedAdjust(pCard, u32TrackID, enType, s32Speed);
    }
    else
    {
        return HI_ERR_AO_SOUND_NOT_OPEN;
    }
}

HI_S32 AO_Track_GetDelayMs(HI_U32 u32TrackID, HI_U32* pu32DelayMs)
{
    SND_CARD_STATE_S* pCard;
    u32TrackID &= AO_TRACK_CHNID_MASK;
    pCard = TRACK_CARD_GetCard(u32TrackID);

    if (pCard)
    {
        return TRACK_GetDelayMs(pCard, u32TrackID, pu32DelayMs);
    }
    else
    {
        return HI_ERR_AO_SOUND_NOT_OPEN;
    }
}

static HI_S32 AO_Track_IsBufEmpty(HI_U32 u32TrackID, HI_BOOL* pbBufEmpty)
{
    SND_CARD_STATE_S* pCard;
    u32TrackID &= AO_TRACK_CHNID_MASK;
    pCard = TRACK_CARD_GetCard(u32TrackID);

    if (pCard)
    {
        return TRACK_IsBufEmpty(pCard, u32TrackID, pbBufEmpty);
    }
    else
    {
        return HI_ERR_AO_SOUND_NOT_OPEN;
    }
}

static HI_S32 AO_Track_SetEosFlag(HI_U32 u32TrackID, HI_BOOL bEosFlag)
{
    SND_CARD_STATE_S* pCard;
    u32TrackID &= AO_TRACK_CHNID_MASK;
    pCard = TRACK_CARD_GetCard(u32TrackID);

    if (pCard)
    {
        return TRACK_SetEosFlag(pCard, u32TrackID, bEosFlag);
    }
    else
    {
        return HI_ERR_AO_SOUND_NOT_OPEN;
    }
}


HI_S32 AO_Track_AttachAi(HI_U32 u32TrackID, HI_HANDLE hAi)
{
#if defined (HI_AUDIO_AI_SUPPORT)
    HI_S32 Ret;
    SND_CARD_STATE_S* pCard;
    HI_HANDLE   hTrack;
    hTrack = u32TrackID & AO_TRACK_CHNID_MASK;
    pCard = TRACK_CARD_GetCard(hTrack);

    if (pCard)
    {
        Ret = TRACK_SetPcmAttr(pCard, hTrack, hAi);
        if (HI_SUCCESS != Ret)
        {
            HI_ERR_AO("call TRACK_SetPcmAttr failed!\n");
            return Ret;
        }

        Ret = AI_SetAttachFlag(hAi, hTrack, HI_TRUE);
        if (HI_SUCCESS != Ret)
        {
            HI_ERR_AO("call AI_SetAttachFlag failed!\n");
            return Ret;
        }

        Ret = TRACK_AttachAi(pCard, hTrack, hAi);
        if (HI_SUCCESS != Ret)
        {
            HI_ERR_AO("call TRACK_AttachAi failed!\n");
            return Ret;
        }
        return Ret;
    }
    else
    {
        return HI_ERR_AO_SOUND_NOT_OPEN;
    }

#else
    return HI_FAILURE;
#endif
}

HI_S32 AO_Track_DetachAi(HI_U32 u32TrackID, HI_HANDLE hAi)
{
#if defined (HI_AUDIO_AI_SUPPORT)
    HI_S32 Ret;
    SND_CARD_STATE_S* pCard;
    u32TrackID &= AO_TRACK_CHNID_MASK;
    pCard = TRACK_CARD_GetCard(u32TrackID);

    if (pCard)
    {
        Ret = TRACK_DetachAi(pCard, u32TrackID);
        if (HI_SUCCESS != Ret)
        {
            HI_ERR_AO("call TRACK_DetachAi failed!\n");
            return Ret;
        }

        Ret = AI_SetAttachFlag(hAi, u32TrackID, HI_FALSE);
        if (HI_SUCCESS != Ret)
        {
            HI_ERR_AO("call AI_SetAttachFlag failed!\n");
            return Ret;
        }
        return Ret;
    }
    else
    {
        return HI_ERR_AO_SOUND_NOT_OPEN;
    }

#else
    return HI_FAILURE;
#endif
}

#if 1
HI_S32 AO_Track_SetDre(HI_U32 u32TrackID, HI_BOOL bDre)
{
    SND_CARD_STATE_S* pCard;
    u32TrackID &= AO_TRACK_CHNID_MASK;
    pCard = TRACK_CARD_GetCard(u32TrackID);

    if (pCard)
    {
        return TRACK_SetDre(pCard, u32TrackID, bDre);
    }
    else
    {
        return HI_ERR_AO_SOUND_NOT_OPEN;
    }
}
#endif

static HI_S32 AO_Track_MasterSlaveExchange(SND_CARD_STATE_S* pCard, HI_U32 u32TrackID)
{
    HI_U32 u32MTrackID;
    HI_UNF_AUDIOTRACK_ATTR_S* pstTrackAttr;
    HI_BOOL bAlsaTrack;
    AO_BUF_ATTR_S* pstBuf;
    HI_UNF_SND_E enSound;

    SND_TRACK_SETTINGS_S stTrackSettings;
    HI_S32 s32Ret;

    enSound = SND_CARD_GetSnd(pCard);
    if (AO_MAX_TOTAL_SND_NUM == enSound)
    {
		return HI_FAILURE;
    }

    u32MTrackID = TRACK_GetMasterId(pCard);
    if (AO_MAX_TOTAL_TRACK_NUM != u32MTrackID)  //judge if master track exist
    {
        //Master -> slave
        TRACK_GetSetting(pCard, u32MTrackID, &stTrackSettings); //save track setting
        //Master Track is NOT STOP,Not support Exchange
        if (SND_TRACK_STATUS_STOP != stTrackSettings.enCurnStatus)
        {
            HI_FATAL_AO("Exist Master Track(%d) is Not Stop!\n", u32MTrackID);
            return HI_FAILURE;
        }

        /* Destory track */
        s32Ret = AO_Track_Destory(u32MTrackID);
        if (HI_SUCCESS != s32Ret)
        {
            HI_FATAL_AO("AO_Track_Destory fail\n");
            return HI_FAILURE;
        }

        pstTrackAttr = &stTrackSettings.stTrackAttr;
        //bAlsaTrack = stTrackSettings.bAlsaTrack;
        bAlsaTrack = HI_FALSE;        //ALSA TRACK NEVER EXCHANGE
        pstBuf = &stTrackSettings.stBufAttr;
        pstTrackAttr->enTrackType = HI_UNF_SND_TRACK_TYPE_SLAVE;

        /* Recreate slave track  */
        s32Ret = AO_Track_Create(enSound, pstTrackAttr, bAlsaTrack, pstBuf, u32MTrackID);
        if (HI_SUCCESS != s32Ret)
        {
            HI_FATAL_AO("AO_Track_Create fail\n");
            return HI_FAILURE;
        }
        TRACK_RestoreSetting(pCard, u32MTrackID, &stTrackSettings); //restore track setting
    }
    if (u32MTrackID == u32TrackID)	//if input track id is master ,just return here
    {
        return HI_SUCCESS;
    }
    else
    {
        //slave -> Master
        TRACK_GetSetting(pCard, u32TrackID, &stTrackSettings);
        /* Destory track */
        s32Ret = AO_Track_Destory(u32TrackID);
        if (HI_SUCCESS != s32Ret)
        {
            HI_FATAL_AO("AO_Track_Destory fail\n");
            return HI_FAILURE;
        }

        pstTrackAttr = &stTrackSettings.stTrackAttr;
        //bAlsaTrack = stTrackSettings.bAlsaTrack;
        bAlsaTrack = HI_FALSE;        //ALSA TRACK NEVER EXCHANGE
        pstBuf = &stTrackSettings.stBufAttr;
        pstTrackAttr->enTrackType = HI_UNF_SND_TRACK_TYPE_MASTER;

        /* Recreate Master track  */
        s32Ret = AO_Track_Create(enSound, pstTrackAttr, bAlsaTrack, pstBuf, u32TrackID);
        if (HI_SUCCESS != s32Ret)
        {
            HI_FATAL_AO("AO_Track_Create fail\n");
            return HI_FAILURE;
        }
        TRACK_RestoreSetting(pCard, u32TrackID, &stTrackSettings);
        return HI_SUCCESS;
    }

}

HI_S32 AO_Track_PreCreate(HI_UNF_SND_E enSound, HI_UNF_AUDIOTRACK_ATTR_S* pstAttr,
                          HI_BOOL bAlsaTrack, AO_BUF_ATTR_S* pstBuf, HI_HANDLE hTrack)
{
    HI_U32 u32TrackID;
    HI_S32 s32Ret;

    SND_CARD_STATE_S* pCard;
    hTrack &= AO_TRACK_CHNID_MASK;
    pCard = SND_CARD_GetCard(enSound);

    if (pCard)
    {
        s32Ret = TRACK_CheckAttr(pstAttr);
        if (HI_SUCCESS != s32Ret)
        {
            return HI_FAILURE;
        }
        if (HI_UNF_SND_TRACK_TYPE_MASTER == pstAttr->enTrackType)
        {
            u32TrackID = TRACK_GetMasterId(pCard);
            if (AO_MAX_TOTAL_TRACK_NUM != u32TrackID)  //judge if master track exist
            {
                s32Ret = AO_Track_MasterSlaveExchange(pCard, u32TrackID);    //force master to slave
                if (HI_SUCCESS != s32Ret)
                {
                    HI_ERR_AO("Failed to Force Master track(%d) To Slave!\n", u32TrackID);
                    return HI_FAILURE;
                }
            }
        }
        return AO_Track_Create(enSound, pstAttr, bAlsaTrack, pstBuf, hTrack);
    }
    else
    {
        return HI_ERR_AO_SOUND_NOT_OPEN;
    }
}

static HI_S32 AO_Track_PreSetAttr(HI_U32 u32TrackID, HI_UNF_AUDIOTRACK_ATTR_S* pstTrackAttr)
{
    HI_S32 s32Ret;
    SND_CARD_STATE_S* pCard;
    SND_TRACK_ATTR_SETTING_E enAttrSetting;
    HI_UNF_AUDIOTRACK_ATTR_S stTrackTmpAttr = {0};
    u32TrackID &= AO_TRACK_CHNID_MASK;
    pCard = TRACK_CARD_GetCard(u32TrackID);

    if (pCard)
    {
        s32Ret = TRACK_DetectAttr(pCard, u32TrackID, pstTrackAttr, &enAttrSetting);
        if (HI_SUCCESS != s32Ret)
        {
            return s32Ret;
        }

        switch (enAttrSetting)
        {
            case SND_TRACK_ATTR_RETAIN:
                s32Ret = HI_SUCCESS;
                break;
            case SND_TRACK_ATTR_MODIFY:
                s32Ret = AO_Track_SetAttr(u32TrackID, pstTrackAttr);
                break;
            case SND_TRACK_ATTR_MASTER2SLAVE:
            case SND_TRACK_ATTR_SLAVE2MASTER:
                AO_Track_GetAttr(u32TrackID, &stTrackTmpAttr);          //save track attr
                s32Ret = AO_Track_SetAttr(u32TrackID, pstTrackAttr);
                s32Ret = AO_Track_MasterSlaveExchange(pCard, u32TrackID);
                if (HI_SUCCESS != s32Ret)
                {
                    AO_Track_SetAttr(u32TrackID, &stTrackTmpAttr);      //exchange failed ,restore track attr
                }
                break;

            default:
                s32Ret = HI_SUCCESS;        //TODO
                break;
        }

        return s32Ret;
    }
    else
    {
        return HI_ERR_AO_SOUND_NOT_OPEN;
    }
}

HI_S32 AO_Track_UpdateBufWptr(HI_U32 u32TrackID, HI_U32* pu32WritePos)
{
    SND_CARD_STATE_S* pCard;
    u32TrackID &= AO_TRACK_CHNID_MASK;
    pCard = TRACK_CARD_GetCard(u32TrackID);

    if (pCard)
    {
        return TRACK_UpdateWptrPos(pCard, u32TrackID, pu32WritePos);
    }
    else
    {
        return HI_ERR_AO_SOUND_NOT_OPEN;
    }
}

HI_S32 AO_Track_UpdateBufRptr(HI_U32 u32TrackID, HI_U32* pu32ReadPos)
{
    SND_CARD_STATE_S* pCard;
    u32TrackID &= AO_TRACK_CHNID_MASK;
    pCard = TRACK_CARD_GetCard(u32TrackID);
    if (pCard)
    {
        return TRACK_UpdateRptrPos(pCard, u32TrackID, pu32ReadPos);
    }
    else
    {
        return HI_ERR_AO_SOUND_NOT_OPEN;
    }
}

HI_S32 AO_Track_GetAipReadPos(HI_U32 u32TrackID, HI_U32* pu32ReadPos)
{
    SND_CARD_STATE_S* pCard;
    u32TrackID &= AO_TRACK_CHNID_MASK;
    pCard = TRACK_CARD_GetCard(u32TrackID);

    if (pCard)
    {
        return TRACK_GetReadPos(pCard, u32TrackID, pu32ReadPos);
    }
    else
    {
        return HI_ERR_AO_SOUND_NOT_OPEN;
    }
}

HI_S32 AO_Track_FlushBuf(HI_U32 u32TrackID)
{
    SND_CARD_STATE_S* pCard;
    u32TrackID &= AO_TRACK_CHNID_MASK;
    pCard = TRACK_CARD_GetCard(u32TrackID);

    if (pCard)
    {
        return TRACK_FlushBuf(pCard, u32TrackID);
    }
    else
    {
        return HI_ERR_AO_SOUND_NOT_OPEN;
    }
}

#ifdef HI_ALSA_AO_SUPPORT

/* track create kernel intf */
HI_S32 AO_Track_Kcreate(AO_Track_Create_Param_S_PTR  arg, struct file* file)
{
    HI_S32 s32Ret;
    HI_HANDLE hHandle = HI_INVALID_HANDLE;
    AO_Track_Create_Param_S_PTR pstTrack = (AO_Track_Create_Param_S_PTR)arg;

    s32Ret = down_interruptible(&g_AoMutex);

    if (HI_SUCCESS == AO_Track_AllocHandle(&hHandle, pstTrack->stAttr.enTrackType, file))
    {
        s32Ret = AO_Track_Create(pstTrack->enSound, &pstTrack->stAttr, pstTrack->bAlsaTrack,
                                 &pstTrack->stBuf, hHandle);
        if (HI_SUCCESS != s32Ret)
        {
            AO_Track_FreeHandle(hHandle);
            up(&g_AoMutex);
            return HI_FAILURE;
        }

        AO_TRACK_SaveSuspendAttr(hHandle, pstTrack);
        pstTrack->hTrack = hHandle;
    }
    up(&g_AoMutex);

    return HI_SUCCESS;
}
/* track destroy kernel intf */
HI_S32 AO_Track_Kdestory(HI_HANDLE*  arg)
{
    HI_S32 s32Ret;
    HI_HANDLE hTrack = *(HI_HANDLE*)arg;

    s32Ret = down_interruptible(&g_AoMutex);

    CHECK_AO_TRACK_OPEN(hTrack);
    s32Ret = AO_Track_Destory( hTrack );
    if (HI_SUCCESS != s32Ret)
    {
        up(&g_AoMutex);
        return HI_FAILURE;
    }
    AO_Track_FreeHandle(hTrack);

    up(&g_AoMutex);
    return HI_SUCCESS;
}

/* track start kernel intf */
HI_S32 AO_Track_Kstart(HI_HANDLE*  arg)
{
    HI_S32 s32Ret;
    HI_HANDLE hTrack = *(HI_HANDLE*)arg;

    //s32Ret = down_interruptible(&g_AoMutex);	//alsa atomic area

    CHECK_AO_TRACK_OPEN(hTrack);
    s32Ret = AO_Track_Start(hTrack);

    //up(&g_AoMutex);
    return s32Ret;
}

/* track stop kernel intf */
HI_S32 AO_Track_Kstop(HI_HANDLE*  arg)
{
    HI_S32 s32Ret;
    HI_HANDLE hTrack = *(HI_HANDLE*)arg;

    //s32Ret = down_interruptible(&g_AoMutex);

    CHECK_AO_TRACK_OPEN(hTrack);
    s32Ret = AO_Track_Stop(hTrack);

    //up(&g_AoMutex);
    return s32Ret;
}
/* track stop kernel intf */
HI_S32 AO_Track_Kflush(HI_HANDLE*  arg)
{
    HI_S32 s32Ret;
    HI_HANDLE hTrack = *(HI_HANDLE*)arg;

    //s32Ret = down_interruptible(&g_AoMutex);

    CHECK_AO_TRACK_OPEN(hTrack);
    s32Ret = AO_Track_Flush(hTrack);

    //up(&g_AoMutex);
    return s32Ret;
}
#endif

/******************************Snd Cast FUNC*************************************/
#if 0
static HI_S32 AO_SND_SetAllCastMute(HI_UNF_SND_E enSound, HI_BOOL bMute)
{
    HI_S32 s32Ret;
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);
    CHECK_AO_NULL_PTR(pCard);

    s32Ret = CAST_SetAllMute(pCard, bMute);
    if (HI_SUCCESS != s32Ret)
    {
        HI_ERR_AO("Set All Cast Mute Failed, Err 0x%x", s32Ret);
        return s32Ret;
    }

    pCard->bAllCastMute = bMute;
    HI_INFO_AO("Set All Cast Mute Staues %d\n", pCard->bAllCastMute);

    return s32Ret;
}

static HI_S32 AO_SND_GetAllCastMute(HI_UNF_SND_E enSound, HI_BOOL* pbMute)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_NULL_PTR(pbMute);
    CHECK_AO_NULL_PTR(pCard);

    *pbMute = pCard->bAllCastMute;
    return HI_SUCCESS;
}
#endif

static HI_S32 AO_Cast_AllocHandle(HI_HANDLE* phHandle, struct file* pstFile, HI_UNF_SND_CAST_ATTR_S* pstUserCastAttr)
{
    HI_U32 i;
    HI_S32 Ret;
    HI_U32 uFrameSize, uBufSize;
    MMZ_BUFFER_S stRbfMmz;

    if (HI_NULL == phHandle)
    {
        HI_ERR_AO("Bad param!\n");
        return HI_FAILURE;
    }

    /* Check ready flag */
    if (s_stAoDrv.bReady != HI_TRUE)
    {
        HI_ERR_AO("Need open first!\n");
        return HI_FAILURE;
    }

    /* Check channel number */
    if (s_stAoDrv.u32CastNum >= AO_MAX_CAST_NUM)
    {
        HI_ERR_AO("Too many Cast:%d!\n", s_stAoDrv.u32CastNum);
        goto err0;
    }

    /* Allocate new channel */
    for (i = 0; i < AO_MAX_CAST_NUM; i++)
    {
        if (0 == atomic_read(&s_stAoDrv.astCastEntity[i].atmUseCnt))
        {
            s_stAoDrv.astCastEntity[i].pstFile = HI_NULL;
            break;
        }
    }

    if (i >= AO_MAX_CAST_NUM)
    {
        HI_ERR_AO("Too many Cast chans!\n");
        goto err0;
    }

    /* Allocate cast mmz resource */
    uFrameSize = AUTIL_CalcFrameSize(AO_TRACK_NORMAL_CHANNELNUM, AO_TRACK_BITDEPTH_LOW); /* force 2ch 16bit */
    uBufSize = pstUserCastAttr->u32PcmFrameMaxNum * pstUserCastAttr->u32PcmSamplesPerFrame * uFrameSize;
    if (uBufSize > AO_CAST_MMZSIZE_MAX)
    {
        HI_ERR_AO("Invalid Cast FrameMaxNum(%d), PcmSamplesPerFrame(%d)!\n", pstUserCastAttr->u32PcmFrameMaxNum,
                  pstUserCastAttr->u32PcmSamplesPerFrame);
        goto err0;
    }

    Ret = HI_DRV_MMZ_AllocAndMap("AO_Cast", MMZ_OTHERS, AO_CAST_MMZSIZE_MAX, AIAO_BUFFER_ADDR_ALIGN, &stRbfMmz);
    if (HI_SUCCESS != Ret)
    {
        HI_ERR_AIAO("MMZ_AllocAndMap failed\n");
        goto err0;
    }

    s_stAoDrv.astCastEntity[i].stRbfMmz   = stRbfMmz;
    s_stAoDrv.astCastEntity[i].u32ReqSize = uBufSize;

    /* Allocate resource */
    s_stAoDrv.astCastEntity[i].pstFile = pstFile;
    s_stAoDrv.u32CastNum++;
    atomic_inc(&s_stAoDrv.astCastEntity[ i].atmUseCnt);
    *phHandle = (HI_ID_AO << 16) | (HI_ID_CAST << 8) | i;
    return HI_SUCCESS;

err0:
    return HI_FAILURE;
}

static HI_VOID AO_Cast_FreeHandle(HI_HANDLE hHandle)
{
    hHandle &= AO_CAST_CHNID_MASK;

    /* Freee cast mmz resource */
    HI_DRV_MMZ_UnmapAndRelease(&s_stAoDrv.astCastEntity[hHandle].stRbfMmz);

    s_stAoDrv.astCastEntity[hHandle].pstFile = HI_NULL;
    s_stAoDrv.u32CastNum--;
    atomic_set(&s_stAoDrv.astCastEntity[hHandle].atmUseCnt, 0);
}

#define CHECK_AO_CAST_OPEN(Cast) \
    do                                                         \
    {                                                          \
        CHECK_AO_CAST(Cast);                             \
        if (0 == atomic_read(&s_stAoDrv.astCastEntity[Cast & AO_CAST_CHNID_MASK].atmUseCnt))   \
        {                                                       \
            HI_WARN_AO(" Invalid Cast id 0x%x\n", Cast);        \
            return HI_ERR_AO_INVALID_PARA;                       \
        }                                                       \
    } while (0)


static SND_CARD_STATE_S* CAST_CARD_GetCard(HI_U32 Id)
{
    HI_UNF_SND_E sndx;
    SND_CARD_STATE_S* pCard = HI_NULL;

    if (Id >= AO_MAX_CAST_NUM)
    {
        HI_WARN_AO(" Invalid Cast id 0x%x\n", Id);
        return HI_NULL;
    }

    for (sndx = HI_UNF_SND_0; sndx < HI_UNF_SND_BUTT; sndx++)
    {
        pCard = SND_CARD_GetCard(sndx);
        if (pCard)
        {
            if (pCard->uSndCastInitFlag & (1L << Id))
            {
                return pCard;
            }
        }
    }

    return HI_NULL;
}

static HI_S32 AO_Cast_SetMute(HI_U32 u32CastID, HI_BOOL bMute)
{
    SND_CARD_STATE_S* pCard;

    u32CastID &= AO_CAST_CHNID_MASK;
    pCard = CAST_CARD_GetCard(u32CastID);
    if (pCard)
    {
        return CAST_SetMute(pCard, u32CastID, bMute);
    }
    else
    {
        HI_FATAL_AO("Ao Sound Not Open!\n");
        return HI_ERR_AO_SOUND_NOT_OPEN;
    }
}

static HI_S32 AO_Cast_GetMute(HI_U32 u32CastID, HI_BOOL* pbMute)
{
    SND_CARD_STATE_S* pCard;

    u32CastID &= AO_CAST_CHNID_MASK;
    pCard = CAST_CARD_GetCard(u32CastID);

    if (pCard)
    {
        return CAST_GetMute(pCard, u32CastID, pbMute);
    }
    else
    {
        HI_FATAL_AO("Ao Sound Not Open!\n");
        return HI_ERR_AO_SOUND_NOT_OPEN;
    }
}


static HI_S32 AO_Cast_SetAbsGain(HI_U32 u32CastID, HI_UNF_SND_ABSGAIN_ATTR_S stCastAbsGain)
{
    SND_CARD_STATE_S* pCard;
    u32CastID &= AO_CAST_CHNID_MASK;
    pCard = CAST_CARD_GetCard(u32CastID);

    if (pCard)
    {
        return CAST_SetAbsGain(pCard, u32CastID, &stCastAbsGain);
    }
    else
    {
        HI_FATAL_AO("Ao Sound Not Open!\n");
        return HI_ERR_AO_SOUND_NOT_OPEN;
    }
}
static HI_S32 AO_Cast_GetAbsGain(HI_U32 u32CastID, HI_UNF_SND_ABSGAIN_ATTR_S* pstCastAbsGain)
{

    SND_CARD_STATE_S* pCard;
    u32CastID &= AO_CAST_CHNID_MASK;
    pCard = CAST_CARD_GetCard(u32CastID);

    if (pCard)
    {
        return CAST_GetAbsGain(pCard, u32CastID, pstCastAbsGain);
    }
    else
    {
        HI_FATAL_AO("Ao Sound Not Open!\n");
        return HI_ERR_AO_SOUND_NOT_OPEN;
    }
}

#if 0
static HI_S32 AO_Cast_SetAefBypass(HI_U32 u32CastID, HI_BOOL bBypass)
{
    SND_CARD_STATE_S* pCard;
    u32CastID &= AO_CAST_CHNID_MASK;
    pCard = CAST_CARD_GetCard(u32CastID);

    if (pCard)
    {
        return Cast_SetAefBypass(pCard, u32CastID, bBypass);
    }
    else
    {
        HI_FATAL_AO("Ao Sound Not Open!\n");
        return HI_ERR_AO_SOUND_NOT_OPEN;
    }
}
#endif

static HI_S32 AO_Cast_GetDefAttr(HI_UNF_SND_CAST_ATTR_S* pstDefAttr)
{
    return CAST_GetDefAttr(pstDefAttr);
}

static HI_VOID AO_Cast_SaveSuspendAttr(HI_UNF_SND_E enSound, HI_HANDLE hHandle, HI_UNF_SND_CAST_ATTR_S* pstCastAttr)
{
    hHandle &= AO_TRACK_CHNID_MASK;
    s_stAoDrv.astCastEntity[hHandle].stSuspendAttr.enSound = enSound;
    s_stAoDrv.astCastEntity[hHandle].stSuspendAttr.stCastAttr = *pstCastAttr;
}

HI_S32 AO_Cast_Create(HI_UNF_SND_E enSound, HI_UNF_SND_CAST_ATTR_S* pstCastAttr, MMZ_BUFFER_S* pstMMz, HI_HANDLE hCast)
{
    HI_S32 s32Ret;
    SND_CARD_STATE_S* pCard;
    hCast &= AO_CAST_CHNID_MASK;
    pCard = SND_CARD_GetCard(enSound);
    CHECK_AO_NULL_PTR(pCard);

    s32Ret = CAST_CreateNew(pCard, pstCastAttr, pstMMz, hCast);
    if (HI_SUCCESS == s32Ret)
    {
        HI_INFO_AO("set cast %d mute or unmute \n", hCast);
        return CAST_SetMute(pCard, hCast, HI_FALSE);
    }
    return s32Ret;
}

HI_S32 AO_Cast_Destory(HI_HANDLE hCast)
{
    SND_CARD_STATE_S* pCard;
    hCast &= AO_CAST_CHNID_MASK;
    pCard = CAST_CARD_GetCard(hCast);
    CHECK_AO_NULL_PTR(pCard);

    return CAST_DestroyCast(pCard, hCast);
}

HI_S32 AO_Cast_SetInfo(HI_HANDLE hCast, HI_VIRT_ADDR_T tUserVirtAddr)
{
    SND_CARD_STATE_S* pCard;
    hCast &= AO_CAST_CHNID_MASK;
    pCard = CAST_CARD_GetCard(hCast);
    CHECK_AO_NULL_PTR(pCard);

    return CAST_SetInfo(pCard, hCast, tUserVirtAddr);
}

HI_S32 AO_Cast_GetInfo(HI_HANDLE hCast, AO_Cast_Info_Param_S* pstInfo)
{
    SND_CARD_STATE_S* pCard;
    hCast &= AO_CAST_CHNID_MASK;
    pCard = CAST_CARD_GetCard(hCast);
    CHECK_AO_NULL_PTR(pCard);

    return CAST_GetInfo(pCard, hCast, pstInfo);
}

HI_S32 AO_Cast_SetEnable(HI_HANDLE hCast, HI_BOOL bEnable)
{
    SND_CARD_STATE_S* pCard;
    hCast &= AO_CAST_CHNID_MASK;
    pCard = CAST_CARD_GetCard(hCast);
    CHECK_AO_NULL_PTR(pCard);

    return CAST_SetEnable(pCard, hCast, bEnable);
}

HI_S32 AO_Cast_GetEnable(HI_HANDLE hCast, HI_BOOL* pbEnable)
{
    SND_CARD_STATE_S* pCard;
    hCast &= AO_CAST_CHNID_MASK;
    pCard = CAST_CARD_GetCard(hCast);
    CHECK_AO_NULL_PTR(pCard);

    return CAST_GetEnable(pCard, hCast, pbEnable);
}

static HI_S32 AO_Cast_ReadData(HI_HANDLE hCast, AO_Cast_Data_Param_S* pstCastData)
{
    SND_CARD_STATE_S* pCard;
    hCast &= AO_CAST_CHNID_MASK;
    pCard = CAST_CARD_GetCard(hCast);
    CHECK_AO_NULL_PTR(pCard);

    return CAST_ReadData(pCard, hCast, pstCastData);
}

static HI_S32 AO_Cast_ReleseData(HI_HANDLE hCast, AO_Cast_Data_Param_S* pstCastData)
{
    SND_CARD_STATE_S* pCard;
    hCast &= AO_CAST_CHNID_MASK;
    pCard = CAST_CARD_GetCard(hCast);
    CHECK_AO_NULL_PTR(pCard);

    return CAST_ReleaseData(pCard, hCast, pstCastData);
}

/********************************Driver inteface FUNC****************************************/

#if (1 == HI_PROC_SUPPORT)
/*********************************** Code ************************************/
//zgjiere; proc兼容需求是否满足，起码风格类似于V1R1
static HI_BOOL bSaveThreadRunFlag = HI_FALSE;
static HI_BOOL bSuspend2SaveThreadFlag = HI_FALSE;    //HI_TRUE meas suspend start, thread should exit
static volatile HI_BOOL bSaveThread2SuspendFlag = HI_FALSE;    //HI_TRUE means  suspend wait until hi_false

static HI_S32 SndProcSaveThread(void* Arg)
{
    HI_S32 s32Ret;
    SND_PCM_SAVE_ATTR_S* pstThreadArg = (SND_PCM_SAVE_ATTR_S*)Arg;
    SND_PCM_SAVE_ATTR_S stThreadArg;

    //use cast
    HI_UNF_SND_CAST_ATTR_S stCastAttr;
    AO_Cast_Create_Param_S  stCastParam;
    AO_Cast_Enable_Param_S stEnableAttr;
    AO_Cast_Info_Param_S stCastInfo;
    AO_Cast_Data_Param_S stCastData;
    HI_HANDLE hHandle = HI_INVALID_HANDLE;

    stThreadArg.enSound = pstThreadArg->enSound;
    stThreadArg.pstFileHandle = pstThreadArg->pstFileHandle;
    stThreadArg.pstDevfileHandle = pstThreadArg->pstDevfileHandle;

    CHECK_AO_SNDCARD_OPEN(stThreadArg.enSound);
    CHECK_AO_NULL_PTR(stThreadArg.pstFileHandle);

    s32Ret = down_interruptible(&g_AoMutex);
    bSaveThread2SuspendFlag = HI_TRUE;

    s32Ret = AO_Cast_GetDefAttr(&stCastAttr);
    if (HI_SUCCESS != s32Ret)
    {
        up(&g_AoMutex);
        goto Close_File;
    }

    stCastParam.enSound = stThreadArg.enSound;
    memcpy(&stCastParam.stCastAttr, &stCastAttr, sizeof(HI_UNF_SND_CAST_ATTR_S));
    //HI_ERR_AO(" u32PcmFrameMaxNum=%d \n", stCastParam.stCastAttr.u32PcmFrameMaxNum);
    //HI_ERR_AO(" u32PcmSamplesPerFrame=%d \n", stCastParam.stCastAttr.u32PcmSamplesPerFrame);

    if (HI_SUCCESS == AO_Cast_AllocHandle(&hHandle, stThreadArg.pstFileHandle, &stCastParam.stCastAttr))
    {
        s32Ret = AO_Cast_Create(stCastParam.enSound, &stCastParam.stCastAttr, &s_stAoDrv.astCastEntity[hHandle & AO_CAST_CHNID_MASK].stRbfMmz,
                                hHandle);
        if (HI_SUCCESS != s32Ret)
        {
            AO_Cast_FreeHandle(hHandle);
            up(&g_AoMutex);
            goto Close_File;
        }
        //AO_Cast_SaveSuspendAttr(stCastParam.enSound, hHandle, &stCastParam.stCastAttr);   //NO resume
        stCastParam.u32ReqSize = s_stAoDrv.astCastEntity[hHandle & AO_CAST_CHNID_MASK].u32ReqSize;
        stCastParam.hCast = hHandle;
    }
    else
    {
        up(&g_AoMutex);
        goto Close_File;
    }

#if 0
    (HI_VOID)AO_Cast_SetAefBypass(stCastParam.hCast, pstThreadArg->bAefBypass);
#endif

    stCastInfo.hCast = stCastParam.hCast;
    s32Ret = AO_Cast_GetInfo(stCastInfo.hCast, &stCastInfo);
    if (HI_SUCCESS != s32Ret)
    {
        HI_ERR_AO(" AO_Cast_GetInfo Failed\n");
        up(&g_AoMutex);
        goto Destory_Cast;
    }
    //HI_ERR_AO(" stCastInfo u32KernelVirtAddr=0x%x \n", stCastInfo.u32KernelVirtAddr);

    stEnableAttr.hCast = stCastParam.hCast;
    stEnableAttr.bCastEnable = HI_TRUE;
    s32Ret = AO_Cast_SetEnable(stEnableAttr.hCast, stEnableAttr.bCastEnable);
    if (HI_SUCCESS != s32Ret)
    {
        HI_ERR_AO(" AO_Cast_SetEnable Enable Failed\n");
        up(&g_AoMutex);
        //return HI_FAILURE;
        goto Destory_Cast;
    }
    up(&g_AoMutex);

    stCastData.hCast = stCastParam.hCast;
    while (HI_TRUE == bSaveThreadRunFlag) // NO !kthread_should_stop() to avoid dead lock
    {
        HI_U32 u32PcmSize;

        s32Ret = down_interruptible(&g_AoMutex);
        if (bSuspend2SaveThreadFlag == HI_TRUE)
        {
            //HI_ERR_AO("bSuspend2SaveThreadFlag  True!\n");
            up(&g_AoMutex);
            goto Destory_Cast;
        }

        s32Ret = AO_Cast_ReadData(stCastData.hCast, &stCastData);
        up(&g_AoMutex);
        if (HI_SUCCESS == s32Ret)
        {
            if (stCastData.stAOFrame.u32PcmSamplesPerFrame == 0)
            {
                msleep(5);
                continue;
            }
            else
            {
                //HI_ERR_AO(" Once Length : %d\n", u32PcmSize);
                //HI_ERR_AO(" Once Offset : %d\n", stCastData.u32DataOffset);
                u32PcmSize = stCastData.stAOFrame.u32PcmSamplesPerFrame * stCastData.stAOFrame.u32Channels * stCastData.stAOFrame.s32BitPerSample / 8;
                if (stThreadArg.pstFileHandle)
					HI_DRV_FILE_Write(stThreadArg.pstFileHandle, (HI_S8 *)(stCastInfo.tKernelVirtAddr + stCastData.u32DataOffset) , u32PcmSize);
                else
                {
                    HI_ERR_AO("stThreadArg.fileHandle is NULL!\n");
                    goto Destory_Cast;
                }
                s32Ret = down_interruptible(&g_AoMutex);
                if (bSuspend2SaveThreadFlag == HI_TRUE)
                {
                    //HI_ERR_AO("bSuspend2SaveThreadFlag  True!\n");
                    up(&g_AoMutex);
                    goto Destory_Cast;
                }

                s32Ret = AO_Cast_ReleseData(stCastData.hCast, &stCastData);
                up(&g_AoMutex);
                if (HI_SUCCESS != s32Ret)
                {
                    goto Close_File;
                }
            }
        }
        else
        {
            goto Close_File;
        }
    }

Destory_Cast:
    CHECK_AO_CAST_OPEN(stCastParam.hCast);
    s32Ret = down_interruptible(&g_AoMutex);
    s32Ret = AO_Cast_Destory(stCastParam.hCast);
    AO_Cast_FreeHandle(stCastParam.hCast);
    up(&g_AoMutex);
Close_File:
    if (stThreadArg.pstFileHandle)
    {
        HI_DRV_FILE_Close(stThreadArg.pstFileHandle);
    }
    s32Ret = AO_Snd_Kclose(stThreadArg.enSound, stThreadArg.pstDevfileHandle);
    if (HI_SUCCESS != s32Ret)
    {
        HI_ERR_AO("AO_Snd_Kclose %d failed \n", (HI_U32)stThreadArg.enSound);
    }
    s32Ret = AO_DRV_Krelease(stThreadArg.pstDevfileHandle);
    if (HI_SUCCESS != s32Ret)
    {
        HI_ERR_AO("AO_DRV_Krelease\n");
    }
    bSaveThread2SuspendFlag = HI_FALSE;
    return HI_SUCCESS;

}

HI_S32 SND_WriteProc(SND_CARD_STATE_S* pCard, HI_BOOL bBypass, SND_DEBUG_CMD_CTRL_E enCmd)
{
    HI_CHAR szPath[AO_SOUND_PATH_NAME_MAXLEN + AO_SOUND_FILE_NAME_MAXLEN] = {0};
    HI_UNF_SND_E enSound;
    static struct  task_struct* g_pstSndSaveThread = NULL; //name todo
    static SND_PCM_SAVE_ATTR_S stThreadArg;
    static AO_SND_Open_Param_S stSndOpenParam;
    static struct file g_file; //just a dev handle no use
    struct tm now;
    HI_S32 s32Ret;
    enSound = SND_CARD_GetSnd(pCard);

    if (SND_DEBUG_CMD_CTRL_START == enCmd && pCard->enSaveState == SND_DEBUG_CMD_CTRL_STOP)
    {
        if (HI_SUCCESS != HI_DRV_FILE_GetStorePath(szPath, AO_SOUND_PATH_NAME_MAXLEN))
        {
            HI_ERR_AO("get store path failed\n");
            return HI_FAILURE;
        }

        time_to_tm(get_seconds(), 0, &now);

        if (HI_TRUE == bBypass)
        {
            snprintf(szPath, sizeof(szPath), "%s/sound%d_%02u_%02u_%02u.pcm", szPath, (HI_U32)enSound, now.tm_hour, now.tm_min, now.tm_sec);
        }
        else
        {
            snprintf(szPath, sizeof(szPath), "%s/sound%d_aef_%02u_%02u_%02u.pcm", szPath, (HI_U32)enSound, now.tm_hour, now.tm_min, now.tm_sec);
        }

        pCard->pstFileHandle = HI_DRV_FILE_Open(szPath, 1);

        if (!pCard->pstFileHandle)
        {
            HI_ERR_AO("open %s error\n", szPath);
            return HI_FAILURE;
        }

        stThreadArg.enSound = enSound;
        stThreadArg.bAefBypass = bBypass;
        stThreadArg.pstFileHandle = pCard->pstFileHandle;
        stThreadArg.pstDevfileHandle = &g_file;

        stSndOpenParam.enSound = enSound;
        up(&g_AoMutex);
        s32Ret = AO_DRV_Kopen(&g_file);

        if (HI_SUCCESS != s32Ret)
        {
            HI_ERR_AO("AO_DRV_Kopen failed\n");
        }

        s32Ret = AO_Snd_Kopen(&stSndOpenParam, HI_NULL, &g_file);    //never first open

        if (HI_SUCCESS != s32Ret)
        {
            HI_ERR_AO("AO_Snd_Kopen failed\n");
        }

        s32Ret = down_interruptible(&g_AoMutex);

        bSaveThreadRunFlag = HI_TRUE;
        g_pstSndSaveThread = kthread_create(SndProcSaveThread, &stThreadArg, "AoSndProcSave");    //Name To Do

        if (IS_ERR(g_pstSndSaveThread))
        {
            HI_ERR_AO("creat sound proc write thread failed\n");
            return HI_FAILURE;
        }
        pCard->enSaveState = enCmd;
        wake_up_process(g_pstSndSaveThread);

        pCard->u32SaveCnt++;

    }

    if (SND_DEBUG_CMD_CTRL_STOP == enCmd && pCard->enSaveState == SND_DEBUG_CMD_CTRL_START)
    {
        bSaveThreadRunFlag = HI_FALSE;
        //kthread_stop(g_pstSndSaveThread);
        g_pstSndSaveThread = HI_NULL;

        //Warnning : HI_DRV_FILE_Close called in Thread, To avoid hold mutex lock long time
        pCard->enSaveState = enCmd;
    }

    //  if(pCard)
    //      pCard->enSaveState = enCmd;
    return HI_SUCCESS;
}

static HI_S32 AOReadSndProc( struct seq_file* p, HI_UNF_SND_E enSnd )
{
    HI_U32 i;
    DRV_SND_ATTR_S* pstSndAttr;
    SND_CARD_STATE_S* pCard;
    //HI_UNF_EDID_AUDIO_FORMAT_CODE_E enFmt;

    pCard = SND_CARD_GetCard(enSnd);
    if (HI_NULL == pCard)
    {
        PROC_PRINT( p, "\n------------------------------------  SOUND[%d] Not Open ----------------------------------\n", (HI_U32)enSnd );
        return HI_SUCCESS;
    }

    PROC_PRINT( p, "\n-------------------------------------------  SOUND[%d]  Status  ----------------------------------------------------\n", (HI_U32)enSnd );
    pstSndAttr = &pCard->stUserOpenParam;

    PROC_PRINT( p,
                "SampleRate   :%d\n",
                pstSndAttr->enSampleRate );

    if (SND_SPDIF_MODE_NONE != pCard->enSpdifPassthrough)
    {
        PROC_PRINT( p,
                    "SPDIF Status :UserSetMode(%s) DataFormat(%s)\n",
                    AUTIL_SpdifMode2Name(pCard->enUserSpdifMode),
                    AUTIL_Format2Name(pCard->u32SpdifDataFormat));
    }

#if 0
    if (HI_TRUE == pCard->bUserArcEnable)
    {
        PROC_PRINT( p,
                    "ARC   Status :UserSetMode(%s) DataFormat(%s)",
                    AUTIL_ArcMode2Name(pCard->enUserArcMode),
                    AUTIL_Format2Name(pCard->u32SpdifDataFormat));
        if (HI_UNF_SND_ARC_AUDIO_MODE_AUTO == pCard->enUserArcMode)
        {
            PROC_PRINT( p," SupportFormat(");
            for(enFmt = HI_UNF_EDID_AUDIO_FORMAT_CODE_RESERVED; enFmt < HI_UNF_EDID_AUDIO_FORMAT_CODE_BUTT; enFmt++)    
            {
                if(HI_TRUE == pCard->stUserArcCap.bAudioFmtSupported[enFmt])
                {
                    PROC_PRINT( p,"[%s]", AUTIL_EdidFormat2Name(enFmt));
                }
            }
            PROC_PRINT( p,")\n");
        }
        else
        {
            PROC_PRINT( p, "\n");
        }
    }
#endif

    if (SND_HDMI_MODE_NONE != pCard->enHdmiPassthrough)
    {
        PROC_PRINT( p,
                    "HDMI Status  :UserSetMode(%s) DataFormat(%s)\n",
                    AUTIL_HdmiMode2Name(pCard->enUserHdmiMode),
                    AUTIL_Format2Name(pCard->u32HdmiDataFormat));
    }

#if 0
    PROC_PRINT( p, "\nAll Mute     :Track(%s)", ((HI_FALSE == pCard->bAllTrackMute) ? "off" : "on"));

    PROC_PRINT( p, ", Cast(%s)\n", ((HI_FALSE == pCard->bAllCastMute) ? "off" : "on"));

    if (HI_TRUE == pCard->bGeqEnable)
    {
        PROC_PRINT( p, "GEQ Attr     :");
        for (i = 0; i < pCard->stGeqAttr.u32BandNum; i++)
        {
            PROC_PRINT( p,
                        "Band%d(%dHz,%d.%.3ddB) ",
                        i,
                        pCard->stGeqAttr.stEqParam[i].u32freq,
                        pCard->stGeqAttr.stEqParam[i].s32Gain / 1000,
                        pCard->stGeqAttr.stEqParam[i].s32Gain % 1000);

            if (0 == ((i + 1) % 5) && (pCard->stGeqAttr.u32BandNum != (i + 1))) //a line 5 Band
            {
                PROC_PRINT( p, "\n              ");
            }
        }
        PROC_PRINT( p, "\n");
    }
#endif

    PROC_PRINT( p, "\n---------------------------------------------  OutPort Status  ---------------------------------------------\n" );
    for (i = 0; i < pstSndAttr->u32PortNum; i++)
    {
        SND_ReadOpProc( p, pCard, pstSndAttr->stOutport[i].enOutPort );
    }

    if (pCard->uSndCastInitFlag)
    {
        PROC_PRINT( p, "------------------------------------------------ Cast Status  ----------------------------------------------\n" );
        CAST_ReadProc(p, pCard);
    }

    if (pCard->uSndTrackInitFlag)
    {
        PROC_PRINT( p, "\n------------------------------------------------ Track Status  ----------------------------------------------\n" );
        Track_ReadProc( p, pCard );
    }

#ifdef HI_SND_AFLT_SUPPORT
    if (pCard->u32AttAef)
    {
        PROC_PRINT( p, "\n--------------------------------------------- Audio Effect Status  ------------------------------------------\n" );
        AEF_ReadProc( p, pCard );
    }
#endif

    return HI_SUCCESS;
}

HI_S32 AO_DRV_ReadProc( struct seq_file* p, HI_VOID* v )
{
    HI_U32 u32Snd;
    DRV_PROC_ITEM_S* pstProcItem;

    pstProcItem = p->private;

    u32Snd = (pstProcItem->entry_name[5] - '0');
    if(u32Snd >= AO_MAX_TOTAL_SND_NUM)
    {
        PROC_PRINT(p, "Invalid Sound ID:%d.\n", u32Snd);
        return HI_FAILURE;
    }

    AOReadSndProc( p, (HI_UNF_SND_E)u32Snd );

    return HI_SUCCESS;
}

static HI_VOID AO_Hdmi_Debug(SND_CARD_STATE_S* pCard)
{
    if (HI_FALSE == pCard->bHdmiDebug)
    {
        pCard->bHdmiDebug = HI_TRUE;
    }
    else
    {
        pCard->bHdmiDebug = HI_FALSE;
    }
}

static HI_S32 AO_Proc_SetHdmiMode(SND_CARD_STATE_S* pCard, HI_UNF_SND_HDMI_MODE_E enSetMode)
{
    HI_UNF_SND_E  enSound;
    HI_UNF_SND_HDMI_MODE_E enMode = HI_UNF_SND_HDMI_MODE_BUTT;
    CHECK_AO_HDMIMODE(enSetMode);

    enSound = SND_CARD_GetSnd(pCard);
    AO_SND_GetHdmiMode(enSound, HI_UNF_SND_OUTPUTPORT_HDMI0, &enMode);
    if (enMode != enSetMode)
    {
        return AO_SND_SetHdmiMode(enSound, HI_UNF_SND_OUTPUTPORT_HDMI0, enSetMode);
    }
    return HI_SUCCESS;
}

static HI_S32 AO_Proc_SetSpdifMode(SND_CARD_STATE_S* pCard, HI_UNF_SND_SPDIF_MODE_E enSetMode)
{
    HI_UNF_SND_E  enSound;
    HI_UNF_SND_SPDIF_MODE_E enMode = HI_UNF_SND_SPDIF_MODE_BUTT;
    CHECK_AO_SPDIFMODE(enSetMode);

    enSound = SND_CARD_GetSnd(pCard);
    AO_SND_GetSpdifMode(enSound, HI_UNF_SND_OUTPUTPORT_SPDIF0, &enMode);
    if (enMode != enSetMode)
    {
        return AO_SND_SetSpdifMode(enSound, HI_UNF_SND_OUTPUTPORT_SPDIF0, enSetMode);
    }
    return HI_SUCCESS;
}

#if 0
static HI_BOOL AO_PROC_JUDGE_OUTPORT(HI_CHAR* pcBuf)
{
    if (strstr(pcBuf, "DAC0") || strstr(pcBuf, "DAC1") || strstr(pcBuf, "DAC2") || strstr(pcBuf, "DAC3")
        || strstr(pcBuf, "I2S0") || strstr(pcBuf, "I2S1") || strstr(pcBuf, "SPDIF0")
        || strstr(pcBuf, "HDMI0") || strstr(pcBuf, "ARC0") || strstr(pcBuf, "ALLPORT"))
    {
        return HI_TRUE;
    }
    else
    {
        return HI_FALSE;
    }
}
#endif

static HI_S32 AO_WriteProc_SaveTrack(SND_CARD_STATE_S* pCard, HI_CHAR* pcBuf)
{
    HI_U32 u32TrackId = AO_MAX_TOTAL_TRACK_NUM;
    SND_DEBUG_CMD_CTRL_E enCtrlCmd;
    HI_CHAR* pcStartCmd = "start";
    HI_CHAR* pcStopCmd = "stop";

    if (pcBuf[0] < '0' || pcBuf[0] > '9')//do not have param
    {
        return HI_FAILURE;
    }
    u32TrackId = (HI_U32)simple_strtoul(pcBuf, &pcBuf, 10);
    if (u32TrackId >= AO_MAX_TOTAL_TRACK_NUM)
    {
        return HI_FAILURE;
    }
    AO_STRING_SKIP_NON_BLANK(pcBuf);
    AO_STRING_SKIP_BLANK(pcBuf);

    if (strstr(pcBuf, pcStartCmd))
    {
        enCtrlCmd = SND_DEBUG_CMD_CTRL_START;
    }
    else if (strstr(pcBuf, pcStopCmd))
    {
        enCtrlCmd = SND_DEBUG_CMD_CTRL_STOP;
    }
    else
    {
        return HI_FAILURE;
    }

    if (HI_SUCCESS != TRACK_WriteProc_SaveData(pCard, u32TrackId, enCtrlCmd))
    {
        return HI_FAILURE;
    }

    return HI_SUCCESS;
}

#if 0
static HI_S32 AO_WriteProc_GEQ(HI_UNF_SND_E enSound, HI_CHAR* pcBuf)
{
    HI_CHAR* pcOnCmd = "on";
    HI_CHAR* pcOffCmd = "off";
    HI_CHAR* pcBand = "band";
    HI_CHAR* pcGain = "gain";
    HI_U32 u32BandId;
    HI_U32 u32Val1, u32Val2;
    HI_BOOL bNagetive = HI_FALSE;
    HI_UNF_SND_GEQ_ATTR_S stGeqAttr = {0};

    if (strstr(pcBuf, pcOnCmd))
    {
        return AO_SND_SetGeqEnable(enSound, HI_TRUE);
    }
    else if (strstr(pcBuf, pcOffCmd))
    {
        return AO_SND_SetGeqEnable(enSound, HI_FALSE);
    }
    else if (strstr(pcBuf, pcBand))
    {
        AO_SND_GetGeqAttr(enSound, &stGeqAttr);

        pcBuf += strlen(pcBand);
        u32BandId = (HI_U32)simple_strtoul(pcBuf, &pcBuf, 10);
        if (u32BandId >= stGeqAttr.u32BandNum)
        {
            return HI_FAILURE;
        }
        AO_STRING_SKIP_BLANK(pcBuf);
        if (strstr(pcBuf, pcGain))
        {
            pcBuf += strlen(pcGain);
            AO_STRING_SKIP_BLANK(pcBuf);
            if (pcBuf[0] == '-')
            {
                bNagetive = HI_TRUE;
                pcBuf++;
            }
            u32Val1 = (HI_U32)simple_strtoul(pcBuf, &pcBuf, 10);
            if (pcBuf[0] == '.')
            {
                pcBuf++;
                u32Val2 = (HI_U32)simple_strtoul(pcBuf, &pcBuf, 10);
            }
            else
            {
                u32Val2 = 0;
            }
            stGeqAttr.stEqParam[u32BandId].s32Gain = (HI_TRUE == bNagetive) ? (-(u32Val1 * 1000 + u32Val2)) : (u32Val1 * 1000 + u32Val2);
            return AO_SND_SetGeqAttr(enSound, &stGeqAttr);
        }
        else
        {
            return HI_FAILURE; //TODO
        }
    }
    else
    {
        return HI_FAILURE;   //TODO
    }
}
#endif

HI_S32 AO_WriteProc_SaveSound(SND_CARD_STATE_S* pCard, HI_CHAR* pcBuf)
{
    SND_DEBUG_CMD_CTRL_E enCtrlCmd;
    HI_BOOL bBypass;
    HI_CHAR* pcStartCmd = "start";
    HI_CHAR* pcStopCmd = "stop";
    HI_CHAR* pcAefCmd = "aef";

    if (strstr(pcBuf, pcAefCmd))
    {
        bBypass = HI_FALSE;
        pcBuf += strlen(pcAefCmd);
        AO_STRING_SKIP_BLANK(pcBuf);
    }
    else
    {
        bBypass = HI_TRUE;
    }

    if (strstr(pcBuf, pcStartCmd))
    {
        enCtrlCmd = SND_DEBUG_CMD_CTRL_START;
    }
    else if (strstr(pcBuf, pcStopCmd))
    {
        enCtrlCmd = SND_DEBUG_CMD_CTRL_STOP;
    }
    else
    {
        return HI_FAILURE;
    }

    if (HI_SUCCESS != SND_WriteProc(pCard, bBypass, enCtrlCmd))
    {
        return HI_FAILURE;
    }

    return HI_SUCCESS;
}

HI_S32 AO_DRV_WriteProc(struct file* file, const char __user* buf, size_t count, loff_t* ppos)
{
    HI_S32 s32Ret;
    HI_U32 u32Snd;
    SND_CARD_STATE_S* pCard;
    HI_CHAR szBuf[48];
    HI_CHAR* pcBuf = szBuf;
    HI_CHAR* pcSaveTrackCmd = "save_track";
    HI_CHAR* pcSaveSoundCmd = "save_sound";
    HI_CHAR* pcHelpCmd = "help";
    //HI_CHAR* pcInHelpCmd = "*help";
    HI_CHAR* pcHdmiCmd = "hdmi=debug";

#ifdef HI_SND_AFLT_SUPPORT
    HI_CHAR* pcAefCmd = "aef";
#endif

    HI_CHAR* pcTrackCmd = "track";
    //HI_CHAR* pcGEQCmd = "geq";
    //HI_CHAR* pcCastSimulateOp = "castsimulateop";

    HI_CHAR* pcHdmiAuto = "hdmi=auto";
    HI_CHAR* pcHdmiPcm  = "hdmi=pcm";
    HI_CHAR* pcHdmiRaw  = "hdmi=raw";
    HI_CHAR* pcHdmiHbr2Lbr = "hdmi=hbr2lbr";

    HI_CHAR* pcSpdifPcm  = "spdif=pcm";
    HI_CHAR* pcSpdifRaw  = "spdif=raw";
    
    struct seq_file* p = file->private_data;
    DRV_PROC_ITEM_S* pstProcItem = p->private;

    s32Ret = down_interruptible(&g_AoMutex);

    if (copy_from_user(szBuf, buf, count))
    {
        HI_ERR_AO("copy from user failed\n");
        up(&g_AoMutex);
        return HI_FAILURE;
    }

    // sizeof("sound") is 5
    u32Snd = (pstProcItem->entry_name[5] - '0');
    if (u32Snd >= AO_MAX_TOTAL_SND_NUM)
    {
        HI_ERR_AO("Invalid Sound ID:%d.\n", u32Snd);
        goto SAVE_CMD_FAULT;
    }

    pCard = SND_CARD_GetCard((HI_UNF_SND_E)u32Snd);
    if (HI_NULL == pCard)
    {
        HI_ERR_AO("Sound %d is not open\n", u32Snd);
        goto SAVE_CMD_FAULT;
    }

    AO_STRING_SKIP_BLANK(pcBuf);
    if (strstr(pcBuf, pcSaveTrackCmd))
    {
        pcBuf += strlen(pcSaveTrackCmd);
        AO_STRING_SKIP_BLANK(pcBuf);
        if (HI_SUCCESS != AO_WriteProc_SaveTrack(pCard, pcBuf))
        {
            goto SAVE_CMD_FAULT;
        }
    }
#if 0
    else if (strstr(pcBuf, pcInHelpCmd))
    {
        AO_DEBUG_SHOW_INHELP(u32Snd);
        up(&g_AoMutex);
        return count;
    }
#endif
    else if (strstr(pcBuf, pcHelpCmd))
    {
        AO_DEBUG_SHOW_HELP(u32Snd);
        up(&g_AoMutex);
        return count;
    }
    else if (strstr(pcBuf, pcHdmiCmd))
    {
        AO_Hdmi_Debug(pCard);
        up(&g_AoMutex);
        return count;
    }
    else if (strstr(pcBuf, pcSaveSoundCmd))
    {
        pcBuf += strlen(pcSaveSoundCmd);
        AO_STRING_SKIP_BLANK(pcBuf);
        if (HI_SUCCESS != AO_WriteProc_SaveSound(pCard, pcBuf))
        {
            goto SAVE_CMD_FAULT;
        }
    }
#if 0
    else if (strstr(pcBuf, pcGEQCmd))
    {
        pcBuf += strlen(pcGEQCmd);
        AO_STRING_SKIP_BLANK(pcBuf);
        if (HI_SUCCESS != AO_WriteProc_GEQ(u32Snd, pcBuf))
        {
            goto SAVE_CMD_FAULT;
        }
    }
#endif
    else if (strstr(pcBuf, pcTrackCmd))
    {
        pcBuf += strlen(pcTrackCmd);
        if (HI_SUCCESS != Track_WriteProc(pCard, pcBuf))
        {
            goto SAVE_CMD_FAULT;
        }
    }
#if 0
    else if (strstr(pcBuf, pcCastSimulateOp))
    {
        pcBuf += strlen(pcCastSimulateOp);
        AO_STRING_SKIP_BLANK(pcBuf);
        if (HI_SUCCESS != AO_WriteProc_CastSimulateOp(pCard, pcBuf))
        {
            goto SAVE_CMD_FAULT;
        }
    }    
    else if (AO_PROC_JUDGE_OUTPORT(pcBuf))
    {
        if (HI_SUCCESS != SND_WriteOpProc(pCard, pcBuf))
        {
            goto SAVE_CMD_FAULT;
        }
    }
#endif

#ifdef HI_SND_AFLT_SUPPORT
    else if (strstr(pcBuf, pcAefCmd))
    {
        pcBuf += strlen(pcAefCmd);
        if (HI_SUCCESS != AEF_WriteProc(pCard, pcBuf))
        {
            goto SAVE_CMD_FAULT;
        }
    }
#endif

    else if (strstr(pcBuf, pcHdmiAuto))
    {
        AO_Proc_SetHdmiMode(pCard, HI_UNF_SND_HDMI_MODE_AUTO);
    }
    else if (strstr(pcBuf, pcHdmiPcm))
    {
        AO_Proc_SetHdmiMode(pCard, HI_UNF_SND_HDMI_MODE_LPCM);
    }
    else if (strstr(pcBuf, pcHdmiRaw))
    {
        AO_Proc_SetHdmiMode(pCard, HI_UNF_SND_HDMI_MODE_RAW);
    }
    else if (strstr(pcBuf, pcHdmiHbr2Lbr))
    {
        AO_Proc_SetHdmiMode(pCard, HI_UNF_SND_HDMI_MODE_HBR2LBR);
    }
    else if (strstr(pcBuf, pcSpdifPcm))
    {
        AO_Proc_SetSpdifMode(pCard, HI_UNF_SND_SPDIF_MODE_LPCM);
    }
    else if (strstr(pcBuf, pcSpdifRaw))
    {
        AO_Proc_SetSpdifMode(pCard, HI_UNF_SND_SPDIF_MODE_RAW);
    }
    else
    {
        goto SAVE_CMD_FAULT;
    }

    up(&g_AoMutex);
    return count;

SAVE_CMD_FAULT:
    HI_ERR_AO("proc cmd is fault\n");
    AO_DEBUG_SHOW_HELP(u32Snd);
    up(&g_AoMutex);
    return HI_FAILURE;
}

static HI_S32 AO_RegProc(HI_U32 u32Snd)
{
    HI_CHAR aszBuf[16];
    DRV_PROC_ITEM_S*  pProcItem;

    /* Check parameters */
    if (HI_NULL == s_stAoDrv.pstProcParam)
    {
        return HI_FAILURE;
    }

    /* Create proc */
    snprintf(aszBuf, sizeof(aszBuf), "sound%d", u32Snd);
    pProcItem = HI_DRV_PROC_AddModule(aszBuf, HI_NULL, HI_NULL);
    if (!pProcItem)
    {
        HI_FATAL_AO("Create ade proc entry fail!\n");
        return HI_FAILURE;
    }

    /* Set functions */
    pProcItem->read  = s_stAoDrv.pstProcParam->pfnReadProc;
    pProcItem->write = s_stAoDrv.pstProcParam->pfnWriteProc;

    HI_INFO_AO("Create Ao proc entry for OK!\n");
    return HI_SUCCESS;
}

static HI_VOID AO_UnRegProc(HI_U32 u32Snd)
{
    HI_CHAR aszBuf[16];
    snprintf(aszBuf, sizeof(aszBuf), "sound%d", u32Snd);

    HI_DRV_PROC_RemoveModule(aszBuf);
    return;
}
#endif

#if defined(HI_AIAO_VERIFICATION_SUPPORT)
DRV_PROC_EX_S stAIAOCbbOpt =
{
    .fnRead = AIAO_VERI_ProcRead,
};
#endif


static HI_S32 AO_OpenDev(HI_VOID)
{
    HI_U32 i;

    HI_S32 s32Ret;

    /* Init global track parameter */
    for (i = 0; i < AO_MAX_TOTAL_TRACK_NUM; i++)
    {
        atomic_set(&s_stAoDrv.astTrackEntity[i].atmUseCnt, 0);
    }

    s_stAoDrv.u32SndNum = 0;
    /* Init global snd parameter */
    for (i = 0; i < AO_MAX_TOTAL_SND_NUM; i++)
    {
        atomic_set(&s_stAoDrv.astSndEntity[i].atmUseTotalCnt, 0);
    }

    s_stAoDrv.pAdspFunc = HI_NULL;
    s_stAoDrv.pstPDMFunc = HI_NULL;

    /* Get pdm functions */
    s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_PDM, (HI_VOID**)&s_stAoDrv.pstPDMFunc);
    if (HI_SUCCESS != s32Ret)
    {
        HI_FATAL_AO("Get pdm function err:%#x!\n", s32Ret);
        goto err;
    }

    /* Get adsp functions */
    s32Ret = HI_DRV_MODULE_GetFunction(HI_ID_ADSP, (HI_VOID**)&s_stAoDrv.pAdspFunc);
    if (HI_SUCCESS != s32Ret)
    {
        HI_FATAL_AO("Get adsp function err:%#x!\n", s32Ret);
        goto err;
    }

    /* HAL_AOE_Init , Init aoe hardare */
    if (s_stAoDrv.pAdspFunc && s_stAoDrv.pAdspFunc->pfnADSP_LoadFirmware)
    {
        s32Ret = (s_stAoDrv.pAdspFunc->pfnADSP_LoadFirmware)(ADSP_CODE_AOE);
        if (HI_SUCCESS != s32Ret)
        {
            goto err;
        }
        if (s_stAoDrv.pAdspFunc && s_stAoDrv.pAdspFunc->pfnADSP_GetAoeFwmInfo)
        {
            ADSP_FIRMWARE_AOE_INFO_S stAoeInfo;
            s32Ret = (s_stAoDrv.pAdspFunc->pfnADSP_GetAoeFwmInfo)(ADSP_CODE_AOE, &stAoeInfo);
            if (HI_SUCCESS != s32Ret)
            {
                s32Ret = (s_stAoDrv.pAdspFunc->pfnADSP_UnLoadFirmware)(ADSP_CODE_AOE);
                goto err;
            }
            HAL_AOE_Init(stAoeInfo.bAoeSwFlag);
        }
    }


    /* HAL_AIAO_Init, Init aiao hardare */
    HAL_AIAO_Init();

    /* HAL_CAST_Init , Init cast hardare */
    HAL_CAST_Init();

#if defined(HI_AIAO_VERIFICATION_SUPPORT)
    {
        DRV_PROC_ITEM_S* item;
        AIAO_VERI_Open();
        item = HI_DRV_PROC_AddModule(AIAO_VERI_PROC_NAME, &stAIAOCbbOpt, NULL);
        if (!item)
        {
            HI_WARN_AIAO("add proc aiao_port failed\n");
        }
    }
#endif

    /* Set ready flag */
    s_stAoDrv.bReady = HI_TRUE;

    HI_INFO_AO("AO_OpenDev OK.\n");
    return HI_SUCCESS;
err:
    return HI_FAILURE;
}

static HI_S32 AO_CloseDev(HI_VOID)
{
    HI_U32 i, j;
    HI_S32 s32Ret;

    DRV_AO_STATE_S* pAOState = HI_NULL;

    /* Reentrant */
    if (s_stAoDrv.bReady == HI_FALSE)
    {
        return HI_SUCCESS;
    }

    /* Set ready flag */
    s_stAoDrv.bReady = HI_FALSE;

    /* Free all Cast */
    for (i = 0; i < AO_MAX_CAST_NUM; i++)
    {
        {
            if (atomic_read(&s_stAoDrv.astCastEntity[i].atmUseCnt))
            {
                (HI_VOID)AO_Cast_Destory( i );
                AO_Cast_FreeHandle(i);
            }
        }
    }

    /* Free all track */
    for (i = 0; i < AO_MAX_TOTAL_TRACK_NUM; i++)
    {
        {
            if (atomic_read(&s_stAoDrv.astTrackEntity[i].atmUseCnt))
            {
                //AO_SND_UpdateTrackInfo(i, HI_FALSE);
                (HI_VOID)AO_Track_Destory(i);
                AO_Track_FreeHandleById(i);
            }
        }
    }

    /* Free all snd */
    for (i = 0; i < AO_MAX_TOTAL_SND_NUM; i++)
    {
        if (s_stAoDrv.astSndEntity[i].pCard)
        {
            for (j = 0; j < SND_MAX_OPEN_NUM; j++)
            {
                if (s_stAoDrv.astSndEntity[i].pstFile[j] != 0)
                {
                    HI_U32 u32UserOpenCnt = 0;
                    pAOState = (DRV_AO_STATE_S*)((s_stAoDrv.astSndEntity[i].pstFile[j]))->private_data;

                    u32UserOpenCnt = atomic_read(&pAOState->atmUserOpenCnt[i]);
                    if (atomic_sub_and_test(u32UserOpenCnt, &s_stAoDrv.astSndEntity[i].atmUseTotalCnt))
                    {
                        (HI_VOID)AO_SND_Close( i, HI_FALSE );
                    }
                    AO_Snd_FreeHandle(i, s_stAoDrv.astSndEntity[i].pstFile[j]);
                }
            }
        }
    }

    /* HAL_AOE_DeInit */
    if (s_stAoDrv.pAdspFunc && s_stAoDrv.pAdspFunc->pfnADSP_UnLoadFirmware)
    {
        HAL_AOE_DeInit( );
        s32Ret = (s_stAoDrv.pAdspFunc->pfnADSP_UnLoadFirmware)(ADSP_CODE_AOE);
    }

    /* HAL_CAST_DeInit  */
    HAL_CAST_DeInit();

    /* HAL_AIAO_DeInit */
    HAL_AIAO_DeInit();

#if defined(HI_AIAO_VERIFICATION_SUPPORT)
    HI_DRV_PROC_RemoveModule(AIAO_VERI_PROC_NAME);
    AIAO_VERI_Release();
#endif

    return HI_SUCCESS;
}

static HI_S32 AO_ProcessCmd( struct inode* inode, struct file* file, HI_U32 cmd, HI_VOID* arg )
{
    HI_S32 Ret = HI_SUCCESS;

    HI_HANDLE hHandle = HI_INVALID_HANDLE;
    HI_UNF_SND_E enSound = HI_UNF_SND_BUTT;
#if defined(HI_AIAO_VERIFICATION_SUPPORT)
    if ((cmd & 0xff) >= CMD_AIAO_VERI_IOCTL)
    {
        return AIAO_VERI_ProcessCmd(inode, file, cmd, arg);
    }
#endif

    /* Check parameter in this switch */
    switch (cmd)
    {
        case CMD_AO_TRACK_DESTROY:
        case CMD_AO_TRACK_START:
        case CMD_AO_TRACK_STOP:
        case CMD_AO_TRACK_PAUSE:
        case CMD_AO_TRACK_FLUSH:
        {
            if (HI_NULL == arg)
            {
                HI_ERR_AO("CMD %d Bad arg!\n", cmd);
                return HI_ERR_AO_INVALID_PARA;
            }

            hHandle = *(HI_HANDLE*)arg & AO_TRACK_CHNID_MASK;
            CHECK_AO_TRACK(hHandle);
            break;
        }
        case CMD_AO_TRACK_GETDEFATTR:
        case CMD_AO_TRACK_SETATTR:
        case CMD_AO_TRACK_GETATTR:
        case CMD_AO_TRACK_CREATE:
        case CMD_AO_TRACK_SETWEITHT:
        case CMD_AO_TRACK_GETWEITHT:
        case CMD_AO_TRACK_SETABSGAIN:
        case CMD_AO_TRACK_GETABSGAIN:
#if 0
        case CMD_AO_TRACK_SETPRESCALE:
        case CMD_AO_TRACK_GETPRESCALE:
#endif
        case CMD_AO_TRACK_SETMUTE:
        case CMD_AO_TRACK_GETMUTE:
        case CMD_AO_TRACK_SETCHANNELMODE:
        case CMD_AO_TRACK_GETCHANNELMODE:
        case CMD_AO_TRACK_SETSPEEDADJUST:
        case CMD_AO_TRACK_GETDELAYMS:
        case CMD_AO_TRACK_SETEOSFLAG:
        case CMD_AO_TRACK_SENDDATA:
        case CMD_AO_TRACK_SETPRIORITY:
        case CMD_AO_TRACK_GETPRIORITY:
        case CMD_AO_TRACK_SETFIFOBYPASS:
        case CMD_AO_TRACK_GETFIFOBYPASS:
        case CMD_AO_GETSNDDEFOPENATTR:
        case CMD_AO_TRACK_ATTACHAI:
        case CMD_AO_TRACK_DETACHAI:
        case CMD_AO_SND_OPEN:
        case CMD_AO_SND_CLOSE:
        case CMD_AO_SND_SETMUTE:
        case CMD_AO_SND_GETMUTE:
        case CMD_AO_SND_SETHDMIMODE:
        case CMD_AO_SND_GETHDMIMODE:
        case CMD_AO_SND_SETSPDIFMODE:
        case CMD_AO_SND_GETSPDIFMODE:
        case CMD_AO_SND_SETVOLUME:
        case CMD_AO_SND_GETVOLUME:
        case CMD_AO_SND_SETSAMPLERATE:
        case CMD_AO_SND_GETSAMPLERATE:
        case CMD_AO_SND_SETTRACKMODE:
        case CMD_AO_SND_GETTRACKMODE:
        case CMD_AO_SND_SETALLTRACKMUTE:
        case CMD_AO_SND_GETALLTRACKMUTE:
        case CMD_AO_SND_SETSMARTVOLUME:
        case CMD_AO_SND_GETSMARTVOLUME:
        case CMD_AO_SND_SETLOWLATENCY:
        case CMD_AO_SND_SETSOUNDDELAY:
        case CMD_AO_SND_GETSOUNDDELAY:
#if 0
        case CMD_AO_SND_SETPRECIVOL:
        case CMD_AO_SND_GETPRECIVOL:
        case CMD_AO_SND_SETBALANCE:
        case CMD_AO_SND_GETBALANCE:
        case CMD_AO_SND_SETARCENABLE:
        case CMD_AO_SND_GETARCENABLE:
        case CMD_AO_SND_SETARCMODE:
        case CMD_AO_SND_GETARCMODE:
        case CMD_AO_SND_SETARCCAP: 
        case CMD_AO_SND_GETARCCAP: 
        case CMD_AO_SND_SETPEQATTR:
        case CMD_AO_SND_GETPEQATTR:
        case CMD_AO_SND_SETPEQENABLE:
        case CMD_AO_SND_GETPEQENABLE:
        case CMD_AO_SND_SETAVCATTR:
        case CMD_AO_SND_GETAVCATTR:
        case CMD_AO_SND_SETAVCENABLE:
        case CMD_AO_SND_GETAVCENABLE:
        case CMD_AO_SND_SETGEQATTR:
        case CMD_AO_SND_GETGEQATTR:
        case CMD_AO_SND_SETGEQENABLE:
        case CMD_AO_SND_GETGEQENABLE:
        case CMD_AO_SND_SETGEQGAIN:
        case CMD_AO_SND_GETGEQGAIN:
        case CMD_AO_SND_SETDRCENABLE:
        case CMD_AO_SND_GETDRCENABLE:
        case CMD_AO_SND_SETDRCATTR:
        case CMD_AO_SND_GETDRCATTR:
#endif
        case CMD_AO_SND_ATTACHAEF:
        case CMD_AO_SND_DETACHAEF:
        case CMD_AO_SND_SETAEFBYPASS:
        case CMD_AO_SND_GETAEFBYPASS:
        case CMD_AO_SND_SETSPDIFSCMSMODE:
        case CMD_AO_SND_GETSPDIFSCMSMODE:
        case CMD_AO_SND_SETSPDIFCATEGORYCODE:
        case CMD_AO_SND_GETSPDIFCATEGORYCODE:
        //case CMD_AO_SND_GETTRACKINFO:
        case CMD_AO_SND_GETXRUNCOUNT:
        case CMD_AO_SND_SETADACENABLE:
        case CMD_AO_SND_GETADACENABLE:
		case CMD_AO_SND_SETEXTDELAYMS:
#if 0
        case CMD_AO_SND_GETAEFBUFATTR:
        case CMD_AO_SND_GETDEBUGPARAM:
        case CMD_AO_SND_SETADOUTPUTENABLE:
        case CMD_AO_SND_GETADOUTPUTENABLE:
        case CMD_AO_SND_DUPLICATETRACK:

        case CMD_AO_SND_SETALLCASTMUTE:
        case CMD_AO_SND_GETALLCASTMUTE:
#endif
        case CMD_AO_CAST_GETDEFATTR:
        case CMD_AO_CAST_CREATE:
        case CMD_AO_CAST_DESTROY:
        case CMD_AO_CAST_SETENABLE:
        case CMD_AO_CAST_GETENABLE:
        case CMD_AO_CAST_SETINFO:
        case CMD_AO_CAST_GETINFO:
        case CMD_AO_CAST_ACQUIREFRAME:
        case CMD_AO_CAST_RELEASEFRAME:
        case CMD_AO_CAST_SETABSGAIN:
        case CMD_AO_CAST_GETABSGAIN:
        case CMD_AO_CAST_SETMUTE:
        case CMD_AO_CAST_GETMUTE:
            {
                if (HI_NULL == arg)
                {
                    HI_ERR_AO("CMD %d Bad arg!\n", cmd);
                    return HI_ERR_AO_INVALID_PARA;
                }

                break;
            }
    }

    switch (cmd)
    {
            //Snd CMD TYPE(call hal_aiao)
        case CMD_AO_GETSNDDEFOPENATTR:
        {
            Ret = AOGetSndDefOpenAttr((AO_SND_OpenDefault_Param_S_PTR)arg);
            break;
        }
        case CMD_AO_SND_OPEN:
        {
            DRV_AO_STATE_S* pAOState = file->private_data;
            AO_SND_Open_Param_S_PTR pstSndParam = ( AO_SND_Open_Param_S_PTR )arg;
            enSound = pstSndParam->enSound;
            CHECK_AO_SNDCARD( enSound );

            Ret = AO_Snd_AllocHandle(enSound, file);
            if (HI_SUCCESS == Ret)
            {
                if (0 == atomic_read(&s_stAoDrv.astSndEntity[enSound].atmUseTotalCnt))
                {
                    Ret = AO_SND_Open( enSound, &pstSndParam->stAttr, NULL, HI_FALSE);
                    if (HI_SUCCESS != Ret)
                    {
                        AO_Snd_FreeHandle(enSound, file);
                        break;
                    }
                }
            }

            atomic_inc(&s_stAoDrv.astSndEntity[enSound].atmUseTotalCnt);
            atomic_inc(&pAOState->atmUserOpenCnt[enSound]);

            break;
        }
        case CMD_AO_SND_CLOSE:
        {
            DRV_AO_STATE_S* pAOState = file->private_data;
            enSound = *( HI_UNF_SND_E*)arg;
            CHECK_AO_SNDCARD_OPEN( enSound );

            if (atomic_dec_and_test(&pAOState->atmUserOpenCnt[enSound]))
            {
                if (atomic_dec_and_test(&s_stAoDrv.astSndEntity[enSound].atmUseTotalCnt))
                {
                    Ret = AO_SND_Close( enSound, HI_FALSE );
                    if (HI_SUCCESS != Ret)
                    {
                        atomic_inc(&s_stAoDrv.astSndEntity[enSound].atmUseTotalCnt);
                        atomic_inc(&pAOState->atmUserOpenCnt[enSound]);
                        break;
                    }

                    AO_Snd_FreeHandle(enSound, file);
                }
            }
            else
            {
                atomic_dec(&s_stAoDrv.astSndEntity[enSound].atmUseTotalCnt);
            }
            Ret = HI_SUCCESS;
            break;
        }
        case CMD_AO_SND_SETMUTE:
        {
            AO_SND_Mute_Param_S_PTR pstMute = (AO_SND_Mute_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstMute->enSound );
            Ret = AO_SND_SetMute(pstMute->enSound, pstMute->enOutPort, pstMute->bMute);
            break;
        }

        case CMD_AO_SND_GETMUTE:
        {
            AO_SND_Mute_Param_S_PTR pstMute = (AO_SND_Mute_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstMute->enSound );
            Ret = AO_SND_GetMute(pstMute->enSound, pstMute->enOutPort, &pstMute->bMute);
            break;
        }

        case CMD_AO_SND_SETHDMIMODE:
        {
            AO_SND_HdmiMode_Param_S_PTR pstMode = (AO_SND_HdmiMode_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstMode->enSound );
            Ret = AO_SND_SetHdmiMode(pstMode->enSound, pstMode->enOutPort, pstMode->enMode);
            break;
        }
        case CMD_AO_SND_GETHDMIMODE:
        {
            AO_SND_HdmiMode_Param_S_PTR pstMode = (AO_SND_HdmiMode_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstMode->enSound );
            Ret = AO_SND_GetHdmiMode(pstMode->enSound, pstMode->enOutPort, &pstMode->enMode);
            break;
        }

        case CMD_AO_SND_SETSPDIFMODE:
        {
            AO_SND_SpdifMode_Param_S_PTR pstMode = (AO_SND_SpdifMode_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstMode->enSound );
            Ret = AO_SND_SetSpdifMode(pstMode->enSound, pstMode->enOutPort, pstMode->enMode);
            break;
        }
        case CMD_AO_SND_GETSPDIFMODE:
        {
            AO_SND_SpdifMode_Param_S_PTR pstMode = (AO_SND_SpdifMode_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstMode->enSound );
            Ret = AO_SND_GetSpdifMode(pstMode->enSound, pstMode->enOutPort, &pstMode->enMode);
            break;
        }

        case CMD_AO_SND_SETVOLUME:
        {
            AO_SND_Volume_Param_S_PTR pstVolume = (AO_SND_Volume_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstVolume->enSound );
            Ret = AO_SND_SetVolume(pstVolume->enSound, pstVolume->enOutPort, pstVolume->stGain);
            break;
        }

        case CMD_AO_SND_GETVOLUME:
        {
            AO_SND_Volume_Param_S_PTR pstVolume = (AO_SND_Volume_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstVolume->enSound );
            Ret = AO_SND_GetVolume(pstVolume->enSound, pstVolume->enOutPort, &pstVolume->stGain);
            break;
        }

        case CMD_AO_SND_SETSPDIFSCMSMODE:
        {
            AO_SND_SpdifSCMSMode_Param_S_PTR pstSCMSMode = (AO_SND_SpdifSCMSMode_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstSCMSMode->enSound );
            Ret = AO_SND_SetSpdifSCMSMode(pstSCMSMode->enSound, pstSCMSMode->enOutPort, pstSCMSMode->enSCMSMode);
            break;
        }
        case CMD_AO_SND_GETSPDIFSCMSMODE:
        {
            AO_SND_SpdifSCMSMode_Param_S_PTR pstSCMSMode = (AO_SND_SpdifSCMSMode_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstSCMSMode->enSound );
            Ret = AO_SND_GetSpdifSCMSMode(pstSCMSMode->enSound, pstSCMSMode->enOutPort, &pstSCMSMode->enSCMSMode);
            break;
        }

        case CMD_AO_SND_SETSPDIFCATEGORYCODE:
        {
            AO_SND_SpdifCategoryCode_Param_S_PTR pstCategoryCode = (AO_SND_SpdifCategoryCode_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstCategoryCode->enSound );
            Ret = AO_SND_SetSpdifCategoryCode(pstCategoryCode->enSound, pstCategoryCode->enOutPort, pstCategoryCode->enCategoryCode);
            break;
        }
        case CMD_AO_SND_GETSPDIFCATEGORYCODE:
        {
            AO_SND_SpdifCategoryCode_Param_S_PTR pstCategoryCode = (AO_SND_SpdifCategoryCode_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstCategoryCode->enSound );
            Ret = AO_SND_GetSpdifCategoryCode(pstCategoryCode->enSound, pstCategoryCode->enOutPort, &pstCategoryCode->enCategoryCode);
            break;
        }
        case CMD_AO_SND_SETSAMPLERATE:
        {
            AO_SND_SampleRate_Param_S_PTR pstSampleRate = (AO_SND_SampleRate_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstSampleRate->enSound );
            Ret = AO_SND_SetSampleRate(pstSampleRate->enSound, pstSampleRate->enOutPort, pstSampleRate->enSampleRate);
            break;
        }

        case CMD_AO_SND_GETSAMPLERATE:
        {
            AO_SND_SampleRate_Param_S_PTR pstSampleRate = (AO_SND_SampleRate_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstSampleRate->enSound );
            Ret = AO_SND_GetSampleRate(pstSampleRate->enSound, pstSampleRate->enOutPort, &pstSampleRate->enSampleRate);
            break;
        }

        case CMD_AO_SND_SETTRACKMODE:
        {
            AO_SND_TrackMode_Param_S_PTR pstMode = (AO_SND_TrackMode_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstMode->enSound );
            Ret = AO_SND_SetTrackMode(pstMode->enSound, pstMode->enOutPort, pstMode->enMode);
            break;
        }

        case CMD_AO_SND_GETTRACKMODE:
        {
            AO_SND_TrackMode_Param_S_PTR pstMode = (AO_SND_TrackMode_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstMode->enSound );
            Ret = AO_SND_GetTrackMode(pstMode->enSound, pstMode->enOutPort, &pstMode->enMode);
            break;
        }

        case CMD_AO_SND_SETALLTRACKMUTE:
        {
            AO_SND_AllTrackMute_Param_S_PTR pstAllMute = (AO_SND_AllTrackMute_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstAllMute->enSound );
            Ret = AO_SND_SetAllTrackMute(pstAllMute->enSound, pstAllMute->bMute);
            break;
        }
        case CMD_AO_SND_GETALLTRACKMUTE:
        {
            AO_SND_AllTrackMute_Param_S_PTR pstAllMute = (AO_SND_AllTrackMute_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstAllMute->enSound );
            Ret = AO_SND_GetAllTrackMute(pstAllMute->enSound, &pstAllMute->bMute);
            break;
        }
        case CMD_AO_SND_SETSMARTVOLUME:
        {
            AO_SND_SmartVolume_Param_S_PTR pstSmartVol = (AO_SND_SmartVolume_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstSmartVol->enSound );
            Ret = AO_SND_SetSmartVolume(pstSmartVol->enSound, pstSmartVol->enOutPort, pstSmartVol->bSmartVolume);
            break;
        }

        case CMD_AO_SND_GETSMARTVOLUME:
        {
            AO_SND_SmartVolume_Param_S_PTR pstSmartVol = (AO_SND_SmartVolume_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstSmartVol->enSound );
            Ret = AO_SND_GetSmartVolume(pstSmartVol->enSound, pstSmartVol->enOutPort, &pstSmartVol->bSmartVolume);
            break;
        }

        case CMD_AO_SND_SETLOWLATENCY:
        {
            AO_SND_Set_LowLatency_Param_S_PTR pstLowLatencyParam = (AO_SND_Set_LowLatency_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN(pstLowLatencyParam->enSound);
            Ret = AO_Snd_SetLowLatency(pstLowLatencyParam->enSound,pstLowLatencyParam->eOutPort, pstLowLatencyParam->u32LatencyMs);
            break;
        }

        case CMD_AO_SND_GETLOWLATENCY:
        {
            AO_SND_Set_LowLatency_Param_S_PTR pstLowLatencyParam = (AO_SND_Set_LowLatency_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN(pstLowLatencyParam->enSound);
            Ret = AO_Snd_GetLowLatency(pstLowLatencyParam->enSound,pstLowLatencyParam->eOutPort, &pstLowLatencyParam->u32LatencyMs);
            break;
        }
#ifdef HI_SOUND_SPDIF_COMPENSATION_SUPPORT
        case CMD_AO_SND_SETSOUNDDELAY:
        {
            AO_SND_SoundSetDelay_Param_S_PTR pstSetDelay = (AO_SND_SoundSetDelay_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstSetDelay->enSound );
            Ret = AO_SND_SetDelayCompensation(pstSetDelay->enSound, pstSetDelay->enOutPort, pstSetDelay->u32DelayMs);
            break;
        }

        case CMD_AO_SND_GETSOUNDDELAY:
        {
            AO_SND_SoundSetDelay_Param_S_PTR pstSetDelay = (AO_SND_SoundSetDelay_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstSetDelay->enSound );
            Ret = AO_SND_GetDelayCompensation(pstSetDelay->enSound, pstSetDelay->enOutPort, &pstSetDelay->u32DelayMs);
            break;
        }
#endif

#if 0
        case CMD_AO_SND_SETPRECIVOL:
        {
            AO_SND_PreciVolume_Param_S_PTR pstPreciVol = (AO_SND_PreciVolume_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstPreciVol->enSound );
            Ret = AO_SND_SetPreciVol(pstPreciVol->enSound, pstPreciVol->enOutPort, pstPreciVol->stPreciGain);
            break;
        }

        case CMD_AO_SND_GETPRECIVOL:
        {
            AO_SND_PreciVolume_Param_S_PTR pstPreciVol = (AO_SND_PreciVolume_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstPreciVol->enSound );
            Ret = AO_SND_GetPreciVol(pstPreciVol->enSound, pstPreciVol->enOutPort, &pstPreciVol->stPreciGain);
            break;
        }

        case CMD_AO_SND_SETBALANCE:
        {
            AO_SND_Balance_Param_S_PTR pstBalance = (AO_SND_Balance_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstBalance->enSound );
            Ret = AO_SND_SetBalance(pstBalance->enSound, pstBalance->enOutPort, pstBalance->s32Balance);
            break;
        }

        case CMD_AO_SND_GETBALANCE:
        {
            AO_SND_Balance_Param_S_PTR pstBalance = (AO_SND_Balance_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstBalance->enSound );
            Ret = AO_SND_GetBalance(pstBalance->enSound, pstBalance->enOutPort, &pstBalance->s32Balance);
            break;
        }
    
        case CMD_AO_SND_SETARCENABLE:
        {
            AO_SND_ARC_ENABLE_Param_S_PTR pstArcEnable = (AO_SND_ARC_ENABLE_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstArcEnable->enSound );
            Ret = AO_SND_SetArcEnable(pstArcEnable->enSound, pstArcEnable->enOutPort, pstArcEnable->bEnable);
            break;
        }   
        
        case CMD_AO_SND_GETARCENABLE:
        {
            AO_SND_ARC_ENABLE_Param_S_PTR pstArcEnable = (AO_SND_ARC_ENABLE_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstArcEnable->enSound );
            Ret = AO_SND_GetArcEnable(pstArcEnable->enSound, pstArcEnable->enOutPort, &pstArcEnable->bEnable);
            break;
        }   
        
        case CMD_AO_SND_SETARCMODE:
        {
            AO_SND_ARC_MODE_Param_S_PTR pstArcMode = (AO_SND_ARC_MODE_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstArcMode->enSound );
            Ret = AO_SND_SetArcMode(pstArcMode->enSound, pstArcMode->enOutPort, pstArcMode->enMode);
            break;
        }     
        
        case CMD_AO_SND_GETARCMODE:
        {
            AO_SND_ARC_MODE_Param_S_PTR pstArcMode = (AO_SND_ARC_MODE_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstArcMode->enSound );
            Ret = AO_SND_GetArcMode(pstArcMode->enSound, pstArcMode->enOutPort, &pstArcMode->enMode);
            break;
        }   
        
        case CMD_AO_SND_SETARCCAP:
        {
            AO_SND_ARC_CAP_Param_S_PTR pstArcCap = (AO_SND_ARC_CAP_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstArcCap->enSound );
            Ret = AO_SND_SetArcCap(pstArcCap->enSound, pstArcCap->enOutPort, pstArcCap->stCap);
            break;
        }     
        
        case CMD_AO_SND_GETARCCAP:
        {
            AO_SND_ARC_CAP_Param_S_PTR pstArcCap = (AO_SND_ARC_CAP_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstArcCap->enSound );
            Ret = AO_SND_GetArcCap(pstArcCap->enSound, pstArcCap->enOutPort, &pstArcCap->stCap);
            break;
        }    

        case CMD_AO_SND_SETAVCATTR:
        {
            AO_SND_Avc_Param_S_PTR pstAvcAttr = (AO_SND_Avc_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstAvcAttr->enSound );
            Ret = AO_SND_SetAvcAttr(pstAvcAttr->enSound, &pstAvcAttr->stAvcAttr);
            break;
        }

        case CMD_AO_SND_GETAVCATTR:
        {
            AO_SND_Avc_Param_S_PTR pstAvcAttr = (AO_SND_Avc_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstAvcAttr->enSound );
            Ret = AO_SND_GetAvcAttr(pstAvcAttr->enSound, &pstAvcAttr->stAvcAttr);
            break;
        }

        case CMD_AO_SND_SETAVCENABLE:
        {
            AO_SND_Avc_Enable_S_PTR pstAvcEanble = (AO_SND_Avc_Enable_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstAvcEanble->enSound );
            Ret = AO_SND_SetAvcEnable(pstAvcEanble->enSound, pstAvcEanble->bAvcEnable);
            break;
        }

        case CMD_AO_SND_GETAVCENABLE:
        {
            AO_SND_Avc_Enable_S_PTR pstAvcEanble = (AO_SND_Avc_Enable_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstAvcEanble->enSound );
            Ret = AO_SND_GetAvcEnable(pstAvcEanble->enSound, &pstAvcEanble->bAvcEnable);
            break;
        }

        case CMD_AO_SND_SETGEQATTR:
        {
            AO_SND_Geq_Param_S_PTR pstGeqAttr = (AO_SND_Geq_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstGeqAttr->enSound );
            Ret = AO_SND_SetGeqAttr(pstGeqAttr->enSound, &pstGeqAttr->stEqAttr);
            break;
        }

        case CMD_AO_SND_GETGEQATTR:
        {
            AO_SND_Geq_Param_S_PTR pstGeqAttr = (AO_SND_Geq_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstGeqAttr->enSound );
            Ret = AO_SND_GetGeqAttr(pstGeqAttr->enSound, &pstGeqAttr->stEqAttr);
            break;
        }

        case CMD_AO_SND_SETGEQENABLE:
        {
            AO_SND_Eq_Enable_S_PTR pstGeqEanble = (AO_SND_Eq_Enable_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstGeqEanble->enSound );
            Ret = AO_SND_SetGeqEnable(pstGeqEanble->enSound, pstGeqEanble->bEqEnable);
            break;
        }

        case CMD_AO_SND_GETGEQENABLE:
        {
            AO_SND_Eq_Enable_S_PTR pstGeqEanble = (AO_SND_Eq_Enable_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstGeqEanble->enSound );
            Ret = AO_SND_GetGeqEnable(pstGeqEanble->enSound, &pstGeqEanble->bEqEnable);
            break;
        }

        case CMD_AO_SND_SETGEQGAIN:
        {
            AO_SND_Geq_Gain_S_PTR pstGeqGain = (AO_SND_Geq_Gain_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstGeqGain->enSound );
            Ret = AO_SND_SetGeqGain(pstGeqGain->enSound, pstGeqGain->u32Band, pstGeqGain->s32Gain);
            break;
        }

        case CMD_AO_SND_GETGEQGAIN:
        {
            AO_SND_Geq_Gain_S_PTR pstGeqGain = (AO_SND_Geq_Gain_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstGeqGain->enSound );
            Ret = AO_SND_GetGeqGain(pstGeqGain->enSound, pstGeqGain->u32Band, &pstGeqGain->s32Gain);
            break;
        }

        case CMD_AO_SND_SETDRCENABLE:
        {
            AO_SND_Drc_Enable_S_PTR pstDrcEanble = (AO_SND_Drc_Enable_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstDrcEanble->enSound );
            Ret = AO_SND_SetDrcEnable(pstDrcEanble->enSound, pstDrcEanble->enOutPort, pstDrcEanble->bDrcEnable);
            break;
        }

        case CMD_AO_SND_GETDRCENABLE:
        {
            AO_SND_Drc_Enable_S_PTR pstDrcEanble = (AO_SND_Drc_Enable_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstDrcEanble->enSound );
            Ret = AO_SND_GetDrcEnable(pstDrcEanble->enSound, pstDrcEanble->enOutPort, &pstDrcEanble->bDrcEnable);
            break;
        }

        case CMD_AO_SND_SETDRCATTR:
        {
            AO_SND_Drc_Param_S_PTR pstDrcAttr = (AO_SND_Drc_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstDrcAttr->enSound );
            Ret = AO_SND_SetDrcAttr(pstDrcAttr->enSound, pstDrcAttr->enOutPort, &pstDrcAttr->stDrcAttr);
            break;
        }

        case CMD_AO_SND_GETDRCATTR:
        {
            AO_SND_Drc_Param_S_PTR pstDrcAttr = (AO_SND_Drc_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstDrcAttr->enSound );
            Ret = AO_SND_GetDrcAttr(pstDrcAttr->enSound, pstDrcAttr->enOutPort, &pstDrcAttr->stDrcAttr);
            break;
        }

        case CMD_AO_SND_SETPEQATTR:
        {
            AO_SND_Peq_Param_S_PTR pstPeqAttr = (AO_SND_Peq_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstPeqAttr->enSound );
            Ret = AO_SND_SetPeqAttr(pstPeqAttr->enSound, pstPeqAttr->enOutPort, &pstPeqAttr->stEqAttr);
            break;
        }

        case CMD_AO_SND_GETPEQATTR:
        {
            AO_SND_Peq_Param_S_PTR pstPeqAttr = (AO_SND_Peq_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstPeqAttr->enSound );

            Ret = AO_SND_GetPeqAttr(pstPeqAttr->enSound, pstPeqAttr->enOutPort, &pstPeqAttr->stEqAttr);
            break;
        }

        case CMD_AO_SND_SETPEQENABLE:
        {
            AO_SND_Eq_Enable_S_PTR pstPeqEanble = (AO_SND_Eq_Enable_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstPeqEanble->enSound );
            Ret = AO_SND_SetPeqEnable(pstPeqEanble->enSound, pstPeqEanble->enOutPort, pstPeqEanble->bEqEnable);
            break;
        }

        case CMD_AO_SND_GETPEQENABLE:
        {
            AO_SND_Eq_Enable_S_PTR pstPeqEanble = (AO_SND_Eq_Enable_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstPeqEanble->enSound );
            Ret = AO_SND_GetPeqEnable(pstPeqEanble->enSound, pstPeqEanble->enOutPort, &pstPeqEanble->bEqEnable);
            break;
        }
#endif
        case CMD_AO_SND_ATTACHAEF:
        {
            AO_SND_AttAef_Param_S_PTR pstSndAttAef = (AO_SND_AttAef_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN(pstSndAttAef->enSound);
            Ret = AO_SND_AttachAef(pstSndAttAef->enSound, pstSndAttAef->u32AefId, &pstSndAttAef->stAefAttr, &pstSndAttAef->u32AefProcAddr);
            break;
        }

        case CMD_AO_SND_DETACHAEF:
        {
            AO_SND_AttAef_Param_S_PTR pstSndAttAef = (AO_SND_AttAef_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN(pstSndAttAef->enSound);
            Ret = AO_SND_DetachAef(pstSndAttAef->enSound, pstSndAttAef->u32AefId, &pstSndAttAef->stAefAttr);
            break;
        }

        case CMD_AO_SND_SETAEFBYPASS:
        {
            AO_SND_AefBypass_Param_S_PTR pstAefBypass = (AO_SND_AefBypass_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN(pstAefBypass->enSound);
            Ret = AO_SND_SetAefBypass(pstAefBypass->enSound, pstAefBypass->enOutPort, pstAefBypass->bBypass);
            break;
        }

        case CMD_AO_SND_GETAEFBYPASS:
        {
            AO_SND_AefBypass_Param_S_PTR pstAefBypass = (AO_SND_AefBypass_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN(pstAefBypass->enSound);
            Ret = AO_SND_GetAefBypass(pstAefBypass->enSound, pstAefBypass->enOutPort, &pstAefBypass->bBypass);
            break;
        }

#if 0
        case CMD_AO_SND_GETTRACKINFO:
        {
            AO_SND_TrackInfo_Param_S_PTR pstTrackInfo = (AO_SND_TrackInfo_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN(pstTrackInfo->enSound);
            Ret = AO_SND_GetTrackInfo(pstTrackInfo->enSound, &pstTrackInfo->stTrackInfo);
            break;
        }
#endif

        case CMD_AO_SND_GETXRUNCOUNT:
        {
            AO_SND_Get_Xrun_Param_S_PTR pstXrunStatus = (AO_SND_Get_Xrun_Param_S_PTR)arg;

            CHECK_AO_SNDCARD_OPEN(pstXrunStatus->enSound);
            Ret = AO_Snd_GetXRunCount(pstXrunStatus->enSound, &pstXrunStatus->u32Count);

            break;
        }
        case CMD_AO_SND_SETADACENABLE:
        {
            AO_SND_Adac_Enable_Param_S_PTR pstAdacEnable = (AO_SND_Adac_Enable_Param_S_PTR)arg;
    
            CHECK_AO_SNDCARD_OPEN(pstAdacEnable->enSound);
            Ret = AO_Snd_SetAdacEnable(pstAdacEnable->enSound, pstAdacEnable->bEnable);
    
            break;
        }
        case CMD_AO_SND_GETADACENABLE:
        {
            AO_SND_Adac_Enable_Param_S_PTR pstAdacEnable = (AO_SND_Adac_Enable_Param_S_PTR)arg;
    
            CHECK_AO_SNDCARD_OPEN(pstAdacEnable->enSound);
            Ret = AO_Snd_GetAdacEnable(pstAdacEnable->enSound, &pstAdacEnable->bEnable);
    
            break;
        }
#if 0
        case CMD_AO_SND_GETAEFBUFATTR:
        {
            AO_SND_Aef_Buf_Param_S_PTR pstAefBuf = (AO_SND_Aef_Buf_Param_S_PTR)arg;

            CHECK_AO_SNDCARD_OPEN(pstAefBuf->enSound);
            Ret = AO_Snd_GetAefBufAttr(pstAefBuf->enSound, &pstAefBuf->stAefBuf);

            break;
        }        
        case CMD_AO_SND_GETDEBUGPARAM:
        {
            AO_SND_DEBUG_Param_S_PTR pstDebug = (AO_SND_DEBUG_Param_S_PTR)arg;

            CHECK_AO_SNDCARD_OPEN(pstDebug->enSound);
            Ret = AO_Snd_GetDebugAttr(pstDebug->enSound, &pstDebug->stDebugAttr);
            break;
        }
        case CMD_AO_SND_SETADOUTPUTENABLE:
        {
            AO_SND_ADOutput_Enable_S_PTR pstADOutputEanble = (AO_SND_ADOutput_Enable_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstADOutputEanble->enSound );
            Ret = AO_SND_SetADOutputEnable(pstADOutputEanble->enSound, pstADOutputEanble->enOutPort, pstADOutputEanble->bADOutputEnable);
            break;
        }
        case CMD_AO_SND_GETADOUTPUTENABLE:
        {
            AO_SND_ADOutput_Enable_S_PTR pstADOutputEanble = (AO_SND_ADOutput_Enable_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstADOutputEanble->enSound );
            Ret = AO_SND_GetADOutputEnable(pstADOutputEanble->enSound, pstADOutputEanble->enOutPort, &pstADOutputEanble->bADOutputEnable);
            break;
        }
        case CMD_AO_SND_DUPLICATETRACK:
        {
            AO_SND_TrackDuplicate_Param_S_PTR pstDuplicateTrack = (AO_SND_TrackDuplicate_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN( pstDuplicateTrack->enSound );
            Ret = AO_SND_TrackDuplicate(pstDuplicateTrack->enSound, pstDuplicateTrack->enOutPort, 
                                        pstDuplicateTrack->hTrack, pstDuplicateTrack->bEnable);
            break;
        }

        case CMD_AO_SND_SETALLCASTMUTE:
        {
            AO_SND_AllCastMute_Param_S_PTR pstAllCastMute = (AO_SND_AllCastMute_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN(pstAllCastMute->enSound);
            Ret = AO_SND_SetAllCastMute(pstAllCastMute->enSound, pstAllCastMute->bMute);
            break;
        }
        case CMD_AO_SND_GETALLCASTMUTE:
        {
            AO_SND_AllCastMute_Param_S_PTR pstAllCastMute = (AO_SND_AllCastMute_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN(pstAllCastMute->enSound);
            Ret = AO_SND_GetAllCastMute(pstAllCastMute->enSound, &pstAllCastMute->bMute);
            break;
        }
#endif

        case CMD_AO_CAST_GETDEFATTR:
        {
            HI_UNF_SND_CAST_ATTR_S* pstDefAttr = (HI_UNF_SND_CAST_ATTR_S*)arg;
            Ret = AO_Cast_GetDefAttr(pstDefAttr);
            break;
        }
        case CMD_AO_CAST_CREATE:
        {
            AO_Cast_Create_Param_S_PTR  pstCastAttr = (AO_Cast_Create_Param_S_PTR)arg;

            //HI_ERR_AO("CMD_AO_CAST_CREATE\n");
            CHECK_AO_SNDCARD_OPEN( pstCastAttr->enSound);

            if (HI_SUCCESS == AO_Cast_AllocHandle(&hHandle, file, &pstCastAttr->stCastAttr))
            {
                Ret = AO_Cast_Create(pstCastAttr->enSound, &pstCastAttr->stCastAttr, &s_stAoDrv.astCastEntity[hHandle
                                     & AO_CAST_CHNID_MASK].stRbfMmz,
                                     hHandle);
                if (HI_SUCCESS != Ret)
                {
                    AO_Cast_FreeHandle(hHandle);
                    break;
                }

                AO_Cast_SaveSuspendAttr(pstCastAttr->enSound, hHandle, &pstCastAttr->stCastAttr);
                pstCastAttr->u32ReqSize = s_stAoDrv.astCastEntity[hHandle & AO_CAST_CHNID_MASK].u32ReqSize;
                pstCastAttr->hCast = hHandle;
            }
            break;
        }
        case CMD_AO_CAST_DESTROY:
        {
            HI_HANDLE  hCast = *(HI_HANDLE*)arg;
            //HI_ERR_AO("CMD_AO_CAST_DESTORY\n");

            CHECK_AO_CAST_OPEN(hCast);
            Ret = AO_Cast_Destory(hCast);
            if (HI_SUCCESS != Ret)
            {
                break;
            }
            AO_Cast_FreeHandle(hCast);
            break;
        }

        case CMD_AO_CAST_SETINFO:
        {
            AO_Cast_Info_Param_S_PTR pstInfo = (AO_Cast_Info_Param_S_PTR)arg;
            CHECK_AO_CAST_OPEN(pstInfo->hCast);

            //HI_ERR_AO("CMD_AO_CAST_SETINFO  CastID=0x%x, pu8UserVirtAddr=0x%p\n",pstInfo->hCast, pstInfo->pu8UserVirtAddr);
            Ret = AO_Cast_SetInfo(pstInfo->hCast, pstInfo->tUserVirtAddr);
            break;
        }
        case CMD_AO_CAST_GETINFO:
        {
            AO_Cast_Info_Param_S_PTR pstInfo = (AO_Cast_Info_Param_S_PTR)arg;
            //HI_ERR_AO("pstInfo->hCast=0x%x \n", pstInfo->hCast);
            CHECK_AO_CAST_OPEN(pstInfo->hCast);
            Ret = AO_Cast_GetInfo(pstInfo->hCast, pstInfo);
            //HI_ERR_AO("CMD_AO_CAST_GETINFO  CastID=0x%x, pu8UserVirtAddr=0x%p Ret=0x%x\n",pstInfo->hCast, pstInfo->pu8UserVirtAddr, Ret);
            break;
        }

        case CMD_AO_CAST_SETENABLE:
        {
            AO_Cast_Enable_Param_S_PTR pstEnable = (AO_Cast_Enable_Param_S_PTR)arg;
            CHECK_AO_CAST_OPEN(pstEnable->hCast);
            //HI_ERR_AO("CMD_AO_CAST_SETENABLE  CastID=0x%x, bCastEnable=0x%x\n",pstEnable->hCast, pstEnable->bCastEnable);
            Ret = AO_Cast_SetEnable(pstEnable->hCast, pstEnable->bCastEnable);
            break;
        }

        case CMD_AO_CAST_GETENABLE:
        {
            AO_Cast_Enable_Param_S_PTR pstEnable = (AO_Cast_Enable_Param_S_PTR)arg;
            CHECK_AO_CAST_OPEN(pstEnable->hCast);
            //HI_ERR_AO("CMD_AO_CAST_GETENABLE CastID=0x%x, bCastEnable=0x%x\n",pstEnable->hCast, pstEnable->bCastEnable);
            Ret = AO_Cast_GetEnable(pstEnable->hCast, &pstEnable->bCastEnable);
            break;
        }

        case CMD_AO_CAST_ACQUIREFRAME:
        {
            AO_Cast_Data_Param_S_PTR pstCastData = (AO_Cast_Data_Param_S_PTR)arg;
            CHECK_AO_CAST_OPEN(pstCastData->hCast);

            Ret = AO_Cast_ReadData(pstCastData->hCast, pstCastData);
            break;
        }
        case CMD_AO_CAST_RELEASEFRAME:
        {
            AO_Cast_Data_Param_S_PTR pstCastData = (AO_Cast_Data_Param_S_PTR)arg;
            CHECK_AO_CAST_OPEN(pstCastData->hCast);
            //HI_ERR_AO("CMD_AO_CAST_RELEASEFRAME  CastID=0x%x\n",pstCastData->hCast);
            Ret = AO_Cast_ReleseData(pstCastData->hCast, pstCastData);

            break;
        }
        case CMD_AO_CAST_SETABSGAIN:
        {
            AO_Cast_AbsGain_Param_S_PTR pstAbsGain = (AO_Cast_AbsGain_Param_S_PTR)arg;
            CHECK_AO_CAST_OPEN(pstAbsGain->hCast);
            Ret = AO_Cast_SetAbsGain(pstAbsGain->hCast, pstAbsGain->stCastAbsGain);
            break;
        }
        case CMD_AO_CAST_GETABSGAIN:
        {
            AO_Cast_AbsGain_Param_S_PTR pstAbsGain = (AO_Cast_AbsGain_Param_S_PTR)arg;
            CHECK_AO_CAST_OPEN(pstAbsGain->hCast);
            Ret = AO_Cast_GetAbsGain(pstAbsGain->hCast, &pstAbsGain->stCastAbsGain);
            break;
        }
        case CMD_AO_CAST_SETMUTE:
        {
            AO_Cast_Mute_Param_S_PTR pstMute = (AO_Cast_Mute_Param_S_PTR)arg;
            CHECK_AO_CAST_OPEN(pstMute->hCast);
            Ret = AO_Cast_SetMute(pstMute->hCast, pstMute->bMute);
            break;
        }
        case CMD_AO_CAST_GETMUTE:
        {
            AO_Cast_Mute_Param_S_PTR pstMute = (AO_Cast_Mute_Param_S_PTR)arg;
            CHECK_AO_CAST_OPEN(pstMute->hCast);
            Ret = AO_Cast_GetMute(pstMute->hCast, &pstMute->bMute);
            break;
        }

        case CMD_AO_SND_ATTACHTRACK:
            break;
        case CMD_AO_SND_DETACHTRACK:
            break;

            //Track CMD TYPE (call hal_aoe)
        case CMD_AO_TRACK_GETDEFATTR:
        {
            HI_UNF_AUDIOTRACK_ATTR_S* pstDefAttr = (HI_UNF_AUDIOTRACK_ATTR_S*)arg;
            Ret = AO_Track_GetDefAttr(pstDefAttr);
            break;
        }
        case CMD_AO_TRACK_SETATTR:
        {
            AO_Track_Attr_Param_S_PTR pstTrackAttr = (AO_Track_Attr_Param_S_PTR)arg;
            CHECK_AO_TRACK_OPEN(pstTrackAttr->hTrack);
            Ret = AO_Track_PreSetAttr(pstTrackAttr->hTrack, &pstTrackAttr->stAttr);
            break;
        }
        
        case CMD_AO_TRACK_GETATTR:
        {
            AO_Track_Attr_Param_S_PTR pstTrackAttr = (AO_Track_Attr_Param_S_PTR)arg;
            CHECK_AO_TRACK_OPEN(pstTrackAttr->hTrack);
            Ret = AO_Track_GetAttr(pstTrackAttr->hTrack, &pstTrackAttr->stAttr);
            break;
        }
        
        case CMD_AO_TRACK_MMAPTRACKATTR:
        {
            AO_Track_GetTrackMapInfo_Param_S_PTR pstTrackMapInfo = (AO_Track_GetTrackMapInfo_Param_S_PTR)arg;
            CHECK_AO_TRACK_OPEN(pstTrackMapInfo->hTrack);
            Ret = AO_Track_MmapTrackAttr(pstTrackMapInfo->hTrack, pstTrackMapInfo);
            break;
        }

        case CMD_AO_TRACK_CREATE:
        {
            AO_Track_Create_Param_S_PTR pstTrack = (AO_Track_Create_Param_S_PTR)arg;
            Ret = AO_Track_AllocHandle(&hHandle, pstTrack->stAttr.enTrackType, file);
            if (HI_SUCCESS == Ret)
            {
                Ret = AO_Track_PreCreate(pstTrack->enSound, &pstTrack->stAttr, pstTrack->bAlsaTrack,
                                     &pstTrack->stBuf, hHandle);
                if (HI_SUCCESS != Ret)
                {
                    AO_Track_FreeHandle(hHandle);
                    break;
                }

                //AO_SND_UpdateTrackInfo(hHandle, HI_TRUE);
                AO_TRACK_SaveSuspendAttr(hHandle, pstTrack);
                pstTrack->hTrack = hHandle;
            }

            break;
        }

        case CMD_AO_TRACK_DESTROY:
        {
            HI_HANDLE hTrack = *(HI_HANDLE*)arg;
            CHECK_AO_TRACK_OPEN(hTrack);

            //AO_SND_UpdateTrackInfo(hTrack, HI_FALSE);

            Ret = AO_Track_Destory(hTrack);
            if (HI_SUCCESS != Ret)
            {
                HI_ERR_AO("AO_Track_Destory failed Ret %x\n",Ret);
                break;
            }

            AO_Track_FreeHandle(hTrack);

            break;
        }
        case CMD_AO_TRACK_START:
        {
            HI_HANDLE hTrack = *(HI_HANDLE*)arg;
            CHECK_AO_TRACK_OPEN(hTrack);
            Ret = AO_Track_Start(hTrack);
            if(Ret != HI_SUCCESS)
            {
                HI_ERR_AO("AO_Track_Start failed %x\n",Ret);
            }
            break;
        }

        case CMD_AO_TRACK_STOP:
        {
            HI_HANDLE hTrack = *(HI_HANDLE*)arg;
            CHECK_AO_TRACK_OPEN(hTrack);
            Ret = AO_Track_Stop(hTrack);
            if(Ret != HI_SUCCESS)
            {
                HI_ERR_AO("AO_Track_Stop failed %x\n",Ret);
            }
            break;
        }

        case CMD_AO_TRACK_PAUSE:
        {
            HI_HANDLE hTrack = *(HI_HANDLE*)arg;
            CHECK_AO_TRACK_OPEN(hTrack);
            Ret = AO_Track_Pause(hTrack);
            break;
        }

        case CMD_AO_TRACK_FLUSH:
        {
            HI_HANDLE hTrack = *(HI_HANDLE*)arg;
            CHECK_AO_TRACK_OPEN(hTrack);
            Ret = AO_Track_Flush(hTrack);
            break;
        }

        case CMD_AO_TRACK_SENDDATA:
        {
            AO_Track_SendData_Param_S_PTR pstData = (AO_Track_SendData_Param_S_PTR)arg;
            CHECK_AO_TRACK_OPEN(pstData->hTrack);
            Ret = AO_Track_SendData(pstData->hTrack, &pstData->stAOFrame);
            if (HI_FAILURE == Ret)
            {
                HI_ERR_AO("AO_Track_SendData failed %x\n",Ret);
            }

            break;
        }

        case CMD_AO_TRACK_SETWEITHT:
        {
            AO_Track_Weight_Param_S_PTR pstWeight = (AO_Track_Weight_Param_S_PTR)arg;
            CHECK_AO_TRACK_OPEN(pstWeight->hTrack);
            Ret = AO_Track_SetWeight(pstWeight->hTrack, pstWeight->stTrackGain);
            break;
        }

        case CMD_AO_TRACK_GETWEITHT:
        {
            AO_Track_Weight_Param_S_PTR pstWeight = (AO_Track_Weight_Param_S_PTR)arg;
            CHECK_AO_TRACK_OPEN(pstWeight->hTrack);
            Ret = AO_Track_GetWeight(pstWeight->hTrack, &pstWeight->stTrackGain);
            break;
        }

        case CMD_AO_TRACK_SETABSGAIN:
        {
            AO_Track_AbsGain_Param_S_PTR pstAbsGain = (AO_Track_AbsGain_Param_S_PTR)arg;
            CHECK_AO_TRACK_OPEN(pstAbsGain->hTrack);
            Ret = AO_Track_SetAbsGain(pstAbsGain->hTrack, pstAbsGain->stTrackAbsGain);
            break;
        }

        case CMD_AO_TRACK_GETABSGAIN:
        {
            AO_Track_AbsGain_Param_S_PTR pstAbsGain = (AO_Track_AbsGain_Param_S_PTR)arg;
            CHECK_AO_TRACK_OPEN(pstAbsGain->hTrack);
            Ret = AO_Track_GetAbsGain(pstAbsGain->hTrack, &pstAbsGain->stTrackAbsGain);
            break;
        }

#if 0
        case CMD_AO_TRACK_SETPRESCALE:
        {
            AO_Track_Prescale_Param_S_PTR pstPrescale = (AO_Track_Prescale_Param_S_PTR)arg;
            CHECK_AO_TRACK_OPEN(pstPrescale->hTrack);
            Ret = AO_Track_SetPrescale(pstPrescale->hTrack, pstPrescale->stPreciGain);
            break;
        }

        case CMD_AO_TRACK_GETPRESCALE:
        {
            AO_Track_Prescale_Param_S_PTR pstPrescale = (AO_Track_Prescale_Param_S_PTR)arg;
            CHECK_AO_TRACK_OPEN(pstPrescale->hTrack);
            Ret = AO_Track_GetPrescale(pstPrescale->hTrack, &pstPrescale->stPreciGain);
            break;
        }
#endif

        case CMD_AO_TRACK_SETMUTE:
        {
            AO_Track_Mute_Param_S_PTR pstMute = (AO_Track_Mute_Param_S_PTR)arg;
            CHECK_AO_TRACK_OPEN(pstMute->hTrack);
            Ret = AO_Track_SetMute(pstMute->hTrack, pstMute->bMute);
            break;
        }
        case CMD_AO_TRACK_GETMUTE:
        {
            AO_Track_Mute_Param_S_PTR pstMute = (AO_Track_Mute_Param_S_PTR)arg;
            CHECK_AO_TRACK_OPEN(pstMute->hTrack);
            Ret = AO_Track_GetMute(pstMute->hTrack, &pstMute->bMute);
            break;
        }

        case CMD_AO_TRACK_SETCHANNELMODE:
        {
            AO_Track_ChannelMode_Param_S_PTR pstChannelMode = (AO_Track_ChannelMode_Param_S_PTR)arg;
            CHECK_AO_TRACK_OPEN(pstChannelMode->hTrack);
            Ret = AO_Track_SetChannelMode(pstChannelMode->hTrack, pstChannelMode->enMode);
            break;
        }
        case CMD_AO_TRACK_GETCHANNELMODE:
        {
            AO_Track_ChannelMode_Param_S_PTR pstChannelMode = (AO_Track_ChannelMode_Param_S_PTR)arg;
            CHECK_AO_TRACK_OPEN(pstChannelMode->hTrack);
            Ret = AO_Track_GetChannelMode(pstChannelMode->hTrack, &pstChannelMode->enMode);
            break;
        }
        
    	case CMD_AO_TRACK_SETFIFOBYPASS:
    	{
            AO_Track_FifoBypass_Param_S_PTR pstFifoBypass = (AO_Track_FifoBypass_Param_S_PTR)arg;
            HI_HANDLE hTrack = pstFifoBypass->hTrack;
            CHECK_AO_TRACK_OPEN(hTrack);
            CHECK_AO_TRACK_OPEN(pstFifoBypass->hTrack);
            Ret = AO_TrackSetAipFiFoBypass(hTrack, pstFifoBypass->bEnable);
    		break;
    	}

        case CMD_AO_TRACK_SETPRIORITY:
    	{
    		AO_Track_Priority_Param_S_PTR pstTrackPriority = (AO_Track_Priority_Param_S_PTR)arg;
    		CHECK_AO_TRACK_OPEN(pstTrackPriority->hTrack);
    		Ret = AO_Track_SePriority(pstTrackPriority->hTrack, pstTrackPriority->bEnable);
    		break;
    	}
    	case CMD_AO_TRACK_GETPRIORITY:
    	{
    		AO_Track_Priority_Param_S_PTR pstTrackPriority = (AO_Track_Priority_Param_S_PTR)arg;
    		CHECK_AO_TRACK_OPEN(pstTrackPriority->hTrack);
    		Ret = AO_Track_GePriority(pstTrackPriority->hTrack, &pstTrackPriority->bEnable);
    		break;
    	}

        case CMD_AO_TRACK_SETSPEEDADJUST:
        {
            AO_Track_SpeedAdjust_Param_S_PTR pstSpeed = (AO_Track_SpeedAdjust_Param_S_PTR)arg;
            CHECK_AO_TRACK_OPEN(pstSpeed->hTrack);
            Ret = AO_Track_SetSpeedAdjust(pstSpeed->hTrack, pstSpeed->enType, pstSpeed->s32Speed);
            break;
        }

        case CMD_AO_TRACK_GETDELAYMS:
        {
            AO_Track_DelayMs_Param_S_PTR pstDelayMs = (AO_Track_DelayMs_Param_S_PTR)arg;
            CHECK_AO_TRACK_OPEN(pstDelayMs->hTrack);
            Ret = AO_Track_GetDelayMs(pstDelayMs->hTrack, &pstDelayMs->u32DelayMs);
            break;
        }

        case CMD_AO_TRACK_ISBUFEMPTY:
        {
            AO_Track_BufEmpty_Param_S_PTR pstBufEmpty = (AO_Track_BufEmpty_Param_S_PTR)arg;
            CHECK_AO_TRACK_OPEN(pstBufEmpty->hTrack);
            Ret = AO_Track_IsBufEmpty(pstBufEmpty->hTrack, &pstBufEmpty->bEmpty);
            break;
        }

        case CMD_AO_TRACK_SETEOSFLAG:
        {
            AO_Track_EosFlag_Param_S_PTR pstEosFlag = (AO_Track_EosFlag_Param_S_PTR)arg;
            CHECK_AO_TRACK_OPEN(pstEosFlag->hTrack);
            Ret = AO_Track_SetEosFlag(pstEosFlag->hTrack, pstEosFlag->bEosFlag);
            break;
        }

        case CMD_AO_TRACK_ATTACHAI:
        {
            AO_Track_AttAi_Param_S_PTR pstTrackAttAi = (AO_Track_AttAi_Param_S_PTR)arg;
            CHECK_AO_TRACK_OPEN(pstTrackAttAi->hTrack);
            Ret = AO_Track_AttachAi(pstTrackAttAi->hTrack, pstTrackAttAi->hAi);
            break;
        }

        case CMD_AO_TRACK_DETACHAI:
        {
            AO_Track_AttAi_Param_S_PTR pstTrackDetAi = (AO_Track_AttAi_Param_S_PTR)arg;
            CHECK_AO_TRACK_OPEN(pstTrackDetAi->hTrack);
            Ret = AO_Track_DetachAi(pstTrackDetAi->hTrack, pstTrackDetAi->hAi);
            break;
        }

        case CMD_AO_SND_SETEXTDELAYMS:
        {
            AO_SND_Set_ExtDelayMs_Param_S_PTR pstExtDelayMsParam = (AO_SND_Set_ExtDelayMs_Param_S_PTR)arg;
            CHECK_AO_SNDCARD_OPEN(pstExtDelayMsParam->enSound);        
            Ret = AO_Snd_SetExtDelayMs(pstExtDelayMsParam->enSound, pstExtDelayMsParam->u32DelayMs);
            break;
        }

        default:
            Ret = HI_FAILURE;
            {
                HI_WARN_AO("unknown cmd: 0x%x\n", cmd);
            }
            break;
    }

    return Ret;
}

long AO_DRV_Ioctl(struct file* file, HI_U32 cmd, unsigned long arg)
{
    long s32Ret = HI_SUCCESS;

    s32Ret = down_interruptible(&g_AoMutex);

    //cmd process
    s32Ret = (long)HI_DRV_UserCopy(file->f_dentry->d_inode, file, cmd, arg, AO_ProcessCmd);

    up(&g_AoMutex);

    return s32Ret;
}

HI_S32 AO_DRV_Open(struct inode* inode, struct file*  filp)
{
    HI_S32 s32Ret;
    HI_U32 cnt;
    DRV_AO_STATE_S* pAOState = HI_NULL;

    if (!filp)
    {
        HI_FATAL_AO("file handle is null.\n");
        return HI_FAILURE;
    }

    s32Ret = down_interruptible(&g_AoMutex);

    pAOState = AUTIL_AO_MALLOC(HI_ID_AO, sizeof(DRV_AO_STATE_S), GFP_KERNEL);
    if (!pAOState)
    {
        HI_FATAL_AO("malloc pAOState failed.\n");
        up(&g_AoMutex);
        return HI_FAILURE;
    }
    for (cnt = 0; cnt < AO_MAX_TOTAL_SND_NUM; cnt++)
    {
        atomic_set(&(pAOState->atmUserOpenCnt[cnt]), 0);
        pAOState->u32FileId[cnt] = AO_SND_FILE_NOUSE_FLAG;
    }

    if (atomic_inc_return(&s_stAoDrv.atmOpenCnt) == 1)
    {
        /* Init device */
        if (HI_SUCCESS != AO_OpenDev())
        {
            HI_FATAL_AO("AO_OpenDev err!\n" );
            goto err;
        }
    }

    filp->private_data = pAOState;

    up(&g_AoMutex);
    return HI_SUCCESS;
err:
    AUTIL_AO_FREE(HI_ID_AO, pAOState);
    atomic_dec(&s_stAoDrv.atmOpenCnt);
    up(&g_AoMutex);
    return HI_FAILURE;
}

HI_S32 AO_DRV_Release(struct inode* inode, struct file*  filp)
{
    HI_U32 i;
    HI_U32 j;

    HI_S32 s32Ret = HI_SUCCESS;
    DRV_AO_STATE_S* pAOState = filp->private_data;

    s32Ret = down_interruptible(&g_AoMutex);

    /* Not the last close, only close the track & snd match with the 'filp' */
    if (atomic_dec_return(&s_stAoDrv.atmOpenCnt) != 0)
    {
        /* Free all Cast */
        for (i = 0; i < AO_MAX_CAST_NUM; i++)
        {
            if (s_stAoDrv.astCastEntity[i].pstFile == filp)
            {
                if (atomic_read(&s_stAoDrv.astCastEntity[i].atmUseCnt))
                {
                    if (HI_SUCCESS != AO_Cast_Destory(i))
                    {
                        atomic_inc(&s_stAoDrv.atmOpenCnt);
                        up(&g_AoMutex);
                        return HI_FAILURE;
                    }
                    AO_Cast_FreeHandle(i);
                }
            }
        }

        /* Free all track */
        for (i = 0; i < AO_MAX_TOTAL_TRACK_NUM; i++)
        {
            if (s_stAoDrv.astTrackEntity[i].pstFile == filp)
            {
                if (atomic_read(&s_stAoDrv.astTrackEntity[i].atmUseCnt))
                {
                    //AO_SND_UpdateTrackInfo(i, HI_FALSE);
                    if (HI_SUCCESS != AO_Track_Destory(i))
                    {
                        atomic_inc(&s_stAoDrv.atmOpenCnt);
                        up(&g_AoMutex);
                        return HI_FAILURE;
                    }

                    AO_Track_FreeHandleById(i);
                }
            }
        }

        /* Free all snd */
        for (i = 0; i < AO_MAX_TOTAL_SND_NUM; i++)
        {
            for (j = 0; j < SND_MAX_OPEN_NUM; j++)
            {
                if (s_stAoDrv.astSndEntity[i].pstFile[j] == filp)
                {
                    HI_U32 u32UserOpenCnt = 0;

                    if (s_stAoDrv.astSndEntity[i].pCard)
                    {
                        u32UserOpenCnt = atomic_read(&pAOState->atmUserOpenCnt[i]);
                        if (atomic_sub_and_test(u32UserOpenCnt, &s_stAoDrv.astSndEntity[i].atmUseTotalCnt))
                        {
                            if (HI_SUCCESS != AO_SND_Close(i, HI_FALSE))
                            {
                                atomic_inc(&s_stAoDrv.astSndEntity[i].atmUseTotalCnt);
                                atomic_inc(&s_stAoDrv.atmOpenCnt);
                                up(&g_AoMutex);
                                return HI_FAILURE;
                            }
                        }

                        AO_Snd_FreeHandle(i, (struct file*)(s_stAoDrv.astSndEntity[i].pstFile[j]));
                    }
                }
            }

        }
    }
    /* Last close */
    else
    {
        AO_CloseDev();
    }

    AUTIL_AO_FREE(HI_ID_AO, pAOState);
    up(&g_AoMutex);
    return HI_SUCCESS;
}

/* drv open  kernel intf */
HI_S32 AO_DRV_Kopen(struct file*  file)
{
    HI_S32 s32Ret;
    HI_U32 cnt;
    DRV_AO_STATE_S* pAOState = HI_NULL;

    if (!file)
    {
        HI_FATAL_AO("file handle is null.\n");
        return HI_FAILURE;
    }

    s32Ret = down_interruptible(&g_AoMutex);

    pAOState = AUTIL_AO_MALLOC(HI_ID_AO, sizeof(DRV_AO_STATE_S), GFP_KERNEL);
    if (!pAOState)
    {
        HI_FATAL_AO("malloc pAOState failed.\n");
        up(&g_AoMutex);
        return HI_FAILURE;
    }
    for (cnt = 0; cnt < AO_MAX_TOTAL_SND_NUM; cnt++)
    {
        atomic_set(&(pAOState->atmUserOpenCnt[cnt]), 0);
        pAOState->u32FileId[cnt] = AO_SND_FILE_NOUSE_FLAG;
    }

    if (atomic_inc_return(&s_stAoDrv.atmOpenCnt) == 1)
    {
        /* Init device */
        if (HI_SUCCESS != AO_OpenDev())
        {
            HI_FATAL_AO("AO_OpenDev err!\n" );
            goto err;
        }
    }

    file->private_data = pAOState;

    up(&g_AoMutex);
    return HI_SUCCESS;
err:
    AUTIL_AO_FREE(HI_ID_AO, pAOState);
    atomic_dec(&s_stAoDrv.atmOpenCnt);
    up(&g_AoMutex);
    return HI_FAILURE;
}
/*drv close kernel intf */
HI_S32 AO_DRV_Krelease(struct file*  file)
{
    HI_U32 i;
    HI_U32 j;
    HI_S32 s32Ret = HI_SUCCESS;
    DRV_AO_STATE_S* pAOState = file->private_data;

    s32Ret = down_interruptible(&g_AoMutex);

    /* Not the last close, only close the track & snd match with the 'filp' */
    if (atomic_dec_return(&s_stAoDrv.atmOpenCnt) != 0)
    {
        /* Free all track */
        for (i = 0; i < AO_MAX_TOTAL_TRACK_NUM; i++)
        {
            if (s_stAoDrv.astTrackEntity[i].pstFile == file)
            {
                if (atomic_read(&s_stAoDrv.astTrackEntity[i].atmUseCnt))
                {
                    if (HI_SUCCESS != AO_Track_Destory(i))
                    {
                        atomic_inc(&s_stAoDrv.atmOpenCnt);
                        up(&g_AoMutex);
                        return HI_FAILURE;
                    }

                    AO_Track_FreeHandleById(i);
                }
            }
        }

        /* Free all snd */
        for (i = 0; i < AO_MAX_TOTAL_SND_NUM; i++)
        {
            for (j = 0; j < SND_MAX_OPEN_NUM; j++)
            {
                if (s_stAoDrv.astSndEntity[i].pstFile[j] == file)
                {
                    HI_U32 u32UserOpenCnt = 0;
                    if (s_stAoDrv.astSndEntity[i].pCard)
                    {
                        u32UserOpenCnt = atomic_read(&pAOState->atmUserOpenCnt[i]);
                        if (atomic_sub_and_test(u32UserOpenCnt, &s_stAoDrv.astSndEntity[i].atmUseTotalCnt))
                        {
                            if (HI_SUCCESS != AO_SND_Close(i, HI_FALSE))
                            {
                                atomic_inc(&s_stAoDrv.astSndEntity[i].atmUseTotalCnt);
                                atomic_inc(&s_stAoDrv.atmOpenCnt);
                                up(&g_AoMutex);
                                return HI_FAILURE;
                            }
                        }

                        AO_Snd_FreeHandle(i, (struct file*)(s_stAoDrv.astSndEntity[i].pstFile[j]));
                    }
                }
            }

        }
    }
    /* Last close */
    else
    {
        AO_CloseDev();
    }

    AUTIL_AO_FREE(HI_ID_AO, pAOState);
    up(&g_AoMutex);
    return HI_SUCCESS;
}

#if defined (HI_ALSA_I2S_ONLY_SUPPORT)|| defined (HI_ALSA_HDMI_ONLY_SUPPORT)
HI_S32 AO_DRV_Krelease(struct file*  file);
HI_S32 AOSetProcStatistics(AIAO_IsrFunc* pFunc)//only for alsa use
{
    HAL_AIAO_P_SetTxI2SDfAttr(AIAO_PORT_TX0, pFunc); //pIsrFunc is the same for all ports
    return HI_SUCCESS;
}

HI_S32 AOGetProcStatistics(AIAO_IsrFunc** pFunc)//only for alsa use
{
    AIAO_PORT_USER_CFG_S pAttr;
    HAL_AIAO_P_GetTxI2SDfAttr(AIAO_PORT_TX0, &pAttr); //pIsrFunc is the same for all ports
    *pFunc = pAttr.pIsrFunc;
    return HI_SUCCESS;
}

HI_S32 AOGetEnport(HI_UNF_SND_E enSound, AIAO_PORT_ID_E* enPort, SND_OUTPUT_TYPE_E enOutType) //jiaxi check
{
    SND_OP_STATE_S*   state;
    AIAO_PORT_ID_E   enAOPort;
    SND_CARD_STATE_S* pCard;

    pCard = SND_CARD_GetCard(enSound);
    if (pCard != HI_NULL)
    {
        if (enOutType == SND_OUTPUT_TYPE_HDMI)
           state = (SND_OP_STATE_S *)SND_GetOpHandlebyOutType(pCard, SND_OUTPUT_TYPE_HDMI); 
        else
           state = (SND_OP_STATE_S *)SND_GetOpHandlebyOutType(pCard, SND_OUTPUT_TYPE_I2S);
    }
    else
    {
        goto _GET_ERR;
    }

    if (state != HI_NULL)
    {
        enAOPort = state->enPortID[state->ActiveId];
    }
    else
    {
        goto _GET_ERR;
    }

    *enPort = enAOPort;
    return HI_SUCCESS;

_GET_ERR:
    HI_FATAL_AO("Get Enpot Error\n");
    return HI_FAILURE;
}

HI_S32 AOGetHandel(HI_UNF_SND_E enSound, HI_VOID* *ppSndOp, SND_OUTPUT_TYPE_E enOutType) //jiaxi check
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);
    if (pCard != HI_NULL)
    {
        if (enOutType == SND_OUTPUT_TYPE_HDMI) //HI_ALSA_HDMI_ONLY_SUPPORT
           *ppSndOp = SND_GetOpHandlebyOutType(pCard, SND_OUTPUT_TYPE_HDMI); 
        else
           *ppSndOp = SND_GetOpHandlebyOutType(pCard, SND_OUTPUT_TYPE_I2S);       
    }
    else
    {
        goto _GET_ERR;
    }
    if (*ppSndOp == HI_NULL)
    {
        goto _GET_ERR;
    }
    return HI_SUCCESS;
_GET_ERR:
    HI_FATAL_AO("Get AOGetHandel Error\n");
    return HI_FAILURE;
}

HI_S32 Alsa_AO_OpenDev(struct file*  file, HI_VOID* pAlsaAttr, HI_VOID* p)
{
    if (HI_SUCCESS != AO_DRV_Kopen(file))
    {
        HI_FATAL_AO("AO_DRV_Kopen err!\n" );
        goto err;
    }

    if (HI_SUCCESS != AO_Snd_Kopen((AO_SND_Open_Param_S*)p, (AO_ALSA_I2S_Param_S*)pAlsaAttr, file))
    {
        AO_DRV_Krelease(file);
        HI_FATAL_AO("\n AO_Snd_Kopen err\n");
        goto err;
    }
    return HI_SUCCESS;

err:
    return HI_FAILURE;
}

HI_S32 Alsa_AO_CloseDev(struct file*  file, HI_UNF_SND_E snd_idx)
{
    if (HI_SUCCESS != AO_Snd_Kclose(snd_idx, file))
    {
        HI_FATAL_AO("AO_Snd_Kclose rr!\n" );
        goto err;
    }
    if (HI_SUCCESS != AO_DRV_Krelease(file))
    {
        HI_FATAL_AO("AO_DRV_Krelease err!\n" );
        goto err;
    }
    return HI_SUCCESS;
err:
    return HI_FAILURE;
}
#endif

#if (1 == HI_PROC_SUPPORT)
HI_S32 AO_DRV_RegisterProc(AO_REGISTER_PARAM_S* pstParam)
{
    HI_U32 i;

    /* Check parameters */
    if (HI_NULL == pstParam)
    {
        return HI_FAILURE;
    }

    s_stAoDrv.pstProcParam = pstParam;

    /* Create proc when use, if MCE open snd , reg proc here*/
    for (i = 0; i < AO_MAX_TOTAL_SND_NUM; i++)
    {
        if (s_stAoDrv.astSndEntity[i].pCard)
        {
            AO_RegProc(i);
        }
    }
    return HI_SUCCESS;
}

HI_VOID AO_DRV_UnregisterProc(HI_VOID)
{
    /* Clear param */
    s_stAoDrv.pstProcParam = HI_NULL;
    return;
}
#endif

#if defined (HI_SND_DRV_SUSPEND_SUPPORT)
static HI_S32 AO_TRACK_GetSettings(HI_HANDLE hTrack, SND_TRACK_SETTINGS_S* pstSndSettings)
{
    SND_CARD_STATE_S* pCard;

    hTrack &= AO_TRACK_CHNID_MASK;
    pCard = TRACK_CARD_GetCard(hTrack);
    if (pCard)
    {
        return TRACK_GetSetting(pCard, hTrack, pstSndSettings);
    }
    else
    {
        HI_ERR_AO("Track(%d) don't attach card!\n", hTrack);
        return HI_FAILURE;
    }
}

static HI_S32 AO_TRACK_RestoreSettings(HI_HANDLE hTrack, SND_TRACK_SETTINGS_S* pstSndSettings)
{
    SND_CARD_STATE_S* pCard;

    hTrack &= AO_TRACK_CHNID_MASK;
    pCard = TRACK_CARD_GetCard(hTrack);
    if (pCard)
    {
        return TRACK_RestoreSetting(pCard, hTrack, pstSndSettings);
    }
    else
    {
        HI_ERR_AO("Track(%d) don't attach card!\n", hTrack);
        return HI_FAILURE;
    }
}

static HI_S32 AO_SND_GetSettings(HI_UNF_SND_E enSound, SND_CARD_SETTINGS_S* pstSndSettings)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_NULL_PTR(pCard);
    CHECK_AO_NULL_PTR(pstSndSettings);

    pstSndSettings->bAllTrackMute = pCard->bAllTrackMute;
    //pstSndSettings->bAllCastMute = pCard->bAllCastMute;
    if (HI_SUCCESS != SND_GetOpSetting(pCard, pstSndSettings))
    {
        return HI_FAILURE;
    }

#ifdef HI_SND_AFLT_SUPPORT
    if (HI_SUCCESS != AEF_GetSetting(pCard, pstSndSettings))
    {
        return HI_FAILURE;
    }
#endif

    return HI_SUCCESS;
}

static HI_S32 AO_SND_RestoreSettings(HI_UNF_SND_E enSound, SND_CARD_SETTINGS_S* pstSndSettings)
{
    SND_CARD_STATE_S* pCard = SND_CARD_GetCard(enSound);

    CHECK_AO_NULL_PTR(pCard);
    CHECK_AO_NULL_PTR(pstSndSettings);
    pCard->bAllTrackMute = pstSndSettings->bAllTrackMute; //All track mute restore in Track restore.
    //pCard->bAllCastMute = pstSndSettings->bAllCastMute; //All track mute restore in Track restore.
    if (HI_SUCCESS != SND_RestoreOpSetting(pCard, pstSndSettings))
    {
        return HI_FAILURE;
    }

#ifdef HI_SND_AFLT_SUPPORT
    if (HI_SUCCESS != AEF_RestoreSetting(pCard, pstSndSettings))
    {
        return HI_FAILURE;
    }
#endif

    return HI_SUCCESS;
}
#endif

HI_S32 HI_DRV_AO_Init(HI_VOID)
{
    return AO_DRV_Init();
}

HI_VOID HI_DRV_AO_DeInit(HI_VOID)
{
    AO_DRV_Exit();
}

HI_S32 HI_DRV_AO_SND_Init(struct file*  pfile)
{
    struct file*  pstfilp;

    if (HI_NULL == pfile)
    {
        pstfilp = &g_filp;
    }
    else
    {
        pstfilp = pfile;
    }

    HI_INFO_AO("\nHI_DRV_AO_SND_Init file=%p\n", pfile);

    return AO_DRV_Open(NULL, pstfilp);
}

HI_S32 HI_DRV_AO_SND_DeInit(struct file*  pfile)
{
    struct file*  pstfilp;

    if (HI_NULL == pfile)
    {
        pstfilp = &g_filp;
    }
    else
    {
        pstfilp = pfile;
    }
    HI_INFO_AO("\nHI_DRV_AO_SND_DeInit file=%p\n", pfile);

    return AO_DRV_Release(NULL, pstfilp);
}

HI_S32 HI_DRV_AO_SND_GetDefaultOpenAttr(HI_UNF_SND_E enSound, DRV_SND_ATTR_S* pstAttr)
{
    HI_S32 Ret;
    AO_SND_OpenDefault_Param_S stSndDefaultAttr;
    CHECK_AO_SNDCARD( enSound );
    Ret = down_interruptible(&g_AoMutex);

    stSndDefaultAttr.enSound = enSound;
    Ret = AOGetSndDefOpenAttr(&stSndDefaultAttr);
    if (HI_SUCCESS != Ret)
    {
        HI_ERR_AO("GetDefaultAttr Failed %d\n");
        up(&g_AoMutex);
        return Ret;
    }
    memcpy(pstAttr, &stSndDefaultAttr.stAttr, sizeof(DRV_SND_ATTR_S));
    up(&g_AoMutex);
    return Ret;
}

HI_S32 HI_DRV_AO_SND_Open(HI_UNF_SND_E enSound, DRV_SND_ATTR_S* pstAttr, struct file*  pfile)
{
    HI_S32 Ret;
    DRV_AO_STATE_S* pAOState;
    struct file*  pstfile;

    Ret = down_interruptible(&g_AoMutex);

    if (HI_NULL == pfile)
    {
        pAOState = g_filp.private_data;
        pstfile = &g_filp;
    }
    else
    {
        pAOState = pfile->private_data;
        pstfile = pfile;
    }

    CHECK_AO_SNDCARD( enSound );

    HI_INFO_AO("\nHI_DRV_AO_SND_Open file=%p\n", pfile);

    Ret = AO_Snd_AllocHandle(enSound, pstfile);
    if (HI_SUCCESS == Ret)
    {
        if (0 == atomic_read(&s_stAoDrv.astSndEntity[enSound].atmUseTotalCnt))
        {
            Ret = AO_SND_Open(enSound, pstAttr, NULL, HI_FALSE);
            if (HI_SUCCESS != Ret)
            {
                HI_ERR_AO("Ao SND Open Failed\n");
                AO_Snd_FreeHandle(enSound, pstfile);
                up(&g_AoMutex);
                return Ret;
            }
        }
    }

    atomic_inc(&s_stAoDrv.astSndEntity[enSound].atmUseTotalCnt);
    atomic_inc(&pAOState->atmUserOpenCnt[enSound]);
    up(&g_AoMutex);

    return Ret;
}

HI_S32 HI_DRV_AO_SND_Close(HI_UNF_SND_E enSound, struct file*  pfile)
{
    HI_S32 Ret;
    DRV_AO_STATE_S* pAOState;
    struct file*  pstfilp;

    Ret = down_interruptible(&g_AoMutex);

    if (HI_NULL == pfile)
    {
        pAOState = g_filp.private_data;
        pstfilp = &g_filp;
    }
    else
    {
        pAOState = pfile->private_data;
        pstfilp = pfile;
    }

    CHECK_AO_SNDCARD_OPEN( enSound );

    HI_INFO_AO("\nHI_DRV_AO_SND_Close file=%p\n", pfile);

    if (atomic_dec_and_test(&pAOState->atmUserOpenCnt[enSound]))
    {
        if (atomic_dec_and_test(&s_stAoDrv.astSndEntity[enSound].atmUseTotalCnt))
        {
            Ret = AO_SND_Close( enSound, HI_FALSE );
            if (HI_SUCCESS != Ret)
            {
                atomic_inc(&s_stAoDrv.astSndEntity[enSound].atmUseTotalCnt);
                atomic_inc(&pAOState->atmUserOpenCnt[enSound]);
                HI_ERR_AO("AO SND Close failed %d\n", Ret);
                up(&g_AoMutex);
                return Ret;
            }

            AO_Snd_FreeHandle(enSound, pstfilp);
        }
    }
    else
    {
        atomic_dec(&s_stAoDrv.astSndEntity[enSound].atmUseTotalCnt);
    }
    up(&g_AoMutex);

    return HI_SUCCESS;
}

HI_S32 HI_DRV_AO_Snd_GetXRunCount(HI_UNF_SND_E enSound, HI_U32* pu32Count)
{
    CHECK_AO_SNDCARD_OPEN(enSound);
    return AO_Snd_GetXRunCount(enSound, pu32Count);

}

HI_S32 HI_DRV_AO_SND_SetVolume(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort, HI_UNF_SND_GAIN_ATTR_S stGain)
{
    HI_S32 Ret = HI_SUCCESS;
    CHECK_AO_SNDCARD_OPEN( enSound );

    Ret = down_interruptible(&g_AoMutex);
    Ret = AO_SND_SetVolume(enSound, enOutPort, stGain);
    up(&g_AoMutex);
    return Ret;

}

HI_S32 HI_DRV_AO_SND_GetVolume(HI_UNF_SND_E enSound, HI_UNF_SND_OUTPUTPORT_E enOutPort, HI_UNF_SND_GAIN_ATTR_S* pstGain)
{
    HI_S32 Ret = HI_SUCCESS;
    CHECK_AO_SNDCARD_OPEN( enSound );
    Ret = down_interruptible(&g_AoMutex);
    Ret = AO_SND_GetVolume(enSound, enOutPort, pstGain);
    up(&g_AoMutex);
    return Ret;
}

HI_S32 HI_DRV_AO_Track_GetDefaultOpenAttr(HI_UNF_SND_TRACK_TYPE_E enTrackType, HI_UNF_AUDIOTRACK_ATTR_S* pstAttr)
{
    HI_S32 Ret = HI_SUCCESS;

    Ret = down_interruptible(&g_AoMutex);

    pstAttr->enTrackType = enTrackType;
    Ret = AO_Track_GetDefAttr(pstAttr);
    if (HI_SUCCESS != Ret)
    {
        HI_ERR_AO("GetDefaultOpenAttr %d\n", Ret);
        up(&g_AoMutex);
        return Ret;
    }
    up(&g_AoMutex);

    return Ret;
}

HI_S32 HI_DRV_AO_Track_Create(HI_UNF_SND_E enSound, HI_UNF_AUDIOTRACK_ATTR_S* pstAttr, HI_BOOL bAlsaTrack, struct file*  pfile, HI_HANDLE* phTrack)
{
    HI_S32 Ret = HI_SUCCESS;
    HI_HANDLE hHandle = HI_INVALID_HANDLE;
    struct file*  pstfilp;
    //HI_UNF_SND_PRECIGAIN_ATTR_S stPreciGain = { -6 , 0};
    Ret = down_interruptible(&g_AoMutex);

    if (HI_NULL == pfile)
    {
        pstfilp = &g_filp;
    }
    else
    {
        pstfilp = pfile;
    }
    HI_INFO_AO("\nHI_DRV_AO_Track_Create bAlsaTrack=%d file=%p\n", bAlsaTrack, pfile);

    Ret = AO_Track_AllocHandle(&hHandle, pstAttr->enTrackType, pstfilp);
    if(HI_SUCCESS != Ret)
    {
        HI_ERR_AO("AO_Track_AllocHandle Failed \n", Ret);
        up(&g_AoMutex);
        return Ret;
    }

    Ret = AO_Track_PreCreate(enSound, pstAttr, bAlsaTrack, NULL, hHandle);
    if (HI_SUCCESS != Ret)
    {
        AO_Track_FreeHandle(hHandle);
        HI_ERR_AO("Pre Create Track Failed \n", Ret);
        up(&g_AoMutex);
        return Ret;
    }

    /* Set Prescale for ALSA track */
    //AO_Track_SetPrescale(hHandle, stPreciGain);

    *phTrack = hHandle;
    up(&g_AoMutex);

    return Ret;
}

HI_S32 HI_DRV_AO_Track_Destroy(HI_HANDLE hSndTrack)
{
    HI_S32 Ret = HI_SUCCESS;
    CHECK_AO_TRACK_OPEN(hSndTrack);
    Ret = down_interruptible(&g_AoMutex);

    Ret = AO_Track_Destory(hSndTrack);
    if (HI_SUCCESS != Ret)
    {
        HI_ERR_AO("Create Destroy Failed \n", Ret);
        up(&g_AoMutex);
        return Ret;
    }

    AO_Track_FreeHandle(hSndTrack);
    up(&g_AoMutex);

    return Ret;
}

HI_S32 HI_DRV_AO_Track_Flush(HI_HANDLE hSndTrack)
{
    CHECK_AO_TRACK_OPEN(hSndTrack);
    return AO_Track_Flush(hSndTrack);
}

HI_S32 HI_DRV_AO_Track_Start(HI_HANDLE hSndTrack)
{
    CHECK_AO_TRACK_OPEN(hSndTrack);
    return AO_Track_Start(hSndTrack);
}

HI_S32 HI_DRV_AO_Track_Stop(HI_HANDLE hSndTrack)
{
    CHECK_AO_TRACK_OPEN(hSndTrack);
    return AO_Track_Stop(hSndTrack);
}

HI_S32 HI_DRV_AO_Track_GetDelayMs(HI_HANDLE hSndTrack, HI_U32* pDelayMs)
{
    CHECK_AO_TRACK_OPEN(hSndTrack);
    return AO_Track_GetDelayMs(hSndTrack, pDelayMs);
}

HI_S32 HI_DRV_AO_Track_SendData(HI_HANDLE hSndTrack, AO_FRAMEINFO_S* pstAOFrame)
{
    CHECK_AO_TRACK_OPEN(hSndTrack);
    return AO_Track_SendData(hSndTrack, pstAOFrame);
}

HI_S32 HI_DRV_AO_Track_AttachAi(HI_HANDLE hSndTrack, HI_HANDLE hAi)
{
    CHECK_AO_TRACK_OPEN(hSndTrack);
    return AO_Track_AttachAi(hSndTrack, hAi);
}

HI_S32 HI_DRV_AO_Track_DetachAi(HI_HANDLE hSndTrack, HI_HANDLE hAi)
{
    CHECK_AO_TRACK_OPEN(hSndTrack);
    return AO_Track_DetachAi(hSndTrack, hAi);
}

static HI_S32 AO_CAST_GetSettings(HI_HANDLE hCast, SND_CAST_SETTINGS_S* pstCastSettings)
{
    SND_CARD_STATE_S* pCard;

    hCast &= AO_CAST_CHNID_MASK;
    pCard = CAST_CARD_GetCard(hCast);
    CHECK_AO_NULL_PTR(pCard);

    CAST_GetSettings(pCard, hCast, pstCastSettings);
    return HI_SUCCESS;
}

static HI_S32 AO_CAST_RestoreSettings(HI_HANDLE hCast, SND_CAST_SETTINGS_S* pstCastSettings)
{
    SND_CARD_STATE_S* pCard;

    hCast &= AO_CAST_CHNID_MASK;
    pCard = CAST_CARD_GetCard(hCast);
    CHECK_AO_NULL_PTR(pCard);

    CAST_RestoreSettings(pCard, hCast, pstCastSettings);
    return HI_SUCCESS;
}

HI_S32 AO_DRV_Suspend(PM_BASEDEV_S* pdev,
                      pm_message_t   state)
{
#if defined (HI_SND_DRV_SUSPEND_SUPPORT)
    HI_S32 i;
    HI_S32 s32Ret = HI_SUCCESS;

#if defined(HI_ALSA_AO_SUPPORT) && defined(CONFIG_PM)
    HI_INFO_AO("AO shallow suspend state.event = 0x%x\n", state.event);
    if (PM_LOW_SUSPEND_FLAG == state.event && HI_NULL != hisi_snd_device)
    {
        bu32shallowSuspendActive = HI_TRUE;
        s32Ret = snd_soc_suspend(&hisi_snd_device->dev);    //shallow suspent here suspend alsa driver
        if (HI_SUCCESS != s32Ret)
        {
            HI_ERR_AO("AO ALSA shallow suspend fail 0x%x\n", s32Ret);
        }
        HI_PRINT("AO ALSA shallow suspend OK.\n");
    }
#endif

#ifdef HI_AIAO_TIMER_SUPPORT
    s32Ret = HI_DRV_Timer_Suspend();
    if (HI_SUCCESS != s32Ret)
    {
       HI_ERR_AO("AO HI_DRV_Timer_Suspend fail 0x%x\n", s32Ret);
    }
    HI_PRINT("AO Timer suspend OK.\n");
#endif

#if (1 == HI_PROC_SUPPORT)
    bSuspend2SaveThreadFlag = HI_TRUE; //just for echo save sound pcm
    while (HI_TRUE == bSaveThread2SuspendFlag) //wait until echo proc for save sound pcm thread exit !
    {
        msleep(2);
    }
#endif

    s32Ret = down_interruptible(&g_AoMutex);
    if (HI_TRUE == s_stAoDrv.bReady)
    {
        /* Destory all cast */
        for (i = 0; i < AO_MAX_CAST_NUM; i++)
        {
            if (atomic_read(&s_stAoDrv.astCastEntity[i].atmUseCnt))
            {
                /* Store cast settings */
                AO_CAST_GetSettings(i, &s_stAoDrv.astCastEntity[i].stSuspendAttr);

                /* Destory cast */
                s32Ret = AO_Cast_Destory(i);
                if (HI_SUCCESS != s32Ret)
                {
                    HI_FATAL_AO("AO_Cast_Destory fail\n");
                    up(&g_AoMutex);
                    return HI_FAILURE;
                }
            }
        }

        /* Destory all track */
        for (i = 0; i < AO_MAX_TOTAL_TRACK_NUM; i++)
        {
            if (atomic_read(&s_stAoDrv.astTrackEntity[i].atmUseCnt))
            {
                /* Store track settings */
                AO_TRACK_GetSettings(i, &s_stAoDrv.astTrackEntity[i].stSuspendAttr);

                /* Destory track */
                s32Ret = AO_Track_Destory(i);
                if (HI_SUCCESS != s32Ret)
                {
                    HI_FATAL_AO("AO_Track_Destory fail\n");
                    up(&g_AoMutex);
                    return HI_FAILURE;
                }
            }
        }

        /* Destory all snd */
        for (i = 0; i < AO_MAX_TOTAL_SND_NUM; i++)
        {
            if (s_stAoDrv.astSndEntity[i].pCard)
            {
                /* Store snd settings */
                AO_SND_GetSettings(i, &s_stAoDrv.astSndEntity[i].stSuspendAttr);

                /* Destory snd */
                s32Ret = AO_SND_Close(i, HI_TRUE);
                if (HI_SUCCESS != s32Ret)
                {
                    HI_FATAL_AO("AO_SND_Close fail\n");
                    up(&g_AoMutex);
                    return HI_FAILURE;
                }
            }
        }

        s32Ret = HAL_AIAO_Suspend();
        if (HI_SUCCESS != s32Ret)
        {
            HI_FATAL_AO("AIAO Suspend fail\n");
            up(&g_AoMutex);
            return HI_FAILURE;
        }

        if (s_stAoDrv.pAdspFunc && s_stAoDrv.pAdspFunc->pfnADSP_UnLoadFirmware)
        {
            s32Ret = (s_stAoDrv.pAdspFunc->pfnADSP_UnLoadFirmware)(ADSP_CODE_AOE);
        }
    }

    up(&g_AoMutex);
#endif
    HI_PRINT("AO suspend OK\n");
    return HI_SUCCESS;
}

HI_S32 AO_DRV_Resume(PM_BASEDEV_S* pdev)
{
#if defined (HI_SND_DRV_SUSPEND_SUPPORT)
    HI_S32 i;
    HI_S32 s32Ret = HI_SUCCESS;
#ifdef HI_AUDIO_AI_SUPPORT
    HI_BOOL bAiEnable;
#endif

#if (1 == HI_PROC_SUPPORT)
    bSuspend2SaveThreadFlag = HI_FALSE; //just for echo save sound pcm
#endif

    s32Ret = down_interruptible(&g_AoMutex);

    if (HI_TRUE == s_stAoDrv.bReady)
    {
        /* HAL_AOE_Init , Init aoe hardare */
        if (s_stAoDrv.pAdspFunc && s_stAoDrv.pAdspFunc->pfnADSP_LoadFirmware)
        {
            s32Ret = (s_stAoDrv.pAdspFunc->pfnADSP_LoadFirmware)(ADSP_CODE_AOE);
            if (HI_SUCCESS != s32Ret)
            {
                HI_FATAL_AO("load aoe fail\n");
                up(&g_AoMutex);
                return HI_FAILURE;
            }
        }

        s32Ret = HAL_AIAO_Resume();
        if (HI_SUCCESS != s32Ret)
        {
            HI_FATAL_AO("AIAO Resume fail\n");
            up(&g_AoMutex);
            return HI_FAILURE;
        }

        /* Restore all snd */
        for (i = 0; i < AO_MAX_TOTAL_SND_NUM; i++)
        {
            if (s_stAoDrv.astSndEntity[i].pCard)
            {
                /* Recreate snd */
                s32Ret = AO_SND_Open(i, &s_stAoDrv.astSndEntity[i].stSuspendAttr.stUserOpenParam, &s_stAoDrv.astSndEntity[i].stSuspendAttr.stUserOpenParamI2s, HI_TRUE); //#ifdef HI_ALSA_I2S_ONLY_SUPPORT  Check DO???
                if (HI_SUCCESS != s32Ret)
                {
                    HI_FATAL_AO("AO_SND_Open fail\n");
                    up(&g_AoMutex);
                    return HI_FAILURE;
                }

                /* Restore snd settings*/
                AO_SND_RestoreSettings(i, &s_stAoDrv.astSndEntity[i].stSuspendAttr);
            }
        }

        for (i = 0; i < AO_MAX_TOTAL_TRACK_NUM; i++)
        {
            if (atomic_read(&s_stAoDrv.astTrackEntity[i].atmUseCnt))
            {
                HI_UNF_SND_E enSound = s_stAoDrv.astTrackEntity[i].stSuspendAttr.enSound;
                HI_UNF_AUDIOTRACK_ATTR_S* pstAttr = &s_stAoDrv.astTrackEntity[i].stSuspendAttr.stTrackAttr;
                HI_BOOL bAlsaTrack = s_stAoDrv.astTrackEntity[i].stSuspendAttr.bAlsaTrack;
                AO_BUF_ATTR_S* pstBuf = &s_stAoDrv.astTrackEntity[i].stSuspendAttr.stBufAttr;

                /* Recreate track  */
                s32Ret = AO_Track_Create(enSound, pstAttr, bAlsaTrack, pstBuf, i);
                if (HI_SUCCESS != s32Ret)
                {
                    HI_FATAL_AO("AO_Track_Create(%d) fail\n", i);
                    up(&g_AoMutex);
                    return HI_FAILURE;
                }
#ifdef HI_AUDIO_AI_SUPPORT
                if(s_stAoDrv.astTrackEntity[i].stSuspendAttr.bAttAi)
                {
                    s32Ret = AI_GetEnable(s_stAoDrv.astTrackEntity[i].stSuspendAttr.hAi, &bAiEnable);
                    if (HI_SUCCESS != s32Ret)
                    {
                        HI_FATAL_AO("AI GetEnable fail\n");
                        up(&g_AoMutex);
                        return HI_FAILURE;
                    }
                    if (HI_TRUE == bAiEnable)
                    {
                        s32Ret = AI_SetEnable(s_stAoDrv.astTrackEntity[i].stSuspendAttr.hAi, HI_FALSE, HI_TRUE);
                        if (HI_SUCCESS != s32Ret)
                        {
                            HI_FATAL_AO("AI SetEnable failed!!\n");
                            up(&g_AoMutex);
                            return HI_FAILURE;
                        }
                    }

                    s32Ret = AO_Track_AttachAi(i, s_stAoDrv.astTrackEntity[i].stSuspendAttr.hAi);
                    if (HI_SUCCESS != s32Ret)
                    {
                        HI_FATAL_AO("AO_Track_AttachAi(%d) fail\n", i);
                        up(&g_AoMutex);
                        return HI_FAILURE;
                    }

                    if (HI_TRUE == bAiEnable)
                    {
                        s32Ret = AI_SetEnable(s_stAoDrv.astTrackEntity[i].stSuspendAttr.hAi, HI_TRUE, HI_TRUE);
                        if (HI_SUCCESS != s32Ret)
                        {
                            HI_FATAL_AO("AI SetEnable failed!!\n");
                            up(&g_AoMutex);
                            return HI_FAILURE;
                        }
                    }

                    s32Ret = AO_Track_Start(i);
                    if (HI_SUCCESS != s32Ret)
                    {
                        HI_FATAL_AO("AO_Track_Start(%d) fail\n", i);
                        up(&g_AoMutex);
                        return HI_FAILURE;
                    }
                }
#endif
                /* Restore track settings*/
                AO_TRACK_RestoreSettings(i, &s_stAoDrv.astTrackEntity[i].stSuspendAttr);
            }
        }

        /* Restore all cast */
        for (i = 0; i < AO_MAX_CAST_NUM; i++)
        {
            if (atomic_read(&s_stAoDrv.astCastEntity[i].atmUseCnt))
            {
                HI_UNF_SND_E enSound = s_stAoDrv.astCastEntity[i].stSuspendAttr.enSound;
                HI_UNF_SND_CAST_ATTR_S* pstAttr = &s_stAoDrv.astCastEntity[i].stSuspendAttr.stCastAttr;

                /* Recreate cast  */
                s32Ret = AO_Cast_Create(enSound, pstAttr, &s_stAoDrv.astCastEntity[i].stRbfMmz, i);
                if (HI_SUCCESS != s32Ret)
                {
                    HI_FATAL_AO("AO_Cast_Create(%d) fail\n", i);
                    up(&g_AoMutex);
                    return HI_FAILURE;
                }

                /* Restore cast settings*/
                AO_CAST_RestoreSettings(i, &s_stAoDrv.astCastEntity[i].stSuspendAttr);
            }
        }
    }

    up(&g_AoMutex);
#endif

#ifdef HI_AIAO_TIMER_SUPPORT
    s32Ret = HI_DRV_Timer_Resume();
    if (HI_SUCCESS != s32Ret)
    {
        HI_FATAL_AO("HI_DRV_Timer_Resume fail 0x%x\n", s32Ret);
    }
#endif

    HI_PRINT("AO resume OK\n");
#if defined(HI_ALSA_AO_SUPPORT) && defined(CONFIG_PM)
    if (HI_NULL != hisi_snd_device && HI_TRUE == bu32shallowSuspendActive)
    {
        HI_INFO_AO("\nAO ALSA shallow resume \n");

        bu32shallowSuspendActive = HI_FALSE;
        s32Ret = snd_soc_resume(&hisi_snd_device->dev);
        if (HI_SUCCESS != s32Ret)
        {
            HI_ERR_AO("AO ALSA shallow resume fail.\n");
        }

        HI_PRINT("AO ALSA shallow resume OK.\n");
    }
#endif

    return HI_SUCCESS;
}

HI_S32 AO_DRV_Init(HI_VOID)
{
    HI_S32 s32Ret;

    s32Ret = down_interruptible(&g_AoMutex);
    s32Ret = HI_DRV_MODULE_Register(HI_ID_AO, AO_NAME,
                                    (HI_VOID*)&s_stAoDrv.stExtFunc);
    if (HI_SUCCESS != s32Ret)
    {
        HI_FATAL_AO("Reg module fail:%#x!\n", s32Ret);
        up(&g_AoMutex);
        return s32Ret;
    }

#ifdef ENA_AO_IRQ_PROC
    /* register ade ISR */
    if (0
        != request_irq(AO_IRQ_NUM, AO_IntVdmProc,
                       IRQF_DISABLED, "aiao",
                       HI_NULL))
    {
        HI_FATAL_AO("FATAL: request_irq for VDI VDM err!\n");
        up(&g_AoMutex);
        return HI_FAILURE;
    }
#endif

	//for karaoke print
    s32Ret = HI_DRV_MODULE_Register(HI_ID_KARAOKE, "HI_KARAOKE", (HI_VOID *)HI_NULL);
	if(HI_SUCCESS != s32Ret)
    {
        HI_FATAL_AO("HI_DRV_MODULE_Register HI_KARAOKE failed 0x%x\n", s32Ret);
        up(&g_AoMutex);
		return s32Ret;
	}

    up(&g_AoMutex);
    return HI_SUCCESS;
}

HI_VOID AO_DRV_Exit(HI_VOID)
{
    HI_S32 s32Ret;

    s32Ret = down_interruptible(&g_AoMutex);
#ifdef ENA_AO_IRQ_PROC
    free_irq(AO_IRQ_NUM, HI_NULL);
#endif
    HI_DRV_MODULE_UnRegister(HI_ID_KARAOKE);
    HI_DRV_MODULE_UnRegister(HI_ID_AO);

    up(&g_AoMutex);
    return;
}

EXPORT_SYMBOL(AO_SND_SetHdmiMode);
#ifdef __cplusplus
#if __cplusplus
#endif
#endif /* End of #ifdef __cplusplus */
