#!/bin/zsh

self=`realpath "$0"`
root="$PWD"

cmd=''
for a in "$@"; do
  if [ -d "$a" ]; then
    find "$a" -type f -name '*.tar.xz' | while read line; do
      name=`basename "$line" '.tar.xz'`
      mkdir -pv "$root/$name"
      cd "$root/$name"

      "$self" "$line"
    done
    continue
  fi

  a=`realpath "$a"`
  tar -Jxvf "$a"
done

exit


