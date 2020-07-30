/*--------------------------------------------------------------------------------------------------------------------------*/
/*!!Warning: This is a key information asset of Huawei Tech Co.,Ltd                                                         */
/*CODEMARK:kOyQZYzjDpyGdBAEC2GaWinjiDDUykL9e8pckESWBbMVmSWkBuyJO01cTiy3TdzKxGk0oBQa
mSMf7J4FkTpfv8z0cuYCL+sO/Q2xjbokwnXqBqh6I/GXbNxahReyeAc/lTJ3w7lPqURpp0cC
/UFzZp96/KF+y2/0vWZ+aJFBDiELUSmc8sUAL3ESTEzAy+nmYBTNxNXrZYVDEguGLF1zCrjZ
WQfDqKEZsCF1bfkxezPFNJFXQcSkuDP0tLaHKZ2bFQlrNIm4S1vTVanOvPtIIw==*/
/*--------------------------------------------------------------------------------------------------------------------------*/
#ifndef __DRV_DISP_ALG_RGB2YUV_H__
#define __DRV_DISP_ALG_RGB2YUV_H__

#include "hi_drv_video.h"

typedef struct
{
    HI_U8 u8Red;
    HI_U8 u8Green;
    HI_U8 u8Blue;

    HI_U8 u8Y;
    HI_U8 u8Cb;
    HI_U8 u8Cr;
}ALG_COLOR_S;

HI_VOID DISP_ALG_CscRgb2Yuv(ALG_COLOR_S *pstRgbColor, ALG_COLOR_S *pYuvColor);

#endif /*__DRV_DISP_ALG_RGB2YUV_H__*/

