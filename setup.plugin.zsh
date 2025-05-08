export DOTFILES=${0:A:h}
for script in $(find $DOTFILES/zsh/{setup,private.zsh} -name '*.zsh'); do
  source $script
done