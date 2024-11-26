#!/bin/zsh

for a in "$@"; do
  taskkill.exe /f /t /im "$a"
done

exit
