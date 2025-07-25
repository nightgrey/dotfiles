# # Translate natural language to CLI command
function ? --wraps aichat --description 'Translate natural language to CLI command'
    set query (string join ' ' $argv)

    if test -z "$query"
        echo "Usage: ? <query>" >&2
        return 1
    end

    aichat -e "$query"
end

function ?? --wraps aichat --description 'Ask for help'
    set query (string join '' $argv)

    if test -z "$query"
        echo "Usage: ?? <query>" >&2
        return 1
    end

    aichat -r help "$query"
end

function ??? --wraps aichat --description 'Ask for help with clipboard content'
    set clipboard (wl-paste --no-newline | string split0)

    if test -z "$clipboard"
        echo "Clipboard is empty." >&2
        return 1
    end

    set block "```
$clipboard
```"

    set query (string join ' ' $argv)

    echo "Request:"
    set_color grey
    echo $block
    set_color normal

    if test -n "$query"
        set_color -o blue
        echo
        echo $query
        set_color normal
    end

    aichat -r help (
        echo $block
        if test -n "$query"
            echo
            echo $query
        end
    )
end
