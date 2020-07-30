KERNEL_OUT := $(ANDROID_PRODUCT_OUT)/obj/KERNEL_OBJ
MODULE_OUT := $(shell pwd)
CROSS_COMPILE ?= arm-hisiv200-linux-
EXTRA_CFLAGS := ROOTFS_DIR=$(ANDROID_BUILD_TOP)/$(PRODUCT_OUT) \
		LINUX_DIR=$(KERNEL_OUT) \
		CFG_HI_KERNEL_VERSION=linux-3.10.y ANDROID_BUILD=y \
		CFG_HI_WIFI_MODE_STA=y CFG_HI_WIFI_MODE_AP=y

TARGET+=CFG80211
ifeq ($(CONFIG_RT3070_SUPPORT),y)
TARGET+=RT5370
endif
ifeq ($(CONFIG_RT5370_SUPPORT),y)
TARGET+=RT5370
endif
ifeq ($(CONFIG_RT5572_SUPPORT),y)
TARGET+=RT5572
endif
ifeq ($(CONFIG_MT7601U_SUPPORT),y)
TARGET+=MT7601U
endif
ifeq ($(CONFIG_AR9271_SUPPORT),y)
TARGET+=AR9271
endif
ifeq ($(CONFIG_AR9374_SUPPORT),y)
TARGET+=AR9374
endif
ifeq ($(CONFIG_QCA1021G_SUPPORT),y)
TARGET+=AR9374
endif
ifeq ($(CONFIG_QCA1021X_SUPPORT),y)
TARGET+=AR9374
endif
ifeq ($(CONFIG_RTL8188CUS_SUPPORT),y)
TARGET+=RTL8188CUS
endif
ifeq ($(CONFIG_RTL8192CU_SUPPORT),y)
TARGET+=RTL8188CUS
endif
ifeq ($(CONFIG_RTL8188EUS_SUPPORT),y)
TARGET+=RTL8188EUS
endif
ifeq ($(CONFIG_RTL8188ETV_SUPPORT),y)
TARGET+=RTL8188EUS
endif
ifeq ($(CONFIG_RTL8192DU_SUPPORT),y)
TARGET+=RTL8192DU
endif
ifeq ($(CONFIG_RTL8192EU_SUPPORT),y)
TARGET+=RTL8192EU
endif
ifeq ($(CONFIG_RTL8812AU_SUPPORT),y)
TARGET+=RTL8812AU
endif
ifeq ($(CONFIG_BCM43236_SUPPORT),y)
TARGET+=BCM43xx
endif
ifeq ($(CONFIG_RTL8723BU_SUPPORT),y)
TARGET+=RTL8723BU
endif

all:$(TARGET)

RT5370:
	make ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) $(EXTRA_CFLAGS) \
		-C ../usb_rt5370 install
	@make -C ../usb_rt5370 clean

RT5572:
	make ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) $(EXTRA_CFLAGS) \
		-C ../usb_rt5572 install
	@make -C ../usb_rt5572 clean

MT7601U:
	make ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) $(EXTRA_CFLAGS) \
		-C ../usb_mt7601u install
	@make -C ../usb_mt7601u clean

AR9271:
	make ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) $(EXTRA_CFLAGS) \
		-C ../usb_ar9271 install
	@make -C ../usb_ar9271 clean

AR9374:
	make ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) $(EXTRA_CFLAGS) \
		-C ../usb_ar9374 install
	@make -C ../usb_ar9374 clean

RTL8188CUS:
	make ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) $(EXTRA_CFLAGS) \
		-C ../usb_rtl8188cu install
	@make -C ../usb_rtl8188cu clean

RTL8188EUS:
	make ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) $(EXTRA_CFLAGS) \
		-C ../usb_rtl8188eu install
	@make -C ../usb_rtl8188eu clean

RTL8192DU:
	make ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) $(EXTRA_CFLAGS) \
		-C ../usb_rtl8192du install
	@make -C ../usb_rtl8192du clean

RTL8192EU:
	make ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) $(EXTRA_CFLAGS) \
		-C ../usb_rtl8192eu install
	@make -C ../usb_rtl8192eu clean

RTL8812AU:
	make ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) $(EXTRA_CFLAGS) \
		-C ../usb_rtl8812au install
	@make -C ../usb_rtl8812au clean

BCM43xx:
	make ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) $(EXTRA_CFLAGS) \
		-C ../usb_bcm43xx install
	@make -C ../usb_bcm43xx clean

RTL8723BU:
	make ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) $(EXTRA_CFLAGS) \
		-C ../usb_rtl8723bu install
	@make -C ../usb_rtl8723bu clean

CFG80211:
	make ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) $(EXTRA_CFLAGS) \
		-C $(shell pwd)/../cfg80211 install
	@make -C $(shell pwd)/../cfg80211 clean

clean:

