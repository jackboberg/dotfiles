export NVM_DIR=$(brew --prefix)/var/nvm
source $(brew --prefix nvm)/nvm.sh

npm-defaults () {
  cat $DOT/node/npm-defaults | xargs npm i -g
}
