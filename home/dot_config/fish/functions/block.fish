function block --description 'Wrap input in a code block'
    argparse  "l/language=?" -- $argv

    set -l code (string collect "$argv")

    # Exit if no content to wrap
    if test -z "$code"
        return
    end

    if set -q _flag_language
        printf '```%s\n%s\n```' "$_flag_language" "$code"
    else
        printf '```\n%s\n```' "$code"
    end
end