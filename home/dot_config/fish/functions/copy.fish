function copi --description 'copy stdin/string/file to clipboard'
    # 1. decide which back-end
    set -q WAYLAND_DISPLAY; and test "$WAYLAND_DISPLAY" != "no"
    and set -l backend wayland
    or set -l backend x11

    # 2. handle input: stdin has priority
    if  isatty 0          # nothing piped
        # 3. treat $argv[1] as string first; if it's a readable file, copy its contents
        if test -z "$argv"
            echo "copy: nothing to copy" >&2
            return 1
        end

        if test -r "$argv[1]"   # it's a file
            cat "$argv[1]"
        else                    # it's a literal string
            printf '%s\n' "$argv"
        end | \
        switch $backend
            case wayland
                wl-copy
            case x11
                xclip -i -selection clipboard
        end
    else
        switch $backend
            case wayland
                wl-copy
            case x11
                xclip -i -selection clipboard
        end
    end
end