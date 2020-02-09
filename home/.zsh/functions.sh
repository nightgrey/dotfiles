# Substitute `open_command` which normally comes from oh-my-zsh.
# Some oh-my-zsh plugins need this to work, e.g. `web-search`, so we define it here.
function open_command() {
  local open_cmd

  # define the open command
  case "$OSTYPE" in
    darwin*)  open_cmd='open' ;;
    cygwin*)  open_cmd='cygstart' ;;
    linux*)   [[ "$(uname -r)" != *icrosoft* ]] && open_cmd='nohup xdg-open' || {
                open_cmd='cmd.exe /c start ""'
                [[ -e "$1" ]] && { 1="$(wslpath -w "${1:a}")" || return 1 }
              } ;;
    msys*)    open_cmd='start ""' ;;
    *)        echo "Platform $OSTYPE not supported"
              return 1
              ;;
  esac

  ${=open_cmd} "$@" &>/dev/null
}
 
# Install peer dependencies of the given packagename, e.g. `npp package-name`
function npp() {
  if [ -z "$1" ]
    then
      echo "First argument must be the package name you want to install the peer dependencies of."
    else
      echo "Installing peer dependencies of $1 ..."
      npm info "$1@latest" peerDependencies --json | command sed 's/[\{\},]//g ; s/: /@/g' | xargs npm install --save-dev "$1@latest"
  fi
}

alias install