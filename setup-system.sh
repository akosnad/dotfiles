#!/bin/bash

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
