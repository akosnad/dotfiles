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
