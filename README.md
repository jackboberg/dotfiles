# @jackboberg has dotfiles

## AMNESTY

I have just begun setup of a new iMac Pro, and have decided to wipe and
restart my dotfiles after 7 years of accumulating cruft. I am moving all
the existing files to a `.dmz` and will rebuild as I discover I am missing
some functionality.

# install

    git clone https://github.com/jackboberg/dotfiles /usr/local/share/dotfiles

## rcm: manage 

    rcup -d /usr/local/share/dotfiles rcrc && rcup
    
First we symlink just the `rcrc` file, then allow that config to drive the default linking strategy. 