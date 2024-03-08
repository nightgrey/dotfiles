# Dynamically extend $PATH in git repos with local binaries
LOCAL_BINARIES=(
  bin
  .bin
  node_modules/.bin
)

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

# Check performance of given command
# Returns execution time in milliseconds.
perf() {
  start_time=$(date +%s.%N)
  eval "$@" >/dev/null
  end_time=$(date +%s.%N)
  execution_time=$(echo "$end_time - $start_time" | bc)
  execution_time_ms=$(echo "$execution_time * 1000" | bc)
  echo "$execution_time_ms ms"
}

PREVIOUS_GIT=false
# Registers $PATH for binaries in git repositories ($LOCAL_BINARIES)
# https://zsh.sourceforge.io/Doc/Release/Functions.html#Hook-Functions
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