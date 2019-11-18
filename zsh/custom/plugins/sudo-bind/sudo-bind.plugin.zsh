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