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

* How to run the test suite

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
- Assets!
- rename deploy to build -> try minification there with grunt
- Write (JavaScript) tests!
- Emberize! :)
- "Publish" will cache as static HTML which is later sent to production server
- Extract to Rails Engine (+ ruby gem:)
- generator for new pages

## Usage

Generate site controller. (TODO generator)
Create views/site/site.html.erb view, views/layouts/site/layout.html.erb for layout.

## Benefits

- customer doesn't need application server and/or database. Only apache/nginx for static HTML serving 

## Postgres hstore

    sudo apt-get install postgresql-contrib

