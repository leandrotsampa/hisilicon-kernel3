/******************************************************************************
*
* Copyright (C) 2015 Hisilicon Technologies Co., Ltd.  All rights reserved. 
*
* This program is confidential and proprietary to Hisilicon  Technologies Co., Ltd. (Hisilicon), 
* and may not be copied, reproduced, modified, disclosed to others, published or used, in
* whole or in part, without the express prior written permission of Hisilicon.
*
******************************************************************************
File Name	    : jpeg_drv_parse.c
Version		    : Initial Draft
Author		    : 
Created		    : 2015/01/25
Description	    :
Function List 	: 

			  		  
History       	:
Date				Author        		Modification
2015/01/25		    y00181162  		    Created file      	
******************************************************************************/

/*********************************add include here******************************/
#include "jpeg_drv_parse.h"
#include "jpeg_drv_error.h"

#ifdef CONFIG_GFX_256BYTE_ALIGN
#include "hi_math.h"
#endif

#ifdef CONFIG_JPEG_OMX_FUNCTION

/***************************** Macro Definition ******************************/

#define JPG_TAG     0xFF

#define INPUT_BYTE(curpos0,curpos1,datavir0,datavir1,datalen0,code)  \
	    if(curpos0 < datalen0)                        \
        {\
            code = *(HI_U8*)(datavir0 + curpos0);     \
            curpos0++;                                \
        }\
        else\
        {\
            code = *(HI_U8*)(datavir1 + curpos1);     \
            curpos1++;                                \
        }

#define INPUT_2BYTE(curpos0,curpos1,datavir0,datavir1,datalen0,code)  \
	    if((curpos0 + 1) < datalen0)\
        {\
            code = ((*(HI_U8*)(datavir0 + curpos0)) << 8) + (*(HI_U8*)(datavir0 + curpos0 + 1)); \
            curpos0 += 2;\
        }\
        else if((curpos0 + 1) == datalen0) \
        {\
            code = ((*(HI_U8*)(datavir0 + curpos0)) << 8) + (*(HI_U8*)(datavir1 + curpos1));     \
            curpos0++;  \
            curpos1++;  \
        }\
        else\
        {\
            code = ((*(HI_U8*)(datavir1 + curpos1)) << 8) + (*(HI_U8*)(datavir1 + curpos1 + 1)); \
            curpos1 += 2;\
        }


#define INPUT_BYTE_DATA(handle,code,byte)\
        {\
            IMAG_INFO_S *pstImgInfo = (IMAG_INFO_S*)(unsigned long)handle;\
            if(1 == byte)\
            {\
                INPUT_BYTE(pstImgInfo->u32CurPos[0], pstImgInfo->u32CurPos[1],  \
                           pstImgInfo->pDataVir[0],  pstImgInfo->pDataVir[1],   \
                           pstImgInfo->u32DataLen[0],code);\
            }\
            else\
            {\
                INPUT_2BYTE(pstImgInfo->u32CurPos[0], pstImgInfo->u32CurPos[1],  \
                            pstImgInfo->pDataVir[0],  pstImgInfo->pDataVir[1],   \
                            pstImgInfo->u32DataLen[0],code);\
            }\
        }


#define OUT_ROUND_UP(a,b)                   ( ((a) + (b) - (1)) / (b) )


/*************************** Structure Definition ****************************/

typedef enum tagJPEGMARKE{
  M_JPEG_SOF0  = 0xc0,
  M_JPEG_SOF1  = 0xc1,
  M_JPEG_SOF2  = 0xc2,
  M_JPEG_SOF3  = 0xc3,
  
  M_JPEG_SOF5  = 0xc5,
  M_JPEG_SOF6  = 0xc6,
  M_JPEG_SOF7  = 0xc7,
  
  M_JPEG_JPG   = 0xc8,
  M_JPEG_SOF9  = 0xc9,
  M_JPEG_SOF10 = 0xca,
  M_JPEG_SOF11 = 0xcb,
  
  M_JPEG_SOF13 = 0xcd,
  M_JPEG_SOF14 = 0xce,
  M_JPEG_SOF15 = 0xcf,
  
  M_JPEG_DHT   = 0xc4,
  
  M_JPEG_DAC   = 0xcc,
  
  M_JPEG_RST0  = 0xd0,
  M_JPEG_RST1  = 0xd1,
  M_JPEG_RST2  = 0xd2,
  M_JPEG_RST3  = 0xd3,
  M_JPEG_RST4  = 0xd4,
  M_JPEG_RST5  = 0xd5,
  M_JPEG_RST6  = 0xd6,
  M_JPEG_RST7  = 0xd7,
  
  M_JPEG_SOI   = 0xd8,
  M_JPEG_EOI   = 0xd9,
  M_JPEG_SOS   = 0xda,
  M_JPEG_DQT   = 0xdb,
  M_JPEG_DNL   = 0xdc,
  M_JPEG_DRI   = 0xdd,
  M_JPEG_DHP   = 0xde,
  M_JPEG_EXP   = 0xdf,
  
  M_JPEG_APP0  = 0xe0,
  M_JPEG_APP1  = 0xe1,
  M_JPEG_APP2  = 0xe2,
  M_JPEG_APP3  = 0xe3,
  M_JPEG_APP4  = 0xe4,
  M_JPEG_APP5  = 0xe5,
  M_JPEG_APP6  = 0xe6,
  M_JPEG_APP7  = 0xe7,
  M_JPEG_APP8  = 0xe8,
  M_JPEG_APP9  = 0xe9,
  M_JPEG_APP10 = 0xea,
  M_JPEG_APP11 = 0xeb,
  M_JPEG_APP12 = 0xec,
  M_JPEG_APP13 = 0xed,
  M_JPEG_APP14 = 0xee,
  M_JPEG_APP15 = 0xef,
  
  M_JPEG_JPG0  = 0xf0,
  M_JPEG_JPG13 = 0xfd,
  M_JPEG_COM   = 0xfe,
  
  M_JPEG_TEM   = 0x01,
  
  M_JPEG_ERROR = 0x100
} JPEG_MARK_E;

/********************** Global Variable declaration **************************/

/******************************* API forward declarations *******************/

/******************************* API realization *****************************/

/***************************************************************************************
* func			: jpeg_para_getstride
* description	: get stride
				  CNcomment: 计算stride CNend\n
* retval		: HI_SUCCESS 成功
* retval		: HI_FAILURE 失败
* others:		: NA
***************************************************************************************/
static HI_VOID jpeg_para_getstride(HI_U32 u32SrcW, HI_U32 *pu32Stride,HI_U32 u32Align)
{
#ifndef HI_BUILD_IN_BOOT
	#ifdef CONFIG_GFX_256BYTE_ALIGN
		 *pu32Stride = u32Align;
		 *pu32Stride = HI_SYS_GET_STRIDE(u32SrcW);
	#else
		 *pu32Stride = (u32SrcW + u32Align - 1) & (~(u32Align - 1));
	#endif
#else
	*pu32Stride = (u32SrcW + u32Align - 1) & (~(u32Align - 1));
#endif
}

/***************************************************************************************
* func			: parse_fist_marker
* description	: parse first mark.
				  CNcomment: 解析第一个标记 CNend\n
* retval		: HI_SUCCESS 成功
* retval		: HI_FAILURE 失败
* others:		: NA
***************************************************************************************/
static HI_BOOL parse_fist_marker(HI_U64 u64DecHandle)
{
    HI_S32 s32Code  = 0;
    HI_S32 s32Code1 = 0;

#ifdef CONIFG_PARSE_DEBUG
    mdelay(100);
    JPEG_TRACE("\n===============================================%s %d\n",__func__,__LINE__);
    JPEG_TRACE("begin parse_fist_marker\n");
#endif

    INPUT_BYTE_DATA(u64DecHandle,s32Code,1);
    INPUT_BYTE_DATA(u64DecHandle,s32Code1,1);

#ifdef CONIFG_PARSE_DEBUG
    JPEG_TRACE("s32Code = 0x%x,s32Code1 = 0x%x\n",s32Code,s32Code1);
    JPEG_TRACE("end parse_fist_marker\n");
    JPEG_TRACE("===============================================%s %d\n",__func__,__LINE__);
    mdelay(100);
#endif

    if(JPG_TAG == s32Code && M_JPEG_SOI == s32Code1)
    {
        return HI_TRUE;
    }
    
    return HI_FALSE;
    
}

/***************************************************************************************
* func			: parse_next_marker
* description	: parse next mark.
				  CNcomment: 解析下一个标记 CNend\n
* retval		: HI_SUCCESS 成功
* retval		: HI_FAILURE 失败
* others:		: NA
***************************************************************************************/
static HI_S32 parse_next_marker(HI_U64 u64DecHandle,HI_S32 *ps32Mark)
{

    HI_S32 s32Code = 0;
    IMAG_INFO_S *pstImgInfo = (IMAG_INFO_S*)(unsigned long)u64DecHandle;

	if(0 == pstImgInfo->u32DataLen[1])
	{
	    while(pstImgInfo->u32CurPos[0] < pstImgInfo->u32DataLen[0])
	    {
	        INPUT_BYTE_DATA(u64DecHandle,s32Code,1);
	        while(s32Code != 0xFF) 
	        {
	          INPUT_BYTE_DATA(u64DecHandle,s32Code,1);
	        }
	        do
	        {
	          INPUT_BYTE_DATA(u64DecHandle,s32Code,1);
	        } while (s32Code == 0xFF);
	        
	        if (s32Code != 0)
	        {
	           break;
	        }
	    }
	    if(pstImgInfo->u32CurPos[0] == pstImgInfo->u32DataLen[0])
	    {/** 已经解析到头了 **/
			return HI_ERR_JPEG_DATA_SUPPORT;
	    }
	}
    else
    {
		while(pstImgInfo->u32CurPos[0] <= pstImgInfo->u32DataLen[0] && pstImgInfo->u32CurPos[1] < pstImgInfo->u32DataLen[1])
	    {
	        INPUT_BYTE_DATA(u64DecHandle,s32Code,1);
	        while(s32Code != 0xFF) 
	        {
	          INPUT_BYTE_DATA(u64DecHandle,s32Code,1);
	        }
	        do
	        {
	          INPUT_BYTE_DATA(u64DecHandle,s32Code,1);
	        } while (s32Code == 0xFF);
	        
	        if (s32Code != 0)
	        {
	           break;
	        }
	    }
		if(pstImgInfo->u32CurPos[1] == pstImgInfo->u32DataLen[1])
	    {/** 已经解析到头了 **/
			return HI_ERR_JPEG_DATA_SUPPORT;
	    }
    }
    
    *ps32Mark = s32Code;

    return HI_SUCCESS;
}

/***************************************************************************************
* func			: parse_dri_marker
* description	: Process a DRI marker
				  CNcomment: 解析扫描间隔标记 CNend\n
* retval		: HI_SUCCESS 成功
* retval		: HI_FAILURE 失败
* others:		: NA
***************************************************************************************/
static HI_BOOL parse_dri_marker(HI_U64 u64DecHandle)
{
      HI_S32 s32Len  = 0;
      HI_S32 s32Code = 0;
      IMAG_INFO_S *pstImgInfo = (IMAG_INFO_S*)(unsigned long)u64DecHandle;
      
      INPUT_BYTE_DATA(u64DecHandle,s32Len,2);
      
      if(s32Len != 4)
      {
         JPEG_TRACE("the dri len is bad\n");
         return HI_FALSE;
      }

      INPUT_BYTE_DATA(u64DecHandle,s32Code,2);

      pstImgInfo->s32RestartInterval = s32Code;
        
      return HI_TRUE;
}

/***************************************************************************************
* func			: parse_appn_marker
* description	: parse appn data.
				  CNcomment: 过滤这个硬件不感兴趣的标记 CNend\n
* retval		: HI_SUCCESS 成功
* retval		: HI_FAILURE 失败
* others:		: NA
***************************************************************************************/
static HI_BOOL parse_appn_marker(HI_U64 u64DecHandle)
{

	HI_S32 s32Len = 0;
	IMAG_INFO_S *pstImgInfo = (IMAG_INFO_S*)(unsigned long)u64DecHandle;

	INPUT_BYTE_DATA(u64DecHandle,s32Len,2);
	s32Len -= 2;

	if( (pstImgInfo->u32CurPos[0] + s32Len) < pstImgInfo->u32DataLen[0])
	{
		pstImgInfo->u32CurPos[0] = pstImgInfo->u32CurPos[0] + s32Len;
	}
	else
	{
		pstImgInfo->u32CurPos[1] = pstImgInfo->u32CurPos[1] + (s32Len - (pstImgInfo->u32DataLen[0] - pstImgInfo->u32CurPos[0]));
		pstImgInfo->u32CurPos[0] = pstImgInfo->u32DataLen[0];
	}

	return HI_TRUE;
}

/***************************************************************************************
* func			: parse_sofn_marker
* description	: parse sofn data.
				  CNcomment: 解析帧开始标记 CNend\n
* retval		: HI_SUCCESS 成功
* retval		: HI_FAILURE 失败
* others:		: NA
***************************************************************************************/
static HI_BOOL parse_sofn_marker(HI_U64 u64DecHandle)
{

    HI_S32 s32Len = 0;
    HI_S32 s32DataPrecision   = 0;
    HI_S32 s32Code = 0;
    HI_S32 s32Cnt  = 0;
    IMAG_INFO_S *pstImgInfo = (IMAG_INFO_S*)(unsigned long)u64DecHandle;

    INPUT_BYTE_DATA(u64DecHandle,s32Len,2);

    INPUT_BYTE_DATA(u64DecHandle,s32DataPrecision,1);

    if(8 != s32DataPrecision)
    {/** 精度硬件不支持 **/
        JPEG_TRACE("the data precison is %d,hard dec not support\n",s32DataPrecision);
        return HI_FALSE;
    }

    INPUT_BYTE_DATA(u64DecHandle,pstImgInfo->s32InHeight,2);
    INPUT_BYTE_DATA(u64DecHandle,pstImgInfo->s32InWidth,2);
    INPUT_BYTE_DATA(u64DecHandle,pstImgInfo->s32NumComponent,1);

    s32Len -= 8;
    if (s32Len != pstImgInfo->s32NumComponent * 3)
    {
       JPEG_TRACE("the s32Len is larger\n");
       return HI_FALSE;
    }
    if(pstImgInfo->s32NumComponent >= 4)
    {
        JPEG_TRACE("the s32NumComponent is larger,not support\n");
        return HI_FALSE;
    }

    if(pstImgInfo->s32InWidth <= 0 || pstImgInfo->s32InHeight <= 0 || pstImgInfo->s32NumComponent <= 0)
    {
        JPEG_TRACE("the image is empty\n");
        return HI_FALSE;
    }

    if(pstImgInfo->s32InWidth > 8096 || pstImgInfo->s32InHeight > 8096)
    {
        JPEG_TRACE("the image w and h is to large\n");
        return HI_FALSE;
    }
    
    for (s32Cnt = 0; s32Cnt < pstImgInfo->s32NumComponent; s32Cnt++) 
    {

        pstImgInfo->stComponentInfo[s32Cnt].s32ComponentIndex = s32Cnt;

        INPUT_BYTE_DATA(u64DecHandle,pstImgInfo->stComponentInfo[s32Cnt].s32ComponentId,1);
        INPUT_BYTE_DATA(u64DecHandle,s32Code,1);
        pstImgInfo->stComponentInfo[s32Cnt].u8HorSampleFac = (s32Code >> 4) & 15;
        pstImgInfo->stComponentInfo[s32Cnt].u8VerSampleFac = (s32Code     ) & 15;
        INPUT_BYTE_DATA(u64DecHandle,pstImgInfo->stComponentInfo[s32Cnt].s32QuantTblNo,1);
    }

    if(1 == pstImgInfo->s32NumComponent)
    {
       if(pstImgInfo->stComponentInfo[0].u8HorSampleFac == pstImgInfo->stComponentInfo[0].u8VerSampleFac)
       {
    		 pstImgInfo->eImgFmt = IMG_FMT_YUV400;
    		 pstImgInfo->u8Fac[0][0] = 1;
    		 pstImgInfo->u8Fac[0][1] = 1;
    		 pstImgInfo->u8Fac[1][0] = 0;
    		 pstImgInfo->u8Fac[1][1] = 0;
    		 pstImgInfo->u8Fac[2][0] = 0;
    		 pstImgInfo->u8Fac[2][1] = 0;
       }
    }
    else if(   (3 == pstImgInfo->s32NumComponent)  \
             && (pstImgInfo->stComponentInfo[1].u8HorSampleFac == pstImgInfo->stComponentInfo[2].u8HorSampleFac) \
             && (pstImgInfo->stComponentInfo[1].u8VerSampleFac == pstImgInfo->stComponentInfo[2].u8VerSampleFac))
    {
    	if(pstImgInfo->stComponentInfo[0].u8HorSampleFac == ((pstImgInfo->stComponentInfo[1].u8HorSampleFac)<<1))
    	{
    		 if(pstImgInfo->stComponentInfo[0].u8VerSampleFac == ((pstImgInfo->stComponentInfo[1].u8VerSampleFac)<<1))
    		 {
    			 pstImgInfo->eImgFmt = IMG_FMT_YUV420;
    		 }
    		 else if(pstImgInfo->stComponentInfo[0].u8VerSampleFac == pstImgInfo->stComponentInfo[1].u8VerSampleFac)
    		 {
    			  pstImgInfo->eImgFmt = IMG_FMT_YUV422_21;
    		 }
    		 
    	 }
    	 else if(pstImgInfo->stComponentInfo[0].u8HorSampleFac == pstImgInfo->stComponentInfo[1].u8HorSampleFac)
    	 {
    		   if(pstImgInfo->stComponentInfo[0].u8VerSampleFac == ((pstImgInfo->stComponentInfo[1].u8VerSampleFac)<<1))
    		   {
    				pstImgInfo->eImgFmt = IMG_FMT_YUV422_12;
    		   }
    		   else if(pstImgInfo->stComponentInfo[0].u8VerSampleFac == pstImgInfo->stComponentInfo[1].u8VerSampleFac)
    		   {
    				pstImgInfo->eImgFmt = IMG_FMT_YUV444;
    		   }
    	  }
    	  pstImgInfo->u8Fac[0][0] = pstImgInfo->stComponentInfo[0].u8HorSampleFac;
    	  pstImgInfo->u8Fac[0][1] = pstImgInfo->stComponentInfo[0].u8VerSampleFac;
    	  pstImgInfo->u8Fac[1][0] = pstImgInfo->stComponentInfo[1].u8HorSampleFac;
    	  pstImgInfo->u8Fac[1][1] = pstImgInfo->stComponentInfo[1].u8VerSampleFac;
    	  pstImgInfo->u8Fac[2][0] = pstImgInfo->stComponentInfo[2].u8HorSampleFac;
    	  pstImgInfo->u8Fac[2][1] = pstImgInfo->stComponentInfo[2].u8VerSampleFac;
    }
    else
    {
       pstImgInfo->eImgFmt = IMG_FMT_BUTT;
       return HI_FALSE;
    }

    return HI_TRUE;

}
/***************************************************************************************
* func			: parse_sos_marker
* description	: parse sos data.
				  CNcomment: 解析扫描层标记 CNend\n
* retval		: HI_SUCCESS 成功
* retval		: HI_FAILURE 失败
* others:		: NA
***************************************************************************************/
static HI_BOOL parse_sos_marker(HI_U64 u64DecHandle)
{
    HI_S32 s32Len = 0;
    HI_S32 s32NumComponent = 0;
    HI_S32 s32Cnt   = 0;
    HI_S32 s32Cnt1  = 0;
    HI_S32 s32Code  = 0;
    HI_S32 s32Code1 = 0;

#ifndef CONFIG_JPEG_SET_SAMPLEFACTOR/**hifone has revise this bug **/
	/** HSCP201405300013 HSCP201405290010 DTS2014061006717**/
	HI_S32 ci = 0;
	HI_BOOL bY22 = HI_FALSE;
	HI_BOOL bU12 = HI_FALSE;
	HI_BOOL bV12 = HI_FALSE;
#endif

    IMAG_INFO_S *pstImgInfo = (IMAG_INFO_S*)(unsigned long)u64DecHandle;
    
    if(HI_FALSE == pstImgInfo->bSofMark)
    {
        JPEG_TRACE("not has sof befor sos\n");
        return HI_FALSE;
    }

    INPUT_BYTE_DATA(u64DecHandle,s32Len,2);

    INPUT_BYTE_DATA(u64DecHandle,s32NumComponent,1);

    if (s32Len != (s32NumComponent * 2 + 6) || s32NumComponent < 1 || s32NumComponent > NUM_COMPS_IN_SCAN)
    {   
        JPEG_TRACE("the len is larger\n");
        return HI_FALSE;
    }

    /** 扫描行内组件数 **/
    pstImgInfo->s32ComInScan = s32NumComponent;
    if(s32NumComponent > 3)
    {
        JPEG_TRACE("the component num is larger\n");
        return HI_FALSE;
    }
    
    for (s32Cnt = 0; s32Cnt < s32NumComponent; s32Cnt++) 
    {

        INPUT_BYTE_DATA(u64DecHandle,s32Code1,1);
        INPUT_BYTE_DATA(u64DecHandle,s32Code,1);
        
        for (s32Cnt1 = 0; s32Cnt1 < pstImgInfo->s32NumComponent; s32Cnt1++) 
        {
          if (s32Code1 == pstImgInfo->stComponentInfo[s32Cnt1].s32ComponentId)
                goto id_found;
        }
        JPEG_TRACE("can not find component id\n");
        return HI_FALSE;
        
        id_found:
            pstImgInfo->stComponentInfo[s32Cnt1].s32DcTblNo = (s32Code >> 4) & 15;
            pstImgInfo->stComponentInfo[s32Cnt1].s32AcTblNo = (s32Code     ) & 15;
            
    }
    INPUT_BYTE_DATA(u64DecHandle,pstImgInfo->s32Ss,1);
    INPUT_BYTE_DATA(u64DecHandle,pstImgInfo->s32Se,1);
    INPUT_BYTE_DATA(u64DecHandle,s32Code,1);

    pstImgInfo->s32Ah = (s32Code >> 4) & 15;
    pstImgInfo->s32Al = (s32Code     ) & 15;



#ifndef CONFIG_JPEG_SET_SAMPLEFACTOR/**hifone has revise this bug **/
	/** HSCP201405300013 HSCP201405290010 DTS2014061006717**/
	for (ci = 0; ci < pstImgInfo->s32ComInScan; ci++)
	{
		if( (0 == ci) && (2 == pstImgInfo->u8Fac[ci][0]) && (2 == pstImgInfo->u8Fac[ci][1]))
			bY22 = HI_TRUE;
		if( (1 == ci) && (1 == pstImgInfo->u8Fac[ci][0]) && (2 == pstImgInfo->u8Fac[ci][1]))
			bU12 = HI_TRUE;
		if( (2 == ci) && (1 == pstImgInfo->u8Fac[ci][0]) && (2 == pstImgInfo->u8Fac[ci][1]))
			bV12 = HI_TRUE;
	}
	if( (HI_TRUE == bY22) && (HI_TRUE == bU12) && (HI_TRUE == bV12))
	{
		return HI_FAILURE;
	}
	if( (IMG_FMT_YUV444 == pstImgInfo->eImgFmt) && (HI_TRUE == bU12) && (HI_TRUE == bV12))
	{
		return HI_FAILURE;
	}
#endif

    return HI_TRUE;

}

/***************************************************************************************
* func			: parse_dht_marker
* description	: parse dht data.
				  CNcomment: 解析哈夫曼表数据 CNend\n
* retval		: HI_SUCCESS 成功
* retval		: HI_FAILURE 失败
* others:		: NA
***************************************************************************************/
static HI_BOOL parse_dht_marker(HI_U64 u64DecHandle)
{

      HI_S32 s32Len      = 0;
      HI_S32 s32HTIndex  = 0;
      HI_U8 bits[17]     = {0};
      HI_U8 huffval[256] = {0};
      HI_S32 s32Count    = 0;
      HI_S32 s32Cnt      = 0;
      JPEG_HUFF_TBL *htblptr = NULL;
      IMAG_INFO_S *pstImgInfo = (IMAG_INFO_S*)(unsigned long)u64DecHandle;

      INPUT_BYTE_DATA(u64DecHandle,s32Len,2);

      s32Len -= 2;
      
      while (s32Len > 16) 
      {

            INPUT_BYTE_DATA(u64DecHandle,s32HTIndex,1);
            bits[0]  = 0;
            s32Count = 0;
            for(s32Cnt = 1; s32Cnt <= 16; s32Cnt++) 
            {
                  INPUT_BYTE_DATA(u64DecHandle,bits[s32Cnt],1);
                  s32Count += bits[s32Cnt];
            }
            s32Len -= 1 + 16;

            #ifdef CONIFG_PARSE_DEBUG
            JPEG_TRACE("bits1->bits8[%d %d %d %d %d %d %d %d]\n",
                 bits[1], bits[2], bits[3], bits[4],
                 bits[5], bits[6], bits[7], bits[8]);
            JPEG_TRACE("bits9->bits16[%d %d %d %d %d %d %d %d]\n",
                 bits[9], bits[10], bits[11], bits[12],
                 bits[13], bits[14], bits[15], bits[16]);
            #endif
            
            if(s32Count > 256 || s32Count > s32Len)
            {
               JPEG_TRACE("the dht is bad\n");
               return HI_FALSE;
            }
        
            for(s32Cnt = 0; s32Cnt < s32Count; s32Cnt++)
            {
                INPUT_BYTE_DATA(u64DecHandle,huffval[s32Cnt],1);
            }
        
            s32Len -= s32Count;

            if(s32HTIndex & 0x10)
            {/** AC table definition **/
                  s32HTIndex -= 0x10;
                  if(s32HTIndex < 0 || s32HTIndex >= MAX_NUM_HUFF_TBLS)
  	              {/** deal codecc warning **/
  	                JPEG_TRACE("the dht index is error\n");
  	                return HI_FALSE;
  	              }
                  htblptr = &pstImgInfo->AcHuffTbl[s32HTIndex];
                  pstImgInfo->AcHuffTbl[s32HTIndex].bHasHuffTbl = HI_TRUE;
            } 
            else
            {/** DC table definition **/
                  if(s32HTIndex < 0 || s32HTIndex >= MAX_NUM_HUFF_TBLS)
  	              {/** deal codecc warning **/
  	                JPEG_TRACE("the dht index is error\n");
  	                return HI_FALSE;
  	              }
                  htblptr = &pstImgInfo->DcHuffTbl[s32HTIndex];
                  pstImgInfo->DcHuffTbl[s32HTIndex].bHasHuffTbl = HI_TRUE;
                  if(0 == s32HTIndex)
                  {
                    pstImgInfo->s32LuDcLen[0] = bits[11];
                    pstImgInfo->s32LuDcLen[1] = bits[12];
                    pstImgInfo->s32LuDcLen[2] = bits[13];
                    pstImgInfo->s32LuDcLen[3] = bits[14];
                    pstImgInfo->s32LuDcLen[4] = bits[15];
                    pstImgInfo->s32LuDcLen[5] = bits[16];
                  }
            }
            memcpy(htblptr->bits, bits, sizeof(htblptr->bits));
            memcpy(htblptr->huffval, huffval, sizeof(htblptr->huffval));
            
      }

      if (s32Len != 0)
      {
         JPEG_TRACE("the dht len is error\n");
         return HI_FALSE;
      }

#ifndef CONFIG_JPEG_DRI_SUPPORT
      if(      0 != pstImgInfo->s32LuDcLen[0] || 0 != pstImgInfo->s32LuDcLen[1] \
            || 0 != pstImgInfo->s32LuDcLen[2] || 0 != pstImgInfo->s32LuDcLen[3] \
            || 0 != pstImgInfo->s32LuDcLen[4] || 0 != pstImgInfo->s32LuDcLen[5])
      {/** 修改当时dri图片解码花屏问题，要是不符合亮度DC协议规定 **/
         JPEG_TRACE("the dri is not support\n");
         return HI_FALSE;
      }
#endif

      return HI_TRUE;

}


/***************************************************************************************
* func			: parse_dqt_marker
* description	: parse dqt data.
				  CNcomment: 解析量化表数据 CNend\n
* retval		: HI_SUCCESS 成功
* retval		: HI_FAILURE 失败
* others:		: NA
***************************************************************************************/
static HI_BOOL parse_dqt_marker(HI_U64 u64DecHandle)
{
      HI_S32 s32Len  = 0;
      HI_S32 s32Code = 0;
      HI_S32 s32Cnt  = 0;
      HI_U32 tmp     = 0;
      HI_S32 s32Precision = 0;
      JPEG_QUANT_TBL *quantptr = NULL;

      HI_S32 s32Zorder[MAX_DCT_SIZE + 16] = {
                                  0,  1,  8, 16,  9,  2,  3, 10,
                                 17, 24, 32, 25, 18, 11,  4,  5,
                                 12, 19, 26, 33, 40, 48, 41, 34,
                                 27, 20, 13,  6,  7, 14, 21, 28,
                                 35, 42, 49, 56, 57, 50, 43, 36,
                                 29, 22, 15, 23, 30, 37, 44, 51,
                                 58, 59, 52, 45, 38, 31, 39, 46,
                                 53, 60, 61, 54, 47, 55, 62, 63,
                                 63, 63, 63, 63, 63, 63, 63, 63,
                                 63, 63, 63, 63, 63, 63, 63, 63
                              };

      IMAG_INFO_S *pstImgInfo = (IMAG_INFO_S*)(unsigned long)u64DecHandle;

      INPUT_BYTE_DATA(u64DecHandle,s32Len,2);

      s32Len -= 2;

      while (s32Len > 0) 
      {

            INPUT_BYTE_DATA(u64DecHandle,s32Code,1);
            
            s32Precision = s32Code >> 4;
            s32Code &= 0x0F;
            if(s32Code >= MAX_NUM_QUANT_TBLS)
            {
                JPEG_TRACE("the qt table is to larger\n");
                return HI_FALSE;
            }
            pstImgInfo->QuantTbl[s32Code].bHasQuantTbl = HI_TRUE;
            
            quantptr = &pstImgInfo->QuantTbl[s32Code];
                        
            for (s32Cnt = 0; s32Cnt < MAX_DCT_SIZE; s32Cnt++)
            {
                  if(s32Precision)
                  {
                      INPUT_BYTE_DATA(u64DecHandle,tmp,2);
                   }
                  else
                   {
                      INPUT_BYTE_DATA(u64DecHandle,tmp,1);
                   }
                   /** We convert the zigzag-order table to natural array order. **/
                   quantptr->quantval[s32Zorder[s32Cnt]] = (HI_U16)tmp;
            }

            #ifdef CONIFG_PARSE_DEBUG
                for (s32Cnt = 0; s32Cnt < MAX_DCT_SIZE; s32Cnt += 8) 
                {
                     JPEG_TRACE("quantable[%d %d %d %d %d %d %d %d]\n",
                     quantptr->quantval[s32Cnt],   quantptr->quantval[s32Cnt+1],
                     quantptr->quantval[s32Cnt+2], quantptr->quantval[s32Cnt+3],
                     quantptr->quantval[s32Cnt+4], quantptr->quantval[s32Cnt+5],
                     quantptr->quantval[s32Cnt+6], quantptr->quantval[s32Cnt+7]);
                }
                JPEG_TRACE("QuanTbl[%d].bHasQuantTbl = %d\n",s32Code,pstImgInfo->QuantTbl[s32Code].bHasQuantTbl);
            #endif

            s32Len -= MAX_DCT_SIZE + 1;
            if (s32Precision)
            {
                s32Len -= MAX_DCT_SIZE;
            }

      }

      if (s32Len != 0)
      {
         JPEG_TRACE("the dqt len is error\n");
         return HI_FALSE;
      }

      return HI_TRUE;
}

/***************************************************************************************
* func			: jpg_dec_parse
* description	: parse data.
				  CNcomment: 解析码流 CNend\n
* param[in] 	: pstInMsg
* retval		: HI_SUCCESS 成功
* retval		: HI_FAILURE 失败
* others:		: NA
***************************************************************************************/
HI_S32 jpg_dec_parse(HI_DRV_JPEG_INMSG_S *pstInMsg)
{    

    HI_S32 s32Mark = 0;
    IMAG_INFO_S *pstImgInfo = NULL;

    if(NULL == pstInMsg){
        return HI_ERR_JPEG_PARA_NULL;
    }
    
    pstImgInfo = (IMAG_INFO_S*)(unsigned long)(pstInMsg->u64DecHandle);
    if(NULL == pstImgInfo){
        return HI_ERR_JPEG_PARA_NULL;
    }
    
    pstImgInfo->s32RestartInterval = -1;

    /** 输入码流信息 **/
    pstImgInfo->pDataVir[0]   = (HI_CHAR*)(unsigned long)pstInMsg->u64SaveVir[0];
    pstImgInfo->pDataVir[1]   = (HI_CHAR*)(unsigned long)pstInMsg->u64SaveVir[1];
    pstImgInfo->u32DataLen[0] = pstInMsg->u32SaveLen[0];
    pstImgInfo->u32DataLen[1] = pstInMsg->u32SaveLen[1];
    pstImgInfo->u32CurPos[0]  = 0;
    pstImgInfo->u32CurPos[1]  = 0;

    if(! parse_fist_marker(pstInMsg->u64DecHandle))
    {
        JPEG_TRACE("is not a jpeg\n");
        return HI_ERR_JPEG_NOT_JPEG;
    }

    while(pstImgInfo->u32CurPos[0] <= pstImgInfo->u32DataLen[0] && pstImgInfo->u32CurPos[1] <= pstImgInfo->u32DataLen[1])
    {
    
        if(HI_SUCCESS != parse_next_marker(pstInMsg->u64DecHandle,&s32Mark))
        {
    	     return HI_ERR_JPEG_DATA_SUPPORT;
        }
        switch(s32Mark)
        {

            case M_JPEG_SOI: /** start data 0xffd8 **/
                  break;
            /** baseline --- huffman **/
            case M_JPEG_SOF0:
            case M_JPEG_SOF1:
                  if(! parse_sofn_marker(pstInMsg->u64DecHandle))
                  {
            	     return HI_ERR_JPEG_SOFN_EXIT;
                  }
                  pstImgInfo->bSofMark  = HI_TRUE;
                  break;
            /** hard dec not support **/
            case M_JPEG_SOF2:       /** progressive                          **/
            case M_JPEG_SOF9:       /** arithmetic                           **/
            case M_JPEG_SOF10:	    /** Progressive, arithmetic              **/
            /** Currently unsupported SOFn types **/
            case M_JPEG_SOF3:		/** Lossless, Huffman                    **/
            case M_JPEG_SOF5:		/** Differential sequential, Huffman     **/
            case M_JPEG_SOF6:		/** Differential progressive, Huffman    **/
            case M_JPEG_SOF7:		/** Differential lossless, Huffman       **/
            case M_JPEG_JPG:	    /** Reserved for JPEG extensions         **/
            case M_JPEG_SOF11:		/** Lossless, arithmetic                 **/
            case M_JPEG_SOF13:		/** Differential sequential, arithmetic  **/
            case M_JPEG_SOF14:		/** Differential progressive, arithmetic **/
            case M_JPEG_SOF15:		/** Differential lossless, arithmetic    **/
                  return HI_ERR_JPEG_UNSUPPORT;
            /** hard decode not need this message **/
            case M_JPEG_APP0:
            case M_JPEG_APP1:
            case M_JPEG_APP2:
            case M_JPEG_APP3:
            case M_JPEG_APP4:
            case M_JPEG_APP5:
            case M_JPEG_APP6:
            case M_JPEG_APP7:
            case M_JPEG_APP8:
            case M_JPEG_APP9:
            case M_JPEG_APP10:
            case M_JPEG_APP11:
            case M_JPEG_APP12:
            case M_JPEG_APP13:
            case M_JPEG_APP14:
            case M_JPEG_APP15:
                  if(! parse_appn_marker(pstInMsg->u64DecHandle))
                  {
            	     return HI_ERR_JPEG_SOFN_EXIT;
                  }
                  break;
            
            case M_JPEG_SOS:
                  if(! parse_sos_marker(pstInMsg->u64DecHandle))
                  {
            	     return HI_ERR_JPEG_SOS_EXIT;
                  }
                  /** ok,parse the dec stream,should not continue parse file **/
                  return HI_SUCCESS;
                  
            case M_JPEG_DHT:
                  if(! parse_dht_marker(pstInMsg->u64DecHandle))
                  {
            	     return HI_ERR_JPEG_PARSE_DHT;
                  }
                  break;
              
            case M_JPEG_DQT:
                  if(! parse_dqt_marker(pstInMsg->u64DecHandle))
                  {
            	     return HI_ERR_JPEG_PARSE_DQT;
                  }
                  break;
            case M_JPEG_DRI:
                  if(! parse_dri_marker(pstInMsg->u64DecHandle))
                  {
            	     return HI_ERR_JPEG_DRI;
                  }
                  break;
            case M_JPEG_RST0:  /* these are all parameterless */
            case M_JPEG_RST1:
            case M_JPEG_RST2:
            case M_JPEG_RST3:
            case M_JPEG_RST4:
            case M_JPEG_RST5:
            case M_JPEG_RST6:
            case M_JPEG_RST7:
                  break;
            case M_JPEG_EOI:
            	  /** 对于纯硬件来说，这里说明没有解析到其它数据 **/
                  return HI_ERR_JPEG_DATA_SUPPORT;
            /** hard decode not need this message **/
            case M_JPEG_DAC:
            case M_JPEG_COM:
            case M_JPEG_TEM:
            case M_JPEG_DNL: /* Ignore DNL ... perhaps the wrong thing */
                break;
            default:
            	return HI_ERR_JPEG_DATA_SUPPORT;
         }
    }
    
    return HI_ERR_JPEG_DATA_SUPPORT;
    
}
/***************************************************************************************
* func			: jpeg_get_sofn
* description	: get sofn message
				  CNcomment: 获取帧信息 CNend\n
* param[in] 	: pstOutMsg
* retval		: HI_SUCCESS 成功
* retval		: HI_FAILURE 失败
* others:		: NA
***************************************************************************************/
HI_S32 jpeg_get_sofn(HI_DRV_JPEG_OUTMSG_S *pstOutMsg)
{

    HI_S32 s32OutTmpYHeight     = 0;  /** 分配Y内存大小使用  **/
    HI_S32 s32OutTmpUVHeight    = 0;  /** 分配UV内存大小使用 **/
    HI_S32 s32OutYWidth         = 0;
    HI_S32 s32OutYHeight        = 0;
    HI_S32 s32OutYStride        = 0;
    HI_S32 s32OutUVWidth        = 0;
    HI_S32 s32OutUVHeight       = 0;
    HI_S32 s32OutUVStride       = 0;
    IMAG_INFO_S *pstImgInfo = (IMAG_INFO_S*)(unsigned long)(pstOutMsg->u64DecHandle);
    
    if(1 != pstOutMsg->s32Scale && 2 != pstOutMsg->s32Scale && 4 != pstOutMsg->s32Scale && 8 != pstOutMsg->s32Scale)
    {
        JPEG_TRACE("the dec scale is not support\n");
        return HI_FAILURE;
    }
    if(1 == pstOutMsg->s32Scale)
    {
       s32OutYWidth  = pstImgInfo->s32InWidth;
       s32OutYHeight = pstImgInfo->s32InHeight;
    }
    else
    {
       s32OutYWidth  = (HI_S32)OUT_ROUND_UP(pstImgInfo->s32InWidth,pstOutMsg->s32Scale);
       s32OutYHeight = (HI_S32)OUT_ROUND_UP(pstImgInfo->s32InHeight,pstOutMsg->s32Scale);
    }
    if(s32OutYWidth  <= 1) s32OutYWidth  = 2;
    if(s32OutYHeight <= 1) s32OutYHeight = 2;
    
	s32OutTmpYHeight = (1 == pstImgInfo->u8Fac[0][1]) ? ((s32OutYHeight + JPEG_DRV_MCU_8ALIGN - 1) & (~(JPEG_DRV_MCU_8ALIGN - 1)))  : ((s32OutYHeight + JPEG_DRV_MCU_16ALIGN - 1) & (~(JPEG_DRV_MCU_16ALIGN - 1)));

    jpeg_para_getstride((HI_U32)s32OutYWidth,(HI_U32*)(&s32OutYStride),64);

    switch(pstImgInfo->eImgFmt)
    {
        case IMG_FMT_YUV400:
            s32OutUVStride      = 0;
            s32OutUVWidth       = 0;
	        s32OutUVHeight      = 0;
	        s32OutTmpUVHeight   = 0;
            pstOutMsg->enOutFmt = JPG_FMT_YUV400;
            break;
        case IMG_FMT_YUV420:
            s32OutUVStride      = s32OutYStride;
            s32OutYWidth        = (s32OutYWidth  >> 1) << 1;
	        s32OutYHeight       = (s32OutYHeight >> 1) << 1;
	        s32OutUVWidth       = s32OutYWidth  >> 1;
	        s32OutUVHeight      = s32OutYHeight >> 1;
	        s32OutTmpUVHeight   = s32OutTmpYHeight >> 1;
            pstOutMsg->enOutFmt = JPG_FMT_YUV420;
            break;
        case IMG_FMT_YUV422_21:
            s32OutUVStride  = s32OutYStride;
            s32OutYWidth    = (s32OutYWidth  >> 1) << 1;
	        s32OutUVWidth   = s32OutYWidth >> 1;
            if(HI_TRUE == pstOutMsg->bOutYuvSp420)
            {
                s32OutTmpUVHeight = s32OutTmpYHeight >> 1;
            }
            else
            {
	            s32OutTmpUVHeight   = s32OutTmpYHeight;
            }
            s32OutUVHeight      = s32OutYHeight;
            pstOutMsg->enOutFmt = JPG_FMT_YUV422_21;
            break;
        case IMG_FMT_YUV422_12:
            if(HI_TRUE == pstOutMsg->bOutYuvSp420)
            {
            	s32OutUVStride = s32OutYStride;
            }
            else
            {
                s32OutUVStride = s32OutYStride << 1;
            }
            s32OutYHeight       = (s32OutYHeight >> 1) << 1;
	        s32OutUVWidth       = s32OutYWidth;
	        s32OutUVHeight      = s32OutYHeight >> 1;
	        s32OutTmpUVHeight   = s32OutTmpYHeight >> 1;
            pstOutMsg->enOutFmt = JPG_FMT_YUV422_12;
            break;
        case IMG_FMT_YUV444:
            if(HI_TRUE == pstOutMsg->bOutYuvSp420)
            {
            	s32OutUVStride    = s32OutYStride;
                s32OutTmpUVHeight = s32OutTmpYHeight >> 1;
            }
            else
            {
                s32OutUVStride    = s32OutYStride << 1;
                s32OutTmpUVHeight = s32OutTmpYHeight;
                
            }
            s32OutUVWidth       = s32OutYWidth;
            s32OutUVHeight      = s32OutYHeight;
            pstOutMsg->enOutFmt = JPG_FMT_YUV444;
            break;
        default:
            return HI_FAILURE;
    }

	if(HI_TRUE == pstOutMsg->bOutYuvSp420 && JPG_FMT_YUV400 != pstOutMsg->enOutFmt)
	{
		s32OutYWidth	= (0 == s32OutYWidth  % 2)? s32OutYWidth  : (s32OutYWidth  - 1);
		s32OutYHeight	= (0 == s32OutYHeight % 2)? s32OutYHeight : (s32OutYHeight - 1);
		s32OutUVWidth	= s32OutYWidth  >> 1;
		s32OutUVHeight  = s32OutYHeight >> 1;
	}
   
    pstOutMsg->u32OutWidth[0]  = s32OutYWidth;
    pstOutMsg->u32OutHeight[0] = s32OutYHeight;
    pstOutMsg->u32OutStride[0] = s32OutYStride;
	pstOutMsg->u32OutSize[0]   = s32OutYStride * s32OutTmpYHeight;

    pstOutMsg->u32OutWidth[1]  = s32OutUVWidth;
    pstOutMsg->u32OutHeight[1] = s32OutUVHeight;
    pstOutMsg->u32OutStride[1] = s32OutUVStride;
    pstOutMsg->u32OutSize[1]   = s32OutUVStride * s32OutTmpUVHeight;

    if(HI_TRUE == pstOutMsg->bOutYuvSp420)
    {
        pstOutMsg->enOutFmt = JPG_FMT_YUV420;
    }
    
    return HI_SUCCESS;
    
}

/***************************************************************************************
* func			: jpeg_get_imginfo
* description	: get jpeg input message
				  CNcomment: 获取图片输入信息 CNend\n
* param[in] 	: pstInMsg
* others:		: NA
***************************************************************************************/
HI_VOID jpeg_get_imginfo(HI_DRV_JPEG_INMSG_S *pstInMsg)
{

    IMAG_INFO_S *pstImgInfo = NULL;

    if(NULL == pstInMsg){
        return;
    }
    pstImgInfo = (IMAG_INFO_S*)(unsigned long)(pstInMsg->u64DecHandle);
    if(NULL == pstImgInfo){
        return;
    }
    pstInMsg->s32InWidth  = pstImgInfo->s32InWidth;
    pstInMsg->s32InHeight = pstImgInfo->s32InHeight;
    switch(pstImgInfo->eImgFmt)
    {
        case IMG_FMT_YUV400:
             pstInMsg->enInFmt = JPG_FMT_YUV400;
             break;
        case IMG_FMT_YUV420:
             pstInMsg->enInFmt = JPG_FMT_YUV420;
             break;
        case IMG_FMT_YUV444:
             pstInMsg->enInFmt = JPG_FMT_YUV444;
             break;
        case IMG_FMT_YUV422_21:
             pstInMsg->enInFmt = JPG_FMT_YUV422_21;
             break;
        case IMG_FMT_YUV422_12:
             pstInMsg->enInFmt = JPG_FMT_YUV422_12;
             break;
        default:
             break;
    }
}
#endif
