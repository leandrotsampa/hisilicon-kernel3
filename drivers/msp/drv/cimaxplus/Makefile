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
EXTRA_CFLAGS += -I$(COMMON_UNF_INCLUDE)                 \
                -I$(COMMON_API_INCLUDE)                 \
                -I$(COMMON_DRV_INCLUDE)                 \
                -I$(MSP_UNF_INCLUDE)                    \
                -I$(MSP_DRV_INCLUDE)                    \
                -I$(MSP_DIR)/drv/cimaxplus

EXTRA_CFLAGS += $(CFG_HI_KMOD_CFLAGS)

KBUILD_EXTRA_SYMBOLS += $(COMMON_DIR)/drv/Module.symvers

MOD_NAME := hi_cimaxplus

obj-$(HI_DRV_BUILDTYPE) += $(MOD_NAME).o

$(MOD_NAME)-y := cimaxplus_usb-driver.o cimaxplus_usb_fw.o
$(MOD_NAME)-y += cimaxplus_usb_config.o
$(MOD_NAME)-y += cimaxplus_usb_time.o

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
	$(AT)mkdir -p $(HI_ROOTFS_DIR)/lib/firmware
	$(AT)cp -f $(CURDIR)/*.cfg $(HI_ROOTFS_DIR)/lib/firmware
	$(AT)cp -f $(CURDIR)/*.bin $(HI_ROOTFS_DIR)/lib/firmware
	$(AT)mkdir -p $(HI_ROOTFS_DIR)/etc/udev/rules.d
	$(AT)cp -f $(CURDIR)/*.rules $(HI_ROOTFS_DIR)/etc/udev/rules.d/

uninstall:
	$(AT)rm -rf $(HI_MODULE_DIR)/$(MOD_NAME).ko
	$(AT)rm -rf $(HI_ROOTFS_DIR)/lib/firmware/cimax+usb.cfg
	$(AT)rm -rf $(HI_ROOTFS_DIR)/lib/firmware/cimax+_usbdvb.bin
	$(AT)rm -rf $(HI_ROOTFS_DIR)/etc/udev/rules.d/95-cimax+usb.rules
