# RubberRing

This project rocks and uses MIT-LICENSE.

* Ruby version: 2.0.0-p0

* DB: postgres 9.1 with hstore

Postgres hstore on Ubuntu

    sudo apt-get install postgresql-contrib

## Usage

    rake db:create
    sudo -u postgres psql rubber_ring_gem_development -c 'create extension hstore;'
    rake rubber_ring:install:migrations
    rake db:migrate


Add this route to your `routes.rb`

    mount RubberRing::Engine => '/rubber_ring', :as => 'rubber_ring'

## Testing Engine:

    cd test/dummy
    sudo -u postgres psql rubber_ring_gem_test -c 'create extension hstore;'
    rake db:migrate RAILS_ENV=test

    cd ../..
    rspec spec

## Rubber Ring documentation

Supported content types for now will be: text (simple text) and html.

CMS fields are made of tag, key and `@page` which holds content for all the page keys. `class`, and `id` are optional

	<%= editable_field(:h1, {key: 'header'}, @page) do %>
	  Welcome to Rubber Ring - CMS that doesn't make you think about it.
	<% end %>

	<%= editable_image({key: 'header_image', src: '/images/rubber_ring.jpg'}, @page) %>

	<%= editable_field(:div, {key: 'first_content', class: 'multi-line'}, @page) do %>
	  Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut
	<% end %>

	<%= duplicable_editable_field(:ul, {group: 'blog_posts'}, @page) do %>
	<%= duplicable_editable_field(:ul, {group: 'blog_posts', duplications: 2}, @page) do %>
	<%= duplicable_editable_field(:ul, {group: 'blog_posts', child_tag: 'li', duplications: 2}, @page) do %>

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
