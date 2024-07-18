
echo "[INFO] sma11case shell loading"

#set -ex

export 'MSYSTEM=MINGW64'
export 'MSYSCON=conemu'
#export 'MSYS2_PATH_TYPE=inherit'
export 'CONTITLE=MinGW x64'
export 'CONICON=mingw64.ico'


export 'MSYS=winsymlinks:lnk'
export 'CYGWIN=winsymlinks:lnk'

#export CYGWIN="winsymlinks:native"
#export CYGWIN="winsymlinks:nativestrict"
#export CYGWIN="winsymlinks:lnk"

export 'CHERE_INVOKING=1'
[ -n "$MINTTY" ] && export 'TERM=xterm-256color'
#export 'TERMINFO=/usr/share/terminfo'
#export 'MSYSTEM=MINGW64'
export 'MSYS2_ARG_CONV_EXCL=*'
export 'MSYS_NO_PATHCONV=1'
#export 'MSYS2_PATH_TYPE=inherit'

function GetWinPath(){
  WorkDir=`cygpath -aw "$1"`
  WorkRoot="${WorkDir//\\//}"
  echo "$WorkRoot"
}
export GetWinPath


function GetLinuxPath(){
  WorkDir=`GetWinPath "$1"`
  realpath "/${WorkDir:0:1}/${WorkDir:3}"
}
export GetLinuxPath

CMDROOT=`GetLinuxPath "$CMDROOT"`
CMDROOT=`realpath "$CMDROOT"`

#set -ex

#################################################################

if [ ! -f '/tmp/zsh.ok' ]; then
  mkdir -pv /tmp
  mount -o bind,binary "$TEMP" /tmp
  touch /tmp/zsh.ok

  mkdir -pv "/home/$USERNAME"
  mount -o bind,binary "$HOME" "/home/$USERNAME"

  mkdir -pv "/home/$USERNAME/WinHome"
  mount -o bind,binary "$(GetLinuxPath "$USERPROFILE")" "/home/$USERNAME/WinHome"
fi
export "HOME=/home/$USERNAME"

#sleep 111


PLAT_LINUX='linux'
PLAT_OSX='osx'
PLAT_WIN='win'

PLAT="${PLAT_LINUX}"
[ -f "$WINDIR/System32/kernel32.dll" ] && PLAT="${PLAT_WIN}"
[ -f '/Applications/iTunes.app/Contents/MacOS/iTunes' ] && PLAT="${PLAT_OSX}"

export LANG="zh_CN.UTF-8"
export LC_COLLATE="zh_CN.UTF-8"
export LC_CTYPE="zh_CN.UTF-8"
export LC_MESSAGES="zh_CN.UTF-8"
export LC_MONETARY="zh_CN.UTF-8"
export LC_NUMERIC="zh_CN.UTF-8"
export LC_TIME="zh_CN.UTF-8"
export LC_ALL="zh_CN.UTF-8"

# Uncomment this to disable daily auto-update & proxy checks on startup (not recommended!)
export DISABLE_CHECK_ON_STARTUP="true"

export ZSH="${HOME}/.oh-my-zsh"
export PATH="${ZSH}/scripts:${PATH}"
export PATH="/opt/subversion/bin:${PATH}"
export PATH="/opt/local/bin:/opt/local/sbin:${PATH}"

HISTFILE='/tmp/.zsh_history'
[ ! -f "$HISTFILE" ] && touch "$HISTFILE"

setopt localoptions rmstarsilent

setopt no_hup
setopt no_checkjobs
setopt NO_CHECK_JOBS

ZSH_THEME="sma11case"
DISABLE_AUTO_UPDATE="true"
HIST_STAMPS="yyyy-mm-dd"

if [ -f "$ZSH/platforms/common/${PLAT}.sh" ]; then
  echo "[INFO] load <ZSH>/platforms/common/${PLAT}.sh"
  source "$ZSH/platforms/common/${PLAT}.sh"
fi

[ `id -u` -eq 0 ] && ZSH_DISABLE_COMPFIX=true
source "${ZSH}/oh-my-zsh.sh"

alias cls='clear'
alias ll='ls -l'
alias la='ls -a'
alias vi='vim'
alias javac="javac -J-Dfile.encoding=utf8"
alias grep="grep --color=auto"
alias igrep="grep --color=auto -i"
alias dir='ls -lah'

export sshcmd='ssh -t -o TCPKeepAlive=yes -o ServerAliveInterval=30 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
alias ssh="$sshcmd"


if [ -f "$ZSH/platforms/common/${PLAT}_post.sh" ]; then
  echo "[INFO] load <ZSH>/platforms/common/${PLAT}_post.sh"
  source "$ZSH/platforms/common/${PLAT}_post.sh"
fi

