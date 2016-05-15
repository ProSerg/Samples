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
ARGS=""
CARGS=""

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
		cmake  ..
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
	make_clean
	mkdir -p ./CBin
	if [ -z "$ARGS" ]; then
		cd ./CBin
		cmake ..		
	else
		for line in $ARGS ; do
			CARGS="$CARGS -DEXCLUDE_$line:BOOL=TRUE"
		done
		cd ./CBin
		cmake $CARGS ..	
	fi
	make
	cd ..
}

make_dir() {
	make_clean
	mkdir -p ./CBin
	cd ./CBin
	cmake ..
	make $1
	cd ..
}

make_update() {
	make_clean
	mkdir -p ./CBin
	cd ./CBin
	cmake ..
}

make_clean() {
        rm -rf ./CBin
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

local KEYS=`getopt -n "$scriptName" -o hlice:u --long \
"help,list,install,clean,update,exclude::
" -- "$@"`
eval set -- "$KEYS"
while [ "$1" != "" ]; do
	case $1 in
		-h | --help )
			exit 0
			;;
		-l | --list )
			printList
			exit 0			
			;;
		-u | --update)
			make_update
			exit 0
			;;
		-i | --install )
			MOD_MAKE_ALL=$OFF
			MOD_INSTALL=$ON
			;;
		-c | --clean )
			make_clean
			exit 0
			;;
		-e | --exclude)
			if [ -z $2 ]; then
				usage
				exit 0
			fi
			ARGS="$ARGS $2"
			shift
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

[ -d ./CBin ] || mkdir -p ./CBin
getDirs
checkKeys $@
build
