# pacman
# https://wiki.archlinux.org/title/pacman/Tips_and_tricks

# List all installed packages by size
function pacman-list-sizes {
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

# Update AUR packages.
alias upgrade-aur="yay -Syua"

# Update the system.
alias upgrade="sudo pacman -Su"

# Mount HDD
alias mount-hdd="sudo mount -t ntfs3 -o defaults,nofail,noatime,prealloc,uid=1000,gid=1000 /dev/sda1 /mnt/hdd"
# Remove dirty flag on my HDD.
alias fix-hdd="sudo ntfsfix -d /dev/sda1"
