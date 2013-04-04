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

CMS fields are made of key and data type
class, and id are optional

<%= editable_field(:p, {key: 'key', type: 'text', class: 'class', id: 'id'}, @content) do %>
  Here is my editable content
<% end %>


# TODOs
- somehow try to disable key duplication
- when admin wants tu publish new changes he clicks "Publish" and this will cache page as static HTML to public folder
