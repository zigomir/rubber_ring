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

      def add_engine_mount_route
        route "mount RubberRing::Engine => '/rubber_ring', :as => 'rubber_ring'"
      end

      def set_page_cache_directory
        application('config.action_controller.page_cache_directory = "#{Rails.root.to_s}/public/build"')
      end
    end
  end
end
