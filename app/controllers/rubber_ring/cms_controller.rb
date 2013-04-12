class RubberRing::CmsController < ApplicationController
  before_action :load_page_content
  before_filter :cache?

  def load_page_content
    page = Page.where(controller: params[:controller],
                      action:     params[:action])

    unless page.empty?
      @content = page.first.content
      @content[:duplications] = 1
    end
  end

  def save
    options = {
      controller: params[:page_controller],
      action:     params[:page_action],
      duplicable: params[:duplicable],
      key:        params[:key],
      value:      params[:value]
    }

    page = Page.save_or_update(options)
    expire_page(controller: '/' + params[:page_controller], action: params[:page_action])

    render :json => { controller: page.controller, action: page.action, content: page.content }
  end

  private

  def cache?
    if params[:cache] == '1'
      @page_caching = true
      system("#{Rails.root.to_s}/build.sh")
    end
  end

end
