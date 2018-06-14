define target/stm32f4xx/configure
    TARGET_ARCH:=arm-none-eabi
	TARGET_CFLAGS:=--specs=nosys.specs -mcpu=cortex-m4 -mthumb -mlittle-endian -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb-interwork
	TARGET_DEPENDS:=
endef

define target/f429_discovery/configure
    $(eval $(call target/stm32f4xx/configure))
endef


$(eval $(call DefineTarget,stm32f4xx))
$(eval $(call DefineTarget,f429_discovery))
