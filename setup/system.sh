#!/bin/bash
set -e

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

### Chaotic aur
if ! sudo pacman-key -l 3056513887B78AEB &>/dev/null; then
    sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
    sudo pacman-key --lsign-key 3056513887B78AEB
fi
if ! sudo pacman -Qi chaotic-keyring chaotic-mirrorlist &>/dev/null; then
    sudo pacman --needed --noconfirm -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
fi

if ! grep -q -E "^\[chaotic-aur\]" /etc/pacman.conf; then
    sudo sh -c 'echo "[chaotic-aur]" >> /etc/pacman.conf'
    sudo sh -c 'echo "Include = /etc/pacman.d/chaotic-mirrorlist" >> /etc/pacman.conf'
fi

### Own aur build server

# add personal signing key
if ! sudo pacman-key -l E2256EAE7390AF2C &>/dev/null; then
    sudo pacman-key --recv-key E2256EAE7390AF2C --keyserver keyserver.ubuntu.com
    sudo pacman-key --lsign-key E2256EAE7390AF2C
fi

# fzt-repo-keyring
if ! sudo pacman -Qi fzt-repo-keyring &>/dev/null; then
    sudo pacman --needed --noconfirm -U 'https://repo.fzt.one/arch/fzt-repo-keyring-20230615-1-any.pkg.tar.zst'
fi

# remove old repo entry
sudo sed -ie '/^\[aurto\]$/,+2d' /etc/pacman.conf
sudo rm -f /etc/pacman.d/aurto
if grep -q -E "^Include = /etc/pacman.d/aurto$" /etc/pacman.conf; then
    sudo sed -ie '/^Include = \/etc\/pacman.d\/aurto$/d' /etc/pacman.conf
fi

# add new repo entry
if ! grep -q -E "^Include = /etc/pacman.d/fzt-repo$" /etc/pacman.conf; then
    sudo sh -c 'echo "Include = /etc/pacman.d/fzt-repo" >> /etc/pacman.conf'
fi

# add repo file
sudo bash -c "cat <<- \"EOF\" > /etc/pacman.d/fzt-repo
[fzt-repo]
SigLevel = Required TrustedOnly
Server = https://repo.fzt.one/arch
EOF
"

### Yay aur helper
if ! command -v yay >/dev/null; then
    sudo pacman -Sy --needed --noconfirm yay base-devel
fi

### Update system
read -p "Update system? [Y/n] " reply
if [[ $reply =~ ^[Yy]$ ]] || [[ $reply == "" ]]; then
    yay -Sy
    if [[ $(yay -Qu archlinux-keyring fzt-repo-keyring) ]]; then
        # update keyring first
        yay -S --noconfirm archlinux-keyring fzt-repo-keyring
    fi
    yay -Su --noconfirm
fi
