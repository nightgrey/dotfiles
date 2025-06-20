# Returns relative path to the root of the git repository (or false) by checking the
# current directory and its parents.
#
# Note: Faster than `git rev-parse --show-toplevel` or `git rev-parse
# --is-inside-work-tree` or `git branch` by roughly ~50%.
is-git() {
  d=${1:-$PWD}
  depth=${2:-8}
  current_depth=0
  result=false

  if [ -d "$d/.git" ]; then
    result=$d
    echo "$d"
    return 0
  else
    d=$(dirname "$d")

    while ! [ "$d" -ef / ] && ! [ "$d" -ef "$HOME" ] && [ $current_depth -lt $depth ]; do
      if [ -d "$d/.git" ]; then
        result=$d
        echo "$d"
        return 0
      fi

      d=$(dirname "$d")
      ((current_depth++))
    done
  fi

  return 1
}

PREV_IS_GIT=false
# Dynamically extend $PATH in git repos with local binaries
typeset -g LOCAL_BINARIES=(
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
local_bin() {
  if (
    [[ $PWD == / ]] ||
    [[ $PWD == $HOME ]] ||
    [[ $PWD == $PREV_IS_GIT ]]
  ) then
    return
  fi

  # Check if in a git repository, IS_GIT is either false or the path to the root of the git repository
  local IS_GIT=$(is-git)

  if ([[ -z $IS_GIT ]]); then
      # Unset for previous git repository
    for current in "${LOCAL_BINARIES[@]}"; do
      local LOCAL_DIR_PATH="${PREV_IS_GIT}/${current}"

      # if LOCAL_DIR_PATH is in PATH, remove it
      if [[ $PATH == *$LOCAL_DIR_PATH* ]]; then
        PATH=${PATH//:$LOCAL_DIR_PATH:/:}
        PATH=${PATH/#$LOCAL_DIR_PATH:/}
        PATH=${PATH/%:$LOCAL_DIR_PATH/}

      fi
    done
    
    # Unset named directories
    hash -d root=""
    hash -d bin=""
    hash -d node_modules=""

    PREV_IS_GIT=false
    return
  else
    # Set current root as previous root
    PREV_IS_GIT=$IS_GIT

    # Set PATH for current git repository
    for current in "${LOCAL_BINARIES[@]}"; do
      local LOCAL_DIR_PATH="${IS_GIT}/${current}"

      # IF LOCAL_DIR_PATH is not in PATH, add it
      if [[ $PATH != *$LOCAL_DIR_PATH* ]]; then
        PATH=${PATH//:/:$LOCAL_DIR_PATH:}
      fi

    done
    
    # Set named directories
    hash -d root="$IS_GIT"
    hash -d bin="$IS_GIT/node_modules/.bin"
    hash -d node_modules="$IS_GIT/node_modules"
  fi
}

# Add the function to the chpwd_functions array
autoload -U add-zsh-hook
add-zsh-hook chpwd local_bin

# execute once
local_bin