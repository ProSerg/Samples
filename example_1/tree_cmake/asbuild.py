#!/usr/bin/python

import argparse
import sys
import re
import subprocess
import copy
import os 
####
# OTHER MODE
####



####

####
__arraylibs=[]
__pwd=""
_exclude=[]
####

def usage():
	print("FIXME")

def HandlerArgs():
	parser = argparse.ArgumentParser(description="A prog for assembly libs")
	parser.add_argument("--libs" ,nargs="+", help="print value", default="all")
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
def parsLibs(nameFile,array):
	try:
		dfile = open(nameFile)
	except IOError as e:
		print("It can not find the file : {}".format(nameFile) )
		return -1
	else:
		with dfile:
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
	for lib in iter(libs):
		subprocess.call("./download.sh {}".format(lib), shell=True)
	
def Install(libs):
	print ("INSTALL: {}".format(libs))
	__pwd=os.path.dirname(os.path.abspath( __file__ ))
	os.chdir("{}/CBin".format(__pwd))
	try:
		subprocess.call("make install", shell=True)
	except NameError as ex:
		print("error: can't call 'make install' ")
		return -1
	else:
		os.chdir("{}".format(__pwd))
		return 0
		 
def Make(excludes):
	print ("MAKE: {}".format(excludes))
	__pwd=os.path.dirname(os.path.abspath( __file__ ))
	os.chdir("{}/CBin".format(__pwd))
	try:
		subprocess.call("rm -rf \"./*\"", shell=True)
		subprocess.call("cmake {} ..".format(excludes), shell=True)
		subprocess.call("make".format(excludes), shell=True)
	except NameError as ex:
		print("error: can't call {}".format(ex.args))
		return -1
	else:
		os.chdir("{}".format(__pwd))
		return 0
	
	
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
	
def excludelibs(libs,exps):
	exclude=""
	array=[]
	if libs == "all":
		if exps:
			for exlib in iter(exps):
				exclude=" ".join("-DEXCLUDE_{}:BOOL=TRUE".format(exlib))
	else:
		array=copy.copy(__arraylibs)
		for lib in iter(libs):
			for element in iter(array):
				if lib == element:
					array.remove(lib)
		exclude="".join(" -DEXCLUDE_%s:BOOL=TRUE" % (stroka) for stroka in array )
	return exclude
	
def HandlerOpts(options):
	array=[]
	libs=options.libs
	isDownload=options.download
	isMake=options.make
	isInstall=options.install
	exps=options.exception
	array=exceptlibs(libs,exps)
	exclude=excludelibs(libs,exps)
	
	if isDownload == bool(1):
		Download(array)
	if isMake == bool(1):
		Make(exclude)
	if isInstall == bool(1):
		Install(array)
		
	return 0
	
def init():
	__pwd=os.path.dirname(os.path.abspath( __file__ ))
	
##
## add checking work directories
##
	print("PWD: {}".format(__pwd) )
	file_download="{}/download.sh".format(__pwd)
	res = parsLibs(file_download,__arraylibs)
	if res == -1:
		print("error: init")
		return -1
	

if __name__ == "__main__":
	print ("Hello,World!")
	for param in sys.argv:
		print(param)
	if init() == -1 :
		exit
	options=HandlerArgs()
	PrintEcho(options)
	
	HandlerOpts(options)
	
