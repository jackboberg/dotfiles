export SRC=$(/usr/local/bin/ghq root)
export DOT=$SRC/github.com/jackboberg/dotfiles

export ASDF_DIR=$(/usr/local/bin/brew --prefix asdf)

export ENHANCD_COMMAND=c

PKG_ICU4C=/usr/local/opt/icu4c/lib/pkgconfig
PKG_KRB5=/usr/local/opt/krb5/lib/pkgconfig
PKG_LIBEDIT=/usr/local/opt/libedit/lib/pkgconfig
PKG_LIBXML2=/usr/local/opt/libxml2/lib/pkgconfig
PKG_OPENSSL=/usr/local/opt/openssl@1.1/lib/pkgconfig

export PKG_CONFIG_PATH=$PKG_ICU4C:$PKG_LIBEDIT:$PKG_LIBXML2:$PKG_OPENSSL:$PKG_CONFIG_PATH

export EDITOR=emacs

export FSEVENT_SLEEP="$HOME/.bin/fsevent_sleep"
