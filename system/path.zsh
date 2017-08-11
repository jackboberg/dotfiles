# even more local bin directories
BIN_PATH=./.bin:./bin:$HOME/.bin:$DOT/bin
#
# Ruby
export RBENV_ROOT=$(brew --prefix)/var/rbenv
RUBY_PATH=$RBENV_ROOT/shims

# export the updated path
export PATH=$BIN_PATH:$RUBY_PATH:$PATH
