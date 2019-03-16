#!/bin/bash -e
pushd $(dirname $0) > /dev/null
  SCRIPTPATH=$(pwd)
popd > /dev/null
pushd ~
  ln -sf "$SCRIPTPATH/i3blocks.conf" .i3blocks.conf
popd
mkdir -p ~/.config/i3/
pushd ~/.config/i3/
  ln -sf "$SCRIPTPATH/.config/i3/config" config
popd 
i3-msg restart

