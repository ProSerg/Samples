#!/bin/bash

dirs="libxml2"
target=source

#./clean.sh

[ -d $target ] || mkdir $target

cd $target

name=libxml2
echo "Build: $name"
mkdir -p ./$name
cd ./$name
cp -r ./../../CMakes/$name/CMakeLists.txt ./
if ! [ -d src ]; then
	git clone https://git.gnome.org/browse/libxml2 ./src
fi 
cd - 

name=glew
echo "Build: $name"
mkdir -p ./$name
cd ./$name
cp -r ./../../CMakes/$name/CMakeLists.txt ./
if ! [ -d src ]; then
	git clone https://github.com/nigels-com/glew.git ./src
fi
cd -

name=glog
echo "Build: $name"
mkdir -p ./$name
cd ./$name
cp -r ./../../CMakes/$name/CMakeLists.txt ./
if ! [ -d src ]; then
	git clone https://github.com/google/glog.git ./src
fi
cd -


name=freeimage
echo "Build: $name"
mkdir -p ./$name
cd ./$name
cp -r ./../../CMakes/$name/CMakeLists.txt ./
if ! [ -d src ]; then
	wget http://downloads.sourceforge.net/freeimage/FreeImage3170.zip
	unzip ./FreeImage3170.zip
	mv ./FreeImage ./src
	rm -rf FreeImage3170.zip 
fi
cd -

name=live555
echo "Build: $name"
mkdir -p ./$name
cd ./$name
cp -r ./../../CMakes/$name/CMakeLists.txt ./
if ! [ -d src ]; then
	wget http://www.live555.com/liveMedia/public/live555-latest.tar.gz	
	tar -zxf live555-latest.tar.gz
	mv ./live ./src
	rm -rf live555-latest.tar.gz
fi
cd -

