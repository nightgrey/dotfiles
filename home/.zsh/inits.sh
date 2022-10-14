# Initialize `thefuck`
# Details: https://github.com/nvbn/thefuck#manual-installation
eval $(thefuck --alias)

# Initialize `rbenv`
eval "$(rbenv init -)"

# Initialize `nvm`
source /usr/share/nvm/init-nvm.sh

# Automagically use the NVM version defined in `.nvmrc`
# Modified to only work if `pwd` matches `home/nico/Developer`.
# Note: Makes cd-ing slower.
# https://github.com/nvm-sh/nvm#zsh
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"

  if [[ $(pwd) = */home/nico/Developer* ]]; then
    local nvmrc_path="$(nvm_find_nvmrc)"

    if [ -n "$nvmrc_path" ]; then
      local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

      if [ "$nvmrc_node_version" = "N/A" ]; then
        nvm install
      elif [ "$nvmrc_node_version" != "$node_version" ]; then
        nvm use
      fi
    elif [ "$node_version" != "$(nvm version default)" ]; then
      echo "Reverting to nvm default version"
      nvm use default
    fi
  else
    if [ "$node_version" != "$(nvm version default)" ]; then
      echo "Reverting to nvm default version"
      nvm use default
    fi
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# Initialize `zoxide`
eval "$(zoxide init zsh)"

# Initialize `pyenv`
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Load completions
fpath=(~/.zsh/completions $fpath)
autoload -Uz compinit
compinit -u
