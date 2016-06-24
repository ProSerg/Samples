
_command() { 
	flag=""
    COMPREPLY=() 
    cur="${COMP_WORDS[COMP_CWORD]}" 
    prev="${COMP_WORDS[COMP_CWORD-1]}" 
    subcommands="libxml2 glew gflags glog freeimage live555 openssl portaudio sdl mongocxx boost cpp-netlib googletest protobufogre freetype yasm ffmpeg x264 x265 rtmp libass theora vorbis fribidi Qt qtpropertybrowser qwt --"
	opts="--download --install --make --help"
   
   if [[ ${cur} == -* ]] ; then
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
   else   
        for el in ${COMP_WORDS[@]}; do
			if [[ ${el} == -* ]]; then
				flag="scip"
				break;
			fi
		done
		
		if [[ -z ${flag} ]]; then
			COMPREPLY=( $(compgen -W "${subcommands}" -- ${cur}) ) 
		fi
   fi
   
   return 0

}

complete -F _command ./asbuild.py
