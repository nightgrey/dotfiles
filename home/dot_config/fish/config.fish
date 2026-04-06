set -U fish_features regex-easyesc qmark-noglob ampersand-nobg-in-token remove-percent-self test-require-arg query-term

oh-my-posh init fish -c ~/.config/oh-my-posh/config.json | source

zoxide init fish | source
mise activate fish | source
chezmoi completion fish | source

set -gx ATUIN_NOBIND true
atuin init fish | source
atuin gen-completions --shell fish | source
bind up _atuin_search
uv generate-shell-completion fish | source
srgn --completions fish | source

source ~/.config/fish/temp.fish
source ~/.config/fish/_completions/*.fish
