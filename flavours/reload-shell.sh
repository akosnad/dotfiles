#for p in $(pgrep zsh); do if [[ $p != $$ ]]; then
#    pkill -P $p -STOP
#fi; done
killall -HUP zsh
for p in $pids; do pkill -P $p -CONT; done
