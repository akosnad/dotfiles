echo_title() {
	TITLE="\e]2;$*\a"
	echo -n -e $TITLE
}

set_title_precmd() {
		TITLE="$(whoami)@$(hostname)"
		echo_title $TITLE
}

set_title_preexec() {
        if [ "$1" = "fg" ]; then
            e=$(jobs | grep -oP '^\[\d+\]\s+\+\s+.*?\s+\K.*$')
            TITLE="$(whoami)@$(hostname): $e"
        else
            TITLE="$(whoami)@$(hostname): $1"
        fi
		echo_title $TITLE
}

add-zsh-hook precmd set_title_precmd
add-zsh-hook preexec set_title_preexec
