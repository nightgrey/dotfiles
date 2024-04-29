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
