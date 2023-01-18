#!/bin/bash
# Use the config_build for _config.yml
cp ./build/config_build.yml _config.yml
sleep 1
# Used to build instead of serve, fo making the sitemap in _site/
# bundle exec jekyll build

# I do not know why but now fails without specifying encoding first:
LC_ALL="en_US.UTF-8" bundle exec jekyll build
