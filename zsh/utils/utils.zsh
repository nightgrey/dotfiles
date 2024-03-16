# Reload the shell (i.e. invoke as a login shell)
function reload {
  exec $SHELL -l
}

# Shows key codes for the pressed keys.
alias keycodes="sed -n l"

# Show a map of all colors
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
