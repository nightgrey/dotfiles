function ? --wraps aichat --description 'Translate natural language to CLI command'
    set -l message
    set -l model
 
    getopts $argv | while read -l key value
        switch $key
            case m model
                set model $value
            case _
                set -a message $value
        end
    end

    if test -z "$message"
        echo "Usage: ? <query>" >&2
        return 1
    end

    if test -n "$model"
        aichat --model $model -e "$message"
    else
        aichat -e "$message"
    end
end