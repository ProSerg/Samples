cmake_minimum_required(VERSION 2.8)
project( boost )
message (STATUS "CMAKE ${PROJECT_NAME} " )

set(TARGET libboost )
set(MAJOR 1)
set(MINOR 60.0)
set(SUFFIX .so)

set(PROJECT_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/src")
set(PROJECT_LIB_DIR "${PROJECT_SOURCE_DIR}/stage/lib")
set(PROJECT_LIB_INCLUDE_DIR "${PROJECT_SOURCE_DIR}/include/libxml")


add_custom_target(${PROJECT_NAME} ALL DEPENDS ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}/bin/${TARGET}_system${SUFFIX} )

message(STATUS "PATH: ${PROJECT_SOURCE_DIR}" )

ADD_CUSTOM_COMMAND(
	OUTPUT ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}/bin/${TARGET}_system${SUFFIX}
	COMMAND ./bootstrap.sh && ./b2 headers && ./b2 link=shared variant=release --libdir=${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}/bin --includedir=${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}
	COMMAND ./b2 link=shared variant=release --libdir=${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}/bin --includedir=${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}  install
	DEPENDS openssl
	WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
)

ADD_CUSTOM_COMMAND(
	  TARGET ${PROJECT_NAME}
	  POST_BUILD
          COMMAND ${CMAKE_COMMAND} -E make_directory ${LICENSE_OUTPUT_PATH}/${PROJECT_NAME}
          COMMAND ${CMAKE_COMMAND} -E make_directory ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME} 
          COMMAND ${CMAKE_COMMAND} -E make_directory ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}/bin 
          COMMAND ${CMAKE_COMMAND} -E make_directory ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}/lib 
          COMMENT "POST BUILD"
)


file(GLOB HEADERS "${PROJECT_LIB_INCLUDE_DIR}/*.h" )


set(LIBS 
 /bin/libboost_chrono.a
 /bin/libboost_exception.a
 /bin/libboost_system.a
 /bin/libboost_test_exec_monitor.a
 /bin/libboost_timer.a
 /bin/libboost_unit_test_framework.a
)

set(LICENSES
	${PROJECT_SOURCE_DIR}/LICENSE_1_0.txt
)

#INSTALL(
#	CODE
#	"EXECUTE_PROCESS (
#	COMMAND ./b2 link=shared variant=release --libdir=${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}/bin --includedir=${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}  install 
#	WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
#	)
#	"
#)

#INSTALL(
#        CODE
#        "EXECUTE_PROCESS (
#        COMMAND rm -rf ./include
#        WORKING_DIRECTORY ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME} 
#        )
#        "
#)


#INSTALL(
#	CODE
#  	"EXECUTE_PROCESS (
#	COMMAND mv ./boost ./include
#	WORKING_DIRECTORY ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME} 
#	)
#	"
#)



#INSTALL(
#	CODE
#	"EXECUTE_PROCESS (
#	COMMAND rm -rf ./${PROJECT_NAME}/bin/libboost_chrono.a 
#	COMMAND rm -rf ./${PROJECT_NAME}/bin/libboost_exception.a 
#	COMMAND rm -rf ./${PROJECT_NAME}/bin/libboost_system.a 
#	COMMAND rm -rf ./${PROJECT_NAME}/bin/libboost_test_exec_monitor.a
#	COMMAND rm -rf ./${PROJECT_NAME}/bin/libboost_timer.a 
#	COMMAND rm -rf ./${PROJECT_NAME}/bin/libboost_unit_test_framework.a
#	WORKING_DIRECTORY ${LIBRARY_OUTPUT_PATH} 
#	)
#	"
#)

INSTALL (
	FILES ${LICENSES} DESTINATION ${LICENSE_OUTPUT_PATH}/${PROJECT_NAME}	
)

