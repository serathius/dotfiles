#!/bin/bash -e
sudo apt-get install i3blocks
pushd $(dirname $0) > /dev/null
  SCRIPTPATH=$(pwd)
popd > /dev/null
pushd ~
  ln -sf "$SCRIPTPATH/i3blocks.conf" .i3blocks.conf
popd
mkdir -p ~/.i3
pushd ~/.i3
  ln -sf "$SCRIPTPATH/i3.conf" config
popd 
i3-msg restart

