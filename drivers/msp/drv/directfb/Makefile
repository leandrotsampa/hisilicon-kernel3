DFB_FUSION=$(shell pwd)

#===============================================================================
# export variable
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

#===================================================================
#dfb example version
#==================================================================
ifeq (${CFG_HI_DIRECTFB_1_6_1},y)
DFB_FUSION_VER = 9.0.2
else
DFB_FUSION_VER = 8.2.1
endif

#$(error $(DFB_FUSION))

#===================================================================
#compile
#==================================================================
.PHONY:all clean prepare install uninstall
all:prepare
ifeq (${CFG_HI_DIRECTFB_SUPPORT},y)
ifeq (${CFG_HI_DIRECTFB_MULTI_SUPPORT},y)
	$(AT)make -C ${DFB_FUSION}/linux-fusion-${DFB_FUSION_VER}
	$(AT)cp -rf ${DFB_FUSION}/linux-fusion-${DFB_FUSION_VER}/linux/drivers/char/fusion/hi_fusion.ko  ${DFB_FUSION}/
endif
endif
clean:
ifeq (${CFG_HI_DIRECTFB_SUPPORT},y)
ifeq (${CFG_HI_DIRECTFB_MULTI_SUPPORT},y)
	-$(AT)rm -rf linux-fusion-${DFB_FUSION_VER}
	-$(AT)rm -rf linux-fusion-${DFB_FUSION_VER}.tar.gz
	-$(AT)rm -rf ${DFB_FUSION}/hi_fusion.ko
endif
else
endif
	$(AT)echo "compiled finish"
prepare:
ifeq (${CFG_HI_DIRECTFB_SUPPORT},y)
ifeq (${CFG_HI_DIRECTFB_MULTI_SUPPORT},y)
	$(AT)cp -rf $(SDK_DIR)/third_party/open_source/linux-fusion-${DFB_FUSION_VER}.tar.gz  ${DFB_FUSION}/
	$(AT)tar -zxvf linux-fusion-${DFB_FUSION_VER}.tar.gz
	$(AT)cp -rf ${DFB_FUSION}/patch-for-fusion/linux-fusion-${DFB_FUSION_VER}.patch/*  ${DFB_FUSION}/linux-fusion-${DFB_FUSION_VER}/
	$(AT)rm -rf linux-fusion-${DFB_FUSION_VER}.tar.gz
endif
endif
	$(AT)echo "compiled finish"
install:all
uninstall:clean
