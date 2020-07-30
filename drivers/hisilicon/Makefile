
obj-y += kapi/ misc/ soc/ clk/ atags/ clocksource/ flash_stats/ ir/

obj-$(CONFIG_BLK_DEV_RAM)		+= initmrd/
obj-$(CONFIG_BLK_DEV_LOOP)		+= initfile/
obj-$(CONFIG_VIRTUAL_INPUT)		+= vinput/
obj-$(CONFIG_CMA)			+= cma/
obj-$(CONFIG_USB_OTG_HISI)		+= usbotg/

#ccflags-y += -I$(srctree)/drivers/hisilicon/tee/include
#obj-$(CONFIG_TEE_DRIVER)		+= tee/
#obj-$(CONFIG_TEE_DRIVER)		+= sec_mmz/
obj-$(CONFIG_TEE)			+= tee/
obj-$(CONFIG_SDCARD_FS)			+= sdcardfs/
obj-$(CONFIG_REGULATOR)			+= regulator/
obj-$(CONFIG_HISI_THERMAL)              += ipa/
