#!/bin/bash


cp ./build/config_build.yml _config.yml
cp ./build/Gemfile Gemfile
sleep 1


bundle exec jekyll serve --skip-initial-build --incremental &
sleep 3

open -a Safari http://127.0.0.1:4000

