#!/bin/bash

cd ./src
curdir=`pwd`
LD="$curdir/../../../libs/qt/5.6/gcc_64"
export PATH="$LD/bin:$PATH"
export QMAKESPEC="$LD/mkspecs/linux-g++"
qmake -set QT_INSTALL_PREFIX "$LD"
qmake -set QT_INSTALL_LIBS "$LD/lib/cmake"
qmake -set QT_INSTALL_PLUGINS "$LD/plugins"
qmake -query
qmake qtpropertybrowser.pro
make

#cmake -DCMAKE_PREFIX_PATH="$LD/5.6/gcc_64/lib/cmake"  ..
