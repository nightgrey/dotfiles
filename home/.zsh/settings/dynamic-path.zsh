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

CHPWD_PREVIOUS_GIT_ROOT=false
# Registers $PATH for binaries in git repositories ($LOCAL_BINARIES)
# https://zsh.sourceforge.io/Doc/Release/Functions.html#Hook-Functions
function test() {
  IS_GIT=$(is-git)

  # Check if in the previous run of this function, a git root was detected.
  IS_PREVIOUS_GIT=$([[ -n $CHPWD_PREVIOUS_GIT_ROOT ]] && echo true || echo false)

  echo "IS_PREVIOUS_GIT: $IS_PREVIOUS_GIT"
  if [[ $IS_GIT == false ]]; then
    echo "Not in a git repository"

    if [[ $IS_PREVIOUS_GIT == true ]]; then
      echo "Unsetting PATH for local binaries."
      # Unset PATH for local binaries
      for path in "${LOCAL_BINARIES[@]}"; do
        echo "Removing $path from $CHPWD_PREVIOUS_GIT_ROOT"
        echo "Before removal: PATH: $PATH"
        export PATH="${PATH//$CHPWD_PREVIOUS_GIT_ROOT/$path:/}"
        echo "After removal: PATH: $PATH"
      done

      echo "Unsetting CHPWD_PREVIOUS_GIT_ROOT"
      $CHPWD_PREVIOUS_GIT_ROOT=false
    else
      echo "No previous git root detected."
    fi


  else
    echo "In a git repository"
    # Set current root
    CHPWD_PREVIOUS_GIT_ROOT=$IS_GIT

    # Set PATH for local binaries
    for path in "${LOCAL_BINARIES[@]}"; do
      echo "Adding $path to $CHPWD_PREVIOUS_GIT_ROOT"
      export PATH="$CHPWD_PREVIOUS_GIT_ROOT/$path:${PATH}"
    done
  fi

  if [[ IS_GIT != false ]]; then

  else

  fi
}
