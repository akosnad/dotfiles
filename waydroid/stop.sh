#!/bin/bash

waydroid session stop
swaymsg exit
loginctl kill-session self
