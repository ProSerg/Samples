cmake_minimum_required (VERSION 2.8) 
 
set (PROJECT hello) 
set (TARGET libs)
set (LICENSE license)
set (SOURCE source)
set (CMAKE source)

#cmake_policy(SET CMP0009 NEW)
 
project (${PROJECT}) 

#include_directories( ./src/foo )


MACRO(RECDIRLIST return curdir)
  #FILE(GLOB_RECURSE children RELATIVE ${curdir} ${curdir}/*)
  FILE(GLOB_RECURSE children ${curdir}/*  )
  SET(dirlist "")
 
  FOREACH(child ${children})
    GET_FILENAME_COMPONENT(dirpath ${child} PATH)
    LIST(APPEND dirlist ${dirpath})
  ENDFOREACH()
  LIST(REMOVE_DUPLICATES dirlist)
  SET(${return} ${dirlist})

ENDMACRO()

MACRO(SUBDIRLIST return curdir)
  FILE(GLOB children RELATIVE ${curdir} ${curdir}/*)
  SET(dirlist "")
 
  FOREACH(child ${children})
	IF(IS_DIRECTORY ${curdir}/${child})
        	LIST(APPEND dirlist ${child})
    	ENDIF()
  ENDFOREACH()
  LIST(REMOVE_DUPLICATES dirlist)
  SET(${return} ${dirlist})

ENDMACRO()

SUBDIRLIST(SUBDIRS ${CMAKE_SOURCE_DIR}/source )

set( LIBRARY_OUTPUT_PATH ${CMAKE_SOURCE_DIR}/${TARGET})
set( LICENSE_OUTPUT_PATH ${CMAKE_SOURCE_DIR}/${LICENSE})

set (SUBDIRS 
	boost
	cpp-netlib
	ffmpeg
	freeimage
	freetype
	gflags
	glew
	glog
	googletest
	libxml2
	live555
	mongocxx
	ogre
	openssl
	portaudio
	protobuf
	rtmpdump
	sdl	
)
 

FOREACH(dir ${SUBDIRS})
	file(MAKE_DIRECTORY ${CMAKE_SOURCE_DIR}/${TARGET} )
	message( STATUS "BUILD: " ${CMAKE_SOURCE_DIR}/source/${dir}  )
	add_subdirectory( ${CMAKE_SOURCE_DIR}/${CMAKE}/${dir}  ${CMAKE_SOURCE_DIR}/${CMAKE}/${dir}/build )
ENDFOREACH()



