#!/bin/zsh

set -e

echo "[INFO] Current Directory: $PWD"
echo "[INFO] Build to Directory: $PWD/build"

mkdir -pv "$PWD/build"

for a in "$@"; do
  [ '--reconf' = "$a" ] && autoreconf -if
done

"$PWD/configure" --enable-static --disable-shared "--prefix=$PWD/build" "--host=x86_64-w64-mingw32"
make -j4
make install

exit
