#!/usr/bin/zsh

WorkDir=`cygpath -aw /var`
WorkRoot="${WorkDir:0:1}"
WorkVHD=`"$HOME/bin/vhd_tool.sh" --find-vhd "$WorkRoot"`

if [ ! -f "$WorkVHD" ]; then
  echo "Error: VHD not found"
  exit
fi

VHDDir=`dirname "$WorkVHD"`
rsync --existing -aP "/cygdrive/$WorkRoot/Runner/Installer/" "$(cygpath -a "$VHDDir")/"
cmd.exe /d /c "$(cygpath -aw '/mnt/root/vhd_chmod.cmd')"

exit

SHORT_HOST=$(hostname | sed -e 's/\..*//')
ZSH_COMPDUMP="${HOME}/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"
echo "ZSH_COMPDUMP: $ZSH_COMPDUMP"

cd "$HOME"

if [ '' != "$ZSH_COMPDUMP" ]; then
  rm -f "$ZSH_COMPDUMP"

  ln -sf '.zcompdump' "$ZSH_COMPDUMP"
  echo 'Babun init done!'
fi

exit 0

