#!/bin/bash

THIS_DIR=$(cd $(dirname $0); pwd)
THIS_FILE=$(basename $0)
THIS_PATH="$THIS_DIR/$THIS_FILE"
CBIN_DIR=$THIS_DIR/CBin
arrLibs=( `cat "libs.txt"` )
MOD=""
MOD_LIB=""
MOD_CLEAN="CLEAN"
MOD_BUILD="BUILD"
MOD_INSTALL="INSTALL"
MOD_DOWNLOAD="DOWNLOAD"
MOD_HELP="HELP"

#functions
err_msg() {
 echo "ERROR: $1" 
 exit 0
}

###

IsLib() {
 res=-1

 [ -z $1 ] && err_msg "Uncorrect using IsLib"
 lib=$1

 for el in ${arrLibs[@]}
 do
	if [ "$el" == "$lib" ]; then
		echo "it's true"
		res=1
		break;
	fi
 done

 return $res

}

usage() {
 echo "usage: $0 [options]
    download           	run install in batch mode (without manual intervention),
    install            	no error if install prefix already exists
    make           	print this help message and exit
    patching    	install prefix, defaults to
    help         	FIXME
    clean		FIXME
"

}

CMake() {
  cd $CBIN_DIR
  cmake $CARGS ..
}

Make() {
  cd $CBIN_DIR
  if [ -z $1 ]; then
     make
  else
     make $1
  fi
}

Clean() {
  rm -rf $CBIN_DIR/*
}

Install() {
  cd $CBIN_DIR
  make install
}

BuildAll() {
  CMake
  Make
}

BuildOneLib() {
 [ -z $1 ] && return 0	
 aLib=$1
 for lib in ${arrLibs[@]}
 do
    if [ "$lib" == "$aLib" ]; then
	continue;
    fi
    CARGS="$CARGS -DEXCLUDE_$lib:BOOL=TRUE"
 done
 return 1
}

ExcludeLibs() {
  [ -z $1 ] && return 0	
  libs=$1
  for lib in $libs ; do
    CARGS="$CARGS -DEXCLUDE_$lib:BOOL=TRUE"
  done
  return 1
}

checkTarget() {
 [ -z $1 ] && return 0
 local lb=$1
 IsLib $lb
 [ $? -eq -1 ] && return -1
}


# FIXME It needs to add a massage about an error.
CheckKeys() {

local KEYS=`getopt -n "$scriptName" --long \
"help,clean,download,make::,install::,update::,exclude::
" -- "$@"`
while [ "$1" != "" ]; do
	case $1 in
		help )
			if [ -z $MOD ]; then  
			  MOD=$MOD_HELP
			else 
			  return -1
			fi
			;;
		download )
			if [ -z $MOD ]; then  
			  MOD=$MOD_DOWNLOAD
			else 
			  return -1
			fi
			;;
		update )
			if [ -z $MOD ]; then
			  MOD=$MOD_UPDATE
			else 
			  return -1
			fi
			;;
		install )
			if [ -z $MOD ]; then
			  MOD=$MOD_INSTALL
			else 
			  return -1
			fi
			;;
		clean )
			if [ -z $MOD ]; then
			  MOD=$MOD_CLEAN
			else 
			  return -1
			fi
			;;
		exclude )
			if [ -z $MOD || $MOD -eq $MOD_BUILD ]; then #FIXME it can used again
			  if  [ -n $2 ]; then
			    EXARGS="$EXARGS $2"
			    MOD=$MOD_BUILD
			  fi
			else 
			  return -1
			fi
			shift
			;;
		--) 
			;;
		*)
			if [ -z $MOD || $MOD -eq $MOD_BUILD ]; then
			  checkTarget $1
			  if [ $? -eq 1 ]; then
			    MOD_LIB=$lb
			    MOD=$MOD_BUILD	
			  else
                             return -1
			  fi
			else
			  return -1
			fi
			;;
	esac
	shift
done

}


Main() {

CheckKeys $@

if [ $1 -eq -1]; then
  usage
  return -1
fi 

case $MOD in
  "$MOD_DOWNLOAD" )
	if [ -z $MOD_LIB ]; then
	  echo "FIXME download all"
	else
	  echo "FIXME download $MOD_LIB" 	
	fi
	 ;;	
  "$MOD_BUILD" )
	if [ -z $MOD_LIB ]; then
	  ExcludeLibs $EXARGS
   	  CMake
  	  Make 
	else
	  BuildOneLib $MOD_LIB
   	  CMake
  	  Make $MOD_LIB
	fi
     	;;
  "$MOD_INSTALL" )
	if [ -z $MOD_LIB ]; then
	  ExcludeLibs $EXARGS
   	  CMake
  	  Install
	else
	  BuildOneLib $MOD_LIB
   	  CMake
  	  Install
	fi
     	;;
  "$MOD_CLEAN" )
	if [ -z $MOD_LIB ]; then
	  echo "FIXME clean all"
	else
	  echo "FIXME clean $MOD_LIB" 	
	fi
     	;;
   "$MOD_HELP" )
	;;
esac
}


Main $@

#setup()




#### Modules

#download
#install
#custom
#builder

####

usage
