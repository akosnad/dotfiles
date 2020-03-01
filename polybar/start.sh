#!/bin/bash

killall -q polybar

echo "--- restart ---" | tee -a /tmp/polybar.log
polybar bar1 >>/tmp/polybar-bar1.log 2>&1 &
polybar bar2 >>/tmp/polybar-bar2.log 2>&1 &

echo "Bar launched..."