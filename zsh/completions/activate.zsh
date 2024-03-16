# Extend fpath with local completions
fpath=( ${0:A:h} "${fpath[@]}" ) 