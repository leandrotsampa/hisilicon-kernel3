/******************************************************************************

  Copyright (C), 2012-2050, Hisilicon Tech. Co., Ltd.

 ******************************************************************************
  File Name     : hal_hdmirx_reg.h
  Version       : Initial Draft
  Author        : Hisilicon multimedia software group
  Created       : 2014/1/16
  Description   : 
  History       :
  1.Date        : 2014/01/16
    Author      : t00202585
    Modification: Created file
******************************************************************************/

#ifndef __HAL_HDMIRX_REG_H__
#define __HAL_HDMIRX_REG_H__

#ifdef __cplusplus
 #if __cplusplus
        extern "C" {
 #endif
#endif /* __cplusplus */

#define BIT0    0x01
#define BIT1    0x02
#define BIT2    0x04
#define BIT3    0x08
#define BIT4    0x10
#define BIT5    0x20
#define BIT6    0x40
#define BIT7    0x80
#define BIT7_5  (BIT7|BIT6|BIT5)
#define BIT7_6	(BIT7|BIT6)
#define BIT5_4	(BIT5|BIT4)
#define BIT4_3	(BIT4|BIT3)
#define BIT4_2  (BIT4|BIT3|BIT2)
#define BIT3_2	(BIT3|BIT2)
#define BIT2_1	(BIT2|BIT1)

#define BIT7_4	(BIT7|BIT6|BIT5|BIT4)
#define BIT6_3	(BIT6|BIT5|BIT4|BIT3)
#define BIT6_4	(BIT6|BIT5|BIT4)
#define BIT1_0	(BIT1|BIT0)
#define BIT2_0	(BIT2|BIT1|BIT0)
#define BIT3_0	(BIT3|BIT2|BIT1|BIT0)
#define BIT4_0	(BIT0|BIT1|BIT2|BIT3|BIT4)
#define BIT5_0	(BIT0|BIT1|BIT2|BIT3|BIT4|BIT5)
#define BIT6_0	(BIT0|BIT1|BIT2|BIT3|BIT4|BIT5|BIT6)
#define BIT7_0	(BIT7|BIT6|BIT5|BIT4|BIT3|BIT2|BIT1|BIT0)

/**********************************PAGE 0**************************************/

#define RX_DEV_IDH                          0x000C

#define RX_DEV_IDL                          0x0008

#define RX_DEV_REV                          0x0010

#define RX_AON_SRST                         0x0014
    #define reg_sw_rst_auto         	BIT4
    #define reg_sw_rst              	BIT0 
    
/*#define RX_SYS_SWTCHC                       0x0024
    #define reg_ddc_sda_in_del_en   	BIT7
    #define reg_ddc_sda_out_del_en  	BIT5
    #define reg_ddc_en              	BIT4
    #define ddc_filter_sel          	BIT3_2*/
    
#define RX_C0_SRST2                         0x002c
    #define reg_cec_sw_rst          	BIT6
    #define reg_hdmim_sw_rst        	BIT4
   //dzjun mod
    //#define ddc_filter_sel          BIT3

#define RX_STATE_AON                        0x0030
    #define hdmi_tx_connected       	BIT3
    #define ckdt                    	BIT1
    #define scdt                    	BIT0

#define RX_DUMMY_CONFIG1                    0x0060
	#define reg_pwr5v0_inv				BIT0
	#define reg_pwr5v1_inv				BIT1

	#define reg_hpd0_inv				BIT4
	#define reg_hpd1_inv				BIT5


	
#define RX_INTR_STATE                       0x01c0
    #define reg_intr                	BIT0

#define RX_INTR2_AON                        0x0200
    #define intr_soft_intr_en       	BIT5
    #define intr_ckdt               	BIT4
    #define intr_scdt               	BIT3

#define RX_INTR6_AON                        0x0204
    #define intr_pwr5v             		BIT0

#define RX_INTR7_AON                        0x0208
    #define cec_interrupt           	BIT4

#define RX_INTR8_AON                        0x020c
    #define intr_cable_in           	BIT1

#define RX_INTR2_MASK_AON                   0x0240

#define RX_INTR6_MASK_AON                   0x0244

#define RX_INTR7_MASK_AON                   0x0248

#define RX_INTR8_MASK_AON                   0x024c


/**********************************PAGE 1**************************************/
#define RX_ACR_CTRL1                        0x0400
    #define reg_cts_dropped_auto_en 	BIT7
    #define reg_post_hw_sw_sel      	BIT6
    #define reg_upll_hw_sw_sel      	BIT5
    #define reg_cts_hw_sw_sel       	BIT4
    #define reg_n_hw_sw_sel         	BIT3
    #define reg_cts_reused_auto_en  	BIT2
    #define reg_fs_hw_sw_sel        	BIT1
    #define reg_acr_init            	BIT0


#define AAC_MCLK_SEL                        0x0404
    #define reg_vcnt_max            	BIT7_6
    #define reg_mclk4dac            	BIT5_4
    #define reg_mclk4hbra           	BIT3_2
    #define reg_mclk4dsd            	BIT1_0

#define RX_FREQ_SVAL                        0x0408
    #define reg_fm_in_val_sw        	BIT7_6
    #define reg_fm_val_sw           	BIT5_4
    #define reg_fs_val_sw           	BIT3_0

#define RX_N_HVAL1                          0x0418
    
#define RX_N_HVAL2                          0x041c
    
#define RX_N_HVAL3                          0x0420
    
#define RX_CTS_HVAL1                        0x0430
    
#define RX_CTS_HVAL2                        0x0434
    
#define RX_CTS_HVAL3                        0x0438

#define RX_POST_SVAL                        0x0444
    #define reg_post_val_sw             BIT5_0
    
#define RX_LK_WIN_SVAL                      0x044c
    
#define RX_LK_THRS_SVAL1                    0x0450
    
#define RX_LK_THRS_SVAL2                    0x0454
    
#define RX_LK_THRS_SVAL3                    0x0458

#define RX_TCLK_FS                          0x045c
    #define rhdmi_aud_sample_f_extn 	BIT7_6
    #define reg_fs_filter_en        	BIT4
    #define rhdmi_aud_sample_f      	BIT3_0

#define RX_ACR_CTRL3                        0x0460
    #define reg_cts_thresh          	BIT6_3
    #define reg_mclk_loopback       	BIT2
    #define reg_log_win_ena         	BIT1
    #define reg_post_div2_ena       	BIT0


#define RX_I2S_CTRL1                        0x0498
    #define reg_invalid_en          	BIT7
    #define reg_clk_edge            	BIT6
    #define reg_size                	BIT5
    #define reg_msb                 	BIT4
    #define reg_ws                  	BIT3
    #define reg_justify             	BIT2
    #define reg_data_dir            	BIT1
    #define reg_1st_bit             	BIT0

#define RX_I2S_CTRL2                        0x049c
    #define reg_sd3_en              	BIT7
    #define reg_sd2_en              	BIT6
    #define reg_sd1_en              	BIT5
    #define reg_sd0_en              	BIT4
    #define reg_mclk_en             	BIT3
    #define reg_mute_flat           	BIT2
    #define reg_vucp                	BIT1
    #define reg_pcm                 	BIT0

#define RX_AUDRX_CTRL                       0x04a4    
    #define reg_i2s_length_en       	BIT7
    #define reg_inv_cor_en          	BIT6
    #define reg_hw_mute_en          	BIT5
    #define reg_pass_spdif_err      	BIT4
    #define reg_pass_aud_err        	BIT3
    #define reg_i2s_mode            	BIT2
    #define reg_spdif_mode          	BIT1
    #define reg_spdif_en            	BIT0

#define RX_CHST1                            0x04a8

#define RX_CHST4                            0x04c0
    #define CHST4_SAMPLE_F		    	BIT3_0

#define RX_AUDP_MUTE                        0x04dc
    #define aac_audio_mute          	BIT4
    #define reg_mute_out_pol        	BIT2
    #define reg_audio_mute          	BIT1

#define RX_VID_XPCNT3                       0x059c
        
#define VID_XPCLK_Base                      0x05a4

#define RX_VID_XPCLK_EN                     0x05a8
    #define reg_vid_xclkpclk_en     	BIT0

#define RX_VID_XPCNT1                       0x05b8
        
#define RX_VID_XPCNT2                       0x05bc

#define RX_APLL_POLE                        0x0620
    
#define RX_APLL_CLIP                        0x0624

#define AEC4_CTRL                           0x06c4

#define AEC3_CTRL                           0x06c8
    #define AAC_UNMUTE_NEW_AUDIO    	BIT1
    #define AAC_UNMUTE_CTS          	BIT0

#define AEC2_CTRL                           0x06cc
    #define AAC_UNMUTE_GOT_FIFO_OVER    BIT3
    #define AAC_UNMUTE_GOT_FIFO_UNDER   BIT2
    #define AAC_UNMUTE_GOT_HDMI         BIT0

#define AEC1_CTRL                           0x06d0
    #define  AAC_UNMUTE_TIME_OUT    	BIT4
    #define  AAC_NEW_ALGORITH       	BIT2
    #define  AAC_SIMPLE_METHOD      	BIT0
    
#define AEC0_CTRL                           0x06d4
    #define reg_ctrl_acr_en         	BIT7
    #define reg_aac_exp_sel         	BIT6
    #define reg_aac_out_off_en      	BIT5
    #define aud_div_min             	BIT4
    #define aac_mute_stat           	BIT3
    #define reg_aac_all             	BIT1
    #define reg_aac_en              	BIT0

#define RX_AEC_EN1                          0x06d8
    #define BIT_CKDT_DETECT         	BIT7
    #define BIT_SYNC_DETECT         	BIT6
    #define BIT_CABLE_UNPLUG        	BIT0
    
#define RX_AEC_EN2                          0x06dc
    #define BIT_H_RES_CHANGED       	BIT7
    #define BIT_FS_CHANGED          	BIT4
    #define BIT_AUDIO_FIFO_OVERRUN  	BIT2
    #define BIT_AUDIO_FIFO_UNDERUN  	BIT1
    #define BIT_HDMI_MODE_CHANGED   	BIT0

#define RX_AEC_EN3                          0x06e0
    #define BIT_V_RES_CHANGED       	BIT0
    
/**********************************PAGE 2**************************************/
#define DDC_CTRL							0x0800
	#define reg_ddc_sda_in_del_en		BIT0
	#define reg_ddc_sda_out_del_en		BIT1
	#define reg_ddc_filter_sel			BIT3_2
	
#define HDMI_TX_STATUS						0x0804
	#define tctl_hdmi_tx_connected		BIT3_0
	
#define SYS_RESET_CTRL						0x0808
	#define reg_ddc_rst					BIT0

#define PA_HPD_DIS_EN						0x080c
	#define reg_pa_hpd_dis_en			BIT3_0

#define PA_DDC_DIS_EN						0x0810
	#define reg_pa_hdcp_ddc_dis_en		BIT3_0
	#define reg_pa_edid_ddc_dis_en		BIT7_4
	
#define RX_DDC_EN                           0x0814
    #define reg_hdcp_ddc_en         	BIT3_0
    #define reg_edid_ddc_en         	BIT7_4

#define HPD_C_CTRL							0x0818
	#define reg_hpd_c_ctrl				BIT3_0

#define HPD_OEN_CTRL						0x081c
	#define reg_hpd_oen_ctrl			BIT3_0

#define HPD_PE_CTRL							0x0820
	#define reg_hpd_pe_ctrl				BIT3_0

#define HPD_PU_CTRL							0x0824
	#define reg_hpd_pu_ctrl				BIT3_0

#define HPD_OVRT_CTRL						0x0828
	#define reg_hpd_ovrt_ctrl			BIT3_0
	
#define CEC_PA_ADDR							0x082c

#define P0_CEC_PAD_L						0x0830	

#define P0_CEC_PAD_H						0x0834

#define P1_CEC_PAD_L						0x0838	
	
#define P1_CEC_PAD_H						0x083c

#define P2_CEC_PAD_L						0x0840	
		
#define P2_CEC_PAD_H						0x0844

#define P3_CEC_PAD_L						0x0848	
			
#define P3_CEC_PAD_H						0x084c

#define P0_CHECKSUM							0x0850

#define P1_CHECKSUM							0x0854

#define P2_CHECKSUM							0x0858

#define P3_CHECKSUM							0x085c

#define DMRX_EDID_PAGE						0x0880

#define TMDS0_CTRL2                         0x908
    #define reg_hdmi_rx0_lobw           BIT0
    #define reg_p0_en_gate_clk          BIT1
    #define reg_hdmi_rx0_mhl_test       BIT2
    #define reg0_eq_tbd                 BIT3
    #define reg_mhl_test_soft_ctrl      BIT4
    #define reg0_itempco_ctl            BIT7_5

#define TMDS0_CTRL3							0x090c

#define PLL0_CALREFSEL                      0x0914
    #define reg_pll0_calrefsel          BIT3_0
    #define reg_pll0_icpcomp            BIT5_4
    #define reg_pll0_mode               BIT7_6
    
#define PLL0_VCOCAL                         0x0920
    #define reg_pll0_vcocal_def         BIT2_0


#define TMDS0_CTRL4                         0x0924
    #define reg_p0_bias_bgr_d           BIT3_0
    #define reg_p0_dpcolor_ctl          BIT6_4
    #define reg_p0_dpcolor_sw_ovr       BIT7

#define TMDS0_TERMCTRL0                     0x0928
    #define reg_term_sel_0              BIT1_0
    #define reg_term_ctl0               BIT4_2
    #define reg0_eq_bias_rstb           BIT5
    #define reg0_eq_noise_dec           BIT6
    #define reg0_pclk_en                BIT7

#define TMDS0_PD_SYS2                       0x092c
       
#define TMDS0_CTRL5							0x0930

#define PLL1_CALREFSEL                      0x0944


#define TMDS1_CTRL4                         0x0954
    #define reg_p1_bias_bgr_d           BIT3_0
    #define reg_p1_dpcolor_ctl          BIT6_4
    #define reg_p1_dpcolor_sw_ovr       BIT7

#define TMDS1_TERMCTRL0                     0x0958
    #define reg_term_sel_1              BIT1_0
    #define reg_term_ctl1               BIT4_2
    #define reg1_eq_bias_rstb           BIT5
    #define reg1_eq_noise_dec           BIT6
    #define reg1_pclk_en                BIT7
    
#define TMDS1_PD_SYS2                       0x095c

#define PLL2_CALREFSEL                      0x0974

#define TMDS2_CTRL4                         0x0984
    #define reg_p2_bias_bgr_d           BIT3_0
    #define reg_p2_dpcolor_ctl          BIT6_4
    #define reg_p2_dpcolor_sw_ovr       BIT7

#define TMDS2_TERMCTRL0                     0x0988
    #define reg_term_sel_2              BIT1_0
    #define reg_term_ctl2               BIT4_2
    #define reg2_eq_bias_rstb           BIT5
    #define reg2_eq_noise_dec           BIT6
    #define reg2_pclk_en                BIT7    

#define TMDS2_PD_SYS2                       0x098c

#define PLL3_CALREFSEL                      0x09A4


#define TMDS3_CTRL4                         0x09b4
    #define reg_p3_bias_bgr_d           BIT3_0
    #define reg_p3_dpcolor_ctl          BIT6_4
    #define reg_p3_dpcolor_sw_ovr       BIT7



#define TMDS3_TERMCTRL0                     0x09b8
    #define reg_term_sel_3              BIT1_0
    #define reg_term_ctl3               BIT4_2
    #define reg3_eq_bias_rstb           BIT5
    #define reg3_eq_noise_dec           BIT6
    #define reg3_pclk_en                BIT7  

#define TMDS3_PD_SYS2                       0x09bc

#define RX_SHD_BKSV_0						0x0a00
	#define otp_bksv0					BIT7_0
	
#define RX_SHD_BKSV_1						0x0a04

#define RX_SHD_BKSV_2						0x0a08

#define RX_SHD_BKSV_3						0x0a0c

#define RX_SHD_BKSV_4						0x0a10

#define RX_HDCP_FAST_CAP                    0x0a7c
    #define p0_reg_hdmi_capable     	BIT1
    #define p1_reg_hdmi_capable     	BIT3
    #define p2_reg_hdmi_capable     	BIT5
    #define p3_reg_hdmi_capable     	BIT7

#define P0_RX_EPST							0x0b10
	#define p0_reg_bist2_err_clr		BIT6
	#define p0_reg_bist1_err_clr		BIT5
	#define otp_dn_ksv					BIT4
	#define reg_ld_ksv					BIT3
	#define p0_reg_bist_err_clr			BIT1
	#define p0_reg_cmd_done_clr			BIT0
	
#define P0_RX_EPCM							0x0b14
	#define p0_reg_epcm					BIT4_0
	
#define P1_RX_EPST							0x0b18
	#define p1_reg_bist2_err_clr		BIT6
	#define p1_reg_bist1_err_clr		BIT5
	#define p1_reg_bist_err_clr			BIT1
	#define p1_reg_cmd_done_clr			BIT0

#define P1_RX_EPCM							0x0b1c

#define CORE_SEL                            0x0b30
    #define reg_ics0_sel            	BIT1_0

#define MHL_1X_EN							0x0b34
	#define reg_mhl_1x_en				BIT0
	
#define PA_PWD_RESET_CTRL					0x0b38
	#define reg_ddc_sw_rst				BIT0
	
/**********************************PAGE 3**************************************/
#define RX_PWD_CTRL                         0x0c04
    #define reg_core_iso_en             BIT0
    #define reg_tmds_mode_inv           BIT4
    #define reg_dvi_rx_dig_bypass       BIT5
    
#define RX_PWD_SRST                         0x0c14
    #define hdcp_rst_auto           	BIT7	// no logic, no usage.
    #define acr_rst_auto            	BIT6
    #define aac_rst                 	BIT5
    #define dc_fifo_rst             	BIT4
    #define hdcp_rst                	BIT3	// no logic, no usage.
    #define acr_rst                 	BIT2
    #define fifo_rst                	BIT1
    #define aud_fifo_rst_auto       	BIT0
    
#define RX_SYS_CTRL1                        0x0c1c
    #define reg_sync_pol            	BIT1
    #define reg_pd_all              	BIT0

#define SYS_TMDS_CH_MAP                     0x0c38
    #define reg_di_ch2_sel          	BIT5_4
    #define reg_di_ch1_sel          	BIT3_2
    #define reg_di_ch0_sel          	BIT1_0
    
#define SYS_TMDS_D_IR                       0x0c3c    
    #define reg_phy_di_dff_en       	BIT6
    #define reg_di_ch2_invt         	BIT5
    #define reg_di_ch1_invt         	BIT4
    #define reg_di_ch0_invt         	BIT3
    #define reg_di_ch2_bsi          	BIT2
    #define reg_di_ch1_bsi          	BIT1
    #define reg_di_ch0_bsi          	BIT0
    
#define RX_SW_HDMI_MODE                     0x0c88
    #define reg_fix_dvihdcp         	BIT2
    #define reg_hdmi_mode_sw_value  	BIT1
    #define reg_hdmi_mode_overwrite 	BIT0
    
#define RX_PREAMBLE_CRIT                    0x0c8c
    
#define RX_HDCP_PREAMBLE_CRIT               0x0c90

#define RX_TEST_STAT						0x0cec
	#define reg_tst_xclk				BIT7
	#define reg_tst_ckdt				BIT6
	#define reg_invert_tclk				BIT5
	#define reg_byp_vid_path			BIT4
	#define reg_tst_pclk_en				BIT2
	
#define RX_INTR1                            0x0d00
    #define intr_hw_cts_changed     	BIT7
    #define intr_auth_start         	BIT1	// no logic, no usage.
    #define intr_auth_done          	BIT0	// no logic, no usage.

#define RX_INTR2                            0x0d04
    #define intr_hdmi_mode          	BIT7
    #define intr_Vsync              	BIT6
    #define intr_got_cts            	BIT2
    #define intr_new_aud_pkt        	BIT1

#define RX_INTR3                            0x0d08
    #define intr_new_avi            BIT0
    #define intr_new_spd            BIT1
    #define intr_new_aud            BIT2
    #define intr_new_mpeg           BIT3
    #define intr_cp_set_mute        BIT6

#define RX_INTR4                            0x0d0c
    #define intr_HDCP_packet_err    BIT6
    #define intr_no_avi             BIT4
    #define intr_cts_dropped_err    BIT3
    #define intr_cts_reused_err     BIT2
    #define intr_overun             BIT1
    #define intr_underun            BIT0

#define RX_INTR5                            0x0d10
    #define reg_fn_chg              BIT7
    #define intr_audio_muted        BIT6
    #define reg_audio_link_err      BIT5
    #define reg_vres_chg            BIT4
    #define reg_hres_chg            BIT3
    #define reg_pol_chg             BIT2
    #define reg_interlace_chg       BIT1
    #define intr_aud_sample_f       BIT0

#define RX_INTR6                            0x0d14
    #define intr_dc_packet_err      BIT7
    #define intr_chst_ready         BIT5
    #define intr_hbra_on            BIT4
    #define intr_new_acp            BIT2
    #define intr_dsd_on             BIT1

#define RX_INTR7							0x0d18

#define RX_INTR8    						0x0d1c

#define RX_INTR1_MASK                       0x0d40
    
#define RX_INTR2_MASK                       0x0d44
    
#define RX_INTR3_MASK                       0x0d48
    
#define RX_INTR4_MASK                       0x0d4c
    
#define RX_INTR5_MASK                       0x0d50
    
    
#define RX_INTR6_MASK                       0x0d54

#define RX_INTR8_MASK                       0x0d5c
    #define reg_intr8_mask4         BIT4



#define RX_SHD_BSTATUS1                     0x0e7c

#define RX_HDCP_DEBUG                       0x0e84
    #define stop_en                     BIT7



/**********************************PAGE 4**************************************/
#define RX_ECC_CTRL                         0x1000
    #define reg_ignore_ecc_err_pkt_en   BIT1
    #define reg_capture_cnt         	BIT0

#define RX_BCH_THRES                        0x1004
    #define reg_bch_thresh          	BIT4_0

#define RX_HDCP_THRES                       0x1028
    
#define RX_HDCP_THRES2                      0x102c

#define RX_BCH_ERR                          0x1040

#define RX_BCH_ERR2                         0x1044

#define RX_HDCP_ERR                         0x1048

#define RX_HDCP_ERR2                        0x104c

#define RX_INT_IF_CTRL                      0x1080
    #define reg_use_aif4vsi         	BIT7
    #define reg_new_vsi_only        	BIT6
    #define reg_new_acp_only        	BIT5
    #define reg_new_unrec_only      	BIT4
    #define reg_new_mpeg_only       	BIT3
    #define reg_new_aud_only        	BIT2
    #define reg_new_spd_only        	BIT1
    #define reg_new_avi_only        	BIT0

#define DEC_AV_MUTE                         0x1088
    #define reg_clear_av_mute       	BIT5
    #define reg_video_mute          	BIT0

#define RX_AUDP_STAT                        0x10d0
    #define hdmi_hbra_on            	BIT6
    #define hdmi_aud_dsd_on         	BIT5
    #define hdmi_layout             	BIT4_3
    #define hdmi_mute               	BIT2
    #define hdmi_mode_en            	BIT1
    #define hdmi_mode_det           	BIT0

#define RX_AVIRX_TYPE                       0x1100

#define RX_SPDRX_TYPE                       0x1180

#define RX_SPD_DEC                          0x11fc

#define RX_AUDRX_TYPE                       0x1200

#define RX_MPEGRX_TYPE                      0x1280

#define RX_MPEG_DEC                         0x12fc

#define RX_ACP_BYTE1                        0x1380

#define RX_ACP_DEC                          0x13fc

/**********************************PAGE 5**************************************/
#define PAUTH_CTRL                          0x14e8
    #define reg_pauth_mp_swap           BIT7
    #define reg_pauth_hpd_con_en        BIT6
    #define reg_pauth_skip_unAKSVport   BIT5
    #define reg_pauth_use_av_mute       BIT4
    #define reg_ignore_pa_hpd           BIT3
    #define reg_pauth_ssc_fifo_err_rcv  BIT2
    #define reg_pauth_skip_non_hdcp     BIT1
    #define reg_pauth_prt_ch_enable     BIT0
    
#define PAUTH_STAT0                         0x14ec
    #define ro_rp_psel                  BIT7_4
    #define ro_mp_psel                  BIT3_0
    
#define PAUTH_STAT1                         0x14f0
    #define ro_p3_hdcp_decrypting_on    BIT7
    #define ro_p2_hdcp_decrypting_on    BIT6
    #define ro_p1_hdcp_decrypting_on    BIT5
    #define ro_p0_hdcp_decrypting_on    BIT4
    #define ro_p3_hdcp_authenticated    BIT3
    #define ro_p2_hdcp_authenticated    BIT2
    #define ro_p1_hdcp_authenticated    BIT1
    #define ro_p0_hdcp_authenticated    BIT0

#define PAUTH_STAT2                         0x14f4
    #define p3_dmatch_done          	BIT7
    #define p2_dmatch_done          	BIT6
    #define p1_dmatch_done          	BIT5
    #define p0_dmatch_done          	BIT4
    #define ro_p3_hdcp_auth_done    	BIT3
    #define ro_p2_hdcp_auth_done    	BIT2
    #define ro_p1_hdcp_auth_done    	BIT1
    #define ro_p0_hdcp_auth_done    	BIT0
    
#define PAUTH_MPOVR                      	0x14f8
    #define reg_pauth_mport_ovr     	BIT3_0
    #define reg_pauth_mport_ovr2    	BIT5_4
    #define reg_pauth_main_ovr      	BIT7

#define PAUTH_RSTLEN0						0x1500

#define PAUTH_RSTLEN1						0x1504

#define PAUTH_RSTLEN2						0x1508

#define PAUTH_RSTLEN3						0x150c

#define PAUTH_ECC_CTRL                      0x155c
    #define reg_pauth_cnt2chk_ecc_err_8 BIT0
    #define reg_pauth_ecc_err_chk_en    BIT4
    #define reg_pauth_ecc2hpd_en        BIT5

#define PAUTH_ECC_CHKTIME                   0x1560
    #define reg_pauth_cnt2chk_ecc_err   BIT7_0
#define PAUTH_INV_CTRL                   	0x1564
    #define reg_pauth_tx_bit_inv    	BIT7
    #define reg_pauth_use_inv_clk   	BIT6_0
    
#define PAUTH_MP_AOVR                    	0x1568
    #define reg_pauth_mport_aovr    	BIT5_0
    #define reg_pauth_use_inv_clk2  	BIT7

#define PAUTH_MP_DLY_STAT					0x1570
	#define ro_rp_dly_val				BIT7_4
	#define ro_mp_dly_val				BIT3_0

#define PAUTH_P1_DLY_STAT					0x1578

#define PAUTH_ECC_THRES0                    0x1584
    #define reg_pauth_ecc_err_thr7_0    BIT7_0
    
#define PAUTH_MISC_CTRL0                    0x158c
    #define reg_ri_ecc_clr              BIT0
    #define reg_pauth_recov_en          BIT6

#define PAUTH_MISC_CTRL1                    0x1590
    #define reg_pauth_ecc_auto_video_mute BIT0
    #define reg_pauth_ecc_auto_audio_mute BIT1
    #define reg_pauth_wide_vs_phase     BIT2
    #define ri_use_ckdt_in_good         BIT6
    #define ri_irst_n                   BIT7

#define PAUTH_FRAME_ECC_THR                 0x1594
    #define reg_pauth_frame_ecc_thr     BIT5_0
    
#define PAUTH_HDMI_CLR                      0x15bc
    #define ri_hdmi_mode_en_itself_clr  BIT0
    #define ri_clr_only_at_pwr          BIT1
    #define ri_extend_int_cnt           BIT2
    #define ri_no_ctl3_ecc_off          BIT3
    #define ri_fix_dvihdcp              BIT4
    #define ri_clr_both_ri              BIT5
    #define ri_ecc_cnt_go_on            BIT6
#define PA_CONF_REG_8						0x15f0
	#define ri_rd_port_sel				BIT2_0

#define PA_CONF_REG_42                      0x1678
    #define ri_mp_use_auto_ecc_chk_on   BIT6
    #define ri_rp_use_auto_ecc_chk_on   BIT7
    
#define PA_CONF_REG_46                      0x1688
    #define ri_rp_ecc_err_chk_en        BIT1
#define PA_STAT_REG_27                      0x17a4
    #define ro_rp_sz_h_act7_0       	BIT7_0
    
#define PA_STAT_REG_28                      0x17a8
    #define ro_rp_sz_h_act12_8      	BIT4_0
    
#define PA_STAT_REG_29                      0x17ac
    #define ro_rp_sz_h_blk7_0       	BIT7_0
    
#define PA_STAT_REG_30                      0x17b0
    #define ro_rp_sz_h_blk11_8      	BIT3_0
    
#define PA_STAT_REG_31                      0x17b4
    #define ro_rp_sz_v_act7_0       	BIT7_0
    
#define PA_STAT_REG_32                      0x17b8    
    #define ro_rp_sz_v_act11_8      	BIT3_0
    
#define PA_STAT_REG_33                      0x17bc
    #define ro_rp_sz_v_blk7_0       	BIT7_0
    
#define PA_STAT_REG_34                      0x17c0
    #define hdmi_rp_scdt            	BIT7
    #define ro_rp_cp_new_cp         	BIT4
    #define ro_rp_cp_clr_mute       	BIT3
    #define ro_rp_cp_set_mute       	BIT2
    #define ro_rp_field             	BIT1
    #define ro_rp_intlaced          	BIT0

#define PA_STAT_REG_35                      0x17c4
    #define ro_rp_color_depth       	BIT3_0
/**********************************PAGE 6**************************************/
#define pauth_dck_fifo						0x1990
	#define ri_dly_chg_intr_clrb		BIT4
	#define ri_rst_n_dckfifo			BIT0
	
#define PAUTH_RSTDIFFOFF0					0x19b4

#define PAUTH_RSTDIFFOFF1					0x19b8

#define PAUTH_RSTDIFFOFF2					0x19bc

#define PAUTH_RSTDIFFOFF3					0x19c0

#define pauth_mhl_config1                   0x19fc
    #define ri_use_new_mhl          	BIT7
    #define ri_rp_m1080p_det_en     	BIT6
    #define ri_mp_m1080p_det_en     	BIT5
    #define ri_bch_code_en          	BIT4
    #define ri_prmbl_thrshld        	BIT3_0

#define Alice1_eq_data0                     0x1A18
    
#define Alice1_eq_data1                     0X1A1C
    
#define Alice1_eq_data2                     0X1A20
    
#define Alice1_eq_data3                     0X1A24
    
#define Alice1_eq_data4                     0X1A28
    
#define Alice1_eq_data5                     0X1A2C
    
#define Alice1_eq_data6                     0X1A30
    
#define Alice1_eq_data7                     0X1A34
   
#define Alice0_eq_data0                     0x1A90

#define Alice0_eq_data1                     0x1A94

#define Alice0_eq_data2                     0x1A98

#define Alice0_eq_data3                     0x1A9C

#define Alice0_eq_data4                     0x1AA0

#define Alice0_eq_data5                     0x1AA4

#define Alice0_eq_data6                     0x1AA8

#define Alice0_eq_data7                     0x1AAC

#define Alice0_cntl1                        0x1ACC
    #define reg_tmds0_ev_sel            BIT0     
    #define reg_tmds0_ext_eq            BIT1    
    #define reg_tmds0_bv_sel            BIT2
    #define reg_tmds0_ext_bw            BIT3
    #define reg_tmds0_dpll_bw_scan_on   BIT6

#define DPLL_MULTZONE_CTRL                  0x1B04
    #define reg_dpll_use_scdt           BIT0
    #define ri_vcocal_in                BIT7_4

#define TMDST_TXDAT1                        0x1B14
    #define reg_txdata9_8               BIT1_0
    #define ri_vcocal_def_mhl1x         BIT7_4

#define mhl1x_eq_data0                      0x1B1C

#define mhl1x_eq_data1                      0x1B20

#define mhl1x_eq_data2                      0x1B24

#define mhl1x_eq_data3                      0x1B28

#define pauth_num_smps                      0x1B40
    #define reg_pauth_num_smps          BIT2_0
    #define reg_pauth_use_chg_auto_clr  BIT3
    #define reg_pauth_use_chg           BIT6_4
    #define ri_mhl1x_eq_en              BIT7

#define pauth_add_config4                   0x1bac
    #define preauth_pll_bias_on     	BIT7
    #define preauth_rp_hdmi_mode_sw_value   BIT6
    #define preauth_mp_hdmi_mode_sw_value   BIT5
    #define preauth_rp_hdmi_mode_overwrite  BIT4	
    #define preauth_mp_hdmi_mode_overwrite  BIT3
    #define preauth_rp_byp_dvifilt_sync     BIT2
    #define preauth_mp_byp_dvifilt_sync     BIT1
    #define preauth_down2cheap_chip         BIT0
	
/**********************************PAGE 8**************************************/	
#define CEC_DEBUG_3                     	0x221c
    #define reg_cec_flush_tx_ff     	BIT7
	#define cec_ctl_retry_cnt			BIT6_4
	
#define CEC_TX_INIT                     	0x2220
    #define reg_cec_init_id         	BIT3_0

#define CEC_TX_DEST                     	0x2224
    #define reg_cec_sd_poll         	BIT7
    #define reg_cec_dest_id         	BIT3_0

#define CEC_CONFIG_CPI                  	0x2238
	
#define CEC_TX_COMMAND                  	0x223c
	
#define CEC_TX_OPERAND_0                	0x2240

#define CEC_CAPTURE_ID0                 	0x2288



#define CEC_TRANSMIT_DATA               	0x227c
    #define reg_transmit_cec_cmd    	BIT4
    #define reg_cec_tx_cmd_cnt      	BIT3_0

#define CEC_INT_ENABLE_0                	0x2290
    #define BIT_RX_MSG_RECEIVED     	BIT1
    #define BIT_TX_FIFO_EMPTY       	BIT2
    #define BIT_TX_MESSAGE_SENT     	BIT5
	
#define CEC_INT_ENABLE_1                	0x2294
    #define BIT_FRAME_RETRANSM_OV   	BIT1
    #define BIT_SHORT_PULSE_DET     	BIT2

#define CEC_INT_STATUS_0                	0x2298
    #define rx_command_received     	BIT0
    #define rx_fifo_not_empty       	BIT1
    #define tx_fifo_empty           	BIT2
    #define tx_transmit_buffer_change   BIT5
    #define tx_transmit_buffer_full 	BIT6

#define CEC_INT_STATUS_1                	0x229c
    #define rx_start_bit_irregular  	BIT0
    #define tx_frame_retx_count_exceed  BIT1
    #define rx_short_pulse_detected 	BIT2
    #define rx_fifo_overrun_error   	BIT3

#define CEC_RX_CONTROL                  	0x22b0
    #define reg_cec_rx_clr_all      	BIT1

#define CEC_RX_COUNT                    	0x22b4
    #define cec_reg_rx_cmd_byte_cnt 	BIT3_0
    #define cec_reg_rx_ff_wr_sel    	BIT5_4
    #define cec_rx_error            	BIT7

#define CEC_RX_CMD_HEADER               	0x22b8
    #define CEC_RX_DEST             	BIT3_0
    #define CEC_RX_INIT             	BIT7_4

#define CEC_RX_COMMAND                  	0x22bc

#define CEC_RX_OPERAND_0                	0x22c0

#define CEC_OP_ABORT_0						0x2300

#define CEC_OP_ABORT_31						0x237c

#define RX_HDMIM_CP_CTRL					0x2748
	#define reg_hdmim_port_disable		BIT4
	#define reg_force_hdmim_mode0		BIT0

#define RX_CBUS_CH_RST_CTRL                 0x2794 
    #define reg_mhl_disc_sw_rst         BIT6
    
#define RX_RSEN_CTRL                        0x27D8
    #define NVRAM_mhl_hpd_en            BIT7
/**********************************PAGE 10**************************************/    
#define RX_H_RESL                           0x28e8

#define RX_H_RESH                           0x28ec

#define RX_V_RESL                           0x28f0

#define RX_V_RESH                           0x28f4

#define RX_VID_CTRL                         0x2920
    #define reg_invertVsync         BIT7
    #define reg_invertHsync         BIT6
    #define reg_YCbCr2RGBMode       BIT2
    #define reg_ExtBitMode          BIT1
    #define reg_RGB2YCbCrMode       BIT0

#define RX_VID_MODE2                        0x2924
    #define reg_dither_mode         BIT7_6
    #define reg_even_polarity       BIT5
    #define reg_enycbcr2rgbrange    BIT3
    #define reg_enycbcr2rgb         BIT2
    #define reg_clipinputisyc       BIT1
    #define reg_enrangeclip         BIT0

#define RX_VID_MODE                         0x2928
    #define reg_EnSyncCodes         BIT7
    #define reg_EnMuxYC             BIT6
    #define reg_EnDither            BIT5
    #define reg_EnRGB2YCbCrRange    BIT4
    #define reg_EnRGB2YCbCr         BIT3
    #define reg_EnUpSample          BIT2
    #define reg_EnDownSample        BIT1

#define RX_VID_BLANK1                       0x292c
    
#define RX_VID_BLANK2                       0x2930
    
#define RX_VID_BLANK3                       0x2934

#define RX_DE_PIX1							0x2938

#define RX_DE_PIX2							0x293c
	#define vid_DEPixels12_8		BIT4_0

#define RX_DE_LINE1							0x2940

#define RX_DE_LINE2							0x2944
	#define vid_DELines12_8			BIT4_0
	
#define RX_VID_F2BPM                        0x2950
    #define reg_Field2Backporch     BIT0
    
#define RX_VID_STAT                         0x2954
    #define InterlacedOut           BIT2
    #define VsyncPol                BIT1
    #define HsyncPol                BIT0

#define RX_VID_CH_MAP						0x2958
	#define reg_channel_map			BIT2_0
	
#define RX_VID_CTRL2                        0x295c
    #define reg_avc_en              BIT4
    #define reg_avc_fix             BIT3
    #define reg_hsync_jitter_en     BIT0

#define RX_VID_AOF                          0x297c

#define RX_DC_STAT                          0x2984
    #define reg_pixelDepth          BIT1_0

#define RX_TMDS_CCTRL2                      0x2a04
    #define reg_offset_coen         BIT5
    #define reg_dc_ctl_ow           BIT4
    #define reg_dc_ctl              BIT3_0

#define RX_VID_CTRL3						0x2aec
	#define reg_q_toggle_en			BIT3
	#define reg_byp_mode_cntl		BIT2_1
	#define reg_s260m_sel			BIT0
#define RX_VID_CTRL4                        0x2af0
    #define reg_oclkdiv             BIT7_6
    #define reg_iclk                BIT5_4
    #define reg_bsel                BIT2
    #define reg_edge                BIT1
	
/**********************************PAGE 11**************************************/	
#define EDID_START                      	0x2c00
	
#define EDID_END                        	0x2ffc

#define IF_CTRL2                            0x3424
    #define reg_gcp_clr_en          BIT0
	
/**********************************PAGE 12**************************************/
#define MHL_DEVCAP_0						0x3000

#define MHL_DEVCAP_1						0x3004

#define MHL_DEVCAP_2						0x3008

#define MHL_DEVCAP_3						0x300c

#define MHL_DEVCAP_4						0x3010

#define MHL_DEVCAP_5						0x3014

#define MHL_DEVCAP_6						0x3018

#define MHL_DEVCAP_7						0x301c

#define MHL_DEVCAP_8						0x3020

#define MHL_DEVCAP_9						0x3024

#define MHL_DEVCAP_A						0x3028

#define MHL_DEVCAP_B						0x302c

#define MHL_DEVCAP_C						0x3030

#define MHL_DEVCAP_D						0x3034

#define MHL_DEVCAP_E						0x3038

#define MHL_DEVCAP_F						0x303c

#define MHL_INT_0							0x3080

#define MHL_STAT_0							0x30c0

#define MHL_STAT_1							0x30c4

#define MHL_SCRPAD_0						0x3100
	#define reg_mhl_scrpad_0			BIT7_0
	
#define CBUS_STATUS							0x3244
	#define reg_cbus_connected			BIT0
	#define reg_mhl_cable_present		BIT4
	
#define CBUS_INT_0							0x3248
	#define msc_mt_done_nack			BIT7
	#define set_int						BIT6
	#define msc_mr_write_burst			BIT5
	#define msc_mr_msc_msg				BIT4
	#define msc_mr_write_stat			BIT3
	#define cbus_hpd_rcvd				BIT2
	#define msc_mt_done					BIT1
	#define cbus_cnx_chg				BIT0

#define CBUS_INT_0_MASK						0x324c

#define CBUS_INT_1							0x3250
	#define mhl_cable_cnx_chg			BIT7
	#define msc_mt_abrt					BIT6
	#define cbus_rcvd_valid				BIT5
	#define msc_mr_cec_capture_id		BIT4
	#define msc_mr_abrt					BIT3
	#define ddc_abrt					BIT2
	#define cec_abrt					BIT1
	#define msc_hb_max_fail				BIT0

#define CBUS_INT_1_MASK						0x3254

#define CEC_ABORT_INT						0x3258

#define DDC_ABORT_INT						0x3260

#define MSC_MT_ABORT_INT					0x3268

#define MSC_MR_ABORT_INT					0x3270

#define MSC_COMMAND_START					0x32e0
	#define reg_msc_debug_cmd			BIT5
	#define reg_msc_write_burst_cmd		BIT4
	#define reg_msc_write_stat_cmd		BIT3
	#define reg_msc_read_devcap_cmd		BIT2
	#define reg_msc_msc_msg_cmd			BIT1
	#define reg_msc_peer_cmd			BIT0
		
#define MSC_CMD_OR_OFFSET					0x32e4
	
#define MSC_1ST_TRANSMIT_DATA				0x32e8
	
#define MSC_2ND_TRANSMIT_DATA				0x32ec

#define MSC_MT_RCVD_DATA0					0x32f0

#define MSC_MT_RCVD_DATA1					0x32f4

#define MSC_MR_MSC_MSG_RCVD_1ST_DATA		0x32fc

#define MSC_MR_MSC_MSG_RCVD_2ND_DATA		0x3300

#define MSC_WRITE_BURST_DATA_LEN			0x3318
	#define reg_msc_write_burst_len		BIT3_0

#ifdef __cplusplus
 #if __cplusplus
		}
 #endif
#endif /* __cplusplus */
		
#endif  /* __HAL_HDMIRX_REG_H__ */

