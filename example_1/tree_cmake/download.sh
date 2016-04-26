#!/bin/bash

LOG="NO"

OUT="> /dev/null"

colors () {
	BOLD=$(tput bold)
	NORM=$(tput sgr0)

	FB=$(tput setaf 0)
	FR=$(tput setaf 1)
	FG=$(tput setaf 2)
	FY=$(tput setaf 3)
	FB=$(tput setaf 4)
	FM=$(tput setaf 5)
	FC=$(tput setaf 6)
	FW=$(tput setaf 7)

	BB=$(tput setab 0)
	BR=$(tput setab 1)
	BG=$(tput setab 2)
	BY=$(tput setab 3)
	BB=$(tput setab 4)
	BM=$(tput setab 5)
	BC=$(tput setab 6)
	BW=$(tput setab 7)
}

download_msg() {
    echo "[${BOLD}${FG}DOWNLOAD${NORM}] ${FY}$@ ${NORM}"
}

sys_msg() {
	echo "[${BOLD}${FG}DOWNLOAD${NORM}] ${FY}$@ ${NORM}"
}

colors

target=source
root=`pwd`
#./clean.sh

[ -d $target ] || mkdir $target



cd $target

name=libxml2
version=2.4.16
download_msg "$name $version"
mkdir -p ./$name
cd ./$name
cp -r ./../../CMakes/$name/CMakeLists.txt ./
if ! [ -d src ]; then
	git clone https://git.gnome.org/browse/libxml2 ./src
fi 
cd $root/$target

name=glew
version=1.13.0
download_msg "$name $version"
mkdir -p ./$name
cd ./$name
cp -r ./../../CMakes/$name/CMakeLists.txt ./
if ! [ -d src ]; then
	git clone https://github.com/nigels-com/glew.git ./src
fi
cd $root/$target


name=gflags
vesrion=2.1.2
download_msg "$name $version"
mkdir -p ./$name
cd ./$name
cp -r ./../../CMakes/$name/CMakeLists.txt ./
if ! [ -d src ]; then
	git clone https://github.com/gflags/gflags.git ./src
fi
cd $root/$target


name=glog
version=0.3.4
download_msg "$name $version"
mkdir -p ./$name
cd ./$name
cp -r ./../../CMakes/$name/CMakeLists.txt ./
if ! [ -d src ]; then
	git clone https://github.com/google/glog.git ./src
fi
cd $root/$target



name=freeimage
version=3.18
download_msg "$name $version"
mkdir -p ./$name
cd ./$name
cp -r ./../../CMakes/$name/CMakeLists.txt ./
if ! [ -d src ]; then
	url=http://freeimage.cvs.sourceforge.net/viewvc/freeimage/FreeImage/?view=tar
	echo " "
	echo "wget $url"
#	curl -# $url | tar xz
	wget -qO- $url | tar xz  	
	mv ./FreeImage ./src
fi
cd $root/$target

name=live555
version=latest
download_msg "$name $version"
mkdir -p ./$name
cd ./$name
cp -r ./../../CMakes/$name/CMakeLists.txt ./
if ! [ -d src ]; then
	url=http://www.live555.com/liveMedia/public/live555-latest.tar.gz
	echo " "
	echo "wget $url"
	curl -# $url | tar xz
	#wget -q0-  $url | tar xz
	mv ./live ./src
	rm -rf live555-latest.tar.gz
fi
cd $root/$target

name=openssl
version=1.1.0
download_msg "$name $version"
mkdir -p ./$name
cd ./$name
cp -r ./../../CMakes/$name/CMakeLists.txt ./
if ! [ -d src ]; then
	git clone https://github.com/openssl/openssl.git ./src
fi
cd $root/$target

name=portaudio
version=v19
download_msg "$name $version"
mkdir -p ./$name
cd ./$name
cp -r ./../../CMakes/$name/CMakeLists.txt ./
if ! [ -d src ]; then
	echo "Cloning : to ./src "
	url=https://subversion.assembla.com/svn/portaudio/portaudio/trunk/
	svn co $url ./src 2>&1> /dev/null
#n=$(svn info -R $url ./src | grep "URL: " | uniq | wc -l)
#i=1
#while read line filename
#   	do
#   		counter=$(( 100*(++i)/n))
#   		echo -e "($counter %)\n"
#   		echo -e "filename: $filename \n"
#done < <(svn co $url ./src )
fi
cd $root/$target

	
name=sdl
version=2.0.4
download_msg "$name $version"
mkdir -p ./$name
cd ./$name
cp -r ./../../CMakes/$name/CMakeLists.txt ./
if ! [ -d src ]; then
	url=https://www.libsdl.org/release/SDL2-2.0.4.tar.gz
        echo " "
        echo "curl $url"
        curl -# $url | tar xz	
	mv ./SDL2-2.0.4 ./src
	rm -rf SDL2-2.0.4.tar.gz 
fi
cd $root/$target


name=mongocxx
version=3.0.0
download_msg "$name $version"
mkdir -p ./$name
cd ./$name
cp -r ./../../CMakes/$name/CMakeLists.txt ./
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


name=boost
version=1.60
download_msg "$name $version"
mkdir -p ./$name
cd ./$name
cp -r ./../../CMakes/$name/CMakeLists.txt ./
if ! [ -d src ]; then
	git clone https://github.com/boostorg/boost.git ./src
	cd ./src 
	target=./libs
	
	exc="compute dll hana metaparse"
	dirs=`find $target/* -maxdepth 0 -type d `	

	# исключаем директории из выборки 
	for dir in $exc ;do
        	dirs="${dirs/$target\/$dir/}"
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
cd $root/$target


name=cpp-netlib
version=0.12
download_msg "$name $version"
mkdir -p ./$name
cd ./$name
cp -r ./../../CMakes/$name/CMakeLists.txt ./
if ! [ -d src ]; then
	git clone https://github.com/cpp-netlib/cpp-netlib ./src
    	cd ./src
    	git submodule init
    	git submodule update
fi
cd $root/$target

name=googletest
version=1.0
download_msg "$name $version"
mkdir -p ./$name
cd ./$name
cp -r ./../../CMakes/$name/CMakeLists.txt ./
if ! [ -d src ]; then
        git clone https://github.com/google/googletest.git ./src
fi
cd $root/$target


name=protobuf
version=1.0
download_msg "$name $version"
mkdir -p ./$name
cd ./$name
cp -r ./../../CMakes/$name/CMakeLists.txt ./
if ! [ -d src ]; then
	git clone https://github.com/google/protobuf.git ./src	
fi
cd $root/$target


name=freetype
version=2.6.3
download_msg "$name $version"
mkdir -p ./$name
cd ./$name
cp -r ./../../CMakes/$name/CMakeLists.txt ./
if ! [ -d src ]; then
	git clone http://git.sv.nongnu.org/r/freetype/freetype2.git ./src
fi
cd $root/$target


name=ffmpeg
version=1.0
download_msg "$name $version"
mkdir -p ./$name
cd ./$name
cp -r ./../../CMakes/$name/CMakeLists.txt ./
	mkdir -p src
	mkdir -p build
	cd ./src

	if ! [ -d yasm ]; then
		wget http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz
		tar xzf yasm-1.3.0.tar.gz
		mv yasm-1.3.0 yasm
		rm -rf yasm-1.3.0.tar.gz
	fi

	if ! [ -d ffmpeg ]; then
		url=http://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2
        	echo "wget $url"
        	wget $url
		tar xjf ffmpeg-snapshot.tar.bz2
        	rm -rf ffmpeg-snapshot.tar.bz2
	fi
		
	if ! [ -d x264 ]; then
		url=http://download.videolan.org/pub/x264/snapshots/last_x264.tar.bz2
                echo "wget $url"
                wget  $url 
		tar xjf last_x264.tar.bz2
                rm -rf last_x264.tar.bz2
		mv ./x264-snapshot* ./x264

	fi

	if ! [ -d rtmpdump ]; then
                git clone git://git.ffmpeg.org/rtmpdump
        fi

	if ! [ -d x265 ]; then
		hg clone https://bitbucket.org/multicoreware/x265
	fi

	if ! [ -d libass ]; then
		git clone https://github.com/libass/libass.git 
	fi
	
	if ! [ -d theora ]; then
		git clone https://git.xiph.org/theora.git
	fi

	if ! [ -d vorbis ]; then
		git clone https://git.xiph.org/vorbis.git
	fi
	
	if ! [ -d fribidi  ]; then
		git clone https://github.com/behdad/fribidi.git 
	fi
cd $root/$target



