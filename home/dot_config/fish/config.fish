# Fish config
# https://fishshell.com/docs/current/index.html

# set -U fish_features regex-easyesc qmark-noglob ampersand-nobg-in-token remove-percent-self test-require-arg query-term

oh-my-posh init fish -c ~/.config/oh-my-posh/config.json | source
zoxide init fish | source

# https://mise.jdx.dev/ide-integration.html#adding-shims-to-path-default-shell
if status is-interactive
    mise activate fish | source
else
    mise activate fish --shims | source
end

# Atuin
set -gx ATUIN_NOBIND true

atuin init fish | source

atuin gen-completions --shell fish | source
bind up _atuin_bind_up

# Completions
uv generate-shell-completion fish | source
srgn --completions fish | source
chezmoi completion fish | source

# Temporary + extra completions
source ~/.config/fish/temp.fish
source ~/.config/fish/_completions/*.fish
