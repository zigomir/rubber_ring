# Rubber Ring - simple content editable CMS

Named by The Smiths [song](http://www.youtube.com/watch?v=Cpf6gJU3520).

## About

This CMS helps you build editable pages fast. You define which content (`image` or `text`) should be editable for your users. Limitation, that only developer sets what page parts are editable is good for keeping the design intact. It is basically backend for simple `contenteditable`. When done editing, only static assets will be published to production server.

## Benefits over other content editable editors

- optimized for developers and quick setup
- simple to use for customers. They should not be able to break design (a lot).
- customer doesn't need application server and/or database. Only plain web server for static HTML serving will do.

### This CMS is not good for
sites, where **editor** wants to create new pages and control each part of every page.

## Used software
*Current software prerequisites; made with*

* Ruby `2.0.0-p0`
* Rails 4.0.0.rc1
* Postgres 9.1 with `hstore`
* imagemagick

## Setup

### Dependencies
To install `hstore` and `imagemagick` on `Ubuntu`
	
	sudo apt-get install postgresql-contrib
	sudo apt-get install imagemagick

### Setting up new Rails project
Create new rails project and add this to `Gemfile` and run `bundle`

	gem 'rubber_ring', :git => 'git://github.com/zigomir/rubber_ring.git'

Create/migrate database

    sudo -u postgres psql your_db_dev -c 'create extension hstore;'
    rake rubber_ring:install:migrations
    rake db:migrate

Add this route to your `routes.rb`

    mount RubberRing::Engine => '/rubber_ring', :as => 'rubber_ring'

Update `development.rb` and `production.rb` files with this two lines

	config.action_controller.perform_caching = true
  	config.action_controller.page_cache_directory = "#{Rails.root.to_s}/public/build"

### Setup config files
Generate initialize settings file for admin and settings for publishing pages on production server

	rails generate rubber_ring:install

This will generate

	app/config/publish.yml
	app/config/initializers/rubber_ring.rb

Set admin password and `app/config/initializers/rubber_ring.rb`

### Static pages or Rails application?

* If you only want to use Rubber Ring to generate static pages, leave `RubberRing.static_only = true` intact. This will leave you with options to `preview` and `publish` html pages and other assets to production server
* If you want to use Rubber Ring to edit content for your Rails application, than just set `RubberRing.static_only` to false
* Set remote production server in `app/config/publish.yml` if you are using `static_only` mode

# Usage

## As an editor I want to easily edit content on my site

Login (`/rubber_ring`) with password which was set by developer in the install stage.

Editing content is easy as clicking inside green boxes and start editing. Developer decides what can be duplicable/repeatable and what not.

For changing images click on `Image manager` in the upper menu. Drag&Drop the image you need to drop zone. After uploading the image you can drag and drop it on the image you wanted to change. Image will be automatically resized to the size that was set by developer or page designer.

### Build and publish your pages

`Preview` option in the menu will output entire page to `public/build` directory. `Publish` will upload current page to your production server, set in `publish.yml` file.

## As a developer I want to have quickly setup editable pages

Rails generator for new pages

    rails generate rubber_ring:page home action1 action2

This will create files and new routes to `routes.rb` file

    create app/controllers/home_controller.rb
    create app/views/home/action1.html.erb
    create app/views/home/action2.html.erb
    route get 'home/action1'
    route get 'home/action2'

### Rubber Ring helpers

CMS fields are made of tag, key and `@page` which holds content for all the page keys/value pairs.

Examples

	<%= editable_field(:h1, {key: 'header'}, @page) do %>
	  I'm editable content in one line.
	<% end %>

	<%= editable_field(:div, {key: 'first_content', class: 'multi-line'}, @page) do %>
	  I'm editable content in 
	  multi lines...
	<% end %>

	<%= duplicable_editable_field(:ul, {group: 'blog_posts', child_tag: 'li', class: 'multi-line'}, @page) do %>
	  I'm text only
	  <h3>I'm hanging with h3, i'm more important and cooler than you are</h3>
	  <span>I'm wrapped in a span element</span>
	<% end %>

	<%= attachment({key: 'software-architecture', href: '/docs/test.pdf'}, @page) do %>
	  <%= editable_field(:span, {key: 'link_title'}, @page) do %>Link to PDF<% end %>
	<% end %>


	<%= editable_image({key: 'header_image', src: '/assets/baws.jpg', height: '360'}, @page) %>


### Helper options

Each helper need's to specify unique `key`. These are holding values in the database. Also each helper needs to include `@page` object as their last parameter. This object holds all the page's editable content in a hash data structure.

#### Already used keys which you must **not** use

- `page_title`

#### helper arguments for all editable fields
- `key` key to hold the value **(must be unique)**
- `class` html class attribute (optional)
	- class value with `multi-line` will enable editing in multi lines
- `id` html id attribute (optional)
- `@page` object for holding page content

#### specific arguments for each field
- `editable_image`
	- `src` image source attribute
	- `width` image width
	- `height` image height
- `editable_field`
	- no specific arguments
- `duplicable_editable_field`
	- `group` is used to specify group's key prefix. Example: `grup: blog_posts` will produce keys `blog_posts_1`, `blog_posts_2`, `blog_posts_3`, ... based on how many duplication user will do **(must be unique)**
	- `child_tag` will set tag for child elements of `duplicable_editable_field`
- `attachment`
	- `href` specifies link to attached file

### Assets (stylesheets and javascripts)

You can use, like in any other new Rails application, [Sprockets directives](https://github.com/sstephenson/sprockets#the-directive-processor) to include assets to your app. Please remove `//= require jquery` and `//= require jquery_ujs` from `application.js` because `rubber ring` is already including `jquery` which you can reuse in your pages as well.

## Philosophy

* user should not be able to break design
* you can not build robust system without limitations
* system may stretch only to certain point until it breaks. Like a rubber ring!

## Inspired by

- [Mercury Editor](http://jejacks0n.github.io/mercury/)
- [Raptor Editor](http://www.raptor-editor.com/)
- [Copybar](https://copybar.io)
- [Perch](http://grabaperch.com/)
- [CopyCopter](http://copycopter.com)
- [SimpleCMS](http://www.simplecms.com)
- [Squarespace](http://www.squarespace.com/)
- [contenteditable editors](http://stackoverflow.com/questions/6756407/what-contenteditable-editors-are-there)

---
This project uses MIT-LICENSE. Copyright 2013 Žiga Vidic