/******************************************************************************
*
* Copyright (C) 2015 Hisilicon Technologies Co., Ltd.  All rights reserved. 
*
* This program is confidential and proprietary to Hisilicon  Technologies Co., Ltd. (Hisilicon), 
* and may not be copied, reproduced, modified, disclosed to others, published or used, in
* whole or in part, without the express prior written permission of Hisilicon.
*
******************************************************************************
File Name	    : hi_gfx_smmu.h
Version		    : version 1.0
Author		    : 
Created		    : 2015/08/25
Description	    : Describes adp file. CNcomment:驱动跨平台适配 CNend\n

				 SMMU调试:
				 将调试工具btools放到单板的/目录下
				 ln -fs btools hismm
				 ln -fs btools hismd
				 然后就可以用这个命令操作mmu地址了
				 hismd.l 0xf8c4f208
				 hismd.l 0xf8c4f20c
				 hismd.l 0xf8c4f304
				 hismd.l 0xf8c4f308
Function List 	:
History       	:
Date				Author        		Modification
2015/08/25		    y00181162  		    
******************************************************************************/


#ifndef  _HI_GFX_SMMU_H_
#define  _HI_GFX_SMMU_H_


#ifdef __cplusplus
 #if __cplusplus
extern "C" {
 #endif /* __cplusplus */
#endif  /* __cplusplus */


/***************************** SDK Version Macro Definition *********************/

/** \addtogroup 	GFX COMM */
/** @{ */  /** <!-- 【GFX COMM】 */


/** @} */	/*! <!-- Macro Definition end */


/*********************************add include here******************************/
#include "hi_type.h"

/***************************** Macro Definition ******************************/

/** \addtogroup 	GFX SMMU */
/** @{ */  /** <!-- 【GFX SMMU】 */



/** @} */	/*! <!-- Macro Definition end */


/*************************** Enum Definition ****************************/

/** \addtogroup 	 GFX SMMU */
/** @{ */  /** <!-- 【GFX SMMU】 */


/** @} */  /*! <!-- enum Definition end */

/*************************** Structure Definition ****************************/

#ifdef CONFIG_GFX_MMU_SUPPORT

/** \addtogroup 	 GFX SMMU */
/** @{ */  /** <!-- 【GFX SMMU】 */

typedef union
{
	struct
	{
		HI_U32 glb_bypass	:	1;
		HI_U32 reserved1	:	2;
		HI_U32 int_en		:	1;
		HI_U32 reserved2	:	12;
		HI_U32 ptw_pf		:	4;
		HI_U32 reserved3	:	12;
	}bits;
	HI_U32 u32Value;
}SMMU_SCR_U;

typedef union
{
	struct
	{
		HI_U32 auto_clk_gt_en	:	1;
		HI_U32 reserved1		:	1;
		HI_U32 smmu_idle		:	1;
		HI_U32 reserved2		:	29;
	}bits;
	HI_U32 u32Value;
}SMMU_LP_CTRL_U;

typedef union
{
	struct
	{
		HI_U32 int_tlbmiss_msk			:	1;
		HI_U32 int_ptw_trans_msk		:	1;
		HI_U32 int_tlbinvalid_msk		:	1;
		HI_U32 reserved1				:	29;
	}bits;
	HI_U32 u32Value;
}SMMU_INTMASK_U;

typedef union
{
	struct
	{
		HI_U32 int_tlbmiss_raw			:	1;
		HI_U32 int_ptw_trans_raw		:	1;
		HI_U32 int_tlbinvalid_raw		:	1;
		HI_U32 reserved1				:	29;
	}bits;
	HI_U32 u32Value;
}SMMU_INTRAW_U;

typedef union
{
	struct
	{
		HI_U32 SMMU_INTSTAT_S			:	1;
		HI_U32 int_ptw_trans_stat		:	1;
		HI_U32 int_tlbinvalid_stat		:	1;
		HI_U32 reserved1				:	29;
	}bits;
	HI_U32 u32Value;
}SMMU_INTSTAT_U;

typedef union
{
	struct
	{
		HI_U32 SMMU_INTCLR_S			:	1;
		HI_U32 int_ptw_trans_clr		:	1;
		HI_U32 int_tlbinvalid_clr		:	1;
		HI_U32 reserved1				:	29;
	}bits;
	HI_U32 u32Value;
}SMMU_INTCLR_U;


typedef struct 
{
	SMMU_SCR_U                uScr;                   /** 0x00 **/
	HI_U32                    u32Reserved1;           /** 0x04 **/
	SMMU_LP_CTRL_U            uLpCtrl;                /** 0x08 **/
	HI_U32                    u32Reserved2;           /** 0x0c **/
	SMMU_INTMASK_U            uIntMaskSafe;           /** 0x10 **/
	SMMU_INTRAW_U             uIntRawSafe;            /** 0x14 **/
	SMMU_INTSTAT_U            uIntStatSafe;           /** 0x18 **/
	SMMU_INTCLR_U             uIntClrSafe;            /** 0x1c **/
	SMMU_INTMASK_U            uIntMask;               /** 0x20 **/
	SMMU_INTRAW_U             uIntRaw;                /** 0x24 **/
	SMMU_INTSTAT_U            uIntStat;               /** 0x28 **/
	SMMU_INTCLR_U             uIntClr;                /** 0x2c **/
	HI_U32                    u32Reserved3[118];
	HI_U32                    u32ScbTtbr;
	HI_U32                    u32CbTtbr;
	HI_U32                    u32Reserved4[61];
	HI_U32                    u32ErrRdAddr;
	HI_U32                    u32ErrWrAddr;
	HI_U32                    u32Reserved5;
	HI_U32                    u32FaultAddrPtwSafe;
	HI_U32                    u32FaultIdPtwSafe;
	HI_U32                    u32Reserved6[2];
	HI_U32                    u32FaultAddrPtw;
	HI_U32                    u32FaultIdPtw;
	HI_U32                    u32FaultPtwNum;
	HI_U32                    u32Reserved7;
	HI_U32                    u32FaultAddrWrSafe;
	HI_U32                    u32FaultTlbWrSafe;
	HI_U32                    u32FaultIdWrSafe;
	HI_U32                    u32Reserved8;
	HI_U32                    u32FaultAddrWr;
	HI_U32                    u32FaultTlbWr;
	HI_U32                    u32FaultIdWr;
	HI_U32                    u32Reserved9;
	HI_U32                    u32FaultAddrRdSafe;
	HI_U32                    u32FaultTlbRdSafe;
	HI_U32                    u32FaultIdRdSafe;
	HI_U32                    u32Reserved10;
	HI_U32                    u32FaultAddrRd;
	HI_U32                    u32FaultTlbRd;
	HI_U32                    u32FaultIdRd;
	HI_U32                    u32FaultTbuInfo;
	HI_U32                    u32FaultTbuDbg;
	HI_U32                    u32PrefBufEmpty;
	HI_U32                    u32PtwqIdle;
	HI_U32                    u32ResetState;
	HI_U32                    u32MasterDbg0;
	HI_U32                    u32MasterDbg1;
	HI_U32                    u32MasterDbg2;
	HI_U32                    u32MasterDbg3;
}GFX_MMU_REG_S;


/** @} */  /*! <!-- Structure Definition end */


/********************** Global Variable declaration **************************/

static volatile GFX_MMU_REG_S *s_pstMmuReg = NULL;

#endif


/******************************* API declaration *****************************/


/***************************************************************************
* func          : HI_GFX_InitSmmu
* description   : init smmu, open smmu while work
                  CNcomment: 在工作的时候才打开smmu，低功耗策略 CNend\n
* retval        : HI_SUCCESS 成功
* retval        : HI_FAILURE 失败
* others:       : NA
****************************************************************************/
static inline HI_S32 HI_GFX_InitSmmu(HI_U32 u32SmmuAddr)
{
#ifdef CONFIG_GFX_MMU_SUPPORT
    HI_U32 u32CbTtbr    = 0;
    HI_U32 u32ErrRdAddr = 0;
    HI_U32 u32ErrWrAddr = 0;
    
    if (NULL == s_pstMmuReg){
		s_pstMmuReg = (volatile GFX_MMU_REG_S*)ioremap_nocache(u32SmmuAddr, sizeof(GFX_MMU_REG_S));
	}
	if (NULL == s_pstMmuReg){
		return HI_FAILURE;
	}
	s_pstMmuReg->uScr.bits.glb_bypass = 0x0;
	s_pstMmuReg->uScr.bits.int_en     = 0x1;
    
	/** 启动内核然后读寄存器，比如himd.l 0xf8c40000 + 0xf000 + 0x20c，并在这里配置 **/
    HI_DRV_SMMU_GetPageTableAddr(&u32CbTtbr, &u32ErrRdAddr, &u32ErrWrAddr);
    s_pstMmuReg->u32ScbTtbr   = u32CbTtbr;      /** 208 安全页表基地址     **/
	s_pstMmuReg->u32CbTtbr    = u32CbTtbr;      /** 20c 非安全页表基地址   **/
	s_pstMmuReg->u32ErrRdAddr = u32ErrRdAddr;   /** 304 读通道地址转换错误 **/
	s_pstMmuReg->u32ErrWrAddr = u32ErrWrAddr;   /** 308 写通道地址转换错误 **/
    //HI_PRINT("====u32CbTtbr = 0x%x, u32ErrRdAddr= 0x%x, u32ErrWrAddr = 0x%x\n",u32CbTtbr,u32ErrRdAddr,u32ErrWrAddr);
#endif
	return HI_SUCCESS;
}

/***************************************************************************
* func          : HI_GFX_DeinitSmmu
* description   : dinit smmu, close smmu while not work
                  CNcomment: 不工作的时候关闭smmu，低功耗策略 CNend\n
* retval        : HI_SUCCESS 成功
* retval        : HI_FAILURE 失败
* others:       : NA
****************************************************************************/
static inline HI_S32 HI_GFX_DeinitSmmu(HI_VOID)
{
#if 0
#ifdef CONFIG_GFX_MMU_SUPPORT
	if (NULL == s_pstMmuReg){
		return HI_FAILURE;
	}
	s_pstMmuReg->uScr.bits.glb_bypass = 0x1;
	s_pstMmuReg->uScr.bits.int_en     = 0x0;

    iounmap((HI_VOID*)s_pstMmuReg);
    s_pstMmuReg = NULL;
    
#endif
#endif
	return HI_SUCCESS;
}

/***************************************************************************
* func          : HI_GFX_SmmuIsr
* description   : irq of smmu
                  CNcomment: smmu中断处理
                             0x10 ~ 0x1c 安全中断处理，对应着
                             0x20 ~ 0x2c 非安全中断处理 CNend\n
* retval        : HI_SUCCESS 成功
* retval        : HI_FAILURE 失败
* others:       : NA
****************************************************************************/
static inline HI_S32 HI_GFX_SmmuIsr(HI_CHAR* pErrType)
{
#ifdef CONFIG_GFX_MMU_SUPPORT
    if (NULL == s_pstMmuReg){
        //HI_PRINT("===s_pstMmuReg is null !!!\n");
		return HI_FAILURE;
	}
    /**
     **这里需要清除中断，否则会狂报中断导致CPU系统卡死而不是总线挂死
     **/
    if(0 != s_pstMmuReg->uIntRawSafe.u32Value || 0 != s_pstMmuReg->uIntStatSafe.u32Value){
        HI_PRINT("SMMU_WRITE_ERR MODULE : %s  raw safe value : 0x%x stat safe value : 0x%x\n",pErrType,s_pstMmuReg->uIntRawSafe.u32Value, s_pstMmuReg->uIntStatSafe.u32Value);
        s_pstMmuReg->uIntClr.u32Value     |= 0x7;
        s_pstMmuReg->uIntClrSafe.u32Value |= 0x7;
        return HI_FAILURE;
    }
    if(0 != s_pstMmuReg->uIntRaw.u32Value || 0 != s_pstMmuReg->uIntStat.u32Value){
        HI_PRINT("SMMU_WRITE_ERR MODULE : %s  int raw value : 0x%x int stat value : 0x%x\n",pErrType,s_pstMmuReg->uIntRaw.u32Value, s_pstMmuReg->uIntStat.u32Value);
        s_pstMmuReg->uIntClr.u32Value     |= 0x7;
        s_pstMmuReg->uIntClrSafe.u32Value |= 0x7;
        return HI_FAILURE;
    }
    /**
     ** SMMU非安全中断清除寄存器，这里清中断
     **/
    //s_pstMmuReg->uIntClrSafe.u32Value |= 0x7;
	//s_pstMmuReg->uIntClr.u32Value     |= 0x7;
#endif
	return HI_SUCCESS;
}

/** \addtogroup 	 GFX SMMU */
/** @{ */  /** <!-- 【GFX SMMU】 */


/** @} */  /*! <!-- API declaration end */

#ifdef __cplusplus
 #if __cplusplus
}
 #endif /* __cplusplus */
#endif  /* __cplusplus */

#endif /**_HI_GFX_SMMU_H_         *\*/
