

# Returns relative path to the root of the git repository (or false) by checking the
# current directory and its parents.
#
# Note: Faster than `git rev-parse --show-toplevel` or `git rev-parse
# --is-inside-work-tree` or `git branch` by roughly ~50%.
is-git() {
  vc=false
  d=$PWD

  if [ -d "$d/.git" ]; then
    vc=$d/.git
  else
    d=$d/..

    # While $d is not /, check if it's a git repository.
    while ! [ "$d" -ef / ]; do
      if [ -d "$d/.git" ]; then
        vc=$d/.git
        break
      fi
      d=$d/..
    done
  fi

  echo $(realpath $vc)
}

local PREV_GIT=false
# Dynamically extend $PATH in git repos with local binaries
local LOCAL_BINARIES=(
  bin
  .bin
  node_modules/.bin
  .venv/bin
)
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
chpwd_local_dirs() {
  # Check if in a git repository
  local NEXT_GIT=${$(is-git)//\/.git}

  if ([[ $NEXT_GIT == false ]] ||
  [[ $NEXT_GIT == / ]] ||
  [[ $NEXT_GIT == $HOME ]] ||
  [[ $NEXT_GIT == $PREV_GIT ]] ||
  [[ -z $PREV_GIT ]]);
  then
    # Do nothing.
  else
    # Unset PATH for local binaries
    for _path in "${LOCAL_BINARIES[@]}"; do
      _absolute_path="${PREV_GIT}/${_path}"
      export PATH="${PATH//$_absolute_path:}"
    done
    
    # Unset named directories
    hash -d root=""
    hash -d bin=""
    hash -d node_modules=""

    PREV_GIT=false
  fi

  if [[ $NEXT_GIT != false ]]; then
    # Set current root as previous root
    PREV_GIT=$NEXT_GIT

    # Set PATH for local binaries
    for _path in "${LOCAL_BINARIES[@]}"; do
      _absolute_path="${NEXT_GIT}/${_path}"
      export PATH="${_absolute_path}:${PATH}"
    done
    
    # Set named directories
    hash -d root="$NEXT_GIT"
    hash -d bin="$NEXT_GIT/node_modules/.bin"
    hash -d node_modules="$NEXT_GIT/node_modules"
  fi
}

# Add the function to the chpwd_functions array
autoload -U add-zsh-hook
add-zsh-hook chpwd chpwd_local_dirs

# execute once
chpwd_local_dirs