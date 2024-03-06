#!/bin/bash
cp ./build/config_test.yml _config.yml
cp ./build/Gemfile_test Gemfile

# I do not know why but now fails without specifying encoding first:
LC_ALL="en_US.UTF-8" bundle exec jekyll serve --incremental &
sleep 3

open -a Safari http://127.0.0.1:4000

