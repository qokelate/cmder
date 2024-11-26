#!/bin/zsh

WorkDir=`cygpath -aw /var`
WorkRoot=`cygpath -a "/${WorkDir:0:1}"`
echo "WorkRoot: $WorkRoot"

if [ ! -f "$WorkRoot/Runner/msys2.txt" ]; then
  echo 'Error: MingW64 ROOT Path Not Found.'
  exit
fi

if [ '' != "$1" ]; then
  LogFile="${WorkRoot}/ChangeLog.txt"
  Now=`date '+%Y-%m-%d %H:%M:%S'`
  echo "$Now $1" >> "$LogFile"
fi

RSYNC_ARGS="'--exclude=cache/'" \
  "/mnt/root/Runner/rsync_tools/upload.exe" "$WorkRoot/" '/common/msys2/'

exit

