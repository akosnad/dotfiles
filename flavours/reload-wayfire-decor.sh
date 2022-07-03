#!/bin/bash

active_color=$(grep -P "^active_color" $HOME/.config/wayfire-win-decor)
inactive_color=$(grep -P "^inactive_color" $HOME/.config/wayfire-win-decor)

sed -i "s/^active_color.*/${active_color}/" $HOME/.config/wayfire.ini
sed -i "s/^inactive_color.*/${inactive_color}/" $HOME/.config/wayfire.ini
