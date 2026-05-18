function block --description 'Wrap input in a code block'
    argparse "l/language=?" -- $argv

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

complete --command block --no-files

function tag --description 'Wrap input in a HTML/XML tag'
    argparse -n tag --min-args 2 -- $argv

    set -l tag_name "$argv[1]"
    set -l content (string collect "$argv[2..-1]")

    printf '<%s>\n%s\n</%s>' "$tag_name" "$content" "$tag_name"
end

complete --command tag --no-files

function hr --description 'Draws a horizontal rule'
    argparse n/newline -- $argv

    if test -n "$_flag_newline"
        echo -n (string repeat --count (tput cols) '─')
    else
        echo (string repeat --count (tput cols) '─')
    end
end

complete --command hr --no-files
complete --command hr --short n --long newline --description 'Do not output a newline' --exclusive
