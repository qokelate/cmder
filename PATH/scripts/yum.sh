#!/bin/zsh

cmd='pacman'
for a in "$@"; do
  [ '-h' = "$a" ] && cmd="$cmd -Sh" && continue
  [ '-y' = "$a" ] && cmd="$cmd --noconfirm" && continue
  [ '-i' = "$a" ] && cmd="$cmd -S" && continue
  [ 'install' = "$a" ] && cmd="$cmd -S" && continue
  [ 'uninstall' = "$a" ] && cmd="$cmd -Rs" && continue
  [ 'remove' = "$a" ] && cmd="$cmd -Rs" && continue
  [ 'update' = "$a" ] && cmd="$cmd -Syu" && continue
  [ '-s' = "$a" ] && cmd="$cmd -Sl | grep -i" && continue
  [ 'search' = "$a" ] && cmd="$cmd -Sl | grep -i" && continue
  [ 'info' = "$a" ] && cmd="$cmd -Sii" && continue
  [ 'download' = "$a" ] && cmd="mkdir -pv '$PWD/pkg.cache'; $cmd -y -Sw --dbpath '$PWD/pkg.cache' --cachedir '$PWD/pkg.cache'" && continue
  [ '-d' = "$a" ] && cmd="mkdir -pv '$PWD/pkg.cache'; $cmd -y -Sw --dbpath '$PWD/pkg.cache' --cachedir '$PWD/pkg.cache'" && continue
  [ '-list' = "$a" ] && cmd="$cmd -Qe" && continue
  [ '-r' = "$a" ] && cmd="$cmd -S --overwrite '*'" && continue
  [ 'reinstall' = "$a" ] && cmd="$cmd -S --overwrite '*'" && continue
  [ 'list-installed' = "$a" ] && cmd="$cmd -Qe" && continue
  [ 'list-all-installed' = "$a" ] && cmd="$cmd -Qn" && continue
  [ 'list-user-installed' = "$a" ] && cmd='comm -23 <(pacman -Qqett | sort) <(pacman -Qqg base -g base-devel | sort | uniq)' && break

  cmd="$cmd '$a'"
done

echo "[INFO] exec: $cmd"
eval "$cmd"

exit

