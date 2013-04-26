module RubberRing
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def generate_publish_yaml
        copy_file 'publish_template.yml', 'config/publish.yml'
      end

      def generate_password_file
        copy_file 'settings_template.rb', 'config/initializers/rubber_ring.rb'
      end
    end
  end
end
