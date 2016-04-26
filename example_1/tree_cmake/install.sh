#!/bin/bash

error () {
	echo "can not find make file"
}

[ -d ./CBin ] || error 
cd ./CBin
make install
