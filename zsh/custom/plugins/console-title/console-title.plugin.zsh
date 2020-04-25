echo_title() {
	TITLE="\e]2;$*\a"
	echo -n -e $TITLE
}

set_title_precmd() {
		TITLE="$(whoami)@$(hostname)"
		echo_title $TITLE
}

set_title_preexec() {
		TITLE="$(whoami)@$(hostname): $1"
		echo_title $TITLE
}

add-zsh-hook precmd set_title_precmd
add-zsh-hook preexec set_title_preexec
