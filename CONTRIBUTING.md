# Where to start

Please read `TODO.md` file and find something you would like there. Or just add whatever you might think would be useful.

## Developing Rails Engine

First install software dependencies, listed in [README.md](README.md#dependencies) file.

    cd test/dummy
    rake db:create
    rake db:migrate
    rake db:migrate RAILS_ENV=test

## Running ruby tests

    rspec spec

## Running javascript tests

First you need to install `node.js`, `karma` test runner and [phantom.js](http://phantomjs.org/download.html) headless WebKit browser

	npm install -g karma

To run the tests just run

	cd spec && karma start
