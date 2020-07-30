#ifndef __HAL_HDMIRX_H__
#define __HAL_HDMIRX_H__


HI_S32 HDMI_HAL_HAL_Init(HI_VOID);
HI_VOID HDMI_HAL_Read(HI_U32 u32Dev, HI_U32 u32Addr, HI_U8* pu8Value);
HI_VOID HDMI_HAL_Write(HI_U32 u32Dev, HI_U32 u32Addr, HI_U8 u8Value);
HI_VOID HDMI_HAL_Read2B(HI_U32 u32Dev, HI_U32 u32Addr, HI_U32* pu32Value);


HI_U32 HDMI_HAL_RegRead(HI_U32);
HI_U32 HDMI_HAL_RegReadFldAlign(HI_U32, HI_U32);
void HDMI_HAL_RegReadBlock(HI_U32, HI_U32 *, HI_U32);

void HDMI_HAL_RegWrite(HI_U32, HI_U32);
void HDMI_HAL_RegWriteBlock(HI_U32, HI_U32 *, HI_U32);
void HDMI_HAL_RegWriteFldAlign(HI_U32, HI_U32, HI_U32);
void HDMI_HAL_RegSetBits(HI_U32,HI_U32, HI_BOOL);
#endif
