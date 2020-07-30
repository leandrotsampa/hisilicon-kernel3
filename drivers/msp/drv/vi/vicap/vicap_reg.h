//******************************************************************************
//  Copyright (C), 2007-2013, Hisilicon Technologies Co., Ltd.
//
//******************************************************************************
// File name     : c_union_define.h
// Version       : 2.0
// Author        : xxx
// Created       : 2013-10-12
// Last Modified : 
// Description   :  The C union definition file for the module vicap
// Function List : 
// History       : 
// 1 Date        : 
// Author        : xxx
// Modification  : Create file
//******************************************************************************

#ifndef __VICAP_REG_H__
#define __VICAP_REG_H__

/* Define the union U_WK_MODE */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    power_mode            : 1   ; /* [0]  */
        unsigned int    Reserved_0            : 31  ; /* [31..1]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_WK_MODE;

/* Define the union U_AXI_CFG */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    Reserved_2            : 4   ; /* [3..0]  */
        unsigned int    outstanding           : 4   ; /* [7..4]  */
        unsigned int    Reserved_1            : 24  ; /* [31..8]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_AXI_CFG;

/* Define the union U_MAC_CFG */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    req_prio              : 8   ; /* [7..0]  */
        unsigned int    Reserved_4            : 24  ; /* [31..8]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_MAC_CFG;

/* Define the union U_PT_SEL */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    pt0_sel               : 1   ; /* [0]  */
        unsigned int    pt1_sel               : 1   ; /* [1]  */
        unsigned int    Reserved_5            : 30  ; /* [31..2]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PT_SEL;

/* Define the union U_CH_SEL */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    ch0_sel               : 1   ; /* [0]  */
        unsigned int    ch1_sel               : 1   ; /* [1]  */
        unsigned int    Reserved_7            : 30  ; /* [31..2]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_SEL;

/* Define the union U_APB_TIMEOUT */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    timeout               : 16  ; /* [15..0]  */
        unsigned int    Reserved_9            : 15  ; /* [30..16]  */
        unsigned int    enable                : 1   ; /* [31]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_APB_TIMEOUT;

/* Define the union U_VICAP_INT */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    int_ch0               : 1   ; /* [0]  */
        unsigned int    int_ch1               : 1   ; /* [1]  */
        unsigned int    Reserved_12           : 14  ; /* [15..2]  */
        unsigned int    int_pt0               : 1   ; /* [16]  */
        unsigned int    int_pt1               : 1   ; /* [17]  */
        unsigned int    Reserved_11           : 14  ; /* [31..18]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_VICAP_INT;

/* Define the union U_VICAP_INT_MASK */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    int_ch0               : 1   ; /* [0]  */
        unsigned int    int_ch1               : 1   ; /* [1]  */
        unsigned int    Reserved_15           : 14  ; /* [15..2]  */
        unsigned int    int_pt0               : 1   ; /* [16]  */
        unsigned int    int_pt1               : 1   ; /* [17]  */
        unsigned int    Reserved_14           : 14  ; /* [31..18]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_VICAP_INT_MASK;

/* Define the union U_PT_INTF_MOD */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    mode                  : 1   ; /* [0]  */
        unsigned int    Reserved_17           : 30  ; /* [30..1]  */
        unsigned int    enable                : 1   ; /* [31]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PT_INTF_MOD;

/* Define the union U_PT_OFFSET0 */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    offset                : 6   ; /* [5..0]  */
        unsigned int    Reserved_19           : 9   ; /* [14..6]  */
        unsigned int    rev                   : 1   ; /* [15]  */
        unsigned int    mask                  : 16  ; /* [31..16]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PT_OFFSET0;

/* Define the union U_PT_OFFSET1 */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    offset                : 6   ; /* [5..0]  */
        unsigned int    Reserved_21           : 9   ; /* [14..6]  */
        unsigned int    rev                   : 1   ; /* [15]  */
        unsigned int    mask                  : 16  ; /* [31..16]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PT_OFFSET1;

/* Define the union U_PT_OFFSET2 */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    offset                : 6   ; /* [5..0]  */
        unsigned int    Reserved_22           : 9   ; /* [14..6]  */
        unsigned int    rev                   : 1   ; /* [15]  */
        unsigned int    mask                  : 16  ; /* [31..16]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PT_OFFSET2;

/* Define the union U_PT_BT656_CFG */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    mode                  : 4   ; /* [3..0]  */
        unsigned int    Reserved_24           : 4   ; /* [7..4]  */
        unsigned int    hsync_inv             : 1   ; /* [8]  */
        unsigned int    vsync_inv             : 1   ; /* [9]  */
        unsigned int    field_inv             : 1   ; /* [10]  */
        unsigned int    Reserved_23           : 20  ; /* [30..11]  */
        unsigned int    enable                : 1   ; /* [31]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PT_BT656_CFG;

/* Define the union U_PT_UNIFY_TIMING_CFG */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    de_sel                : 2   ; /* [1..0]  */
        unsigned int    de_inv                : 1   ; /* [2]  */
        unsigned int    Reserved_29           : 5   ; /* [7..3]  */
        unsigned int    hsync_sel             : 2   ; /* [9..8]  */
        unsigned int    hsync_inv             : 1   ; /* [10]  */
        unsigned int    hsync_and             : 2   ; /* [12..11]  */
        unsigned int    hsync_mode            : 2   ; /* [14..13]  */
        unsigned int    Reserved_28           : 1   ; /* [15]  */
        unsigned int    vsync_sel             : 2   ; /* [17..16]  */
        unsigned int    vsync_inv             : 1   ; /* [18]  */
        unsigned int    vsync_mode            : 2   ; /* [20..19]  */
        unsigned int    Reserved_27           : 3   ; /* [23..21]  */
        unsigned int    field_sel             : 2   ; /* [25..24]  */
        unsigned int    field_inv             : 1   ; /* [26]  */
        unsigned int    Reserved_26           : 5   ; /* [31..27]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PT_UNIFY_TIMING_CFG;

/* Define the union U_PT_GEN_TIMING_CFG */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    Reserved_32           : 1   ; /* [0]  */
        unsigned int    hsync_mode            : 1   ; /* [1]  */
        unsigned int    vsync_mode            : 1   ; /* [2]  */
        unsigned int    Reserved_31           : 28  ; /* [30..3]  */
        unsigned int    enable                : 1   ; /* [31]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PT_GEN_TIMING_CFG;

/* Define the union U_PT_UNIFY_DATA_CFG */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    comp_num              : 2   ; /* [1..0]  */
        unsigned int    yc_seq                : 1   ; /* [2]  */
        unsigned int    uv_seq                : 1   ; /* [3]  */
        unsigned int    Reserved_33           : 27  ; /* [30..4]  */
        unsigned int    enable                : 1   ; /* [31]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PT_UNIFY_DATA_CFG;

/* Define the union U_PT_GEN_DATA_CFG */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    de_move               : 1   ; /* [0]  */
        unsigned int    hsync_move            : 1   ; /* [1]  */
        unsigned int    vsync_move            : 1   ; /* [2]  */
        unsigned int    hsync_reset           : 1   ; /* [3]  */
        unsigned int    vsync_reset           : 1   ; /* [4]  */
        unsigned int    data2_move            : 1   ; /* [5]  */
        unsigned int    data1_move            : 1   ; /* [6]  */
        unsigned int    data0_move            : 1   ; /* [7]  */
        unsigned int    Reserved_35           : 23  ; /* [30..8]  */
        unsigned int    enable                : 1   ; /* [31]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PT_GEN_DATA_CFG;

/* Define the union U_PT_GEN_DATA_COEF */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    step_space            : 8   ; /* [7..0]  */
        unsigned int    inc_space             : 8   ; /* [15..8]  */
        unsigned int    step_frame            : 8   ; /* [23..16]  */
        unsigned int    inc_frame             : 8   ; /* [31..24]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PT_GEN_DATA_COEF;

/* Define the union U_PT_GEN_DATA_INIT */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    data0                 : 8   ; /* [7..0]  */
        unsigned int    data1                 : 8   ; /* [15..8]  */
        unsigned int    data2                 : 8   ; /* [23..16]  */
        unsigned int    Reserved_36           : 8   ; /* [31..24]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PT_GEN_DATA_INIT;

/* Define the union U_PT_YUV444_CFG */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    Reserved_37           : 31  ; /* [30..0]  */
        unsigned int    enable                : 1   ; /* [31]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PT_YUV444_CFG;

/* Define the union U_PT_FSTART_DLY */
typedef union
{
    /* Define the struct bits  */
    struct
    {
        unsigned int fstart_dly              : 32  ; /* [31..0]  */
    } bits;
 
    /* Define an unsigned member */
        unsigned int    u32;
 
} U_PT_FSTART_DLY;
/* Define the union U_PT_INTF_HFB */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    hfb                   : 16  ; /* [15..0]  */
        unsigned int    Reserved_39           : 16  ; /* [31..16]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PT_INTF_HFB;

/* Define the union U_PT_INTF_HACT */
typedef union
{
    /* Define the struct bits  */
    struct
    {
        unsigned int hact                    : 32  ; /* [31..0]  */
    } bits;
 
    /* Define an unsigned member */
        unsigned int    u32;
 
} U_PT_INTF_HACT;
/* Define the union U_PT_INTF_HBB */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    hbb                   : 16  ; /* [15..0]  */
        unsigned int    Reserved_41           : 16  ; /* [31..16]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PT_INTF_HBB;

/* Define the union U_PT_INTF_VFB */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    vfb                   : 16  ; /* [15..0]  */
        unsigned int    Reserved_42           : 16  ; /* [31..16]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PT_INTF_VFB;

/* Define the union U_PT_INTF_VACT */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    vact                  : 16  ; /* [15..0]  */
        unsigned int    Reserved_43           : 16  ; /* [31..16]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PT_INTF_VACT;

/* Define the union U_PT_INTF_VBB */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    vbb                   : 16  ; /* [15..0]  */
        unsigned int    Reserved_44           : 16  ; /* [31..16]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PT_INTF_VBB;

/* Define the union U_PT_INTF_VBFB */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    vbfb                  : 16  ; /* [15..0]  */
        unsigned int    Reserved_45           : 16  ; /* [31..16]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PT_INTF_VBFB;

/* Define the union U_PT_INTF_VBACT */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    vbact                 : 16  ; /* [15..0]  */
        unsigned int    Reserved_46           : 16  ; /* [31..16]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PT_INTF_VBACT;

/* Define the union U_PT_INTF_VBBB */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    vbbb                  : 16  ; /* [15..0]  */
        unsigned int    Reserved_47           : 16  ; /* [31..16]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PT_INTF_VBBB;

/* Define the union U_PT_STATUS */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    de                    : 1   ; /* [0]  */
        unsigned int    hsync                 : 1   ; /* [1]  */
        unsigned int    vysnc                 : 1   ; /* [2]  */
        unsigned int    field                 : 1   ; /* [3]  */
        unsigned int    Reserved_48           : 28  ; /* [31..4]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PT_STATUS;

/* Define the union U_PT_BT656_STATUS */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    Reserved_51           : 8   ; /* [7..0]  */
        unsigned int    seav                  : 8   ; /* [15..8]  */
        unsigned int    Reserved_50           : 16  ; /* [31..16]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PT_BT656_STATUS;

/* Define the union U_PT_SIZE */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    width                 : 16  ; /* [15..0]  */
        unsigned int    height                : 16  ; /* [31..16]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PT_SIZE;

/* Define the union U_PT_INT */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    fstart                : 1   ; /* [0]  */
        unsigned int    width_err             : 1   ; /* [1]  */
        unsigned int    height_err            : 1   ; /* [2]  */
        unsigned int    Reserved_53           : 29  ; /* [31..3]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PT_INT;

/* Define the union U_PT_INT_MASK */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    fstart                : 1   ; /* [0]  */
        unsigned int    width_err             : 1   ; /* [1]  */
        unsigned int    height_err            : 1   ; /* [2]  */
        unsigned int    Reserved_54           : 29  ; /* [31..3]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_PT_INT_MASK;

/* Define the union U_CH_CTRL */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    Reserved_56           : 31  ; /* [30..0]  */
        unsigned int    enable                : 1   ; /* [31]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_CTRL;

/* Define the union U_CH_REG_NEWER */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    reg_newer             : 1   ; /* [0]  */
        unsigned int    Reserved_58           : 31  ; /* [31..1]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_REG_NEWER;

/* Define the union U_CH_ADAPTER_CFG */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    hsync_mode            : 1   ; /* [0]  */
        unsigned int    vsync_mode            : 1   ; /* [1]  */
        unsigned int    Reserved_59           : 30  ; /* [31..2]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_ADAPTER_CFG;

/* Define the union U_CH_WCH_Y_CFG */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    cmp_en                : 1   ; /* [0]  */
        unsigned int    cmp_mode              : 1   ; /* [1]  */
        unsigned int    head_tword            : 1   ; /* [2]  */
        unsigned int    Reserved_62           : 13  ; /* [15..3]  */
        unsigned int    bit_width             : 2   ; /* [17..16]  */
        unsigned int    bfield                : 1   ; /* [18]  */
        unsigned int    interleave            : 1   ; /* [19]  */
        unsigned int    Reserved_61           : 12  ; /* [31..20]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_WCH_Y_CFG;

/* Define the union U_CH_WCH_Y_SIZE */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    width                 : 13  ; /* [12..0]  */
        unsigned int    Reserved_65           : 3   ; /* [15..13]  */
        unsigned int    height                : 13  ; /* [28..16]  */
        unsigned int    Reserved_64           : 3   ; /* [31..29]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_WCH_Y_SIZE;

/* Define the union U_CH_WCH_Y_FADDR */
typedef union
{
    /* Define the struct bits  */
    struct
    {
        unsigned int faddr                   : 32  ; /* [31..0]  */
    } bits;
 
    /* Define an unsigned member */
        unsigned int    u32;
 
} U_CH_WCH_Y_FADDR;
/* Define the union U_CH_WCH_Y_HADDR */
typedef union
{
    /* Define the struct bits  */
    struct
    {
        unsigned int haddr                   : 32  ; /* [31..0]  */
    } bits;
 
    /* Define an unsigned member */
        unsigned int    u32;
 
} U_CH_WCH_Y_HADDR;
/* Define the union U_CH_WCH_Y_STRIDE */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    stride                : 16  ; /* [15..0]  */
        unsigned int    Reserved_67           : 16  ; /* [31..16]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_WCH_Y_STRIDE;

/* Define the union U_CH_WCH_C_CFG */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    cmp_en                : 1   ; /* [0]  */
        unsigned int    cmp_mode              : 1   ; /* [1]  */
        unsigned int    head_tword            : 1   ; /* [2]  */
        unsigned int    Reserved_69           : 13  ; /* [15..3]  */
        unsigned int    bit_width             : 2   ; /* [17..16]  */
        unsigned int    bfield                : 1   ; /* [18]  */
        unsigned int    interleave            : 1   ; /* [19]  */
        unsigned int    Reserved_68           : 12  ; /* [31..20]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_WCH_C_CFG;

/* Define the union U_CH_WCH_C_SIZE */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    width                 : 13  ; /* [12..0]  */
        unsigned int    Reserved_72           : 3   ; /* [15..13]  */
        unsigned int    height                : 13  ; /* [28..16]  */
        unsigned int    Reserved_71           : 3   ; /* [31..29]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_WCH_C_SIZE;

/* Define the union U_CH_WCH_C_FADDR */
typedef union
{
    /* Define the struct bits  */
    struct
    {
        unsigned int faddr                   : 32  ; /* [31..0]  */
    } bits;
 
    /* Define an unsigned member */
        unsigned int    u32;
 
} U_CH_WCH_C_FADDR;
/* Define the union U_CH_WCH_C_HADDR */
typedef union
{
    /* Define the struct bits  */
    struct
    {
        unsigned int haddr                   : 32  ; /* [31..0]  */
    } bits;
 
    /* Define an unsigned member */
        unsigned int    u32;
 
} U_CH_WCH_C_HADDR;
/* Define the union U_CH_WCH_C_STRIDE */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    stride                : 16  ; /* [15..0]  */
        unsigned int    Reserved_74           : 16  ; /* [31..16]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_WCH_C_STRIDE;

/* Define the union U_CH_INT */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    fstart                : 1   ; /* [0]  */
        unsigned int    cc_int                : 1   ; /* [1]  */
        unsigned int    buf_ovf               : 1   ; /* [2]  */
        unsigned int    field_throw           : 1   ; /* [3]  */
        unsigned int    update_cfg            : 1   ; /* [4]  */
        unsigned int    bus_err_c             : 1   ; /* [5]  */
        unsigned int    bus_err_y             : 1   ; /* [6]  */
        unsigned int    Reserved_75           : 25  ; /* [31..7]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_INT;

/* Define the union U_CH_INT_MASK */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    fstart                : 1   ; /* [0]  */
        unsigned int    cc_int                : 1   ; /* [1]  */
        unsigned int    buf_ovf               : 1   ; /* [2]  */
        unsigned int    field_throw           : 1   ; /* [3]  */
        unsigned int    update_cfg            : 1   ; /* [4]  */
        unsigned int    bus_err_c             : 1   ; /* [5]  */
        unsigned int    bus_err_y             : 1   ; /* [6]  */
        unsigned int    Reserved_77           : 25  ; /* [31..7]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_INT_MASK;

/* Define the union U_CH_CROP_CFG */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    n0_en                 : 1   ; /* [0]  */
        unsigned int    n1_en                 : 1   ; /* [1]  */
        unsigned int    Reserved_79           : 30  ; /* [31..2]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_CROP_CFG;

/* Define the union U_CH_CROP_WIN */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    width                 : 13  ; /* [12..0]  */
        unsigned int    Reserved_82           : 3   ; /* [15..13]  */
        unsigned int    height                : 13  ; /* [28..16]  */
        unsigned int    Reserved_81           : 3   ; /* [31..29]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_CROP_WIN;

/* Define the union U_CH_CROP0_START */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    x_start               : 13  ; /* [12..0]  */
        unsigned int    Reserved_84           : 3   ; /* [15..13]  */
        unsigned int    y_start               : 13  ; /* [28..16]  */
        unsigned int    Reserved_83           : 3   ; /* [31..29]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_CROP0_START;

/* Define the union U_CH_CROP0_SIZE */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    width                 : 13  ; /* [12..0]  */
        unsigned int    Reserved_87           : 3   ; /* [15..13]  */
        unsigned int    height                : 13  ; /* [28..16]  */
        unsigned int    Reserved_86           : 3   ; /* [31..29]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_CROP0_SIZE;

/* Define the union U_CH_CROP1_START */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    x_start               : 13  ; /* [12..0]  */
        unsigned int    Reserved_89           : 3   ; /* [15..13]  */
        unsigned int    y_start               : 13  ; /* [28..16]  */
        unsigned int    Reserved_88           : 3   ; /* [31..29]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_CROP1_START;

/* Define the union U_CH_CROP1_SIZE */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    width                 : 13  ; /* [12..0]  */
        unsigned int    Reserved_92           : 3   ; /* [15..13]  */
        unsigned int    height                : 13  ; /* [28..16]  */
        unsigned int    Reserved_91           : 3   ; /* [31..29]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_CROP1_SIZE;

/* Define the union U_CH_CSC_CFG */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    Reserved_93           : 31  ; /* [30..0]  */
        unsigned int    enable                : 1   ; /* [31]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_CSC_CFG;

/* Define the union U_CH_CSC_COEF0 */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    Reserved_96           : 1   ; /* [0]  */
        unsigned int    coef00                : 15  ; /* [15..1]  */
        unsigned int    Reserved_95           : 1   ; /* [16]  */
        unsigned int    coef01                : 15  ; /* [31..17]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_CSC_COEF0;

/* Define the union U_CH_CSC_COEF1 */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    Reserved_99           : 1   ; /* [0]  */
        unsigned int    coef02                : 15  ; /* [15..1]  */
        unsigned int    Reserved_98           : 1   ; /* [16]  */
        unsigned int    coef10                : 15  ; /* [31..17]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_CSC_COEF1;

/* Define the union U_CH_CSC_COEF2 */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    Reserved_101          : 1   ; /* [0]  */
        unsigned int    coef11                : 15  ; /* [15..1]  */
        unsigned int    Reserved_100          : 1   ; /* [16]  */
        unsigned int    coef12                : 15  ; /* [31..17]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_CSC_COEF2;

/* Define the union U_CH_CSC_COEF3 */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    Reserved_103          : 1   ; /* [0]  */
        unsigned int    coef20                : 15  ; /* [15..1]  */
        unsigned int    Reserved_102          : 1   ; /* [16]  */
        unsigned int    coef21                : 15  ; /* [31..17]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_CSC_COEF3;

/* Define the union U_CH_CSC_COEF4 */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    Reserved_106          : 1   ; /* [0]  */
        unsigned int    coef22                : 15  ; /* [15..1]  */
        unsigned int    Reserved_105          : 1   ; /* [16]  */
        unsigned int    Reserved_104          : 15  ; /* [31..17]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_CSC_COEF4;

/* Define the union U_CH_CSC_IN_DC0 */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    Reserved_108          : 5   ; /* [4..0]  */
        unsigned int    in_dc0                : 11  ; /* [15..5]  */
        unsigned int    Reserved_107          : 5   ; /* [20..16]  */
        unsigned int    in_dc1                : 11  ; /* [31..21]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_CSC_IN_DC0;

/* Define the union U_CH_CSC_IN_DC1 */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    Reserved_112          : 5   ; /* [4..0]  */
        unsigned int    in_dc2                : 11  ; /* [15..5]  */
        unsigned int    Reserved_111          : 5   ; /* [20..16]  */
        unsigned int    Reserved_110          : 11  ; /* [31..21]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_CSC_IN_DC1;

/* Define the union U_CH_CSC_OUT_DC0 */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    Reserved_114          : 5   ; /* [4..0]  */
        unsigned int    out_dc0               : 11  ; /* [15..5]  */
        unsigned int    Reserved_113          : 5   ; /* [20..16]  */
        unsigned int    out_dc1               : 11  ; /* [31..21]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_CSC_OUT_DC0;

/* Define the union U_CH_CSC_OUT_DC1 */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    Reserved_117          : 5   ; /* [4..0]  */
        unsigned int    out_dc2               : 11  ; /* [15..5]  */
        unsigned int    Reserved_116          : 5   ; /* [20..16]  */
        unsigned int    Reserved_115          : 11  ; /* [31..21]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_CSC_OUT_DC1;

/* Define the union U_CH_SKIP_Y_CFG */
typedef union
{
    /* Define the struct bits  */
    struct
    {
        unsigned int skip_cfg                : 32  ; /* [31..0]  */
    } bits;
 
    /* Define an unsigned member */
        unsigned int    u32;
 
} U_CH_SKIP_Y_CFG;
/* Define the union U_CH_SKIP_Y_WIN */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    width                 : 3   ; /* [2..0]  */
        unsigned int    Reserved_120          : 13  ; /* [15..3]  */
        unsigned int    height                : 2   ; /* [17..16]  */
        unsigned int    Reserved_119          : 14  ; /* [31..18]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_SKIP_Y_WIN;

/* Define the union U_CH_SKIP_C_CFG */
typedef union
{
    /* Define the struct bits  */
    struct
    {
        unsigned int skip_cfg                : 32  ; /* [31..0]  */
    } bits;
 
    /* Define an unsigned member */
        unsigned int    u32;
 
} U_CH_SKIP_C_CFG;
/* Define the union U_CH_SKIP_C_WIN */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    width                 : 3   ; /* [2..0]  */
        unsigned int    Reserved_123          : 13  ; /* [15..3]  */
        unsigned int    height                : 2   ; /* [17..16]  */
        unsigned int    Reserved_122          : 14  ; /* [31..18]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_SKIP_C_WIN;

/* Define the union U_CH_COEF_UPDATE */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    lhcoef_update         : 1   ; /* [0]  */
        unsigned int    chcoef_update         : 1   ; /* [1]  */
        unsigned int    Reserved_124          : 30  ; /* [31..2]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_COEF_UPDATE;

/* Define the union U_CH_COEF_RSEL */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    lhcoef_read_sel       : 1   ; /* [0]  */
        unsigned int    chcoef_read_sel       : 1   ; /* [1]  */
        unsigned int    Reserved_126          : 30  ; /* [31..2]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_COEF_RSEL;

/* Define the union U_CH_LHFIR_CFG */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    ratio                 : 24  ; /* [23..0]  */
        unsigned int    Reserved_127          : 5   ; /* [28..24]  */
        unsigned int    fir_en                : 1   ; /* [29]  */
        unsigned int    mid_en                : 1   ; /* [30]  */
        unsigned int    enable                : 1   ; /* [31]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_LHFIR_CFG;

/* Define the union U_CH_CHFIR_CFG */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    ratio                 : 24  ; /* [23..0]  */
        unsigned int    Reserved_129          : 5   ; /* [28..24]  */
        unsigned int    fir_en                : 1   ; /* [29]  */
        unsigned int    mid_en                : 1   ; /* [30]  */
        unsigned int    enable                : 1   ; /* [31]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_CHFIR_CFG;

/* Define the union U_CH_LHFIR_OFFSET */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    offset                : 28  ; /* [27..0]  */
        unsigned int    Reserved_130          : 4   ; /* [31..28]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_LHFIR_OFFSET;

/* Define the union U_CH_CHFIR_OFFSET */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    offset                : 28  ; /* [27..0]  */
        unsigned int    Reserved_131          : 4   ; /* [31..28]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_CHFIR_OFFSET;

/* Define the union U_CH_LVFIR_CFG */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    ratio                 : 5   ; /* [4..0]  */
        unsigned int    Reserved_132          : 26  ; /* [30..5]  */
        unsigned int    enable                : 1   ; /* [31]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_LVFIR_CFG;

/* Define the union U_CH_CVFIR_CFG */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    ratio                 : 5   ; /* [4..0]  */
        unsigned int    Reserved_133          : 26  ; /* [30..5]  */
        unsigned int    enable                : 1   ; /* [31]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_CVFIR_CFG;

/* Define the union U_CH_LFIR_IN_SIZE */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    width                 : 13  ; /* [12..0]  */
        unsigned int    Reserved_135          : 3   ; /* [15..13]  */
        unsigned int    height                : 13  ; /* [28..16]  */
        unsigned int    Reserved_134          : 3   ; /* [31..29]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_LFIR_IN_SIZE;

/* Define the union U_CH_CFIR_IN_SIZE */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    width                 : 13  ; /* [12..0]  */
        unsigned int    Reserved_138          : 3   ; /* [15..13]  */
        unsigned int    height                : 13  ; /* [28..16]  */
        unsigned int    Reserved_137          : 3   ; /* [31..29]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_CFIR_IN_SIZE;

/* Define the union U_CH_LFIR_OUT_SIZE */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    width                 : 13  ; /* [12..0]  */
        unsigned int    Reserved_140          : 3   ; /* [15..13]  */
        unsigned int    height                : 13  ; /* [28..16]  */
        unsigned int    Reserved_139          : 3   ; /* [31..29]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_LFIR_OUT_SIZE;

/* Define the union U_CH_CFIR_OUT_SIZE */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    width                 : 13  ; /* [12..0]  */
        unsigned int    Reserved_142          : 3   ; /* [15..13]  */
        unsigned int    height                : 13  ; /* [28..16]  */
        unsigned int    Reserved_141          : 3   ; /* [31..29]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_CFIR_OUT_SIZE;

/* Define the union U_CH_VCDS_CFG */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    Reserved_143          : 31  ; /* [30..0]  */
        unsigned int    enable                : 1   ; /* [31]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_VCDS_CFG;

/* Define the union U_CH_VCDS_COEF */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    coef0                 : 5   ; /* [4..0]  */
        unsigned int    Reserved_146          : 11  ; /* [15..5]  */
        unsigned int    coef1                 : 5   ; /* [20..16]  */
        unsigned int    Reserved_145          : 11  ; /* [31..21]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_VCDS_COEF;

/* Define the union U_CH_DITHER_CFG */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    mode                  : 1   ; /* [0]  */
        unsigned int    Reserved_147          : 30  ; /* [30..1]  */
        unsigned int    enable                : 1   ; /* [31]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_DITHER_CFG;

/* Define the union U_CH_CLIP_Y_CFG */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    min                   : 16  ; /* [15..0]  */
        unsigned int    max                   : 16  ; /* [31..16]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_CLIP_Y_CFG;

/* Define the union U_CH_CLIP_C_CFG */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    min                   : 16  ; /* [15..0]  */
        unsigned int    max                   : 16  ; /* [31..16]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_CLIP_C_CFG;

/* Define the union U_CH_LHFIR_COEF0 */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    coef0                 : 10  ; /* [9..0]  */
        unsigned int    coef1                 : 10  ; /* [19..10]  */
        unsigned int    coef2                 : 10  ; /* [29..20]  */
        unsigned int    Reserved_150          : 2   ; /* [31..30]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_LHFIR_COEF0;

/* Define the union U_CH_LHFIR_COEF1 */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    coef3                 : 10  ; /* [9..0]  */
        unsigned int    coef4                 : 10  ; /* [19..10]  */
        unsigned int    coef5                 : 10  ; /* [29..20]  */
        unsigned int    Reserved_152          : 2   ; /* [31..30]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_LHFIR_COEF1;

/* Define the union U_CH_LHFIR_COEF2 */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    coef6                 : 10  ; /* [9..0]  */
        unsigned int    coef7                 : 10  ; /* [19..10]  */
        unsigned int    Reserved_153          : 12  ; /* [31..20]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_LHFIR_COEF2;

/* Define the union U_CH_CHFIR_COEF0 */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    coef0                 : 10  ; /* [9..0]  */
        unsigned int    coef1                 : 10  ; /* [19..10]  */
        unsigned int    coef2                 : 10  ; /* [29..20]  */
        unsigned int    Reserved_154          : 2   ; /* [31..30]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_CHFIR_COEF0;

/* Define the union U_CH_CHFIR_COEF1 */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    coef3                 : 10  ; /* [9..0]  */
        unsigned int    coef4                 : 10  ; /* [19..10]  */
        unsigned int    coef5                 : 10  ; /* [29..20]  */
        unsigned int    Reserved_156          : 2   ; /* [31..30]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_CHFIR_COEF1;

/* Define the union U_CH_CHFIR_COEF2 */
typedef union
{
    /* Define the struct bits */
    struct
    {
        unsigned int    coef6                 : 10  ; /* [9..0]  */
        unsigned int    coef7                 : 10  ; /* [19..10]  */
        unsigned int    Reserved_157          : 12  ; /* [31..20]  */
    } bits;

    /* Define an unsigned member */
    unsigned int    u32;

} U_CH_CHFIR_COEF2;

/* Define the struct CH_LHFIR_COEF_S */
typedef struct
{
    
    U_CH_LHFIR_COEF0 uChLhfirCoef0;
    U_CH_LHFIR_COEF1 uChLhfirCoef1;
    U_CH_LHFIR_COEF2 uChLhfirCoef2;
    unsigned int     Reserved_158;
} CH_LHFIR_COEF_S;

/* Define the struct CH_CHFIR_COEF_S */
typedef struct
{
    
    U_CH_CHFIR_COEF0 uChChfirCoef0;
    U_CH_CHFIR_COEF1 uChChfirCoef1;
    U_CH_CHFIR_COEF2 uChChfirCoef2;
    unsigned int     Reserved_159;
} CH_CHFIR_COEF_S;


//==============================================================================
/* Define the global struct */
typedef struct
{
    U_WK_MODE            WK_MODE;
    unsigned int         Reserved_0[3];
    U_AXI_CFG            AXI_CFG;
    U_MAC_CFG            MAC_CFG;
    unsigned int         Reserved_1[2];
    U_PT_SEL             PT_SEL;
    unsigned int         Reserved_2[3];
    U_CH_SEL             CH_SEL;
    unsigned int         Reserved_3[43];
    U_APB_TIMEOUT        APB_TIMEOUT;
    unsigned int         Reserved_4[3];
    U_VICAP_INT          VICAP_INT;
    unsigned int         Reserved_5;
    U_VICAP_INT_MASK     VICAP_INT_MASK;
    unsigned int         Reserved_6;
    U_PT_INTF_MOD        PT_INTF_MOD;
    unsigned int         Reserved_7[3];
    U_PT_OFFSET0         PT_OFFSET0;
    U_PT_OFFSET1         PT_OFFSET1;
    U_PT_OFFSET2         PT_OFFSET2;
    unsigned int         Reserved_8;
    U_PT_BT656_CFG       PT_BT656_CFG;
    unsigned int         Reserved_9[3];
    U_PT_UNIFY_TIMING_CFG PT_UNIFY_TIMING_CFG;
    U_PT_GEN_TIMING_CFG  PT_GEN_TIMING_CFG;
    unsigned int         Reserved_10[2];
    U_PT_UNIFY_DATA_CFG  PT_UNIFY_DATA_CFG;
    U_PT_GEN_DATA_CFG    PT_GEN_DATA_CFG;
    U_PT_GEN_DATA_COEF   PT_GEN_DATA_COEF;
    U_PT_GEN_DATA_INIT   PT_GEN_DATA_INIT;
    U_PT_YUV444_CFG      PT_YUV444_CFG;
    unsigned int         Reserved_11[3];
    U_PT_FSTART_DLY      PT_FSTART_DLY;
    unsigned int         Reserved_12[7];
    U_PT_INTF_HFB        PT_INTF_HFB;
    U_PT_INTF_HACT       PT_INTF_HACT;
    U_PT_INTF_HBB        PT_INTF_HBB;
    U_PT_INTF_VFB        PT_INTF_VFB;
    U_PT_INTF_VACT       PT_INTF_VACT;
    U_PT_INTF_VBB        PT_INTF_VBB;
    U_PT_INTF_VBFB       PT_INTF_VBFB;
    U_PT_INTF_VBACT      PT_INTF_VBACT;
    U_PT_INTF_VBBB       PT_INTF_VBBB;
    unsigned int         Reserved_13[15];
    U_PT_STATUS          PT_STATUS;
    U_PT_BT656_STATUS    PT_BT656_STATUS;
    unsigned int         Reserved_14;
    U_PT_SIZE            PT_SIZE;
    U_PT_INT             PT_INT;
    unsigned int         Reserved_15;
    U_PT_INT_MASK        PT_INT_MASK;
    unsigned int         Reserved_16[897];
    U_CH_CTRL            CH_CTRL;
    U_CH_REG_NEWER       CH_REG_NEWER;
    unsigned int         Reserved_17[2];
    U_CH_ADAPTER_CFG     CH_ADAPTER_CFG;
    unsigned int         Reserved_18[27];
    U_CH_WCH_Y_CFG       CH_WCH_Y_CFG;
    U_CH_WCH_Y_SIZE      CH_WCH_Y_SIZE;
    unsigned int         Reserved_19[2];
    U_CH_WCH_Y_FADDR     CH_WCH_Y_FADDR;
    U_CH_WCH_Y_HADDR     CH_WCH_Y_HADDR;
    U_CH_WCH_Y_STRIDE    CH_WCH_Y_STRIDE;
    unsigned int         Reserved_20;
    U_CH_WCH_C_CFG       CH_WCH_C_CFG;
    U_CH_WCH_C_SIZE      CH_WCH_C_SIZE;
    unsigned int         Reserved_21[2];
    U_CH_WCH_C_FADDR     CH_WCH_C_FADDR;
    U_CH_WCH_C_HADDR     CH_WCH_C_HADDR;
    U_CH_WCH_C_STRIDE    CH_WCH_C_STRIDE;
    unsigned int         Reserved_22[13];
    U_CH_INT             CH_INT;
    unsigned int         Reserved_23;
    U_CH_INT_MASK        CH_INT_MASK;
    unsigned int         Reserved_24;
    U_CH_CROP_CFG        CH_CROP_CFG;
    U_CH_CROP_WIN        CH_CROP_WIN;
    unsigned int         Reserved_25[2];
    U_CH_CROP0_START     CH_CROP0_START;
    U_CH_CROP0_SIZE      CH_CROP0_SIZE;
    unsigned int         Reserved_26[2];
    U_CH_CROP1_START     CH_CROP1_START;
    U_CH_CROP1_SIZE      CH_CROP1_SIZE;
    unsigned int         Reserved_27[54];
    U_CH_CSC_CFG         CH_CSC_CFG;
    unsigned int         Reserved_28[3];
    U_CH_CSC_COEF0       CH_CSC_COEF0;
    U_CH_CSC_COEF1       CH_CSC_COEF1;
    U_CH_CSC_COEF2       CH_CSC_COEF2;
    U_CH_CSC_COEF3       CH_CSC_COEF3;
    U_CH_CSC_COEF4       CH_CSC_COEF4;
    unsigned int         Reserved_29[3];
    U_CH_CSC_IN_DC0      CH_CSC_IN_DC0;
    U_CH_CSC_IN_DC1      CH_CSC_IN_DC1;
    U_CH_CSC_OUT_DC0     CH_CSC_OUT_DC0;
    U_CH_CSC_OUT_DC1     CH_CSC_OUT_DC1;
    unsigned int         Reserved_30[48];
    U_CH_SKIP_Y_CFG      CH_SKIP_Y_CFG;
    U_CH_SKIP_Y_WIN      CH_SKIP_Y_WIN;
    unsigned int         Reserved_31[2];
    U_CH_SKIP_C_CFG      CH_SKIP_C_CFG;
    U_CH_SKIP_C_WIN      CH_SKIP_C_WIN;
    unsigned int         Reserved_32[58];
    U_CH_COEF_UPDATE     CH_COEF_UPDATE;
    U_CH_COEF_RSEL       CH_COEF_RSEL;
    unsigned int         Reserved_33[2];
    U_CH_LHFIR_CFG       CH_LHFIR_CFG;
    U_CH_CHFIR_CFG       CH_CHFIR_CFG;
    U_CH_LHFIR_OFFSET    CH_LHFIR_OFFSET;
    U_CH_CHFIR_OFFSET    CH_CHFIR_OFFSET;
    U_CH_LVFIR_CFG       CH_LVFIR_CFG;
    U_CH_CVFIR_CFG       CH_CVFIR_CFG;
    unsigned int         Reserved_34[2];
    U_CH_LFIR_IN_SIZE    CH_LFIR_IN_SIZE;
    U_CH_CFIR_IN_SIZE    CH_CFIR_IN_SIZE;
    U_CH_LFIR_OUT_SIZE   CH_LFIR_OUT_SIZE;
    U_CH_CFIR_OUT_SIZE   CH_CFIR_OUT_SIZE;
    unsigned int         Reserved_35[48];
    U_CH_VCDS_CFG        CH_VCDS_CFG;
    U_CH_VCDS_COEF       CH_VCDS_COEF;
    unsigned int         Reserved_36[62];
    U_CH_DITHER_CFG      CH_DITHER_CFG;
    unsigned int         Reserved_37[63];
    U_CH_CLIP_Y_CFG      CH_CLIP_Y_CFG;
    U_CH_CLIP_C_CFG      CH_CLIP_C_CFG;
    unsigned int         Reserved_38[62];
    U_CH_LHFIR_COEF0     CH_LHFIR_COEF0;
    U_CH_LHFIR_COEF1     CH_LHFIR_COEF1;
    U_CH_LHFIR_COEF2     CH_LHFIR_COEF2;
    unsigned int         Reserved_39[125];
    U_CH_CHFIR_COEF0     CH_CHFIR_COEF0;
    U_CH_CHFIR_COEF1     CH_CHFIR_COEF1;
    U_CH_CHFIR_COEF2     CH_CHFIR_COEF2;


} S_vicap_REGS_TYPE;

/* Declare the struct pointor of the module vicap */
extern S_vicap_REGS_TYPE *gopvicapAllReg;

typedef struct
{
    U_WK_MODE            WK_MODE;
    unsigned int         Reserved_0[3];
    U_AXI_CFG            AXI_CFG;
    U_MAC_CFG            MAC_CFG;
    unsigned int         Reserved_1[2];
    U_PT_SEL             PT_SEL;
    unsigned int         Reserved_2[3];
    U_CH_SEL             CH_SEL;
    unsigned int         Reserved_3[43];
    U_APB_TIMEOUT        APB_TIMEOUT;
    unsigned int         Reserved_4[3];
    U_VICAP_INT          VICAP_INT;
    unsigned int         Reserved_5;
    U_VICAP_INT_MASK     VICAP_INT_MASK;
    unsigned int         Reserved_6;  
}VICAP_GLOBAL_REGS_TYPE_S;

typedef struct
{
    U_PT_INTF_MOD        PT_INTF_MOD;
    unsigned int         Reserved_7[3];
    U_PT_OFFSET0         PT_OFFSET0;
    U_PT_OFFSET1         PT_OFFSET1;
    U_PT_OFFSET2         PT_OFFSET2;
    unsigned int         Reserved_8;
    U_PT_BT656_CFG       PT_BT656_CFG;
    unsigned int         Reserved_9[3];
    U_PT_UNIFY_TIMING_CFG PT_UNIFY_TIMING_CFG;
    U_PT_GEN_TIMING_CFG  PT_GEN_TIMING_CFG;
    unsigned int         Reserved_10[2];
    U_PT_UNIFY_DATA_CFG  PT_UNIFY_DATA_CFG;
    U_PT_GEN_DATA_CFG    PT_GEN_DATA_CFG;
    U_PT_GEN_DATA_COEF   PT_GEN_DATA_COEF;
    U_PT_GEN_DATA_INIT   PT_GEN_DATA_INIT;
    U_PT_YUV444_CFG      PT_YUV444_CFG;
    unsigned int         Reserved_11[3];
    U_PT_FSTART_DLY      PT_FSTART_DLY;
    unsigned int         Reserved_12[7];
    U_PT_INTF_HFB        PT_INTF_HFB;
    U_PT_INTF_HACT       PT_INTF_HACT;
    U_PT_INTF_HBB        PT_INTF_HBB;
    U_PT_INTF_VFB        PT_INTF_VFB;
    U_PT_INTF_VACT       PT_INTF_VACT;
    U_PT_INTF_VBB        PT_INTF_VBB;
    U_PT_INTF_VBFB       PT_INTF_VBFB;
    U_PT_INTF_VBACT      PT_INTF_VBACT;
    U_PT_INTF_VBBB       PT_INTF_VBBB;
    unsigned int         Reserved_13[15];
    U_PT_STATUS          PT_STATUS;
    U_PT_BT656_STATUS    PT_BT656_STATUS;
    unsigned int         Reserved_14;
    U_PT_SIZE            PT_SIZE;
    U_PT_INT             PT_INT;
    unsigned int         Reserved_15;
    U_PT_INT_MASK        PT_INT_MASK;
    unsigned int         Reserved_16;
}VICAP_PORT_REGS_TYPE_S;

typedef struct
{
    U_CH_CTRL            CH_CTRL;
    U_CH_REG_NEWER       CH_REG_NEWER;
    unsigned int         Reserved_17[2];
    U_CH_ADAPTER_CFG     CH_ADAPTER_CFG;
    unsigned int         Reserved_18[27];
    U_CH_WCH_Y_CFG       CH_WCH_Y_CFG;
    U_CH_WCH_Y_SIZE      CH_WCH_Y_SIZE;
    unsigned int         Reserved_19[2];
    U_CH_WCH_Y_FADDR     CH_WCH_Y_FADDR;
    U_CH_WCH_Y_HADDR     CH_WCH_Y_HADDR;
    U_CH_WCH_Y_STRIDE    CH_WCH_Y_STRIDE;
    unsigned int         Reserved_20;
    U_CH_WCH_C_CFG       CH_WCH_C_CFG;
    U_CH_WCH_C_SIZE      CH_WCH_C_SIZE;
    unsigned int         Reserved_21[2];
    U_CH_WCH_C_FADDR     CH_WCH_C_FADDR;
    U_CH_WCH_C_HADDR     CH_WCH_C_HADDR;
    U_CH_WCH_C_STRIDE    CH_WCH_C_STRIDE;
    unsigned int         Reserved_22[13];
    U_CH_INT             CH_INT;
    unsigned int         Reserved_23;
    U_CH_INT_MASK        CH_INT_MASK;
    unsigned int         Reserved_24;
    U_CH_CROP_CFG        CH_CROP_CFG;
    U_CH_CROP_WIN        CH_CROP_WIN;
    unsigned int         Reserved_25[2];
    U_CH_CROP0_START     CH_CROP0_START;
    U_CH_CROP0_SIZE      CH_CROP0_SIZE;
    unsigned int         Reserved_26[2];
    U_CH_CROP1_START     CH_CROP1_START;
    U_CH_CROP1_SIZE      CH_CROP1_SIZE;
    unsigned int         Reserved_27[54];
    U_CH_CSC_CFG         CH_CSC_CFG;
    unsigned int         Reserved_28[3];
    U_CH_CSC_COEF0       CH_CSC_COEF0;
    U_CH_CSC_COEF1       CH_CSC_COEF1;
    U_CH_CSC_COEF2       CH_CSC_COEF2;
    U_CH_CSC_COEF3       CH_CSC_COEF3;
    U_CH_CSC_COEF4       CH_CSC_COEF4;
    unsigned int         Reserved_29[3];
    U_CH_CSC_IN_DC0      CH_CSC_IN_DC0;
    U_CH_CSC_IN_DC1      CH_CSC_IN_DC1;
    U_CH_CSC_OUT_DC0     CH_CSC_OUT_DC0;
    U_CH_CSC_OUT_DC1     CH_CSC_OUT_DC1;
    unsigned int         Reserved_30[48];
    U_CH_SKIP_Y_CFG      CH_SKIP_Y_CFG;
    U_CH_SKIP_Y_WIN      CH_SKIP_Y_WIN;
    unsigned int         Reserved_31[2];
    U_CH_SKIP_C_CFG      CH_SKIP_C_CFG;
    U_CH_SKIP_C_WIN      CH_SKIP_C_WIN;
    unsigned int         Reserved_32[58];
    U_CH_COEF_UPDATE     CH_COEF_UPDATE;
    U_CH_COEF_RSEL       CH_COEF_RSEL;
    unsigned int         Reserved_33[2];
    U_CH_LHFIR_CFG       CH_LHFIR_CFG;
    U_CH_CHFIR_CFG       CH_CHFIR_CFG;
    U_CH_LHFIR_OFFSET    CH_LHFIR_OFFSET;
    U_CH_CHFIR_OFFSET    CH_CHFIR_OFFSET;
    U_CH_LVFIR_CFG       CH_LVFIR_CFG;
    U_CH_CVFIR_CFG       CH_CVFIR_CFG;
    unsigned int         Reserved_34[2];
    U_CH_LFIR_IN_SIZE    CH_LFIR_IN_SIZE;
    U_CH_CFIR_IN_SIZE    CH_CFIR_IN_SIZE;
    U_CH_LFIR_OUT_SIZE   CH_LFIR_OUT_SIZE;
    U_CH_CFIR_OUT_SIZE   CH_CFIR_OUT_SIZE;
    unsigned int         Reserved_35[48];
    U_CH_VCDS_CFG        CH_VCDS_CFG;
    U_CH_VCDS_COEF       CH_VCDS_COEF;
    unsigned int         Reserved_36[62];
    U_CH_DITHER_CFG      CH_DITHER_CFG;
    unsigned int         Reserved_37[63];
    U_CH_CLIP_Y_CFG      CH_CLIP_Y_CFG;
    U_CH_CLIP_C_CFG      CH_CLIP_C_CFG;
    unsigned int         Reserved_38[62];
    CH_LHFIR_COEF_S      CH_LHFIR_COEF[17];
    unsigned int         Reserved_39[60];
    CH_CHFIR_COEF_S      CH_CHFIR_COEF[17];
    unsigned int         Reserved_40[316];
}VICAP_CH_REGS_TYPE_S;

typedef struct
{
    unsigned int         Reserved_41[832];

}VICAP_RESERVED_REGS_S;


typedef struct
{
    /*Global regs*/
    VICAP_GLOBAL_REGS_TYPE_S stGlobalReg;
    /*Port regs*/
    VICAP_PORT_REGS_TYPE_S   stPortReg[2];
    /*Reserved regs*/
    VICAP_RESERVED_REGS_S    stReserved;
    /*chn regs*/
    VICAP_CH_REGS_TYPE_S     stChnReg[2];
}VICAP_REGS_TYPE_S;



#endif /* __C_UNION_DEFINE_H__ */

