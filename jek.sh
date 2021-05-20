#!/bin/bash
bundle exec jekyll serve &
# jekyll serve &
sleep 3

open -a Safari http://127.0.0.1:4000

# :set spell spelllang=en_gb

# if already in use
# ps aux | grep jekyll
# kill -9 "PID"

# Errors due to OS updates.

# e.g.: can't find gem jekyll (>= 0.a). Depending on machine:
# If rails not installed,
# sudo gem install rails
# bundle update

# sudo gem install jekyll bundler
# sudo rm -rf _site

# sudo chmod -R 777 /usr/local/lib/ruby/gems/
# gem install bundler jekyll
# bundle add webrick
