#!/usr/bin/env bash

# Screen
SCREEN_WIDTH=2560
SCREEN_HEIGHT=1440

# Position (`/ 1` = rounding -- floating points would throw an error)
W=$(echo "($SCREEN_WIDTH * 0.75) / 1" | bc)
H=$(echo "($SCREEN_HEIGHT * 0.40) / 1" | bc)

X=$(echo "($SCREEN_WIDTH / 2 - $W / 2) / 1" | bc)
Y="0"

tdrop -P 'wmctrl -i -r $wid -b add,above,skip_taskbar' -y "$Y" -h "35%" -x "$X" -w "$W" -h "$H" ghostty --config-file="/home/nico/.config/ghostty/floating.conf"
   