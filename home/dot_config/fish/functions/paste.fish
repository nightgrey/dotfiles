function paste --description 'print clipboard contents to stdout'
    set -q WAYLAND_DISPLAY; and test "$WAYLAND_DISPLAY" != "no"
    and set -l backend wayland
    or set -l backend x11 
 
    switch $backend 
        case wayland
            wl-paste
        case x11 
            xclip -o -selection clipboard
    end
end