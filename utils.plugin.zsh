export DOTFILES=${0:A:h} 
for script in $(find $DOTFILES/zsh/utils -name '*.zsh'); do
  source $script
done
