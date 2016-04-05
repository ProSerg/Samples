#!/bin/bash

dirs="libA libB libC libD libE libG libH"
target=source

rm -rf ./$target

[ -d $target ] || mkdir $target

cd $target

for dir in $dirs; 
do
  echo "Build: $dir"
  mkdir -p ./$dir/src/
  echo "License of $dir" >> ./$dir/LICENSE
#  echo "Source of $dir" >> ./$dir/src/file.c
 
cat>>./$dir/src/fun.c <<EOF
#include <stdio.h>
#include "fun.h"
void fun(const char * text) {
	printf( "fun:%s\\n",text );
}
EOF

#  echo "Header of $dir" >> ./$dir/src/file.h

cat>>./$dir/src/fun.h <<EOF
#include <stdio.h>
void fun(const char * text);
EOF

#
cat>>./$dir/CMakeLists.txt <<EOF
cmake_minimum_required(VERSION 2.8)
project ($dir)
 
set (PROJECT_SOURCE_DIR \${CMAKE_CURRENT_SOURCE_DIR}/src)
set (PROJECT_INCLUDE_DIR \${PROJECT_SOURCE_DIR})

set(SOURCES 
\${PROJECT_SOURCE_DIR}/fun.c
)
 
set(HEADERS
\${PROJECT_SOURCE_DIR}/fun.h
)

#include_directories("")
#include_directories("")

message (STATUS "PATH: " \${CMAKE_CURRENT_SOURCE_DIR} )
message (STATUS "MAIN:PATH: " \${CMAKE_SOURCE_DIR} )
message (STATUS "LIB: "  \${LIBRARY_OUTPUT_PATH} )
message (STATUS "COMM: " \${CMAKE_COMMAND} )

add_library(\${PROJECT_NAME} SHARED \${SOURCES})

# если нужно чтобы библиотека копировалась в целевую директорию, а не в свою
#set_target_properties(\${PROJECT_NAME} PROPERTIES LIBRARY_OUTPUT_DIRECTORY \${LIBRARY_OUTPUT_PATH}/$dir/lib)
set_target_properties(\${PROJECT_NAME} PROPERTIES LIBRARY_OUTPUT_DIRECTORY \${CMAKE_CURRENT_SOURCE_DIR}/lib)


ADD_CUSTOM_COMMAND(
	  TARGET \${PROJECT_NAME}
          POST_BUILD

          COMMAND \${CMAKE_COMMAND} -E make_directory \${LICENSE_OUTPUT_PATH}/\${PROJECT_NAME}
          COMMAND \${CMAKE_COMMAND} -E make_directory \${LIBRARY_OUTPUT_PATH}/\${PROJECT_NAME}/bin 
          COMMAND \${CMAKE_COMMAND} -E make_directory \${LIBRARY_OUTPUT_PATH}/\${PROJECT_NAME}/lib 
          COMMAND \${CMAKE_COMMAND} -E make_directory \${LIBRARY_OUTPUT_PATH}/\${PROJECT_NAME}/include 
          COMMAND \${CMAKE_COMMAND} -E copy \${CMAKE_CURRENT_SOURCE_DIR}/lib/lib\${PROJECT_NAME}.so \${LIBRARY_OUTPUT_PATH}/\${PROJECT_NAME}/lib/\${PROJECT_NAME}.so
          COMMAND \${CMAKE_COMMAND} -E copy \${CMAKE_CURRENT_SOURCE_DIR}/LICENSE \${LICENSE_OUTPUT_PATH}/\${PROJECT_NAME}/LICENSE
)
EOF

done 
