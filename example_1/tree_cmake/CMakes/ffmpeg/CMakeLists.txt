cmake_minimum_required(VERSION 2.8)
project( ffmpeg )
message (STATUS "CMAKE ${PROJECT_NAME} " )

set(TARGET libmpeg )


set(MAJOR 2)
set(MINOR 9.3)
set(SUFFIX .so)

set(PROJECT_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/src")
set(PROJECT_LIB_DIR "${PROJECT_SOURCE_DIR}/")
set(PROJECT_LIB_INCLUDE_DIR "${PROJECT_SOURCE_DIR}/")



set(LD ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME} )

set(TARGET_YASM yasm )
set(LIB_YASM ${PROJECT_SOURCE_DIR}/${TARGET_YASM}/libyasm.a)

set(TARGET_FRIBIDI fribidi )
set(LIB_FRIBIDI ${PROJECT_SOURCE_DIR}/${TARGET_FRIBIDI}/lib/.libs/libfribidi.so )

set(TARGET_X264 x264 )
set(LIB_X264 ${PROJECT_SOURCE_DIR}/${TARGET_X264}/libx264.so )




add_custom_target(${PROJECT_NAME} ALL DEPENDS  
	${LIB_YASM}
	${LIB_FRIBIDI}
#	${LIB_X264}
	)

ADD_CUSTOM_COMMAND(
	OUTPUT ${LIB_YASM}
	COMMAND ./configure --prefix="${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}" --bindir="${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}/bin" && make && make install
	WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}/${TARGET_YASM}
	COMMENT "YASM-LIB"
)


ADD_CUSTOM_COMMAND(
	OUTPUT ${LIB_FRIBIDI}
	COMMAND ./bootstrap && ./configure --prefix="${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}" && make && make install
	WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}/${TARGET_FRIBIDI}
	COMMENT "FRIBIDI-LIB"
)

#ADD_CUSTOM_COMMAND(
#	OUTPUT  ${LIB_X264}
	#COMMAND export PKG_CONFIG_PATH="${LD}/lib/pkgconfig" && export PKG_CONFIG_LIBDIR="${LD}/lib/pkgconfig" && echo "$PKG_CONFIG_LIBDIR" && ./configure --prefix="${LD}" --bindir="${LD}/bin" --enable-static && make 
#	COMMAND ./configure
#	WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}/${TARGET_X264}
#	COMMENT "X264-LIB"
#)

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

#INSTALL(
#        CODE
#        "EXECUTE_PROCESS (
#        COMMAND make install
#        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/cdriver_src/
#        )
#        "
#)

