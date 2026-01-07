function ?? --wraps aichat --description 'Ask your friendly neighborhood machine'
    set -l message (string collect $argv)

    if test -z "$message"
        echo "Usage: ?? <query>" >&2
        return 1
    end

    aichat -r help "$message"
end

complete -c ?? --no-files
