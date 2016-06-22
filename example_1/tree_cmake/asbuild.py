#!/usr/bin/python

import argparse
import sys
import re
import subprocess
import copy
####
# OTHER MODE
####



####

####
__arraylibs=[]

####

def usage():
	print("FIXME")

def HandlerArgs():
	parser = argparse.ArgumentParser(description="A prog for assembly libs")
	parser.add_argument("--libs" ,nargs="+", help="print value", default="all")
	parser.add_argument("--download" ,action='store_true', help="download loibs")
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
def parsLibs(nameFile,array):
	dfile = open(nameFile)
	for line in iter(dfile):
		p=re.compile('\s*function\s+download_([\w-]+)')
		match=p.match(line)
		if match:
			array.append(match.group(1))
	dfile.close()
	return 0

def Download(libs):
	print ("DOWNLOAD: {}".format(libs))
	#print("LIBS:{}".format(libs))
	#for lib in iter(libs):
		#subprocess.call("./download.sh {}".format(lib), shell=True)
	#return res
	
def Install(libs):
	print ("INSTALL: {}".format(libs))

def Make(libs):
	print ("MAKE: {}".format(libs))

def exceptlibs(libs,exps):			
	array=[]
	if libs == "all":
		array=copy.copy(__arraylibs)
		if exps:
			for exlib in iter(exps):
				for element in iter(array):
					if exlib == element:
						array.remove(exlib)
						break
	else:
		array=copy.copy(libs)
	return array
	

def HandlerOpts(options):
	array=[]
	libs=options.libs
	isDownload=options.download
	isMake=options.make
	isInstall=options.install
	exps=options.exception
	
	array=exceptlibs(libs,exps)
	
	if isDownload == bool(1):
		Download(array)
	if isMake == bool(1):
		Make(array)
	if isInstall == bool(1):
		Install(array)
		
	return 0
	
def init():
	parsLibs("./download.sh",__arraylibs)
	

if __name__ == "__main__":
	print ("Hello,World!")
	for param in sys.argv:
		print(param)
	init()
	
#	print("Arr:{}".format(array))
	
	options=HandlerArgs()
	PrintEcho(options)
	
	HandlerOpts(options)
	
