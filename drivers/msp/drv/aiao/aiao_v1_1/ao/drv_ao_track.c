/*******************************************************************************
 *              Copyright 2004 - 2014, Hisilicon Tech. Co., Ltd.
 *                           ALL RIGHTS RESERVED
 * FileName: drv_ao_op_func.c
 * Description: aiao interface of module.
 *
 * History:
 * Version   Date         Author     DefectNum    Description
 * main\1
 ********************************************************************************/
#include <asm/setup.h>
#include <linux/interrupt.h>

#include "hi_type.h"

#include "hi_module.h"
#include "hi_drv_mmz.h"
#include "hi_drv_file.h"
#include "hi_error_mpi.h"
#include "hi_drv_proc.h"

#include "hi_drv_hdmi.h"
#include "drv_hdmi_ext.h"

#include "audio_util.h"
#include "drv_ao_op.h"
#include "drv_ao_track.h"
#include "hal_aoe_func.h"
#include "hal_aiao_func.h"
#include "hal_aiao_common.h"
#include "hal_aoe_common.h"
#include "hal_aoe.h"
#include "hal_cast.h"
#include "hal_aiao.h"
//#include "hal_tianlai_adac_v500.h"

#if defined (HI_AUDIO_AI_SUPPORT)
#include "drv_ai_private.h"
#endif


/* test hdmi pass-through autio without hdmi device , only work at HI_UNF_SND_HDMI_MODE_RAW*/
#define HDMI_AUDIO_PASSTHROUGH_DEBUG
#define UTIL_ALIGN4(x) \
    do {                                                   \
        if (x & 3){                                      \
            x=(((x+3)/4)*4);                                             \
        }                                   \
    } while (0)

/******************************Track Engine process FUNC*************************************/

static HI_VOID TrackDestroyEngine(HI_VOID* pSndEngine)
{
    SND_ENGINE_STATE_S* state = (SND_ENGINE_STATE_S*)pSndEngine;

    if (!state)
    {
        return;
    }

    HAL_AOE_ENGINE_Stop(state->enEngine);
    HAL_AOE_ENGINE_Destroy(state->enEngine);
    AUTIL_AO_FREE(HI_ID_AO, (HI_VOID*)state);
}

// for HBR 
static HI_U32 TrackGetMultiPcmChannels(AO_FRAMEINFO_S* pstAOFrame)
{
    HI_U32 u32MulChannel;
    u32MulChannel = pstAOFrame->u32Channels & 0xff;
    
    if (u32MulChannel > AO_TRACK_NORMAL_CHANNELNUM)
    {
        //compatible the former action
        return (u32MulChannel - AO_TRACK_NORMAL_CHANNELNUM);
    }
    else
    {
        //AOEIMP: TODO, add channel distribution diagram
        //follow the new action(such as the channels of ms12)
        u32MulChannel = (pstAOFrame->u32Channels & 0xff00) >> 8;
        if (u32MulChannel > AO_TRACK_NORMAL_CHANNELNUM)
        {
            return u32MulChannel - AO_TRACK_NORMAL_CHANNELNUM;
        }

    return 0;
    }
}

#ifdef DRV_SND_MULTICH_AEF_SUPPORT
// TODO: AOEIMP metadata
static HI_U32 TrackGetMcPCMChannel(AO_FRAMEINFO_S* pstAOFrame)
{
    HI_U32 u32MulChannel;

    //follow the new action(such as the channels of ms12)
    u32MulChannel = (pstAOFrame->u32Channels & 0xff00) >> 8;
    if (u32MulChannel > AO_TRACK_NORMAL_CHANNELNUM)
    {
        return u32MulChannel;
    }
    else
    {
        return 0;
    }
}

static HI_U32 TrackGetMcPcmSize(AO_FRAMEINFO_S* pstAOFrame)
{
    if (TrackGetMultiPcmChannels(pstAOFrame))
    {
        /* allways 8 ch */
        return pstAOFrame->u32PcmSamplesPerFrame * AUTIL_CalcFrameSize(AO_TRACK_MC_CHANNELNUM, pstAOFrame->s32BitPerSample);
    }
    else
    {
        return 0;
    }
}

static HI_VOID* TrackGetMcPcmAddr(AO_FRAMEINFO_S* pstAOFrame, SND_TRACK_STREAM_ATTR_S* pstStreamAttr)
{
    HI_VOID* pBase = (HI_VOID*)pstAOFrame->tPcmBuffer;
    
    if (!TrackGetMultiPcmChannels(pstAOFrame))
    {
        return HI_NULL;
    }
    else
    {
        /* dmx allways 2 ch */
        return pBase + pstStreamAttr->u32PcmBytesPerFrame;
    }
}
#endif

#ifdef DRV_SND_AD_OUTPUT_SUPPORT
static HI_BOOL TrackGetAssocPCMChannel(AO_FRAMEINFO_S* pstAOFrame)
{
    HI_U32 u32AssocChannel;

    //follow the new action(such as the channels of ms12)
    u32AssocChannel = (pstAOFrame->u32Channels & 0xff0000) >> 16;
    if (u32AssocChannel > AO_TRACK_NORMAL_CHANNELNUM || u32AssocChannel == 0)
    {
        return 0;
    }
    else
    {
        return u32AssocChannel;
    }
}

static HI_VOID* TrackGetAssocPcmAddr(AO_FRAMEINFO_S* pstAOFrame, SND_TRACK_STREAM_ATTR_S* pstStreamAttr)
{
    HI_VOID* pBase = (HI_VOID*)pstAOFrame->tPcmBuffer;
    
    if (!TrackGetAssocPCMChannel(pstAOFrame))
    {
        return HI_NULL;
    }
    else
    {
        return pBase + pstStreamAttr->u32PcmBytesPerFrame + pstStreamAttr->u32McPcmBytesPerFrame;
    }
}

static HI_U32 TrackGetAssocPcmSize(AO_FRAMEINFO_S* pstAOFrame)
{
    HI_U32 channels = (pstAOFrame->u32Channels & 0xff0000) >> 16;
    
    return pstAOFrame->u32PcmSamplesPerFrame * AUTIL_CalcFrameSize(channels, pstAOFrame->s32BitPerSample);
}
#endif

HI_VOID TRACK_DestroyEngine(SND_CARD_STATE_S* pCard)
{
    HI_U32 Id;

    for (Id = 0; Id < SND_ENGINE_TYPE_BUTT; Id++)
    {
        if (pCard->pSndEngine[Id])
        {
            TrackDestroyEngine(pCard->pSndEngine[Id]);
            pCard->pSndEngine[Id] = HI_NULL;
        }
    }
}

HI_S32 TrackCreateEngine(HI_VOID* *ppSndEngine, AOE_ENGINE_CHN_ATTR_S* pstAttr, SND_ENGINE_TYPE_E enType)
{
    SND_ENGINE_STATE_S* state = HI_NULL;
    HI_S32 Ret = HI_FAILURE;
    AOE_ENGINE_ID_E enEngine;

    *ppSndEngine = HI_NULL;

    state = AUTIL_AO_MALLOC(HI_ID_AO, sizeof(SND_ENGINE_STATE_S), GFP_KERNEL);
    if (state == HI_NULL)
    {
        HI_FATAL_AIAO("malloc CreateEngine failed\n");
        goto CreateEngine_ERR_EXIT;
    }

    memset(state, 0, sizeof(SND_ENGINE_STATE_S));

    if (HI_SUCCESS != HAL_AOE_ENGINE_Create(&enEngine, pstAttr))
    {
        HI_ERR_AO("Create engine failed!\n");
        goto CreateEngine_ERR_EXIT;
    }

    state->stUserEngineAttr = *pstAttr;
    state->enEngine = enEngine;
    state->enEngineType = enType;
    *ppSndEngine = (HI_VOID*)state;

    return HI_SUCCESS;

CreateEngine_ERR_EXIT:
    *ppSndEngine = HI_NULL;
    AUTIL_AO_FREE(HI_ID_AO, (HI_VOID*)state);
    return Ret;
}

SND_ENGINE_TYPE_E  TrackGetEngineType(HI_VOID* pSndEngine)
{
    SND_ENGINE_STATE_S* state = (SND_ENGINE_STATE_S*)pSndEngine;

    return (state->enEngineType);
}

HI_VOID*  TrackGetEngineHandlebyType(SND_CARD_STATE_S* pCard, SND_ENGINE_TYPE_E enType)
{
    HI_VOID* pSndEngine;

    pSndEngine = pCard->pSndEngine[enType];
    if (pSndEngine)
    {
        return pSndEngine;
    }

    return HI_NULL;
}

/******************************Track process FUNC*************************************/
HI_BOOL  TrackCheckIsPcmOutput(SND_CARD_STATE_S* pCard)
{
    if (SND_PCM_OUTPUT_CERTAIN == pCard->enPcmOutput)
    {
        return HI_TRUE;
    }
    else if (SND_PCM_OUTPUT_VIR_SPDIFORHDMI == pCard->enPcmOutput)
    {
        if (SND_SPDIF_MODE_PCM == pCard->enSpdifPassthrough || SND_HDMI_MODE_PCM == pCard->enHdmiPassthrough)
        {
            return HI_TRUE;
        }
    }

    return HI_FALSE;
}

static HI_U32 TrackGetDmxPcmSize(AO_FRAMEINFO_S* pstAOFrame)
{
    HI_U32 channels = pstAOFrame->u32Channels;

    if (TrackGetMultiPcmChannels(pstAOFrame))
    {
        channels = AO_TRACK_NORMAL_CHANNELNUM;
    }
    else
    {
        channels = channels & 0xff;
    }
    
    return pstAOFrame->u32PcmSamplesPerFrame * AUTIL_CalcFrameSize(channels, pstAOFrame->s32BitPerSample);
}

HI_U32 TrackGetMultiPcmSize(AO_FRAMEINFO_S* pstAOFrame)
{
    if (TrackGetMultiPcmChannels(pstAOFrame))
    {
        /* allways 8 ch */
        return pstAOFrame->u32PcmSamplesPerFrame * AUTIL_CalcFrameSize(AO_TRACK_MUTILPCM_CHANNELNUM, pstAOFrame->s32BitPerSample);
    }
    else
    {
        return 0;
    }
}

static HI_U32 TrackGetLbrSize(AO_FRAMEINFO_S* pstAOFrame)
{
    HI_U32 LbrRawBytes = 0;

    LbrRawBytes = (pstAOFrame->u32BitsBytesPerFrame & 0x7fff);
    return LbrRawBytes;
}

static HI_U32 TrackGetHbrSize(AO_FRAMEINFO_S* pstAOFrame)
{
    HI_U32 HbrRawBytes = 0;

    if (pstAOFrame->u32BitsBytesPerFrame & 0xffff0000)
    {
        HbrRawBytes = (pstAOFrame->u32BitsBytesPerFrame >> 16);
    }
    else
    {
        // truehd
        HbrRawBytes = (pstAOFrame->u32BitsBytesPerFrame & 0xffff);
    }

    return HbrRawBytes;
}

static HI_U32 TrackGetDmxPcmChannels(AO_FRAMEINFO_S* pstAOFrame)
{
    HI_U32 u32DmxPcmCh = pstAOFrame->u32Channels;
    u32DmxPcmCh = u32DmxPcmCh & 0xff;
    
    if (AO_TRACK_NORMAL_CHANNELNUM == u32DmxPcmCh || 1 == u32DmxPcmCh)
    {
        return u32DmxPcmCh;
    }
    else if (u32DmxPcmCh > AO_TRACK_NORMAL_CHANNELNUM)
    {
        return (HI_U32)(AO_TRACK_NORMAL_CHANNELNUM);
    }
    else
    {
        return 0;
    }
}

static HI_U32 TrackGetMultiPcmSampleRate(AO_FRAMEINFO_S * pstAOFrame)
{
    switch (pstAOFrame->u32SampleRate)
    {
       // case HI_UNF_SAMPLE_RATE_32K:
       // case HI_UNF_SAMPLE_RATE_44K:
       // case HI_UNF_SAMPLE_RATE_48K:
        case HI_UNF_SAMPLE_RATE_88K:
        case HI_UNF_SAMPLE_RATE_96K:
        case HI_UNF_SAMPLE_RATE_176K:
        case HI_UNF_SAMPLE_RATE_192K:
            return 1;
        default:
            return 0;
    }
}

HI_VOID* TrackGetPcmBufAddr(AO_FRAMEINFO_S* pstAOFrame)
{
    return (HI_VOID*)pstAOFrame->tPcmBuffer;
}
/*
  |----Interleaved dmx 2.0 frame----|--Interleaved multi 7.1 frame--|----Interleaved assoc 2.0 frame----|
  |----Interleaved 7.1-----------------------------|
  |----Interleaved 5.1----------------- padding 0/0|

*/
static HI_VOID* TrackGetMultiPcmAddr(AO_FRAMEINFO_S* pstAOFrame)
{
    HI_VOID* pBase = (HI_VOID*)pstAOFrame->tPcmBuffer;
    
    if (!TrackGetMultiPcmChannels(pstAOFrame))
    {
        return HI_NULL;
    }
    else
    {
        /* dmx allways 2 ch */
        return pBase + pstAOFrame->u32PcmSamplesPerFrame * AUTIL_CalcFrameSize(AO_TRACK_NORMAL_CHANNELNUM, pstAOFrame->s32BitPerSample);
    }
}

HI_VOID* TrackGetLbrBufAddr(AO_FRAMEINFO_S* pstAOFrame)
{
    if (pstAOFrame->u32BitsBytesPerFrame & 0x7fff)
    {
        return (HI_VOID*)pstAOFrame->tBitsBuffer;
    }

    return 0;
}

HI_VOID* TrackGetHbrBufAddr(AO_FRAMEINFO_S* pstAOFrame)
{
    HI_VOID* pAddr;

    pAddr = (HI_VOID*)pstAOFrame->tBitsBuffer;
    if (pstAOFrame->u32BitsBytesPerFrame & 0xffff0000)
    {
        pAddr += (pstAOFrame->u32BitsBytesPerFrame & 0x7fff);
    }

    return pAddr;
}

//for both passthrough-only(no pcm output) and simul mode
HI_VOID TrackBuildPcmAttr(AO_FRAMEINFO_S* pstAOFrame, SND_TRACK_STREAM_ATTR_S* pstStreamAttr)
{
    if (pstAOFrame->u32PcmSamplesPerFrame)
    {
        pstStreamAttr->u32PcmSampleRate = pstAOFrame->u32SampleRate;
        pstStreamAttr->u32PcmBitDepth   = pstAOFrame->s32BitPerSample;
        pstStreamAttr->u32PcmSamplesPerFrame = pstAOFrame->u32PcmSamplesPerFrame;
        pstStreamAttr->u32PcmBytesPerFrame   = TrackGetDmxPcmSize(pstAOFrame);
        pstStreamAttr->u32PcmChannels = TrackGetDmxPcmChannels(pstAOFrame);
        pstStreamAttr->pPcmDataBuf    = (HI_VOID*)TrackGetPcmBufAddr(pstAOFrame);
        
#ifdef DRV_SND_MULTICH_AEF_SUPPORT
        if (TrackGetMcPCMChannel(pstAOFrame))
        {
            pstStreamAttr->u32McPcmSampleRate = pstAOFrame->u32SampleRate;
            pstStreamAttr->u32McPcmBitDepth = pstAOFrame->s32BitPerSample;
            pstStreamAttr->u32McPcmBytesPerFrame = TrackGetMcPcmSize(pstAOFrame); //AOEIMP: TOCHECK, 8Ch??
            pstStreamAttr->u32McPcmChannels = TrackGetMcPCMChannel(pstAOFrame);
            pstStreamAttr->pMcPcmDataBuf = TrackGetMcPcmAddr(pstAOFrame, pstStreamAttr);
        } 
        else
        {
            //避免突然发生变化时仍然保留上一数据状态(但却是无效的)
            pstStreamAttr->u32McPcmSampleRate = HI_UNF_SAMPLE_RATE_48K;
            pstStreamAttr->u32McPcmBitDepth = AO_TRACK_BITDEPTH_LOW;
            pstStreamAttr->u32McPcmBytesPerFrame = 0;
            pstStreamAttr->u32McPcmChannels = 0;
            pstStreamAttr->pMcPcmDataBuf = (HI_VOID*)HI_NULL;  
        }
#endif

#ifdef DRV_SND_AD_OUTPUT_SUPPORT
        if (TrackGetAssocPCMChannel(pstAOFrame))
        {
            pstStreamAttr->u32AssocPcmSampleRate = pstAOFrame->u32SampleRate;
            pstStreamAttr->u32AssocPcmBitDepth = pstAOFrame->s32BitPerSample;
            pstStreamAttr->u32AssocPcmBytesPerFrame = TrackGetAssocPcmSize(pstAOFrame); //AOEIMP: TOCHECK, 8Ch??
            pstStreamAttr->u32AssocPcmChannels = TrackGetAssocPCMChannel(pstAOFrame);
            pstStreamAttr->pAssocPcmDataBuf = TrackGetAssocPcmAddr(pstAOFrame, pstStreamAttr);
        }
        else
        {
            //避免突然发生变化时仍然保留上一数据状态(但却是无效的)
            pstStreamAttr->u32AssocPcmSampleRate = HI_UNF_SAMPLE_RATE_48K;
            pstStreamAttr->u32AssocPcmBitDepth = AO_TRACK_BITDEPTH_LOW;
            pstStreamAttr->u32AssocPcmBytesPerFrame = 0;
            pstStreamAttr->u32AssocPcmChannels = 0;
            pstStreamAttr->pAssocPcmDataBuf = (HI_VOID*)HI_NULL;
        }
#endif
    }
    else
    {
        HI_U32 u32BitWidth;
        if (16 == pstAOFrame->s32BitPerSample)
        {
            u32BitWidth = sizeof(HI_U16);
        }
        else
        {
            u32BitWidth = sizeof(HI_U32);
        }
        if (pstStreamAttr->pLbrDataBuf)
        {
            pstStreamAttr->u32PcmSampleRate = pstAOFrame->u32SampleRate;
            pstStreamAttr->u32PcmBitDepth   = pstAOFrame->s32BitPerSample;
            pstStreamAttr->u32PcmBytesPerFrame = pstStreamAttr->u32LbrBytesPerFrame;
            pstStreamAttr->u32PcmChannels = AO_TRACK_NORMAL_CHANNELNUM;
            pstStreamAttr->u32PcmSamplesPerFrame = pstStreamAttr->u32PcmBytesPerFrame / pstStreamAttr->u32PcmChannels / u32BitWidth;
            pstStreamAttr->pPcmDataBuf = (HI_VOID*)HI_NULL;
        }
        else if (pstStreamAttr->pHbrDataBuf)
        {
            HI_U32 u32HbrSamplesPerFrame = pstStreamAttr->u32HbrBytesPerFrame / pstStreamAttr->u32HbrChannels / u32BitWidth;
            pstStreamAttr->u32PcmSamplesPerFrame = u32HbrSamplesPerFrame >> 2;
            pstStreamAttr->u32PcmSampleRate = pstAOFrame->u32SampleRate;
            pstStreamAttr->u32PcmBitDepth = pstAOFrame->s32BitPerSample;
            pstStreamAttr->u32PcmChannels = AO_TRACK_NORMAL_CHANNELNUM;
            pstStreamAttr->u32PcmBytesPerFrame = pstStreamAttr->u32PcmSamplesPerFrame * pstStreamAttr->u32PcmChannels * u32BitWidth;
            pstStreamAttr->pPcmDataBuf = (HI_VOID*)HI_NULL;
        }
        else
        {
            pstStreamAttr->u32PcmSampleRate = HI_UNF_SAMPLE_RATE_48K;
            pstStreamAttr->u32PcmBitDepth = AO_TRACK_BITDEPTH_LOW;
            pstStreamAttr->u32PcmChannels = AO_TRACK_NORMAL_CHANNELNUM;
            pstStreamAttr->u32PcmBytesPerFrame = 0;
            pstStreamAttr->u32PcmSamplesPerFrame = 0;
            pstStreamAttr->pPcmDataBuf = (HI_VOID*)HI_NULL;
#ifdef DRV_SND_MULTICH_AEF_SUPPORT
            pstStreamAttr->u32McPcmSampleRate = HI_UNF_SAMPLE_RATE_48K;
            pstStreamAttr->u32McPcmBitDepth = AO_TRACK_BITDEPTH_LOW;
            pstStreamAttr->u32McPcmBytesPerFrame = 0;
            pstStreamAttr->u32McPcmChannels = 0;
            pstStreamAttr->pMcPcmDataBuf = (HI_VOID*)HI_NULL;
#endif

#ifdef DRV_SND_AD_OUTPUT_SUPPORT
            pstStreamAttr->u32AssocPcmSampleRate = HI_UNF_SAMPLE_RATE_48K;
            pstStreamAttr->u32AssocPcmBitDepth = AO_TRACK_BITDEPTH_LOW;
            pstStreamAttr->u32AssocPcmBytesPerFrame = 0;
            pstStreamAttr->u32AssocPcmChannels = 0;
            pstStreamAttr->pAssocPcmDataBuf = (HI_VOID*)HI_NULL;
#endif            
        }
    }
}

static HI_VOID TRACKDbgCountTrySendData(SND_TRACK_STATE_S* pTrack)
{
    pTrack->u32SendTryCnt++;
}

static HI_VOID TRACKDbgCountSendData(SND_TRACK_STATE_S* pTrack)
{
    pTrack->u32SendCnt++;
}

static HI_VOID TRACKBuildMultiPcmStreamAttr(SND_CARD_STATE_S *pCard, AO_FRAMEINFO_S *pstAOFrame, SND_TRACK_STREAM_ATTR_S * pstStreamAttr)
{
    HI_S32 s32Ret = HI_FAILURE;

    HI_DRV_HDMI_AUDIO_CAPABILITY_S stSinkCap;

    memset(&stSinkCap, 0, sizeof(HI_DRV_HDMI_AUDIO_CAPABILITY_S));

    /*get the capability of the max pcm channels of the output device*/
    if (pCard->pstHdmiFunc && pCard->pstHdmiFunc->pfnHdmiGetAudioCapability)
    {
        s32Ret = (pCard->pstHdmiFunc->pfnHdmiGetAudioCapability)(HI_UNF_HDMI_ID_0, &stSinkCap);
    }

#if 0    //#if defined(HDMI_AUDIO_PASSTHROUGH_DEBUG)
    if (HI_TRUE == pCard->bHdmiDebug)
    {
        if (HI_UNF_SND_HDMI_MODE_RAW == pCard->enUserHdmiMode)
        {
            s32Ret = HI_SUCCESS; /* cheat SND work at hdmi plun-in status without hdmi device */
            stSinkCap.u32MaxPcmChannels = AO_TRACK_MUTILPCM_CHANNELNUM;
        }
    }
#endif

    if (HI_SUCCESS == s32Ret)
    {
        if (stSinkCap.u32MaxPcmChannels > AO_TRACK_NORMAL_CHANNELNUM)
        {
            pstStreamAttr->u32HbrBitDepth = pstAOFrame->s32BitPerSample;
            pstStreamAttr->u32HbrSampleRate = pstAOFrame->u32SampleRate;
            pstStreamAttr->u32HbrFormat = IEC61937_DATATYPE_71_LPCM;
            pstStreamAttr->u32HbrChannels = AO_TRACK_MUTILPCM_CHANNELNUM;
            pstStreamAttr->u32OrgMultiPcmChannels = TrackGetMultiPcmChannels(pstAOFrame);
            pstStreamAttr->u32HbrBytesPerFrame = TrackGetMultiPcmSize(pstAOFrame);
            pstStreamAttr->pHbrDataBuf = (HI_VOID*)TrackGetMultiPcmAddr(pstAOFrame);
        }
    }
}

static HI_VOID TRACKBuildCompressRawData(SND_TRACK_STREAM_ATTR_S* pstStreamAttr)
{
    HI_U16 *pu16Data;
    if (pstStreamAttr->u32LbrFormat & 0xff00)
    {
        pu16Data = (HI_U16 *)pstStreamAttr->pLbrDataBuf;
        pu16Data[0] = (HI_U16)(pstStreamAttr->u32LbrBytesPerFrame & 0xffff);
        if (pu16Data[0] <= 0)
        {
            HI_ERR_AO("Lbr Pa(%d) <= 0!!!!\n", pu16Data[0]);
        }
    }

    if (pstStreamAttr->u32HbrFormat & 0xff00)
    {
        pu16Data = (HI_U16 *)pstStreamAttr->pHbrDataBuf;
        pu16Data[0] = (HI_U16)(pstStreamAttr->u32HbrBytesPerFrame & 0xffff);
        if (pu16Data[0] <= 0)
        {
            HI_ERR_AO("Hbr Pa(%d) <= 0!!!!\n", pu16Data[0]);
        }
    }
}

static HI_VOID TRACKBuildStreamAttr(SND_CARD_STATE_S* pCard, AO_FRAMEINFO_S* pstAOFrame, SND_TRACK_STREAM_ATTR_S* pstStreamAttr)
{
    HI_U32 u32IEC61937DataType = 0;
    HI_BOOL bCompressed = HI_FALSE;
    memset(pstStreamAttr, 0, sizeof(SND_TRACK_STREAM_ATTR_S));

    // LBR action
    if (pstAOFrame->u32IEC61937DataType & 0xff)
    {
        //must be truehd iec61937 data type
        u32IEC61937DataType = pstAOFrame->u32IEC61937DataType & 0xff;    /*0~8bit : datatype*/
    }
    else
    {
        //except truehd, others need "AUTIL_IEC61937DataType" interface to make sure
        u32IEC61937DataType = AUTIL_IEC61937DataType((HI_U16*)TrackGetLbrBufAddr(pstAOFrame), TrackGetLbrSize(pstAOFrame));
        bCompressed = (pstAOFrame->u32BitsBytesPerFrame & 0x8000) ? HI_TRUE : HI_FALSE;
    }

    pstStreamAttr->u32LbrFormat = IEC61937_DATATYPE_NULL;
    if (u32IEC61937DataType && !(AUTIL_isIEC61937Hbr(u32IEC61937DataType, pstAOFrame->u32SampleRate)))
    {
        pstStreamAttr->u32LbrSampleRate = pstAOFrame->u32SampleRate;
        pstStreamAttr->u32LbrBitDepth = AO_TRACK_BITDEPTH_LOW;
        pstStreamAttr->u32LbrChannels = AO_TRACK_NORMAL_CHANNELNUM;
        pstStreamAttr->u32LbrFormat = ((bCompressed == HI_FALSE) ? u32IEC61937DataType : (u32IEC61937DataType | 0xff00));
        pstStreamAttr->u32LbrBytesPerFrame = TrackGetLbrSize(pstAOFrame);
        pstStreamAttr->pLbrDataBuf = TrackGetLbrBufAddr(pstAOFrame);
    }

    // HBR action
    if (pstAOFrame->u32IEC61937DataType & 0xff)
    {
        //must be truehd iec61937 data type
        u32IEC61937DataType = pstAOFrame->u32IEC61937DataType & 0xff;/*0~8bit : datatype*/
    }
    else
    {
        //except truehd, others need "AUTIL_IEC61937DataType" interface to make sure
        u32IEC61937DataType = AUTIL_IEC61937DataType((HI_U16*)TrackGetHbrBufAddr(pstAOFrame), TrackGetHbrSize(pstAOFrame));
    }

    pstStreamAttr->u32HbrFormat = IEC61937_DATATYPE_NULL;
    if ((AUTIL_isIEC61937Hbr(u32IEC61937DataType, pstAOFrame->u32SampleRate)))
    {
        pstStreamAttr->u32HbrBitDepth = AO_TRACK_BITDEPTH_LOW;
        pstStreamAttr->u32HbrChannels = ((IEC61937_DATATYPE_DOLBY_DIGITAL_PLUS == u32IEC61937DataType) ? 2 : 8);
        pstStreamAttr->u32HbrFormat = ((bCompressed == HI_FALSE) ? u32IEC61937DataType : (u32IEC61937DataType | 0xff00));
        if (pstAOFrame->u32SampleRate <= HI_UNF_SAMPLE_RATE_48K)
        {
            pstStreamAttr->u32HbrSampleRate = pstAOFrame->u32SampleRate * 4;  /* hbr 4*samplerate */
        }
        else if (pstAOFrame->u32SampleRate == HI_UNF_SAMPLE_RATE_88K || pstAOFrame->u32SampleRate == HI_UNF_SAMPLE_RATE_96K)
        {
            pstStreamAttr->u32HbrSampleRate = pstAOFrame->u32SampleRate * 2;
        }
        else
        {
            pstStreamAttr->u32HbrSampleRate = pstAOFrame->u32SampleRate;  /* hbr samplerate */
        }
        pstStreamAttr->u32HbrBytesPerFrame = TrackGetHbrSize(pstAOFrame);
        pstStreamAttr->pHbrDataBuf = TrackGetHbrBufAddr(pstAOFrame);
    }
    else if (pstStreamAttr->u32LbrFormat == IEC61937_DATATYPE_NULL && pstStreamAttr->u32HbrFormat == IEC61937_DATATYPE_NULL)
    {
        HI_U32 u32Channels = pstAOFrame->u32Channels & 0xff;
        if (HI_UNF_SND_HDMI_MODE_AUTO == pCard->enUserHdmiMode && u32Channels > AO_TRACK_NORMAL_CHANNELNUM)
        {
            TRACKBuildMultiPcmStreamAttr(pCard, pstAOFrame, pstStreamAttr);
        }
        else if (HI_UNF_SND_HDMI_MODE_RAW == pCard->enUserHdmiMode)
        {
            pstStreamAttr->u32HbrBitDepth = pstAOFrame->s32BitPerSample;
            pstStreamAttr->u32HbrSampleRate = pstAOFrame->u32SampleRate;

            if (u32Channels > AO_TRACK_NORMAL_CHANNELNUM)
            {
                pstStreamAttr->u32HbrFormat = IEC61937_DATATYPE_71_LPCM;
                pstStreamAttr->u32HbrChannels = AO_TRACK_MUTILPCM_CHANNELNUM;
                pstStreamAttr->u32OrgMultiPcmChannels = TrackGetMultiPcmChannels(pstAOFrame);
                pstStreamAttr->u32HbrBytesPerFrame = TrackGetMultiPcmSize(pstAOFrame);
                pstStreamAttr->pHbrDataBuf = (HI_VOID*)TrackGetMultiPcmAddr(pstAOFrame);
            }
            else if (TrackGetMultiPcmSampleRate(pstAOFrame))
            {
                pstStreamAttr->u32HbrFormat = IEC61937_DATATYPE_20_LPCM;
                pstStreamAttr->u32HbrChannels = u32Channels;
                pstStreamAttr->u32OrgMultiPcmChannels = u32Channels;
                pstStreamAttr->u32HbrBytesPerFrame = pstAOFrame->u32PcmSamplesPerFrame * AUTIL_CalcFrameSize(pstAOFrame->u32Channels, pstAOFrame->s32BitPerSample);
                pstStreamAttr->pHbrDataBuf = (HI_VOID*)pstAOFrame->tPcmBuffer;
            }         
        }
        else if (HI_UNF_SND_HDMI_MODE_HBR2LBR == pCard->enUserHdmiMode && TrackGetMultiPcmSampleRate(pstAOFrame))
        {
            pstStreamAttr->u32LbrBitDepth = pstAOFrame->s32BitPerSample;
            pstStreamAttr->u32LbrSampleRate = pstAOFrame->u32SampleRate;
            pstStreamAttr->u32LbrFormat = IEC61937_DATATYPE_20_LPCM;
            pstStreamAttr->u32OrgMultiPcmChannels = u32Channels;
            pstStreamAttr->pLbrDataBuf = (HI_VOID*)pstAOFrame->tPcmBuffer;

            if (u32Channels > AO_TRACK_NORMAL_CHANNELNUM)
            {
                pstStreamAttr->u32LbrChannels = AO_TRACK_NORMAL_CHANNELNUM;
                pstStreamAttr->u32LbrBytesPerFrame = pstAOFrame->u32PcmSamplesPerFrame * AUTIL_CalcFrameSize(AO_TRACK_NORMAL_CHANNELNUM, pstAOFrame->s32BitPerSample);
            }
            else
            {
                pstStreamAttr->u32LbrChannels = u32Channels;
                pstStreamAttr->u32LbrBytesPerFrame = pstAOFrame->u32PcmSamplesPerFrame * AUTIL_CalcFrameSize(pstAOFrame->u32Channels, pstAOFrame->s32BitPerSample);
            }
        }
    }

    // pcm
    TrackBuildPcmAttr(pstAOFrame, pstStreamAttr);
}

static SND_HDMI_MODE_E TRACKHdmiEdidChange(HI_DRV_HDMI_AUDIO_CAPABILITY_S* pstSinkCap, HI_U32 u32Format)
{
    switch (u32Format)
    {
        case IEC61937_DATATYPE_NULL:
            return SND_HDMI_MODE_PCM;

        case IEC61937_DATATYPE_DOLBY_DIGITAL:
            if (HI_TRUE == pstSinkCap->bAudioFmtSupported[AO_HDMI_CAPABILITY_AC3])
            {
                return SND_HDMI_MODE_LBR;
            }
            else
            {
                return SND_HDMI_MODE_PCM;
            }

        case IEC61937_DATATYPE_DTS_TYPE_I:
        case IEC61937_DATATYPE_DTS_TYPE_II:
        case IEC61937_DATATYPE_DTS_TYPE_III:
        case IEC61937_DATATYPE_DTSCD:
            if (HI_TRUE == pstSinkCap->bAudioFmtSupported[AO_HDMI_CAPABILITY_DTS])
            {
                return SND_HDMI_MODE_LBR;
            }
            else
            {
                return SND_HDMI_MODE_PCM;
            }

        case IEC61937_DATATYPE_DOLBY_DIGITAL_PLUS:
            if (HI_TRUE == pstSinkCap->bAudioFmtSupported[AO_HDMI_CAPABILITY_DDP])
            {
                return SND_HDMI_MODE_HBR;
            }
            else
            {
                return SND_HDMI_MODE_LBR;
            }

        case IEC61937_DATATYPE_DTS_TYPE_IV:
            if (HI_TRUE == pstSinkCap->bAudioFmtSupported[AO_HDMI_CAPABILITY_DTSHD])
            {
                return SND_HDMI_MODE_HBR;
            }
            else
            {
                return SND_HDMI_MODE_LBR;
            }

        case IEC61937_DATATYPE_DOLBY_TRUE_HD:
            if (HI_TRUE == pstSinkCap->bAudioFmtSupported[AO_HDMI_CAPABILITY_MAT])
            {
                return SND_HDMI_MODE_HBR;
            }
            else
            {
                return SND_HDMI_MODE_LBR;
            }

        case IEC61937_DATATYPE_71_LPCM:
            return SND_HDMI_MODE_HBR;

        default:
            HI_WARN_AO("Failed to judge edid cabability of format %d\n", u32Format);
            return SND_HDMI_MODE_PCM;
    }
}

#if 0
static SND_SPDIF_MODE_E TRACKArcEdidChange(HI_UNF_SND_ARC_AUDIO_CAP_S *pstArcCap, HI_U32 u32Format)
{
    switch(u32Format)
    {
        case IEC61937_DATATYPE_NULL:
            return SND_SPDIF_MODE_PCM;
            
        case IEC61937_DATATYPE_DOLBY_DIGITAL:
            if(HI_TRUE == pstArcCap->bAudioFmtSupported[HI_UNF_EDID_AUDIO_FORMAT_CODE_AC3])
            {
                return SND_SPDIF_MODE_LBR;
            }
            else
            {
                return SND_SPDIF_MODE_PCM;
            }
            
        case IEC61937_DATATYPE_DTS_TYPE_I:
        case IEC61937_DATATYPE_DTS_TYPE_II:
        case IEC61937_DATATYPE_DTS_TYPE_III: 
        case IEC61937_DATATYPE_DTSCD:   
            if(HI_TRUE == pstArcCap->bAudioFmtSupported[HI_UNF_EDID_AUDIO_FORMAT_CODE_DTS])
            {
                return SND_SPDIF_MODE_LBR;
            }
            else
            {
                return SND_SPDIF_MODE_PCM;
            }

        case IEC61937_DATATYPE_DOLBY_DIGITAL_PLUS:
            if(HI_TRUE == pstArcCap->bAudioFmtSupported[HI_UNF_EDID_AUDIO_FORMAT_CODE_DDP])
            {
                return SND_SPDIF_MODE_HBR;
            }
            else
            {
                return SND_SPDIF_MODE_LBR;
            }             
            
        case IEC61937_DATATYPE_DTS_TYPE_IV:    //Spdif can't transmit dtshd
                return SND_SPDIF_MODE_LBR;
                
        case IEC61937_DATATYPE_DOLBY_TRUE_HD:  //Spdif can't transmit truehd
                return SND_SPDIF_MODE_LBR;
                
        case IEC61937_DATATYPE_71_LPCM:       //Spdif can't transmit 7.1 pcm
            return SND_SPDIF_MODE_LBR;  

        default:
            HI_WARN_AO("Failed to judge edid cabability of format %d\n", u32Format);
            return SND_SPDIF_MODE_PCM;       
    }
}
#endif

TRACK_STREAMMODE_CHANGE_E GetHdmiChangeMode(SND_CARD_STATE_S *pCard, SND_TRACK_STREAM_ATTR_S *pstAttr)
{
    SND_OP_ATTR_S stSndPortAttr;
    HI_VOID* pSndOp = HI_NULL;
    TRACK_STREAMMODE_CHANGE_E enChange = TRACK_STREAMMODE_CHANGE_NONE;
    SND_HDMI_MODE_E mode  = SND_HDMI_MODE_PCM;
    HI_BOOL bdisPassThrough = HI_FALSE;
    HI_S32 s32Ret = HI_FAILURE;
#if 0
    HI_U32 u32Status = HI_FALSE;
#endif
    pSndOp = SND_GetOpHandlebyOutType(pCard, SND_OUTPUT_TYPE_HDMI);
    if (!pSndOp)
    {
        return TRACK_STREAMMODE_CHANGE_NONE;
    }

    s32Ret = SND_GetOpAttr(pCard, SND_GetOpOutputport(pSndOp), &stSndPortAttr);
    if (HI_SUCCESS != s32Ret)
    {
        HI_ERR_AO("SND_GetOpAttr Fail\n");
        return s32Ret;
    }

    /* ui */
    if (HI_UNF_SND_HDMI_MODE_LPCM == pCard->enUserHdmiMode)
    {
        bdisPassThrough = HI_TRUE;
    }
#if 0
    if (pCard->pstHdmiFunc && pCard->pstHdmiFunc->pfnHdmiGetPlayStus)
    {
        (pCard->pstHdmiFunc->pfnHdmiGetPlayStus)(HI_UNF_HDMI_ID_0, &u32Status);
#if defined(HDMI_AUDIO_PASSTHROUGH_DEBUG)
        if (HI_TRUE == pCard->bHdmiDebug)
        {
            u32Status = HI_TRUE; /* cheat SND work at hdmi plun-in status without hdmi device */
        }
#endif
    }

    /*HDMI disconnect just PCM no LBR/HBR output */
    if (u32Status != HI_TRUE)
    {
        bdisPassThrough = HI_TRUE;
    }
#endif
    /* no raw data at stream */
    if (!(pstAttr->u32LbrFormat & 0xff) && !(pstAttr->u32HbrFormat & 0xff))
    {
        bdisPassThrough = HI_TRUE;
    }

    if (bdisPassThrough)
    {
        /* disable hdmi pass-through, switch to pcm */
        mode = SND_HDMI_MODE_PCM;
    }
    else
    {
        HI_DRV_HDMI_AUDIO_CAPABILITY_S stSinkCap;
        mode = SND_HDMI_MODE_LBR;
        if (pCard->pstHdmiFunc && pCard->pstHdmiFunc->pfnHdmiGetAudioCapability)
        {
            s32Ret = (pCard->pstHdmiFunc->pfnHdmiGetAudioCapability)(HI_UNF_HDMI_ID_0, &stSinkCap);
        }
        else
        {
            HI_ERR_AO("pfnHdmiGetAudioCapability Fail\n");
            s32Ret = HI_FAILURE;
        }

        if (pstAttr->u32HbrFormat & 0xff)
        {
            mode = SND_HDMI_MODE_HBR;
            if (HI_UNF_SND_HDMI_MODE_HBR2LBR == pCard->enUserHdmiMode)
            {
                /* hbr2lbr */
                if (pstAttr->u32LbrFormat & 0xff)
                {
                    mode = SND_HDMI_MODE_LBR;
                }
                else
                {
                    mode = SND_HDMI_MODE_PCM;
                }
            }
            if ((HI_UNF_SND_HDMI_MODE_AUTO == pCard->enUserHdmiMode) && (HI_SUCCESS == s32Ret))
            {
                mode = TRACKHdmiEdidChange(&stSinkCap, (pstAttr->u32HbrFormat & 0xff));
            }
        }
        if (SND_HDMI_MODE_LBR == mode)
        {
            if ((HI_UNF_SND_HDMI_MODE_AUTO == pCard->enUserHdmiMode) && (HI_SUCCESS == s32Ret))
            {
                mode = TRACKHdmiEdidChange(&stSinkCap, (pstAttr->u32LbrFormat & 0xff));
            }
        }
    }

    if(s32Ret != HI_SUCCESS)
    {
        mode = SND_HDMI_MODE_PCM;
    }
    
    if (SND_HDMI_MODE_PCM == mode)
    {
        if (SND_HDMI_MODE_LBR == pCard->enHdmiPassthrough)
        {
            enChange = TRACK_STREAMMODE_CHANGE_LBR2PCM;
        }
        else if (SND_HDMI_MODE_HBR == pCard->enHdmiPassthrough)
        {
            enChange = TRACK_STREAMMODE_CHANGE_HBR2PCM;
        }
    }
    else if (SND_HDMI_MODE_LBR == mode)
    {
        if (SND_HDMI_MODE_PCM == pCard->enHdmiPassthrough)
        {
            enChange = TRACK_STREAMMODE_CHANGE_PCM2LBR;
        }
        else if (SND_HDMI_MODE_LBR == pCard->enHdmiPassthrough)
        {
            if (pstAttr->u32LbrSampleRate != stSndPortAttr.u32SampleRate)
            {
                enChange = TRACK_STREAMMODE_CHANGE_LBR2LBR;
            }
        }
        else if (SND_HDMI_MODE_HBR == pCard->enHdmiPassthrough)
        {
            enChange = TRACK_STREAMMODE_CHANGE_HBR2LBR;
        }
    }
    else if (SND_HDMI_MODE_HBR == mode)
    {
        if (SND_HDMI_MODE_PCM == pCard->enHdmiPassthrough)
        {
            enChange = TRACK_STREAMMODE_CHANGE_PCM2HBR;
        }
        else if (SND_HDMI_MODE_LBR == pCard->enHdmiPassthrough)
        {
            enChange = TRACK_STREAMMODE_CHANGE_LBR2HBR;
        }
        else if (SND_HDMI_MODE_HBR == pCard->enHdmiPassthrough)
        {
            if (pstAttr->u32HbrSampleRate != stSndPortAttr.u32SampleRate)
            {
                enChange = TRACK_STREAMMODE_CHANGE_HBR2HBR;
            }
        }
    }

    return enChange;
}

#if 0
TRACK_STREAMMODE_CHANGE_E GetSpdifChangeMode(SND_CARD_STATE_S* pCard, SND_TRACK_STREAM_ATTR_S* pstAttr)
{
    HI_S32 s32Ret;
    SND_OP_ATTR_S stSndPortAttr;
    HI_VOID* pSndOp = HI_NULL;
    HI_BOOL bdisPassThrough = HI_FALSE;
    SND_SPDIF_MODE_E mode  = SND_SPDIF_MODE_PCM;
    TRACK_STREAMMODE_CHANGE_E enChange = TRACK_STREAMMODE_CHANGE_NONE;

    pSndOp = SND_GetOpHandlebyOutType(pCard, SND_OUTPUT_TYPE_SPDIF);
    if (HI_NULL == pSndOp)
    {        
        HI_ERR_AO("SND_GetOpHandlebyOutType Fail\n");
        return TRACK_STREAMMODE_CHANGE_NONE;
    }

    s32Ret = SND_GetOpAttr(pCard, SND_GetOpOutputport(pSndOp), &stSndPortAttr);
    if (HI_SUCCESS != s32Ret)
    {
        HI_ERR_AO("SND_GetOpAttr Fail\n");
        return TRACK_STREAMMODE_CHANGE_NONE;
    }

    //step 1: certain current mode
    /* ui or stream */
    if (HI_FALSE == pCard->bUserArcEnable)  //SpdifOut route (only consider PCM and LBR)
    {
        if ((HI_UNF_SND_SPDIF_MODE_LPCM == pCard->enUserSpdifMode) || (IEC61937_DATATYPE_NULL == (pstAttr->u32LbrFormat & 0xff)))
        {
            bdisPassThrough = HI_TRUE;  //User set PCM or have not raw data, so only output pcm
        }
    }
    else  //ARC route (consider PCM and LBR and HBR(only DDP))
    {

        if (HI_UNF_SND_ARC_AUDIO_MODE_LPCM == pCard->enUserArcMode)
        {
            bdisPassThrough = HI_TRUE;  //User set PCM, so only output pcm
        }

        if (!(pstAttr->u32LbrFormat & 0xff) && !(pstAttr->u32HbrFormat & 0xff)) 
        {
            bdisPassThrough = HI_TRUE;  //have not raw data, so only output pcm
        }
    }

    if (bdisPassThrough)
    {
        mode = SND_SPDIF_MODE_PCM;
    }
    else
    {        
        mode = SND_SPDIF_MODE_LBR;  //no arc
        if (HI_TRUE == pCard->bUserArcEnable)
        {
            if (pstAttr->u32HbrFormat & 0xff)
            {
                mode = SND_SPDIF_MODE_HBR; 
                if ( (HI_UNF_SND_ARC_AUDIO_MODE_HBR2LBR == pCard->enUserArcMode) 
                    || (IEC61937_DATATYPE_DTS_TYPE_IV == (pstAttr->u32HbrFormat & 0xff))  //Spdif can't transmit dtshd
                    || (IEC61937_DATATYPE_DOLBY_TRUE_HD == (pstAttr->u32HbrFormat & 0xff))//Spdif can't transmit truehd
                    || (IEC61937_DATATYPE_71_LPCM == (pstAttr->u32HbrFormat  & 0xff)))     //Spdif can't transmit 7.1 pcm
                {
                    /* hbr2lbr */
                    if(pstAttr->u32LbrFormat & 0xff)
                    {
                        mode = SND_SPDIF_MODE_LBR;
                    }
                    else
                    {
                        mode = SND_SPDIF_MODE_PCM;
                    }
                }

                if(HI_UNF_SND_ARC_AUDIO_MODE_AUTO == pCard->enUserArcMode)
                {               
                    mode = TRACKArcEdidChange(&pCard->stUserArcCap, pstAttr->u32HbrFormat & 0xff); //judge according to ARC Edid for HBR
                }

            }

            if(SND_SPDIF_MODE_LBR == mode)
            {
                if(HI_UNF_SND_ARC_AUDIO_MODE_AUTO == pCard->enUserArcMode)
                {
                    mode = TRACKArcEdidChange(&pCard->stUserArcCap, pstAttr->u32LbrFormat & 0xff); //second judge according to ARC Edid for LBR
                }
            }
        }
    }

    //step 2: certain mode change
    if (SND_SPDIF_MODE_PCM == mode)
    {
        if (SND_SPDIF_MODE_LBR == pCard->enSpdifPassthrough)
        {
            enChange = TRACK_STREAMMODE_CHANGE_LBR2PCM;
        }
        else if (SND_SPDIF_MODE_HBR == pCard->enSpdifPassthrough)
        {
            enChange = TRACK_STREAMMODE_CHANGE_HBR2PCM;
        }
    }
    else if (SND_SPDIF_MODE_LBR == mode)
    {
        if (SND_SPDIF_MODE_PCM == pCard->enSpdifPassthrough)
        {
            enChange = TRACK_STREAMMODE_CHANGE_PCM2LBR;
        }
        else if (SND_SPDIF_MODE_LBR == pCard->enSpdifPassthrough)
        {
            if ((pstAttr->u32LbrSampleRate != stSndPortAttr.u32SampleRate) ||
                (pstAttr->u32LbrFormat != stSndPortAttr.u32DataFormat))
            {
                enChange = TRACK_STREAMMODE_CHANGE_LBR2LBR;  /* stream change samplerate */
            }
        }
        else if (SND_SPDIF_MODE_HBR == pCard->enSpdifPassthrough)
        {
            enChange = TRACK_STREAMMODE_CHANGE_HBR2LBR;
        }
    }
    else if (SND_SPDIF_MODE_HBR == mode)
    {
        if (SND_SPDIF_MODE_PCM == pCard->enSpdifPassthrough)
        {
            enChange = TRACK_STREAMMODE_CHANGE_PCM2HBR;
        }
        else if (SND_SPDIF_MODE_LBR == pCard->enSpdifPassthrough)
        {
            enChange = TRACK_STREAMMODE_CHANGE_LBR2HBR;
        }
        else if (SND_SPDIF_MODE_HBR == pCard->enSpdifPassthrough)
        {
            if (pstAttr->u32HbrSampleRate != stSndPortAttr.u32SampleRate)
            {
                enChange = TRACK_STREAMMODE_CHANGE_HBR2HBR;
            }
        }
    }

    return enChange;
}

#else

TRACK_STREAMMODE_CHANGE_E GetSpdifChangeMode(SND_CARD_STATE_S *pCard, SND_TRACK_STREAM_ATTR_S *pstAttr)
{
    HI_S32 s32Ret;
    SND_OP_ATTR_S stSndPortAttr;
    HI_VOID* pSndOp = HI_NULL;
    HI_BOOL bdisPassThrough = HI_FALSE;
    TRACK_STREAMMODE_CHANGE_E enChange = TRACK_STREAMMODE_CHANGE_NONE;

    if ((pstAttr->u32LbrFormat & 0xff) == IEC61937_DATATYPE_20_LPCM)
    {
        return TRACK_STREAMMODE_CHANGE_NONE;
    }

    pSndOp = SND_GetOpHandlebyOutType(pCard, SND_OUTPUT_TYPE_SPDIF);
    if (HI_NULL == pSndOp)
    {
        return TRACK_STREAMMODE_CHANGE_NONE;
    }

    s32Ret = SND_GetOpAttr(pCard, SND_GetOpOutputport(pSndOp), &stSndPortAttr);
    if(HI_SUCCESS != s32Ret)
    {
        HI_ERR_AO("SND_GetOpAttr Fail\n");
        return s32Ret;
    }

    /* ui or stream */
    if ((HI_UNF_SND_SPDIF_MODE_LPCM == pCard->enUserSpdifMode) || (IEC61937_DATATYPE_NULL == pstAttr->u32LbrFormat))
    {
        bdisPassThrough = HI_TRUE;
    }

    if (bdisPassThrough)
    {
        /* disable spdif pass-through */
        if (SND_SPDIF_MODE_LBR == pCard->enSpdifPassthrough)
        {
            enChange = TRACK_STREAMMODE_CHANGE_LBR2PCM;
        }
    }
    else
    {
        /* enable spdif pass-through */
        if (SND_SPDIF_MODE_LBR == pCard->enSpdifPassthrough)
        {
            if (pstAttr->u32LbrSampleRate != stSndPortAttr.u32SampleRate)
            {
                enChange = TRACK_STREAMMODE_CHANGE_LBR2LBR;  /* shtream change samplerate */
            }
        }
        else
        {
            enChange = TRACK_STREAMMODE_CHANGE_PCM2LBR;     /* atcive pass-through */
        }
    }

    return enChange;
}

#endif

HI_VOID DetectTrueHDModeChange(SND_CARD_STATE_S* pCard, SND_TRACK_STREAM_ATTR_S* pstAttr)
{
    if (IEC61937_DATATYPE_DOLBY_TRUE_HD == (pstAttr->u32HbrFormat & 0xff))
    {
        if (SND_HDMI_MODE_HBR == pCard->enHdmiPassthrough)
        {
            HI_U32 u32PcmBitWidth, u32SampleRateWidth, u32HbrBitWidth;
            HI_U32 u32HbrSamplesPerFrame;
            if (16 == pstAttr->u32PcmBitDepth)
            {
                u32PcmBitWidth = sizeof(HI_U16);
            }
            else
            {
                u32PcmBitWidth = sizeof(HI_U32);
            }

            if (16 == pstAttr->u32HbrBitDepth)
            {
                u32HbrBitWidth = sizeof(HI_U16);
            }
            else
            {
                u32HbrBitWidth = sizeof(HI_U32);
            }

            if (pstAttr->u32PcmSampleRate <= HI_UNF_SAMPLE_RATE_48K)
            {
                u32SampleRateWidth = 2;
            }
            else if ((HI_UNF_SAMPLE_RATE_88K == pstAttr->u32PcmSampleRate) || (HI_UNF_SAMPLE_RATE_96K == pstAttr->u32PcmSampleRate))
            {
                u32SampleRateWidth = 1;
            }
            else
            {
                u32SampleRateWidth = 0;
            }

            u32HbrSamplesPerFrame = pstAttr->u32HbrBytesPerFrame / pstAttr->u32HbrChannels / u32HbrBitWidth;
            pstAttr->u32PcmSamplesPerFrame = u32HbrSamplesPerFrame >> u32SampleRateWidth;
            pstAttr->u32PcmChannels = AO_TRACK_NORMAL_CHANNELNUM;
            pstAttr->u32PcmBytesPerFrame = pstAttr->u32PcmSamplesPerFrame * pstAttr->u32PcmChannels * u32PcmBitWidth;
            pstAttr->pPcmDataBuf = (HI_VOID*)HI_NULL;
        }
    }
}


static HI_VOID DetectStreamModeChange(SND_CARD_STATE_S* pCard, SND_TRACK_STATE_S* pTrack, SND_TRACK_STREAM_ATTR_S* pstAttr,
                               STREAMMODE_CHANGE_ATTR_S* pstChange)
{
    SND_TRACK_STREAM_ATTR_S* pstAttr_old = &pTrack->stStreamAttr;

    pstChange->enPcmChange   = TRACK_STREAMMODE_CHANGE_NONE;
    pstChange->enSpdifChange = TRACK_STREAMMODE_CHANGE_NONE;
    pstChange->enHdmiChnage  = TRACK_STREAMMODE_CHANGE_NONE;

    // pcm stream attr(image that u32PcmBitDepth & u32PcmSampleRate is the same for dmx & mc & assoc)
    //AOEIMPDYJ: TODO
    if ((pstAttr_old->u32PcmBitDepth != pstAttr->u32PcmBitDepth) || 
        (pstAttr_old->u32PcmSampleRate != pstAttr->u32PcmSampleRate) ||
        (pstAttr_old->u32PcmChannels != pstAttr->u32PcmChannels))
    {
        pstChange->enPcmChange = TRACK_STREAMMODE_CHANGE_PCM2PCM;
    }
    
#ifdef DRV_SND_MULTICH_AEF_SUPPORT
    if (pstAttr_old->u32McPcmChannels != pstAttr->u32McPcmChannels)
    {
        pstChange->enPcmChange = TRACK_STREAMMODE_CHANGE_PCM2PCM;
    }
#endif

#ifdef DRV_SND_AD_OUTPUT_SUPPORT
    if (pstAttr_old->u32AssocPcmChannels != pstAttr->u32AssocPcmChannels)
    {
        pstChange->enPcmChange = TRACK_STREAMMODE_CHANGE_PCM2PCM;
    }
#endif

    if (HI_UNF_SND_TRACK_TYPE_MASTER == pTrack->stUserTrackAttr.enTrackType)
    {
        if (SND_SPDIF_MODE_NONE != pCard->enSpdifPassthrough)
        {
            pstChange->enSpdifChange = GetSpdifChangeMode(pCard, pstAttr);
        }

        if (SND_HDMI_MODE_NONE != pCard->enHdmiPassthrough)
        {
            pstChange->enHdmiChnage  = GetHdmiChangeMode(pCard, pstAttr);
        }
    }
}

HI_VOID SndProcPcmRoute(SND_CARD_STATE_S* pCard, SND_TRACK_STATE_S* pTrack, TRACK_STREAMMODE_CHANGE_E enMode,
                        SND_TRACK_STREAM_ATTR_S* pstAttr)
{
    AOE_AIP_CHN_ATTR_S stAipAttr;
#if defined (DRV_SND_MULTICH_AEF_SUPPORT) || defined (DRV_SND_AD_OUTPUT_SUPPORT)    
    SND_ENGINE_STATE_S *pstEnginestate = (SND_ENGINE_STATE_S*)pCard->pSndEngine[SND_ENGINE_TYPE_PCM];
#endif

    if (TRACK_STREAMMODE_CHANGE_NONE == enMode)
    {
        return;
    }

    HAL_AOE_AIP_GetAttr(pTrack->enAIP[SND_AIP_TYPE_PCM], &stAipAttr);
    stAipAttr.stBufInAttr.u32BufBitPerSample = pstAttr->u32PcmBitDepth;
    stAipAttr.stBufInAttr.u32BufSampleRate = pstAttr->u32PcmSampleRate;
    stAipAttr.stBufInAttr.u32BufChannels   = pstAttr->u32PcmChannels;
    stAipAttr.stBufInAttr.u32BufDataFormat = 0;
    HAL_AOE_AIP_SetAttr(pTrack->enAIP[SND_AIP_TYPE_PCM], &stAipAttr);

#ifdef DRV_SND_MULTICH_AEF_SUPPORT
    if (pstAttr->u32McPcmChannels)
    {
        pCard->enPcmMcStart = HI_TRUE;
        HAL_AOE_AIP_GetAttr(pTrack->enAIP[SND_AIP_TYPE_MC_PCM], &stAipAttr);
        stAipAttr.stBufInAttr.u32BufBitPerSample = pstAttr->u32McPcmBitDepth;
        stAipAttr.stBufInAttr.u32BufSampleRate = pstAttr->u32McPcmSampleRate;
        stAipAttr.stBufInAttr.u32BufChannels   = pstAttr->u32McPcmChannels;
        stAipAttr.stBufInAttr.u32BufDataFormat = 0;
        HAL_AOE_AIP_SetAttr(pTrack->enAIP[SND_AIP_TYPE_MC_PCM], &stAipAttr);
        HAL_AOE_ENGINE_AttachAip(pstEnginestate->enEngine, pTrack->enAIP[SND_AIP_TYPE_MC_PCM]);
    }
    else
    {
        pCard->enPcmMcStart = HI_FALSE;
    }
#endif

#ifdef DRV_SND_AD_OUTPUT_SUPPORT
    if (pstAttr->u32AssocPcmChannels)
    {    
        pCard->enPcmAssocStart = HI_TRUE;
        HAL_AOE_AIP_GetAttr(pTrack->enAIP[SND_AIP_TYPE_ASSOC_PCM], &stAipAttr);
        stAipAttr.stBufInAttr.u32BufBitPerSample = pstAttr->u32AssocPcmBitDepth;
        stAipAttr.stBufInAttr.u32BufSampleRate = pstAttr->u32AssocPcmSampleRate;
        stAipAttr.stBufInAttr.u32BufChannels   = pstAttr->u32AssocPcmChannels;
        stAipAttr.stBufInAttr.u32BufDataFormat = 0;
        HAL_AOE_AIP_SetAttr(pTrack->enAIP[SND_AIP_TYPE_ASSOC_PCM], &stAipAttr);
        HAL_AOE_ENGINE_AttachAip(pstEnginestate->enEngine, pTrack->enAIP[SND_AIP_TYPE_ASSOC_PCM]);
    }
    else
    {
        pCard->enPcmAssocStart = HI_FALSE;
    }
#endif

    memcpy(&pTrack->stStreamAttr, pstAttr, sizeof(SND_TRACK_STREAM_ATTR_S));
    return;
}


static HI_VOID TranslateOpAttr(SND_OP_ATTR_S* pstOpAttr,  TRACK_STREAMMODE_CHANGE_E enMode, SND_TRACK_STREAM_ATTR_S* pstAttr)
{
    HI_U32 u32PeriondMs;
    HI_U32 u32FrameSize;
    HI_U32 BitDepth, Channels, Format, Rate;


    if ((TRACK_STREAMMODE_CHANGE_PCM2LBR == enMode) || (TRACK_STREAMMODE_CHANGE_LBR2LBR == enMode)
        || (TRACK_STREAMMODE_CHANGE_HBR2LBR == enMode))
    {
        BitDepth = pstAttr->u32LbrBitDepth;
        Channels = pstAttr->u32LbrChannels;
        Format = pstAttr->u32LbrFormat;
        Rate = pstAttr->u32LbrSampleRate;
    }
    else if ((TRACK_STREAMMODE_CHANGE_PCM2HBR == enMode) || (TRACK_STREAMMODE_CHANGE_LBR2HBR == enMode)
             || (TRACK_STREAMMODE_CHANGE_HBR2HBR == enMode))
    {
        BitDepth = pstAttr->u32HbrBitDepth;
        Channels = pstAttr->u32HbrChannels;
        Format = pstAttr->u32HbrFormat;
        Rate = pstAttr->u32HbrSampleRate;
    }
    else
    {
        BitDepth = AO_TRACK_BITDEPTH_LOW;
        Channels   = AO_TRACK_NORMAL_CHANNELNUM;
        Rate = HI_UNF_SAMPLE_RATE_48K;
        Format = 0;
    }
#if 1
    /* recaculate PeriodBufSize */
    u32FrameSize = AUTIL_CalcFrameSize(pstOpAttr->u32Channels, pstOpAttr->u32BitPerSample);
    u32PeriondMs = AUTIL_ByteSize2LatencyMs(pstOpAttr->u32PeriodBufSize, u32FrameSize, pstOpAttr->u32SampleRate);
    u32FrameSize = AUTIL_CalcFrameSize(Channels, BitDepth);
    pstOpAttr->u32PeriodBufSize = AUTIL_LatencyMs2ByteSize(u32PeriondMs, u32FrameSize, Rate);
#endif
    pstOpAttr->u32BitPerSample = BitDepth;
    pstOpAttr->u32SampleRate = Rate;
    pstOpAttr->u32Channels   = Channels;
    pstOpAttr->u32DataFormat = Format;
}

//proprocess hdmi output
static HI_VOID  HDMISetAudioMute(SND_CARD_STATE_S *pCard)
{
    if(pCard->pstHdmiFunc && pCard->pstHdmiFunc->pfnHdmiSetAudioMute)
    {
        (pCard->pstHdmiFunc->pfnHdmiSetAudioMute)(HI_UNF_HDMI_ID_0);
    }
    else
        HI_WARN_AO(" pstHdmiFunc->pfnHdmiPreFormat Not Found !\n");
}

static HI_VOID  HDMISetAudioUnMute(SND_CARD_STATE_S *pCard)
{
    if(pCard->pstHdmiFunc && pCard->pstHdmiFunc->pfnHdmiSetAudioMute)
    {
        (pCard->pstHdmiFunc->pfnHdmiSetAudioUnMute)(HI_UNF_HDMI_ID_0);
    }
    else
        HI_WARN_AO(" pstHdmiFunc->pfnHdmiPreFormat Not Found !\n");
}

//verify should simple , can change hdmi attr according to op attr
static HI_VOID  HDMIAudioChange(SND_CARD_STATE_S* pCard, TRACK_STREAMMODE_CHANGE_E enMode,
                                SND_TRACK_STREAM_ATTR_S* pstAttr)
{
    HI_S32 s32Ret;
    HDMI_AUDIOINTERFACE_E enHdmiSoundIntf;
    HDMI_AUDIO_ATTR_S stHDMIAttr;
    HI_U32 Channels,Rate;
    HI_UNF_EDID_AUDIO_FORMAT_CODE_E enAudioFormat = HI_UNF_EDID_AUDIO_FORMAT_CODE_RESERVED;

    if ((TRACK_STREAMMODE_CHANGE_PCM2LBR == enMode) || (TRACK_STREAMMODE_CHANGE_LBR2LBR == enMode)
        || (TRACK_STREAMMODE_CHANGE_HBR2LBR == enMode))
    {
        HI_U32 u32LbrFormat = pstAttr->u32LbrFormat & 0xff;
        Channels = pstAttr->u32LbrChannels;
        Rate = pstAttr->u32LbrSampleRate;
        enHdmiSoundIntf = HDMI_AUDIO_INTERFACE_SPDIF;
        /* set hdmi_audio_interface_spdif audio codec type  */
        if((IEC61937_DATATYPE_DOLBY_DIGITAL == u32LbrFormat))
        {
            enAudioFormat = HI_UNF_EDID_AUDIO_FORMAT_CODE_AC3;
        }
        else if(IEC61937_DATATYPE_DTS_TYPE_I == u32LbrFormat  || 
                IEC61937_DATATYPE_DTS_TYPE_II == u32LbrFormat ||   
                IEC61937_DATATYPE_DTS_TYPE_III == u32LbrFormat)
        {
            enAudioFormat = HI_UNF_EDID_AUDIO_FORMAT_CODE_DTS;
        }
        else if(IEC61937_DATATYPE_20_LPCM == u32LbrFormat)
        {
            Channels = pstAttr->u32LbrChannels;
            enHdmiSoundIntf = HDMI_AUDIO_INTERFACE_I2S;
            enAudioFormat = HI_UNF_EDID_AUDIO_FORMAT_CODE_PCM;  
            Rate = pstAttr->u32PcmSampleRate;
        }
    }
    else if (TRACK_STREAMMODE_CHANGE_PCM2HBR == enMode ||
             TRACK_STREAMMODE_CHANGE_LBR2HBR == enMode ||
             TRACK_STREAMMODE_CHANGE_HBR2HBR == enMode)
    {
        HI_U32 u32HbrFormat = pstAttr->u32HbrFormat & 0xff;
        Rate = pstAttr->u32HbrSampleRate;
        Channels = pstAttr->u32HbrChannels;
        enHdmiSoundIntf = HDMI_AUDIO_INTERFACE_HBR;
        if(IEC61937_DATATYPE_71_LPCM == u32HbrFormat ||
           IEC61937_DATATYPE_20_LPCM == u32HbrFormat)
        {
            Channels = pstAttr->u32OrgMultiPcmChannels;
            enHdmiSoundIntf = HDMI_AUDIO_INTERFACE_I2S;   //verify
            enAudioFormat = HI_UNF_EDID_AUDIO_FORMAT_CODE_PCM;  
            Rate = pstAttr->u32PcmSampleRate;
        }
        else if (IEC61937_DATATYPE_DOLBY_DIGITAL_PLUS == u32HbrFormat)
        {
            enHdmiSoundIntf = HDMI_AUDIO_INTERFACE_SPDIF;
            enAudioFormat = HI_UNF_EDID_AUDIO_FORMAT_CODE_DDP;  //set hdmi_audio_interface_spdif audio codec type
        }
        else if(IEC61937_DATATYPE_DTS_TYPE_IV == u32HbrFormat)
        {
            enAudioFormat = HI_UNF_EDID_AUDIO_FORMAT_CODE_DTS_HD;  
        }
    }    
    else if ((TRACK_STREAMMODE_CHANGE_LBR2PCM == enMode) || (TRACK_STREAMMODE_CHANGE_HBR2PCM == enMode))
    {
        HI_VOID* pSndPcmOnlyOp;
        SND_OP_ATTR_S stPcmOnlyOpAttr;
        pSndPcmOnlyOp = SND_GetOpHandlebyOutType(pCard, SND_OUTPUT_TYPE_DAC);
        if (!pSndPcmOnlyOp)
        {
            pSndPcmOnlyOp = SND_GetOpHandlebyOutType(pCard, SND_OUTPUT_TYPE_I2S);
        }

        if (!pSndPcmOnlyOp)
        {
            Channels   = AO_TRACK_NORMAL_CHANNELNUM;
            Rate = HI_UNF_SAMPLE_RATE_48K;
        }
        else
        {
            s32Ret = SND_GetOpAttr(pCard, SND_GetOpOutputport(pSndPcmOnlyOp), &stPcmOnlyOpAttr);
            if (HI_SUCCESS != s32Ret)
            {
                HI_ERR_AO("SND_GetOpAttr Fail\n");
                return;
            }
            Channels = stPcmOnlyOpAttr.u32Channels;
            Rate = stPcmOnlyOpAttr.u32SampleRate;
        }
        enHdmiSoundIntf = HDMI_AUDIO_INTERFACE_I2S;
        enAudioFormat = HI_UNF_EDID_AUDIO_FORMAT_CODE_PCM;
    }
    else
    {
        return;
    }

    /*if the channels of the frame have changed , set the attribute of HDMI*/
    if (pCard->pstHdmiFunc && pCard->pstHdmiFunc->pfnHdmiGetAoAttr)
    {
        (pCard->pstHdmiFunc->pfnHdmiGetAoAttr)(HI_UNF_HDMI_ID_0, &stHDMIAttr);
    }

    stHDMIAttr.enSoundIntf  = enHdmiSoundIntf;
    stHDMIAttr.enSampleRate = (HI_UNF_SAMPLE_RATE_E)Rate;
    stHDMIAttr.u32Channels  = Channels;
    stHDMIAttr.enAudioCode  = enAudioFormat;
    HI_WARN_AO("HDMI Audio format ->  %d\n", enAudioFormat);
 
    /* set the attribute to HDMI driver */
    if (pCard->pstHdmiFunc && pCard->pstHdmiFunc->pfnHdmiAudioChange)
    {
        (pCard->pstHdmiFunc->pfnHdmiAudioChange)(HI_UNF_HDMI_ID_0, &stHDMIAttr);
    }
}

HI_VOID SndProcHdmifRoute(SND_CARD_STATE_S* pCard, SND_TRACK_STATE_S* pTrack, TRACK_STREAMMODE_CHANGE_E enMode,
                          SND_TRACK_STREAM_ATTR_S* pstAttr)
{
    HI_S32 s32Ret;
    AOE_AIP_CHN_ATTR_S stAipAttr;
    HI_VOID* pSndOp = HI_NULL;
    HI_UNF_SND_OUTPUTPORT_E eOutPort = HI_UNF_SND_OUTPUTPORT_BUTT;
    AOE_AOP_ID_E Aop;
    SND_OP_ATTR_S stOpAttr;
    AOE_ENGINE_CHN_ATTR_S stEngineAttr;
    SND_ENGINE_TYPE_E enEngineNew;
    SND_ENGINE_TYPE_E enEngineOld;
    SND_AIP_TYPE_E enAipOld;
    SND_AIP_TYPE_E enAipNew;
    HI_VOID* pEngineNew;
    HI_VOID* pEngineOld;
    SND_ENGINE_STATE_S* state;

    if (TRACK_STREAMMODE_CHANGE_NONE == enMode)
    {
        return;
    }

    //before resetting audio attr, proprocess hdmi audio output
    pSndOp = SND_GetOpHandlebyOutType(pCard, SND_OUTPUT_TYPE_HDMI);
    if (!pSndOp)
    {
        HI_ERR_AO("SND_GetOpHandlebyOutType Fail\n");
        return;        
    }
    
    eOutPort = SND_GetOpOutputport(pSndOp);
    Aop = SND_GetOpAopId(pSndOp);
    if ((TRACK_STREAMMODE_CHANGE_PCM2LBR == enMode) || (TRACK_STREAMMODE_CHANGE_LBR2LBR == enMode)
        || (TRACK_STREAMMODE_CHANGE_HBR2LBR == enMode))
    {
        //set op
        if (TRACK_STREAMMODE_CHANGE_PCM2LBR == enMode)
        {
            enEngineOld = SND_ENGINE_TYPE_PCM;
        }
        else
        {
            enEngineOld = SND_ENGINE_TYPE_HDMI_RAW;
        }

        enEngineNew = SND_ENGINE_TYPE_HDMI_RAW;
        enAipNew   = SND_AIP_TYPE_HDMI_RAW;
        pEngineOld = TrackGetEngineHandlebyType(pCard, enEngineOld);
        if (!pEngineOld)
        {            
            HI_ERR_AO("TrackGetEngineHandlebyType Fail\n");
            return;
        }
        
        pEngineNew = TrackGetEngineHandlebyType(pCard, enEngineNew);
        if (!pEngineNew)
        {            
            HI_ERR_AO("TrackGetEngineHandlebyType Fail\n");
            return;
        }
        
        s32Ret = SND_GetOpAttr(pCard, eOutPort, &stOpAttr);
        if (HI_SUCCESS != s32Ret)
        {
            HI_ERR_AO("SND_GetOpAttr Fail\n");
            return ;
        }

        SND_StopOp(pCard, eOutPort);
        state = (SND_ENGINE_STATE_S*)pEngineOld;
        HAL_AOE_ENGINE_DetachAop(state->enEngine, Aop);
        TranslateOpAttr(&stOpAttr, enMode, pstAttr);
        SND_SetOpAttr(pCard, eOutPort, &stOpAttr);
        Aop = SND_GetOpAopId(pSndOp);  //verify
        state = (SND_ENGINE_STATE_S*)pEngineNew; //verify
        HAL_AOE_ENGINE_Stop(state->enEngine);
        HAL_AOE_ENGINE_AttachAop(state->enEngine, Aop);
        SND_StartOp(pCard, eOutPort);

        //set aip
        HAL_AOE_AIP_GetAttr(pTrack->enAIP[enAipNew], &stAipAttr);
        stAipAttr.stBufInAttr.u32BufBitPerSample = pstAttr->u32LbrBitDepth;
        stAipAttr.stBufInAttr.u32BufSampleRate = pstAttr->u32LbrSampleRate;
        stAipAttr.stBufInAttr.u32BufChannels   = pstAttr->u32LbrChannels;
        stAipAttr.stBufInAttr.u32BufDataFormat = pstAttr->u32LbrFormat;

        stAipAttr.stFifoOutAttr.u32FifoBitPerSample = pstAttr->u32LbrBitDepth;
        stAipAttr.stFifoOutAttr.u32FifoSampleRate = pstAttr->u32LbrSampleRate;
        stAipAttr.stFifoOutAttr.u32FifoChannels   = pstAttr->u32LbrChannels;
        stAipAttr.stFifoOutAttr.u32FifoDataFormat = pstAttr->u32LbrFormat;
        HAL_AOE_AIP_SetAttr(pTrack->enAIP[enAipNew], &stAipAttr);
        HAL_AOE_ENGINE_AttachAip(state->enEngine, pTrack->enAIP[enAipNew]);

        pCard->u32HdmiDataFormat = pstAttr->u32LbrFormat;

        //set engine
        stEngineAttr.u32BitPerSample = pstAttr->u32LbrBitDepth;
        stEngineAttr.u32Channels   = pstAttr->u32LbrChannels;
        stEngineAttr.u32SampleRate = pstAttr->u32LbrSampleRate;
        stEngineAttr.u32DataFormat = pstAttr->u32LbrFormat;
        HAL_AOE_ENGINE_SetAttr(state->enEngine, &stEngineAttr);
        HAL_AOE_ENGINE_Start(state->enEngine);
    }
    else if ((TRACK_STREAMMODE_CHANGE_PCM2HBR == enMode) || (TRACK_STREAMMODE_CHANGE_LBR2HBR == enMode)
             || (TRACK_STREAMMODE_CHANGE_HBR2HBR == enMode))
    {
        //set op
        if (TRACK_STREAMMODE_CHANGE_PCM2HBR == enMode)
        {
            enEngineOld = SND_ENGINE_TYPE_PCM;
        }
        else
        {
            enEngineOld = SND_ENGINE_TYPE_HDMI_RAW;
        }

        enEngineNew = SND_ENGINE_TYPE_HDMI_RAW;
        enAipNew   = SND_AIP_TYPE_HDMI_RAW;
        pEngineOld = TrackGetEngineHandlebyType(pCard, enEngineOld);
        if (!pEngineOld)
        {            
            HI_ERR_AO("TrackGetEngineHandlebyType Fail\n");
            return;
        }
            
        pEngineNew = TrackGetEngineHandlebyType(pCard, enEngineNew);
        if (!pEngineNew)
        {            
            HI_ERR_AO("TrackGetEngineHandlebyType Fail\n");
            return;
        }
                
        s32Ret = SND_GetOpAttr(pCard, eOutPort, &stOpAttr);
        if (HI_SUCCESS != s32Ret)
        {
            HI_ERR_AO("SND_GetOpAttr Fail\n");
            return ;
        }

        SND_StopOp(pCard, eOutPort);
        state = (SND_ENGINE_STATE_S*)pEngineOld; //verify
        HAL_AOE_ENGINE_DetachAop(state->enEngine, Aop);
        TranslateOpAttr(&stOpAttr, enMode, pstAttr);
        SND_SetOpAttr(pCard, eOutPort, &stOpAttr);
        Aop = SND_GetOpAopId(pSndOp); //verify
        state = (SND_ENGINE_STATE_S*)pEngineNew; //verify
        HAL_AOE_ENGINE_Stop(state->enEngine);
        HAL_AOE_ENGINE_AttachAop(state->enEngine, Aop);
        SND_StartOp(pCard, eOutPort);

        //set aip
        HAL_AOE_AIP_GetAttr(pTrack->enAIP[enAipNew], &stAipAttr);
        stAipAttr.stBufInAttr.u32BufBitPerSample = pstAttr->u32HbrBitDepth;
        stAipAttr.stBufInAttr.u32BufSampleRate = pstAttr->u32HbrSampleRate;
        stAipAttr.stBufInAttr.u32BufChannels   = pstAttr->u32HbrChannels;
        stAipAttr.stBufInAttr.u32BufDataFormat = pstAttr->u32HbrFormat;

        stAipAttr.stFifoOutAttr.u32FifoBitPerSample = pstAttr->u32HbrBitDepth;
        stAipAttr.stFifoOutAttr.u32FifoSampleRate = pstAttr->u32HbrSampleRate;
        stAipAttr.stFifoOutAttr.u32FifoChannels   = pstAttr->u32HbrChannels;
        stAipAttr.stFifoOutAttr.u32FifoDataFormat = pstAttr->u32HbrFormat;
        HAL_AOE_AIP_SetAttr(pTrack->enAIP[enAipNew], &stAipAttr);
        HAL_AOE_ENGINE_AttachAip(state->enEngine, pTrack->enAIP[enAipNew]);

        pCard->u32HdmiDataFormat = pstAttr->u32HbrFormat;
        //set engine
        stEngineAttr.u32BitPerSample = pstAttr->u32HbrBitDepth;
        stEngineAttr.u32Channels   = pstAttr->u32HbrChannels;
        stEngineAttr.u32SampleRate = pstAttr->u32HbrSampleRate;
        stEngineAttr.u32DataFormat = pstAttr->u32HbrFormat;
        HAL_AOE_ENGINE_SetAttr(state->enEngine, &stEngineAttr);
        HAL_AOE_ENGINE_Start(state->enEngine);
    }
    else if ((TRACK_STREAMMODE_CHANGE_LBR2PCM == enMode) || (TRACK_STREAMMODE_CHANGE_HBR2PCM == enMode))
    {
        HI_VOID* pSndPcmOnlyOp;
        SND_OP_ATTR_S stPcmOnlyOpAttr;
        enEngineOld = SND_ENGINE_TYPE_HDMI_RAW;
        enEngineNew = SND_ENGINE_TYPE_PCM;
        enAipOld    = SND_AIP_TYPE_HDMI_RAW;
        pEngineOld = TrackGetEngineHandlebyType(pCard, enEngineOld);
        if (!pEngineOld)
        {            
            HI_ERR_AO("TrackGetEngineHandlebyType Fail\n");
            return;
        }
        
        pEngineNew = TrackGetEngineHandlebyType(pCard, enEngineNew);        
        if (!pEngineNew)
        {            
            HI_ERR_AO("TrackGetEngineHandlebyType Fail\n");
            return;
        }

        //set op
        s32Ret = SND_GetOpAttr(pCard, eOutPort, &stOpAttr);
        if (HI_SUCCESS != s32Ret)
        {
            HI_ERR_AO("SND_GetOpAttr Fail\n");
            return ;
        }

        SND_StopOp(pCard, eOutPort);
        state = (SND_ENGINE_STATE_S*)pEngineOld;  //verify
        HAL_AOE_ENGINE_DetachAop(state->enEngine, Aop);
        HAL_AOE_ENGINE_DetachAip(state->enEngine, pTrack->enAIP[enAipOld]);
        HAL_AOE_ENGINE_Stop(state->enEngine);

        // reset attr
        pSndPcmOnlyOp = SND_GetOpHandlebyOutType(pCard, SND_OUTPUT_TYPE_DAC);
        if (!pSndPcmOnlyOp)
        {
            pSndPcmOnlyOp = SND_GetOpHandlebyOutType(pCard, SND_OUTPUT_TYPE_I2S);
        }

        if (!pSndPcmOnlyOp)
        {
            TranslateOpAttr(&stOpAttr, enMode, pstAttr);
        }
        else
        {
            s32Ret = SND_GetOpAttr(pCard, SND_GetOpOutputport(pSndPcmOnlyOp), &stPcmOnlyOpAttr);  //verify
            if (HI_SUCCESS != s32Ret)
            {
                HI_ERR_AO("SND_GetOpAttr Fail\n");
                return ;
            }

            stOpAttr.u32BitPerSample = stPcmOnlyOpAttr.u32BitPerSample;
            stOpAttr.u32Channels   = stPcmOnlyOpAttr.u32Channels;
            stOpAttr.u32SampleRate = stPcmOnlyOpAttr.u32SampleRate;
            stOpAttr.u32PeriodBufSize = stPcmOnlyOpAttr.u32PeriodBufSize;
            stOpAttr.u32LatencyThdMs = stPcmOnlyOpAttr.u32LatencyThdMs;
            stOpAttr.u32DataFormat = 0;
        }

        SND_SetOpAttr(pCard, eOutPort, &stOpAttr);
        Aop = SND_GetOpAopId(pSndOp); //verify
        state = (SND_ENGINE_STATE_S*)pEngineNew; //verify
        HAL_AOE_ENGINE_AttachAop(state->enEngine, Aop);
        SND_StartOp(pCard, eOutPort);
        pCard->u32HdmiDataFormat = 0;
    }

    if ((TRACK_STREAMMODE_CHANGE_PCM2LBR == enMode) || (TRACK_STREAMMODE_CHANGE_LBR2LBR == enMode)
        || (TRACK_STREAMMODE_CHANGE_HBR2LBR == enMode))
    {
        pCard->enHdmiPassthrough = SND_HDMI_MODE_LBR;
    }
    else if ((TRACK_STREAMMODE_CHANGE_PCM2HBR == enMode) || (TRACK_STREAMMODE_CHANGE_LBR2HBR == enMode)
             || (TRACK_STREAMMODE_CHANGE_HBR2HBR == enMode))
    {
        pCard->enHdmiPassthrough = SND_HDMI_MODE_HBR;
    }
    else
    {
        pCard->enHdmiPassthrough = SND_HDMI_MODE_PCM;
    }
    HDMIAudioChange(pCard, enMode, pstAttr);

    memcpy(&pTrack->stStreamAttr, pstAttr, sizeof(SND_TRACK_STREAM_ATTR_S));
}

#ifdef HI_SOUND_SPDIF_COMPENSATION_SUPPORT
HI_VOID TrackStartSpdifDelaySetting(SND_CARD_STATE_S* pCard)
{
    HI_S32 s32Ret;
    HI_U32 u32SpdifDelayMs;

    s32Ret = SND_GetDelayCompensation(pCard, HI_UNF_SND_OUTPUTPORT_SPDIF0, &u32SpdifDelayMs);

    if (s32Ret == HI_SUCCESS)
    {
        s32Ret = SND_SetDelayCompensation(pCard, HI_UNF_SND_OUTPUTPORT_SPDIF0, u32SpdifDelayMs, HI_FALSE);

        if (HI_SUCCESS != s32Ret)
        {
            HI_ERR_AO("SetDelayCompensation delayms %d failed\n", u32SpdifDelayMs);
        }
    }
}

HI_S32 TrackPauseSpdifDelaySetting(SND_CARD_STATE_S* pCard)
{
    HI_S32 Ret;

    Ret = SND_SetDelayCompensation(pCard, HI_UNF_SND_OUTPUTPORT_SPDIF0, 0, HI_FALSE);

    if (HI_SUCCESS != Ret)
    {
        HI_ERR_AO("Pause Set delayms failed\n");
    }

    return Ret;
}

HI_VOID SpidfRouteDelaySetting(SND_CARD_STATE_S* pCard)
{
    HI_S32 s32Ret;
    HI_U32 u32SpdifDelayMs;
    HI_U32 u32SndDelayMs;

    s32Ret = SND_GetDelayCompensation(pCard, HI_UNF_SND_OUTPUTPORT_SPDIF0, &u32SpdifDelayMs);

    if (s32Ret == HI_SUCCESS)
    {
        if (pCard->enSpdifPassthrough == SND_SPDIF_MODE_PCM)
        {
            SND_GetDelayMs(pCard, &u32SndDelayMs);
            u32SpdifDelayMs += u32SndDelayMs;

            if (u32SpdifDelayMs > AO_MAX_DELAYMS + PERIOND_NUM * 10)
            {
                u32SpdifDelayMs = AO_MAX_DELAYMS + PERIOND_NUM * 10;
            }
        }

        s32Ret = SND_SetDelayCompensation(pCard, HI_UNF_SND_OUTPUTPORT_SPDIF0, u32SpdifDelayMs, HI_FALSE);

        if (HI_SUCCESS != s32Ret)
        {
            HI_ERR_AO("SetDelayCompensation delayms %d failed\n", u32SpdifDelayMs);
        }
    }
}
#endif

HI_VOID SndProcSpidfRoute(SND_CARD_STATE_S* pCard, SND_TRACK_STATE_S* pTrack, TRACK_STREAMMODE_CHANGE_E enMode,
                          SND_TRACK_STREAM_ATTR_S* pstAttr)
{
    HI_S32 s32Ret;
    AOE_AIP_CHN_ATTR_S stAipAttr;
    HI_VOID* pSndOp = HI_NULL;
    HI_UNF_SND_OUTPUTPORT_E eOutPort = HI_UNF_SND_OUTPUTPORT_BUTT;
    AOE_AOP_ID_E Aop;
    SND_OP_ATTR_S stOpAttr;
    AOE_ENGINE_CHN_ATTR_S stEngineAttr;
    SND_ENGINE_TYPE_E enEngineNew;
    SND_ENGINE_TYPE_E enEngineOld;
    SND_AIP_TYPE_E enAipOld;
    SND_AIP_TYPE_E enAipNew;
    HI_VOID* pEngineNew;
    HI_VOID* pEngineOld;
    SND_ENGINE_STATE_S* state;

    if (TRACK_STREAMMODE_CHANGE_NONE == enMode)
    {
        return;
    }

    pSndOp = SND_GetOpHandlebyOutType(pCard, SND_OUTPUT_TYPE_SPDIF);
    if (!pSndOp)
    {
        HI_ERR_AO("SND_GetOpHandlebyOutType Null\n");
        return;
    }
    
    eOutPort = SND_GetOpOutputport(pSndOp);
    Aop = SND_GetOpAopId(pSndOp);
    if ((TRACK_STREAMMODE_CHANGE_PCM2LBR == enMode) || (TRACK_STREAMMODE_CHANGE_LBR2LBR == enMode))
    {
        /* enable pass-through */

        //set op
        if (TRACK_STREAMMODE_CHANGE_PCM2LBR == enMode)
        {
            enEngineOld = SND_ENGINE_TYPE_PCM;
        }
        else
        {
            enEngineOld = SND_ENGINE_TYPE_SPDIF_RAW;
        }

        enEngineNew = SND_ENGINE_TYPE_SPDIF_RAW;
        enAipNew   = SND_AIP_TYPE_SPDIF_RAW;
        pEngineOld = TrackGetEngineHandlebyType(pCard, enEngineOld);
        if (!pEngineOld)
        {
            HI_ERR_AO("TrackGetEngineHandlebyType Fail\n");
            return;
        }            
        
        pEngineNew = TrackGetEngineHandlebyType(pCard, enEngineNew);
        if (!pEngineNew)
        {
            HI_ERR_AO("TrackGetEngineHandlebyType Fail\n");
            return;
        }

        s32Ret = SND_GetOpAttr(pCard, eOutPort, &stOpAttr);
        if (HI_SUCCESS != s32Ret)
        {
            HI_ERR_AO("SND_GetOpAttr Fail\n");
            return ;
        }

        SND_StopOp(pCard, eOutPort);
        state = (SND_ENGINE_STATE_S*)pEngineOld;
        HAL_AOE_ENGINE_DetachAop(state->enEngine, Aop);
        TranslateOpAttr(&stOpAttr, enMode, pstAttr);
        SND_SetOpAttr(pCard, eOutPort, &stOpAttr);
        state = (SND_ENGINE_STATE_S*)pEngineNew; //verify
        HAL_AOE_ENGINE_Stop(state->enEngine);
        HAL_AOE_ENGINE_AttachAop(state->enEngine, Aop);
        SND_StartOp(pCard, eOutPort);

        //set aip
        HAL_AOE_AIP_GetAttr(pTrack->enAIP[enAipNew], &stAipAttr);
        stAipAttr.stBufInAttr.u32BufBitPerSample = pstAttr->u32LbrBitDepth;
        stAipAttr.stBufInAttr.u32BufSampleRate = pstAttr->u32LbrSampleRate;
        stAipAttr.stBufInAttr.u32BufChannels   = pstAttr->u32LbrChannels;
        stAipAttr.stBufInAttr.u32BufDataFormat = pstAttr->u32LbrFormat;

        stAipAttr.stFifoOutAttr.u32FifoBitPerSample = pstAttr->u32LbrBitDepth;
        stAipAttr.stFifoOutAttr.u32FifoSampleRate = pstAttr->u32LbrSampleRate;
        stAipAttr.stFifoOutAttr.u32FifoChannels   = pstAttr->u32LbrChannels;
        stAipAttr.stFifoOutAttr.u32FifoDataFormat = pstAttr->u32LbrFormat;
        HAL_AOE_AIP_SetAttr(pTrack->enAIP[enAipNew], &stAipAttr);
        HAL_AOE_ENGINE_AttachAip(state->enEngine, pTrack->enAIP[enAipNew]);

        pCard->u32SpdifDataFormat = pstAttr->u32LbrFormat;

        //set engine
        stEngineAttr.u32BitPerSample = pstAttr->u32LbrBitDepth;
        stEngineAttr.u32Channels   = pstAttr->u32LbrChannels;
        stEngineAttr.u32SampleRate = pstAttr->u32LbrSampleRate;
        stEngineAttr.u32DataFormat = pstAttr->u32LbrFormat;
        HAL_AOE_ENGINE_SetAttr(state->enEngine, &stEngineAttr);
        HAL_AOE_ENGINE_Start(state->enEngine);
    }
    else if (TRACK_STREAMMODE_CHANGE_LBR2PCM == enMode)
    {
        /* disable pass-through */
        HI_VOID* pSndPcmOnlyOp;
        SND_OP_ATTR_S stPcmOnlyOpAttr;
        enEngineOld = SND_ENGINE_TYPE_SPDIF_RAW;
        enEngineNew = SND_ENGINE_TYPE_PCM;
        enAipOld   = SND_AIP_TYPE_SPDIF_RAW;
        
        pEngineOld = TrackGetEngineHandlebyType(pCard, enEngineOld);
        if (!pEngineOld)
        {
            HI_ERR_AO("TrackGetEngineHandlebyType Fail\n");
            return;
        }
        
        pEngineNew = TrackGetEngineHandlebyType(pCard, enEngineNew);
        if (!pEngineNew)
        {
            HI_ERR_AO("TrackGetEngineHandlebyType Fail\n");
            return;
        }

        //set op
        s32Ret = SND_GetOpAttr(pCard, eOutPort, &stOpAttr);
        if (HI_SUCCESS != s32Ret)
        {
            HI_ERR_AO("SND_GetOpAttr Fail\n");
            return ;
        }

        SND_StopOp(pCard, eOutPort);
        state = (SND_ENGINE_STATE_S*)pEngineOld;
        HAL_AOE_ENGINE_DetachAop(state->enEngine, Aop);
        HAL_AOE_ENGINE_DetachAip(state->enEngine, pTrack->enAIP[enAipOld]);
        HAL_AOE_ENGINE_Stop(state->enEngine);

        // reset attr
        pSndPcmOnlyOp = SND_GetOpHandlebyOutType(pCard, SND_OUTPUT_TYPE_DAC);
        if (!pSndPcmOnlyOp)
        {
            pSndPcmOnlyOp = SND_GetOpHandlebyOutType(pCard, SND_OUTPUT_TYPE_I2S);
        }

        if (!pSndPcmOnlyOp)
        {
            TranslateOpAttr(&stOpAttr, enMode, pstAttr);
        }
        else
        {
            s32Ret = SND_GetOpAttr(pCard, SND_GetOpOutputport(pSndPcmOnlyOp), &stPcmOnlyOpAttr);
            if (HI_SUCCESS != s32Ret)
            {
                HI_ERR_AO("SND_GetOpAttr Fail\n");
                return ;
            }

            stOpAttr.u32BitPerSample = stPcmOnlyOpAttr.u32BitPerSample;
            stOpAttr.u32Channels   = stPcmOnlyOpAttr.u32Channels;
            stOpAttr.u32SampleRate = stPcmOnlyOpAttr.u32SampleRate;
            stOpAttr.u32PeriodBufSize = stPcmOnlyOpAttr.u32PeriodBufSize;
            stOpAttr.u32LatencyThdMs = stPcmOnlyOpAttr.u32LatencyThdMs;
            stOpAttr.u32DataFormat = 0;
        }

        SND_SetOpAttr(pCard, eOutPort, &stOpAttr);
        state = (SND_ENGINE_STATE_S*)pEngineNew; //verify
        HAL_AOE_ENGINE_AttachAop(state->enEngine, Aop);
        SND_StartOp(pCard, eOutPort);

        pCard->u32SpdifDataFormat = 0;
    }

    if ((TRACK_STREAMMODE_CHANGE_PCM2LBR == enMode) || (TRACK_STREAMMODE_CHANGE_LBR2LBR == enMode))
    {
        pCard->enSpdifPassthrough = SND_SPDIF_MODE_LBR; 
    }
    else
    {
        pCard->enSpdifPassthrough = SND_SPDIF_MODE_PCM;
    }

    memcpy(&pTrack->stStreamAttr, pstAttr, sizeof(SND_TRACK_STREAM_ATTR_S));
#ifdef HI_SOUND_SPDIF_COMPENSATION_SUPPORT
    SpidfRouteDelaySetting(pCard);
#endif
    return;
}

//zgjiere; u32BufLevelMs需要细心检查异常情况，避免堵塞，u32BufLevelMs异常时，认为无流控
HI_BOOL TrackisBufFree(SND_CARD_STATE_S* pCard, SND_TRACK_STATE_S* pTrack, SND_TRACK_STREAM_ATTR_S* pstStreamAttr)
{
    HI_U32 Free = 0;
    HI_U32 DelayMs = 0;
    HI_U32 FrameSize = 0;
    HI_U32 FrameMs = 0;
    HI_U32 PcmFrameBytes = 0;
    HI_U32 SpdifRawBytes = 0;
    HI_U32 HdmiRawBytes = 0;

    if (HI_TRUE == TrackCheckIsPcmOutput(pCard))
    {
        //dmx
        PcmFrameBytes = pstStreamAttr->u32PcmBytesPerFrame;        
        Free = HAL_AOE_AIP_QueryBufFree(pTrack->enAIP[SND_AIP_TYPE_PCM]);
        if (Free <= PcmFrameBytes)
        {
            return HI_FALSE;
        }
        HAL_AOE_AIP_GetBufDelayMs(pTrack->enAIP[SND_AIP_TYPE_PCM], &DelayMs);
        FrameSize = AUTIL_CalcFrameSize(pstStreamAttr->u32PcmChannels, pstStreamAttr->u32PcmBitDepth);
        FrameMs = AUTIL_ByteSize2LatencyMs(PcmFrameBytes, FrameSize, pstStreamAttr->u32PcmSampleRate);
        if (DelayMs + FrameMs >= pTrack->stUserTrackAttr.u32BufLevelMs)
        {
            return HI_FALSE;
        }

        if (HI_UNF_SND_TRACK_TYPE_MASTER == pTrack->stUserTrackAttr.enTrackType)
        {
#ifdef DRV_SND_MULTICH_AEF_SUPPORT
            //mc
            PcmFrameBytes = pstStreamAttr->u32McPcmBytesPerFrame;   
            Free = HAL_AOE_AIP_QueryBufFree(pTrack->enAIP[SND_AIP_TYPE_MC_PCM]);
            if (Free <= PcmFrameBytes)
            {
                return HI_FALSE;
            }
            HAL_AOE_AIP_GetBufDelayMs(pTrack->enAIP[SND_AIP_TYPE_MC_PCM], &DelayMs);
            FrameSize = AUTIL_CalcFrameSize(pstStreamAttr->u32McPcmChannels, pstStreamAttr->u32McPcmBitDepth);
            FrameMs = AUTIL_ByteSize2LatencyMs(PcmFrameBytes, FrameSize, pstStreamAttr->u32McPcmSampleRate);
            if (DelayMs + FrameMs >= pTrack->stUserTrackAttr.u32BufLevelMs)
            {
                return HI_FALSE;
            }
#endif

#ifdef DRV_SND_AD_OUTPUT_SUPPORT
            //assoc
            PcmFrameBytes = pstStreamAttr->u32PcmBytesPerFrame;        
            Free = HAL_AOE_AIP_QueryBufFree(pTrack->enAIP[SND_AIP_TYPE_ASSOC_PCM]);
            if (Free <= PcmFrameBytes)
            {
                return HI_FALSE;
            }
            HAL_AOE_AIP_GetBufDelayMs(pTrack->enAIP[SND_AIP_TYPE_ASSOC_PCM], &DelayMs);
            FrameSize = AUTIL_CalcFrameSize(pstStreamAttr->u32AssocPcmChannels, pstStreamAttr->u32AssocPcmBitDepth);
            FrameMs = AUTIL_ByteSize2LatencyMs(PcmFrameBytes, FrameSize, pstStreamAttr->u32AssocPcmSampleRate);
            if (DelayMs + FrameMs >= pTrack->stUserTrackAttr.u32BufLevelMs)
            {
                return HI_FALSE;
            }  
#endif
        }
    }

    if (HI_UNF_SND_TRACK_TYPE_MASTER == pTrack->stUserTrackAttr.enTrackType)
    {
        if (SND_SPDIF_MODE_LBR == pCard->enSpdifPassthrough)
        {
            SpdifRawBytes = pstStreamAttr->u32LbrBytesPerFrame;
            Free = HAL_AOE_AIP_QueryBufFree(pTrack->enAIP[SND_AIP_TYPE_SPDIF_RAW]);
            if (Free <= SpdifRawBytes)
            {
                return HI_FALSE;
            }

            HAL_AOE_AIP_GetBufDelayMs(pTrack->enAIP[SND_AIP_TYPE_SPDIF_RAW], &DelayMs);  //verify pcm controled , passthrough need control
            FrameSize = AUTIL_CalcFrameSize(pstStreamAttr->u32LbrChannels, pstStreamAttr->u32LbrBitDepth);
            FrameMs = AUTIL_ByteSize2LatencyMs(SpdifRawBytes, FrameSize, pstStreamAttr->u32LbrSampleRate);
            if (DelayMs + FrameMs >= pTrack->stUserTrackAttr.u32BufLevelMs)
            {
                return HI_FALSE;
            }
        }
        else if(SND_SPDIF_MODE_HBR == pCard->enSpdifPassthrough)
        {
            SpdifRawBytes = pstStreamAttr->u32HbrBytesPerFrame;
            Free = HAL_AOE_AIP_QueryBufFree(pTrack->enAIP[SND_AIP_TYPE_SPDIF_RAW]);
            if (Free <= SpdifRawBytes)
            {
                return HI_FALSE;
            }

            HAL_AOE_AIP_GetBufDelayMs(pTrack->enAIP[SND_AIP_TYPE_SPDIF_RAW], &DelayMs);  //verify pcm controled , passthrough need control
            FrameSize = AUTIL_CalcFrameSize(pstStreamAttr->u32HbrChannels, pstStreamAttr->u32HbrBitDepth);
            FrameMs = AUTIL_ByteSize2LatencyMs(SpdifRawBytes, FrameSize, pstStreamAttr->u32HbrSampleRate);
            if (DelayMs + FrameMs >= pTrack->stUserTrackAttr.u32BufLevelMs)
            {
                return HI_FALSE;
            }
        }

        if (SND_HDMI_MODE_LBR == pCard->enHdmiPassthrough)
        {
            HdmiRawBytes = pstStreamAttr->u32LbrBytesPerFrame;
            Free = HAL_AOE_AIP_QueryBufFree(pTrack->enAIP[SND_AIP_TYPE_HDMI_RAW]);
            if (Free <= HdmiRawBytes)
            {
                return HI_FALSE;
            }

            HAL_AOE_AIP_GetBufDelayMs(pTrack->enAIP[SND_AIP_TYPE_HDMI_RAW], &DelayMs);
            FrameSize = AUTIL_CalcFrameSize(pstStreamAttr->u32LbrChannels, pstStreamAttr->u32LbrBitDepth);
            FrameMs = AUTIL_ByteSize2LatencyMs(HdmiRawBytes, FrameSize, pstStreamAttr->u32LbrSampleRate);
            if (DelayMs + FrameMs >= pTrack->stUserTrackAttr.u32BufLevelMs)
            {
                return HI_FALSE;
            }
        }
        else if (SND_HDMI_MODE_HBR == pCard->enHdmiPassthrough)

        {
            HdmiRawBytes = pstStreamAttr->u32HbrBytesPerFrame;
            Free = HAL_AOE_AIP_QueryBufFree(pTrack->enAIP[SND_AIP_TYPE_HDMI_RAW]);
            if (Free <= HdmiRawBytes)
            {
                return HI_FALSE;
            }

            HAL_AOE_AIP_GetBufDelayMs(pTrack->enAIP[SND_AIP_TYPE_HDMI_RAW], &DelayMs);
            FrameSize = AUTIL_CalcFrameSize(pstStreamAttr->u32HbrChannels, pstStreamAttr->u32HbrBitDepth);
            FrameMs = AUTIL_ByteSize2LatencyMs(HdmiRawBytes, FrameSize, pstStreamAttr->u32HbrSampleRate);
            if (DelayMs + FrameMs >= pTrack->stUserTrackAttr.u32BufLevelMs)
            {
                return HI_FALSE;
            }
        }
    }

    return HI_TRUE;
}

static HI_S32 TRACKStartAipReal(SND_CARD_STATE_S* pCard, SND_TRACK_STATE_S* pTrack)
{
    HI_S32 s32Ret = HI_SUCCESS;
    s32Ret = HAL_AOE_AIP_Start(pTrack->enAIP[SND_AIP_TYPE_PCM]);
    if (HI_SUCCESS != s32Ret)
    {
        HI_WARN_AO("AIP Start PCM Error\n");
    }
    if (HI_UNF_SND_TRACK_TYPE_MASTER == pTrack->stUserTrackAttr.enTrackType)
    {
#ifdef DRV_SND_MULTICH_AEF_SUPPORT
        if (HI_TRUE == pCard->enPcmMcStart)
        {
            s32Ret = HAL_AOE_AIP_Start(pTrack->enAIP[SND_AIP_TYPE_MC_PCM]);
            if (HI_SUCCESS != s32Ret)
            {
                HI_WARN_AO("AIP Start MC PCM Error\n");
            }
        }
#endif
#ifdef DRV_SND_AD_OUTPUT_SUPPORT
        if (HI_TRUE == pCard->enPcmAssocStart)
        {
            s32Ret = HAL_AOE_AIP_Start(pTrack->enAIP[SND_AIP_TYPE_ASSOC_PCM]);
            if (HI_SUCCESS != s32Ret)
            {
                HI_WARN_AO("AIP Start ASSOC PCM Error\n");
            }
        }
#endif
        if (SND_SPDIF_MODE_NONE != pCard->enSpdifPassthrough)
        {
            s32Ret = HAL_AOE_AIP_Start(pTrack->enAIP[SND_AIP_TYPE_SPDIF_RAW]);
            if (HI_SUCCESS != s32Ret)
            {
                HI_WARN_AO("AIP Start SPDIF RAW Error\n");
            }
        }
        if (SND_HDMI_MODE_NONE != pCard->enHdmiPassthrough)
        {
            s32Ret = HAL_AOE_AIP_Start(pTrack->enAIP[SND_AIP_TYPE_HDMI_RAW]);
            if (HI_SUCCESS != s32Ret)
            {
                HI_WARN_AO("AIP Start HDMI RAW Error\n");
            }
        }
    }

    return s32Ret;
}

HI_S32 TRACKStartAip(SND_CARD_STATE_S* pCard, SND_TRACK_STATE_S* pTrack)
{
    HI_U32 u32DelayMs = 0;
    HI_S32 s32Ret = HI_SUCCESS;

    if (HI_TRUE == TrackCheckIsPcmOutput(pCard))
    {
        HAL_AOE_AIP_GetBufDelayMs(pTrack->enAIP[SND_AIP_TYPE_PCM], &u32DelayMs);
    }
    else if(SND_SPDIF_MODE_LBR == pCard->enSpdifPassthrough || SND_SPDIF_MODE_HBR == pCard->enSpdifPassthrough)
    {
        HAL_AOE_AIP_GetBufDelayMs(pTrack->enAIP[SND_AIP_TYPE_SPDIF_RAW], &u32DelayMs);
    }
    else if (SND_HDMI_MODE_LBR == pCard->enHdmiPassthrough || SND_HDMI_MODE_HBR == pCard->enHdmiPassthrough)
    {
        HAL_AOE_AIP_GetBufDelayMs(pTrack->enAIP[SND_AIP_TYPE_HDMI_RAW], &u32DelayMs);
    }

    if (SND_TRACK_STATUS_START == pTrack->enCurnStatus)
    {
        if ((HI_UNF_SND_TRACK_TYPE_MASTER == pTrack->stUserTrackAttr.enTrackType && u32DelayMs >= pTrack->stUserTrackAttr.u32StartThresholdMs) //for master, 50ms start
            || (HI_UNF_SND_TRACK_TYPE_LOWLATENCY == pTrack->stUserTrackAttr.enTrackType) //for slave, immediately start
            || (HI_UNF_SND_TRACK_TYPE_SLAVE == pTrack->stUserTrackAttr.enTrackType) //for slave, immediately start
            || (HI_TRUE == pTrack->bEosFlag)    //if set eosflag, immediately start
            || (HI_TRUE == pTrack->bAlsaTrack)  //alsa track, immediately start
#ifdef HI_AUDIO_AI_SUPPORT
            || (HI_TRUE == pTrack->bAttAi)    //if track attaches ai, immediately start
#endif
           )
        {
            s32Ret = TRACKStartAipReal(pCard, pTrack);
            HDMISetAudioUnMute(pCard);
        }
    }

    return s32Ret;
}

HI_VOID TRACKPcmUnifyProcess(SND_CARD_STATE_S* pCard, SND_TRACK_STATE_S* pTrack, SND_TRACK_STREAM_ATTR_S* pstStreamAttr)
{
    // todo
    // step 1 , note Interleaved to Interleaved

    // step 2,  7.1+2.0 PCM
}

#if (1 == HI_PROC_SUPPORT)
static HI_VOID TRACKSavePcmData(SND_TRACK_STATE_S* pTrack, SND_TRACK_STREAM_ATTR_S* pstStreamAttr)
{
    HI_S32 s32Len;
    if(SND_DEBUG_CMD_CTRL_START == pTrack->enSaveState)
    {
        if (pstStreamAttr->pPcmDataBuf)
        {
            if (16 == pstStreamAttr->u32PcmBitDepth)
            {
                if (pTrack->fileHandle)
                {
                    HI_U32 u32FrameSize = AUTIL_CalcFrameSize(pstStreamAttr->u32PcmChannels, pstStreamAttr->u32PcmBitDepth);;
                    s32Len = HI_DRV_FILE_Write(pTrack->fileHandle, pstStreamAttr->pPcmDataBuf, pstStreamAttr->u32PcmSamplesPerFrame * u32FrameSize);
                    //pTrack->fileHandle->f_op->write(pTrack->fileHandle, pstStreamAttr->pPcmDataBuf, pstStreamAttr->u32PcmSamplesPerFrame * u32FrameSize, &pTrack->fileHandle->f_pos);
                    if (s32Len != pstStreamAttr->u32PcmSamplesPerFrame * u32FrameSize)
                    {
                        HI_ERR_AO("HI_DRV_FILE_Write failed!\n");
                        pTrack->enSaveState = SND_DEBUG_CMD_CTRL_STOP;
                        HI_DRV_FILE_Close(pTrack->fileHandle);
                        pTrack->fileHandle = HI_NULL;
                    }
                }
            }
            else if (24 == pstStreamAttr->u32PcmBitDepth)
            {
                HI_U32 i;
                HI_U32 u32TotalSample = pstStreamAttr->u32PcmSamplesPerFrame * pstStreamAttr->u32PcmChannels;
                HI_VOID* ps8Src = pstStreamAttr->pPcmDataBuf;
                for (i = 0; i < u32TotalSample; i++)
                {
                    if (pTrack->fileHandle)
                    {
                        s32Len = HI_DRV_FILE_Write(pTrack->fileHandle, ps8Src + i * 4 + 1, 3);
                        if (s32Len != 3)
                        {
                            HI_ERR_AO("HI_DRV_FILE_Write failed!\n");
                            pTrack->enSaveState = SND_DEBUG_CMD_CTRL_STOP;
                            HI_DRV_FILE_Close(pTrack->fileHandle);
                            pTrack->fileHandle = HI_NULL;
                        }
                    }
                }
            }
        }
    }

    return;
}
#endif

static HI_VOID TRACKWriteFrame(SND_CARD_STATE_S* pCard, SND_TRACK_STATE_S* pTrack, SND_TRACK_STREAM_ATTR_S* pstStreamAttr)
{
    HI_U32 Write = 0;
    HI_U32 PcmFrameBytes = 0;
    HI_U32 SpdifRawBytes = 0;
    HI_U32 HdmiRawBytes = 0;

#if (1 == HI_PROC_SUPPORT)
    TRACKSavePcmData(pTrack, pstStreamAttr);
#endif

    TRACKPcmUnifyProcess(pCard, pTrack, pstStreamAttr);
    if (HI_TRUE == TrackCheckIsPcmOutput(pCard))
    {
        PcmFrameBytes = pstStreamAttr->u32PcmBytesPerFrame;
        Write = HAL_AOE_AIP_WriteBufData(pTrack->enAIP[SND_AIP_TYPE_PCM], (HI_U8*)pstStreamAttr->pPcmDataBuf,
                                         PcmFrameBytes);
        if (Write != PcmFrameBytes)
        {
            HI_ERR_AO("HAL_AOE_AIP_WriteBufData fail write(%d) actual(%d)\n", PcmFrameBytes, Write);
        }
    }

    if (HI_UNF_SND_TRACK_TYPE_MASTER == pTrack->stUserTrackAttr.enTrackType)
    {
#ifdef DRV_SND_MULTICH_AEF_SUPPORT
        if (HI_TRUE == pCard->enPcmMcStart)
        {        
            PcmFrameBytes = pstStreamAttr->u32McPcmBytesPerFrame;
            Write = HAL_AOE_AIP_WriteBufData(pTrack->enAIP[SND_AIP_TYPE_MC_PCM], (HI_U8*)pstStreamAttr->pMcPcmDataBuf,
                                             PcmFrameBytes);
            if (Write != PcmFrameBytes)
            {
                HI_ERR_AO("HAL_AOE_AIP_WriteBufData fail write(%d) actual(%d)\n", PcmFrameBytes, Write);
            }
        }
#endif

#ifdef DRV_SND_AD_OUTPUT_SUPPORT
        if (HI_TRUE == pCard->enPcmAssocStart)
        {
            PcmFrameBytes = pstStreamAttr->u32PcmBytesPerFrame;
            Write = HAL_AOE_AIP_WriteBufData(pTrack->enAIP[SND_AIP_TYPE_ASSOC_PCM], (HI_U8*)pstStreamAttr->pAssocPcmDataBuf,
                                             PcmFrameBytes);
            if (Write != PcmFrameBytes)
            {
                HI_ERR_AO("HAL_AOE_AIP_WriteBufData fail write(%d) actual(%d)\n", PcmFrameBytes, Write);
            }
        }
#endif
        if (SND_SPDIF_MODE_LBR == pCard->enSpdifPassthrough)
        {
            SpdifRawBytes = pstStreamAttr->u32LbrBytesPerFrame;
            Write = HAL_AOE_AIP_WriteBufData(pTrack->enAIP[SND_AIP_TYPE_SPDIF_RAW],
                                             (HI_U8*)pstStreamAttr->pLbrDataBuf, SpdifRawBytes);
            if (Write != SpdifRawBytes)
            {
                HI_ERR_AO("HAL_AOE_AIP_WriteBufData fail write(%d) actual(%d)\n", SpdifRawBytes, Write);
            }
        }
        else if (SND_SPDIF_MODE_HBR == pCard->enSpdifPassthrough)
        {
            SpdifRawBytes = pstStreamAttr->u32HbrBytesPerFrame;
            Write = HAL_AOE_AIP_WriteBufData(pTrack->enAIP[SND_AIP_TYPE_SPDIF_RAW],
                                             (HI_U8 *)pstStreamAttr->pHbrDataBuf, SpdifRawBytes);
            if (Write != SpdifRawBytes)
            {
                HI_ERR_AO("HAL_AOE_AIP_WriteBufData fail write(%d) actual(%d)\n", SpdifRawBytes, Write);
            }
        }

        if (SND_HDMI_MODE_LBR == pCard->enHdmiPassthrough)
        {
            HdmiRawBytes = pstStreamAttr->u32LbrBytesPerFrame;
            Write = HAL_AOE_AIP_WriteBufData(pTrack->enAIP[SND_AIP_TYPE_HDMI_RAW],
                                             (HI_U8*)pstStreamAttr->pLbrDataBuf, HdmiRawBytes);
            if (Write != HdmiRawBytes)
            {
                HI_ERR_AO("HAL_AOE_AIP_WriteBufData fail write(%d) actual(%d)\n", HdmiRawBytes, Write);
            }
        }
        else if (SND_HDMI_MODE_HBR == pCard->enHdmiPassthrough)
        {
            HdmiRawBytes = pstStreamAttr->u32HbrBytesPerFrame;
            Write = HAL_AOE_AIP_WriteBufData(pTrack->enAIP[SND_AIP_TYPE_HDMI_RAW],
                                             (HI_U8*)pstStreamAttr->pHbrDataBuf, HdmiRawBytes);
            if (Write != HdmiRawBytes)
            {
                HI_ERR_AO("HAL_AOE_AIP_WriteBufData(%d) fail\n", HdmiRawBytes);
            }
        }
    }

    return;
}

static HI_VOID TRACKWriteMuteFrame(SND_CARD_STATE_S* pCard, SND_TRACK_STATE_S* pTrack, SND_TRACK_STREAM_ATTR_S* pstStreamAttr)
{
    HI_U32 SpdifRawFree = 0, HdmiRawFree = 0;
    HI_U32 SpdifRawBusy = 0, HdmiRawBusy = 0;
    HI_U32 SpdifRawData = 0, HdmiRawData = 0;
    HI_U32 PcmDelayMs = 0, SpdifDelayMs = 0, HdmiDelayMs = 0;
    HI_U32 FrameSize = 0;
    
    HI_U16 stData[2];

    if (HI_UNF_SND_TRACK_TYPE_MASTER != pTrack->stUserTrackAttr.enTrackType)
    {
        return;
    }

    if (SND_SPDIF_MODE_PCM >= pCard->enSpdifPassthrough && SND_HDMI_MODE_PCM >= pCard->enHdmiPassthrough)
    {
        return;
    }

    SpdifRawBusy = HAL_AOE_AIP_QueryBufData(pTrack->enAIP[SND_AIP_TYPE_SPDIF_RAW]);
    HdmiRawBusy = HAL_AOE_AIP_QueryBufData(pTrack->enAIP[SND_AIP_TYPE_HDMI_RAW]);

    //When the data of raw AIP less than two frame, send mute frame
    if ((SND_SPDIF_MODE_LBR == pCard->enSpdifPassthrough && SpdifRawBusy < 2 * pstStreamAttr->u32LbrBytesPerFrame)
        || (SND_SPDIF_MODE_HBR == pCard->enSpdifPassthrough && SpdifRawBusy < 2 * pstStreamAttr->u32HbrBytesPerFrame) 
        || (SND_HDMI_MODE_LBR == pCard->enHdmiPassthrough && HdmiRawBusy < 2 * pstStreamAttr->u32LbrBytesPerFrame)
        || (SND_HDMI_MODE_HBR == pCard->enHdmiPassthrough && HdmiRawBusy < 2 * pstStreamAttr->u32HbrBytesPerFrame))
    {
        if (HI_TRUE == TrackCheckIsPcmOutput(pCard))
        {
            HAL_AOE_AIP_GetBufDelayMs(pTrack->enAIP[SND_AIP_TYPE_PCM], &PcmDelayMs);
            if (SND_SPDIF_MODE_LBR == pCard->enSpdifPassthrough)
            {
                HAL_AOE_AIP_GetBufDelayMs(pTrack->enAIP[SND_AIP_TYPE_SPDIF_RAW], &SpdifDelayMs);
                if (PcmDelayMs > SpdifDelayMs)
                {
                    FrameSize = AUTIL_CalcFrameSize(pstStreamAttr->u32LbrChannels, pstStreamAttr->u32LbrBitDepth);
                    SpdifRawData = AUTIL_LatencyMs2ByteSize(PcmDelayMs - SpdifDelayMs, FrameSize, pstStreamAttr->u32LbrSampleRate); //mute frame size is difference value between delayms
                    if (SpdifRawData < pstStreamAttr->u32LbrBytesPerFrame)
                    {
                        SpdifRawData = pstStreamAttr->u32LbrBytesPerFrame;   //if  it is less than a frame, send a frame
                    }
                    SpdifRawFree = HAL_AOE_AIP_QueryBufFree(pTrack->enAIP[SND_AIP_TYPE_SPDIF_RAW]);
                    if (SpdifRawData > SpdifRawFree)
                    {
                        return;
                    }
                }
            }
            else if (SND_SPDIF_MODE_HBR == pCard->enSpdifPassthrough) 
            {
                HAL_AOE_AIP_GetBufDelayMs(pTrack->enAIP[SND_AIP_TYPE_SPDIF_RAW], &SpdifDelayMs);
                if(PcmDelayMs > SpdifDelayMs)
                {
                    FrameSize = AUTIL_CalcFrameSize(pstStreamAttr->u32HbrChannels, pstStreamAttr->u32HbrBitDepth);
                    SpdifRawData = AUTIL_LatencyMs2ByteSize(PcmDelayMs - SpdifDelayMs, FrameSize, pstStreamAttr->u32HbrSampleRate); //mute frame size is difference value between delayms
                    if(SpdifRawData < pstStreamAttr->u32HbrBytesPerFrame)  
                    {
                        SpdifRawData = pstStreamAttr->u32HbrBytesPerFrame;   //if  it is less than a frame, send a frame
                    }
                    SpdifRawFree = HAL_AOE_AIP_QueryBufFree(pTrack->enAIP[SND_AIP_TYPE_SPDIF_RAW]);
                    if(SpdifRawData > SpdifRawFree)
                    {
                        return;
                    }
                }         
            }
            if (SND_HDMI_MODE_LBR == pCard->enHdmiPassthrough)
            {
                HAL_AOE_AIP_GetBufDelayMs(pTrack->enAIP[SND_AIP_TYPE_HDMI_RAW], &HdmiDelayMs);
                if (PcmDelayMs > HdmiDelayMs)
                {
                    FrameSize = AUTIL_CalcFrameSize(pstStreamAttr->u32LbrChannels, pstStreamAttr->u32LbrBitDepth);
                    HdmiRawData = AUTIL_LatencyMs2ByteSize(PcmDelayMs - HdmiDelayMs, FrameSize, pstStreamAttr->u32LbrSampleRate);
                    if (HdmiRawData < pstStreamAttr->u32LbrBytesPerFrame)
                    {
                        HdmiRawData = pstStreamAttr->u32LbrBytesPerFrame;
                    }
                    HdmiRawFree = HAL_AOE_AIP_QueryBufFree(pTrack->enAIP[SND_AIP_TYPE_HDMI_RAW]);
                    if (HdmiRawData > HdmiRawFree)
                    {
                        return;
                    }
                }
            }
            else if (SND_HDMI_MODE_HBR == pCard->enHdmiPassthrough)
            {
                HAL_AOE_AIP_GetBufDelayMs(pTrack->enAIP[SND_AIP_TYPE_HDMI_RAW], &HdmiDelayMs);
                if (PcmDelayMs > HdmiDelayMs)
                {
                    FrameSize = AUTIL_CalcFrameSize(pstStreamAttr->u32HbrChannels, pstStreamAttr->u32HbrBitDepth);
                    HdmiRawData = AUTIL_LatencyMs2ByteSize(PcmDelayMs - HdmiDelayMs, FrameSize, pstStreamAttr->u32HbrSampleRate);
                    if (HdmiRawData < pstStreamAttr->u32HbrBytesPerFrame)
                    {
                        HdmiRawData = pstStreamAttr->u32HbrBytesPerFrame;
                    }
                    HdmiRawFree = HAL_AOE_AIP_QueryBufFree(pTrack->enAIP[SND_AIP_TYPE_HDMI_RAW]);
                    if (HdmiRawData > HdmiRawFree)
                    {
                        return;
                    }
                }
            }
        }
        else
        {
            if (SND_SPDIF_MODE_LBR == pCard->enSpdifPassthrough)
            {
                SpdifRawData = 2 * pstStreamAttr->u32LbrBytesPerFrame;
            }
            else if (SND_SPDIF_MODE_HBR == pCard->enSpdifPassthrough) 
            {
                SpdifRawData = 2 * pstStreamAttr->u32HbrBytesPerFrame;   
            }
            
            if (SND_HDMI_MODE_LBR == pCard->enHdmiPassthrough)
            {
                HdmiRawData = 2 * pstStreamAttr->u32LbrBytesPerFrame;
            }
            else if (SND_HDMI_MODE_HBR == pCard->enHdmiPassthrough)
            {
                HdmiRawData = 2 * pstStreamAttr->u32HbrBytesPerFrame;
            }
        }

        if (SND_SPDIF_MODE_LBR == pCard->enSpdifPassthrough ||
            SND_SPDIF_MODE_HBR == pCard->enSpdifPassthrough)
        {
            if ((pstStreamAttr->u32LbrFormat & 0xff00) || (pstStreamAttr->u32HbrFormat & 0xff00))
            {
                stData[0] = 0xffff;
                stData[1] = SpdifRawData;
                HAL_AOE_AIP_WriteBufData(pTrack->enAIP[SND_AIP_TYPE_SPDIF_RAW], (HI_U8*)stData, sizeof(stData));
            }
            else
            {
                HAL_AOE_AIP_WriteBufData(pTrack->enAIP[SND_AIP_TYPE_SPDIF_RAW], HI_NULL, SpdifRawData);
            }
        }

        if (SND_HDMI_MODE_LBR == pCard->enHdmiPassthrough ||
            SND_HDMI_MODE_HBR == pCard->enHdmiPassthrough)
        {
            if ((pstStreamAttr->u32LbrFormat & 0xff00) || (pstStreamAttr->u32HbrFormat & 0xff00))
            {
                stData[0] = 0xffff;
                stData[1] = HdmiRawData;
                HAL_AOE_AIP_WriteBufData(pTrack->enAIP[SND_AIP_TYPE_HDMI_RAW], (HI_U8*)stData, sizeof(stData));
            }
            else
            {
                HAL_AOE_AIP_WriteBufData(pTrack->enAIP[SND_AIP_TYPE_HDMI_RAW], HI_NULL, HdmiRawData);
            }
        }

        pTrack->u32AddMuteFrameNum++;
    }

    return;
}

HI_VOID TrackSetAipRbfAttr(AOE_RBUF_ATTR_S* pRbfAttr, MMZ_BUFFER_S* pstRbfMmz)
{
    pRbfAttr->tBufPhyAddr = pstRbfMmz->u32StartPhyAddr;
    pRbfAttr->tBufVirAddr = (HI_VIRT_ADDR_T)pstRbfMmz->pu8StartVirAddr;
    pRbfAttr->u32BufSize = pstRbfMmz->u32Size;
    pRbfAttr->u32BufWptrRptrFlag = 0;  /* cpu write */
}

HI_VOID TrackGetAipPcmDfAttr(AOE_AIP_CHN_ATTR_S* pstAipAttr, MMZ_BUFFER_S* pstRbfMmz,
                             HI_UNF_AUDIOTRACK_ATTR_S* pstUnfAttr)
{
    TrackSetAipRbfAttr(&pstAipAttr->stBufInAttr.stRbfAttr, pstRbfMmz);
    pstAipAttr->stBufInAttr.u32BufBitPerSample = AO_TRACK_BITDEPTH_LOW;
    pstAipAttr->stBufInAttr.u32BufSampleRate = HI_UNF_SAMPLE_RATE_48K;
    pstAipAttr->stBufInAttr.u32BufChannels     = AO_TRACK_NORMAL_CHANNELNUM;
    pstAipAttr->stBufInAttr.u32BufDataFormat   = 0;
    pstAipAttr->stBufInAttr.u32BufLatencyThdMs = pstUnfAttr->u32BufLevelMs;
    pstAipAttr->stBufInAttr.u32FadeinMs  = pstUnfAttr->u32FadeinMs;
    pstAipAttr->stBufInAttr.u32FadeoutMs = pstUnfAttr->u32FadeoutMs;
    pstAipAttr->stBufInAttr.bFadeEnable = HI_FALSE;
    pstAipAttr->stBufInAttr.eAipType = AOE_AIP_TYPE_PCM_BUTT;
    pstAipAttr->stBufInAttr.bMixPriority = HI_FALSE;
    if (pstUnfAttr->u32FadeinMs | pstUnfAttr->u32FadeoutMs)
    {
        pstAipAttr->stBufInAttr.bFadeEnable = HI_TRUE;
    }

    pstAipAttr->stFifoOutAttr.u32FifoBitPerSample = AO_TRACK_BITDEPTH_LOW;
    pstAipAttr->stFifoOutAttr.u32FifoSampleRate = HI_UNF_SAMPLE_RATE_48K;
    pstAipAttr->stFifoOutAttr.u32FifoChannels     = AO_TRACK_NORMAL_CHANNELNUM;
    pstAipAttr->stFifoOutAttr.u32FifoDataFormat   = 0;
    pstAipAttr->stFifoOutAttr.u32FiFoLatencyThdMs = AIP_FIFO_LATENCYMS_DEFAULT;
}

HI_VOID TrackGetAipLbrDfAttr(AOE_AIP_CHN_ATTR_S* pstAipAttr, MMZ_BUFFER_S* pstRbfMmz,
                             HI_UNF_AUDIOTRACK_ATTR_S* pstUnfAttr)
{
    TrackSetAipRbfAttr(&pstAipAttr->stBufInAttr.stRbfAttr, pstRbfMmz);
    pstAipAttr->stBufInAttr.u32BufBitPerSample = AO_TRACK_BITDEPTH_LOW;
    pstAipAttr->stBufInAttr.u32BufSampleRate = HI_UNF_SAMPLE_RATE_48K;
    pstAipAttr->stBufInAttr.u32BufChannels     = AO_TRACK_NORMAL_CHANNELNUM;
    pstAipAttr->stBufInAttr.u32BufDataFormat   = 1;
    pstAipAttr->stBufInAttr.u32BufLatencyThdMs = pstUnfAttr->u32BufLevelMs;
    pstAipAttr->stBufInAttr.bFadeEnable = HI_FALSE;
    pstAipAttr->stBufInAttr.bMixPriority = HI_FALSE;

    pstAipAttr->stFifoOutAttr.u32FifoBitPerSample = AO_TRACK_BITDEPTH_LOW;
    pstAipAttr->stFifoOutAttr.u32FifoSampleRate = HI_UNF_SAMPLE_RATE_48K;
    pstAipAttr->stFifoOutAttr.u32FifoChannels     = AO_TRACK_NORMAL_CHANNELNUM;
    pstAipAttr->stFifoOutAttr.u32FifoDataFormat   = 1;
    pstAipAttr->stFifoOutAttr.u32FiFoLatencyThdMs = AIP_FIFO_LATENCYMS_DEFAULT;
}

HI_VOID TrackGetAipHbrDfAttr(AOE_AIP_CHN_ATTR_S* pstAipAttr, MMZ_BUFFER_S* pstRbfMmz,
                             HI_UNF_AUDIOTRACK_ATTR_S* pstUnfAttr)
{
    TrackSetAipRbfAttr(&pstAipAttr->stBufInAttr.stRbfAttr, pstRbfMmz);
    pstAipAttr->stBufInAttr.u32BufBitPerSample = AO_TRACK_BITDEPTH_LOW;
    pstAipAttr->stBufInAttr.u32BufSampleRate = HI_UNF_SAMPLE_RATE_192K;
    pstAipAttr->stBufInAttr.u32BufChannels     = AO_TRACK_MUTILPCM_CHANNELNUM;
    pstAipAttr->stBufInAttr.u32BufDataFormat   = 1;
    pstAipAttr->stBufInAttr.u32BufLatencyThdMs = pstUnfAttr->u32BufLevelMs;;
    pstAipAttr->stBufInAttr.bFadeEnable = HI_FALSE;
    pstAipAttr->stBufInAttr.bMixPriority = HI_FALSE;

    pstAipAttr->stFifoOutAttr.u32FifoBitPerSample = AO_TRACK_BITDEPTH_LOW;
    pstAipAttr->stFifoOutAttr.u32FifoSampleRate = HI_UNF_SAMPLE_RATE_192K;
    pstAipAttr->stFifoOutAttr.u32FifoChannels     = AO_TRACK_MUTILPCM_CHANNELNUM;
    pstAipAttr->stFifoOutAttr.u32FifoDataFormat   = 1;
    pstAipAttr->stFifoOutAttr.u32FiFoLatencyThdMs = AIP_FIFO_LATENCYMS_DEFAULT;
}

HI_S32 TrackCreateMaster(SND_CARD_STATE_S* pCard, SND_TRACK_STATE_S* state, HI_UNF_AUDIOTRACK_ATTR_S* pstAttr)
{
    HI_S32 Ret;
    AOE_AIP_ID_E enAIP;
    AOE_AIP_CHN_ATTR_S stAipAttr;
    MMZ_BUFFER_S stRbfMmz;

    stRbfMmz = pCard->stTrackRbfMmz[SND_AIP_TYPE_PCM];
    TrackGetAipPcmDfAttr(&stAipAttr, &stRbfMmz, pstAttr);
    stAipAttr.stBufInAttr.eAipType = AOE_AIP_TYPE_PCM_DMX;

    {
        HI_U32 i;
        //for support slic 8K 1ch, avoid default value here, update fifo samplerate and channel
        stAipAttr.stFifoOutAttr.u32FifoSampleRate = pCard->enUserSampleRate;
        for (i = 0; i < pCard->stUserOpenParam.u32PortNum; i++)
        {
            if(HI_UNF_SND_OUTPUTPORT_I2S0 == pCard->stUserOpenParam.stOutport[i].enOutPort)
            {
                stAipAttr.stFifoOutAttr.u32FifoChannels = (HI_U32)(pCard->stUserOpenParam.stOutport[i].unAttr.stI2sAttr.stAttr.enChannel);
                HI_INFO_AO("Update HI_UNF_SND_OUTPUTPORT_I2S0 FifoChannels: %d\n", stAipAttr.stFifoOutAttr.u32FifoChannels);
           }
        }
    }

    Ret = HAL_AOE_AIP_Create(&enAIP, &stAipAttr);
    if (HI_SUCCESS != Ret)
    {
        HI_ERR_AO("HAL_AOE_AIP_Create failed\n");
        goto CREATE_PCM_ERR_EXIT;
    }

    state->enAIP[SND_AIP_TYPE_PCM] = enAIP;
    state->stAipRbfMmz[SND_AIP_TYPE_PCM] = stRbfMmz;
    state->bAipRbfExtDmaMem[SND_AIP_TYPE_PCM] = HI_FALSE;

#ifdef DRV_SND_MULTICH_AEF_SUPPORT
    stRbfMmz = pCard->stTrackRbfMmz[SND_AIP_TYPE_MC_PCM];
    TrackGetAipPcmDfAttr(&stAipAttr, &stRbfMmz, pstAttr);
    stAipAttr.stBufInAttr.eAipType = AOE_AIP_TYPE_PCM_MC;
    stAipAttr.stBufInAttr.u32BufChannels = AO_TRACK_MC_CHANNELNUM;
    stAipAttr.stFifoOutAttr.u32FifoChannels = AO_TRACK_MC_CHANNELNUM;
    Ret = HAL_AOE_AIP_Create(&enAIP, &stAipAttr);
    if (HI_SUCCESS != Ret)
    {
        HI_ERR_AO("HAL_AOE_AIP_Create failed\n");
        goto CREATE_MCPCM_ERR_EXIT;
    }

    state->enAIP[SND_AIP_TYPE_MC_PCM] = enAIP;
    state->stAipRbfMmz[SND_AIP_TYPE_MC_PCM] = stRbfMmz;
    state->bAipRbfExtDmaMem[SND_AIP_TYPE_MC_PCM] = HI_FALSE;
#endif

#ifdef DRV_SND_AD_OUTPUT_SUPPORT
    stRbfMmz = pCard->stTrackRbfMmz[SND_AIP_TYPE_ASSOC_PCM];
    TrackGetAipPcmDfAttr(&stAipAttr, &stRbfMmz, pstAttr);
    stAipAttr.stBufInAttr.eAipType = AOE_AIP_TYPE_PCM_ASSOC;
    Ret = HAL_AOE_AIP_Create(&enAIP, &stAipAttr);
    if (HI_SUCCESS != Ret)
    {
        HI_ERR_AO("HAL_AOE_AIP_Create failed\n");
        goto CREATE_ASSOCPCM_ERR_EXIT;
    }

    state->enAIP[SND_AIP_TYPE_ASSOC_PCM] = enAIP;
    state->stAipRbfMmz[SND_AIP_TYPE_ASSOC_PCM] = stRbfMmz;
    state->bAipRbfExtDmaMem[SND_AIP_TYPE_ASSOC_PCM] = HI_FALSE;
#endif

    if (SND_SPDIF_MODE_NONE != pCard->enSpdifPassthrough)
    {
        stRbfMmz = pCard->stTrackRbfMmz[SND_AIP_TYPE_SPDIF_RAW];
        TrackGetAipLbrDfAttr(&stAipAttr, &stRbfMmz, pstAttr);
        stAipAttr.stBufInAttr.eAipType = AOE_AIP_TYPE_PCM_BUTT;
        Ret = HAL_AOE_AIP_Create(&enAIP, &stAipAttr);
        if (HI_SUCCESS != Ret)
        {
            HI_ERR_AO("HAL_AOE_AIP_Create failed\n");
            goto CREATE_SPDIF_ERR_EXIT;
        }

        state->enAIP[SND_AIP_TYPE_SPDIF_RAW] = enAIP;
        state->stAipRbfMmz[SND_AIP_TYPE_SPDIF_RAW] = stRbfMmz;
        state->bAipRbfExtDmaMem[SND_AIP_TYPE_SPDIF_RAW] = HI_FALSE;
    }

    if (SND_HDMI_MODE_NONE != pCard->enHdmiPassthrough)
    {
        stRbfMmz = pCard->stTrackRbfMmz[SND_AIP_TYPE_HDMI_RAW];
        TrackGetAipHbrDfAttr(&stAipAttr, &stRbfMmz, pstAttr);
        stAipAttr.stBufInAttr.eAipType = AOE_AIP_TYPE_PCM_BUTT;
        Ret = HAL_AOE_AIP_Create(&enAIP, &stAipAttr);
        if (HI_SUCCESS != Ret)
        {
            HI_ERR_AO("HAL_AOE_AIP_Create failed\n");
            goto CREATE_HDMI_ERR_EXIT;
        }

        state->enAIP[SND_AIP_TYPE_HDMI_RAW] = enAIP;
        state->stAipRbfMmz[SND_AIP_TYPE_HDMI_RAW] = stRbfMmz;
        state->bAipRbfExtDmaMem[SND_AIP_TYPE_HDMI_RAW] = HI_FALSE;
    }

    state->enCurnStatus = SND_TRACK_STATUS_STOP;
    return HI_SUCCESS;

CREATE_HDMI_ERR_EXIT:
    if (SND_SPDIF_MODE_NONE != pCard->enSpdifPassthrough)
    {
        HAL_AOE_AIP_Destroy(state->enAIP[SND_AIP_TYPE_SPDIF_RAW]);
    }
CREATE_SPDIF_ERR_EXIT:

#ifdef DRV_SND_AD_OUTPUT_SUPPORT
    HAL_AOE_AIP_Destroy(state->enAIP[SND_AIP_TYPE_ASSOC_PCM]);
CREATE_ASSOCPCM_ERR_EXIT:
#endif

#ifdef DRV_SND_MULTICH_AEF_SUPPORT
    HAL_AOE_AIP_Destroy(state->enAIP[SND_AIP_TYPE_MC_PCM]);
CREATE_MCPCM_ERR_EXIT:
#endif

    HAL_AOE_AIP_Destroy(state->enAIP[SND_AIP_TYPE_PCM]);
CREATE_PCM_ERR_EXIT:
    return HI_FAILURE;
}

HI_S32 TrackCreateSlave(SND_CARD_STATE_S* pCard,
                        SND_TRACK_STATE_S* state,
                        HI_UNF_AUDIOTRACK_ATTR_S* pstAttr,
                        HI_BOOL bAlsaTrack,
                        AO_BUF_ATTR_S *pstBuf)
{
    HI_S32 Ret;
    AOE_AIP_ID_E enAIP;
    AOE_AIP_CHN_ATTR_S stAipAttr;
    MMZ_BUFFER_S stRbfMmz;
#ifdef AIAO_ALSA_DRV_V2
    if (1)
#else
    if (HI_FALSE == bAlsaTrack)
#endif
    {
        Ret = HI_DRV_MMZ_AllocAndMap("AO_SAipPcm", MMZ_OTHERS, AO_TRACK_PCM_BUFSIZE_BYTE_MAX, AIAO_BUFFER_ADDR_ALIGN,
                                     &stRbfMmz);
        if (HI_SUCCESS != Ret)
        {
            return HI_FAILURE;
        }

        TrackGetAipPcmDfAttr(&stAipAttr, &stRbfMmz, pstAttr);
        
        {
            HI_U32 i;
            //for support slic 8K 1ch, avoid default value here, update fifo samplerate and channel
            stAipAttr.stFifoOutAttr.u32FifoSampleRate = pCard->enUserSampleRate;
            for (i = 0; i < pCard->stUserOpenParam.u32PortNum; i++)
            {
                if(HI_UNF_SND_OUTPUTPORT_I2S0 == pCard->stUserOpenParam.stOutport[i].enOutPort)
                {
                    stAipAttr.stFifoOutAttr.u32FifoChannels = (HI_U32)(pCard->stUserOpenParam.stOutport[i].unAttr.stI2sAttr.stAttr.enChannel);
                    HI_INFO_AO("Update HI_UNF_SND_OUTPUTPORT_I2S0 FifoChannels: %d\n", stAipAttr.stFifoOutAttr.u32FifoChannels);
               }
            }
        }

        //slave track only support alsa & slave normal pcm2.0
        if (HI_TRUE == bAlsaTrack)
        {
            stAipAttr.stBufInAttr.eAipType = AOE_AIP_TYPE_PCM_ALSA;
        }
        else
        {
            stAipAttr.stBufInAttr.eAipType = AOE_AIP_TYPE_PCM_SLAVE;
        }

        Ret = HAL_AOE_AIP_Create(&enAIP, &stAipAttr);
        if (HI_SUCCESS != Ret)
        {
            HI_DRV_MMZ_UnmapAndRelease(&stRbfMmz);
            return HI_FAILURE;
        }

        state->enAIP[SND_AIP_TYPE_PCM] = enAIP;
        state->stAipRbfMmz[SND_AIP_TYPE_PCM] = stRbfMmz;
        state->bAipRbfExtDmaMem[SND_AIP_TYPE_PCM] = HI_FALSE;
        state->enCurnStatus = SND_TRACK_STATUS_STOP;
    }
#ifndef AIAO_ALSA_DRV_V2
    else
    {
        stRbfMmz.u32StartPhyAddr = pstBuf->u32BufPhyAddr;
        stRbfMmz.pu8StartVirAddr = (HI_U8*)pstBuf->tBufVirAddr;
        stRbfMmz.u32Size = pstBuf->u32BufSize;
#if  0
        TRP(stRbfMmz.u32StartPhyAddr);
        TRP(stRbfMmz.u32StartVirAddr);
        TRP(stRbfMmz.u32Size);
#endif
        TrackGetAipPcmDfAttr(&stAipAttr, &stRbfMmz, pstAttr);
        stAipAttr.stFifoOutAttr.u32FifoSampleRate = pCard->enUserSampleRate;
        //only alsa possibility, when come into this condition
        stAipAttr.stBufInAttr.eAipType = AOE_AIP_TYPE_PCM_ALSA;
        Ret = HAL_AOE_AIP_Create(&enAIP, &stAipAttr);
        if (HI_SUCCESS != Ret)
        {
            return HI_FAILURE;
        }

        state->enAIP[SND_AIP_TYPE_PCM] = enAIP;
        state->bAipRbfExtDmaMem[SND_AIP_TYPE_PCM] = HI_TRUE;
        state->enCurnStatus = SND_TRACK_STATUS_STOP;
    }
#endif

    return HI_SUCCESS;
}

HI_VOID SndOpBing2Engine(SND_CARD_STATE_S* pCard, HI_VOID* pEngine)
{
    HI_VOID* pSndOp;
    HI_U32 op;
    AOE_AOP_ID_E enAOP;
    SND_ENGINE_TYPE_E enEngineType = TrackGetEngineType(pEngine);
    SND_ENGINE_STATE_S* state = (SND_ENGINE_STATE_S*)pEngine;

    for (op = 0; op < HI_UNF_SND_OUTPUTPORT_MAX; op++)
    {
        if (pCard->pSndOp[op])
        {
            pSndOp = pCard->pSndOp[op];
            if (enEngineType == SND_GetOpGetOutType(pSndOp))
            {
                enAOP = SND_GetOpAopId(pSndOp);
                HAL_AOE_ENGINE_AttachAop(state->enEngine, enAOP);
            }
        }
    }
}

HI_VOID TrackSetMute(SND_CARD_STATE_S* pCard, SND_TRACK_STATE_S* pTrack, HI_BOOL bMute)
{
    HAL_AOE_AIP_SetMute(pTrack->enAIP[SND_AIP_TYPE_PCM], bMute);
    if (HI_UNF_SND_TRACK_TYPE_MASTER == pTrack->stUserTrackAttr.enTrackType)
    {
#ifdef DRV_SND_MULTICH_AEF_SUPPORT
        HAL_AOE_AIP_SetMute(pTrack->enAIP[SND_AIP_TYPE_MC_PCM], bMute);
#endif

#ifdef DRV_SND_AD_OUTPUT_SUPPORT
        HAL_AOE_AIP_SetMute(pTrack->enAIP[SND_AIP_TYPE_ASSOC_PCM], bMute);
#endif
        if (SND_SPDIF_MODE_NONE != pCard->enSpdifPassthrough)
        {
            HAL_AOE_AIP_SetMute(pTrack->enAIP[SND_AIP_TYPE_SPDIF_RAW], bMute);
        }
        if (SND_HDMI_MODE_NONE != pCard->enHdmiPassthrough)
        {
            HAL_AOE_AIP_SetMute(pTrack->enAIP[SND_AIP_TYPE_HDMI_RAW], bMute);
        }
    }
}

HI_S32 TrackBing2Engine(SND_CARD_STATE_S* pCard, HI_VOID* pSndTrack)
{
    AOE_AIP_CHN_ATTR_S stAipAttr;
    AOE_ENGINE_CHN_ATTR_S stEngineAttr;
    HI_VOID* pEngine;
    SND_TRACK_STATE_S* state = (SND_TRACK_STATE_S*)pSndTrack;
    SND_ENGINE_STATE_S* pstEnginestate;

#ifdef HI_SND_AFLT_SUPPORT
    HI_U32  u32AefId;
    HI_BOOL bMcProcess = HI_FALSE;   //The flag of whether to do mc process
#endif

    if (pCard->pSndEngine[SND_ENGINE_TYPE_PCM])
    {
        pEngine = pCard->pSndEngine[SND_ENGINE_TYPE_PCM];
        pstEnginestate = (SND_ENGINE_STATE_S*)pEngine; //verify
        HAL_AOE_ENGINE_AttachAip(pstEnginestate->enEngine, state->enAIP[SND_AIP_TYPE_PCM]);
    }
    else
    {
        HAL_AOE_AIP_GetAttr(state->enAIP[SND_AIP_TYPE_PCM], &stAipAttr);
        stEngineAttr.u32BitPerSample = stAipAttr.stFifoOutAttr.u32FifoBitPerSample;
        stEngineAttr.u32Channels   = stAipAttr.stFifoOutAttr.u32FifoChannels;
        stEngineAttr.u32SampleRate = stAipAttr.stFifoOutAttr.u32FifoSampleRate;
        stEngineAttr.u32DataFormat = stAipAttr.stFifoOutAttr.u32FifoDataFormat;

#ifdef HI_SND_USER_AEF_SUPPORT
        stEngineAttr.stAefInBufAttr.tBufPhyAddr   = pCard->stAefInBufMmz.u32StartPhyAddr;
        stEngineAttr.stAefInBufAttr.tBufVirAddr   = (HI_VIRT_ADDR_T)pCard->stAefInBufMmz.pu8StartVirAddr; //64w todo
        stEngineAttr.stAefInBufAttr.u32BufSize    = pCard->stAefInBufMmz.u32Size;
        stEngineAttr.stAefInBufAttr.u32PeriodSize = pCard->stAefInBufMmz.u32Size / AOE_AEF_PERIODBUF_NUM;
        stEngineAttr.stAefInBufAttr.u32PeriodNum  = AOE_AEF_PERIODBUF_NUM;

        stEngineAttr.stAefOutBufAttr.tBufPhyAddr   = pCard->stAefOutBufMmz.u32StartPhyAddr;
        stEngineAttr.stAefOutBufAttr.tBufVirAddr   = (HI_VIRT_ADDR_T)pCard->stAefOutBufMmz.pu8StartVirAddr;//64w todo
        stEngineAttr.stAefOutBufAttr.u32BufSize    = pCard->stAefOutBufMmz.u32Size;
        stEngineAttr.stAefOutBufAttr.u32PeriodSize = pCard->stAefOutBufMmz.u32Size / AOE_AEF_PERIODBUF_NUM;
        stEngineAttr.stAefOutBufAttr.u32PeriodNum  = AOE_AEF_PERIODBUF_NUM;
#endif

        TrackCreateEngine(&pEngine, &stEngineAttr, SND_ENGINE_TYPE_PCM);
        if (HI_NULL == pEngine)
        {
            HI_ERR_AO("Engine is NULL!\n");
			return HI_FAILURE;
        }

        pCard->pSndEngine[SND_ENGINE_TYPE_PCM] = pEngine;
        pstEnginestate = (SND_ENGINE_STATE_S*)pEngine;

#ifdef HI_SND_AFLT_SUPPORT
        //because engine is created after creating track
        for (u32AefId = 0; u32AefId < AOE_AEF_MAX_CHAN_NUM * 2; u32AefId++)
        {
            if (pCard->u32AttAef & ((HI_U32)1L << u32AefId))
            {
                HAL_AOE_ENGINE_AttachAef(pstEnginestate->enEngine, u32AefId);
            }
        }
        
        for (u32AefId = 0; u32AefId < AOE_AEF_MAX_CHAN_NUM * 2; u32AefId++)
        {
            if (pCard->u32AttAef & ((HI_U32)1L << u32AefId))
            {
                bMcProcess = (pCard->u32AefMcSupported & (1 << u32AefId)) ? HI_TRUE : HI_FALSE;
                break;
            }
        }
        HAL_AOE_ENGINE_SetAefAttr(pstEnginestate->enEngine, bMcProcess, pCard->u32AefFrameDelay);
#endif

#if 0
        HAL_AOE_ENGINE_SetAvcAttr(pstEnginestate->enEngine, &pCard->stAvcAttr);
        HAL_AOE_ENGINE_SetAvcEnable(pstEnginestate->enEngine, pCard->bAvcEnable);
        HAL_AOE_ENGINE_SetGeqAttr(pstEnginestate->enEngine, &pCard->stGeqAttr);
        HAL_AOE_ENGINE_SetGeqEnable(pstEnginestate->enEngine, pCard->bGeqEnable);
#endif
        HAL_AOE_ENGINE_AttachAip(pstEnginestate->enEngine, state->enAIP[SND_AIP_TYPE_PCM]);
        HAL_AOE_ENGINE_Start(pstEnginestate->enEngine);
        SndOpBing2Engine(pCard, pEngine);
    }

    if (HI_UNF_SND_TRACK_TYPE_MASTER == state->stUserTrackAttr.enTrackType)
    {
        if (SND_SPDIF_MODE_NONE != pCard->enSpdifPassthrough)
        {
            if (pCard->pSndEngine[SND_ENGINE_TYPE_SPDIF_RAW])
            {
                pEngine = pCard->pSndEngine[SND_ENGINE_TYPE_SPDIF_RAW];
                pstEnginestate = (SND_ENGINE_STATE_S*)pEngine; //verify
                HAL_AOE_ENGINE_AttachAip(pstEnginestate->enEngine, state->enAIP[SND_AIP_TYPE_SPDIF_RAW]);
            }
            else
            {
                HAL_AOE_AIP_GetAttr(state->enAIP[SND_AIP_TYPE_SPDIF_RAW], &stAipAttr);
                stEngineAttr.u32BitPerSample = stAipAttr.stFifoOutAttr.u32FifoBitPerSample;
                stEngineAttr.u32Channels   = stAipAttr.stFifoOutAttr.u32FifoChannels;
                stEngineAttr.u32SampleRate = stAipAttr.stFifoOutAttr.u32FifoSampleRate;
                stEngineAttr.u32DataFormat = stAipAttr.stFifoOutAttr.u32FifoDataFormat;
                TrackCreateEngine(&pEngine, &stEngineAttr, SND_ENGINE_TYPE_SPDIF_RAW);
				if (HI_NULL == pEngine)
		        {
		            HI_ERR_AO("Engine is NULL!\n");
					return HI_FAILURE;
		        }
                pCard->pSndEngine[SND_ENGINE_TYPE_SPDIF_RAW] = pEngine;
                pstEnginestate = (SND_ENGINE_STATE_S*)pEngine;
#if 0
                HAL_AOE_ENGINE_SetAvcAttr(pstEnginestate->enEngine, &pCard->stAvcAttr);
                HAL_AOE_ENGINE_SetAvcEnable(pstEnginestate->enEngine, pCard->bAvcEnable);
                HAL_AOE_ENGINE_SetGeqAttr(pstEnginestate->enEngine, &pCard->stGeqAttr);
                HAL_AOE_ENGINE_SetGeqEnable(pstEnginestate->enEngine, pCard->bGeqEnable);
#endif
                HAL_AOE_ENGINE_AttachAip(pstEnginestate->enEngine, state->enAIP[SND_AIP_TYPE_SPDIF_RAW]);
                HAL_AOE_ENGINE_Start(pstEnginestate->enEngine);
                SndOpBing2Engine(pCard, pEngine);
            }
        }

        if (SND_HDMI_MODE_NONE != pCard->enHdmiPassthrough)
        {
            if (pCard->pSndEngine[SND_ENGINE_TYPE_HDMI_RAW])
            {
                pEngine = pCard->pSndEngine[SND_ENGINE_TYPE_HDMI_RAW];
                pstEnginestate = (SND_ENGINE_STATE_S*)pEngine;
                HAL_AOE_ENGINE_AttachAip(pstEnginestate->enEngine, state->enAIP[SND_AIP_TYPE_HDMI_RAW]);
            }
            else
            {
                HAL_AOE_AIP_GetAttr(state->enAIP[SND_AIP_TYPE_HDMI_RAW], &stAipAttr);
                stEngineAttr.u32BitPerSample = stAipAttr.stFifoOutAttr.u32FifoBitPerSample;
                stEngineAttr.u32Channels   = stAipAttr.stFifoOutAttr.u32FifoChannels;
                stEngineAttr.u32SampleRate = stAipAttr.stFifoOutAttr.u32FifoSampleRate;
                stEngineAttr.u32DataFormat = stAipAttr.stFifoOutAttr.u32FifoDataFormat;
                TrackCreateEngine(&pEngine, &stEngineAttr, SND_ENGINE_TYPE_HDMI_RAW);
				if (HI_NULL == pEngine)
		        {
		            HI_ERR_AO("Engine is NULL!\n");
					return HI_FAILURE;
		        }
                pCard->pSndEngine[SND_ENGINE_TYPE_HDMI_RAW] = pEngine;
                pstEnginestate = (SND_ENGINE_STATE_S*)pEngine;
#if 0
                HAL_AOE_ENGINE_SetAvcAttr(pstEnginestate->enEngine, &pCard->stAvcAttr);
                HAL_AOE_ENGINE_SetAvcEnable(pstEnginestate->enEngine, pCard->bAvcEnable);

                HAL_AOE_ENGINE_SetGeqAttr(pstEnginestate->enEngine, &pCard->stGeqAttr);
                HAL_AOE_ENGINE_SetGeqEnable(pstEnginestate->enEngine, pCard->bGeqEnable);
#endif
                HAL_AOE_ENGINE_AttachAip(pstEnginestate->enEngine, state->enAIP[SND_AIP_TYPE_HDMI_RAW]);
                HAL_AOE_ENGINE_Start(pstEnginestate->enEngine);
                SndOpBing2Engine(pCard, pEngine);
            }
        }
    }

    return HI_SUCCESS;
}

/******************************AO Track FUNC*************************************/
HI_U32 TRACK_GetMasterId(SND_CARD_STATE_S* pCard)
{
    HI_U32 TrackId;
    SND_TRACK_STATE_S* state;

    for (TrackId = 0; TrackId < AO_MAX_TOTAL_TRACK_NUM; TrackId++)
    {
        if (pCard->uSndTrackInitFlag & ((HI_U32)1L << TrackId))
        {
            state = (SND_TRACK_STATE_S*)pCard->pSndTrack[TrackId];
            if (HI_UNF_SND_TRACK_TYPE_MASTER == state->stUserTrackAttr.enTrackType)
            {
                return TrackId;
            }
        }
    }

    return AO_MAX_TOTAL_TRACK_NUM;
}

HI_S32 TRACK_SetAipFiFoBypass(SND_CARD_STATE_S *pCard, HI_U32 u32TrackID, HI_BOOL bEnable)
{
    HI_S32 Ret = HI_FAILURE;
    SND_TRACK_STATE_S *state = (SND_TRACK_STATE_S *)pCard->pSndTrack[u32TrackID];

    if (pCard->pSndEngine[SND_ENGINE_TYPE_PCM] && state)
    {
        Ret = HAL_AOE_AIP_SetFiFoBypass(state->enAIP[SND_AIP_TYPE_PCM], bEnable);
        if(HI_SUCCESS != Ret)
        {
            HI_ERR_AO("HAL_AOE_AIP_SetFiFoBypass %d Ret = %d\n",bEnable, Ret);
            return Ret;
        }
        state->bFifoBypass = bEnable;
    }
    return Ret;
}

HI_S32 TRACK_CheckAttr(HI_UNF_AUDIOTRACK_ATTR_S* pstTrackAttr)
{
    if (HI_NULL == pstTrackAttr)
    {
        HI_ERR_AO("pstTrackAttr is null\n");
        return HI_FAILURE;
    }

    if (pstTrackAttr->enTrackType >= HI_UNF_SND_TRACK_TYPE_BUTT)
    {
        HI_ERR_AO("dont support tracktype(%d)\n", pstTrackAttr->enTrackType);
        return HI_FAILURE;
    }

    if (pstTrackAttr->u32BufLevelMs < AO_TRACK_MASTER_MIN_BUFLEVELMS || pstTrackAttr->u32BufLevelMs > AO_TRACK_MASTER_MAX_BUFLEVELMS)
    {
        HI_ERR_AO("Invalid u32BufLevelMs(%d), Min(%d), Max(%d)\n", pstTrackAttr->u32BufLevelMs,
                  AO_TRACK_MASTER_MIN_BUFLEVELMS, AO_TRACK_MASTER_MAX_BUFLEVELMS);
        return HI_FAILURE;
    }

    if ((HI_UNF_SND_TRACK_TYPE_MASTER == pstTrackAttr->enTrackType) && (pstTrackAttr->u32StartThresholdMs > pstTrackAttr->u32BufLevelMs))
    {
        HI_ERR_AO("Invalid u32StartThresholdMs(%dms) (Exceed u32BufLevelMs(%dms))\n", pstTrackAttr->u32StartThresholdMs, pstTrackAttr->u32BufLevelMs);
        return HI_FAILURE;
    }

    return HI_SUCCESS;
}

#if 0
HI_S32 TRACK_Duplicate2Aop(SND_CARD_STATE_S* pCard, HI_UNF_SND_OUTPUTPORT_E enOutPort, HI_U32 u32TrackID, HI_BOOL bEnable)
{
    SND_ENGINE_STATE_S* pEngine;
    HI_VOID *pSndOp;
    AOE_AOP_ID_E enAOP;
    HI_U32 u32DelayMs = 0, u32SkipMs;
    SND_TRACK_STATE_S* pTrack = (SND_TRACK_STATE_S*)pCard->pSndTrack[u32TrackID];

    pEngine = (SND_ENGINE_STATE_S*)pCard->pSndEngine[SND_ENGINE_TYPE_PCM];
    pSndOp = SNDGetOpHandleByOutPort(pCard, enOutPort);
	if (HI_NULL == pSndOp)
	{
	    HI_ERR_AO("pSndOp is NULL!\n");
        return HI_FAILURE;
	}
	
    enAOP = SND_GetOpAopId(pSndOp);

    if(HI_FALSE == bEnable)
    {
        if(HI_FALSE == pTrack->bDuplicate)
        {
            HI_ERR_AO("Track Duplicate2Aop is not enable,can not disable!\n");
            return HI_FAILURE;
        }

	    HAL_AOE_AIP_DetachAop(pTrack->enAIP[SND_AIP_TYPE_PCM], enAOP);
        HAL_AOE_ENGINE_AttachAop(pEngine->enEngine, enAOP);
        pTrack->bDuplicate = HI_FALSE;
        pTrack->enDuplicatePort = HI_UNF_SND_OUTPUTPORT_BUTT;
        return HI_SUCCESS;
    }

    if(HI_TRUE == pTrack->bDuplicate)
    {
        if(enOutPort == pTrack->enDuplicatePort)
        {
            return HI_SUCCESS;
        }
        else
        {
            HI_ERR_AO("Track has already Duplicate2 an other Aop!\n");
            return HI_FALSE;
        }
        
    }
    
    if(HI_FALSE == pTrack->bAttAi)
    {
        HI_ERR_AO("Track is not attach Ai,cannot Duplicate2Aop!\n");
        return HI_FAILURE;
    }

    AI_GetDelayMs(pTrack->hAi, &u32DelayMs);
    if(u32DelayMs < AO_TRACK_DUPLICATE_DELAY_THRESHOLDMS)
    {
        HI_ERR_AO("DelayMs is too small,cannot Duplicate2Aop!\n");
        return HI_FAILURE;
    }

    if(AI_IsHdimPort(pTrack->hAi))
    {
        HI_ERR_AO("Track attach HDMI AI,cannot Duplicate2Aop!\n");
        return HI_FAILURE;
    }

    //todo:制定更加详细的策略
    u32SkipMs = u32DelayMs -AO_TRACK_DUPLICATE_BUF_RESERVEMS;
    
    HAL_AOE_ENGINE_DetachAop(pEngine->enEngine, enAOP);
    HAL_AOE_AIP_AttachAop(pTrack->enAIP[SND_AIP_TYPE_PCM], enAOP, u32SkipMs);

    pTrack->bDuplicate = HI_TRUE;
    pTrack->enDuplicatePort = enOutPort;
    
    return HI_SUCCESS;
}
#endif

HI_S32 TRACK_CreateNew(SND_CARD_STATE_S* pCard, HI_UNF_AUDIOTRACK_ATTR_S* pstAttr,
                       HI_BOOL bAlsaTrack, AO_BUF_ATTR_S* pstBuf, HI_U32 TrackId)
{
    SND_TRACK_STATE_S* state = HI_NULL;
    HI_S32 Ret = HI_FAILURE;

    if (HI_SUCCESS != TRACK_CheckAttr(pstAttr))
    {
        HI_ERR_AO("invalid track attr\n");
        return HI_FAILURE;
    }

    state = AUTIL_AO_MALLOC(HI_ID_AO, sizeof(SND_TRACK_STATE_S), GFP_KERNEL);
    if (state == HI_NULL)
    {
        HI_FATAL_AO("malloc TRACK_Create failed\n");
        goto SndTrackCreate_ERR_EXIT;
    }

    memset(state, 0, sizeof(SND_TRACK_STATE_S));

    switch (pstAttr->enTrackType)
    {
        case HI_UNF_SND_TRACK_TYPE_MASTER:
            if (AO_MAX_TOTAL_TRACK_NUM != TRACK_GetMasterId(pCard))  //judge if master track exist
            {
                HI_ERR_AO("Master track exist!\n");
                goto SndTrackCreate_ERR_EXIT;
            }

            if (HI_SUCCESS != TrackCreateMaster(pCard, state, pstAttr))
            {
                goto SndTrackCreate_ERR_EXIT;
            }

            break;
        case HI_UNF_SND_TRACK_TYPE_LOWLATENCY:
        case HI_UNF_SND_TRACK_TYPE_SLAVE:
            if (HI_SUCCESS != TrackCreateSlave(pCard, state, pstAttr, bAlsaTrack, pstBuf))
            {
                goto SndTrackCreate_ERR_EXIT;
            }

            break;

        default:
            HI_ERR_AO("dont support tracktype(%d)\n ", pstAttr->enTrackType);
            goto SndTrackCreate_ERR_EXIT;
    }

    state->TrackId = TrackId;
    memcpy(&state->stUserTrackAttr, pstAttr, sizeof(HI_UNF_AUDIOTRACK_ATTR_S));
    state->stTrackAbsGain.bLinearMode = HI_TRUE;
    state->stTrackAbsGain.s32GainL = AO_MAX_LINEARVOLUME;
    state->stTrackAbsGain.s32GainR = AO_MAX_LINEARVOLUME;
    state->bMute = HI_FALSE;
    state->enChannelMode = HI_UNF_TRACK_MODE_STEREO;
    state->u32SendTryCnt = 0;
    state->u32SendCnt = 0;
    state->u32AddMuteFrameNum = 0;
    state->bEosFlag = HI_FALSE;
    state->bAlsaTrack = bAlsaTrack;
#if (1 == HI_PROC_SUPPORT)
    state->enSaveState = SND_DEBUG_CMD_CTRL_STOP;
    state->u32SaveCnt = 0;
    state->fileHandle = HI_NULL;
#endif
    state->bFifoBypass = HI_FALSE;
    pCard->pSndTrack[TrackId] = (HI_VOID *)state;
    pCard->uSndTrackInitFlag |= ((HI_U32)1L << TrackId);
    Ret = TrackBing2Engine(pCard, pCard->pSndTrack[TrackId]);
    if (HI_SUCCESS != Ret)
    {
        TRACK_Destroy(pCard, TrackId);
        return Ret;
    }

    return HI_SUCCESS;

SndTrackCreate_ERR_EXIT:
    AUTIL_AO_FREE(HI_ID_AO, (HI_VOID*)state);
    return Ret;
}

HI_VOID TRACK_AddMuteData(SND_CARD_STATE_S *pCard, SND_TRACK_STATE_S *pTrack)  
{
    HI_U32 SpdifRawData = 0, HdmiRawData = 0, PcmRawData = 0;
    HI_U32 FrameSize = 0;

    SND_TRACK_STREAM_ATTR_S * pstStreamAttr = &pTrack->stStreamAttr;

    {
        HI_U32 u32AdacDelayMs = TRACK_GetAdacDelayMs(pCard, pTrack);
        HI_U32 u32AdacAddMs   = 0;

        if (pTrack->u32PauseDelayMs > u32AdacDelayMs)
        {
            u32AdacAddMs    = pTrack->u32PauseDelayMs - u32AdacDelayMs;
        
            FrameSize = AUTIL_CalcFrameSize(pstStreamAttr->u32PcmChannels, pstStreamAttr->u32PcmBitDepth);
            PcmRawData = AUTIL_LatencyMs2ByteSize(u32AdacAddMs, FrameSize, pstStreamAttr->u32PcmSampleRate);
        }
    }

    if (SND_SPDIF_MODE_LBR == pCard->enSpdifPassthrough) 
    {
        HI_U32 u32SpdifDelayMs = TRACK_GetSpdifDelayMs(pCard, pTrack);
        HI_U32 u32SpdifAddMs   = 0;

        if (pTrack->u32PauseDelayMs > u32SpdifDelayMs)
        {
            u32SpdifAddMs = pTrack->u32PauseDelayMs - u32SpdifDelayMs;
            FrameSize = AUTIL_CalcFrameSize(pstStreamAttr->u32LbrChannels, pstStreamAttr->u32LbrBitDepth);
            SpdifRawData = AUTIL_LatencyMs2ByteSize(u32SpdifAddMs, FrameSize, pstStreamAttr->u32LbrSampleRate);
        }
    }

    if (SND_HDMI_MODE_LBR == pCard->enHdmiPassthrough)
    {
        HI_U32 u32HDMIDelayMs = TRACK_GetHDMIDelayMs(pCard, pTrack);
        HI_U32 u32HDMIAddMs   = 0;

        if (pTrack->u32PauseDelayMs > u32HDMIDelayMs)
        {
            u32HDMIAddMs   = pTrack->u32PauseDelayMs - u32HDMIDelayMs;

            FrameSize = AUTIL_CalcFrameSize(pstStreamAttr->u32LbrChannels, pstStreamAttr->u32LbrBitDepth);
            HdmiRawData = AUTIL_LatencyMs2ByteSize(u32HDMIAddMs, FrameSize, pstStreamAttr->u32LbrSampleRate);
        }
    }
    else if (SND_HDMI_MODE_HBR == pCard->enHdmiPassthrough)
    {
        HI_U32 u32HDMIDelayMs = TRACK_GetHDMIDelayMs(pCard, pTrack);
        HI_U32 u32HDMIAddMs   = 0;

        if (pTrack->u32PauseDelayMs > u32HDMIDelayMs)
        {
            u32HDMIAddMs   = pTrack->u32PauseDelayMs - u32HDMIDelayMs;

            FrameSize = AUTIL_CalcFrameSize(pstStreamAttr->u32HbrChannels, pstStreamAttr->u32HbrBitDepth);
            HdmiRawData = AUTIL_LatencyMs2ByteSize(u32HDMIAddMs, FrameSize, pstStreamAttr->u32HbrSampleRate);
        }
    }

    if (HI_TRUE == TrackCheckIsPcmOutput(pCard))
    { 
        UTIL_ALIGN4(PcmRawData);
        HAL_AOE_AIP_ChangeReadPos(pTrack->enAIP[SND_AIP_TYPE_PCM], PcmRawData);
    }

    if (SND_SPDIF_MODE_LBR == pCard->enSpdifPassthrough)
    {
        UTIL_ALIGN4(SpdifRawData);
        HAL_AOE_AIP_ChangeReadPos(pTrack->enAIP[SND_AIP_TYPE_SPDIF_RAW], SpdifRawData);
    }

    if (SND_HDMI_MODE_LBR == pCard->enHdmiPassthrough ||
        SND_HDMI_MODE_HBR == pCard->enHdmiPassthrough)
    {
        UTIL_ALIGN4(HdmiRawData);
        HAL_AOE_AIP_ChangeReadPos(pTrack->enAIP[SND_AIP_TYPE_HDMI_RAW], HdmiRawData);
    }

    pTrack->u32AddPauseResumeNum++;
}

HI_S32 TRACK_Destroy(SND_CARD_STATE_S* pCard, HI_U32 u32TrackID)
{
    SND_TRACK_STATE_S* state;
    SND_ENGINE_STATE_S* pstEngineState;

    state = (SND_TRACK_STATE_S*)pCard->pSndTrack[u32TrackID];
    if (HI_NULL == state)
    {
        return HI_FAILURE;
    }

    switch (state->stUserTrackAttr.enTrackType)
    {
        case HI_UNF_SND_TRACK_TYPE_MASTER:
            pstEngineState = (SND_ENGINE_STATE_S*)TrackGetEngineHandlebyType(pCard, SND_ENGINE_TYPE_PCM);
            if (pstEngineState)
            {
                HAL_AOE_ENGINE_DetachAip(pstEngineState->enEngine, state->enAIP[SND_AIP_TYPE_PCM]);
#ifdef DRV_SND_MULTICH_AEF_SUPPORT
                HAL_AOE_ENGINE_DetachAip(pstEngineState->enEngine, state->enAIP[SND_AIP_TYPE_MC_PCM]);
#endif
#ifdef DRV_SND_AD_OUTPUT_SUPPORT
                HAL_AOE_ENGINE_DetachAip(pstEngineState->enEngine, state->enAIP[SND_AIP_TYPE_ASSOC_PCM]);
#endif
            }
            HAL_AOE_AIP_Destroy(state->enAIP[SND_AIP_TYPE_PCM]);
#ifdef DRV_SND_MULTICH_AEF_SUPPORT
            HAL_AOE_AIP_Destroy(state->enAIP[SND_AIP_TYPE_MC_PCM]);
#endif
#ifdef DRV_SND_AD_OUTPUT_SUPPORT
            HAL_AOE_AIP_Destroy(state->enAIP[SND_AIP_TYPE_ASSOC_PCM]);
#endif

            if (SND_SPDIF_MODE_NONE != pCard->enSpdifPassthrough)
            {
                pstEngineState = (SND_ENGINE_STATE_S*)TrackGetEngineHandlebyType(pCard, SND_ENGINE_TYPE_SPDIF_RAW);
                if (pstEngineState)
                    HAL_AOE_ENGINE_DetachAip(pstEngineState->enEngine, state->enAIP[SND_AIP_TYPE_SPDIF_RAW]);
                HAL_AOE_AIP_Destroy(state->enAIP[SND_AIP_TYPE_SPDIF_RAW]);
            }

            if (SND_HDMI_MODE_NONE != pCard->enHdmiPassthrough)
            {
                pstEngineState = (SND_ENGINE_STATE_S*)TrackGetEngineHandlebyType(pCard, SND_ENGINE_TYPE_HDMI_RAW);
                if (pstEngineState)
                    HAL_AOE_ENGINE_DetachAip(pstEngineState->enEngine, state->enAIP[SND_AIP_TYPE_HDMI_RAW]);
                HAL_AOE_AIP_Destroy(state->enAIP[SND_AIP_TYPE_HDMI_RAW]);
            }
            break;
        case HI_UNF_SND_TRACK_TYPE_LOWLATENCY:
        case HI_UNF_SND_TRACK_TYPE_SLAVE:
            pstEngineState = (SND_ENGINE_STATE_S*)TrackGetEngineHandlebyType(pCard, SND_ENGINE_TYPE_PCM);
            if (pstEngineState)
                HAL_AOE_ENGINE_DetachAip(pstEngineState->enEngine, state->enAIP[SND_AIP_TYPE_PCM]);
            HAL_AOE_AIP_Destroy(state->enAIP[SND_AIP_TYPE_PCM]);
            if (HI_TRUE != state->bAipRbfExtDmaMem[SND_AIP_TYPE_PCM])
            {
                HI_DRV_MMZ_UnmapAndRelease(&state->stAipRbfMmz[SND_AIP_TYPE_PCM]);
            }

            break;

        default:
            break;
    }

    pCard->uSndTrackInitFlag &= ~((HI_U32)1L << state->TrackId);
    pCard->pSndTrack[state->TrackId] = HI_NULL;
    AUTIL_AO_FREE(HI_ID_AO, (HI_VOID*)state);
    return HI_SUCCESS;
}

HI_S32 TRACK_SendData(SND_CARD_STATE_S* pCard, HI_U32 u32TrackID, AO_FRAMEINFO_S* pstAOFrame)
{
    SND_TRACK_STATE_S* pTrack;
    SND_TRACK_STREAM_ATTR_S stStreamAttr;
    STREAMMODE_CHANGE_ATTR_S stChange;
    AOE_AIP_STATUS_E eAipStatus = AOE_AIP_STATUS_STOP;

    if (HI_NULL == pstAOFrame)
    {
        return HI_FAILURE;
    }

    pTrack = (SND_TRACK_STATE_S*)pCard->pSndTrack[u32TrackID];

    //Ao track state check
    if (SND_TRACK_STATUS_BUTT <= pTrack->enCurnStatus)
    {
        HI_ERR_AO("Invalid ao track status\n");
        return HI_FAILURE;
    }
    if (SND_TRACK_STATUS_PAUSE == pTrack->enCurnStatus)
    {
        return HI_ERR_AO_PAUSE_STATE;
    }
    if (SND_TRACK_STATUS_STOP == pTrack->enCurnStatus)
    {
        HI_ERR_AO("Ao track stop status, can't send data\n");
        return HI_FAILURE;
    }

    //if it is invaild samplerate & bitdepth, discard audio frame and return HI_SUCCESS(avoid printing).
    CHECK_AO_FRAME_NOSTANDART_SAMPLERATE(pstAOFrame->u32SampleRate);
    CHECK_AO_FRAME_BITDEPTH(pstAOFrame->s32BitPerSample);
    
    TRACKDbgCountTrySendData(pTrack);

    if (HI_UNF_SND_TRACK_TYPE_MASTER == pTrack->stUserTrackAttr.enTrackType)
    {
        TRACKBuildStreamAttr(pCard, pstAOFrame, &stStreamAttr);
    }
    else
    {
        // slave track only need to build pcm attr
        memset(&stStreamAttr, 0, sizeof(SND_TRACK_STREAM_ATTR_S));
        TrackBuildPcmAttr(pstAOFrame, &stStreamAttr);
    }

    DetectStreamModeChange(pCard, pTrack, &stStreamAttr, &stChange);

    if (HI_UNF_SND_TRACK_TYPE_MASTER == pTrack->stUserTrackAttr.enTrackType)
    {
        if (stChange.enPcmChange || stChange.enSpdifChange || stChange.enHdmiChnage)
        {
            //image that AIP status is the same for dmx & mc & assoc
            HAL_AOE_AIP_GetStatus(pTrack->enAIP[SND_AIP_TYPE_PCM], &eAipStatus); //master don't immediately start, so get start/stop status firstly
            if (AOE_AIP_STATUS_START == eAipStatus || AOE_AIP_STATUS_PAUSE == eAipStatus)
            {
                HAL_AOE_AIP_Stop(pTrack->enAIP[SND_AIP_TYPE_PCM]);
#ifdef DRV_SND_MULTICH_AEF_SUPPORT
                HAL_AOE_AIP_Stop(pTrack->enAIP[SND_AIP_TYPE_MC_PCM]);
                pCard->enPcmMcStart = HI_FALSE;

#endif
#ifdef DRV_SND_AD_OUTPUT_SUPPORT
                HAL_AOE_AIP_Stop(pTrack->enAIP[SND_AIP_TYPE_ASSOC_PCM]);
                pCard->enPcmAssocStart = HI_FALSE;
#endif
                if (SND_SPDIF_MODE_NONE != pCard->enSpdifPassthrough)
                    HAL_AOE_AIP_Stop(pTrack->enAIP[SND_AIP_TYPE_SPDIF_RAW]);
                if (SND_HDMI_MODE_NONE != pCard->enHdmiPassthrough)
                    HAL_AOE_AIP_Stop(pTrack->enAIP[SND_AIP_TYPE_HDMI_RAW]);
            }

            SndProcPcmRoute(pCard, pTrack, stChange.enPcmChange, &stStreamAttr);
            if (SND_SPDIF_MODE_NONE != pCard->enSpdifPassthrough)
                SndProcSpidfRoute(pCard, pTrack, stChange.enSpdifChange, &stStreamAttr);
            if (SND_HDMI_MODE_NONE != pCard->enHdmiPassthrough)
            { 
                if((SND_HDMI_MODE_LBR == pCard->enHdmiPassthrough) || (SND_HDMI_MODE_HBR == pCard->enHdmiPassthrough))
                {
                    HDMISetAudioMute(pCard);            
                }
                SndProcHdmifRoute(pCard, pTrack, stChange.enHdmiChnage, &stStreamAttr);
            }
            if (AOE_AIP_STATUS_START == eAipStatus)
            {                
                (HI_VOID)TRACKStartAipReal(pCard, pTrack);
            }
        }
        
        DetectTrueHDModeChange(pCard, &stStreamAttr);
    }
    else if (HI_UNF_SND_TRACK_TYPE_SLAVE == pTrack->stUserTrackAttr.enTrackType)
    {
        if (stChange.enPcmChange)
        {
            (HI_VOID)HAL_AOE_AIP_Stop(pTrack->enAIP[SND_AIP_TYPE_PCM]);   //slave immediately start, so we don't need get start/stop status
            SndProcPcmRoute(pCard, pTrack, stChange.enPcmChange, &stStreamAttr);
            (HI_VOID)HAL_AOE_AIP_Start(pTrack->enAIP[SND_AIP_TYPE_PCM]);
        }
    }
    else
    {
        //verify virtual
    }

    if (HI_FALSE == TrackisBufFree(pCard, pTrack, &stStreamAttr))
    {
        (HI_VOID)TRACKStartAipReal(pCard, pTrack);   //buf is being full, directly start aip,
        return HI_ERR_AO_OUT_BUF_FULL;
    }
    if (HI_UNF_SND_TRACK_TYPE_MASTER == pTrack->stUserTrackAttr.enTrackType)
    {
        TRACKBuildCompressRawData(&stStreamAttr);
    }

    TRACKWriteFrame(pCard, pTrack, &stStreamAttr);

    if (AO_SND_SPEEDADJUST_SRC == pTrack->enUserSpeedType && 0 > pTrack->s32UserSpeedRate)
    {
        TRACKWriteMuteFrame(pCard, pTrack, &stStreamAttr);
    }

    (HI_VOID)TRACKStartAip(pCard, pTrack);

    TRACKDbgCountSendData(pTrack);

    return HI_SUCCESS;
}

HI_S32 TRACK_SetPriority(SND_CARD_STATE_S *pCard, HI_U32 u32TrackID, HI_BOOL bEnable)
{
    SND_TRACK_STATE_S *pTrack;
    HI_S32 Ret;

    pTrack = (SND_TRACK_STATE_S *)pCard->pSndTrack[u32TrackID];

    if(pTrack->enCurnStatus != SND_TRACK_STATUS_START)
    {
        HI_WARN_AO("Please make track start first !\n");
        return HI_ERR_AO_NOTSUPPORT;
    }

    Ret = HAL_AOE_AIP_SetMixPriority(pTrack->enAIP[SND_AIP_TYPE_PCM], bEnable);
    if(Ret != HI_SUCCESS)
    {
        HI_ERR_AO("TRACK_SetPriority Failed !\n");
        return Ret;
    }
    pTrack->bAipPriority = bEnable;

    return Ret;
}

HI_S32 TRACK_GetPriority(SND_CARD_STATE_S *pCard, HI_U32 u32TrackID, HI_BOOL *pbEnable)
{
    SND_TRACK_STATE_S *pTrack;

    pTrack = (SND_TRACK_STATE_S *)pCard->pSndTrack[u32TrackID];

    return  HAL_AOE_AIP_GetMixPriority(pTrack->enAIP[SND_AIP_TYPE_PCM],  pbEnable);
}

HI_S32 TRACK_Start(SND_CARD_STATE_S* pCard, HI_U32 u32TrackID)
{
    SND_TRACK_STATE_S* pTrack;
    HI_S32 Ret = HI_SUCCESS;

    pTrack = (SND_TRACK_STATE_S*)pCard->pSndTrack[u32TrackID];
    if (HI_NULL == pTrack)
    {
        return HI_FAILURE;
    }

    pTrack = (SND_TRACK_STATE_S*)pCard->pSndTrack[u32TrackID];
    if (SND_TRACK_STATUS_START == pTrack->enCurnStatus)
    {
        return HI_SUCCESS;
    }

    if(pTrack->enCurnStatus == SND_TRACK_STATUS_PAUSE)
    {
        TRACK_AddMuteData(pCard, pTrack);
    }
    pTrack->enCurnStatus = SND_TRACK_STATUS_START;

    Ret = TRACKStartAip(pCard, pTrack);
    if (HI_SUCCESS != Ret)
    {
       HI_WARN_AO("TRACKStartAip Error\n");
    }

#ifdef HI_SOUND_SPDIF_COMPENSATION_SUPPORT
    TrackStartSpdifDelaySetting(pCard);
#endif
    return Ret;
}

HI_S32 TRACK_Stop(SND_CARD_STATE_S* pCard, HI_U32 u32TrackID)
{
    SND_TRACK_STATE_S* pTrack;
    HI_S32 Ret = HI_SUCCESS;

    pTrack = (SND_TRACK_STATE_S*)pCard->pSndTrack[u32TrackID];
    if (HI_NULL == pTrack)
    {
        return HI_FAILURE;
    }

    pTrack = (SND_TRACK_STATE_S*)pCard->pSndTrack[u32TrackID];
    if (SND_TRACK_STATUS_STOP == pTrack->enCurnStatus)
    {
        return HI_SUCCESS;
    }

    if (HI_UNF_SND_TRACK_TYPE_MASTER == pTrack->stUserTrackAttr.enTrackType)
    {
        HI_U32 u32AIPStopMask = 0;
        AOE_AIP_STATUS_E curstatus;
        HAL_AOE_AIP_GetStatus(pTrack->enAIP[SND_AIP_TYPE_PCM], &curstatus);
        if (curstatus != AOE_AIP_STATUS_STOP)
        {
            u32AIPStopMask |= (1 << (HI_U32)pTrack->enAIP[SND_AIP_TYPE_PCM]);
        }
#ifdef DRV_SND_MULTICH_AEF_SUPPORT
        HAL_AOE_AIP_GetStatus(pTrack->enAIP[SND_AIP_TYPE_MC_PCM], &curstatus);
        if (curstatus != AOE_AIP_STATUS_STOP)
        {
            u32AIPStopMask |= (1 << (HI_U32)pTrack->enAIP[SND_AIP_TYPE_MC_PCM]);
        }
#endif
#ifdef DRV_SND_AD_OUTPUT_SUPPORT
        HAL_AOE_AIP_GetStatus(pTrack->enAIP[SND_AIP_TYPE_ASSOC_PCM], &curstatus);
        if (curstatus != AOE_AIP_STATUS_STOP)
        {
            u32AIPStopMask |= (1 << (HI_U32)pTrack->enAIP[SND_AIP_TYPE_ASSOC_PCM]);
        }
#endif
        if (SND_SPDIF_MODE_NONE != pCard->enSpdifPassthrough)
        {
            HAL_AOE_AIP_GetStatus(pTrack->enAIP[SND_AIP_TYPE_SPDIF_RAW], &curstatus);
            if (curstatus != AOE_AIP_STATUS_STOP)
            {
                u32AIPStopMask |= (1 << (HI_U32)pTrack->enAIP[SND_AIP_TYPE_SPDIF_RAW]);
            }
        }
        if (SND_HDMI_MODE_NONE != pCard->enHdmiPassthrough)
        {
            HAL_AOE_AIP_GetStatus(pTrack->enAIP[SND_AIP_TYPE_HDMI_RAW], &curstatus);
            if (curstatus != AOE_AIP_STATUS_STOP)
            {
                u32AIPStopMask |= (1 << (HI_U32)pTrack->enAIP[SND_AIP_TYPE_HDMI_RAW]);
            }
        }

        //the interface is only used for master track type to stop
        if (u32AIPStopMask != 0)
        {
            Ret = HAL_AOE_AIP_Group_Stop(u32AIPStopMask);
            if(Ret != HI_SUCCESS)
            {
                HI_WARN_AO("AIP Stop Group  Error\n");
            }
        }

        if (SND_SPDIF_MODE_LBR == pCard->enSpdifPassthrough)
        {
            SndProcSpidfRoute(pCard, pTrack, TRACK_STREAMMODE_CHANGE_LBR2PCM, &pTrack->stStreamAttr);
        }
        else if (SND_SPDIF_MODE_HBR == pCard->enSpdifPassthrough)
        {
            SndProcSpidfRoute(pCard, pTrack, TRACK_STREAMMODE_CHANGE_HBR2PCM, &pTrack->stStreamAttr);
        }

        if (SND_HDMI_MODE_LBR == pCard->enHdmiPassthrough)
        {
            HDMISetAudioMute(pCard);            
            SndProcHdmifRoute(pCard, pTrack, TRACK_STREAMMODE_CHANGE_LBR2PCM, &pTrack->stStreamAttr);
        }
        else if (SND_HDMI_MODE_HBR == pCard->enHdmiPassthrough)
        {
            HDMISetAudioMute(pCard);            
            SndProcHdmifRoute(pCard, pTrack, TRACK_STREAMMODE_CHANGE_HBR2PCM, &pTrack->stStreamAttr);
        }
    }
    else
    {
        Ret = HAL_AOE_AIP_Stop(pTrack->enAIP[SND_AIP_TYPE_PCM]);
        if(Ret != HI_SUCCESS)
        {
            HI_WARN_AO("AIP Stop PCM  Error\n");
        }
    }
    pTrack->bEosFlag = HI_FALSE;

    pTrack->enCurnStatus = SND_TRACK_STATUS_STOP;

    return Ret;
}

HI_S32 TRACK_Pause(SND_CARD_STATE_S* pCard, HI_U32 u32TrackID)
{
    SND_TRACK_STATE_S* pTrack;
    HI_U32 u32DelayMs;
    HI_S32 Ret = HI_SUCCESS;

    pTrack = (SND_TRACK_STATE_S*)pCard->pSndTrack[u32TrackID];
    if (HI_NULL == pTrack)
    {
        return HI_FAILURE;
    }

    pTrack = (SND_TRACK_STATE_S*)pCard->pSndTrack[u32TrackID];
    if (SND_TRACK_STATUS_PAUSE == pTrack->enCurnStatus)
    {
        return HI_SUCCESS;
    }
#ifdef HI_SOUND_SPDIF_COMPENSATION_SUPPORT
    Ret = TrackPauseSpdifDelaySetting(pCard);
    if (HI_SUCCESS != Ret)
    {
        HI_ERR_AO("Pause Set delayms failed\n");
    }
#endif

    Ret = HAL_AOE_AIP_Pause(pTrack->enAIP[SND_AIP_TYPE_PCM]);
    if (HI_SUCCESS != Ret)
    {
        HI_WARN_AO("AIP Pause PCM  Error\n");
    }
    if (HI_UNF_SND_TRACK_TYPE_MASTER == pTrack->stUserTrackAttr.enTrackType)
    {
#ifdef DRV_SND_MULTICH_AEF_SUPPORT
        if (HI_TRUE == pCard->enPcmMcStart)
        {
            HAL_AOE_AIP_Pause(pTrack->enAIP[SND_AIP_TYPE_MC_PCM]);
        }
#endif
#ifdef DRV_SND_AD_OUTPUT_SUPPORT
        if (HI_TRUE == pCard->enPcmAssocStart)
        {
            HAL_AOE_AIP_Pause(pTrack->enAIP[SND_AIP_TYPE_ASSOC_PCM]);
        }
#endif
        if (SND_SPDIF_MODE_NONE != pCard->enSpdifPassthrough)
        {
            Ret = HAL_AOE_AIP_Pause(pTrack->enAIP[SND_AIP_TYPE_SPDIF_RAW]);
            if (HI_SUCCESS != Ret)
            {
                HI_WARN_AO("AIP Pause SPDIF  Error\n");
            }
        }
        if (SND_HDMI_MODE_NONE != pCard->enHdmiPassthrough)
        {
            if((SND_HDMI_MODE_LBR == pCard->enHdmiPassthrough) || (SND_HDMI_MODE_HBR == pCard->enHdmiPassthrough))
            {
                HDMISetAudioMute(pCard);            
            }
            Ret = HAL_AOE_AIP_Pause(pTrack->enAIP[SND_AIP_TYPE_HDMI_RAW]);
            if (HI_SUCCESS != Ret)
            {
                HI_WARN_AO("AIP Pause HDMI  Error\n");
            }
        }
    }

    TRACK_GetDelayMs(pCard, u32TrackID, &u32DelayMs);    
    pTrack->u32PauseDelayMs = u32DelayMs;

    pTrack->enCurnStatus = SND_TRACK_STATUS_PAUSE;

    return Ret;
}

HI_S32 TRACK_Flush(SND_CARD_STATE_S* pCard, HI_U32 u32TrackID)
{
    SND_TRACK_STATE_S* pTrack;
    HI_S32 Ret = HI_SUCCESS;

    pTrack = (SND_TRACK_STATE_S*)pCard->pSndTrack[u32TrackID];
    Ret = HAL_AOE_AIP_Flush(pTrack->enAIP[SND_AIP_TYPE_PCM]);
    if (HI_SUCCESS != Ret)
    {
        HI_WARN_AO("AIP flush PCM Error\n");
    }
    if (HI_UNF_SND_TRACK_TYPE_MASTER == pTrack->stUserTrackAttr.enTrackType)
    {
#ifdef DRV_SND_MULTICH_AEF_SUPPORT
        if (HI_TRUE == pCard->enPcmMcStart)
        {
            HAL_AOE_AIP_Flush(pTrack->enAIP[SND_AIP_TYPE_MC_PCM]);
        }
#endif
#ifdef DRV_SND_AD_OUTPUT_SUPPORT
        if (HI_TRUE == pCard->enPcmAssocStart)
        {
            HAL_AOE_AIP_Flush(pTrack->enAIP[SND_AIP_TYPE_ASSOC_PCM]);
        }
#endif
        if (SND_SPDIF_MODE_NONE != pCard->enSpdifPassthrough)
        {
            Ret = HAL_AOE_AIP_Flush(pTrack->enAIP[SND_AIP_TYPE_SPDIF_RAW]);
            if (HI_SUCCESS != Ret)
            {
                HI_WARN_AO("AIP flush SPDIF  Error\n");
            }
        }
        if (SND_HDMI_MODE_NONE != pCard->enHdmiPassthrough)
        {
            Ret = HAL_AOE_AIP_Flush(pTrack->enAIP[SND_AIP_TYPE_HDMI_RAW]);
            if (HI_SUCCESS != Ret)
            {
                HI_WARN_AO("AIP flush SPDIF  Error\n");
            }
        }
    }

    return Ret;
}

HI_S32 TRACK_DetectAttr(SND_CARD_STATE_S* pCard, HI_U32 u32TrackID, HI_UNF_AUDIOTRACK_ATTR_S* pstTrackAttr, SND_TRACK_ATTR_SETTING_E* penAttrSetting)
{
    SND_TRACK_STATE_S* pTrack;

    if (HI_SUCCESS != TRACK_CheckAttr(pstTrackAttr))
    {
        HI_ERR_AO("invalid parameter!\n");
        return HI_ERR_AO_INVALID_PARA;
    }

    pTrack = (SND_TRACK_STATE_S*)pCard->pSndTrack[u32TrackID];

    if (pTrack->stUserTrackAttr.enTrackType == pstTrackAttr->enTrackType)
    {
        if (pTrack->stUserTrackAttr.u32BufLevelMs != pstTrackAttr->u32BufLevelMs  ||
            pTrack->stUserTrackAttr.u32StartThresholdMs != pstTrackAttr->u32StartThresholdMs ||
            pTrack->stUserTrackAttr.u32FadeinMs != pstTrackAttr->u32FadeinMs ||
            pTrack->stUserTrackAttr.u32FadeoutMs != pstTrackAttr->u32FadeoutMs ||
            pTrack->stUserTrackAttr.u32OutputBufSize != pstTrackAttr->u32OutputBufSize)
        {
            //TODO   not support parameter  u32FadeinMs   u32FadeoutMs  u32OutputBufSize
            *penAttrSetting = SND_TRACK_ATTR_MODIFY;
        }
        else
        {
            *penAttrSetting = SND_TRACK_ATTR_RETAIN;
        }
    }
    else if (HI_UNF_SND_TRACK_TYPE_MASTER == pstTrackAttr->enTrackType)
    {
        *penAttrSetting = SND_TRACK_ATTR_SLAVE2MASTER;
    }
    else if (HI_UNF_SND_TRACK_TYPE_SLAVE == pstTrackAttr->enTrackType)
    {
        *penAttrSetting = SND_TRACK_ATTR_MASTER2SLAVE;
    }
    else
    {
        HI_ERR_AO("virttrack Not support \n");
        return HI_ERR_AO_INVALID_PARA;
    }

    return HI_SUCCESS;
}

HI_S32 TRACK_SetAttr(SND_CARD_STATE_S* pCard, HI_U32 u32TrackID, HI_UNF_AUDIOTRACK_ATTR_S* pstTrackAttr)
{
    SND_TRACK_STATE_S* pTrack;

    if (HI_NULL == pstTrackAttr)
    {
        return HI_FAILURE;
    }

    pTrack = (SND_TRACK_STATE_S*)pCard->pSndTrack[u32TrackID];
    pTrack->stUserTrackAttr.u32BufLevelMs = pstTrackAttr->u32BufLevelMs;
    pTrack->stUserTrackAttr.u32StartThresholdMs = pstTrackAttr->u32StartThresholdMs;

    pTrack->stUserTrackAttr.u32FadeinMs = pstTrackAttr->u32FadeinMs;
    pTrack->stUserTrackAttr.u32FadeoutMs = pstTrackAttr->u32FadeoutMs;
    pTrack->stUserTrackAttr.u32OutputBufSize = pstTrackAttr->u32OutputBufSize;

    return HI_SUCCESS;
}

HI_S32 TRACK_SetWeight(SND_CARD_STATE_S* pCard, HI_U32 u32TrackID, HI_UNF_SND_GAIN_ATTR_S* pstTrackGain)
{
    SND_TRACK_STATE_S* pTrack;
    HI_U32 u32dBReg;

    if (HI_NULL == pstTrackGain)
    {
        return HI_FAILURE;
    }

    if (HI_TRUE == pstTrackGain->bLinearMode)
    {
        CHECK_AO_LINEARVOLUME(pstTrackGain->s32Gain);
        u32dBReg = AUTIL_VolumeLinear2RegdB((HI_U32)pstTrackGain->s32Gain);
    }
    else
    {
        CHECK_AO_ABSLUTEVOLUME(pstTrackGain->s32Gain);
        u32dBReg = AUTIL_VolumedB2RegdB(pstTrackGain->s32Gain);
    }

    pTrack = (SND_TRACK_STATE_S*)pCard->pSndTrack[u32TrackID];

    HAL_AOE_AIP_SetLRVolume(pTrack->enAIP[SND_AIP_TYPE_PCM], u32dBReg, u32dBReg);
#if defined (DRV_SND_MULTICH_AEF_SUPPORT) || defined (DRV_SND_AD_OUTPUT_SUPPORT)
    if (HI_UNF_SND_TRACK_TYPE_MASTER == pTrack->stUserTrackAttr.enTrackType)
    {
#ifdef DRV_SND_MULTICH_AEF_SUPPORT
        HAL_AOE_AIP_SetLRVolume(pTrack->enAIP[SND_AIP_TYPE_MC_PCM], u32dBReg, u32dBReg);
#endif
#ifdef DRV_SND_AD_OUTPUT_SUPPORT
        HAL_AOE_AIP_SetLRVolume(pTrack->enAIP[SND_AIP_TYPE_ASSOC_PCM], u32dBReg, u32dBReg);
#endif
    }
#endif
    pTrack->stTrackAbsGain.bLinearMode = pstTrackGain->bLinearMode;
    pTrack->stTrackAbsGain.s32GainL = pstTrackGain->s32Gain;
    pTrack->stTrackAbsGain.s32GainR = pstTrackGain->s32Gain;

    return HI_SUCCESS;
}

HI_S32 TRACK_GetWeight(SND_CARD_STATE_S* pCard, HI_U32 u32TrackID, HI_UNF_SND_GAIN_ATTR_S* pstTrackGain)
{
    SND_TRACK_STATE_S* pTrack;

    if (HI_NULL == pstTrackGain)
    {
        return HI_FAILURE;
    }

    pTrack = (SND_TRACK_STATE_S*)pCard->pSndTrack[u32TrackID];

    pstTrackGain->bLinearMode = pTrack->stTrackAbsGain.bLinearMode;
    pstTrackGain->s32Gain = pTrack->stTrackAbsGain.s32GainL;    //Just give L Gain

    return HI_SUCCESS;
}

HI_S32 TRACK_SetAbsGain(SND_CARD_STATE_S* pCard, HI_U32 u32TrackID, HI_UNF_SND_ABSGAIN_ATTR_S* pstTrackAbsGain)
{
    SND_TRACK_STATE_S* pTrack;
    HI_U32 u32dBLReg;
    HI_U32 u32dBRReg;

    if (HI_NULL == pstTrackAbsGain)
    {
        return HI_FAILURE;
    }
    if (HI_TRUE == pstTrackAbsGain->bLinearMode)
    {
        CHECK_AO_LINEARVOLUME(pstTrackAbsGain->s32GainL);
        CHECK_AO_LINEARVOLUME(pstTrackAbsGain->s32GainR);

        u32dBLReg = AUTIL_VolumeLinear2RegdB((HI_U32)pstTrackAbsGain->s32GainL);
        u32dBRReg = AUTIL_VolumeLinear2RegdB((HI_U32)pstTrackAbsGain->s32GainR);
    }
    else
    {
        CHECK_AO_ABSLUTEVOLUMEEXT(pstTrackAbsGain->s32GainL);
        CHECK_AO_ABSLUTEVOLUMEEXT(pstTrackAbsGain->s32GainR);

        u32dBLReg = AUTIL_VolumedB2RegdB(pstTrackAbsGain->s32GainL);
        u32dBRReg = AUTIL_VolumedB2RegdB(pstTrackAbsGain->s32GainR);
    }

    pTrack = (SND_TRACK_STATE_S*)pCard->pSndTrack[u32TrackID];

    HAL_AOE_AIP_SetLRVolume(pTrack->enAIP[SND_AIP_TYPE_PCM], u32dBLReg, u32dBRReg);
#if defined (DRV_SND_MULTICH_AEF_SUPPORT) || defined (DRV_SND_AD_OUTPUT_SUPPORT)
    if (HI_UNF_SND_TRACK_TYPE_MASTER == pTrack->stUserTrackAttr.enTrackType)
    {
#ifdef DRV_SND_MULTICH_AEF_SUPPORT
        HAL_AOE_AIP_SetLRVolume(pTrack->enAIP[SND_AIP_TYPE_MC_PCM], u32dBLReg, u32dBRReg);
#endif
#ifdef DRV_SND_AD_OUTPUT_SUPPORT
        HAL_AOE_AIP_SetLRVolume(pTrack->enAIP[SND_AIP_TYPE_ASSOC_PCM], u32dBLReg, u32dBRReg);
#endif
    }
#endif
    pTrack->stTrackAbsGain.bLinearMode = pstTrackAbsGain->bLinearMode;
    pTrack->stTrackAbsGain.s32GainL = pstTrackAbsGain->s32GainL;
    pTrack->stTrackAbsGain.s32GainR = pstTrackAbsGain->s32GainR;

    return HI_SUCCESS;
}

HI_S32 TRACK_GetAbsGain(SND_CARD_STATE_S* pCard, HI_U32 u32TrackID, HI_UNF_SND_ABSGAIN_ATTR_S* pstTrackAbsGain)
{
    SND_TRACK_STATE_S* pTrack;

    if (HI_NULL == pstTrackAbsGain)
    {
        return HI_FAILURE;
    }
    pTrack = (SND_TRACK_STATE_S*)pCard->pSndTrack[u32TrackID];
    pstTrackAbsGain->bLinearMode = pTrack->stTrackAbsGain.bLinearMode;
    pstTrackAbsGain->s32GainL = pTrack->stTrackAbsGain.s32GainL;
    pstTrackAbsGain->s32GainR = pTrack->stTrackAbsGain.s32GainR;

    return HI_SUCCESS;
}

#if 0
HI_S32 TRACK_SetPrescale(SND_CARD_STATE_S* pCard, HI_U32 u32TrackID, HI_UNF_SND_PRECIGAIN_ATTR_S* pstPreciGain)
{
    SND_TRACK_STATE_S* pTrack;
    HI_U32 u32IntdB = 0;
    HI_S32 s32DecdB = 0;

    if (HI_NULL == pstPreciGain)
    {
        return HI_FAILURE;
    }

    CHECK_AO_ABSLUTEPRECIVOLUME(pstPreciGain->s32IntegerGain, pstPreciGain->s32DecimalGain);

    u32IntdB = AUTIL_VolumedB2RegdB(pstPreciGain->s32IntegerGain);
    s32DecdB = AUTIL_DecimalVolumedB2RegdB(pstPreciGain->s32DecimalGain);

    pTrack = (SND_TRACK_STATE_S*)pCard->pSndTrack[u32TrackID];

    HAL_AOE_AIP_SetPrescale(pTrack->enAIP[SND_AIP_TYPE_PCM], u32IntdB, s32DecdB);
    if (HI_UNF_SND_TRACK_TYPE_MASTER == pTrack->stUserTrackAttr.enTrackType)
    {
#ifdef DRV_SND_MULTICH_AEF_SUPPORT
        HAL_AOE_AIP_SetPrescale(pTrack->enAIP[SND_AIP_TYPE_MC_PCM], u32IntdB, s32DecdB);
#endif
#ifdef DRV_SND_AD_OUTPUT_SUPPORT
        HAL_AOE_AIP_SetPrescale(pTrack->enAIP[SND_AIP_TYPE_ASSOC_PCM], u32IntdB, s32DecdB);
#endif
    }

    pTrack->stUserPrescale.s32IntegerGain = pstPreciGain->s32IntegerGain;
    pTrack->stUserPrescale.s32DecimalGain = pstPreciGain->s32DecimalGain;

    return HI_SUCCESS;
}

HI_S32 TRACK_GetPrescale(SND_CARD_STATE_S* pCard, HI_U32 u32TrackID, HI_UNF_SND_PRECIGAIN_ATTR_S* pstPreciGain)
{
    SND_TRACK_STATE_S* pTrack;

    if (HI_NULL == pstPreciGain)
    {
        return HI_FAILURE;
    }

    pTrack = (SND_TRACK_STATE_S*)pCard->pSndTrack[u32TrackID];
    pstPreciGain->s32DecimalGain = pTrack->stUserPrescale.s32DecimalGain;
    pstPreciGain->s32IntegerGain = pTrack->stUserPrescale.s32IntegerGain;

    return HI_SUCCESS;
}
#endif

HI_S32 TRACK_SetMute(SND_CARD_STATE_S* pCard, HI_U32 u32TrackID, HI_BOOL bMute)
{
    SND_TRACK_STATE_S* pTrack;
    pTrack = (SND_TRACK_STATE_S*)pCard->pSndTrack[u32TrackID];

    //TODO
    if (HI_TRUE == pTrack->bAlsaTrack)
    {
        HI_WARN_AO("Alsa track don't support mute function!\n");
        return HI_FAILURE;
    }

    if (HI_FALSE == pCard->bAllTrackMute && HI_FALSE == bMute)
    {
        HI_INFO_AO("Track Set unMute Id %d\n", u32TrackID);
        TrackSetMute(pCard, pTrack, HI_FALSE);
    }
    else
    {
        HI_INFO_AO("Track Set Mute Id %d\n", u32TrackID);
        TrackSetMute(pCard, pTrack, HI_TRUE);
    }

    pTrack->bMute = bMute;

    return HI_SUCCESS;
}
HI_S32 TRACK_GetMute(SND_CARD_STATE_S* pCard, HI_U32 u32TrackID, HI_BOOL* pbMute)
{
    SND_TRACK_STATE_S* pTrack;

    if (HI_NULL == pbMute)
    {
        return HI_FAILURE;
    }
    pTrack = (SND_TRACK_STATE_S*)pCard->pSndTrack[u32TrackID];
    //TODO
    if (HI_TRUE == pTrack->bAlsaTrack)
    {
        HI_ERR_AO("Alsa track don't support mute function!\n");
        return HI_FAILURE;
    }

    *pbMute = pTrack->bMute;
    HI_INFO_AO("Track Id %d get Mute Staues %d\n", u32TrackID, *pbMute);
    return HI_SUCCESS;
}

HI_S32 TRACK_SetAllMute(SND_CARD_STATE_S* pCard, HI_BOOL bMute)
{
    HI_U32 i;
    SND_TRACK_STATE_S* pTrack;

    for (i = 0; i < AO_MAX_TOTAL_TRACK_NUM; i++)
    {
        if (pCard->pSndTrack[i])
        {
            pTrack = (SND_TRACK_STATE_S*)pCard->pSndTrack[i];
            if (HI_TRUE == pTrack->bAlsaTrack)
            {
                HI_WARN_AO("Alsa track don't support mute function!\n");
                continue;
            }

            if (HI_FALSE == pTrack->bMute && HI_FALSE == bMute)
            {
                HI_INFO_AO("Set Track All unmute Id %d\n", i);
                TrackSetMute(pCard, pTrack, HI_FALSE);
            }
            else
            {
                HI_INFO_AO("Set Track All mute Id %d\n", i);
                TrackSetMute(pCard, pTrack, HI_TRUE);
            }
        }
    }

    return HI_SUCCESS;
}

HI_S32 TRACK_SetChannelMode(SND_CARD_STATE_S* pCard, HI_U32 u32TrackID, HI_UNF_TRACK_MODE_E* penMode)
{
    SND_TRACK_STATE_S* pTrack;

    if (HI_NULL == penMode || HI_UNF_TRACK_MODE_BUTT == *penMode)
    {
        return HI_FAILURE;
    }

    pTrack = (SND_TRACK_STATE_S*)pCard->pSndTrack[u32TrackID];

    HAL_AOE_AIP_SetChannelMode(pTrack->enAIP[SND_AIP_TYPE_PCM], *(HI_U32*)penMode);
#if defined (DRV_SND_MULTICH_AEF_SUPPORT) || defined (DRV_SND_AD_OUTPUT_SUPPORT)
    if (HI_UNF_SND_TRACK_TYPE_MASTER == pTrack->stUserTrackAttr.enTrackType)
    {
#ifdef DRV_SND_MULTICH_AEF_SUPPORT
        HAL_AOE_AIP_SetChannelMode(pTrack->enAIP[SND_AIP_TYPE_MC_PCM], *(HI_U32*)penMode);
#endif
#ifdef DRV_SND_AD_OUTPUT_SUPPORT
        HAL_AOE_AIP_SetChannelMode(pTrack->enAIP[SND_AIP_TYPE_ASSOC_PCM], *(HI_U32*)penMode);
#endif
    }
#endif
    pTrack->enChannelMode = *penMode;

    return HI_SUCCESS;
}


HI_S32 TRACK_GetChannelMode(SND_CARD_STATE_S* pCard, HI_U32 u32TrackID, HI_UNF_TRACK_MODE_E* penMode)
{
    SND_TRACK_STATE_S* pTrack;

    if (HI_NULL == penMode)
    {
        return HI_FAILURE;
    }
    pTrack = (SND_TRACK_STATE_S*)pCard->pSndTrack[u32TrackID];

    *penMode = pTrack->enChannelMode;

    return HI_SUCCESS;
}

HI_S32 TRACK_SetSpeedAdjust(SND_CARD_STATE_S* pCard, HI_U32 u32TrackID, AO_SND_SPEEDADJUST_TYPE_E enType, HI_S32 s32Speed)
{
    SND_TRACK_STATE_S* pTrack;

    CHECK_AO_SPEEDADJUST(s32Speed);

    pTrack = (SND_TRACK_STATE_S*)pCard->pSndTrack[u32TrackID];

    if (AO_SND_SPEEDADJUST_SRC == enType)
    {
        HAL_AOE_AIP_SetSpeed(pTrack->enAIP[SND_AIP_TYPE_PCM], s32Speed); //verify no pcm need speedadjust?
#if defined (DRV_SND_MULTICH_AEF_SUPPORT) || defined (DRV_SND_AD_OUTPUT_SUPPORT)
        if (HI_UNF_SND_TRACK_TYPE_MASTER == pTrack->stUserTrackAttr.enTrackType)
        {
#ifdef DRV_SND_MULTICH_AEF_SUPPORT
            HAL_AOE_AIP_SetSpeed(pTrack->enAIP[SND_AIP_TYPE_MC_PCM], s32Speed);
#endif
#ifdef DRV_SND_AD_OUTPUT_SUPPORT
            HAL_AOE_AIP_SetSpeed(pTrack->enAIP[SND_AIP_TYPE_ASSOC_PCM], s32Speed);
#endif
        }
#endif
    }
    else if (AO_SND_SPEEDADJUST_MUTE == enType)
    {
        //verify  avplay not use
    }
    pTrack->enUserSpeedType  = enType;
    pTrack->s32UserSpeedRate = s32Speed;

    return HI_SUCCESS;
}

#ifdef HI_AUDIO_AI_SUPPORT
HI_S32 TRACK_SetPcmAttr(SND_CARD_STATE_S* pCard, HI_U32 u32TrackID, HI_HANDLE hAi)
{
    HI_S32 Ret;
    SND_TRACK_STATE_S* pTrack;
    AOE_AIP_CHN_ATTR_S stAipAttr;
    AIAO_RBUF_ATTR_S stAiaoBuf;
    AIAO_PORT_ATTR_S stPortAttr;
    HI_BOOL bDre = HI_FALSE;

    Ret = AI_GetPortAttr(hAi, &stPortAttr);
    if (HI_SUCCESS != Ret)
    {
        HI_ERR_AO("call AI_GetPortAttr failed!\n");
        return Ret;
    }

    memset(&stAiaoBuf, 0, sizeof(AIAO_RBUF_ATTR_S));
    Ret = AI_GetPortBuf(hAi, &stAiaoBuf);
    if (HI_SUCCESS != Ret)
    {
        HI_ERR_AO("call AI_GetPortBuf failed!\n");
        return Ret;
    }

    Ret = AI_GetDreEnableStatus(hAi, &bDre);
    if (HI_SUCCESS != Ret)
    {
        HI_ERR_AO("call AI_GetNREnableStatus failed!\n");
        return Ret;
    }

    pTrack = (SND_TRACK_STATE_S*)pCard->pSndTrack[u32TrackID];
    HAL_AOE_AIP_GetAttr(pTrack->enAIP[SND_AIP_TYPE_PCM], &stAipAttr );

    stAipAttr.stBufInAttr.u32BufSampleRate = (HI_U32)(stPortAttr.stIfAttr.enRate);
    stAipAttr.stBufInAttr.u32BufBitPerSample = (HI_U32)(stPortAttr.stIfAttr.enBitDepth);
    stAipAttr.stBufInAttr.u32BufChannels = (HI_U32)(stPortAttr.stIfAttr.enChNum);

    stAipAttr.stBufInAttr.stRbfAttr.tBufPhyAddr = stAiaoBuf.tBufPhyAddr;
    stAipAttr.stBufInAttr.stRbfAttr.tBufPhyRptr = stAiaoBuf.tBufPhyRptr;
    stAipAttr.stBufInAttr.stRbfAttr.tBufPhyWptr = stAiaoBuf.tBufPhyWptr;
    stAipAttr.stBufInAttr.stRbfAttr.tBufVirAddr = stAiaoBuf.tBufVirAddr;
    stAipAttr.stBufInAttr.stRbfAttr.tBufVirRptr = stAiaoBuf.tBufVirRptr;
    stAipAttr.stBufInAttr.stRbfAttr.tBufVirWptr = stAiaoBuf.tBufVirWptr;
    stAipAttr.stBufInAttr.stRbfAttr.u32BufSize = stAiaoBuf.u32BufSize;
    stAipAttr.stBufInAttr.stRbfAttr.u32BufWptrRptrFlag = 1;
    stAipAttr.stBufInAttr.bMixPriority = HI_TRUE;
    HAL_AOE_AIP_SetAttr(pTrack->enAIP[SND_AIP_TYPE_PCM], &stAipAttr);

    HAL_AOE_AIP_SetDre(pTrack->enAIP[SND_AIP_TYPE_PCM], bDre);

    return HI_SUCCESS;
}

HI_S32 TRACK_AttachAi(SND_CARD_STATE_S* pCard, HI_U32 u32TrackID, HI_HANDLE hAi)
{
    SND_TRACK_STATE_S* pTrack;

    pTrack = (SND_TRACK_STATE_S*)pCard->pSndTrack[u32TrackID];

    pTrack->bAttAi = HI_TRUE;
    pTrack->hAi = hAi;
    return HI_SUCCESS;
}

HI_S32 TRACK_DetachAi(SND_CARD_STATE_S* pCard, HI_U32 u32TrackID)
{
    HI_S32 Ret;
    SND_TRACK_STATE_S* pTrack;
    AOE_AIP_CHN_ATTR_S stAipAttr;
    MMZ_BUFFER_S stMmzBuf;
    pTrack = (SND_TRACK_STATE_S*)pCard->pSndTrack[u32TrackID];
    stMmzBuf = pTrack->stAipRbfMmz[SND_AIP_TYPE_PCM];

    Ret = HAL_AOE_AIP_GetAttr(pTrack->enAIP[SND_AIP_TYPE_PCM], &stAipAttr);
    if (HI_SUCCESS != Ret)
    {
        HI_ERR_AO("HAL_AOE_AIP_GetAttr failed!\n");
        return Ret;
    }
    stAipAttr.stBufInAttr.stRbfAttr.tBufPhyAddr = stMmzBuf.u32StartPhyAddr;
    stAipAttr.stBufInAttr.stRbfAttr.tBufVirAddr = (HI_VIRT_ADDR_T)stMmzBuf.pu8StartVirAddr;
    stAipAttr.stBufInAttr.stRbfAttr.u32BufSize = stMmzBuf.u32Size;
    stAipAttr.stBufInAttr.stRbfAttr.u32BufWptrRptrFlag = 0;
    stAipAttr.stBufInAttr.bMixPriority = HI_FALSE;

    HAL_AOE_AIP_Stop(pTrack->enAIP[SND_AIP_TYPE_PCM]);
    Ret = HAL_AOE_AIP_SetAttr(pTrack->enAIP[SND_AIP_TYPE_PCM], &stAipAttr);
    if (HI_SUCCESS != Ret)
    {
        HI_ERR_AO("HAL_AOE_AIP_SetAttr failed!\n");
        return Ret;
    }
    Ret = HAL_AOE_AIP_Start(pTrack->enAIP[SND_AIP_TYPE_PCM]);
    if (HI_SUCCESS != Ret)
    {
        HI_ERR_AO("HAL_AOE_AIP_Start failed!\n");
        return Ret;
    }

    pTrack->bAttAi = HI_FALSE;
    pTrack->hAi = HI_INVALID_HANDLE;
    return Ret;
}
#endif

HI_S32 TRACK_SetDre(SND_CARD_STATE_S* pCard, HI_U32 u32TrackID, HI_BOOL bDre)
{
    SND_TRACK_STATE_S* pTrack = (SND_TRACK_STATE_S*)pCard->pSndTrack[u32TrackID];

    HAL_AOE_AIP_SetDre(pTrack->enAIP[SND_AIP_TYPE_PCM], bDre);

    return HI_SUCCESS;
}

HI_U32 TRACK_GetAdacDelayMs(SND_CARD_STATE_S* pCard, SND_TRACK_STATE_S* pTrack)
{
    HI_U32 u32AipDelayMs = 0;
    HI_U32 u32FifoDelayMs = 0;
    HI_U32 u32AopDelayMs = 0;

    if (HI_TRUE == TrackCheckIsPcmOutput(pCard))
    {
        HAL_AOE_AIP_GetBufDelayMs(pTrack->enAIP[SND_AIP_TYPE_PCM], &u32AipDelayMs);
        HAL_AOE_AIP_GetFiFoDelayMs(pTrack->enAIP[SND_AIP_TYPE_PCM], &u32FifoDelayMs);
    }

    SND_GetPortDelayMs(pCard, SND_OUTPUT_TYPE_DAC, &u32AopDelayMs);

    return (u32AipDelayMs + u32FifoDelayMs + u32AopDelayMs);
}

HI_U32 TRACK_GetSpdifDelayMs(SND_CARD_STATE_S* pCard, SND_TRACK_STATE_S* pTrack)
{
    HI_U32 u32AipDelayMs = 0;
    HI_U32 u32AopDelayMs = 0;

    HAL_AOE_AIP_GetBufDelayMs(pTrack->enAIP[SND_AIP_TYPE_SPDIF_RAW], &u32AipDelayMs);
    SND_GetPortDelayMs(pCard, SND_OUTPUT_TYPE_SPDIF, &u32AopDelayMs);

    return (u32AipDelayMs + u32AopDelayMs);
}

HI_U32 TRACK_GetHDMIDelayMs(SND_CARD_STATE_S* pCard, SND_TRACK_STATE_S* pTrack)
{
    HI_U32 u32AipDelayMs = 0;
    HI_U32 u32AopDelayMs = 0;

    HAL_AOE_AIP_GetBufDelayMs(pTrack->enAIP[SND_AIP_TYPE_HDMI_RAW], &u32AipDelayMs);
    SND_GetPortDelayMs(pCard, SND_OUTPUT_TYPE_HDMI, &u32AopDelayMs);

    return (u32AipDelayMs + u32AopDelayMs);
}

HI_S32 TRACK_GetDelayMs(SND_CARD_STATE_S* pCard, HI_U32 u32TrackID, HI_U32* pu32DelayMs)
{
    SND_TRACK_STATE_S* pTrack;
    HI_U32 u32TrackDelayMs = 0;
    HI_U32 u32TrackFiFoDelayMs = 0;
    HI_U32 u32SndFiFoDelayMs = 0;
    HI_U32 u32SndExtDelayMs=0;
#ifdef HI_SND_AFLT_SUPPORT
    HI_U32 u32EngineAefDelayMs = 0;
    SND_ENGINE_STATE_S* pstEnginestate = HI_NULL;
#endif

    if (HI_NULL == pu32DelayMs)
    {
        return HI_FAILURE;
    }
    
    pTrack = (SND_TRACK_STATE_S*)pCard->pSndTrack[u32TrackID];
#ifdef HI_AUDIO_AI_SUPPORT
    if(HI_FALSE == pTrack->bAttAi && pTrack->bFifoBypass == HI_FALSE)
#else
    if(pTrack->bFifoBypass == HI_FALSE)
#endif
    {
        if (HI_TRUE == TrackCheckIsPcmOutput(pCard))
        {        
            //Because Mc & Assoc is the same with Dmx, so only need to get Dmx delay_ms
            HAL_AOE_AIP_GetBufDelayMs(pTrack->enAIP[SND_AIP_TYPE_PCM], &u32TrackDelayMs);
            HAL_AOE_AIP_GetFiFoDelayMs(pTrack->enAIP[SND_AIP_TYPE_PCM], &u32TrackFiFoDelayMs);       // for aip fifo delay
        }
        else if(SND_SPDIF_MODE_LBR == pCard->enSpdifPassthrough || SND_SPDIF_MODE_HBR == pCard->enSpdifPassthrough)
        {
            HAL_AOE_AIP_GetBufDelayMs(pTrack->enAIP[SND_AIP_TYPE_SPDIF_RAW], &u32TrackDelayMs);
            HAL_AOE_AIP_GetFiFoDelayMs(pTrack->enAIP[SND_AIP_TYPE_SPDIF_RAW], &u32TrackFiFoDelayMs); // for aip fifo delay
        }
        else if (SND_HDMI_MODE_LBR == pCard->enHdmiPassthrough || SND_HDMI_MODE_HBR == pCard->enHdmiPassthrough)
        {
            HAL_AOE_AIP_GetBufDelayMs(pTrack->enAIP[SND_AIP_TYPE_HDMI_RAW], &u32TrackDelayMs);
            HAL_AOE_AIP_GetFiFoDelayMs(pTrack->enAIP[SND_AIP_TYPE_HDMI_RAW], &u32TrackFiFoDelayMs);  // for aip fifo delay
        }
    }

    SND_GetDelayMs(pCard, &u32SndFiFoDelayMs);
    
    *pu32DelayMs = u32TrackDelayMs + u32TrackFiFoDelayMs + u32SndFiFoDelayMs;
    SND_GetExtDelayMs(pCard, &u32SndExtDelayMs);
    *pu32DelayMs += u32SndExtDelayMs;
#ifdef HI_SND_AFLT_SUPPORT
    pstEnginestate = (SND_ENGINE_STATE_S*)pCard->pSndEngine[SND_ENGINE_TYPE_PCM];
    if (pstEnginestate != HI_NULL)
    {
        HAL_AOE_ENGINE_GetAefDelayMs(pstEnginestate->enEngine, &u32EngineAefDelayMs);
    }
    *pu32DelayMs += u32EngineAefDelayMs;
#endif

    return HI_SUCCESS;
}

HI_S32 TRACK_IsBufEmpty(SND_CARD_STATE_S* pCard, HI_U32 u32TrackID, HI_BOOL* pbBufEmpty)
{
    SND_TRACK_STATE_S* pTrack;
    HI_U32 u32TrackDelayMs = 0;
    HI_U32 u32TrackFiFoDelayMs = 0;

    if (HI_NULL == pbBufEmpty)
    {
        return HI_FAILURE;
    }

    pTrack = (SND_TRACK_STATE_S*)pCard->pSndTrack[u32TrackID];
    if (HI_TRUE == TrackCheckIsPcmOutput(pCard))
    {
        HAL_AOE_AIP_GetBufDelayMs(pTrack->enAIP[SND_AIP_TYPE_PCM], &u32TrackDelayMs);
        HAL_AOE_AIP_GetFiFoDelayMs(pTrack->enAIP[SND_AIP_TYPE_PCM], &u32TrackFiFoDelayMs); // for aip fifo delay
    }
    else if(SND_SPDIF_MODE_LBR == pCard->enSpdifPassthrough || SND_SPDIF_MODE_HBR == pCard->enSpdifPassthrough)
    {
        HAL_AOE_AIP_GetBufDelayMs(pTrack->enAIP[SND_AIP_TYPE_SPDIF_RAW], &u32TrackDelayMs);
        HAL_AOE_AIP_GetFiFoDelayMs(pTrack->enAIP[SND_AIP_TYPE_SPDIF_RAW], &u32TrackFiFoDelayMs); // for aip fifo delay
    }
    else if (SND_HDMI_MODE_LBR == pCard->enHdmiPassthrough || SND_HDMI_MODE_HBR == pCard->enHdmiPassthrough)
    {
        HAL_AOE_AIP_GetBufDelayMs(pTrack->enAIP[SND_AIP_TYPE_HDMI_RAW], &u32TrackDelayMs);
        HAL_AOE_AIP_GetFiFoDelayMs(pTrack->enAIP[SND_AIP_TYPE_HDMI_RAW], &u32TrackFiFoDelayMs); // for aip fifo delay
    }

    if (u32TrackDelayMs + u32TrackFiFoDelayMs <= AO_TRACK_BUF_EMPTY_THRESHOLD_MS)
    {
        *pbBufEmpty = HI_TRUE;
    }
    else
    {
        *pbBufEmpty = HI_FALSE;
    }

    return HI_SUCCESS;
}

HI_S32 TRACK_SetEosFlag(SND_CARD_STATE_S* pCard, HI_U32 u32TrackID, HI_BOOL bEosFlag)
{
    SND_TRACK_STATE_S* pTrack;

    pTrack = (SND_TRACK_STATE_S*)pCard->pSndTrack[u32TrackID];
    pTrack->bEosFlag = bEosFlag;

    return HI_SUCCESS;
}

HI_S32 TRACK_GetStatus(SND_CARD_STATE_S* pCard, HI_U32 u32TrackID, HI_VOID* pstParam)
{
    //TO DO
    //s1:HAL_AOE_AOP_GetStatus
    return HI_SUCCESS;
}

HI_S32 TRACK_GetDefAttr(HI_UNF_AUDIOTRACK_ATTR_S* pstDefAttr)
{
    //zgjiere;u32OutputBufSize 目前被忽略，AIP按照最大能力创建，避免频繁内存操作
    switch (pstDefAttr->enTrackType)
    {
        case HI_UNF_SND_TRACK_TYPE_MASTER:
        {
            pstDefAttr->u32BufLevelMs = AO_TRACK_MASTER_DEFATTR_BUFLEVELMS;
            pstDefAttr->u32OutputBufSize = AO_TRACK_MASTER_DEFATTR_BUFSIZE;        //verify
            pstDefAttr->u32FadeinMs  = AO_TRACK_MASTER_DEFATTR_FADEINMS;
            pstDefAttr->u32FadeoutMs = AO_TRACK_MASTER_DEFATTR_FADEOUTMS;
            pstDefAttr->u32StartThresholdMs = AO_TRACK_DEFATTR_START_THRESHOLDMS;
            break;
        }
        case HI_UNF_SND_TRACK_TYPE_LOWLATENCY:
        case HI_UNF_SND_TRACK_TYPE_SLAVE:
        {
            pstDefAttr->u32BufLevelMs = AO_TRACK_SLAVE_DEFATTR_BUFLEVELMS;
            pstDefAttr->u32OutputBufSize = AO_TRACK_SLAVE_DEFATTR_BUFSIZE;        //verify
            pstDefAttr->u32FadeinMs  = AO_TRACK_SLAVE_DEFATTR_FADEINMS;
            pstDefAttr->u32FadeoutMs = AO_TRACK_SLAVE_DEFATTR_FADEOUTMS;
            break;
        }

        case HI_UNF_SND_TRACK_TYPE_VIRTUAL:
        {
            pstDefAttr->u32OutputBufSize = AO_TRACK_VIRTUAL_DEFATTR_BUFSIZE;
            break;
        }

        default:

            //todo
            HI_ERR_AO("Get DefaultTrackAttr failed!\n");
            return HI_FAILURE;
    }

    return HI_SUCCESS;
}

HI_S32 TRACK_GetAttr(SND_CARD_STATE_S* pCard, HI_U32 u32TrackID, HI_UNF_AUDIOTRACK_ATTR_S* pstTrackAttr)
{
    SND_TRACK_STATE_S* pTrack;

    if (HI_NULL == pstTrackAttr)
    {
        return HI_FAILURE;
    }

    pTrack = (SND_TRACK_STATE_S*)pCard->pSndTrack[u32TrackID];
    memcpy(pstTrackAttr, &pTrack->stUserTrackAttr, sizeof(HI_UNF_AUDIOTRACK_ATTR_S));//verify  TrackType

    return HI_SUCCESS;
}

HI_S32  TRACK_MmapTrackAttr(SND_CARD_STATE_S *pCard, HI_U32 u32TrackID, AO_Track_GetTrackMapInfo_Param_S *pstTrackMapInfo)
{
    SND_TRACK_STATE_S * pTrack;
    AOE_AIP_CHN_ATTR_S stAipAttr;

    pTrack = (SND_TRACK_STATE_S *)pCard->pSndTrack[u32TrackID];

    if(pTrack->enCurnStatus != SND_TRACK_STATUS_STOP)
    {
        HI_ERR_AO("Mmap Track Attr should be ahead of Track Start!\n");
        return HI_FAILURE;
    }

    if(pTrack->bFifoBypass == HI_TRUE)
    {
        // pcm stream attr
        if (HI_UNF_I2S_BIT_DEPTH_16 != pstTrackMapInfo->u32BitPerSample)
        {
            HI_ERR_AO("Fifo Bypess:BitPerSample should be HI_UNF_I2S_BIT_DEPTH_16 \n");
            return HI_FAILURE;
        }

        if (HI_UNF_I2S_CHNUM_2 != pstTrackMapInfo->u32Channels)
        {
            HI_ERR_AO("Fifo Bypess:Channel should be HI_UNF_I2S_CHNUM_2 \n");
            return HI_FAILURE;
        }

        if (HI_UNF_SAMPLE_RATE_48K != pstTrackMapInfo->u32SampleRate)
        {
            HI_ERR_AO("Fifo Bypess:SampleRate should be HI_UNF_SAMPLE_RATE_48K \n");
            return HI_FAILURE;
        }
    }

    pstTrackMapInfo->u32AipRegAddr = HAL_AOE_AIP_GetRegAddr(pTrack->enAIP[SND_AIP_TYPE_PCM]);

    //Set AIP In Buffer attr before Track start
    HAL_AOE_AIP_GetAttr(pTrack->enAIP[SND_AIP_TYPE_PCM], &stAipAttr);
    stAipAttr.stBufInAttr.u32BufBitPerSample = pstTrackMapInfo->u32BitPerSample;
    stAipAttr.stBufInAttr.u32BufSampleRate = pstTrackMapInfo->u32SampleRate;
    stAipAttr.stBufInAttr.u32BufChannels   = pstTrackMapInfo->u32Channels;
    stAipAttr.stBufInAttr.u32BufDataFormat = 0;
    HAL_AOE_AIP_SetAttr(pTrack->enAIP[SND_AIP_TYPE_PCM], &stAipAttr);

    //Set Stream Attr
    pTrack->stStreamAttr.u32PcmBitDepth = pstTrackMapInfo->u32BitPerSample;
    pTrack->stStreamAttr.u32PcmSampleRate = pstTrackMapInfo->u32SampleRate;
    pTrack->stStreamAttr.u32PcmChannels = pstTrackMapInfo->u32Channels;

    return HI_SUCCESS;
}

HI_S32 TRACK_GetSetting(SND_CARD_STATE_S *pCard, HI_U32 u32TrackID, SND_TRACK_SETTINGS_S* pstSndSettings)
{
    SND_TRACK_STATE_S* pTrack;

    pTrack = (SND_TRACK_STATE_S*)pCard->pSndTrack[u32TrackID];
    pstSndSettings->enCurnStatus = pTrack->enCurnStatus;
    pstSndSettings->enType = pTrack->enUserSpeedType;
    pstSndSettings->s32Speed = pTrack->s32UserSpeedRate;
    memcpy(&pstSndSettings->stTrackAbsGain, &pTrack->stTrackAbsGain, sizeof(HI_UNF_SND_ABSGAIN_ATTR_S));
    //memcpy(&pstSndSettings->stPrescale, &pTrack->stUserPrescale, sizeof(HI_UNF_SND_PRECIGAIN_ATTR_S));
    memcpy(&pstSndSettings->enChannelMode, &pTrack->enChannelMode, sizeof(HI_UNF_TRACK_MODE_E));
    memcpy(&pstSndSettings->stTrackAttr, &pTrack->stUserTrackAttr, sizeof(HI_UNF_AUDIOTRACK_ATTR_S));
    pstSndSettings->bMute = pTrack->bMute;
    pstSndSettings->bPriority= pTrack->bAipPriority;
    pstSndSettings->bBypass = pTrack->bFifoBypass;
#ifdef HI_AUDIO_AI_SUPPORT
    pstSndSettings->bAttAi = pTrack->bAttAi;
    pstSndSettings->hAi = pTrack->hAi;
#endif
    pstSndSettings->bAlsaTrack = pTrack->bAlsaTrack;
    //pstSndSettings->bDuplicate = pTrack->bDuplicate;
    //pstSndSettings->enDuplicatePort = pTrack->enDuplicatePort;

    return HI_SUCCESS;
}

HI_S32 TRACK_RestoreSetting(SND_CARD_STATE_S* pCard, HI_U32 u32TrackID, SND_TRACK_SETTINGS_S* pstSndSettings)
{
    SND_TRACK_STATE_S* pTrack;
    pTrack = (SND_TRACK_STATE_S*)pCard->pSndTrack[u32TrackID];
    TRACK_SetAipFiFoBypass(pCard, u32TrackID, pstSndSettings->bBypass);
    if (SND_TRACK_STATUS_START == pstSndSettings->enCurnStatus)
    {
        TRACK_Start(pCard, u32TrackID);
    }
    else if (SND_TRACK_STATUS_STOP == pstSndSettings->enCurnStatus)
    {
        TRACK_Stop(pCard, u32TrackID);
    }
    else if (SND_TRACK_STATUS_PAUSE == pstSndSettings->enCurnStatus)
    {
        TRACK_Pause(pCard, u32TrackID);
    }

    TRACK_SetSpeedAdjust(pCard, u32TrackID, pstSndSettings->enType, pstSndSettings->s32Speed);
    TRACK_SetMute(pCard, u32TrackID, pstSndSettings->bMute);
    TRACK_SetPriority(pCard, u32TrackID, pstSndSettings->bPriority);
    TRACK_SetAbsGain(pCard, u32TrackID, &pstSndSettings->stTrackAbsGain);
    TRACK_SetChannelMode(pCard, u32TrackID, &pstSndSettings->enChannelMode);

    //TRACK_SetPrescale(pCard, u32TrackID, &pstSndSettings->stPrescale);

    return HI_SUCCESS;
}

#if (1 == HI_PROC_SUPPORT)
HI_S32 Track_ReadProc( struct seq_file* p, SND_CARD_STATE_S* pCard )
{
    SND_TRACK_STATE_S* pTrack;
    SND_AIP_TYPE_E     enAip;
    AOE_AIP_CHN_ATTR_S stAipAttr;
    HI_BOOL bAipFifoBypass = HI_FALSE;
    HI_U32 i;
    HI_U32 u32DelayMs;

    for (i = 0; i < AO_MAX_TOTAL_TRACK_NUM; i++)
    {
        if (pCard->uSndTrackInitFlag & ((HI_U32)1L << i))
        {
            pTrack = (SND_TRACK_STATE_S*)pCard->pSndTrack[i];
            PROC_PRINT(p,
                       /*"Track(%d): Type(%s%s), Status(%s), Weight(%.3d/%.3d%s), Prescale(%s%d.%ddB), ChannelMode(%s), Mute(%s)",*/
                       "Track(%d): Type(%s%s), Status(%s), Weight(%.3d/%.3d%s), ChannelMode(%s), Mute(%s)",
                       pTrack->TrackId,
                       AUTIL_Track2Name(pTrack->stUserTrackAttr.enTrackType),
                       (HI_CHAR*)((HI_TRUE == pTrack->bAlsaTrack) ? "(alsa)" : ""),
                       (HI_CHAR*)((SND_TRACK_STATUS_START == pTrack->enCurnStatus) ? "start" : ((SND_TRACK_STATUS_STOP == pTrack->enCurnStatus) ? "stop" : "pause")),
                       pTrack->stTrackAbsGain.s32GainL,
                       pTrack->stTrackAbsGain.s32GainR,
                       (HI_TRUE == pTrack->stTrackAbsGain.bLinearMode) ? "" : "dB",
#if 0
                       (0 == pTrack->stUserPrescale.s32IntegerGain && pTrack->stUserPrescale.s32DecimalGain < 0) ? "-" : "",
                       pTrack->stUserPrescale.s32IntegerGain,
                       (pTrack->stUserPrescale.s32DecimalGain < 0) ? (-pTrack->stUserPrescale.s32DecimalGain) : pTrack->stUserPrescale.s32DecimalGain,
#endif
                       AUTIL_TrackMode2Name(pTrack->enChannelMode),
                       (HI_FALSE == pTrack->bMute) ? "off" : "on");
#ifdef HI_AUDIO_AI_SUPPORT
            if (HI_TRUE == pTrack->bAttAi)
            {
                PROC_PRINT(p, ", AttachAi(0x%x)", pTrack->hAi);
            }
#endif

            if (HI_UNF_SND_TRACK_TYPE_MASTER == pTrack->stUserTrackAttr.enTrackType)
            {
                PROC_PRINT(p, ", StartThresHold(%.3dms)", pTrack->stUserTrackAttr.u32StartThresholdMs);
            }

            PROC_PRINT(p, "\n");

            PROC_PRINT(p,
               "          SpeedRate(%.2d), AddMuteFrames(%.4d), SendCnt(Try/OK)(%.6u/%.6u), PauseResumeMuteNum(%.4d)\n",
                       pTrack->s32UserSpeedRate,
                       pTrack->u32AddMuteFrameNum,
                       pTrack->u32SendTryCnt,
                       pTrack->u32SendCnt,
                       pTrack->u32AddPauseResumeNum);
            for (enAip = SND_AIP_TYPE_PCM; enAip < SND_AIP_TYPE_BUTT; enAip++)
            {
                if ((SND_AIP_TYPE_PCM == enAip) || (HI_UNF_SND_TRACK_TYPE_MASTER == pTrack->stUserTrackAttr.enTrackType))
                {
                    if (((SND_AIP_TYPE_PCM == enAip || SND_AIP_TYPE_MC_PCM == enAip ||  SND_AIP_TYPE_ASSOC_PCM == enAip ) && (HI_FALSE == TrackCheckIsPcmOutput(pCard)))
                        || (SND_AIP_TYPE_SPDIF_RAW == enAip && SND_SPDIF_MODE_PCM >= pCard->enSpdifPassthrough)
                        || (SND_AIP_TYPE_HDMI_RAW == enAip && SND_HDMI_MODE_PCM >= pCard->enHdmiPassthrough)
#if 0
                        || (SND_AIP_TYPE_MC_PCM == enAip && HI_FALSE == pCard->enPcmMcStart)
                        || (SND_AIP_TYPE_ASSOC_PCM == enAip && HI_FALSE == pCard->enPcmAssocStart)
#else
                        || SND_AIP_TYPE_MC_PCM == enAip
                        || SND_AIP_TYPE_ASSOC_PCM == enAip
#endif
                    )
                    {
                        continue;
                    }

                    HAL_AOE_AIP_GetAttr(pTrack->enAIP[enAip], &stAipAttr);
                    HAL_AOE_AIP_GetFiFoBypass(pTrack->enAIP[enAip], &bAipFifoBypass);
                    PROC_PRINT(p,
                                "*AIP(%x): Engine(%s), SampleRate(%.6d), Channel(%.2d), BitWidth(%2d), DataFormat(%s), Priority(%s), FifoBypass(%s)\n",
                                (HI_U32)pTrack->enAIP[enAip],
                                AUTIL_Aip2Name(enAip),
                                stAipAttr.stBufInAttr.u32BufSampleRate,
                                stAipAttr.stBufInAttr.u32BufChannels,
                                stAipAttr.stBufInAttr.u32BufBitPerSample,
                                AUTIL_Format2Name(stAipAttr.stBufInAttr.u32BufDataFormat),
                                (HI_FALSE == stAipAttr.stBufInAttr.bMixPriority)?"low":"high",
                                (HI_FALSE == bAipFifoBypass)?"off":"on");

                    HAL_AOE_AIP_GetBufDelayMs(pTrack->enAIP[enAip], &u32DelayMs);
                    PROC_PRINT(p,
                               "        EmptyCnt(%.6u), EmptyWarningCnt(%.6u), Latency/Threshold(%.3dms/%.3dms)\n",
                               0,  //verify
                               0,  //verify
                               u32DelayMs,
                               stAipAttr.stBufInAttr.u32BufLatencyThdMs);
                }
            }
            PROC_PRINT(p, "\n");
        }
    }

    return HI_SUCCESS;
}

HI_S32 Track_WriteProc(SND_CARD_STATE_S* pCard, HI_CHAR* pcBuf)
{
    HI_U32 u32TrackId = AO_MAX_TOTAL_TRACK_NUM;
    HI_U32 u32Val1;    //u32Val2 = 0;
    HI_CHAR* pcMuteCmd = "mute";
    //HI_CHAR* pcPrescaleCmd = "prescale";
    HI_CHAR* pcWeightCmd = "weight";
    HI_CHAR* pcOnCmd = "on";
    HI_CHAR* pcOffCmd = "off";
    HI_CHAR* pcdBUnit = "dB";
    HI_BOOL  bNagetive = HI_FALSE;

    if (pcBuf[0] < '0' || pcBuf[0] > '9')//do not have param
    {
        HI_ERR_AO("\n");
        return HI_FAILURE;
    }
    u32TrackId = (HI_U32)simple_strtoul(pcBuf, &pcBuf, 10);
    if (u32TrackId >= AO_MAX_TOTAL_TRACK_NUM)
    {
        HI_ERR_AO("\n");
        return HI_FAILURE;
    }
    AO_STRING_SKIP_NON_BLANK(pcBuf);
    AO_STRING_SKIP_BLANK(pcBuf);

    if (strstr(pcBuf, pcMuteCmd))
    {
        pcBuf += strlen(pcMuteCmd);
        AO_STRING_SKIP_BLANK(pcBuf);
        if (strstr(pcBuf, pcOnCmd))
        {
            return TRACK_SetMute(pCard, u32TrackId, HI_TRUE);
        }
        else if (strstr(pcBuf, pcOffCmd))
        {
            return TRACK_SetMute(pCard, u32TrackId, HI_FALSE);
        }
        else
        {
            HI_ERR_AO("\n");
            return HI_FAILURE;
        }
    }
#if 0
    else if (strstr(pcBuf, pcPrescaleCmd))
    {
        HI_UNF_SND_PRECIGAIN_ATTR_S stPreciGain;
        pcBuf += strlen(pcPrescaleCmd);
        AO_STRING_SKIP_BLANK(pcBuf);
        if (strstr(pcBuf, pcdBUnit))
        {
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

            stPreciGain.s32IntegerGain = (HI_TRUE == bNagetive) ? (-u32Val1) : u32Val1;
            stPreciGain.s32DecimalGain = (HI_TRUE == bNagetive) ? (-u32Val2) : u32Val2;

            return TRACK_SetPrescale(pCard, u32TrackId, &stPreciGain);
        }
        else
        {
            return HI_FAILURE;
        }
    }
#endif
    else if (strstr(pcBuf, pcWeightCmd))
    {
        HI_UNF_SND_GAIN_ATTR_S stTrackGain;
        pcBuf += strlen(pcWeightCmd);
        AO_STRING_SKIP_BLANK(pcBuf);
        if (strstr(pcBuf, pcdBUnit))
        {
            if (pcBuf[0] == '-')
            {
                bNagetive = HI_TRUE;
                pcBuf++;
            }
            u32Val1 = (HI_U32)simple_strtoul(pcBuf, &pcBuf, 10);
            stTrackGain.bLinearMode = HI_FALSE;
            stTrackGain.s32Gain = (HI_TRUE == bNagetive) ? (-u32Val1) : u32Val1;
            return TRACK_SetWeight(pCard, u32TrackId, &stTrackGain);
        }
        else
        {
            HI_ERR_AO("\n");
            return HI_FAILURE;
        }
    }
    else
    {
        HI_ERR_AO("\n");
        return HI_FAILURE;
    }
}

HI_S32 TRACK_WriteProc_SaveData(SND_CARD_STATE_S* pCard, HI_U32 u32TrackID, SND_DEBUG_CMD_CTRL_E enCmd)
{
    SND_TRACK_STATE_S* pTrack;
    HI_CHAR szPath[AO_TRACK_PATH_NAME_MAXLEN + AO_TRACK_FILE_NAME_MAXLEN] = {0};
    struct tm now;

    pTrack = (SND_TRACK_STATE_S*)pCard->pSndTrack[u32TrackID];
    if (!pTrack)
    {
        HI_ERR_AO("Track %d don't attach this sound\n");
        return HI_FAILURE;
    }

    if (HI_TRUE == pTrack->bAlsaTrack)
    {
        HI_ERR_AO("ALSA Track not support Echo WriteFile \n");
        return HI_FAILURE;
    }

    if (SND_DEBUG_CMD_CTRL_START == enCmd && SND_DEBUG_CMD_CTRL_STOP == pTrack->enSaveState)
    {
        if (HI_SUCCESS != HI_DRV_FILE_GetStorePath(szPath, AO_TRACK_PATH_NAME_MAXLEN))
        {
            HI_ERR_AO("get store path failed\n");
            return HI_FAILURE;
        }
        time_to_tm(get_seconds(), 0, &now);
        snprintf(szPath, sizeof(szPath), "%s/track%d_%02u_%02u_%02u.pcm", szPath, u32TrackID, now.tm_hour, now.tm_min, now.tm_sec);
        pTrack->fileHandle = HI_DRV_FILE_Open(szPath, 1);
        if (!pTrack->fileHandle)
        {
            HI_ERR_AO("open %s error\n", szPath);
            return HI_FAILURE;
        }
        pTrack->u32SaveCnt++;
    }
    if (SND_DEBUG_CMD_CTRL_STOP == enCmd && SND_DEBUG_CMD_CTRL_START == pTrack->enSaveState)
    {
        if (pTrack->fileHandle)
        {
            HI_DRV_FILE_Close(pTrack->fileHandle);
            pTrack->fileHandle = HI_NULL;
        }
    }

    pTrack->enSaveState = enCmd;

    return HI_SUCCESS;
}
#endif

HI_S32 TRACK_UpdateWptrPos(SND_CARD_STATE_S* pCard, HI_U32 u32TrackID, HI_U32* pu32WptrLen)    //for alsa
{
    SND_TRACK_STATE_S* pTrack;
    /*
    SND_TRACK_STREAM_ATTR_S stStreamAttr;
    STREAMMODE_CHANGE_ATTR_S stChange;
    HI_U32 Write = 0;
    */
    if (HI_NULL == pu32WptrLen)
    {
        return HI_FAILURE;
    }

    //todo , check attr


    pTrack = (SND_TRACK_STATE_S*)pCard->pSndTrack[u32TrackID];
    /*
    if (SND_TRACK_STATUS_START != pTrack->enCurnStatus)
    {
        HI_ERR_AO("Ao track status(%d) should be SND_TRACK_STATUS_START  \n", pTrack->enCurnStatus);
        //return HI_FAILURE;
    }
    */
    HAL_AOE_AIP_UpdateWritePos(pTrack->enAIP[SND_AIP_TYPE_PCM], pu32WptrLen);

    return  HI_SUCCESS;
}

HI_S32 TRACK_UpdateRptrPos(SND_CARD_STATE_S* pCard, HI_U32 u32TrackID, HI_U32* pu32RptrLen)    //for alsa
{
    SND_TRACK_STATE_S* pTrack;
    /*
    SND_TRACK_STREAM_ATTR_S stStreamAttr;
    STREAMMODE_CHANGE_ATTR_S stChange;
    HI_U32 Write = 0;
    */
    if (HI_NULL == pu32RptrLen)
    {
        return HI_FAILURE;
    }

    //todo , check attr


    pTrack = (SND_TRACK_STATE_S*)pCard->pSndTrack[u32TrackID];
    /*
    if (SND_TRACK_STATUS_START != pTrack->enCurnStatus)
    {
    	HI_ERR_AO("Ao track status(%d) should be SND_TRACK_STATUS_START  \n", pTrack->enCurnStatus);
    	//return HI_FAILURE;
    }
    */
    HAL_AOE_AIP_UpdateReadPos(pTrack->enAIP[SND_AIP_TYPE_PCM], pu32RptrLen);

    return	HI_SUCCESS;
}
HI_S32 TRACK_GetReadPos(SND_CARD_STATE_S* pCard, HI_U32 u32TrackID, HI_U32* pu32ReadPos)    //for alsa
{
    SND_TRACK_STATE_S* pTrack;
    /*
    SND_TRACK_STREAM_ATTR_S stStreamAttr;
    STREAMMODE_CHANGE_ATTR_S stChange;
    HI_U32 Write = 0;
    */
    if (HI_NULL == pu32ReadPos)
    {
        return HI_FAILURE;
    }

    //todo , check attr


    pTrack = (SND_TRACK_STATE_S*)pCard->pSndTrack[u32TrackID];
    /*
    if (SND_TRACK_STATUS_START != pTrack->enCurnStatus)
    {
        HI_ERR_AO("Ao track status(%d) should be SND_TRACK_STATUS_START  \n", pTrack->enCurnStatus);
        //return HI_FAILURE;
    }
    */
    HAL_AOE_AIP_GetReadPos(pTrack->enAIP[SND_AIP_TYPE_PCM], pu32ReadPos);

    return  HI_SUCCESS;
}


HI_S32 TRACK_FlushBuf(SND_CARD_STATE_S* pCard, HI_U32 u32TrackID)    //for alsa
{
    SND_TRACK_STATE_S* pTrack;
    //todo , check attr

    pTrack = (SND_TRACK_STATE_S*)pCard->pSndTrack[u32TrackID];
    HAL_AOE_AIP_FlushBuf(pTrack->enAIP[SND_AIP_TYPE_PCM]);

    return  HI_SUCCESS;
}
