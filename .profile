. /etc/profile
# export LC_ALL=en_US.UTF-8
export EDITOR=/usr/bin/nvim
export VISUAL=$EDITOR
export PAGER=/usr/bin/less
export QT_QPA_PLATFORM="wayland;xcb"
export QT_QPA_PLATFORMTHEME=qt5ct
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}

if [[ $XDG_SESSION_TYPE == "wayland" ]]; then
    export TERMINAL=alacritty
fi

export TEXMFDIST="/usr/share/texmf-dist"
export TEXMFLOCAL="/usr/local/share/texmf:/usr/share/texmf"
export TEXMFSYSVAR="/var/lib/texmf"
export TEXMFSYSCONFIG="/etc/texmf"
export TEXMFHOME="~/texmf"
export TEXMFVAR="~/.texlive/texmf-var"
export TEXMFCONFIG="~/.texlive/texmf-config"
export TEXMFCACHE="$TEXMFSYSVAR;$TEXMFVAR"

export PATH="$PATH:/home/$USER/.local/bin"
# alias tlmgr='$TEXMFDIST/scripts/texlive/tlmgr.pl --usermode'
