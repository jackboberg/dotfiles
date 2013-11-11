alias rake="noglob rake"
alias rspec='nocorrect rspec'
alias cap='nocorrect cap'

alias sc='script/console'
alias sg='script/generate'
alias sd='script/destroy'

alias migrate='rake db:migrate db:test:clone'

# bundle
alias b="bundle"
alias bi="b install"
alias bil="bi --local"
alias bu="b update"
alias binit="bi && b package"

function rbenvsudo(){
  executable=$1
  shift 1
  sudo $(rbenv which $executable) $*
}
