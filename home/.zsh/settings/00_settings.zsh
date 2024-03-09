# Movement
# https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html#Movement-1

# POS1, END, and DEL
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char

# CTRL+-> and CTRL+<-
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Bind up and down to history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Configuration for zsh autocompletion.

# Increase limits for zsh-autocomplete
# See https://github.com/marlonrichert/zsh-autocomplete#configuration
#zstyle -e ':autocomplete:list-choices:*' list-lines 'reply=( 256 )'
#zstyle ':autocomplete:history-incremental-search-backward:*' list-lines 256
#zstyle ':autocomplete:history-search-backward:*' list-lines 256

# Submit the command when pressing enter - always.
# bindkey -M menuselect '\r' .accept-line

# Set recent directory backend to use `z`.
# https://github.com/marlonrichert/zsh-autocomplete#use-a-custom-backend-for-recent-directories
+autocomplete:recent-directories() {
    # Print recent directories (by time, not rating) in a list.
    # `awk` removes the time prefix (list format is usually `${time} ${path}`).
    typeset -ga reply=($(z -lt | awk '{print $2}'))
}

# New line = history search mode
# Note: Disabled for now, not sure if I like it.
# zstyle ':autocomplete:*' default-context history-incremental-search-backward

# Always show all completions. Never ask "to see all possibilities".
# Note: Different/native autocomplete (not sure, maybe just globally used options), but it's needed for some cases.
unsetopt LIST_BEEP
setopt LIST_PACKED
export LISTMAX=0
export LISTMAXT=0

# Enable `< file` to quickly view the contents of any file.
[[ -z "$READNULLCMD" ]] || READNULLCMD=$PAGER