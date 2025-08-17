# Function 'd' is a wrapper around the 'dirs' command that shows directory stack
# If an argument is provided, passes it directly to 'dirs'
# If no argument, shows the first 10 entries of directory stack in numbered format
function d() {
  if [[ -n $1 ]]; then
    dirs "$@"
  else
    dirs -v | head -n 10
  fi
}

# List directory contents
alias lsa='ls -lah'
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
