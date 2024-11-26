#!/bin/zsh

set -x

msu=`winpath.sh "$1"`
root="/tmp/msu-expand"
name=`basename "$msu"`

mkdir -pv "$root/$name"
cd "$root/$name"

"C:/Windows/System32/expand.exe" '-F:*' "$msu" .

find . -name '*.cab' | while read line; do
  DISM.exe /Quiet /NoRestart /Online /Add-Package /PackagePath:"${line:2}"
done

cd /tmp
rm -rf "$root/$name"

exit
