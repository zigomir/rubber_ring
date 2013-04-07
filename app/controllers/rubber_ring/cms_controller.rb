class RubberRing::CmsController < ApplicationController
  before_action :load_page_content
  before_filter :cache?

  def save
    options = {
      controller: params[:page_controller],
      action:     params[:page_action],
      key:        params[:key],
      value:      params[:value]
    }

    page = Page.save_or_update(options)
    expire_page(controller: '/' + params[:page_controller], action: params[:page_action])

    render :json => { controller: page.controller, action: page.action, content: page.content }
  end

  def load_page_content
    page = Page.where(controller: params[:controller],
                      action: params[:action])

    @content = page.first.content unless page.empty?
  end

  private

  def cache?
    if params[:cache] == '1'
      @page_caching = true
    end
  end

end
