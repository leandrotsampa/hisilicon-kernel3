#include "hi_type.h"
#include "vdp_define.h"
#include "vdp_drv_pq_hdr.h"
#include "vdp_drv_hdr.h"
#include "vdp_hal_hdr.h"
#include "vdp_hal_vid.h"
#include "vdp_hal_gfx.h"
#include "vdp_hal_mmu.h"
#include "vdp_hal_chn.h"
#include "drv_pq_ext.h"
#include "vdp_drv_func.h"

#include "vdp_drv_comm.h"
#include "vdp_drv_pq_zme.h"
#include "vdp_hal_comm.h"
#if VDP_CBB_FPGA
#include "hi_drv_mmz.h"
#endif
#include "vdp_drv_hihdr.h"
#include "vdp_drv_bt2020.h"
extern HI_U32 gdm_gmm_lut[64]; 
extern HI_U32 gdm_degmm_lut[64]; 
extern  uint32_t HisiHdr10_1024Lut[1024];

extern uint32_t  HisiHdr10l2GLutX[128];
extern uint32_t  HisiHdr10l2GLutA[128];
extern uint32_t  HisiHdr10l2GLutB[128];

extern uint32_t  HisiHdr10l2pqLutX[128];
extern uint32_t  HisiHdr10l2pqLutA[128];
extern uint32_t  HisiHdr10l2pqLutB[128];

extern HI_U32 gdm_gmm_hihdrlut[64];

//extern HI_U32 gdm_gmm_hislflut[64];

extern VDP_COEF_ADDR_S gstVdpCoefBufAddr;




HI_VOID VDP_DRV_SetHisiGdmHdr10InHdr10Out(HI_VOID)
{
	#if 1
    HI_U32 g_degamma_en = 1;
    HI_U32 g_gamma_en   = 1;
    HI_U32 gcvm_en      = 1;
    HI_U32 cvm_sel      = 0;
    HI_U32 gdm_en       = 1;

    HI_U32 g_rgb2lms_en             ; 

	int16_t csc_coef[3][3]={{0},{0},{0}};
	HI_S32  csc_offset[3]={0};

//**************-----degamm and gamma---------------
    HI_U32 g_degmm_step[4]          ; 
    HI_U32 g_degmm_pos[4]           ; 
    HI_U32 g_degmm_num[4]           ; 

    HI_U32 g_gmm_step[4]            ; 
    HI_U32 g_gmm_pos[4]             ; 
    HI_U32 g_gmm_num[4]             ; 

    HI_U32 g_rgb2yuv_en             ;

	HI_U32 u32Pre   ; 
	HI_U32 u32DcPre	;

	HI_U32  u32Scale;
	HI_S32 m33Yuv2Rgb[3][3]={{0},{0},{0}};
	HI_S32 m33Yuv2RgbDc[3]={0};

                                    
    g_rgb2lms_en = 1;
    g_rgb2yuv_en = 1;


	//****************-----degamm-----**********************
	g_degmm_pos[0]           = 64;
	g_degmm_pos[1]           = 64*2;
	g_degmm_pos[2]           = 64*3;
	g_degmm_pos[3]           = 252;//255;
	g_degmm_step[0]          = 2;
	g_degmm_step[1]          = 2;
	g_degmm_step[2]          = 2;
	g_degmm_step[3]          = 2;
	g_degmm_num[0]           = 16;
	g_degmm_num[1]           = 16;
	g_degmm_num[2]           = 16;
	g_degmm_num[3]           = 15;
	//****************-----degamm end-----**********************

#if 1//苏勇最新提供20160105
	//****************-----gamm-----**********************
	g_gmm_pos[0]		   = 557056 ;
	g_gmm_pos[1]		   = 2916352 ;
	g_gmm_pos[2]		   = 14450688  ;
	g_gmm_pos[3]		   = 29130752;
	g_gmm_step[0]		   = 15;
	g_gmm_step[1]		   = 17;
	g_gmm_step[2]		   = 19;
	g_gmm_step[3]		   = 21;
	g_gmm_num[0]		   = 17;
	g_gmm_num[1]		   = 18;
	g_gmm_num[2]		   = 22;
	g_gmm_num[3]		   = 7;
	//****************-----degamm end-----**********************
#endif
                                    
    VDP_HDR_SetGDmEn(gdm_en);
    VDP_HDR_SetGDmDegammaEn           ( g_degamma_en);
    VDP_HDR_SetGDmRgb2lmsEn           ( g_rgb2lms_en             ) ;


	csc_coef[0][0]	   = 10279;
	csc_coef[0][1]	   = 5396;
	csc_coef[0][2]	   = 710;
	csc_coef[1][0]	   = 1134;
	csc_coef[1][1]	   = 15064;
	csc_coef[1][2]	   = 187;
	csc_coef[2][0]	   = 268;
	csc_coef[2][1]	   = 1442;
	csc_coef[2][2]	   = 14673;

	csc_offset[0]=0;	
	csc_offset[1]=0;	
	csc_offset[2]=0;

	
    VDP_HDR_SetGDmImapRgb2lms         ( csc_coef     ) ;
    VDP_HDR_SetGDmImapRgb2lmsscale2p  ( 14    ) ;
	VDP_HDR_SetGDmImapRgb2lmsmin          ( 0 );
	VDP_HDR_SetGDmImapRgb2lmsmax          ( 26214400       );
    VDP_HDR_SetGDmImapRgb2lmsOutDc    ( csc_offset ) ;



#if  1//Full rgb -> Full yuv out

	VDP_HDR_SetCvmEn 			 (true);
	VDP_HDR_SetGCvmRgb2yuvEn 	 (true);


	u32Pre = 1 << 10;
	u32Scale	  = 1 << (15 - 10 );
	u32DcPre	  = 4 * 64;

	m33Yuv2Rgb[0][0] = (HI_S32)( 0.2249* u32Pre*u32Scale/2);
	m33Yuv2Rgb[0][1] = (HI_S32)( 0.5806* u32Pre*u32Scale/2);
	m33Yuv2Rgb[0][2] = (HI_S32)( 0.0508* u32Pre*u32Scale/2);
	m33Yuv2Rgb[1][0] = (HI_S32)(-0.1223* u32Pre*u32Scale/2);
	m33Yuv2Rgb[1][1] = (HI_S32)(-0.3156* u32Pre*u32Scale/2);
	m33Yuv2Rgb[1][2] = (HI_S32)( 0.4379* u32Pre*u32Scale/2);
	m33Yuv2Rgb[2][0] = (HI_S32)( 0.4379* u32Pre*u32Scale/2);
	m33Yuv2Rgb[2][1] = (HI_S32)( -0.4027* u32Pre*u32Scale/2);
	m33Yuv2Rgb[2][2] = (HI_S32)(-0.0352* u32Pre*u32Scale/2);
	m33Yuv2RgbDc[0]= (HI_S32)(16   * u32DcPre/2);	
	m33Yuv2RgbDc[1]= (HI_S32)(128 * u32DcPre/2);	
	m33Yuv2RgbDc[2]= (HI_S32)(128 * u32DcPre/2);	



	VDP_HDR_SetGCvmOmapRgb2yuvscale2p(15 | (1<<5) );
	VDP_HDR_SetGCvmOmapRgb2yuv	   (m33Yuv2Rgb	);
	VDP_HDR_SetGCvmOmapRgb2yuvOutDc  (m33Yuv2RgbDc );
	VDP_HDR_SetGCvmOmapRgb2yuvmin    (0);
	VDP_HDR_SetGCvmOmapRgb2yuvmax    (0x7FFF);
#endif

    VDP_HDR_SetGDmDegmmPos            ( g_degmm_pos);
    VDP_HDR_SetGDmDegmmStep           ( g_degmm_step);
    VDP_HDR_SetGDmDegmmNum            ( g_degmm_num);
    VDP_HDR_SetGDmGammaEn             ( g_gamma_en);
    VDP_HDR_SetGDmGammaPos            ( g_gmm_pos);
    VDP_HDR_SetGDmGammaStep           ( g_gmm_step);
    VDP_HDR_SetGDmGmmNum              ( g_gmm_num);
//  gcvm ------
    VDP_HDR_SetAuthEn                 ( gcvm_en);
    VDP_HDR_SetCvmSel                 ( cvm_sel);
#endif

}

HI_VOID VDP_DRV_SetHisiGdm(HI_VOID)
{
	

    HI_U32 g_degamma_en = 1;//stCfg -> degamm_en; 
    HI_U32 g_gamma_en   = 1;//stCfg -> gamm_en;
    HI_U32 gcvm_en      = 1;//stCfg -> gcvm_en;
    //HI_U32 cvm_sel      = 1;//stCfg -> cvm_sel;
    //HI_U32 cvm_en       = 1;//stCfg -> cvm_en;
    HI_U32 gdm_en       = 1;//stCfg -> gdm_en;

    HI_U32 g_rgb2lms_en             ; 

	int16_t csc_coef[3][3]={{0},{0},{0}};
	HI_S32  csc_offset[3]={0};

	
    //HI_U32 gamma_rd_en              ; 
    //HI_U32 degamma_rd_en            ;  
//**************-----degamm and gamma---------------
    HI_U32 g_degmm_step[4]          ; 
    HI_U32 g_degmm_pos[4]           ; 
    HI_U32 g_degmm_num[4]           ; 

    HI_U32 g_gmm_step[4]            ; 
    HI_U32 g_gmm_pos[4]             ; 
    HI_U32 g_gmm_num[4]             ; 

    HI_U32 g_rgb2yuv_en             ;


                                    
    g_rgb2lms_en = 1;//stCfg -> g_rgb2lms_en;
    g_rgb2yuv_en = 1;//stCfg -> g_rgb2yuv_en;


    {      
//****************-----degamm-----**********************
        g_degmm_pos[0]           = 64;
        g_degmm_pos[1]           = 64*2;
        g_degmm_pos[2]           = 64*3;
        g_degmm_pos[3]           = 252;//255;
        g_degmm_step[0]          = 2;
        g_degmm_step[1]          = 2;
        g_degmm_step[2]          = 2;
        g_degmm_step[3]          = 2;
        g_degmm_num[0]           = 16;
        g_degmm_num[1]           = 16;
        g_degmm_num[2]           = 16;
        g_degmm_num[3]           = 15;
//****************-----degamm end-----**********************

#if 1//苏勇最新提供20160105
//****************-----gamm-----**********************
		g_gmm_pos[0]		   = 557056 ;//1792  ;//256;//mod by suyong //832;//16384;
		g_gmm_pos[1]		   = 2916352 ;//345856;//15616;//mod by suyong //21312;//16384*2;
		g_gmm_pos[2]		   = 14450688  ;//4540160;//1326336;//mod by suyong //1004352;//16384*3;
		g_gmm_pos[3]		   = 29130752;//27493888;//mod by suyong //26170716;//16384*3;
		g_gmm_step[0]		   = 15;//4;//mod by suyong //5;//10;
		g_gmm_step[1]		   = 17;//16;//10;//mod by suyong //11;//10;
		g_gmm_step[2]		   = 19;//18;//16;//mod by suyong //16;//10;
		g_gmm_step[3]		   = 21;//20;//mod by suyong //21;//10;
		g_gmm_num[0]		   = 17;//16;//mod by suyong //26;//16;
		g_gmm_num[1]		   = 18;//15;//mod by suyong //10;//16;
		g_gmm_num[2]		   = 22;//20;//mod by suyong //15;//16;
		g_gmm_num[3]		   = 7;//13;//mod by suyong //12;//16;
//****************-----degamm end-----**********************
#endif

#if 0
	g_gmm_pos[0]		   = 256;//mod by suyong //832;//16384;
	g_gmm_pos[1]		   = 15616;//mod by suyong //21312;//16384*2;
	g_gmm_pos[2]		   = 1326336;//mod by suyong //1004352;//16384*3;
	g_gmm_pos[3]		   = 26170716;//mod by suyong //26170716;//16384*3;
	g_gmm_step[0]		   = 4;//mod by suyong //5;//10;
	g_gmm_step[1]		   = 10;//mod by suyong //11;//10;
	g_gmm_step[2]		   = 16;//mod by suyong //16;//10;
	g_gmm_step[3]		   = 21;//mod by suyong //21;//10;
	g_gmm_num[0]		   = 16;//mod by suyong //26;//16;
	g_gmm_num[1]		   = 15;//mod by suyong //10;//16;
	g_gmm_num[2]		   = 20;//mod by suyong //15;//16;
	g_gmm_num[3]		   = 13;//mod by suyong //12;//16;

#endif

    }
    
        
                                    
    VDP_HDR_SetGDmEn(gdm_en);
    VDP_HDR_SetGDmDegammaEn           ( g_degamma_en);
    VDP_HDR_SetGDmRgb2lmsEn           ( g_rgb2lms_en             ) ;

#if  0
	csc_coef[0][0]	   = 9989; 
	csc_coef[0][1]	   = 20686; 
	csc_coef[0][2]	   = 2091; 
	csc_coef[1][0]	   = 5103; 
	csc_coef[1][1]	   = 24333; 
	csc_coef[1][2]	   = 3329; 
	csc_coef[2][0]	   = 865; 
	csc_coef[2][1]	   = 4357; 
	csc_coef[2][2]	   = 27543; 
#endif

#if  1


		csc_coef[0][0]	   = 5145*2;
		csc_coef[0][1]	   = 10477*2;
		csc_coef[0][2]	   = 762*2;
		csc_coef[1][0]	   = 2546*2;
		csc_coef[1][1]	   = 12416*2;
		csc_coef[1][2]	   = 1421*2;
		csc_coef[2][0]	   = 290*2;
		csc_coef[2][1]	   = 1793*2;
		csc_coef[2][2]	   = 14300*2;
#endif



	csc_offset[0]=0;	
	csc_offset[1]=0;	
	csc_offset[2]=0;

	
    VDP_HDR_SetGDmImapRgb2lms         ( csc_coef     ) ;
    VDP_HDR_SetGDmImapRgb2lmsscale2p  ( 15    ) ;
	VDP_HDR_SetGDmImapRgb2lmsmin          ( 0 );
	VDP_HDR_SetGDmImapRgb2lmsmax          ( ((1<<25)  -1)       );
    VDP_HDR_SetGDmImapRgb2lmsOutDc    ( csc_offset ) ;


	csc_coef[0][0]	   = 1638;
	csc_coef[0][1]	   = 1638;
	csc_coef[0][2]	   = 819;
	csc_coef[1][0]	   = 18248;
	csc_coef[1][1]	   = -19870;
	csc_coef[1][2]	   = 1622;
	csc_coef[2][0]	   = 3300;
	csc_coef[2][1]	   = 1463;
	csc_coef[2][2]	   = -4763;

	csc_offset[0]=0;	
	csc_offset[1]=0;	
	csc_offset[2]=0;

	
    VDP_HDR_SetGCvmLms2IptEn          ( 1             ) ;
    VDP_HDR_SetGCvmLms2Ipt            ( csc_coef     ) ;
    VDP_HDR_SetGCvmLms2IptScale2p     ( 12    ) ;
    VDP_HDR_SetGCvmLms2IptOutDc       ( csc_offset ) ;

    VDP_HDR_SetGDmDegmmPos            ( g_degmm_pos);
    VDP_HDR_SetGDmDegmmStep           ( g_degmm_step);
    VDP_HDR_SetGDmDegmmNum            ( g_degmm_num);
    VDP_HDR_SetGDmGammaEn             ( g_gamma_en);
    VDP_HDR_SetGDmGammaPos            ( g_gmm_pos);
    VDP_HDR_SetGDmGammaStep           ( g_gmm_step);
    VDP_HDR_SetGDmGmmNum              ( g_gmm_num);
//  gcvm ------
    VDP_HDR_SetAuthEn                 ( gcvm_en);
    //VDP_HDR_SetCvmSel                 ( cvm_sel);
    //VDP_HDR_SetCvmEn                  ( cvm_en);


}

HI_S32 VDP_DRV_SetHisiVdm(HI_VOID)
{
	
	int32_t v3IptOff[3];

	int16_t csc_coef[3][3]={{0},{0},{0}};
	HI_S32  csc_offset[3]={0};


	
    //composer up sample
    VDP_VID_SetComposeElUpsampleMax    (16383);
    VDP_VID_SetComposeElUpsampleMin    (0);


    //vdm_yuv2rgb 
    VDP_HDR_SetVDmYuv2rgbEn            ( 1 );
    VDP_HDR_SetVDmYuv2rgbV0En          ( 1 ); 
    VDP_HDR_SetVDmYuv2rgbV1En          ( 0 ); 



	csc_coef[0][0]=9567	;
	csc_coef[0][1]=0	;
	csc_coef[0][2]=13792	;
	csc_coef[1][0]=9567	;
	csc_coef[1][1]=-1539	;
	csc_coef[1][2]=-5344	;
	csc_coef[2][0]=9567	;
	csc_coef[2][1]=17597	;
	csc_coef[2][2]=0		;


	csc_offset[0]=122423345;	
	csc_offset[1]=-46449400;	
	csc_offset[2]=153501460;


	
    VDP_HDR_SetVDmImap0Yuv2rgb         (csc_coef);
    VDP_HDR_SetVDmImapYuv2rgbscale2p   (13);
    VDP_HDR_SetVDmImapYuv2rgbOutDc0    (csc_offset);

    VDP_HDR_SetVDmInBits               ( 1 );


    //vdm_rgb2lms
    VDP_HDR_SetVDmRgb2lmsEn            ( 1 ); 

	
	csc_coef[0][0]=7222	;
	csc_coef[0][1]=8771	;
	csc_coef[0][2]=390	;
	csc_coef[1][0]=2653	;
	csc_coef[1][1]=12429	;
	csc_coef[1][2]=1300	;
	csc_coef[2][0]=0		;
	csc_coef[2][1]=422	;
	csc_coef[2][2]=15961	;

	csc_offset[0]=0;
	csc_offset[1]=0;
	csc_offset[2]=0;

	
    VDP_HDR_SetVDmImapRgb2lms          ( csc_coef );
    VDP_HDR_SetVDmImapRgb2lmsscale2p   ( 14);
    VDP_HDR_SetVDmImapRgb2lmsmin       ( 0 );
    //VDP_HDR_SetVDmImapRgb2lmsmax       ( (HI_U32)((HI_U64)10000*(1<<18))  );
    VDP_HDR_SetVDmImapRgb2lmsmax        ( 0x9c400000  );//(10000LL*(1<<18))

    //cvm1_lms2ipt
    VDP_HDR_SetVCvmLms2iptEn           ( 1 ); 
    VDP_HDR_SetVDmImapLms2iptmin       ( 0-((1<<15)-1) );
    VDP_HDR_SetVDmImapLms2iptmax       ( ((1<<15)-1) );

	csc_coef[0][0]=1638;
	csc_coef[0][1]=1638;
	csc_coef[0][2]=819;
	csc_coef[1][0]=18248;
	csc_coef[1][1]=-19870;
	csc_coef[1][2]=1622;
	csc_coef[2][0]=3300;
	csc_coef[2][1]=1463;
	csc_coef[2][2]=-4763;

	csc_offset[0]=0;
	csc_offset[1]=0;
	csc_offset[2]=0;

	
    VDP_HDR_SetVCvmImapLms2ipt         ( csc_coef         );
    VDP_HDR_SetVCvmImapLms2iptscale2p  ( 12+1 );

    //cvm1_ipt2lms
    VDP_HDR_SetVCvmIpt2lmsEn           ( 1 ); 

	csc_coef[0][0]=32767;
	csc_coef[0][1]=3196;
	csc_coef[0][2]=6725;
	csc_coef[1][0]=32767;
	csc_coef[1][1]=-3731;
	csc_coef[1][2]=4365;
	csc_coef[2][0]=32767;
	csc_coef[2][1]=1069;
	csc_coef[2][2]=-22180;

	csc_offset[0]=0;
	csc_offset[1]=0;
	csc_offset[2]=0;


	
    VDP_HDR_SetVCvmOmapIpt2lms         ( csc_coef      );

    VDP_HDR_SetVCvmOmapIpt2lmsscale2p  ( 15);
    VDP_HDR_SetVDmOmapIpt2lmsmin       ( 0 );
    VDP_HDR_SetVDmOmapIpt2lmsmax       ( (1<<16)-1 );

    //cvm1_lms2rgb
    VDP_HDR_SetVCvmLms2rgbEn           ( 1 ); 



	csc_coef[0][0]= 22415	;		
	csc_coef[0][1]= -19014	;	
	csc_coef[0][2]= 695		;	
	csc_coef[1][0]= -4609	;		
	csc_coef[1][1]= 9393	;		
	csc_coef[1][2]= -688	;		
	csc_coef[2][0]= 122		;	
	csc_coef[2][1]= -791	;		
	csc_coef[2][2]= 4765	;	

	csc_offset[0]=0;
	csc_offset[1]=0;
	csc_offset[2]=0;

	
    VDP_HDR_SetVCvmOmapLms2rgb         ( csc_coef       );
    VDP_HDR_SetVCvmOmapLms2rgbscale2p  ( 12);
    VDP_HDR_SetVDmOmapLms2rgbmin       ( 0     );
    VDP_HDR_SetVDmOmapLms2rgbmax       ( 26214400  );

    //cvm1_rgb2yuv
    VDP_HDR_SetVCvmRgb2yuvEn           ( 1 ); 

	csc_coef[0][0]=5961;
	csc_coef[0][1]=20051;
	csc_coef[0][2]=2023;
	csc_coef[1][0]=-3287;
	csc_coef[1][1]=-11054;
	csc_coef[1][2]=14339;
	csc_coef[2][0]=14339;
	csc_coef[2][1]=-13025;
	csc_coef[2][2]=-1316;

	csc_offset[0]=256;
	csc_offset[1]=2048;
	csc_offset[2]=2048;

	
    VDP_HDR_SetVCvmOmapRgb2yuv         ( csc_coef      );

	
    VDP_HDR_SetVCvmOmapRgb2yuvscale2p  ( 15);
    VDP_HDR_SetVCvmOmapRgb2yuvOutDc    ( csc_offset     );

    //VDM_PQ2L
    
    VDP_HDR_SetVDmInEotf               ( 1 );
    VDP_HDR_SetVDmDegammaEn            ( 1 );
    VDP_HDR_SetVCvmEn                  ( 1 );
    VDP_HDR_SetVCvmDegammaEn           ( 1 );
    VDP_HDR_SetVCvmMGammaEn            ( 1 );
    VDP_HDR_SetVDmGammaEn              ( 1 );
    VDP_HDR_SetVDmNormEn               ( 1 );
    VDP_HDR_SetVDmImapRangeMin         ( 0 );
    VDP_HDR_SetVDmImapRange            ( 16383);
    VDP_HDR_SetVDmImapRangeInv         ( 65540 );
    VDP_HDR_SetVCvmOmapRangeMin        ( 0     );
    VDP_HDR_SetVCvmOmapRangeOver       ( 0x0000fff0 );

    VDP_HDR_SetCvmOutBits              ( 2 );//12bit
    VDP_HDR_SetVCvmDenormEn            ( 1 );

	v3IptOff[0]=64;
	v3IptOff[1]=512;
	v3IptOff[2]=512;
	
    VDP_HDR_SetVDmImapIptoff           ( v3IptOff               );
    VDP_HDR_SetVDmImapIptScale         ( 4902930                );

    VDP_HDR_SetVDmInColor              ( 1 );//yuv
    VDP_HDR_SetCvmOutColor             ( 1 );//yuv

	v3IptOff[0]=256;
	v3IptOff[1]=2048;
	v3IptOff[2]=2048;

    VDP_HDR_SetVCvmOmapIptoff          ( v3IptOff );
    VDP_HDR_SetVCvmOmapIptScale        ( 3504);

	//downsample
    VDP_HDR_SetDmHdrDsMax              ( 4095 );
    VDP_HDR_SetDmHdrDsMin              ( 0 );


	
	#if 0
	HI_U32 u32InBdp;
	HI_U32 u32OutBdp;
	HI_U32 u32InClr;
	HI_U32 u32OutClr;
	int16_t m33Ipt2Lms[3][3];
	int16_t m33Lms2Rgb[3][3];
	int16_t m33Rgb2Yuv[3][3];

	int32_t m3Rgb2YuvDc[3];
    //composer up sample
    //VDP_VID_SetComposeElUpsampleMax    (pstHisiHdrTmCfg->ksUds.maxUs);
    //VDP_VID_SetComposeElUpsampleMin    (pstHisiHdrTmCfg->ksUds.minUs);


    VDP_BT2020_CFG_T bt2020_cfg;
    VDP_BT2020_CFG_T* pCfg = &bt2020_cfg;
    HI_S16 m33Lms2Ipt[3][3];
	HI_S32 s32CscDc[3]={0};

    u32InBdp = 0;//TODO  (pstHisiHdrTmCfg->ksIMap.eotfParam.bdp == 12) ? 0:1;
    VDP_HDR_SetVDmInBits               ( u32InBdp );
    //vdm_yuv2rgb 
    VDP_HDR_SetVDmYuv2rgbEn            ( 1 );
    VDP_HDR_SetVDmYuv2rgbV0En          ( 1 ); 
    VDP_HDR_SetVDmYuv2rgbV1En          ( 0 ); 
    //VDP_HDR_SetVDmImap0Yuv2rgb         (pstHisiHdrTmCfg->ksIMap.m33Yuv2Rgb);
    //VDP_HDR_SetVDmImapYuv2rgbscale2p   (pstHisiHdrTmCfg->ksIMap.m33Yuv2RgbScale2P);
    //VDP_HDR_SetVDmImapYuv2rgbOutDc0    (pstHisiHdrTmCfg->ksIMap.v3Yuv2RgbOffInRgb);


	//yuv2rgb
	VDP_HDR_SetVDmYuv2rgbEn 			( 1 			) ;
	VDP_HDR_SetVDmImapYuv2rgbscale2p ( pCfg->v0_csc_cfg.m33Yuv2RgbScale2P );
	VDP_HDR_SetVDmImap0Yuv2rgb		 ( pCfg->v0_csc_cfg.m33Yuv2Rgb		  );
	VDP_HDR_SetVDmImapYuv2rgbOutDc0  ( pCfg->v0_csc_cfg.v3Yuv2RgbOffInRgb );
	VDP_HDR_SetVDmImapRange 		 ( 65535 );//是否是王正说的i32V_IM_Yuv2RgbClipMax


	//VDM_RGB2LMS
	VDP_HDR_SetVDmRgb2lmsEn 		  ( 1			  )  ;
	VDP_HDR_SetVDmImapRangeMin		 ( pCfg->gamma_cfg.rangeMin 		 );
	VDP_HDR_SetVDmImapRange 		 ( pCfg->gamma_cfg.range			 );
	VDP_HDR_SetVDmImapRangeInv		 ( pCfg->gamma_cfg.rangeInv 		 );

	VDP_HDR_SetVDmImapRgb2lms		 ( pCfg->gamma_cfg.m33Rgb2Lms		 );
	VDP_HDR_SetVDmImapRgb2lmsscale2p ( pCfg->gamma_cfg.m33Rgb2LmsScale2P );
	VDP_HDR_SetVDmImapRgb2lmsmin	 ( pCfg->gamma_cfg.csc_min			 );
	VDP_HDR_SetVDmImapRgb2lmsmax	 ( pCfg->gamma_cfg.csc_max			 );




	pCfg->v0_csc_cfg.m33Yuv2RgbScale2P	  = 13 ;  //wangzheng provide
	pCfg->gamma_cfg.m33Rgb2LmsScale2P	  = 14;    //wangzheng provide



	pCfg->v0_csc_cfg.m33Yuv2Rgb[0][0]	  = 9567;
	pCfg->v0_csc_cfg.m33Yuv2Rgb[0][1]	  = 0;
	pCfg->v0_csc_cfg.m33Yuv2Rgb[0][2]	  = 13792;
	pCfg->v0_csc_cfg.m33Yuv2Rgb[1][0]	  = 9567;
	pCfg->v0_csc_cfg.m33Yuv2Rgb[1][1]	  = -1539;
	pCfg->v0_csc_cfg.m33Yuv2Rgb[1][2]	  = -5344;
	pCfg->v0_csc_cfg.m33Yuv2Rgb[2][0]	  = 9567;
	pCfg->v0_csc_cfg.m33Yuv2Rgb[2][1]	  = 17597;
	pCfg->v0_csc_cfg.m33Yuv2Rgb[2][2]	  = 0;
	pCfg->v0_csc_cfg.v3Yuv2RgbOffInRgb[0] = 122423345;//TODo
	pCfg->v0_csc_cfg.v3Yuv2RgbOffInRgb[1] = -46449400;//TODo
	pCfg->v0_csc_cfg.v3Yuv2RgbOffInRgb[2] = 153501460;//TODo

	//pCfg->gamma_cfg.m33Rgb2Lms[0][0]	  = 7222;;
	//pCfg->gamma_cfg.m33Rgb2Lms[0][1]	  = 8771;;
	//pCfg->gamma_cfg.m33Rgb2Lms[0][2]	  = 390;;
	//pCfg->gamma_cfg.m33Rgb2Lms[1][0]	  = 2653;
	//pCfg->gamma_cfg.m33Rgb2Lms[1][1]	  = 12429;;
	//pCfg->gamma_cfg.m33Rgb2Lms[1][2]	  = 1300;
	//pCfg->gamma_cfg.m33Rgb2Lms[2][0]	  = 0;
	//pCfg->gamma_cfg.m33Rgb2Lms[2][1]	  = 422;
	//pCfg->gamma_cfg.m33Rgb2Lms[2][2]	  = 15961;



	m33Lms2Ipt[0][0] = 1638;//to do
	m33Lms2Ipt[0][1] = 1638;
	m33Lms2Ipt[0][2] = 819;
	m33Lms2Ipt[1][0] = 18248;
	m33Lms2Ipt[1][1] = -19870;
	m33Lms2Ipt[1][2] = 1622;
	m33Lms2Ipt[2][0] = 3300;
	m33Lms2Ipt[2][1] = 1463;
	m33Lms2Ipt[2][2] = -4763;

	s32CscDc[0]=2048*2; // 67108864;//	  //67108864;
	s32CscDc[1]=16384*2;//536870912;////536870912;
	s32CscDc[2]=16384*2;//536870912;////536870912;

	
#if 1
	//LMS2TPT:实际上是将rgb转化为yuv yu
#if 1
	m33Lms2Ipt[0][0] = 1638;//to do
	m33Lms2Ipt[0][1] = 1638;
	m33Lms2Ipt[0][2] = 819;
	m33Lms2Ipt[1][0] = 18248;
	m33Lms2Ipt[1][1] = -19870;
	m33Lms2Ipt[1][2] = 1622;
	m33Lms2Ipt[2][0] = 3300;
	m33Lms2Ipt[2][1] = 1463;
	m33Lms2Ipt[2][2] = -4763;

	s32CscDc[0]=0; // 67108864;//	  //67108864;
	s32CscDc[1]=0;//536870912;////536870912;
	s32CscDc[2]=0;//536870912;////536870912;
#endif
	VDP_HDR_SetVCvmLms2iptEn(HI_TRUE);
	VDP_HDR_SetVCvmImapLms2ipt ( m33Lms2Ipt);
	//VDP_HDR_SetVCvmImapLms2iptscale2p ( 14 );//普通通路
	VDP_HDR_SetVCvmImapLms2iptscale2p ( 12 );
	VDP_HDR_SetVCvmImapLms2iptOutDc(s32CscDc);
	VDP_HDR_SetGCvmLms2IptMin (0);;
	VDP_HDR_SetGCvmLms2IptMax (32767);
#endif

    //cvm1_lms2ipt
    //VDP_HDR_SetVCvmLms2iptEn           ( 1 ); 
    //VDP_HDR_SetVDmImapLms2iptmin       ( 0-((1<<15)-1) );
    //VDP_HDR_SetVDmImapLms2iptmax       ( ((1<<15)-1) );
    //VDP_HDR_SetVCvmImapLms2ipt         ( pstHisiHdrTmCfg->ksIMap.m33Lms2Ipt           );
    //VDP_HDR_SetVCvmImapLms2iptscale2p  ( pstHisiHdrTmCfg->ksIMap.m33Lms2IptScale2P +1 );

    //cvm1_ipt2lms
    
	m33Ipt2Lms[0][0]= 32767;
	m33Ipt2Lms[0][1]= 3196;
	m33Ipt2Lms[0][2]= 6725;
	m33Ipt2Lms[1][0]= 32767;
	m33Ipt2Lms[1][1]= -3731;
	m33Ipt2Lms[1][2]= 4365;
	m33Ipt2Lms[2][0]= 32767;
	m33Ipt2Lms[2][1]= 1069;
	m33Ipt2Lms[2][2]= -22180;

	
    VDP_HDR_SetVCvmIpt2lmsEn           ( 1 ); 
    VDP_HDR_SetVCvmOmapIpt2lms         ( m33Ipt2Lms       );
    VDP_HDR_SetVCvmOmapIpt2lmsscale2p  ( 15);
    VDP_HDR_SetVDmOmapIpt2lmsmin       ( 0 );
	VDP_HDR_SetVDmOmapIpt2lmsmax		( (1<<16)-1 );

    //cvm1_lms2rgb


	m33Lms2Rgb[0][0]= 22415;
	m33Lms2Rgb[0][1]= -19014;
	m33Lms2Rgb[0][2]= 695;
	m33Lms2Rgb[1][0]= -4609;
	m33Lms2Rgb[1][1]= 9393;
	m33Lms2Rgb[1][2]= -688;
	m33Lms2Rgb[2][0]= 122;
	m33Lms2Rgb[2][1]= -791;
	m33Lms2Rgb[2][2]= 4765;

	
    VDP_HDR_SetVCvmLms2rgbEn           ( 1 ); 
    VDP_HDR_SetVCvmOmapLms2rgb         ( m33Lms2Rgb);
    VDP_HDR_SetVCvmOmapLms2rgbscale2p  ( 12 );
    VDP_HDR_SetVDmOmapLms2rgbmin       ( 0 );
	VDP_HDR_SetVDmOmapLms2rgbmax		( 0xffffffff );

    //cvm1_rgb2yuv
	m33Rgb2Yuv[0][0]= 5961;
	m33Rgb2Yuv[0][1]= 20051;
	m33Rgb2Yuv[0][2]= 2023;
	m33Rgb2Yuv[1][0]= -3287;
	m33Rgb2Yuv[1][1]= -11054;
	m33Rgb2Yuv[1][2]= 14339;
	m33Rgb2Yuv[2][0]= 14339;
	m33Rgb2Yuv[2][1]= -13025;
	m33Rgb2Yuv[2][2]= -1316;

	m3Rgb2YuvDc[0] = 256;
	m3Rgb2YuvDc[1] = 2048;
	m3Rgb2YuvDc[2] = 2048;


	
    VDP_HDR_SetVCvmRgb2yuvEn           ( 1 ); 
    VDP_HDR_SetVCvmOmapRgb2yuv         ( m33Rgb2Yuv);

    VDP_HDR_SetVCvmOmapRgb2yuvscale2p  ( 15);
    VDP_HDR_SetVCvmOmapRgb2yuvOutDc    ( m3Rgb2YuvDc  );

    //VDM_PQ2L
    VDP_HDR_SetVDmInEotf               ( 0  ) ;
    VDP_HDR_SetVDmDegammaEn            ( 1 );
    VDP_HDR_SetVCvmEn                  ( 1 );
    VDP_HDR_SetVCvmDegammaEn           ( 1 );
    VDP_HDR_SetVCvmMGammaEn            ( 1 );
    VDP_HDR_SetVDmGammaEn              ( 1 );
    VDP_HDR_SetVDmNormEn               ( 0 );
    VDP_HDR_SetVDmImapRangeMin         ( 0    );
    VDP_HDR_SetVDmImapRange            ( 16383  );
    VDP_HDR_SetVDmImapRangeInv         ( 65540);
    VDP_HDR_SetVCvmOmapRangeMin        ( 0);
    VDP_HDR_SetVCvmOmapRangeOver       (65535 );

    u32OutBdp = 2;//(pstHisiHdrTmCfg->ksOMap.oetfParam.bdp == 12) ? 2:((pstHisiHdrTmCfg->ksOMap.oetfParam.bdp == 10) ? 1 : 0 );
    VDP_HDR_SetCvmOutBits              ( u32OutBdp );
    VDP_HDR_SetVCvmDenormEn            ( 0 );
    //VDP_HDR_SetVDmImapIptoff           (              );//TODO
    //VDP_HDR_SetVDmImapIptScale         (                );//TODO

    //u32InClr = (pstHisiHdrTmCfg->ksIMap.clr == 3) ? 0 : 1;
    VDP_HDR_SetVDmInColor              ( 1 );//TODO 1:yuv

   // u32OutClr = (pstHisiHdrTmCfg->ksOMap.clr == 3) ? 0 : 1;
    VDP_HDR_SetCvmOutColor             ( 1 );//TODO 1:yuv

    //VDP_HDR_SetVCvmOmapIptoff          ( pstHisiHdrTmCfg->ksOMap.v3IptOff );//TODO
    //VDP_HDR_SetVCvmOmapIptScale        ( pstHisiHdrTmCfg->ksOMap.iptScale );//TODO

	//downsample
    //VDP_HDR_SetDmHdrDsMax              ( pstHisiHdrTmCfg->ksUds.maxDs );//TODO
    //VDP_HDR_SetDmHdrDsMin              ( pstHisiHdrTmCfg->ksUds.minDs );//TODO


	VDP_HDR_SetVDmEn				  (1  ) ;
	VDP_HDR_SetVDmInBits(1); //all see as 14bits
	//VDP_HDR_SetVCvmDenormEn(1);
	VDP_HDR_SetVDmInEotf(0);
	VDP_HDR_SetVDmYuv2rgbV0En		  (1)  ;
	VDP_HDR_SetVDmYuv2rgbV1En		  (1)  ;



	

	return HI_SUCCESS;
	#endif
    return HI_SUCCESS;
}

HI_S32 VDP_DRV_SetHisiHdrGfxBaseSetting(VDP_HISI_HDR_CFG_S  *stHdrCfg)
{
    #if 0
		VDP_GFX_SetInDataFmt		   (VDP_LAYER_GFX0, VDP_GFX_IFMT_ARGB_8888);
		VDP_GFX_SetReadMode 		   (VDP_LAYER_GFX0, VDP_RMODE_PROGRESSIVE);
		VDP_GFX_SetPreMultEnable	   (VDP_LAYER_GFX0, HI_FALSE);
		VDP_GFX_SetLayerGalpha		   (VDP_LAYER_GFX0, 0xff);
		VDP_GFX_SetPalpha			   (VDP_LAYER_GFX0, 1, 1, 0, 0);

		VDP_GFX_SetInReso			   (VDP_LAYER_GFX0, stHdrCfg->stGfxReso);
		VDP_GFX_SetVideoPos 		   (VDP_LAYER_GFX0, stHdrCfg->stGfxReso);
		VDP_GFX_SetDispPos			   (VDP_LAYER_GFX0, stHdrCfg->stGfxReso);

		VDP_GP_SetInReso			   (VDP_LAYER_GP0, stHdrCfg->stGfxReso);
		VDP_GP_SetOutReso			   (VDP_LAYER_GP0, stHdrCfg->stVidOutReso);
		VDP_GP_SetVideoPos			   (VDP_LAYER_GP0, stHdrCfg->stVidOutReso);
		VDP_GP_SetDispPos			   (VDP_LAYER_GP0, stHdrCfg->stVidOutReso);

		if((stHdrCfg->stGfxReso.u32Wth != stHdrCfg->stVidOutReso.u32Wth)
		|| (stHdrCfg->stGfxReso.u32Hgt != stHdrCfg->stVidOutReso.u32Hgt))
		{
			HI_U32 u64ZmeWth = stHdrCfg->stGfxReso.u32Wth;
			VDP_GP_SetZmeHfirOrder		   (VDP_LAYER_GP0, VDP_ZME_ORDER_VH);

			VDP_GP_SetZmeEnable 		   (VDP_LAYER_GP0, VDP_ZME_MODE_HOR, HI_TRUE);
			VDP_GP_SetZmeEnable 		   (VDP_LAYER_GP0, VDP_ZME_MODE_VER, HI_TRUE);
			VDP_GP_SetZmeFirEnable		   (VDP_LAYER_GP0, VDP_ZME_MODE_HOR, HI_FALSE);
			VDP_GP_SetZmeMidEnable		   (VDP_LAYER_GP0, VDP_ZME_MODE_HOR, HI_FALSE);
			VDP_GP_SetZmeHorRatio		   (VDP_LAYER_GP0, (u64ZmeWth*GZME_HPREC)/stHdrCfg->stVidOutReso.u32Wth);
			VDP_GP_SetZmePhase			   (VDP_LAYER_GP0, VDP_ZME_MODE_HOR, 0*GZME_HPREC);
			VDP_GP_SetZmeFirEnable		   (VDP_LAYER_GP0, VDP_ZME_MODE_VER, HI_FALSE);
			VDP_GP_SetZmeMidEnable		   (VDP_LAYER_GP0, VDP_ZME_MODE_VER, HI_FALSE);
			VDP_GP_SetZmeVerRatio		   (VDP_LAYER_GP0, (stHdrCfg->stGfxReso.u32Hgt*GZME_VPREC)/stHdrCfg->stVidOutReso.u32Hgt);
			VDP_GP_SetZmePhase			   (VDP_LAYER_GP0, VDP_ZME_MODE_VER, 0*GZME_VPREC);
		}

		VDP_GP_SetLayerGalpha		   (VDP_LAYER_GP0, 0xff);
#endif


return HI_SUCCESS;
	}




HI_S32 VDP_DRV_SetHisiVidBaseSetting(VDP_HISI_HDR_CFG_S  *stHdrCfg)
{
	
    HI_PQ_ZME_COEF_RATIO_E enHiPqZmeCoefRatio;
		//----------------------------------------------------------------------
		//BL setting
		//----------------------------------------------------------------------
		VDP_VID_SetLayerEnable			   (VDP_LAYER_VID0, HI_TRUE);
		VDP_VID_SetInDataFmt			   (VDP_LAYER_VID0, stHdrCfg->enVidIFmt);
		
		//VDP_VID_SetInDataFmt			   (VDP_LAYER_VID0, VDP_VID_IFMT_SP_420);
		VDP_VID_SetReadMode 			   (VDP_LAYER_VID0, VDP_RMODE_PROGRESSIVE, VDP_RMODE_PROGRESSIVE);
		VDP_VID_SetDataWidth			   (VDP_LAYER_VID0, stHdrCfg->u32DataWidth);
		//VDP_VID_SetMuteEnable 			 (VDP_LAYER_VID0, stHdrCfg->bMuteEn);
	
		VDP_VID_SetInReso				   (VDP_LAYER_VID0, stHdrCfg->stVidInReso);
		VDP_VID_SetOutReso				   (VDP_LAYER_VID0, stHdrCfg->stVidOutReso);
		VDP_VID_SetVideoPos 			   (VDP_LAYER_VID0, stHdrCfg->stVidOutReso);
		VDP_VID_SetDispPos				   (VDP_LAYER_VID0, stHdrCfg->stVidOutReso);
	
		VDP_VID_SetLayerAddr			   (VDP_LAYER_VID0, 0, stHdrCfg->stVidAddr.u32LumAddr, stHdrCfg->stVidAddr.u32ChmAddr, stHdrCfg->stVidAddr.u32LumStr, stHdrCfg->stVidAddr.u32ChmStr);
		VDP_VID_SetLayerAddr			   (VDP_LAYER_VID0, 1, stHdrCfg->stVidAddr_2LowBit.u32LumAddr, stHdrCfg->stVidAddr_2LowBit.u32ChmAddr, stHdrCfg->stVidAddr.u32LumStr, stHdrCfg->stVidAddr.u32ChmStr);
		VDP_VID_SetTileStride(VDP_LAYER_VID0, stHdrCfg->stVidAddr_2LowBit.u32LumStr, stHdrCfg->stVidAddr_2LowBit.u32ChmStr);
		VDP_VID_SetTileDcmpEnable		   (VDP_LAYER_VID0, stHdrCfg->bDcmpEn);


		//----------mmu setting-------------//
		VDP_VID_Set16RegionSmmuLumBypass (VDP_LAYER_VID0, 0, !stHdrCfg->bSmmuEn);
		VDP_VID_Set16RegionSmmuChromBypass (VDP_LAYER_VID0, 0, !stHdrCfg->bSmmuEn);
		VDP_VID_Set16RegionSmmuLumBypass (VDP_LAYER_VID1, 0, !stHdrCfg->bSmmuEn);
		VDP_VID_Set16RegionSmmuChromBypass (VDP_LAYER_VID1, 0, !stHdrCfg->bSmmuEn);
		//----------------end---------------//


		
		if(stHdrCfg->bDcmpEn == HI_TRUE)
		{
			VDP_VID_SetHeadAddr 	   (VDP_LAYER_VID0, stHdrCfg->stHeadAddr.u32LumAddr, stHdrCfg->stHeadAddr.u32ChmAddr);
			VDP_VID_SetHeadStride	   (VDP_LAYER_VID0, stHdrCfg->stHeadAddr.u32LumStr);
			VDP_VID_SetHeadSize 	   (VDP_LAYER_VID0, stHdrCfg->stHeadAddr.u32DcmpHeadSize);
		}
	
	
	
	//	if((stHdrCfg->stBlReso.u32Wth != stHdrCfg->stBlReso.u32Wth) || (stHdrCfg->stBlReso.u32Hgt != stHdrCfg->stBlReso.u32Hgt))
		{
			VDP_VID_SetZmeEnable		   (VDP_LAYER_VID0, VDP_ZME_MODE_HOR, HI_TRUE);
			VDP_VID_SetZmeEnable		   (VDP_LAYER_VID0, VDP_ZME_MODE_VER, HI_TRUE);
	
			VDP_VID_SetZmePhase 		   (VDP_LAYER_VID0, VDP_ZME_MODE_HOR, 0);
			VDP_VID_SetZmePhase 		   (VDP_LAYER_VID0, VDP_ZME_MODE_VER, 0);
			VDP_VID_SetZmeFirEnable 	   (VDP_LAYER_VID0, VDP_ZME_MODE_HOR, HI_TRUE);
			VDP_VID_SetZmeFirEnable 	   (VDP_LAYER_VID0, VDP_ZME_MODE_VER, HI_TRUE);
			VDP_VID_SetZmeHorRatio		   (VDP_LAYER_VID0, (stHdrCfg->stVidInReso.u32Wth*ZME_HPREC)/stHdrCfg->stVidOutReso.u32Wth);
			VDP_VID_SetZmeVerRatio		   (VDP_LAYER_VID0, (stHdrCfg->stVidInReso.u32Hgt*ZME_VPREC)/stHdrCfg->stVidOutReso.u32Hgt);
	
			VDP_VID_SetZmeInFmt 		   (VDP_LAYER_VID0, VDP_PROC_FMT_SP_420);
			VDP_VID_SetZmeOutFmt		   (VDP_LAYER_VID0, VDP_PROC_FMT_SP_420);

		enHiPqZmeCoefRatio =HI_PQ_ZME_COEF_1;//TODO hyx

		DRV_PQ_GetVdpZmeCoef(enHiPqZmeCoefRatio,HI_PQ_ZME_COEF_TYPE_LH,HI_PQ_ZME_TAP_8T32P, (HI_S16 *)(gstVdpCoefBufAddr.pu8CoefVirAddr[VDP_COEF_BUF_ZME_TMP]));
		DRV_PQ_SetVdpZmeCoef(VDP_ZOOM_TAP_8LH,HI_PQ_ZME_COEF_TYPE_LH,(gstVdpCoefBufAddr.pu8CoefVirAddr[VDP_COEF_BUF_ZMEH]),(gstVdpCoefBufAddr.pu8CoefVirAddr[VDP_COEF_BUF_ZME_TMP]));

		DRV_PQ_GetVdpZmeCoef(enHiPqZmeCoefRatio,HI_PQ_ZME_COEF_TYPE_CH,HI_PQ_ZME_TAP_4T32P, (HI_S16 *)(gstVdpCoefBufAddr.pu8CoefVirAddr[VDP_COEF_BUF_ZME_TMP]));
		DRV_PQ_SetVdpZmeCoef(VDP_ZOOM_TAP_4CH,HI_PQ_ZME_COEF_TYPE_CH,(gstVdpCoefBufAddr.pu8CoefVirAddr[VDP_COEF_BUF_ZMEH]+256),(gstVdpCoefBufAddr.pu8CoefVirAddr[VDP_COEF_BUF_ZME_TMP]));	

		DRV_PQ_GetVdpZmeCoef(enHiPqZmeCoefRatio,HI_PQ_ZME_COEF_TYPE_LV,HI_PQ_ZME_TAP_6T32P, (HI_S16 *)(gstVdpCoefBufAddr.pu8CoefVirAddr[VDP_COEF_BUF_ZME_TMP]));
		DRV_PQ_SetVdpZmeCoef(VDP_ZOOM_TAP_6LV,HI_PQ_ZME_COEF_TYPE_LV,(gstVdpCoefBufAddr.pu8CoefVirAddr[VDP_COEF_BUF_ZMEV]),(gstVdpCoefBufAddr.pu8CoefVirAddr[VDP_COEF_BUF_ZME_TMP]));	
		DRV_PQ_GetVdpZmeCoef(enHiPqZmeCoefRatio,HI_PQ_ZME_COEF_TYPE_CV,HI_PQ_ZME_TAP_4T32P, (HI_S16 *)(gstVdpCoefBufAddr.pu8CoefVirAddr[VDP_COEF_BUF_ZME_TMP]));
		DRV_PQ_SetVdpZmeCoef(VDP_ZOOM_TAP_4CV,HI_PQ_ZME_COEF_TYPE_CV,(gstVdpCoefBufAddr.pu8CoefVirAddr[VDP_COEF_BUF_ZMEV]+256),(gstVdpCoefBufAddr.pu8CoefVirAddr[VDP_COEF_BUF_ZME_TMP]));	
	
		VDP_VID_SetZmeCoefAddr(VDP_LAYER_VID0, VDP_VID_PARA_ZME_HOR , (gstVdpCoefBufAddr.u32CoefPhyAddr[VDP_COEF_BUF_ZMEH]));
		VDP_VID_SetZmeCoefAddr(VDP_LAYER_VID0, VDP_VID_PARA_ZME_VER , (gstVdpCoefBufAddr.u32CoefPhyAddr[VDP_COEF_BUF_ZMEV]));
		VDP_VID_SetParaUpd(VDP_LAYER_VID0,VDP_VID_PARA_ZME_HOR);
		VDP_VID_SetParaUpd(VDP_LAYER_VID0,VDP_VID_PARA_ZME_VER);

			
		}
		
	
		//----------------------------------------------------------------------
		//VP setting
		//----------------------------------------------------------------------
		VDP_VP_SetInReso			   (VDP_LAYER_VP0, stHdrCfg->stVidOutReso);
		VDP_VP_SetVideoPos			   (VDP_LAYER_VP0, stHdrCfg->stVidOutReso);
		VDP_VP_SetDispPos			   (VDP_LAYER_VP0, stHdrCfg->stVidOutReso);
		VDP_VP_SetMuteEnable		   (VDP_LAYER_VP0, stHdrCfg->bMuteEn);
	
		//stVpMuteBkg.u32VpMuteBkgY=0x40;
		//stVpMuteBkg.u32VpMuteBkgU=0x200;
		//stVpMuteBkg.u32VpMuteBkgV=0x200;
		//
		//VDP_VP_SetMuteBkg			   (VDP_LAYER_VP0,stVpMuteBkg);

return HI_SUCCESS;



}

HI_S32 VDP_DRV_SetHisiHdrMode(VDP_HISI_HDR_CFG_S  *stHdrCfg, HiHDRDmTMCfg  *pstHisiHdrTmCfg)
{

	//enable
	HI_U32 bl_en             = 1;
	HI_U32 el_en             = 0;
	HI_U32 composer_en       = 0;
	HI_U32 edr_en            = 0;
	HI_U32 edr_md_en         = 0;
	HI_U32 edr_ds_en         = 0;

	//vdm
	HI_U32 vdm_degmm_en      = 1;
	HI_U32 vdm_rgb2lms_en    = 1;
	HI_U32 vdm_gmm_en        = 1;
	HI_U32 vdm_gmm_v0_en     = 1;
	HI_U32 vdm_gmm_v1_en     = 1;

	//cvm1:full spec
	HI_U32 cvm_sel           = 0;//0: vid select cvm1; 1: gfx select cvm1
	HI_U32 vcvm_en           = 1;
	HI_U32 cvm1_lms2ipt_en   = 1;
	HI_U32 cvm1_ipt2lms_en   = 1;
	HI_U32 cvm1_lms2rgb_en   = 1;
	HI_U32 cvm1_rgb2yuv_en   = 1;
    HI_U32 cvm1_degmm_en     = 1;
    HI_U32 cvm1_gmm_en       = 1;

	HI_U32 cvm2_lms2ipt_en   = 1;
	HI_S32 cvm2_lms2ipt_out_dc[3] = {0};

	HI_S32 csc_offset[3] = {0};
	HI_S16 csc_m3[3][3] = {{1, 0, 0}, {0, 1, 0}, {0, 0, 1}};

	//-------for ec csc---------//
	HI_U32 u32Pre	=0; 
	HI_U32 u32DcPre  =0;
	HI_U32 vcvm_csc_en =1;
	HI_U32	u32Scale=0;
	HI_S16 m33Yuv2RgbScale2P=0;
	HI_S16 v_imap_lms2ipt[3][3]={{0,0,0}};
	HI_S32 s32CscDc[3]={0};

	VDP_VID_SetMuteEnable              (VDP_LAYER_VID0, stHdrCfg->bMuteEn);
	VDP_VID_SetMuteEnable              (VDP_LAYER_VID1, stHdrCfg->bMuteEn);
	//-------end for ec csc---------//


	//--------add by hyx for ec csc-----------------------//
	VDP_HDR_SetVDmImapRgb2lms(csc_m3);
	VDP_HDR_SetVDmImapRgb2lmsscale2p(0);
	VDP_HDR_SetVDmRgb2lmsEn(1);
	
	 u32Pre = 1 << 10;
	 u32DcPre = 4 * 32 ;//1:8bit; 4:10bit
	
	m33Yuv2RgbScale2P	  =  15;	 //sGetRandEx(5,31);		 
	
	u32Scale	= 1 << (m33Yuv2RgbScale2P - 10);
	u32DcPre	= 4 * 64;
	
	
	v_imap_lms2ipt[0][0]	  =  (HI_S32)(1  * u32Pre*u32Scale/2);
	v_imap_lms2ipt[0][1]	  =  (HI_S32)(0  * u32Pre*u32Scale/2);
	v_imap_lms2ipt[0][2]	  =  (HI_S32)(0  * u32Pre*u32Scale/2);
	v_imap_lms2ipt[1][0]	  =  (HI_S32)(0 * u32Pre*u32Scale/2);
	v_imap_lms2ipt[1][1]	  =  (HI_S32)(1 * u32Pre*u32Scale/2);
	v_imap_lms2ipt[1][2]	  =  (HI_S32)(0 * u32Pre*u32Scale/2);
	v_imap_lms2ipt[2][0]	  =  (HI_S32)(0 * u32Pre*u32Scale/2);
	v_imap_lms2ipt[2][1]	  =  (HI_S32)(0 * u32Pre*u32Scale/2);
	v_imap_lms2ipt[2][2]	  =  (HI_S32)(1 * u32Pre*u32Scale/2);
	s32CscDc[0] =  0;	
	s32CscDc[1] =  0;	
	s32CscDc[2] =  0;	
	
	VDP_HDR_SetCvmSel	(0);
	VDP_HDR_SetVCvmLms2iptEn		(vcvm_csc_en);
	
	VDP_HDR_SetVCvmImapLms2iptscale2p(m33Yuv2RgbScale2P | (vcvm_csc_en<<5) );
	
	VDP_HDR_SetVCvmImapLms2ipt		 (v_imap_lms2ipt);
	VDP_HDR_SetVCvmImapLms2iptOutDc  (s32CscDc );
	VDP_HDR_SetVDmImapLms2iptmin	 (0);
	VDP_HDR_SetVDmImapLms2iptmax	 (0x7FFF);
	
	//-------------end----------------------//

	
	//----------------------------------------------------------------------
	//HDR10 OUTPUT
	//----------------------------------------------------------------------
	 if(stHdrCfg->enHdrMode == VDP_HIHDR_HDR10_IN_HDR10_OUT)
	{
		bl_en                = 0;
		cvm_sel              = 0;
	    edr_ds_en            = 0;
	}
	else if(stHdrCfg->enHdrMode == VDP_HIHDR_HDR10_IN_SDR_OUT)
	{
	    edr_md_en            = 0;
	    edr_ds_en            = 0;
		cvm_sel              = 0;
	    cvm2_lms2ipt_en      = 1;
		vcvm_en 			 = 1;
		cvm1_ipt2lms_en		 = 1;
		cvm1_lms2rgb_en		 = 1;
		cvm1_rgb2yuv_en		 = 1;
    
	}



	VDP_CBM_SetMixerPrio(VDP_CBM_MIXV0, VDP_LAYER_VID0,1);
	VDP_CBM_SetMixerPrio(VDP_CBM_MIXV0, VDP_LAYER_VID1,0);	

	VDP_HDR_SetVDmEn               (1);

	VDP_DRV_SetGdmDegammaCoef(gdm_degmm_lut);
	
	VDP_DRV_SetGdmgammaCoef(gdm_gmm_lut);
	//VDP_DRV_SetGdmgammaCoef(gdm_gmm_hihdrlut);
    
	VDP_DRV_SetHisiDegammaCoef(HisiHdr10_1024Lut,1024);
	VDP_DRV_SetHisigammaCoef(HisiHdr10l2pqLutX,HisiHdr10l2pqLutA,HisiHdr10l2pqLutB);

	
	VDP_DRV_SetHisiDmCvmCoef(pstHisiHdrTmCfg->s16V_TMLutI,pstHisiHdrTmCfg->s16V_TMLutS,pstHisiHdrTmCfg->s16V_SMLutI,pstHisiHdrTmCfg->s16V_SMLutS);

	VDP_HDR_SetGdmParaUpd(VDP_LAYER_GP0,VDP_GP_PARA_HDR_DEGMM);
	VDP_HDR_SetGdmParaUpd(VDP_LAYER_GP0,VDP_GP_PARA_HDR_GMM);
	VDP_HDR_SetDmInputDegmmParaup  ();
	VDP_HDR_SetDmInputGammaParaup  ();
	VDP_HDR_SetDmCvmParaup		   ();
	VDP_HDR_SetDmOutputDegmmParaup ();
	VDP_HDR_SetDmOutputGammaParaup ();

	//图形层基本设置
	VDP_GFX_SetLayerEnable         (VDP_LAYER_GFX0, stHdrCfg->bGfxEn);
	if(stHdrCfg->bGfxEn)
	{
		//VDP_DRV_SetHisiHdrGfxBaseSetting(stHdrCfg);
	}

	//视频层基本设置
	VDP_DRV_SetHisiVidBaseSetting(stHdrCfg);




	if(stHdrCfg->bPreMult == HI_FALSE)
	{
		
		VDP_GFX_SetPreMultEnable(VDP_LAYER_GFX0,HI_FALSE);
		VDP_GFX_MixvBypassEn		   (1);
		VDP_GFX_MixvPremultEn		   (0);
	}


	//----------------------------------------------------------------------
	//data path setting
	//----------------------------------------------------------------------
	VDP_HDR_SetCvmSel                     ( cvm_sel);

	if(stHdrCfg->enHdrMode == VDP_HIHDR_HDR10_IN_HDR10_OUT)
	{

		
		VDP_HDR_SetHdrEnable			   ( 0 );
        VDP_HDR_SetVDmDegammaEn            ( 0 );
        VDP_HDR_SetVDmGammaEn              ( 0 );
        VDP_HDR_SetVDmNormEn               ( 0 );
        VDP_HDR_SetVCvmEn                  ( 0 );
        VDP_HDR_SetVCvmDegammaEn           ( 0 );
        VDP_HDR_SetVCvmMGammaEn            ( 0 );
        VDP_HDR_SetVCvmDenormEn            ( 0 );
        
        VDP_VID_SetIfirMode(VDP_LAYER_VID0, VDP_IFIRMODE_6TAPFIR);
        VDP_HDR_SetVDmYuv2rgbV0En      (HI_FALSE);
        VDP_HDR_SetVDmYuv2rgbEn            ( 0 );
		VDP_VID_SetZmeOutFmt		   (VDP_LAYER_VID0, VDP_PROC_FMT_SP_422);

		if(stHdrCfg->bGfxEn)
		{
			VDP_DRV_SetGdmgammaCoef(gdm_gmm_hihdrlut);
			VDP_HDR_SetGdmParaUpd(VDP_LAYER_GP0,VDP_GP_PARA_HDR_GMM);
			VDP_DRV_SetHisiGdmHdr10InHdr10Out();
		}

	}
	else if(stHdrCfg->enHdrMode == VDP_HIHDR_HDR10_IN_SDR_OUT )
	{
		bl_en			     = 0;
		el_en				 = 0;
		composer_en          = 0;
	    edr_md_en            = 0;
	    edr_ds_en            = 0;
		cvm_sel              = 0;

        csc_offset[0] = 0;
		csc_offset[1] = 0;
		csc_offset[2] = 0;
        VDP_HDR_SetVDmImapYuv2rgbInDc0       ( csc_offset );

		VDP_VID_SetZmeOutFmt		   (VDP_LAYER_VID0, VDP_PROC_FMT_SP_420);
		VDP_HDR_SetHdrEnable		   (1);
		VDP_VID_SetComposerBlEn 	   ( bl_en  );
		VDP_VID_SetComposerElEn 		 ( el_en  );
		VDP_DRV_SetHisiVdm();
		if(stHdrCfg->bGfxEn)
		{
			VDP_DRV_SetHisiGdm();
		}


		if(stHdrCfg->bPreMult == HI_FALSE)
		{
			VDP_HDR_SetGCvmLms2IptEn          ( cvm2_lms2ipt_en                     );
			
			csc_offset[0] =16;
			csc_offset[1] =128;
			csc_offset[2] =128;
			
			 csc_m3[0][0] = 1638;
			 csc_m3[0][1] = 1638;
			 csc_m3[0][2] = 819;
			 csc_m3[1][0] = 18248;
			 csc_m3[1][1] = -19870;
			 csc_m3[1][2] = 1622;
			 csc_m3[2][0] = 3300;
			 csc_m3[2][1] = 1463;
			 csc_m3[2][2] = -4763;

			 
			VDP_HDR_SetGCvmLms2Ipt            ( csc_m3);
			VDP_HDR_SetGCvmLms2IptScale2p     ( 12 + 1);
			VDP_HDR_SetGCvmLms2IptOutDc       ( cvm2_lms2ipt_out_dc                 );

			VDP_HDR_SetGCvmLms2IptMin      (0x8001);//   (-((1<<15)));
			VDP_HDR_SetGCvmLms2IptMax         (((1<<15)-1));
			
		}


		//VDM(V2020)
	    VDP_HDR_SetVDmYuv2rgbEn        ( 1 );
	    VDP_HDR_SetVDmYuv2rgbV0En      ( 1 );
	    VDP_HDR_SetVDmYuv2rgbV1En      ( 0 );


	    VDP_HDR_SetVDmDegammaEn        ( vdm_degmm_en      );
	    VDP_HDR_SetVDmRgb2lmsEn        ( vdm_rgb2lms_en    );
	    VDP_HDR_SetVDmGammaEn          ( vdm_gmm_en        );
	    VDP_HDR_SetVDmGammaV0En        ( vdm_gmm_v0_en     );
	    VDP_HDR_SetVDmGammaV1En        ( vdm_gmm_v1_en     );

	    //VCVM1
	    VDP_HDR_SetVCvmEn              ( vcvm_en           );
	    VDP_HDR_SetVCvmLms2iptEn       ( cvm1_lms2ipt_en   );
	    VDP_HDR_SetVCvmIpt2lmsEn       ( cvm1_ipt2lms_en   );//by hyx
	    VDP_HDR_SetVCvmLms2rgbEn       ( cvm1_lms2rgb_en   );//by hyx
	    VDP_HDR_SetVCvmRgb2yuvEn       ( cvm1_rgb2yuv_en   );//by hyx

	    VDP_HDR_SetVCvmDegammaEn       ( cvm1_degmm_en     );
	    VDP_HDR_SetVCvmMGammaEn        ( cvm1_gmm_en       );

	    //GDM
	    VDP_HDR_SetGDmEn               ( 1            );
	    VDP_HDR_SetGDmDegammaEn        ( 1    		  );
	    VDP_HDR_SetGDmRgb2lmsEn        ( 1   		  );
	    VDP_HDR_SetGDmGammaEn          ( 1             );
	    VDP_HDR_SetAuthEn              ( 1                 );

	    //EDR
	    VDP_HDR_SetDmEdrEn             ( edr_en            );
	    VDP_HDR_SetDmHdrMdEn           ( edr_md_en         );
	    VDP_HDR_SetDmHdrDsEn           ( edr_ds_en         );



	}

    

	//----------------------------------------------------------------------
	//do not support the function in HDR mode
	//----------------------------------------------------------------------
    VDP_VID_SetFlipEnable              (VDP_LAYER_VID0, HI_FALSE);
    VDP_VID_SetUvorder                 (VDP_LAYER_VID0, HI_FALSE);
    VDP_VID_SetDrawMode                (VDP_LAYER_VID0, VDP_DRAW_MODE_1, VDP_DRAW_MODE_1);

    VDP_VID_SetMultiModeEnable         (VDP_LAYER_VID1, HI_FALSE);
    VDP_VID_SetFlipEnable              (VDP_LAYER_VID1, HI_FALSE);
    VDP_VID_SetUvorder                 (VDP_LAYER_VID1, HI_FALSE);
    VDP_VID_SetDrawMode                (VDP_LAYER_VID1, VDP_DRAW_MODE_1, VDP_DRAW_MODE_1);

    VDP_DISP_SetDispMode               (VDP_CHN_DHD0, VDP_DISP_MODE_2D);
    VDP_DISP_SetDispMode               (VDP_CHN_DHD0, VDP_DISP_MODE_2D);
	//----------------------------------------------------------------------
	//disable all PQ
	//----------------------------------------------------------------------
    VDP_VID_SetSharpEnable             (VDP_LAYER_VID0, HI_FALSE);
    VDP_VID_SetZme2Enable              (VDP_LAYER_VID0, VDP_ZME_MODE_HOR, HI_FALSE);
    VDP_VID_SetZme2Enable              (VDP_LAYER_VID0, VDP_ZME_MODE_VER, HI_FALSE);

    VDP_VP_SetAcmEnable                (VDP_LAYER_VP0, HI_FALSE);
    VDP_VP_SetDciEnable                (VDP_LAYER_VP0, HI_FALSE);

	VDP_VID_SetRegUp(VDP_LAYER_VID0);
	VDP_VID_SetRegUp(VDP_LAYER_VID1);
    
	VDP_GP_SetRegUp(VDP_LAYER_GFX0);
	VDP_VP_SetRegUp(VDP_LAYER_VP0);
    VDP_HDR_SetRegUp();
    VDP_DISP_SetRegUp (VDP_CHN_DHD0);
	return HI_SUCCESS;

}


static HI_U32   u32GFX_AlphabBack = 0xff;
static HI_U32   u32GFX_MuteBack = 0;

HI_VOID VDP_DRV_HiSiHdrClean(HI_BOOL bclear)
{
    if(!bclear)
    {
        VDP_VID_SetLayerEnable (VDP_LAYER_VID1, HI_FALSE);

        VDP_HDR_SetHdrEnable		    (HI_FALSE);
        VDP_HDR_SetVCvmDenormEn 	    (HI_FALSE);
        VDP_HDR_SetVDmNormEn		    (HI_FALSE);
        VDP_HDR_SetVDmInColor		    (1);
        VDP_HDR_SetVDmEn			    (1);
        VDP_HDR_SetVDmGammaEn           (0);
        VDP_HDR_SetVDmDegammaEn         (0);
        VDP_HDR_SetVDmGammaV0En         (0);
        VDP_HDR_SetVDmGammaV1En         (0);
        VDP_HDR_SetDmHdrDsEn            (0);
        VDP_HDR_SetDmHdrMdEn            ( 0 );
        VDP_HDR_SetGDmEn                ( 0 );
        VDP_HDR_SetGDmDegammaEn         ( 0 );
        VDP_HDR_SetGDmRgb2lmsEn         ( 0 );
        VDP_HDR_SetGDmGammaEn           ( 0 );
        VDP_HDR_SetVDmYuv2rgbV0En      (HI_FALSE);
        VDP_HDR_SetVDmYuv2rgbEn            ( 0 );

        VDP_HDR_SetCvmSel			    (0);
        VDP_HDR_SetVCvmLms2iptEn		(1)  ;
        VDP_HDR_SetVCvmEn			    (0 ) ;
        VDP_HDR_SetVDmInBits			(1) ;
        VDP_DISP_SetHdmiMode(VDP_CHN_DHD0, 0);

        //VDP_VP_SetMuteEnable              (VDP_LAYER_VP0, HI_FALSE);

        /*closed GFX */
        VDP_GP_GetLayerGalpha(0, &u32GFX_AlphabBack);
        VDP_GFX_GetMuteEnable(0, &u32GFX_MuteBack);

        VDP_GP_SetLayerGalpha(0, 0);
        VDP_GFX_SetMuteEnable(0, 1);

        VDP_GP_SetRegUp(VDP_LAYER_GFX0);
        VDP_HDR_SetRegUp();
        VDP_VID_SetRegUp(VDP_LAYER_VID1);
        //VDP_VP_SetRegUp(VDP_LAYER_VP0);
        VDP_DISP_SetRegUp(VDP_CHN_DHD0);
    }
    else
    {
        /*resum GFX  */
        VDP_GP_SetLayerGalpha(0, u32GFX_AlphabBack);
        VDP_GFX_SetMuteEnable(0, u32GFX_MuteBack);
        VDP_GFX_MixvBypassEn	(0);
        VDP_GP_SetRegUp(VDP_LAYER_GFX0);
        VDP_HDR_SetRegUp();
        VDP_VID_SetRegUp(VDP_LAYER_VID1);
        //VDP_VP_SetRegUp(VDP_LAYER_VP0);
        VDP_DISP_SetRegUp(VDP_CHN_DHD0);
    }
    
}


HI_VOID VDP_DRV_HiSiHdrMute(HI_BOOL bMuteEn)
{
    //VDP_VP_MUTE_BK_S        stVpMuteBkg={0};
	VDP_VP_SetMuteEnable		   (VDP_LAYER_VP0, bMuteEn);

	//stVpMuteBkg.u32VpMuteBkgY=0x40;
	//stVpMuteBkg.u32VpMuteBkgU=0x200;
	//stVpMuteBkg.u32VpMuteBkgV=0x200;
	
	//VDP_VP_SetMuteBkg 		   (VDP_LAYER_VP0,stVpMuteBkg);
	VDP_VID_SetRegUp(VDP_LAYER_VID0);
	VDP_VP_SetRegUp(VDP_LAYER_VP0);


}


