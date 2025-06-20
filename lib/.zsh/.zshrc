# ### **`.zshrc`**
# - **When loaded**: Interactive shells (both login and non-login)
# - **Purpose**: Interactive shell configuration
# - **Use for**: Aliases, functions, prompt, key bindings, completions, plugins
# - **Note**: This is where most of your customization goes

# zinit
# Wiki: https://zdharma-continuum.github.io/zinit/wiki/
# GitHub: https://github.com/zdharma-continuum/zinit
# Examples: https://zdharma-continuum.github.io/zinit/wiki/GALLERY/#snippets
source /usr/share/zinit/zinit.zsh
  
# Package manager
#zi load asdf-vm/asdf

# Theme
#zi ice eval'starship init zsh --print-full-init'; zi load starship/starship
#zi ice eval'oh-my-posh init zsh --config ~/.config/oh-my-posh/config.json'
# zi sh 'oh-my-posh init zsh --config ~/.config/oh-my-posh/config.json'
# zi as"program" sh"oh-my-posh init zsh"
zi ice !wait'' from"gh-r" as"command" mv"posh* -> oh-my-posh"  atclone"./oh-my-posh init zsh --config ~/.config/oh-my-posh/config.json > init.zsh; ./oh-my-posh " atpull"%atclone" src"init.zsh" lucid nocd
zi light JanDeDobbeleer/oh-my-posh


# Auto suggestions
zi load trystan2k/zsh-tab-title

# Basics
zinit light zdharma-continuum/fast-syntax-highlighting
zi light zsh-users/zsh-autosuggestions
zi light marlonrichert/zsh-autocomplete
zinit light zsh-users/zsh-completions
zi snippet OMZL::directories.zsh # oh-my-zsh/lib/directories
zi snippet OMZP::git # oh-my-zsh/plugins/git

#zi load marlonrichert/zcolors
#zi ice eval'zcolors ${(q)LS_COLORS}'; zi load marlonrichert/zcolors
#zi load zdharma-continuum/fast-syntax-highlighting

# Aliases for tooling
zi load ajeetdsouza/zoxide
zi load zap-zsh/exa

# Tools

zinit ice as"command" from"gh-r" mv"bat* -> bat" pick"bat/bat" atload"alias cat=bat"
zinit light sharkdp/bat

zinit ice as"command" from"gh-r" pick"rg" atload"alias grep=rg"
zinit light BurntSushi/ripgrep

# https://zdharma-continuum.github.io/zinit/wiki/GALLERY/#snippets
zinit ice from"gh-r" as"program" mv"shfmt* -> shfmt"
zinit light mvdan/sh

zinit ice as"program" pick"yank" make
zinit light mptre/yank

zi load mattmc3/zman
zi load minTaqa/mvrel

# Completions

# zi ice as"completion" has"rg"
# zi snippet <(rg --generate complete-zsh)

zi ice id-as="mise" as"completion" atclone"mise completion zsh > _mise; mise activate zsh > init.zsh" atpull"%atclone" src"init.zsh"
zi load mise

# Load dotfiles
zi ice id-as="dotfiles" src"dotfiles.plugin.zsh" nocd
zi load /home/nico/.dot
