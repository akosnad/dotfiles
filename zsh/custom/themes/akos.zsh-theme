autoload -Uz add-zsh-hook

# Grabbed from https://geoff.greer.fm/lscolors/
export LSCOLORS="exfxcxdxbxegedabagacad"
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} +"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} *"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} *"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} -"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ="
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} !"

set_prompt() {
    NCOLOR="green"
    ERRCOLOR='red'
    local exit_status='%{$fg[$ERRCOLOR]%}%(?..%?)%{$reset_color%}'
    local git_status="$(git_prompt_status)%{$reset_color%} $(git_prompt_info)%{$reset_color%}"

    if [ $UID -eq 0 ]; then
        NCOLOR="red"
    else
        /usr/bin/sudo -n -v &>/dev/null
        if [ $? -eq 0 ]; then
            NCOLOR="yellow"
        fi
    fi
    PROMPT='%{$fg[$NCOLOR]%}%5~ > %{$reset_color%}'
    RPROMPT="${git_status} ${exit_status}"
}

set_prompt
add-zsh-hook precmd set_prompt
