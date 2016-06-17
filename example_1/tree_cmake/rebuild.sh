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
MOD_DOWNLOAD="DOWNLOAD" # it will patching too.
MOD_HELP="HELP"
EXARGS=""
DWARGS=""

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
    download           	FIXME
    install            	FIXME
    make           	FIXME
    patching    	FIXME
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

checkKeys() {

local KEYS=`getopt -n "$THIS_FILE" -o hlice:u --long \
"help,list,install::,clean,update::,exclude::
" -- "$@"`
eval set -- "$KEYS"
while [ "$1" != "" ]; do
	case $1 in
		-h | --help )
			echo "HELP"
			exit 0
			;;
		-l | --list )
			echo "LIST"
			exit 0			
			;;
		-u | --update)
			if [ -z $2 ]; then
				usage
				exit 0
			fi
			ARGS="$ARGS $2"
			echo "UPDATE $ARGS"
			shift 2
			;;
		-i | --install )
			if [ -z $2 ]; then
				usage
				exit 0
			fi
			ARGS="$ARGS $2"
			echo "INSTALL $ARGS"
			shift 2
			;;
		-c | --clean )
			echo "LIST"
			exit 0
			;;
		-e | --exclude)
			if [ -z $2 ]; then
				usage
				exit 0
			fi
			ARGS="$ARGS $2"
			echo "EXCLUDE $ARGS"
			shift 2
			;;
		--) 
			shift
			;;
		*)
			echo "TARGET $1"
			shift
			;;
	esac
done

}

# FIXME It needs to add a massage about an error.
CheckKeys2() {

local KEYS=`getopt -n "$THIS_FILE" -o hlice:u --long \
"help,clean,download:,make:,install:,update:,exclude: $@"`
#eval set -- $KEYS
while [ "$1" != "" ]; do
	case $1 in
		--help )
			if [ -z $MOD ]; then  
			  MOD=$MOD_HELP
			else 
			  return -1
			fi
			;;
		download )
			if [ -z $MOD || "$MOD" -eq "$MOD_DOWNLOAD" ]; then
			  MOD=$MOD_DOWNLOAD
			  if  [ -n $2 ]; then
			    DWARGS="$DWARGS $2"
			    echo "Test $DWARGS $3"
			    shift
			  else
			    return -1
			  fi
			  
			else 
			  return -1
			fi
			;;
		--update )
			if [ -z $MOD ]; then
			  MOD=$MOD_UPDATE
			  if  [ -n $2 ]; then
			    DWARGS="$DWARGS $2"
			    shift
			  else
			    return -1
			  fi
			else 
			  return -1
			fi
			;;
		--install )
			if [ -z $MOD ]; then
			  MOD=$MOD_INSTALL
			else 
			  return -1
			fi
			;;
		--clean )
			if [ -z $MOD ]; then
			  MOD=$MOD_CLEAN
			else 
			  return -1
			fi
			;;
		--exclude )
			if [ -z $MOD || $MOD -eq $MOD_BUILD ]; then 
			  if  [ -n $2 ]; then
			    EXARGS="$EXARGS $2"
			    MOD=$MOD_BUILD
			  else
			    return -1
			  fi
			else 
			  return -1
			fi
			shift
			;;
		--make )
			if [ -z $MOD || $MOD -eq $MOD_BUILD ]; then
			  if  [ -n $2 ]; then
			    MOD_LIB="$2"
			    MOD=$MOD_BUILD
			    shift
			  else
			    return -1
			  fi
			else 
			  return -1
			fi
			;;
		--) 
			shift
			;;
		*)
			#if [ -z $MOD || "$MOD" -eq "$MOD_BUILD" ]; then
			if [ -z $MOD ]; then
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
done

return 1
}

Avtomat() {
local COMM=""

if [ -z $1 ]; then
 COMM=$MOD
else
 COMM=$1
fi 

case $COMM in
  "$MOD_DOWNLOAD" )
	if [ -z $DWARGS ]; then
	  echo "FIXME download all"
	else
	  echo "FIXME download $DWARGS" 	
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

Main() {

echo "Res: $# "
if [ $# -eq 0 ]; then
   Avtomat $MOD_DOWNLOAD
   Avtomat $MOD_BUILD
   Avtomat $MOD_INSTALL
else
  CheckKeys2 $@

  if [ $? -eq -1 ]; then
    usage
    return -1
  fi 

  Avtomat 
fi

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
