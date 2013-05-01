require 'jquery-rails'
require 'actionpack/page_caching'
require 'image_sorcery'
require 'fastimage'
require 'rr_publish'

module RubberRing
  class Engine < ::Rails::Engine
    isolate_namespace RubberRing
  end
end
