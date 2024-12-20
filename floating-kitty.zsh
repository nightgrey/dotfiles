#!/usr/bin/env bash

# Screen
SCREEN=2560
HALF_SCREEN=$(echo "$SCREEN / 2 / 1" | bc)

# Kitty
Y="0"
W=$(echo "$SCREEN * 0.75 / 1" | bc)
X=$(echo "$HALF_SCREEN - $W / 2 / 1" | bc)
H="40%"

LANG="en_US.UTF-8" LC_ALL="de_DE.UTF-8" tdrop -P 'wmctrl -i -r $wid -b add,above,skip_taskbar' -y "$Y" -h "35%" -x "$X" -w "$W" -h "$H"  kitty --config ~/.config/kitty/floating.conf
