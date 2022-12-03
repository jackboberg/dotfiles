# modify PATH here
# https://unix.stackexchange.com/questions/22979/path-helper-and-zsh

# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"

# DOOM!
DOOM_BIN=$(ghq list -p doomemacs/doomemacs)/bin
PATH=$PATH:$DOOM_BIN

# elixir-ls
ELIXIR_LS_PATH=$(ghq list -p elixir-lsp/elixir-ls)/release
PATH=$PATH:$ELIXIR_LS_PATH

# even more local bin directories
LOCAL_BIN=./.bin:./bin:$HOME/.bin
PATH=$LOCAL_BIN:$PATH
