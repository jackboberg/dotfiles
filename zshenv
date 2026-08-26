export SRC=$(/opt/homebrew/bin/ghq root)
export DOT=${(%):-%d}

export NODEJS_CHECK_SIGNATURES=no

export ENHANCD_COMMAND=c

export EDITOR="zed --wait"

export FSEVENT_SLEEP="$HOME/.bin/fsevent_sleep"

export GOPATH=$SRC
. "$HOME/.cargo/env"
