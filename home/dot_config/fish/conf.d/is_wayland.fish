function is_wayland 
    # Return false if WAYLAND_DISPLAY is set to "no"
    set -q WAYLAND_DISPLAY; and test "$WAYLAND_DISPLAY" = "no"; and return 1
    # Return true if WAYLAND_DISPLAY is set or XDG_SESSION_TYPE is set to "wayland"
    set -q WAYLAND_DISPLAY; or test -n "$XDG_SESSION_TYPE" -a "$XDG_SESSION_TYPE" = wayland; and return 0
end