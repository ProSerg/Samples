cmake_minimum_required(VERSION 2.8)
project( qtpropertybrowser )
message (STATUS "CMAKE ${PROJECT_NAME} " )

set(TARGET libqtpropertybrowser )
set(MAJOR 1)
set(MINOR 0)
set(SUFFIX .a)

set(PROJECT_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/src")
set(PROJECT_LIB_DIR "${PROJECT_SOURCE_DIR}/")
set(PROJECT_LIB_INCLUDE_DIR "${PROJECT_SOURCE_DIR}/")


add_custom_target(${PROJECT_NAME} ALL DEPENDS ${PROJECT_LIB_DIR}/${TARGET}${SUFFIX} )


ADD_CUSTOM_COMMAND(
	OUTPUT ${PROJECT_LIB_DIR}/${TARGET}${SUFFIX}
	COMMAND mkdir -p ./build 
	COMMAND cd ./build && cmake -DCMAKE_INSTALL_PREFIX=${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME} .. && make -j4 
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


set(
	LICENSE ${PROJECT_SOURCE_DIR}/LICENSE 
)



INSTALL (
	FILES ${LICENSE} DESTINATION ${LICENSE_OUTPUT_PATH}/${PROJECT_NAME}
)


