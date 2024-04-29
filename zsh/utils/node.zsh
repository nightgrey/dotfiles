# Always use bun.
alias _npx="npx"
alias npx="bunx"

# https://github.com/raineorshine/npm-check-updates
# Check package updates with `npm-check-updates`
alias ncu="bunx npm-check-updates"

# https://github.com/dylang/npm-check
# Check package updates with `npm-check`
alias nc="bunx npm-check"


# https://www.npmjs.com/package/madge
alias list-deps="npx madge --extensions ts,tsx,js,jsx"
alias list-circular="npx madge --circular --extensions ts,tsx,js,jsx"
alias list-unused="npx madge --orphans --extensions ts,tsx,js,jsx"

# ESLint config inspector
alias "inspect-eslint"="bunx @eslint/config-inspector"
alias "eslint-inspect"="inspect-eslint"
alias "debug-eslint"="inspect-eslint"
alias "eslint-config"="inspect-eslint"