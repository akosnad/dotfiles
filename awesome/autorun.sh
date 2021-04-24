#!/usr/bin/env bash

~/.config/awesome/startup.sh

function run {
	if ! pgrep -f $1 ;
	then
		$@&
	fi
}

run redshift-gtk
