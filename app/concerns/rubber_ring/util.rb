module RubberRing
  module Util
    Struct.new('AttachmentsDir', :image_src_dir, :file_src_dir, :image_dir, :file_dir)

    def Util.save_page_content(params)
      options = get_options_from_params(params)
      Page.save_or_update(options)
    end

    def Util.save_page_templates(params)
      options = get_options_from_params(params)
      Page.save_or_update_templates(options)
    end

    def Util.get_attachment_directories(params)
      controller  = params[:page_controller] || params[:controller]
      action      = params[:page_action]     || params[:action]
      locale      = params[:locale]          || I18n.default_locale.to_s

      image_src_dir = "upload/#{locale}/#{controller}/#{action}/images"
      file_src_dir  = "upload/#{locale}/#{controller}/#{action}/attachments"

      return Struct::AttachmentsDir.new(
        image_src_dir,
        file_src_dir,
        "public/#{image_src_dir}",
        "public/#{file_src_dir}"
      )
    end

    def Util.load_attachments_page(params)
      images = []
      attachments = []
      dir_config = get_attachment_directories(params)
      dirs_to_crawl = [dir_config.image_dir, dir_config.file_dir]

      dirs_to_crawl.each do |dir|
        if File.directory?(dir)
          Dir.foreach(dir) do |file|
            next if file == '.' or file == '..'

            if dir == dir_config.image_dir
              images << File.join(dir_config.image_src_dir, file)
            else
              attachments << File.join(dir_config.file_src_dir, file)
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
