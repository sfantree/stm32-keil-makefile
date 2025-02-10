#AUTO GENERATE BY KEIL2MAKEFILE
#INCLUDE BEGIN
INCLUDE_DIRS+=$(KEILMK_DIR)/./Start
INCLUDE_DIRS+=$(KEILMK_DIR)/./Library
INCLUDE_DIRS+=$(KEILMK_DIR)/./User
INCLUDE_DIRS+=$(KEILMK_DIR)/./System
INCLUDE_DIRS+=$(KEILMK_DIR)/./Hardware
DIR_INCLUDE = $(patsubst %, -I%, $(INCLUDE_DIRS))
#INCLUDE END
#SOURCE BEGIN
SRC_ASM+=startup_stm32f10x_md.s
SRC_C+=$(KEILMK_DIR)/./Start/core_cm3.c
SRC_C+=$(KEILMK_DIR)/./Start/system_stm32f10x.c
SRC_C+=$(KEILMK_DIR)/./Library/misc.c
SRC_C+=$(KEILMK_DIR)/./Library/stm32f10x_adc.c
SRC_C+=$(KEILMK_DIR)/./Library/stm32f10x_bkp.c
SRC_C+=$(KEILMK_DIR)/./Library/stm32f10x_can.c
SRC_C+=$(KEILMK_DIR)/./Library/stm32f10x_cec.c
SRC_C+=$(KEILMK_DIR)/./Library/stm32f10x_crc.c
SRC_C+=$(KEILMK_DIR)/./Library/stm32f10x_dac.c
SRC_C+=$(KEILMK_DIR)/./Library/stm32f10x_dbgmcu.c
SRC_C+=$(KEILMK_DIR)/./Library/stm32f10x_dma.c
SRC_C+=$(KEILMK_DIR)/./Library/stm32f10x_exti.c
SRC_C+=$(KEILMK_DIR)/./Library/stm32f10x_flash.c
SRC_C+=$(KEILMK_DIR)/./Library/stm32f10x_fsmc.c
SRC_C+=$(KEILMK_DIR)/./Library/stm32f10x_gpio.c
SRC_C+=$(KEILMK_DIR)/./Library/stm32f10x_i2c.c
SRC_C+=$(KEILMK_DIR)/./Library/stm32f10x_iwdg.c
SRC_C+=$(KEILMK_DIR)/./Library/stm32f10x_pwr.c
SRC_C+=$(KEILMK_DIR)/./Library/stm32f10x_rcc.c
SRC_C+=$(KEILMK_DIR)/./Library/stm32f10x_rtc.c
SRC_C+=$(KEILMK_DIR)/./Library/stm32f10x_sdio.c
SRC_C+=$(KEILMK_DIR)/./Library/stm32f10x_spi.c
SRC_C+=$(KEILMK_DIR)/./Library/stm32f10x_tim.c
SRC_C+=$(KEILMK_DIR)/./Library/stm32f10x_usart.c
SRC_C+=$(KEILMK_DIR)/./Library/stm32f10x_wwdg.c
SRC_C+=$(KEILMK_DIR)/./System/Delay.c
SRC_C+=$(KEILMK_DIR)/./Hardware/LED.c
SRC_C+=$(KEILMK_DIR)/./Hardware/Key.c
SRC_C+=$(KEILMK_DIR)/./Hardware/OLED.c
SRC_C+=$(KEILMK_DIR)/./Hardware/Serial.c
SRC_C+=$(KEILMK_DIR)/./User/main.c
SRC_C+=$(KEILMK_DIR)/./User/stm32f10x_it.c
#SOURCE END
