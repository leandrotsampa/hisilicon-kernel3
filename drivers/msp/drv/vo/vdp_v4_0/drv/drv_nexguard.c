
#include "drv_nexguard.h"


HI_VOID NG_Reset(HI_VOID)                                  /* to perform a software reset of the WM IP core */ 
{
    return;
}
HI_VOID NG_EnableIn(HI_BOOL enableIn)                  /*   1-bit, globally enables/disables watermarking */
{
    return;
}
HI_VOID NG_DebugEnableIn(HI_BOOL debugEnableIn)          /*   1-bit, visible test pattern enable/disable */
{
    return;
}
HI_VOID NG_SetKeyInSeed(HI_U32 keyInSeed)       /*  32-bit 每 KeyIn */
{
    return;
}



HI_VOID NG_SetOperatorId(HI_U8 operatorId)    /*   8-bit 每 Payload[55:48] */
{
    return;
}
HI_VOID NG_SetSubscriberId(HI_U32 subScriberId) /*  32-bit 每 Payload[47:16] */
{
    return;
}
HI_VOID NG_SetTimeCode(HI_U16 timeCode)   /*  16-bit 每 Payload[15:0]  */
{
    return;
}


HI_VOID NG_SetSetting(struct SettingStruct* sStruct)  /* 165-bit packed in 21 bytes */
{
    return;
}                                                       






HI_VOID NXG_HW_SetParameters(HI_BOOL bEnable)
{
    VDP_NXG_NXG_MODE_E NxgMode = VDP_NXG_NXG_TYP;
    VDP_NXG_CFG_S stCfg;
    HI_U32 iw = 0, ih = 0;

    if (bEnable)
    {
        VDP_FUNC_GetNxgCfg(NxgMode, iw, ih, &stCfg);
        stCfg.dwm_en   = 1;
        stCfg.debug_en = 1;
        VDP_DRV_SetNxgMode(VDP_LAYER_VP0, &stCfg);
    }
    else
    {
        VDP_FUNC_GetNxgCfg(NxgMode, iw, ih, &stCfg);
        stCfg.dwm_en   = 0;
        stCfg.debug_en = 0;
        VDP_DRV_SetNxgMode(VDP_LAYER_VP0, &stCfg);
    }

    return;
}







