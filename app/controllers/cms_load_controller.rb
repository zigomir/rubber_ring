class CmsLoadController < ApplicationController
  before_action :load_page_content
  before_filter :cache?

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
