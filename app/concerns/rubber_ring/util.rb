module RubberRing
  module Util
    Struct.new('AttachmentsDir', :img_src_dir, :att_src_dir, :img_dir, :att_dir)

    def Util.save_page_content(params)
      options = get_options_from_params(params)
      Page.save_or_update(options)
    end

    def Util.get_attachment_directories(params)
      controller  = params[:page_controller] || params[:controller]
      action      = params[:page_action]     || params[:action]
      img_src_dir = "upload/#{controller}/#{action}/images"
      att_src_dir = "upload/#{controller}/#{action}/attachments"

      return Struct::AttachmentsDir.new(
        img_src_dir,
        att_src_dir,
        "public/#{img_src_dir}",
        "public/#{att_src_dir}"
      )
    end

    def Util.load_attachments_page(params)
      images = []
      attachments = []
      dir_config = get_attachment_directories(params)
      dirs_to_crawl = [dir_config.img_dir, dir_config.att_dir]

      dirs_to_crawl.each do |dir|
        if File.directory?(dir)
          Dir.foreach(dir) do |file|
            next if file == '.' or file == '..'

            if dir == dir_config.img_dir
              images << File.join(dir_config.img_src_dir, file)
            else
              attachments << File.join(dir_config.att_src_dir, file)
            end
          end
        end
      end

      return images, attachments
    end

    def Util.get_options_from_params(params)
      {
        controller: params[:page_controller],
        action:     params[:page_action],
        locale:     params[:page_locale] || I18n.default_locale.to_s,
        content:    params[:content]
      }
    end

    def Util.save_file_to_fs(dir, name, file)
      unless File.directory?(dir)
        FileUtils.mkdir_p(dir)
      end

      File.open(File.join(dir, name), 'wb') { |f| f.write(file) }
    end

    def Util.move_file(source, destination)
      unless File.directory?(destination)
        FileUtils.mkdir_p(destination)
      end

      FileUtils.mv(source, destination)
    end

  end
end
