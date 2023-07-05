################################################################################
# @file CMakeLists.txt
# @author Josepablo C (josepablo134@gmail.com)
# @version 1.0
################################################################################
set(CMAKE_C_LINK_EXECUTABLE
    "<CMAKE_C_COMPILER> <FLAGS> --run_linker <LINK_LIBRARIES> <OBJECTS> --output_file=<TARGET> <CMAKE_C_LINK_FLAGS> <LINK_FLAGS>" CACHE INTERNAL "C Linker")

set(CMAKE_CXX_LINK_EXECUTABLE
    "<CMAKE_CXX_COMPILER> <FLAGS> --run_linker <LINK_LIBRARIES> <OBJECTS> --output_file=<TARGET> <CMAKE_C_LINK_FLAGS> <LINK_FLAGS>" CACHE INTERNAL "CXX Linker")
