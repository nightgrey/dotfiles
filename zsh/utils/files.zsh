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
