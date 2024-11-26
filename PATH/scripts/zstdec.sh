#!/bin/zsh

self=`realpath "$0"`
root="$PWD"

cmd=''
for a in "$@"; do
  if [ -d "$a" ]; then
    find "$a" -type f -name '*.tar.zst' | while read line; do
      name=`basename "$line" '.tar.zst'`
      mkdir -pv "$root/$name"
      cd "$root/$name"

      "$self" "$line"
    done
    continue
  fi

  a=`cygpath -aw "$a"`
  zstd -dc "$a" | tar xv
done

exit

