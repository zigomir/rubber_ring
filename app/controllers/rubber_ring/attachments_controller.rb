module RubberRing
  class AttachmentsController < ActionController::Base
    include Util

    def save_image
      page = Util.save_page_content(params)
      width, height = params[:width], params[:height]

      unless width.nil? and height.nil?
        key  = params[:content].keys.first
        path = "public/#{page.content[key]}"
        convert_image(path, width, height) if File.exist?(path)
      end

      expire_page_and_render(page)
    end

    def convert_image(path, width, height)
      image = ImageSorcery.new(path)
      image.convert(path, quality: 90, resize: "#{width}x#{height}>")
    end

    def save_attachment
      page = Util.save_page_content(params)
      expire_page_and_render(page)
    end

    def expire_page_and_render(page)
      expire_page(params[:page_path])
      render :json => { controller: page.controller, action: page.action, content: page.content }
    end

    def add
      name = params[:file].original_filename
      temp_dir = 'public/upload/temp'
      Util.save_file_to_fs(temp_dir, name, params[:file].read)

      uploaded_file_path = File.join(temp_dir, name)
      dir_config = Util.get_attachment_directories(params)

      type = FastImage.type(uploaded_file_path).nil? ? 'file' : 'image'
      dir, src_dir = "#{type}_dir", "#{type}_src_dir"
      Util.move_file(uploaded_file_path, dir_config[dir])

      render :json => { src: '/' + File.join(dir_config[src_dir], name), type: type }
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
