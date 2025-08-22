#!/bin/sh

killall -q hyprsunset

current_hour=$(date +%H)

if [ "$current_hour" -ge 18 ] || [ "$current_hour" -le 6 ]; then
  hyprsunset -t 3000
else
  hyprsunset -i
fi
