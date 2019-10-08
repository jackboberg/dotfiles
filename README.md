# @jackboberg has dotfiles

## AMNESTY

I have just begun setup of a new iMac Pro, and have decided to wipe and
restart my dotfiles after 7 years of accumulating cruft. I am moving all
the existing files to a `.dmz` and will rebuild as I discover I am missing
some functionality.

# install

    git clone https://github.com/jackboberg/dotfiles /usr/local/share/dotfiles

## rcm: manage 

    rcup -v -d /usr/local/share/dotfiles
    
this will include `.rcrc` so future usage targets this directory