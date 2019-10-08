export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=$HISTSIZE

# Fish shell's history search feature
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# perform history expansion and reload the line into the editing buffer
setopt HIST_VERIFY

# add timestamps to history
setopt EXTENDED_HISTORY

# don't record dupes in history
setopt HIST_IGNORE_ALL_DUPS  

# # share history between sessions ???
# setopt SHARE_HISTORY

# adds history incrementally and share it across sessions
setopt INC_APPEND_HISTORY SHARE_HISTORY

# append their history list to file, rather than replace it
setopt APPEND_HISTORY

# remove superfluous blanks from each command
setopt HIST_REDUCE_BLANKS

# remove command when the first character on the line is a space
setopt HIST_IGNORE_SPACE
