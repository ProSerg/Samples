#!/bin/bash

target=source
root=`pwd`
#./clean.sh

[ -d $target ] || mkdir $target

cd $target

name=libxml2
version=2.4.16
echo "Build: $name $version"
mkdir -p ./$name
cd ./$name
cp -r ./../../CMakes/$name/CMakeLists.txt ./
if ! [ -d src ]; then
	git clone https://git.gnome.org/browse/libxml2 ./src
fi 
cd $root/$target

name=glew
version=1.13.0
echo "Build: $name $version"
mkdir -p ./$name
cd ./$name
cp -r ./../../CMakes/$name/CMakeLists.txt ./
if ! [ -d src ]; then
	git clone https://github.com/nigels-com/glew.git ./src
fi
cd $root/$target

name=glog
version=0.3.4
echo "Build: $name $version"
mkdir -p ./$name
cd ./$name
cp -r ./../../CMakes/$name/CMakeLists.txt ./
if ! [ -d src ]; then
	git clone https://github.com/google/glog.git ./src
fi
cd $root/$target



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
cd $root/$target

name=live555
version=latest
echo "Build: $name $version"
mkdir -p ./$name
cd ./$name
cp -r ./../../CMakes/$name/CMakeLists.txt ./
if ! [ -d src ]; then
	wget http://www.live555.com/liveMedia/public/live555-latest.tar.gz	
	tar -zxf live555-latest.tar.gz
	mv ./live ./src
	rm -rf live555-latest.tar.gz
fi
cd $root/$target

name=openssl
version=1.1.0
echo "Build: $name $version"
mkdir -p ./$name
cd ./$name
cp -r ./../../CMakes/$name/CMakeLists.txt ./
if ! [ -d src ]; then
	git clone https://github.com/openssl/openssl.git ./src
fi
cd $root/$target

name=portaudio
version=v19
echo "Build: $name $version"
mkdir -p ./$name
cd ./$name
cp -r ./../../CMakes/$name/CMakeLists.txt ./
if ! [ -d src ]; then
	svn co https://subversion.assembla.com/svn/portaudio/portaudio/trunk/ ./src
fi
cd $root/$target

	
name=sdl
version=2.0.4
echo "Build: $name $version"
mkdir -p ./$name
cd ./$name
cp -r ./../../CMakes/$name/CMakeLists.txt ./
if ! [ -d src ]; then
	wget https://www.libsdl.org/release/SDL2-2.0.4.tar.gz
	tar -zxf SDL2-2.0.4.tar.gz	
	mv ./SDL2-2.0.4 ./src
	rm -rf SDL2-2.0.4.tar.gz 
fi
cd $root/$target


name=mongocxx
version=3.0.0
echo "Build: $name $version"
mkdir -p ./$name
cd ./$name
cp -r ./../../CMakes/$name/CMakeLists.txt ./
if ! [ -d src ]; then
	git clone https://github.com/mongodb/mongo-c-driver ./cdriver_src/
	cd ./cdriver_src/
	git checkout 1.3.4
	cd ../
	git clone -b master https://github.com/mongodb/mongo-cxx-driver.git ./src
	cd ./src
	git checkout r3.0.0
	cd ../	
fi
cd $root/$target


name=boost
version=1.60
echo "Build: $name $version"
mkdir -p ./$name
cd ./$name
cp -r ./../../CMakes/$name/CMakeLists.txt ./
if ! [ -d src ]; then
	git clone --recursive https://github.com/boostorg/boost.git ./src
	cd ./src 
	git checkout boost-1.60.0
	git submodule update
fi
cd $root/$target


name=cpp-netlib
version=0.12
echo "Build: $name $version"
#mkdir -p ./$name
#cd ./$name
#cp -r ./../../CMakes/$name/CMakeLists.txt ./
#if ! [ -d src ]; then
#	git clone https://github.com/cpp-netlib/cpp-netlib ./src
#    	cd ./src
#    	git submodule init
#    	git submodule update
#fi
#cd $root/$target

name=googletest
version=1.0
echo "Build: $name $version"
mkdir -p ./$name
cd ./$name
cp -r ./../../CMakes/$name/CMakeLists.txt ./
if ! [ -d src ]; then
        git clone https://github.com/google/googletest.git ./src
fi
cd $root/$target


name=protobuf
version=1.0
echo "Build: $name $version"
mkdir -p ./$name
cd ./$name
cp -r ./../../CMakes/$name/CMakeLists.txt ./
if ! [ -d src ]; then
	git clone https://github.com/google/protobuf.git ./src	
fi
cd $root/$target

