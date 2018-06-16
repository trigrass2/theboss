ALL_TARGETS:=
MANDATORY_CFLAGS:=\
	-Wall -Wextra -Werror\
	-g \
	-Os -ffunction-sections -fdata-sections\
	-std=gnu11\
	-pedantic \
	-Wchar-subscripts\
	-Wformat\
	-Wformat-nonliteral\
	-Wformat-security\
	-Wmissing-braces\
	-Wparentheses\
	-Wsequence-point\
	-Wswitch\
	-Wtrigraphs\
	-Wno-unused-function\
	-Wunused-label\
	-Wno-unused-parameter\
	-Wunused-variable\
	-Wunused-value\
	-Wuninitialized\
	-Wdiv-by-zero\
	-Wfloat-equal\
	-Wdouble-promotion\
	-fsingle-precision-constant\
	-Wshadow\
	-Wpointer-arith\
	-Wwrite-strings\
	-Wconversion\
	-Wredundant-decls\
	-Wunreachable-code\
	-Winline\
	-Wenum-compare \
	-Wlong-long\
	-Wchar-subscripts
MANDATORY_LDFLAGS:=\
	-Wl,--gc-sections

define ResetTargetOptions
TARGET:=$(1)
TARGET_DIR:=$(TARGETS_TOP_DIR)/$(dir $(1))
TARGET_COMMON_FLAGS:=
TARGET_CFLAGS:=
TARGET_CXXFLAGS:=
TARGET_LDFLAGS:=
TARGET_LDADD:=
TARGET_DEPENDS:=
TARGET_ARCH:=
TARGET_DEVICETREE:=noexist
TARGET_STAGING_DIR:=
TARGET_CONFIGURE_OPTIONS:=
endef

# (1): target name
define DefineTarget 
$(eval $(call ResetTargetOptions,$(1)))
$(eval $(call target/$(1)/configure))
ALL_TARGETS+=$(1)
endef

# (1): target
# (2): package
# (3): dependency packages
# (4): package file dependencies
define define_package_target
$(eval $(call ResetTargetOptions,$(1)))
$(eval $(call target/$(1)/configure))
$(eval $(call ResetPackageOptions,$(1)))
$(eval $(call package/$(2)/configure))
ifdef package/$(2)/$(1)/configure
$(eval $(call package/$(2)/$(1)/configure))
endif
$(eval PKG_BUILD_DIR:=$(BUILD_DIR)/$(1)/$(2))
$(eval TARGET_STAGING_DIR:=$(STAGING_DIR)/$(1))
$(eval _PKG_CFLAGS:=$(MANDATORY_CFLAGS) $(TARGET_CFLAGS) $(PKG_CFLAGS) -I $(TARGET_STAGING_DIR)/include)
$(eval _PKG_CXXFLAGS:=$(TARGET_CXXFLAGS) $(PKG_CXXFLAGS) -I $(TARGET_STAGING_DIR)/include)
$(eval _PKG_LDFLAGS:=$(MANDATORY_LDFLAGS) $(TARGET_LDFLAGS) $(PKG_LDFLAGS) -L $(TARGET_STAGING_DIR)/lib)
$(eval _PKG_LDADD:=$(MANDATORY_LDADD) $(TARGET_LDADD) $(PKG_LDADD))
$(eval _PKG_CONFIGURE_OPTIONS:=$(TARGET_CONFIGURE_OPTIONS) $(PKG_CONFIGURE_OPTIONS))
$(eval _PKG_DEPENDS:=$(foreach DEP,$(PKG_DEPENDS),package/$(DEP)/$(1)/install) $(foreach DEP,$(TARGET_DEPENDS),package/$(DEP)/$(1)/install))
$(info Package $(2) depends on $(_PKG_DEPENDS))
$(PKG_BUILD_DIR): $(_PKG_DEPENDS)
	@mkdir -p $(PKG_BUILD_DIR)
	@echo "Configuring target $(2) for $(1)."
	(cd $(PKG_BUILD_DIR) && $(PKG_SOURCE_DIR)/configure --build=`uname -m` --host="$(TARGET_ARCH)" $(_PKG_CONFIGURE_OPTIONS) CFLAGS="$(_PKG_CFLAGS)" LDFLAGS="$(_PKG_LDFLAGS)" LDADD="$(_PKG_LDADD)" --prefix "$(TARGET_STAGING_DIR)" && touch $(PKG_BUILD_DIR)/.configured)
$(PKG_BUILD_DIR)/.built: $(PKG_BUILD_DIR)
	@echo "Building target $(2) for $(1). Depends on $(4)"
	(cd $(PKG_BUILD_DIR) && make)
$(PKG_BUILD_DIR)/.installed: $(PKG_BUILD_DIR)/.built
	(cd $(PKG_BUILD_DIR) && make install && touch $(PKG_BUILD_DIR)/.installed)
$(PKG_BUILD_DIR)/.unconfigure:
	rm $(PKG_BUILD_DIR)/.configured
package/$(2)/$(1)/configure: $(PKG_BUILD_DIR)/.unconfigure $(PKG_BUILD_DIR)/.configured
package/$(2)/$(1)/compile: $(BUILD_DIR)/$(1)/$(2)/.installed
	@echo "$(2)/$(1) compiled";
package/$(2)/$(1)/install: package/$(2)/$(1)/compile
	@echo "$(2)/$(1)/installed";
PKG_BUILD_TARGETS+=package/$(2)/$(1)/compile
endef

define ResetPackageOptions
PKG_TARGETS:=
PKG_DEPENDS:=
PKG_CFLAGS:=
PKG_CXXFLAGS:=
PKG_LDFLAGS:=
PKG_LDADD:=
PKG_SOURCE_DIR:=
PKG_BUILD_TARGETS:=
PKG_CONFIGURE_OPTIONS:=
PKG_DEPEND_BUILD_TARGETS:=
endef

# (1): target
# (2): package
define define_firmware_targets
firmware/$(2)/$(1)/compile: package/$(2)/$(1)/compile
firmware/$(2)/$(1)/install: package/$(2)/$(1)/install
endef

# (1): firmware
define DefineFirmware
$(foreach TARGET,$(ALL_TARGETS),$(eval $(call define_package_target,$(TARGET),$(1),$(PKG_DEPENDS),$(TOP_DIR)/firmware/$(1)/Makefile)))
.PHONY+=$(PKG_BUILD_TARGETS)
BUILD_TARGETS+=firmware/$(1)/compile
endef

# (1): package
define DefinePackage
$(foreach TARGET,$(ALL_TARGETS),$(eval $(call define_package_target,$(TARGET),$(1),$(PKG_DEPENDS),$(TOP_DIR)/package/$(1)/Makefile)))
.PHONY+=$(PKG_BUILD_TARGETS)
endef


