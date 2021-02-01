#!  /bin/sh
#   buildall.py
#
#       Rebuild the entire project with
#       all the dependencies.
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

./cleanup.sh

cd ./thirdparty
./update.sh
./rebuild.sh "$generator" $config
cd ..

cd ./build

if [ -n "$generator" ]; then
  cmake \
    -G "$generator" \
    -D CMAKE_MSVC_RUNTIME_LIBRARY=MultiThreaded \
    -D CMAKE_BUILD_TYPE=$config \
    ..
else
  cmake \
    -D CMAKE_MSVC_RUNTIME_LIBRARY=MultiThreaded \
    -D CMAKE_BUILD_TYPE=$config \
    ..
fi

cmake \
  --build . --config $config

cd ..
