if [ -x /opt/homebrew/bin/ghq ]; then
  export SRC=$(/opt/homebrew/bin/ghq root)
fi
export DOT=${(%):-%d}

# XDG Base Directory Specification
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}

export RUSTUP_HOME=${RUSTUP_HOME:-$XDG_DATA_HOME/rustup}
export CARGO_HOME=${CARGO_HOME:-$XDG_DATA_HOME/cargo}

export NODEJS_CHECK_SIGNATURES=no

export ENHANCD_COMMAND=c

export EDITOR="zed --wait"

export FSEVENT_SLEEP="$HOME/.bin/fsevent_sleep"

export GOPATH=$SRC
[ -f "$CARGO_HOME/env" ] && . "$CARGO_HOME/env"
