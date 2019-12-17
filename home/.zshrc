# Load antigen.sh
source /usr/local/share/antigen/antigen.zsh

# Load bundles
antigen bundle git
antigen bundle npm
antigen bundle yarn
antigen bundle web-search
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle history-substring-search
antigen bundle z

# Apply it
antigen apply

# Import configuration
for file in $HOME/.zsh/*
do 
   source $file
done

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
