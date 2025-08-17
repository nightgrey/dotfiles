if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
  alias copy="wl-copy"
  alias paste="wl-paste"
else
  alias copy="xclip -selection clipboard -in"
  alias paste="xclip -selection clipboard -out"
fi

function path() {
  echo -n $(realpath -s "${1:-$PWD}") | xclip -selection clipboard
}
