# Use `< file` to quickly view the contents of any file.
[[ -z "$READNULLCMD" ]] || READNULLCMD=$PAGER

# Open dolphin with `here` or `open`, similar to MacOS.
function here {
  dolphin "$1" >/dev/null 2>&1 &
  disown
}

alias open=here

# Search
alias "?file"="find ./ -type f -name"
alias "?dir"="find ./ -type d -name"

# Size
alias size="du -Lsm --human-readable"

# Show used ports
alias ports="netstat -tulnp"

# Show traffic per process
alias itop="nethogs"
alias iftop=itop

# Show docker's total RAM usage
function docker-ram {
  docker stats --no-stream --format 'table {{.MemUsage}}' | sed 's/[A-Za-z]*//g' | awk '{sum += $1} END {print sum "MB"}'
}

# Reload the shell (i.e. invoke as a login shell)
function reload {
  exec $SHELL -l
}

# Shows key codes for the pressed keys.
alias keycodes="sed -n l"

# Show all colors
color-map() {
    for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
}

# Kill processes with given search term
function killit() {
  search="$1"
  processes=$(ps ux | grep "${search}" | grep -v 'grep')

  if [ -n "${processes}" ]; then
    kill $(echo "${processes}" | awk '{print $2}')
    echo -e "Killed all processes matching \"${search}\""
  else
    echo -e "No processes found matching \"${search}\""
  fi
}

# # Check performance of given command
# # Returns execution time in milliseconds.
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