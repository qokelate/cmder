#!/bin/zsh

export 'PATH1=/mingw64/bin:/home/Administrator/bin'
export 'PATH2=/c/Windows:/c/Windows/System32:/c/Windows/System32/Wbem:/c/Windows/System32/WindowsPowerShell/v1.0'
export "PATH=$PATH1:$PATH2"

cmd=''
for a in "$@"; do
  cmd="$cmd '$a'"
done
if [ -n "$cmd" ]; then
  echo "PATH: $PATH"
  echo "Command: $cmd"
  eval "$cmd"
fi

exit

