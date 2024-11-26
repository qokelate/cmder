#!/bin/zsh

tcount=10
aria2="aria2c '--split=$tcount' '--max-concurrent-downloads=$tcount' '--max-connection-per-server=$tcount' '--min-split-size=1M'"
# aria2="$aria2 '--file-allocation=none'"


[ "${all_proxy:0:4}" = "http" ] && proxy1="$all_proxy"
[ -n "$http_proxy" ] && proxy1="$http_proxy"
[ -n "$proxy1" ] && aria2="$aria2 '--all-proxy=$proxy1'"

unset 'all_proxy'
unset 'http_proxy'


for a in "$@"; do
	aria2="$aria2 '$a'"
done

echo "$aria2"; eval "$aria2"

exit

