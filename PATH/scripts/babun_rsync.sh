#!/bin/zsh

src="$1"
dst="$2"

if [ '' = "$dst" ]; then
  echo 'usage: babun_rsync.sh <remote_path> <local_path> [rsync_args]'
  exit
fi

shift 2
export "sshcmd=ssh -p 23 -o TCPKeepAlive=yes -o ServerAliveInterval=30 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
newcmd="rsync -azP '--compress-level=9' -e '$sshcmd'"
for a in "$@"; do
  newcmd="$newcmd '$a'"
done
newcmd="$newcmd 'robase@a.qiuxy.com:$src' '$dst'"

echo "$newcmd"
eval "$newcmd"

exit

