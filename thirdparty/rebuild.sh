#!  /bin/sh
#   rebuild.sh
#
#       Rebuild required third-party repos.
#
#   Copyright (c) 2021 Mitya Selivanov
#
#   This file is part of the Template Project.
#
#   Template Project is distributed in the hope that it will be
#   useful, but WITHOUT ANY WARRANTY; without even the implied
#   warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
#   PURPOSE. See the MIT License for more details.

deps='deps.txt'

unpack_input() {
  url=''
  folder=''
  build_to=''
  headers=''
  flags=''
  
  i=1
  for arg in $@
    do
      case $i in
        1) url=$arg ;;
        2) folder=$arg ;;
        3) build_to=$arg ;;
        4) headers=$arg ;;
        *) flags="$flags $arg"
      esac
      i=`expr $i + 1`
    done
}

config='Release'
lib_folder='../../lib/'

rebuild_lib() {
  if [ -d $folder ]
    then
      cd $folder

      if [ -d $build_to ]; then
        rm -rf $build_to
      fi

      cmake \
        $flags \
        -D CMAKE_MSVC_RUNTIME_LIBRARY=MultiThreaded \
        -D CMAKE_BUILD_TYPE=$config \
        -B$build_to -H.

      cmake \
        --build $build_to --config $config

      if [ -d $lib_folder ]
        then
          if [ -d $build_to/$config ]; then
            cp $build_to/$config/* $lib_folder
          elif [ -d $build_to/lib/$config ]; then
            cp $build_to/lib/$config/* $lib_folder
          elif [ -d $build_to/lib/ ]; then
            cp -f $build_to/lib/*.a $lib_folder 2> /dev/null
            cp -f $build_to/lib/*.lib $lib_folder 2> /dev/null
          fi
        fi

      cd ..
    fi
}

if [ $# -eq 1 ]; then
  config=$1
fi

while read line; do
  unpack_input $line
  rebuild_lib
done < $deps
