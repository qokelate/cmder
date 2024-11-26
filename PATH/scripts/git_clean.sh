#!/bin/zsh

git reset --hard HEAD
git clean -fdx

exit

find "$PWD" -maxdepth 1 | while read line; do
	[ "$PWD" = "$line" ] && continue
	[ "$PWD/.git" = "$line" ] && continue
	echo "[INFO] delete $line"
	rm -rf "$line"
done

exit
