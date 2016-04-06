#!/bin/bash

curr_dir=`pwd`
source=src
prefix=$curr_dir/lib
flags="--disable-static"

[ -d ./$source ] || echo "Error $source"

#rm -rf ./lib/*
cd ./$source

#aclocal
#autoconf
#automake
 
#./configure --prefix=$prefix $flags
#make
#make install
