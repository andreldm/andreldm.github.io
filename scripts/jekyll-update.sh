#!/bin/sh

# https://github.com/envygeeks/jekyll-docker/blob/master/README.md

docker run --rm \
  --volume="$PWD:/srv/jekyll" \
  -it jekyll/jekyll:3.8 \
  bundle update
