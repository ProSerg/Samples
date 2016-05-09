cmake_minimum_required(VERSION 2.8)
project( ffmpeg )
message (STATUS "CMAKE ${PROJECT_NAME} " )

set(TARGET libavcodec )
set(MAJOR 2)
set(MINOR 9.3)
set(SUFFIX .so)

set(PROJECT_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/src")
set(PROJECT_LIB_DIR "${PROJECT_SOURCE_DIR}/")
set(PROJECT_LIB_INCLUDE_DIR "${PROJECT_SOURCE_DIR}/")

SUBDIRS ( ${CMAKE_SOURCE_DIR}/source/yasm ${CMAKE_SOURCE_DIR}/source/fribidi ${CMAKE_SOURCE_DIR}/source/libass  ${CMAKE_SOURCE_DIR}/source/theora ${CMAKE_SOURCE_DIR}/source/vorbis ${CMAKE_SOURCE_DIR}/source/x264 ${CMAKE_SOURCE_DIR}/source/x265 )


set(LD ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME} )

set(LIB ${PROJECT_LIB_DIR}/${TARGET}/${TARGET}${SUFFIX} ) 



add_custom_target(${PROJECT_NAME} ALL DEPENDS  
	${LIB}
	)

ADD_CUSTOM_COMMAND(
	OUTPUT  ${LIB}
	#COMMAND ./configure --enable-shared --prefix="${LD}" --extra-cflags="-I${LD}/include" --extra-ldflags="-L${LD}/lib" --pkg-config-flags="--static" --bindir="${LD}/bin" --enable-gpl --enable-libass --enable-libfreetype --enable-libtheora --enable-libvorbis --enable-libx264 --enable-libx265
	COMMAND ./build.sh
	WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
	COMMENT "FFMPEG-LIB"
)

ADD_CUSTOM_COMMAND(
	  TARGET ${PROJECT_NAME}
	  POST_BUILD
          COMMAND ${CMAKE_COMMAND} -E make_directory ${LICENSE_OUTPUT_PATH}/${PROJECT_NAME}
          COMMAND ${CMAKE_COMMAND} -E make_directory ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME} 
          COMMAND ${CMAKE_COMMAND} -E make_directory ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}/bin 
          COMMAND ${CMAKE_COMMAND} -E make_directory ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}/lib 
          COMMAND ${CMAKE_COMMAND} -E make_directory ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}/include 
          COMMENT "${PROJECT_NAME} BUILD"
)

ADD_DEPENDENCIES(${PROJECT_NAME} yasm fribidi libass theora vorbis x264 x265)


set(LICENSES
	${PROJECT_SOURCE_DIR}/COPYING.GPLv2
	${PROJECT_SOURCE_DIR}/COPYING.GPLv3
	${PROJECT_SOURCE_DIR}/COPYING.LGPLv2.1
	${PROJECT_SOURCE_DIR}/COPYING.LGPLv3
	${PROJECT_SOURCE_DIR}/LICENSE.md
)


INSTALL(
	FILES ${LICENSES} DESTINATION  ${LICENSE_OUTPUT_PATH}/${PROJECT_NAME}
)

