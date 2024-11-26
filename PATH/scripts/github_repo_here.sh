#!/bin/zsh

set -ex

[ -d "$1" ] && cd "$1"

[ -f ".git/config" ] || git init

gh repo create --private --source . || true

git add *

git commit -am "$(date '+%Y-%m-%d %H:%M:%S')"

git push --all -u

exit
