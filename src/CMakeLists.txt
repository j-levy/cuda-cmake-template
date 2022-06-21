cmake_minimum_required(VERSION 3.10)
project(${PROJECT_NAME} LANGUAGES CXX CUDA)

include_directories (include)

# configure_file( Version.h.in ${CMAKE_SOURCE_DIR}/sample/Version.h )

IF(STATIC)
    IF(APPLE)
        message(FATAL_ERROR "MacOSX does not support static linking. Please use -DSTATIC=OFF")
    ENDIF()
    SET(CMAKE_FIND_LIBRARY_SUFFIXES ".a")    
    SET(BUILD_SHARED_LIBRARIES OFF)
    SET(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -static")
ENDIF()

					
add_executable(main_executable_name
				main.cpp
                )	
					

add_executable(cuda_executable_name
                main_cuda.cu
                add.cu
                )	

target_compile_features(main_executable_name PUBLIC cxx_std_11)
target_compile_features(cuda_executable_name PUBLIC cxx_std_11)


set_target_properties(cuda_executable_name
                       PROPERTIES CUDA_SEPARABLE_COMPILATION ON
                      )

target_compile_options(cuda_executable_name PRIVATE $<$<COMPILE_LANGUAGE:CUDA>:
            -G
            >)
target_compile_options(main_executable_name PRIVATE $<$<COMPILE_LANGUAGE:CXX>:
            -g
            >)

install (TARGETS cuda_executable_name DESTINATION bin)
install (TARGETS main_executable_name DESTINATION bin)
