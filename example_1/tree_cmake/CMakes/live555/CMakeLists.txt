cmake_minimum_required(VERSION 2.8)
project( live555 )
message (STATUS "CMAKE ${PROJECT_NAME} " )

set(TARGET libliveMedia )
set(MAJOR 52)
set(MINOR 0.4)
set(SUFFIX .so)

set(PROJECT_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/src")
set(PROJECT_LIB_DIR "${PROJECT_SOURCE_DIR}/liveMedia")
set(PROJECT_LIB_INCLUDE_DIR "${PROJECT_SOURCE_DIR}/")


add_custom_target(${PROJECT_NAME} ALL DEPENDS ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}/lib/${TARGET}${SUFFIX}.${MAJOR}.${MINOR} )

set(LIBS 
	${PROJECT_SOURCE_DIR}/groupsock/libgroupsock.so.8.1.0
	${PROJECT_SOURCE_DIR}/liveMedia/libliveMedia.so.52.0.4
	${PROJECT_SOURCE_DIR}/BasicUsageEnvironment/libBasicUsageEnvironment.so.1.0.0
	${PROJECT_SOURCE_DIR}/UsageEnvironment/libUsageEnvironment.so.3.1.0			
)

ADD_CUSTOM_COMMAND(
	OUTPUT ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}/lib/${TARGET}${SUFFIX}.${MAJOR}.${MINOR}
#	COMMAND ./genMakefiles linux && ./configure --prefix=${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}  && make
#	COMMAND ./genMakefiles linux && make
	COMMAND ./genMakefiles linux-with-shared-libraries && make
	COMMAND cp -r ${PROJECT_SOURCE_DIR}/groupsock/libgroupsock.so.8.1.0 ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}/lib
	COMMAND cp -r ${PROJECT_SOURCE_DIR}/liveMedia/libliveMedia.so.52.0.4 ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}/lib
	COMMAND cp -r ${PROJECT_SOURCE_DIR}/BasicUsageEnvironment/libBasicUsageEnvironment.so.1.0.0 ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}/lib
	COMMAND cp -r ${PROJECT_SOURCE_DIR}/UsageEnvironment/libUsageEnvironment.so.3.1.0 ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}/lib
	WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
)

ADD_CUSTOM_COMMAND(
	  TARGET ${PROJECT_NAME}
	  POST_BUILD
          COMMAND ${CMAKE_COMMAND} -E make_directory ${LICENSE_OUTPUT_PATH}/${PROJECT_NAME}
          COMMAND ${CMAKE_COMMAND} -E make_directory ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME} 
          COMMAND ${CMAKE_COMMAND} -E make_directory ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}/bin 
          COMMAND ${CMAKE_COMMAND} -E make_directory ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}/lib 
          COMMAND ${CMAKE_COMMAND} -E make_directory ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}/include 
          COMMENT "POST BUILD"
)


file(GLOB_RECURSE HEADERS "${PROJECT_LIB_INCLUDE_DIR}/*.h*" )


set(LICENSES
	${PROJECT_SOURCE_DIR}/COPYING
)
 
INSTALL (
	FILES ${HEADERS} DESTINATION ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}/include
)

#INSTALL (
#	FILES ${LIBS} DESTINATION ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}/bin
#)


INSTALL (
	FILES ${LICENSES} DESTINATION ${LICENSE_OUTPUT_PATH}/${PROJECT_NAME}	
)

