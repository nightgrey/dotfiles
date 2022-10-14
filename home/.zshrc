# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# language configuration
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Load zplug
source /usr/share/zsh/scripts/zplug/init.zsh

# zplug "b4b4r07/enhancd", use:init.sh

zplug "plugins/git", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/docker-compose", from:oh-my-zsh
zplug "plugins/node", from:oh-my-zsh
zplug "plugins/npm", from:oh-my-zsh
zplug "plugins/web-search", from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh

# zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "marlonrichert/zsh-autocomplete"

zplug "DarrinTisdale/zsh-aliases-exa"
zplug "zsh-users/zsh-history-substring-search"
zplug "lukechilds/zsh-better-npm-completion", defer:2
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "romkatv/powerlevel10k", as:theme, depth:1

# Let zplug manage itself.
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

# Import configuration
for file in $HOME/.zsh/*
do
   source $file
done

# powerlevel10k configuration
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
