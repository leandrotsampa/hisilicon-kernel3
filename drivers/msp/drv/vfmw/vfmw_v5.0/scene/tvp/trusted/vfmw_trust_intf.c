/*$$$!!Warning: Huawei key information asset. No spread without permission.$$$*/
/*CODEMARK:EG4uRhTwMmgcVFBsBnYHCDadN5jJKSuVyxmmaCmKFU6eJEbB2fyHF9weu4/jer/hxLHb+S1e
E0zVg4C3NiZh4SXu1DUPt3BK64ZJx2SaroTK5QUHRI9UX5KeSe3MjVz/EbC4xx64tuANphe3
Vboa6b4pYu8m8UC28pwi97ELsUTJTl5RB1PRuEMOczXet0+qgXTuHXRloWufkI5//OVahT+k
utv3oJ2Y2jFklawvuzRPXS9WYBXWklQWvzqeJuxvdE/PWg7bN65zZmaVZA8xmA==#*/
/*$$$!!Warning: Deleting or modifying the preceding information is prohibited.$$$*/

#include "vfmw_trust_intf.h"
#include "trusted_vfmw_osal.h"
#include "vfmw_ctrl.h"
#include "tvp_adapter.h"
#include "vfmw_osal_ext.h"

extern Vfmw_Osal_Func_Ptr vfmw_Osal_Func_Ptr_S;

/* SECURE MARK */
MEMORY_NEEDED_SECVFMW_S *g_pVfmSharewMem  = NULL;
VDEC_CHAN_OPTION_S *g_pChanOption; //store chan option
RAW_ARRAY_NS *g_pStreamList = NULL; //manage stream buffer
CALLBACK_ARRAY_NS *g_pCallBackList = NULL;//manage callback buffer
VDEC_CHAN_STATE_S  *g_pChanState = NULL; //store chan state
IMAGE_QUEUE_NS     *g_pImageList = NULL; //store image info
UINT8              *g_pProcBuf     = NULL;

/************************************************************************
    TEE 通信封装接口
*************************************************************************/
SINT32 SEC_VDEC_Init( UINT32 pVdecCallback)
{
    SINT32 ret = 0;
        
    pVdecCallback = SOS_Mmap(pVdecCallback, sizeof(UINT32), 1, 1);
    
    if (NULL == pVdecCallback)
    {
        dprint(PRN_FATAL, "%s %d, map_section_entry failed ret=%d\n", __func__,__LINE__,ret);
    }
    else
    {
        ret = VDEC_Init((VOID *)pVdecCallback);
    }
    
    SOS_Unmap(pVdecCallback, sizeof(UINT32));
     
    return ret;
}

SINT32 SEC_VDEC_InitWithOperation(UINT32 pArgs)
{
    SINT32 ret = VDEC_ERR;
       
    pArgs = SOS_Mmap(pArgs, sizeof(VDEC_OPERATION_S), 1, 1);
    if (pArgs == NULL)
    {
        dprint(PRN_FATAL, "%s %d, map_section_entry failed!\n", __func__,__LINE__);
        return VDEC_ERR;
    }
    
    ret = VDEC_InitWithOperation((VDEC_OPERATION_S *)pArgs);    
    
    SOS_Unmap(pArgs, sizeof(VDEC_OPERATION_S));

    return ret;
}

SINT32 SEC_VDEC_Exit(VOID)
{
    SINT32 ret = VDEC_ERR;
    
    ret = VDEC_Exit();

    return ret;
}

SINT32 SEC_VDEC_Control(SINT32 ChanID, UINT32 eCmdID, UINT32 pArgs)
{
    SINT32 ret = VDEC_ERR;
    UINT8  MapFlag = 0;
    SINT32 MapSize = 4096;
    
    if (pArgs != 0)
    {
        pArgs = SOS_Mmap(pArgs, MapSize, 1, 1);//指针所指的内容长度未知，暂映射4K
        if (NULL == pArgs)
        {
            dprint(PRN_FATAL, "%s %d, map_section_entry failed ret=%d\n", __func__,__LINE__,ret);
            return VDEC_ERR;
        }
        MapFlag = 1;
    }
    
    ret = VDEC_Control(ChanID, eCmdID, (VOID *)pArgs);

    if (1 == MapFlag)
    {
        SOS_Unmap(pArgs, MapSize);
    }
    
    return ret;
}

SINT32 SEC_TEST_Memcpy(SINT32 src, UINT32 dst, UINT32 len)
{
    SINT32 ret = -1;
    UINT32 viraddr;
    
    if (0 != mmap(src, len, 1, 0, &viraddr))    
    {        
        uart_printf_func("ca2ta map_section_entry failed ret!\n");    
    }
    else
    {
        memcpy((UINT8 *)dst, (UINT8 *)viraddr, len);
        unmap(viraddr, len);
        ret = 0;
    }
    
    return ret;
}

SINT32 SEC_VDEC_Suspend(VOID)
{
    return VDEC_Suspend();
}

SINT32 SEC_VDEC_Resume(VOID)
{
    return VDEC_Resume();
}

SINT32 SEC_VCTRL_RunProcess(VOID)
{
   	SINT32 ret =0;

    ret = VCTRL_RunProcess();

    return ret;
}

SINT32 SEC_VCTRL_ReadProc(UINT32 page, SINT32 count)
{
    SINT32 ret = 0;
    
    if (g_pProcBuf != NULL)
    {
        ret = VCTRL_ReadProc((SINT8 *)g_pProcBuf, count);
    }

    return ret;
}

SINT32 SEC_VCTRL_WriteProc(UINT32 option, SINT32 value)
{
    return VCTRL_WriteProc(option, value);
}

SINT32 SEC_VCTRL_SetDbgOption (UINT32 opt, UINT32 p_args)
{
    SINT32 ret = 0;
    p_args = SOS_Mmap(p_args, sizeof(UINT32), 1, 1);
    if (NULL == p_args)
    {
        dprint(PRN_FATAL, "%s %d, map_section_entry failed ret=%d\n", __func__,__LINE__,ret);
    }
    else
    {
        ret = VCTRL_SetDbgOption(opt, (UINT8 *)p_args);
    }
    SOS_Unmap(p_args, sizeof(UINT32));
    return ret;
}

SINT32 SEC_VCTRL_GetChanImage(SINT32 ChanID, UINT32 pImage)
{
    SINT32 ret = 0;
    pImage = SOS_Mmap(pImage, sizeof(IMAGE), 1, 1);
    if (NULL == pImage)
    {
        dprint(PRN_FATAL, "%s %d, map_section_entry failed ret=%d\n", __func__,__LINE__,ret);
    }
    else
    {
        ret = VCTRL_GetChanImage(ChanID, (IMAGE *)pImage);
    }
    SOS_Unmap(pImage, sizeof(IMAGE));

    return ret;
}

SINT32 SEC_VCTRL_ReleaseChanImage( SINT32 ChanID, UINT32 pImage )
{
    SINT32 ret = 0;
    pImage = SOS_Mmap(pImage, sizeof(IMAGE), 1, 1);
    if (NULL == pImage)
    {
        dprint(PRN_FATAL, "%s %d, map_section_entry failed ret=%d\n", __func__,__LINE__,ret);
    }
    else
    {
        ret = VCTRL_ReleaseChanImage(ChanID, (IMAGE *)pImage);
    }
    SOS_Unmap(pImage, sizeof(IMAGE));
    return ret;
}


