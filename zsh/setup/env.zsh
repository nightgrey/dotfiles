
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
#these are my config files. still, journactl is showing `Dez 19 22:08:29 linux kioworker[158557]: Detected locale C with character encoding ANSI_X3.4-1968 which is not UTF-8. Qt depends on a UTF-8 locale, and has switched to C.UTF-8 instead. If this causes problems, reconfigure your locale. See the locale(1) manual for more information.` all the time. how can I fix this?!


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
