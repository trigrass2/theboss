define package/ex-console/configure
PKG_SOURCE_DIR:=$(SRC_TOP_DIR)/ex-console
PKG_VERSION:=1.0
PKG_DEPENDS:=libfirmware
endef

define package/ex-console/f429_discovery/configure
$(eval $(call firmware/ex-console/configure))
PKG_CONFIGURE_OPTIONS:=--with-target=f429_discovery
endef

define package/ex-console/naze32/configure
$(eval $(call firmware/ex-console/configure))
PKG_CONFIGURE_OPTIONS:=--with-target=naze32
endef

define package/ex-console/motordriver-v2/configure
$(eval $(call firmware/ex-console/configure))
PKG_CONFIGURE_OPTIONS:=--with-target=motordriver-v2
endef

$(eval $(call DefineFirmware,ex-console))
