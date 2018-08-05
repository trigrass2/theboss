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

define package/ex-blinky/stm32duino/configure
$(eval $(call firmware/ex-blinky/configure))
PKG_CONFIGURE_OPTIONS:=--with-target=stm32duino
endef

$(eval $(call DefineFirmware,ex-blinky))

package/ex-blinky/stm32duino/flash: package/ex-blinky/stm32duino/compile
	arm-none-eabi-objcopy -O binary build_dir/stm32duino/ex-blinky/src/ex-blinky firmware.bin
	arm-none-eabi-size build_dir/stm32duino/ex-blinky/src/ex-blinky
	ls -la firmware.bin
	stm32flash -w firmware.bin -b 115200 -v -g 0x0 /dev/ttyUSB0

package/ex-blinky/stm32duino/flash-stlink: package/ex-blinky/stm32duino/compile
	arm-none-eabi-objcopy -O binary build_dir/stm32duino/ex-blinky/src/ex-blinky build_dir/stm32duino/ex-blinky/ex-blinky.bin
	arm-none-eabi-objcopy -O ihex build_dir/stm32duino/ex-blinky/src/ex-blinky build_dir/stm32duino/ex-blinky/ex-blinky.hex
	openocd -f interface/stlink-v2.cfg -f target/stm32f1x.cfg -c "program build_dir/stm32duino/ex-blinky/ex-blinky.hex verify reset";
