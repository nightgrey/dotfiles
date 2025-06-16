if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    export QT_QPA_PLATFORM=xcb
    export WAYLAND_DISPLAY=wayland-0
else
    
fi