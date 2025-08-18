# eza
alias ls='eza -al --color=always --group-directories-first --icons' # preferred listing
alias la='eza -a --color=always --group-directories-first --icons' # all files and dirs
alias ll='eza -l --color=always --group-directories-first --icons' # long format
alias lt='eza -aT --color=always --group-directories-first --icons' # tree listing
alias l.="eza -a | grep -e '^\.'" # show only dotfiles

# editor
alias ws=webstorm
alias c=code
alias vs=code

# ripgrep
alias grep=rg

# bat
alias cat=bat

function history
    if test (count $argv) -gt 0
        builtin history $argv
    else
        builtin history --show-time='%F %T '
    end
end

function backup --argument path --description "Backup a file or directory"
    if test -d $path
        cp -r $path $path.bak
    else
        cp $path $path.bak
    end
end

# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'

# Error messages
alias jctl="journalctl -p 3 -xb"

# Recent installed packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

function pairdrop -d "Open pairdrop"
    open https://pairdrop.net/
end
