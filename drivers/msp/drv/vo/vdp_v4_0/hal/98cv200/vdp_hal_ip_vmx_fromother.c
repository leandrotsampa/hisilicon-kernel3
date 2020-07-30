
#include "hi_type.h"
#include "vdp_hal_comm.h"
//#include "vdp_hal_ip_vmx.h"

extern S_VDP_REGS_TYPE *pVdpReg;


HI_VOID  VDP_VID_SetParaUpd_VMX       (HI_U32 u32Data, VDP_VID_PARA_E enMode)
{
    U_V0_DWM_SYB_PARAUP V0_DWM_SYB_PARAUP ;
    if(enMode == VDP_VID_PARA_VMX)
    {
        V0_DWM_SYB_PARAUP.u32 = VDP_RegRead(((HI_ULONG)&(pVdpReg->V0_DWM_SYB_PARAUP.u32) + u32Data * VID_VMX_OFFSET));
        V0_DWM_SYB_PARAUP.bits.para_up= 0x1;
        VDP_RegWrite(((HI_ULONG)&(pVdpReg->V0_DWM_SYB_PARAUP.u32) + u32Data * VID_VMX_OFFSET), V0_DWM_SYB_PARAUP.u32); 
    }

    if(u32Data >= VID_MAX)
    {
        VDP_PRINT("error,VDP_VID_SetParaUpd_VMX() select wrong video layer id\n");
        return ;
    }
   
    return ;
}


HI_VOID  VDP_VP0_SetParaUpd_VMX(HI_U32 u32Data, VDP_VP_PARA_E  enMode)
{
    U_V0_DWM_SYB_PARAUP V0_DWM_SYB_PARAUP ;
    if(enMode == VDP_VP_PARA_VMX)
    {
        V0_DWM_SYB_PARAUP.u32 = VDP_RegRead(((HI_ULONG)&(pVdpReg->V0_DWM_SYB_PARAUP.u32) + 2 * VID_VMX_OFFSET));
        V0_DWM_SYB_PARAUP.bits.para_up= 0x1;
        VDP_RegWrite(((HI_ULONG)&(pVdpReg->V0_DWM_SYB_PARAUP.u32) + 2 * VID_VMX_OFFSET), V0_DWM_SYB_PARAUP.u32); 
    }

    if(u32Data >= VID_MAX)
    {
        VDP_PRINT("error,VDP_VP0_SetParaUpd() select wrong video layer id\n");
        return ;
    }    
    return ;
}




HI_VOID  VDP_VID_GetLayerEnable_VMX(HI_U32 u32Data, HI_U32 *pu32Enable)
{
    U_V0_CTRL V0_CTRL;

    if(u32Data >= VID_MAX)
    {
        VDP_PRINT("Error,VDP_VID_SetLayerEnable() Select Wrong Video Layer ID\n");
        return ;
    }

    V0_CTRL.u32 = VDP_RegRead(((HI_ULONG)&(pVdpReg->V0_CTRL.u32) + u32Data * VID_OFFSET));
    *pu32Enable = V0_CTRL.bits.surface_en;

    return ;
}



HI_VOID VDP_DISP_GetHDREnable_VMX(HI_U32 *pu32Enable)
{
    U_HDR_CTRL HDR_CTRL;

    HDR_CTRL.u32 = VDP_RegRead(((HI_ULONG)&(pVdpReg->HDR_CTRL.u32)));
    *pu32Enable = HDR_CTRL.bits.hdr_en;

    return ;
}

HI_VOID  VDP_VID_GetVideoReso_VMX(HI_U32 u32Data, HI_U32 *pu32Width, HI_U32 *pu32Height)
{
    U_V0_VFPOS V0_VFPOS;
    U_V0_VLPOS V0_VLPOS;

    if(u32Data >= VID_MAX)
    {
        VDP_PRINT("Error,VDP_VID_SetVideoPos() Select Wrong Video Layer ID\n");
        return ;
    }

    /*video position */ 
    V0_VFPOS.u32 = VDP_RegRead(((HI_ULONG)&(pVdpReg->V0_VFPOS.u32) + u32Data * VID_OFFSET));
    V0_VLPOS.u32 = VDP_RegRead(((HI_ULONG)&(pVdpReg->V0_VLPOS.u32) + u32Data * VID_OFFSET));

    *pu32Width = V0_VLPOS.bits.video_xlpos - V0_VFPOS.bits.video_xfpos + 1;
    *pu32Height = V0_VLPOS.bits.video_ylpos - V0_VFPOS.bits.video_yfpos + 1;
    return ;
}   


HI_VOID  VDP_VP_GetLayerReso_VMX(HI_U32 *pu32Width, HI_U32 *pu32Height)
{
    U_VP0_IRESO VP0_IRESO;
/*
    if(u32Data >= VID_MAX)
    {
        VDP_PRINT("Error,VDP_VP_SetLayerReso() Select Wrong Video Layer ID\n");
        return ;
    }
    */
    VP0_IRESO.u32 = VDP_RegRead(((HI_ULONG)&(pVdpReg->VP0_IRESO.u32)));
    *pu32Width = VP0_IRESO.bits.iw + 1;
    *pu32Height = VP0_IRESO.bits.ih + 1;
   
   return ;
}
