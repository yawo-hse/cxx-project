#!  /bin/sh
#   cleanup.py
#
#       Build the project.
#
#   Copyright (c) 2021 Mitya Selivanov
#
#   This file is part of the Template Project.
#
#   Template Project is distributed in the hope that it will be
#   useful, but WITHOUT ANY WARRANTY; without even the implied
#   warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
#   PURPOSE. See the MIT License for more details.

generator=''
config='Release'

if [ $# -eq 1 ]; then
  config=$1
elif [ $# -eq 2 ]; then
  generator="$1"
  config=$2
fi

if [ `ls lib | wc -l` -eq 0 ] || [ `ls include | wc -l` -eq 0 ]; then
  ./buildall.sh "$generator" $config
else
  rm -rf ./build/*
  touch ./bin/.placeholder

  cd ./build

  if [ -n "$generator" ]; then
    generator="-G $generator"
  fi

  cmake \
    $generator \
    -D CMAKE_MSVC_RUNTIME_LIBRARY=MultiThreaded \
    -D CMAKE_BUILD_TYPE=$config \
    ..

  cmake \
    --build . --config $config

  cd ..
fi
