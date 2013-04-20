# Rubber Ring

This project rocks and uses MIT-LICENSE.

* Ruby version: `2.0.0-p0`
* DB: postgres 9.1 with `hstore`
* to install `hstore` on `Ubuntu` run `sudo apt-get install postgresql-contrib`

## Install

Create new rails project and add this to `Gemfile` and run `bundle`

	gem 'rubber_ring', path: '../gems/rubber_ring' # TODO change this line after publishing gem

Create/migrate database

    sudo -u postgres psql your_db_dev -c 'create extension hstore;'
    rake rubber_ring:install:migrations
    rake db:migrate

Add this route to your `routes.rb`

    mount RubberRing::Engine => '/rubber_ring', :as => 'rubber_ring'

Update `development.rb` and `production.rb` files with this two lines

	config.action_controller.perform_caching = true
  	config.action_controller.page_cache_directory = "#{Rails.root.to_s}/public/build"

Set admin password with creating `app/config/initializers/rubber_ring.rb` file and set it like this

	RubberRing.admin_password = 'secret'

This will enable you to output your pages to plain old `HTML` files that can be later on uploaded to plain web server for serving them.

## Usage

### Developers

Rails generator for new pages

    rails g rubber_ring:page home index edit

### Rubber Ring helpers

CMS fields are made of tag, key and `@page` which holds content for all the page keys. `class`, and `id` are optional

	<%= editable_field(:h1, {key: 'header'}, @page) do %>
	  Welcome to Rubber Ring - CMS that doesn't make you think about it.
	<% end %>

	<%= editable_image({key: 'header_image', src: '/assets/baws.jpg'}, @page) %>

	<%= editable_field(:div, {key: 'first_content', class: 'multi-line'}, @page) do %>
	  Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut
	<% end %>

	<%= duplicable_editable_field(:ul, {group: 'blog_posts'}, @page) do %>
	<%= duplicable_editable_field(:ul, {group: 'blog_posts', duplications: 2}, @page) do %>
	<%= duplicable_editable_field(:ul, {group: 'blog_posts', child_tag: 'li', duplications: 2}, @page) do %>

### Customers - content editing

Login on URL `/rubber_ring` with password which was set by developer in the install stage.

Editing content is easy as clicking inside green boxes and start editing. Some fields can be duplicated with a middle mouse click. Developer decides what can be duplicable/repeatable and what not.

For changing images just click on `Image manager` in the upper menu. Drop the image you need to drop zone. After uploading the image you can drag and drop it on the image you wanted to change.

## Philosophy

* you can not build robust system without limitations
* system may stretch only to certain point until it breaks. Like a rubber ring!

## Deploy site to production

`Preview and prepare` => cache to `public/build`

`Publish` => `rsync` or `capistrano` to staging server server

## Benefits

- optimized for developers and quick setup
- simple to use for customers. True WSYIWYG.
- customer doesn't need application server and/or database. Only plain web server for static HTML serving.

## Future ideas

- service where user page (html + assets) (before must add right attributes to elements she wants to be editable) and than she can start editing her page right away (use grammar for parsing html or at leas really good library)

## Similar CMS

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
