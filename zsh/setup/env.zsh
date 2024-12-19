# Read desired editor from ~/.editor file
[[ -f ~/.editor ]] && export EDITOR=$(cat ~/.editor)

export BROWSER="google-chrome-stable"
# see ~dot/zsh/utils/editor.zsh
export EDITOR="${EDITOR:-nano}"
export VISUAL="${VISUAL:-nano}"
export PAGER="${PAGER:-most}"

# Used in Vite error messages.
# https://www.npmjs.com/package/@open-editor/vite
export LAUNCH_EDITOR=$EDITOR

# Language

export LANGUAGE="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LC_CTYPE="de_DE.UTF-8"
export LC_NUMERIC="de_DE.UTF-8"
export LC_COLLATE="de_DE.UTF-8"
export LC_TIME="de_DE.UTF-8"
export LC_MESSAGES="de_DE.UTF-8"
export LC_MONETARY="de_DE.UTF-8"
export LC_ADDRESS="de_DE.UTF-8"
export LC_IDENTIFICATION="de_DE.UTF-8"
export LC_MEASUREMENT="de_DE.UTF-8"
export LC_PAPER="de_DE.UTF-8"
export LC_TELEPHONE="de_DE.UTF-8"
export LC_NAME="de_DE.UTF-8"

# Keybinds
# https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html#Movement-1

# Bindkey notation:
# https://github.com/rothgar/mastering-zsh/blob/master/docs/helpers/bindkey.md (TL;DR confusing)

# More:
# https://unix.stackexchange.com/questions/116562/key-bindings-table?rq=1

# POS1, END, and DEL
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char

# CTRL+-> and CTRL+<-
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# CTRL+DEL to delete word
bindkey "^H" backward-kill-word


# Files

# Enable `< file` to quickly view the contents of any file.
[[ -z "$READNULLCMD" ]] || READNULLCMD=$PAGER

# Ensure path arrays do not contain duplicates.
typeset -gU path fpath cdpath mailpath

# Automatically clone git repositories.
alias -s git="git clone"

# Open these files with cat.
alias -s {js,json,env,md,html,css,toml}=cat


# Exclude HDD from Zoxide. Slows down shell.
# https://github.com/ajeetdsouza/zoxide
export _ZO_EXCLUDE_DIRS="/mnt/hdd/*;$HOME"
