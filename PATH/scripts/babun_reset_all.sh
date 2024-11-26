#!/bin/zsh

WorkDir=`cygpath -aw /`
WorkRoot="${WorkDir//\\//}"
WorkRoot="/${WorkRoot:0:1}/${WorkRoot:3}"
WorkRoot=`dirname "$WorkRoot"`
echo "WorkRoot: $WorkRoot"


if [ ! -f "$WorkRoot/Runner/msys2.txt" ]; then
  echo 'Error: MingW64 ROOT Path Not Found.'
  exit
fi


tmpdir="/tmp/rsync_tools"
rsync -aqP "/mnt/root/Runner/rsync_tools/" "$tmpdir/"
"$tmpdir/pull.exe" '/common/msys2/' "$WorkRoot/" 
rm -rf "$tmpdir"

exit

