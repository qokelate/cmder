#!/bin/sh

SRC="$1"
DST="$2"
[ -z "$DST" ] && DST="$PWD/$(basename "$SRC").zip"

if [ ! -d "${SRC}" ]; then
	echo "usage: zipFolder.sh <folder_path> [zip_path]"
	exit 0
fi

cd "$SRC"
cd ..
rm -f "${DST}"

echo "cd '$PWD'"
cmd="zip --symlinks -9r '${DST}' '$(basename "$SRC")'"
echo "$cmd"; eval "$cmd"

if [ -f "${DST}" ]; then
	echo "[INFO] zip: ${SRC}"
	echo "[INFO] to: ${DST} success!"
else
	echo "[INFO] zip: ${SRC}"
	echo "[INFO] to: ${DST} failed!"
fi

exit
