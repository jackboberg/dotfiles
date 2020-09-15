export DOT=/usr/local/share/dotfiles

export ENHANCD_COMMAND=c

# even more local bin directories
LOCAL_BIN_PATH=./.bin:./bin:$HOME/.bin
# DOOM!
DOOM_BIN=$(/usr/local/bin/ghq root)/github.com/hlissner/doom-emacs/bin

export PATH=$LOCAL_BIN_PATH:$DOOM_BIN:$PATH
