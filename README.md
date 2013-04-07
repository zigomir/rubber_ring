## Docs

* Ruby version: 2.0.0-p0

* System dependencies: postgres

* Configuration

### Database creation:

	rake db:create
    sudo -u postgres psql rubber_ring_development -c 'create extension hstore;'
    sudo -u postgres psql rubber_ring_test -c 'create extension hstore;'
    rake db:migrate RAILS_ENV=development
    rake db:migrate RAILS_ENV=test


* Database initialization

### Running tests

    rspec spec

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

## Rubber Ring documentation

Supported content types for now will be: text (simple text) and html.

CMS fields are made of key and data type
class, and id are optional

	<%= editable_field(:p, {key: 'key', type: 'text', class: 'class', id: 'id'}, @content) do %>
  		Here is my editable content
	<% end %>


# TODOs
- Assets:
  - minify assets with grunt from build script
- firefox + ie editing is not as good as in chrome (webkit)
- Write (JavaScript) tests!
- Ember APP for images
- Extract to Rails Engine (+ ruby gem:)
- generator for new pages

## Usage

Generate site controller. (TODO generator)
Create views/site/site.html.erb view, views/layouts/site/layout.html.erb for layout.

## Deploy site to production

`Preview and prepare` => cache to `public/build`

`Publish` => `rsync` or `capistrano` to staging server server

## Benefits

- optimized for developers and quick setup
- simple to use for customers
- customer doesn't need application server and/or database. Only apache/nginx for static HTML serving 

## Postgres hstore

    sudo apt-get install postgresql-contrib


## Future may bring?

- service where user page (html + assets) (before must add right attributes to elements she wants to be editable) and than she can start editing her page right away (use grammar for parsing html or at leas really good library)