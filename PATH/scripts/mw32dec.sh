#!/bin/zsh

src=`realpath "$1"`

if [ -n "$2" ]; then
  mkdir -pv "$2"
  cd "$2"
fi

root="$PWD"

function post_action(){
    dest="$1"
    name="$2"
    
    rm -rf "$dest/mingw32/bin"
    rm -rf "$dest/mingw32/etc"
    rm -rf "$dest/mingw32/ssl"
    rm -rf "$dest/mingw32/share"

    find "$dest/mingw32" -name '*.dll' -type f | while read line; do
      rm -fv "$line"
    done

    find "$dest/mingw32" -name '*.dll.a' -type f | while read line; do
      rm -fv "$line"
    done

    mv -fv "$dest/mingw32" "$name"
}

find "$src" -type f -name '*.tar.xz' | while read line; do
  name=`basename "$line" '.tar.xz'`
  name="${name%.*}"
  
  xzdec.sh "$line"
  post_action "$PWD" "$name"
done

find "$src" -type f -name '*.tar.zst' | while read line; do
  name=`basename "$line" '.tar.zst'`
  name="${name%.*}"
  
  zstdec.sh "$line"
  post_action "$PWD" "$name"
done

exit

