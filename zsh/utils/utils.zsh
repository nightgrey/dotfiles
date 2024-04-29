

# Shows key codes for the pressed keys.
alias keycodes="sed -n l"

# Display all colors
# @TODO: It's executed on startup. Why?!
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

alias neofetch="fastfetch"