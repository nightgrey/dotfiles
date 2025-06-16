# SGPT

# Get CLI command
alias "?"="aichat -e"

# Ask for any kind of help
alias "??"="aichat -r help"

function qqq() {
  raw=$(xclip -selection clipboard -out | tr -d '\r')
  clip=$(echo "$raw" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
  query="$1"

  if [ -z "$clip" ]; then
    echo "Clipboard is empty." >&2
    return 1
  fi

  # length < 2
  if [ "${#clip}" -lt 2 ]; then
    echo "Clipboard ('$clip') is too short." >&2
    return 1
  fi  

  block="\`\`\`\n${clip}\n\`\`\`"

  if [ $? -ne 0 ]; then
    return 1
  fi

  echo -e "Request:\n\e[1;37m$block\e[0m\e\n\n[1;31m$query\e[0m"

  aichat -r help "$block\n\n$query"
}

# Automatically send the clipboard content(s) with ask for help. Optionally, pass a prompt.
alias "???"="qqq"

# # Integrates `aichat` into the shell.
# # Type something, then press `Ctrl + E` to get a response from `aichat`.
# # https://github.com/sigoden/aichat#shell-integration
# _aichat_zsh() {
#   if [[ -n "$BUFFER" ]]; then
#     local _old=$BUFFER
#     BUFFER+=" ..."
#     zle -I && zle redisplay
#     BUFFER=$(aichat -e "$_old")
#     zle end-of-line
#   fi
# }
# zle -N _aichat_zsh

# bindkey '^E' _aichat_zsh
