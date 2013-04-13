class RubberRing::CmsController < ApplicationController
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
    expire_page(controller: '/' + params[:page_controller], action: params[:page_action])

    render :json => { controller: page.controller, action: page.action, content: page.content }
  end

  def remove
    options = get_options_from_params(params)
    key_to_remove = options[:content].keys[0]

    page = Page.remove(options, key_to_remove)
    expire_page(controller: '/' + params[:page_controller], action: params[:page_action])

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
    src_dir = "images/upload/#{params[:controller]}/#{params[:action]}"
    dir = "public/#{src_dir}"
    return dir, src_dir
  end

  def cache?
    if params[:cache] == '1'
      @page_caching = true
      system("#{Rails.root.to_s}/build.sh")
    end
  end

end
