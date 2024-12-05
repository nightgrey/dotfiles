alias omp="oh-my-posh"

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

# Kill processes with given search term
alias killit="pkill"

alias neofetch="fastfetch"
