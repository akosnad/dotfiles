default_theme="darkmoss"

if [ ! -d "$HOME/.local/share/flavours" ]; then
    flavours update lists
    flavours update schemes || true
    flavours update templates
fi
flavours_conf="$dotfiles/flavours/config.toml"
pushd "$dotfiles/flavours"
./link_templates.sh
popd
rm -f "$flavours_conf"
ln -s $dotfiles/flavours/config-$1.toml $flavours_conf

case $1 in
    "minimal")
        if ! flavours current &>/dev/null; then
            flavours apply $default_theme
        fi
    ;;
    *)
        if [ -f $dotfiles/awesome/.first-run ]; then
            rm $dotfiles/awesome/.first-run
            if ! flavours current &>/dev/null; then
                flavours apply $default_theme
            else
                flavours apply $(flavours current)
            fi
        fi
    ;;
esac


