#!/usr/bin/env fish

# Screen
set SCREEN_WIDTH 2560
set SCREEN_HEIGHT 1440

# Position (bc is available in fish, but math is easier with math command)
set W (string trim (math "$SCREEN_WIDTH * 0.70"))
# set H (math "int($SCREEN_HEIGHT * 0.40)")
set H 550
set X (string trim (math "$SCREEN_WIDTH / 2 - $W / 2"))
set Y 0

echo "Width: $W, Height: $H, X: $X, Y: $Y"
env WAYLAND_DISPLAY=no tdrop -P 'wmctrl -i -r $wid -b add,above,skip_taskbar' -y $Y -x $X -w $W -h $H ghostty --config-file="/home/nico/.config/ghostty/floating.conf" --config-default-files=false
