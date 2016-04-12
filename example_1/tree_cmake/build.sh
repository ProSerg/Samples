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

name=openssl
echo "Build: $name"
mkdir -p ./$name
cd ./$name
cp -r ./../../CMakes/$name/CMakeLists.txt ./
if ! [ -d src ]; then
	git clone git://git.openssl.org/openssl.git ./src
fi
cd -

name=portaudio
echo "Build: $name"
mkdir -p ./$name
cd ./$name
cp -r ./../../CMakes/$name/CMakeLists.txt ./
if ! [ -d src ]; then
	svn co https://subversion.assembla.com/svn/portaudio/portaudio/trunk/ ./src
fi
cd -

	
name=sdl
echo "Build: $name"
mkdir -p ./$name
cd ./$name
cp -r ./../../CMakes/$name/CMakeLists.txt ./
if ! [ -d src ]; then
	#git clone "hg::http://hg.libsdl.org/SDL" ./src/
	wget https://www.libsdl.org/release/SDL2-2.0.4.tar.gz
	tar -zxf SDL2-2.0.4.tar.gz	
	mv ./SDL2-2.0.4 ./src
	rm -rf SDL2-2.0.4.tar.gz 
fi
cd -


name=mongocxx
echo "Build: $name"
mkdir -p ./$name
cd ./$name
cp -r ./../../CMakes/$name/CMakeLists.txt ./
if ! [ -d src ]; then
	git clone -b legacy https://github.com/mongodb/mongo-cxx-driver.git ./src	
fi
cd -


name=boost
echo "Build: $name"
mkdir -p ./$name
cd ./$name
cp -r ./../../CMakes/$name/CMakeLists.txt ./
if ! [ -d src ]; then
	git clone --recursive https://github.com/boostorg/boost.git ./src
	cd ./src 
	git checkout boost-1.60.0
	git submodule update
fi
cd -

