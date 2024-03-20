# Aliases to create and (de-)activate venv's
alias "venv-new"="python -m venv --symlinks --system-site-packages --symlinks .venv"
alias "venv-on"="source .venv/bin/activate"
alias "venv-off"="source .venv/bin/deactivate"

# Shortcut
alias "venv"="venv-on"

# Install nightly pytorch
alias "install-pytorch"="pip install --pre torch torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/cu121"
