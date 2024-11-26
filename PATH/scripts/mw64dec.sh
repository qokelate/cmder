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
    
#    rm -rf "$dest/mingw64/bin"
    rm -rf "$dest/mingw64/etc"
    rm -rf "$dest/mingw64/ssl"
    rm -rf "$dest/mingw64/share"

    find "$dest/mingw64" -name '*.dll' -type f | while read line; do
      rm -fv "$line"
    done

    find "$dest/mingw64" -name '*.dll.a' -type f | while read line; do
      rm -fv "$line"
    done

    mv -fv "$dest/mingw64" "$name"
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

