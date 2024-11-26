#!/bin/zsh

if [ '-s' = "$1" ]; then
	echo -n "$2" | base64 -D
	exit
fi

# data=`echo -n "$1" | base64 -D`
echo "data length: $(echo -n "$1" | base64 -D | wc -c | grep -oE '[0-9]+')"
echo -n "$1" | base64 -D | hexdump
# echo -n "$data" | hexdump

exit
