#!/bin/zsh

readonly "sshcmd=ssh -p 23 -o TCPKeepAlive=yes -o ServerAliveInterval=30 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
rsync -aP --no-owner --no-perms --no-group --delete-after --dry-run -e "$sshcmd -p 23" --exclude "System Volume Information" '/mnt/root/' 'robase@a.qiuxy.com:/cygwin32/'

exit
