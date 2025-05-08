# Create requirements.txt
alias "create-requirements"="./.venv/bin/pip3 list --format=freeze --local > requirements.txt"

# Aliases to create and (de-)activate venv's
alias "venv-new"="python -m venv .venv && chmod +x .venv/bin/activate"
alias "venv-on"="source .venv/bin/activate"
alias "venv-off"="source .venv/bin/deactivate"
# Shortcut
alias "venv"="venv-on"

# Install nightly pytorch
alias "install-pytorch"="pip3 install torch torchvision --index-url https://download.pytorch.org/whl/cu124"

# General fix for pip install issues. Usually something is out of date.
alias "fix-pip"="pip install --upgrade pip setuptools wheel packaging && pip3 install --upgrade pip setuptools wheel packaging"
