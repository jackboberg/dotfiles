# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv zsh)"

# DOOM!
if command -v ghq >/dev/null 2>&1; then
  DOOM_BIN=$(ghq list -p doomemacs/doomemacs)/bin
  PATH=$PATH:$DOOM_BIN
fi

# even more local bin directories
LOCAL_BIN=./.bin:./bin:$HOME/.bin:$HOME/.local/bin:$SRC/bin
PATH=$LOCAL_BIN:$PATH
