//******************************************************************************
//  Copyright (C), 2007-2014, Hisilicon Technologies Co., Ltd.
//
//******************************************************************************
// File name     : hal_hdmirx_reg.h
// Version       : 2.0
// Author        : xxx
// Created       : 2012-07-30
// Last Modified : 
// Description   :  The C union definition file for the module TVD_V100
// Function List : 
// History       : 
// 1 Date        : 2014-06-14
// Author        : l00214567
// Modification  : Create file
//******************************************************************************

#ifndef __HAL_HDMIRX_REG_H__
#define __HAL_HDMIRX_REG_H__



#define BIT0    0x01
#define BIT1    0x02
#define BIT2    0x04
#define BIT3    0x08
#define BIT4    0x10
#define BIT5    0x20
#define BIT6    0x40
#define BIT7    0x80

#define RX_DEV_IDH                      0x000C

#define RX_DEV_IDL                      0x0008

#define RX_DEV_REV                      0x0010

#define RX_AON_SRST                     0x0014
    #define reg_sw_rst_auto         BIT4
    #define reg_sw_rst              BIT0 
    
#define RX_SYS_SWTCHC                   0x0024
    #define reg_ddc_sda_in_del_en   BIT7
    #define reg_ddc_sda_out_del_en  BIT5
    #define reg_ddc_en              BIT4
    #define ddc_filter_sel          (BIT3|BIT2)

#define RX_C0_SRST2                     0x002c
    #define reg_cec_sw_rst          BIT6
    #define reg_hdmim_sw_rst        BIT4
    
#define RX_STATE_AON                    0x0030
    #define hdmi_tx_connected       BIT3
    #define ckdt                    BIT1
    #define scdt                    BIT0
    
#define RX_DUMMY_CONFIG1                0x0060

#define RX_INTR_STATE                   0x01c0
    #define reg_intr                BIT0
    
#define RX_INTR2_AON                    0x0200
    #define intr_soft_intr_en       BIT5
    #define intr_ckdt               BIT4
    #define intr_scdt               BIT3

#define RX_INTR6_AON                    0x0204
    #define intr_unplug             BIT0

#define RX_INTR7_AON                    0x0208
    #define cec_interrupt           BIT4
    
#define RX_INTR8_AON                    0x020c
    #define intr_cable_in           BIT1

#define RX_INTR2_MASK_AON               0x0240

#define RX_INTR6_MASK_AON               0x0244

#define RX_INTR7_MASK_AON               0x0248

#define RX_INTR8_MASK_AON               0x024c
    
#define RX_ACR_CTRL1                    0x0400
    #define reg_cts_dropped_auto_en BIT7
    #define reg_post_hw_sw_sel      BIT6
    #define reg_upll_hw_sw_sel      BIT5
    #define reg_cts_hw_sw_sel       BIT4
    #define reg_n_hw_sw_sel         BIT3
    #define reg_cts_reused_auto_en  BIT2
    #define reg_fs_hw_sw_sel        BIT1
    #define reg_acr_init            BIT0

#define AAC_MCLK_SEL                    0x0404
    #define reg_vcnt_max            (BIT7|BIT6)
    #define reg_mclk4dac            (BIT5|BIT4)
    #define reg_mclk4hbra           (BIT3|BIT2)
    #define reg_mclk4dsd            (BIT1|BIT0)

#define RX_FREQ_SVAL                    0x0408
    #define reg_fm_in_val_sw        (BIT7|BIT6)
    #define reg_fm_val_sw           (BIT5|BIT4)
    #define reg_fs_val_sw           (BIT3|BIT2|BIT1|BIT0)

#define RX_N_HVAL1                      0x0418

#define RX_N_HVAL2                      0x041c

#define RX_N_HVAL3                      0x0420

#define RX_CTS_HVAL1                    0x0430

#define RX_CTS_HVAL2                    0x0434

#define RX_CTS_HVAL3                    0x0438

#define RX_POST_SVAL                    0x0444
    #define reg_post_val_sw         (BIT5|BIT4|BIT3|BIT2|BIT1|BIT0)

#define RX_LK_WIN_SVAL                  0x044c

#define RX_LK_THRS_SVAL1                0x0450

#define RX_LK_THRS_SVAL2                0x0454

#define RX_LK_THRS_SVAL3                0x0458

#define RX_TCLK_FS                      0x045c
    #define rhdmi_aud_sample_f_extn BIT7|BIT6
    #define reg_fs_filter_en        BIT4
    #define rhdmi_aud_sample_f      (BIT3|BIT2|BIT1|BIT0)    

#define RX_ACR_CTRL3                    0x0460
    #define reg_cts_thresh          0x78
    #define reg_mclk_loopback       BIT2
    #define reg_log_win_ena         BIT1
    #define reg_post_div2_ena       BIT0
    
#define RX_I2S_CTRL1                    0x0498
    #define reg_invalid_en          BIT7
    #define reg_clk_edge            BIT6
    #define reg_size                BIT5
    #define reg_msb                 BIT4
    #define reg_ws                  BIT3
    #define reg_justify             BIT2
    #define reg_data_dir            BIT1
    #define reg_1st_bit             BIT0

#define RX_I2S_CTRL2                    0x049c
    #define reg_sd3_en              BIT7
    #define reg_sd2_en              BIT6
    #define reg_sd1_en              BIT5
    #define reg_sd0_en              BIT4
    #define reg_mclk_en             BIT3
    #define reg_mute_flat           BIT2
    #define reg_vucp                BIT1
    #define reg_pcm                 BIT0

#define RX_I2S_MAP                      0x04a0
    #define reg_sd0_map             BIT1|BIT0
    #define reg_sd1_map             BIT3|BIT2
    #define reg_sd2_map             BIT5|BIT4
    #define reg_sd3_map             BIT7|BIT6
    
#define RX_AUDRX_CTRL                   0x04a4    
    #define reg_i2s_length_en       0x80
    #define reg_inv_cor_en          BIT6
    #define reg_hw_mute_en          BIT5
    #define reg_pass_spdif_err      BIT4
    #define reg_pass_aud_err        BIT3
    #define reg_i2s_mode            BIT2
    #define reg_spdif_mode          BIT1
    #define reg_spdif_en            BIT0

#define RX_CHST1                        0x04a8

#define RX_CHST4                        0x04c0
    #define CHST4_SAMPLE_F		    (BIT0|BIT1|BIT2|BIT3)
    
#define RX_SW_OW                        0x04b8
    #define reg_swap                (BIT7|BIT6|BIT5|BIT4)
    #define reg_cs_bit2             BIT2
    #define reg_dsd_on_i2s          BIT1
    #define reg_ow_en               BIT0

#define RX_AUDP_MUTE                    0x04dc
    #define aac_audio_mute          BIT4
    #define reg_mute_out_pol        BIT2
    #define reg_audio_mute          BIT1
    
#define RX_VID_XPCNT3                   0x059c
    
#define RX_VID_XPCNT1                   0x05b8

#define RX_VID_XPCNT2                   0x05bc

#define VID_XPCLK_Base                  0x05a4

#define VID_XPCLK_EN                    0x05a8
    #define reg_vid_xclkpclk_en     BIT0
    
#define RX_APLL_POLE                    0x0620

#define RX_APLL_CLIP                    0x0624

#define AEC3_CTRL                       0x06c8
    #define AAC_UNMUTE_NEW_AUDIO    BIT1
    #define AAC_UNMUTE_CTS          BIT0

#define AEC2_CTRL                       0x06cc
    #define AAC_UNMUTE_GOT_FIFO_OVER    BIT3
    #define AAC_UNMUTE_GOT_FIFO_UNDER   BIT2
    #define AAC_UNMUTE_GOT_HDMI         BIT0

#define AEC1_CTRL                       0x06d0

#define AEC0_CTRL                       0x06d4
    #define reg_ctrl_acr_en         BIT7
    #define reg_aac_exp_sel         BIT6
    #define reg_aac_out_off_en      BIT5
    #define aud_div_min             BIT4
    #define aac_mute_stat           BIT3
    #define reg_aac_all             BIT1
    #define reg_aac_en              BIT0
    
#define RX_AEC_EN1                      0x06D8
    #define BIT_CKDT_DETECT         BIT7
    #define BIT_SYNC_DETECT         BIT6
    #define BIT_CABLE_UNPLUG        BIT0
    
#define RX_AEC_EN2                      0x06DC
    #define BIT_H_RES_CHANGED       BIT7
    #define BIT_FS_CHANGED          BIT4
    #define BIT_AUDIO_FIFO_OVERRUN  BIT2
    #define BIT_AUDIO_FIFO_UNDERUN  BIT1
    #define BIT_HDMI_MODE_CHANGED   BIT0

#define RX_AEC_EN3                      0x06e0
    #define BIT_V_RES_CHANGED       BIT0
    
#define RX_PWD_SRST                     0x0c14
    #define hdcp_rst_auto           BIT7
    #define acr_rst_auto            BIT6
    #define aac_rst                 BIT5
    #define dc_fifo_rst             BIT4
    #define hdcp_rst                BIT3
    #define acr_rst                 BIT2
    #define fifo_rst                BIT1
    #define aud_fifo_rst_auto       BIT0
    
#define RX_SYS_CTRL1                    0x0c1c
    #define reg_sync_pol            BIT1
    #define reg_pd_all              BIT0
    
#define SYS_TMDS_D_IR                   0x0c3c
    #define reg_phy_di_dff_en       BIT6
    #define reg_di_ch2_invt         BIT5
    #define reg_di_ch1_invt         BIT4
    #define reg_di_ch0_invt         BIT3
    #define reg_di_ch2_bsi          BIT2
    #define reg_di_ch1_bsi          BIT1
    #define reg_di_ch0_bsi          BIT0
    
#define RX_RPT_RDY_CTRL                 0x0c40
    #define reg_fifordy_clr_en       (BIT0|BIT1|BIT2)
    #define reg_hdmi_mode_clr_en      BIT3
    
#define RX_SW_HDMI_MODE                 0x0c88
    #define reg_fix_dvihdcp         BIT2
    
#define RX_PREAMBLE_CRIT                0x0c8c

#define RX_HDCP_PREAMBLE_CRIT           0x0c90

#define RX_TEST_STAT                    0x0cec
    #define reg_invert_tclk         BIT5

#define RX_PD_SYS2                      0x0cf8
    #define reg_pd_pclk             BIT7
    #define reg_pd_mclk             BIT6

#define RX_INTR1                        0x0d00
    #define intr_hw_cts_changed     BIT7
    #define intr_auth_start         BIT1
    #define intr_auth_done          BIT0
    
#define RX_INTR2                        0x0d04
    #define intr_hdmi_mode          BIT7
    #define intr_Vsync              BIT6
    #define intr_got_cts            BIT2
    #define intr_new_aud_pkt        BIT1
    #define video_clock_change      BIT0

#define RX_INTR3                        0x0d08
    #define intr_new_avi            BIT0
    #define intr_new_spd            BIT1
    #define intr_new_aud            BIT2
    #define intr_new_mpeg           BIT3
    #define intr_cp_set_mute        BIT6
    
#define RX_INTR4                        0x0d0c
    #define intr_HDCP_packet_err    BIT6
    #define intr_no_avi             BIT4
    #define intr_cts_dropped_err    BIT3
    #define intr_cts_reused_err     BIT2
    #define intr_overun             BIT1
    #define intr_underun            BIT0

#define RX_INTR5                        0x0d10
    #define reg_fn_chg              BIT7
    #define intr_audio_muted        BIT6
    #define reg_audio_link_err      BIT5
    #define reg_vres_chg            BIT4
    #define reg_hres_chg            BIT3
    #define reg_pol_chg             BIT2
    #define reg_interlace_chg       BIT1
    #define intr_aud_sample_f       BIT0

#define RX_INTR6                        0x0d14
    #define intr_dc_packet_err      BIT7
    #define intr_chst_ready         BIT5
    #define intr_hbra_on            BIT4
    #define intr_new_acp            BIT2
    #define intr_dsd_on             BIT1
    
#define RX_INTR7                        0x0d18

#define RX_INTR8                        0x0d1c

#define RX_INTR9                        0x0d20

#define RX_INTR10                       0x0d24

#define RX_INTR1_MASK                   0x0d40

#define RX_INTR2_MASK                   0x0d44

#define RX_INTR3_MASK                   0x0d48

#define RX_INTR4_MASK                   0x0d4c

#define RX_INTR5_MASK                   0x0d50


#define RX_INTR6_MASK                   0x0d54

#define RX_INTR8_MASK                   0x0d5c
    #define reg_intr8_mask4         BIT4

#define RX_SHD_BKSV_1                   0x0e28

#define RX_SHD_AKSV1                    0x0e44

#define RX_SHD_AN1                      0x0e58

#define RX_BCAPS_SET                    0x0e78
    #define reg_hdmi_capable        BIT7
    #define reg_repeater            BIT6
    #define reg_fifo_rdy            BIT5
    #define reg_fast                BIT4

#define RX_SHD_BSTATUS1                 0x0e7c

#define RX_HDCP_DEBUG                   0x0e84
    #define stop_en                 BIT7

#define RX_HDCP_STAT                    0x0e88
    #define hdcp_decrypting         BIT5
    #define hdcp_authenticated      BIT4
    
#define RX_EPST                         0x0fe4
    #define reg_ld_ksv_clr          BIT4
    
#define RX_EPCM                         0x0fe8
    #define reg_ld_ksv              BIT5
    
#define RX_ECC_CTRL                     0x1000
    #define reg_ignore_ecc_err_pkt_en   BIT1
    #define reg_capture_cnt         BIT0
    
#define RX_BCH_THRES                    0x1004
    #define reg_bch_thresh          (BIT0|BIT1|BIT2|BIT3|BIT4)

#define RX_HDCP_THRES                   0x1028

#define RX_HDCP_THRES2                  0x102c

#define RX_HDCP_ERR                     0x1048

#define RX_HDCP_ERR2                    0x104c

#define RX_INT_IF_CTRL                  0x1080
    #define reg_use_aif4vsi         BIT7
    #define reg_new_vsi_only        BIT6
    #define reg_new_acp_only        BIT5
    #define reg_new_unrec_only      BIT4
    #define reg_new_mpeg_only       BIT3
    #define reg_new_aud_only        BIT2
    #define reg_new_spd_only        BIT1
    #define reg_new_avi_only        BIT0

#define DEC_AV_MUTE                     0x1088
    #define reg_clear_av_mute       BIT5
    #define reg_video_mute          BIT0

#define RX_AUDP_STAT                    0x10d0
    #define hdmi_hbra_on            BIT6
    #define hdmi_aud_dsd_on         BIT5
    #define hdmi_layout             BIT4|BIT3
    #define hdmi_mute               BIT2
    #define hdmi_mode_en            BIT1
    #define hdmi_mode_det           BIT0

#define AVIRX_TYPE                      0x1100

#define SPDRX_TYPE                      0x1180

#define SPD_DEC                         0x11fc

#define AUDRX_TYPE                      0x1200

#define MPEGRX_TYPE                     0x1280

#define MPEG_DEC                        0x12fc

#define RX_ACP_BYTE1                    0x1380
    
#define RX_ACP_DEC                      0x13fc

#define CEC_DEBUG_3                     0x221c
    #define reg_cec_flush_tx_ff     BIT7
    
#define CEC_TX_INIT                     0x2220
    #define reg_cec_init_id         BIT0|BIT1|BIT2|BIT3

#define CEC_TX_DEST                     0x2224
    #define reg_cec_sd_poll         BIT7
    #define reg_cec_dest_id         (BIT3|BIT2|BIT1|BIT0)

#define CEC_CONFIG_CPI                  0x2238

#define CEC_TX_COMMAND                  0x223c

#define CEC_TX_OPERAND_0                0x2240

#define CEC_TRANSMIT_DATA               0x227c
    #define reg_transmit_cec_cmd    BIT4
    #define reg_cec_tx_cmd_cnt      (BIT3|BIT2|BIT1|BIT0)
    
#define CEC_CAPTURE_ID0                 0x2288

#define CEC_INT_ENABLE_0                0x2290
    #define BIT_RX_MSG_RECEIVED     BIT1
    #define BIT_TX_FIFO_EMPTY       BIT2
    #define BIT_TX_MESSAGE_SENT     BIT5

#define CEC_INT_ENABLE_1                0x2294
    #define BIT_FRAME_RETRANSM_OV   BIT1
    #define BIT_SHORT_PULSE_DET     BIT2

#define CEC_INT_STATUS_0                0x2298
    #define rx_command_received     BIT0
    #define rx_fifo_not_empty       BIT1
    #define tx_fifo_empty           BIT2
    #define tx_transmit_buffer_change   BIT5
    #define tx_transmit_buffer_full BIT6

#define CEC_INT_STATUS_1                0x229c
    #define rx_start_bit_irregular  BIT0
    #define tx_frame_retx_count_exceed  BIT1
    #define rx_short_pulse_detected BIT2
    #define rx_fifo_overrun_error   BIT3

#define CEC_RX_CONTROL                  0x22b0
    #define reg_cec_rx_clr_all      BIT1

#define CEC_RX_COUNT                    0x22b4
    #define cec_reg_rx_cmd_byte_cnt (BIT3|BIT2|BIT1|BIT0)
    #define cec_reg_rx_ff_wr_sel    BIT5|BIT4
    #define cec_rx_error            BIT7

#define CEC_RX_CMD_HEADER               0x22b8
    #define CEC_RX_DEST             (BIT3|BIT2|BIT1|BIT0)
    #define CEC_RX_INIT             (BIT7|BIT6|BIT5|BIT4)
    
#define CEC_RX_COMMAND                  0x22bc

#define CEC_RX_OPERAND_0                0x22c0

#define RX_HPD_C_CTRL                   0x27a4
    #define reg_hpd_c_ctrl          BIT0
    
#define RX_HPD_OEN_CTRL                 0x27a8
    #define reg_hpd_oen_ctrl        BIT0
    
#define RX_HPD_PE_CTRL                  0x27ac
    #define reg_hpd_pe_ctrl         BIT0
    
#define RX_HPD_PU_CTRL                  0x27b0
    #define reg_hpd_pu_ctrl         BIT0
    
#define RX_HPD_OVRT_CTRL                0x27b4
    #define reg_hpd_ovrt_ctrl       BIT0

#define RX_H_RESL                       0x28e8

#define RX_H_RESH                       0x28ec

#define RX_V_RESL                       0x28f0

#define RX_V_RESH                       0x28f4

#define RX_VID_CTRL                     0x2920
    #define reg_invertVsync         0x80
    #define reg_invertHsync         0x40
    #define reg_YCbCr2RGBMode       BIT2
    #define reg_ExtBitMode          BIT1
    #define reg_RGB2YCbCrMode       BIT0
    
#define RX_VID_MODE2                    0x2924
    #define reg_dither_mode         0xc0
    #define reg_even_polarity       BIT5
    #define reg_enycbcr2rgbrange    BIT3
    #define reg_enycbcr2rgb         BIT2
    #define reg_clipinputisyc       BIT1
    #define reg_enrangeclip         BIT0

#define RX_VID_MODE                     0x2928
    #define reg_EnSyncCodes         0x80
    #define reg_EnMuxYC             0x40
    #define reg_EnDither            BIT5
    #define reg_EnRGB2YCbCrRange    BIT4
    #define reg_EnRGB2YCbCr         BIT3
    #define reg_EnUpSample          BIT2
    #define reg_EnDownSample        BIT1
    
#define RX_VID_BLANK1                   0x292c

#define RX_VID_BLANK2                   0x2930

#define RX_VID_BLANK3                   0x2934

#define RX_DE_PIX1                     0x2938   /*vid_DEPixels[7:0]*/
    #define L_DEPixels              (0xFF)
#define RX_DE_PIX2                     0x293c   /*vid_DEPixels[12:8]*/
    #define H_DEPixels                  (BIT3|BIT2|BIT1|BIT0)
    
#define RX_DE_LINE1                     0x2940   /*vid_DELines[7:0]*/
    #define L_DELines               (0xFF)
#define RX_DE_LINE2                     0x2944   /*vid_DELines[12:8]*/
    #define H_DELines               (BIT3|BIT2|BIT1|BIT0)

#define RX_VID_STAT                     0x2954   
    #define HsyncPol                BIT0
    #define VsyncPol                BIT1
    #define InterlacedOut           BIT2
    
#define RX_VID_CH_MAP                   0x2958   
    #define reg_channel_map         (BIT2|BIT1|BIT0)

    
#define RX_VID_CTRL2                    0x295c
    #define reg_avc_en              BIT4
    #define reg_avc_fix             BIT3
    #define reg_hsync_jitter_en     BIT0

#define RX_VID_AOF                      0x297c

#define RX_DC_STAT                      0x2984
    #define reg_pixelDepth          (BIT1|BIT0)
    
#define RX_TMDS_CCTRL2                  0x2a04
    #define reg_offset_coen         BIT5
    #define reg_dc_ctl_ow           BIT4
    #define reg_dc_ctl              (BIT3|BIT2|BIT1|BIT0)
    
#define RX_VID_CTRL4                    0x2af0
    #define reg_oclkdiv             0xc0
    #define reg_iclk                0x30
    #define reg_bsel                BIT2
    #define reg_edge                BIT1

#define EDID_START                      0x2c00

#define EDID_END                        0x2ffc

#define IF_CTRL2                        0x3424
    #define reg_gcp_clr_en          BIT0
// Declare the struct pointor of the module HDMI_reg
//extern volatile S_HDMI_RX_REGS_TYPE *HDMI_AllReg;
#endif

