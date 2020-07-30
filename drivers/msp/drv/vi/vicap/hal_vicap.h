/******************************************************************************

  Copyright (C), 2012-2050, Hisilicon Tech. Co., Ltd.

 ******************************************************************************
  File Name     : hal_vicap.h
  Version       : Initial Draft
  Author        : Hisilicon multimedia software group
  Created       : 2013/11/147
  Description   : 
  History       :
  1.Date        : 2013/11/14
    Author      : w00248302/c186004
    Modification: Created file
******************************************************************************/

#ifndef __HAL_VICAP_H__
#define __HAL_VICAP_H__

#include "hi_drv_video.h"
#include "hi_reg_common.h"

#ifdef __cplusplus
#if __cplusplus
extern "C"{
#endif
#endif /* __cplusplus */

#define VICAP_HAL_NO_HSCALE_STEP 1048576
#define VICAP_HAL_NO_VSCALE_STEP 1

#define VICAP_REGS_ADDR        0xFF200000
#define VICAP_REGS_SIZE        0x10000

#define MAXPT    2
#define MAXCHN   2

/*端口*/
#define   VICAP_PHYPT_PT0   0
#define   VICAP_PHYPT_PT1  1   

/*通道*/
#define   VICAP_PHYCHN_CHN0  0x01
#define   VICAP_PHYCHN_CHN1  0x02

typedef enum hiVICAP_FRAME_FILED_E
{
    VICAP_FRAME_FILED_TOP = 0,
    VICAP_FRAME_FILED_BOTTOM,
    VICAP_FRAME_FILED_FRAME,
    
    VICAP_FRAME_FILED_BUTT,
} VICAP_FRAME_FILED_E;


typedef enum hiVICAP_OUT_STANDING_E
{
    VICAP_OUT_ONE = 0,
    VICAP_OUT_TWO,
    VICAP_OUT_THREE,
    VICAP_OUT_FOUR,
    VICAP_OUT_FIVE,
    VICAP_OUT_SIX,
    VICAP_OUT_SEVEN,
    VICAP_OUT_EIGHT,
    
    VICAP_OUT_BUTT,
} VICAP_OUT_STANDING_E;


/* 中断使能掩码或中断状态位 */
typedef enum hiVICAP_CHN_INT_E
{
    VICAP_CHN_INT_FRAMESTART = 0x0001,/* [0]场起始中断*/
    VICAP_CHN_INT_CC         = 0x0002,/* [1]获取完毕中断状态*/
    VICAP_CHN_INT_BUFOVF     = 0x0004,/* [2]内部FIFO溢出错误中断状态*/ 
    VICAP_CHN_INT_FIELDTHROW = 0x0008,/* [3]场数据丢失中断*/        
    VICAP_CHN_INT_UPDATECFG  = 0x0010,/* [4]工作寄存器更新中断*/                        
    VICAP_CHN_INT_YBUSERR    = 0x0020,/* [5]Y数据通路总线错误中断状态*/  
    VICAP_CHN_INT_CBUSERR    = 0x0040,/* [6]C数据通路总线错误中断状态*/ 

    VICAP_CHN_INT_BUTT,
} VICAP_CHN_INT_E;

typedef enum hiVICAP_FIELD_SEL_E
{
    VICAP_FIELD_SEL_FIELD = 0,  /* 奇偶场信号 */
    VICAP_FIELD_SEL_VSYNC,      /* 场同步信号 */
    VICAP_FIELD_SEL_VSYNC_HSYNC,/* 根据vsync和hsync的关系检测 */
    VICAP_FIELD_SEL_ZERO,       /* FIELD信号始终为0 */
    
    VICAP_FIELD_SEL_BUTT,
} VICAP_FIELD_SEL_E;

typedef enum hiVICAP_VSYNC_MODE_E
{
    VICAP_VSYNC_MODE_OFF = 0,      /* 不处理 */
    VICAP_VSYNC_MODE_SINGLE_UP,    /* 上升沿触发一次为一个VSYNC */
    VICAP_VSYNC_MODE_SINGLE_DOUBLE,/* 双沿模式触发一次为一个VSYNC */
    
    VICAP_VSYNC_MODE_BUTT,
} VICAP_VSYNC_MODE_E;

typedef enum hiVICAP_VSYNC_SEL_E
{
    VICAP_VSYNC_SEL_VSYNC = 0,/* 场同步信号 */    
    VICAP_VSYNC_SEL_FIELD,    /* 奇偶场信号 */  
    VICAP_VSYNC_SEL_ZERO,     /* VSYNC信号始终为0 */
    
    VICAP_VSYNC_SEL_BUTT,
} VICAP_VSYNC_SEL_E;

typedef enum hiVICAP_HSYNC_MODE_E
{
    VICAP_HSYNC_MODE_OFF = 0,  /* 不处理 */
    VICAP_HSYNC_MODE_SINGLE_UP,/* 上升沿触发一次为一个HSYNC */
    
    VICAP_HSYNC_MODE_BUTT,
} VICAP_HSYNC_MODE_E;

typedef enum hiVICAP_HSYNC_AND_E
{
    VICAP_HSYNC_AND_OFF = 0, /* 不处理 */
    VICAP_HSYNC_AND_VSYNCINV,/* hsync与vsync极性相与 */
    VICAP_HSYNC_XOR_VSYNCINV,/* hsync与vsync极性异或 */
    
    VICAP_HSYNC_AND_BUTT,
} VICAP_HSYNC_AND_E;

typedef enum hiVICAP_HSYNC_SEL_E
{
    VICAP_HSYNC_SEL_HSYNC = 0,/* 水平同步信号 */    
    VICAP_HSYNC_SEL_DE,       /* 数据有效信号 */
    VICAP_HSYNC_SEL_ZERO,     /* HSYNC信号始终为0 */
    
    VICAP_HSYNC_SEL_BUTT,
} VICAP_HSYNC_SEL_E;

typedef enum hiVICAP_DE_SEL_E
{
    VICAP_DE_SEL_DE = 0,   /* 数据有效信号 */
    VICAP_DE_SEL_HSYNC_AND,/* hsync与vsync极性处理后的结果 */
    VICAP_DE_SEL_ONE,      /* HSYNC信号始终为1 */
    VICAP_DE_SEL_ZERO,     /* HSYNC信号始终为0 */
    
    VICAP_DE_SEL_BUTT,
} VICAP_DE_SEL_E;

typedef struct hiSIZE_S
{
    HI_U32 u32Width;
    HI_U32 u32Height;
} SIZE_S;

typedef enum hiVICAP_DITHER_CFG_E
{
    VICAP_DITHER_10BIT = 0,/* 10bit输出 */
    VICAP_DITHER_8BIT,   /* 8bit输出 */
    
    VICAP_DITHER_BUTT,
} VICAP_DITHER_CFG_E;

/*缩放属性针对对象*/
typedef enum hiVICAP_CHN_SCALE_OBJ_E
{
    VICAP_CHN_SCALE_OBJ_YH = 0,
    VICAP_CHN_SCALE_OBJ_CH,
    
    VICAP_CHN_SCALE_OBJ_BUTT,
} VICAP_CHN_SCALE_OBJ_E;

/*缩放模式*/
typedef enum hiVICAP_CHN_SCALE_MODE_E
{
    VICAP_CHN_SCALE_MODE_FILT = 0,
    VICAP_CHN_SCALE_MODE_COPY,
    
    VICAP_CHN_SCALE_MODE_BUTT,
} VICAP_CHN_SCALE_MODE_E;

typedef enum hiVICAP_CHN_COEF_UPDATE_E
{
    VICAP_CHN_LHCOEF_UPDATE = 0,
    VICAP_CHN_CHCOEF_UPDATE,
    
    VICAP_CHN_COEF_BUTT,
} VICAP_CHN_COEF_UPDATE_E;


typedef enum hiVICAP_UPDATE_SCALE_TYPE_E
{
    VICAP_UPDATE_SCALE_PARAM = 0,/*更新除缩放系数外的其它缩放参数*/
    VICAP_UPDATE_SCALE_COEF,     /*更新缩放系数*/
    
    VICAP_UPDATE_SCALE_BUTT,
} VICAP_UPDATE_SCALE_TYPE_E;


/*port 输入时序FVHDE配置*/
typedef struct hiVICAP_SYNC_CFG_S
{
    HI_BOOL            bFieldInv;  /* 奇偶场信号的极性 */  
    VICAP_FIELD_SEL_E  enFieldSel; /* 奇偶场信号的选择 */
    VICAP_VSYNC_MODE_E enVsyncMode;/* 垂直同步处理模式 */
    HI_BOOL            bVsyncInv;  /* 垂直同步信号极性 */     
    VICAP_VSYNC_SEL_E  enVsyncSel; /* 垂直同步信号的选择 */
    VICAP_HSYNC_MODE_E enHsyncMode;/* 行同步处理模式 */
    VICAP_HSYNC_AND_E  enHsyncAnd; /* 行同步与场同步极性的处理 */ 
    HI_BOOL            bHsyncInv;  /* 行同步信号的极性 */
    VICAP_HSYNC_SEL_E  enHsyncSel; /* 行同步信号的选择 */
    HI_BOOL            bDeInv;     /* 数据有效信号的极性 */
    VICAP_DE_SEL_E     enDeSel;    /* 数据有效信号的选择 */
} VICAP_SYNC_CFG_S;

/* 接口模式 */
typedef enum hiVICAP_INTF_MODE_E
{
    VICAP_INTF_MODE_FVHDE = 0,
    VICAP_INTF_MODE_BT601,
    VICAP_INTF_MODE_BT656,
    VICAP_INTF_MODE_BT1120,
    
    VICAP_INTF_MODE_BUTT
} VICAP_INTF_MODE_E;


typedef enum hiVICAP_COMP_MODE_E
{
    VICAP_COMP_MODE_SINGLE = 0,/* 单分量 */
    VICAP_COMP_MODE_DOUBLE,    /* 双分量 */
    VICAP_COMP_MODE_THREE,     /* 三分量 */
    
    VICAP_COMP_MODE_BUTT,   
} VICAP_COMP_MODE_E;

typedef enum hiVICAP_FILED_MODE_E
{
    VICAP_FILED_MODE_TOP = 0,   /* 顶场 */
    VICAP_FILED_MODE_BOTTOM,    /* 底场 */
    
    VICAP_FILED_MODE_BUTT,   
} VICAP_FILED_MODE_E;

typedef enum hiVICAP_HEDTWORD_MODE_E
{
    VICAP_HEDTWORD_MODE_128BIT = 0,
    VICAP_HEDTWORD_MODE_256BIT,
    
    VICAP_HEDTWORD_MODE_BUTT,
} VICAP_HEDTWORD_MODE_E;

typedef enum hiVICAP_CMP_MODE_E
{
    VICAP_CMP_MODE_128pix = 0,
    VICAP_CMP_MODE_192pix_256pix,
    
    VICAP_CMP_MODE_BUTT,
} VICAP_CMP_MODE_E;

/*VICAP图像存储信息*/
typedef struct hiVICAP_ADDR_S
{
    HI_U32 u32YAddr;
    HI_U32 u32CAddr;
    //HI_U32 u32YStride;
    //HI_U32 u32CStride;
} VICAP_ADDR_S;

typedef enum hiVICAP_WCH_MODE_E
{
    VICAP_WCH_MODE_Y = 0,
    VICAP_WCH_MODE_C,
        
    VICAP_WCH_MODE_BUTT,

}VICAP_WCH_MODE_E;


/*WCH_CFG*/
typedef struct hiVICAP_WCH_CFG_S
{
    HI_BOOL                 bInterlace;
    VICAP_FILED_MODE_E      enFiled;
    HI_DRV_PIXEL_BITWIDTH_E enBitWidth;
    VICAP_HEDTWORD_MODE_E   enHeadTword;
    VICAP_CMP_MODE_E        enCmpMode;
    HI_BOOL                 benableCmp;
}VICAP_WCH_CFG_S;


typedef struct hiVICAP_SCALE_ATTR_S
{
    HI_U32 u32InImgWidth;/*输入图像宽度*/
    HI_U32 u32InImgHeight;/*输入图像高度*/
    HI_U32 u32OutImgWidth;/*输出图像宽度*/
    HI_U32 u32OutImgHeight;/*输入图像高度*/
    HI_DRV_PIX_FORMAT_E enPixFormat;/*像素格式*/ 
    HI_DRV_PIX_FORMAT_E  enVideoFmt;/*视频存储格式*/
} VICAP_SCALE_ATTR_S;

typedef struct hiVICAP_SCALE_SIZE_S
{
    HI_U32 u32YInPixel;/*输入图像Y宽度*/
    HI_U32 u32YInLine;/*输入图像Y高度*/
    HI_U32 u32YOutPixel;/*输出图像Y宽度*/
    HI_U32 u32YOutLine;/*输入图像Y高度*/
    HI_U32 u32CInPixel;/*输入图像Y宽度*/
    HI_U32 u32CInLine;/*输入图像Y高度*/
    HI_U32 u32COutPixel;/*输出图像Y宽度*/
    HI_U32 u32COutLine;/*输入图像Y高度*/
} VICAP_SCALE_SIZE_S;

/* 通道裁剪配置 */
typedef struct hiVICAP_CROP_CFG_S
{
    HI_BOOL   bCropEn[2];   /* 通道有两个裁剪区域的开关 */
    HI_RECT_S stCropRect[2];/* 通道有两个裁剪区域 */
} VICAP_CROP_CFG_S;

/*CSC 矩阵系数结构*/
typedef struct  hiVICAP_CSC_COEF_S
{
    HI_S32 csc_coef00;
    HI_S32 csc_coef01;
    HI_S32 csc_coef02;

    HI_S32 csc_coef10;
    HI_S32 csc_coef11;
    HI_S32 csc_coef12;

    HI_S32 csc_coef20;
    HI_S32 csc_coef21;
    HI_S32 csc_coef22;
} VICAP_CSC_COEF_S;

typedef struct  hiVICAP_CSC_DCCOEF_S
{
    HI_S32 csc_in_dc0;
    HI_S32 csc_in_dc1;
    HI_S32 csc_in_dc2;

    HI_S32 csc_out_dc0;
    HI_S32 csc_out_dc1;
    HI_S32 csc_out_dc2;
} VICAP_CSC_DCCOEF_S;

typedef enum hiVICAP_FILED_FRAME_E
{
    VICAP_FILED_FRAME_TOP = 0,
    VICAP_FILED_FRAME_BOTTOM,
    VICAP_FILED_FRAME_FRAME,
    
    VICAP_FILED_FRAME_BUTT,
} VICAP_FILED_FRAME_E;

/* Wch配置 */
typedef struct hiVICAP_CHN_WCH_CFG_S
{
   VICAP_FILED_FRAME_E      enField; 
   HI_BOOL                  bInterlace;
   HI_DRV_PIXEL_BITWIDTH_E  enDstBitWidth;
} VICAP_CHN_WCH_CFG_S;

typedef enum hiVICAP_SCALE_COEFPARA_E
{
    VICAP_SCALE_COEFPARA_NO = 0,
    VICAP_SCALE_COEFPARA_2X,
    VICAP_SCALE_COEFPARA_3X,
    VICAP_SCALE_COEFPARA_4X,
    VICAP_SCALE_COEFPARA_OTHER,
        
    VICAP_SCALE_COEFPARA_BUTT,

}VICAP_SCALE_COEFPARA_E;

/* CRG总线时钟门控 */
HI_VOID VICAP_HAL_SetBusClken(HI_BOOL bEnable);
/* CRG PT 时钟门控 */ 
HI_VOID VICAP_HAL_SetPtClken(HI_U32 u32PtIndex, HI_BOOL bEnable);
/* CRG PPC 时钟门控 */ 
HI_VOID VICAP_HAL_SetPpcClken(HI_U32 u32ChnIndex, HI_BOOL bEnable);

/* CRG总线复位 */
HI_VOID VICAP_HAL_SetBusReset(HI_BOOL bEnable);
/* CRG PT 复位 */
HI_VOID VICAP_HAL_SetPtReset(HI_U32 u32PtIndex, HI_BOOL bEnable);
/* CRG PPC 复位 */
HI_VOID VICAP_HAL_SetPpcReset(HI_U32 u32ChnIndex, HI_BOOL bEnable);


/* 初始化 */
HI_S32 VICAP_HAL_BoardInit(HI_VOID);

/* 去初始化 */
HI_VOID VICAP_HAL_BoardDeInit(HI_VOID);

/*清除中断*/
HI_VOID VICAP_HAL_ClrChnIntStatus(HI_U32 s32ChnIndex, HI_U32 u32ClrInt);

/*获取中断状态*/
HI_S32 VICAP_HAL_GetChnIntStatus(HI_U32 s32ChnIndex);

/*端口是否使能*/
HI_S32  VICAP_HAL_GetPtIntfMode(HI_U32 s32PtIndex);

/*yuv422上采样到YUV444*/
HI_VOID VICAP_HAL_SetPortUpToYuv444(HI_U32 u32PtIndex,HI_BOOL bUptoYuv444);

/* 设置接口模式 */
HI_VOID VICAP_HAL_SetPortIntfMode(HI_U32 u32PtIndex,VICAP_INTF_MODE_E enIntfMode);

/* 设置端口的分量模式 */
HI_VOID VICAP_HAL_SetPortCompMode(HI_U32 u32PtIndex,VICAP_COMP_MODE_E enCompMode);

/* 设置端口三分量的偏移/掩码 */
HI_VOID VICAP_HAL_SetPortDataLayout(HI_U32 u32PtIndex,HI_U32 au32Offset[3], HI_U32 au32CompMask[3]);

/* 设置端口FVHDE同步信号的配置 */
HI_VOID VICAP_HAL_SetPortSyncCfg(HI_U32 u32PtIndex,VICAP_SYNC_CFG_S *pstSyncCfg);

/* 设置端口中断mask */
HI_VOID VICAP_HAL_SetPortIntMask(HI_U32 u32PtIndex,HI_U32 u32IntMask);

/* 禁用/使能端口 */
HI_VOID VICAP_HAL_SetPortEn(HI_U32 u32PtIndex,HI_BOOL bEnalbe);

/* 设置通道的亮度SKIP信息 */
HI_VOID VICAP_HAL_SetSkipYCfg(HI_U32 s32ChnIndex, HI_U32 u32SkipCfg);

/* 设置通道的色度SKIP信息*/
HI_VOID VICAP_HAL_SetSkipCCfg(HI_U32 s32ChnIndex, HI_U32 u32SkipCfg);

/*Y分量跨度*/
HI_VOID VICAP_HAL_SetWchYStride(HI_U32 s32ChnIndex, HI_U32 u32YStride);

/*C分量跨度*/
HI_VOID VICAP_HAL_SetWchCStride(HI_U32 s32ChnIndex, HI_U32 u32CStride);

/* VI全局中断mask */
HI_VOID VICAP_HAL_SetVicapIntChnMask(HI_U32 u32ChnIndex,HI_BOOL bValid);
HI_VOID VICAP_HAL_SetVicapIntPtMask(HI_U32 u32PtIndex,HI_BOOL bValid);



/*通道中断mask*/
HI_VOID VICAP_HAL_SetChnIntMask(HI_U32 s32ChnIndex, HI_U32 u32IntMask);

/*使能/禁用通道*/
HI_VOID VICAP_HAL_SetChnEn(HI_U32 s32ChnIndex, HI_BOOL bEn);

/*获取通道使能状态*/
HI_S32 VICAP_HAL_GetChnEnStatus(HI_U32 s32ChnIndex);

/* 获取当前场是否为顶场(奇场)，隔行信号有效 */
VICAP_FRAME_FILED_E VICAP_HAL_IsTopField(HI_U32 u32PtIndex);

/* 
 * 设置通道裁剪区域
 * 图像一行的宽度(以像素为单位)，配置值为实际值减1 
 * 获取图像的高度(以行为单位)，配置值为实际值减1
 */
HI_VOID VICAP_HAL_SetChnCrop(HI_U32 s32ChnIndex, VICAP_CROP_CFG_S *pstCropCfg);

/* 设置通道DITHER模式信息 */
HI_VOID VICAP_HAL_SetDitherCfg(HI_U32 s32ChnIndex, VICAP_DITHER_CFG_E enDitherCfg);

/*CSC使能*/
HI_VOID VICAP_HAL_SetChnCscEn(HI_U32 s32ChnIndex, HI_BOOL bEnableCsc);


/*配置CSC参数*/
HI_VOID VICAP_HAL_SetChnCsc(HI_U32 s32ChnIndex, VICAP_CSC_COEF_S *pstVicapCSCCoef, VICAP_CSC_DCCOEF_S *pstVicapCSCDCCoef);


/* 设置缩放输入输出宽度 */
HI_S32 VICAP_HAL_SetScaleSize(HI_S32 s32ChnIndex, VICAP_CHN_SCALE_OBJ_E enObj, VICAP_SCALE_SIZE_S *pstScaleSize);

/*水平缩放配置*/
HI_S32 VICAP_HAL_SetHScale(HI_U32 s32ChnIndex, VICAP_CHN_SCALE_OBJ_E enObj, HI_U32 u32Ratio,VICAP_CHN_SCALE_MODE_E enMode, HI_BOOL bMidEn, HI_BOOL bScaleEn);

/*垂直缩放配置*/
HI_S32 VICAP_HAL_SetVScale(HI_U32 s32ChnIndex, VICAP_CHN_SCALE_OBJ_E enObj, HI_U32 u32Ratio,HI_BOOL bScaleEn);

/* 水平缩放使能 */
HI_S32 VICAP_HAL_HScaleEn(HI_U32 s32ChnIndex, VICAP_CHN_SCALE_OBJ_E enObj, HI_BOOL bEn);

/*垂直缩放使能*/
HI_S32 VICAP_HAL_VScaleEn(HI_U32 s32ChnIndex, VICAP_CHN_SCALE_OBJ_E enObj,HI_BOOL bScaleEn);

/* 设置水平缩放8阶系数 */
HI_S32 VICAP_HAL_SetHScaleCoef8Phase(HI_S32 s32ChnIndex, VICAP_CHN_SCALE_OBJ_E enObj, VICAP_SCALE_COEFPARA_E eYCoefPara);

/* 设置水平缩放参数更新 */
HI_S32 VICAP_HAL_SetCoefUpdate(HI_S32 s32ChnIndex, VICAP_CHN_COEF_UPDATE_E enMod);


HI_VOID VICAP_HAL_SetChnWchSize(HI_U32 s32ChnIndex,HI_U32 u32Width, HI_U32 u32Height,VICAP_WCH_MODE_E enWchMode);

HI_VOID VICAP_HAL_SetChnWchCfg(HI_U32 s32ChnIndex,VICAP_CHN_WCH_CFG_S *stWchCfg,VICAP_WCH_MODE_E enWchMode);

HI_VOID VICAP_HAL_SetChnWchAddr(HI_U32 s32ChnIndex,VICAP_ADDR_S *stVicapAddr,VICAP_WCH_MODE_E enWchMode);

/* 设置通道更新寄存器 */
HI_VOID VICAP_HAL_SetRegNewer(HI_S32 s32ChnIndex);

/* 初始化硬件 */
HI_VOID VICAP_HAL_Init(HI_VOID);

/*端口时钟选择*/
HI_VOID VICAP_HAL_SetPtClk(HI_U32 u32PtIndex);

/*通道时钟选择*/
HI_VOID VICAP_HAL_SetChnClk(HI_U32 u32PtIndex,HI_U32 u32ChnIndex);

HI_VOID VicapHalDumpReg(HI_VOID);


#ifdef __cplusplus
#if __cplusplus
}
#endif
#endif /* __cplusplus */

#endif/* __HAL_VICAP_H__ */

