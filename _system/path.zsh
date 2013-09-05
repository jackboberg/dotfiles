# use local FIRST
LOCAL_PATH=/usr/local/bin:/usr/local/sbin

# Python
PYTHON_PATH=/usr/local/share/python

# Ruby
RUBY_PATH=$HOME/.rbenv/shims:$HOME/.rbenv/bin

# Node/npm
NPM_PATH=/usr/local/share/npm/bin

export PATH=./.bin:./bin:$RUBY_PATH:$LOCAL_PATH:$ZSH/bin:$PYTHON_PATH:$NPM_PATH:$PATH
