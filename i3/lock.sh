#!/bin/bash

### i3lock-fancy-multimonitor -b=0x3

if [ "$(qdbus org.freedesktop.PowerManagement /org/freedesktop/PowerManagement org.freedesktop.PowerManagement.HasInhibit)" = "false" -o "$1" = "--manual" ]; then

# Taken from https://pastebin.com/ZpYghBkQ
    scrot /tmp/screen.png
    convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png

    if [[ -f $HOME/dotfiles/i3/lock.png ]] 
    then
        # placement x/y
        PX=0
        PY=0
        # lockscreen image info
        R=$(file ~/dotfiles/i3/lock.png | grep -o '[0-9]* x [0-9]*')
        RX=$(echo $R | cut -d' ' -f 1)
        RY=$(echo $R | cut -d' ' -f 3)

    #    SR=$(xrandr --query | grep ' connected' | cut -f3 -d' ')
        SR=$(xrandr --query | grep ' connected' | grep -oP '[0-9]*x[][0-9]*\+[0-9]*\+[0-9]*')
        for RES in $SR
        do
            # monitor position/offset
            SRX=$(echo $RES | cut -d'x' -f 1)                   # x pos
            SRY=$(echo $RES | cut -d'x' -f 2 | cut -d'+' -f 1)  # y pos
            SROX=$(echo $RES | cut -d'x' -f 2 | cut -d'+' -f 2) # x offset
            SROY=$(echo $RES | cut -d'x' -f 2 | cut -d'+' -f 3) # y offset
            PX=$(($SROX + $SRX/2 - $RX/2))
            PY=$(($SROY + $SRY/2 - $RY/2))

            convert /tmp/screen.png $HOME/dotfiles/i3/lock.png -geometry +$PX+$PY -composite -matte  /tmp/screen.png
            echo "done"
        done
    fi 
    i3lock -e -u -n -i /tmp/screen.png
    rm /tmp/screen.png

else
	echo 'Not locking due to inhibitation'
fi
