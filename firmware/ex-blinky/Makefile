define package/ex-blinky/configure
PKG_SOURCE_DIR:=$(SRC_TOP_DIR)/ex-blinky
PKG_VERSION:=1.0
PKG_DEPENDS:=libfirmware
endef

define package/ex-blinky/f429_discovery/configure
$(eval $(call firmware/ex-blinky/configure))
PKG_CONFIGURE_OPTIONS:=--with-target=f429_discovery
endef

define package/ex-blinky/naze32/configure
$(eval $(call firmware/ex-blinky/configure))
PKG_CONFIGURE_OPTIONS:=--with-target=naze32
endef

$(eval $(call DefineFirmware,ex-blinky))
