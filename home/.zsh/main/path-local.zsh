# Include local binaries in current git repo
export PATH="$(git root 2>/dev/null)/bin:${PATH}"
export PATH="$(git root 2>/dev/null)/.bin:${PATH}"
export PATH="$(git root 2>/dev/null)/node_modules/.bin:${PATH}"

# Include local binaries in current directory
export PATH="./bin:${PATH}"
export PATH="./.bin:${PATH}"
export PATH="./node_modules/.bin:${PATH}"