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
# export variables
#===============================================================================
EXTRA_CFLAGS += -DENV_ARMLINUX_KERNEL

ifeq ($(CFG_HI_CHIP_TYPE), hi3798cv200)
VFMW_DIR := $(MSP_DIR)/drv/vfmw/vfmw_v5.0
else
VFMW_DIR := $(MSP_DIR)/drv/vfmw/vfmw_v4.0
endif

SDEC_KO_DIR   := $(MSP_DIR)/drv/vfmw/softlib

################################################
ifneq ($(findstring $(CFG_HI_CHIP_TYPE), hi3716cv200 hi3716mv400 hi3718cv100 hi3719cv100 hi3718mv100 hi3719mv100),)
include $(VFMW_DIR)/firmware/product/Hi3716CV200/HD_FULL/vfmw_make.cfg
endif

ifneq ($(findstring $(CFG_HI_CHIP_TYPE), hi3798mv100 hi3796mv100),)
include $(VFMW_DIR)/firmware/product/Hi3798MV100/HD_FULL/vfmw_make.cfg
endif

ifneq ($(findstring $(CFG_HI_CHIP_TYPE), hi3716mv410 hi3716mv420),)
include $(VFMW_DIR)/firmware/product/Hi3716MV410/HD_FULL/vfmw_make.cfg
endif

ifneq ($(findstring $(CFG_HI_CHIP_TYPE), hi3751v100),)
include $(VFMW_DIR)/firmware/product/HiS5V100/HD_FULL/vfmw_make.cfg
endif

ifneq ($(findstring $(CFG_HI_CHIP_TYPE), hi3751v200),)
include $(VFMW_DIR)/firmware/product/HiS5V200/HD_FULL/vfmw_make.cfg
endif

ifeq ($(CFG_HI_CHIP_TYPE), hi3798cv200)
include $(VFMW_DIR)/firmware/product/Hi3798CV200/HD_FULL/vfmw_make.cfg
endif

export HWMEDIA_DIR = $(SDEC_KO_DIR)/hwmedia_v1.1

EXTRA_CFLAGS += $(CFG_HI_KMOD_CFLAGS)

EXTRA_CFLAGS += -I$(COMMON_UNF_INCLUDE) \
                -I$(COMMON_API_INCLUDE) \
                -I$(COMMON_DRV_INCLUDE)

EXTRA_CFLAGS += $(VFMW_CFLAGS)
EXTRA_CFLAGS += -I$(SDEC_KO_DIR)

KBUILD_EXTRA_SYMBOLS += $(COMMON_DIR)/drv/Module.symvers

####################################### objects #####################################
obj-y += hwmedia_v1.1/

MOD_NAME := hi_svdec

obj-$(HI_DRV_BUILDTYPE) += $(MOD_NAME).o

#1. ko interface
hi_svdec-y += ./sdec_imedia_intf.o

# 2. soft decoder
hi_svdec-y += ./sdec_imedia.o
ifneq ($(HI_DRV_BUILDTYPE),y)
hi_svdec-y += ./hwmedia_v1.1/hwmedia.o
endif

REMOVED_FILES := "*.o" "*.ko" "*.order" "*.symvers" "*.mod" "*.mod.*" "*.cmd" ".tmp_versions" "modules.builtin"

all:
	$(AT)make -C $(HWMEDIA_DIR) ARCH=$(CFG_HI_CPU_ARCH)
	$(AT)make -C $(LINUX_DIR) ARCH=$(CFG_HI_CPU_ARCH) CROSS_COMPILE=$(HI_KERNEL_TOOLCHAINS_NAME)- M=$(CURDIR) modules

clean:
	$(AT)make -C $(HWMEDIA_DIR) clean
	$(AT)find ./ -name "*.d" $(foreach file, $(REMOVED_FILES), -o -name $(file)) | xargs rm -rf

install: all
	$(AT)cp -f $(MOD_NAME).ko $(HI_MODULE_DIR)/

uninstall:
	$(AT)rm -rf $(HI_MODULE_DIR)/$(MOD_NAME).ko
