# use local FIRST
LOCAL_PATH=/usr/local/bin:/usr/local/sbin

# Ruby
RUBY_PATH=$HOME/.rbenv/shims:$HOME/.rbenv/bin

# Node/npm
NPM_PATH=/usr/local/share/npm/bin

# add regular bin paths
BIN_PATH=./vendor/ruby/bin:./.bin:./bin

export PATH=$BIN_PATH:$RUBY_PATH:$LOCAL_PATH:$ZSH/bin:$NPM_PATH:$PATH
