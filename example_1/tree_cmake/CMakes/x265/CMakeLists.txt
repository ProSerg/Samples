cmake_minimum_required(VERSION 2.8)
project( x265 )
message (STATUS "CMAKE ${PROJECT_NAME} " )

set(TARGET libx265 )
set(MAJOR 1)
set(MINOR 0)
set(SUFFIX .a)

set(FFMPEG ffmpeg)

set(PROJECT_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/src")
set(PROJECT_LIB_DIR "${PROJECT_SOURCE_DIR}/build/linux")
set(PROJECT_LIB_INCLUDE_DIR "${PROJECT_SOURCE_DIR}/")


add_custom_target(${PROJECT_NAME} ALL DEPENDS ${LIBRARY_OUTPUT_PATH}/${FFMPEG}/lib/${TARGET}${SUFFIX} )


ADD_CUSTOM_COMMAND(
	OUTPUT ${LIBRARY_OUTPUT_PATH}/${FFMPEG}/lib/${TARGET}${SUFFIX}
	COMMAND  cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="${LIBRARY_OUTPUT_PATH}/${FFMPEG}"  ../../source && make -j4 && make install
	DEPENDS yasm
	WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}/build/linux
)

ADD_CUSTOM_COMMAND(
	  TARGET ${PROJECT_NAME}
	  POST_BUILD
          COMMAND ${CMAKE_COMMAND} -E make_directory ${LICENSE_OUTPUT_PATH}/${PROJECT_NAME}
          COMMAND ${CMAKE_COMMAND} -E make_directory ${LIBRARY_OUTPUT_PATH}/${FFMPEG} 
          COMMAND ${CMAKE_COMMAND} -E make_directory ${LIBRARY_OUTPUT_PATH}/${FFMPEG}/bin 
          COMMAND ${CMAKE_COMMAND} -E make_directory ${LIBRARY_OUTPUT_PATH}/${FFMPEG}/lib 
          COMMAND ${CMAKE_COMMAND} -E make_directory ${LIBRARY_OUTPUT_PATH}/${FFMPEG}/include 
          COMMENT "POST BUILD"
)


set(
	LICENSE ${PROJECT_SOURCE_DIR}/COPYING 
)

INSTALL(
        CODE
        "EXECUTE_PROCESS (
        COMMAND make install
        WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}/build/linux
        )
        "
)

INSTALL (
	FILES ${LICENSE} DESTINATION ${LICENSE_OUTPUT_PATH}/${PROJECT_NAME}
)


