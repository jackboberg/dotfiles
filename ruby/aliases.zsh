alias r='rbenv local 1.8.7-p358'

alias sc='script/console'
alias sg='script/generate'
alias sd='script/destroy'

alias migrate='rake db:migrate db:test:clone'

function rbenvsudo(){
  executable=$1
  shift 1
  sudo $(rbenv which $executable) $* 
}
