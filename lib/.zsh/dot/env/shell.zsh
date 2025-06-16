
# History
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt HIST_IGNORE_DUPS # Ignore duplicated commands
setopt HIST_IGNORE_ALL_DUPS # Ignore duplicated commands
setopt HIST_IGNORE_SPACE # Ignore commands that start with a space
setopt HIST_SAVE_NO_DUPS # Don't save duplicated commands
setopt SHARE_HISTORY # Share command history between all sessions
setopt APPEND_HISTORY # Append to command history instead of overwriting it
setopt INC_APPEND_HISTORY # Append to command history instead of overwriting it

# Files
# auto_cd: Allows you to change directories by typing the directory name without 'cd'
# auto_pushd: Automatically pushes old directory onto directory stack when changing dirs
# pushd_ignore_dups: Don't push duplicate directories onto the stack
# pushdminus: Makes 'cd -n' work like 'cd +n' for easier navigation through dir history
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus


# Keybinds
# https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html#Movement-1
# Bindkey notation: https://github.com/rothgar/mastering-zsh/blob/master/docs/helpers/bindkey.md (TL;DR confusing)
# More: https://unix.stackexchange.com/questions/116562/key-bindings-table?rq=1

# POS1, END, and DEL
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char

# CTRL+-> and CTRL+<-
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# CTRL+DEL to delete word
bindkey "^H" backward-kill-word

# Jump into autocompletion menu with tab
#bindkey '^I' menu-select
#bindkey "$terminfo[kcbt]" menu-select

# Named directories
# Can be accessed by `~name`, for example `cd ~dev`.
# https://askubuntu.com/a/1042076
hash -d dev=~/Developer
hash -d dot=$DOTFILES
hash -d dotfiles=$DOTFILES
hash -d ai=~/hdd/Data/AI
hash -d hdd=~/hdd
hash -d models=~/AI/Models
hash -d canvas=~/Developer/own/canvas

# Enable `< file` to quickly view the contents of any file.
[[ -z "$READNULLCMD" ]] || READNULLCMD=$PAGER

# Ensure path arrays do not contain duplicates.
typeset -gU path fpath cdpath mailpath

# Automatically clone git repositories.
alias -s git="git clone"

# Open these files with cat.
alias -s {js,json,env,md,html,css,toml}=cat

# zsh-autocomplete
# http://www.masterzen.fr/2009/04/19/in-love-with-zsh-part-one/
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path ~/.cache/zsh/autocomplete

# Limits
# https://github.com/marlonrichert/zsh-autocomplete#configuration
# zstyle ':autocomplete:list-choices:*' list-lines 32
# zstyle ':autocomplete:history-incremental-search-backward:*' list-lines 24
# zstyle ':autocomplete:history-search-backward:*' list-lines 128

# Recent directories with zoxide
# https://github.com/marlonrichert/zsh-autocomplete#use-a-custom-backend-for-recent-directories
+autocomplete:recent-directories() {
    echo "zoxide"
    # Print recent directories (by time, not rating) in a list.
    # `awk` removes the time prefix (list format is usually `${time} ${path}`).
    typeset -ga reply=($(/usr/bin/zoxide query --list "$1" | head -20))
}


# zsh-autosuggestions
ZSH_AUTOSUGGEST_HISTORY_IGNORE="cd *" # Ignore `cd` commands in history (they are not useful for autosuggestions).
# ZSH_AUTOSUGGEST_USE_ASYNC=1 # Use asynchronous autosuggestions.
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#565747"

# zsh-syntax-highlighting
ZSH_HIGHLIGHT_MAXLENGTH=512
ZSH_HIGHLIGHT_DEBUG=1

# Automatically disable during paste operations
zle_highlight+=(paste:none)

# Highlight dangerous commands
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf' 'fg=red,bold,bg=yellow')

# Exclude HDD from Zoxide. Slows down shell.
# https://github.com/ajeetdsouza/zoxide
export _ZO_EXCLUDE_DIRS="/mnt/hdd/*;$HOME"

# tab-title
ZSH_TAB_TITLE_DEFAULT_DISABLE_PREFIX=true
ZSH_TAB_TITLE_ENABLE_FULL_COMMAND=true


#############
#### UNUSED #
#############

# zstyle ':completion:*' verbose yes
# zstyle ':completion:*:descriptions' format "$fg[yellow]%B%d%b"
# zstyle ':completion:*:messages' format '%d'
# zstyle ':completion:*:warnings' format "$fg[red]No matches for:$reset_color %d"
# zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'

# Submit the command when pressing enter on a menu selection
# bindkey -M menuselect '\r' .accept-line

# First insert the common substring
# https://github.com/marlonrichert/zsh-autocomplete#first-insert-the-common-substring
# zstyle ':autocomplete:*complete*:*' insert-unambiguous yes
# zstyle ':autocomplete:*history*:*' insert-unambiguous yes
# zstyle ':autocomplete:menu-search:*' insert-unambiguous yes
# zstyle ':completion:*:*' matcher-list 'm:{[:lower:]-}={[:upper:]_}' '+r:|[.]=**'
# New line = history search mode
# Disabled for now, not sure if I like it.
# zstyle ':autocomplete:*' default-context history-incremental-search-backward

# Always show all completions. Never ask "to see all possibilities".
# Different/native autocomplete (not sure, maybe just globally used options), but it's needed for some cases.
# unsetopt LIST_BEEP
# setopt LIST_PACKED
# export LISTMAX=0
# export LISTMAXT=0
