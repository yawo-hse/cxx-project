#!  /bin/sh
#   update.sh
#
#       Update required third-party repos.
#
#   Copyright (c) 2021 Mitya Selivanov
#
#   This file is part of the Laplace project.
#
#   Laplace is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty
#   of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
#   the MIT License for more details.

update_repo() {
  # $1 - url
  # $2 - folder
  # $3 - headers

  if [ -d $2 ]; then
    cd $2
    git pull
    cd ..
  else
    git clone $1
  fi
  
  if [ -d $2 ]; then
    cd $2

    inc_folder="../../include"

    if [ -d $inc_folder ]; then
      cp -r $3 $inc_folder
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

  update_repo \
    `unwrap_quote $1` \
    `unwrap_quote $2` \
    `unwrap_quote $4`
}

deps="deps.txt"

while read line;
  do
    unpack_input $line
  done < $deps
