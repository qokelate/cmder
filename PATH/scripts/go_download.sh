#!/bin/zsh

ver='1.17'
[ -n "$1" ] && ver="$1"
aria2get.sh "https://golang.org/dl/go$ver.windows-amd64.zip"

exit
