cmake_minimum_required(VERSION 3.8)

# note: __shfl is deprecated. The non-sync definitions of warp shuffle functions ( __shfl, __shfl_up, __shfl_down, and __shfl_xor ) and warp vote functions (__any, __all, __ballot) have been removed when compilation is targeting devices with compute capability 7.x and higher.
# for now I set architecture to 6.0 max.

if(NOT DEFINED CMAKE_CUDA_ARCHITECTURES)
  set(CMAKE_CUDA_ARCHITECTURES 75)
endif()

project(PROJECTNAME LANGUAGES CXX CUDA)

include(CheckCXXCompilerFlag)


option(STATIC "Build static binary" OFF)


# Set a default build type for single-configuration
# CMake generators if no build type is set.
# RELEASE, RELWITHDEBINFO, DEBUG
IF(NOT CMAKE_CONFIGURATION_TYPES AND NOT CMAKE_BUILD_TYPE)
  message(STATUS "No build type specified. Using 'RELWITHDEBINFO'")
  SET(CMAKE_BUILD_TYPE RELWITHDEBINFO)
ENDIF(NOT CMAKE_CONFIGURATION_TYPES AND NOT CMAKE_BUILD_TYPE)


set( NGM_VERSION_MAJOR 0 )
set( NGM_VERSION_MINOR 1 )
IF(CMAKE_BUILD_TYPE STREQUAL "Debug")
    message(STATUS "Building in debug mode!")
    set( NGM_VERSION_BUILD 0-debug )
else()
  set( NGM_VERSION_BUILD 0 )
ENDIF()

# find_package( ZLIB REQUIRED )
find_package ( Threads REQUIRED )


CHECK_CXX_COMPILER_FLAG("-std=c++11" COMPILER_SUPPORTS_CXX11)
if(COMPILER_SUPPORTS_CXX11)
    IF(NOT APPLE)
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
    ELSE()
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -stdlib=libc++")
    ENDIF()
else()
    message(FATAL_ERROR "The compiler ${CMAKE_CXX_COMPILER} has no C++11 support. Please use a different C++ compiler.")
endif()

set(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/bin/${PROJECT_NAME}-${NGM_VERSION_MAJOR}.${NGM_VERSION_MINOR}.${NGM_VERSION_BUILD}/)
set(LIBRARY_OUTPUT_PATH    ${PROJECT_SOURCE_DIR}/lib/${PROJECT_NAME}-${NGM_VERSION_MAJOR}.${NGM_VERSION_MINOR}.${NGM_VERSION_BUILD}/)
file(MAKE_DIRECTORY ${EXECUTABLE_OUTPUT_PATH})

add_subdirectory(src)
# add_subdirectory(sample)
