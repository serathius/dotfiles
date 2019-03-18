#!/usr/bin/env bash
set -e

IMAGE=/tmp/i3lock.png
TEXT="locked"
RESOURCES=/home/serathius/.config/i3/resources
RES=$(xrandr -q|perl -F'\s|,' -lane "/^Sc/&&print join '',@F[8..10]")
BOXSIZE=$(expr $(echo $RES | cut -d 'x' -f1) / 2)

if [[ $1 != "" ]]; then
    TEXT=$1
fi

ffmpeg -f x11grab -video_size $RES -y -i $DISPLAY -i $RESOURCES/lock.png -filter_complex "boxblur=5,drawtext=fontfile=$RESOURCES/Digital_tech.otf:text=$TEXT:fontcolor='#ffffffe0':fontsize=40:x=(w-tw)/2:y=(h/PHI)+th:shadowcolor='#1d1f21d0':shadowx=2:shadowy=2:box=1:boxcolor=#1a1b22@0.4:boxborderw=$BOXSIZE,overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2" -vframes 1 $IMAGE

/usr/bin/i3lock -i $IMAGE

rm $IMAGE