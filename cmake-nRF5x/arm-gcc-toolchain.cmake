# check if already run. Changing the compiler var can cause reconfigure so don't want to do it again
if(DEFINED ARM_GCC_TOOLCHAIN)
    return()
endif()
set(ARM_GCC_TOOLCHAIN TRUE)

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR ARM)

set(TOOLCHAIN_PREFIX arm-none-eabi-)

if (NOT DEFINED ARM_NONE_EABI_TOOLCHAIN_BIN_PATH)
    if(MINGW OR CYGWIN OR WIN32)
        set(UTIL_SEARCH_CMD where)
    elseif(UNIX OR APPLE)
        set(UTIL_SEARCH_CMD which)
    endif()
    execute_process(
            COMMAND ${UTIL_SEARCH_CMD} ${TOOLCHAIN_PREFIX}gcc
            OUTPUT_VARIABLE BINUTILS_PATH
            OUTPUT_STRIP_TRAILING_WHITESPACE
    )

    get_filename_component(ARM_NONE_EABI_TOOLCHAIN_BIN_PATH ${BINUTILS_PATH} DIRECTORY)
endif ()

# Without that flag CMake is not able to pass test compilation check
if (${CMAKE_VERSION} VERSION_EQUAL "3.6.0" OR ${CMAKE_VERSION} VERSION_GREATER "3.6")
    set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
else()
    set(CMAKE_EXE_LINKER_FLAGS_INIT "--specs=nosys.specs")
endif()

#set(TOOLCHAIN_PATH_AND_PREFIX ${ARM_NONE_EABI_TOOLCHAIN_BIN_PATH}/${TOOLCHAIN_PREFIX})
#set(LLVM_TOOLCHAIN_BIN_PATH /home/smj/purs3/LLVMEmbeddedToolchainForArm-14.0.0/bin/)
set(LLVM_TOOLCHAIN_BIN_PATH /usr/lib/llvm-14/bin/)
set(LLVM_TOOLCHAIN_PATH_AND_PREFIX ${LLVM_TOOLCHAIN_BIN_PATH}/llvm-)
set(TOOLCHAIN_PATH_AND_PREFIX ${LLVM_TOOLCHAIN_PATH_AND_PREFIX})

#set(CMAKE_C_COMPILER ${TOOLCHAIN_PATH_AND_PREFIX}gcc)
set(CMAKE_C_COMPILER ${LLVM_TOOLCHAIN_BIN_PATH}clang)
#set(CMAKE_C_COMPILER wllvm)

set(CMAKE_ASM_COMPILER ${CMAKE_C_COMPILER})

#set(CMAKE_CXX_COMPILER ${TOOLCHAIN_PATH_AND_PREFIX}c++)
set(CMAKE_CXX_COMPILER ${LLVM_TOOLCHAIN_BIN_PATH}clang++)
#set(CMAKE_CXX_COMPILER wllvm++)

set(CMAKE_AR ${TOOLCHAIN_PATH_AND_PREFIX}ar)
set(CMAKE_RANLIB ${TOOLCHAIN_PATH_AND_PREFIX}ranlib)

set(CMAKE_OBJCOPY ${TOOLCHAIN_PATH_AND_PREFIX}objcopy CACHE INTERNAL "objcopy tool")
set(CMAKE_SIZE_UTIL ${TOOLCHAIN_PATH_AND_PREFIX}size CACHE INTERNAL "size tool")

#set(CMAKE_SYSROOT ${ARM_NONE_EABI_TOOLCHAIN_BIN_PATH})
#set(CMAKE_FIND_ROOT_PATH ${ARM_NONE_EABI_TOOLCHAIN_BIN_PATH})
#set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
#set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
#set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
