#!/usr/bin/env bash
set -e

export DISPLAY=:0
count=1
ARRAY=()
for resolution in $(xrandr --current | grep '*' | awk '{print $1}'); do
  /usr/bin/wget -O /tmp/wallpaper-${count}.jpg https://unsplash.it/$(echo $resolution | sed 's/x/\//g')/?random
  ARRAY+=('--bg-fill')
  ARRAY+=("/tmp/wallpaper-${count}.jpg")
  (( count++ ))
done
/usr/bin/feh $(echo ${ARRAY[@]})