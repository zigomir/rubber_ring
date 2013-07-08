module RubberRing
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def generate_publish_yaml
        copy_file 'publish_template.yml', 'config/publish.yml'
      end

      def generate_htaccess_file
        copy_file '.htaccess', 'public/.htaccess'
      end

      def generate_password_file
        copy_file 'settings_template.rb', 'config/initializers/rubber_ring.rb'
      end

      def generate_puma_config_file
        copy_file 'puma_template.rb', 'config/puma.rb'
      end

      def copy_application_layout
        copy_file 'layout.html.erb', 'app/views/layouts/rubber_ring/layout.html.erb'
      end

      def override_application_js
        copy_file 'application.js', 'app/assets/javascripts/application.js'
      end

      def add_engine_mount_route
        route "mount RubberRing::Engine => '/rubber_ring', :as => 'rubber_ring'"
      end
    end
  end
end
