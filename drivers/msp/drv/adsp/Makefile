#=======================================
#	export variable
#=======================================
ifeq ($(CFG_HI_EXPORT_FLAG),)
    ifneq ($(srctree),)
    KERNEL_DIR := $(srctree)

    SDK_DIR := $(shell cd $(KERNEL_DIR) && /bin/pwd)
    else
    SDK_DIR := $(shell cd $(CURDIR)/../../../.. && /bin/pwd)
    endif

    include $(SDK_DIR)/base.mak
endif

#=======================================
#	local variable
#=======================================

objects := adsp_v1_1

#Develop Version Enable
#CFG_HI_SND_DEVELOP_VERSION_SUPPORT = y		do not enable here, include in base.mak

obj-y += $(addsuffix /,$(objects))

objects_clean       := $(addsuffix _clean, $(objects))
objects_install     := $(addsuffix _install, $(objects))
objects_uninstall   := $(addsuffix _uninstall, $(objects))

REMOVED_FILES := "*.o" "*.ko" "*.order" "*.symvers" "*.mod" "*.mod.*" "*.cmd" ".tmp_versions" "modules.builtin"

#=================================================================
#	  rules
#=================================================================
.PHONY: all clean install uninstall $(objects) $(objects_clean) $(objects_install) $(objects_uninstall)

all: $(objects)

clean:
	$(AT)find ./ -name "*.d" $(foreach file, $(REMOVED_FILES), -o -name $(file)) | xargs rm -rf

install: $(objects_install)

uninstall: $(objects_uninstall)

$(objects):
	make -C $@

$(objects_clean):
	make -C $(patsubst %_clean,%,$@) clean

$(objects_install):
	make -C $(patsubst %_install,%,$@) install

$(objects_uninstall):
	make -C $(patsubst %_uninstall,%,$@) uninstall
