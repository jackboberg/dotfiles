# modify PATH here
# https://unix.stackexchange.com/questions/22979/path-helper-and-zsh

# homebrew sbin
PATH=$PATH:/usr/local/sbin

# DOOM!
DOOM_BIN=$(ghq list -p hlissner/doom-emacs)/bin
PATH=$PATH:$DOOM_BIN

# asdf
# instead of sourcing `$(brew --prefix asdf)/asdf.sh`, which always prepends
ASDF_BIN="${ASDF_DIR}/bin"
ASDF_USER_SHIMS="${ASDF_DATA_DIR:-$HOME/.asdf}/shims"
PATH=$ASDF_USER_SHIMS:$ASDF_BIN:$PATH

# elixir-ls
ELIXIR_LS_PATH=$(ghq list -p elixir-lsp/elixir-ls)/release
PATH=$PATH:$ELIXIR_LS_PATH

# even more local bin directories
LOCAL_BIN=./.bin:./bin:$HOME/.bin
PATH=$LOCAL_BIN:$PATH
