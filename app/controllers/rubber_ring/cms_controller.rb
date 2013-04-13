class RubberRing::CmsController < ApplicationController
  before_action :load_page_content
  before_filter :cache?

  def load_page_content
    page = Page.where(controller: params[:controller],
                      action:     params[:action])

    @page = page.first unless page.empty?
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
    name = params[:file].original_filename
    path = File.join('public/images/upload', name)
    File.open(path, 'wb') { |f| f.write(params[:file].read) }

    render :json => { message: 'Image uploaded!' }
  end

  private

  def get_options_from_params(params)
    {
      controller: params[:page_controller],
      action:     params[:page_action],
      content:    params[:content]
    }
  end

  def cache?
    if params[:cache] == '1'
      @page_caching = true
      system("#{Rails.root.to_s}/build.sh")
    end
  end

end
