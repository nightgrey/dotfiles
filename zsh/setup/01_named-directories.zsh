# Named directories
# Can be accessed by `~name`, for example `cd ~dev`.
# https://askubuntu.com/a/1042076
hash -d dev=~/Developer
hash -d dot=$DOTFILES
hash -d dotfiles=$DOTFILES
hash -d ai=~/hdd/Data/AI
hash -d hdd=~/hdd
hash -d models=~/AI/Models

# Everytime we change directory, update the named directories
# `git root` is defined in ~/.gitconfig
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