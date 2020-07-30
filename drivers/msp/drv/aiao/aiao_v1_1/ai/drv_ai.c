/*******************************************************************************
 *              Copyright 2004 - 2014, Hisilicon Tech. Co., Ltd.
 *                           ALL RIGHTS RESERVED
 * FileName: ai_intf_k.c
 * Description: ai interface of module.
 *
 * History:
 * Version   Date         Author     DefectNum    Description
 * main\1    
 ********************************************************************************/

#include <asm/setup.h>
#include <linux/interrupt.h>

#include "hi_type.h"
#include "hi_drv_struct.h"
#include "hi_drv_dev.h"
#include "hi_drv_proc.h"

#include "hi_module.h"
#include "hi_drv_mmz.h"
#include "hi_drv_module.h"
#include "hi_drv_mem.h"
#include "hi_error_mpi.h"
#include "hi_drv_file.h"

#include "hal_aiao.h"
#include "audio_util.h"

#include "hi_drv_ai.h"

#include <sound/pcm.h>

#include "drv_ai_private.h"
#include "drv_ai_ioctl.h"
#include "hal_tianlai_adac_v510.h"

HI_S32 AO_Track_GetDelayMs(HI_U32 u32TrackID, HI_U32 *pu32DelayMs);
HI_S32 AO_Track_SetDre(HI_U32 u32TrackID, HI_BOOL bDre);

static HI_S32 AI_RegProc(HI_U32 u32Ai);
static HI_VOID AI_UnRegProc(HI_U32 u32Ai);

#define HI_AI_DRV_SUSPEND_SUPPORT

#define AC3_BITS_LENGTH_INBYTES       (1536*4) 
#define EAC3_BITS_LENGTH_INBYTES      (1536*4*4) 
#define TUREHD_BITS_LENGTH_INBYTES    61440

//#define MAX_EAC3_IEC_OFFSET_SIZE  24576   //?????
#define IEC61937_SYNCWORD1 0xF872
#define IEC61937_SYNCWORD2 0x4E1F
#define DATA_TYPE_AC3        0x0001       /* the data type code of AC3, see 61917-3 */
#define DATA_TYPE_EAC3       0x0015       /* the data type code of EAC3, see 61917-3 */

#define SYNC_LENGTH          8
#define DTSHD_HEADER_SIZE    12


#define DATA_DTS_TYPE_I 0x000b       /* the data type code of DTS, see 61917-2 */
#define DATA_DTS_TYPE_II 0x000c       /* the data type code of DTS, see 61917-2 */
#define DATA_DTS_TYPE_III 0x000d       /* the data type code of DTS, see 61917-2 */
#define DATA_DTS_TYPE_IV 0x0011       /* the data type code of DTS, see 61917-2 */
/* the repetition period between 2 data-burst of DTS, also indicate the out buffer length */
#define DTS_BITS_LENGTH_INBYTES_TYPE_I (512*4)
#define DTS_BITS_LENGTH_INBYTES_TYPE_II (1024*4)
#define DTS_BITS_LENGTH_INBYTES_TYPE_III (2048*4)
#define DTS_BITS_LENGTH_INBYTES_TYPE_CD (1000*4)
#define DTSHD_BITS_LENGTH_INBYTES 32768

#define DTS_CD_SYNC_BE 0x1FFFE800
#define DTS_CD_SYNC_LE 0xFF1F00E8

#define DTS_CD_SYNC1_BE 0x1FFF
#define DTS_CD_SYNC2_BE 0xE800

#define DTS_CD_SYNC1_LE 0xFF1F
#define DTS_CD_SYNC2_LE 0x00E8


#define FIND_SYNC_MAX_CNT 1
#define NULL_DATA_TYPE    0
#define PAUSE_DATA_TYPE   3

DEFINE_SEMAPHORE(g_AIMutex);

static atomic_t g_AIOpenCnt = ATOMIC_INIT(0);

struct file  g_file;

//AI Resource
static AI_GLOBAL_RESOURCE_S  g_pstGlobalAIRS =
{
    .pstProcParam        = HI_NULL,
    .stExtFunc           =
    {
        .pfnAI_DrvResume = AI_DRV_Resume,
        .pfnAI_DrvSuspend = AI_DRV_Suspend,
    }
};

#ifdef HI_ALSA_AI_SUPPORT
AI_ALSA_Param_S g_stAlsaAttr;
#endif

static HI_BOOL AICheckPortValid(HI_UNF_AI_E enAiPort)
{
#if    defined(CHIP_TYPE_hi3716cv200)   \
    || defined(CHIP_TYPE_hi3716mv400)   \
    || defined(CHIP_TYPE_hi3718cv100)   \
    || defined(CHIP_TYPE_hi3719cv100)   \
    || defined(CHIP_TYPE_hi3719mv100_a) \
    || defined(CHIP_TYPE_hi3798mv100)   \
    || defined(CHIP_TYPE_hi3796mv100)   \
    || defined(CHIP_TYPE_hi3798cv200_a) \
    || defined(CHIP_TYPE_hi3798cv200_b) \
    || defined(CHIP_TYPE_hi3798cv200)   \
    || defined(CHIP_TYPE_hi3798hv100)
    
    if((HI_UNF_AI_I2S0 != enAiPort) && (HI_UNF_AI_I2S1 != enAiPort))
    {
        HI_ERR_AI("just support I2S0 and I2S1 Port!\n");
        return HI_FALSE;
    }
#elif    defined(CHIP_TYPE_hi3719mv100)  \
      || defined(CHIP_TYPE_hi3718mv100)  \
      || defined(CHIP_TYPE_hi3716mv420)
    if (HI_UNF_AI_I2S0 != enAiPort)
    {
        HI_ERR_AI("just support I2S0 Port!\n");
        return HI_FALSE;
    }
#elif defined(CHIP_TYPE_hi3751v100)  || defined(CHIP_TYPE_hi3751v100b)
    if((HI_UNF_AI_I2S0 != enAiPort) &&(HI_UNF_AI_I2S1 != enAiPort) && (HI_UNF_AI_SIF0 != enAiPort) 
        && (HI_UNF_AI_ADC0 != enAiPort) && (HI_UNF_AI_ADC1 != enAiPort) && (HI_UNF_AI_ADC2 != enAiPort)
        && (HI_UNF_AI_ADC3 != enAiPort) && (HI_UNF_AI_ADC4 != enAiPort) && (HI_UNF_AI_HDMI3 != enAiPort) 
        && (HI_UNF_AI_HDMI0 != enAiPort) && (HI_UNF_AI_HDMI1 != enAiPort)&& (HI_UNF_AI_HDMI2 != enAiPort))
    {
        HI_ERR_AI("just support I2S0, I2S1 , SIF, HDMI, ADC0/ADC1/ADC2/ADC3/ADC4 Port!\n");
        return HI_FALSE;
    }
#elif defined(CHIP_TYPE_hi3751v600) || defined(CHIP_TYPE_hi3751lv500)
    if((HI_UNF_AI_I2S0 != enAiPort) &&(HI_UNF_AI_I2S1 != enAiPort) && (HI_UNF_AI_SIF0 != enAiPort) 
        && (HI_UNF_AI_ADC0 != enAiPort) && (HI_UNF_AI_ADC1 != enAiPort) && (HI_UNF_AI_ADC2 != enAiPort)
        && (HI_UNF_AI_ADC3 != enAiPort) && (HI_UNF_AI_HDMI0 != enAiPort) 
        && (HI_UNF_AI_HDMI1 != enAiPort)&& (HI_UNF_AI_HDMI2 != enAiPort))
    {
        HI_ERR_AI("just support I2S0, I2S1 , SIF, HDMI, ADC0/ADC1/ADC2/ADC4 Port!\n");
        return HI_FALSE;
    }
#elif defined(CHIP_TYPE_hi3751av500) 
    if((HI_UNF_AI_I2S1 != enAiPort) && (HI_UNF_AI_SIF0 != enAiPort) 
        && (HI_UNF_AI_ADC0 != enAiPort) && (HI_UNF_AI_ADC1 != enAiPort) && (HI_UNF_AI_ADC2 != enAiPort)
        && (HI_UNF_AI_ADC3 != enAiPort) && (HI_UNF_AI_HDMI0 != enAiPort) 
        && (HI_UNF_AI_HDMI1 != enAiPort)&& (HI_UNF_AI_HDMI2 != enAiPort))
    {
        HI_ERR_AI("just support I2S0, I2S1 , SIF, HDMI, ADC0/ADC1/ADC2/ADC4 Port!\n");
        return HI_FALSE;
    }    
#else
    #error YOU MUST DEFINE  CHIP_TYPE!
#endif

    return HI_TRUE;
}

static HI_BOOL AICheckPortUsed(HI_UNF_AI_E enAiPort)
{
    HI_U32 i;
    
    for(i = 0; i < AI_MAX_TOTAL_NUM; i++)
    {
        if(g_pstGlobalAIRS.pstAI_ATTR_S[i])
        {
            if(g_pstGlobalAIRS.pstAI_ATTR_S[i]->enAiPort == enAiPort)
            {
                HI_ERR_AI("This port has been occupied!\n");
                return HI_FALSE;
            }
                 
        }
    }

    return HI_TRUE;
}

static HI_VOID AIGetChannelsAndBitDepth(HI_UNF_AI_E enAiPort, HI_UNF_AI_ATTR_S *pstAiAttr,
                                    HI_U32 *pu32Channel, HI_U32 *pu32BitDepth)
{
    switch(enAiPort)
    {
        case HI_UNF_AI_I2S0:
        case HI_UNF_AI_I2S1:    
            *pu32Channel = pstAiAttr->unAttr.stI2sAttr.stAttr.enChannel;
            *pu32BitDepth = pstAiAttr->unAttr.stI2sAttr.stAttr.enBitDepth;
            return;

        case HI_UNF_AI_HDMI0:
        case HI_UNF_AI_HDMI1:
        case HI_UNF_AI_HDMI2:
        case HI_UNF_AI_HDMI3:
            *pu32Channel = pstAiAttr->unAttr.stHDMIAttr.enChannel;
            *pu32BitDepth = pstAiAttr->unAttr.stHDMIAttr.enBitDepth;
            return;
        
        case HI_UNF_AI_ADC0:
        case HI_UNF_AI_ADC1:
        case HI_UNF_AI_ADC2:
        case HI_UNF_AI_ADC3:
        case HI_UNF_AI_ADC4:
        case HI_UNF_AI_SIF0:
            *pu32Channel = HI_UNF_I2S_CHNUM_2;
            *pu32BitDepth = HI_UNF_I2S_BIT_DEPTH_16;
            return;        
        default:
            return;
    }
}

HI_S32 AI_GetDefaultAttr(HI_UNF_AI_E enAiPort, HI_UNF_AI_ATTR_S *pstAiAttr)
{
    if(HI_FALSE == AICheckPortValid(enAiPort))
    {
        return HI_FAILURE;
    }

    pstAiAttr->enSampleRate = HI_UNF_SAMPLE_RATE_48K;
    pstAiAttr->u32PcmFrameMaxNum = AI_BUFF_FRAME_NUM_DF;
    pstAiAttr->u32PcmSamplesPerFrame = AI_SAMPLE_PERFRAME_DF;
    if(HI_UNF_AI_I2S0 == enAiPort || HI_UNF_AI_I2S1 == enAiPort)
    {
        pstAiAttr->unAttr.stI2sAttr.stAttr.bMaster = HI_TRUE;
        pstAiAttr->unAttr.stI2sAttr.stAttr.enI2sMode = HI_UNF_I2S_STD_MODE;
        pstAiAttr->unAttr.stI2sAttr.stAttr.enMclkSel = HI_UNF_I2S_MCLK_256_FS;
        pstAiAttr->unAttr.stI2sAttr.stAttr.enBclkSel = HI_UNF_I2S_BCLK_4_DIV;
        pstAiAttr->unAttr.stI2sAttr.stAttr.enChannel = HI_UNF_I2S_CHNUM_2;
        pstAiAttr->unAttr.stI2sAttr.stAttr.enBitDepth = HI_UNF_I2S_BIT_DEPTH_16;
        pstAiAttr->unAttr.stI2sAttr.stAttr.bPcmSampleRiseEdge = HI_TRUE;
        pstAiAttr->unAttr.stI2sAttr.stAttr.enPcmDelayCycle = HI_UNF_I2S_PCM_0_DELAY;
    }
    else if(HI_UNF_AI_ADC0 == enAiPort || HI_UNF_AI_ADC1 == enAiPort || 
        HI_UNF_AI_ADC2 == enAiPort || HI_UNF_AI_ADC3 == enAiPort || HI_UNF_AI_ADC4 == enAiPort)
    {
        pstAiAttr->unAttr.stAdcAttr.bByPass = HI_FALSE;
    }
    else if(HI_UNF_AI_HDMI0 == enAiPort || HI_UNF_AI_HDMI1 == enAiPort || 
        HI_UNF_AI_HDMI2 == enAiPort || HI_UNF_AI_HDMI3 == enAiPort)
    {
        pstAiAttr->unAttr.stHDMIAttr.enSampleRate = HI_UNF_SAMPLE_RATE_48K;
        pstAiAttr->unAttr.stHDMIAttr.enBitDepth = HI_UNF_I2S_BIT_DEPTH_16;
        pstAiAttr->unAttr.stHDMIAttr.enChannel = HI_UNF_I2S_CHNUM_2;
        pstAiAttr->unAttr.stHDMIAttr.enHdmiAudioDataFormat = HI_UNF_AI_HDMI_FORMAT_LPCM;
    }
    
    return HI_SUCCESS;
}

#ifdef HI_ALSA_AI_SUPPORT    
HI_S32 AIGetProcStatistics(AIAO_IsrFunc **pFunc) //For ALSA
{
    AIAO_PORT_USER_CFG_S pAttr;
    
    HAL_AIAO_P_GetTxI2SDfAttr(AIAO_PORT_TX0,&pAttr);  //pIsrFunc is the same for all ports

    *pFunc = pAttr.pIsrFunc;
    
    return HI_SUCCESS;
}

HI_S32 AIGetEnport(HI_HANDLE hAi,AIAO_PORT_ID_E *enPort)  //For ALSA
{
    AI_CHANNEL_STATE_S *state = HI_NULL;    
    hAi &= AI_CHNID_MASK;

    state = g_pstGlobalAIRS.pstAI_ATTR_S[hAi];
    if(state)
        *enPort = state->enPort;
		
    return HI_SUCCESS;
}
#endif

static HI_S32 AICheckI2sAttr(HI_UNF_AI_I2S_ATTR_S  *pstI2sAttr)
{
    CHECK_AI_MCLKDIV(pstI2sAttr->stAttr.enMclkSel);
    CHECK_AI_BCLKDIV(pstI2sAttr->stAttr.enBclkSel);
    CHECK_AI_CHN(pstI2sAttr->stAttr.enChannel);
    CHECK_AI_BITDEPTH(pstI2sAttr->stAttr.enBitDepth);
    CHECK_AI_PCMDELAY(pstI2sAttr->stAttr.enPcmDelayCycle);

    if(HI_UNF_I2S_MODE_BUTT <= pstI2sAttr->stAttr.enI2sMode)
    {
        HI_ERR_AI("dont support I2sMode(%d)\n",pstI2sAttr->stAttr.enI2sMode);
        return HI_ERR_AI_INVALID_PARA;
    }

    if(HI_UNF_I2S_MCLK_BUTT <= pstI2sAttr->stAttr.enMclkSel)
    {
        HI_ERR_AI("dont support I2S MclkSel(%d)\n", pstI2sAttr->stAttr.enBclkSel);
        return HI_ERR_AI_INVALID_PARA;
    }

    return HI_SUCCESS;
}

static HI_S32 AICheckHdmiAttr(HI_UNF_AI_HDMI_ATTR_S  *pstHdmiAttr)
{
#if defined (CHIP_TYPE_hi3751v600) || defined (CHIP_TYPE_hi3751lv500) || defined(CHIP_TYPE_hi3751av500) 
    if((g_pstGlobalAIRS.u32BitFlag_AI & ((HI_U32)1<<AI_I2S1_MSK)) || (g_pstGlobalAIRS.u32BitFlag_AI & ((HI_U32)1<<AI_ADAC_MSK)))
    {
        HI_ERR_AO("SIF, ADC and HDMIRX can not coexist!\n");
        return HI_FAILURE;
    }
#endif
    CHECK_AI_CHN(pstHdmiAttr->enChannel);
    CHECK_AI_BITDEPTH(pstHdmiAttr->enBitDepth);
    CHECK_AI_HdmiDataFormat(pstHdmiAttr->enHdmiAudioDataFormat);

    return HI_SUCCESS;
}

static HI_S32 AICheckAdcAttr(HI_UNF_AI_ATTR_S *pstAiAttr)
{
#if defined (CHIP_TYPE_hi3751v600) || defined (CHIP_TYPE_hi3751lv500) || defined(CHIP_TYPE_hi3751av500) 
    if((g_pstGlobalAIRS.u32BitFlag_AI & ((HI_U32)1<<AI_I2S1_MSK)) || (g_pstGlobalAIRS.u32BitFlag_AI & ((HI_U32)1<<AI_HDMI_MSK)))
    {
        HI_ERR_AO("SIF, ADC and HDMIRX can not coexist!\n");
        return HI_FAILURE;
    }
#endif
    if(HI_UNF_SAMPLE_RATE_48K != pstAiAttr->enSampleRate)
    {
        HI_ERR_AI("ADC port only support 48k samplerate!\n");
        return HI_FAILURE;
    }
    
    return HI_SUCCESS;
}

static HI_S32 AICheckSifAttr(HI_UNF_AI_E enAiPort)
{
#if defined (CHIP_TYPE_hi3751v600) || defined (CHIP_TYPE_hi3751lv500) || defined(CHIP_TYPE_hi3751av500) 
    if((g_pstGlobalAIRS.u32BitFlag_AI & ((HI_U32)1<<AI_ADAC_MSK)) || (g_pstGlobalAIRS.u32BitFlag_AI & ((HI_U32)1<<AI_HDMI_MSK)))
    {
        HI_ERR_AO("SIF, ADC and HDMIRX can not coexist!\n");
        return HI_FAILURE;
    }
#endif

    return HI_SUCCESS;
}

static HI_S32 AICheckAttr(HI_UNF_AI_E enAiPort, HI_UNF_AI_ATTR_S *pstAiAttr)
{
    HI_S32 Ret = HI_SUCCESS;
    CHECK_AI_SAMPLERATE(pstAiAttr->enSampleRate);
    
    switch(enAiPort)
    {
        case HI_UNF_AI_I2S0:
        case HI_UNF_AI_I2S1:
            Ret = AICheckI2sAttr(&pstAiAttr->unAttr.stI2sAttr);
            break;
        case HI_UNF_AI_HDMI0:
        case HI_UNF_AI_HDMI1:
        case HI_UNF_AI_HDMI2:
        case HI_UNF_AI_HDMI3:
            Ret = AICheckHdmiAttr(&pstAiAttr->unAttr.stHDMIAttr);
            break;
        case HI_UNF_AI_ADC0:
        case HI_UNF_AI_ADC1:
        case HI_UNF_AI_ADC2:
        case HI_UNF_AI_ADC3:
        case HI_UNF_AI_ADC4:
            Ret = AICheckAdcAttr(pstAiAttr);
            break;
        case HI_UNF_AI_SIF0:
            Ret = AICheckSifAttr(enAiPort);
            break;
        default:
            break;
    }

    return Ret;
}

static HI_VOID AISetPortIfAttr(HI_UNF_AI_E enAiPort, HI_UNF_AI_ATTR_S *pstAiAttr, AIAO_IfAttr_S *pstIfAttr)
{
    pstIfAttr->enRate = (AIAO_SAMPLE_RATE_E)(pstAiAttr->enSampleRate);

    if(HI_UNF_AI_I2S0 == enAiPort || HI_UNF_AI_I2S1 == enAiPort)
    {
        if(pstAiAttr->unAttr.stI2sAttr.stAttr.bMaster)
        {
            pstIfAttr->enCrgMode = AIAO_CRG_MODE_DUPLICATE;
            if(HI_UNF_AI_I2S0 == enAiPort)
            {
                pstIfAttr->eCrgSource = AIAO_TX_CRG0;
            }
            if(HI_UNF_AI_I2S1 == enAiPort)
            {
                pstIfAttr->eCrgSource = AIAO_TX_CRG1;
            }  
            
            pstIfAttr->u32BCLK_DIV = pstAiAttr->unAttr.stI2sAttr.stAttr.enBclkSel;
            pstIfAttr->u32FCLK_DIV = AUTIL_BclkFclkDiv(pstAiAttr->unAttr.stI2sAttr.stAttr.enMclkSel, pstAiAttr->unAttr.stI2sAttr.stAttr.enBclkSel);
        }
        else
        {
            pstIfAttr->enCrgMode = AIAO_CRG_MODE_SLAVE;
        }
        pstIfAttr->enI2SMode = AUTIL_I2S_MODE_UNF2AIAO(pstAiAttr->unAttr.stI2sAttr.stAttr.enI2sMode);
        pstIfAttr->enChNum = AUTIL_CHNUM_UNF2AIAO(pstAiAttr->unAttr.stI2sAttr.stAttr.enChannel);
        pstIfAttr->enBitDepth = AUTIL_BITDEPTH_UNF2AIAO(pstAiAttr->unAttr.stI2sAttr.stAttr.enBitDepth);
        pstIfAttr->u32PcmDelayCycles = pstAiAttr->unAttr.stI2sAttr.stAttr.enPcmDelayCycle;
        if(pstAiAttr->unAttr.stI2sAttr.stAttr.bPcmSampleRiseEdge == HI_TRUE)
        {
            pstIfAttr->enRiseEdge = AIAO_MODE_EDGE_RISE;
        }
        else
        {
            pstIfAttr->enRiseEdge = AIAO_MODE_EDGE_FALL;
        }
    }
    else if(HI_UNF_AI_HDMI0 == enAiPort || HI_UNF_AI_HDMI1 == enAiPort 
    || HI_UNF_AI_HDMI2 == enAiPort || HI_UNF_AI_HDMI3 == enAiPort)
    {
        pstIfAttr->enChNum = AUTIL_CHNUM_UNF2AIAO(pstAiAttr->unAttr.stHDMIAttr.enChannel);
        pstIfAttr->enBitDepth = AUTIL_BITDEPTH_UNF2AIAO(pstAiAttr->unAttr.stHDMIAttr.enBitDepth);
    }
    else if(HI_UNF_AI_ADC0 == enAiPort || HI_UNF_AI_ADC1 == enAiPort 
    || HI_UNF_AI_ADC2 == enAiPort || HI_UNF_AI_ADC3 == enAiPort || HI_UNF_AI_ADC4 == enAiPort)
    {
        
    }
    
    return;
}

static void Port2TianlaiSel(HI_UNF_AI_E enAiPort, HI_BOOL bByPass)
{
    S5_TIANLAI_LINEIN_SEL_E enSel = S5_TIANLAI_LINEIN_SEL_BUTT;
    switch (enAiPort)
    {
        case HI_UNF_AI_ADC0:
            enSel = S5_TIANLAI_LINEIN_SEL_MIC;
            break;
        case HI_UNF_AI_ADC1:
            enSel = S5_TIANLAI_LINEIN_SEL_L1;
            break;
        case HI_UNF_AI_ADC2:
            enSel = S5_TIANLAI_LINEIN_SEL_L2;
            break;
        case HI_UNF_AI_ADC3:
            enSel = S5_TIANLAI_LINEIN_SEL_L3;
            break;
        case HI_UNF_AI_ADC4: 
            enSel = S5_TIANLAI_LINEIN_SEL_L4;
            break;
        default:
            break;
    }

#ifdef HI_TIANLAI_V510   
    HAL_TIANLAI_V510_SetLineInSuorce(enSel, bByPass, HI_TRUE);
#endif
}

static HI_S32 AICreateChn(HI_UNF_AI_E enAiPort, HI_UNF_AI_ATTR_S *pstAttr, HI_BOOL bAlsa, HI_VOID *pAlsaPara, AI_CHANNEL_STATE_S *state)
{
    HI_S32 Ret;
    HI_U32 u32BoardI2sNum = 0;
    AIAO_PORT_USER_CFG_S stHwPortAttr;
    
    AIAO_PORT_ID_E enPort = AIAO_PORT_BUTT;
    
#ifdef HI_ALSA_AI_SUPPORT    
    AI_ALSA_Param_S *pstAlsaAttr = HI_NULL;
#endif    

    switch(enAiPort)
    {
#if defined (HI_I2S0_SUPPORT)     
        case HI_UNF_AI_I2S0:
            u32BoardI2sNum = 0;
            HAL_AIAO_P_GetBorardRxI2SDfAttr(u32BoardI2sNum, &enPort, &stHwPortAttr);
            break;
#endif   

#if defined (HI_I2S1_SUPPORT)     
        case HI_UNF_AI_I2S1:
            u32BoardI2sNum = 1;
            HAL_AIAO_P_GetBorardRxI2SDfAttr(u32BoardI2sNum, &enPort, &stHwPortAttr);
            break;
#endif            
        case HI_UNF_AI_ADC0:
        case HI_UNF_AI_ADC1:
        case HI_UNF_AI_ADC2:
        case HI_UNF_AI_ADC3:
        case HI_UNF_AI_ADC4:
            Port2TianlaiSel(enAiPort, pstAttr->unAttr.stAdcAttr.bByPass);
#if defined (CHIP_TYPE_hi3751v600) || defined (CHIP_TYPE_hi3751lv500) || defined(CHIP_TYPE_hi3751av500) 
            enPort = AIAO_PORT_RX3;
#elif defined (CHIP_TYPE_hi3751v100) || defined (CHIP_TYPE_hi3751v100b)
            enPort = AIAO_PORT_RX2;
#else
#endif
            HAL_AIAO_P_GetRxAdcDfAttr(enPort, &stHwPortAttr);
            break;
        case HI_UNF_AI_HDMI0:
        case HI_UNF_AI_HDMI1:      
        case HI_UNF_AI_HDMI2:
        case HI_UNF_AI_HDMI3:
#if  defined(CHIP_TYPE_hi3798cv200_a) || defined(CHIP_TYPE_hi3798cv200_b)
            enPort = AIAO_PORT_RX2;
#else
            enPort = AIAO_PORT_RX3;
#endif
            if((HI_UNF_AI_HDMI_FORMAT_LBR == pstAttr->unAttr.stHDMIAttr.enHdmiAudioDataFormat)||  \
               (HI_UNF_AI_HDMI_FORMAT_HBR == pstAttr->unAttr.stHDMIAttr.enHdmiAudioDataFormat))
            {
                state->bIsBitsStream = HI_TRUE;
                //state->enDataType = pstAttr->unAttr.stHDMIAttr.enHdmiAudioDataType;
            }

            HAL_AIAO_P_GetRxHdmiDfAttr(enPort, &stHwPortAttr);

#if defined (CHIP_TYPE_hi3751v600) || defined (CHIP_TYPE_hi3751lv500) || defined(CHIP_TYPE_hi3751av500)      
            if (HI_UNF_AI_HDMI2 == enAiPort)  
            {  
                stHwPortAttr.stIfAttr.enSource = AIAO_RX4;
                stHwPortAttr.stIfAttr.eCrgSource = AIAO_RX_CRG4;
            }
#endif
            break;
        case HI_UNF_AI_SIF0:
#if defined (CHIP_TYPE_hi3751v600) || defined (CHIP_TYPE_hi3751lv500) || defined(CHIP_TYPE_hi3751av500) 
            enPort = AIAO_PORT_RX3;
#elif defined (CHIP_TYPE_hi3751v100) || defined (CHIP_TYPE_hi3751v100b)
            enPort = AIAO_PORT_RX1;
#else
#endif
            HAL_AIAO_P_GetRxSifDfAttr(enPort, &stHwPortAttr);
            break;
        default:
            HI_ERR_AI("Aiport is invalid!\n");
            return HI_ERR_AI_INVALID_PARA;
    }

    stHwPortAttr.stBufConfig.u32PeriodNumber = state->stRbfMmz.u32Size/stHwPortAttr.stBufConfig.u32PeriodBufSize;
#ifdef HI_ALSA_AI_SUPPORT
    if(bAlsa == HI_TRUE)
    {
        if(HI_NULL == pAlsaPara)
        {
            HI_ERR_AI("pAlsaPara is null!\n");
            return HI_ERR_AI_INVALID_PARA;
        }
        pstAlsaAttr = (AI_ALSA_Param_S*)pAlsaPara;
        stHwPortAttr.bExtDmaMem = HI_TRUE;
        stHwPortAttr.stExtMem.tBufPhyAddr = pstAlsaAttr->stBuf.tBufPhyAddr;
        stHwPortAttr.stExtMem.tBufVirAddr = pstAlsaAttr->stBuf.tBufVirAddr;
        stHwPortAttr.stExtMem.u32BufSize    = pstAlsaAttr->stBuf.u32BufSize;
        state->stRbfMmz.u32Size         = pstAlsaAttr->stBuf.u32BufSize;
        state->stRbfMmz.u32StartPhyAddr = pstAlsaAttr->stBuf.tBufPhyAddr;
        state->stRbfMmz.pu8StartVirAddr = (HI_U8*)HI_NULL + pstAlsaAttr->stBuf.tBufVirAddr;
        stHwPortAttr.pIsrFunc    = pstAlsaAttr->IsrFunc;
        stHwPortAttr.pSubstream   = pstAlsaAttr->pSubstream;

        stHwPortAttr.stBufConfig.u32PeriodBufSize = pstAlsaAttr->stBuf.u32PeriodByteSize;
        stHwPortAttr.stBufConfig.u32PeriodNumber  = pstAlsaAttr->stBuf.u32Periods;
    }
    else
#endif
    {
        stHwPortAttr.bExtDmaMem = HI_TRUE;
        stHwPortAttr.stExtMem.tBufPhyAddr = state->stRbfMmz.u32StartPhyAddr;
        stHwPortAttr.stExtMem.tBufVirAddr = (HI_VIRT_ADDR_T)state->stRbfMmz.pu8StartVirAddr;
        stHwPortAttr.stExtMem.u32BufSize = state->stRbfMmz.u32Size;
    }

    AISetPortIfAttr(enAiPort, pstAttr, &stHwPortAttr.stIfAttr);
    Ret = HAL_AIAO_P_Open(enPort, &stHwPortAttr);
    if (HI_SUCCESS != Ret)
    {
        HI_ERR_AI("HAL_AIAO_P_Open failed\n");
        return HI_FAILURE;
    }

#if 0
    if(HI_UNF_AI_ADC0 == enAiPort || HI_UNF_AI_ADC1 == enAiPort || HI_UNF_AI_ADC2 == enAiPort 
        || HI_UNF_AI_ADC3 == enAiPort || HI_UNF_AI_ADC4 == enAiPort || HI_UNF_AI_SIF0 == enAiPort) 
    {
        state->bDre = HI_TRUE;   //when input is adc, enable DRE
    }
#endif

    //2.set state
    state->enCurnStatus = AI_CHANNEL_STATUS_STOP;
    state->enAiPort = enAiPort;
    state->enPort = enPort;

    state->stAiProc.u32AqcCnt = 0;         //init proc info
    state->stAiProc.u32AqcTryCnt = 0;
    state->stAiProc.u32RelCnt = 0;
    state->stAiProc.u32RelTryCnt = 0;
    state->u32Rptr = 0;
    state->u32Wptr = 0;
    memcpy(&state->stSndPortAttr, pstAttr, sizeof(HI_UNF_AI_ATTR_S));

#if 0
    if(HI_TRUE == state->bIsBitsStream)
    {
        switch(state->enDataType)
        {
            case HI_UNF_AI_HDMI_DATA_DD:
                state->u32BitsBytesPerFrame = AC3_BITS_LENGTH_INBYTES;
                break;
            case HI_UNF_AI_HDMI_DATA_DDP:
                state->u32BitsBytesPerFrame = EAC3_BITS_LENGTH_INBYTES;
                break;
            case HI_UNF_AI_HDMI_DATA_DTS:
                state->u32BitsBytesPerFrame = 0;
                break;
            case HI_UNF_AI_HDMI_DATA_DTSHD:
                state->u32BitsBytesPerFrame = DTSHD_BITS_LENGTH_INBYTES;
                break;
            case HI_UNF_AI_HDMI_DATA_TRUEHD:
                state->u32BitsBytesPerFrame = TUREHD_BITS_LENGTH_INBYTES;
                break;
            default:
                HI_ERR_AI("Iinvalid hdmi data type!\n");
                return HI_ERR_AI_INVALID_PARA;
        }
    }
#endif

    return HI_SUCCESS;
}

HI_S32 AI_Create(HI_UNF_AI_E enAiPort, HI_UNF_AI_ATTR_S *pstAttr, HI_BOOL bAlsa, HI_VOID *pAlsaPara, HI_HANDLE hAi)
{
    HI_S32 Ret = HI_SUCCESS;
    AI_CHANNEL_STATE_S *state = HI_NULL;

    hAi &= AI_CHNID_MASK;

    if((pstAttr->u32PcmFrameMaxNum <= 0) || (pstAttr->u32PcmSamplesPerFrame <=0))
    {
        HI_ERR_AI("PcmFrameMaxNum(%d) is invalid!\n",pstAttr->u32PcmFrameMaxNum);
        return HI_ERR_AI_INVALID_PARA;
    }

    if (HI_NULL == g_pstGlobalAIRS.pstAI_ATTR_S[hAi])
    {
        HI_ERR_AI("this AI chn is not open!\n");
        return HI_ERR_AI_INVALID_PARA;
    }
    state = g_pstGlobalAIRS.pstAI_ATTR_S[hAi];

    state->bIsBitsStream = HI_FALSE;
    //state->enDataType = HI_UNF_AI_HDMI_DATA_BUTT;

    Ret = AICreateChn(enAiPort, pstAttr, bAlsa, pAlsaPara, state);
    if(HI_SUCCESS != Ret)
    {
        HI_FATAL_AI("AICreateChn failed\n");
        return HI_FAILURE;
    }
    
    state->bAlsa = bAlsa;
    state->pAlsaPara = pAlsaPara;
    state->bAttach = HI_FALSE;

    state->enSaveState = AI_CMD_CTRL_STOP;
    state->bSaveThreadRun = HI_FALSE;
    state->u32SaveCnt = 0;
    state->fileHandle = HI_NULL;
    state->pSaveBuf   = HI_NULL;
    state->u32SaveReadPos = 0;

#if  defined (HI_ALSA_AI_SUPPORT)
    if(state->bAlsa == HI_TRUE)
    {
        memcpy(&g_stAlsaAttr,(AI_ALSA_Param_S*)(pAlsaPara),sizeof(AI_ALSA_Param_S));
    }
#endif
    //4.set global variable
    
    switch(enAiPort)
    {
        case HI_UNF_AI_I2S0:
            g_pstGlobalAIRS.u32BitFlag_AI = (HI_U32)1<<AI_I2S0_MSK;
            break;
        case HI_UNF_AI_I2S1:
            g_pstGlobalAIRS.u32BitFlag_AI = (HI_U32)1<<AI_I2S1_MSK;
            break;
         
        case HI_UNF_AI_ADC0:
        case HI_UNF_AI_ADC1:
        case HI_UNF_AI_ADC2:
        case HI_UNF_AI_ADC3:
        case HI_UNF_AI_ADC4:
            g_pstGlobalAIRS.u32BitFlag_AI = (HI_U32)1<<AI_ADAC_MSK;
            break;
        case HI_UNF_AI_SIF0:
            g_pstGlobalAIRS.u32BitFlag_AI = (HI_U32)1<<AI_I2S1_MSK;
            break;
        case HI_UNF_AI_HDMI0:
        case HI_UNF_AI_HDMI1:
        case HI_UNF_AI_HDMI2:
        case HI_UNF_AI_HDMI3:
            g_pstGlobalAIRS.u32BitFlag_AI = (HI_U32)1<<AI_HDMI_MSK;
            break;
           
        default:
            HI_ERR_AI("Aiport is invalid!\n");
            return HI_ERR_AI_INVALID_PARA;
    }


    AI_RegProc(hAi);

    return HI_SUCCESS;
}

static HI_S32 AIChnDestory(AI_CHANNEL_STATE_S *state)
{
    HAL_AIAO_P_Close(state->enPort);
    return HI_SUCCESS;
}

HI_S32 AI_Destory(HI_HANDLE hAi)
{
    AI_CHANNEL_STATE_S *state = HI_NULL;
    
    hAi &= AI_CHNID_MASK;

    state = g_pstGlobalAIRS.pstAI_ATTR_S[hAi];
    if (HI_NULL == state)
    {
        HI_ERR_AI("this AI chn is not open!\n");
        return HI_ERR_AI_INVALID_PARA;
    }

    if(state->pSaveBuf)
    {
        HI_KFREE(HI_ID_AI, state->pSaveBuf);
        state->pSaveBuf = HI_NULL;
    }
    
    AI_UnRegProc(hAi);
    AIChnDestory(state);

    switch(state->enAiPort)
    {
#if defined (HI_I2S0_SUPPORT)
        case HI_UNF_AI_I2S0:
            g_pstGlobalAIRS.u32BitFlag_AI &= (HI_U32)(~(1<<AI_I2S0_MSK));
            break;
#endif
#if defined (HI_I2S1_SUPPORT)
        case HI_UNF_AI_I2S1:
            g_pstGlobalAIRS.u32BitFlag_AI &= (HI_U32)(~(1<<AI_I2S1_MSK));
            break;
#endif
        case HI_UNF_AI_ADC0:
        case HI_UNF_AI_ADC1:
        case HI_UNF_AI_ADC2:
        case HI_UNF_AI_ADC3:
        case HI_UNF_AI_ADC4:
            g_pstGlobalAIRS.u32BitFlag_AI &= (HI_U32)(~(1<<AI_ADAC_MSK));
#ifdef HI_TIANLAI_V510
            HAL_TIANLAI_V510_SetLineInSuorce(S5_TIANLAI_LINEIN_SEL_MIC, HI_FALSE, HI_FALSE);
#endif
            break;
        case HI_UNF_AI_HDMI0:
        case HI_UNF_AI_HDMI1:
        case HI_UNF_AI_HDMI2:
        case HI_UNF_AI_HDMI3:
            g_pstGlobalAIRS.u32BitFlag_AI &= (HI_U32)(~(1<<AI_HDMI_MSK));
            break;
        case HI_UNF_AI_SIF0:
            g_pstGlobalAIRS.u32BitFlag_AI &= (HI_U32)(~(1<<AI_I2S1_MSK));
            break;
        default:
            HI_ERR_AI("Aiport is invalid!\n");
            return HI_ERR_AI_INVALID_PARA;
    }

    return HI_SUCCESS;
}

HI_S32 AI_SetEnable(HI_HANDLE hAi, HI_BOOL bEnable, HI_BOOL bTrackResume)
{
    HI_S32 Ret;
    HI_U32 u32AiDelayMs = 0;
    HI_U32 u32AoDelayMs = 0;
    HI_U32 u32BytesSize = 0;
    HI_U32 u32FrameSize = 0;
    AI_CHANNEL_STATE_S *state = HI_NULL;
    AIAO_PORT_ATTR_S stPortAttr;

    memset(&stPortAttr, 0, sizeof(AIAO_PORT_ATTR_S));

    hAi &= AI_CHNID_MASK;

    state = g_pstGlobalAIRS.pstAI_ATTR_S[hAi];

    if (HI_NULL == state)
    {
        HI_ERR_AI("this AI chn is not open!\n");
        return HI_ERR_AI_INVALID_PARA;
    }

    if(bEnable)
    {

        Ret = HAL_AIAO_P_GetAttr(state->enPort,&stPortAttr);
        if (HI_SUCCESS != Ret)
        {
            HI_ERR_AI("HAL_AIAO_P_GetAttr(%d) failed\n", state->enPort);
            return Ret;
        }
        u32FrameSize = AUTIL_CalcFrameSize(stPortAttr.stIfAttr.enChNum, stPortAttr.stIfAttr.enBitDepth);

        if(bTrackResume)
        {
            u32BytesSize = AUTIL_LatencyMs2ByteSize(20,  u32FrameSize, stPortAttr.stIfAttr.enRate);
            HAL_AIAO_P_WriteData(state->enPort, HI_NULL, u32BytesSize);
        }
        HAL_AIAO_P_GetDelayMs(state->enPort, &u32AiDelayMs);
        if(HI_TRUE == state->bAttach)
        {
            Ret = AO_Track_GetDelayMs(state->hTrack, &u32AoDelayMs);
            if (HI_SUCCESS != Ret)
            {
                HI_ERR_AI("AO_Track_GetDelayMs(%d) failed\n", state->hTrack);
                return Ret;
            }
        }

        if(u32AiDelayMs + u32AoDelayMs < state->stDelayComps.u32DelayMs)
        {
            u32BytesSize = AUTIL_LatencyMs2ByteSize(state->stDelayComps.u32DelayMs - u32AiDelayMs - u32AoDelayMs,
                                                        u32FrameSize, stPortAttr.stIfAttr.enRate);
            HAL_AIAO_P_WriteData(state->enPort, HI_NULL, u32BytesSize);
        }

        Ret = HAL_AIAO_P_Start(state->enPort);
        if (HI_SUCCESS != Ret)
        {
            HI_ERR_AI("HAL_AIAO_P_Start(%d) failed\n", state->enPort);
        }
        else
        {
            state->enCurnStatus  = AI_CHANNEL_STATUS_START;
        }
    }
    else
    {
        if(HI_TRUE == state->bSaveThreadRun)
        {
            state->bSaveThreadRun = HI_FALSE;
            msleep(2);   //wait util save thread exit
        }
        
        Ret = HAL_AIAO_P_Stop(state->enPort, AIAO_STOP_IMMEDIATE);
        if (HI_SUCCESS != Ret)
        {
            HI_ERR_AI("HAL_AIAO_P_Stop(%d) failed\n", state->enPort);
        }
        else
        {
            state->enCurnStatus  = AI_CHANNEL_STATUS_STOP;
        }
    }

    return Ret;
}

HI_S32 AI_GetEnable(HI_HANDLE hAi, HI_BOOL *pbEnable)
{
    AI_CHANNEL_STATE_S *state = HI_NULL;

    hAi &= AI_CHNID_MASK;

    state = g_pstGlobalAIRS.pstAI_ATTR_S[hAi];

    if (HI_NULL == state)
    {
        HI_ERR_AI("this AI chn is not open!\n");
        return HI_ERR_AI_INVALID_PARA;
    }

    if(AI_CHANNEL_STATUS_START == state->enCurnStatus)
    {
        *pbEnable = HI_TRUE;
    }
    else if(AI_CHANNEL_STATUS_STOP == state->enCurnStatus)
    {
        *pbEnable = HI_FALSE;
    }
    else
    {
        return HI_FAILURE;
    }

    return HI_SUCCESS;

}

static HI_S32 AI_SetAttr(HI_HANDLE hAi, HI_UNF_AI_ATTR_S *pAiAttr)
{
    AI_CHANNEL_STATE_S *state = HI_NULL;
    AIAO_PORT_ATTR_S stPortAttr;
    HI_S32 Ret = HI_SUCCESS;

    hAi &= AI_CHNID_MASK;

    state = g_pstGlobalAIRS.pstAI_ATTR_S[hAi];
    if (HI_NULL == state)
    {
        HI_ERR_AI("this AI chn is not open!\n");
        return HI_ERR_AI_INVALID_PARA;
    }

    Ret = AICheckAttr(state->enAiPort, pAiAttr);
    if(HI_SUCCESS != Ret)
    {
        HI_ERR_AI("invalid ai attr!\n");
        return Ret;
    }

    if(AI_CHANNEL_STATUS_STOP != state->enCurnStatus)
    {
        HI_ERR_AI("current state is not stop,can not set attr!\n");
        return HI_FAILURE;
    }

    HAL_AIAO_P_GetAttr(state->enPort, &stPortAttr);

    AISetPortIfAttr(state->enAiPort, pAiAttr, &stPortAttr.stIfAttr);

    Ret = HAL_AIAO_P_SetAttr(state->enPort,&stPortAttr);
    if(HI_SUCCESS != Ret)
    {
        return Ret;
    }
    memcpy(&state->stSndPortAttr, pAiAttr, sizeof(HI_UNF_AI_ATTR_S));

    return HI_SUCCESS;
}

HI_S32 AI_GetAttr(HI_HANDLE hAi, HI_UNF_AI_ATTR_S *pAiAttr)
{
    AI_CHANNEL_STATE_S *state = HI_NULL;

    hAi &= AI_CHNID_MASK;

    state = g_pstGlobalAIRS.pstAI_ATTR_S[hAi];
    if (HI_NULL == state)
    {
        HI_ERR_AI("this AI chn is not open!\n");
        return HI_ERR_AI_INVALID_PARA;
    }
    memcpy(pAiAttr, &state->stSndPortAttr, sizeof(HI_UNF_AI_ATTR_S));

    return HI_SUCCESS;
}

HI_S32 AI_GetPortAttr(HI_HANDLE hAi, AIAO_PORT_ATTR_S *pstPortAttr)
{
    AI_CHANNEL_STATE_S *state = HI_NULL;

    hAi &= AI_CHNID_MASK;

    state = g_pstGlobalAIRS.pstAI_ATTR_S[hAi];
    if (HI_NULL == state)
    {
        HI_ERR_AI("this AI chn is not open!\n");
        return HI_ERR_AI_INVALID_PARA;
    }

    if(HI_SUCCESS != HAL_AIAO_P_GetAttr(state->enPort, pstPortAttr))
    {
        HI_ERR_AI("HAL_AIAO_P_GetAttr failed!\n");
        return HI_FAILURE;
    }
    
    return HI_SUCCESS;
}

HI_S32 AI_GetDreEnableStatus(HI_HANDLE hAi, HI_BOOL *pbDre)
{
    AI_CHANNEL_STATE_S *state = HI_NULL;
    
    hAi &= AI_CHNID_MASK;
 
    state = g_pstGlobalAIRS.pstAI_ATTR_S[hAi];
    if (HI_NULL == state)
    {
        HI_ERR_AI("this AI chn is not open!\n");
        return HI_ERR_AI_INVALID_PARA;
    }
    
    *pbDre = state->bDre;
    
    return HI_SUCCESS;
}

static HI_S32 AICheckDelayComps(AI_CHANNEL_STATE_S *state, HI_U32 u32CompensationMs)
{
    HI_U32 u32BufDelayMs = 0;

    if(state->stSndPortAttr.enSampleRate)
    {
        u32BufDelayMs = state->stSndPortAttr.u32PcmSamplesPerFrame * state->stSndPortAttr.u32PcmFrameMaxNum
                        * 1000 / state->stSndPortAttr.enSampleRate;
    }

    if(u32CompensationMs > u32BufDelayMs)
    {
        HI_ERR_AI("u32CompensationMs(%d) exceed u32BufDelayMs(%d)!\n", u32CompensationMs, u32BufDelayMs);
        return HI_FAILURE;
    }

    return HI_SUCCESS;
}

static HI_S32 AI_SetDelayComps(HI_HANDLE hAi, HI_UNF_AI_DELAY_S *pstDelayComps)
{
    AI_CHANNEL_STATE_S *state = HI_NULL;

    hAi &= AI_CHNID_MASK;

    state = g_pstGlobalAIRS.pstAI_ATTR_S[hAi];

    if (HI_NULL == state)
    {
        HI_ERR_AI("this AI chn is not open!\n");
        return HI_ERR_AI_INVALID_PARA;;
    }

    if(HI_SUCCESS != AICheckDelayComps(state, pstDelayComps->u32DelayMs))
    {
        return HI_FAILURE;
    }

    if(AI_CHANNEL_STATUS_STOP != state->enCurnStatus)
    {
        HI_ERR_AI("current state is not stop,can not set delay compensation!\n");
        return HI_FAILURE;
    }

    memcpy(&state->stDelayComps, pstDelayComps, sizeof(HI_UNF_AI_DELAY_S));

    return HI_SUCCESS;
}

static HI_S32 AI_GetDelayComps(HI_HANDLE hAi, HI_UNF_AI_DELAY_S *pstDelayComps)
{
    AI_CHANNEL_STATE_S *state = HI_NULL;

    hAi &= AI_CHNID_MASK;

    state = g_pstGlobalAIRS.pstAI_ATTR_S[hAi];

    if (HI_NULL == state)
    {
        HI_ERR_AI("this AI chn is not open!\n");
        return HI_ERR_AI_INVALID_PARA;;
    }

    memcpy(pstDelayComps, &state->stDelayComps, sizeof(HI_UNF_AI_DELAY_S));

    return HI_SUCCESS;

}


static HI_U32 AiGetSysTime(HI_VOID)
{
    HI_U64   SysTime;

    SysTime = sched_clock();

    do_div(SysTime, 1000000);

    return (HI_U32)SysTime;
}

static HI_S32 AI_AcquireFrame(HI_HANDLE hAi, AO_FRAMEINFO_S *pstFrame)
{
    HI_U32 u32ReadBytes, u32NeedBytes, /*u32NeedBytes_bak = 0, u32NeedBytes_Que,*/ u32DataBytes, 
           u32FrameSize, u32QurBufDataCnt = 0/*, u32ReadCnt = 0*/;
    HI_U32 u32Chn = 0, u32Bit = 0;
    AI_CHANNEL_STATE_S *state = HI_NULL;
    HI_U32 /*i, u32SyncSkip,*/ u32StreamBytes = 0;
    //HI_U16 *pu16Buf;
    //HI_BOOL bDtscd = HI_FALSE;

    hAi &= AI_CHNID_MASK;

    state = g_pstGlobalAIRS.pstAI_ATTR_S[hAi];

    if (HI_NULL == state)
    {
        HI_ERR_AI("AI chn is not open,can not get frame!\n");
        return HI_ERR_AI_INVALID_PARA;
    }

    state->stAiProc.u32AqcTryCnt++;

    if(AI_CHANNEL_STATUS_STOP == state->enCurnStatus)
    {
        HI_WARN_AI("current state is stop,can not get frame!\n");
        return HI_FAILURE;
    }

    AIGetChannelsAndBitDepth(state->enAiPort, &state->stSndPortAttr, &u32Chn, &u32Bit);

    if(!state->stAiBuf.u32Read)         //do not need read data from port buff
    {
        pstFrame->bInterleaved = HI_TRUE;

        if(HI_UNF_I2S_BIT_DEPTH_16 == u32Bit)
        {
            pstFrame->s32BitPerSample = 16;
        }
        else
        {
            pstFrame->s32BitPerSample = 32;
        }
        pstFrame->u32Channels = u32Chn;
        
        if(HI_TRUE == state->bIsBitsStream)
        {
            pstFrame->u32BitsBytesPerFrame = state->u32BitsBytesNotRlease;
            pstFrame->u32SampleRate = state->stSndPortAttr.enSampleRate;
        }
        else
        {
            pstFrame->u32PcmSamplesPerFrame = state->stSndPortAttr.u32PcmSamplesPerFrame;
            pstFrame->u32SampleRate = state->stSndPortAttr.enSampleRate;
        }
        pstFrame->u32PtsMs = AiGetSysTime();

        return HI_SUCCESS;
    }
#if 0
    if(state->bIsBitsStream)
    {
        if((HI_UNF_AI_HDMI_DATA_DTS == state->enDataType) && (0 == state->u32BitsBytesPerFrame))
        {
            // = DTS_BITS_LENGTH_INBYTES_TYPE_III;
            //u32NeedBytes_Que = DTS_BITS_LENGTH_INBYTES_TYPE_III;
            
            u32NeedBytes = DTS_BITS_LENGTH_INBYTES_TYPE_I;
            u32NeedBytes_Que = DTS_BITS_LENGTH_INBYTES_TYPE_I;
        }
        else
        {
            u32NeedBytes = state->u32BitsBytesPerFrame;
        }
        
        u32NeedBytes_bak = u32NeedBytes;
    }
    else
#endif
    {
        u32FrameSize = AUTIL_CalcFrameSize(u32Chn, u32Bit);
        u32NeedBytes= state->stSndPortAttr.u32PcmSamplesPerFrame*u32FrameSize;
    }
    
    while(1)
    {
        u32QurBufDataCnt++;
        
        if(HI_TRUE == state->bAttach)
        {
            u32DataBytes = HAL_AIAO_P_QueryBufData_ProvideRptr(state->enPort, &state->u32Rptr);
        }
        else
        {
            u32DataBytes = HAL_AIAO_P_QueryBufData(state->enPort);
        }
#if 0
        if((state->bIsBitsStream) && (HI_UNF_AI_HDMI_DATA_DTS == state->enDataType) && (0 == state->u32BitsBytesPerFrame))
        {
            if (u32DataBytes > u32NeedBytes_Que)
            {
                break;
            }
        }
        else
#endif
        {
            if (u32DataBytes > u32NeedBytes)
            {
                break;
            }
        }
        
        if (u32QurBufDataCnt > AI_QUERY_BUF_CNT_MAX)
        {
            HI_WARN_AI("Query BufData time out!\n");
            //return HI_ERR_AI_NOT_ENOUGH_DATA;
            return HI_FAILURE;
        }
        msleep(1);
    }

    if(HI_TRUE == state->bAttach)
    {
        u32ReadBytes = HAL_AIAO_P_ReadData_NotUpRptr(state->enPort, (HI_U8*)state->stAiBuf.tKernelVirBaseAddr, u32NeedBytes, &state->u32Rptr, &state->u32Wptr);
    }
    else
    {
        u32ReadBytes = HAL_AIAO_P_ReadData(state->enPort, (HI_U8*)state->stAiBuf.tKernelVirBaseAddr, u32NeedBytes);
#if 0
        if(HI_FALSE == state->bIsBitsStream)
        {
        u32ReadBytes = HAL_AIAO_P_ReadData(state->enPort, state->stAiBuf.tKernelVirBaseAddr, u32NeedBytes);
        }
        else
        {
            while(u32ReadCnt < FIND_SYNC_MAX_CNT)
            {
                u32ReadBytes = HAL_AIAO_P_ReadData(state->enPort, state->stAiBuf.tKernelVirBaseAddr, u32NeedBytes);
				if (!u32ReadBytes)
				{
				   u32ReadCnt++;
				   msleep(10);
				   continue;
				}

                if(DTS_BITS_LENGTH_INBYTES_TYPE_CD == u32NeedBytes)
                {
                    u32StreamBytes = u32ReadBytes;
                    break;
                }

                pu16Buf = (HI_U16*)state->stAiBuf.tKernelVirBaseAddr;
                for(i=0; i<(u32ReadBytes/2-1); i++)
                {
                    if(HI_UNF_AI_HDMI_DATA_DTS == state->enDataType)
                    {
                        if(((DTS_CD_SYNC1_LE == pu16Buf[i]) && (DTS_CD_SYNC2_LE == pu16Buf[i+1])) \
                        || ((DTS_CD_SYNC1_BE == pu16Buf[i]) && (DTS_CD_SYNC2_BE == pu16Buf[i+1])))
                        {
                            state->u32BitsBytesPerFrame = DTS_BITS_LENGTH_INBYTES_TYPE_CD;
                            bDtscd = HI_TRUE;
                            break;
                        }
                    }
                    
                    if((IEC61937_SYNCWORD1 == pu16Buf[i]) && (IEC61937_SYNCWORD2 == pu16Buf[i+1]))
                    {
                        break;
                    }
                }
                
                if((u32ReadBytes/2-1) == i)    
                {
                    u32ReadCnt ++;
                    msleep(10);
                    continue;
                }
                if(0 != i)
                {
                    u32SyncSkip = i;
                    memcpy(state->stAiBuf.tKernelVirBaseAddr, state->stAiBuf.tKernelVirBaseAddr + i * sizeof(HI_U16), u32ReadBytes - u32SyncSkip * sizeof(HI_U16));

                    u32NeedBytes = u32SyncSkip*sizeof(HI_U16);  //todo
                    u32ReadBytes = HAL_AIAO_P_ReadData(state->enPort, state->stAiBuf.tKernelVirBaseAddr + (u32ReadBytes - u32SyncSkip * sizeof(HI_U16)), u32NeedBytes);
                }

				if(!bDtscd)
				{
				    if((PAUSE_DATA_TYPE == pu16Buf[2]) || (NULL_DATA_TYPE == pu16Buf[2]))
				    {
                        HI_WARN_AI("pause data or null data!\n");
						return HI_ERR_AI_BITS_INVALID_DATA;
				    }
				}
				
				if(HI_UNF_AI_HDMI_DATA_DD == state->enDataType)
				{
					if(DATA_TYPE_EAC3 == pu16Buf[2])
					{
						state->enDataType = HI_UNF_AI_HDMI_DATA_DDP;
						state->u32BitsBytesPerFrame = EAC3_BITS_LENGTH_INBYTES;
						u32NeedBytes = EAC3_BITS_LENGTH_INBYTES - AC3_BITS_LENGTH_INBYTES;
						u32ReadBytes = HAL_AIAO_P_ReadData(state->enPort, (HI_U8*)state->stAiBuf.tKernelVirBaseAddr + AC3_BITS_LENGTH_INBYTES, u32NeedBytes);
					}
				}
				
                switch(state->enDataType)
                {
                    case HI_UNF_AI_HDMI_DATA_DD:
                        u32StreamBytes = pu16Buf[3] >> 3;
                        break;
                    case HI_UNF_AI_HDMI_DATA_DDP:
                        u32StreamBytes = pu16Buf[3];
                        break;
                    case HI_UNF_AI_HDMI_DATA_DTS:
                        u32StreamBytes =  (pu16Buf[3] >> 4)*sizeof(HI_U16);
                        break;
                    case HI_UNF_AI_HDMI_DATA_DTSHD:
                        u32StreamBytes = pu16Buf[9];
                        break;
                    case HI_UNF_AI_HDMI_DATA_TRUEHD:
                        u32StreamBytes = pu16Buf[3];
                        break;
                    default:
                        HI_ERR_AI("Iinvalid hdmi data type!\n");
                        return HI_ERR_AI_INVALID_PARA;
                }
                if(bDtscd)
                {
                    u32StreamBytes = u32NeedBytes_bak;
                }
                else
                {
                    if(0 == u32StreamBytes)
                    {
                        HI_WARN_AI("no invalid data!\n");
                        return HI_FAILURE;
                    }
                    if((HI_UNF_AI_HDMI_DATA_DTS == state->enDataType) && (0 == state->u32BitsBytesPerFrame))
                    {
                        switch(pu16Buf[2])
                        {
                            case DATA_DTS_TYPE_I:
                                state->u32BitsBytesPerFrame = DTS_BITS_LENGTH_INBYTES_TYPE_I;
                                break;
                            case DATA_DTS_TYPE_II:
                                state->u32BitsBytesPerFrame = DTS_BITS_LENGTH_INBYTES_TYPE_II;
                                break;
                            case DATA_DTS_TYPE_III:
                                state->u32BitsBytesPerFrame = DTS_BITS_LENGTH_INBYTES_TYPE_III;
                                break;
                            default:
                                HI_ERR_AI("Iinvalid dts hdmi data type!\n");
                                return HI_ERR_AI_INVALID_PARA;
                        }
                        if(u32NeedBytes_bak != state->u32BitsBytesPerFrame)
                        {
                            u32ReadBytes = HAL_AIAO_P_ReadData(state->enPort, state->stAiBuf.tKernelVirBaseAddr + u32NeedBytes_bak, state->u32BitsBytesPerFrame - u32NeedBytes_bak);
                        }
                    }
                    if(HI_UNF_AI_HDMI_DATA_DTSHD == state->enDataType)
                    {
                        memcpy(state->stAiBuf.tKernelVirBaseAddr, state->stAiBuf.tKernelVirBaseAddr + SYNC_LENGTH + DTSHD_HEADER_SIZE, u32StreamBytes);
                    }
                    else
                    {
                        memcpy(state->stAiBuf.tKernelVirBaseAddr, state->stAiBuf.tKernelVirBaseAddr + SYNC_LENGTH, u32StreamBytes);
                    }
                }
                break;
            }
            
            if(FIND_SYNC_MAX_CNT == u32ReadCnt)
            {
                HI_WARN_AI("Can not find sync words!\n");
                return HI_ERR_AI_CANNOT_FINDSYNC;
            }

        }
#endif
    }

    if (u32ReadBytes != u32NeedBytes)
    {
        HI_ERR_AI("Read Port Data Error!\n");
        return HI_FAILURE;
    }
    
    pstFrame->bInterleaved = HI_TRUE;
    if(HI_UNF_I2S_BIT_DEPTH_16 == u32Bit)
    {
        pstFrame->s32BitPerSample = 16;
    }
    else
    {
        pstFrame->s32BitPerSample = 32;
    }
    pstFrame->u32Channels = u32Chn;

    if(HI_TRUE == state->bIsBitsStream)
    {
        pstFrame->u32BitsBytesPerFrame = u32StreamBytes;
    }
    else
    {
        pstFrame->u32PcmSamplesPerFrame = state->stSndPortAttr.u32PcmSamplesPerFrame;
    }

    pstFrame->u32SampleRate = state->stSndPortAttr.enSampleRate;
    pstFrame->u32PtsMs = AiGetSysTime();
    if(HI_TRUE == state->bIsBitsStream)
    {
        state->u32BitsBytesNotRlease = u32StreamBytes;
        state->stAiBuf.u32Write = u32StreamBytes;
        state->stAiBuf.u32Read = 0;
    }
    else
    {
        state->stAiBuf.u32Write = u32ReadBytes;
        state->stAiBuf.u32Read = 0;
    }
    state->stAiProc.u32AqcCnt++;

    return HI_SUCCESS;
}

static HI_S32 AI_ReleaseFrame(HI_HANDLE hAi, AO_FRAMEINFO_S *pstFrame)
{
    //HI_U32 u32DataBytes, u32UpRptrBytes, u32FrameSize;
    
    AI_CHANNEL_STATE_S *state = HI_NULL;
    
    hAi &= AI_CHNID_MASK;

    state = g_pstGlobalAIRS.pstAI_ATTR_S[hAi];
    if (HI_NULL == state)
    {
        HI_ERR_AI("this AI chn is not open!\n");
        return HI_FAILURE;
    }

    if (state->stAiBuf.u32Read)
    {
        HI_ERR_AI("have not acquired frame,can not release frame!\n");
        return HI_FAILURE;
    }
    
    if(HI_TRUE == state->bIsBitsStream)
    {
        state->stAiProc.u32RelTryCnt++;
        state->stAiBuf.u32Read = state->u32BitsBytesNotRlease;
    }
    else
    {
        state->stAiProc.u32RelTryCnt++;
        state->stAiBuf.u32Read =state->stAiBuf.u32Read + pstFrame->u32PcmSamplesPerFrame*pstFrame->u32Channels*pstFrame->s32BitPerSample /8;
    }
    state->stAiProc.u32RelCnt++;
    return HI_SUCCESS;
}

static HI_S32 AI_GetAiBufInfo(HI_HANDLE hAi, AI_BUF_ATTR_S *pstAiBuf)
{
    AI_CHANNEL_STATE_S *state = HI_NULL;
    
    hAi &= AI_CHNID_MASK;

    state = g_pstGlobalAIRS.pstAI_ATTR_S[hAi];

    if (HI_NULL == state)
    {
        HI_ERR_AI("AI chn is not open,can not get frame!\n");
        return HI_ERR_AI_INVALID_PARA;
    }

    pstAiBuf->tPhyBaseAddr = state->stAiBuf.tPhyBaseAddr;
    pstAiBuf->u32Size = state->stAiBuf.u32Size;
    pstAiBuf->tKernelVirBaseAddr = state->stAiBuf.tKernelVirBaseAddr;
    pstAiBuf->u32Read = state->stAiBuf.u32Read;
    pstAiBuf->u32Write = state->stAiBuf.u32Write;
    pstAiBuf->tUserVirBaseAddr = state->stAiBuf.tUserVirBaseAddr;

    return HI_SUCCESS;
}

static HI_S32 AI_SetAiBufInfo(HI_HANDLE hAi, AI_BUF_ATTR_S *pstAiBuf)
{
    AI_CHANNEL_STATE_S *state = HI_NULL;

    hAi &= AI_CHNID_MASK;

    state = g_pstGlobalAIRS.pstAI_ATTR_S[hAi];

    if (HI_NULL == state)
    {
        HI_ERR_AI("AI chn is not open,can not get frame!\n");
        return HI_ERR_AI_INVALID_PARA;
    }

    state->stAiBuf.tUserVirBaseAddr = pstAiBuf->tUserVirBaseAddr;
    
    return HI_SUCCESS;
}

HI_S32 AI_GetPortBuf(HI_HANDLE hAi, AIAO_RBUF_ATTR_S* pstAiaoBuf)
{
    AI_CHANNEL_STATE_S *state = HI_NULL;

    CHECK_AI_CHN_OPEN(hAi);
    hAi &= AI_CHNID_MASK;

    state = g_pstGlobalAIRS.pstAI_ATTR_S[hAi];

    if (HI_NULL == state)
    {
        HI_ERR_AI("AI chn is not open,can not get frame!\n");
        return HI_ERR_AI_INVALID_PARA;
    }

    return HAL_AIAO_P_GetRbfAttr(state->enPort, pstAiaoBuf);
}

HI_S32 AI_SetAttachFlag(HI_HANDLE hAi, HI_HANDLE hTrack, HI_BOOL bAttachFlag)
{
    AI_CHANNEL_STATE_S *state = HI_NULL;

    CHECK_AI_CHN_OPEN(hAi);
    hAi &= AI_CHNID_MASK;

    state = g_pstGlobalAIRS.pstAI_ATTR_S[hAi];

    if (HI_NULL == state)
    {
        HI_ERR_AI("AI chn is not open,can not be attached!\n");
        return HI_ERR_AI_INVALID_PARA;
    }
    if(HI_TRUE == bAttachFlag)
    {

        if((HI_TRUE == state->bAttach) && (state->hTrack != hTrack))
        {
            HI_ERR_AI("AI is attached ,can not be attached again!\n");
            return HI_FAILURE;
        }
        state->bAttach = HI_TRUE;
        state->hTrack = hTrack;
    }
    else
    {
        if((HI_TRUE != state->bAttach) || (state->hTrack != hTrack))
        {
            HI_ERR_AI("track(0x%x) is not attach this AI channel, can not detach!\n",hTrack);
            return HI_FAILURE;
        }
        state->bAttach = HI_FALSE;
        state->hTrack = HI_INVALID_HANDLE;
    }
    
    return HI_SUCCESS;
}

HI_S32 AI_AllocHandle(HI_HANDLE *phHandle, struct file *pstFile, HI_UNF_AI_E enAiPort, 
                                HI_BOOL bAlseUse, HI_UNF_AI_ATTR_S *pstAiAttr)
{
    HI_U32 i;
    HI_S32 Ret = HI_SUCCESS;
    HI_CHAR szName[16];
    AI_CHANNEL_STATE_S *state;
    HI_U32 u32Channel = HI_UNF_I2S_CHNUM_2;
    HI_U32 u32BitDepth = HI_UNF_I2S_BIT_DEPTH_16;
    HI_U32 u32FrameSize = 0, u32AiBufSize = 0, u32BufSize = 0;

    if (!phHandle || !pstAiAttr)
    {
        HI_ERR_AI("Bad param!\n");
        Ret = HI_ERR_AI_INVALID_PARA;
        goto err0;
    }

    if(HI_FALSE == AICheckPortValid(enAiPort))
    {
        Ret = HI_ERR_AI_INVALID_PARA;
        goto err0;
    }

    if(HI_FALSE == AICheckPortUsed(enAiPort))
    {
        Ret = HI_FAILURE;
        goto err0;
    }

    Ret = AICheckAttr(enAiPort, pstAiAttr);
    if(HI_SUCCESS != Ret)
    {
        HI_ERR_AI("invalid ai attr!\n");
        goto err0;
    }

    /* Allocate new channel */
    for (i = 0; i < AI_MAX_TOTAL_NUM; i++)
    {
        if (NULL == g_pstGlobalAIRS.pstAI_ATTR_S[i])
        {
            break;
        }
    }

    if (i >= AI_MAX_TOTAL_NUM)
    {
        HI_ERR_AI("Too many Ai channel!\n");
        Ret = HI_FAILURE;
        goto err0;
    }

    state = HI_KMALLOC(HI_ID_AI, sizeof(AI_CHANNEL_STATE_S), GFP_KERNEL);
    if (state == HI_NULL)
    {
        HI_FATAL_AI("HI_KMALLOC AI_Create failed\n");
        Ret = HI_FAILURE;
        goto err0;
    }
    memset(state, 0, sizeof(AI_CHANNEL_STATE_S));

    if(HI_FALSE == bAlseUse)
    {
        //for passthrough data
        if((HI_UNF_AI_HDMI_FORMAT_LBR == pstAiAttr->unAttr.stHDMIAttr.enHdmiAudioDataFormat)
         ||(HI_UNF_AI_HDMI_FORMAT_HBR == pstAiAttr->unAttr.stHDMIAttr.enHdmiAudioDataFormat))
        {
            pstAiAttr->u32PcmSamplesPerFrame = AI_SAMPLE_PERFRAME_DF*20;
        }

        AIGetChannelsAndBitDepth(enAiPort, pstAiAttr, &u32Channel, &u32BitDepth);
        u32FrameSize = AUTIL_CalcFrameSize(u32Channel, u32BitDepth);
        u32AiBufSize = pstAiAttr->u32PcmSamplesPerFrame * u32FrameSize;
        snprintf(szName, sizeof(szName), "AI_ChnBuf%d", i);
        Ret = HI_DRV_MMZ_AllocAndMap(szName, MMZ_OTHERS, u32AiBufSize, AIAO_BUFFER_ADDR_ALIGN, &state->stAiRbfMmz);
        if (HI_SUCCESS != Ret)
        {
            HI_FATAL_AI("HI_MMZ AI_BUF failed, AllocSize(%d)\n", u32AiBufSize);
            Ret = HI_FAILURE;
            goto err1;
        }
        state->stAiBuf.tPhyBaseAddr = state->stAiRbfMmz.u32StartPhyAddr;
        state->stAiBuf.u32Size = state->stAiRbfMmz.u32Size;
        state->stAiBuf.tKernelVirBaseAddr = (HI_VIRT_ADDR_T)state->stAiRbfMmz.pu8StartVirAddr;
        state->stAiBuf.tUserVirBaseAddr = HI_NULL;
        state->stAiBuf.u32Read = state->stAiRbfMmz.u32Size;  //verify standby
        state->stAiBuf.u32Write = 0;

        u32BufSize = pstAiAttr->u32PcmSamplesPerFrame * u32FrameSize * pstAiAttr->u32PcmFrameMaxNum;
        snprintf(szName, sizeof(szName), "AI_I2sBuf%d", i);
        Ret = HI_DRV_MMZ_AllocAndMap(szName, MMZ_OTHERS, u32BufSize, AIAO_BUFFER_ADDR_ALIGN, &state->stRbfMmz);
        if (HI_SUCCESS != Ret)
        {
            HI_FATAL_AI("HI_MMZ AI_PORT_BUF failed, AllocSize(%d)\n", u32BufSize);
            Ret = HI_FAILURE;
            goto err2;
        }
    }

    state->pstFile = pstFile;
    g_pstGlobalAIRS.pstAI_ATTR_S[i] = state;

    *phHandle =(HI_ID_AI << 16) | i;

    return HI_SUCCESS;
    
err2:
    HI_DRV_MMZ_UnmapAndRelease(&state->stAiRbfMmz);
err1:
    HI_KFREE(HI_ID_AI, state);
err0:
    return Ret;
}

HI_VOID AI_FreeHandle(HI_HANDLE hHandle)
{
    AI_CHANNEL_STATE_S *state = HI_NULL;
    hHandle &= AI_CHNID_MASK;


    if(HI_NULL == g_pstGlobalAIRS.pstAI_ATTR_S[hHandle])
    {
        return;
    }

    state = g_pstGlobalAIRS.pstAI_ATTR_S[hHandle];

    if(HI_FALSE == state->bAlsa)
    {
        HI_DRV_MMZ_UnmapAndRelease(&state->stRbfMmz);
        HI_DRV_MMZ_UnmapAndRelease(&state->stAiRbfMmz);
    }
    HI_KFREE(HI_ID_AI, state);
    g_pstGlobalAIRS.pstAI_ATTR_S[hHandle] = NULL;

    return;
}

static HI_S32 AI_OpenDev(HI_VOID)
{
    HI_U32 i;

    g_pstGlobalAIRS.u32BitFlag_AI = 0;

    for (i=0;i<AI_MAX_TOTAL_NUM;i++)
    {
        g_pstGlobalAIRS.pstAI_ATTR_S[i] = NULL;
    }

    HAL_AIAO_Init();

    return HI_SUCCESS;
}

static HI_S32 AI_CloseDev(HI_VOID)
{
    HI_U32 i;

    g_pstGlobalAIRS.u32BitFlag_AI = 0;

    for (i=0;i<AI_MAX_TOTAL_NUM;i++)
    {
        g_pstGlobalAIRS.pstAI_ATTR_S[i] = NULL;
    }

    HAL_AIAO_DeInit();

    return HI_SUCCESS;
}


/************************************************************************/
//static HI_S32 AI_ProcessCmd(struct file *file, HI_U32 cmd, HI_VOID *arg)
static HI_S32 AI_ProcessCmd( struct inode *inode, struct file *file, HI_U32 cmd, HI_VOID *arg )
{
    HI_S32 Ret = HI_SUCCESS;
    HI_HANDLE hHandle = HI_INVALID_HANDLE;

    switch(cmd)
    {
        case CMD_AI_GEtDEFAULTATTR:
        {
            AI_GetDfAttr_Param_S_PTR pstAiDfAttr = (AI_GetDfAttr_Param_S_PTR)arg;
            Ret = AI_GetDefaultAttr(pstAiDfAttr->enAiPort, &pstAiDfAttr->stAttr);
            break;
        }
        case CMD_AI_CREATE:
        {
            AI_Create_Param_S_PTR pstAi =  (AI_Create_Param_S_PTR)arg;
			Ret = AI_AllocHandle(&hHandle, file, pstAi->enAiPort, pstAi->bAlsaUse, &pstAi->stAttr);
            if (HI_SUCCESS == Ret)
            {
                Ret = AI_Create(pstAi->enAiPort, &pstAi->stAttr, pstAi->bAlsaUse, HI_NULL, hHandle);
                
                if (HI_SUCCESS != Ret)
                {
                    AI_FreeHandle(hHandle);
                    break;
                }
                
                pstAi->hAi = hHandle;
            }
            else
            {
                Ret = HI_FAILURE;
            }
            break;
        }
        case CMD_AI_DESTROY:
        {
            HI_HANDLE hAi = *(HI_HANDLE *)arg;
            CHECK_AI_CHN_OPEN(hAi);

            Ret = AI_Destory(hAi);
            if (HI_SUCCESS != Ret)
            {
                break;
            }

            AI_FreeHandle(hAi);
            break;
        }

        case CMD_AI_SETENABLE:
        {
            AI_Enable_Param_S_PTR pstAiEnable = (AI_Enable_Param_S_PTR)arg;

            CHECK_AI_CHN_OPEN(pstAiEnable->hAi);

            Ret = AI_SetEnable(pstAiEnable->hAi, pstAiEnable->bAiEnable, HI_FALSE);
            break;
        }

        case CMD_AI_GETENABLE:
        {
            AI_Enable_Param_S_PTR pstAiEnable = (AI_Enable_Param_S_PTR)arg;

            CHECK_AI_CHN_OPEN(pstAiEnable->hAi);

            Ret = AI_GetEnable(pstAiEnable->hAi, &pstAiEnable->bAiEnable);
            break;
        }

        case CMD_AI_ACQUIREFRAME:
        {
            AI_Frame_Param_S_PTR pstAiFrame = (AI_Frame_Param_S_PTR)arg;

            CHECK_AI_CHN_OPEN(pstAiFrame->hAi);

            Ret = AI_AcquireFrame(pstAiFrame->hAi, &pstAiFrame->stAiFrame);
            break;
        }

        case CMD_AI_RELEASEFRAME:
        {
            AI_Frame_Param_S_PTR pstAiFrame = (AI_Frame_Param_S_PTR)arg;

            CHECK_AI_CHN_OPEN(pstAiFrame->hAi);

            Ret = AI_ReleaseFrame(pstAiFrame->hAi, &pstAiFrame->stAiFrame);
            break;
        }

        case CMD_AI_SETATTR:
        {
            AI_Attr_Param_S_PTR pstAiAttr = (AI_Attr_Param_S_PTR)arg;

            CHECK_AI_CHN_OPEN(pstAiAttr->hAi);

            Ret = AI_SetAttr(pstAiAttr->hAi, &pstAiAttr->stAttr);
            break;
        }

        case CMD_AI_GETATTR:
        {
            AI_Attr_Param_S_PTR pstAiAttr = (AI_Attr_Param_S_PTR)arg;

            CHECK_AI_CHN_OPEN(pstAiAttr->hAi);

            Ret = AI_GetAttr(pstAiAttr->hAi, &pstAiAttr->stAttr);
            break;
        }

        case CMD_AI_GETBUFINFO:
        {
            AI_Buf_Param_S_PTR pstAiBufInfo = (AI_Buf_Param_S_PTR)arg;

            CHECK_AI_CHN_OPEN(pstAiBufInfo->hAi);

            Ret = AI_GetAiBufInfo(pstAiBufInfo->hAi, &pstAiBufInfo->stAiBuf);
            break;
        }

        case CMD_AI_SETBUFINFO:
        {
            AI_Buf_Param_S_PTR pstAiBufInfo = (AI_Buf_Param_S_PTR)arg;

            CHECK_AI_CHN_OPEN(pstAiBufInfo->hAi);

            Ret = AI_SetAiBufInfo(pstAiBufInfo->hAi, &pstAiBufInfo->stAiBuf);
            break;
        }

        case CMD_AI_SETDELAYCOMPS:
        {
            AI_DelayComps_Param_S_PTR pstDelayComps = (AI_DelayComps_Param_S_PTR)arg;

            CHECK_AI_CHN_OPEN(pstDelayComps->hAi);

            Ret = AI_SetDelayComps(pstDelayComps->hAi, &pstDelayComps->stDelayComps);
            break;
        }
        
        case CMD_AI_GETDELAYCOMPS:
        {
            AI_DelayComps_Param_S_PTR pstDelayComps = (AI_DelayComps_Param_S_PTR)arg;

            CHECK_AI_CHN_OPEN(pstDelayComps->hAi);

            Ret = AI_GetDelayComps(pstDelayComps->hAi, &pstDelayComps->stDelayComps);
            break;
        }
        
        default:
        {
            Ret = HI_ERR_AI_INVALID_PARA;
            HI_WARN_AI("unknown cmd: 0x%x\n", cmd);
            break;
        }

    }

    return Ret;

}

long AI_DRV_Ioctl(struct file *file, HI_U32 cmd, unsigned long arg)
{
    long Ret;

    Ret = down_interruptible(&g_AIMutex);

    //cmd process
 //   Ret = (long)AI_ProcessCmd(file,cmd, (HI_VOID *)arg);
     Ret = (long)HI_DRV_UserCopy(file->f_dentry->d_inode, file, cmd, arg, AI_ProcessCmd);

    up(&g_AIMutex);
    return Ret;
}


HI_S32 AI_DRV_Open(struct inode *inode, struct file  *filp)
{
    HI_S32 Ret;
    
    Ret = down_interruptible(&g_AIMutex);
   
    if (atomic_inc_return(&g_AIOpenCnt) == 1)
    {
        if (HI_SUCCESS != AI_OpenDev())
        {
            HI_FATAL_AI("AI_OpenDev err!\n" );
            up(&g_AIMutex);
            return HI_FAILURE;
        }
    }
    
    up(&g_AIMutex);
    return HI_SUCCESS;
}

HI_S32 AI_DRV_Release(struct inode *inode, struct file  *filp)
{
    HI_S32 Ret,i;
    HI_HANDLE hAi;
    
    Ret = down_interruptible(&g_AIMutex);
    
    for(i=0;i<AI_MAX_TOTAL_NUM;i++)
    {
        if((NULL != g_pstGlobalAIRS.pstAI_ATTR_S[i]) && filp == g_pstGlobalAIRS.pstAI_ATTR_S[i]->pstFile)
        {
            hAi = (HI_HANDLE)i;

            if(HI_SUCCESS != AI_Destory(hAi))
            {
                HI_ERR_AI("AI_Destory err! hAi is %d\n", hAi);
            }
            
            AI_FreeHandle(hAi);
        }
    }
    
    if (atomic_dec_and_test(&g_AIOpenCnt))
    {
        if (HI_SUCCESS != AI_CloseDev())
        {
            HI_FATAL_AI("AI_CloseDev err!\n" );
        }
    }
    
    up(&g_AIMutex);

    return HI_SUCCESS;
}

static HI_S32 AiSaveThread(void *Arg)
{
    HI_U32 u32Ai = *((HI_U32 *)Arg);
    HI_U32 u32Chn = 0, u32Bit = 0, u32FrameSize = 0, u32WritePos = 0;
    HI_U32 u32ReadBytes = 0, u32NeedBytes = 0, u32DataBytes = 0;
    AI_CHANNEL_STATE_S *state = g_pstGlobalAIRS.pstAI_ATTR_S[u32Ai];
    if (!state)
    {
        HI_ERR_AI("this AI chn is not open!\n");
        return HI_FAILURE;
    }

    if(AI_CHANNEL_STATUS_STOP == state->enCurnStatus)
    {
        HI_WARN_AI("current state is stop,can not get frame!\n");
        return HI_FAILURE;
    }

    while(HI_TRUE == state->bSaveThreadRun)
    {
        AIGetChannelsAndBitDepth(state->enAiPort, &state->stSndPortAttr, &u32Chn, &u32Bit);
        u32FrameSize = AUTIL_CalcFrameSize(u32Chn, u32Bit);
        u32NeedBytes= state->stSndPortAttr.u32PcmSamplesPerFrame * u32FrameSize;
        u32DataBytes = HAL_AIAO_P_QueryBufData_ProvideRptr(state->enPort, &state->u32SaveReadPos);

        if (u32DataBytes >= u32NeedBytes)        
        {
            if(state->pSaveBuf && state->fileHandle)
            {
                u32ReadBytes = HAL_AIAO_P_ReadData_NotUpRptr(state->enPort, (HI_U8*)state->pSaveBuf, u32NeedBytes, &state->u32SaveReadPos, &u32WritePos);
                if (u32ReadBytes != u32NeedBytes)
                {
                    HI_ERR_AI("Read Port Data Error!\n");
                    return HI_FAILURE;
                }    
                HI_DRV_FILE_Write(state->fileHandle, (HI_S8 *)state->pSaveBuf, u32NeedBytes);
            }
        }
        else
        {
            msleep(1);
        }
    }

    return HI_SUCCESS;
}

HI_S32 AI_WriteProc(HI_U32 u32Ai, AI_CMD_CTRL_E enCmd)
{
    AI_CHANNEL_STATE_S *state = HI_NULL;
    static struct  task_struct  *g_pstAiSaveThread = HI_NULL;
    HI_CHAR szPath[AI_PATH_NAME_MAXLEN + AI_FILE_NAME_MAXLEN] = {0};
    struct tm now;

    state = g_pstGlobalAIRS.pstAI_ATTR_S[u32Ai];
    if (!state)
    {
        HI_ERR_AI("this AI chn is not open!\n");
        return HI_FAILURE;
    }
    if(AI_CMD_CTRL_START == enCmd && AI_CMD_CTRL_STOP == state->enSaveState)
    {

        if(HI_SUCCESS != HI_DRV_FILE_GetStorePath(szPath, AI_PATH_NAME_MAXLEN))
        {
            HI_ERR_AI("get store path failed\n");
            return HI_FAILURE;
        }
        time_to_tm(get_seconds(), 0, &now);
        
        snprintf(szPath, sizeof(szPath), "%s/ai%d_%02u_%02u_%02u.pcm", szPath, u32Ai, now.tm_hour, now.tm_min, now.tm_sec);
        state->fileHandle = HI_DRV_FILE_Open(szPath, 1);
        if (!state->fileHandle)
        {
            HI_ERR_AI("open %s error\n", szPath);
            return HI_FAILURE;
        }

        state->pSaveBuf = HI_KMALLOC(HI_ID_AI, state->stAiBuf.u32Size, GFP_KERNEL);
        if(!state->pSaveBuf)
        {
            HI_DRV_FILE_Close(state->fileHandle);
            HI_ERR_AI("malloc save buffer failed\n");
            return HI_FAILURE;
        }

        state->bSaveThreadRun = HI_TRUE;
        g_pstAiSaveThread = kthread_create(AiSaveThread, &u32Ai, "AiSaveDataThread");
        if(HI_NULL == g_pstAiSaveThread)
        {
            HI_ERR_AO("creat ai save thread failed\n");
            return HI_FAILURE;
        }
        wake_up_process(g_pstAiSaveThread);

        state->u32SaveCnt++;
    }

    if(AI_CMD_CTRL_STOP == enCmd && AI_CMD_CTRL_START == state->enSaveState)
    {
        state->bSaveThreadRun = HI_FALSE;
        
        if(state->fileHandle)
        {
            HI_DRV_FILE_Close(state->fileHandle);
            state->fileHandle = HI_NULL;
        }
        if(state->pSaveBuf)
        {
            HI_KFREE(HI_ID_AI, state->pSaveBuf);
            state->pSaveBuf = HI_NULL;
        }
    }

    state->enSaveState = enCmd;

    return HI_SUCCESS;
}

static HI_VOID AIShowSpecAttr(struct seq_file* p, AI_CHANNEL_STATE_S *state)
{
    HI_UNF_AI_ADC_ATTR_S  stAdcAttr;
    HI_UNF_AI_I2S_ATTR_S  stI2sAttr;
    HI_UNF_AI_HDMI_ATTR_S stHDMIAttr;
    
    switch(state->enAiPort)
    {
        case HI_UNF_AI_I2S0:
        case HI_UNF_AI_I2S1:
            stI2sAttr = state->stSndPortAttr.unAttr.stI2sAttr;
            PROC_PRINT(p,
                "Channel                              :%d\n"
                "BitWidth                             :%d\n"
                "ClkMode                              :%s\n"
                "I2sMode                              :%s\n"
                "Mclk/Fs                              :%d\n"
                "Mclk/Bclk                            :%d\n"
                "SampleEdge                           :%s\n"
                "DelayCycle                           :%d\n",
                stI2sAttr.stAttr.enChannel,
                stI2sAttr.stAttr.enBitDepth,
                (HI_TRUE == stI2sAttr.stAttr.bMaster) ? "Master" : "Slave",
                (HI_UNF_I2S_STD_MODE == stI2sAttr.stAttr.enI2sMode) ? "Standard" : "Pcm",
                AUTIL_MclkFclkDiv(stI2sAttr.stAttr.enMclkSel),
                stI2sAttr.stAttr.enBclkSel,
                (HI_TRUE == stI2sAttr.stAttr.bPcmSampleRiseEdge) ? "Positive" : "Negative",
                stI2sAttr.stAttr.enPcmDelayCycle);
            break;
        case HI_UNF_AI_HDMI0:
        case HI_UNF_AI_HDMI1:
        case HI_UNF_AI_HDMI2:
        case HI_UNF_AI_HDMI3:
            stHDMIAttr = state->stSndPortAttr.unAttr.stHDMIAttr;
            PROC_PRINT(p,
                "Channel                              :%d\n"
                "BitWidth                             :%d\n"
                "Format                               :%s\n",           
                stHDMIAttr.enChannel,
                stHDMIAttr.enBitDepth,
                (HI_UNF_AI_HDMI_FORMAT_LPCM == stHDMIAttr.enHdmiAudioDataFormat) ? "Pcm" : ((HI_UNF_AI_HDMI_FORMAT_LBR == stHDMIAttr.enHdmiAudioDataFormat) ? "LBR" : "HBR"));
            break;
        case HI_UNF_AI_ADC0:
        case HI_UNF_AI_ADC1:
        case HI_UNF_AI_ADC2:
        case HI_UNF_AI_ADC3:
        case HI_UNF_AI_ADC4:
            stAdcAttr = state->stSndPortAttr.unAttr.stAdcAttr;
            PROC_PRINT(p,
                "Bypass                               :%s\n",
                (HI_TRUE == stAdcAttr.bByPass) ? "On" : "Off");
            break;
        default:
            break;
    }

    return;
}

static HI_S32 AI_ShowChnProc(struct seq_file* p, HI_U32 u32Chn)
{
    HI_S32 Ret;
    HI_U32 u32BufSizeUsed, u32BufPerCentUsed;
    AIAO_PORT_ID_E enPort;
    AIAO_PORT_STAUTS_S pstPortStatus;
    AI_CHANNEL_STATE_S *state = HI_NULL;
    
    state = g_pstGlobalAIRS.pstAI_ATTR_S[u32Chn];
    
    enPort = state->enPort;

    memset(&pstPortStatus, 0, sizeof(AIAO_PORT_STAUTS_S));
    Ret = HAL_AIAO_P_GetStatus(enPort, &pstPortStatus);
    if(HI_SUCCESS != Ret)
    {
        return Ret;
    }
    
    if(*(pstPortStatus.stCircBuf.pu32Write) >= *(pstPortStatus.stCircBuf.pu32Read))
    {
        u32BufSizeUsed = *(pstPortStatus.stCircBuf.pu32Write) - *(pstPortStatus.stCircBuf.pu32Read);
    }
    else
    {
        u32BufSizeUsed = pstPortStatus.stCircBuf.u32Lenght - (*(pstPortStatus.stCircBuf.pu32Read) - *(pstPortStatus.stCircBuf.pu32Write));
    }
    
    u32BufPerCentUsed = u32BufSizeUsed*100/pstPortStatus.stCircBuf.u32Lenght;

    PROC_PRINT( p, 
                "\n--------------------- AI%d[%s] Status ---------------------\n",
                u32Chn,
                AUTIL_AiPort2Name(state->enAiPort));
    PROC_PRINT(p,
               "Status                               :%s\n",
               (HI_CHAR*)((AIAO_PORT_STATUS_START == pstPortStatus.enStatus) ? "start" : ((AIAO_PORT_STATUS_STOP == pstPortStatus.enStatus) ? "stop" : "stopping")));
    PROC_PRINT(p,
               "SampleRate                           :%d\n",
               state->stSndPortAttr.enSampleRate);
    PROC_PRINT(p,
               "PcmFrameMaxNum                       :%d\n",
               state->stSndPortAttr.u32PcmFrameMaxNum);
    PROC_PRINT(p,
               "PcmSamplesPerFrame                   :%d\n",
               state->stSndPortAttr.u32PcmSamplesPerFrame);
    
    AIShowSpecAttr(p, state);
#if 0
    PROC_PRINT(p,
               "DelayCompensation                    :%dms\n",
               state->stDelayComps.u32DelayMs);
#endif
    PROC_PRINT(p,
               "*AiPort                              :0x%.2x\n",
               enPort);
    PROC_PRINT(p,
               "*Alsa                                :%s\n",
               (state->bAlsa == HI_TRUE) ? "Yes" : "No");
#if 0
    PROC_PRINT(p,
               "*DRE                                 :%s\n\n",
               (state->bDre == HI_TRUE) ? "On" : "Off");
#endif
    PROC_PRINT(p,
               "DmaCnt                               :%d\n",
               pstPortStatus.stProcStatus.uDMACnt);
    PROC_PRINT(p,
               "BufFullCnt                           :%d\n",
               pstPortStatus.stProcStatus.uBufFullCnt);
    PROC_PRINT(p,
               "FiFoFullCnt                          :%d\n",
               pstPortStatus.stProcStatus.uInfFiFoFullCnt);
    PROC_PRINT(p,
               "FrameBuf(Total/Use/Percent)(Bytes)   :%d/%d/%d%%\n",
               pstPortStatus.stBuf.u32BUFF_SIZE, u32BufSizeUsed, u32BufPerCentUsed);
    PROC_PRINT(p,
               "AcquireFrame(Try/OK)                 :%d/%d\n",
               state->stAiProc.u32AqcTryCnt, state->stAiProc.u32AqcCnt);
    PROC_PRINT(p,
               "ReleaseFrame(Try/OK)                 :%d/%d\n\n",
               state->stAiProc.u32RelTryCnt, state->stAiProc.u32RelCnt);

    return HI_SUCCESS;
}


HI_S32 AI_DRV_ReadProc( struct seq_file* p, HI_VOID* v )
{
    HI_S32 i;
    
    for (i = 0; i < AI_MAX_TOTAL_NUM; i++)
    {
        if(g_pstGlobalAIRS.pstAI_ATTR_S[i])
        {
            AI_ShowChnProc( p, i);
        }
    }

    return HI_SUCCESS;
}

HI_S32 AI_DRV_WriteProc( struct file* file, const char __user* buf, size_t count, loff_t* ppos )
{
    HI_S32 s32Ret;
    HI_U32 u32Ai;

    AI_CMD_PROC_E enProcCmd;
    AI_CMD_CTRL_E enCtrlCmd;

    HI_CHAR szBuf[48];
    HI_CHAR *pcBuf = szBuf;
    HI_CHAR *pcStartCmd = "start";
    HI_CHAR *pcStopCmd = "stop";
    HI_CHAR *pcSaveAICmd = "save";
    HI_CHAR *pcDreSwitch = "dre";
    HI_CHAR *pcOnCmd = "on";
    HI_CHAR *pcOffCmd = "off";
    HI_CHAR *pcSetAIDelayCmd = "setdelay";

    HI_CHAR *pcHelpCmd = "help";
    AI_CHANNEL_STATE_S *state = HI_NULL;

    struct seq_file *p = file->private_data;
    DRV_PROC_ITEM_S *pstProcItem = p->private;

    s32Ret = down_interruptible(&g_AIMutex);
    if (copy_from_user(szBuf, buf, count))
    {
        HI_ERR_AI("copy from user failed\n");
        up(&g_AIMutex);
        return HI_FAILURE;
    }

    // sizeof("ai") is 2
    u32Ai = (pstProcItem->entry_name[2] - '0');
    if(u32Ai >= AI_MAX_TOTAL_NUM)
    {
        HI_ERR_AI("Invalid Ai ID:%d.\n", u32Ai);
        goto SAVE_CMD_FAULT;
    }

    state = g_pstGlobalAIRS.pstAI_ATTR_S[u32Ai];
    if (HI_NULL == state)
    {
        HI_ERR_AI("this AI chn is not open!\n");
        goto SAVE_CMD_FAULT;
    }

    AI_STRING_SKIP_BLANK(pcBuf);
    if (strstr(pcBuf, pcSaveAICmd))
    {
        enProcCmd = AI_CMD_PROC_SAVE_AI;
        pcBuf += strlen(pcSaveAICmd);
    }
    else if (strstr(pcBuf, pcDreSwitch))
    {
        enProcCmd = AI_CMD_PROC_DRE_SWITCH;
        pcBuf += strlen(pcDreSwitch);
    }
    else if (strstr(pcBuf, pcSetAIDelayCmd))
    {
        enProcCmd = AI_CMD_PROC_SET_DELAY;
        pcBuf += strlen(pcSetAIDelayCmd);
    }
    else if (strstr(pcBuf, pcHelpCmd))
    {
        AI_PROC_SHOW_HELP(u32Ai);
        up(&g_AIMutex);
        return count;
    }
    else
    {
        goto SAVE_CMD_FAULT;
    }
    
    AI_STRING_SKIP_BLANK(pcBuf);

    if(AI_CMD_PROC_SAVE_AI == enProcCmd)
    {
        if (strstr(pcBuf,pcStartCmd))
        {
            enCtrlCmd = AI_CMD_CTRL_START;
        }
        else if (strstr(pcBuf,pcStopCmd))
        {
            enCtrlCmd = AI_CMD_CTRL_STOP;
        }
        else
        {
            goto SAVE_CMD_FAULT;
        }
        s32Ret = AI_WriteProc(u32Ai, enCtrlCmd);
        if (s32Ret != HI_SUCCESS)
        {
            goto SAVE_CMD_FAULT;
        }
    }
    
    if(AI_CMD_PROC_DRE_SWITCH == enProcCmd)
    {
        if (strstr(pcBuf,pcOnCmd))
        {
            (HI_VOID)AO_Track_SetDre(state->hTrack, HI_TRUE);
            state->bDre = HI_TRUE;
        }
        else if (strstr(pcBuf,pcOffCmd))
        {
            (HI_VOID)AO_Track_SetDre(state->hTrack, HI_FALSE);
            state->bDre = HI_FALSE;
        }
        else
        {
            goto SAVE_CMD_FAULT;
        }
    }

    if(AI_CMD_PROC_SET_DELAY == enProcCmd)
    {
        HI_U32  u32AIDelay = 0;
        HI_UNF_AI_DELAY_S   stDelayComps;
        AI_CHANNEL_STATUS_E enStatusTmp;

        if (pcBuf[0] < '0' || pcBuf[0] > '9')//do not have param
        {
            return HI_FAILURE;
        }

        u32AIDelay = (HI_U32)simple_strtoul(pcBuf, &pcBuf, 10);

        stDelayComps.bDelayMsAutoHold = HI_FALSE;
        stDelayComps.u32DelayMs       = u32AIDelay;

        enStatusTmp = state->enCurnStatus;
        
        if (AI_CHANNEL_STATUS_START == enStatusTmp)
        {
            AI_SetEnable(u32Ai, HI_FALSE, HI_FALSE);
        }
        
        s32Ret = AI_SetDelayComps(u32Ai, &stDelayComps);
        HI_DRV_PROC_EchoHelper("Set AI Delay %s!\n",
            (HI_SUCCESS == s32Ret) ? "success" : "faiure");

        if (AI_CHANNEL_STATUS_START == enStatusTmp)
        {
            AI_SetEnable(u32Ai, HI_TRUE, HI_FALSE);
        }
    }

    up(&g_AIMutex);
    return count;

SAVE_CMD_FAULT:

    HI_ERR_AI("proc cmd is fault\n");
    AI_PROC_SHOW_HELP(u32Ai);
    up(&g_AIMutex);

    return HI_FAILURE;
}

static HI_S32 AI_RegProc(HI_U32 u32Ai)
{
    HI_CHAR aszBuf[16];
    DRV_PROC_ITEM_S*  pProcItem;

    /* Check parameters */
    if (HI_NULL == g_pstGlobalAIRS.pstProcParam)
    {
        return HI_FAILURE;
    }

    /* Create proc */
    snprintf(aszBuf, sizeof(aszBuf), "ai%d", u32Ai);
    pProcItem = HI_DRV_PROC_AddModule(aszBuf, HI_NULL, HI_NULL);
    if (!pProcItem)
    {
        HI_FATAL_AO("Create ai proc entry fail!\n");
        return HI_FAILURE;
    }

    /* Set functions */
    pProcItem->read  = g_pstGlobalAIRS.pstProcParam->pfnReadProc;
    pProcItem->write = g_pstGlobalAIRS.pstProcParam->pfnWriteProc;

    HI_INFO_AO("Create Ai proc entry for OK!\n");
    return HI_SUCCESS;
}

static HI_VOID AI_UnRegProc(HI_U32 u32Ai)
{
    HI_CHAR aszBuf[16];
    snprintf(aszBuf, sizeof(aszBuf), "ai%d", u32Ai);

    HI_DRV_PROC_RemoveModule(aszBuf);
}

HI_S32 AI_DRV_RegisterProc(AI_REGISTER_PARAM_S * pstParam)
{
    /* Check parameters */
    if (HI_NULL == pstParam)
    {
        return HI_FAILURE;
    }

    g_pstGlobalAIRS.pstProcParam = pstParam;

    /* Create proc when use*/

    return HI_SUCCESS;
}

HI_VOID AI_DRV_UnregisterProc(HI_VOID)
{

    /* Clear param */
    g_pstGlobalAIRS.pstProcParam = HI_NULL;
    return;
}

HI_S32 AI_DRV_Suspend(PM_BASEDEV_S* pdev, pm_message_t   state)
{
#if defined (HI_AI_DRV_SUSPEND_SUPPORT)  
    HI_U32 i;
    HI_S32 s32Ret;
    AI_CHANNEL_STATE_S *pAistate = HI_NULL;
    
    s32Ret = down_interruptible(&g_AIMutex);
    if(0 != atomic_read(&g_AIOpenCnt))
    {
        for(i=0; i<AI_MAX_TOTAL_NUM; i++)
        {
            if (g_pstGlobalAIRS.pstAI_ATTR_S[i])
            {
                pAistate = g_pstGlobalAIRS.pstAI_ATTR_S[i];
                s32Ret = AI_Destory(i);
				if(HI_SUCCESS != s32Ret)
        		{
            		HI_FATAL_AI("AI Destory fail\n");
            		up(&g_AIMutex);
            		return HI_FAILURE;
        		}
            }
        }
        
        s32Ret = HAL_AIAO_Suspend();
        if(HI_SUCCESS != s32Ret)
        {
            HI_FATAL_AI("AIAO Suspend fail\n");
            up(&g_AIMutex);
            return HI_FAILURE;
        }
    }
    HI_PRINT("AI suspend OK\n");
#endif
    up(&g_AIMutex);
    return HI_SUCCESS;
}

HI_S32 AI_DRV_Resume(PM_BASEDEV_S * pdev)
{
#if defined (HI_AI_DRV_SUSPEND_SUPPORT)    
    HI_S32 s32Ret;
    HI_U32 i;
    HI_UNF_AI_E enAiPort;
    HI_UNF_AI_ATTR_S stAiAttr;
    HI_BOOL bAlsa;
    HI_VOID *pAlsaPara;
    AI_CHANNEL_STATE_S *state = HI_NULL;
    AI_CHANNEL_STATUS_E  enAiStatus;
    
    s32Ret = down_interruptible(&g_AIMutex);
    
    if(0 != atomic_read(&g_AIOpenCnt))
    {
        s32Ret = HAL_AIAO_Resume();
        if (HI_SUCCESS != s32Ret)
        {
            HI_FATAL_AI("AIAO Resume fail\n");
            up(&g_AIMutex);
            return HI_FAILURE;
        }

        for (i = 0; i < AI_MAX_TOTAL_NUM; i++)
        {
            if (g_pstGlobalAIRS.pstAI_ATTR_S[i])
            {
                state = g_pstGlobalAIRS.pstAI_ATTR_S[i];
                enAiPort = state->enAiPort;
                stAiAttr = state->stSndPortAttr;
                bAlsa = state->bAlsa;
                pAlsaPara = state->pAlsaPara;
                enAiStatus= state->enCurnStatus;
#ifdef HI_ALSA_AI_SUPPORT
                if (bAlsa == HI_TRUE)
                {                     
                     pAlsaPara= (void*)&g_stAlsaAttr;                    
                }
#endif
                s32Ret = AI_Create(enAiPort, &stAiAttr, bAlsa, pAlsaPara, i);
                
                if (HI_SUCCESS != s32Ret)
                {
                    HI_FATAL_AI("AICreateChn failed\n");
                    up(&g_AIMutex);
                    return HI_FAILURE;
                }
                
                if ((AI_CHANNEL_STATUS_START == enAiStatus) && (!(state->bAttach)))
                {
                    s32Ret = AI_SetEnable(i, HI_TRUE, HI_FALSE);
                    if (HI_SUCCESS != s32Ret)
                    {
                        HI_ERR_AI("Set AI Enable failed\n");
                        up(&g_AIMutex);
                        return HI_FAILURE;
                    }                
                }
            }
        }
    }
    up(&g_AIMutex);
    HI_PRINT("AI resume OK\n");
#endif
    return HI_SUCCESS;
}

HI_S32 AI_DRV_Init(HI_VOID)
{
    HI_S32 s32Ret;

    s32Ret = down_interruptible(&g_AIMutex);
    s32Ret = HI_DRV_MODULE_Register(HI_ID_AI, AI_NAME,(HI_VOID*)&g_pstGlobalAIRS.stExtFunc);
    if (HI_SUCCESS != s32Ret)
    {
        HI_FATAL_AI("Reg Ai module fail:%#x!\n", s32Ret);
        up(&g_AIMutex);
        return s32Ret;
    }

    up(&g_AIMutex);
    return HI_SUCCESS;
}

HI_VOID AI_DRV_Exit(HI_VOID)
{
    HI_S32 s32Ret;

    s32Ret = down_interruptible(&g_AIMutex);
    
    HI_DRV_MODULE_UnRegister(HI_ID_AI);

    up(&g_AIMutex);
    return;
}

HI_S32 HI_DRV_AI_Init(HI_VOID)
{
    return AI_DRV_Init();
}

HI_VOID HI_DRV_AI_DeInit(HI_VOID)
{
    AI_DRV_Exit();
}

HI_S32 HI_DRV_AI_Drv_Open(HI_VOID)
{
    return AI_DRV_Open(NULL, &g_file);
}

HI_S32 HI_DRV_AI_Drv_Release(HI_VOID)
{
    return AI_DRV_Release(NULL, &g_file);
}

HI_S32 HI_DRV_AI_SND_GetDefaultOpenAttr(HI_UNF_AI_E enAiPort, HI_UNF_AI_ATTR_S *pstAttr)
{
    return AI_GetDefaultAttr(enAiPort, pstAttr);   
}

HI_S32 HI_DRV_AI_Create(HI_UNF_AI_E enAiPort, HI_UNF_AI_ATTR_S *pstAttr, HI_HANDLE *phandle)
{
    HI_S32 Ret;
    AI_Create_Param_S stAiParam;
    HI_HANDLE hAi = HI_NULL;
    
    stAiParam.enAiPort = enAiPort;
    stAiParam.bAlsaUse = HI_FALSE;

    memcpy(&stAiParam.stAttr, pstAttr, sizeof(HI_UNF_AI_ATTR_S));

    Ret = AI_AllocHandle(&hAi, &g_file, stAiParam.enAiPort, stAiParam.bAlsaUse, &stAiParam.stAttr);
    if(HI_SUCCESS != Ret)
    {
        HI_ERR_AI("Alloc Ai Handle failed!");
        return Ret;
    }
    
    Ret = AI_Create(stAiParam.enAiPort, &stAiParam.stAttr, stAiParam.bAlsaUse, HI_NULL, hAi);
    if(HI_SUCCESS != Ret)
    {
        HI_ERR_AI("Ai Create failed 0x%x!", Ret);
        return Ret;
    }

    if (HI_NULL != hAi)
    {
        *phandle = hAi;
    }

    return Ret;
}

HI_S32 HI_DRV_AI_Destroy(HI_HANDLE hAi)
{
    HI_S32 Ret;

    CHECK_AI_CHN_OPEN(hAi);

    Ret = AI_Destory(hAi);
    if (HI_SUCCESS != Ret)
    {
        return Ret;
    }
    
    AI_FreeHandle(hAi);

    return Ret;
}

HI_S32 HI_DRV_AI_SetEnable(HI_HANDLE hAi, HI_BOOL bEnable)
{
    CHECK_AI_CHN_OPEN(hAi);
    return AI_SetEnable(hAi, bEnable, HI_FALSE);   
}

HI_S32 HI_DRV_AI_GetEnable(HI_HANDLE hAi, HI_BOOL *pbEnable)
{
    CHECK_AI_CHN_OPEN(hAi);
    return AI_GetEnable(hAi, pbEnable);   
}

HI_S32 HI_DRV_AI_GetAttr(HI_HANDLE hAi, HI_UNF_AI_ATTR_S *pstAttr)
{
    CHECK_AI_CHN_OPEN(hAi);
    return AI_GetAttr(hAi, pstAttr);
}

HI_S32 HI_DRV_AI_SetAttr(HI_HANDLE hAi, HI_UNF_AI_ATTR_S *pstAttr)
{
    CHECK_AI_CHN_OPEN(hAi);
    return AI_SetAttr(hAi, pstAttr);
}

HI_S32 HI_DRV_AI_AcquireFrame(HI_HANDLE hAi, AO_FRAMEINFO_S *pstFrame)
{
    HI_S32 Ret;
    AI_BUF_ATTR_S stAiBuf;
    
    CHECK_AI_CHN_OPEN(hAi);

    Ret = AI_GetAiBufInfo(hAi, &stAiBuf);
    if(HI_SUCCESS != Ret)
    {
        HI_ERR_AI("Alloc Ai Get BufInfo failed!");
        return Ret;
    }
    
    Ret = AI_AcquireFrame(hAi, pstFrame);
    if(HI_SUCCESS != Ret)
    {
        HI_ERR_AI("Alloc Ai Get AcquireFrame failed!");
        return Ret;
    }
    pstFrame->tPcmBuffer = stAiBuf.tKernelVirBaseAddr; 
    return Ret;
}

HI_S32 HI_DRV_AI_ReleaseFrame(HI_HANDLE hAi, AO_FRAMEINFO_S *pstFrame)
{
    CHECK_AI_CHN_OPEN(hAi);
    return AI_ReleaseFrame(hAi, pstFrame);
}
