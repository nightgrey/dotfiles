# https://github.com/marlonrichert/zsh-snap
# https://github.com/marlonrichert/zsh-snap/blob/main/.zshrc
source "$HOME/.znap/znap/znap.zsh"

# My own dotfiles

# Theme
znap eval starship "starship init zsh --print-full-init"
znap prompt

# Autocompletions & syntax highlighting
znap source zsh-users/zsh-autosuggestions
znap source marlonrichert/zsh-autocomplete
znap source zdharma-continuum/fast-syntax-highlighting
znap source lukechilds/zsh-better-npm-completion

# Completions
znap source ohmyzsh/ohmyzsh lib/theme-and-appearance
znap source ohmyzsh/ohmyzsh \
  lib/{directories,clipboard,history,key-bindings} plugins/{git,npm,web-search,colored-man-pages}
znap source supercrabtree/k
znap source DarrinTisdale/zsh-aliases-exa

# Prettify
znap source marlonrichert/zcolors
znap eval   marlonrichert/zcolors "zcolors ${(q)LS_COLORS}"

# Tools
znap source ajeetdsouza/zoxide
znap eval ajeetdsouza/zoxide "zoxide init zsh"

znap eval nvbn/thefuck "thefuck --alias"

znap source peterhurford/up.zsh
znap source mattmc3/zman

znap source mattmc3/zephyr \
  plugins/{utility,history}

# mvrel
# Move directory with symlinks intact
znap source minTaqa/mvrel

# Title
ZSH_TAB_TITLE_DEFAULT_DISABLE_PREFIX=true
ZSH_TAB_TITLE_ENABLE_FULL_COMMAND=true
znap source trystan2k/zsh-tab-title

# asdf
# Tool management (npm, python, ruby, and more)
znap source asdf-vm/asdf
znap fpath _asdf  "cat $ASDF_DIR/completions/_asdf"

# fpath
znap fpath _pip "pip completion --zsh"
znap fpath _docker "curl -sSL https://raw.githubusercontent.com/docker/cli/fa84cfd8020a4c221ab97da1c11507c1c5e552fd/contrib/completion/zsh/_docker"
# https://github.com/docker/docker.github.io-1/blob/86dfbfc52bf242cac9f39630a952345cb171ab33/compose/completion.md?plain=1#L87
znap fpath _docker-compose "curl -sSL https://raw.githubusercontent.com/docker/compose/master/contrib/completion/zsh/_docker-compose"
znap fpath _ruff "ruff generate-shell-completion zsh"
znap fpath _starship "starship completions zsh"
znap fpath _gh "gh completion -s zsh" 
znap fpath _rg "rg --generate complete-zsh"
znap fpath _sgpt "sgpt completion zsh"

# My own stuff.
znap source nightgrey/dotfiles
