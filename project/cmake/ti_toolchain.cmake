################################################################################
# @file CMakeLists.txt
# @author Josepablo C (josepablo134@gmail.com)
# @version 1.0
################################################################################

if (WIN32)
    include(${CMAKE_CURRENT_LIST_DIR}/ti_win-toolchain.cmake)
else ()
    include(${CMAKE_CURRENT_LIST_DIR}/ti_linux-toolchain.cmake)
endif ()

# Perform compiler test with static library
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# Compiler Search Paths
include_directories(BEFORE SYSTEM
    ${TOOLCHAIN_INC_DIR}
)

# Linker Search Paths
link_directories(
    ${TOOLCHAIN_LIB_DIR}
)

# where is the target environment 
SET(CMAKE_FIND_ROOT_PATH ${TOOLCHAIN_PREFIX})

# search for programs in the build host directories
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

set(CMAKE_C_LINK_EXECUTABLE
    "<CMAKE_LINKER> <FLAGS> --run_linker <OBJECTS> <LINK_LIBRARIES> --output_file=<TARGET> <CMAKE_C_LINK_FLAGS> <LINK_FLAGS>" CACHE INTERNAL "C Linker")

set(CMAKE_CXX_LINK_EXECUTABLE
    "<CMAKE_LINKER> <FLAGS> --run_linker <OBJECTS> <LINK_LIBRARIES> --output_file=<TARGET> <CMAKE_C_LINK_FLAGS> <LINK_FLAGS>" CACHE INTERNAL "CXX Linker")

#---------------------------------------------------------------------------------------
# Set compiler/linker flags
#---------------------------------------------------------------------------------------

# Object build options
set(OBJECT_GEN_FLAGS "--abi=eabi -mv7R4 --code_state=32 --float_support=VFPv3D16 -g --diag_warning=225 --diag_wrap=off --display_error_number --enum_type=packed --abi=eabi --preproc_with_compile")

set(CMAKE_C_FLAGS   "${OBJECT_GEN_FLAGS} " CACHE INTERNAL "C Compiler options")
set(CMAKE_CXX_FLAGS "${OBJECT_GEN_FLAGS} " CACHE INTERNAL "C++ Compiler options")
set(CMAKE_ASM_FLAGS "${OBJECT_GEN_FLAGS} " CACHE INTERNAL "ASM Compiler options")

# Checkout Ti arm cgt
set(CMAKE_EXE_LINKER_FLAGS "--heap_size=0x800 --stack_size=0x800 --rom_model --be32 --reread_libs --diag_wrap=off --display_error_number --warn_sections --search_path=${TOOLCHAIN_LIB_DIR} --library=rtsv7R4_T_be_v3D16_eabi.lib --entry_point=_c_int00" CACHE INTERNAL "Linker options")

#---------------------------------------------------------------------------------------
# Set debug/release build configuration Options
#---------------------------------------------------------------------------------------

# Options for DEBUG build
# -Og   Enables optimizations that do not interfere with debugging.
# -g    Produce debugging information in the operating system’s native format.
set(CMAKE_C_FLAGS_DEBUG "-Og -g -g3 -gdwarf-3 -gstrict-dwarf" CACHE INTERNAL "C Compiler options for debug build type")
set(CMAKE_CXX_FLAGS_DEBUG "-Og -g -g3 -gdwarf-3 -gstrict-dwarf" CACHE INTERNAL "C++ Compiler options for debug build type")
set(CMAKE_ASM_FLAGS_DEBUG "-g -g3 -gdwarf-3 -gstrict-dwarf" CACHE INTERNAL "ASM Compiler options for debug build type")
set(CMAKE_EXE_LINKER_FLAGS_DEBUG "" CACHE INTERNAL "Linker options for debug build type")

# Options for RELEASE build
# -Os   Optimize for size. -Os enables all -O2 optimizations.
# -flto Runs the standard link-time optimizer.
set(CMAKE_C_FLAGS_RELEASE "-Os -flto" CACHE INTERNAL "C Compiler options for release build type")
set(CMAKE_CXX_FLAGS_RELEASE "-Os -flto" CACHE INTERNAL "C++ Compiler options for release build type")
set(CMAKE_ASM_FLAGS_RELEASE "" CACHE INTERNAL "ASM Compiler options for release build type")
set(CMAKE_EXE_LINKER_FLAGS_RELEASE "-flto" CACHE INTERNAL "Linker options for release build type")
