for script in $(find ${0:A:h}/zsh/{bin,completions,config,setup,utils} -name '*.zsh')
do
    source $script
done