function __toggle_npm_bun --description 'Toggle npm/npx to bun/bunx in the current commandline'
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
