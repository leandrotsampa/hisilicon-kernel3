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
                -I$(MSP_DIR)/drv/ci                     \
                -I$(MSP_DIR)/api/gpio                   \
                -I$(MSP_DIR)/drv/gpio

EXTRA_CFLAGS += $(CFG_HI_KMOD_CFLAGS)

KBUILD_EXTRA_SYMBOLS += $(COMMON_DIR)/drv/Module.symvers
KBUILD_EXTRA_SYMBOLS += $(MSP_DIR)/drv/spi/Module.symvers
KBUILD_EXTRA_SYMBOLS += $(MSP_DIR)/drv/gpio/Module.symvers

########################config for CI/CI+ device support  ######################
ifeq ($(CFG_HI_CI_DEV_CIMAX),y)
EXTRA_CFLAGS += -DHI_CI_DEV_CIMAX
endif
ifeq ($(CFG_HI_CI_DEV_CIMAXPLUS),y)
EXTRA_CFLAGS += -DHI_CI_DEV_CIMAXPLUS
endif
ifeq ($(CFG_HI_CI_DEV_HICI),y)
EXTRA_CFLAGS += -DHI_CI_DEV_HICI
endif

ifeq ($(CFG_HI_SPI_BUS_SUPPORT),y)
EXTRA_CFLAGS += -DHI_SPI_BUS_SUPPORT
endif

ifeq ($(CFG_HI_CIMAXPLUS_MODE_USB),y)
EXTRA_CFLAGS += -DHI_CIMAXPLUS_MODE_USB
endif

ifeq ($(CFG_HI_CIMAXPLUS_MODE_SPI),y)
EXTRA_CFLAGS += -DHI_CIMAXPLUS_MODE_SPI
endif

MOD_NAME := hi_ci

obj-$(HI_DRV_BUILDTYPE) += $(MOD_NAME).o

$(MOD_NAME)-y := drv_ci_intf.o	\
		 		 drv_ci.o

ifeq ($(CFG_HI_CI_DEV_CIMAX),y)
$(MOD_NAME)-y += ./cimax/hal_cimax.o
endif
ifeq ($(CFG_HI_CI_DEV_CIMAXPLUS),y)
$(MOD_NAME)-y += ./cimaxplus/hal_cimaxplus.o
endif
ifeq ($(CFG_HI_CI_DEV_HICI),y)
$(MOD_NAME)-y += ./hici/hal_hici.o
endif
ifeq ($(STARCI2WIN_SUPPORT), YES)
$(MOD_NAME)-y += ./starci2win/hal_starci2win.o
endif

###########For SPI Test############
#EXTRA_CFLAGS += -DUSE_GPIO_SPI_FUNC
#$(MOD_NAME)-y += drv_gpio_spi.o
###################################

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

