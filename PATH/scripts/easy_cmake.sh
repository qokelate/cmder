#!/bin/zsh

set -e

echo "[INFO] Current Directory: $PWD"
echo "[INFO] Build to Directory: $PWD/build"

mkdir -pv "$PWD/build"
cd "$PWD/build"

"$HOME/bin/cmake.sh" ..
make -j4

exit
