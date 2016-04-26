#!/bin/bash

target=./source
dirs=""
MOD_MAKE_ALL="all" # if wont the target use "make"
MOD_MAKE="make"
MOD_INSTALL="install"
MOD_CLEAN="clean"
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
			make_dir $dir
			exit 0
		fi
	done
	
}

make_install() {
[ -d ./CBin ] || error "can not find make file"
	cd ./CBin
	make install

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

}

make_dir() {
[ -d ./CBin ] || mkdir -p ./CBin
	cd ./CBin
	cmake -DLIBS="$1" ..
	make
}

make_clean() {
[ -d ./CBin ] || mkdir -p ./CBin
        cd ./CBin
        make clean

}

build() {
	case "$1" in
	"$MOD_MAKE_ALL" )
		make_all
		;;
	"$MOD_MAKE" )
		make_dir $2
		;;
	"$MOD_INSTALL")
		make_install
		;;
	esac
	

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
			make_install
			exit 0
			;;
		-c | --clean)
			make_clean
			exit 0
			;;
		*)
			checkTarget $1
			;;
	esac
	shift
done

}

if [ $# -eq 0 ]; then
	make_all
	exit 0
fi

getDirs
checkKeys $@

echo "no  target"
