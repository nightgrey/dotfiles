
# https://github.com/marlonrichert/zsh-snap
# https://github.com/marlonrichert/zsh-snap/blob/main/.zshrc
source "$HOME/.znap/znap/znap.zsh"

# Package manager
#znap source asdf-vm/asdf
# Auto suggestions
znap source zsh-users/zsh-autosuggestions
znap source marlonrichert/zsh-autocomplete

# Theme
#znap eval starship "starship init zsh --print-full-init"
znap eval oh-my-posh "oh-my-posh init zsh --config ~/.config/oh-my-posh/config.json"

# Title

znap source trystan2k/zsh-tab-title

# Basics
znap source mattmc3/zephyr plugins/history
znap source ohmyzsh/ohmyzsh lib/{directories,} plugins/git
#  lib/{theme-and-appearance,directories,completion,clipboard,history,key-bindings} plugins/{git,npm,web-search,colored-man-pages}

#znap source zdharma-continuum/fast-syntax-highlighting (fails)

znap source ajeetdsouza/zoxide

#znap source marlonrichert/zcolors
#znap eval   marlonrichert/zcolors "zcolors ${(q)LS_COLORS}"

znap source mattmc3/zman # zsh manual
znap source minTaqa/mvrel # Move directory with symlinks intact
#znap source supercrabtree/k
#znap eval nvbn/thefuck "thefuck --alias"


# Setup after sourcing plugins.
znap source nightgrey/dotfiles setup


# # fpath
# znap fpath _docker "curl -sSL https://raw.githubusercontent.com/docker/cli/fa84cfd8020a4c221ab97da1c11507c1c5e552fd/contrib/completion/zsh/_docker"
# # https://github.com/docker/docker.github.io-1/blob/86dfbfc52bf242cac9f39630a952345cb171ab33/compose/completion.md?plain=1#L87
#znap fpath _docker-compose "curl -sSL https://raw.githubusercontent.com/docker/compose/master/contrib/completion/zsh/_docker-compose"
znap fpath _gh "gh completion -s zsh" 
znap fpath _rg "rg --generate complete-zsh"
znap fpath _aichat "curl -sSL https://raw.githubusercontent.com/sigoden/aichat/master/scripts/completions/aichat.zsh"
# znap fpath _oh-my-posh "oh-my-posh completion zsh"
znap fpath _pip "python -m pip completion --zsh"
# znap fpath _pip "pip completion --zsh"
znap fpath _bun "source /home/nico/.bun/_bun"
znap fpath _mise "curl -sSL https://raw.githubusercontent.com/jdx/mise/refs/heads/main/completions/_mise"
znap fpath _npm "npm completion"

# Rest
znap source nightgrey/dotfiles {completions,utils,bin}

eval "$(mise activate zsh)"
