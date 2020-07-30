#include <linux/version.h>
#include <linux/proc_fs.h>
#include <linux/ioport.h>
#include <linux/string.h>
#include <linux/ioctl.h>
#include <linux/fs.h>
#include <linux/delay.h>

#include <asm/uaccess.h>
#include <asm/io.h>
#include <linux/seq_file.h>

#include "hi_drv_mmz.h"
#include "hi_drv_stat.h"
#include "hi_drv_sys.h"
#include "hi_drv_proc.h"

#include "hi_audsp_aflt.h"
#include "hal_aflt.h"

#ifdef __cplusplus
 #if __cplusplus
extern "C" {
 #endif
#endif /* End of #ifdef __cplusplus */

static volatile S_AFLT_COM_ATTR*       g_pAfltComReg;  
static volatile S_AFLT_REGS_TYPE*       g_pAfltChnReg[AFLT_MAX_CHAN_NUM];
static HI_VOID *pRegMapAddr = NULL;
static HI_BOOL g_bSwAfltFlag = HI_TRUE;  /* HI_TRUE: sw; HI_FALSE: hw */

static AFLT_CHN_STATE_S g_AfltRm[AFLT_MAX_CHAN_NUM];


static HI_VOID AFLTIOAddressMap(HI_U32 u32AfltRegBase)
{
    HI_U32 u32AfltId;

    pRegMapAddr = ioremap_nocache(u32AfltRegBase, AFLT_REG_LENGTH);

    /* reg map */
    g_pAfltComReg = (S_AFLT_COM_ATTR *)(pRegMapAddr + AFLT_COM_REG_OFFSET);
    for (u32AfltId = 0; u32AfltId < AFLT_MAX_CHAN_NUM; u32AfltId++)
    {
        g_pAfltChnReg[u32AfltId] = (S_AFLT_REGS_TYPE *)((pRegMapAddr + AFLT_CHN_REG_OFFSET) + AFLT_CHN_REG_BANDSIZE * u32AfltId);
    }

    return;
}

static HI_VOID AFLTIOaddressUnmap(HI_VOID)
{
    HI_U32 u32AfltId;

    /* reg ummap */
    for (u32AfltId = 0; u32AfltId < AFLT_MAX_CHAN_NUM; u32AfltId++)
    {
        g_pAfltChnReg[u32AfltId] = HI_NULL;
    }

    g_pAfltComReg= HI_NULL;

    if (pRegMapAddr)
    {
        iounmap(pRegMapAddr);
        pRegMapAddr = 0;
    }
}

AFLT_CMD_RET_E  iHAL_AFLT_AckCmd(HI_U32 u32AfltId)
{
    S_AFLT_REGS_TYPE *AfltReg = (S_AFLT_REGS_TYPE *)g_pAfltChnReg[u32AfltId];
    volatile HI_U32 u32LoopOuter = 0;
    volatile HI_U32 u32LoopInner = 0;

    for (u32LoopOuter = 0; u32LoopOuter < 100; u32LoopOuter++)
    {
        for(u32LoopInner = 0; u32LoopInner < 8; u32LoopInner++)
        {
            if (AfltReg->CTRL.bits.cmd_done)
            {
                return (AFLT_CMD_RET_E)AfltReg->CTRL.bits.cmd_return_value;
            }
            udelay(10);
        }
        msleep(1);
    }

    return AFLT_CMD_ERR_TIMEOUT;
}

AFLT_CMD_RET_E  iHAL_AFLT_NoBlock_AckCmd(HI_U32 u32AfltId)
{
    S_AFLT_REGS_TYPE *AfltReg = (S_AFLT_REGS_TYPE *)g_pAfltChnReg[u32AfltId];
    volatile HI_U32 loop = 0;  //TODO volatile?

    for (loop = 0; loop < 800; loop++)
    {
        if (AfltReg->CTRL.bits.cmd_done)
        {
            return (AFLT_CMD_RET_E)AfltReg->CTRL.bits.cmd_return_value;
        }
    }

    return AFLT_CMD_DONE;
}

HI_S32 iHAL_AFLT_SetCmd(HI_U32 u32AfltId, AFLT_CMD_E enNewCmd)
{
    S_AFLT_REGS_TYPE *AfltReg = (S_AFLT_REGS_TYPE *)g_pAfltChnReg[u32AfltId];
    AFLT_CMD_RET_E Ack;

    switch (enNewCmd)
    {
    case AFLT_CMD_CREATE:
    case AFLT_CMD_DESTROY:
    case AFLT_CMD_START:
    case AFLT_CMD_STOP:
    case AFLT_CMD_SETPARAM:
    case AFLT_CMD_GETPARAM:
    case AFLT_CMD_SETCONFIG:
    case AFLT_CMD_GETCONFIG:
    case AFLT_CMD_RESTORESETTING:
    case AFLT_CMD_STORESETTING:
    case AFLT_CMD_INITINBUF:
    case AFLT_CMD_DEINITINBUF:
    case AFLT_CMD_INITOUTBUF:
    case AFLT_CMD_DEINITOUTBUF:
        AfltReg->CTRL.bits.cmd = (HI_U32)enNewCmd;
        break;

    default:
        return HI_SUCCESS;
    }

    AfltReg->CTRL.bits.cmd_done = 0;
    Ack = iHAL_AFLT_AckCmd(u32AfltId);  //TODO use noblock or block  //iHAL_AFLT_NoBlock_AckCmd  only config use noBlock?
    if (AFLT_CMD_DONE != Ack)
    {
        HI_ERR_AFLT("Aflt(%d) ack cmd(%d) failed(0x%x)", u32AfltId, enNewCmd, Ack);
        return HI_FAILURE;
    }

    return HI_SUCCESS;
}


HI_VOID AFLT_HAL_Init(HI_U32 u32AfltRegBase, HI_BOOL bSwAfltFlag)
{
    AFLTIOAddressMap(u32AfltRegBase);
    //AFLTInitGlobalSource();
    g_bSwAfltFlag = bSwAfltFlag;

    return;
}

HI_VOID AFLT_HAL_DeInit(HI_VOID)
{
    //AFLTDewInitGlobalSource();
    AFLTIOaddressUnmap();

    return;
}

HI_S32 AFLT_HAL_Create(HI_U32 u32AfltId, AFLT_CREATE_ATTR_S* pstAttr)
{
    HI_S32 ret;
    HI_U32 i;
    AFLT_CHN_STATE_S *state = &g_AfltRm[u32AfltId];
    S_AFLT_REGS_TYPE *AfltReg = (S_AFLT_REGS_TYPE *)g_pAfltChnReg[u32AfltId];

    AfltReg->ATTR.bits.master_flag = (HI_TRUE == pstAttr->bMaster)?1:0;
    AfltReg->ATTR.bits.filter_id   = (HI_U32)pstAttr->enAfltCompId;
    for(i = 0; i < AFLT_CUSTOMER_AUTHKEY_SIZE; i++)
    {
        AfltReg->AUTH_KEY[i] = pstAttr->au32AuthKey[i];
    }
    
    ret = iHAL_AFLT_SetCmd(u32AfltId, AFLT_CMD_CREATE);
    if(HI_SUCCESS != ret)
    {
        HI_ERR_AFLT("set alft(%d) create cmd failed\n", u32AfltId);
        return ret;
    }
    state->enCurnStatus = AFLT_STATUS_STOP;
    
    return HI_SUCCESS;
}

HI_S32 AFLT_HAL_Destroy(HI_U32 u32AfltId)
{
    HI_S32 ret;

    ret = iHAL_AFLT_SetCmd(u32AfltId, AFLT_CMD_DESTROY);
    if(HI_SUCCESS != ret)
    {
        HI_ERR_AFLT("set alft(%d) destroy cmd failed\n", u32AfltId);
        return ret;
    }

    //TODO   about state
    return HI_SUCCESS;
}

HI_S32 AFLT_HAL_Start(HI_U32 u32AfltId)
{
    HI_S32 ret;
    AFLT_CHN_STATE_S *state = &g_AfltRm[u32AfltId];

    ret = iHAL_AFLT_SetCmd(u32AfltId, AFLT_CMD_START);
    if(HI_SUCCESS != ret)
    {
        HI_ERR_AFLT("set alft(%d) start cmd failed\n", u32AfltId);
        return ret;
    }
    state->enCurnStatus = AFLT_STATUS_START;
    
    return HI_SUCCESS;
}

HI_S32 AFLT_HAL_Stop(HI_U32 u32AfltId)
{
    HI_S32 ret;
    AFLT_CHN_STATE_S *state = &g_AfltRm[u32AfltId];

    ret = iHAL_AFLT_SetCmd(u32AfltId, AFLT_CMD_STOP);
    if(HI_SUCCESS != ret)
    {
        HI_ERR_AFLT("set alft(%d) stop cmd failed\n", u32AfltId);
        return ret;
    }
    state->enCurnStatus = AFLT_STATUS_STOP;
    
    return HI_SUCCESS;
}

//TODO
HI_S32 AFLT_HAL_SetParam(HI_U32 u32AfltId, AFLT_PARAM_S stParam)
{
    HI_S32 ret;
    U_CTRL Ctrl;
    S_AFLT_REGS_TYPE *AfltReg = (S_AFLT_REGS_TYPE *)g_pAfltChnReg[u32AfltId];

    Ctrl.u32 = AfltReg->CTRL.u32;
    Ctrl.bits.param_index = stParam.u32ParamIndex;
    Ctrl.bits.param_wordsize = stParam.u32ParamStructSize; 
    AfltReg->CTRL.u32 = Ctrl.u32;

    ret = iHAL_AFLT_SetCmd(u32AfltId, AFLT_CMD_SETPARAM);
    if(HI_SUCCESS != ret)
    {
        HI_ERR_AFLT("set alft(%d) param cmd failed\n", u32AfltId);
        return ret;
    }

    return HI_SUCCESS;
}

HI_S32 AFLT_HAL_GetParam(HI_U32 u32AfltId, AFLT_PARAM_S *pstParam)
{
    HI_S32 ret;
    U_CTRL Ctrl;
    S_AFLT_REGS_TYPE *AfltReg = (S_AFLT_REGS_TYPE *)g_pAfltChnReg[u32AfltId];

    Ctrl.u32 = AfltReg->CTRL.u32;
    Ctrl.bits.param_index = pstParam->u32ParamIndex;  
    AfltReg->CTRL.u32 = Ctrl.u32;

    ret = iHAL_AFLT_SetCmd(u32AfltId, AFLT_CMD_GETPARAM);
    if(HI_SUCCESS != ret)
    {
        HI_ERR_AFLT("get alft(%d) param cmd failed\n", u32AfltId);
        return ret;
    }

    pstParam->u32ParamStructSize = AfltReg->CTRL.bits.param_wordsize; 
    
    return HI_SUCCESS;
}

HI_S32 AFLT_HAL_SetConfig(HI_U32 u32AfltId, AFLT_CONFIG_S stConfig)
{
    HI_S32 ret;
    U_CTRL Ctrl;
    S_AFLT_REGS_TYPE *AfltReg = (S_AFLT_REGS_TYPE *)g_pAfltChnReg[u32AfltId];

    Ctrl.u32 = AfltReg->CTRL.u32;
    Ctrl.bits.param_index = stConfig.u32ConfigIndex;
    Ctrl.bits.param_wordsize = stConfig.u32ConfigStructSize; 
    AfltReg->CTRL.u32 = Ctrl.u32;

    ret = iHAL_AFLT_SetCmd(u32AfltId, AFLT_CMD_SETCONFIG);
    if(HI_SUCCESS != ret)
    {
        HI_ERR_AFLT("set alft(%d) config cmd failed\n", u32AfltId);
        return ret;
    }

    return HI_SUCCESS;
}

HI_S32 AFLT_HAL_GetConfig(HI_U32 u32AfltId, AFLT_CONFIG_S *pstConfig)
{
    HI_S32 ret;
    U_CTRL Ctrl;
    S_AFLT_REGS_TYPE *AfltReg = (S_AFLT_REGS_TYPE *)g_pAfltChnReg[u32AfltId];

    Ctrl.u32 = AfltReg->CTRL.u32;
    Ctrl.bits.param_index = pstConfig->u32ConfigIndex; 
    AfltReg->CTRL.u32 = Ctrl.u32;

    ret = iHAL_AFLT_SetCmd(u32AfltId, AFLT_CMD_GETCONFIG);
    if(HI_SUCCESS != ret)
    {
        HI_ERR_AFLT("get alft(%d) config cmd failed\n", u32AfltId);
        return ret;
    }

    pstConfig->u32ConfigStructSize = AfltReg->CTRL.bits.param_wordsize; 
    
    return HI_SUCCESS;
}

HI_S32 AFLT_HAL_RestoreSetting(HI_U32 u32AfltId)
{
    HI_S32 ret;

    ret = iHAL_AFLT_SetCmd(u32AfltId, AFLT_CMD_RESTORESETTING);
    if(HI_SUCCESS != ret)
    {
        HI_ERR_AFLT("restore alft(%d) setting cmd failed\n", u32AfltId);
        return ret;
    }

    return HI_SUCCESS;
}

HI_S32 AFLT_HAL_StoreSetting(HI_U32 u32AfltId)
{
    HI_S32 ret;

    ret = iHAL_AFLT_SetCmd(u32AfltId, AFLT_CMD_STORESETTING);
    if(HI_SUCCESS != ret)
    {
        HI_ERR_AFLT("store alft(%d) setting cmd failed\n", u32AfltId);
        return ret;
    }

    return HI_SUCCESS;
}

HI_S32 AFLT_HAL_GetCunrStatus(HI_U32 u32AfltId, AFLT_STATUS_E *pstCunrStatus)
{
    *pstCunrStatus = g_AfltRm[u32AfltId].enCurnStatus;
    return HI_SUCCESS;
}

HI_VOID AFLT_HAL_SetMsgPoolAttr(HI_U32 u32AfltId, HAL_AFLT_MSGPOOL_ATTR_S *pstAttr)
{
    U_ATTR Attr;
    S_AFLT_REGS_TYPE *AfltReg = (S_AFLT_REGS_TYPE *)g_pAfltChnReg[u32AfltId];

    Attr.u32 = AfltReg->ATTR.u32;

    if(HI_TRUE == g_bSwAfltFlag)
    {
        ADSP_WriteAddr(pstAttr->tBufVirAddr, AfltReg->MSGPOOL_ADDR);
    }
    else
    {
        ADSP_WriteAddr(pstAttr->tBufPhyAddr, AfltReg->MSGPOOL_ADDR);
    }
    Attr.bits.msgpool_size = pstAttr->u32MsgPoolSize;
    AfltReg->ATTR.u32 = Attr.u32;
    
    return;
}

HI_S32 AFLT_HAL_InitInbuf(HI_U32 u32AfltId, HAL_AFLT_INBUF_ATTR_S* pstAttr)
{
    HI_S32 ret;
    U_IP_BUF_SIZE IpBufSize;
    S_AFLT_REGS_TYPE *AfltReg = (S_AFLT_REGS_TYPE *)g_pAfltChnReg[u32AfltId];   
    
    IpBufSize.u32 = AfltReg->IP_BUF_SIZE.u32;
    if(HI_TRUE == g_bSwAfltFlag)
    {
        ADSP_WriteAddr(pstAttr->tBufVirAddr, AfltReg->IP_BUF_ADDR);
    }
    else
    {
        ADSP_WriteAddr(pstAttr->tBufPhyAddr, AfltReg->IP_BUF_ADDR);
    }
    IpBufSize.bits.inbuff_size = pstAttr->u32BufSize;
    IpBufSize.bits.inbuff_flag = pstAttr->u32BufFlag;
    IpBufSize.bits.inbuff_eos_flag = (HI_TRUE == pstAttr->bEosFlag) ? 1 : 0;
    AfltReg->IP_BUF_SIZE.u32 = IpBufSize.u32;
    
    AfltReg->IP_BUF_WPTR = pstAttr->u32Wpos;
    AfltReg->IP_BUF_RPTR = pstAttr->u32Rpos;
    AfltReg->READPOS  = pstAttr->u32StreamReadPos;
    AfltReg->IPBUF_BOUNDARY = pstAttr->u32PtsBoundary;

    ret = iHAL_AFLT_SetCmd(u32AfltId, AFLT_CMD_INITINBUF);
    if(HI_SUCCESS != ret)
    {
        HI_ERR_AFLT("Init alft(%d) inbuf cmd failed\n", u32AfltId);
        return ret;
    }

    return HI_SUCCESS;
}

HI_S32 AFLT_HAL_DeInitInbuf(HI_U32 u32AfltId)
{
    HI_S32 ret;

    ret = iHAL_AFLT_SetCmd(u32AfltId, AFLT_CMD_DEINITINBUF);
    if(HI_SUCCESS != ret)
    {
        HI_ERR_AFLT("Deinit alft(%d) inbuf cmd failed\n", u32AfltId);
        return ret;
    }

    return HI_SUCCESS;
}

HI_S32 AFLT_HAL_InitOutbuf(HI_U32 u32AfltId, HAL_AFLT_OUTBUF_ATTR_S* pstAttr)
{
    HI_S32 ret;
    U_OP_BUF_SIZE OpBufSize;
    U_OP_BUF_WIDX OpBufWidx;
    U_OP_BUF_RIDX OpBufRidx;
    S_AFLT_REGS_TYPE *AfltReg = (S_AFLT_REGS_TYPE *)g_pAfltChnReg[u32AfltId];  

    OpBufSize.u32 = AfltReg->OP_BUF_SIZE.u32;
    
    if (HI_TRUE == g_bSwAfltFlag)
    {
        ADSP_WriteAddr(pstAttr->tBufVirAddr, AfltReg->OP_BUF_ADDR);
    }
    else
    {
        ADSP_WriteAddr(pstAttr->tBufPhyAddr, AfltReg->OP_BUF_ADDR);
    }
    OpBufWidx.u32 = AfltReg->OP_BUF_WIDX.u32;
    OpBufRidx.u32 = AfltReg->OP_BUF_RIDX.u32;
    
    OpBufSize.bits.periond_size  = pstAttr->u32PeriodBufSize;
    OpBufSize.bits.periond_num = pstAttr->u32PeriodNumber;
    OpBufWidx.bits.periond_write_idx = pstAttr->u32Widx;
    OpBufWidx.bits.periond_write_wrap = pstAttr->u32Wwrap;
    OpBufRidx.bits.periond_read_idx = pstAttr->u32Ridx;
    OpBufRidx.bits.periond_read_wrap = pstAttr->u32Rwrap;

    AfltReg->OP_BUF_SIZE.u32 = OpBufSize.u32;
    AfltReg->OP_BUF_WIDX.u32 = OpBufWidx.u32 ;
    AfltReg->OP_BUF_RIDX.u32 = OpBufRidx.u32;

    ret = iHAL_AFLT_SetCmd(u32AfltId, AFLT_CMD_INITOUTBUF);
    if(HI_SUCCESS != ret)
    {
        HI_ERR_AFLT("Init alft(%d) outbuf cmd failed\n", u32AfltId);
        return ret;
    }

    return HI_SUCCESS;
}

HI_S32 AFLT_HAL_DeInitOutbuf(HI_U32 u32AfltId)
{
    HI_S32 ret;

    ret = iHAL_AFLT_SetCmd(u32AfltId, AFLT_CMD_DEINITOUTBUF);
    if(HI_SUCCESS != ret)
    {
        HI_ERR_AFLT("Deinit alft(%d) outbuf cmd failed\n", u32AfltId);
        return ret;
    }

    return HI_SUCCESS;
}

HI_VOID AFLT_HAL_GetInbufWritePos(HI_U32 u32AfltId, HI_U32 *pu32WritePos)
{
    S_AFLT_REGS_TYPE *AfltReg = (S_AFLT_REGS_TYPE *)g_pAfltChnReg[u32AfltId];

    *pu32WritePos = AfltReg->IP_BUF_WPTR;
}

HI_VOID AFLT_HAL_GetInbufReadPos(HI_U32 u32AfltId, HI_U32 *pu32ReadPos)
{
    S_AFLT_REGS_TYPE *AfltReg = (S_AFLT_REGS_TYPE *)g_pAfltChnReg[u32AfltId];

    *pu32ReadPos = AfltReg->IP_BUF_RPTR;
}

HI_VOID AFLT_HAL_GetInbufStreamReadPos(HI_U32 u32AfltId, HI_U32 *pu32StreamReadPos)
{
    S_AFLT_REGS_TYPE *AfltReg = (S_AFLT_REGS_TYPE *)g_pAfltChnReg[u32AfltId];

    *pu32StreamReadPos = AfltReg->READPOS;
}


HI_VOID AFLT_HAL_SetInbufWritePos(HI_U32 u32AfltId, HI_U32 u32WritePos)
{
    S_AFLT_REGS_TYPE *AfltReg = (S_AFLT_REGS_TYPE *)g_pAfltChnReg[u32AfltId];

    AfltReg->IP_BUF_WPTR = u32WritePos;
}

HI_VOID AFLT_HAL_GetOutbufWriteIdxAndWrap(HI_U32 u32AfltId, HI_U32 *pu32WriteIdx, HI_U32 *pu32WriteWrap)
{
    S_AFLT_REGS_TYPE *AfltReg = (S_AFLT_REGS_TYPE *)g_pAfltChnReg[u32AfltId];

    if(pu32WriteIdx)
        *pu32WriteIdx = AfltReg->OP_BUF_WIDX.bits.periond_write_idx;
    if(pu32WriteWrap)
        *pu32WriteWrap = AfltReg->OP_BUF_WIDX.bits.periond_write_wrap;
}

HI_VOID AFLT_HAL_GetOutbufReadIdxAndWrap(HI_U32 u32AfltId, HI_U32 *pu32ReadIdx, HI_U32 *pu32ReadWrap)
{
    S_AFLT_REGS_TYPE *AfltReg = (S_AFLT_REGS_TYPE *)g_pAfltChnReg[u32AfltId];

    if(pu32ReadIdx)
        *pu32ReadIdx = AfltReg->OP_BUF_RIDX.bits.periond_read_idx;
    if(pu32ReadWrap)
        *pu32ReadWrap = AfltReg->OP_BUF_RIDX.bits.periond_read_wrap;
}

HI_VOID AFLT_HAL_GetExeFrameStatisticsInfo(HI_U32 u32AfltId, HI_U32 *pu32TryExeCnt, HI_U32 *pu32FrameCnt, HI_U32 *pu32ErrFrameCnt)
{
    S_AFLT_REGS_TYPE *AfltReg = (S_AFLT_REGS_TYPE *)g_pAfltChnReg[u32AfltId];

    if(pu32TryExeCnt)
        *pu32TryExeCnt = AfltReg->TRY_EXE_CNT;
    if(pu32FrameCnt)
        *pu32FrameCnt = AfltReg->STATUS0.bits.frame_cnt;
    if(pu32ErrFrameCnt)
        *pu32ErrFrameCnt = AfltReg->STATUS0.bits.frame_err_cnt;
}

HI_VOID AFLT_HAL_GetTimeOutStatisticsInfo(HI_U32 u32AfltId, HI_U32 *pu32ScheTimeOutCnt, HI_U32 *pu32ExeTimeOutCnt)
{
    S_AFLT_REGS_TYPE *AfltReg = (S_AFLT_REGS_TYPE *)g_pAfltChnReg[u32AfltId];

    if(pu32ScheTimeOutCnt)
        *pu32ScheTimeOutCnt = AfltReg->TIMEOUT.bits.sche_timeout_cnt;
    if(pu32ExeTimeOutCnt)
        *pu32ExeTimeOutCnt = AfltReg->TIMEOUT.bits.exe_timeout_cnt;
}

HI_VOID AFLT_HAL_SetOutBufRptrAndWrap(HI_U32 u32AfltId, HI_U32 u32ReadIdx)
{
    HI_U32 u32ReadWrap = 0;
    HI_U32 u32PeriodNum = 0;
    U_OP_BUF_RIDX OpBufRidx;
    S_AFLT_REGS_TYPE *AfltReg = (S_AFLT_REGS_TYPE *)g_pAfltChnReg[u32AfltId];

    u32PeriodNum = AfltReg->OP_BUF_SIZE.bits.periond_num;
    OpBufRidx.u32 = AfltReg->OP_BUF_RIDX.u32;
    if(u32ReadIdx == u32PeriodNum)
    {
        OpBufRidx.bits.periond_read_idx = 0;
        u32ReadWrap = OpBufRidx.bits.periond_read_wrap;
        u32ReadWrap ^= 1;  //readidx wrap
        OpBufRidx.bits.periond_read_wrap = u32ReadWrap;
    }
    else
    {
        OpBufRidx.bits.periond_read_idx = u32ReadIdx;
    }
    AfltReg->OP_BUF_RIDX.u32 = OpBufRidx.u32;
        
    return;
}

HI_VOID AFLT_HAL_SetEosFlag(HI_U32 u32AfltId, HI_BOOL bEosFlag)
{
    U_ATTR Attr;
    S_AFLT_REGS_TYPE *AfltReg = (S_AFLT_REGS_TYPE *)g_pAfltChnReg[u32AfltId];

    Attr.u32 = AfltReg->ATTR.u32;
    Attr.bits.eos_flag = (HI_TRUE == bEosFlag)?1:0;
    Attr.bits.endofframe = 0;
    AfltReg->ATTR.u32 = Attr.u32;
}

HI_VOID AFLT_HAL_GetEndOfFrame(HI_U32 u32AfltId, HI_BOOL *pbEndOfFrame)
{
    S_AFLT_REGS_TYPE *AfltReg = (S_AFLT_REGS_TYPE *)g_pAfltChnReg[u32AfltId];

    *pbEndOfFrame = (0==AfltReg->ATTR.bits.endofframe) ? HI_FALSE : HI_TRUE;
}

#ifdef __cplusplus
 #if __cplusplus
}
 #endif
#endif /* End of #ifdef __cplusplus */

