
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


# Alias for starting to work on current project.
alias canvas="cd ~dev/own/canvas; webstorm . && bun dev"