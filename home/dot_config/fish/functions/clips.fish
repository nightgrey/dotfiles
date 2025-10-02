function clips --description "Collect clipboard history until Ctrl-C, then dump it"
    if is_wayland
        set watcher wl-paste -w
    else 
        set watcher xclip -out -selection clipboard -quiet
        set poll true
    end

    set -l seen     # list of unique clips
    set -l last     # last clip we stored

    function _remember --argument clip
        if test "$clip" != "$last"
            set -g last $clip
            set -a seen $clip
        end
    end

    # Trap Ctrl-C so we can still print what we collected
    trap "echo; _clips_dump" INT

    function _clips_dump
        printf "\n--- collected %d clip(s) ---\n\n" (count $seen)
        for item in $seen
            printf '```\n%s\n```\n\n' "$item"
        end
        exit 0
    end

    # Wayland path: wl-paste -w blocks and spits out data on every change
    if is_wayland
        $watcher | while read -lz line
            _remember $line
        end
    else
        # X11 path: poll once every 0.3 s
        while true
            set -l cur ($watcher 2>/dev/null)
            _remember $cur
            sleep 0.3
        end
    end
end