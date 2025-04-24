
local setup-editor() {
  # Read desired editor from ~/.editor file
  [[ -f ~/.editor ]] && export EDITOR=$(cat ~/.editor)

  if [[ $EDITOR == "webstorm-eap" ]]; then
    alias "webstorm"="webstorm-eap"
  fi  
}

setup-editor

# Open given file or path in the chosen editor.
editor() {
  $EDITOR ${1:-$PWD}
}

# Set the $EDITOR variable to ~/.editor & env variables. Used by certain scripts.
set-editor() {
  local arg=$1

  case $arg in
    code|c|vs)
      echo "code" > ~/.editor
      export EDITOR="code"
      export LAUNCH_EDITOR="code"
      echo "$EDITOR set to 'code'"
      ;;
    webstorm|w|ws)
      echo "webstorm" > ~/.editor
      export EDITOR="webstorm"
      export LAUNCH_EDITOR="webstorm"
      echo "$EDITOR set to 'webstorm'"
      
      ;;
    webstorm-eap|eap|wse|wseap|wsea)
      echo "webstorm-eap" > ~/.editor
      export EDITOR="webstorm-eap"
      export LAUNCH_EDITOR="webstorm-eap"
      echo "$EDITOR set to 'webstorm-eap'"
      ;;
    *)
      echo $1 > ~/.editor
      export EDITOR=$1
      export LAUNCH_EDITOR=$1
      echo "$EDITOR set to '$1'"
      ;;
  esac
  
  setup-editor
}

# Completion function
_set-editor() {
  local -a editors
  editors=(
    'code:VS Code'
    'c:VS Code (alias)' 
    'vs:VS Code (alias)'
    'vsc:VS Code (alias)'
    'webstorm:WebStorm'
    'w:WebStorm (alias)'
    'ws:WebStorm (alias)'
    'webstorm-eap:WebStorm EAP'
    'wseap:WebStorm EAP (alias)'
  )

  _describe 'set-editor' editors
}

# Initialize completion
compdef _set-editor set-editor