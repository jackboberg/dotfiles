npm-defaults () {
  cat $DOT/node/npm-defaults | xargs npm i -g
}

alias ccat="highlight"
alias h='npx historie'
alias standard-readme='npx -p generator-standard-readme -p yo yo standard-readme'
