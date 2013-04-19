require 'jquery-rails'
require 'actionpack/page_caching'

module RubberRing
  class Engine < ::Rails::Engine
    isolate_namespace RubberRing
  end
end
