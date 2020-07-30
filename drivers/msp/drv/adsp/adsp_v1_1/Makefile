#===============================================================================
# export variables
#===============================================================================
ifeq ($(CFG_HI_EXPORT_FLAG),)
    ifneq ($(srctree),)
    KERNEL_DIR := $(srctree)

    SDK_DIR := $(shell cd $(KERNEL_DIR) && /bin/pwd)
    else
    SDK_DIR := $(shell cd $(CURDIR)/../../../../.. && /bin/pwd)
    endif

    include $(SDK_DIR)/base.mak
endif

#===============================================================================
# local variables
#===============================================================================
ADSP_DRV_INCLUDE    := $(MSP_DIR)/drv/adsp/adsp_v1_1/include
# ADSP_DRV_INCLUDE_1  := $(MSP_DIR)/drv/adsp/adsp_v1_1/include/comp
# HA_CODEC_INCLUDE    := $(COMPONENT_DIR)/ha_codec/include

# CFG_HI_SND_AFLT_SUPPORT := y

#===============================================================================
# Tensilica Audio Lib
#===============================================================================
# ADSP_XA_INCLUDE    =$(SDK_DIR)/drivers/msp/drv/adsp/adsp_v1_1/hifi/component/external/xtensa/include
# ADSP_XA_MP3DEC_INC =$(SDK_DIR)/drivers/msp/drv/adsp/adsp_v1_1/hifi/component/external/xtensa/mp3_dec/ulibxa_mp3_dec/include

EXTRA_CFLAGS += $(CFG_HI_KMOD_CFLAGS)

EXTRA_CFLAGS += -I$(COMMON_UNF_INCLUDE)   \
                -I$(COMMON_API_INCLUDE)   \
                -I$(COMMON_DRV_INCLUDE)   \
                -I$(MSP_UNF_INCLUDE)      \
                -I$(MSP_API_INCLUDE)      \
                -I$(MSP_DRV_INCLUDE)      \
                -I$(ADSP_DRV_INCLUDE)

ifeq ($(CFG_HI_SND_AFLT_SUPPORT),y)
HA_EFFECT_INCLUDE := $(COMPONENT_DIR)/ha_effect/include
EXTRA_CFLAGS += -I$(HA_EFFECT_INCLUDE)
endif

##just for TQE test for hw aoe
# CFG_TQE_FOR_SND_AOE_HW_SUPPORT = Y

ifeq ($(CFG_HI_SND_AOE_HW_SUPPORT),y)
# CFG_DSP_COMPILER_SUPPORT = y
endif

ifneq ($(CFG_HI_SND_AOE_HW_SUPPORT),y)
#simulate support

ifneq ($(findstring $(CFG_HI_CHIP_TYPE), hi3796mv100 hi3798mv100),)
HIFIDIR := ./hifi/Hi3798MV100/arm-histbv310-linux
else ifneq ($(findstring $(CFG_HI_CHIP_TYPE), hi3716mv410 hi3716mv420),)
ifdef CFG_HI_ADVCA_FUNCTION
HIFIDIR := ./hifi/Hi3716MV410/arm-histbv310-linux_advca
else
HIFIDIR := ./hifi/Hi3716MV410/arm-histbv310-linux
endif
else ifneq ($(findstring $(CFG_HI_CHIP_TYPE), hi3798cv200),)
HIFIDIR := ./hifi/Hi3798CV200/arm-histbv310-linux
endif

EXTRA_CFLAGS +=  \
		-I$(MSP_DIR)/drv/adsp/adsp_v1_1/$(HIFIDIR)/common/include \
		-I$(MSP_DIR)/drv/adsp/adsp_v1_1/$(HIFIDIR)/aoe/include \
		-I$(MSP_DIR)/drv/adsp/adsp_v1_1/$(HIFIDIR)/aflt/include \
		-I$(MSP_DIR)/drv/adsp/adsp_v1_1/$(HIFIDIR)/aoe/src/include \
		-I$(MSP_DIR)/drv/adsp/adsp_v1_1/$(HIFIDIR)/component/codec/iapcm_dec \
		-I$(MSP_DIR)/drv/adsp/adsp_v1_1/$(HIFIDIR)/component/codec/iamp3_dec \
		-I$(MSP_DIR)/drv/adsp/adsp_v1_1/$(HIFIDIR)/component/effect/base_effect\
		-I$(MSP_DIR)/drv/adsp/adsp_v1_1

ifeq ($(CFG_TQE_FOR_SND_AOE_HW_SUPPORT),y)
EXTRA_CFLAGS +=  \
		-I$(MSP_DIR)/drv/adsp/adsp_v1_1/$(HIFIDIR)/component/external/xtensa/resampler/ulibxa_resampler/include/resampler \
		-I$(MSP_DIR)/drv/adsp/adsp_v1_1/$(HIFIDIR)/component/external/xtensa/include
endif

ifeq ($(CFG_HI_CPU_ARCH),arm)
ASRC_DIR := $(MSP_DIR)/drv/adsp/adsp_v1_1/external/ASRC_ARM
EXTRA_CFLAGS += -I$(ASRC_DIR)/inc
EXTRA_CFLAGS += -DHI_SND_IMEDIA_SRC_SUPPORT
endif
EXTRA_CFLAGS += -DHI_SND_AOE_SWSIMULATE_SUPPORT

else
EXTRA_CFLAGS += -DHI_SND_DSP_HW_SUPPORT
endif

ifeq ($(CFG_HI_SND_USER_AEF_SUPPORT),y)
EXTRA_CFLAGS += -DHI_SND_USER_AEF_SUPPORT
endif

EXTRA_CFLAGS += -DINTERLEAVED_OUTPUT

# EXTRA_CFLAGS += -DPCM_DECODER_SUPPORT
#only use debug for mp3 decoder
# EXTRA_CFLAGS += -DMP3_DECODER_SUPPORT

ifeq ($(CFG_HI_SND_AFLT_SUPPORT),y)
EXTRA_CFLAGS += -DHI_SND_AFLT_SWSIMULATE_SUPPORT
EXTRA_CFLAGS += -DBASE_EFFECT_SUPPORT
EXTRA_CFLAGS += -DHI_SND_AFLT_SUPPORT
endif
EXTRA_CFLAGS += -DHI_SND_TIMER_CAST

ifneq ($(findstring $(CFG_HI_CHIP_TYPE), hi3716cv200 hi3716mv400 hi3718cv100 hi3719cv100 hi3718mv100 hi3719mv100 hi3798mv100 hi3796mv100),)
LSP_HIFI = RD4_HIFI3_3_LSP
endif

ifneq ($(findstring $(CFG_HI_CHIP_TYPE), hi3796cv100 hi3798cv100),)
EXTRA_CFLAGS += -DADSP_SELLECT_DSP1
LSP_HIFI = RD5_HIFI3_3_LSP
endif

ifeq ($(CFG_HI_CHIP_TYPE),hi3751v100)
#EXTRA_CFLAGS += -DADSP_SELLECT_DSP0
#LSP_HIFI = RD5_HIFI3_4_LSP
EXTRA_CFLAGS += -DADSP_SELLECT_DSP1
LSP_HIFI = RD5_HIFI3_3_LSP
endif

KBUILD_EXTRA_SYMBOLS += $(COMMON_DIR)/drv/Module.symvers

MOD_NAME := hi_adsp

obj-$(HI_DRV_BUILDTYPE) += $(MOD_NAME).o

$(MOD_NAME)-y   := drv_adsp_intf.o drv_adsp.o

ifneq ($(CFG_HI_SND_AOE_HW_SUPPORT),y)
#simulate support
$(MOD_NAME)-y += $(HIFIDIR)/common/linear/linear.o
$(MOD_NAME)-y += $(HIFIDIR)/common/mem/dsp_mem.o
ifeq ($(CFG_TQE_FOR_SND_AOE_HW_SUPPORT),y)
$(MOD_NAME)-y += $(HIFIDIR)/component/resampler/xa_resampler_error_handler.o
$(MOD_NAME)-y += $(HIFIDIR)/component/resampler/xa_resampler.o
endif
$(MOD_NAME)-y += $(HIFIDIR)/common/resampler/resample_rom.o
$(MOD_NAME)-y += $(HIFIDIR)/common/resampler/resample.o
$(MOD_NAME)-y += $(HIFIDIR)/common/util/dsp_util.o
$(MOD_NAME)-y += $(HIFIDIR)/common/ringbuf/dsp_ringbuf.o
$(MOD_NAME)-y += $(HIFIDIR)/common/basicop/basicop.o
$(MOD_NAME)-y += $(HIFIDIR)/common/timer/system_timer.o

$(MOD_NAME)-y += $(HIFIDIR)/sw_main.o
$(MOD_NAME)-y += $(HIFIDIR)/aoe/src/aop/aoe_aop.o
$(MOD_NAME)-y += $(HIFIDIR)/aoe/src/aop/aoe_cast.o
$(MOD_NAME)-y += $(HIFIDIR)/aoe/src/aip/aoe_aip.o
$(MOD_NAME)-y += $(HIFIDIR)/aoe/src/engine/aoe_engine.o
$(MOD_NAME)-y += $(HIFIDIR)/aoe/src/aoe_main.o
$(MOD_NAME)-y += $(HIFIDIR)/aoe/src/aoe_reg.o

ifeq ($(CFG_HI_SND_AFLT_SUPPORT),y)
$(MOD_NAME)-y += $(HIFIDIR)/aflt/src/aflt_main.o                             \
                 $(HIFIDIR)/aflt/src/aflt_func.o                             \
                 $(HIFIDIR)/component/codec/iapcm_dec/iapcm_dec.o            \
                 $(HIFIDIR)/component/codec/iapcm_dec/iapcm_dec_comp.o       \
                 $(HIFIDIR)/component/effect/base_effect/base_effect_comp.o  \
                 $(HIFIDIR)/component/effect/base_effect/base_effect_volume.o
endif

#only use debug for mp3 decoder
#$(MOD_NAME)-y+= $(HIFIDIR)/component/codec/iamp3_dec/comp_mp3dec_wrap.o       \
                $(HIFIDIR)/component/codec/iamp3_dec/mp3_decoder.o            \
                $(HIFIDIR)/component/codec/iamp3_dec/bits_op.o                \
                $(HIFIDIR)/component/codec/iamp3_dec/dct_core.o               \
                $(HIFIDIR)/component/codec/iamp3_dec/memory_op.o              \
                $(HIFIDIR)/component/codec/iamp3_dec/dequant.o                \
                $(HIFIDIR)/component/codec/iamp3_dec/huffman.o                \
                $(HIFIDIR)/component/codec/iamp3_dec/huffman_rom.o            \
                $(HIFIDIR)/component/codec/iamp3_dec/dec_layer12_sample.o     \
                $(HIFIDIR)/component/codec/iamp3_dec/imdct.o                  \
                $(HIFIDIR)/component/codec/iamp3_dec/mp3_rom.o                \
                $(HIFIDIR)/component/codec/iamp3_dec/data_decode.o            \
                $(HIFIDIR)/component/codec/iamp3_dec/stereo.o                 \
                $(HIFIDIR)/component/codec/iamp3_dec/synthesis.o              \
                $(HIFIDIR)/component/codec/iamp3_dec/trig_rom.o               \
                $(HIFIDIR)/component/codec/iamp3_dec/armgcc/asmpoly_gcc.o

else
$(MOD_NAME)-y += kfile_ops_func.o dsp_elf_func.o
endif

ifeq ($(O),)
ADSP_EXT_LIB_DIR := $(ASRC_DIR)/lib
else
ADSP_EXT_LIB_DIR := $(O)/drivers/msp/adsp/adsp_v1_1/external/ASRC_ARM/lib
endif

ifeq ($(CFG_HI_CPU_ARCH),arm)
$(shell mkdir -p $(ADSP_EXT_LIB_DIR))
$(shell cp $(ASRC_DIR)/lib/libimedia_asrc_arma9.lib $(ADSP_EXT_LIB_DIR)/libimedia_asrc_arma9.a)

$(MOD_NAME)-y += ./external/ASRC_ARM/lib/libimedia_asrc_arma9.a
endif

REMOVED_FILES := "*.o" "*.ko" "*.a" "*.order" "*.symvers" "*.mod" "*.mod.*" "*.cmd" ".tmp_versions" "modules.builtin"

#===============================================================================
#   rules
#===============================================================================
.PHONY: all clean install uninstall

all:
	$(AT)make -C $(LINUX_DIR) ARCH=$(CFG_HI_CPU_ARCH) CROSS_COMPILE=$(HI_KERNEL_TOOLCHAINS_NAME)- M=$(CURDIR) modules

clean:
	$(AT)find ./ -name "*.d" $(foreach file, $(REMOVED_FILES), -o -name $(file)) | xargs rm -rf

install: all
	$(AT)cp -f $(CURDIR)/$(MOD_NAME).ko $(HI_MODULE_DIR)/

uninstall:
	$(AT)rm -rf $(HI_MODULE_DIR)/$(MOD_NAME).ko
