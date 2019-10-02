# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=10000
setopt appendhistory beep extendedglob nomatch notify
unsetopt autocd
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/jack/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
source $(brew --prefix antibody)/zsh_plugins.sh

alias antibuild="antibody bundle < ~/.dotfiles/zsh_plugins > $(brew --prefix antibody)/zsh_plugins.sh"
