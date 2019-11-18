setopt share_history

# https://superuser.com/questions/446594/separate-up-arrow-lookback-for-local-and-global-zsh-history
bindkey "^[[A" up-line-or-local-history   # Cursor up
bindkey "^[[B" down-line-or-local-history # Cursor

bindkey "^[[1;5A" up-line-or-history    # [CTRL] + Cursor up
bindkey "^[[1;5B" down-line-or-history  # [CTRL] + Cursor down

up-line-or-local-history() {
    zle set-local-history 1
    zle up-line-or-history
    # zle set-local-history 0
}
zle -N up-line-or-local-history

down-line-or-local-history() {
    zle set-local-history 1
    zle down-line-or-history
    # zle set-local-history 0
}
zle -N down-line-or-local-history

bindkey "^X" clear-screen