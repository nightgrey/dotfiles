# Local binaries
export PATH="$HOME/.zsh/bin:${PATH}"

# JetBrains Toolbox
export PATH="$HOME/.local/share/JetBrains/Toolbox/scripts:${PATH}"

# Include local binaries in current git repo
export PATH="$(git rev-parse --show-toplevel 2>/dev/null)/bin:${PATH}"
export PATH="$(git rev-parse --show-toplevel 2>/dev/null)/.bin:${PATH}"
export PATH="$(git rev-parse --show-toplevel 2>/dev/null)/node_modules/.bin:${PATH}"

# Include local binaries in current directory
export PATH="./bin:${PATH}"
export PATH="./.bin:${PATH}"
export PATH="./node_modules/.bin:${PATH}"
