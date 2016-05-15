#!/bin/bash

cd ./src
curdir=`pwd`
LD="$curdir/../../../libs/qt"
export PATH="$LD/bin:$PATH"
export QMAKESPEC="$LD/5.6/gcc_64/mkspecs/linux-g++"
#qmake qtpropertybrowser.pro
mkdir ./build
cd ./build
cmake -DCMAKE_PREFIX_PATH="$LD/5.6/gcc_64/lib/cmake"  ..
