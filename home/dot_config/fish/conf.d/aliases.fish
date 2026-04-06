# code

# Technically only needed when ran from inside floating ghostty because tdrop does not support wayland yet.
# Too lazy to if-condition it properly, though.
alias code="env --unset=WAYLAND_DISPLAY code"

# eza
alias ls='eza -al --color=always --group-directories-first --icons' # preferred listing
alias la='eza -a --color=always --group-directories-first --icons' # all files and dirs
alias ll='eza -l --color=always --group-directories-first --icons' # long format
alias lt='eza -aT --color=always --group-directories-first --icons' # tree listing
alias l.="eza -a | grep -e '^\.'" # show only dotfiles+

# edit
alias edit=$EDITOR
# editor
alias ws=webstorm
alias c=code
alias vs=code

# where                 
alias where="command -v"
alias trace="fish_trace=1"

# ripgrep
alias grep=rg
alias ggrep=/usr/bin/grep
alias rgrep=rg
alias agrep=ast-grep
alias astgrep=ast-grep

# bat
alias cat=bat

# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'

# Error messages
alias jctl="journalctl -p 3 -xb"

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
