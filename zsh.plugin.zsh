for script in $(find $ZDOTDIR/dot/env -name '*.zsh'); do
  source $script
done
for script in $(find $ZDOTDIR/dot/utils -name '*.zsh'); do
  source $script
done
