# Default browser
export BROWSER="google-chrome-stable"

# Nativefier directory
# https://github.com/nativefier/nativefier
export NATIVEFIER_APPS_DIR="$HOME/.nativefier"

# language configuration
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Set $EDITOR
export EDITOR="nano"

# History command
HISTFILE=$HOME/.zsh_history
HISTSIZE=2000
SAVEHIST=2000
setopt hist_ignore_dups  # ignore duplication command history list
setopt hist_ignore_space # ignore when commands starts with space
setopt share_history     # share command history data
