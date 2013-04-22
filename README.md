# Rubber Ring

This project rocks and uses MIT-LICENSE.

* Ruby version: `2.0.0-p0`
* DB: postgres 9.1 with `hstore`
* imagemagick

To install `hstore` and `imagemagick` on `Ubuntu`
	
	sudo apt-get install postgresql-contrib
	sudo apt-get install imagemagick

# Install

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

# Usage
## Developers

Rails generator for new pages

    rails generate rubber_ring:page home action1 action2

This will create files and new routes to `routes.rb` file

    create  app/controllers/home_controller.rb
    create  app/views/home/action1.html.erb
    create  app/views/home/action2.html.erb
    route  get 'home/action1'
    route  get 'home/action2'

### Rubber Ring helpers

CMS fields are made of tag, key and `@page` which holds content for all the page keys.

Example

	<%= editable_image({key: 'header_image', src: '/assets/baws.jpg', height: '360'}, @page) %>

	<%= editable_field(:h1, {key: 'header'}, @page) do %>
	  Welcome to Rubber Ring - CMS that doesn't make you think about it.
	<% end %>

	<%= editable_field(:div, {key: 'first_content', class: 'multi-line'}, @page) do %>
	  Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut
	<% end %>

	<%= duplicable_editable_field(:ul, {group: 'blog_posts', child_tag: 'li', class: 'multi-line'}, @page) do %>
	  i am so alone, no one is wrapping me
	  <h3>i'm hanging with h3, i'm more important and cooler than you are</h3>
	  <span>i'm wrapped in a span element</span>
	<% end %>

### Helper options

Each helper need's to specify unique `key`. These are holding values in the database. Also each helper needs to include `@page` object as their last parameter. This object holds all the page's editable content in a hash data structure.

Already used keys which you must **not** use:

- `page_title`

#### helper arguments for all the fields
- `key` unique key to hold the value
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
	- `group` is used to specify group's key prefix. Example: `grup: blog_posts` will produce keys `blog_posts_1`, `blog_posts_2`, `blog_posts_3`, ... based on how many duplication user will do with middle clicking on duplicable field.
	- `child_tag` will set child element tag for `duplicable_editable_field`

### Assets (stylesheets and javascripts)

You can use Sprockets include assets to your app. `app/assets/javascripts/application.js` and `app/assets/stylesheets/application.css` are already included. Please remove `//= require jquery` and `//= require jquery_ujs` from `application.js` because `rubber ring` is already including `jquery` which you can reuse in your pages as well.

#### jQuery

`jQuery` is the one exception. It must not be included in your `application.js` file through Sprockets `require` command. For now, `jQuery` is included by default, right before your other `javascript` files.

## Customers - content editing

Login on URL `/rubber_ring` with password which was set by developer in the install stage.

Editing content is easy as clicking inside green boxes and start editing. Some fields can be duplicated with a double mouse click and removed with middle mouse click. Developer decides what can be duplicable/repeatable and what not.

For changing images just click on `Image manager` in the upper menu. Drop the image you need to drop zone. After uploading the image you can drag and drop it on the image you wanted to change. Image will be automatically resized to the size developer set for it.

## Build site

`Preview and prepare for publish!` option in the menu will output entire page to `public/build` directory. If you do this for every page you should be able to just upload entire `public/build` directory to your production server and use it.

## So this is OK for static HTML sites, what about dynamic ones?
You can of course integrate Rubber Ring your Rails application as well and use it only for site content editing. This only means that you won't need to click `Preview and prepare for publish!`.

## Philosophy

* you can not build robust system without limitations
* system may stretch only to certain point until it breaks. Like a rubber ring!

## Benefits

- optimized for developers and quick setup
- simple to use for customers. True WSYIWYG.
- customer doesn't need application server and/or database. Only plain web server for static HTML serving.

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
