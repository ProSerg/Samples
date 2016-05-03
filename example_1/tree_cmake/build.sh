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
[ -d ./CBin ] || error "can not find make file"
	cd ./CBin
	make install
	cd ..
}

printList() {
	echo `pwd`
	echo "list targets:"
	for dir in $dirs; do
		echo "$dir"
	done
}

make_all() {
[ -d ./CBin ] || mkdir -p ./CBin	
	cd ./CBin
	cmake -ULIBS  ..
	make
	cd ..
}

make_dir() {
[ -d ./CBin ] || mkdir -p ./CBin
	cd ./CBin
	cmake -DLIBS="$1" ..
	make
	cd ..
}

make_clean() {
[ -d ./CBin ] || mkdir -p ./CBin
        cd ./CBin
        make clean
	cd ..

}

build() {
	if ! [ -z $MOD_MAKE_ALL ]; then
		make_all
	fi
	
	if ! [ -z $MOD_MAKE ]; then
		make_dir $MOD_MAKE
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

getDirs
checkKeys $@
build
