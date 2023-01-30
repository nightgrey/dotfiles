# Named directories
# https://askubuntu.com/a/1042076
hash -d dev=~/Developer
hash -d Dev=~/Developer
hash -d dot=~/Developer/own/dotfiles
hash -d dotfiles=~/Developer/own/dotfiles

# Everytime we change directory, update the named directories
# `git root` is defined in
# https://stackoverflow.com/a/45444758
autoload -U add-relative-named-directories
add-relative-named-directories -Uz chpwd () {
    if [[ $(git root 2> /dev/null) ]]; then
        hash -d root="$(git root)"
        hash -d bin="$(git root)/node_modules/.bin"
        hash -d node_modules="$(git root)/node_modules"
    else
        hash -d root="."
        hash -d bin="./node_modules/.bin"
        hash -d node_modules="./node_modules"
    fi
}