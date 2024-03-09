#### SETTINGS ####
for file in $(find $HOME/.zsh/settings -name '*.zsh')
do
  source $file
done
#### SETTINGS ####

#### PRIVATE ####
source $HOME/.zsh/private.zsh
#### PRIVATE ####

#### COMPLETIONS ####
source "$HOME/.zsh/completions/activate.zsh"
#### UTILS/ALIASES ####

#### ZNAP ####

# https://github.com/marlonrichert/zsh-snap
# https://github.com/marlonrichert/zsh-snap/blob/main/.zshrc
source "$HOME/.znap/znap/znap.zsh"

# Theme
znap eval starship "starship init zsh --print-full-init"
znap prompt

# Autocompletions & syntax highlighting
znap source marlonrichert/zsh-autocomplete
znap source zdharma-continuum/fast-syntax-highlighting
znap source lukechilds/zsh-better-npm-completion
znap source zsh-users/zsh-autosuggestions

# Completions
znap source ohmyzsh/ohmyzsh lib/theme-and-appearance
znap source ohmyzsh/ohmyzsh \
     lib/{directories,clipboard,history,key-bindings} plugins/{git,npm,web-search,colored-man-pages,docker,docker-compose}
znap source supercrabtree/k
znap source DarrinTisdale/zsh-aliases-exa

# Prettify
znap source marlonrichert/zcolors
znap eval   marlonrichert/zcolors "zcolors ${(q)LS_COLORS}"

# Tools
znap source asdf-vm/asdf
znap source ajeetdsouza/zoxide
znap eval ajeetdsouza/zoxide "zoxide init zsh"

znap source nvbn/thefuck
znap eval nvbn/thefuck "thefuck --alias"

znap source peterhurford/up.zsh
znap source mattmc3/zman

# Misc
znap source mattmc3/zephyr \
     plugins/{utility,history}

#### ZNAP ####

#### UTILS/ALIASES ####
for file in $(find $HOME/.zsh/aliases -name '*.*sh')
do
source $file
done
#### UTILS/ALIASES ####

