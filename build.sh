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

if [ $# -eq 1 ]; then
  config=$1
else
  config="Release"
fi

if [ `ls lib | wc -l` -eq 0 ] || [ `ls include | wc -l` -eq 0 ]; then
  ./buildall.sh
else
  rm -rf ./build/*
  touch ./bin/.placeholder

  cd build
  cmake ..
  cmake --build . --config $config
  cd ..
fi
