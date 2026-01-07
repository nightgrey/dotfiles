function ??? --wraps aichat --description 'Ask your friendly neighborhood machine - with clipboard'
    set -l message (string collect "$argv" | string trim)

    if test -z "$message"
        echo "Usage: ??? <query>" >&2
        return 1
    end 

    set -l clipboard
    set -l code
    set -l query
    set -l snippet

    # When ghostty runs in `tdrop` (only supports X11), `fish_clipboard_paste` returns nothing.
    if is_wayland
        for type in STRING 'text/plain' 'text/plain;charset=utf-8' 'text/plain;charset=utf-8;format=text/plain' 'text/html'
            if wl-paste --type="$type" >/dev/null 2>&1
                # Set the first that works, then break.
                set clipboard (wl-paste --type="$type" -n | string collect)
                break
            end
        end
    else    
        set clipboard (xclip -out -selection clipboard | string collect)
    end
 

    if test -n "$clipboard" 
        set -l blocked (block $clipboard | string collect)
        printf "<snippet>\n%s\n</snippet>\n" "$blocked"
        set -a query "$blocked"
    end

    if test -n "$message"
        printf "\n\x1b[1;31m%s\x1b[0m\n\n" "$message"

        set -a query "

$message"
    end


    aichat -r help "$query"
end 
