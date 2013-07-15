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

* Ruby 2
* Rails 4
* ruby web server running at least 2 processes (puma, unicorn, thin) - I only tested with puma for now
* imagemagick
* wget

## Versions

Use `gem 'rubber_ring', '~> 0.1.2'` if you don't want to run multiple processes. Instead you will need to publish each
change of any page separately.

Use `gem 'rubber_ring', '~> 1.0.0'` if you can have two or more processes of web server. In this version whole site
will be built in one step.

### Browser support

Firefox, Chrome and Safari.

## Setup

### Dependencies
To install `imagemagick` and `sqlite3` on `Ubuntu`

	sudo apt-get install imagemagick
	sudo apt-get install libsqlite3-dev

## Setting up a new project

Add this to your `Gemfile`

	gem 'rubber_ring'

Create and migrate database

    rake rubber_ring:install:migrations
    rake db:create db:migrate

Update `development.rb` to enable build for development mode. This will disable rails to add `body=1` to every asset link.

```ruby
config.assets.debug = false
```

### Generate config files

	rails generate rubber_ring:install

This will generate

	1. app/config/publish.yml
	2. app/config/initializers/rubber_ring.rb
	3. app/views/layouts/rubber_ring/layout.html.erb
	4. app/assets/javascripts/application.js
	5. public/.htaccess
	6. app/puma.rb

1. Set your production server name and path. You will need SSH access and your public key
on server. If you tend to use Rubber Ring as part of web application, or you don't want/need to publish only static HTML files, you can ignore this file.
2. Set admin password and application type in `app/config/initializers/rubber_ring.rb`.
3. `app/views/layouts/rubber_ring/layout.html.erb` is here for you to override it,
so you have complete control over your markup.
4. This is copied because default Rails `application.js` includes `jquery` which is
already included for you by Rubber Ring (avoiding clashes).
5. Apaches access config. Including rules so you can access all published pages. It will
look for `.html` files first and enter sub directories later. Example: we have page with
route `/en` and `/en/example`. When published, `en.html` and `en/example.html` will be
generated and synced with production server. To serve them both we need this `.htaccess` file.
6. We need to run `Rubber Ring` as `Rails Application` with at least two workers. This is
because when doing a request to `/rubber_ring/build` there will also run a `wget` program
which will download all `html` files and save them into `public/build` directory. Without
more workers we need to must use threads, but with threads we can not accurately tell
user when `wget` program finishes its job.

### Run

```bash
puma -p 3000 -C config/puma.rb
```

### Static pages or Rails application?

If you only want to use Rubber Ring to generate static pages, leave
`RubberRing.static_only = true` inside `app/config/initializers/rubber_ring.rb` intact.
This will leave you with options to `preview` and `publish` html pages and other
assets to production server. Otherwise set
this option to false.

# Usage

## As an editor I want to easily edit content on my site

Login at URL `/rubber_ring` with password which was set by developer in the install stage.

Just edit content inside green boxes.
Developer sets what content is editable/repeatable/link/multi line...

For changing images click on `Image manager` in the upper menu.
Drag and drop the image(s) you need to drop zone. After uploading the
image(s) you can drag and drop them on the image you wanted to change.
Image will be automatically re-sized to the size that was set by developer/designer.

### Preview

The easiest way to preview your current work is to log out or even better, open it in
a new browser where you are not logged in.

### Build and publish your pages

`Build & Publish` option in the menu will first output entire page to `public/build` directory. `Publish` will upload/copy whole site to your production server, set in `publish.yml` file.

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

```erb
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
```

## Templates

Allows you to set up repeating and sortable templates. Example

```erb
<% template([
    {template: 'article',   tclass: 'article', element: 'article'},
    {template: 'blog_post', tclass: 'blog',    element: 'div'}
  ],
  {key: 'template_key', wrap_element: 'div', wrap_class: 'templates'}, @page)
%>
```

This means, that you need to create new view for each template in
`app/views/templates/`. Example

    app/views/templates/_article.html.erb

Convention

	...
	{template: 'article', ...
	...

means that you need a view, saved in a file

    app/views/templates/_article.html.erb

**Inside templates** you can use all other helpers. **BUT**, you need to
assemble your key correctly or otherwise you will be overwriting your own content.
You can use `key_prefix`, which is assembled the way which will help you to prevent key overwites. Example:

```erb
<%= editable_field(:h2, {key: "#{key_prefix}_title"}, @page) do %>
	Article Title
<% end %>
```

### Helper options

Each helper needs to specify unique `key`. These are holding values in the database.
Also each helper needs to include `@page` object as their last parameter.
This object holds all the editable content of the page in a hash data structure.

#### reserved key(s) - don't use them

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
Please don't use `//= require jquery` and `//= require jquery-ui`
in your `application.js` file, because rubber ring is already including `jquery`
which you can reuse in your pages as well.

## Philosophy

* user should not be able to break design
* you can not build robust system without limitations
* system may stretch only to certain point until it breaks. Like a rubber ring!

## Inspired by (aka ideas stolen from)

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
