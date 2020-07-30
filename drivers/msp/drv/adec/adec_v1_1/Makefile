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
MP3DEC_DIR = $(MSP_DIR)/drv/adec/adec_v1_1/mp3dec

EXTRA_CFLAGS += $(CFG_HI_KMOD_CFLAGS)
EXTRA_CFLAGS += -I$(COMMON_UNF_INCLUDE)                 \
                -I$(COMMON_API_INCLUDE)                 \
                -I$(COMMON_DRV_INCLUDE)                 \
                -I$(MSP_UNF_INCLUDE)                    \
                -I$(MSP_API_INCLUDE)                    \
                -I$(MSP_DRV_INCLUDE)                    \
                -I$(MP3DEC_DIR)

EXTRA_CFLAGS += -DHI_ADEC_MAX_INSTANCE=$(CFG_HI_ADEC_MAX_INSTANCE)

KBUILD_EXTRA_SYMBOLS += $(COMMON_DIR)/drv/Module.symvers
EXTRA_CFLAGS += -DINTERLEAVED_OUTPUT
ifeq (y,$(CFG_HI_MCE_SUPPORT))
EXTRA_CFLAGS += -DHI_MCE_SUPPORT
endif

HI_DRV_DIR := $(MSP_DIR)/drv

MOD_NAME := hi_adec

obj-$(HI_DRV_BUILDTYPE) += $(MOD_NAME).o

$(MOD_NAME)-y   :=  drv_adec.o drv_adec_k.o

ifeq ($(CFG_HI_MCE_SUPPORT),y)
$(MOD_NAME)-y+= ./mp3dec/ha_mp3dec_wrap.o         \
                ./mp3dec/mp3_decoder.o            \
                ./mp3dec/bits_op.o                \
                ./mp3dec/dct_core.o               \
                ./mp3dec/memory_op.o              \
                ./mp3dec/dequant.o                \
                ./mp3dec/huffman.o                \
                ./mp3dec/huffman_rom.o            \
                ./mp3dec/dec_layer12_sample.o     \
                ./mp3dec/imdct.o                  \
                ./mp3dec/mp3_rom.o                \
                ./mp3dec/data_decode.o            \
                ./mp3dec/stereo.o                 \
                ./mp3dec/synthesis.o              \
                ./mp3dec/trig_rom.o               \
                ./mp3dec/armgcc/asmpoly_gcc.o
endif

REMOVED_FILES := "*.o" "*.ko" "*.order" "*.symvers" "*.mod" "*.mod.*" "*.cmd" ".tmp_versions" "modules.builtin"

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

