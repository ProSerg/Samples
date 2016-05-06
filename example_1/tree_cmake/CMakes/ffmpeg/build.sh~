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
	export LD_LIBRARY_PATH="$LIBS/openssl/lib:$LIBS/freetype/lib:$LD/lib/:$LD_LIBRARY_PATH"
	export PKG_CONFIG_PATH="$LIBS/openssl/lib/pkgconfig:$LIBS/freetype/lib/pkgconfig:$LD/lib/pkgconfig:$PKG_CONFIG_PATH"	
	export FRIBIDI_LIBS="$LD/lib/" 
	export FREETYPE_LIBS="$LIBS/freetype/lib" 
	logdir=$curdir/../log

}


build() {

cd $SDIR

#  --pkg-config-flags="--static" \
./configure \
  --enable-shared \
  --prefix="$LD" \
  --extra-cflags="-I$LD/include" \
  --extra-ldflags="-L$LD/lib" \
  --pkg-config-flags="--static" \
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
 make -j4
 cd $curdir

}

settings
build
