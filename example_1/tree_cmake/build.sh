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
version=3.18
echo "Build: $name $version"
mkdir -p ./$name
cd ./$name
cp -r ./../../CMakes/$name/CMakeLists.txt ./
if ! [ -d src ]; then
	echo "wget http://freeimage.cvs.sourceforge.net/viewvc/freeimage/FreeImage/?view=tar"
	wget -qO- http://freeimage.cvs.sourceforge.net/viewvc/freeimage/FreeImage/?view=tar  | tar xz
	mv ./FreeImage ./src
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
#	it clone https://git.openssl.org/openssl.git ./src
	git clone https://github.com/openssl/openssl.git ./src
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
	#git clone -b master https://github.com/mongodb/mongo-cxx-driver.git ./src	
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

