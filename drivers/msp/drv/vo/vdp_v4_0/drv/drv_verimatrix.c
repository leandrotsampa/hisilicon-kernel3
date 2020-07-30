
#include "drv_verimatrix.h"

#define ABS(x)           (((x) < 0) ? -(x) : (x))
#define MAX(a, b)         (( (a) < (b) ) ?  (b) : (a))
#define MIN(a, b)         (( (a) > (b) ) ?  (b) : (a))


	
VM_HW_Err_t VM_HW_SetParameters_Rend (HI_U8 bServiceIdx, vmx_hw_soc_rend_t * hwParameters)
{
    HI_U32 u32V0Enable = 0;
    HI_U32 u32V1Enable = 0;
    HI_U32 u32HDREnable = 0;
    HI_U32 u32Width,u32Height;
    HI_U32 i,j;
    vmx_hw_soc_t vmx_cfg_in = {0};
    HI_S32  frequency_distance_min[3] = {0, 0, 3};
    HI_S32  frequency_distance_max[3] = {3, 7, 16};
    HI_U32  embedding_sthength_threshold_num = 0;
    
    //vmx_cfg_in->u32Id                   = bServiceIdx;
    vmx_cfg_in.symbols_rows            = hwParameters->symbols_rows;
    vmx_cfg_in.symbols_cols            = hwParameters->symbols_cols;
    vmx_cfg_in.symbols_xpos            = hwParameters->symbols_xpos;
    vmx_cfg_in.symbols_ypos            = hwParameters->symbols_ypos;
    vmx_cfg_in.symbol_size             = hwParameters->symbol_size;
    vmx_cfg_in.spacing_vert            = hwParameters->spacing_vert;
    vmx_cfg_in.spacing_horz            = hwParameters->spacing_horz;
    vmx_cfg_in.symbol_scale_control    = hwParameters->symbol_scale_control;
    vmx_cfg_in.watermark_on            = hwParameters->watermark_on;
    vmx_cfg_in.background_embedding_on = hwParameters->background_embedding_on;
    vmx_cfg_in.direction_max           = hwParameters->direction_max;
    vmx_cfg_in.strength_multiply       = hwParameters->strength_multiply;
    //vmx_cfg_in.payload_symbols         = hwParameters->payload_symbols;
    vmx_cfg_in.payload_symbols    = hwParameters->symbol_phy_addr;

    
    //memcpy(&vmx_cfg_in->frequency_distance, &hwParameters->frequency_distance, sizeof(hwParameters->frequency_distance));
    // Parameters for symbol embedding of rendered symbols
    for (i = 0; i < 3; i++)
    {
        for (j = 0; j < 3; j++) 
        {
            vmx_cfg_in.frequency_distance[i][j] = hwParameters->frequency_distance[i][j];
            //validate frequency distance values against thresholds
            if(vmx_cfg_in.frequency_distance[i][j] < frequency_distance_min[j])
                vmx_cfg_in.frequency_distance[i][j] = frequency_distance_min[j];
            if(vmx_cfg_in.frequency_distance[i][j] > frequency_distance_max[j])
                vmx_cfg_in.frequency_distance[i][j] = frequency_distance_max[j];
        }
        // validate that frequency distances are in ascending order.
        if(vmx_cfg_in.frequency_distance[i][0] > vmx_cfg_in.frequency_distance[i][1])
            vmx_cfg_in.frequency_distance[i][0] = MIN(vmx_cfg_in.frequency_distance[i][1], frequency_distance_max[0]);
        if(vmx_cfg_in.frequency_distance[i][1] > vmx_cfg_in.frequency_distance[i][2])
            vmx_cfg_in.frequency_distance[i][1] = MIN(vmx_cfg_in.frequency_distance[i][2], frequency_distance_max[1]);
    }


    VDP_DISP_GetHDREnable_VMX(&u32HDREnable);

    if (u32HDREnable)
    {
        embedding_sthength_threshold_num = 48;
        for (i = 0; i < embedding_sthength_threshold_num; i++) 
        {
            vmx_cfg_in.embedding_strength_threshold[i] = hwParameters->embedding_strength_threshold_12[i];
            vmx_cfg_in.embedding_strength_threshold_bg[i] = hwParameters->embedding_strength_threshold_bg_12[i];
        }

        VDP_VP_GetLayerReso_VMX(&u32Width, &u32Height);

        //从寄存器获取水印模块输入的视频宽高信息
		
    	VDP_DRV_SetVmxMode (VDP_LAYER_VMX_VP0, VDP_VMX_EYE_MODE_LEFTEYE, &vmx_cfg_in);            
    }
    else
    {
        embedding_sthength_threshold_num = 12;
        for (i = 0; i < embedding_sthength_threshold_num; i++) 
        {
            vmx_cfg_in.embedding_strength_threshold[i] = hwParameters->embedding_strength_threshold_10[i];
            vmx_cfg_in.embedding_strength_threshold_bg[i] = hwParameters->embedding_strength_threshold_bg_10[i];
        }
            
        VDP_VID_GetLayerEnable_VMX(VDP_LAYER_VMX_VID0, &u32V0Enable);
        VDP_VID_GetLayerEnable_VMX(VDP_LAYER_VMX_VID1, &u32V1Enable);

        if (u32V0Enable && (!u32V1Enable))
        {
            VDP_VID_GetVideoReso_VMX(VDP_LAYER_VMX_VID0, &u32Width, &u32Height);

            VDP_DRV_SetVmxMode (VDP_LAYER_VMX_VID0, VDP_VMX_EYE_MODE_LEFTEYE, &vmx_cfg_in);
			VDP_VID_SetParaUpd_VMX(VDP_LAYER_VMX_VID0,VDP_VID_PARA_VMX);

        }
        else if ((!u32V0Enable) && u32V1Enable)
        {
            VDP_VID_GetVideoReso_VMX(VDP_LAYER_VMX_VID1, &u32Width, &u32Height);
        
            VDP_DRV_SetVmxMode (VDP_LAYER_VMX_VID1, VDP_VMX_EYE_MODE_LEFTEYE, &vmx_cfg_in);
			VDP_VID_SetParaUpd_VMX(VDP_LAYER_VMX_VID1,VDP_VID_PARA_VMX);
        }
        else if (u32V0Enable && u32V1Enable)
        {
            // TODO:需要保证两个水印模块添加的水印不重叠
            VDP_VID_GetVideoReso_VMX(VDP_LAYER_VMX_VID0, &u32Width, &u32Height);
            VDP_DRV_SetVmxMode (VDP_LAYER_VMX_VID0, VDP_VMX_EYE_MODE_LEFTEYE, &vmx_cfg_in);

            VDP_VID_GetVideoReso_VMX(VDP_LAYER_VMX_VID1, &u32Width, &u32Height);
            VDP_DRV_SetVmxMode (VDP_LAYER_VMX_VID1, VDP_VMX_EYE_MODE_LEFTEYE, &vmx_cfg_in);
        }
        else
        {
            return VM_HW_FAIL;
        }
        
    }
    
    return VM_HW_OK;
}



