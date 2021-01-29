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

deps="deps.txt"

rebuild_lib() {
  # $1 - folder
  # $2 - build subfolder
  # $3 - config (Debug/Release)

  if [ -d $1 ]; then
    cd $1

    if [ -d $2 ]; then
      rm -rf $2
    fi

    cmake \
      -D CMAKE_MSVC_RUNTIME_LIBRARY=MultiThreaded \
      -D CMAKE_BUILD_TYPE=$3 \
      -B$2 -H.

    cmake \
      --build $2 --config $3

    lib_folder="../../lib/"

    if [ -d $lib_folder ]; then
      if [ -d $2/$3 ]; then
        cp $2/$3/* $lib_folder
      elif [ -d $2/lib/$3 ]; then
        cp $2/lib/$3/* $lib_folder
      fi
    fi

    cd ..
  fi
}

unpack_input() {
  # $1 - url
  # $2 - folder
  # $3 - build subfolder
  # $4 - headers
  # $5 - config

  rebuild_lib $2 $3 $5
}

if [ $# -eq 1 ]; then
  config=$1
else
  config="Release"
fi

while read line;
  do
    unpack_input $line $config
  done < $deps
