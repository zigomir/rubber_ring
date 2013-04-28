## Features
- release gem
	- recreate site before release of gem
	- use [semantic versioning](http://semver.org/)
- duplicable order change with drag and drop
- screen cast tutorial
- minify assets with grunt or sprockets from build script

## Documentation
- document and revise documentation regularly
- maybe use [YARD](http://yardoc.org/) for documenting code

## Development
- Multiple duplicables (page2) - DONE, only these issues for now:
	- order is different on reload (because of _id's)
- maybe ditch hstore so that all databases could be used?
	- if sqlite3 can be used, I should write Rails Girls guide too
- move vendor assets to vendor directory [link](http://prioritized.net/blog/gemify-assets-for-rails/)
- add JavaScript tests

## Future / neat features
- publish on specific time [cool lib for timepicking](http://amsul.ca/pickadate.js)
- use shadow dom for encapsulating application menu [link](http://www.html5rocks.com/en/tutorials/webcomponents/shadowdom/)
- much better GUI design
