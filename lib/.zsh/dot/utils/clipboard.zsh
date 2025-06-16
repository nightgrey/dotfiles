alias copy="xclip -selection clipboard -in"
# Original `paste` CLI. Hopefully this doesn’t break anything.
alias paste=_paste
alias paste="xclip -selection clipboard -out"

# Copy path to clipboard
function path {
    arg="${1:-$PWD}"
    absolute_path=$(realpath -s "${arg}")
    echo -n "${absolute_path}" | xclip -selection clipboard
    echo "✅ Copied absolute path to ${arg}"
}

# Copy file contents to clipboard
function content {
    arg="${1}"

    if [ -z "${arg}" ]; then
        echo "❌ Please provide a path."
        return 1
    fi

    absolute_path=$(realpath -s "${arg}")
    echo -n "$(cat "${1}")" | xclip -selection clipboard
    echo "✅ Copied content of ${arg}"
}