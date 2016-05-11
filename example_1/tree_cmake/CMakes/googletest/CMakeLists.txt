cmake_minimum_required(VERSION 2.8)
project( googletest )
message (STATUS "CMAKE ${PROJECT_NAME} " )

set(TARGET libgtest)
set(MAJOR 1)
set(MINOR 0)
set(SUFFIX .a)

set(PROJECT_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/src")
set(PROJECT_LIB_DIR "${PROJECT_SOURCE_DIR}/build/googlemock/gtest")
set(PROJECT_LIB_INCLUDE_DIR "${PROJECT_SOURCE_DIR}/build")


add_custom_target(${PROJECT_NAME} ALL DEPENDS ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}/lib/${TARGET}${SUFFIX} )


ADD_CUSTOM_COMMAND(
	OUTPUT ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}/lib/${TARGET}${SUFFIX}
	COMMAND mkdir -p ./build
	COMMAND cd ./build && cmake -DCMAKE_INSTALL_PREFIX=${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME} .. && make -j4 && make install
	WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
)

ADD_CUSTOM_COMMAND(
	  TARGET ${PROJECT_NAME}
	  POST_BUILD
          COMMAND ${CMAKE_COMMAND} -E make_directory ${LICENSE_OUTPUT_PATH}/googletest
          COMMAND ${CMAKE_COMMAND} -E make_directory ${LICENSE_OUTPUT_PATH}/googlemosk
          COMMAND ${CMAKE_COMMAND} -E make_directory ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME} 
          COMMAND ${CMAKE_COMMAND} -E make_directory ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}/bin 
          COMMAND ${CMAKE_COMMAND} -E make_directory ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}/lib 
          COMMAND ${CMAKE_COMMAND} -E make_directory ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}/include 
          COMMENT "POST BUILD"
)


set(GTEST
	${PROJECT_SOURCE_DIR}/googletest/LICENSE
)


set(GMOCK
	${PROJECT_SOURCE_DIR}/googlemock/LICENSE
)

#INSTALL(
#        CODE
#        "EXECUTE_PROCESS (
#        COMMAND make install
#        WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}/build
#        )
#        "
#)


INSTALL (
	FILES ${GTEST} DESTINATION ${LICENSE_OUTPUT_PATH}/googletest
)

INSTALL (
	FILES ${GMOCK} DESTINATION ${LICENSE_OUTPUT_PATH}/googlemosk
)
