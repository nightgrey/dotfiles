# Load antigen.sh
source /usr/local/share/antigen/antigen.zsh

# Load bundles
antigen bundle git
antigen bundle docker
antigen bundle docker-compose
antigen bundle docker-machine
antigen bundle yarn
antigen bundle web-search
antigen bundle brew
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle history-substring-search
antigen bundle z
antigen bundle DarrinTisdale/zsh-aliases-exa
antigen bundle zsh-users/zsh-completions

# Theme
POWERLEVEL9K_INSTALLATION_PATH=$ANTIGEN_BUNDLES/bhilburn/powerlevel9k
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status vcs ram nvm)
POWERLEVEL9K_PROMPT_ON_NEWLINE=true

antigen theme bhilburn/powerlevel9k powerlevel9k

# Apply it
antigen apply

# Import configuration
for file in $HOME/.zsh/*
do
   source $file
done