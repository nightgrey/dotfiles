function ??? --wraps aichat --description 'Ask for help with clipboard content'
    set -l clipboard
    set -l code

    set -l message (string join0 $argv)

    if test $WAYLAND_DISPLAY = no
        set clipboard (xclip -selection clipboard -o | string split0)
    else
        set clipboard (wl-paste --no-newline | string split0)
    end
    set code (block $clipboard)

    set_color grey
    echo $code
    set_color normal

    if test -n "$argv"
        set_color brred
        echo
        echo $message
        set_color normal
    end

    aichat -r help "$code
$message"
end
