# where to store the history
HISTFILE=~/.histfile

# number in memory
HISTSIZE=1000

# number in the file
SAVEHIST=10000

# perform history expansion and reload the line into the editing buffer
setopt HIST_VERIFY

# add timestamps to history
setopt EXTENDED_HISTORY

# don't record dupes in history
setopt HIST_IGNORE_ALL_DUPS  

# adds history incrementally and share it across sessions
setopt INC_APPEND_HISTORY SHARE_HISTORY

# remove superfluous blanks from each command
setopt HIST_REDUCE_BLANKS

# remove command when the first character on the line is a space
setopt HIST_IGNORE_SPACE

# ---
# zsh-users/zsh-history-substring-search
# Fish Shell's history search feature
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# bind the k and j keys for use in VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down