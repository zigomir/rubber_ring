#!/bin/sh

rm -rf public/build/images/ public/build/javascripts/ public/build/stylesheets/
cp -r public/images/ public/javascripts/ public/stylesheets/ public/build
