alias r='rbenv local 1.9.3-p385'
alias rake="noglob rake"

alias sc='script/console'
alias sg='script/generate'
alias sd='script/destroy'

alias migrate='rake db:migrate db:test:clone'

# bundle
alias b="bundle"
alias bi="b install --path vendor"
alias bil="bi --local"
alias bu="b update"
alias be="b exec"
alias binit="bi && b package && echo 'vendor/ruby' >> .gitignore"

function rbenvsudo(){
  executable=$1
  shift 1
  sudo $(rbenv which $executable) $*
}
