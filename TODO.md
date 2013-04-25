## Features
- release gem and open source the project - after at least one successfully tested project with it (probably DASO for Astina)
	- use [semantic versioning](http://semver.org/)
- duplicable order change with drag and drop
- screen cast tutorial
- minify assets with grunt or sprockets from build script

## Known issues
- middle click on Mac
- sometimes publish won't get cached html ... maybe because of threading -> investigate

## Documentation
- document and revise documentation regularly
- use [YARD](http://yardoc.org/) for documenting code

## Development
- better and more consistent naming conventions
- maybe ditch hstore so that all databases could be used?
	- if sqlite3 can be used, I should write Rails Girls guide too
- move vendor assets to vendor directory [link](http://prioritized.net/blog/gemify-assets-for-rails/)
- add JavaScript tests

## Future / neat features
- publish on specific time [cool lib for timepicking](http://amsul.ca/pickadate.js)
- use shadow dom for encapsulating application menu [link](http://www.html5rocks.com/en/tutorials/webcomponents/shadowdom/)
- service where user page (html + assets) (before must add right attributes to elements she wants to be editable) and than she can start editing her page right away (use grammar for parsing html or at least really good library - check https://github.com/flavorjones/loofah)
