# pacman
# https://wiki.archlinux.org/title/pacman/Tips_and_tricks

# List all installed packages by size
function pacman-sizes-all {
    LC_ALL=C pacman -Qi | awk '/^Name/{name=$3} /^Installed Size/{print $4$5, name}' | sort -h
}

# List installed packages (not in the meta package base nor package group base-devel) by size
function pacman-list-others {
    expac -H M "%011m\t%-20n\t%10d" $(comm -23 <(pacman -Qqen | sort) <({ pacman -Qqg xorg; expac -l '\n' '%E' base; } | sort -u)) | sort -n
}

# Browse all installed packages with detailed info
alias pacman-browse="pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"

# Remove all orphans and their configuration files
alias pacman-clean="pacman -Qtdq | pacman -Rns -"
