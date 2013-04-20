## Features
- middle click on Mac
- set page title through app menu
- GOOD DEMO! (Sprüngli)
- images resize with imagemagick
	- resize image while dropping / read the size from img width/height attributes
- publish build to server (use maybe rysinc or capistrano?)
- release gem
	- use [semantic versioning](http://semver.org/)
- duplicable order change with drag and drop
- nice tutorial (game like)

## Document
- cms helpers
	- `multi-line` class
	- `group` and `child_tag` for `duplicable_editable_field`

## Development
- better and more consistent naming conventions
- integration tests with phantom js driver
- Write (JavaScript) tests!
- minify assets with grunt from build script

## Future
- use shadow dom for encapsulating application menu [link](http://www.html5rocks.com/en/tutorials/webcomponents/shadowdom/)
- service where user page (html + assets) (before must add right attributes to elements she wants to be editable) and than she can start editing her page right away (use grammar for parsing html or at least really good library - check https://github.com/flavorjones/loofah)
