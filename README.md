# TMS570CTemplate

A template for projects based on the TMS570 microcontroller (Launchpad XL2, TMS570LS1224).

# Toolchain

## ARM NONE EABI GCC

You can install it from [here](https://developer.arm.com/downloads/-/gnu-rm).

### Warning

TMS570 is a big-endian part (BE32), GCC libraries are compiled only for little-endian systems. Recompile the gcc libs is required.

[TMS570 GCC LIBC Big Endian](https://answers.launchpad.net/gcc-arm-embedded/+question/189066)

[TI TMS570 GCC LIBC Big Endian](https://e2e.ti.com/support/microcontrollers/arm-based-microcontrollers-group/arm-based-microcontrollers/f/arm-based-microcontrollers-forum/907975/ccs-tms570lc4357-halcogen-code-cannot-be-compiled-with-gcc)


## TI ARM CGT (Code Generation Tools)

You can install it from [here](https://www.ti.com/tool/download/ARM-CGT).

This tool has the big endian libs so no workaround is needed with this option.

# Project structure

 - __project/cmake__ : Contains the toolchain (compiler, linker and options definition), the linker script and some project specific cmake variables.

 - __project/BSPHALCoGen__ : Software component containing the basic software package, this package is generated from HALGCode Tool, here there are multiple examples of projects that can be imported into HALCoGen to reconfigure and generate a new BSP.

# CMake and Ninja

[CMake](https://cmake.org/) is a tool for generation and automation of code. The name is an abbreviation of __cross platform make__. It is a multiplatform, open-source tool that can generate Makefiles (or different build system projects like Ninja) from a simple and more readable configuration file. CMake in a nutshell is a syntax to describe a project and the compiler environment so it can be abstracted from the final build system file (Makefiles, Ninja.build, Eclipse .cproject, etc)

[Ninja](https://ninja-build.org/), in other hand, is a build system tool meant to replace Makefiles. It is focused by design to run as fast as possible. It already knows the number of cores of your machine, so it dynamically decides when and how to parallelize the build process.

## Build Process

The build process is pretty straightforward, just create a build folder, invoke CMake over the `project` folder and then run ninja (I recommend to use Ninja instead of Make).

```.sh
$ #Assuming you are at the root folder of this repo:
$ mkdir build
$ cd build
$ cmake ../project -GNinja
$ ninja
```

After the compilation, the artifacts are located at the new `build/bin` folder. This will generate __ELF__, __S19__ and __HEX__ files.
You can now load the binary to the microcontroller using OpenOCD and see the leds blinking.

## __Important!__

If you have any comment or question, you can reach me out [josepablo134@gmail.com](mailto:josepablo134@gmail.com)
