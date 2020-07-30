/*--------------------------------------------------------------------------------------------------------------------------*/
/*!!Warning: This is a key information asset of Huawei Tech Co.,Ltd                                                         */
/*CODEMARK:64z4jYnYa5t1KtRL8a/vnMxg4uGttU/wzF06xcyNtiEfsIe4UpyXkUSy93j7U7XZDdqx2rNx
p+25Dla32ZW7ohi4qDDjwbJXYbjR7HRRkg5cta9IldytA7oZ6BI0P99vPtLLDqx2qE8mc634
x64fBH++IYVPEILNds4RkwY2TwkjURzY4v0MLHsj3qpERFM99mfMM9+7O0x75McJ5qO2rH9l
KkNTEwsI5sthXXQW3yRzXKkR1izHJV4FfsFHkWG3VvKOJHUHyy/pO9FgRfANHQ==*/
/*--------------------------------------------------------------------------------------------------------------------------*/
#include "drv_disp_alg_rgb2yuv.h"


//RGB_YUVÉ«²Ê¿Õ¼ä×ª»»
HI_VOID DISP_ALG_CscRgb2Yuv(ALG_COLOR_S *pstRgbColor, ALG_COLOR_S *pYuvColor)
{
    HI_U8 Red;
    HI_U8 Green;
    HI_U8 Blue;

    Red   = pstRgbColor->u8Red;
    Green = pstRgbColor->u8Green;
    Blue  = pstRgbColor->u8Blue;

    pYuvColor->u8Y  = 257 * Red / 1000 + 504 * Green / 1000 + 98 * Blue / 1000 + 16;
    pYuvColor->u8Cb = -148 * Red / 1000 - 291 * Green / 1000 + 439 * Blue / 1000 + 128;
    pYuvColor->u8Cr = 439 * Red / 1000 - 368 * Green / 1000 - 71 * Blue / 1000 + 128;

    if (pYuvColor->u8Y < 16)
    {
        pYuvColor->u8Y = 16;
    }

    if (pYuvColor->u8Y > 235)
    {
        pYuvColor->u8Y = 235;
    }

    if (pYuvColor->u8Cb < 16)
    {
        pYuvColor->u8Cb = 16;
    }

    if (pYuvColor->u8Cb > 240)
    {
        pYuvColor->u8Cb = 240;
    }

    if (pYuvColor->u8Cr < 16)
    {
        pYuvColor->u8Cr = 16;
    }

    if (pYuvColor->u8Cr > 240)
    {
        pYuvColor->u8Cr = 240;
    }
}


