export DOTFILES=${0:A:h}
# ... then, the rest.
for script in $(find $DOTFILES/zsh/bin -name '*.zsh'); do
  source $script
done
