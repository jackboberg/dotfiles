# use local FIRST
LOCAL_PATH=/usr/local/bin:/usr/local/sbin

# Ruby
RUBY_PATH=$HOME/.rbenv/shims:$HOME/.rbenv/bin

# Node/npm
NPM_PATH=/usr/local/share/npm/bin

# add regular bin paths
BIN_PATH=./.bin:./bin:./vendor/ruby/bin:$ZSH/bin

# Heroku Toolbelt
HEROKU_PATH=/usr/local/heroku/bin

export PATH=$BIN_PATH:$RUBY_PATH:$LOCAL_PATH:$HEROKU_PATH:$NPM_PATH:$PATH
