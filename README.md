# @jackboberg has dotfiles

# Prerequisites

- [Homebrew: The Missing Package Manager for macOS (or Linux)](https://brew.sh/)
- [x-motemen/ghq: Remote repository management made easy](https://github.com/x-motemen/ghq)
- [thoughtbot/rcm: rc file (dotfile) management](https://github.com/thoughtbot/rcm)

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    brew doctor
    brew install ghq rcm

# install
    
    GHQ_ROOT=~/src ghq get jackboberg/dotfiles

## rcm: manage symbolic links 

    rcup -d ~/src/github.com/jackboberg/dotfiles rcrc && rcup
    
First we symbolically link just the `rcrc` file, then allow that configuration
to drive the default linking strategy. 

## Next steps

    brew bundle --global
    
### Setup Emacs

    ghq get plexus/chemacs
    ghq get hlissner/doom-emacs
    ghq get syl20bnr/spacemacs
    cd $SRC/github.com/plexus/chemacs && ./install.sh
    
[chemacs](https://github.com/plexus/chemacs) allows me to toggle my Emacs
configuration, currently [Doom](https://github.com/hlissner/doom-emacs).


# AMNESTY

While setting up a new iMac Pro, I decided to wipe and restart my dotfiles after
7 years of accumulating cruft. I have moved all the existing files to a `.dmz`
and am rebuilding as I discover missing functionality.
