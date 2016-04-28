#!/bin/bash

curdir=`pwd`


error() {
 if [ $2 != 0  ]; then
	echo "[$1] error"
	exit 0	
 fi 
}


settings () {
	LIBS="$curdir/../../libs"
	SDIR="$curdir/src"
	SSL="$LIBS/openssl"
	ZLIB="$LIBS/zlib"
	LD="$LIBS/ffmpeg"
	PATH="$LD/bin:$PATH"
	PKG_CONFIG_PATH="$LD/lib/pkgconfig"
	PKG_CONFIG_LIBDIR="$LD/lib/pkgconfig"  

	logdir=$curdir/../log
}

usage() {
	echo "usage: FIXME :)"
}

checkKeys() {
	local KEYS=`getopt -n "$scriptName" -o hl: --long \
	"help,lib_dir::
	" -- "$@"`
	eval set -- "$KEYS"
	while [ "$1" != "" ]; do
		case $1 in 
			-h | --help )
				usage
				exit 0
				;;
			-l | --lib_dir )
				case "$2" in
					"") 
						echo "Error: $1" 
						usage ;
						exit 0 ;;
					*) 
						LIBS=$2 ; 
						shift 1 
						;;
					esac ;;	
			--) 
				;;
			*)
				;;
		esac
		shift
	done
}

build_yasm() {
 cd $SDIR/yasm
 ./configure --prefix="$LD" --bindir="$LD/bin"  
 error "Config" $?
 make
 make install

 cd $curdir

}

build_fribidi() {

echo ""
echo "#### LIB FRIBIDI ####"
echo ""

cd $SDIR/fribidi
 ./bootstrap 
 ./configure --prefix="$LD"
error "Config" $?
make 
make install 

cd $curdir

}

build_x264() {

echo ""
echo "#### LIB x264 ####"
echo ""

 cd $SDIR/x264
# if [  ]; then 
	 ./configure --prefix="$LD" --bindir="$LD/bin" --enable-static
	 error "Config" $?
	 make
# fi
 make install
 cd $curdir
}

build_x265() {

echo ""
echo "#### LIB x265 ####"
echo ""

 cd $SDIR/x265/build/linux
 cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$LD" -DENABLE_SHARED:bool=off ../../source
 error "Config" $?
 make
 make install
 cd $curdir
}

build_vorbis() {

echo ""
echo "#### LIB vorbis ####"
echo ""

 cd $SDIR/vorbis
 ./autogen.sh
 ./configure --prefix="$LD" --disable-shared
 error "Config" $?
 make
 make install
 cd $curdir
}


build_libass() {

echo ""
echo "#### LIB ASS ####"
echo ""

 cd $SDIR/libass
 ./autogen.sh
PKG_CONFIG_PATH="$LD/lib/pkgconfig" ./configure --prefix="$LD" --disable-shared 
 error "Config" $?
 make
 make install
 cd $curdir

}

build_zlib() {
echo ""
echo "#### LIB ZLIB ####"
echo ""

 cd $SDIR/zlib
 mkdir -p build
 cd ./build
 cmake -DCMAKE_INSTALL_PREFIX=$LIBS/zlib ..
 make
 make install
 cd $curdir
}


build_rtmp(){
echo ""
echo "#### LIB RTMPDUMP ####"
echo ""

 cd $SDIR/rtmpdump
 mkdir -p build
 cd ./build
 export CXXFLAGS="-fPIC" && OPENSSL_ROOT_DIR=$SSL ZLib_DIR=$ZLIB  cmake ..
 error "Build" $?
 make
#DESTDIR=$LD make install
#make clean
 cd $curdir
}


build_theora(){
echo ""
echo "#### LIB THEORA ####"
echo ""

 cd $SDIR/theora
 ./autogen.sh
 ./configure --prefix=$LD --disable-shared
 error "Config" $?
 make
 make install
 cd $curdir
}

build_ffmpeg(){
echo ""
echo "#### LIB FFMPEG  ####"
echo ""

#  --pkg-config-flags="--shared" \

 cd $SDIR/ffmpeg

echo "#### FRIBIDI_LIBS=$LD/lib/ "
echo "#### PKG_CONFIG_PATH=$LD/lib/pkgconfig "

FRIBIDI_LIBS="$LD/lib/" 
PKG_CONFIG_PATH="$LD/lib/pkgconfig" ./configure \
  --enable-shared \
  --prefix="$LD" \
  --pkg-config-flags="--static" \
  --extra-cflags="-I$LD/include" \
  --extra-ldflags="-L$LD/lib" \
  --bindir="$LD/bin" \
  --enable-gpl \
  --enable-libass \
  --enable-libfreetype \
  --enable-libtheora \
  --enable-libvorbis \
  --enable-libx264 \
  --enable-libx265


#  need add RTMP
 error "Config" $?
 make
 make install
 cd $curdir
}

settings
checkKeys $@

#build_yasm
#build_fribidi
build_x264
build_x265
build_vorbis
#build_zlib delete
#build_rtmp #FIXME it doesn't building.
build_theora
build_libass
build_ffmpeg 
