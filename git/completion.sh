# completion=/usr/local/share/zsh/site-functions/_git
# if test -f $completion
# then
#   source $completion
# fi
# 
# completion=/usr/local/share/zsh/site-functions/git-flow-completion.zsh
# if test -f $completion
# then
#   source $completion
# fi

# completion=/usr/local/share/zsh/site-functions/_hub
# if test -f $completion
# then
#   source $completion
# fi

__git_files () {
    _wanted files expl 'local files' _files
}
