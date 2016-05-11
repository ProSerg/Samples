#!/bin/bash

target=./source
dirs=""
ON="#"
OFF=""
MOD_MAKE_ALL=$ON # if want the target use "make"
MOD_MAKE=$OFF
MOD_INSTALL=$OFF
MOD_CLEAN=$OFF
dir=""
CMOD=""

error () {
        echo "$1"
}


getDirs() {
	cd $target
	dirs=`find * -maxdepth 0 -type d `
	cd ..
}

checkTarget() {
	for dir in $dirs; do
		if [ $1 == $dir  ]; then
			MOD_MAKE_ALL=$OFF
			MOD_MAKE=$dir
			break
		fi
	done
	if [ "$MOD_MAKE" == "$OFF" ]; then 
		echo "no target $1"
		exit -1
	fi
}

make_install() {
	cd ./CBin
	if ! [ -z  $MOD_MAKE  ] ; then
		cmake -DLIBS=$MOD_MAKE ..
	fi
	echo "MOD:$MOD_MAKE"
	make install
	cd ..
}

printList() {
	cd ./CBin
	make help
}

make_all() {
	cd ./CBin
	cmake -ULIBS ..
	make
	cd ..
}

make_dir() {
	cd ./CBin
	cmake -DLIBS=$MOD_MAKE ..
	make $1
	cd ..
}

make_clean() {
        cd ./CBin
        make clean
	cd ..

}

build() {
	if ! [ -z $MOD_MAKE_ALL ]; then
		make_all
	fi
	
	if ! [ -z $MOD_MAKE ]; then
		if [ -z $MOD_INSTALL ]; then
			make_dir $MOD_MAKE
		fi
	fi
		
	if ! [ -z $MOD_INSTALL ]; then
		make_install
	fi
}

usage() {
	echo "FIXME :)"
}

checkKeys() {

local KEYS=`getopt -n "$scriptName" -o hlic --long \
"help,list,install,clean
" -- "$@"`
eval set -- "$KEYS"
while [ "$1" != "" ]; do
	case $1 in 
		-h | --help )
			usage
			exit 0
			;;
		-l | --list )
			printList
			exit 0			
			;;
		-i | --install )
			MOD_MAKE_ALL=$OFF
			MOD_INSTALL=$ON
			;;
		-c | --clean )
			exit 0
			;;
		--) 
			;;
		*)
			checkTarget $1
			;;
	esac
	shift
done

}

[ -d ./CBin ] || error "can not find make file"
getDirs
checkKeys $@
build
