#!/bin/zsh

[ -n "$1" ] && src=`cygpath -a "$1"`
[ -n "$2" ] && dst=`cygpath -a "$2"`

if [ -z "$2" ] || [ ! -e "$src" ]; then
  echo "usage: $(basename "$0") <src> <dst> [other_fastcopy_args]"
  exit
fi

if [ -d "$src" ]; then
  [ "$(basename "$src")" = "$(basename "$dst")" ] && dst=`dirname "$dst"`
fi

shift 2
src=`cygpath -aw "$src"`
src="${src//\\/\\\\}"
dst=`cygpath -aw "$dst"`
dst="${dst//\\/\\\\}"
[ -d "$src" ] && dst="$dst\\"
readonly "fc=/mnt/root/FastCopy380_x64/FastCopy.exe"
cmd="nohup '$fc' /cmd=diff /auto_close /estimate /open_window '$src' '/to=$dst' >/dev/null 2>/dev/null &"

echo "$cmd"
eval "$cmd"

exit

