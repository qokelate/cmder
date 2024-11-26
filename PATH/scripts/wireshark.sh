#!/bin/zsh

cd '/tmp'

pkill -9 Wireshark
ssh -o TCPKeepAlive=yes -o ServerAliveInterval=30 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null \
  'root@10.0.0.1' 'tcpdump -ni br-lan -s 0 -w - not port 22' | '/cygdrive/c/Program Files/Wireshark/Wireshark.exe' -k -i -

exit

