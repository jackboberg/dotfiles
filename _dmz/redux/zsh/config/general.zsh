export LSCOLORS="exfxcxdxbxegedabagacad"
export CLICOLOR=true

fpath=($DOT/zsh/functions $fpath)

autoload -U $DOT/zsh/functions/*(:t)

# dont nice background tasks
setopt NO_BG_NICE
setopt NO_HUP
setopt NO_LIST_BEEP

# allow functions to have local options
# FIXME: breaks pure prompt
# setopt LOCAL_OPTIONS

# allow functions to have local traps
setopt LOCAL_TRAPS
setopt PROMPT_SUBST
setopt CORRECT
setopt COMPLETE_IN_WORD
setopt IGNORE_EOF

# don't expand aliases _before_ completion has finished
#   like: git comm-[tab]
setopt complete_aliases

zle -N newtab

bindkey '^[^[[D' backward-word
bindkey '^[^[[C' forward-word
bindkey '^[[5D' beginning-of-line
bindkey '^[[5C' end-of-line
bindkey '^[[3~' delete-char
bindkey '^[^N' newtab
bindkey '^?' backward-delete-char
