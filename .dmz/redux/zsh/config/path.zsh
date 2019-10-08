# even more local bin directories
BIN_PATH=./.bin:./bin:$HOME/.bin:$DOT/bin
DENO_PATH=$HOME/.deno/bin
export PATH=$BIN_PATH:$DENO_PATH:$PATH
