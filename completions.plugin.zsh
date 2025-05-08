export DOTFILES=${0:A:h}
for script in $(find $DOTFILES/zsh/completions -name '*.zsh'); do
  source $script
done
