oh-my-posh init fish -c ~/.config/oh-my-posh/config.json | source

zoxide init fish | source
mise activate fish | source
chezmoi completion fish | source
atuin init fish | source
atuin gen-completions --shell fish | source
uv generate-shell-completion fish | source

source ~/.config/fish/temp.fish
