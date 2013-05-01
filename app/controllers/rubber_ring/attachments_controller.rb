module RubberRing
  class AttachmentsController < ActionController::Base
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

    def save_attachment
      page = Util.save_page_content(params)
      expire_page(params[:page_path])
      render :json => { controller: page.controller, action: page.action, content: page.content }
    end

    def add
      name = params[:file].original_filename
      temp_dir = 'public/upload/temp'
      Util.save_file_to_fs(temp_dir, name, params[:file].read)

      uploaded_file_path = File.join(temp_dir, name)
      dir_config = Util.get_attachment_directories(params)
      # check if we have image or another type of attachemnt
      if FastImage.type(uploaded_file_path).nil?
        Util.move_file(uploaded_file_path, dir_config.att_dir)
        render :json => { src: File.join(dir_config.att_src_dir, name), type: 'file' }
      else
        Util.move_file(uploaded_file_path, dir_config.img_dir)
        render :json => { src: File.join(dir_config.img_src_dir, name), type: 'image' }
      end
    end

    def remove
      unless params[:src_to_remove].blank?
        file_to_remove = "public/#{params[:src_to_remove]}"
        FileUtils.rm(file_to_remove)
      end

      render :json => { src: params[:src_to_remove] }
    end

  end
end
