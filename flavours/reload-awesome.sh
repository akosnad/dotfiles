#!/bin/bash
set -e

xrdb -merge ~/.Xresources.d/colors
if command -v awesome-client >/dev/null; then
    awesome-client "awesome.emit_signal('reload')"
fi
