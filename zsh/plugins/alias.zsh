# exa
alias l="exa -l"
alias ll="exa -la"

# create directory and change to it
mkd () {
    mkdir -pv "${1}" && cd "${1}"
}