# use local FIRST
LOCAL_PATH=/usr/local/bin:/usr/local/sbin

# Python
PYTHON_PATH=/usr/local/share/python

# Ruby
RUBY_PATH=$HOME/.rbenv/shims:$HOME/.rbenv/bin

# Node/NPM
NPM_PATH=/usr/local/share/npm/bin
export NODE_PATH=/usr/local/lib/node_modules

export PATH=./.bin:./bin:$RUBY_PATH:$LOCAL_PATH:$ZSH/bin:$PYTHON_PATH:$NPM_PATH:$PATH
