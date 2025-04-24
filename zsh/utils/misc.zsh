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

# Show used ports
alias ports="netstat -tulnp"

# Show traffic per process
alias itop="nethogs"
alias iftop=itop

# Show docker's total RAM usage
function docker-ram {
  docker stats --no-stream --format 'table {{.MemUsage}}' | sed 's/[A-Za-z]*//g' | awk '{sum += $1} END {print sum "MB"}'
}

# Kills process by name
stirb() {
  if [ -z "$1" ]; then
    echo "Usage: stirb PROCESS_NAME"
    return 1
  fi
  
  echo "Sending SIGTERM to $1..."
  pkill "$1"
  
  # Wait up to 3 seconds for process to terminate
  for i in {1..3}; do
    if ! pgrep "$1" >/dev/null; then
      echo "Process terminated gracefully."
      return 0
    fi
    sleep 1
  done
  
  echo "Forcefully terminating $1..."
  pkill -9 "$1"
}

alias wslog="tail -f /home/nico/.cache/JetBrains/WebStorm2025.1/log/idea.log"
alias wscache="rm -rf /home/nico/.cache/JetBrains/WebStorm2025.1"

# Get network stats.
alias "ifstats"="vnstat"
alias "wlanstats"="vnstat -i wlan0"