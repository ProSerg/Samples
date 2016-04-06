cmake_minimum_required(VERSION 2.8)
project( libxml2 )


message (STATUS "CMAKE ${PROJECT_NAME} " )

set(XML2_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/src")
set(XML2_LIB_DIR "${CMAKE_CURRENT_SOURCE_DIR}/lib")
set(XML2_LIB_INCLUDE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/include")

# это может заменить скрипт build.sh
#add_custom_target(subProjectTarget ALL)
#add_custom_command(TARGET subProjectTarget PRE_BUILD COMMAND mkdir -p ${CMAKE_BINARY_DIR}/subProject && cd ${CMAKE_BINARY_DIR}/subProject && ${CMAKE_COMMAND} ${CMAKE_SOURCE_DIR}/subProject && make)


add_custom_target ( 
    lib ALL
    COMMAND ./build.sh 
    WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
)


ADD_CUSTOM_COMMAND(
	TARGET lib
	COMMAND ${CMAKE_COMMAND} -E
#	FILE(GLOB_RECURSE libs ${CMAKE_CURRENT_SOURCE_DIR}/lib/lib/*.so  )
	COMMENT "!!!${lib}"
)

ADD_CUSTOM_COMMAND(
	  TARGET lib
          POST_BUILD
          COMMAND ${CMAKE_COMMAND} -E make_directory {LICENSE_OUTPUT_PATH}/${PROJECT_NAME}
          COMMAND ${CMAKE_COMMAND} -E make_directory ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}/bin 
          COMMAND ${CMAKE_COMMAND} -E make_directory ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}/lib 
          COMMAND ${CMAKE_COMMAND} -E make_directory ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}/include 
          COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_SOURCE_DIR}/lib/lib  ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}/bin
          COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/src/Copyright ${LICENSE_OUTPUT_PATH}/${PROJECT_NAME}/Copyright
          COMMENT "POST BUILD"
)
#for foreach list<files>
#FOREACH(file_h ${HEADERS} )
#    ADD_CUSTOM_COMMAND(	
#   	TARGET lib
#   	POST_BUILD
#   	COMMAND ${CMAKE_COMMAND} -E copy ${PROJECT_SOURCE_DIR}/${file_h}  ${LIBRARY_OUTPUT_PATH}/${PROJECT_NAME}/include/${file_h}
#	DEPENDS "${file_h}" processor # depends on the 'processor'
#        COMMENT "copy ${file_h}"
#    )
#ENDFOREACH(file_h)
