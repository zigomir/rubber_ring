## Docs

* Ruby version: 2.0.0-p0

* DB: postgres

### Database creation:

Postgres hstore

    sudo apt-get install postgresql-contrib

Rails + Postgres commands

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

	
	<%= editable_field(:h1, {key: 'header'}, @page) do %>
	  Welcome to Rubber Ring - CMS that doesn't make you think about it.
	<% end %>
	
	<%= editable_field(:div, {key: 'first_content', class: 'multi-line'}, @page) do %>
	  Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut
	<% end %>
	
	<%= duplicable_editable_field(:ul, {group: 'blog_posts'}, @page) do %>
	<%= duplicable_editable_field(:ul, {group: 'blog_posts', duplications: 2}, @page) do %>
	<%= duplicable_editable_field(:ul, {group: 'blog_posts', child_tag: 'li', duplications: 2}, @page) do %>


# TODOs
- duplicable content
- images
- Assets:
  - minify assets with grunt from build script
- Write (JavaScript) tests!
- Extract to Rails Engine (+ ruby gem:)
- generator for new pages

## Philosophy

* you can not build robust system without limitations
* system may stretch only to certain point until it breaks. Like a rubber ring!

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

## Future may bring?

- service where user page (html + assets) (before must add right attributes to elements she wants to be editable) and than she can start editing her page right away (use grammar for parsing html or at leas really good library)


## Similar CMS-es

### Copybar

[Site](https://copybar.io) & [Documentation](https://copybar.io/documentation#quickstartUsers)

#### Advantages
- really easy to set up and use

#### Disadvantages
- every time loading content from servers (dependencies)
- not free (only for 5 elements, which is not enough)

### Perch
[Site](http://grabaperch.com/)

#### Advantages
- looks easy

#### Disadvantages
- not free
- hosted only

### Other CMS-es for inspiration
- [CopyCopter](http://copycopter.com) - opensource, ruby
- [SimpleCMS](http://www.simplecms.com) - not free, service
