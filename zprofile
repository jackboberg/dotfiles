# modify PATH here
# https://unix.stackexchange.com/questions/22979/path-helper-and-zsh

# DOOM!
DOOM_BIN=$SRC/github.com/hlissner/doom-emacs/bin
PATH=$PATH:$DOOM_BIN

# asdf
# instead of sourcing `$(brew --prefix asdf)/asdf.sh`, which always prepends
ASDF_BIN="${ASDF_DIR}/bin"
ASDF_USER_SHIMS="${ASDF_DATA_DIR:-$HOME/.asdf}/shims"
PATH=$ASDF_USER_SHIMS:$ASDF_BIN:$PATH

# even more local bin directories
LOCAL_BIN=./.bin:./bin:$HOME/.bin
PATH=$LOCAL_BIN:$PATH
