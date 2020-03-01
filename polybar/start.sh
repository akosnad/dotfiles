#!/bin/bash

killall -q polybar

echo "--- restart ---" | tee -a /tmp/polybar.log
MONITOR=$(polybar -m | head -1 | sed -e 's/:.*$//g') polybar bar1 >>/tmp/polybar-bar1.log 2>&1 &
pMONITOR=$(polybar -m | tail -1 | sed -e 's/:.*$//g') polybar bar2 >>/tmp/polybar-bar2.log 2>&1 &

echo "Bar launched..."
