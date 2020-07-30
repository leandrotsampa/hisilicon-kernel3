/***********************************************************************************
*              Copyright 2004 - 2050, Hisilicon Tech. Co., Ltd.
*                           ALL RIGHTS RESERVED
* FileName   :  drv_vi_buf.c
* Description:
*
***********************************************************************************/

#include <linux/kernel.h>

#include "drv_vicap_buf.h"
#include "hi_drv_vi.h"

HI_S32 VICAP_DRV_BufCheckAttr(VICAP_BUF_ATTR_S *pstBufAttr)
{        
    if (pstBufAttr->enBufMode > VICAP_FB_MODE_BUTT)
    {
        HI_ERR_PRINT(HI_ID_VICAP, "invalid param enBufMode[%#x].\n", pstBufAttr->enBufMode); 
		return HI_FAILURE;
    }

    if (0 == pstBufAttr->u32BufSize)
    {
        HI_ERR_PRINT(HI_ID_VICAP, "invalid param u32BufSize[%#x].\n", pstBufAttr->u32BufSize); 
		return HI_FAILURE;
    }

    if (0 == pstBufAttr->u32BufNum)
    {
        HI_ERR_PRINT(HI_ID_VICAP, "invalid param u32BufNum[%#x].\n", pstBufAttr->u32BufNum); 
		return HI_FAILURE;
    }

    return HI_SUCCESS;
}

HI_S32 VICAP_DRV_BufInit(VICAP_BUF_ATTR_S *pstBufAttr, HI_HANDLE *phBuf)
{       
    HI_S32 s32Ret = 0;
    HI_U32 i, u32SumBufSize = 0;    
    VICAP_BUF_S *pTempBuf = HI_NULL;
    VICAP_BUF_MGR_S *pstBufMgr = HI_NULL;

    if ((HI_NULL == pstBufAttr) || ((HI_NULL == phBuf)))
    {
        HI_ERR_PRINT(HI_ID_VICAP, "Null point\n"); 
        return HI_FAILURE;
    }
    
    s32Ret = VICAP_DRV_BufCheckAttr(pstBufAttr);
    if (s32Ret != HI_SUCCESS)
    {
        return HI_FAILURE;
    }

    pstBufMgr = (VICAP_BUF_MGR_S *)kzalloc(sizeof(VICAP_BUF_MGR_S), GFP_KERNEL);
    if (!pstBufMgr) 
    {
        HI_ERR_PRINT(HI_ID_VICAP, "kzalloc failed\n"); 
		return HI_FAILURE;
	}

    pstBufMgr->pstBuf = (VICAP_BUF_S *)kzalloc(sizeof(VICAP_BUF_S) * pstBufAttr->u32BufNum, GFP_KERNEL);
    if (!pstBufMgr->pstBuf) 
    {
        kfree(pstBufMgr);
        HI_ERR_PRINT(HI_ID_VICAP, "kzalloc failed\n"); 
		return HI_FAILURE;
	}

    spin_lock_init(&pstBufMgr->stBufLock);
    
    INIT_LIST_HEAD(&pstBufMgr->stFree);
    INIT_LIST_HEAD(&pstBufMgr->stBusy);
    INIT_LIST_HEAD(&pstBufMgr->stUsed);

    if (VICAP_FB_MODE_ALLOC == pstBufAttr->enBufMode)
    {
        u32SumBufSize = pstBufAttr->u32BufSize * pstBufAttr->u32BufNum;
        s32Ret = HI_DRV_MMZ_AllocAndMap("VI_ChnBuf", MMZ_OTHERS, u32SumBufSize, 0, &pstBufMgr->stMMZBuf);
        if (s32Ret != HI_SUCCESS)
        {            
            kfree(pstBufMgr->pstBuf);
            kfree(pstBufMgr);
            HI_ERR_PRINT(HI_ID_VICAP,"VI HI_DRV_MMZ_AllocAndMap failed\n");
            return HI_NULL;
        }
        
        memset((HI_CHAR*)pstBufMgr->stMMZBuf.pu8StartVirAddr, 0, u32SumBufSize);
    }
    
    for (i = 0; i < pstBufAttr->u32BufNum; i++)
    {
        pTempBuf = pstBufMgr->pstBuf + i;        
        pTempBuf->u32Index = i;
        pTempBuf->s32SumCnt = 0;
        
        switch (pstBufAttr->enBufMode)
        {
            case VICAP_FB_MODE_ALLOC:
            {
                pTempBuf->stVideoFrmInfo.stBufAddr[0].u32PhyAddr_Y = pstBufMgr->stMMZBuf.u32StartPhyAddr
                                        + i * pstBufAttr->u32BufSize;      
                list_add_tail(&pTempBuf->stList, &pstBufMgr->stFree);
                break;
            }
            default:
            {
                break;
            }
        }
    }

    memcpy(&pstBufMgr->stBufAttr, pstBufAttr, sizeof(VICAP_BUF_ATTR_S));
    *phBuf = (HI_HANDLE)pstBufMgr;

    return HI_SUCCESS;
}
/* VICAP Buf去始化 */
HI_S32 VICAP_DRV_BufDeInit(HI_HANDLE hBuf)
{       
    VICAP_BUF_MGR_S *pstBufMgr = HI_NULL;
        
    if ((HI_INVALID_HANDLE == hBuf) || (0 == hBuf))
    {
        HI_ERR_PRINT(HI_ID_VICAP, "Invalid handle\n"); 
        return HI_FAILURE;
    }

    pstBufMgr = (VICAP_BUF_MGR_S *)hBuf;
    if (VICAP_FB_MODE_ALLOC == pstBufMgr->stBufAttr.enBufMode)
    {
        HI_DRV_MMZ_UnmapAndRelease(&pstBufMgr->stMMZBuf);
    }

    kfree(pstBufMgr->pstBuf);

    kfree(pstBufMgr);

    return HI_SUCCESS;
}

/* VICAP Buf复位为初始状态 */
HI_S32 VICAP_DRV_BufReset(HI_HANDLE hBuf)
{       
    HI_U32 i;
    VICAP_BUF_S *pTempBuf = HI_NULL;
    VICAP_BUF_MGR_S *pstBufMgr = HI_NULL;
        
    if ((HI_INVALID_HANDLE == hBuf) || (0 == hBuf))
    {
        HI_ERR_PRINT(HI_ID_VICAP, "Invalid handle\n"); 
        return HI_FAILURE;
    }

    pstBufMgr = (VICAP_BUF_MGR_S *)hBuf;
    for (i = 0; i < pstBufMgr->stBufAttr.u32BufNum; i++)
    {
        pTempBuf = pstBufMgr->pstBuf + i;
        pTempBuf->s32SumCnt = 0;
        list_del(&pTempBuf->stList);
        list_add_tail(&pTempBuf->stList, &pstBufMgr->stFree);
    }    

    return HI_SUCCESS;
}

/* 设置MMAP模式的外部Buf的地址 */
HI_S32 VICAP_DRV_BufSetExt(HI_HANDLE hBuf, HI_U32 u32PhyAddr[], HI_U32 u32BufNum)
{       
    HI_U32 i;
    VICAP_BUF_S *pTempBuf = HI_NULL;
    VICAP_BUF_MGR_S *pstBufMgr = HI_NULL;

    if ((HI_INVALID_HANDLE == hBuf) || (0 == hBuf))
    {
        HI_ERR_PRINT(HI_ID_VICAP, "Invalid handle\n"); 
        return HI_FAILURE;
    }
        
    if (HI_NULL == u32PhyAddr)
    {
        HI_ERR_PRINT(HI_ID_VICAP, "u32PhyAddr Null point\n"); 
        return HI_FAILURE;
    }

    pstBufMgr = (VICAP_BUF_MGR_S *)hBuf;
    if (u32BufNum > pstBufMgr->stBufAttr.u32BufNum)
    {
        HI_ERR_PRINT(HI_ID_VICAP, "u32BufNum is over buf init Num.\n"); 
        return HI_FAILURE;
    }
    
    for (i = 0; i < u32BufNum; i++)
    {
        pTempBuf = pstBufMgr->pstBuf + i;
        pTempBuf->stVideoFrmInfo.stBufAddr[0].u32PhyAddr_Y = u32PhyAddr[i];
        list_add_tail(&pTempBuf->stList, &pstBufMgr->stFree);
    }    

    return HI_SUCCESS;
}

/* 获取空闲Buf */
HI_S32 VICAP_DRV_BufGet(HI_HANDLE hBuf, VICAP_BUF_S *pstBuf)
{
    unsigned long vicapbuf_lockflag;
    struct list_head *pstList = NULL;
    VICAP_BUF_MGR_S *pstBufMgr = HI_NULL;
    VICAP_BUF_S *pTempBuf = HI_NULL;

    if ((HI_INVALID_HANDLE == hBuf) || (0 == hBuf))
    {
        HI_ERR_PRINT(HI_ID_VICAP, "Invalid handle\n"); 
        return HI_FAILURE;
    }
    
    if (HI_NULL == pstBuf)
    {
        HI_ERR_PRINT(HI_ID_VICAP, "Null point\n"); 
        return HI_FAILURE;
    }

    pstBufMgr = (VICAP_BUF_MGR_S *)hBuf;
    
    spin_lock_irqsave(&pstBufMgr->stBufLock,vicapbuf_lockflag);
    if (list_empty(&pstBufMgr->stFree))
    {        
        if (VICAP_FB_MODE_MMAP == pstBufMgr->stBufAttr.enBufMode)
        {
            HI_ERR_PRINT(HI_ID_VICAP, "MMAP Mode please SetExt firstly.\n"); 
        }
        HI_INFO_PRINT(HI_ID_VICAP, "no free buffer.\n");        
        spin_unlock_irqrestore(&pstBufMgr->stBufLock,vicapbuf_lockflag);
        return HI_FAILURE;
    }

    pstList = pstBufMgr->stFree.next;
    pTempBuf = list_entry(pstList, VICAP_BUF_S, stList);
    list_del(&pTempBuf->stList);
    INIT_LIST_HEAD(&pTempBuf->stList);
    pTempBuf->s32SumCnt++;
    
    memcpy(pstBuf, pTempBuf, sizeof(VICAP_BUF_S));
    spin_unlock_irqrestore(&pstBufMgr->stBufLock,vicapbuf_lockflag);

    return HI_SUCCESS;
}

/* 送入采集的数据Buf */
HI_S32 VICAP_DRV_BufPut(HI_HANDLE hBuf, VICAP_BUF_S *pstBuf)
{
    unsigned long vicapbuf_lockflag;
    HI_U32 u32BufOffset = 0;
    VICAP_BUF_MGR_S *pstBufMgr = HI_NULL;
    VICAP_BUF_S *pTempBuf = HI_NULL;

    if ((HI_INVALID_HANDLE == hBuf) || (0 == hBuf))
    {
        HI_ERR_PRINT(HI_ID_VICAP, "Invalid handle\n"); 
        return HI_FAILURE;
    }
    
    if (HI_NULL == pstBuf)
    {
        HI_ERR_PRINT(HI_ID_VICAP, "Null point\n"); 
        return HI_FAILURE;
    }

    pstBufMgr = (VICAP_BUF_MGR_S *)hBuf;
    spin_lock_irqsave(&pstBufMgr->stBufLock,vicapbuf_lockflag);
    u32BufOffset = (pstBuf->stVideoFrmInfo.stBufAddr[0].u32PhyAddr_Y - pstBufMgr->stMMZBuf.u32StartPhyAddr) / pstBufMgr->stBufAttr.u32BufSize;
    if (u32BufOffset >= pstBufMgr->stBufAttr.u32BufNum)
    {
        HI_ERR_PRINT(HI_ID_VICAP, "Buf addr [0x%x] is over range.\n",pstBuf->stVideoFrmInfo.stBufAddr[0].u32PhyAddr_Y); 
        spin_unlock_irqrestore(&pstBufMgr->stBufLock,vicapbuf_lockflag);
        
        return HI_FAILURE;
    }
   
    pTempBuf = pstBufMgr->pstBuf + u32BufOffset;
    memcpy(&pTempBuf->stVideoFrmInfo, &pstBuf->stVideoFrmInfo,sizeof(HI_DRV_VIDEO_FRAME_S));
    /* put到busy队列的节点都应该是get的free节点，如果不是则为异常情况 */
    if (!list_empty(&pTempBuf->stList))
    {
        HI_ERR_PRINT(HI_ID_VICAP, "this buf node is not a free node.\n");    
        spin_unlock_irqrestore(&pstBufMgr->stBufLock,vicapbuf_lockflag);
        
        return HI_FAILURE;
    }
        
    list_add_tail(&pTempBuf->stList, &pstBufMgr->stBusy);
    
    spin_unlock_irqrestore(&pstBufMgr->stBufLock,vicapbuf_lockflag);

    return HI_SUCCESS;
}

/* 获取数据Buf */
HI_S32 VICAP_DRV_BufAcquire(HI_HANDLE hBuf, VICAP_BUF_S *pstBuf)
{
    unsigned long vicapbuf_lockflag;
    struct list_head *pstList = NULL;
    VICAP_BUF_MGR_S *pstBufMgr = HI_NULL;
    VICAP_BUF_S *pTempBuf = HI_NULL;

    if ((HI_INVALID_HANDLE == hBuf) || (0 == hBuf))
    {
        HI_ERR_PRINT(HI_ID_VICAP, "Invalid handle\n"); 
        return HI_FAILURE;
    }
    
    if (HI_NULL == pstBuf)
    {
        HI_ERR_PRINT(HI_ID_VICAP, "Null point\n"); 
        return HI_FAILURE;
    }

    pstBufMgr = (VICAP_BUF_MGR_S *)hBuf;
    spin_lock_irqsave(&pstBufMgr->stBufLock,vicapbuf_lockflag);
    
    if (list_empty(&pstBufMgr->stBusy))
    {
        HI_INFO_PRINT(HI_ID_VICAP, "no busy buffer.\n");
        spin_unlock_irqrestore(&pstBufMgr->stBufLock,vicapbuf_lockflag);
        return HI_FAILURE;
    }

    pstList = pstBufMgr->stBusy.next;
    pTempBuf = list_entry(pstList, VICAP_BUF_S, stList);
    list_del(&pTempBuf->stList);
    list_add_tail(&pTempBuf->stList, &pstBufMgr->stUsed);
    memcpy(pstBuf, pTempBuf, sizeof(VICAP_BUF_S));
    spin_unlock_irqrestore(&pstBufMgr->stBufLock,vicapbuf_lockflag);

    return HI_SUCCESS;
}

/* 释放Buf */
HI_S32 VICAP_DRV_BufRelease(HI_HANDLE hBuf, VICAP_BUF_S *pstBuf)
{
    unsigned long vicapbuf_lockflag;
    HI_U32 u32BufOffset = 0;
    VICAP_BUF_MGR_S *pstBufMgr = HI_NULL;
    VICAP_BUF_S *pTempBuf = HI_NULL;

    if ((HI_INVALID_HANDLE == hBuf) || (0 == hBuf))
    {
        HI_ERR_PRINT(HI_ID_VICAP, "Invalid handle\n"); 
        return HI_FAILURE;
    }

    if (HI_NULL == pstBuf)
    {
        HI_ERR_PRINT(HI_ID_VICAP, "Null point\n"); 
        return HI_FAILURE;
    }

    pstBufMgr = (VICAP_BUF_MGR_S *)hBuf;  

    if((pstBuf->stVideoFrmInfo.stBufAddr[0].u32PhyAddr_Y < pstBufMgr->stMMZBuf.u32StartPhyAddr)
        ||(pstBuf->stVideoFrmInfo.stBufAddr[0].u32PhyAddr_Y >= pstBufMgr->stMMZBuf.u32StartPhyAddr + pstBufMgr->stMMZBuf.u32StartPhyAddr))
    {
        HI_ERR_PRINT(HI_ID_VICAP, "Buf addr:[0x%x] is over range.\n", pstBuf->stVideoFrmInfo.stBufAddr[0].u32PhyAddr_Y); 
        return HI_FAILURE;
    }
    
    spin_lock_irqsave(&pstBufMgr->stBufLock,vicapbuf_lockflag);
    u32BufOffset = (pstBuf->stVideoFrmInfo.stBufAddr[0].u32PhyAddr_Y - pstBufMgr->stMMZBuf.u32StartPhyAddr) / pstBufMgr->stBufAttr.u32BufSize;

    pTempBuf = pstBufMgr->pstBuf + u32BufOffset;
    pTempBuf->s32SumCnt--;
    if (pTempBuf->s32SumCnt <= 0)
    {
        list_del(&pTempBuf->stList);
        pTempBuf->s32SumCnt = 0;
        list_add_tail(&pTempBuf->stList, &pstBufMgr->stFree);
    }
    spin_unlock_irqrestore(&pstBufMgr->stBufLock,vicapbuf_lockflag);

    return HI_SUCCESS;
}

/* Buf引用计数加1 */
HI_S32 VICAP_DRV_BufAdd(HI_HANDLE hBuf, HI_U32 u32PhyAddr)
{
    unsigned long vicapbuf_lockflag;
    HI_U32 u32BufOffset = 0;
    VICAP_BUF_MGR_S *pstBufMgr = HI_NULL;
    VICAP_BUF_S *pTempBuf = HI_NULL;

    if ((HI_INVALID_HANDLE == hBuf) || (0 == hBuf))
    {
        HI_ERR_PRINT(HI_ID_VICAP, "Invalid handle\n"); 
        return HI_FAILURE;
    }

    pstBufMgr = (VICAP_BUF_MGR_S *)hBuf;  
    spin_lock_irqsave(&pstBufMgr->stBufLock,vicapbuf_lockflag);

    if((u32PhyAddr < pstBufMgr->stMMZBuf.u32StartPhyAddr)
        ||(u32PhyAddr >= pstBufMgr->stMMZBuf.u32StartPhyAddr + pstBufMgr->stMMZBuf.u32StartPhyAddr))
    {
        HI_ERR_PRINT(HI_ID_VICAP, "Buf addr:[0x%x] is over range.\n", u32PhyAddr);
        spin_unlock_irqrestore(&pstBufMgr->stBufLock,vicapbuf_lockflag);

        return HI_FAILURE;
    }
    
    u32BufOffset = (u32PhyAddr - pstBufMgr->stMMZBuf.u32StartPhyAddr) / pstBufMgr->stBufAttr.u32BufSize;

    pTempBuf = pstBufMgr->pstBuf + u32BufOffset;
    pTempBuf->s32SumCnt++;
    spin_unlock_irqrestore(&pstBufMgr->stBufLock,vicapbuf_lockflag);

    return HI_SUCCESS;
}

/* Buf引用计数减1 */
HI_S32 VICAP_DRV_BufSub(HI_HANDLE hBuf, HI_U32 u32PhyAddr)
{
    unsigned long vicapbuf_lockflag;
    HI_U32 u32BufOffset = 0;
    VICAP_BUF_MGR_S *pstBufMgr = HI_NULL;
    VICAP_BUF_S *pTempBuf = HI_NULL;

    if ((HI_INVALID_HANDLE == hBuf) || (0 == hBuf))
    {
        HI_ERR_PRINT(HI_ID_VICAP, "Invalid handle\n"); 
        return HI_FAILURE;
    }

    pstBufMgr = (VICAP_BUF_MGR_S *)hBuf;  
    spin_lock_irqsave(&pstBufMgr->stBufLock,vicapbuf_lockflag);

    if((u32PhyAddr < pstBufMgr->stMMZBuf.u32StartPhyAddr)
        ||(u32PhyAddr >= pstBufMgr->stMMZBuf.u32StartPhyAddr + pstBufMgr->stMMZBuf.u32StartPhyAddr))
    {
        HI_ERR_PRINT(HI_ID_VICAP, "Buf addr:[0x%x] is over range.\n", u32PhyAddr); 
        spin_unlock_irqrestore(&pstBufMgr->stBufLock,vicapbuf_lockflag);

        return HI_FAILURE;
    }
    
    u32BufOffset = (u32PhyAddr - pstBufMgr->stMMZBuf.u32StartPhyAddr) / pstBufMgr->stBufAttr.u32BufSize;
    pTempBuf = pstBufMgr->pstBuf + u32BufOffset;
    
    if (unlikely(pTempBuf->s32SumCnt <= 0))
    {
        HI_ERR_PRINT(HI_ID_VICAP, "try to sub user for a free buffer!\n");
        spin_unlock_irqrestore(&pstBufMgr->stBufLock,vicapbuf_lockflag);

        return HI_FAILURE;
    }
    
    pTempBuf->s32SumCnt--;
    
    if (pTempBuf->s32SumCnt <= 0)
    {
        list_del(&pTempBuf->stList);            
        //INIT_LIST_HEAD(&pTempBuf->stList);
        pTempBuf->s32SumCnt = 0;
        list_add_tail(&pTempBuf->stList, &pstBufMgr->stFree);
    }
    spin_unlock_irqrestore(&pstBufMgr->stBufLock,vicapbuf_lockflag);

    return HI_SUCCESS;
}


