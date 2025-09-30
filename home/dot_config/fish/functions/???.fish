function ??? --wraps aichat --description 'Ask for help with clipboard content'
    set -l message
    set -l model

    getopts $argv | while read -l key value
        switch $key
            case m model
                set model $value
                # Collect anything else into the message.
            case _
                set -a message (string split0 $value)
        end
    end

    set message (string collect $message)

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
        set clipboard (xclip -selection clipboard -o | string collect)
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

    if test -n "$model"
        aichat --model $model -r help "$query"
    else
        aichat -r help "$query"
    end
end 
