# Better list output
alias l='ls -lFGh'
alias ll='ls -lAFGh'

# Traversing
alias ..='cd ..'
alias ...='cd ../..'

# create directory and change to it
mkd () {
    mkdir -pv "${1}" && cd "${1}"
}

# Super user
alias _='sudo'

# History
alias h='history'
alias fh='history | grep $1' #Requires one input

# How deep into vim have I gotten
alias shlvl="echo $SHLVL"

# Clear the DNS
alias flush_dns="dscacheutil -flushcache"
