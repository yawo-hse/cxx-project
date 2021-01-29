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

if [ $# -eq 1 ]; then
  config=$1
else
  config="Release"
fi

./cleanup.sh

cd ./thirdparty
./update.sh
./rebuild.sh $config
cd ..

cd build
cmake ..
cmake --build . --config $config
cd ..
