# Search
alias "?file"="find ./ -type f -name"
alias "?dir"="find ./ -type d -name"

# Size
alias size="du -Lsm --human-readable"

# QT_LOGGING_RULES="*=false" disables annoying logging for `xdg-open`..... almost. AAAAHHHHH!!!
# https://community.kde.org/Guidelines_and_HOWTOs/Debugging/Using_Error_Messages
function open() {
  QT_LOGGING_RULES="*=false" xdg-open "$@" &>/dev/null
}
alias here="open ."

# Runs anything after `perf` and prints execution time in milliseconds.
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

# Shows key codes for the pressed keys.
alias keycodes="sed -n l"

# Display all colors
print-colors() {
      print -l $funcsourcetrace
    print -l $funcstack
  for color in {0..255}; do
    print -Pn "%K{$color}    %k %F{white}${(l:3::0:)color}%F ";

    if [[ $((color % 8)) -eq 7 ]]; then
      echo "\n"
    fi
  done
}

alias neofetch="fastfetch"

alias wslog="cd /home/nico/.cache/JetBrains/WebStorm2024.3/log/"
alias wscache="rm -rf /home/nico/.cache/JetBrains/WebStorm2024.3"


# Show used ports
alias ports="netstat -tulnp"

# Show traffic per process
alias itop="nethogs"
alias iftop=itop

# Show docker's total RAM usage
function docker-ram {
  docker stats --no-stream --format 'table {{.MemUsage}}' | sed 's/[A-Za-z]*//g' | awk '{sum += $1} END {print sum "MB"}'
}
