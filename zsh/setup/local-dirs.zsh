# Dynamically extend $PATH in git repos with local binaries
local LOCAL_BINARIES=(
  bin
  .bin
  node_modules/.bin
)

# Copied from utils
is-git() {
  vc=false
  d=$PWD

  if [ -d "$d/.git" ]; then
    vc=$d/.git
  else
    d=..

    # While $d is not /, check if it's a git repository.
    while ! [ "$d" -ef / ]; do
      if [ -d "$d/.git" ]; then
        vc=$d/.git
        break
      fi
      d=$d/..
    done
  fi

  echo $vc
}

local PREVIOUS_GIT=false

# Registers $PATH and named directories in git repositories ($LOCAL_BINARIES) with `chpwd`.
#
# Why not set relative paths?
# -> Slows down autocompletion considerably.
# -> Occasionally takes into account the wrong binary.
#
# This solution is not super good either though, as directory changing is
# impacted.
#
# See: https://zsh.sourceforge.io/Doc/Release/Functions.html#Hook-Functions
chpwd() {
  # Check if in a git repository
  local CURRENT_GIT=${$(is-git)//\/.git}

  if ([[ $CURRENT_GIT == false ]] ||
  [[ $CURRENT_GIT == / ]] ||
  [[ $CURRENT_GIT == $HOME ]] ||
  [[ $CURRENT_GIT == $PREVIOUS_GIT ]] ||
  [[ -z $PREVIOUS_GIT ]]);
  then
    # Do nothing.
  else
    # Unset PATH for local binaries
    for _path in "${LOCAL_BINARIES[@]}"; do
      _absolute_path="${PREVIOUS_GIT}/${_path}"
      export PATH="${PATH//$_absolute_path:}"
    done
    
    # Unset named directories
    hash -d root=""
    hash -d bin=""
    hash -d node_modules=""

    PREVIOUS_GIT=false
  fi

  if [[ $CURRENT_GIT != false ]]; then
    # Set current root as previous root
    PREVIOUS_GIT=$CURRENT_GIT

    # Set PATH for local binaries
    for _path in "${LOCAL_BINARIES[@]}"; do
      _absolute_path="${CURRENT_GIT}/${_path}"
      export PATH="${_absolute_path}:${PATH}"
    done
    
    # Set named directories
    hash -d root="$CURRENT_GIT"
    hash -d bin="$CURRENT_GIT/node_modules/.bin"
    hash -d node_modules="$CURRENT_GIT/node_modules"
  fi
}

# .. and execute it once to set the initial $PATH
chpwd