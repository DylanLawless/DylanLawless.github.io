#!/bin/bash
# bundle exec jekyll serve &
 jekyll serve &
sleep 3

open -a Safari http://127.0.0.1:4000

# :set spell spelllang=en_gb

# if already in use
# ps aux | grep jekyll
# kill -9 "PID"



# with error: can't find gem jekyll (>= 0.a)
# sudo rm -rf _site
# bundle update
# bundle exec jekyll serve
# 
# And then always using 
# bundle exec jekyll serve 
# instead of 
# sudo jekyll serve or 
# jekyll serve.


