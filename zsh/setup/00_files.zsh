# Enable `< file` to quickly view the contents of any file.
[[ -z "$READNULLCMD" ]] || READNULLCMD=$PAGER

# Ensure path arrays do not contain duplicates.
typeset -gU path fpath cdpath mailpath


# Automatically clone git repositories.
alias -s git="git clone"

# Open these files with cat.
alias -s {js,json,env,md,html,css,toml}=cat