# print current IP
alias myip="curl -s https://api.myip.com | jq -r '{ip} | (.ip)'"
# curl whatismyip.akamai.com

# Copy my public key to my clipboard
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

alias guid="curl -s givemeguid.com"

# create directory and change to it
mkd () {
    mkdir -pv "${1}" && cd "${1}"
}

# cd to fuzzy-found locally cloned repository
p () {
    cd $(ghq root)/$(ghq list | fzy);
}

# easy zlib decompression
# via: Building Git
#
# cat .git/objects/XX/1234 | inflate
inflate () {
    ruby -r zlib -e "STDOUT.write Zlib::Inflate.inflate(STDIN.read)"
}
