#!/bin/bash

function order_mirrors(){  
  file1='/tmp/msys2.tmp.txt'
  cp -fv "$1" '/tmp/'
  grep '\.ustc\.' "$1" > "$file1"
  grep '\.tuna\.' "$1" >> "$file1"
  grep -v '\.ustc\.' "$1" | grep -v '\.tuna\.' >> "$file1"
  mv -fv "$file1" "$1"
}

order_mirrors "/etc/pacman.d/mirrorlist.msys"
order_mirrors "/etc/pacman.d/mirrorlist.mingw32"
order_mirrors "/etc/pacman.d/mirrorlist.mingw64"
order_mirrors "/etc/pacman.d/mirrorlist.ucrt64"
order_mirrors "/etc/pacman.d/mirrorlist.clang64"

pacman --noconfirm -Syu || export error=1
pacman --noconfirm -Syuu || export error=2

order_mirrors "/etc/pacman.d/mirrorlist.msys"
order_mirrors "/etc/pacman.d/mirrorlist.mingw32"
order_mirrors "/etc/pacman.d/mirrorlist.mingw64"
order_mirrors "/etc/pacman.d/mirrorlist.ucrt64"
order_mirrors "/etc/pacman.d/mirrorlist.clang64"

rm -rf /var/cache/pacman/pkg/*

if [ -n "$error" ]; then
  echo "[ERROR] error occur, need check."
  read line
fi

exit 0

