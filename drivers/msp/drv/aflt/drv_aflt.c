
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

/* Drv headers */
#include "drv_aflt_private.h"
#include "drv_aflt_ioctl.h"


#ifdef __cplusplus
 #if __cplusplus
extern "C" {
 #endif
#endif /* __cplusplus */

/***************************** Static Definition *****************************/

DECLARE_MUTEX(g_AfltMutex);

static AFLT_GLOBAL_PARAM_S s_stAfltDrv =
{
    .u32ChanNum       = 0,
    .atmOpenCnt       = ATOMIC_INIT(0),
    .bReady           = HI_FALSE,
    .pstProcParam     = HI_NULL,
    .bAfltSwFlag      = HI_FALSE,
    .pAdspFunc        = HI_NULL,
};

/****************************** Static Function *********************************/
static HI_S32 AFLT_RegChanProc(HI_U32 u32AfltId)
{
    HI_CHAR aszBuf[16];
    DRV_PROC_ITEM_S *pstItem;

    /* Check parameters */
    if (HI_NULL == s_stAfltDrv.pstProcParam)
    {
        return HI_FAILURE;
    }

    /* Create proc */
    snprintf(aszBuf, sizeof(aszBuf), "aflt%02d", u32AfltId);
    pstItem = HI_DRV_PROC_AddModule(aszBuf, HI_NULL, HI_NULL);
    if (!pstItem)
    {
        HI_FATAL_AFLT("Create aflt proc fail!\n");
        return HI_FAILURE;
    }

    /* Set functions */
    pstItem->read  = s_stAfltDrv.pstProcParam->pfnReadProc;
    pstItem->write = s_stAfltDrv.pstProcParam->pfnWriteProc;

    HI_INFO_AFLT("Create proc for aflt%d OK!\n", u32AfltId);

    return HI_SUCCESS;
}

static HI_VOID AFLT_UnRegChanProc(HI_U32 u32AfltId)
{
    HI_CHAR aszBuf[16];

    snprintf(aszBuf, sizeof(aszBuf), "aflt%02d", u32AfltId);
    HI_DRV_PROC_RemoveModule(aszBuf);

    return;
}

static HI_S32 AFLT_Chan_AllocHandle(HI_HANDLE *phAflt, struct file *pstFile, AFLT_CREATE_ATTR_S  *pstCreateAttr)
{
    HI_U32 i;
    AFLT_CHANNEL_S *pState;
    HI_CHAR szMsgPoolMmzName[16];

    if (HI_NULL == phAflt)
    {
        HI_ERR_AFLT("null point!\n");
        return HI_FAILURE;
    }

    if (HI_NULL == pstCreateAttr)
    {
        HI_ERR_AFLT("null point!\n");
        return HI_FAILURE;
    }

    /* Check ready flag */
    if (s_stAfltDrv.bReady != HI_TRUE)
    {
        HI_ERR_AFLT("Need open dev first!\n");
        return HI_FAILURE;
    }

    /* Check channel number */
    if (s_stAfltDrv.u32ChanNum >= AFLT_MAX_CHAN_NUM)
    {
        HI_ERR_AFLT("Too many aflt chans:%d!\n", s_stAfltDrv.u32ChanNum);
        return HI_FAILURE;
    }

    /* Allocate new channel */
    for (i = 0; i < AFLT_MAX_CHAN_NUM; i++)
    {
        if (0 == atomic_read(&s_stAfltDrv.astChanEntity[i].atmUseCnt))
        {
            pState = (AFLT_CHANNEL_S *)HI_KMALLOC(HI_ID_AFLT, sizeof(AFLT_CHANNEL_S), GFP_KERNEL);
            if (HI_NULL == pState)
            {
                HI_ERR_AFLT("Too many aflt chans!\n");
                return HI_FAILURE;
            }

            //alloc message pool mmz
            snprintf(szMsgPoolMmzName, sizeof(szMsgPoolMmzName), "AFLT_Msg%02d", i);
            if (HI_SUCCESS
              != HI_DRV_MMZ_AllocAndMap(szMsgPoolMmzName, MMZ_OTHERS, pstCreateAttr->u32MsgPoolSize, 4,
                                        &s_stAfltDrv.astChanEntity[i].stMsgRbfMmz))
            {
                HI_FATAL_AFLT("Unable to mmz %s \n", szMsgPoolMmzName);
                HI_KFREE(HI_ID_AFLT, pState);
                return HI_FAILURE;
            }

            /* Allocate resource */
            s_stAfltDrv.astChanEntity[i].pstChan = pState;
            s_stAfltDrv.astChanEntity[i].pstFile = pstFile;
            s_stAfltDrv.u32ChanNum++;
            atomic_inc(&s_stAfltDrv.astChanEntity[i].atmUseCnt);
            *phAflt = (HI_ID_AFLT << 16) | i;
            break;
        }
    }

    if (i >= AFLT_MAX_CHAN_NUM)
    {
        HI_ERR_AFLT("Too many aflt chans!\n");
        return HI_FAILURE;
    }

    return HI_SUCCESS;
}

static HI_S32 AFLT_Chan_FreeHandle(HI_HANDLE hAflt)
{
    HI_U32 u32AfltId;
    AFLT_CHANNEL_S *pstChan = HI_NULL;
    u32AfltId = hAflt & AFLT_CHNID_MASK;

    if (s_stAfltDrv.astChanEntity[u32AfltId].stMsgRbfMmz.u32StartPhyAddr)
    {
        HI_DRV_MMZ_UnmapAndRelease(&s_stAfltDrv.astChanEntity[u32AfltId].stMsgRbfMmz);
        s_stAfltDrv.astChanEntity[u32AfltId].stMsgRbfMmz.u32StartPhyAddr = 0;
    }

    pstChan = s_stAfltDrv.astChanEntity[u32AfltId].pstChan;
    if(pstChan)
    {
        if (pstChan->stInBufMmz.u32StartPhyAddr)
        {
            HI_DRV_MMZ_UnmapAndRelease(&pstChan->stInBufMmz);
            pstChan->stInBufMmz.u32StartPhyAddr = 0;
        }
        if (pstChan->stOutBufMmz.u32StartPhyAddr)
        {
            HI_DRV_MMZ_UnmapAndRelease(&pstChan->stOutBufMmz);
            pstChan->stOutBufMmz.u32StartPhyAddr = 0;
        }
        HI_KFREE(HI_ID_AFLT, pstChan);
        s_stAfltDrv.astChanEntity[u32AfltId].pstChan = HI_NULL;
    }

    s_stAfltDrv.astChanEntity[u32AfltId].pstFile = HI_NULL;
    s_stAfltDrv.u32ChanNum--;
    atomic_set(&s_stAfltDrv.astChanEntity[u32AfltId].atmUseCnt, 0);

    return HI_SUCCESS;
}

static HI_S32 AFLTCreate(HI_U32 u32AfltId, AFLT_CREATE_ATTR_S* pstAttr)
{
    AFLT_CHANNEL_S *pstChan = HI_NULL;

    pstChan = s_stAfltDrv.astChanEntity[u32AfltId].pstChan;

    AFLT_HAL_SetMsgPoolAttr(u32AfltId, &pstChan->stMsgAttr);

    if (HI_SUCCESS != AFLT_HAL_Create(u32AfltId, pstAttr))
    {
        HI_ERR_AFLT("Create AFLT(%d)fail!\n", u32AfltId);
        return HI_FAILURE;
    }

    memcpy(&pstChan->stCreateAttr, pstAttr, sizeof(AFLT_CREATE_ATTR_S));

    return HI_SUCCESS;
}

static HI_S32 AFLTDestroy(HI_U32 u32AfltId)
{
    AFLT_CHANNEL_S *pstChan = HI_NULL;

    pstChan = s_stAfltDrv.astChanEntity[u32AfltId].pstChan;
    /* Stop aflt */
    if (AFLT_STATUS_STOP != pstChan->enCurnStatus)
    {
        if (HI_SUCCESS != AFLT_HAL_Stop(u32AfltId))
        {
            HI_ERR_AFLT("Stop aflt(%d) failed!\n", u32AfltId);
            return HI_FAILURE;
        }

        pstChan->enCurnStatus = AFLT_STATUS_STOP;
    }

    /* Close decoder */
    if (HI_SUCCESS != AFLT_HAL_Destroy(u32AfltId))
    {
        HI_ERR_AFLT("Destroy aflt(%d) failed!\n", u32AfltId);
        return HI_FAILURE;
    }

    return HI_SUCCESS;
}

static HI_S32 AFLT_Create(HI_HANDLE hAflt, AFLT_CREATE_ATTR_S* pstAttr, MMZ_BUFFER_S *pstMsgRbfMmz)
{
    HI_U32 u32AfltId;
    AFLT_CHANNEL_S *pstChan = HI_NULL;

    u32AfltId = hAflt & AFLT_CHNID_MASK;
    /* Check and get pstChan pointer */
    CHECK_AFLT_CREATE(u32AfltId);

    pstChan = s_stAfltDrv.astChanEntity[u32AfltId].pstChan;

    memset(pstChan,0, sizeof(AFLT_CHANNEL_S));

    memcpy(&pstChan->stMsgPoolMmz, pstMsgRbfMmz, sizeof(MMZ_BUFFER_S));

    /* store  msgpoll  attr */
    if(HI_TRUE == s_stAfltDrv.bAfltSwFlag)
    {
        pstChan->stMsgAttr.tBufVirAddr = (HI_U32)pstChan->stMsgPoolMmz.pu8StartVirAddr;
    }
    else
    {
        pstChan->stMsgAttr.tBufPhyAddr = pstChan->stMsgPoolMmz.u32StartPhyAddr;
    }
    pstChan->stMsgAttr.u32MsgPoolSize = pstChan->stMsgPoolMmz.u32Size;

    if (HI_SUCCESS != AFLTCreate(u32AfltId, pstAttr))
    {
        goto err0;
    }

    if (HI_SUCCESS != AFLT_RegChanProc(u32AfltId))
    {
        HI_FATAL_AFLT("Register aflt(%d) Proc fail\n", u32AfltId);
        goto err1;
    }

    memcpy(&pstChan->stCreateAttr, pstAttr, sizeof(AFLT_CREATE_ATTR_S));
    pstChan->enCurnStatus = AFLT_STATUS_STOP;

    return HI_SUCCESS;

err1:
    (HI_VOID)AFLTDestroy(hAflt);

err0:
    return HI_FAILURE;
}

static HI_S32 AFLT_Destroy(HI_HANDLE hAflt)
{
    HI_U32 u32AfltId;

    u32AfltId = hAflt & AFLT_CHNID_MASK;
    CHECK_AFLT_CREATE(u32AfltId);

    AFLT_UnRegChanProc(u32AfltId);

    return AFLTDestroy(u32AfltId);
}

static HI_S32 AFLT_Start(HI_HANDLE hAflt)
{
    HI_U32 u32AfltId;
    AFLT_CHANNEL_S *pstChan = HI_NULL;

    u32AfltId = hAflt & AFLT_CHNID_MASK;
    /* Check and get pstChan pointer */
    CHECK_AFLT_CREATE(u32AfltId);

    pstChan = s_stAfltDrv.astChanEntity[u32AfltId].pstChan;

    if (AFLT_STATUS_START == pstChan->enCurnStatus)
    {
        return HI_SUCCESS;
    }

    if (HI_SUCCESS != AFLT_HAL_Start(u32AfltId))
    {
        HI_ERR_AFLT("Start AFLT(%d)fail!\n", u32AfltId);
        return HI_FAILURE;
    }

    pstChan->enCurnStatus = AFLT_STATUS_START;

    return HI_SUCCESS;
}

static HI_S32 AFLT_Stop(HI_HANDLE hAflt)
{
    HI_U32 u32AfltId;
    AFLT_CHANNEL_S *pstChan = HI_NULL;

    u32AfltId = hAflt & AFLT_CHNID_MASK;
    CHECK_AFLT_CREATE(u32AfltId);

    pstChan = s_stAfltDrv.astChanEntity[u32AfltId].pstChan;

    if(AFLT_STATUS_STOP == pstChan->enCurnStatus)
    {
        return HI_SUCCESS;
    }

    if (HI_SUCCESS != AFLT_HAL_Stop(u32AfltId))
    {
        HI_ERR_AFLT("Stop AFLT(%d)fail!\n", u32AfltId);
        return HI_FAILURE;
    }

    pstChan->enCurnStatus = AFLT_STATUS_STOP;

    return HI_SUCCESS;
}

static HI_S32 AFLT_SetParam(HI_HANDLE hAflt, AFLT_PARAM_S stParam)
{
    HI_S32 s32Ret;
    HI_U32 u32AfltId;
    AFLT_CHANNEL_S *pstChan = HI_NULL;

    u32AfltId = hAflt & AFLT_CHNID_MASK;
    CHECK_AFLT_CREATE(u32AfltId);

    pstChan = s_stAfltDrv.astChanEntity[u32AfltId].pstChan;

    if(AFLT_STATUS_STOP != pstChan->enCurnStatus)
    {
        HI_ERR_AFLT("need stop before set alft param!\n");
        return HI_FAILURE;
    }

    //TODO
    if(stParam.u32ParamStructSize > pstChan->stMsgPoolMmz.u32Size)
    {
        HI_ERR_AFLT("param size exceed msg pool size!\n");
        return HI_FAILURE;
    }
    s32Ret = copy_from_user((HI_VOID *)pstChan->stMsgPoolMmz.pu8StartVirAddr, (HI_VOID *)(HI_VIRT_ADDR_T)(stParam.tParamStruct), stParam.u32ParamStructSize);

    if (HI_SUCCESS != AFLT_HAL_SetParam(u32AfltId, stParam))
    {
        HI_ERR_AFLT("Set AFLT(%d) param fail!\n", u32AfltId);
        return HI_FAILURE;
    }

    return HI_SUCCESS;
}

static HI_S32 AFLT_GetParam(HI_HANDLE hAflt, AFLT_PARAM_S *pstParam)
{
    HI_S32 s32Ret;
    HI_U32 u32AfltId;
    AFLT_CHANNEL_S *pstChan = HI_NULL;

    u32AfltId = hAflt & AFLT_CHNID_MASK;
    CHECK_AFLT_CREATE(u32AfltId);

    pstChan = s_stAfltDrv.astChanEntity[u32AfltId].pstChan;

    if (HI_SUCCESS != AFLT_HAL_GetParam(u32AfltId, pstParam))
    {
        HI_ERR_AFLT("Get AFLT(%d) param fail!\n", u32AfltId);
        return HI_FAILURE;
    }
    //TODO get which param? who alloc param
    s32Ret = copy_to_user((HI_VOID *)(HI_VIRT_ADDR_T)(pstParam->tParamStruct), (HI_VOID *)pstChan->stMsgPoolMmz.pu8StartVirAddr, pstParam->u32ParamStructSize);

    return HI_SUCCESS;
}

static HI_S32 AFLT_SetConfig(HI_HANDLE hAflt, AFLT_CONFIG_S stConfig)
{
    HI_S32 s32Ret;
    HI_U32 u32AfltId;
    AFLT_CHANNEL_S *pstChan = HI_NULL;

    u32AfltId = hAflt & AFLT_CHNID_MASK;
    CHECK_AFLT_CREATE(u32AfltId);

    pstChan = s_stAfltDrv.astChanEntity[u32AfltId].pstChan;

    if(stConfig.u32ConfigStructSize > pstChan->stMsgPoolMmz.u32Size)
    {
        HI_ERR_AFLT("config size exceed msg pool size!\n");
        return HI_FAILURE;
    }
    s32Ret = copy_from_user((HI_VOID *)pstChan->stMsgPoolMmz.pu8StartVirAddr, (HI_VOID *)(HI_VIRT_ADDR_T)(stConfig.tConfigStruct), stConfig.u32ConfigStructSize);

    if (HI_SUCCESS != AFLT_HAL_SetConfig(u32AfltId, stConfig))
    {
        HI_ERR_AFLT("Set AFLT(%d) config fail!\n", u32AfltId);
        return HI_FAILURE;
    }

    return HI_SUCCESS;
}

static HI_S32 AFLT_GetConfig(HI_HANDLE hAflt, AFLT_CONFIG_S *pstConfig)
{
    HI_S32 s32Ret;
    HI_U32 u32AfltId;
    AFLT_CHANNEL_S *pstChan = HI_NULL;

    u32AfltId = hAflt & AFLT_CHNID_MASK;

    pstChan = s_stAfltDrv.astChanEntity[u32AfltId].pstChan;

    if (HI_SUCCESS != AFLT_HAL_GetConfig(u32AfltId, pstConfig))
    {
        HI_ERR_AFLT("Get AFLT(%d) config fail!\n", u32AfltId);
        return HI_FAILURE;
    }
    s32Ret = copy_to_user((HI_VOID *)(HI_VIRT_ADDR_T)(pstConfig->tConfigStruct), (HI_VOID *)pstChan->stMsgPoolMmz.pu8StartVirAddr, pstConfig->u32ConfigStructSize);

    return HI_SUCCESS;
}

static HI_S32 AFLT_InitInbuf(HI_HANDLE hAflt, AFLT_INBUF_ATTR_S *pstAttr)
{
    HI_U32 u32AfltId;
    HI_CHAR szInBufMmzName[16];
    AFLT_CHANNEL_S *pstChan = HI_NULL;

    u32AfltId = hAflt & AFLT_CHNID_MASK;
    CHECK_AFLT_CREATE(u32AfltId);

    pstChan = s_stAfltDrv.astChanEntity[u32AfltId].pstChan;

    if(HI_FALSE == pstChan->stCreateAttr.bMaster)
    {
        HI_ERR_AFLT("Slave aflt don't support init inbuf\n");
        goto err0;
    }

    if (AFLT_STATUS_STOP != pstChan->enCurnStatus)
    {
        HI_ERR_AFLT("aflt should be stop before init inbuf!\n");
        goto err0;
    }

    pstAttr->u32StreamReadPos = 0; //TODO user set
    pstAttr->u32BufDataAddr = 0;
    /* Record  input buffer  attr */
    pstChan->stInBufAttr.u32PtsBoundary = pstAttr->u32PtsBufBoundary;
    pstChan->stInBufAttr.u32Wpos = 0;
    pstChan->stInBufAttr.u32Rpos = 0;
    pstChan->stInBufAttr.u32StreamReadPos = pstAttr->u32StreamReadPos;
    pstChan->stInBufAttr.u32BufFlag = 0;   //directly addressing
    pstChan->stInBufAttr.bEosFlag = HI_FALSE;

    snprintf(szInBufMmzName, sizeof(szInBufMmzName), "AFLT_InBuf%02d", (HI_S32)u32AfltId);
    if (HI_SUCCESS
        != HI_DRV_MMZ_AllocAndMap(szInBufMmzName, MMZ_OTHERS, pstAttr->u32BufSize, 4,
                                  &pstChan->stInBufMmz))
    {
        HI_FATAL_AFLT("Unable to mmz %s \n", szInBufMmzName);
        goto err0;
    }

    pstAttr->u32BufDataAddr = pstChan->stInBufMmz.u32StartPhyAddr;
    if(HI_TRUE == s_stAfltDrv.bAfltSwFlag)
    {
        pstChan->stInBufAttr.tBufVirAddr = (HI_U32)pstChan->stInBufMmz.pu8StartVirAddr;
    }
    else
    {
        pstChan->stInBufAttr.tBufPhyAddr = pstChan->stInBufMmz.u32StartPhyAddr;
    }
    pstChan->stInBufAttr.u32BufSize = pstChan->stInBufMmz.u32Size;


    if (HI_SUCCESS !=  AFLT_HAL_InitInbuf(u32AfltId, &pstChan->stInBufAttr))
    {
        HI_ERR_AFLT("Init AFLT(%d) inbuf fail!\n", u32AfltId);
        goto err1;
    }

    return HI_SUCCESS;

err1:
    HI_DRV_MMZ_UnmapAndRelease(&pstChan->stInBufMmz);
    pstChan->stInBufMmz.u32StartPhyAddr = 0;
    pstChan->stInBufMmz.pu8StartVirAddr = 0;

err0:
    return HI_FAILURE;
}

static HI_S32 AFLT_DeInitInbuf(HI_HANDLE hAflt)
{
    HI_U32 u32AfltId;
    AFLT_CHANNEL_S *pstChan = HI_NULL;

    u32AfltId = hAflt & AFLT_CHNID_MASK;
    CHECK_AFLT_CREATE(u32AfltId);

    pstChan = s_stAfltDrv.astChanEntity[u32AfltId].pstChan;

    if(HI_FALSE == pstChan->stCreateAttr.bMaster)
    {
        HI_ERR_AFLT("Slave aflt don't support deinit inbuf\n");
        return HI_FAILURE;
    }

    if (AFLT_STATUS_STOP != pstChan->enCurnStatus)
    {
        HI_ERR_AFLT("aflt should be stop before deinit inbuf!\n");
        return HI_FAILURE;
    }

    if (HI_SUCCESS !=  AFLT_HAL_DeInitInbuf(u32AfltId))
    {
        HI_ERR_AFLT("Deinit AFLT(%d) inbuf fail!\n", u32AfltId);
        return HI_FAILURE;
    }

    if (pstChan->stInBufMmz.u32StartPhyAddr)
    {
        HI_DRV_MMZ_UnmapAndRelease(&pstChan->stInBufMmz);
        pstChan->stInBufMmz.u32StartPhyAddr = 0;
        pstChan->stInBufMmz.pu8StartVirAddr = 0;
    }
    //TODO whether need set adsp aflt inbuf
    return HI_SUCCESS;
}

static HI_S32 AFLT_InitOutbuf(HI_HANDLE hAflt, AFLT_OUTBUF_ATTR_S *pstAttr)
{
    HI_U32 u32AfltId;
    HI_U32 u32BufSize;
    HI_U32 u32UnitHeadSize;
    HI_U32 u32PeriodBufSize;
    HI_CHAR szOutBufMmzName[16];
    AFLT_CHANNEL_S *pstChan = HI_NULL;

    u32AfltId = hAflt & AFLT_CHNID_MASK;
    CHECK_AFLT_CREATE(u32AfltId);

    pstChan = s_stAfltDrv.astChanEntity[u32AfltId].pstChan;

    if(HI_FALSE == pstChan->stCreateAttr.bMaster)
    {
        HI_ERR_AFLT("Slave aflt don't support init outbuf\n");
        goto err0;
    }

    if (AFLT_STATUS_STOP != pstChan->enCurnStatus)
    {
        HI_ERR_AFLT("aflt should be stop before init outbuf!\n");
        goto err0;
    }

    u32UnitHeadSize  = sizeof(AFLT_ADSP_FRAME_INFO_S);
    u32UnitHeadSize += pstAttr->u32FramePrivateInfoSize;
    u32PeriodBufSize = pstAttr->u32FrameBufDataSize + u32UnitHeadSize;
    u32BufSize = u32PeriodBufSize * pstAttr->u32FrameBufNumber;
    pstAttr->u32BufSize = u32BufSize;

    pstAttr->u32BufDataAddr = 0;
    snprintf(szOutBufMmzName, sizeof(szOutBufMmzName), "AFLT_OutBuf%02d", (HI_S32)u32AfltId);
#if 0 //cache
    if (HI_SUCCESS
        != HI_DRV_MMZ_Alloc(szOutBufMmzName, MMZ_OTHERS, u32BufSize, 4,
                                  &pstChan->stOutBufMmz))
    {
        HI_FATAL_AFLT("Unable to mmz %s \n", szOutBufMmzName);
        return HI_FAILURE;
    }

    pstAttr->u32BufDataAddr = pstChan->stOutBufMmz.u32StartPhyAddr;

    /* store  outputbuf  attr */
    if(HI_TRUE == s_stAfltDrv.bAfltSwFlag)
    {
        pstChan->stOutBufAttr.u32BufAddr = pstChan->stOutBufMmz.u32StartVirAddr;
    }
    else
    {
        pstChan->stOutBufAttr.u32BufAddr = pstChan->stOutBufMmz.u32StartPhyAddr;
        if(HI_SUCCESS!=HI_DRV_MMZ_MapCache(&pstChan->stOutBufMmz))  //TODO
        {
            HI_ERR_AFLT("MapCache %s fail!\n", szOutBufMmzName);
            HI_DRV_MMZ_UnmapAndRelease(&pstChan->stOutBufMmz);
            return HI_FAILURE;
        }
    }
#else  //no cache
    if (HI_SUCCESS
        != HI_DRV_MMZ_AllocAndMap(szOutBufMmzName, MMZ_OTHERS, u32BufSize, 4,
                                  &pstChan->stOutBufMmz))
    {
        HI_FATAL_AFLT("Unable to mmz %s \n", szOutBufMmzName);
        goto err0;
    }

    pstAttr->u32BufDataAddr = pstChan->stOutBufMmz.u32StartPhyAddr;

    /* store  outputbuf  attr */
    if(HI_TRUE == s_stAfltDrv.bAfltSwFlag)
    {
        pstChan->stOutBufAttr.tBufVirAddr = (HI_U32)pstChan->stOutBufMmz.pu8StartVirAddr;
    }
    else
    {
        pstChan->stOutBufAttr.tBufPhyAddr = pstChan->stOutBufMmz.u32StartPhyAddr;
    }
#endif

    pstChan->stOutBufAttr.u32BufSize = pstChan->stOutBufMmz.u32Size;
    pstChan->stOutBufAttr.u32PeriodNumber  = pstAttr->u32FrameBufNumber;
    pstChan->stOutBufAttr.u32PeriodBufSize = u32PeriodBufSize;
    pstChan->stOutBufAttr.u32UnitHeadSize = u32UnitHeadSize;
    pstChan->stOutBufAttr.u32Widx = 0;
    pstChan->stOutBufAttr.u32Wwrap = 0;
    pstChan->stOutBufAttr.u32Ridx = 0;
    pstChan->stOutBufAttr.u32Rwrap = 0;

    if (HI_SUCCESS != AFLT_HAL_InitOutbuf(u32AfltId, &pstChan->stOutBufAttr))
    {
        HI_ERR_AFLT("Init AFLT(%d) outbuf fail!\n", u32AfltId);
        goto err1;
    }

    return HI_SUCCESS;

err1:
    HI_DRV_MMZ_UnmapAndRelease(&pstChan->stOutBufMmz);
    pstChan->stOutBufMmz.u32StartPhyAddr = 0;
    pstChan->stOutBufMmz.pu8StartVirAddr = 0;

err0:
    return HI_FAILURE;
}

static HI_S32 AFLT_DeInitOutbuf(HI_HANDLE hAflt)
{
    HI_U32 u32AfltId;
    AFLT_CHANNEL_S *pstChan = HI_NULL;

    u32AfltId = hAflt & AFLT_CHNID_MASK;
    CHECK_AFLT_CREATE(u32AfltId);

    pstChan = s_stAfltDrv.astChanEntity[u32AfltId].pstChan;

    if(HI_FALSE == pstChan->stCreateAttr.bMaster)
    {
        HI_ERR_AFLT("Slave aflt don't support deinit outbuf\n");
        return HI_FAILURE;
    }

    if (AFLT_STATUS_STOP != pstChan->enCurnStatus)
    {
        HI_ERR_AFLT("aflt should be stop before deinit outbuf!\n");
        return HI_FAILURE;
    }

   if (HI_SUCCESS !=  AFLT_HAL_DeInitOutbuf(u32AfltId))
    {
        HI_ERR_AFLT("Deinit AFLT(%d) outbuf fail!\n", u32AfltId);
        return HI_FAILURE;
    }

    if (pstChan->stOutBufMmz.u32StartPhyAddr)
    {
        HI_DRV_MMZ_UnmapAndRelease(&pstChan->stOutBufMmz);
        pstChan->stOutBufMmz.u32StartPhyAddr = 0;
        pstChan->stOutBufMmz.pu8StartVirAddr = 0;
    }
    //TODO MapCache release
    return HI_SUCCESS;
}

HI_VOID AFLTDbgGetBufCntTry(AFLT_CHANNEL_S *pstChan)
{
    pstChan->stPrivProcInfo.u32DbgGetBufCntTry++;
    return;
}

HI_VOID AFLTDbgGetBufCntOk(AFLT_CHANNEL_S *pstChan)
{
    pstChan->stPrivProcInfo.u32DbgGetBufCntOk++;
    return;
}

HI_VOID AFLTDbgPutBufCntTry(AFLT_CHANNEL_S *pstChan)
{
    pstChan->stPrivProcInfo.u32DbgPutBufCntTry++;
    return;
}

HI_VOID AFLTDbgPutBufCntOk(AFLT_CHANNEL_S *pstChan)
{
    pstChan->stPrivProcInfo.u32DbgPutBufCntOk++;
    return;
}

HI_VOID AFLTDbgAcquireFrmCntTry(AFLT_CHANNEL_S *pstChan)
{
    pstChan->stPrivProcInfo.u32DbgAcquireFrmCntTry++;
    return;
}

HI_VOID AFLTDbgAcquireFrmCntOk(AFLT_CHANNEL_S *pstChan)
{
    pstChan->stPrivProcInfo.u32DbgAcquireFrmCntOk++;
    return;
}

HI_VOID AFLTDbgReleaseFrmCntTry(AFLT_CHANNEL_S *pstChan)
{
    pstChan->stPrivProcInfo.u32DbgReleaseFrmCntTry++;
    return;
}

HI_VOID AFLTDbgReleaseFrmCntOk(AFLT_CHANNEL_S *pstChan)
{
    pstChan->stPrivProcInfo.u32DbgReleaseFrmCntOk++;
    return;
}

static HI_S32 AFLT_GetBuf(HI_HANDLE hAflt, AFLT_STREAM_BUF_S *pstStreamBuf, HI_U32 u32RequestSize)
{
    HI_U32 u32AfltId;
    HI_U32 u32WritePos = 0, u32ReadPos = 0;
    HI_U32 u32FreeSize = 0, u32TailFreeSize = 0;
    AFLT_CHANNEL_S *pstChan = HI_NULL;

    u32AfltId = hAflt & AFLT_CHNID_MASK;
    CHECK_AFLT_CREATE(u32AfltId);

    pstChan = s_stAfltDrv.astChanEntity[u32AfltId].pstChan;

    if(HI_FALSE == pstChan->stCreateAttr.bMaster)
    {
        HI_ERR_AFLT("Slave aflt don't support getbuf\n");
        return HI_FAILURE;
    }

    if(AFLT_STATUS_START != pstChan->enCurnStatus)
    {
        return HI_ERR_AFLT_INBUF_FULL;
    }

    AFLTDbgGetBufCntTry(pstChan);

    AFLT_HAL_GetInbufWritePos(u32AfltId, &u32WritePos);
    AFLT_HAL_GetInbufReadPos(u32AfltId, &u32ReadPos);
    if(u32ReadPos > u32WritePos)
    {
        u32FreeSize = u32ReadPos - u32WritePos;
        u32TailFreeSize = u32FreeSize;
    }
    else
    {
        u32FreeSize = u32ReadPos + (pstChan->stInBufMmz.u32Size - u32WritePos);
        u32TailFreeSize = pstChan->stInBufMmz.u32Size - u32WritePos;
    }

    if(u32FreeSize <= u32RequestSize)
    {
        return HI_ERR_AFLT_INBUF_FULL;
    }

    if(u32TailFreeSize >= u32RequestSize)
    {
        pstStreamBuf->u32DataOffset1 = u32WritePos;
        pstStreamBuf->u32Size1 = u32RequestSize;
        pstStreamBuf->u32DataOffset2 = 0;
        pstStreamBuf->u32Size2 = 0;
    }
    else
    {
        pstStreamBuf->u32DataOffset1 = u32WritePos;
        pstStreamBuf->u32Size1 = u32TailFreeSize;
        pstStreamBuf->u32DataOffset2 = 0;
        pstStreamBuf->u32Size2 = u32RequestSize - u32TailFreeSize;
    }

    AFLTDbgGetBufCntOk(pstChan);

    return HI_SUCCESS;
}

static HI_S32 AFLT_PutBuf(HI_HANDLE hAflt, AFLT_STREAM_BUF_S stStreamBuf)
{
    HI_U32 u32AfltId;
    HI_U32 u32WritePos = 0;
    AFLT_CHANNEL_S *pstChan = HI_NULL;

    u32AfltId = hAflt & AFLT_CHNID_MASK;
    CHECK_AFLT_CREATE(u32AfltId);

    pstChan = s_stAfltDrv.astChanEntity[u32AfltId].pstChan;

    //TODO adec put buf don't judge CurnStatus

    if(HI_FALSE == pstChan->stCreateAttr.bMaster)
    {
        HI_ERR_AFLT("Slave aflt don't support putbuf\n");
        return HI_FAILURE;
    }

    if(0 == stStreamBuf.u32Size1 && 0 == stStreamBuf.u32Size2)
    {
        HI_INFO_AFLT("u32Size of StreamBuf is 0\n");
        return HI_SUCCESS;
    }

    AFLTDbgPutBufCntTry(pstChan);

    AFLT_HAL_GetInbufWritePos(u32AfltId, &u32WritePos);
    u32WritePos += stStreamBuf.u32Size1 + stStreamBuf.u32Size2;
    if(u32WritePos >= pstChan->stInBufMmz.u32Size)
    {
        u32WritePos -= pstChan->stInBufMmz.u32Size;
    }

    AFLT_HAL_SetInbufWritePos(u32AfltId, u32WritePos);

    AFLTDbgPutBufCntOk(pstChan);

    return HI_SUCCESS;
}

static HI_S32 AFLTAcquireFrame(HI_U32 u32AfltId, AFLT_FRAME_INFO_S* pstFrameInfo)
{
    AFLT_CHANNEL_S *pstChan = HI_NULL;
    HI_U32 u32WriteIdx = 0, u32ReadIdx = 0;
    HI_U32 u32WriteWrap = 0, u32ReadWrap = 0;
    HI_U32 u32PeriodBufSize = 0;
    HI_U32 u32FrameOffsetAddr = 0;
    AFLT_ADSP_FRAME_INFO_S *pstAdspFrameInfo = HI_NULL;

    pstChan = s_stAfltDrv.astChanEntity[u32AfltId].pstChan;
    u32PeriodBufSize = pstChan->stOutBufAttr.u32PeriodBufSize;

    AFLT_HAL_GetOutbufWriteIdxAndWrap(u32AfltId, &u32WriteIdx, &u32WriteWrap);
    AFLT_HAL_GetOutbufReadIdxAndWrap(u32AfltId, &u32ReadIdx, &u32ReadWrap);

    if((u32ReadIdx == u32WriteIdx) && (u32ReadWrap == u32WriteWrap))  //empty
    {
        return HI_ERR_AFLT_OUTBUF_EMPTY;
    }

    pstAdspFrameInfo = (AFLT_ADSP_FRAME_INFO_S *)(pstChan->stOutBufMmz.pu8StartVirAddr + pstChan->stOutBufAttr.u32PeriodBufSize * u32ReadIdx);

    u32FrameOffsetAddr = pstChan->stOutBufAttr.u32PeriodBufSize * u32ReadIdx;
    pstFrameInfo->u32FrameDataOffsetAddr = u32FrameOffsetAddr + sizeof(AFLT_ADSP_FRAME_INFO_S);
    pstFrameInfo->u32FrameIndex = u32ReadIdx; //pstAdspFrameInfo->u32FrameIndex; //TODO if can delete pstAdspFrameInfo->u32FrameIndex
    pstFrameInfo->u32PtsReadPos = pstAdspFrameInfo->u32PtsReadPos;
    pstFrameInfo->u32FrameDataBytes = pstAdspFrameInfo->u32FrameDataBytes;
    pstFrameInfo->u32FramePrivOffsetAddr = pstFrameInfo->u32FrameDataOffsetAddr + pstFrameInfo->u32FrameDataBytes;
    pstFrameInfo->u32FramePrivBytes = pstAdspFrameInfo->u32FramePrivBytes;

    return HI_SUCCESS;
}

static HI_S32 AFLTReleaseFrame(HI_U32 u32AfltId, HI_U32 u32FrameIdx)
{
    HI_U32 u32ReadIdx = 0, u32ReadWrap = 0;
    AFLT_CHANNEL_S *pstChan = HI_NULL;

    pstChan = s_stAfltDrv.astChanEntity[u32AfltId].pstChan;

    if (u32FrameIdx >= pstChan->stOutBufAttr.u32PeriodNumber)
    {
        HI_ERR_AFLT("invalid frame index (%d)\n, nomal value(0~%d)\n", pstChan->stOutBufAttr.u32PeriodNumber-1);
        return HI_FAILURE;
    }
    AFLT_HAL_GetOutbufReadIdxAndWrap(u32AfltId, &u32ReadIdx, &u32ReadWrap);
    if(u32FrameIdx != u32ReadIdx)
    {
        HI_WARN_AFLT("Aflt release frame(frame index %d) unnomally\n", u32FrameIdx);
        return HI_SUCCESS;
    }
    u32ReadIdx = u32FrameIdx + 1;
    AFLT_HAL_SetOutBufRptrAndWrap(u32AfltId, u32ReadIdx);

    return HI_SUCCESS;
}

static HI_S32 AFLT_AcquireFrame(HI_HANDLE hAflt, AFLT_FRAME_INFO_S* pstFrameInfo)
{
    HI_S32 s32Ret;
    HI_U32 u32AfltId;
    AFLT_CHANNEL_S *pstChan = HI_NULL;

    u32AfltId = hAflt & AFLT_CHNID_MASK;
    CHECK_AFLT_CREATE(u32AfltId);

    pstChan = s_stAfltDrv.astChanEntity[u32AfltId].pstChan;

    if(HI_FALSE == pstChan->stCreateAttr.bMaster)
    {
        HI_ERR_AFLT("Slave aflt don't support acquire frame\n");
        return HI_FAILURE;
    }

    if (AFLT_STATUS_START != pstChan->enCurnStatus)
    {
        HI_ERR_AFLT("aflt should be start before acquire frame!\n");
        return HI_ERR_AFLT_OUTBUF_EMPTY;  //TODO the same with adec core
    }

    AFLTDbgAcquireFrmCntTry(pstChan);

    s32Ret = AFLTAcquireFrame(u32AfltId, pstFrameInfo);
    if (HI_SUCCESS != s32Ret)
    {
        return s32Ret;
    }

    //AFLTBuildHaFrame(u32AfltId);
    AFLTDbgAcquireFrmCntOk(pstChan);

    return HI_SUCCESS;
}

static HI_S32 AFLT_ReleaseFrame(HI_HANDLE hAflt, HI_U32 u32FrameIdx)
{
    HI_S32 s32Ret;
    HI_U32 u32AfltId;
    AFLT_CHANNEL_S *pstChan = HI_NULL;

    u32AfltId = hAflt & AFLT_CHNID_MASK;
    CHECK_AFLT_CREATE(u32AfltId);

    pstChan = s_stAfltDrv.astChanEntity[u32AfltId].pstChan;

    if(HI_FALSE == pstChan->stCreateAttr.bMaster)
    {
        HI_ERR_AFLT("Slave aflt don't support release frame\n");
        return HI_FAILURE;
    }

    AFLTDbgReleaseFrmCntTry(pstChan);

    s32Ret = AFLTReleaseFrame(u32AfltId, u32FrameIdx);   //TODO if need
    if(HI_SUCCESS != s32Ret)
    {
        return s32Ret;
    }

    AFLTDbgReleaseFrmCntOk(pstChan);

    return HI_SUCCESS;
}

static HI_S32 AFLT_SetEosFlag(HI_HANDLE hAflt, HI_BOOL bEosFlag)
{
    HI_U32 u32AfltId;

    u32AfltId = hAflt & AFLT_CHNID_MASK;
    CHECK_AFLT_CREATE(u32AfltId);

    AFLT_HAL_SetEosFlag(u32AfltId, bEosFlag);

    return HI_SUCCESS;
}

static HI_VOID AFLTGetStatusInfo(HI_U32 u32AfltId, AFLT_STATUS_INFO_S *pstStatusInfo)
{
    AFLT_HAL_GetInbufWritePos(u32AfltId, &pstStatusInfo->u32InBufWritePos);
    AFLT_HAL_GetInbufReadPos(u32AfltId, &pstStatusInfo->u32InBufReadPos);
    AFLT_HAL_GetOutbufWriteIdxAndWrap(u32AfltId, &pstStatusInfo->u32OutBufWriteIdx, &pstStatusInfo->u32OutBufWriteWrap);
    AFLT_HAL_GetOutbufReadIdxAndWrap(u32AfltId, &pstStatusInfo->u32OutBufReadIdx, &pstStatusInfo->u32OutBufReadWrap);
    AFLT_HAL_GetExeFrameStatisticsInfo(u32AfltId, &pstStatusInfo->u32TryExeCnt, &pstStatusInfo->u32FrameNum, &pstStatusInfo->u32ErrFrameNum);
    AFLT_HAL_GetEndOfFrame(u32AfltId, &pstStatusInfo->bEndOfFrame);
    AFLT_HAL_GetTimeOutStatisticsInfo(u32AfltId, &pstStatusInfo->u32ScheTimeOutCnt, &pstStatusInfo->u32ExeTimeOutCnt);
    AFLT_HAL_GetInbufStreamReadPos(u32AfltId, &pstStatusInfo->u32StreamReadPos);

    return;
}

static HI_S32 AFLT_GetStatusInfo(HI_HANDLE hAflt, AFLT_STATUS_INFO_S *pstStatusInfo)
{
    HI_U32 u32AfltId;

    u32AfltId = hAflt & AFLT_CHNID_MASK;
    CHECK_AFLT_CREATE(u32AfltId);

    AFLTGetStatusInfo(u32AfltId, pstStatusInfo);

    return HI_SUCCESS;
}

static HI_S32 AFLT_GetCunrStatus(HI_HANDLE hAflt, AFLT_STATUS_E *pstCunrStatus)
{
    HI_U32 u32AfltId;
    u32AfltId = hAflt & AFLT_CHNID_MASK;
    CHECK_AFLT_CREATE(u32AfltId);

    AFLT_HAL_GetCunrStatus(hAflt,pstCunrStatus);
    return HI_SUCCESS;
}

static HI_S32 AFLT_OpenDev(HI_VOID)
{
    HI_U32 i;
    HI_S32 s32Ret;

    /* Init global parameter */

    for (i = 0; i < AFLT_MAX_CHAN_NUM; i++)
    {
        atomic_set(&s_stAfltDrv.astChanEntity[i].atmUseCnt, 0);
        s_stAfltDrv.astChanEntity[i].bUsed = HI_FALSE;
        s_stAfltDrv.astChanEntity[i].pstChan = HI_NULL;
        s_stAfltDrv.astChanEntity[i].pstFile = HI_NULL;
        memset(&s_stAfltDrv.astChanEntity[i].stMsgRbfMmz, 0, sizeof(MMZ_BUFFER_S));
        memset(&s_stAfltDrv.astChanEntity[i].stStoreAttr, 0, sizeof(AFTL_STORING_S));
    }

    if (s_stAfltDrv.pAdspFunc && s_stAfltDrv.pAdspFunc->pfnADSP_LoadFirmware)
    {
        s32Ret = (s_stAfltDrv.pAdspFunc->pfnADSP_LoadFirmware)(ADSP_CODE_AFLT);
        if (HI_SUCCESS != s32Ret)
        {
            HI_ERR_AFLT("Load Adsp Aflt fail\n");
            return HI_FAILURE;
        }
    }

     if (s_stAfltDrv.pAdspFunc && s_stAfltDrv.pAdspFunc->pfnADSP_GetAoeFwmInfo)
     {
        ADSP_FIRMWARE_AOE_INFO_S stAoeInfo;
        s32Ret = (s_stAfltDrv.pAdspFunc->pfnADSP_GetAoeFwmInfo)(ADSP_CODE_AOE,&stAoeInfo);  //TODO AOE and Aflt can use the same interface
        if (HI_SUCCESS != s32Ret)
        {
            s32Ret = (s_stAfltDrv.pAdspFunc->pfnADSP_UnLoadFirmware)(ADSP_CODE_AFLT);
            return HI_FAILURE;
        }
        /* Set aflt simulator flag */
        s_stAfltDrv.bAfltSwFlag = stAoeInfo.bAoeSwFlag;
     }

    /* AFLTE HAL Init , Init aoe hardare */
    AFLT_HAL_Init( AFLT_COM_REG_BASE, s_stAfltDrv.bAfltSwFlag);

    /* Set ready flag */
    s_stAfltDrv.bReady = HI_TRUE;

    HI_INFO_AFLT("AFLT_OpenDev OK.\n");
    return HI_SUCCESS;
}

static HI_S32 AFLT_CloseDev(HI_VOID)
{
    HI_U32 i;
    HI_S32 s32Ret;

    /* Reentrant */
    if (s_stAfltDrv.bReady == HI_FALSE)
    {
        return HI_SUCCESS;
    }

    /* Free all channels */
    for (i = 0; i < AFLT_MAX_CHAN_NUM; i++)
    {
        if (atomic_read(&s_stAfltDrv.astChanEntity[i].atmUseCnt))
        {
            s32Ret = AFLT_Destroy(i);
            if(HI_SUCCESS != s32Ret)
            {
                return s32Ret;
            }
            AFLT_Chan_FreeHandle(i);
        }
    }

    /* AFLT HAL DeInit */
    AFLT_HAL_DeInit();

    if (s_stAfltDrv.pAdspFunc && s_stAfltDrv.pAdspFunc->pfnADSP_UnLoadFirmware)
    {
        s32Ret = (s_stAfltDrv.pAdspFunc->pfnADSP_UnLoadFirmware)(ADSP_CODE_AFLT);
    }

    /* Set ready flag */
    s_stAfltDrv.bReady = HI_FALSE;

    return HI_SUCCESS;
}

static HI_S32 AFLT_Ioctl( struct inode *inode, struct file *file, HI_U32 cmd, HI_VOID *arg )
{
    HI_S32 s32Ret = HI_FAILURE;
    HI_HANDLE hAflt = HI_INVALID_HANDLE;

    switch (cmd)
    {
        case CMD_AFLT_CREATE:
        {
            AFLT_Create_Param_S_PTR pstCreateParam = (AFLT_Create_Param_S_PTR)arg;
            if (HI_SUCCESS == AFLT_Chan_AllocHandle(&hAflt, file, &pstCreateParam->stCreateAttr))
            {
                s32Ret = AFLT_Create(hAflt, &pstCreateParam->stCreateAttr, &s_stAfltDrv.astChanEntity[hAflt&AFLT_CHNID_MASK].stMsgRbfMmz);
                if (HI_SUCCESS != s32Ret)
                {
                    AFLT_Chan_FreeHandle(hAflt);
                }
                else
                {
                    pstCreateParam->hAflt = hAflt;
                }
            }
            break;
        }

        case CMD_AFLT_DESTROY:
        {
            HI_HANDLE hAflt = *(HI_HANDLE *)arg;
            s32Ret = AFLT_Destroy(hAflt);
            if (HI_SUCCESS == s32Ret)
            {
                s32Ret = AFLT_Chan_FreeHandle(hAflt);
            }
            break;
        }
        case CMD_AFLT_START:
        {
            HI_HANDLE hAflt = *(HI_HANDLE *)arg;
            s32Ret = AFLT_Start(hAflt);
            break;
        }
        case CMD_AFLT_STOP:
        {
            HI_HANDLE hAflt = *(HI_HANDLE *)arg;
            s32Ret = AFLT_Stop(hAflt);
            break;
        }
        case CMD_AFLT_SETPARAM:
        {
            AFLT_Setting_Param_S_PTR pstSetParam = (AFLT_Setting_Param_S_PTR)arg;
            s32Ret = AFLT_SetParam(pstSetParam->hAflt, pstSetParam->stParam);
            break;
        }
        case CMD_AFLT_GETPARAM:
        {
            AFLT_Setting_Param_S_PTR pstGetParam = (AFLT_Setting_Param_S_PTR)arg;
            s32Ret = AFLT_GetParam(pstGetParam->hAflt, &pstGetParam->stParam);
            break;
        }
        case CMD_AFLT_SETCONFIG:
        {
            AFLT_Setting_Config_S_PTR pstSetConfig = (AFLT_Setting_Config_S_PTR)arg;
            s32Ret = AFLT_SetConfig(pstSetConfig->hAflt, pstSetConfig->stConfig);
            break;
        }
        case CMD_AFLT_GETCONFIG:
        {
            AFLT_Setting_Config_S_PTR pstGetConfig = (AFLT_Setting_Config_S_PTR)arg;
            s32Ret = AFLT_GetConfig(pstGetConfig->hAflt, &pstGetConfig->stConfig);
            break;
        }
        case CMD_AFLT_INITINBUF:
        {
            AFLT_Inbuf_Param_S_PTR pstInbufParam = (AFLT_Inbuf_Param_S_PTR)arg;
            s32Ret = AFLT_InitInbuf(pstInbufParam->hAflt, &pstInbufParam->stInbuf);
            break;
        }
        case CMD_AFLT_DEINITINBUF:
        {
            HI_HANDLE hAflt = *(HI_HANDLE *)arg;
            s32Ret = AFLT_DeInitInbuf(hAflt);
            break;
        }
        case CMD_AFLT_INITOUTBUF:
        {
            AFLT_Outbuf_Param_S_PTR pstOutbufParam = (AFLT_Outbuf_Param_S_PTR)arg;
            s32Ret = AFLT_InitOutbuf(pstOutbufParam->hAflt, &pstOutbufParam->stOutbuf);
            break;
        }
        case CMD_AFLT_DEINITOUTBUF:
        {
            HI_HANDLE hAflt = *(HI_HANDLE *)arg;
            s32Ret = AFLT_DeInitOutbuf(hAflt);
            break;
        }
        case CMD_AFLT_GETBUF:
        {
            AFLT_GetBuf_Param_S_PTR pstGetBufParam = (AFLT_GetBuf_Param_S_PTR)arg;
            s32Ret = AFLT_GetBuf(pstGetBufParam->hAflt, &pstGetBufParam->stStreambuf, pstGetBufParam->u32RequestSize);
            break;
        }
        case CMD_AFLT_PUTBUF:
        {
            AFLT_PutBuf_Param_S_PTR pstPutBufParam = (AFLT_PutBuf_Param_S_PTR)arg;
            s32Ret = AFLT_PutBuf(pstPutBufParam->hAflt, pstPutBufParam->stStreambuf);
            break;
        }
        case CMD_AFLT_ACQUIREFRAME:
        {
            AFLT_AcquireFrame_Param_S_PTR pstFrameParam = (AFLT_AcquireFrame_Param_S_PTR)arg;
            s32Ret = AFLT_AcquireFrame(pstFrameParam->hAflt, &pstFrameParam->stFrameInfo);
            break;
        }
        case CMD_AFLT_RELEASEFRAME:
        {
            AFLT_ReleaseFrame_Param_S_PTR pstFrameParam = (AFLT_ReleaseFrame_Param_S_PTR)arg;
            s32Ret = AFLT_ReleaseFrame(pstFrameParam->hAflt, pstFrameParam->u32FrameIdx);
            break;
        }
        case CMD_AFLT_SETEOSFLAG:
        {
            AFLT_EOSFLAG_Param_S_PTR pstEosFlagParam = (AFLT_EOSFLAG_Param_S_PTR)arg;
            s32Ret = AFLT_SetEosFlag(pstEosFlagParam->hAflt, pstEosFlagParam->bEosFlag);
            break;
        }
        case CMD_AFLT_GETSTATUSINFO:
        {
            AFLT_StatusInfo_Param_S_PTR pstStatusInfoParam = (AFLT_StatusInfo_Param_S_PTR)arg;
            s32Ret = AFLT_GetStatusInfo(pstStatusInfoParam->hAflt, &pstStatusInfoParam->stStatusInfo);
            break;
        }
        case CMD_AFLT_GETSTATUS:
        {
            AFLT_Status_Param_S_PTR pstStatusParam = (AFLT_Status_Param_S_PTR)arg;
            s32Ret = AFLT_GetCunrStatus(pstStatusParam->hAflt, &pstStatusParam->enCurnStatus);
            break;
        }

        default:
        {
            s32Ret = HI_FAILURE;
            HI_ERR_AFLT("unknown aflt cmd: 0x%x\n", cmd);
            break;
        }
    }

    return s32Ret;
}

static HI_VOID AFLTFlushOutBufData(AFLT_CHANNEL_S *pstChan)
{
    //Suspend outbuf data flush
    memset((HI_VOID *)pstChan->stOutBufMmz.pu8StartVirAddr, 0, pstChan->stOutBufAttr.u32BufSize);

    pstChan->stOutBufAttr.u32Ridx = 0;
    pstChan->stOutBufAttr.u32Rwrap = 0;
    pstChan->stOutBufAttr.u32Widx = 0;
    pstChan->stOutBufAttr.u32Wwrap = 0;
}

static HI_VOID AFLT_GetSettings(HI_U32 u32AfltId, AFTL_STORING_S *pstStoreAttr)
{
    AFLT_CHANNEL_S *pstChan = HI_NULL;

    pstChan = s_stAfltDrv.astChanEntity[u32AfltId].pstChan;
    pstStoreAttr->enCurnStatus = pstChan->enCurnStatus;
    pstStoreAttr->stCreateAttr = pstChan->stCreateAttr;

    if(HI_TRUE == pstChan->stCreateAttr.bMaster)
    {
        pstStoreAttr->stInBufMmz = pstChan->stInBufMmz;
        pstStoreAttr->stInBufAttr = pstChan->stInBufAttr;
        AFLT_HAL_GetInbufReadPos(u32AfltId, &pstStoreAttr->stInBufAttr.u32Rpos);
        AFLT_HAL_GetInbufWritePos(u32AfltId, &pstStoreAttr->stInBufAttr.u32Wpos);
        AFLT_HAL_GetInbufStreamReadPos(u32AfltId, &pstStoreAttr->stInBufAttr.u32StreamReadPos);

        pstStoreAttr->stOutBufMmz = pstChan->stOutBufMmz;
        AFLTFlushOutBufData(pstChan);
        pstStoreAttr->stOutBufAttr = pstChan->stOutBufAttr;
    }
    //TODO Eosflag

    AFLT_HAL_StoreSetting(u32AfltId);  //TODO ret

    return;
}

static HI_S32 AFLT_RestoreSettings(HI_U32 u32AfltId, AFTL_STORING_S *pstStoreAttr)
{
    HI_S32 s32Ret;
    AFLT_CHANNEL_S *pstChan = HI_NULL;

    pstChan = s_stAfltDrv.astChanEntity[u32AfltId].pstChan;

    AFLT_HAL_RestoreSetting(u32AfltId);

    if(HI_TRUE == pstChan->stCreateAttr.bMaster)
    {
        s32Ret = AFLT_HAL_InitInbuf(u32AfltId, &pstStoreAttr->stInBufAttr);
        if (HI_SUCCESS !=  s32Ret)
        {
            HI_ERR_AFLT("Init AFLT(%d) inbuf fail!\n", u32AfltId);
            return s32Ret;
        }
        pstChan->stInBufAttr = pstStoreAttr->stInBufAttr;
        pstChan->stInBufMmz = pstStoreAttr->stInBufMmz;

        s32Ret = AFLT_HAL_InitOutbuf(u32AfltId, &pstStoreAttr->stOutBufAttr);
        if (HI_SUCCESS != s32Ret)
        {
            HI_ERR_AFLT("Init AFLT(%d) outbuf fail!\n", u32AfltId);
            return s32Ret;
        }
        pstChan->stOutBufAttr = pstStoreAttr->stOutBufAttr;
        pstChan->stOutBufMmz = pstStoreAttr->stOutBufMmz;
    }

    //TODO
    if(AFLT_STATUS_START == pstStoreAttr->enCurnStatus)
    {
        if(HI_SUCCESS != AFLT_HAL_Start(u32AfltId)) //TODO need create AFLTStart?
        {
            return HI_FAILURE;
        }
    }
    pstChan->enCurnStatus = pstStoreAttr->enCurnStatus;

    return HI_SUCCESS;
}

static HI_VOID AFLTGetStatusProc(HI_U32 u32AfltId, AFLT_STATUS_INFO_S stStatusInfo, AFLT_STATUS_PROC_S *pstStatusProc)
{
    AFLT_CHANNEL_S *pstChan = HI_NULL;
    HI_U32 u32InbufUse = 0, u32InbufFree = 0, u32InbufUsePerc = 0;
    HI_U32 u32OutbufUse = 0, u32OutbufFree = 0, u32OutbufUsePerc = 0;
    pstChan = s_stAfltDrv.astChanEntity[u32AfltId].pstChan;

    if(stStatusInfo.u32InBufReadPos <= stStatusInfo.u32InBufWritePos)
    {
        u32InbufUse = stStatusInfo.u32InBufWritePos - stStatusInfo.u32InBufReadPos;
    }
    else
    {
        u32InbufFree = stStatusInfo.u32InBufReadPos - stStatusInfo.u32InBufWritePos;
        u32InbufUse = pstChan->stInBufMmz.u32Size - u32InbufFree;
    }
    u32InbufUsePerc = u32InbufUse * 100 / pstChan->stInBufMmz.u32Size;

    if(stStatusInfo.u32OutBufReadIdx == stStatusInfo.u32OutBufWriteIdx)
    {
        if(stStatusInfo.u32OutBufReadWrap == stStatusInfo.u32OutBufWriteWrap)
        {
            u32OutbufUse = 0;
        }
        else
        {
            u32OutbufUse = pstChan->stOutBufAttr.u32PeriodNumber;
        }
    }
    else if(stStatusInfo.u32OutBufReadIdx < stStatusInfo.u32OutBufWriteIdx)
    {
        u32OutbufUse = stStatusInfo.u32OutBufWriteIdx - stStatusInfo.u32OutBufReadIdx;
    }
    else
    {
        u32OutbufFree = stStatusInfo.u32OutBufReadIdx - stStatusInfo.u32OutBufWriteIdx;
        u32OutbufUse = pstChan->stOutBufAttr.u32PeriodNumber - u32OutbufFree;
    }
    u32OutbufUsePerc = u32OutbufUse * 100 / pstChan->stOutBufAttr.u32PeriodNumber;

    pstStatusProc->u32InbufUse = u32InbufUse;
    pstStatusProc->u32OutbufUse = u32OutbufUse;
    pstStatusProc->u32InbufUsePerc = u32InbufUsePerc;
    pstStatusProc->u32OutbufUsePerc = u32OutbufUsePerc;

    return;
}
HI_S32 AFLT_ReadProc(struct seq_file* p, HI_U32 u32AfltId)
{
    AFLT_CHANNEL_S *pstChan = HI_NULL;
    AFLT_STATUS_INFO_S stStatusInfo;
    AFLT_STATUS_PROC_S stStatusProc;

    CHECK_AFLT_CREATE(u32AfltId);

    pstChan = s_stAfltDrv.astChanEntity[u32AfltId].pstChan;

    AFLTGetStatusInfo(u32AfltId, &stStatusInfo);
    AFLTGetStatusProc(u32AfltId, stStatusInfo, &stStatusProc);
    PROC_PRINT( p, "\n----------------------------------  Aflt[%d]  Status  --------------------------------------\n", u32AfltId);

    PROC_PRINT( p,
                "Type                                    :%s\n"
                "AfltCompId                              :%d\n"
                "Status                                  :%s\n\n",
                (HI_TRUE == pstChan->stCreateAttr.bMaster)?"master":"slave",
                pstChan->stCreateAttr.enAfltCompId,
                (AFLT_STATUS_START == pstChan->enCurnStatus)?"start":"stop");

    PROC_PRINT( p,
               "MessagePoolSize                         :0x%x\n",
                pstChan->stMsgPoolMmz.u32Size);

    if(HI_TRUE == pstChan->stCreateAttr.bMaster)
    {
        PROC_PRINT( p,
                   "InbufAttr                               :Size(0x%x)\n",
                    pstChan->stInBufMmz.u32Size);

        PROC_PRINT( p,
                   "OutbufAttr                              :Size(0x%x) PeriodSize(0x%x), PeriodNum(0x%x)\n\n",
                    pstChan->stOutBufMmz.u32Size,
                    pstChan->stOutBufAttr.u32PeriodBufSize,
                    pstChan->stOutBufAttr.u32PeriodNumber);

        PROC_PRINT( p,
                   "InBufStatus(Total/Use/Percent)(Bytes)   :0x%x/0x%x/%u%%\n",
                    pstChan->stInBufMmz.u32Size,
                    stStatusProc.u32InbufUse,
                    stStatusProc.u32InbufUsePerc);
        PROC_PRINT( p,
                   "InBufStatus(ReadPos/WritePos)           :0x%x/0x%x\n",
                    stStatusInfo.u32InBufReadPos,
                    stStatusInfo.u32InBufWritePos);
        PROC_PRINT( p,
                   "OutBufStatus(Total/Use/Percent)         :0x%x/0x%x/%u%%\n",
                    pstChan->stOutBufAttr.u32PeriodNumber,
                    stStatusProc.u32OutbufUse,
                    stStatusProc.u32OutbufUsePerc);
        PROC_PRINT( p,
                   "OutBufStatus(ReadIdx/WriteIdx)          :0x%x(%d)/0x%x(%d)\n",
                    stStatusInfo.u32OutBufReadIdx,
                    stStatusInfo.u32OutBufReadWrap,
                    stStatusInfo.u32OutBufWriteIdx,
                    stStatusInfo.u32OutBufWriteWrap);
        PROC_PRINT( p,
                   "GetBuf                                  :Try/Ok(%u/%u)\n",
                    pstChan->stPrivProcInfo.u32DbgGetBufCntTry,
                    pstChan->stPrivProcInfo.u32DbgGetBufCntOk);
        PROC_PRINT( p,
                   "PutBuf                                  :Try/Ok(%u/%u)\n",
                    pstChan->stPrivProcInfo.u32DbgPutBufCntTry,
                    pstChan->stPrivProcInfo.u32DbgPutBufCntOk);
        PROC_PRINT( p,
                   "AcquireFrame                            :Try/Ok(%u/%u)\n",
                    pstChan->stPrivProcInfo.u32DbgAcquireFrmCntTry,
                    pstChan->stPrivProcInfo.u32DbgAcquireFrmCntOk);
        PROC_PRINT( p,
                   "ReleaseFrame                            :Try/Ok(%u/%u)\n",
                    pstChan->stPrivProcInfo.u32DbgReleaseFrmCntTry,
                    pstChan->stPrivProcInfo.u32DbgReleaseFrmCntOk);
    }
    PROC_PRINT(p, "\n");

    return HI_SUCCESS;
}



/******************************Extern Function *********************************/
long AFLT_DRV_Ioctl(struct file *file, HI_U32 cmd, unsigned long arg)
{
    long s32Ret = HI_SUCCESS;

    s32Ret = down_interruptible(&g_AfltMutex);

    //cmd process
    s32Ret = (long)HI_DRV_UserCopy(file->f_dentry->d_inode, file, cmd, arg, AFLT_Ioctl);

    up(&g_AfltMutex);

    return s32Ret;
}

HI_S32 AFLT_DRV_Open(struct inode *inode, struct file  *filp)
{
    HI_S32 Ret;

    Ret = down_interruptible(&g_AfltMutex);

    if (atomic_inc_return(&s_stAfltDrv.atmOpenCnt) == 1)
    {
        s_stAfltDrv.pAdspFunc = HI_NULL;

        /* Get demux functions */
        Ret = HI_DRV_MODULE_GetFunction(HI_ID_ADSP, (HI_VOID**)&s_stAfltDrv.pAdspFunc);
        if (HI_SUCCESS != Ret)
        {
            HI_FATAL_AFLT("Get adsp function err:%#x!\n", Ret);
            goto err;
        }

        /* Init device */
        if (HI_SUCCESS != AFLT_OpenDev())
        {
            HI_FATAL_AFLT("AFLT_OpenDev err!\n" );
            goto err;
        }
    }

    up(&g_AfltMutex);
    return HI_SUCCESS;

err:
    atomic_dec(&s_stAfltDrv.atmOpenCnt);
    up(&g_AfltMutex);
    return HI_FAILURE;
}

HI_S32 AFLT_DRV_Release(struct inode *inode, struct file  *filp)
{
    HI_S32 i;
    long Ret = HI_SUCCESS;

    Ret = down_interruptible(&g_AfltMutex);

    /* Not the last close, only close the channel match with the 'filp' */
    if (atomic_dec_return(&s_stAfltDrv.atmOpenCnt) != 0)
    {
        for (i = 0; i < AFLT_MAX_CHAN_NUM; i++)
        {
            if (s_stAfltDrv.astChanEntity[i].pstFile == filp)
            {
                if (atomic_read(&s_stAfltDrv.astChanEntity[i].atmUseCnt))
                {
                    if (HI_SUCCESS != AFLT_Destroy(i))
                    {
                        atomic_inc(&s_stAfltDrv.atmOpenCnt);
                        up(&g_AfltMutex);
                        return HI_FAILURE;
                    }
                    AFLT_Chan_FreeHandle(i);
                }
            }
        }
    }
    /* Last close */
    else
    {
        AFLT_CloseDev();
    }

    up(&g_AfltMutex);
    return HI_SUCCESS;
}

HI_S32 AFLT_DRV_ReadProc( struct seq_file* p, HI_VOID* v )
{
    HI_U32 u32AfltId;
    DRV_PROC_ITEM_S *pstProcItem;

    pstProcItem = p->private;

    (HI_VOID)sscanf(pstProcItem->entry_name, "aflt%2d", &u32AfltId);

    if(u32AfltId >= AFLT_MAX_CHAN_NUM)
    {
        PROC_PRINT(p, "Invalid Aflt ID:%d.\n", u32AfltId);
        return HI_FAILURE;
    }

    return AFLT_ReadProc(p, u32AfltId);
}

HI_S32 AFLT_DRV_WriteProc(struct file * file, const char __user * buf, size_t count, loff_t *ppos)
{
    HI_S32 s32Ret;
    s32Ret = down_interruptible(&g_AfltMutex);
    up(&g_AfltMutex);
    return count;
}

HI_S32 AFLT_DRV_RegisterProc(AFLT_REGISTER_PARAM_S *pstParam)
{
    HI_S32 ret;
    HI_U32 i;

    /* Check parameters */
    if (HI_NULL == pstParam)
    {
        return HI_FAILURE;
    }

    s_stAfltDrv.pstProcParam = pstParam;

    /* Create proc */
    for (i = 0; i < AFLT_MAX_CHAN_NUM; i++)
    {
        if (s_stAfltDrv.astChanEntity[i].pstChan)
        {
            ret = AFLT_RegChanProc(i);
            if(ret != HI_SUCCESS)
            {
                HI_FATAL_AFLT("Register aflt(%d) Proc fail\n", i);
                return ret;
            }
        }
    }

    return HI_SUCCESS;
}

HI_VOID AFLT_DRV_UnRegisterProc(HI_VOID)
{
    HI_U32 i;

    /* Unregister */
    for (i = 0; i < AFLT_MAX_CHAN_NUM; i++)
    {
        if (s_stAfltDrv.astChanEntity[i].pstChan)
        {
            AFLT_UnRegChanProc(i);
        }
    }

    /* Clear param */
    s_stAfltDrv.pstProcParam = HI_NULL;

    return;
}

HI_S32 AFLT_DRV_Suspend(PM_BASEDEV_S *pdev, pm_message_t state)
{
    HI_U32 i;
    long s32Ret = HI_SUCCESS;

    s32Ret = down_interruptible(&g_AfltMutex);

    if (HI_TRUE == s_stAfltDrv.bReady)
    {
        /* Destory all aflt */
        for (i = 0; i < AFLT_MAX_CHAN_NUM; i++)
        {
            if (atomic_read(&s_stAfltDrv.astChanEntity[i].atmUseCnt))
            {
                /* Store aflt settings */
                AFLT_GetSettings(i, &s_stAfltDrv.astChanEntity[i].stStoreAttr);

                /* Destroy aflt */
                s32Ret = AFLT_Destroy(i);
                if (HI_SUCCESS != s32Ret)
                {
                    HI_FATAL_AFLT("Destroy aflt(%d) fail\n", i);
                    up(&g_AfltMutex);
                    return HI_FAILURE;
                }
            }
        }

        if (s_stAfltDrv.pAdspFunc && s_stAfltDrv.pAdspFunc->pfnADSP_UnLoadFirmware)
        {
            s32Ret = (s_stAfltDrv.pAdspFunc->pfnADSP_UnLoadFirmware)(ADSP_CODE_AFLT);
        }
    }

    up(&g_AfltMutex);
    HI_PRINT("AFLT suspend OK\n");

    return HI_SUCCESS;
}

static HI_VOID AFLT_REG_RESET(HI_VOID)
{    
    HI_VOID *pRegMapAddr = NULL ;
#ifdef CONFIG_64BIT
    pRegMapAddr = ioremap_wc(AFLT_COM_REG_BASE, AFLT_REG_LENGTH);
#else
    pRegMapAddr = ioremap_nocache(AFLT_COM_REG_BASE, AFLT_REG_LENGTH);
#endif
    memset(pRegMapAddr, 0, AFLT_REG_LENGTH);

    if (pRegMapAddr)
    {
        iounmap(pRegMapAddr);
        pRegMapAddr = 0;
    }
    
}

HI_S32 AFLT_DRV_Resume(PM_BASEDEV_S *pdev)
{
    HI_U32 i;
    long s32Ret = HI_SUCCESS;

    s32Ret = down_interruptible(&g_AfltMutex);

    if (HI_TRUE == s_stAfltDrv.bReady)
    {
        if (s_stAfltDrv.pAdspFunc && s_stAfltDrv.pAdspFunc->pfnADSP_LoadFirmware)
        {
            s32Ret = (s_stAfltDrv.pAdspFunc->pfnADSP_LoadFirmware)(ADSP_CODE_AFLT);
            if (HI_SUCCESS != s32Ret)
            {
                HI_FATAL_AFLT("load adsp_aflt fail\n");
                up(&g_AfltMutex);
                return HI_FAILURE;
            }
        }

        /* Restore all ade */

        for (i = 0; i < AFLT_MAX_CHAN_NUM; i++)
        {
            if (atomic_read(&s_stAfltDrv.astChanEntity[i].atmUseCnt))
            {
                if (HI_SUCCESS != AFLT_Create(i, &s_stAfltDrv.astChanEntity[i].stStoreAttr.stCreateAttr,
                                        &s_stAfltDrv.astChanEntity[i].stMsgRbfMmz))
                {
                    HI_FATAL_AFLT("Create aflt(%d) fail\n", i);
                    up(&g_AfltMutex);
                    return HI_FAILURE;
                }

                /* Restore decoder  settings */
                if (HI_SUCCESS != AFLT_RestoreSettings(i, &s_stAfltDrv.astChanEntity[i].stStoreAttr))
                {
                    HI_FATAL_AFLT("AFLT_RestoreSettings(%d) fail\n", i);
                    up(&g_AfltMutex);
                    return HI_FAILURE;
                }
            }
        }
    }
    else
    {        
        AFLT_REG_RESET();
    }

    up(&g_AfltMutex);
    HI_PRINT("AFLT resume OK\n");

    return HI_SUCCESS;
}

HI_S32 AFLT_DRV_Init(HI_VOID)
{
    HI_S32 Ret;

    Ret = down_interruptible(&g_AfltMutex);
    Ret = HI_DRV_MODULE_Register(HI_ID_AFLT, AFLT_NAME, HI_NULL);
    if (HI_SUCCESS != Ret)
    {
        HI_FATAL_AFLT("Register aflt module fail:%#x!\n", Ret);
        up(&g_AfltMutex);
        return Ret;
    }
    up(&g_AfltMutex);

    AFLT_REG_RESET();
    return HI_SUCCESS;
}

HI_VOID AFLT_DRV_Exit(HI_VOID)
{
    HI_S32 Ret;

    Ret = down_interruptible(&g_AfltMutex);
    HI_DRV_MODULE_UnRegister(HI_ID_AFLT);
    up(&g_AfltMutex);

    return;
}

#ifdef __cplusplus
 #if __cplusplus
}
 #endif
#endif /* End of #ifdef __cplusplus */

