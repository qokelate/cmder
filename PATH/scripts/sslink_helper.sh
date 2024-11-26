#!/bin/zsh

ss_debuglog="/dev/null"
ss_cookies="/tmp/sslink_$RANDOM.txt"
[ '' != "$ss_proxy" ] && alias curl='curl --proxy "$ss_proxy"'
alias sscurl_n='curl -s -Lk -c "$ss_cookies" -b "$ss_cookies"'
alias sscurl_h='sscurl_n -o "$ss_debuglog"'
[ '1' = "$ss_debug" ] && alias sscurl_h='sscurl_n'

if [ ! -f "$(which md5sum)" ] && [ -f "$(which md5)" ]; then
	alias md5sum=md5
fi

funcction ss_login()
{
	ss_user="$1"
	ss_pwd="$2"
	
	ss_user="${ss_user/@/%40}"
	ss_pwd=`echo -n "$ss_pwd" | md5sum`
	ss_pwd="${ss_pwd:0:32}"
	[ '1' = "$ss_safepwd" ] && ss_pwd="$2"
	
	[ '1' = "$ss_debug" ] && echo '====================== Login Action ========================='
	sscurl_h 'https://sslinkcom.com/login' "-demail=$ss_user&redirect=%2Fmy%2Fhostings&password=$ss_pwd"
}

function ss_create()
{
	[ '1' = "$ss_debug" ] && echo '====================== Create Action ========================='
	sscurl_h 'https://sslinkcom.com/order' '-dserviceId=%E7%BE%8E%E5%9B%BD%E6%B4%9B%E6%9D%89%E7%9F%B6GR%E7%BA%BF%E8%B7%AF&term=year'
	sscurl_h 'https://sslinkcom.com/pay' -X 'POST'

	hostingId=`sscurl_n 'https://sslinkcom.com/my/hostings' | grep -oE 'hostingId\s*=\s*\S+' | tail -n 1 | grep -oE '[0-9]+'`
	sscurl_h 'https://sslinkcom.com/createHosting' "-dhostingId=$hostingId"
}

function ss_getlast()
{
	[ '1' = "$ss_debug" ] && echo '====================== Query Action ========================='
	hostingId=`sscurl_n 'https://sslinkcom.com/my/hostings' | grep -oE 'hostingId\s*=\s*\S+' | tail -n 1 | grep -oE '[0-9]+'`
	echo "hostingId: $hostingId"
	text=`sscurl_n 'https://sslinkcom.com/my/hostings' | awk "/$hostingId/,/\\/\\s*table/"`
	export SS_HOST=`echo "$text" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+'`
	export SS_PORT=`echo "$text" | awk "/端口/,/[0-9]{5}/" | grep -oE '[0-9]+'`
	export SS_PASS=`echo "$text" | awk "/密码/,/[0-9]{5,}/" | grep -oE '[0-9]+'`
	export SS_METHOD=`echo "$text" | awk "/算法/,/\\/\\s*tr/" | grep -oE '[0-9a-zA-Z]+\-[0-9a-zA-Z]+(\-[0-9a-zA-Z]+)*'`
	
	echo "host: $SS_HOST"
	echo "port: $SS_PORT"
	echo "pass: $SS_PASS"
	echo "method: $SS_METHOD"
	echo 'export env: $SS_HOST, $SS_PORT, $SS_PASS, $SS_METHOD'
}

arg_idx=0
shell_args=( "$@" )
for a in "$@"; do
	arg_idx=`expr "$arg_idx" + 1`

	[ '--create' = "$a" ] && ss_create
	[ '--query' = "$a" ] && ss_getlast
	
	if [ '--login' = "$a" ]; then
		arg_idx2=`expr "$arg_idx" + 1`
		user="$shell_args[$arg_idx2]"
		
		arg_idx2=`expr "$arg_idx" + 2`
		passwd="$shell_args[$arg_idx2]"
		
		ss_login "$user" "$passwd"
		continue
	fi
	
	if [ '--exec' = "$a" ]; then
		arg_idx2=`expr "$arg_idx" + 1`
		exec_cmd="$shell_args[$arg_idx2]"
		[ '1' = "$ss_debug" ] && echo "exec: $exec_cmd"
		eval "$exec_cmd"
		continue
	fi
done

rm -f "$ss_cookies"
exit
