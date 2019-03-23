define target/stm32f4xx/configure
    TARGET_ARCH:=arm-none-eabi
	TARGET_CFLAGS:=--specs=nosys.specs -mcpu=cortex-m4 -mthumb -mlittle-endian -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb-interwork
	TARGET_DEPENDS:=
	TARGET_PLATFORM:=stm32f4xx
endef

define target/stm32f429_439xx/configure
	$(eval $(call target/stm32f4xx/configure))
	TARGET_PLATFORM:=stm32f429_439xx
endef

define target/stm32f40_41xxx/configure
	$(eval $(call target/stm32f4xx/configure))
	TARGET_PLATFORM:=stm32f40_41xxx
endef


$(eval $(call DefineTarget,stm32f4xx))
$(eval $(call DefineTarget,stm32f429_439xx))
$(eval $(call DefineTarget,stm32f40_41xxx))
