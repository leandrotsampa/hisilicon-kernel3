#===============================================================================
# export variables
#===============================================================================
ifeq ($(CFG_HI_EXPORT_FLAG),)
    ifneq ($(srctree),)
    KERNEL_DIR := $(srctree)

    SDK_DIR := $(shell cd $(KERNEL_DIR) && /bin/pwd)
    else
    SDK_DIR := $(shell cd $(CURDIR)/../../../.. && /bin/pwd)
    endif

    include $(SDK_DIR)/base.mak
endif

#===============================================================================
# local variables
#===============================================================================
EXTRA_CFLAGS += $(CFG_HI_KMOD_CFLAGS)

EXTRA_CFLAGS += -I$(COMMON_UNF_INCLUDE)                 \
                -I$(COMMON_API_INCLUDE)                 \
                -I$(COMMON_DRV_INCLUDE)                 \
                -I$(MSP_UNF_INCLUDE)                    \
                -I$(MSP_DRV_INCLUDE)

EXTRA_CFLAGS += -DHI_SND_AMP_TYPE_TAS5707

ifeq ($(CFG_HI_SND_AMP_TYPE_TAS5711),y)
EXTRA_CFLAGS += -DHI_SND_AMP_TYPE_TAS5711
endif

ifeq ($(FG_HI_SND_AMP_I2C),y)
EXTRA_CFLAGS += -DHI_SND_AMP_I2C=$(CFG_HI_SND_AMP_I2C)
endif

KBUILD_EXTRA_SYMBOLS += $(COMMON_DIR)/drv/Module.symvers
MOD_NAME := hi_amp

obj-$(HI_DRV_BUILDTYPE) += $(MOD_NAME).o

$(MOD_NAME)-y   :=  drv_amp_intf.o        \
		drv_amp.o

$(MOD_NAME)-y += amp_i2s_tas5707.o

#ifeq ($(CFG_HI_SND_AMP_TYPE_TAS5711),y)
$(MOD_NAME)-y += amp_i2s_tas5711.o
#endif

$(MOD_NAME)-y += amp_i2s_ntp8214.o

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
