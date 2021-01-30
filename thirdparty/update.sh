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

deps='deps.txt'

unpack_input() {
  url=''
  folder=''
  build_to=''
  headers=''
  flags=''
  
  i=1
  for arg in $@
    do
      case $i in
        1) url=$arg ;;
        2) folder=$arg ;;
        3) build_to=$arg ;;
        4) headers=$arg ;;
        *) flags="$flags $arg"
      esac
      i=`expr $i + 1`
    done
}

inc_folder='../include'

update_repo() {
  #if [ -d $folder ]
  #  then
  #    cd $folder
  #    git pull
  #    cd ..
  #  else
  #    git clone $url $folder
  #  fi

  if [ -d $folder ]
    then
      cd $folder

      if [ -d ../$inc_folder ]; then
        cp -r `echo $headers` ../$inc_folder
      fi

      cd ..
    fi
}

if [ -d $inc_folder ]; then
  rm -rf $inc_folder/*
fi

while read line; do
  unpack_input $line
  update_repo
done < $deps
