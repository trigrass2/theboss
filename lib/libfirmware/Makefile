define package/libfirmware/configure
    PKG_SOURCE_DIR:=$(SRC_TOP_DIR)/libfirmware
	PKG_DEPENDS:=libfdt
endef

define package/libfirmware/f429_discovery/configure
	PKG_CONFIGURE_OPTIONS:=--with-target=stm32f4xx
endef

define package/libfirmware/gnu/linux/configure
	PKG_CONFIGURE_OPTIONS:=--with-target=linux
endef

define package/libfirmware/naze32/configure
	PKG_CONFIGURE_OPTIONS:=--with-target=stm32f10x
endef

define package/libfirmware/stm32duino/configure
	PKG_CONFIGURE_OPTIONS:=--with-target=stm32f10x
endef

define package/libfirmware/motordriver-v2/configure
	PKG_CONFIGURE_OPTIONS:=--with-target=stm32f407
endef

$(eval $(call DefinePackage,libfirmware))
