COMMON_DIR := $(srctree)/drivers/common
MSP_DIR    := $(srctree)/drivers/msp
COMMON_UNF_INCLUDE := $(srctree)/drivers/common/include/
COMMON_API_INCLUDE := $(srctree)/drivers/common/api/include/
COMMON_DRV_INCLUDE := $(srctree)/drivers/common/drv/include/


MSP_UNF_INCLUDE := $(srctree)/drivers/msp/include/
MSP_API_INCLUDE := $(srctree)/drivers/msp/api/include/
MSP_DRV_INCLUDE := $(srctree)/drivers/msp/drv/include/

HI_DRV_BUILDTYPE := y

ifeq ($(CONFIG_ARCH_HI3798MV2X),y)
  CFG_HI_CHIP_TYPE=hi3798mv200
endif

ifeq ($(CONFIG_ARCH_HI3798CV2X),y)
  CFG_HI_CHIP_TYPE=hi3798cv200
endif

CFG_HI_SDK_VERSION="HiSTBLinuxV100R005C00SPC030"

CFG_HI_32BIT_SYSTEM=y
# CFG_HI_64BIT_SYSTEM is not set
CFG_HI_USER_SPACE_LIB=y
# CFG_HI_USER_SPACE_LIB64 is not set
# CFG_HI_USER_SPACE_ALL_LIB is not set
CFG_HI_CPU_ARCH=arm

CFG_HI_SMMU_SUPPORT=y
CFG_HI_HDR_SUPPORT=y
CFG_HI_ETH_SUPPORT=y
CFG_HI_EMMC_SUPPORT=y
CFG_HI_KEYLED_FD650_SELECT=y

CFG_HI_SND_ALSA_AO_SUPPORT=y
CFG_HI_SND_MUTECTL_SUPPORT=y
CFG_HI_SND_MUTECTL_GPIO=0x33
CFG_HI_SND_MUTECTL_LEVEL=0

CFG_HI_DAC_CVBS=0
CFG_HI_VO_VDAC_VIDEO_BUFFER=y

CFG_HI_LOG_SUPPORT=y
CFG_HI_LOG_LEVEL=4
CFG_HI_LOG_NETWORK_SUPPORT=y
CFG_HI_LOG_UDISK_SUPPORT=y
CFG_HI_PROC_SUPPORT=y
CFG_HI_PROC_WRITE_SUPPORT=y

CFG_HI_DEMUX_POOLBUF_SIZE=0x200000


CFG_HI_AI_SUPPORT=y
CFG_HI_ADEC_MAX_INSTANCE=8
CFG_HI_SND_HBRA_PASSTHROUGH_SUPPORT=y


CFG_HI_VIDEO_PRE_CAP_1080P_IN_256=y
CFG_HI_VIDEO_MAX_REF_FRAME_NUM_IN_256=7
CFG_HI_VIDEO_MAX_DISP_FRAME_NUM_IN_256=2
CFG_HI_VIDEO_MAX_VDH_BUF_IN_256=110

CFG_HI_VIDEO_PRE_CAP_4K_IN_512=y
CFG_HI_VIDEO_MAX_REF_FRAME_NUM_IN_512=7
CFG_HI_VIDEO_MAX_DISP_FRAME_NUM_IN_512=4
CFG_HI_VIDEO_MAX_VDH_BUF_IN_512=180

CFG_HI_VIDEO_PRE_CAP_4K_IN_768=y
CFG_HI_VIDEO_MAX_REF_FRAME_NUM_IN_768=5
CFG_HI_VIDEO_MAX_DISP_FRAME_NUM_IN_768=4
CFG_HI_VIDEO_MAX_VDH_BUF_IN_768=180

CFG_HI_VIDEO_PRE_CAP_4K_IN_1024=y
CFG_HI_VIDEO_MAX_REF_FRAME_NUM_IN_1024=5
CFG_HI_VIDEO_MAX_DISP_FRAME_NUM_IN_1024=4
CFG_HI_VIDEO_MAX_VDH_BUF_IN_1024=180

CFG_HI_VIDEO_PRE_CAP_4K_IN_2048=y
CFG_HI_VIDEO_MAX_REF_FRAME_NUM_IN_2048=6
CFG_HI_VIDEO_MAX_DISP_FRAME_NUM_IN_2048=6
CFG_HI_VIDEO_MAX_VDH_BUF_IN_2048=250
CFG_HI_VDEC_DEINTERLACE_SUPPORT=y
CFG_HI_VDEC_REG_CODEC_SUPPORT=y
CFG_HI_VDEC_MJPEG_SUPPORT=y
CFG_HI_VDEC_USERDATA_CC_SUPPORT=y
CFG_HI_VDEC_USERDATA_CC_BUFSIZE=0xC000
CFG_HI_VDEC_DFS_SUPPORT=y

CFG_HI_DISP_TTX_INBUFFERSIZE=0x4000
CFG_HI_DISP_CC_INBUFFERSIZE=0x4000
CFG_HI_PQ_V4_0=y

CFG_HI_VPSS_MAX_BUFFER_NUMB=6


# HDMI Config
#
CFG_HI_HDMI_SUPPORT_2_0=y
CFG_HI_HDMI_SUPPORT_HDCP=y
CFG_HI_HDMI_SUPPORT_CEC=y
# CFG_HI_HDMI_SUPPORT_DEBUG is not set
CFG_HI_HDMI_DEBUG_MEM_SIZE=0x80000

#
# Graphic Config
#
# CFG_HI_DIRECTFB_SUPPORT is not set
# CFG_HI_FB0_SMMU_SUPPORT is not set
CFG_HI_FB=y
CFG_HI_FB1_SMMU_SUPPORT=y
CFG_HI_FB2_SMMU_SUPPORT=y
CFG_HIFB_STEREO3D_SUPPORT=y
# CFG_HIFB_SCROLLTEXT_SUPPORT is not set
CFG_HI_FB_DECOMPRESS_SUPPORT=y
# CFG_HI_GFX_DEBUG_LOG_SUPPORT is not set
CFG_HI_TDE_CSCTMPBUFFER_SIZE=0x0
CFG_HI_JPEG6B_STREAMBUFFER_SIZE=0x100000
CFG_HI_HD0_FB_VRAM_SIZE=40500
CFG_HI_HD1_FB_VRAM_SIZE=0
CFG_HI_HD2_FB_VRAM_SIZE=0
CFG_HI_SD0_FB_VRAM_SIZE=2430

#
# GPU Config
#
CFG_HI_GPU=y
CFG_HI_GPU_SUPPORT=y
ifeq ($(CONFIG_ARCH_HI3798CV2X),y)
  CFG_HI_GPU_MALI700_SUPPORT=y
else ifeq ($(CONFIG_ARCH_HI3798MV2X),y)
  CFG_HI_GPU_MALI450_SUPPORT=y
else
  CFG_HI_GPU_MALI400_SUPPORT=y
endif
# CFG_HI_GPU_DEBUG is not set
CFG_HI_GPU_PROFILING=y
# CFG_HI_GPU_INTERNAL_PROFILING is not set
CFG_HI_GPU_MAX_SHARE_MEM_SIZE=0x20000000
# CFG_EGL_HIGO is not set
CFG_EGL_FB=y
# CFG_EGL_DFB is not set
CFG_HI_EGL_TYPE=fb

#
# IR Config
#
CFG_HI_IR_TYPE_S2=y
CFG_HI_IR_NEC_SUPPORT=y
CFG_HI_IR_RC6_SUPPORT=y
CFG_HI_IR_RC5_SUPPORT=y
CFG_HI_IR_SONY_SUPPORT=y
CFG_HI_IR_TC9012_SUPPORT=y

#
# Keyled Config
#
CFG_HI_KEYLED_SUPPORT=y
# CFG_HI_KEYLED_74HC164_SUPPORT is not set
# CFG_HI_KEYLED_GPIOKEY_SUPPORT is not set
# CFG_HI_KEYLED_GPIOKEY_POWER_GPIO is not set
# CFG_HI_KEYLED_GPIOKEY_OK_GPIO is not set
# CFG_HI_KEYLED_GPIOKEY_MENU_GPIO is not set
# CFG_HI_KEYLED_GPIOKEY_LEFT_GPIO is not set
# CFG_HI_KEYLED_GPIOKEY_RIGHT_GPIO is not set
# CFG_HI_KEYLED_GPIOKEY_UP_GPIO is not set
# CFG_HI_KEYLED_GPIOKEY_DOWN_GPIO is not set
# CFG_HI_KEYLED_CT1642_SUPPORT is not set
# CFG_HI_KEYLED_CT1642_GPIO_MODE is not set
# CFG_HI_KEYLED_PT6961_SUPPORT is not set
# CFG_HI_KEYLED_PT6961_CLOCK_GPIO is not set
# CFG_HI_KEYLED_PT6961_STB_GPIO is not set
# CFG_HI_KEYLED_PT6961_DIN_GPIO is not set
# CFG_HI_KEYLED_PT6961_DOUT_GPIO is not set
# CFG_HI_KEYLED_PT6964_SUPPORT is not set
# CFG_HI_KEYLED_PT6964_CLOCK_GPIO is not set
# CFG_HI_KEYLED_PT6964_STB_GPIO is not set
# CFG_HI_KEYLED_PT6964_DINOUT_GPIO is not set
CFG_HI_KEYLED_FD650_SUPPORT=y
CFG_HI_KEYLED_FD650_CLOCK_GPIO=0x28
CFG_HI_KEYLED_FD650_DINOUT_GPIO=0x29

#
# PowerManagement Config
#
CFG_HI_DVFS_CPU_SUPPORT=y
CFG_HI_DVFS_CORE_SUPPORT=y
CFG_HI_DVFS_GPU_SUPPORT=y
CFG_HI_AVS_SUPPORT=y
# CFG_HI_DONGLE_CONFIG is not set
# CFG_HI_PM_POWERUP_MODE1_SUPPORT is not set
CFG_HI_TEMP_CTRL_CONFIG=y
CFG_HI_TEMP_CTRL_DOWN_THRESHOLD=0x73
CFG_HI_TEMP_CTRL_UP_THRESHOLD=0x64
CFG_HI_TEMP_CTRL_REBOOT_THRESHOLD=0x7d
# CFG_HI_MCE_SUPPORT is not set

#
# SCI Config
#
CFG_HI_SCI_SUPPORT=y

CFG_HI_VI_SUPPORT=y
CFG_HI_VENC_SUPPORT=y
CFG_HI_AENC_SUPPORT=y

CFG_HI_GPIOI2C_SUPPORT=y
CFG_HI_FRONTEND_SUPPORT=y
CFG_HI_DEMOD_TYPE_FC8300=y
CFG_HI_DEMOD_TYPE_GX1132=y
CFG_HI_DEMOD_TYPE_HI3136=y
ifeq ($(CFG_HI_GPIOI2C_SUPPORT),y)
  CFG_HI_DEMOD_TYPE_HI3137=y
  CFG_HI_TUNER_TYPE_MXL608=y
endif
CFG_HI_DEMOD_TYPE_MXL254=y
CFG_HI_DEMOD_TYPE_MXL683=y
CFG_HI_TUNER_TYPE_MXL683=y
CFG_HI_TUNER_TYPE_AV2011=y
CFG_HI_DISEQC_SUPPORT=y
CFG_HI_LNB_CTRL_ISL9492=y
CFG_HI_LNB_CTRL_MPS8125=y

CFG_HI_KMOD_CFLAGS := -Wno-format-extra-args
#CFG_HI_KMOD_CFLAGS := -Werror
CFG_HI_KMOD_CFLAGS += -DCHIP_TYPE_$(CFG_HI_CHIP_TYPE) -DSDK_VERSION=$(CFG_HI_SDK_VERSION)

ifeq ($(findstring fpga, $(CFG_HI_BOOT_REG_NAME)), fpga)
CFG_HI_KMOD_CFLAGS += -DHI_FPGA_SUPPORT
endif

ifeq ($(CFG_HI_SMMU_SUPPORT),y)
CFG_HI_KMOD_CFLAGS += -DHI_SMMU_SUPPORT
endif

ifeq ($(CFG_HI_HDR_SUPPORT),y)
CFG_HI_KMOD_CFLAGS += -DHI_HDR_SUPPORT
endif

ifeq ($(CFG_HI_KEYLED_CT1642_KERNEL_SUPPORT),y)
CFG_HI_KMOD_CFLAGS += -DHI_KEYLED_CT1642_KERNEL_SUPPORT
endif

ifeq ($(CFG_HI_MCE_SUPPORT),y)
CFG_HI_KMOD_CFLAGS += -DHI_MCE_SUPPORT
endif

ifeq ($(CFG_HI_GPIOI2C_SUPPORT),y)
CFG_HI_KMOD_CFLAGS += -DHI_GPIOI2C_SUPPORT
endif

## common and other modules will use hi_debug.h, which refers to the HI_LOG_LEVEL
ifeq ($(CFG_HI_LOG_SUPPORT),y)
CFG_HI_KMOD_CFLAGS += -DHI_LOG_SUPPORT=1
ifdef CFG_HI_LOG_LEVEL
CFG_HI_KMOD_CFLAGS += -DHI_LOG_LEVEL=$(CFG_HI_LOG_LEVEL)
else
CFG_HI_KMOD_CFLAGS += -DHI_LOG_LEVEL=1
endif
else
CFG_HI_KMOD_CFLAGS += -DHI_LOG_SUPPORT=0
endif
ifeq ($(CFG_HI_PROC_SUPPORT),y)
CFG_HI_KMOD_CFLAGS += -DHI_PROC_SUPPORT=1
else
CFG_HI_KMOD_CFLAGS += -DHI_PROC_SUPPORT=0
endif

ifeq ($(CFG_HI_HDMI_SUPPORT_1_4),y)
CFG_HI_KMOD_CFLAGS += -DHI_HDMI_SUPPORT_1_4
else ifeq ($(CFG_HI_HDMI_SUPPORT_2_0),y)
CFG_HI_KMOD_CFLAGS += -DHI_HDMI_SUPPORT_2_0
endif

ifeq ($(CFG_HI_GFX2D_SUPPORT),y)
CFG_HI_KMOD_CFLAGS += -DHI_GFX2D_SUPPORT
endif

ifeq ($(CFG_HI_LOADER_APPLOADER),y)
CFG_HI_KMOD_CFLAGS += -DHI_LOADER_APPLOADER
endif

ifeq ($(CFG_HI_KEYLED_SUPPORT),y)
CFG_HI_KMOD_CFLAGS += -DHI_KEYLED_SUPPORT
endif

ifeq ($(CFG_HI_HDMI_SUPPORT_HDCP),y)
CFG_HI_KMOD_CFLAGS += -DHI_HDCP_SUPPORT
endif

ifeq ($(CFG_HI_SCI_SUPPORT),y)
CFG_HI_KMOD_CFLAGS += -DHI_SCI_SUPPORT
endif

ifeq ($(CFG_HI_PVR_SUPPORT),y)
CFG_HI_KMOD_CFLAGS += -DHI_PVR_SUPPORT
endif

ifeq ($(CFG_HI_VI_SUPPORT),y)
CFG_HI_KMOD_CFLAGS += -DHI_VI_SUPPORT
endif

ifeq ($(CFG_HI_VENC_SUPPORT),y)
CFG_HI_KMOD_CFLAGS += -DHI_VENC_SUPPORT
endif

ifeq ($(CFG_HI_AENC_SUPPORT),y)
CFG_HI_KMOD_CFLAGS += -DHI_AENC_SUPPORT
endif

ifeq ($(CFG_HI_ADAC_SLIC_SUPPORT),y)
CFG_HI_KMOD_CFLAGS += -DHI_ADAC_SLIC_SUPPORT
endif

ifeq ($(CFG_HI_PQ_V3_0),y)
CFG_HI_KMOD_CFLAGS += -DHI_PQ_V3_0
endif

ifeq ($(CFG_HI_PQ_V4_0),y)
CFG_HI_KMOD_CFLAGS += -DHI_PQ_V4_0
endif


