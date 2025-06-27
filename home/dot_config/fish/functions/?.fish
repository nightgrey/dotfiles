function ? --wraps aichat --description 'Translate natural language to CLI command'
    set query (string join ' ' $argv)

    if test -z "$query"
        echo "Usage: ? <query>" >&2
        return 1
    end

    aichat -e "$query"
end