#!/bin/bash
open -a Safari http://127.0.0.1:4000
jekyll serve

# if already in use
# ps aux | grep jekyll
# kill -9 "PID"
