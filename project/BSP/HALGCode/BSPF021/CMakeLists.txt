################################################################################
# @file CMakeLists.txt
# @author Josepablo C (josepablo134@gmail.com)
################################################################################
cmake_minimum_required( VERSION 3.18.4 )

project( F021
		DESCRIPTION "F021 Flash API Version 2.01.01"
		VERSION 2.01.01
		LANGUAGES C ASM
)

set(COMPONENT_NAME BSP)
set(SUBCOMPONENT_NAME F021)

set(CURRENT_COMPONENT_NAME ${CURRENT_COMPONENT_NAME}_${SUBCOMPONENT_NAME})

add_library(${CURRENT_COMPONENT_NAME} STATIC
		${CMAKE_CURRENT_LIST_DIR}/source/Fapi_UserDefinedFunctions.c
)

target_include_directories(${CURRENT_COMPONENT_NAME} PUBLIC
		${CMAKE_CURRENT_LIST_DIR}/include
)

add_library(${COMPONENT_NAME}::${SUBCOMPONENT_NAME} ALIAS ${CURRENT_COMPONENT_NAME})
