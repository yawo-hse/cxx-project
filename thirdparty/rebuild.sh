#!  /bin/sh
#   rebuild.sh
#
#       Rebuild required third-party repos.

deps='deps.txt'

generator=''
config='Release'

lib_folder='../../lib/'

rebuild_lib() {
  if [ -d "$folder" ]
    then
      cd "$folder"

      if [ -n "$generator" ]; then
        cmake \
          -G "$generator" \
          $flags \
          -D CMAKE_MSVC_RUNTIME_LIBRARY=MultiThreaded \
          -D CMAKE_BUILD_TYPE=$config \
          -B"$build_to" -H.
      else
        cmake \
          $flags \
          -D CMAKE_MSVC_RUNTIME_LIBRARY=MultiThreaded \
          -D CMAKE_BUILD_TYPE=$config \
          -B"$build_to" -H.
      fi

      cmake \
        --build "$build_to" --config "$config"

      if [ -d "$lib_folder" ]; then
        if [ -d "$build_to/$config" ]; then
          cp "$build_to/$config"/* "$lib_folder"
        elif [ -d "$build_to/lib/$config" ]; then
          cp "$build_to/lib/$config"/* "$lib_folder"
        elif [ -d "$build_to/lib" ]; then
          cp -f "$build_to/lib"/*.a "$lib_folder" 2> /dev/null
          cp -f "$build_to/lib"/*.lib "$lib_folder" 2> /dev/null
        fi
      fi

      cd ..
    fi
}

if [ $# -eq 1 ]; then
  config=$1
elif [ $# -eq 2 ]; then
  generator=$1
  config=$2
fi

next_repo() {
  url=''
  folder=''
  build_to=''
  headers=''
  flags=''
  i=0
}

next_arg() {
  case $1 in
    0) url=$2 ;;
    1) folder=$2 ;;
    2) build_to=$2 ;;
    3) headers=$2 ;;
    *) flags="$flags $2" ;;
  esac
}

next_repo

while read line; do
  if [ -n "$line" ]; then
    for arg in $line; do
      if [ "`echo $arg`" = '<repo>' ]
        then
          rebuild_lib
          next_repo
        else
          next_arg $i `echo $arg`
          i=`expr $i + 1`
        fi
    done
  fi
done < $deps

rebuild_lib
