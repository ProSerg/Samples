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
 make -j2
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
 if [ $? -ne 0  ]; then
 	./bootstrap
 	./configure --prefix="$LD"
	error "Config" $?
 fi
make -j2 
make install 

cd $curdir

}

build_x264() {

echo ""
echo "#### LIB x264 ####"
echo ""

 cd $SDIR/x264
 ./configure --prefix="$LD" --libdir="$LD/lib/" --enable-static --enable-shared 
  if [ $? -ne 0  ]; then
	./configure --prefix="$LD" --libdir="$LD/lib/"   --enable-static --enable-shared 
	error "Config" $?
 fi
 make -j2
 make install
 cd $curdir
}

build_x265() {

echo ""
echo "#### LIB x265 ####"
echo ""

 cd $SDIR/x265/build/linux
 cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$LD"  ../../source
 error "Config" $?
 make -j2
 make install
 cd $curdir
}

build_vorbis() {

echo ""
echo "#### LIB vorbis ####"
echo ""

 cd $SDIR/vorbis
 ./autogen.sh
 ./configure --prefix="$LD" 
 if [ $? -ne 0  ]; then
	./autogen.sh
 	./configure --prefix="$LD" 
	error "Config" $?
 fi
 make -j2
 make install
 cd $curdir
}


build_libass() {

echo ""
echo "#### LIB ASS ####"
echo ""

 cd $SDIR/libass
 export PKG_CONFIG_PATH="$LIBS/freetype/lib/pkgconfig:$LD/lib/pkgconfig:$PKG_CONFIG_PATH"	
 ./autogen.sh
  FREETYPE_LIBS="$LIBS/freetype/lib" ./configure --prefix="$LD" --disable-require-system-font-provider
  if [ $? -ne 0  ]; then
	./autogen.sh
  	FREETYPE_LIBS="$LIBS/freetype/lib" ./configure --prefix="$LD" --disable-require-system-font-provider
	error "Config" $?
 fi
 make -j2
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
 make -j2
 make install
 cd $curdir
}


build_rtmp(){
echo ""
echo "#### LIB RTMPDUMP ####"
echo ""

 cd $SDIR/rtmpdump
 cd ./librtmp
 make SYS=posix XCFLAGS="-I$LIBS/openssl/include"  XLDFLAGS="-L$LIBS/openssl/lib" prefix="$LIBS/ffmpeg"
 error "Config" $?
 echo "INSTALL files"
 cp -r -v ./librtmp.so* $LD/lib
 cp -r -v  ./rtmp.h $LD/include
 cd $curdir
}


build_theora(){
echo ""
echo "#### LIB THEORA ####"
echo ""

 cd $SDIR/theora
 ./autogen.sh
 ./configure --prefix=$LD 
 if [ $? -ne 0  ]; then
	./autogen.sh
 	./configure --prefix=$LD 
	error "Config" $?
 fi
 make -j2
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

#PKG_CONFIG_PATH="$LD/lib/pkgconfig" ./configure \

export PKG_CONFIG_PATH="$LIBS/freetype/lib/pkgconfig:$LD/lib/pkgconfig:$PKG_CONFIG_PATH"	
export FRIBIDI_LIBS="$LD/lib/" 
export FREETYPE_LIBS="$LIBS/freetype/lib" 
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
 make -j2
 make install
 cd $curdir
}

settings
checkKeys $@

build_yasm
build_fribidi
build_x264
build_x265
build_vorbis
#build_zlib delete
build_rtmp 
build_theora
build_libass
build_ffmpeg 
