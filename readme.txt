将keil的stm32工程添加makefile支持，新增GMAKE目录，保持原项目目录结构不变

stm32项目修改自江协科技的串口uart1示例

效果：
50ms串口1输出一个字符'5'

使用说明：
1. 将GMAKE目录复制到keil工程根目录中
2. keil2makefile解析keil工程文件格式(uvprojx)生成 Project.mk文件(keil2makefile为golang环境编译)
3. 修改Project.mk文件，修改keil和gcc互不兼容的文件，修改后的文件位于GMAKE(startup_stm32f10x_md.s, core_cm3.c)
4. 修改GMAKE目录的Makefile，指定正确的KEILMK_DIR和Project.mk
5. 下载安装arm gcc交叉编译器
6. 下载安装mingw64(make)
7. 修改build.bat中mingw64和arm gcc环境变量

使用make编译时arm gcc交叉编译器下载地址
https://launchpad.net/gcc-arm-embedded/4.6/4.6-2012-q4-update

文件功能说明
startup_stm32f10x_md.s 
从CMSIS目录下复制，注意区分MDK(CMSIS_RVMDK)和ARM(EWARM)的汇编格式

core_cm3.mod.c
修改汇编，修复gcc下 Error: registers may not be the same

STM32F103XB_FLASH.ld
链接文件

Makefile
参考 https://microdynamics.github.io
修改自 https://github.com/microdynamics-robot-quadcopter/breeze_firmware_none/blob/master/make/Project/Makefile

build.bat
自动配置环境变量，一键编译            

stm32f103.mod.resc
renode的stm32f103脚本语法

stm32f103.mod.repl
renode的stm32f103 soc外设资源硬件地址描述
RCC部分取自renode/stm32f0
