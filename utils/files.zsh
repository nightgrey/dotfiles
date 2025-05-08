# auto_cd: Allows you to change directories by typing the directory name without 'cd'
# auto_pushd: Automatically pushes old directory onto directory stack when changing dirs
# pushd_ignore_dups: Don't push duplicate directories onto the stack
# pushdminus: Makes 'cd -n' work like 'cd +n' for easier navigation through dir history
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

# Function 'd' is a wrapper around the 'dirs' command that shows directory stack
# If an argument is provided, passes it directly to 'dirs'
# If no argument, shows the first 10 entries of directory stack in numbered format
function d () {
  if [[ -n $1 ]]; then
    dirs "$@"
  else
    dirs -v | head -n 10
  fi
}
compdef _dirs d


# List directory contents
alias lsa='ls -lah'
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
