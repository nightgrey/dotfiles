for script in $(find ${0:A:h}/zsh/{bin,completions,config,setup,utils,private.zsh} -name '*.zsh')
do
    source $script
done