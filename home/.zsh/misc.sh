# Set locale
# https://unix.stackexchange.com/questions/87745/what-does-lc-all-c-do
export LC_ALL=en_GB.UTF-8

# Bind up/down keys to zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Load iTerm shell integration
# https://iterm2.com/documentation-shell-integration.html
source ~/.iterm2_shell_integration.zsh

# Set $EDITOR
export EDITOR="nano"
