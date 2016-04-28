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


build_x264() {

echo ""
echo "#### INSTALL x264 ####"
echo ""

 cd $SDIR/x264	
 make install
 make distclean

 cd $curdir
}

build_x265() {

echo ""
echo "#### INSTALL x265 ####"
echo ""

 cd $SDIR/x265/build/linux
 make install
 make distclean
 cd $curdir
}

build_vorbis() {

echo ""
echo "#### INSTALL vorbis ####"
echo ""

 cd $SDIR/vorbis
 make install
 make clean

 cd $curdir
}


build_libass() {

echo ""
echo "#### INSTALL ASS ####"
echo ""

 cd $SDIR/libass
 make install
 make clean
 cd $curdir

}

build_zlib() {
echo ""
echo "#### INSTALL ZLIB ####"
echo ""

 cd $SDIR/zlib
 make install
 make clean
 cd $curdir
}


build_rtmp(){
echo ""
echo "#### INSTALL RTMPDUMP ####"
echo ""

 cd $SDIR/rtmpdump
 echo "FIXME"
 cd $curdir
}


build_theora(){
echo ""
echo "#### INSTALL THEORA ####"
echo ""

 cd $SDIR/theora
 make install
 make clean
 cd $curdir
}

build_ffmpeg(){
echo ""
echo "#### INSTALL FFMPEG  ####"
echo ""

 cd $SDIR/ffmpeg
 make install
 cd $curdir
}

settings

build_x264
build_x265
build_vorbis
build_zlib
#build_rtmp #FIXME it doesn't building.
build_theora
build_libass
build_ffmpeg 
