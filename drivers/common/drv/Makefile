###############################################################################
# export variables
###############################################################################
ifeq ($(CFG_HI_EXPORT_FLAG),)
    ifneq ($(srctree),)
    KERNEL_DIR := $(srctree)

    SDK_DIR := $(shell cd $(KERNEL_DIR) && /bin/pwd)
    else
    SDK_DIR := $(shell cd $(CURDIR)/.. && /bin/pwd)
    endif

    include $(SDK_DIR)/base.mak
endif

###############################################################################
# local variables
###############################################################################

## header search path

EXTRA_CFLAGS += -I$(COMMON_DIR)/include \
                -I$(COMMON_DIR)/api/include \
                -I$(COMMON_DIR)/drv/include \
                -I$(COMMON_DIR)/api/log \
                -I$(COMMON_DIR)/api/stat \
                -I$(COMMON_DIR)/api/sys \
                -I$(COMMON_DIR)/api/mmz \
                -I$(COMMON_DIR)/drv/module \
                -I$(COMMON_DIR)/drv/mem \
                -I$(COMMON_DIR)/drv/log \
                -I$(COMMON_DIR)/drv/mmz \
                -I$(COMMON_DIR)/api/mem \
                -I$(MSP_DIR)/drv/include \
                -I$(MSP_DIR)/api/include \
                -I$(MSP_DIR)/api/tde/include \
                -I$(MSP_DIR)/include

ifeq ($(CFG_HI_TEE_SUPPORT),y)
EXTRA_CFLAGS += -I$(LINUX_DIR)/drivers/hisilicon/tee/tee_hisi/tzdriver/
endif

ifdef CFG_HI_LOG_LEVEL
EXTRA_CFLAGS += -DCFG_HI_LOG_LEVEL=$(CFG_HI_LOG_LEVEL)
else
EXTRA_CFLAGS += -DCFG_HI_LOG_LEVEL=1
endif

ifeq ($(CFG_HI_LOG_NETWORK_SUPPORT),y)
EXTRA_CFLAGS += -DLOG_NETWORK_SUPPORT
endif

ifeq ($(CFG_HI_LOG_UDISK_SUPPORT),y)
EXTRA_CFLAGS += -DLOG_UDISK_SUPPORT
endif

EXTRA_CFLAGS += $(CFG_HI_KMOD_CFLAGS)

MOD_NAME_CMN   := hi_common
MOD_NAME_MMZ   := hi_mmz
MOD_NAME_MEDIA := hi_media

$(MOD_NAME_CMN)-y := sys/drv_base_ext_k.o  \
               sys/drv_sys_ext_k.o   \
               dev/drv_dev_ext_k.o   \
               stat/drv_stat_ext_k.o \
               proc/drv_proc_ext_k.o \
               log/drv_log_ext_k.o

$(MOD_NAME_CMN)-y +=    sys/drv_base_ext.o          \
                        sys/drv_sys_ext.o           \
                        sys/drv_reg_common.o        \
                        stat/drv_stat_ext.o         \
                        mem/drv_mutils.o            \
                        module/drv_module_ext.o     \
                        file/drv_file_ext.o         \
                        proc/drv_proc_ext.o         \
                        log/drv_log_ext.o           \
                        memdev/drv_memdev.o         \
                        userproc/drv_userproc.o     \
                        osal/drv_osal.o

$(MOD_NAME_MEDIA)-y := himedia/himedia_base.o  \
                       himedia/himedia.o

ifeq ($(HI_MEMMGR_SUPPORT),y)
EXTRA_CFLAGS += -DCMN_MMGR_SUPPORT

$(MOD_NAME_CMN)-y += mem/drv_mmgr_ext.o mem/drv_mem_ext.o
endif

$(MOD_NAME_MMZ)-y :=	mmz/drv_mmz_ext_k.o \
			mmz/drv_mmz_intf.o \
			mmz/drv_tzsmmu.o

ifdef CONFIG_COMPAT
$(MOD_NAME_MMZ)-y +=mmz/drv_mmz_compat.o
endif

$(MOD_NAME_MMZ)-y += mmz/drv_mmz_userdev.o mmz/drv_media_mem.o

ifeq ($(CFG_HI_TEE_SUPPORT),y)
$(MOD_NAME_MMZ)-y +=	mmz/drv_tee_smmu_agent.o
endif
###############################################################################
obj-$(HI_DRV_BUILDTYPE) += $(MOD_NAME_MEDIA).o $(MOD_NAME_MMZ).o $(MOD_NAME_CMN).o

###############################################################################

REMOVED_FILES := "*.o" "*.ko" "*.order" "*.symvers" "*.mod" "*.mod.*" "*.cmd" ".tmp_versions" "modules.builtin"

###############################################################################
#   rules
###############################################################################
.PHONY: all clean install uninstall

all:
	$(AT)make ARCH=$(CFG_HI_CPU_ARCH) CROSS_COMPILE=$(HI_KERNEL_TOOLCHAINS_NAME)- -C $(LINUX_DIR)  M=`pwd` modules
	$(AT)$(HI_KERNEL_TOOLCHAINS_NAME)-strip --strip-unneeded $(MOD_NAME_CMN).ko

clean:
	$(AT)find ./ -name "*.d" $(foreach file, $(REMOVED_FILES), -o -name $(file)) | xargs rm -rf

install: all
	$(AT)cp -f $(MOD_NAME_CMN).ko $(HI_MODULE_DIR)/
	$(AT)cp -f $(MOD_NAME_MMZ).ko $(HI_MODULE_DIR)/
	$(AT)cp -f $(MOD_NAME_MEDIA).ko $(HI_MODULE_DIR)/

uninstall:
	$(AT)rm -f $(HI_MODULE_DIR)/$(MOD_NAME_CMN).ko
	$(AT)rm -f $(HI_MODULE_DIR)/$(MOD_NAME_MMZ).ko
	$(AT)rm -f $(HI_MODULE_DIR)/$(MOD_NAME_MEDIA).ko

