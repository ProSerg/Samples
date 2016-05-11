cmake_minimum_required(VERSION 2.8)
project( vorbis )
message (STATUS "CMAKE ${PROJECT_NAME} " )

set(TARGET libvorbis )
set(MAJOR 1)
set(MINOR 0)
set(SUFFIX .a)

set(FFMPEG ffmpeg)

set(PROJECT_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/src")
set(PROJECT_LIB_DIR "${PROJECT_SOURCE_DIR}/lib/.libs")
set(PROJECT_LIB_INCLUDE_DIR "${PROJECT_SOURCE_DIR}/")


add_custom_target(${PROJECT_NAME} ALL DEPENDS ${PROJECT_LIB_DIR}/${TARGET}${SUFFIX} )


ADD_CUSTOM_COMMAND(
	OUTPUT ${LIBRARY_OUTPUT_PATH}/${ffmpeg}/lib/${TARGET}${SUFFIX}
	COMMAND ./autogen.sh && ./configure --prefix="${LIBRARY_OUTPUT_PATH}/${FFMPEG}" && make -j4 && make install
	WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
)

ADD_CUSTOM_COMMAND(
	  TARGET ${PROJECT_NAME}
	  POST_BUILD
          COMMAND ${CMAKE_COMMAND} -E make_directory ${LICENSE_OUTPUT_PATH}/${PROJECT_NAME}
          COMMAND ${CMAKE_COMMAND} -E make_directory ${LIBRARY_OUTPUT_PATH}/${ffmpeg} 
          COMMAND ${CMAKE_COMMAND} -E make_directory ${LIBRARY_OUTPUT_PATH}/${ffmpeg}/bin 
          COMMAND ${CMAKE_COMMAND} -E make_directory ${LIBRARY_OUTPUT_PATH}/${ffmpeg}/lib 
          COMMAND ${CMAKE_COMMAND} -E make_directory ${LIBRARY_OUTPUT_PATH}/${ffmpeg}/include 
          COMMENT "POST BUILD"
)


set(
	LICENSE ${PROJECT_SOURCE_DIR}/COPYING
)

INSTALL(
        CODE
        "EXECUTE_PROCESS (
        COMMAND make install
        WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
        )
        "
)

INSTALL (
	FILES ${LICENSE} DESTINATION ${LICENSE_OUTPUT_PATH}/${PROJECT_NAME}
)


