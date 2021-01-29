#!  /bin/sh
#   rebuild.sh
#
#       Rebuild required third-party repos.
#
#   Copyright (c) 2021 Mitya Selivanov
#
#   This file is part of the Laplace project.
#
#   Laplace is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty
#   of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
#   the MIT License for more details.

rebuild_lib() {
  # $1 - folder
  # $2 - build subfolder
  # $3 - config (Debug/Release)
  # $4 - flags

  if [ -d $1 ]; then
    cd $1

    if [ -d $2 ]; then
      rm -rf $2
    fi

    cmake $4 \
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

unwrap_quote() {
  let len=${#1}-2
  str=$1
  if [ ${str:0:1} == '"' ]; then
    if [ $len -gt 2 ]; then
      echo ${str:1:$len}
    fi
  else
    echo $1
  fi
}

unpack_input() {
  # $1 - url
  # $2 - folder
  # $3 - build subfolder
  # $4 - headers
  # $5 - flags
  # $6 - config

  rebuild_lib \
    `unwrap_quote $2` \
    `unwrap_quote $3` \
    `unwrap_quote $6` \
    `unwrap_quote $5`
}

deps="deps.txt"

if [ $# -eq 1 ]; then
  config=$1
else
  config="Release"
fi

while read line;
  do
    unpack_input $line $config
  done < $deps
