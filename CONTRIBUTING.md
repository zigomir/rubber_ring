# Where to start

Please read `TODO.md` file and find something you would like there. Or just add whatever you might think is useful to this project.

## Developing Rails Engine

    cd test/dummy
    rake db:create
    sudo -u postgres psql rubber_ring_gem_development -c 'create extension hstore;'
    sudo -u postgres psql rubber_ring_gem_test -c 'create extension hstore;'
    rake db:migrate
    rake db:migrate RAILS_ENV=test

## Running tests

    rspec spec