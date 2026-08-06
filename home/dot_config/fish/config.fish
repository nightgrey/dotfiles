# Fish config
# https://fishshell.com/docs/current/index.html

# ------------------------------------------------------------------------------
# CORE
# ------------------------------------------------------------------------------

set -g fish_greeting
#set -U fish_features regex-easyesc query-term
# qmark-noglob ampersand-nobg-in-token remove-percent-self test-require-arg

# -------------------- -----------------------------------------------------------
# ENVIRONMENT
# -------------------------------------------------------------------------------
set -gx BROWSER firefox
set -gx EDITOR (command -v micro || command -v nano)
set -gx VISUAL (command -v micro || command -v nano)
set -gx PAGER (command -v bat || command -v less)
set -gx TERMINAL ghostty
if test "$PAGER" = (command -v bat)
    set -gx PAGER "bat --style=numbers,changes --paging=always"
    set -gx LESSOPEN "| bat --color=always --style=plain %s"
    set -gx LESS -R # Allow colors in less
end

set -gx LAUNCH_EDITOR (test -n "$LAUNCH_EDITOR" && echo $LAUNCH_EDITOR || echo $EDITOR)
set -gx QT_QPA_PLATFORM "wayland;xcb"

# .local/bin
fish_add_path -g $HOME/.local/bin

# Bun
set -gx BUN_INSTALL $HOME/.bun
fish_add_path -g $BUN_INSTALL/bin

# Check package updates
# alias ncu="bunx npm-check-updates"
alias ncu="bunx npm-check"

# Go
set -gx GOPATH $HOME/.go
set -gx GOBIN $GOPATH/bin
fish_add_path -g $GOBIN

# Python
fish_add_path -g ./.venv/bin

# ------------------------------------------------------------------------------
# SOURCES
# ------------------------------------------------------------------------------
source ~/.config/fish/temp.fish

# Note: Completions and functions have to have only one completion/function per file.
# The "more" folders contain multiple related ones per file.
source ~/.config/fish/more-completions/*.fish
source ~/.config/fish/more-functions/*.fish

# ------------------------------------------------------------------------------
# INITS
# ------------------------------------------------------------------------------
oh-my-posh init fish -c ~/.config/oh-my-posh/config.json | source
zoxide init fish | source

# Mise
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

# ------------------------------------------------------------------------------
# ALIASES
# ------------------------------------------------------------------------------
# ls
alias ls='eza -al --color=always --group-directories-first --icons' # preferred listing
alias la='eza -a --color=always --group-directories-first --icons' # all files and dirs
alias ll='eza -l --color=always --group-directories-first --icons' # long format
alias lt='eza -aT --color=always --group-directories-first --icons' # tree listing
alias l.="eza -a | grep -e '^\.'" # show only dotfiles+

# grep
alias grep=rg
alias ggrep=/usr/bin/grep
alias rgrep=rg
alias agrep=ast-grep
alias astgrep=ast-grep

# cat
alias cat=bat

# edit
alias edit=$EDITOR

# where                 
alias where="command -v"
alias trace="fish_trace=1"

# chezmoi
alias cz='chezmoi'
alias cza='chezmoi apply --exclude templates'
alias czd='chezmoi diff'

# oh-my-posh
alias omp='oh-my-posh'

# `updates` takes no additional arguments
# ------------------------------------------------------------------------------
# DIRS
# ------------------------------------------------------------------------------
abbr --add --position anywhere "~dev" ~/Developer
abbr --add --position anywhere "~dot" ~/.dot
abbr --add --position anywhere "~fish" ~/.fish
abbr --add --position anywhere "~fishsrc" /usr/share/fish
abbr --add --position anywhere "~canvas" ~/Developer/canvas
abbr --add --position anywhere "~thing" ~/Developer/thing

# ------------------------------------------------------------------------------
# COMPLETIONS
# ------------------------------------------------------------------------------
wt config shell init fish | source
uv generate-shell-completion fish | source
srgn --completions fish | source
chezmoi completion fish | source
grove switch shell-init | source
piri completion fish | source
niri completions fish | source
crush completion fish | source

# ------------------------------------------------------------------------------
# KEYBINDINGS
# ------------------------------------------------------------------------------
bind end end-of-buffer
bind home beginning-of-buffer

bind left backward-char
bind right forward-char

bind alt-shift-left beginning-of-line
bind alt-shift-right end-of-line

bind f2 __toggle_npm_bun
