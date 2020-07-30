//******************************************************************************
// Copyright     :  Copyright (C) 2013, Hisilicon Technologies Co., Ltd.
// File name     :  hi_reg_peri.h
// Author        :
// Version       :  1.0
// Date          :  2013-11-29
// Description   :  The C union definition file for the module perictrl
// Others        :  Generated automatically by nManager V4.0
//******************************************************************************

#ifndef __HI_REG_PERI_H__
#define __HI_REG_PERI_H__

/* Define the union U_START_MODE */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    reserved_3            : 7   ; /* [6..0]  */
        unsigned int    romboot_sel_lock      : 1   ; /* [7]  */
        unsigned int    caboot_en             : 1   ; /* [8]  */
        unsigned int    boot_sel              : 2   ; /* [10..9]  */
        unsigned int    sfc_addr_mode         : 1   ; /* [11]  */
        unsigned int    nf_bootbw             : 1   ; /* [12]  */
        unsigned int    reserved_2            : 7   ; /* [19..13]  */
        unsigned int    romboot_sel           : 1   ; /* [20]  */
        unsigned int    reserved_1            : 1   ; /* [21]  */
        unsigned int    por_sel               : 1   ; /* [22]  */
        unsigned int    jtag_sel              : 1   ; /* [23]  */
        unsigned int    reserved_0            : 8   ; /* [31..24]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_START_MODE;

/* Define the union U_PERI_STAT */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    reserved_1            : 3   ; /* [2..0]  */
        unsigned int    gpu_pwractive         : 1   ; /* [3]  */
        unsigned int    reserved_0            : 28  ; /* [31..4]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PERI_STAT;

/* Define the union U_PERI_CTRL */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    sdio1_card_det_mode   : 1   ; /* [0]  */
        unsigned int    sdio0_card_det_mode   : 1   ; /* [1]  */
        unsigned int    reserved_2            : 2   ; /* [3..2]  */
        unsigned int    ssp0_cs_sel           : 1   ; /* [4]  */
        unsigned int    reserved_1            : 3   ; /* [7..5]  */
        unsigned int    net_if0_sel           : 1   ; /* [8]  */
        unsigned int    reserved_0            : 19  ; /* [27..9]  */
        unsigned int    clk_mhlnx_sel         : 1   ; /* [28]  */
        unsigned int    peri_jtag_sel         : 3   ; /* [31..29]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PERI_CTRL;

/* Define the union U_CPU_STAT */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    core0_smpnamp         : 1   ; /* [0]  */
        unsigned int    reserved_0            : 31  ; /* [31..1]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CPU_STAT;

/* Define the union U_CPU_SET */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    core0_cfgnmfi         : 1   ; /* [0]  */
        unsigned int    reserved_0            : 31  ; /* [31..1]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CPU_SET;

/* Define the union U_NF_CFG */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    reserved_2            : 3   ; /* [2..0]  */
        unsigned int    nf_blksize            : 2   ; /* [4..3]  */
        unsigned int    nf_page               : 3   ; /* [7..5]  */
        unsigned int    nf_adnum              : 1   ; /* [8]  */
        unsigned int    randomizer_en         : 1   ; /* [9]  */
        unsigned int    sync_nand             : 1   ; /* [10]  */
        unsigned int    nf_ecc_type           : 4   ; /* [14..11]  */
        unsigned int    reserved_1            : 5   ; /* [19..15]  */
        unsigned int    nf_boot_cfg_lock      : 6   ; /* [25..20]  */
        unsigned int    reserved_0            : 6   ; /* [31..26]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_NF_CFG;

/* Define the union U_PERI_SEC_STAT */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    a9mp_pmusecure        : 1   ; /* [0]  */
        unsigned int    reserved_1            : 3   ; /* [3..1]  */
        unsigned int    a9mp_pmupriv          : 1   ; /* [4]  */
        unsigned int    reserved_0            : 27  ; /* [31..5]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PERI_SEC_STAT;

/* Define the union U_PERI_QOS_GLOB_CTRL */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    ddrc_qos_way          : 1   ; /* [0]  */
        unsigned int    reserved_0            : 31  ; /* [31..1]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PERI_QOS_GLOB_CTRL;

/* Define the union U_PERI_USB_SUSPEND_INT_MASK */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    usb_phy0_suspend_int_mask : 1   ; /* [0]  */
        unsigned int    reserved_1            : 2   ; /* [2..1]  */
        unsigned int    usb_phy1_suspend_int_mask : 1   ; /* [3]  */
        unsigned int    reserved_0            : 28  ; /* [31..4]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PERI_USB_SUSPEND_INT_MASK;

/* Define the union U_PERI_USB_SUSPEND_INT_RAWSTAT */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    usb_phy0_suspend_int_rawstat : 1   ; /* [0]  */
        unsigned int    reserved_1            : 2   ; /* [2..1]  */
        unsigned int    usb_phy1_suspend_int_rawstat : 1   ; /* [3]  */
        unsigned int    reserved_0            : 28  ; /* [31..4]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PERI_USB_SUSPEND_INT_RAWSTAT;

/* Define the union U_PERI_USB_SUSPEND_INT_STAT */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    usb_phy0_suspend_int_stat : 1   ; /* [0]  */
        unsigned int    reserved_1            : 2   ; /* [2..1]  */
        unsigned int    usb_phy1_suspend_int_stat : 1   ; /* [3]  */
        unsigned int    reserved_0            : 28  ; /* [31..4]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PERI_USB_SUSPEND_INT_STAT;

/* Define the union U_PERI_INT_A9TOMCE */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    int_a9tomce           : 1   ; /* [0]  */
        unsigned int    reserved_0            : 31  ; /* [31..1]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PERI_INT_A9TOMCE;

/* Define the union U_PERI_INT_A9TODSP0 */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    int_swi_a9todsp0      : 1   ; /* [0]  */
        unsigned int    reserved_0            : 31  ; /* [31..1]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PERI_INT_A9TODSP0;

/* Define the union U_PERI_INT_DSP0TOA9 */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    int_swi_dsp0toa9      : 1   ; /* [0]  */
        unsigned int    reserved_0            : 31  ; /* [31..1]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PERI_INT_DSP0TOA9;

/* Define the union U_PERI_INT_SWI0 */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    int_swi0              : 1   ; /* [0]  */
        unsigned int    reserved_0            : 31  ; /* [31..1]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PERI_INT_SWI0;

/* Define the union U_PERI_INT_SWI1 */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    int_swi1              : 1   ; /* [0]  */
        unsigned int    reserved_0            : 31  ; /* [31..1]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PERI_INT_SWI1;

/* Define the union U_PERI_INT_SWI2 */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    int_swi2              : 1   ; /* [0]  */
        unsigned int    reserved_0            : 31  ; /* [31..1]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PERI_INT_SWI2;

/* Define the union U_PERI_INT_SWI0_MASK */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    int_swi0_mask_a9      : 1   ; /* [0]  */
        unsigned int    int_swi0_mask_dsp0    : 1   ; /* [1]  */
        unsigned int    reserved_0            : 30  ; /* [31..2]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PERI_INT_SWI0_MASK;

/* Define the union U_PERI_INT_SWI1_MASK */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    int_swi1_mask_a9      : 1   ; /* [0]  */
        unsigned int    int_swi1_mask_dsp0    : 1   ; /* [1]  */
        unsigned int    reserved_0            : 30  ; /* [31..2]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PERI_INT_SWI1_MASK;

/* Define the union U_PERI_INT_SWI2_MASK */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    int_swi2_mask_a9      : 1   ; /* [0]  */
        unsigned int    int_swi2_mask_dsp0    : 1   ; /* [1]  */
        unsigned int    reserved_0            : 30  ; /* [31..2]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PERI_INT_SWI2_MASK;

/* Define the union U_PERI_TIANLA_ADAC0 */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    dacr_vol              : 7   ; /* [6..0]  */
        unsigned int    reserved_1            : 1   ; /* [7]  */
        unsigned int    dacl_vol              : 7   ; /* [14..8]  */
        unsigned int    reserved_0            : 3   ; /* [17..15]  */
        unsigned int    deemphasis_fs         : 2   ; /* [19..18]  */
        unsigned int    dacr_deemph           : 1   ; /* [20]  */
        unsigned int    dacl_deemph           : 1   ; /* [21]  */
        unsigned int    dacr_path             : 1   ; /* [22]  */
        unsigned int    dacl_path             : 1   ; /* [23]  */
        unsigned int    popfreer              : 1   ; /* [24]  */
        unsigned int    popfreel              : 1   ; /* [25]  */
        unsigned int    fs                    : 1   ; /* [26]  */
        unsigned int    pd_vref               : 1   ; /* [27]  */
        unsigned int    mute_dacr             : 1   ; /* [28]  */
        unsigned int    mute_dacl             : 1   ; /* [29]  */
        unsigned int    pd_dacr               : 1   ; /* [30]  */
        unsigned int    pd_dacl               : 1   ; /* [31]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PERI_TIANLA_ADAC0;

/* Define the union U_PERI_TIANLA_ADAC1 */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    reserved_2            : 8   ; /* [7..0]  */
        unsigned int    clkdgesel             : 1   ; /* [8]  */
        unsigned int    clksel2               : 1   ; /* [9]  */
        unsigned int    adj_refbf             : 2   ; /* [11..10]  */
        unsigned int    rst                   : 1   ; /* [12]  */
        unsigned int    adj_ctcm              : 1   ; /* [13]  */
        unsigned int    adj_dac               : 2   ; /* [15..14]  */
        unsigned int    reserved_1            : 3   ; /* [18..16]  */
        unsigned int    sample_sel            : 3   ; /* [21..19]  */
        unsigned int    data_bits             : 2   ; /* [23..22]  */
        unsigned int    reserved_0            : 1   ; /* [24]  */
        unsigned int    mute_rate             : 2   ; /* [26..25]  */
        unsigned int    dacvu                 : 1   ; /* [27]  */
        unsigned int    sunmuter              : 1   ; /* [28]  */
        unsigned int    sunmutel              : 1   ; /* [29]  */
        unsigned int    smuter                : 1   ; /* [30]  */
        unsigned int    smutel                : 1   ; /* [31]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PERI_TIANLA_ADAC1;

/* Define the union U_PERI_FEPHY */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    fephy_phy_addr        : 5   ; /* [4..0]  */
        unsigned int    reserved_4            : 3   ; /* [7..5]  */
        unsigned int    fephy_tclk_enable     : 1   ; /* [8]  */
        unsigned int    reserved_3            : 1   ; /* [9]  */
        unsigned int    fephy_patch_enable    : 1   ; /* [10]  */
        unsigned int    reserved_2            : 1   ; /* [11]  */
        unsigned int    soft_fephy_mdio_mdc   : 1   ; /* [12]  */
        unsigned int    reserved_1            : 1   ; /* [13]  */
        unsigned int    soft_fephy_mdio_i     : 1   ; /* [14]  */
        unsigned int    reserved_0            : 1   ; /* [15]  */
        unsigned int    soft_fephy_gp_i       : 16  ; /* [31..16]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PERI_FEPHY;

/* Define the union U_PERI_SD_LDO */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    fuse                  : 4   ; /* [3..0]  */
        unsigned int    vset                  : 1   ; /* [4]  */
        unsigned int    en                    : 1   ; /* [5]  */
        unsigned int    bypass                : 1   ; /* [6]  */
        unsigned int    reserved_0            : 25  ; /* [31..7]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PERI_SD_LDO;

/* Define the union U_PERI_USB0 */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    ss_word_if_i          : 1   ; /* [0]  */
        unsigned int    ohci_susp_lgcy_i      : 1   ; /* [1]  */
        unsigned int    app_start_clk_i       : 1   ; /* [2]  */
        unsigned int    ulpi_bypass_en_i      : 1   ; /* [3]  */
        unsigned int    reserved_3            : 1   ; /* [4]  */
        unsigned int    ss_autoppd_on_overcur_en_i : 1   ; /* [5]  */
        unsigned int    ss_ena_incr_align_i   : 1   ; /* [6]  */
        unsigned int    ss_ena_incr4_i        : 1   ; /* [7]  */
        unsigned int    ss_ena_incr8_i        : 1   ; /* [8]  */
        unsigned int    ss_ena_incr16_i       : 1   ; /* [9]  */
        unsigned int    reserved_2            : 2   ; /* [11..10]  */
        unsigned int    reserved_1            : 10  ; /* [21..12]  */
        unsigned int    ss_hubsetup_min_i     : 1   ; /* [22]  */
        unsigned int    reserved_0            : 5   ; /* [27..23]  */
        unsigned int    chipid                : 1   ; /* [28]  */
        unsigned int    ss_scaledown_mode     : 2   ; /* [30..29]  */
        unsigned int    ohci_0_cntsel_i_n     : 1   ; /* [31]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PERI_USB0;

/* Define the union U_PERI_USB1 */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    test_wrdata           : 8   ; /* [7..0]  */
        unsigned int    test_addr             : 5   ; /* [12..8]  */
        unsigned int    test_wren             : 1   ; /* [13]  */
        unsigned int    test_clk              : 1   ; /* [14]  */
        unsigned int    test_rstn             : 1   ; /* [15]  */
        unsigned int    test_rddata           : 8   ; /* [23..16]  */
        unsigned int    reserved_0            : 8   ; /* [31..24]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PERI_USB1;

/* Define the union U_DSP0_CTRL */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    runstall_dsp0         : 1   ; /* [0]  */
        unsigned int    statvectorsel_dsp0    : 1   ; /* [1]  */
        unsigned int    ocdhaltonreset_dsp0   : 1   ; /* [2]  */
        unsigned int    reserved_1            : 1   ; /* [3]  */
        unsigned int    wdg1_en_dsp0          : 1   ; /* [4]  */
        unsigned int    reserved_0            : 27  ; /* [31..5]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_DSP0_CTRL;

/* Define the union U_DSP0_PRID */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    prid_dsp0             : 2   ; /* [1..0]  */
        unsigned int    reserved_0            : 30  ; /* [31..2]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_DSP0_PRID;

/* Define the union U_DSP0_STATUS */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    pwaitmode_dsp0        : 1   ; /* [0]  */
        unsigned int    xocdmode_dsp0         : 1   ; /* [1]  */
        unsigned int    reserved_0            : 30  ; /* [31..2]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_DSP0_STATUS;

/* Define the union U_PERI_DDRPHY_TEST0 */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    ddrphy_dbgmux_sel     : 4   ; /* [3..0]  */
        unsigned int    reserved_0            : 28  ; /* [31..4]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PERI_DDRPHY_TEST0;

/* Define the union U_PERI_CHIP_INFO4 */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    dolby_flag            : 1   ; /* [0]  */
        unsigned int    reserved_0            : 1   ; /* [1]  */
        unsigned int    dts_flag              : 1   ; /* [2]  */
        unsigned int    peri_chip_info4       : 29  ; /* [31..3]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PERI_CHIP_INFO4;

/* Define the union U_PERI_TIMEOUT_CFG_0 */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    aiao_rtout            : 2   ; /* [1..0]  */
        unsigned int    reserved_7            : 2   ; /* [3..2]  */
        unsigned int    aiao_wtout            : 2   ; /* [5..4]  */
        unsigned int    reserved_6            : 2   ; /* [7..6]  */
        unsigned int    bpd_rtout             : 2   ; /* [9..8]  */
        unsigned int    reserved_5            : 2   ; /* [11..10]  */
        unsigned int    bpd_wtout             : 2   ; /* [13..12]  */
        unsigned int    reserved_4            : 2   ; /* [15..14]  */
        unsigned int    cpu_m1_rtout          : 2   ; /* [17..16]  */
        unsigned int    reserved_3            : 2   ; /* [19..18]  */
        unsigned int    cpu_m1_wtout          : 2   ; /* [21..20]  */
        unsigned int    reserved_2            : 2   ; /* [23..22]  */
        unsigned int    ddrt_rtout            : 2   ; /* [25..24]  */
        unsigned int    reserved_1            : 2   ; /* [27..26]  */
        unsigned int    ddrt_wtout            : 2   ; /* [29..28]  */
        unsigned int    reserved_0            : 2   ; /* [31..30]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PERI_TIMEOUT_CFG_0;

/* Define the union U_PERI_TIMEOUT_CFG_1 */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    dsp_rtout             : 2   ; /* [1..0]  */
        unsigned int    reserved_7            : 2   ; /* [3..2]  */
        unsigned int    dsp_wtout             : 2   ; /* [5..4]  */
        unsigned int    reserved_6            : 2   ; /* [7..6]  */
        unsigned int    gpu_rtout             : 2   ; /* [9..8]  */
        unsigned int    reserved_5            : 2   ; /* [11..10]  */
        unsigned int    gpu_wtout             : 2   ; /* [13..12]  */
        unsigned int    reserved_4            : 2   ; /* [15..14]  */
        unsigned int    hwc_m0_rtout          : 2   ; /* [17..16]  */
        unsigned int    reserved_3            : 2   ; /* [19..18]  */
        unsigned int    hwc_m0_wtout          : 2   ; /* [21..20]  */
        unsigned int    reserved_2            : 2   ; /* [23..22]  */
        unsigned int    jpgd_rtout            : 2   ; /* [25..24]  */
        unsigned int    reserved_1            : 2   ; /* [27..26]  */
        unsigned int    jpgd_wtout            : 2   ; /* [29..28]  */
        unsigned int    reserved_0            : 2   ; /* [31..30]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PERI_TIMEOUT_CFG_1;

/* Define the union U_PERI_TIMEOUT_CFG_2 */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    reserved_3            : 8   ; /* [7..0]  */
        unsigned int    pgd_rtout             : 2   ; /* [9..8]  */
        unsigned int    reserved_2            : 2   ; /* [11..10]  */
        unsigned int    pgd_wtout             : 2   ; /* [13..12]  */
        unsigned int    reserved_1            : 14  ; /* [27..14]  */
        unsigned int    tde_rtout             : 2   ; /* [29..28]  */
        unsigned int    reserved_0            : 2   ; /* [31..30]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PERI_TIMEOUT_CFG_2;

/* Define the union U_PERI_TIMEOUT_CFG_3 */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    tde_wtout             : 2   ; /* [1..0]  */
        unsigned int    reserved_6            : 2   ; /* [3..2]  */
        unsigned int    vdh_rtout             : 2   ; /* [5..4]  */
        unsigned int    reserved_5            : 2   ; /* [7..6]  */
        unsigned int    vdh_wtout             : 2   ; /* [9..8]  */
        unsigned int    reserved_4            : 2   ; /* [11..10]  */
        unsigned int    vdp_rtout             : 2   ; /* [13..12]  */
        unsigned int    reserved_3            : 2   ; /* [15..14]  */
        unsigned int    vdp_wtout             : 2   ; /* [17..16]  */
        unsigned int    reserved_2            : 2   ; /* [19..18]  */
        unsigned int    vedu_rtout            : 2   ; /* [21..20]  */
        unsigned int    reserved_1            : 2   ; /* [23..22]  */
        unsigned int    vedu_wtout            : 2   ; /* [25..24]  */
        unsigned int    reserved_0            : 6   ; /* [31..26]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PERI_TIMEOUT_CFG_3;

/* Define the union U_PERI_TIMEOUT_CFG_4 */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    vpss_m0_rtout         : 2   ; /* [1..0]  */
        unsigned int    reserved_7            : 2   ; /* [3..2]  */
        unsigned int    vpss_m0_wtout         : 2   ; /* [5..4]  */
        unsigned int    reserved_6            : 2   ; /* [7..6]  */
        unsigned int    ca_m_tout             : 2   ; /* [9..8]  */
        unsigned int    reserved_5            : 2   ; /* [11..10]  */
        unsigned int    dmac_m0_tout          : 2   ; /* [13..12]  */
        unsigned int    reserved_4            : 2   ; /* [15..14]  */
        unsigned int    dmac_m1_tout          : 2   ; /* [17..16]  */
        unsigned int    reserved_3            : 2   ; /* [19..18]  */
        unsigned int    nandc_m_tout          : 2   ; /* [21..20]  */
        unsigned int    reserved_2            : 2   ; /* [23..22]  */
        unsigned int    pvr_m_tout            : 2   ; /* [25..24]  */
        unsigned int    reserved_1            : 2   ; /* [27..26]  */
        unsigned int    scd_m_tout            : 2   ; /* [29..28]  */
        unsigned int    reserved_0            : 2   ; /* [31..30]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PERI_TIMEOUT_CFG_4;

/* Define the union U_PERI_TIMEOUT_CFG_5 */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    sdio0_m_tout          : 2   ; /* [1..0]  */
        unsigned int    reserved_6            : 2   ; /* [3..2]  */
        unsigned int    sdio1_m_tout          : 2   ; /* [5..4]  */
        unsigned int    reserved_5            : 2   ; /* [7..6]  */
        unsigned int    sf_m0_tout            : 2   ; /* [9..8]  */
        unsigned int    reserved_4            : 6   ; /* [15..10]  */
        unsigned int    sfc_m_tout            : 2   ; /* [17..16]  */
        unsigned int    reserved_3            : 2   ; /* [19..18]  */
        unsigned int    sha_m_tout            : 2   ; /* [21..20]  */
        unsigned int    reserved_2            : 2   ; /* [23..22]  */
        unsigned int    usb2host0_ehci_m_tout : 2   ; /* [25..24]  */
        unsigned int    reserved_1            : 2   ; /* [27..26]  */
        unsigned int    usb2otg0_m_tout       : 2   ; /* [29..28]  */
        unsigned int    reserved_0            : 2   ; /* [31..30]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PERI_TIMEOUT_CFG_5;

/* Define the union U_PERI_TIMEOUT_CFG_6 */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    mce_m_tout            : 2   ; /* [1..0]  */
        unsigned int    reserved_0            : 30  ; /* [31..2]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PERI_TIMEOUT_CFG_6;

/* Define the union U_PERI_SIM_OD_CTRL */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    reserved_1            : 1   ; /* [0]  */
        unsigned int    sim0_pwren_od_sel     : 1   ; /* [1]  */
        unsigned int    sim0_rst_od_sel       : 1   ; /* [2]  */
        unsigned int    reserved_0            : 29  ; /* [31..3]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PERI_SIM_OD_CTRL;

/* Define the union U_PERI_SOC_FUSE */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    otp_control_cpu       : 1   ; /* [0]  */
        unsigned int    reserved_4            : 2   ; /* [2..1]  */
        unsigned int    otp_control_gpu       : 2   ; /* [4..3]  */
        unsigned int    otp_ddr_st            : 2   ; /* [6..5]  */
        unsigned int    otp_vd_st             : 1   ; /* [7]  */
        unsigned int    reserved_3            : 1   ; /* [8]  */
        unsigned int    otp_pvr_tsi2_cken     : 1   ; /* [9]  */
        unsigned int    otp_spdif_ctrl        : 1   ; /* [10]  */
        unsigned int    reserved_2            : 1   ; /* [11]  */
        unsigned int    otp_ctrl_vdac         : 4   ; /* [15..12]  */
        unsigned int    chip_id               : 5   ; /* [20..16]  */
        unsigned int    reserved_1            : 3   ; /* [23..21]  */
        unsigned int    mven                  : 1   ; /* [24]  */
        unsigned int    vedu_chip_id          : 2   ; /* [26..25]  */
        unsigned int    reserved_0            : 5   ; /* [31..27]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PERI_SOC_FUSE;

/* Define the union U_PERI_FEPHY_LDO_CTRL */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    fephy_ldo_vset        : 4   ; /* [3..0]  */
        unsigned int    reserved_0            : 28  ; /* [31..4]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PERI_FEPHY_LDO_CTRL;

//==============================================================================
/* Define the global struct */
typedef struct
{
    volatile U_START_MODE           START_MODE               ; /* 0x0 */
    volatile U_PERI_STAT            PERI_STAT                ; /* 0x4 */
    volatile U_PERI_CTRL            PERI_CTRL                ; /* 0x8 */
    volatile U_CPU_STAT             CPU_STAT                 ; /* 0xc */
    volatile U_CPU_SET              CPU_SET                  ; /* 0x10 */
    volatile U_NF_CFG               NF_CFG                   ; /* 0x14 */
    volatile U_PERI_SEC_STAT        PERI_SEC_STAT            ; /* 0x18 */
    volatile unsigned int           reserved_0[9]            ; /* 0x1c~0x3c */
    volatile U_PERI_QOS_GLOB_CTRL   PERI_QOS_GLOB_CTRL       ; /* 0x40 */
    volatile unsigned int           PERI_QOS_CFG0            ; /* 0x44 */
    volatile unsigned int           PERI_QOS_CFG1            ; /* 0x48 */
    volatile unsigned int           PERI_QOS_CFG2            ; /* 0x4c */
    volatile unsigned int           PERI_QOS_CFG3            ; /* 0x50 */
    volatile unsigned int           PERI_QOS_CFG4            ; /* 0x54 */
    volatile unsigned int           PERI_QOS_CFG5            ; /* 0x58 */
    volatile unsigned int           PERI_QOS_CFG6            ; /* 0x5c */
    volatile unsigned int           PERI_QOS_CFG7            ; /* 0x60 */
    volatile unsigned int           reserved_1[20]           ; /* 0x64~0xb0 */
    volatile U_PERI_USB_SUSPEND_INT_MASK   PERI_USB_SUSPEND_INT_MASK ; /* 0xb4 */
    volatile U_PERI_USB_SUSPEND_INT_RAWSTAT   PERI_USB_SUSPEND_INT_RAWSTAT ; /* 0xb8 */
    volatile U_PERI_USB_SUSPEND_INT_STAT   PERI_USB_SUSPEND_INT_STAT ; /* 0xbc */
    volatile U_PERI_INT_A9TOMCE     PERI_INT_A9TOMCE         ; /* 0xc0 */
    volatile U_PERI_INT_A9TODSP0    PERI_INT_A9TODSP0        ; /* 0xc4 */
    volatile U_PERI_INT_DSP0TOA9    PERI_INT_DSP0TOA9        ; /* 0xc8 */
    volatile unsigned int           reserved_2[6]            ; /* 0xcc~0xe0 */
    volatile U_PERI_INT_SWI0        PERI_INT_SWI0            ; /* 0xe4 */
    volatile U_PERI_INT_SWI1        PERI_INT_SWI1            ; /* 0xe8 */
    volatile U_PERI_INT_SWI2        PERI_INT_SWI2            ; /* 0xec */
    volatile U_PERI_INT_SWI0_MASK   PERI_INT_SWI0_MASK       ; /* 0xf0 */
    volatile U_PERI_INT_SWI1_MASK   PERI_INT_SWI1_MASK       ; /* 0xf4 */
    volatile U_PERI_INT_SWI2_MASK   PERI_INT_SWI2_MASK       ; /* 0xf8 */
    volatile unsigned int           reserved_3[5]            ; /* 0xfc~0x10c */
    volatile U_PERI_TIANLA_ADAC0    PERI_TIANLA_ADAC0        ; /* 0x110 */
    volatile U_PERI_TIANLA_ADAC1    PERI_TIANLA_ADAC1        ; /* 0x114 */
    volatile U_PERI_FEPHY           PERI_FEPHY               ; /* 0x118 */
    volatile U_PERI_SD_LDO          PERI_SD_LDO              ; /* 0x11c */
    volatile U_PERI_USB0            PERI_USB0                ; /* 0x120 */
    volatile U_PERI_USB1            PERI_USB1                ; /* 0x124 */
    volatile unsigned int           reserved_4[22]           ; /* 0x128~0x17c */
    volatile U_DSP0_CTRL            DSP0_CTRL                ; /* 0x180 */
    volatile U_DSP0_PRID            DSP0_PRID                ; /* 0x184 */
    volatile U_DSP0_STATUS          DSP0_STATUS              ; /* 0x188 */
    volatile unsigned int           DSP0_IMPWIRE             ; /* 0x18c */
    volatile unsigned int           DSP0_EXPSTATE            ; /* 0x190 */
    volatile unsigned int           reserved_5[8]            ; /* 0x194~0x1b0 */
    volatile U_PERI_DDRPHY_TEST0    PERI_DDRPHY_TEST0        ; /* 0x1b4 */
    volatile unsigned int           reserved_6[10]           ; /* 0x1b8~0x1dc */
    volatile U_PERI_CHIP_INFO4      PERI_CHIP_INFO4          ; /* 0x1e0 */
    volatile unsigned int           reserved_7[3]            ; /* 0x1e4~0x1ec */
    volatile unsigned int           PERI_SW_SET              ; /* 0x1f0 */
    volatile unsigned int           reserved_8[131]          ; /* 0x1f4~0x3fc */
    volatile unsigned int           PERI_DSP0_0              ; /* 0x400 */
    volatile unsigned int           PERI_DSP0_1              ; /* 0x404 */
    volatile unsigned int           PERI_DSP0_2              ; /* 0x408 */
    volatile unsigned int           PERI_DSP0_3              ; /* 0x40c */
    volatile unsigned int           PERI_DSP0_4              ; /* 0x410 */
    volatile unsigned int           PERI_DSP0_5              ; /* 0x414 */
    volatile unsigned int           PERI_DSP0_6              ; /* 0x418 */
    volatile unsigned int           PERI_DSP0_7              ; /* 0x41c */
    volatile unsigned int           reserved_9[256]          ; /* 0x420~0x81c */
    volatile U_PERI_TIMEOUT_CFG_0   PERI_TIMEOUT_CFG_0       ; /* 0x820 */
    volatile U_PERI_TIMEOUT_CFG_1   PERI_TIMEOUT_CFG_1       ; /* 0x824 */
    volatile U_PERI_TIMEOUT_CFG_2   PERI_TIMEOUT_CFG_2       ; /* 0x828 */
    volatile U_PERI_TIMEOUT_CFG_3   PERI_TIMEOUT_CFG_3       ; /* 0x82c */
    volatile U_PERI_TIMEOUT_CFG_4   PERI_TIMEOUT_CFG_4       ; /* 0x830 */
    volatile U_PERI_TIMEOUT_CFG_5   PERI_TIMEOUT_CFG_5       ; /* 0x834 */
    volatile U_PERI_TIMEOUT_CFG_6   PERI_TIMEOUT_CFG_6       ; /* 0x838 */
    volatile U_PERI_SIM_OD_CTRL     PERI_SIM_OD_CTRL         ; /* 0x83c */
    volatile U_PERI_SOC_FUSE        PERI_SOC_FUSE            ; /* 0x840 */
    volatile U_PERI_FEPHY_LDO_CTRL   PERI_FEPHY_LDO_CTRL     ; /* 0x844 */
} S_PERICTRL_REGS_TYPE;

#endif /* __HI_REG_PERI_H__ */

