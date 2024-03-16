# Dynamically extend $PATH in git repos with local binaries
LOCAL_BINARIES=(
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

PREVIOUS_GIT=false
# Registers $PATH for binaries in git repositories ($LOCAL_BINARIES) with `chpwd`.
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
  CURRENT_GIT=${$(is-git)//\/.git}

  if [[ $CURRENT_GIT == false ]]; then
    if [[ -z $PREVIOUS_GIT ]]; then
      # Do nothing.
    else
      # Unset PATH for local binaries
      for _path in "${LOCAL_BINARIES[@]}"; do
        _absolute_path="${PREVIOUS_GIT}/${_path}"
        export PATH="${PATH//$_absolute_path:}"
      done

      PREVIOUS_GIT=false
    fi
  else
    # Set current root as previous root
    PREVIOUS_GIT=$CURRENT_GIT

    # Set PATH for local binaries
    for _path in "${LOCAL_BINARIES[@]}"; do
      _absolute_path="${CURRENT_GIT}/${_path}"
      export PATH="${_absolute_path}:${PATH}"
    done
  fi
}

# .. and execute it once to set the initial $PATH
chpwd