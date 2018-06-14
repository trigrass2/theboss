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
# see if we want verbose output or not
ifeq ($(strip $(V)),)
	Q:=@
else
    Q:=
endif

# first target is "all" so that we can defer default target to a different one we define after we have included all the files.
all: everything

# include the main rules file that defines all make rules and helper functions
include $(SCRIPTS)/rules.mk

# loop thorugh all building system makefiles and include them
# -----------------------------------------------------------

# all device tree files are built using dtc compiler regardless of the targets
$(foreach DTS,$(shell find $(TARGETS_TOP_DIR)/*/dts -type f -name *.dts),$(eval $(call DefineDeviceTree,$(basename $(DTS)))))
# include all target makefiles
$(foreach TARGET,$(notdir $(shell find $(TARGETS_TOP_DIR)/ -maxdepth 1 -type d)),$(eval include $(TARGETS_TOP_DIR)/$(TARGET)/Makefile))
# include libraries
$(foreach LIBRARY,$(notdir $(shell find $(LIBRARIES_TOP_DIR)/ -maxdepth 1 -type d)),$(eval -include $(LIBRARIES_TOP_DIR)/$(LIBRARY)/Makefile))
# include firmwares
$(foreach FIRMWARE,$(notdir $(shell find $(FIRMWARES_TOP_DIR)/ -maxdepth 1 -type d)),$(eval include $(FIRMWARES_TOP_DIR)/$(FIRMWARE)/Makefile))

# define top level build targets
# ------------------------------

everything: $(BUILD_TARGETS)

clean:
	rm -rf build_dir


