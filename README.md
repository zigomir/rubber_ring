== README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


Please feel free to use a different markup language if you do not plan to run
<tt>rake doc:app</tt>.

## Rubber Ring documentation

Supported content types for now will be: text (simple text) and html.

CMS fields are made of key and data type
class, and id are optional

<%= editable_field(:p, {key: 'key', type: 'text', class: 'class', id: 'id'}, @content) do %>
  Here is my editable content
<% end %>


# TODOs
- Pull request for actionpack-page_caching gem in readme about config.action_controller.page_cache_directory = Rails.root.to_s + '/public'

- assets => assets precompile to deploy

- Disable key duplication
- Write tests!
- Controller + Action = Unique
- Emberize backend! :)
- "Publish" will cache as static HTML which is later sent to production server

# Benefits
- customer doesn't need application server and/or database. Only apache/nginx for static HTML serving
- 

## Software dependencies

Postgres hstore

    sudo apt-get install postgresql-contrib

    sudo -u postgres psql rubber_ring_development -c 'create extension hstore;'
    sudo -u postgres psql rubber_ring_test -c 'create extension hstore;'
    sudo -u postgres psql rubber_ring_production -c 'create extension hstore;'
