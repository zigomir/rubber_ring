# TODO
- install generator should also copy `views/layout/rubber_ring/- application.html.erb` to host application so it can be customized


- editable_field helper with first parameter = null should not be wrapped in a tag
- don't save attachments whole url with host and stuff. will break the production!


- create demo with tutorial (doing Spruengli site)
- release gem
	- recreate site before release of gem
	- use [semantic versioning](http://semver.org/)

## Features
- nesting helpers
	- for now it is only safe to nest stuff inside attachment helper!
- minify assets with grunt or sprockets from build script

## Documentation
- document and revise documentation regularly
- maybe use [YARD](http://yardoc.org/) for documenting code

## Development
- test / refactor / refine
- remove unused attachments is buggy (add js tests!)

## Future / neat features
- publish on specific time [cool lib for timepicking](http://amsul.ca/pickadate.js)
- use shadow dom for encapsulating application menu [link](http://www.html5rocks.com/en/tutorials/webcomponents/shadowdom/)
- better GUI design
