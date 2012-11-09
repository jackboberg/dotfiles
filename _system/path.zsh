# export PATH="./bin:$HOME/.rbenv/shims:/usr/local/bin:/usr/local/sbin:$HOME/.sfs:$ZSH/bin:$PATH"
# export MANPATH="/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$MANPATH"

# use local FIRST
LOCAL_PATH=/usr/local/bin:/usr/local/sbin

# PHP
PHP_PATH=/Applications/MAMP/bin/php/php5.3.6/bin

# Python
PYTHON_PATH=/usr/local/share/python

# Ruby
RUBY_PATH=$HOME/.rbenv/shims:$HOME/.rbenv/bin

# Node/NPM
NPM_PATH=/usr/local/share/npm/bin
export NODE_PATH=/usr/local/lib/node_modules

export PATH=.bin:$RUBY_PATH:$LOCAL_PATH:$ZSH/bin:$PHP_PATH:$PYTHON_PATH:$NPM_PATH:$PATH
