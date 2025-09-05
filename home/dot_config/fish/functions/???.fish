function ??? --wraps aichat --description 'Ask for help with clipboard content'
    if test -z "$argv"
        echo "Usage: ??? <query>" >&2
        return 1
    end

    set -l clipboard
    set -l code
    set -l query
    set -l snippet
    set -l message (string collect $argv)

    # When ghostty runs in `tdrop` (only supports X11), `fish_clipboard_paste` returns nothing.
    if test $WAYLAND_DISPLAY = "no"
        set clipboard (xclip -selection clipboard -o | string collect)
    else   
        set clipboard (wl-paste -t STRING -n | string collect)
    end
 
    set code (block $clipboard | string collect)

    if test -n "$code" 
        set snippet (tag snippet $code | string collect)
        set query $snippet

        set_color grey
        echo $code
        set_color normal
    end

    if test -n "$message"
        if test -n "$code"
            echo
            set query "$query

$message"
        else 
            set query $message
        end


        set_color brred
        echo $message
        set_color normal
    end

    if test -z "$query"
        echo "Usage: ??? <query>" >&2
        return 1
    end

   aichat -r help "$query"
end 
