#ifndef __DRV_HIHDR_H__
#define __DRV_HIHDR_H__

#include "vdp_drv_vid.h"



typedef enum tagVDP_HIHDR_CFG_MODE_E
{
    VDP_HIHDR_HDR10_IN_HDR10_OUT  = 0x0 , 
	VDP_HIHDR_HDR10_IN_SDR_OUT   , 
    VDP_HIHDR_CFG_MODE_BUTT        
    
}VDP_HIHDR_CFG_MODE_E;



typedef struct
{
	VDP_HIHDR_CFG_MODE_E enHdrMode;
	VDP_DATA_WTH u32DataWidth;//0:8bit; 1:10bit
	VDP_RECT_S stVidInReso ; //vid input reso
	VDP_RECT_S stVidOutReso  ; //vid zme output reso
	//VDP_RECT_S stGfxReso ; //gfx input reso

	VDP_ADDR_S stVidAddr; 
	VDP_ADDR_S stVidAddr_2LowBit  ; 
	VDP_ADDR_S stHeadAddr; //dcmp head data addr

	HI_BOOL bDcmpEn;
	HI_BOOL bMuteEn;
	HI_BOOL bGfxEn;
	HI_BOOL bPreMult;
	
    VDP_VID_IFMT_E  enVidIFmt;

	//VDP_GFX_IFMT_E enGfxIfmt;
	
    HI_BOOL           bSmmuEn; 

} VDP_HISI_HDR_CFG_S;
#define HiHDR_TM_LUT_SIZE 512

typedef struct HiHDRDmTMCfg_
{

	
	/*ToneMapping*/
	//HI_S16 s16aTMLutI[HiHDR_TM_LUT_SIZE];
	//HI_S16 s16aTMLutS[HiHDR_TM_LUT_SIZE];
	//HI_S16 s16aSMLutI[HiHDR_TM_LUT_SIZE];
	//HI_S16 s16aSMLutS[HiHDR_TM_LUT_SIZE];
	
  // ToneMapping
	#if 1
	HI_S16 s16V_TMLutI[HiHDR_TM_LUT_SIZE];
	HI_S16 s16V_TMLutS[HiHDR_TM_LUT_SIZE];
	HI_S16 s16V_SMLutI[HiHDR_TM_LUT_SIZE];
	HI_S16 s16V_SMLutS[HiHDR_TM_LUT_SIZE];
	#endif
} HiHDRDmTMCfg;


HI_S32 VDP_DRV_SetHisiHdrMode         ( VDP_HISI_HDR_CFG_S *stHdrCfg, HiHDRDmTMCfg *pstHisiHdr);
HI_VOID VDP_DRV_HiSiHdrClean(HI_BOOL bclear);
HI_VOID VDP_DRV_HiSiHdrMute(HI_BOOL bMuteEn);


#endif
