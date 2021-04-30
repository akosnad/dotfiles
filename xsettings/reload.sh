#!/bin/bash

# I found no other way that works, only killing xsettingsd updates the theme
killall xsettingsd
xsettingsd -c $HOME/dotfiles/xsettings/xsettingsd &
sleep 0.2

