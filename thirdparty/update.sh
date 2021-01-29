#!  /bin/sh
#   update.sh
#
#       Update required third-party repos.
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
inc_folder="../include"
    
update_repo() {
  # $1 - url
  # $2 - folder
  # $3 - headers

  if [ -d $2 ]; then
    cd $2
    git pull
    cd ..
  else
    git clone $1 $2
  fi

  if [ -d $2 ]; then
    cd $2

    if [ -d ../$inc_folder ]; then
      cp -r `echo $3` ../`echo $inc_folder`
    fi

    cd ..
  fi
}

unpack_input() {
  # $1 - url
  # $2 - folder
  # $3 - build subfolder
  # $4 - headers

  update_repo $1 $2 $4
}

if [ -d $inc_folder ]; then
  rm -rf $inc_folder/*
fi

while read line;
  do
    unpack_input $line
  done < $deps
