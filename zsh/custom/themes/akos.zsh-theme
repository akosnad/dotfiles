autoload -Uz add-zsh-hook

# Grabbed from https://geoff.greer.fm/lscolors/
export LSCOLORS="exfxcxdxbxegedabagacad"
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

set_prompt() {
    NCOLOR="green"
    ERRCOLOR='red'

    if [ $UID -eq 0 ]; then
        NCOLOR="red"
    else
        /usr/bin/sudo -n -v &>/dev/null
        if [ $? -eq 0 ]; then
            NCOLOR="yellow"
        fi
    fi
    PROMPT='%{$fg[$NCOLOR]%}%5~ » %{$reset_color%}'
    RPROMPT='%{$fg[$ERRCOLOR]%}%(?..%?)%{$reset_color%}'
}

set_prompt
add-zsh-hook precmd set_prompt
