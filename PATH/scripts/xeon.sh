#!/bin/zsh

export 'all_proxy=socks5://127.0.0.1:14601'
export 'http_proxy=http://127.0.0.1:14602'

echo "export 'all_proxy=$all_proxy'"
echo "export 'http_proxy=$http_proxy'"

cmd=''
for a in "$@"; do
  cmd="$cmd '$a'"
done
if [ -n "$cmd" ]; then
  echo "Command: $cmd"
  eval "$cmd"
fi

exit