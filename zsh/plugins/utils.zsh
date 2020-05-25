# print current IP
alias myip="curl -s https://api.myip.com | jq -r '{ip} | (.ip)'"

# Copy my public key to my clipboard
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"