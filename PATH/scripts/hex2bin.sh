#!/bin/zsh

echo -n "$1" |sed -e 's/[^0-9a-fA-F]//g'|xxd -r -p

exit
