class CmsLoadController < ApplicationController
  before_action :load_page_content

  def load_page_content
    page = Page.where(controller: params[:controller],
                          action: params[:action])

    @content = page.first.content unless page.empty?
  end

end
