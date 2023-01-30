# Fig pre block. Keep at the top of this file.
# @TODO: Keep?
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"

#### BEFORE ####
for file in $(find $HOME/.zsh/before -name '*.zsh')
do
  source $file
done
#### BEFORE ####


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
znap source ajeetdsouza/zoxide
znap eval ajeetdsouza/zoxide "zoxide init zsh"

znap source nvbn/thefuck
znap eval nvbn/thefuck "thefuck --alias"

#### ZNAP ####

#### MAIN ####
for file in $(find $HOME/.zsh/main -name '*.zsh')
do
  source $file
done
#### MAIN ####

# Fig post block. Keep at the bottom of this file.
# @TODO: Keep?
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
