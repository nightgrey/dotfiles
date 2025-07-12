set -gx BUN_INSTALL $HOME/.bun
fish_add_path -g $BUN_INSTALL/bin

# This is a prefix'ed NPM. Currently only used by `claude` (Claude Code)
fish_add_path -g /home/nico/.npm/prefix/bin

# https://github.com/raineorshine/npm-check-updates
# Check package updates with `npm-check-updates`
alias ncu="bunx npm-check-updates"
alias bun="bun --prefer-offline"

# https://github.com/dylang/npm-check
# Check package updates with `npm-check`
alias nc="bunx npm-check"

function _toggle_npm_bun --description 'Toggle npm/npx to bun/bunx in the current commandline'
    set -l cmd (commandline)
    set cmd (string replace -a 'bunx' '__BUNX_TEMP__' $cmd)
    set cmd (string replace -a 'npx' '__NPX_TEMP__' $cmd)
    set cmd (string replace -a 'bun' '__BUN_TEMP__' $cmd)
    set cmd (string replace -a 'npm' '__NPM_TEMP__' $cmd)
    set cmd (string replace -a '__BUN_TEMP__' 'npm' $cmd)
    set cmd (string replace -a '__NPM_TEMP__' 'bun' $cmd)
    set cmd (string replace -a '__BUNX_TEMP__' 'npx' $cmd)
    set cmd (string replace -a '__NPX_TEMP__' 'bunx' $cmd)
    commandline --replace $cmd
end

bind f2 _toggle_npm_bun

