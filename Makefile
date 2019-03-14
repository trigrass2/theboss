# ==================================
# TheBOSS Master Makefile
# Copyright (c) 2018 Martin Schröder
# License: BSD
# ==================================

# define core variables
TOP_DIR:=$(CURDIR)
SCRIPTS:=$(TOP_DIR)/scripts/
TARGETS_TOP_DIR:=$(TOP_DIR)/target/
FIRMWARES_TOP_DIR:=$(TOP_DIR)/firmware/
LIBRARIES_TOP_DIR:=$(TOP_DIR)/lib/
BUILD_DIR:=$(TOP_DIR)/build_dir/
SRC_TOP_DIR:=$(TOP_DIR)/src/
STAGING_DIR:=$(TOP_DIR)/staging_dir/
SUBMAKE:=make -r TOP_DIR=$(TOP_DIR) 

ifneq ($(PROJECT),)
PROJECT_TOP_DIR:=$(PROJECT)
else
PROJECT_TOP_DIR:=$(TOP_DIR)
endif

# see if we want verbose output or not
ifeq ($(strip $(V)),)
	Q:=@
else
    Q:=
endif

# first target is "all" so that we can defer default target to a different one we define after we have included all the files.
all: info everything

info:
	@echo "PROJECT=$(PROJECT)"

# include the main rules file that defines all make rules and helper functions
include $(SCRIPTS)/rules.mk

# loop thorugh all building system makefiles and include them
# -----------------------------------------------------------

# all device tree files are built using dtc compiler regardless of the targets
#$(foreach DTS,$(shell find $(TARGETS_TOP_DIR)/*/dts -type f -name *.dts),$(eval $(call DefineDeviceTree,$(basename $(DTS)))))
# include all target makefiles
$(foreach TARGET,$(notdir $(shell find $(TARGETS_TOP_DIR)/ -maxdepth 1 -type d)),$(eval include $(TARGETS_TOP_DIR)/$(TARGET)/Makefile))
# include module makefiles

ifneq ($(PROJECT),)
include $(PROJECT)/target/Makefile
endif

# include core makefile
include src/Makefile

ifneq ($(PROJECT),)
include $(PROJECT)/src/Makefile
endif

# define top level build targets
# ------------------------------

everything: $(BUILD_TARGETS)

clean:
	rm -rf build_dir

.PHONY=info everything clean
