#!/bin/bash
jekyll serve &
sleep 3

open -a Safari http://127.0.0.1:4000

# :set spell spelllang=en_gb

# if already in use
# ps aux | grep jekyll
# kill -9 "PID"
