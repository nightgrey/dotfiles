
# autocomplete

# zstyle ':completion:*' verbose yes

# http://www.masterzen.fr/2009/04/19/in-love-with-zsh-part-one/
zstyle ':completion:*:descriptions' format "$fg[yellow]%B%d%b"
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format "$fg[red]No matches for:$reset_color %d"
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'

# Submit the command when pressing enter on a menu selection
# bindkey -M menuselect '\r' .accept-line

# First insert the common substring
# https://github.com/marlonrichert/zsh-autocomplete#first-insert-the-common-substring
zstyle ':autocomplete:*complete*:*' insert-unambiguous yes
zstyle ':autocomplete:*history*:*' insert-unambiguous yes
zstyle ':autocomplete:menu-search:*' insert-unambiguous yes
# zstyle ':completion:*:*' matcher-list 'm:{[:lower:]-}={[:upper:]_}' '+r:|[.]=**'

# Limits
# https://github.com/marlonrichert/zsh-autocomplete#configuration
#zstyle -e ':autocomplete:list-choices:*' list-lines 'reply=( 256 )'
#zstyle ':autocomplete:history-incremental-search-backward:*' list-lines 256
#zstyle ':autocomplete:history-search-backward:*' list-lines 256

# Recent directories with zoxide
# https://github.com/marlonrichert/zsh-autocomplete#use-a-custom-backend-for-recent-directories
+autocomplete:recent-directories() {
    echo "zoxide"
    # Print recent directories (by time, not rating) in a list.
    # `awk` removes the time prefix (list format is usually `${time} ${path}`).
    typeset -ga reply=($(/usr/bin/zoxide query --list "$1"))
}

# New line = history search mode
# Disabled for now, not sure if I like it.
# zstyle ':autocomplete:*' default-context history-incremental-search-backward

# Always show all completions. Never ask "to see all possibilities".
# Different/native autocomplete (not sure, maybe just globally used options), but it's needed for some cases.
# unsetopt LIST_BEEP
# setopt LIST_PACKED
# export LISTMAX=0
# export LISTMAXT=0


# zsh-autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=( completion match_prev_cmd history )
ZSH_AUTOSUGGEST_HISTORY_IGNORE="cd *" # Ignore `cd` commands in history (they are not useful for autosuggestions).
ZSH_AUTOSUGGEST_USE_ASYNC=1 # Use asynchronous autosuggestions.
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#565747"


# tab-title
ZSH_TAB_TITLE_DEFAULT_DISABLE_PREFIX=true
ZSH_TAB_TITLE_ENABLE_FULL_COMMAND=true