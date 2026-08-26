# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"

# DOOM!
DOOM_BIN=$(ghq list -p doomemacs/doomemacs)/bin
PATH=$PATH:$DOOM_BIN

# even more local bin directories
LOCAL_BIN=./.bin:./bin:$HOME/.bin:$SRC/bin
PATH=$LOCAL_BIN:$PATH
