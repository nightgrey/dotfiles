# https://github.com/raineorshine/npm-check-updates
# Check package updates with `npm-check-updates`
alias ncu="bunx npm-check-updates"

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

# Function to toggle 'npm' and 'bun' in the current command line
toggle_npm_bun() {
  # Use a temporary placeholder to avoid double replacement
  BUFFER=${BUFFER//npm/__TMP__}
  BUFFER=${BUFFER//bun/npm}
  BUFFER=${BUFFER//__TMP__/bun}

  # Optionally, you can reposition the cursor if needed
  # zle reset-prompt
}

# Register the function as a ZLE widget
# Bind the F2 key to the toggle_npm_bun widget
zle -N toggle_npm_bun
bindkey '^[OQ' toggle_npm_bun

