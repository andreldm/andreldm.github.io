#!/bin/sh

# https://github.com/envygeeks/jekyll-docker/blob/master/README.md

docker run --rm \
  --volume="$PWD:/srv/jekyll" \
  --volume="$HOME/.jekyll-cache:/usr/local/bundle" \
  -p 4000:4000 \
  -it jekyll/jekyll:3.8 \
  jekyll "$@"
