# @jackboberg has dotfiles

Insipred by [Zach Holman][holman], this are how I personalize my system.

## install

    git clone --recursive git://github.com/jackboberg/dotfiles ~/.dotfiles
    cd ~/.dotfiles
    rake install

The install rake task will symlink the appropriate files in `.dotfiles` to your
home directory. Everything is configured and tweaked within `~/.dotfiles`,
though.

## components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment.
- **topic/\*.symlink**: Any files ending in `*.symlink` get symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `rake install`.
- **topic/\*.completion.sh**: Any files ending in `completion.sh` get loaded
  last so that they get loaded after we set up zsh autocomplete functions.

[holman]: http://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/


## notes

```
npm i tern -g # for emacs
```

- homebrew
  (/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)")
  - rcm
  - zsh
    - antigen: symlink in .zshrc
      - nvm
        - node (script all the things)
