#===============================================================================
# export variables
#===============================================================================
ifeq ($(CFG_HI_EXPORT_FLAG),)
    ifneq ($(srctree),)
    KERNEL_DIR := $(srctree)

    SDK_DIR := $(KERNEL_DIR)/../../..
    else
    SDK_DIR := $(CURDIR)/../../../..
    endif

include $(SDK_DIR)/base.mak
endif

#===============================================================================
# local variables
#===============================================================================
# hisilicon hisecurity
EXTRA_CFLAGS += $(CFG_HI_KMOD_CFLAGS)

EXTRA_CFLAGS += -I$(MSP_UNF_INCLUDE)            \
                -I$(MSP_DRV_INCLUDE)            \
                -I$(MSP_DIR)/drv/cipher         \
                -I$(MSP_DIR)/drv/cipher/sha     \
                -I$(COMMON_UNF_INCLUDE)         \
                -I$(COMMON_DRV_INCLUDE)         \
                -I$(COMMON_API_INCLUDE)         \
                -I$(MSP_API_INCLUDE)            \

KBUILD_EXTRA_SYMBOLS += $(COMMON_DIR)/drv/Module.symvers

MOD_NAME := security

obj-y += $(MOD_NAME).o

$(MOD_NAME)-objs   :=  verify.o  bignum.o  rsa.o


.PHONY: all clean install uninstall

all:
	$(AT)make -C $(LINUX_DIR) ARCH=$(CFG_HI_CPU_ARCH) CROSS_COMPILE=$(HI_KERNEL_TOOLCHAINS_NAME)- M=$(CURDIR) 

clean:
	$(AT)make -C $(LINUX_DIR) M=$(CURDIR) clean
	$(AT)rm -rf  *.o
	$(AT)rm -rf  .*.o.cmd
	$(AT)rm -rf .tmp_versions
	$(AT)rm -rf  Module.symvers
	$(AT)rm -rf  modules.order

install: all
	$(AT)cp -f $(CURDIR)/$(MOD_NAME).ko $(HI_MODULE_DIR)/

uninstall:
	$(AT)rm -rf $(HI_MODULE_DIR)/$(MOD_NAME).ko

