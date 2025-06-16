#!/usr/bin/env bash

# Screen
SCREEN_WIDTH=2560
SCREEN_HEIGHT=1440

# Position (`/ 1` = rounding -- floating points would throw an error)
W=$(echo "($SCREEN_WIDTH * 0.70) / 1" | bc)
# H=$(echo "($SCREEN_HEIGHT * 0.40) / 1" | bc)
H=550
X=$(echo "($SCREEN_WIDTH / 2 - $W / 2) / 1" | bc)
Y="0"
 
# GTK_THEME=Sierra-dark-customized 
# GTK_DEBUG=interactive
WAYLAND_DISPLAY=no tdrop -P 'wmctrl -i -r $wid -b add,above,skip_taskbar'  -y "$Y" -x "$X" -w "$W" -h "$H" ghostty --config-file="/home/nico/.config/ghostty/floating.conf" --config-default-files=false  
# CLASS="floating.ghostty"
# EXISTS=false
# VISIBLE=false

# if xdotool search --class "$CLASS" >/dev/null 2>&1; then
#     EXISTS=true
# else
#     EXISTS=false
# fi

# if xdotool search --onlyvisible --class "$CLASS" >/dev/null 2>&1; then
#     VISIBLE=true
# else
#     VISIBLE=false
# fi


# if [ "$EXISTS" = true ]; then

#     if [ "$VISIBLE" = true ]; then
#         notify-send "Ghostty" "Visible."
#     else
#         notify-send "Hidden or closed" 
#     fi

#     notify-send "Ghostty" "Toggle visibility..."
#     xdotool search --class "$CLASS" -- windowstate --toggle HIDDEN


# else
#     notify-send "Ghostty" "Closed."

#     ghostty --config-file="/home/nico/.config/ghostty/floating.conf" --config-default-files=false  &

#         xdotool search --limit 1 --class "floating.ghostty" -- windowstate --add ABOVE,STICKY,SKIP_TASKBAR
# fi



# # if xdotool search --class "$CLASS" > /dev/null 2>&1; then
# #     notify-send "Ghostty" "Window doesn't exist, launching the app..."

# #     ghostty --config-file="/home/nico/.config/ghostty/floating.conf" --config-default-files=false  &
# # else 

# #     # Check if window is hidden with wmctrl
# #    if wmctrl -lx | grep "floating.ghostty" | awk '{print $2}' | grep -q "^-"; then
# #         notify-send "Ghostty" "Window is hidden, showing it..."
# #         # Window is hidden, show it
# #         wwmctrl -x -r "floating.ghostty" -b "remove,hidden"
# #     else
# #         notify-send "Ghostty" "Window is visible, hide it..."
# #         # Window is visible, minimize it
# #         wwmctrl -x -r "floating.ghostty" -b "add,hidden"
# #     fi
# fi
