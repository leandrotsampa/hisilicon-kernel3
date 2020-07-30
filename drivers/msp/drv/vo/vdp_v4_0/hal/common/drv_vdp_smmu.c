/******************************************************************************
*
* Copyright (C) 2015 Hisilicon Technologies Co., Ltd.  All rights reserved. 
*
* This program is confidential and proprietary to Hisilicon  Technologies Co., Ltd. (Hisilicon), 
* and may not be copied, reproduced, modified, disclosed to others, published or used, in
* whole or in part, without the express prior written permission of Hisilicon.
*
******************************************************************************
File Name	    : hi_vdp_smmu.h
Version		    : version 1.0
Author		    : 
Created		    : 2015/08/25
Description	    : Describes adp file. 
Function List 	:
History       	:
Date				Author        		Modification
2015/08/25		    w00217574  		    
******************************************************************************/


#ifndef  _HI_VDP_SMMU_H_
#define  _HI_VDP_SMMU_H_


#ifdef __cplusplus
 #if __cplusplus
extern "C" {
 #endif /* __cplusplus */
#endif  /* __cplusplus */


#include "hi_type.h"
#include "hi_drv_mmz.h"
#include "hi_drv_struct.h"


#include "vdp_hal_mmu.h"
#include "drv_disp_com.h"

/***************************** Macro Definition ******************************/


/******************************* API declaration *****************************/

HI_S32 VDP_Hal_SetSmmuScbTtbr(HI_S32 u32ScbTtbr)
{

#ifdef CFG_VDP_MMU_SUPPORT
	VDP_SMMU_SetScbTtbr(u32ScbTtbr);
#endif

	return HI_SUCCESS;
}
HI_S32 VDP_Hal_SetSmmuCbTtbr(HI_S32 u32CbTtbr)
{

#ifdef CFG_VDP_MMU_SUPPORT
	VDP_SMMU_SetCbTtbr(u32CbTtbr);
#endif

	return HI_SUCCESS;
}
HI_S32 VDP_Hal_SetSmmuErrRdAddr(HI_S32 u32ErrRdAddr)
{
#ifdef CFG_VDP_MMU_SUPPORT
	VDP_SMMU_SetErrRdAddr(u32ErrRdAddr);
#endif
	return HI_SUCCESS;

}
HI_S32 VDP_Hal_SetSmmuErrWrAddr(HI_S32 u32ErrWrAddr)
{

#ifdef CFG_VDP_MMU_SUPPORT
	VDP_SMMU_SetErrWrAddr(u32ErrWrAddr);
#endif

	return HI_SUCCESS;
}

HI_VOID VDP_Hal_ClearSMMUInt(HI_S32 u32State)
{

#ifdef CFG_VDP_MMU_SUPPORT
	VDP_SMMU_SetIntnsPtwTransClr((HI_U32)HI_TRUE);
	VDP_SMMU_SetIntnsTlbinvalidClr((HI_U32)HI_TRUE);
	VDP_SMMU_SetIntnsTlbmissClr((HI_U32)HI_TRUE);
	
	VDP_SMMU_SetIntsPtwTransClr((HI_U32)HI_TRUE);
	VDP_SMMU_SetIntsTlbinvalidClr((HI_U32)HI_TRUE);
	VDP_SMMU_SetIntsTlbmissClr((HI_U32)HI_TRUE);

#endif
}

HI_VOID VDP_Hal_SetSMMUIntEnable(HI_BOOL bEnable)
{

#ifdef CFG_VDP_MMU_SUPPORT
	if (bEnable)
	{
		VDP_SMMU_SetIntEn(HI_TRUE);
		
		VDP_SMMU_SetIntsTlbinvalidMsk(HI_FALSE);
		VDP_SMMU_SetIntsPtwTransMsk(HI_FALSE);
		VDP_SMMU_SetIntsTlbmissMsk(HI_FALSE);
		
		VDP_SMMU_SetIntnsTlbinvalidMsk(HI_FALSE);
		VDP_SMMU_SetIntnsPtwTransMsk(HI_FALSE);
		VDP_SMMU_SetIntnsTlbmissMsk(HI_FALSE);
		
	}
	else
	{
		VDP_SMMU_SetIntEn(HI_FALSE);
		
		VDP_SMMU_SetIntsTlbinvalidMsk(HI_TRUE);
		VDP_SMMU_SetIntsPtwTransMsk(HI_TRUE);
		VDP_SMMU_SetIntsTlbmissMsk(HI_TRUE);
		
		VDP_SMMU_SetIntnsTlbinvalidMsk(HI_TRUE);
		VDP_SMMU_SetIntnsPtwTransMsk(HI_TRUE);
		VDP_SMMU_SetIntnsTlbmissMsk(HI_TRUE);
	}
#endif

}

HI_VOID VDP_Hal_GetSMMUSta(HI_S32 *pu32State)
{

#ifdef CFG_VDP_MMU_SUPPORT
	HI_S32 SmmuSIntState = 0;
	HI_S32 SmmuNSIntState = 0;

	SmmuNSIntState = VDP_SMMU_GetIntnsPtwTransSta();
	SmmuNSIntState |= VDP_SMMU_GetIntnsTlbinvalidSta();
	SmmuNSIntState |= VDP_SMMU_GetIntnsTlbmissSta();
	
    if (SmmuNSIntState)
    {
        HI_PRINT("SMMU_WRITE_ERR MODULE : %s NSState : %#x\n",
            HI_MOD_VO,SmmuNSIntState);
    }
    
	SmmuSIntState |= VDP_SMMU_GetIntsPtwTransSta();
	SmmuSIntState |= VDP_SMMU_GetIntsTlbinvalidSta();
	SmmuSIntState |= VDP_SMMU_GetIntsTlbmissSta();

	if (SmmuSIntState)
    {
        HI_PRINT("SMMU_WRITE_ERR MODULE : %s SState : %#x\n",
            HI_MOD_VO,SmmuSIntState);
    }
    
	if (SmmuSIntState || SmmuNSIntState)
		*pu32State = 1;
	else
		*pu32State = 0;
#endif

}

HI_S32 VDP_Hal_SetSmmuEnable(HI_BOOL bEnable)
{
#ifdef CFG_VDP_MMU_SUPPORT
	HI_U32 u32CbTtbr;
	HI_U32 u32ErrRdAddr;
	HI_U32 u32ErrWrAddr;

	HI_DRV_SMMU_GetPageTableAddr(&u32CbTtbr, &u32ErrRdAddr, &u32ErrWrAddr);
    //printk("SMMU addr: 0x%x---0x%x,0x%x\n",u32CbTtbr,u32ErrRdAddr,u32ErrWrAddr);
	if (bEnable)
	{
		VDP_SMMU_SetGlbBypass(HI_FALSE);
		VDP_VID_SetAllRegionSmmuBypassDisable(0,0);
		VDP_VID_SetAllRegionSmmuBypassDisable(1,0);
		VDP_VID_SetAllRegionSmmuBypassDisable(3,0);
		
		//VDP_Hal_SetSmmuScbTtbr(u32CbTtbr);
		VDP_Hal_SetSmmuCbTtbr(u32CbTtbr);
		VDP_Hal_SetSmmuErrRdAddr(u32ErrRdAddr);
		VDP_Hal_SetSmmuErrWrAddr(u32ErrWrAddr);
	}
	else
	{
		VDP_SMMU_SetGlbBypass(HI_TRUE);
		VDP_VID_SetAllRegionSmmuBypassDisable(0,~0);
		VDP_VID_SetAllRegionSmmuBypassDisable(1,~0);
		VDP_VID_SetAllRegionSmmuBypassDisable(3,~0);
	}
	
	VDP_SMMU_SetIntEn(HI_TRUE);
#endif

	return HI_SUCCESS;
}


HI_VOID ISR_VDP_SmmuDebug(HI_VOID)
{
#ifdef CFG_VDP_MMU_SUPPORT
	if (VDP_SMMU_GetIntnsPtwTransSta())
	{
		printk("smmu err: nsPtwTrans\n");
	}
	if (VDP_SMMU_GetIntnsTlbinvalidSta())
	{
		printk("smmu err: nsTlbinvalid\n");
	}
	if (VDP_SMMU_GetIntnsTlbmissSta())
	{
		printk("smmu err: nsTlbmiss\n");
	}
	
	if (VDP_SMMU_GetIntsPtwTransSta())
	{
		printk("smmu err: sPtwTrans\n");
	}
	if (VDP_SMMU_GetIntsTlbinvalidSta())
	{
		printk("smmu err: sTlbinvalid\n");
	}
	if (VDP_SMMU_GetIntsTlbmissSta())
	{
		printk("smmu err: sTlbmiss\n");
	}

#endif

}

/** @} */  /*! <!-- API declaration end */

#ifdef __cplusplus
 #if __cplusplus
}
 #endif /* __cplusplus */
#endif  /* __cplusplus */

#endif /**_HI_VDP_SMMU_H_         *\*/
