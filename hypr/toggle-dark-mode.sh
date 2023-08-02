#!/bin/bash

if ! bash $HOME/dotfiles/flavours/toggle.sh; then
    notify-send -e "Failed to toggle light/dark mode" "Current colorcheme does not have an opposite light/dark variant :("
fi
