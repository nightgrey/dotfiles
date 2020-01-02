# Homebrew
export PATH="/usr/local/bin:$PATH"

# Python 3.8
export PATH="/usr/local/opt/python@3.8/bin:$PATH"

# rbenv
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
eval "$(rbenv init -)"
rbenv local 2.7.1
