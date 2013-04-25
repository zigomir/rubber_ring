module RubberRing
  module Util
    def Util.save_page_content(params)
      options = get_options_from_params(params)
      Page.save_or_update(options)
    end

    def Util.get_image_directories(params)
      controller = params[:page_controller] || params[:controller]
      action     = params[:page_action]     || params[:action]
      src_dir    = "images/upload/#{controller}/#{action}"
      dir        = "public/#{src_dir}"
      return dir, src_dir
    end

    def Util.load_images_for_page(params)
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

    def Util.get_options_from_params(params)
      {
        controller: params[:page_controller],
        action:     params[:page_action],
        content:    params[:content]
      }
    end
  end
end
