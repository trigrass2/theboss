define target/stm32f10x/configure
    TARGET_ARCH:=arm-none-eabi
	TARGET_CFLAGS:=-specs=nosys.specs -mcpu=cortex-m3 -mthumb -mlittle-endian -mfloat-abi=soft -mthumb-interwork
    TARGET_LDADD:=-specs=nosys.specs -mcpu=cortex-m3 -mthumb -mlittle-endian -mfloat-abi=soft -mthumb-interwork
	TARGET_DEPENDS:=
endef

define target/naze32/configure
    $(eval $(call target/stm32f10x/configure))
    TARGET_CFLAGS+=-DSTM32F10X_MD -DHSE_VALUE=8000000
endef


$(eval $(call DefineTarget,naze32))
