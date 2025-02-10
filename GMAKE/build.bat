@echo off
set PATH=%PATH%;D:\TDM-GCC-64\bin
set PATH=%PATH%;D:\Program Files (x86)\GNU Arm Embedded Toolchain\10 2021.10\bin
rem set PATH=%PATH%;D:\Program Files (x86)\GNU Tools ARM Embedded\4.6 2012q4\bin
rem cmd /K cd "D:\Program Files (x86)\GNU Tools ARM Embedded\4.6 2012q4\bin"
rem arm-none-eabi-gcc.exe -v
rem mingw32-make.exe -h
mingw32-make.exe -f Makefile
rem arm-none-eabi-gcc.exe -x assembler-with-cpp -mcpu=cortex-m3 -mthumb -mlittle-endian -O0 -c -o  startup_stm32f10x_md.o startup_stm32f10x_md.s
rem arm-none-eabi-gcc.exe -mcpu=cortex-m3 -mthumb -mlittle-endian -O0 -c -o main.o main.c
rem arm-none-eabi-ld.exe  -T STM32F103XB_FLASH.ld  -Map main.map -o main.elf startup_stm32f10x_md.o main.o
rem arm-none-eabi-objcopy.exe -O ihex main.elf main.hex
pause