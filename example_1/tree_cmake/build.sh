#!/bin/bash

[ -d ./CBin ] || mkdir -p ./CBin
cd ./CBin
cmake ..
make

