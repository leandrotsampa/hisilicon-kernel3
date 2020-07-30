#===============================================================================
# export variables
#===============================================================================
ifeq ($(CFG_HI_EXPORT_FLAG),)
SDK_DIR := $(CURDIR)/../../../../..
include $(SDK_DIR)/base.mak
endif

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#   variable
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
BUILD_DIR  := $(shell pwd)/tmp
ifneq ($(ANDROID_BUILD),y)
INSTALL_DIR := $(MODULE_DIR)
FW_INSTALL_DIR := $(ROOTFS_DIR)/lib/firmware
FW_INSTALL_DIR := $(ROOTFS_DIR)/lib/firmware/wlan
MYFTM_INSTALL_DIR := $(ROOTFS_DIR)/system/bin
else
INSTALL_DIR := $(ANDROID_PRODUCT_OUT)/system/lib/modules
FW_INSTALL_DIR := $(ANDROID_PRODUCT_OUT)/system/lib
MYFTM_INSTALL_DIR := $(ANDROID_PRODUCT_OUT)/system/bin
endif
HOST := $(patsubst %-,%,$(CROSS_COMPILE))

MODULE_SRC := fixce
MODULE := compat.ko cfg80211_6174.ko qca6174a.ko 
MODULE_PATH := $(BUILD_DIR)/$(MODULE_SRC)/AIO/rootfs-hisi.build/lib/modules/compat.ko \
	$(BUILD_DIR)/$(MODULE_SRC)/AIO/rootfs-hisi.build/lib/modules/cfg80211_6174.ko \
	$(BUILD_DIR)/$(MODULE_SRC)/AIO/rootfs-hisi.build/lib/modules/qca6174a.ko
FIRMWARE := athwlan.bin fakeboar.bin otp.bin utf.bin
FIRMWARE_PATH := $(shell pwd)/firmware
MYFTM_PATH := $(shell pwd)/myftm/myftm

BUILD_MODULES = $(patsubst %,%_build,${MODULE_SRC})
UNINSTALL_MODULES = $(patsubst %,%_uninstall,${MODULE})

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#   rules
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#==================================================================
#                          all
#==================================================================
.PHONY: all clean install uninstall
all: $(BUILD_MODULES)

clean:
	@rm -rf $(BUILD_DIR)

install: all
	test -d $(INSTALL_DIR) || mkdir -p $(INSTALL_DIR)
	cp -v $(MODULE_PATH) $(INSTALL_DIR)/
	test -d $(FW_INSTALL_DIR) || mkdir -p $(FW_INSTALL_DIR)
	#cp -vrf $(FIRMWARE_PATH) $(FW_INSTAll_DIR)/
	cp -vrf $(FIRMWARE_PATH) $(ANDROID_PRODUCT_OUT)/system/lib/
	test -d $(MYFTM_INSTALL_DIR) || mkdir -p $(MYFTM_INSTALL_DIR)
	#cp -rf $(MYFTM_PATH)/myftm $(MYFTM_INSTALL_DIR)/
	cp -rf $(MYFTM_PATH)/myftm $(ANDROID_PRODUCT_OUT)/system/bin/
uninstall: $(UNINSTALL_MODULES)
#	@rm -rf $(FW_INSTALL_DIR)

#==================================================================
#                          modules
#==================================================================
%_build: $(BUILD_DIR)
	@echo -e "\033[31m""Build $(patsubst %_build,%,$@) ...""\033[00m"
	@test -d $(BUILD_DIR)/$(patsubst %_build,%,$@) \
		|| tar -zxf $(patsubst %_build,%,$@).tar.gz -C $(BUILD_DIR)
	cd $(BUILD_DIR)/$(patsubst %_build,%,$@)/AIO/build && \
	make ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) \
			KERNELPATH=$(LINUX_DIR) BOARD_TYPE=hisi IF_TYPE=PCIE && \
	cd -

$(BUILD_DIR):
	@test -d $(BUILD_DIR) || mkdir -p $(BUILD_DIR)

%_uninstall:
	@rm -f $(INSTALL_DIR)/$(patsubst %_uninstall,%,$@)
