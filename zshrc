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

# FPATH is exported by `brew shellenv zsh`, so entries are inherited by child
# shells and re-prepended on each startup. Keep the arrays unique.
typeset -U fpath path

eval "$(sheldon source)"

# Completion init lives in the sheldon plugin list, where the ordering
# constraints against $fpath and `compdef` are expressed.

# load local config
[ -f ~/.local/zshrc ] && . ~/.local/zshrc

eval "$(starship init zsh)"

# zprof
