#!  /bin/sh
#   cleanup.py
#
#       Remove all build files.
#
#   Copyright (c) 2021 Mitya Selivanov
#
#   This file is part of the Template Project.
#
#   Template Project is distributed in the hope that it will be
#   useful, but WITHOUT ANY WARRANTY; without even the implied
#   warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
#   PURPOSE. See the MIT License for more details.

rm -rf ./include/*
rm -rf ./lib/*
rm -rf ./bin/*
rm -rf ./build/*
rm -rf ./thirdparty/*/

touch ./include/.placeholder
touch ./lib/.placeholder
touch ./bin/.placeholder
touch ./build/.placeholder
