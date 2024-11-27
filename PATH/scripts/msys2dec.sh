#!/bin/zsh

set -ex

if ! which cmd.exe; then
    function cygpath(){
        realpath "$2"
    }
fi

function decompress_zst(){
    root="$PWD"
    for a in "$@"; do
        if [ -d "$a" ]; then
            find "$a" -type f -name '*.tar.zst' | while read line; do
                name=`basename "$line" '.tar.zst'`
                mkdir -pv "$root/$name"
                pushd "$root/$name"
                decompress_zst "$line"
                popd
            done
            continue
        fi

        a=`cygpath -aw "$a"`
        zstd -dc "$a" | tar xv
    done
}

function decompress_xz() {
    root="$PWD"
    for a in "$@"; do
        if [ -d "$a" ]; then
            find "$a" -type f -name '*.tar.xz' | while read line; do
                name=`basename "$line" '.tar.xz'`
                mkdir -pv "$root/$name"
                pushd "$root/$name"
                decompress_xz "$line"
                popd
            done
            continue
        fi

        a=`realpath "$a"`
        tar -Jxvf "$a"
    done
}

src=`realpath "$1"`

if [ -n "$2" ]; then
  mkdir -pv "$2"
  cd "$2"
fi
root="$PWD"

find "$src" -type f -name '*.tar.xz' | while read line; do
  decompress_xz "$line"
done

find "$src" -type f -name '*.tar.zst' | while read line; do
  decompress_zst "$line"
done

exit

