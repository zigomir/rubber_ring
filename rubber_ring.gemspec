$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'rubber_ring/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'rubber_ring'
  s.version     = RubberRing::VERSION
  s.authors     = ['Žiga Vidic']
  s.email       = ['zigomir@gmail.com']
  s.homepage    = 'https://github.com/zigomir/rubber_ring' # TODO
  s.summary     = 'Rubber Ring - easy and limited CMS'
  s.description = 'Rubber Ring helps your customers edit their web sites. It helps developers to quickly build new ones.'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*', 'spec/**/*']

  s.add_dependency 'rails', '~> 4.0.0.beta1'
  s.add_dependency 'sass-rails', '~> 4.0.0.beta1'
  s.add_dependency 'coffee-rails', '~> 4.0.0.beta1'

  s.add_dependency 'pg'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'actionpack-page_caching'

  s.add_development_dependency 'rspec-rails'
end