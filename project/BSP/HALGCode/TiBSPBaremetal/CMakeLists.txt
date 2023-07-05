################################################################################
# @file CMakeLists.txt
# @author Josepablo C (josepablo134@gmail.com)
################################################################################
cmake_minimum_required( VERSION 3.18.4 )

project( TMS570BSP_TiBaremetal
		DESCRIPTION "Baremetal TMS570LS122 BSP generated from HALGCode (Ti ARM CGT)"
		VERSION 1.0.0
		LANGUAGES C ASM
)

set(COMPONENT_NAME BSP)
set(SUBCOMPONENT_VARIANT TI)
set(SUBCOMPONENT_NAME Baremetal)

set(CURRENT_COMPONENT_NAME ${COMPONENT_NAME}_${SUBCOMPONENT_VARIANT}_${SUBCOMPONENT_NAME})

add_library(${CURRENT_COMPONENT_NAME} STATIC
		# ASM
		${CMAKE_CURRENT_LIST_DIR}/source/dabort.asm
		${CMAKE_CURRENT_LIST_DIR}/source/sys_core.asm
		${CMAKE_CURRENT_LIST_DIR}/source/sys_intvecs.asm
		${CMAKE_CURRENT_LIST_DIR}/source/sys_mpu.asm
		${CMAKE_CURRENT_LIST_DIR}/source/sys_pmu.asm
		# C
		${CMAKE_CURRENT_LIST_DIR}/source/adc.c
		${CMAKE_CURRENT_LIST_DIR}/source/can.c
		${CMAKE_CURRENT_LIST_DIR}/source/crc.c
		${CMAKE_CURRENT_LIST_DIR}/source/dcc.c
		${CMAKE_CURRENT_LIST_DIR}/source/ecap.c
		${CMAKE_CURRENT_LIST_DIR}/source/eqep.c
		${CMAKE_CURRENT_LIST_DIR}/source/errata_SSWF021_45.c
		${CMAKE_CURRENT_LIST_DIR}/source/esm.c
		${CMAKE_CURRENT_LIST_DIR}/source/etpwm.c
		${CMAKE_CURRENT_LIST_DIR}/source/gio.c
		${CMAKE_CURRENT_LIST_DIR}/source/het.c
		${CMAKE_CURRENT_LIST_DIR}/source/i2c.c
		${CMAKE_CURRENT_LIST_DIR}/source/lin.c
		${CMAKE_CURRENT_LIST_DIR}/source/mibspi.c
		${CMAKE_CURRENT_LIST_DIR}/source/notification.c
		${CMAKE_CURRENT_LIST_DIR}/source/pinmux.c
		${CMAKE_CURRENT_LIST_DIR}/source/rti.c
		${CMAKE_CURRENT_LIST_DIR}/source/sci.c
		${CMAKE_CURRENT_LIST_DIR}/source/spi.c
		${CMAKE_CURRENT_LIST_DIR}/source/sys_dma.c
		${CMAKE_CURRENT_LIST_DIR}/source/sys_main.c
		${CMAKE_CURRENT_LIST_DIR}/source/sys_pcr.c
		${CMAKE_CURRENT_LIST_DIR}/source/sys_phantom.c
		${CMAKE_CURRENT_LIST_DIR}/source/sys_pmm.c
		${CMAKE_CURRENT_LIST_DIR}/source/sys_selftest.c
		${CMAKE_CURRENT_LIST_DIR}/source/sys_startup.c
		${CMAKE_CURRENT_LIST_DIR}/source/system.c
		${CMAKE_CURRENT_LIST_DIR}/source/sys_vim.c
)

target_include_directories(${CURRENT_COMPONENT_NAME} PUBLIC
		${CMAKE_CURRENT_LIST_DIR}/include
)

add_library(${COMPONENT_NAME}::${SUBCOMPONENT_VARIANT}::${SUBCOMPONENT_NAME} ALIAS ${CURRENT_COMPONENT_NAME})

target_link_libraries(${CURRENT_COMPONENT_NAME}
	BSP::F021
)
