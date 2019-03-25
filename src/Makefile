define package/libcanopen/configure
    PKG_SOURCE_DIR:=$(SRC_TOP_DIR)/libcanopen
	PKG_TARGETS:=gnu/linux stm32f4xx
endef

define package/libdriver/configure
    PKG_SOURCE_DIR:=$(SRC_TOP_DIR)/libdriver
    PKG_DEPENDS=libfirmware
endef

define package/libfdt/configure
    PKG_SOURCE_DIR:=$(SRC_TOP_DIR)/libfdt
endef

define package/libfirmware/configure
    PKG_SOURCE_DIR:=$(SRC_TOP_DIR)/libfirmware
	PKG_DEPENDS:=libfdt
	PKG_CONFIGURE_OPTIONS:=--with-target=$(TARGET_PLATFORM)
endef

define package/bossinit/configure
	PKG_SOURCE_DIR:=$(SRC_TOP_DIR)/bossinit
	PKG_VERSION:=1.0
	PKG_DEPENDS:=libfirmware libdriver
	PKG_MAKE_FLAGS:=-B
endef

$(eval $(call DefinePackage,libdriver))
$(eval $(call DefinePackage,libfdt))
$(eval $(call DefinePackage,libcanopen))
$(eval $(call DefinePackage,libfirmware))
$(eval $(call DefinePackage,bossinit))

