module RubberRing
  class ImagesController < ActionController::Base
    include Util

    def save_image
      page   = Util.save_page_content(params)
      width  = params[:width] || ''
      height = params[:height] || ''

      unless width == '' and height == ''
        key = params[:content].keys.first
        path = "public/#{page.content[key]}"
        image = ImageSorcery.new(path)
        #http://www.imagemagick.org/script/command-line-processing.php#geometry
        #widthxheight>	Shrinks an image with dimension(s) larger than the corresponding width and/or height argument(s).
        image.convert(path, quality: 90, resize: "#{width}x#{height}>")
      end

      expire_page(params[:page_path])
      render :json => { controller: page.controller, action: page.action, content: page.content }
    end

    def image_add
      dir, src_dir = Util.get_image_directories(params)
      name = params[:file].original_filename
      save_file_to_fs(dir, name)

      render :json => { src: File.join(src_dir, name) }
    end

    def image_remove
      file_to_remove = "public/#{params[:src_to_remove]}"
      FileUtils.rm(file_to_remove)

      render :json => { src: params[:src_to_remove] }
    end

  private

    def save_file_to_fs(dir, name)
      unless File.directory?(dir)
        FileUtils.mkdir_p(dir)
      end

      File.open(File.join(dir, name), 'wb') { |f| f.write(params[:file].read) }
    end
  end
end
