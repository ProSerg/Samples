#!/bin/bash

LD="/home/serg/workspace/upwork/tree_cmake/libs/ffmpeg"
PATH="$LD/bin:$PATH"
PKG_CONFIG_PATH="$LD/lib/pkgconfig"
PKG_CONFIG_LIBDIR="$LD/lib/pkgconfig"  

curdir=`pwd`
logdir=$curdir/../

error() {
 if [ $2 != 0  ]; then
	echo "[$1] error"
	exit 0	
 fi 
}

build_yasm() {
 cd ./yasm
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

cd ./fribidi
 ./bootstrap >  $logdir/fribidi.bootstrap.log
 ./configure --prefix="$LD"  > $logdir/fribidi.conf.log
error "Config" $?
make > $logdir/fribidi.make.log
make install > $logdir/fribidi.install.log

cd $curdir

}

build_x264() {
 cd ./x264
 ./configure --prefix="$LD" --bindir="$LD/bin" --enable-static
 make
 make install
 make distclean

 cd $curdir
}

build_x265() {
 cd ./x265/build/linux
 cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$LD" -DENABLE_SHARED:bool=off ../../source
 make
 make install
 make distclean
 cd $curdir
}

build_vorbis() {
 cd ./vorbis
 ./autogen.sh
 ./configure --prefix="$LD" --disable-shared
 make
 make install
 make clean

 cd $curdir
}


build_libass() {

echo ""
echo "#### LIB ASS ####"
echo ""

 cd ./libass
 ./autogen.sh
PKG_CONFIG_PATH="$LD/lib/pkgconfig" ./configure --prefix="$LD" --disable-shared 
 error "Config" $?
 make
 make install
 make clean
 cd $curdir

}


build_rtmp(){
echo ""
echo "#### LIB RTMPDUMP ####"
echo ""

 cd ./rtmpdump/librtmp
 make
 DESTDIR=$LD make install
 make clean
 cd $curdir
}


build_theora(){
echo ""
echo "#### LIB THEORA ####"
echo ""

 cd ./theora
 ./autogen.sh
 ./configure --prefix=$LD --disable-shared
 make
 make install
 make clean
 cd $curdir
}

build_ffmpeg(){
echo ""
echo "#### LIB FFMPEG  ####"
echo ""

 cd ./ffmpeg
FRIBIDI_LIBS="$LD/lib/"
PKG_CONFIG_PATH="$LD/lib/pkgconfig" ./configure \
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


#  --enable-libfdk-aac \
#  --enable-libmp3lame \
#  --enable-libvpx \
#  --enable-nonfree
 make
 make install
 cd $curdir
}

#build_yasm
#build_fribidi

build_libass
build_ffmpeg 
