completion=/usr/local/share/zsh/functions/_git
if test -f $completion
then
  source $completion
fi

completion=/usr/local/share/zsh/functions/git-flow-completion.zsh
if test -f $completion
then
  source $completion
fi
