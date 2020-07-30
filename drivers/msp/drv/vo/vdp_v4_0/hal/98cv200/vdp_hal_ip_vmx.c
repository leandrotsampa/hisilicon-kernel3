
#include "hi_type.h"
#include "vdp_hal_comm.h"
#include "vdp_hal_ip_vmx.h"

extern S_VDP_REGS_TYPE *pVdpReg;



HI_VOID VDP_VMX_SetVmxDwmEn(HI_U32 u32Data, HI_U32 dwm_en)
{
	U_V0_DWM_CTRL DWM_CTRL;
	
	if(u32Data >= VID_MAX)
	{
		VDP_PRINT("Error, VDP_VMX_SetVmxDwmEn Select Wrong Layer ID\n");
	}
	
	DWM_CTRL.u32 = VDP_RegRead(((HI_ULONG)&(pVdpReg->V0_DWM_CTRL.u32) + u32Data * VID_VMX_OFFSET));
	DWM_CTRL.bits.dwm_en = dwm_en;
	VDP_RegWrite(((HI_ULONG)&(pVdpReg->V0_DWM_CTRL.u32) + u32Data * VID_VMX_OFFSET),DWM_CTRL.u32);
	
	return ;
}


HI_VOID VDP_VMX_SetVmxBgEmbdEn(HI_U32 u32Data, HI_U32 bg_embd_en)
{
	U_V0_DWM_CTRL DWM_CTRL;
	
	if(u32Data >= VID_MAX)
	{
		VDP_PRINT("Error, VDP_VMX_SetVmxBgEmbdEn Select Wrong Layer ID\n");
	}
	
	DWM_CTRL.u32 = VDP_RegRead(((HI_ULONG)&(pVdpReg->V0_DWM_CTRL.u32) + u32Data * VID_VMX_OFFSET));
	DWM_CTRL.bits.bg_embd_en = bg_embd_en;
	VDP_RegWrite(((HI_ULONG)&(pVdpReg->V0_DWM_CTRL.u32) + u32Data * VID_VMX_OFFSET),DWM_CTRL.u32);
	
	return ;
}


HI_VOID VDP_VMX_SetVmxScale(HI_U32 u32Data, HI_U32 scale)
{
	U_V0_DWM_SYB_SCL DWM_SYB_SCL;
	
	if(u32Data >= VID_MAX)
	{
		VDP_PRINT("Error, VDP_VMX_SetVmxScale Select Wrong Layer ID\n");
	}
	
	DWM_SYB_SCL.u32 = VDP_RegRead(((HI_ULONG)&(pVdpReg->V0_DWM_SYB_SCL.u32) + u32Data * VID_VMX_OFFSET));
	DWM_SYB_SCL.bits.scale = scale;
	VDP_RegWrite(((HI_ULONG)&(pVdpReg->V0_DWM_SYB_SCL.u32) + u32Data * VID_VMX_OFFSET),DWM_SYB_SCL.u32);
	
	return ;
}


HI_VOID VDP_VMX_SetVmxWidth(HI_U32 u32Data, HI_U32 width)
{
	U_V0_DWM_SYB_ORESO DWM_SYB_ORESO;
	
	if(u32Data >= VID_MAX)
	{
		VDP_PRINT("Error, VDP_VMX_SetVmxWidth Select Wrong Layer ID\n");
	}
	
	DWM_SYB_ORESO.u32 = VDP_RegRead(((HI_ULONG)&(pVdpReg->V0_DWM_SYB_ORESO.u32) + u32Data * VID_VMX_OFFSET));
	DWM_SYB_ORESO.bits.width = width - 1;
	VDP_RegWrite(((HI_ULONG)&(pVdpReg->V0_DWM_SYB_ORESO.u32) + u32Data * VID_VMX_OFFSET),DWM_SYB_ORESO.u32);
	
	return ;
}


HI_VOID VDP_VMX_SetVmxHeight(HI_U32 u32Data, HI_U32 height)
{
	U_V0_DWM_SYB_ORESO DWM_SYB_ORESO;
	
	if(u32Data >= VID_MAX)
	{
		VDP_PRINT("Error, VDP_VMX_SetVmxHeight Select Wrong Layer ID\n");
	}
	
	DWM_SYB_ORESO.u32 = VDP_RegRead(((HI_ULONG)&(pVdpReg->V0_DWM_SYB_ORESO.u32) + u32Data * VID_VMX_OFFSET));
	DWM_SYB_ORESO.bits.height = height - 1;
	VDP_RegWrite(((HI_ULONG)&(pVdpReg->V0_DWM_SYB_ORESO.u32) + u32Data * VID_VMX_OFFSET),DWM_SYB_ORESO.u32);
	
	return ;
}


HI_VOID VDP_VMX_SetVmxSybYfpos(HI_U32 u32Data, HI_U32 syb_yfpos)
{
	U_V0_DWM_SYB_FPOS DWM_SYB_FPOS;
	
	if(u32Data >= VID_MAX)
	{
		VDP_PRINT("Error, VDP_VMX_SetVmxSybYfpos Select Wrong Layer ID\n");
	}
	
	DWM_SYB_FPOS.u32 = VDP_RegRead(((HI_ULONG)&(pVdpReg->V0_DWM_SYB_FPOS.u32) + u32Data * VID_VMX_OFFSET));
	DWM_SYB_FPOS.bits.syb_yfpos = syb_yfpos;
	VDP_RegWrite(((HI_ULONG)&(pVdpReg->V0_DWM_SYB_FPOS.u32) + u32Data * VID_VMX_OFFSET),DWM_SYB_FPOS.u32);
	
	return ;
}


HI_VOID VDP_VMX_SetVmxSybXfpos(HI_U32 u32Data, HI_U32 syb_xfpos)
{
	U_V0_DWM_SYB_FPOS DWM_SYB_FPOS;
	
	if(u32Data >= VID_MAX)
	{
		VDP_PRINT("Error, VDP_VMX_SetVmxSybXfpos Select Wrong Layer ID\n");
	}
	
	DWM_SYB_FPOS.u32 = VDP_RegRead(((HI_ULONG)&(pVdpReg->V0_DWM_SYB_FPOS.u32) + u32Data * VID_VMX_OFFSET));
	DWM_SYB_FPOS.bits.syb_xfpos = syb_xfpos;
	VDP_RegWrite(((HI_ULONG)&(pVdpReg->V0_DWM_SYB_FPOS.u32) + u32Data * VID_VMX_OFFSET),DWM_SYB_FPOS.u32);
	
	return ;
}


HI_VOID VDP_VMX_SetVmxSybYlpos(HI_U32 u32Data, HI_U32 syb_ylpos)
{
	U_V0_DWM_SYB_LPOS DWM_SYB_LPOS;
	
	if(u32Data >= VID_MAX)
	{
		VDP_PRINT("Error, VDP_VMX_SetVmxSybYlpos Select Wrong Layer ID\n");
	}
	
	DWM_SYB_LPOS.u32 = VDP_RegRead(((HI_ULONG)&(pVdpReg->V0_DWM_SYB_LPOS.u32) + u32Data * VID_VMX_OFFSET));
	DWM_SYB_LPOS.bits.syb_ylpos = syb_ylpos - 1;
	VDP_RegWrite(((HI_ULONG)&(pVdpReg->V0_DWM_SYB_LPOS.u32) + u32Data * VID_VMX_OFFSET),DWM_SYB_LPOS.u32);
	
	return ;
}


HI_VOID VDP_VMX_SetVmxSybXlpos(HI_U32 u32Data, HI_U32 syb_xlpos)
{
	U_V0_DWM_SYB_LPOS DWM_SYB_LPOS;
	
	if(u32Data >= VID_MAX)
	{
		VDP_PRINT("Error, VDP_VMX_SetVmxSybXlpos Select Wrong Layer ID\n");
	}
	
	DWM_SYB_LPOS.u32 = VDP_RegRead(((HI_ULONG)&(pVdpReg->V0_DWM_SYB_LPOS.u32) + u32Data * VID_VMX_OFFSET));
	DWM_SYB_LPOS.bits.syb_xlpos = syb_xlpos - 1;
	VDP_RegWrite(((HI_ULONG)&(pVdpReg->V0_DWM_SYB_LPOS.u32) + u32Data * VID_VMX_OFFSET),DWM_SYB_LPOS.u32);
	
	return ;
}


HI_VOID VDP_VMX_SetVmxSybVerNum(HI_U32 u32Data, HI_U32 syb_ver_num)
{
	U_V0_DWM_SYB_NUM DWM_SYB_NUM;
	
	if(u32Data >= VID_MAX)
	{
		VDP_PRINT("Error, VDP_VMX_SetVmxSybVerNum Select Wrong Layer ID\n");
	}
	
	DWM_SYB_NUM.u32 = VDP_RegRead(((HI_ULONG)&(pVdpReg->V0_DWM_SYB_NUM.u32) + u32Data * VID_VMX_OFFSET));
	DWM_SYB_NUM.bits.syb_ver_num = syb_ver_num - 1;
	VDP_RegWrite(((HI_ULONG)&(pVdpReg->V0_DWM_SYB_NUM.u32) + u32Data * VID_VMX_OFFSET),DWM_SYB_NUM.u32);
	
	return ;
}


HI_VOID VDP_VMX_SetVmxSybHorNum(HI_U32 u32Data, HI_U32 syb_hor_num)
{
	U_V0_DWM_SYB_NUM DWM_SYB_NUM;
	
	if(u32Data >= VID_MAX)
	{
		VDP_PRINT("Error, VDP_VMX_SetVmxSybHorNum Select Wrong Layer ID\n");
	}
	
	DWM_SYB_NUM.u32 = VDP_RegRead(((HI_ULONG)&(pVdpReg->V0_DWM_SYB_NUM.u32) + u32Data * VID_VMX_OFFSET));
	DWM_SYB_NUM.bits.syb_hor_num = syb_hor_num - 1;
	VDP_RegWrite(((HI_ULONG)&(pVdpReg->V0_DWM_SYB_NUM.u32) + u32Data * VID_VMX_OFFSET),DWM_SYB_NUM.u32);
	
	return ;
}


HI_VOID VDP_VMX_SetVmxSybVerSpac(HI_U32 u32Data, HI_U32 syb_ver_spac)
{
	U_V0_DWM_SYB_SPAC DWM_SYB_SPAC;
	
	if(u32Data >= VID_MAX)
	{
		VDP_PRINT("Error, VDP_VMX_SetVmxSybVerSpac Select Wrong Layer ID\n");
	}
	
	DWM_SYB_SPAC.u32 = VDP_RegRead(((HI_ULONG)&(pVdpReg->V0_DWM_SYB_SPAC.u32) + u32Data * VID_VMX_OFFSET));
	DWM_SYB_SPAC.bits.syb_ver_spac = syb_ver_spac;
	VDP_RegWrite(((HI_ULONG)&(pVdpReg->V0_DWM_SYB_SPAC.u32) + u32Data * VID_VMX_OFFSET),DWM_SYB_SPAC.u32);
	
	return ;
}


HI_VOID VDP_VMX_SetVmxSybHorSpac(HI_U32 u32Data, HI_U32 syb_hor_spac)
{
	U_V0_DWM_SYB_SPAC DWM_SYB_SPAC;
	
	if(u32Data >= VID_MAX)
	{
		VDP_PRINT("Error, VDP_VMX_SetVmxSybHorSpac Select Wrong Layer ID\n");
	}
	
	DWM_SYB_SPAC.u32 = VDP_RegRead(((HI_ULONG)&(pVdpReg->V0_DWM_SYB_SPAC.u32) + u32Data * VID_VMX_OFFSET));
	DWM_SYB_SPAC.bits.syb_hor_spac = syb_hor_spac;
	VDP_RegWrite(((HI_ULONG)&(pVdpReg->V0_DWM_SYB_SPAC.u32) + u32Data * VID_VMX_OFFSET),DWM_SYB_SPAC.u32);
	
	return ;
}


HI_VOID VDP_VMX_SetVmxLfreDirction(HI_U32 u32Data, HI_U32 dirction[3])
{
	U_V0_DWM_LFRE_DISTANCE DWM_LFRE_DISTANCE;
	
	if(u32Data >= VID_MAX)
	{
		VDP_PRINT("Error, VDP_VMX_SetVmxLfreDirction Select Wrong Layer ID\n");
	}
	
	DWM_LFRE_DISTANCE.u32 = VDP_RegRead(((HI_ULONG)&(pVdpReg->V0_DWM_LFRE_DISTANCE.u32) + u32Data * VID_VMX_OFFSET));
	DWM_LFRE_DISTANCE.bits.dirction_2 = dirction[2];
	DWM_LFRE_DISTANCE.bits.dirction_1 = dirction[1];
	DWM_LFRE_DISTANCE.bits.dirction_0 = dirction[0];
	VDP_RegWrite(((HI_ULONG)&(pVdpReg->V0_DWM_LFRE_DISTANCE.u32) + u32Data * VID_VMX_OFFSET),DWM_LFRE_DISTANCE.u32);
	
	return ;
}


HI_VOID VDP_VMX_SetVmxRfreDirction(HI_U32 u32Data, HI_U32 dirction[3])
{
	U_V0_DWM_RFRE_DISTANCE DWM_RFRE_DISTANCE;
	
	if(u32Data >= VID_MAX)
	{
		VDP_PRINT("Error, VDP_VMX_SetVmxRfreDirction Select Wrong Layer ID\n");
	}
	
	DWM_RFRE_DISTANCE.u32 = VDP_RegRead(((HI_ULONG)&(pVdpReg->V0_DWM_RFRE_DISTANCE.u32) + u32Data * VID_VMX_OFFSET));
	DWM_RFRE_DISTANCE.bits.dirction_2 = dirction[2];
	DWM_RFRE_DISTANCE.bits.dirction_1 = dirction[1];
	DWM_RFRE_DISTANCE.bits.dirction_0 = dirction[0];
	VDP_RegWrite(((HI_ULONG)&(pVdpReg->V0_DWM_RFRE_DISTANCE.u32) + u32Data * VID_VMX_OFFSET),DWM_RFRE_DISTANCE.u32);
	
	return ;
}


HI_VOID VDP_VMX_SetVmxTfreDirction(HI_U32 u32Data, HI_U32 dirction[3])
{
	U_V0_DWM_TFRE_DISTANCE DWM_TFRE_DISTANCE;
	
	if(u32Data >= VID_MAX)
	{
		VDP_PRINT("Error, VDP_VMX_SetVmxTopDirction Select Wrong Layer ID\n");
	}
	
	DWM_TFRE_DISTANCE.u32 = VDP_RegRead(((HI_ULONG)&(pVdpReg->V0_DWM_TFRE_DISTANCE.u32) + u32Data * VID_VMX_OFFSET));
	DWM_TFRE_DISTANCE.bits.dirction_2 = dirction[2];
	DWM_TFRE_DISTANCE.bits.dirction_1 = dirction[1];
	DWM_TFRE_DISTANCE.bits.dirction_0 = dirction[0];
	VDP_RegWrite(((HI_ULONG)&(pVdpReg->V0_DWM_TFRE_DISTANCE.u32) + u32Data * VID_VMX_OFFSET),DWM_TFRE_DISTANCE.u32);
	
	return ;
}


HI_VOID VDP_VMX_SetVmxFrequencyLine(HI_U32 u32Data, HI_U32 frequency_line)
{
	U_V0_DWM_FRE_NUM DWM_FRE_NUM;
	
	if(u32Data >= VID_MAX)
	{
		VDP_PRINT("Error, VDP_VMX_SetVmxFrequencyLine Select Wrong Layer ID\n");
	}
	
	DWM_FRE_NUM.u32 = VDP_RegRead(((HI_ULONG)&(pVdpReg->V0_DWM_FRE_NUM.u32) + u32Data * VID_VMX_OFFSET));
	DWM_FRE_NUM.bits.frequency_line = frequency_line;
	VDP_RegWrite(((HI_ULONG)&(pVdpReg->V0_DWM_FRE_NUM.u32) + u32Data * VID_VMX_OFFSET),DWM_FRE_NUM.u32);
	
	return ;
}


HI_VOID VDP_VMX_SetVmxFrequencyPix(HI_U32 u32Data, HI_U32 frequency_pix)
{
	U_V0_DWM_FRE_NUM DWM_FRE_NUM;
	
	if(u32Data >= VID_MAX)
	{
		VDP_PRINT("Error, VDP_VMX_SetVmxFrequencyPix Select Wrong Layer ID\n");
	}
	
	DWM_FRE_NUM.u32 = VDP_RegRead(((HI_ULONG)&(pVdpReg->V0_DWM_FRE_NUM.u32) + u32Data * VID_VMX_OFFSET));
	DWM_FRE_NUM.bits.frequency_pix = frequency_pix;
	VDP_RegWrite(((HI_ULONG)&(pVdpReg->V0_DWM_FRE_NUM.u32) + u32Data * VID_VMX_OFFSET),DWM_FRE_NUM.u32);
	
	return ;
}

HI_VOID VDP_VMX_SetVmxFrequencySpac(HI_U32 u32Data, HI_U32 frequency_spac)
{
	U_V0_DWM_FRE_NUM DWM_FRE_NUM;
	
	if(u32Data >= VID_MAX)
	{
		VDP_PRINT("Error, VDP_VMX_SetVmxFrequencySpac Select Wrong Layer ID\n");
	}
	
	DWM_FRE_NUM.u32 = VDP_RegRead(((HI_ULONG)&(pVdpReg->V0_DWM_FRE_NUM.u32) + u32Data * VID_VMX_OFFSET));
	DWM_FRE_NUM.bits.frequency_spac = frequency_spac;
	VDP_RegWrite(((HI_ULONG)&(pVdpReg->V0_DWM_FRE_NUM.u32) + u32Data * VID_VMX_OFFSET),DWM_FRE_NUM.u32);
	
	return ;
}

HI_VOID VDP_VMX_SetVmxSybStride(HI_U32 u32Data, HI_U32 sub_stride)
{
	U_V0_DWM_SYB_STRIDE DWM_SYB_STRIDE;
	
	if(u32Data >= VID_MAX)
	{
		VDP_PRINT("Error, VDP_VMX_SetVmxSybStride Select Wrong Layer ID\n");
	}
	
	DWM_SYB_STRIDE.u32 = VDP_RegRead(((HI_ULONG)&(pVdpReg->V0_DWM_SYB_STRIDE.u32) + u32Data * VID_VMX_OFFSET));
	DWM_SYB_STRIDE.bits.sub_stride = sub_stride;
	VDP_RegWrite(((HI_ULONG)&(pVdpReg->V0_DWM_SYB_STRIDE.u32) + u32Data * VID_VMX_OFFSET),DWM_SYB_STRIDE.u32);
	
	return ;
}


HI_VOID VDP_VMX_SetVmxStrenghMultiply(HI_U32 u32Data, HI_U32 strengh_multiply)
{
	U_V0_DWM_STRENGH DWM_STRENGH;
	
	if(u32Data >= VID_MAX)
	{
		VDP_PRINT("Error, VDP_VMX_SetVmxStrenghMultiply Select Wrong Layer ID\n");
	}
	
	DWM_STRENGH.u32 = VDP_RegRead(((HI_ULONG)&(pVdpReg->V0_DWM_STRENGH.u32) + u32Data * VID_VMX_OFFSET));
	DWM_STRENGH.bits.strengh_multiply = strengh_multiply;
	VDP_RegWrite(((HI_ULONG)&(pVdpReg->V0_DWM_STRENGH.u32) + u32Data * VID_VMX_OFFSET),DWM_STRENGH.u32);
	
	return ;
}


HI_VOID VDP_VMX_SetVmxDirectionMax(HI_U32 u32Data, HI_U32 direction_max)
{
	U_V0_DWM_STRENGH DWM_STRENGH;
	
	if(u32Data >= VID_MAX)
	{
		VDP_PRINT("Error, VDP_VMX_SetVmxDirectionMax Select Wrong Layer ID\n");
	}
	
	DWM_STRENGH.u32 = VDP_RegRead(((HI_ULONG)&(pVdpReg->V0_DWM_STRENGH.u32) + u32Data * VID_VMX_OFFSET));
	DWM_STRENGH.bits.direction_max = direction_max;
	VDP_RegWrite(((HI_ULONG)&(pVdpReg->V0_DWM_STRENGH.u32) + u32Data * VID_VMX_OFFSET),DWM_STRENGH.u32);
	
	return ;
}


HI_VOID VDP_VMX_SetVmxStrenghThd(HI_U32 u32Data, HI_U32 * strengh_thd)
{
	U_V0_DWM_STR_THD0  DWM_STR_THD0 ;
	HI_U32 num = 6;
	HI_U32 i;

	
	if(u32Data >= VID_MAX)
	{
		VDP_PRINT("Error, VDP_VMX_SetVmxStrenghThd Select Wrong Layer ID\n");
	}

    if((u32Data == VDP_LAYER_VMX_VID0) || (u32Data == VDP_LAYER_VMX_VID1))
        num = 6;
    else if(u32Data == VDP_LAYER_VMX_VP0)
        num = 24;

	for(i=0;i<num;i++)
	{
		DWM_STR_THD0.u32  = VDP_RegRead(((HI_ULONG)&(pVdpReg->V0_DWM_STR_THD0.u32)  + u32Data * VID_VMX_OFFSET + i*4));
		DWM_STR_THD0.bits.strengh_0   = strengh_thd[i*2] ; 
		DWM_STR_THD0.bits.strengh_1   = strengh_thd[i*2+1] ; 
		VDP_RegWrite(((HI_ULONG)&(pVdpReg->V0_DWM_STR_THD0.u32) + u32Data * VID_VMX_OFFSET + i*4),DWM_STR_THD0.u32);
	}

	return ;
}


HI_VOID VDP_VMX_SetVmxStrenghThdBg(HI_U32 u32Data, HI_U32 * strengh_bg)
{
	U_V0_DWM_BGSTR_THD0  DWM_BGSTR_THD0 ;
	HI_U32 i;

	HI_U32 num = 6;
	
	if(u32Data >= VID_MAX)
	{
		VDP_PRINT("Error, VDP_VMX_SetVmxStrenghThdBg Select Wrong Layer ID\n");
	}
	
    if((u32Data == VDP_LAYER_VMX_VID0) || (u32Data == VDP_LAYER_VMX_VID1))
        num = 6;
    else if(u32Data == VDP_LAYER_VMX_VP0)
        num = 24;

	for(i=0;i<num;i++)
	{
		DWM_BGSTR_THD0.u32  = VDP_RegRead(((HI_ULONG)&(pVdpReg->V0_DWM_BGSTR_THD0.u32)  + u32Data * VID_VMX_OFFSET + i*4));
		DWM_BGSTR_THD0.bits.strengh_0   = strengh_bg[i*2] ;
		DWM_BGSTR_THD0.bits.strengh_1   = strengh_bg[i*2+1] ;
		VDP_RegWrite(((HI_ULONG)&(pVdpReg->V0_DWM_BGSTR_THD0.u32) + u32Data * VID_VMX_OFFSET + i*4),DWM_BGSTR_THD0.u32);
	}
	return ;
}

HI_VOID VDP_VID_SetVmxCoefAddr(HI_U32 u32Data, HI_U32 u32CoefAddr)
{
    U_V0_DWM_SYB_PARA_ADDR   V0_DWM_SYB_PARA_ADDR;

    if(u32Data>= VID_MAX)
    {
        VDP_PRINT("Error,VDP_VID_SetVmxCoefAddr() Select Wrong CHANNEL ID\n");
        return ;
    }

    V0_DWM_SYB_PARA_ADDR.u32 = VDP_RegRead(((HI_ULONG)&(pVdpReg->V0_DWM_SYB_PARA_ADDR.u32) + u32Data * VID_VMX_OFFSET));
    V0_DWM_SYB_PARA_ADDR.bits.para_addr = u32CoefAddr;
    VDP_RegWrite(((HI_ULONG)&(pVdpReg->V0_DWM_SYB_PARA_ADDR.u32) + u32Data * VID_VMX_OFFSET), V0_DWM_SYB_PARA_ADDR.u32); 

    return ;
}

HI_VOID VDP_VP_SetVmxCoefAddr(HI_U32 u32Data, HI_U32 u32CoefAddr)
{
    U_V0_DWM_SYB_PARA_ADDR   V0_DWM_SYB_PARA_ADDR;

    if(u32Data>= VID_MAX)
    {
        VDP_PRINT("Error,VDP_VID_SetVmxCoefAddr() Select Wrong CHANNEL ID\n");
        return ;
    }

    V0_DWM_SYB_PARA_ADDR.u32 = VDP_RegRead(((HI_ULONG)&(pVdpReg->V0_DWM_SYB_PARA_ADDR.u32) + 2 * VID_VMX_OFFSET));
    V0_DWM_SYB_PARA_ADDR.bits.para_addr = u32CoefAddr;
    VDP_RegWrite(((HI_ULONG)&(pVdpReg->V0_DWM_SYB_PARA_ADDR.u32) + 2 * VID_VMX_OFFSET), V0_DWM_SYB_PARA_ADDR.u32); 
    
    return ;
}

//HI_S32 VDP_FUNC_GetVmxCfg (VDP_LAYER_VMX_E enLayer, mode, vmx_hw_soc_t * vmx_cfg_in)
//{
//    return HI_SUCCESS;
//}

HI_S32 VDP_DRV_SetVmxMode (VDP_LAYER_VMX_E enLayer, VDP_VMX_EYE_MODE_E enVmxEyeMode, vmx_hw_soc_t * pstVmxCfg)
{
    HI_U32 i = 0, j = 0;

    HI_U32 h_res = 0;
    HI_U32 v_res = 0;

    HI_U32 start_pos_x = 0, start_pos_y = 0, max_distance, mark_buffer_width, mark_buffer_height, scale;
    HI_U32 N; // N = how many columns // +1 needed to fit current, unmodified scanline into the storage
    HI_U32 S; // S = distance between columns
    HI_U32 syb_stride = 0; // symbols store stride for dut

    HI_U32 u32sym_w         ;
    HI_U32 u32sym_h         ;
    HI_U32 u32sym_spacing_w ;
    HI_U32 u32sym_spacing_h ;
    HI_U32 end_pos_x        ;
    HI_U32 end_pos_y        ;

	HI_U32 target_scale;
	HI_U32 direction = 0;
	HI_U32 distance = 0;

    HI_U32 coef_addr;
	HI_U32 u32bIop = 1   ; 

    U_DHD0_CTRL DHD0_CTRL ; 
    U_V0_CTRL   V0_CTRL   ; 
    U_V0_VFPOS  V0_VFPOS  ; 
    U_V0_VLPOS  V0_VLPOS  ; 
    U_VP0_VFPOS VP0_VFPOS ; 
    U_VP0_VLPOS VP0_VLPOS ; 

    DHD0_CTRL.u32  = VDP_RegRead((HI_ULONG)&(pVdpReg->DHD0_CTRL.u32))                         ; 
    V0_CTRL.u32    = VDP_RegRead((HI_ULONG)&(pVdpReg->V0_CTRL.u32) + enLayer * VID_OFFSET)    ; 
    V0_VFPOS.u32   = VDP_RegRead(((HI_ULONG)&(pVdpReg->V0_VFPOS.u32) + enLayer* VID_OFFSET)) ; 
    V0_VLPOS.u32   = VDP_RegRead(((HI_ULONG)&(pVdpReg->V0_VLPOS.u32) + enLayer* VID_OFFSET)) ; 
    VP0_VFPOS.u32  = VDP_RegRead(((HI_ULONG)&(pVdpReg->VP0_VFPOS.u32) + 0* VP_OFFSET)) ; 
    VP0_VLPOS.u32  = VDP_RegRead(((HI_ULONG)&(pVdpReg->VP0_VLPOS.u32) + 0* VP_OFFSET)) ; 
    
    //-------------------------------------------- 
    //get vmx reso from v0/v1/vp video reso
    //-------------------------------------------- 
    if((enLayer == VDP_LAYER_VMX_VID0)||(enLayer == VDP_LAYER_VMX_VID1))
    {
        h_res = V0_VLPOS.bits.video_xlpos - V0_VFPOS.bits.video_xfpos + 1 ;
        v_res = V0_VLPOS.bits.video_ylpos - V0_VFPOS.bits.video_yfpos + 1 ;
    }
    else if(enLayer == VDP_LAYER_VMX_VP0)
    {
        h_res = VP0_VLPOS.bits.video_xlpos - VP0_VFPOS.bits.video_xfpos + 1 ;
        v_res = VP0_VLPOS.bits.video_ylpos - VP0_VFPOS.bits.video_yfpos + 1 ;
    }
    else 
    {
        VDP_PRINT("VDP_DRV_SetVmxMode Set Wrong Layer!!! \n") ; 
    }
    //-------------------------------------------- 
    //get vmx iop based on : dhd0_iop, p2i_en
    //-------------------------------------------- 
    if((DHD0_CTRL.bits.iop)||(DHD0_CTRL.bits.p2i_en))
    {
        u32bIop = 1 ;
    }
    else
    {
        u32bIop = 0 ;
    }
    
    //-----------------change the height based on iop---------------------
    v_res = u32bIop ? v_res : v_res/2 ;
   
    //-------------------------------------------- 
    //change width (HI_ULONG)& height (HI_ULONG)& start_x/y based on 3D mode
    //-------------------------------------------- 
    if((DHD0_CTRL.bits.disp_mode == VDP_DISP_MODE_2D)||(DHD0_CTRL.bits.disp_mode == VDP_DISP_MODE_FP)||(DHD0_CTRL.bits.disp_mode == VDP_DISP_MODE_FS))
    {
        h_res    = h_res;
        v_res    = v_res;
        
        start_pos_x  = (h_res * pstVmxCfg->symbols_xpos / 100) / 2 * 2;
        start_pos_y  = (v_res * pstVmxCfg->symbols_ypos / 100) / 2 * 2;
    }
    else if (DHD0_CTRL.bits.disp_mode == VDP_DISP_MODE_SBS) 
    {
        h_res    = h_res/2;
        v_res    = v_res;
        
        start_pos_y  = (v_res * pstVmxCfg->symbols_ypos / 100) / 2 * 2;
        if(enVmxEyeMode == VDP_VMX_EYE_MODE_LEFTEYE)
        {
            start_pos_x  = (h_res * pstVmxCfg->symbols_xpos / 100) / 2 * 2;
        }
        else if(enVmxEyeMode == VDP_VMX_EYE_MODE_RIGHTEYE)
        {
            start_pos_x  = h_res + (h_res * pstVmxCfg->symbols_xpos / 100) / 2 * 2;
        }
        else ;
    }
    else if (DHD0_CTRL.bits.disp_mode == VDP_DISP_MODE_TAB) 
    {
        h_res    = h_res;
        v_res    = v_res/2;
        
        start_pos_x        = (h_res * pstVmxCfg->symbols_xpos / 100) / 2 * 2;
        if(enVmxEyeMode == VDP_VMX_EYE_MODE_LEFTEYE)
        {
            start_pos_y    = (v_res * pstVmxCfg->symbols_ypos / 100) / 2 * 2;
        }
        else if(enVmxEyeMode == VDP_VMX_EYE_MODE_RIGHTEYE)
        {
            start_pos_y    = v_res + (v_res * pstVmxCfg->symbols_ypos / 100) / 2 * 2;
        }
        else ;
    }
    else if (DHD0_CTRL.bits.disp_mode == VDP_DISP_MODE_LBL) 
    {
        h_res    = h_res*2;
        v_res    = v_res/2;
        
        start_pos_x        = (h_res * pstVmxCfg->symbols_xpos / 100) / 2 * 2;
        if(enVmxEyeMode == VDP_VMX_EYE_MODE_LEFTEYE)
        {
            start_pos_y    = (v_res * pstVmxCfg->symbols_ypos / 100) / 2 * 2;
        }
        else if(enVmxEyeMode == VDP_VMX_EYE_MODE_RIGHTEYE)
        {
            start_pos_y    = v_res + (v_res * pstVmxCfg->symbols_ypos / 100) / 2 * 2;
        }
        else ;
    }
    else
    {
        VDP_PRINT("VDP_DRV_SetVmxMode 3D Mode Set Error!! \n") ; 
    }
    
    if (((DHD0_CTRL.bits.disp_mode == VDP_DISP_MODE_SBS) || (DHD0_CTRL.bits.disp_mode == VDP_DISP_MODE_TAB) || (DHD0_CTRL.bits.disp_mode == VDP_DISP_MODE_LBL)) && (enVmxEyeMode == VDP_VMX_EYE_MODE_TWOEYE))
    {
        VDP_PRINT("VDP_DRV_SetVmxMode LBL Set Two Eye Error!!! \n") ; 
    }
    else ;
    //-------------------------------------------- 
    //assert of three fre distance
    //-------------------------------------------- 
    if(pstVmxCfg->watermark_on == HI_TRUE)
    {
        for (i = 0; i < 3; i ++) {
            VDP_ASSERT(pstVmxCfg->frequency_distance[i][0] <= 3);
            VDP_ASSERT(pstVmxCfg->frequency_distance[i][1] <= 7);
            VDP_ASSERT((pstVmxCfg->frequency_distance[i][2] <= 16)&&(pstVmxCfg->frequency_distance[i][2] >= 3));
        }
    }

    // Render the symbols
    //-------------------calc the scale and distance

	target_scale = ((v_res * 10 * pstVmxCfg->symbol_scale_control / 480) - 10 * pstVmxCfg->symbol_scale_control + 100) * pstVmxCfg->symbol_size;
 	scale = VMX_MIN3(target_scale, 
		h_res * (95 - pstVmxCfg->symbols_xpos) / (pstVmxCfg->symbols_cols * (SYMBOL_ORG_WIDTH  + pstVmxCfg->spacing_horz) - pstVmxCfg->spacing_horz), 
		v_res * (95 - pstVmxCfg->symbols_ypos) / (pstVmxCfg->symbols_rows * (SYMBOL_ORG_HEIGHT + pstVmxCfg->spacing_vert) - pstVmxCfg->spacing_vert)
		); 

	scale = scale / 100; // this is TRUNCated (default behavior of float->int conversion)
    
    //add scale == 0
    if(pstVmxCfg->watermark_on == HI_TRUE)
    {
        VDP_ASSERT(scale > 0);
    }
    //-------------------------------------------- 
    //calc distance of three directions
    //-------------------------------------------- 
	for (direction = 0; direction < 3; direction ++) {
		for (distance = 0; distance < 3; distance ++) {
			pstVmxCfg->frequency_distance[direction][distance] = (pstVmxCfg->frequency_distance[direction][distance] * v_res + 240) / 480;
		}
	}

    //-------------------------------------------- 
    //calc the settings for dut
    //-------------------------------------------- 
    max_distance       = pstVmxCfg->frequency_distance[DIRECTION_TOP][2];
    mark_buffer_width  = pstVmxCfg->symbols_cols * (SYMBOL_ORG_WIDTH + pstVmxCfg->spacing_horz) * scale - pstVmxCfg->spacing_horz * scale;
    mark_buffer_height = pstVmxCfg->symbols_rows * (SYMBOL_ORG_HEIGHT + pstVmxCfg->spacing_vert) * scale - pstVmxCfg->spacing_vert * scale;
    N                  = COLUMN_STORE_SIZE / (pstVmxCfg->frequency_distance[2][2] + 1);
    S                  = VMX_MAX((mark_buffer_width / N) + 1, 4);
    N                  = (mark_buffer_width + S - 1) / S;
 
    //------------------calc the settings for dut
    u32sym_w         = scale * SYMBOL_ORG_WIDTH ;
    u32sym_h         = scale * SYMBOL_ORG_HEIGHT ;
    u32sym_spacing_w = scale * pstVmxCfg->spacing_horz ;
    u32sym_spacing_h = scale * pstVmxCfg->spacing_vert ;
    end_pos_x        = start_pos_x + mark_buffer_width ;  // - 1 or not
    end_pos_y        = start_pos_y + mark_buffer_height;  // - 1 or not
    syb_stride       = pstVmxCfg->symbols_cols * 24 ;


   //add assert 
    if(pstVmxCfg->watermark_on == HI_TRUE)
    {
        //in reso limit is 720x480,but the real test limit is 300x240
        VDP_ASSERT((h_res >= 300)&&(v_res >= 240))

        for (i = 0; i < 3; i ++) {
            for (j = 0; j < 2; j ++) {
                VDP_ASSERT(pstVmxCfg->frequency_distance[i][j] <= pstVmxCfg->frequency_distance[i][j+1]);
            }
        }
        VDP_ASSERT((h_res%2 == 0)&&(v_res%2 == 0));
        VDP_ASSERT((start_pos_x%2 == 0)&&(start_pos_y%2 == 0));
        //add start_pos_x > distance
        VDP_ASSERT(start_pos_x >=  pstVmxCfg->frequency_distance[0][2]);
        VDP_ASSERT(start_pos_x >=  pstVmxCfg->frequency_distance[1][2]);
        VDP_ASSERT(start_pos_y >=  pstVmxCfg->frequency_distance[2][2]);

        VDP_ASSERT((u32sym_spacing_w%2 == 0)&&(u32sym_spacing_h%2 == 0));
        VDP_ASSERT((pstVmxCfg->symbols_xpos >= 5)&&(pstVmxCfg->symbols_xpos <= 95));
        VDP_ASSERT((pstVmxCfg->symbols_ypos >= 5)&&(pstVmxCfg->symbols_ypos <= 95));
        VDP_ASSERT((pstVmxCfg->spacing_horz >= 0)&&(pstVmxCfg->spacing_horz <= 500));
        VDP_ASSERT((pstVmxCfg->spacing_vert >= 0)&&(pstVmxCfg->spacing_vert <= 500));
        VDP_ASSERT((pstVmxCfg->symbol_size >= 1)&&(pstVmxCfg->symbol_size <= 20));
        VDP_ASSERT((pstVmxCfg->symbol_scale_control >= 1)&&(pstVmxCfg->symbol_scale_control <= 10));
        VDP_ASSERT(((end_pos_x * 100 / h_res) >= 5)&&((end_pos_x * 100 / h_res) <= 95));
        VDP_ASSERT(((end_pos_y * 100 / v_res) >= 5)&&((end_pos_y * 100 / v_res) <= 95));
        VDP_ASSERT((pstVmxCfg->strength_multiply <= 120)&&(pstVmxCfg->strength_multiply >= -120));
    }
    
    //-------------------------------------------- 
    //config sent to dut
    //-------------------------------------------- 
    VDP_VMX_SetVmxWidth           ( enLayer, u32sym_w                                             );
    VDP_VMX_SetVmxHeight          ( enLayer, u32sym_h                                             );
    VDP_VMX_SetVmxSybXlpos        ( enLayer, end_pos_x                                            ); //the last pos of symbols scale
    VDP_VMX_SetVmxSybYlpos        ( enLayer, end_pos_y                                            );
    VDP_VMX_SetVmxSybXfpos        ( enLayer, start_pos_x                                          ); //mark_buffer first pos
    VDP_VMX_SetVmxSybYfpos        ( enLayer, start_pos_y                                          );
    VDP_VMX_SetVmxSybHorSpac      ( enLayer, u32sym_spacing_w                                     );    //mark_buffer last pos
    VDP_VMX_SetVmxSybVerSpac      ( enLayer, u32sym_spacing_h                                     );
    VDP_VMX_SetVmxLfreDirction    ( enLayer, (HI_U32*)(pstVmxCfg->frequency_distance[0])          ); //sample disitance
    VDP_VMX_SetVmxRfreDirction    ( enLayer, (HI_U32*)(pstVmxCfg->frequency_distance[1])          );
    VDP_VMX_SetVmxTfreDirction    ( enLayer, (HI_U32*)(pstVmxCfg->frequency_distance[2])          );
    VDP_VMX_SetVmxFrequencyLine   ( enLayer, max_distance                                         );  //
    VDP_VMX_SetVmxFrequencyPix    ( enLayer, N                                                    );
    VDP_VMX_SetVmxFrequencySpac   ( enLayer, S                                                    );
    VDP_VMX_SetVmxSybStride       ( enLayer, syb_stride                                           );
    VDP_VMX_SetVmxDwmEn           ( enLayer, pstVmxCfg->watermark_on                              );
    VDP_VMX_SetVmxBgEmbdEn        ( enLayer, pstVmxCfg->background_embedding_on                   );
    VDP_VMX_SetVmxScale           ( enLayer, scale                                                );
    VDP_VMX_SetVmxSybHorNum       ( enLayer, pstVmxCfg->symbols_cols                              );
    VDP_VMX_SetVmxSybVerNum       ( enLayer, pstVmxCfg->symbols_rows                              );
    VDP_VMX_SetVmxStrenghMultiply ( enLayer, pstVmxCfg->strength_multiply                         );
    VDP_VMX_SetVmxDirectionMax    ( enLayer, pstVmxCfg->direction_max                             );
    VDP_VMX_SetVmxStrenghThd      ( enLayer, (HI_U32*)(pstVmxCfg->embedding_strength_threshold)   );
    VDP_VMX_SetVmxStrenghThdBg    ( enLayer, (HI_U32*)(pstVmxCfg->embedding_strength_threshold_bg));

    coef_addr = pstVmxCfg->payload_symbols;
    if((enLayer == VDP_LAYER_VMX_VID0)||(enLayer == VDP_LAYER_VMX_VID1))
    {
        VDP_VID_SetVmxCoefAddr        ( enLayer, coef_addr ) ;
    }
    else//VP
    {
        VDP_VP_SetVmxCoefAddr         ( enLayer, coef_addr ) ;
    }

    return HI_SUCCESS;
}
