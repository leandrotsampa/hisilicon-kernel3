/******************************************************************************

  Copyright (C), 2014-2015, Hisilicon Tech. Co., Ltd.

******************************************************************************
  File Name     : drv_pq_table.c
  Version       : Initial Draft
  Author        : p00203646
  Created       : 2013/11/06
  Description   :

******************************************************************************/

#include "pq_hal_comm.h"
#include "hi_drv_proc.h"
#include "drv_pq_table.h"
#include "pq_hal_table_default.h"
#include "hi_math.h"

static HI_BOOL sg_bPqTableInitial   = HI_FALSE;
static HI_U32  sg_u32PhyListNum     = PHY_REG_MAX;
static HI_U32  sg_u32SoftListNum    = SOFT_REG_MAX;
static PQ_PHY_REG_S* sg_pstPhyReg   = HI_NULL;
static PQ_PHY_REG_S* sg_pstSoftReg  = HI_NULL;

static HI_PQ_BIN_MODULE_POS_S sg_astBinPos[HI_PQ_MODULE_BUTT];


HI_S32 PQ_MNG_DeInitPQTable(HI_VOID)
{
    if (sg_bPqTableInitial == HI_FALSE)
    {
        return HI_SUCCESS;
    }

    sg_bPqTableInitial = HI_FALSE;
    return HI_SUCCESS;
}

HI_S32 PQ_MNG_InitPQTable(PQ_PARAM_S* pstPqParam, HI_BOOL bDefault)
{
    HI_U32 i = 0;
    HI_U32 u32Order = 0;


    if (sg_bPqTableInitial == HI_TRUE)
    {
        return HI_SUCCESS;
    }

    PQ_CHECK_NULL_PTR(pstPqParam);
    sg_pstPhyReg  = pstPqParam->stPQPhyReg;
    sg_pstSoftReg = pstPqParam->stPQSoftReg;

    /*set default pqparam form code*/
    if (HI_TRUE == bDefault)
    {
        memset(sg_pstPhyReg, 0, sizeof(PQ_PHY_REG_S)*PHY_REG_MAX);
        memset(sg_pstSoftReg, 0, sizeof(PQ_PHY_REG_S)*SOFT_REG_MAX);

        for (i = 0; i < PHY_REG_MAX; i++)
        {
            if ((0 == sg_stPhyReg[i].u32RegAddr)
                && (0 == sg_stPhyReg[i].u8Lsb)
                && (0 == sg_stPhyReg[i].u8Msb))
            {
                break;
            }
            sg_pstPhyReg[i] = sg_stPhyReg[i];
        }

        for (i = 0; i < SOFT_REG_MAX; i++)
        {
            if ((0 == sg_stPQSoftReg[i].u32RegAddr)
                && (0 == sg_stPQSoftReg[i].u8Lsb)
                && (0 == sg_stPQSoftReg[i].u8Msb))
            {
                break;
            }
            sg_pstSoftReg[i] = sg_stPQSoftReg[i];
        }
    }

    /*init variable about pq table*/
    for (i = 0; i < HI_PQ_MODULE_BUTT; i++)
    {
        sg_astBinPos[i].u32StartPos = PHY_REG_MAX - 1;
        sg_astBinPos[i].u32EndPos   = 0;
    }

    /* calculate phy list num and  start position and end position of alg module*/
    for (i = 0; i < PHY_REG_MAX; i++)
    {
        if ((0 == sg_pstPhyReg[i].u32RegAddr)
            && (0 == sg_pstPhyReg[i].u8Lsb)
            && (0 == sg_pstPhyReg[i].u8Msb))
        {
            break;
        }

        /*init start position and end position of pq bin module*/
        u32Order = sg_pstPhyReg[i].u32Module;
        if (u32Order >= HI_PQ_MODULE_BUTT)
        {
            continue;
        }

        sg_astBinPos[u32Order].u32StartPos = MIN2(sg_astBinPos[u32Order].u32StartPos, i);
        sg_astBinPos[u32Order].u32EndPos   = MAX2(sg_astBinPos[u32Order].u32EndPos, i);
    }
    sg_u32PhyListNum = i;

    /* calculate soft list num */
    for (i = 0; i < SOFT_REG_MAX; i++)
    {
        if ((0 == sg_pstSoftReg[i].u32RegAddr)
            && (0 == sg_pstSoftReg[i].u8Lsb)
            && (0 == sg_pstSoftReg[i].u8Msb))
        {
            break;
        }
    }
    sg_u32SoftListNum = i;

    HI_INFO_PQ("Phy Register Num:%d\n", sg_u32PhyListNum);
    HI_INFO_PQ("Soft Register Num:%d\n", sg_u32SoftListNum);

    pstPqParam->stPQFileHeader.u32PhyRegNum = sg_u32PhyListNum;
    pstPqParam->stPQFileHeader.u32SoftRegNum = sg_u32SoftListNum;

    sg_bPqTableInitial = HI_TRUE;
    return HI_SUCCESS;
}

/* check Timing Source Mode*/
PQ_SOURCE_MODE_E PQ_MNG_CheckSourceMode(HI_U32 u32Width, HI_U32 u32Height)
{
    if (720 >= u32Width) /* SD Source */
    {
        return SOURCE_MODE_SD;
    }
    else if ((1280 >= u32Width) && (720 < u32Width)) /* HD Source */
    {
        return SOURCE_MODE_HD;
    }
    else if ((1920 >= u32Width) && (1280 < u32Width)) /* FHD Source */
    {
        return SOURCE_MODE_HD;
    }
    else if ((4096 >= u32Width) && (1920 < u32Width)) /* UHD Source */
    {
        return SOURCE_MODE_UHD;
    }

    return SOURCE_MODE_NO;
}

/* check Timing Output Mode*/
PQ_OUTPUT_MODE_E PQ_MNG_CheckOutputMode(HI_S32 s32Width)
{
    if ((720 >= s32Width) && (0 < s32Width)) /* SD Source */
    {
        return OUTPUT_MODE_SD;
    }
    else if ((1280 >= s32Width) && (720 < s32Width)) /* HD Source */
    {
        return OUTPUT_MODE_HD;
    }
    else if ((1920 >= s32Width) && (1280 < s32Width)) /* FHD Source */
    {
        return OUTPUT_MODE_HD;
    }
    else if ((4096 >= s32Width) && (1920 < s32Width)) /* UHD Source */
    {
        return OUTPUT_MODE_UHD;
    }

    return OUTPUT_MODE_NO;

}


static HI_S32 PQ_MNG_UpdatePhyList(HI_U32 u32Addr, HI_U8 u8Lsb, HI_U8 u8Msb, HI_U8 u8SourceMode, HI_U8 u8OutputMode, HI_U32 u32Value)
{
    HI_U32 i;

    PQ_CHECK_NULL_PTR(sg_pstPhyReg);

    for (i = 0; i < sg_u32PhyListNum; i++)
    {
        if ((u32Addr & REG_OFFSET_ADDR_MASK) != sg_pstPhyReg[i].u32RegAddr)
        {
            continue;
        }
        if (u8Lsb != sg_pstPhyReg[i].u8Lsb)
        {
            continue;
        }
        if (u8Msb != sg_pstPhyReg[i].u8Msb)
        {
            continue;
        }
        if ((SOURCE_MODE_NO != sg_pstPhyReg[i].u8SourceMode) && (u8SourceMode != sg_pstPhyReg[i].u8SourceMode))
        {
            continue;
        }
        if ((SOURCE_MODE_NO != sg_pstPhyReg[i].u8OutputMode) && (u8OutputMode != sg_pstPhyReg[i].u8OutputMode))
        {
            continue;
        }

        sg_pstPhyReg[i].u32Value = u32Value;
        return i;
    }

    return HI_FAILURE;
}

static HI_S32 PQ_MNG_SetVdpReg(HI_U32 u32Addr, HI_U8 u8Lsb, HI_U8 u8Msb, HI_U32 u32Value)
{
    HI_S32 s32Ret = HI_FAILURE;
    HI_U32 u32RegValue = 0;

    if (PQ_HAL_CheckVdpValid() == HI_TRUE)
    {
        s32Ret = PQ_HAL_ReadRegister(0, u32Addr, &u32RegValue);
        if (HI_SUCCESS != s32Ret)
        { return HI_FAILURE; }
        PQ_HAL_SetU32ByBit(&u32RegValue, u8Msb, u8Lsb, u32Value);
        s32Ret = PQ_HAL_WriteRegister(0, u32Addr, u32RegValue);
    }
    else
    {
        HI_ERR_PQ("PQ_HAL_CheckVdpValid false\n");
    }

    return s32Ret;
}

static HI_S32 PQ_MNG_SetVpssReg(HI_U32 u32Addr, HI_U8 u8Lsb, HI_U8 u8Msb, HI_U32 u32Value)
{
    HI_S32 s32Ret = HI_FAILURE;
    HI_U32 u32RegValue = 0;
    HI_S32 i = 0;

    for (i = 0; i < VPSS_HANDLE_NUM; i++)
    {
        if (PQ_HAL_CheckVpssValid(i) == HI_FALSE)
        {
            continue;
        }
        s32Ret = PQ_HAL_ReadRegister(i, u32Addr, &u32RegValue);
        if (HI_SUCCESS != s32Ret)
        { return HI_FAILURE; }
        PQ_HAL_SetU32ByBit(&u32RegValue, u8Msb, u8Lsb, u32Value);
        s32Ret = PQ_HAL_WriteRegister(i, u32Addr, u32RegValue);
    }

    return s32Ret;
}

static HI_BOOL PQ_MNG_IsSelVdpReg(HI_U32 u32RegAddr)
{
    HI_U32 u32OffsetAddr =	u32RegAddr & REG_OFFSET_ADDR_MASK;

    if ((u32RegAddr & REG_BASE_ADDR_MASK) != VDP_REGS_ADDR)
    {
        return HI_FALSE;
    }

    if ((u32OffsetAddr >= 0xD800) && (u32OffsetAddr <= 0xEE7C))
    {
        return HI_TRUE;
    }

    return HI_FALSE;
}

static HI_S32 PQ_MNG_SetSelVdpReg(HI_U32 u32Addr, HI_U8 u8Lsb, HI_U8 u8Msb, HI_U32 u32Value)
{
    HI_U32 u32RegValue = 0;
    HI_U32 u32OffsetAddr =  u32Addr & REG_OFFSET_ADDR_MASK;

    u32RegValue = *((HI_U32*)((HI_VOID*)g_pstIPSelVdpAlg + u32OffsetAddr));
    PQ_HAL_SetU32ByBit(&u32RegValue, u8Msb, u8Lsb, u32Value);
    *(HI_U32*)((HI_VOID*)g_pstIPSelVdpAlg + u32OffsetAddr) = u32RegValue;

    return HI_SUCCESS;
}

static HI_S32 PQ_MNG_SetSelVdpRegByModule(HI_U32 u32Module, HI_U32 u32Addr, HI_U8 u8Lsb, HI_U8 u8Msb, HI_U32 u32Value)
{
    if ((HI_PQ_MODULE_DB == u32Module)
        || (HI_PQ_MODULE_DM == u32Module)
        || (HI_PQ_MODULE_DR == u32Module)
        || (HI_PQ_MODULE_DS == u32Module))
    {
        u32Addr += 0xB300;
    }
    else if ((HI_PQ_MODULE_TNR == u32Module) || (HI_PQ_MODULE_SNR == u32Module))
    {
        u32Addr += 0xB000;
    }
    else
    {
        return HI_FAILURE;
    }

    PQ_MNG_SetSelVdpReg(u32Addr, u8Lsb, u8Msb, u32Value);

    return HI_SUCCESS;
}


HI_S32 PQ_MNG_LoadPhyList(PQ_REG_TYPE_E enRegType, PQ_SOURCE_MODE_E enSourceMode, PQ_OUTPUT_MODE_E enOutputMode)
{
    HI_S32 s32Ret = HI_FAILURE;
    HI_U32 i;
    HI_U32 u32Addr, u32Value, u32Module;
    HI_U8 u8Lsb, u8Msb, u8SourceMode, u8OutputMode;

    PQ_CHECK_NULL_PTR(sg_pstPhyReg);

    for (i = 0; i < sg_u32PhyListNum; i++)
    {
        u32Addr       = sg_pstPhyReg[i].u32RegAddr;
        u32Value      = sg_pstPhyReg[i].u32Value;
        u32Module     = sg_pstPhyReg[i].u32Module;
        u8Lsb         = sg_pstPhyReg[i].u8Lsb;
        u8Msb         = sg_pstPhyReg[i].u8Msb;
        u8SourceMode  = sg_pstPhyReg[i].u8SourceMode;
        u8OutputMode  = sg_pstPhyReg[i].u8OutputMode;

        u32Addr &= REG_OFFSET_ADDR_MASK;

        if ((HI_U32)enRegType != PQ_COMM_GetAlgTypeID(u32Module))
        {
            continue;
        }

        if ((SOURCE_MODE_NO != u8SourceMode) && (u8SourceMode != enSourceMode))
        {
            continue;
        }

        if ((OUTPUT_MODE_NO != u8OutputMode) && (u8OutputMode != enOutputMode))
        {
            continue;
        }

        if (REG_TYPE_VPSS == PQ_COMM_GetAlgTypeID(u32Module))
        {
            u32Addr |= VPSS_REGS_ADDR;
            s32Ret = PQ_MNG_SetVpssReg(u32Addr, u8Lsb, u8Msb, u32Value);
        }
        else if (REG_TYPE_VDP == PQ_COMM_GetAlgTypeID(u32Module))
        {
            s32Ret = PQ_MNG_SetSelVdpRegByModule(u32Module, u32Addr, u8Lsb, u8Msb, u32Value);
            if (s32Ret == HI_SUCCESS)
            {
                continue;
            }

            u32Addr |= VDP_REGS_ADDR;
            s32Ret = PQ_MNG_SetVdpReg(u32Addr, u8Lsb, u8Msb, u32Value);
        }

        pqprint(PQ_PRN_TABLE, "LoadPhyList,Load Addr:0x%x, SourceMode:%d, OutputMode:%d, Module:%d\n", u32Addr, u8SourceMode, u8OutputMode, u32Module);
    }

    return s32Ret;
}

HI_S32 PQ_MNG_LoadPhyListOfAlg(HI_PQ_MODULE_E enModule, PQ_SOURCE_MODE_E enSourceMode, PQ_OUTPUT_MODE_E enOutputMode)
{
    HI_S32 s32Ret = HI_FAILURE;
    HI_U32 i;
    HI_U32 u32Addr, u32Value, u32Module;
    HI_U32 u32StartPos = 0;
    HI_U32 u32EndPos = 0;
    HI_U8  u8Lsb, u8Msb, u8SourceMode, u8OutputMode;

    PQ_CHECK_NULL_PTR(sg_pstPhyReg);

    u32StartPos = sg_astBinPos[enModule].u32StartPos;
    u32EndPos = sg_astBinPos[enModule].u32EndPos;

    for (i = u32StartPos; i <= u32EndPos; i++)
    {
        u32Addr       = sg_pstPhyReg[i].u32RegAddr;
        u32Value      = sg_pstPhyReg[i].u32Value;
        u32Module     = sg_pstPhyReg[i].u32Module;
        u8Lsb         = sg_pstPhyReg[i].u8Lsb;
        u8Msb         = sg_pstPhyReg[i].u8Msb;
        u8SourceMode  = sg_pstPhyReg[i].u8SourceMode;
        u8OutputMode  = sg_pstPhyReg[i].u8OutputMode;

        u32Addr &= REG_OFFSET_ADDR_MASK;

        if ((HI_U32)enModule != u32Module)
        {
            continue;
        }

        if ((SOURCE_MODE_NO != u8SourceMode) && (u8SourceMode != enSourceMode))
        {
            continue;
        }

        if ((OUTPUT_MODE_NO != u8OutputMode) && (u8OutputMode != enOutputMode))
        {
            continue;
        }

        if (REG_TYPE_VPSS == PQ_COMM_GetAlgTypeID(enModule))
        {
            u32Addr |= VPSS_REGS_ADDR;
            s32Ret = PQ_MNG_SetVpssReg(u32Addr, u8Lsb, u8Msb, u32Value);
        }
        else if (REG_TYPE_VDP == PQ_COMM_GetAlgTypeID(enModule))
        {
            s32Ret = PQ_MNG_SetSelVdpRegByModule(u32Module, u32Addr, u8Lsb, u8Msb, u32Value);
            if (s32Ret == HI_SUCCESS)
            {
                continue;
            }

            u32Addr |= VDP_REGS_ADDR;
            s32Ret = PQ_MNG_SetVdpReg(u32Addr, u8Lsb, u8Msb, u32Value);
        }

        pqprint(PQ_PRN_TABLE, "LoadPhyListOfAlg,Load Addr:0x%x, SourceMode:%d, OutputMode:%d, Module:%d\n", u32Addr, u8SourceMode, u8OutputMode, u32Module);
    }

    return s32Ret;
}

HI_S32 PQ_MNG_LoadMultiList(PQ_REG_TYPE_E enRegType, PQ_SOURCE_MODE_E enSourceMode, PQ_OUTPUT_MODE_E enOutputMode)
{
    HI_S32 s32Ret = HI_FAILURE;
    HI_PQ_MODULE_E enModule;


    for (enModule = 0; enModule < HI_PQ_MODULE_BUTT; enModule++)
    {
        if (PQ_BIN_ADAPT_MULTIPLE != PQ_COMM_GetAlgAdapeType(enModule))
        {
            continue;
        }

        if ((HI_U32)enRegType != PQ_COMM_GetAlgTypeID(enModule))
        {
            continue;
        }

        s32Ret = PQ_MNG_LoadPhyListOfAlg(enModule, enSourceMode, enOutputMode);
    }

    return s32Ret;
}

HI_S32 PQ_MNG_InitPhyList(HI_U32 u32ID, HI_PQ_MODULE_E enModule, PQ_SOURCE_MODE_E enSourceMode, PQ_OUTPUT_MODE_E enOutputMode)
{
    S_CAS_REGS_TYPE* pstVpssVirReg = HI_NULL;
    S_VDP_REGS_TYPE* pVdpVirReg    = NULL;
    HI_U32 i;
    HI_U32 u32Addr, u32Value, u32Module;
    HI_U32 u32RegValue = 0;
    HI_U32 u32OffsetAddr = 0x0;
    HI_U32 u32StartPos = 0;
    HI_U32 u32EndPos = 0;
    HI_U8  u8Lsb, u8Msb, u8SourceMode, u8OutputMode;

    PQ_CHECK_NULL_PTR(sg_pstPhyReg);

    u32StartPos = sg_astBinPos[enModule].u32StartPos;
    u32EndPos = sg_astBinPos[enModule].u32EndPos;

    for (i = u32StartPos; i <= u32EndPos; i++)
    {
        u32Addr       = sg_pstPhyReg[i].u32RegAddr;
        u32Value      = sg_pstPhyReg[i].u32Value;
        u32Module     = sg_pstPhyReg[i].u32Module;
        u8Lsb         = sg_pstPhyReg[i].u8Lsb;
        u8Msb         = sg_pstPhyReg[i].u8Msb;
        u8SourceMode  = sg_pstPhyReg[i].u8SourceMode;
        u8OutputMode  = sg_pstPhyReg[i].u8OutputMode;
        u32OffsetAddr = u32Addr & REG_OFFSET_ADDR_MASK;

        if ((HI_U32)enModule != u32Module)
        {
            continue;
        }

        if ((SOURCE_MODE_NO != u8SourceMode) && (u8SourceMode != enSourceMode))
        {
            continue;
        }

        if ((OUTPUT_MODE_NO != u8OutputMode) && (u8OutputMode != enOutputMode))
        {
            continue;
        }

        if (REG_TYPE_VPSS == PQ_COMM_GetAlgTypeID(enModule))
        {
            pstVpssVirReg = PQ_HAL_GetVpssReg(u32ID);
            PQ_CHECK_NULL_PTR(pstVpssVirReg);

            u32RegValue = *((HI_U32*)((HI_VOID*)pstVpssVirReg + u32OffsetAddr));
            PQ_HAL_SetU32ByBit(&u32RegValue, u8Msb, u8Lsb, u32Value);
            *(HI_U32*)((HI_VOID*)pstVpssVirReg + u32OffsetAddr) = u32RegValue;
        }
        else if (REG_TYPE_VDP == PQ_COMM_GetAlgTypeID(enModule))
        {
            pVdpVirReg = PQ_HAL_GetVdpReg();
            PQ_CHECK_NULL_PTR(pVdpVirReg);

            if ((HI_PQ_MODULE_DB == enModule)
                || (HI_PQ_MODULE_DM == enModule)
                || (HI_PQ_MODULE_DR == enModule)
                || (HI_PQ_MODULE_DS == enModule)
                || (HI_PQ_MODULE_TNR == enModule)
                || (HI_PQ_MODULE_SNR == enModule))
            {
                //u32OffsetAddr += 0xB300;
                //u32OffsetAddr += 0xB000;
                continue;
            }

            u32RegValue = *((HI_U32*)((HI_VOID*)pVdpVirReg + u32OffsetAddr));
            PQ_HAL_SetU32ByBit(&u32RegValue, u8Msb, u8Lsb, u32Value);
            *(HI_U32*)((HI_VOID*)pVdpVirReg + u32OffsetAddr) = u32RegValue;
        }

        pqprint(PQ_PRN_TABLE, "InitPhyList, Addr:0x%x, Lsb:%d, Msb:%d, Source:%d, Output:%d, Module:%d, Value:%d\n", u32Addr, u8Lsb, u8Msb, u8SourceMode, u8OutputMode, u32Module, u32Value);
    }

    return HI_SUCCESS;
}

HI_VOID PQ_MNG_PrintTable(PQ_PRN_TABLE_TYPE_E enType, HI_U32 u32PriAddr)
{
#ifndef HI_ADVCA_FUNCTION_RELEASE
    HI_U32 i;
    HI_U32 u32Addr, u32Value, u32Module;
    HI_U8  u8Lsb, u8Msb, u8SourceMode, u8OutputMode;
    PQ_PHY_REG_S* pstReg   = sg_pstPhyReg;

    if (sg_pstPhyReg == HI_NULL)
    {
        return;
    }

    if (PRN_TABLE_SET_DEFAULT == enType)
    {
        if (sg_pstSoftReg == HI_NULL)
        {
            return;
        }

        memset(sg_pstPhyReg, 0, sizeof(PQ_PHY_REG_S)*PHY_REG_MAX);
        memset(sg_pstSoftReg, 0, sizeof(PQ_PHY_REG_S)*SOFT_REG_MAX);

        for (i = 0; i < PHY_REG_MAX; i++)
        {
            if ((0 == sg_stPhyReg[i].u32RegAddr)
                && (0 == sg_stPhyReg[i].u8Lsb)
                && (0 == sg_stPhyReg[i].u8Msb))
            {
                break;
            }
            sg_pstPhyReg[i] = sg_stPhyReg[i];
        }

        for (i = 0; i < SOFT_REG_MAX; i++)
        {
            if ((0 == sg_stPQSoftReg[i].u32RegAddr)
                && (0 == sg_stPQSoftReg[i].u8Lsb)
                && (0 == sg_stPQSoftReg[i].u8Msb))
            {
                break;
            }
            sg_pstSoftReg[i] = sg_stPQSoftReg[i];
        }

        HI_DRV_PROC_EchoHelper("set pqbin default from code success!\n");
        return;
    }

    HI_DRV_PROC_EchoHelper("\n");
    HI_DRV_PROC_EchoHelper("List\t");
    HI_DRV_PROC_EchoHelper("Addr\t");
    HI_DRV_PROC_EchoHelper("Lsb\t");
    HI_DRV_PROC_EchoHelper("Msb\t");
    HI_DRV_PROC_EchoHelper("SourceMode\t");
    HI_DRV_PROC_EchoHelper("OutputMode\t");
    HI_DRV_PROC_EchoHelper("Module\t");
    HI_DRV_PROC_EchoHelper("Value\t");

    for (i = 0; i < sg_u32PhyListNum; i++)
    {
        u32Addr       = pstReg[i].u32RegAddr;
        u32Value      = pstReg[i].u32Value;
        u32Module     = pstReg[i].u32Module;
        u8Lsb         = pstReg[i].u8Lsb;
        u8Msb         = pstReg[i].u8Msb;
        u8SourceMode  = pstReg[i].u8SourceMode;
        u8OutputMode  = pstReg[i].u8OutputMode;

        if ((PRN_TABLE_SINGLE == enType) && (u32PriAddr != u32Addr))
        {
            continue;
        }
        else if ((PRN_TABLE_MULTI == enType) && (PQ_BIN_ADAPT_MULTIPLE != PQ_COMM_GetAlgAdapeType(u32Module)))
        {
            continue;
        }
        else if ((PRN_TABLE_ALG == enType) && (u32PriAddr != u32Module))
        {
            continue;
        }

        HI_DRV_PROC_EchoHelper("\n");
        HI_DRV_PROC_EchoHelper("[%d]\t", i);
        HI_DRV_PROC_EchoHelper("0x%x\t", u32Addr);
        HI_DRV_PROC_EchoHelper("%d\t", u8Lsb);
        HI_DRV_PROC_EchoHelper("%d\t", u8Msb);
        HI_DRV_PROC_EchoHelper("%d\t\t", u8SourceMode);
        HI_DRV_PROC_EchoHelper("%d\t\t", u8OutputMode);
        HI_DRV_PROC_EchoHelper("0x%x\t", u32Module);
        HI_DRV_PROC_EchoHelper("%d\t", u32Value);

    }

    HI_DRV_PROC_EchoHelper("\n");
    HI_DRV_PROC_EchoHelper("\n");

#endif
}

HI_VOID PQ_MNG_SetTable(HI_U32 u32List, HI_U32 u32Value)
{
#ifndef HI_ADVCA_FUNCTION_RELEASE
    HI_U32 u32Addr, u32OldValue, u32Module;
    HI_U8  u8Lsb, u8Msb, u8SourceMode, u8OutputMode;

    if (sg_pstPhyReg == HI_NULL)
    {
        return;
    }

    if (u32List > sg_u32PhyListNum)
    {
        return;
    }

    HI_DRV_PROC_EchoHelper("\n");
    HI_DRV_PROC_EchoHelper("List\t");
    HI_DRV_PROC_EchoHelper("Addr\t");
    HI_DRV_PROC_EchoHelper("Lsb\t");
    HI_DRV_PROC_EchoHelper("Msb\t");
    HI_DRV_PROC_EchoHelper("SourceMode\t");
    HI_DRV_PROC_EchoHelper("OutputMode\t");
    HI_DRV_PROC_EchoHelper("Module\t");
    HI_DRV_PROC_EchoHelper("Value\t");

    u32Addr       = sg_pstPhyReg[u32List].u32RegAddr;
    u32OldValue   = sg_pstPhyReg[u32List].u32Value;
    u32Module     = sg_pstPhyReg[u32List].u32Module;
    u8Lsb         = sg_pstPhyReg[u32List].u8Lsb;
    u8Msb         = sg_pstPhyReg[u32List].u8Msb;
    u8SourceMode  = sg_pstPhyReg[u32List].u8SourceMode;
    u8OutputMode  = sg_pstPhyReg[u32List].u8OutputMode;

    HI_DRV_PROC_EchoHelper("\n");
    HI_DRV_PROC_EchoHelper("[%d]\t", u32List);
    HI_DRV_PROC_EchoHelper("0x%x\t", u32Addr);
    HI_DRV_PROC_EchoHelper("%d\t", u8Lsb);
    HI_DRV_PROC_EchoHelper("%d\t", u8Msb);
    HI_DRV_PROC_EchoHelper("%d\t\t", u8SourceMode);
    HI_DRV_PROC_EchoHelper("%d\t\t", u8OutputMode);
    HI_DRV_PROC_EchoHelper("0x%x\t", u32Module);
    HI_DRV_PROC_EchoHelper("%d to %d\n", u32OldValue, u32Value);

    sg_pstPhyReg[u32List].u32Value = u32Value;
#endif

    return;
}

HI_U32 PQ_MNG_GetSoftTable(HI_U32 u32Lut, PQ_SOURCE_MODE_E enSourceMode, PQ_OUTPUT_MODE_E enOutputMode, HI_U32 u32DefaultValue)
{
    HI_S32 i;
    HI_U32 u32Addr, u32Value;
    HI_U8  u8SourceMode, u8OutputMode;

    PQ_CHECK_NULL_PTR(sg_pstSoftReg);

    for (i = 0; i < sg_u32SoftListNum;  i++)
    {
        u32Addr       = sg_pstSoftReg[i].u32RegAddr;
        u32Value      = sg_pstSoftReg[i].u32Value;
        u8SourceMode  = sg_pstSoftReg[i].u8SourceMode;
        u8OutputMode  = sg_pstSoftReg[i].u8OutputMode;

        if (HI_FALSE == PQ_HAL_IsSpecialReg(u32Addr))
        {
            break;
        }

        if (u32Addr != u32Lut)
        {
            continue;
        }

        if ((SOURCE_MODE_NO != u8SourceMode) && (u8SourceMode != enSourceMode))
        {
            continue;
        }

        if ((OUTPUT_MODE_NO != u8OutputMode) && (u8OutputMode != enOutputMode))
        {
            continue;
        }

        return u32Value;

    }

    return u32DefaultValue;

}

HI_S32 PQ_MNG_SetSoftTable(HI_U32 u32Lut, PQ_SOURCE_MODE_E enSourceMode, PQ_OUTPUT_MODE_E enOutputMode, HI_U32 u32Value)
{
    HI_S32 i;
    HI_U32 u32Addr;
    HI_U8  u8SourceMode, u8OutputMode;

    PQ_CHECK_NULL_PTR(sg_pstSoftReg);

    for (i = 0; i < sg_u32SoftListNum;  i++)
    {
        u32Addr       = sg_pstSoftReg[i].u32RegAddr;
        u8SourceMode  = sg_pstSoftReg[i].u8SourceMode;
        u8OutputMode  = sg_pstSoftReg[i].u8OutputMode;

        if (u32Addr != u32Lut)
        {
            continue;
        }

        if ((SOURCE_MODE_NO != u8SourceMode) && (u8SourceMode != enSourceMode))
        {
            continue;
        }

        if ((OUTPUT_MODE_NO != u8OutputMode) && (u8OutputMode != enOutputMode))
        {
            continue;
        }

        sg_pstSoftReg[i].u32Value = u32Value;
        return HI_SUCCESS;
    }

    return HI_FAILURE;
}

HI_U32 PQ_MNG_GetArraySoftTable(HI_U32 u32Lut, HI_U32* pArray, HI_U32 u32Num, PQ_SOURCE_MODE_E enSourceMode, PQ_OUTPUT_MODE_E enOutputMode, HI_U32 u32DefaultArray[])
{
    HI_S32 i;
    HI_U32 u32Addr, u32Value;
    HI_U8  u8Lsb, u8Msb, u8Widthsb, u8SourceMode, u8OutputMode;
    static HI_U32 u32ArrayNum = 0;

    PQ_CHECK_NULL_PTR(sg_pstSoftReg);

    for (i = 0; i < sg_u32SoftListNum;  i++)
    {
        u32Addr       = sg_pstSoftReg[i].u32RegAddr;
        u32Value      = sg_pstSoftReg[i].u32Value;
        u8Lsb         = sg_pstSoftReg[i].u8Lsb;
        u8Msb         = sg_pstSoftReg[i].u8Msb;
        u8SourceMode  = sg_pstSoftReg[i].u8SourceMode;
        u8OutputMode  = sg_pstSoftReg[i].u8OutputMode;

        if (HI_FALSE == PQ_HAL_IsSpecialReg(u32Addr))
        {
            break;
        }

        if (u32Addr != u32Lut)
        {
            continue;
        }

        if ((SOURCE_MODE_NO != u8SourceMode) && (u8SourceMode != enSourceMode))
        {
            continue;
        }

        if ((OUTPUT_MODE_NO != u8OutputMode) && (u8OutputMode != enOutputMode))
        {
            continue;
        }

        if (u8Lsb > u8Msb)
        {
            break;
        }
        else
        {
            u8Widthsb = u8Msb - u8Lsb + 1;
        }

        if ((u8Lsb / u8Widthsb) > u32Num - 1)
        {
            break;
        }

        *(pArray + (u8Lsb / u8Widthsb)) = u32Value; /* Length need to divide Bits Width */
        u32ArrayNum++;

        /* compare to u32Num, but not u32Num-1, after every loop calc u32ArrayNum++ */
        if (u32ArrayNum >= u32Num)
        {
            u32ArrayNum = 0;
            return HI_SUCCESS;
        }

    }

    memcpy(pArray, u32DefaultArray, u32Num * sizeof(HI_U32));
    return HI_SUCCESS;
}

HI_S32 PQ_MNG_SetReg(HI_PQ_REGISTER_S* pstAttr, PQ_SOURCE_MODE_E enSourceMode, PQ_OUTPUT_MODE_E enOutputMode)
{
    HI_S32 s32Ret = HI_FAILURE;
    HI_S32 s32Num = -1;

    PQ_CHECK_NULL_PTR(sg_pstPhyReg);

    if (PQ_HAL_IsSpecialReg(pstAttr->u32RegAddr) == HI_TRUE)
    {
        s32Ret = PQ_MNG_SetSoftTable(pstAttr->u32RegAddr, pstAttr->u8SourceMode, \
                                     pstAttr->u8OutputMode, pstAttr->u32Value);

        return s32Ret;
    }

    s32Num = PQ_MNG_UpdatePhyList(pstAttr->u32RegAddr, pstAttr->u8Lsb, pstAttr->u8Msb, \
                                  pstAttr->u8SourceMode, pstAttr->u8OutputMode, pstAttr->u32Value);
    if (HI_FAILURE == s32Num)
    {
        pqprint(PQ_PRN_TABLE, "Warning! not find Register[Address:0x%x, Bit:%d~%d],SourceMode:[%d],OutputMode:[%d]\n", \
                pstAttr->u32RegAddr, pstAttr->u8Lsb, pstAttr->u8Msb, pstAttr->u8SourceMode, pstAttr->u8OutputMode);
    }
    else
    {
        if ((SOURCE_MODE_NO != sg_pstPhyReg[s32Num].u8SourceMode) \
            && (pstAttr->u8SourceMode != enSourceMode))
        {
            HI_ERR_PQ("Current Source Mode:[%d], Set Source Mode:[%d],Not Set Physical Reg\n", \
                      enSourceMode, pstAttr->u8SourceMode);
            return HI_SUCCESS;
        }

        if ((OUTPUT_MODE_NO != sg_pstPhyReg[s32Num].u8OutputMode) \
            && (pstAttr->u8OutputMode != enOutputMode))
        {
            HI_ERR_PQ("Current Output Mode:[%d], Set Output Mode:[%d],Not Set Physical Reg\n", \
                      enOutputMode, pstAttr->u8OutputMode);
            return HI_SUCCESS;
        }
    }

    if (PQ_MNG_IsSelVdpReg(pstAttr->u32RegAddr) == HI_TRUE)
    {
        s32Ret = PQ_MNG_SetSelVdpReg(pstAttr->u32RegAddr, pstAttr->u8Lsb, \
                                     pstAttr->u8Msb, pstAttr->u32Value);
        return s32Ret;
    }

    if (PQ_HAL_IsVpssReg(pstAttr->u32RegAddr) == HI_TRUE)
    {
        s32Ret = PQ_MNG_SetVpssReg(pstAttr->u32RegAddr, pstAttr->u8Lsb, \
                                   pstAttr->u8Msb, pstAttr->u32Value);
    }
    else if (PQ_HAL_IsVdpReg(pstAttr->u32RegAddr) == HI_TRUE)
    {
        s32Ret = PQ_MNG_SetVdpReg(pstAttr->u32RegAddr, pstAttr->u8Lsb, \
                                  pstAttr->u8Msb, pstAttr->u32Value);
    }
    else
    {
        HI_ERR_PQ("not VPSS/VDP/Special Register!\n");
        return HI_FAILURE;
    }

    return s32Ret;
}

HI_S32 PQ_MNG_GetReg(HI_PQ_REGISTER_S* pstAttr)
{
    HI_U32 u32Addr, u32Value;
    HI_U8  u8Lsb, u8Msb, u8SourceMode, u8OutputMode;
    HI_U32 i;

    PQ_CHECK_NULL_PTR(sg_pstPhyReg);

    if (PQ_HAL_IsSpecialReg(pstAttr->u32RegAddr) == HI_TRUE)
    {
        pstAttr->u32Value = PQ_MNG_GetSoftTable(pstAttr->u32RegAddr, pstAttr->u8SourceMode, pstAttr->u8OutputMode, 0);
        return HI_SUCCESS;
    }

    for (i = 0; i < sg_u32PhyListNum; i++)
    {
        u32Addr       = sg_pstPhyReg[i].u32RegAddr;
        u32Value      = sg_pstPhyReg[i].u32Value;
        u8Lsb         = sg_pstPhyReg[i].u8Lsb;
        u8Msb         = sg_pstPhyReg[i].u8Msb;
        u8SourceMode  = sg_pstPhyReg[i].u8SourceMode;
        u8OutputMode  = sg_pstPhyReg[i].u8OutputMode;

        if (u32Addr != (pstAttr->u32RegAddr & REG_OFFSET_ADDR_MASK))
        {
            continue;
        }

        if (u8Lsb != pstAttr->u8Lsb)
        {
            continue;
        }

        if (u8Msb != pstAttr->u8Msb)
        {
            continue;
        }

        if ((SOURCE_MODE_NO != u8SourceMode) && (u8SourceMode != pstAttr->u8SourceMode))
        {
            continue;
        }

        if ((OUTPUT_MODE_NO != u8OutputMode) && (u8OutputMode != pstAttr->u8OutputMode))
        {
            continue;
        }

        pstAttr->u32Value = u32Value;
        return HI_SUCCESS;
    }

    HI_ERR_PQ("Error! not find Phy Register List[Address:0x%x, Bit:%d~%d],SourceMode:[%d], OutputMode:[%d]\n", \
              pstAttr->u32RegAddr, pstAttr->u8Lsb, pstAttr->u8Msb, pstAttr->u8SourceMode, pstAttr->u8OutputMode);

    return HI_FAILURE;
}

HI_S32 PQ_MNG_FindBinPos(HI_PQ_MODULE_E enModule, HI_U32* pu32StartPos, HI_U32* pu32EndPos)
{
    *pu32StartPos = sg_astBinPos[enModule].u32StartPos;
    *pu32EndPos = sg_astBinPos[enModule].u32EndPos;

    return HI_SUCCESS;
}


