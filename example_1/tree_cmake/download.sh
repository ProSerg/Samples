#!/bin/bash

. ./custom.sh

LOG="NO"

OUT="> /dev/null"

colors

libs=libs
target=source
root=`pwd`
#./clean.sh

[ -d $target ] || mkdir -p $target
[ -d $libs ] || mkdir -p $libs
[ -d ./CBin ] || mkdir -p ./CBin

cd $target

function download_libxml2() 
{
	name=libxml2
	version=2.4.16
	download_msg "$name $version"
	mkdir -p $root/$target/$name
	cd $root/$target/$name
	if ! [ -d src ]; then
		git clone https://git.gnome.org/browse/libxml2 ./src
	fi 
}

function download_glew() 
{
	name=glew
	version=1.13.0
	download_msg "$name $version"
	mkdir -p $root/$target/$name
	cd $root/$target/$name
	if ! [ -d src ]; then
		git clone https://github.com/nigels-com/glew.git ./src
	fi
}

function download_gflags() 
{
	name=gflags
	vesrion=2.1.2
	download_msg "$name $version"
	mkdir -p $root/$target/$name
	cd $root/$target/$name
	if ! [ -d src ]; then
		git clone https://github.com/gflags/gflags.git ./src
	fi
}

function download_glog()
{
	name=glog
	version=0.3.4
	download_msg "$name $version"
	mkdir -p $root/$target/$name
	cd $root/$target/$name
	if ! [ -d src ]; then
		git clone https://github.com/google/glog.git ./src
	fi
}

function download_freeimage()
{
	name=freeimage
	version=3.18
	download_msg "$name $version"
	mkdir -p $root/$target/$name
	cd $root/$target/$name
	if ! [ -d src ]; then
		url=http://freeimage.cvs.sourceforge.net/viewvc/freeimage/FreeImage/?view=tar
		echo " "
		echo "wget $url"
	#	curl -# $url | tar xz
		wget -qO- $url | tar xz  	
		mv ./FreeImage ./src
	fi
}

function download_live555()
{
	name=live555
	version=latest
	download_msg "$name $version"
	mkdir -p $root/$target/$name
	cd $root/$target/$name
	if ! [ -d src ]; then
		url=http://www.live555.com/liveMedia/public/live555-latest.tar.gz
		echo " "
		echo "wget $url"
		curl -# $url | tar xz
		#wget -q0-  $url | tar xz
		mv ./live ./src
		rm -rf live555-latest.tar.gz
	fi
}

function download_openssl()
{
	name=openssl
	version=1.1.0
	download_msg "$name $version"
	mkdir -p $root/$target/$name
	cd $root/$target/$name
	if ! [ -d src ]; then
		git clone https://github.com/openssl/openssl.git ./src
		cd ./src
		git checkout remotes/origin/OpenSSL_1_0_1-stable 
		git pull
	fi
}

function download_portaudio()
{
	name=portaudio
	version=v19
	download_msg "$name $version"
	mkdir -p $root/$target/$name
	cd $root/$target/$name
	if ! [ -d src ]; then
		echo "Cloning : to ./src "
		url=https://subversion.assembla.com/svn/portaudio/portaudio/trunk/
		svn co $url ./src 2>&1> /dev/null
	fi
}

function download_sdl()
{
	name=sdl
	version=2.0.4
	download_msg "$name $version"
	mkdir -p $root/$target/$name
	cd $root/$target/$name
	if ! [ -d src ]; then
		url=https://www.libsdl.org/release/SDL2-2.0.4.tar.gz
		echo " "
		echo "curl $url"
		curl -# $url | tar xz	
		mv ./SDL2-2.0.4 ./src
		rm -rf SDL2-2.0.4.tar.gz 
	fi
	cd $root/$target
}

function download_mongocxx()
{
	name=mongocxx
	version=3.0.0
	download_msg "$name $version"
	mkdir -p $root/$target/$name
	cd $root/$target/$name
	if ! [ -d src ]; then
		git clone https://github.com/mongodb/mongo-c-driver ./cdriver_src/
		cd ./cdriver_src/
		git checkout 1.3.4 > /dev/null
		cd ../
		git clone -b master https://github.com/mongodb/mongo-cxx-driver.git ./src
		cd ./src
		git checkout r3.0.0 > /dev/null
		cd ../	
	fi
	cd $root/$target
}

##FIXME ADD THE PATCH
function download_boost()
{
	name=boost
	version=1.60
	download_msg "$name $version"
	mkdir -p $root/$target/$name
	cd $root/$target/$name
	if ! [ -d src ]; then
		git clone https://github.com/boostorg/boost.git ./src
		cd ./src 
		libs=./libs
		
		exc="compute dll hana metaparse"
		dirs=`find $libs/* -maxdepth 0 -type d `	

		# исключаем директории из выборки 
		for dir in $exc ;do
				dirs="${dirs/$libs\/$dir/}"
		done

		dirs=`echo "$dirs" | awk '/./'`
		count=`echo "$dirs" | wc -l`
		i=1
		
		for dir in  $dirs ; do
			echo "Submodule: ($i/$count) $dir"	
			git submodule --quiet update --init $dir
			let "i = $i +1"
				tput cuu1
			tput ed
		done
		git submodule --quiet update --init  
		git checkout --quiet boost-1.60.0 
		git submodule --quiet update 
	fi
}


function download_cpp-netlib()
{
	name=cpp-netlib
	version=0.12
	download_msg "$name $version"
	mkdir -p $root/$target/$name
	cd $root/$target/$name
	cp -r ./../../CMakes/$name/build.sh ./
	if ! [ -d src ]; then
		git clone https://github.com/cpp-netlib/cpp-netlib ./src
		cd ./src 
			git checkout $version-release
			git submodule init
			git submodule update
	fi
}

function download_googletest()
{
	name=googletest
	version=1.0
	download_msg "$name $version"
	mkdir -p $root/$target/$name
	cd $root/$target/$name
	if ! [ -d src ]; then
			git clone https://github.com/google/googletest.git ./src
	fi
}

function download_protobuf()
{
	name=protobuf
	version=1.0
	download_msg "$name $version"
	mkdir -p $root/$target/$name
	cd $root/$target/$name
	cp -r ./../../CMakes/$name/CMakeLists.txt ./
	if ! [ -d src ]; then
		git clone https://github.com/google/protobuf.git ./src	
	fi
}

function download_ogre()
{
	name=ogre
	version=1.10
	download_msg "$name $version"
	mkdir -p $root/$target/$name
	cd $root/$target/$name
	if ! [ -d src ]; then
		hg clone https://bitbucket.org/sinbad/ogre ./src
		cd ./src
		hg checkout v1-10
		cd ..
	fi
	if ! [ -d deps ]; then
		hg clone https://bitbucket.org/cabalistic/ogredeps ./deps
	fi
}

function download_freetype()
{
	name=freetype
	version=2.6.3
	download_msg "$name $version"
	mkdir -p $root/$target/$name
	cd $root/$target/$name
	if ! [ -d src ]; then
		git clone http://git.sv.nongnu.org/r/freetype/freetype2.git ./src
		if ! [ -d src ]; then
			wget https://sourceforge.net/projects/freetype/files/freetype2/$version/freetype-"$version".tar.bz2
			tar xjf freetype-"$version".tar.bz2
			mv freetype-"$version" ./src
			rm -rf  freetype-"$version".tar.bz2
		fi
	fi 
}

function download_yasm()
{
	name=yasm
	version=1.3
	download_msg "$name $version"
	mkdir -p $root/$target/$name
	cd $root/$target/$name
	if ! [ -d src ]; then
		wget http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz
		tar xzf yasm-1.3.0.tar.gz
		mv yasm-1.3.0 src
		rm -rf yasm-1.3.0.tar.gz
	fi
}

function download_ffmpeg()
{
	name=ffmpeg
	version=1.0
	download_msg "$name $version"
	mkdir -p $root/$target/$name
	cd $root/$target/$name
#	cp -r ./../../CMakes/$name/CMakeLists.txt ./
	cp -r ./../../CMakes/$name/build.sh ./
	if ! [ -d src ]; then
		url=http://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2
        echo "wget $url"
        wget $url
		tar xjf ffmpeg-snapshot.tar.bz2
		mv ffmpeg src
        rm -rf ffmpeg-snapshot.tar.bz2
	fi
}

function download_x264()
{
	name=x264
	version=1.0
	download_msg "$name $version"
	mkdir -p $root/$target/$name
	cd $root/$target/$name
	cp -r ./../../CMakes/$name/CMakeLists.txt ./
	cp -r ./../../CMakes/$name/build.sh ./
	if ! [ -d src ]; then
		url=http://download.videolan.org/pub/x264/snapshots/last_x264.tar.bz2
        wget  $url 
		tar xjf last_x264.tar.bz2
        rm -rf last_x264.tar.bz2
		mv ./x264-snapshot* ./src
	fi
}

function download_x265() 
{
	name=x265
	version=1.0
	download_msg "$name $version"
	mkdir -p $root/$target/$name
	cd $root/$target/$name
	if ! [ -d src ]; then
		wget https://bitbucket.org/multicoreware/x265/downloads/x265_1.9.tar.gz
		tar xzf x265_1.9.tar.gz
		mv x265_1.9 ./src
		rm -rf x265_1.9.tar.gz
		
	fi
}


function download_rtmp() 
{
	name=rtmp
	version=1.0
	download_msg "$name $version"
	mkdir -p $root/$target/$name
	cd $root/$target/$name
	if ! [ -d src ]; then
		git clone https://git.ffmpeg.org/rtmpdump ./src
    fi
}

function download_libass() 
{
	name=libass
	version=1.0
	download_msg "$name $version"
	mkdir -p $root/$target/$name
	cd $root/$target/$name
	cp -r ./../../CMakes/$name/build.sh ./
	if ! [ -d src ]; then
		git clone https://github.com/libass/libass.git ./src
	fi
	cd $root/$target
}

function download_theora() 
{
	name=theora
	version=1.0
	download_msg "$name $version"
	mkdir -p $root/$target/$name
	cd $root/$target/$name
	if ! [ -d src ]; then
		git clone https://git.xiph.org/theora.git ./src
	fi
}

function download_vorbis() 
{
	name=vorbis
	version=1.0
	download_msg "$name $version"
	mkdir -p $root/$target/$name
	cd $root/$target/$name
	if ! [ -d src ]; then
		git clone https://git.xiph.org/vorbis.git ./src
	fi
	cd $root/$target
}

function download_fribidi() 
{
	name=fribidi
	version=0.19.7
	download_msg "$name $version"
	mkdir -p $root/$target/$name
	cd $root/$target/$name
	if ! [ -d src ]; then
		wget http://fribidi.org/download/fribidi-0.19.7.tar.bz2
		bzip2 -cd fribidi-0.19.7.tar.bz2  | tar xf -
        mv fribidi-0.19.7 ./src
        rm -rf fribidi-0.19.7.tar.bz2
	fi
}
	
function download_Qt() 
{
	name=Qt
    version=5.6
    download_msg "$name $version"
    mkdir -p $root/$target/$name
    cd $root/$target/$name
    if ! [ -d $root/$libs/$name/$version ]; then
		[ -d qt-online-installer  ] || git clone https://github.com/sarbjit-longia/qt-online-installer 
		cd ./qt-online-installer
		echo "  need to make the installer executable" 
		sudo chmod +x ./qt-unified-linux-x64-2.0.3-online.run
		mkdir -p $root/$target/$name
		./qt-unified-linux-x64-2.0.3-online.run 	
	fi
}

function download_qtpropertybrowser() 
{
	name=qtpropertybrowser
    version=1.0
    download_msg "$name $version"
    mkdir -p $root/$target/$name
    cd $root/$target/$name
	cp -r ./../../CMakes/$name/build.sh ./
    if ! [ -d src ]; then
		hg clone https://bitbucket.org/eligt/qtpropertybrowser ./src
    fi
}

function download_qwt() 
{
	name=qwt
    version=6.1.2
    download_msg "$name $version"
    mkdir -p $root/$target/$name
    cd $root/$target/$name
    if ! [ -d src ]; then
		wget https://sourceforge.net/projects/qwt/files/qwt/6.1.2/$name-$version.tar.bz2
		bzip2 -cd $name-$version.tar.bz2  | tar xf -
        mv $name-$version ./src
        rm -rf  $name-$version.tar.bz2
    fi
}


chackeTarget() 
{
	
if [ -z $1 ]; then
	return -1
else
	name=$1
fi

	case "$name" in 
		"libxml2" )
			download_libxml2
			;;
		"glew" )
			download_glew
			;;
		"gflags" )
			download_gflags
			;;
		"glog" )
			download_glog
			;;
		"freeimage" )
			download_freeimage
			;;
		"live555" )
			download_live555
			;;
		"openssl" )
			download_openssl
			;;
		"portaudio" )
			download_portaudio
			;;
		"sdl" )
			download_sdl
			;;
		"mongocxx" )
			download_mongocxx
			;;
		"boost" )
			download_boost
			;;
		"cpp-netlib")
			download_cpp-netlib
			;;
		"googletest" )
			download_googletest
			;;
		"protobuf" )
			download_protobuf
			;;
		"ogre" )
			download_ogre
			;;
		"freetype" )
			download_freetype
			;;
		"yasm" )
			download_yasm
			;;
		"ffmpeg" )
			download_ffmpeg
			;;
		"x264" )
			download_x264
			;;
		"x265" )
			download_x265
			;;
		"rtmp" )
			download_rtmp
			;;
		"libass" )
			download_libass
			;;
		"theora" )
			download_theora
			;;
		"vorbis" )
			download_vorbis
			;;
		"fribidi" )
			download_fribidi
			;;
		"Qt" )
			download_Qt
			;;
		"qtpropertybrowser" )
			download_qtpropertybrowser
			;;
		"qwt" )
			download_qwt
			;;
		"*" )
			echo "error"
			;;
	esac 
	return 0
}

chackeTarget $1



