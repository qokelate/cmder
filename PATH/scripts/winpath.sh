#!/bin/zsh

path1=`cygpath -aw "$@"`
echo "${path1//\\//}"

exit
