export DOTFILES=${0:A:h}
export DOT=$DOTFILES

for script in $DOTFILES/lib/.zsh/config/**/*.zsh; do
  source $script
done