alias drmi='docker rmi $(docker images --filter "dangling=true" -qa)'
