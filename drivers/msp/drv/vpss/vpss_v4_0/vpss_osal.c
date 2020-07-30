
#include "vpss_osal.h"
#include <linux/wait.h>

#ifdef HI_TEE_SUPPORT
#include "sec_mmz.h"
#endif

#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif
#endif

/************************************************************************/
/* file operation                                                       */
/************************************************************************/

struct file *VPSS_OSAL_fopen(const char *filename, int flags, int mode)
{
        struct file *filp = filp_open(filename, flags, mode);
        return (IS_ERR(filp)) ? NULL : filp;
}

void VPSS_OSAL_fclose(struct file *filp)
{
        if (filp)
            filp_close(filp, NULL);
}

int VPSS_OSAL_fread(char *buf, unsigned int len, struct file *filp)
{
        int readlen;
        mm_segment_t oldfs;

        if (filp == NULL)
                return -ENOENT;
        if (filp->f_op->read == NULL)
                return -ENOSYS;
        if (((filp->f_flags & O_ACCMODE) & (O_RDONLY | O_RDWR)) == 0)
                return -EACCES;
        oldfs = get_fs();
        set_fs(KERNEL_DS);
        readlen = filp->f_op->read(filp, buf, len, &filp->f_pos);
        set_fs(oldfs);

        return readlen;
}

int VPSS_OSAL_fwrite(char *buf, int len, struct file *filp)
{
        int writelen;
        mm_segment_t oldfs;

        if (filp == NULL)
                return -ENOENT;
        if (filp->f_op->write == NULL)
                return -ENOSYS;
        if (((filp->f_flags & O_ACCMODE) & (O_WRONLY | O_RDWR)) == 0)
                return -EACCES;
        oldfs = get_fs();
        set_fs(KERNEL_DS);
        writelen = filp->f_op->write(filp, buf, len, &filp->f_pos);
        set_fs(oldfs);

        return writelen;
}


/************************************************************************/
/* event operation                                                      */
/************************************************************************/
HI_S32 VPSS_OSAL_InitEvent( OSAL_EVENT *pEvent, HI_S32 InitVal1, HI_S32 InitVal2)
{
    pEvent->flag_1 = InitVal1;
    pEvent->flag_2 = InitVal2;
    init_waitqueue_head( &(pEvent->queue_head) );
    return OSAL_OK;
}

HI_S32 VPSS_OSAL_GiveEvent( OSAL_EVENT *pEvent, HI_S32 InitVal1, HI_S32 InitVal2)
{
    pEvent->flag_1 = InitVal1;
    pEvent->flag_2 = InitVal2;

    wake_up(&(pEvent->queue_head));
	return OSAL_OK;
}

HI_S32 VPSS_OSAL_WaitEvent( OSAL_EVENT *pEvent, HI_S32 s32WaitTime )
{
	int l_ret;
    long unsigned int time;
    time = jiffies;
    l_ret = wait_event_timeout( pEvent->queue_head,
                                (pEvent->flag_1 != 0 || pEvent->flag_2 != 0),
                                s32WaitTime );
    if(l_ret == 0
       || pEvent->flag_2 == 1
       || l_ret < 0)
    {
        return OSAL_ERR;
    }
    else
    {
        return OSAL_OK;
    }
}

HI_S32 VPSS_OSAL_ResetEvent( OSAL_EVENT *pEvent, HI_S32 InitVal1, HI_S32 InitVal2)
{
    pEvent->flag_1 = InitVal1;
    pEvent->flag_2 = InitVal2;

    return OSAL_OK;
}


/************************************************************************/
/* mutux lock operation                                                 */
/************************************************************************/
HI_S32 VPSS_OSAL_InitLOCK(VPSS_OSAL_LOCK *pLock, HI_U32 u32InitVal)
{
    sema_init(pLock,u32InitVal);
    return HI_SUCCESS;
}

HI_S32 VPSS_OSAL_DownLock(VPSS_OSAL_LOCK *pLock)
{
    HI_S32 s32Ret;
    s32Ret = down_interruptible(pLock);

    if (s32Ret < 0)
    {
		return HI_FAILURE;
	}
    else if (s32Ret == 0)
    {
        return HI_SUCCESS;
    }
    else
    {
        VPSS_FATAL("DownLock Error! ret = %d\n",s32Ret);
        return HI_FAILURE;
    }
    return HI_SUCCESS;
}

HI_S32 VPSS_OSAL_TryLock(VPSS_OSAL_LOCK *pLock)
{
    HI_S32 s32Ret;
    s32Ret = down_trylock(pLock);
    if (s32Ret == 0)
    {
        return HI_SUCCESS;
    }
    else
    {
        return HI_FAILURE;
    }
}

HI_S32 VPSS_OSAL_UpLock(VPSS_OSAL_LOCK *pLock)
{
    up(pLock);
    return HI_SUCCESS;
}



/************************************************************************/
/* spin lock operation                                                  */
/************************************************************************/
HI_S32 VPSS_OSAL_InitSpin(VPSS_OSAL_SPIN *pLock)
{
    spin_lock_init(pLock);
	return HI_SUCCESS;
}

HI_S32 VPSS_OSAL_DownSpin(VPSS_OSAL_SPIN *pLock,unsigned long *flags)
{
    spin_lock_irqsave(pLock, *flags);

    return HI_SUCCESS;
}

HI_S32 VPSS_OSAL_UpSpin(VPSS_OSAL_SPIN *pLock,unsigned long *flags)
{
    spin_unlock_irqrestore(pLock, *flags);

    return HI_SUCCESS;
}

HI_S32 VPSS_OSAL_TryLockSpin(VPSS_OSAL_SPIN *pLock,unsigned long *flags)
{
   if(spin_trylock_irqsave(pLock, *flags))
   {
        return HI_SUCCESS;
   }
   else
   {
        return HI_FAILURE;
   }
}

/************************************************************************/
/* debug operation                                                      */
/************************************************************************/
HI_S32 VPSS_OSAL_GetProcArg(HI_CHAR*  chCmd,HI_CHAR*  chArg,HI_U32 u32ArgIdx)
{
    HI_U32 u32Count;
    HI_U32 u32CmdCount;
    HI_U32 u32LogCount;
    HI_U32 u32NewFlag;
    HI_CHAR chArg1[DEF_FILE_NAMELENGTH] = {0};
    HI_CHAR chArg2[DEF_FILE_NAMELENGTH] = {0};
    HI_CHAR chArg3[DEF_FILE_NAMELENGTH] = {0};
    u32CmdCount = 0;

    /*clear empty space*/
    u32Count = 0;
    u32CmdCount = 0;
    u32LogCount = 1;
    u32NewFlag = 0;
    while(chCmd[u32Count] != 0 && chCmd[u32Count] != '\n' )
    {
        if (chCmd[u32Count] != ' ')
        {
            u32NewFlag = 1;
        }
        else
        {
            if(u32NewFlag == 1)
            {
                u32LogCount++;
                u32CmdCount= 0;
                u32NewFlag = 0;
            }
        }

        if (u32NewFlag == 1)
        {
            switch(u32LogCount)
            {
                case 1:
                    chArg1[u32CmdCount] = chCmd[u32Count];
                    u32CmdCount++;
                    break;
                case 2:
                    chArg2[u32CmdCount] = chCmd[u32Count];
                    u32CmdCount++;
                    break;
                case 3:
                    chArg3[u32CmdCount] = chCmd[u32Count];
                    u32CmdCount++;
                    break;
                default:
                    break;
            }

        }
        u32Count++;
    }

    switch(u32ArgIdx)
    {
        case 1:
            memcpy(chArg,chArg1,sizeof(HI_CHAR)*DEF_FILE_NAMELENGTH);
            break;
        case 2:
            memcpy(chArg,chArg2,sizeof(HI_CHAR)*DEF_FILE_NAMELENGTH);
            break;
        case 3:
            memcpy(chArg,chArg3,sizeof(HI_CHAR)*DEF_FILE_NAMELENGTH);
            break;
        default:
            break;
    }
    return HI_SUCCESS;
}


HI_S32 VPSS_OSAL_ParseCmd(HI_CHAR*  chArg1,HI_CHAR*  chArg2,HI_CHAR*  chArg3,HI_VOID *pstCmd)
{
    return HI_SUCCESS;
}

HI_S32 VPSS_OSAL_TransforUV10bitTobit(HI_U8 *pu10UVdata,HI_U8 *pu8Udata,HI_U8 *pu8Vdata,HI_U32 u32Stride,HI_U32 u32Width,HI_DRV_PIX_FORMAT_E eFormat)
{
    HI_U8 *pTmp;
    HI_U32 i,j,tmpU,tmpV;
    pTmp = VPSS_VMALLOC(u32Stride*8);
    if (pTmp == HI_NULL)
    {
        return HI_FAILURE;
    }
    for(i = 0; i < u32Stride; i++)
    {
        for(j=0; j < 8; j++)
        {
            pTmp[i*8 +j] = (pu10UVdata[i]>>j) & 0x1;
        }
    }
    for(i = 0; i < u32Width/2; i = i+2)
    {
        tmpU = 0;
        for(j=0; j < 8; j++)
        {
            tmpU |= pTmp[i*10+j+2]<<j;
        }
        tmpV = 0;
        for(j=0; j < 8; j++)
        {
            tmpV |= pTmp[(i+1)*10+j+2]<<j;
        }
        if((eFormat == HI_DRV_PIX_FMT_NV21) || (eFormat == HI_DRV_PIX_FMT_NV61_2X1) )
        {
            pu8Vdata[i] = tmpU;
            pu8Udata[i] = tmpV;
        }
        else
        {
            pu8Udata[i] = tmpU;
            pu8Vdata[i] = tmpV;
        }
    }
    VPSS_VFREE(pTmp);
    return HI_SUCCESS;
}
HI_S32 VPSS_OSAL_Transfor10bitTobit(HI_U8 *pu10Ydata,HI_U8 *pu8Ydata,HI_U32 u32Stride,HI_U32 u32Width)
{
    HI_U8 *pTmp;
    HI_U32 i,j,tmp;
    pTmp = VPSS_VMALLOC(u32Stride*8);
    if (pTmp == HI_NULL)
    {
        return HI_FAILURE;
    }
    for(i = 0; i < u32Stride; i++)
    {
        for(j=0; j < 8; j++)
        {
            pTmp[i*8 +j] = (pu10Ydata[i]>>j) & 0x1;
        }
    }
    for(i = 0; i < u32Width; i++)
    {
        tmp = 0;
        for(j=0; j < 8; j++)
        {
            tmp |= pTmp[i*10+j+2]<<j;
        }
        pu8Ydata[i] = tmp;
    }
    VPSS_VFREE(pTmp);
    return HI_SUCCESS;
}

HI_U8  temp[4096]={0};
static inline HI_VOID VPSS_OSAL_OneLine10To8Bit(int enType, HI_CHAR *pInAddr, HI_U32 u32Width, HI_CHAR *pOutAddr)
{
    HI_U32 i, j, u32Cnt;
    HI_CHAR  *pTmpMem = NULL;

    pTmpMem = pInAddr;
    u32Cnt = HICEILING(u32Width, 4);//四个像素一循环，占5 byte,不足四个像素也占5byte处理
    for (i = 0; i < u32Cnt; i++)
    {
        for(j = 0; j < 5; j++)
        {
             temp[j] = *(pTmpMem + i*5 + j);
        }

        if (0 == enType)
        {
            *pOutAddr = ((temp[1] << 6) & 0xc0) | ((temp[0] >> 2)& 0x3f);
            pOutAddr++;
            *pOutAddr = ((temp[2] << 4) & 0xf0) | ((temp[1] >> 4)& 0x0f);
            pOutAddr++;
            *pOutAddr = ((temp[3] << 2) & 0xfc) | ((temp[2] >> 6)& 0x03);
            pOutAddr++;
            *pOutAddr = temp[4] & 0xff;
            pOutAddr++;

        }
        else if (1 == enType)
        {
            *pOutAddr = ((temp[2] << 4) & 0xf0) | ((temp[1] >> 4)& 0x0f);
			pOutAddr++;
			*pOutAddr = temp[4] & 0xff;
			pOutAddr++;
        }
        else
        {
            *pOutAddr = ((temp[1] << 6) & 0xc0) | ((temp[0] >> 2)& 0x3f);
			pOutAddr++;
			*pOutAddr = ((temp[3] << 2) & 0xfc) | ((temp[2] >> 6)& 0x03);
			pOutAddr++;
        }
    }

}

HI_S32 VPSS_OSAL_StrToNumb(HI_CHAR*  chStr,HI_U32 *pu32Numb)
{
    HI_U32 u32Count = 0;
    HI_U32 u32RetNumb = 0;

    while(chStr[u32Count] != 0)
    {
        u32RetNumb = u32RetNumb*10 + chStr[u32Count] - '0';
        u32Count++;
    }

    *pu32Numb = u32RetNumb;

    return HI_SUCCESS;
}

HI_U8* VPSS_OSAL_MEMMap(HI_BOOL bSecure, HI_U32 u32StartPhyAddr)
{
    HI_S32                s32Ret = HI_SUCCESS;
   
    if (HI_FALSE == bSecure)
    {
#ifdef HI_VPSS_SMMU_SUPPORT
        SMMU_BUFFER_S stMMU = {0};

        stMMU.u32StartSmmuAddr = u32StartPhyAddr;
        s32Ret = HI_DRV_SMMU_Map(&stMMU);
        if (HI_SUCCESS == s32Ret)
        {
            return stMMU.pu8StartVirAddr;
        }
        else
        {
            VPSS_ERROR("HI_DRV_SMMU_Map alloc failed\n");
            return HI_NULL;
        }
#else
        MMZ_BUFFER_S stMMZ = {0};

        stMMZ.u32StartPhyAddr = u32StartPhyAddr;
        s32Ret = HI_DRV_MMZ_Map(&stMMZ);

        if (HI_SUCCESS == s32Ret)
        {
            return stMMZ.pu8StartVirAddr;
        }
        else
        {
            VPSS_ERROR("HI_DRV_MMZ_Map alloc failed\n");
            return HI_NULL;
        }

#endif
    }
    else
    {
        VPSS_ERROR("Can not map in secure mode!\n");
    }
    return HI_NULL;
}

HI_S32 VPSS_OSAL_MEMUnmap(HI_BOOL bSecure, HI_U32 u32StartPhyAddr, HI_U8* pu8StartVirAddr)
{
    HI_S32 s32Ret = HI_SUCCESS;

    if (HI_FALSE == bSecure)
    {
#ifdef HI_VPSS_SMMU_SUPPORT
        SMMU_BUFFER_S stMMU = {0};

        stMMU.u32StartSmmuAddr = u32StartPhyAddr;
        stMMU.pu8StartVirAddr = pu8StartVirAddr;

        HI_DRV_SMMU_Unmap(&stMMU);
#else
        MMZ_BUFFER_S stMMZ = {0};

        stMMZ.u32StartPhyAddr = u32StartPhyAddr;
        stMMZ.pu8StartVirAddr = pu8StartVirAddr;
        HI_DRV_MMZ_Unmap(&stMMZ);
#endif
    }
    else
    {
        VPSS_ERROR("Can not unmap in secure mode!\n");
    }

    return s32Ret;
}

HI_S32 VPSS_OSAL_WRITEYUV_10BIT(HI_DRV_VIDEO_FRAME_S *pstFrame,HI_CHAR* pchFile)
{
    char str[50] = {0};
    unsigned char *ptr;
    FILE *fp;
    HI_U8 *pu8Udata;
    HI_U8 *pu8Vdata;
    HI_U8 *pu8Ydata;
    HI_U8 *pu10UVdata;
    HI_U8 *pu10Ydata;
    HI_S8  s_VpssSavePath[DEF_FILE_NAMELENGTH];
    HI_U32 i;
    HI_DRV_LOG_GetStorePath(s_VpssSavePath, DEF_FILE_NAMELENGTH);
    HI_OSAL_Snprintf(str, 50, "%s/%s", s_VpssSavePath,pchFile);

    if (pstFrame->ePixFormat == HI_DRV_PIX_FMT_NV21
        || pstFrame->ePixFormat == HI_DRV_PIX_FMT_NV12)
    {
        pu8Udata = VPSS_VMALLOC(pstFrame->u32Width * pstFrame->u32Height / 2 /2);
        if (pu8Udata == HI_NULL)
        {
            return HI_FAILURE;
        }

        pu10UVdata = VPSS_VMALLOC(pstFrame->stBufAddr[0].u32Stride_C);
        if (pu10UVdata == HI_NULL)
        {
            VPSS_VFREE(pu8Udata);
            return HI_FAILURE;
        }

        pu8Vdata = VPSS_VMALLOC(pstFrame->u32Width * pstFrame->u32Height / 2 /2);
        if (pu8Vdata == HI_NULL)
        {
            VPSS_VFREE(pu8Udata);
            VPSS_VFREE(pu10UVdata);
            return HI_FAILURE;
        }
        pu8Ydata = VPSS_VMALLOC(pstFrame->u32Width);
        if (pu8Ydata == HI_NULL)
        {
            VPSS_VFREE(pu8Udata);
            VPSS_VFREE(pu8Vdata);
            VPSS_VFREE(pu10UVdata);
            return HI_FAILURE;
        }
        pu10Ydata = VPSS_VMALLOC(pstFrame->stBufAddr[0].u32Stride_Y);
        if (pu10Ydata == HI_NULL)
        {
            VPSS_VFREE(pu8Udata);
            VPSS_VFREE(pu8Vdata);
            VPSS_VFREE(pu10UVdata);
            VPSS_VFREE(pu8Ydata);
            return HI_FAILURE;
        }
        ptr = VPSS_OSAL_MEMMap(pstFrame->bSecure, pstFrame->stBufAddr[0].u32PhyAddr_Y);
        if (!ptr)
        {
            VPSS_FATAL("address is not valid!\n");
        }
        else
        {
            fp = VPSS_OSAL_fopen(str, O_RDWR | O_CREAT|O_APPEND, 0);
            if (fp == HI_NULL)
            {
                VPSS_FATAL("open file '%s' fail!\n", str);
                VPSS_VFREE(pu8Udata);
                VPSS_VFREE(pu8Vdata);
                VPSS_VFREE(pu8Ydata);
                VPSS_VFREE(pu10UVdata);
                VPSS_VFREE(pu10Ydata);
                return HI_FAILURE;
            }
            for (i=0; i<pstFrame->u32Height; i++)
            {
                memcpy(pu10Ydata,ptr,sizeof(HI_U8)*pstFrame->stBufAddr[0].u32Stride_Y);
                VPSS_OSAL_Transfor10bitTobit(pu10Ydata,pu8Ydata,pstFrame->stBufAddr[0].u32Stride_Y,pstFrame->u32Width);
                if(pstFrame->u32Width != VPSS_OSAL_fwrite(pu8Ydata,pstFrame->u32Width, fp))
                {
                    VPSS_FATAL("line %d: fwrite fail!\n",__LINE__);
                }
                ptr += pstFrame->stBufAddr[0].u32Stride_Y;
            }
            
            for (i=0; i<pstFrame->u32Height/2; i++)
            {
                memcpy(pu10UVdata,ptr,pstFrame->stBufAddr[0].u32Stride_C);

                VPSS_OSAL_OneLine10To8Bit(1,pu10UVdata,pstFrame->u32Width, pu8Udata+i*pstFrame->u32Width/2);

                VPSS_OSAL_OneLine10To8Bit(2,pu10UVdata,pstFrame->u32Width, pu8Vdata+i*pstFrame->u32Width/2);

                //VPSS_OSAL_TransforUV10bitTobit(pu10UVdata,&pu8Udata[i*pstFrame->u32Width/2],&pu8Vdata[i*pstFrame->u32Width/2],
                //    pstFrame->stBufAddr[0].u32Stride_C,pstFrame->u32Width,pstFrame->ePixFormat);
                ptr += pstFrame->stBufAddr[0].u32Stride_C;
            }
            VPSS_OSAL_fwrite(pu8Udata, pstFrame->u32Width * pstFrame->u32Height / 2 /2, fp);
            VPSS_OSAL_fwrite(pu8Vdata, pstFrame->u32Width * pstFrame->u32Height / 2 /2, fp);
            VPSS_OSAL_MEMUnmap(pstFrame->bSecure, pstFrame->stBufAddr[0].u32PhyAddr_Y, ptr);
            VPSS_OSAL_fclose(fp);
            VPSS_FATAL("2d image has been saved to '%s' W=%d H=%d Format=%d \n",
                        str,pstFrame->u32Width,pstFrame->u32Height,pstFrame->ePixFormat);
        }
        VPSS_VFREE(pu8Udata);
        VPSS_VFREE(pu8Vdata);
        VPSS_VFREE(pu8Ydata);
        VPSS_VFREE(pu10UVdata);
        VPSS_VFREE(pu10Ydata);
    }
    else if (pstFrame->ePixFormat == HI_DRV_PIX_FMT_NV61_2X1
            || pstFrame->ePixFormat == HI_DRV_PIX_FMT_NV16_2X1)
    {
        pu8Udata = VPSS_VMALLOC(pstFrame->u32Width * pstFrame->u32Height / 2 );
        if (pu8Udata == HI_NULL)
        {
            return HI_FAILURE;
        }

        pu10UVdata = VPSS_VMALLOC(pstFrame->stBufAddr[0].u32Stride_C);
        if (pu10UVdata == HI_NULL)
        {
            VPSS_VFREE(pu8Udata);
            return HI_FAILURE;
        }

        pu8Vdata = VPSS_VMALLOC(pstFrame->u32Width * pstFrame->u32Height / 2 );
        if (pu8Vdata == HI_NULL)
        {
            VPSS_VFREE(pu8Udata);
            VPSS_VFREE(pu10UVdata);
            return HI_FAILURE;
        }
        pu8Ydata = VPSS_VMALLOC(pstFrame->u32Width);
        if (pu8Ydata == HI_NULL)
        {
            VPSS_VFREE(pu8Udata);
            VPSS_VFREE(pu8Vdata);
            VPSS_VFREE(pu10UVdata);
            return HI_FAILURE;
        }
        pu10Ydata = VPSS_VMALLOC(pstFrame->stBufAddr[0].u32Stride_Y);
        if (pu10Ydata == HI_NULL)
        {
            VPSS_VFREE(pu8Udata);
            VPSS_VFREE(pu8Vdata);
            VPSS_VFREE(pu10UVdata);
            VPSS_VFREE(pu8Ydata);
            return HI_FAILURE;
        }
        ptr = VPSS_OSAL_MEMMap(pstFrame->bSecure, pstFrame->stBufAddr[0].u32PhyAddr_Y);
        if (!ptr)
        {
            VPSS_FATAL("address is not valid!\n");
        }
        else
        {
            fp = VPSS_OSAL_fopen(str, O_RDWR | O_CREAT|O_APPEND, 0);
            if (fp == HI_NULL)
            {
                VPSS_FATAL("open file '%s' fail!\n", str);
                VPSS_VFREE(pu8Udata);
                VPSS_VFREE(pu8Vdata);
                VPSS_VFREE(pu8Ydata);
                VPSS_VFREE(pu10UVdata);
                VPSS_VFREE(pu10Ydata);
                return HI_FAILURE;
            }
            for (i=0; i<pstFrame->u32Height; i++)
            {
                memcpy(pu10Ydata,ptr,sizeof(HI_U8)*pstFrame->stBufAddr[0].u32Stride_Y);
                VPSS_OSAL_Transfor10bitTobit(pu10Ydata,pu8Ydata,pstFrame->stBufAddr[0].u32Stride_Y,pstFrame->u32Width);
                if(pstFrame->u32Width != VPSS_OSAL_fwrite(pu8Ydata,pstFrame->u32Width, fp))
                {
                    VPSS_FATAL("line %d: fwrite fail!\n",__LINE__);
                }
                ptr += pstFrame->stBufAddr[0].u32Stride_Y;
            }

            for (i=0; i<pstFrame->u32Height; i++)
            {
                memcpy(pu10UVdata,ptr,pstFrame->stBufAddr[0].u32Stride_C);

                VPSS_OSAL_OneLine10To8Bit(1,pu10UVdata,pstFrame->u32Width, pu8Udata+i*pstFrame->u32Width/2);

                VPSS_OSAL_OneLine10To8Bit(2,pu10UVdata,pstFrame->u32Width, pu8Vdata+i*pstFrame->u32Width/2);

//                VPSS_OSAL_TransforUV10bitTobit(pu10UVdata,&pu8Udata[i*pstFrame->u32Width/2],&pu8Vdata[i*pstFrame->u32Width/2],
   //                 pstFrame->stBufAddr[0].u32Stride_C,pstFrame->u32Width,pstFrame->ePixFormat);
                ptr += pstFrame->stBufAddr[0].u32Stride_C;
            }
            VPSS_OSAL_fwrite(pu8Udata, pstFrame->u32Width * pstFrame->u32Height  /2, fp);
            VPSS_OSAL_fwrite(pu8Vdata, pstFrame->u32Width * pstFrame->u32Height  /2, fp);
            VPSS_OSAL_MEMUnmap(pstFrame->bSecure, pstFrame->stBufAddr[0].u32PhyAddr_Y, ptr);
            VPSS_OSAL_fclose(fp);
            VPSS_FATAL("2d image has been saved to '%s' W=%d H=%d Format=%d \n",
                        str,pstFrame->u32Width,pstFrame->u32Height,pstFrame->ePixFormat);
        }
        VPSS_VFREE(pu8Udata);
        VPSS_VFREE(pu8Vdata);
        VPSS_VFREE(pu8Ydata);
        VPSS_VFREE(pu10UVdata);
        VPSS_VFREE(pu10Ydata);
    }
	else if (pstFrame->ePixFormat == HI_DRV_PIX_FMT_NV21_CMP
				|| pstFrame->ePixFormat == HI_DRV_PIX_FMT_NV12_CMP)
	{
		HI_U8 u8YhFileName[50] = "/mnt/cmp_y.head";
		HI_U8 u8YdFileName[50] = "/mnt/cmp_y.dat";
		HI_U8 u8ChFileName[50] = "/mnt/cmp_c.head";
		HI_U8 u8CdFileName[50] = "/mnt/cmp_c.dat";
		FILE *pfYh;
		FILE *pfYd;
		FILE *pfCh;
		FILE *pfCd;
		HI_U32 u32Y_Stride;
		HI_U32 u32C_Stride;
		HI_U32 u32W;
		HI_U32 u32H;
		HI_U8 *pu8Y_VAddr;
		HI_U8 *pu8C_VAddr;
		HI_U32 u32HeadStride;
		HI_BOOL b8BitWidth;
		HI_U32 u32HeadLenth = 0;
		HI_U8 pu8TmpData[4]={0};
		HI_U8 u8TmpZero = 0;
		HI_U32 i,j;

		u32W = pstFrame->u32Width;
		u32H = pstFrame->u32Height;

		u32Y_Stride = pstFrame->stBufAddr[0].u32Stride_Y;
		u32C_Stride = pstFrame->stBufAddr[0].u32Stride_C;

        pu8Y_VAddr = VPSS_OSAL_MEMMap(pstFrame->bSecure, pstFrame->stBufAddr[0].u32PhyAddr_Y);
        pu8C_VAddr = VPSS_OSAL_MEMMap(pstFrame->bSecure, pstFrame->stBufAddr[0].u32PhyAddr_C);

		b8BitWidth = (pstFrame->enBitWidth == HI_DRV_PIXEL_BITWIDTH_8BIT)?0:1;

		u32HeadStride = (u32W*((b8BitWidth == 0)?8:10))*2/128*16;


		pfYh = VPSS_OSAL_fopen(u8YhFileName, O_RDWR | O_CREAT|O_APPEND, 0644);
		pfYd = VPSS_OSAL_fopen(u8YdFileName, O_RDWR | O_CREAT|O_APPEND, 0644);
		pfCh = VPSS_OSAL_fopen(u8ChFileName, O_RDWR | O_CREAT|O_APPEND, 0644);
		pfCd = VPSS_OSAL_fopen(u8CdFileName, O_RDWR | O_CREAT|O_APPEND, 0644);

		for(j=0; j<u32H; j++, pu8Y_VAddr += u32Y_Stride)
		{
			memcpy(pu8TmpData, pu8Y_VAddr, 2);
			memcpy(&u32HeadLenth, pu8Y_VAddr, 2);

			if(4 !=VPSS_OSAL_fwrite(pu8TmpData, 4,pfYh))
			{
				VPSS_ERROR("error:write %d, %s\n", __LINE__,__FILE__);
				break;
			}

			HI_ASSERT(u32HeadLenth*16<=u32Y_Stride);

			if(u32HeadLenth*16 != VPSS_OSAL_fwrite(pu8Y_VAddr,u32HeadLenth*16, pfYd))
			{
				VPSS_ERROR("error:write %d, %s\n", __LINE__,__FILE__);
				break;
			}

			if(u32HeadStride>u32HeadLenth*16)
			{
				for(i=0; i<(u32HeadStride-u32HeadLenth*16); i++)
				{
					if(1 !=VPSS_OSAL_fwrite(&u8TmpZero, 1, pfYd))
					{
						VPSS_ERROR("error:write %d, %s\n", __LINE__,__FILE__); break;}
				}
			}
		}

		for(j=0; j<u32H/2; j++, pu8C_VAddr+=u32C_Stride)
		{
			memcpy(pu8TmpData,pu8C_VAddr, 2);

			memcpy(&u32HeadLenth,pu8C_VAddr, 2);

			if(4 !=VPSS_OSAL_fwrite(pu8TmpData, 4,pfCh))
			{
				VPSS_ERROR("error:write %d, %s\n", __LINE__,__FILE__);
				break;
			}

			HI_ASSERT(u32HeadLenth*16<=u32C_Stride);

			if(u32HeadLenth*16 !=VPSS_OSAL_fwrite(pu8C_VAddr,u32HeadLenth*16,pfCd))
			{
				VPSS_ERROR("error:write %d, %s\n", __LINE__,__FILE__);
				break;
			}

			if(u32HeadStride>u32HeadLenth*16)
			{
				for(i=0; i<(u32HeadStride-u32HeadLenth*16); i++)
				{
					if(1 !=VPSS_OSAL_fwrite(&u8TmpZero, 1,pfCd))
					{
						VPSS_ERROR("error:write %d, %s\n", __LINE__,__FILE__);
						break;
					}
				}
			}
		}
        VPSS_OSAL_MEMUnmap(pstFrame->bSecure, pstFrame->stBufAddr[0].u32PhyAddr_Y, pu8Y_VAddr);
        VPSS_OSAL_MEMUnmap(pstFrame->bSecure, pstFrame->stBufAddr[0].u32PhyAddr_C, pu8C_VAddr);
	}
    else
    {
        VPSS_FATAL("PixFormat %d can't saveyuv\n",pstFrame->ePixFormat);
    }
    return HI_SUCCESS;
}
HI_S32 VPSS_OSAL_WRITEYUV_8BIT(HI_DRV_VIDEO_FRAME_S *pstFrame,HI_CHAR* pchFile)
{
	char str[50] = {0};
	unsigned char *ptr;
	FILE *fp;
    HI_U8 *pu8Udata;
    HI_U8 *pu8Vdata;
    HI_U8 *pu8Ydata;
    HI_S8  s_VpssSavePath[DEF_FILE_NAMELENGTH];
    HI_U32 i,j;

    HI_DRV_LOG_GetStorePath(s_VpssSavePath, DEF_FILE_NAMELENGTH);

    HI_OSAL_Snprintf(str, 50, "%s/%s", s_VpssSavePath,pchFile);

    if (pstFrame->ePixFormat == HI_DRV_PIX_FMT_NV21
        || pstFrame->ePixFormat == HI_DRV_PIX_FMT_NV12)
    {
        pu8Udata = VPSS_VMALLOC(pstFrame->u32Width * pstFrame->u32Height / 2 /2);
        if (pu8Udata == HI_NULL)
        {
            return HI_FAILURE;
        }
        pu8Vdata = VPSS_VMALLOC(pstFrame->u32Width * pstFrame->u32Height / 2 /2);
        if (pu8Vdata == HI_NULL)
        {
            VPSS_VFREE(pu8Udata);
            return HI_FAILURE;
        }
        pu8Ydata = VPSS_VMALLOC(pstFrame->stBufAddr[0].u32Stride_Y);
        if (pu8Ydata == HI_NULL)
        {
            VPSS_VFREE(pu8Udata);
            VPSS_VFREE(pu8Vdata);
            return HI_FAILURE;
        }

		//MMU virtual addr
		ptr = VPSS_OSAL_MEMMap(pstFrame->bSecure, pstFrame->stBufAddr[0].u32PhyAddr_Y);
        
		if (!ptr)
		{
            VPSS_FATAL("address is not valid!\n");
		}
		else
		{
            fp = VPSS_OSAL_fopen(str, O_RDWR | O_CREAT|O_APPEND, 0644);

            if (fp == HI_NULL)
            {
                VPSS_FATAL("open file '%s' fail!\n", str);
                VPSS_VFREE(pu8Udata);
                VPSS_VFREE(pu8Vdata);
                VPSS_VFREE(pu8Ydata);
                return HI_FAILURE;
            }

            /*write Y data*/
            for (i=0; i<pstFrame->u32Height; i++)
            {
                memcpy(pu8Ydata,ptr,sizeof(HI_U8)*pstFrame->stBufAddr[0].u32Stride_Y);


                if(pstFrame->u32Width > VPSS_OSAL_fwrite(pu8Ydata, pstFrame->stBufAddr[0].u32Stride_Y, fp))
				{
                    VPSS_FATAL("line %d: fwrite fail!\n",__LINE__);
                }
                ptr += pstFrame->stBufAddr[0].u32Stride_Y;
            }

            /*write UV data */
            for (i=0; i<pstFrame->u32Height/2; i++)
            {
                for (j=0; j<pstFrame->u32Width/2; j++)
                {
                    if(pstFrame->ePixFormat == HI_DRV_PIX_FMT_NV21)
                    {
                        pu8Vdata[i*pstFrame->u32Width/2+j] = ptr[2*j];
                        pu8Udata[i*pstFrame->u32Width/2+j] = ptr[2*j+1];
                    }
                    else
                    {
                        pu8Udata[i*pstFrame->u32Width/2+j] = ptr[2*j];
                        pu8Vdata[i*pstFrame->u32Width/2+j] = ptr[2*j+1];
                    }
                }
                ptr += pstFrame->stBufAddr[0].u32Stride_C;
            }
            VPSS_OSAL_fwrite(pu8Udata, pstFrame->u32Width * pstFrame->u32Height / 2 /2, fp);

            VPSS_OSAL_fwrite(pu8Vdata, pstFrame->u32Width * pstFrame->u32Height / 2 /2, fp);


            VPSS_OSAL_fclose(fp);
            VPSS_FATAL("2d image has been saved to '%s' W=%d H=%d Format=%d u32Stride_Y:%d u32Stride_C:%d \n",
                        str,pstFrame->u32Width,pstFrame->u32Height,pstFrame->ePixFormat,
							pstFrame->stBufAddr[0].u32Stride_Y, pstFrame->stBufAddr[0].u32Stride_C);


		}
        
        VPSS_OSAL_MEMUnmap(pstFrame->bSecure, pstFrame->stBufAddr[0].u32PhyAddr_Y, ptr);
        VPSS_VFREE(pu8Udata);
        VPSS_VFREE(pu8Vdata);
        VPSS_VFREE(pu8Ydata);
    }
    else if (pstFrame->ePixFormat == HI_DRV_PIX_FMT_NV21_TILE
            || pstFrame->ePixFormat == HI_DRV_PIX_FMT_NV12_TILE)
    {
		HI_U8 *U_Array = NULL;
		HI_U8 *V_Array = NULL;
		HI_U8 *YUV_Array = NULL;
		HI_U32 i, j;
		HI_S32 len = 0;
		HI_U8 *dst, *src, *tmp;
		HI_U32 Stride =0;
		HI_S8 *Y_Addr = HI_NULL;
		HI_S8 *C_Addr = HI_NULL;
		HI_U32 srcIdx, dstIdx;
		HI_U32 tileX,tileY;
		HI_S32 row_map_table_y[2][4][16] =
		{
			{
				//偶数tile
				//第0列
				{0, 8, 1, 9, 2, 10, 3, 11,	4, 12, 5, 13, 6, 14, 7, 15},
				//第1列
				{12, 0, 13, 1, 14, 2, 15, 3, 8, 4, 9, 5, 10, 6, 11, 7 },
				//第2列
				{4, 12, 5, 13, 6, 14, 7, 15,  0, 8, 1, 9, 2, 10, 3, 11},
				//第3列
				{8, 4, 9, 5, 10, 6, 11, 7,	12, 0, 13, 1, 14, 2, 15, 3}
			},
			{
				//奇数tile			
				{8, 0, 9, 1, 10, 2, 11, 3,	12, 4, 13, 5, 14, 6, 15, 7},
				{0, 12, 1, 13, 2, 14, 3, 15,  4, 8, 5, 9, 6, 10, 7, 11},
				{12, 4, 13, 5, 14, 6, 15, 7,  8, 0, 9, 1, 10, 2, 11, 3},
				{4, 8, 5, 9, 6, 10, 7, 11,	0, 12, 1, 13, 2, 14, 3, 15}
			}
		};
		
		HI_S32 row_map_table_uv[2][4][8] =
		{
			{
				//偶数tile
				{0, 4, 1, 5,  2, 6, 3, 7},
				{4, 0, 5, 1,  6, 2, 7, 3},
				{4, 0, 5, 1,  6, 2, 7, 3},
				{0, 4, 1, 5,  2, 6, 3, 7},
			},
			{
				//奇数tile
				{4, 0, 5, 1,  6, 2, 7, 3},
				{0, 4, 1, 5,  2, 6, 3, 7},
				{0, 4, 1, 5,  2, 6, 3, 7},
				{4, 0, 5, 1,  6, 2, 7, 3}
			}
		};

		Y_Addr = VPSS_OSAL_MEMMap(pstFrame->bSecure,
            pstFrame->stBufAddr[0].u32PhyAddr_Y);
		C_Addr = VPSS_OSAL_MEMMap(pstFrame->bSecure,
            pstFrame->stBufAddr[0].u32PhyAddr_C);

        if(HI_NULL == YUV_Array)
        {
            YUV_Array = VPSS_VMALLOC(pstFrame->u32Width * pstFrame->u32Height * 3/2);
            if (HI_NULL == YUV_Array)
            {                  
				VPSS_FATAL("VPSS_VMALLOC fail!\n");				
				return HI_FAILURE;
            }

            U_Array = YUV_Array + pstFrame->u32Width * pstFrame->u32Height;
            V_Array = U_Array + pstFrame->u32Width * pstFrame->u32Height/4;
        }

		VPSS_FATAL("VPSS_VMALLOC success!\n");
		
		fp = VPSS_OSAL_fopen(str, O_RDWR | O_CREAT|O_APPEND, 0644);
		
		if (fp == HI_NULL)
		{
			VPSS_FATAL("open file '%s' fail!\n", str);
			VPSS_VFREE(YUV_Array);
			return HI_FAILURE;
		}		

		VPSS_FATAL("VPSS_OSAL_fopen %s success!\n", str);

        Stride = pstFrame->stBufAddr[0].u32Stride_Y * 16;

        /*Y*/
    	for(i=0;i<pstFrame->u32Height;i++)
        {
            for(j=0;j<pstFrame->u32Width;j+=64)
            {
                dst  = (unsigned char*)(YUV_Array+ pstFrame->u32Width*i + j);
                tileY = (i/16)%2;
             tileX = (j/64)%4;
             srcIdx = i%16;
             dstIdx = row_map_table_y[tileY][tileX][srcIdx];
             src =  Y_Addr + Stride*(i/16) + dstIdx*64 + (j/64)*64*16;
                memcpy(dst,src,64);
            }
        }

		VPSS_FATAL("memcpy Y success!\n");
		len = VPSS_OSAL_fwrite(YUV_Array, pstFrame->u32Width*pstFrame->u32Height, fp);
        if(len != pstFrame->u32Width*pstFrame->u32Height)
        {
            VPSS_FATAL("%s write Y failed.len : %d,W*H :%d\n", __func__,len,pstFrame->u32Width*pstFrame->u32Height);
            {
				VPSS_VFREE(YUV_Array);
                return HI_FAILURE;
            }
        }

		VPSS_FATAL("VPSS_OSAL_fwrite Y success!\n");

        /*UV*/
     	for(i=0;i<pstFrame->u32Height/2;i++)
        {
            for(j=0;j<pstFrame->u32Width;j+=64)
            {
               dst  = (unsigned char*)(YUV_Array + pstFrame->u32Width*i + j);
	    	 tileY = (i/8)%2;
            tileX = (j/64)%4;
            srcIdx = i%8;
            dstIdx = row_map_table_uv[tileY][tileX][srcIdx];
            src =  C_Addr + (Stride/2)*(i/8) + dstIdx*64 + (j/64)*64*8;
            memcpy(dst,src,64);
            }
        }

		VPSS_FATAL("memcpy UV success!\n");
        tmp = YUV_Array;
        {
            for (i=0;i<pstFrame->u32Height/2;i++)
            {
                for (j=0;j<pstFrame->u32Width/2;j++)
                {
                    V_Array[i*pstFrame->u32Width/2+j] = tmp[2*j];
                    U_Array[i*pstFrame->u32Width/2+j] = tmp[2*j+1];
                }
                tmp+= pstFrame->u32Width;
            }
        }

		len = VPSS_OSAL_fwrite(U_Array, pstFrame->u32Width*pstFrame->u32Height/4, fp);
        if(len != pstFrame->u32Width*pstFrame->u32Height/4)
        {
            VPSS_FATAL("%s write U failed.len : %d,W*H :%d\n", __func__,len,pstFrame->u32Width*pstFrame->u32Height/4);
            {
				VPSS_VFREE(YUV_Array);
                return HI_FAILURE;
            }
        }

		VPSS_FATAL("VPSS_OSAL_fwrite U success!\n");

		len = VPSS_OSAL_fwrite(V_Array, pstFrame->u32Width*pstFrame->u32Height/4, fp);
        if(len != pstFrame->u32Width*pstFrame->u32Height/4)
        {
            VPSS_FATAL("%s write V failed.len : %d,W*H :%d\n", __func__,len,pstFrame->u32Width*pstFrame->u32Height/4);
            {
           		VPSS_VFREE(YUV_Array);
                return HI_FAILURE;
            }
        }

		VPSS_FATAL("VPSS_OSAL_fwrite V success!\n");

        VPSS_FATAL("Saving YUV(%dx%d)...\n", pstFrame->u32Width, pstFrame->u32Height);
        VPSS_OSAL_MEMUnmap(pstFrame->bSecure, pstFrame->stBufAddr[0].u32PhyAddr_Y, Y_Addr);
        VPSS_OSAL_MEMUnmap(pstFrame->bSecure, pstFrame->stBufAddr[0].u32PhyAddr_C, C_Addr);
        VPSS_OSAL_fclose(fp);

	}
	else if (pstFrame->ePixFormat == HI_DRV_PIX_FMT_NV61_2X1
            || pstFrame->ePixFormat == HI_DRV_PIX_FMT_NV16_2X1)
    {
        pu8Udata = VPSS_VMALLOC(pstFrame->u32Width * pstFrame->u32Height / 2 );
        if (pu8Udata == HI_NULL)
        {
            return HI_FAILURE;
        }
        pu8Vdata = VPSS_VMALLOC(pstFrame->u32Width * pstFrame->u32Height / 2 );
        if (pu8Vdata == HI_NULL)
        {
            VPSS_VFREE(pu8Udata);
            return HI_FAILURE;
        }
        pu8Ydata = VPSS_VMALLOC(pstFrame->stBufAddr[0].u32Stride_Y);
        if (pu8Ydata == HI_NULL)
        {
            VPSS_VFREE(pu8Udata);
            VPSS_VFREE(pu8Vdata);
            return HI_FAILURE;
        }

        ptr = VPSS_OSAL_MEMMap(pstFrame->bSecure,
            pstFrame->stBufAddr[0].u32PhyAddr_Y);

		if (!ptr)
		{
            VPSS_FATAL("address is not valid!\n");
		}
		else
		{

            fp = VPSS_OSAL_fopen(str, O_RDWR | O_CREAT|O_APPEND, 0644);

            if (fp == HI_NULL)
            {
                VPSS_FATAL("open file '%s' fail!\n", str);
                VPSS_VFREE(pu8Udata);
                VPSS_VFREE(pu8Vdata);
                VPSS_VFREE(pu8Ydata);
                return HI_FAILURE;
            }

            /*write Y data*/
            for (i=0; i<pstFrame->u32Height; i++)
            {
                memcpy(pu8Ydata,ptr,sizeof(HI_U8)*pstFrame->stBufAddr[0].u32Stride_Y);

                if(pstFrame->u32Width != VPSS_OSAL_fwrite(pu8Ydata,pstFrame->u32Width, fp))
				{
                    VPSS_FATAL("line %d: fwrite fail!\n",__LINE__);
                }
                ptr += pstFrame->stBufAddr[0].u32Stride_Y;
            }

            /*write UV data */
            for (i=0; i<pstFrame->u32Height; i++)
            {
                for (j=0; j<pstFrame->u32Width/2; j++)
                {
                    if(pstFrame->ePixFormat == HI_DRV_PIX_FMT_NV61_2X1)
                    {
                        pu8Vdata[i*pstFrame->u32Width/2+j] = ptr[2*j];
                        pu8Udata[i*pstFrame->u32Width/2+j] = ptr[2*j+1];
                    }
                    else
                    {
                        pu8Udata[i*pstFrame->u32Width/2+j] = ptr[2*j];
                        pu8Vdata[i*pstFrame->u32Width/2+j] = ptr[2*j+1];
                    }
                }
                ptr += pstFrame->stBufAddr[0].u32Stride_C;
            }
            VPSS_OSAL_fwrite(pu8Udata, pstFrame->u32Width * pstFrame->u32Height  /2, fp);

            VPSS_OSAL_fwrite(pu8Vdata, pstFrame->u32Width * pstFrame->u32Height  /2, fp);

            VPSS_OSAL_MEMUnmap(pstFrame->bSecure, pstFrame->stBufAddr[0].u32PhyAddr_Y, ptr);
            VPSS_OSAL_fclose(fp);
            VPSS_FATAL("2d image has been saved to '%s' W=%d H=%d Format=%d \n",
                        str,pstFrame->u32Width,pstFrame->u32Height,pstFrame->ePixFormat);

		}
        VPSS_VFREE(pu8Udata);
        VPSS_VFREE(pu8Vdata);
        VPSS_VFREE(pu8Ydata);
    }
	else if (pstFrame->ePixFormat == HI_DRV_PIX_FMT_NV21_CMP
			|| pstFrame->ePixFormat == HI_DRV_PIX_FMT_NV12_CMP)
	{
		HI_U8 u8YhFileName[] = "/mnt/cmp_y.head";
		HI_U8 u8YdFileName[] = "/mnt/cmp_y.dat";
		HI_U8 u8ChFileName[] = "/mnt/cmp_c.head";
		HI_U8 u8CdFileName[] = "/mnt/cmp_c.dat";
		FILE *pfYh;
		FILE *pfYd;
		FILE *pfCh;
		FILE *pfCd;
		HI_U32 u32Y_Stride;
		HI_U32 u32C_Stride;
		HI_U32 u32W;
		HI_U32 u32H;
		HI_U8 *pu8Y_VAddr;
		HI_U8 *pu8C_VAddr;
		HI_U32 u32HeadStride;
		HI_BOOL b8BitWidth;
		HI_U32 u32HeadLenth = 0;
		HI_U8 pu8TmpData[4]={0};
		HI_U8 u8TmpZero = 0;

		u32W = pstFrame->u32Width;
		u32H = pstFrame->u32Height;

		u32Y_Stride = pstFrame->stBufAddr[0].u32Stride_Y;
		u32C_Stride = pstFrame->stBufAddr[0].u32Stride_C;

		pu8Y_VAddr = VPSS_OSAL_MEMMap(pstFrame->bSecure,
            pstFrame->stBufAddr[0].u32PhyAddr_Y);
		pu8C_VAddr = VPSS_OSAL_MEMMap(pstFrame->bSecure,
            pstFrame->stBufAddr[0].u32PhyAddr_C);
		b8BitWidth = (pstFrame->enBitWidth == HI_DRV_PIXEL_BITWIDTH_8BIT)?0:1;

		u32HeadStride = (u32W*((b8BitWidth == 0)?8:10))*2/128*16;


		pfYh = VPSS_OSAL_fopen(u8YhFileName, O_RDWR | O_CREAT|O_APPEND, 0644);
		pfYd = VPSS_OSAL_fopen(u8YdFileName, O_RDWR | O_CREAT|O_APPEND, 0644);
		pfCh = VPSS_OSAL_fopen(u8ChFileName, O_RDWR | O_CREAT|O_APPEND, 0644);
		pfCd = VPSS_OSAL_fopen(u8CdFileName, O_RDWR | O_CREAT|O_APPEND, 0644);

		for(j=0; j<u32H; j++, pu8Y_VAddr += u32Y_Stride)
		{
			memcpy(pu8TmpData, pu8Y_VAddr, 2);
			memcpy(&u32HeadLenth, pu8Y_VAddr, 2);

			if(4 !=VPSS_OSAL_fwrite(pu8TmpData, 4,pfYh))
			{
				VPSS_ERROR("error:write %d, %s\n", __LINE__,__FILE__);
				break;
			}

			HI_ASSERT(u32HeadLenth*16<=u32Y_Stride);

			if(u32HeadLenth*16 != VPSS_OSAL_fwrite(pu8Y_VAddr,u32HeadLenth*16, pfYd))
			{
				VPSS_ERROR("error:write %d, %s\n", __LINE__,__FILE__);
				break;
			}

			if(u32HeadStride>u32HeadLenth*16)
			{
				for(i=0; i<(u32HeadStride-u32HeadLenth*16); i++)
				{
					if(1 !=VPSS_OSAL_fwrite(&u8TmpZero, 1, pfYd))
					{
						VPSS_ERROR("error:write %d, %s\n", __LINE__,__FILE__); break;}
				}
			}
		}

		for(j=0; j<u32H/2; j++, pu8C_VAddr+=u32C_Stride)
		{
			memcpy(pu8TmpData,pu8C_VAddr, 2);

			memcpy(&u32HeadLenth,pu8C_VAddr, 2);

			if(4 !=VPSS_OSAL_fwrite(pu8TmpData, 4,pfCh))
			{
				VPSS_ERROR("error:write %d, %s\n", __LINE__,__FILE__);
				break;
			}

			HI_ASSERT(u32HeadLenth*16<=u32C_Stride);

			if(u32HeadLenth*16 !=VPSS_OSAL_fwrite(pu8C_VAddr,u32HeadLenth*16,pfCd))
			{
				VPSS_ERROR("error:write %d, %s\n", __LINE__,__FILE__);
				break;
			}

			if(u32HeadStride>u32HeadLenth*16)
			{
				for(i=0; i<(u32HeadStride-u32HeadLenth*16); i++)
				{
					if(1 !=VPSS_OSAL_fwrite(&u8TmpZero, 1,pfCd))
					{
						VPSS_ERROR("error:write %d, %s\n", __LINE__,__FILE__);
						break;
					}
				}
			}
		}
        VPSS_OSAL_MEMUnmap(pstFrame->bSecure, pstFrame->stBufAddr[0].u32PhyAddr_Y, pu8Y_VAddr);
        VPSS_OSAL_MEMUnmap(pstFrame->bSecure, pstFrame->stBufAddr[0].u32PhyAddr_C, pu8C_VAddr);

	}
    else
    {
        VPSS_FATAL("PixFormat %d can't saveyuv\n",pstFrame->ePixFormat);
    }

    return HI_SUCCESS;
}
HI_S32 VPSS_OSAL_WRITEYUV(HI_DRV_VIDEO_FRAME_S *pstFrame,HI_CHAR* pchFile)
{
    if(HI_DRV_PIXEL_BITWIDTH_8BIT == pstFrame->enBitWidth)
    {
        return VPSS_OSAL_WRITEYUV_8BIT(pstFrame,pchFile);
    }
    else
    if(HI_DRV_PIXEL_BITWIDTH_10BIT == pstFrame->enBitWidth)
    {
        return VPSS_OSAL_WRITEYUV_10BIT(pstFrame,pchFile);
    }
    else
    {
        return HI_FAILURE;
    }
}
HI_S32 VPSS_OSAL_CalBufSize(HI_U32 *pSize,HI_U32 *pStride,HI_U32 u32Height,HI_U32 u32Width,HI_DRV_PIX_FORMAT_E ePixFormat,HI_DRV_PIXEL_BITWIDTH_E  enOutBitWidth)
{
    HI_U32 u32RetSize = 0;
    HI_U32 u32RetStride = 0;

    //:TODO:默认按10bit紧凑分配
    switch (ePixFormat)
    {
        case HI_DRV_PIX_FMT_NV12:
        case HI_DRV_PIX_FMT_NV21:
            if(HI_DRV_PIXEL_BITWIDTH_8BIT == enOutBitWidth)
            {
                u32RetStride = (u32Width + 0xF) & 0xFFFFFFF0;
            }
            else
            {
                u32RetStride = HI_ALIGN_10BIT_COMP_YSTRIDE(u32Width);
            }
            u32RetSize = u32Height * u32RetStride*3/2;
            break;
        case HI_DRV_PIX_FMT_NV16_2X1:
        case HI_DRV_PIX_FMT_NV61_2X1:
            if(HI_DRV_PIXEL_BITWIDTH_8BIT == enOutBitWidth)
            {
                u32RetStride = HI_ALIGN_8BIT_YSTRIDE(u32Width);
            }
            else
            {
                u32RetStride = HI_ALIGN_10BIT_COMP_YSTRIDE(u32Width);
            }
            u32RetSize = u32Height * u32RetStride*2;
            break;
        case HI_DRV_PIX_FMT_NV12_CMP:
        case HI_DRV_PIX_FMT_NV21_CMP:
			{
			#if defined(CHIP_TYPE_hifone) || defined(CHIP_TYPE_hi3716mv410)|| defined(CHIP_TYPE_hi3716mv420)
				HI_U32 u32tempt = 0;
				u32tempt = u32Width * ( (HI_DRV_PIXEL_BITWIDTH_10BIT == enOutBitWidth)? 10 : 8);
				if ( u32Width <= 3584)
				{
					u32RetStride = 16 + (u32tempt+127)/128 * 16;
				}
				else if( 3584 < u32Width && u32Width <= 7680)
				{
					u32RetStride = 2*16 + (u32tempt+127)/128 * 16;
				}
				else
				{
					u32RetStride = 3*16 + (u32tempt+127)/128 * 16;
				}

			#else
				if(HI_DRV_PIXEL_BITWIDTH_8BIT == enOutBitWidth)
				{
					u32RetStride = HI_ALIGN_8BIT_YSTRIDE(u32Width);
				}
				else
				{
					u32RetStride = HI_ALIGN_10BIT_COMP_YSTRIDE(u32Width);
				}
			#endif
			}
            u32RetSize = u32Height * u32RetStride*3/2 + 16 * u32Height*3/2;
            break;
        case HI_DRV_PIX_FMT_NV16_CMP:
        case HI_DRV_PIX_FMT_NV61_CMP:
            if(HI_DRV_PIXEL_BITWIDTH_8BIT == enOutBitWidth)
            {
                u32RetStride = HI_ALIGN_8BIT_YSTRIDE(u32Width);
            }
            else
            {
                u32RetStride = HI_ALIGN_10BIT_COMP_YSTRIDE(u32Width);
            }
            u32RetSize = u32Height * u32RetStride*3/2 + 16 * u32Height*2;
            break;
        case HI_DRV_PIX_FMT_ARGB8888:
        case HI_DRV_PIX_FMT_ABGR8888:
            u32RetStride = HI_ALIGN_8BIT_YSTRIDE(u32Width*4);
            u32RetSize = u32Height * u32RetStride;
            break;
        default:
            VPSS_FATAL("Unsupport PixFormat %d.\n",ePixFormat);
            return HI_FAILURE;
    }

    *pSize = u32RetSize;
    *pStride = u32RetStride;
    return HI_SUCCESS;
}


HI_S32 VPSS_OSAL_GetVpssVersion(VPSS_VERSION_E *penVersion, VPSS_CAPABILITY_U *penCapability)
{
    HI_CHIP_TYPE_E enChipType;
    HI_CHIP_VERSION_E enChipVersion;

    VPSS_CHECK_NULL(penVersion);

    HI_DRV_SYS_GetChipVersion(&enChipType, &enChipVersion);

	penCapability->u32 = 0; //should be initialized

	if (enChipType == HI_CHIP_TYPE_HI3798C
			&& (enChipVersion == HI_CHIP_VERSION_V200))
	{
		*penVersion = VPSS_VERSION_V4_0;
	}
	else if (enChipType == HI_CHIP_TYPE_HI3716M
			&& (enChipVersion == HI_CHIP_VERSION_V410 || enChipVersion == HI_CHIP_VERSION_V420))
	{
		*penVersion = VPSS_VERSION_V3_0;
		penCapability->bits.hi3716mv410 = HI_TRUE;
	}
	else if (enChipType == HI_CHIP_TYPE_HI3798C)
    {
        *penVersion = VPSS_VERSION_V2_0;
    }
    else if (enChipType == HI_CHIP_TYPE_HI3716C)
    {
        *penVersion = VPSS_VERSION_BUTT;
    }
    else if (enChipType == HI_CHIP_TYPE_HI3798M_A || enChipType == HI_CHIP_TYPE_HI3796M ||
			 enChipType == HI_CHIP_TYPE_HI3798M )
    {
        *penVersion = VPSS_VERSION_V1_0;
		penCapability->bits.hi3798mv100 = HI_TRUE;
    }
    else if (enChipType == HI_CHIP_TYPE_HI3798C_A && enChipVersion == HI_CHIP_VERSION_V200)
    {
        *penVersion = VPSS_VERSION_V1_0;
		penCapability->bits.hi3798cv200_a = HI_TRUE;
    }
    else
    {
        *penVersion = VPSS_VERSION_BUTT;
		penCapability->u32 = 0;
    }

    return HI_SUCCESS;
}

HI_S32 VPSS_OSAL_GetTileOffsetAddr(HI_U32 u32Xoffset,HI_U32 u32Yoffset,
                                   HI_U32 *pu32Yaddr,HI_U32 *pu32Caddr,
                                   HI_DRV_VID_FRAME_ADDR_S *pstOriAddr)
{
    HI_U32 tile_pix_pos,tile_y_stride,tile_c_stride;
    HI_U32 u32Y_Stride,u32Y_Addr;
    HI_U32 u32C_Stride,u32C_Addr;
    HI_U32 u32C_StartAddr;
    HI_U32 u32Y_StartAddr;

    u32Y_Addr = pstOriAddr->u32PhyAddr_Y;
    u32Y_Stride = pstOriAddr->u32Stride_Y;

    tile_pix_pos = (((u32Xoffset)/256)==(u32Y_Stride/256));
    tile_y_stride = (tile_pix_pos==1)?(((u32Y_Stride%256)==0)?256:(u32Y_Stride%256)):256;
    u32Y_StartAddr =u32Y_Addr+((u32Yoffset)/16)*u32Y_Stride*16+((u32Xoffset)/256)*256*16+((u32Yoffset)%16)*tile_y_stride+(u32Xoffset)%256;

    u32C_Addr = pstOriAddr->u32PhyAddr_C;
    u32C_Stride = pstOriAddr->u32Stride_C;

    tile_pix_pos = (((u32Xoffset)/256)==(u32C_Stride/256));
    tile_c_stride = (tile_pix_pos==1)?(((u32C_Stride%256)==0)?256:(u32C_Stride%256)):256;
    u32C_StartAddr =u32C_Addr+((u32Yoffset/2)/8)*u32C_Stride*8+((u32Xoffset)/256)*256*8+((u32Yoffset/2)%8)*tile_c_stride+(u32Xoffset)%256;

    *pu32Yaddr = u32Y_StartAddr;
    *pu32Caddr = u32C_StartAddr;

    return HI_SUCCESS;
}
HI_S32 VPSS_OSAL_GetCurTime(HI_U32 *pu32Hour,HI_U32 *pu32Minute,
                                   HI_U32 *pu32Second)
{
    struct tm now;

    time_to_tm(get_seconds(), 0, &now);

    *pu32Hour = now.tm_hour;
    *pu32Minute = now.tm_min;
    *pu32Second = now.tm_sec;

    return HI_SUCCESS;
}

HI_S32 VPSS_OSAL_GetSysMemSize(HI_U32 *pu32MemSize)
{
    HI_S32 s32Ret;
    HI_U32 u32Mem = 0;
    HI_SYS_MEM_CONFIG_S stConfig;

    s32Ret = HI_DRV_SYS_GetMemConfig(&stConfig);

    if (HI_SUCCESS == s32Ret)
    {
        u32Mem = stConfig.u32TotalSize;
    }
    else
    {
        u32Mem = 0;
    }

    *pu32MemSize = u32Mem;

    return s32Ret;
}

HI_S32 VPSS_OSAL_AllocateMem(HI_U8 u8flag,
		HI_U32  u32Size,
		HI_U8  *pu8ZoneName,
		HI_U8  *pu8MemName,
		VPSS_MEM_S *pstMem)
{
	HI_S32 s32Ret = HI_SUCCESS;

	if (u8flag == VPSS_MEM_FLAG_NORMAL)
	{
#ifdef HI_VPSS_SMMU_SUPPORT
        SMMU_BUFFER_S stMMU;

        s32Ret = HI_DRV_SMMU_Alloc( pu8MemName,
				u32Size, 0, &stMMU);
		if (s32Ret == HI_SUCCESS)
		{
			pstMem->u32Size = stMMU.u32Size;
			pstMem->u32StartPhyAddr = stMMU.u32StartSmmuAddr;
			pstMem->pu8StartVirAddr = stMMU.pu8StartVirAddr;

			pstMem->u8flag = u8flag;
		}
#else
        MMZ_BUFFER_S stMMZ;

        s32Ret = HI_DRV_MMZ_Alloc( pu8MemName, HI_NULL,
				u32Size, 0, &stMMZ);
		if (s32Ret == HI_SUCCESS)
		{
			pstMem->u32Size = stMMZ.u32Size;
			pstMem->u32StartPhyAddr = stMMZ.u32StartPhyAddr;
			pstMem->pu8StartVirAddr = stMMZ.pu8StartVirAddr;

			pstMem->u8flag = u8flag;
		}
#endif
	}
	else if (u8flag == VPSS_MEM_FLAG_SECURE)
	{
#ifdef HI_TEE_SUPPORT
       
        s32Ret = HI_DRV_SECSMMU_Alloc(pu8MemName, u32Size,16, &pstMem->stTeeMem);
		if (s32Ret == HI_SUCCESS)
		{
			pstMem->u32Size = u32Size;
			pstMem->u32StartPhyAddr = pstMem->stTeeMem.u32StartSmmuAddr;
			pstMem->pu8StartVirAddr = HI_NULL;
			pstMem->u8flag = u8flag;
		}
		else
		{
			VPSS_ERROR("alloc secure buffer failed\n");
		}
#else
        MMZ_BUFFER_S stMMZ;

        s32Ret = HI_DRV_MMZ_Alloc( pu8MemName, HI_NULL,
				u32Size, 0, &stMMZ);
		if (s32Ret == HI_SUCCESS)
		{
			pstMem->u32Size = stMMZ.u32Size;
			pstMem->u32StartPhyAddr = stMMZ.u32StartPhyAddr;

			pstMem->pu8StartVirAddr = stMMZ.pu8StartVirAddr;

			pstMem->u8flag = u8flag;
		}
#endif
	}
	else
	{

	}
	return s32Ret;
}

HI_S32 VPSS_OSAL_FreeMem(VPSS_MEM_S *pstMem)
{
	HI_S32 s32Ret = HI_SUCCESS;

	if (pstMem->u8flag == VPSS_MEM_FLAG_NORMAL)
	{
#ifdef HI_VPSS_SMMU_SUPPORT
        SMMU_BUFFER_S stMMU;

        stMMU.u32StartSmmuAddr = pstMem->u32StartPhyAddr;
		stMMU.pu8StartVirAddr = pstMem->pu8StartVirAddr;
		stMMU.u32Size = pstMem->u32Size;

		HI_DRV_SMMU_Release(&stMMU);
#else
        MMZ_BUFFER_S stMMZ;

        stMMZ.u32StartPhyAddr = pstMem->u32StartPhyAddr;
		stMMZ.pu8StartVirAddr = pstMem->pu8StartVirAddr;
		stMMZ.u32Size = pstMem->u32Size;

		HI_DRV_MMZ_Release(&stMMZ);
#endif
	}
	else if (pstMem->u8flag == VPSS_MEM_FLAG_SECURE)
	{
#ifdef HI_TEE_SUPPORT
		(HI_VOID)HI_DRV_SECSMMU_Release(&pstMem->stTeeMem);
#else
        MMZ_BUFFER_S stMMZ;

        stMMZ.u32StartPhyAddr = pstMem->u32StartPhyAddr;
		stMMZ.pu8StartVirAddr = pstMem->pu8StartVirAddr;
		stMMZ.u32Size = pstMem->u32Size;

		HI_DRV_MMZ_Release(&stMMZ);
#endif
	}
	else
	{
	}

	return s32Ret;
}

#ifdef __cplusplus
 #if __cplusplus
}
 #endif
#endif /* __cplusplus */
