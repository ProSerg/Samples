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
	

#	export PKG_CONFIG_LIBDIR="$LIBS/openssl/include/:${PKG_CONFIG_LIBDIR}" 
 
	export LD_LIBRARY_PATH="$LIBS/openssl/lib:$LIBS/freetype/lib:$LD/lib/:$LD_LIBRARY_PATH"
	export PKG_CONFIG_PATH="$LIBS/openssl/lib/pkgconfig:$LIBS/freetype/lib/pkgconfig:$LD/lib/pkgconfig:$PKG_CONFIG_PATH"

	logdir=$curdir/../log
#	export CFLAGS="$CFLAGS -I$LIBS/openssl/include"  
#	export CXXFLAGS="$CXXFLAGS -I$LIBS/openssl/include"	
}


build() {

cd $SDIR
# export PKG_CONFIG_PATH="$LIBS/freetype/lib/pkgconfig:$LD/lib/pkgconfig:$PKG_CONFIG_PATH"	
 ./autogen.sh
  FREETYPE_LIBS="$LIBS/freetype/lib" ./configure --prefix="$LD" --disable-require-system-font-provider
  error "Config" $?
  make -j4
  make install
}

settings
build
