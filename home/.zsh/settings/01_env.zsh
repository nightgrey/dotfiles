# Default tools
export BROWSER="google-chrome-stable"
export EDITOR="${EDITOR:-nano}"
export VISUAL="${VISUAL:-nano}"
export PAGER="${PAGER:-most}"

# zsh-autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=( match_prev_cmd history completion )

# Ensure path arrays do not contain duplicates.
typeset -gU path fpath cdpath mailpath

