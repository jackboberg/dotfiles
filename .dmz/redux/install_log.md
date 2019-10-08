# install

    git clone https://github.com/jackboberg/dotfiles /usr/local/share/dotfiles

## homebrew

    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew doctor
    brew cask doctor
    brew bundle --file /usr/local/share/dotfiles/Brewfile

## dropbox

- auth with dropbox, will require access to 1Password on mobile

## passwords

- install 1Password from app store
- relink accounts/vaults leveragin mobile

## rcm: manage 

    rcup -v -d /usr/local/share/dotfiles
    
this will include `.rcrc` so future usage targets this dir

## zsh

make default shell, config should be present from rcm

    sudo echo $(which zsh) >> /etc/shells
    chsh -s $(which zsh)

^ this did not work, ended up doing:

- Go to System Preferences
- Click on "Users & Groups"
- Click the lock to make changes.
- Right click the current user -> Advanced options
- Change the login shell to /usr/local/bin/zsh in the dropdown.
    
## emacs

    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
    # should have ~/.spacemacs from .dotfiles

Install 

## App store installed

- 1Password.app
- DaisyDisk.app
- Keynote.app
- Marked 2.app
- Numbers.app
- OmniFocus.app
- OmniGraffle.app
- OmniOutliner Pro.app
- Pages.app
- Pixelmator.app
- Slack.app
- Spark.app
- Textual.app
- TextWrangler.app
- Xcode.app

## post-install

    nvm i --lts
    # Installing default global packages from /usr/local/opt/nvm/default-packages...
