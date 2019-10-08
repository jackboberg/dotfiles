#!/usr/bin/env zsh
# uncomment this and the last line for zprof info
# zmodload zsh/zprof

# Lines configured by zsh-newuser-install
setopt beep extendedglob nomatch notify
unsetopt autocd
bindkey -v
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '/Users/jack/.zshrc'
# End of lines added by compinstall

autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

source <(sheldon --root $DOT/zsh source)

# load local config
[ -f ~/.localrc ] && . ~/.localrc

# zprof