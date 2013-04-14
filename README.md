# RubberRing

This project rocks and uses MIT-LICENSE.

In your rails app run following:

    rake db:create
    sudo -u postgres psql rubber_ring_gem_development -c 'create extension hstore;'
    rake rubber_ring:install:migrations
    rake db:migrate

For testing you need to do this:

    cd test/dummy
    sudo -u postgres psql rubber_ring_gem_test -c 'create extension hstore;'
    rake db:migrate RAILS_ENV=test

    cd ../..
    rspec spec

# TODO copy readme here
# TODO copy build.sh to rails app or do it rather with code

