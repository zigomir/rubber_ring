module RubberRing
  class CmsController < ActionController::Base
    layout 'rubber_ring/application'
    before_action :load_page_content
    before_filter :cache?

    def load_page_content
      page = Page.where(controller: params[:controller],
                        action:     params[:action])

      @page = page.first unless page.empty?
      @images = load_images_for_page(params)
    end

    def save
      options = get_options_from_params(params)
      page = Page.save_or_update(options)
      # TODO pass named path
      expire_page("#{main_app.example_page_path}")

      render :json => { controller: page.controller, action: page.action, content: page.content }
    end

    def remove
      options = get_options_from_params(params)
      key_to_remove = params[:key_to_remove]

      page = Page.remove(options, key_to_remove)
      # TODO pass named path
      expire_page("#{main_app.example_page_path}")

      render :json => { controller: page.controller, action: page.action, content: page.content }
    end

    def image_add
      dir, src_dir = get_image_directories(params)
      name = params[:file].original_filename

      unless File.directory?(dir)
        FileUtils.mkdir_p(dir)
      end

      path = File.join(dir, name)
      File.open(path, 'wb') { |f| f.write(params[:file].read) }

      render :json => { src: File.join(src_dir, name) }
    end

    def image_remove
      file_to_remove = "public/#{params[:src_to_remove]}"
      FileUtils.rm(file_to_remove)

      render :json => { src: params[:src_to_remove] }
    end

    private

    def get_options_from_params(params)
      {
        controller: params[:page_controller],
        action:     params[:page_action],
        content:    params[:content]
      }
    end

    def load_images_for_page(params)
      images = []
      dir, src_dir = get_image_directories(params)

      if File.directory?(dir)
        Dir.foreach(dir) do |file|
          next if file == '.' or file == '..'
          images << File.join(src_dir, file)
        end
      end

      images
    end

    def get_image_directories(params)
      controller = params[:page_controller] || params[:controller]
      action     = params[:page_action]     || params[:action]
      src_dir    = "images/upload/#{controller}/#{action}"
      dir        = "public/#{src_dir}"
      return dir, src_dir
    end

    def cache?
      if params[:cache] == '1'
        @page_caching = true
        system("#{Rails.root.to_s}/build.sh")
      end
    end
  end
end
