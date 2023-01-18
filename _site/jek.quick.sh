#!/bin/bash
# Use the config_test for _config.yml
# remove scholar plugin
cp ./build/config_test.yml _config.yml
cp ./build/Gemfile_test Gemfile


# # bundle exec jekyll serve --incremental &
# bundle exec jekyll serve &
# bundle jekyll exec serve --skip-initial-build --incremental &

# I do not know why but now fails without specifying encoding first:
LC_ALL="en_US.UTF-8" bundle jekyll exec serve --skip-initial-build --incremental &

# jekyll exec serve --skip-initial-build --incremental &
sleep 3

open -a Safari http://127.0.0.1:4000

