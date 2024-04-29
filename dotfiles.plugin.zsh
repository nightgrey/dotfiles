# First, load the config and setup files...
for script in $(find ${0:A:h}/zsh/{config,setup,utils,private.zsh} -name '*.zsh')
do
    source $script
done

# ... then, the rest.
for script in $(find ${0:A:h}/zsh/{completions,utils} -name '*.zsh')
do
    source $script
done

# ... then, the rest.
for script in $(find ${0:A:h}/zsh/bin -name '*.zsh')
do
    source $script
done