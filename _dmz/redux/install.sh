#!/usr/bin/env bash
set -euf -o pipefail

# curl -o- https://raw.githubusercontent.com/jackboberg/dotfiles/blob/master/install.sh | bash

{ # ensure the entire script is loaded #
  
  clone_dotfiles() {
    # leverages hub

    hub clone --recursive jackboberg/dotfiles ~/.dotfiles
    git clone dotfiles ~/.dotfiles
  }

  install_homebrew() {
    which brew && return
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  }

  install_homebrew_defaults() {
    brew bundle
    xargs brew install < ./brew/defaults
  }

  dotfiles_do_install() {
    install_homebrew
    clone_dotfiles # requires git and hub
    install_homebrew_defaults

    echo 'i ran'
  }

  # [ "_$DOT_ENV" = "_testing" ] || dotfiles_do_install
  dotfiles_do_install

} # ensure the entire script is loaded #
