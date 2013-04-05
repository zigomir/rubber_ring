class CmsController < ApplicationController

  def save
    options = {
      controller: params[:page_controller],
      action:     params[:page_action],
      key:        params[:key],
      value:      params[:value]
    }

    page = Page.save_or_update(options)
    expire_page(controller: params[:page_controller], action: params[:page_action])

    render :json => { controller: page.controller, action: page.action, content: page.content }
  end

end
