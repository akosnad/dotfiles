#!/bin/bash

gsettings set org.gnome.desktop.interface gtk-theme Adwaita
sleep 0.2
gsettings set org.gnome.desktop.interface gtk-theme FlatColor

wf_shell_ini=$HOME/dotfiles/wayfire/wf-shell.ini
sed -i 's/gtk_headerbar/####TEMP####/g' $wf_shell_ini
sleep 0.2
sed -i 's/####TEMP####/gtk_headerbar/g' $wf_shell_ini
