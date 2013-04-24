module RubberRing
  module Generators
    class PageGenerator < Rails::Generators::NamedBase
      include Rails::Generators::ResourceHelpers

      source_root File.expand_path('../templates', __FILE__)
      argument :actions, :type => :array, :default => []

      def generate_controller
        template 'controller.rb', "app/controllers/#{page_name}_controller.rb"
      end

      def generate_view
        actions.reverse.each do |action|
          copy_file 'action.html.erb', "app/views/#{page_name}/#{action}.html.erb"
        end
      end

      def add_routes
        actions.reverse.each do |action|
          route %{get '#{page_name}/#{action}'}
        end
      end

    private

      def page_name
        class_name.underscore
      end
    end
  end
end
