# export PATH="./bin:$HOME/.rbenv/shims:/usr/local/bin:/usr/local/sbin:$HOME/.sfs:$ZSH/bin:$PATH"
# export MANPATH="/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$MANPATH"

# use local FIRST
LOCAL_PATH=/usr/local/bin:/usr/local/sbin

# Python
PYTHON_PATH=/usr/local/share/python

# Ruby
RUBY_PATH=/usr/local/Cellar/ruby/1.9.3-p194/bin
export GEM_HOME='/usr/local'

# Node/NPM
NPM_PATH=/usr/local/share/npm/bin
export NODE_PATH=/usr/local/lib/node_modules

export PATH=$LOCAL_PATH:$ZSH/bin:$PYTHON_PATH:$RUBY_PATH:$NPM_PATH:$PATH
