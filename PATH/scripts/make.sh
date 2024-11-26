#!/bin/zsh

cmd=''
for a in "$@"; do
  cmd="$cmd '$a'"
done
if [ -n "$cmd" ]; then
  cmd="'/mingw64/bin/mingw32-make' $cmd"
  echo "Command: $cmd"
  eval "$cmd"
fi

exit
