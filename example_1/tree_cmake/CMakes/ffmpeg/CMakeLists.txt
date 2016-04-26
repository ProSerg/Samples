cmake_minimum_required(VERSION 2.8)
project( ffmpeg )
message (STATUS "CMAKE ${PROJECT_NAME} " )

set(TARGET libmpeg )

#set(CDRIVER libmongoc-1.0 )
#set(CDRIVER libmongoc-1.0 )
#set(CDRIVER libmongoc-1.0 )
#set(CDRIVER libmongoc-1.0 )

set(MAJOR 2)
set(MINOR 9.3)
set(SUFFIX .so)

set(PROJECT_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/src")
set(PROJECT_LIB_DIR "${PROJECT_SOURCE_DIR}/")
set(PROJECT_LIB_INCLUDE_DIR "${PROJECT_SOURCE_DIR}/")

set(CDRIVER_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/")
set(CDRIVER_LIB_DIR "${CDRIVER_SOURCE_DIR}/")



#add_custom_target(${PROJECT_NAME} ALL DEPENDS  ${CDRIVER_LIB_DIR}/${CDRIVER}${SUFFIX}.0  ${PROJECT_LIB_DIR}/${TARGET}${SUFFIX}   )

#ADD_CUSTOM_COMMAND(
#	OUTPUT ${CDRIVER_LIB_DIR}/${CDRIVER}${SUFFIX}.0
#	COMMAND ./autogen.sh --prefix=${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME} && make && make install
#	WORKING_DIRECTORY ${CDRIVER_SOURCE_DIR}
#	COMMENT "MONGOC-DRIVER"
#)
#
#
#ADD_CUSTOM_COMMAND(
#	OUTPUT ${PROJECT_LIB_DIR}/${TARGET}${SUFFIX}
#	COMMAND mkdir -p ./build && cd ./build && PKG_CONFIG_PATH=${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}/lib/pkgconfig/ cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}  .. && make && make install
#	WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
#	COMMENT "MONGOCXX-DRIVER"
#)
#
#ADD_CUSTOM_COMMAND(
#	  TARGET ${PROJECT_NAME}
#	  POST_BUILD
#          COMMAND ${CMAKE_COMMAND} -E make_directory ${LICENSE_OUTPUT_PATH}/${PROJECT_NAME}
#          COMMAND ${CMAKE_COMMAND} -E make_directory ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME} 
#          COMMAND ${CMAKE_COMMAND} -E make_directory ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}/bin 
#          COMMAND ${CMAKE_COMMAND} -E make_directory ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}/lib 
#          COMMAND ${CMAKE_COMMAND} -E make_directory ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}/include 
#          COMMENT "POST BUILD"
#)
#
#
#
#INSTALL(
#        CODE
#        "EXECUTE_PROCESS (
#        COMMAND make install
#        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/cdriver_src/
#        )
#        "
#)
#
#INSTALL(
#        CODE
#        "EXECUTE_PROCESS (
#        COMMAND make install
#        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/src/build
#        )
#        "
#)
#
#INSTALL(
#        CODE
#        "EXECUTE_PROCESS (
#        COMMAND rm -rf ./bin
#        WORKING_DIRECTORY ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}
#        )
#        "
#)
#
#
#INSTALL(
#	 CODE 
#	 "FILE(GLOB_RECURSE LIBS ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}/lib/*.so ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}/lib/*.so* ) \n
#   	 FILE(INSTALL DESTINATION ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}/bin
#   	 TYPE FILE FILES \${LIBS}
#   	 )"
#)
#
#
#INSTALL(
#        CODE
#        "EXECUTE_PROCESS (
#	COMMAND rm -rf ./lib
#        WORKING_DIRECTORY ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}
#        )
#	"
#)
#
#
#INSTALL(
#        CODE
#        "EXECUTE_PROCESS (
#        COMMAND mkdir -p lib
#        WORKING_DIRECTORY ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}
#        )
#        "
#)
#
#
#
#INSTALL(
#        CODE
#        "EXECUTE_PROCESS (	
#	COMMAND mkdir -p ${LICENSE_OUTPUT_PATH}/libson
#	COMMAND cp -r ./share/doc/libbson/COPYING ${LICENSE_OUTPUT_PATH}/libson/ 
#	COMMAND cp -r ./share/doc/mongo-c-driver/COPYING ${LICENSE_OUTPUT_PATH}/${PROJECT_NAME}
#	COMMAND rm -rf ./share
#	COMMAND echo \"A\"
#        WORKING_DIRECTORY ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME} 
#        )
#	"
#)