export DOTFILES=${0:A:h}
export DOT=$DOTFILES

# Move to $DOTFILES/plugin or sth like that?
for script in $DOTFILES/home/dot_zsh/{env,utils}/**/*.zsh; do
  source $script
done