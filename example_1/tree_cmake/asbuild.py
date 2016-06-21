#!/usr/bin/python

import argparse
import sys

####
# OTHER MODE
####



####

def usage():
	print("FIXME")

def HandlerArgs():
	parser = argparse.ArgumentParser(description="A prog for assembly libs")
	parser.add_argument("--libs" ,nargs="*", help="print value", default="all")
	parser.add_argument("--download" ,action='store_true', help="download libs")
	parser.add_argument("--install" ,action='store_true', help="install libs")
	parser.add_argument("--make" ,action='store_true', help="build libs")
	parser.add_argument("--exception" ,nargs="+", help="exception libs")
	options = parser.parse_args()
	return options
	
def PrintEcho(options):
	print ("Echo: {}".format(options) )
	print ("LIBS: {}".format(options.libs) )
	print ("isDownload: {}".format(options.download) )
	print ("isMake: {}".format(options.make) )
	print ("isInstall: {}".format(options.install) )
	print ("Exception: {}".format(options.exception) )
	
# it needs for exseption "ALL" if there is another lib. 	
def filter():
	return 0

def Download(arrs,exps=""):
	print ("DOWNLOAD: {},{}".format(arrs,exps))
	
def Install(arrs,exps=""):
	print ("INSTALL: {},{}".format(arrs,exps))

def Make(arrs,exps=""):
	print ("MAKE: {},{}".format(arrs,exps))
		
	
def HandlerOpts(options):
	libs=options.libs
	isDownload=options.download
	isMake=options.make
	isInstall=options.install
	exps=options.exception
	
	if isDownload == bool(1):
		Download(libs,exps)
	if isMake == bool(1):
		Make(libs,exps)
	if isInstall == bool(1):
		Install(libs,exps)
		
	return 0
	
if __name__ == "__main__":
	print ("Hello,World!")
	for param in sys.argv:
		print(param)
	options=HandlerArgs()
	PrintEcho(options)
	HandlerOpts(options)
	
