################################################################################
# @file CMakeLists.txt
# @author Josepablo C (josepablo134@gmail.com)
# @version 1.0
################################################################################

cmake_minimum_required( VERSION 3.18.4 )

include(cmake/ti_toolchain.cmake)

project( TMS570CTemplate
		DESCRIPTION "Project template for TMS570LS122 microcontroller"
		VERSION 1.0.0
		LANGUAGES C ASM
)

# Patch to TI.cmake to link the program
# armcl --run_linker <OBJS> <LIBRARIES>
include(cmake/ti_toolchain_epilog.cmake)

# ===================================================================
# Project Set-Up
# ===================================================================

set( PROJECT_NAME template )
set( EXEC_NAME ${PROJECT_NAME} )
set( WORK_DIR ${PROJECT_SOURCE_DIR} )

include( ${WORK_DIR}/cmake/project.cmake)

# ===================================================================
# Project content
# ===================================================================

add_executable( ${EXEC_NAME} ${WORK_DIR}/main.c )

add_subdirectory( ${WORK_DIR}/BSP )

target_link_libraries( ${EXEC_NAME}
		BSP::TI::Baremetal
)

target_include_directories(${EXEC_NAME} PRIVATE
		${WORK_DIR}
)

target_link_options(${EXEC_NAME}
		PUBLIC
		# Ti ARM CGT
		--rom_model -m${OUTPUT_MAP}
		# GCC none eabi
		#-Wl,-T ${LINKER_SCRIPT} -Wl,-Map=${OUTPUT_MAP}
)

# Generate Linker Script from configuration file
add_custom_command(
		TARGET ${EXEC_NAME} PRE_LINK
		COMMAND
				${CMAKE_COMMAND} -E make_directory ${CMAKE_RUNTIME_LOCATE_DIRECTORY}
		COMMAND
				# TI ARM CGT
				${CMAKE_C_COMPILER} --preproc_only --c_extension=.ld  ${PRE_LINKER_SCRIPT} --output_file=${LINKER_SCRIPT}
				# GNU
				#${CMAKE_C_COMPILER} -E -P -x c ${PRE_LINKER_SCRIPT} -o ${LINKER_SCRIPT}
		DEPENDS 
				${PRE_LINKER_SCRIPT}
)

# Not supported by TI compiler
# # Generate S19 file
# add_custom_command(
# 		TARGET ${EXEC_NAME} POST_BUILD
# 		COMMAND
# 				${CMAKE_OBJCOPY} -O srec --srec-forceS3 ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${EXEC_NAME}${CMAKE_EXECUTABLE_SUFFIX} ${OUTPUT_S19}
# 		DEPENDS 
# 			${EXEC_NAME}
# )

# Generate HEX file
add_custom_command(
		TARGET ${EXEC_NAME} POST_BUILD
		COMMAND
				${CMAKE_OBJCOPY} -O ihex ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${EXEC_NAME}${CMAKE_EXECUTABLE_SUFFIX} ${OUTPUT_HEX}
		DEPENDS 
			${EXEC_NAME}
)

