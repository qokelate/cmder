#!/bin/zsh

if [ '--list' = "$1" ]; then
  shift 1
  echo -ne 'list vdisk \r\n' | diskpart | grep -oE '[a-zA-Z]:\\.+$'
  exit
fi

if [ '--detail' = "$1" ]; then
  shift 1
  vhd="$1"
  vhd=`cygpath -aw "$vhd"`
  vhd="${vhd//\\/\\\\}"
  echo -ne "sel vdisk file=\"$vhd\" \r\n detail disk \r\n" | diskpart
  exit
fi

if [ '--get-letter' = "$1" ]; then
  "$0" --detail "$2" | grep -oE '^\s*Volume\s+\w+\s+\w+' | grep -oE '\w+$' | head -n 1
  exit
fi

if [ '--find-vhd' = "$1" ]; then
  dest="$2"
  list=`"$0" '--list'`
  list="${list//\\//}"
  echo "$list" | while read line; do
    letter=`"$0" '--get-letter' "$(cygpath -a "$line")"`
    echo "$letter" | grep -oisqE "^\\s*$dest" && cygpath -aw "$line"
  done
  exit
fi


exit

