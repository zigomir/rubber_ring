$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'rubber_ring/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'rubber_ring'
  s.version     = RubberRing::VERSION
  s.authors     = ['Ziga Vidic']
  s.email       = ['zigomir@gmail.com']
  s.homepage    = 'https://github.com/zigomir/rubber_ring'
  s.summary     = 'Rubber Ring - easy and limited CMS'
  s.description = 'Rubber Ring helps developers to quickly build new sites and customers to easily edit them.'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*', 'spec/**/*']

  s.required_ruby_version = '~> 2.0.0'

  s.add_dependency 'rails', '~> 4.0.0.rc1'
  s.add_dependency 'sass-rails', '~> 4.0.0.rc1'
  s.add_dependency 'coffee-rails', '~> 4.0.0.rc1'

  s.add_dependency 'jquery-rails'
  s.add_dependency 'actionpack-page_caching'
  s.add_dependency 'image_sorcery'
  s.add_dependency 'fastimage'
  s.add_dependency 'rr_publish'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'spork'
  s.add_development_dependency 'uglifier'
  s.add_development_dependency 'debugger-pry'
end
