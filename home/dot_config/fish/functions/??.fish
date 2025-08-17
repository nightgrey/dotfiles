function ?? --wraps aichat --description 'Send prompt to AI and get help'
    set query (string join '' $argv)

    if test -z "$query"
        echo "Usage: ?? <query>" >&2
        return 1
    end

    aichat -r help "$query"
end