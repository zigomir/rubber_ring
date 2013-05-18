# Rubber Ring - simple content editable CMS
[![Code Climate](https://codeclimate.com/github/zigomir/rubber_ring.png)](https://codeclimate.com/github/zigomir/rubber_ring)

## About

This CMS helps you build editable pages fast. You define which content 
(`text`, `image`, `attachment`, ...) should be editable for your users. 
Limitation, that only developer sets what page parts are editable is good for 
keeping the design intact. It is basically backend for saving `contenteditable` content.
When done editing, only static assets will be published to production server 
where you only need a web server like Apache or Nginx.

Named by The Smiths [song](http://www.youtube.com/watch?v=Cpf6gJU3520).

## Benefits over other content editable CMSes

- optimized for developers and quick setup
- simple to use for customers. They should not be able to break design (a lot)
- customer doesn't need application server and/or database. Only plain web server for static HTML serving will do

### This CMS is not good for
sites, where **editor** wants to create new pages and control each part of every page, 
change fonts and text style

## Software prerequisites

* Ruby `2.0.0-p0`
* Rails `4.0.0.rc1`
* imagemagick

### Browser support

Firefox and Chrome. IE drag and drop doesn't work for now.

## Setup

### Dependencies
To install `imagemagick` and `sqlite3` on `Ubuntu`
	
	sudo apt-get install imagemagick
	sudo apt-get install libsqlite3-dev

### Setting up new Rails project

Add it to your `Gemfile`

	gem 'rubber_ring', :git => 'git://github.com/zigomir/rubber_ring.git'

Create/migrate database

    rake rubber_ring:install:migrations
    rake db:migrate

Update `development.rb` to enable caching

	config.action_controller.perform_caching = true

Remove `//= require jquery` and `//= require jquery_ujs` from `application.js` because 
Rubber Ring is already including jQuery for you.

### Setup config files

Generate initialize settings file for admin and settings for publishing pages 
on production server

	rails generate rubber_ring:install

This will generate

	1. app/config/publish.yml
	2. app/config/initializers/rubber_ring.rb
	3. app/views/layouts/rubber_ring/layout.html.erb
	4. app/assets/javascripts/application.js
	5. public/.htaccess

1. Set your production server name and path. You will need SSH access and your public key 
on server. If you tend to use Rubber Ring as part of web application you can ignore this 
file.
2. Set admin password and application type in `app/config/initializers/rubber_ring.rb`.
3. `app/views/layouts/rubber_ring/layout.html.erb` is here for you to override it, 
so you have complete control over your markup.
4. This is copied because default Rails `application.js` includes `jquery` which is 
already included for you by Rubber Ring (avoiding clashes).
5. Apaches access config. Including rules so you can access all published pages. It will 
look for `.html` files first and enter sub directories later. Example: we have page with 
route `/en` and `/en/example`. When published, `en.html` and `en/example.html` will be 
generated and synced with production server. To serve them both we need this `.htaccess` file.

### Static pages or Rails application?

* If you only want to use Rubber Ring to generate static pages, leave
`RubberRing.static_only = true` intact. This will leave you with options to 
`preview` and `publish` html pages and other assets to production server. Otherwise set 
this option to false.

# Usage

## As an editor I want to easily edit content on my site

Login (`/rubber_ring`) with password which was set by developer in the install stage.

Editing content is easy as clicking inside green boxes and start editing. 
Developer sets what content is editable/repeatable/link/multi line...

For changing images click on `Image manager` in the upper menu. 
Drag and drop the image you need to drop zone. After uploading the image you can drag 
and drop it on the image you wanted to change. Image will be automatically resized 
to the size that was set by developer/designer.

### Build and publish your pages

`Preview` option in the menu will output entire page to `public/build` directory. `Publish` will upload current page to your production server, set in `publish.yml` file.

## As a developer I want to quickly setup editable pages

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
	
	<%= editable_link({class: 'rubber_ring_attachment', key: 'attachment-link', href: '/link-to-something'}, @page) do %>
    	Link to PDF
	<% end %>

	<%= editable_image({key: 'header_image', src: image_path('baws.jpg'), height: '360'}, @page) %>
	
	<% repeat_template('article', @page) %>

## Repeat template

Allows you to set up repeating templates. Example

	<% repeat_template('article', @page) %>
	
This means, that you need to create new view in `app/views/templates/_article.html.erb` 
where **templates** and **article** are important as directory and file name. 
Convention is that the first parameter to the helper needs to be the same as view 
name without underscore.

**Inside repeat templates** you can use all other helpers. **BUT**, you need to 
assemble your key correctly or otherwise you will be overwriting your own content. 
You can use `key_prefix`, which is assembled from index and parent key, like this:

	<%= editable_field(:p, {key: "#{key_prefix}_paragraph", class: "multi-line"}, @page) do %>
		Template content
    <% end %>

### Helper options

Each helper need's to specify unique `key`. These are holding values in the database. 
Also each helper needs to include `@page` object as their last parameter. 
This object holds all the editable content of the page in a hash data structure.

#### already used keys which you must not use

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
- `editable_link`
	- `href` specifies link to page / file
	- if you set or add a class called `rubber_ring_attachment` to `editable_link` you can drop new attachments to it

### Assets (stylesheets and javascripts)

You can use, like in any other Rails application, 
[sprockets directives](https://github.com/sstephenson/sprockets#the-directive-processor) 
to include assets to your app. 
Please remove `//= require jquery` and `//= require jquery_ujs` from `application.js`
because rubber ring is already including `jquery` which you can reuse in your 
pages as well.

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
