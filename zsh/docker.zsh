alias drmi='docker rmi $(docker images --filter "dangling=true" -qa)'

function dclean {
  echo "Removing dead containers..."
  docker container rm $(docker container ls -a -q -f status=dead) 2>/dev/null || echo "...No dead containers to remove."

  echo "Removing stopped containers..."
  docker rm $(docker ps --all --quiet --filter status=exited) 2>/dev/null|| echo "...No stopped containers to remove."

  echo "Removing untagged images..."
  docker rmi $(docker images --quiet --filter dangling=true) 2>/dev/null || echo "...No dead images to remove."
}

dstop () {
  # echo "Stopping docker-sync..."
  # docker-sync stop

  echo "Stopping all docker containers..."
  docker stop $(docker ps --all --quiet)
}
