# Utility to quickly open my dotfiles folder or a specific dotfiles script in VSCode.
dot() {
    if [ $# -eq 0 ]; then
        code ~dot
    else
        code ~dot/$1
    fi
}

_dot() {
    # Start completing from `~dot` and exclude `*.zwc` files.
    _files -W ~dot -F "*.zwc"
}
compdef _dot dot


# Utility to quickly load a specific dotfiles script
reload() {
    if [ $# -eq 0 ]; then
        echo -e "Specify a path relative to \`~dot/zsh\`."
        echo "Example: \`reload utils/ai.zsh\`"
    else
        source ~dot/zsh/$1

        alias rl="reload $1"

        echo "Reloaded \`$1\`. Repeat with \`rl\`."
    fi
}

_reload() {
    # Start completing from `~dot` and exclude `*.zwc` files.
    _files -W ~dot/zsh -F "*.zwc"
}
compdef _reload reload

