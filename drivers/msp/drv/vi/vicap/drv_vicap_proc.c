/***********************************************************************************
*              Copyright 2004 - 2050, Hisilicon Tech. Co., Ltd.
*                           ALL RIGHTS RESERVED
* FileName   :  drv_vicap_proc.c
* Description:
*
***********************************************************************************/
#include "hi_drv_proc.h"
#include <asm/uaccess.h>
#include "drv_vicap.h"

static HI_VOID VICAP_DRV_ProcHelp(HI_VOID)
{
    HI_DRV_PROC_EchoHelper("------------------Vicap Debug Option----------------\n");
    HI_DRV_PROC_EchoHelper("echo help   > /proc/msp/vicapXXXX(e.g.£¬vicap0/vicap1)\n");
}

HI_S32 VICAP_DRV_ParseProcPara(HI_CHAR *pProcPara,HI_CHAR **ppArg1,HI_CHAR **ppArg2)
{
    HI_CHAR *pChar = HI_NULL;

    if (strlen(pProcPara) == 0)
    {
        /* not fined arg1 and arg2, return failed */
        *ppArg1  = HI_NULL;
        *ppArg2  = HI_NULL;        
        return HI_FAILURE;
    }

    /* find arg1 */
    pChar = pProcPara;
    while( (*pChar == ' ') && (*pChar != '\0') )
    {
        pChar++;
    }
   
    if (*pChar != '\0')
    {
        *ppArg1 = pChar;
    }
    else
    {
        *ppArg1  = HI_NULL;
        
        return HI_FAILURE;
    }

    /* ignor arg1 */
    while( (*pChar != ' ') && (*pChar != '\0') )
    {
        pChar++;
    }

    /* Not find arg2, return */
    if (*pChar == '\0')
    {
        *ppArg2 = HI_NULL;
        
        return HI_SUCCESS;
    }

    /* add '\0' for arg1 */
    *pChar = '\0';

    /* start to find arg2 */
    pChar = pChar + 1;
    while( (*pChar == ' ') && (*pChar != '\0') )
    {
        pChar++;
    }

    if (*pChar != '\0')
    {
        *ppArg2 = pChar;
    }
    else
    {
        *ppArg2 = HI_NULL;
    }

    return HI_SUCCESS;
}

static HI_S32 VICAP_DRV_ProcRead(struct seq_file *s, HI_VOID *pData)
{  
    HI_U32 i;
    DRV_PROC_ITEM_S *pProcItem;
    HI_U32 u32VicapContextId;    
    HI_HANDLE hVicap;
    VICAP_DRV_CTX_S *pstVicapDrvCtx = HI_NULL;
    HI_DRV_VICAP_ATTR_S *pstDrvVicapAttr = HI_NULL;
    HI_DRV_VICAP_OUTPUT_ATTR_S  *pstOutAttr = HI_NULL;
    VICAP_FRAME_STATUS_S        *pstFrmStatus = HI_NULL;
    VICAP_CHN_DBG_INFO_S        *pstChnDbg = HI_NULL;
    VICAP_BUF_MGR_S             *pstBufMgr = HI_NULL;

    static HI_CHAR sVicapStatus[][20] =
    {
        {"Stop"}, {"Start"}, {"Stopping"}, 
    };

    static HI_CHAR sVicapType[][20] =
    {
        {"Main"}, {"Sub"}, {"Virtual"}, 
    };

    static HI_CHAR sVicapAccess[][20] =
    {
        {"TVD"}, {"HDDEC"}, {"HDMI"}, {"EXTERN"},
    };

    static HI_CHAR sVicap3dFmt[][20] =
    {
        {"2D"}, {"SBS"}, {"TB"}, {"FP"},
    };
    
    static HI_CHAR sVicapIntf[][20] =
    {
        {"FVHDE"}, {"BT601"}, {"BT656"}, {"BT1120"},
    };
    
    static HI_CHAR sVicapCSpace[][20] =
    {
        {"UNKNOWN"}, {"DEFAULT"}, {"BT601_YUV_L"}, {"BT601_YUV_F"},
        {"BT601_RGB_L"},{"BT601_RGB_F"},{"NTSC1953"},{"BT470_SYSTEM_M"},
        {"BT470_SYSTEM_BG"},{"BT709_YUV_L"},{"BT709_YUV_F"},{"BT709_RGB_L"},
        {"BT709_RGB_F"},{"REC709"},{"SMPT170M"},{"SMPT170M"},{"SMPT240M"},
        {"BT878"},{"XVYCC"},{"JPEG"},{"RGB"},  
    };
    
    static HI_CHAR sVicapPixFmt[][20] =
    {
        {"RGB332"}, {"RGB444"}, {"RGB555"}, {"RGB565"},{"BGR565"}, {"RGB555X "},
        {"RGB565X"}, {"BGR666"}, {"BGR24"}, {"RGB24"},{"BGR32"}, {"RGB32"},
        {"CLUT_1BPP"}, {"CLUT_2BPP"}, {"CLUT_4BPP"}, {"CLUT_8BPP"},{"ACLUT_44"}, {"ACLUT_88"},
        {"ARGB4444"}, {"ABGR4444"}, {"RGBA4444"}, {"ARGB1555"},{"ABGR1555"}, {"RGBA5551"},
        {"ARGB8565"}, {"ABGR8565"}, {"RGBA5658"}, {"ARGB6666"},{"RGBA6666"}, {"ARGB8888"},
        {"ABGR8888"}, {"RGBA8888"}, {"AYUV8888"}, {"YUVA8888"},{"GREY"}, {"Y4"},
        {"Y6"}, {"Y10"}, {"Y12"}, {"Y16"},{"Y10BPACK"}, {"PAL8"},
        {"YVU410"}, {"YVU420"}, {"YUYV"}, {"YYUV"},{"YVYU"}, {"UYVY"},
        {"VYUY"}, {"YUV422P"}, {"YUV411P"}, {"Y41P"},{"YUV444"}, {"YUV555"},
        {"YUV565"}, {"YUV32"}, {"YUV410"}, {"YUV420"},{"HI240"}, {"HM12"},
        {"M420"}, {"NV08"},{"NV80"}, {"NV12"},{"NV21"}, {"NV12_411"},  
        {"NV16"}, {"NV61"},{"NV16_2X1"}, {"YUV422"}, {"NV24"},{"YUV444"}, {"NV42_RGB"},
        {"NV12M"}, {"NV12MT"}, {"YUV420M"}, {"SBGGR8"},{"SGBRG8"}, {"SGRBG8"},
        {"SRGGB8"}, {"SBGGR10"}, {"SGBRG10"}, {"SGRBG10"},{"SRGGB10"}, {"SBGGR12"},
        {"SGBRG12"}, {"SGRBG12"}, {"SRGGB12"}, {"NV08_CMP"},{"NV80_CMP"}, {"NV12_CMP"},
        {"NV21_CMP"}, {"NV16_CMP"}, {"NV61_CMP"}, {"NV16_2X1_CMP"},{"NV61_2X1_CMP"}, {"NV24_CMP"},
        {"NV42_CMP"}, {"NV12_TILE"}, {"NV21_TILE"}, {"YUV400_TILE"},{"NV12_TILE_CMP"}, {"FMT_NV21_TILE_CMP"},
        {"YUV400 "}, {"YUV410p"}, {"YUV420p"}, {"YUV411"},{"YUV422_1X2"}, {"YUV422_2X1"},
        {"YUV_444"},
    };

    static HI_CHAR sVicapBitWidth[][20] =
    {
        {"8Bit"}, {"10Bit"}, {"12Bit"},
    };

    static HI_CHAR sVicapOverSmp[][20] =
    {
        {"1X"}, {"2X"}, {"4X"},
    };

    static HI_CHAR sVicapSrcType[][20] =
    {
        {"DTV"}, {"USB"}, {"ATV"}, {"SCART"}, {"SVIDEO"}, 
        {"CVBS"}, {"VGA"}, {"YPBPR"},{"HDMI"},
    };
    
    static HI_CHAR sVicapColorSys[][20] =
    {
        {"AUTO"}, {"PAL"}, {"NTSC"}, {"SECAM"}, {"PAL_M"}, 
        {"PAL_N"}, {"PAL_60"}, {"NTSC443"},{"NTSC_50"},
    };

    static HI_CHAR sVicapBufMode[][20] =
    {
        {"ALLOC"}, {"MMAP"}, {"AUTO"},
    };

    static HI_CHAR sVicap3DT2DMode[][20] =
    {
        {"OFF"}, {"L"}, {"R"},
    };

    pProcItem = s->private;
    hVicap = (HI_HANDLE)pProcItem->data;
    u32VicapContextId = GETCONTEXTID(hVicap);
    VICAP_DRV_GetVicapCtx(u32VicapContextId, &pstVicapDrvCtx);
    pstDrvVicapAttr = &pstVicapDrvCtx->stVicapAttr;
    pstOutAttr = &pstVicapDrvCtx->stVicapAttr.stOutAttr;
    pstFrmStatus = &pstVicapDrvCtx->stFrmStatus;
    pstChnDbg = &pstVicapDrvCtx->stChnDbg;
    pstBufMgr = (VICAP_BUF_MGR_S *)(pstVicapDrvCtx->hBufHandle);
    
    PROC_PRINT(s, "\n-------------------------------Vicap Info---------------------------------------\n");
    PROC_PRINT(s, "%-15s" "%-5s" "0x%-13x" "%-5s","hViCap",":",hVicap,"|");
    PROC_PRINT(s, "%-15s" "%-5s" "%-15s\n","Status",":",sVicapStatus[pstVicapDrvCtx->enStatus]);
    PROC_PRINT(s, "%-15s" "%-5s" "0x%-13x" "%-5s","UfHandle",":",(HI_U32)(pstVicapDrvCtx->pUfHandle),"|");
    PROC_PRINT(s, "%-15s" "%-5s" "0x%-13x\n","BufHandle",":",pstVicapDrvCtx->hBufHandle);

    PROC_PRINT(s, "-------------------------------Vicap In Atttr-----------------------------------\n");
    PROC_PRINT(s, "%-15s" "%-5s" "%-15s" "%-5s","Type",":",sVicapType[pstDrvVicapAttr->enType],"|");
    PROC_PRINT(s, "%-15s" "%-5s" "%-15s\n","Access",":",sVicapAccess[pstDrvVicapAttr->enAccess]);
    PROC_PRINT(s, "%-15s" "%-5s" "%-15s" "%-5s","3dFmt",":",sVicap3dFmt[pstDrvVicapAttr->en3dFmt],"|");
    PROC_PRINT(s, "%-15s" "%-5s" "%-15s\n","Intf_M",":",sVicapIntf[pstDrvVicapAttr->enIntfMode]);
    PROC_PRINT(s, "%-15s" "%-5s" "%-15s" "%-5s","I/P",":",((pstDrvVicapAttr->bInterlace)?"I":"P"),"|");
    PROC_PRINT(s, "%-15s" "%-5s" "%-15d\n","Freq",":",pstDrvVicapAttr->u32FrameRate);
    PROC_PRINT(s, "%-15s" "%-5s" "%-15d" "%-5s","SrcW",":",pstDrvVicapAttr->u32Width,"|");
    PROC_PRINT(s, "%-15s" "%-5s" "%-15d\n","SrcH",":",pstDrvVicapAttr->u32Height);
    PROC_PRINT(s, "%-15s" "%-5s" "%-15d" "%-5s","Vblank",":",pstDrvVicapAttr->u32Vblank,"|");
    PROC_PRINT(s, "%-15s" "%-5s" "%-15s\n","PixFmt",":",sVicapPixFmt[pstDrvVicapAttr->enPixFmt]);
    PROC_PRINT(s, "%-15s" "%-5s" "%-15s" "%-5s","BitW",":",sVicapBitWidth[pstDrvVicapAttr->enSrcBitWidth],"|");
    PROC_PRINT(s, "%-15s" "%-5s" "%-15s\n","OverSmp",":",sVicapOverSmp[pstDrvVicapAttr->enOverSample]);
    PROC_PRINT(s, "%-15s" "%-5s" "%-15s" "%-5s","C_Space",":",sVicapCSpace[pstDrvVicapAttr->enColorSpace],"|");
    PROC_PRINT(s, "%-15s" "%-5s" "%-15s\n","SrcType",":",sVicapSrcType[pstDrvVicapAttr->enSourceType]);
    PROC_PRINT(s, "%-15s" "%-5s" "%-15s" "%-5s","C_Sys",":",sVicapColorSys[pstDrvVicapAttr->enColorSys],"|");
    PROC_PRINT(s, "%-15s" "%-5s" "%-15s\n","bGraphicMode",":",((pstDrvVicapAttr->bGraphicMode)?"YES":"NO"));
    PROC_PRINT(s, "%-15s" "%-5s" "%-15s" "%-5s","BufMod",":",sVicapBufMode[pstDrvVicapAttr->enBufMgmtMode],"|");
    PROC_PRINT(s, "%-15s" "%-5s" "%-15d\n","BufNum",":",pstDrvVicapAttr->u32BufNum);
    PROC_PRINT(s, "%-15s" "%-5s" "%-15s\n","bUserOut",":",((pstDrvVicapAttr->bUserOut)?"YES":"NO"));
    
    PROC_PRINT(s, "-------------------------------Vicap Out Atttr-----------------------------------\n");
    PROC_PRINT(s, "%-15s" "%-5s" "%-15s" "%-5s","3DT2DMode",":",sVicap3DT2DMode[pstOutAttr->en3DT2DMode],"|");
    PROC_PRINT(s, "%-15s" "%-5s" "%-15d\n","DstFRate",":",pstOutAttr->u32DstFrameRate);
    PROC_PRINT(s, "%-15s" "%-5s" "%-15d" "%-5s","Cap_X",":",pstOutAttr->stCapRect.s32X,"|");
    PROC_PRINT(s, "%-15s" "%-5s" "%-15d\n","Cap_Y",":",pstOutAttr->stCapRect.s32Y);
    PROC_PRINT(s, "%-15s" "%-5s" "%-15d" "%-5s","Cap_W",":",pstOutAttr->stCapRect.s32Width,"|");
    PROC_PRINT(s, "%-15s" "%-5s" "%-15d\n","Cap_H",":",pstOutAttr->stCapRect.s32Height);
    PROC_PRINT(s, "%-15s" "%-5s" "%-15d" "%-5s","Dest_W",":",pstOutAttr->u32DestWidth,"|");
    PROC_PRINT(s, "%-15s" "%-5s" "%-15d\n","Dest_H",":",pstOutAttr->u32DestHeight);
    PROC_PRINT(s, "%-15s" "%-5s" "%-15s" "%-5s","Dest_VFmt",":",sVicapPixFmt[pstOutAttr->enVideoFmt],"|");
    PROC_PRINT(s, "%-15s" "%-5s" "%-15s\n","Dest_BitW",":",sVicapBitWidth[pstOutAttr->enDstBitWidth]);
    
    PROC_PRINT(s, "-------------------------------Vicap Frame Status--------------------------------\n");
    PROC_PRINT(s, "%-15s" "%-5s" "%-15d" "%-5s","YStride",":",pstFrmStatus->u32YStride,"|");
    PROC_PRINT(s, "%-15s" "%-5s" "%-15d\n","CStride",":",pstFrmStatus->u32CStride);
    PROC_PRINT(s, "%-15s" "%-5s" "%-15d" "%-5s","BufSize",":",pstFrmStatus->u32BufSize,"|");
    PROC_PRINT(s, "%-15s" "%-5s" "%-15s\n","b3D",":",((pstFrmStatus->b3D)?"YES":"NO"));
    PROC_PRINT(s, "%-15s" "%-5s" "%-15s" "%-5s","bCsc",":",((pstFrmStatus->bCsc)?"YES":"NO"),"|");
    PROC_PRINT(s, "%-15s" "%-5s" "%-15s\n","CscColorSpace",":",sVicapCSpace[pstFrmStatus->eCscColorSpace]);

    PROC_PRINT(s, "-------------------------------Vicap MMZ Info------------------------------------\n");
    PROC_PRINT(s, "%-15s" "%-5s" "0x%-13x" "%-5s","VirAddr",":",pstBufMgr->stMMZBuf.pu8StartVirAddr,"|");
    PROC_PRINT(s, "%-15s" "%-5s" "0x%-13x\n","PhyAddr",":",pstBufMgr->stMMZBuf.u32StartPhyAddr);
    PROC_PRINT(s, "%-15s" "%-5s" "0x%-13x\n","SumCnt",":",pstBufMgr->stMMZBuf.u32Size);

    PROC_PRINT(s, "-------------------------------Vicap Buf Attr------------------------------------\n");
    for (i = 0; i < pstBufMgr->stBufAttr.u32BufNum; i = i+2)
    {
        PROC_PRINT(s, "%-15s" "%-5s" "0x%-8x" "/%-4d" "%-5s","PhyAddr/SumCnt"
            ,":",pstBufMgr->pstBuf[i].stVideoFrmInfo.stBufAddr[0].u32PhyAddr_Y
            ,pstBufMgr->pstBuf[i].s32SumCnt,"|");
        PROC_PRINT(s, "%-15s" "%-5s" "0x%-8x" "/%-4d\n","PhyAddr/SumCnt",":"
            ,pstBufMgr->pstBuf[i+1].stVideoFrmInfo.stBufAddr[0].u32PhyAddr_Y
            ,pstBufMgr->pstBuf[i+1].s32SumCnt);         
    }
    
    PROC_PRINT(s, "--------------------------------Vicap Dbg Info-----------------------------------\n");
    PROC_PRINT(s, "%-15s" "%-5s" "%-15d" "%-5s","IntCnt",":",pstChnDbg->u32IntCnt,"|");
    PROC_PRINT(s, "%-15s" "%-5s" "%-15d\n","IntTime",":",pstChnDbg->u32IntTime);
    PROC_PRINT(s, "%-15s" "%-5s" "%-15d" "%-5s","IntvTime",":",pstChnDbg->u32IntvTime,"|");
    PROC_PRINT(s, "%-15s" "%-5s" "%-15d\n","BufCnt",":",pstChnDbg->u32BufCnt);
    PROC_PRINT(s, "%-15s" "%-5s" "%-15d" "%-5s","LostInt",":",pstChnDbg->u32LostInt,"|");
    PROC_PRINT(s, "%-15s" "%-5s" "%-15d\n","TopLost",":",pstChnDbg->u32TopLost);
    PROC_PRINT(s, "%-15s" "%-5s" "%-15d" "%-5s","BotLost",":",pstChnDbg->u32BotLost,"|");
    PROC_PRINT(s, "%-15s" "%-5s" "%-15d\n","GetFaild",":",pstChnDbg->u32GetVbFail);
    PROC_PRINT(s, "%-15s" "%-5s" "%-15d" "%-5s","FrmIndex",":",pstChnDbg->u32Sequence,"|");
    PROC_PRINT(s, "%-15s" "%-5s" "%-15d\n","Sequence",":",pstChnDbg->u32Sequence);    
    PROC_PRINT(s, "%-15s" "%-5s" "%-15d" "%-5s","SendvTime",":",pstChnDbg->u32SendvTime,"|");
    PROC_PRINT(s, "%-15s" "%-5s" "%-15d\n","SendTime",":",pstChnDbg->u32SendFrmTime);
    PROC_PRINT(s, "%-15s" "%-5s" "%-15d" "%-5s","SendCnt",":",pstChnDbg->u32SendCnt,"|");
    PROC_PRINT(s, "%-15s" "%-5s" "%-15d\n","UpdateCnt",":",pstChnDbg->u32UpdateCnt);
 
    return HI_SUCCESS;
}

static HI_S32 VICAP_DRV_ProcWrite(struct file *file, const char __user *buf, size_t count,
                               loff_t *ppos)
{
    struct seq_file *q = file->private_data;
    DRV_PROC_ITEM_S *pProcItem = q->private;
    HI_CHAR  ProcPara[64]={0};
    HI_CHAR *pArg1, *pArg2;
    HI_HANDLE hVicap;
    HI_S32 s32Ret;

    hVicap = (HI_HANDLE)(pProcItem->data);

    if (HI_INVALID_HANDLE == hVicap)
    {
        return -EFAULT;
    }

    if(count >= sizeof(ProcPara)) 
    {
        HI_ERR_VICAP("your echo parameter string is too long!\n");
        return -EFAULT;
    }

    if (count >= 1)
    {
        //memset(ProcPara, 0, sizeof(ProcPara));
        if (copy_from_user(ProcPara, buf, count))
        {
            HI_ERR_VICAP("copy_from_user failed.\n");
            return -EFAULT;
        }
        
        ProcPara[count] = '\0';
        
        s32Ret = VICAP_DRV_ParseProcPara(ProcPara, &pArg1, &pArg2);
        if (s32Ret != HI_SUCCESS)
        {
            VICAP_DRV_ProcHelp();
            return -EFAULT;
        }
        else
        {
            VICAP_DRV_ProcHelp();
        }
    }
    else
    {
        VICAP_DRV_ProcHelp();
    }

    return count;
}

HI_S32 VICAP_DRV_ProcAdd(HI_HANDLE hVicap)
{
    HI_S32 s32Len = 0;
    HI_U32 u32VicapContextId;
    DRV_PROC_ITEM_S *pProcItem; 
    HI_CHAR ProcName[12];

    if (HI_INVALID_HANDLE == hVicap)
    {
        return HI_FAILURE;
    }

    u32VicapContextId = GETCONTEXTID(hVicap);
    s32Len = HI_OSAL_Snprintf(ProcName, sizeof(ProcName), "vicap%04x", u32VicapContextId);
    if (0 == s32Len)
    {
        HI_ERR_VICAP("HI_OSAL_Snprintf failed!\n");
        return HI_FAILURE;
    }

    pProcItem = HI_DRV_PROC_AddModule(ProcName, HI_NULL, HI_NULL);
    if (!pProcItem)
    {
        HI_ERR_VICAP("VICAP add proc failed!\n");
        return HI_FAILURE;
    }

    pProcItem->data  = (HI_VOID *)hVicap;
    pProcItem->read  = VICAP_DRV_ProcRead;
    pProcItem->write = VICAP_DRV_ProcWrite;

    return HI_SUCCESS;
}

HI_S32 VICAP_DRV_ProcDel(HI_HANDLE hVicap)
{
    HI_S32 s32Len = 0;
    HI_U32 u32VicapContextId;
    HI_CHAR ProcName[12];

    if (HI_INVALID_HANDLE == hVicap)
    {
        return HI_FAILURE;
    }

    u32VicapContextId = GETCONTEXTID(hVicap);

    s32Len = HI_OSAL_Snprintf(ProcName, sizeof(ProcName), "vicap%04x", u32VicapContextId);
    if (0 == s32Len)
    {
        return HI_FAILURE;
    }

    HI_DRV_PROC_RemoveModule(ProcName);
    return HI_SUCCESS;
}

