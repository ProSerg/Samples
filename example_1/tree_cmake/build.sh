#!/bin/bash

dirs="libxml2"
target=source

#./clean.sh

[ -d $target ] || mkdir $target

cd $target

for dir in $dirs; 
do
  echo "Build: $dir"
  mkdir -p ./$dir
done

cd ./libxml2

cp -r ./../../CMakes/libxml2/CMakeLists.txt ./
if ! [ -d src ]; then
	wget ftp://xmlsoft.org/libxml2/libxml2-2.9.3.tar.gz -O - | tar -xz 
	mv libxml2-2.9.3 src
fi 
 


