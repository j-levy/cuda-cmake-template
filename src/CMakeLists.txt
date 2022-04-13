cmake_minimum_required(VERSION 3.8)
project(${PROJECT_NAME} LANGUAGES CXX CUDA)

include_directories (.)

# configure_file( Version.h.in ${CMAKE_SOURCE_DIR}/sample/Version.h )

IF(STATIC)
    IF(APPLE)
        message(FATAL_ERROR "MacOSX does not support static linking. Please use -DSTATIC=OFF")
    ENDIF()
    SET(CMAKE_FIND_LIBRARY_SUFFIXES ".a")    
    SET(BUILD_SHARED_LIBRARIES OFF)
    SET(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -static")
ENDIF()

					
add_executable(${PROJECT_NAME}
				main.cpp
                kernel.cu
                otherfile.cpp)	
					

target_compile_features(${PROJECT_NAME} PUBLIC cxx_std_11)

set_target_properties( ${PROJECT_NAME}
                       PROPERTIES CUDA_SEPARABLE_COMPILATION ON
                      )
# SET_TARGET_PROPERTIES(sampleconvexalign PROPERTIES COMPILE_FLAGS " -g -O3 -shared-libgcc")
# SET_TARGET_PROPERTIES(sampleconvexalign PROPERTIES LINK_FLAGS " -g -O3 -shared-libgcc")

## these don't work...
# add_compile_options("$<$<CONFIG:RELEASE>: -W -Wall -O3 -pg -pedantic>")
# add_compile_options("$<$<CONFIG:DEBUG>: -W -Wall -O0 -pg -g -pedantic>")

# TARGET_LINK_LIBRARIES(sampleconvexalign ${ZLIB_LIBRARIES})
# TARGET_LINK_LIBRARIES(sampleconvexalign ${CMAKE_THREAD_LIBS_INIT})
# TARGET_LINK_LIBRARIES(sampleconvexalign ${LIBRARY_OUTPUT_PATH}/libconvexalign.a)

install (TARGETS ${PROJECT_NAME} DESTINATION bin)
