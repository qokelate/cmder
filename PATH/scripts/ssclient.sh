#!/bin/zsh

export 'SC_Kill=shadowsocks-local.exe'
xstart 'shadowsocks-local.exe' "-s=$SS_HOST" "-k=$SS_PASS" "-p=$SS_PORT" "-m=$SS_METHOD" "-b=0.0.0.0" "-l=14601"

exit

