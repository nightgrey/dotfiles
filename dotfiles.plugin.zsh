export DOTFILES=${0:A:h}

# First, load the config and setup files...
for script in $(find $DOTFILES/zsh/{setup,utils,private.zsh} -name '*.zsh'); do
  source $script
done

# ... then, the rest.
for script in $(find $DOTFILES/zsh/{completions,utils} -name '*.zsh'); do
  source $script
done

# ... then, the rest.
for script in $(find $DOTFILES/zsh/bin -name '*.zsh'); do
  source $script
done
