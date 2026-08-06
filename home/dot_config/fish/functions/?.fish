function ? --wraps aichat --description 'Translate natural language to CLI command'
    # Parse options: -m/--model takes a value, -h/--help
    argparse 'm/model=' h/help -- $argv

    # Show help if requested
    if set -q _flag_help
        echo "Usage: ? [--model MODEL] <query>" >&2
        return 0
    end

    # Model flag was given?
    if set -q _flag_m
        set model $_flag_m
    end

    # Remaining arguments become the message (join into a single string)
    # $argv after argparse contains only the positional arguments
    set -l message (string join " " -- $argv)

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
