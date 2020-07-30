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
# local variable
#===============================================================================

# V1:HI3716, V2:HI3110, V3:V1R1
#SDK_SECURITY_ARCH_VERSION=SDK_SECURITY_ARCH_VERSION_V1
#SDK_SECURITY_ARCH_VERSION=SDK_SECURITY_ARCH_VERSION_V2
SDK_SECURITY_ARCH_VERSION=SDK_SECURITY_ARCH_VERSION_V3

EXTRA_CFLAGS += -D$(SDK_SECURITY_ARCH_VERSION)


EXTRA_CFLAGS += $(CFG_HI_KMOD_CFLAGS)
EXTRA_CFLAGS += $(CFG_CFLAGS)

###These header files are for SDK_SECURITY_ARCH_VERSION_V3###
EXTRA_CFLAGS    +=  -I$(COMMON_UNF_INCLUDE)             \
                    -I$(COMMON_API_INCLUDE)             \
                    -I$(COMMON_DRV_INCLUDE)             \
                    -I$(MSP_UNF_INCLUDE)                \
                    -I$(MSP_API_INCLUDE)                \
                    -I$(MSP_DRV_INCLUDE)                \
                    -I$(MSP_DIR)/include                \
                    -I$(MSP_DRV_INCLUDE)                \
                    -I$(MSP_DIR)/drv/advca              \
                    -I$(MSP_DIR)/drv/advca/runtime      \
                    -I$(MSP_DIR)/drv/advca/V200         \
                    -I$(MSP_DIR)/drv/advca/V300         \
                    -I$(MSP_DIR)/drv/advca/ca_otp       \
                    -I$(MSP_DIR)/drv/advca/ca_otp/ca_otpv100    \
                    -I$(MSP_DIR)/drv/advca/ca_otp/ca_otpv200

###These header files are for SDK_SECURITY_ARCH_VERSION_V1###
EXTRA_CFLAGS    +=  -I$(KCOM_DIR)/drv/include                   \
                    -I$(KCOM_DIR)/include                       \
                    -I$(ADVCA_ROOT_DIR)/include                 \
                    -I$(ADVCA_COMMON_DIR)/include               \
                    -I$(KECS_DIR)/drv/include                   \
                    -I$(KECS_DIR)/include                       \
                    -I$(ADVCA_COMMON_DIR)/drv                   \
                    -I$(ADVCA_COMMON_DIR)/drv/V200              \
                    -I$(ADVCA_COMMON_DIR)/drv/V300              \
                    -I$(ADVCA_COMMON_DIR)/drv/ca_otp            \
                    -I$(ADVCA_COMMON_DIR)/drv/ca_otp/ca_otpv100 \
                    -I$(ADVCA_COMMON_DIR)/drv/ca_otp/ca_otpv200

DDR_WAKE_UP_CHECK_BIN = $(MSP_DIR)/drv/advca/ddr_wakeup_check/ddr_wakeup_check.bin
EXTRA_AFLAGS += -DWAKE_UP_BIN=\"$(DDR_WAKE_UP_CHECK_BIN)\"
KBUILD_EXTRA_SYMBOLS += $(MSP_DIR)/drv/otp/Module.symvers
KBUILD_EXTRA_SYMBOLS += $(COMMON_DIR)/drv/Module.symvers

MOD_NAME := hi_advca
obj-$(HI_DRV_BUILDTYPE) += $(MOD_NAME).o

$(MOD_NAME)-y := drv_advca_intf.o
$(MOD_NAME)-y += ./drv_advca.o ./drv_advca_common.o
#$(MOD_NAME)-y += ./V200/drv_advca_v200.o
$(MOD_NAME)-y += ./V300/hal_advca_v300.o ./V300/drv_advca_v300.o
$(MOD_NAME)-y += ./ca_otp/ca_otpv200/drv_ca_otp_v200.o
$(MOD_NAME)-y += ./ca_otp/ca_otpv100/drv_ca_otp_v100.o
$(MOD_NAME)-y += ./runtime/sha1.o
$(MOD_NAME)-y += ./runtime/runtime_module.o

ifeq ($(CFG_HI_AARCH64_TOOLCHAINS_NAME),)
ifeq ($(CFG_HI_LOADER_SUPPORT),)
EXTRA_CFLAGS += -DDDR_WAKE_UP_CHECK_ENABLE
$(MOD_NAME)-y += hi_ca_pm.o
endif
endif

REMOVED_FILES := "*.o" "*.ko" "*.order" "*.symvers" "*.mod" "*.mod.*" "*.cmd" ".tmp_versions" "modules.builtin"

#===============================================================================
# rules
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
