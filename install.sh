#!/bin/bash -e

pushd $(dirname $0) > /dev/null
  SCRIPTPATH=$(pwd)
popd > /dev/null

function install_file {
  SRC=$1
  DST=$2
  [[ ! -s $DST ]] && mv $DST $DST.old
  ln -sf $SRC $DST
}
install_file "$SCRIPTPATH/i3blocks.conf" ~/.i3blocks.conf
install_file "$SCRIPTPATH/.bashrc" ~/.bashrc
install_file "$SCRIPTPATH/.prompt" ~/.prompt
install_file "$SCRIPTPATH/.wallpaper.jpg" ~/.wallpaper.jpg
install_file "$SCRIPTPATH/.bash_aliases" ~/.bash_aliases

mkdir -p ~/.config/i3/
install_file "$SCRIPTPATH/.config/i3/config" ~/.config/i3/config
i3-msg restart

