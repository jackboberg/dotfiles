# import colors to named vars
autoload colors
if [[ "$terminfo[colors]" -gt 8 ]]; then
    colors
fi
for COLOR in RED GREEN YELLOW BLUE MAGENTA CYAN BLACK WHITE; do
    eval $COLOR='$fg_no_bold[${(L)COLOR}]'
    eval BOLD_$COLOR='$fg_bold[${(L)COLOR}]'
done
eval RESET='$reset_color'


git_branch() {
  echo $(/usr/local/bin/git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}


git_dirty() {
  st=$(/usr/local/bin/git status 2>/dev/null | tail -n 1)
  if [[ $st == "" ]]
  then
    echo ""
  else
    if [[ $st == "nothing to commit (working directory clean)" ]]
    then
      echo "%{$GREEN%}$(git_prompt_info)%{$RESET%}"
    else
      echo "%{$RED%}$(git_prompt_info)%{$RESET%}"
    fi
  fi
}


git_prompt_info () {
  ref=$(/usr/local/bin/git symbolic-ref HEAD 2>/dev/null) || return
  echo "(${ref#refs/heads/})"
}


unpushed () {
  /usr/local/bin/git cherry -v @{upstream} 2>/dev/null
}


need_push () {
  if [[ $(unpushed) == "" ]]
  then
    echo " "
  else
    echo " %{$MAGENTA%}▲%{$RESET%}"
  fi
}


local_user(){
  echo "%{$CYAN%}%n%{$RESET%}@%{$CYAN%}%m%{$RESET%}"
}

# This keeps the number of todos always available the right hand side of my
# command line. I filter it to only count those tagged as "+next", so it's more
# of a motivation to clear out the list.
todo(){
  if $(which todo.sh &> /dev/null)
  then
    num=$(echo $(td ls +next | wc -l))
    let todos=num-2
    if [ $todos != 0 ]
    then
      echo "$todos"
    else
      echo ""
    fi
  else
    echo ""
  fi
}


directory_name(){
  echo "%{$BLUE%}%~%{$RESET%}"
}


export PROMPT=$'\n[$(local_user):$(directory_name)] $(git_dirty)$(need_push)\n› '
set_prompt () {
  export RPROMPT="%{$GREEN%}$(todo)%{$RESET%}"
}
precmd() {
  title "zsh" "%m" "%55<...<%~"
  set_prompt
}
