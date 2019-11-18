sudo-drop-privileges-or-exit() {
    if [[ $UID -ne 0 ]]; then
        /usr/bin/sudo -n -v &>/dev/null
        if [[ $? -eq 0 ]]; then
            sudo -k
            # echo -n "Dropped superuser privileges"
            zle accept-line
            return
        fi
    fi
    if [[ -z $BUFFER ]]; then
        exit
    fi
}
zle -N sudo-drop-privileges-or-exit

stty eof undef # Disable built-in Ctrl+D
bindkey "^D" sudo-drop-privileges-or-exit

sudo-elevate-or-insert() {
    if [[ -z $BUFFER ]]; then
        sudo -v
        zle accept-line
    else
        if [[ $BUFFER = 'sudo '* ]]; then return; fi
        BUFFER="sudo "$BUFFER
        zle end-of-line
    fi
}
zle -N sudo-elevate-or-insert
bindkey "^S" sudo-elevate-or-insert