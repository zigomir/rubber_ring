#!/bin/sh

rm -rf public/deploy/images/ public/deploy/javascripts/ public/deploy/stylesheets/
cp -r public/images/ public/javascripts/ public/stylesheets/ public/deploy
