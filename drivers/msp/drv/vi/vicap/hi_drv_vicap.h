/******************************************************************************

  Copyright (C), 2012-2050, Hisilicon Tech. Co., Ltd.

 ******************************************************************************
  File Name     : hi_drv_vicap.h
  Version       : Initial Draft
  Author        : Hisilicon multimedia software group
  Created       : 2013/10/25
  Description   : 
  History       :
  1.Date        : 2013/10/25
    Author      : w00248302/c00186004
    Modification: Created file
******************************************************************************/

#ifndef __HI_DRV_VICAP_H__
#define __HI_DRV_VICAP_H__

#include "hi_drv_video.h"

#ifdef __cplusplus
#if __cplusplus
extern "C"{
#endif
#endif /* __cplusplus */
#define MIN_VI_FB_NUM 4
#define MAX_VI_FB_NUM 16


typedef enum hiDRV_VICAP_TYPE_E
{
    HI_DRV_VICAP_MAIN = 0,  
    HI_DRV_VICAP_SUB,    /* 一屏双显时使用 */
#ifdef VI_STB_PRODUCT 
    HI_DRV_VICAP_VIRTUAL,/* STB虚拟VI */   
#endif    
    HI_DRV_VICAP_BUTT                        
} HI_DRV_VICAP_TYPE_E;

typedef enum hiDRV_VICAP_3DT2D_MODE_E 
{
    HI_DRV_VICAP_3DT2D_OFF = 0,/* 保留3D格式的左右眼正常播放图像 */
    HI_DRV_VICAP_3DT2D_L,      /* 保留3D格式的左眼图像 */
    HI_DRV_VICAP_3DT2D_R,      /* 保留3D格式的右眼图像 */
    
    HI_DRV_VICAP_3DT2D_BUTT,
} HI_DRV_VICAP_3DT2D_MODE_E;

typedef enum hi_DRV_VICAP_ACCESS_TYPE_E
{
    HI_DRV_VICAP_ACCESS_TVD = 0,
    HI_DRV_VICAP_ACCESS_HDDEC,
    HI_DRV_VICAP_ACCESS_HDMI,
    HI_DRV_VICAP_ACCESS_EXTERN,/* 外部接口，例如:CAMERA */
    
    HI_DRV_VICAP_ACCESS_BUTT
} HI_DRV_VICAP_ACCESS_TYPE_E;

/* Interface mode */
typedef enum hiDRV_VICAP_INTF_MODE_E
{
    HI_DRV_VICAP_INTF_FVHDE = 0,
    HI_DRV_VICAP_INTF_BT601,     
    HI_DRV_VICAP_INTF_BT656,  
    HI_DRV_VICAP_INTF_BT1120, 
    
    HI_DRV_VICAP_INTF_BUTT
} HI_DRV_VICAP_INTF_MODE_E;

typedef enum hiDRV_VICAP_BUF_MGMT_E
{
    HI_DRV_VICAP_BUF_ALLOC = 0,  /**<VI alloc buffer *//**<CNcomment: VI申请帧BUF */
    HI_DRV_VICAP_BUF_MMAP,       /**<User alloc frame buffer, then maps it to VI *//**<CNcomment: 用户申请帧BUF，并映射给VI */
    
    HI_DRV_VICAP_BUF_BUTT
} HI_DRV_VICAP_BUF_MGMT_E;

typedef struct hiDRV_VICAP_BUF_ATTR_S
{
    HI_U32 u32UsrVirAddr[MAX_VI_FB_NUM];  /**<User virtual address *//**<CNcomment: 用户态虚拟地址*/
    HI_U32 u32PhyAddr[MAX_VI_FB_NUM];     /**<Physical address *//**<CNcomment: 物理地址*/
    HI_U32 u32BufNum;                          /**<Buffer number *//**<CNcomment: 缓冲区个数*/
    HI_U32 u32Stride;                          /**<Stride of external frame buffer *//**<CNcomment:外部帧存的stride*/
} HI_DRV_VICAP_BUF_ATTR_S;


typedef struct hi_DRV_VICAP_OUTPUT_ATTR_S
{   
    HI_DRV_VICAP_3DT2D_MODE_E en3DT2DMode;     /* 静态,3D播放模式，由绑定模块(VENC/VDP)确定 */  
    HI_RECT_S                 stCapRect;       /* 动态,stCapRect裁剪区域，用于overscan和非标 */
    HI_U32                    u32DestWidth;    /* 动态,由绑定模块确定输出图像宽度 */
    HI_U32                    u32DestHeight;   /* 动态,由绑定模块确定输出图像高度 */    
    HI_DRV_PIX_FORMAT_E       enVideoFmt;      /* 静态,输出格式 RGB_SP444,YUV_SP444/422/420,由VI内部根据绑定模块(VENC/VDP)确定输出格式 */
    HI_U32                    u32DstFrameRate; /* 动态,默认为输入帧率大于60降成60，小于60不变；或则由绑定模块确认输出帧率 */
    HI_DRV_PIXEL_BITWIDTH_E   enDstBitWidth;   /* 静态,输入为输入位宽为8bit则8bit输出，大于8bit则10bit输出；或则由绑定模块确认输出帧率 */ 
} HI_DRV_VICAP_OUTPUT_ATTR_S;

typedef struct hiDRV_VICAP_ATTR_S
{
    HI_DRV_VICAP_TYPE_E               enType;               /* 实体vi最多创建两路2D或则一路3D */   
    HI_DRV_VICAP_ACCESS_TYPE_E        enAccess;             /* 实体vi对接的输入数据源 */      
    HI_DRV_FRAME_TYPE_E               en3dFmt;              /* 2D/3D 格式 */
    HI_DRV_VICAP_INTF_MODE_E          enIntfMode;           /* 实体vi对接的接口时序类型， */
    HI_BOOL                           bInterlace;         /* 逐行隔行信息 */
    HI_U32                            u32Width;             /* 源图像一帧的宽度,3D格式为单眼宽高 */
    HI_U32                            u32Height;            /* 源图像一帧的高度，即隔行信号是两场的高度，逐行信号是一帧的高度，3D格式为单眼宽高 */
    HI_U32                            u32Vblank;	        /* 场消隐区宽度，用于处理3D格式FP */
    HI_U32                            u32FrameRate;         /* 输入帧率 [24Hz,85] */
    HI_DRV_PIX_FORMAT_E               enPixFmt;             /* 输入像素格式 RGB444,YUV444/422 */ 
    HI_DRV_PIXEL_BITWIDTH_E           enSrcBitWidth;        /* 输入位宽 8/10/12BIT */
    HI_DRV_OVERSAMPLE_MODE_E          enOverSample;     /* 过采样模式 */ 
    HI_DRV_COLOR_SPACE_E              enColorSpace;         /* 色彩空间 */
    HI_DRV_SOURCE_E                   enSourceType;         /* 输入信源类型 */
    HI_DRV_COLOR_SYS_E                enColorSys;           /* ATV/CVBS信源下的彩色制式 */
    HI_BOOL                           bGraphicMode;
    HI_DRV_VICAP_BUF_MGMT_E           enBufMgmtMode;        /* Buf模式，一出2时可独立控制 */    
    HI_U32                            u32BufNum;            /* Buf数目，一出2时可独立控制 */
    HI_DRV_VICAP_OUTPUT_ATTR_S        stOutAttr;            /* 输出属性，一出2时可独立控制 */ 
    HI_BOOL                           bUserOut;        /* 是否支持用户获取帧数据 */ 
} HI_DRV_VICAP_ATTR_S;

/**defines the vicap process buf event.*/
/**CNcomment:定义VICAP处理BUF事件*/
typedef enum
{   
    VICAP_EVENT_BUFLIST_FULL,
    VICAP_EVENT_NEW_FRAME,
    VICAP_EVENT_BUTT,
}HI_DRV_VICAP_EVENT_E;

/**defines the vicap process buf event callback.*/
/**CNcomment:定义VICAP处理BUF事件回调
    VICAP_EVENT_BUFLIST_FULL:采集帧存满
    VICAP_EVENT_NEW_FRAME:新帧采集完成*/
typedef HI_S32 (*PFN_VICAP_CALLBACK)(HI_HANDLE hDst, HI_DRV_VICAP_EVENT_E enEventID, HI_VOID *pstArgs);


HI_S32  HI_DRV_VICAP_Init(HI_VOID);
HI_VOID HI_DRV_VICAP_DeInit(HI_VOID);
HI_S32 HI_DRV_VICAP_Create(HI_DRV_VICAP_ATTR_S *pstVicapAttr, HI_HANDLE *phVicap);
HI_S32  HI_DRV_VICAP_Destroy(HI_HANDLE hVicap);
HI_S32  HI_DRV_VICAP_Start(HI_HANDLE hVicap);
HI_S32  HI_DRV_VICAP_Stop(HI_HANDLE hVicap);
HI_S32  HI_DRV_VICAP_GetOutputAttr(HI_HANDLE hVicap, HI_DRV_VICAP_OUTPUT_ATTR_S *pstOutAttr);
HI_S32  HI_DRV_VICAP_SetOutputAttr(HI_HANDLE hVicap, HI_DRV_VICAP_OUTPUT_ATTR_S *pstOutAttr);

/*虚拟VI使用*/
HI_S32  HI_DRV_VICAP_SetExtBuf(HI_HANDLE hVicap, HI_DRV_VICAP_BUF_ATTR_S *pstBufAttr);

/* 获取/释放采集图像帧 */
HI_S32  HI_DRV_VICAP_AcquireFrame(HI_HANDLE hVicap, HI_DRV_VIDEO_FRAME_S *pFrameInfo);
HI_S32  HI_DRV_VICAP_ReleaseFrame(HI_HANDLE hVicap, HI_DRV_VIDEO_FRAME_S *pFrameInfo);

/* 用户获取采集图像帧 */
HI_S32 HI_DRV_VICAP_UserAcquireFrame(HI_HANDLE hVicap, HI_DRV_VIDEO_FRAME_S *pFrameInfo, HI_U32 u32TimeoutMs);
/* 用户释放采集图像帧 */
HI_S32 HI_DRV_VICAP_UserReleaseFrame(HI_HANDLE hVicap, HI_DRV_VIDEO_FRAME_S *pFrameInfo);

/* 回调，返回buf事件 */
HI_S32  HI_DRV_VICAP_RegistHook(HI_HANDLE hVicap, HI_HANDLE hDst, PFN_VICAP_CALLBACK pfVicapCallback);


#ifdef __cplusplus
#if __cplusplus
}
#endif
#endif /* __cplusplus */

#endif/* __HI_DRV_VICAP_H__ */
