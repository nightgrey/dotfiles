# Set the $EDITOR variable to ~/.editor & env variables. Used by certain scripts.
editor() {
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
    *)
      echo "Usage: editor [code|webstorm]"
      ;;
  esac
}

# Completion function
_editor() {
  local -a editors
  editors=(
    'code:VS Code'
    'c:VS Code (alias)' 
    'vs:VS Code (alias)'
    'vsc:VS Code (alias)'
    'webstorm:WebStorm'
    'w:WebStorm (alias)'
    'ws:WebStorm (alias)'
  )

  _describe 'editor' editors
}

# Initialize completion
compdef _editor editor