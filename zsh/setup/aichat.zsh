# Integrates `aichat` into the shell.
# Type something, then press `Ctrl + E` to get a response from `aichat`.
# https://github.com/sigoden/aichat#shell-integration

_aichat_zsh() {
  if [[ -n "$BUFFER" ]]; then
    local _old=$BUFFER
    BUFFER+=" ..."
    zle -I && zle redisplay
    BUFFER=$(aichat -e "$_old")
    zle end-of-line
  fi
}
zle -N _aichat_zsh

bindkey '\ee' _aichat_zsh
