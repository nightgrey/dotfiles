# https://github.com/raineorshine/npm-check-updates
# Check package updates with `npm-check-updates`
alias ncu="bunx npm-check-updates"
alias -g "bun"="bun --prefer-offline"
alias "bun"="bun --prefer-offline"

# https://github.com/dylang/npm-check
# Check package updates with `npm-check`
alias nc="bunx npm-check"

# https://www.npmjs.com/package/madge
alias list-deps="bunx madge"
alias list-circular="bunx madge --circular"
alias list-unused="bunx madge --orphans"

# ESLint config inspector
alias "inspect-eslint"="bunx @eslint/config-inspector"
alias "eslint-inspect"="inspect-eslint"
alias "debug-eslint"="inspect-eslint"
alias "eslint-config"="inspect-eslint"

# Function to toggle `npm` / `npx` to `bun` / `bunx` in the current commannd
toggle_npm_bun() {
  # First handle bunx/npx pair to avoid conflicts
  BUFFER=${BUFFER//bunx/__BUNX_TEMP__}
  BUFFER=${BUFFER//npx/__NPX_TEMP__}
  
  # Then handle bun/npm pair
  BUFFER=${BUFFER//bun/__BUN_TEMP__}
  BUFFER=${BUFFER//npm/__NPM_TEMP__}
  
  # Now restore with swapped values
  BUFFER=${BUFFER//__BUN_TEMP__/npm}
  BUFFER=${BUFFER//__NPM_TEMP__/bun}
  BUFFER=${BUFFER//__BUNX_TEMP__/npx}
  BUFFER=${BUFFER//__NPX_TEMP__/bunx}
}

# Register the function as a ZLE widget
# Bind the F2 key to the toggle_npm_bun widget
zle -N toggle_npm_bun
bindkey '^[OQ' toggle_npm_bun

# This is a prefix'ed NPM. Currently only used by `claude` (Claude Code)
export PATH="/home/nico/.npm/prefix/bin:$PATH"