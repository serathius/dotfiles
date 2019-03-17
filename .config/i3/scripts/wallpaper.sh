#!/usr/bin/env bash
set -e

wget -O /tmp/wallpaper.jpg https://unsplash.it/1920/1080/?random
feh --bg-scale /tmp/wallpaper.jpg