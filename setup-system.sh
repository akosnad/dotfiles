#!/bin/bash
set -e
dotfiles="$(dirname $(realpath $BASH_SOURCE))"
source "$dotfiles/setup-helpers.sh"

## Locale
need_locale_gen=0

if ! grep -q -P '^(?!#)en_US' /etc/locale.gen; then
    sudo sh -c 'echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen'
    need_locale_gen=1
fi


if ! [ -f /etc/locale.conf ]; then
    sudo touch /etc/locale.conf
fi
if ! grep -q -P '^LANG=en_US' /etc/locale.conf; then
    sudo sh -c 'echo "LANG=en_US.UTF-8" >> /etc/locale.conf'
    need_locale_gen=1
fi
if ! grep -q -P '^LC_(?:.*)=en_US' /etc/locale.conf; then
    sudo sh -c 'echo "LC_ALL=en_US.UTF-8" >> /etc/locale.conf'
    need_locale_gen=1
fi

if [ $need_locale_gen -eq 1 ]; then
    sudo locale-gen
fi

### Yay aur helper
if ! command -v yay >/dev/null; then
    sudo pacman -Sy --needed --noconfirm yay base-devel
fi

### Update system
yay -Syu

### Chaotic aur
if ! sudo pacman-key -l FBA220DFC880C036 &>/dev/null; then
    sudo pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com
    sudo pacman-key --lsign-key FBA220DFC880C036
fi
if ! sudo pacman -Qi chaotic-keyring chaotic-mirrorlist &>/dev/null; then
    sudo pacman --needed --noconfirm -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
fi

if ! grep -q -E "^\[chaotic-aur\]" /etc/pacman.conf; then
    sudo sh -c 'echo "[chaotic-aur]" >> /etc/pacman.conf'
    sudo sh -c 'echo "Include = /etc/pacman.d/chaotic-mirrorlist" >> /etc/pacman.conf'
fi

### Own aur build server
if ! grep -q -E "^\[aurto\]" /etc/pacman.conf; then
    sudo sh -c 'echo "[aurto]" >> /etc/pacman.conf'
    sudo sh -c 'echo "SigLevel = Never" >> /etc/pacman.conf'
    sudo sh -c 'echo "Server = https://repo.xfzt.gq/arch" >> /etc/pacman.conf'
fi
