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
