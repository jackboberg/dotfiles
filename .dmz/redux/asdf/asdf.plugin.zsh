export ASDF_DIR=$(brew --prefix)/opt/asdf/

source $(brew --prefix asdf)/asdf.sh

autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
source $(brew --prefix)/etc/bash_completion.d/asdf.bash
