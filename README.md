# @jackboberg has dotfiles

## install
    
    /usr/bin/env bash \
        <(curl -fsSL https://raw.githubusercontent.com/jackboberg/dotfiles/latest/script/install)

This will clone this repo to `~/src/github.com/jackboberg` and execute [`script/setup`](script/setup). The path matches conventions from [`ghq`][ghq], which I use to manage all my local projects.

### Next steps

I keep a log of [install issues][install-issues] and potential improvements when
I have the opportunity to run a _clean_ install.

- 2021-04-17: iMac Pro, macOS 11.2.3
- 2020-11-28: MacBook Pro, macOS 10.15.7

## Tooling

- [rossmacarthur/sheldon: A fast, configurable, shell plugin manager](https://github.com/rossmacarthur/sheldon)
- [Starship: Cross-Shell Prompt](https://starship.rs/)
- [thoughtbot/rcm: rc file (dotfile) management](https://github.com/thoughtbot/rcm)
- [hlissner/doom-emacs: An Emacs framework for the stubborn martian hacker](https://github.com/hlissner/doom-emacs)
- [asdf - An extendable version manager](https://asdf-vm.com)
- [x-motemen/ghq: Remote repository management made easy][ghq]
- [Homebrew: The Missing Package Manager for macOS (or Linux)](https://brew.sh)

## Amnesty

While setting up a new computer, I decided to wipe and restart my dotfiles after
years of accumulating cruft. I have moved all the legacy files to a `.dmz` and
am rebuilding as I discover missing functionality.

[install-issues]: https://github.com/jackboberg/dotfiles/labels/install
[ghq]: https://github.com/x-motemen/ghq
