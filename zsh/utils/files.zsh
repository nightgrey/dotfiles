# Search
alias "?file"="find ./ -type f -name"
alias "?dir"="find ./ -type d -name"

# Size
alias size="du -Lsm --human-readable"

# Open dolphin file manager
function here {
    dolphin "${1:-$PWD}" >/dev/null 2>&1 &
    disown
}

alias open=here


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