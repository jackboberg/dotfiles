# Ruby
export RBENV_ROOT=/usr/local/var/rbenv
RUBY_PATH=$RBENV_ROOT/shims

# even more local bin directories
BIN_PATH=./.bin:./bin:$HOME/.bin:$DOT/bin

# export the updated path
export PATH=$BIN_PATH:$RUBY_PATH:$PATH
