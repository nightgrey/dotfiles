# Load antigen
source /usr/share/zsh/share/antigen.zsh

# Load library
antigen use oh-my-zsh

# Load bundles
antigen bundle git
antigen bundle docker
antigen bundle docker-compose
antigen bundle node
antigen bundle npm
antigen bundle lukechilds/zsh-better-npm-completion
antigen bundle web-search
antigen bundle zsh_reload

# Shell related
antigen bundle z
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle DarrinTisdale/zsh-aliases-exa
antigen bundle history-substring-search
antigen bundle zsh-autocomplete
antigen bundle command-not-found

# Theme
antigen theme romkatv/powerlevel10k

# Apply!
antigen apply

# Import configuration
for file in $HOME/.zsh/*
do
   source $file
done

# powerlevel10k configuration
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /usr/share/nvm/init-nvm.sh
