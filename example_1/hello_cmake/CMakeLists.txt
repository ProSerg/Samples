cmake_minimum_required (VERSION 2.8) 
 
set (PROJECT hello) 
 
project (${PROJECT}) 

#include_directories( ./src/foo )

MACRO(SUBDIRLIST result curdir)
  FILE(GLOB children RELATIVE ${curdir} ${curdir}/*)
  SET(dirlist "")
  FOREACH(child ${children})
    IF(IS_DIRECTORY ${curdir}/${child})
        LIST(APPEND dirlist ${child})
    ENDIF()
  ENDFOREACH()
  SET(${result} ${dirlist})
ENDMACRO()

MACRO(HEADER_DIRECTORIES return_list)
    FILE(GLOB_RECURSE new_list *.h)
    SET(dir_list "")
    FOREACH(file_path ${new_list})
        GET_FILENAME_COMPONENT(dir_path ${file_path} PATH)
        SET(dir_list ${dir_list} ${dir_path})
    ENDFOREACH()
    LIST(REMOVE_DUPLICATES dir_list)
    SET(${return_list} ${dir_list})
ENDMACRO()


SUBDIRLIST(SUBDIRS ${CMAKE_SOURCE_DIR}/src )
HEADER_DIRECTORIES(SUBDIR_H )

message( STATUS "CURDIR: " ${CMAKE_SOURCE_DIR}  )
message( STATUS "SUBDIRS: " ${SUBDIRS} )
message( STATUS "SUBDIRS: " ${SUBDIR_H} )


FOREACH(dir ${SUBDIRS})
	message( STATUS "DIR: " ${dir}  )
	include_directories(${CMAKE_SOURCE_DIR}/src/${dir})
	file(GLOB_RECURSE HEADERS ${CMAKE_SOURCE_DIR}/src/${dir}/*.h )
	file(GLOB_RECURSE SOURCES ${CMAKE_SOURCE_DIR}/src/${dir}/*.c )
	LIST (APPEND PROJECT_HEADERS ${HEADERS} )
	LIST (APPEND PROJECT_SOURCES ${SOURCES} )
ENDFOREACH()



message( STATUS "SRC: " ${SRC}  )


message( STATUS "LIST: " ${PROJECT_HEADERS} )
message( STATUS "LIST: " ${PROJECT_SOURCES} )

# настройка для компилятора
#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -Wall")
 
#set (MAIN_HEADERS 
#./src/foo/foo.h )
 
set (MAIN_SOURCES 
 main.c) 
 
add_executable (./bin/${PROJECT} ${MAIN_SOURCES} ${PROJECT_HEADERS} ${PROJECT_SOURCES})

