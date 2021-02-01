#!  /bin/sh
#   cleanup.py
#
#       Build the project.

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
fi
