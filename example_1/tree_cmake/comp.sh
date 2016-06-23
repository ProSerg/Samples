
_command(){ 
    COMPREPLY=() 
    cur="${COMP_WORDS[COMP_CWORD]}" 
    prev="${COMP_WORDS[COMP_CWORD-1]}" 
    #subcommands_1="libxml2 glew gflags glog freeimage live555 openssl portaudio sdl mongocxx boost cpp-netlib googletest protobufogre freetype yasm ffmpeg x264 x265 rtmp libass theora vorbis fribidi Qt qtpropertybrowser qwt"
	subcommands_1="libxml2 glew gflags glog freeimage live555 openssl portaudio sdl"
 

   if [[ ${COMP_CWORD} == 1 ]] ; then 
        COMPREPLY=( $(compgen -W "${subcommands_1}" -- ${cur}) ) 
        return 0
   fi
}

complete -F _command ./asbuild.py
