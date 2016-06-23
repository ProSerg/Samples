#!/bin/bash

colors () {
	BOLD=$(tput bold)
	NORM=$(tput sgr0)

	FB=$(tput setaf 0)
	FR=$(tput setaf 1)
	FG=$(tput setaf 2)
	FY=$(tput setaf 3)
	FB=$(tput setaf 4)
	FM=$(tput setaf 5)
	FC=$(tput setaf 6)
	FW=$(tput setaf 7)

	BB=$(tput setab 0)
	BR=$(tput setab 1)
	BG=$(tput setab 2)
	BY=$(tput setab 3)
	BB=$(tput setab 4)
	BM=$(tput setab 5)
	BC=$(tput setab 6)
	BW=$(tput setab 7)
}

download_msg() {
    echo "[${BOLD}${FG}DOWNLOAD${NORM}] ${FY}$@ ${NORM}"
}

cmake_msg() {
    echo "[${BOLD}${FG}CMAKE${NORM}] ${FY}$@ ${NORM}"
}

sys_msg() {
	echo "[${BOLD}${FG}DOWNLOAD${NORM}] ${FY}$@ ${NORM}"
}

error_msg() {
	echo "[${BOLD}${FR}ERROR${NORM}] ${FY}$@ ${NORM}"
}
