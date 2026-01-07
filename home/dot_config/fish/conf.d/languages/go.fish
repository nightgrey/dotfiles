set -gx GOPATH $HOME/.go
set -gx GOBIN $GOPATH/bin

# Add $HOME/go/bin to the PATH
fish_add_path -g $GOBIN