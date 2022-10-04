if [ ! -d "$HOME/.themes/FlatColor" ]; then
    git clone "https://github.com/jasperro/FlatColor" "$HOME/.themes/FlatColor"
fi
if ! grep -Eq "^include \"../colors2\"$" "$HOME/.themes/FlatColor/gtk-2.0/gtkrc"; then
    pushd "$HOME/.themes/FlatColor"
    git apply "$dotfiles/gtk/flatcolor.patch"
    popd
fi

# credit: https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland

config="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-3.0/settings.ini"
if [ ! -f "$config" ]; then return; fi

gnome_schema="org.gnome.desktop.interface"
gtk_theme="$(grep 'gtk-theme-name' "$config" | sed 's/.*\s*=\s*//')"
icon_theme="$(grep 'gtk-icon-theme-name' "$config" | sed 's/.*\s*=\s*//')"
cursor_theme="$(grep 'gtk-cursor-theme-name' "$config" | sed 's/.*\s*=\s*//')"
font_name="$(grep 'gtk-font-name' "$config" | sed 's/.*\s*=\s*//')"
gsettings set "$gnome_schema" gtk-theme "$gtk_theme"
gsettings set "$gnome_schema" icon-theme "$icon_theme"
gsettings set "$gnome_schema" cursor-theme "$cursor_theme"
gsettings set "$gnome_schema" font-name "$font_name"
